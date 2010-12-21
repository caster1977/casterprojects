{$WARN UNIT_PLATFORM OFF}
{$WARN SYMBOL_PLATFORM OFF}
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
  ActnList,
  ExtCtrls,
  ComCtrls,
  AppEvnts,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  ImgList,
  Menus,
  getFVI,
  XPStyleActnCtrls,
  mysql,
  StdCtrls,
  CheckLst,
  IdBaseComponent,
  IdComponent,
  IdUDPBase,
  IdUDPClient,
  IdTrivialFTP,
  WinInet,
  OverseerConsts,
  OverseerTypes,
  OverseerRoutines,
  ListViewEx;

type
  THackControl=class(TControl);

  TMainForm=class(TForm)
    MainMenu1: TMainMenu;
    ImageList1: TImageList;
    ApplicationEvents1: TApplicationEvents;
    StatusBar1: TStatusBar;
    pbMain: TProgressBar;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_About: TAction;
    Action_Quit: TAction;
    Action_Restore: TAction;
    TrayIcon1: TTrayIcon;
    pmTray: TPopupMenu;
    ActionRestore1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    O1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    O2: TMenuItem;
    pnlLog: TPanel;
    pnlConnectedMode: TPanel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    cbActionsList: TComboBox;
    PageControl1: TPageControl;
    ts_SIC_09: TTabSheet;
    gb_SIC_09: TGroupBox;
    lbPhoneNet_SIC_09: TLabel;
    cbPhoneNet_SIC_09: TComboBox;
    btnSelectAllServices_SIC_09: TButton;
    btnUnselectAllServices_SIC_09: TButton;
    ts_SIC_02: TTabSheet;
    gb_SIC_02: TGroupBox;
    ts_SIC_07: TTabSheet;
    ts_SIC_03: TTabSheet;
    gb_SIC_07: TGroupBox;
    Action_Logon: TAction;
    Action_Logout: TAction;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    Action_Configuration: TAction;
    N14: TMenuItem;
    miStatusbar: TMenuItem;
    N17: TMenuItem;
    Action_Accounts: TAction;
    Image1: TImage;
    btnProcess: TButton;
    Action_MaximizeLogPanel: TAction;
    Action_RestoreLogPanel: TAction;
    pmLog: TPopupMenu;
    N23: TMenuItem;
    N24: TMenuItem;
    GroupBox7: TGroupBox;
    Panel5: TPanel;
    btnMaximazeLogPanel: TButton;
    btnRestoreLogPanel: TButton;
    Action_Process: TAction;
    miActions: TMenuItem;
    N26: TMenuItem;
    Timer2: TTimer;
    N31: TMenuItem;
    pnlMain: TPanel;
    gb_SIC_03: TGroupBox;
    lbPhoneNet_SIC_03: TLabel;
    cbPhoneNet_SIC_03: TComboBox;
    N15: TMenuItem;
    Action_OpenReportsFolder: TAction;
    N32: TMenuItem;
    Action_CopySQLFromLogToClipboard: TAction;
    Action_ClearLogList: TAction;
    Action_CopyLogStringToClipboard: TAction;
    Action_FindPreviousWithSuchGUID: TAction;
    Action_FindNextWithSuchGUID: TAction;
    Action_CopyGUIDStringToClipboard: TAction;
    Action_FindSpecifiedGUID: TAction;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    SQL1: TMenuItem;
    GUID1: TMenuItem;
    N36: TMenuItem;
    GUID2: TMenuItem;
    GUIDF21: TMenuItem;
    GUIDF31: TMenuItem;
    N16: TMenuItem;
    N22: TMenuItem;
    Timer1: TTimer;
    TabSheet7: TTabSheet;
    gb_XRD: TGroupBox;
    cbRecreateXRD: TCheckBox;
    gbGroupingPeriod: TGroupBox;
    rbGroupByYears: TRadioButton;
    rbGroupByQuarters: TRadioButton;
    rbGroupByMonths: TRadioButton;
    rbGroupByWeeks: TRadioButton;
    rbGroupByDays: TRadioButton;
    rbGroupByHours: TRadioButton;
    GroupBox2: TGroupBox;
    rbLastDate: TRadioButton;
    rbLastWeek: TRadioButton;
    rbLastMonth: TRadioButton;
    rbLastQuarter: TRadioButton;
    rbLastYear: TRadioButton;
    rbChoisenYear: TRadioButton;
    cbChoisenQuarter_Year: TComboBox;
    rbChoisenQuarter: TRadioButton;
    cbChoisenYear: TComboBox;
    cbChoisenQuarter_Quarter: TComboBox;
    rbChoisenMonth: TRadioButton;
    cbChoisenMonth_Month: TComboBox;
    cbChoisenMonth_Year: TComboBox;
    rbChoisenDate: TRadioButton;
    dtpChoisenDate: TDateTimePicker;
    cbChoisenPeriod_Start: TDateTimePicker;
    rbChoisenPeriod: TRadioButton;
    cbChoisenPeriod_Stop: TDateTimePicker;
    ebCustomNameOfXRDA: TEdit;
    cbCustomNameOfXRDA: TCheckBox;
    cbRecreateXRDA: TCheckBox;
    Action_ProcessSelectedActions: TAction;
    N25: TMenuItem;
    rbDetailedReport_SIC_02: TRadioButton;
    rbSortedReport_SIC_02: TRadioButton;
    ts_SIC_05: TTabSheet;
    gb_SIC_05: TGroupBox;
    ts_SIC_08: TTabSheet;
    rbIRD: TRadioButton;
    rbORD: TRadioButton;
    cbCreateXRDA: TCheckBox;
    cbWeekStartsFromDayOfBeginning_SIC_05: TCheckBox;
    btnActionComments: TButton;
    cbWeekStartsFromDayOfBeginning_SIC_07: TCheckBox;
    ts_SIC_01: TTabSheet;
    gb_SIC_01: TGroupBox;
    lb_SIC_01: TLabel;
    btnAdd_SIC_01: TButton;
    btnDelete_SIC_01: TButton;
    btnClear_SIC_01: TButton;
    eb_SIC_01: TEdit;
    lv_SIC_01: TListView;
    Action_AddPhones_SIC_01: TAction;
    Action_DeletePhone_SIC_01: TAction;
    Action_ClearPhones_SIC_01: TAction;
    Action_Comments: TAction;
    cbShowUnserved_SIC_01: TCheckBox;
    ts_SIC_04: TTabSheet;
    gb_SIC_04: TGroupBox;
    rbAllUsers_SIC_04: TRadioButton;
    rbSelectedUsers_SIC_04: TRadioButton;
    btnRefreshUserList_SIC_04: TButton;
    cbShowIdleUsers_SIC_04: TCheckBox;
    clbUsers_SIC_04: TCheckListBox;
    btnSelectAllUsers_SIC_04: TButton;
    btnUnselectAllUsers_SIC_04: TButton;
    cbCreateDetailedReport_SIC_04: TCheckBox;
    cbShowSQLQueries_SIC_04: TCheckBox;
    Action_RefreshUserList_SIC_04: TAction;
    cbWeekStartsFromDayOfBeginning_SIC_04: TCheckBox;
    TabSheet1: TTabSheet;
    GroupBox3: TGroupBox;
    btnResfeshCallsList_Payoff: TButton;
    btnSelectAllCalls_Payoff: TButton;
    btnUnselectAllCalls_Payoff: TButton;
    ebPhonesList_Payoff: TEdit;
    lblPhonesNumbers: TLabel;
    Action_RefreshCallsList_Payoff: TAction;
    lvPhonesList_Payoff: TListView;
    lvServices_SIC_09: TListView;
    pm_SIC_09: TPopupMenu;
    Action_SelectAllServices_SIC_09: TAction;
    N18: TMenuItem;
    Action_UnselectAllServices_SIC_09: TAction;
    N19: TMenuItem;
    Action_SelectOralServices_SIC_09: TAction;
    Action_SelectAutoServices_SIC_09: TAction;
    N20: TMenuItem;
    N21: TMenuItem;
    N27: TMenuItem;
    btnSelectOralServices_SIC_09: TButton;
    btnSelectAutoServices_SIC_09: TButton;
    Action_SelectAllUsers_SIC_04: TAction;
    Action_UnselectAllUsers_SIC_04: TAction;
    pm_SIC_04: TPopupMenu;
    N28: TMenuItem;
    N29: TMenuItem;
    pm_Payoff: TPopupMenu;
    Action_SelectAllCalls_Payoff: TAction;
    Action_UnselectAllCalls_Payoff: TAction;
    N30: TMenuItem;
    N37: TMenuItem;
    ts_SIC_10: TTabSheet;
    gb_SIC_10: TGroupBox;
    rbAllUsers_SIC_10: TRadioButton;
    rbSelectedUsers_SIC_10: TRadioButton;
    btnRefreshUserList_SIC_10: TButton;
    clbUsers_SIC_10: TCheckListBox;
    btnSelectAllUsers_SIC_10: TButton;
    btnUnselectAllUsers_SIC_10: TButton;
    cbCreateDetailedReport_SIC_10: TCheckBox;
    cbWeekStartsFromDayOfBeginning_SIC_10: TCheckBox;
    Action_RefreshUserList_SIC_10: TAction;
    Action_SelectAllUsers_SIC_10: TAction;
    Action_UnselectAllUsers_SIC_10: TAction;
    pm_SIC_10: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    Label2: TLabel;
    cbCCID_SIC_10: TComboBox;
    cbService_SIC_05: TComboBox;
    lbService_SIC_05: TLabel;
    cbSummaryReport_SIC_09: TCheckBox;
    PageControl2: TPageControl;
    tsLog: TTabSheet;
    tsActions: TTabSheet;
    lvLog: TListView;
    lvActionList: TListViewEx;
    ilActionList: TImageList;
    pm_ProcessedActions: TPopupMenu;
    cbOldReport_SIC_09: TCheckBox;
    chkbxScrollToLastLogMessage: TCheckBox;
    TabSheet2: TTabSheet;
    GroupBox4: TGroupBox;
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_RestoreExecute(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Action_SelectAllServices_SIC_09Execute(Sender: TObject);
    procedure Action_UnselectAllServices_SIC_09Execute(Sender: TObject);
    procedure Action_LogonExecute(Sender: TObject);
    procedure Action_LogoutExecute(Sender: TObject);
    procedure Action_MaximizeLogPanelExecute(Sender: TObject);
    procedure Action_RestoreLogPanelExecute(Sender: TObject);
    procedure Action_ProcessExecute(Sender: TObject);
    procedure cbActionsListChange(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure lvLogCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure miStatusbarClick(Sender: TObject);
    procedure Action_OpenReportsFolderExecute(Sender: TObject);
    procedure lvLogCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure lvLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Action_CopySQLFromLogToClipboardExecute(Sender: TObject);
    procedure Action_ClearLogListExecute(Sender: TObject);
    procedure Action_CopyLogStringToClipboardExecute(Sender: TObject);
    procedure Action_FindPreviousWithSuchGUIDExecute(Sender: TObject);
    procedure Action_FindNextWithSuchGUIDExecute(Sender: TObject);
    procedure Action_CopyGUIDStringToClipboardExecute(Sender: TObject);
    procedure Action_FindSpecifiedGUIDExecute(Sender: TObject);
    procedure pmLogPopup(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure Action_AccountsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbCustomNameOfXRDAClick(Sender: TObject);
    procedure cbRecreateXRDAClick(Sender: TObject);
    procedure Action_ProcessSelectedActionsExecute(Sender: TObject);
    procedure cbCreateXRDAClick(Sender: TObject);
    procedure TimePeriodChange(Sender: TObject);
    procedure ChangeGroupping(Sender: TObject);
    procedure Action_AddPhones_SIC_01Execute(Sender: TObject);
    procedure Action_DeletePhone_SIC_01Execute(Sender: TObject);
    procedure Action_ClearPhones_SIC_01Execute(Sender: TObject);
    procedure lv_SIC_01SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure eb_SIC_01Change(Sender: TObject);
    procedure Action_CommentsExecute(Sender: TObject);
    procedure cbCreateDetailedReport_SIC_04Click(Sender: TObject);
    procedure rbUsers_SIC_04Click(Sender: TObject);
    procedure Action_RefreshUserList_SIC_04Execute(Sender: TObject);
    procedure Action_RefreshCallsList_PayoffExecute(Sender: TObject);
    procedure ebPhonesList_PayoffChange(Sender: TObject);
    procedure Action_SelectOralServices_SIC_09Execute(Sender: TObject);
    procedure Action_SelectAutoServices_SIC_09Execute(Sender: TObject);
    procedure lvServices_SIC_09ItemChecked(Sender: TObject; Item: TListItem);
    procedure clbUsers_SIC_04ClickCheck(Sender: TObject);
    procedure Action_SelectAllUsers_SIC_04Execute(Sender: TObject);
    procedure Action_UnselectAllUsers_SIC_04Execute(Sender: TObject);
    procedure Action_UnselectAllCalls_PayoffExecute(Sender: TObject);
    procedure Action_SelectAllCalls_PayoffExecute(Sender: TObject);
    procedure lvPhonesList_PayoffItemChecked(Sender: TObject; Item: TListItem);
    procedure clbUsers_SIC_10ClickCheck(Sender: TObject);
    procedure Action_RefreshUserList_SIC_10Execute(Sender: TObject);
    procedure Action_SelectAllUsers_SIC_10Execute(Sender: TObject);
    procedure Action_UnselectAllUsers_SIC_10Execute(Sender: TObject);
    procedure rbUsers_SIC_10Click(Sender: TObject);
    procedure lvActionListEndColumnResize(sender: TCustomListView; columnIndex, columnWidth: Integer);
    procedure lvActionListDividerDblClick(sender: TCustomListView; columnIndex, columnWidth: Integer);
    procedure lvActionListResize(Sender: TObject);
    procedure lvActionListMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure lvActionListScroll(Sender: TCustomListView);
    procedure cbOldReport_SIC_09Click(Sender: TObject);
    procedure cbSummaryReport_SIC_09Click(Sender: TObject);
    procedure chkbxScrollToLastLogMessageClick(Sender: TObject);
    procedure lvActionListInsert(Sender: TObject; Item: TListItem);
    procedure ApplicationEvents1Restore(Sender: TObject);
  private
    dtLastDate: TDate;

    dtLastWeekStart, dtLastWeekStop: TDate;

    dtLastMonthStart, dtLastMonthStop: TDate;
    wLastMonth_Month, wLastMonth_Year: word;

    dtLastQuarterStart, dtLastQuarterStop: TDate;
    wLastQuarter_Quarter, wLastQuarter_Year: word;

    dtLastYearStart, dtLastYearStop: TDate;
    wLastYear: word;

    bAboutWindowExist: boolean;

    // ttsActionStart: TTimeStamp;

    bFirstRun: boolean;

    procedure Save_ConfigIni;
    procedure Load_ConfigIni;
    // procedure Start_ActionTimer(aLogGroupGUID: string);
    // procedure Stop_ActionTimer(aLogGroupGUID: string);

    procedure Update_pnlConnectedMode;
    procedure Update_DateTimeLabels;
    procedure Update_LastDates;
    procedure Update_GroupingState;
    procedure Update_OtherGroupingStateOptions;
    procedure Update_Actions_SIC_01;
    procedure Update_Actions_SIC_04;
    procedure Update_Actions_SIC_09;
    procedure Update_Actions_SIC_10;
    procedure Update_Actions_Payoff;
    procedure Update_PhonesOrderNumbers_SIC_01;
    procedure Update_Actions;
    procedure Update_ProgressBarsInActionsListView;
    procedure Do_About;
    procedure Do_Comments;
    procedure Do_Help;
    procedure Do_RestoreMainForm;
    procedure Do_MinimizeMainForm;
    procedure Do_MaximizeLogPanel;
    procedure Do_ProcessSelectedActions;
    procedure Do_SelectAction;
    procedure Do_OpenReportsFolder;
    procedure Do_Configuration;
    function Do_GetApplicationFolder: string;
    function Do_GetTempFolder: string;
    procedure Do_FindNextWithSuchGUID;
    procedure Do_FindPreviousWithSuchGUID;
    procedure Do_CopySQLFromLogToClipboard;
    procedure Do_CopyLogStringToClipboard;
    procedure Do_CopyGUIDStringToClipboard;
    procedure Do_ClearLogList;
    procedure Do_RestoreLogPanel;
    procedure Do_FindSpecifiedGUID;
    procedure Do_OpenAccountsList;
    procedure Do_Logon;
    procedure Do_Logout;
    procedure Do_AddPhones_SIC_01;
    procedure Do_DeletePhone_SIC_01;
    procedure Do_ClearPhones_SIC_01;
    procedure Do_RefreshUserList_SIC_04;
    procedure Do_RefreshUserList_SIC_10;
    procedure Do_RefreshCallsList_Payoff;
    procedure Do_SelectAllServices_SIC_09;
    procedure Do_SelectOralServices_SIC_09;
    procedure Do_SelectAutoServices_SIC_09;
    procedure Do_UnselectAllServices_SIC_09;
    procedure Do_Process;
    procedure Do_FlushLogToFile;
    function Do_SIC_01(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aPhonesList: TStringList; const aShowUnserved: boolean): boolean;
    function Do_SIC_03(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aNetIndex: integer): boolean;
    function Do_SIC_04(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aCalculateWeekFromMonday, aAllUsers, aCreateDetailedReport, aShowSQLQueries, aShowIdleUsers: boolean;
      const aSelectedUserList: TStringList): boolean;
    function Do_SIC_05(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aServiceIndex: integer; const aCalculateWeekFromMonday: boolean): boolean;
    function Do_SIC_07(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aCalculateWeekFromMonday: boolean): boolean;
    function Do_SIC_08(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean): boolean;
    function Do_SIC_09(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aNetIndex: integer; const aSummaryReport, aOldReport: boolean; const aSelectedServicesList: TStringList): boolean;
    function Do_SIC_10(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aCalculateWeekFromMonday, aAllUsers, aCreateDetailedReport: boolean; const aCCID: integer;
      const aSelectedUserList: TStringList): boolean;
    function Do_ASKR(const aStartDate, aStopDate: TDate): boolean;
    function Do_PayOff(const aPayoffList: TStringList): boolean;
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure LogThis(const aMessage, aLogGroupGIUD: string; aMessageType: TLogMessagesType);
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
    procedure PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
    procedure PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
    procedure StepProgressBar;
  public
    SessionLogEventCount: cardinal;
    msgLogKeeperServer, msgLogKeeperClient: cardinal;
    hLogKeeper: HWND;
    Configuration: TConfigurationRec;
    CurrentUser: TUserRec;
    iBusyCounter: integer;
    function Do_CreateXRDA(const aStartDate, aStopDate: TDate; const aSilentYes: boolean; const aXRD: tXRD; var aTableName: string; const bRecreateXRD: boolean; const bCreateXRDA, bRecreateXRDA: boolean): boolean;
    procedure ShowErrorBox(const aHandle: HWND; const aErrorMessage: string; const aLogGroupGUID: string);
    function Do_SaveReportAsHTMLAndOpen(const aHTML, aFileName: string; const aOpenWithBrowser, aSilentYes: boolean): boolean;
    procedure Inc_BusyState(const aLogGroupGUID: string);
    procedure Dec_BusyState(const aLogGroupGUID: string);
    procedure Refresh_BusyState(const aLogGroupGUID: string);
    procedure _ProgressBarMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure InitProgressBar(const aMax: integer);

    procedure MySQL_UnlockTables(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
    procedure MySQL_CloseConnection(const aLogGroupGUID: string; var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
    procedure MySQL_LockTables(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aTablesList: string);
    procedure MySQL_OpenConnection(const aLogGroupGUID: string; var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
    procedure MySQL_CheckTableExistance(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; const aMySQLDatabase: string; var bError: boolean; var sErrorMessage: string; const aTableName: string);
    procedure MySQL_CreateTable(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
    procedure MySQL_DropTable(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
    function MySQL_InsertRecords(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
    function MySQL_UpdateRecords(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Configuration,
  Accounts,
  About,
  Login,
  FindGIUD,
  Thread_Do_SIC_01,
  Thread_Do_SIC_03,
  Thread_Do_SIC_04,
  Thread_Do_SIC_05,
  Thread_Do_SIC_07,
  Thread_Do_SIC_08,
  Thread_Do_SIC_09,
  Thread_Do_SIC_10,
  Thread_Do_ASKR,
  CommCtrl,
  IniFiles,
  WinSock,
  DateUtils,
  Clipbrd,
  Comments,
  ShellAPI,
  jpeg;

var
  Recipients: DWORD=BSM_APPLICATIONS;

procedure TMainForm.LogThis(const aMessage, aLogGroupGIUD: string; aMessageType: TLogMessagesType);
var
  i: integer;
  ListItem: TListItem;
  s: string;
  m: AnsiString;
  aCopyData: TCopyDataStruct;
begin
  i:=-1;
  SessionLogEventCount:=SessionLogEventCount+1;

  if Configuration.bUseExternalLog then
    begin
      case aMessageType of
        lmtError:
          s:='ERROR  ';
        lmtWarning:
          s:='WARNING';
        lmtInfo:
          s:='INFO   ';
        lmtSQL:
          s:='SQL    ';
        lmtDebug:
          s:='DEBUG  ';
      end;
      m:=AnsiString(Application.ExeName+#09+CurrentUser.sLogin+#09+ // ������� �������������� ������������
        s+#09+ // ��� ���������
        StringReplace(FormatDateTime('dd.mm.yyyy hh:nn:ss', Now), ' ', #09, [rfReplaceAll])+#09+
        // ���� � ����� ���������
        aLogGroupGIUD+#09+StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])+#09+
        // ���������� ����� ���������
        aMessage); // ����� ���������
      // �������� ������� LogKeeper � ��� ������ � ������ ����������
      if IsWindow(hLogKeeper) then
        begin // ���� LogKeeper �������
          with aCopyData do
            begin
              dwData:=0;
              cbData:=Length(m)+1;
              lpData:=PAnsiChar(m);
            end;
          SendMessage(hLogKeeper, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
          // LogThis('����������� �������� ��������� ���-������� ������ ������: ['+m+']', LogGroupGUID, lmtDebug);
        end
      else
        begin
          Configuration.bUseExternalLog:=False;
          pnlLog.Visible:=not Configuration.bUseExternalLog;
          Height:=600-152*integer(Configuration.bUseExternalLog);
          Timer1.Enabled:=Configuration.bUseExternalLog;
        end;
    end;
  if not Configuration.bUseExternalLog then
    begin
      if (((Configuration.bKeepErrorLog)and(aMessageType=lmtError))or((Configuration.bKeepWarningLog)and(aMessageType=lmtWarning))or((Configuration.bKeepInfoLog)and(aMessageType=lmtInfo))or((Configuration.bKeepSQLLog)and(aMessageType=lmtSQL))or
        ((Configuration.bKeepDebugLog)and(aMessageType=lmtDebug))) then
        begin
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
          ListItem.SubItems.Add(CurrentUser.sLogin); // ������� �������������� ������������
          ListItem.SubItems.Add(aMessage); // ����� ���������
          if (Configuration.iFlushLogOnStringsQuantity>0)and(lvLog.Items.Count=Configuration.iFlushLogOnStringsQuantity) then
            Do_FlushLogToFile;
          if Configuration.bScrollToLastLogMessage then
            SendMessage(lvLog.Handle, LVM_ENSUREVISIBLE, lvLog.Items.Count-1, 0);
        end;
    end;
end;

procedure TMainForm.pmLogPopup(Sender: TObject);
const
  LogGroupGUID: string='{EA0B3ED4-0C27-4B87-8A2E-828E54604B9D}';
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

procedure TMainForm.InitProgressBar(const aMax: integer);
begin
  pbMain.Position:=pbMain.Min;
  pbMain.Max:=aMax;
  Application.ProcessMessages;
end;

procedure TMainForm.StepProgressBar;
begin
  pbMain.Position:=pbMain.Position+pbMain.Step;
  Application.ProcessMessages;
end;

procedure TMainForm.Do_Help;
const
  LogGroupGUID: string='{D4FD6F3E-2121-4B0C-829D-19646865BA89}';
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

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_MinimizeMainForm;
const
  LogGroupGUID: string='{14072DE1-178E-48D8-9A01-4899004A5DB5}';
begin
  ProcedureHeader('��������� ������������ �������� ���� � ����', LogGroupGUID);

  MainForm.Visible:=False;
  TrayIcon1.Visible:=True;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_MaximizeLogPanel;
const
  LogGroupGUID: string='{90EED816-7CA7-4806-BED7-D4E82D6CBB9A}';
begin
  ProcedureHeader('��������� �������������� ������ ��������� �� �� ����', LogGroupGUID);

  pnlLog.Align:=alClient;
  Action_MaximizeLogPanel.Enabled:=False;
  Action_RestoreLogPanel.Enabled:=True;
  btnMaximazeLogPanel.Enabled:=False;
  btnRestoreLogPanel.Enabled:=True;
  Update_pnlConnectedMode;
  LogThis('������ ��������� ������ ��������� ���� ��������� �� �� ����.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TrayIcon1Click(Sender: TObject);
const
  LogGroupGUID: string='{AF1A3B63-DB71-4648-B6B2-BCB8E1DAAD19}';
begin
  ProcedureHeader('���������-���������� ������ �� ������ � ����', LogGroupGUID);

  if MainForm.Visible then
    SetForegroundWindow(MainForm.Handle);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_MaximizeLogPanelExecute(Sender: TObject);
const
  LogGroupGUID: string='{9C0E64E8-E627-4AFF-9EB7-2AB33C9985B9}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_MaximizeLogPanel.Caption+'"', LogGroupGUID);
  Do_MaximizeLogPanel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_OpenReportsFolderExecute(Sender: TObject);
const
  LogGroupGUID: string='{FD57F9EB-94B0-4B15-BC65-A905798B4A5B}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_OpenReportsFolder.Caption+'"', LogGroupGUID);
  Do_OpenReportsFolder;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ApplicationEvents1Minimize(Sender: TObject);
const
  LogGroupGUID: string='{168855D1-C5B0-4123-8276-2EFBE47C06C3}';
begin
  ProcedureHeader('��������� ������� �� ������� ����������� �������� ����', LogGroupGUID);
  Do_MinimizeMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TrayIcon1DblClick(Sender: TObject);
const
  LogGroupGUID: string='{359069CB-50CA-4171-9714-38B0895924E0}';
begin
  ProcedureHeader('���������-���������� ���������� ������ �� ������ � ����', LogGroupGUID);
  Do_RestoreMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopyGUIDStringToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string='{E9293B16-9E48-4589-A67B-3D578DF548A0}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_CopyGUIDStringToClipboard.Caption+'"', LogGroupGUID);
  Do_CopyGUIDStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyGUIDStringToClipboard;
const
  LogGroupGUID: string='{61BF14C3-7B19-4042-9EB5-E051D5AB72B9}';
begin
  ProcedureHeader('��������� ����������� GUID ����������� �������� ������ ��������� � ����� ������', LogGroupGUID);

  with lvLog do
    if Selected<>nil then
      with Selected do
        if SubItems.Count=4 then
          Routines_CopyStringToClipboard(Trim(SubItems[0]));

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopyLogStringToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string='{AFA0F989-38E5-4D0F-93B5-2A69649FD483}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_CopyLogStringToClipboard.Caption+'"', LogGroupGUID);
  Do_CopyLogStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyLogStringToClipboard;
const
  LogGroupGUID: string='{FF84CE4B-78C0-4DD3-B1D2-76931F50A843}';
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

procedure TMainForm.Action_CopySQLFromLogToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string='{2FAEB893-5B17-4294-B3A3-5F133D85B41B}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_CopySQLFromLogToClipboard.Caption+'"', LogGroupGUID);
  Do_CopySQLFromLogToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopySQLFromLogToClipboard;
const
  LogGroupGUID: string='{C7EC6643-0CE4-4E3C-90D6-928C07605DAE}';
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

procedure TMainForm.Action_AboutExecute(Sender: TObject);
const
  LogGroupGUID: string='{3FE35A16-DF07-4218-B82A-1C7959244447}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_About.Caption+'"', LogGroupGUID);
  Do_About;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{B40DE54E-580C-4F96-BE2A-1447856505B0}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
const
  LogGroupGUID: string='{73855780-FE07-4058-983D-912D3CCF00A7}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Quit.Caption+'"', LogGroupGUID);
  Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RestoreExecute(Sender: TObject);
const
  LogGroupGUID: string='{4FFF4893-DFF8-406C-B66B-9CE1430B7B06}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Restore.Caption+'"', LogGroupGUID);
  Do_RestoreMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ProcessSelectedActionsExecute(Sender: TObject);
const
  LogGroupGUID: string='{E3CD2FE0-99EB-4234-862F-4F15B3828609}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ProcessSelectedActions.Caption+'"', LogGroupGUID);
  Do_ProcessSelectedActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindNextWithSuchGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string='{79024270-342A-401B-8066-15C28D938D4D}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_FindNextWithSuchGUID.Caption+'"', LogGroupGUID);
  Do_FindNextWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindPreviousWithSuchGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string='{544909F1-2987-4A25-9D7B-5A196C170D04}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_FindPreviousWithSuchGUID.Caption+'"', LogGroupGUID);
  Do_FindPreviousWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindSpecifiedGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string='{473D6C20-DBD4-40CC-9664-7DBF0521194F}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_FindSpecifiedGUID.Caption+'"', LogGroupGUID);
  Do_FindSpecifiedGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_FindSpecifiedGUID;
const
  LogGroupGUID: string='{CC35A134-5080-493D-BBFD-252EAC167F37}';
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

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
// const
// LogGroupGUID: string = '{C87E45B5-DCEB-4BE2-A094-4B1181AE7CAB}';
begin
  // ��������� �� ���������� ���������� ��������� - � ����� ����������� ���� ��������� ��������
  // ProcedureHeader('��������� ����������� ������ ����������� ��������� � ������ �������',LogGroupGUID,False,False);
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.miStatusbarClick(Sender: TObject);
const
  LogGroupGUID: string='{54B6714E-1890-420E-9EE6-540DC623EF92}';
begin
  ProcedureHeader('��������� ���������/���������� ����������� ������ �������', LogGroupGUID);

  StatusBar1.Visible:=miStatusbar.Checked;
  Configuration.bNoStatusBar:=not StatusBar1.Visible;
  LogThis('������ ������� '+Routines_GetConditionalMessage(StatusBar1.Visible, '�', '��')+'�������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbActionsListChange(Sender: TObject);
const
  LogGroupGUID: string='{C25BFA97-7031-4CE8-B9B2-986181BD3292}';
begin
  ProcedureHeader('���������-���������� ������ �������� ����������� ������ ��������', LogGroupGUID);
  Do_SelectAction;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbCreateXRDAClick(Sender: TObject);
const
  LogGroupGUID: string='{97DB87A6-D071-468A-B071-887C1AFAF9F9}';
begin
  ProcedureHeader('��������� ������� �� ������������ ��������� ������ "'+cbCreateXRDA.Caption+'"', LogGroupGUID);

  cbCustomNameOfXRDA.Enabled:=cbCreateXRDA.Checked or cbRecreateXRDA.Checked;
  if not(cbReCreateXRDA.Checked or cbCreateXRDA.Checked) then
    cbCustomNameOfXRDA.Checked:=False;
  LogThis('������ "'+cbCreateXRDA.Caption+'" '+Routines_GetConditionalMessage(cbCreateXRDA.Checked, '�������', '��������')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbCustomNameOfXRDAClick(Sender: TObject);
const
  LogGroupGUID: string='{520E19D9-05A0-4423-9298-81313CFD42C8}';
begin
  ProcedureHeader('��������� ������� �� ������������ ��������� ������ "'+cbCustomNameOfXRDA.Caption+'"', LogGroupGUID);

  ebCustomNameOfXRDA.Enabled:=cbCustomNameOfXRDA.Checked;
  if not cbCustomNameOfXRDA.Checked then
    ebCustomNameOfXRDA.Clear;
  LogThis('������ "'+cbCustomNameOfXRDA.Caption+'" '+Routines_GetConditionalMessage(cbCustomNameOfXRDA.Checked, '�������', '��������')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbRecreateXRDAClick(Sender: TObject);
const
  LogGroupGUID: string='{35FDB9E5-CE9D-4AEC-9A3A-3A36B6CAA6E9}';
begin
  ProcedureHeader('��������� ������� �� ������������ ��������� ������ "'+cbRecreateXRDA.Caption+'"', LogGroupGUID);

  cbCustomNameOfXRDA.Enabled:=cbCreateXRDA.Checked or cbRecreateXRDA.Checked;
  if not(cbReCreateXRDA.Checked or cbCreateXRDA.Checked) then
    cbCustomNameOfXRDA.Checked:=False;
  LogThis('������ "'+cbRecreateXRDA.Caption+'" '+Routines_GetConditionalMessage(cbRecreateXRDA.Checked, '�������', '��������')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RestoreLogPanelExecute(Sender: TObject);
const
  LogGroupGUID: string='{DB45C462-B894-4F9D-BC37-99BA807BE93F}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_RestoreLogPanel.Caption+'"', LogGroupGUID);
  Do_RestoreLogPanel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_RestoreLogPanel;
const
  LogGroupGUID: string='{45DF4FFD-F0F5-4C0F-BE52-A478E53A219A}';
begin
  ProcedureHeader('��������� �������������� �������� �������� ������ ���������', LogGroupGUID);

  pnlLog.Align:=alBottom;
  pnlLog.Height:=152;
  Action_RestoreLogPanel.Enabled:=False;
  Action_MaximizeLogPanel.Enabled:=True;
  btnRestoreLogPanel.Enabled:=False;
  btnMaximazeLogPanel.Enabled:=True;
  Update_pnlConnectedMode;
  LogThis('���� ���������� ���������� ������� ������ ��������� ������ ���������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_SelectAllCalls_PayoffExecute(Sender: TObject);
var
  i: integer;
begin
  with lvPhonesList_Payoff do
    begin
      OnItemChecked:=nil;
      Items.BeginUpdate;
      for i:=0 to Items.Count-1 do
        Items[i].Checked:=True;
      Items.EndUpdate;
      OnItemChecked:=lvPhonesList_PayoffItemChecked;
    end;
  Update_Actions_Payoff;
end;

procedure TMainForm.Action_SelectAllServices_SIC_09Execute(Sender: TObject);
begin
  Do_SelectAllServices_SIC_09;
end;

procedure TMainForm.Action_SelectAllUsers_SIC_04Execute(Sender: TObject);
var
  i: integer;
begin
  with clbUsers_SIC_04 do
    begin
      OnClickCheck:=nil;
      Items.BeginUpdate;
      for i:=0 to Count-1 do
        Checked[i]:=True;
      Items.EndUpdate;
      OnClickCheck:=clbUsers_SIC_04ClickCheck;
    end;
  Update_Actions_SIC_04;
end;

procedure TMainForm.Action_SelectAllUsers_SIC_10Execute(Sender: TObject);
var
  i: integer;
begin
  with clbUsers_SIC_10 do
    begin
      OnClickCheck:=nil;
      Items.BeginUpdate;
      for i:=0 to Count-1 do
        Checked[i]:=True;
      Items.EndUpdate;
      OnClickCheck:=clbUsers_SIC_10ClickCheck;
    end;
  Update_Actions_SIC_10;
end;

procedure TMainForm.Action_UnselectAllCalls_PayoffExecute(Sender: TObject);
var
  i: integer;
begin
  with lvPhonesList_Payoff do
    begin
      OnItemChecked:=nil;
      Items.BeginUpdate;
      for i:=0 to Items.Count-1 do
        Items[i].Checked:=False;
      Items.EndUpdate;
      OnItemChecked:=lvPhonesList_PayoffItemChecked;
    end;
  Update_Actions_Payoff;
end;

procedure TMainForm.Action_UnselectAllServices_SIC_09Execute(Sender: TObject);
begin
  Do_UnselectAllServices_SIC_09;
end;

procedure TMainForm.Action_UnselectAllUsers_SIC_04Execute(Sender: TObject);
var
  i: integer;
begin
  with clbUsers_SIC_04 do
    begin
      OnClickCheck:=nil;
      Items.BeginUpdate;
      for i:=0 to Count-1 do
        Checked[i]:=False;
      Items.EndUpdate;
      OnClickCheck:=clbUsers_SIC_04ClickCheck;
    end;
  Update_Actions_SIC_04;
end;

procedure TMainForm.Action_UnselectAllUsers_SIC_10Execute(Sender: TObject);
var
  i: integer;
begin
  with clbUsers_SIC_10 do
    begin
      OnClickCheck:=nil;
      Items.BeginUpdate;
      for i:=0 to Count-1 do
        Checked[i]:=False;
      Items.EndUpdate;
      OnClickCheck:=clbUsers_SIC_10ClickCheck;
    end;
  Update_Actions_SIC_10;
end;

procedure TMainForm.Update_ProgressBarsInActionsListView;
var
  i: integer;
  ProgressBarRect: TRect;
begin
  for i:=0 to lvActionList.Items.Count-1 do
    if lvActionList.Items[i]<>nil then
      if lvActionList.Items[i].Data<>nil then
        begin
          TProgressBar(lvActionList.Items[i].Data).Width:=lvActionList.Column[1].Width-2;
          ProgressBarRect:=lvActionList.Items[i].DisplayRect(drBounds);
          ProgressBarRect.Top:=ProgressBarRect.Top+1;
          ProgressBarRect.Bottom:=ProgressBarRect.Bottom-2;
          ProgressBarRect.Left:=ProgressBarRect.Left+MainForm.lvActionList.Columns[0].Width+1;
          ProgressBarRect.Right:=ProgressBarRect.Left+MainForm.lvActionList.Columns[1].Width-1;
          TProgressBar(lvActionList.Items[i].Data).BoundsRect:=ProgressBarRect;
          TProgressBar(lvActionList.Items[i].Data).Visible:=(BOOL(ListView_IsItemVisible(lvActionList.Handle, lvActionList.Items[i].index))=True)and(i>=ListView_GetTopIndex(lvActionList.Handle));
        end;
end;

procedure TMainForm.lvActionListDividerDblClick(sender: TCustomListView; columnIndex, columnWidth: Integer);
begin
  Update_ProgressBarsInActionsListView;
end;

procedure TMainForm.lvActionListEndColumnResize(sender: TCustomListView; columnIndex, columnWidth: Integer);
begin
  Update_ProgressBarsInActionsListView;
end;

procedure TMainForm.lvActionListInsert(Sender: TObject; Item: TListItem);
begin
  if Configuration.bScrollToLastLogMessage then
    SendMessage(lvActionList.Handle, LVM_ENSUREVISIBLE, lvActionList.Items.Count-1, 0);
end;

procedure TMainForm.lvActionListMouseWheel(Sender: TObject; Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  Update_ProgressBarsInActionsListView;
end;

procedure TMainForm.lvActionListResize(Sender: TObject);
begin
  Update_ProgressBarsInActionsListView;
end;

procedure TMainForm.lvActionListScroll(Sender: TCustomListView);
begin
  Update_ProgressBarsInActionsListView;
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

procedure TMainForm.lvLogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
const
  LogGroupGUID: string='{49CA36EC-7980-4B2A-9CE1-1D75C31F416A}';
begin
  ProcedureHeader('���������-���������� ������� ������� � ������ ���������', LogGroupGUID);
  if Key=VK_F2 then
    Do_FindPreviousWithSuchGUID;
  if Key=VK_F3 then
    Do_FindNextWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.lvPhonesList_PayoffItemChecked(Sender: TObject; Item: TListItem);
begin
  Update_Actions_Payoff;
end;

procedure TMainForm.Do_FindNextWithSuchGUID;
const
  LogGroupGUID: string='{096C66C7-8056-4A2E-9E0A-228405B7B4D0}';
var
  s: string;
  i, j: integer;
  b: boolean;
  iOldBusyCounter: integer;
begin
  // ProcedureHeader('��������� �������� � ��������� ������ ��������� � ����� �� GUID',LogGroupGUID,False,False);
  b:=False;
  j:=-1;
  if (lvLog.Items.Count>0)and(lvLog.Selected<>nil) then
    begin
      if lvLog.Selected.SubItems.Count>=1 then
        begin
          s:=lvLog.Selected.SubItems[0]; // ��������� GUID ����������� �������� ������
          // LogThis(PWideChar('������� ������ GUID: '+s+'.'), LogGroupGUID, lmtDebug);
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
                  iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
                  iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
                  Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������

                  MessageBox(Handle, PWideChar('����� � GUID '+s+' ���� ��������� � ������ ��������� ����� �� �������!'), PWideChar('LogKeeper - ��������!'), MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                  Application.ProcessMessages;

                  iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
                  Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������
                  Application.ProcessMessages;
                end;
            end;
        end;
      // else LogThis(PWideChar('������� �� ��������, ��� ��� �� ���� ������� ������ GUID ���� �� ������!'),LogGroupGUID,lmtError);
    end;
  // else LogThis(PWideChar('������� �� ����������, ��� ��� �� ���� �������� �� ����� ������ ������!'),LogGroupGUID,lmtWarning);
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.Do_FindPreviousWithSuchGUID;
const
  LogGroupGUID: string='{47CC151A-8EB8-4687-91A3-D9859380A432}';
var
  s: string;
  i, j: integer;
  b: boolean;
  iOldBusyCounter: integer;
begin
  // ProcedureHeader('��������� �������� � ���������� ������ ��������� � ����� �� GUID',LogGroupGUID,False,False);
  b:=False;
  j:=-1;
  if (lvLog.Items.Count>0)and(lvLog.Selected<>nil) then
    begin
      if lvLog.Selected.SubItems.Count>=1 then
        begin
          s:=lvLog.Selected.SubItems[0]; // ��������� GUID ����������� �������� ������
          // LogThis(PWideChar('������� ������ GUID: '+s+'.'), LogGroupGUID, lmtDebug);
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
                  iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
                  iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
                  Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������

                  MessageBox(Handle, PWideChar('����� � GUID '+s+' ���� ��������� � ������ ��������� ����� �� �������!'), PWideChar('LogKeeper - ��������!'), MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                  Application.ProcessMessages;

                  iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
                  Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������
                  Application.ProcessMessages;
                end;
            end;
        end;
      // else LogThis(PWideChar('������� �� ��������, ��� ��� �� ���� ������� ������ GUID ���� �� ������!'),LogGroupGUID,lmtError);
    end;
  // else LogThis(PWideChar('������� �� ����������, ��� ��� �� ���� �������� �� ����� ������ ������!'),LogGroupGUID,lmtWarning);
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  LogGroupGUID: string;
  iOldBusyCounter: integer;
begin
  LogGroupGUID:='{98820E3D-0168-459B-8902-19391BEFBDDE}';
  ProcedureHeader('��������� ���������� ������ ����������', LogGroupGUID);

  CanClose:=False;

  iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
  iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
  Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������

  if Configuration.bShowQuitConfirmation then
    CanClose:=MessageBox(Handle, PWideChar('�� ������������� ������ ��������� ������ ���������?'), PWideChar('OVERSEER - ������������� ������'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK
  else
    CanClose:=True;
  Application.ProcessMessages;

  iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
  Refresh_BusyState(LogGroupGUID); // ���������� ��������� ����������
  Application.ProcessMessages;

  if CanClose then
    begin
      LogThis('���������� ������ ���������� ���� ������������.', LogGroupGUID, lmtInfo);
      Do_Logout;
      Save_ConfigIni;
      // ������� ������ ���� � ������� �������
      if Configuration.bAutorun then
        begin
          if not Routines_IsApplicationInRunKey('overseer') then
            Routines_AddApplicationToRunKey('overseer', Application.ExeName)
        end
      else
        if Routines_IsApplicationInRunKey('overseer') then
          Routines_DeleteApplicationFromRunKey('overseer');
      if Configuration.bFlushLogOnExit then
        Do_FlushLogToFile;
    end
  else
    LogThis('���������� ������ ���������� ���� �������� �������������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Load_ConfigIni;
const
  LogGroupGUID: string='{CABB30D6-CFDE-4356-AF41-C874A49E46F5}';
var
  s: string;
begin
  ProcedureHeader('��������� �������� ������������ ��������� �� ����� INI', LogGroupGUID);

  with TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'overseer.ini') do
    try
      // ������ "���������"
      Configuration.bAlwaysShowTrayIcon:=ReadBool('���������', 'bAlwaysShowTrayIcon', False);
      Configuration.bShowQuitConfirmation:=ReadBool('���������', 'bShowQuitConfirmation', True);
      Configuration.bStoreLastLogin:=ReadBool('���������', 'bStoreLastLogin', False);
      Configuration.sLastLogin:=Routines_GetConditionalMessage(Configuration.bStoreLastLogin, ReadString('���������', 'sLastLogin', ''), '');
      Configuration.bStoreLastPassword:=ReadBool('���������', 'bStoreLastPassword', False);
      Configuration.sLastPassword:=Routines_GetConditionalMessage(Configuration.bStoreLastPassword, ReadString('���������', 'sLastPassword', ''), '');
      Configuration.bAutoLogon:=ReadBool('���������', 'bAutoLogon', False);
      Configuration.bUseExternalLog:=ReadBool('���������', 'bUseExternalLog', False);
      Configuration.sDefaultAction:=ReadString('���������', 'sDefaultAction', '');
      Configuration.bNoStatusBar:=ReadBool('���������', 'bNoStatusBar', False);
      Configuration.bScrollToLastLogMessage:=ReadBool('���������', 'bScrollToLastLogMessage', True);
      Configuration.bAutorun:=ReadBool('���������', 'bAutorun', False);
      Configuration.bStartInTray:=ReadBool('���������', 'bStartInTray', False);
      Configuration.bPlaySoundAfterAction:=ReadBool('���������', 'bPlaySoundAfterAction', True);
      Configuration.bShowBaloonHintAfterAction:=ReadBool('���������', 'bShowBaloonHintAfterAction', True);

      // ������ "������ � ���� ������"
      Configuration.OverseerServer.sMySQLHost:=ReadString('������ � ���� ������', 'OverseerServer.sMySQLHost', 'OVERSEERSERVER'); // overseerserver
      Configuration.OverseerServer.iMySQLPort:=ReadInteger('������ � ���� ������', 'OverseerServer.iMySQLPort', MYSQL_PORT);
      Configuration.OverseerServer.iMySQLTimeout:=ReadInteger('������ � ���� ������', 'OverseerServer.iMySQLTimeout', 30);
      Configuration.OverseerServer.bMySQLCompress:=ReadBool('������ � ���� ������', 'OverseerServer.bMySQLCompress', True);
      Configuration.OverseerServer.sMySQLDatabase:=ReadString('������ � ���� ������', 'OverseerServer.sMySQLDatabase', 'overseer');

      // dbserver
      Configuration.DBServer.sMySQLHost:=ReadString('������ � ���� ������', 'DBServer.sMySQLHost', 'DBSERVER');
      Configuration.DBServer.iMySQLPort:=ReadInteger('������ � ���� ������', 'DBServer.iMySQLPort', MYSQL_PORT);
      Configuration.DBServer.iMySQLTimeout:=ReadInteger('������ � ���� ������', 'DBServer.iMySQLTimeout', 30);
      Configuration.DBServer.bMySQLCompress:=ReadBool('������ � ���� ������', 'DBServer.bMySQLCompress', True);
      Configuration.DBServer.sMySQLDatabase_IRD_Location:=ReadString('������ � ���� ������', 'DBServer.sMySQLDatabase_IRD_Location', 'statistika');
      Configuration.DBServer.sMySQLDatabase_ORD_Location:=ReadString('������ � ���� ������', 'DBServer.sMySQLDatabase_ORD_Location', 'statistika');
      Configuration.DBServer.sMySQLDatabase_PRIJAVE_Location:=ReadString('������ � ���� ������', 'DBServer.sMySQLDatabase_PRIJAVE_Location', 'test');
      Configuration.DBServer.sMySQLDatabase_PRIJAVE_Q_Location:=ReadString('������ � ���� ������', 'DBServer.sMySQLDatabase_PRIJAVE_Q_Location', 'test');
      Configuration.DBServer.sMySQLDatabase_T_DAY_Location:=ReadString('������ � ���� ������', 'DBServer.sMySQLDatabase_T_DAY_Location', 'MyStat');

      // statserver
      Configuration.StatServer.sMySQLHost:=ReadString('������ � ���� ������', 'StatServer.sMySQLHost', 'STATSERVER');
      Configuration.StatServer.iMySQLPort:=ReadInteger('������ � ���� ������', 'StatServer.iMySQLPort', MYSQL_PORT);
      Configuration.StatServer.iMySQLTimeout:=ReadInteger('������ � ���� ������', 'StatServer.iMySQLTimeout', 30);
      Configuration.StatServer.bMySQLCompress:=ReadBool('������ � ���� ������', 'StatServer.bMySQLCompress', True);
      Configuration.StatServer.sMySQLDatabase_IRD_Location:=ReadString('������ � ���� ������', 'StatServer.sMySQLDatabase_IRD_Location', 'ird');
      Configuration.StatServer.sMySQLDatabase_ORD_Location:=ReadString('������ � ���� ������', 'StatServer.sMySQLDatabase_ORD_Location', 'ord');
      Configuration.StatServer.sMySQLDatabase_IRDA_Location:=ReadString('������ � ���� ������', 'StatServer.sMySQLDatabase_IRDA_Location', 'irda');
      Configuration.StatServer.sMySQLDatabase_ORDA_Location:=ReadString('������ � ���� ������', 'StatServer.sMySQLDatabase_ORDA_Location', 'orda');
      Configuration.StatServer.sMySQLDatabase_PRIJAVE_Location:=ReadString('������ � ���� ������', 'StatServer.sMySQLDatabase_PRIJAVE_Location', 'prijaves');
      Configuration.StatServer.sMySQLDatabase_PRIJAVE_Q_Location:=ReadString('������ � ���� ������', 'StatServer.sMySQLDatabase_PRIJAVE_Q_Location', 'prijaves');

      // rne4server
      Configuration.RNE4Server.sMySQLHost:=ReadString('������ � ���� ������', 'RNE4Server.sMySQLHost', 'RNE4SERVER');
      Configuration.RNE4Server.iMySQLPort:=ReadInteger('������ � ���� ������', 'RNE4Server.iMySQLPort', MYSQL_PORT);
      Configuration.RNE4Server.iMySQLTimeout:=ReadInteger('������ � ���� ������', 'RNE4Server.iMySQLTimeout', 30);
      Configuration.RNE4Server.bMySQLCompress:=ReadBool('������ � ���� ������', 'RNE4Server.bMySQLCompress', True);
      Configuration.RNE4Server.sMySQLDatabase:=ReadString('������ � ���� ������', 'RNE4Server.sMySQLDatabase', 'rne4');

      // ������ "����������������"
      Configuration.bKeepErrorLog:=ReadBool('����������������', 'bKeepErrorLog', True);
      Configuration.bKeepWarningLog:=ReadBool('����������������', 'bKeepWarningLog', True);
      Configuration.bKeepInfoLog:=ReadBool('����������������', 'bKeepInfoLog', True);
      Configuration.bKeepSQLLog:=ReadBool('����������������', 'bKeepSQLLog', False);
      Configuration.bKeepDebugLog:=ReadBool('����������������', 'bKeepDebugLog', False);
      Configuration.bFlushLogOnExit:=ReadBool('����������������', 'bFlushLogOnExit', True);
      Configuration.iFlushLogOnStringsQuantity:=ReadInteger('����������������', 'iFlushLogOnStringsQuantity', -1);
      Configuration.bFlushLogOnClearingLog:=ReadBool('����������������', 'bFlushLogOnClearingLog', True);

      // ������ "������"
      s:=ReadString('������', 'sReportFolder', '');
      if s='ApplicationFolder' then
        Configuration.trfReportFolder:=rfApplicationFolder
      else
        if s='CustomFolder' then
          Configuration.trfReportFolder:=rfCustomFolder
        else
          Configuration.trfReportFolder:=rfTempFolder;
      Configuration.sCustomFolder:=ReadString('������', 'sCustomFolder', '');

      Configuration.bDontDemandOverwriteConfirmation:=ReadBool('������', 'bDontDemandOverwriteConfirmation', False);
      Configuration.bAskForFileName:=ReadBool('������', 'bAskForFileName', False);

      LogThis('������������ ������� �������.', LogGroupGUID, lmtInfo);

      // ���������� ���������� �������� � ���������
      // cbActionsList.ItemIndex:=cbActionsList.Items.IndexOf(Configuration.sDefaultAction);
      // if cbActionsList.ItemIndex<0 then
      // cbActionsList.ItemIndex:=0;
      // Do_SelectAction;

      chkbxScrollToLastLogMessage.Checked:=chkbxScrollToLastLogMessage.Enabled and Configuration.bScrollToLastLogMessage;

      if not(FileExists(ExpandFileName(Application.HelpFile))) then
        begin
          Action_Help.Enabled:=False;
          Action_Help.Visible:=False;
        end;

      if Configuration.bNoStatusBar then
        begin
          miStatusbar.Checked:=False;
          StatusBar1.Visible:=miStatusbar.Checked;
        end;

      pnlLog.Visible:=not Configuration.bUseExternalLog;
      MainForm.Height:=600-152*integer(Configuration.bUseExternalLog);
      Timer1.Enabled:=Configuration.bUseExternalLog;

      if bFirstRun then
        begin
          Application.ShowMainForm:=not Configuration.bStartInTray;
          MainForm.Visible:=not Configuration.bStartInTray;
        end;

      TrayIcon1.Visible:=(not MainForm.Visible)or Configuration.bAlwaysShowTrayIcon;
    finally
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Save_ConfigIni;
const
  LogGroupGUID: string='{B282D7BB-0359-45AD-877C-F24CDB5F44E7}';
begin
  ProcedureHeader('��������� ���������� ������������ ��������� � ���� INI', LogGroupGUID);

  with TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'overseer.ini') do
    try
      try
        // ������ "���������"
        WriteBool('���������', 'bAlwaysShowTrayIcon', Configuration.bAlwaysShowTrayIcon);
        WriteBool('���������', 'bShowQuitConfirmation', Configuration.bShowQuitConfirmation);
        WriteBool('���������', 'bStoreLastLogin', Configuration.bStoreLastLogin);
        if Configuration.bStoreLastLogin then
          WriteString('���������', 'sLastLogin', Configuration.sLastLogin)
        else
          DeleteKey('���������', 'sLastLogin');
        WriteBool('���������', 'bStoreLastPassword', Configuration.bStoreLastPassword);
        if Configuration.bStoreLastPassword then
          WriteString('���������', 'sLastPassword', Configuration.sLastPassword)
        else
          DeleteKey('���������', 'sLastPassword');
        if Configuration.bAutoLogon then
          WriteBool('���������', 'bAutoLogon', Configuration.bAutoLogon)
        else
          DeleteKey('���������', 'bAutoLogon');
        WriteBool('���������', 'bUseExternalLog', Configuration.bUseExternalLog);
        WriteString('���������', 'sDefaultAction', Configuration.sDefaultAction);
        WriteBool('���������', 'bNoStatusBar', Configuration.bNoStatusBar);
        WriteBool('���������', 'bScrollToLastLogMessage', Configuration.bScrollToLastLogMessage);
        WriteBool('���������', 'bAutorun', Configuration.bAutorun);
        WriteBool('���������', 'bStartInTray', Configuration.bStartInTray);
        WriteBool('���������', 'bPlaySoundAfterAction', Configuration.bPlaySoundAfterAction);
        WriteBool('���������', 'bShowBaloonHintAfterAction', Configuration.bShowBaloonHintAfterAction);

        // ������ "������ � ���� ������"
        WriteString('������ � ���� ������', 'OverseerServer.sMySQLHost', Configuration.OverseerServer.sMySQLHost);
        // overseerserver
        WriteString('������ � ���� ������', 'OverseerServer.sMySQLHost', Configuration.OverseerServer.sMySQLHost);
        WriteInteger('������ � ���� ������', 'OverseerServer.iMySQLPort', Configuration.OverseerServer.iMySQLPort);
        WriteInteger('������ � ���� ������', 'OverseerServer.iMySQLTimeout', Configuration.OverseerServer.iMySQLTimeout);
        WriteBool('������ � ���� ������', 'OverseerServer.bMySQLCompress', Configuration.OverseerServer.bMySQLCompress);
        WriteString('������ � ���� ������', 'OverseerServer.sMySQLDatabase', Configuration.OverseerServer.sMySQLDatabase);

        WriteString('������ � ���� ������', 'DBServer.sMySQLHost', Configuration.DBServer.sMySQLHost); // dbserver
        WriteString('������ � ���� ������', 'DBServer.sMySQLHost', Configuration.DBServer.sMySQLHost);
        WriteInteger('������ � ���� ������', 'DBServer.iMySQLPort', Configuration.DBServer.iMySQLPort);
        WriteInteger('������ � ���� ������', 'DBServer.iMySQLTimeout', Configuration.DBServer.iMySQLTimeout);
        WriteBool('������ � ���� ������', 'DBServer.bMySQLCompress', Configuration.DBServer.bMySQLCompress);
        WriteString('������ � ���� ������', 'DBServer.sMySQLDatabase_IRD_Location', Configuration.DBServer.sMySQLDatabase_IRD_Location);
        WriteString('������ � ���� ������', 'DBServer.sMySQLDatabase_ORD_Location', Configuration.DBServer.sMySQLDatabase_ORD_Location);
        WriteString('������ � ���� ������', 'DBServer.sMySQLDatabase_PRIJAVE_Location', Configuration.DBServer.sMySQLDatabase_PRIJAVE_Location);
        WriteString('������ � ���� ������', 'DBServer.sMySQLDatabase_PRIJAVE_Q_Location', Configuration.DBServer.sMySQLDatabase_PRIJAVE_Q_Location);
        WriteString('������ � ���� ������', 'DBServer.sMySQLDatabase_T_DAY_Location', Configuration.DBServer.sMySQLDatabase_T_DAY_Location);

        WriteString('������ � ���� ������', 'StatServer.sMySQLHost', Configuration.StatServer.sMySQLHost); // statserver
        WriteString('������ � ���� ������', 'StatServer.sMySQLHost', Configuration.StatServer.sMySQLHost);
        WriteInteger('������ � ���� ������', 'StatServer.iMySQLPort', Configuration.StatServer.iMySQLPort);
        WriteInteger('������ � ���� ������', 'StatServer.iMySQLTimeout', Configuration.StatServer.iMySQLTimeout);
        WriteBool('������ � ���� ������', 'StatServer.bMySQLCompress', Configuration.StatServer.bMySQLCompress);
        WriteString('������ � ���� ������', 'StatServer.sMySQLDatabase_IRD_Location', Configuration.StatServer.sMySQLDatabase_IRD_Location);
        WriteString('������ � ���� ������', 'StatServer.sMySQLDatabase_ORD_Location', Configuration.StatServer.sMySQLDatabase_ORD_Location);
        WriteString('������ � ���� ������', 'StatServer.sMySQLDatabase_IRDA_Location', Configuration.StatServer.sMySQLDatabase_IRDA_Location);
        WriteString('������ � ���� ������', 'StatServer.sMySQLDatabase_ORDA_Location', Configuration.StatServer.sMySQLDatabase_ORDA_Location);
        WriteString('������ � ���� ������', 'StatServer.sMySQLDatabase_PRIJAVE_Location', Configuration.StatServer.sMySQLDatabase_PRIJAVE_Location);
        WriteString('������ � ���� ������', 'StatServer.sMySQLDatabase_PRIJAVE_Q_Location', Configuration.StatServer.sMySQLDatabase_PRIJAVE_Q_Location);

        WriteString('������ � ���� ������', 'RNE4Server.sMySQLHost', Configuration.RNE4Server.sMySQLHost);
        WriteInteger('������ � ���� ������', 'RNE4Server.iMySQLPort', Configuration.RNE4Server.iMySQLPort);
        WriteInteger('������ � ���� ������', 'RNE4Server.iMySQLTimeout', Configuration.RNE4Server.iMySQLTimeout);
        WriteBool('������ � ���� ������', 'RNE4Server.bMySQLCompress', Configuration.RNE4Server.bMySQLCompress);
        WriteString('������ � ���� ������', 'RNE4Server.sMySQLDatabase', Configuration.RNE4Server.sMySQLDatabase);

        // ������ "����������������"
        WriteBool('����������������', 'bKeepErrorLog', Configuration.bKeepErrorLog);
        WriteBool('����������������', 'bKeepWarningLog', Configuration.bKeepWarningLog);
        WriteBool('����������������', 'bKeepInfoLog', Configuration.bKeepInfoLog);
        WriteBool('����������������', 'bKeepSQLLog', Configuration.bKeepSQLLog);
        WriteBool('����������������', 'bKeepDebugLog', Configuration.bKeepDebugLog);
        WriteBool('����������������', 'bFlushLogOnExit', Configuration.bFlushLogOnExit);
        WriteInteger('����������������', 'iFlushLogOnStringsQuantity', Configuration.iFlushLogOnStringsQuantity);
        WriteBool('����������������', 'bFlushLogOnClearingLog', Configuration.bFlushLogOnClearingLog);
        // ������ "������"
        case Configuration.trfReportFolder of
          rfApplicationFolder:
            WriteString('������', 'sReportFolder', 'ApplicationFolder');
          rfCustomFolder:
            WriteString('������', 'sReportFolder', 'CustomFolder');
        else
          WriteString('������', 'sReportFolder', 'TempFolder');
        end;
        WriteString('������', 'sCustomFolder', Configuration.sCustomFolder);
        WriteBool('������', 'bDontDemandOverwriteConfirmation', Configuration.bDontDemandOverwriteConfirmation);
        WriteBool('������', 'bAskForFileName', Configuration.bAskForFileName);

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

procedure TMainForm.Timer2Timer(Sender: TObject);
begin
  Update_LastDates;
  Update_DateTimeLabels;
end;

procedure TMainForm.Update_DateTimeLabels;
begin
  rbLastDate.Caption:='&1) ��������� ���� '+FormatDateTime('(dd.mm.yyyy)', dtLastDate);
  rbLastWeek.Caption:='&3) ��������� ������ ('+FormatDateTime('dd.mm.yyyy', dtLastWeekStart)+' - '+FormatDateTime('dd.mm.yyyy', dtLastWeekStop)+')';
  rbLastMonth.Caption:='&4) ��������� ����� ('+cbChoisenMonth_Month.Items[wLastMonth_Month-1]+' '+IntToStr(wLastMonth_Year)+' ����)';
  rbLastQuarter.Caption:='&6) ��������� ������� ('+cbChoisenQuarter_Quarter.Items[wLastQuarter_Quarter-1]+' ������� '+IntToStr(wLastQuarter_Year)+' ����)';
  rbLastYear.Caption:='&8) ��������� ��� ('+IntToStr(wLastYear)+' ���)';
end;

procedure TMainForm.Update_LastDates;
var
  dtNow: TDateTime;
  dtDayDuration: TDateTime;
  Day, Month, Year: word;
begin
  dtNow:=Now;
  DecodeDate(dtNow, Year, Month, Day);

  dtDayDuration:=EncodeDate(2008, 1, 3)-EncodeDate(2008, 1, 2);

  dtLastDate:=dtNow-dtDayDuration;

  dtLastWeekStart:=StartOfTheWeek(StartOfTheWeek(dtNow)-dtDayDuration);
  dtLastWeekStop:=EndOfTheWeek(StartOfTheWeek(dtNow)-dtDayDuration);

  dtLastMonthStart:=StartOfTheMonth(StartOfTheMonth(dtNow)-dtDayDuration);
  dtLastMonthStop:=EndOfTheMonth(StartOfTheMonth(dtNow)-dtDayDuration);
  DecodeDate(dtLastMonthStart, wLastMonth_Year, wLastMonth_Month, Day);

  case Month of
    1..3:
      begin
        wLastQuarter_Quarter:=4;
        wLastQuarter_Year:=Year-1;
        dtLastQuarterStart:=EncodeDate(wLastQuarter_Year, 10, 1);
        dtLastQuarterStop:=EncodeDate(wLastQuarter_Year, 12, 31);
      end;
    4..6:
      begin
        wLastQuarter_Quarter:=1;
        wLastQuarter_Year:=Year;
        dtLastQuarterStart:=EncodeDate(wLastQuarter_Year, 1, 1);
        dtLastQuarterStop:=EncodeDate(wLastQuarter_Year, 3, 31);
      end;
    7..9:
      begin
        wLastQuarter_Quarter:=2;
        wLastQuarter_Year:=Year;
        dtLastQuarterStart:=EncodeDate(wLastQuarter_Year, 4, 1);
        dtLastQuarterStop:=EncodeDate(wLastQuarter_Year, 6, 30);
      end;
    10..12:
      begin
        wLastQuarter_Quarter:=3;
        wLastQuarter_Year:=Year;
        dtLastQuarterStart:=EncodeDate(wLastQuarter_Year, 7, 1);
        dtLastQuarterStop:=EncodeDate(wLastQuarter_Year, 9, 30);
      end;
  end;

  dtLastYearStart:=StartOfTheYear(StartOfTheYear(dtNow)-dtDayDuration);
  dtLastYearStop:=EndOfTheYear(StartOfTheYear(dtNow)-dtDayDuration);
  DecodeDate(dtLastYearStart, wLastYear, Month, Day);
end;

function TMainForm.Do_GetApplicationFolder: string;
const
  LogGroupGUID: string='{C69D3679-9D31-4BCC-9651-F00B5E598845}';
var
  s, sErrorMessage: string;
  bError: boolean;
begin
  ProcedureHeader('��������� ��������� ���� ������� ����� ���������', LogGroupGUID);
  bError:=False;
  Do_GetApplicationFolder:='';

  s:=ExtractFilePath(ExpandFileName(Application.ExeName));
  if DirectoryExists(s) then
    begin
      Do_GetApplicationFolder:=s;
      LogThis('���� ������� ����� ��������� ������� ������� - <'+s+'>.', LogGroupGUID, lmtDebug);
    end
  else
    Routines_GenerateError('�������� ������ ��� ������� ��������� ���� ������� ����� ���������!', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

function TMainForm.Do_GetTempFolder: string;
const
  LogGroupGUID: string='{C69D3679-9D31-4BCC-9651-F00B5E598845}';
var
  sErrorMessage: string;
  bError: boolean;
  r: cardinal;
  TempPathNameBuffer: PWideChar;
begin
  ProcedureHeader('��������� ��������� ���� ��������� �����', LogGroupGUID);
  bError:=False;
  TempPathNameBuffer:=nil;
  Do_GetTempFolder:='';

  try
    GetMem(TempPathNameBuffer, 1024+1);
    r:=GetTempPath(1024, TempPathNameBuffer);
    if r>0 then
      begin
        if r>1024 then
          begin
            FreeMem(TempPathNameBuffer);
            GetMem(TempPathNameBuffer, r+1);
          end;
        if DirectoryExists(TempPathNameBuffer) then
          begin
            Do_GetTempFolder:=TempPathNameBuffer;
            LogThis('���� ��������� ����� ������� ������� - <'+TempPathNameBuffer+'>.', LogGroupGUID, lmtDebug);
          end
        else
          Routines_GenerateError('�������� ������ ��� ������� ��������� ���� ��������� �����!', sErrorMessage, bError);
      end;
  finally
    if TempPathNameBuffer<>nil then
      FreeMem(TempPathNameBuffer);
  end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_OpenReportsFolder;
const
  LogGroupGUID: string='{516C86A7-24A7-4A31-868D-202AD4CD2EE9}';
var
  sErrorMessage: string;
  bError: boolean;
begin
  ProcedureHeader('��������� �������� ����� ���������� �������', LogGroupGUID);
  bError:=False;

  LogThis('������������ ������� �������� ����� ���������� �������...', LogGroupGUID, lmtInfo);
  case Configuration.trfReportFolder of
    rfTempFolder:
      ShellExecute(Application.Handle, 'open', PWideChar(Configuration.sTempFolder), nil, nil, SW_MAXIMIZE);
    rfApplicationFolder:
      ShellExecute(Application.Handle, 'open', PWideChar(Configuration.sApplicationFolder), nil, nil, SW_MAXIMIZE);
    rfCustomFolder:
      ShellExecute(Application.Handle, 'open', PWideChar(Configuration.sCustomFolder), nil, nil, SW_MAXIMIZE);
  else
    Routines_GenerateError('�������� ������ ��� ����������� ���� ����� ���������� �������!', sErrorMessage, bError);
  end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_AccountsExecute(Sender: TObject);
const
  LogGroupGUID: string='{124A5150-AFB3-440A-A442-B76EBAC96839}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Accounts.Caption+'"', LogGroupGUID);
  Do_OpenAccountsList;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ClearLogListExecute(Sender: TObject);
const
  LogGroupGUID: string='{A694CF78-8CE3-4F7E-B4E8-262F45815BDA}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ClearLogList.Caption+'"', LogGroupGUID);
  Do_ClearLogList;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_ClearLogList;
const
  LogGroupGUID: string='{89903EE5-7982-453C-8CCE-570E44579B9E}';
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

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
const
  LogGroupGUID: string='{7D3330ED-5483-4194-BC52-3E90851FD868}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Configuration.Caption+'"', LogGroupGUID);
  Do_Configuration;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_FlushLogToFile;
const
  LogGroupGUID: string='{018C63D4-B2CA-442C-A04C-B44479507EE6}';
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
        sl.SaveToFile(ExtractFilePath(ExpandFileName(Application.ExeName))+'overseer_'+s+'.log');
      except
        on EStringListError do
          ShowErrorBox(Handle, '�������� ������ ��� ������� ���������� ��������� � ����� "'+s+'"! ���������� � ��������������!', LogGroupGUID);
      end;
  finally
    sl.Free;
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Configuration;
const
  LogGroupGUID: string='{797493AC-5FA8-4E65-89C1-7FB0CC1C5824}';
  sModalWinName: string='�������� ���������';
var
  sErrorMessage: string;
  bError: boolean;
  ConfigurationForm: TConfigurationForm;
  iBusy: integer;
begin
  ProcedureHeader('��������� ����������� ���� '+sModalWinName, LogGroupGUID);
  bError:=False;

  ConfigurationForm:=TConfigurationForm.Create(Self);
  with ConfigurationForm do
    try
      ImageList1.GetIcon(ICON_CONFIGURATION, Icon);
      // ������ "���������"
      vleInterface.Cells[1, 1]:=Routines_GetConditionalMessage(Configuration.bAlwaysShowTrayIcon, '��', '���');
      vleInterface.Cells[1, 2]:=Routines_GetConditionalMessage(Configuration.bShowQuitConfirmation, '��', '���');
      vleInterface.Cells[1, 3]:=Routines_GetConditionalMessage(Configuration.bStoreLastLogin, '��', '���');
      vleInterface.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.bStoreLastPassword, '��', '���');
      vleInterface.Cells[1, 5]:=Routines_GetConditionalMessage(Configuration.bAutoLogon, '��', '���');
      vleInterface.Cells[1, 6]:=Routines_GetConditionalMessage(Configuration.bUseExternalLog, '��', '���');
      vleInterface.Cells[1, 7]:=Routines_GetConditionalMessage(vleInterface.ItemProps[6].PickList.IndexOf(Configuration.sDefaultAction)>-1, Configuration.sDefaultAction, '');
      vleInterface.Cells[1, 8]:=Routines_GetConditionalMessage(Configuration.bScrollToLastLogMessage, '��', '���');
      vleInterface.Cells[1, 9]:=Routines_GetConditionalMessage(Configuration.bAutorun, '��', '���');
      vleInterface.Cells[1, 10]:=Routines_GetConditionalMessage(Configuration.bStartInTray, '��', '���');
      vleInterface.Cells[1, 11]:=Routines_GetConditionalMessage(Configuration.bPlaySoundAfterAction, '��', '���');
      vleInterface.Cells[1, 12]:=Routines_GetConditionalMessage(Configuration.bShowBaloonHintAfterAction, '��', '���');

      // ������ "������ � ���� ������"
      vleOVERSEERSERVER.Cells[1, 1]:=WideString(Configuration.OverseerServer.sMySQLHost); // overseerserver
      vleOVERSEERSERVER.Cells[1, 2]:=IntToStr(Configuration.OverseerServer.iMySQLPort);
      vleOVERSEERSERVER.Cells[1, 3]:=IntToStr(Configuration.OverseerServer.iMySQLTimeout);
      vleOVERSEERSERVER.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.OverseerServer.bMySQLCompress, '��', '���');
      vleOVERSEERSERVER.Cells[1, 5]:=WideString(Configuration.OverseerServer.sMySQLDatabase);
      // vleOVERSEERSERVER.Enabled:=not Configuration.OverseerServer.bMySQLConnected;

      vleRNE4SERVER.Cells[1, 1]:=WideString(Configuration.RNE4Server.sMySQLHost); // overseerserver
      vleRNE4SERVER.Cells[1, 2]:=IntToStr(Configuration.RNE4Server.iMySQLPort);
      vleRNE4SERVER.Cells[1, 3]:=IntToStr(Configuration.RNE4Server.iMySQLTimeout);
      vleRNE4SERVER.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.RNE4Server.bMySQLCompress, '��', '���');
      vleRNE4SERVER.Cells[1, 5]:=WideString(Configuration.RNE4Server.sMySQLDatabase);

      vleDBSERVER.Cells[1, 1]:=WideString(Configuration.DBServer.sMySQLHost); // dbserver
      vleDBSERVER.Cells[1, 2]:=IntToStr(Configuration.DBServer.iMySQLPort);
      vleDBSERVER.Cells[1, 3]:=IntToStr(Configuration.DBServer.iMySQLTimeout);
      vleDBSERVER.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.DBServer.bMySQLCompress, '��', '���');
      vleDBSERVER.Cells[1, 5]:=WideString(Configuration.DBServer.sMySQLDatabase_IRD_Location);
      vleDBSERVER.Cells[1, 6]:=WideString(Configuration.DBServer.sMySQLDatabase_ORD_Location);
      vleDBSERVER.Cells[1, 7]:=WideString(Configuration.DBServer.sMySQLDatabase_PRIJAVE_Location);
      vleDBSERVER.Cells[1, 8]:=WideString(Configuration.DBServer.sMySQLDatabase_PRIJAVE_Q_Location);
      vleDBSERVER.Cells[1, 9]:=WideString(Configuration.DBServer.sMySQLDatabase_T_DAY_Location);
      // vleDBSERVER.Enabled:=not Configuration.DBServer.bMySQLConnected;

      vleSTATSERVER.Cells[1, 1]:=WideString(Configuration.StatServer.sMySQLHost); // statserver
      vleSTATSERVER.Cells[1, 2]:=IntToStr(Configuration.StatServer.iMySQLPort);
      vleSTATSERVER.Cells[1, 3]:=IntToStr(Configuration.StatServer.iMySQLTimeout);
      vleSTATSERVER.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.StatServer.bMySQLCompress, '��', '���');
      vleSTATSERVER.Cells[1, 5]:=WideString(Configuration.StatServer.sMySQLDatabase_IRD_Location); // dbserver
      vleSTATSERVER.Cells[1, 6]:=WideString(Configuration.StatServer.sMySQLDatabase_ORD_Location);
      vleSTATSERVER.Cells[1, 7]:=WideString(Configuration.StatServer.sMySQLDatabase_IRDA_Location);
      vleSTATSERVER.Cells[1, 8]:=WideString(Configuration.StatServer.sMySQLDatabase_ORDA_Location);
      vleSTATSERVER.Cells[1, 9]:=WideString(Configuration.StatServer.sMySQLDatabase_PRIJAVE_Location);
      vleSTATSERVER.Cells[1, 10]:=WideString(Configuration.StatServer.sMySQLDatabase_PRIJAVE_Q_Location);
      // vleSTATSERVER.Enabled:=not Configuration.StatServer.bMySQLConnected;
      // ������ "����������������"
      chkbxKeepInfoLog.Enabled:=not Configuration.bUseExternalLog;
      chkbxKeepErrorLog.Checked:=Configuration.bKeepErrorLog;

      chkbxKeepWarningLog.Enabled:=not Configuration.bUseExternalLog;
      chkbxKeepWarningLog.Checked:=Configuration.bKeepWarningLog;

      chkbxKeepErrorLog.Enabled:=not Configuration.bUseExternalLog;
      chkbxKeepInfoLog.Checked:=Configuration.bKeepInfoLog;

      chkbxKeepSQLLog.Enabled:=not Configuration.bUseExternalLog;
      chkbxKeepSQLLog.Checked:=Configuration.bKeepSQLLog;

      chkbxKeepDebugLog.Enabled:=not Configuration.bUseExternalLog;
      chkbxKeepDebugLog.Checked:=Configuration.bKeepDebugLog;

      chkbxFlushLogOnExit.Enabled:=not Configuration.bUseExternalLog;
      chkbxFlushLogOnExit.Checked:=Configuration.bFlushLogOnExit;

      chkbxFlushLogOnStringsQuantity.Enabled:=not Configuration.bUseExternalLog;
      chkbxFlushLogOnStringsQuantity.Checked:=Configuration.iFlushLogOnStringsQuantity>0;

      edbxFlushLogOnStringsQuantity.Enabled:=(not Configuration.bUseExternalLog)and chkbxFlushLogOnStringsQuantity.Checked;
      edbxFlushLogOnStringsQuantity.Text:=Routines_GetConditionalMessage(edbxFlushLogOnStringsQuantity.Enabled, IntToStr(Configuration.iFlushLogOnStringsQuantity), '');

      chkbxFlushLogOnClearingLog.Enabled:=not Configuration.bUseExternalLog;
      chkbxFlushLogOnClearingLog.Checked:=Configuration.bFlushLogOnClearingLog;

      chkbxFlushLogOnApply.Enabled:=not Configuration.bUseExternalLog;
      chkbxFlushLogOnApply.Checked:=False;

      // ������ "������"
      rbSaveIntoTheTempFolder.Caption:=rbSaveIntoTheTempFolder.Caption+' ('+Configuration.sTempFolder+')';
      rbSaveIntoTheTempFolder.Checked:=Configuration.trfReportFolder=rfTempFolder;
      rbSaveIntoTheApplicationFolder.Caption:=rbSaveIntoTheApplicationFolder.Caption+' ('+Configuration.sApplicationFolder+')';
      rbSaveIntoTheApplicationFolder.Checked:=Configuration.trfReportFolder=rfApplicationFolder;
      rbSaveIntoTheSelectedFolder.Checked:=Configuration.trfReportFolder=rfCustomFolder;
      edbxSelectedFolder.Text:=Routines_GetConditionalMessage(rbSaveIntoTheSelectedFolder.Checked, Configuration.sCustomFolder, '');
      chkbxDontDemandOverwriteConfirmation.Checked:=Configuration.bDontDemandOverwriteConfirmation;
      chkbxAskForFileName.Checked:=Configuration.bAskForFileName;

      PreShowModal(sModalWinName, LogGroupGUID, iBusy);
      ShowModal;
    finally
      PostShowModal(sModalWinName, LogGroupGUID, iBusy);
      Configuration.iConfigurationFormPage:=cbPage.ItemIndex;
      if ModalResult=mrOk then
        begin
          // LogThis('���� ����������� ������� ���������� �������� ���������.', LogGroupGUID, lmtDebug);
          // ������ "���������"
          Configuration.bAlwaysShowTrayIcon:=vleInterface.Cells[1, 1]='��';
          TrayIcon1.Visible:=Configuration.bAlwaysShowTrayIcon or(not MainForm.Visible);
          Configuration.bShowQuitConfirmation:=vleInterface.Cells[1, 2]='��';
          Configuration.bStoreLastLogin:=vleInterface.Cells[1, 3]='��';
          Configuration.bStoreLastPassword:=vleInterface.Cells[1, 4]='��';
          Configuration.bAutoLogon:=vleInterface.Cells[1, 5]='��';
          Configuration.bUseExternalLog:=vleInterface.Cells[1, 6]='��';
          Configuration.bScrollToLastLogMessage:=vleInterface.Cells[1, 8]='��';
          Configuration.bAutorun:=vleInterface.Cells[1, 9]='��';
          Configuration.bStartInTray:=vleInterface.Cells[1, 10]='��';
          Configuration.bPlaySoundAfterAction:=vleInterface.Cells[1, 11]='��';
          Configuration.bShowBaloonHintAfterAction:=vleInterface.Cells[1, 12]='��';

          chkbxScrollToLastLogMessage.Checked:=chkbxScrollToLastLogMessage.Enabled and Configuration.bScrollToLastLogMessage;
          pnlLog.Visible:=not Configuration.bUseExternalLog;
          MainForm.Height:=600-152*integer(Configuration.bUseExternalLog);
          Timer1.Enabled:=Configuration.bUseExternalLog;
          Configuration.sDefaultAction:=Routines_GetConditionalMessage(cbActionsList.Items.IndexOf(vleInterface.Cells[1, 7])>-1, vleInterface.Cells[1, 7], '');

          // ������ "������ � ���� ������"
          // if not Configuration.OverseerServer.bMySQLConnected then
          begin
            Configuration.OverseerServer.sMySQLHost:=vleOVERSEERSERVER.Cells[1, 1];
            Configuration.OverseerServer.iMySQLPort:=StrToIntDef(vleOVERSEERSERVER.Cells[1, 2], MYSQL_PORT);
            Configuration.OverseerServer.iMySQLTimeout:=StrToIntDef(vleOVERSEERSERVER.Cells[1, 3], 30);
            Configuration.OverseerServer.bMySQLCompress:=vleOVERSEERSERVER.Cells[1, 4]='��';
            Configuration.OverseerServer.sMySQLDatabase:=vleOVERSEERSERVER.Cells[1, 5];
          end;

          // if not Configuration.RNE4Server.bMySQLConnected then
          begin
            Configuration.RNE4Server.sMySQLHost:=vleRNE4SERVER.Cells[1, 1];
            Configuration.RNE4Server.iMySQLPort:=StrToIntDef(vleRNE4SERVER.Cells[1, 2], MYSQL_PORT);
            Configuration.RNE4Server.iMySQLTimeout:=StrToIntDef(vleRNE4SERVER.Cells[1, 3], 30);
            Configuration.RNE4Server.bMySQLCompress:=vleRNE4SERVER.Cells[1, 4]='��';
            Configuration.RNE4Server.sMySQLDatabase:=vleRNE4SERVER.Cells[1, 5];
          end;

          // if not Configuration.DBServer.bMySQLConnected then
          begin
            Configuration.DBServer.sMySQLHost:=vleDBSERVER.Cells[1, 1];
            Configuration.DBServer.iMySQLPort:=StrToIntDef(vleDBSERVER.Cells[1, 2], MYSQL_PORT);
            Configuration.DBServer.iMySQLTimeout:=StrToIntDef(vleDBSERVER.Cells[1, 3], 30);
            Configuration.DBServer.bMySQLCompress:=vleDBSERVER.Cells[1, 4]='��';
            Configuration.DBServer.sMySQLDatabase_IRD_Location:=vleDBSERVER.Cells[1, 5];
            Configuration.DBServer.sMySQLDatabase_ORD_Location:=vleDBSERVER.Cells[1, 6];
            Configuration.DBServer.sMySQLDatabase_PRIJAVE_Location:=vleDBSERVER.Cells[1, 7];
            Configuration.DBServer.sMySQLDatabase_PRIJAVE_Q_Location:=vleDBSERVER.Cells[1, 8];
            Configuration.DBServer.sMySQLDatabase_T_DAY_Location:=vleDBSERVER.Cells[1, 9];
          end;

          // if not Configuration.StatServer.bMySQLConnected then
          begin
            Configuration.StatServer.sMySQLHost:=vleSTATSERVER.Cells[1, 1];
            Configuration.StatServer.iMySQLPort:=StrToIntDef(vleSTATSERVER.Cells[1, 2], MYSQL_PORT);
            Configuration.StatServer.iMySQLTimeout:=StrToIntDef(vleSTATSERVER.Cells[1, 3], 30);
            Configuration.StatServer.bMySQLCompress:=vleSTATSERVER.Cells[1, 4]='��';
            Configuration.StatServer.sMySQLDatabase_IRD_Location:=vleSTATSERVER.Cells[1, 5];
            Configuration.StatServer.sMySQLDatabase_ORD_Location:=vleSTATSERVER.Cells[1, 6];
            Configuration.StatServer.sMySQLDatabase_IRDA_Location:=vleSTATSERVER.Cells[1, 7];
            Configuration.StatServer.sMySQLDatabase_ORDA_Location:=vleSTATSERVER.Cells[1, 8];
            Configuration.StatServer.sMySQLDatabase_PRIJAVE_Location:=vleSTATSERVER.Cells[1, 9];
            Configuration.StatServer.sMySQLDatabase_PRIJAVE_Q_Location:=vleSTATSERVER.Cells[1, 10];
          end;
          // ������ "����������������"
          Configuration.bKeepErrorLog:=chkbxKeepErrorLog.Checked;
          Configuration.bKeepWarningLog:=chkbxKeepWarningLog.Checked;
          Configuration.bKeepInfoLog:=chkbxKeepInfoLog.Checked;
          Configuration.bKeepSQLLog:=chkbxKeepSQLLog.Checked;
          Configuration.bKeepDebugLog:=chkbxKeepDebugLog.Checked;
          Configuration.bFlushLogOnExit:=chkbxFlushLogOnExit.Checked;
          Configuration.bFlushLogOnClearingLog:=chkbxFlushLogOnClearingLog.Checked;
          if chkbxFlushLogOnStringsQuantity.Checked and(StrToIntDef(edbxFlushLogOnStringsQuantity.Text, -1)>0) then
            Configuration.iFlushLogOnStringsQuantity:=StrToIntDef(edbxFlushLogOnStringsQuantity.Text, -1)
          else
            Configuration.iFlushLogOnStringsQuantity:=-1;
          // ������ "������"
          Configuration.bDontDemandOverwriteConfirmation:=chkbxDontDemandOverwriteConfirmation.Checked;
          Configuration.bAskForFileName:=chkbxAskForFileName.Checked;
          if rbSaveIntoTheTempFolder.Checked then
            Configuration.trfReportFolder:=rfTempFolder
          else
            if rbSaveIntoTheApplicationFolder.Checked then
              Configuration.trfReportFolder:=rfApplicationFolder
            else
              if rbSaveIntoTheSelectedFolder.Checked then
                begin
                  Configuration.trfReportFolder:=rfCustomFolder;
                  Configuration.sCustomFolder:=edbxSelectedFolder.Text;
                end
              else
                Routines_GenerateError('�������� ������ ��� ����������� ��������� ����� ��� ���������� �������!', sErrorMessage, bError);
          // ���� ���� �� ������� ������ "���������" (���� ���� �������� ������ �����)
          if chkbxFlushLogOnApply.Checked then
            Do_FlushLogToFile;
          LogThis('���������� �������� ��������� �������.', LogGroupGUID, lmtInfo);
        end;
      Free;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; // ������������
  var Handled: Boolean);
begin
  if Msg.message=msgLogKeeperClient then
    begin
      if Configuration.bUseExternalLog then
        PostMessage(Msg.wParam, msgLogKeeperClient, Handle, 0);
      Handled:=True;
    end;
  if Msg.message=msgLogKeeperServer then
    begin
      hLogKeeper:=Msg.wParam; // ��������� ����� ���� ������� ���������
      Handled:=True;
    end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject); // ������������
begin
  // �������� ������������� ��������� ���������������� ������ LogKeeper � ����� ��������� ������ ���� ��������� ������� ���������
  BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, msgLogKeeperServer, Handle, 0);
end;

procedure TMainForm.FormCreate(Sender: TObject); // ������������
const
  LogGroupGUID: string='{68B5F888-0DA1-4466-AFE7-9FA854AB11C7}';
var
  PanelRect: TRect;
  i: integer;
begin
  // ��������������� ������������� ����������
  SessionLogEventCount:=0; // ������������� �������� ����
  hLogKeeper:=0;
  bFirstRun:=True;

  // ����������� ������� ���������
  msgLogKeeperClient:=RegisterWindowMessage('msgLogKeeperClient');
  msgLogKeeperServer:=RegisterWindowMessage('msgLogKeeperServer');

  // ��������� ������ ��������� LogKeeper � ������ ���� ��� ��� ��������
  BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, msgLogKeeperServer, Handle, 0);
  Application.ProcessMessages; // ��������� �������� ������� ��������� (� ��� �����

  // ��������������� ������������� �����������
  THackControl(pbMain).SetParent(StatusBar1);

  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
  pbMain.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right-PanelRect.Left, PanelRect.Bottom-PanelRect.Top);
  THackControl(Image1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
  Image1.SetBounds(PanelRect.Left+1, PanelRect.Top+1, PanelRect.Right-PanelRect.Left+1, PanelRect.Bottom-PanelRect.Top+1);

  cbPhoneNet_SIC_09.ItemIndex:=0;
  cbPhoneNet_SIC_03.ItemIndex:=0;

  Update_LastDates;
  Update_DateTimeLabels;

  // ���������� ������� �����
  // ������ � ������� ���� ������� � 2004 ����!!!
  with cbChoisenMonth_Year do
    begin
      Clear;
      for i:=2004 to wLastMonth_Year do
        Items.Append(IntToStr(i));
    end;

  with cbChoisenQuarter_Year do
    begin
      Clear;
      for i:=2004 to wLastQuarter_Year do
        Items.Append(IntToStr(i));
    end;

  with cbChoisenYear do
    begin
      Clear;
      for i:=2004 to wLastYear do
        Items.Append(IntToStr(i));
    end;

  dtpChoisenDate.DateTime:=dtLastDate;
  cbChoisenMonth_Month.ItemIndex:=wLastMonth_Month-1;
  cbChoisenMonth_Year.ItemIndex:=cbChoisenMonth_Year.Items.IndexOf(IntToStr(wLastMonth_Year));

  cbChoisenQuarter_Quarter.ItemIndex:=wLastQuarter_Quarter-1;
  cbChoisenQuarter_Year.ItemIndex:=cbChoisenQuarter_Year.Items.IndexOf(IntToStr(wLastQuarter_Year));

  cbChoisenYear.ItemIndex:=cbChoisenYear.Items.IndexOf(IntToStr(wLastYear));

  cbChoisenPeriod_Start.DateTime:=dtLastDate;
  cbChoisenPeriod_Stop.DateTime:=dtLastDate;

  PageControl2.ActivePage:=tsLog;

  // ��������������� ������������� ���������� ������������
  Configuration.OverseerServer.bConnected:=False;
  Configuration.DBServer.bConnected:=False;
  Configuration.StatServer.bConnected:=False;
  Configuration.RNE4Server.bConnected:=False;
  CurrentUser.bLogged:=False;

  Configuration.sLocalHost:=Routines_GetLocalIP;
  Configuration.trfReportFolder:=rfTempFolder;
  Configuration.sCustomFolder:='';
  Configuration.sApplicationFolder:=Do_GetApplicationFolder;
  Configuration.sTempFolder:=Do_GetTempFolder;

  // ���������� ������������ �� �����
  Load_ConfigIni;

  // ������ LogKeeper � ������, ���� �� �� ��� ������
  if Configuration.bUseExternalLog and(not IsWindow(hLogKeeper)) then
    begin
      if FileExists(ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper.exe') then
        ShellExecute(Application.Handle, 'open', PWideChar(ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper.exe'), nil, nil, SW_NORMAL);
      // ���������� ��� ��������� �����
      if FileExists('D:\My Documents\RAD Studio\Projects\LogKeeper\LogKeeper.exe') then
        ShellExecute(Application.Handle, 'open', PWideChar('D:\My Documents\RAD Studio\Projects\LogKeeper\LogKeeper.exe'), nil, nil, SW_NORMAL);
      // ���������� ��� ��������� �����
    end;
  Update_Actions;
end;

procedure TMainForm.Action_LogonExecute(Sender: TObject);
const
  LogGroupGUID: string='{3BC49B0E-54F9-4E55-890C-8D2353D8BC86}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Logon.Caption+'"', LogGroupGUID);
  Do_Logon;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_LogoutExecute(Sender: TObject);
const
  LogGroupGUID: string='{4E094470-6F30-4F77-B301-B21B880E78B6}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Logout.Caption+'"', LogGroupGUID);
  Do_Logout;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_pnlConnectedMode;
begin
  pnlConnectedMode.Visible:=CurrentUser.bLogged and Action_MaximizeLogPanel.Enabled;
  Application.ProcessMessages;
end;

procedure TMainForm.Update_Actions;
const
  LogGroupGUID: string='{8BE4E5AD-0DC6-4937-81BD-BC7009C6CD52}';
begin
  ProcedureHeader('��������� ���������� ��������� �������� ���������� � ��������', LogGroupGUID);

  Action_Logon.Enabled:=not CurrentUser.bLogged;
  Action_Logon.Visible:=Action_Logon.Enabled;
  Action_Logout.Enabled:=not Action_Logon.Enabled;
  Action_Logout.Visible:=Action_Logout.Enabled;
  LogThis(PWideChar('�������� "'+Action_Logon.Caption+'" '+Routines_GetConditionalMessage(Action_Logon.Enabled, '��������', '���������')+', '+'�������� "'+Action_Logout.Caption+'" '+Routines_GetConditionalMessage(Action_Logout.Enabled, '��������',
    '���������')+'.'), LogGroupGUID, lmtDebug);
  Action_Accounts.Enabled:=CurrentUser.bLogged and CurrentUser.bIsAdmin;
  Action_Accounts.Visible:=Action_Accounts.Enabled;
  Action_Process.Enabled:=CurrentUser.bLogged;
  Action_Process.Visible:=Action_Process.Enabled;
  miActions.Visible:=Action_Process.Visible or Action_Process.Visible;
  Application.ProcessMessages;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_OpenAccountsList;
const
  LogGroupGUID: string='{1D06AD87-D4E6-4459-A73E-C6161EF94F21}';
  sModalWinName: string='���������� �������� ��������';
var
  iBusy: integer;
begin
  ProcedureHeader('��������� ����������� ���� '+sModalWinName, LogGroupGUID);

  with TAccountsForm.Create(Self) do
    try
      MainForm.ImageList1.GetIcon(ICON_ACCOUNTS, Icon);
      PreShowModal(sModalWinName, LogGroupGUID, iBusy);
      ShowModal;
    finally
      PostShowModal(sModalWinName, LogGroupGUID, iBusy);
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Logout;
const
  LogGroupGUID: string='{5B7FAC5E-2317-4C3C-BA70-CC70DFB9D333}';
begin
  ProcedureHeader('��������� ���������� ������ ������ �������� ������������', LogGroupGUID);

  CurrentUser.bLogged:=False;
  Update_Actions;
  Update_pnlConnectedMode;
  LogThis('����� ������ ������������ ��������.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Process;
const
  LogGroupGUID: string='{2B13B2D3-BAFD-4068-BA4B-83382621E5B3}';
var
  sErrorMessage: string;
  bError: boolean;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  iYear: integer;
  gbp: TGroupByPeriod;
  aXRD: tXRD;
  sTableName: string;
  iRoutineCounter: integer;
  slPhonesList, slUserList, slPayoffList, slSelectedServicesList: TStringList;
  aIRDTableRecord: trIRDTableRecord;
  iCCID: integer;
begin
  ProcedureHeader('��������� ������� ���������� ���������� ��������', LogGroupGUID);

  Action_Process.Enabled:=False;
  Application.ProcessMessages;

  bError:=False;
  wStartDay:=0;
  wStartMonth:=0;
  wStartYear:=0;
  wStopDay:=0;
  wStopMonth:=0;
  wStopYear:=0;
  gbp:=gbpNone;
  iCCID:=-1;

  // ������ ���������� ���������� �������
  if not bError then
    begin
      LogThis('>> ����������� �������� ������� ���������� ���������� �������...', LogGroupGUID, lmtDebug);
      if not(rbLastDate.Checked or rbChoisenDate.Checked or rbLastWeek.Checked or rbLastMonth.Checked or rbChoisenMonth.Checked or rbLastQuarter.Checked or rbChoisenQuarter.Checked or rbLastYear.Checked or rbChoisenYear.Checked or
        rbChoisenPeriod.Checked) then
        Routines_GenerateError('�� ��� ������ ������!', sErrorMessage, bError)
      else
        begin
          if rbLastDate.Checked then
            begin
              wStartDay:=DayOf(dtLastDate);
              wStartMonth:=MonthOf(dtLastDate);
              wStartYear:=YearOf(dtLastDate);
              wStopDay:=wStartDay;
              wStopMonth:=wStartMonth;
              wStopYear:=wStartYear;
            end;
          if rbChoisenDate.Checked then
            begin
              wStartDay:=DayOf(dtpChoisenDate.Date);
              wStartMonth:=MonthOf(dtpChoisenDate.Date);
              wStartYear:=YearOf(dtpChoisenDate.Date);
              wStopDay:=wStartDay;
              wStopMonth:=wStartMonth;
              wStopYear:=wStartYear;
            end;
          if rbLastWeek.Checked then
            begin
              wStartDay:=DayOf(dtLastWeekStart);
              wStartMonth:=MonthOf(dtLastWeekStart);
              wStartYear:=YearOf(dtLastWeekStart);
              wStopDay:=DayOf(dtLastWeekStop);
              wStopMonth:=MonthOf(dtLastWeekStop);
              wStopYear:=YearOf(dtLastWeekStop);
            end;
          if rbLastMonth.Checked then
            begin
              wStartDay:=DayOf(dtLastMonthStart);
              wStartMonth:=MonthOf(dtLastMonthStart);
              wStartYear:=YearOf(dtLastMonthStart);
              wStopDay:=DayOf(dtLastMonthStop);
              wStopMonth:=MonthOf(dtLastMonthStop);
              wStopYear:=YearOf(dtLastMonthStop);
            end;
          if rbLastQuarter.Checked then
            begin
              wStartDay:=DayOf(dtLastQuarterStart);
              wStartMonth:=MonthOf(dtLastQuarterStart);
              wStartYear:=YearOf(dtLastQuarterStart);
              wStopDay:=DayOf(dtLastQuarterStop);
              wStopMonth:=MonthOf(dtLastQuarterStop);
              wStopYear:=YearOf(dtLastQuarterStop);
            end;
          if rbLastYear.Checked then
            begin
              wStartDay:=DayOf(StartOfAYear(wLastYear));
              wStartMonth:=MonthOf(StartOfAYear(wLastYear));
              wStartYear:=YearOf(StartOfAYear(wLastYear));
              wStopDay:=DayOf(EndOfAYear(wLastYear));
              wStopMonth:=MonthOf(EndOfAYear(wLastYear));
              wStopYear:=YearOf(EndOfAYear(wLastYear));
            end;
          if rbChoisenPeriod.Checked then
            begin
              if cbChoisenPeriod_Start.Date>cbChoisenPeriod_Stop.Date then
                Routines_GenerateError('��������� ��������� ���� ('+FormatDateTime('dd.mm.yyyy', cbChoisenPeriod_Start.Date)+') ������, ��� �������� ('+FormatDateTime('dd.mm.yyyy', cbChoisenPeriod_Stop.Date)+')!', sErrorMessage, bError)
              else
                begin
                  wStartDay:=DayOf(cbChoisenPeriod_Start.Date);
                  wStartMonth:=MonthOf(cbChoisenPeriod_Start.Date);
                  wStartYear:=YearOf(cbChoisenPeriod_Start.Date);
                  wStopDay:=DayOf(cbChoisenPeriod_Stop.Date);
                  wStopMonth:=MonthOf(cbChoisenPeriod_Stop.Date);
                  wStopYear:=YearOf(cbChoisenPeriod_Stop.Date);
                end;
            end;
          if rbChoisenMonth.Checked then
            begin
              iYear:=StrToIntDef(cbChoisenMonth_Year.Items[cbChoisenMonth_Year.ItemIndex], -1);
              if iYear=-1 then
                Routines_GenerateError('�� ������� ���������� ����������� ��������� ����!', sErrorMessage, bError)
              else
                begin
                  wStartYear:=iYear;
                  wStopYear:=iYear;
                  wStartMonth:=cbChoisenMonth_Month.ItemIndex+1;
                  wStopMonth:=wStartMonth;
                  wStartDay:=DayOf(StartOfAMonth(wStartYear, wStartMonth));
                  wStopDay:=DayOf(EndOfAMonth(wStopYear, wStopMonth));
                end;
            end;
          if not bError then
            begin
              if rbChoisenQuarter.Checked then
                begin
                  iYear:=StrToIntDef(cbChoisenQuarter_Year.Items[cbChoisenQuarter_Year.ItemIndex], -1);
                  if iYear=-1 then
                    Routines_GenerateError('�� ������� ���������� ����������� ��������� ����!', sErrorMessage, bError)
                  else
                    begin
                      wStartYear:=iYear;
                      wStopYear:=iYear;
                      wStartMonth:=(cbChoisenQuarter_Quarter.ItemIndex*3)+1;
                      wStopMonth:=wStartMonth+2;
                      wStartDay:=DayOf(StartOfAMonth(wStartYear, wStartMonth));
                      wStopDay:=DayOf(EndOfAMonth(wStopYear, wStopMonth));
                    end;
                end;
            end;
          if not bError then
            begin
              if rbChoisenYear.Checked then
                begin
                  iYear:=StrToIntDef(cbChoisenYear.Items[cbChoisenYear.ItemIndex], -1);
                  if iYear=-1 then
                    Routines_GenerateError('�� ������� ���������� ����������� ��������� ����!', sErrorMessage, bError)
                  else
                    begin
                      wStartDay:=DayOf(StartOfAYear(iYear));
                      wStartMonth:=MonthOf(StartOfAYear(iYear));
                      wStartYear:=YearOf(StartOfAYear(iYear));
                      wStopDay:=DayOf(EndOfAYear(iYear));
                      wStopMonth:=MonthOf(EndOfAYear(iYear));
                      wStopYear:=YearOf(EndOfAYear(iYear));
                    end;
                end;
            end;
        end;
      LogThis('<< ���������� �������� ������� ���������� ���������� ������� ���������.', LogGroupGUID, lmtDebug);
    end;

  // ��������� ���������� �����������
  if not bError then
    begin
      LogThis('>> ����������� �������� ��������� ���������� �����������...', LogGroupGUID, lmtDebug);
      if (not(rbGroupByYears.Checked or rbGroupByQuarters.Checked or rbGroupByMonths.Checked or rbGroupByWeeks.Checked or rbGroupByDays.Checked or rbGroupByHours.Checked))and
        (rbGroupByYears.Enabled or rbGroupByQuarters.Enabled or rbGroupByMonths.Enabled or rbGroupByWeeks.Enabled or rbGroupByDays.Enabled or rbGroupByHours.Enabled) then
        Routines_GenerateError('�� ������ ������ ��� ����������� ������ ��� ������������ ������!', sErrorMessage, bError)
      else
        begin
          if rbGroupByYears.Checked then
            gbp:=gbpYears;
          if rbGroupByQuarters.Checked then
            gbp:=gbpQuarters;
          if rbGroupByMonths.Checked then
            gbp:=gbpMonths;
          if rbGroupByWeeks.Checked then
            gbp:=gbpWeeks;
          if rbGroupByDays.Checked then
            gbp:=gbpDays;
          if rbGroupByHours.Checked then
            gbp:=gbpHours;
        end;
      LogThis('<< ���������� �������� ������� ��������� ���������� ����������� ���������.', LogGroupGUID, lmtDebug);
    end;

  // ������ ������ �������� � ��� ������������� ���������� � ������ ���������� ��������
  if not bError then
    begin
      LogThis('>> ����������� �������� ������� ���������� ��������...', LogGroupGUID, lmtDebug);
      if cbActionsList.Text='������ ������ �� ������ �� ��������� ������ ���' then
        begin
          slPayoffList:=TStringList.Create;
          try
            slPayoffList.Duplicates:=dupIgnore;
            slPayoffList.Sorted:=False;
            for iRoutineCounter:=0 to lvPhonesList_Payoff.Items.Count-1 do
              if bError then
                Break
              else
                begin
                  if lvPhonesList_Payoff.Items[iRoutineCounter].Checked then
                    begin
                      if lvPhonesList_Payoff.Items[iRoutineCounter].SubItems.Count<>9 then
                        Routines_GenerateError('�� ������� ������������� ������ ������ �� ������ (������ �'+IntToStr(iRoutineCounter+1)+')!', sErrorMessage, bError)
                      else
                        begin
                          with aIRDTableRecord do
                            begin
                              ani:=lvPhonesList_Payoff.Items[iRoutineCounter].Caption;
                              ddi:=lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[0];
                              datum:=lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[1];
                              vrijeme:=lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[2];
                              dur:=lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[3];
                              rm:=lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[4];
                              izg:=Routines_GetConditionalMessage(lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[5]='��', '1', '0');
                              izgnum:=lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[6];
                              v_oper:=lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[7];
                              v_mreza:=lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[8];
                            end;
                          slPayoffList.Add(Routines_Convert_trIRDTableRecord_to_string(aIRDTableRecord));
                        end;
                    end;
                end;
            if not bError then
              if slPayoffList.Count<=0 then
                Routines_GenerateError('�� �������� �� ������ ������ ��� ���������� ��������!', sErrorMessage, bError)
              else
                if not Do_PayOff(slPayoffList) then
                  begin
                    Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);
                    Do_RefreshCallsList_Payoff;
                  end
                else
                  begin
                    for iRoutineCounter:=lvPhonesList_Payoff.Items.Count-1 downto 0 do
                      if lvPhonesList_Payoff.Items[iRoutineCounter].Checked then
                        lvPhonesList_Payoff.Items[iRoutineCounter].Delete;
                  end;
          finally
            slPayoffList.Free;
          end;
        end;

      if cbActionsList.Text='������������ ������ �� ����� � ���-01-...' then
        begin
          slPhonesList:=TStringList.Create;
          try
            slPhonesList.Duplicates:=dupIgnore;
            slPhonesList.Sorted:=False;
            for iRoutineCounter:=0 to lv_SIC_01.Items.Count-1 do
              if lv_SIC_01.Items[iRoutineCounter].SubItems.Count=2 then
                slPhonesList.Add(lv_SIC_01.Items[iRoutineCounter].SubItems[1]);
            if slPhonesList.Count<=0 then
              Routines_GenerateError('�� ������ �� ������ ������������ ������ �������� ��� ������������ ������!', sErrorMessage, bError)
            else
              if not Do_SIC_01(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, slPhonesList, cbShowUnserved_SIC_01.Checked and cbShowUnserved_SIC_01.Enabled) then
                Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);
          finally
            slPhonesList.Free;
          end;
        end;

      if cbActionsList.Text='������������ ������ �� ����� � ���-03-...' then
        if not Do_SIC_03(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, cbPhoneNet_SIC_03.ItemIndex) then
          Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);

      if cbActionsList.Text='������������ ������ �� ����� � ���-04-...' then
        begin
          slUserList:=TStringList.Create;
          try
            slUserList.Duplicates:=dupIgnore;
            slUserList.Sorted:=False;
            if rbSelectedUsers_SIC_04.Checked then
              for iRoutineCounter:=0 to clbUsers_SIC_04.Count-1 do
                if clbUsers_SIC_04.Checked[iRoutineCounter] then
                  slUserList.Add(clbUsers_SIC_04.Items[iRoutineCounter]);
            if rbSelectedUsers_SIC_04.Checked and(slUserList.Count<=0) then
              Routines_GenerateError('�� ������� �� ������ ������������ ��� ������������ ������!', sErrorMessage, bError)
            else
              if not Do_SIC_04(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, gbp, not(cbWeekStartsFromDayOfBeginning_SIC_04.Checked and cbWeekStartsFromDayOfBeginning_SIC_04.Enabled),
                rbAllUsers_SIC_04.Checked, cbCreateDetailedReport_SIC_04.Checked and cbCreateDetailedReport_SIC_04.Enabled, cbShowSQLQueries_SIC_04.Checked and cbShowSQLQueries_SIC_04.Enabled,
                cbShowIdleUsers_SIC_04.Checked and cbShowIdleUsers_SIC_04.Enabled, slUserList) then
                Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);
          finally
            slUserList.Free;
          end;
        end;

      if cbActionsList.Text='������������ ������ �� ����� � ���-05-...' then
        begin
          if (cbService_SIC_05.ItemIndex<0)and(cbService_SIC_05.ItemIndex>(aServices_Count-1)) then
            Routines_GenerateError('�� ������� ���������� ����������� �������� ������!', sErrorMessage, bError)
          else
            if not Do_SIC_05(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, gbp, cbService_SIC_05.ItemIndex,
              not(cbWeekStartsFromDayOfBeginning_SIC_05.Checked and cbWeekStartsFromDayOfBeginning_SIC_05.Enabled)) then
              Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);
        end;

      if cbActionsList.Text='������������ ������ �� ����� � ���-07-...' then
        if not Do_SIC_07(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, gbp, not(cbWeekStartsFromDayOfBeginning_SIC_07.Checked and cbWeekStartsFromDayOfBeginning_SIC_07.Enabled)) then
          Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);

      if cbActionsList.Text='������������ ������ �� ����� � ���-08-...' then
        if not Do_SIC_08(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True) then
          Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);

      if cbActionsList.Text='������������ ������ �� ����� � ���-09-...' then
        begin
          slSelectedServicesList:=TStringList.Create;
          try
            slSelectedServicesList.Duplicates:=dupIgnore;
            slSelectedServicesList.Sorted:=False;
            for iRoutineCounter:=0 to lvServices_SIC_09.Items.Count-1 do
              if lvServices_SIC_09.Items[iRoutineCounter]<>nil then
                if lvServices_SIC_09.Items[iRoutineCounter].Checked then
                  slSelectedServicesList.Add(lvServices_SIC_09.Items[iRoutineCounter].Caption);
            if slSelectedServicesList.Count<=0 then
              Routines_GenerateError('�� ������ �� ����� ������ ��� ������������ ������!', sErrorMessage, bError)
            else
              if not Do_SIC_09(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, cbPhoneNet_SIC_09.ItemIndex, cbSummaryReport_SIC_09.Enabled and cbSummaryReport_SIC_09.Checked,
                cbOldReport_SIC_09.Enabled and cbOldReport_SIC_09.Checked, slSelectedServicesList) then
                Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);
          finally
            slSelectedServicesList.Free;
          end;
        end;

      if cbActionsList.Text='������������ ������ �� ����� � ���-10-...' then
        begin
          case cbCCID_SIC_10.ItemIndex of
            0:
              iCCID:=-1;
            1:
              iCCID:=1;
            2:
              iCCID:=2;
          else
            Routines_GenerateError('�� ������� ���������������� ��������� ������ �������������!', sErrorMessage, bError);
          end;
          if not bError then
            begin
              slUserList:=TStringList.Create;
              try
                slUserList.Duplicates:=dupIgnore;
                slUserList.Sorted:=False;
                if rbSelectedUsers_SIC_10.Checked then
                  for iRoutineCounter:=0 to clbUsers_SIC_10.Count-1 do
                    if clbUsers_SIC_10.Checked[iRoutineCounter] then
                      slUserList.Add(clbUsers_SIC_10.Items[iRoutineCounter]);
                if rbSelectedUsers_SIC_10.Checked and(slUserList.Count<=0) then
                  Routines_GenerateError('�� ������� �� ������ ������������ ��� ������������ ������!', sErrorMessage, bError)
                else
                  if not Do_SIC_10(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, gbp, not(cbWeekStartsFromDayOfBeginning_SIC_10.Checked and cbWeekStartsFromDayOfBeginning_SIC_10.Enabled),
                    rbAllUsers_SIC_10.Checked, cbCreateDetailedReport_SIC_10.Checked and cbCreateDetailedReport_SIC_10.Enabled, iCCID, slUserList) then
                    Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);
              finally
                slUserList.Free;
              end;
            end;
        end;

      if cbActionsList.Text='������������ ������ ������ ��������/��������� ������� (<i/o>rd_<yyyymmdd>, <i/o>rd_<yyyy>[mm][dd][_[yyyy][mm][dd]])' then
        begin
          aXRD:=XRDInput;
          if rbIRD.Checked then
            aXRD:=XRDInput;
          if rbORD.Checked then
            aXRD:=XRDOutput;
          sTableName:=Routines_GetConditionalMessage((cbCustomNameOfXRDA.Checked)and(ebCustomNameOfXRDA.Text<>''), ebCustomNameOfXRDA.Text, '');
          if not Do_CreateXRDA(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), False, aXRD, sTableName, cbRecreateXRD.Checked, cbCreateXRDA.Checked, cbRecreateXRDA.Checked) then
            Routines_GenerateError('��������� ������ �� ��������� ������� ���������� ��������!', sErrorMessage, bError);
        end;

      if cbActionsList.Text='������������ ������ �������� ��� ����' then
        begin
          if not Do_ASKR(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay)) then
            Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!', sErrorMessage, bError);
        end;

      LogThis('<< ���������� �������� ������� ���������� �������� ���������.', LogGroupGUID, lmtDebug);
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);

  Action_Process.Enabled:=True;
  Application.ProcessMessages;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ebPhonesList_PayoffChange(Sender: TObject);
const
  LogGroupGUID: string='{70495031-A0E6-4B91-86E7-BE055A005D74}';
begin
  ProcedureHeader('��������� ������� �� ��������� ����������� ������ ����� ���������', LogGroupGUID);
  Update_Actions_Payoff;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RefreshCallsList_PayoffExecute(Sender: TObject);
const
  LogGroupGUID: string='{CCBC63CD-6CF3-4043-AC86-B6420C40BE88}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_RefreshCallsList_Payoff.Caption+'"', LogGroupGUID);
  Do_RefreshCallsList_Payoff;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_SelectAction;
const
  LogGroupGUID: string='{094455BA-D7C8-469A-9599-0DAC6D98B506}';
var
  i: integer;
begin
  ProcedureHeader('��������� ������� �� ������������ �������� ������ ��������', LogGroupGUID);

  for i:=0 to PageControl1.PageCount-1 do
    begin
      if PageControl1.Pages[i].Caption=cbActionsList.Text then
        begin
          PageControl1.ActivePageIndex:=i;
          LogThis('���� ������� �������� � ��������� <'+PageControl1.Pages[i].Caption+'>.', LogGroupGUID, lmtDebug);
        end;
    end;
  Update_GroupingState;

  // ������������� �������� ����������� ��������

  if cbActionsList.Text='������ ������ �� ������ �� ��������� ������ ���' then
    begin
      ebPhonesList_Payoff.Clear;
      lvPhonesList_Payoff.Items.BeginUpdate;
      lvPhonesList_Payoff.Clear;
      lvPhonesList_Payoff.Items.EndUpdate;
      Update_Actions_Payoff;
    end;
  if (cbActionsList.Text='������������ ������ �� ����� � ���-01-...') then
    begin
      cbShowUnserved_SIC_01.Checked:=False;
      Update_Actions_SIC_01;
    end;
  if (cbActionsList.Text='������������ ������ �� ����� � ���-02-...') then
    begin
      rbDetailedReport_SIC_02.Checked:=True;
      rbSortedReport_SIC_02.Checked:=False;
    end;
  if (cbActionsList.Text='������������ ������ �� ����� � ���-04-...') then
    begin
      rbAllUsers_SIC_04.Checked:=True;
      rbSelectedUsers_SIC_04.Checked:=False;
      with clbUsers_SIC_04 do
        begin
          Enabled:=False;
          Items.BeginUpdate;
          Clear;
          Items.EndUpdate;
        end;
      cbCreateDetailedReport_SIC_04.Checked:=False;
      cbShowSQLQueries_SIC_04.Checked:=False;
      cbShowSQLQueries_SIC_04.Enabled:=False;
      cbShowIdleUsers_SIC_04.Checked:=False;
      cbWeekStartsFromDayOfBeginning_SIC_04.Checked:=False;
      Update_Actions_SIC_04;
    end;
  if (cbActionsList.Text='������������ ������ �� ����� � ���-05-...') then
    begin
      cbService_SIC_05.ItemIndex:=0;
      cbWeekStartsFromDayOfBeginning_SIC_05.Checked:=False;
    end;
  if (cbActionsList.Text='������������ ������ �� ����� � ���-07-...') then
    begin
      cbWeekStartsFromDayOfBeginning_SIC_07.Checked:=False;
    end;
  if (cbActionsList.Text='������������ ������ �� ����� � ���-09-...') then
    begin
      cbPhoneNet_SIC_09.ItemIndex:=0;
      for i:=0 to lvServices_SIC_09.Items.Count-1 do
        lvServices_SIC_09.Items[i].Checked:=False;
      cbSummaryReport_SIC_09.Checked:=False;
      cbOldReport_SIC_09.Checked:=False;
      Update_Actions_SIC_09;
    end;
  if (cbActionsList.Text='������������ ������ �� ����� � ���-10-...') then
    begin
      cbCCID_SIC_10.ItemIndex:=0;
      rbAllUsers_SIC_10.Checked:=True;
      rbSelectedUsers_SIC_10.Checked:=False;
      with clbUsers_SIC_10 do
        begin
          Enabled:=False;
          Items.BeginUpdate;
          Clear;
          Items.EndUpdate;
        end;
      cbCreateDetailedReport_SIC_10.Checked:=False;
      cbWeekStartsFromDayOfBeginning_SIC_10.Checked:=False;
      Update_Actions_SIC_10;
    end;
  if (cbActionsList.Text='������������ ������ ������ ��������/��������� ������� (<i/o>rd_<yyyymmdd>, <i/o>rd_<yyyy>[mm][dd][_[yyyy][mm][dd]])') then
    begin
      rbIRD.Checked:=True;
      rbORD.Checked:=False;
      cbReCreateXRD.Checked:=False;
      cbReCreateXRDA.Checked:=False;
      cbCustomNameOfXRDA.Enabled:=cbReCreateXRDA.Checked;
      cbCustomNameOfXRDA.Checked:=False;
      ebCustomNameOfXRDA.Enabled:=cbCustomNameOfXRDA.Checked;
      ebCustomNameOfXRDA.Clear;
    end;

  if cbActionsList.Text='������������ ������ �������� ��� ����' then
    begin

    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_ProcessSelectedActions;
const
  LogGroupGUID: string='{6098ACEB-6014-4607-AFCC-F89006A79C25}';
var
  sErrorMessage: string;
  bError: boolean;
  // wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  // iYear: integer;
  // gbp: TGroupByPeriod;
  // iRoutineCounter: integer;
begin
  ProcedureHeader('��������� ������� ���������� ��������� �� ������ ��������', LogGroupGUID);
  bError:=False;
  // wStartDay:=1;
  // wStartMonth:=10;
  // wStartYear:=2009;
  // wStopDay:=31;
  // wStopMonth:=10;
  // wStopYear:=2009;
  // gbp:=gbpNone;

  // for iRoutineCounter:=0 to cbPhoneNet_2.Items.Count-1 do
  // if not bError then
  // if not Do_SIC_03(EncodeDate(wStartYear,wStartMonth,wStartDay), EncodeDate(wStopYear,wStopMonth,wStopDay),iRoutineCounter,False,True) then
  // Routines_GenerateError('��������� ������ �� ��������� ������� ������������ ������!',sErrorMessage,bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_GroupingState;
const
  LogGroupGUID: string='{6D94F34E-4DC9-4FC6-8F60-CF903CDBF92E}';
var
  wStartMonth, wStartYear, wStopMonth, wStopYear: word;
  bStartOfTheYear, bStartOfTheMonth, bEndOfTheYear, bEndOfTheMonth,
  // bStartOfTheWeek, bEndOfTheWeek,
  bStartOfTheQuarter, bEndOfTheQuarter: boolean;
  dtStartDate, dtStopDate: TDate;
begin
  ProcedureHeader('��������� ���������� ��������� ��������� �����������', LogGroupGUID);

  dtStartDate:=cbChoisenPeriod_Start.Date;
  dtStopDate:=cbChoisenPeriod_Stop.Date;

  wStartMonth:=MonthOf(dtStartDate);
  wStopMonth:=MonthOf(dtStopDate);
  wStartYear:=YearOf(dtStartDate);
  wStopYear:=YearOf(dtStopDate);

  bStartOfTheYear:=SameDate(StartOfTheYear(dtStartDate), dtStartDate);
  bEndOfTheYear:=SameDate(EndOfTheYear(dtStopDate), dtStopDate);
  bStartOfTheMonth:=SameDate(StartOfTheMonth(dtStartDate), dtStartDate);
  bEndOfTheMonth:=SameDate(EndOfTheMonth(dtStopDate), dtStopDate);
  bStartOfTheQuarter:=(wStartMonth in [1, 4, 7, 10])and bStartOfTheMonth;
  bEndOfTheQuarter:=(wStopMonth in [3, 6, 9, 12])and bEndOfTheMonth;
  // bStartOfTheWeek:=SameDate(StartOfTheWeek(dtStartDate), dtStartDate);
  // bEndOfTheWeek:=SameDate(EndOfTheWeek(dtStopDate), dtStopDate);

  if (cbActionsList.Text='������������ ������ �� ����� � ���-01-...')or(cbActionsList.Text='������������ ������ �� ����� � ���-03-...')or(cbActionsList.Text='������������ ������ �� ����� � ���-08-...')or
    (cbActionsList.Text='������������ ������ �� ����� � ���-09-...')or(cbActionsList.Text='������������ ������ ������ ��������/��������� ������� (<i/o>rd_<yyyymmdd>, <i/o>rd_<yyyy>[mm][dd][_[yyyy][mm][dd]])')or
    (cbActionsList.Text='������ ������ �� ������ �� ��������� ������ ���')or(cbActionsList.Text='������������ ������ �������� ��� ����') then
    begin
      gbGroupingPeriod.Visible:=False;
      rbGroupByYears.Enabled:=False;
      rbGroupByQuarters.Enabled:=False;
      rbGroupByMonths.Enabled:=False;
      rbGroupByWeeks.Enabled:=False;
      rbGroupByDays.Enabled:=False;
      rbGroupByHours.Enabled:=False;
      rbGroupByYears.Checked:=False;
      rbGroupByQuarters.Checked:=False;
      rbGroupByMonths.Checked:=False;
      rbGroupByWeeks.Checked:=False;
      rbGroupByDays.Checked:=False;
      rbGroupByHours.Checked:=False;
    end
  else
    begin
      gbGroupingPeriod.Visible:=True;
      rbGroupByDays.Checked:=True;
      // ���� ��� ������ ������ ���������� ������� ����
      if rbLastYear.Checked or rbChoisenYear.Checked or(rbChoisenPeriod.Checked and bStartOfTheYear and bEndOfTheYear and(wStartYear<=wStopYear)) then
        begin
          rbGroupByYears.Enabled:=True;
          rbGroupByQuarters.Enabled:=True;
          rbGroupByMonths.Enabled:=True;
          rbGroupByWeeks.Enabled:=True;
          rbGroupByDays.Enabled:=True;
          rbGroupByHours.Enabled:=not(cbActionsList.Text='������������ ������ �� ����� � ���-10-...');
        end
      else
        // ���� ��� ������ ������ ���������� ������� ��������
        if rbLastQuarter.Checked or rbChoisenQuarter.Checked or(rbChoisenPeriod.Checked and bStartOfTheQuarter and bEndOfTheQuarter and(((wStartYear=wStopYear)and(wStopMonth>=wStartMonth+2))or(wStartYear<wStopYear))) then
          begin
            rbGroupByYears.Enabled:=False;
            rbGroupByQuarters.Enabled:=True;
            rbGroupByMonths.Enabled:=True;
            rbGroupByWeeks.Enabled:=True;
            rbGroupByDays.Enabled:=True;
            rbGroupByHours.Enabled:=not(cbActionsList.Text='������������ ������ �� ����� � ���-10-...');
          end
        else
          // ���� ��� ������ ������ ���������� ������� ������
          if rbLastMonth.Checked or rbChoisenMonth.Checked or(rbChoisenPeriod.Checked and bStartOfTheMonth and bEndOfTheMonth and(((wStartYear=wStopYear)and(wStopMonth>=wStartMonth))or(wStartYear<wStopYear))) then
            begin
              rbGroupByYears.Enabled:=False;
              rbGroupByQuarters.Enabled:=False;
              rbGroupByMonths.Enabled:=True;
              rbGroupByWeeks.Enabled:=True;
              rbGroupByDays.Enabled:=True;
              rbGroupByHours.Enabled:=not(cbActionsList.Text='������������ ������ �� ����� � ���-10-...');
            end
          else
            // ���� ��� ������ ������ ���������� ������� ������
            if rbLastWeek.Checked or(rbChoisenPeriod.Checked
              // and bStartOfTheWeek and bEndOfTheWeek and((DaysBetween(dtStartDate, dtStopDate)mod 7)=6)) then // ����� ���������� ������ ���������� ������� ������
              and(DaysBetween(dtStartDate, dtStopDate)>=6)) then
              begin
                rbGroupByYears.Enabled:=False;
                rbGroupByQuarters.Enabled:=False;
                rbGroupByMonths.Enabled:=False;
                rbGroupByWeeks.Enabled:=True;
                rbGroupByDays.Enabled:=True;
                rbGroupByHours.Enabled:=not(cbActionsList.Text='������������ ������ �� ����� � ���-10-...');
              end
            else
              // ���� ��� ������ ������ ������������ ���������� (� ��� ����� ������ ������)
              begin
                rbGroupByYears.Enabled:=False;
                rbGroupByQuarters.Enabled:=False;
                rbGroupByMonths.Enabled:=False;
                rbGroupByWeeks.Enabled:=False;
                rbGroupByDays.Enabled:=True;
                rbGroupByHours.Enabled:=not(cbActionsList.Text='������������ ������ �� ����� � ���-10-...');
              end;
    end;

  Update_OtherGroupingStateOptions;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TimePeriodChange(Sender: TObject);
const
  LogGroupGUID: string='{64D91A01-B402-49D6-B0BE-FBB37647799A}';
begin
  ProcedureHeader('���������-���������� �������� �� ������ ����� ������� �������', LogGroupGUID);
  Update_GroupingState;
  ProcedureFooter(LogGroupGUID);
end;

function TMainForm.Do_SaveReportAsHTMLAndOpen(const aHTML, aFileName: string; const aOpenWithBrowser, aSilentYes: boolean): boolean;
const
  LogGroupGUID: string='{4F0E35A0-EF59-4352-841A-38C8A3478B2E}';
var
  sErrorMessage: string;
  bError: boolean;
  sFileFolder, sFileName: string;
  aFileTypeItem: TFileTypeItem;
begin
  ProcedureHeader('������� ���������� ������ ������ � ���� � �������� ������� ����� ��� ������ ���������������� ����������', LogGroupGUID);
  bError:=False;

  // ���������� ��������������� ������ � ���� �� ����
  // �������� ����������� ����� ��� ������ ��������
  if not bError then
    begin
      with TStringList.Create do
        try
          Text:=aHTML;
          LogThis('������������ ����� ����� ��� ���������� ������.', LogGroupGUID, lmtDebug);
          case Configuration.trfReportFolder of
            rfTempFolder:
              sFileFolder:=Configuration.sTempFolder;
            rfApplicationFolder:
              sFileFolder:=Configuration.sApplicationFolder;
            rfCustomFolder:
              sFileFolder:=Configuration.sCustomFolder;
          else
            Routines_GenerateError('�������� ������ ��� ����������� ���� ����� ���������� �������!', sErrorMessage, bError);
          end;
          sFileName:=aFileName;
          if Configuration.bAskForFileName and(not aSilentYes) then
            with TFileSaveDialog.Create(Self) do
              try
                DefaultExtension:='htm';
                DefaultFolder:=sFileFolder;
                FileName:=sFileName;
                aFileTypeItem:=FileTypes.Add;
                aFileTypeItem.DisplayName:='��������� HTML (*.htm)';
                aFileTypeItem.FileMask:='*.htm';
                aFileTypeItem:=FileTypes.Add;
                aFileTypeItem.DisplayName:='��� ����� (*.*)';
                aFileTypeItem.FileMask:='*.*';
                FileTypeIndex:=1;
                if not Configuration.bDontDemandOverwriteConfirmation then
                  Options:=[fdoOverWritePrompt];
                Title:='�������� ����� � ������� ��� ����� ��� ���������� ������';
                if not Execute then
                  Routines_GenerateError('�� ���� ������������ ��� ����� ��� ���������� ������!', sErrorMessage, bError)
                else
                  if FileName='' then
                    Routines_GenerateError('�� ���� ������� ��� ����� ��� ���������� ������!', sErrorMessage, bError)
                  else
                    sFileName:=FileName;
              finally
                Free;
              end
          else
            sFileName:=sFileFolder+sFileName;
          if not bError then
            LogThis('��� ����� ��� ���������� ������ - '+#39+sFileName+#39+'.', LogGroupGUID, lmtDebug);
          if not bError then
            if (not Configuration.bDontDemandOverwriteConfirmation)and FileExists(sFileName)and(not aSilentYes) then
              if MessageBox(Handle, PWideChar('�� ������������� ������ �������� ������������ ����?'), PWideChar('OVERSEER - ������������� ������'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)<>IDOK then
                Routines_GenerateError('�������� ������ ��� ���������� ������ � ���� '+#39+sFileName+#39+' - �������� ������ ����� �� ���� ������������ �������������!', sErrorMessage, bError);
          if not bError then
            begin
              LogThis('������������ ������� ���������� ������ � ���� '+#39+sFileName+#39+'.', LogGroupGUID, lmtInfo);
              SaveToFile(sFileName);
              if aOpenWithBrowser then
                begin
                  LogThis('������������ ������� �������� ����� ��������� �� ���������.', LogGroupGUID, lmtInfo);
                  ShellExecute(Application.Handle, 'open', PChar(sFileName), nil, nil, SW_MAXIMIZE);
                end;
            end;
        finally
          Free;
        end;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
  Do_SaveReportAsHTMLAndOpen:=not bError;
end;

procedure TMainForm.ChangeGroupping(Sender: TObject);
const
  LogGroupGUID: string='{B15EB543-3A23-488C-A185-0A581E1E4C36}';
begin
  ProcedureHeader('���������-���������� �������� �� ������ ����� ������� ����������� ������', LogGroupGUID);
  Update_OtherGroupingStateOptions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.chkbxScrollToLastLogMessageClick(Sender: TObject);
begin
  Configuration.bScrollToLastLogMessage:=chkbxScrollToLastLogMessage.Enabled and chkbxScrollToLastLogMessage.Checked;
end;

procedure TMainForm.clbUsers_SIC_04ClickCheck(Sender: TObject);
begin
  Update_Actions_SIC_04;
end;

procedure TMainForm.clbUsers_SIC_10ClickCheck(Sender: TObject);
begin
  Update_Actions_SIC_10;
end;

procedure TMainForm.Update_OtherGroupingStateOptions;
const
  LogGroupGUID: string='{09BA9D1A-959A-43A9-93B5-5AB3682ED328}';
begin
  ProcedureHeader('��������� ���������� ��������� ��������� �����������', LogGroupGUID);

  cbWeekStartsFromDayOfBeginning_SIC_04.Enabled:=rbGroupByWeeks.Checked;
  cbWeekStartsFromDayOfBeginning_SIC_05.Enabled:=rbGroupByWeeks.Checked;
  cbWeekStartsFromDayOfBeginning_SIC_07.Enabled:=rbGroupByWeeks.Checked;
  cbWeekStartsFromDayOfBeginning_SIC_10.Enabled:=rbGroupByWeeks.Checked;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_AddPhones_SIC_01Execute(Sender: TObject);
const
  LogGroupGUID: string='{D597F336-3C58-4F49-B539-F7A762F101FE}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_AddPhones_SIC_01.Caption+'"', LogGroupGUID);
  Do_AddPhones_SIC_01;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_DeletePhone_SIC_01Execute(Sender: TObject);
const
  LogGroupGUID: string='{7795C5E0-3800-46AD-9C82-E823D717678B}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_DeletePhone_SIC_01.Caption+'"', LogGroupGUID);
  Do_DeletePhone_SIC_01;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ClearPhones_SIC_01Execute(Sender: TObject);
const
  LogGroupGUID: string='{7795C5E0-3800-46AD-9C82-E823D717678B}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_ClearPhones_SIC_01.Caption+'"', LogGroupGUID);
  Do_ClearPhones_SIC_01;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_DeletePhone_SIC_01;
const
  LogGroupGUID: string='{9A7069A9-67FC-47C8-8FAA-817DFBA5BD49}';
begin
  ProcedureHeader('��������� �������� �������� �� ������', LogGroupGUID);

  if lv_SIC_01.ItemIndex>-1 then
    begin
      lv_SIC_01.Items.BeginUpdate;
      if lv_SIC_01.Selected<>nil then
        lv_SIC_01.Selected.Delete;
      lv_SIC_01.Items.EndUpdate;
      Update_PhonesOrderNumbers_SIC_01;
      Update_Actions_SIC_01;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_ClearPhones_SIC_01;
const
  LogGroupGUID: string='{D2160763-1ED1-47B8-AB45-762FA3053169}';
begin
  ProcedureHeader('��������� ������� ������ ���������', LogGroupGUID);

  if lv_SIC_01.Items.Count>0 then
    begin
      lv_SIC_01.Items.BeginUpdate;
      lv_SIC_01.Items.Clear;
      lv_SIC_01.Items.EndUpdate;
      Update_Actions_SIC_01;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.lv_SIC_01SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
const
  LogGroupGUID: string='{A1B86688-0229-4360-BBF3-BF03E4194741}';
begin
  ProcedureHeader('��������� ������� �� ����� �������� ������ ���������', LogGroupGUID);
  Update_Actions_SIC_01;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.eb_SIC_01Change(Sender: TObject);
const
  LogGroupGUID: string='{9069FB29-ECAB-4F24-BA7A-1B1B3FE43606}';
begin
  ProcedureHeader('��������� ������� �� ��������� ����������� ������ ����� ���������', LogGroupGUID);
  Update_Actions_SIC_01;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_AddPhones_SIC_01;
const
  LogGroupGUID: string='{3B53509B-4E9F-4C5F-BBAE-67A44B6C3485}';
var
  aSL: TStringList;
  s: string;
  i: integer;
  ListItem: TListItem;
begin
  ProcedureHeader('��������� ���������� ��������� � ������', LogGroupGUID);

  s:=Routines_ValidatePhoneString(eb_SIC_01.Text);
  aSL:=TStringList.Create;
  try
    aSL.Duplicates:=dupIgnore;
    aSL.Sorted:=False;
    Routines_CutStringByLimiterToStringList(s, aSL, ' ');
    for i:=0 to aSL.Count-1 do
      begin
        ListItem:=lv_SIC_01.Items.Add;
        ListItem.Caption:='';
        ListItem.SubItems.Add('');
        ListItem.SubItems.Add(aSL[i]);
      end;
    Update_PhonesOrderNumbers_SIC_01;
    eb_SIC_01.Clear;
  finally
    aSl.Free;
  end;
  Update_Actions_SIC_01;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_PhonesOrderNumbers_SIC_01;
const
  LogGroupGUID: string='{E1AC0977-93C6-4D72-8D91-569246873352}';
var
  i: integer;
begin
  ProcedureHeader('��������� �������������� ���������� ������� ��������� � ������', LogGroupGUID);

  lv_SIC_01.Items.BeginUpdate;
  for i:=0 to lv_SIC_01.Items.Count-1 do
    if lv_SIC_01.Items[i].SubItems.Count>0 then
      lv_SIC_01.Items[i].SubItems[0]:=IntToStr(i+1);
  lv_SIC_01.Items.EndUpdate;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CommentsExecute(Sender: TObject);
const
  LogGroupGUID: string='{82BFA78B-8D10-4F5D-96CF-94655DEB8880}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Comments.Caption+'"', LogGroupGUID);
  Do_Comments;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbCreateDetailedReport_SIC_04Click(Sender: TObject);
const
  LogGroupGUID: string='{590E669D-89A0-4D4E-9A75-A6FFCD6D1FAE}';
begin
  ProcedureHeader('��������� ������� �� ������������ ��������� ������ "'+cbCreateDetailedReport_SIC_04.Caption+'"', LogGroupGUID);

  cbShowSQLQueries_SIC_04.Enabled:=cbCreateDetailedReport_SIC_04.Checked;
  if not cbShowSQLQueries_SIC_04.Enabled then
    cbShowSQLQueries_SIC_04.Checked:=False;
  LogThis('������ "'+cbCreateDetailedReport_SIC_04.Caption+'" '+Routines_GetConditionalMessage(cbCreateDetailedReport_SIC_04.Checked, '�������', '��������')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RefreshUserList_SIC_04Execute(Sender: TObject);
const
  LogGroupGUID: string='{8B252F54-5DD5-4D0C-ADC7-9B169CD47862}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_RefreshUserList_SIC_04.Caption+'"', LogGroupGUID);
  Do_RefreshUserList_SIC_04;
  Update_Actions_SIC_04;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RefreshUserList_SIC_10Execute(Sender: TObject);
const
  LogGroupGUID: string='{1AB0BDE1-08FB-41B5-A116-662EC4B11032}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_RefreshUserList_SIC_10.Caption+'"', LogGroupGUID);
  Do_RefreshUserList_SIC_10;
  Update_Actions_SIC_10;
  ProcedureFooter(LogGroupGUID);
end;

function TMainForm.Do_CreateXRDA(const aStartDate, aStopDate: TDate; const aSilentYes: boolean; const aXRD: tXRD; var aTableName: string; const bRecreateXRD: boolean; const bCreateXRDA, bRecreateXRDA: boolean): boolean;
const
  LogGroupGUID: string='{A98BEE49-03AB-44A4-BA81-633908F5B06E}';
var
  ResultSet, ResultSet2: PMYSQL_RES;
  ResultRow, ResultRow2: PMYSQL_ROW;
  q, sCreateQuery, sLockQuery: string;
  iRoutineCounter, iFullListCounter, iMissedListCounter, iSourceRowCounter, iRowCountSource, iRowCountDestination: integer;
  sErrorMessage: string;
  bError: boolean;
  sXRDATableName: string;
  bXRDATableExists: boolean;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  bStartOfTheYear, bStartOfTheMonth, bEndOfTheYear, bEndOfTheMonth: boolean;
  dtDate: TDate;
  slXRDFullList, slXRDMissedList: TStringList;
  cXRDPrefix: char;
  sSTATSERVER_XRD_Location, sSTATSERVER_XRDA_Location, sDBSERVER_XRD_Location: string;
  sMessage: string;
begin
  ProcedureHeader('��������� (����)������������ ������ ������ ��������/��������� ������� (ird[a]/orda[a])', LogGroupGUID);
  bError:=False;
  bXRDATableExists:=False;
  iRowCountDestination:=-1;
  iRowCountSource:=-1;
  cXRDPrefix:=#0;

  case aXRD of
    XRDInput:
      begin
        cXRDPrefix:='i';
        sSTATSERVER_XRD_Location:=Configuration.StatServer.sMySQLDatabase_IRD_Location;
        sSTATSERVER_XRDA_Location:=Configuration.StatServer.sMySQLDatabase_IRDA_Location;
        sDBSERVER_XRD_Location:=Configuration.DBServer.sMySQLDatabase_IRD_Location;
      end;
    XRDOutput:
      begin
        cXRDPrefix:='o';
        sSTATSERVER_XRD_Location:=Configuration.StatServer.sMySQLDatabase_ORD_Location;
        sSTATSERVER_XRDA_Location:=Configuration.StatServer.sMySQLDatabase_ORDA_Location;
        sDBSERVER_XRD_Location:=Configuration.DBServer.sMySQLDatabase_ORD_Location;
      end;
  end;

  wStartDay:=DayOf(aStartDate);
  wStartMonth:=MonthOf(aStartDate);
  wStartYear:=YearOf(aStartDate);
  wStopDay:=DayOf(aStopDate);
  wStopMonth:=MonthOf(aStopDate);
  wStopYear:=YearOf(aStopDate);

  bStartOfTheYear:=SameDate(StartOfTheYear(aStartDate), aStartDate);
  bStartOfTheMonth:=SameDate(StartOfTheMonth(aStartDate), aStartDate);
  bEndOfTheYear:=SameDate(EndOfTheYear(aStopDate), aStopDate);
  bEndOfTheMonth:=SameDate(EndOfTheMonth(aStopDate), aStopDate);

  InitProgressBar(1);
  // ����������� � STATSERVER
  MySQL_OpenConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
  StepProgressBar; //

  // ������������ ����� ������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]], ���� ����� (����)����������� XRDA
  if (not bError)and(bCreateXRDA or bRecreateXRDA) then
    begin
      LogThis('>> ����������� �������� ��������� ����� ������� ������ xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]...', LogGroupGUID, lmtDebug);
      if aTableName<>'' then
        sXRDATableName:=aTableName
      else
        begin
          // ���� ��������� ���� �������� ������� ���� � �������� �������� ������ ����
          if bStartOfTheYear and bEndOfTheYear and(wStartYear=wStopYear) then
            sXRDATableName:=cXRDPrefix+'rda_'+FormatDateTime('yyyy', aStartDate)
          else
            // ���� ��������� ���� �������� ������� ������ � �������� �������� ������ ������
            if bStartOfTheMonth and bEndOfTheMonth and(wStartYear=wStopYear)and(wStartMonth=wStopMonth) then
              sXRDATableName:=cXRDPrefix+'rda_'+FormatDateTime('yyyymm', aStartDate)
            else
              // ���� ��������� ���� � �������� ���������
              if (wStartYear=wStopYear)and(wStartMonth=wStopMonth)and(wStartDay=wStopDay) then
                sXRDATableName:=cXRDPrefix+'rda_'+FormatDateTime('yyyymmdd', aStartDate)
              else
                sXRDATableName:=cXRDPrefix+'rda_'+FormatDateTime('yyyymmdd', aStartDate)+'_'+FormatDateTime('yyyymmdd', aStopDate);
        end;
      aTableName:=sXRDATableName;
      LogThis('��������������� ��� ������� ������ xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] ����� "'+sXRDATableName+'".', LogGroupGUID, lmtDebug);
      LogThis('<< ���������� �������� ��������� ����� ������� ������ xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] ���������.', LogGroupGUID, lmtDebug);

      // �������� ������� ������� ������� ������ xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]], ���� ����� (����)����������� XRDA
      LogThis('>> ����������� �������� �������� ������� ������� ������ "'+sXRDATableName+'" � ���� ������...', LogGroupGUID, lmtDebug);
      if not Configuration.StatServer.bConnected then
        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(Configuration.StatServer.hConnection)<>0 then
            Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
          else
            begin
              q:='SHOW TABLES FROM '+sSTATSERVER_XRDA_Location+' LIKE "'+LowerCase(sXRDATableName)+'";';
              LogThis(q, LogGroupGUID, lmtSQL);
              if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
              else
                begin
                  LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                  ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
                  if ResultSet=nil then
                    Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                  else
                    begin
                      LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                      iRoutineCounter:=mysql_num_rows(ResultSet);
                      LogThis('���������� ����� ������� ����� '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                      if iRoutineCounter<0 then
                        Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                      else
                        begin
                          if (iRoutineCounter<0)or(iRoutineCounter>1) then
                            Routines_GenerateError('���������� ����� ������� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (0 ��� 1)!', sErrorMessage, bError)
                          else
                            begin
                              LogThis('���������� ����� ������� ������������� ���������� (0 ��� 1).', LogGroupGUID, lmtDebug);
                              if iRoutineCounter=0 then
                                begin
                                  bXRDATableExists:=False;
                                  LogThis('������� ������� �� ���� �������!', LogGroupGUID, lmtWarning);
                                end
                              else
                                begin
                                  ResultRow:=mysql_fetch_row(ResultSet);
                                  if ResultRow=nil then
                                    Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!', sErrorMessage, bError)
                                  else
                                    begin
                                      if LowerCase(string(ResultRow[0]))<>LowerCase(sXRDATableName) then
                                        Routines_GenerateError('���������� ��� ������� ������ �� ������������� ����������!', sErrorMessage, bError)
                                      else
                                        begin
                                          bXRDATableExists:=True;
                                          LogThis('������� ������� ������ ��������� �������.', LogGroupGUID, lmtDebug);
                                        end;
                                    end;
                                end;
                            end;
                        end;
                      mysql_free_result(ResultSet);
                      LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                    end;
                end;
            end;
        end;
      LogThis('<< ���������� �������� �������� ������� ������� ������ "'+sXRDATableName+'" � ���� ������ ���������.', LogGroupGUID, lmtDebug);
      StepProgressBar;
    end;

  if not bError then
    begin
      slXRDFullList:=TStringList.Create;
      try
        // ���� ��� ������� xrda � ����� � ���������, ���� ����� ������������� xrd ��� xrda
        if (((not bXRDATableExists)and bCreateXRDA)or bRecreateXRD or bRecreateXRDA) then
          begin
            // C���������� ������ ������ xrd_<yyyymmdd>, ������� ������ ���� �� ������� STATSERVER (� ��� ����� ��� ������������ ������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]])
            LogThis('>> ����������� �������� ����������� ������ ������ ������ ��� �������� �� ������� � ���� ������...', LogGroupGUID, lmtDebug);
            dtDate:=aStartDate;
            repeat
              slXRDFullList.Add(cXRDPrefix+'rd_'+FormatDateTime('yyyymmdd', dtDate));
              dtDate:=IncDay(dtDate, 1);
            until dtDate>aStopDate;
            LogThis('��������� ���������� ����� ������ ������ ������ ����� '+IntToStr(slXRDFullList.Count)+'.', LogGroupGUID, lmtDebug);
            LogThis('<< ���������� �������� ����������� ������ ������ ������ ��� �������� �� ������� � ���� ������ ���������.', LogGroupGUID, lmtDebug);

            slXRDMissedList:=TStringList.Create;
            try
              // ����������� �������� ������� ���� ������ xrd_<yyyymmdd> �� ���������� ������ �� ������� STATSERVER � ������������ ������ ����������� ������
              LogThis('>> ����������� �������� ����������� ������ ����������� ������ ������...', LogGroupGUID, lmtDebug);

              if bRecreateXRD then
                begin
                  // � ������ ���� ����� ��������������� ��� ������� xrd_<yyyymmdd> - ��������� � ������ ����������� ���� ������ �����������
                  slXRDMissedList.AddStrings(slXRDFullList);
                end
              else
                begin
                  for iFullListCounter:=0 to slXRDFullList.Count-1 do
                    if bError then
                      Break
                    else
                      begin
                        LogThis('>> ����������� �������� �������� ������� ������� ������ "'+slXRDFullList[iFullListCounter]+'" � ���� ������...', LogGroupGUID, lmtDebug);
                        if not Configuration.StatServer.bConnected then
                          Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                        else
                          begin
                            if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                              Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                            else
                              begin
                                q:='SHOW TABLES FROM '+sSTATSERVER_XRD_Location+' LIKE "'+LowerCase(slXRDFullList[iFullListCounter])+'";';
                                LogThis(q, LogGroupGUID, lmtSQL);
                                if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                  Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                                else
                                  begin
                                    LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                    ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
                                    if ResultSet=nil then
                                      Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                        iRoutineCounter:=mysql_num_rows(ResultSet);
                                        LogThis('���������� ����� ������� ����� '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                        if iRoutineCounter<0 then
                                          Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                        else
                                          begin
                                            if (iRoutineCounter<0)or(iRoutineCounter>1) then
                                              Routines_GenerateError('���������� ����� ������� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (0 ��� 1)!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('���������� ����� ������� ������������� ���������� (0 ��� 1).', LogGroupGUID, lmtDebug);
                                                if iRoutineCounter=0 then
                                                  begin
                                                    slXRDMissedList.Add(slXRDFullList[iFullListCounter]);
                                                    LogThis('������� ������� ������ ('+sSTATSERVER_XRD_Location+'.'+slXRDFullList[iFullListCounter]+') �� ���� �������!', LogGroupGUID, lmtWarning);
                                                  end
                                                else
                                                  begin
                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                    if ResultRow=nil then
                                                      Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!', sErrorMessage, bError)
                                                    else
                                                      if LowerCase(string(ResultRow[0]))<>LowerCase(slXRDFullList[iFullListCounter]) then
                                                        Routines_GenerateError('���������� ��� ������� ������ �� ������������� ����������!', sErrorMessage, bError)
                                                      else
                                                        LogThis('������� ������� ������ ��������� �������.', LogGroupGUID, lmtDebug);
                                                  end;
                                              end;
                                          end;
                                        mysql_free_result(ResultSet);
                                        LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                      end;
                                  end;
                              end;
                          end;
                        LogThis('<< ���������� �������� �������� ������� ������� ������ "'+slXRDFullList[iFullListCounter]+'" � ���� ������ ���������.', LogGroupGUID, lmtDebug);
                      end;
                end;
              if not bError then
                LogThis('���������� ����������� ������ ������ ����� '+IntToStr(slXRDMissedList.Count)+'.', LogGroupGUID, lmtWarning);
              LogThis('<< ���������� �������� ����������� ������ ����������� ������ ������ ���������.', LogGroupGUID, lmtDebug);

              // � ������, ���� �� ������ ��������� ������ xrd_<yyyymmdd>:
              if (not bError)and(slXRDMissedList.Count>0) then
                begin
                  // ����������� � DBSERVER
                  MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                  StepProgressBar;

                  if not bError then
                    begin
                      // ����������� ���������� �������� �� �������� ������ ������ xrd_<yyyymmdd>
                      for iMissedListCounter:=0 to slXRDMissedList.Count-1 do
                        if bError then
                          Break
                        else
                          begin
                            // �������� ������� �������� ������� xrd_<yyyymmdd> �� DBSERVER
                            LogThis('>> ����������� �������� �������� ������� ������� ������ "'+slXRDMissedList[iMissedListCounter]+'" � ���� ������...', LogGroupGUID, lmtDebug);
                            if not Configuration.DBServer.bConnected then
                              Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                            else
                              begin
                                if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                                  Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    q:='SHOW TABLES FROM '+sDBSERVER_XRD_Location+' LIKE "'+LowerCase(slXRDMissedList[iMissedListCounter])+'";';
                                    LogThis(q, LogGroupGUID, lmtSQL);
                                    if mysql_real_query(Configuration.DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                      Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                        ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                        if ResultSet=nil then
                                          Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                            iRoutineCounter:=mysql_num_rows(ResultSet);
                                            LogThis('���������� ����� ������� ����� '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                            if iRoutineCounter<0 then
                                              Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                            else
                                              begin
                                                if iRoutineCounter<>1 then
                                                  begin
                                                    LogThis('���������� ����� ������� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (1)!', LogGroupGUID, lmtDebug);
                                                    Routines_GenerateError('������� ������� ������  ('+sDBSERVER_XRD_Location+'.'+slXRDMissedList[iMissedListCounter]+') �� ���� �������!', sErrorMessage, bError);
                                                  end
                                                else
                                                  begin
                                                    LogThis('���������� ����� ������� ������������� ���������� (1).', LogGroupGUID, lmtDebug);
                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                    if ResultRow=nil then
                                                      Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        if LowerCase(string(ResultRow[0]))<>LowerCase(slXRDMissedList[iMissedListCounter]) then
                                                          Routines_GenerateError('���������� ��� ������� ������ �� ������������� ����������!', sErrorMessage, bError)
                                                        else
                                                          LogThis('������� ������� ������ ��������� �������.', LogGroupGUID, lmtDebug);
                                                      end;
                                                  end;
                                              end;
                                            mysql_free_result(ResultSet);
                                            LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                          end;
                                      end;
                                  end;
                              end;
                            LogThis('<< ���������� �������� �������� ������� ������� ������ "'+slXRDMissedList[iMissedListCounter]+'" � ���� ������ ���������.', LogGroupGUID, lmtDebug);
                            StepProgressBar;

                            // ��������� ������ ������� �� �������� ��������� ������������� ������� xrd_<yyyymmdd> �� ������ ������������
                            if not bError then
                              begin
                                LogThis('>> ����������� �������� ��������� ������� �� �������� ��������� ����������� ������� ������...', LogGroupGUID, lmtDebug);
                                if not Configuration.DBServer.bConnected then
                                  Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                                      Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SHOW CREATE TABLE '+sDBSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+';';
                                        LogThis(q, LogGroupGUID, lmtSQL);
                                        if mysql_real_query(Configuration.DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                            if ResultSet=nil then
                                              Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                                iRoutineCounter:=mysql_num_rows(ResultSet);
                                                LogThis('���������� ����� ������� ����� '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                                if iRoutineCounter<0 then
                                                  Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    if iRoutineCounter>1 then
                                                      Routines_GenerateError('���������� ����� ������� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!', sErrorMessage, bError)
                                                        else
                                                          if ResultRow[1]='' then
                                                            Routines_GenerateError('�������� ������ ��� ��������� ������ ������� �� �������� ��������� ����������� ������� ������!', sErrorMessage, bError)
                                                          else
                                                            begin
                                                              sCreateQuery:=StringReplace(StringReplace(StringReplace(string(ResultRow[1]), #$A, '', [rfReplaceAll]), '`', '', [rfReplaceAll]), 'CREATE TABLE '+cXRDPrefix+'rd_',
                                                                'CREATE TABLE '+sSTATSERVER_XRD_Location+'.'+cXRDPrefix+'rd_', [rfReplaceAll]);
                                                              LogThis('������ �� �������� ����������� ������� ������ ������� �������.', LogGroupGUID, lmtDebug);
                                                            end;
                                                      end;
                                                  end;
                                              end;
                                            mysql_free_result(ResultSet);
                                            LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                          end;
                                      end;
                                  end;
                                LogThis('<< ���������� �������� ��������� ������� �� �������� ��������� ����������� ������� ������ ���������.', LogGroupGUID, lmtDebug);
                                StepProgressBar;

                                if not bError then
                                  begin
                                    // ��������������� �������� ������� xrd_<yyyymmdd> �� STATSERVER ��� � �������
                                    MySQL_DropTable(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, //
                                      'DROP TABLE IF EXISTS '+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+';'); //
                                    StepProgressBar;

                                    if not bError then
                                      begin
                                        // �������� ������� xrd_<yyyymmdd> �� STATSERVER
                                        MySQL_CreateTable(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, sCreateQuery); //
                                        StepProgressBar;

                                        if not bError then
                                          begin
                                            // �������� c������a ������� xrd_<yyyymmdd> �� STATSERVER
                                            MySQL_CheckTableExistance(LogGroupGUID, Configuration.StatServer, sSTATSERVER_XRD_Location, bError, sErrorMessage, LowerCase(slXRDMissedList[iMissedListCounter]));
                                            StepProgressBar;

                                            if not bError then
                                              begin
                                                // ������������ ������� �� DBSERVER �� ������
                                                MySQL_LockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage, sDBSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+' READ');
                                                StepProgressBar;

                                                if not bError then
                                                  begin
                                                    // ������������ ������ �� STATSERVER �� ������
                                                    MySQL_LockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+' WRITE');
                                                    StepProgressBar;
                                                  end;
                                              end;
                                          end;
                                      end;
                                  end;
                              end;

                            // ������� ������ �� ������� � DBSERVER � ������� �� STATSERVER
                            if not bError then
                              begin
                                // ��������� ������ �� ������� �� DBSERVER
                                LogThis('>> ����������� �������� ��������� ������� ������� ������ "'+LowerCase(slXRDMissedList[iMissedListCounter])+'"...', LogGroupGUID, lmtDebug);
                                if not Configuration.DBServer.bConnected then
                                  Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                                      Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT * FROM '+sDBSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+';';
                                        LogThis(q, LogGroupGUID, lmtSQL);
                                        if mysql_real_query(Configuration.DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                            if ResultSet=nil then
                                              Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                                iRowCountSource:=mysql_num_rows(ResultSet);
                                                LogThis('���������� ����� ������� ����� '+IntToStr(iRowCountSource)+'.', LogGroupGUID, lmtDebug);
                                                if iRowCountSource<0 then
                                                  Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    InitProgressBar(iRowCountSource);
                                                    for iSourceRowCounter:=0 to iRowCountSource-1 do
                                                      if bError then
                                                        Break
                                                      else
                                                        begin
                                                          LogThis('��������� ��������� ������ ������� ('+IntToStr(iSourceRowCounter)+').', LogGroupGUID, lmtDebug);
                                                          ResultRow:=mysql_fetch_row(ResultSet);
                                                          if ResultRow=nil then
                                                            Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iSourceRowCounter)+')!', sErrorMessage, bError)
                                                          else
                                                            begin
                                                              LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iSourceRowCounter)+') ������ �������.', LogGroupGUID, lmtDebug);

                                                              // ������� ��������� ������ ������ � ������� �� STATSERVER
                                                              iRoutineCounter:=MySQL_InsertRecords(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, //
                                                                'INSERT INTO '+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+' ' //
                                                                +'VALUES (' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[0]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[1]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[2]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[3]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[4]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[5]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[6]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[7]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[8]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[9]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[10]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[11]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[12]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[13]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[14]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[15]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[16]), True, False)+', ' //
                                                                +Routines_NormalizeStringForQuery(string(ResultRow[17]), True, False)+');');
                                                              if iRoutineCounter<>1 then
                                                                Routines_GenerateError('���������� ������������ ����� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (1)!', sErrorMessage, bError);

                                                              // �������� ��������� ����������� � ������� �� STATSERVER ������ ������
                                                              if not bError then
                                                                begin
                                                                  LogThis('>> ����������� �������� �������� ������, �������� � ������� '+LowerCase(slXRDMissedList[iMissedListCounter])+'...', LogGroupGUID, lmtDebug);
                                                                  if not Configuration.StatServer.bConnected then
                                                                    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                                  else
                                                                    begin
                                                                      if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                                                        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                                                      else
                                                                        begin
                                                                          q:='SELECT * FROM '+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+' ' //
                                                                            +'WHERE' //
                                                                            +' ani='+Routines_NormalizeStringForQuery(string(ResultRow[0]), True, False) //
                                                                            +' AND ddi='+Routines_NormalizeStringForQuery(string(ResultRow[1]), True, False) //
                                                                            +' AND datum='+Routines_NormalizeStringForQuery(string(ResultRow[2]), True, False) //
                                                                            +' AND vrijeme='+Routines_NormalizeStringForQuery(string(ResultRow[3]), True, False) //
                                                                            +' AND dur='+Routines_NormalizeStringForQuery(string(ResultRow[4]), True, False) //
                                                                            +' AND rc='+Routines_NormalizeStringForQuery(string(ResultRow[5]), True, False) //
                                                                            +' AND srv='+Routines_NormalizeStringForQuery(string(ResultRow[6]), True, False) //
                                                                            +' AND rm='+Routines_NormalizeStringForQuery(string(ResultRow[7]), True, False) //
                                                                            +' AND izg='+Routines_NormalizeStringForQuery(string(ResultRow[8]), True, False) //
                                                                            +' AND izgnum='+Routines_NormalizeStringForQuery(string(ResultRow[9]), True, False) //
                                                                            +' AND druga_info='+Routines_NormalizeStringForQuery(string(ResultRow[10]), True, False) //
                                                                            +' AND v_oper='+Routines_NormalizeStringForQuery(string(ResultRow[11]), True, False) //
                                                                            +' AND v_mreza='+Routines_NormalizeStringForQuery(string(ResultRow[12]), True, False) //
                                                                            +' AND qid='+Routines_NormalizeStringForQuery(string(ResultRow[13]), True, False) //
                                                                            +' AND ccid='+Routines_NormalizeStringForQuery(string(ResultRow[14]), True, False) //
                                                                            +' AND d_qid='+Routines_NormalizeStringForQuery(string(ResultRow[15]), True, False) //
                                                                            +' AND d_ccid='+Routines_NormalizeStringForQuery(string(ResultRow[16]), True, False) //
                                                                            +' AND qdur='+Routines_NormalizeStringForQuery(string(ResultRow[17]), True, False)+';'; //
                                                                          LogThis(q, LogGroupGUID, lmtSQL);
                                                                          if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                                            Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                                                              ResultSet2:=mysql_store_result(Configuration.StatServer.hConnection);
                                                                              if ResultSet2=nil then
                                                                                Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                                                                iRoutineCounter:=mysql_num_rows(ResultSet2);
                                                                                LogThis('���������� ����� ������� ����� '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                                                                if iRoutineCounter<0 then
                                                                                Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                if iRoutineCounter<>1 then
                                                                                Routines_GenerateError('���������� ����� ������� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (1)!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('���������� ����� ������� ������������� ����������.', LogGroupGUID, lmtDebug);
                                                                                LogThis('�������� ������, �������� � ������� '+LowerCase(slXRDMissedList[iMissedListCounter])+' ��������� �������.', LogGroupGUID, lmtDebug);
                                                                                end;
                                                                                end;
                                                                                mysql_free_result(ResultSet2);
                                                                                LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                                                                end;
                                                                            end;
                                                                        end;
                                                                    end;
                                                                  LogThis('<< ���������� �������� �������� ������, �������� � ������� '+LowerCase(slXRDMissedList[iMissedListCounter])+' ���������.', LogGroupGUID, lmtDebug);
                                                                end;
                                                              StepProgressBar;
                                                            end;
                                                        end;
                                                  end;
                                                mysql_free_result(ResultSet);
                                                LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                              end;
                                          end;
                                      end;
                                  end;
                                LogThis('<< ���������� �������� ��������� ������� ������� ������ "'+LowerCase(slXRDMissedList[iMissedListCounter])+'" ���������.', LogGroupGUID, lmtDebug);
                                StepProgressBar;
                              end;

                            // ��������� ��������� ���������� ����� � ��������
                            // ��������� ���������� ����� � ������� �� ������� STATSERVER
                            if not bError then
                              begin
                                LogThis('>> ����������� �������� ��������� ���������� ������� ������� ������ "'+LowerCase(slXRDMissedList[iMissedListCounter])+'"...', LogGroupGUID, lmtDebug);
                                if not Configuration.StatServer.bConnected then
                                  Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                      Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT COUNT(*) FROM '+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+';';
                                        LogThis(q, LogGroupGUID, lmtSQL);
                                        if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
                                            if ResultSet=nil then
                                              Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                                iRoutineCounter:=mysql_num_rows(ResultSet);
                                                LogThis('���������� ����� ������� ����� '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                                if iRoutineCounter<0 then
                                                  Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    if iRoutineCounter<>1 then
                                                      Routines_GenerateError('���������� ����� ������� ('+IntToStr(iRoutineCounter)+') �� ������������� ���������� (1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('���������� ����� ������� ������������� ����������.', LogGroupGUID, lmtDebug);
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            iRowCountDestination:=StrToIntDef(string(ResultRow[0]), -1);
                                                            if iRowCountDestination=-1 then
                                                              Routines_GenerateError('�� ������� ���������� ����������� ����������� ���������� ������� ������!', sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('��������� ���������� ������� ������� ������ �������� �������.', LogGroupGUID, lmtDebug);
                                                                LogThis('���������� ����� ������� ������ ����������: '+IntToStr(iRowCountDestination)+'.', LogGroupGUID, lmtDebug);
                                                              end;
                                                          end;
                                                      end;
                                                  end;
                                                mysql_free_result(ResultSet);
                                                LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                              end;
                                          end;
                                      end;
                                  end;
                                LogThis('<< ���������� �������� ��������� ���������� ������� ������� ������ "'+LowerCase(slXRDMissedList[iMissedListCounter])+'" ���������.', LogGroupGUID, lmtDebug);
                                StepProgressBar;
                              end;

                            if not bError then
                              begin
                                // ������� ��������� ���������� �����
                                LogThis('>> ����������� �������� ��������� ���������� ������� ������ ������...', LogGroupGUID, lmtDebug);
                                if iRowCountDestination<>iRowCountSource then
                                  Routines_GenerateError('���������� ������� ('+IntToStr(iRowCountSource)+') � �������� ������� ������ ('+sDBSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+') ���������� �� ���������� ������� ('
                                    +IntToStr(iRowCountDestination)+') � �������������� ������� ������ ('+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+')!', sErrorMessage, bError)
                                else
                                  LogThis('���������� ������� ������ ������ ��������� ('+IntToStr(iRowCountSource)+').', LogGroupGUID, lmtDebug);
                                LogThis('<< ���������� �������� ��������� ���������� ������� ������ ������ ���������.', LogGroupGUID, lmtDebug);
                                StepProgressBar;

                                if not bError then
                                  begin
                                    // ��������������� ������ �� DBSERVER
                                    MySQL_UnlockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                                    StepProgressBar;

                                    if not bError then
                                      begin
                                        // ��������������� ������ �� STATSERVER
                                        MySQL_UnlockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
                                        StepProgressBar;
                                      end;
                                  end;
                              end;
                          end;
                    end;

                  // ���������� �� DBSERVER, ���� � ������ ������
                  MySQL_CloseConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                  StepProgressBar;
                end;
            finally
              slXRDMissedList.Free;
            end;
          end;

        // ���� ����� (����)����������� ������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
        if (((not bXRDATableExists)and bCreateXRDA)or bRecreateXRDA)and(not bError) then
          begin
            // �������� ������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] ��� � �������
            if bXRDATableExists and bRecreateXRDA then
              begin
                MySQL_DropTable(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, //
                  'DROP TABLE IF EXISTS '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+';');
              end;
            StepProgressBar;

            if not bError then
              begin
                // �������� ������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] �� ������ ��������� ������� xrd_yyyymmdd
                MySQL_CreateTable(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, //
                  'CREATE TABLE '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' (' //
                  +'KEY ani (ani), ' //
                  +'KEY ddi (ddi), ' //
                  +'KEY datum (datum)' //
                  +') ' //
                  +'SELECT * ' //
                  +'FROM '+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDFullList[0])+' ' //
                  +'WHERE 1=0;'); //
                StepProgressBar;

                if not bError then
                  begin
                    // ������������ ������ �� STATSERVER �� ������
                    // ����������� ������ ����������� ������
                    sLockQuery:=sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' WRITE';
                    for iRoutineCounter:=0 to slXRDFullList.Count-1 do
                      sLockQuery:=sLockQuery+', '+sSTATSERVER_XRD_Location+'.'+slXRDFullList[iRoutineCounter]+' READ';
                    // ��������������� ������������ ������
                    MySQL_LockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, sLockQuery);
                    StepProgressBar;

                    if not bError then
                      begin
                        // �������� ������� ������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
                        MySQL_CheckTableExistance(LogGroupGUID, Configuration.StatServer, sSTATSERVER_XRDA_Location, bError, sErrorMessage, LowerCase(sXRDATableName));
                        StepProgressBar;

                        if not bError then
                          begin
                            // �������� ���� ������ �� ������ xrd_<yyyymmdd> � ������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
                            for iFullListCounter:=0 to slXRDFullList.Count-1 do
                              if bError then
                                Break
                              else
                                begin
                                  // ������� ������ �� ��������� ������� xrd_<yyyymmdd> � ������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
                                  MySQL_InsertRecords(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, //
                                    'INSERT INTO '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' ' //
                                    +'SELECT * ' //
                                    +'FROM '+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDFullList[iFullListCounter])+';'); //
                                end;
                            StepProgressBar;

                            { TODO -c������� ���������� : � ������ ������������� �������� ����� ���� }
                            // ��������� ���������� ���������� ����� � ��������-���������� xrd_<yyyymmdd> � ���������� ����� � �������-�������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
                            // ��������� ��������� ���������� ����������� � ������� xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] �����

                            // ��������������� ������ �� STATSERVER
                            if not bError then
                              begin
                                MySQL_UnlockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
                                StepProgressBar;
                              end;
                          end;
                      end;
                  end;
              end;
          end;
      finally
        slXRDFullList.Free;
      end;
    end;

  // ���������� �� STATSERVER, ���� � ������ ������
  MySQL_CloseConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
  StepProgressBar;

  // ����� ��������� �� �������� ���������� ��������, ���� �� ����� ���� ��������
  if (not bError)and(not aSilentYes) then
    begin
      Application.ProcessMessages;
      sMessage:='�������� ��������� �������.';
      if bRecreateXRD then
        sMessage:=sMessage+#13#10+'������� '+sSTATSERVER_XRD_Location+'.'+cXRDPrefix+'rd_<yyyymmdd> ���� ������� ��������������� �� ������� '+Configuration.StatServer.sMySQLHost+'.'
      else
        sMessage:=sMessage+#13#10+'������� ������ '+sSTATSERVER_XRD_Location+'.'+cXRDPrefix+'rd_<yyyymmdd> �� ������� '+Configuration.StatServer.sMySQLHost+' ������� ���������.';
      if bCreateXRDA and bXRDATableExists and(not bRecreateXRDA) then
        sMessage:=sMessage+#13#10+'������� ������� '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' �� ������� '+Configuration.StatServer.sMySQLHost+' ������� ���������.';
      if bCreateXRDA and(not bXRDATableExists) then
        sMessage:=sMessage+#13#10+'������� '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' ���� ������� ������������ �� ������� '+Configuration.StatServer.sMySQLHost+'.';
      if bRecreateXRDA and bXRDATableExists then
        sMessage:=sMessage+#13#10+'������� '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' ���� ������� ��������������� �� ������� '+Configuration.StatServer.sMySQLHost+'.';
      MessageBox(Handle, PWideChar(sMessage), PWideChar('OVERSEER - ����������'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
  Do_CreateXRDA:=not bError;
end;

procedure TMainForm.Do_RefreshUserList_SIC_04;
const
  LogGroupGUID: string='{12377232-7273-45A6-B852-09D6E34EBC2E}';
var
  sErrorMessage: string;
  bError: boolean;
  q: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  iRowQuantity, iRowCounter: integer;
begin
  ProcedureHeader('��������� ���������� ������ ������������� �� ������ "����� � �����������"', LogGroupGUID);

  InitProgressBar(6); // 0
  // ������������ � MySQL-�������, �� ������� ��������� ������� ������������� �� rne4
  MySQL_OpenConnection(LogGroupGUID, Configuration.RNE4Server, bError, sErrorMessage);
  StepProgressBar; // 1

  if not bError then
    begin
      // �������� ������� ������� ������������� � ���� ������
      MySQL_CheckTableExistance(LogGroupGUID, Configuration.RNE4Server, Configuration.RNE4Server.sMySQLDatabase, bError, sErrorMessage, '_usr');
      StepProgressBar; // 2

      if not bError then
        begin
          // ������������ �������
          MySQL_LockTables(LogGroupGUID, Configuration.RNE4Server, bError, sErrorMessage, Configuration.RNE4Server.sMySQLDatabase+'._usr READ');
          StepProgressBar; // 3

          if not bError then
            begin
              // ��������� ������ ������������� � ���������� ������
              LogThis('>> ����������� �������� ��������� ������ ������������� � ���������� ������...', LogGroupGUID, lmtDebug);
              if not Configuration.RNE4Server.bConnected then
                Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
              else
                begin
                  if mysql_ping(Configuration.RNE4Server.hConnection)<>0 then
                    Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                  else
                    begin
                      q:='SELECT DISTINCT usr_fullname ' //
                        +'FROM '+Configuration.RNE4Server.sMySQLDatabase+'._usr ' //
                        +'WHERE usr_erased="0" ' //
                        +'ORDER BY usr_fullname;'; //
                      LogThis(q, LogGroupGUID, lmtSQL);
                      if mysql_real_query(Configuration.RNE4Server.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                        Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                      else
                        begin
                          LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                          ResultSet:=mysql_store_result(Configuration.RNE4Server.hConnection);
                          if ResultSet=nil then
                            Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                          else
                            begin
                              LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                              iRowQuantity:=mysql_num_rows(ResultSet);
                              LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                              if iRowQuantity<0 then
                                Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                              else
                                begin
                                  LogThis('���������� ����� ������� ������������� ����������.', LogGroupGUID, lmtDebug);
                                  clbUsers_SIC_04.Items.BeginUpdate;
                                  clbUsers_SIC_04.Clear;
                                  for iRowCounter:=0 to iRowQuantity-1 do
                                    if bError then
                                      Break
                                    else
                                      begin
                                        LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                        ResultRow:=mysql_fetch_row(ResultSet);
                                        if ResultRow=nil then
                                          Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', LogGroupGUID, lmtDebug);
                                            clbUsers_SIC_04.Items.Add(string(ResultRow[0]));
                                          end;
                                      end;
                                  clbUsers_SIC_04.Items.EndUpdate;
                                end;
                              mysql_free_result(ResultSet);
                              LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                            end;
                        end;
                    end;
                end;
              LogThis('<< ���������� �������� ��������� ������ ������������� � ���������� ������ ���������.', LogGroupGUID, lmtDebug);
              StepProgressBar; // 4

              if not bError then
                begin
                  // ��������������� ������
                  MySQL_UnlockTables(LogGroupGUID, Configuration.RNE4Server, bError, sErrorMessage);
                  StepProgressBar; // 5
                end;
            end;
        end;
      // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
      MySQL_CloseConnection(LogGroupGUID, Configuration.RNE4Server, bError, sErrorMessage);
      StepProgressBar; // 6
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_Actions_SIC_01;
const
  LogGroupGUID: string='{71E749C1-C998-43D1-B806-3BFD243D3BFA}';
begin
  ProcedureHeader('��������� ���������� ��������� ������ �������������� ���������� ��������', LogGroupGUID);

  Action_AddPhones_SIC_01.Enabled:=Routines_IsStringIsPhone(eb_SIC_01.Text);
  btnAdd_SIC_01.default:=Action_AddPhones_SIC_01.Enabled;
  Action_DeletePhone_SIC_01.Enabled:=lv_SIC_01.ItemIndex>-1;
  Action_ClearPhones_SIC_01.Enabled:=lv_SIC_01.Items.Count>0;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_Actions_Payoff;
const
  LogGroupGUID: string='{4DF12007-9115-4244-959A-F142A2862EFF}';
var
  b: boolean;
  i: integer;
begin
  ProcedureHeader('��������� ���������� ��������� ������ �������������� ���������� ��������', LogGroupGUID);

  lvPhonesList_Payoff.Enabled:=lvPhonesList_Payoff.Items.Count>0;

  Action_RefreshCallsList_Payoff.Enabled:=Routines_IsStringIsPhone(ebPhonesList_Payoff.Text);
  btnResfeshCallsList_Payoff.default:=Action_RefreshCallsList_Payoff.Enabled;

  b:=False;
  for i:=0 to lvPhonesList_Payoff.Items.Count-1 do
    if not lvPhonesList_Payoff.Items[i].Checked then
      begin
        b:=True;
        Break;
      end;
  Action_SelectAllCalls_Payoff.Enabled:=(lvPhonesList_Payoff.Items.Count>0)and b;
  btnSelectAllCalls_Payoff.Enabled:=Action_SelectAllCalls_Payoff.Enabled;

  b:=False;
  for i:=0 to lvPhonesList_Payoff.Items.Count-1 do
    if lvPhonesList_Payoff.Items[i].Checked then
      begin
        b:=True;
        Break;
      end;
  Action_UnselectAllCalls_Payoff.Enabled:=(lvPhonesList_Payoff.Items.Count>0)and b;
  btnUnselectAllCalls_Payoff.Enabled:=Action_UnselectAllCalls_Payoff.Enabled;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_RefreshCallsList_Payoff;
const
  LogGroupGUID: string='{A71624CA-9307-4390-8B9C-7E615DAF8086}';
var
  sErrorMessage: string;
  bError: boolean;
  q: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  iRowQuantity, iRowCounter: integer;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  iYear: integer;
  slIRDFullList, slPhonesList: TStringList;
  iFullListCounter: integer;
  iRoutineCounter: integer;
  dtDate, aStartDate, aStopDate: TDate;
  bNeedToConnectToSTATSERVER, bNeedToConnectToDBSERVER: boolean;
  ListItem: TListItem;
begin
  ProcedureHeader('��������� ���������� ������ ������� �� ������ ���', LogGroupGUID);

  wStartDay:=0;
  wStartMonth:=0;
  wStartYear:=0;
  wStopDay:=0;
  wStopMonth:=0;
  wStopYear:=0;

  lvPhonesList_Payoff.Items.BeginUpdate;
  lvPhonesList_Payoff.Clear;
  lvPhonesList_Payoff.Items.EndUpdate;

  // ������ ���������� ���������� �������
  LogThis('>> ����������� �������� ������� ���������� ���������� �������...', LogGroupGUID, lmtDebug);
  if not(rbLastDate.Checked or rbChoisenDate.Checked or rbLastWeek.Checked or rbLastMonth.Checked or rbChoisenMonth.Checked or rbLastQuarter.Checked or rbChoisenQuarter.Checked or rbLastYear.Checked or rbChoisenYear.Checked or
    rbChoisenPeriod.Checked) then
    Routines_GenerateError('�� ��� ������ ������!', sErrorMessage, bError)
  else
    begin
      if rbLastDate.Checked then
        begin
          wStartDay:=DayOf(dtLastDate);
          wStartMonth:=MonthOf(dtLastDate);
          wStartYear:=YearOf(dtLastDate);
          wStopDay:=wStartDay;
          wStopMonth:=wStartMonth;
          wStopYear:=wStartYear;
        end;
      if rbChoisenDate.Checked then
        begin
          wStartDay:=DayOf(dtpChoisenDate.Date);
          wStartMonth:=MonthOf(dtpChoisenDate.Date);
          wStartYear:=YearOf(dtpChoisenDate.Date);
          wStopDay:=wStartDay;
          wStopMonth:=wStartMonth;
          wStopYear:=wStartYear;
        end;
      if rbLastWeek.Checked then
        begin
          wStartDay:=DayOf(dtLastWeekStart);
          wStartMonth:=MonthOf(dtLastWeekStart);
          wStartYear:=YearOf(dtLastWeekStart);
          wStopDay:=DayOf(dtLastWeekStop);
          wStopMonth:=MonthOf(dtLastWeekStop);
          wStopYear:=YearOf(dtLastWeekStop);
        end;
      if rbLastMonth.Checked then
        begin
          wStartDay:=DayOf(dtLastMonthStart);
          wStartMonth:=MonthOf(dtLastMonthStart);
          wStartYear:=YearOf(dtLastMonthStart);
          wStopDay:=DayOf(dtLastMonthStop);
          wStopMonth:=MonthOf(dtLastMonthStop);
          wStopYear:=YearOf(dtLastMonthStop);
        end;
      if rbLastQuarter.Checked then
        begin
          wStartDay:=DayOf(dtLastQuarterStart);
          wStartMonth:=MonthOf(dtLastQuarterStart);
          wStartYear:=YearOf(dtLastQuarterStart);
          wStopDay:=DayOf(dtLastQuarterStop);
          wStopMonth:=MonthOf(dtLastQuarterStop);
          wStopYear:=YearOf(dtLastQuarterStop);
        end;
      if rbLastYear.Checked then
        begin
          wStartDay:=DayOf(StartOfAYear(wLastYear));
          wStartMonth:=MonthOf(StartOfAYear(wLastYear));
          wStartYear:=YearOf(StartOfAYear(wLastYear));
          wStopDay:=DayOf(EndOfAYear(wLastYear));
          wStopMonth:=MonthOf(EndOfAYear(wLastYear));
          wStopYear:=YearOf(EndOfAYear(wLastYear));
        end;
      if rbChoisenPeriod.Checked then
        begin
          if cbChoisenPeriod_Start.Date>cbChoisenPeriod_Stop.Date then
            Routines_GenerateError('��������� ��������� ���� ('+FormatDateTime('dd.mm.yyyy', cbChoisenPeriod_Start.Date)+') ������, ��� �������� ('+FormatDateTime('dd.mm.yyyy', cbChoisenPeriod_Stop.Date)+')!', sErrorMessage, bError)
          else
            begin
              wStartDay:=DayOf(cbChoisenPeriod_Start.Date);
              wStartMonth:=MonthOf(cbChoisenPeriod_Start.Date);
              wStartYear:=YearOf(cbChoisenPeriod_Start.Date);
              wStopDay:=DayOf(cbChoisenPeriod_Stop.Date);
              wStopMonth:=MonthOf(cbChoisenPeriod_Stop.Date);
              wStopYear:=YearOf(cbChoisenPeriod_Stop.Date);
            end;
        end;
      if rbChoisenMonth.Checked then
        begin
          iYear:=StrToIntDef(cbChoisenMonth_Year.Items[cbChoisenMonth_Year.ItemIndex], -1);
          if iYear=-1 then
            Routines_GenerateError('�� ������� ���������� ����������� ��������� ����!', sErrorMessage, bError)
          else
            begin
              wStartYear:=iYear;
              wStopYear:=iYear;
              wStartMonth:=cbChoisenMonth_Month.ItemIndex+1;
              wStopMonth:=wStartMonth;
              wStartDay:=DayOf(StartOfAMonth(wStartYear, wStartMonth));
              wStopDay:=DayOf(EndOfAMonth(wStopYear, wStopMonth));
            end;
        end;
      if not bError then
        begin
          if rbChoisenQuarter.Checked then
            begin
              iYear:=StrToIntDef(cbChoisenQuarter_Year.Items[cbChoisenQuarter_Year.ItemIndex], -1);
              if iYear=-1 then
                Routines_GenerateError('�� ������� ���������� ����������� ��������� ����!', sErrorMessage, bError)
              else
                begin
                  wStartYear:=iYear;
                  wStopYear:=iYear;
                  wStartMonth:=(cbChoisenQuarter_Quarter.ItemIndex*3)+1;
                  wStopMonth:=wStartMonth+2;
                  wStartDay:=DayOf(StartOfAMonth(wStartYear, wStartMonth));
                  wStopDay:=DayOf(EndOfAMonth(wStopYear, wStopMonth));
                end;
            end;
        end;
      if not bError then
        begin
          if rbChoisenYear.Checked then
            begin
              iYear:=StrToIntDef(cbChoisenYear.Items[cbChoisenYear.ItemIndex], -1);
              if iYear=-1 then
                Routines_GenerateError('�� ������� ���������� ����������� ��������� ����!', sErrorMessage, bError)
              else
                begin
                  wStartDay:=DayOf(StartOfAYear(iYear));
                  wStartMonth:=MonthOf(StartOfAYear(iYear));
                  wStartYear:=YearOf(StartOfAYear(iYear));
                  wStopDay:=DayOf(EndOfAYear(iYear));
                  wStopMonth:=MonthOf(EndOfAYear(iYear));
                  wStopYear:=YearOf(EndOfAYear(iYear));
                end;
            end;
        end;
    end;
  LogThis('<< ���������� �������� ������� ���������� ���������� ������� ���������.', LogGroupGUID, lmtDebug);

  if not bError then
    begin
      aStartDate:=EncodeDate(wStartYear, wStartMonth, wStartDay);
      aStopDate:=EncodeDate(wStopYear, wStopMonth, wStopDay);

      // ��������� ���������� �������
      if (aStartDate>ToDay)or(aStopDate>ToDay) then
        if aStartDate>ToDay then
          Routines_GenerateError('��������� ���� ������ ������� ����!', sErrorMessage, bError)
        else
          Routines_GenerateError('�������� ���� ������ ������� ����!', sErrorMessage, bError)
      else
        if aStopDate<aStartDate then
          Routines_GenerateError('��������� ���� ������ �������� ����!', sErrorMessage, bError);

      if not bError then
        begin
          // �������� �� ������� ���� � �������
          if SameDate(ToDay, aStopDate) then
            begin
              if SameDate(ToDay, aStartDate) then
                begin
                  // ������� ������ �� ������� ����
                  bNeedToConnectToSTATSERVER:=False;
                  bNeedToConnectToDBSERVER:=True;
                end
              else
                begin
                  // ������� �� ���������� � ... �� ������� ����
                  bNeedToConnectToSTATSERVER:=True;
                  bNeedToConnectToDBSERVER:=True;
                end;
            end
          else
            begin
              // ������� �... ��... ������ �� ��������� ���
              bNeedToConnectToSTATSERVER:=True;
              bNeedToConnectToDBSERVER:=False;
            end;

          // �������� ������ ������� ���������
          slPhonesList:=TStringList.Create;
          try
            Routines_CutStringByLimiterToStringList(Trim(ebPhonesList_Payoff.Text), slPhonesList, ' ');

            slIRDFullList:=TStringList.Create;
            try
              // �������� ������ ��� �������� ������ ������
              LogThis('>> ����������� �������� ����������� ������ ������ �������� �������...', LogGroupGUID, lmtDebug);
              dtDate:=aStartDate;
              repeat
                slIRDFullList.Add('ird_'+FormatDateTime('yyyymmdd', dtDate));
                dtDate:=IncDay(dtDate, 1);
              until dtDate>aStopDate;
              // ���� � ������ ������������ ������� ����, ������� � �� ������
              if bNeedToConnectToDBSERVER then
                slIRDFullList.Delete(slIRDFullList.Count-1);
              LogThis('��������� ���������� ����� ������ ������ ������ ����� '+IntToStr(slIRDFullList.Count)+'.', LogGroupGUID, lmtDebug);
              LogThis('<< ���������� �������� ����������� ������ ������ �������� ������� ���������.', LogGroupGUID, lmtDebug);

              if bNeedToConnectToSTATSERVER then
                begin
                  // ������������ � MySQL-������� STATSERVER
                  MySQL_OpenConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);

                  if not bError then
                    begin
                      // �������� �� �������
                      for iFullListCounter:=0 to slIRDFullList.Count-1 do
                        if bError then
                          Break
                        else
                          begin
                            // �������� ������� ������� � ���� ������
                            MySQL_CheckTableExistance(LogGroupGUID, Configuration.StatServer, Configuration.StatServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, LowerCase(slIRDFullList[iFullListCounter]));

                            if not bError then
                              begin
                                // ������������ �������
                                MySQL_LockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, Configuration.StatServer.sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[iFullListCounter])+' READ');

                                if not bError then
                                  begin
                                    // ��������� ������ � ���������� ������
                                    LogThis('>> ����������� �������� ��������� ������ � ���������� ������...', LogGroupGUID, lmtDebug);
                                    if not Configuration.StatServer.bConnected then
                                      Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                          Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                        else
                                          begin
                                            q:='SELECT' //
                                              +' ani,' //
                                              +' ddi,' //
                                              +' DATE_FORMAT(datum, "%d.%m.%Y"),' //
                                              +' vrijeme,' //
                                              +' dur,' //
                                              +' rm,' //
                                              +' izg,' //
                                              +' izgnum,' //
                                              +' v_oper,' //
                                              +' v_mreza ' //
                                              +'FROM '+Configuration.StatServer.sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[iFullListCounter])+' ' //
                                              +'WHERE rm>0 AND srv="0" AND ';
                                            if slPhonesList.Count>1 then
                                              q:=q+'('; //
                                            for iRoutineCounter:=0 to slPhonesList.Count-1 do
                                              begin
                                                q:=q+'ani LIKE "%'+slPhonesList[iRoutineCounter]+'"'; //
                                                if iRoutineCounter<slPhonesList.Count-1 then
                                                  q:=q+' OR ';
                                              end;
                                            if slPhonesList.Count>1 then
                                              q:=q+')'; //
                                            q:=q+' ' //
                                              +'ORDER BY datum, vrijeme, ani ' //
                                              +'LIMIT 100;'; //
                                            LogThis(q, LogGroupGUID, lmtSQL);
                                            if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                              Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                                ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
                                                if ResultSet=nil then
                                                  Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                                    iRowQuantity:=mysql_num_rows(ResultSet);
                                                    LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                                    if iRowQuantity<0 then
                                                      Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('���������� ����� ������� ������������� ����������.', LogGroupGUID, lmtDebug);
                                                        lvPhonesList_Payoff.Items.BeginUpdate;
                                                        // lvPhonesList_Payoff.AllocBy:=iRowQuantity-1;
                                                        for iRowCounter:=0 to iRowQuantity-1 do
                                                          if bError then
                                                            Break
                                                          else
                                                            begin
                                                              LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                              ResultRow:=mysql_fetch_row(ResultSet);
                                                              if ResultRow=nil then
                                                                Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', LogGroupGUID, lmtDebug);
                                                                  ListItem:=lvPhonesList_Payoff.Items.Add;
                                                                  ListItem.ImageIndex:=2;
                                                                  ListItem.Caption:=string(ResultRow[0]);
                                                                  ListItem.SubItems.Add(string(ResultRow[1]));
                                                                  ListItem.SubItems.Add(string(ResultRow[2]));
                                                                  ListItem.SubItems.Add(string(ResultRow[3]));
                                                                  ListItem.SubItems.Add(string(ResultRow[4]));
                                                                  ListItem.SubItems.Add(string(ResultRow[5]));
                                                                  ListItem.SubItems.Add(Routines_GetConditionalMessage(string(ResultRow[6])='1', '��', Routines_GetConditionalMessage(string(ResultRow[6])='0', '���', '������!')));
                                                                  ListItem.SubItems.Add(string(ResultRow[7]));
                                                                  ListItem.SubItems.Add(string(ResultRow[8]));
                                                                  ListItem.SubItems.Add(string(ResultRow[9]));
                                                                end;
                                                            end;
                                                        lvPhonesList_Payoff.Items.EndUpdate;
                                                      end;
                                                    mysql_free_result(ResultSet);
                                                    LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                                  end;
                                              end;
                                          end;
                                      end;
                                    LogThis('<< ���������� �������� ��������� ������ � ���������� ������ ���������.', LogGroupGUID, lmtDebug);

                                    // ��������������� ������
                                    if not bError then
                                      MySQL_UnlockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
                                  end;
                              end;
                          end;

                      // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
                      MySQL_CloseConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
                    end;
                end;
            finally
              slIRDFullList.Free;
            end;

            if not bError then
              if bNeedToConnectToDBSERVER then
                begin
                  // ����������� � MySQL-������� DBSERVER
                  MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);

                  // �������� �� �������
                  if not bError then
                    begin
                      // �������� ������� ������� � ���� ������
                      MySQL_CheckTableExistance(LogGroupGUID, Configuration.DBServer, Configuration.DBServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, 'ird_'+FormatDateTime('yyyymmdd', aStopDate));

                      if not bError then
                        begin
                          // ������������ �������
                          // MySQL_LockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage, Configuration.DBServer.sMySQLDatabase_IRD_Location+'.ird_'+FormatDateTime('yyyymmdd', aStopDate)+' READ');

                          if not bError then
                            begin
                              // ��������� ������ � ���������� ������
                              LogThis('>> ����������� �������� ��������� ������ � ���������� ������...', LogGroupGUID, lmtDebug);
                              if not Configuration.DBServer.bConnected then
                                Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                              else
                                begin
                                  if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                                    Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                  else
                                    begin
                                      q:='SELECT' //
                                        +' ani,' //
                                        +' ddi,' //
                                        +' DATE_FORMAT(datum, "%d.%m.%Y"),' //
                                        +' vrijeme,' //
                                        +' dur,' //
                                        +' rm,' //
                                        +' izg,' //
                                        +' izgnum,' //
                                        +' v_oper,' //
                                        +' v_mreza ' //
                                        +'FROM '+Configuration.DBServer.sMySQLDatabase_IRD_Location+'.ird_'+FormatDateTime('yyyymmdd', aStopDate)+' ' //
                                        +'WHERE rm>0 AND srv="0" AND ';
                                      if slPhonesList.Count>1 then
                                        q:=q+'('; //
                                      for iRoutineCounter:=0 to slPhonesList.Count-1 do
                                        begin
                                          q:=q+'ani LIKE "%'+slPhonesList[iRoutineCounter]+'"'; //
                                          if iRoutineCounter<slPhonesList.Count-1 then
                                            q:=q+' OR ';
                                        end;
                                      if slPhonesList.Count>1 then
                                        q:=q+')'; //
                                      q:=q+' ' //
                                        +'ORDER BY datum, vrijeme, ani ' //
                                        +'LIMIT 100;'; //
                                      LogThis(q, LogGroupGUID, lmtSQL);
                                      if mysql_real_query(Configuration.DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                        Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                                      else
                                        begin
                                          LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                          ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                          if ResultSet=nil then
                                            Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                          else
                                            begin
                                              LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                              iRowQuantity:=mysql_num_rows(ResultSet);
                                              LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                              if iRowQuantity<0 then
                                                Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                              else
                                                begin
                                                  LogThis('���������� ����� ������� ������������� ����������.', LogGroupGUID, lmtDebug);
                                                  lvPhonesList_Payoff.Items.BeginUpdate;
                                                  // lvPhonesList_Payoff.AllocBy:=iRowQuantity-1;
                                                  for iRowCounter:=0 to iRowQuantity-1 do
                                                    if bError then
                                                      Break
                                                    else
                                                      begin
                                                        LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', LogGroupGUID, lmtDebug);
                                                            ListItem:=lvPhonesList_Payoff.Items.Add;
                                                            ListItem.ImageIndex:=2;
                                                            ListItem.Caption:=string(ResultRow[0]);
                                                            ListItem.SubItems.Add(string(ResultRow[1]));
                                                            ListItem.SubItems.Add(string(ResultRow[2]));
                                                            ListItem.SubItems.Add(string(ResultRow[3]));
                                                            ListItem.SubItems.Add(string(ResultRow[4]));
                                                            ListItem.SubItems.Add(string(ResultRow[5]));
                                                            ListItem.SubItems.Add(Routines_GetConditionalMessage(string(ResultRow[6])='1', '��', Routines_GetConditionalMessage(string(ResultRow[6])='0', '���', '������!')));
                                                            ListItem.SubItems.Add(string(ResultRow[7]));
                                                            ListItem.SubItems.Add(string(ResultRow[8]));
                                                            ListItem.SubItems.Add(string(ResultRow[9]));
                                                          end;
                                                      end;
                                                  lvPhonesList_Payoff.Items.EndUpdate;
                                                end;
                                              mysql_free_result(ResultSet);
                                              LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                            end;
                                        end;
                                    end;
                                end;
                              LogThis('<< ���������� �������� ��������� ������ � ���������� ������ ���������.', LogGroupGUID, lmtDebug);

                              if not bError then
                                begin
                                  // ��������������� ������
                                  // MySQL_UnlockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                                end;
                            end;
                        end;

                      // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
                      MySQL_CloseConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                    end;
                end;
          finally
            slPhonesList.Free;
          end;
        end;
    end;
  Update_Actions_Payoff;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_Actions_SIC_04;
const
  LogGroupGUID: string='{88740CDD-7D63-420D-AD61-02ED86D33634}';
var
  b: boolean;
  i: integer;
begin
  ProcedureHeader('��������� ���������� ��������� ������ �������������� ���������� ��������', LogGroupGUID);

  Action_RefreshUserList_SIC_04.Enabled:=rbSelectedUsers_SIC_04.Checked;
  clbUsers_SIC_04.Enabled:=rbSelectedUsers_SIC_04.Checked;

  b:=False;
  for i:=0 to clbUsers_SIC_04.Items.Count-1 do
    if not clbUsers_SIC_04.Checked[i] then
      begin
        b:=True;
        Break;
      end;
  Action_SelectAllUsers_SIC_04.Enabled:=rbSelectedUsers_SIC_04.Checked and(clbUsers_SIC_04.Items.Count>0)and b;
  btnSelectAllUsers_SIC_04.Enabled:=Action_SelectAllUsers_SIC_04.Enabled;

  b:=False;
  for i:=0 to clbUsers_SIC_04.Items.Count-1 do
    if clbUsers_SIC_04.Checked[i] then
      begin
        b:=True;
        Break;
      end;
  Action_UnselectAllUsers_SIC_04.Enabled:=rbSelectedUsers_SIC_04.Checked and(clbUsers_SIC_04.Items.Count>0)and b;
  btnUnselectAllUsers_SIC_04.Enabled:=Action_UnselectAllUsers_SIC_04.Enabled;

  btnRefreshUserList_SIC_04.default:=rbSelectedUsers_SIC_04.Checked and(clbUsers_SIC_04.Items.Count=0);
  if rbSelectedUsers_SIC_04.Checked and(clbUsers_SIC_04.Items.Count=0) then
    btnRefreshUserList_SIC_04.SetFocus;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_SelectAllServices_SIC_09;
var
  i: integer;
begin
  with lvServices_SIC_09 do
    begin
      OnItemChecked:=nil;
      Items.BeginUpdate;
      for i:=0 to Items.Count-1 do
        Items[i].Checked:=True;
      Items.EndUpdate;
      OnItemChecked:=lvServices_SIC_09ItemChecked;
    end;
  Update_Actions_SIC_09;
end;

procedure TMainForm.Do_UnselectAllServices_SIC_09;
var
  i: integer;
begin
  with lvServices_SIC_09 do
    begin
      OnItemChecked:=nil;
      Items.BeginUpdate;
      for i:=0 to Items.Count-1 do
        Items[i].Checked:=False;
      Items.EndUpdate;
      OnItemChecked:=lvServices_SIC_09ItemChecked;
    end;
  Update_Actions_SIC_09;
end;

procedure TMainForm.Action_SelectOralServices_SIC_09Execute(Sender: TObject);
begin
  Do_SelectOralServices_SIC_09
end;

procedure TMainForm.Action_SelectAutoServices_SIC_09Execute(Sender: TObject);
begin
  Do_SelectAutoServices_SIC_09;
end;

procedure TMainForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{D344FBD0-0E99-408B-B9AE-7B74D2056F0A}';
var
  i: integer;
  aListItem: TListItem;
begin
  ProcedureHeader('���������-���������� ������� ����������� ����', LogGroupGUID);

  if bFirstRun then
    begin
      iBusyCounter:=0;
      bFirstRun:=False;
    end;
  Refresh_BusyState(LogGroupGUID);

  cbService_SIC_05.Clear;
  cbService_SIC_05.Items.BeginUpdate;
  for i:=0 to aServices_Count-1 do
    cbService_SIC_05.Items.Add(aServices[i].sNumber+' - '+aServices[i].sName);
  cbService_SIC_05.Items.EndUpdate;

  lvServices_SIC_09.Clear;
  lvServices_SIC_09.Items.BeginUpdate;
  for i:=0 to aServices_Count-1 do
    begin
      aListItem:=lvServices_SIC_09.Items.Add;
      aListItem.Caption:=aServices[i].sNumber;
      if aServices[i].bAutoService then
        aListItem.ImageIndex:=ICON_AUTOSERVICES
      else
        aListItem.ImageIndex:=ICON_ORALSERVICES;
      aListItem.SubItems.Add(aServices[i].sName);
    end;
  lvServices_SIC_09.Items.EndUpdate;
  Update_Actions_SIC_09;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_SelectOralServices_SIC_09;
var
  i: integer;
begin
  with lvServices_SIC_09 do
    begin
      OnItemChecked:=nil;
      Items.BeginUpdate;
      for i:=0 to Items.Count-1 do
        if Items[i]<>nil then
          if Items[i].SubItems.Count>0 then
            Items[i].Checked:=Items[i].ImageIndex=ICON_ORALSERVICES;
      Items.EndUpdate;
      OnItemChecked:=lvServices_SIC_09ItemChecked;
    end;
  Update_Actions_SIC_09;
end;

procedure TMainForm.Do_SelectAutoServices_SIC_09;
var
  i: integer;
begin
  with lvServices_SIC_09 do
    begin
      OnItemChecked:=nil;
      Items.BeginUpdate;
      for i:=0 to Items.Count-1 do
        if Items[i]<>nil then
          if Items[i].SubItems.Count>0 then
            Items[i].Checked:=Items[i].ImageIndex=ICON_AUTOSERVICES;
      Items.EndUpdate;
      OnItemChecked:=lvServices_SIC_09ItemChecked;
    end;
  Update_Actions_SIC_09;
end;

procedure TMainForm.lvServices_SIC_09ItemChecked(Sender: TObject; Item: TListItem);
begin
  Update_Actions_SIC_09;
end;

procedure TMainForm.Update_Actions_SIC_09;
const
  LogGroupGUID: string='{3A66CADF-4583-4D30-B856-885AEA86DBA9}';
var
  b: boolean;
  i: integer;
begin
  ProcedureHeader('��������� ���������� ��������� ������ �������������� ���������� ��������', LogGroupGUID);

  b:=False;
  for i:=0 to lvServices_SIC_09.Items.Count-1 do
    if not lvServices_SIC_09.Items[i].Checked then
      begin
        b:=True;
        Break;
      end;
  Action_SelectAllServices_SIC_09.Enabled:=b;
  btnSelectAllServices_SIC_09.Enabled:=Action_SelectAllServices_SIC_09.Enabled;

  b:=False;
  for i:=0 to lvServices_SIC_09.Items.Count-1 do
    if ((not lvServices_SIC_09.Items[i].Checked)and(lvServices_SIC_09.Items[i].ImageIndex=ICON_ORALSERVICES))or(lvServices_SIC_09.Items[i].Checked and(lvServices_SIC_09.Items[i].ImageIndex=ICON_AUTOSERVICES)) then
      begin
        b:=True;
        Break;
      end;
  Action_SelectOralServices_SIC_09.Enabled:=b;
  btnSelectOralServices_SIC_09.Enabled:=Action_SelectOralServices_SIC_09.Enabled;

  b:=False;
  for i:=0 to lvServices_SIC_09.Items.Count-1 do
    if (lvServices_SIC_09.Items[i].Checked and(lvServices_SIC_09.Items[i].ImageIndex=ICON_ORALSERVICES))or((not lvServices_SIC_09.Items[i].Checked)and(lvServices_SIC_09.Items[i].ImageIndex=ICON_AUTOSERVICES)) then
      begin
        b:=True;
        Break;
      end;
  Action_SelectAutoServices_SIC_09.Enabled:=b;
  btnSelectAutoServices_SIC_09.Enabled:=Action_SelectAutoServices_SIC_09.Enabled;

  b:=False;
  for i:=0 to lvServices_SIC_09.Items.Count-1 do
    if lvServices_SIC_09.Items[i].Checked then
      begin
        b:=True;
        Break;
      end;
  Action_UnselectAllServices_SIC_09.Enabled:=b;
  btnUnselectAllServices_SIC_09.Enabled:=Action_UnselectAllServices_SIC_09.Enabled;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_Actions_SIC_10;
const
  LogGroupGUID: string='{49BC039D-FED2-420D-8126-59F56088B881}';
var
  b: boolean;
  i: integer;
begin
  ProcedureHeader('��������� ���������� ��������� ������ �������������� ���������� ��������', LogGroupGUID);

  Action_RefreshUserList_SIC_10.Enabled:=rbSelectedUsers_SIC_10.Checked;
  clbUsers_SIC_10.Enabled:=rbSelectedUsers_SIC_10.Checked;

  b:=False;
  for i:=0 to clbUsers_SIC_10.Items.Count-1 do
    if not clbUsers_SIC_10.Checked[i] then
      begin
        b:=True;
        Break;
      end;
  Action_SelectAllUsers_SIC_10.Enabled:=rbSelectedUsers_SIC_10.Checked and(clbUsers_SIC_10.Items.Count>0)and b;
  btnSelectAllUsers_SIC_10.Enabled:=Action_SelectAllUsers_SIC_10.Enabled;

  b:=False;
  for i:=0 to clbUsers_SIC_10.Items.Count-1 do
    if clbUsers_SIC_10.Checked[i] then
      begin
        b:=True;
        Break;
      end;
  Action_UnselectAllUsers_SIC_10.Enabled:=rbSelectedUsers_SIC_10.Checked and(clbUsers_SIC_10.Items.Count>0)and b;
  btnUnselectAllUsers_SIC_10.Enabled:=Action_UnselectAllUsers_SIC_10.Enabled;

  btnRefreshUserList_SIC_10.default:=rbSelectedUsers_SIC_10.Checked and(clbUsers_SIC_10.Items.Count=0);
  if rbSelectedUsers_SIC_10.Checked and(clbUsers_SIC_10.Items.Count=0) then
    btnRefreshUserList_SIC_10.SetFocus;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_RefreshUserList_SIC_10;
const
  LogGroupGUID: string='{FE9602F4-36D8-455A-AC52-BA75E2C395B3}';
var
  sErrorMessage: string;
  bError: boolean;
  q: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  iRowQuantity, iRowCounter: integer;
  wStartDay, wStartMonth, wStartYear, wStopDay, wStopMonth, wStopYear: word;
  iYear: integer;
  sCCID: string;
begin
  ProcedureHeader('��������� ���������� ������ �������������', LogGroupGUID);

  bError:=False;
  wStartDay:=0;
  wStartMonth:=0;
  wStartYear:=0;
  wStopDay:=0;
  wStopMonth:=0;
  wStopYear:=0;

  // ������ ���������� ���������� �������
  LogThis('>> ����������� �������� ������� ���������� ���������� �������...', LogGroupGUID, lmtDebug);
  if not(rbLastDate.Checked or rbChoisenDate.Checked or rbLastWeek.Checked or rbLastMonth.Checked or rbChoisenMonth.Checked or rbLastQuarter.Checked or rbChoisenQuarter.Checked or rbLastYear.Checked or rbChoisenYear.Checked or
    rbChoisenPeriod.Checked) then
    Routines_GenerateError('�� ��� ������ ������!', sErrorMessage, bError)
  else
    begin
      if rbLastDate.Checked then
        begin
          wStartDay:=DayOf(dtLastDate);
          wStartMonth:=MonthOf(dtLastDate);
          wStartYear:=YearOf(dtLastDate);
          wStopDay:=wStartDay;
          wStopMonth:=wStartMonth;
          wStopYear:=wStartYear;
        end;
      if rbChoisenDate.Checked then
        begin
          wStartDay:=DayOf(dtpChoisenDate.Date);
          wStartMonth:=MonthOf(dtpChoisenDate.Date);
          wStartYear:=YearOf(dtpChoisenDate.Date);
          wStopDay:=wStartDay;
          wStopMonth:=wStartMonth;
          wStopYear:=wStartYear;
        end;
      if rbLastWeek.Checked then
        begin
          wStartDay:=DayOf(dtLastWeekStart);
          wStartMonth:=MonthOf(dtLastWeekStart);
          wStartYear:=YearOf(dtLastWeekStart);
          wStopDay:=DayOf(dtLastWeekStop);
          wStopMonth:=MonthOf(dtLastWeekStop);
          wStopYear:=YearOf(dtLastWeekStop);
        end;
      if rbLastMonth.Checked then
        begin
          wStartDay:=DayOf(dtLastMonthStart);
          wStartMonth:=MonthOf(dtLastMonthStart);
          wStartYear:=YearOf(dtLastMonthStart);
          wStopDay:=DayOf(dtLastMonthStop);
          wStopMonth:=MonthOf(dtLastMonthStop);
          wStopYear:=YearOf(dtLastMonthStop);
        end;
      if rbLastQuarter.Checked then
        begin
          wStartDay:=DayOf(dtLastQuarterStart);
          wStartMonth:=MonthOf(dtLastQuarterStart);
          wStartYear:=YearOf(dtLastQuarterStart);
          wStopDay:=DayOf(dtLastQuarterStop);
          wStopMonth:=MonthOf(dtLastQuarterStop);
          wStopYear:=YearOf(dtLastQuarterStop);
        end;
      if rbLastYear.Checked then
        begin
          wStartDay:=DayOf(StartOfAYear(wLastYear));
          wStartMonth:=MonthOf(StartOfAYear(wLastYear));
          wStartYear:=YearOf(StartOfAYear(wLastYear));
          wStopDay:=DayOf(EndOfAYear(wLastYear));
          wStopMonth:=MonthOf(EndOfAYear(wLastYear));
          wStopYear:=YearOf(EndOfAYear(wLastYear));
        end;
      if rbChoisenPeriod.Checked then
        begin
          if cbChoisenPeriod_Start.Date>cbChoisenPeriod_Stop.Date then
            Routines_GenerateError('��������� ��������� ���� ('+FormatDateTime('dd.mm.yyyy', cbChoisenPeriod_Start.Date)+') ������, ��� �������� ('+FormatDateTime('dd.mm.yyyy', cbChoisenPeriod_Stop.Date)+')!', sErrorMessage, bError)
          else
            begin
              wStartDay:=DayOf(cbChoisenPeriod_Start.Date);
              wStartMonth:=MonthOf(cbChoisenPeriod_Start.Date);
              wStartYear:=YearOf(cbChoisenPeriod_Start.Date);
              wStopDay:=DayOf(cbChoisenPeriod_Stop.Date);
              wStopMonth:=MonthOf(cbChoisenPeriod_Stop.Date);
              wStopYear:=YearOf(cbChoisenPeriod_Stop.Date);
            end;
        end;
      if rbChoisenMonth.Checked then
        begin
          iYear:=StrToIntDef(cbChoisenMonth_Year.Items[cbChoisenMonth_Year.ItemIndex], -1);
          if iYear=-1 then
            Routines_GenerateError('�� ������� ���������� ����������� ��������� ����!', sErrorMessage, bError)
          else
            begin
              wStartYear:=iYear;
              wStopYear:=iYear;
              wStartMonth:=cbChoisenMonth_Month.ItemIndex+1;
              wStopMonth:=wStartMonth;
              wStartDay:=DayOf(StartOfAMonth(wStartYear, wStartMonth));
              wStopDay:=DayOf(EndOfAMonth(wStopYear, wStopMonth));
            end;
        end;
      if not bError then
        begin
          if rbChoisenQuarter.Checked then
            begin
              iYear:=StrToIntDef(cbChoisenQuarter_Year.Items[cbChoisenQuarter_Year.ItemIndex], -1);
              if iYear=-1 then
                Routines_GenerateError('�� ������� ���������� ����������� ��������� ����!', sErrorMessage, bError)
              else
                begin
                  wStartYear:=iYear;
                  wStopYear:=iYear;
                  wStartMonth:=(cbChoisenQuarter_Quarter.ItemIndex*3)+1;
                  wStopMonth:=wStartMonth+2;
                  wStartDay:=DayOf(StartOfAMonth(wStartYear, wStartMonth));
                  wStopDay:=DayOf(EndOfAMonth(wStopYear, wStopMonth));
                end;
            end;
        end;
      if not bError then
        begin
          if rbChoisenYear.Checked then
            begin
              iYear:=StrToIntDef(cbChoisenYear.Items[cbChoisenYear.ItemIndex], -1);
              if iYear=-1 then
                Routines_GenerateError('�� ������� ���������� ����������� ��������� ����!', sErrorMessage, bError)
              else
                begin
                  wStartDay:=DayOf(StartOfAYear(iYear));
                  wStartMonth:=MonthOf(StartOfAYear(iYear));
                  wStartYear:=YearOf(StartOfAYear(iYear));
                  wStopDay:=DayOf(EndOfAYear(iYear));
                  wStopMonth:=MonthOf(EndOfAYear(iYear));
                  wStopYear:=YearOf(EndOfAYear(iYear));
                end;
            end;
        end;
    end;
  LogThis('<< ���������� �������� ������� ���������� ���������� ������� ���������.', LogGroupGUID, lmtDebug);

  if not bError then
    begin
      case cbCCID_SIC_10.ItemIndex of
        0:
          sCCID:='';
        1:
          sCCID:=' ccid="1" AND';
        2:
          sCCID:=' ccid="2" AND';
      else
        Routines_GenerateError('�� ������� ���������������� ��������� ������ �������������!', sErrorMessage, bError);
      end;

      if not bError then
        begin
          InitProgressBar(6); // 0
          // ������������ � MySQL-�������, �� ������� ��������� ������� ������������� �� rne4
          MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
          StepProgressBar; // 1

          if not bError then
            begin
              // �������� ������� ������� ������������� � ���� ������
              MySQL_CheckTableExistance(LogGroupGUID, Configuration.DBServer, Configuration.DBServer.sMySQLDatabase_T_DAY_Location, bError, sErrorMessage, 't_day');
              StepProgressBar; // 2

              if not bError then
                begin
                  // ������������ �������
                  MySQL_LockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage, Configuration.DBServer.sMySQLDatabase_T_DAY_Location+'.t_day READ');
                  StepProgressBar; // 3

                  if not bError then
                    begin
                      // ��������� ������ ������������� � ���������� ������
                      LogThis('>> ����������� �������� ��������� ������ ������������� � ���������� ������...', LogGroupGUID, lmtDebug);
                      if not Configuration.DBServer.bConnected then
                        Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                      else
                        begin
                          if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                            Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                          else
                            begin
                              q:='SELECT DISTINCT name ' //
                                +'FROM '+Configuration.DBServer.sMySQLDatabase_T_DAY_Location+'.t_day ' //
                                +'WHERE' //
                                +sCCID //
                                +' date BETWEEN "'+FormatDateTime('yyyymmdd', EncodeDate(wStartYear, wStartMonth, wStartDay))+'" AND "'+FormatDateTime('yyyymmdd', EncodeDate(wStopYear, wStopMonth, wStopDay))+'" ' //
                                +'ORDER BY name;'; //
                              LogThis(q, LogGroupGUID, lmtSQL);
                              if mysql_real_query(Configuration.DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                              else
                                begin
                                  LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                  ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                  if ResultSet=nil then
                                    Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                      iRowQuantity:=mysql_num_rows(ResultSet);
                                      LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                      if iRowQuantity<0 then
                                        Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                      else
                                        begin
                                          LogThis('���������� ����� ������� ������������� ����������.', LogGroupGUID, lmtDebug);
                                          clbUsers_SIC_10.Items.BeginUpdate;
                                          clbUsers_SIC_10.Clear;
                                          for iRowCounter:=0 to iRowQuantity-1 do
                                            if bError then
                                              Break
                                            else
                                              begin
                                                LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                if ResultRow=nil then
                                                  Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', LogGroupGUID, lmtDebug);
                                                    clbUsers_SIC_10.Items.Add(string(ResultRow[0]));
                                                  end;
                                              end;
                                          clbUsers_SIC_10.Items.EndUpdate;
                                        end;
                                      mysql_free_result(ResultSet);
                                      LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                    end;
                                end;
                            end;
                        end;
                      LogThis('<< ���������� �������� ��������� ������ ������������� � ���������� ������ ���������.', LogGroupGUID, lmtDebug);
                      StepProgressBar; // 4

                      if not bError then
                        begin
                          // ��������������� ������
                          MySQL_UnlockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                          StepProgressBar; // 5
                        end;
                    end;
                end;
              // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
              MySQL_CloseConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
              StepProgressBar; // 6
            end;
        end;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.rbUsers_SIC_04Click(Sender: TObject);
const
  LogGroupGUID: string='{C22D3DDA-47E6-4028-B7D3-F93BD4B8BAFD}';
begin
  ProcedureHeader('��������� ������� �� ������������ �������/����������� ������ ������ �������������', LogGroupGUID);

  with clbUsers_SIC_04 do
    begin
      Enabled:=False;
      Items.BeginUpdate;
      Clear;
      Items.EndUpdate;
    end;
  Update_Actions_SIC_04;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.rbUsers_SIC_10Click(Sender: TObject);
const
  LogGroupGUID: string='{82809328-4E9C-45A5-97FD-3D300B59A4C7}';
begin
  ProcedureHeader('��������� ������� �� ������������ ���������� ������ �������������', LogGroupGUID);

  with clbUsers_SIC_10 do
    begin
      Enabled:=False;
      Items.BeginUpdate;
      Clear;
      Items.EndUpdate;
    end;
  Update_Actions_SIC_10;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Logon;
const
  LogGroupGUID: string='{A6F5325A-6EDE-4AD3-B707-37627F1D1300}';
  sModalWinName: string='����� ������ � ������ ������������';
var
  sErrorMessage: string;
  i, iRowQuantity, iRowCounter: integer;
  bError: boolean;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  mr: TModalResult;
  LoginForm: TLoginForm;
  q: string;
  iBusy: integer;
begin
  ProcedureHeader('��������� ������ ������ ������ ������������', LogGroupGUID);
  bError:=False;

  // ��������� ������ � ������ ������������
  LogThis('>> ����������� �������� ��������� ������ � ������ ������������...', LogGroupGUID, lmtDebug);
  LoginForm:=TLoginForm.Create(Self);
  with LoginForm do
    try
      edbxLogin.Text:=Routines_GetConditionalMessage(Configuration.bStoreLastLogin and(Configuration.sLastLogin<>''), Configuration.sLastLogin, '');
      mePassword.Text:=Routines_GetConditionalMessage(Configuration.bStoreLastPassword and(Configuration.sLastPassword<>'')and(Configuration.sLastLogin<>''), Configuration.sLastPassword, '');
      if (Configuration.bAutoLogon and(edbxLogin.Text<>'')and(mePassword.Text<>'')) then
        ModalResult:=mrOk
      else
        begin
          if edbxLogin.Text<>'' then
            if mePassword.Text<>'' then
              ActiveControl:=btnOk
            else
              ActiveControl:=mePassword
          else
            ActiveControl:=edbxLogin;
          PreShowModal(sModalWinName, LogGroupGUID, iBusy);
          ShowModal;
        end;
    finally
      PostShowModal(sModalWinName, LogGroupGUID, iBusy);
      mr:=ModalResult;
      if mr=mrOk then
        with Configuration, CurrentUser do
          begin
            sLogin:=edbxLogin.Text;
            sPassword:=mePassword.Text;
            sLastLogin:=edbxLogin.Text;
            sLastPassword:=mePassword.Text;
          end;
      Free;
    end;
  LogThis('<< ���������� �������� ��������� ������ � ������ ������������ ���������.', LogGroupGUID, lmtDebug);

  // ���� ���� ������� ����� � ������ ������������
  if mr<>mrOk then
    LogThis('����������� ������������ �� ���� ���������!', LogGroupGUID, lmtInfo)
  else
    begin
      InitProgressBar(11);
      // ������������ � MySQL-�������, �� ������� ��������� ������� �������������
      MySQL_OpenConnection(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage);
      StepProgressBar; // 1

      if not bError then
        begin
          // ��������� ������� ������� ������������� � ���� ������
          MySQL_CheckTableExistance(LogGroupGUID, Configuration.OverseerServer, Configuration.OverseerServer.sMySQLDatabase, bError, sErrorMessage, '_users');
          StepProgressBar; // 2

          if not bError then
            begin
              // ������������ �������
              MySQL_LockTables(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage, Configuration.OverseerServer.sMySQLDatabase+'._users READ');
              StepProgressBar; // 3

              // �������� ������ ������������ �� ���� ������
              if not bError then
                with Configuration.OverseerServer, CurrentUser do
                  begin
                    LogThis('>> ����������� �������� ��������� ������ ���������� ������������...', LogGroupGUID, lmtDebug);
                    if not bConnected then
                      Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                    else
                      begin
                        if mysql_ping(hConnection)<>0 then
                          Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                        else
                          begin
                            q:='SELECT' //
                              +' usr_id,' //
                              +' usr_disabled,' //
                              +' usr_fullname,' //
                              +' usr_position,' //
                              +' usr_contactphone,' //
                              +' usr_is_admin ' //
                              +'FROM '+sMySQLDatabase+'._users ' //
                              +'WHERE' //
                              +' usr_login='+Routines_NormalizeStringForQuery(sLogin, True, False) //
                              +' AND usr_password_md5=md5('+Routines_NormalizeStringForQuery(sPassword, True, False)+');'; //
                            LogThis(q, LogGroupGUID, lmtSQL);
                            if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                              Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                            else
                              begin
                                LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                ResultSet:=mysql_store_result(hConnection);
                                if ResultSet=nil then
                                  Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                else
                                  begin
                                    LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                    i:=mysql_num_rows(ResultSet);
                                    LogThis('���������� ����� ������� ����� '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                                    if i<0 then
                                      Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                    else
                                      begin
                                        if i=0 then
                                          Routines_GenerateError('������������ � ���������� ������� � ������� �� ����������! '+#13#10+'��������� ������� ���� �����, ��������� ������� Caps Lock � ������������ ������.', sErrorMessage, bError)
                                        else
                                          begin
                                            if i>1 then
                                              begin
                                                LogThis('���������� ����� ������� ('+IntToStr(i)+')�� ������������� ���������� (1)!', LogGroupGUID, lmtError);
                                                Routines_GenerateError('������� ����� ����� ������� ������ � ���������� ������� � �������! ���������� � ��������������!', sErrorMessage, bError);
                                              end
                                            else
                                              begin
                                                LogThis('���������� ����� ������� ������������� ����������.', LogGroupGUID, lmtDebug);
                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                if ResultRow=nil then
                                                  Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    if ResultRow[1]='1' then
                                                      Routines_GenerateError('� ��������� ������ ������ ������� ������ ���������! ���������� � ��������������!', sErrorMessage, bError)
                                                    else
                                                      with CurrentUser do
                                                        begin
                                                          sID:=string(ResultRow[0]);
                                                          sFullName:=string(ResultRow[2]);
                                                          sPosition:=string(ResultRow[3]);
                                                          sContactPhone:=string(ResultRow[4]);
                                                          bIsAdmin:=string(ResultRow[5])='1';
                                                          LogThis('������ ������������ �������� �������.', LogGroupGUID, lmtDebug);
                                                        end;
                                                  end;
                                              end;
                                          end;
                                      end;
                                    mysql_free_result(ResultSet);
                                    LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                  end;
                              end;
                          end;
                      end;
                    LogThis('<< ���������� �������� ��������� ������ ���������� ������������ ���������.', LogGroupGUID, lmtDebug);
                    StepProgressBar; // 4

                    // ��������������� ������
                    if not bError then
                      begin
                        MySQL_UnlockTables(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage);
                        StepProgressBar; // 5

                        // ���������� ������ �������� � ������������ � ������� ������� �������� ������������
                        if not bError then
                          begin
                            LogThis('>> ����������� �������� ��������� ���� ������� �������� ������������...', LogGroupGUID, lmtDebug);
                            cbActionsList.Clear;

                            // ��������� ������� ������� �������� � ���� ������
                            MySQL_CheckTableExistance(LogGroupGUID, Configuration.OverseerServer, Configuration.OverseerServer.sMySQLDatabase, bError, sErrorMessage, '_actions');
                            StepProgressBar; // 6

                            if not bError then
                              begin
                                // ��������� ������� ������� ���� ������������� � ���� ������
                                MySQL_CheckTableExistance(LogGroupGUID, MainForm.Configuration.OverseerServer, MainForm.Configuration.OverseerServer.sMySQLDatabase, bError, sErrorMessage, '_permissions');
                                StepProgressBar; // 7

                                if not bError then
                                  begin
                                    // ������������ ������
                                    MySQL_LockTables(LogGroupGUID, MainForm.Configuration.OverseerServer, bError, sErrorMessage, MainForm.Configuration.OverseerServer.sMySQLDatabase+'._actions READ, _permissions READ');
                                    StepProgressBar; // 8

                                    // ��������� ������ ������� ��������
                                    if not bError then
                                      with Configuration.OverseerServer do
                                        begin
                                          LogThis('>> ����������� �������� ��������� ������� ������ ��������...', LogGroupGUID, lmtDebug);
                                          if not bConnected then
                                            Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                          else
                                            begin
                                              if mysql_ping(hConnection)<>0 then
                                                Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
                                              else
                                                begin
                                                  q:='SELECT act_name ' //
                                                    +'FROM '+sMySQLDatabase+'._actions ' //
                                                    +'LEFT JOIN '+sMySQLDatabase+'._permissions ON prm_action_id=act_id ' // '
                                                    +'WHERE' //
                                                    +' prm_permit="1" AND' //
                                                    +' prm_user_id='+CurrentUser.sID+' ' //
                                                    +'ORDER BY act_name;'; //
                                                  LogThis(q, LogGroupGUID, lmtSQL);
                                                  if mysql_real_query(hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                                    Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
                                                  else
                                                    begin
                                                      LogThis('������ �������� �������.', LogGroupGUID, lmtDebug);
                                                      ResultSet:=mysql_store_result(hConnection);
                                                      if ResultSet=nil then
                                                        Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
                                                      else
                                                        begin
                                                          LogThis('�������������� ������� �������� �������.', LogGroupGUID, lmtDebug);
                                                          iRowQuantity:=mysql_num_rows(ResultSet);
                                                          LogThis('���������� ����� ������� ����� '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                                          if iRowQuantity<0 then
                                                            Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                                                          else
                                                            begin
                                                              LogThis('���������� ����� ������� ������������� ����������.', LogGroupGUID, lmtDebug);
                                                              for iRowCounter:=0 to iRowQuantity-1 do
                                                                if bError then
                                                                  Break
                                                                else
                                                                  begin
                                                                    LogThis('��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                                    if ResultRow=nil then
                                                                      Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                                                    else
                                                                      begin
                                                                        cbActionsList.Items.Add(string(ResultRow[0]));
                                                                        LogThis('�������� ��������� ��������� ������ ������� ('+IntToStr(iRowCounter)+') ������ �������.', LogGroupGUID, lmtDebug);
                                                                      end;
                                                                  end;
                                                            end;
                                                          mysql_free_result(ResultSet);
                                                          LogThis('������������ ��������, ������� ����������� �������, ���������.', LogGroupGUID, lmtDebug);
                                                        end;
                                                    end;
                                                end;
                                            end;
                                          LogThis('<< ���������� �������� ��������� ������� ������ �������� ���������.', LogGroupGUID, lmtDebug);
                                          StepProgressBar; // 9

                                          // ��������������� ������
                                          if not bError then
                                            begin
                                              MySQL_UnlockTables(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage);
                                              StepProgressBar; // 10

                                              CurrentUser.bLogged:=True; // ������ � ������ ������� ������ ����������� ������������ ���������� ���� �����������
                                              LogThis('����������� ������������ ������ �������.', LogGroupGUID, lmtInfo);
                                              LogThis('����� ������ ������������ �����.', LogGroupGUID, lmtInfo);

                                              // ����������� ���������� � ������������ �������� �� ���������
                                              cbActionsList.ItemIndex:=cbActionsList.Items.IndexOf(Configuration.sDefaultAction);
                                              if cbActionsList.ItemIndex<0 then
                                                cbActionsList.ItemIndex:=0;
                                              Do_SelectAction;
                                            end;
                                        end;
                                  end;

                              end;

                            LogThis('<< ���������� �������� ��������� ���� ������� �������� ������������ ���������.', LogGroupGUID, lmtDebug);
                          end;
                      end;
                  end;
            end;
        end;

      // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
      MySQL_CloseConnection(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage);
      StepProgressBar; // 11
    end;

  if not bError then
    begin
      Update_Actions;
      Update_pnlConnectedMode;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

// procedure TMainForm.Start_ActionTimer(aLogGroupGUID: string);
// begin
// ttsActionStart:=DateTimeToTimeStamp(Now);
// LogThis('����� ������� ���������� �������� �����.', aLogGroupGUID, lmtDebug);
// end;
//
// procedure TMainForm.Stop_ActionTimer(aLogGroupGUID: string);
// var
// TotalTime: LongWord;
// begin
// TotalTime:=DateTimeToTimeStamp(Now).Time-ttsActionStart.Time;
// LogThis('����� ���������� �������� ��������� '+IntToStr(integer(TotalTime))+' ��.', aLogGroupGUID, lmtDebug);
// end;

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

procedure TMainForm.ShowErrorBox(const aHandle: HWND; const aErrorMessage: string; const aLogGroupGUID: string);
var
  iOldBusyCounter: integer;
begin
  LogThis(aErrorMessage, aLogGroupGUID, lmtError);

  iOldBusyCounter:=iBusyCounter; // ���������� �������� �������� ��������, ��������� ��������� "������"
  iBusyCounter:=0; // ��������� �������� ����� ��������� ���������� ����
  Refresh_BusyState(aLogGroupGUID); // ���������� ��������� ����������

  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar('OVERSEER - ������!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  Application.ProcessMessages;

  iBusyCounter:=iOldBusyCounter; // ����������� ������� �������� ��������
  Refresh_BusyState(aLogGroupGUID); // ���������� ��������� ����������
  Application.ProcessMessages;
end;

procedure TMainForm.Action_ProcessExecute(Sender: TObject);
const
  LogGroupGUID: string='{9B587CF1-98E3-4323-95CB-3DF29E155052}';
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Process.Caption+'"', LogGroupGUID);
  Do_Process;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm._ProgressBarMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  aX, aY: integer;
begin
  if Sender is TProgressBar then
    begin
      aX:=TProgressBar(Sender).ClientToParent(Point(X, Y), TProgressBar(Sender).Parent).X;
      aY:=TProgressBar(Sender).ClientToParent(Point(X, Y), TProgressBar(Sender).Parent).Y;
      if lvActionList.GetItemAt(aX, AY)<>nil then
        begin
          lvActionList.GetItemAt(aX, AY).Selected:=True;
          lvActionList.GetItemAt(aX, AY).Focused:=True;
        end;
    end;
end;

function TMainForm.Do_SIC_01(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aPhonesList: TStringList; const aShowUnserved: boolean): boolean;
const
  LogGroupGUID: string='{2587EA3D-6408-4604-8F2E-54FE647678B2}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // �������� ������ ������ � ������� ����� ����������� ��� �������� �� ������������ ������
  with TThread_Do_SIC_01.Create( //
    '{34182F45-5792-4FA4-895C-F1410DD8EBB6}', //
    aStartDate, //
    aStopDate, //
    aOpenWithBrowser, //
    aShowUnserved, //
    CurrentUser, //
    Configuration, //
    aPhonesList //
    ) do //
    try
      Start; // ��������� ���������� ������
    except
      on Exception do
        Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
    end;

  Do_SIC_01:=not bError;
end;

function TMainForm.Do_SIC_03(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aNetIndex: integer): boolean;
const
  LogGroupGUID: string='{99A443F4-4D52-42DE-AD56-0292038528BA}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // �������� ������ ������ � ������� ����� ����������� ��� �������� �� ������������ ������
  with TThread_Do_SIC_03.Create( //
    '{959697CB-3316-4FA2-BD3C-1A54515DBEFC}', //
    aStartDate, //
    aStopDate, //
    aOpenWithBrowser, //
    CurrentUser, //
    Configuration, //
    aNetIndex //
    ) do //
    try
      Start; // ��������� ���������� ������
    except
      on Exception do
        Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
    end;

  Do_SIC_03:=not bError;
end;

function TMainForm.Do_SIC_07(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aCalculateWeekFromMonday: boolean): boolean;
const
  LogGroupGUID: string='{71E749C1-C998-43D1-B806-3BFD243D3BFA}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // �������� ������ ������ � ������� ����� ����������� ��� �������� �� ������������ ������
  with TThread_Do_SIC_07.Create( //
    '{42EF6EE0-6AC7-400D-8BF5-2177FEA86C1F}', //
    aStartDate, //
    aStopDate, //
    aOpenWithBrowser, //
    aCalculateWeekFromMonday, //
    CurrentUser, //
    Configuration, //
    aGroupByPeriod //
    ) do //
    try
      Start; // ��������� ���������� ������
    except
      on Exception do
        Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
    end;

  Do_SIC_07:=not bError;
end;

function TMainForm.Do_SIC_04(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aCalculateWeekFromMonday, aAllUsers, aCreateDetailedReport, aShowSQLQueries, aShowIdleUsers: boolean;
  const aSelectedUserList: TStringList): boolean;
const
  LogGroupGUID: string='{E2E2F7E9-046B-4AF3-8029-B846D20883D2}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // �������� ������ ������ � ������� ����� ����������� ��� �������� �� ������������ ������
  with TThread_Do_SIC_04.Create('{D6FBA897-C198-4B2F-A4EC-0934EE48ACD7}', //
    aStartDate, //
    aStopDate, //
    aOpenWithBrowser, //
    aCreateDetailedReport, //
    aShowSQLQueries, //
    aAllUsers, //
    aShowIdleUsers, //
    CurrentUser, //
    Configuration, //
    aGroupByPeriod, //
    aSelectedUserList //
    ) do //
    try
      Start; // ��������� ���������� ������
    except
      on Exception do
        Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
    end;

  Do_SIC_04:=not bError;
end;

function TMainForm.Do_SIC_05(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aServiceIndex: integer; const aCalculateWeekFromMonday: boolean): boolean;
const
  LogGroupGUID: string='{583963FE-2E91-443C-94B7-C71A71AA6CE9}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // �������� ������ ������ � ������� ����� ����������� ��� �������� �� ������������ ������
  with TThread_Do_SIC_05.Create( //
    '{78E66AFF-4BB3-495F-819A-CEF3339AA23A}', //
    aStartDate, //
    aStopDate, //
    aOpenWithBrowser, //
    aCalculateWeekFromMonday, //
    CurrentUser, //
    Configuration, //
    aGroupByPeriod, //
    aServiceIndex //
    ) do //
    try
      Start; // ��������� ���������� ������
    except
      on Exception do
        Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
    end;

  Do_SIC_05:=not bError;
end;

function TMainForm.Do_SIC_08(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean): boolean;
const
  LogGroupGUID: string='{18C42AD9-6099-4D5C-8BC9-56F3B1C15115}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // �������� ������ ������ � ������� ����� ����������� ��� �������� �� ������������ ������
  with TThread_Do_SIC_08.Create( //
    '{D43A98B2-4615-4584-9FBE-8F3CB31C6958}', //
    aStartDate, //
    aStopDate, //
    aOpenWithBrowser, //
    CurrentUser, //
    Configuration //
    ) do //
    try
      Start; // ��������� ���������� ������
    except
      on Exception do
        Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
    end;

  Do_SIC_08:=not bError;
end;

function TMainForm.Do_SIC_10(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aCalculateWeekFromMonday, aAllUsers, aCreateDetailedReport: boolean; const aCCID: integer;
  const aSelectedUserList: TStringList): boolean;
const
  LogGroupGUID: string='{49C8CBFB-9D2A-4E23-A8DF-10D0CB6C6719}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // �������� ������ ������ � ������� ����� ����������� ��� �������� �� ������������ ������
  with TThread_Do_SIC_10.Create('{1726AE8E-E2E2-4051-B375-8CC618EC7FBE}', aStartDate, aStopDate, aOpenWithBrowser, aAllUsers, aCalculateWeekFromMonday, aCreateDetailedReport, CurrentUser, Configuration, aCCID, aGroupByPeriod, aSelectedUserList) do
    try
      Start; // ��������� ���������� ������
    except
      on Exception do
        Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
    end;

  Do_SIC_10:=not bError;
end;

procedure TMainForm.cbSummaryReport_SIC_09Click(Sender: TObject);
const
  LogGroupGUID: string='{DCB28878-1DF5-4EAA-A757-8EF3EF7DE73E}';
begin
  ProcedureHeader('��������� ������� �� ������������ ��������� ������ "'+cbSummaryReport_SIC_09.Caption+'"', LogGroupGUID);

  cbOldReport_SIC_09.Enabled:=not cbSummaryReport_SIC_09.Checked;
  if not cbOldReport_SIC_09.Enabled then
    cbOldReport_SIC_09.Checked:=False;
  LogThis('������ "'+cbSummaryReport_SIC_09.Caption+'" '+Routines_GetConditionalMessage(cbSummaryReport_SIC_09.Checked, '�������', '��������')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbOldReport_SIC_09Click(Sender: TObject);
const
  LogGroupGUID: string='{96103B91-D537-423F-9398-53F33A6479CB}';
begin
  ProcedureHeader('��������� ������� �� ������������ ��������� ������ "'+cbOldReport_SIC_09.Caption+'"', LogGroupGUID);

  cbSummaryReport_SIC_09.Enabled:=not cbOldReport_SIC_09.Checked;
  if not cbSummaryReport_SIC_09.Enabled then
    cbSummaryReport_SIC_09.Checked:=False;
  LogThis('������ "'+cbOldReport_SIC_09.Caption+'" '+Routines_GetConditionalMessage(cbOldReport_SIC_09.Checked, '�������', '��������')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

function TMainForm.Do_SIC_09(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aNetIndex: integer; const aSummaryReport, aOldReport: boolean; const aSelectedServicesList: TStringList): boolean;
const
  LogGroupGUID: string='{5EC0AAA9-F42C-4D89-9267-7E0FCC4A9513}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // �������� ������ ������ � ������� ����� ����������� ��� �������� �� ������������ ������
  with TThread_Do_SIC_09.Create('{2235B998-6802-49A7-B681-EF9BC48BEB53}', //
    aStartDate, //
    aStopDate, //
    aOpenWithBrowser, //
    aSummaryReport, //
    aOldReport, //
    CurrentUser, //
    Configuration, //
    aNetIndex, //
    aSelectedServicesList //
    ) do //
    try
      Start; // ��������� ���������� ������
    except
      on Exception do
        Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
    end;

  Do_SIC_09:=not bError;
end;

procedure TMainForm.MySQL_UnlockTables(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
var
  q: string;
begin
  LogThis('>> ����������� �������� ��������������� ���� ����� ��������������� ������ ���� ������...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          q:='UNLOCK TABLES;';
          LogThis(q, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
            Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
          else
            LogThis('������ �������� �������.', aLogGroupGUID, lmtDebug);
        end;
    end;
  LogThis('<< ���������� �������� ��������������� ������ ���� ������ ���������.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.MySQL_CloseConnection(const aLogGroupGUID: string; var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
begin
  with aTMySQLServerConnectionDetails do
    begin
      if bConnected then
        begin
          LogThis('>> ����������� �������� ���������� �� MySQL-������� '+sMySQLHost+'...', aLogGroupGUID, lmtDebug);
          if hConnection<>nil then
            begin
              mysql_close(hConnection);
              hConnection:=nil;
            end;
          bConnected:=False;
          LogThis('���������� �� MySQL-������� '+sMySQLHost+' ��������� �������.', aLogGroupGUID, lmtDebug);
          LogThis('<< ���������� �������� ���������� �� MySQL-������� '+sMySQLHost+' ���������.', aLogGroupGUID, lmtDebug);
        end;
    end;
end;

procedure TMainForm.MySQL_LockTables(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aTablesList: string);
var
  q: string;
begin
  LogThis('>> ����������� �������� ���������� ������� ���� ������...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          q:='LOCK TABLE '+aTablesList+';';
          LogThis(q, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
            Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
          else
            LogThis('������ �������� �������.', aLogGroupGUID, lmtDebug);
        end;
    end;
  LogThis('<< ���������� �������� ���������� ������� ���� ������ ���������.', aLogGroupGUID, lmtDebug);
end;

function TMainForm.MySQL_UpdateRecords(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
begin
  Result:=-1;
  LogThis('>> ����������� �������� ���������� ������ �������...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          LogThis(aQuery, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
            Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
          else
            begin
              LogThis('������ �������� �������.', aLogGroupGUID, lmtDebug);
              Result:=mysql_affected_rows(aTMySQLServerConnectionDetails.hConnection);
              LogThis('���������� ������������ ����� ����� '+IntToStr(Result)+'.', aLogGroupGUID, lmtDebug);
              if Result<0 then
                Routines_GenerateError('���������� ������������ ����� ('+IntToStr(Result)+') �� ������������� ���������� (>=0)!', sErrorMessage, bError)
              else
                LogThis('���������� ������ ��������� �������.', aLogGroupGUID, lmtDebug);
            end;
        end;
    end;
  LogThis('<< ���������� �������� ���������� ������ ������� ���������.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.MySQL_OpenConnection(const aLogGroupGUID: string; var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
begin
  with aTMySQLServerConnectionDetails do
    begin
      LogThis('>> ����������� �������� ����������� � MySQL-������� '+sMySQLHost+'...', aLogGroupGUID, lmtDebug);
      if bConnected then
        Routines_GenerateError('���� ����������� ������� ����������� � ������������� � ��������� ������ ������� MySQL!', sErrorMessage, bError)
      else
        begin
          hConnection:=mysql_init(nil);
          if hConnection=nil then
            Routines_GenerateError('�������� ������ ��� ������������� ������� ���������� � �������� MySQL!', sErrorMessage, bError)
          else
            begin
              LogThis('������������� ������� ���������� � �������� MySQL ��������� �������.', aLogGroupGUID, lmtDebug);
              bConnected:=mysql_real_connect(hConnection, PAnsiChar(AnsiString(sMySQLHost)), PAnsiChar('overseer'), PAnsiChar(''), PAnsiChar(AnsiString(sMySQLDatabase)), iMySQLPort, nil, integer(bMySQLCompress)*CLIENT_COMPRESS)<>nil;
              if not bConnected then
                Routines_GenerateError('�������� ������ ��� ������� ����������� � ������� MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                LogThis('����������� � MySQL-������� '+aTMySQLServerConnectionDetails.sMySQLHost+' ��������� �������.', aLogGroupGUID, lmtDebug);
            end;
        end;
      LogThis('<< ���������� �������� ����������� � MySQL-������� '+aTMySQLServerConnectionDetails.sMySQLHost+' ���������.', aLogGroupGUID, lmtDebug);
    end;
end;

procedure TMainForm.MySQL_CheckTableExistance(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; const aMySQLDatabase: string; var bError: boolean; var sErrorMessage: string; const aTableName: string);
var
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  q: string;
  i: integer;
begin
  LogThis('>> ����������� �������� �������� ������� ������� ������ "'+aTableName+'" � ���� ������...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          q:='SHOW TABLES FROM '+aMySQLDatabase+' LIKE "'+LowerCase(aTableName)+'";';
          LogThis(q, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
            Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
          else
            begin
              LogThis('������ �������� �������.', aLogGroupGUID, lmtDebug);
              ResultSet:=mysql_store_result(aTMySQLServerConnectionDetails.hConnection);
              if ResultSet=nil then
                Routines_GenerateError('�� ������� �������� �������������� ������� �� ���������� SQL-�������!', sErrorMessage, bError)
              else
                begin
                  LogThis('�������������� ������� �������� �������.', aLogGroupGUID, lmtDebug);
                  i:=mysql_num_rows(ResultSet);
                  LogThis('���������� ����� ������� ����� '+IntToStr(i)+'.', aLogGroupGUID, lmtDebug);
                  if i<0 then
                    Routines_GenerateError('�������� ������ ��� ��������� ���������� ���� �������������� �������!', sErrorMessage, bError)
                  else
                    begin
                      if i<>1 then
                        Routines_GenerateError('���������� ����� ������� ('+IntToStr(i)+') �� ������������� ���������� (1)!', sErrorMessage, bError)
                      else
                        begin
                          LogThis('���������� ����� ������� ������������� ����������.', aLogGroupGUID, lmtDebug);
                          ResultRow:=mysql_fetch_row(ResultSet);
                          if ResultRow=nil then
                            Routines_GenerateError('�������� ������ ��� �������� ������ ������ ������� (���������� ����� ������ ����� 1)!', sErrorMessage, bError)
                          else
                            begin
                              if LowerCase(string(ResultRow[0]))<>LowerCase(aTableName) then
                                Routines_GenerateError('���������� ��� ������� ������ �� ������������� ����������!', sErrorMessage, bError)
                              else
                                LogThis('������� ������� ������ ��������� �������.', aLogGroupGUID, lmtDebug);
                            end;
                        end;
                    end;
                  mysql_free_result(ResultSet);
                  LogThis('������������ ��������, ������� ����������� �������, ���������.', aLogGroupGUID, lmtDebug);
                end;
            end;
        end;
    end;
  LogThis('<< ���������� �������� �������� ������� ������� ������ "'+aTableName+'" � ���� ������ ���������.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.MySQL_CreateTable(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
begin
  LogThis('>> ����������� �������� �� �������� ������� ������...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
  else
    if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
      Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
    else
      begin
        LogThis(aQuery, aLogGroupGUID, lmtSQL);
        if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
          Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
        else
          LogThis('������ �������� �������.', aLogGroupGUID, lmtDebug);
      end;
  LogThis('<< ���������� �������� �� �������� ������� ������ ���������.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.MySQL_DropTable(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
begin
  LogThis('>> ����������� �������� �� �������� ������� ������...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
  else
    if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
      Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
    else
      begin
        LogThis(aQuery, aLogGroupGUID, lmtSQL);
        if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
          Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������!', sErrorMessage, bError)
        else
          LogThis('������ �������� �������.', aLogGroupGUID, lmtDebug);
      end;
  LogThis('<< ���������� �������� �� �������� ������� ������ ���������.', aLogGroupGUID, lmtDebug);
end;

function TMainForm.MySQL_InsertRecords(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
begin
  Result:=-1;
  LogThis('>> ����������� �������� ������� ������� � �������...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('��� ���������� �������� ���������� ����������� � ������� MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('�������� ������ ��� ������� �������� ����������� � ������� MySQL!', sErrorMessage, bError)
      else
        begin
          LogThis(aQuery, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
            begin
              Routines_GenerateError('�������� ������ ��� ���������� ���������� SQL-�������! '+mysql_error(aTMySQLServerConnectionDetails.hConnection), sErrorMessage, bError);
            end
          else
            begin
              LogThis('������ �������� �������.', aLogGroupGUID, lmtDebug);
              Result:=mysql_affected_rows(aTMySQLServerConnectionDetails.hConnection);
              LogThis('���������� ������������ ����� ����� '+IntToStr(Result)+'.', aLogGroupGUID, lmtDebug);
              if Result<0 then
                Routines_GenerateError('���������� ������������ ����� ('+IntToStr(Result)+') �� ������������� ���������� (>=0)!', sErrorMessage, bError)
              else
                LogThis('������� ������ ��������� �������.', aLogGroupGUID, lmtDebug);
            end;
        end;
    end;
  LogThis('<< ���������� �������� ������� ������� � ������� ���������.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('��������� ��������� ��� ������.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
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

procedure TMainForm.Do_Comments;
const
  LogGroupGUID: string='{B7C8AA25-E38C-4BE7-B2B3-236FFFB048B8}';
  sModalWinName: string='"�����������..."';
var
  CommentsForm: TCommentsForm;
  iBusy: integer;
begin
  ProcedureHeader('��������� ����������� ���� '+sModalWinName, LogGroupGUID);

  CommentsForm:=TCommentsForm.Create(Self);
  with CommentsForm do
    try
      SmallImage:=TJPEGImage.Create;
      SmallImage.LoadFromFile('D:\My Documents\RAD Studio\Projects\Overseer\CommentsPictures\���-07-�-�_Preview.jpg');

      NormalImage:=TJPEGImage.Create;
      NormalImage.LoadFromFile('D:\My Documents\RAD Studio\Projects\Overseer\CommentsPictures\���-07-�-�.jpg');

      PreShowModal(sModalWinName, LogGroupGUID, iBusy);
      ShowModal;
    finally
      PostShowModal(sModalWinName, LogGroupGUID, iBusy);
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

function TMainForm.Do_ASKR(const aStartDate, aStopDate: TDate): boolean;
const
  LogGroupGUID: string='{2A215240-6E2D-4616-B304-248CD425752F}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // �������� ������ ������ � ������� ����� ����������� ��� �������� �� ������������ ������
  with TThread_Do_ASKR.Create( //
    '{579EF208-BFB8-4555-86CC-9EC2CE7CDFCE}', //
    aStartDate, //
    aStopDate, //
    CurrentUser, //
    Configuration //
    ) do //
    try
      Start; // ��������� ���������� ������
    except
      on Exception do
        Routines_GenerateError('��������� ������ ��� ������� ��������� ������!', sErrorMessage, bError);
    end;

  Do_ASKR:=not bError;
end;

procedure TMainForm.Do_About;
const
  LogGroupGUID: string='{12AD944B-B412-4D41-A2AB-1836C6352752}';
  sModalWinName: string='"� ���������..."';
var
  AboutForm: TAboutForm;
  iBusy: integer;
begin
  ProcedureHeader('��������� ����������� ���� '+sModalWinName, LogGroupGUID);

  if bAboutWindowExist then
    SetForegroundWindow(FindWindow('TAboutForm', 'About "OVERSEER"...'))
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

procedure TMainForm.Do_RestoreMainForm;
const
  LogGroupGUID: string='{420D53A5-8A48-4EC2-8B8F-6CA389870E95}';
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

procedure TMainForm.ApplicationEvents1Restore(Sender: TObject);
begin
  if bAboutWindowExist then
    SetForegroundWindow(FindWindow('TAboutForm', 'About "OVERSEER"...'));
end;

function TMainForm.Do_PayOff(const aPayoffList: TStringList): boolean;
const
  LogGroupGUID: string='{8E920B8F-8164-47C1-99D6-ACD40BBEA027}';
var
  sErrorMessage: string;
  bError: boolean;
  i: integer;
  aIRDTableRecord: trIRDTableRecord;
  aDate: TDate;
begin
  ProcedureHeader('��������� ������ ������ �� ��������� ������ �� ��������� ������ ���...', LogGroupGUID);
  bError:=False;

  InitProgressBar(aPayoffList.Count);
  // ������� ����� � ���� ������ ird �� �����, ���������� �� �������
  for i:=0 to aPayoffList.Count-1 do
    if bError then
      Break
    else
      begin
        aIRDTableRecord:=Routines_Convert_string_to_trIRDTableRecord(aPayoffList[i]);
        aDate:=EncodeDate(StrToIntDef(Copy(aIRDTableRecord.datum, 7, 4), 1900), StrToIntDef(Copy(aIRDTableRecord.datum, 4, 2), 1), StrToIntDef(Copy(aIRDTableRecord.datum, 1, 2), 1));
        if IsSameDay(EncodeDate(1900, 1, 1), aDate) then
          Routines_GenerateError('�������� ������ ��� ����������� ���� ������!', sErrorMessage, bError)
        else
          begin
            if IsSameDay(ToDay, aDate) then // ���� ������ ��������� � ����������� �������
              begin
                // ����������� � MySQL-�������
                MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);

                if not bError then
                  begin
                    // �������� ������� ������� � ���� ������
                    MySQL_CheckTableExistance(LogGroupGUID, Configuration.DBServer, Configuration.DBServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, 'ird_'+FormatDateTime('yyyymmdd', aDate));

                    if not bError then
                      begin
                        MySQL_UpdateRecords(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage, //
                          'UPDATE '+Configuration.DBServer.sMySQLDatabase_IRD_Location+'.ird_'+FormatDateTime('yyyymmdd', aDate)+' ' //
                          +'SET rm="-'+aIRDTableRecord.rm+'" ' //
                          +'WHERE' //
                          +' ani="'+aIRDTableRecord.ani+'" AND' //
                          +' ddi="'+aIRDTableRecord.ddi+'" AND' //
                          +' datum="'+FormatDateTime('yyyy-mm-dd', aDate)+'" AND' //
                          +' vrijeme="'+aIRDTableRecord.vrijeme+'" AND' //
                          +' dur="'+aIRDTableRecord.dur+'" AND' //
                          +' rm="'+aIRDTableRecord.rm+'" AND' //
                          +' izg="'+aIRDTableRecord.izg+'" AND' //
                          +' izgnum="'+aIRDTableRecord.izgnum+'" AND' //
                          +' v_oper="'+aIRDTableRecord.v_oper+'" AND' //
                          +' v_mreza="'+aIRDTableRecord.v_mreza+'";'); //
                      end;

                    // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
                    MySQL_CloseConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                  end;
              end
            else
              begin
                // ����������� � MySQL-�������
                MySQL_OpenConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);

                if not bError then
                  begin
                    // �������� ������� ������� � ���� ������
                    MySQL_CheckTableExistance(LogGroupGUID, Configuration.StatServer, Configuration.StatServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, 'ird_'+FormatDateTime('yyyymmdd', aDate));

                    if not bError then
                      begin
                        // ������������ �������
                        MySQL_LockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, Configuration.StatServer.sMySQLDatabase_IRD_Location+'.ird_'+FormatDateTime('yyyymmdd', aDate)+' WRITE');

                        if not bError then
                          begin
                            MySQL_UpdateRecords(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, //
                              'UPDATE '+Configuration.StatServer.sMySQLDatabase_IRD_Location+'.ird_'+FormatDateTime('yyyymmdd', aDate)+' ' //
                              +'SET rm="-'+aIRDTableRecord.rm+'" ' //
                              +'WHERE' //
                              +' ani="'+aIRDTableRecord.ani+'" AND' //
                              +' ddi="'+aIRDTableRecord.ddi+'" AND' //
                              +' datum="'+FormatDateTime('yyyy-mm-dd', aDate)+'" AND' //
                              +' vrijeme="'+aIRDTableRecord.vrijeme+'" AND' //
                              +' dur="'+aIRDTableRecord.dur+'" AND' //
                              +' rm="'+aIRDTableRecord.rm+'" AND' //
                              +' izg="'+aIRDTableRecord.izg+'" AND' //
                              +' izgnum="'+aIRDTableRecord.izgnum+'" AND' //
                              +' v_oper="'+aIRDTableRecord.v_oper+'" AND' //
                              +' v_mreza="'+aIRDTableRecord.v_mreza+'";'); //

                            if not bError then
                              begin
                                // ��������������� ������
                                MySQL_UnlockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);

                                // ��������� ������ �� DBSERVER, ���� ���� � ������� �������
                                if not bError then
                                  begin

                                    // ����������� � MySQL-�������
                                    MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);

                                    if not bError then
                                      begin
                                        // �������� ������� ������� � ���� ������
                                        MySQL_CheckTableExistance(LogGroupGUID, Configuration.DBServer, Configuration.DBServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, 'ird_'+FormatDateTime('yyyymmdd', aDate));

                                        if not bError then
                                          begin
                                            MySQL_UpdateRecords(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage, //
                                              'UPDATE '+Configuration.DBServer.sMySQLDatabase_IRD_Location+'.ird_'+FormatDateTime('yyyymmdd', aDate)+' ' //
                                              +'SET rm="-'+aIRDTableRecord.rm+'" ' //
                                              +'WHERE' //
                                              +' ani="'+aIRDTableRecord.ani+'" AND' //
                                              +' ddi="'+aIRDTableRecord.ddi+'" AND' //
                                              +' datum="'+FormatDateTime('yyyy-mm-dd', aDate)+'" AND' //
                                              +' vrijeme="'+aIRDTableRecord.vrijeme+'" AND' //
                                              +' dur="'+aIRDTableRecord.dur+'" AND' //
                                              +' rm="'+aIRDTableRecord.rm+'" AND' //
                                              +' izg="'+aIRDTableRecord.izg+'" AND' //
                                              +' izgnum="'+aIRDTableRecord.izgnum+'" AND' //
                                              +' v_oper="'+aIRDTableRecord.v_oper+'" AND' //
                                              +' v_mreza="'+aIRDTableRecord.v_mreza+'";'); //
                                          end
                                        else
                                          bError:=False; // � ������ ���� ������� ���� ���� - �� ������� ��� �� ������

                                        // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
                                        MySQL_CloseConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                                      end;
                                  end;
                              end;
                          end;
                      end;

                    // ���������� �� MySQL-������� �� ��������� ������ ������� ��������� � ������ ������ - ���� � ������ ������
                    MySQL_CloseConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
                  end;
              end;
          end;
        StepProgressBar;
      end;

  // ����� ��������� �� �������� ���������� ��������, ���� �� ����� ���� ��������
  if not bError then
    begin
      Application.ProcessMessages;
      MessageBox(Handle, PWideChar('�������� ��������� �������.'), PWideChar('OVERSEER - ����������'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
  Do_PayOff:=not bError;
end;

procedure TMainForm.WMCopyData(var Msg: TWMCopyData);
const
  LogGroupGUID: string='{E7F0CF2F-1AAB-471B-9B77-E4E69B2BE487}';
var
  cText: array [0..51200] of AnsiChar;
  sl: TStringList;
  MessageType: TLogMessagesType;
  bError: boolean;
  sErrorMessage: string;
begin
  // ProcedureHeader('��������� ��������� ������ �� �������� ��������', LogGroupGUID);
  MessageType:=lmtError;

  StrLCopy(cText, Msg.CopyDataStruct.lpData, Msg.CopyDataStruct.cbData);
  // LogThis(PChar('������, ��������� �� �������� ��������: ['+cText+']'), LogGroupGUID, lmtDebug);

  if Msg.From=HWND(MainForm.Handle) then
    begin
      sl:=TStringList.Create;
      try
        Routines_CutStringByLimiterToStringList(string(AnsiString(cText)), sl, ';');
        if sl.Count=4 then
          begin
            if ((sl[0]=IntToStr(WMCD_THREADLOG))or(sl[0]=IntToStr(WMCD_MODALLOG)))and((sl[1]='ERROR')or(sl[1]='WARNING')or(sl[1]='INFO')or(sl[1]='SQL')or(sl[1]='DEBUG')) then
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
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  // ProcedureFooter(LogGroupGUID);
end;

{
  # 109 ������� ������
  SELECT "109d" AS ddi,
  COUNT(*)
  FROM irda.tmp_03_1
  WHERE ddi="109" AND vrijeme BETWEEN "06:00:00" AND "21:59:59"
  GROUP BY ddi
  UNION

  # 109 ������ ������
  SELECT "109n" AS ddi,
  COUNT(*)
  FROM irda.tmp_03_1
  WHERE ddi="109" AND ((vrijeme BETWEEN "22:00:00" AND "23:59:59") OR (vrijeme BETWEEN "00:00:00" AND "05:59:59"))
  GROUP BY ddi
  UNION

  # 188 192 195
  SELECT ddi, COUNT(*)
  FROM irda.tmp_03_1
  WHERE ddi="188" OR ddi="192" OR ddi="195"
  GROUP BY ddi
  ORDER BY ddi;

  SELECT ddi,
  COUNT(*),
  CEILING(SUM(dur)/60),
  SUM(CEILING(dur/60))
  FROM irda.tmp_03_1
  WHERE ddi="175" OR ddi="190" OR ddi="191" OR ddi="193" OR ddi="194" OR ddi="196" OR ddi="197"
  GROUP BY ddi
  ORDER BY ddi;
}

{ TODO -c������� ���������� : ������� ��������� ������� ��� ������� �� ������ ������������ }
{ TODO -c�������������� ����� : ����������� � ��������� ��������� � �������� ���� ��� �� ����� ������ ������� }
{ TODO -c������� ���������� : ��������, ����� ������� ����������� "������" ����������� ������������� �������? }
{ TODO -c�������������� ����� : �������� �������� ������� � ������ ����������� �� ������� }
{ TODO -c������� ���������� : ������������ ����������������� ����� ������ ������� � ����������� �� �� ���������� }

{ TODO -c�������������� ����� : ��������� �������� ������� �� ������ �� ������ � ���� ��� ����������� � ������ ������ ���� About - ���� �� ������ ���������! }

{ TODO -c������� ���������� : �������� ������ ������������ � �������� ������������ ������� �� �������� ����� aSilentYes, �.�. � ������ ������������ �� ���� ������� ����������� }

{ TODO -c������� ���������� : �� ����������� ��������� ��������� Do_PayOff � ����������� �����? �� �� ������ ��� ��� ����� ��������� }

end.
