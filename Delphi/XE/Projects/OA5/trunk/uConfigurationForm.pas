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
    edbxAutoGetMessagesCycleDuration: TEdit;
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
    procedure edbxFlushLogOnStringsQuantityValueKeyPress(Sender: TObject; var Key: Char);
    procedure chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
    procedure rbSaveIntoTheCustomFolderClick(Sender: TObject);
    procedure chkbxStoreLastLoginClick(Sender: TObject);
    procedure chkbxStoreLastPasswordClick(Sender: TObject);
    procedure chkbxEnableAutoGetMessagesClick(Sender: TObject);
    procedure edbxAutoGetMessagesCycleDurationKeyPress(Sender: TObject; var Key: Char);
    procedure edbxAutoGetMessagesCycleDurationChange(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure chkbxMainFormPositionByCenterClick(Sender: TObject);
    procedure chkbxFullScreenAtLaunchClick(Sender: TObject);
    procedure Action_ChooseCustomHelpFileExecute(Sender: TObject);
    procedure chkbxCustomHelpFileClick(Sender: TObject);
    procedure edbxMainFormPositionXKeyPress(Sender: TObject; var Key: Char);
    procedure edbxMainFormPositionYKeyPress(Sender: TObject; var Key: Char);
    procedure edbxMainFormWidthKeyPress(Sender: TObject; var Key: Char);
    procedure edbxMainFormHeightKeyPress(Sender: TObject; var Key: Char);
    procedure edbxOrganizationPanelHeightKeyPress(Sender: TObject; var Key: Char);
    procedure edbxDataPanelWidthKeyPress(Sender: TObject; var Key: Char);
    procedure chkbxOrganizationPanelHalfHeightClick(Sender: TObject);
    procedure chkbxDataPanelHalfWidthClick(Sender: TObject);
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
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TOptionsForm.Action_ApplyExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', '{84DDCA84-3467-43EB-9005-E35C20FD98D0}');
  Do_Apply;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_Apply;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{55D9E5EB-97B6-47FC-B149-348070521077}');

  ModalResult:=mrOk;
  Log.SendInfo('Попытка изменения настроек программы была подтверждена пользователем.');
  Log.SendInfo('Окно изменения настроек программы закрыто.');

  ProcedureFooter;
end;

procedure TOptionsForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{609A88EE-6BC8-4F0F-9C3D-EC1D6FD1A50F}');
  Do_Close;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{6B58486E-78C2-4F8B-9923-BFC7F5FEA88C}');

  ModalResult:=mrClose;
  Log.SendInfo('Попытка изменения настроек программы была отменена пользователем.');
  Log.SendInfo('Окно изменения настроек программы закрыто.');

  ProcedureFooter;
end;

procedure TOptionsForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{0CB39D36-EC59-4C76-AFE5-1718B99DA0CA}');
  Do_Help;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{4852C968-A8CC-4A2B-947E-4BA717D6A8EE}');

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TOptionsForm.Action_PreviousPageExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_PreviousPage.Caption+'"', '{50728BC6-7E7C-4D0D-9C17-E7919DE4A4C3}');
  Do_PreviousPage;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_PreviousPage;
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения предыдущей страницы настроек программы', '{8CC5AFC0-A130-40F8-A13E-441914AFE036}');

  i:=cbPage.ItemIndex-1;
  if i<0 then
    i:=cbPage.Items.Count-1;
  cbPage.ItemIndex:=i;
  cbPageSelect(nil);

  ProcedureFooter;
end;

procedure TOptionsForm.Action_NextPageExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_NextPage.Caption+'"', '{0D4FC270-5B1E-4E59-8EBF-89ADBAC0E89F}');
  Do_NextPage;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_NextPage;
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения следующей страницы настроек программы', '{0408CB52-5F42-4BE4-8BB5-09EBA649B868}');

  i:=cbPage.ItemIndex+1;
  if i>cbPage.Items.Count-1 then
    i:=0;
  cbPage.ItemIndex:=i;
  cbPageSelect(nil);

  ProcedureFooter;
end;

procedure TOptionsForm.Action_ChooseReportFolderExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseReportFolder.Caption+'"', '{0F2D97AB-C59D-456A-ABCA-C390806F896C}');
  Do_ChooseCustomReportFolder;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_ChooseCustomHelpFile;
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

procedure TOptionsForm.Do_ChooseCustomReportFolder;
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

procedure TOptionsForm.Action_ChooseCustomHelpFileExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseCustomHelpFile.Caption+'"', '{708E3642-722E-4556-9774-2F813BD540ED}');
  Do_ChooseCustomHelpFile;
  ProcedureFooter;
end;

procedure TOptionsForm.Action_ChooseCustomLogClientFileExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseReportFolder.Caption+'"', '{24E77954-BFEB-4128-B764-C31ED26D068C}');
  Do_ChooseLogClientFile;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_ChooseLogClientFile;
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

procedure TOptionsForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{3D3256A6-E8E3-4709-A3B3-B7A6E90A75BF}');
  Log.SendInfo('Отображено окно изменения настроек программы.');
  ProcedureFooter;
end;

procedure TOptionsForm.Action_DefaultsExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Defaults.Caption+'"', '{9B790597-F8F3-47A8-96FE-472EFFB6020E}');
  Do_Defaults;
  ProcedureFooter;
end;

procedure TOptionsForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  slBoolean.Free;
end;

procedure TOptionsForm.chkbxEnableLogClick(Sender: TObject);
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

  if edbxFlushLogOnStringsQuantityValue.Enabled then
    begin
      if MainForm.Configuration.FlushLogOnStringsQuantityValue>0 then
        edbxFlushLogOnStringsQuantityValue.Text:=IntToStr(MainForm.Configuration.FlushLogOnStringsQuantityValue)
      else
        edbxFlushLogOnStringsQuantityValue.Text:='10000';
    end
  else
    edbxFlushLogOnStringsQuantityValue.Text:='';

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

procedure TOptionsForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
var
  bFlushLogOnStringsQuantity: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxFlushLogOnStringsQuantity.Caption, '{56071FBF-61AE-472E-B52B-BC239C45CD7C}');

  bFlushLogOnStringsQuantity:=chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;

  edbxFlushLogOnStringsQuantityValue.Enabled:=bFlushLogOnStringsQuantity;

  edbxFlushLogOnStringsQuantityValue.Text:=Routines.GetConditionalString(bFlushLogOnStringsQuantity, Routines.GetConditionalString(MainForm.Configuration.FlushLogOnStringsQuantityValue>0, IntToStr(MainForm.Configuration.FlushLogOnStringsQuantityValue),
    IntToStr(DefaultValue_FlushLogOnStringsQuantityValue)), '');

  // if bFlushLogOnStringsQuantity then
  // begin
  // with MainForm do
  // if FlushLogOnStringsQuantityValue>0 then
  // edbxFlushLogOnStringsQuantityValue.Text:=IntToStr(FlushLogOnStringsQuantityValue)
  // else
  // edbxFlushLogOnStringsQuantityValue.Text:='10000';
  // end
  // else
  // edbxFlushLogOnStringsQuantityValue.Text:='';

  Log.SendInfo('Флажок "'+chkbxFlushLogOnStringsQuantity.Caption+'"'+Routines.GetConditionalString(bFlushLogOnStringsQuantity, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxCustomLogClientFileClick(Sender: TObject);
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

procedure TOptionsForm.chkbxDataPanelHalfWidthClick(Sender: TObject);
var
  bDataPanelHalfWidth: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxDataPanelHalfWidth.Caption, '{E88569C6-BFE3-4AE7-B34B-6CA8179B0FEA}');

  bDataPanelHalfWidth:=chkbxDataPanelHalfWidth.Checked and chkbxDataPanelHalfWidth.Enabled;
  edbxDataPanelWidth.Enabled:=not bDataPanelHalfWidth;
  edbxDataPanelWidth.Text:=Routines.GetConditionalString(bDataPanelHalfWidth, '', IntToStr(MainForm.Configuration.DataPanelWidth));

  Log.SendInfo('Флажок "'+chkbxDataPanelHalfWidth.Caption+'"'+Routines.GetConditionalString(bDataPanelHalfWidth, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.rbSaveIntoTheCustomFolderClick(Sender: TObject);
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

procedure TOptionsForm.edbxFlushLogOnStringsQuantityValueKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TOptionsForm.edbxMainFormHeightKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TOptionsForm.edbxMainFormPositionXKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TOptionsForm.edbxMainFormPositionYKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TOptionsForm.edbxMainFormWidthKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TOptionsForm.edbxOrganizationPanelHeightKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

// !!!!!!!!!!
// Далее располагаются неотлаженные процедуры
// !!!!!!!!!!

procedure TOptionsForm.cbPageSelect(Sender: TObject);
var
  i: integer;
begin
  // поиск и открытие нужной страницы в компоненте
  for i:=0 to PageControl1.PageCount-1 do
    begin
      if PageControl1.Pages[i].Caption=cbPage.Items[cbPage.ItemIndex] then
        PageControl1.ActivePageIndex:=i;
    end;

  { TODO : Отладить, т.к. блок был написан с нуля. }

  // доступность действия сброса настроек в значения по умолчанию
  if (PageControl1.ActivePage.Caption=' подключения к серверу базы данных услуги')or(PageControl1.ActivePage.Caption=' подключения к серверу системы обмена сообщениями') then
    begin
      if PageControl1.ActivePage.Caption=' подключения к серверу базы данных услуги' then
        begin
          Action_Defaults.Enabled:=vleRNE4SERVER.Enabled;
          // Action_Defaults.Visible:=Action_Defaults.Enabled;
        end;
      if PageControl1.ActivePage.Caption=' подключения к серверу системы обмена сообщениями' then
        begin
          Action_Defaults.Enabled:=vleRNE4MESSAGESSERVER.Enabled;
          // Action_Defaults.Visible:=Action_Defaults.Enabled;
        end;
    end
  else
    if PageControl1.ActivePage.Caption=' списка автозамены' then
      begin
        Action_Defaults.Enabled:=False;
        // Action_Defaults.Visible:=False;
      end
    else
      begin
        Action_Defaults.Enabled:=True;
        // Action_Defaults.Visible:=True;
      end;

  // доступность действия поднятия и опускания строки в списке автощзамены
  Action_LineUp.Visible:=(PageControl1.ActivePage.Caption=' списка автозамены')and sgAutoReplaceList.Visible and sgAutoReplaceList.Enabled;
  Action_LineDown.Visible:=Action_LineUp.Visible;
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
const
  ICON_CONFIGURATION=5;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{928DE88A-9894-4B2A-B8AB-6D9BB130BCF6}');

  ilConfigurationFormSmallImages.GetIcon(ICON_CONFIGURATION, Icon);

  Action_Help.Enabled:=Application.HelpFile<>'';

  slBoolean:=TStringList.Create;
  with slBoolean do
    begin
      Add('Нет');
      Add('Да');
    end;

  lblAutoReplaceSorry.Caption:='Извините, но список доступен только для пользователей'+#10#13+'с правами редактирования базы данных'+#10#13+'при подлючении к базе данных!';

  // инициализации компонентов вкладки настроек интерфейса
  { TODO : Дописать код }

  // инициализации компонентов вкладки настроек подключения к серверу RNE4SERVER
  vleRNE4SERVER.ItemProps[1].EditMask:='99999;0; '; // номер порта
  vleRNE4SERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
  vleRNE4SERVER.ItemProps[2].EditMask:='99999;0; '; // таймаут
  vleRNE4SERVER.Cells[1, 3]:=IntToStr(30);
  vleRNE4SERVER.ItemProps[3].EditStyle:=esPickList; // сжатие данных
  vleRNE4SERVER.ItemProps[3].ReadOnly:=True;
  vleRNE4SERVER.ItemProps[3].PickList:=slBoolean;
  vleRNE4SERVER.Cells[1, 4]:=vleRNE4SERVER.ItemProps[3].PickList.Strings[1];

  // инициализации компонентов вкладки настроек подключения к серверу RNE4MESSAGESSERVER
  vleRNE4MESSAGESSERVER.ItemProps[1].EditMask:='99999;0; '; // номер порта
  vleRNE4MESSAGESSERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
  vleRNE4MESSAGESSERVER.ItemProps[2].EditMask:='99999;0; '; // таймаут
  vleRNE4MESSAGESSERVER.Cells[1, 3]:=IntToStr(30);
  vleRNE4MESSAGESSERVER.ItemProps[3].EditStyle:=esPickList; // сжатие данных
  vleRNE4MESSAGESSERVER.ItemProps[3].ReadOnly:=True;
  vleRNE4MESSAGESSERVER.ItemProps[3].PickList:=slBoolean;
  vleRNE4MESSAGESSERVER.Cells[1, 4]:=vleRNE4MESSAGESSERVER.ItemProps[3].PickList.Strings[1];

  cbPage.ItemIndex:=0;
  cbPageSelect(Sender);
  rbSaveIntoTheCustomFolderClick(Sender);

  ProcedureFooter;
end;

procedure TOptionsForm.Do_Defaults;
begin
  ProcedureHeader('Процедура сброса настроек к значениям по умолчанию', '{EDC577E6-6D47-4DC2-973E-AD820C7AC588}');

  { TODO : Добавить изменение значений контролов на значения по умолчанию }

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
      if DefaultValue_FlushLogOnStringsQuantity and DefaultValue_EnableLog then
        edbxFlushLogOnStringsQuantityValue.Text:=IntToStr(DefaultValue_FlushLogOnStringsQuantityValue)
      else
        edbxFlushLogOnStringsQuantityValue.Text:='';
      chkbxFlushLogOnClearingLog.Checked:=DefaultValue_FlushLogOnClearingLog and DefaultValue_EnableLog;
      chkbxFlushLogOnApply.Checked:=DefaultValue_FlushLogOnApply and DefaultValue_EnableLog;
      chkbxCustomLogClientFile.Checked:=DefaultValue_CustomLogClientFile and DefaultValue_EnableLog;
      if DefaultValue_CustomLogClientFile and DefaultValue_EnableLog then
        edbxCustomLogClientFileValue.Text:=DefaultValue_CustomLogClientFileValue
      else
        edbxCustomLogClientFileValue.Text:='';
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
      edbxAutoGetMessagesCycleDuration.Text:=Routines.GetConditionalString(DefaultValue_EnableAutoGetMessages, IntToStr(DefaultValue_AutoGetMessagesCycleDuration), '');
      chkbxCustomHelpFile.Checked:=DefaultValue_CustomHelpFile;
      edbxCustomHelpFileValue.Text:=Routines.GetConditionalString(DefaultValue_CustomHelpFile, DefaultValue_CustomHelpFileValue, '');
      // выставление доступа к элементам интерфейса
      edbxAutoGetMessagesCycleDuration.Enabled:=DefaultValue_EnableAutoGetMessages;
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
      edbxOrganizationPanelHeight.Text:=Routines.GetConditionalString(DefaultValue_OrganizationPanelHalfHeight, '', IntToStr(DefaultValue_OrganizationPanelHeight));
      chkbxOrganizationPanelHalfHeight.Checked:=DefaultValue_OrganizationPanelHalfHeight;
      edbxDataPanelWidth.Text:=Routines.GetConditionalString(DefaultValue_DataPanelHalfWidth, '', IntToStr(DefaultValue_DataPanelWidth));
      chkbxDataPanelHalfWidth.Checked:=DefaultValue_DataPanelHalfWidth;
      chkbxShowDataInOtherInfoPanel.Checked:=DefaultValue_ShowDataInOtherInfoPanel;
      chkbxShowMeasuresListAsRichEdit.Checked:=DefaultValue_ShowMeasuresListAsRichEdit;
      chkbxMarkSearchedStrings.Checked:=DefaultValue_MarkSearchedStrings;
      chkbxPutTownAtTheEnd.Checked:=DefaultValue_PutTownAtTheEnd;;
      // выставление доступа к элементам интерфейса
      edbxOrganizationPanelHeight.Enabled:=not DefaultValue_OrganizationPanelHalfHeight;
      edbxDataPanelWidth.Enabled:=not DefaultValue_DataPanelHalfWidth;
    end;

  Log.SendInfo('Настройки '+PageControl1.ActivePage.Caption+' были сброшены пользователем в значения по умолчанию.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxFullScreenAtLaunchClick(Sender: TObject);
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

procedure TOptionsForm.chkbxStoreLastLoginClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxStoreLastLogin.Caption, '{DF6E7711-9716-4511-8C02-AA1F34D95096}');

  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked:=chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendInfo('Флажок "'+chkbxStoreLastLogin.Caption+'"'+Routines.GetConditionalString(chkbxStoreLastLogin.Checked, 'в', 'от')+'ключен.');
  Log.SendInfo('Флажок "'+chkbxAutoLogon.Caption+'"'+Routines.GetConditionalString(chkbxAutoLogon.Checked, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxStoreLastPasswordClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxStoreLastPassword.Caption, '{C9AD62BE-833A-4C57-904C-0ED5DFB0634F}');

  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  chkbxAutoLogon.Checked:=chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
  Log.SendInfo('Флажок "'+chkbxStoreLastPassword.Caption+'"'+Routines.GetConditionalString(chkbxStoreLastPassword.Checked, 'в', 'от')+'ключен.');
  Log.SendInfo('Флажок "'+chkbxAutoLogon.Caption+'"'+Routines.GetConditionalString(chkbxAutoLogon.Checked, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxEnableAutoGetMessagesClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxEnableAutoGetMessages.Caption, '{5C3B5E46-E8F7-4BD1-8092-16B88A617F55}');

  edbxAutoGetMessagesCycleDuration.Enabled:=chkbxEnableAutoGetMessages.Checked;
  edbxAutoGetMessagesCycleDuration.Text:=Routines.GetConditionalString(edbxAutoGetMessagesCycleDuration.Enabled, IntToStr(MainForm.Configuration.AutoGetMessagesCycleDuration), '');
  Log.SendInfo('Флажок "'+chkbxEnableAutoGetMessages.Caption+'"'+Routines.GetConditionalString(chkbxEnableAutoGetMessages.Checked, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxCustomHelpFileClick(Sender: TObject);
var
  bCustomHelpFile: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxCustomHelpFile.Caption, '{C4007F3B-8108-4F5D-8699-A1855EC707B1}');

  bCustomHelpFile:=chkbxCustomHelpFile.Checked and chkbxCustomHelpFile.Enabled;

  edbxCustomLogClientFileValue.Enabled:=bCustomHelpFile;
  Action_ChooseCustomHelpFile.Enabled:=bCustomHelpFile;
  if not bCustomHelpFile then
    edbxCustomHelpFileValue.Text:='';

  Log.SendInfo('Флажок "'+chkbxCustomHelpFile.Caption+'"'+Routines.GetConditionalString(bCustomHelpFile, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxMainFormPositionByCenterClick(Sender: TObject);
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

procedure TOptionsForm.chkbxOrganizationPanelHalfHeightClick(Sender: TObject);
var
  bOrganizationPanelHalfHeight: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxOrganizationPanelHalfHeight.Caption, '{DB478623-5C76-41CE-AD55-E8E101D15815}');

  bOrganizationPanelHalfHeight:=chkbxOrganizationPanelHalfHeight.Checked and chkbxOrganizationPanelHalfHeight.Enabled;
  edbxOrganizationPanelHeight.Enabled:=not bOrganizationPanelHalfHeight;
  edbxOrganizationPanelHeight.Text:=Routines.GetConditionalString(bOrganizationPanelHalfHeight, '', IntToStr(MainForm.Configuration.OrganizationPanelHeight));

  Log.SendInfo('Флажок "'+chkbxOrganizationPanelHalfHeight.Caption+'"'+Routines.GetConditionalString(bOrganizationPanelHalfHeight, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.edbxAutoGetMessagesCycleDurationChange(Sender: TObject);
begin
  if StrToIntDef(edbxAutoGetMessagesCycleDuration.Text, 1)<1 then
    edbxAutoGetMessagesCycleDuration.Text:='1';
  if StrToIntDef(edbxAutoGetMessagesCycleDuration.Text, 1)>60 then
    edbxAutoGetMessagesCycleDuration.Text:='60';
end;

procedure TOptionsForm.edbxAutoGetMessagesCycleDurationKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TOptionsForm.edbxDataPanelWidthKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TOptionsForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption=' положения диалоговых окон' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

procedure TOptionsForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption=' положения диалоговых окон' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

end.
