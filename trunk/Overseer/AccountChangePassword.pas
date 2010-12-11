unit AccountChangePassword;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  ExtCtrls,
  Mask,
  OverseerTypes;

type
  TAccountChangePasswordForm=class(TForm)
    lblPassword: TLabel;
    lblConfirmation: TLabel;
    mskPassword: TMaskEdit;
    mskConfirmation: TMaskEdit;
    Bevel1: TBevel;
    ActionManager1: TActionManager;
    Action_Apply: TAction;
    Action_Cancel: TAction;
    Action_Help: TAction;
    btnCancel: TButton;
    btnHelp: TButton;
    btnApply: TButton;
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_CancelExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FieldsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure Do_Apply;
    procedure Do_Cancel;
    procedure Do_Help;
    procedure Do_UpdateActions;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
  end;

var
  AccountChangePasswordForm: TAccountChangePasswordForm;

implementation

{$R *.dfm}

uses
  Main,
  OverseerRoutines,
  OverseerConsts;

procedure TAccountChangePasswordForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
var
  s: string;
  aCopyData: TCopyDataStruct;
begin
  case aMessageType of
    lmtError:
      s:='ERROR';
    lmtWarning:
      s:='WARNING';
    lmtInfo:
      s:='INFO';
    lmtSQL:
      s:='SQL';
    lmtDebug:
      s:='DEBUG';
  end;
  s:=IntToStr(WMCD_MODALLOG)+';'+s+';'+aMessage+';'+aLogGroupGUID;
  with aCopyData do
    begin
      dwData:=0;
      cbData:=Length(s)+1;
      lpData:=PAnsiChar(AnsiString(s));
    end;
  SendMessage(MainForm.Handle, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
end;

procedure TAccountChangePasswordForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TAccountChangePasswordForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TAccountChangePasswordForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TAccountChangePasswordForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{1E310629-ACF3-45CB-8A47-FB7F16679898}';
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);

  LogThis('Производится попытка открытия справочного файла программы...', LogGroupGUID, lmtInfo);
  with Action_Help do
    begin
      Enabled:=Application.HelpFile<>'';
      Visible:=Enabled;
    end;
  LogThis('Действие "'+Action_Help.Caption+'" '+Routines_GetConditionalMessage(Action_Help.Visible, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountChangePasswordForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{62066969-BA56-459D-9D20-BA4D3425194C}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);

  LogThis('Отображено окно изменения пароля учётной записи.', LogGroupGUID, lmtInfo);
  Do_UpdateActions;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountChangePasswordForm.FieldsChange(Sender: TObject);
const
  LogGroupGUID: string='{856591B4-DAB1-44A5-8253-9DA5CDCCF2D2}';
begin
  ProcedureHeader('Процедура-обработчик события изменения значения полей', LogGroupGUID);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountChangePasswordForm.Do_UpdateActions;
const
  LogGroupGUID: string='{420CA9D2-77A8-4135-9C82-1ABAD941C427}';
begin
  ProcedureHeader('Процедура обновления состояния действий', LogGroupGUID);

  Action_Apply.Enabled:=mskPassword.Text=mskConfirmation.Text;
  LogThis('Действие "'+Action_Apply.Caption+'" '+Routines_GetConditionalMessage(Action_Apply.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  btnApply.Default:=Action_Apply.Enabled;
  btnCancel.Default:=not Action_Apply.Enabled;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountChangePasswordForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{7B859181-AC2E-483B-AC38-6B3A134986AE}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountChangePasswordForm.Action_ApplyExecute(Sender: TObject);
const
  LogGroupGUID: string='{5A83A4C3-4664-4B55-8A06-B78ACFD959A7}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', LogGroupGUID);
  Do_Apply;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountChangePasswordForm.Action_CancelExecute(Sender: TObject);
const
  LogGroupGUID: string='{0458EDB5-A41A-416F-A9C8-7830D5B6D747}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Cancel.Caption+'"', LogGroupGUID);
  Do_Cancel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountChangePasswordForm.Do_Help;
const
  LogGroupGUID: string='{A28AA836-A546-4518-8BA6-DFD6EE4B07FC}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', LogGroupGUID);

  LogThis('Производится попытка открытия справочного файла программы...', LogGroupGUID, lmtInfo);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines_GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountChangePasswordForm.Do_Apply;
const
  LogGroupGUID: string='{0A879120-DB8C-434B-84D1-73EBDCA3647B}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', LogGroupGUID);

  ModalResult:=mrOk;
  LogThis('Попытка изменения пароля была подтверждена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения пароля закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountChangePasswordForm.Do_Cancel;
const
  LogGroupGUID: string='{7C4B2989-7CC2-4CDC-B2BC-76CDA8E954FA}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrCancel', LogGroupGUID);

  ModalResult:=mrCancel;
  LogThis('Попытка изменения пароля была отменена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения пароля закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

end.
