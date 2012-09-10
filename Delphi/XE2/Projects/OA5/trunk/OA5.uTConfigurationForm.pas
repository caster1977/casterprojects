{$WARN UNIT_PLATFORM OFF}
unit OA5.uTConfigurationForm;

interface

uses
  CastersPackage.uTPositionedLogForm,
  Winapi.Windows,
  System.Types,
  System.Classes,
  Vcl.PlatformDefaultStyleActnCtrls,
  CastersPackage.uTLogMessagesType,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.ActnList,
  Vcl.ActnMan,
  Vcl.Grids,
  Vcl.StdCtrls,
  Vcl.ValEdit,
  Vcl.Forms,
  Vcl.ExtCtrls,
  Vcl.ComCtrls;

type
  TConfigurationForm = class(TPositionedLogForm)
    actHelp: TAction;
    actDefaults: TAction;
    actClose: TAction;
    actApply: TAction;
    actPreviousPage: TAction;
    actNextPage: TAction;
    actChooseCustomLogClientFile: TAction;
    ImageListSmall: TImageList;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnDefaults: TButton;
    Panel3: TPanel;
    gbHeader: TGroupBox;
    cbPage: TComboBox;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    Panel1: TPanel;
    gbPage: TGroupBox;
    PageControl1: TPageControl;
    ts1: TTabSheet;
    ts4: TTabSheet;
    lblFlushLog: TLabel;
    Bevel1: TBevel;
    lblShowData: TLabel;
    Bevel2: TBevel;
    chkbxKeepInfoLog: TCheckBox;
    chkbxKeepWarningLog: TCheckBox;
    chkbxKeepErrorLog: TCheckBox;
    chkbxKeepSQLLog: TCheckBox;
    chkbxFlushLogOnStringsQuantity: TCheckBox;
    chkbxFlushLogOnExit: TCheckBox;
    edbxFlushLogOnStringsQuantityValue: TEdit;
    chkbxFlushLogOnClearingLog: TCheckBox;
    chkbxFlushLogOnApply: TCheckBox;
    chkbxKeepDebugLog: TCheckBox;
    ts5: TTabSheet;
    Bevel3: TBevel;
    rbSaveIntoTheTempFolder: TRadioButton;
    rbSaveIntoTheCustomFolder: TRadioButton;
    rbSaveIntoTheApplicationFolder: TRadioButton;
    chkbxAskForFileName: TCheckBox;
    edbxCustomReportFolderValue: TEdit;
    btnSelectFolder: TButton;
    chkbxDontDemandOverwriteConfirmation: TCheckBox;
    ts2: TTabSheet;
    vleRNE4SERVER: TValueListEditor;
    ts3: TTabSheet;
    vleRNE4MESSAGESSERVER: TValueListEditor;
    chkbxCustomLogClientFile: TCheckBox;
    edbxCustomLogClientFileValue: TEdit;
    btnChooseCustomLogClientFile: TButton;
    actChooseReportFolder: TAction;
    chkbxEnableLog: TCheckBox;
    Bevel4: TBevel;
    Bevel5: TBevel;
    ts6: TTabSheet;
    sgAutoReplaceList: TStringGrid;
    btnLineUp: TButton;
    btnLineDown: TButton;
    actLineUp: TAction;
    actLineDown: TAction;
    lblAutoReplaceSorry: TLabel;
    ts9: TTabSheet;
    ts7: TTabSheet;
    chkbxStoreLastLogin: TCheckBox;
    chkbxStoreLastPassword: TCheckBox;
    chkbxAutoLogon: TCheckBox;
    chkbxEnableAutoGetMessages: TCheckBox;
    edbxAutoGetMessagesCycleDurationValue: TEdit;
    lblAutoGetMessagesCycleDuration: TLabel;
    ts8: TTabSheet;
    ScrollBox1: TScrollBox;
    lblLoginFormPosition: TLabel;
    lblLoginFormPositionX: TLabel;
    edbxLoginFormPositionX: TEdit;
    lblLoginFormPositionY: TLabel;
    edbxLoginFormPositionY: TEdit;
    chkbxLoginFormPositionByCenter: TCheckBox;
    lblConfigurationFormPosition: TLabel;
    lblConfigurationFormPositionX: TLabel;
    edbxConfigurationFormPositionX: TEdit;
    lblConfigurationFormPositionY: TLabel;
    edbxConfigurationFormPositionY: TEdit;
    chkbxConfigurationFormPositionByCenter: TCheckBox;
    lblUsersFormPosition: TLabel;
    lblUsersFormPositionX: TLabel;
    edbxUsersFormPositionX: TEdit;
    lblUsersFormPositionY: TLabel;
    edbxUsersFormPositionY: TEdit;
    chkbxUsersFormPositionByCenter: TCheckBox;
    lblSetPasswordFormPosition: TLabel;
    lblSetPasswordFormPositionX: TLabel;
    edbxSetPasswordFormPositionX: TEdit;
    lblSetPasswordFormPositionY: TLabel;
    edbxSetPasswordFormPositionY: TEdit;
    chkbxSetPasswordFormPositionByCenter: TCheckBox;
    lblReportFormPosition: TLabel;
    lblReportFormPositionX: TLabel;
    edbxReportFormPositionX: TEdit;
    lblReportFormPositionY: TLabel;
    edbxReportFormPositionY: TEdit;
    chkbxReportFormPositionByCenter: TCheckBox;
    lblMaintenanceFormPosition: TLabel;
    lblMaintenanceFormPositionX: TLabel;
    edbxMaintenanceFormPositionX: TEdit;
    lblMaintenanceFormPositionY: TLabel;
    edbxMaintenanceFormPositionY: TEdit;
    chkbxMaintenanceFormPositionByCenter: TCheckBox;
    lblClearingFormPosition: TLabel;
    lblClearingFormPositionX: TLabel;
    edbxClearingFormPositionX: TEdit;
    lblClearingFormPositionY: TLabel;
    edbxClearingFormPositionY: TEdit;
    chkbxClearingFormPositionByCenter: TCheckBox;
    lblViewMessagesFormPosition: TLabel;
    lblViewMessagesFormPositionX: TLabel;
    lblViewMessagesFormPositionY: TLabel;
    edbxViewMessagesFormPositionX: TEdit;
    edbxViewMessagesFormPositionY: TEdit;
    chkbxViewMessagesFormPositionByCenter: TCheckBox;
    lblViewMessageFormPosition: TLabel;
    lblViewMessageFormPositionX: TLabel;
    lblViewMessageFormPositionY: TLabel;
    edbxViewMessageFormPositionX: TEdit;
    edbxViewMessageFormPositionY: TEdit;
    chkbxViewMessageFormPositionByCenter: TCheckBox;
    lblPhonesFormPosition: TLabel;
    lblPhonesFormPositionX: TLabel;
    lblPhonesFormPositionY: TLabel;
    edbxPhonesFormPositionX: TEdit;
    edbxPhonesFormPositionY: TEdit;
    chkbxPhonesFormPositionByCenter: TCheckBox;
    lblAddEditPhoneFormPosition: TLabel;
    lblAddEditPhoneFormPositionX: TLabel;
    edbxAddEditPhoneFormPositionX: TEdit;
    lblAddEditPhoneFormPositionY: TLabel;
    edbxAddEditPhoneFormPositionY: TEdit;
    chkbxAddEditPhoneFormPositionByCenter: TCheckBox;
    lblAddMassMsrFormPosition: TLabel;
    lblAddMassMsrFormPositionX: TLabel;
    lblAddMassMsrFormPositionY: TLabel;
    edbxAddMassMsrFormPositionX: TEdit;
    edbxAddMassMsrFormPositionY: TEdit;
    chkbxAddMassMsrFormPositionByCenter: TCheckBox;
    ts10: TTabSheet;
    lblMainFormPosition: TLabel;
    lblMainFormSize: TLabel;
    lblMainFormPositionX: TLabel;
    edbxMainFormPositionX: TEdit;
    lblMainFormPositionY: TLabel;
    edbxMainFormPositionY: TEdit;
    chkbxMainFormPositionByCenter: TCheckBox;
    lblMainFormWidth: TLabel;
    edbxMainFormWidth: TEdit;
    lblMainFormHeight: TLabel;
    edbxMainFormHeight: TEdit;
    chkbxFullScreenAtLaunch: TCheckBox;
    ts11: TTabSheet;
    lbOrganizationPanelHeight: TLabel;
    lbDataPanelWidth: TLabel;
    edbxOrganizationPanelHeightValue: TEdit;
    edbxDataPanelWidthValue: TEdit;
    chkbxOrganizationPanelHalfHeight: TCheckBox;
    chkbxDataPanelHalfWidth: TCheckBox;
    chkbxShowDataInOtherInfoPanel: TCheckBox;
    chkbxShowMeasuresListAsRichEdit: TCheckBox;
    chkbxMarkSearchedStrings: TCheckBox;
    chkbxPutTownAtTheEnd: TCheckBox;
    chkbxCustomHelpFile: TCheckBox;
    edbxCustomHelpFileValue: TEdit;
    btnChooseCustomHelpFile: TButton;
    chkbxLaunchAtStartup: TCheckBox;
    chkbxShowSplashAtStart: TCheckBox;
    chkbxShowToolbar: TCheckBox;
    chkbxShowStatusbar: TCheckBox;
    chkbxShowEditboxHints: TCheckBox;
    chkbxShowCommonSearchEditbox: TCheckBox;
    chkbxShowID: TCheckBox;
    chkbxUseMultibuffer: TCheckBox;
    chkbxShowConfirmationOnQuit: TCheckBox;
    chkbxPlaySoundOnComplete: TCheckBox;
    actChooseCustomHelpFile: TAction;
    lblPermissionsFormPosition: TLabel;
    lblPermissionsFormPositionX: TLabel;
    edbxPermissionsFormPositionX: TEdit;
    lblPermissionsFormPositionY: TLabel;
    edbxPermissionsFormPositionY: TEdit;
    chkbxPermissionsFormPositionByCenter: TCheckBox;
    lblCreateMessageFormPosition: TLabel;
    lblCreateMessageFormPositionX: TLabel;
    lblCreateMessageFormPositionY: TLabel;
    edbxCreateMessageFormPositionX: TEdit;
    edbxCreateMessageFormPositionY: TEdit;
    chkbxCreateMessageFormPositionByCenter: TCheckBox;
    ActionList: TActionList;
    procedure FormCreate(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actDefaultsExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actPreviousPageExecute(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actChooseReportFolderExecute(Sender: TObject);
    procedure actChooseCustomLogClientFileExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cbPageSelect(Sender: TObject);
    procedure chkbxCustomLogClientFileClick(Sender: TObject);
    procedure chkbxEnableLogClick(Sender: TObject);
    procedure chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
    procedure rbSaveIntoTheCustomFolderClick(Sender: TObject);
    procedure chkbxStoreLastLoginClick(Sender: TObject);
    procedure chkbxStoreLastPasswordClick(Sender: TObject);
    procedure chkbxEnableAutoGetMessagesClick(Sender: TObject);
    procedure edbxAutoGetMessagesCycleDurationValueChange(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure chkbxMainFormPositionByCenterClick(Sender: TObject);
    procedure chkbxFullScreenAtLaunchClick(Sender: TObject);
    procedure actChooseCustomHelpFileExecute(Sender: TObject);
    procedure chkbxCustomHelpFileClick(Sender: TObject);
    procedure chkbxOrganizationPanelHalfHeightClick(Sender: TObject);
    procedure chkbxDataPanelHalfWidthClick(Sender: TObject);
    procedure chkbxLoginFormPositionByCenterClick(Sender: TObject);
    procedure chkbxConfigurationFormPositionByCenterClick(Sender: TObject);
    procedure chkbxUsersFormPositionByCenterClick(Sender: TObject);
    procedure chkbxSetPasswordFormPositionByCenterClick(Sender: TObject);
    procedure chkbxReportFormPositionByCenterClick(Sender: TObject);
    procedure chkbxMaintenanceFormPositionByCenterClick(Sender: TObject);
    procedure chkbxClearingFormPositionByCenterClick(Sender: TObject);
    procedure chkbxViewMessagesFormPositionByCenterClick(Sender: TObject);
    procedure chkbxCreateMessageFormPositionByCenterClick(Sender: TObject);
    procedure chkbxPhonesFormPositionByCenterClick(Sender: TObject);
    procedure chkbxAddEditPhoneFormPositionByCenterClick(Sender: TObject);
    procedure chkbxAddMassMsrFormPositionByCenterClick(Sender: TObject);
    procedure chkbxPermissionsFormPositionByCenterClick(Sender: TObject);
    procedure edbxNumericFieldKeyPress(Sender: TObject; var Key: Char);
    procedure chkbxViewMessageFormPositionByCenterClick(Sender: TObject);
  strict private
    FBooleanValuesList: TStringList;
    procedure Do_Help;
    procedure Do_Defaults;
    procedure Do_Close;
    procedure Do_Apply;
    procedure Do_NextPage;
    procedure Do_PreviousPage;
    procedure Do_ChooseCustomReportFolder;
    procedure Do_ChooseLogClientFile;
    procedure Do_ChooseCustomHelpFile;
    procedure Do_PageSelect;
  private
    procedure CreateBooleanValuesList;
  end;

implementation

{$R *.dfm}

uses
  OA5.uDefaultConsts,
  CastersPackage.uTReportFolder,
  Vcl.Dialogs,
  System.SysUtils,
  CastersPackage.uTLogForm,
  Winapi.Messages,
  Vcl.FileCtrl,
  CastersPackage.uLogKeeperData,
  CastersPackage.uRoutines,
  CastersPackage.uTDialogPosition,
  OA5.uMainForm,
  OA5.uTLoginForm,
  OA5.uTAboutForm,
  OA5.uTAddMassMsrForm,
  OA5.uTSetPasswordForm,
  OA5.uPermissionsForm,
  OA5.uReportForm,
  OA5.uTConfiguration,
  OA5.uTCreateMessageForm,
  OA5.uTViewMessageForm,
  OA5.uTViewMessagesForm,
  OA5.uTAddEditPhoneForm;

procedure TConfigurationForm.actApplyExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actApply.Caption + '"', '{84DDCA84-3467-43EB-9005-E35C20FD98D0}');
  Do_Apply;
  ProcedureFooter;
end;

procedure TConfigurationForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actClose.Caption + '"', '{609A88EE-6BC8-4F0F-9C3D-EC1D6FD1A50F}');
  Do_Close;
  ProcedureFooter;
end;

procedure TConfigurationForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actHelp.Caption + '"', '{0CB39D36-EC59-4C76-AFE5-1718B99DA0CA}');
  Do_Help;
  ProcedureFooter;
end;

procedure TConfigurationForm.actPreviousPageExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actPreviousPage.Caption + '"',
    '{50728BC6-7E7C-4D0D-9C17-E7919DE4A4C3}');
  Do_PreviousPage;
  ProcedureFooter;
end;

procedure TConfigurationForm.actNextPageExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actNextPage.Caption + '"',
    '{0D4FC270-5B1E-4E59-8EBF-89ADBAC0E89F}');
  Do_NextPage;
  ProcedureFooter;
end;

procedure TConfigurationForm.actChooseReportFolderExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actChooseReportFolder.Caption + '"',
    '{0F2D97AB-C59D-456A-ABCA-C390806F896C}');
  Do_ChooseCustomReportFolder;
  ProcedureFooter;
end;

procedure TConfigurationForm.actChooseCustomHelpFileExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actChooseCustomHelpFile.Caption + '"',
    '{708E3642-722E-4556-9774-2F813BD540ED}');
  Do_ChooseCustomHelpFile;
  ProcedureFooter;
end;

procedure TConfigurationForm.actChooseCustomLogClientFileExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actChooseReportFolder.Caption + '"',
    '{24E77954-BFEB-4128-B764-C31ED26D068C}');
  Do_ChooseLogClientFile;
  ProcedureFooter;
end;

procedure TConfigurationForm.actDefaultsExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "' + actDefaults.Caption + '"',
    '{9B790597-F8F3-47A8-96FE-472EFFB6020E}');
  Do_Defaults;
  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Apply;
var
  dialog_position: TDialogPosition;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{55D9E5EB-97B6-47FC-B149-348070521077}');

  ModalResult := mrOk;
  Log.SendInfo('Попытка изменения настроек программы была подтверждена пользователем.');

  with MainForm.Configuration do
  begin
    // вкладка "настройки интерфейса"
    ShowSplashAtStart := chkbxShowSplashAtStart.Enabled and chkbxShowSplashAtStart.Checked;
    ShowToolbar := chkbxShowToolbar.Enabled and chkbxShowToolbar.Checked;
    ShowStatusbar := chkbxShowStatusbar.Enabled and chkbxShowStatusbar.Checked;
    ShowEditboxHints := chkbxShowEditboxHints.Enabled and chkbxShowEditboxHints.Checked;
    ShowCommonSearchEditbox := chkbxShowCommonSearchEditbox.Enabled and chkbxShowCommonSearchEditbox.Checked;
    ShowID := chkbxShowID.Enabled and chkbxShowID.Checked;
    UseMultibuffer := chkbxUseMultibuffer.Enabled and chkbxUseMultibuffer.Checked;
    ShowConfirmationOnQuit := chkbxShowConfirmationOnQuit.Enabled and chkbxShowConfirmationOnQuit.Checked;

    // вкладка "настройки ведения протокола работы"
    EnableLog := chkbxEnableLog.Enabled and chkbxEnableLog.Checked;

    if EnableLog and chkbxKeepErrorLog.Enabled and chkbxKeepErrorLog.Checked then
    begin
      KeepLogTypes := KeepLogTypes + [lmtError];
    end
    else
    begin
      KeepLogTypes := KeepLogTypes - [lmtError];
    end;

    if EnableLog and chkbxKeepWarningLog.Enabled and chkbxKeepWarningLog.Checked then
    begin
      KeepLogTypes := KeepLogTypes + [lmtWarning];
    end
    else
    begin
      KeepLogTypes := KeepLogTypes - [lmtWarning];
    end;

    if EnableLog and chkbxKeepInfoLog.Enabled and chkbxKeepInfoLog.Checked then
    begin
      KeepLogTypes := KeepLogTypes + [lmtInfo];
    end
    else
    begin
      KeepLogTypes := KeepLogTypes - [lmtInfo];
    end;

    if EnableLog and chkbxKeepSQLLog.Enabled and chkbxKeepSQLLog.Checked then
    begin
      KeepLogTypes := KeepLogTypes + [lmtSQL];
    end
    else
    begin
      KeepLogTypes := KeepLogTypes - [lmtSQL];
    end;

    if EnableLog and chkbxKeepDebugLog.Enabled and chkbxKeepDebugLog.Checked then
    begin
      KeepLogTypes := KeepLogTypes + [lmtDebug];
    end
    else
    begin
      KeepLogTypes := KeepLogTypes - [lmtDebug];
    end;

    FlushLogOnExit := chkbxFlushLogOnExit.Enabled and chkbxFlushLogOnExit.Checked;
    FlushLogOnStringsQuantity := chkbxFlushLogOnStringsQuantity.Enabled and chkbxFlushLogOnStringsQuantity.Checked;
    FlushLogOnStringsQuantityValue :=
      StrToIntDef(Routines.GetConditionalString(chkbxFlushLogOnStringsQuantity.Enabled and
      chkbxFlushLogOnStringsQuantity.Checked and edbxFlushLogOnStringsQuantityValue.Enabled,
      Trim(edbxFlushLogOnStringsQuantityValue.Text), EmptyStr), DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE);
    FlushLogOnClearingLog := chkbxFlushLogOnClearingLog.Enabled and chkbxFlushLogOnClearingLog.Checked;
    FlushLogOnApply := chkbxFlushLogOnApply.Enabled and chkbxFlushLogOnApply.Checked;
    CustomLogClientFile := chkbxCustomLogClientFile.Enabled and chkbxCustomLogClientFile.Checked;
    CustomLogClientFileValue := Routines.GetConditionalString(chkbxCustomLogClientFile.Enabled and
      chkbxCustomLogClientFile.Checked and chkbxEnableLog.Enabled and chkbxEnableLog.Checked and
      edbxCustomLogClientFileValue.Enabled, Trim(edbxCustomLogClientFileValue.Text),
      DEFAULT_CONFIGURATION_CUSTOM_LOG_CLIENT_VALUE);

    // вкладка "настройки положения диалоговых окон"
    dialog_position.Centered := chkbxLoginFormPositionByCenter.Enabled and chkbxLoginFormPositionByCenter.Checked;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxLoginFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxLoginFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    LoginFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxConfigurationFormPositionByCenter.Checked and
      chkbxConfigurationFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxConfigurationFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxConfigurationFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    ConfigurationFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxUsersFormPositionByCenter.Checked and chkbxUsersFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxUsersFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxUsersFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    UsersFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxSetPasswordFormPositionByCenter.Checked and
      chkbxSetPasswordFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxSetPasswordFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxSetPasswordFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    SetPasswordFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxReportFormPositionByCenter.Checked and chkbxReportFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxReportFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxReportFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    ReportFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxMaintenanceFormPositionByCenter.Checked and
      chkbxMaintenanceFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxMaintenanceFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxMaintenanceFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    MaintenanceFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxClearingFormPositionByCenter.Checked and chkbxClearingFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxClearingFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxClearingFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    ClearingFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxViewMessagesFormPositionByCenter.Checked and
      chkbxViewMessagesFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxViewMessagesFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxViewMessagesFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    ViewMessagesFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxCreateMessageFormPositionByCenter.Checked and
      chkbxCreateMessageFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxCreateMessageFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxCreateMessageFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    CreateMessageFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxViewMessageFormPositionByCenter.Checked and
      chkbxViewMessageFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxViewMessageFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxViewMessageFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    ViewMessageFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxPhonesFormPositionByCenter.Checked and chkbxPhonesFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxPhonesFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxPhonesFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    PhonesFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxAddEditPhoneFormPositionByCenter.Checked and
      chkbxAddEditPhoneFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxAddEditPhoneFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxAddEditPhoneFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    AddEditPhoneFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxAddMassMsrFormPositionByCenter.Checked and chkbxAddMassMsrFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxAddMassMsrFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxAddMassMsrFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    AddMassMsrFormPosition.Assign(dialog_position);

    dialog_position.Centered := chkbxPermissionsFormPositionByCenter.Checked and
      chkbxPermissionsFormPositionByCenter.Enabled;
    dialog_position.Left := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxPermissionsFormPositionX.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_LEFT);
    dialog_position.Top := StrToIntDef(Routines.GetConditionalString(not dialog_position.Centered,
      Trim(edbxPermissionsFormPositionY.Text), EmptyStr), DEFAULT_CONFIGURATION_DIALOG_TOP);
    PermissionsFormPosition.Assign(dialog_position);

    // вкладка "настройки процедуры логирования"
    StoreLogin := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked;
    StorePassword := chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
    AutoLogon := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and
      chkbxStoreLastPassword.Checked and chkbxAutoLogon.Enabled and chkbxAutoLogon.Checked;

    // вкладка "подключения к серверу базы данных услуги"
    if vleRNE4SERVER.Enabled then
    begin
      with RNE4Server, vleRNE4SERVER do
      begin
        Host := Trim(Cells[1, 1]);
        Port := StrToIntDef(Trim(Cells[1, 2]), DEFAULT_CONFIGURATION_RNE4SERVER_PORT);
        Timeout := StrToIntDef(Trim(Cells[1, 3]), DEFAULT_CONFIGURATION_RNE4SERVER_TIMEOUT);
        Compression := Trim(Cells[1, 4]) = 'Да';
        Database := Trim(Cells[1, 5]);
      end;
    end;

    // вкладка "подключения к серверу системы обмена сообщениями"
    if vleRNE4MESSAGESSERVER.Enabled then
    begin
      with MessagesServer, vleRNE4MESSAGESSERVER do
      begin
        Host := Trim(Cells[1, 1]);
        Port := StrToIntDef(Trim(Cells[1, 2]), DEFAULT_CONFIGURATION_MESSAGESERVER_PORT);
        Timeout := StrToIntDef(Trim(Cells[1, 3]), DEFAULT_CONFIGURATION_MESSAGESERVER_TIMEOUT);
        Compression := Trim(Cells[1, 4]) = 'Да';
        Database := Trim(Cells[1, 5]);
      end;
    end;

    // вкладка "настройки формирования отчётов"
    if rbSaveIntoTheTempFolder.Enabled and rbSaveIntoTheTempFolder.Checked then
    begin
      ReportFolder := rfTempFolder;
    end;
    if rbSaveIntoTheApplicationFolder.Enabled and rbSaveIntoTheApplicationFolder.Checked then
    begin
      ReportFolder := rfApplicationFolder;
    end;
    if rbSaveIntoTheCustomFolder.Enabled and rbSaveIntoTheCustomFolder.Checked then
    begin
      ReportFolder := rfCustomFolder;
    end;

    CustomReportFolderValue := Routines.GetConditionalString(rbSaveIntoTheCustomFolder.Enabled and
      rbSaveIntoTheCustomFolder.Checked, Trim(edbxCustomReportFolderValue.Text), DEFAULT_CONFIGURATION_CUSTOM_REPORT_FOLDER_VALUE);
    DontDemandOverwriteConfirmation := chkbxDontDemandOverwriteConfirmation.Enabled and
      chkbxDontDemandOverwriteConfirmation.Checked;
    AskForFileName := chkbxAskForFileName.Enabled and chkbxAskForFileName.Checked;

    // вкладка "настройки списка автозамены"

    // вкладка "настройки прочие"
    LaunchAtStartup := chkbxLaunchAtStartup.Enabled and chkbxLaunchAtStartup.Checked;
    PlaySoundOnComplete := chkbxPlaySoundOnComplete.Enabled and chkbxPlaySoundOnComplete.Checked;
    EnableAutoGetMessages := chkbxEnableAutoGetMessages.Enabled and chkbxEnableAutoGetMessages.Checked;
    AutoGetMessagesCycleDurationValue :=
      StrToIntDef(Routines.GetConditionalString(chkbxEnableAutoGetMessages.Enabled and
      chkbxEnableAutoGetMessages.Checked and edbxAutoGetMessagesCycleDurationValue.Enabled,
      Trim(edbxAutoGetMessagesCycleDurationValue.Text), IntToStr(DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE)),
      DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE);
    CustomHelpFile := chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked;
    CustomHelpFileValue := Routines.GetConditionalString(chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked and
      edbxCustomHelpFileValue.Enabled, Trim(edbxCustomHelpFileValue.Text), DEFAULT_CONFIGURATION_CUSTOM_HELP_FILE_VALUE);

    // вкладка "настройки главного окна"
    MainFormPositionByCenter := chkbxMainFormPositionByCenter.Enabled and chkbxMainFormPositionByCenter.Checked and
      (not(chkbxFullScreenAtLaunch.Enabled and chkbxFullScreenAtLaunch.Checked));
    FullScreenAtLaunch := chkbxFullScreenAtLaunch.Enabled and chkbxFullScreenAtLaunch.Checked;
    if chkbxFullScreenAtLaunch.Enabled and chkbxFullScreenAtLaunch.Checked then
    begin
      MainFormLeft := Screen.WorkAreaLeft;
      MainFormTop := Screen.WorkAreaTop;
      MainFormWidth := Screen.WorkAreaWidth;
      MainFormHeight := Screen.WorkAreaHeight;
    end
    else
      if chkbxMainFormPositionByCenter.Enabled and chkbxMainFormPositionByCenter.Checked then
      begin
        if edbxMainFormWidth.Enabled then
        begin
          MainFormWidth := StrToIntDef(Trim(edbxMainFormWidth.Text), DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH);
        end
        else
        begin
          MainFormWidth := DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH;
        end;

        if edbxMainFormHeight.Enabled then
        begin
          MainFormHeight := StrToIntDef(Trim(edbxMainFormHeight.Text), DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT);
        end
        else
        begin
          MainFormHeight := DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT;
        end;
        MainFormLeft := (Screen.WorkAreaWidth - MainFormWidth) div 2;
        MainFormTop := (Screen.WorkAreaHeight - MainFormHeight) div 2;
      end
      else
      begin
        if edbxMainFormPositionX.Enabled then
        begin
          MainFormLeft := StrToIntDef(Trim(edbxMainFormPositionX.Text), DEFAULT_CONFIGURATION_MAIN_FORM_LEFT);
        end
        else
        begin
          MainFormLeft := DEFAULT_CONFIGURATION_MAIN_FORM_LEFT;
        end;

        if edbxMainFormPositionY.Enabled then
        begin
          MainFormTop := StrToIntDef(Trim(edbxMainFormPositionY.Text), DEFAULT_CONFIGURATION_MAIN_FORM_TOP);
        end
        else
        begin
          MainFormTop := DEFAULT_CONFIGURATION_MAIN_FORM_TOP;
        end;

        if edbxMainFormWidth.Enabled then
        begin
          MainFormWidth := StrToIntDef(Trim(edbxMainFormWidth.Text), DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH);
        end
        else
        begin
          MainFormWidth := DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH;
        end;

        if edbxMainFormHeight.Enabled then
        begin
          MainFormHeight := StrToIntDef(Trim(edbxMainFormHeight.Text), DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT);
        end
        else
        begin
          MainFormHeight := DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT;
        end;
      end;

    // вкладка "настройки отображения информации"
    OrganizationPanelHeightValue :=
      StrToIntDef(Routines.GetConditionalString(chkbxOrganizationPanelHalfHeight.Enabled and
      chkbxOrganizationPanelHalfHeight.Checked, EmptyStr, Trim(edbxOrganizationPanelHeightValue.Text)),
      DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE);
    OrganizationPanelHalfHeight := chkbxOrganizationPanelHalfHeight.Enabled and
      chkbxOrganizationPanelHalfHeight.Checked;
    DataPanelWidthValue := StrToIntDef(Routines.GetConditionalString(chkbxDataPanelHalfWidth.Enabled and
      chkbxDataPanelHalfWidth.Checked, EmptyStr, Trim(edbxDataPanelWidthValue.Text)), DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE);
    DataPanelHalfWidth := chkbxDataPanelHalfWidth.Enabled and chkbxDataPanelHalfWidth.Checked;
    ShowDataInOtherInfoPanel := chkbxShowDataInOtherInfoPanel.Enabled and chkbxShowDataInOtherInfoPanel.Checked;
    ShowMeasuresListAsRichEdit := chkbxShowMeasuresListAsRichEdit.Enabled and chkbxShowMeasuresListAsRichEdit.Checked;
    MarkSearchedStrings := chkbxMarkSearchedStrings.Enabled and chkbxMarkSearchedStrings.Checked;
    PutTownAtTheEnd := chkbxPutTownAtTheEnd.Enabled and chkbxPutTownAtTheEnd.Checked;
  end;

  Log.SendInfo('Окно изменения настроек программы закрыто.');

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{6B58486E-78C2-4F8B-9923-BFC7F5FEA88C}');

  ModalResult := mrClose;
  Log.SendInfo('Попытка изменения настроек программы была отменена пользователем.');
  Log.SendInfo('Окно изменения настроек программы закрыто.');

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Help;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{4852C968-A8CC-4A2B-947E-4BA717D6A8EE}');

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    GenerateError('Извините, справочный файл к данной программе не найден.');
  end;

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_PreviousPage;
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения предыдущей страницы настроек программы',
    '{8CC5AFC0-A130-40F8-A13E-441914AFE036}');

  i := cbPage.ItemIndex - 1;
  if i < 0 then
  begin
    i := cbPage.Items.Count - 1;
  end;
  cbPage.ItemIndex := i;
  Do_PageSelect;

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_NextPage;
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения следующей страницы настроек программы',
    '{0408CB52-5F42-4BE4-8BB5-09EBA649B868}');

  i := cbPage.ItemIndex + 1;
  if i > cbPage.Items.Count - 1 then
  begin
    i := 0;
  end;
  cbPage.ItemIndex := i;
  Do_PageSelect;

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_ChooseCustomHelpFile;
var
  sPath: string;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора стороннего справочного файла к программе',
    '{DBF9ACD7-9F70-4D0A-9D90-CA893744CBBB}');

  iOldBusyCounter := MainForm.iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  MainForm.iBusyCounter := 0; // обнуление счётчика перед открытием модального окна
  MainForm.Refresh_BusyState; // обновление состояния индикатора

  with TOpenDialog.Create(Self) do
    try
      Filter := 'Файл справки к программе|' + StringReplace(ExtractFileName(Application.ExeName), '.exe', '.chm',
        [rfReplaceAll, rfIgnoreCase]) + '|Справочные файлы формата .CHM|*.chm|Справочные файлы формата .HLP|*.hlp';
      DefaultExt := 'chm';
      Title := 'Выберите файл справки...';
      FilterIndex := 1;
      Options := [ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName = EmptyStr then
        begin
          GenerateError('Возникла ошибка при выборе файла справки - файл не был выбран!');
        end
        else
          if not FileExists(FileName) then
          begin
            GenerateError('Возникла ошибка при выборе файла справки - выбранный файл не существует!');
          end
          else
          begin
            edbxCustomHelpFileValue.Text := FileName;
            Log.SendDebug('В качестве стороннего справочного файла выбрана файл "' + sPath + '".');
          end;
    finally
      Free;
    end;

  MainForm.iBusyCounter := iOldBusyCounter; // возвращение старого значения счётчика
  MainForm.Refresh_BusyState; // обновление состояния индикатора

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_ChooseCustomReportFolder;
var
  s, sPath: string;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора папки для сохранения отчётов', '{58DA7933-E4BD-4402-9E83-2446DB94BE14}');

  iOldBusyCounter := MainForm.iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  MainForm.iBusyCounter := 0; // обнуление счётчика перед открытием модального окна
  MainForm.Refresh_BusyState; // обновление состояния индикатора

  s := edbxCustomReportFolderValue.Text;

  if SelectDirectory('Выберите папку', EmptyStr, s, [sdNewFolder, sdNewUI], Self) then
    if (s <> EmptyStr) then
    begin
      sPath := IncludeTrailingPathDelimiter(sPath);
      if System.SysUtils.DirectoryExists(sPath) then
      begin
        edbxCustomReportFolderValue.Text := sPath;
        Log.SendDebug('В качестве папки для сохранения отчётов выбрана папка "' + sPath + '".');
      end
      else
      begin
        edbxCustomReportFolderValue.Text := EmptyStr;
        GenerateError('Возникла ошибка при выборе папки - указанная папка не существует!');
      end;
    end;

  MainForm.iBusyCounter := iOldBusyCounter; // возвращение старого значения счётчика
  MainForm.Refresh_BusyState; // обновление состояния индикатора

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_ChooseLogClientFile;
var
  sPath: string;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора внешнего клиента протоколирования', '{DCD63D88-72D9-42E5-91EC-35906B335D27}');

  iOldBusyCounter := MainForm.iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  MainForm.iBusyCounter := 0; // обнуление счётчика перед открытием модального окна
  MainForm.Refresh_BusyState; // обновление состояния индикатора

  with TOpenDialog.Create(Self) do
    try
      Filter := 'Файл модуля лог-клиента|LogKeeper.exe|Исполняемые файлы|*.exe';
      DefaultExt := 'exe';
      Title := 'Выберите файл внешнего клиента протоколирования...';
      FilterIndex := 1;
      Options := [ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName = EmptyStr then
          GenerateError('Возникла ошибка при выборе файла внешнего клиента протоколирования - файл не был выбран!')
        else
          if not FileExists(FileName) then
            GenerateError
              ('Возникла ошибка при выборе файла внешнего клиента протоколирования - выбранный файл не существует!')
          else
          begin
            edbxCustomLogClientFileValue.Text := FileName;
            Log.SendDebug('В качестве файла внешнего клиента протоколирования выбран файл "' + sPath + '".');
          end;
    finally
      Free;
    end;

  MainForm.iBusyCounter := iOldBusyCounter; // возвращение старого значения счётчика
  MainForm.Refresh_BusyState; // обновление состояния индикатора

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_PageSelect;
var
  i: integer;
begin
  ProcedureHeader
    ('Процедура обновления состояния элементов управления в зависимости от выбранного пункта выпадающего списка настроек',
    '{396B4482-5CD9-4C26-8AE4-B5CC0F52CF20}');

  // поиск и открытие нужной страницы в компоненте
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    if PageControl1.Pages[i].Caption = cbPage.Items[cbPage.ItemIndex] then
    begin
      PageControl1.ActivePageIndex := i;
    end;
  end;

  // доступность действия сброса настроек в значения по умолчанию
  if (PageControl1.ActivePage.Caption = ' подключения к серверу базы данных услуги') or
    (PageControl1.ActivePage.Caption = ' подключения к серверу системы обмена сообщениями') then
  begin
    if PageControl1.ActivePage.Caption = ' подключения к серверу базы данных услуги' then
    begin
      actDefaults.Enabled := vleRNE4SERVER.Enabled;
    end;
    if PageControl1.ActivePage.Caption = ' подключения к серверу системы обмена сообщениями' then
    begin
      actDefaults.Enabled := vleRNE4MESSAGESSERVER.Enabled;
    end;
  end
  else
  begin
    actDefaults.Enabled := not(PageControl1.ActivePage.Caption = ' списка автозамены');
  end;
  Log.SendDebug('Действие "' + actDefaults.Caption + '" ' + Routines.GetConditionalString(actDefaults.Enabled, 'в',
    'от') + 'ключено.');

  // доступность действия поднятия и опускания строки в списке автощзамены
  actLineUp.Visible := (PageControl1.ActivePage.Caption = ' списка автозамены') and sgAutoReplaceList.Visible and
    sgAutoReplaceList.Enabled;
  actLineDown.Visible := actLineUp.Visible;

  ProcedureFooter;
end;

procedure TConfigurationForm.CreateBooleanValuesList;
begin
  FBooleanValuesList := TStringList.Create;
  FBooleanValuesList.Add('Нет');
  FBooleanValuesList.Add('Да');
end;

procedure TConfigurationForm.Do_Defaults;
begin
  ProcedureHeader('Процедура сброса настроек к значениям по умолчанию', '{EDC577E6-6D47-4DC2-973E-AD820C7AC588}');

  // вкладка "настройки интерфейса"
  if PageControl1.ActivePage.Caption = ' интерфейса' then
  begin
    // выставление значений по умолчанию для контролов
    chkbxShowSplashAtStart.Checked := DEFAULT_CONFIGURATION_ENABLE_SPLASH_AT_START;
    chkbxShowToolbar.Checked := DEFAULT_CONFIGURATION_ENABLE_TOOLBAR;
    chkbxShowStatusbar.Checked := DEFAULT_CONFIGURATION_ENABLE_STATUSBAR;
    chkbxShowEditboxHints.Checked := DEFAULT_CONFIGURATION_ENABLE_EDITBOX_HINTS;
    chkbxShowCommonSearchEditbox.Checked := DEFAULT_CONFIGURATION_ENABLE_COMMON_SEARCH_EDITBOX;
    chkbxShowID.Checked := DEFAULT_CONFIGURATION_ENABLE_ID;
    chkbxUseMultibuffer.Checked := DEFAULT_CONFIGURATION_ENABLE_MULTIBUFFER;
    chkbxShowConfirmationOnQuit.Checked := DEFAULT_CONFIGURATION_ENABLE_QUIT_CONFIRMATION;
  end;

  // вкладка "настройки ведения протокола работы"
  if PageControl1.ActivePage.Caption = ' ведения протокола работы' then
  begin
    // выставление значений по умолчанию для элементов интерфейса
    chkbxEnableLog.Checked := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepErrorLog.Checked := (lmtError in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) and DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepWarningLog.Checked := (lmtWarning in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) and DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepInfoLog.Checked := (lmtInfo in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) and DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepSQLLog.Checked := (lmtSQL in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) and DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepDebugLog.Checked := (lmtDebug in DEFAULT_CONFIGURATION_KEEP_LOG_TYPES) and DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxFlushLogOnExit.Checked := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_EXIT and DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxFlushLogOnStringsQuantity.Checked := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY and DEFAULT_CONFIGURATION_ENABLE_LOG;
    edbxFlushLogOnStringsQuantityValue.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_STRINGS_QUANTITY and
      DEFAULT_CONFIGURATION_ENABLE_LOG, IntToStr(DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE), EmptyStr);
    chkbxFlushLogOnClearingLog.Checked := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_CLEARING_LOG and DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxFlushLogOnApply.Checked := DEFAULT_CONFIGURATION_ENABLE_FLUSH_LOG_ON_APPLY and DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxCustomLogClientFile.Checked := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT and DEFAULT_CONFIGURATION_ENABLE_LOG;
    edbxCustomLogClientFileValue.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT and
      DEFAULT_CONFIGURATION_ENABLE_LOG, DEFAULT_CONFIGURATION_CUSTOM_LOG_CLIENT_VALUE, EmptyStr);
    // выставление доступа к элементам интерфейса
    lblShowData.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepErrorLog.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepWarningLog.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepInfoLog.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepSQLLog.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxKeepDebugLog.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    lblFlushLog.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxFlushLogOnExit.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxFlushLogOnStringsQuantity.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    edbxFlushLogOnStringsQuantityValue.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxFlushLogOnClearingLog.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxFlushLogOnApply.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    chkbxCustomLogClientFile.Enabled := DEFAULT_CONFIGURATION_ENABLE_LOG;
    edbxCustomLogClientFileValue.Enabled := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT and DEFAULT_CONFIGURATION_ENABLE_LOG;
    actChooseCustomLogClientFile.Enabled := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_LOG_CLIENT and DEFAULT_CONFIGURATION_ENABLE_LOG;
    Log.SendDebug('Действие "' + actChooseCustomLogClientFile.Caption + '" ' +
      Routines.GetConditionalString(actChooseCustomLogClientFile.Enabled, 'в', 'от') + 'ключено.');
  end;

  // вкладка "настройки положения диалоговых окон"
  if PageControl1.ActivePage.Caption = ' положения диалоговых окон' then
  begin
    chkbxLoginFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxLoginFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxLoginFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxLoginFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxLoginFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxConfigurationFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxConfigurationFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxConfigurationFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxConfigurationFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxConfigurationFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxUsersFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxUsersFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxUsersFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxUsersFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxUsersFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxSetPasswordFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxSetPasswordFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxSetPasswordFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxSetPasswordFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxSetPasswordFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxReportFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxReportFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxReportFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxReportFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxReportFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxMaintenanceFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxMaintenanceFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxMaintenanceFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxMaintenanceFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxMaintenanceFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxClearingFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxClearingFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxClearingFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxClearingFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxClearingFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxViewMessagesFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxViewMessagesFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxViewMessagesFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxViewMessagesFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxViewMessagesFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxCreateMessageFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxCreateMessageFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxCreateMessageFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxCreateMessageFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxCreateMessageFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxViewMessageFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxViewMessageFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxViewMessageFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxViewMessageFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxViewMessageFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxPhonesFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxPhonesFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxPhonesFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxPhonesFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxPhonesFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxAddEditPhoneFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxAddEditPhoneFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxAddEditPhoneFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxAddEditPhoneFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxAddEditPhoneFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxAddMassMsrFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxAddMassMsrFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxAddMassMsrFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxAddMassMsrFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxAddMassMsrFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;

    chkbxPermissionsFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxPermissionsFormPositionX.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_LEFT));
    edbxPermissionsFormPositionY.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DIALOG_TOP));
    edbxPermissionsFormPositionX.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
    edbxPermissionsFormPositionY.Enabled := not DEFAULT_CONFIGURATION_ENABLE_DIALOG_CENTERED;
  end;

  // вкладка "настройки процедуры логирования"
  if PageControl1.ActivePage.Caption = ' процедуры логирования' then
  begin
    // выставление значений по умолчанию для элементов интерфейса
    chkbxStoreLastLogin.Checked := DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN;
    chkbxStoreLastPassword.Checked := DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD;
    chkbxAutoLogon.Checked := DEFAULT_CONFIGURATION_ENABLE_AUTO_LOGON and DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN and DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD;
    // выставление доступа к элементам интерфейса
    chkbxAutoLogon.Enabled := DEFAULT_CONFIGURATION_ENABLE_STORE_LOGIN and DEFAULT_CONFIGURATION_ENABLE_STORE_PASSWORD;
  end;

  // вкладка "подключения к серверу базы данных услуги"
  if PageControl1.ActivePage.Caption = ' подключения к серверу базы данных услуги' then
  begin
    // выставление значений по умолчанию для элементов интерфейса
    vleRNE4SERVER.Cells[1, 1] := DEFAULT_CONFIGURATION_RNE4SERVER_HOST;
    vleRNE4SERVER.Cells[1, 2] := IntToStr(DEFAULT_CONFIGURATION_RNE4SERVER_PORT);
    vleRNE4SERVER.Cells[1, 3] := IntToStr(DEFAULT_CONFIGURATION_RNE4SERVER_TIMEOUT);
    vleRNE4SERVER.Cells[1, 4] := vleRNE4SERVER.ItemProps[3].PickList.Strings
      [integer(DEFAULT_CONFIGURATION_RNE4SERVER_COMPRESSION)];
    vleRNE4SERVER.Cells[1, 5] := DEFAULT_CONFIGURATION_RNE4SERVER_DATABESE;
  end;

  // вкладка "подключения к серверу системы обмена сообщениями"
  if PageControl1.ActivePage.Caption = ' подключения к серверу системы обмена сообщениями' then
  begin
    // выставление значений по умолчанию для элементов интерфейса
    vleRNE4MESSAGESSERVER.Cells[1, 1] := DEFAULT_CONFIGURATION_MESSAGESERVER_HOST;
    vleRNE4MESSAGESSERVER.Cells[1, 2] := IntToStr(DEFAULT_CONFIGURATION_MESSAGESERVER_PORT);
    vleRNE4MESSAGESSERVER.Cells[1, 3] := IntToStr(DEFAULT_CONFIGURATION_MESSAGESERVER_TIMEOUT);
    vleRNE4MESSAGESSERVER.Cells[1, 4] := vleRNE4MESSAGESSERVER.ItemProps[3].PickList.Strings
      [integer(DEFAULT_CONFIGURATION_MESSAGESERVER_COMPRESSION)];
    vleRNE4MESSAGESSERVER.Cells[1, 5] := DEFAULT_CONFIGURATION_MESSAGESERVER_DATABASE;
  end;

  // вкладка "настройки формирования отчётов"
  if PageControl1.ActivePage.Caption = ' формирования отчётов' then
  begin
    // выставление значений по умолчанию для элементов интерфейса
    rbSaveIntoTheTempFolder.Checked := DEFAULT_CONFIGURATION_REPORT_FOLDER = rfTempFolder;
    rbSaveIntoTheApplicationFolder.Checked := DEFAULT_CONFIGURATION_REPORT_FOLDER = rfApplicationFolder;
    rbSaveIntoTheCustomFolder.Checked := DEFAULT_CONFIGURATION_REPORT_FOLDER = rfCustomFolder;
    edbxCustomReportFolderValue.Text := DEFAULT_CONFIGURATION_CUSTOM_REPORT_FOLDER_VALUE;
    chkbxDontDemandOverwriteConfirmation.Checked := DEFAULT_CONFIGURATION_ENABLE_OVERWRITE_CONFIRMATION;
    chkbxAskForFileName.Checked := DEFAULT_CONFIGURATION_ENABLE_ASK_FOR_FILE_NAME;
    // выставление доступа к элементам интерфейса
    edbxCustomReportFolderValue.Enabled := DEFAULT_CONFIGURATION_REPORT_FOLDER = rfCustomFolder;
    actChooseReportFolder.Enabled := DEFAULT_CONFIGURATION_REPORT_FOLDER = rfCustomFolder;
    Log.SendDebug('Действие "' + actChooseReportFolder.Caption + '" ' + Routines.GetConditionalString
      (actChooseReportFolder.Enabled, 'в', 'от') + 'ключено.');
  end;

  // вкладка "настройки прочие"
  if PageControl1.ActivePage.Caption = ' прочие' then
  begin
    // выставление значений по умолчанию для элементов интерфейса
    chkbxLaunchAtStartup.Checked := DEFAULT_CONFIGURATION_ENABLE_LAUNCH_AT_STARTUP;
    chkbxPlaySoundOnComplete.Checked := DEFAULT_CONFIGURATION_ENABLE_PLAY_SOUND_ON_COMPLETE;
    chkbxEnableAutoGetMessages.Checked := DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGE;
    edbxAutoGetMessagesCycleDurationValue.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGE,
      IntToStr(DEFAULT_CONFIGURATION_AUTO_GET_MESSAGES_CYCLE_DURATION_VALUE), EmptyStr);
    chkbxCustomHelpFile.Checked := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE;
    edbxCustomHelpFileValue.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE,
      DEFAULT_CONFIGURATION_CUSTOM_HELP_FILE_VALUE, EmptyStr);
    // выставление доступа к элементам интерфейса
    edbxAutoGetMessagesCycleDurationValue.Enabled := DEFAULT_CONFIGURATION_ENABLE_AUTO_GET_MESSAGE;
    edbxCustomHelpFileValue.Enabled := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE;
    actChooseCustomHelpFile.Enabled := DEFAULT_CONFIGURATION_ENABLE_CUSTOM_HELP_FILE;
    Log.SendDebug('Действие "' + actChooseCustomHelpFile.Caption + '" ' + Routines.GetConditionalString
      (actChooseCustomHelpFile.Enabled, 'в', 'от') + 'ключено.');
  end;

  // вкладка "настройки главного окна"
  if PageControl1.ActivePage.Caption = ' главного окна' then
  begin
    // выставление значений по умолчанию для элементов интерфейса
    chkbxFullScreenAtLaunch.Checked := DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH;
    chkbxMainFormPositionByCenter.Checked := DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_POSITION_BY_CENTER and
      (not DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH);
    edbxMainFormPositionX.Text := Routines.GetConditionalString
      (not(DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_POSITION_BY_CENTER or DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH),
      IntToStr(DEFAULT_CONFIGURATION_MAIN_FORM_LEFT), EmptyStr);
    edbxMainFormPositionY.Text := Routines.GetConditionalString
      (not(DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_POSITION_BY_CENTER or DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH),
      IntToStr(DEFAULT_CONFIGURATION_MAIN_FORM_TOP), EmptyStr);
    edbxMainFormWidth.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_MAIN_FORM_WIDTH));
    edbxMainFormHeight.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_MAIN_FORM_ENABLE_FULL_SCREEN_AT_LAUNCH, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_MAIN_FORM_HEIGHT));
  end;

  // вкладка "настройки отображения информации"
  if PageControl1.ActivePage.Caption = ' отображения информации' then
  begin
    // выставление значений по умолчанию для элементов интерфейса
    edbxOrganizationPanelHeightValue.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT,
      EmptyStr, IntToStr(DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_HEIGHT_VALUE));
    chkbxOrganizationPanelHalfHeight.Checked := DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT;
    edbxDataPanelWidthValue.Text := Routines.GetConditionalString(DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH, EmptyStr,
      IntToStr(DEFAULT_CONFIGURATION_DATA_PANEL_WIDTH_VALUE));
    chkbxDataPanelHalfWidth.Checked := DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH;
    chkbxShowDataInOtherInfoPanel.Checked := DEFAULT_CONFIGURATION_ENABLE_DATA_IN_OTHER_INFO_PANEL;
    chkbxShowMeasuresListAsRichEdit.Checked := DEFAULT_CONFIGURATION_ENABLE_MEASURE_LIST_AS_RICH_EDIT;
    chkbxMarkSearchedStrings.Checked := DEFAULT_CONFIGURATION_ENABLE_MARK_SEARCHED_STRING;
    chkbxPutTownAtTheEnd.Checked := DEFAULT_CONFIGURATION_ENABLE_PUT_TOWN_AT_THE_END;;
    // выставление доступа к элементам интерфейса
    edbxOrganizationPanelHeightValue.Enabled := not DEFAULT_CONFIGURATION_ORGANIZATION_PANEL_ENABLE_HALF_HEIGHT;
    edbxDataPanelWidthValue.Enabled := not DEFAULT_CONFIGURATION_DATA_PANEL_ENABLE_HALF_WIDTH;
  end;

  Log.SendInfo('Настройки ' + PageControl1.ActivePage.Caption +
    ' были сброшены пользователем в значения по умолчанию.');

  ProcedureFooter;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{3D3256A6-E8E3-4709-A3B3-B7A6E90A75BF}');
  Log.SendInfo('Отображено окно настроек программы.');
  ProcedureFooter;
end;

procedure TConfigurationForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  MainForm.Configuration.ConfigurationFormPage := cbPage.ItemIndex;
  FreeAndNil(FBooleanValuesList);
end;

procedure TConfigurationForm.chkbxEnableLogClick(Sender: TObject);
var
  bUseLog: Boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxEnableLog.Caption + '"',
    '{20AFAF3C-D977-4A28-8779-C5F59EB39B45}');

  bUseLog := chkbxEnableLog.Enabled and chkbxEnableLog.Checked;

  lblShowData.Enabled := bUseLog;

  chkbxKeepInfoLog.Enabled := bUseLog;
  chkbxKeepInfoLog.Checked := chkbxKeepInfoLog.Checked and chkbxKeepInfoLog.Enabled;

  chkbxKeepWarningLog.Enabled := bUseLog;
  chkbxKeepWarningLog.Checked := chkbxKeepWarningLog.Checked and chkbxKeepWarningLog.Enabled;

  chkbxKeepErrorLog.Enabled := bUseLog;
  chkbxKeepErrorLog.Checked := chkbxKeepErrorLog.Checked and chkbxKeepErrorLog.Enabled;

  chkbxKeepSQLLog.Enabled := bUseLog;
  chkbxKeepSQLLog.Checked := chkbxKeepSQLLog.Checked and chkbxKeepSQLLog.Enabled;

  chkbxKeepDebugLog.Enabled := bUseLog;
  chkbxKeepDebugLog.Checked := chkbxKeepDebugLog.Checked and chkbxKeepDebugLog.Enabled;

  lblFlushLog.Enabled := bUseLog;

  chkbxFlushLogOnExit.Enabled := bUseLog;
  chkbxFlushLogOnExit.Checked := chkbxFlushLogOnExit.Checked and chkbxFlushLogOnExit.Enabled;

  chkbxFlushLogOnStringsQuantity.Enabled := bUseLog;
  chkbxFlushLogOnStringsQuantity.Checked := chkbxFlushLogOnStringsQuantity.Checked and
    chkbxFlushLogOnStringsQuantity.Enabled;
  edbxFlushLogOnStringsQuantityValue.Enabled := bUseLog and chkbxFlushLogOnStringsQuantity.Checked and
    chkbxFlushLogOnStringsQuantity.Enabled;
  edbxFlushLogOnStringsQuantityValue.Text := Routines.GetConditionalString(edbxFlushLogOnStringsQuantityValue.Enabled,
    Routines.GetConditionalString(MainForm.Configuration.FlushLogOnStringsQuantityValue > 0,
    IntToStr(MainForm.Configuration.FlushLogOnStringsQuantityValue),
    IntToStr(DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE)), EmptyStr);

  chkbxFlushLogOnClearingLog.Enabled := bUseLog;
  chkbxFlushLogOnClearingLog.Checked := chkbxFlushLogOnClearingLog.Checked and chkbxFlushLogOnClearingLog.Enabled;

  chkbxFlushLogOnApply.Enabled := bUseLog;
  chkbxFlushLogOnApply.Checked := chkbxFlushLogOnApply.Checked and chkbxFlushLogOnApply.Enabled;

  chkbxCustomLogClientFile.Enabled := bUseLog;
  chkbxCustomLogClientFile.Checked := chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFileValue.Enabled := bUseLog and chkbxCustomLogClientFile.Checked and
    chkbxCustomLogClientFile.Enabled;
  if not bUseLog then
  begin
    edbxCustomLogClientFileValue.Text := EmptyStr;
  end;

  actChooseCustomLogClientFile.Enabled := chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;
  Log.SendDebug('Действие "' + actChooseCustomLogClientFile.Caption + '" ' +
    Routines.GetConditionalString(actChooseCustomLogClientFile.Enabled, 'в', 'от') + 'ключено.');

  Log.SendDebug('Флажок "' + chkbxEnableLog.Caption + '"' + Routines.GetConditionalString(bUseLog, 'в', 'от') +
    'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
var
  bFlushLogOnStringsQuantity: Boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxFlushLogOnStringsQuantity.Caption + '"',
    '{56071FBF-61AE-472E-B52B-BC239C45CD7C}');

  bFlushLogOnStringsQuantity := chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;
  edbxFlushLogOnStringsQuantityValue.Enabled := bFlushLogOnStringsQuantity;
  edbxFlushLogOnStringsQuantityValue.Text := Routines.GetConditionalString(bFlushLogOnStringsQuantity,
    Routines.GetConditionalString(MainForm.Configuration.FlushLogOnStringsQuantityValue > 0,
    IntToStr(MainForm.Configuration.FlushLogOnStringsQuantityValue),
    IntToStr(DEFAULT_CONFIGURATION_FLUSH_LOG_ON_STRINGS_QUANTITY_VALUE)), EmptyStr);

  Log.SendDebug('Флажок "' + chkbxFlushLogOnStringsQuantity.Caption + '"' + Routines.GetConditionalString
    (bFlushLogOnStringsQuantity, 'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxCustomLogClientFileClick(Sender: TObject);
var
  bCustomLogClientFile: Boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxCustomLogClientFile.Caption + '"',
    '{4CBC38D1-3DB9-480E-BA9A-246708A0C0A2}');

  bCustomLogClientFile := chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFileValue.Enabled := bCustomLogClientFile;
  actChooseCustomLogClientFile.Enabled := bCustomLogClientFile;
  Log.SendDebug('Действие "' + actChooseCustomLogClientFile.Caption + '" ' +
    Routines.GetConditionalString(actChooseCustomLogClientFile.Enabled, 'в', 'от') + 'ключено.');
  if not bCustomLogClientFile then
  begin
    edbxCustomLogClientFileValue.Text := EmptyStr;
  end;

  Log.SendDebug('Флажок "' + chkbxCustomLogClientFile.Caption + '"' + Routines.GetConditionalString
    (bCustomLogClientFile, 'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxDataPanelHalfWidthClick(Sender: TObject);
var
  bDataPanelHalfWidth: Boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxDataPanelHalfWidth.Caption + '"',
    '{E88569C6-BFE3-4AE7-B34B-6CA8179B0FEA}');

  bDataPanelHalfWidth := chkbxDataPanelHalfWidth.Checked and chkbxDataPanelHalfWidth.Enabled;
  edbxDataPanelWidthValue.Enabled := not bDataPanelHalfWidth;
  edbxDataPanelWidthValue.Text := Routines.GetConditionalString(bDataPanelHalfWidth, EmptyStr,
    IntToStr(MainForm.Configuration.DataPanelWidthValue));

  Log.SendDebug('Флажок "' + chkbxDataPanelHalfWidth.Caption + '"' + Routines.GetConditionalString(bDataPanelHalfWidth,
    'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.rbSaveIntoTheCustomFolderClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на радиокнопке', '{77B71A67-5A1E-4D56-ADE8-C42EBD13CAC0}');

  if Sender is TRadioButton then
  begin
    Log.SendInfo('Нажата радиокнопка "' + (Sender as TRadioButton).Caption + '".');
  end;

  edbxCustomReportFolderValue.Enabled := rbSaveIntoTheCustomFolder.Checked;
  actChooseReportFolder.Enabled := rbSaveIntoTheCustomFolder.Checked;
  Log.SendDebug('Действие "' + actChooseReportFolder.Caption + '" ' + Routines.GetConditionalString
    (actChooseReportFolder.Enabled, 'в', 'от') + 'ключено.');
  if not rbSaveIntoTheCustomFolder.Checked then
  begin
    edbxCustomReportFolderValue.Text := EmptyStr;
  end;

  ProcedureFooter;
end;

procedure TConfigurationForm.edbxNumericFieldKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0' .. '9', #8, '-']) then
  begin
    Key := #0; // "погасить" все остальные клавиши
  end;
end;

procedure TConfigurationForm.cbPageSelect(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события выбора пункта выпадающего списка',
    '{DD1092FC-D170-451E-B28F-B678197E5C0D}');
  Do_PageSelect;
  ProcedureFooter;
end;

procedure TConfigurationForm.FormCreate(Sender: TObject);
const
  ICON_CONFIGURATION = 5;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{928DE88A-9894-4B2A-B8AB-6D9BB130BCF6}');
  CreateBooleanValuesList;

  ImageListSmall.GetIcon(ICON_CONFIGURATION, Icon);
  actHelp.Enabled := Application.HelpFile <> EmptyStr;
  Log.SendDebug('Действие "' + actHelp.Caption + '" ' + Routines.GetConditionalString(actHelp.Enabled, 'в', 'от') +
    'ключено.');

  with MainForm.Configuration do
  begin
    // установка параметров протоколирования в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;

    // вкладка "настройки интерфейса"
    chkbxShowSplashAtStart.Checked := ShowSplashAtStart;
    chkbxShowToolbar.Checked := ShowToolbar;
    chkbxShowStatusbar.Checked := ShowStatusbar;
    chkbxShowEditboxHints.Checked := ShowEditboxHints;
    chkbxShowCommonSearchEditbox.Checked := ShowCommonSearchEditbox;
    chkbxShowID.Checked := ShowID;
    chkbxUseMultibuffer.Checked := UseMultibuffer;
    chkbxShowConfirmationOnQuit.Checked := ShowConfirmationOnQuit;

    // вкладка "настройки ведения протокола работы"
    chkbxEnableLog.Checked := EnableLog;
    chkbxKeepErrorLog.Checked := (lmtError in KeepLogTypes) and EnableLog;
    chkbxKeepWarningLog.Checked := (lmtWarning in KeepLogTypes) and EnableLog;
    chkbxKeepInfoLog.Checked := (lmtInfo in KeepLogTypes) and EnableLog;
    chkbxKeepSQLLog.Checked := (lmtSQL in KeepLogTypes) and EnableLog;
    chkbxKeepDebugLog.Checked := (lmtDebug in KeepLogTypes) and EnableLog;
    chkbxFlushLogOnExit.Checked := FlushLogOnExit and EnableLog;
    chkbxFlushLogOnStringsQuantity.Checked := FlushLogOnStringsQuantity and EnableLog;
    edbxFlushLogOnStringsQuantityValue.Text := Routines.GetConditionalString(FlushLogOnStringsQuantity and EnableLog,
      IntToStr(FlushLogOnStringsQuantityValue), EmptyStr);
    chkbxFlushLogOnClearingLog.Checked := FlushLogOnClearingLog and EnableLog;
    chkbxFlushLogOnApply.Checked := FlushLogOnApply and EnableLog;
    chkbxCustomLogClientFile.Checked := CustomLogClientFile and EnableLog;
    edbxCustomLogClientFileValue.Text := Routines.GetConditionalString(CustomLogClientFile and EnableLog,
      CustomLogClientFileValue, EmptyStr);
    lblShowData.Enabled := EnableLog;
    chkbxKeepErrorLog.Enabled := EnableLog;
    chkbxKeepWarningLog.Enabled := EnableLog;
    chkbxKeepInfoLog.Enabled := EnableLog;
    chkbxKeepSQLLog.Enabled := EnableLog;
    chkbxKeepDebugLog.Enabled := EnableLog;
    lblFlushLog.Enabled := EnableLog;
    chkbxFlushLogOnExit.Enabled := EnableLog;
    chkbxFlushLogOnStringsQuantity.Enabled := EnableLog;
    edbxFlushLogOnStringsQuantityValue.Enabled := EnableLog;
    chkbxFlushLogOnClearingLog.Enabled := EnableLog;
    chkbxFlushLogOnApply.Enabled := EnableLog;
    chkbxCustomLogClientFile.Enabled := EnableLog;
    edbxCustomLogClientFileValue.Enabled := CustomLogClientFile and EnableLog;
    actChooseCustomLogClientFile.Enabled := CustomLogClientFile and EnableLog;
    Log.SendDebug('Действие "' + actChooseCustomLogClientFile.Caption + '" ' +
      Routines.GetConditionalString(actChooseCustomLogClientFile.Enabled, 'в', 'от') + 'ключено.');

    // вкладка "настройки положения диалоговых окон"
    ScrollBox1.VertScrollBar.Position := 0;

    chkbxLoginFormPositionByCenter.Checked := LoginFormPosition.Centered;
    edbxLoginFormPositionX.Text := Routines.GetConditionalString(LoginFormPosition.Centered, EmptyStr,
      IntToStr(LoginFormPosition.Left));
    edbxLoginFormPositionY.Text := Routines.GetConditionalString(LoginFormPosition.Centered, EmptyStr,
      IntToStr(LoginFormPosition.Top));
    edbxLoginFormPositionX.Enabled := not LoginFormPosition.Centered;
    edbxLoginFormPositionY.Enabled := not LoginFormPosition.Centered;

    chkbxConfigurationFormPositionByCenter.Checked := ConfigurationFormPosition.Centered;
    edbxConfigurationFormPositionX.Text := Routines.GetConditionalString(ConfigurationFormPosition.Centered, EmptyStr,
      IntToStr(ConfigurationFormPosition.Left));
    edbxConfigurationFormPositionY.Text := Routines.GetConditionalString(ConfigurationFormPosition.Centered, EmptyStr,
      IntToStr(ConfigurationFormPosition.Top));
    edbxConfigurationFormPositionX.Enabled := not ConfigurationFormPosition.Centered;
    edbxConfigurationFormPositionY.Enabled := not ConfigurationFormPosition.Centered;

    chkbxUsersFormPositionByCenter.Checked := UsersFormPosition.Centered;
    edbxUsersFormPositionX.Text := Routines.GetConditionalString(UsersFormPosition.Centered, EmptyStr,
      IntToStr(UsersFormPosition.Left));
    edbxUsersFormPositionY.Text := Routines.GetConditionalString(UsersFormPosition.Centered, EmptyStr,
      IntToStr(UsersFormPosition.Top));
    edbxUsersFormPositionX.Enabled := not UsersFormPosition.Centered;
    edbxUsersFormPositionY.Enabled := not UsersFormPosition.Centered;

    chkbxSetPasswordFormPositionByCenter.Checked := SetPasswordFormPosition.Centered;
    edbxSetPasswordFormPositionX.Text := Routines.GetConditionalString(SetPasswordFormPosition.Centered, EmptyStr,
      IntToStr(SetPasswordFormPosition.Left));
    edbxSetPasswordFormPositionY.Text := Routines.GetConditionalString(SetPasswordFormPosition.Centered, EmptyStr,
      IntToStr(SetPasswordFormPosition.Top));
    edbxSetPasswordFormPositionX.Enabled := not SetPasswordFormPosition.Centered;
    edbxSetPasswordFormPositionY.Enabled := not SetPasswordFormPosition.Centered;

    chkbxReportFormPositionByCenter.Checked := ReportFormPosition.Centered;
    edbxReportFormPositionX.Text := Routines.GetConditionalString(ReportFormPosition.Centered, EmptyStr,
      IntToStr(ReportFormPosition.Left));
    edbxReportFormPositionY.Text := Routines.GetConditionalString(ReportFormPosition.Centered, EmptyStr,
      IntToStr(ReportFormPosition.Top));
    edbxReportFormPositionX.Enabled := not ReportFormPosition.Centered;
    edbxReportFormPositionY.Enabled := not ReportFormPosition.Centered;

    chkbxMaintenanceFormPositionByCenter.Checked := MaintenanceFormPosition.Centered;
    edbxMaintenanceFormPositionX.Text := Routines.GetConditionalString(MaintenanceFormPosition.Centered, EmptyStr,
      IntToStr(MaintenanceFormPosition.Left));
    edbxMaintenanceFormPositionY.Text := Routines.GetConditionalString(MaintenanceFormPosition.Centered, EmptyStr,
      IntToStr(MaintenanceFormPosition.Top));
    edbxMaintenanceFormPositionX.Enabled := not MaintenanceFormPosition.Centered;
    edbxMaintenanceFormPositionY.Enabled := not MaintenanceFormPosition.Centered;

    chkbxClearingFormPositionByCenter.Checked := ClearingFormPosition.Centered;
    edbxClearingFormPositionX.Text := Routines.GetConditionalString(ClearingFormPosition.Centered, EmptyStr,
      IntToStr(ClearingFormPosition.Left));
    edbxClearingFormPositionY.Text := Routines.GetConditionalString(ClearingFormPosition.Centered, EmptyStr,
      IntToStr(ClearingFormPosition.Top));
    edbxClearingFormPositionX.Enabled := not ClearingFormPosition.Centered;
    edbxClearingFormPositionY.Enabled := not ClearingFormPosition.Centered;

    chkbxViewMessagesFormPositionByCenter.Checked := ViewMessagesFormPosition.Centered;
    edbxViewMessagesFormPositionX.Text := Routines.GetConditionalString(ViewMessagesFormPosition.Centered, EmptyStr,
      IntToStr(ViewMessagesFormPosition.Left));
    edbxViewMessagesFormPositionY.Text := Routines.GetConditionalString(ViewMessagesFormPosition.Centered, EmptyStr,
      IntToStr(ViewMessagesFormPosition.Top));
    edbxViewMessagesFormPositionX.Enabled := not ViewMessagesFormPosition.Centered;
    edbxViewMessagesFormPositionY.Enabled := not ViewMessagesFormPosition.Centered;

    chkbxCreateMessageFormPositionByCenter.Checked := CreateMessageFormPosition.Centered;
    edbxCreateMessageFormPositionX.Text := Routines.GetConditionalString(CreateMessageFormPosition.Centered, EmptyStr,
      IntToStr(CreateMessageFormPosition.Left));
    edbxCreateMessageFormPositionY.Text := Routines.GetConditionalString(CreateMessageFormPosition.Centered, EmptyStr,
      IntToStr(CreateMessageFormPosition.Top));
    edbxCreateMessageFormPositionX.Enabled := not CreateMessageFormPosition.Centered;
    edbxCreateMessageFormPositionY.Enabled := not CreateMessageFormPosition.Centered;

    chkbxViewMessageFormPositionByCenter.Checked := ViewMessageFormPosition.Centered;
    edbxViewMessageFormPositionX.Text := Routines.GetConditionalString(ViewMessageFormPosition.Centered, EmptyStr,
      IntToStr(ViewMessageFormPosition.Left));
    edbxViewMessageFormPositionY.Text := Routines.GetConditionalString(ViewMessageFormPosition.Centered, EmptyStr,
      IntToStr(ViewMessageFormPosition.Top));
    edbxViewMessageFormPositionX.Enabled := not ViewMessageFormPosition.Centered;
    edbxViewMessageFormPositionY.Enabled := not ViewMessageFormPosition.Centered;

    chkbxPhonesFormPositionByCenter.Checked := PhonesFormPosition.Centered;
    edbxPhonesFormPositionX.Text := Routines.GetConditionalString(PhonesFormPosition.Centered, EmptyStr,
      IntToStr(PhonesFormPosition.Left));
    edbxPhonesFormPositionY.Text := Routines.GetConditionalString(PhonesFormPosition.Centered, EmptyStr,
      IntToStr(PhonesFormPosition.Top));
    edbxPhonesFormPositionX.Enabled := not PhonesFormPosition.Centered;
    edbxPhonesFormPositionY.Enabled := not PhonesFormPosition.Centered;

    chkbxAddEditPhoneFormPositionByCenter.Checked := AddEditPhoneFormPosition.Centered;
    edbxAddEditPhoneFormPositionX.Text := Routines.GetConditionalString(AddEditPhoneFormPosition.Centered, EmptyStr,
      IntToStr(AddEditPhoneFormPosition.Left));
    edbxAddEditPhoneFormPositionY.Text := Routines.GetConditionalString(AddEditPhoneFormPosition.Centered, EmptyStr,
      IntToStr(AddEditPhoneFormPosition.Top));
    edbxAddEditPhoneFormPositionX.Enabled := not AddEditPhoneFormPosition.Centered;
    edbxAddEditPhoneFormPositionY.Enabled := not AddEditPhoneFormPosition.Centered;

    chkbxAddMassMsrFormPositionByCenter.Checked := AddMassMsrFormPosition.Centered;
    edbxAddMassMsrFormPositionX.Text := Routines.GetConditionalString(AddMassMsrFormPosition.Centered, EmptyStr,
      IntToStr(AddMassMsrFormPosition.Left));
    edbxAddMassMsrFormPositionY.Text := Routines.GetConditionalString(AddMassMsrFormPosition.Centered, EmptyStr,
      IntToStr(AddMassMsrFormPosition.Top));
    edbxAddMassMsrFormPositionX.Enabled := not AddMassMsrFormPosition.Centered;
    edbxAddMassMsrFormPositionY.Enabled := not AddMassMsrFormPosition.Centered;

    chkbxPermissionsFormPositionByCenter.Checked := PermissionsFormPosition.Centered;
    edbxPermissionsFormPositionX.Text := Routines.GetConditionalString(PermissionsFormPosition.Centered, EmptyStr,
      IntToStr(PermissionsFormPosition.Left));
    edbxPermissionsFormPositionY.Text := Routines.GetConditionalString(PermissionsFormPosition.Centered, EmptyStr,
      IntToStr(PermissionsFormPosition.Top));
    edbxPermissionsFormPositionX.Enabled := not PermissionsFormPosition.Centered;
    edbxPermissionsFormPositionY.Enabled := not PermissionsFormPosition.Centered;

    // вкладка "настройки процедуры логирования"
    chkbxStoreLastLogin.Checked := StoreLogin;
    chkbxStoreLastPassword.Checked := StorePassword;
    chkbxAutoLogon.Checked := AutoLogon and StoreLogin and StorePassword;
    chkbxAutoLogon.Enabled := StoreLogin and StorePassword;

    // вкладка "подключения к серверу базы данных услуги"
    vleRNE4SERVER.Cells[1, 1] := RNE4Server.Host;
    vleRNE4SERVER.ItemProps[1].EditMask := '99999;0; ';
    vleRNE4SERVER.Cells[1, 2] := IntToStr(RNE4Server.Port);
    vleRNE4SERVER.ItemProps[2].EditMask := '99999;0; ';
    vleRNE4SERVER.Cells[1, 3] := IntToStr(RNE4Server.Timeout);
    vleRNE4SERVER.ItemProps[3].EditStyle := esPickList;
    vleRNE4SERVER.ItemProps[3].PickList := FBooleanValuesList;
    vleRNE4SERVER.ItemProps[3].ReadOnly := True;
    vleRNE4SERVER.Cells[1, 4] := vleRNE4SERVER.ItemProps[3].PickList.Strings[integer(RNE4Server.Compression)];
    vleRNE4SERVER.Cells[1, 5] := RNE4Server.Database;

    // вкладка "подключения к серверу системы обмена сообщениями"
    vleRNE4MESSAGESSERVER.Cells[1, 1] := MessagesServer.Host;
    vleRNE4MESSAGESSERVER.ItemProps[1].EditMask := '99999;0; ';
    vleRNE4MESSAGESSERVER.Cells[1, 2] := IntToStr(MessagesServer.Port);
    vleRNE4MESSAGESSERVER.ItemProps[2].EditMask := '99999;0; ';
    vleRNE4MESSAGESSERVER.Cells[1, 3] := IntToStr(MessagesServer.Timeout);
    vleRNE4MESSAGESSERVER.ItemProps[3].EditStyle := esPickList;
    vleRNE4MESSAGESSERVER.ItemProps[3].PickList := FBooleanValuesList;
    vleRNE4MESSAGESSERVER.ItemProps[3].ReadOnly := True;
    vleRNE4MESSAGESSERVER.Cells[1, 4] := vleRNE4MESSAGESSERVER.ItemProps[3].PickList.Strings
      [integer(MessagesServer.Compression)];
    vleRNE4MESSAGESSERVER.Cells[1, 5] := MessagesServer.Database;

    // вкладка "настройки формирования отчётов"
    rbSaveIntoTheTempFolder.Checked := ReportFolder = rfTempFolder;
    rbSaveIntoTheApplicationFolder.Checked := ReportFolder = rfApplicationFolder;
    rbSaveIntoTheCustomFolder.Checked := ReportFolder = rfCustomFolder;
    edbxCustomReportFolderValue.Text := CustomReportFolderValue;
    chkbxDontDemandOverwriteConfirmation.Checked := DontDemandOverwriteConfirmation;
    chkbxAskForFileName.Checked := AskForFileName;
    edbxCustomReportFolderValue.Enabled := ReportFolder = rfCustomFolder;
    actChooseReportFolder.Enabled := ReportFolder = rfCustomFolder;
    Log.SendDebug('Действие "' + actChooseReportFolder.Caption + '" ' + Routines.GetConditionalString
      (actChooseReportFolder.Enabled, 'в', 'от') + 'ключено.');

    // вкладка "настройки списка автозамены"
    lblAutoReplaceSorry.Caption := 'Извините, но список доступен только для пользователей' + sLineBreak +
      'с правами редактирования базы данных' + sLineBreak + 'при подлючении к базе данных!';

    // вкладка "настройки прочие"
    chkbxLaunchAtStartup.Checked := LaunchAtStartup;
    chkbxPlaySoundOnComplete.Checked := PlaySoundOnComplete;
    chkbxEnableAutoGetMessages.Checked := EnableAutoGetMessages;
    edbxAutoGetMessagesCycleDurationValue.Text := Routines.GetConditionalString(EnableAutoGetMessages,
      IntToStr(AutoGetMessagesCycleDurationValue), EmptyStr);
    chkbxCustomHelpFile.Checked := CustomHelpFile;

    edbxCustomHelpFileValue.Text := Routines.GetConditionalString(CustomHelpFile, CustomHelpFileValue, EmptyStr);

    edbxAutoGetMessagesCycleDurationValue.Enabled := EnableAutoGetMessages;
    edbxCustomHelpFileValue.Enabled := CustomHelpFile;
    actChooseCustomHelpFile.Enabled := CustomHelpFile;
    Log.SendDebug('Действие "' + actChooseCustomHelpFile.Caption + '" ' + Routines.GetConditionalString
      (actChooseCustomHelpFile.Enabled, 'в', 'от') + 'ключено.');

    // вкладка "настройки главного окна"
    chkbxFullScreenAtLaunch.Checked := MainForm.WindowState = wsMaximized;
    chkbxMainFormPositionByCenter.Checked := MainForm.Position = poScreenCenter;
    edbxMainFormPositionX.Text := Routines.GetConditionalString
      (not((MainForm.Position = poScreenCenter) or (MainForm.WindowState = wsMaximized)), IntToStr(MainForm.Left),
      EmptyStr);
    edbxMainFormPositionY.Text := Routines.GetConditionalString
      (not((MainForm.Position = poScreenCenter) or (MainForm.WindowState = wsMaximized)), IntToStr(MainForm.Top),
      EmptyStr);
    edbxMainFormWidth.Text := Routines.GetConditionalString(MainForm.WindowState = wsMaximized, EmptyStr,
      IntToStr(MainForm.Width));
    edbxMainFormHeight.Text := Routines.GetConditionalString(MainForm.WindowState = wsMaximized, EmptyStr,
      IntToStr(MainForm.Height));

    // вкладка "настройки отображения информации"
    edbxOrganizationPanelHeightValue.Text := Routines.GetConditionalString(OrganizationPanelHalfHeight, EmptyStr,
      IntToStr(OrganizationPanelHeightValue));
    chkbxOrganizationPanelHalfHeight.Checked := OrganizationPanelHalfHeight;
    edbxDataPanelWidthValue.Text := Routines.GetConditionalString(DataPanelHalfWidth, EmptyStr,
      IntToStr(DataPanelWidthValue));
    chkbxDataPanelHalfWidth.Checked := DataPanelHalfWidth;
    chkbxShowDataInOtherInfoPanel.Checked := ShowDataInOtherInfoPanel;
    chkbxShowMeasuresListAsRichEdit.Checked := ShowMeasuresListAsRichEdit;
    chkbxMarkSearchedStrings.Checked := MarkSearchedStrings;
    chkbxPutTownAtTheEnd.Checked := PutTownAtTheEnd;;
    edbxOrganizationPanelHeightValue.Enabled := not OrganizationPanelHalfHeight;
    edbxDataPanelWidthValue.Enabled := not DataPanelHalfWidth;

  end;

  cbPage.ItemIndex := MainForm.Configuration.ConfigurationFormPage;
  Do_PageSelect;
  rbSaveIntoTheCustomFolderClick(Sender);

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxFullScreenAtLaunchClick(Sender: TObject);
var
  bFullScreenAtLaunch: Boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxFullScreenAtLaunch.Caption + '"',
    '{52688629-980D-4725-A207-FD5D898B16AB}');

  bFullScreenAtLaunch := chkbxFullScreenAtLaunch.Checked and chkbxFullScreenAtLaunch.Enabled;
  chkbxMainFormPositionByCenter.Enabled := not bFullScreenAtLaunch;
  chkbxMainFormPositionByCenter.Checked := chkbxMainFormPositionByCenter.Checked and (not bFullScreenAtLaunch);
  edbxMainFormPositionX.Enabled := (not bFullScreenAtLaunch) and (not chkbxMainFormPositionByCenter.Checked);
  edbxMainFormPositionY.Enabled := (not bFullScreenAtLaunch) and (not chkbxMainFormPositionByCenter.Checked);
  edbxMainFormWidth.Enabled := not bFullScreenAtLaunch;
  edbxMainFormHeight.Enabled := not bFullScreenAtLaunch;

  edbxMainFormPositionX.Text := Routines.GetConditionalString(edbxMainFormPositionX.Enabled,
    IntToStr(MainForm.Configuration.MainFormLeft), EmptyStr);
  edbxMainFormPositionY.Text := Routines.GetConditionalString(edbxMainFormPositionY.Enabled,
    IntToStr(MainForm.Configuration.MainFormTop), EmptyStr);
  edbxMainFormWidth.Text := Routines.GetConditionalString(not bFullScreenAtLaunch,
    IntToStr(MainForm.Configuration.MainFormWidth), EmptyStr);
  edbxMainFormHeight.Text := Routines.GetConditionalString(not bFullScreenAtLaunch,
    IntToStr(MainForm.Configuration.MainFormHeight), EmptyStr);

  Log.SendDebug('Флажок "' + chkbxMainFormPositionByCenter.Caption + '"' + Routines.GetConditionalString
    (bFullScreenAtLaunch, 'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxLoginFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  LoginForm: TLoginForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxLoginFormPositionByCenter.Caption + '"',
    '{4F120B29-021D-4F4C-893C-F33E907F3D7A}');

  b := chkbxLoginFormPositionByCenter.Enabled and chkbxLoginFormPositionByCenter.Checked;
  edbxLoginFormPositionX.Enabled := not b;
  edbxLoginFormPositionY.Enabled := not b;
  if b then
  begin
    edbxLoginFormPositionX.Text := EmptyStr;
    edbxLoginFormPositionY.Text := EmptyStr;
  end
  else
  begin
    LoginForm := TLoginForm.Create(Self, MainForm.Configuration.LoginFormPosition);
    try
      edbxLoginFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - LoginForm.Width) div 2);
      edbxLoginFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - LoginForm.Height) div 2);
    finally
      LoginForm.Free;
    end;
  end;
  Log.SendDebug('Флажок "' + chkbxLoginFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в', 'от')
    + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxSetPasswordFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  SetPasswordForm: TSetPasswordForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxSetPasswordFormPositionByCenter.Caption + '"',
    '{9ED32D46-9E32-4491-B6AB-6D5BBF7FD074}');

  b := chkbxSetPasswordFormPositionByCenter.Enabled and chkbxSetPasswordFormPositionByCenter.Checked;
  edbxSetPasswordFormPositionX.Enabled := not b;
  edbxSetPasswordFormPositionY.Enabled := not b;
  if b then
  begin
    edbxSetPasswordFormPositionX.Text := EmptyStr;
    edbxSetPasswordFormPositionY.Text := EmptyStr;
  end
  else
  begin
    SetPasswordForm := TSetPasswordForm.Create(Self, MainForm.Configuration.SetPasswordFormPosition);
    try
      edbxSetPasswordFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - SetPasswordForm.Width) div 2);
      edbxSetPasswordFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - SetPasswordForm.Height) div 2);
    finally
      SetPasswordForm.Free;
    end;
  end;
  Log.SendDebug('Флажок "' + chkbxSetPasswordFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxReportFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  ReportForm: TReportForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxReportFormPositionByCenter.Caption + '"',
    '{24AC0BDC-F297-4CB9-BC03-8A19926A70C6}');

  b := chkbxReportFormPositionByCenter.Enabled and chkbxReportFormPositionByCenter.Checked;
  edbxReportFormPositionX.Enabled := not b;
  edbxReportFormPositionY.Enabled := not b;
  if b then
  begin
    edbxReportFormPositionX.Text := EmptyStr;
    edbxReportFormPositionY.Text := EmptyStr;
  end
  else
  begin
    ReportForm := TReportForm.Create(Self, MainForm.Configuration.ReportFormPosition);
    try
      edbxReportFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - ReportForm.Width) div 2);
      edbxReportFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - ReportForm.Height) div 2);
    finally
      ReportForm.Free;
    end;
  end;
  Log.SendDebug('Флажок "' + chkbxReportFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в', 'от')
    + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxStoreLastLoginClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxStoreLastLogin.Caption + '"',
    '{DF6E7711-9716-4511-8C02-AA1F34D95096}');

  chkbxStoreLastPassword.Enabled := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked;
  chkbxStoreLastPassword.Checked := chkbxStoreLastPassword.Checked and chkbxStoreLastPassword.Enabled;
  chkbxAutoLogon.Enabled := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and
    chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked := chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendDebug('Флажок "' + chkbxStoreLastLogin.Caption + '"' + Routines.GetConditionalString
    (chkbxStoreLastLogin.Checked, 'в', 'от') + 'ключен.');
  Log.SendDebug('Флажок "' + chkbxStoreLastPassword.Caption + '"' + Routines.GetConditionalString
    (chkbxStoreLastPassword.Checked, 'в', 'от') + 'ключен.');
  Log.SendDebug('Флажок "' + chkbxAutoLogon.Caption + '"' + Routines.GetConditionalString(chkbxAutoLogon.Checked, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxStoreLastPasswordClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxStoreLastPassword.Caption + '"',
    '{C9AD62BE-833A-4C57-904C-0ED5DFB0634F}');

  chkbxAutoLogon.Enabled := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and
    chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked := chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendDebug('Флажок "' + chkbxStoreLastPassword.Caption + '"' + Routines.GetConditionalString
    (chkbxStoreLastPassword.Checked, 'в', 'от') + 'ключен.');
  Log.SendDebug('Флажок "' + chkbxAutoLogon.Caption + '"' + Routines.GetConditionalString(chkbxAutoLogon.Checked, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxUsersFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  // UsersForm: TUsersForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxUsersFormPositionByCenter.Caption + '"',
    '{F7984D0B-E438-4B31-8BC8-9C24190065C4}');

  b := chkbxUsersFormPositionByCenter.Enabled and chkbxUsersFormPositionByCenter.Checked;
  edbxUsersFormPositionX.Enabled := not b;
  edbxUsersFormPositionY.Enabled := not b;
  if b then
  begin
    edbxUsersFormPositionX.Text := EmptyStr;
    edbxUsersFormPositionY.Text := EmptyStr;
  end
  else
  begin
    // UsersForm:=TUsersForm.Create(Self);
    // try
    // edbxUsersFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-UsersForm.Width)div 2);
    // edbxUsersFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-UsersForm.Height)div 2);
    // finally
    // UsersForm.Free;
    // end;
  end;
  Log.SendDebug('Флажок "' + chkbxUsersFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в', 'от')
    + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxCreateMessageFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  CreateMessageForm: TCreateMessageForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxCreateMessageFormPositionByCenter.Caption + '"',
    '{E4C4C710-0120-4391-8B8B-3A3DF1D7F95B}');

  b := chkbxCreateMessageFormPositionByCenter.Enabled and chkbxCreateMessageFormPositionByCenter.Checked;
  edbxCreateMessageFormPositionX.Enabled := not b;
  edbxCreateMessageFormPositionY.Enabled := not b;
  if b then
  begin
    edbxCreateMessageFormPositionX.Text := EmptyStr;
    edbxCreateMessageFormPositionY.Text := EmptyStr;
  end
  else
  begin
    CreateMessageForm := TCreateMessageForm.Create(Self, MainForm.Configuration.CreateMessageFormPosition);
    try
      edbxCreateMessageFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - CreateMessageForm.Width) div 2);
      edbxCreateMessageFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - CreateMessageForm.Height) div 2);
    finally
      CreateMessageForm.Free;
    end;
  end;
  Log.SendDebug('Флажок "' + chkbxCreateMessageFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b,
    'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxViewMessageFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  ViewMessageForm: TViewMessageForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxViewMessageFormPositionByCenter.Caption + '"',
    '{34DEEAA1-C7A1-4C63-8384-D28CBB8CEBF3}');

  b := chkbxViewMessageFormPositionByCenter.Enabled and chkbxViewMessageFormPositionByCenter.Checked;
  edbxViewMessageFormPositionX.Enabled := not b;
  edbxViewMessageFormPositionY.Enabled := not b;
  if b then
  begin
    edbxViewMessageFormPositionX.Text := EmptyStr;
    edbxViewMessageFormPositionY.Text := EmptyStr;
  end
  else
  begin
    ViewMessageForm := TViewMessageForm.Create(Self, MainForm.Configuration.ViewMessageFormPosition);
    try
      edbxViewMessageFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - ViewMessageForm.Width) div 2);
      edbxViewMessageFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - ViewMessageForm.Height) div 2);
    finally
      ViewMessageForm.Free;
    end;
  end;
  Log.SendDebug('Флажок "' + chkbxViewMessageFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxViewMessagesFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  ViewMessagesForm: TViewMessagesForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxViewMessagesFormPositionByCenter.Caption + '"',
    '{0CEE11D1-8BEF-4853-AA5A-707DD2E2FD34}');

  b := chkbxViewMessagesFormPositionByCenter.Enabled and chkbxViewMessagesFormPositionByCenter.Checked;
  edbxViewMessagesFormPositionX.Enabled := not b;
  edbxViewMessagesFormPositionY.Enabled := not b;
  if b then
  begin
    edbxViewMessagesFormPositionX.Text := EmptyStr;
    edbxViewMessagesFormPositionY.Text := EmptyStr;
  end
  else
  begin
    ViewMessagesForm := TViewMessagesForm.Create(Self, MainForm.Configuration.ViewMessagesFormPosition);
    try
      edbxViewMessagesFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - ViewMessagesForm.Width) div 2);
      edbxViewMessagesFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - ViewMessagesForm.Height) div 2);
    finally
      ViewMessagesForm.Free;
    end;
  end;
  Log.SendDebug('Флажок "' + chkbxViewMessagesFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxEnableAutoGetMessagesClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxEnableAutoGetMessages.Caption + '"',
    '{5C3B5E46-E8F7-4BD1-8092-16B88A617F55}');

  edbxAutoGetMessagesCycleDurationValue.Enabled := chkbxEnableAutoGetMessages.Checked;
  edbxAutoGetMessagesCycleDurationValue.Text := Routines.GetConditionalString
    (edbxAutoGetMessagesCycleDurationValue.Enabled, IntToStr(MainForm.Configuration.AutoGetMessagesCycleDurationValue),
    EmptyStr);
  Log.SendDebug('Флажок "' + chkbxEnableAutoGetMessages.Caption + '"' + Routines.GetConditionalString
    (chkbxEnableAutoGetMessages.Checked, 'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxAddEditPhoneFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  AddEditPhoneForm: TAddEditPhoneForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxAddEditPhoneFormPositionByCenter.Caption + '"',
    '{9D51B088-F24F-4EBC-9CDB-BBD50B769BBB}');

  b := chkbxAddEditPhoneFormPositionByCenter.Enabled and chkbxAddEditPhoneFormPositionByCenter.Checked;
  edbxAddEditPhoneFormPositionX.Enabled := not b;
  edbxAddEditPhoneFormPositionY.Enabled := not b;
  if b then
  begin
    edbxAddEditPhoneFormPositionX.Text := EmptyStr;
    edbxAddEditPhoneFormPositionY.Text := EmptyStr;
  end
  else
  begin
    AddEditPhoneForm := TAddEditPhoneForm.Create(Self, MainForm.Configuration.AddEditPhoneFormPosition);
    try
      edbxAddEditPhoneFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - AddEditPhoneForm.Width) div 2);
      edbxAddEditPhoneFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - AddEditPhoneForm.Height) div 2);
    finally
      AddEditPhoneForm.Free;
    end;
  end;
  Log.SendDebug('Флажок "' + chkbxAddEditPhoneFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxAddMassMsrFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  AddMassMsrForm: TAddMassMsrForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxAddMassMsrFormPositionByCenter.Caption + '"',
    '{8E88B020-CF7F-4F40-9C02-B64741BD3133}');

  b := chkbxAddMassMsrFormPositionByCenter.Enabled and chkbxAddMassMsrFormPositionByCenter.Checked;
  edbxAddMassMsrFormPositionX.Enabled := not b;
  edbxAddMassMsrFormPositionY.Enabled := not b;
  if b then
  begin
    edbxAddMassMsrFormPositionX.Text := EmptyStr;
    edbxAddMassMsrFormPositionY.Text := EmptyStr;
  end
  else
  begin
    AddMassMsrForm := TAddMassMsrForm.Create(Self, MainForm.Configuration.AddMassMsrFormPosition);
    try
      edbxAddMassMsrFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - AddMassMsrForm.Width) div 2);
      edbxAddMassMsrFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - AddMassMsrForm.Height) div 2);
    finally
      AddMassMsrForm.Free;
    end;
  end;
  Log.SendDebug('Флажок "' + chkbxAddMassMsrFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxPermissionsFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  PermissionsForm: TPermissionsForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxPermissionsFormPositionByCenter.Caption + '"',
    '{D6CC8CB4-3B01-449C-84C4-8F3B55C9AE92}');

  b := chkbxPermissionsFormPositionByCenter.Enabled and chkbxPermissionsFormPositionByCenter.Checked;
  edbxPermissionsFormPositionX.Enabled := not b;
  edbxPermissionsFormPositionY.Enabled := not b;
  if b then
  begin
    edbxPermissionsFormPositionX.Text := EmptyStr;
    edbxPermissionsFormPositionY.Text := EmptyStr;
  end
  else
  begin
    PermissionsForm := TPermissionsForm.Create(Self, MainForm.Configuration.PermissionsFormPosition);
    try
      edbxPermissionsFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - PermissionsForm.Width) div 2);
      edbxPermissionsFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - PermissionsForm.Height) div 2);
    finally
      PermissionsForm.Free;
    end;
  end;
  Log.SendDebug('Флажок "' + chkbxPermissionsFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxClearingFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  // ClearingForm: TClearingForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxClearingFormPositionByCenter.Caption + '"',
    '{6EF352F0-799F-4ECB-8FA5-D283943475C6}');

  b := chkbxClearingFormPositionByCenter.Enabled and chkbxClearingFormPositionByCenter.Checked;
  edbxClearingFormPositionX.Enabled := not b;
  edbxClearingFormPositionY.Enabled := not b;
  if b then
  begin
    edbxClearingFormPositionX.Text := EmptyStr;
    edbxClearingFormPositionY.Text := EmptyStr;
  end
  else
  begin
    // ClearingForm:=TClearingForm.Create(Self);
    // try
    // edbxClearingFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-ClearingForm.Width)div 2);
    // edbxClearingFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-ClearingForm.Height)div 2);
    // finally
    // ClearingForm.Free;
    // end;
  end;
  Log.SendDebug('Флажок "' + chkbxClearingFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxCustomHelpFileClick(Sender: TObject);
var
  bCustomHelpFile: Boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxCustomHelpFile.Caption + '"',
    '{C4007F3B-8108-4F5D-8699-A1855EC707B1}');

  bCustomHelpFile := chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked;

  edbxCustomHelpFileValue.Enabled := bCustomHelpFile;
  actChooseCustomHelpFile.Enabled := bCustomHelpFile;
  Log.SendDebug('Действие "' + actChooseCustomHelpFile.Caption + '" ' + Routines.GetConditionalString
    (actChooseCustomHelpFile.Enabled, 'в', 'от') + 'ключено.');
  if not bCustomHelpFile then
  begin
    edbxCustomHelpFileValue.Text := EmptyStr;
  end;

  Log.SendDebug('Флажок "' + chkbxCustomHelpFile.Caption + '"' + Routines.GetConditionalString(bCustomHelpFile, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxMainFormPositionByCenterClick(Sender: TObject);
var
  bMainFormPositionByCenter: Boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxMainFormPositionByCenter.Caption + '"',
    '{0C75BE73-4F1F-4C3E-8938-728609D1E4F1}');

  bMainFormPositionByCenter := chkbxMainFormPositionByCenter.Checked and chkbxMainFormPositionByCenter.Enabled;
  edbxMainFormPositionX.Enabled := not bMainFormPositionByCenter;
  edbxMainFormPositionY.Enabled := not bMainFormPositionByCenter;
  edbxMainFormPositionX.Text := Routines.GetConditionalString(edbxMainFormPositionX.Enabled,
    IntToStr(MainForm.Configuration.MainFormLeft), EmptyStr);
  edbxMainFormPositionY.Text := Routines.GetConditionalString(edbxMainFormPositionY.Enabled,
    IntToStr(MainForm.Configuration.MainFormTop), EmptyStr);

  Log.SendDebug('Флажок "' + chkbxMainFormPositionByCenter.Caption + '"' + Routines.GetConditionalString
    (bMainFormPositionByCenter, 'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxMaintenanceFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  // MaintenanceForm: TMaintenanceForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxMaintenanceFormPositionByCenter.Caption + '"',
    '{4F229484-7E9F-42E6-A641-FA1713C99D80}');

  b := chkbxMaintenanceFormPositionByCenter.Enabled and chkbxMaintenanceFormPositionByCenter.Checked;
  edbxMaintenanceFormPositionX.Enabled := not b;
  edbxMaintenanceFormPositionY.Enabled := not b;
  if b then
  begin
    edbxMaintenanceFormPositionX.Text := EmptyStr;
    edbxMaintenanceFormPositionY.Text := EmptyStr;
  end
  else
  begin
    // MaintenanceForm:=TMaintenanceForm.Create(Self);
    // try
    // edbxMaintenanceFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-MaintenanceForm.Width)div 2);
    // edbxMaintenanceFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-MaintenanceForm.Height)div 2);
    // finally
    // MaintenanceForm.Free;
    // end;
  end;
  Log.SendDebug('Флажок "' + chkbxMaintenanceFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в',
    'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxConfigurationFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxConfigurationFormPositionByCenter.Caption + '"',
    '{BED5B417-AF81-44BC-A216-3C6D966C8A3E}');

  b := chkbxConfigurationFormPositionByCenter.Enabled and chkbxConfigurationFormPositionByCenter.Checked;
  edbxConfigurationFormPositionX.Enabled := not b;
  edbxConfigurationFormPositionY.Enabled := not b;
  if b then
  begin
    edbxConfigurationFormPositionX.Text := EmptyStr;
    edbxConfigurationFormPositionY.Text := EmptyStr;
  end
  else
  begin
    edbxConfigurationFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - Width) div 2);
    edbxConfigurationFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - Height) div 2);
  end;
  Log.SendDebug('Флажок "' + chkbxConfigurationFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b,
    'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxOrganizationPanelHalfHeightClick(Sender: TObject);
var
  bOrganizationPanelHalfHeight: Boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxOrganizationPanelHalfHeight.Caption + '"',
    '{DB478623-5C76-41CE-AD55-E8E101D15815}');

  bOrganizationPanelHalfHeight := chkbxOrganizationPanelHalfHeight.Checked and chkbxOrganizationPanelHalfHeight.Enabled;
  edbxOrganizationPanelHeightValue.Enabled := not bOrganizationPanelHalfHeight;
  edbxOrganizationPanelHeightValue.Text := Routines.GetConditionalString(bOrganizationPanelHalfHeight, EmptyStr,
    IntToStr(MainForm.Configuration.OrganizationPanelHeightValue));

  Log.SendDebug('Флажок "' + chkbxOrganizationPanelHalfHeight.Caption + '"' +
    Routines.GetConditionalString(bOrganizationPanelHalfHeight, 'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxPhonesFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  // PhonesForm: TPhonesForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxPhonesFormPositionByCenter.Caption + '"',
    '{B3057ACB-A356-4036-997D-FC6034C1974F}');

  b := chkbxPhonesFormPositionByCenter.Enabled and chkbxPhonesFormPositionByCenter.Checked;
  edbxPhonesFormPositionX.Enabled := not b;
  edbxPhonesFormPositionY.Enabled := not b;
  if b then
  begin
    edbxPhonesFormPositionX.Text := EmptyStr;
    edbxPhonesFormPositionY.Text := EmptyStr;
  end
  else
  begin
    // PhonesForm:=TPhonesForm.Create(Self);
    // try
    // edbxPhonesFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-PhonesForm.Width)div 2);
    // edbxPhonesFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-PhonesForm.Height)div 2);
    // finally
    // PhonesForm.Free;
    // end;
  end;
  Log.SendDebug('Флажок "' + chkbxPhonesFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, 'в', 'от')
    + 'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.edbxAutoGetMessagesCycleDurationValueChange(Sender: TObject);
begin
  if StrToIntDef(edbxAutoGetMessagesCycleDurationValue.Text, 1) < 1 then
  begin
    edbxAutoGetMessagesCycleDurationValue.Text := '1';
  end;
  if StrToIntDef(edbxAutoGetMessagesCycleDurationValue.Text, 1) > 60 then
  begin
    edbxAutoGetMessagesCycleDurationValue.Text := '60';
  end;
end;

procedure TConfigurationForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption = ' положения диалоговых окон' then
  begin
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
  end;
end;

procedure TConfigurationForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption = ' положения диалоговых окон' then
  begin
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEUP, 0);
  end;
end;

end.
