unit OA5.uTCreateMessageForm;

interface

uses
  CastersPackage.uTPositionedLogForm,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.StdCtrls;

type
  TCreateMessageForm = class(TPositionedLogForm)
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
    procedure _Help;
    procedure _Close;
    procedure _Clear;
    procedure _Send;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  Vcl.Forms,
  CastersPackage.uTLogForm,
  OA5.uTMainForm;

const
  ICON_CREATEMESSAGE = 1;

resourcestring
  RsCreateMessageForm = 'создания нового сообщения';

procedure TCreateMessageForm._Send;
begin
  ProcedureHeader(Format(RsCloseModalWithOkProcedure, [RsCreateMessageForm]), '{7BDDCBE9-E93E-4D51-A45E-6F8E532E8661}');

  ModalResult := mrOk;
  Log.SendInfo('Попытка отправки созданного сообщения была подтверждена пользователем.');
  Log.SendInfo(Format(RsWindowClosedByUser, [RsCreateMessageForm]));

  ProcedureFooter;
end;

procedure TCreateMessageForm.actClearExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClear.Caption]), '{F78DE6D4-0164-4F4E-9DCA-0BD6FA5EB2CF}');
  _Clear;
  ProcedureFooter;
end;

procedure TCreateMessageForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{F1FBC2E1-336C-491D-BC0B-8B2E70108C6D}');
  _Close;
  ProcedureFooter;
end;

procedure TCreateMessageForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{800109C0-82AB-4EAC-80E9-9341BC00A650}');
  _Help;
  ProcedureFooter;
end;

procedure TCreateMessageForm.actSendExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actSend.Caption]), '{09170DB8-FCE2-4EF4-BD59-4E149C5F8280}');
  _Send;
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

procedure TCreateMessageForm._Close;
begin
  ProcedureHeader(Format(RsCloseModalWithCancelProcedure, [RsCreateMessageForm]),
    '{FB15D7B1-D988-4AB8-952A-A407B768E1C6}');

  ModalResult := mrCancel;
  Log.SendInfo('Попытка отправки нового сообщения была отменена пользователем.');
  Log.SendInfo(Format(RsWindowClosedByUser, [RsCreateMessageForm]));
  ProcedureFooter;
end;

procedure TCreateMessageForm._Help;
begin
  ProcedureHeader(RsContextHelpProcedure, '{4C5AF0DB-D386-413F-AC80-B0E36F4F9777}');

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

procedure TCreateMessageForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsCreateMessageForm]),
    '{7FD82BF2-AA3D-4AD0-848B-14E0000E9B31}');

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
  b := (cmbbxTo.ItemIndex > -1) and (edbxTheme.Text <> EmptyStr) and (reMessage.Text <> EmptyStr);
  if actSend.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actSend.Caption]), '{4FBC980F-4CAF-4B64-89D3-77F33D1EA9F3}');
    actSend.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actSend));
    btnSend.Default := b;
    btnClose.Default := not b;
    ProcedureFooter;
  end;
end;

procedure TCreateMessageForm.actClearUpdate(Sender: TObject);
var
  b: Boolean;
begin
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
