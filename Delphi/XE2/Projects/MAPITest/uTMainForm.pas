unit uTMainForm;

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
  System.Actions,
  Vcl.ActnList,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ExtActns,
  MAPI, IdMessage, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdSMTPBase, IdSMTP;

type
  TMainForm = class(TForm)
    btnSend: TButton;
    ledFrom: TLabeledEdit;
    ledTo: TLabeledEdit;
    ledSubject: TLabeledEdit;
    lblBody: TLabel;
    meBody: TMemo;
    ActionList: TActionList;
    actSendByMAPI: TAction;
    Button1: TButton;
    actSendBySMTP: TAction;
    IdSMTP: TIdSMTP;
    IdMessage: TIdMessage;
    procedure actSendByMAPIUpdate(Sender: TObject);
    procedure actSendByMAPIExecute(Sender: TObject);
    procedure actSendBySMTPExecute(Sender: TObject);
    procedure actSendBySMTPUpdate(Sender: TObject);
  private
    function GetFrom: LPSTR;
    property From: LPSTR read GetFrom nodefault;
  private
    function GetRecip: LPSTR;
    property Recip: LPSTR read GetRecip nodefault;
  private
    function GetSubject: LPSTR;
    property Subject: LPSTR read GetSubject nodefault;
  private
    function GetBody: LPSTR;
    property Body: LPSTR read GetBody nodefault;
  private
    function GetOriginator: PMapiRecipDesc;
    property Originator: PMapiRecipDesc read GetOriginator nodefault;
  private
    function GetRecipient: PMapiRecipDesc;
    property Recipient: PMapiRecipDesc read GetRecipient nodefault;
  private
    function GetLetter: TMapiMessage;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.actSendByMAPIExecute(Sender: TObject);
var
  Letter: TMapiMessage;
begin
  Letter := GetLetter;
  MapiSendMail(0, Application.Handle, Letter, MAPI_DIALOG or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0);
end;

procedure TMainForm.actSendByMAPIUpdate(Sender: TObject);
begin
  actSendByMAPI.Enabled := (Trim(ledFrom.Text) <> EmptyStr) and (Trim(ledTo.Text) <> EmptyStr) and (Trim(ledSubject.Text) <> EmptyStr) and (Trim(meBody.Lines.Text) <> EmptyStr);
end;

function TMainForm.GetSubject: LPSTR;
var
  s: string;
begin
  Result := nil;
  s := Trim(ledSubject.Text);
  if s <> EmptyStr then
  begin
    Result := StrNew(PAnsiChar(AnsiString(s)));
  end;
end;

function TMainForm.GetBody: LPSTR;
var
  s: string;
begin
  Result := nil;
  s := Trim(meBody.Lines.Text);
  if s <> EmptyStr then
  begin
    Result := StrNew(PAnsiChar(AnsiString(s)));
  end;
end;

function TMainForm.GetFrom: LPSTR;
var
  s: string;
begin
  Result := nil;
  s := Trim(ledFrom.Text);
  if s <> EmptyStr then
  begin
    Result := StrNew(PAnsiChar(AnsiString(s)));
  end;
end;

function TMainForm.GetLetter: TMapiMessage;
begin
  Result.ulReserved := 0; { Reserved for future use (M.B. 0) }
  Result.lpszSubject := Subject; { Message Subject }
  Result.lpszNoteText := Body; { Message Text }
  Result.lpszMessageType := nil; { Message Class }
  Result.lpszDateReceived := nil; { in YYYY/MM/DD HH:MM format }
  Result.lpszConversationID := nil; { conversation thread ID }
  Result.flFlags := 0; { unread,return receipt }
  Result.lpOriginator := Originator; { Originator descriptor }
  Result.nRecipCount := 1; { Number of recipients }
  Result.lpRecips := Recipient; // PMapiRecipDesc;  { Recipient descriptors                  }
  Result.nFileCount := 0; { # of file attachments }
  Result.lpFiles := nil; { Attachment descriptors }
end;

function TMainForm.GetOriginator: PMapiRecipDesc;
begin
  Result := nil;
  GetMem(Result, SizeOf(TMapiRecipDesc));
  Result^.ulReserved := 0;
  Result^.ulRecipClass := MAPI_ORIG;
  Result^.lpszName := From;
  Result^.lpszAddress := From;
  Result^.ulEIDSize := 0;
  Result^.lpEntryID := nil;
end;

function TMainForm.GetRecip: LPSTR;
var
  s: string;
begin
  Result := nil;
  s := Trim(ledTo.Text);
  if s <> EmptyStr then
  begin
    Result := StrNew(PAnsiChar(AnsiString(s)));
  end;
end;

function TMainForm.GetRecipient: PMapiRecipDesc;
begin
  Result := nil;
  GetMem(Result, SizeOf(TMapiRecipDesc));
  Result^.ulReserved := 0;
  Result^.ulRecipClass := MAPI_TO;
  Result^.lpszName := Recip;
  Result^.lpszAddress := Recip;
  Result^.ulEIDSize := 0;
  Result^.lpEntryID := nil;
end;

procedure TMainForm.actSendBySMTPUpdate(Sender: TObject);
begin
  actSendBySMTP.Enabled := (Trim(ledFrom.Text) <> EmptyStr) and (Trim(ledTo.Text) <> EmptyStr) and (Trim(ledSubject.Text) <> EmptyStr) and (Trim(meBody.Lines.Text) <> EmptyStr);
end;

procedure TMainForm.actSendBySMTPExecute(Sender: TObject);
begin
  IdMessage.CharSet := 'koi8-r';
  IdMessage.Body := meBody.Lines;
  IdMessage.From.Text := From;
  IdMessage.Recipients.Add;
  IdMessage.Recipients.Items[0].Address := Recip;
  IdMessage.Subject := Subject;

  IdSMTP.AuthType := satNone;
  IdSMTP.Host := 'mail.rtl.by';
  IdSMTP.Username := 'usersqlagent';
  IdSMTP.Password := 'Njhgtlf2009';
  IdSMTP.Port := 25;

//  IdSMTP.Host := 'smtp.yandex.ru';
//  IdSMTP.Port := 25;
//  IdSMTP.Username := 'caster1977';
//  IdSMTP.Password := 'grandmaster';
  IdSMTP.Connect;
  try
    if IdSMTP.Connected then
    begin
      IdSMTP.Send(IdMessage);
    end;
  finally
    if IdSMTP.Connected then
    begin
      IdSMTP.Disconnect;
    end;
  end;
end;

end.
