unit AccountProperties;

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
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  StdCtrls,
  ExtCtrls,
  OverseerTypes;

type
  TAccountPropertiesForm=class(TForm)
    Bevel2: TBevel;
    lblFullname: TLabel;
    lblPosition: TLabel;
    lblPhone: TLabel;
    Bevel1: TBevel;
    edbxFullname: TEdit;
    edbxPosition: TEdit;
    chkbxIsAdmin: TCheckBox;
    chkbxDisable: TCheckBox;
    btnHelp: TButton;
    btnApply: TButton;
    btnCancel: TButton;
    ActionManager1: TActionManager;
    Action_Apply: TAction;
    Action_Cancel: TAction;
    Action_Help: TAction;
    edbxPhone: TEdit;
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_CancelExecute(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure FieldsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    sFullname, sPosition, sPhone: string;
    bIsAdmin, bDisable: boolean;
    procedure Do_UpdateActions;
    procedure Do_Cancel;
    procedure Do_Help;
    procedure Do_Apply;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
  end;

var
  AccountPropertiesForm: TAccountPropertiesForm;

implementation

{$R *.dfm}

uses
  Main,
  OverseerRoutines,
  OverseerConsts;

procedure TAccountPropertiesForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
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

procedure TAccountPropertiesForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TAccountPropertiesForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TAccountPropertiesForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TAccountPropertiesForm.FormCreate(Sender: TObject); // завершена
const
  LogGroupGUID: string='{C780BC4E-AE60-4716-8931-58DF23F0DB88}';
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);

  with Action_Help do
    begin
      Enabled:=Application.HelpFile<>'';
      Visible:=Enabled;
    end;
  LogThis('Действие "'+Action_Help.Caption+'" '+Routines_GetConditionalMessage(Action_Help.Visible, 'в', 'от')+'ключено.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountPropertiesForm.FormShow(Sender: TObject); // завершена
const
  LogGroupGUID: string='{AEA4B578-739C-45A8-A287-1DCDFA2026D5}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);

  sFullname:=edbxFullname.Text;
  sPosition:=edbxPosition.Text;
  sPhone:=edbxPhone.Text;
  bIsAdmin:=chkbxIsAdmin.Checked;
  bDisable:=chkbxDisable.Checked;
  Do_UpdateActions;
  LogThis('Отображено окно изменения свойств учётной записи.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountPropertiesForm.FieldsChange(Sender: TObject); // завершена
const
  LogGroupGUID: string='{84DBC40F-579D-4BA0-8D69-F9AB50E97E7F}';
begin
  ProcedureHeader('Процедура-обработчик события изменения значения полей', LogGroupGUID);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountPropertiesForm.Do_UpdateActions; // завершена
const
  LogGroupGUID: string='{7CD0AE26-D7D9-4E27-AC2F-504E1960AE22}';
begin
  ProcedureHeader('Процедура обновления состояния действий', LogGroupGUID);

  Action_Apply.Enabled:=not((sFullname=edbxFullname.Text)and(sPosition=edbxPosition.Text)and(sPhone=edbxPhone.Text)and(bIsAdmin=chkbxIsAdmin.Checked)and(bDisable=chkbxDisable.Checked));
  LogThis('Действие "'+Action_Apply.Caption+'" '+Routines_GetConditionalMessage(Action_Apply.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtInfo);
  btnApply.Default:=Action_Apply.Enabled;
  btnCancel.Default:=not Action_Apply.Enabled;

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountPropertiesForm.Action_HelpExecute(Sender: TObject); // завершена
const
  LogGroupGUID: string='{A6A205D3-EEE6-4182-BA32-549E3560A42F}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountPropertiesForm.Action_ApplyExecute(Sender: TObject); // завершена
const
  LogGroupGUID: string='{DAE8957B-C18C-481F-AA2E-2E8686EF239B}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', LogGroupGUID);
  Do_Apply;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountPropertiesForm.Action_CancelExecute(Sender: TObject); // завершена
const
  LogGroupGUID: string='{562F9D1A-270D-4D0A-966C-9F1DDA03C14D}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Cancel.Caption+'"', LogGroupGUID);
  Do_Cancel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountPropertiesForm.Do_Help; // завершена
const
  LogGroupGUID: string='{F0041693-641E-4870-BFCD-E7256E4BE4D0}';
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

procedure TAccountPropertiesForm.Do_Apply; // завершена
const
  LogGroupGUID: string='{A9C1CCEC-F832-4443-BE04-8F28F282FE7F}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', LogGroupGUID);

  ModalResult:=mrOk;
  LogThis('Попытка изменения свойств учётной записи была подтверждена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения свойств учётной записи закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TAccountPropertiesForm.Do_Cancel; // завершена
const
  LogGroupGUID: string='{FF3A7593-9C79-45E4-A2DB-86FFE81533BC}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrCancel', LogGroupGUID);

  ModalResult:=mrCancel;
  LogThis('Попытка изменения свойств учётной записи была отменена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения свойств учётной записи закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

end.
