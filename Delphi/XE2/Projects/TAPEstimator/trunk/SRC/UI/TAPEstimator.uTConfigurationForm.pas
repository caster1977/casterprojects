unit TAPEstimator.uTConfigurationForm;

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
  Vcl.ActnList,
  System.Actions,
  TAPEstimator.uConsts,
  TAPEstimator.Configuration.uTConfiguration;

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
    gbTop: TGroupBox;
    ImageList: TImageList;
    PageControl: TPageControl;
    pnlButtons: TPanel;
    pnlTop: TPanel;
    tsInterface: TTabSheet;
    tsOther: TTabSheet;
    procedure actCancelExecute(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actNextPageUpdate(Sender: TObject);
    procedure actPreviousPageExecute(Sender: TObject);
    procedure actPreviousPageUpdate(Sender: TObject);
    procedure cmbPageNameSelect(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actDefaultsExecute(Sender: TObject);
    procedure actDefaultsUpdate(Sender: TObject);
    procedure actApplyUpdate(Sender: TObject);

  strict private
    function GetActivePage: Integer;
    procedure SetActivePage(const AValue: Integer);
    property ActivePage: Integer read GetActivePage write SetActivePage
      default CONFIGURATION_DEFAULT_ACTIVE_PAGE;

  strict private
    function GetPageCount: Integer;
    property PageCount: Integer read GetPageCount nodefault;

  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration: TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;

  public
    constructor Create(AOwner: TComponent; const AConfiguration: TConfiguration;
      const AActivePage: Integer = CONFIGURATION_DEFAULT_ACTIVE_PAGE); reintroduce; virtual;

  strict private
    function GetEnablePlaySoundOnComplete: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete
      write SetEnablePlaySoundOnComplete
      default CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;

  strict private
    function GetEnableQuitConfirmation: Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation
      write SetEnableQuitConfirmation default CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;

  strict private
    function GetEnableSplashAtStart: Boolean;
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart
      default CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;

  strict private
    function GetEnableStatusbar: Boolean;
    procedure SetEnableStatusbar(const AValue: Boolean);
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar
      default CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;

  strict private
    function GetEnableToolbar: Boolean;
    procedure SetEnableToolbar(const AValue: Boolean);
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar
      default CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
  end;

implementation

uses
  CastersPackage.uRoutines,
  TAPEstimator.Configuration.uTInterfaceSection,
  TAPEstimator.Configuration.uTOtherSection;

resourcestring
  RsAConfigurationIsNil = 'AConfiguration is nil.';

{$R *.dfm}

constructor TConfigurationForm.Create(AOwner: TComponent; const AConfiguration: TConfiguration;
  const AActivePage: Integer);

  procedure ApplyConfiguration;
  begin
    if Assigned(Configuration) then
    begin
      EnableQuitConfirmation := Configuration.Section<TInterfaceSection>.EnableQuitConfirmation;
      EnableSplashAtStart := Configuration.Section<TInterfaceSection>.EnableSplashAtStart;
      EnableStatusbar := Configuration.Section<TInterfaceSection>.EnableStatusbar;
      EnableToolbar := Configuration.Section<TInterfaceSection>.EnableToolbar;
      EnablePlaySoundOnComplete := Configuration.Section<TOtherSection>.EnablePlaySoundOnComplete;
    end;
  end;

begin
  Assert(Assigned(AConfiguration), RsAConfigurationIsNil);
  inherited Create(AOwner);
  ActivePage := AActivePage;
  FConfiguration := AConfiguration;
  ApplyConfiguration;
end;

procedure TConfigurationForm.actDefaultsExecute(Sender: TObject);
begin
  if PageControl.ActivePage = tsInterface then
  begin
    EnableQuitConfirmation := CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
    EnableSplashAtStart := CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
    EnableStatusbar := CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
    EnableToolbar := CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
  end;
  if PageControl.ActivePage = tsOther then
  begin
    EnablePlaySoundOnComplete := CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;
  end;
end;

procedure TConfigurationForm.actDefaultsUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if PageControl.ActivePage = tsInterface then
  begin
    b := not((EnableQuitConfirmation = CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION) and
      (EnableSplashAtStart = CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START) and
      (EnableStatusbar = CONFIGURATION_DEFAULT_ENABLE_STATUSBAR) and
      (EnableToolbar = CONFIGURATION_DEFAULT_ENABLE_TOOLBAR));
  end;
  if PageControl.ActivePage = tsOther then
  begin
    b := not(EnablePlaySoundOnComplete = CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE);
  end;
  actDefaults.Enabled := b;
end;

procedure TConfigurationForm.actApplyExecute(Sender: TObject);
begin
  if Assigned(Configuration) then
  begin
    Configuration.Section<TInterfaceSection>.EnableQuitConfirmation := EnableQuitConfirmation;
    Configuration.Section<TInterfaceSection>.EnableSplashAtStart := EnableSplashAtStart;
    Configuration.Section<TInterfaceSection>.EnableStatusbar := EnableStatusbar;
    Configuration.Section<TInterfaceSection>.EnableToolbar := EnableToolbar;
    Configuration.Section<TOtherSection>.EnablePlaySoundOnComplete := EnablePlaySoundOnComplete;
  end;
  ModalResult := mrOk;
end;

procedure TConfigurationForm.actApplyUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := False;
  if Assigned(Configuration) then
  begin
    b := not((Configuration.Section<TOtherSection>.EnablePlaySoundOnComplete =
      EnablePlaySoundOnComplete) and
      (Configuration.Section<TInterfaceSection>.EnableQuitConfirmation = EnableQuitConfirmation) and
      (Configuration.Section<TInterfaceSection>.EnableSplashAtStart = EnableSplashAtStart) and
      (Configuration.Section<TInterfaceSection>.EnableStatusbar = EnableStatusbar) and
      (Configuration.Section<TInterfaceSection>.EnableToolbar = EnableToolbar));
  end;
  actApply.Enabled := b;
  btnApply.Default := b;
  btnCancel.Default := not b;
end;

procedure TConfigurationForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TConfigurationForm.GetActivePage: Integer;
begin
  Result := cmbPageName.ItemIndex;
end;

function TConfigurationForm.GetConfiguration: TConfiguration;
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

procedure TConfigurationForm.SetEnablePlaySoundOnComplete(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnablePlaySoundOnComplete, AValue);
end;

procedure TConfigurationForm.SetEnableQuitConfirmation(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableQuitConfirmation, AValue);
end;

procedure TConfigurationForm.SetEnableSplashAtStart(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableSplashAtStart, AValue);
end;

procedure TConfigurationForm.SetEnableStatusbar(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableStatusbar, AValue);
end;

procedure TConfigurationForm.SetEnableToolbar(const AValue: Boolean);
begin
  Routines.SetCheckBoxState(chkEnableToolbar, AValue);
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
