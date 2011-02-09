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
  OA5Types;

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
    Label2: TLabel;
    Bevel1: TBevel;
    Label3: TLabel;
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
    ts10: TTabSheet;
    ts7: TTabSheet;
    chkbxStoreLastLogin: TCheckBox;
    chkbxStoreLastPassword: TCheckBox;
    chkbxAutoLogon: TCheckBox;
    chkbxGetMessages: TCheckBox;
    Edit1: TEdit;
    lblGetMessagesCycleDuration: TLabel;
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
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure LogThis(const aMessage, aLogGroupGUID: string; aMessageType: TLogMessagesType);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
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

procedure TOptionsForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TOptionsForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TOptionsForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TOptionsForm.Action_ApplyExecute(Sender: TObject);
const
  LogGroupGUID: string='{CA167013-A754-476D-B36F-6CE012D8C21E}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Apply.Caption+'"', LogGroupGUID);
  Do_Apply;
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Do_Apply;
const
  LogGroupGUID: string='{33DF7021-2314-4BD2-8FE5-745D3C92231F}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', LogGroupGUID);

  ModalResult:=mrOk;
  LogThis('Попытка изменения настроек программы была подтверждена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения настроек программы закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{E29B1B88-55F3-4F04-A4E7-99D189526C44}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Do_Close;
const
  LogGroupGUID: string='{A114BAEA-0279-44A9-AECA-1D6D0A1C12BA}';
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', LogGroupGUID);

  ModalResult:=mrClose;
  LogThis('Попытка изменения настроек программы была отменена пользователем.', LogGroupGUID, lmtInfo);
  LogThis('Окно изменения настроек программы закрыто.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{C5006F00-F43A-40AE-A060-15853FF8290F}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Do_Help;
const
  LogGroupGUID: string='{A107CDA0-8C13-4A7D-A685-15948B680D49}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', LogGroupGUID);

  LogThis('Производится попытка открытия справочного файла программы...', LogGroupGUID, lmtInfo);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines_GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Action_PreviousPageExecute(Sender: TObject);
const
  LogGroupGUID: string='{DEEC08B4-451D-480B-A392-1E3127868934}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_PreviousPage.Caption+'"', LogGroupGUID);
  Do_PreviousPage;
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Do_PreviousPage;
const
  LogGroupGUID: string='{5C70F626-6F88-4F8B-9F16-93DDCDA4A919}';
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения предыдущей страницы настроек программы', LogGroupGUID);

  i:=cbPage.ItemIndex-1;
  if i<0 then
    i:=cbPage.Items.Count-1;
  cbPage.ItemIndex:=i;
  cbPageSelect(nil);

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Action_NextPageExecute(Sender: TObject);
const
  LogGroupGUID: string='{8AC3593F-EC49-4348-92E9-C34C15492737}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_NextPage.Caption+'"', LogGroupGUID);
  Do_NextPage;
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Do_NextPage;
const
  LogGroupGUID: string='{207F2915-B5C9-4123-A435-AEA01A519A5A}';
var
  i: integer;
begin
  ProcedureHeader('Процедура отображения следующей страницы настроек программы', LogGroupGUID);

  i:=cbPage.ItemIndex+1;
  if i>cbPage.Items.Count-1 then
    i:=0;
  cbPage.ItemIndex:=i;
  cbPageSelect(nil);

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Action_ChooseReportFolderExecute(Sender: TObject);
const
  LogGroupGUID: string='{07B749FB-3200-4928-97AB-6C9ECE22181C}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseReportFolder.Caption+'"', LogGroupGUID);
  Do_ChooseReportFolder;
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Do_ChooseReportFolder;
const
  LogGroupGUID: string='{10574594-BB2E-4D66-B2B0-45CFE6B0BD58}';
var
  s, sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора папки для сохранения отчётов', LogGroupGUID);
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора
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
            LogThis('В качестве папки для сохранения отчётов выбрана папка "'+sPath+'".', LogGroupGUID, lmtDebug);
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
      Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Action_ChooseLogClientExecute(Sender: TObject);
const
  LogGroupGUID: string='{2D27F8F7-46A5-4A52-A527-F80BCE16C56D}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ChooseReportFolder.Caption+'"', LogGroupGUID);
  Do_ChooseLogClient;
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Do_ChooseLogClient;
const
  LogGroupGUID: string='{94AC07F5-5E72-4F4E-9525-BD309C7C807C}';
var
  sPath: string;
  sErrorMessage: string;
  bError: boolean;
  iOldBusyCounter: integer;
begin
  ProcedureHeader('Процедура выбора папки для сохранения отчётов', LogGroupGUID);
  bError:=False;

  with MainForm do
    begin
      iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора
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
              LogThis('В качестве папки для сохранения отчётов выбрана папка "'+sPath+'".', LogGroupGUID, lmtDebug);
            end;
    finally
      Free;
    end;

  with MainForm do
    begin
      iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
      Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора
      Application.ProcessMessages;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{E3A04C17-B2AB-461E-A4F5-2473EC4E9297}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);
  LogThis('Отображено окно изменения настроек программы.', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Action_DefaultsExecute(Sender: TObject);
const
  LogGroupGUID: string='{AB46AE80-4A60-4E43-8B6F-47A2D8E1049F}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Defaults.Caption+'"', LogGroupGUID);
  Do_Defaults;
  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
  LogGroupGUID: string='{307097C9-68DB-47A5-A46D-1432E3A70A84}';
begin
  slBoolean.Free;
end;

procedure TOptionsForm.chkbxUseLogClick(Sender: TObject);
const
  LogGroupGUID: string='{014B87F4-F1A4-43D2-B1C9-86C2ED00B302}';
var
  bUseLog: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxUseLog.Caption, LogGroupGUID);

  bUseLog:=chkbxUseLog.Enabled and chkbxUseLog.Checked;

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

  LogThis('Флажок "'+chkbxUseLog.Caption+'"'+Routines_GetConditionalMessage(bUseLog, 'в', 'от')+'ключен.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.chkbxFlushLogOnStringsQuantityClick(Sender: TObject);
const
  LogGroupGUID: string='{4BB27723-6126-479F-AA75-85258CB0B383}';
var
  bFlushLogOnStringsQuantity: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxFlushLogOnStringsQuantity.Caption, LogGroupGUID);

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

  LogThis('Флажок "'+chkbxFlushLogOnStringsQuantity.Caption+'"'+Routines_GetConditionalMessage(bFlushLogOnStringsQuantity, 'в', 'от')+'ключен.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.chkbxCustomLogClientFileClick(Sender: TObject);
const
  LogGroupGUID: string='{59642A4A-DADE-4683-9005-79FAC3BD0291}';
var
  bCustomLogClientFile: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxCustomLogClientFile.Caption, LogGroupGUID);

  bCustomLogClientFile:=chkbxCustomLogClientFile.Checked and chkbxCustomLogClientFile.Enabled;

  edbxCustomLogClientFile.Enabled:=bCustomLogClientFile;
  Action_ChooseLogClient.Enabled:=bCustomLogClientFile;
  if not bCustomLogClientFile then
    edbxCustomLogClientFile.Text:='';

  LogThis('Флажок "'+chkbxCustomLogClientFile.Caption+'"'+Routines_GetConditionalMessage(bCustomLogClientFile, 'в', 'от')+'ключен.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.rbSaveIntoTheSelectedFolderClick(Sender: TObject);
const
  LogGroupGUID: string='{84E7EFE1-95CB-4D28-97F7-0C89FAF95BBD}';
begin
  if Sender is TRadioButton then
    with Sender as TRadioButton do
      begin
        ProcedureHeader('Процедура отклика на щелчок на радиокнопке "'+Caption+'"', LogGroupGUID);
        LogThis('Нажата радиокнопка "'+Caption+'".', LogGroupGUID, lmtInfo);
      end;

  edbxSelectedFolder.Enabled:=rbSaveIntoTheSelectedFolder.Checked;
  Action_ChooseReportFolder.Enabled:=rbSaveIntoTheSelectedFolder.Checked;

  ProcedureFooter(LogGroupGUID);
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
  LogGroupGUID: string='{928DE88A-9894-4B2A-B8AB-6D9BB130BCF6}';
  ICON_CONFIGURATION=5;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID);

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

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.Do_Defaults;
const
  LogGroupGUID: string='{EDC577E6-6D47-4DC2-973E-AD820C7AC588}';
begin
  ProcedureHeader('Процедура сброса настроек к значениям по умолчанию', LogGroupGUID);

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

  LogThis('Настройки '+PageControl1.ActivePage.Caption+' были сброшены пользователем к значениям по умолчанию.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.chkbxStoreLastLoginClick(Sender: TObject);
const
  LogGroupGUID: string='{94563798-81ED-4231-969F-E2CEAC81DD43}';
var
  bUseLog: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxStoreLastLogin.Caption, LogGroupGUID);

  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  if not chkbxAutoLogon.Enabled then
    chkbxAutoLogon.Checked:=False;
  LogThis('Флажок "'+chkbxStoreLastLogin.Caption+'"'+Routines_GetConditionalMessage(chkbxStoreLastLogin.Checked, 'в', 'от')+'ключен.', LogGroupGUID, lmtInfo);
  LogThis('Флажок "'+chkbxAutoLogon.Caption+'"'+Routines_GetConditionalMessage(chkbxAutoLogon.Checked, 'в', 'от')+'ключен.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TOptionsForm.chkbxStoreLastPasswordClick(Sender: TObject);
const
  LogGroupGUID: string='{49F6B4E7-D782-4C9E-A0C4-C4610FE43097}';
var
  bUseLog: boolean;
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке '+chkbxStoreLastPassword.Caption, LogGroupGUID);

  chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Enabled and chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Enabled and chkbxStoreLastPassword.Checked;
  if not chkbxAutoLogon.Enabled then
    chkbxAutoLogon.Checked:=False;
  LogThis('Флажок "'+chkbxStoreLastPassword.Caption+'"'+Routines_GetConditionalMessage(chkbxStoreLastPassword.Checked, 'в', 'от')+'ключен.', LogGroupGUID, lmtInfo);
  LogThis('Флажок "'+chkbxAutoLogon.Caption+'"'+Routines_GetConditionalMessage(chkbxAutoLogon.Checked, 'в', 'от')+'ключен.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

end.
