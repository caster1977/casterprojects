unit About;

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
  ShellAPI,
  CastersPackage.getFVI,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  jpeg,
  OverseerTypes;

type
  TAboutForm=class(TForm)
    Shape1: TShape;
    Timer1: TTimer;
    Timer2: TTimer;
    imgApplicationIcon: TImage;
    imgLogo: TImage;
    lblTitle: TLabel;
    lblVersion: TLabel;
    lblLegalCopyright: TLabel;
    lblEMailAddress: TLabel;
    btnClose: TButton;
    lblEMail: TLabel;
    gsFileVersionInfo1: TgsFileVersionInfo;
    ActionManager1: TActionManager;
    Action_Close: TAction;
    procedure Timer2Timer(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
  private
    procedure Do_Close;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

uses
  Main,
  OverseerConsts;

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

procedure TAboutForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TAboutForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{DE0DCC91-CA35-448A-9D90-90AE67C0B19B}';
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);
  Action_Close.Visible:=False;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{F351EEB2-9D08-4D78-9E81-C390A78194DF}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);
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
  lblVersion.Caption:=Format('Версия %d.%d Release %d Build %d', [gsFileVersionInfo1.ModuleVersion.Major, gsFileVersionInfo1.ModuleVersion.Minor, gsFileVersionInfo1.ModuleVersion.Release, gsFileVersionInfo1.ModuleVersion.Build]);
  lblLegalCopyright.Caption:=gsFileVersionInfo1.LegalCopyright;
  LogThis('Отображено окно "О программе...".', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{313F0883-6BA7-4CD9-BA9B-95D259F25251}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.Do_Close;
const
  LogGroupGUID: string='{B142DF26-306F-4F22-AF72-1987284AAA13}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', LogGroupGUID);
  ModalResult:=mrClose;
  LogThis('Окно "О программе..." закрыто.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.lblEMailAddressClick(Sender: TObject);
const
  LogGroupGUID: string='{32092C44-085B-402B-AF10-CC4D0D5D73A1}';
begin
  ProcedureHeader('Процедура-обработчик щелчка по метке адреса электронной почты', LogGroupGUID);
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:vlad_dracula@tut.by'), nil, nil, SW_MAXIMIZE);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.Timer1Timer(Sender: TObject);
const
  LogGroupGUID: string='{3C1D1174-D5AB-4710-912A-8D56B2B8B74E}';
begin
  ProcedureHeader('Процедура закрытия окна по истечению счётчика таймера', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.Timer2Timer(Sender: TObject);
begin
  // Процедура реакции на срабатывание таймера, отвечающего за плавное увеличение прозрачности окна
  if ((AlphaBlendValue+17)<=222) then
    AlphaBlendValue:=AlphaBlendValue+17;
end;

end.
