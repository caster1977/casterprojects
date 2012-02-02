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
  CastersPackage.getFVI,
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
  CastersPackage.uListViewEx;

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
    dtpChoisenPeriod_Start: TDateTimePicker;
    rbChoisenPeriod: TRadioButton;
    dtpChoisenPeriod_Stop: TDateTimePicker;
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
    ts_SIC_06: TTabSheet;
    gb_SIC_06: TGroupBox;
    lbService_SIC_06: TLabel;
    cbService_SIC_06: TComboBox;
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
    function Do_SIC_06(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aServiceIndex: integer): boolean;
    function Do_SIC_07(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aCalculateWeekFromMonday: boolean): boolean;
    function Do_SIC_08(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean): boolean;
    function Do_SIC_09(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aNetIndex: integer; const aSummaryReport, aOldReport: boolean; const aSelectedServicesList: TStringList): boolean;
    function Do_SIC_10(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aGroupByPeriod: TGroupByPeriod; const aCalculateWeekFromMonday, aAllUsers, aCreateDetailedReport: boolean; const aCCID: integer;
      const aSelectedUserList: TStringList): boolean;
    function Do_ASKR(const aStartDate, aStopDate: TDate): boolean;
    function Do_PayOff(const aPayoffList: TStringList): boolean;
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure LogThis(const aMessage, aLogGroupGIUD: string; aMessageType: TLogMessagesType);
    procedure ProcedureHeader(const aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(const aLogGroupGUID: string);
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
  Thread_Do_SIC_06,
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
      m:=AnsiString(Application.ExeName+#09+CurrentUser.sLogin+#09+ // текущий залогированный пользователь
        s+#09+ // тип сообщения
        StringReplace(FormatDateTime('dd.mm.yyyy hh:nn:ss', Now), ' ', #09, [rfReplaceAll])+#09+
        // дата и время сообщения
        aLogGroupGIUD+#09+StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])+#09+
        // порядковый номер сообщения
        aMessage); // текст сообщения
      // проверка наличия LogKeeper и его запуск в случае отсутствия
      if IsWindow(hLogKeeper) then
        begin // если LogKeeper запущен
          with aCopyData do
            begin
              dwData:=0;
              cbData:=Length(m)+1;
              lpData:=PAnsiChar(m);
            end;
          SendMessage(hLogKeeper, WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
          // LogThis('Произведена отправка программе лог-клиента строки данных: ['+m+']', LogGroupGUID, lmtDebug);
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
          ListItem.ImageIndex:=i; // тип сообщения
          ListItem.Caption:=FormatDateTime('dd.mm.yyyy hh:nn:ss', Now); // дата и время сообщения
          ListItem.SubItems.Add(aLogGroupGIUD);
          ListItem.SubItems.Add(StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])); // порядковый номер сообщения
          ListItem.SubItems.Add(CurrentUser.sLogin); // текущий залогированный пользователь
          ListItem.SubItems.Add(aMessage); // текст сообщения
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
  ProcedureHeader('Процедура установки состояния доступности для действий локального меню списка сообщений протокола', LogGroupGUID);

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
  ProcedureHeader('Процедура открытия справочного файла программы', LogGroupGUID);

  LogThis('Производится попытка открытия справочного файла программы...', LogGroupGUID, lmtInfo);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    Routines_GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_MinimizeMainForm;
const
  LogGroupGUID: string='{14072DE1-178E-48D8-9A01-4899004A5DB5}';
begin
  ProcedureHeader('Процедура сворачивания главного окна в трей', LogGroupGUID);

  Visible:=False;
  TrayIcon1.Visible:=True;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_MaximizeLogPanel;
const
  LogGroupGUID: string='{90EED816-7CA7-4806-BED7-D4E82D6CBB9A}';
begin
  ProcedureHeader('Процедура разворачивания панели протокола во всё окно', LogGroupGUID);

  pnlLog.Align:=alClient;
  Action_MaximizeLogPanel.Enabled:=False;
  Action_RestoreLogPanel.Enabled:=True;
  btnMaximazeLogPanel.Enabled:=False;
  btnRestoreLogPanel.Enabled:=True;
  Update_pnlConnectedMode;
  LogThis('Панель протокола работы программы была развёрнута на всё окно.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TrayIcon1Click(Sender: TObject);
const
  LogGroupGUID: string='{AF1A3B63-DB71-4648-B6B2-BCB8E1DAAD19}';
begin
  ProcedureHeader('Процедура-обработчик щелчка на иконке в трее', LogGroupGUID);

  if Visible then
    SetForegroundWindow(Handle);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_MaximizeLogPanelExecute(Sender: TObject);
const
  LogGroupGUID: string='{9C0E64E8-E627-4AFF-9EB7-2AB33C9985B9}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_MaximizeLogPanel.Caption+'"', LogGroupGUID);
  Do_MaximizeLogPanel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_OpenReportsFolderExecute(Sender: TObject);
const
  LogGroupGUID: string='{FD57F9EB-94B0-4B15-BC65-A905798B4A5B}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_OpenReportsFolder.Caption+'"', LogGroupGUID);
  Do_OpenReportsFolder;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ApplicationEvents1Minimize(Sender: TObject);
const
  LogGroupGUID: string='{168855D1-C5B0-4123-8276-2EFBE47C06C3}';
begin
  ProcedureHeader('Процедура реакции на попытку минимизации главного окна', LogGroupGUID);
  Do_MinimizeMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TrayIcon1DblClick(Sender: TObject);
const
  LogGroupGUID: string='{359069CB-50CA-4171-9714-38B0895924E0}';
begin
  ProcedureHeader('Процедура-обработчик двойноного щелчка на иконке в трее', LogGroupGUID);
  Do_RestoreMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_CopyGUIDStringToClipboardExecute(Sender: TObject);
const
  LogGroupGUID: string='{E9293B16-9E48-4589-A67B-3D578DF548A0}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_CopyGUIDStringToClipboard.Caption+'"', LogGroupGUID);
  Do_CopyGUIDStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyGUIDStringToClipboard;
const
  LogGroupGUID: string='{61BF14C3-7B19-4042-9EB5-E051D5AB72B9}';
begin
  ProcedureHeader('Процедура копирования GUID выделенного элемента списка протокола в буфер обмена', LogGroupGUID);

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
  ProcedureHeader('Процедура-обработчик действия "'+Action_CopyLogStringToClipboard.Caption+'"', LogGroupGUID);
  Do_CopyLogStringToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopyLogStringToClipboard;
const
  LogGroupGUID: string='{FF84CE4B-78C0-4DD3-B1D2-76931F50A843}';
var
  s: string;
begin
  ProcedureHeader('Процедура копирования текста выделенного элемента списка протокола в буфер обмена', LogGroupGUID);

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
  ProcedureHeader('Процедура-обработчик действия "'+Action_CopySQLFromLogToClipboard.Caption+'"', LogGroupGUID);
  Do_CopySQLFromLogToClipboard;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_CopySQLFromLogToClipboard;
const
  LogGroupGUID: string='{C7EC6643-0CE4-4E3C-90D6-928C07605DAE}';
begin
  ProcedureHeader('Процедура копирования текста SQL-запроса выделенного элемента списка сообщений протокола в буфер обмена', LogGroupGUID);

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
  ProcedureHeader('Процедура-обработчик действия "'+Action_About.Caption+'"', LogGroupGUID);
  Do_About;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{B40DE54E-580C-4F96-BE2A-1447856505B0}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
const
  LogGroupGUID: string='{73855780-FE07-4058-983D-912D3CCF00A7}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Quit.Caption+'"', LogGroupGUID);
  Close;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RestoreExecute(Sender: TObject);
const
  LogGroupGUID: string='{4FFF4893-DFF8-406C-B66B-9CE1430B7B06}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Restore.Caption+'"', LogGroupGUID);
  Do_RestoreMainForm;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ProcessSelectedActionsExecute(Sender: TObject);
const
  LogGroupGUID: string='{E3CD2FE0-99EB-4234-862F-4F15B3828609}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ProcessSelectedActions.Caption+'"', LogGroupGUID);
  Do_ProcessSelectedActions;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindNextWithSuchGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string='{79024270-342A-401B-8066-15C28D938D4D}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_FindNextWithSuchGUID.Caption+'"', LogGroupGUID);
  Do_FindNextWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindPreviousWithSuchGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string='{544909F1-2987-4A25-9D7B-5A196C170D04}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_FindPreviousWithSuchGUID.Caption+'"', LogGroupGUID);
  Do_FindPreviousWithSuchGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_FindSpecifiedGUIDExecute(Sender: TObject);
const
  LogGroupGUID: string='{473D6C20-DBD4-40CC-9664-7DBF0521194F}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_FindSpecifiedGUID.Caption+'"', LogGroupGUID);
  Do_FindSpecifiedGUID;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_FindSpecifiedGUID;
const
  LogGroupGUID: string='{CC35A134-5080-493D-BBFD-252EAC167F37}';
  sModalWinName: string='поиска GUID';
var
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);

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
  // критичная по количеству выполнений процедура - в целях незасорения лога заголовок отключён
  // ProcedureHeader('Процедура отображения строки контекстной подсказки в панели статуса',LogGroupGUID);
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
  // ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.miStatusbarClick(Sender: TObject);
const
  LogGroupGUID: string='{54B6714E-1890-420E-9EE6-540DC623EF92}';
begin
  ProcedureHeader('Процедура включения/отключения отображения панели статуса', LogGroupGUID);

  StatusBar1.Visible:=miStatusbar.Checked;
  Configuration.bNoStatusBar:=not StatusBar1.Visible;
  LogThis('Панель статуса '+Routines_GetConditionalMessage(StatusBar1.Visible, 'в', 'от')+'ключена.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbActionsListChange(Sender: TObject);
const
  LogGroupGUID: string='{C25BFA97-7031-4CE8-B9B2-986181BD3292}';
begin
  ProcedureHeader('Процедура-обработчик выбора элемента выпадающего списка действий', LogGroupGUID);
  Do_SelectAction;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbCreateXRDAClick(Sender: TObject);
const
  LogGroupGUID: string='{97DB87A6-D071-468A-B071-887C1AFAF9F9}';
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "'+cbCreateXRDA.Caption+'"', LogGroupGUID);

  cbCustomNameOfXRDA.Enabled:=cbCreateXRDA.Checked or cbRecreateXRDA.Checked;
  if not(cbReCreateXRDA.Checked or cbCreateXRDA.Checked) then
    cbCustomNameOfXRDA.Checked:=False;
  LogThis('Флажок "'+cbCreateXRDA.Caption+'" '+Routines_GetConditionalMessage(cbCreateXRDA.Checked, 'включён', 'отключён')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbCustomNameOfXRDAClick(Sender: TObject);
const
  LogGroupGUID: string='{520E19D9-05A0-4423-9298-81313CFD42C8}';
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "'+cbCustomNameOfXRDA.Caption+'"', LogGroupGUID);

  ebCustomNameOfXRDA.Enabled:=cbCustomNameOfXRDA.Checked;
  if not cbCustomNameOfXRDA.Checked then
    ebCustomNameOfXRDA.Clear;
  LogThis('Флажок "'+cbCustomNameOfXRDA.Caption+'" '+Routines_GetConditionalMessage(cbCustomNameOfXRDA.Checked, 'включён', 'отключён')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbRecreateXRDAClick(Sender: TObject);
const
  LogGroupGUID: string='{35FDB9E5-CE9D-4AEC-9A3A-3A36B6CAA6E9}';
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "'+cbRecreateXRDA.Caption+'"', LogGroupGUID);

  cbCustomNameOfXRDA.Enabled:=cbCreateXRDA.Checked or cbRecreateXRDA.Checked;
  if not(cbReCreateXRDA.Checked or cbCreateXRDA.Checked) then
    cbCustomNameOfXRDA.Checked:=False;
  LogThis('Флажок "'+cbRecreateXRDA.Caption+'" '+Routines_GetConditionalMessage(cbRecreateXRDA.Checked, 'включён', 'отключён')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RestoreLogPanelExecute(Sender: TObject);
const
  LogGroupGUID: string='{DB45C462-B894-4F9D-BC37-99BA807BE93F}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_RestoreLogPanel.Caption+'"', LogGroupGUID);
  Do_RestoreLogPanel;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_RestoreLogPanel;
const
  LogGroupGUID: string='{45DF4FFD-F0F5-4C0F-BE52-A478E53A219A}';
begin
  ProcedureHeader('Процедура восстановления исходных размеров панели протокола', LogGroupGUID);

  pnlLog.Align:=alBottom;
  pnlLog.Height:=152;
  Action_RestoreLogPanel.Enabled:=False;
  Action_MaximizeLogPanel.Enabled:=True;
  btnRestoreLogPanel.Enabled:=False;
  btnMaximazeLogPanel.Enabled:=True;
  Update_pnlConnectedMode;
  LogThis('Были возвращены нормальные размеры панели протокола работы программы.', LogGroupGUID, lmtInfo);

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
          ProgressBarRect.Left:=ProgressBarRect.Left+lvActionList.Columns[0].Width+1;
          ProgressBarRect.Right:=ProgressBarRect.Left+lvActionList.Columns[1].Width-1;
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
  ProcedureHeader('Процедура-обработчик нажатия клавиши в списке протокола', LogGroupGUID);
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
  // ProcedureHeader('Процедура перехода к следующей строке протокола с таким же GUID',LogGroupGUID,False,False);
  b:=False;
  j:=-1;
  if (lvLog.Items.Count>0)and(lvLog.Selected<>nil) then
    begin
      if lvLog.Selected.SubItems.Count>=1 then
        begin
          s:=lvLog.Selected.SubItems[0]; // получение GUID выделенного элемента списка
          // LogThis(PWideChar('Искомая строка GUID: '+s+'.'), LogGroupGUID, lmtDebug);
          with lvLog do // переход к следующей строке списка протокола с равным GUID
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
                  iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
                  iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
                  Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора

                  MessageBox(Handle, PWideChar('Строк с GUID '+s+' ниже указанной в списке протокола более не найдено!'), PWideChar('LogKeeper - Внимание!'), MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                  Application.ProcessMessages;

                  iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
                  Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора
                  Application.ProcessMessages;
                end;
            end;
        end;
      // else LogThis(PWideChar('Переход не выполнен, так как не была найдена строка GUID ниже по списку!'),LogGroupGUID,lmtError);
    end;
  // else LogThis(PWideChar('Переход не выполнялся, так как не бало выделено ни одной строки списка!'),LogGroupGUID,lmtWarning);
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
  // ProcedureHeader('Процедура перехода к предыдущей строке протокола с таким же GUID',LogGroupGUID,False,False);
  b:=False;
  j:=-1;
  if (lvLog.Items.Count>0)and(lvLog.Selected<>nil) then
    begin
      if lvLog.Selected.SubItems.Count>=1 then
        begin
          s:=lvLog.Selected.SubItems[0]; // получение GUID выделенного элемента списка
          // LogThis(PWideChar('Искомая строка GUID: '+s+'.'), LogGroupGUID, lmtDebug);
          with lvLog do // переход к предыдущей строке списка протокола с равным GUID
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
                  iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
                  iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
                  Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора

                  MessageBox(Handle, PWideChar('Строк с GUID '+s+' выше указанной в списке протокола более не найдено!'), PWideChar('LogKeeper - Внимание!'), MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
                  Application.ProcessMessages;

                  iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
                  Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора
                  Application.ProcessMessages;
                end;
            end;
        end;
      // else LogThis(PWideChar('Переход не выполнен, так как не была найдена строка GUID выше по списку!'),LogGroupGUID,lmtError);
    end;
  // else LogThis(PWideChar('Переход не выполнялся, так как не бало выделено ни одной строки списка!'),LogGroupGUID,lmtWarning);
  // ProcedureFooter(LogGroupGUID,False,False);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  LogGroupGUID: string;
  iOldBusyCounter: integer;
begin
  LogGroupGUID:='{98820E3D-0168-459B-8902-19391BEFBDDE}';
  ProcedureHeader('Процедура завершения работы приложения', LogGroupGUID);

  CanClose:=False;

  iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
  Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора

  if Configuration.bShowQuitConfirmation then
    CanClose:=MessageBox(Handle, PWideChar('Вы действительно хотите завершить работу программы?'), PWideChar('OVERSEER - Подтверждение выхода'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK
  else
    CanClose:=True;
  Application.ProcessMessages;

  iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
  Refresh_BusyState(LogGroupGUID); // обновление состояния индикатора
  Application.ProcessMessages;

  if CanClose then
    begin
      LogThis('Завершение работы приложения было подтверждено.', LogGroupGUID, lmtInfo);
      Do_Logout;
      Save_ConfigIni;
      // попытка записи себя в авторан реестра
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
    LogThis('Завершение работы приложения было отменено пользователем.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Load_ConfigIni;
const
  LogGroupGUID: string='{CABB30D6-CFDE-4356-AF41-C874A49E46F5}';
var
  s: string;
begin
  ProcedureHeader('Процедура загрузки конфигурации программы из файла INI', LogGroupGUID);

  with TIniFile.Create(ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')) do
    try
      // секция "Интерфейс"
      Configuration.bAlwaysShowTrayIcon:=ReadBool('Интерфейс', 'bAlwaysShowTrayIcon', False);
      Configuration.bShowQuitConfirmation:=ReadBool('Интерфейс', 'bShowQuitConfirmation', True);
      Configuration.bStoreLastLogin:=ReadBool('Интерфейс', 'bStoreLastLogin', False);
      Configuration.sLastLogin:=Routines_GetConditionalMessage(Configuration.bStoreLastLogin, ReadString('Интерфейс', 'sLastLogin', ''), '');
      Configuration.bStoreLastPassword:=ReadBool('Интерфейс', 'bStoreLastPassword', False);
      Configuration.sLastPassword:=Routines_GetConditionalMessage(Configuration.bStoreLastPassword, ReadString('Интерфейс', 'sLastPassword', ''), '');
      Configuration.bAutoLogon:=ReadBool('Интерфейс', 'bAutoLogon', False);
      Configuration.bUseExternalLog:=ReadBool('Интерфейс', 'bUseExternalLog', False);
      Configuration.sDefaultAction:=ReadString('Интерфейс', 'sDefaultAction', '');
      Configuration.bNoStatusBar:=ReadBool('Интерфейс', 'bNoStatusBar', False);
      Configuration.bScrollToLastLogMessage:=ReadBool('Интерфейс', 'bScrollToLastLogMessage', True);
      Configuration.bAutorun:=ReadBool('Интерфейс', 'bAutorun', False);
      Configuration.bStartInTray:=ReadBool('Интерфейс', 'bStartInTray', False);
      Configuration.bPlaySoundAfterAction:=ReadBool('Интерфейс', 'bPlaySoundAfterAction', True);
      Configuration.bShowBaloonHintAfterAction:=ReadBool('Интерфейс', 'bShowBaloonHintAfterAction', True);

      // секция "Сервер и база данных"
      Configuration.OverseerServer.sMySQLHost:=ReadString('Сервер и база данных', 'OverseerServer.sMySQLHost', 'OVERSEERSERVER'); // overseerserver
      Configuration.OverseerServer.iMySQLPort:=ReadInteger('Сервер и база данных', 'OverseerServer.iMySQLPort', MYSQL_PORT);
      Configuration.OverseerServer.iMySQLTimeout:=ReadInteger('Сервер и база данных', 'OverseerServer.iMySQLTimeout', 30);
      Configuration.OverseerServer.bMySQLCompress:=ReadBool('Сервер и база данных', 'OverseerServer.bMySQLCompress', True);
      Configuration.OverseerServer.sMySQLDatabase:=ReadString('Сервер и база данных', 'OverseerServer.sMySQLDatabase', 'overseer');

      // dbserver
      Configuration.DBServer.sMySQLHost:=ReadString('Сервер и база данных', 'DBServer.sMySQLHost', 'DBSERVER');
      Configuration.DBServer.iMySQLPort:=ReadInteger('Сервер и база данных', 'DBServer.iMySQLPort', MYSQL_PORT);
      Configuration.DBServer.iMySQLTimeout:=ReadInteger('Сервер и база данных', 'DBServer.iMySQLTimeout', 30);
      Configuration.DBServer.bMySQLCompress:=ReadBool('Сервер и база данных', 'DBServer.bMySQLCompress', True);
      Configuration.DBServer.sMySQLDatabase_IRD_Location:=ReadString('Сервер и база данных', 'DBServer.sMySQLDatabase_IRD_Location', 'statistika');
      Configuration.DBServer.sMySQLDatabase_ORD_Location:=ReadString('Сервер и база данных', 'DBServer.sMySQLDatabase_ORD_Location', 'statistika');
      Configuration.DBServer.sMySQLDatabase_PRIJAVE_Location:=ReadString('Сервер и база данных', 'DBServer.sMySQLDatabase_PRIJAVE_Location', 'test');
      Configuration.DBServer.sMySQLDatabase_PRIJAVE_Q_Location:=ReadString('Сервер и база данных', 'DBServer.sMySQLDatabase_PRIJAVE_Q_Location', 'test');
      Configuration.DBServer.sMySQLDatabase_T_DAY_Location:=ReadString('Сервер и база данных', 'DBServer.sMySQLDatabase_T_DAY_Location', 'MyStat');

      // statserver
      Configuration.StatServer.sMySQLHost:=ReadString('Сервер и база данных', 'StatServer.sMySQLHost', 'STATSERVER');
      Configuration.StatServer.iMySQLPort:=ReadInteger('Сервер и база данных', 'StatServer.iMySQLPort', MYSQL_PORT);
      Configuration.StatServer.iMySQLTimeout:=ReadInteger('Сервер и база данных', 'StatServer.iMySQLTimeout', 30);
      Configuration.StatServer.bMySQLCompress:=ReadBool('Сервер и база данных', 'StatServer.bMySQLCompress', True);
      Configuration.StatServer.sMySQLDatabase_IRD_Location:=ReadString('Сервер и база данных', 'StatServer.sMySQLDatabase_IRD_Location', 'ird');
      Configuration.StatServer.sMySQLDatabase_ORD_Location:=ReadString('Сервер и база данных', 'StatServer.sMySQLDatabase_ORD_Location', 'ord');
      Configuration.StatServer.sMySQLDatabase_IRDA_Location:=ReadString('Сервер и база данных', 'StatServer.sMySQLDatabase_IRDA_Location', 'irda');
      Configuration.StatServer.sMySQLDatabase_ORDA_Location:=ReadString('Сервер и база данных', 'StatServer.sMySQLDatabase_ORDA_Location', 'orda');
      Configuration.StatServer.sMySQLDatabase_PRIJAVE_Location:=ReadString('Сервер и база данных', 'StatServer.sMySQLDatabase_PRIJAVE_Location', 'prijaves');
      Configuration.StatServer.sMySQLDatabase_PRIJAVE_Q_Location:=ReadString('Сервер и база данных', 'StatServer.sMySQLDatabase_PRIJAVE_Q_Location', 'prijaves');

      // rne4server
      Configuration.RNE4Server.sMySQLHost:=ReadString('Сервер и база данных', 'RNE4Server.sMySQLHost', 'RNE4SERVER');
      Configuration.RNE4Server.iMySQLPort:=ReadInteger('Сервер и база данных', 'RNE4Server.iMySQLPort', MYSQL_PORT);
      Configuration.RNE4Server.iMySQLTimeout:=ReadInteger('Сервер и база данных', 'RNE4Server.iMySQLTimeout', 30);
      Configuration.RNE4Server.bMySQLCompress:=ReadBool('Сервер и база данных', 'RNE4Server.bMySQLCompress', True);
      Configuration.RNE4Server.sMySQLDatabase:=ReadString('Сервер и база данных', 'RNE4Server.sMySQLDatabase', 'rne4');

      // секция "Протоколирование"
      Configuration.bKeepErrorLog:=ReadBool('Протоколирование', 'bKeepErrorLog', True);
      Configuration.bKeepWarningLog:=ReadBool('Протоколирование', 'bKeepWarningLog', True);
      Configuration.bKeepInfoLog:=ReadBool('Протоколирование', 'bKeepInfoLog', True);
      Configuration.bKeepSQLLog:=ReadBool('Протоколирование', 'bKeepSQLLog', False);
      Configuration.bKeepDebugLog:=ReadBool('Протоколирование', 'bKeepDebugLog', False);
      Configuration.bFlushLogOnExit:=ReadBool('Протоколирование', 'bFlushLogOnExit', True);
      Configuration.iFlushLogOnStringsQuantity:=ReadInteger('Протоколирование', 'iFlushLogOnStringsQuantity', -1);
      Configuration.bFlushLogOnClearingLog:=ReadBool('Протоколирование', 'bFlushLogOnClearingLog', True);

      // секция "Отчёты"
      s:=ReadString('Отчёты', 'sReportFolder', '');
      if s='ApplicationFolder' then
        Configuration.trfReportFolder:=rfApplicationFolder
      else
        if s='CustomFolder' then
          Configuration.trfReportFolder:=rfCustomFolder
        else
          Configuration.trfReportFolder:=rfTempFolder;
      Configuration.sCustomFolder:=ReadString('Отчёты', 'sCustomFolder', '');

      Configuration.bDontDemandOverwriteConfirmation:=ReadBool('Отчёты', 'bDontDemandOverwriteConfirmation', False);
      Configuration.bAskForFileName:=ReadBool('Отчёты', 'bAskForFileName', False);

      LogThis('Конфигурация считана успешно.', LogGroupGUID, lmtInfo);

      // применение полученных настроек к программе
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
      Height:=600-152*integer(Configuration.bUseExternalLog);
      Timer1.Enabled:=Configuration.bUseExternalLog;

      if bFirstRun then
        begin
          Application.ShowMainForm:=not Configuration.bStartInTray;
          Visible:=not Configuration.bStartInTray;
        end;

      TrayIcon1.Visible:=(not Visible)or Configuration.bAlwaysShowTrayIcon;
    finally
      Free;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Save_ConfigIni;
const
  LogGroupGUID: string='{B282D7BB-0359-45AD-877C-F24CDB5F44E7}';
begin
  ProcedureHeader('Процедура сохранения конфигурации программы в файл INI', LogGroupGUID);

  with TIniFile.Create(ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')) do
    try
      try
        // секция "Интерфейс"
        WriteBool('Интерфейс', 'bAlwaysShowTrayIcon', Configuration.bAlwaysShowTrayIcon);
        WriteBool('Интерфейс', 'bShowQuitConfirmation', Configuration.bShowQuitConfirmation);
        WriteBool('Интерфейс', 'bStoreLastLogin', Configuration.bStoreLastLogin);
        if Configuration.bStoreLastLogin then
          WriteString('Интерфейс', 'sLastLogin', Configuration.sLastLogin)
        else
          DeleteKey('Интерфейс', 'sLastLogin');
        WriteBool('Интерфейс', 'bStoreLastPassword', Configuration.bStoreLastPassword);
        if Configuration.bStoreLastPassword then
          WriteString('Интерфейс', 'sLastPassword', Configuration.sLastPassword)
        else
          DeleteKey('Интерфейс', 'sLastPassword');
        if Configuration.bAutoLogon then
          WriteBool('Интерфейс', 'bAutoLogon', Configuration.bAutoLogon)
        else
          DeleteKey('Интерфейс', 'bAutoLogon');
        WriteBool('Интерфейс', 'bUseExternalLog', Configuration.bUseExternalLog);
        WriteString('Интерфейс', 'sDefaultAction', Configuration.sDefaultAction);
        WriteBool('Интерфейс', 'bNoStatusBar', Configuration.bNoStatusBar);
        WriteBool('Интерфейс', 'bScrollToLastLogMessage', Configuration.bScrollToLastLogMessage);
        WriteBool('Интерфейс', 'bAutorun', Configuration.bAutorun);
        WriteBool('Интерфейс', 'bStartInTray', Configuration.bStartInTray);
        WriteBool('Интерфейс', 'bPlaySoundAfterAction', Configuration.bPlaySoundAfterAction);
        WriteBool('Интерфейс', 'bShowBaloonHintAfterAction', Configuration.bShowBaloonHintAfterAction);

        // секция "Сервер и база данных"
        WriteString('Сервер и база данных', 'OverseerServer.sMySQLHost', Configuration.OverseerServer.sMySQLHost);
        // overseerserver
        WriteString('Сервер и база данных', 'OverseerServer.sMySQLHost', Configuration.OverseerServer.sMySQLHost);
        WriteInteger('Сервер и база данных', 'OverseerServer.iMySQLPort', Configuration.OverseerServer.iMySQLPort);
        WriteInteger('Сервер и база данных', 'OverseerServer.iMySQLTimeout', Configuration.OverseerServer.iMySQLTimeout);
        WriteBool('Сервер и база данных', 'OverseerServer.bMySQLCompress', Configuration.OverseerServer.bMySQLCompress);
        WriteString('Сервер и база данных', 'OverseerServer.sMySQLDatabase', Configuration.OverseerServer.sMySQLDatabase);

        WriteString('Сервер и база данных', 'DBServer.sMySQLHost', Configuration.DBServer.sMySQLHost); // dbserver
        WriteString('Сервер и база данных', 'DBServer.sMySQLHost', Configuration.DBServer.sMySQLHost);
        WriteInteger('Сервер и база данных', 'DBServer.iMySQLPort', Configuration.DBServer.iMySQLPort);
        WriteInteger('Сервер и база данных', 'DBServer.iMySQLTimeout', Configuration.DBServer.iMySQLTimeout);
        WriteBool('Сервер и база данных', 'DBServer.bMySQLCompress', Configuration.DBServer.bMySQLCompress);
        WriteString('Сервер и база данных', 'DBServer.sMySQLDatabase_IRD_Location', Configuration.DBServer.sMySQLDatabase_IRD_Location);
        WriteString('Сервер и база данных', 'DBServer.sMySQLDatabase_ORD_Location', Configuration.DBServer.sMySQLDatabase_ORD_Location);
        WriteString('Сервер и база данных', 'DBServer.sMySQLDatabase_PRIJAVE_Location', Configuration.DBServer.sMySQLDatabase_PRIJAVE_Location);
        WriteString('Сервер и база данных', 'DBServer.sMySQLDatabase_PRIJAVE_Q_Location', Configuration.DBServer.sMySQLDatabase_PRIJAVE_Q_Location);
        WriteString('Сервер и база данных', 'DBServer.sMySQLDatabase_T_DAY_Location', Configuration.DBServer.sMySQLDatabase_T_DAY_Location);

        WriteString('Сервер и база данных', 'StatServer.sMySQLHost', Configuration.StatServer.sMySQLHost); // statserver
        WriteString('Сервер и база данных', 'StatServer.sMySQLHost', Configuration.StatServer.sMySQLHost);
        WriteInteger('Сервер и база данных', 'StatServer.iMySQLPort', Configuration.StatServer.iMySQLPort);
        WriteInteger('Сервер и база данных', 'StatServer.iMySQLTimeout', Configuration.StatServer.iMySQLTimeout);
        WriteBool('Сервер и база данных', 'StatServer.bMySQLCompress', Configuration.StatServer.bMySQLCompress);
        WriteString('Сервер и база данных', 'StatServer.sMySQLDatabase_IRD_Location', Configuration.StatServer.sMySQLDatabase_IRD_Location);
        WriteString('Сервер и база данных', 'StatServer.sMySQLDatabase_ORD_Location', Configuration.StatServer.sMySQLDatabase_ORD_Location);
        WriteString('Сервер и база данных', 'StatServer.sMySQLDatabase_IRDA_Location', Configuration.StatServer.sMySQLDatabase_IRDA_Location);
        WriteString('Сервер и база данных', 'StatServer.sMySQLDatabase_ORDA_Location', Configuration.StatServer.sMySQLDatabase_ORDA_Location);
        WriteString('Сервер и база данных', 'StatServer.sMySQLDatabase_PRIJAVE_Location', Configuration.StatServer.sMySQLDatabase_PRIJAVE_Location);
        WriteString('Сервер и база данных', 'StatServer.sMySQLDatabase_PRIJAVE_Q_Location', Configuration.StatServer.sMySQLDatabase_PRIJAVE_Q_Location);

        WriteString('Сервер и база данных', 'RNE4Server.sMySQLHost', Configuration.RNE4Server.sMySQLHost);
        WriteInteger('Сервер и база данных', 'RNE4Server.iMySQLPort', Configuration.RNE4Server.iMySQLPort);
        WriteInteger('Сервер и база данных', 'RNE4Server.iMySQLTimeout', Configuration.RNE4Server.iMySQLTimeout);
        WriteBool('Сервер и база данных', 'RNE4Server.bMySQLCompress', Configuration.RNE4Server.bMySQLCompress);
        WriteString('Сервер и база данных', 'RNE4Server.sMySQLDatabase', Configuration.RNE4Server.sMySQLDatabase);

        // секция "Протоколирование"
        WriteBool('Протоколирование', 'bKeepErrorLog', Configuration.bKeepErrorLog);
        WriteBool('Протоколирование', 'bKeepWarningLog', Configuration.bKeepWarningLog);
        WriteBool('Протоколирование', 'bKeepInfoLog', Configuration.bKeepInfoLog);
        WriteBool('Протоколирование', 'bKeepSQLLog', Configuration.bKeepSQLLog);
        WriteBool('Протоколирование', 'bKeepDebugLog', Configuration.bKeepDebugLog);
        WriteBool('Протоколирование', 'bFlushLogOnExit', Configuration.bFlushLogOnExit);
        WriteInteger('Протоколирование', 'iFlushLogOnStringsQuantity', Configuration.iFlushLogOnStringsQuantity);
        WriteBool('Протоколирование', 'bFlushLogOnClearingLog', Configuration.bFlushLogOnClearingLog);
        // секция "Отчёты"
        case Configuration.trfReportFolder of
          rfApplicationFolder:
            WriteString('Отчёты', 'sReportFolder', 'ApplicationFolder');
          rfCustomFolder:
            WriteString('Отчёты', 'sReportFolder', 'CustomFolder');
        else
          WriteString('Отчёты', 'sReportFolder', 'TempFolder');
        end;
        WriteString('Отчёты', 'sCustomFolder', Configuration.sCustomFolder);
        WriteBool('Отчёты', 'bDontDemandOverwriteConfirmation', Configuration.bDontDemandOverwriteConfirmation);
        WriteBool('Отчёты', 'bAskForFileName', Configuration.bAskForFileName);

        LogThis('Конфигурация сохранена успешно.', LogGroupGUID, lmtInfo);
      except
        on EIniFileException do
          ShowErrorBox(Handle, 'Возникла ошибка при потытке сохранения конфигурации в INI-файле! Обратитесь к администратору!', LogGroupGUID);
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
  rbLastDate.Caption:='&1) прошедший день '+FormatDateTime('(dd.mm.yyyy)', dtLastDate);
  rbLastWeek.Caption:='&3) прошедшая неделя ('+FormatDateTime('dd.mm.yyyy', dtLastWeekStart)+' - '+FormatDateTime('dd.mm.yyyy', dtLastWeekStop)+')';
  rbLastMonth.Caption:='&4) прошедший месяц ('+cbChoisenMonth_Month.Items[wLastMonth_Month-1]+' '+IntToStr(wLastMonth_Year)+' года)';
  rbLastQuarter.Caption:='&6) прошедший квартал ('+cbChoisenQuarter_Quarter.Items[wLastQuarter_Quarter-1]+' квартал '+IntToStr(wLastQuarter_Year)+' года)';
  rbLastYear.Caption:='&8) прошедший год ('+IntToStr(wLastYear)+' год)';
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
  ProcedureHeader('Процедура получения пути рабочей папки программы', LogGroupGUID);
  bError:=False;
  Do_GetApplicationFolder:='';

  s:=ExtractFilePath(ExpandFileName(Application.ExeName));
  if DirectoryExists(s) then
    begin
      Do_GetApplicationFolder:=s;
      LogThis('Путь рабочей папки программы успешно получен - <'+s+'>.', LogGroupGUID, lmtDebug);
    end
  else
    Routines_GenerateError('Возникла ошибка при попытке получения пути рабочей папки программы!', sErrorMessage, bError);

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
  ProcedureHeader('Процедура получения пути временной папки', LogGroupGUID);
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
            LogThis('Путь временной папки успешно получен - <'+TempPathNameBuffer+'>.', LogGroupGUID, lmtDebug);
          end
        else
          Routines_GenerateError('Возникла ошибка при попытке получения пути временной папки!', sErrorMessage, bError);
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
  sDirectory: string;
begin
  ProcedureHeader('Процедура открытия папки сохранённых отчётов', LogGroupGUID);
  bError:=False;

  LogThis('Производится попытка открытия папки сохранённых отчётов...', LogGroupGUID, lmtInfo);
  case Configuration.trfReportFolder of
    rfTempFolder:
      sDirectory:=Configuration.sTempFolder;
    rfApplicationFolder:
      sDirectory:=Configuration.sApplicationFolder;
    rfCustomFolder:
      sDirectory:=Configuration.sCustomFolder;
  else
    Routines_GenerateError('Возникла ошибка при определении пути папки сохранённых отчётов!', sErrorMessage, bError);
  end;

  if DirectoryExists(sDirectory) then
    ShellExecute(Application.Handle, 'open', PWideChar(sDirectory), nil, nil, SW_MAXIMIZE)
  else
    Routines_GenerateError('Папка сохранённых отчётов не существует! Проверьте правильность указанного пути ['+sDirectory+']!', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_AccountsExecute(Sender: TObject);
const
  LogGroupGUID: string='{124A5150-AFB3-440A-A442-B76EBAC96839}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Accounts.Caption+'"', LogGroupGUID);
  Do_OpenAccountsList;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ClearLogListExecute(Sender: TObject);
const
  LogGroupGUID: string='{A694CF78-8CE3-4F7E-B4E8-262F45815BDA}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ClearLogList.Caption+'"', LogGroupGUID);
  Do_ClearLogList;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_ClearLogList;
const
  LogGroupGUID: string='{89903EE5-7982-453C-8CCE-570E44579B9E}';
var
  iCount: integer;
begin
  ProcedureHeader('Процедура очистки списка сообщений протокола', LogGroupGUID);

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
          LogThis('Выполнена очистка протокола работы программы. Количество удалённых строк: '+IntToStr(iCount)+'.', LogGroupGUID, lmtInfo);
        end
      else
        LogThis('Протокол работы программы пуст, очистка не требуется.', LogGroupGUID, lmtInfo);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
const
  LogGroupGUID: string='{7D3330ED-5483-4194-BC52-3E90851FD868}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Configuration.Caption+'"', LogGroupGUID);
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
  ProcedureHeader('Процедура выгрузки всех текущих строк протокола работы программы в текстовый файл', LogGroupGUID);

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
          ShowErrorBox(Handle, 'Возникла ошибка при потытке сохранения протокола в файле "'+s+'"! Обратитесь к администратору!', LogGroupGUID);
      end;
  finally
    sl.Free;
  end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Configuration;
const
  LogGroupGUID: string='{797493AC-5FA8-4E65-89C1-7FB0CC1C5824}';
  sModalWinName: string='настроек программы';
var
  sErrorMessage: string;
  bError: boolean;
  ConfigurationForm: TConfigurationForm;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);
  bError:=False;

  ConfigurationForm:=TConfigurationForm.Create(Self);
  with ConfigurationForm do
    try
      ImageList1.GetIcon(ICON_CONFIGURATION, Icon);
      // секция "Интерфейс"
      vleInterface.Cells[1, 1]:=Routines_GetConditionalMessage(Configuration.bAlwaysShowTrayIcon, 'Да', 'Нет');
      vleInterface.Cells[1, 2]:=Routines_GetConditionalMessage(Configuration.bShowQuitConfirmation, 'Да', 'Нет');
      vleInterface.Cells[1, 3]:=Routines_GetConditionalMessage(Configuration.bStoreLastLogin, 'Да', 'Нет');
      vleInterface.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.bStoreLastPassword, 'Да', 'Нет');
      vleInterface.Cells[1, 5]:=Routines_GetConditionalMessage(Configuration.bAutoLogon, 'Да', 'Нет');
      vleInterface.Cells[1, 6]:=Routines_GetConditionalMessage(Configuration.bUseExternalLog, 'Да', 'Нет');
      vleInterface.Cells[1, 7]:=Routines_GetConditionalMessage(vleInterface.ItemProps[6].PickList.IndexOf(Configuration.sDefaultAction)>-1, Configuration.sDefaultAction, '');
      vleInterface.Cells[1, 8]:=Routines_GetConditionalMessage(Configuration.bScrollToLastLogMessage, 'Да', 'Нет');
      vleInterface.Cells[1, 9]:=Routines_GetConditionalMessage(Configuration.bAutorun, 'Да', 'Нет');
      vleInterface.Cells[1, 10]:=Routines_GetConditionalMessage(Configuration.bStartInTray, 'Да', 'Нет');
      vleInterface.Cells[1, 11]:=Routines_GetConditionalMessage(Configuration.bPlaySoundAfterAction, 'Да', 'Нет');
      vleInterface.Cells[1, 12]:=Routines_GetConditionalMessage(Configuration.bShowBaloonHintAfterAction, 'Да', 'Нет');

      // секция "Сервер и база данных"
      vleOVERSEERSERVER.Cells[1, 1]:=WideString(Configuration.OverseerServer.sMySQLHost); // overseerserver
      vleOVERSEERSERVER.Cells[1, 2]:=IntToStr(Configuration.OverseerServer.iMySQLPort);
      vleOVERSEERSERVER.Cells[1, 3]:=IntToStr(Configuration.OverseerServer.iMySQLTimeout);
      vleOVERSEERSERVER.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.OverseerServer.bMySQLCompress, 'Да', 'Нет');
      vleOVERSEERSERVER.Cells[1, 5]:=WideString(Configuration.OverseerServer.sMySQLDatabase);
      // vleOVERSEERSERVER.Enabled:=not Configuration.OverseerServer.bMySQLConnected;

      vleRNE4SERVER.Cells[1, 1]:=WideString(Configuration.RNE4Server.sMySQLHost); // overseerserver
      vleRNE4SERVER.Cells[1, 2]:=IntToStr(Configuration.RNE4Server.iMySQLPort);
      vleRNE4SERVER.Cells[1, 3]:=IntToStr(Configuration.RNE4Server.iMySQLTimeout);
      vleRNE4SERVER.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.RNE4Server.bMySQLCompress, 'Да', 'Нет');
      vleRNE4SERVER.Cells[1, 5]:=WideString(Configuration.RNE4Server.sMySQLDatabase);

      vleDBSERVER.Cells[1, 1]:=WideString(Configuration.DBServer.sMySQLHost); // dbserver
      vleDBSERVER.Cells[1, 2]:=IntToStr(Configuration.DBServer.iMySQLPort);
      vleDBSERVER.Cells[1, 3]:=IntToStr(Configuration.DBServer.iMySQLTimeout);
      vleDBSERVER.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.DBServer.bMySQLCompress, 'Да', 'Нет');
      vleDBSERVER.Cells[1, 5]:=WideString(Configuration.DBServer.sMySQLDatabase_IRD_Location);
      vleDBSERVER.Cells[1, 6]:=WideString(Configuration.DBServer.sMySQLDatabase_ORD_Location);
      vleDBSERVER.Cells[1, 7]:=WideString(Configuration.DBServer.sMySQLDatabase_PRIJAVE_Location);
      vleDBSERVER.Cells[1, 8]:=WideString(Configuration.DBServer.sMySQLDatabase_PRIJAVE_Q_Location);
      vleDBSERVER.Cells[1, 9]:=WideString(Configuration.DBServer.sMySQLDatabase_T_DAY_Location);
      // vleDBSERVER.Enabled:=not Configuration.DBServer.bMySQLConnected;

      vleSTATSERVER.Cells[1, 1]:=WideString(Configuration.StatServer.sMySQLHost); // statserver
      vleSTATSERVER.Cells[1, 2]:=IntToStr(Configuration.StatServer.iMySQLPort);
      vleSTATSERVER.Cells[1, 3]:=IntToStr(Configuration.StatServer.iMySQLTimeout);
      vleSTATSERVER.Cells[1, 4]:=Routines_GetConditionalMessage(Configuration.StatServer.bMySQLCompress, 'Да', 'Нет');
      vleSTATSERVER.Cells[1, 5]:=WideString(Configuration.StatServer.sMySQLDatabase_IRD_Location); // dbserver
      vleSTATSERVER.Cells[1, 6]:=WideString(Configuration.StatServer.sMySQLDatabase_ORD_Location);
      vleSTATSERVER.Cells[1, 7]:=WideString(Configuration.StatServer.sMySQLDatabase_IRDA_Location);
      vleSTATSERVER.Cells[1, 8]:=WideString(Configuration.StatServer.sMySQLDatabase_ORDA_Location);
      vleSTATSERVER.Cells[1, 9]:=WideString(Configuration.StatServer.sMySQLDatabase_PRIJAVE_Location);
      vleSTATSERVER.Cells[1, 10]:=WideString(Configuration.StatServer.sMySQLDatabase_PRIJAVE_Q_Location);
      // vleSTATSERVER.Enabled:=not Configuration.StatServer.bMySQLConnected;
      // секция "Протоколирование"
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

      // секция "Отчёты"
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
          // LogThis('Была предпринята попытка применения настроек программы.', LogGroupGUID, lmtDebug);
          // секция "Интерфейс"
          Configuration.bAlwaysShowTrayIcon:=vleInterface.Cells[1, 1]='Да';
          TrayIcon1.Visible:=Configuration.bAlwaysShowTrayIcon or(not {MainForm.}Visible);
          Configuration.bShowQuitConfirmation:=vleInterface.Cells[1, 2]='Да';
          Configuration.bStoreLastLogin:=vleInterface.Cells[1, 3]='Да';
          Configuration.bStoreLastPassword:=vleInterface.Cells[1, 4]='Да';
          Configuration.bAutoLogon:=vleInterface.Cells[1, 5]='Да';
          Configuration.bUseExternalLog:=vleInterface.Cells[1, 6]='Да';
          Configuration.bScrollToLastLogMessage:=vleInterface.Cells[1, 8]='Да';
          Configuration.bAutorun:=vleInterface.Cells[1, 9]='Да';
          Configuration.bStartInTray:=vleInterface.Cells[1, 10]='Да';
          Configuration.bPlaySoundAfterAction:=vleInterface.Cells[1, 11]='Да';
          Configuration.bShowBaloonHintAfterAction:=vleInterface.Cells[1, 12]='Да';

          chkbxScrollToLastLogMessage.Checked:=chkbxScrollToLastLogMessage.Enabled and Configuration.bScrollToLastLogMessage;
          pnlLog.Visible:=not Configuration.bUseExternalLog;
          {MainForm.}Height:=600-152*integer(Configuration.bUseExternalLog);
          Timer1.Enabled:=Configuration.bUseExternalLog;
          Configuration.sDefaultAction:=Routines_GetConditionalMessage(cbActionsList.Items.IndexOf(vleInterface.Cells[1, 7])>-1, vleInterface.Cells[1, 7], '');

          // секция "Сервер и база данных"
          // if not Configuration.OverseerServer.bMySQLConnected then
          begin
            Configuration.OverseerServer.sMySQLHost:=vleOVERSEERSERVER.Cells[1, 1];
            Configuration.OverseerServer.iMySQLPort:=StrToIntDef(vleOVERSEERSERVER.Cells[1, 2], MYSQL_PORT);
            Configuration.OverseerServer.iMySQLTimeout:=StrToIntDef(vleOVERSEERSERVER.Cells[1, 3], 30);
            Configuration.OverseerServer.bMySQLCompress:=vleOVERSEERSERVER.Cells[1, 4]='Да';
            Configuration.OverseerServer.sMySQLDatabase:=vleOVERSEERSERVER.Cells[1, 5];
          end;

          // if not Configuration.RNE4Server.bMySQLConnected then
          begin
            Configuration.RNE4Server.sMySQLHost:=vleRNE4SERVER.Cells[1, 1];
            Configuration.RNE4Server.iMySQLPort:=StrToIntDef(vleRNE4SERVER.Cells[1, 2], MYSQL_PORT);
            Configuration.RNE4Server.iMySQLTimeout:=StrToIntDef(vleRNE4SERVER.Cells[1, 3], 30);
            Configuration.RNE4Server.bMySQLCompress:=vleRNE4SERVER.Cells[1, 4]='Да';
            Configuration.RNE4Server.sMySQLDatabase:=vleRNE4SERVER.Cells[1, 5];
          end;

          // if not Configuration.DBServer.bMySQLConnected then
          begin
            Configuration.DBServer.sMySQLHost:=vleDBSERVER.Cells[1, 1];
            Configuration.DBServer.iMySQLPort:=StrToIntDef(vleDBSERVER.Cells[1, 2], MYSQL_PORT);
            Configuration.DBServer.iMySQLTimeout:=StrToIntDef(vleDBSERVER.Cells[1, 3], 30);
            Configuration.DBServer.bMySQLCompress:=vleDBSERVER.Cells[1, 4]='Да';
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
            Configuration.StatServer.bMySQLCompress:=vleSTATSERVER.Cells[1, 4]='Да';
            Configuration.StatServer.sMySQLDatabase_IRD_Location:=vleSTATSERVER.Cells[1, 5];
            Configuration.StatServer.sMySQLDatabase_ORD_Location:=vleSTATSERVER.Cells[1, 6];
            Configuration.StatServer.sMySQLDatabase_IRDA_Location:=vleSTATSERVER.Cells[1, 7];
            Configuration.StatServer.sMySQLDatabase_ORDA_Location:=vleSTATSERVER.Cells[1, 8];
            Configuration.StatServer.sMySQLDatabase_PRIJAVE_Location:=vleSTATSERVER.Cells[1, 9];
            Configuration.StatServer.sMySQLDatabase_PRIJAVE_Q_Location:=vleSTATSERVER.Cells[1, 10];
          end;
          // секция "Протоколирование"
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
          // секция "Отчёты"
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
                Routines_GenerateError('Возникла ошибка при определении выбранной папки для сохранения отчётов!', sErrorMessage, bError);
          // флуш лога по нажатию кнопки "применить" (если была включена данная опция)
          if chkbxFlushLogOnApply.Checked then
            Do_FlushLogToFile;
          LogThis('Применение настроек выполнено успешно.', LogGroupGUID, lmtInfo);
        end;
      Free;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; // недоделанная
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
      hLogKeeper:=Msg.wParam; // обновляем хэндл окна ведения протокола
      Handled:=True;
    end;
end;

procedure TMainForm.Timer1Timer(Sender: TObject); // недоделанная
begin
  // отправка бродкастового сообщения предназначенного только LogKeeper в целях получения хэндла окна программы ведения протокола
  BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, msgLogKeeperServer, Handle, 0);
end;

procedure TMainForm.FormCreate(Sender: TObject); // недоделанная
const
  LogGroupGUID: string='{68B5F888-0DA1-4466-AFE7-9FA854AB11C7}';
var
  PanelRect: TRect;
  i: integer;
begin
  // предварительная инициализация переменных
  SessionLogEventCount:=0; // инициализация счётчика лога
  hLogKeeper:=0;
  bFirstRun:=True;

  // регистрация оконных сообщений
  msgLogKeeperClient:=RegisterWindowMessage('msgLogKeeperClient');
  msgLogKeeperServer:=RegisterWindowMessage('msgLogKeeperServer');

  // получение хэндла программы LogKeeper в случае если она уже запущена
  BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, msgLogKeeperServer, Handle, 0);
  Application.ProcessMessages; // получение входящих оконных сообщений (в том числе

  // предварительная инициализация компонентов
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

  // заполнение списков годов
  // данные В АРХИВАХ есть начиная с 2004 года!!!
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

  dtpChoisenPeriod_Start.DateTime:=dtLastDate;
  dtpChoisenPeriod_Stop.DateTime:=dtLastDate;

  PageControl2.ActivePage:=tsLog;

  // предварительная инициализация переменных конфигурации
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

  // считывание конфигурации из файла
  Load_ConfigIni;

  // запуск LogKeeper в случае, если он не был найден
  if Configuration.bUseExternalLog and(not IsWindow(hLogKeeper)) then
    begin
      if FileExists(ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper.exe') then
        ShellExecute(Application.Handle, 'open', PWideChar(ExtractFilePath(ExpandFileName(Application.ExeName))+'LogKeeper.exe'), nil, nil, SW_NORMAL);
      // попытаться его запустить вновь
      if FileExists('D:\My Documents\RAD Studio\Projects\LogKeeper\LogKeeper.exe') then
        ShellExecute(Application.Handle, 'open', PWideChar('D:\My Documents\RAD Studio\Projects\LogKeeper\LogKeeper.exe'), nil, nil, SW_NORMAL);
      // попытаться его запустить вновь
    end;
  Update_Actions;
end;

procedure TMainForm.Action_LogonExecute(Sender: TObject);
const
  LogGroupGUID: string='{3BC49B0E-54F9-4E55-890C-8D2353D8BC86}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Logon.Caption+'"', LogGroupGUID);
  Do_Logon;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_LogoutExecute(Sender: TObject);
const
  LogGroupGUID: string='{4E094470-6F30-4F77-B301-B21B880E78B6}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Logout.Caption+'"', LogGroupGUID);
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
  ProcedureHeader('Процедура обновления состояния действий соединения с сервером', LogGroupGUID);

  Action_Logon.Enabled:=not CurrentUser.bLogged;
  Action_Logon.Visible:=Action_Logon.Enabled;
  Action_Logout.Enabled:=not Action_Logon.Enabled;
  Action_Logout.Visible:=Action_Logout.Enabled;
  LogThis(PWideChar('Действие "'+Action_Logon.Caption+'" '+Routines_GetConditionalMessage(Action_Logon.Enabled, 'включено', 'отключено')+', '+'действие "'+Action_Logout.Caption+'" '+Routines_GetConditionalMessage(Action_Logout.Enabled, 'включено',
    'отключено')+'.'), LogGroupGUID, lmtDebug);
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
  sModalWinName: string='управления учётными записями';
var
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);

  with TAccountsForm.Create(Self) do
    try
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
  ProcedureHeader('Процедура завершения сеанса работы текущего пользователя', LogGroupGUID);

  CurrentUser.bLogged:=False;
  Update_Actions;
  Update_pnlConnectedMode;
  LogThis('Сеанс работы пользователя завершён.', LogGroupGUID, lmtInfo);

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
  ProcedureHeader('Процедура запуска выполнения выбранного действия', LogGroupGUID);

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

  // расчёт выбранного временного периода
  if not bError then
    begin
      LogThis('>> Выполняется операция расчёта выбранного временного периода...', LogGroupGUID, lmtDebug);
      if not(rbLastDate.Checked or rbChoisenDate.Checked or rbLastWeek.Checked or rbLastMonth.Checked or rbChoisenMonth.Checked or rbLastQuarter.Checked or rbChoisenQuarter.Checked or rbLastYear.Checked or rbChoisenYear.Checked or
        rbChoisenPeriod.Checked) then
        Routines_GenerateError('Не был выбран период!', sErrorMessage, bError)
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
              if dtpChoisenPeriod_Start.Date>dtpChoisenPeriod_Stop.Date then
                Routines_GenerateError('Выбранная начальная дата ('+FormatDateTime('dd.mm.yyyy', dtpChoisenPeriod_Start.Date)+') больше, чем конечная ('+FormatDateTime('dd.mm.yyyy', dtpChoisenPeriod_Stop.Date)+')!', sErrorMessage, bError)
              else
                begin
                  wStartDay:=DayOf(dtpChoisenPeriod_Start.Date);
                  wStartMonth:=MonthOf(dtpChoisenPeriod_Start.Date);
                  wStartYear:=YearOf(dtpChoisenPeriod_Start.Date);
                  wStopDay:=DayOf(dtpChoisenPeriod_Stop.Date);
                  wStopMonth:=MonthOf(dtpChoisenPeriod_Stop.Date);
                  wStopYear:=YearOf(dtpChoisenPeriod_Stop.Date);
                end;
            end;
          if rbChoisenMonth.Checked then
            begin
              iYear:=StrToIntDef(cbChoisenMonth_Year.Items[cbChoisenMonth_Year.ItemIndex], -1);
              if iYear=-1 then
                Routines_GenerateError('Не удалось произвести конвертацию выбраного года!', sErrorMessage, bError)
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
                    Routines_GenerateError('Не удалось произвести конвертацию выбраного года!', sErrorMessage, bError)
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
                    Routines_GenerateError('Не удалось произвести конвертацию выбраного года!', sErrorMessage, bError)
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
      LogThis('<< Выполнение операции расчёта выбранного временного периода завершено.', LogGroupGUID, lmtDebug);
    end;

  // получение параметров группировки
  if not bError then
    begin
      LogThis('>> Выполняется операция получения параметров группировки...', LogGroupGUID, lmtDebug);
      if (not(rbGroupByYears.Checked or rbGroupByQuarters.Checked or rbGroupByMonths.Checked or rbGroupByWeeks.Checked or rbGroupByDays.Checked or rbGroupByHours.Checked))and
        (rbGroupByYears.Enabled or rbGroupByQuarters.Enabled or rbGroupByMonths.Enabled or rbGroupByWeeks.Enabled or rbGroupByDays.Enabled or rbGroupByHours.Enabled) then
        Routines_GenerateError('Не выбран период для группировки данных при формировании отчёта!', sErrorMessage, bError)
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
      LogThis('<< Выполнение операции расчёта получения параметров группировки завершено.', LogGroupGUID, lmtDebug);
    end;

  // анализ выбора действия и его отличительных параметров и запуск выполнения действия
  if not bError then
    begin
      LogThis('>> Выполняется операция запуска выполнения действия...', LogGroupGUID, lmtDebug);
      if cbActionsList.Text='Снятие оплаты за звонок на голосовые службы СИЦ' then
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
                        Routines_GenerateError('Не удалось преобразовать данные записи из списка (строка №'+IntToStr(iRoutineCounter+1)+')!', sErrorMessage, bError)
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
                              izg:=Routines_GetConditionalMessage(lvPhonesList_Payoff.Items[iRoutineCounter].SubItems[5]='Да', '1', '0');
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
                Routines_GenerateError('Не отмечено ни одного звонка для выполнения действия!', sErrorMessage, bError)
              else
                if not Do_PayOff(slPayoffList) then
                  begin
                    Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);
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

      if cbActionsList.Text='Формирование отчёта по форме № СИЦ-01-...' then
        begin
          slPhonesList:=TStringList.Create;
          try
            slPhonesList.Duplicates:=dupIgnore;
            slPhonesList.Sorted:=False;
            for iRoutineCounter:=0 to lv_SIC_01.Items.Count-1 do
              if lv_SIC_01.Items[iRoutineCounter].SubItems.Count=2 then
                slPhonesList.Add(lv_SIC_01.Items[iRoutineCounter].SubItems[1]);
            if slPhonesList.Count<=0 then
              Routines_GenerateError('Не задано ни одного абонентского номера телефона для формирования отчёта!', sErrorMessage, bError)
            else
              if not Do_SIC_01(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, slPhonesList, cbShowUnserved_SIC_01.Checked and cbShowUnserved_SIC_01.Enabled) then
                Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);
          finally
            slPhonesList.Free;
          end;
        end;

      if cbActionsList.Text='Формирование отчёта по форме № СИЦ-03-...' then
        if not Do_SIC_03(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, cbPhoneNet_SIC_03.ItemIndex) then
          Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);

      if cbActionsList.Text='Формирование отчёта по форме № СИЦ-04-...' then
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
              Routines_GenerateError('Не выбрано ни одного пользователя для формирования отчёта!', sErrorMessage, bError)
            else
              if not Do_SIC_04(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, gbp, not(cbWeekStartsFromDayOfBeginning_SIC_04.Checked and cbWeekStartsFromDayOfBeginning_SIC_04.Enabled),
                rbAllUsers_SIC_04.Checked, cbCreateDetailedReport_SIC_04.Checked and cbCreateDetailedReport_SIC_04.Enabled, cbShowSQLQueries_SIC_04.Checked and cbShowSQLQueries_SIC_04.Enabled,
                cbShowIdleUsers_SIC_04.Checked and cbShowIdleUsers_SIC_04.Enabled, slUserList) then
                Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);
          finally
            slUserList.Free;
          end;
        end;

      if cbActionsList.Text='Формирование отчёта по форме № СИЦ-05-...' then
        begin
          if (cbService_SIC_05.ItemIndex<0)and(cbService_SIC_05.ItemIndex>(aServices_Count-1)) then
            Routines_GenerateError('Не удалось произвести конвертацию выбраной услуги!', sErrorMessage, bError)
          else
            if not Do_SIC_05(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, gbp, cbService_SIC_05.ItemIndex,
              not(cbWeekStartsFromDayOfBeginning_SIC_05.Checked and cbWeekStartsFromDayOfBeginning_SIC_05.Enabled)) then
              Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);
        end;

      if cbActionsList.Text='Формирование отчёта по форме № СИЦ-06-...' then
        begin
          if (cbService_SIC_06.ItemIndex<0)and(cbService_SIC_06.ItemIndex>(aServices_Count-1)) then
            Routines_GenerateError('Не удалось произвести конвертацию выбраной услуги!', sErrorMessage, bError)
          else
            if not Do_SIC_06(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, cbService_SIC_06.ItemIndex) then
              Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);
        end;

      if cbActionsList.Text='Формирование отчёта по форме № СИЦ-07-...' then
        if not Do_SIC_07(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, gbp, not(cbWeekStartsFromDayOfBeginning_SIC_07.Checked and cbWeekStartsFromDayOfBeginning_SIC_07.Enabled)) then
          Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);

      if cbActionsList.Text='Формирование отчёта по форме № СИЦ-08-...' then
        if not Do_SIC_08(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True) then
          Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);

      if cbActionsList.Text='Формирование отчёта по форме № СИЦ-09-...' then
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
              Routines_GenerateError('Не задано ни одной услуги для формирования отчёта!', sErrorMessage, bError)
            else
              if not Do_SIC_09(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, cbPhoneNet_SIC_09.ItemIndex, cbSummaryReport_SIC_09.Enabled and cbSummaryReport_SIC_09.Checked,
                cbOldReport_SIC_09.Enabled and cbOldReport_SIC_09.Checked, slSelectedServicesList) then
                Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);
          finally
            slSelectedServicesList.Free;
          end;
        end;

      if cbActionsList.Text='Формирование отчёта по форме № СИЦ-10-...' then
        begin
          case cbCCID_SIC_10.ItemIndex of
            0:
              iCCID:=-1;
            1:
              iCCID:=1;
            2:
              iCCID:=2;
          else
            Routines_GenerateError('Не удалось идентифицировать выбранную группу пользователей!', sErrorMessage, bError);
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
                  Routines_GenerateError('Не выбрано ни одного пользователя для формирования отчёта!', sErrorMessage, bError)
                else
                  if not Do_SIC_10(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), True, gbp, not(cbWeekStartsFromDayOfBeginning_SIC_10.Checked and cbWeekStartsFromDayOfBeginning_SIC_10.Enabled),
                    rbAllUsers_SIC_10.Checked, cbCreateDetailedReport_SIC_10.Checked and cbCreateDetailedReport_SIC_10.Enabled, iCCID, slUserList) then
                    Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);
              finally
                slUserList.Free;
              end;
            end;
        end;

      if cbActionsList.Text='Формирование таблиц данных входящих/исходящих вызовов (<i/o>rd_<yyyymmdd>, <i/o>rd_<yyyy>[mm][dd][_[yyyy][mm][dd]])' then
        begin
          aXRD:=XRDInput;
          if rbIRD.Checked then
            aXRD:=XRDInput;
          if rbORD.Checked then
            aXRD:=XRDOutput;
          sTableName:=Routines_GetConditionalMessage((cbCustomNameOfXRDA.Checked)and(ebCustomNameOfXRDA.Text<>''), ebCustomNameOfXRDA.Text, '');
          if not Do_CreateXRDA(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay), False, aXRD, sTableName, cbRecreateXRD.Checked, cbCreateXRDA.Checked, cbRecreateXRDA.Checked) then
            Routines_GenerateError('Произошла ошибка во вложенной функции выполнения операции!', sErrorMessage, bError);
        end;

      if cbActionsList.Text='Формирование файлов выгрузки для АСКР' then
        begin
          if not Do_ASKR(EncodeDate(wStartYear, wStartMonth, wStartDay), EncodeDate(wStopYear, wStopMonth, wStopDay)) then
            Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!', sErrorMessage, bError);
        end;

      LogThis('<< Выполнение операции запуска выполнения действия завершено.', LogGroupGUID, lmtDebug);
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
  ProcedureHeader('Процедура реакции на изменение содержимого строки ввода телефонов', LogGroupGUID);
  Update_Actions_Payoff;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RefreshCallsList_PayoffExecute(Sender: TObject);
const
  LogGroupGUID: string='{CCBC63CD-6CF3-4043-AC86-B6420C40BE88}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_RefreshCallsList_Payoff.Caption+'"', LogGroupGUID);
  Do_RefreshCallsList_Payoff;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_SelectAction;
const
  LogGroupGUID: string='{094455BA-D7C8-469A-9599-0DAC6D98B506}';
var
  i: integer;
begin
  ProcedureHeader('Процедура реакции на переключения элемента списка действий', LogGroupGUID);

  for i:=0 to PageControl1.PageCount-1 do
    begin
      if PageControl1.Pages[i].Caption=cbActionsList.Text then
        begin
          PageControl1.ActivePageIndex:=i;
          LogThis('Была выбрана страница с названием <'+PageControl1.Pages[i].Caption+'>.', LogGroupGUID, lmtDebug);
        end;
    end;
  Update_GroupingState;

  // инициализация значений компонентов страницы

  if cbActionsList.Text='Снятие оплаты за звонок на голосовые службы СИЦ' then
    begin
      ebPhonesList_Payoff.Clear;
      lvPhonesList_Payoff.Items.BeginUpdate;
      lvPhonesList_Payoff.Clear;
      lvPhonesList_Payoff.Items.EndUpdate;
      Update_Actions_Payoff;
    end;
  if (cbActionsList.Text='Формирование отчёта по форме № СИЦ-01-...') then
    begin
      cbShowUnserved_SIC_01.Checked:=False;
      Update_Actions_SIC_01;
    end;
  if (cbActionsList.Text='Формирование отчёта по форме № СИЦ-02-...') then
    begin
      rbDetailedReport_SIC_02.Checked:=True;
      rbSortedReport_SIC_02.Checked:=False;
    end;
  if (cbActionsList.Text='Формирование отчёта по форме № СИЦ-04-...') then
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
  if (cbActionsList.Text='Формирование отчёта по форме № СИЦ-05-...') then
    begin
      cbService_SIC_05.ItemIndex:=0;
      cbWeekStartsFromDayOfBeginning_SIC_05.Checked:=False;
    end;
  if (cbActionsList.Text='Формирование отчёта по форме № СИЦ-06-...') then
    begin
      cbService_SIC_06.ItemIndex:=0;
    end;
  if (cbActionsList.Text='Формирование отчёта по форме № СИЦ-07-...') then
    begin
      cbWeekStartsFromDayOfBeginning_SIC_07.Checked:=False;
    end;
  if (cbActionsList.Text='Формирование отчёта по форме № СИЦ-09-...') then
    begin
      cbPhoneNet_SIC_09.ItemIndex:=0;
      for i:=0 to lvServices_SIC_09.Items.Count-1 do
        lvServices_SIC_09.Items[i].Checked:=False;
      cbSummaryReport_SIC_09.Checked:=False;
      cbOldReport_SIC_09.Checked:=False;
      Update_Actions_SIC_09;
    end;
  if (cbActionsList.Text='Формирование отчёта по форме № СИЦ-10-...') then
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
  if (cbActionsList.Text='Формирование таблиц данных входящих/исходящих вызовов (<i/o>rd_<yyyymmdd>, <i/o>rd_<yyyy>[mm][dd][_[yyyy][mm][dd]])') then
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

  if cbActionsList.Text='Формирование файлов выгрузки для АСКР' then
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
  ProcedureHeader('Процедура запуска выполнения выбранных из списка действий', LogGroupGUID);
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
  // Routines_GenerateError('Произошла ошибка во вложенной функции формирования отчёта!',sErrorMessage,bError);

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
  ProcedureHeader('Процедура обновления состояния вариантов группировки', LogGroupGUID);

  dtStartDate:=dtpChoisenPeriod_Start.Date;
  dtStopDate:=dtpChoisenPeriod_Stop.Date;

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

  if (cbActionsList.Text='Формирование отчёта по форме № СИЦ-01-...')or(cbActionsList.Text='Формирование отчёта по форме № СИЦ-03-...')or(cbActionsList.Text='Формирование отчёта по форме № СИЦ-06-...')or
    (cbActionsList.Text='Формирование отчёта по форме № СИЦ-08-...')or(cbActionsList.Text='Формирование отчёта по форме № СИЦ-09-...')or
    (cbActionsList.Text='Формирование таблиц данных входящих/исходящих вызовов (<i/o>rd_<yyyymmdd>, <i/o>rd_<yyyy>[mm][dd][_[yyyy][mm][dd]])')or(cbActionsList.Text='Снятие оплаты за звонок на голосовые службы СИЦ')or
    (cbActionsList.Text='Формирование файлов выгрузки для АСКР') then
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
      // если для отчёта выбран промежуток кратный году
      if rbLastYear.Checked or rbChoisenYear.Checked or(rbChoisenPeriod.Checked and bStartOfTheYear and bEndOfTheYear and(wStartYear<=wStopYear)) then
        begin
          rbGroupByYears.Enabled:=True;
          rbGroupByQuarters.Enabled:=True;
          rbGroupByMonths.Enabled:=True;
          rbGroupByWeeks.Enabled:=True;
          rbGroupByDays.Enabled:=True;
          rbGroupByHours.Enabled:=not(cbActionsList.Text='Формирование отчёта по форме № СИЦ-10-...');
        end
      else
        // если для отчёта выбран промежуток кратный кварталу
        if rbLastQuarter.Checked or rbChoisenQuarter.Checked or(rbChoisenPeriod.Checked and bStartOfTheQuarter and bEndOfTheQuarter and(((wStartYear=wStopYear)and(wStopMonth>=wStartMonth+2))or(wStartYear<wStopYear))) then
          begin
            rbGroupByYears.Enabled:=False;
            rbGroupByQuarters.Enabled:=True;
            rbGroupByMonths.Enabled:=True;
            rbGroupByWeeks.Enabled:=True;
            rbGroupByDays.Enabled:=True;
            rbGroupByHours.Enabled:=not(cbActionsList.Text='Формирование отчёта по форме № СИЦ-10-...');
          end
        else
          // если для отчёта выбран промежуток кратный месяцу
          if rbLastMonth.Checked or rbChoisenMonth.Checked or(rbChoisenPeriod.Checked and bStartOfTheMonth and bEndOfTheMonth and(((wStartYear=wStopYear)and(wStopMonth>=wStartMonth))or(wStartYear<wStopYear))) then
            begin
              rbGroupByYears.Enabled:=False;
              rbGroupByQuarters.Enabled:=False;
              rbGroupByMonths.Enabled:=True;
              rbGroupByWeeks.Enabled:=True;
              rbGroupByDays.Enabled:=True;
              rbGroupByHours.Enabled:=not(cbActionsList.Text='Формирование отчёта по форме № СИЦ-10-...');
            end
          else
            // если для отчёта выбран промежуток кратный неделе
            if rbLastWeek.Checked or(rbChoisenPeriod.Checked
              // and bStartOfTheWeek and bEndOfTheWeek and((DaysBetween(dtStartDate, dtStopDate)mod 7)=6)) then // чтобы учитывался только промежуток кратный неделе
              and(DaysBetween(dtStartDate, dtStopDate)>=6)) then
              begin
                rbGroupByYears.Enabled:=False;
                rbGroupByQuarters.Enabled:=False;
                rbGroupByMonths.Enabled:=False;
                rbGroupByWeeks.Enabled:=True;
                rbGroupByDays.Enabled:=True;
                rbGroupByHours.Enabled:=not(cbActionsList.Text='Формирование отчёта по форме № СИЦ-10-...');
              end
            else
              // если для отчёта выбран произвольный промежуток (в том числе равный суткам)
              begin
                rbGroupByYears.Enabled:=False;
                rbGroupByQuarters.Enabled:=False;
                rbGroupByMonths.Enabled:=False;
                rbGroupByWeeks.Enabled:=False;
                rbGroupByDays.Enabled:=True;
                rbGroupByHours.Enabled:=not(cbActionsList.Text='Формирование отчёта по форме № СИЦ-10-...');
              end;
    end;

  Update_OtherGroupingStateOptions;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.TimePeriodChange(Sender: TObject);
const
  LogGroupGUID: string='{64D91A01-B402-49D6-B0BE-FBB37647799A}';
begin
  ProcedureHeader('Процедура-обработчик операции по выбору иного периода времени', LogGroupGUID);
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
  ProcedureHeader('Функция сохранения данных отчёта в файл и открытия данного файла при помощи ассоциированного приложения', LogGroupGUID);
  bError:=False;

  // сохранение сформированного текста в файл на диск
  // открытие сохранённого файла при помощи браузера
  if not bError then
    begin
      with TStringList.Create do
        try
          Text:=aHTML;
          LogThis('Формирование имени файла для сохранения отчёта.', LogGroupGUID, lmtDebug);
          case Configuration.trfReportFolder of
            rfTempFolder:
              sFileFolder:=Configuration.sTempFolder;
            rfApplicationFolder:
              sFileFolder:=Configuration.sApplicationFolder;
            rfCustomFolder:
              sFileFolder:=Configuration.sCustomFolder;
          else
            Routines_GenerateError('Возникла ошибка при определении пути папки сохранённых отчётов!', sErrorMessage, bError);
          end;
          sFileName:=aFileName;
          if Configuration.bAskForFileName and(not aSilentYes) then
            with TFileSaveDialog.Create(Self) do
              try
                DefaultExtension:='htm';
                DefaultFolder:=sFileFolder;
                FileName:=sFileName;
                aFileTypeItem:=FileTypes.Add;
                aFileTypeItem.DisplayName:='Документы HTML (*.htm)';
                aFileTypeItem.FileMask:='*.htm';
                aFileTypeItem:=FileTypes.Add;
                aFileTypeItem.DisplayName:='Все файлы (*.*)';
                aFileTypeItem.FileMask:='*.*';
                FileTypeIndex:=1;
                if not Configuration.bDontDemandOverwriteConfirmation then
                  Options:=[fdoOverWritePrompt];
                Title:='Выберите папку и введите имя файла для сохранения отчёта';
                if not Execute then
                  Routines_GenerateError('Не было подтверждено имя файла для сохранения отчёта!', sErrorMessage, bError)
                else
                  if FileName='' then
                    Routines_GenerateError('Не было введено имя файла для сохранения отчёта!', sErrorMessage, bError)
                  else
                    sFileName:=FileName;
              finally
                Free;
              end
          else
            sFileName:=sFileFolder+sFileName;
          if not bError then
            LogThis('Имя файла для сохранения отчёта - '+#39+sFileName+#39+'.', LogGroupGUID, lmtDebug);
          if not bError then
            if (not Configuration.bDontDemandOverwriteConfirmation)and FileExists(sFileName)and(not aSilentYes) then
              if MessageBox(Handle, PWideChar('Вы действительно хотите заменить существующий файл?'), PWideChar('OVERSEER - Подтверждение замены'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)<>IDOK then
                Routines_GenerateError('Возникла ошибка при сохранении отчёта в файл '+#39+sFileName+#39+' - операция замены файла не была подтверждена пользователем!', sErrorMessage, bError);
          if not bError then
            begin
              LogThis('Производится попытка сохранения отчёта в файл '+#39+sFileName+#39+'.', LogGroupGUID, lmtInfo);
              SaveToFile(sFileName);
              if aOpenWithBrowser then
                begin
                  LogThis('Производится попытка открытия файла браузером по умолчанию.', LogGroupGUID, lmtInfo);
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
  ProcedureHeader('Процедура-обработчик операции по выбору иного способа группировки данных', LogGroupGUID);
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
  ProcedureHeader('Процедура обновления состояния вариантов группировки', LogGroupGUID);

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
  ProcedureHeader('Процедура-обработчик действия "'+Action_AddPhones_SIC_01.Caption+'"', LogGroupGUID);
  Do_AddPhones_SIC_01;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_DeletePhone_SIC_01Execute(Sender: TObject);
const
  LogGroupGUID: string='{7795C5E0-3800-46AD-9C82-E823D717678B}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_DeletePhone_SIC_01.Caption+'"', LogGroupGUID);
  Do_DeletePhone_SIC_01;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ClearPhones_SIC_01Execute(Sender: TObject);
const
  LogGroupGUID: string='{7795C5E0-3800-46AD-9C82-E823D717678B}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_ClearPhones_SIC_01.Caption+'"', LogGroupGUID);
  Do_ClearPhones_SIC_01;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_DeletePhone_SIC_01;
const
  LogGroupGUID: string='{9A7069A9-67FC-47C8-8FAA-817DFBA5BD49}';
begin
  ProcedureHeader('Процедура удаления телефона из списка', LogGroupGUID);

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
  ProcedureHeader('Процедура очистки списка телефонов', LogGroupGUID);

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
  ProcedureHeader('Процедура реакции на выбор элемента списка телефонов', LogGroupGUID);
  Update_Actions_SIC_01;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.eb_SIC_01Change(Sender: TObject);
const
  LogGroupGUID: string='{9069FB29-ECAB-4F24-BA7A-1B1B3FE43606}';
begin
  ProcedureHeader('Процедура реакции на изменение содержимого строки ввода телефонов', LogGroupGUID);
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
  ProcedureHeader('Процедура добавления телефонов в список', LogGroupGUID);

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
  ProcedureHeader('Процедура переназначения порядковых номеров телефонов в списке', LogGroupGUID);

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
  ProcedureHeader('Процедура-обработчик действия "'+Action_Comments.Caption+'"', LogGroupGUID);
  Do_Comments;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbCreateDetailedReport_SIC_04Click(Sender: TObject);
const
  LogGroupGUID: string='{590E669D-89A0-4D4E-9A75-A6FFCD6D1FAE}';
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "'+cbCreateDetailedReport_SIC_04.Caption+'"', LogGroupGUID);

  cbShowSQLQueries_SIC_04.Enabled:=cbCreateDetailedReport_SIC_04.Checked;
  if not cbShowSQLQueries_SIC_04.Enabled then
    cbShowSQLQueries_SIC_04.Checked:=False;
  LogThis('Флажок "'+cbCreateDetailedReport_SIC_04.Caption+'" '+Routines_GetConditionalMessage(cbCreateDetailedReport_SIC_04.Checked, 'включён', 'отключён')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RefreshUserList_SIC_04Execute(Sender: TObject);
const
  LogGroupGUID: string='{8B252F54-5DD5-4D0C-ADC7-9B169CD47862}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_RefreshUserList_SIC_04.Caption+'"', LogGroupGUID);
  Do_RefreshUserList_SIC_04;
  Update_Actions_SIC_04;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_RefreshUserList_SIC_10Execute(Sender: TObject);
const
  LogGroupGUID: string='{1AB0BDE1-08FB-41B5-A116-662EC4B11032}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_RefreshUserList_SIC_10.Caption+'"', LogGroupGUID);
  Do_RefreshUserList_SIC_10;
  Update_Actions_SIC_10;
  ProcedureFooter(LogGroupGUID);
end;

function TMainForm.Do_CreateXRDA(const aStartDate, aStopDate: TDate; const aSilentYes: boolean; const aXRD: tXRD; var aTableName: string; const bRecreateXRD: boolean; const bCreateXRDA, bRecreateXRDA: boolean): boolean;
const
  LogGroupGUID: string='{A98BEE49-03AB-44A4-BA81-633908F5B06E}';
var
  ResultSet, ResultSet2: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
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
  ProcedureHeader('Процедура (пере)формирования таблиц данных входящих/исходящих вызовов (ird[a]/orda[a])', LogGroupGUID);
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
  // Подключение к STATSERVER
  MySQL_OpenConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
  StepProgressBar; //

  // Формирование имени таблицы xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]], если нужно (пере)формировать XRDA
  if (not bError)and(bCreateXRDA or bRecreateXRDA) then
    begin
      LogThis('>> Выполняется операция генерации имени таблицы данных xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]...', LogGroupGUID, lmtDebug);
      if aTableName<>'' then
        sXRDATableName:=aTableName
      else
        begin
          // если начальная дата является началом года и конечная является концом года
          if bStartOfTheYear and bEndOfTheYear and(wStartYear=wStopYear) then
            sXRDATableName:=cXRDPrefix+'rda_'+FormatDateTime('yyyy', aStartDate)
          else
            // если начальная дата является началом месяца и конечная является концом месяца
            if bStartOfTheMonth and bEndOfTheMonth and(wStartYear=wStopYear)and(wStartMonth=wStopMonth) then
              sXRDATableName:=cXRDPrefix+'rda_'+FormatDateTime('yyyymm', aStartDate)
            else
              // если начальная дата и конечная совпадают
              if (wStartYear=wStopYear)and(wStartMonth=wStopMonth)and(wStartDay=wStopDay) then
                sXRDATableName:=cXRDPrefix+'rda_'+FormatDateTime('yyyymmdd', aStartDate)
              else
                sXRDATableName:=cXRDPrefix+'rda_'+FormatDateTime('yyyymmdd', aStartDate)+'_'+FormatDateTime('yyyymmdd', aStopDate);
        end;
      aTableName:=sXRDATableName;
      LogThis('Сгенерированное имя таблицы данных xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] равно "'+sXRDATableName+'".', LogGroupGUID, lmtDebug);
      LogThis('<< Выполнение операции генерации имени таблицы данных xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] завершено.', LogGroupGUID, lmtDebug);

      // Проверка наличия готовой таблицы данных xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]], если нужно (пере)формировать XRDA
      LogThis('>> Выполняется операция проверки наличия таблицы данных "'+sXRDATableName+'" в базе данных...', LogGroupGUID, lmtDebug);
      if not Configuration.StatServer.bConnected then
        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          if mysql_ping(Configuration.StatServer.hConnection)<>0 then
            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
          else
            begin
              q:='SHOW TABLES FROM '+sSTATSERVER_XRDA_Location+' LIKE "'+LowerCase(sXRDATableName)+'";';
              LogThis(q, LogGroupGUID, lmtSQL);
              if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
              else
                begin
                  LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                  ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
                  if ResultSet=nil then
                    Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                  else
                    begin
                      LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                      iRoutineCounter:=mysql_num_rows(ResultSet);
                      LogThis('Количество строк выборки равно '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                      if iRoutineCounter<0 then
                        Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                      else
                        begin
                          if (iRoutineCounter<0)or(iRoutineCounter>1) then
                            Routines_GenerateError('Количество строк выборки ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (0 или 1)!', sErrorMessage, bError)
                          else
                            begin
                              LogThis('Количество строк выборки соответствует требуемому (0 или 1).', LogGroupGUID, lmtDebug);
                              if iRoutineCounter=0 then
                                begin
                                  bXRDATableExists:=False;
                                  LogThis('Искомая таблица не была найдена!', LogGroupGUID, lmtWarning);
                                end
                              else
                                begin
                                  ResultRow:=mysql_fetch_row(ResultSet);
                                  if ResultRow=nil then
                                    Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!', sErrorMessage, bError)
                                  else
                                    begin
                                      if LowerCase(string(ResultRow[0]))<>LowerCase(sXRDATableName) then
                                        Routines_GenerateError('Полученное имя таблицы данных не соответствует требуемому!', sErrorMessage, bError)
                                      else
                                        begin
                                          bXRDATableExists:=True;
                                          LogThis('Наличие таблицы данных проверено успешно.', LogGroupGUID, lmtDebug);
                                        end;
                                    end;
                                end;
                            end;
                        end;
                      mysql_free_result(ResultSet);
                      LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                    end;
                end;
            end;
        end;
      LogThis('<< Выполнение операции проверки наличия таблицы данных "'+sXRDATableName+'" в базе данных завершено.', LogGroupGUID, lmtDebug);
      StepProgressBar;
    end;

  if not bError then
    begin
      slXRDFullList:=TStringList.Create;
      try
        // если нет таблицы xrda и нужно её создавать, либо нужно пересоздавать xrd или xrda
        if (((not bXRDATableExists)and bCreateXRDA)or bRecreateXRD or bRecreateXRDA) then
          begin
            // Cоставление списка таблиц xrd_<yyyymmdd>, которые должны быть на сервере STATSERVER (в том числе для формирования таблицы xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]])
            LogThis('>> Выполняется операция составления списка таблиц данных для проверки их наличия в базе данных...', LogGroupGUID, lmtDebug);
            dtDate:=aStartDate;
            repeat
              slXRDFullList.Add(cXRDPrefix+'rd_'+FormatDateTime('yyyymmdd', dtDate));
              dtDate:=IncDay(dtDate, 1);
            until dtDate>aStopDate;
            LogThis('Финальное количество строк списка таблиц данных равно '+IntToStr(slXRDFullList.Count)+'.', LogGroupGUID, lmtDebug);
            LogThis('<< Выполнение операции составления списка таблиц данных для проверки их наличия в базе данных завершено.', LogGroupGUID, lmtDebug);

            slXRDMissedList:=TStringList.Create;
            try
              // Циклическая проверка наличия всех таблиц xrd_<yyyymmdd> из созданного списка на сервере STATSERVER с составлением списка недостающих таблиц
              LogThis('>> Выполняется операция составления списка недостающих таблиц данных...', LogGroupGUID, lmtDebug);

              if bRecreateXRD then
                begin
                  // в случае если нужно переформировать все таблицы xrd_<yyyymmdd> - добавляем в список недостающий весь список необходимых
                  slXRDMissedList.AddStrings(slXRDFullList);
                end
              else
                begin
                  for iFullListCounter:=0 to slXRDFullList.Count-1 do
                    if bError then
                      Break
                    else
                      begin
                        LogThis('>> Выполняется операция проверки наличия таблицы данных "'+slXRDFullList[iFullListCounter]+'" в базе данных...', LogGroupGUID, lmtDebug);
                        if not Configuration.StatServer.bConnected then
                          Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                        else
                          begin
                            if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                              Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
                            else
                              begin
                                q:='SHOW TABLES FROM '+sSTATSERVER_XRD_Location+' LIKE "'+LowerCase(slXRDFullList[iFullListCounter])+'";';
                                LogThis(q, LogGroupGUID, lmtSQL);
                                if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                  Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                                else
                                  begin
                                    LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                    ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
                                    if ResultSet=nil then
                                      Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                        iRoutineCounter:=mysql_num_rows(ResultSet);
                                        LogThis('Количество строк выборки равно '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                        if iRoutineCounter<0 then
                                          Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                        else
                                          begin
                                            if (iRoutineCounter<0)or(iRoutineCounter>1) then
                                              Routines_GenerateError('Количество строк выборки ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (0 или 1)!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('Количество строк выборки соответствует требуемому (0 или 1).', LogGroupGUID, lmtDebug);
                                                if iRoutineCounter=0 then
                                                  begin
                                                    slXRDMissedList.Add(slXRDFullList[iFullListCounter]);
                                                    LogThis('Искомая таблица данных ('+sSTATSERVER_XRD_Location+'.'+slXRDFullList[iFullListCounter]+') не была найдена!', LogGroupGUID, lmtWarning);
                                                  end
                                                else
                                                  begin
                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                    if ResultRow=nil then
                                                      Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!', sErrorMessage, bError)
                                                    else
                                                      if LowerCase(string(ResultRow[0]))<>LowerCase(slXRDFullList[iFullListCounter]) then
                                                        Routines_GenerateError('Полученное имя таблицы данных не соответствует требуемому!', sErrorMessage, bError)
                                                      else
                                                        LogThis('Наличие таблицы данных проверено успешно.', LogGroupGUID, lmtDebug);
                                                  end;
                                              end;
                                          end;
                                        mysql_free_result(ResultSet);
                                        LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                      end;
                                  end;
                              end;
                          end;
                        LogThis('<< Выполнение операции проверки наличия таблицы данных "'+slXRDFullList[iFullListCounter]+'" в базе данных завершено.', LogGroupGUID, lmtDebug);
                      end;
                end;
              if not bError then
                LogThis('Количество недостающих таблиц данных равно '+IntToStr(slXRDMissedList.Count)+'.', LogGroupGUID, lmtWarning);
              LogThis('<< Выполнение операции составления списка недостающих таблиц данных завершено.', LogGroupGUID, lmtDebug);

              // В случае, если не достаёт некоторых таблиц xrd_<yyyymmdd>:
              if (not bError)and(slXRDMissedList.Count>0) then
                begin
                  // Подключение к DBSERVER
                  MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                  StepProgressBar;

                  if not bError then
                    begin
                      // Циклическое выполнение действий по созданию таблиц данных xrd_<yyyymmdd>
                      for iMissedListCounter:=0 to slXRDMissedList.Count-1 do
                        if bError then
                          Break
                        else
                          begin
                            // Проверка наличия исходной таблицы xrd_<yyyymmdd> на DBSERVER
                            LogThis('>> Выполняется операция проверки наличия таблицы данных "'+slXRDMissedList[iMissedListCounter]+'" в базе данных...', LogGroupGUID, lmtDebug);
                            if not Configuration.DBServer.bConnected then
                              Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                            else
                              begin
                                if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                                  Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    q:='SHOW TABLES FROM '+sDBSERVER_XRD_Location+' LIKE "'+LowerCase(slXRDMissedList[iMissedListCounter])+'";';
                                    LogThis(q, LogGroupGUID, lmtSQL);
                                    if mysql_real_query(Configuration.DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                      Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                                    else
                                      begin
                                        LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                        ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                        if ResultSet=nil then
                                          Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                            iRoutineCounter:=mysql_num_rows(ResultSet);
                                            LogThis('Количество строк выборки равно '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                            if iRoutineCounter<0 then
                                              Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                            else
                                              begin
                                                if iRoutineCounter<>1 then
                                                  begin
                                                    LogThis('Количество строк выборки ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (1)!', LogGroupGUID, lmtDebug);
                                                    Routines_GenerateError('Искомая таблица данных  ('+sDBSERVER_XRD_Location+'.'+slXRDMissedList[iMissedListCounter]+') не была найдена!', sErrorMessage, bError);
                                                  end
                                                else
                                                  begin
                                                    LogThis('Количество строк выборки соответствует требуемому (1).', LogGroupGUID, lmtDebug);
                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                    if ResultRow=nil then
                                                      Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        if LowerCase(string(ResultRow[0]))<>LowerCase(slXRDMissedList[iMissedListCounter]) then
                                                          Routines_GenerateError('Полученное имя таблицы данных не соответствует требуемому!', sErrorMessage, bError)
                                                        else
                                                          LogThis('Наличие таблицы данных проверено успешно.', LogGroupGUID, lmtDebug);
                                                      end;
                                                  end;
                                              end;
                                            mysql_free_result(ResultSet);
                                            LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                          end;
                                      end;
                                  end;
                              end;
                            LogThis('<< Выполнение операции проверки наличия таблицы данных "'+slXRDMissedList[iMissedListCounter]+'" в базе данных завершено.', LogGroupGUID, lmtDebug);
                            StepProgressBar;

                            // Получение текста запроса на создание очередной отсутствующей таблицы xrd_<yyyymmdd> на основе существующей
                            if not bError then
                              begin
                                LogThis('>> Выполняется операция получения запроса на создание очередной недостающей таблицы данных...', LogGroupGUID, lmtDebug);
                                if not Configuration.DBServer.bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SHOW CREATE TABLE '+sDBSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+';';
                                        LogThis(q, LogGroupGUID, lmtSQL);
                                        if mysql_real_query(Configuration.DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                            if ResultSet=nil then
                                              Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                                iRoutineCounter:=mysql_num_rows(ResultSet);
                                                LogThis('Количество строк выборки равно '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                                if iRoutineCounter<0 then
                                                  Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    if iRoutineCounter>1 then
                                                      Routines_GenerateError('Количество строк выборки ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!', sErrorMessage, bError)
                                                        else
                                                          if ResultRow[1]='' then
                                                            Routines_GenerateError('Возникла ошибка при получении строки запроса на создание очередной недостающей таблицы данных!', sErrorMessage, bError)
                                                          else
                                                            begin
                                                              sCreateQuery:=StringReplace(StringReplace(StringReplace(string(ResultRow[1]), #$A, '', [rfReplaceAll]), '`', '', [rfReplaceAll]), 'CREATE TABLE '+cXRDPrefix+'rd_',
                                                                'CREATE TABLE '+sSTATSERVER_XRD_Location+'.'+cXRDPrefix+'rd_', [rfReplaceAll]);
                                                              LogThis('Запрос на создание недостающей таблицы данных получен успешно.', LogGroupGUID, lmtDebug);
                                                            end;
                                                      end;
                                                  end;
                                              end;
                                            mysql_free_result(ResultSet);
                                            LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                          end;
                                      end;
                                  end;
                                LogThis('<< Выполнение операции получения запроса на создание очередной недостающей таблицы данных завершено.', LogGroupGUID, lmtDebug);
                                StepProgressBar;

                                if not bError then
                                  begin
                                    // Предварительное удаление таблицы xrd_<yyyymmdd> на STATSERVER при её наличии
                                    MySQL_DropTable(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, //
                                      'DROP TABLE IF EXISTS '+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+';'); //
                                    StepProgressBar;

                                    if not bError then
                                      begin
                                        // Создание таблицы xrd_<yyyymmdd> на STATSERVER
                                        MySQL_CreateTable(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, sCreateQuery); //
                                        StepProgressBar;

                                        if not bError then
                                          begin
                                            // Проверка cозданиa таблицы xrd_<yyyymmdd> на STATSERVER
                                            MySQL_CheckTableExistance(LogGroupGUID, Configuration.StatServer, sSTATSERVER_XRD_Location, bError, sErrorMessage, LowerCase(slXRDMissedList[iMissedListCounter]));
                                            StepProgressBar;

                                            if not bError then
                                              begin
                                                // Блокирование таблицы на DBSERVER на чтение
                                                MySQL_LockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage, sDBSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+' READ');
                                                StepProgressBar;

                                                if not bError then
                                                  begin
                                                    // Блокирование таблиц на STATSERVER на запись
                                                    MySQL_LockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+' WRITE');
                                                    StepProgressBar;
                                                  end;
                                              end;
                                          end;
                                      end;
                                  end;
                              end;

                            // Вставка данных из таблицы с DBSERVER в таблицу на STATSERVER
                            if not bError then
                              begin
                                // Получение данных из таблицы на DBSERVER
                                LogThis('>> Выполняется операция получения записей таблицы данных "'+LowerCase(slXRDMissedList[iMissedListCounter])+'"...', LogGroupGUID, lmtDebug);
                                if not Configuration.DBServer.bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT * FROM '+sDBSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+
                                          ' GROUP BY ani, ddi, datum, vrijeme, dur, rc, srv, rm, izg, izgnum, druga_info, v_oper, v_mreza, qid, ccid, d_qid, d_ccid, qdur;';
                                        LogThis(q, LogGroupGUID, lmtSQL);
                                        if mysql_real_query(Configuration.DBServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                            if ResultSet=nil then
                                              Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                                iRowCountSource:=mysql_num_rows(ResultSet);
                                                LogThis('Количество строк выборки равно '+IntToStr(iRowCountSource)+'.', LogGroupGUID, lmtDebug);
                                                if iRowCountSource<0 then
                                                  Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    InitProgressBar(iRowCountSource);
                                                    for iSourceRowCounter:=0 to iRowCountSource-1 do
                                                      if bError then
                                                        Break
                                                      else
                                                        begin
                                                          LogThis('Получение очередной строки выборки ('+IntToStr(iSourceRowCounter)+').', LogGroupGUID, lmtDebug);
                                                          ResultRow:=mysql_fetch_row(ResultSet);
                                                          if ResultRow=nil then
                                                            Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iSourceRowCounter)+')!', sErrorMessage, bError)
                                                          else
                                                            begin
                                                              LogThis('Операция получения очередной строки выборки ('+IntToStr(iSourceRowCounter)+') прошла успешно.', LogGroupGUID, lmtDebug);

                                                              // Вставка очередной строки данных в таблицу на STATSERVER
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
                                                                Routines_GenerateError('Количество обработанных строк ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (1)!', sErrorMessage, bError);

                                                              // Проверка очередной вставленной в таблицу на STATSERVER строки данных
                                                              if not bError then
                                                                begin
                                                                  LogThis('>> Выполняется операция проверки данных, внесённых в таблицу '+LowerCase(slXRDMissedList[iMissedListCounter])+'...', LogGroupGUID, lmtDebug);
                                                                  if not Configuration.StatServer.bConnected then
                                                                    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                                                  else
                                                                    begin
                                                                      if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                                                        Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
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
                                                                            Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                                                                          else
                                                                            begin
                                                                              LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                                                              ResultSet2:=mysql_store_result(Configuration.StatServer.hConnection);
                                                                              if ResultSet2=nil then
                                                                                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                                                              else
                                                                                begin
                                                                                LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                                                                iRoutineCounter:=mysql_num_rows(ResultSet2);
                                                                                LogThis('Количество строк выборки равно '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                                                                if iRoutineCounter<0 then
                                                                                Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                if iRoutineCounter<=0 then
                                                                                Routines_GenerateError('Количество строк выборки ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (>0)!', sErrorMessage, bError)
                                                                                else
                                                                                begin
                                                                                LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                                                                LogThis('Проверка данных, внесённых в таблицу '+LowerCase(slXRDMissedList[iMissedListCounter])+' выполнена успешно.', LogGroupGUID, lmtDebug);
                                                                                end;
                                                                                end;
                                                                                mysql_free_result(ResultSet2);
                                                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                                                                end;
                                                                            end;
                                                                        end;
                                                                    end;
                                                                  LogThis('<< Выполнение операции проверки данных, внесённых в таблицу '+LowerCase(slXRDMissedList[iMissedListCounter])+' завершено.', LogGroupGUID, lmtDebug);
                                                                end;
                                                              StepProgressBar;
                                                            end;
                                                        end;
                                                  end;
                                                mysql_free_result(ResultSet);
                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                              end;
                                          end;
                                      end;
                                  end;
                                LogThis('<< Выполнение операции получения записей таблицы данных "'+LowerCase(slXRDMissedList[iMissedListCounter])+'" завершено.', LogGroupGUID, lmtDebug);
                                StepProgressBar;
                              end;

                            // Финальное сравнение количества строк в таблицах
                            // Получение количества строк в таблице на сервере STATSERVER
                            if not bError then
                              begin
                                LogThis('>> Выполняется операция получения количества записей таблицы данных "'+LowerCase(slXRDMissedList[iMissedListCounter])+'"...', LogGroupGUID, lmtDebug);
                                if not Configuration.StatServer.bConnected then
                                  Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                else
                                  begin
                                    if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        q:='SELECT COUNT(*) FROM '+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+';';
                                        LogThis(q, LogGroupGUID, lmtSQL);
                                        if mysql_real_query(Configuration.StatServer.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                                          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                            ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
                                            if ResultSet=nil then
                                              Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                                iRoutineCounter:=mysql_num_rows(ResultSet);
                                                LogThis('Количество строк выборки равно '+IntToStr(iRoutineCounter)+'.', LogGroupGUID, lmtDebug);
                                                if iRoutineCounter<0 then
                                                  Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    if iRoutineCounter<>1 then
                                                      Routines_GenerateError('Количество строк выборки ('+IntToStr(iRoutineCounter)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            iRowCountDestination:=StrToIntDef(string(ResultRow[0]), -1);
                                                            if iRowCountDestination=-1 then
                                                              Routines_GenerateError('Не удалось произвести конвертацию полученного количества таблицы данных!', sErrorMessage, bError)
                                                            else
                                                              begin
                                                                LogThis('Получение количества записей таблицы данных получено успешно.', LogGroupGUID, lmtDebug);
                                                                LogThis('Количество строк таблицы данных составляет: '+IntToStr(iRowCountDestination)+'.', LogGroupGUID, lmtDebug);
                                                              end;
                                                          end;
                                                      end;
                                                  end;
                                                mysql_free_result(ResultSet);
                                                LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                              end;
                                          end;
                                      end;
                                  end;
                                LogThis('<< Выполнение операции получения количества записей таблицы данных "'+LowerCase(slXRDMissedList[iMissedListCounter])+'" завершено.', LogGroupGUID, lmtDebug);
                                StepProgressBar;
                              end;

                            if not bError then
                              begin
                                // Процесс сравнения количества строк
                                LogThis('>> Выполняется операция сравнения количества записей таблиц данных...', LogGroupGUID, lmtDebug);
                                if iRowCountDestination<>iRowCountSource then
                                  Routines_GenerateError('Количество записей ('+IntToStr(iRowCountSource)+') в исходной таблице данных ('+sDBSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+') отличается от количества записей ('
                                    +IntToStr(iRowCountDestination)+') в результирующей таблице данных ('+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDMissedList[iMissedListCounter])+')!', sErrorMessage, bError)
                                else
                                  LogThis('Количество записей таблиц данных совпадает ('+IntToStr(iRowCountSource)+').', LogGroupGUID, lmtDebug);
                                LogThis('<< Выполнение операции сравнения количества записей таблиц данных завершено.', LogGroupGUID, lmtDebug);
                                StepProgressBar;

                                if not bError then
                                  begin
                                    // Разблокирование таблиц на DBSERVER
                                    MySQL_UnlockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                                    StepProgressBar;

                                    if not bError then
                                      begin
                                        // Разблокирование таблиц на STATSERVER
                                        MySQL_UnlockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
                                        StepProgressBar;
                                      end;
                                  end;
                              end;
                          end;
                    end;

                  // Отключение от DBSERVER, даже в случае ошибки
                  MySQL_CloseConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                  StepProgressBar;
                end;
            finally
              slXRDMissedList.Free;
            end;
          end;

        // если нужно (пере)формировать таблицу xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
        if (((not bXRDATableExists)and bCreateXRDA)or bRecreateXRDA)and(not bError) then
          begin
            // Удаление таблицы xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] при её наличии
            if bXRDATableExists and bRecreateXRDA then
              begin
                MySQL_DropTable(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, //
                  'DROP TABLE IF EXISTS '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+';');
              end;
            StepProgressBar;

            if not bError then
              begin
                // Создание таблицы xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] на основе структуры таблицы xrd_yyyymmdd
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
                    // Блокирование таблиц на STATSERVER на запись
                    // Составление списка блокируемых таблиц
                    sLockQuery:=sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' WRITE';
                    for iRoutineCounter:=0 to slXRDFullList.Count-1 do
                      sLockQuery:=sLockQuery+', '+sSTATSERVER_XRD_Location+'.'+slXRDFullList[iRoutineCounter]+' READ';
                    // Непосредственно блокирование таблиц
                    MySQL_LockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, sLockQuery);
                    StepProgressBar;

                    if not bError then
                      begin
                        // Проверка наличия таблицы xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
                        MySQL_CheckTableExistance(LogGroupGUID, Configuration.StatServer, sSTATSERVER_XRDA_Location, bError, sErrorMessage, LowerCase(sXRDATableName));
                        StepProgressBar;

                        if not bError then
                          begin
                            // Внесение всех данных из таблиц xrd_<yyyymmdd> в таблицу xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
                            for iFullListCounter:=0 to slXRDFullList.Count-1 do
                              if bError then
                                Break
                              else
                                begin
                                  // Вставка данных из очередной таблицы xrd_<yyyymmdd> в таблицу xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
                                  MySQL_InsertRecords(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, //
                                    'INSERT INTO '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' ' //
                                    +'SELECT * ' //
                                    +'FROM '+sSTATSERVER_XRD_Location+'.'+LowerCase(slXRDFullList[iFullListCounter])+';'); //
                                end;
                            StepProgressBar;

                            { TODO -cБудущие разработки : в случае необходимости дописать кусок кода }
                            // Получение суммарного количества строк в таблицах-источниках xrd_<yyyymmdd> и количества строк в таблице-приёмнике xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]]
                            // Финальное сравнение количества вставленных в таблицу xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] строк

                            // Разблокирование таблиц на STATSERVER
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

  // Отключение от STATSERVER, даже в случае ошибки
  MySQL_CloseConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
  StepProgressBar;

  // Вывод сообщения об успешном завершении операции, если не задан флаг молчания
  if (not bError)and(not aSilentYes) then
    begin
      Application.ProcessMessages;
      sMessage:='Действие выполнено успешно.';
      if bRecreateXRD then
        sMessage:=sMessage+sLineBreak+'Таблицы '+sSTATSERVER_XRD_Location+'.'+cXRDPrefix+'rd_<yyyymmdd> были успешно переформированы на сервере '+Configuration.StatServer.sMySQLHost+'.'
      else
        sMessage:=sMessage+sLineBreak+'Наличие таблиц '+sSTATSERVER_XRD_Location+'.'+cXRDPrefix+'rd_<yyyymmdd> на сервере '+Configuration.StatServer.sMySQLHost+' успешно проверено.';
      if bCreateXRDA and bXRDATableExists and(not bRecreateXRDA) then
        sMessage:=sMessage+sLineBreak+'Наличие таблицы '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' на сервере '+Configuration.StatServer.sMySQLHost+' успешно проверено.';
      if bCreateXRDA and(not bXRDATableExists) then
        sMessage:=sMessage+sLineBreak+'Таблица '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' была успешно сформирована на сервере '+Configuration.StatServer.sMySQLHost+'.';
      if bRecreateXRDA and bXRDATableExists then
        sMessage:=sMessage+sLineBreak+'Таблица '+sSTATSERVER_XRDA_Location+'.'+LowerCase(sXRDATableName)+' была успешно переформирована на сервере '+Configuration.StatServer.sMySQLHost+'.';
      MessageBox(Handle, PWideChar(sMessage), PWideChar('OVERSEER - Информация'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
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
  ProcedureHeader('Процедура обновления списка пользователей БД услуги "Отдых и развлечения"', LogGroupGUID);

  InitProgressBar(6); // 0
  // подключаемся к MySQL-серверу, на котором находится таблица пользователей БД rne4
  MySQL_OpenConnection(LogGroupGUID, Configuration.RNE4Server, bError, sErrorMessage);
  StepProgressBar; // 1

  if not bError then
    begin
      // проверка наличия таблицы пользователей в базе данных
      MySQL_CheckTableExistance(LogGroupGUID, Configuration.RNE4Server, Configuration.RNE4Server.sMySQLDatabase, bError, sErrorMessage, '_usr');
      StepProgressBar; // 2

      if not bError then
        begin
          // блокирование таблицы
          MySQL_LockTables(LogGroupGUID, Configuration.RNE4Server, bError, sErrorMessage, Configuration.RNE4Server.sMySQLDatabase+'._usr READ');
          StepProgressBar; // 3

          if not bError then
            begin
              // получение данных пользователей и заполнение списка
              LogThis('>> Выполняется операция получения данных пользователей и заполнение списка...', LogGroupGUID, lmtDebug);
              if not Configuration.RNE4Server.bConnected then
                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
              else
                begin
                  if mysql_ping(Configuration.RNE4Server.hConnection)<>0 then
                    Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
                  else
                    begin
                      q:='SELECT DISTINCT usr_fullname ' //
                        +'FROM '+Configuration.RNE4Server.sMySQLDatabase+'._usr ' //
                        +'WHERE usr_erased="0" ' //
                        +'ORDER BY usr_fullname;'; //
                      LogThis(q, LogGroupGUID, lmtSQL);
                      if mysql_real_query(Configuration.RNE4Server.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
                        Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                      else
                        begin
                          LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                          ResultSet:=mysql_store_result(Configuration.RNE4Server.hConnection);
                          if ResultSet=nil then
                            Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                          else
                            begin
                              LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                              iRowQuantity:=mysql_num_rows(ResultSet);
                              LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                              if iRowQuantity<0 then
                                Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                              else
                                begin
                                  LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                  clbUsers_SIC_04.Items.BeginUpdate;
                                  clbUsers_SIC_04.Clear;
                                  for iRowCounter:=0 to iRowQuantity-1 do
                                    if bError then
                                      Break
                                    else
                                      begin
                                        LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                        ResultRow:=mysql_fetch_row(ResultSet);
                                        if ResultRow=nil then
                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                        else
                                          begin
                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', LogGroupGUID, lmtDebug);
                                            clbUsers_SIC_04.Items.Add(string(ResultRow[0]));
                                          end;
                                      end;
                                  clbUsers_SIC_04.Items.EndUpdate;
                                end;
                              mysql_free_result(ResultSet);
                              LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                            end;
                        end;
                    end;
                end;
              LogThis('<< Выполнение операции получения данных пользователей и заполнение списка завершено.', LogGroupGUID, lmtDebug);
              StepProgressBar; // 4

              if not bError then
                begin
                  // разблокирование таблиц
                  MySQL_UnlockTables(LogGroupGUID, Configuration.RNE4Server, bError, sErrorMessage);
                  StepProgressBar; // 5
                end;
            end;
        end;
      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
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
  ProcedureHeader('Процедура обновления состояния кнопок дополнительных параметров действия', LogGroupGUID);

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
  ProcedureHeader('Процедура обновления состояния кнопок дополнительных параметров действия', LogGroupGUID);

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
  ProcedureHeader('Процедура обновления списка звонков на службы СИЦ', LogGroupGUID);

  wStartDay:=0;
  wStartMonth:=0;
  wStartYear:=0;
  wStopDay:=0;
  wStopMonth:=0;
  wStopYear:=0;

  lvPhonesList_Payoff.Items.BeginUpdate;
  lvPhonesList_Payoff.Clear;
  lvPhonesList_Payoff.Items.EndUpdate;

  // расчёт выбранного временного периода
  LogThis('>> Выполняется операция расчёта выбранного временного периода...', LogGroupGUID, lmtDebug);
  if not(rbLastDate.Checked or rbChoisenDate.Checked or rbLastWeek.Checked or rbLastMonth.Checked or rbChoisenMonth.Checked or rbLastQuarter.Checked or rbChoisenQuarter.Checked or rbLastYear.Checked or rbChoisenYear.Checked or rbChoisenPeriod.Checked)
  then
    Routines_GenerateError('Не был выбран период!', sErrorMessage, bError)
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
          if dtpChoisenPeriod_Start.Date>dtpChoisenPeriod_Stop.Date then
            Routines_GenerateError('Выбранная начальная дата ('+FormatDateTime('dd.mm.yyyy', dtpChoisenPeriod_Start.Date)+') больше, чем конечная ('+FormatDateTime('dd.mm.yyyy', dtpChoisenPeriod_Stop.Date)+')!', sErrorMessage, bError)
          else
            begin
              wStartDay:=DayOf(dtpChoisenPeriod_Start.Date);
              wStartMonth:=MonthOf(dtpChoisenPeriod_Start.Date);
              wStartYear:=YearOf(dtpChoisenPeriod_Start.Date);
              wStopDay:=DayOf(dtpChoisenPeriod_Stop.Date);
              wStopMonth:=MonthOf(dtpChoisenPeriod_Stop.Date);
              wStopYear:=YearOf(dtpChoisenPeriod_Stop.Date);
            end;
        end;
      if rbChoisenMonth.Checked then
        begin
          iYear:=StrToIntDef(cbChoisenMonth_Year.Items[cbChoisenMonth_Year.ItemIndex], -1);
          if iYear=-1 then
            Routines_GenerateError('Не удалось произвести конвертацию выбраного года!', sErrorMessage, bError)
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
                Routines_GenerateError('Не удалось произвести конвертацию выбраного года!', sErrorMessage, bError)
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
                Routines_GenerateError('Не удалось произвести конвертацию выбраного года!', sErrorMessage, bError)
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
  LogThis('<< Выполнение операции расчёта выбранного временного периода завершено.', LogGroupGUID, lmtDebug);

  if not bError then
    begin
      aStartDate:=EncodeDate(wStartYear, wStartMonth, wStartDay);
      aStopDate:=EncodeDate(wStopYear, wStopMonth, wStopDay);

      // валидация временного периода
      if (aStartDate>ToDay)or(aStopDate>ToDay) then
        if aStartDate>ToDay then
          Routines_GenerateError('Начальная дата больше текущей даты!', sErrorMessage, bError)
        else
          Routines_GenerateError('Конечная дата больше текущей даты!', sErrorMessage, bError)
      else
        if aStopDate<aStartDate then
          Routines_GenerateError('Начальная дата больше конечной даты!', sErrorMessage, bError);

      if not bError then
        begin
          // проверка на текущий день в выборке
          if SameDate(ToDay, aStopDate) then
            begin
              if SameDate(ToDay, aStartDate) then
                begin
                  // выборка только за текущий день
                  bNeedToConnectToSTATSERVER:=False;
                  bNeedToConnectToDBSERVER:=True;
                end
              else
                begin
                  // выборка за промежуток с ... по текущий день
                  bNeedToConnectToSTATSERVER:=True;
                  bNeedToConnectToDBSERVER:=True;
                end;
            end
          else
            begin
              // выборка с... по... только за прошедшие дни
              bNeedToConnectToSTATSERVER:=True;
              bNeedToConnectToDBSERVER:=False;
            end;

          // создание списка номеров телефонов
          slPhonesList:=TStringList.Create;
          try
            Routines_CutStringByLimiterToStringList(Trim(ebPhonesList_Payoff.Text), slPhonesList, ' ');

            slIRDFullList:=TStringList.Create;
            try
              // создание списка имён исходных таблиц данных
              LogThis('>> Выполняется операция составления списка таблиц входящих звонков...', LogGroupGUID, lmtDebug);
              dtDate:=aStartDate;
              repeat
                slIRDFullList.Add('ird_'+FormatDateTime('yyyymmdd', dtDate));
                dtDate:=IncDay(dtDate, 1);
              until dtDate>aStopDate;
              // если в списке присутствует текущая дата, убираем её из списка
              if bNeedToConnectToDBSERVER then
                slIRDFullList.Delete(slIRDFullList.Count-1);
              LogThis('Финальное количество строк списка таблиц данных равно '+IntToStr(slIRDFullList.Count)+'.', LogGroupGUID, lmtDebug);
              LogThis('<< Выполнение операции составления списка таблиц входящих звонков завершено.', LogGroupGUID, lmtDebug);

              if bNeedToConnectToSTATSERVER then
                begin
                  // подключаемся к MySQL-серверу STATSERVER
                  MySQL_OpenConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);

                  if not bError then
                    begin
                      // действия по выборке
                      for iFullListCounter:=0 to slIRDFullList.Count-1 do
                        if bError then
                          Break
                        else
                          begin
                            // проверка наличия таблицы в базе данных
                            MySQL_CheckTableExistance(LogGroupGUID, Configuration.StatServer, Configuration.StatServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, LowerCase(slIRDFullList[iFullListCounter]));

                            if not bError then
                              begin
                                // блокирование таблицы
                                MySQL_LockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage, Configuration.StatServer.sMySQLDatabase_IRD_Location+'.'+LowerCase(slIRDFullList[iFullListCounter])+' READ');

                                if not bError then
                                  begin
                                    // получение данных и заполнение списка
                                    LogThis('>> Выполняется операция получения данных и заполнение списка...', LogGroupGUID, lmtDebug);
                                    if not Configuration.StatServer.bConnected then
                                      Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                    else
                                      begin
                                        if mysql_ping(Configuration.StatServer.hConnection)<>0 then
                                          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
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
                                              Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                                            else
                                              begin
                                                LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                                ResultSet:=mysql_store_result(Configuration.StatServer.hConnection);
                                                if ResultSet=nil then
                                                  Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                                    iRowQuantity:=mysql_num_rows(ResultSet);
                                                    LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                                    if iRowQuantity<0 then
                                                      Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                    else
                                                      begin
                                                        LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                                        lvPhonesList_Payoff.Items.BeginUpdate;
                                                        // lvPhonesList_Payoff.AllocBy:=iRowQuantity-1;
                                                        for iRowCounter:=0 to iRowQuantity-1 do
                                                          if bError then
                                                            Break
                                                          else
                                                            begin
                                                              LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                              ResultRow:=mysql_fetch_row(ResultSet);
                                                              if ResultRow=nil then
                                                                Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                                              else
                                                                begin
                                                                  LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', LogGroupGUID, lmtDebug);
                                                                  ListItem:=lvPhonesList_Payoff.Items.Add;
                                                                  ListItem.ImageIndex:=2;
                                                                  ListItem.Caption:=string(ResultRow[0]);
                                                                  ListItem.SubItems.Add(string(ResultRow[1]));
                                                                  ListItem.SubItems.Add(string(ResultRow[2]));
                                                                  ListItem.SubItems.Add(string(ResultRow[3]));
                                                                  ListItem.SubItems.Add(string(ResultRow[4]));
                                                                  ListItem.SubItems.Add(string(ResultRow[5]));
                                                                  ListItem.SubItems.Add(Routines_GetConditionalMessage(string(ResultRow[6])='1', 'Да', Routines_GetConditionalMessage(string(ResultRow[6])='0', 'Нет', 'Ошибка!')));
                                                                  ListItem.SubItems.Add(string(ResultRow[7]));
                                                                  ListItem.SubItems.Add(string(ResultRow[8]));
                                                                  ListItem.SubItems.Add(string(ResultRow[9]));
                                                                end;
                                                            end;
                                                        lvPhonesList_Payoff.Items.EndUpdate;
                                                      end;
                                                    mysql_free_result(ResultSet);
                                                    LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                                  end;
                                              end;
                                          end;
                                      end;
                                    LogThis('<< Выполнение операции получения данных и заполнение списка завершено.', LogGroupGUID, lmtDebug);

                                    // разблокирование таблиц
                                    if not bError then
                                      MySQL_UnlockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
                                  end;
                              end;
                          end;

                      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
                      MySQL_CloseConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
                    end;
                end;
            finally
              slIRDFullList.Free;
            end;

            if not bError then
              if bNeedToConnectToDBSERVER then
                begin
                  // подключение к MySQL-серверу DBSERVER
                  MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);

                  // действия по выборке
                  if not bError then
                    begin
                      // проверка наличия таблицы в базе данных
                      MySQL_CheckTableExistance(LogGroupGUID, Configuration.DBServer, Configuration.DBServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, 'ird_'+FormatDateTime('yyyymmdd', aStopDate));

                      if not bError then
                        begin
                          // блокирование таблицы
                          // MySQL_LockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage, Configuration.DBServer.sMySQLDatabase_IRD_Location+'.ird_'+FormatDateTime('yyyymmdd', aStopDate)+' READ');

                          if not bError then
                            begin
                              // получение данных и заполнение списка
                              LogThis('>> Выполняется операция получения данных и заполнение списка...', LogGroupGUID, lmtDebug);
                              if not Configuration.DBServer.bConnected then
                                Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                              else
                                begin
                                  if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                                    Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
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
                                        Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                                      else
                                        begin
                                          LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                          ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                          if ResultSet=nil then
                                            Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                          else
                                            begin
                                              LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                              iRowQuantity:=mysql_num_rows(ResultSet);
                                              LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                              if iRowQuantity<0 then
                                                Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                              else
                                                begin
                                                  LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                                  lvPhonesList_Payoff.Items.BeginUpdate;
                                                  // lvPhonesList_Payoff.AllocBy:=iRowQuantity-1;
                                                  for iRowCounter:=0 to iRowQuantity-1 do
                                                    if bError then
                                                      Break
                                                    else
                                                      begin
                                                        LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                        ResultRow:=mysql_fetch_row(ResultSet);
                                                        if ResultRow=nil then
                                                          Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                                        else
                                                          begin
                                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', LogGroupGUID, lmtDebug);
                                                            ListItem:=lvPhonesList_Payoff.Items.Add;
                                                            ListItem.ImageIndex:=2;
                                                            ListItem.Caption:=string(ResultRow[0]);
                                                            ListItem.SubItems.Add(string(ResultRow[1]));
                                                            ListItem.SubItems.Add(string(ResultRow[2]));
                                                            ListItem.SubItems.Add(string(ResultRow[3]));
                                                            ListItem.SubItems.Add(string(ResultRow[4]));
                                                            ListItem.SubItems.Add(string(ResultRow[5]));
                                                            ListItem.SubItems.Add(Routines_GetConditionalMessage(string(ResultRow[6])='1', 'Да', Routines_GetConditionalMessage(string(ResultRow[6])='0', 'Нет', 'Ошибка!')));
                                                            ListItem.SubItems.Add(string(ResultRow[7]));
                                                            ListItem.SubItems.Add(string(ResultRow[8]));
                                                            ListItem.SubItems.Add(string(ResultRow[9]));
                                                          end;
                                                      end;
                                                  lvPhonesList_Payoff.Items.EndUpdate;
                                                end;
                                              mysql_free_result(ResultSet);
                                              LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                            end;
                                        end;
                                    end;
                                end;
                              LogThis('<< Выполнение операции получения данных и заполнение списка завершено.', LogGroupGUID, lmtDebug);

                              if not bError then
                                begin
                                  // разблокирование таблиц
                                  // MySQL_UnlockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                                end;
                            end;
                        end;

                      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
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
  ProcedureHeader('Процедура обновления состояния кнопок дополнительных параметров действия', LogGroupGUID);

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
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);

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

  cbService_SIC_06.Clear;
  cbService_SIC_06.Items.BeginUpdate;
  for i:=0 to aServices_Count-1 do
    cbService_SIC_06.Items.Add(aServices[i].sNumber+' - '+aServices[i].sName);
  cbService_SIC_06.Items.EndUpdate;

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
  ProcedureHeader('Процедура обновления состояния кнопок дополнительных параметров действия', LogGroupGUID);

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
  ProcedureHeader('Процедура обновления состояния кнопок дополнительных параметров действия', LogGroupGUID);

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
  ProcedureHeader('Процедура обновления списка пользователей', LogGroupGUID);

  bError:=False;
  wStartDay:=0;
  wStartMonth:=0;
  wStartYear:=0;
  wStopDay:=0;
  wStopMonth:=0;
  wStopYear:=0;

  // расчёт выбранного временного периода
  LogThis('>> Выполняется операция расчёта выбранного временного периода...', LogGroupGUID, lmtDebug);
  if not(rbLastDate.Checked or rbChoisenDate.Checked or rbLastWeek.Checked or rbLastMonth.Checked or rbChoisenMonth.Checked or rbLastQuarter.Checked or rbChoisenQuarter.Checked or rbLastYear.Checked or rbChoisenYear.Checked or rbChoisenPeriod.Checked)
  then
    Routines_GenerateError('Не был выбран период!', sErrorMessage, bError)
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
          if dtpChoisenPeriod_Start.Date>dtpChoisenPeriod_Stop.Date then
            Routines_GenerateError('Выбранная начальная дата ('+FormatDateTime('dd.mm.yyyy', dtpChoisenPeriod_Start.Date)+') больше, чем конечная ('+FormatDateTime('dd.mm.yyyy', dtpChoisenPeriod_Stop.Date)+')!', sErrorMessage, bError)
          else
            begin
              wStartDay:=DayOf(dtpChoisenPeriod_Start.Date);
              wStartMonth:=MonthOf(dtpChoisenPeriod_Start.Date);
              wStartYear:=YearOf(dtpChoisenPeriod_Start.Date);
              wStopDay:=DayOf(dtpChoisenPeriod_Stop.Date);
              wStopMonth:=MonthOf(dtpChoisenPeriod_Stop.Date);
              wStopYear:=YearOf(dtpChoisenPeriod_Stop.Date);
            end;
        end;
      if rbChoisenMonth.Checked then
        begin
          iYear:=StrToIntDef(cbChoisenMonth_Year.Items[cbChoisenMonth_Year.ItemIndex], -1);
          if iYear=-1 then
            Routines_GenerateError('Не удалось произвести конвертацию выбраного года!', sErrorMessage, bError)
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
                Routines_GenerateError('Не удалось произвести конвертацию выбраного года!', sErrorMessage, bError)
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
                Routines_GenerateError('Не удалось произвести конвертацию выбраного года!', sErrorMessage, bError)
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
  LogThis('<< Выполнение операции расчёта выбранного временного периода завершено.', LogGroupGUID, lmtDebug);

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
        Routines_GenerateError('Не удалось идентифицировать выбранную группу пользователей!', sErrorMessage, bError);
      end;

      if not bError then
        begin
          InitProgressBar(6); // 0
          // подключаемся к MySQL-серверу, на котором находится таблица пользователей БД rne4
          MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
          StepProgressBar; // 1

          if not bError then
            begin
              // проверка наличия таблицы пользователей в базе данных
              MySQL_CheckTableExistance(LogGroupGUID, Configuration.DBServer, Configuration.DBServer.sMySQLDatabase_T_DAY_Location, bError, sErrorMessage, 't_day');
              StepProgressBar; // 2

              if not bError then
                begin
                  // блокирование таблицы
                  MySQL_LockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage, Configuration.DBServer.sMySQLDatabase_T_DAY_Location+'.t_day READ');
                  StepProgressBar; // 3

                  if not bError then
                    begin
                      // получение данных пользователей и заполнение списка
                      LogThis('>> Выполняется операция получения данных пользователей и заполнение списка...', LogGroupGUID, lmtDebug);
                      if not Configuration.DBServer.bConnected then
                        Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                      else
                        begin
                          if mysql_ping(Configuration.DBServer.hConnection)<>0 then
                            Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
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
                                Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                              else
                                begin
                                  LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                  ResultSet:=mysql_store_result(Configuration.DBServer.hConnection);
                                  if ResultSet=nil then
                                    Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                  else
                                    begin
                                      LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                      iRowQuantity:=mysql_num_rows(ResultSet);
                                      LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                      if iRowQuantity<0 then
                                        Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                      else
                                        begin
                                          LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                          clbUsers_SIC_10.Items.BeginUpdate;
                                          clbUsers_SIC_10.Clear;
                                          for iRowCounter:=0 to iRowQuantity-1 do
                                            if bError then
                                              Break
                                            else
                                              begin
                                                LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                if ResultRow=nil then
                                                  Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', LogGroupGUID, lmtDebug);
                                                    clbUsers_SIC_10.Items.Add(string(ResultRow[0]));
                                                  end;
                                              end;
                                          clbUsers_SIC_10.Items.EndUpdate;
                                        end;
                                      mysql_free_result(ResultSet);
                                      LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                    end;
                                end;
                            end;
                        end;
                      LogThis('<< Выполнение операции получения данных пользователей и заполнение списка завершено.', LogGroupGUID, lmtDebug);
                      StepProgressBar; // 4

                      if not bError then
                        begin
                          // разблокирование таблиц
                          MySQL_UnlockTables(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                          StepProgressBar; // 5
                        end;
                    end;
                end;
              // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
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
  ProcedureHeader('Процедура реакции на переключение полного/выборочного режима списка пользователей', LogGroupGUID);

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
  ProcedureHeader('Процедура реакции на переключение параметров списка пользователей', LogGroupGUID);

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
  sModalWinName: string='ввода логина и пароля пользователя';
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
  ProcedureHeader('Процедура начала сеанса работы пользователя', LogGroupGUID);
  bError:=False;

  // получение логина и пароля пользователя
  LogThis('>> Выполняется операция получения логина и пароля пользователя...', LogGroupGUID, lmtDebug);
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
  LogThis('<< Выполнение операции получения логина и пароля пользователя завершено.', LogGroupGUID, lmtDebug);

  // если были введены логин и пароль пользователя
  if mr<>mrOk then
    LogThis('Авторизация пользователя не была выполнена!', LogGroupGUID, lmtInfo)
  else
    begin
      InitProgressBar(11);
      // подключаемся к MySQL-серверу, на котором находится таблица пользователей
      MySQL_OpenConnection(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage);
      StepProgressBar; // 1

      if not bError then
        begin
          // проверяем наличие таблицы пользователей в базе данных
          MySQL_CheckTableExistance(LogGroupGUID, Configuration.OverseerServer, Configuration.OverseerServer.sMySQLDatabase, bError, sErrorMessage, '_users');
          StepProgressBar; // 2

          if not bError then
            begin
              // блокирование таблицы
              MySQL_LockTables(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage, Configuration.OverseerServer.sMySQLDatabase+'._users READ');
              StepProgressBar; // 3

              // проверка данных пользователя по базе данных
              if not bError then
                with Configuration.OverseerServer, CurrentUser do
                  begin
                    LogThis('>> Выполняется операция получения данных указанного пользователя...', LogGroupGUID, lmtDebug);
                    if not bConnected then
                      Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                    else
                      begin
                        if mysql_ping(hConnection)<>0 then
                          Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
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
                              Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                            else
                              begin
                                LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                ResultSet:=mysql_store_result(hConnection);
                                if ResultSet=nil then
                                  Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                else
                                  begin
                                    LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                    i:=mysql_num_rows(ResultSet);
                                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.', LogGroupGUID, lmtDebug);
                                    if i<0 then
                                      Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                    else
                                      begin
                                        if i=0 then
                                          Routines_GenerateError('Пользователя с указанными логином и паролем не существует! '+sLineBreak+'Проверьте текущий язык ввода, состояние клавиши Caps Lock и правильность набора.', sErrorMessage, bError)
                                        else
                                          begin
                                            if i>1 then
                                              begin
                                                LogThis('Количество строк выборки ('+IntToStr(i)+')не соответствует требуемому (1)!', LogGroupGUID, lmtError);
                                                Routines_GenerateError('Найдено более одной учётной записи с указанными логином и паролем! Обратитесь к администратору!', sErrorMessage, bError);
                                              end
                                            else
                                              begin
                                                LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                                ResultRow:=mysql_fetch_row(ResultSet);
                                                if ResultRow=nil then
                                                  Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!', sErrorMessage, bError)
                                                else
                                                  begin
                                                    if ResultRow[1]='1' then
                                                      Routines_GenerateError('В настоящий момент данная учётная запись отключена! Обратитесь к администратору!', sErrorMessage, bError)
                                                    else
                                                      with CurrentUser do
                                                        begin
                                                          sID:=string(ResultRow[0]);
                                                          sFullName:=string(ResultRow[2]);
                                                          sPosition:=string(ResultRow[3]);
                                                          sContactPhone:=string(ResultRow[4]);
                                                          bIsAdmin:=string(ResultRow[5])='1';
                                                          LogThis('Данные пользователя получены успешно.', LogGroupGUID, lmtDebug);
                                                        end;
                                                  end;
                                              end;
                                          end;
                                      end;
                                    mysql_free_result(ResultSet);
                                    LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                  end;
                              end;
                          end;
                      end;
                    LogThis('<< Выполнение операции получения данных указанного пользователя завершено.', LogGroupGUID, lmtDebug);
                    StepProgressBar; // 4

                    // разблокирование таблиц
                    if not bError then
                      begin
                        MySQL_UnlockTables(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage);
                        StepProgressBar; // 5

                        // заполнение списка действий в соответствии с правами доступа текущего пользователя
                        if not bError then
                          begin
                            LogThis('>> Выполняется операция получения прав доступа текущего пользователя...', LogGroupGUID, lmtDebug);
                            cbActionsList.Clear;

                            // проверяем наличие таблицы действий в базе данных
                            MySQL_CheckTableExistance(LogGroupGUID, Configuration.OverseerServer, Configuration.OverseerServer.sMySQLDatabase, bError, sErrorMessage, '_actions');
                            StepProgressBar; // 6

                            if not bError then
                              begin
                                // проверяем наличие таблицы прав пользователей в базе данных
                                MySQL_CheckTableExistance(LogGroupGUID, Configuration.OverseerServer, Configuration.OverseerServer.sMySQLDatabase, bError, sErrorMessage, '_permissions');
                                StepProgressBar; // 7

                                if not bError then
                                  begin
                                    // блокирование таблиц
                                    MySQL_LockTables(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage, Configuration.OverseerServer.sMySQLDatabase+'._actions READ, _permissions READ');
                                    StepProgressBar; // 8

                                    // получение данных таблицы действий
                                    if not bError then
                                      with Configuration.OverseerServer do
                                        begin
                                          LogThis('>> Выполняется операция получения полного списка действий...', LogGroupGUID, lmtDebug);
                                          if not bConnected then
                                            Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
                                          else
                                            begin
                                              if mysql_ping(hConnection)<>0 then
                                                Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
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
                                                    Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
                                                  else
                                                    begin
                                                      LogThis('Запрос выполнен успешно.', LogGroupGUID, lmtDebug);
                                                      ResultSet:=mysql_store_result(hConnection);
                                                      if ResultSet=nil then
                                                        Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
                                                      else
                                                        begin
                                                          LogThis('Результирующая выборка получена успешно.', LogGroupGUID, lmtDebug);
                                                          iRowQuantity:=mysql_num_rows(ResultSet);
                                                          LogThis('Количество строк выборки равно '+IntToStr(iRowQuantity)+'.', LogGroupGUID, lmtDebug);
                                                          if iRowQuantity<0 then
                                                            Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                                                          else
                                                            begin
                                                              LogThis('Количество строк выборки соответствует требуемому.', LogGroupGUID, lmtDebug);
                                                              for iRowCounter:=0 to iRowQuantity-1 do
                                                                if bError then
                                                                  Break
                                                                else
                                                                  begin
                                                                    LogThis('Получение очередной строки выборки ('+IntToStr(iRowCounter)+').', LogGroupGUID, lmtDebug);
                                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                                    if ResultRow=nil then
                                                                      Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(iRowCounter)+')!', sErrorMessage, bError)
                                                                    else
                                                                      begin
                                                                        cbActionsList.Items.Add(string(ResultRow[0]));
                                                                        LogThis('Операция получения очередной строки выборки ('+IntToStr(iRowCounter)+') прошла успешно.', LogGroupGUID, lmtDebug);
                                                                      end;
                                                                  end;
                                                            end;
                                                          mysql_free_result(ResultSet);
                                                          LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', LogGroupGUID, lmtDebug);
                                                        end;
                                                    end;
                                                end;
                                            end;
                                          LogThis('<< Выполнение операции получения полного списка действий завершено.', LogGroupGUID, lmtDebug);
                                          StepProgressBar; // 9

                                          // разблокирование таблиц
                                          if not bError then
                                            begin
                                              MySQL_UnlockTables(LogGroupGUID, Configuration.OverseerServer, bError, sErrorMessage);
                                              StepProgressBar; // 10

                                              CurrentUser.bLogged:=True; // только в случае полного успеха логирования пользователя выставляем флаг логирования
                                              LogThis('Авторизация пользователя прошла успешно.', LogGroupGUID, lmtInfo);
                                              LogThis('Сеанс работы пользователя начат.', LogGroupGUID, lmtInfo);

                                              // выставление указанного в конфигурации действия по умолчанию
                                              cbActionsList.ItemIndex:=cbActionsList.Items.IndexOf(Configuration.sDefaultAction);
                                              if cbActionsList.ItemIndex<0 then
                                                cbActionsList.ItemIndex:=0;
                                              Do_SelectAction;
                                            end;
                                        end;
                                  end;

                              end;

                            LogThis('<< Выполнение операции получения прав доступа текущего пользователя завершено.', LogGroupGUID, lmtDebug);
                          end;
                      end;
                  end;
            end;
        end;

      // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
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
// LogThis('Замер времени выполнения действия начат.', aLogGroupGUID, lmtDebug);
// end;
//
// procedure TMainForm.Stop_ActionTimer(aLogGroupGUID: string);
// var
// TotalTime: LongWord;
// begin
// TotalTime:=DateTimeToTimeStamp(Now).Time-ttsActionStart.Time;
// LogThis('Время выполнения действия составило '+IntToStr(integer(TotalTime))+' мс.', aLogGroupGUID, lmtDebug);
// end;

procedure TMainForm.Refresh_BusyState(const aLogGroupGUID: string);
begin
  LogThis('Установлен режим "'+Routines_GetConditionalMessage(iBusyCounter>0, 'Занято', 'Готово')+'".', aLogGroupGUID, lmtDebug);
  if iBusyCounter>0 then
    ImageList1.GetIcon(ICON_BUSY, Image1.Picture.Icon)
  else
    ImageList1.GetIcon(ICON_READY, Image1.Picture.Icon);
  if not Configuration.bNoStatusBar then
    StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=Routines_GetConditionalMessage(iBusyCounter>0, 'Пожалуйста, подождите...', 'Готово');
  Application.ProcessMessages;
end;

procedure TMainForm.Inc_BusyState(const aLogGroupGUID: string);
begin
  iBusyCounter:=iBusyCounter+1;
  if iBusyCounter<0 then
    iBusyCounter:=0;
  Refresh_BusyState(aLogGroupGUID);
end;

procedure TMainForm.Dec_BusyState(const aLogGroupGUID: string);
begin
  iBusyCounter:=iBusyCounter-1;
  if iBusyCounter<0 then
    iBusyCounter:=0;
  Refresh_BusyState(aLogGroupGUID);
end;

procedure TMainForm.ShowErrorBox(const aHandle: HWND; const aErrorMessage: string; const aLogGroupGUID: string);
var
  iOldBusyCounter: integer;
begin
  LogThis(aErrorMessage, aLogGroupGUID, lmtError);

  iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
  Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора

  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar('OVERSEER - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  Application.ProcessMessages;

  iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
  Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
  Application.ProcessMessages;
end;

procedure TMainForm.Action_ProcessExecute(Sender: TObject);
const
  LogGroupGUID: string='{9B587CF1-98E3-4323-95CB-3DF29E155052}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Process.Caption+'"', LogGroupGUID);
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

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
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
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
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

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
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
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
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

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
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
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
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

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
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
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
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

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
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
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
    end;

  Do_SIC_05:=not bError;
end;

function TMainForm.Do_SIC_06(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean; const aServiceIndex: integer): boolean;
const
  LogGroupGUID: string='{BC065FDC-7748-44C2-88A9-70B44694FD09}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
  with TThread_Do_SIC_06.Create( //
    '{2902D8CC-B068-4A09-B4C0-4B5DDD418572}', //
    aStartDate, //
    aStopDate, //
    aOpenWithBrowser, //
    CurrentUser, //
    Configuration, //
    aServiceIndex //
    ) do //
    try
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
    end;

  Do_SIC_06:=not bError;
end;

function TMainForm.Do_SIC_08(const aStartDate, aStopDate: TDate; const aOpenWithBrowser: boolean): boolean;
const
  LogGroupGUID: string='{18C42AD9-6099-4D5C-8BC9-56F3B1C15115}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  bError:=False;

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
  with TThread_Do_SIC_08.Create( //
    '{D43A98B2-4615-4584-9FBE-8F3CB31C6958}', //
    aStartDate, //
    aStopDate, //
    aOpenWithBrowser, //
    CurrentUser, //
    Configuration //
    ) do //
    try
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
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

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
  with TThread_Do_SIC_10.Create('{1726AE8E-E2E2-4051-B375-8CC618EC7FBE}', aStartDate, aStopDate, aOpenWithBrowser, aAllUsers, aCalculateWeekFromMonday, aCreateDetailedReport, CurrentUser, Configuration, aCCID, aGroupByPeriod, aSelectedUserList) do
    try
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
    end;

  Do_SIC_10:=not bError;
end;

procedure TMainForm.cbSummaryReport_SIC_09Click(Sender: TObject);
const
  LogGroupGUID: string='{DCB28878-1DF5-4EAA-A757-8EF3EF7DE73E}';
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "'+cbSummaryReport_SIC_09.Caption+'"', LogGroupGUID);

  cbOldReport_SIC_09.Enabled:=not cbSummaryReport_SIC_09.Checked;
  if not cbOldReport_SIC_09.Enabled then
    cbOldReport_SIC_09.Checked:=False;
  LogThis('Флажок "'+cbSummaryReport_SIC_09.Caption+'" '+Routines_GetConditionalMessage(cbSummaryReport_SIC_09.Checked, 'включён', 'отключён')+'.', LogGroupGUID, lmtDebug);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.cbOldReport_SIC_09Click(Sender: TObject);
const
  LogGroupGUID: string='{96103B91-D537-423F-9398-53F33A6479CB}';
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "'+cbOldReport_SIC_09.Caption+'"', LogGroupGUID);

  cbSummaryReport_SIC_09.Enabled:=not cbOldReport_SIC_09.Checked;
  if not cbSummaryReport_SIC_09.Enabled then
    cbSummaryReport_SIC_09.Checked:=False;
  LogThis('Флажок "'+cbOldReport_SIC_09.Caption+'" '+Routines_GetConditionalMessage(cbOldReport_SIC_09.Checked, 'включён', 'отключён')+'.', LogGroupGUID, lmtDebug);

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

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
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
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
    end;

  Do_SIC_09:=not bError;
end;

procedure TMainForm.MySQL_UnlockTables(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
var
  q: string;
begin
  LogThis('>> Выполняется операция разблокирования всех ранее заблокированных таблиц базы данных...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          q:='UNLOCK TABLES;';
          LogThis(q, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
            Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
          else
            LogThis('Запрос выполнен успешно.', aLogGroupGUID, lmtDebug);
        end;
    end;
  LogThis('<< Выполнение операции разблокирования таблиц базы данных завершено.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.MySQL_CloseConnection(const aLogGroupGUID: string; var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
begin
  with aTMySQLServerConnectionDetails do
    begin
      if bConnected then
        begin
          LogThis('>> Выполняется операция отключения от MySQL-сервера '+sMySQLHost+'...', aLogGroupGUID, lmtDebug);
          if hConnection<>nil then
            begin
              mysql_close(hConnection);
              hConnection:=nil;
            end;
          bConnected:=False;
          LogThis('Отключение от MySQL-сервера '+sMySQLHost+' выполнено успешно.', aLogGroupGUID, lmtDebug);
          LogThis('<< Выполнение операции отключения от MySQL-сервера '+sMySQLHost+' завершено.', aLogGroupGUID, lmtDebug);
        end;
    end;
end;

procedure TMainForm.MySQL_LockTables(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aTablesList: string);
var
  q: string;
begin
  LogThis('>> Выполняется операция блокировки таблицы базы данных...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          q:='LOCK TABLE '+aTablesList+';';
          LogThis(q, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
            Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
          else
            LogThis('Запрос выполнен успешно.', aLogGroupGUID, lmtDebug);
        end;
    end;
  LogThis('<< Выполнение операции блокировки таблицы базы данных завершено.', aLogGroupGUID, lmtDebug);
end;

function TMainForm.MySQL_UpdateRecords(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
begin
  Result:=-1;
  LogThis('>> Выполняется операция обновления данных таблицы...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          LogThis(aQuery, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
            Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
          else
            begin
              LogThis('Запрос выполнен успешно.', aLogGroupGUID, lmtDebug);
              Result:=mysql_affected_rows(aTMySQLServerConnectionDetails.hConnection);
              LogThis('Количество обработанных строк равно '+IntToStr(Result)+'.', aLogGroupGUID, lmtDebug);
              if Result<0 then
                Routines_GenerateError('Количество обработанных строк ('+IntToStr(Result)+') не соответствует требуемому (>=0)!', sErrorMessage, bError)
              else
                LogThis('Обновление данных выполнено успешно.', aLogGroupGUID, lmtDebug);
            end;
        end;
    end;
  LogThis('<< Выполнение операции обновления данных таблицы завершено.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.MySQL_OpenConnection(const aLogGroupGUID: string; var aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string);
begin
  with aTMySQLServerConnectionDetails do
    begin
      LogThis('>> Выполняется операция подключения к MySQL-серверу '+sMySQLHost+'...', aLogGroupGUID, lmtDebug);
      if bConnected then
        Routines_GenerateError('Была предпринята попытка подключения к подключенному в настоящий момент серверу MySQL!', sErrorMessage, bError)
      else
        begin
          hConnection:=mysql_init(nil);
          if hConnection=nil then
            Routines_GenerateError('Возникла ошибка при инициализации объекта соединения с сервером MySQL!', sErrorMessage, bError)
          else
            begin
              LogThis('Инициализация объекта соединения с сервером MySQL выполнена успешно.', aLogGroupGUID, lmtDebug);
              bConnected:=mysql_real_connect(hConnection, PAnsiChar(AnsiString(sMySQLHost)), PAnsiChar('overseer'), PAnsiChar(''), PAnsiChar(AnsiString(sMySQLDatabase)), iMySQLPort, nil, integer(bMySQLCompress)*CLIENT_COMPRESS)<>nil;
              if not bConnected then
                Routines_GenerateError('Возникла ошибка при попытке подключения к серверу MySQL!'+Routines_GetMySQLErrorInfo(aTMySQLServerConnectionDetails), sErrorMessage, bError)
              else
                LogThis('Подключение к MySQL-серверу '+aTMySQLServerConnectionDetails.sMySQLHost+' выполнено успешно.', aLogGroupGUID, lmtDebug);
            end;
        end;
      LogThis('<< Выполнение операции подключения к MySQL-серверу '+aTMySQLServerConnectionDetails.sMySQLHost+' завершено.', aLogGroupGUID, lmtDebug);
    end;
end;

procedure TMainForm.MySQL_CheckTableExistance(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; const aMySQLDatabase: string; var bError: boolean; var sErrorMessage: string; const aTableName: string);
var
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  q: string;
  i: integer;
begin
  LogThis('>> Выполняется операция проверки наличия таблицы данных "'+aTableName+'" в базе данных...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          q:='SHOW TABLES FROM '+aMySQLDatabase+' LIKE "'+LowerCase(aTableName)+'";';
          LogThis(q, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(q)), Length(q))<>0 then
            Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
          else
            begin
              LogThis('Запрос выполнен успешно.', aLogGroupGUID, lmtDebug);
              ResultSet:=mysql_store_result(aTMySQLServerConnectionDetails.hConnection);
              if ResultSet=nil then
                Routines_GenerateError('Не удалось получить результирующую выборку по последнему SQL-запросу!', sErrorMessage, bError)
              else
                begin
                  LogThis('Результирующая выборка получена успешно.', aLogGroupGUID, lmtDebug);
                  i:=mysql_num_rows(ResultSet);
                  LogThis('Количество строк выборки равно '+IntToStr(i)+'.', aLogGroupGUID, lmtDebug);
                  if i<0 then
                    Routines_GenerateError('Возникла ошибка при получении количества срок результирующей выборки!', sErrorMessage, bError)
                  else
                    begin
                      if i<>1 then
                        Routines_GenerateError('Количество строк выборки ('+IntToStr(i)+') не соответствует требуемому (1)!', sErrorMessage, bError)
                      else
                        begin
                          LogThis('Количество строк выборки соответствует требуемому.', aLogGroupGUID, lmtDebug);
                          ResultRow:=mysql_fetch_row(ResultSet);
                          if ResultRow=nil then
                            Routines_GenerateError('Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен 1)!', sErrorMessage, bError)
                          else
                            begin
                              if LowerCase(string(ResultRow[0]))<>LowerCase(aTableName) then
                                Routines_GenerateError('Полученное имя таблицы данных не соответствует требуемому!', sErrorMessage, bError)
                              else
                                LogThis('Наличие таблицы данных проверено успешно.', aLogGroupGUID, lmtDebug);
                            end;
                        end;
                    end;
                  mysql_free_result(ResultSet);
                  LogThis('Освобождение ресурсов, занятых результатом выборки, выполнено.', aLogGroupGUID, lmtDebug);
                end;
            end;
        end;
    end;
  LogThis('<< Выполнение операции проверки наличия таблицы данных "'+aTableName+'" в базе данных завершено.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.MySQL_CreateTable(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
begin
  LogThis('>> Выполняется операция по созданию таблицы данных...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
  else
    if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
    else
      begin
        LogThis(aQuery, aLogGroupGUID, lmtSQL);
        if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
        else
          LogThis('Запрос выполнен успешно.', aLogGroupGUID, lmtDebug);
      end;
  LogThis('<< Выполнение операции по созданию таблицы данных завершено.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.MySQL_DropTable(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string);
begin
  LogThis('>> Выполняется операция по удалению таблицы данных...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
  else
    if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
      Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
    else
      begin
        LogThis(aQuery, aLogGroupGUID, lmtSQL);
        if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
          Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса!', sErrorMessage, bError)
        else
          LogThis('Запрос выполнен успешно.', aLogGroupGUID, lmtDebug);
      end;
  LogThis('<< Выполнение операции по удалению таблицы данных завершено.', aLogGroupGUID, lmtDebug);
end;

function TMainForm.MySQL_InsertRecords(const aLogGroupGUID: string; const aTMySQLServerConnectionDetails: TMySQLServerConnectionDetails; var bError: boolean; var sErrorMessage: string; const aQuery: string): integer;
begin
  Result:=-1;
  LogThis('>> Выполняется операция вставки записей в таблицу...', aLogGroupGUID, lmtDebug);
  if not aTMySQLServerConnectionDetails.bConnected then
    Routines_GenerateError('Для выполнения операции необходимо подключение к серверу MySQL!', sErrorMessage, bError)
  else
    begin
      if mysql_ping(aTMySQLServerConnectionDetails.hConnection)<>0 then
        Routines_GenerateError('Возникла ошибка при попытке проверки подключения к серверу MySQL!', sErrorMessage, bError)
      else
        begin
          LogThis(aQuery, aLogGroupGUID, lmtSQL);
          if mysql_real_query(aTMySQLServerConnectionDetails.hConnection, PAnsiChar(AnsiString(aQuery)), Length(aQuery))<>0 then
            begin
              Routines_GenerateError('Возникла ошибка при выполнении последнего SQL-запроса! '+mysql_error(aTMySQLServerConnectionDetails.hConnection), sErrorMessage, bError);
            end
          else
            begin
              LogThis('Запрос выполнен успешно.', aLogGroupGUID, lmtDebug);
              Result:=mysql_affected_rows(aTMySQLServerConnectionDetails.hConnection);
              LogThis('Количество обработанных строк равно '+IntToStr(Result)+'.', aLogGroupGUID, lmtDebug);
              if Result<0 then
                Routines_GenerateError('Количество обработанных строк ('+IntToStr(Result)+') не соответствует требуемому (>=0)!', sErrorMessage, bError)
              else
                LogThis('Вставка данных выполнена успешно.', aLogGroupGUID, lmtDebug);
            end;
        end;
    end;
  LogThis('<< Выполнение операции вставки записей в таблицу завершено.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  pbMain.Position:=pbMain.Min;
end;

procedure TMainForm.ProcedureHeader(const aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TMainForm.ProcedureFooter(const aLogGroupGUID: string);
begin
  Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TMainForm.PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  LogThis('Производится попытка отображения модального окна '+aWindowName+'.', aLogGroupGUID, lmtDebug);
  aOldBusyState:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
  Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
end;

procedure TMainForm.PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  iBusyCounter:=aOldBusyState; // возвращение старого значения счётчика
  Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
  LogThis('Окно '+aWindowName+' скрыто.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.Do_Comments;
const
  LogGroupGUID: string='{B7C8AA25-E38C-4BE7-B2B3-236FFFB048B8}';
  sModalWinName: string='"Комментарии..."';
var
  CommentsForm: TCommentsForm;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);

  CommentsForm:=TCommentsForm.Create(Self);
  with CommentsForm do
    try
      SmallImage:=TJPEGImage.Create;
      SmallImage.LoadFromFile('D:\My Documents\RAD Studio\Projects\Overseer\CommentsPictures\СИЦ-07-К-М_Preview.jpg');

      NormalImage:=TJPEGImage.Create;
      NormalImage.LoadFromFile('D:\My Documents\RAD Studio\Projects\Overseer\CommentsPictures\СИЦ-07-К-М.jpg');

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

  // создание нового потока в котором будут выполняться все действия по формированию отчёта
  with TThread_Do_ASKR.Create( //
    '{579EF208-BFB8-4555-86CC-9EC2CE7CDFCE}', //
    aStartDate, //
    aStopDate, //
    CurrentUser, //
    Configuration //
    ) do //
    try
      Start; // запускаем выполнение потока
    except
      on Exception do
        Routines_GenerateError('Произошла ошибка при запуске дочернего потока!', sErrorMessage, bError);
    end;

  Do_ASKR:=not bError;
end;

procedure TMainForm.Do_About;
const
  LogGroupGUID: string='{12AD944B-B412-4D41-A2AB-1836C6352752}';
  sModalWinName: string='"О программе..."';
var
  AboutForm: TAboutForm;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);

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
  ProcedureHeader('Процедура разворачивания главного окна из трея', LogGroupGUID);

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
      Visible:=True;
      SetForegroundWindow(Handle);
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
  ProcedureHeader('Процедура снятия оплаты за указанные звонки на голосовые службы СИЦ...', LogGroupGUID);
  bError:=False;

  InitProgressBar(aPayoffList.Count);
  // перебор строк и фикс таблиц ird по датам, полученным из записей
  for i:=0 to aPayoffList.Count-1 do
    if bError then
      Break
    else
      begin
        aIRDTableRecord:=Routines_Convert_string_to_trIRDTableRecord(aPayoffList[i]);
        aDate:=EncodeDate(StrToIntDef(Copy(aIRDTableRecord.datum, 7, 4), 1900), StrToIntDef(Copy(aIRDTableRecord.datum, 4, 2), 1), StrToIntDef(Copy(aIRDTableRecord.datum, 1, 2), 1));
        if IsSameDay(EncodeDate(1900, 1, 1), aDate) then
          Routines_GenerateError('Возникла ошибка при конвертации даты звонка!', sErrorMessage, bError)
        else
          begin
            if IsSameDay(ToDay, aDate) then // если запись находится в сегодняшней таблице
              begin
                // подключение к MySQL-серверу
                MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);

                if not bError then
                  begin
                    // проверка наличия таблицы в базе данных
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

                    // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
                    MySQL_CloseConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                  end;
              end
            else
              begin
                // подключение к MySQL-серверу
                MySQL_OpenConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);

                if not bError then
                  begin
                    // проверка наличия таблицы в базе данных
                    MySQL_CheckTableExistance(LogGroupGUID, Configuration.StatServer, Configuration.StatServer.sMySQLDatabase_IRD_Location, bError, sErrorMessage, 'ird_'+FormatDateTime('yyyymmdd', aDate));

                    if not bError then
                      begin
                        // блокирование таблицы
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
                                // разблокирование таблиц
                                MySQL_UnlockTables(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);

                                // изменение данных на DBSERVER, если есть в наличии таблица
                                if not bError then
                                  begin

                                    // подключение к MySQL-серверу
                                    MySQL_OpenConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);

                                    if not bError then
                                      begin
                                        // проверка наличия таблицы в базе данных
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
                                          bError:=False; // в случае если таблицы тупо нету - не считать это за ошибку

                                        // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
                                        MySQL_CloseConnection(LogGroupGUID, Configuration.DBServer, bError, sErrorMessage);
                                      end;
                                  end;
                              end;
                          end;
                      end;

                    // отключение от MySQL-сервера по окончанию работы текущей процедуры с базами данных - даже в случае ошибки
                    MySQL_CloseConnection(LogGroupGUID, Configuration.StatServer, bError, sErrorMessage);
                  end;
              end;
          end;
        StepProgressBar;
      end;

  // Вывод сообщения об успешном завершении операции, если не задан флаг молчания
  if not bError then
    begin
      Application.ProcessMessages;
      MessageBox(Handle, PWideChar('Действие выполнено успешно.'), PWideChar('OVERSEER - Информация'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
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
  // ProcedureHeader('Процедура получения данных из внешнего процесса', LogGroupGUID);
  MessageType:=lmtError;

  StrLCopy(cText, Msg.CopyDataStruct.lpData, Msg.CopyDataStruct.cbData);
  // LogThis(PChar('Данные, полученые из внешнего процесса: ['+cText+']'), LogGroupGUID, lmtDebug);

  if Msg.From=Handle then
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
              Routines_GenerateError('Произошла ошибка при расшифровке данных строки лога, переданных из дочернего потока!', sErrorMessage, bError);
          end;
      finally
        sl.Free;
      end;
    end;

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  // ProcedureFooter(LogGroupGUID);
end;

{
  # 109 дневной трафик
  SELECT "109d" AS ddi,
  COUNT(*)
  FROM irda.tmp_03_1
  WHERE ddi="109" AND vrijeme BETWEEN "06:00:00" AND "21:59:59"
  GROUP BY ddi
  UNION

  # 109 ночной трафик
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

{ TODO -cБудущие разработки : сделать превьюшки отчётов при нажатии на кнопку комментариев }
{ TODO -cНезначительные фиксы : разобраться с контролем начальной и конечной даты ещё на этапе выбора периода }
{ TODO -cБудущие разработки : возможно, нужно сделать возможность "полной" группировки произвольного периода? }
{ TODO -cПервоочередные фиксы : изменить алгоритм расчёта в случае группировки по неделям }
{ TODO -cБудущие разработки : окончательно систематизировать имена файлов отчётов в зависимости от их параметров }

{ TODO -cНезначительные фиксы : поправить алгоритм отклика на щелчок на иконке в трее при отображённом в данный момент окне About - окно не должно всплывать! }

{ TODO -cБудущие разработки : Завязать работу прогрессбара в функциях формирования отчётов на значение флага aSilentYes, т.к. в режиме планировщика не нуна трогать прогрессбар }

{ TODO -cБудущие разработки : по возможности перенести процедуру Do_PayOff в паралельный потом? но не уверен что это будет правильно }

{ TODO -cБудущие разработки : изменить номенклатуру 9-го отчёта, учитывая момент, когда выбирается список услуг, а не все услуги }

end.
