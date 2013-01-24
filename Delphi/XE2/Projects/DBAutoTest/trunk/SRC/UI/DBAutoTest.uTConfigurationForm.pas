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
  DBAutoTest.uConsts,
  DBAutoTest.uIConfiguration;

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
    chkEnablePlaySoundOnComplete: TCheckBox;
    chkEnableQuitConfirmation: TCheckBox;
    chkEnableSplashAtStart: TCheckBox;
    chkEnableStatusbar: TCheckBox;
    chkEnableToolbar: TCheckBox;
    cmbPageName: TComboBox;
    gbInterface: TGroupBox;
    gbOther: TGroupBox;
    gbReport: TGroupBox;
    gbResults: TGroupBox;
    gbTop: TGroupBox;
    ImageList: TImageList;
    PageControl: TPageControl;
    pnlButtons: TPanel;
    pnlTop: TPanel;
    tsInterface: TTabSheet;
    tsOther: TTabSheet;
    tsReport: TTabSheet;
    tsResults: TTabSheet;
    procedure actCancelExecute(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actNextPageUpdate(Sender: TObject);
    procedure actPreviousPageExecute(Sender: TObject);
    procedure actPreviousPageUpdate(Sender: TObject);
    procedure cmbPageNameSelect(Sender: TObject);
  strict private
    function GetActivePage: Integer;
    function GetPageCount: Integer;
    procedure SetActivePage(const AValue: Integer);
    property PageCount: Integer read GetPageCount nodefault;
  strict private
    FConfiguration: IConfiguration;
    function GetConfiguration: IConfiguration;
    property Configuration: IConfiguration read GetConfiguration nodefault;
  public
    constructor Create(AOwner: TComponent; const AConfiguration: IConfiguration;
      const AActivePage: Integer = CONFIGURATION_DEFAULT_ACTIVE_PAGE); reintroduce; virtual;
    property ActivePage: Integer read GetActivePage write SetActivePage
      default CONFIGURATION_DEFAULT_ACTIVE_PAGE;
  strict private
    procedure SetCheckBoxState(const ACheckBox: TCheckBox; const AValue: Boolean);
  strict private
    function GetEnablePlaySoundOnComplete: Boolean;
    function GetEnableQuitConfirmation: Boolean;
    function GetEnableSplashAtStart: Boolean;
    function GetEnableStatusbar: Boolean;
    function GetEnableToolbar: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    procedure SetEnableStatusbar(const AValue: Boolean);
    procedure SetEnableToolbar(const AValue: Boolean);
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete
      write SetEnablePlaySoundOnComplete
      default CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation
      write SetEnableQuitConfirmation default CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart
      default CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar
      default CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar
      default CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
  end;

implementation

resourcestring
  RsAConfigurationIsNil = 'AConfiguration is nil.';

{$R *.dfm}

constructor TConfigurationForm.Create(AOwner: TComponent; const AConfiguration: IConfiguration;
  const AActivePage: Integer);
begin
  //Assert(Assigned(AConfiguration), RsAConfigurationIsNil);
  inherited Create(AOwner);
  FConfiguration := AConfiguration;
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

function TConfigurationForm.GetConfiguration: IConfiguration;
begin
  Result := FConfiguration;
end;

function TConfigurationForm.GetEnablePlaySoundOnComplete: Boolean;
begin
  Result := chkEnablePlaySoundOnComplete.Enabled and chkEnablePlaySoundOnComplete.Checked;
end;

function TConfigurationForm.GetEnableQuitConfirmation: Boolean;
begin
  Result := chkEnableQuitConfirmation.Enabled and chkEnableQuitConfirmation.Checked;
end;

function TConfigurationForm.GetEnableSplashAtStart: Boolean;
begin
  Result := chkEnableSplashAtStart.Enabled and chkEnableSplashAtStart.Checked;
end;

function TConfigurationForm.GetEnableStatusbar: Boolean;
begin
  Result := chkEnableStatusbar.Enabled and chkEnableStatusbar.Checked;
end;

function TConfigurationForm.GetEnableToolbar: Boolean;
begin
  Result := chkEnableToolbar.Enabled and chkEnableToolbar.Checked;
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

procedure TConfigurationForm.SetCheckBoxState(const ACheckBox: TCheckBox; const AValue: Boolean);
begin
  if ACheckBox.Checked <> AValue then
  begin
    if ACheckBox.Enabled then
    begin
      ACheckBox.Checked := AValue;
    end
    else
    begin
      ACheckBox.Checked := False;
    end;
  end;
end;

procedure TConfigurationForm.SetEnablePlaySoundOnComplete(const AValue: Boolean);
begin
  SetCheckBoxState(chkEnablePlaySoundOnComplete, AValue);
end;

procedure TConfigurationForm.SetEnableQuitConfirmation(const AValue: Boolean);
begin
  SetCheckBoxState(chkEnableQuitConfirmation, AValue);
end;

procedure TConfigurationForm.SetEnableSplashAtStart(const AValue: Boolean);
begin
  SetCheckBoxState(chkEnableSplashAtStart, AValue);
end;

procedure TConfigurationForm.SetEnableStatusbar(const AValue: Boolean);
begin
  SetCheckBoxState(chkEnableStatusbar, AValue);
end;

procedure TConfigurationForm.SetEnableToolbar(const AValue: Boolean);
begin
  SetCheckBoxState(chkEnableToolbar, AValue);
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
