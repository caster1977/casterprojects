unit OA5.uTCreateMessageForm;

interface

uses
  OA5.uTOA5PositionedLogForm,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.StdCtrls;

type
  TCreateMessageForm = class(TOA5PositionedLogForm)
    ImageList: TImageList;
    actHelp: TAction;
    actClose: TAction;
    btnClose: TButton;
    btnHelp: TButton;
    reMessage: TRichEdit;
    cmbbxTo: TComboBox;
    lblTo: TLabel;
    btnSend: TButton;
    actSend: TAction;
    btnClear: TButton;
    actClear: TAction;
    edbxTheme: TEdit;
    lblTheme: TLabel;
    ActionList: TActionList;
    pnlButtons: TPanel;
    pnlMain: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actSendExecute(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
    procedure actClearUpdate(Sender: TObject);
    procedure actSendUpdate(Sender: TObject);
  strict private
    procedure _Clear;
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.uResourceStrings,
  System.SysUtils,
  Vcl.Forms,
  OA5.uTMainForm;

const
  ICON_CREATEMESSAGE = 1;

resourcestring
  RsCreateMessageForm = 'создания нового сообщения';

procedure TCreateMessageForm.actClearExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClear.Caption]), '{F78DE6D4-0164-4F4E-9DCA-0BD6FA5EB2CF}');
  _Clear;
  ProcedureFooter;
end;

procedure TCreateMessageForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{F1FBC2E1-336C-491D-BC0B-8B2E70108C6D}');
  Log.SendInfo('Попытка отправки нового сообщения была отменена пользователем.');
  CloseModalWindowWithOkResult(RsCreateMessageForm, '{6534AA5E-554C-4205-9A00-ED012CB9C24A}');
  ProcedureFooter;
end;

procedure TCreateMessageForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{800109C0-82AB-4EAC-80E9-9341BC00A650}');
  Help(HelpContext, '{C62837FE-27A8-4514-A2ED-4F01ABBAFCD3}');
  ProcedureFooter;
end;

procedure TCreateMessageForm.actSendExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actSend.Caption]), '{09170DB8-FCE2-4EF4-BD59-4E149C5F8280}');
  Log.SendInfo('Попытка отправки созданного сообщения была подтверждена пользователем.');
  CloseModalWindowWithOkResult(RsCreateMessageForm, '{6B3A55BA-2855-4E4F-A7DE-806E72AE46EB}');
  ProcedureFooter;
end;

procedure TCreateMessageForm._Clear;
begin
  ProcedureHeader('Процедура очистки полей ввода окна создания сообщения', '{CC3CBEB8-842A-44C8-A6A0-92FE911F5A4D}');

  cmbbxTo.ItemIndex := -1;
  edbxTheme.Clear;
  reMessage.Clear;
  ActiveControl := edbxTheme;
  Log.SendInfo('Поля ввода очищены пользователем.');

  ProcedureFooter;
end;

procedure TCreateMessageForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsCreateMessageForm]), '{7FD82BF2-AA3D-4AD0-848B-14E0000E9B31}');

  ImageList.GetIcon(ICON_CREATEMESSAGE, Icon);
  with MainForm.Configuration do
  begin
    // установка параметров протоколирования в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;
  end;

  ProcedureFooter;
end;

procedure TCreateMessageForm.FormShow(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsCreateMessageForm]), '{C74EFD70-4CE5-4DF6-AFCD-D946EF325B07}');
  Log.SendInfo(Format(RsWindowShowed, [RsCreateMessageForm]));
  ProcedureFooter;
end;

procedure TCreateMessageForm.actSendUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := (cmbbxTo.ItemIndex > -1) and (edbxTheme.Text <> EmptyStr) and (reMessage.Text <> EmptyStr);
  if actSend.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actSend.Caption]), '{4FBC980F-4CAF-4B64-89D3-77F33D1EA9F3}');
    actSend.Enabled := b;
    btnSend.Default := b;
    btnClose.Default := not b;
    Log.SendDebug(GetActionUpdateLogMessage(actSend));
    ProcedureFooter;
  end;
end;

procedure TCreateMessageForm.actClearUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := (cmbbxTo.ItemIndex > -1) or (edbxTheme.Text <> EmptyStr) or (reMessage.Text <> EmptyStr);
  if actClear.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actClear.Caption]), '{C0B63DD7-D5B5-4F12-A314-CB2826FBB521}');
    actClear.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actClear));
    ProcedureFooter;
  end;
end;

procedure TCreateMessageForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{876209CD-9450-437C-BECD-39568ECD2FC0}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

end.
