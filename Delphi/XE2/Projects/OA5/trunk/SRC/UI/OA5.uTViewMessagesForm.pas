unit OA5.uTViewMessagesForm;

interface

uses
  Vcl.ComCtrls,
  OA5.uTOA5PositionedLogForm,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TViewMessagesForm = class(TOA5PositionedLogForm)
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
  end;

implementation

{$R *.dfm}

uses
  Vcl.Forms,
  System.SysUtils,
  CastersPackage.uResourceStrings;

resourcestring
  RsViewMessagesForm = 'просмотра полученных сообщений';

procedure TViewMessagesForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{37A8475E-6BD4-4823-94D2-8FE6965B2F7C}');
  CloseModalWindowWithCancelResult(RsViewMessagesForm, '{36E905AB-B82A-4DCF-B459-F22973FD0B8D}');
  ProcedureFooter;
end;

procedure TViewMessagesForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{B33612F9-C8BF-491C-8327-379CB02B0531}');
  Help(HelpContext, '{87D37E94-9189-4786-90B4-DF122F140089}');
  ProcedureFooter;
end;

procedure TViewMessagesForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{66193937-EBE8-4A00-90AE-B0C4BCF61DD3}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

end.
