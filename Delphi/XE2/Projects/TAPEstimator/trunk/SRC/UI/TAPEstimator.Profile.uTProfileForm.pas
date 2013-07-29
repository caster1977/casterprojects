unit TAPEstimator.Profile.uTProfileForm;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.StdActns,
  CastersPackage.Actions.Classes,
  System.Actions,
  Vcl.ActnList,
  Data.DB,
  Data.Win.ADODB,
  Vcl.Mask,
  Vcl.ComCtrls,
  Vcl.ImgList,
  TAPEstimator.uConsts;

type
  TProfileForm = class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    btnDefaults: TButton;
    btnHelp: TButton;
    ActionList: TActionList;
    actApply: TAction;
    actCancel: TAction;
    actHelp: TAction_Help;
    actTestConnection: TAction;
    actUseWinNTSecurity: TAction;
    gbTop: TGroupBox;
    cmbPageName: TComboBox;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    PageControl: TPageControl;
    ImageList: TImageList;
    actDefaults: TAction_Defaults;
    actPreviousPage: TAction_PreviousPage;
    actNextPage: TAction_NextPage;
    pnlTop: TPanel;
    actUseLoginAndPassword: TAction;
    actEnablePasswordSaving: TAction;
    actEnableEmptyPassword: TAction;
    actRefreshServers: TAction;
    tsConnection: TTabSheet;
    gbConnection: TGroupBox;
    procedure actCancelExecute(Sender: TObject);
    procedure actPreviousPageExecute(Sender: TObject);
    procedure actPreviousPageUpdate(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actNextPageUpdate(Sender: TObject);
    procedure cmbPageNameSelect(Sender: TObject);
  strict private
    function GetActivePage: Integer;
    procedure SetActivePage(const AValue: Integer);
    function GetPageCount: Integer;
    property PageCount: Integer read GetPageCount nodefault;
  public
    constructor Create(AOwner: TComponent;
      const AActivePage: Integer = PROFILE_DEFAULT_ACTIVE_PAGE); reintroduce; virtual;
    property ActivePage: Integer read GetActivePage write SetActivePage
      default PROFILE_DEFAULT_ACTIVE_PAGE;
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.UNetSrvList;

constructor TProfileForm.Create(AOwner: TComponent; const AActivePage: Integer);
begin
  inherited Create(AOwner);
  ActivePage := AActivePage;
end;

procedure TProfileForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TProfileForm.actNextPageExecute(Sender: TObject);
begin
  ActivePage := ActivePage + 1;
end;

procedure TProfileForm.actNextPageUpdate(Sender: TObject);
begin
  actNextPage.Enabled := PageCount > 1;
end;

procedure TProfileForm.actPreviousPageExecute(Sender: TObject);
begin
  ActivePage := ActivePage - 1;
end;

procedure TProfileForm.actPreviousPageUpdate(Sender: TObject);
begin
  actPreviousPage.Enabled := PageCount > 1;
end;

function TProfileForm.GetActivePage: Integer;
begin
  Result := cmbPageName.ItemIndex;
end;

function TProfileForm.GetPageCount: Integer;
begin
  Result := cmbPageName.Items.Count;
end;

procedure TProfileForm.SetActivePage(const AValue: Integer);
var
  i: Integer;
begin
  i := AValue;
  if i < 0 then
  begin
    i := PageCount - 1;
  end;
  if i > PageCount - 1 then
  begin
    i := 0;
  end;
  if cmbPageName.ItemIndex <> i then
  begin
    cmbPageName.ItemIndex := i;
  end;

  for i := 0 to PageControl.PageCount - 1 do
  begin
    if PageControl.Pages[i].Caption = cmbPageName.Items[cmbPageName.ItemIndex] then
    begin
      if PageControl.ActivePageIndex <> i then
      begin
        PageControl.ActivePageIndex := i;
      end;
      Break;
    end;
  end;
end;

procedure TProfileForm.cmbPageNameSelect(Sender: TObject);
begin
  ActivePage := cmbPageName.ItemIndex;
end;

end.
