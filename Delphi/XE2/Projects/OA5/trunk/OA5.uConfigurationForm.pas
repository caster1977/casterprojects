{$WARN UNIT_PLATFORM OFF}
unit OA5.uConfigurationForm;

interface

uses
  CastersPackage.uLogProvider,
  CastersPackage.uTLogForm,
  Winapi.Windows,
  System.Types,
  System.Classes,
  Vcl.PlatformDefaultStyleActnCtrls,
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
  TConfigurationForm = class(TLogForm)
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
  Vcl.Dialogs,
  System.SysUtils,
  Winapi.Messages,
  Vcl.FileCtrl,
  CastersPackage.uLogKeeperData,
  CastersPackage.uRoutines,
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
  ProcedureHeader('���������-���������� �������� "' + actApply.Caption + '"', '{84DDCA84-3467-43EB-9005-E35C20FD98D0}');
  Do_Apply;
  ProcedureFooter;
end;

procedure TConfigurationForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "' + actClose.Caption + '"', '{609A88EE-6BC8-4F0F-9C3D-EC1D6FD1A50F}');
  Do_Close;
  ProcedureFooter;
end;

procedure TConfigurationForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "' + actHelp.Caption + '"', '{0CB39D36-EC59-4C76-AFE5-1718B99DA0CA}');
  Do_Help;
  ProcedureFooter;
end;

procedure TConfigurationForm.actPreviousPageExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "' + actPreviousPage.Caption + '"',
    '{50728BC6-7E7C-4D0D-9C17-E7919DE4A4C3}');
  Do_PreviousPage;
  ProcedureFooter;
end;

procedure TConfigurationForm.actNextPageExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "' + actNextPage.Caption + '"',
    '{0D4FC270-5B1E-4E59-8EBF-89ADBAC0E89F}');
  Do_NextPage;
  ProcedureFooter;
end;

procedure TConfigurationForm.actChooseReportFolderExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "' + actChooseReportFolder.Caption + '"',
    '{0F2D97AB-C59D-456A-ABCA-C390806F896C}');
  Do_ChooseCustomReportFolder;
  ProcedureFooter;
end;

procedure TConfigurationForm.actChooseCustomHelpFileExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "' + actChooseCustomHelpFile.Caption + '"',
    '{708E3642-722E-4556-9774-2F813BD540ED}');
  Do_ChooseCustomHelpFile;
  ProcedureFooter;
end;

procedure TConfigurationForm.actChooseCustomLogClientFileExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "' + actChooseReportFolder.Caption + '"',
    '{24E77954-BFEB-4128-B764-C31ED26D068C}');
  Do_ChooseLogClientFile;
  ProcedureFooter;
end;

procedure TConfigurationForm.actDefaultsExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "' + actDefaults.Caption + '"',
    '{9B790597-F8F3-47A8-96FE-472EFFB6020E}');
  Do_Defaults;
  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Apply;
var
  FormPosition: TFormPosition;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrOk', '{55D9E5EB-97B6-47FC-B149-348070521077}');

  ModalResult := mrOk;
  Log.SendInfo('������� ��������� �������� ��������� ���� ������������ �������������.');

  with MainForm.Configuration do
  begin
    // ������� "��������� ����������"
    ShowSplashAtStart := chkbxShowSplashAtStart.Enabled and chkbxShowSplashAtStart.Checked;
    ShowToolbar := chkbxShowToolbar.Enabled and chkbxShowToolbar.Checked;
    ShowStatusbar := chkbxShowStatusbar.Enabled and chkbxShowStatusbar.Checked;
    ShowEditboxHints := chkbxShowEditboxHints.Enabled and chkbxShowEditboxHints.Checked;
    ShowCommonSearchEditbox := chkbxShowCommonSearchEditbox.Enabled and chkbxShowCommonSearchEditbox.Checked;
    ShowID := chkbxShowID.Enabled and chkbxShowID.Checked;
    UseMultibuffer := chkbxUseMultibuffer.Enabled and chkbxUseMultibuffer.Checked;
    ShowConfirmationOnQuit := chkbxShowConfirmationOnQuit.Enabled and chkbxShowConfirmationOnQuit.Checked;

    // ������� "��������� ������� ��������� ������"
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
      Trim(edbxFlushLogOnStringsQuantityValue.Text), EmptyStr), DefaultValue_FlushLogOnStringsQuantityValue);
    FlushLogOnClearingLog := chkbxFlushLogOnClearingLog.Enabled and chkbxFlushLogOnClearingLog.Checked;
    FlushLogOnApply := chkbxFlushLogOnApply.Enabled and chkbxFlushLogOnApply.Checked;
    CustomLogClientFile := chkbxCustomLogClientFile.Enabled and chkbxCustomLogClientFile.Checked;
    CustomLogClientFileValue := Routines.GetConditionalString(chkbxCustomLogClientFile.Enabled and
      chkbxCustomLogClientFile.Checked and chkbxEnableLog.Enabled and chkbxEnableLog.Checked and
      edbxCustomLogClientFileValue.Enabled, Trim(edbxCustomLogClientFileValue.Text),
      DefaultValue_CustomLogClientFileValue);

    // ������� "��������� ��������� ���������� ����"
    FormPosition.bCenter := chkbxLoginFormPositionByCenter.Enabled and chkbxLoginFormPositionByCenter.Checked;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxLoginFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxLoginFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    LoginFormPosition := FormPosition;

    FormPosition.bCenter := chkbxConfigurationFormPositionByCenter.Checked and
      chkbxConfigurationFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxConfigurationFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxConfigurationFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    ConfigurationFormPosition := FormPosition;

    FormPosition.bCenter := chkbxUsersFormPositionByCenter.Checked and chkbxUsersFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxUsersFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxUsersFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    UsersFormPosition := FormPosition;

    FormPosition.bCenter := chkbxSetPasswordFormPositionByCenter.Checked and
      chkbxSetPasswordFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxSetPasswordFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxSetPasswordFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    SetPasswordFormPosition := FormPosition;

    FormPosition.bCenter := chkbxReportFormPositionByCenter.Checked and chkbxReportFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxReportFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxReportFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    ReportFormPosition := FormPosition;

    FormPosition.bCenter := chkbxMaintenanceFormPositionByCenter.Checked and
      chkbxMaintenanceFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxMaintenanceFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxMaintenanceFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    MaintenanceFormPosition := FormPosition;

    FormPosition.bCenter := chkbxClearingFormPositionByCenter.Checked and chkbxClearingFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxClearingFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxClearingFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    ClearingFormPosition := FormPosition;

    FormPosition.bCenter := chkbxViewMessagesFormPositionByCenter.Checked and
      chkbxViewMessagesFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxViewMessagesFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxViewMessagesFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    ViewMessagesFormPosition := FormPosition;

    FormPosition.bCenter := chkbxCreateMessageFormPositionByCenter.Checked and
      chkbxCreateMessageFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxCreateMessageFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxCreateMessageFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    CreateMessageFormPosition := FormPosition;

    FormPosition.bCenter := chkbxViewMessageFormPositionByCenter.Checked and
      chkbxViewMessageFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxViewMessageFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxViewMessageFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    ViewMessageFormPosition := FormPosition;

    FormPosition.bCenter := chkbxPhonesFormPositionByCenter.Checked and chkbxPhonesFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxPhonesFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxPhonesFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    PhonesFormPosition := FormPosition;

    FormPosition.bCenter := chkbxAddEditPhoneFormPositionByCenter.Checked and
      chkbxAddEditPhoneFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxAddEditPhoneFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxAddEditPhoneFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    AddEditPhoneFormPosition := FormPosition;

    FormPosition.bCenter := chkbxAddMassMsrFormPositionByCenter.Checked and chkbxAddMassMsrFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxAddMassMsrFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxAddMassMsrFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    AddMassMsrFormPosition := FormPosition;

    FormPosition.bCenter := chkbxPermissionsFormPositionByCenter.Checked and
      chkbxPermissionsFormPositionByCenter.Enabled;
    FormPosition.x := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxPermissionsFormPositionX.Text), EmptyStr), DefaultValue_FormPosition_x);
    FormPosition.y := StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,
      Trim(edbxPermissionsFormPositionY.Text), EmptyStr), DefaultValue_FormPosition_y);
    PermissionsFormPosition := FormPosition;

    // ������� "��������� ��������� �����������"
    StoreLogin := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked;
    StorePassword := chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
    AutoLogon := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and
      chkbxStoreLastPassword.Checked and chkbxAutoLogon.Enabled and chkbxAutoLogon.Checked;

    // ������� "����������� � ������� ���� ������ ������"
    if vleRNE4SERVER.Enabled then
    begin
      with RNE4Server, vleRNE4SERVER do
      begin
        Host := Trim(Cells[1, 1]);
        Port := StrToIntDef(Trim(Cells[1, 2]), DefaultValue_RNE4Server_Port);
        Timeout := StrToIntDef(Trim(Cells[1, 3]), DefaultValue_RNE4Server_Timeout);
        Compression := Trim(Cells[1, 4]) = '��';
        Database := Trim(Cells[1, 5]);
      end;
    end;

    // ������� "����������� � ������� ������� ������ �����������"
    if vleRNE4MESSAGESSERVER.Enabled then
    begin
      with MessagesServer, vleRNE4MESSAGESSERVER do
      begin
        Host := Trim(Cells[1, 1]);
        Port := StrToIntDef(Trim(Cells[1, 2]), DefaultValue_MessagesServer_Port);
        Timeout := StrToIntDef(Trim(Cells[1, 3]), DefaultValue_MessagesServer_Timeout);
        Compression := Trim(Cells[1, 4]) = '��';
        Database := Trim(Cells[1, 5]);
      end;
    end;

    // ������� "��������� ������������ �������"
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
      rbSaveIntoTheCustomFolder.Checked, Trim(edbxCustomReportFolderValue.Text), DefaultValue_CustomReportFolderValue);
    DontDemandOverwriteConfirmation := chkbxDontDemandOverwriteConfirmation.Enabled and
      chkbxDontDemandOverwriteConfirmation.Checked;
    AskForFileName := chkbxAskForFileName.Enabled and chkbxAskForFileName.Checked;

    // ������� "��������� ������ ����������"

    // ������� "��������� ������"
    LaunchAtStartup := chkbxLaunchAtStartup.Enabled and chkbxLaunchAtStartup.Checked;
    PlaySoundOnComplete := chkbxPlaySoundOnComplete.Enabled and chkbxPlaySoundOnComplete.Checked;
    EnableAutoGetMessages := chkbxEnableAutoGetMessages.Enabled and chkbxEnableAutoGetMessages.Checked;
    AutoGetMessagesCycleDurationValue :=
      StrToIntDef(Routines.GetConditionalString(chkbxEnableAutoGetMessages.Enabled and
      chkbxEnableAutoGetMessages.Checked and edbxAutoGetMessagesCycleDurationValue.Enabled,
      Trim(edbxAutoGetMessagesCycleDurationValue.Text), IntToStr(DefaultValue_AutoGetMessagesCycleDurationValue)),
      DefaultValue_AutoGetMessagesCycleDurationValue);
    CustomHelpFile := chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked;
    CustomHelpFileValue := Routines.GetConditionalString(chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked and
      edbxCustomHelpFileValue.Enabled, Trim(edbxCustomHelpFileValue.Text), DefaultValue_CustomHelpFileValue);

    // ������� "��������� �������� ����"
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
          MainFormWidth := StrToIntDef(Trim(edbxMainFormWidth.Text), DefaultValue_MainFormWidth);
        end
        else
        begin
          MainFormWidth := DefaultValue_MainFormWidth;
        end;

        if edbxMainFormHeight.Enabled then
        begin
          MainFormHeight := StrToIntDef(Trim(edbxMainFormHeight.Text), DefaultValue_MainFormHeight);
        end
        else
        begin
          MainFormHeight := DefaultValue_MainFormHeight;
        end;
        MainFormLeft := (Screen.WorkAreaWidth - MainFormWidth) div 2;
        MainFormTop := (Screen.WorkAreaHeight - MainFormHeight) div 2;
      end
      else
      begin
        if edbxMainFormPositionX.Enabled then
        begin
          MainFormLeft := StrToIntDef(Trim(edbxMainFormPositionX.Text), DefaultValue_MainFormLeft);
        end
        else
        begin
          MainFormLeft := DefaultValue_MainFormLeft;
        end;

        if edbxMainFormPositionY.Enabled then
        begin
          MainFormTop := StrToIntDef(Trim(edbxMainFormPositionY.Text), DefaultValue_MainFormTop);
        end
        else
        begin
          MainFormTop := DefaultValue_MainFormTop;
        end;

        if edbxMainFormWidth.Enabled then
        begin
          MainFormWidth := StrToIntDef(Trim(edbxMainFormWidth.Text), DefaultValue_MainFormWidth);
        end
        else
        begin
          MainFormWidth := DefaultValue_MainFormWidth;
        end;

        if edbxMainFormHeight.Enabled then
        begin
          MainFormHeight := StrToIntDef(Trim(edbxMainFormHeight.Text), DefaultValue_MainFormHeight);
        end
        else
        begin
          MainFormHeight := DefaultValue_MainFormHeight;
        end;
      end;

    // ������� "��������� ����������� ����������"
    OrganizationPanelHeightValue :=
      StrToIntDef(Routines.GetConditionalString(chkbxOrganizationPanelHalfHeight.Enabled and
      chkbxOrganizationPanelHalfHeight.Checked, EmptyStr, Trim(edbxOrganizationPanelHeightValue.Text)),
      DefaultValue_OrganizationPanelHeightValue);
    OrganizationPanelHalfHeight := chkbxOrganizationPanelHalfHeight.Enabled and
      chkbxOrganizationPanelHalfHeight.Checked;
    DataPanelWidthValue := StrToIntDef(Routines.GetConditionalString(chkbxDataPanelHalfWidth.Enabled and
      chkbxDataPanelHalfWidth.Checked, EmptyStr, Trim(edbxDataPanelWidthValue.Text)), DefaultValue_DataPanelWidthValue);
    DataPanelHalfWidth := chkbxDataPanelHalfWidth.Enabled and chkbxDataPanelHalfWidth.Checked;
    ShowDataInOtherInfoPanel := chkbxShowDataInOtherInfoPanel.Enabled and chkbxShowDataInOtherInfoPanel.Checked;
    ShowMeasuresListAsRichEdit := chkbxShowMeasuresListAsRichEdit.Enabled and chkbxShowMeasuresListAsRichEdit.Checked;
    MarkSearchedStrings := chkbxMarkSearchedStrings.Enabled and chkbxMarkSearchedStrings.Checked;
    PutTownAtTheEnd := chkbxPutTownAtTheEnd.Enabled and chkbxPutTownAtTheEnd.Checked;
  end;

  Log.SendInfo('���� ��������� �������� ��������� �������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Close;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', '{6B58486E-78C2-4F8B-9923-BFC7F5FEA88C}');

  ModalResult := mrClose;
  Log.SendInfo('������� ��������� �������� ��������� ���� �������� �������������.');
  Log.SendInfo('���� ��������� �������� ��������� �������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Help;
begin
  ProcedureHeader('��������� ������ ����������� �������', '{4852C968-A8CC-4A2B-947E-4BA717D6A8EE}');

  Log.SendInfo('������������ ������� �������� ����������� ����� ���������...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    GenerateError('��������, ���������� ���� � ������ ��������� �� ������.');
  end;

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_PreviousPage;
var
  i: integer;
begin
  ProcedureHeader('��������� ����������� ���������� �������� �������� ���������',
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
  ProcedureHeader('��������� ����������� ��������� �������� �������� ���������',
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
  ProcedureHeader('��������� ������ ���������� ����������� ����� � ���������',
    '{DBF9ACD7-9F70-4D0A-9D90-CA893744CBBB}');

  iOldBusyCounter := MainForm.iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
  MainForm.iBusyCounter := 0; // ��������� �������� ����� ��������� ���������� ����
  MainForm.Refresh_BusyState; // ���������� ��������� ����������

  with TOpenDialog.Create(Self) do
    try
      Filter := '���� ������� � ���������|' + StringReplace(ExtractFileName(Application.ExeName), '.exe', '.chm',
        [rfReplaceAll, rfIgnoreCase]) + '|���������� ����� ������� .CHM|*.chm|���������� ����� ������� .HLP|*.hlp';
      DefaultExt := 'chm';
      Title := '�������� ���� �������...';
      FilterIndex := 1;
      Options := [ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName = EmptyStr then
        begin
          GenerateError('�������� ������ ��� ������ ����� ������� - ���� �� ��� ������!');
        end
        else
          if not FileExists(FileName) then
          begin
            GenerateError('�������� ������ ��� ������ ����� ������� - ��������� ���� �� ����������!');
          end
          else
          begin
            edbxCustomHelpFileValue.Text := FileName;
            Log.SendDebug('� �������� ���������� ����������� ����� ������� ���� "' + sPath + '".');
          end;
    finally
      Free;
    end;

  MainForm.iBusyCounter := iOldBusyCounter; // ����������� ������� �������� ��������
  MainForm.Refresh_BusyState; // ���������� ��������� ����������

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_ChooseCustomReportFolder;
var
  s, sPath: string;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('��������� ������ ����� ��� ���������� �������', '{58DA7933-E4BD-4402-9E83-2446DB94BE14}');

  iOldBusyCounter := MainForm.iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
  MainForm.iBusyCounter := 0; // ��������� �������� ����� ��������� ���������� ����
  MainForm.Refresh_BusyState; // ���������� ��������� ����������

  s := edbxCustomReportFolderValue.Text;

  if SelectDirectory('�������� �����', EmptyStr, s, [sdNewFolder, sdNewUI], Self) then
    if (s <> EmptyStr) then
    begin
      sPath := IncludeTrailingPathDelimiter(sPath);
      if System.SysUtils.DirectoryExists(sPath) then
      begin
        edbxCustomReportFolderValue.Text := sPath;
        Log.SendDebug('� �������� ����� ��� ���������� ������� ������� ����� "' + sPath + '".');
      end
      else
      begin
        edbxCustomReportFolderValue.Text := EmptyStr;
        GenerateError('�������� ������ ��� ������ ����� - ��������� ����� �� ����������!');
      end;
    end;

  MainForm.iBusyCounter := iOldBusyCounter; // ����������� ������� �������� ��������
  MainForm.Refresh_BusyState; // ���������� ��������� ����������

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_ChooseLogClientFile;
var
  sPath: string;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('��������� ������ �������� ������� ����������������', '{DCD63D88-72D9-42E5-91EC-35906B335D27}');

  iOldBusyCounter := MainForm.iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
  MainForm.iBusyCounter := 0; // ��������� �������� ����� ��������� ���������� ����
  MainForm.Refresh_BusyState; // ���������� ��������� ����������

  with TOpenDialog.Create(Self) do
    try
      Filter := '���� ������ ���-�������|LogKeeper.exe|����������� �����|*.exe';
      DefaultExt := 'exe';
      Title := '�������� ���� �������� ������� ����������������...';
      FilterIndex := 1;
      Options := [ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName = EmptyStr then
          GenerateError('�������� ������ ��� ������ ����� �������� ������� ���������������� - ���� �� ��� ������!')
        else
          if not FileExists(FileName) then
            GenerateError
              ('�������� ������ ��� ������ ����� �������� ������� ���������������� - ��������� ���� �� ����������!')
          else
          begin
            edbxCustomLogClientFileValue.Text := FileName;
            Log.SendDebug('� �������� ����� �������� ������� ���������������� ������ ���� "' + sPath + '".');
          end;
    finally
      Free;
    end;

  MainForm.iBusyCounter := iOldBusyCounter; // ����������� ������� �������� ��������
  MainForm.Refresh_BusyState; // ���������� ��������� ����������

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_PageSelect;
var
  i: integer;
begin
  ProcedureHeader
    ('��������� ���������� ��������� ��������� ���������� � ����������� �� ���������� ������ ����������� ������ ��������',
    '{396B4482-5CD9-4C26-8AE4-B5CC0F52CF20}');

  // ����� � �������� ������ �������� � ����������
  for i := 0 to PageControl1.PageCount - 1 do
  begin
    if PageControl1.Pages[i].Caption = cbPage.Items[cbPage.ItemIndex] then
    begin
      PageControl1.ActivePageIndex := i;
    end;
  end;

  // ����������� �������� ������ �������� � �������� �� ���������
  if (PageControl1.ActivePage.Caption = ' ����������� � ������� ���� ������ ������') or
    (PageControl1.ActivePage.Caption = ' ����������� � ������� ������� ������ �����������') then
  begin
    if PageControl1.ActivePage.Caption = ' ����������� � ������� ���� ������ ������' then
    begin
      actDefaults.Enabled := vleRNE4SERVER.Enabled;
    end;
    if PageControl1.ActivePage.Caption = ' ����������� � ������� ������� ������ �����������' then
    begin
      actDefaults.Enabled := vleRNE4MESSAGESSERVER.Enabled;
    end;
  end
  else
  begin
    actDefaults.Enabled := not(PageControl1.ActivePage.Caption = ' ������ ����������');
  end;
  Log.SendDebug('�������� "' + actDefaults.Caption + '" ' + Routines.GetConditionalString(actDefaults.Enabled, '�',
    '��') + '�������.');

  // ����������� �������� �������� � ��������� ������ � ������ �����������
  actLineUp.Visible := (PageControl1.ActivePage.Caption = ' ������ ����������') and sgAutoReplaceList.Visible and
    sgAutoReplaceList.Enabled;
  actLineDown.Visible := actLineUp.Visible;

  ProcedureFooter;
end;

procedure TConfigurationForm.CreateBooleanValuesList;
begin
  FBooleanValuesList := TStringList.Create;
  FBooleanValuesList.Add('���');
  FBooleanValuesList.Add('��');
end;

procedure TConfigurationForm.Do_Defaults;
begin
  ProcedureHeader('��������� ������ �������� � ��������� �� ���������', '{EDC577E6-6D47-4DC2-973E-AD820C7AC588}');

  // ������� "��������� ����������"
  if PageControl1.ActivePage.Caption = ' ����������' then
  begin
    // ����������� �������� �� ��������� ��� ���������
    chkbxShowSplashAtStart.Checked := DefaultValue_ShowSplashAtStart;
    chkbxShowToolbar.Checked := DefaultValue_ShowToolbar;
    chkbxShowStatusbar.Checked := DefaultValue_ShowStatusbar;
    chkbxShowEditboxHints.Checked := DefaultValue_ShowEditboxHints;
    chkbxShowCommonSearchEditbox.Checked := DefaultValue_ShowCommonSearchEditbox;
    chkbxShowID.Checked := DefaultValue_ShowID;
    chkbxUseMultibuffer.Checked := DefaultValue_UseMultibuffer;
    chkbxShowConfirmationOnQuit.Checked := DefaultValue_ShowConfirmationOnQuit;
  end;

  // ������� "��������� ������� ��������� ������"
  if PageControl1.ActivePage.Caption = ' ������� ��������� ������' then
  begin
    // ����������� �������� �� ��������� ��� ��������� ����������
    chkbxEnableLog.Checked := DefaultValue_EnableLog;
    chkbxKeepErrorLog.Checked := (lmtError in DefaultValue_KeepLogTypes) and DefaultValue_EnableLog;
    chkbxKeepWarningLog.Checked := (lmtWarning in DefaultValue_KeepLogTypes) and DefaultValue_EnableLog;
    chkbxKeepInfoLog.Checked := (lmtInfo in DefaultValue_KeepLogTypes) and DefaultValue_EnableLog;
    chkbxKeepSQLLog.Checked := (lmtSQL in DefaultValue_KeepLogTypes) and DefaultValue_EnableLog;
    chkbxKeepDebugLog.Checked := (lmtDebug in DefaultValue_KeepLogTypes) and DefaultValue_EnableLog;
    chkbxFlushLogOnExit.Checked := DefaultValue_FlushLogOnExit and DefaultValue_EnableLog;
    chkbxFlushLogOnStringsQuantity.Checked := DefaultValue_FlushLogOnStringsQuantity and DefaultValue_EnableLog;
    edbxFlushLogOnStringsQuantityValue.Text := Routines.GetConditionalString(DefaultValue_FlushLogOnStringsQuantity and
      DefaultValue_EnableLog, IntToStr(DefaultValue_FlushLogOnStringsQuantityValue), EmptyStr);
    chkbxFlushLogOnClearingLog.Checked := DefaultValue_FlushLogOnClearingLog and DefaultValue_EnableLog;
    chkbxFlushLogOnApply.Checked := DefaultValue_FlushLogOnApply and DefaultValue_EnableLog;
    chkbxCustomLogClientFile.Checked := DefaultValue_CustomLogClientFile and DefaultValue_EnableLog;
    edbxCustomLogClientFileValue.Text := Routines.GetConditionalString(DefaultValue_CustomLogClientFile and
      DefaultValue_EnableLog, DefaultValue_CustomLogClientFileValue, EmptyStr);
    // ����������� ������� � ��������� ����������
    lblShowData.Enabled := DefaultValue_EnableLog;
    chkbxKeepErrorLog.Enabled := DefaultValue_EnableLog;
    chkbxKeepWarningLog.Enabled := DefaultValue_EnableLog;
    chkbxKeepInfoLog.Enabled := DefaultValue_EnableLog;
    chkbxKeepSQLLog.Enabled := DefaultValue_EnableLog;
    chkbxKeepDebugLog.Enabled := DefaultValue_EnableLog;
    lblFlushLog.Enabled := DefaultValue_EnableLog;
    chkbxFlushLogOnExit.Enabled := DefaultValue_EnableLog;
    chkbxFlushLogOnStringsQuantity.Enabled := DefaultValue_EnableLog;
    edbxFlushLogOnStringsQuantityValue.Enabled := DefaultValue_EnableLog;
    chkbxFlushLogOnClearingLog.Enabled := DefaultValue_EnableLog;
    chkbxFlushLogOnApply.Enabled := DefaultValue_EnableLog;
    chkbxCustomLogClientFile.Enabled := DefaultValue_EnableLog;
    edbxCustomLogClientFileValue.Enabled := DefaultValue_CustomLogClientFile and DefaultValue_EnableLog;
    actChooseCustomLogClientFile.Enabled := DefaultValue_CustomLogClientFile and DefaultValue_EnableLog;
    Log.SendDebug('�������� "' + actChooseCustomLogClientFile.Caption + '" ' +
      Routines.GetConditionalString(actChooseCustomLogClientFile.Enabled, '�', '��') + '�������.');
  end;

  // ������� "��������� ��������� ���������� ����"
  if PageControl1.ActivePage.Caption = ' ��������� ���������� ����' then
  begin
    chkbxLoginFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxLoginFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxLoginFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxLoginFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxLoginFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxConfigurationFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxConfigurationFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxConfigurationFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxConfigurationFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxConfigurationFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxUsersFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxUsersFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxUsersFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxUsersFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxUsersFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxSetPasswordFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxSetPasswordFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxSetPasswordFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxSetPasswordFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxSetPasswordFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxReportFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxReportFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxReportFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxReportFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxReportFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxMaintenanceFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxMaintenanceFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxMaintenanceFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxMaintenanceFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxMaintenanceFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxClearingFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxClearingFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxClearingFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxClearingFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxClearingFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxViewMessagesFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxViewMessagesFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxViewMessagesFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxViewMessagesFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxViewMessagesFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxCreateMessageFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxCreateMessageFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxCreateMessageFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxCreateMessageFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxCreateMessageFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxViewMessageFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxViewMessageFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxViewMessageFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxViewMessageFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxViewMessageFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxPhonesFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxPhonesFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxPhonesFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxPhonesFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxPhonesFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxAddEditPhoneFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxAddEditPhoneFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxAddEditPhoneFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxAddEditPhoneFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxAddEditPhoneFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxAddMassMsrFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxAddMassMsrFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxAddMassMsrFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxAddMassMsrFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxAddMassMsrFormPositionY.Enabled := not DefaultValue_FormPosition_Center;

    chkbxPermissionsFormPositionByCenter.Checked := DefaultValue_FormPosition_Center;
    edbxPermissionsFormPositionX.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_x));
    edbxPermissionsFormPositionY.Text := Routines.GetConditionalString(DefaultValue_FormPosition_Center, EmptyStr,
      IntToStr(DefaultValue_FormPosition_y));
    edbxPermissionsFormPositionX.Enabled := not DefaultValue_FormPosition_Center;
    edbxPermissionsFormPositionY.Enabled := not DefaultValue_FormPosition_Center;
  end;

  // ������� "��������� ��������� �����������"
  if PageControl1.ActivePage.Caption = ' ��������� �����������' then
  begin
    // ����������� �������� �� ��������� ��� ��������� ����������
    chkbxStoreLastLogin.Checked := DefaultValue_StoreLogin;
    chkbxStoreLastPassword.Checked := DefaultValue_StorePassword;
    chkbxAutoLogon.Checked := DefaultValue_AutoLogon and DefaultValue_StoreLogin and DefaultValue_StorePassword;
    // ����������� ������� � ��������� ����������
    chkbxAutoLogon.Enabled := DefaultValue_StoreLogin and DefaultValue_StorePassword;
  end;

  // ������� "����������� � ������� ���� ������ ������"
  if PageControl1.ActivePage.Caption = ' ����������� � ������� ���� ������ ������' then
  begin
    // ����������� �������� �� ��������� ��� ��������� ����������
    vleRNE4SERVER.Cells[1, 1] := DefaultValue_RNE4Server_Host;
    vleRNE4SERVER.Cells[1, 2] := IntToStr(DefaultValue_RNE4Server_Port);
    vleRNE4SERVER.Cells[1, 3] := IntToStr(DefaultValue_RNE4Server_Timeout);
    vleRNE4SERVER.Cells[1, 4] := vleRNE4SERVER.ItemProps[3].PickList.Strings
      [integer(DefaultValue_RNE4Server_Compression)];
    vleRNE4SERVER.Cells[1, 5] := DefaultValue_RNE4Server_Database;
  end;

  // ������� "����������� � ������� ������� ������ �����������"
  if PageControl1.ActivePage.Caption = ' ����������� � ������� ������� ������ �����������' then
  begin
    // ����������� �������� �� ��������� ��� ��������� ����������
    vleRNE4MESSAGESSERVER.Cells[1, 1] := DefaultValue_MessagesServer_Host;
    vleRNE4MESSAGESSERVER.Cells[1, 2] := IntToStr(DefaultValue_MessagesServer_Port);
    vleRNE4MESSAGESSERVER.Cells[1, 3] := IntToStr(DefaultValue_MessagesServer_Timeout);
    vleRNE4MESSAGESSERVER.Cells[1, 4] := vleRNE4MESSAGESSERVER.ItemProps[3].PickList.Strings
      [integer(DefaultValue_MessagesServer_Compression)];
    vleRNE4MESSAGESSERVER.Cells[1, 5] := DefaultValue_MessagesServer_Database;
  end;

  // ������� "��������� ������������ �������"
  if PageControl1.ActivePage.Caption = ' ������������ �������' then
  begin
    // ����������� �������� �� ��������� ��� ��������� ����������
    rbSaveIntoTheTempFolder.Checked := DefaultValue_ReportFolder = rfTempFolder;
    rbSaveIntoTheApplicationFolder.Checked := DefaultValue_ReportFolder = rfApplicationFolder;
    rbSaveIntoTheCustomFolder.Checked := DefaultValue_ReportFolder = rfCustomFolder;
    edbxCustomReportFolderValue.Text := DefaultValue_CustomReportFolderValue;
    chkbxDontDemandOverwriteConfirmation.Checked := DefaultValue_DontDemandOverwriteConfirmation;
    chkbxAskForFileName.Checked := DefaultValue_AskForFileName;
    // ����������� ������� � ��������� ����������
    edbxCustomReportFolderValue.Enabled := DefaultValue_ReportFolder = rfCustomFolder;
    actChooseReportFolder.Enabled := DefaultValue_ReportFolder = rfCustomFolder;
    Log.SendDebug('�������� "' + actChooseReportFolder.Caption + '" ' + Routines.GetConditionalString
      (actChooseReportFolder.Enabled, '�', '��') + '�������.');
  end;

  // ������� "��������� ������"
  if PageControl1.ActivePage.Caption = ' ������' then
  begin
    // ����������� �������� �� ��������� ��� ��������� ����������
    chkbxLaunchAtStartup.Checked := DefaultValue_LaunchAtStartup;
    chkbxPlaySoundOnComplete.Checked := DefaultValue_PlaySoundOnComplete;
    chkbxEnableAutoGetMessages.Checked := DefaultValue_EnableAutoGetMessages;
    edbxAutoGetMessagesCycleDurationValue.Text := Routines.GetConditionalString(DefaultValue_EnableAutoGetMessages,
      IntToStr(DefaultValue_AutoGetMessagesCycleDurationValue), EmptyStr);
    chkbxCustomHelpFile.Checked := DefaultValue_CustomHelpFile;
    edbxCustomHelpFileValue.Text := Routines.GetConditionalString(DefaultValue_CustomHelpFile,
      DefaultValue_CustomHelpFileValue, EmptyStr);
    // ����������� ������� � ��������� ����������
    edbxAutoGetMessagesCycleDurationValue.Enabled := DefaultValue_EnableAutoGetMessages;
    edbxCustomHelpFileValue.Enabled := DefaultValue_CustomHelpFile;
    actChooseCustomHelpFile.Enabled := DefaultValue_CustomHelpFile;
    Log.SendDebug('�������� "' + actChooseCustomHelpFile.Caption + '" ' + Routines.GetConditionalString
      (actChooseCustomHelpFile.Enabled, '�', '��') + '�������.');
  end;

  // ������� "��������� �������� ����"
  if PageControl1.ActivePage.Caption = ' �������� ����' then
  begin
    // ����������� �������� �� ��������� ��� ��������� ����������
    chkbxFullScreenAtLaunch.Checked := DefaultValue_FullScreenAtLaunch;
    chkbxMainFormPositionByCenter.Checked := DefaultValue_MainFormPositionByCenter and
      (not DefaultValue_FullScreenAtLaunch);
    edbxMainFormPositionX.Text := Routines.GetConditionalString
      (not(DefaultValue_MainFormPositionByCenter or DefaultValue_FullScreenAtLaunch),
      IntToStr(DefaultValue_MainFormLeft), EmptyStr);
    edbxMainFormPositionY.Text := Routines.GetConditionalString
      (not(DefaultValue_MainFormPositionByCenter or DefaultValue_FullScreenAtLaunch),
      IntToStr(DefaultValue_MainFormTop), EmptyStr);
    edbxMainFormWidth.Text := Routines.GetConditionalString(DefaultValue_FullScreenAtLaunch, EmptyStr,
      IntToStr(DefaultValue_MainFormWidth));
    edbxMainFormHeight.Text := Routines.GetConditionalString(DefaultValue_FullScreenAtLaunch, EmptyStr,
      IntToStr(DefaultValue_MainFormHeight));
  end;

  // ������� "��������� ����������� ����������"
  if PageControl1.ActivePage.Caption = ' ����������� ����������' then
  begin
    // ����������� �������� �� ��������� ��� ��������� ����������
    edbxOrganizationPanelHeightValue.Text := Routines.GetConditionalString(DefaultValue_OrganizationPanelHalfHeight,
      EmptyStr, IntToStr(DefaultValue_OrganizationPanelHeightValue));
    chkbxOrganizationPanelHalfHeight.Checked := DefaultValue_OrganizationPanelHalfHeight;
    edbxDataPanelWidthValue.Text := Routines.GetConditionalString(DefaultValue_DataPanelHalfWidth, EmptyStr,
      IntToStr(DefaultValue_DataPanelWidthValue));
    chkbxDataPanelHalfWidth.Checked := DefaultValue_DataPanelHalfWidth;
    chkbxShowDataInOtherInfoPanel.Checked := DefaultValue_ShowDataInOtherInfoPanel;
    chkbxShowMeasuresListAsRichEdit.Checked := DefaultValue_ShowMeasuresListAsRichEdit;
    chkbxMarkSearchedStrings.Checked := DefaultValue_MarkSearchedStrings;
    chkbxPutTownAtTheEnd.Checked := DefaultValue_PutTownAtTheEnd;;
    // ����������� ������� � ��������� ����������
    edbxOrganizationPanelHeightValue.Enabled := not DefaultValue_OrganizationPanelHalfHeight;
    edbxDataPanelWidthValue.Enabled := not DefaultValue_DataPanelHalfWidth;
  end;

  Log.SendInfo('��������� ' + PageControl1.ActivePage.Caption +
    ' ���� �������� ������������� � �������� �� ���������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� ����������� ����', '{3D3256A6-E8E3-4709-A3B3-B7A6E90A75BF}');
  Log.SendInfo('���������� ���� �������� ���������.');
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
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxEnableLog.Caption + '"',
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
    IntToStr(DefaultValue_FlushLogOnStringsQuantityValue)), EmptyStr);

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
  Log.SendDebug('�������� "' + actChooseCustomLogClientFile.Caption + '" ' +
    Routines.GetConditionalString(actChooseCustomLogClientFile.Enabled, '�', '��') + '�������.');

  Log.SendDebug('������ "' + chkbxEnableLog.Caption + '"' + Routines.GetConditionalString(bUseLog, '�', '��') +
    '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
var
  bFlushLogOnStringsQuantity: Boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxFlushLogOnStringsQuantity.Caption + '"',
    '{56071FBF-61AE-472E-B52B-BC239C45CD7C}');

  bFlushLogOnStringsQuantity := chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;
  edbxFlushLogOnStringsQuantityValue.Enabled := bFlushLogOnStringsQuantity;
  edbxFlushLogOnStringsQuantityValue.Text := Routines.GetConditionalString(bFlushLogOnStringsQuantity,
    Routines.GetConditionalString(MainForm.Configuration.FlushLogOnStringsQuantityValue > 0,
    IntToStr(MainForm.Configuration.FlushLogOnStringsQuantityValue),
    IntToStr(DefaultValue_FlushLogOnStringsQuantityValue)), EmptyStr);

  Log.SendDebug('������ "' + chkbxFlushLogOnStringsQuantity.Caption + '"' + Routines.GetConditionalString
    (bFlushLogOnStringsQuantity, '�', '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxCustomLogClientFileClick(Sender: TObject);
var
  bCustomLogClientFile: Boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxCustomLogClientFile.Caption + '"',
    '{4CBC38D1-3DB9-480E-BA9A-246708A0C0A2}');

  bCustomLogClientFile := chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFileValue.Enabled := bCustomLogClientFile;
  actChooseCustomLogClientFile.Enabled := bCustomLogClientFile;
  Log.SendDebug('�������� "' + actChooseCustomLogClientFile.Caption + '" ' +
    Routines.GetConditionalString(actChooseCustomLogClientFile.Enabled, '�', '��') + '�������.');
  if not bCustomLogClientFile then
  begin
    edbxCustomLogClientFileValue.Text := EmptyStr;
  end;

  Log.SendDebug('������ "' + chkbxCustomLogClientFile.Caption + '"' + Routines.GetConditionalString
    (bCustomLogClientFile, '�', '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxDataPanelHalfWidthClick(Sender: TObject);
var
  bDataPanelHalfWidth: Boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxDataPanelHalfWidth.Caption + '"',
    '{E88569C6-BFE3-4AE7-B34B-6CA8179B0FEA}');

  bDataPanelHalfWidth := chkbxDataPanelHalfWidth.Checked and chkbxDataPanelHalfWidth.Enabled;
  edbxDataPanelWidthValue.Enabled := not bDataPanelHalfWidth;
  edbxDataPanelWidthValue.Text := Routines.GetConditionalString(bDataPanelHalfWidth, EmptyStr,
    IntToStr(MainForm.Configuration.DataPanelWidthValue));

  Log.SendDebug('������ "' + chkbxDataPanelHalfWidth.Caption + '"' + Routines.GetConditionalString(bDataPanelHalfWidth,
    '�', '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.rbSaveIntoTheCustomFolderClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� �����������', '{77B71A67-5A1E-4D56-ADE8-C42EBD13CAC0}');

  if Sender is TRadioButton then
  begin
    Log.SendInfo('������ ����������� "' + (Sender as TRadioButton).Caption + '".');
  end;

  edbxCustomReportFolderValue.Enabled := rbSaveIntoTheCustomFolder.Checked;
  actChooseReportFolder.Enabled := rbSaveIntoTheCustomFolder.Checked;
  Log.SendDebug('�������� "' + actChooseReportFolder.Caption + '" ' + Routines.GetConditionalString
    (actChooseReportFolder.Enabled, '�', '��') + '�������.');
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
    Key := #0; // "��������" ��� ��������� �������
  end;
end;

procedure TConfigurationForm.cbPageSelect(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� ������ ������ ����������� ������',
    '{DD1092FC-D170-451E-B28F-B678197E5C0D}');
  Do_PageSelect;
  ProcedureFooter;
end;

procedure TConfigurationForm.FormCreate(Sender: TObject);
const
  ICON_CONFIGURATION = 5;
begin
  ProcedureHeader('���������-���������� ������� �������� ����', '{928DE88A-9894-4B2A-B8AB-6D9BB130BCF6}');
  CreateBooleanValuesList;

  ImageListSmall.GetIcon(ICON_CONFIGURATION, Icon);
  actHelp.Enabled := Application.HelpFile <> EmptyStr;
  Log.SendDebug('�������� "' + actHelp.Caption + '" ' + Routines.GetConditionalString(actHelp.Enabled, '�', '��') +
    '�������.');

  with MainForm.Configuration do
  begin
    // ��������� ���������� ���������������� � ������������ � ����������� ���������
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;

    // ��������� ��������� ���� ������������ � ����������� �� ���������� ������������ ���������
    if ConfigurationFormPosition.bCenter then
    begin
      Position := poScreenCenter;
    end
    else
    begin
      Position := poDesigned;
      if ConfigurationFormPosition.x < Screen.WorkAreaLeft then
      begin
        Left := Screen.WorkAreaLeft;
      end
      else
      begin
        if ConfigurationFormPosition.x > Screen.WorkAreaLeft + Screen.WorkAreaWidth then
        begin
          Left := Screen.WorkAreaLeft + Screen.WorkAreaWidth - Width;
        end
        else
        begin
          Left := ConfigurationFormPosition.x;
        end;
      end;
      if ConfigurationFormPosition.y < Screen.WorkAreaTop then
      begin
        Top := Screen.WorkAreaTop;
      end
      else
      begin
        if ConfigurationFormPosition.y > Screen.WorkAreaTop + Screen.WorkAreaHeight then
        begin
          Top := Screen.WorkAreaTop + Screen.WorkAreaHeight - Height;
        end
        else
        begin
          Top := ConfigurationFormPosition.y;
        end;
      end;
    end;

    // ������� "��������� ����������"
    chkbxShowSplashAtStart.Checked := ShowSplashAtStart;
    chkbxShowToolbar.Checked := ShowToolbar;
    chkbxShowStatusbar.Checked := ShowStatusbar;
    chkbxShowEditboxHints.Checked := ShowEditboxHints;
    chkbxShowCommonSearchEditbox.Checked := ShowCommonSearchEditbox;
    chkbxShowID.Checked := ShowID;
    chkbxUseMultibuffer.Checked := UseMultibuffer;
    chkbxShowConfirmationOnQuit.Checked := ShowConfirmationOnQuit;

    // ������� "��������� ������� ��������� ������"
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
    Log.SendDebug('�������� "' + actChooseCustomLogClientFile.Caption + '" ' +
      Routines.GetConditionalString(actChooseCustomLogClientFile.Enabled, '�', '��') + '�������.');

    // ������� "��������� ��������� ���������� ����"
    ScrollBox1.VertScrollBar.Position := 0;

    chkbxLoginFormPositionByCenter.Checked := LoginFormPosition.bCenter;
    edbxLoginFormPositionX.Text := Routines.GetConditionalString(LoginFormPosition.bCenter, EmptyStr,
      IntToStr(LoginFormPosition.x));
    edbxLoginFormPositionY.Text := Routines.GetConditionalString(LoginFormPosition.bCenter, EmptyStr,
      IntToStr(LoginFormPosition.y));
    edbxLoginFormPositionX.Enabled := not LoginFormPosition.bCenter;
    edbxLoginFormPositionY.Enabled := not LoginFormPosition.bCenter;

    chkbxConfigurationFormPositionByCenter.Checked := ConfigurationFormPosition.bCenter;
    edbxConfigurationFormPositionX.Text := Routines.GetConditionalString(ConfigurationFormPosition.bCenter, EmptyStr,
      IntToStr(ConfigurationFormPosition.x));
    edbxConfigurationFormPositionY.Text := Routines.GetConditionalString(ConfigurationFormPosition.bCenter, EmptyStr,
      IntToStr(ConfigurationFormPosition.y));
    edbxConfigurationFormPositionX.Enabled := not ConfigurationFormPosition.bCenter;
    edbxConfigurationFormPositionY.Enabled := not ConfigurationFormPosition.bCenter;

    chkbxUsersFormPositionByCenter.Checked := UsersFormPosition.bCenter;
    edbxUsersFormPositionX.Text := Routines.GetConditionalString(UsersFormPosition.bCenter, EmptyStr,
      IntToStr(UsersFormPosition.x));
    edbxUsersFormPositionY.Text := Routines.GetConditionalString(UsersFormPosition.bCenter, EmptyStr,
      IntToStr(UsersFormPosition.y));
    edbxUsersFormPositionX.Enabled := not UsersFormPosition.bCenter;
    edbxUsersFormPositionY.Enabled := not UsersFormPosition.bCenter;

    chkbxSetPasswordFormPositionByCenter.Checked := SetPasswordFormPosition.bCenter;
    edbxSetPasswordFormPositionX.Text := Routines.GetConditionalString(SetPasswordFormPosition.bCenter, EmptyStr,
      IntToStr(SetPasswordFormPosition.x));
    edbxSetPasswordFormPositionY.Text := Routines.GetConditionalString(SetPasswordFormPosition.bCenter, EmptyStr,
      IntToStr(SetPasswordFormPosition.y));
    edbxSetPasswordFormPositionX.Enabled := not SetPasswordFormPosition.bCenter;
    edbxSetPasswordFormPositionY.Enabled := not SetPasswordFormPosition.bCenter;

    chkbxReportFormPositionByCenter.Checked := ReportFormPosition.bCenter;
    edbxReportFormPositionX.Text := Routines.GetConditionalString(ReportFormPosition.bCenter, EmptyStr,
      IntToStr(ReportFormPosition.x));
    edbxReportFormPositionY.Text := Routines.GetConditionalString(ReportFormPosition.bCenter, EmptyStr,
      IntToStr(ReportFormPosition.y));
    edbxReportFormPositionX.Enabled := not ReportFormPosition.bCenter;
    edbxReportFormPositionY.Enabled := not ReportFormPosition.bCenter;

    chkbxMaintenanceFormPositionByCenter.Checked := MaintenanceFormPosition.bCenter;
    edbxMaintenanceFormPositionX.Text := Routines.GetConditionalString(MaintenanceFormPosition.bCenter, EmptyStr,
      IntToStr(MaintenanceFormPosition.x));
    edbxMaintenanceFormPositionY.Text := Routines.GetConditionalString(MaintenanceFormPosition.bCenter, EmptyStr,
      IntToStr(MaintenanceFormPosition.y));
    edbxMaintenanceFormPositionX.Enabled := not MaintenanceFormPosition.bCenter;
    edbxMaintenanceFormPositionY.Enabled := not MaintenanceFormPosition.bCenter;

    chkbxClearingFormPositionByCenter.Checked := ClearingFormPosition.bCenter;
    edbxClearingFormPositionX.Text := Routines.GetConditionalString(ClearingFormPosition.bCenter, EmptyStr,
      IntToStr(ClearingFormPosition.x));
    edbxClearingFormPositionY.Text := Routines.GetConditionalString(ClearingFormPosition.bCenter, EmptyStr,
      IntToStr(ClearingFormPosition.y));
    edbxClearingFormPositionX.Enabled := not ClearingFormPosition.bCenter;
    edbxClearingFormPositionY.Enabled := not ClearingFormPosition.bCenter;

    chkbxViewMessagesFormPositionByCenter.Checked := ViewMessagesFormPosition.bCenter;
    edbxViewMessagesFormPositionX.Text := Routines.GetConditionalString(ViewMessagesFormPosition.bCenter, EmptyStr,
      IntToStr(ViewMessagesFormPosition.x));
    edbxViewMessagesFormPositionY.Text := Routines.GetConditionalString(ViewMessagesFormPosition.bCenter, EmptyStr,
      IntToStr(ViewMessagesFormPosition.y));
    edbxViewMessagesFormPositionX.Enabled := not ViewMessagesFormPosition.bCenter;
    edbxViewMessagesFormPositionY.Enabled := not ViewMessagesFormPosition.bCenter;

    chkbxCreateMessageFormPositionByCenter.Checked := CreateMessageFormPosition.bCenter;
    edbxCreateMessageFormPositionX.Text := Routines.GetConditionalString(CreateMessageFormPosition.bCenter, EmptyStr,
      IntToStr(CreateMessageFormPosition.x));
    edbxCreateMessageFormPositionY.Text := Routines.GetConditionalString(CreateMessageFormPosition.bCenter, EmptyStr,
      IntToStr(CreateMessageFormPosition.y));
    edbxCreateMessageFormPositionX.Enabled := not CreateMessageFormPosition.bCenter;
    edbxCreateMessageFormPositionY.Enabled := not CreateMessageFormPosition.bCenter;

    chkbxViewMessageFormPositionByCenter.Checked := ViewMessageFormPosition.bCenter;
    edbxViewMessageFormPositionX.Text := Routines.GetConditionalString(ViewMessageFormPosition.bCenter, EmptyStr,
      IntToStr(ViewMessageFormPosition.x));
    edbxViewMessageFormPositionY.Text := Routines.GetConditionalString(ViewMessageFormPosition.bCenter, EmptyStr,
      IntToStr(ViewMessageFormPosition.y));
    edbxViewMessageFormPositionX.Enabled := not ViewMessageFormPosition.bCenter;
    edbxViewMessageFormPositionY.Enabled := not ViewMessageFormPosition.bCenter;

    chkbxPhonesFormPositionByCenter.Checked := PhonesFormPosition.bCenter;
    edbxPhonesFormPositionX.Text := Routines.GetConditionalString(PhonesFormPosition.bCenter, EmptyStr,
      IntToStr(PhonesFormPosition.x));
    edbxPhonesFormPositionY.Text := Routines.GetConditionalString(PhonesFormPosition.bCenter, EmptyStr,
      IntToStr(PhonesFormPosition.y));
    edbxPhonesFormPositionX.Enabled := not PhonesFormPosition.bCenter;
    edbxPhonesFormPositionY.Enabled := not PhonesFormPosition.bCenter;

    chkbxAddEditPhoneFormPositionByCenter.Checked := AddEditPhoneFormPosition.bCenter;
    edbxAddEditPhoneFormPositionX.Text := Routines.GetConditionalString(AddEditPhoneFormPosition.bCenter, EmptyStr,
      IntToStr(AddEditPhoneFormPosition.x));
    edbxAddEditPhoneFormPositionY.Text := Routines.GetConditionalString(AddEditPhoneFormPosition.bCenter, EmptyStr,
      IntToStr(AddEditPhoneFormPosition.y));
    edbxAddEditPhoneFormPositionX.Enabled := not AddEditPhoneFormPosition.bCenter;
    edbxAddEditPhoneFormPositionY.Enabled := not AddEditPhoneFormPosition.bCenter;

    chkbxAddMassMsrFormPositionByCenter.Checked := AddMassMsrFormPosition.bCenter;
    edbxAddMassMsrFormPositionX.Text := Routines.GetConditionalString(AddMassMsrFormPosition.bCenter, EmptyStr,
      IntToStr(AddMassMsrFormPosition.x));
    edbxAddMassMsrFormPositionY.Text := Routines.GetConditionalString(AddMassMsrFormPosition.bCenter, EmptyStr,
      IntToStr(AddMassMsrFormPosition.y));
    edbxAddMassMsrFormPositionX.Enabled := not AddMassMsrFormPosition.bCenter;
    edbxAddMassMsrFormPositionY.Enabled := not AddMassMsrFormPosition.bCenter;

    chkbxPermissionsFormPositionByCenter.Checked := PermissionsFormPosition.bCenter;
    edbxPermissionsFormPositionX.Text := Routines.GetConditionalString(PermissionsFormPosition.bCenter, EmptyStr,
      IntToStr(PermissionsFormPosition.x));
    edbxPermissionsFormPositionY.Text := Routines.GetConditionalString(PermissionsFormPosition.bCenter, EmptyStr,
      IntToStr(PermissionsFormPosition.y));
    edbxPermissionsFormPositionX.Enabled := not PermissionsFormPosition.bCenter;
    edbxPermissionsFormPositionY.Enabled := not PermissionsFormPosition.bCenter;

    // ������� "��������� ��������� �����������"
    chkbxStoreLastLogin.Checked := StoreLogin;
    chkbxStoreLastPassword.Checked := StorePassword;
    chkbxAutoLogon.Checked := AutoLogon and StoreLogin and StorePassword;
    chkbxAutoLogon.Enabled := StoreLogin and StorePassword;

    // ������� "����������� � ������� ���� ������ ������"
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

    // ������� "����������� � ������� ������� ������ �����������"
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

    // ������� "��������� ������������ �������"
    rbSaveIntoTheTempFolder.Checked := ReportFolder = rfTempFolder;
    rbSaveIntoTheApplicationFolder.Checked := ReportFolder = rfApplicationFolder;
    rbSaveIntoTheCustomFolder.Checked := ReportFolder = rfCustomFolder;
    edbxCustomReportFolderValue.Text := CustomReportFolderValue;
    chkbxDontDemandOverwriteConfirmation.Checked := DontDemandOverwriteConfirmation;
    chkbxAskForFileName.Checked := AskForFileName;
    edbxCustomReportFolderValue.Enabled := ReportFolder = rfCustomFolder;
    actChooseReportFolder.Enabled := ReportFolder = rfCustomFolder;
    Log.SendDebug('�������� "' + actChooseReportFolder.Caption + '" ' + Routines.GetConditionalString
      (actChooseReportFolder.Enabled, '�', '��') + '�������.');

    // ������� "��������� ������ ����������"
    lblAutoReplaceSorry.Caption := '��������, �� ������ �������� ������ ��� �������������' + sLineBreak +
      '� ������� �������������� ���� ������' + sLineBreak + '��� ���������� � ���� ������!';

    // ������� "��������� ������"
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
    Log.SendDebug('�������� "' + actChooseCustomHelpFile.Caption + '" ' + Routines.GetConditionalString
      (actChooseCustomHelpFile.Enabled, '�', '��') + '�������.');

    // ������� "��������� �������� ����"
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

    // ������� "��������� ����������� ����������"
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
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxFullScreenAtLaunch.Caption + '"',
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

  Log.SendDebug('������ "' + chkbxMainFormPositionByCenter.Caption + '"' + Routines.GetConditionalString
    (bFullScreenAtLaunch, '�', '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxLoginFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  LoginForm: TLoginForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxLoginFormPositionByCenter.Caption + '"',
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
    LoginForm := TLoginForm.Create(Self);
    try
      edbxLoginFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - LoginForm.Width) div 2);
      edbxLoginFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - LoginForm.Height) div 2);
    finally
      LoginForm.Free;
    end;
  end;
  Log.SendDebug('������ "' + chkbxLoginFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�', '��')
    + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxSetPasswordFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  SetPasswordForm: TSetPasswordForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxSetPasswordFormPositionByCenter.Caption + '"',
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
    SetPasswordForm := TSetPasswordForm.Create(Self);
    try
      edbxSetPasswordFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - SetPasswordForm.Width) div 2);
      edbxSetPasswordFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - SetPasswordForm.Height) div 2);
    finally
      SetPasswordForm.Free;
    end;
  end;
  Log.SendDebug('������ "' + chkbxSetPasswordFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxReportFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  ReportForm: TReportForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxReportFormPositionByCenter.Caption + '"',
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
    ReportForm := TReportForm.Create(Self);
    try
      edbxReportFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - ReportForm.Width) div 2);
      edbxReportFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - ReportForm.Height) div 2);
    finally
      ReportForm.Free;
    end;
  end;
  Log.SendDebug('������ "' + chkbxReportFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�', '��')
    + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxStoreLastLoginClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxStoreLastLogin.Caption + '"',
    '{DF6E7711-9716-4511-8C02-AA1F34D95096}');

  chkbxStoreLastPassword.Enabled := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked;
  chkbxStoreLastPassword.Checked := chkbxStoreLastPassword.Checked and chkbxStoreLastPassword.Enabled;
  chkbxAutoLogon.Enabled := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and
    chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked := chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendDebug('������ "' + chkbxStoreLastLogin.Caption + '"' + Routines.GetConditionalString
    (chkbxStoreLastLogin.Checked, '�', '��') + '������.');
  Log.SendDebug('������ "' + chkbxStoreLastPassword.Caption + '"' + Routines.GetConditionalString
    (chkbxStoreLastPassword.Checked, '�', '��') + '������.');
  Log.SendDebug('������ "' + chkbxAutoLogon.Caption + '"' + Routines.GetConditionalString(chkbxAutoLogon.Checked, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxStoreLastPasswordClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxStoreLastPassword.Caption + '"',
    '{C9AD62BE-833A-4C57-904C-0ED5DFB0634F}');

  chkbxAutoLogon.Enabled := chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and
    chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked := chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendDebug('������ "' + chkbxStoreLastPassword.Caption + '"' + Routines.GetConditionalString
    (chkbxStoreLastPassword.Checked, '�', '��') + '������.');
  Log.SendDebug('������ "' + chkbxAutoLogon.Caption + '"' + Routines.GetConditionalString(chkbxAutoLogon.Checked, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxUsersFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  // UsersForm: TUsersForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxUsersFormPositionByCenter.Caption + '"',
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
  Log.SendDebug('������ "' + chkbxUsersFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�', '��')
    + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxCreateMessageFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  CreateMessageForm: TCreateMessageForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxCreateMessageFormPositionByCenter.Caption + '"',
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
    CreateMessageForm := TCreateMessageForm.Create(Self);
    try
      edbxCreateMessageFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - CreateMessageForm.Width) div 2);
      edbxCreateMessageFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - CreateMessageForm.Height) div 2);
    finally
      CreateMessageForm.Free;
    end;
  end;
  Log.SendDebug('������ "' + chkbxCreateMessageFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b,
    '�', '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxViewMessageFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  ViewMessageForm: TViewMessageForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxViewMessageFormPositionByCenter.Caption + '"',
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
    ViewMessageForm := TViewMessageForm.Create(Self);
    try
      edbxViewMessageFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - ViewMessageForm.Width) div 2);
      edbxViewMessageFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - ViewMessageForm.Height) div 2);
    finally
      ViewMessageForm.Free;
    end;
  end;
  Log.SendDebug('������ "' + chkbxViewMessageFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxViewMessagesFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  ViewMessagesForm: TViewMessagesForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxViewMessagesFormPositionByCenter.Caption + '"',
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
    ViewMessagesForm := TViewMessagesForm.Create(Self);
    try
      edbxViewMessagesFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - ViewMessagesForm.Width) div 2);
      edbxViewMessagesFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - ViewMessagesForm.Height) div 2);
    finally
      ViewMessagesForm.Free;
    end;
  end;
  Log.SendDebug('������ "' + chkbxViewMessagesFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxEnableAutoGetMessagesClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxEnableAutoGetMessages.Caption + '"',
    '{5C3B5E46-E8F7-4BD1-8092-16B88A617F55}');

  edbxAutoGetMessagesCycleDurationValue.Enabled := chkbxEnableAutoGetMessages.Checked;
  edbxAutoGetMessagesCycleDurationValue.Text := Routines.GetConditionalString
    (edbxAutoGetMessagesCycleDurationValue.Enabled, IntToStr(MainForm.Configuration.AutoGetMessagesCycleDurationValue),
    EmptyStr);
  Log.SendDebug('������ "' + chkbxEnableAutoGetMessages.Caption + '"' + Routines.GetConditionalString
    (chkbxEnableAutoGetMessages.Checked, '�', '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxAddEditPhoneFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  AddEditPhoneForm: TAddEditPhoneForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxAddEditPhoneFormPositionByCenter.Caption + '"',
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
    AddEditPhoneForm := TAddEditPhoneForm.Create(Self);
    try
      edbxAddEditPhoneFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - AddEditPhoneForm.Width) div 2);
      edbxAddEditPhoneFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - AddEditPhoneForm.Height) div 2);
    finally
      AddEditPhoneForm.Free;
    end;
  end;
  Log.SendDebug('������ "' + chkbxAddEditPhoneFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxAddMassMsrFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  AddMassMsrForm: TAddMassMsrForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxAddMassMsrFormPositionByCenter.Caption + '"',
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
    AddMassMsrForm := TAddMassMsrForm.Create(Self);
    try
      edbxAddMassMsrFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - AddMassMsrForm.Width) div 2);
      edbxAddMassMsrFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - AddMassMsrForm.Height) div 2);
    finally
      AddMassMsrForm.Free;
    end;
  end;
  Log.SendDebug('������ "' + chkbxAddMassMsrFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxPermissionsFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  PermissionsForm: TPermissionsForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxPermissionsFormPositionByCenter.Caption + '"',
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
    PermissionsForm := TPermissionsForm.Create(Self);
    try
      edbxPermissionsFormPositionX.Text := IntToStr((Screen.WorkAreaWidth - PermissionsForm.Width) div 2);
      edbxPermissionsFormPositionY.Text := IntToStr((Screen.WorkAreaHeight - PermissionsForm.Height) div 2);
    finally
      PermissionsForm.Free;
    end;
  end;
  Log.SendDebug('������ "' + chkbxPermissionsFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxClearingFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  // ClearingForm: TClearingForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxClearingFormPositionByCenter.Caption + '"',
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
  Log.SendDebug('������ "' + chkbxClearingFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxCustomHelpFileClick(Sender: TObject);
var
  bCustomHelpFile: Boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxCustomHelpFile.Caption + '"',
    '{C4007F3B-8108-4F5D-8699-A1855EC707B1}');

  bCustomHelpFile := chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked;

  edbxCustomHelpFileValue.Enabled := bCustomHelpFile;
  actChooseCustomHelpFile.Enabled := bCustomHelpFile;
  Log.SendDebug('�������� "' + actChooseCustomHelpFile.Caption + '" ' + Routines.GetConditionalString
    (actChooseCustomHelpFile.Enabled, '�', '��') + '�������.');
  if not bCustomHelpFile then
  begin
    edbxCustomHelpFileValue.Text := EmptyStr;
  end;

  Log.SendDebug('������ "' + chkbxCustomHelpFile.Caption + '"' + Routines.GetConditionalString(bCustomHelpFile, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxMainFormPositionByCenterClick(Sender: TObject);
var
  bMainFormPositionByCenter: Boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxMainFormPositionByCenter.Caption + '"',
    '{0C75BE73-4F1F-4C3E-8938-728609D1E4F1}');

  bMainFormPositionByCenter := chkbxMainFormPositionByCenter.Checked and chkbxMainFormPositionByCenter.Enabled;
  edbxMainFormPositionX.Enabled := not bMainFormPositionByCenter;
  edbxMainFormPositionY.Enabled := not bMainFormPositionByCenter;
  edbxMainFormPositionX.Text := Routines.GetConditionalString(edbxMainFormPositionX.Enabled,
    IntToStr(MainForm.Configuration.MainFormLeft), EmptyStr);
  edbxMainFormPositionY.Text := Routines.GetConditionalString(edbxMainFormPositionY.Enabled,
    IntToStr(MainForm.Configuration.MainFormTop), EmptyStr);

  Log.SendDebug('������ "' + chkbxMainFormPositionByCenter.Caption + '"' + Routines.GetConditionalString
    (bMainFormPositionByCenter, '�', '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxMaintenanceFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  // MaintenanceForm: TMaintenanceForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxMaintenanceFormPositionByCenter.Caption + '"',
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
  Log.SendDebug('������ "' + chkbxMaintenanceFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�',
    '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxConfigurationFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxConfigurationFormPositionByCenter.Caption + '"',
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
  Log.SendDebug('������ "' + chkbxConfigurationFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b,
    '�', '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxOrganizationPanelHalfHeightClick(Sender: TObject);
var
  bOrganizationPanelHalfHeight: Boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxOrganizationPanelHalfHeight.Caption + '"',
    '{DB478623-5C76-41CE-AD55-E8E101D15815}');

  bOrganizationPanelHalfHeight := chkbxOrganizationPanelHalfHeight.Checked and chkbxOrganizationPanelHalfHeight.Enabled;
  edbxOrganizationPanelHeightValue.Enabled := not bOrganizationPanelHalfHeight;
  edbxOrganizationPanelHeightValue.Text := Routines.GetConditionalString(bOrganizationPanelHalfHeight, EmptyStr,
    IntToStr(MainForm.Configuration.OrganizationPanelHeightValue));

  Log.SendDebug('������ "' + chkbxOrganizationPanelHalfHeight.Caption + '"' +
    Routines.GetConditionalString(bOrganizationPanelHalfHeight, '�', '��') + '������.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxPhonesFormPositionByCenterClick(Sender: TObject);
var
  b: Boolean;
  // PhonesForm: TPhonesForm;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ "' + chkbxPhonesFormPositionByCenter.Caption + '"',
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
  Log.SendDebug('������ "' + chkbxPhonesFormPositionByCenter.Caption + '"' + Routines.GetConditionalString(b, '�', '��')
    + '������.');

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
  if PageControl1.ActivePage.Caption = ' ��������� ���������� ����' then
  begin
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
  end;
end;

procedure TConfigurationForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint;
  var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption = ' ��������� ���������� ����' then
  begin
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEUP, 0);
  end;
end;

end.
