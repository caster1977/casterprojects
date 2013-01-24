unit DBAutoTest.uTConfigurationForm;

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
  Vcl.ImgList,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  CastersPackage.Actions.Classes,
  Vcl.StdActns,
  System.Actions,
  Vcl.ActnList,
  DBAutoTest.uConsts;

type
  TConfigurationForm = class(TForm)
    actApply: TAction;
    actCancel: TAction;
    actDefaults: TAction_Defaults;
    actHelp: TAction_Help;
    ActionList: TActionList;
    actNextPage: TAction_NextPage;
    actPreviousPage: TAction_PreviousPage;
    btnApply: TButton;
    btnCancel: TButton;
    btnDefaults: TButton;
    btnHelp: TButton;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    cmbPageName: TComboBox;
    chkbxPlaySoundOnComplete: TCheckBox;
    chkbxShowConfirmationOnQuit: TCheckBox;
    chkbxShowSplashAtStart: TCheckBox;
    chkbxShowStatusbar: TCheckBox;
    chkbxShowToolbar: TCheckBox;
    gbInterface: TGroupBox;
    gbOther: TGroupBox;
    gbResults: TGroupBox;
    gbTop: TGroupBox;
    ImageList: TImageList;
    PageControl: TPageControl;
    pnlButtons: TPanel;
    pnlTop: TPanel;
    tsInterface: TTabSheet;
    tsOther: TTabSheet;
    tsResults: TTabSheet;
    procedure actCancelExecute(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actPreviousPageExecute(Sender: TObject);
    procedure actPreviousPageUpdate(Sender: TObject);
    procedure actNextPageUpdate(Sender: TObject);
    procedure cmbPageNameSelect(Sender: TObject);
  private
    function GetActivePage: Integer;
    procedure SetActivePage(const AValue: Integer); { TODO : убрать, выполнив рефакторинг }
    /// <summary>
    /// Свойство для управления текущей страницей окна настроек программы
    /// </summary>
    property ActivePage: Integer read GetActivePage write SetActivePage
      default CONFIGURATION_DEFAULT_ACTIVE_PAGE;
    function GetPageCount: Integer;
    property PageCount: Integer read GetPageCount nodefault;
  public
    constructor Create(AOwner: TComponent;
      const AActivePage: Integer = CONFIGURATION_DEFAULT_ACTIVE_PAGE); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

constructor TConfigurationForm.Create(AOwner: TComponent; const AActivePage: Integer);
begin
  inherited Create(AOwner);
  ActivePage := AActivePage;
end;

procedure TConfigurationForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TConfigurationForm.GetActivePage: Integer;
begin
  Result := cmbPageName.ItemIndex;
end;

function TConfigurationForm.GetPageCount: Integer;
begin
  Result := cmbPageName.Items.Count;
end;

procedure TConfigurationForm.SetActivePage(const AValue: Integer);
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

procedure TConfigurationForm.actPreviousPageUpdate(Sender: TObject);
begin
  actPreviousPage.Enabled := PageCount > 1;
end;

procedure TConfigurationForm.actNextPageExecute(Sender: TObject);
begin
  ActivePage := ActivePage + 1;
end;

procedure TConfigurationForm.actNextPageUpdate(Sender: TObject);
begin
  actNextPage.Enabled := PageCount > 1;
end;

procedure TConfigurationForm.actPreviousPageExecute(Sender: TObject);
begin
  ActivePage := ActivePage - 1;
end;

procedure TConfigurationForm.cmbPageNameSelect(Sender: TObject);
begin
  ActivePage := cmbPageName.ItemIndex;
end;

end.
