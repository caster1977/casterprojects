unit Budgeting.UI.Configuration;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  System.Actions,
  Vcl.ActnList,
  Budgeting.Logic.Consts,
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  Vcl.Samples.Spin,
  Vcl.ImgList,
  Vcl.StdActns,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  dxCore,
  cxDateUtils,
  cxLabel,
  cxTextEdit,
  cxMaskEdit,
  cxDropDownEdit,
  cxCalendar;

type
  TConfigurationForm = class(TForm)
    actApply: TAction;
    actCancel: TAction;
    ActionList: TActionList;
    btnApply: TButton;
    btnCancel: TButton;
    btnDefaults: TButton;
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
    PageControl: TPageControl;
    pnlButtons: TPanel;
    pnlTop: TPanel;
    tsInterface: TTabSheet;
    tsOther: TTabSheet;
    chkEnableStoreMainFormSizesAndPosition: TCheckBox;
    ImageList: TImageList;
    actDefaults: TAction;
    actPreviousPage: TAction;
    actNextPage: TAction;
    tsGeneral: TTabSheet;
    cxdtdtStartDate: TcxDateEdit;
    lblStartDate: TcxLabel;
    lblStopDate: TcxLabel;
    cxdtdtStopDate: TcxDateEdit;
    procedure actCancelExecute(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actNextPageUpdate(Sender: TObject);
    procedure actPreviousPageExecute(Sender: TObject);
    procedure actPreviousPageUpdate(Sender: TObject);
    procedure cmbPageNameSelect(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actApplyUpdate(Sender: TObject);
    procedure actDefaultsExecute(Sender: TObject);
    procedure actDefaultsUpdate(Sender: TObject);

  strict private
    function GetActivePage(): Integer;
    procedure SetActivePage(const AValue: Integer);
    property ActivePage: Integer read GetActivePage write SetActivePage default CONFIGURATION_DEFAULT_ACTIVE_PAGE;

  strict private
    function GetPageCount(): Integer;
    property PageCount: Integer read GetPageCount nodefault;

  strict private
    FConfiguration: TConfiguration;
    function GetConfiguration(): TConfiguration;
    property Configuration: TConfiguration read GetConfiguration nodefault;

  strict private
    function GetStartDate(): TDateTime;
    procedure SetStartDate(const AValue: TDateTime);
    property StartDate: TDateTime read GetStartDate write SetStartDate nodefault;

  strict private
    function GetStopDate(): TDateTime;
    procedure SetStopDate(const AValue: TDateTime);
    property StopDate: TDateTime read GetStopDate write SetStopDate nodefault;

  strict private
    function GetEnableQuitConfirmation(): Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation write SetEnableQuitConfirmation
      default CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;

  strict private
    function GetEnableSplashAtStart(): Boolean;
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart default CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;

  strict private
    function GetEnableStatusbar(): Boolean;
    procedure SetEnableStatusbar(const AValue: Boolean);
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar default CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;

  strict private
    function GetEnableToolbar(): Boolean;
    procedure SetEnableToolbar(const AValue: Boolean);
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar default CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;

  strict private
    function GetEnableStoreMainFormSizesAndPosition(): Boolean;
    procedure SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
    property EnableStoreMainFormSizesAndPosition: Boolean read GetEnableStoreMainFormSizesAndPosition write SetEnableStoreMainFormSizesAndPosition
      default CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;

  strict private
    function GetEnablePlaySoundOnComplete(): Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete write SetEnablePlaySoundOnComplete
      default CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;

  public
    constructor Create(const aOwner: TComponent; const aConfiguration: TConfiguration; const aActivePage: Integer = CONFIGURATION_DEFAULT_ACTIVE_PAGE);
      reintroduce; virtual;
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

uses
  System.UITypes,
  Budgeting.Logic.Classes.Configuration.Section.TGeneral,
  Budgeting.Logic.Classes.Configuration.Section.TInterface,
  Budgeting.Logic.Classes.Configuration.Section.TOther;

resourcestring
  RsAConfigurationIsNil = 'aConfiguration is nil.';

  {$R *.dfm}

procedure SetCheckBoxState(const aCheckBox: TCheckBox; const AValue: Boolean);
begin
  if aCheckBox.Checked <> AValue then
  begin
    aCheckBox.Checked := AValue and aCheckBox.Enabled;
  end;
end;

constructor TConfigurationForm.Create(const aOwner: TComponent; const aConfiguration: TConfiguration; const aActivePage: Integer);
  procedure ApplyConfiguration();
  begin
    if Assigned(Configuration) then
    begin
      StartDate := EncodeDate(Configuration.Section<TGeneral>.StartDate.Substring(0, 4).ToInteger(),
        Configuration.Section<TGeneral>.StartDate.Substring(4, 2).ToInteger(), Configuration.Section<TGeneral>.StartDate.Substring(6, 2)
        .ToInteger());
      StopDate := EncodeDate(Configuration.Section<TGeneral>.StopDate.Substring(0, 4).ToInteger(),
        Configuration.Section<TGeneral>.StopDate.Substring(4, 2).ToInteger(), Configuration.Section<TGeneral>.StopDate.Substring(6, 2)
        .ToInteger());
      EnableQuitConfirmation := Configuration.Section<TInterface>.EnableQuitConfirmation;
      EnableSplashAtStart := Configuration.Section<TInterface>.EnableSplashAtStart;
      EnableStatusbar := Configuration.Section<TInterface>.EnableStatusbar;
      EnableToolbar := Configuration.Section<TInterface>.EnableToolbar;
      EnableStoreMainFormSizesAndPosition := Configuration.Section<TInterface>.EnableStoreMainFormSizesAndPosition;
    end;
  end;

begin
//  Assert(Assigned(aConfiguration), RsAConfigurationIsNil);
  inherited Create(aOwner);
  ActivePage := aActivePage;
  FConfiguration := aConfiguration;
  ApplyConfiguration();
end;

procedure TConfigurationForm.actDefaultsExecute(Sender: TObject);
var
  tmpDate: TDateTime;
begin
  if PageControl.ActivePage = tsGeneral then
  begin
    tmpDate := Date();
    StartDate := tmpDate;
    StopDate := tmpDate;
  end;
  if PageControl.ActivePage = tsInterface then
  begin
    EnableQuitConfirmation := CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;
    EnableSplashAtStart := CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START;
    EnableStatusbar := CONFIGURATION_DEFAULT_ENABLE_STATUSBAR;
    EnableToolbar := CONFIGURATION_DEFAULT_ENABLE_TOOLBAR;
    EnableStoreMainFormSizesAndPosition := CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;
  end;
  if PageControl.ActivePage = tsOther then
  begin
    EnablePlaySoundOnComplete := CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;
  end;
end;

procedure TConfigurationForm.actDefaultsUpdate(Sender: TObject);
var
  b: Boolean;
  tmpDate: string;
begin
  {b := False;
  if PageControl.ActivePage = tsGeneral then
  begin
    tmpDate := FormatDateTime('yyyymmdd', Date());
    b := not((Configuration.Section<TGeneralSection>.StartDate = tmpDate) and (Configuration.Section<TGeneralSection>.StopDate = tmpDate));
  end;
  if PageControl.ActivePage = tsInterface then
  begin
    b := not((EnableQuitConfirmation = CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION) and (EnableSplashAtStart = CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START)
      and (EnableStatusbar = CONFIGURATION_DEFAULT_ENABLE_STATUSBAR) and (EnableToolbar = CONFIGURATION_DEFAULT_ENABLE_TOOLBAR) and
      (EnableStoreMainFormSizesAndPosition = CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION));
  end;
  if PageControl.ActivePage = tsOther then
  begin
    b := not((EnablePlaySoundOnComplete = CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE));
  end;
  actDefaults.Enabled := b;}
end;

procedure TConfigurationForm.actApplyExecute(Sender: TObject);
begin
  if Assigned(Configuration) then
  begin
    Configuration.Section<TGeneral>.StartDate := FormatDateTime('yyyymmdd', StartDate);
    Configuration.Section<TGeneral>.StopDate := FormatDateTime('yyyymmdd', StopDate);
    Configuration.Section<TInterface>.EnableQuitConfirmation := EnableQuitConfirmation;
    Configuration.Section<TInterface>.EnableSplashAtStart := EnableSplashAtStart;
    Configuration.Section<TInterface>.EnableStatusbar := EnableStatusbar;
    Configuration.Section<TInterface>.EnableToolbar := EnableToolbar;
    Configuration.Section<TInterface>.EnableStoreMainFormSizesAndPosition := EnableStoreMainFormSizesAndPosition;
    Configuration.Section<TOther>.EnablePlaySoundOnComplete := EnablePlaySoundOnComplete;
    Configuration.CurrentPage := ActivePage;
  end;
  ModalResult := mrOk;
end;

procedure TConfigurationForm.actApplyUpdate(Sender: TObject);
var
  b: Boolean;
  tmpStartDate: string;
  tmpStopDate: string;
begin
  {b := False;
  if Assigned(Configuration) then
  begin
    tmpStartDate := FormatDateTime('yyyymmdd', StartDate);
    tmpStopDate := FormatDateTime('yyyymmdd', StopDate);
    b := not((Configuration.Section<TInterfaceSection>.EnableQuitConfirmation = EnableQuitConfirmation) and
      (Configuration.Section<TGeneralSection>.StartDate = tmpStartDate) and (Configuration.Section<TGeneralSection>.StopDate = tmpStopDate) and
      (Configuration.Section<TInterfaceSection>.EnableSplashAtStart = EnableSplashAtStart) and
      (Configuration.Section<TInterfaceSection>.EnableStatusbar = EnableStatusbar) and (Configuration.Section<TInterfaceSection>.EnableToolbar = EnableToolbar)
      and (Configuration.Section<TInterfaceSection>.EnableStoreMainFormSizesAndPosition = EnableStoreMainFormSizesAndPosition) and
      (Configuration.Section<TOtherSection>.EnablePlaySoundOnComplete = EnablePlaySoundOnComplete));
  end;
  actApply.Enabled := b;
  btnApply.Default := b;
  btnCancel.Default := not b;}
end;

procedure TConfigurationForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TConfigurationForm.GetActivePage(): Integer;
begin
  Result := cmbPageName.ItemIndex;
end;

function TConfigurationForm.GetStartDate(): TDateTime;
begin
  Result := cxdtdtStartDate.EditValue;
end;

function TConfigurationForm.GetConfiguration(): TConfiguration;
begin
  Result := FConfiguration;
end;

function TConfigurationForm.GetEnablePlaySoundOnComplete(): Boolean;
begin
  Result := chkEnablePlaySoundOnComplete.Enabled and chkEnablePlaySoundOnComplete.Checked;
end;

function TConfigurationForm.GetEnableQuitConfirmation(): Boolean;
begin
  Result := chkEnableQuitConfirmation.Enabled and chkEnableQuitConfirmation.Checked;
end;

function TConfigurationForm.GetEnableSplashAtStart(): Boolean;
begin
  Result := chkEnableSplashAtStart.Enabled and chkEnableSplashAtStart.Checked;
end;

function TConfigurationForm.GetEnableStatusbar(): Boolean;
begin
  Result := chkEnableStatusbar.Enabled and chkEnableStatusbar.Checked;
end;

function TConfigurationForm.GetEnableStoreMainFormSizesAndPosition(): Boolean;
begin
  Result := chkEnableStoreMainFormSizesAndPosition.Enabled and chkEnableStoreMainFormSizesAndPosition.Checked;
end;

function TConfigurationForm.GetEnableToolbar(): Boolean;
begin
  Result := chkEnableToolbar.Enabled and chkEnableToolbar.Checked;
end;

function TConfigurationForm.GetStopDate(): TDateTime;
begin
  Result := cxdtdtStopDate.EditValue;
end;

function TConfigurationForm.GetPageCount(): Integer;
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
    i := Pred(PageCount);
  end;
  if i > Pred(PageCount) then
  begin
    i := 0;
  end;
  if cmbPageName.ItemIndex <> i then
  begin
    cmbPageName.ItemIndex := i;
  end;

  for i := 0 to Pred(PageControl.PageCount) do
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

procedure TConfigurationForm.SetStartDate(const AValue: TDateTime);
begin
  cxdtdtStartDate.EditValue := AValue;
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

procedure TConfigurationForm.SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
begin
  SetCheckBoxState(chkEnableStoreMainFormSizesAndPosition, AValue);
end;

procedure TConfigurationForm.SetEnableToolbar(const AValue: Boolean);
begin
  SetCheckBoxState(chkEnableToolbar, AValue);
end;

procedure TConfigurationForm.SetStopDate(const AValue: TDateTime);
begin
  cxdtdtStopDate.EditValue := AValue;
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

procedure TConfigurationForm.SetEnablePlaySoundOnComplete(const AValue: Boolean);
begin
  SetCheckBoxState(chkEnablePlaySoundOnComplete, AValue);
end;

end.
