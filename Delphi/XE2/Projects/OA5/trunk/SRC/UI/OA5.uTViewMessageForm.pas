unit OA5.uTViewMessageForm;

interface

uses
  Vcl.ExtCtrls,
  OA5.uTOA5PositionedLogForm,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ComCtrls, System.Actions;

type
  TViewMessageForm = class(TOA5PositionedLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actHelp: TAction;
    actClose: TAction;
    actDelete: TAction;
    actPrevious: TAction;
    actNext: TAction;
    actProcess: TAction;
    pnlMain: TPanel;
    lblTheme: TLabel;
    edbxTheme: TEdit;
    lblFrom: TLabel;
    edbxFrom: TEdit;
    lblWhen: TLabel;
    edbxWhen: TEdit;
    pnlButtons: TPanel;
    reMessage: TRichEdit;
    btnClose: TButton;
    btnHelp: TButton;
    btnProcess: TButton;
    btnDelete: TButton;
    btnPrevious: TButton;
    btnNext: TButton;
    procedure FormShow(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPreviousExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actProcessExecute(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
  strict private
    procedure _Delete;
    procedure _Next;
    procedure _Previous;
    procedure _Process;
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.uResourceStrings,
  Vcl.Forms,
  System.SysUtils;

resourcestring
  RsViewMessageForm = 'просмотра полученного сообщения';

const
  ICON_VIEWMESSAGE = 1;

procedure TViewMessageForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsViewMessageForm]),
    '{79ED6FCD-6B91-4FE9-8729-67067D3B5FA2}');
  ImageList.GetIcon(ICON_VIEWMESSAGE, Icon);
  ProcedureFooter;
end;

procedure TViewMessageForm.FormShow(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsViewMessageForm]),
    '{9BFE180F-1D7B-4070-AE05-291F6C449091}');
  Log.SendInfo(Format(RsWindowShowed, [RsViewMessageForm]));
  ProcedureFooter;
end;

procedure TViewMessageForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]),
    '{C51BD81D-B224-409C-9AE1-985C0263C371}');
  CloseModalWindowWithCancelResult(RsViewMessageForm, '{CEC7B0B6-5FD5-480B-A6AA-404C7922AAAB}');
  ProcedureFooter;
end;

procedure TViewMessageForm.actDeleteExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actDelete.Caption]),
    '{2E33FC92-7CA7-429D-B729-AACB73242320}');
  _Delete;
  ProcedureFooter;
end;

procedure TViewMessageForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]),
    '{C6AC5679-39E1-4FD7-81E4-79CBE93831A5}');
  Help(HelpContext, '{D5CDD891-E10A-4CD6-A006-A166E58E43AE}');
  ProcedureFooter;
end;

procedure TViewMessageForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]),
      '{ADE69D60-880D-463E-9776-5E197AD9212E}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

procedure TViewMessageForm.actNextExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actNext.Caption]),
    '{646509D5-B6E4-4BA8-ACB1-D3FC3E7D6909}');
  _Next;
  ProcedureFooter;
end;

procedure TViewMessageForm.actPreviousExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actPrevious.Caption]),
    '{F1B8E1BE-3D35-4D60-A962-1C33B0E2140E}');
  _Previous;
  ProcedureFooter;
end;

procedure TViewMessageForm.actProcessExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actProcess.Caption]),
    '{DE989347-B026-45D2-B6BA-21A502C1F8F9}');
  _Process;
  ProcedureFooter;
end;

procedure TViewMessageForm._Delete;
begin
  ProcedureHeader('Процедура удаления текущего сообщения',
    '{876CA1BB-200F-4922-9D2D-59FBCB5A2506}');

  { TODO : дописать }

  ProcedureFooter;
end;

procedure TViewMessageForm._Next;
begin
  ProcedureHeader('Процедура перехода к следущему сообщению',
    '{CEC95D15-EAE9-4A73-850C-62F7230F1813}');

  { TODO : дописать }

  ProcedureFooter;
end;

procedure TViewMessageForm._Previous;
begin
  ProcedureHeader('Процедура перехода к предыдущему сообщению',
    '{493DAAC0-4DF7-479A-84AB-7E4D79758C31}');

  { TODO : дописать }

  ProcedureFooter;
end;

procedure TViewMessageForm._Process;
begin
  ProcedureHeader('Процедура пометки сообщения как прочитанного',
    '{DAA1A662-2261-4B3A-B4F7-04A1BCEAEE09}');

  { TODO : дописать }

  ProcedureFooter;
end;

end.
