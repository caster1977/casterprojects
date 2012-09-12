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
  strict private
    procedure _Enter;
    procedure _Help;
    procedure _Close;
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

procedure TLoginForm._Enter;
begin
  ProcedureHeader(Format(RsCloseModalWithOkProcedure, [RsLoginForm]), '{38630A3A-99DB-4D54-A9A4-42BBA7F6DC42}');

  ModalResult := mrOk;
  Log.SendInfo('ѕопытка авторизации была подтверждена пользователем.');
  Log.SendInfo(Format(RsWindowClosedByUser, [RsLoginForm]));

  ProcedureFooter;
end;

procedure TLoginForm.actEnterExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actEnter.Caption]), '{28FD25CC-0ED7-4CDC-8238-38B08A51AE9B}');
  _Enter;
  ProcedureFooter;
end;

procedure TLoginForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{387AD513-3FC5-4D69-8DC9-C4841FFC2D22}');
  _Help;
  ProcedureFooter;
end;

procedure TLoginForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{CEE5E3DF-C04C-4125-AFDE-D6FE85947558}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

procedure TLoginForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{051B0A6E-B5FF-45D2-A88E-00E7883BADD8}');
  _Close;
  ProcedureFooter;
end;

procedure TLoginForm._Help;
begin
  ProcedureHeader(RsContextHelpProcedure, '{39BD2567-FAB9-430D-8381-C63A899366A4}');

  Log.SendInfo(RsTryingToOpenHelpFile);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    GenerateError(RsHelpFileNonFound);
  end;

  ProcedureFooter;
end;

procedure TLoginForm._Close;
begin
  ProcedureHeader(Format(RsCloseModalWithCancelProcedure, [RsLoginForm]), '{AFC63B2A-379B-4A09-98F3-549C5570B3D2}');

  ModalResult := mrCancel;
  Log.SendInfo('ѕопытка авторизации была отменена пользователем.');
  Log.SendInfo(Format(RsWindowClosedByUser, [RsLoginForm]));

  ProcedureFooter;
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
  b := edbxLogin.Text <> EmptyStr;
  if actEnter.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actEnter.Caption]),
      '{53E5D5D6-2AA3-4537-8268-7DD101CB6FBB}');
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
