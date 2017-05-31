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
  cxCalendar,

  cxSpinEdit,
  Vcl.ImgList;

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
    cxlblYear: TcxLabel;
    cxspndtYear: TcxSpinEdit;
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
    procedure cxspndtYearPropertiesChange(Sender: TObject);
    procedure cxspndtYearPropertiesEditValueChanged(Sender: TObject);

  strict private
    function GetActivePage(): Integer;
    procedure SetActivePage(const AValue: Integer);
    property ActivePage: Integer read GetActivePage write SetActivePage default CONFIGURATION_DEFAULT_ACTIVE_PAGE;

  strict private
    function GetPageCount(): Integer;
    property PageCount: Integer read GetPageCount nodefault;

  strict private
    function GetYear(): Integer;
    procedure SetYear(const AValue: Integer);
    property Year: Integer read GetYear write SetYear nodefault;

  strict private
    function GetEnableQuitConfirmation(): Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation write SetEnableQuitConfirmation default CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION;

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
    property EnableStoreMainFormSizesAndPosition: Boolean read GetEnableStoreMainFormSizesAndPosition write SetEnableStoreMainFormSizesAndPosition default CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION;

  strict private
    function GetEnablePlaySoundOnComplete(): Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete write SetEnablePlaySoundOnComplete default CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE;

  public
    constructor Create(const aOwner: TComponent; const aActivePage: Integer = CONFIGURATION_DEFAULT_ACTIVE_PAGE); reintroduce; virtual;
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

uses
  System.UITypes,
  System.Math,
  System.Variants,
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  Budgeting.Logic.Classes.Configuration.Sections.TGeneralSection,
  Budgeting.Logic.Classes.Configuration.Sections.TInterfaceSection,
  Budgeting.Logic.Classes.Configuration.Sections.TOtherSection;

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

constructor TConfigurationForm.Create(const aOwner: TComponent; const aActivePage: Integer);
  procedure ApplyConfiguration();
  var
    tmpYear: Integer;
  begin
    tmpYear := TConfiguration.Get(TConfiguration).Section<TGeneralSection>.Year;
    Year := IfThen(tmpYear = 0, CurrentYear(), tmpYear);
    EnableQuitConfirmation := TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableQuitConfirmation;
    EnableSplashAtStart := TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableSplashAtStart;
    EnableStatusbar := TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStatusbar;
    EnableToolbar := TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableToolbar;
    EnableStoreMainFormSizesAndPosition := TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStoreMainFormSizesAndPosition;
  end;

begin
  inherited Create(aOwner);
  ActivePage := aActivePage;
  ApplyConfiguration();
end;

procedure TConfigurationForm.cxspndtYearPropertiesChange(Sender: TObject);
begin
  cxspndtYear.EditValue := cxspndtYear.EditingValue;
end;

procedure TConfigurationForm.cxspndtYearPropertiesEditValueChanged(Sender: TObject);
// var
// tmpCursor: TCursor;
begin
  // tmpCursor := Screen.Cursor;
  // Screen.Cursor := crHourGlass;
  // try
  // FOnEventSimple(veItemChanged);
  // finally
  // Screen.Cursor := tmpCursor;
  // end;
end;

procedure TConfigurationForm.actDefaultsExecute(Sender: TObject);
begin
  if PageControl.ActivePage = tsGeneral then
  begin
    Year := CurrentYear();
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
begin
  b := False;
  if PageControl.ActivePage = tsGeneral then
  begin
    b := not(Year = CurrentYear());
  end;
  if PageControl.ActivePage = tsInterface then
  begin
    b := not((EnableQuitConfirmation = CONFIGURATION_DEFAULT_ENABLE_QUIT_CONFIRMATION) and (EnableSplashAtStart = CONFIGURATION_DEFAULT_ENABLE_SPLASH_AT_START) and (EnableStatusbar = CONFIGURATION_DEFAULT_ENABLE_STATUSBAR) and
      (EnableToolbar = CONFIGURATION_DEFAULT_ENABLE_TOOLBAR) and (EnableStoreMainFormSizesAndPosition = CONFIGURATION_DEFAULT_ENABLE_STORE_MAINFORM_SIZES_AND_POSITION));
  end;
  if PageControl.ActivePage = tsOther then
  begin
    b := not((EnablePlaySoundOnComplete = CONFIGURATION_DEFAULT_ENABLE_PLAY_SOUND_ON_COMPLETE));
  end;
  actDefaults.Enabled := b;
end;

procedure TConfigurationForm.actApplyExecute(Sender: TObject);
begin
  TConfiguration.Get(TConfiguration).Section<TGeneralSection>.Year := Year;
  TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableQuitConfirmation := EnableQuitConfirmation;
  TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableSplashAtStart := EnableSplashAtStart;
  TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStatusbar := EnableStatusbar;
  TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableToolbar := EnableToolbar;
  TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStoreMainFormSizesAndPosition := EnableStoreMainFormSizesAndPosition;
  TConfiguration.Get(TConfiguration).Section<TOtherSection>.EnablePlaySoundOnComplete := EnablePlaySoundOnComplete;
  (TConfiguration.Get(TConfiguration) as TConfiguration).CurrentPage := ActivePage;
  ModalResult := mrOk;
end;

procedure TConfigurationForm.actApplyUpdate(Sender: TObject);
// var
// b: Boolean;
// tmpStartDate: string;
// tmpStopDate: string;
begin
  { b := False;
    if Assigned(Configuration) then
    begin
    tmpStartDate := FormatDateTime('yyyymmdd', StartDate);
    tmpStopDate := FormatDateTime('yyyymmdd', StopDate);
    b := not((TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableQuitConfirmation = EnableQuitConfirmation) and
    (TConfiguration.Get(TConfiguration).Section<TGeneralSection>.StartDate = tmpStartDate) and (TConfiguration.Get(TConfiguration).Section<TGeneralSection>.StopDate = tmpStopDate) and
    (TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableSplashAtStart = EnableSplashAtStart) and
    (TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStatusbar = EnableStatusbar) and (TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableToolbar = EnableToolbar)
    and (TConfiguration.Get(TConfiguration).Section<TInterfaceSection>.EnableStoreMainFormSizesAndPosition = EnableStoreMainFormSizesAndPosition) and
    (TConfiguration.Get(TConfiguration).Section<TOtherSection>.EnablePlaySoundOnComplete = EnablePlaySoundOnComplete));
    end;
    actApply.Enabled := b;
    btnApply.Default := b;
    btnCancel.Default := not b; }
end;

procedure TConfigurationForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TConfigurationForm.GetActivePage(): Integer;
begin
  Result := cmbPageName.ItemIndex;
end;

function TConfigurationForm.GetYear(): Integer;
begin
  Result := 0;
  if not VarIsNull(cxspndtYear.EditValue) then
  begin
    Result := cxspndtYear.EditValue;
  end;
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

procedure TConfigurationForm.SetYear(const AValue: Integer);
begin
  cxspndtYear.EditValue := AValue;
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
