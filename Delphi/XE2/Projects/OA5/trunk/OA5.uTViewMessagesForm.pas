unit OA5.uTViewMessagesForm;

interface

uses
  CastersPackage.uTLogForm,
  System.Classes,
  Vcl.Controls,
  Vcl.ImgList,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ActnList,
  Vcl.ComCtrls;

type
  TViewMessagesForm = class(TLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actClose: TAction;
    actHelp: TAction;
    actDelete: TAction;
    actCreate: TAction;
    actOpen: TAction;
    ListView: TListView;
    pnlButtons: TPanel;
    btnCreate: TButton;
    btnView: TButton;
    btnDelete: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
  strict private
    procedure _Close;
    procedure _Help;
  end;

implementation

{$R *.dfm}

uses
  Vcl.Forms,
  CastersPackage.uRoutines,
  System.SysUtils;

resourcestring
  RsViewMessagesForm = 'просмотра полученных сообщений';

procedure TViewMessagesForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{37A8475E-6BD4-4823-94D2-8FE6965B2F7C}');
  _Close;
  ProcedureFooter;
end;

procedure TViewMessagesForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{B33612F9-C8BF-491C-8327-379CB02B0531}');
  _Help;
  ProcedureFooter;
end;

procedure TViewMessagesForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{66193937-EBE8-4A00-90AE-B0C4BCF61DD3}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

procedure TViewMessagesForm._Close;
begin
  ProcedureHeader(Format(RsCloseModalWithCancelProcedure, [RsViewMessagesForm]), '{335FD3A9-F77B-4CB0-840A-A3BF1A22FB2D}');
  ModalResult := mrCancel;
  Log.SendInfo(Format(RsWindowClosedByUser, [RsViewMessagesForm]));
  ProcedureFooter;
end;

procedure TViewMessagesForm._Help;
begin
  ProcedureHeader(RsContextHelpProcedure, '{0A6F8938-BD19-4812-9EDB-65B2CC550958}');
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

end.
