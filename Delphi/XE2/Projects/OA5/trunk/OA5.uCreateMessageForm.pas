unit OA5.uCreateMessageForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  CastersPackage.uLogProvider,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan;

type
  TCreateMessageForm=class(TForm)
    ilCreateMessageFormSmallImages: TImageList;
    Log: TLogProvider;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_Close: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
  strict private
    procedure ProcedureHeader(const aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure Do_Help;
    procedure Do_Close;
    procedure Do_UpdateActions;
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.uRoutines,
  OA5.uMainForm;

procedure TCreateMessageForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TCreateMessageForm.ProcedureHeader(const aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TCreateMessageForm.PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('��������� ��������� ��� ������.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TCreateMessageForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Close.Caption+'"', '{F1FBC2E1-336C-491D-BC0B-8B2E70108C6D}');
  Do_Close;
  ProcedureFooter;
end;

procedure TCreateMessageForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Help.Caption+'"', '{800109C0-82AB-4EAC-80E9-9341BC00A650}');
  Do_Help;
  ProcedureFooter;
end;

procedure TCreateMessageForm.Do_Close;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', '{FB15D7B1-D988-4AB8-952A-A407B768E1C6}');

  ModalResult:=mrClose;
  Log.SendInfo('���� �������� ������ ��������� ������� �������������.');

  ProcedureFooter;
end;

procedure TCreateMessageForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('��������� ������ ����������� �������', '{D123D1F6-0D45-45B0-9361-110CAC9C6735}');
  bError:=False;

  Log.SendInfo('������������ ������� �������� ����������� ����� ���������...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('��������, ���������� ���� � ������ ��������� �� ������.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TCreateMessageForm.Do_UpdateActions;
begin
  ProcedureHeader('��������� ���������� ��������� ��������', '{3F56424B-5AAE-4F72-AC97-57075F825F88}');

  // Action_Clear.Enabled:=lvBuffer.Items.Count>0;
  // Log.SendDebug('�������� "'+Action_Clear.Caption+'" '+Routines.GetConditionalString(Action_Clear.Enabled, '�', '��')+'�������.');

  ProcedureFooter;
end;

procedure TCreateMessageForm.FormCreate(Sender: TObject);
const
  ICON_CREATEMESSAGE=1;
begin
  ProcedureHeader('���������-���������� ������� �������� ����', '{7FD82BF2-AA3D-4AD0-848B-14E0000E9B31}');

  ilCreateMessageFormSmallImages.GetIcon(ICON_CREATEMESSAGE, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('�������� "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, '�', '��')+'�������.');

  with MainForm.Configuration do
    begin
      // ��������� ���������� ���������������� � ������������ � ����������� ���������
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // ��������� ��������� ���� ������������ � ����������� �� ���������� ������������ ���������
      if CreateMessageFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if CreateMessageFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if CreateMessageFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=CreateMessageFormPosition.x;
          if CreateMessageFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if CreateMessageFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=CreateMessageFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

end.
