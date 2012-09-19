unit OA5.uTPhoneListForm;

interface

uses
  Vcl.Controls,
  OA5.uTOA5PositionedLogForm,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ActnList,
  Vcl.ComCtrls,
  System.Classes,
  Vcl.ImgList;

type
  TPhoneListForm = class(TOA5PositionedLogForm)
    pnlButtons: TPanel;
    btnCreate: TButton;
    btnEdit: TButton;
    btnHelp: TButton;
    btnDelete: TButton;
    btnClose: TButton;
    btnConnect: TButton;
    btnVoice: TButton;
    ListView1: TListView;
    ActionList: TActionList;
    ImageList: TImageList;
    actCreate: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actHelp: TAction;
    actClose: TAction;
    actConnect: TAction;
    actVoice: TAction;
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses
  Vcl.Forms,
  System.SysUtils,
  CastersPackage.uResourceStrings;

const
  ICON_PHONELIST = 0;

resourcestring
  RsPhoneListForm = 'просмотра списка телефонов';

procedure TPhoneListForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{2BF0A9D9-668B-4004-B672-8F5E90E874DA}');
  CloseModalWindowWithCancelResult(RsPhoneListForm, '{501A0C5C-6051-4FE2-B530-E7A88692E69B}');
  ProcedureFooter;
end;

procedure TPhoneListForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{AEBE97C7-DE36-498B-964A-0F15E903572F}');
  Help(HelpContext, '{FA41C5EC-B7F8-4026-8040-56B5AAC85A84}');
  ProcedureFooter;
end;

procedure TPhoneListForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{14DF31FC-912A-49B3-9FB0-C713F5EDC2C5}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

procedure TPhoneListForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsPhoneListForm]), '{DD0698E8-EC58-42A2-9178-3CEF2182E39D}');
  ImageList.GetIcon(ICON_PHONELIST, Icon);
  ProcedureFooter;
end;

end.
