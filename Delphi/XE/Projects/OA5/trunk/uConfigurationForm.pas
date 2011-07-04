{$WARN UNIT_PLATFORM OFF}
unit uConfigurationForm;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ImgList,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  ExtCtrls,
  ValEdit,
  Grids,
  ComCtrls,
  uLogProvider;

type
  TOptionsForm=class(TForm)
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
    lblOptionsFormPosition: TLabel;
    lblOptionsFormPositionX: TLabel;
    edbxOptionsFormPositionX: TEdit;
    lblOptionsFormPositionY: TLabel;
    edbxOptionsFormPositionY: TEdit;
    chkbxOptionsFormPositionByCenter: TCheckBox;
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
    edbxOrganizationPanelHeight: TEdit;
    edbxDataPanelWidth: TEdit;
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
    procedure chkbxOptionsFormPositionByCenterClick(Sender: TObject);
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
    slBoolean: TStringList;
  private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
  public
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
  OptionsForm: TOptionsForm;

implementation

{$R *.dfm}

uses
  LogKeeperData,
  FileCtrl,
  uMainForm,
  uRoutines,
  mysql,
  uConfigurationClass,
  OA5Consts;

procedure TOptionsForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TOptionsForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TOptionsForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('��������� ��������� ��� ������.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TOptionsForm.Action_ApplyExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Apply.Caption+'"', '{84DDCA84-3467-43EB-9005-E35C20FD98D0}');
  Do_Apply;
  ProcedureFooter;
end;

procedure TOptionsForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Close.Caption+'"', '{609A88EE-6BC8-4F0F-9C3D-EC1D6FD1A50F}');
  Do_Close;
  ProcedureFooter;
end;

procedure TOptionsForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Help.Caption+'"', '{0CB39D36-EC59-4C76-AFE5-1718B99DA0CA}');
  Do_Help;
  ProcedureFooter;
end;

procedure TOptionsForm.Action_PreviousPageExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_PreviousPage.Caption+'"', '{50728BC6-7E7C-4D0D-9C17-E7919DE4A4C3}');
  Do_PreviousPage;
  ProcedureFooter;
end;

procedure TOptionsForm.Action_NextPageExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_NextPage.Caption+'"', '{0D4FC270-5B1E-4E59-8EBF-89ADBAC0E89F}');
  Do_NextPage;
  ProcedureFooter;
end;

procedure TOptionsForm.Action_ChooseReportFolderExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ChooseReportFolder.Caption+'"', '{0F2D97AB-C59D-456A-ABCA-C390806F896C}');
  Do_ChooseCustomReportFolder;
  ProcedureFooter;
end;

procedure TOptionsForm.Action_ChooseCustomHelpFileExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ChooseCustomHelpFile.Caption+'"', '{708E3642-722E-4556-9774-2F813BD540ED}');
  Do_ChooseCustomHelpFile;
  ProcedureFooter;
end;

procedure TOptionsForm.Action_ChooseCustomLogClientFileExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ChooseReportFolder.Caption+'"', '{24E77954-BFEB-4128-B764-C31ED26D068C}');
  Do_ChooseLogClientFile;
  ProcedureFooter;
end;

procedure TOptionsForm.Action_DefaultsExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Defaults.Caption+'"', '{9B790597-F8F3-47A8-96FE-472EFFB6020E}');
  Do_Defaults;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_Apply;
var
  FormPosition: TFormPosition;
  Rect: TRect;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrOk', '{55D9E5EB-97B6-47FC-B149-348070521077}');

  ModalResult:=mrOk;
  Log.SendInfo('������� ��������� �������� ��������� ���� ������������ �������������.');

  with MainForm.Configuration do
    begin
      // ������� "��������� ����������"
      ShowAboutWindowAtLaunch:=chkbxShowAboutWindowAtLaunch.Enabled and chkbxShowAboutWindowAtLaunch.Checked;
      ShowToolbarAtLaunch:=chkbxShowToolbarAtLaunch.Enabled and chkbxShowToolbarAtLaunch.Checked;
      ShowStatusbarAtLaunch:=chkbxShowStatusbarAtLaunch.Enabled and chkbxShowStatusbarAtLaunch.Checked;
      ShowEditboxHints:=chkbxShowEditboxHints.Enabled and chkbxShowEditboxHints.Checked;
      ShowCommonSearchEditbox:=chkbxShowCommonSearchEditbox.Enabled and chkbxShowCommonSearchEditbox.Checked;
      ShowID:=chkbxShowID.Enabled and chkbxShowID.Checked;
      UseMultibuffer:=chkbxUseMultibuffer.Enabled and chkbxUseMultibuffer.Checked;
      ShowConfirmationAtQuit:=chkbxShowConfirmationAtQuit.Enabled and chkbxShowConfirmationAtQuit.Checked;

      // ������� "��������� ������� ��������� ������"
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
      CustomLogClientFileValue:=Routines.GetConditionalString(chkbxCustomLogClientFile.Enabled and chkbxCustomLogClientFile.Checked and chkbxEnableLog.Enabled and chkbxEnableLog.Checked and edbxCustomLogClientFileValue.Enabled, Trim(edbxCustomLogClientFileValue.Text), DefaultValue_CustomLogClientFileValue);

      // ������� "��������� ��������� ���������� ����"
      FormPosition.bCenter:=chkbxLoginFormPositionByCenter.Enabled and chkbxLoginFormPositionByCenter.Checked;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxLoginFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxLoginFormPositionY.Text),''), DefaultValue_FormPosition_y);
      LoginFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxOptionsFormPositionByCenter.Checked and chkbxOptionsFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxOptionsFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxOptionsFormPositionY.Text),''), DefaultValue_FormPosition_y);
      OptionsFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxUsersFormPositionByCenter.Checked and chkbxUsersFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxUsersFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxUsersFormPositionY.Text),''), DefaultValue_FormPosition_y);
      UsersFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxSetPasswordFormPositionByCenter.Checked and chkbxSetPasswordFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxSetPasswordFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxSetPasswordFormPositionY.Text),''), DefaultValue_FormPosition_y);
      SetPasswordFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxStatisticFormPositionByCenter.Checked and chkbxStatisticFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxStatisticFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxStatisticFormPositionY.Text),''), DefaultValue_FormPosition_y);
      StatisticFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxMaintenanceFormPositionByCenter.Checked and chkbxMaintenanceFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxMaintenanceFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxMaintenanceFormPositionY.Text),''), DefaultValue_FormPosition_y);
      MaintenanceFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxClearingFormPositionByCenter.Checked and chkbxClearingFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxClearingFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxClearingFormPositionY.Text),''), DefaultValue_FormPosition_y);
      ClearingFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxViewPostListFormPositionByCenter.Checked and chkbxViewPostListFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxViewPostListFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxViewPostListFormPositionY.Text),''), DefaultValue_FormPosition_y);
      ViewPostListFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxCreateViewPostFormPositionByCenter.Checked and chkbxCreateViewPostFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxCreateViewPostFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxCreateViewPostFormPositionY.Text),''), DefaultValue_FormPosition_y);
      CreateViewPostFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxPhonesFormPositionByCenter.Checked and chkbxPhonesFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxPhonesFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxPhonesFormPositionY.Text),''), DefaultValue_FormPosition_y);
      PhonesFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxAddEditPhoneFormPositionByCenter.Checked and chkbxAddEditPhoneFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxAddEditPhoneFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxAddEditPhoneFormPositionY.Text),''), DefaultValue_FormPosition_y);
      AddEditPhoneFormPosition:=FormPosition;

      FormPosition.bCenter:=chkbxAddMassMsrFormPositionByCenter.Checked and chkbxAddMassMsrFormPositionByCenter.Enabled;
      FormPosition.x:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxAddMassMsrFormPositionX.Text),''), DefaultValue_FormPosition_x);
      FormPosition.y:=StrToIntDef(Routines.GetConditionalString(not FormPosition.bCenter,Trim(edbxAddMassMsrFormPositionY.Text),''), DefaultValue_FormPosition_y);
      AddMassMsrFormPosition:=FormPosition;

      // ������� "��������� ��������� �����������"
      StoreLastLogin:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked;
      StoreLastPassword:=chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
      AutoLogon:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked and chkbxAutoLogon.Enabled and chkbxAutoLogon.Checked;

      // ������� "����������� � ������� ���� ������ ������"
      if vleRNE4SERVER.Enabled then
        with RNE4Server, vleRNE4SERVER do
          begin
            Host:=Trim(Cells[1, 1]);
            Port:=StrToIntDef(Trim(Cells[1, 2]), DefaultValue_RNE4Server_Port);
            Timeout:=StrToIntDef(Trim(Cells[1, 3]), DefaultValue_RNE4Server_Timeout);
            Compression:=Trim(Cells[1, 4])='��';
            Database:=Trim(Cells[1, 5]);
          end;

      // ������� "����������� � ������� ������� ������ �����������"
      if vleRNE4MESSAGESSERVER.Enabled then
        with MessagesServer, vleRNE4MESSAGESSERVER do
          begin
            Host:=Trim(Cells[1, 1]);
            Port:=StrToIntDef(Trim(Cells[1, 2]), DefaultValue_MessagesServer_Port);
            Timeout:=StrToIntDef(Trim(Cells[1, 3]), DefaultValue_MessagesServer_Timeout);
            Compression:=Trim(Cells[1, 4])='��';
            Database:=Trim(Cells[1, 5]);
          end;

      // ������� "��������� ������������ �������"
      if rbSaveIntoTheTempFolder.Enabled and rbSaveIntoTheTempFolder.Checked then
        ReportFolder:=rfTempFolder;
      if rbSaveIntoTheApplicationFolder.Enabled  and rbSaveIntoTheApplicationFolder.Checked then
        ReportFolder:=rfApplicationFolder;
      if rbSaveIntoTheCustomFolder.Enabled and rbSaveIntoTheCustomFolder.Checked then
        ReportFolder:=rfCustomFolder;

      CustomReportFolderValue:=Routines.GetConditionalString(rbSaveIntoTheCustomFolder.Enabled and rbSaveIntoTheCustomFolder.Checked, Trim(edbxCustomReportFolderValue.Text), DefaultValue_CustomReportFolderValue);
      DontDemandOverwriteConfirmation:=chkbxDontDemandOverwriteConfirmation.Enabled and chkbxDontDemandOverwriteConfirmation.Checked;
      AskForFileName:=chkbxAskForFileName.Enabled and chkbxAskForFileName.Checked;

      // ������� "��������� ������ ����������"

      // ������� "��������� ������"
      LaunchAtStartup:=chkbxLaunchAtStartup.Enabled and chkbxLaunchAtStartup.Checked;
      PlaySoundOnComplete:=chkbxPlaySoundOnComplete.Enabled and chkbxPlaySoundOnComplete.Checked;
      EnableAutoGetMessages:=chkbxEnableAutoGetMessages.Enabled and chkbxEnableAutoGetMessages.Checked;
      AutoGetMessagesCycleDurationValue:=StrToIntDef(Routines.GetConditionalString(chkbxEnableAutoGetMessages.Enabled and chkbxEnableAutoGetMessages.Checked and edbxAutoGetMessagesCycleDurationValue.Enabled, Trim(edbxAutoGetMessagesCycleDurationValue.Text), IntToStr(DefaultValue_AutoGetMessagesCycleDurationValue)), DefaultValue_AutoGetMessagesCycleDurationValue);
      CustomHelpFile:=chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked;
      CustomHelpFileValue:=Routines.GetConditionalString(chkbxCustomHelpFile.Enabled and chkbxCustomHelpFile.Checked and edbxCustomHelpFileValue.Enabled, Trim(edbxCustomHelpFileValue.Text), DefaultValue_CustomHelpFileValue);

      // ������� "��������� �������� ����"
      MainFormPositionByCenter:=chkbxMainFormPositionByCenter.Enabled and chkbxMainFormPositionByCenter.Checked and (not (chkbxFullScreenAtLaunch.Enabled and chkbxFullScreenAtLaunch.Checked));
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

      // ������� "��������� ����������� ����������"
      // edbxOrganizationPanelHeight.Text:=Routines.GetConditionalString(OrganizationPanelHalfHeight, '', IntToStr(OrganizationPanelHeight));
      // chkbxOrganizationPanelHalfHeight.Checked:=OrganizationPanelHalfHeight;
      // edbxDataPanelWidth.Text:=Routines.GetConditionalString(DataPanelHalfWidth, '', IntToStr(DataPanelWidth));
      // chkbxDataPanelHalfWidth.Checked:=DataPanelHalfWidth;
      // chkbxShowDataInOtherInfoPanel.Checked:=ShowDataInOtherInfoPanel;
      // chkbxShowMeasuresListAsRichEdit.Checked:=ShowMeasuresListAsRichEdit;
      // chkbxMarkSearchedStrings.Checked:=MarkSearchedStrings;
      // chkbxPutTownAtTheEnd.Checked:=PutTownAtTheEnd;;
      // edbxOrganizationPanelHeight.Enabled:=not OrganizationPanelHalfHeight;
      // edbxDataPanelWidth.Enabled:=not DataPanelHalfWidth;
    end;

  { TODO : �������� ��� ���������� �������� ��������� � ����� ������������ }

  Log.SendInfo('���� ��������� �������� ��������� �������.');

  ProcedureFooter;
end;

procedure TOptionsForm.Do_Close;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', '{6B58486E-78C2-4F8B-9923-BFC7F5FEA88C}');

  ModalResult:=mrClose;
  Log.SendInfo('������� ��������� �������� ��������� ���� �������� �������������.');
  Log.SendInfo('���� ��������� �������� ��������� �������.');

  ProcedureFooter;
end;

procedure TOptionsForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('��������� ������ ����������� �������', '{4852C968-A8CC-4A2B-947E-4BA717D6A8EE}');

  Log.SendInfo('������������ ������� �������� ����������� ����� ���������...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('��������, ���������� ���� � ������ ��������� �� ������.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TOptionsForm.Do_PreviousPage;
var
  i: integer;
begin
  ProcedureHeader('��������� ����������� ���������� �������� �������� ���������', '{8CC5AFC0-A130-40F8-A13E-441914AFE036}');

  i:=cbPage.ItemIndex-1;
  if i<0 then
    i:=cbPage.Items.Count-1;
  cbPage.ItemIndex:=i;
  Do_PageSelect;

  ProcedureFooter;
end;

procedure TOptionsForm.Do_NextPage;
var
  i: integer;
begin
  ProcedureHeader('��������� ����������� ��������� �������� �������� ���������', '{0408CB52-5F42-4BE4-8BB5-09EBA649B868}');

  i:=cbPage.ItemIndex+1;
  if i>cbPage.Items.Count-1 then
    i:=0;
  cbPage.ItemIndex:=i;
  Do_PageSelect;

  ProcedureFooter;
end;

procedure TOptionsForm.Do_ChooseCustomHelpFile;
var
  sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('��������� ������ ���������� ����������� ����� � ���������', '{DBF9ACD7-9F70-4D0A-9D90-CA893744CBBB}');
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
      iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
      Refresh_BusyState; // ���������� ��������� ����������
    end;

  with TOpenDialog.Create(Self) do
    try
      Filter:='���� ������� � ���������|'+StringReplace(ExtractFileName(Application.ExeName), '.exe', '.chm', [rfReplaceAll, rfIgnoreCase])+'|���������� ����� ������� .CHM|*.chm|���������� ����� ������� .HLP|*.hlp';
      DefaultExt:='chm';
      Title:='�������� ���� �������...';
      FilterIndex:=1;
      Options:=[ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName='' then
          Routines.GenerateError('�������� ������ ��� ������ ����� ������� - ���� �� ��� ������!', sErrorMessage, bError)
        else
          if not FileExists(FileName) then
            Routines.GenerateError('�������� ������ ��� ������ ����� ������� - ��������� ���� �� ����������!', sErrorMessage, bError)
          else
            begin
              edbxCustomHelpFileValue.Text:=FileName;
              Log.SendDebug('� �������� ���������� ����������� ����� ������� ���� "'+sPath+'".');
            end;
    finally
      Free;
    end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
      Refresh_BusyState; // ���������� ��������� ����������
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TOptionsForm.Do_ChooseCustomReportFolder;
var
  s, sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('��������� ������ ����� ��� ���������� �������', '{58DA7933-E4BD-4402-9E83-2446DB94BE14}');
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
      iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
      Refresh_BusyState; // ���������� ��������� ����������
    end;

  s:=edbxCustomReportFolderValue.Text;

  if SelectDirectory('�������� �����', '', s, [sdNewFolder, sdNewUI], Self) then
    if (s<>'') then
      begin
        sPath:=s;
        if (sPath[Length(sPath)]<>'\') then
          sPath:=sPath+'\';
        if SysUtils.DirectoryExists(sPath) then
          begin
            edbxCustomReportFolderValue.Text:=sPath;
            Log.SendDebug('� �������� ����� ��� ���������� ������� ������� ����� "'+sPath+'".');
          end
        else
          begin
            edbxCustomReportFolderValue.Text:='';
            Routines.GenerateError('�������� ������ ��� ������ ����� - ��������� ����� �� ����������!', sErrorMessage, bError);
          end;
      end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
      Refresh_BusyState; // ���������� ��������� ����������
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TOptionsForm.Do_ChooseLogClientFile;
var
  sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('��������� ������ �������� ������� ����������������', '{DCD63D88-72D9-42E5-91EC-35906B335D27}');
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
      iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
      Refresh_BusyState; // ���������� ��������� ����������
    end;

  with TOpenDialog.Create(Self) do
    try
      Filter:='���� ������ ���-�������|LogKeeper.exe|����������� �����|*.exe';
      DefaultExt:='exe';
      Title:='�������� ���� �������� ������� ����������������...';
      FilterIndex:=1;
      Options:=[ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName='' then
          Routines.GenerateError('�������� ������ ��� ������ ����� �������� ������� ���������������� - ���� �� ��� ������!', sErrorMessage, bError)
        else
          if not FileExists(FileName) then
            Routines.GenerateError('�������� ������ ��� ������ ����� �������� ������� ���������������� - ��������� ���� �� ����������!', sErrorMessage, bError)
          else
            begin
              edbxCustomLogClientFileValue.Text:=FileName;
              Log.SendDebug('� �������� ����� �������� ������� ���������������� ������ ���� "'+sPath+'".');
            end;
    finally
      Free;
    end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
      Refresh_BusyState; // ���������� ��������� ����������
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TOptionsForm.Do_PageSelect;
var
  i: integer;
begin
  ProcedureHeader('��������� ���������� ��������� ��������� ���������� � ����������� �� ���������� ������ ����������� ������ ��������', '{396B4482-5CD9-4C26-8AE4-B5CC0F52CF20}');

  // ����� � �������� ������ �������� � ����������
  for i:=0 to PageControl1.PageCount-1 do
    if PageControl1.Pages[i].Caption=cbPage.Items[cbPage.ItemIndex] then
      PageControl1.ActivePageIndex:=i;

  // ����������� �������� ������ �������� � �������� �� ���������
  if (PageControl1.ActivePage.Caption=' ����������� � ������� ���� ������ ������')or(PageControl1.ActivePage.Caption=' ����������� � ������� ������� ������ �����������') then
    begin
      if PageControl1.ActivePage.Caption=' ����������� � ������� ���� ������ ������' then
        Action_Defaults.Enabled:=vleRNE4SERVER.Enabled;
      if PageControl1.ActivePage.Caption=' ����������� � ������� ������� ������ �����������' then
        Action_Defaults.Enabled:=vleRNE4MESSAGESSERVER.Enabled;
    end
  else
    Action_Defaults.Enabled:=not(PageControl1.ActivePage.Caption=' ������ ����������');

  // ����������� �������� �������� � ��������� ������ � ������ �����������
  Action_LineUp.Visible:=(PageControl1.ActivePage.Caption=' ������ ����������')and sgAutoReplaceList.Visible and sgAutoReplaceList.Enabled;
  Action_LineDown.Visible:=Action_LineUp.Visible;

  ProcedureFooter;
end;

procedure TOptionsForm.Do_Defaults;
begin
  ProcedureHeader('��������� ������ �������� � ��������� �� ���������', '{EDC577E6-6D47-4DC2-973E-AD820C7AC588}');

  // ������� "��������� ����������"
  if PageControl1.ActivePage.Caption=' ����������' then
    begin
      // ����������� �������� �� ��������� ��� ���������
      chkbxShowAboutWindowAtLaunch.Checked:=DefaultValue_ShowAboutWindowAtLaunch;
      chkbxShowToolbarAtLaunch.Checked:=DefaultValue_ShowToolbarAtLaunch;
      chkbxShowStatusbarAtLaunch.Checked:=DefaultValue_ShowStatusbarAtLaunch;
      chkbxShowEditboxHints.Checked:=DefaultValue_ShowEditboxHints;
      chkbxShowCommonSearchEditbox.Checked:=DefaultValue_ShowCommonSearchEditbox;
      chkbxShowID.Checked:=DefaultValue_ShowID;
      chkbxUseMultibuffer.Checked:=DefaultValue_UseMultibuffer;
      chkbxShowConfirmationAtQuit.Checked:=DefaultValue_ShowConfirmationAtQuit;
    end;

  // ������� "��������� ������� ��������� ������"
  if PageControl1.ActivePage.Caption=' ������� ��������� ������' then
    begin
      // ����������� �������� �� ��������� ��� ��������� ����������
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
      // ����������� ������� � ��������� ����������
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

  // ������� "��������� ��������� ���������� ����"
  chkbxLoginFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxLoginFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxLoginFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxLoginFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxLoginFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

  chkbxOptionsFormPositionByCenter.Checked:=DefaultValue_FormPosition_Center;
  edbxOptionsFormPositionX.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_x));
  edbxOptionsFormPositionY.Text:=Routines.GetConditionalString(DefaultValue_FormPosition_Center, '', IntToStr(DefaultValue_FormPosition_y));
  edbxOptionsFormPositionX.Enabled:=not DefaultValue_FormPosition_Center;
  edbxOptionsFormPositionY.Enabled:=not DefaultValue_FormPosition_Center;

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

  // ������� "��������� ��������� �����������"
  if PageControl1.ActivePage.Caption=' ��������� �����������' then
    begin
      // ����������� �������� �� ��������� ��� ��������� ����������
      chkbxStoreLastLogin.Checked:=DefaultValue_StoreLastLogin;
      chkbxStoreLastPassword.Checked:=DefaultValue_StoreLastPassword;
      chkbxAutoLogon.Checked:=DefaultValue_AutoLogon and DefaultValue_StoreLastLogin and DefaultValue_StoreLastPassword;
      // ����������� ������� � ��������� ����������
      chkbxAutoLogon.Enabled:=DefaultValue_StoreLastLogin and DefaultValue_StoreLastPassword;
    end;

  // ������� "����������� � ������� ���� ������ ������"
  if PageControl1.ActivePage.Caption=' ����������� � ������� ���� ������ ������' then
    begin
      // ����������� �������� �� ��������� ��� ��������� ����������
      vleRNE4SERVER.Cells[1, 1]:=DefaultValue_RNE4Server_Host;
      vleRNE4SERVER.Cells[1, 2]:=IntToStr(DefaultValue_RNE4Server_Port);
      vleRNE4SERVER.Cells[1, 3]:=IntToStr(DefaultValue_RNE4Server_Timeout);
      vleRNE4SERVER.Cells[1, 4]:=vleRNE4SERVER.ItemProps[3].PickList.Strings[integer(DefaultValue_RNE4Server_Compression)];
      vleRNE4SERVER.Cells[1, 5]:=DefaultValue_RNE4Server_Database;
    end;

  // ������� "����������� � ������� ������� ������ �����������"
  if PageControl1.ActivePage.Caption=' ����������� � ������� ������� ������ �����������' then
    begin
      // ����������� �������� �� ��������� ��� ��������� ����������
      vleRNE4MESSAGESSERVER.Cells[1, 1]:=DefaultValue_MessagesServer_Host;
      vleRNE4MESSAGESSERVER.Cells[1, 2]:=IntToStr(DefaultValue_MessagesServer_Port);
      vleRNE4MESSAGESSERVER.Cells[1, 3]:=IntToStr(DefaultValue_MessagesServer_Timeout);
      vleRNE4MESSAGESSERVER.Cells[1, 4]:=vleRNE4MESSAGESSERVER.ItemProps[3].PickList.Strings[integer(DefaultValue_MessagesServer_Compression)];
      vleRNE4MESSAGESSERVER.Cells[1, 5]:=DefaultValue_MessagesServer_Database;
    end;

  // ������� "��������� ������������ �������"
  if PageControl1.ActivePage.Caption=' ������������ �������' then
    begin
      // ����������� �������� �� ��������� ��� ��������� ����������
      rbSaveIntoTheTempFolder.Checked:=DefaultValue_ReportFolder=rfTempFolder;
      rbSaveIntoTheApplicationFolder.Checked:=DefaultValue_ReportFolder=rfApplicationFolder;
      rbSaveIntoTheCustomFolder.Checked:=DefaultValue_ReportFolder=rfCustomFolder;
      edbxCustomReportFolderValue.Text:=DefaultValue_CustomReportFolderValue;
      chkbxDontDemandOverwriteConfirmation.Checked:=DefaultValue_DontDemandOverwriteConfirmation;
      chkbxAskForFileName.Checked:=DefaultValue_AskForFileName;
      // ����������� ������� � ��������� ����������
      edbxCustomReportFolderValue.Enabled:=DefaultValue_ReportFolder=rfCustomFolder;
      Action_ChooseReportFolder.Enabled:=DefaultValue_ReportFolder=rfCustomFolder;
    end;

  // ������� "��������� ������"
  if PageControl1.ActivePage.Caption=' ������' then
    begin
      // ����������� �������� �� ��������� ��� ��������� ����������
      chkbxLaunchAtStartup.Checked:=DefaultValue_LaunchAtStartup;
      chkbxPlaySoundOnComplete.Checked:=DefaultValue_PlaySoundOnComplete;
      chkbxEnableAutoGetMessages.Checked:=DefaultValue_EnableAutoGetMessages;
      edbxAutoGetMessagesCycleDurationValue.Text:=Routines.GetConditionalString(DefaultValue_EnableAutoGetMessages, IntToStr(DefaultValue_AutoGetMessagesCycleDurationValue), '');
      chkbxCustomHelpFile.Checked:=DefaultValue_CustomHelpFile;
      edbxCustomHelpFileValue.Text:=Routines.GetConditionalString(DefaultValue_CustomHelpFile, DefaultValue_CustomHelpFileValue, '');
      // ����������� ������� � ��������� ����������
      edbxAutoGetMessagesCycleDurationValue.Enabled:=DefaultValue_EnableAutoGetMessages;
      edbxCustomHelpFileValue.Enabled:=DefaultValue_CustomHelpFile;
      Action_ChooseCustomHelpFile.Enabled:=DefaultValue_CustomHelpFile;
    end;

  // ������� "��������� �������� ����"
  if PageControl1.ActivePage.Caption=' �������� ����' then
    begin
      // ����������� �������� �� ��������� ��� ��������� ����������
      edbxMainFormPositionX.Text:=Routines.GetConditionalString(not(DefaultValue_MainFormPositionByCenter or DefaultValue_FullScreenAtLaunch), IntToStr(DefaultValue_MainFormRect_Left), '');
      edbxMainFormPositionY.Text:=Routines.GetConditionalString(not(DefaultValue_MainFormPositionByCenter or DefaultValue_FullScreenAtLaunch), IntToStr(DefaultValue_MainFormRect_Top), '');
      chkbxMainFormPositionByCenter.Checked:=DefaultValue_MainFormPositionByCenter and(not DefaultValue_FullScreenAtLaunch);
      edbxMainFormWidth.Text:=Routines.GetConditionalString(DefaultValue_FullScreenAtLaunch, '', IntToStr(DefaultValue_MainFormRect_Right-DefaultValue_MainFormRect_Left));
      edbxMainFormHeight.Text:=Routines.GetConditionalString(DefaultValue_FullScreenAtLaunch, '', IntToStr(DefaultValue_MainFormRect_Bottom-DefaultValue_MainFormRect_Top));
      chkbxFullScreenAtLaunch.Checked:=DefaultValue_FullScreenAtLaunch;
    end;

  // ������� "��������� ����������� ����������"
  if PageControl1.ActivePage.Caption=' ����������� ����������' then
    begin
      // ����������� �������� �� ��������� ��� ��������� ����������
      edbxOrganizationPanelHeight.Text:=Routines.GetConditionalString(DefaultValue_OrganizationPanelHalfHeight, '', IntToStr(DefaultValue_OrganizationPanelHeight));
      chkbxOrganizationPanelHalfHeight.Checked:=DefaultValue_OrganizationPanelHalfHeight;
      edbxDataPanelWidth.Text:=Routines.GetConditionalString(DefaultValue_DataPanelHalfWidth, '', IntToStr(DefaultValue_DataPanelWidth));
      chkbxDataPanelHalfWidth.Checked:=DefaultValue_DataPanelHalfWidth;
      chkbxShowDataInOtherInfoPanel.Checked:=DefaultValue_ShowDataInOtherInfoPanel;
      chkbxShowMeasuresListAsRichEdit.Checked:=DefaultValue_ShowMeasuresListAsRichEdit;
      chkbxMarkSearchedStrings.Checked:=DefaultValue_MarkSearchedStrings;
      chkbxPutTownAtTheEnd.Checked:=DefaultValue_PutTownAtTheEnd;;
      // ����������� ������� � ��������� ����������
      edbxOrganizationPanelHeight.Enabled:=not DefaultValue_OrganizationPanelHalfHeight;
      edbxDataPanelWidth.Enabled:=not DefaultValue_DataPanelHalfWidth;
    end;

  Log.SendInfo('��������� '+PageControl1.ActivePage.Caption+' ���� �������� ������������� � �������� �� ���������.');

  ProcedureFooter;
end;

procedure TOptionsForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� ����������� ����', '{3D3256A6-E8E3-4709-A3B3-B7A6E90A75BF}');
  Log.SendInfo('���������� ���� ��������� �������� ���������.');
  ProcedureFooter;
end;

procedure TOptionsForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  MainForm.Configuration.ConfigurationFormPage:=cbPage.ItemIndex;
  slBoolean.Free;
end;

procedure TOptionsForm.chkbxEnableLogClick(Sender: TObject);
var
  bUseLog: boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxEnableLog.Caption, '{20AFAF3C-D977-4A28-8779-C5F59EB39B45}');

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

  Log.SendInfo('������ "'+chkbxEnableLog.Caption+'"'+Routines.GetConditionalString(bUseLog, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
var
  bFlushLogOnStringsQuantity: boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxFlushLogOnStringsQuantity.Caption, '{56071FBF-61AE-472E-B52B-BC239C45CD7C}');

  bFlushLogOnStringsQuantity:=chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;
  edbxFlushLogOnStringsQuantityValue.Enabled:=bFlushLogOnStringsQuantity;
  edbxFlushLogOnStringsQuantityValue.Text:=Routines.GetConditionalString(bFlushLogOnStringsQuantity, Routines.GetConditionalString(MainForm.Configuration.FlushLogOnStringsQuantityValue>0,
    IntToStr(MainForm.Configuration.FlushLogOnStringsQuantityValue), IntToStr(DefaultValue_FlushLogOnStringsQuantityValue)), '');

  Log.SendInfo('������ "'+chkbxFlushLogOnStringsQuantity.Caption+'"'+Routines.GetConditionalString(bFlushLogOnStringsQuantity, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxCustomLogClientFileClick(Sender: TObject);
var
  bCustomLogClientFile: boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxCustomLogClientFile.Caption, '{4CBC38D1-3DB9-480E-BA9A-246708A0C0A2}');

  bCustomLogClientFile:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFileValue.Enabled:=bCustomLogClientFile;
  Action_ChooseCustomLogClientFile.Enabled:=bCustomLogClientFile;
  if not bCustomLogClientFile then
    edbxCustomLogClientFileValue.Text:='';

  Log.SendInfo('������ "'+chkbxCustomLogClientFile.Caption+'"'+Routines.GetConditionalString(bCustomLogClientFile, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxDataPanelHalfWidthClick(Sender: TObject);
var
  bDataPanelHalfWidth: boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxDataPanelHalfWidth.Caption, '{E88569C6-BFE3-4AE7-B34B-6CA8179B0FEA}');

  bDataPanelHalfWidth:=chkbxDataPanelHalfWidth.Checked and chkbxDataPanelHalfWidth.Enabled;
  edbxDataPanelWidth.Enabled:=not bDataPanelHalfWidth;
  edbxDataPanelWidth.Text:=Routines.GetConditionalString(bDataPanelHalfWidth, '', IntToStr(MainForm.Configuration.DataPanelWidth));

  Log.SendInfo('������ "'+chkbxDataPanelHalfWidth.Caption+'"'+Routines.GetConditionalString(bDataPanelHalfWidth, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.rbSaveIntoTheCustomFolderClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� �����������', '{77B71A67-5A1E-4D56-ADE8-C42EBD13CAC0}');

  if Sender is TRadioButton then
    with Sender as TRadioButton do
      Log.SendInfo('������ ����������� "'+Caption+'".');

  edbxCustomReportFolderValue.Enabled:=rbSaveIntoTheCustomFolder.Checked;
  Action_ChooseReportFolder.Enabled:=rbSaveIntoTheCustomFolder.Checked;
  if not rbSaveIntoTheCustomFolder.Checked then
    edbxCustomReportFolderValue.Text:='';

  ProcedureFooter;
end;

procedure TOptionsForm.edbxNumericFieldKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "��������" ��� ��������� �������
end;

procedure TOptionsForm.cbPageSelect(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� ������ ������ ����������� ������', '{DD1092FC-D170-451E-B28F-B678197E5C0D}');
  Do_PageSelect;
  ProcedureFooter;
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
const
  ICON_CONFIGURATION=5;
begin
  ProcedureHeader('���������-���������� ������� �������� ����', '{928DE88A-9894-4B2A-B8AB-6D9BB130BCF6}');

  slBoolean:=TStringList.Create;
  with slBoolean do
    begin
      Add('���');
      Add('��');
    end;

  ilConfigurationFormSmallImages.GetIcon(ICON_CONFIGURATION, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';

  with MainForm.Configuration do
    begin
      // ������� "��������� ����������"
      chkbxShowAboutWindowAtLaunch.Checked:=ShowAboutWindowAtLaunch;
      chkbxShowToolbarAtLaunch.Checked:=ShowToolbarAtLaunch;
      chkbxShowStatusbarAtLaunch.Checked:=ShowStatusbarAtLaunch;
      chkbxShowEditboxHints.Checked:=ShowEditboxHints;
      chkbxShowCommonSearchEditbox.Checked:=ShowCommonSearchEditbox;
      chkbxShowID.Checked:=ShowID;
      chkbxUseMultibuffer.Checked:=UseMultibuffer;
      chkbxShowConfirmationAtQuit.Checked:=ShowConfirmationAtQuit;

      // ������� "��������� ������� ��������� ������"
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

      // ������� "��������� ��������� ���������� ����"
      ScrollBox1.VertScrollBar.Position:=0;

      chkbxLoginFormPositionByCenter.Checked:=LoginFormPosition.bCenter;
      edbxLoginFormPositionX.Text:=Routines.GetConditionalString(LoginFormPosition.bCenter, '', IntToStr(LoginFormPosition.x));
      edbxLoginFormPositionY.Text:=Routines.GetConditionalString(LoginFormPosition.bCenter, '', IntToStr(LoginFormPosition.y));
      edbxLoginFormPositionX.Enabled:=not LoginFormPosition.bCenter;
      edbxLoginFormPositionY.Enabled:=not LoginFormPosition.bCenter;

      chkbxOptionsFormPositionByCenter.Checked:=OptionsFormPosition.bCenter;
      edbxOptionsFormPositionX.Text:=Routines.GetConditionalString(OptionsFormPosition.bCenter, '', IntToStr(LoginFormPosition.x));
      edbxOptionsFormPositionY.Text:=Routines.GetConditionalString(OptionsFormPosition.bCenter, '', IntToStr(LoginFormPosition.y));
      edbxOptionsFormPositionX.Enabled:=not OptionsFormPosition.bCenter;
      edbxOptionsFormPositionY.Enabled:=not OptionsFormPosition.bCenter;

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

      // ������� "��������� ��������� �����������"
      chkbxStoreLastLogin.Checked:=StoreLastLogin;
      chkbxStoreLastPassword.Checked:=StoreLastPassword;
      chkbxAutoLogon.Checked:=AutoLogon and StoreLastLogin and StoreLastPassword;
      chkbxAutoLogon.Enabled:=StoreLastLogin and StoreLastPassword;

      // ������� "����������� � ������� ���� ������ ������"
      vleRNE4SERVER.Cells[1, 1]:=RNE4Server.Host;
      vleRNE4SERVER.ItemProps[1].EditMask:='99999;0; ';
      vleRNE4SERVER.Cells[1, 2]:=IntToStr(RNE4Server.Port);
      vleRNE4SERVER.ItemProps[2].EditMask:='99999;0; ';
      vleRNE4SERVER.Cells[1, 3]:=IntToStr(RNE4Server.Timeout);
      vleRNE4SERVER.ItemProps[3].EditStyle:=esPickList;
      vleRNE4SERVER.ItemProps[3].PickList:=slBoolean;
      vleRNE4SERVER.ItemProps[3].ReadOnly:=True;
      vleRNE4SERVER.Cells[1, 4]:=vleRNE4SERVER.ItemProps[3].PickList.Strings[integer(RNE4Server.Compression)];
      vleRNE4SERVER.Cells[1, 5]:=RNE4Server.Database;

      // ������� "����������� � ������� ������� ������ �����������"
      vleRNE4MESSAGESSERVER.Cells[1, 1]:=MessagesServer.Host;
      vleRNE4MESSAGESSERVER.ItemProps[1].EditMask:='99999;0; ';
      vleRNE4MESSAGESSERVER.Cells[1, 2]:=IntToStr(MessagesServer.Port);
      vleRNE4MESSAGESSERVER.ItemProps[2].EditMask:='99999;0; ';
      vleRNE4MESSAGESSERVER.Cells[1, 3]:=IntToStr(MessagesServer.Timeout);
      vleRNE4MESSAGESSERVER.ItemProps[3].EditStyle:=esPickList;
      vleRNE4MESSAGESSERVER.ItemProps[3].PickList:=slBoolean;
      vleRNE4MESSAGESSERVER.ItemProps[3].ReadOnly:=True;
      vleRNE4MESSAGESSERVER.Cells[1, 4]:=vleRNE4MESSAGESSERVER.ItemProps[3].PickList.Strings[integer(MessagesServer.Compression)];
      vleRNE4MESSAGESSERVER.Cells[1, 5]:=MessagesServer.Database;

      // ������� "��������� ������������ �������"
      rbSaveIntoTheTempFolder.Checked:=ReportFolder=rfTempFolder;
      rbSaveIntoTheApplicationFolder.Checked:=ReportFolder=rfApplicationFolder;
      rbSaveIntoTheCustomFolder.Checked:=ReportFolder=rfCustomFolder;
      edbxCustomReportFolderValue.Text:=CustomReportFolderValue;
      chkbxDontDemandOverwriteConfirmation.Checked:=DontDemandOverwriteConfirmation;
      chkbxAskForFileName.Checked:=AskForFileName;
      edbxCustomReportFolderValue.Enabled:=ReportFolder=rfCustomFolder;
      Action_ChooseReportFolder.Enabled:=ReportFolder=rfCustomFolder;

      // ������� "��������� ������ ����������"
      lblAutoReplaceSorry.Caption:='��������, �� ������ �������� ������ ��� �������������'+#10#13+'� ������� �������������� ���� ������'+#10#13+'��� ���������� � ���� ������!';

      // ������� "��������� ������"
      chkbxLaunchAtStartup.Checked:=LaunchAtStartup;
      chkbxPlaySoundOnComplete.Checked:=PlaySoundOnComplete;
      chkbxEnableAutoGetMessages.Checked:=EnableAutoGetMessages;
      edbxAutoGetMessagesCycleDurationValue.Text:=Routines.GetConditionalString(EnableAutoGetMessages, IntToStr(AutoGetMessagesCycleDurationValue), '');
      chkbxCustomHelpFile.Checked:=CustomHelpFile;
      edbxCustomHelpFileValue.Text:=Routines.GetConditionalString(CustomHelpFile, CustomHelpFileValue, '');
      edbxAutoGetMessagesCycleDurationValue.Enabled:=EnableAutoGetMessages;
      edbxCustomHelpFileValue.Enabled:=CustomHelpFile;
      Action_ChooseCustomHelpFile.Enabled:=CustomHelpFile;

      // ������� "��������� �������� ����"
      edbxMainFormPositionX.Text:=Routines.GetConditionalString(not(MainFormPositionByCenter or FullScreenAtLaunch), IntToStr(MainFormRect.Left), '');
      edbxMainFormPositionY.Text:=Routines.GetConditionalString(not(MainFormPositionByCenter or FullScreenAtLaunch), IntToStr(MainFormRect.Top), '');
      chkbxMainFormPositionByCenter.Checked:=MainFormPositionByCenter and(not FullScreenAtLaunch);
      edbxMainFormWidth.Text:=Routines.GetConditionalString(FullScreenAtLaunch, '', IntToStr(MainFormRect.Right-MainFormRect.Left));
      edbxMainFormHeight.Text:=Routines.GetConditionalString(FullScreenAtLaunch, '', IntToStr(MainFormRect.Bottom-MainFormRect.Top));
      chkbxFullScreenAtLaunch.Checked:=FullScreenAtLaunch;

      // ������� "��������� ����������� ����������"
      edbxOrganizationPanelHeight.Text:=Routines.GetConditionalString(OrganizationPanelHalfHeight, '', IntToStr(OrganizationPanelHeight));
      chkbxOrganizationPanelHalfHeight.Checked:=OrganizationPanelHalfHeight;
      edbxDataPanelWidth.Text:=Routines.GetConditionalString(DataPanelHalfWidth, '', IntToStr(DataPanelWidth));
      chkbxDataPanelHalfWidth.Checked:=DataPanelHalfWidth;
      chkbxShowDataInOtherInfoPanel.Checked:=ShowDataInOtherInfoPanel;
      chkbxShowMeasuresListAsRichEdit.Checked:=ShowMeasuresListAsRichEdit;
      chkbxMarkSearchedStrings.Checked:=MarkSearchedStrings;
      chkbxPutTownAtTheEnd.Checked:=PutTownAtTheEnd;;
      edbxOrganizationPanelHeight.Enabled:=not OrganizationPanelHalfHeight;
      edbxDataPanelWidth.Enabled:=not DataPanelHalfWidth;

    end;

  cbPage.ItemIndex:=MainForm.Configuration.ConfigurationFormPage;
  Do_PageSelect;
  rbSaveIntoTheCustomFolderClick(Sender);

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxFullScreenAtLaunchClick(Sender: TObject);
var
  bFullScreenAtLaunch: boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxFullScreenAtLaunch.Caption, '{52688629-980D-4725-A207-FD5D898B16AB}');

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

  Log.SendInfo('������ "'+chkbxMainFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(bFullScreenAtLaunch, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxLoginFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxLoginFormPositionByCenter.Caption, '{4F120B29-021D-4F4C-893C-F33E907F3D7A}');

  edbxLoginFormPositionX.Enabled:=not chkbxLoginFormPositionByCenter.Checked;
  edbxLoginFormPositionX.Text:=Routines.GetConditionalString(edbxLoginFormPositionX.Enabled, IntToStr(MainForm.Configuration.LoginFormPosition.x), '');
  edbxLoginFormPositionY.Enabled:=not chkbxLoginFormPositionByCenter.Checked;
  edbxLoginFormPositionY.Text:=Routines.GetConditionalString(edbxLoginFormPositionY.Enabled, IntToStr(MainForm.Configuration.LoginFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxLoginFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxLoginFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxSetPasswordFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxSetPasswordFormPositionByCenter.Caption, '{9ED32D46-9E32-4491-B6AB-6D5BBF7FD074}');

  edbxSetPasswordFormPositionX.Enabled:=not chkbxSetPasswordFormPositionByCenter.Checked;
  edbxSetPasswordFormPositionX.Text:=Routines.GetConditionalString(edbxSetPasswordFormPositionX.Enabled, IntToStr(MainForm.Configuration.SetPasswordFormPosition.x), '');
  edbxSetPasswordFormPositionY.Enabled:=not chkbxSetPasswordFormPositionByCenter.Checked;
  edbxSetPasswordFormPositionY.Text:=Routines.GetConditionalString(edbxSetPasswordFormPositionY.Enabled, IntToStr(MainForm.Configuration.SetPasswordFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxSetPasswordFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxSetPasswordFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxStatisticFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxStatisticFormPositionByCenter.Caption, '{24AC0BDC-F297-4CB9-BC03-8A19926A70C6}');

  edbxStatisticFormPositionX.Enabled:=not chkbxStatisticFormPositionByCenter.Checked;
  edbxStatisticFormPositionX.Text:=Routines.GetConditionalString(edbxStatisticFormPositionX.Enabled, IntToStr(MainForm.Configuration.StatisticFormPosition.x), '');
  edbxStatisticFormPositionY.Enabled:=not chkbxStatisticFormPositionByCenter.Checked;
  edbxStatisticFormPositionY.Text:=Routines.GetConditionalString(edbxStatisticFormPositionY.Enabled, IntToStr(MainForm.Configuration.StatisticFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxStatisticFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxStatisticFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxStoreLastLoginClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxStoreLastLogin.Caption, '{DF6E7711-9716-4511-8C02-AA1F34D95096}');

  chkbxStoreLastPassword.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked;
  chkbxStoreLastPassword.Checked:=chkbxStoreLastPassword.Checked and chkbxStoreLastPassword.Enabled;
  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked:=chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendInfo('������ "'+chkbxStoreLastLogin.Caption+'"'+Routines.GetConditionalString(chkbxStoreLastLogin.Checked, '�', '��')+'������.');
  Log.SendInfo('������ "'+chkbxStoreLastPassword.Caption+'"'+Routines.GetConditionalString(chkbxStoreLastPassword.Checked, '�', '��')+'������.');
  Log.SendInfo('������ "'+chkbxAutoLogon.Caption+'"'+Routines.GetConditionalString(chkbxAutoLogon.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxStoreLastPasswordClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxStoreLastPassword.Caption, '{C9AD62BE-833A-4C57-904C-0ED5DFB0634F}');

  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked:=chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendInfo('������ "'+chkbxStoreLastPassword.Caption+'"'+Routines.GetConditionalString(chkbxStoreLastPassword.Checked, '�', '��')+'������.');
  Log.SendInfo('������ "'+chkbxAutoLogon.Caption+'"'+Routines.GetConditionalString(chkbxAutoLogon.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxUsersFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxUsersFormPositionByCenter.Caption, '{F7984D0B-E438-4B31-8BC8-9C24190065C4}');

  edbxUsersFormPositionX.Enabled:=not chkbxUsersFormPositionByCenter.Checked;
  edbxUsersFormPositionX.Text:=Routines.GetConditionalString(edbxUsersFormPositionX.Enabled, IntToStr(MainForm.Configuration.UsersFormPosition.x), '');
  edbxUsersFormPositionY.Enabled:=not chkbxUsersFormPositionByCenter.Checked;
  edbxUsersFormPositionY.Text:=Routines.GetConditionalString(edbxUsersFormPositionY.Enabled, IntToStr(MainForm.Configuration.UsersFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxUsersFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxUsersFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxViewPostListFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxViewPostListFormPositionByCenter.Caption, '{0CEE11D1-8BEF-4853-AA5A-707DD2E2FD34}');

  edbxViewPostListFormPositionX.Enabled:=not chkbxViewPostListFormPositionByCenter.Checked;
  edbxViewPostListFormPositionX.Text:=Routines.GetConditionalString(edbxViewPostListFormPositionX.Enabled, IntToStr(MainForm.Configuration.ViewPostListFormPosition.x), '');
  edbxViewPostListFormPositionY.Enabled:=not chkbxViewPostListFormPositionByCenter.Checked;
  edbxViewPostListFormPositionY.Text:=Routines.GetConditionalString(edbxViewPostListFormPositionY.Enabled, IntToStr(MainForm.Configuration.ViewPostListFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxViewPostListFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxViewPostListFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxEnableAutoGetMessagesClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxEnableAutoGetMessages.Caption, '{5C3B5E46-E8F7-4BD1-8092-16B88A617F55}');

  edbxAutoGetMessagesCycleDurationValue.Enabled:=chkbxEnableAutoGetMessages.Checked;
  edbxAutoGetMessagesCycleDurationValue.Text:=Routines.GetConditionalString(edbxAutoGetMessagesCycleDurationValue.Enabled, IntToStr(MainForm.Configuration.AutoGetMessagesCycleDurationValue), '');
  Log.SendInfo('������ "'+chkbxEnableAutoGetMessages.Caption+'"'+Routines.GetConditionalString(chkbxEnableAutoGetMessages.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxAddEditPhoneFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxAddEditPhoneFormPositionByCenter.Caption, '{9D51B088-F24F-4EBC-9CDB-BBD50B769BBB}');

  edbxAddEditPhoneFormPositionX.Enabled:=not chkbxAddEditPhoneFormPositionByCenter.Checked;
  edbxAddEditPhoneFormPositionX.Text:=Routines.GetConditionalString(edbxAddEditPhoneFormPositionX.Enabled, IntToStr(MainForm.Configuration.AddEditPhoneFormPosition.x), '');
  edbxAddEditPhoneFormPositionY.Enabled:=not chkbxAddEditPhoneFormPositionByCenter.Checked;
  edbxAddEditPhoneFormPositionY.Text:=Routines.GetConditionalString(edbxAddEditPhoneFormPositionY.Enabled, IntToStr(MainForm.Configuration.AddEditPhoneFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxAddEditPhoneFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxAddEditPhoneFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxAddMassMsrFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxAddMassMsrFormPositionByCenter.Caption, '{8E88B020-CF7F-4F40-9C02-B64741BD3133}');

  edbxAddMassMsrFormPositionX.Enabled:=not chkbxAddMassMsrFormPositionByCenter.Checked;
  edbxAddMassMsrFormPositionX.Text:=Routines.GetConditionalString(edbxAddMassMsrFormPositionX.Enabled, IntToStr(MainForm.Configuration.AddMassMsrFormPosition.x), '');
  edbxAddMassMsrFormPositionY.Enabled:=not chkbxAddMassMsrFormPositionByCenter.Checked;
  edbxAddMassMsrFormPositionY.Text:=Routines.GetConditionalString(edbxAddMassMsrFormPositionY.Enabled, IntToStr(MainForm.Configuration.AddMassMsrFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxAddMassMsrFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxAddMassMsrFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxClearingFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxClearingFormPositionByCenter.Caption, '{6EF352F0-799F-4ECB-8FA5-D283943475C6}');

  edbxClearingFormPositionX.Enabled:=not chkbxClearingFormPositionByCenter.Checked;
  edbxClearingFormPositionX.Text:=Routines.GetConditionalString(edbxClearingFormPositionX.Enabled, IntToStr(MainForm.Configuration.ClearingFormPosition.x), '');
  edbxClearingFormPositionY.Enabled:=not chkbxClearingFormPositionByCenter.Checked;
  edbxClearingFormPositionY.Text:=Routines.GetConditionalString(edbxClearingFormPositionY.Enabled, IntToStr(MainForm.Configuration.ClearingFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxClearingFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxClearingFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxCreateViewPostFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxCreateViewPostFormPositionByCenter.Caption, '{E4C4C710-0120-4391-8B8B-3A3DF1D7F95B}');

  edbxCreateViewPostFormPositionX.Enabled:=not chkbxCreateViewPostFormPositionByCenter.Checked;
  edbxCreateViewPostFormPositionX.Text:=Routines.GetConditionalString(edbxCreateViewPostFormPositionX.Enabled, IntToStr(MainForm.Configuration.CreateViewPostFormPosition.x), '');
  edbxCreateViewPostFormPositionY.Enabled:=not chkbxCreateViewPostFormPositionByCenter.Checked;
  edbxCreateViewPostFormPositionY.Text:=Routines.GetConditionalString(edbxCreateViewPostFormPositionY.Enabled, IntToStr(MainForm.Configuration.CreateViewPostFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxCreateViewPostFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxCreateViewPostFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxCustomHelpFileClick(Sender: TObject);
var
  bCustomHelpFile: boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxCustomHelpFile.Caption, '{C4007F3B-8108-4F5D-8699-A1855EC707B1}');

  bCustomHelpFile:=chkbxCustomHelpFile.Checked and chkbxCustomHelpFile.Enabled;

  edbxCustomLogClientFileValue.Enabled:=bCustomHelpFile;
  Action_ChooseCustomHelpFile.Enabled:=bCustomHelpFile;
  if not bCustomHelpFile then
    edbxCustomHelpFileValue.Text:='';

  Log.SendInfo('������ "'+chkbxCustomHelpFile.Caption+'"'+Routines.GetConditionalString(bCustomHelpFile, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxMainFormPositionByCenterClick(Sender: TObject);
var
  bMainFormPositionByCenter: boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxMainFormPositionByCenter.Caption, '{0C75BE73-4F1F-4C3E-8938-728609D1E4F1}');

  bMainFormPositionByCenter:=chkbxMainFormPositionByCenter.Checked and chkbxMainFormPositionByCenter.Enabled;
  edbxMainFormPositionX.Enabled:=not bMainFormPositionByCenter;
  edbxMainFormPositionY.Enabled:=not bMainFormPositionByCenter;
  edbxMainFormPositionX.Text:=Routines.GetConditionalString(edbxMainFormPositionX.Enabled, IntToStr(MainForm.Configuration.MainFormRect.Left), '');
  edbxMainFormPositionY.Text:=Routines.GetConditionalString(edbxMainFormPositionY.Enabled, IntToStr(MainForm.Configuration.MainFormRect.Top), '');

  Log.SendInfo('������ "'+chkbxMainFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(bMainFormPositionByCenter, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxMaintenanceFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxMaintenanceFormPositionByCenter.Caption, '{4F229484-7E9F-42E6-A641-FA1713C99D80}');

  edbxMaintenanceFormPositionX.Enabled:=not chkbxMaintenanceFormPositionByCenter.Checked;
  edbxMaintenanceFormPositionX.Text:=Routines.GetConditionalString(edbxMaintenanceFormPositionX.Enabled, IntToStr(MainForm.Configuration.MaintenanceFormPosition.x), '');
  edbxMaintenanceFormPositionY.Enabled:=not chkbxMaintenanceFormPositionByCenter.Checked;
  edbxMaintenanceFormPositionY.Text:=Routines.GetConditionalString(edbxMaintenanceFormPositionY.Enabled, IntToStr(MainForm.Configuration.MaintenanceFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxMaintenanceFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxMaintenanceFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxOptionsFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxOptionsFormPositionByCenter.Caption, '{BED5B417-AF81-44BC-A216-3C6D966C8A3E}');

  edbxOptionsFormPositionX.Enabled:=not chkbxOptionsFormPositionByCenter.Checked;
  edbxOptionsFormPositionX.Text:=Routines.GetConditionalString(edbxOptionsFormPositionX.Enabled, IntToStr(MainForm.Configuration.OptionsFormPosition.x), '');
  edbxOptionsFormPositionY.Enabled:=not chkbxOptionsFormPositionByCenter.Checked;
  edbxOptionsFormPositionY.Text:=Routines.GetConditionalString(edbxOptionsFormPositionY.Enabled, IntToStr(MainForm.Configuration.OptionsFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxOptionsFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxOptionsFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxOrganizationPanelHalfHeightClick(Sender: TObject);
var
  bOrganizationPanelHalfHeight: boolean;
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxOrganizationPanelHalfHeight.Caption, '{DB478623-5C76-41CE-AD55-E8E101D15815}');

  bOrganizationPanelHalfHeight:=chkbxOrganizationPanelHalfHeight.Checked and chkbxOrganizationPanelHalfHeight.Enabled;
  edbxOrganizationPanelHeight.Enabled:=not bOrganizationPanelHalfHeight;
  edbxOrganizationPanelHeight.Text:=Routines.GetConditionalString(bOrganizationPanelHalfHeight, '', IntToStr(MainForm.Configuration.OrganizationPanelHeight));

  Log.SendInfo('������ "'+chkbxOrganizationPanelHalfHeight.Caption+'"'+Routines.GetConditionalString(bOrganizationPanelHalfHeight, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxPhonesFormPositionByCenterClick(Sender: TObject);
begin
  ProcedureHeader('��������� ������� �� ������ �� ������ '+chkbxPhonesFormPositionByCenter.Caption, '{B3057ACB-A356-4036-997D-FC6034C1974F}');

  edbxPhonesFormPositionX.Enabled:=not chkbxPhonesFormPositionByCenter.Checked;
  edbxPhonesFormPositionX.Text:=Routines.GetConditionalString(edbxPhonesFormPositionX.Enabled, IntToStr(MainForm.Configuration.PhonesFormPosition.x), '');
  edbxPhonesFormPositionY.Enabled:=not chkbxPhonesFormPositionByCenter.Checked;
  edbxPhonesFormPositionY.Text:=Routines.GetConditionalString(edbxPhonesFormPositionY.Enabled, IntToStr(MainForm.Configuration.PhonesFormPosition.y), '');
  Log.SendInfo('������ "'+chkbxPhonesFormPositionByCenter.Caption+'"'+Routines.GetConditionalString(chkbxPhonesFormPositionByCenter.Checked, '�', '��')+'������.');

  ProcedureFooter;
end;

procedure TOptionsForm.edbxAutoGetMessagesCycleDurationValueChange(Sender: TObject);
begin
  if StrToIntDef(edbxAutoGetMessagesCycleDurationValue.Text, 1)<1 then
    edbxAutoGetMessagesCycleDurationValue.Text:='1';
  if StrToIntDef(edbxAutoGetMessagesCycleDurationValue.Text, 1)>60 then
    edbxAutoGetMessagesCycleDurationValue.Text:='60';
end;

procedure TOptionsForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption=' ��������� ���������� ����' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

procedure TOptionsForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption=' ��������� ���������� ����' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

end.
