{$WARN UNIT_PLATFORM OFF}
unit uConfigurationForm;

interface

uses
  Windows,
  Classes,
  Controls,
  Forms,
  StdCtrls,
  ActnList,
  ActnMan,
  ExtCtrls,
  ValEdit,
  Grids,
  ComCtrls,
  uLogProvider,
  ImgList,
  PlatformDefaultStyleActnCtrls;

type
  TConfigurationForm=class(TForm)
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_Defaults: TAction;
    Action_Close: TAction;
    Action_Apply: TAction;
    Action_PreviousPage: TAction;
    Action_NextPage: TAction;
    Action_ChooseCustomLogClientFile: TAction;
    ilConfigurationFormSmallImages: TImageList;
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
    Action_ChooseReportFolder: TAction;
    chkbxEnableLog: TCheckBox;
    Bevel4: TBevel;
    Bevel5: TBevel;
    ts6: TTabSheet;
    sgAutoReplaceList: TStringGrid;
    btnLineUp: TButton;
    btnLineDown: TButton;
    Action_LineUp: TAction;
    Action_LineDown: TAction;
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
    lblStatisticFormPosition: TLabel;
    lblStatisticFormPositionX: TLabel;
    edbxStatisticFormPositionX: TEdit;
    lblStatisticFormPositionY: TLabel;
    edbxStatisticFormPositionY: TEdit;
    chkbxStatisticFormPositionByCenter: TCheckBox;
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
    lblViewPostListFormPosition: TLabel;
    lblViewPostListFormPositionX: TLabel;
    lblViewPostListFormPositionY: TLabel;
    edbxViewPostListFormPositionX: TEdit;
    edbxViewPostListFormPositionY: TEdit;
    chkbxViewPostListFormPositionByCenter: TCheckBox;
    lblCreateViewPostFormPosition: TLabel;
    lblCreateViewPostFormPositionX: TLabel;
    lblCreateViewPostFormPositionY: TLabel;
    edbxCreateViewPostFormPositionX: TEdit;
    edbxCreateViewPostFormPositionY: TEdit;
    chkbxCreateViewPostFormPositionByCenter: TCheckBox;
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
    Log: TLogProvider;
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
    chkbxShowAboutWindowAtLaunch: TCheckBox;
    chkbxShowToolbarAtLaunch: TCheckBox;
    chkbxShowStatusbarAtLaunch: TCheckBox;
    chkbxShowEditboxHints: TCheckBox;
    chkbxShowCommonSearchEditbox: TCheckBox;
    chkbxShowID: TCheckBox;
    chkbxUseMultibuffer: TCheckBox;
    chkbxShowConfirmationAtQuit: TCheckBox;
    chkbxPlaySoundOnComplete: TCheckBox;
    Action_ChooseCustomHelpFile: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_DefaultsExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_PreviousPageExecute(Sender: TObject);
    procedure Action_NextPageExecute(Sender: TObject);
    procedure Action_ChooseReportFolderExecute(Sender: TObject);
    procedure Action_ChooseCustomLogClientFileExecute(Sender: TObject);
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
    procedure Action_ChooseCustomHelpFileExecute(Sender: TObject);
    procedure chkbxCustomHelpFileClick(Sender: TObject);
    procedure chkbxOrganizationPanelHalfHeightClick(Sender: TObject);
    procedure chkbxDataPanelHalfWidthClick(Sender: TObject);
    procedure chkbxLoginFormPositionByCenterClick(Sender: TObject);
    procedure chkbxConfigurationFormPositionByCenterClick(Sender: TObject);
    procedure chkbxUsersFormPositionByCenterClick(Sender: TObject);
    procedure chkbxSetPasswordFormPositionByCenterClick(Sender: TObject);
    procedure chkbxStatisticFormPositionByCenterClick(Sender: TObject);
    procedure chkbxMaintenanceFormPositionByCenterClick(Sender: TObject);
    procedure chkbxClearingFormPositionByCenterClick(Sender: TObject);
    procedure chkbxViewPostListFormPositionByCenterClick(Sender: TObject);
    procedure chkbxCreateViewPostFormPositionByCenterClick(Sender: TObject);
    procedure chkbxPhonesFormPositionByCenterClick(Sender: TObject);
    procedure chkbxAddEditPhoneFormPositionByCenterClick(Sender: TObject);
    procedure chkbxAddMassMsrFormPositionByCenterClick(Sender: TObject);
    procedure edbxNumericFieldKeyPress(Sender: TObject; var Key: Char);
  strict private
    slBooleanValues: TStringList;
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
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
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

{$R *.dfm}

uses
  Dialogs,
  SysUtils,
  Messages,
  LogKeeperData,
  FileCtrl,
  uMainForm,
  uLoginForm,
  uAboutForm,
  uAddMassMsrForm,
  uRoutines,
  uConfigurationClass;

procedure TConfigurationForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TConfigurationForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TConfigurationForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TConfigurationForm.Action_ApplyExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', '{84DDCA84-3467-43EB-9005-E35C20FD98D0}');
  Do_Apply;
  ProcedureFooter;
end;

procedure TConfigurationForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{609A88EE-6BC8-4F0F-9C3D-EC1D6FD1A50F}');
  Do_Close;
  ProcedureFooter;
end;

procedure TConfigurationForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{0CB39D36-EC59-4C76-AFE5-1718B99DA0CA}');
  Do_Help;
  ProcedureFooter;
end;

procedure TConfigurationForm.Action_PreviousPageExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_PreviousPage.Caption+'"', '{50728BC6-7E7C-4D0D-9C17-E7919DE4A4C3}');
  Do_PreviousPage;
  ProcedureFooter;
end;

procedure TConfigurationForm.Action_NextPageExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_NextPage.Caption+'"', '{0D4FC270-5B1E-4E59-8EBF-89ADBAC0E89F}');
  Do_NextPage;
  ProcedureFooter;
end;

procedure TConfigurationForm.Action_ChooseReportFolderExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseReportFolder.Caption+'"', '{0F2D97AB-C59D-456A-ABCA-C390806F896C}');
  Do_ChooseCustomReportFolder;
  ProcedureFooter;
end;

procedure TConfigurationForm.Action_ChooseCustomHelpFileExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseCustomHelpFile.Caption+'"', '{708E3642-722E-4556-9774-2F813BD540ED}');
  Do_ChooseCustomHelpFile;
  ProcedureFooter;
end;

procedure TConfigurationForm.Action_ChooseCustomLogClientFileExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseReportFolder.Caption+'"', '{24E77954-BFEB-4128-B764-C31ED26D068C}');
  Do_ChooseLogClientFile;
  ProcedureFooter;
end;

procedure TConfigurationForm.Action_DefaultsExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Defaults.Caption+'"', '{9B790597-F8F3-47A8-96FE-472EFFB6020E}');
  Do_Defaults;
  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Apply;
var
  FormPosition: TFormPosition;
  Rect: TRect;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{55D9E5EB-97B6-47FC-B149-348070521077}');

  ModalResult:=mrOk;
  Log.SendInfo('Попытка изменения настроек программы была подтверждена пользователем.');

  with MainForm.Configuration do
    begin
      // вкладка "настройки интерфейса"
      ShowAboutWindowAtLaunch:=chkbxShowAboutWindowAtLaunch.Enabled and chkbxShowAboutWindowAtLaunch.Checked;
      ShowToolbarAtLaunch:=chkbxShowToolbarAtLaunch.Enabled and chkbxShowToolbarAtLaunch.Checked;
      ShowStatusbarAtLaunch:=chkbxShowStatusbarAtLaunch.Enabled and chkbxShowStatusbarAtLaunch.Checked;
      ShowEditboxHints:=chkbxShowEditboxHints.Enabled and chkbxShowEditboxHints.Checked;
      ShowCommonSearchEditbox:=chkbxShowCommonSearchEditbox.Enabled and chkbxShowCommonSearchEditbox.Checked;
      ShowID:=chkbxShowID.Enabled and chkbxShowID.Checked;
      UseMultibuffer:=chkbxUseMultibuffer.Enabled and chkbxUseMultibuffer.Checked;
      ShowConfirmationAtQuit:=chkbxShowConfirmationAtQuit.Enabled and chkbxShowConfirmationAtQuit.Checked;

      // вкладка "настройки ведения протокола работы"
      EnableLog:=chkbxEnableLog.Enabled and chkbxEnableLog.Checked;

      if EnableLog and chkbxKeepErrorLog.Enabled and chkbxKeepErrorLog.Checked then
        KeepLogTypes:=KeepLogTypes+[lmtError]
      else
        KeepLogTypes:=KeepLogTypes-[lmtError];

      if EnableLog and chkbxKeepWarningLog.Enabled and chkbxKeepWarningLog.Checked then
        KeepLogTypes:=KeepLogTypes+[lmtWarning]
      else
        KeepLogTypes:=KeepLogTypes-[lmtWarning];

      if EnableLog and chkbxKeepInfoLog.Enabled and chkbxKeepInfoLog.Checked then
        KeepLogTypes:=KeepLogTypes+[lmtInfo]
      else
        KeepLogTypes:=KeepLogTypes-[lmtInfo];

      if EnableLog and chkbxKeepSQLLog.Enabled and chkbxKeepSQLLog.Checked then
        KeepLogTypes:=KeepLogTypes+[lmtSQL]
      else
        KeepLogTypes:=KeepLogTypes-[lmtSQL];

      if EnableLog and chkbxKeepDebugLog.Enabled and chkbxKeepDebugLog.Checked then
        KeepLogTypes:=KeepLogTypes+[lmtDebug]
      else
        KeepLogTypes:=KeepLogTypes-[lmtDebug];

      FlushLogOnExit:=chkbxFlushLogOnExit.Enabled and chkbxFlushLogOnExit.Checked;
      FlushLogOnStringsQuantity:=chkbxFlushLogOnStringsQuantity.Enabled and chkbxFlushLogOnStringsQuantity.Checked;
      FlushLogOnStringsQuantityValue:=StrToIntDef(Routines.GetConditionalString(chkbxFlushLogOnStringsQuantity.Enabled and chkbxFlushLogOnStringsQuantity.Checked and edbxFlushLogOnStringsQuantityValue.Enabled,
        Trim(edbxFlushLogOnStringsQuantityValue.Text), ''), DefaultValue_FlushLogOnStringsQuantityValue);
      FlushLogOnClearingLog:=chkbxFlushLogOnClearingLog.Enabled and chkbxFlushLogOnClearingLog.Checked;
      FlushLogOnApply:=chkbxFlushLogOnApply.Enabled and chkbxFlushLogOnApply.Checked;
      CustomLogClientFile:=chkbxCustomLogClientFile.Enabled and chkbxCustomLogClientFile.Checked;
      CustomLogClientFileValue:=Routines.GetConditionalString(chkbxCustomLogClientFile.Enabled and chkbxCustomLogClientFile.Checked and chkbxEnableLog.Enabled and chkbxEnableLog.Checked and edbxCustomLogClientFileValue.Enabled,
        Trim(edbxCustomLogClientFileValue.Text), DefaultValue_CustomLogClientFileValue);

      // вкладка "настройки положения диалоговых окон"
      FormPosition.bCenter:=chkbxLoginFormPositionByCenter.Enabled and chkbxLoginFormPositionByCenter.Checked;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxLoginFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxLoginFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      LoginFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxConfigurationFormPositionByCenter.Checked and chkbxConfigurationFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxConfigurationFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxConfigurationFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      ConfigurationFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxUsersFormPositionByCenter.Checked and chkbxUsersFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxUsersFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxUsersFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      UsersFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxSetPasswordFormPositionByCenter.Checked and chkbxSetPasswordFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxSetPasswordFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxSetPasswordFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      SetPasswordFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxStatisticFormPositionByCenter.Checked and chkbxStatisticFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxStatisticFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxStatisticFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      StatisticFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxMaintenanceFormPositionByCenter.Checked and chkbxMaintenanceFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxMaintenanceFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxMaintenanceFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      MaintenanceFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxClearingFormPositionByCenter.Checked and chkbxClearingFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxClearingFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxClearingFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      ClearingFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxViewPostListFormPositionByCenter.Checked and chkbxViewPostListFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxViewPostListFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxViewPostListFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      ViewPostListFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxCreateViewPostFormPositionByCenter.Checked and chkbxCreateViewPostFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxCreateViewPostFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxCreateViewPostFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      CreateViewPostFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxPhonesFormPositionByCenter.Checked and chkbxPhonesFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxPhonesFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxPhonesFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      PhonesFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxAddEditPhoneFormPositionByCenter.Checked and chkbxAddEditPhoneFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxAddEditPhoneFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxAddEditPhoneFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      AddEditPhoneFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxAddMassMsrFormPositionByCenter.Checked and chkbxAddMassMsrFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxAddMassMsrFormPositionX.Text), ''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter, Trim(edbxAddMassMsrFormPositionY.Text), ''), DefaultValue_FormPosition_y);
      AddMassMsrFormPosition:=FormPosition;

      // вкладка "настройки процедуры логирования"
      StoreLastLogin:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked;
      StoreLastPassword:=chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
      AutoLogon:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked and chkbxAutoLogon.Enabled and chkbxAutoLogon.Checked;

      // вкладка "подключения к серверу базы данных услуги"
      if vleRNE4SERVER.Enabled then
        with RNE4Server, vleRNE4SERVER do
          begin
            Host:=Trim(Cells[1, 1]);
            Port:=StrToIntDef(Trim(Cells[1, 2]), DefaultValue_RNE4Server_Port);
            Timeout:=StrToIntDef(Trim(Cells[1, 3]), DefaultValue_RNE4Server_Timeout);
            Compression:=Trim(Cells[1, 4])='Да';
            Database:=Trim(Cells[1, 5]);
          end;

      // вкладка "подключения к серверу системы обмена сообщениями"
      if vleRNE4MESSAGESSERVER.Enabled then
        with MessagesServer, vleRNE4MESSAGESSERVER do
          begin
            Host:=Trim(Cells[1, 1]);
            Port:=StrToIntDef(Trim(Cells[1, 2]), DefaultValue_MessagesServer_Port);
            Timeout:=StrToIntDef(Trim(Cells[1, 3]), DefaultValue_MessagesServer_Timeout);
            Compression:=Trim(Cells[1, 4])='Да';
            Database:=Trim(Cells[1, 5]);
          end;

      // вкладка "настройки формирования отчётов"
      if rbSaveIntoTheTempFolder.Enabled and rbSaveIntoTheTempFolder.Checked then
        ReportFolder:=rfTempFolder;
      if rbSaveIntoTheApplicationFolder.Enabled and rbSaveIntoTheApplicationFolder.Checked then
        ReportFolder:=rfApplicationFolder;
      if rbSaveIntoTheCustomFolder.Enabled and rbSaveIntoTheCustomFolder.Checked then
        ReportFolder:=rfCustomFolder;

      CustomReportFolderValue:=Routines.GetConditionalString(rbSaveIntoTheCustomFolder.Enabled and rbSaveIntoTheCustomFolder.Checked, Trim(edbxCustomReportFolderValue.Text), DefaultValue_CustomReportFolderValue);
      DontDemandOverwriteConfirmation:=chkbxDontDemandOverwriteConfirmation.Enabled and chkbxDontDemandOverwriteConfirmation.Checked;
      AskForFileName:=chkbxAskForFileName.Enabled and chkbxAskForFileName.Checked;

      // вкладка "настройки списка автозамены"

      // вкладка "настройки прочие"
      LaunchAtStartup:=chkbxLaunchAtStartup.Enabled and chkbxLaunchAtStartup.Checked;
      PlaySoundOnComplete:=chkbxPlaySoundOnComplete.Enabled and chkbxPlaySoundOnComplete.Checked;
      EnableAutoGetMessages:=chkbxEnableAutoGetMessages.Enabled and chkbxEnableAutoGetMessages.Checked;
      AutoGetMessagesCycleDurationValue:=StrToIntDef(Routines.GetConditionalString(chkbxEnableAutoGetMessages.Enabled and chkbxEnableAutoGetMessages.Checked and edbxAutoGetMessagesCycleDurationValue.Enabled,
        Trim(edbxAutoGetMessagesCycleDurationValue.Text), IntToStr(DefaultValue_AutoGetMessagesCycleDurationValue)), DefaultValue_AutoGetMessagesCycleDurationValue);
      CustomHelpFile:=chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked;
      CustomHelpFileValue:=Routines.GetConditionalString(chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked and edbxCustomHelpFileValue.Enabled, Trim(edbxCustomHelpFileValue.Text), DefaultValue_CustomHelpFileValue);

      // вкладка "настройки главного окна"
      MainFormPositionByCenter:=chkbxMainFormPositionByCenter.Enabled and chkbxMainFormPositionByCenter.Checked and(not(chkbxFullScreenAtLaunch.Enabled and chkbxFullScreenAtLaunch.Checked));
      FullScreenAtLaunch:=chkbxFullScreenAtLaunch.Enabled and chkbxFullScreenAtLaunch.Checked;
      if chkbxFullScreenAtLaunch.Enabled and chkbxFullScreenAtLaunch.Checked then
        begin
          Rect.Left:=0;
          Rect.Top:=0;
          Rect.Right:=Screen.WorkAreaRect.Right;
          Rect.Bottom:=Screen.WorkAreaRect.Bottom;
          MainFormRect:=Rect;
        end
      else
        if chkbxMainFormPositionByCenter.Enabled and chkbxMainFormPositionByCenter.Checked then
          begin
            if edbxMainFormWidth.Enabled then
              Rect.Right:=StrToIntDef(Trim(edbxMainFormWidth.Text), DefaultValue_MainFormRect_Right+1)-1
            else
              Rect.Right:=DefaultValue_MainFormRect_Right;

            if edbxMainFormHeight.Enabled then
              Rect.Bottom:=StrToIntDef(Trim(edbxMainFormHeight.Text), DefaultValue_MainFormRect_Bottom+1)-1
            else
              Rect.Bottom:=DefaultValue_MainFormRect_Bottom;
            Rect.Left:=Screen.WorkAreaWidth-Rect.Right-1;
            Rect.Top:=Screen.WorkAreaHeight-Rect.Bottom-1;
            MainFormRect:=Rect;
          end
        else
          begin
            if edbxMainFormPositionX.Enabled then
              Rect.Left:=StrToIntDef(Trim(edbxMainFormPositionX.Text), DefaultValue_MainFormRect_Left)
            else
              Rect.Left:=DefaultValue_MainFormRect_Left;

            if edbxMainFormPositionY.Enabled then
              Rect.Top:=StrToIntDef(Trim(edbxMainFormPositionY.Text), DefaultValue_MainFormRect_Top)
            else
              Rect.Top:=DefaultValue_MainFormRect_Top;

            if edbxMainFormWidth.Enabled then
              Rect.Right:=StrToIntDef(Trim(edbxMainFormWidth.Text), DefaultValue_MainFormRect_Right+1)-1
            else
              Rect.Right:=DefaultValue_MainFormRect_Right;

            if edbxMainFormHeight.Enabled then
              Rect.Bottom:=StrToIntDef(Trim(edbxMainFormHeight.Text), DefaultValue_MainFormRect_Bottom+1)-1
            else
              Rect.Bottom:=DefaultValue_MainFormRect_Bottom;
            MainFormRect:=Rect;
          end;

      // вкладка "настройки отображения информации"
      OrganizationPanelHeightValue:=StrToIntDef(Routines.GetConditionalString(chkbxOrganizationPanelHalfHeight.Enabled and chkbxOrganizationPanelHalfHeight.Checked, '', Trim(edbxOrganizationPanelHeightValue.Text)),
        DefaultValue_OrganizationPanelHeightValue);
      OrganizationPanelHalfHeight:=chkbxOrganizationPanelHalfHeight.Enabled and chkbxOrganizationPanelHalfHeight.Checked;
      DataPanelWidthValue:=StrToIntDef(Routines.GetConditionalString(chkbxDataPanelHalfWidth.Enabled and chkbxDataPanelHalfWidth.Checked, '', Trim(edbxDataPanelWidthValue.Text)), DefaultValue_DataPanelWidthValue);
      DataPanelHalfWidth:=chkbxDataPanelHalfWidth.Enabled and chkbxDataPanelHalfWidth.Checked;
      ShowDataInOtherInfoPanel:=chkbxShowDataInOtherInfoPanel.Enabled and chkbxShowDataInOtherInfoPanel.Checked;
      ShowMeasuresListAsRichEdit:=chkbxShowMeasuresListAsRichEdit.Enabled and chkbxShowMeasuresListAsRichEdit.Checked;
      MarkSearchedStrings:=chkbxMarkSearchedStrings.Enabled and chkbxMarkSearchedStrings.Checked;
      PutTownAtTheEnd:=chkbxPutTownAtTheEnd.Enabled and chkbxPutTownAtTheEnd.Checked;
    end;

  Log.SendInfo('Окно изменения настроек программы закрыто.');

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{6B58486E-78C2-4F8B-9923-BFC7F5FEA88C}');

  ModalResult:=mrClose;
  Log.SendInfo('Попытка изменения настроек программы была отменена пользователем.');
  Log.SendInfo('Окно изменения настроек программы закрыто.');

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{4852C968-A8CC-4A2B-947E-4BA717D6A8EE}');
  bError:=False;

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TConfigurationForm.Do_PreviousPage;
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения предыдущей страницы настроек программы', '{8CC5AFC0-A130-40F8-A13E-441914AFE036}');

  i:=cbPage.ItemIndex-1;
  if i<0 then
    i:=cbPage.Items.Count-1;
  cbPage.ItemIndex:=i;
  Do_PageSelect;

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_NextPage;
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения следующей страницы настроек программы', '{0408CB52-5F42-4BE4-8BB5-09EBA649B868}');

  i:=cbPage.ItemIndex+1;
  if i>cbPage.Items.Count-1 then
    i:=0;
  cbPage.ItemIndex:=i;
  Do_PageSelect;

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_ChooseCustomHelpFile;
var
  sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора стороннего справочного файла к программе', '{DBF9ACD7-9F70-4D0A-9D90-CA893744CBBB}');
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState; // обновление состояния индикатора
    end;

  with TOpenDialog.Create(Self) do
    try
      Filter:='Файл справки к программе|'+StringReplace(ExtractFileName(Application.ExeName), '.exe', '.chm', [rfReplaceAll, rfIgnoreCase])+'|Справочные файлы формата .CHM|*.chm|Справочные файлы формата .HLP|*.hlp';
      DefaultExt:='chm';
      Title:='Выберите файл справки...';
      FilterIndex:=1;
      Options:=[ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName='' then
          Routines.GenerateError('Возникла ошибка при выборе файла справки - файл не был выбран!', sErrorMessage, bError)
        else
          if not FileExists(FileName) then
            Routines.GenerateError('Возникла ошибка при выборе файла справки - выбранный файл не существует!', sErrorMessage, bError)
          else
            begin
              edbxCustomHelpFileValue.Text:=FileName;
              Log.SendDebug('В качестве стороннего справочного файла выбрана файл "'+sPath+'".');
            end;
    finally
      Free;
    end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
      Refresh_BusyState; // обновление состояния индикатора
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TConfigurationForm.Do_ChooseCustomReportFolder;
var
  s, sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора папки для сохранения отчётов', '{58DA7933-E4BD-4402-9E83-2446DB94BE14}');
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState; // обновление состояния индикатора
    end;

  s:=edbxCustomReportFolderValue.Text;

  if SelectDirectory('Выберите папку', '', s, [sdNewFolder, sdNewUI], Self) then
    if (s<>'') then
      begin
        sPath:=s;
        if (sPath[Length(sPath)]<>'\') then
          sPath:=sPath+'\';
        if SysUtils.DirectoryExists(sPath) then
          begin
            edbxCustomReportFolderValue.Text:=sPath;
            Log.SendDebug('В качестве папки для сохранения отчётов выбрана папка "'+sPath+'".');
          end
        else
          begin
            edbxCustomReportFolderValue.Text:='';
            Routines.GenerateError('Возникла ошибка при выборе папки - указанная папка не существует!', sErrorMessage, bError);
          end;
      end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
      Refresh_BusyState; // обновление состояния индикатора
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TConfigurationForm.Do_ChooseLogClientFile;
var
  sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора внешнего клиента протоколирования', '{DCD63D88-72D9-42E5-91EC-35906B335D27}');
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState; // обновление состояния индикатора
    end;

  with TOpenDialog.Create(Self) do
    try
      Filter:='Файл модуля лог-клиента|LogKeeper.exe|Исполняемые файлы|*.exe';
      DefaultExt:='exe';
      Title:='Выберите файл внешнего клиента протоколирования...';
      FilterIndex:=1;
      Options:=[ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName='' then
          Routines.GenerateError('Возникла ошибка при выборе файла внешнего клиента протоколирования - файл не был выбран!', sErrorMessage, bError)
        else
          if not FileExists(FileName) then
            Routines.GenerateError('Возникла ошибка при выборе файла внешнего клиента протоколирования - выбранный файл не существует!', sErrorMessage, bError)
          else
            begin
              edbxCustomLogClientFileValue.Text:=FileName;
              Log.SendDebug('В качестве файла внешнего клиента протоколирования выбран файл "'+sPath+'".');
            end;
    finally
      Free;
    end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
      Refresh_BusyState; // обновление состояния индикатора
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TConfigurationForm.Do_PageSelect;
var
  i: integer;
begin
  ProcedureHeader('Процедура обновления состояния элементов управления в зависимости от выбранного пункта выпадающего списка настроек', '{396B4482-5CD9-4C26-8AE4-B5CC0F52CF20}');

  // поиск и открытие нужной страницы в компоненте
  for i:=0 to PageControl1.PageCount-1 do
    if PageControl1.Pages[i].Caption=cbPage.Items[cbPage.ItemIndex] then
      PageControl1.ActivePageIndex:=i;

  // доступность действия сброса настроек в значения по умолчанию
  if (PageControl1.ActivePage.Caption=' подключения к серверу базы данных услуги')or(PageControl1.ActivePage.Caption=' подключения к серверу системы обмена сообщениями') then
    begin
      if PageControl1.ActivePage.Caption=' подключения к серверу базы данных услуги' then
        Action_Defaults.Enabled:=vleRNE4SERVER.Enabled;
      if PageControl1.ActivePage.Caption=' подключения к серверу системы обмена сообщениями' then
        Action_Defaults.Enabled:=vleRNE4MESSAGESSERVER.Enabled;
    end
  else
    Action_Defaults.Enabled:=not(PageControl1.ActivePage.Caption=' списка автозамены');

  // доступность действия поднятия и опускания строки в списке автощзамены
  Action_LineUp.Visible:=(PageControl1.ActivePage.Caption=' списка автозамены')and sgAutoReplaceList.Visible and sgAutoReplaceList.Enabled;
  Action_LineDown.Visible:=Action_LineUp.Visible;

  ProcedureFooter;
end;

procedure TConfigurationForm.Do_Defaults;
begin
  ProcedureHeader('Процедура сброса настроек к значениям по умолчанию', '{EDC577E6-6D47-4DC2-973E-AD820C7AC588}');

  // вкладка "настройки интерфейса"
  if PageControl1.ActivePage.Caption=' интерфейса' then
    begin
      // выставление значений по умолчанию для контролов
      chkbxShowAboutWindowAtLaunch.Checked:=DefaultValue_ShowAboutWindowAtLaunch;
      chkbxShowToolbarAtLaunch.Checked:=DefaultValue_ShowToolbarAtLaunch;
      chkbxShowStatusbarAtLaunch.Checked:=DefaultValue_ShowStatusbarAtLaunch;
      chkbxShowEditboxHints.Checked:=DefaultValue_ShowEditboxHints;
      chkbxShowCommonSearchEditbox.Checked:=DefaultValue_ShowCommonSearchEditbox;
      chkbxShowID.Checked:=DefaultValue_ShowID;
      chkbxUseMultibuffer.Checked:=DefaultValue_UseMultibuffer;
      chkbxShowConfirmationAtQuit.Checked:=DefaultValue_ShowConfirmationAtQuit;
    end;

  // вкладка "настройки ведения протокола работы"
  if PageControl1.ActivePage.Caption=' ведения протокола работы' then
    begin
      // выставление значений по умолчанию для элементов интерфейса
      chkbxEnableLog.Checked:=DefaultValue_EnableLog;
      chkbxKeepErrorLog.Checked:=(lmtError in DefaultValue_KeepLogTypes)and DefaultValue_EnableLog;
      chkbxKeepWarningLog.Checked:=(lmtWarning in DefaultValue_KeepLogTypes)and DefaultValue_EnableLog;
      chkbxKeepInfoLog.Checked:=(lmtInfo in DefaultValue_KeepLogTypes)and DefaultValue_EnableLog;
      chkbxKeepSQLLog.Checked:=(lmtSQL in DefaultValue_KeepLogTypes)and DefaultValue_EnableLog;
      chkbxKeepDebugLog.Checked:=(lmtDebug in DefaultValue_KeepLogTypes)and DefaultValue_EnableLog;
      chkbxFlushLogOnExit.Checked:=DefaultValue_FlushLogOnExit and DefaultValue_EnableLog;
      chkbxFlushLogOnStringsQuantity.Checked:=DefaultValue_FlushLogOnStringsQuantity and DefaultValue_EnableLog;
      edbxFlushLogOnStringsQuantityValue.Text:=Routines.GetConditionalString(DefaultValue_FlushLogOnStringsQuantity and DefaultValue_EnableLog, IntToStr(DefaultValue_FlushLogOnStringsQuantityValue), '');
      chkbxFlushLogOnClearingLog.Checked:=DefaultValue_FlushLogOnClearingLog and DefaultValue_EnableLog;
      chkbxFlushLogOnApply.Checked:=DefaultValue_FlushLogOnApply and DefaultValue_EnableLog;
      chkbxCustomLogClientFile.Checked:=DefaultValue_CustomLogClientFile and DefaultValue_EnableLog;
      edbxCustomLogClientFileValue.Text:=Routines.GetConditionalString(DefaultValue_CustomLogClientFile and DefaultValue_EnableLog, DefaultValue_CustomLogClientFileValue, '');
      // выставление доступа к элементам интерфейса
      lblShowData.Enabled:=DefaultValue_EnableLog;
      chkbxKeepErrorLog.Enabled:=DefaultValue_EnableLog;
      chkbxKeepWarningLog.Enabled:=DefaultValue_EnableLog;
      chkbxKeepInfoLog.Enabled:=DefaultValue_EnableLog;
      chkbxKeepSQLLog.Enabled:=DefaultValue_EnableLog;
      chkbxKeepDebugLog.Enabled:=DefaultValue_EnableLog;
      lblFlushLog.Enabled:=DefaultValue_EnableLog;
      chkbxFlushLogOnExit.Enabled:=DefaultValue_EnableLog;
      chkbxFlushLogOnStringsQuantity.Enabled:=DefaultValue_EnableLog;
      edbxFlushLogOnStringsQuantityValue.Enabled:=DefaultValue_EnableLog;
      chkbxFlushLogOnClearingLog.Enabled:=DefaultValue_EnableLog;
      chkbxFlushLogOnApply.Enabled:=DefaultValue_EnableLog;
      chkbxCustomLogClientFile.Enabled:=DefaultValue_EnableLog;
      edbxCustomLogClientFileValue.Enabled:=DefaultValue_CustomLogClientFile and DefaultValue_EnableLog;
      Action_ChooseCustomLogClientFile.Enabled:=DefaultValue_CustomLogClientFile and DefaultValue_EnableLog;
    end;

  // вкладка "настройки положения диалоговых окон"
  chkbxLoginFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxLoginFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxLoginFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxLoginFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxLoginFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxConfigurationFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxConfigurationFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxConfigurationFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxConfigurationFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxConfigurationFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxUsersFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxUsersFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxUsersFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxUsersFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxUsersFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxSetPasswordFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxSetPasswordFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxSetPasswordFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxSetPasswordFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxSetPasswordFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxStatisticFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxStatisticFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxStatisticFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxStatisticFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxStatisticFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxMaintenanceFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxMaintenanceFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxMaintenanceFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxMaintenanceFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxMaintenanceFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxClearingFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxClearingFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxClearingFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxClearingFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxClearingFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxViewPostListFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxViewPostListFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxViewPostListFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxViewPostListFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxViewPostListFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxCreateViewPostFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxCreateViewPostFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxCreateViewPostFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxCreateViewPostFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxCreateViewPostFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxPhonesFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxPhonesFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxPhonesFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxPhonesFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxPhonesFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxAddEditPhoneFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxAddEditPhoneFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxAddEditPhoneFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxAddEditPhoneFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxAddEditPhoneFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxAddMassMsrFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxAddMassMsrFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxAddMassMsrFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxAddMassMsrFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxAddMassMsrFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  // вкладка "настройки процедуры логирования"
  if PageControl1.ActivePage.Caption=' процедуры логирования' then
    begin
      // выставление значений по умолчанию для элементов интерфейса
      chkbxStoreLastLogin.Checked:=DefaultValue_StoreLastLogin;
      chkbxStoreLastPassword.Checked:=DefaultValue_StoreLastPassword;
      chkbxAutoLogon.Checked:=DefaultValue_AutoLogon and DefaultValue_StoreLastLogin and DefaultValue_StoreLastPassword;
      // выставление доступа к элементам интерфейса
      chkbxAutoLogon.Enabled:=DefaultValue_StoreLastLogin and DefaultValue_StoreLastPassword;
    end;

  // вкладка "подключения к серверу базы данных услуги"
  if PageControl1.ActivePage.Caption=' подключения к серверу базы данных услуги' then
    begin
      // выставление значений по умолчанию для элементов интерфейса
      vleRNE4SERVER.Cells[1, 1]:=DefaultValue_RNE4Server_Host;
      vleRNE4SERVER.Cells[1, 2]:=IntToStr(DefaultValue_RNE4Server_Port);
      vleRNE4SERVER.Cells[1, 3]:=IntToStr(DefaultValue_RNE4Server_Timeout);
      vleRNE4SERVER.Cells[1, 4]:=vleRNE4SERVER.ItemProps[3].PickList.Strings[integer(DefaultValue_RNE4Server_Compression)];
      vleRNE4SERVER.Cells[1, 5]:=DefaultValue_RNE4Server_Database;
    end;

  // вкладка "подключения к серверу системы обмена сообщениями"
  if PageControl1.ActivePage.Caption=' подключения к серверу системы обмена сообщениями' then
    begin
      // выставление значений по умолчанию для элементов интерфейса
      vleRNE4MESSAGESSERVER.Cells[1, 1]:=DefaultValue_MessagesServer_Host;
      vleRNE4MESSAGESSERVER.Cells[1, 2]:=IntToStr(DefaultValue_MessagesServer_Port);
      vleRNE4MESSAGESSERVER.Cells[1, 3]:=IntToStr(DefaultValue_MessagesServer_Timeout);
      vleRNE4MESSAGESSERVER.Cells[1, 4]:=vleRNE4MESSAGESSERVER.ItemProps[3].PickList.Strings[integer(DefaultValue_MessagesServer_Compression)];
      vleRNE4MESSAGESSERVER.Cells[1, 5]:=DefaultValue_MessagesServer_Database;
    end;

  // вкладка "настройки формирования отчётов"
  if PageControl1.ActivePage.Caption=' формирования отчётов' then
    begin
      // выставление значений по умолчанию для элементов интерфейса
      rbSaveIntoTheTempFolder.Checked:=DefaultValue_ReportFolder=rfTempFolder;
      rbSaveIntoTheApplicationFolder.Checked:=DefaultValue_ReportFolder=rfApplicationFolder;
      rbSaveIntoTheCustomFolder.Checked:=DefaultValue_ReportFolder=rfCustomFolder;
      edbxCustomReportFolderValue.Text:=DefaultValue_CustomReportFolderValue;
      chkbxDontDemandOverwriteConfirmation.Checked:=DefaultValue_DontDemandOverwriteConfirmation;
      chkbxAskForFileName.Checked:=DefaultValue_AskForFileName;
      // выставление доступа к элементам интерфейса
      edbxCustomReportFolderValue.Enabled:=DefaultValue_ReportFolder=rfCustomFolder;
      Action_ChooseReportFolder.Enabled:=DefaultValue_ReportFolder=rfCustomFolder;
    end;

  // вкладка "настройки прочие"
  if PageControl1.ActivePage.Caption=' прочие' then
    begin
      // выставление значений по умолчанию для элементов интерфейса
      chkbxLaunchAtStartup.Checked:=DefaultValue_LaunchAtStartup;
      chkbxPlaySoundOnComplete.Checked:=DefaultValue_PlaySoundOnComplete;
      chkbxEnableAutoGetMessages.Checked:=DefaultValue_EnableAutoGetMessages;
      edbxAutoGetMessagesCycleDurationValue.Text:=Routines.GetConditionalString(DefaultValue_EnableAutoGetMessages, IntToStr(DefaultValue_AutoGetMessagesCycleDurationValue), '');
      chkbxCustomHelpFile.Checked:=DefaultValue_CustomHelpFile;
      edbxCustomHelpFileValue.Text:=Routines.GetConditionalString(DefaultValue_CustomHelpFile, DefaultValue_CustomHelpFileValue, '');
      // выставление доступа к элементам интерфейса
      edbxAutoGetMessagesCycleDurationValue.Enabled:=DefaultValue_EnableAutoGetMessages;
      edbxCustomHelpFileValue.Enabled:=DefaultValue_CustomHelpFile;
      Action_ChooseCustomHelpFile.Enabled:=DefaultValue_CustomHelpFile;
    end;

  // вкладка "настройки главного окна"
  if PageControl1.ActivePage.Caption=' главного окна' then
    begin
      // выставление значений по умолчанию для элементов интерфейса
      edbxMainFormPositionX.Text:=Routines.GetConditionalString(not(DefaultValue_MainFormPositionByCenter or DefaultValue_FullScreenAtLaunch), IntToStr(DefaultValue_MainFormRect_Left), '');
      edbxMainFormPositionY.Text:=Routines.GetConditionalString(not(DefaultValue_MainFormPositionByCenter or DefaultValue_FullScreenAtLaunch), IntToStr(DefaultValue_MainFormRect_Top), '');
      chkbxMainFormPositionByCenter.Checked:=DefaultValue_MainFormPositionByCenter and(not DefaultValue_FullScreenAtLaunch);
      edbxMainFormWidth.Text:=Routines.GetConditionalString(DefaultValue_FullScreenAtLaunch, '', IntToStr(DefaultValue_MainFormRect_Right-DefaultValue_MainFormRect_Left));
      edbxMainFormHeight.Text:=Routines.GetConditionalString(DefaultValue_FullScreenAtLaunch, '', IntToStr(DefaultValue_MainFormRect_Bottom-DefaultValue_MainFormRect_Top));
      chkbxFullScreenAtLaunch.Checked:=DefaultValue_FullScreenAtLaunch;
    end;

  // вкладка "настройки отображения информации"
  if PageControl1.ActivePage.Caption=' отображения информации' then
    begin
      // выставление значений по умолчанию для элементов интерфейса
      edbxOrganizationPanelHeightValue.Text:=Routines.GetConditionalString(DefaultValue_OrganizationPanelHalfHeight, '', IntToStr(DefaultValue_OrganizationPanelHeightValue));
      chkbxOrganizationPanelHalfHeight.Checked:=DefaultValue_OrganizationPanelHalfHeight;
      edbxDataPanelWidthValue.Text:=Routines.GetConditionalString(DefaultValue_DataPanelHalfWidth, '', IntToStr(DefaultValue_DataPanelWidthValue));
      chkbxDataPanelHalfWidth.Checked:=DefaultValue_DataPanelHalfWidth;
      chkbxShowDataInOtherInfoPanel.Checked:=DefaultValue_ShowDataInOtherInfoPanel;
      chkbxShowMeasuresListAsRichEdit.Checked:=DefaultValue_ShowMeasuresListAsRichEdit;
      chkbxMarkSearchedStrings.Checked:=DefaultValue_MarkSearchedStrings;
      chkbxPutTownAtTheEnd.Checked:=DefaultValue_PutTownAtTheEnd;;
      // выставление доступа к элементам интерфейса
      edbxOrganizationPanelHeightValue.Enabled:=not DefaultValue_OrganizationPanelHalfHeight;
      edbxDataPanelWidthValue.Enabled:=not DefaultValue_DataPanelHalfWidth;
    end;

  Log.SendInfo('Настройки '+PageControl1.ActivePage.Caption+' были сброшены пользователем в значения по умолчанию.');

  ProcedureFooter;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{3D3256A6-E8E3-4709-A3B3-B7A6E90A75BF}');
  Log.SendInfo('Отображено окно изменения настроек программы.');
  ProcedureFooter;
end;

procedure TConfigurationForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  MainForm.Configuration.ConfigurationFormPage:=cbPage.ItemIndex;
  slBooleanValues.Free;
end;

procedure TConfigurationForm.chkbxEnableLogClick(Sender: TObject);
var
  bUseLog: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxEnableLog.Caption, '{20AFAF3C-D977-4A28-8779-C5F59EB39B45}');

  bUseLog:=chkbxEnableLog.Enabled and chkbxEnableLog.Checked;

  lblShowData.Enabled:=bUseLog;

  chkbxKeepInfoLog.Enabled:=bUseLog;
  chkbxKeepInfoLog.Checked:=chkbxKeepInfoLog.Checked and chkbxKeepInfoLog.Enabled;

  chkbxKeepWarningLog.Enabled:=bUseLog;
  chkbxKeepWarningLog.Checked:=chkbxKeepWarningLog.Checked and chkbxKeepWarningLog.Enabled;

  chkbxKeepErrorLog.Enabled:=bUseLog;
  chkbxKeepErrorLog.Checked:=chkbxKeepErrorLog.Checked and chkbxKeepErrorLog.Enabled;

  chkbxKeepSQLLog.Enabled:=bUseLog;
  chkbxKeepSQLLog.Checked:=chkbxKeepSQLLog.Checked and chkbxKeepSQLLog.Enabled;

  chkbxKeepDebugLog.Enabled:=bUseLog;
  chkbxKeepDebugLog.Checked:=chkbxKeepDebugLog.Checked and chkbxKeepDebugLog.Enabled;

  lblFlushLog.Enabled:=bUseLog;

  chkbxFlushLogOnExit.Enabled:=bUseLog;
  chkbxFlushLogOnExit.Checked:=chkbxFlushLogOnExit.Checked and chkbxFlushLogOnExit.Enabled;

  chkbxFlushLogOnStringsQuantity.Enabled:=bUseLog;
  chkbxFlushLogOnStringsQuantity.Checked:=chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;
  edbxFlushLogOnStringsQuantityValue.Enabled:=bUseLog and chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;
  edbxFlushLogOnStringsQuantityValue.Text:=Routines.GetConditionalString(edbxFlushLogOnStringsQuantityValue.Enabled, Routines.GetConditionalString(MainForm.Configuration.FlushLogOnStringsQuantityValue>0,
    IntToStr(MainForm.Configuration.FlushLogOnStringsQuantityValue), IntToStr(DefaultValue_FlushLogOnStringsQuantityValue)), '');

  chkbxFlushLogOnClearingLog.Enabled:=bUseLog;
  chkbxFlushLogOnClearingLog.Checked:=chkbxFlushLogOnClearingLog.Checked and chkbxFlushLogOnClearingLog.Enabled;

  chkbxFlushLogOnApply.Enabled:=bUseLog;
  chkbxFlushLogOnApply.Checked:=chkbxFlushLogOnApply.Checked and chkbxFlushLogOnApply.Enabled;

  chkbxCustomLogClientFile.Enabled:=bUseLog;
  chkbxCustomLogClientFile.Checked:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFileValue.Enabled:=bUseLog and chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;
  if not bUseLog then
    edbxCustomLogClientFileValue.Text:='';

  Action_ChooseCustomLogClientFile.Enabled:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  Log.SendInfo('Флажок "'+chkbxEnableLog.Caption+'"'+Routines.GetConditionalString(bUseLog, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
var
  bFlushLogOnStringsQuantity: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxFlushLogOnStringsQuantity.Caption, '{56071FBF-61AE-472E-B52B-BC239C45CD7C}');

  bFlushLogOnStringsQuantity:=chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;
  edbxFlushLogOnStringsQuantityValue.Enabled:=bFlushLogOnStringsQuantity;
  edbxFlushLogOnStringsQuantityValue.Text:=Routines.GetConditionalString(bFlushLogOnStringsQuantity, Routines.GetConditionalString(MainForm.Configuration.FlushLogOnStringsQuantityValue>0,
    IntToStr(MainForm.Configuration.FlushLogOnStringsQuantityValue), IntToStr(DefaultValue_FlushLogOnStringsQuantityValue)), '');

  Log.SendInfo('Флажок "'+chkbxFlushLogOnStringsQuantity.Caption+'"'+Routines.GetConditionalString(bFlushLogOnStringsQuantity, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxCustomLogClientFileClick(Sender: TObject);
var
  bCustomLogClientFile: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxCustomLogClientFile.Caption, '{4CBC38D1-3DB9-480E-BA9A-246708A0C0A2}');

  bCustomLogClientFile:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFileValue.Enabled:=bCustomLogClientFile;
  Action_ChooseCustomLogClientFile.Enabled:=bCustomLogClientFile;
  if not bCustomLogClientFile then
    edbxCustomLogClientFileValue.Text:='';

  Log.SendInfo('Флажок "'+chkbxCustomLogClientFile.Caption+'"'+Routines.GetConditionalString(bCustomLogClientFile, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxDataPanelHalfWidthClick(Sender: TObject);
var
  bDataPanelHalfWidth: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxDataPanelHalfWidth.Caption, '{E88569C6-BFE3-4AE7-B34B-6CA8179B0FEA}');

  bDataPanelHalfWidth:=chkbxDataPanelHalfWidth.Checked and chkbxDataPanelHalfWidth.Enabled;
  edbxDataPanelWidthValue.Enabled:=not bDataPanelHalfWidth;
  edbxDataPanelWidthValue.Text:=Routines.GetConditionalString(bDataPanelHalfWidth, '', IntToStr(MainForm.Configuration.DataPanelWidthValue));

  Log.SendInfo('Флажок "'+chkbxDataPanelHalfWidth.Caption+'"'+Routines.GetConditionalString(bDataPanelHalfWidth, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.rbSaveIntoTheCustomFolderClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на радиокнопке', '{77B71A67-5A1E-4D56-ADE8-C42EBD13CAC0}');

  if Sender is TRadioButton then
    with Sender as TRadioButton do
      Log.SendInfo('Нажата радиокнопка "'+Caption+'".');

  edbxCustomReportFolderValue.Enabled:=rbSaveIntoTheCustomFolder.Checked;
  Action_ChooseReportFolder.Enabled:=rbSaveIntoTheCustomFolder.Checked;
  if not rbSaveIntoTheCustomFolder.Checked then
    edbxCustomReportFolderValue.Text:='';

  ProcedureFooter;
end;

procedure TConfigurationForm.edbxNumericFieldKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TConfigurationForm.cbPageSelect(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события выбора пункта выпадающего списка', '{DD1092FC-D170-451E-B28F-B678197E5C0D}');
  Do_PageSelect;
  ProcedureFooter;
end;

procedure TConfigurationForm.FormCreate(Sender: TObject);
const
  ICON_CONFIGURATION=5;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{928DE88A-9894-4B2A-B8AB-6D9BB130BCF6}');

  slBooleanValues:=TStringList.Create;
  with slBooleanValues do
    begin
      Add('Нет');
      Add('Да');
    end;

  ilConfigurationFormSmallImages.GetIcon(ICON_CONFIGURATION, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';

  with MainForm.Configuration do
    begin
      // установка параметров протоколирования в соответствии с настройками программы
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // установка положения окна конфигурации в соответсвии со значениями конфигурации программы
      if ConfigurationFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if ConfigurationFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if ConfigurationFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=ConfigurationFormPosition.x;
          if ConfigurationFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if ConfigurationFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=ConfigurationFormPosition.y;
        end;

      // вкладка "настройки интерфейса"
      chkbxShowAboutWindowAtLaunch.Checked:=ShowAboutWindowAtLaunch;
      chkbxShowToolbarAtLaunch.Checked:=ShowToolbarAtLaunch;
      chkbxShowStatusbarAtLaunch.Checked:=ShowStatusbarAtLaunch;
      chkbxShowEditboxHints.Checked:=ShowEditboxHints;
      chkbxShowCommonSearchEditbox.Checked:=ShowCommonSearchEditbox;
      chkbxShowID.Checked:=ShowID;
      chkbxUseMultibuffer.Checked:=UseMultibuffer;
      chkbxShowConfirmationAtQuit.Checked:=ShowConfirmationAtQuit;

      // вкладка "настройки ведения протокола работы"
      chkbxEnableLog.Checked:=EnableLog;
      chkbxKeepErrorLog.Checked:=(lmtError in KeepLogTypes)and EnableLog;
      chkbxKeepWarningLog.Checked:=(lmtWarning in KeepLogTypes)and EnableLog;
      chkbxKeepInfoLog.Checked:=(lmtInfo in KeepLogTypes)and EnableLog;
      chkbxKeepSQLLog.Checked:=(lmtSQL in KeepLogTypes)and EnableLog;
      chkbxKeepDebugLog.Checked:=(lmtDebug in KeepLogTypes)and EnableLog;
      chkbxFlushLogOnExit.Checked:=FlushLogOnExit and EnableLog;
      chkbxFlushLogOnStringsQuantity.Checked:=FlushLogOnStringsQuantity and EnableLog;
      edbxFlushLogOnStringsQuantityValue.Text:=Routines.GetConditionalString(FlushLogOnStringsQuantity and EnableLog, IntToStr(FlushLogOnStringsQuantityValue), '');
      chkbxFlushLogOnClearingLog.Checked:=FlushLogOnClearingLog and EnableLog;
      chkbxFlushLogOnApply.Checked:=FlushLogOnApply and EnableLog;
      chkbxCustomLogClientFile.Checked:=CustomLogClientFile and EnableLog;
      edbxCustomLogClientFileValue.Text:=Routines.GetConditionalString(CustomLogClientFile and EnableLog, CustomLogClientFileValue, '');
      lblShowData.Enabled:=EnableLog;
      chkbxKeepErrorLog.Enabled:=EnableLog;
      chkbxKeepWarningLog.Enabled:=EnableLog;
      chkbxKeepInfoLog.Enabled:=EnableLog;
      chkbxKeepSQLLog.Enabled:=EnableLog;
      chkbxKeepDebugLog.Enabled:=EnableLog;
      lblFlushLog.Enabled:=EnableLog;
      chkbxFlushLogOnExit.Enabled:=EnableLog;
      chkbxFlushLogOnStringsQuantity.Enabled:=EnableLog;
      edbxFlushLogOnStringsQuantityValue.Enabled:=EnableLog;
      chkbxFlushLogOnClearingLog.Enabled:=EnableLog;
      chkbxFlushLogOnApply.Enabled:=EnableLog;
      chkbxCustomLogClientFile.Enabled:=EnableLog;
      edbxCustomLogClientFileValue.Enabled:=CustomLogClientFile and EnableLog;
      Action_ChooseCustomLogClientFile.Enabled:=CustomLogClientFile and EnableLog;

      // вкладка "настройки положения диалоговых окон"
      ScrollBox1.VertScrollBar.Position:=0;

      chkbxLoginFormPositionByCenter.Checked:=LoginFormPosition.bCenter;
      edbxLoginFormPositionX.Text:=Routines.GetConditionalString(LoginFormPosition.bCenter, '', IntToStr(LoginFormPosition.x));
      edbxLoginFormPositionY.Text:=Routines.GetConditionalString(LoginFormPosition.bCenter, '', IntToStr(LoginFormPosition.y));
      edbxLoginFormPositionX.Enabled:=not LoginFormPosition.bCenter;
      edbxLoginFormPositionY.Enabled:=not LoginFormPosition.bCenter;

      chkbxConfigurationFormPositionByCenter.Checked:=ConfigurationFormPosition.bCenter;
      edbxConfigurationFormPositionX.Text:=Routines.GetConditionalString(ConfigurationFormPosition.bCenter, '', IntToStr(ConfigurationFormPosition.x));
      edbxConfigurationFormPositionY.Text:=Routines.GetConditionalString(ConfigurationFormPosition.bCenter, '', IntToStr(ConfigurationFormPosition.y));
      edbxConfigurationFormPositionX.Enabled:=not ConfigurationFormPosition.bCenter;
      edbxConfigurationFormPositionY.Enabled:=not ConfigurationFormPosition.bCenter;

      chkbxUsersFormPositionByCenter.Checked:=UsersFormPosition.bCenter;
      edbxUsersFormPositionX.Text:=Routines.GetConditionalString(UsersFormPosition.bCenter, '', IntToStr(UsersFormPosition.x));
      edbxUsersFormPositionY.Text:=Routines.GetConditionalString(UsersFormPosition.bCenter, '', IntToStr(UsersFormPosition.y));
      edbxUsersFormPositionX.Enabled:=not UsersFormPosition.bCenter;
      edbxUsersFormPositionY.Enabled:=not UsersFormPosition.bCenter;

      chkbxSetPasswordFormPositionByCenter.Checked:=SetPasswordFormPosition.bCenter;
      edbxSetPasswordFormPositionX.Text:=Routines.GetConditionalString(SetPasswordFormPosition.bCenter, '', IntToStr(SetPasswordFormPosition.x));
      edbxSetPasswordFormPositionY.Text:=Routines.GetConditionalString(SetPasswordFormPosition.bCenter, '', IntToStr(SetPasswordFormPosition.y));
      edbxSetPasswordFormPositionX.Enabled:=not SetPasswordFormPosition.bCenter;
      edbxSetPasswordFormPositionY.Enabled:=not SetPasswordFormPosition.bCenter;

      chkbxStatisticFormPositionByCenter.Checked:=StatisticFormPosition.bCenter;
      edbxStatisticFormPositionX.Text:=Routines.GetConditionalString(StatisticFormPosition.bCenter, '', IntToStr(StatisticFormPosition.x));
      edbxStatisticFormPositionY.Text:=Routines.GetConditionalString(StatisticFormPosition.bCenter, '', IntToStr(StatisticFormPosition.y));
      edbxStatisticFormPositionX.Enabled:=not StatisticFormPosition.bCenter;
      edbxStatisticFormPositionY.Enabled:=not StatisticFormPosition.bCenter;

      chkbxMaintenanceFormPositionByCenter.Checked:=MaintenanceFormPosition.bCenter;
      edbxMaintenanceFormPositionX.Text:=Routines.GetConditionalString(MaintenanceFormPosition.bCenter, '', IntToStr(MaintenanceFormPosition.x));
      edbxMaintenanceFormPositionY.Text:=Routines.GetConditionalString(MaintenanceFormPosition.bCenter, '', IntToStr(MaintenanceFormPosition.y));
      edbxMaintenanceFormPositionX.Enabled:=not MaintenanceFormPosition.bCenter;
      edbxMaintenanceFormPositionY.Enabled:=not MaintenanceFormPosition.bCenter;

      chkbxClearingFormPositionByCenter.Checked:=ClearingFormPosition.bCenter;
      edbxClearingFormPositionX.Text:=Routines.GetConditionalString(ClearingFormPosition.bCenter, '', IntToStr(ClearingFormPosition.x));
      edbxClearingFormPositionY.Text:=Routines.GetConditionalString(ClearingFormPosition.bCenter, '', IntToStr(ClearingFormPosition.y));
      edbxClearingFormPositionX.Enabled:=not ClearingFormPosition.bCenter;
      edbxClearingFormPositionY.Enabled:=not ClearingFormPosition.bCenter;

      chkbxViewPostListFormPositionByCenter.Checked:=ViewPostListFormPosition.bCenter;
      edbxViewPostListFormPositionX.Text:=Routines.GetConditionalString(ViewPostListFormPosition.bCenter, '', IntToStr(ViewPostListFormPosition.x));
      edbxViewPostListFormPositionY.Text:=Routines.GetConditionalString(ViewPostListFormPosition.bCenter, '', IntToStr(ViewPostListFormPosition.y));
      edbxViewPostListFormPositionX.Enabled:=not ViewPostListFormPosition.bCenter;
      edbxViewPostListFormPositionY.Enabled:=not ViewPostListFormPosition.bCenter;

      chkbxCreateViewPostFormPositionByCenter.Checked:=CreateViewPostFormPosition.bCenter;
      edbxCreateViewPostFormPositionX.Text:=Routines.GetConditionalString(CreateViewPostFormPosition.bCenter, '', IntToStr(CreateViewPostFormPosition.x));
      edbxCreateViewPostFormPositionY.Text:=Routines.GetConditionalString(CreateViewPostFormPosition.bCenter, '', IntToStr(CreateViewPostFormPosition.y));
      edbxCreateViewPostFormPositionX.Enabled:=not CreateViewPostFormPosition.bCenter;
      edbxCreateViewPostFormPositionY.Enabled:=not CreateViewPostFormPosition.bCenter;

      chkbxPhonesFormPositionByCenter.Checked:=PhonesFormPosition.bCenter;
      edbxPhonesFormPositionX.Text:=Routines.GetConditionalString(PhonesFormPosition.bCenter, '', IntToStr(PhonesFormPosition.x));
      edbxPhonesFormPositionY.Text:=Routines.GetConditionalString(PhonesFormPosition.bCenter, '', IntToStr(PhonesFormPosition.y));
      edbxPhonesFormPositionX.Enabled:=not PhonesFormPosition.bCenter;
      edbxPhonesFormPositionY.Enabled:=not PhonesFormPosition.bCenter;

      chkbxAddEditPhoneFormPositionByCenter.Checked:=AddEditPhoneFormPosition.bCenter;
      edbxAddEditPhoneFormPositionX.Text:=Routines.GetConditionalString(AddEditPhoneFormPosition.bCenter, '', IntToStr(AddEditPhoneFormPosition.x));
      edbxAddEditPhoneFormPositionY.Text:=Routines.GetConditionalString(AddEditPhoneFormPosition.bCenter, '', IntToStr(AddEditPhoneFormPosition.y));
      edbxAddEditPhoneFormPositionX.Enabled:=not AddEditPhoneFormPosition.bCenter;
      edbxAddEditPhoneFormPositionY.Enabled:=not AddEditPhoneFormPosition.bCenter;

      chkbxAddMassMsrFormPositionByCenter.Checked:=AddMassMsrFormPosition.bCenter;
      edbxAddMassMsrFormPositionX.Text:=Routines.GetConditionalString(AddMassMsrFormPosition.bCenter, '', IntToStr(AddMassMsrFormPosition.x));
      edbxAddMassMsrFormPositionY.Text:=Routines.GetConditionalString(AddMassMsrFormPosition.bCenter, '', IntToStr(AddMassMsrFormPosition.y));
      edbxAddMassMsrFormPositionX.Enabled:=not AddMassMsrFormPosition.bCenter;
      edbxAddMassMsrFormPositionY.Enabled:=not AddMassMsrFormPosition.bCenter;

      // вкладка "настройки процедуры логирования"
      chkbxStoreLastLogin.Checked:=StoreLastLogin;
      chkbxStoreLastPassword.Checked:=StoreLastPassword;
      chkbxAutoLogon.Checked:=AutoLogon and StoreLastLogin and StoreLastPassword;
      chkbxAutoLogon.Enabled:=StoreLastLogin and StoreLastPassword;

      // вкладка "подключения к серверу базы данных услуги"
      vleRNE4SERVER.Cells[1, 1]:=RNE4Server.Host;
      vleRNE4SERVER.ItemProps[1].EditMask:='99999;0; ';
      vleRNE4SERVER.Cells[1, 2]:=IntToStr(RNE4Server.Port);
      vleRNE4SERVER.ItemProps[2].EditMask:='99999;0; ';
      vleRNE4SERVER.Cells[1, 3]:=IntToStr(RNE4Server.Timeout);
      vleRNE4SERVER.ItemProps[3].EditStyle:=esPickList;
      vleRNE4SERVER.ItemProps[3].PickList:=slBooleanValues;
      vleRNE4SERVER.ItemProps[3].ReadOnly:=True;
      vleRNE4SERVER.Cells[1, 4]:=vleRNE4SERVER.ItemProps[3].PickList.Strings[integer(RNE4Server.Compression)];
      vleRNE4SERVER.Cells[1, 5]:=RNE4Server.Database;

      // вкладка "подключения к серверу системы обмена сообщениями"
      vleRNE4MESSAGESSERVER.Cells[1, 1]:=MessagesServer.Host;
      vleRNE4MESSAGESSERVER.ItemProps[1].EditMask:='99999;0; ';
      vleRNE4MESSAGESSERVER.Cells[1, 2]:=IntToStr(MessagesServer.Port);
      vleRNE4MESSAGESSERVER.ItemProps[2].EditMask:='99999;0; ';
      vleRNE4MESSAGESSERVER.Cells[1, 3]:=IntToStr(MessagesServer.Timeout);
      vleRNE4MESSAGESSERVER.ItemProps[3].EditStyle:=esPickList;
      vleRNE4MESSAGESSERVER.ItemProps[3].PickList:=slBooleanValues;
      vleRNE4MESSAGESSERVER.ItemProps[3].ReadOnly:=True;
      vleRNE4MESSAGESSERVER.Cells[1, 4]:=vleRNE4MESSAGESSERVER.ItemProps[3].PickList.Strings[integer(MessagesServer.Compression)];
      vleRNE4MESSAGESSERVER.Cells[1, 5]:=MessagesServer.Database;

      // вкладка "настройки формирования отчётов"
      rbSaveIntoTheTempFolder.Checked:=ReportFolder=rfTempFolder;
      rbSaveIntoTheApplicationFolder.Checked:=ReportFolder=rfApplicationFolder;
      rbSaveIntoTheCustomFolder.Checked:=ReportFolder=rfCustomFolder;
      edbxCustomReportFolderValue.Text:=CustomReportFolderValue;
      chkbxDontDemandOverwriteConfirmation.Checked:=DontDemandOverwriteConfirmation;
      chkbxAskForFileName.Checked:=AskForFileName;
      edbxCustomReportFolderValue.Enabled:=ReportFolder=rfCustomFolder;
      Action_ChooseReportFolder.Enabled:=ReportFolder=rfCustomFolder;

      // вкладка "настройки списка автозамены"
      lblAutoReplaceSorry.Caption:='Извините, но список доступен только для пользователей'+#10#13+'с правами редактирования базы данных'+#10#13+'при подлючении к базе данных!';

      // вкладка "настройки прочие"
      chkbxLaunchAtStartup.Checked:=LaunchAtStartup;
      chkbxPlaySoundOnComplete.Checked:=PlaySoundOnComplete;
      chkbxEnableAutoGetMessages.Checked:=EnableAutoGetMessages;
      edbxAutoGetMessagesCycleDurationValue.Text:=Routines.GetConditionalString(EnableAutoGetMessages, IntToStr(AutoGetMessagesCycleDurationValue), '');
      chkbxCustomHelpFile.Checked:=CustomHelpFile;

      edbxCustomHelpFileValue.Text:=Routines.GetConditionalString(CustomHelpFile, CustomHelpFileValue, '');

      edbxAutoGetMessagesCycleDurationValue.Enabled:=EnableAutoGetMessages;
      edbxCustomHelpFileValue.Enabled:=CustomHelpFile;
      Action_ChooseCustomHelpFile.Enabled:=CustomHelpFile;

      // вкладка "настройки главного окна"
      edbxMainFormPositionX.Text:=Routines.GetConditionalString(not(MainFormPositionByCenter or FullScreenAtLaunch), IntToStr(MainFormRect.Left), '');
      edbxMainFormPositionY.Text:=Routines.GetConditionalString(not(MainFormPositionByCenter or FullScreenAtLaunch), IntToStr(MainFormRect.Top), '');
      chkbxMainFormPositionByCenter.Checked:=MainFormPositionByCenter and(not FullScreenAtLaunch);
      edbxMainFormWidth.Text:=Routines.GetConditionalString(FullScreenAtLaunch, '', IntToStr(MainFormRect.Right-MainFormRect.Left));
      edbxMainFormHeight.Text:=Routines.GetConditionalString(FullScreenAtLaunch, '', IntToStr(MainFormRect.Bottom-MainFormRect.Top));
      chkbxFullScreenAtLaunch.Checked:=FullScreenAtLaunch;

      // вкладка "настройки отображения информации"
      edbxOrganizationPanelHeightValue.Text:=Routines.GetConditionalString(OrganizationPanelHalfHeight, '', IntToStr(OrganizationPanelHeightValue));
      chkbxOrganizationPanelHalfHeight.Checked:=OrganizationPanelHalfHeight;
      edbxDataPanelWidthValue.Text:=Routines.GetConditionalString(DataPanelHalfWidth, '', IntToStr(DataPanelWidthValue));
      chkbxDataPanelHalfWidth.Checked:=DataPanelHalfWidth;
      chkbxShowDataInOtherInfoPanel.Checked:=ShowDataInOtherInfoPanel;
      chkbxShowMeasuresListAsRichEdit.Checked:=ShowMeasuresListAsRichEdit;
      chkbxMarkSearchedStrings.Checked:=MarkSearchedStrings;
      chkbxPutTownAtTheEnd.Checked:=PutTownAtTheEnd;;
      edbxOrganizationPanelHeightValue.Enabled:=not OrganizationPanelHalfHeight;
      edbxDataPanelWidthValue.Enabled:=not DataPanelHalfWidth;

    end;

  cbPage.ItemIndex:=MainForm.Configuration.ConfigurationFormPage;
  Do_PageSelect;
  rbSaveIntoTheCustomFolderClick(Sender);

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxFullScreenAtLaunchClick(Sender: TObject);
var
  bFullScreenAtLaunch: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxFullScreenAtLaunch.Caption, '{52688629-980D-4725-A207-FD5D898B16AB}');

  bFullScreenAtLaunch:=chkbxFullScreenAtLaunch.Checked and chkbxFullScreenAtLaunch.Enabled;
  chkbxMainFormPositionByCenter.Enabled:=not bFullScreenAtLaunch;
  chkbxMainFormPositionByCenter.Checked:=chkbxMainFormPositionByCenter.Checked and(not bFullScreenAtLaunch);
  edbxMainFormPositionX.Enabled:=(not bFullScreenAtLaunch)and(not chkbxMainFormPositionByCenter.Checked);
  edbxMainFormPositionY.Enabled:=(not bFullScreenAtLaunch)and(not chkbxMainFormPositionByCenter.Checked);
  edbxMainFormWidth.Enabled:=not bFullScreenAtLaunch;
  edbxMainFormHeight.Enabled:=not bFullScreenAtLaunch;

  edbxMainFormPositionX.Text:=Routines.GetConditionalString(edbxMainFormPositionX.Enabled, IntToStr(MainForm.Configuration.MainFormRect.Left), '');
  edbxMainFormPositionY.Text:=Routines.GetConditionalString(edbxMainFormPositionY.Enabled, IntToStr(MainForm.Configuration.MainFormRect.Top), '');
  edbxMainFormWidth.Text:=Routines.GetConditionalString(not bFullScreenAtLaunch, IntToStr(MainForm.Configuration.MainFormRect.Right-MainForm.Configuration.MainFormRect.Left), '');
  edbxMainFormHeight.Text:=Routines.GetConditionalString(not bFullScreenAtLaunch, IntToStr(MainForm.Configuration.MainFormRect.Bottom-MainForm.Configuration.MainFormRect.Top), '');

  Log.SendInfo('Флажок "'+chkbxMainFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(bFullScreenAtLaunch, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxLoginFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  LoginForm: TLoginForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxLoginFormPositionByCenter.Caption, '{4F120B29-021D-4F4C-893C-F33E907F3D7A}');

  b:=chkbxLoginFormPositionByCenter.Enabled and chkbxLoginFormPositionByCenter.Checked;
  edbxLoginFormPositionX.Enabled:=not b;
  edbxLoginFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxLoginFormPositionX.Text:='';
      edbxLoginFormPositionY.Text:='';
    end
  else
    begin
      LoginForm:=TLoginForm.Create(Self);
      try
        edbxLoginFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-LoginForm.Width)div 2);
        edbxLoginFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-LoginForm.Height)div 2);
      finally
        LoginForm.Free;
      end;
    end;
  Log.SendInfo('Флажок "'+chkbxLoginFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxSetPasswordFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  // SetPasswordForm: TSetPasswordForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxSetPasswordFormPositionByCenter.Caption, '{9ED32D46-9E32-4491-B6AB-6D5BBF7FD074}');

  b:=chkbxSetPasswordFormPositionByCenter.Enabled and chkbxSetPasswordFormPositionByCenter.Checked;
  edbxSetPasswordFormPositionX.Enabled:=not b;
  edbxSetPasswordFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxSetPasswordFormPositionX.Text:='';
      edbxSetPasswordFormPositionY.Text:='';
    end
  else
    begin
      // SetPasswordForm:=TSetPasswordForm.Create(Self);
      // try
      // edbxSetPasswordFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-SetPasswordForm.Width)div 2);
      // edbxSetPasswordFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-SetPasswordForm.Height)div 2);
      // finally
      // SetPasswordForm.Free;
      // end;
    end;
  Log.SendInfo('Флажок "'+chkbxSetPasswordFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxStatisticFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  // StatisticForm: TStatisticForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxStatisticFormPositionByCenter.Caption, '{24AC0BDC-F297-4CB9-BC03-8A19926A70C6}');

  b:=chkbxStatisticFormPositionByCenter.Enabled and chkbxStatisticFormPositionByCenter.Checked;
  edbxStatisticFormPositionX.Enabled:=not b;
  edbxStatisticFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxStatisticFormPositionX.Text:='';
      edbxStatisticFormPositionY.Text:='';
    end
  else
    begin
      // StatisticForm:=TStatisticForm.Create(Self);
      // try
      // edbxStatisticFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-StatisticForm.Width)div 2);
      // edbxStatisticFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-StatisticForm.Height)div 2);
      // finally
      // StatisticForm.Free;
      // end;
    end;
  Log.SendInfo('Флажок "'+chkbxStatisticFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxStoreLastLoginClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxStoreLastLogin.Caption, '{DF6E7711-9716-4511-8C02-AA1F34D95096}');

  chkbxStoreLastPassword.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked;
  chkbxStoreLastPassword.Checked:=chkbxStoreLastPassword.Checked and chkbxStoreLastPassword.Enabled;
  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked:=chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendInfo('Флажок "'+chkbxStoreLastLogin.Caption+'"'+Routines.GetConditionalString(chkbxStoreLastLogin.Checked, 'в', 'от')+'ключен.');
  Log.SendInfo('Флажок "'+chkbxStoreLastPassword.Caption+'"'+Routines.GetConditionalString(chkbxStoreLastPassword.Checked, 'в', 'от')+'ключен.');
  Log.SendInfo('Флажок "'+chkbxAutoLogon.Caption+'"'+Routines.GetConditionalString(chkbxAutoLogon.Checked, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxStoreLastPasswordClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxStoreLastPassword.Caption, '{C9AD62BE-833A-4C57-904C-0ED5DFB0634F}');

  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked:=chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendInfo('Флажок "'+chkbxStoreLastPassword.Caption+'"'+Routines.GetConditionalString(chkbxStoreLastPassword.Checked, 'в', 'от')+'ключен.');
  Log.SendInfo('Флажок "'+chkbxAutoLogon.Caption+'"'+Routines.GetConditionalString(chkbxAutoLogon.Checked, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxUsersFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  // UsersForm: TUsersForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxUsersFormPositionByCenter.Caption, '{F7984D0B-E438-4B31-8BC8-9C24190065C4}');

  b:=chkbxUsersFormPositionByCenter.Enabled and chkbxUsersFormPositionByCenter.Checked;
  edbxUsersFormPositionX.Enabled:=not b;
  edbxUsersFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxUsersFormPositionX.Text:='';
      edbxUsersFormPositionY.Text:='';
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
  Log.SendInfo('Флажок "'+chkbxUsersFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxViewPostListFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  // ViewPostListForm: TViewPostListForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxViewPostListFormPositionByCenter.Caption, '{0CEE11D1-8BEF-4853-AA5A-707DD2E2FD34}');

  b:=chkbxViewPostListFormPositionByCenter.Enabled and chkbxViewPostListFormPositionByCenter.Checked;
  edbxViewPostListFormPositionX.Enabled:=not b;
  edbxViewPostListFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxViewPostListFormPositionX.Text:='';
      edbxViewPostListFormPositionY.Text:='';
    end
  else
    begin
      // ViewPostListForm:=TViewPostListForm.Create(Self);
      // try
      // edbxViewPostListFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-ViewPostListForm.Width)div 2);
      // edbxViewPostListFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-ViewPostListForm.Height)div 2);
      // finally
      // ViewPostListForm.Free;
      // end;
    end;
  Log.SendInfo('Флажок "'+chkbxViewPostListFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxEnableAutoGetMessagesClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxEnableAutoGetMessages.Caption, '{5C3B5E46-E8F7-4BD1-8092-16B88A617F55}');

  edbxAutoGetMessagesCycleDurationValue.Enabled:=chkbxEnableAutoGetMessages.Checked;
  edbxAutoGetMessagesCycleDurationValue.Text:=Routines.GetConditionalString(edbxAutoGetMessagesCycleDurationValue.Enabled, IntToStr(MainForm.Configuration.AutoGetMessagesCycleDurationValue), '');
  Log.SendInfo('Флажок "'+chkbxEnableAutoGetMessages.Caption+'"'+Routines.GetConditionalString(chkbxEnableAutoGetMessages.Checked, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxAddEditPhoneFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  // AddEditPhoneForm: TAddEditPhoneForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxAddEditPhoneFormPositionByCenter.Caption, '{9D51B088-F24F-4EBC-9CDB-BBD50B769BBB}');

  b:=chkbxAddEditPhoneFormPositionByCenter.Enabled and chkbxAddEditPhoneFormPositionByCenter.Checked;
  edbxAddEditPhoneFormPositionX.Enabled:=not b;
  edbxAddEditPhoneFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxAddEditPhoneFormPositionX.Text:='';
      edbxAddEditPhoneFormPositionY.Text:='';
    end
  else
    begin
      // AddEditPhoneForm:=TAddEditPhoneForm.Create(Self);
      // try
      // edbxAddEditPhoneFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-AddEditPhoneForm.Width)div 2);
      // edbxAddEditPhoneFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-AddEditPhoneForm.Height)div 2);
      // finally
      // AddEditPhoneForm.Free;
      // end;
    end;
  Log.SendInfo('Флажок "'+chkbxAddEditPhoneFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxAddMassMsrFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  AddMassMsrForm: TAddMassMsrForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxAddMassMsrFormPositionByCenter.Caption, '{8E88B020-CF7F-4F40-9C02-B64741BD3133}');

  b:=chkbxAddMassMsrFormPositionByCenter.Enabled and chkbxAddMassMsrFormPositionByCenter.Checked;
  edbxAddMassMsrFormPositionX.Enabled:=not b;
  edbxAddMassMsrFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxAddMassMsrFormPositionX.Text:='';
      edbxAddMassMsrFormPositionY.Text:='';
    end
  else
    begin
      AddMassMsrForm:=TAddMassMsrForm.Create(Self);
      try
        edbxAddMassMsrFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-AddMassMsrForm.Width)div 2);
        edbxAddMassMsrFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-AddMassMsrForm.Height)div 2);
      finally
        AddMassMsrForm.Free;
      end;
    end;
  Log.SendInfo('Флажок "'+chkbxAddMassMsrFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxClearingFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  // ClearingForm: TClearingForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxClearingFormPositionByCenter.Caption, '{6EF352F0-799F-4ECB-8FA5-D283943475C6}');

  b:=chkbxClearingFormPositionByCenter.Enabled and chkbxClearingFormPositionByCenter.Checked;
  edbxClearingFormPositionX.Enabled:=not b;
  edbxClearingFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxClearingFormPositionX.Text:='';
      edbxClearingFormPositionY.Text:='';
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
  Log.SendInfo('Флажок "'+chkbxClearingFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxCreateViewPostFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  // CreateViewPostForm: TCreateViewPostForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxCreateViewPostFormPositionByCenter.Caption, '{E4C4C710-0120-4391-8B8B-3A3DF1D7F95B}');

  b:=chkbxCreateViewPostFormPositionByCenter.Enabled and chkbxCreateViewPostFormPositionByCenter.Checked;
  edbxCreateViewPostFormPositionX.Enabled:=not b;
  edbxCreateViewPostFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxCreateViewPostFormPositionX.Text:='';
      edbxCreateViewPostFormPositionY.Text:='';
    end
  else
    begin
      // CreateViewPostForm:=TCreateViewPostForm.Create(Self);
      // try
      // edbxCreateViewPostFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-CreateViewPostForm.Width)div 2);
      // edbxCreateViewPostFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-CreateViewPostForm.Height)div 2);
      // finally
      // CreateViewPostForm.Free;
      // end;
    end;
  Log.SendInfo('Флажок "'+chkbxCreateViewPostFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxCustomHelpFileClick(Sender: TObject);
var
  bCustomHelpFile: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxCustomHelpFile.Caption, '{C4007F3B-8108-4F5D-8699-A1855EC707B1}');

  bCustomHelpFile:=chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked;

  edbxCustomHelpFileValue.Enabled:=bCustomHelpFile;
  Action_ChooseCustomHelpFile.Enabled:=bCustomHelpFile;
  if not bCustomHelpFile then
    edbxCustomHelpFileValue.Text:='';

  Log.SendInfo('Флажок "'+chkbxCustomHelpFile.Caption+'"'+Routines.GetConditionalString(bCustomHelpFile, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxMainFormPositionByCenterClick(Sender: TObject);
var
  bMainFormPositionByCenter: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxMainFormPositionByCenter.Caption, '{0C75BE73-4F1F-4C3E-8938-728609D1E4F1}');

  bMainFormPositionByCenter:=chkbxMainFormPositionByCenter.Checked and chkbxMainFormPositionByCenter.Enabled;
  edbxMainFormPositionX.Enabled:=not bMainFormPositionByCenter;
  edbxMainFormPositionY.Enabled:=not bMainFormPositionByCenter;
  edbxMainFormPositionX.Text:=Routines.GetConditionalString(edbxMainFormPositionX.Enabled, IntToStr(MainForm.Configuration.MainFormRect.Left), '');
  edbxMainFormPositionY.Text:=Routines.GetConditionalString(edbxMainFormPositionY.Enabled, IntToStr(MainForm.Configuration.MainFormRect.Top), '');

  Log.SendInfo('Флажок "'+chkbxMainFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(bMainFormPositionByCenter, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxMaintenanceFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  // MaintenanceForm: TMaintenanceForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxMaintenanceFormPositionByCenter.Caption, '{4F229484-7E9F-42E6-A641-FA1713C99D80}');

  b:=chkbxMaintenanceFormPositionByCenter.Enabled and chkbxMaintenanceFormPositionByCenter.Checked;
  edbxMaintenanceFormPositionX.Enabled:=not b;
  edbxMaintenanceFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxMaintenanceFormPositionX.Text:='';
      edbxMaintenanceFormPositionY.Text:='';
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
  Log.SendInfo('Флажок "'+chkbxMaintenanceFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxConfigurationFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxConfigurationFormPositionByCenter.Caption, '{BED5B417-AF81-44BC-A216-3C6D966C8A3E}');

  b:=chkbxConfigurationFormPositionByCenter.Enabled and chkbxConfigurationFormPositionByCenter.Checked;
  edbxConfigurationFormPositionX.Enabled:=not b;
  edbxConfigurationFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxConfigurationFormPositionX.Text:='';
      edbxConfigurationFormPositionY.Text:='';
    end
  else
    begin
      edbxConfigurationFormPositionX.Text:=IntToStr((Screen.WorkAreaWidth-Width)div 2);
      edbxConfigurationFormPositionY.Text:=IntToStr((Screen.WorkAreaHeight-Height)div 2);
    end;
  Log.SendInfo('Флажок "'+chkbxConfigurationFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxOrganizationPanelHalfHeightClick(Sender: TObject);
var
  bOrganizationPanelHalfHeight: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxOrganizationPanelHalfHeight.Caption, '{DB478623-5C76-41CE-AD55-E8E101D15815}');

  bOrganizationPanelHalfHeight:=chkbxOrganizationPanelHalfHeight.Checked and chkbxOrganizationPanelHalfHeight.Enabled;
  edbxOrganizationPanelHeightValue.Enabled:=not bOrganizationPanelHalfHeight;
  edbxOrganizationPanelHeightValue.Text:=Routines.GetConditionalString(bOrganizationPanelHalfHeight, '', IntToStr(MainForm.Configuration.OrganizationPanelHeightValue));

  Log.SendInfo('Флажок "'+chkbxOrganizationPanelHalfHeight.Caption+'"'+Routines.GetConditionalString(bOrganizationPanelHalfHeight, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.chkbxPhonesFormPositionByCenterClick(Sender: TObject);
var
  b: boolean;
  // PhonesForm: TPhonesForm;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxPhonesFormPositionByCenter.Caption, '{B3057ACB-A356-4036-997D-FC6034C1974F}');

  b:=chkbxPhonesFormPositionByCenter.Enabled and chkbxPhonesFormPositionByCenter.Checked;
  edbxPhonesFormPositionX.Enabled:=not b;
  edbxPhonesFormPositionY.Enabled:=not b;
  if b then
    begin
      edbxPhonesFormPositionX.Text:='';
      edbxPhonesFormPositionY.Text:='';
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
  Log.SendInfo('Флажок "'+chkbxPhonesFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TConfigurationForm.edbxAutoGetMessagesCycleDurationValueChange(Sender: TObject);
begin
  if StrToIntDef(edbxAutoGetMessagesCycleDurationValue.Text, 1)<1 then
    edbxAutoGetMessagesCycleDurationValue.Text:='1';
  if StrToIntDef(edbxAutoGetMessagesCycleDurationValue.Text, 1)>60 then
    edbxAutoGetMessagesCycleDurationValue.Text:='60';
end;

procedure TConfigurationForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption=' положения диалоговых окон' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

procedure TConfigurationForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption=' положения диалоговых окон' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

end.
