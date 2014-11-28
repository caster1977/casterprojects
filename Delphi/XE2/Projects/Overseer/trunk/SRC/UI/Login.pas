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
  ExtCtrls,
  StdCtrls,
  Mask,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  OverseerTypes;

type
  TLoginForm=class(TForm)
    lblLogin: TLabel;
    lblPassword: TLabel;
    imgKey: TImage;
    edbxLogin: TEdit;
    mePassword: TMaskEdit;
    btnOk: TButton;
    btnCancel: TButton;
    Bevel2: TBevel;
    ActionManager1: TActionManager;
    Action_Ok: TAction;
    Action_Cancel: TAction;
    procedure FieldsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_OkExecute(Sender: TObject);
    procedure Action_CancelExecute(Sender: TObject);
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
  OverseerRoutines,
  OverseerConsts;

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
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TLoginForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TLoginForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{F93DF6F2-0480-41F4-94B5-3C3DA25B8812}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);
  LogThis('Отображено окно авторизации.', LogGroupGUID, lmtInfo);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.FieldsChange(Sender: TObject);
const
  LogGroupGUID: string='{59008256-880B-44C7-AF9E-1F40C53A3DA1}';
begin
  ProcedureHeader('Процедура-обработчик события изменения значения полей', LogGroupGUID);
  Do_UpdateActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.Do_UpdateActions;
const
  LogGroupGUID: string='{E432BB88-DDDE-48A8-902A-ED4D6FA38B74}';
begin
  ProcedureHeader('Процедура обновления состояния действий', LogGroupGUID);
  Action_Ok.Enabled:=edbxLogin.Text<>'';
  LogThis('Действие "'+Action_Ok.Caption+'" '+Routines_GetConditionalMessage(Action_Ok.Enabled, 'в', 'от')+'ключено.', LogGroupGUID, lmtDebug);
  btnOk.Default:=Action_Ok.Enabled;
  btnCancel.Default:=not Action_Ok.Enabled;
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
  LogGroupGUID: string='{1A7F3F94-317E-4013-B49A-47B71CCBAAD2}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Cancel.Caption+'"', LogGroupGUID);
  Do_Cancel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.Do_Ok;
const
  LogGroupGUID: string='{E3589F85-E04E-4DF7-B5F9-E0E8E5083396}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', LogGroupGUID);
  ModalResult:=mrOk;
  LogThis('Попытка авторизации была подтверждена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно авторизации закрыто.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TLoginForm.Do_Cancel;
const
  LogGroupGUID: string='{9341B39A-FE1C-4D56-B03A-EE83E01E25C9}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrCancel', LogGroupGUID);
  ModalResult:=mrCancel;
  LogThis('Попытка авторизации была отменена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно авторизации закрыто.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

end.
