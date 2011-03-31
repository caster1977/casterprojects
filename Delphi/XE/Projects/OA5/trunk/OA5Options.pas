{$WARN UNIT_PLATFORM OFF}
unit OA5Options;

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
  Grids,
  ValEdit,
  ComCtrls,
  OA5Types, uLogProvider;

type
  TStringGridX=class(TStringGrid)
  public
    procedure MoveRow(FromIndex, ToIndex: Longint);
  end;

  TOptionsForm=class(TForm)
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_Defaults: TAction;
    Action_Close: TAction;
    Action_Apply: TAction;
    Action_PreviousPage: TAction;
    Action_NextPage: TAction;
    Action_ChooseLogClient: TAction;
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
    vleInterface: TValueListEditor;
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
    edbxFlushLogOnStringsQuantity: TEdit;
    chkbxFlushLogOnClearingLog: TCheckBox;
    chkbxFlushLogOnApply: TCheckBox;
    chkbxKeepDebugLog: TCheckBox;
    ts5: TTabSheet;
    Bevel3: TBevel;
    rbSaveIntoTheTempFolder: TRadioButton;
    rbSaveIntoTheSelectedFolder: TRadioButton;
    rbSaveIntoTheApplicationFolder: TRadioButton;
    chkbxAskForFileName: TCheckBox;
    edbxSelectedFolder: TEdit;
    btnSelectFolder: TButton;
    chkbxDontDemandOverwriteConfirmation: TCheckBox;
    ts2: TTabSheet;
    vleRNE4SERVER: TValueListEditor;
    ts3: TTabSheet;
    vleRNE4MESSAGESSERVER: TValueListEditor;
    chkbxCustomLogClientFile: TCheckBox;
    edbxCustomLogClientFile: TEdit;
    btnChoiseCustomLogClientFile: TButton;
    Action_ChooseReportFolder: TAction;
    chkbxUseLog: TCheckBox;
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
    chkbxGetMessages: TCheckBox;
    edbxGetMessagesCycleDuration: TEdit;
    lblGetMessagesCycleDuration: TLabel;
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
    chkbxStartupFullScreen: TCheckBox;
    Log: TLogProvider;
    procedure FormCreate(Sender: TObject);
    procedure Action_ApplyExecute(Sender: TObject);
    procedure Action_DefaultsExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_PreviousPageExecute(Sender: TObject);
    procedure Action_NextPageExecute(Sender: TObject);
    procedure Action_ChooseReportFolderExecute(Sender: TObject);
    procedure Action_ChooseLogClientExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cbPageSelect(Sender: TObject);
    procedure chkbxCustomLogClientFileClick(Sender: TObject);
    procedure chkbxUseLogClick(Sender: TObject);
    procedure edbxFlushLogOnStringsQuantityKeyPress(Sender: TObject; var Key: Char);
    procedure chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
    procedure rbSaveIntoTheSelectedFolderClick(Sender: TObject);
    procedure chkbxStoreLastLoginClick(Sender: TObject);
    procedure chkbxStoreLastPasswordClick(Sender: TObject);
    procedure chkbxGetMessagesClick(Sender: TObject);
    procedure edbxGetMessagesCycleDurationKeyPress(Sender: TObject;
      var Key: Char);
    procedure edbxGetMessagesCycleDurationChange(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
  public
    slBoolean: TStringList;
  private
    procedure Do_Help;
    procedure Do_Defaults;
    procedure Do_Close;
    procedure Do_Apply;
    procedure Do_NextPage;
    procedure Do_PreviousPage;
    procedure Do_ChooseReportFolder;
    procedure Do_ChooseLogClient;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
  end;

var
  OptionsForm: TOptionsForm;

implementation

{$R *.dfm}

uses
  FileCtrl,
  OA5Main,
  mysql,
  OA5Routines,
  OA5Configuration,
  OA5Consts;

procedure TStringGridX.MoveRow(FromIndex, ToIndex: Integer);
begin
  inherited;
end;

(*
procedure TOptionsForm.LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
var
  s: string;
  aCopyData: TCopyDataStruct;
begin
  case aMessageType of
    lmtError:
      s:='ERROR';
    lmtWarning:
      s:='WARNING';
    lmtInfo:
      s:='INFO';
    lmtSQL:
      s:='SQL';
    lmtDebug:
      s:='DEBUG';
  end;
  s:=IntToStr(WMCD_MODALLOG)+';'+s+';'+aMessage+';'+aLogGroupGUID;
  with aCopyData do
    begin
      dwData:=0;
      cbData:=Length(s)+1;
      lpData:=PAnsiChar(AnsiString(s));
    end;
  SendMessage(MainForm.Handle, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
end;
*)

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
    Routines_GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

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
  Do_ChooseReportFolder;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_ChooseReportFolder;
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

  s:=edbxSelectedFolder.Text;

  if SelectDirectory('Выберите папку', '', s, [sdNewFolder, sdNewUI], Self) then
    if (s<>'') then
      begin
        sPath:=s;
        if (sPath[Length(sPath)]<>'\') then
          sPath:=sPath+'\';
        if SysUtils.DirectoryExists(sPath) then
          begin
            edbxSelectedFolder.Text:=sPath;
            Log.SendDebug('В качестве папки для сохранения отчётов выбрана папка "'+sPath+'".');
          end
        else
          begin
            edbxSelectedFolder.Text:='';
            Routines_GenerateError('Возникла ошибка при выборе папки - указанная папка не существует!', sErrorMessage, bError);
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

procedure TOptionsForm.Action_ChooseLogClientExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseReportFolder.Caption+'"', '{24E77954-BFEB-4128-B764-C31ED26D068C}');
  Do_ChooseLogClient;
  ProcedureFooter;
end;

procedure TOptionsForm.Do_ChooseLogClient;
var
  sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора папки для сохранения отчётов', '{D4DB6A7E-DEB9-433D-BAF5-74E86459D66C}');
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
          Routines_GenerateError('Возникла ошибка при выборе файла внешнего клиента протоколирования - файл не был выбран!', sErrorMessage, bError)
        else
          if not FileExists(FileName) then
            Routines_GenerateError('Возникла ошибка при выборе файла внешнего клиента протоколирования - выбранный файл не существует!', sErrorMessage, bError)
          else
            begin
              edbxCustomLogClientFile.Text:=FileName;
              Log.SendDebug('В качестве папки для сохранения отчётов выбрана папка "'+sPath+'".');
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

procedure TOptionsForm.chkbxUseLogClick(Sender: TObject);
var
  bUseLog: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxUseLog.Caption, '{20AFAF3C-D977-4A28-8779-C5F59EB39B45}');

  bUseLog:=chkbxUseLog.Enabled and chkbxUseLog.Checked;

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

  edbxFlushLogOnStringsQuantity.Enabled:=bUseLog and chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;

  if edbxFlushLogOnStringsQuantity.Enabled then
    begin
      with MainForm do
        if Configuration.iFlushLogOnStringsQuantity>0 then
          edbxFlushLogOnStringsQuantity.Text:=IntToStr(Configuration.iFlushLogOnStringsQuantity)
        else
          edbxFlushLogOnStringsQuantity.Text:='10000';
    end
  else
    edbxFlushLogOnStringsQuantity.Text:='';

  chkbxFlushLogOnClearingLog.Enabled:=bUseLog;
  chkbxFlushLogOnClearingLog.Checked:=chkbxFlushLogOnClearingLog.Checked and chkbxFlushLogOnClearingLog.Enabled;

  chkbxFlushLogOnApply.Enabled:=bUseLog;
  chkbxFlushLogOnApply.Checked:=chkbxFlushLogOnApply.Checked and chkbxFlushLogOnApply.Enabled;

  chkbxCustomLogClientFile.Enabled:=bUseLog;
  chkbxCustomLogClientFile.Checked:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFile.Enabled:=bUseLog and chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;
  if not bUseLog then
    edbxCustomLogClientFile.Text:='';

  Action_ChooseLogClient.Enabled:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  Log.SendInfo('Флажок "'+chkbxUseLog.Caption+'"'+Routines_GetConditionalMessage(bUseLog, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
var
  bFlushLogOnStringsQuantity: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxFlushLogOnStringsQuantity.Caption, '{56071FBF-61AE-472E-B52B-BC239C45CD7C}');

  bFlushLogOnStringsQuantity:=chkbxFlushLogOnStringsQuantity.Checked and chkbxFlushLogOnStringsQuantity.Enabled;

  edbxFlushLogOnStringsQuantity.Enabled:=bFlushLogOnStringsQuantity;
  if bFlushLogOnStringsQuantity then
    begin
      with MainForm do
        if Configuration.iFlushLogOnStringsQuantity>0 then
          edbxFlushLogOnStringsQuantity.Text:=IntToStr(Configuration.iFlushLogOnStringsQuantity)
        else
          edbxFlushLogOnStringsQuantity.Text:='10000';
    end
  else
    edbxFlushLogOnStringsQuantity.Text:='';

  Log.SendInfo('Флажок "'+chkbxFlushLogOnStringsQuantity.Caption+'"'+Routines_GetConditionalMessage(bFlushLogOnStringsQuantity, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxCustomLogClientFileClick(Sender: TObject);
var
  bCustomLogClientFile: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxCustomLogClientFile.Caption, '{4CBC38D1-3DB9-480E-BA9A-246708A0C0A2}');

  bCustomLogClientFile:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFile.Enabled:=bCustomLogClientFile;
  Action_ChooseLogClient.Enabled:=bCustomLogClientFile;
  if not bCustomLogClientFile then
    edbxCustomLogClientFile.Text:='';

  Log.SendInfo('Флажок "'+chkbxCustomLogClientFile.Caption+'"'+Routines_GetConditionalMessage(bCustomLogClientFile, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.rbSaveIntoTheSelectedFolderClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на радиокнопке', '{77B71A67-5A1E-4D56-ADE8-C42EBD13CAC0}');

  if Sender is TRadioButton then
    with Sender as TRadioButton do
      Log.SendInfo('Нажата радиокнопка "'+Caption+'".');

  edbxSelectedFolder.Enabled:=rbSaveIntoTheSelectedFolder.Checked;
  Action_ChooseReportFolder.Enabled:=rbSaveIntoTheSelectedFolder.Checked;

  ProcedureFooter;
end;

procedure TOptionsForm.edbxFlushLogOnStringsQuantityKeyPress(Sender: TObject; var Key: Char);
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

  cbPage.ItemIndex:=MainForm.Configuration.iConfigurationFormPage;
  if cbPage.ItemIndex<0 then
    cbPage.ItemIndex:=0;
  cbPageSelect(Sender);
  rbSaveIntoTheSelectedFolderClick(Sender);

  ProcedureFooter;
end;

procedure TOptionsForm.Do_Defaults;
begin
  ProcedureHeader('Процедура сброса настроек к значениям по умолчанию', '{EDC577E6-6D47-4DC2-973E-AD820C7AC588}');

  { TODO : Добавить изменение значений контролов на значения по умолчанию }

  if PageControl1.ActivePage.Caption=' интерфейса' then
    begin
    end;

  if PageControl1.ActivePage.Caption=' процедуры логирования' then
    begin
      chkbxStoreLastLogin.Checked:=False;
      chkbxStoreLastPassword.Checked:=False;
      chkbxAutoLogon.Checked:=False;
      chkbxAutoLogon.Enabled:=False;
    end;

  if PageControl1.ActivePage.Caption=' подключения к серверу базы данных услуги' then
    begin
      vleRNE4SERVER.Cells[1, 1]:='RNE4SERVER';
      vleRNE4SERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
      vleRNE4SERVER.Cells[1, 3]:=IntToStr(30);
      vleRNE4SERVER.Cells[1, 4]:=vleRNE4SERVER.ItemProps[3].PickList.Strings[1];
      vleRNE4SERVER.Cells[1, 5]:='rne4';
    end;

  if PageControl1.ActivePage.Caption=' подключения к серверу системы обмена сообщениями' then
    begin
      vleRNE4MESSAGESSERVER.Cells[1, 1]:='RNE4MESSAGESSERVER';
      vleRNE4MESSAGESSERVER.Cells[1, 2]:=IntToStr(MYSQL_PORT);
      vleRNE4MESSAGESSERVER.Cells[1, 3]:=IntToStr(30);
      vleRNE4MESSAGESSERVER.Cells[1, 4]:=vleRNE4MESSAGESSERVER.ItemProps[3].PickList.Strings[1];
      vleRNE4MESSAGESSERVER.Cells[1, 5]:='rne4';
    end;

  if PageControl1.ActivePage.Caption=' ведения протокола работы' then
    begin
      chkbxUseLog.Checked:=True;
      chkbxKeepErrorLog.Checked:=True;
      chkbxKeepWarningLog.Checked:=True;
      chkbxKeepInfoLog.Checked:=True;
      chkbxKeepSQLLog.Checked:=False;
      chkbxKeepDebugLog.Checked:=False;
      chkbxFlushLogOnExit.Checked:=True;
      chkbxFlushLogOnStringsQuantity.Checked:=False;
      edbxFlushLogOnStringsQuantity.Text:='';
      chkbxFlushLogOnClearingLog.Checked:=True;
      chkbxFlushLogOnApply.Checked:=False;
      chkbxCustomLogClientFile.Checked:=False;
    end;

  if PageControl1.ActivePage.Caption=' формирования отчётов' then
    begin
      rbSaveIntoTheTempFolder.Checked:=True;
      edbxSelectedFolder.Text:='';
      chkbxDontDemandOverwriteConfirmation.Checked:=False;
      chkbxAskForFileName.Checked:=False;
    end;

  Log.SendInfo('Настройки '+PageControl1.ActivePage.Caption+' были сброшены пользователем к значениям по умолчанию.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxStoreLastLoginClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxStoreLastLogin.Caption, '{DF6E7711-9716-4511-8C02-AA1F34D95096}');

  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  if not chkbxAutoLogon.Enabled then
    chkbxAutoLogon.Checked:=False;
  Log.SendInfo('Флажок "'+chkbxStoreLastLogin.Caption+'"'+Routines_GetConditionalMessage(chkbxStoreLastLogin.Checked, 'в', 'от')+'ключен.');
  Log.SendInfo('Флажок "'+chkbxAutoLogon.Caption+'"'+Routines_GetConditionalMessage(chkbxAutoLogon.Checked, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxStoreLastPasswordClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxStoreLastPassword.Caption, '{C9AD62BE-833A-4C57-904C-0ED5DFB0634F}');

  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  if not chkbxAutoLogon.Enabled then
    chkbxAutoLogon.Checked:=False;
  Log.SendInfo('Флажок "'+chkbxStoreLastPassword.Caption+'"'+Routines_GetConditionalMessage(chkbxStoreLastPassword.Checked, 'в', 'от')+'ключен.');
  Log.SendInfo('Флажок "'+chkbxAutoLogon.Caption+'"'+Routines_GetConditionalMessage(chkbxAutoLogon.Checked, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.chkbxGetMessagesClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxGetMessages.Caption, '{5C3B5E46-E8F7-4BD1-8092-16B88A617F55}');

  edbxGetMessagesCycleDuration.Enabled:=chkbxGetMessages.Checked;
  if edbxGetMessagesCycleDuration.Enabled then
    edbxGetMessagesCycleDuration.Text:=IntToStr(MainForm.Configuration.iGetMessagesCycleDuration)
  else edbxGetMessagesCycleDuration.Clear;
  Log.SendInfo('Флажок "'+chkbxGetMessages.Caption+'"'+Routines_GetConditionalMessage(chkbxGetMessages.Checked, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

procedure TOptionsForm.edbxGetMessagesCycleDurationChange(Sender: TObject);
begin
  if StrToIntDef(edbxGetMessagesCycleDuration.Text, 1)<1 then
    edbxGetMessagesCycleDuration.Text:='1';
  if StrToIntDef(edbxGetMessagesCycleDuration.Text, 1)>60 then
    edbxGetMessagesCycleDuration.Text:='60';
end;

procedure TOptionsForm.edbxGetMessagesCycleDurationKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8, '-']) then
    Key:=#0; // "погасить" все остальные клавиши
end;

procedure TOptionsForm.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption=' положения диалоговых окон' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEDOWN, 0);
end;

procedure TOptionsForm.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
  if PageControl1.ActivePage.Caption=' положения диалоговых окон' then
    SendMessage(ScrollBox1.Handle, WM_VSCROLL, SB_LINEUP, 0);
end;

end.
