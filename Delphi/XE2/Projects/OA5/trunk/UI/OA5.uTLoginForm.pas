unit OA5.uTLoginForm;

interface

uses
  OA5.uTOA5PositionedLogForm,
  System.Classes,
  Vcl.Forms,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.Mask,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TLoginForm = class(TOA5PositionedLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actHelp: TAction;
    actEnter: TAction;
    actClose: TAction;
    pnlButtons: TPanel;
    btnHelp: TButton;
    btnEnter: TButton;
    btnClose: TButton;
    lblLogin: TLabel;
    edbxLogin: TEdit;
    lblPassword: TLabel;
    mePassword: TMaskEdit;
    procedure FormShow(Sender: TObject);
    procedure actEnterExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actEnterUpdate(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.uResourceStrings,
  System.SysUtils,
  OA5.uTMainForm,
  CastersPackage.uRoutines;

resourcestring
  RsLoginForm = 'авторизации';

const
  ICON_LOGIN = 1;

procedure TLoginForm.actEnterExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actEnter.Caption]), '{28FD25CC-0ED7-4CDC-8238-38B08A51AE9B}');
  Log.SendInfo('ѕопытка авторизации была подтверждена пользователем.');
  CloseModalWindowWithOkResult(RsLoginForm, '{BE6CDE7F-6BE7-4917-A934-22DCD3BB37A7}');
  ProcedureFooter;
end;

procedure TLoginForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{051B0A6E-B5FF-45D2-A88E-00E7883BADD8}');
  Log.SendInfo('ѕопытка авторизации была отменена пользователем.');
  CloseModalWindowWithCancelResult(RsLoginForm, '{F74BBC28-40EF-4202-8A1E-5FB66DDE83AA}');
  ProcedureFooter;
end;

procedure TLoginForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{387AD513-3FC5-4D69-8DC9-C4841FFC2D22}');
  Help(HelpContext, '{9790B9F4-3536-4CDE-8F0B-C30445D8587C}');
  ProcedureFooter;
end;

procedure TLoginForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{CEE5E3DF-C04C-4125-AFDE-D6FE85947558}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

procedure TLoginForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsLoginForm]), '{B7B2C87E-2141-43CA-A41B-23FE0E874839}');

  ImageList.GetIcon(ICON_LOGIN, Icon);
  with MainForm.Configuration do
  begin
    // установка параметров протоколировани€ в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;
  end;

  ProcedureFooter;
end;

procedure TLoginForm.FormShow(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsLoginForm]), '{96321487-1DC9-4591-AD46-BD64CDC4B64D}');
  Log.SendInfo(Format(RsWindowShowed, [RsLoginForm]));
  ProcedureFooter;
end;

procedure TLoginForm.actEnterUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := edbxLogin.Text <> EmptyStr;
  if actEnter.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actEnter.Caption]), '{53E5D5D6-2AA3-4537-8268-7DD101CB6FBB}');
    actEnter.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actEnter));
    ProcedureFooter;
  end;
  if btnEnter.Default <> b then
  begin
    btnEnter.Default := b;
  end;
  if btnClose.Default <> (not b) then
  begin
    btnClose.Default := not b;
  end;
end;

end.
