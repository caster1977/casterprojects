unit uSetPasswordForm;

interface

uses
  ActnList,
  ActnMan,
  Classes,
  Controls,
  ExtCtrls,
  Forms,
  ImgList,
  Mask,
  PlatformDefaultStyleActnCtrls,
  StdCtrls,
  uLogProvider,
  Windows;

type
  TSetPasswordForm=class(TForm)
    lblPassword: TLabel;
    lblConfirmation: TLabel;
    meConfirmation: TMaskEdit;
    mePassword: TMaskEdit;
    Bevel2: TBevel;
    Log: TLogProvider;
    ActionManager1: TActionManager;
    Action_Apply: TAction;
    Action_Close: TAction;
    chkbxShowPassword: TCheckBox;
    btnApply: TButton;
    btnHelp: TButton;
    Action_Help: TAction;
    btnClose: TButton;
    ilSetPasswordFormSmallImages: TImageList;
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FieldsChange(Sender: TObject);
    procedure chkbxShowPasswordClick(Sender: TObject);
  strict private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure Do_Help;
    procedure Do_Apply;
    procedure Do_Close;
    procedure Do_UpdateActions;
    procedure Do_SwitchPasswordVisibility;
  end;

implementation

{$R *.dfm}

uses
  SysUtils,
  uMainForm,
  uRoutines;

procedure TSetPasswordForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TSetPasswordForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TSetPasswordForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('��������� ��������� ��� ������.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TSetPasswordForm.Do_Apply;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrOk', '{8C1D1934-43A0-4BD3-A063-95940EA9B73D}');

  ModalResult:=mrOk;
  Log.SendInfo('������� ��������� ������ ������� ������ ���� ������������ �������������.');
  Log.SendInfo('���� ��������� ������ ������� ������ �������.');

  ProcedureFooter;
end;

procedure TSetPasswordForm.Do_Close;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', '{19DBBA6D-0E8E-4BBB-BF5B-D2C80E71A631}');

  ModalResult:=mrClose;
  Log.SendInfo('������� ��������� ������ ������� ������ ���� �������� �������������.');
  Log.SendInfo('���� ��������� ������ ������� ������ �������.');

  ProcedureFooter;
end;

procedure TSetPasswordForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('��������� ������ ����������� �������', '{95536062-F76C-495C-B1F2-70E50F7A9FF0}');
  bError:=False;

  Log.SendInfo('������������ ������� �������� ����������� ����� ���������...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('��������, ���������� ���� � ������ ��������� �� ������.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TSetPasswordForm.Do_UpdateActions;
begin
  ProcedureHeader('��������� ���������� ��������� ��������', '{3ED4C156-FDB8-4F56-9E52-B3F393FE249D}');

  Action_Apply.Enabled:=mePassword.Text=meConfirmation.Text;
  Log.SendDebug('�������� "'+Action_Apply.Caption+'" '+Routines.GetConditionalString(Action_Apply.Enabled, '�', '��')+'�������.');
  btnApply.Default:=Action_Apply.Enabled;
  btnClose.Default:=not Action_Apply.Enabled;

  ProcedureFooter;
end;

procedure TSetPasswordForm.Do_SwitchPasswordVisibility;
begin
  ProcedureHeader('��������� ������� �� ������������ ��������� ������ "'+chkbxShowPassword.Caption+'"', '{0219B9CF-B108-49C8-A390-22AF8B17C186}');

  if chkbxShowPassword.Checked then
    begin
      mePassword.PasswordChar:=#0;
      meConfirmation.PasswordChar:=#0;
    end
  else
    begin
      mePassword.PasswordChar:='*';
      meConfirmation.PasswordChar:='*';
    end;

  ProcedureFooter;
end;

procedure TSetPasswordForm.FormCreate(Sender: TObject);
const
  ICON_SETPASSWORD=1;
begin
  ProcedureHeader('���������-���������� ������� �������� ����', '{43E2DB1C-46EC-46FB-BE5F-69082FF4BDB0}');

  ilSetPasswordFormSmallImages.GetIcon(ICON_SETPASSWORD, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('�������� "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, '�', '��')+'�������.');

  with MainForm.Configuration do
    begin
      // ��������� ���������� ���������������� � ������������ � ����������� ���������
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // ��������� ��������� ���� ������������ � ����������� �� ���������� ������������ ���������
      if SetPasswordFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if SetPasswordFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if SetPasswordFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=SetPasswordFormPosition.x;
          if SetPasswordFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if SetPasswordFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=SetPasswordFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TSetPasswordForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� ����������� ����', '{109E2C60-29E7-4230-956B-848F6063FD69}');
  Do_UpdateActions;
  Log.SendInfo('���������� ���� ��������� ������ ������� ������.');
  ProcedureFooter;
end;

procedure TSetPasswordForm.FieldsChange(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� ��������� �������� �����', '{C2099A30-DAD0-476B-AAFF-031721A0641E}');
  Do_UpdateActions;
  ProcedureFooter;
end;

procedure TSetPasswordForm.Action_ApplyExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Apply.Caption+'"', '{D6F02F10-4334-4227-9C49-E2DB8B98CA70}');
  Do_Apply;
  ProcedureFooter;
end;

procedure TSetPasswordForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Close.Caption+'"', '{4569EB61-7A53-4A07-8D49-7D91C54D6FEF}');
  Do_Close;
  ProcedureFooter;
end;

procedure TSetPasswordForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Help.Caption+'"', '{772E549E-6DD2-4921-B2F9-5C65F20976FE}');
  Do_Help;
  ProcedureFooter;
end;

procedure TSetPasswordForm.chkbxShowPasswordClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "'+chkbxShowPassword.Caption+'"', '{1CA50F76-73D7-4646-8365-189442365348}');
  Do_SwitchPasswordVisibility;
  ProcedureFooter;
end;

end.
