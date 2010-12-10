unit Login;

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
  Mask,
  StdCtrls,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  ExtCtrls,
  OA5Types;

type
  TLoginForm=class(TForm)
    Bevel2: TBevel;
    imgKey: TImage;
    ActionManager1: TActionManager;
    Action_Ok: TAction;
    Action_Cancel: TAction;
    btnOk: TButton;
    btnCancel: TButton;
    lblLogin: TLabel;
    lblPassword: TLabel;
    edbxLogin: TEdit;
    mePassword: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure Action_OkExecute(Sender: TObject);
    procedure Action_CancelExecute(Sender: TObject);
    procedure FieldsChange(Sender: TObject);
  private
    procedure Do_UpdateActions;
    procedure Do_Ok;
    procedure Do_Cancel;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses
  Main,
  OA5Routines,
  OA5Consts;

procedure TLoginForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
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

procedure TLoginForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  { TODO : Убрать ремарки }
  // MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TLoginForm.ProcedureFooter(aLogGroupGUID: string);
begin
  { TODO : Убрать ремарки }
  // MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TLoginForm.Do_UpdateActions;
const
  LogGroupGUID: string='{962C8991-2959-43F6-A7B4-73863EC8E206}';
begin
  ProcedureHeader('Процедура обновления состояния действий', LogGroupGUID);
  Action_Ok.Enabled:=edbxLogin.Text<>'';
  LogThis('Действие "'+Action_Ok.Caption+'" '+Routines_GetConditionalMessage(Action_Ok.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  btnOk.Default:=Action_Ok.Enabled;
  btnCancel.Default:=not Action_Ok.Enabled;
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.Do_Ok;
const
  LogGroupGUID: string='{8766EEB1-60BE-4D78-B9F4-0FAD3DDDC4C6}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', LogGroupGUID);
  ModalResult:=mrOk;
  LogThis('Попытка авторизации была подтверждена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно авторизации закрыто.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.Action_OkExecute(Sender: TObject);
const
  LogGroupGUID: string='{296AF451-9F40-4B8F-8E49-21EDE305F088}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Ok.Caption+'"', LogGroupGUID);
  Do_Ok;
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.Action_CancelExecute(Sender: TObject);
const
  LogGroupGUID: string='{053CBDC4-E004-4055-9043-48242ECE44A8}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Cancel.Caption+'"', LogGroupGUID);
  Do_Cancel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.Do_Cancel;
const
  LogGroupGUID: string='{5E1CBAA8-4442-4494-B599-4DAEDFFAFE2F}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrCancel', LogGroupGUID);
  ModalResult:=mrCancel;
  LogThis('Попытка авторизации была отменена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно авторизации закрыто.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.FieldsChange(Sender: TObject);
const
  LogGroupGUID: string='{DF1696CA-94FC-41B5-A0EE-C24DC939F026}';
begin
  ProcedureHeader('Процедура-обработчик события изменения значения полей', LogGroupGUID);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{B826CB1D-0670-4A10-A20B-A74946FC3F4D}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);
  LogThis('Отображено окно авторизации.', LogGroupGUID, lmtInfo);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

end.
