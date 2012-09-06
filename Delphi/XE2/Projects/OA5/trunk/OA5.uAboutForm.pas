unit OA5.uAboutForm;

interface

uses
  Forms,
  ActnList,
  ActnMan,
  ExtCtrls,
  StdCtrls,
  CastersPackage.uLogProvider,
  Classes,
  PlatformDefaultStyleActnCtrls,
  Controls,
  Graphics,
  CastersPackage.uTGSFileVersionInfo,
  CastersPackage.uTLogForm;

type
  TAboutForm = class(TLogForm)
    Shape1: TShape;
    ActionManager: TActionManager;
    actClose: TAction;
    Timer1: TTimer;
    Timer2: TTimer;
    lblEMail: TLabel;
    lblEMailAddress: TLabel;
    btnClose: TButton;
    lblLegalCopyright: TLabel;
    lblVersion: TLabel;
    imgApplicationIcon: TImage;
    lblTitle: TLabel;
    gsFileVersionInfo1: TgsFileVersionInfo;
    procedure actCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
  strict private
    procedure Do_Close;
  end;

implementation

{$R *.dfm}

uses
  Windows,
  SysUtils,
  ShellAPI,
  OA5.uMainForm;

resourcestring
  TEXT_ERROR_CREATE_MUTEX = '�� ������� ������� �������!';
  TEXT_ERROR_WAITFOR_MUTEX = '�� ������� ������� ��������� ��������!';
  TEXT_ERROR_RELEASE_MUTEX = '�� ������� ������� �������!';
  TEXT_ERROR_CLOSE_MUTEX_HANDLE = '�� ������� ������� ������������� ��������!';
  TEXT_ERRORCODE = ' ��� ������: ';

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� �������� ����', '{0B2B4443-33C8-44ED-8E91-C55FFCBB75E4}');
  gsFileVersionInfo1.Filename := Application.ExeName;
  actClose.Visible := False;
  ProcedureFooter;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� ����������� ����', '{BF30B1AE-7EA8-42ED-A2E1-6BB23BE961B3}');
  if actClose.Visible then
  begin
    Timer1.Enabled := False;
    AlphaBlendValue := 222;
    Timer2.Enabled := False;
  end
  else
  begin
    Timer1.Enabled := True;
    AlphaBlendValue := 0;
    Timer2.Enabled := True;
  end;
  btnClose.Default := actClose.Visible;
  lblVersion.Caption := Format('������ %d.%d Release %d Build %d', [gsFileVersionInfo1.ModuleVersion.Major,
    gsFileVersionInfo1.ModuleVersion.Minor, gsFileVersionInfo1.ModuleVersion.Release,
    gsFileVersionInfo1.ModuleVersion.Build]);
  lblLegalCopyright.Caption := gsFileVersionInfo1.LegalCopyright;
  Log.SendInfo('���������� ���� "� ���������...".');
  ProcedureFooter;
end;

procedure TAboutForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "' + actClose.Caption + '"',
    '{D141CB7B-C326-4B85-BDFC-5F5107598AEA}');
  Do_Close;
  ProcedureFooter;
end;

procedure TAboutForm.Do_Close;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', '{0C17F685-16BC-4D7F-B964-287B74A1CABF}');
  ModalResult := mrClose;
  Log.SendInfo('���� "� ���������..." �������.');
  ProcedureFooter;
end;

procedure TAboutForm.Timer1Timer(Sender: TObject);
begin
  ProcedureHeader('��������� �������� ���� �� ��������� �������� �������', '{1A3ED186-8181-467D-8491-E6C021EB2174}');
  Do_Close;
  ProcedureFooter;
end;

procedure TAboutForm.Timer2Timer(Sender: TObject);
begin
  // ��������� ������� �� ������������ �������, ����������� �� ������� ���������� ������������ ����
  if ((AlphaBlendValue + 17) <= 222) then
    AlphaBlendValue := AlphaBlendValue + 17;
end;

procedure TAboutForm.lblEMailAddressClick(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������ �� ����� ������ ����������� �����',
    '{A2E28A1B-21CE-4B40-8CB7-944094FAB627}');
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:vlad_dracula@tut.by'), nil, nil, SW_MAXIMIZE);
  ProcedureFooter;
end;

end.
