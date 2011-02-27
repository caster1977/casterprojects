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
  StdCtrls;

type
  TAboutForm=class(TForm)
    Shape1: TShape;
    ActionManager1: TActionManager;
    Action_Close: TAction;
    gsFileVersionInfo1: TgsFileVersionInfo;
    Timer1: TTimer;
    Timer2: TTimer;
    lblEMail: TLabel;
    lblEMailAddress: TLabel;
    btnClose: TButton;
    lblLegalCopyright: TLabel;
    lblVersion: TLabel;
    imgApplicationIcon: TImage;
    lblTitle: TLabel;
    procedure Action_CloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
  private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
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
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TAboutForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState;
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{D5F63818-B7A4-4402-9B7F-F73982428C93}';
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);
  gsFileVersionInfo1.Filename:=Application.ExeName;
  Action_Close.Visible:=False;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{855FFBFA-BE54-41C2-B039-E485EB834BE6}';
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
  lblVersion.Caption:=Format('Версия %s билд %s', [copy(gsFileVersionInfo1.FileVersion, 1, LastDelimiter('.', gsFileVersionInfo1.FileVersion)-1), gsFileVersionInfo1.GetBuildOnly]);
  lblLegalCopyright.Caption:=gsFileVersionInfo1.LegalCopyright;
  LogThis('Отображено окно "О программе...".', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{C7F253A6-6654-4B07-8BBB-0CE66F649BF9}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.Do_Close;
const
  LogGroupGUID: string='{D7505404-3E9E-4962-87E0-B5A240BF28CE}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', LogGroupGUID);
  ModalResult:=mrClose;
  LogThis('Окно "О программе..." закрыто.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TAboutForm.Timer1Timer(Sender: TObject);
const
  LogGroupGUID: string='{4FD69E44-3560-46EE-83ED-AD0FFC20A0DF}';
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

procedure TAboutForm.lblEMailAddressClick(Sender: TObject);
const
  LogGroupGUID: string='{E1A6413A-F33A-4DC2-B281-CE50DF74296D}';
begin
  ProcedureHeader('Процедура-обработчик щелчка по метке адреса электронной почты', LogGroupGUID);
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:vlad_dracula@tut.by'), nil, nil, SW_MAXIMIZE);
  ProcedureFooter(LogGroupGUID);
end;

end.
