unit Main;

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
  getFVI,
  AppEvnts,
  ExtCtrls,
  Menus,
  ActnList,
  XPStyleActnCtrls,
  ActnMan,
  CommCtrl,
  ToolWin,
  ActnCtrls,
  mysql,
  LogKeeperConsts,
  LogKeeperTypes;

type
  THackControl= class(TControl);

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
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
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
    procedure lvLogCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvLogCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Action_FindPreviousWithSuchGUIDExecute(Sender: TObject);
    procedure Action_CopyGUIDStringToClipboardExecute(Sender: TObject);
    procedure ExitTimerTimer(Sender: TObject);
    procedure Action_FindSpecifiedGUIDExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    iBusyCounter: integer;
    bFirstRun: boolean;
    msgLogKeeperServer, msgLogKeeperClient: cardinal;
    SessionLogEventCount: cardinal;
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
    procedure PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
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
    bAboutWindowExist: boolean;
    bStartingNormalShutdown: boolean;
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
  About,
  Configuration,
  FindGIUD,
  ShellAPI,
  IniFiles,
  SendDataToMySQLServer,
  LogKeeperRoutines;

var
  Recipients: DWORD=BSM_APPLICATIONS;

  { ���������� ��������� }

procedure TMainForm.Action_FindSpecifiedGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string='{51F0AA87-B7E2-4968-8136-466AE002FC93}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_FindSpecifiedGUID.Caption+'"', LogGroupGUID);
  Do_FindSpecifiedGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ShowErrorBox(const aHandle: HWND; const aErrorMessage: string; const aLogGroupGUID: string);
var
  iOldBusyCounter: integer;
begin
  LogThis(aErrorMessage, aLogGroupGUID, lmtError);

  iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
  iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
  Refresh_BusyState(aLogGroupGUID); // ���������� ��������� ����������

  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar('LogKeeper - ������!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  Application.ProcessMessages;

  iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
  Refresh_BusyState(aLogGroupGUID); // ���������� ��������� ����������
  Application.ProcessMessages;
end;

procedure TMainForm.PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  LogThis('������������ ������� ����������� ���������� ���� '+aWindowName+'.', aLogGroupGUID, lmtDebug);
  with MainForm do
    begin
      aOldBusyState:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
      iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
      Refresh_BusyState(aLogGroupGUID); // ���������� ��������� ����������
    end;
end;

procedure TMainForm.PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  with MainForm do
    begin
      iBusyCounter:=aOldBusyState; // ����������� ������� �������� ��������
      Refresh_BusyState(aLogGroupGUID); // ���������� ��������� ����������
    end;
  LogThis('���� '+aWindowName+' ������.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('������ ���������...', aLogGroupGUID, lmtDebug);
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TMainForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('��������� ���������.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
const
  LogGroupGUID: string='{4A3B82FD-ED8E-4ABC-A6C6-C9E600BD1B33}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Configuration.Caption+'"', LogGroupGUID);
  Do_Configuration;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopyGUIDStringToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string='{6871D088-2BEB-4BE4-B14E-29B83117B378}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_CopyGUIDStringToClipboard.Caption+'"', LogGroupGUID);
  Do_CopyGUIDStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
const
  LogGroupGUID: string='{2B63A7EF-38C1-4035-BEBD-838E86C11146}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_About.Caption+'"', LogGroupGUID);
  Do_About;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopySQLFromMsgToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string='{5CED9045-D491-481A-B80A-E40216AB39EF}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_CopySQLFromMsgToClipboard.Caption+'"', LogGroupGUID);
  Do_CopySQLFromMsgToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopyLogStringToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string='{A1D1D539-1E62-4D10-A05E-FCB1C66DF595}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_CopyLogStringToClipboard.Caption+'"', LogGroupGUID);
  Do_CopyLogStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopyMsgStringToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string='{74B6478F-7FB3-44AF-AB9B-75081A655BE1}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_CopyMsgStringToClipboard.Caption+'"', LogGroupGUID);
  Do_CopyMsgStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ClearLogListExecute(Sender: TObject);
const
  LogGroupGUID: string='{FFFB71DB-6D94-4081-BDAE-A682A53B3EB2}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ClearLogList.Caption+'"', LogGroupGUID);
  Do_ClearLogList;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ConnectExecute(Sender: TObject);
const
  LogGroupGUID: string='{098B8251-3B86-4848-947A-1B5CAEC07323}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Connect.Caption+'"', LogGroupGUID);
  Do_Connect;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_DisconnectExecute(Sender: TObject);
const
  LogGroupGUID: string='{0A134B4E-48D3-4CF0-BE39-5C1AA6A80E00}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Disconnect.Caption+'"', LogGroupGUID);
  Do_Disconnect;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopySQLFromLogToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string='{C96DE03B-56B7-4947-B2EC-51486C4801DD}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_CopySQLFromLogToClipboard.Caption+'"', LogGroupGUID);
  Do_CopySQLFromLogToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ClearMsgListExecute(Sender: TObject);
const
  LogGroupGUID: string='{83D14757-BCCE-48CD-862A-91F83DEAA85F}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ClearMsgList.Caption+'"', LogGroupGUID);
  Do_ClearMsgList;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{A51A51FA-F9F4-4964-8E14-6186C77FE244}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RestoreExecute(Sender: TObject);
const
  LogGroupGUID: string='{BEBD392D-B923-4341-BCB6-821191362237}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Restore.Caption+'"', LogGroupGUID);
  Do_RestoreMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RestoreLogPanelExecute(Sender: TObject);
const
  LogGroupGUID: string='{40FA8E73-EEF7-44DC-93C2-CC3CC0BCEB78}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_RestoreLogPanel.Caption+'"', LogGroupGUID);
  Do_RestoreLogPanel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_MaximizeLogPanelExecute(Sender: TObject);
const
  LogGroupGUID: string='{191EC332-8ECF-46D1-BD76-C992CA2EB530}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_MaximizeLogPanel.Caption+'"', LogGroupGUID);
  Do_MaximizeLogPanel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyGUIDStringToClipboard;
const
  LogGroupGUID: string='{9EAA7AEB-8077-45E7-BCBC-2943C92A7DC9}';
begin
  ProcedureHeader('��������� ����������� GUID ����������� �������� ������ ��������� � ����� ������', LogGroupGUID);

  with lvLog do
    if Selected<>nil then
      with Selected do
        if SubItems.Count=4 then
          Routines_CopyStringToClipboard(Trim(SubItems[0]));

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_ClearLogList;
const
  LogGroupGUID: string='{38F36760-1536-47B3-8EB9-89BE61599232}';
var
  iCount: integer;
begin
  ProcedureHeader('��������� ������� ������ ��������� ���������', LogGroupGUID);

  if Configuration.bFlushLogOnClearingLog then
    Do_FlushLogToFile
  else
    with lvLog.Items do
      if Count>0 then
        begin
          iCount:=Count;
          BeginUpdate;
          Clear;
          EndUpdate;
          LogThis('��������� ������� ��������� ������ ���������. ���������� �������� �����: '+IntToStr(iCount)+'.', LogGroupGUID, lmtInfo);
        end
      else
        LogThis('�������� ������ ��������� ����, ������� �� ���������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyLogStringToClipboard;
const
  LogGroupGUID: string='{00BE0E1B-28FB-40BC-BFB9-2BE760F3254C}';
var
  s: string;
begin
  ProcedureHeader('��������� ����������� ������ ����������� �������� ������ ��������� � ����� ������', LogGroupGUID);

  with lvLog do
    if (Items.Count>0)and(Selected<>nil) then
      with Selected do
        begin
          case ImageIndex of
            ICON_ERROR:
              s:='ERROR';
            ICON_WARNING:
              s:='WARNING';
            ICON_INFO:
              s:='INFO';
            ICON_SQL:
              s:='SQL';
          end;
          Routines_CopyStringToClipboard(s+#09+Caption+#09+SubItems[0]+#09+SubItems[1]+#09+SubItems[2]+#09+SubItems[3]);
        end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyMsgStringToClipboard;
const
  LogGroupGUID: string='{B3EB6C9B-BF98-4D9F-808C-4AC146531E7A}';
begin
  ProcedureHeader('��������� ����������� ������ ����������� �������� ������ ���������� ��������� � ����� ������', LogGroupGUID);

  with ListBox1 do
    if (Count>0)and(ItemIndex>=0) then
      Routines_CopyStringToClipboard(Items[ItemIndex]);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopySQLFromLogToClipboard;
const
  LogGroupGUID: string='{27F2860B-7873-403B-B2E2-09A4E635FF2A}';
begin
  ProcedureHeader('��������� ����������� ������ SQL-������� ����������� �������� ������ ��������� ��������� � ����� ������', LogGroupGUID);

  with lvLog do
    if Selected<>nil then
      with Selected do
        if ImageIndex=ICON_SQL then
          if SubItems.Count=4 then
            Routines_CopyStringToClipboard(Trim(SubItems[3]));

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_MinimizeMainForm;
const
  LogGroupGUID: string='{47111023-48A7-47FC-903F-1D23D28CD03F}';
begin
  ProcedureHeader('��������� ������������ �������� ���� � ����', LogGroupGUID);

  MainForm.Visible:=False;
  TrayIcon1.Visible:=True;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Help;
const
  LogGroupGUID: string='{DA5BFDBC-CA0D-4031-BCCB-84727CD271E8}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('��������� �������� ����������� ����� ���������', LogGroupGUID);

  LogThis('������������ ������� �������� ����������� ����� ���������...', LogGroupGUID, lmtInfo);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    Routines_GenerateError('��������, ���������� ���� � ������ ��������� �� ������.', sErrorMessage, bError);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_RestoreLogPanel;
const
  LogGroupGUID: string='{421471AF-24CD-4F33-9BCD-1716CA35A228}';
begin
  ProcedureHeader('��������� �������������� �������� �������� ������ ���������', LogGroupGUID);

  pnlLog.Align:=alBottom;
  pnlLog.Height:=87;
  ListBox1.Visible:=not(pnlLog.Align=alClient);
  Action_RestoreLogPanel.Enabled:=False;
  Action_MaximizeLogPanel.Enabled:=True;
  btnRestoreLogPanel.Enabled:=False;
  btnMaximazeLogPanel.Enabled:=True;
  LogThis('���� ���������� ���������� ������� ������ ��������� ������ ���������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_MaximizeLogPanel;
const
  LogGroupGUID: string='{2A9FE7CB-1477-4762-9B44-97D38B4828D4}';
begin
  ProcedureHeader('��������� �������������� ������ ��������� �� �� ����', LogGroupGUID);

  pnlLog.Align:=alClient;
  ListBox1.Visible:=not(pnlLog.Align=alClient);
  Action_MaximizeLogPanel.Enabled:=False;
  Action_RestoreLogPanel.Enabled:=True;
  btnMaximazeLogPanel.Enabled:=False;
  btnRestoreLogPanel.Enabled:=True;
  LogThis('������ ��������� ������ ��������� ���� ��������� �� �� ����.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_RestoreMainForm;
const
  LogGroupGUID: string='{CD7AB392-2C99-4D7D-953A-8E1D87B3ABE0}';
var
  fwi: FLASHWINFO;
begin
  ProcedureHeader('��������� �������������� �������� ���� �� ����', LogGroupGUID);

  if bAboutWindowExist then
    begin
      with fwi do
        begin
          cbSize:=sizeof(FLASHWINFO);
          hwnd:=Application.Handle;
          dwFlags:=FLASHW_TRAY or FLASHW_TIMERNOFG;
          uCount:=0;
          dwTimeout:=0;
        end;
      FlashWindowEx(fwi);
    end
  else
    begin
      TrayIcon1.Visible:=Configuration.bAlwaysShowTrayIcon;
      MainForm.Visible:=True;
      SetForegroundWindow(MainForm.Handle);
      Application.Restore;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.miStatusbarClick(Sender: TObject);
const
  LogGroupGUID: string='{DE96EF0B-E61C-4BCA-AFEB-506C2A601E95}';
begin
  ProcedureHeader('��������� ���������/���������� ����������� ������ �������', LogGroupGUID);

  StatusBar1.Visible:=miStatusbar.Checked;
  Configuration.bNoStatusBar:=not StatusBar1.Visible;
  LogThis('������ ������� '+Routines_GetConditionalMessage(StatusBar1.Visible, '�', '��')+'�������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ApplicationEvents1Minimize(Sender: TObject);
const
  LogGroupGUID: string='{7BC630DC-36DE-41C6-9456-653FFDCBF218}';
begin
  ProcedureHeader('��������� ������� �� ������� ����������� �������� ����', LogGroupGUID);
  Do_MinimizeMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TrayIcon1Click(Sender: TObject);
const
  LogGroupGUID: string='{98C16554-C533-4ACF-AB8A-0211CC0CDDD0}';
begin
  ProcedureHeader('���������-���������� ������ �� ������ � ����', LogGroupGUID);

  if MainForm.Visible then
    SetForegroundWindow(MainForm.Handle);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TrayIcon1DblClick(Sender: TObject);
const
  LogGroupGUID: string='{007A7EE9-D2F8-4680-A937-908EF3F9E880}';
begin
  ProcedureHeader('���������-���������� ���������� ������ �� ������ � ����', LogGroupGUID);
  Do_RestoreMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindNextWithSuchGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string='{0ECA0D5F-75C0-475C-B8E5-F2729BEF3BF5}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_FindNextWithSuchGUID.Caption+'"', LogGroupGUID);
  Do_FindNextWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindPreviousWithSuchGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string='{2E15574E-CC14-4B96-88FC-B9DEF3D1168F}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_FindPreviousWithSuchGUID.Caption+'"', LogGroupGUID);
  Do_FindPreviousWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.lvLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  LogGroupGUID: string='{0D23E095-7D8F-4144-9727-1CA679901494}';
begin
  ProcedureHeader('���������-���������� ������� ������� � ������ ���������', LogGroupGUID);
  if Key=VK_F2 then
    Do_FindPreviousWithSuchGUID;
  if Key=VK_F3 then
    Do_FindNextWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_FlushLogToFile;
const
  LogGroupGUID: string='{E40F2A33-FEE8-4D0A-8A0F-C5FB265BE184}';
var
  s: string;
  sl: TStringList;
begin
  ProcedureHeader('��������� �������� ���� ������� ����� ��������� ������ ��������� � ��������� ����', LogGroupGUID);

  sl:=TStringList.Create;
  try
    while lvLog.Items.Count>0 do
      begin
        if lvLog.Items[0]<>nil then
          if lvLog.Items[0].SubItems.Count=4 then
            sl.Append(lvLog.Items[0].Caption+#09+lvLog.Items[0].SubItems[0]+#09+lvLog.Items[0].SubItems[1]+#09+lvLog.Items[0].SubItems[2]+#09+lvLog.Items[0].SubItems[3]);
        lvLog.Items[0].Delete;
      end;
    s:=FormatDateTime('yyyymmdd_hhnnss', Now);
    if sl.Count>0 then
      try
        sl.SaveToFile(ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper_'+s+'.log');
      except
        on EStringListError do
          ShowErrorBox(Handle, '�������� ������ ��� ������� ���������� ��������� � ����� "'+s+'"! ���������� � ��������������!', LogGroupGUID);
      end;
  finally
    sl.Free;
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_FindSpecifiedGUID;
const
  LogGroupGUID: string='{BAD3DC04-5E81-4735-B9AC-17C85A8C1ED7}';
  sModalWinName: string='������ GUID';
var
  iBusy: integer;
begin
  ProcedureHeader('��������� ����������� ���� '+sModalWinName, LogGroupGUID);

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
      iBusyCounter:=iBusyCounter+1;
      if iBusyCounter<0 then
        iBusyCounter:=0;
      Refresh_BusyState(aLogGroupGUID);
    end;
end;

procedure TMainForm.Dec_BusyState(const aLogGroupGUID: string);
begin
  with MainForm do
    begin
      iBusyCounter:=iBusyCounter-1;
      if iBusyCounter<0 then
        iBusyCounter:=0;
      Refresh_BusyState(aLogGroupGUID);
    end;
end;

procedure TMainForm.Refresh_BusyState(const aLogGroupGUID: string);
begin
  LogThis('���������� ����� "'+Routines_GetConditionalMessage(iBusyCounter>0, '������', '������')+'".', aLogGroupGUID, lmtDebug);
  with MainForm do
    begin
      if iBusyCounter>0 then
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
        StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=Routines_GetConditionalMessage(iBusyCounter>0, '����������, ���������...', '������');
    end;
  Application.ProcessMessages;
end;

procedure TMainForm.LogThis(const aMessage, aLogGroupGIUD: string; const aMessageType: TLogMessagesType);
var
  i: integer;
  ListItem: TListItem;
begin
  if (((Configuration.bKeepErrorLog)and(aMessageType=lmtError))or((Configuration.bKeepWarningLog)and(aMessageType=lmtWarning))or((Configuration.bKeepInfoLog)and(aMessageType=lmtInfo))or((Configuration.bKeepSQLLog)and(aMessageType=lmtSQL))or
      ((Configuration.bKeepDebugLog)and(aMessageType=lmtDebug))) then
    begin
      i:=-1;
      SessionLogEventCount:=SessionLogEventCount+1;
      case aMessageType of
        lmtError:
          i:=ICON_ERROR;
        lmtWarning:
          i:=ICON_WARNING;
        lmtInfo:
          i:=ICON_INFO;
        lmtSQL:
          i:=ICON_SQL;
        lmtDebug:
          i:=ICON_DEBUG;
      end;
      ListItem:=lvLog.Items.Add;
      ListItem.ImageIndex:=i; // ��� ���������
      ListItem.Caption:=FormatDateTime('dd.mm.yyyy hh:nn:ss', Now); // ���� � ����� ���������
      ListItem.SubItems.Add(aLogGroupGIUD);
      ListItem.SubItems.Add(StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])); // ���������� ����� ���������
      ListItem.SubItems.Add(string(Configuration.LogServer.sMySQLUser)); // ������� �������������� ������������
      ListItem.SubItems.Add(aMessage); // ����� ���������
      if (Configuration.iFlushLogOnStringsQuantity>0)and(lvLog.Items.Count=Configuration.iFlushLogOnStringsQuantity) then
        Do_FlushLogToFile;
      if Configuration.bScrollToLastLogMessage then
        SendMessage(lvLog.Handle, LVM_ENSUREVISIBLE, lvLog.Items.Count-1, 0);
      Update_QuantityOfLogStrings;
    end;
end;

procedure TMainForm.Do_Close;
const
  LogGroupGUID: string='{7F91E383-797D-42DE-8742-826D4F358C65}';
begin
  ProcedureHeader('��������� ��������� ���������� ������ ���������', LogGroupGUID);
  Close;
  LogThis('����������� ������� ���������� ������ ���������...', LogGroupGUID, lmtInfo);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
const
  LogGroupGUID: string='{9E0753A5-7E5A-40E4-8EC9-45EF6282D941}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Quit.Caption+'"', LogGroupGUID);
  Do_Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_About;
const
  LogGroupGUID: string='{68AFEB74-4DA9-41D9-9398-2955A89084D3}';
  sModalWinName: string='"� ���������..."';
var
  AboutForm: TAboutForm;
  iBusy: integer;
begin
  ProcedureHeader('��������� ����������� ���� '+sModalWinName, LogGroupGUID);

  if bAboutWindowExist then
    SetForegroundWindow(FindWindow('TAboutForm', 'About "LogKeeper"...'))
  else
    begin
      AboutForm:=TAboutForm.Create(Self);
      with AboutForm do
        try
          bAboutWindowExist:=True;
          Action_Close.Visible:=True;
          PreShowModal(sModalWinName, LogGroupGUID, iBusy);
          ShowModal;
        finally
          PostShowModal(sModalWinName, LogGroupGUID, iBusy);
          Free;
          bAboutWindowExist:=False;
        end;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Connect;
const
  LogGroupGUID: string='{1BCA8A3E-8671-438D-98DB-D94194F6AF05}';
var
  sErrorMessage: string;
  bError: boolean;
begin
  ProcedureHeader('��������� ����������� ��������� � MySQL-�������', LogGroupGUID);
  bError:=False;

  with Configuration, LogServer do
    begin
      LogThis('>> ����������� �������� ����������� � MySQL-������� '+sMySQLHost+'...', LogGroupGUID, lmtInfo);
      if bConnected then
        Routines_GenerateError('���� ����������� ������� ����������� � ������������� � ��������� ������ MySQL-�������!', sErrorMessage, bError)
      else
        begin
          hConnection:=mysql_init(nil);
          if hConnection=nil then
            Routines_GenerateError('�������� ������ ��� ������������� ������� ���������� � �������� MySQL!', sErrorMessage, bError)
          else
            begin
              LogThis('������������� ������� ���������� � �������� MySQL ��������� �������.', LogGroupGUID, lmtDebug);
              bConnected:=mysql_real_connect(hConnection, PAnsiChar(AnsiString(sMySQLHost)), PAnsiChar(sMySQLUser), PAnsiChar(sMySQLPassword), PAnsiChar(AnsiString(sMySQLDatabase)), iMySQLPort, nil, integer(bMySQLCompress)*CLIENT_COMPRESS)<>nil;
              if not bConnected then
                Routines_GenerateError('�������� ������ ��� ������� ����������� � MySQL-������� '+sMySQLHost+'!'+Routines_GetMySQLErrorInfo(LogServer), sErrorMessage, bError)
              else
                LogThis('����������� � MySQL-������� '+sMySQLHost+' ��������� �������.', LogGroupGUID, lmtInfo);
            end;
        end;
      LogThis('<< ���������� �������� ����������� � MySQL-������� '+sMySQLHost+' ���������.', LogGroupGUID, lmtDebug);
    end;

  Update_ConnectionAction;

  if bError then
    LogThis(sErrorMessage, LogGroupGUID, lmtError)
  else
    begin
      LogThis('��������� ��������� ��� ������.', LogGroupGUID, lmtDebug);
      ApplicationEvents1.OnIdle:=ApplicationEvents1Idle; // ������ ������ ����������� �������� ��������� �� ������
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Disconnect;
const
  LogGroupGUID: string='{B0306D16-AF57-4B6C-AA33-00784E46BFC7}';
begin
  ProcedureHeader('��������� ���������� ��������� �� MySQL-�������', LogGroupGUID);

  with Configuration.LogServer do
    begin
      if bConnected then
        begin
          LogThis('>> ����������� �������� ���������� �� MySQL-������� '+sMySQLHost+'...', LogGroupGUID, lmtDebug);
          if hConnection<>nil then
            begin
              LogThis('"��������� ����������� � MySQL-������� �� ����. ������������ ����������.', LogGroupGUID, lmtDebug);
              mysql_close(hConnection);
              hConnection:=nil;
            end
          else
            LogThis('"��������� ����������� � MySQL-������� ����. ���������� �� ���������.', LogGroupGUID, lmtDebug);
          bConnected:=False;
          LogThis('���������� �� MySQL-������� '+sMySQLHost+' ��������� �������.', LogGroupGUID, lmtInfo);
          LogThis('<< ���������� �������� ���������� �� MySQL-������� '+sMySQLHost+' ���������.', LogGroupGUID, lmtDebug);
        end;
    end;

  ApplicationEvents1.OnIdle:=nil;
  Update_ConnectionAction;

  ProcedureFooter(LogGroupGUID);
end;

{ ������������ ��������� }

procedure TMainForm.Do_CopySQLFromMsgToClipboard;
const
  LogGroupGUID: string='{CD23B041-44F4-4375-9738-A4A4DBEBAD07}';
var
  sl: TStringList;
begin
  ProcedureHeader('��������� ����������� ������ SQL-������� ����������� �������� ������ ���������� ��������� � ����� ������', LogGroupGUID);

  with ListBox1 do
    if (Count>0)and(ItemIndex>=0) then
      begin
        sl:=TStringList.Create;
        try
          Routines_CutStringByLimiterToStringList(Items[ItemIndex], sl, #09);
          if Trim(sl[0])='SQL' then
            if sl.Count=7 then
              Routines_CopyStringToClipboard(Trim(sl[6]));
        finally
          sl.Free;
        end;
      end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_ClearMsgList;
const
  LogGroupGUID: string='{38F36760-1536-47B3-8EB9-89BE61599232}';
begin
  ProcedureHeader('��������� ������� ������ ���������� ���������', LogGroupGUID);

  with ListBox1 do
    if Count>0 then
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
  LogGroupGUID: string='{218867D7-6A06-4C16-BA00-4F78EA3E0141}';
var
  s: string;
  i, j: integer;
  b: boolean;
  aCursor: TCursor;
begin
  // ProcedureHeader('��������� �������� � ��������� ������ ��������� � ����� �� GUID',LogGroupGUID,False,False);
  b:=False;
  j:=-1;
  if (lvLog.Items.Count>0)and(lvLog.Selected<>nil) then
    begin
      if lvLog.Selected.SubItems.Count>=1 then
        begin
          s:=lvLog.Selected.SubItems[0]; // ��������� GUID ����������� �������� ������
          // LogThis(PChar('������� ������ GUID: '+s+'.'),LogGroupGUID,lmtInfo);
          with lvLog do // ������� � ��������� ������ ������ ��������� � ������ GUID
            begin
              for i:=Selected.index+1 to Items.Count-1 do
                if not b then
                  if Items[i]<>nil then
                    if Items[i].SubItems.Count>=1 then
                      if Items[i].SubItems[0]=s then
                        begin
                          b:=True;
                          j:=i;
                        end;
              if b and(j>-1) then
                begin
                  Items[j].Selected:=True;
                  Items[j].Focused:=True;
                  Selected.MakeVisible(False);
                end
              else
                begin
                  aCursor:=Screen.Cursor;
                  Screen.Cursor:=crDefault;
                  MessageBox(Handle, PChar('����� � GUID '+s+' ���� ��������� � ������ ��������� ����� �� �������!'), PChar('LogKeeper - ��������!'), MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                  Application.ProcessMessages;
                  Screen.Cursor:=aCursor;
                end;
            end;
        end;
      // else LogThis(PChar('������� �� ��������, ��� ��� �� ���� ������� ������ GUID ���� �� ������!'),LogGroupGUID,lmtError);
    end;
  // else LogThis(PChar('������� �� ����������, ��� ��� �� ���� �������� �� ����� ������ ������!'),LogGroupGUID,lmtWarning);
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.Do_FindPreviousWithSuchGUID;
const
  LogGroupGUID: string='{EF163619-7AE2-4D73-9DA4-C07ABAFA8303}';
var
  s: string;
  i, j: integer;
  b: boolean;
  aCursor: TCursor;
begin
  // ProcedureHeader('��������� �������� � ���������� ������ ��������� � ����� �� GUID',LogGroupGUID,False,False);
  b:=False;
  j:=-1;
  if (lvLog.Items.Count>0)and(lvLog.Selected<>nil) then
    begin
      if lvLog.Selected.SubItems.Count>=1 then
        begin
          s:=lvLog.Selected.SubItems[0]; // ��������� GUID ����������� �������� ������
          // LogThis(PChar('������� ������ GUID: '+s+'.'),LogGroupGUID,lmtInfo);
          with lvLog do // ������� � ���������� ������ ������ ��������� � ������ GUID
            begin
              for i:=Selected.index-1 downto 0 do
                if not b then
                  if Items[i]<>nil then
                    if Items[i].SubItems.Count>=1 then
                      if Items[i].SubItems[0]=s then
                        begin
                          b:=True;
                          j:=i;
                        end;
              if b and(j>-1) then
                begin
                  Items[j].Selected:=True;
                  Items[j].Focused:=True;
                  Selected.MakeVisible(False);
                end
              else
                begin
                  aCursor:=Screen.Cursor;
                  Screen.Cursor:=crDefault;
                  MessageBox(Handle, PChar('����� � GUID '+s+' ���� ��������� � ������ ��������� ����� �� �������!'), PChar('LogKeeper - ��������!'), MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                  Application.ProcessMessages;
                  Screen.Cursor:=aCursor;
                end;
            end;
        end;
      // else LogThis(PChar('������� �� ��������, ��� ��� �� ���� ������� ������ GUID ���� �� ������!'),LogGroupGUID,lmtError);
    end;
  // else LogThis(PChar('������� �� ����������, ��� ��� �� ���� �������� �� ����� ������ ������!'),LogGroupGUID,lmtWarning);
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.Do_TransferMessageToDB;
const
  LogGroupGUID: string='{2F0657F6-BE9D-4851-9877-0A89F4947D32}';
var
  bError: boolean;
  q: string;
  sMessage, sErrorMessage: string;
  i: integer;
  sl: TStringList;
  dt: TDateTime;
begin
  ProcedureHeader('��������� �������� ���������� ��������� �� MySQL-������', LogGroupGUID);
  bError:=False;

  if ListBox1.Items.Count>0 then
    begin
      // ������������ ������ ������ �� ���������
      sMessage:=ListBox1.Items[0];
      ListBox1.Items.Delete(0);
      Application.ProcessMessages;

      sl:=TStringList.Create;
      try
        sl.Duplicates:=dupAccept;
        sl.Sorted:=False;
        Routines_CutStringByLimiterToStringList(sMessage, sl, #09);
        // ��������� ��������� ������������ ������
        if not bError then
          if not((sl[2]='ERROR  ')or(sl[2]='WARNING')or(sl[2]='INFO   ')or(sl[2]='SQL    ')) then
            Routines_GenerateError('��� ��������� ['+sl[2]+'] �� ������������� �����������!', sErrorMessage, bError);
        if not bError then
          begin
            dt:=EncodeDate(1900, 01, 01);
            if StrToDateDef(sl[3], dt)=dt then
              Routines_GenerateError('���� ��������� ['+sl[3]+'] �� ������������� �����������!', sErrorMessage, bError);
          end;
        if not bError then
          begin
            dt:=EncodeTime(1, 2, 3, 4);
            if StrToTimeDef(sl[4], dt)=dt then
              Routines_GenerateError('����� ��������� ['+sl[4]+'] �� ������������� �����������!', sErrorMessage, bError);
          end;
        if not bError then
          if Length(sl[5])<>38 then
            Routines_GenerateError('GUID ������ ��������� ['+sl[5]+'] �� ������������� �����������!', sErrorMessage, bError);
        if not bError then
          if StrToIntDef(sl[6], -1)=-1 then
            Routines_GenerateError('������ ��������� ['+sl[6]+'] �� ������������� �����������!', sErrorMessage, bError);
        if not bError then
          begin
            q:='INSERT INTO '+string(Configuration.LogServer.sMySQLDatabase)+'._log '+'(log_host, log_application, log_user, log_type, log_date, log_time, log_group_guid, log_index, log_details) VALUES ('+'"'+Configuration.sLocalHost+'", '+
              Routines_NormalizeStringForQuery(Trim(sl[0]), True, False)+', '+Routines_NormalizeStringForQuery(Trim(sl[1]), True, False)+', '+Routines_NormalizeStringForQuery(sl[2], True, False)+', '+Routines_NormalizeStringForQuery
              (FormatDateTime('yyyy-mm-dd', StrToDate(sl[3])), True, False)+', '+Routines_NormalizeStringForQuery(sl[4], True, False)+', '+Routines_NormalizeStringForQuery(sl[5], True, False)+', '+Routines_NormalizeStringForQuery(sl[6], False,
              False)+', '+Routines_NormalizeStringForQuery(sl[7], True, False)+');';
          end;
      except
        Routines_GenerateError('�������� ������ � �������� �������������� ������ ������!', sErrorMessage, bError);
      end;
      if not bError then
        begin
          LogThis(q, LogGroupGUID, lmtSQL);
          i:=mysql_real_query(Configuration.LogServer.hConnection, PAnsiChar(AnsiString(q)), Length(q));
          if i=0 then
            begin
              LogThis('������ �������� �������.', LogGroupGUID, lmtInfo);
              i:=mysql_affected_rows(Configuration.LogServer.hConnection);
              if i=1 then
                begin
                  LogThis('���������� ����� ������� ������������� ����������.', LogGroupGUID, lmtInfo);
                  LogThis('������ ������ ���� ������� �������� � ������� ��.', LogGroupGUID, lmtInfo);
                end
              else
                Routines_GenerateError('���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!', sErrorMessage, bError);
            end
          else
            Routines_GenerateError('�������� ������ ��� ���������� �������!', sErrorMessage, bError);
        end;
      if bError then
        begin
          ListBox1.Items.Append(sMessage); // �������������� ����������� ������ � ����� ������
          LogThis(sErrorMessage, LogGroupGUID, lmtError);
          Application.ProcessMessages;
          // ���������� � ������ ������ ��� ���������� ������� � ��������� ������� �����������
          Do_Disconnect;
          Timer2Timer(nil);
        end
      else
        LogThis('��������� ��������� ��� ������.', LogGroupGUID, lmtInfo);
      Update_QuantityOfMessagesStrings;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Configuration;
const
  LogGroupGUID: string='{8B1B9E56-2345-4401-B4C2-5156EC4DE468}';
  sModalWinName: string='�������� ���������';
var
  iBusy: integer;
begin
  ProcedureHeader('��������� ����������� ���� '+sModalWinName, LogGroupGUID);

  with TConfigurationForm.Create(Self) do
    try
      ImageList1.GetIcon(ICON_CONFIGURATION, Icon);
      // ������ "������ � ���� ������"
      edbxMySQLHost.Text:=WideString(Configuration.LogServer.sMySQLHost);
      edbxMySQLHost.Enabled:=not Configuration.LogServer.bConnected;
      edbxMySQLPort.Text:=IntToStr(Configuration.LogServer.iMySQLPort);
      edbxMySQLPort.Enabled:=not Configuration.LogServer.bConnected;
      edbxMySQLTimeout.Text:=IntToStr(Configuration.LogServer.iMySQLTimeout);
      edbxMySQLTimeout.Enabled:=not Configuration.LogServer.bConnected;
      chkbxMySQLCompress.Checked:=Configuration.LogServer.bMySQLCompress;
      chkbxMySQLCompress.Enabled:=not Configuration.LogServer.bConnected;
      edbxMySQLDatabase.Text:=WideString(Configuration.LogServer.sMySQLDatabase);
      edbxMySQLDatabase.Enabled:=not Configuration.LogServer.bConnected;
      edbxMySQLUser.Text:=WideString(Configuration.LogServer.sMySQLUser);
      edbxMySQLUser.Enabled:=not Configuration.LogServer.bConnected;
      edbxMySQLPassword.Text:=WideString(Configuration.LogServer.sMySQLPassword);
      edbxMySQLPassword.Enabled:=not Configuration.LogServer.bConnected;
      // ������ "���������"
      chkbxAlwaysShowTrayIcon.Checked:=Configuration.bAlwaysShowTrayIcon;
      chkbxCustomHelpFile.Checked:=Configuration.sCustomHelpFile<>'';
      edbxCustomHelpFile.Text:=Configuration.sCustomHelpFile;
      edbxCustomHelpFile.Enabled:=chkbxCustomHelpFile.Checked;
      btnChoiseCustomHelpFile.Enabled:=chkbxCustomHelpFile.Checked;
      Configuration.bFullScreen:=MainForm.WindowState=wsMaximized;
      chkbxFullScreen.Checked:=Configuration.bFullScreen;
      cbMainFormAlignment.ItemIndex:=Integer(Configuration.bBottomMainFormAlignment);
      edbxMainFormHeight.Enabled:=not chkbxFullScreen.Checked;
      edbxMainFormHeight.Text:=Routines_GetConditionalMessage(edbxMainFormHeight.Enabled, IntToStr(Configuration.iMainFormHeight), '');
      // ������ "����������������"
      chkbxKeepErrorLog.Checked:=Configuration.bKeepErrorLog;
      chkbxKeepWarningLog.Checked:=Configuration.bKeepWarningLog;
      chkbxKeepInfoLog.Checked:=Configuration.bKeepInfoLog;
      chkbxKeepSQLLog.Checked:=Configuration.bKeepSQLLog;
      chkbxFlushLogOnExit.Checked:=Configuration.bFlushLogOnExit;
      chkbxFlushLogOnStringsQuantity.Checked:=Configuration.iFlushLogOnStringsQuantity>0;
      edbxFlushLogOnStringsQuantity.Enabled:=chkbxFlushLogOnStringsQuantity.Checked;
      edbxFlushLogOnStringsQuantity.Text:=Routines_GetConditionalMessage(chkbxFlushLogOnStringsQuantity.Checked, IntToStr(Configuration.iFlushLogOnStringsQuantity), '');
      chkbxFlushLogOnClearingLog.Checked:=Configuration.bFlushLogOnClearingLog;
      chkbxFlushLogOnApply.Checked:=False;

      PreShowModal(sModalWinName, LogGroupGUID, iBusy);
      ShowModal;
    finally
      PostShowModal(sModalWinName, LogGroupGUID, iBusy);
      if ModalResult=mrOk then
        begin
          LogThis('���� ����������� ������� ���������� �������� ���������.', LogGroupGUID, lmtInfo);
          // ������ "������ � ���� ������"
          if not Configuration.LogServer.bConnected then
            begin
              Configuration.LogServer.sMySQLHost:=edbxMySQLHost.Text;
              Configuration.LogServer.iMySQLPort:=StrToIntDef(edbxMySQLPort.Text, 3306);
              Configuration.LogServer.iMySQLTimeout:=StrToIntDef(edbxMySQLTimeout.Text, 30);
              Configuration.LogServer.bMySQLCompress:=chkbxMySQLCompress.Checked;
              Configuration.LogServer.sMySQLDatabase:=edbxMySQLDatabase.Text;
              Configuration.LogServer.sMySQLUser:=AnsiString(edbxMySQLUser.Text);
              Configuration.LogServer.sMySQLPassword:=AnsiString(edbxMySQLPassword.Text);
            end;
          // ������ "���������"
          Configuration.bAlwaysShowTrayIcon:=chkbxAlwaysShowTrayIcon.Checked;
          TrayIcon1.Visible:=Configuration.bAlwaysShowTrayIcon or(not MainForm.Visible);
          Configuration.sCustomHelpFile:=Routines_GetConditionalMessage(chkbxCustomHelpFile.Checked and FileExists(edbxCustomHelpFile.Text), edbxCustomHelpFile.Text, '');
          Application.HelpFile:=Routines_GetConditionalMessage(Configuration.sCustomHelpFile<>'', Configuration.sCustomHelpFile, Application.HelpFile);
          Configuration.iMainFormHeight:=StrToIntDef(edbxMainFormHeight.Text, 200);
          if Configuration.iMainFormHeight>Screen.WorkAreaHeight then
            Configuration.iMainFormHeight:=Screen.WorkAreaHeight;
          if Configuration.iMainFormHeight<200 then
            Configuration.iMainFormHeight:=200;
          Configuration.bBottomMainFormAlignment:=cbMainFormAlignment.ItemIndex=1;
          Configuration.bFullScreen:=chkbxFullScreen.Checked and chkbxFullScreen.Enabled;
          Update_MainFormPosition;
          // ������ "����������������"
          Configuration.bKeepErrorLog:=chkbxKeepErrorLog.Checked and chkbxKeepErrorLog.Enabled;
          Configuration.bKeepWarningLog:=chkbxKeepWarningLog.Checked and chkbxKeepWarningLog.Enabled;
          Configuration.bKeepInfoLog:=chkbxKeepInfoLog.Checked and chkbxKeepInfoLog.Enabled;
          Configuration.bKeepSQLLog:=chkbxKeepSQLLog.Checked and chkbxKeepSQLLog.Enabled;
          Configuration.bFlushLogOnExit:=chkbxFlushLogOnExit.Checked;
          Configuration.bFlushLogOnClearingLog:=chkbxFlushLogOnClearingLog.Checked;
          if chkbxFlushLogOnStringsQuantity.Checked and(StrToIntDef(edbxFlushLogOnStringsQuantity.Text, -1)>0) then
            Configuration.iFlushLogOnStringsQuantity:=StrToIntDef(edbxFlushLogOnStringsQuantity.Text, -1)
          else
            Configuration.iFlushLogOnStringsQuantity:=-1;
          // ���� ���� �� ������� ������ "���������" (���� ���� �������� ������ �����)
          if chkbxFlushLogOnApply.Checked then
            Do_FlushLogToFile;
          LogThis('���������� �������� ��������� �������.', LogGroupGUID, lmtInfo);
        end
      else
        LogThis('������� ��������� ��������� �� ����.', LogGroupGUID, lmtWarning);
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_LoadConfigIni;
const
  LogGroupGUID: string='{6DA78F21-CF66-4E35-AA7E-8D8AEE98A08F}';
begin
  ProcedureHeader('��������� �������� ������������ ��������� �� ����� INI', LogGroupGUID);

  with TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper.ini') do
    try
      // ������ "������ � ���� ������"
      Configuration.LogServer.sMySQLHost:=ReadString('������ � ���� ������', 'sMySQLHost', '');
      Configuration.LogServer.iMySQLPort:=ReadInteger('������ � ���� ������', 'iMySQLPort', MYSQL_PORT);
      Configuration.LogServer.iMySQLTimeout:=ReadInteger('������ � ���� ������', 'iMySQLTimeout', 30);
      Configuration.LogServer.bMySQLCompress:=ReadBool('������ � ���� ������', 'bMySQLCompress', True);
      Configuration.LogServer.sMySQLDatabase:=ReadString('������ � ���� ������', 'sMySQLDatabase', '');
      Configuration.LogServer.sMySQLUser:=AnsiString(ReadString('������ � ���� ������', 'sMySQLUser', ''));
      Configuration.LogServer.sMySQLPassword:=AnsiString(ReadString('������ � ���� ������', 'sMySQLPassword', ''));
      // ������ "���������"
      Configuration.bAlwaysShowTrayIcon:=ReadBool('���������', 'bAlwaysShowTrayIcon', False);
      Configuration.sCustomHelpFile:=ReadString('���������', 'sCustomHelpFile', '');
      Configuration.iMainFormHeight:=ReadInteger('���������', 'iMainFormHeight', 200);
      Configuration.bFullScreen:=ReadBool('���������', 'bFullScreen', False);
      Configuration.bBottomMainFormAlignment:=ReadBool('���������', 'bBottomMainFormAlignment', True);
      Configuration.bNoStatusBar:=ReadBool('���������', 'bNoStatusBar', False);
      // ������ "����������������"
      Configuration.bKeepErrorLog:=ReadBool('����������������', 'bKeepErrorLog', True);
      Configuration.bKeepWarningLog:=ReadBool('����������������', 'bKeepWarningLog', True);
      Configuration.bKeepInfoLog:=ReadBool('����������������', 'bKeepInfoLog', True);
      Configuration.bKeepSQLLog:=ReadBool('����������������', 'bKeepSQLLog', True);
      Configuration.bFlushLogOnExit:=ReadBool('����������������', 'bFlushLogOnExit', True);
      Configuration.iFlushLogOnStringsQuantity:=ReadInteger('����������������', 'iFlushLogOnStringsQuantity', 10000);
      Configuration.bFlushLogOnClearingLog:=ReadBool('����������������', 'bFlushLogOnClearingLog', True);

      LogThis('������������ ������� �������.', LogGroupGUID, lmtInfo);
    finally
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_SaveConfigIni;
const
  LogGroupGUID: string='{1EFB79E2-7C1D-4A66-8DF4-8F7C7C4764C9}';
begin
  ProcedureHeader('��������� ���������� ������������ ��������� � ���� INI', LogGroupGUID);

  with TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper.ini') do
    try
      try
        // ������ "������ � ���� ������"
        WriteString('������ � ���� ������', 'sMySQLHost', string(Configuration.LogServer.sMySQLHost));
        WriteInteger('������ � ���� ������', 'iMySQLPort', Configuration.LogServer.iMySQLPort);
        WriteInteger('������ � ���� ������', 'iMySQLTimeout', Configuration.LogServer.iMySQLTimeout);
        WriteBool('������ � ���� ������', 'bMySQLCompress', Configuration.LogServer.bMySQLCompress);
        WriteString('������ � ���� ������', 'sMySQLDatabase', string(Configuration.LogServer.sMySQLDatabase));
        WriteString('������ � ���� ������', 'sMySQLUser', string(Configuration.LogServer.sMySQLUser));
        WriteString('������ � ���� ������', 'sMySQLPassword', string(Configuration.LogServer.sMySQLPassword));
        // ������ "���������"
        WriteBool('���������', 'bAlwaysShowTrayIcon', Configuration.bAlwaysShowTrayIcon);
        WriteString('���������', 'sCustomHelpFile', Configuration.sCustomHelpFile);
        WriteInteger('���������', 'iMainFormHeight', Configuration.iMainFormHeight);
        WriteBool('���������', 'bFullScreen', Configuration.bFullScreen);
        WriteBool('���������', 'bBottomMainFormAlignment', Configuration.bBottomMainFormAlignment);
        WriteBool('���������', 'bNoStatusBar', Configuration.bNoStatusBar);
        // ������ "����������������"
        WriteBool('����������������', 'bKeepErrorLog', Configuration.bKeepErrorLog);
        WriteBool('����������������', 'bKeepWarningLog', Configuration.bKeepWarningLog);
        WriteBool('����������������', 'bKeepInfoLog', Configuration.bKeepInfoLog);
        WriteBool('����������������', 'bKeepSQLLog', Configuration.bKeepSQLLog);
        WriteBool('����������������', 'bFlushLogOnExit', Configuration.bFlushLogOnExit);
        WriteInteger('����������������', 'iFlushLogOnStringsQuantity', Configuration.iFlushLogOnStringsQuantity);
        WriteBool('����������������', 'bFlushLogOnClearingLog', Configuration.bFlushLogOnClearingLog);

        LogThis('������������ ��������� �������.', LogGroupGUID, lmtInfo);
      except
        on EIniFileException do
          ShowErrorBox(Handle, '�������� ������ ��� ������� ���������� ������������ � INI-�����! ���������� � ��������������!', LogGroupGUID);
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
  // ��������� �� ���������� ���������� ��������� - � ����� ����������� ���� ��������� ��������
  // ProcedureHeader('��������� ����������� ��������� �� MySQL-������ �� ����� �������',LogGroupGUID,False,False);
  if (ListBox1.Items.Count>0)and Configuration.LogServer.bConnected then
    Do_TransferMessageToDB;
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
// const
// LogGroupGUID: string = '{9B0F5A08-CBA4-4993-8456-F944F6D289AD}';
begin
  // ��������� �� ���������� ���������� ��������� - � ����� ����������� ���� ��������� ��������
  // ProcedureHeader('��������� ����������� ������ ����������� ��������� � ������ �������',LogGroupGUID,False,False);
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.pmLogPopup(Sender: TObject);
const
  LogGroupGUID: string='{55CC897A-D7E5-4F1A-9C57-47886044EBAD}';
var
  b: boolean;
begin
  ProcedureHeader('��������� ��������� ��������� ����������� ��� �������� ���������� ���� ������ ��������� ���������', LogGroupGUID);

  b:=False;
  Action_CopyLogStringToClipboard.Enabled:=(lvLog.Items.Count>0)and(lvLog.Selected<>nil);
  Action_FindPreviousWithSuchGUID.Enabled:=(lvLog.Items.Count>0)and(lvLog.Selected<>nil);
  Action_FindNextWithSuchGUID.Enabled:=(lvLog.Items.Count>0)and(lvLog.Selected<>nil);
  if lvLog.Selected<>nil then
    if lvLog.Selected.ImageIndex=ICON_SQL then
      if lvLog.Selected.SubItems.Count=4 then
        b:=(Trim(lvLog.Selected.SubItems[3]))>'';
  Action_CopySQLFromLogToClipboard.Enabled:=b;
  Action_FindSpecifiedGUID.Enabled:=lvLog.Items.Count>0;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.pmMsgPopup(Sender: TObject);
const
  LogGroupGUID: string='{C6A61024-12A8-4D8F-9333-60A4C5A2FAE5}';
var
  b: boolean;
  sl: TStringList;
begin
  ProcedureHeader('��������� ��������� ��������� ����������� ��� �������� ���������� ���� ������ ���������� ���������', LogGroupGUID);
  b:=False;

  with ListBox1 do
    begin
      Action_CopyMsgStringToClipboard.Enabled:=(Count>0)and(ItemIndex>=0);
      if (Count>0)and(ItemIndex>=0) then
        begin
          sl:=TStringList.Create;
          try
            Routines_CutStringByLimiterToStringList(Items[ItemIndex], sl, #09);
            if Trim(sl[0])='SQL' then
              if sl.Count=7 then
                b:=Trim(sl[6])>'';
          finally
            sl.Free;
          end;
        end;
      Action_CopySQLFromMsgToClipboard.Enabled:=b;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{064A508A-27A0-468A-9A65-D6D006F9E113}';
var
  s: string;
  PanelRect: TRect;
begin
  bFirstRun:=True;
  // ��������������� ��������� ���������� ����������� ������������ ����� ��������� ������ ���������
  Configuration.bKeepErrorLog:=True;
  Configuration.bKeepWarningLog:=True;
  Configuration.bKeepInfoLog:=True;
  Configuration.bKeepSQLLog:=True;

  ProcedureHeader('��������� �������� ������� �����', LogGroupGUID);

  LogThis(PChar('������������ ����������� ������� ���������...'), LogGroupGUID, lmtInfo);
  msgLogKeeperServer:=RegisterWindowMessage('msgLogKeeperServer');
  msgLogKeeperClient:=RegisterWindowMessage('msgLogKeeperClient');

  LogThis(PChar('������������ ������������� ���������� ����������...'), LogGroupGUID, lmtInfo);
  Configuration.LogServer.bConnected:=False;
  Configuration.wExitCicleCounter:=0;
  MainForm.Visible:=False;
  TrayIcon1.Visible:=True;

  LogThis(PChar('������������ ��������� ���������� ���������� � ������ ������� ���������...'), LogGroupGUID, lmtInfo);
  THackControl(pbMain).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
  pbMain.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right-PanelRect.Left, PanelRect.Bottom-PanelRect.Top);
  THackControl(Image1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
  Image1.SetBounds(PanelRect.Left+1, PanelRect.Top+1, PanelRect.Right-PanelRect.Left+1, PanelRect.Bottom-PanelRect.Top+1);

  LogThis(PChar('������������ �������� ������� ����� �������...'), LogGroupGUID, lmtInfo);
  if not(FileExists(ExpandFileName(Application.HelpFile))) then
    begin
      Action_Help.Enabled:=False;
      Action_Help.Visible:=False;
    end;

  LogThis(PChar('������������ ��������� ����� ���������� �����...'), LogGroupGUID, lmtInfo);
  Configuration.sLocalHost:=Routines_GetLocalIP;
  LogThis(PChar('��� ���������� �����: '+Configuration.sLocalHost+'.'), LogGroupGUID, lmtInfo);

  LogThis(PChar('������������ ���������� �� ����� ����� ������������ �� ������� ���������...'), LogGroupGUID, lmtInfo);
  s:=ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper_UnsendedMessages.dat';
  if FileExists(s) then
    begin
      ListBox1.Items.LoadFromFile(s);
      DeleteFile(s);
      LogThis(PChar('��������� ���� ������� ������� � ��������� � ������ ���������.'), LogGroupGUID, lmtInfo);
    end
  else
    LogThis(PChar('���� �� ��� ���������.'), LogGroupGUID, lmtInfo);

  LogThis(PChar('������������ ���������� ������������ ��������� �� ini-�����...'), LogGroupGUID, lmtInfo);
  Do_LoadConfigIni;

  LogThis(PChar('������������ ������������� ��������� � �������� �������� ���� ���������...'), LogGroupGUID, lmtInfo);
  Update_MainFormPosition;

  LogThis(PChar('������������ ������������� ������ �������...'), LogGroupGUID, lmtInfo);
  miStatusbar.Checked:=not Configuration.bNoStatusBar;
  StatusBar1.Visible:=miStatusbar.Checked;
  Update_QuantityOfMessagesStrings;
  Update_QuantityOfLogStrings;
  Application.ProcessMessages;

  LogThis(PChar('������������ ������ ��������...'), LogGroupGUID, lmtInfo);
  ExitTimer.Enabled:=True;
  Timer2Timer(Sender);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{3EBF0749-B2FF-4AD4-9633-5BCC8A8DE5FD}';
begin
  ProcedureHeader('���������-���������� ������� ����������� ����', LogGroupGUID);

  if bFirstRun then
    begin
      iBusyCounter:=0;
      bFirstRun:=False;
    end;
  Refresh_BusyState(LogGroupGUID);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.lvLogCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  lvLog.Canvas.Font.Color:=clBlack;
end;

procedure TMainForm.lvLogCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  lvLog.Canvas.Font.Color:=clBlack;
  if SubItem=1 then
    if Length(Item.SubItems[0])=38 then
      lvLog.Canvas.Font.Color:=StringToColor('$'+Copy(Item.SubItems[0], 2, 6));
end;

procedure TMainForm.Update_ConnectionAction;
const
  LogGroupGUID: string='{8BE4E5AD-0DC6-4937-81BD-BC7009C6CD52}';
begin
  ProcedureHeader('��������� ���������� ��������� �������� ���������� � MySQL-��������', LogGroupGUID);

  Action_Connect.Enabled:=not Configuration.LogServer.bConnected;
  Action_Connect.Visible:=Action_Connect.Enabled;
  Action_Disconnect.Enabled:=not Action_Connect.Enabled;
  Action_Disconnect.Visible:=Action_Disconnect.Enabled;
  LogThis(PChar('�������� "'+Action_Connect.Caption+'" '+Routines_GetConditionalMessage(Action_Connect.Enabled, '�', '��')+'�������, �������� "'+Action_Disconnect.Caption+'" '+Routines_GetConditionalMessage(Action_Connect.Enabled, '�',
        '��')+'�������.'), LogGroupGUID, lmtInfo);
  Application.ProcessMessages;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_QuantityOfMessagesStrings;
begin
  if StatusBar1.Panels[STATUSBAR_MESSAGES_COUNT_PANEL_NUMBER].Text<>'���������: '+IntToStr(ListBox1.Items.Count) then
    begin
      StatusBar1.Panels[STATUSBAR_MESSAGES_COUNT_PANEL_NUMBER].Text:='���������: '+IntToStr(ListBox1.Items.Count);
      StatusBar1.Panels[STATUSBAR_MESSAGES_COUNT_PANEL_NUMBER].Width:=StatusBar1.Canvas.TextWidth(StatusBar1.Panels[STATUSBAR_MESSAGES_COUNT_PANEL_NUMBER].Text)+14;
    end;
end;

procedure TMainForm.Update_QuantityOfLogStrings;
begin
  if StatusBar1.Panels[STATUSBAR_LOG_COUNT_PANEL_NUMBER].Text<>'��������: '+IntToStr(lvLog.Items.Count) then
    begin
      StatusBar1.Panels[STATUSBAR_LOG_COUNT_PANEL_NUMBER].Text:='��������: '+IntToStr(lvLog.Items.Count);
      StatusBar1.Panels[STATUSBAR_LOG_COUNT_PANEL_NUMBER].Width:=StatusBar1.Canvas.TextWidth(StatusBar1.Panels[STATUSBAR_LOG_COUNT_PANEL_NUMBER].Text)+10;
    end;
end;

procedure TMainForm.Update_MainFormPosition;
const
  LogGroupGUID: string='{E2B76FBF-AE4B-41BA-936D-33F99378F624}';
begin
  ProcedureHeader('��������� ���������� �������� ��������� � �������� �������� ���� ���������', LogGroupGUID);

  if MainForm.WindowState=wsMaximized then
    MainForm.WindowState:=wsNormal;
  MainForm.Width:=Screen.WorkAreaWidth; // ��������� ������ ���� � ������ �������� �����
  MainForm.Height:=Configuration.iMainFormHeight; // ��������� ������ ����
  MainForm.Left:=Screen.WorkAreaLeft; // ��������� ������ ���� � ������� ����� ����� �������� �����
  if Configuration.bBottomMainFormAlignment then // ��������� ���� � ����� �������
    MainForm.Top:=Screen.WorkAreaHeight-MainForm.Height
  else
    MainForm.Top:=Screen.WorkAreaTop;
  LogThis('����������� ��������� ���������� � ������� �������� ����: X='+IntToStr(MainForm.Left)+', Y='+IntToStr(MainForm.Top)+', W='+IntToStr(MainForm.Width)+', H='+IntToStr(MainForm.Height)+'.', LogGroupGUID, lmtInfo);
  if Configuration.bFullScreen then // ������������ ���� ��� ������� ������������ �����
    begin
      MainForm.Position:=poDesigned;
      MainForm.WindowState:=wsMaximized;
      LogThis('������� ���� ���� ��������������� � ������������ � �����������.', LogGroupGUID, lmtInfo);
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
const
  LogGroupGUID: string='{E6FB9B6A-DA74-45B3-B11C-07D35052C1CD}';
var
  i: integer;
begin
  ProcedureHeader('���������-���������� ���������� ������ ���������', LogGroupGUID);

  if not((Configuration.bInterraptionInitiated)and(Configuration.wExitCicleCounter>=EXIT_COUNTER_MAX)) then
    begin
      LogThis('���������� ������ �������� ������ � �������� ���������� ���������� ���������. ����� ��������� ����������� �������� ����.', LogGroupGUID, lmtWarning);
      Do_MinimizeMainForm;
      CanClose:=False;
    end
  else
    begin
      if Configuration.LogServer.bConnected then
        begin
          LogThis('������������ ������� �������� ���������� ��������� �� MySQL-������...', LogGroupGUID, lmtInfo);
          for i:=0 to ListBox1.Items.Count-1 do
            if Configuration.LogServer.bConnected then
              Do_TransferMessageToDB;
        end;
      if ListBox1.Items.Count>0 then
        begin
          LogThis('������������ ������ ������������ �� MySQL-������ ��������� � ����...', LogGroupGUID, lmtInfo);
          ListBox1.Items.SaveToFile(ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper_UnsendedMessages.dat');
        end;
      LogThis('������������ ���������� �� MySQL-�������...', LogGroupGUID, lmtInfo);
      Do_Disconnect;
      LogThis('������������ ������ ������������...', LogGroupGUID, lmtInfo);
      Do_SaveConfigIni;
      if Configuration.bFlushLogOnExit then
        begin
          LogThis('������������ ������ ��������� ��������� � ����...', LogGroupGUID, lmtInfo);
          Do_FlushLogToFile;
        end;
    end;
  LogThis('������������ ��������� ����� ��������� ������...', LogGroupGUID, lmtInfo);
  Configuration.bInterraptionInitiated:=True; // ���������� ���� ��������� ������ �� ��������� �� ������� ������ ������

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
const
  LogGroupGUID: string='{6A2082B1-5186-4D83-896B-25AC87AF224E}';
begin
  // ������ ��������� �� ������� ���������� ��������� !!!!
  // ProcedureHeader('��������� ��������� ��������� �������� ���������', LogGroupGUID);

  if Msg.message=msgLogKeeperServer then
    begin
      // LogThis('������ ����� �� ���������� ����������������� ���������.',LogGroupGUID,lmtWarning);
      PostMessage(Msg.wParam, msgLogKeeperServer, Handle, 0);
      Configuration.wExitCicleCounter:=0; // �������� ������� �������� ������� �������� ����� �������, �.�. ���� �������� ��������� �� ����� �� ���������� ��������
      Handled:=True;
    end;
  if Msg.message=msgLogKeeperClient then
    begin
      // LogThis('������� ����� �� ��������� ����� ����������������� ���������.',LogGroupGUID,lmtWarning);
      Configuration.bInterraptionInitiated:=False; // ��������� ����� �� ��������� ��� ���������� ��������
      if Configuration.wExitCicleCounter>1 then
        LogThis('��������� ������ �� ��������� �������� ������ � ���������� ������ �� ���������� ��������� �� '+IntToStr(Configuration.wExitCicleCounter*(word(ExitTimer.Interval div 1000)))+' ���.', LogGroupGUID, lmtWarning);
      Configuration.wExitCicleCounter:=0; // �������� ������� �������� ������� �������� ����� �������, �.�. ��� ������� ����� �� ����� �� ���������� ��������
      Handled:=True;
    end;

  // ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ExitTimerTimer(Sender: TObject);
const
  LogGroupGUID: string='{1AD5F1D9-046C-4665-AF5D-F6702E639C55}';
begin
  // ������ ��������� �� ������� ���������� ��������� !!!!
  // ProcedureHeader('��������� ������������ ������� ��������� �������� � ��������� ���������� � ������ ���������� �������', LogGroupGUID);

  if Configuration.bInterraptionInitiated then
    LogThis('��� ����������� ����� �� ���������! �� ������ �������� '+IntToStr((EXIT_COUNTER_MAX-Configuration.wExitCicleCounter)*(word(ExitTimer.Interval div 1000)))+' ���.', LogGroupGUID, lmtWarning)
  else
    if Configuration.wExitCicleCounter>0 then
      LogThis('�� ���� ���������� ��������� �� ���� ������ �� �����! �� ������ �������� '+IntToStr((EXIT_COUNTER_MAX-Configuration.wExitCicleCounter)*(word(ExitTimer.Interval div 1000)))+' ���.', LogGroupGUID, lmtWarning);
  if Configuration.wExitCicleCounter=EXIT_COUNTER_MAX then
    begin
      if Configuration.bInterraptionInitiated then
        LogThis('������������ ���������� ������ ��������� ������ � �������� ������ �������������.', LogGroupGUID, lmtInfo)
      else
        LogThis('������������ ���������� ������ ��������� ������ � ����������� ���������� ��������.', LogGroupGUID, lmtInfo);
    end;
  if Configuration.wExitCicleCounter<EXIT_COUNTER_MAX then
    begin
      Configuration.wExitCicleCounter:=Configuration.wExitCicleCounter+1;
      BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, msgLogKeeperClient, Handle, 0); // �������� ������������� ��������� ��� ��������� �������� ������� ��������
    end
  else
    begin
      Configuration.bInterraptionInitiated:=True;
      ExitTimer.Enabled:=False;
      Do_Close; // ����� ��� ���������� ��������� ��������� ��������� "�������" ��������� ��� ���������� ��������
    end;

  // ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Timer2Timer(Sender: TObject);
const
  LogGroupGUID: string='{DA1C328A-D622-45EB-B608-26313DA8524A}';
begin
  ProcedureHeader('��������� ������� �� ������������ ������� �������������� �� ��������� ����������� � MySQL-�������', LogGroupGUID);

  if Configuration.LogServer.bConnected then // // ���� ��� ���� ����������� ����������
    Timer2.Enabled:=False // ��������� ������� ����� �����������
  else
    begin // ���� ���
      with TSendDataToMySQLServerThread.Create('{93BCFE4A-99DB-4E09-BA2B-A4E9CE38F48E}', Configuration) do
        try
          Start;
        except
          on Exception do
            ;
          // Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
        end;
      Timer2.Enabled:=True; // �������� ������
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.WMCopyData(var Msg: TWMCopyData);
const
  LogGroupGUID: string='{8EDBC4A1-DFFF-46DF-82D5-B8AB3F161848}';
var
  cText: array [0..51200] of AnsiChar;
  MessageType: TLogMessagesType;
  sl: TStringList;
  bError: boolean;
  sErrorMessage: string;
begin
  // ProcedureHeader('��������� ��������� ������ �� �������� ��������', LogGroupGUID);
  MessageType:=lmtError;

  StrLCopy(cText, Msg.CopyDataStruct.lpData, Msg.CopyDataStruct.cbData);
  LogThis(PChar('������, ��������� �� �������� ��������: ['+cText+']'), LogGroupGUID, lmtDebug);

  if Msg.From=HWND(MainForm.Handle) then
    begin
      sl:=TStringList.Create;
      try
        Routines_CutStringByLimiterToStringList(string(AnsiString(cText)), sl, ';');
        if sl.Count=4 then
          begin
            if (sl[0]=IntToStr(WMCD_THREADLOG))and((sl[1]='ERROR')or(sl[1]='WARNING')or(sl[1]='INFO')or(sl[1]='SQL')or(sl[1]='DEBUG')) then
              begin
                if sl[1]='ERROR' then
                  MessageType:=lmtError
                else
                  if sl[1]='WARNING' then
                    MessageType:=lmtWarning
                  else
                    if sl[1]='INFO' then
                      MessageType:=lmtInfo
                    else
                      if sl[1]='SQL' then
                        MessageType:=lmtSQL
                      else
                        if sl[1]='DEBUG' then
                          MessageType:=lmtDebug;
                LogThis(sl[2], sl[3], MessageType);
              end
            else
              Routines_GenerateError('��������� ������ ��� ����������� ������ ������ ����, ���������� �� ��������� ������!', sErrorMessage, bError);
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

{ TODO: ���������� ��������� � ������ ��������� ������� overseer }

end.

// �������� ���������� �������� ����������!!!
