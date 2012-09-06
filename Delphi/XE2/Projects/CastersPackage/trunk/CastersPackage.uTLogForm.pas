unit CastersPackage.uTLogForm;

interface

uses
  CastersPackage.uLogProvider,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls;

type
  TBusyStateMethod = procedure of object;

  TLogForm = class(TForm)
    Log: TLogProvider;
  strict private
    FBusyCounter: PInteger;
    FIncrease: TBusyStateMethod;
    FDecrease: TBusyStateMethod;
    FRefresh: TBusyStateMethod;
    FProgressBar: TProgressBar;
    FError: Boolean;
    FErrorMessage: string;
    procedure ClearError;
    procedure RunBusy(ABusyStateMethod: TBusyStateMethod);
    procedure ShowErrorDialog;
  protected
    procedure ProcedureHeader(const ATitle, ALogGroupGUID: string);
    procedure ProcedureFooter;
    procedure GenerateError(const AMessage: string);
  public
    constructor Create(AOwner: TComponent; ABusyCounter: PInteger = nil; AIncrease: TBusyStateMethod = nil;
      ADecrease: TBusyStateMethod = nil; ARefresh: TBusyStateMethod = nil; AProgressBar: TProgressBar = nil);
      reintroduce; virtual;
  end;

resourcestring
  RsEventHandlerOfActionExecute = 'Процедура-обработчик действия "%s"';
  RsEventHandlerOfActionUpdate = 'Процедура-обработчик обновления действия "%s';
  RsEventHandlerOfFormCreation = 'Процедура-обработчик события создания окна %s';
  RsEventHandlerOfFormShowing = 'Процедура-обработчик события отображения окна %s';
  RsWindowShowed ='Отображено окно %s.';
  RsWindowClosedByUser = 'Окно %s закрыто пользователем.';
  RsContextHelpProcedure = 'Процедура вызова контекстной справки';
  RsTryingToOpenHelpFile = 'Производится попытка открытия справочного файла программы...';
  RsHelpFileNonFound = 'Извините, справочный файл к данной программе не найден.';

implementation

resourcestring
  RsProcedureExecutesWithoutError = 'Процедура выполнена без ошибок.';
  RsShowErrorDialogCaption = '%s - Ошибка!';

{$R *.dfm}

procedure TLogForm.ProcedureHeader(const ATitle, ALogGroupGUID: string);
begin
  ClearError;
  Log.EnterMethod(ATitle, ALogGroupGUID);
  RunBusy(FIncrease);
end;

constructor TLogForm.Create(AOwner: TComponent; ABusyCounter: PInteger;
  AIncrease, ADecrease, ARefresh: TBusyStateMethod; AProgressBar: TProgressBar);
begin
  inherited Create(AOwner);
  FBusyCounter := ABusyCounter;
  FIncrease := AIncrease;
  FDecrease := ADecrease;
  FRefresh := ARefresh;
  FProgressBar := AProgressBar;
  Log.LogFile.FileNameSuffix := Application.Title + '_' + Self.Name;
end;

procedure TLogForm.GenerateError(const AMessage: string);
begin
  FErrorMessage:=AMessage;
  FError:=True;
end;

procedure TLogForm.RunBusy(ABusyStateMethod: TBusyStateMethod);
begin
  if Assigned(ABusyStateMethod) then
  begin
    ABusyStateMethod;
  end;
end;

procedure TLogForm.ProcedureFooter;
begin
  if FError then
  begin
    ShowErrorDialog;
    ClearError;
  end
  else
  begin
    Log.SendDebug(RsProcedureExecutesWithoutError);
  end;
  if Assigned(FProgressBar) then
  begin
    FProgressBar.Position := FProgressBar.Min;
  end;
  RunBusy(FDecrease);
  Log.ExitMethod;
end;

procedure TLogForm.ClearError;
begin
  FError := False;
  FErrorMessage := EmptyStr;
end;

procedure TLogForm.ShowErrorDialog;
var
  old_busy_counter: Integer;
begin
  old_busy_counter := 0;
  Log.SendError(FErrorMessage);
  try
    if Assigned(FBusyCounter) then
    begin
      old_busy_counter := FBusyCounter^; // сохранение значения счётчика действий, требующих состояния "занято"
      FBusyCounter^ := 0;
      RunBusy(FRefresh);
    end;
    MessageBox(Handle, PWideChar(FErrorMessage), PWideChar(Format(RsShowErrorDialogCaption, [Application.Title])),
      MB_OK + MB_ICONERROR + MB_DEFBUTTON1);
  finally
    if Assigned(FBusyCounter) then
    begin
      FBusyCounter^ := old_busy_counter; // возвращение старого значения счётчика
      RunBusy(FRefresh);
    end;
  end;
end;

end.
