unit RoutinesPackage.Logic;

interface

uses
  Winapi.ActiveX, Data.Win.ADODB, FireDAC.Stan.ASync, FireDAC.Stan.Def, FireDAC.DApt, FireDAC.Comp.Client, RoutinesPackage.Logic.TParamValue, Data.DB, IdSMTP, IdMessage, RoutinesPackage.Logic.IEventLogger;

(* создание и установка значений(aArgs) параметров SQL-запроса(tmpSQL),
  а также самого SQL-запроса в aQuery.
  Метод добавляет к строке aSQL количесво строк ':P?'(где
  ":" - символ обозначающий что это параметр,
  "?" - номер параметра), равное количесву элементов в aArgs,
  далее вставляет эту строку в aQuery и присваивает значения параметров
  aDataSet-а из aArgs *)
procedure SetADOQuery(const aQuery: TADOQuery; aSQL: string; const aArgs: array of Variant; const aOpen: Boolean = True);
function GetADOQuery(const AConnection: TCustomConnection): TADOQuery;
function GetFDQuery(const AConnection: TCustomConnection): TFDQuery;
function GetQuery(const aConnection: TCustomConnection): TDataSet;
function InitializeCOM(const aCoInit: Integer = COINIT_MULTITHREADED + COINIT_SPEED_OVER_MEMORY): IInterface;
function GetEventLogger(const aName: string): IEventLogger;
function SendEMail(const aSMTP: TIdSMTP; const aEMail: TIdMessage; var aLogMessage: string): Boolean;
function Caesar(const aValue: string): string;
function SaveDataSetToFile(const aDataSet: TDataSet; var aFileName: string; const aTitle, aFileFormatExtension: string): Boolean;

/// <summary>
/// Процедура, получающая результирующую выборку на основе текста запроса,
/// переданного указанному объекту запроса
/// </summary>
/// <param name="aQuery">
/// Объект запроса типа <b>TADOQuery</b> или <b>TSQLQuery</b>
/// </param>
/// <param name="aSQL">
/// Текст запроса
/// </param>
/// <param name="aOpen">
/// Необходимо ли выполнить получение результирующей выборки
/// </param>
procedure SetSQLForQuery(const aQuery: TDataSet; const aSQL: string; const aArgs: array of TParamValue; const aOpen: Boolean = True);

/// <summary>
/// Функция объявления начала SQL-транзакции
/// </summary>
function BeginTransaction(const aConnection: TCustomConnection; out tmpInParentTransacton: Boolean): Boolean;

/// <summary>
/// Функция подтверждения SQL-транзакций
/// </summary>
function CommitTransaction(const aConnection: TCustomConnection; const tmpInParentTransacton: Boolean): Boolean;

/// <summary>
/// Функция отмены SQL-транзакций
/// </summary>
function RollBackTransaction(const aConnection: TCustomConnection; const tmpInParentTransacton: Boolean): Boolean;

implementation

uses
  CodeSiteLogging, RoutinesPackage.Logic.TInitializeCOM, RoutinesPackage.Logic.TEventLogger, Vcl.Forms, Vcl.Controls, System.Classes, System.SysUtils,
  System.StrUtils, System.IOUtils, Winapi.Windows, RoutinesPackage.Logic.IDataSetWriter, RoutinesPackage.Logic.TDataSetWriterClass,
  RoutinesPackage.Logic.TCSVDataSetWriter, RoutinesPackage.Logic.TXLSXDataSetWriter, RoutinesPackage.Logic.TTXTDataSetWriter, FireDAC.Stan.Param;

resourcestring
  RsSended = 'Отправлено: [%s <%s>]';

function InitializeCOM(const aCoInit: Integer): IInterface;
begin
  Result := TInitializeCOM.Create(aCoInit);
end;

function GetEventLogger(const aName: string): IEventLogger;
begin
  Result := TEventLogger.Create(aName);
end;

function GetQuery(const aConnection: TCustomConnection): TDataSet;
begin
  Result := nil;

  if not Assigned(aConnection) then
  begin
    Exit;
  end;

  if aConnection is TADOConnection then
  begin
    Result := GetADOQuery(aConnection);
  end;

  if aConnection is TFDConnection then
  begin
    Result := GetFDQuery(aConnection);
  end;
end;

procedure SetADOQuery(const aQuery: TADOQuery; aSQL: string; const aArgs: array of Variant; const aOpen: Boolean);
var
  i, iParams: Integer;
  tmpSQL: string;
  tmpParameters: array of Variant;
  tmpCursor: TCursor;
begin
  tmpCursor := Screen.Cursor;

  iParams := aSQL.IndexOf(':');
  tmpParameters := nil;
  if iParams > 0 then
  begin
    SetLength(tmpParameters, aQuery.Parameters.Count);
    for i := 0 to Pred(aQuery.Parameters.Count) do
    begin
      tmpParameters[i] := aQuery.Parameters.Items[i].Value;
    end;
  end;

  aQuery.SQL.Clear();
  aQuery.Close();
  tmpSQL := aSQL;

  for i := 0 to high(aArgs) do
  begin
    if (i = 0) and (iParams <= 0) then
    begin
      tmpSQL := Format('%s :P%d', [tmpSQL, i]);
    end
    else
    begin
      tmpSQL := Format('%s, :P%d', [tmpSQL, i]);
    end;
  end;

  aQuery.SQL.Append(tmpSQL);

  if iParams > 0 then
  begin
    for i := 0 to high(tmpParameters) do
    begin
      aQuery.Parameters.Items[i].Value := tmpParameters[i];
    end;

    for i := 0 to high(aArgs) do
    begin
      aQuery.Parameters.Items[(Succ(high(tmpParameters))) + i].Value := aArgs[i];
    end;
  end
  else
  begin
    for i := 0 to high(aArgs) do
    begin
      aQuery.Parameters.Items[i].Value := aArgs[i];
    end;
  end;

  try
    Screen.Cursor := crSQLWait;
    if aOpen then
    begin
      aQuery.Open();
    end
    else
    begin
      aQuery.ExecSQL();
    end;
  finally
    Screen.Cursor := tmpCursor;
  end;
end;

function GetFDQuery(const AConnection: TCustomConnection): TFDQuery;
begin
  Result := nil;

  if not Assigned(AConnection) then
  begin
    Exit;
  end;

  if not(AConnection is TFDConnection) then
  begin
    Exit;
  end;

  Result := TFDQuery.Create(nil);
  if not Assigned(Result) then
  begin
    Exit;
  end;

  Result.Connection := AConnection as TFDConnection;

end;

function GetADOQuery(const AConnection: TCustomConnection): TADOQuery;
begin
  Result := nil;

  if not Assigned(AConnection) then
  begin
    Exit;
  end;

  if not(AConnection is TADOConnection) then
  begin
    Exit;
  end;

  Result := TADOQuery.Create(nil);

  if not Assigned(Result) then
  begin
    Exit;
  end;

  Result.Connection := AConnection as TADOConnection;
  Result.CommandTimeout := Result.Connection.CommandTimeout;
  Result.LockType := ltReadOnly;
  Result.CursorType := ctOpenForwardOnly;
  Result.DisableControls();
end;

function SendEMail(const aSMTP: TIdSMTP; const aEMail: TIdMessage; var aLogMessage: string): Boolean;
begin;
  Result := False;

  try
    if aSMTP.Connected() then
    begin
      aSMTP.Disconnect();
    end;

    aSMTP.Connect();
    try
      aSMTP.Send(aEMail);
      aLogMessage := Format(RsSended, [aEMail.Subject, aEMail.Recipients.EMailAddresses]);
      Result := True;
    finally
      aSMTP.Disconnect();
    end;
  except
    on e: Exception do
    begin
      aLogMessage := e.ToString();
    end;
  end;
end;

function Caesar(const aValue: string): string;
var
  i: Integer;
begin
  Result := aValue;
  for i := 1 to Length(Result) do
  begin
    Result[i] := Pred(Result[i]);
  end;
end;

function SaveDataSetToFile(const aDataSet: TDataSet; var aFileName: string; const aTitle, aFileFormatExtension: string): Boolean;
var
  tmpWriter: IDataSetWriter;
  s: string;
begin
  Result := False;

  s := Format('T%sDataSetWriter', [aFileFormatExtension.Trim().ToUpper()]);
  try
    if not Supports((TDataSetWriterClass(GetClass(s))).Create(aDataSet, aFileName, aTitle), IDataSetWriter, tmpWriter) then
    begin
      Exit;
    end;
  except
    CodeSite.SendDateTime(csmError, Format('Класс ''%s'' для обработки расширения ''%s'' не найден', [s, aFileFormatExtension]), Now());
    Exit;
  end;

  if not tmpWriter.Save() then
  begin
    Exit;
  end;

  aFileName := tmpWriter.DestinationFileName;

  Result := True;
end;

function BeginTransaction(const aConnection: TCustomConnection; out tmpInParentTransacton: Boolean): Boolean;
begin
  Result := False;

  if not Assigned(aConnection) then
  begin
    Exit;
  end;

  if aConnection is TADOConnection then
  begin
    tmpInParentTransacton := (aConnection as TADOConnection).InTransaction;

    if tmpInParentTransacton then
    begin
      Exit(True);
    end;

    Result := (aConnection as TADOConnection).BeginTrans() > 0;
  end;

  if aConnection is TFDConnection then
  begin
    tmpInParentTransacton := (aConnection as TFDConnection).InTransaction;

    if tmpInParentTransacton then
    begin
      Exit(True);
    end;

    (aConnection as TFDConnection).StartTransaction();
    Result := True;
  end;
end;

function CommitTransaction(const aConnection: TCustomConnection; const tmpInParentTransacton: Boolean): Boolean;
begin
  Result := False;

  if not Assigned(aConnection) then
  begin
    Exit;
  end;

  if tmpInParentTransacton then
  begin
    Exit;
  end;

  if aConnection is TADOConnection then
  begin
    (aConnection as TADOConnection).CommitTrans();
    Result := True;
  end;

  if aConnection is TFDConnection then
  begin
    (aConnection as TFDConnection).Commit();
    Result := True;
  end;
end;

function RollBackTransaction(const aConnection: TCustomConnection; const tmpInParentTransacton: Boolean): Boolean;
begin
  Result := False;

  if not Assigned(aConnection) then
  begin
    Exit;
  end;

  if tmpInParentTransacton then
  begin
    Exit;
  end;

  if aConnection is TADOConnection then
  begin
    (aConnection as TADOConnection).RollbackTrans();
    Result := True;
  end;

  if aConnection is TFDConnection then
  begin
    (aConnection as TFDConnection).Rollback();
    Result := True;
  end;
end;

procedure SetSQLForQuery(const aQuery: TDataSet; const aSQL: string; const aArgs: array of TParamValue; const aOpen: Boolean);
var
  i: Integer;
  tmpSQL: string;
begin
  if not Assigned(aQuery) then
  begin
    Exit;
  end;

  tmpSQL := aSQL;
  for i := 0 to Pred(Length(aArgs)) do
  begin
    tmpSQL := Format('%s%s', [tmpSQL, Format('%s:P%d', [IfThen(i > 0, ', ', ' '), i])]);
  end;

  if aQuery is TADOQuery then
  begin
    (aQuery as TADOQuery).SQL.Clear();
    (aQuery as TADOQuery).SQL.Append(tmpSQL);
    for i := low(aArgs) to high(aArgs) do
    begin
      (aQuery as TADOQuery).Parameters.Items[i].DataType := aArgs[i].ValueType;
      (aQuery as TADOQuery).Parameters.Items[i].Value := aArgs[i].Value;
    end;
    if not aOpen then
    begin
      (aQuery as TADOQuery).ExecSQL();
    end;
  end;

  if aQuery is TFDQuery then
  begin
    (aQuery as TFDQuery).SQL.Clear();
    (aQuery as TFDQuery).SQL.Append(tmpSQL);
    for i := low(aArgs) to high(aArgs) do
    begin
      (aQuery as TFDQuery).Params.Items[i].DataType := aArgs[i].ValueType;
      (aQuery as TFDQuery).Params.Items[i].Value := aArgs[i].Value;
    end;
    if not aOpen then
    begin
      (aQuery as TFDQuery).ExecSQL();
    end;
  end;

  if aOpen then
  begin
    aQuery.Open();
  end;
end;

initialization

RegisterClasses([TCSVDataSetWriter, TTXTDataSetWriter, TXLSXDataSetWriter]);

end.
