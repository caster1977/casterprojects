unit uCommonRoutines;

interface

uses
  Controls,
  StdCtrls,
  SysUtils,
  DB,
  ADODB,
  SQLExpr,
  uTArchiveDocumentItemClass,
  uIArchiveDocumentItem,
  uTArchiveDocumentItem,
  uTArchiveDocumentListClass,
  uIArchiveDocumentList,
  uTArchiveDocumentList;

/// <summary>
/// Процедура, получающая результирующую выборку на основе текста запроса,
/// переданного указанному объекту запроса
/// </summary>
/// <param name="AQuery">
/// Объект запроса типа <b>TADOQuery</b> или <b>TSQLQuery</b>
/// </param>
/// <param name="ASQL">
/// Текст запроса
/// </param>
/// <param name="AOpen">
/// Необходимо ли выполнить получение результирующей выборки
/// </param>
procedure SetSQLForQuery(const AQuery: TDataSet; const ASQL: string; const AOpen: Boolean);

/// <summary>
/// Функция получения ссылки на контрол по имени контрола
/// </summary>
/// <param name="AName">
/// Имя контрола
/// </param>
/// <param name="AParent">
/// Оконный элемент, среди дочерних элементов которого нужно производить
/// поиск контрола
/// </param>
/// <returns>
/// Ссылка на искомый контрол
/// </returns>
function GetControlByName(const AName: string; const AParent: TCustomControl): TControl;

/// <summary>
/// Процедура установки текста компонента типа "метка" с указанным именем
/// </summary>
/// <param name="AParentControl">
/// Контрол, содержащий метку
/// </param>
/// <param name="ALabelName">
/// Имя компонента типа "метка"
/// </param>
/// <param name="ACaption">
/// Текст, который нужно присвоить метке
/// </param>
procedure SetLabelCaption(const AParentControl: TCustomControl; const ALabelName, ACaption: string);

/// <summary>
/// Функция создания объекта запроса <b>TADOQuery</b> или <b>TSQLQuery</b> и
/// получения ссылки на него в виде ссылки на датасет
/// </summary>
/// <param name="AConnection">
/// Объект подключения к БД
/// </param>
/// <returns>
/// Ссылка на объект запроса
/// </returns>
function GetQuery(const AConnection: TCustomConnection): TDataSet;

/// <summary>
/// Функция, возвращающая класс документа по указанному типу
/// </summary>
function GetArchiveDocumentItemClassByTypeId(const ATypeId: Integer): TArchiveDocumentItemClass;

/// <summary>
/// Функция, возвращающая класс списка документов по указанному типу
/// </summary>
function GetArchiveDocumentListClassByTypeId(const ATypeId: Integer): TArchiveDocumentListClass;

/// <summary>
/// Процедура удаления всех дочерних элементов из указанного контрола
/// </summary>
procedure EmptyControl(const AControl: TCustomControl);

implementation

uses
  uTShipmentBSOItem,
  uTShipmentBSOWithActItem,
  uTDamagedBSOItem,
  uTShipmentBSOList,
  uTShipmentBSOWithActList,
  uTDamagedBSOList;

function GetControlByName(const AName: string; const AParent: TCustomControl): TControl;
var
  k: Integer;
begin
  Result := nil;
  for k := 0 to AParent.ControlCount - 1 do
  begin
    if AParent.Controls[k].Name = AName then
    begin
      Result := AParent.Controls[k];
      Break;
    end;
  end;
end;

procedure SetLabelCaption(const AParentControl: TCustomControl; const ALabelName, ACaption: string);
var
  cc: TControl;
begin
  if Assigned(AParentControl) then
  begin
    cc := GetControlByName(Trim(ALabelName), AParentControl);
    if Assigned(cc) then
    begin
      if cc is TLabel then
      begin
        (cc as TLabel).Caption := ACaption;
      end;
    end;
  end;
end;

procedure SetSQLForQuery(const AQuery: TDataSet; const ASQL: string; const AOpen: Boolean);
begin
  if AQuery is TADOQuery then
  begin
    (AQuery as TADOQuery).SQL.Clear;
    (AQuery as TADOQuery).SQL.Append(ASQL);
    if not AOpen then
    begin
      (AQuery as TADOQuery).ExecSQL;
    end;
  end
  else
  begin
    (AQuery as TSQLQuery).SQL.Clear;
    (AQuery as TSQLQuery).SQL.Append(ASQL);
    if not AOpen then
    begin
      (AQuery as TSQLQuery).ExecSQL;
    end;
  end;
  if AOpen then
  begin
    AQuery.Open;
  end;
end;

function GetADOQuery(const AConnection: TCustomConnection): TADOQuery;
begin
  Result := TADOQuery.Create(nil);
  Result.Connection := AConnection as TADOConnection;
  Result.CommandTimeout := 60000;
  Result.LockType := ltReadOnly;
  Result.CursorType := ctOpenForwardOnly;
end;

function GetSQLQuery(const AConnection: TCustomConnection): TSQLQuery;
begin
  Result := TSQLQuery.Create(nil);
  Result.SQLConnection := AConnection as TSQLConnection;
end;

function GetQuery(const AConnection: TCustomConnection): TDataSet;
begin
  Result := nil;
  if Assigned(AConnection) then
  begin
    if AConnection is TADOConnection then
    begin
      Result := GetADOQuery(AConnection);
    end
    else
    begin
      Result := GetSQLQuery(AConnection);
    end;
  end;
end;

function GetArchiveDocumentItemClassByTypeId(const ATypeId: Integer): TArchiveDocumentItemClass;
begin
  case ATypeId of
    1:
      begin
        Result := TShipmentBSOItem;
      end;
    2:
      begin
        Result := TShipmentBSOWithActItem;
      end;
    5:
      begin
        Result := TDamagedBSOItem;
      end;
  else
    begin
      Result := nil;
    end;
  end;
end;

function GetArchiveDocumentListClassByTypeId(const ATypeId: Integer): TArchiveDocumentListClass;
begin
  case ATypeId of
    1:
      begin
        Result := TShipmentBSOList;
      end;
    2:
      begin
        Result := TShipmentBSOWithActList;
      end;
    5:
      begin
        Result := TDamagedBSOList;
      end;
  else
    begin
      Result := nil;
    end;
  end;
end;

procedure EmptyControl(const AControl: TCustomControl);
var
  i: Integer;
  c: TControl;
begin
  if Assigned(AControl) then
  begin
    for i := AControl.ControlCount - 1 downto 0 do
    begin
      c := AControl.Controls[i];
      c.Parent := nil;
      FreeAndNil(c);
    end;
  end;
end;

end.
