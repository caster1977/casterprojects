unit LogKeeper.uMainForm;

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
  ComCtrls,
  ImgList,
  AppEvnts,
  ExtCtrls,
  Menus,
  ActnList,
  XPStyleActnCtrls,
  ActnMan,
  CommCtrl,
  ToolWin,
  ActnCtrls,
  LogKeeper.uConsts,
  LogKeeper.uTypes,
  System.Actions,
  CastersPackage.uTApplicationOnHint;

type
  THackControl = class(TControl);

  TMainForm = class(TForm)
    StatusBar1: TStatusBar;
    pbMain: TProgressBar;
    Memo1: TMemo;
    ApplicationEvents1: TApplicationEvents;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_About: TAction;
    Action_Quit: TAction;
    Action_Restore: TAction;
    Action_CopyLogStringToClipboard: TAction;
    pmTray: TPopupMenu;
    ActionRestore1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    O1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    pmLog: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    Image1: TImage;
    TrayIcon1: TTrayIcon;
    Timer2: TTimer;
    pnlLog: TPanel;
    GroupBox7: TGroupBox;
    lvLog: TListView;
    Panel5: TPanel;
    btnMaximazeLogPanel: TButton;
    btnRestoreLogPanel: TButton;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    N7: TMenuItem;
    MenuItem2: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    O2: TMenuItem;
    ListBox1: TListBox;
    Action_RestoreLogPanel: TAction;
    Action_MaximizeLogPanel: TAction;
    Action_ClearLogList: TAction;
    Action_Configuration: TAction;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    miStatusbar: TMenuItem;
    Action_CopySQLFromLogToClipboard: TAction;
    N13: TMenuItem;
    SQL1: TMenuItem;
    pmMsg: TPopupMenu;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    Action_ClearMsgList: TAction;
    Action_CopyMsgStringToClipboard: TAction;
    Action_CopySQLFromMsgToClipboard: TAction;
    pnlMain: TPanel;
    Action_Connect: TAction;
    Action_Disconnect: TAction;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    Action_FindNextWithSuchGUID: TAction;
    GUID1: TMenuItem;
    N17: TMenuItem;
    Action_FindPreviousWithSuchGUID: TAction;
    GUIDF21: TMenuItem;
    Action_CopyGUIDStringToClipboard: TAction;
    GUID2: TMenuItem;
    ExitTimer: TTimer;
    Action_FindSpecifiedGUID: TAction;
    GUID3: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    aplctnhnt1: TApplicationOnHint;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_RestoreExecute(Sender: TObject);
    procedure Action_CopyLogStringToClipboardExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pmLogPopup(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure Action_RestoreLogPanelExecute(Sender: TObject);
    procedure Action_MaximizeLogPanelExecute(Sender: TObject);
    procedure Action_ClearLogListExecute(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure miStatusbarClick(Sender: TObject);
    procedure Action_CopySQLFromLogToClipboardExecute(Sender: TObject);
    procedure pmMsgPopup(Sender: TObject);
    procedure Action_ClearMsgListExecute(Sender: TObject);
    procedure Action_CopyMsgStringToClipboardExecute(Sender: TObject);
    procedure Action_CopySQLFromMsgToClipboardExecute(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure Action_DisconnectExecute(Sender: TObject);
    procedure Action_ConnectExecute(Sender: TObject);
    procedure Action_FindNextWithSuchGUIDExecute(Sender: TObject);
    procedure lvLogCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvLogCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
      var DefaultDraw: Boolean);
    procedure lvLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Action_FindPreviousWithSuchGUIDExecute(Sender: TObject);
    procedure Action_CopyGUIDStringToClipboardExecute(Sender: TObject);
    procedure ExitTimerTimer(Sender: TObject);
    procedure Action_FindSpecifiedGUIDExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    iBusyCounter: Integer;
    bFirstRun: Boolean;
    msgLogKeeperServer, msgLogKeeperClient: cardinal;
    SessionLogEventCount: cardinal;
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: Integer);
    procedure PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: Integer);
    procedure Update_MainFormPosition;
    procedure Update_QuantityOfMessagesStrings;
    procedure Update_QuantityOfLogStrings;

    procedure Do_TransferMessageToDB;
    procedure Do_RestoreMainForm;
    procedure Do_MinimizeMainForm;
    procedure Do_About;
    procedure Do_FindNextWithSuchGUID;
    procedure Do_FindPreviousWithSuchGUID;
    procedure Do_FindSpecifiedGUID;
    procedure Do_Configuration;
    procedure Do_CopyMsgStringToClipboard;
    procedure Do_CopyLogStringToClipboard;
    procedure Do_CopySQLFromMsgToClipboard;
    procedure Do_CopySQLFromLogToClipboard;
    procedure Do_ClearLogList;
    procedure Do_ClearMsgList;
    procedure Do_RestoreLogPanel;
    procedure Do_Help;
    procedure Do_MaximizeLogPanel;
    procedure Do_Disconnect;
    procedure Do_SaveConfigIni;
    procedure Do_LoadConfigIni;
    procedure Do_CopyGUIDStringToClipboard;
    procedure Do_FlushLogToFile;
    procedure Do_Close;
    procedure Refresh_BusyState(const aLogGroupGUID: string);
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
  public
    bAboutWindowExist: Boolean;
    bStartingNormalShutdown: Boolean;
    Configuration: TConfigurationRec;
    procedure ShowErrorBox(const aHandle: HWND; const aErrorMessage: string; const aLogGroupGUID: string);
    procedure Do_Connect;
    procedure LogThis(const aMessage, aLogGroupGIUD: string; const aMessageType: TLogMessagesType);
    procedure Update_ConnectionAction;
    procedure Inc_BusyState(const aLogGroupGUID: string);
    procedure Dec_BusyState(const aLogGroupGUID: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  LogKeeper.uAboutForm,
  LogKeeper.uConfigurationForm,
  LogKeeper.uFindGIUDForm,
  CastersPackage.uMysql,
  System.AnsiStrings,
  ShellAPI,
  IniFiles,
  LogKeeper.uSendDataToMySQLServer,
  LogKeeper.uRoutines;

var
  Recipients: DWORD = BSM_APPLICATIONS;

  { Отлаженные процедуры }

procedure TMainForm.Action_FindSpecifiedGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string = '{51F0AA87-B7E2-4968-8136-466AE002FC93}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_FindSpecifiedGUID.Caption + '"', LogGroupGUID);
  Do_FindSpecifiedGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ShowErrorBox(const aHandle: HWND; const aErrorMessage: string; const aLogGroupGUID: string);
var
  iOldBusyCounter: Integer;
begin
  LogThis(aErrorMessage, aLogGroupGUID, lmtError);

  iOldBusyCounter := iBusyCounter;
  // сохранение значения счётчика действий, требующих состояния "занято"
  iBusyCounter := 0; // обнуление счётчика перед открытием модального окна
  Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора

  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar('LogKeeper - Ошибка!'), MB_OK + MB_ICONERROR + MB_DEFBUTTON1);
  Application.ProcessMessages;

  iBusyCounter := iOldBusyCounter; // возвращение старого значения счётчика
  Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
  Application.ProcessMessages;
end;

procedure TMainForm.PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: Integer);
begin
  LogThis('Производится попытка отображения модального окна ' + aWindowName + '.', aLogGroupGUID, lmtDebug);
  with MainForm do
  begin
    aOldBusyState := iBusyCounter;
    // сохранение значения счётчика действий, требующих состояния "занято"
    iBusyCounter := 0; // обнуление счётчика перед открытием модального окна
    Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
  end;
end;

procedure TMainForm.PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: Integer);
begin
  with MainForm do
  begin
    iBusyCounter := aOldBusyState; // возвращение старого значения счётчика
    Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
  end;
  LogThis('Окно ' + aWindowName + ' скрыто.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('[' + aTitle + ']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TMainForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
const
  LogGroupGUID: string = '{4A3B82FD-ED8E-4ABC-A6C6-C9E600BD1B33}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_Configuration.Caption + '"', LogGroupGUID);
  Do_Configuration;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopyGUIDStringToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string = '{6871D088-2BEB-4BE4-B14E-29B83117B378}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_CopyGUIDStringToClipboard.Caption + '"', LogGroupGUID);
  Do_CopyGUIDStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
const
  LogGroupGUID: string = '{2B63A7EF-38C1-4035-BEBD-838E86C11146}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_About.Caption + '"', LogGroupGUID);
  Do_About;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopySQLFromMsgToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string = '{5CED9045-D491-481A-B80A-E40216AB39EF}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_CopySQLFromMsgToClipboard.Caption + '"', LogGroupGUID);
  Do_CopySQLFromMsgToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopyLogStringToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string = '{A1D1D539-1E62-4D10-A05E-FCB1C66DF595}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_CopyLogStringToClipboard.Caption + '"', LogGroupGUID);
  Do_CopyLogStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopyMsgStringToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string = '{74B6478F-7FB3-44AF-AB9B-75081A655BE1}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_CopyMsgStringToClipboard.Caption + '"', LogGroupGUID);
  Do_CopyMsgStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ClearLogListExecute(Sender: TObject);
const
  LogGroupGUID: string = '{FFFB71DB-6D94-4081-BDAE-A682A53B3EB2}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_ClearLogList.Caption + '"', LogGroupGUID);
  Do_ClearLogList;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ConnectExecute(Sender: TObject);
const
  LogGroupGUID: string = '{098B8251-3B86-4848-947A-1B5CAEC07323}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_Connect.Caption + '"', LogGroupGUID);
  Do_Connect;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_DisconnectExecute(Sender: TObject);
const
  LogGroupGUID: string = '{0A134B4E-48D3-4CF0-BE39-5C1AA6A80E00}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_Disconnect.Caption + '"', LogGroupGUID);
  Do_Disconnect;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopySQLFromLogToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string = '{C96DE03B-56B7-4947-B2EC-51486C4801DD}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_CopySQLFromLogToClipboard.Caption + '"', LogGroupGUID);
  Do_CopySQLFromLogToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ClearMsgListExecute(Sender: TObject);
const
  LogGroupGUID: string = '{83D14757-BCCE-48CD-862A-91F83DEAA85F}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_ClearMsgList.Caption + '"', LogGroupGUID);
  Do_ClearMsgList;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string = '{A51A51FA-F9F4-4964-8E14-6186C77FE244}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_Help.Caption + '"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RestoreExecute(Sender: TObject);
const
  LogGroupGUID: string = '{BEBD392D-B923-4341-BCB6-821191362237}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_Restore.Caption + '"', LogGroupGUID);
  Do_RestoreMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RestoreLogPanelExecute(Sender: TObject);
const
  LogGroupGUID: string = '{40FA8E73-EEF7-44DC-93C2-CC3CC0BCEB78}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_RestoreLogPanel.Caption + '"', LogGroupGUID);
  Do_RestoreLogPanel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_MaximizeLogPanelExecute(Sender: TObject);
const
  LogGroupGUID: string = '{191EC332-8ECF-46D1-BD76-C992CA2EB530}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_MaximizeLogPanel.Caption + '"', LogGroupGUID);
  Do_MaximizeLogPanel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyGUIDStringToClipboard;
const
  LogGroupGUID: string = '{9EAA7AEB-8077-45E7-BCBC-2943C92A7DC9}';
begin
  ProcedureHeader('Процедура копирования GUID выделенного элемента списка протокола в буфер обмена', LogGroupGUID);

  with lvLog do
    if Selected <> nil then
      with Selected do
        if SubItems.Count = 4 then
          Routines_CopyStringToClipboard(Trim(SubItems[0]));

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_ClearLogList;
const
  LogGroupGUID: string = '{38F36760-1536-47B3-8EB9-89BE61599232}';
var
  iCount: Integer;
begin
  ProcedureHeader('Процедура очистки списка сообщений протокола', LogGroupGUID);

  if Configuration.bFlushLogOnClearingLog then
    Do_FlushLogToFile
  else
    with lvLog.Items do
      if Count > 0 then
      begin
        iCount := Count;
        BeginUpdate;
        Clear;
        EndUpdate;
        LogThis('Выполнена очистка протокола работы программы. Количество удалённых строк: ' + IntToStr(iCount) + '.',
          LogGroupGUID, lmtInfo);
      end
      else
        LogThis('Протокол работы программы пуст, очистка не требуется.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyLogStringToClipboard;
const
  LogGroupGUID: string = '{00BE0E1B-28FB-40BC-BFB9-2BE760F3254C}';
var
  s: string;
begin
  ProcedureHeader('Процедура копирования текста выделенного элемента списка протокола в буфер обмена', LogGroupGUID);

  with lvLog do
    if (Items.Count > 0) and (Selected <> nil) then
      with Selected do
      begin
        case ImageIndex of
          ICON_ERROR:
            s := 'ERROR';
          ICON_WARNING:
            s := 'WARNING';
          ICON_INFO:
            s := 'INFO';
          ICON_SQL:
            s := 'SQL';
        end;
        Routines_CopyStringToClipboard(s + #09 + Caption + #09 + SubItems[0] + #09 + SubItems[1] + #09 + SubItems[2] +
          #09 + SubItems[3]);
      end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyMsgStringToClipboard;
const
  LogGroupGUID: string = '{B3EB6C9B-BF98-4D9F-808C-4AC146531E7A}';
begin
  ProcedureHeader('Процедура копирования текста выделенного элемента списка полученных сообщений в буфер обмена',
    LogGroupGUID);

  with ListBox1 do
    if (Count > 0) and (ItemIndex >= 0) then
      Routines_CopyStringToClipboard(Items[ItemIndex]);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopySQLFromLogToClipboard;
const
  LogGroupGUID: string = '{27F2860B-7873-403B-B2E2-09A4E635FF2A}';
begin
  ProcedureHeader
    ('Процедура копирования текста SQL-запроса выделенного элемента списка сообщений протокола в буфер обмена',
    LogGroupGUID);

  with lvLog do
    if Selected <> nil then
      with Selected do
        if ImageIndex = ICON_SQL then
          if SubItems.Count = 4 then
            Routines_CopyStringToClipboard(Trim(SubItems[3]));

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_MinimizeMainForm;
const
  LogGroupGUID: string = '{47111023-48A7-47FC-903F-1D23D28CD03F}';
begin
  ProcedureHeader('Процедура сворачивания главного окна в трей', LogGroupGUID);

  MainForm.Visible := False;
  TrayIcon1.Visible := True;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Help;
const
  LogGroupGUID: string = '{DA5BFDBC-CA0D-4031-BCCB-84727CD271E8}';
var
  bError: Boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура открытия справочного файла программы', LogGroupGUID);

  LogThis('Производится попытка открытия справочного файла программы...', LogGroupGUID, lmtInfo);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    Routines_GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_RestoreLogPanel;
const
  LogGroupGUID: string = '{421471AF-24CD-4F33-9BCD-1716CA35A228}';
begin
  ProcedureHeader('Процедура восстановления исходных размеров панели протокола', LogGroupGUID);

  pnlLog.Align := alBottom;
  pnlLog.Height := 87;
  ListBox1.Visible := not(pnlLog.Align = alClient);
  Action_RestoreLogPanel.Enabled := False;
  Action_MaximizeLogPanel.Enabled := True;
  btnRestoreLogPanel.Enabled := False;
  btnMaximazeLogPanel.Enabled := True;
  LogThis('Были возвращены нормальные размеры панели протокола работы программы.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_MaximizeLogPanel;
const
  LogGroupGUID: string = '{2A9FE7CB-1477-4762-9B44-97D38B4828D4}';
begin
  ProcedureHeader('Процедура разворачивания панели протокола во всё окно', LogGroupGUID);

  pnlLog.Align := alClient;
  ListBox1.Visible := not(pnlLog.Align = alClient);
  Action_MaximizeLogPanel.Enabled := False;
  Action_RestoreLogPanel.Enabled := True;
  btnMaximazeLogPanel.Enabled := False;
  btnRestoreLogPanel.Enabled := True;
  LogThis('Панель протокола работы программы была развёрнута на всё окно.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_RestoreMainForm;
const
  LogGroupGUID: string = '{CD7AB392-2C99-4D7D-953A-8E1D87B3ABE0}';
var
  fwi: FLASHWINFO;
begin
  ProcedureHeader('Процедура разворачивания главного окна из трея', LogGroupGUID);

  if bAboutWindowExist then
  begin
    with fwi do
    begin
      cbSize := sizeof(FLASHWINFO);
      HWND := Application.Handle;
      dwFlags := FLASHW_TRAY or FLASHW_TIMERNOFG;
      uCount := 0;
      dwTimeout := 0;
    end;
    FlashWindowEx(fwi);
  end
  else
  begin
    TrayIcon1.Visible := Configuration.bAlwaysShowTrayIcon;
    MainForm.Visible := True;
    SetForegroundWindow(MainForm.Handle);
    Application.Restore;
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.miStatusbarClick(Sender: TObject);
const
  LogGroupGUID: string = '{DE96EF0B-E61C-4BCA-AFEB-506C2A601E95}';
begin
  ProcedureHeader('Процедура включения/отключения отображения панели статуса', LogGroupGUID);

  StatusBar1.Visible := miStatusbar.Checked;
  Configuration.bNoStatusBar := not StatusBar1.Visible;
  LogThis('Панель статуса ' + Routines_GetConditionalMessage(StatusBar1.Visible, 'в', 'от') + 'ключена.',
    LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ApplicationEvents1Minimize(Sender: TObject);
const
  LogGroupGUID: string = '{7BC630DC-36DE-41C6-9456-653FFDCBF218}';
begin
  ProcedureHeader('Процедура реакции на попытку минимизации главного окна', LogGroupGUID);
  Do_MinimizeMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TrayIcon1Click(Sender: TObject);
const
  LogGroupGUID: string = '{98C16554-C533-4ACF-AB8A-0211CC0CDDD0}';
begin
  ProcedureHeader('Процедура-обработчик щелчка на иконке в трее', LogGroupGUID);

  if MainForm.Visible then
    SetForegroundWindow(MainForm.Handle);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TrayIcon1DblClick(Sender: TObject);
const
  LogGroupGUID: string = '{007A7EE9-D2F8-4680-A937-908EF3F9E880}';
begin
  ProcedureHeader('Процедура-обработчик двойноного щелчка на иконке в трее', LogGroupGUID);
  Do_RestoreMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindNextWithSuchGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string = '{0ECA0D5F-75C0-475C-B8E5-F2729BEF3BF5}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_FindNextWithSuchGUID.Caption + '"', LogGroupGUID);
  Do_FindNextWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindPreviousWithSuchGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string = '{2E15574E-CC14-4B96-88FC-B9DEF3D1168F}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_FindPreviousWithSuchGUID.Caption + '"', LogGroupGUID);
  Do_FindPreviousWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.lvLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  LogGroupGUID: string = '{0D23E095-7D8F-4144-9727-1CA679901494}';
begin
  ProcedureHeader('Процедура-обработчик нажатия клавиши в списке протокола', LogGroupGUID);
  if Key = VK_F2 then
    Do_FindPreviousWithSuchGUID;
  if Key = VK_F3 then
    Do_FindNextWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_FlushLogToFile;
const
  LogGroupGUID: string = '{E40F2A33-FEE8-4D0A-8A0F-C5FB265BE184}';
var
  s: string;
  sl: TStringList;
begin
  ProcedureHeader('Процедура выгрузки всех текущих строк протокола работы программы в текстовый файл', LogGroupGUID);

  sl := TStringList.Create;
  try
    while lvLog.Items.Count > 0 do
    begin
      if lvLog.Items[0] <> nil then
        if lvLog.Items[0].SubItems.Count = 4 then
          sl.Append(lvLog.Items[0].Caption + #09 + lvLog.Items[0].SubItems[0] + #09 + lvLog.Items[0].SubItems[1] + #09 +
            lvLog.Items[0].SubItems[2] + #09 + lvLog.Items[0].SubItems[3]);
      lvLog.Items[0].Delete;
    end;
    s := FormatDateTime('yyyymmdd_hhnnss', Now);
    if sl.Count > 0 then
      try
        sl.SaveToFile(ExtractFilePath(ExpandFileName(Application.ExeName)) + 'LogKeeper_' + s + '.log');
      except
        on EStringListError do
          ShowErrorBox(Handle, 'Возникла ошибка при потытке сохранения протокола в файле "' + s +
            '"! Обратитесь к администратору!', LogGroupGUID);
      end;
  finally
    sl.Free;
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_FindSpecifiedGUID;
const
  LogGroupGUID: string = '{BAD3DC04-5E81-4735-B9AC-17C85A8C1ED7}';
  sModalWinName: string = 'поиска GUID';
var
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + sModalWinName, LogGroupGUID);

  with TFindGUIDForm.Create(Self) do
    try
      ImageList1.GetIcon(ICON_FINDGUID, Icon);
      PreShowModal(sModalWinName, LogGroupGUID, iBusy);
      ShowModal;
    finally
      PostShowModal(sModalWinName, LogGroupGUID, iBusy);
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Inc_BusyState(const aLogGroupGUID: string);
begin
  with MainForm do
  begin
    iBusyCounter := iBusyCounter + 1;
    if iBusyCounter < 0 then
      iBusyCounter := 0;
    Refresh_BusyState(aLogGroupGUID);
  end;
end;

procedure TMainForm.Dec_BusyState(const aLogGroupGUID: string);
begin
  with MainForm do
  begin
    iBusyCounter := iBusyCounter - 1;
    if iBusyCounter < 0 then
      iBusyCounter := 0;
    Refresh_BusyState(aLogGroupGUID);
  end;
end;

procedure TMainForm.Refresh_BusyState(const aLogGroupGUID: string);
begin
  LogThis('Установлен режим "' + Routines_GetConditionalMessage(iBusyCounter > 0, 'Занято', 'Готово') + '".',
    aLogGroupGUID, lmtDebug);
  with MainForm do
  begin
    if iBusyCounter > 0 then
    begin
      ImageList1.GetIcon(ICON_BUSY, Image1.Picture.Icon);
      // Screen.Cursor:=crHourGlass;
    end
    else
    begin
      ImageList1.GetIcon(ICON_READY, Image1.Picture.Icon);
      // Screen.Cursor:=crDefault;
    end;
    if not Configuration.bNoStatusBar then
      StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text := Routines_GetConditionalMessage(iBusyCounter > 0,
        'Пожалуйста, подождите...', 'Готово');
  end;
  Application.ProcessMessages;
end;

procedure TMainForm.LogThis(const aMessage, aLogGroupGIUD: string; const aMessageType: TLogMessagesType);
var
  i: Integer;
  ListItem: TListItem;
begin
  if (((Configuration.bKeepErrorLog) and (aMessageType = lmtError)) or ((Configuration.bKeepWarningLog) and
    (aMessageType = lmtWarning)) or ((Configuration.bKeepInfoLog) and (aMessageType = lmtInfo)) or
    ((Configuration.bKeepSQLLog) and (aMessageType = lmtSQL)) or ((Configuration.bKeepDebugLog) and
    (aMessageType = lmtDebug))) then
  begin
    i := -1;
    SessionLogEventCount := SessionLogEventCount + 1;
    case aMessageType of
      lmtError:
        i := ICON_ERROR;
      lmtWarning:
        i := ICON_WARNING;
      lmtInfo:
        i := ICON_INFO;
      lmtSQL:
        i := ICON_SQL;
      lmtDebug:
        i := ICON_DEBUG;
    end;
    ListItem := lvLog.Items.Add;
    ListItem.ImageIndex := i; // тип сообщения
    ListItem.Caption := FormatDateTime('dd.mm.yyyy hh:nn:ss', Now);
    // дата и время сообщения
    ListItem.SubItems.Add(aLogGroupGIUD);
    ListItem.SubItems.Add(StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll]));
    // порядковый номер сообщения
    ListItem.SubItems.Add(string(Configuration.LogServer.sMySQLUser));
    // текущий залогированный пользователь
    ListItem.SubItems.Add(aMessage); // текст сообщения
    if (Configuration.iFlushLogOnStringsQuantity > 0) and (lvLog.Items.Count = Configuration.iFlushLogOnStringsQuantity)
    then
      Do_FlushLogToFile;
    if Configuration.bScrollToLastLogMessage then
      SendMessage(lvLog.Handle, LVM_ENSUREVISIBLE, lvLog.Items.Count - 1, 0);
    Update_QuantityOfLogStrings;
  end;
end;

procedure TMainForm.Do_Close;
const
  LogGroupGUID: string = '{7F91E383-797D-42DE-8742-826D4F358C65}';
begin
  ProcedureHeader('Процедура инициации завершения работы программы', LogGroupGUID);
  Close;
  LogThis('Выполняется попытка завершения работы программы...', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
const
  LogGroupGUID: string = '{9E0753A5-7E5A-40E4-8EC9-45EF6282D941}';
begin
  ProcedureHeader('Процедура-обработчик действия "' + Action_Quit.Caption + '"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_About;
const
  LogGroupGUID: string = '{68AFEB74-4DA9-41D9-9398-2955A89084D3}';
  sModalWinName: string = '"О программе..."';
var
  AboutForm: TAboutForm;
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + sModalWinName, LogGroupGUID);

  if bAboutWindowExist then
    SetForegroundWindow(FindWindow('TAboutForm', 'About "LogKeeper"...'))
  else
  begin
    AboutForm := TAboutForm.Create(Self);
    with AboutForm do
      try
        bAboutWindowExist := True;
        Action_Close.Visible := True;
        PreShowModal(sModalWinName, LogGroupGUID, iBusy);
        ShowModal;
      finally
        PostShowModal(sModalWinName, LogGroupGUID, iBusy);
        Free;
        bAboutWindowExist := False;
      end;
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Connect;
const
  LogGroupGUID: string = '{1BCA8A3E-8671-438D-98DB-D94194F6AF05}';
var
  sErrorMessage: string;
  bError: Boolean;
begin
  ProcedureHeader('Процедура подключения программы к MySQL-серверу', LogGroupGUID);
  bError := False;

  with Configuration, LogServer do
  begin
    LogThis('>> Выполняется операция подключения к MySQL-серверу ' + sMySQLHost + '...', LogGroupGUID, lmtInfo);
    if bConnected then
      Routines_GenerateError('Была предпринята попытка подключения к подключенному в настоящий момент MySQL-серверу!',
        sErrorMessage, bError)
    else
    begin
      hConnection := mysql_init(nil);
      if hConnection = nil then
        Routines_GenerateError('Возникла ошибка при инициализации объекта соединения с сервером MySQL!',
          sErrorMessage, bError)
      else
      begin
        LogThis('Инициализация объекта соединения с сервером MySQL выполнена успешно.', LogGroupGUID, lmtDebug);
        bConnected := mysql_real_connect(hConnection, PAnsiChar(AnsiString(sMySQLHost)), PAnsiChar(sMySQLUser),
          PAnsiChar(sMySQLPassword), PAnsiChar(AnsiString(sMySQLDatabase)), iMySQLPort, nil,
          Integer(bMySQLCompress) * CLIENT_COMPRESS) <> nil;
        if not bConnected then
          Routines_GenerateError('Возникла ошибка при попытке подключения к MySQL-серверу ' + sMySQLHost + '!' +
            Routines_GetMySQLErrorInfo(LogServer), sErrorMessage, bError)
        else
          LogThis('Подключение к MySQL-серверу ' + sMySQLHost + ' выполнено успешно.', LogGroupGUID, lmtInfo);
      end;
    end;
    LogThis('<< Выполнение операции подключения к MySQL-серверу ' + sMySQLHost + ' завершено.', LogGroupGUID, lmtDebug);
  end;

  Update_ConnectionAction;

  if bError then
    LogThis(sErrorMessage, LogGroupGUID, lmtError)
  else
  begin
    LogThis('Процедура выполнена без ошибок.', LogGroupGUID, lmtDebug);
    ApplicationEvents1.OnIdle := ApplicationEvents1Idle;
    // начало работы обработчика отправки сообщений на сервер
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Disconnect;
const
  LogGroupGUID: string = '{B0306D16-AF57-4B6C-AA33-00784E46BFC7}';
begin
  ProcedureHeader('Процедура отключения программы от MySQL-сервера', LogGroupGUID);

  with Configuration.LogServer do
  begin
    if bConnected then
    begin
      LogThis('>> Выполняется операция отключения от MySQL-сервера ' + sMySQLHost + '...', LogGroupGUID, lmtDebug);
      if hConnection <> nil then
      begin
        LogThis('"Экземпляр подключения к MySQL-серверу не пуст. Производится отключение.', LogGroupGUID, lmtDebug);
        mysql_close(hConnection);
        hConnection := nil;
      end
      else
        LogThis('"Экземпляр подключения к MySQL-серверу пуст. Отключение не требуется.', LogGroupGUID, lmtDebug);
      bConnected := False;
      LogThis('Отключение от MySQL-сервера ' + sMySQLHost + ' выполнено успешно.', LogGroupGUID, lmtInfo);
      LogThis('<< Выполнение операции отключения от MySQL-сервера ' + sMySQLHost + ' завершено.', LogGroupGUID,
        lmtDebug);
    end;
  end;

  ApplicationEvents1.OnIdle := nil;
  Update_ConnectionAction;

  ProcedureFooter(LogGroupGUID);
end;

{ Неотлаженные процедуры }

procedure TMainForm.Do_CopySQLFromMsgToClipboard;
const
  LogGroupGUID: string = '{CD23B041-44F4-4375-9738-A4A4DBEBAD07}';
var
  sl: TStringList;
begin
  ProcedureHeader
    ('Процедура копирования текста SQL-запроса выделенного элемента списка полученных сообщений в буфер обмена',
    LogGroupGUID);

  with ListBox1 do
    if (Count > 0) and (ItemIndex >= 0) then
    begin
      sl := TStringList.Create;
      try
        Routines_CutStringByLimiterToStringList(Items[ItemIndex], sl, #09);
        if Trim(sl[0]) = 'SQL' then
          if sl.Count = 7 then
            Routines_CopyStringToClipboard(Trim(sl[6]));
      finally
        sl.Free;
      end;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_ClearMsgList;
const
  LogGroupGUID: string = '{38F36760-1536-47B3-8EB9-89BE61599232}';
begin
  ProcedureHeader('Процедура очистки списка полученных сообщений', LogGroupGUID);

  with ListBox1 do
    if Count > 0 then
      with Items do
      begin
        BeginUpdate;
        Clear;
        EndUpdate;
      end;
  Update_QuantityOfMessagesStrings;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_FindNextWithSuchGUID;
const
  LogGroupGUID: string = '{218867D7-6A06-4C16-BA00-4F78EA3E0141}';
var
  s: string;
  i, j: Integer;
  b: Boolean;
  aCursor: TCursor;
begin
  // ProcedureHeader('Процедура перехода к следующей строке протокола с таким же GUID',LogGroupGUID,False,False);
  b := False;
  j := -1;
  if (lvLog.Items.Count > 0) and (lvLog.Selected <> nil) then
  begin
    if lvLog.Selected.SubItems.Count >= 1 then
    begin
      s := lvLog.Selected.SubItems[0];
      // получение GUID выделенного элемента списка
      // LogThis(PChar('Искомая строка GUID: '+s+'.'),LogGroupGUID,lmtInfo);
      with lvLog do // переход к следующей строке списка протокола с равным GUID
      begin
        for i := Selected.index + 1 to Items.Count - 1 do
          if not b then
            if Items[i] <> nil then
              if Items[i].SubItems.Count >= 1 then
                if Items[i].SubItems[0] = s then
                begin
                  b := True;
                  j := i;
                end;
        if b and (j > -1) then
        begin
          Items[j].Selected := True;
          Items[j].Focused := True;
          Selected.MakeVisible(False);
        end
        else
        begin
          aCursor := Screen.Cursor;
          Screen.Cursor := crDefault;
          MessageBox(Handle, PChar('Строк с GUID ' + s + ' ниже указанной в списке протокола более не найдено!'),
            PChar('LogKeeper - Внимание!'), MB_OK + MB_ICONWARNING + MB_DEFBUTTON1);
          Application.ProcessMessages;
          Screen.Cursor := aCursor;
        end;
      end;
    end;
    // else LogThis(PChar('Переход не выполнен, так как не была найдена строка GUID ниже по списку!'),LogGroupGUID,lmtError);
  end;
  // else LogThis(PChar('Переход не выполнялся, так как не бало выделено ни одной строки списка!'),LogGroupGUID,lmtWarning);
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.Do_FindPreviousWithSuchGUID;
const
  LogGroupGUID: string = '{EF163619-7AE2-4D73-9DA4-C07ABAFA8303}';
var
  s: string;
  i, j: Integer;
  b: Boolean;
  aCursor: TCursor;
begin
  // ProcedureHeader('Процедура перехода к предыдущей строке протокола с таким же GUID',LogGroupGUID,False,False);
  b := False;
  j := -1;
  if (lvLog.Items.Count > 0) and (lvLog.Selected <> nil) then
  begin
    if lvLog.Selected.SubItems.Count >= 1 then
    begin
      s := lvLog.Selected.SubItems[0];
      // получение GUID выделенного элемента списка
      // LogThis(PChar('Искомая строка GUID: '+s+'.'),LogGroupGUID,lmtInfo);
      with lvLog do
      // переход к предыдущей строке списка протокола с равным GUID
      begin
        for i := Selected.index - 1 downto 0 do
          if not b then
            if Items[i] <> nil then
              if Items[i].SubItems.Count >= 1 then
                if Items[i].SubItems[0] = s then
                begin
                  b := True;
                  j := i;
                end;
        if b and (j > -1) then
        begin
          Items[j].Selected := True;
          Items[j].Focused := True;
          Selected.MakeVisible(False);
        end
        else
        begin
          aCursor := Screen.Cursor;
          Screen.Cursor := crDefault;
          MessageBox(Handle, PChar('Строк с GUID ' + s + ' выше указанной в списке протокола более не найдено!'),
            PChar('LogKeeper - Внимание!'), MB_OK + MB_ICONWARNING + MB_DEFBUTTON1);
          Application.ProcessMessages;
          Screen.Cursor := aCursor;
        end;
      end;
    end;
    // else LogThis(PChar('Переход не выполнен, так как не была найдена строка GUID выше по списку!'),LogGroupGUID,lmtError);
  end;
  // else LogThis(PChar('Переход не выполнялся, так как не бало выделено ни одной строки списка!'),LogGroupGUID,lmtWarning);
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.Do_TransferMessageToDB;
const
  LogGroupGUID: string = '{2F0657F6-BE9D-4851-9877-0A89F4947D32}';
var
  bError: Boolean;
  q: string;
  sMessage, sErrorMessage: string;
  i: Integer;
  sl: TStringList;
  dt: TDateTime;
begin
  ProcedureHeader('Процедура переноса полученных сообщений на MySQL-сервер', LogGroupGUID);
  bError := False;

  if ListBox1.Items.Count > 0 then
  begin
    // парсирование строки данных из листбокса
    sMessage := ListBox1.Items[0];
    ListBox1.Items.Delete(0);
    Application.ProcessMessages;

    sl := TStringList.Create;
    try
      sl.Duplicates := dupAccept;
      sl.Sorted := False;
      Routines_CutStringByLimiterToStringList(sMessage, sl, #09);
      // валидация элементов построенного списка
      if not bError then
        if not((sl[2] = 'ERROR  ') or (sl[2] = 'WARNING') or (sl[2] = 'INFO   ') or (sl[2] = 'SQL    ')) then
          Routines_GenerateError('Тип сообщения [' + sl[2] + '] не соответствует допустимому!', sErrorMessage, bError);
      if not bError then
      begin
        dt := EncodeDate(1900, 01, 01);
        if StrToDateDef(sl[3], dt) = dt then
          Routines_GenerateError('Дата сообщения [' + sl[3] + '] не соответствует допустимому!', sErrorMessage, bError);
      end;
      if not bError then
      begin
        dt := EncodeTime(1, 2, 3, 4);
        if StrToTimeDef(sl[4], dt) = dt then
          Routines_GenerateError('Время сообщения [' + sl[4] + '] не соответствует допустимому!',
            sErrorMessage, bError);
      end;
      if not bError then
        if Length(sl[5]) <> 38 then
          Routines_GenerateError('GUID группы сообщения [' + sl[5] + '] не соответствует допустимому!',
            sErrorMessage, bError);
      if not bError then
        if StrToIntDef(sl[6], -1) = -1 then
          Routines_GenerateError('Индекс сообщения [' + sl[6] + '] не соответствует допустимому!',
            sErrorMessage, bError);
      if not bError then
      begin
        q := 'INSERT INTO ' + string(Configuration.LogServer.sMySQLDatabase) + '._log ' +
          '(log_host, log_application, log_user, log_type, log_date, log_time, log_group_guid, log_index, log_details) VALUES ('
          + '"' + Configuration.sLocalHost + '", ' + Routines_NormalizeStringForQuery(Trim(sl[0]), True, False) + ', ' +
          Routines_NormalizeStringForQuery(Trim(sl[1]), True, False) + ', ' + Routines_NormalizeStringForQuery(sl[2],
          True, False) + ', ' + Routines_NormalizeStringForQuery(FormatDateTime('yyyy-mm-dd', StrToDate(sl[3])), True,
          False) + ', ' + Routines_NormalizeStringForQuery(sl[4], True, False) + ', ' +
          Routines_NormalizeStringForQuery(sl[5], True, False) + ', ' + Routines_NormalizeStringForQuery(sl[6], False,
          False) + ', ' + Routines_NormalizeStringForQuery(sl[7], True, False) + ');';
      end;
    except
      Routines_GenerateError('Возникла ошибка в процессе преобразования строки данных!', sErrorMessage, bError);
    end;
    if not bError then
    begin
      LogThis(q, LogGroupGUID, lmtSQL);
      i := mysql_real_query(Configuration.LogServer.hConnection, PAnsiChar(AnsiString(q)), Length(q));
      if i = 0 then
      begin
        LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtInfo);
        i := mysql_affected_rows(Configuration.LogServer.hConnection);
        if i = 1 then
        begin
          LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtInfo);
          LogThis('Строка данных лога успешно сохранёна в таблице БД.', LogGroupGUID, lmtInfo);
        end
        else
          Routines_GenerateError('Количество обработанных строк (' + IntToStr(i) + ') не соответствует требуемому (1)!',
            sErrorMessage, bError);
      end
      else
        Routines_GenerateError('Возникла ошибка при выполнении запроса!', sErrorMessage, bError);
    end;
    if bError then
    begin
      ListBox1.Items.Append(sMessage);
      // восстановление незаписаной строки в конец списка
      LogThis(sErrorMessage, LogGroupGUID, lmtError);
      Application.ProcessMessages;
      // отключение в случае ошибки при выполнении запроса и повторная попытка подключения
      Do_Disconnect;
      Timer2Timer(nil);
    end
    else
      LogThis('Процедура выполнена без ошибок.', LogGroupGUID, lmtInfo);
    Update_QuantityOfMessagesStrings;
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Configuration;
const
  LogGroupGUID: string = '{8B1B9E56-2345-4401-B4C2-5156EC4DE468}';
  sModalWinName: string = 'настроек программы';
var
  iBusy: Integer;
begin
  ProcedureHeader('Процедура отображения окна ' + sModalWinName, LogGroupGUID);

  with TConfigurationForm.Create(Self) do
    try
      ImageList1.GetIcon(ICON_CONFIGURATION, Icon);
      // секция "Сервер и база данных"
      edbxMySQLHost.Text := WideString(Configuration.LogServer.sMySQLHost);
      edbxMySQLHost.Enabled := not Configuration.LogServer.bConnected;
      edbxMySQLPort.Text := IntToStr(Configuration.LogServer.iMySQLPort);
      edbxMySQLPort.Enabled := not Configuration.LogServer.bConnected;
      edbxMySQLTimeout.Text := IntToStr(Configuration.LogServer.iMySQLTimeout);
      edbxMySQLTimeout.Enabled := not Configuration.LogServer.bConnected;
      chkbxMySQLCompress.Checked := Configuration.LogServer.bMySQLCompress;
      chkbxMySQLCompress.Enabled := not Configuration.LogServer.bConnected;
      edbxMySQLDatabase.Text := WideString(Configuration.LogServer.sMySQLDatabase);
      edbxMySQLDatabase.Enabled := not Configuration.LogServer.bConnected;
      edbxMySQLUser.Text := WideString(Configuration.LogServer.sMySQLUser);
      edbxMySQLUser.Enabled := not Configuration.LogServer.bConnected;
      edbxMySQLPassword.Text := WideString(Configuration.LogServer.sMySQLPassword);
      edbxMySQLPassword.Enabled := not Configuration.LogServer.bConnected;
      // секция "Интерфейс"
      chkbxAlwaysShowTrayIcon.Checked := Configuration.bAlwaysShowTrayIcon;
      chkbxCustomHelpFile.Checked := Configuration.sCustomHelpFile <> '';
      edbxCustomHelpFile.Text := Configuration.sCustomHelpFile;
      edbxCustomHelpFile.Enabled := chkbxCustomHelpFile.Checked;
      btnChoiseCustomHelpFile.Enabled := chkbxCustomHelpFile.Checked;
      Configuration.bFullScreen := MainForm.WindowState = wsMaximized;
      chkbxFullScreen.Checked := Configuration.bFullScreen;
      cbMainFormAlignment.ItemIndex := Integer(Configuration.bBottomMainFormAlignment);
      edbxMainFormHeight.Enabled := not chkbxFullScreen.Checked;
      edbxMainFormHeight.Text := Routines_GetConditionalMessage(edbxMainFormHeight.Enabled,
        IntToStr(Configuration.iMainFormHeight), '');
      // секция "Протоколирование"
      chkbxKeepErrorLog.Checked := Configuration.bKeepErrorLog;
      chkbxKeepWarningLog.Checked := Configuration.bKeepWarningLog;
      chkbxKeepInfoLog.Checked := Configuration.bKeepInfoLog;
      chkbxKeepSQLLog.Checked := Configuration.bKeepSQLLog;
      chkbxFlushLogOnExit.Checked := Configuration.bFlushLogOnExit;
      chkbxFlushLogOnStringsQuantity.Checked := Configuration.iFlushLogOnStringsQuantity > 0;
      edbxFlushLogOnStringsQuantity.Enabled := chkbxFlushLogOnStringsQuantity.Checked;
      edbxFlushLogOnStringsQuantity.Text := Routines_GetConditionalMessage(chkbxFlushLogOnStringsQuantity.Checked,
        IntToStr(Configuration.iFlushLogOnStringsQuantity), '');
      chkbxFlushLogOnClearingLog.Checked := Configuration.bFlushLogOnClearingLog;
      chkbxFlushLogOnApply.Checked := False;

      PreShowModal(sModalWinName, LogGroupGUID, iBusy);
      ShowModal;
    finally
      PostShowModal(sModalWinName, LogGroupGUID, iBusy);
      if ModalResult = mrOk then
      begin
        LogThis('Была предпринята попытка применения настроек программы.', LogGroupGUID, lmtInfo);
        // секция "Сервер и база данных"
        if not Configuration.LogServer.bConnected then
        begin
          Configuration.LogServer.sMySQLHost := edbxMySQLHost.Text;
          Configuration.LogServer.iMySQLPort := StrToIntDef(edbxMySQLPort.Text, 3306);
          Configuration.LogServer.iMySQLTimeout := StrToIntDef(edbxMySQLTimeout.Text, 30);
          Configuration.LogServer.bMySQLCompress := chkbxMySQLCompress.Checked;
          Configuration.LogServer.sMySQLDatabase := edbxMySQLDatabase.Text;
          Configuration.LogServer.sMySQLUser := AnsiString(edbxMySQLUser.Text);
          Configuration.LogServer.sMySQLPassword := AnsiString(edbxMySQLPassword.Text);
        end;
        // секция "Интерфейс"
        Configuration.bAlwaysShowTrayIcon := chkbxAlwaysShowTrayIcon.Checked;
        TrayIcon1.Visible := Configuration.bAlwaysShowTrayIcon or (not MainForm.Visible);
        Configuration.sCustomHelpFile := Routines_GetConditionalMessage(chkbxCustomHelpFile.Checked and
          FileExists(edbxCustomHelpFile.Text), edbxCustomHelpFile.Text, '');
        Application.HelpFile := Routines_GetConditionalMessage(Configuration.sCustomHelpFile <> '',
          Configuration.sCustomHelpFile, Application.HelpFile);
        Configuration.iMainFormHeight := StrToIntDef(edbxMainFormHeight.Text, 200);
        if Configuration.iMainFormHeight > Screen.WorkAreaHeight then
          Configuration.iMainFormHeight := Screen.WorkAreaHeight;
        if Configuration.iMainFormHeight < 200 then
          Configuration.iMainFormHeight := 200;
        Configuration.bBottomMainFormAlignment := cbMainFormAlignment.ItemIndex = 1;
        Configuration.bFullScreen := chkbxFullScreen.Checked and chkbxFullScreen.Enabled;
        Update_MainFormPosition;
        // секция "Протоколирование"
        Configuration.bKeepErrorLog := chkbxKeepErrorLog.Checked and chkbxKeepErrorLog.Enabled;
        Configuration.bKeepWarningLog := chkbxKeepWarningLog.Checked and chkbxKeepWarningLog.Enabled;
        Configuration.bKeepInfoLog := chkbxKeepInfoLog.Checked and chkbxKeepInfoLog.Enabled;
        Configuration.bKeepSQLLog := chkbxKeepSQLLog.Checked and chkbxKeepSQLLog.Enabled;
        Configuration.bFlushLogOnExit := chkbxFlushLogOnExit.Checked;
        Configuration.bFlushLogOnClearingLog := chkbxFlushLogOnClearingLog.Checked;
        if chkbxFlushLogOnStringsQuantity.Checked and (StrToIntDef(edbxFlushLogOnStringsQuantity.Text, -1) > 0) then
          Configuration.iFlushLogOnStringsQuantity := StrToIntDef(edbxFlushLogOnStringsQuantity.Text, -1)
        else
          Configuration.iFlushLogOnStringsQuantity := -1;
        // флуш лога по нажатию кнопки "применить" (если была включена данная опция)
        if chkbxFlushLogOnApply.Checked then
          Do_FlushLogToFile;
        LogThis('Применение настроек выполнено успешно.', LogGroupGUID, lmtInfo);
      end
      else
        LogThis('Попытки применить настройки не было.', LogGroupGUID, lmtWarning);
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_LoadConfigIni;
const
  LogGroupGUID: string = '{6DA78F21-CF66-4E35-AA7E-8D8AEE98A08F}';
begin
  ProcedureHeader('Процедура загрузки конфигурации программы из файла INI', LogGroupGUID);

  with TIniFile.Create(ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')) do
    try
      // секция "Сервер и база данных"
      Configuration.LogServer.sMySQLHost := ReadString('Сервер и база данных', 'sMySQLHost', '');
      Configuration.LogServer.iMySQLPort := ReadInteger('Сервер и база данных', 'iMySQLPort', MYSQL_PORT);
      Configuration.LogServer.iMySQLTimeout := ReadInteger('Сервер и база данных', 'iMySQLTimeout', 30);
      Configuration.LogServer.bMySQLCompress := ReadBool('Сервер и база данных', 'bMySQLCompress', True);
      Configuration.LogServer.sMySQLDatabase := ReadString('Сервер и база данных', 'sMySQLDatabase', '');
      Configuration.LogServer.sMySQLUser := AnsiString(ReadString('Сервер и база данных', 'sMySQLUser', ''));
      Configuration.LogServer.sMySQLPassword := AnsiString(ReadString('Сервер и база данных', 'sMySQLPassword', ''));
      // секция "Интерфейс"
      Configuration.bAlwaysShowTrayIcon := ReadBool('Интерфейс', 'bAlwaysShowTrayIcon', False);
      Configuration.sCustomHelpFile := ReadString('Интерфейс', 'sCustomHelpFile', '');
      Configuration.iMainFormHeight := ReadInteger('Интерфейс', 'iMainFormHeight', 200);
      Configuration.bFullScreen := ReadBool('Интерфейс', 'bFullScreen', False);
      Configuration.bBottomMainFormAlignment := ReadBool('Интерфейс', 'bBottomMainFormAlignment', True);
      Configuration.bNoStatusBar := ReadBool('Интерфейс', 'bNoStatusBar', False);
      // секция "Протоколирование"
      Configuration.bKeepErrorLog := ReadBool('Протоколирование', 'bKeepErrorLog', True);
      Configuration.bKeepWarningLog := ReadBool('Протоколирование', 'bKeepWarningLog', True);
      Configuration.bKeepInfoLog := ReadBool('Протоколирование', 'bKeepInfoLog', True);
      Configuration.bKeepSQLLog := ReadBool('Протоколирование', 'bKeepSQLLog', True);
      Configuration.bFlushLogOnExit := ReadBool('Протоколирование', 'bFlushLogOnExit', True);
      Configuration.iFlushLogOnStringsQuantity := ReadInteger('Протоколирование', 'iFlushLogOnStringsQuantity', 10000);
      Configuration.bFlushLogOnClearingLog := ReadBool('Протоколирование', 'bFlushLogOnClearingLog', True);

      LogThis('Конфигурация считана успешно.', LogGroupGUID, lmtInfo);
    finally
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_SaveConfigIni;
const
  LogGroupGUID: string = '{1EFB79E2-7C1D-4A66-8DF4-8F7C7C4764C9}';
begin
  ProcedureHeader('Процедура сохранения конфигурации программы в файл INI', LogGroupGUID);

  with TIniFile.Create(ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')) do
    try
      try
        // секция "Сервер и база данных"
        WriteString('Сервер и база данных', 'sMySQLHost', string(Configuration.LogServer.sMySQLHost));
        WriteInteger('Сервер и база данных', 'iMySQLPort', Configuration.LogServer.iMySQLPort);
        WriteInteger('Сервер и база данных', 'iMySQLTimeout', Configuration.LogServer.iMySQLTimeout);
        WriteBool('Сервер и база данных', 'bMySQLCompress', Configuration.LogServer.bMySQLCompress);
        WriteString('Сервер и база данных', 'sMySQLDatabase', string(Configuration.LogServer.sMySQLDatabase));
        WriteString('Сервер и база данных', 'sMySQLUser', string(Configuration.LogServer.sMySQLUser));
        WriteString('Сервер и база данных', 'sMySQLPassword', string(Configuration.LogServer.sMySQLPassword));
        // секция "Интерфейс"
        WriteBool('Интерфейс', 'bAlwaysShowTrayIcon', Configuration.bAlwaysShowTrayIcon);
        WriteString('Интерфейс', 'sCustomHelpFile', Configuration.sCustomHelpFile);
        WriteInteger('Интерфейс', 'iMainFormHeight', Configuration.iMainFormHeight);
        WriteBool('Интерфейс', 'bFullScreen', Configuration.bFullScreen);
        WriteBool('Интерфейс', 'bBottomMainFormAlignment', Configuration.bBottomMainFormAlignment);
        WriteBool('Интерфейс', 'bNoStatusBar', Configuration.bNoStatusBar);
        // секция "Протоколирование"
        WriteBool('Протоколирование', 'bKeepErrorLog', Configuration.bKeepErrorLog);
        WriteBool('Протоколирование', 'bKeepWarningLog', Configuration.bKeepWarningLog);
        WriteBool('Протоколирование', 'bKeepInfoLog', Configuration.bKeepInfoLog);
        WriteBool('Протоколирование', 'bKeepSQLLog', Configuration.bKeepSQLLog);
        WriteBool('Протоколирование', 'bFlushLogOnExit', Configuration.bFlushLogOnExit);
        WriteInteger('Протоколирование', 'iFlushLogOnStringsQuantity', Configuration.iFlushLogOnStringsQuantity);
        WriteBool('Протоколирование', 'bFlushLogOnClearingLog', Configuration.bFlushLogOnClearingLog);

        LogThis('Конфигурация сохранена успешно.', LogGroupGUID, lmtInfo);
      except
        on EIniFileException do
          ShowErrorBox(Handle,
            'Возникла ошибка при потытке сохранения конфигурации в INI-файле! Обратитесь к администратору!',
            LogGroupGUID);
      end;
    finally
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
// const
// LogGroupGUID: string = '{696511C5-B8BA-4A79-AC78-A1F7A4436F4B}';
begin
  // критичная по количеству выполнений процедура - в целях незасорения лога заголовок отключён
  // ProcedureHeader('Процедура отправления сообщений на MySQL-сервер во время простоя',LogGroupGUID,False,False);
  if (ListBox1.Items.Count > 0) and Configuration.LogServer.bConnected then
    Do_TransferMessageToDB;
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.pmLogPopup(Sender: TObject);
const
  LogGroupGUID: string = '{55CC897A-D7E5-4F1A-9C57-47886044EBAD}';
var
  b: Boolean;
begin
  ProcedureHeader('Процедура установки состояния доступности для действий локального меню списка сообщений протокола',
    LogGroupGUID);

  b := False;
  Action_CopyLogStringToClipboard.Enabled := (lvLog.Items.Count > 0) and (lvLog.Selected <> nil);
  Action_FindPreviousWithSuchGUID.Enabled := (lvLog.Items.Count > 0) and (lvLog.Selected <> nil);
  Action_FindNextWithSuchGUID.Enabled := (lvLog.Items.Count > 0) and (lvLog.Selected <> nil);
  if lvLog.Selected <> nil then
    if lvLog.Selected.ImageIndex = ICON_SQL then
      if lvLog.Selected.SubItems.Count = 4 then
        b := (Trim(lvLog.Selected.SubItems[3])) > '';
  Action_CopySQLFromLogToClipboard.Enabled := b;
  Action_FindSpecifiedGUID.Enabled := lvLog.Items.Count > 0;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.pmMsgPopup(Sender: TObject);
const
  LogGroupGUID: string = '{C6A61024-12A8-4D8F-9333-60A4C5A2FAE5}';
var
  b: Boolean;
  sl: TStringList;
begin
  ProcedureHeader('Процедура установки состояния доступности для действий локального меню списка полученных сообщений',
    LogGroupGUID);
  b := False;

  with ListBox1 do
  begin
    Action_CopyMsgStringToClipboard.Enabled := (Count > 0) and (ItemIndex >= 0);
    if (Count > 0) and (ItemIndex >= 0) then
    begin
      sl := TStringList.Create;
      try
        Routines_CutStringByLimiterToStringList(Items[ItemIndex], sl, #09);
        if Trim(sl[0]) = 'SQL' then
          if sl.Count = 7 then
            b := Trim(sl[6]) > '';
      finally
        sl.Free;
      end;
    end;
    Action_CopySQLFromMsgToClipboard.Enabled := b;
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string = '{064A508A-27A0-468A-9A65-D6D006F9E113}';
var
  s: string;
  PanelRect: TRect;
begin
  bFirstRun := True;
  // предварительное включение переменных управляющих отображением строк протокола работы программы
  Configuration.bKeepErrorLog := True;
  Configuration.bKeepWarningLog := True;
  Configuration.bKeepInfoLog := True;
  Configuration.bKeepSQLLog := True;

  ProcedureHeader('Процедура создания главной формы', LogGroupGUID);

  LogThis(PChar('Производится регистрация оконных сообщений...'), LogGroupGUID, lmtInfo);
  msgLogKeeperServer := RegisterWindowMessage('msgLogKeeperServer');
  msgLogKeeperClient := RegisterWindowMessage('msgLogKeeperClient');

  LogThis(PChar('Производится инициализация глобальных переменных...'), LogGroupGUID, lmtInfo);
  Configuration.LogServer.bConnected := False;
  Configuration.wExitCicleCounter := 0;
  MainForm.Visible := False;
  TrayIcon1.Visible := True;

  LogThis(PChar('Производится установка индикатора готовности в панель статуса программы...'), LogGroupGUID, lmtInfo);
  THackControl(pbMain).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
  pbMain.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right - PanelRect.Left, PanelRect.Bottom - PanelRect.Top);
  THackControl(Image1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
  Image1.SetBounds(PanelRect.Left + 1, PanelRect.Top + 1, PanelRect.Right - PanelRect.Left + 1,
    PanelRect.Bottom - PanelRect.Top + 1);

  LogThis(PChar('Производится проверка наличия файла справки...'), LogGroupGUID, lmtInfo);
  if not(FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Action_Help.Enabled := False;
    Action_Help.Visible := False;
  end;

  LogThis(PChar('Производится получение имени локального хоста...'), LogGroupGUID, lmtInfo);
  Configuration.sLocalHost := Routines_GetLocalIP;
  LogThis(PChar('Имя локального хоста: ' + Configuration.sLocalHost + '.'), LogGroupGUID, lmtInfo);

  LogThis(PChar('Производится считывание из файла ранее несохранённых на сервере сообщений...'), LogGroupGUID, lmtInfo);
  s := ExtractFilePath(ExpandFileName(Application.ExeName)) + 'LogKeeper_UnsendedMessages.dat';
  if FileExists(s) then
  begin
    ListBox1.Items.LoadFromFile(s);
    DeleteFile(s);
    LogThis(PChar('Сообщения были успешно считаны и добавлены в список сообщений.'), LogGroupGUID, lmtInfo);
  end
  else
    LogThis(PChar('Файл не был обнаружен.'), LogGroupGUID, lmtInfo);

  LogThis(PChar('Производится считывание конфигурации программы из ini-файла...'), LogGroupGUID, lmtInfo);
  Do_LoadConfigIni;

  LogThis(PChar('Производится инициализация положения и размеров главного окна программы...'), LogGroupGUID, lmtInfo);
  Update_MainFormPosition;

  LogThis(PChar('Производится инициализация панели статуса...'), LogGroupGUID, lmtInfo);
  miStatusbar.Checked := not Configuration.bNoStatusBar;
  StatusBar1.Visible := miStatusbar.Checked;
  Update_QuantityOfMessagesStrings;
  Update_QuantityOfLogStrings;
  Application.ProcessMessages;

  LogThis(PChar('Производится запуск таймеров...'), LogGroupGUID, lmtInfo);
  ExitTimer.Enabled := True;
  Timer2Timer(Sender);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string = '{3EBF0749-B2FF-4AD4-9633-5BCC8A8DE5FD}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);

  if bFirstRun then
  begin
    iBusyCounter := 0;
    bFirstRun := False;
  end;
  Refresh_BusyState(LogGroupGUID);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.lvLogCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  lvLog.Canvas.Font.Color := clBlack;
end;

procedure TMainForm.lvLogCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer;
  State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  lvLog.Canvas.Font.Color := clBlack;
  if SubItem = 1 then
    if Length(Item.SubItems[0]) = 38 then
      lvLog.Canvas.Font.Color := StringToColor('$' + Copy(Item.SubItems[0], 2, 6));
end;

procedure TMainForm.Update_ConnectionAction;
const
  LogGroupGUID: string = '{8BE4E5AD-0DC6-4937-81BD-BC7009C6CD52}';
begin
  ProcedureHeader('Процедура обновления состояния действий соединения с MySQL-сервером', LogGroupGUID);

  Action_Connect.Enabled := not Configuration.LogServer.bConnected;
  Action_Connect.Visible := Action_Connect.Enabled;
  Action_Disconnect.Enabled := not Action_Connect.Enabled;
  Action_Disconnect.Visible := Action_Disconnect.Enabled;
  LogThis(PChar('Действие "' + Action_Connect.Caption + '" ' + Routines_GetConditionalMessage(Action_Connect.Enabled,
    'в', 'от') + 'ключено, действие "' + Action_Disconnect.Caption + '" ' + Routines_GetConditionalMessage
    (Action_Connect.Enabled, 'в', 'от') + 'ключено.'), LogGroupGUID, lmtInfo);
  Application.ProcessMessages;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_QuantityOfMessagesStrings;
begin
  if StatusBar1.Panels[STATUSBAR_MESSAGES_COUNT_PANEL_NUMBER].Text <> 'Сообщений: ' + IntToStr(ListBox1.Items.Count)
  then
  begin
    StatusBar1.Panels[STATUSBAR_MESSAGES_COUNT_PANEL_NUMBER].Text := 'Сообщений: ' + IntToStr(ListBox1.Items.Count);
    StatusBar1.Panels[STATUSBAR_MESSAGES_COUNT_PANEL_NUMBER].Width :=
      StatusBar1.Canvas.TextWidth(StatusBar1.Panels[STATUSBAR_MESSAGES_COUNT_PANEL_NUMBER].Text) + 14;
  end;
end;

procedure TMainForm.Update_QuantityOfLogStrings;
begin
  if StatusBar1.Panels[STATUSBAR_LOG_COUNT_PANEL_NUMBER].Text <> 'Протокол: ' + IntToStr(lvLog.Items.Count) then
  begin
    StatusBar1.Panels[STATUSBAR_LOG_COUNT_PANEL_NUMBER].Text := 'Протокол: ' + IntToStr(lvLog.Items.Count);
    StatusBar1.Panels[STATUSBAR_LOG_COUNT_PANEL_NUMBER].Width :=
      StatusBar1.Canvas.TextWidth(StatusBar1.Panels[STATUSBAR_LOG_COUNT_PANEL_NUMBER].Text) + 10;
  end;
end;

procedure TMainForm.Update_MainFormPosition;
const
  LogGroupGUID: string = '{E2B76FBF-AE4B-41BA-936D-33F99378F624}';
begin
  ProcedureHeader('Процедура применения настроек положения и размеров главного окна программы', LogGroupGUID);

  if MainForm.WindowState = wsMaximized then
    MainForm.WindowState := wsNormal;
  MainForm.Width := Screen.WorkAreaWidth;
  // установка ширины окна в ширину рабочего стола
  MainForm.Height := Configuration.iMainFormHeight; // установка высоты окна
  MainForm.Left := Screen.WorkAreaLeft;
  // установка левого угла в крайнюю левую точку рабочего стола
  if Configuration.bBottomMainFormAlignment then
    // установка окна в новые позиции
    MainForm.Top := Screen.WorkAreaHeight - MainForm.Height
  else
    MainForm.Top := Screen.WorkAreaTop;
  LogThis('Установлены следующие координаты и размеры главного окна: X=' + IntToStr(MainForm.Left) + ', Y=' +
    IntToStr(MainForm.Top) + ', W=' + IntToStr(MainForm.Width) + ', H=' + IntToStr(MainForm.Height) + '.',
    LogGroupGUID, lmtInfo);
  if Configuration.bFullScreen then
  // максимизация окна при условии выставленной опции
  begin
    MainForm.Position := poDesigned;
    MainForm.WindowState := wsMaximized;
    LogThis('Главное окно было максимизировано в соответствии с настройками.', LogGroupGUID, lmtInfo);
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
  LogGroupGUID: string = '{E6FB9B6A-DA74-45B3-B11C-07D35052C1CD}';
var
  i: Integer;
begin
  ProcedureHeader('Процедура-обработчик завершения работы программы', LogGroupGUID);

  if not((Configuration.bInterraptionInitiated) and (Configuration.wExitCicleCounter >= EXIT_COUNTER_MAX)) then
  begin
    LogThis('Завершение работы отменено всвязи с наличием запущенной клиентской программы. Будет выполнена минимизация главного окна.',
      LogGroupGUID, lmtWarning);
    Do_MinimizeMainForm;
    CanClose := False;
  end
  else
  begin
    if Configuration.LogServer.bConnected then
    begin
      LogThis('Производится попытка передачи оставшихся сообщений на MySQL-сервер...', LogGroupGUID, lmtInfo);
      for i := 0 to ListBox1.Items.Count - 1 do
        if Configuration.LogServer.bConnected then
          Do_TransferMessageToDB;
    end;
    if ListBox1.Items.Count > 0 then
    begin
      LogThis('Производится запись непереданных на MySQL-сервер сообщений в файл...', LogGroupGUID, lmtInfo);
      ListBox1.Items.SaveToFile(ExtractFilePath(ExpandFileName(Application.ExeName)) +
        'LogKeeper_UnsendedMessages.dat');
    end;
    LogThis('Производится отключение от MySQL-сервера...', LogGroupGUID, lmtInfo);
    Do_Disconnect;
    LogThis('Производится запись конфигурации...', LogGroupGUID, lmtInfo);
    Do_SaveConfigIni;
    if Configuration.bFlushLogOnExit then
    begin
      LogThis('Производится запись сообщений протокола в файл...', LogGroupGUID, lmtInfo);
      Do_FlushLogToFile;
    end;
  end;
  LogThis('Производится включение флага инициации выхода...', LogGroupGUID, lmtInfo);
  Configuration.bInterraptionInitiated := True;
  // выставляем флаг инициации выхода из программы по нажатии кнопки выхода

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
const
  LogGroupGUID: string = '{6A2082B1-5186-4D83-896B-25AC87AF224E}';
begin
  // крайне критичная по времени исполнения процедура !!!!
  // ProcedureHeader('Процедура обработки сообщений посланых программе', LogGroupGUID);

  if Msg.message = msgLogKeeperServer then
  begin
    // LogThis('Послан ответ на полученное широковещательное сообщение.',LogGroupGUID,lmtWarning);
    PostMessage(Msg.wParam, msgLogKeeperServer, Handle, 0);
    Configuration.wExitCicleCounter := 0;
    // обнулить счётчик проверок наличия клиентов перед выходом, т.к. было получено сообщение от одной из клиентских программ
    Handled := True;
  end;
  if Msg.message = msgLogKeeperClient then
  begin
    // LogThis('Получен ответ на посланное ранее широковещательное сообщение.',LogGroupGUID,lmtWarning);
    Configuration.bInterraptionInitiated := False;
    // запретить выход из программы при достижении счётчика
    if Configuration.wExitCicleCounter > 1 then
      LogThis('Процедура выхода из программы прервана всвязи с получением ответа от клиентской программы на ' +
        IntToStr(Configuration.wExitCicleCounter * (Word(ExitTimer.Interval div 1000))) + ' сек.', LogGroupGUID,
        lmtWarning);
    Configuration.wExitCicleCounter := 0;
    // обнулить счётчик проверок наличия клиентов перед выходом, т.к. был получен ответ от одной из клиентских программ
    Handled := True;
  end;

  // ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ExitTimerTimer(Sender: TObject);
const
  LogGroupGUID: string = '{1AD5F1D9-046C-4665-AF5D-F6702E639C55}';
begin
  // крайне критичная по времени исполнения процедура !!!!
  // ProcedureHeader('Процедура отслеживания наличия клиентсих программ и инициации завершения в случае отсутствия таковых', LogGroupGUID);

  if Configuration.bInterraptionInitiated then
    LogThis('Был инициирован выход из программы! До выхода осталось ' +
      IntToStr((EXIT_COUNTER_MAX - Configuration.wExitCicleCounter) * (Word(ExitTimer.Interval div 1000))) + ' сек.',
      LogGroupGUID, lmtWarning)
  else
    if Configuration.wExitCicleCounter > 0 then
      LogThis('Ни одна клиентская программа не дала отклик на опрос! До выхода осталось ' +
        IntToStr((EXIT_COUNTER_MAX - Configuration.wExitCicleCounter) * (Word(ExitTimer.Interval div 1000))) + ' сек.',
        LogGroupGUID, lmtWarning);
  if Configuration.wExitCicleCounter = EXIT_COUNTER_MAX then
  begin
    if Configuration.bInterraptionInitiated then
      LogThis('Производится завершение работы программы всвязи с командой данной пользователем.', LogGroupGUID, lmtInfo)
    else
      LogThis('Производится завершение работы программы всвязи с отсутствием клиентских программ.',
        LogGroupGUID, lmtInfo);
  end;
  if Configuration.wExitCicleCounter < EXIT_COUNTER_MAX then
  begin
    Configuration.wExitCicleCounter := Configuration.wExitCicleCounter + 1;
    BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, msgLogKeeperClient, Handle, 0);
    // отправка бродкастового сообщения для очередной проверки наличия клиентов
  end
  else
  begin
    Configuration.bInterraptionInitiated := True;
    ExitTimer.Enabled := False;
    Do_Close; // выход при достижении счётчиком минутного интервала "простоя" программы без нахождения клиентов
  end;

  // ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
const
  LogGroupGUID: string = '{DA1C328A-D622-45EB-B608-26313DA8524A}';
begin
  ProcedureHeader('Процедура реакции на срабатывание таймера ответственного за повторное подключение к MySQL-серверу',
    LogGroupGUID);

  if Configuration.LogServer.bConnected then
    // // если уже было установлено соединение
    Timer2.Enabled := False // выключаем попытки вновь соединиться
  else
  begin // если нет
    with TSendDataToMySQLServerThread.Create('{93BCFE4A-99DB-4E09-BA2B-A4E9CE38F48E}', Configuration) do
      try
        Start;
      except
        on Exception do;
        // Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
      end;
    Timer2.Enabled := True; // включаем таймер
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.WMCopyData(var Msg: TWMCopyData);
const
  LogGroupGUID: string = '{8EDBC4A1-DFFF-46DF-82D5-B8AB3F161848}';
var
  cText: array [0 .. 51200] of AnsiChar;
  MessageType: TLogMessagesType;
  sl: TStringList;
  bError: Boolean;
  sErrorMessage: string;
begin
  // ProcedureHeader('Процедура получения данных из внешнего процесса', LogGroupGUID);
  MessageType := lmtError;

  System.AnsiStrings.StrLCopy(cText, Msg.CopyDataStruct.lpData, Msg.CopyDataStruct.cbData);
  LogThis(PChar('Данные, полученые из внешнего процесса: [' + cText + ']'), LogGroupGUID, lmtDebug);

  if Msg.From = HWND(MainForm.Handle) then
  begin
    sl := TStringList.Create;
    try
      Routines_CutStringByLimiterToStringList(string(AnsiString(cText)), sl, ';');
      if sl.Count = 4 then
      begin
        if (sl[0] = IntToStr(WMCD_THREADLOG)) and ((sl[1] = 'ERROR') or (sl[1] = 'WARNING') or (sl[1] = 'INFO') or
          (sl[1] = 'SQL') or (sl[1] = 'DEBUG')) then
        begin
          if sl[1] = 'ERROR' then
            MessageType := lmtError
          else
            if sl[1] = 'WARNING' then
              MessageType := lmtWarning
            else
              if sl[1] = 'INFO' then
                MessageType := lmtInfo
              else
                if sl[1] = 'SQL' then
                  MessageType := lmtSQL
                else
                  if sl[1] = 'DEBUG' then
                    MessageType := lmtDebug;
          LogThis(sl[2], sl[3], MessageType);
        end
        else
          Routines_GenerateError('Произошла ошибка при расшифровке данных строки лога, переданных из дочернего потока!',
            sErrorMessage, bError);
      end;
    finally
      sl.Free;
    end;
  end
  else
  begin
    ListBox1.Items.Append(string(AnsiString(cText)));
    Update_QuantityOfMessagesStrings;
    Application.ProcessMessages;
  end;

  // PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  // ProcedureFooter(LogGroupGUID);
end;

{ TODO: Переделать программу с учётом наработок проекта overseer }

end.

// дописать функцмонал настроек интерфейса!!!
