{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
unit uConfigurationForm;

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
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.ImgList,
  Vcl.ComCtrls;

type
  TConfigurationForm=class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnDefaults: TButton;
    ilConfigurationFormSmallImages: TImageList;
    ActionManager1: TActionManager;
    Action_Defaults: TAction;
    Action_Apply: TAction;
    Action_Close: TAction;
    Action_Help: TAction;
    pnlBrowse: TPanel;
    gbHeader: TGroupBox;
    cbPage: TComboBox;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    pnlPage: TPanel;
    gbPage: TGroupBox;
    PageControl1: TPageControl;
    ts1: TTabSheet;
    ts3: TTabSheet;
    ts4: TTabSheet;
    ts5: TTabSheet;
    Action_PreviousPage: TAction;
    Action_NextPage: TAction;
    ts2: TTabSheet;
    chkbxShowSplashAtStart: TCheckBox;
    chkbxShowStatusbar: TCheckBox;
    chkbxShowConfirmationOnQuit: TCheckBox;
    chkbxScrollLogToBottom: TCheckBox;
    lblWatchPause: TLabel;
    edbxWatchPauseValue: TEdit;
    edbxRetranslatorPauseValue: TEdit;
    lblRetranslatorPause: TLabel;
    edbxDestinationFolderValue: TEdit;
    btnDestinationFolder: TButton;
    lblDestinationFolder: TLabel;
    chkbxPlaySoundOnComplete: TCheckBox;
    chkbxKeepInfoLog: TCheckBox;
    chkbxKeepWarningLog: TCheckBox;
    chkbxKeepErrorLog: TCheckBox;
    chkbxKeepDebugLog: TCheckBox;
    lblMainForm: TLabel;
    lblConfigurationForm: TLabel;
    Bevel1: TBevel;
    lblMainFormLeft: TLabel;
    edbxMainFormLeftValue: TEdit;
    lblMainFormTop: TLabel;
    edbxMainFormTopValue: TEdit;
    chkbxMainFormCentered: TCheckBox;
    lblMainFormWidth: TLabel;
    lblMainFormHeight: TLabel;
    edbxMainFormWidthValue: TEdit;
    edbxMainFormHeightValue: TEdit;
    chkbxMainFormMaximized: TCheckBox;
    lblConfigurationFormLeft: TLabel;
    edbxConfigurationFormLeftValue: TEdit;
    lblConfigurationFormTop: TLabel;
    edbxConfigurationFormTopValue: TEdit;
    chkbxConfigurationFormCentered: TCheckBox;
    Action_ChooseDestinationFolder: TAction;
    lblSharedMemSize: TLabel;
    edbxSharedMemSizeValue: TEdit;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_PreviousPageExecute(Sender: TObject);
    procedure Action_NextPageExecute(Sender: TObject);
    procedure Action_DefaultsExecute(Sender: TObject);
    procedure cbPageSelect(Sender: TObject);
    procedure Action_ChooseDestinationFolderExecute(Sender: TObject);
    procedure edbxNumericFieldKeyPress(Sender: TObject; var Key: Char);
    procedure chkbxConfigurationFormCenteredClick(Sender: TObject);
    procedure chkbxMainFormCenteredClick(Sender: TObject);
    procedure chkbxMainFormMaximizedClick(Sender: TObject);
    procedure edbxSharedMemSizeValueChange(Sender: TObject);
  strict private
    procedure Do_PageSelect;
    procedure Do_Help;
    procedure Do_Close;
    procedure Do_Defaults;
    procedure Do_Apply;
    procedure Do_NextPage;
    procedure Do_PreviousPage;
    procedure Do_ChooseDestinationFolder;
    procedure Do_UpdateActions;
  end;

implementation

{$R *.dfm}

uses
  uMainForm,
  uCommon,
  uCommonConfigurationClass,
  uConfigurationClass,
  Vcl.FileCtrl;

procedure TConfigurationForm.Action_ApplyExecute(Sender: TObject);
begin
  Do_Apply;
end;

procedure TConfigurationForm.Action_ChooseDestinationFolderExecute(Sender: TObject);
begin
  Do_ChooseDestinationFolder;
end;

procedure TConfigurationForm.Action_CloseExecute(Sender: TObject);
begin
  Do_Close;
end;

procedure TConfigurationForm.Action_DefaultsExecute(Sender: TObject);
begin
  Do_Defaults;
end;

procedure TConfigurationForm.Action_HelpExecute(Sender: TObject);
begin
  Do_Help;
end;

procedure TConfigurationForm.Action_NextPageExecute(Sender: TObject);
begin
  Do_NextPage;
end;

procedure TConfigurationForm.Action_PreviousPageExecute(Sender: TObject);
begin
  Do_PreviousPage;
end;

procedure TConfigurationForm.cbPageSelect(Sender: TObject);
begin
  Do_PageSelect;
end;

procedure TConfigurationForm.chkbxConfigurationFormCenteredClick(Sender: TObject);
var
  b: boolean;
begin
  b:=chkbxConfigurationFormCentered.Enabled and chkbxConfigurationFormCentered.Checked;
  edbxConfigurationFormLeftValue.Enabled:=not b;
  edbxConfigurationFormTopValue.Enabled:=not b;
  if b then
    begin
      edbxConfigurationFormLeftValue.Text:='';
      edbxConfigurationFormTopValue.Text:='';
    end
  else
    begin
      edbxConfigurationFormLeftValue.Text:=IntToStr((Screen.WorkAreaWidth-Width)div 2);
      edbxConfigurationFormTopValue.Text:=IntToStr((Screen.WorkAreaHeight-Height)div 2);
    end;
  MainForm.LogDebug(Format(TEXT_CHECKBOX_SWITCHED, [chkbxConfigurationFormCentered.Caption, CommonFunctions.GetConditionalString(b, TEXT_CHECKBOX_ON, TEXT_CHECKBOX_OFF)]));
end;

procedure TConfigurationForm.chkbxMainFormCenteredClick(Sender: TObject);
var
  bMainFormCentered: boolean;
begin
  bMainFormCentered:=chkbxMainFormCentered.Checked and chkbxMainFormCentered.Enabled;
  edbxMainFormLeftValue.Enabled:=not bMainFormCentered;
  edbxMainFormTopValue.Enabled:=not bMainFormCentered;
  edbxMainFormLeftValue.Text:=CommonFunctions.GetConditionalString(edbxMainFormLeftValue.Enabled, IntToStr(MainForm.Configuration.MainFormPosition.Left), '');
  edbxMainFormTopValue.Text:=CommonFunctions.GetConditionalString(edbxMainFormTopValue.Enabled, IntToStr(MainForm.Configuration.MainFormPosition.Top), '');

  MainForm.LogDebug(Format(TEXT_CHECKBOX_SWITCHED, [chkbxMainFormCentered.Caption, CommonFunctions.GetConditionalString(bMainFormCentered, TEXT_CHECKBOX_ON, TEXT_CHECKBOX_OFF)]));
end;

procedure TConfigurationForm.chkbxMainFormMaximizedClick(Sender: TObject);
var
  bMainFormMaximized: boolean;
begin
  bMainFormMaximized:=chkbxMainFormMaximized.Checked and chkbxMainFormMaximized.Enabled;
  chkbxMainFormCentered.Enabled:=not bMainFormMaximized;
  chkbxMainFormCentered.Checked:=chkbxMainFormCentered.Checked and(not bMainFormMaximized);
  edbxMainFormLeftValue.Enabled:=(not bMainFormMaximized)and(not chkbxMainFormCentered.Checked);
  edbxMainFormTopValue.Enabled:=(not bMainFormMaximized)and(not chkbxMainFormCentered.Checked);
  edbxMainFormWidthValue.Enabled:=not bMainFormMaximized;
  edbxMainFormHeightValue.Enabled:=not bMainFormMaximized;

  edbxMainFormLeftValue.Text:=CommonFunctions.GetConditionalString(edbxMainFormLeftValue.Enabled, IntToStr(MainForm.Configuration.MainFormPosition.Left), '');
  edbxMainFormTopValue.Text:=CommonFunctions.GetConditionalString(edbxMainFormTopValue.Enabled, IntToStr(MainForm.Configuration.MainFormPosition.Top), '');
  edbxMainFormWidthValue.Text:=CommonFunctions.GetConditionalString(not bMainFormMaximized, IntToStr(MainForm.Configuration.MainFormPosition.Width), '');
  edbxMainFormHeightValue.Text:=CommonFunctions.GetConditionalString(not bMainFormMaximized, IntToStr(MainForm.Configuration.MainFormPosition.Height), '');

  MainForm.LogDebug(Format(TEXT_CHECKBOX_SWITCHED, [chkbxMainFormCentered.Caption, CommonFunctions.GetConditionalString(bMainFormMaximized, TEXT_CHECKBOX_ON, TEXT_CHECKBOX_OFF)]));
end;

procedure TConfigurationForm.Do_Apply;
var
  FormPosition: TFormPosition;
begin
  ModalResult:=mrOk;
  MainForm.LogInfo(TEXT_CONFIGURATION_SAVING_CONFIRMED_BY_USER);

  with MainForm.Configuration do
    begin
      ShowSplashAtStart:=chkbxShowSplashAtStart.Enabled and chkbxShowSplashAtStart.Checked;
      ShowStatusbar:=chkbxShowStatusbar.Enabled and chkbxShowStatusbar.Checked;
      ScrollLogToBottom:=chkbxScrollLogToBottom.Enabled and chkbxScrollLogToBottom.Checked;
      ShowConfirmationOnQuit:=chkbxShowConfirmationOnQuit.Enabled and chkbxShowConfirmationOnQuit.Checked;

      if chkbxKeepErrorLog.Enabled and chkbxKeepErrorLog.Checked then
        KeepLogTypes:=KeepLogTypes+[lmtError]
      else
        KeepLogTypes:=KeepLogTypes-[lmtError];
      if chkbxKeepWarningLog.Enabled and chkbxKeepWarningLog.Checked then
        KeepLogTypes:=KeepLogTypes+[lmtWarning]
      else
        KeepLogTypes:=KeepLogTypes-[lmtWarning];
      if chkbxKeepInfoLog.Enabled and chkbxKeepInfoLog.Checked then
        KeepLogTypes:=KeepLogTypes+[lmtInfo]
      else
        KeepLogTypes:=KeepLogTypes-[lmtInfo];
      if chkbxKeepDebugLog.Enabled and chkbxKeepDebugLog.Checked then
        KeepLogTypes:=KeepLogTypes+[lmtDebug]
      else
        KeepLogTypes:=KeepLogTypes-[lmtDebug];

      FormPosition.Centered:=chkbxMainFormCentered.Enabled and chkbxMainFormCentered.Checked and(not(chkbxMainFormMaximized.Enabled and chkbxMainFormMaximized.Checked));
      FormPosition.Maximized:=chkbxMainFormMaximized.Enabled and chkbxMainFormMaximized.Checked;
      if chkbxMainFormMaximized.Enabled and chkbxMainFormMaximized.Checked then
        begin
          FormPosition.Left:=Screen.WorkAreaLeft;
          FormPosition.Top:=Screen.WorkAreaTop;
          FormPosition.Width:=Screen.WorkAreaWidth;
          FormPosition.Height:=Screen.WorkAreaHeight;
        end
      else
        if chkbxMainFormCentered.Enabled and chkbxMainFormCentered.Checked then
          begin
            if edbxMainFormWidthValue.Enabled then
              FormPosition.Width:=StrToIntDef(Trim(edbxMainFormWidthValue.Text), CONST_DEFAULTVALUE_MAINFORM_WIDTH)
            else
              FormPosition.Width:=CONST_DEFAULTVALUE_MAINFORM_WIDTH;
            if edbxMainFormHeightValue.Enabled then
              FormPosition.Height:=StrToIntDef(Trim(edbxMainFormHeightValue.Text), CONST_DEFAULTVALUE_MAINFORM_HEIGHT)
            else
              FormPosition.Height:=CONST_DEFAULTVALUE_MAINFORM_HEIGHT;
            FormPosition.Left:=(Screen.WorkAreaWidth-FormPosition.Width)div 2;
            FormPosition.Top:=(Screen.WorkAreaHeight-FormPosition.Height)div 2;
          end
        else
          begin
            if edbxMainFormLeftValue.Enabled then
              FormPosition.Left:=StrToIntDef(Trim(edbxMainFormLeftValue.Text), CONST_DEFAULTVALUE_MAINFORM_LEFT)
            else
              FormPosition.Left:=CONST_DEFAULTVALUE_MAINFORM_LEFT;
            if edbxMainFormTopValue.Enabled then
              FormPosition.Top:=StrToIntDef(Trim(edbxMainFormTopValue.Text), CONST_DEFAULTVALUE_MAINFORM_TOP)
            else
              FormPosition.Top:=CONST_DEFAULTVALUE_MAINFORM_TOP;
            if edbxMainFormWidthValue.Enabled then
              FormPosition.Width:=StrToIntDef(Trim(edbxMainFormWidthValue.Text), CONST_DEFAULTVALUE_MAINFORM_WIDTH)
            else
              FormPosition.Width:=CONST_DEFAULTVALUE_MAINFORM_WIDTH;
            if edbxMainFormHeightValue.Enabled then
              FormPosition.Height:=StrToIntDef(Trim(edbxMainFormHeightValue.Text), CONST_DEFAULTVALUE_MAINFORM_HEIGHT)
            else
              FormPosition.Height:=CONST_DEFAULTVALUE_MAINFORM_HEIGHT;
          end;
      MainFormPosition:=FormPosition;
      FormPosition.Centered:=chkbxConfigurationFormCentered.Checked and chkbxConfigurationFormCentered.Enabled;
      FormPosition.Left:=StrToIntDef(CommonFunctions.GetConditionalString(not FormPosition.Centered, Trim(edbxConfigurationFormLeftValue.Text), ''), CONST_DEFAULTVALUE_FORMPOSITION_LEFT);
      FormPosition.Top:=StrToIntDef(CommonFunctions.GetConditionalString(not FormPosition.Centered, Trim(edbxConfigurationFormTopValue.Text), ''), CONST_DEFAULTVALUE_FORMPOSITION_TOP);
      ConfigurationFormPosition:=FormPosition;

      PlaySoundOnComplete:=chkbxPlaySoundOnComplete.Enabled and chkbxPlaySoundOnComplete.Checked;
      WatchPause:=StrToIntDef(Trim(edbxWatchPauseValue.Text), CONST_DEFAULTVALUE_WATCHPAUSE);
      RetranslatorPause:=StrToIntDef(Trim(edbxRetranslatorPauseValue.Text), CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
      SharedMemSize:=StrToIntDef(Trim(edbxSharedMemSizeValue.Text), CONST_DEFAULTVALUE_SHAREDMEMSIZE);

      DestinationFolder:=Trim(edbxDestinationFolderValue.Text);
    end;

  MainForm.LogInfo(TEXT_CONFIGURATION_WINDOW_CLOSED);
end;

procedure TConfigurationForm.Do_ChooseDestinationFolder;
resourcestring
  TEXT_CHOOSE_FOLDER='Выберите папку';
  TEXT_SELECTED_FOLDER='В качестве папки для сохранения отчётов выбрана папка "%s".';
  TEXT_SELECTED_FOLDER_ERROR='Возникла ошибка при выборе папки - указанная папка не существует!';
var
  sPath: string;
  sErrorMessage: string;
  bError: boolean;
begin
  bError:=False;

  sPath:=Trim(edbxDestinationFolderValue.Text);
  if sPath='' then
    sPath:=IncludeTrailingPathDelimiter(ExtractFilePath(ExpandFileName(Application.ExeName)));
  if Win32MajorVersion>=6 then // для Vista и выше
    with TFileOpenDialog.Create(Self) do
      try
        Title:=TEXT_CHOOSE_FOLDER;
        DefaultFolder:=sPath;
        FileName:=sPath;
        Options:=[fdoPickFolders, fdoPathMustExist, fdoForceFileSystem];
        if Execute then
          edbxDestinationFolderValue.Text:=IncludeTrailingPathDelimiter(FileName);
      finally
        Free;
      end
  else // для XP и ниже
    if SelectDirectory(TEXT_CHOOSE_FOLDER, '', sPath, [sdNewFolder, sdNewUI, sdShowEdit, sdShowShares], Self) then
      if (sPath<>'') then
        begin
          sPath:=IncludeTrailingPathDelimiter(sPath);
          if System.SysUtils.DirectoryExists(sPath) then
            begin
              edbxDestinationFolderValue.Text:=sPath;
              MainForm.LogDebug(Format(TEXT_SELECTED_FOLDER, [sPath]));
            end
          else
            begin
              edbxDestinationFolderValue.Text:='';
              CommonFunctions.GenerateError(TEXT_SELECTED_FOLDER_ERROR, sErrorMessage, bError);
            end;
        end;
  Do_UpdateActions;

  MainForm.ProcessErrors(Handle, bError, sErrorMessage);
end;

procedure TConfigurationForm.Do_Close;
begin
  ModalResult:=mrClose;
  MainForm.LogInfo(TEXT_CONFIGURATION_SAVING_ABORTED_BY_USER);
  MainForm.LogInfo(TEXT_CONFIGURATION_WINDOW_CLOSED);
end;

procedure TConfigurationForm.Do_Defaults;
begin
  // вкладка "настройки интерфейса"
  if PageControl1.ActivePage.Caption=TEXT_CONFIGURATION_PAGE_INTERFACE then
    begin
      chkbxShowSplashAtStart.Checked:=CONST_DEFAULTVALUE_SHOWSPLASHATSTART;
      chkbxShowStatusbar.Checked:=CONST_DEFAULTVALUE_SHOWSTATUSBAR;
      chkbxScrollLogToBottom.Checked:=CONST_DEFAULTVALUE_SCROLLLOGTOBOTTOM;
      chkbxShowConfirmationOnQuit.Checked:=CONST_DEFAULTVALUE_SHOWCONFIRMATIONONQUIT;
    end;
  // вкладка "настройки расположения файлов и папок"
  if PageControl1.ActivePage.Caption=TEXT_CONFIGURATION_PAGE_LOCATION then
    begin
      edbxDestinationFolderValue.Text:=CONST_DEFAULTVALUE_DESTINATIONFOLDER;
      Do_UpdateActions;
    end;
  // вкладка "настройки ведения протокола работы"
  if PageControl1.ActivePage.Caption=TEXT_CONFIGURATION_PAGE_LOG then
    begin
      chkbxKeepInfoLog.Checked:=lmtInfo in CONST_DEFAULTVALUE_KEEPLOGTYPES;
      chkbxKeepWarningLog.Checked:=lmtWarning in CONST_DEFAULTVALUE_KEEPLOGTYPES;
      chkbxKeepErrorLog.Checked:=lmtError in CONST_DEFAULTVALUE_KEEPLOGTYPES;
      chkbxKeepDebugLog.Checked:=lmtDebug in CONST_DEFAULTVALUE_KEEPLOGTYPES;
    end;
  // вкладка "настройки положения и размеров окон"
  if PageControl1.ActivePage.Caption=TEXT_CONFIGURATION_PAGE_WINDOW_SIZES then
    begin
      chkbxMainFormMaximized.Checked:=CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED;
      chkbxMainFormCentered.Checked:=CONST_DEFAULTVALUE_MAINFORM_CENTERED and(not CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED);
      edbxMainFormLeftValue.Text:=CommonFunctions.GetConditionalString(not(CONST_DEFAULTVALUE_MAINFORM_CENTERED or CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED), IntToStr(CONST_DEFAULTVALUE_MAINFORM_LEFT), '');
      edbxMainFormTopValue.Text:=CommonFunctions.GetConditionalString(not(CONST_DEFAULTVALUE_MAINFORM_CENTERED or CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED), IntToStr(CONST_DEFAULTVALUE_MAINFORM_TOP), '');
      edbxMainFormWidthValue.Text:=CommonFunctions.GetConditionalString(CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED, '', IntToStr(CONST_DEFAULTVALUE_MAINFORM_WIDTH));
      edbxMainFormHeightValue.Text:=CommonFunctions.GetConditionalString(CONST_DEFAULTVALUE_MAINFORM_MAXIMIZED, '', IntToStr(CONST_DEFAULTVALUE_MAINFORM_HEIGHT));

      chkbxConfigurationFormCentered.Checked:=CONST_DEFAULTVALUE_FORMPOSITION_CENTERED;
      edbxConfigurationFormLeftValue.Text:=CommonFunctions.GetConditionalString(CONST_DEFAULTVALUE_FORMPOSITION_CENTERED, '', IntToStr(CONST_DEFAULTVALUE_FORMPOSITION_LEFT));
      edbxConfigurationFormTopValue.Text:=CommonFunctions.GetConditionalString(CONST_DEFAULTVALUE_FORMPOSITION_CENTERED, '', IntToStr(CONST_DEFAULTVALUE_FORMPOSITION_TOP));
      edbxConfigurationFormLeftValue.Enabled:=not CONST_DEFAULTVALUE_FORMPOSITION_CENTERED;
      edbxConfigurationFormTopValue.Enabled:=not CONST_DEFAULTVALUE_FORMPOSITION_CENTERED;
    end;
  // вкладка "настройки прочие"
  if PageControl1.ActivePage.Caption=TEXT_CONFIGURATION_PAGE_OTHER then
    begin
      chkbxPlaySoundOnComplete.Checked:=CONST_DEFAULTVALUE_PLAYSOUNDONCOMPLETE;
      edbxWatchPauseValue.Text:=IntToStr(CONST_DEFAULTVALUE_WATCHPAUSE);
      edbxRetranslatorPauseValue.Text:=IntToStr(CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
      edbxSharedMemSizeValue.Text:=IntToStr(CONST_DEFAULTVALUE_SHAREDMEMSIZE);
    end;
  MainForm.LogInfo(Format(TEXT_CONFIGURATION_VALUES_SETTED_TO_DEFAULTS, [PageControl1.ActivePage.Caption]));
end;

procedure TConfigurationForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  MainForm.LogInfo(TEXT_HELP_FILE_OPENING);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    CommonFunctions.GenerateError(TEXT_HELP_FILE_NOT_FOUND, sErrorMessage, bError);

  MainForm.ProcessErrors(Handle, bError, sErrorMessage);
end;

procedure TConfigurationForm.Do_NextPage;
var
  i: integer;
begin
  i:=cbPage.ItemIndex+1;
  if i>cbPage.Items.Count-1 then
    i:=0;
  cbPage.ItemIndex:=i;
  Do_PageSelect;
end;

procedure TConfigurationForm.Do_PageSelect;
var
  i: integer;
begin
  for i:=0 to PageControl1.PageCount-1 do
    if PageControl1.Pages[i].Caption=cbPage.Items[cbPage.ItemIndex] then
      PageControl1.ActivePageIndex:=i;
end;

procedure TConfigurationForm.Do_PreviousPage;
var
  i: integer;
begin
  i:=cbPage.ItemIndex-1;
  if i<0 then
    i:=cbPage.Items.Count-1;
  cbPage.ItemIndex:=i;
  Do_PageSelect;
end;

procedure TConfigurationForm.Do_UpdateActions;
begin
  edbxDestinationFolderValue.Enabled:=edbxDestinationFolderValue.Text<>'';
end;

procedure TConfigurationForm.edbxNumericFieldKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0;
end;

procedure TConfigurationForm.edbxSharedMemSizeValueChange(Sender: TObject);
var
  i: integer;
begin
  i:=StrToIntDef(edbxSharedMemSizeValue.Text, CONST_DEFAULTVALUE_SHAREDMEMSIZE);
  if i>CONST_DEFAULTVALUE_SHAREDMEMSIZE then
    edbxSharedMemSizeValue.Text:=IntToStr(CONST_DEFAULTVALUE_SHAREDMEMSIZE);
end;

procedure TConfigurationForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  MainForm.Configuration.ConfigurationFormPage:=cbPage.ItemIndex;
end;

procedure TConfigurationForm.FormCreate(Sender: TObject);
const
  ICON_CONFIGURATION=3;
begin
  ilConfigurationFormSmallImages.GetIcon(ICON_CONFIGURATION, Icon);

  with cbPage do
    begin
      Clear;
      with Items do
        begin
          Append(TEXT_CONFIGURATION_PAGE_INTERFACE);
          Append(TEXT_CONFIGURATION_PAGE_LOCATION);
          Append(TEXT_CONFIGURATION_PAGE_LOG);
          Append(TEXT_CONFIGURATION_PAGE_WINDOW_SIZES);
          Append(TEXT_CONFIGURATION_PAGE_OTHER);
        end;
    end;

  Action_Help.Enabled:=Application.HelpFile<>'';
  MainForm.LogDebug(Format(TEXT_ACTION_SWITCHED, [Action_Help.Caption, CommonFunctions.GetConditionalString(Action_Help.Enabled, TEXT_ACTION_ON, TEXT_ACTION_OFF)]));

  with MainForm.Configuration do
    begin
      if ConfigurationFormPosition.Centered then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if ConfigurationFormPosition.Left<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if ConfigurationFormPosition.Left>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=ConfigurationFormPosition.Left;
          if ConfigurationFormPosition.Top<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if ConfigurationFormPosition.Top>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=ConfigurationFormPosition.Top;
        end;

      chkbxShowSplashAtStart.Checked:=ShowSplashAtStart;
      chkbxShowStatusbar.Checked:=ShowStatusbar;
      chkbxScrollLogToBottom.Checked:=ScrollLogToBottom;
      chkbxShowConfirmationOnQuit.Checked:=ShowConfirmationOnQuit;

      chkbxKeepErrorLog.Checked:=lmtError in KeepLogTypes;
      chkbxKeepWarningLog.Checked:=lmtWarning in KeepLogTypes;
      chkbxKeepInfoLog.Checked:=lmtInfo in KeepLogTypes;
      chkbxKeepDebugLog.Checked:=lmtDebug in KeepLogTypes;

      chkbxMainFormMaximized.Checked:=MainForm.WindowState=wsMaximized;
      chkbxMainFormCentered.Checked:=MainForm.Position=poScreenCenter;
      edbxMainFormLeftValue.Text:=CommonFunctions.GetConditionalString(not((MainForm.Position=poScreenCenter)or(MainForm.WindowState=wsMaximized)), IntToStr(MainForm.Left), '');
      edbxMainFormTopValue.Text:=CommonFunctions.GetConditionalString(not((MainForm.Position=poScreenCenter)or(MainForm.WindowState=wsMaximized)), IntToStr(MainForm.Top), '');
      edbxMainFormWidthValue.Text:=CommonFunctions.GetConditionalString(MainForm.WindowState=wsMaximized, '', IntToStr(MainForm.Width));
      edbxMainFormHeightValue.Text:=CommonFunctions.GetConditionalString(MainForm.WindowState=wsMaximized, '', IntToStr(MainForm.Height));

      chkbxConfigurationFormCentered.Checked:=ConfigurationFormPosition.Centered;
      edbxConfigurationFormLeftValue.Text:=CommonFunctions.GetConditionalString(ConfigurationFormPosition.Centered, '', IntToStr(ConfigurationFormPosition.Left));
      edbxConfigurationFormTopValue.Text:=CommonFunctions.GetConditionalString(ConfigurationFormPosition.Centered, '', IntToStr(ConfigurationFormPosition.Top));
      edbxConfigurationFormLeftValue.Enabled:=not ConfigurationFormPosition.Centered;
      edbxConfigurationFormTopValue.Enabled:=not ConfigurationFormPosition.Centered;

      edbxDestinationFolderValue.Text:=DestinationFolder;

      chkbxPlaySoundOnComplete.Checked:=PlaySoundOnComplete;
      edbxWatchPauseValue.Text:=IntToStr(WatchPause);
      edbxRetranslatorPauseValue.Text:=IntToStr(RetranslatorPause);
      edbxSharedMemSizeValue.Text:=IntToStr(SharedMemSize);
    end;
  cbPage.ItemIndex:=MainForm.Configuration.ConfigurationFormPage;
  Do_PageSelect;
  Do_UpdateActions;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
begin
  MainForm.LogInfo(TEXT_CONFIGURATION_WINDOW_SHOWED);
end;

end.
