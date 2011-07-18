unit uLoginForm;

interface

uses
  Forms,
  Mask,
  StdCtrls,
  ActnList,
  ActnMan,
  ExtCtrls,
  uLogProvider,
  PlatformDefaultStyleActnCtrls,
  Controls,
  Graphics,
  Classes;

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
    Log: TLogProvider;
    procedure FormShow(Sender: TObject);
    procedure Action_OkExecute(Sender: TObject);
    procedure Action_CancelExecute(Sender: TObject);
    procedure FieldsChange(Sender: TObject);
  strict private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure Do_UpdateActions;
    procedure Do_Ok;
    procedure Do_Cancel;
  end;

var
  LoginForm: TLoginForm;

implementation

{$R *.dfm}

uses
  uMainForm,
  OA5Routines;

procedure TLoginForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TLoginForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TLoginForm.Do_UpdateActions;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{348CBBCC-9845-40ED-9C35-39F5D58F4EAA}');
  Action_Ok.Enabled:=edbxLogin.Text<>'';
  Log.SendDebug('Действие "'+Action_Ok.Caption+'" '+Routines_GetConditionalMessage(Action_Ok.Enabled, 'в', 'от')+'ключено.');
  btnOk.Default:=Action_Ok.Enabled;
  btnCancel.Default:=not Action_Ok.Enabled;
  ProcedureFooter;
end;

procedure TLoginForm.Do_Ok;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{38630A3A-99DB-4D54-A9A4-42BBA7F6DC42}');
  ModalResult:=mrOk;
  Log.SendInfo('Попытка авторизации была подтверждена пользователем.');
  Log.SendInfo('Окно авторизации закрыто.');
  ProcedureFooter;
end;

procedure TLoginForm.Action_OkExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Ok.Caption+'"', '{28FD25CC-0ED7-4CDC-8238-38B08A51AE9B}');
  Do_Ok;
  ProcedureFooter;
end;

procedure TLoginForm.Action_CancelExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Cancel.Caption+'"', '{1DFD76E1-46A7-4ADA-A2F3-AAF70AC8060C}');
  Do_Cancel;
  ProcedureFooter;
end;

procedure TLoginForm.Do_Cancel;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrCancel', '{AFC63B2A-379B-4A09-98F3-549C5570B3D2}');
  ModalResult:=mrCancel;
  Log.SendInfo('Попытка авторизации была отменена пользователем.');
  Log.SendInfo('Окно авторизации закрыто.');
  ProcedureFooter;
end;

procedure TLoginForm.FieldsChange(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события изменения значения полей', '{93B9E5F4-4353-4053-A07E-DED31D7011F0}');
  Do_UpdateActions;
  ProcedureFooter;
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{96321487-1DC9-4591-AD46-BD64CDC4B64D}');
  Log.SendInfo('Отображено окно авторизации.');
  Do_UpdateActions;
  ProcedureFooter;
end;

end.
