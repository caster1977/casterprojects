unit OA5About;

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
  ExtCtrls,
  OA5Types,
  getFVI,
  StdCtrls,
  LogProvider;

type
  TAboutForm=class(TForm)
    Shape1: TShape;
    ActionManager1: TActionManager;
    Action_Close: TAction;
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
    Log: TLogProvider;
    procedure Action_CloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
  private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure Do_Close;
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

uses
  ShellAPI,
  OA5Main,
  OA5Consts;

(*
procedure TAboutForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
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
*)

procedure TAboutForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TAboutForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� �������� ����', '{0B2B4443-33C8-44ED-8E91-C55FFCBB75E4}');
  gsFileVersionInfo1.Filename:=Application.ExeName;
  Action_Close.Visible:=False;
  ProcedureFooter;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� ����������� ����', '{BF30B1AE-7EA8-42ED-A2E1-6BB23BE961B3}');
  if Action_Close.Visible then
    begin
      Timer1.Enabled:=False;
      AlphaBlendValue:=222;
      Timer2.Enabled:=False;
    end
  else
    begin
      Timer1.Enabled:=True;
      AlphaBlendValue:=0;
      Timer2.Enabled:=True;
    end;
  btnClose.default:=Action_Close.Visible;
  lblVersion.Caption:=Format('������ %s ���� %s', [copy(gsFileVersionInfo1.FileVersion, 1, LastDelimiter('.', gsFileVersionInfo1.FileVersion)-1), gsFileVersionInfo1.GetBuildOnly]);
  lblLegalCopyright.Caption:=gsFileVersionInfo1.LegalCopyright;
  Log.SendInfo('���������� ���� "� ���������...".');
  ProcedureFooter;
end;

procedure TAboutForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Close.Caption+'"', '{D141CB7B-C326-4B85-BDFC-5F5107598AEA}');
  Do_Close;
  ProcedureFooter;
end;

procedure TAboutForm.Do_Close;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', '{0C17F685-16BC-4D7F-B964-287B74A1CABF}');
  ModalResult:=mrClose;
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
  if ((AlphaBlendValue+17)<=222) then
    AlphaBlendValue:=AlphaBlendValue+17;
end;

procedure TAboutForm.lblEMailAddressClick(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������ �� ����� ������ ����������� �����', '{A2E28A1B-21CE-4B40-8CB7-944094FAB627}');
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:vlad_dracula@tut.by'), nil, nil, SW_MAXIMIZE);
  ProcedureFooter;
end;

end.
