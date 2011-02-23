unit Main;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ActnList,
  ImgList,
  Menus,
  ComCtrls,
  ToolWin,
  StdCtrls,
  Grids,
  OleCtrls,
  ExtCtrls,
  ActiveX,
  ShellAPI,
  IniFiles,
  Registry,
  mysql,
  getFVI,
  DSCommonServer, DSHTTPCommon, DSHTTPWebBroker, SHDocVw;

const
  // опеределения для панели статуса
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_INFO_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=2;
  HR: string=#10#13;
  RN: string=#13;
  bExitOnError: boolean=True;
  PHONENUMBERTAG: string='~PHONE ';
  PHONEINDEXTAG: string='~PHONEID ';

type
  TMainForm= class(TForm)
    StatusBar1: TStatusBar;
    ActionList1: TActionList;
    ImageList1: TImageList;
    ACTION_QuitProgram: TAction;
    ACTION_AboutProgram: TAction;
    ACTION_ConnectToMySQLServer: TAction;
    ACTION_DisconnectFromMySQLServer: TAction;
    ACTION_Options: TAction;
    ACTION_AddRecord: TAction;
    ACTION_DeleteRecord: TAction;
    ACTION_EditRecord: TAction;
    ACTION_HelpContent: TAction;
    ACTION_UpdateRecords: TAction;
    ACTION_StartTELARM: TAction;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N2: TMenuItem;
    ACTIONQuitProgram1: TMenuItem;
    MI_Action: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    MI_SeparatorAboveUpdateRecords: TMenuItem;
    N23: TMenuItem;
    MI_Mode: TMenuItem;
    MI_Mode_Measures: TMenuItem;
    MI_Mode_Organizations: TMenuItem;
    MI_Mode_Users: TMenuItem;
    MI_Maintenance: TMenuItem;
    N20: TMenuItem;
    MI_Options: TMenuItem;
    N3: TMenuItem;
    N18: TMenuItem;
    MI_SeparatorAboveAboutProgram: TMenuItem;
    N4: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    ACTION_Login: TAction;
    N7: TMenuItem;
    MI_ButtonPanel: TMenuItem;
    MI_StatusPanel: TMenuItem;
    MI_FilterPanel: TMenuItem;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    GB_Mode_Users: TGroupBox;
    ToolButton15: TToolButton;
    CB_DBOperator: TCheckBox;
    CB_DBAdministrator: TCheckBox;
    SG_Mode_Users: TStringGrid;
    GB_Mode_Organizations: TGroupBox;
    SG_Mode_Organizations: TStringGrid;
    GB_Mode_Measures: TGroupBox;
    BUTTON_Apply_Mode_Measures: TButton;
    Button8: TButton;
    Button9: TButton;
    COMBOBOX_OrganizationType: TComboBox;
    COMBOBOX_OrganizationName: TComboBox;
    COMBOBOX_MeasureType: TComboBox;
    COMBOBOX_MeasureName: TComboBox;
    COMBOBOX_MeasureAuthor: TComboBox;
    COMBOBOX_MeasureInfo: TComboBox;
    CHECKBOX_MeasureStartDateTime: TCheckBox;
    DATETIMEPICKER_MeasureStartDate: TDateTimePicker;
    DATETIMEPICKER_MeasureStartTime: TDateTimePicker;
    CHECKBOX_MeasureStopDateTime: TCheckBox;
    DATETIMEPICKER_MeasureStopDate: TDateTimePicker;
    DATETIMEPICKER_MeasureStopTime: TDateTimePicker;
    CHECKBOX_MeasurePremier: TCheckBox;
    CHECKBOX_ChildrenMeasure: TCheckBox;
    CHECKBOX_TeenagerMeasure: TCheckBox;
    BUTTON_Apply_Mode_Organizations: TButton;
    Button5: TButton;
    Button6: TButton;
    BUTTON_Apply_Mode_Users: TButton;
    Button2: TButton;
    Button3: TButton;
    COMBOBOX_OrganizationType2: TComboBox;
    COMBOBOX_OrganizationName2: TComboBox;
    COMBOBOX_OrganizationAddress: TComboBox;
    COMBOBOX_OrganizationHowToReach: TComboBox;
    COMBOBOX_OrganizationPhones: TComboBox;
    COMBOBOX_OrganizationInfo: TComboBox;
    COMBOBOX_MeasureProducer: TComboBox;
    MI_WebBrowser: TMenuItem;
    ToolButton4: TToolButton;
    ACTION_ContextHelp: TAction;
    N24: TMenuItem;
    gsFileVersionInfo1: TgsFileVersionInfo;
    PANEL_WebBrowser: TPanel;
    Splitter1: TSplitter;
    SG_Mode_Measures: TStringGrid;
    ACTION_HideFilterPanel: TAction;
    ACTION_ShowFilterPanel: TAction;
    ACTION_ShowWebBrowser: TAction;
    ACTION_ClearFilter: TAction;
    ACTION_ApplyCurrentFilter: TAction;
    ToolButton5: TToolButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    TabSheet4: TTabSheet;
    MI_Mode_ReplacedPhones: TMenuItem;
    GB_Mode_ReplacedPhones: TGroupBox;
    Button1: TButton;
    Button4: TButton;
    Button7: TButton;
    CheckBox6: TCheckBox;
    SG_Mode_ReplacedPhones: TStringGrid;
    ACTION_EditPaste: TAction;
    ACTION_EditSelectAll: TAction;
    ACTION_EditCut: TAction;
    ACTION_EditClear: TAction;
    ACTION_EditCopy: TAction;
    PopupMenu1: TPopupMenu;
    miEditCut: TMenuItem;
    miEditCopy: TMenuItem;
    miEditPaste: TMenuItem;
    miEditClear: TMenuItem;
    MenuItem3: TMenuItem;
    miEditSelectAll: TMenuItem;
    MenuItem5: TMenuItem;
    miEditHTML: TMenuItem;
    BR1: TMenuItem;
    ACTION_EditHTML_BR: TAction;
    ACTION_EditHTML_HR: TAction;
    ACTION_EditHTML_B: TAction;
    ACTION_EditHTML_I: TAction;
    ACTION_EditHTML_U: TAction;
    ACTION_EditHTML_FONT: TAction;
    BB1: TMenuItem;
    II1: TMenuItem;
    UU1: TMenuItem;
    FONTCOLORREDFONT1: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N8: TMenuItem;
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    WebBrowser1: TWebBrowser;
    procedure ACTION_QuitProgramExecute(Sender: TObject);
    procedure ACTION_ContextHelpExecute(Sender: TObject);
    procedure ACTION_HelpContentExecute(Sender: TObject);
    procedure ACTION_AboutProgramExecute(Sender: TObject);
    procedure PanelSwitcherButtonsClick(Sender: TObject);
    procedure ACTION_HideFilterPanelExecute(Sender: TObject);
    procedure ACTION_ShowFilterPanelExecute(Sender: TObject);
    procedure ACTION_ShowWebBrowserExecute(Sender: TObject);
    procedure ModeSwitcherClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ACTION_ClearFilterExecute(Sender: TObject);
    procedure CHECKBOX_OrganizationType2Click(Sender: TObject);
    procedure CHECKBOX_OrganizationName2Click(Sender: TObject);
    procedure CHECKBOX_OrganizationAddressClick(Sender: TObject);
    procedure CHECKBOX_OrganizationHowToReachClick(Sender: TObject);
    procedure CHECKBOX_OrganizationPhonesClick(Sender: TObject);
    procedure CHECKBOX_OrganizationInfoClick(Sender: TObject);
    procedure CHECKBOX_MeasureStartDateTimeClick(Sender: TObject);
    procedure CHECKBOX_MeasureStopDateTimeClick(Sender: TObject);
    procedure ACTION_StartTELARMExecute(Sender: TObject);
    procedure ACTION_ConnectToMySQLServerExecute(Sender: TObject);
    procedure ACTION_LoginExecute(Sender: TObject);
    procedure ACTION_DisconnectFromMySQLServerExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ACTION_UpdateRecordsExecute(Sender: TObject);
    procedure ACTION_ApplyCurrentFilterExecute(Sender: TObject);
    procedure DATETIMEPICKER_MeasureStartTimeChange(Sender: TObject);
    procedure DATETIMEPICKER_MeasureStopTimeChange(Sender: TObject);
    procedure DATETIMEPICKER_MeasureStartDateChange(Sender: TObject);
    procedure DATETIMEPICKER_MeasureStopDateChange(Sender: TObject);
    procedure ACTION_DeleteRecordExecute(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure SG_Mode_MeasuresSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure ACTION_AddRecordExecute(Sender: TObject);
    procedure SG_KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ACTION_EditRecordExecute(Sender: TObject);
    procedure ACTION_OptionsExecute(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure COMBOBOX_OrganizationAddressDropDown(Sender: TObject);
    procedure UpdateFilterPanel(Sender: TObject);
    procedure COMBOBOX_OrganizationHowToReachDropDown(Sender: TObject);
    procedure COMBOBOX_OrganizationPhonesDropDown(Sender: TObject);
    procedure COMBOBOX_OrganizationInfoDropDown(Sender: TObject);
    procedure COMBOBOX_OrganizationType2DropDown(Sender: TObject);
    procedure COMBOBOX_OrganizationName2DropDown(Sender: TObject);
    procedure COMBOBOX_MeasureAuthorDropDown(Sender: TObject);
    procedure COMBOBOX_MeasureProducerDropDown(Sender: TObject);
    procedure COMBOBOX_MeasureInfoDropDown(Sender: TObject);
    procedure COMBOBOX_MeasureNameDropDown(Sender: TObject);
    procedure COMBOBOX_OrganizationTypeDropDown(Sender: TObject);
    procedure COMBOBOX_OrganizationNameDropDown(Sender: TObject);
    procedure COMBOBOX_MeasureTypeDropDown(Sender: TObject);
    procedure ACTION_EditCutExecute(Sender: TObject);
    procedure ACTION_EditSelectAllExecute(Sender: TObject);
    procedure ACTION_EditClearExecute(Sender: TObject);
    procedure ACTION_EditPasteExecute(Sender: TObject);
    procedure ACTION_EditCopyExecute(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ACTION_EditHTML_BRExecute(Sender: TObject);
    procedure ACTION_EditHTML_HRExecute(Sender: TObject);
    procedure ACTION_EditHTML_BExecute(Sender: TObject);
    procedure ACTION_EditHTML_IExecute(Sender: TObject);
    procedure ACTION_EditHTML_UExecute(Sender: TObject);
    procedure ACTION_EditHTML_FONTExecute(Sender: TObject);
  private
    sMeasureFilter, // строка с фильтром (часть WHERE) запроса по мероприятиям
    sOrganizationFilter, // строка с фильтром (часть WHERE) запроса по организациям
    sUserFilter, // строка с фильтром (часть WHERE) запроса по пользователям
    sWebQuery: string; // строка веб-запроса для браузера
    procedure HideFilterPanel; // процедура скрытия панели фильтров
    procedure ShowFilterPanel; // процедура отображения панели фильтров
    procedure ShowWebBrowser; // процедура отображения панели веб-браузера
    procedure UpdateAllControls; // процедура обновления компонентов
    function GetCurrentMode: integer; // функция получения текущего редима работы программы
    procedure ApplyMode(Mode: integer); // процедура установки текущего режима работы программы
    procedure DisplayHint(Sender: TObject); // процедура-обработчик вывода контекстной подсказки
    procedure Maintenance_CorrectUnfinishedMeasures; // процедура подстановки конечной даты мероприятий, где есть начальная дата, но нет конечной
    procedure Maintenance_EraseAllOutdatedMeasures; // процедура удаления мероприятий, устаревших на текущую дату
    procedure Maintenance_EraseAllMeasuresOutdatedBySelectedDate; // процедура удаления мероприятий, устаревших на указанную дату
    procedure Maintenance_EraseUnusedMeasureAuthors; // процедура удаления незадействованных авторов мероприятий
    procedure Maintenance_EraseUnusedMeasureProducers; // процедура удаления незадействованных режиссёров мероприятий
    procedure Maintenance_EraseUnusedMeasureNames; // процедура удаления незадействованных наименований мероприятий
    procedure Maintenance_EraseUnusedMeasureTypes; // процедура удаления незадействованных типов мероприятий
    procedure Maintenance_EraseUnusedOrganizationNames; // процедура удаления незадействованных наименований организаций
    procedure Maintenance_EraseUnusedOrganizationTypes; // процедура удаления незадействованных типов организаций
    procedure Maintenance_EraseUnusedPhoneRefs; // удаление незадействованных ссылок на номера телефонов в базе данных _inform_
    procedure EraseAllGarbage; // процедура удаления всех ненужных записей
    procedure Maintenance_BaseAutoCorrection; // процедура автоматической корректировки (строковых) данных базы
    // procedure Maintenance_BaseIndexOptimization;			// процедура оптимизации индексов записей (необратимая операция, очищает все сохранённые в удалённых записи)
    // procedure Maintenance_RemoveDuplicates;						// процедура удаления дубликатов записей и перенаправления всех ссылок на оставшийся вариант
  public
    CFGFileName, // имя файла конфигурации
    LOGFileName, // имя файла лога
    HLPFileName: TFileName; // имя файла спраки
    MySQLConnectionHandler: PMYSQL; // экземпляр структуры данных подключения
    sUserLogin, // имя пользователя
    sUserPwd, // пароль пользователя
    sUserRealName: string; // настоящее имя пользователя
    iUserID: integer; // номер пользователя в списке пользователей
    bUserIsAdmin: boolean; // флаг - является-ли пользователь администратором базы данных
    LogFile: TStringStream;
    procedure UpdateMeasureList;
    procedure UpdateOrganizationList;
    procedure UpdateUserList;
    procedure UpdateReplacedPhonesList;
    procedure UpdateCurrentList;
    procedure TryReconnectToServer; // процедура восстановления подключения к MySQL-серверу
    function TryExecuteSelectQuery(const _Query: string; _mysql: PMYSQL): boolean; // функция выполнения SELECT-подобного SQL-запроса
    function TryExecuteUpdateQuery(const _Query: string; _mysql: PMYSQL): boolean; // функция выполнения UPDATE-подобного SQL-запроса
    function ValidateString(s: string): string; // функция валидации (исправления) входной строки, подгонки её под шаблон
    procedure AddListedPhonesToDB(a: string);
    function LoadBoolFromRegistry(aKey, aValue: string): boolean; // функция чтения значения типа boolean из реестра
    function LoadStringFromRegistry(aKey, aValue: string): string; // функция чтения значения строки из реестра
    function LoadIntegerFromRegistry(aKey, aValue: string): integer; // функция чтения значения типа integer из реестра
    procedure LogThis(a: string); // процедура внесения строки в лог программы
  end;

procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

uses
  PopUp,
  Login,
  Options,
  SelectDate,
  Measures,
  Organizations,
  Report,
  Users;
(*
  procedure SimulateKeyDown(Key : byte);
  begin
  keybd_event(Key, 0, 0, 0);
  end;

  procedure SimulateKeyUp(Key : byte);
  begin
  keybd_event(Key, 0, KEYEVENTF_KEYUP, 0);
  end;

  procedure SimulateKeystroke(Key : byte; extra : DWORD);
  begin
  keybd_event(Key,extra,0,0);
  keybd_event(Key,extra,KEYEVENTF_KEYUP,0);
  end;

  procedure SendKeys(s : string);
  var
  i : integer;
  flag : bool;
  w : word;
  begin
  {Get the state of the caps lock key}
  flag := not GetKeyState(VK_CAPITAL) and 1 = 0;
  {If the caps lock key is on then turn it off}
  if flag then
  SimulateKeystroke(VK_CAPITAL, 0);
  for i := 1 to Length(s) do
  begin
  w := VkKeyScan(s[i]);
  {If there is not an error in the key translation}
  if ((HiByte(w) <> $FF) and (LoByte(w) <> $FF)) then
  begin
  {If the key requires the shift key down - hold it down}
  if HiByte(w) and 1 = 1 then
  SimulateKeyDown(VK_SHIFT);
  {Send the VK_KEY}
  SimulateKeystroke(LoByte(w), 0);
  {If the key required the shift key down - release it}
  if HiByte(w) and 1 = 1 then
  SimulateKeyUp(VK_SHIFT);
  end;
  end;
  {if the caps lock key was on at start, turn it back on}
  if flag then
  SimulateKeystroke(VK_CAPITAL, 0);
  end;
*)

function TMainForm.ValidateString(s: string): string;
var
  new_s: string;
  i, j: integer;
begin
  (* функция "подведения" заданной строки под стандартный вид базы *)
  // замена ' на \'
  new_s:=StringReplace(s, #39, '\'+#39, [rfReplaceAll]);
  // предварительное удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // удаление ограничивающих парных кавычек
  if new_s>'' then
    if (new_s[1]='"')and(new_s[Length(new_s)]='"') then
      new_s:=copy(new_s, 2, Length(new_s)-2);
  // замена символов перевода строки и возврата каретки на пробелы
  new_s:=StringReplace(new_s, #10, ' ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, #13, ' ', [rfReplaceAll]);
  // замена символа "."
  new_s:=StringReplace(new_s, ' .', '.', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. ', '.', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '.', '. ', [rfReplaceAll]);
  // замена трёх точек на многоточие
  new_s:=StringReplace(new_s, '. . . ', '... ', [rfReplaceAll]);
  // замена символа ","
  new_s:=StringReplace(new_s, ' ,', ',', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ', ', ',', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ',', ', ', [rfReplaceAll]);
  // замена символа "-"
  new_s:=StringReplace(new_s, ' -', '-', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '- ', '-', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '-', '- ', [rfReplaceAll]);
  // замена символа ":"
  new_s:=StringReplace(new_s, ' :', ':', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ': ', ':', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ':', ': ', [rfReplaceAll]);
  // корректировка случая "цифра-тире(двоеточие)-цифра" для дат и времени
  for j:=0 to 9 do
    for i:=0 to 9 do
      begin
        new_s:=StringReplace(new_s, IntToStr(j)+'- '+IntToStr(i), IntToStr(j)+'-'+IntToStr(i), [rfReplaceAll]);
        new_s:=StringReplace(new_s, IntToStr(j)+': '+IntToStr(i), IntToStr(j)+':'+IntToStr(i), [rfReplaceAll]);
        new_s:=StringReplace(new_s, IntToStr(j)+'. '+IntToStr(i), IntToStr(j)+':'+IntToStr(i), [rfReplaceAll]);
      end;
  // замена символа """
  new_s:=StringReplace(new_s, ' "', '"', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '" ', '"', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '"', ' " ', [rfReplaceAll]);
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // замена символов "[" и "]"
  new_s:=StringReplace(new_s, ' [', '[', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '[ ', '[', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '[', ' [ ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' ]', ']', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '] ', ']', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ']', ' ] ', [rfReplaceAll]);
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // замена символов "[" и "]"
  new_s:=StringReplace(new_s, ' <', '<', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< ', '<', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '<', ' < ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' >', '>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '> ', '>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '>', ' > ', [rfReplaceAll]);
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // замена символов "(" и ")"
  new_s:=StringReplace(new_s, ' (', '(', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '( ', '(', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '(', ' ( ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' )', ')', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ') ', ')', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ')', ' ) ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ') ,', '),', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ') .', ').', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ') ;', ');', [rfReplaceAll]);
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // ПРОЧИЕ ЗАМЕНЫ
  // если не указано сокращение "город" перед Минск, вставляем
  if Pos('Минск,', new_s)=1 then
    new_s:='г. '+new_s;
  if Pos('Минск.', new_s)=1 then
    new_s:='г. '+new_s;
  if Pos('Минск ', new_s)=1 then
    new_s:='г. '+new_s;
  new_s:=StringReplace(new_s, 'www. ', 'www.', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. by', '.by', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. ru', '.ru', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. com', '.com', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. net', '.net', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. org', '.org', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. open', '.open', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. tut', '.tut', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'mailto: ', 'mailto:', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'mail: ', 'mail:', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'E- mail', 'E-mail', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'E- Mail', 'E-mail', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'e- Mail', 'E-mail', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'e- mail', 'E-mail', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'http: /', 'http:/', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' atava.', 'atava.', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< BR >', '<BR>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< HR >', '<HR>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< B >', '<B>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< /B >', '</B>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< A ', '<A ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< /A >', '</A>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< FONT ', '<FONT ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< /FONT >', '</FONT>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '<FONT COLOR= " RED " >', '<FONT COLOR="RED">', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'карины', 'корины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'карыны', 'корины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'пр. Скорины', 'пр- т Ф. Скорины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'пр. Ф. Скорины', 'пр- т Ф. Скорины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'пр- т Скорины', 'пр- т Ф. Скорины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' р- он', ' р- н', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' р- он,', ' р- н,', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' р- он.', ' р- н.', [rfReplaceAll]);

  // ДОПИСАТЬ!!!
  // здесь нужно вставить обработку списка автозамен из окна опций

  // финальное удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  // добавление пробела в начале текстовой строки
  if new_s>'' then
    new_s:=' '+new_s;
  Result:=new_s;
end;

function TMainForm.TryExecuteUpdateQuery(const _Query: string; _mysql: PMYSQL): boolean;
var
  i: integer;
begin
  Result:=False;
  repeat
    // попробовать выполнить запрос
    i:=mysql_real_query(_mysql, PAnsiChar(AnsiString(_Query)), Length(_Query));
    // если функция вернула не ноль - проводим обработку ошибки
    if i<>0 then
      begin
        // если клиентом было случайно потеряно соединение с сервером
        if mysql_errno(_mysql)=2014 then
          begin
            // попробовать переподключиться
            MessageDlg('Было утеряно соедиенение с сервером MySQL!'+HR+RN+'MySQL_Error: '+string(mysql_error(_mysql))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(_mysql)), mtError, [mbOK], 0);
            if (MessageDlg('Сделать попытку переподключения?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
              TryReconnectToServer;
          end
        else
          begin
            // выходим по ошибке
            MessageDlg('Не удалось выполнить запрос!'+HR+RN+'MySQL_Error: '+string(mysql_error(_mysql))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(_mysql)), mtError, [mbOK], 0);
            Exit;
          end;
      end;
  until i=0;
  Result:=True;
end;

function TMainForm.TryExecuteSelectQuery(const _Query: string; _mysql: PMYSQL): boolean;
var
  i: integer;
begin
  Result:=False;
  repeat
    // попробовать выполнить запрос
    i:=mysql_real_query(_mysql, PAnsiChar(AnsiString(_Query)), Length(_Query));
    // если функция вернула не ноль - проводим обработку ошибки
    if i<>0 then
      begin
        // если клиентом было случайно потеряно соединение с сервером
        if mysql_errno(_mysql)=2014 then
          begin
            // попробовать переподключиться
            MessageDlg('Было утеряно соедиенение с сервером MySQL!'+HR+RN+'MySQL_Error: '+string(mysql_error(_mysql))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(_mysql)), mtError, [mbOK], 0);
            if (MessageDlg('Сделать попытку переподключения?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
              TryReconnectToServer;
          end
        else
          begin
            // выходим по ошибке
            MessageDlg('Не удалось выполнить запрос!'+HR+RN+'MySQL_Error: '+string(mysql_error(_mysql))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(_mysql)), mtError, [mbOK], 0);
            Exit;
          end;
      end;
  until i=0;
  Result:=True;
end;

procedure TMainForm.UpdateAllControls;
(* процедура обновления состояния панелей *)
begin
  (* !!!ДОПИСАТЬ!!! *)
  PageControl1.Visible:=(not ACTION_ConnectToMySQLServer.Visible)and ACTION_DisconnectFromMySQLServer.Visible;
  MI_Mode_Users.Visible:=bUserIsAdmin;
  MI_Mode.Visible:=PageControl1.Visible;
  MI_Action.Visible:=PageControl1.Visible;
  MI_WebBrowser.Visible:=(GetCurrentMode=0)and PageControl1.Visible;
  MI_FilterPanel.Visible:=PageControl1.Visible and(GetCurrentMode<>3);
  MI_Maintenance.Visible:=PageControl1.Visible and bUserIsAdmin;
  ACTION_AddRecord.Visible:=PageControl1.Visible and(GetCurrentMode<>3);
  ACTION_DeleteRecord.Visible:=PageControl1.Visible and(GetCurrentMode<>3);
  ACTION_EditRecord.Visible:=PageControl1.Visible and(GetCurrentMode<>3);
  ACTION_UpdateRecords.Visible:=PageControl1.Visible;
  MI_SeparatorAboveUpdateRecords.Visible:=(ACTION_AddRecord.Visible or ACTION_DeleteRecord.Visible or ACTION_EditRecord.Visible)and ACTION_UpdateRecords.Visible;
  ToolBar1.Visible:=MI_ButtonPanel.Checked;
  if (StatusBar1.Visible=False)and(StatusBar1.Visible<>MI_StatusPanel.Checked) then
    StatusBar1.Visible:=MI_StatusPanel.Checked
  else
    StatusBar1.Visible:=MI_StatusPanel.Checked;
  GB_Mode_Measures.Visible:=MI_FilterPanel.Checked;
  GB_Mode_Organizations.Visible:=MI_FilterPanel.Checked;
  GB_Mode_Users.Visible:=MI_FilterPanel.Checked;
  PANEL_WebBrowser.Visible:=MI_WebBrowser.Checked;
  Splitter1.Visible:=MI_WebBrowser.Checked;
  ACTION_ShowFilterPanel.Visible:=(not MI_FilterPanel.Checked)and PageControl1.Visible and(GetCurrentMode<>3);
  ACTION_ShowWebBrowser.Visible:=(not MI_WebBrowser.Checked)and(GetCurrentMode=0)and PageControl1.Visible;
  MI_SeparatorAboveAboutProgram.Visible:=(ACTION_HelpContent.Visible or ACTION_ContextHelp.Visible)and ACTION_AboutProgram.Visible;
  UpdateFilterPanel(nil);
end;

procedure TMainForm.PanelSwitcherButtonsClick(Sender: TObject);
begin
  (* процедура отклика на нажатие одного из элементов меню, отвечающего за включение/выключение панелей *)
  if Sender is TMenuItem then
    begin
      TMenuItem(Sender).Checked:=not TMenuItem(Sender).Checked;
      UpdateAllControls;
    end;
end;

procedure TMainForm.HideFilterPanel;
begin
  (* процедура скрытия панели фильтров *)
  MI_FilterPanel.Checked:=False;
  UpdateAllControls;
end;

procedure TMainForm.ShowFilterPanel;
begin
  (* процедура отображения панели фильтров *)
  MI_FilterPanel.Checked:=True;
  UpdateAllControls;
end;

procedure TMainForm.ShowWebBrowser;
begin
  (* процедура отображения панели браузера *)
  MI_WebBrowser.Checked:=True;
  UpdateAllControls;
end;

procedure TMainForm.ApplyMode(Mode: integer);
{ *	процедура устанавливает указанный режим	работы	* }
begin
  PageControl1.ActivePage:=PageControl1.Pages[Mode];
  ACTION_ClearFilterExecute(nil);
  sMeasureFilter:='';
  sOrganizationFilter:='';
  sUserFilter:='';
  ACTION_UpdateRecordsExecute(Self);
  UpdateAllControls;
end;

function TMainForm.GetCurrentMode: integer;
(* функция получения номера текущего режима работы *)
begin
  Result:=0;
  if MI_Mode_Organizations.Checked then
    Result:=1;
  if MI_Mode_Users.Checked then
    Result:=2;
  if MI_Mode_ReplacedPhones.Checked then
    Result:=3;
end;

procedure TMainForm.ModeSwitcherClick(Sender: TObject);
(* процедура установки выбранного режима работы *)
begin
  if Sender is TMenuItem then
    begin
      TMenuItem(Sender).Checked:=True;
    end;
  ApplyMode(TMenuItem(Sender).Tag);
end;

procedure TMainForm.ACTION_HideFilterPanelExecute(Sender: TObject);
begin
  HideFilterPanel;
end;

procedure TMainForm.ACTION_ShowFilterPanelExecute(Sender: TObject);
begin
  ShowFilterPanel;
end;

procedure TMainForm.DisplayHint(Sender: TObject);
begin
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.ACTION_ShowWebBrowserExecute(Sender: TObject);
begin
  ShowWebBrowser;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  i: integer;
begin
  LOGFileName:=Copy(Application.ExeName, 0, Length(Application.ExeName)-4)+ { DateToStr(Date)+ } '.log';
  LogThis('Начало работы программы');
  ImageList1.GetIcon(6, Application.Icon);
  Icon:=Application.Icon;
  Application.OnHint:=DisplayHint;
  CFGFileName:=Copy(Application.ExeName, 0, Length(Application.ExeName)-3)+'cfg';
  HLPFileName:=Copy(ExtractFileName(Application.ExeName), 0, Length(ExtractFileName(Application.ExeName))-3)+'hlp';
  bUserIsAdmin:=False;
  gsFileVersionInfo1.Filename:=Application.ExeName;
  // чтение настроек текущего юзера из реестра
  LogThis('Чтение настроек программы из реестра');
  Application.Title:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'ApplicationTitle');
  if Application.Title='' then
    Application.Title:='АРМ оператора БД "Отдых и развлечения"';
  if LoadBoolFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'MaximizeWindowOnStartUp') then
    MainForm.WindowState:=wsMaximized
  else
    begin
      i:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'MainWindowTop');
      if i<>-1 then
        MainForm.Top:=i;
      i:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'MainWindowLeft');
      if i<>-1 then
        MainForm.Left:=i;
      i:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'MainWindowHeight');
      if i<>-1 then
        MainForm.Height:=i;
      i:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'MainWindowWidth');
      if i<>-1 then
        MainForm.Width:=i;
    end;
  Caption:=Application.Title;
  ACTION_Options.Visible:=True;
  ACTION_HelpContent.Enabled:=FileExists(HLPFileName);
  ACTION_HelpContent.Visible:=ACTION_HelpContent.Enabled;
  ACTION_ContextHelp.Enabled:=ACTION_HelpContent.Enabled;
  ACTION_ContextHelp.Visible:=ACTION_HelpContent.Visible;
  if ACTION_HelpContent.Visible then
    HelpFile:=HLPFileName;
  PageControl1.ActivePage:=PageControl1.Pages[0];
  ACTION_ClearFilterExecute(nil);
  ACTION_AboutProgram.Execute;
  UpdateAllControls;
end;

procedure TMainForm.ACTION_ClearFilterExecute(Sender: TObject);
begin
  case GetCurrentMode of
    0:
      begin
        COMBOBOX_OrganizationType.Text:='';
        COMBOBOX_OrganizationName.Text:='';
        COMBOBOX_MeasureType.Text:='';
        COMBOBOX_MeasureName.Text:='';
        COMBOBOX_MeasureAuthor.Text:='';
        COMBOBOX_MeasureProducer.Text:='';
        COMBOBOX_MeasureInfo.Text:='';
        CHECKBOX_MeasureStartDateTime.Checked:=False;
        DATETIMEPICKER_MeasureStartDate.Date:=Date;
        DATETIMEPICKER_MeasureStartTime.Time:=0;
        CHECKBOX_MeasureStopDateTime.Checked:=False;
        DATETIMEPICKER_MeasureStopDate.Date:=Date;
        DATETIMEPICKER_MeasureStopTime.Time:=EncodeTime(23, 59, 59, 0);
        CHECKBOX_MeasurePremier.Checked:=False;
        CHECKBOX_ChildrenMeasure.Checked:=False;
        CHECKBOX_TeenagerMeasure.Checked:=False;
      end;
    1:
      begin
        COMBOBOX_OrganizationType2.Text:='';
        COMBOBOX_OrganizationName2.Text:='';
        COMBOBOX_OrganizationAddress.Text:='';
        COMBOBOX_OrganizationHowToReach.Text:='';
        COMBOBOX_OrganizationPhones.Text:='';
        COMBOBOX_OrganizationInfo.Text:='';
      end;
    2:
      begin
        CB_DBOperator.Checked:=False;
        CB_DBAdministrator.Checked:=False;
      end;
    3:
      begin
        (* !!!ДОПИСАТЬ!!! *)
      end;
  end;
  UpdateFilterPanel(Sender);
end;

procedure TMainForm.CHECKBOX_OrganizationType2Click(Sender: TObject);
begin
  if (COMBOBOX_OrganizationType2.Enabled=False) then
    COMBOBOX_OrganizationType2.Text:=''
  else
    if COMBOBOX_OrganizationType2.Visible then
      COMBOBOX_OrganizationType2.SetFocus;
  UpdateFilterPanel(Sender);
end;

procedure TMainForm.CHECKBOX_OrganizationName2Click(Sender: TObject);
begin
  if (COMBOBOX_OrganizationName2.Enabled=False) then
    COMBOBOX_OrganizationName2.Text:=''
  else
    if COMBOBOX_OrganizationName2.Visible then
      COMBOBOX_OrganizationName2.SetFocus;
  UpdateFilterPanel(Sender);
end;

procedure TMainForm.CHECKBOX_OrganizationAddressClick(Sender: TObject);
begin
  if (COMBOBOX_OrganizationAddress.Enabled=False) then
    COMBOBOX_OrganizationAddress.Text:=''
  else
    if COMBOBOX_OrganizationAddress.Visible then
      COMBOBOX_OrganizationAddress.SetFocus;
  UpdateFilterPanel(Sender);
end;

procedure TMainForm.CHECKBOX_OrganizationHowToReachClick(Sender: TObject);
begin
  if (COMBOBOX_OrganizationHowToReach.Enabled=False) then
    COMBOBOX_OrganizationHowToReach.Text:=''
  else
    if COMBOBOX_OrganizationHowToReach.Visible then
      COMBOBOX_OrganizationHowToReach.SetFocus;
  UpdateFilterPanel(Sender);
end;

procedure TMainForm.CHECKBOX_OrganizationPhonesClick(Sender: TObject);
begin
  if (COMBOBOX_OrganizationPhones.Enabled=False) then
    COMBOBOX_OrganizationPhones.Text:=''
  else
    if COMBOBOX_OrganizationPhones.Visible then
      COMBOBOX_OrganizationPhones.SetFocus;
  UpdateFilterPanel(Sender);
end;

procedure TMainForm.CHECKBOX_OrganizationInfoClick(Sender: TObject);
begin
  if (COMBOBOX_OrganizationInfo.Enabled=False) then
    COMBOBOX_OrganizationInfo.Text:=''
  else
    if COMBOBOX_OrganizationInfo.Visible then
      COMBOBOX_OrganizationInfo.SetFocus;
  UpdateFilterPanel(Sender);
end;

procedure TMainForm.CHECKBOX_MeasureStartDateTimeClick(Sender: TObject);
begin
  DATETIMEPICKER_MeasureStartDate.Enabled:=CHECKBOX_MeasureStartDateTime.Checked;
  DATETIMEPICKER_MeasureStartTime.Enabled:=CHECKBOX_MeasureStartDateTime.Checked;
  if (CHECKBOX_MeasureStartDateTime.Checked=False) then
    begin
      DATETIMEPICKER_MeasureStartDate.Date:=Date;
      DATETIMEPICKER_MeasureStartTime.Time:=0;
    end
  else
    if DATETIMEPICKER_MeasureStartDate.Visible then
      DATETIMEPICKER_MeasureStartDate.SetFocus;
  UpdateFilterPanel(Sender);
end;

procedure TMainForm.CHECKBOX_MeasureStopDateTimeClick(Sender: TObject);
begin
  DATETIMEPICKER_MeasureStopDate.Enabled:=CHECKBOX_MeasureStopDateTime.Checked;
  DATETIMEPICKER_MeasureStopTime.Enabled:=CHECKBOX_MeasureStopDateTime.Checked;
  if (CHECKBOX_MeasureStopDateTime.Checked=False) then
    begin
      DATETIMEPICKER_MeasureStopDate.Date:=Date;
      DATETIMEPICKER_MeasureStopTime.Time:=EncodeTime(23, 59, 59, 0);
    end
  else
    if DATETIMEPICKER_MeasureStopDate.Visible then
      DATETIMEPICKER_MeasureStopDate.SetFocus;
  UpdateFilterPanel(Sender);
end;

procedure TMainForm.ACTION_StartTELARMExecute(Sender: TObject);
begin
  (* процедура открытия веб-сценария АРМ телефониста *)
  if LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'WebServer')<>'' then
    ShellExecute(Application.Handle, 'open', PChar(LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'WebServer')), nil, nil, SW_MAXIMIZE)
  else
    MessageDlg('Программа не может считать из реестра адрес веб-сервера, обеспечивающего работу АРМ телефониста! Обратитесь к администратору сети!', mtError, [mbOk], 0);
end;

procedure TMainForm.ACTION_ConnectToMySQLServerExecute(Sender: TObject);
var
  iServersCount, iLastServer: integer;
  sHostName, sLogin, sPwd, sDBName: string;
  iPort, // iTimeOut,
  iUseCompression: integer;
begin
  iServersCount:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'ServersCount');
  if iServersCount>0 then
    begin
      iLastServer:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastServer');
      if (iLastServer>0)and(iLastServer<=iServersCount) then
        begin
          sHostName:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(iLastServer), 'HostName');
          if sHostName='' then
            begin
              LogThis('ERROR: Ошибка чтения из реестра строки с именем MySQL-сервера');
              MessageDlg('Произошла ошибка при попытке чтения имени сервера для подключения по умолчанию из реестра! Обратитесь к администратору!', mtError, [mbOk], 0);
              Exit;
            end;
          sLogin:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(iLastServer), 'Login');
          if sLogin='' then
            begin
              LogThis('ERROR: Ошибка чтения из реестра логина для подключения к MySQL-серверу');
              MessageDlg('Произошла ошибка при попытке чтения логина подключения к серверу из реестра! Обратитесь к администратору!', mtError, [mbOk], 0);
              Exit;
            end;
          sPwd:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(iLastServer), 'Password');
          (*
            if sPwd='' then
            begin
            LogThis('ERROR: Ошибка чтения из реестра пароля для подключения к MySQL-серверу');
            MessageDlg('Произошла ошибка при попытке чтения пароля подключения к серверу из реестра! Обратитесь к администратору!',mtError,[mbOk],0);
            Exit;
            end;
            *)
          sDBName:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(iLastServer), 'DBName');
          if sDBName='' then
            begin
              LogThis('ERROR: Ошибка чтения из реестра имени базы данных');
              MessageDlg('Произошла ошибка при попытке чтения имени базы данных из реестра! Обратитесь к администратору!', mtError, [mbOk], 0);
              Exit;
            end;
          iPort:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(iLastServer), 'Port');
          if iPort=-1 then
            begin
              iPort:=MYSQL_PORT;
              LogThis('ERROR: Ошибка чтения из реестра номера порта для подключения к MySQL-серверу');
              MessageDlg('Произошла ошибка при попытке чтения порта подключения по умолчанию из реестра! Обратитесь к администратору!', mtError, [mbOk], 0);
            end;
          (*
            iTimeOut:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(iLastServer),'TimeOut');
            if iTimeOut=-1 then
            begin
            iTimeOut:=30;
            LogThis('ERROR: Ошибка чтения из реестра времени таймаута подключения к MySQL-серверу');
            MessageDlg('Произошла ошибка при попытке чтения времени таймаута подключения по умолчанию из реестра! Обратитесь к администратору!',mtError,[mbOk],0);
            end;
            *)
          iUseCompression:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(iLastServer), 'UseCompression');
          if iUseCompression=-1 then
            begin
              iUseCompression:=1;
              LogThis('ERROR: Ошибка чтения из реестра флага компрессии данных подключения к MySQL-серверу');
              MessageDlg('Произошла ошибка при попытке чтения флага компрессии данных подключения по умолчанию из реестра! Обратитесь к администратору!', mtError, [mbOk], 0);
            end;
        end
      else
        begin
          case iLastServer of
            -1:
              MessageDlg('Произошла ошибка при попытке чтения настроек подключения из реестра! Обратитесь к администратору!', mtError, [mbOk], 0);
            0:
              MessageDlg('Не выбран сервер по умолчанию для подключения! Обратитесь к администратору!', mtError, [mbOk], 0);
          else
            MessageDlg('Выбран несуществующий номер сервера по умолчанию для подключения! Обратитесь к администратору!', mtError, [mbOk], 0);
          end;
          Exit;
        end;
    end
  else
    begin
      case iServersCount of
        -1:
          MessageDlg('Произошла ошибка при попытке чтения настроек подключения из реестра! Обратитесь к администратору!', mtError, [mbOk], 0);
        0:
          MessageDlg('Не указано ни одного сервера для подключения! Обратитесь к администратору!', mtError, [mbOk], 0);
      end;
      Exit;
    end;
  // если всё же были считаны все настройки для инициализации подключения, пробуем подключиться
  try
    MySQLConnectionHandler:=mysql_init(nil);
  except
    on EAccessViolation do
      begin
        LogThis('ERROR: Ошибка обращения к функции библиотеки "libmysql.dll"');
        MessageDlg('Произошла ошибка обращения к функции библиотеки "libmysql.dll"! Возможно, файл отсутствует на диске. Обратитесь к администратору!', mtError, [mbOK], 0);
        Exit;
      end;
  end;
  if MySQLConnectionHandler=nil then
    begin
      LogThis('ERROR: Ошибка инифиализации объекта PMYSQL');
      MessageDlg('Не удалось инифиализировать объект PMYSQL! Возможно не хватает свободной оперативной памяти. Обратитесь к администратору!', mtError, [mbOK], 0);
      Exit;
    end;
  if mysql_real_connect(MySQLConnectionHandler, PAnsiChar(AnsiString(sHostName)), PAnsiChar(AnsiString(sLogin)), PAnsiChar(AnsiString(sPwd)), PAnsiChar(AnsiString(sDBName)), iPort, nil, iUseCompression)=nil then
    begin
      if mysql_errno(MySQLConnectionHandler)=2003 then
        begin
          LogThis('ERROR: Ошибка подключения к MySQL-серверу (сервер не запущен)');
          MessageDlg('Не удалось установить соединение с сервером MYSQL, т.к. сервер MySQL не запущен! Обратитесь к администратору сети!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
              (mysql_errno(MySQLConnectionHandler)), mtError, [mbOK], 0)
        end
      else
        begin
          LogThis('ERROR: Ошибка подключения к MySQL-серверу');
          MessageDlg('Не удалось установить соединение с сервером MYSQL!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError, [mbOK], 0);
        end;
      Exit;
    end
  else
    begin
      ACTION_ConnectToMySQLServer.Visible:=False;
      ACTION_DisconnectFromMySQLServer.Visible:=True;
      if LoadBoolFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'ShowHostnameInTitle') then
        MainForm.Caption:=Application.Title+' - ['+sHostName+']';
    end;
  // вызов процедуры логирования пользователя
  ACTION_LoginExecute(Sender);
  // обновление компонентов формы
  UpdateAllControls;
  if LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'WebServer')<>'' then
    sWebQuery:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'WebServer')+'searchid.php?MEASURE_ID='
  else
    MessageDlg('Программа не может считать из реестра адрес веб-сервера, обеспечивающего работу АРМ телефониста! Обратитесь к администратору сети!', mtError, [mbOk], 0);
  if MI_WebBrowser.Checked then
    WebBrowser1.Navigate(sWebQuery+SG_Mode_Measures.Cells[0, SG_Mode_Measures.Row]);
  if SG_Mode_Measures.Visible then
    SG_Mode_Measures.SetFocus;
end;

procedure TMainForm.ACTION_LoginExecute(Sender: TObject);
var
  q, s, sLastUserPwd: string;
  i: integer;
  ResultSet_LookupBase: PMYSQL_RES;
  ResultRow_LookupBase: PMYSQL_ROW;
begin
  // считываем имя последнего логировавшегося пользователя
  sUserLogin:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastUser');
  // считываем пароль последнего логировавшегося пользователя.
  // по умолчанию он в реестре НЕ ПРОПИСАН!!!
  // если надоело вводить каждый раз пароль - достаточно добавить
  // строковую переменную LastUserPwd по вышеуказанному пути
  // в реестре со значением пароля пользователя
  sLastUserPwd:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastUserPwd');
  // проверка прав доступа пользователя
  with TLoginForm.Create(Self) do
    try
      ActiveControl:=EDIT_UserName;
      if sUserLogin<>'' then
        begin
          EDIT_UserName.Text:=sUserLogin;
          ActiveControl:=EDIT_UserPassword;
          if sLastUserPwd<>'' then
            begin
              EDIT_UserPassword.Text:=sLastUserPwd;
              ModalResult:=mrOk;
            end
          else
            ShowModal;
        end
      else
        ShowModal;
      if ModalResult<>mrOk then
        begin
          ACTION_DisconnectFromMySQLServer.Execute;
          Exit;
        end;
      q:='SELECT realname, editor, administrator, id FROM users WHERE name='+#39+EDIT_UserName.Text+#39+' AND password='+#39+EDIT_UserPassword.Text+#39+' ORDER BY realname;';
      // если подключение невыполнено, подключиться
      // иначе - пропинговать подключение (восстановить его в случае утери)
      TryReconnectToServer;
      if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
        begin
          // попытаться получить результирующий запрос
          ResultSet_LookupBase:=mysql_store_result(MySQLConnectionHandler);
          // если ничего не получилось - вывести диалог об ошибке и выйти из функции
          if ResultSet_LookupBase=nil then
            begin
              MessageDlg('Не удалось получить результирующую выборку из таблицы USERS!'+HR+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError, [mbOK], 0);
              ACTION_DisconnectFromMySQLServer.Execute;
              Exit;
            end
          else
            try
              if mysql_num_rows(ResultSet_LookupBase)>0 then
                begin
                  ResultRow_LookupBase:=mysql_fetch_row(ResultSet_LookupBase);
                  if ResultRow_LookupBase[1]<>'1' then
                    begin
                      MessageDlg('Пользователь "'+ResultRow_LookupBase[0]+'" не имеет права на редактирование базы данных!', mtError, [mbOk], 0);
                      ACTION_DisconnectFromMySQLServer.Execute;
                      Exit;
                    end
                  else
                    begin
                      sUserRealName:=string(ResultRow_LookupBase[0]);
                      sUserLogin:=EDIT_UserName.Text;
                      iUserID:=StrToInt(string(ResultRow_LookupBase[3]));
                      bUserIsAdmin:=ResultRow_LookupBase[2]='1';
                      s:='Добро пожаловать, ';
                      if (Time<EncodeTime(6, 00, 00, 0)) then
                        s:='Доброй ночи, ';
                      if ((Time>=EncodeTime(6, 00, 00, 0))and(Time<EncodeTime(12, 00, 00, 0))) then
                        s:='Доброе утро, ';
                      if ((Time>=EncodeTime(12, 00, 00, 0))and(Time<EncodeTime(18, 00, 00, 0))) then
                        s:='Добрый день, ';
                      if ((Time>=EncodeTime(18, 00, 00, 0))and(Time<EncodeTime(23, 59, 59, 0))) then
                        s:='Добрый вечер, ';
                      LogThis('Пользователь '+sUserRealName+' успешно залогирован');
                      MessageDlg(s+sUserRealName+'!', mtInformation, [mbOk], 0);
                      // запись в реестр логина последнего работавшего в программе пользователя
                      i:=0;
                      with TRegistry.Create do
                        try
                          RootKey:=HKEY_CURRENT_USER;
                          if OpenKey('\Software\Vlad DraCooLa\OPERARM', True) then
                            try
                              i:=1;
                              if LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'StoreLastUser')=1 then
                                begin
                                  i:=2;
                                  WriteString('LastUser', sUserLogin);
                                  if LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastUserPwd')<>'' then
                                    WriteString('LastUserPwd', sLastUserPwd);
                                end
                              else
                                begin
                                  DeleteValue('LastUser');
                                  DeleteValue('LastUserPwd');
                                end;
                            except
                              on ERegistryException do
                                begin
                                  case i of
                                    1:
                                      MessageDlg('Ошибка чтения настройки параметра сохранения текущего пользователя в реестре! Обратитесь к администратору!', mtError, [mbOk], 0);
                                    2:
                                      MessageDlg('Ошибка сохранения имени текущего пользователя в реестре! Обратитесь к администратору!', mtError, [mbOk], 0);
                                  end;
                                end;
                            end;
                        finally
                          CloseKey;
                          Free;
                        end;
                      ModeSwitcherClick(MI_Mode_Measures);
                      Exit;
                    end;
                end
              else
                begin
                  MessageDlg('Неизвеcтный пользователь!', mtError, [mbOk], 0);
                  ACTION_DisconnectFromMySQLServer.Execute;
                  Exit;
                end;
            finally
              mysql_free_result(ResultSet_LookupBase);
            end;
        end
      else
        ACTION_DisconnectFromMySQLServer.Execute;
    finally
      Free;
    end;
end;

procedure TMainForm.TryReconnectToServer;
(* процедура выполняет пинг сервера или подключение к серверу в случае отсутствия подключения *)
begin
  if MySQLConnectionHandler=nil then
    ACTION_ConnectToMySQLServer.Execute
  else
    mysql_ping(MySQLConnectionHandler);
end;

procedure TMainForm.ACTION_DisconnectFromMySQLServerExecute(Sender: TObject);
begin
  ACTION_ConnectToMySQLServer.Visible:=True;
  ACTION_DisconnectFromMySQLServer.Visible:=False;
  if MySQLConnectionHandler<>nil then
    begin
      mysql_close(MySQLConnectionHandler);
      MySQLConnectionHandler:=nil;
    end;
  MainForm.Caption:=Application.Title;
  sUserLogin:='';
  sUserPwd:='';
  sUserRealName:='';
  iUserID:=-1;
  bUserIsAdmin:=False;
  UpdateAllControls;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=False;
  if (MessageDlg('Вы действитьно хотите выйти из программы?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      if ACTION_DisconnectFromMySQLServer.Visible then
        ACTION_DisconnectFromMySQLServer.Execute;
      CanClose:=True;
    end;
  if CanClose then
    begin
      with TRegistry.Create do
        try
          RootKey:=HKEY_CURRENT_USER;
          if OpenKey('\Software\Vlad DraCooLa\OPERARM', True) then
            try
              WriteBool('MaximizeWindowOnStartUp', (MainForm.WindowState=wsMaximized));
              WriteInteger('MainWindowTop', MainForm.Top);
              WriteInteger('MainWindowLeft', MainForm.Left);
              WriteInteger('MainWindowHeight', MainForm.Height);
              WriteInteger('MainWindowWidth', MainForm.Width);
            except
              on ERegistryException do
                MessageDlg('Произошла ошибка при попытки записи текущей конфигурации в реестр! Обратитесь к администратору!', mtError, [mbOk], 0);
            end;
        finally
          CloseKey;
          Free;
        end;
    end;
end;

procedure TMainForm.UpdateMeasureList;
(* процедура обновления списка мероприятий *)
var
  q: string;
  i, j, k, MaxWidth, alw: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  Screen.Cursor:=crHourGlass;
  q:='SELECT'+' measures.id,'+' organizationtypes.organizationtype,'+' organizationnames.organizationname as a,'+' measuretypes.measuretype,'+' measurenames.measurename,'+' measureauthors.measureauthor,'+' measureproducers.measureproducer,'+
    ' DATE_FORMAT(measures.measurestartdatetime, "%d-%m-%Y %T"),'+' DATE_FORMAT(measures.measurestopdatetime, "%d-%m-%Y %T"),'+' measures.measureticketprice,'+' measures.measureduration,'+' measures.measureperformer,'+' measures.measureorganizer,'+
    ' measures.measureinfo,'+' measures.measurepremier,'+' measures.teenagersmeasure,'+' measures.childrenmeasure,'+' users.realname,'+' DATE_FORMAT(measures.LMTS,"%d.%m.%Y   %H:%i:%S")'+' FROM measures'+
    ' LEFT JOIN organizationtypes ON (organizationtypes.id=measures.organizationtypeid)'+' LEFT JOIN organizationnames ON (organizationnames.id=measures.organizationnameid)'+' LEFT JOIN measuretypes ON (measuretypes.id=measures.measuretypeid)'+
    ' LEFT JOIN measurenames ON (measurenames.id=measures.measurenameid)'+' LEFT JOIN measureauthors ON (measureauthors.id=measures.measureauthorid)'+' LEFT JOIN measureproducers ON (measureproducers.id=measures.measureproducerid)'+
    ' LEFT JOIN users ON (users.id=measures.ridcreatorid)'+sMeasureFilter+' ORDER by a, measures.measurestartdatetime;';
  LogThis('QUERY: '+q);
  if not TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      Screen.Cursor:=crDefault;
      Exit;
    end;
  ResultSet:=mysql_store_result(MySQLConnectionHandler);
  if ResultSet=nil then
    begin
      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURES!'+HR+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError, [mbOK], 0);
      Screen.Cursor:=crDefault;
      Exit;
    end
  else
    try
      alw:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'AlignColumnWidth');
      if alw=-1 then
        alw:=0;
      // временное отключение  отображения таблицы строк для ускорения процесса заполнения значениями
      SG_Mode_Measures.Visible:=False;
      with SG_Mode_Measures do
        begin
          // предвариетельная очистка таблицы строк
          for i:=0 to ColCount-1 do
            Cols[i].Clear;
          // устанавливаем размерность таблицы строк
          ColCount:=19;
          if ColCount>1 then
            FixedCols:=1;
          FixedRows:=1;
          RowCount:=mysql_num_rows(ResultSet)+1;
          // задание строк строки статуса
          // SetStatusBarPanels(IntToStr(RowCount-1)+' строк найдено','');
          // установка заголовков столбцов
          Cells[0, 0]:='RID';
          Cells[1, 0]:='Тип организации';
          Cells[2, 0]:='Наименование организации';
          Cells[3, 0]:='Тип мероприятия';
          Cells[4, 0]:='Наименование мероприятия';
          Cells[5, 0]:='Автор мероприятия';
          Cells[6, 0]:='Режиссёр мероприятия';
          Cells[7, 0]:='Дата/время начала мероприятия';
          Cells[8, 0]:='Дата/время окончания мероприятия';
          Cells[9, 0]:='Стоимость билетов';
          Cells[10, 0]:='Продолжительность мероприятия';
          Cells[11, 0]:='Исполнитель мероприятия';
          Cells[12, 0]:='Организатор мероприятия';
          Cells[13, 0]:='Прочая информация о мероприятии';
          Cells[14, 0]:='Премьера';
          Cells[15, 0]:='Для подростков';
          Cells[16, 0]:='Для детей';
          Cells[17, 0]:='Оператор';
          Cells[18, 0]:='Дата и время модификации';
          // перебор всех строк выборки
          for j:=0 to RowCount-2 do
            begin
              // получаем очередную строку
              ResultRow:=mysql_fetch_row(ResultSet);
              // перебираем все столбцы (поля) внутри строки
              for i:=0 to ColCount-1 do
                begin
                  // вносим значения строк в таблицу строк
                  case i of
                    0..13:
                      Cells[i, j+1]:=string(ResultRow[i]);
                    14..16:
                      begin
                        Cells[i, j+1]:='Нет';
                        if string(ResultRow[i])<>'' then
                          if string(ResultRow[i])='1' then
                            Cells[i, j+1]:='Да';
                      end;
                    17..18:
                      Cells[i, j+1]:=string(ResultRow[i]);
                  end;
                end;
            end;
          for i:=0 to ColCount-1 do
            ColWidths[i]:=0; // установка длины столбцов в ноль
          for i:=0 to ColCount-1 do // установка длины столбцов по длине содержимого столбцов
            begin
              MaxWidth:=-1;
              case alw of
                0:
                  begin
                    for j:=1 to RowCount-1 do
                      begin
                        k:=SG_Mode_Measures.Canvas.TextWidth(Cells[i, j])+5;
                        if MaxWidth<k then
                          MaxWidth:=k;
                      end;
                  end;
                1:
                  begin
                    k:=SG_Mode_Measures.Canvas.TextWidth(Cells[i, 0])+5;
                    if MaxWidth<k then
                      MaxWidth:=k
                  end;
                2:
                  begin
                    for j:=0 to RowCount-1 do
                      begin
                        k:=SG_Mode_Measures.Canvas.TextWidth(Cells[i, j])+5;
                        if MaxWidth<k then
                          MaxWidth:=k;
                      end;
                  end;
              end;
              ColWidths[i]:=MaxWidth;
            end;
        end;
      SG_Mode_Measures.Visible:=True;
    finally
      mysql_free_result(ResultSet); // и в заключении освободить выборку
      with SG_Mode_Measures do
        if (RowCount=1) then
          begin
            RowCount:=2;
            FixedRows:=1;
            MessageDlg('По указанным Вами параметрам не было найдено ни одной записи!'+HR+'Вам рекомендуется проверить корректность поставленых условий отбора.', mtWarning, [mbOk], 0);
          end;
    end;
  UpdateAllControls;
  if MI_WebBrowser.Checked then
    WebBrowser1.Navigate(sWebQuery+SG_Mode_Measures.Cells[0, SG_Mode_Measures.Row]);
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.UpdateOrganizationList;
(* процедура обновления списка организаций *)
var
  q: string;
  i, j, k, MaxWidth, alw: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  Screen.Cursor:=crHourGlass;
  q:='SELECT organizationnames.id, '+'organizationtypes.organizationtype, '+'organizationnames.organizationname, '+'organizationnames.organizationaddress, '+'organizationnames.organizationhowtoreach, '+'organizationnames.organizationphones, '+
    'organizationnames.organizationinfo, '+'DATE_FORMAT(organizationnames.LMTS,"%d.%m.%Y   %H:%i:%S") '+'FROM organizationnames LEFT JOIN organizationtypes ON (organizationtypes.id=organizationnames.organizationtypeid)'+sOrganizationFilter+
    ' ORDER BY organizationnames.id;';
  LogThis('QUERY: '+q);
  if not TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      Screen.Cursor:=crDefault;
      Exit;
    end;
  ResultSet:=mysql_store_result(MySQLConnectionHandler);
  if ResultSet=nil then
    begin
      MessageDlg('Не удалось получить результирующую выборку из таблиц ORGANIZATIONNAMES, ORGANIZATUIONTYPES!'+HR+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
        mtError, [mbOK], 0);
      Screen.Cursor:=crDefault;
      Exit;
    end
  else
    try
      alw:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'AlignColumnWidth');
      if alw=-1 then
        alw:=0;
      // временное отключение  отображения таблицы строк для ускорения процесса заполнения значениями
      SG_Mode_Organizations.Visible:=False;
      with SG_Mode_Organizations do
        begin
          // предвариетельная очистка таблицы строк
          for i:=0 to ColCount-1 do
            Cols[i].Clear;
          // устанавливаем размерность таблицы строк
          ColCount:=8;
          if ColCount>1 then
            FixedCols:=1;
          FixedRows:=1;
          RowCount:=mysql_num_rows(ResultSet)+1;
          (* // задание строк строки статуса
            SetStatusBarPanels(IntToStr(RowCount-1)+' строк найдено',''); *)
          // установка заголовков столбцов
          Cells[0, 0]:='RID';
          Cells[1, 0]:='Тип организации';
          Cells[2, 0]:='Наименование организации';
          Cells[3, 0]:='Адрес организации';
          Cells[4, 0]:='Как добраться';
          Cells[5, 0]:='Контактные телефоны';
          Cells[6, 0]:='Прочая информация';
          Cells[7, 0]:='Дата и время модификации';
          // перебор всех строк выборки
          for j:=0 to RowCount-2 do
            begin
              // получаем очередную строку
              ResultRow:=mysql_fetch_row(ResultSet);
              // перебираем все столбцы (поля) внутри строки
              for i:=0 to ColCount-1 do
                begin
                  // вносим значения строк в таблицу строк
                  case i of
                    0..7:
                      Cells[i, j+1]:=string(ResultRow[i]);
                  end;
                end;
            end;
          for i:=0 to ColCount-1 do
            ColWidths[i]:=0; // установка длины столбцов в ноль
          for i:=0 to ColCount-1 do // установка длины столбцов по длине содержимого столбцов
            begin
              MaxWidth:=-1;
              case alw of
                0:
                  begin
                    for j:=1 to RowCount-1 do
                      begin
                        k:=SG_Mode_Organizations.Canvas.TextWidth(Cells[i, j])+5;
                        if MaxWidth<k then
                          MaxWidth:=k;
                      end;
                  end;
                1:
                  begin
                    k:=SG_Mode_Organizations.Canvas.TextWidth(Cells[i, 0])+5;
                    if MaxWidth<k then
                      MaxWidth:=k
                  end;
                2:
                  begin
                    for j:=0 to RowCount-1 do
                      begin
                        k:=SG_Mode_Organizations.Canvas.TextWidth(Cells[i, j])+5;
                        if MaxWidth<k then
                          MaxWidth:=k;
                      end;
                  end;
              end;
              ColWidths[i]:=MaxWidth;
            end;
        end;
      SG_Mode_Organizations.Visible:=True;
    finally
      mysql_free_result(ResultSet); // и в заключении освободить выборку
      with SG_Mode_Organizations do
        if (RowCount=1) then
          begin
            RowCount:=2;
            FixedRows:=1;
            MessageDlg('По указанным Вами параметрам не было найдено ни одной записи!'+HR+'Вам рекомендуется проверить корректность поставленых условий отбора.', mtWarning, [mbOk], 0);
          end;
    end;
  UpdateAllControls;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.UpdateUserList;
(* процедура обновления списка пользователей *)
var
  q: string;
  i, j, k, MaxWidth, alw: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  Screen.Cursor:=crHourGlass;
  q:='SELECT id, name, password, realName, editor, administrator FROM users'+sUserFilter+' ORDER BY id;';
  LogThis('QUERY: '+q);
  if not TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      Screen.Cursor:=crDefault;
      Exit;
    end;
  ResultSet:=mysql_store_result(MySQLConnectionHandler);
  if ResultSet=nil then
    begin
      MessageDlg('Не удалось получить результирующую выборку из таблицы USERS!'+HR+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError, [mbOK], 0);
      Screen.Cursor:=crDefault;
      Exit;
    end
  else
    try
      alw:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'AlignColumnWidth');
      if alw=-1 then
        alw:=0;
      // временное отключение  отображения таблицы строк для ускорения процесса заполнения значениями
      SG_Mode_Users.Visible:=False;
      with SG_Mode_Users do
        begin
          // предвариетельная очистка таблицы строк
          for i:=0 to ColCount-1 do
            Cols[i].Clear;
          // устанавливаем размерность таблицы строк
          ColCount:=6;
          if ColCount>1 then
            FixedCols:=1;
          FixedRows:=1;
          RowCount:=mysql_num_rows(ResultSet)+1;
          (* // задание строк строки статуса
            SetStatusBarPanels(IntToStr(RowCount-1)+' строк найдено',''); *)
          // установка заголовков столбцов
          Cells[0, 0]:='RID';
          Cells[1, 0]:='Логин';
          Cells[2, 0]:='Пароль';
          Cells[3, 0]:='Имя пользователя';
          Cells[4, 0]:='Оператор';
          Cells[5, 0]:='Администратор';
          // перебор всех строк выборки
          for j:=0 to RowCount-2 do
            begin
              // получаем очередную строку
              ResultRow:=mysql_fetch_row(ResultSet);
              // перебираем все столбцы (поля) внутри строки
              for i:=0 to ColCount-1 do
                begin
                  // вносим значения строк в таблицу строк
                  case i of
                    0..3:
                      Cells[i, j+1]:=string(ResultRow[i]);
                    4, 5:
                      if string(ResultRow[i])='1' then
                        Cells[i, j+1]:='Да'
                      else
                        Cells[i, j+1]:='Нет';
                  end;
                end;
            end;
          for i:=0 to ColCount-1 do
            ColWidths[i]:=0; // установка длины столбцов в ноль
          for i:=0 to ColCount-1 do // установка длины столбцов по длине содержимого столбцов
            begin
              MaxWidth:=-1;
              case alw of
                0:
                  begin
                    for j:=1 to RowCount-1 do
                      begin
                        k:=SG_Mode_Users.Canvas.TextWidth(Cells[i, j])+5;
                        if MaxWidth<k then
                          MaxWidth:=k;
                      end;
                  end;
                1:
                  begin
                    k:=SG_Mode_Users.Canvas.TextWidth(Cells[i, 0])+5;
                    if MaxWidth<k then
                      MaxWidth:=k
                  end;
                2:
                  begin
                    for j:=0 to RowCount-1 do
                      begin
                        k:=SG_Mode_Users.Canvas.TextWidth(Cells[i, j])+5;
                        if MaxWidth<k then
                          MaxWidth:=k;
                      end;
                  end;
              end;
              ColWidths[i]:=MaxWidth;
            end;
        end;
      SG_Mode_Users.Visible:=True;
    finally
      mysql_free_result(ResultSet); // и в заключении освободить выборку
      with SG_Mode_Users do
        if (RowCount=1) then
          begin
            RowCount:=2;
            FixedRows:=1;
            MessageDlg('По указанным Вами параметрам не было найдено ни одной записи!'+HR+'Вам рекомендуется проверить корректность поставленых условий отбора.', mtWarning, [mbOk], 0);
          end;
    end;
  UpdateAllControls;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.UpdateReplacedPhonesList;
(* процедура обновления списка изменённых номеров телефонов *)
var
  // q: string;
  i, j, k, MaxWidth, alw: integer;
  // ResultSet: PMYSQL_RES;
  // ResultRow: PMYSQL_ROW;
begin
  Screen.Cursor:=crHourGlass;
  try
    alw:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'AlignColumnWidth');
    if alw=-1 then
      alw:=0;
    // временное отключение  отображения таблицы строк для ускорения процесса заполнения значениями
    SG_Mode_ReplacedPhones.Visible:=False;
    with SG_Mode_ReplacedPhones do
      begin
        // предвариетельная очистка таблицы строк
        for i:=0 to ColCount-1 do
          Cols[i].Clear;
        // устанавливаем размерность таблицы строк
        ColCount:=5;
        if ColCount>1 then
          FixedCols:=1;
        FixedRows:=1;
        RowCount:=1;
        (* // задание строк строки статуса
          SetStatusBarPanels(IntToStr(RowCount-1)+' строк найдено',''); *)
        // установка заголовков столбцов
        Cells[0, 0]:='№ п/п';
        Cells[1, 0]:='Старый номер телефона';
        Cells[2, 0]:='Новый номер телефона';
        Cells[3, 0]:='Режим';
        Cells[4, 0]:='Наименование поля';

        (* !!!ДОПИСАТЬ!!! *)

        for i:=0 to ColCount-1 do
          ColWidths[i]:=0; // установка длины столбцов в ноль
        for i:=0 to ColCount-1 do // установка длины столбцов по длине содержимого столбцов
          begin
            MaxWidth:=-1;
            case alw of
              0:
                begin
                  for j:=1 to RowCount-1 do
                    begin
                      k:=SG_Mode_ReplacedPhones.Canvas.TextWidth(Cells[i, j])+5;
                      if MaxWidth<k then
                        MaxWidth:=k;
                    end;
                end;
              1:
                begin
                  k:=SG_Mode_ReplacedPhones.Canvas.TextWidth(Cells[i, 0])+5;
                  if MaxWidth<k then
                    MaxWidth:=k
                end;
              2:
                begin
                  for j:=0 to RowCount-1 do
                    begin
                      k:=SG_Mode_ReplacedPhones.Canvas.TextWidth(Cells[i, j])+5;
                      if MaxWidth<k then
                        MaxWidth:=k;
                    end;
                end;
            end;
            ColWidths[i]:=MaxWidth;
          end;
      end;
    SG_Mode_ReplacedPhones.Visible:=True;
  finally
    with SG_Mode_ReplacedPhones do
      if (RowCount=1) then
        begin
          RowCount:=2;
          FixedRows:=1;
          MessageDlg('Изменений номеров телефонов не зафиксировано.', mtInformation, [mbOk], 0);
        end;
  end;
  UpdateAllControls;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.UpdateCurrentList;
begin
  LogThis('Обновление списка записей');
  case GetCurrentMode of
    0:
      UpdateMeasureList;
    1:
      UpdateOrganizationList;
    2:
      UpdateUserList;
    3:
      UpdateReplacedPhonesList;
  end;
end;

procedure TMainForm.ACTION_UpdateRecordsExecute(Sender: TObject);
begin
  UpdateCurrentList;
end;

procedure TMainForm.ACTION_ApplyCurrentFilterExecute(Sender: TObject);
var
  s, s1: string;
  SL: TStringList;

  procedure QtoS(c: TComboBox; sf: string; var a: string);
  var
    i: integer;
    s2: string;
  begin
    with c do
      if Enabled and(Text<>'') then
        begin
          s2:=Trim(Text);
          while Pos('  ', s2)>0 do
            s2:=StringReplace(s2, '  ', ' ', [rfReplaceAll]);
          CutStringByLimiterToStringList(s2, SL, ' ');
          i:=SL.Count;
          if i>0 then
            begin
              if a<>'' then
                a:=a+' AND ';
              a:=a+'(';
              s1:='';
              while (SL.Count>0) do
                begin
                  if s1<>'' then
                    s1:=s1+' AND ';
                  (* s1:=s1+'(('+sf+' LIKE UPPER('+#39+SL.Strings[0]+'%'+#39+
                    ')) OR ('+sf+' LIKE UPPER('+#39+'\"'+SL.Strings[0]+'%'+#39+
                    ')) OR ('+sf+' LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+
                    ')) OR ('+sf+' LIKE UPPER('+#39+'% \"'+SL.Strings[0]+'%'+#39+
                    ')) OR ('+sf+' LIKE UPPER('+#39+'% ('+SL.Strings[0]+'%'+#39+
                    ')) OR ('+sf+' LIKE UPPER('+#39+'% ['+SL.Strings[0]+'%'+#39+
                    ')) OR ('+sf+' LIKE UPPER('+#39+'% {'+SL.Strings[0]+'%'+#39+
                    ')) OR ('+sf+' LIKE UPPER('+#39+'% #'+SL.Strings[0]+'%'+#39+
                    ')) OR ('+sf+' LIKE UPPER('+#39+'% №'+SL.Strings[0]+'%'+#39+
                    ')))';
                    *)
                  s1:=s1+'(UPPER('+sf+') LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
                  SL.Delete(0);
                end;
              a:=a+s1+')';
            end;
        end;
  end;

begin
  LogThis('Применение фильтрации по введённым пользователем параметрам отбора');
  s:='';
  SL:=TStringList.Create;
  try
    case GetCurrentMode of
      //
      0:
        begin
          QtoS(COMBOBOX_OrganizationType, 'organizationtypes.organizationtype', s);
          QtoS(COMBOBOX_OrganizationName, 'organizationnames.organizationname', s);
          QtoS(COMBOBOX_MeasureType, 'measuretypes.measuretype', s);
          QtoS(COMBOBOX_MeasureName, 'measurenames.measurename', s);
          QtoS(COMBOBOX_MeasureAuthor, 'measureauthors.measureauthor', s);
          QtoS(COMBOBOX_MeasureProducer, 'measureproducers.measureproducer', s);
          QtoS(COMBOBOX_MeasureInfo, 'measureinfo', s);
          // QtoS(COMBOBOX_MeasureInfo,'organizationnames.organizationinfo',s);
          with DATETIMEPICKER_MeasureStartDate do
            if Enabled then
              begin
                if s<>'' then
                  s:=s+' AND ';
                s:=s+'measures.measurestartdatetime>='+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', DateTime)+#39;
              end;
          with DATETIMEPICKER_MeasureStopDate do
            if Enabled then
              begin
                if s<>'' then
                  s:=s+' AND ';
                s:=s+'measures.measurestopdatetime<='+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', DateTime)+#39;
              end;
          if CHECKBOX_MeasurePremier.Checked then
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'measures.measurepremier='+#39+'1'+#39;
            end;
          if CHECKBOX_ChildrenMeasure.Checked then
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'measures.childrenmeasure='+#39+'1'+#39;
            end;
          if CHECKBOX_TeenagerMeasure.Checked then
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'measures.teenagersmeasure='+#39+'1'+#39;
            end;
          if s<>'' then
            s:=' WHERE '+s;
          sMeasureFilter:=s;
          BUTTON_Apply_Mode_Measures.Font.Style:=BUTTON_Apply_Mode_Measures.Font.Style-[fsBold];
        end;
      //
      1:
        begin
          QtoS(COMBOBOX_OrganizationType2, 'organizationtypes.organizationtype', s);
          QtoS(COMBOBOX_OrganizationName2, 'organizationnames.organizationname', s);
          QtoS(COMBOBOX_OrganizationAddress, 'organizationnames.organizationaddress', s);
          QtoS(COMBOBOX_OrganizationHowToReach, 'organizationnames.organizationhowtoreach', s);
          QtoS(COMBOBOX_OrganizationPhones, 'organizationnames.organizationphones', s);
          QtoS(COMBOBOX_OrganizationInfo, 'organizationnames.organizationinfo', s);
          if s<>'' then
            s:=' WHERE '+s;
          sOrganizationFilter:=s;
          BUTTON_Apply_Mode_Organizations.Font.Style:=BUTTON_Apply_Mode_Organizations.Font.Style-[fsBold];
        end;
      //
      2:
        begin
          if CB_DBOperator.Checked then
            s:='users.editor='+#39+'1'+#39;
          if CB_DBAdministrator.Checked then
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'users.administrator='+#39+'1'+#39;
            end;
          if s<>'' then
            s:=' WHERE '+s;
          sUserFilter:=s;
          BUTTON_Apply_Mode_Users.Font.Style:=BUTTON_Apply_Mode_Users.Font.Style-[fsBold];
        end;
      3:
        begin
          (* !!!ДОПИСАТЬ!!! *)
        end;
    end;
  finally
    SL.Free;
  end;
  LogThis('FILTER: '+s);
  UpdateCurrentList;
end;

procedure TMainForm.DATETIMEPICKER_MeasureStartTimeChange(Sender: TObject);
begin
  DATETIMEPICKER_MeasureStartDate.Time:=DATETIMEPICKER_MeasureStartTime.Time;
end;

procedure TMainForm.DATETIMEPICKER_MeasureStopTimeChange(Sender: TObject);
begin
  DATETIMEPICKER_MeasureStopDate.Time:=DATETIMEPICKER_MeasureStopTime.Time;
end;

procedure TMainForm.DATETIMEPICKER_MeasureStartDateChange(Sender: TObject);
begin
  DATETIMEPICKER_MeasureStartTime.Date:=DATETIMEPICKER_MeasureStartDate.Date;
end;

procedure TMainForm.DATETIMEPICKER_MeasureStopDateChange(Sender: TObject);
begin
  DATETIMEPICKER_MeasureStopTime.Date:=DATETIMEPICKER_MeasureStopDate.Date;
end;

procedure TMainForm.ACTION_DeleteRecordExecute(Sender: TObject);
var
  s, s1, q: string;
  i: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  case GetCurrentMode of
    0:
      begin
        LogThis('Удаление мероприятия');
        i:=SG_Mode_Measures.Row;
        s:=SG_Mode_Measures.Cells[0, i];
        q:='НОМЕР ЗАПИСИ (RID):'+HR+s+HR;
        if SG_Mode_Measures.Cells[1, i]<>'' then
          q:=q+RN+'ТИП ОРГАНИЗАЦИИ:'+HR+SG_Mode_Measures.Cells[1, i]+HR;
        if SG_Mode_Measures.Cells[2, i]<>'' then
          q:=q+RN+'НАИМЕНОВАНИЕ ОРГАНИЗАЦИИ:'+HR+SG_Mode_Measures.Cells[2, i]+HR;
        if SG_Mode_Measures.Cells[3, i]<>'' then
          q:=q+RN+'ТИП МЕРОПРИЯТИЯ:'+HR+SG_Mode_Measures.Cells[3, i]+HR;
        if SG_Mode_Measures.Cells[4, i]<>'' then
          q:=q+RN+'НАИМЕНОВАНИЕ МЕРОПРИЯТИЯ:'+HR+SG_Mode_Measures.Cells[4, i]+HR;
        if SG_Mode_Measures.Cells[5, i]<>'' then
          q:=q+RN+'АВТОР МЕРОПРИЯТИЯ:'+HR+SG_Mode_Measures.Cells[5, i]+HR;
        if SG_Mode_Measures.Cells[6, i]<>'' then
          q:=q+RN+'РЕЖИССЁР МЕРОПРИЯТИЯ:'+HR+SG_Mode_Measures.Cells[6, i]+HR;
        if SG_Mode_Measures.Cells[7, i]<>'' then
          q:=q+RN+'ДАТА/ВРЕМЯ НАЧАЛА МЕРОПРИЯТИЯ:'+HR+SG_Mode_Measures.Cells[7, i]+HR;
        if SG_Mode_Measures.Cells[8, i]<>'' then
          q:=q+RN+'ДАТА/ВРЕМЯ ОКОНЧАНИЯ МЕРОПРИЯТИЯ:'+HR+SG_Mode_Measures.Cells[8, i]+HR;
        if SG_Mode_Measures.Cells[9, i]<>'' then
          q:=q+RN+'СТОИМОСТЬ БИЛЕТОВ:'+HR+SG_Mode_Measures.Cells[9, i]+HR;
        if SG_Mode_Measures.Cells[10, i]<>'' then
          q:=q+RN+'ПРОДОЛЖИТЕЛЬНОСТЬ МЕРОПРИЯТИЯ:'+HR+SG_Mode_Measures.Cells[10, i]+HR;
        if SG_Mode_Measures.Cells[11, i]<>'' then
          q:=q+RN+'ИСПОЛНИТЕЛЬ МЕРОПРИЯТИЯ:'+HR+SG_Mode_Measures.Cells[11, i]+HR;
        if SG_Mode_Measures.Cells[12, i]<>'' then
          q:=q+RN+'ОРГАНИЗАТОР МЕРОПРИЯТИЯ:'+HR+SG_Mode_Measures.Cells[12, i]+HR;
        if SG_Mode_Measures.Cells[13, i]<>'' then
          q:=q+RN+'ПРОЧАЯ ИНФОРМАЦИЯ О МЕРОПРИЯТИИ:'+HR+SG_Mode_Measures.Cells[13, i]+HR;
        if SG_Mode_Measures.Cells[14, i]='Да' then
          q:=q+RN+'ПРЕМЬЕРА'+HR;
        if SG_Mode_Measures.Cells[15, i]='Да' then
          q:=q+RN+'ДЛЯ ПОДРОСТКОВ'+HR;
        if SG_Mode_Measures.Cells[16, i]='Да' then
          q:=q+RN+'ДЛЯ ДЕТЕЙ'+HR;
        if SG_Mode_Measures.Cells[17, i]<>'' then
          q:=q+RN+'СОЗДАТЕЛЬ ДАННОЙ ЗАПИСИ:'+HR+SG_Mode_Measures.Cells[17, i]+HR;
        if SG_Mode_Measures.Cells[18, i]<>'' then
          q:=q+RN+'ДАТА И ВРЕМЯ МОДИФИКАЦИИ:'+HR+SG_Mode_Measures.Cells[18, i]+HR;
        q:=q+RN+'Вы действитьно хотите удалить данную запись?';
        if (MessageDlg(q, mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
          begin
            LogThis('Сохранение записи в таблице ERASEDMEASURES...');
            q:='INSERT INTO erasedmeasures SELECT * FROM measures WHERE id='+s+';';
            LogThis('QUERY: '+q);
            if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
              begin
                LogThis('Ошибка!');
                if bExitOnError then
                  Exit;
              end
            else
              LogThis('Ok');
            LogThis('Удаление записи из таблицы MEASURES...');
            q:='DELETE FROM measures WHERE id='+s+';';
            LogThis('QUERY: '+q);
            if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
              begin
                LogThis('Ошибка!');
                if bExitOnError then
                  Exit;
              end
            else
              LogThis('Ok');
            ACTION_UpdateRecords.Execute;
            if MI_WebBrowser.Checked then
              WebBrowser1.Navigate(sWebQuery+SG_Mode_Measures.Cells[0, SG_Mode_Measures.Row]);
            if SG_Mode_Measures.Visible then
              SG_Mode_Measures.SetFocus;
          end
        else
          LogThis('Операция отменена пользователем');
      end;
    1:
      begin
        LogThis('Удаление организации');
        i:=SG_Mode_Organizations.Row;
        s:=SG_Mode_Organizations.Cells[0, i];
        LogThis('Получение количества мероприятий, связанных с организацией');
        q:='SELECT COUNT(*) FROM measures WHERE organizationnameid='+s+';';
        LogThis('QUERY: '+q);
        if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
          begin
            ResultSet:=mysql_store_result(MySQLConnectionHandler);
            try
              if ResultSet=nil then
                begin
                  LogThis('ERROR: Выборка пуста!');
                  if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                        (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
                    Exit;
                end;
              ResultRow:=mysql_fetch_row(ResultSet);
              s1:=string(ResultRow[0]);
              LogThis('Найдено записей: '+s1);
            finally
              if ResultSet<>nil then
                mysql_free_result(ResultSet);
            end;
          end;
        q:='НОМЕР ЗАПИСИ (RID):'+HR+s+HR;
        if SG_Mode_Organizations.Cells[1, i]<>'' then
          q:=q+RN+'ТИП ОРГАНИЗАЦИИ:'+HR+SG_Mode_Organizations.Cells[1, i]+HR;
        if SG_Mode_Organizations.Cells[2, i]<>'' then
          q:=q+RN+'НАИМЕНОВАНИЕ ОРГАНИЗАЦИИ:'+HR+SG_Mode_Organizations.Cells[2, i]+HR;
        if SG_Mode_Organizations.Cells[3, i]<>'' then
          q:=q+RN+'АДРЕС ОРГАНИЗАЦИИ:'+HR+SG_Mode_Organizations.Cells[3, i]+HR;
        if SG_Mode_Organizations.Cells[4, i]<>'' then
          q:=q+RN+'КАК ДОБРАТЬСЯ:'+HR+SG_Mode_Organizations.Cells[4, i]+HR;
        if SG_Mode_Organizations.Cells[5, i]<>'' then
          q:=q+RN+'КОНТАКТНЫЕ ТЕЛЕФОНЫ:'+HR+SG_Mode_Organizations.Cells[5, i]+HR;
        if SG_Mode_Organizations.Cells[6, i]<>'' then
          q:=q+RN+'ПРОЧАЯ ИНФОРМАЦИЯ:'+HR+SG_Mode_Organizations.Cells[6, i]+HR;
        if SG_Mode_Organizations.Cells[7, i]<>'' then
          q:=q+RN+'ДАТА И ВРЕМЯ МОДИФИКАЦИИ:'+HR+SG_Mode_Organizations.Cells[7, i]+HR;
        q:=q+RN+'Вы действитьно хотите удалить данную запись и все мероприятия (общим количеством '+s1+'), связанные с данной записью?';
        if (MessageDlg(q, mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
          begin
            LogThis('Сохранение записей в таблице ERASEDMEASURES...');
            q:='INSERT INTO erasedmeasures SELECT * FROM measures WHERE organizationnameid='+s+';';
            LogThis('QUERY: '+q);
            if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
              begin
                LogThis('Ошибка!');
                if bExitOnError then
                  Exit;
              end
            else
              LogThis('Ok');
            LogThis('Удаление записей из таблицы MEASURES...');
            q:='DELETE FROM measures WHERE organizationnameid='+s+';';
            LogThis('QUERY: '+q);
            if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
              begin
                LogThis('Ошибка!');
                if bExitOnError then
                  Exit;
              end
            else
              LogThis('Ok');
            LogThis('Сохранение записи в таблице ERASEDORGANIZATIONNAMES...');
            q:='INSERT INTO erasedorganizationnames SELECT * FROM organizationnames WHERE id='+s+';';
            LogThis('QUERY: '+q);
            if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
              begin
                LogThis('Ошибка!');
                if bExitOnError then
                  Exit;
              end
            else
              LogThis('Ok');
            LogThis('Удаление записи из таблицы ORGANIZATIONNAMES...');
            q:='DELETE FROM organizationnames WHERE id='+s+';';
            LogThis('QUERY: '+q);
            if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
              begin
                LogThis('Ошибка!');
                if bExitOnError then
                  Exit;
              end
            else
              LogThis('Ok');
            ACTION_UpdateRecords.Execute;
            if SG_Mode_Organizations.Visible then
              SG_Mode_Organizations.SetFocus;
          end
        else
          LogThis('Операция отменена пользователем');
      end;
    2:
      begin
        i:=SG_Mode_Users.Row;
        s:=SG_Mode_Users.Cells[0, i];
        LogThis('Удаление пользователя');
        LogThis('Получение количества мероприятий, внесённых пользователем');
        q:='SELECT COUNT(*) FROM measures WHERE ridcreatorid='+s+';';
        LogThis('QUERY: '+q);
        if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
          begin
            ResultSet:=mysql_store_result(MySQLConnectionHandler);
            try
              if ResultSet=nil then
                begin
                  LogThis('ERROR: Выборка пуста!');
                  if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                        (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
                    Exit;
                end;
              ResultRow:=mysql_fetch_row(ResultSet);
              s1:=string(ResultRow[0]);
              LogThis('Найдено записей: '+s1);
            finally
              if ResultSet<>nil then
                mysql_free_result(ResultSet);
            end;
          end;
        q:='НОМЕР ЗАПИСИ (RID):'+HR+s+HR;
        if SG_Mode_Users.Cells[1, i]<>'' then
          q:=q+RN+'ЛОГИН:'+HR+SG_Mode_Users.Cells[1, i]+HR;
        if SG_Mode_Users.Cells[2, i]<>'' then
          q:=q+RN+'ПАРОЛЬ:'+HR+SG_Mode_Users.Cells[2, i]+HR;
        if SG_Mode_Users.Cells[3, i]<>'' then
          q:=q+RN+'ИМЯ ПОЛЬЗОВАТЕЛЯ:'+HR+SG_Mode_Users.Cells[3, i]+HR;
        if SG_Mode_Users.Cells[4, i]='Да' then
          q:=q+RN+'ОПЕРАТОР'+HR;
        if SG_Mode_Users.Cells[5, i]='Да' then
          q:=q+RN+'АДМИНИСТРАТОР'+HR;
        q:=q+RN+'Вы действитьно хотите удалить данную запись?';
        if (MessageDlg(q, mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
          begin
            Application.ProcessMessages;
            LogThis('Сохранение записи в таблице ERASEDUSERS...');
            q:='INSERT INTO erasedusers SELECT * FROM users WHERE id='+s+';';
            LogThis('QUERY: '+q);
            if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
              begin
                LogThis('Ошибка!');
                if bExitOnError then
                  Exit;
              end
            else
              LogThis('Ok');
            LogThis('Удаление записи из таблицы USERS...');
            q:='DELETE FROM users WHERE id='+s+';';
            LogThis('QUERY: '+q);
            if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
              begin
                LogThis('Ошибка!');
                if bExitOnError then
                  Exit;
              end
            else
              LogThis('Ok');
            if (MessageDlg('Хотите удалить все записи о мероприятиях, внесённых данным пользователем (общим количеством '+s1+')?', mtConfirmation, [mbNo, mbYes], 0)=mrYes) then
              begin
                LogThis('Сохранение записей в таблице ERASEDMEASURES...');
                q:='INSERT INTO erasedmeasures SELECT * FROM measures WHERE ridcreatorid='+s+';';
                LogThis('QUERY: '+q);
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  begin
                    LogThis('Ошибка!');
                    if bExitOnError then
                      Exit;
                  end
                else
                  LogThis('Ok');
                LogThis('Удаление записи из таблицы...');
                q:='DELETE FROM measures WHERE ridcreatorid='+s+';';
                LogThis('QUERY: '+q);
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  begin
                    LogThis('Ошибка!');
                    if bExitOnError then
                      Exit;
                  end
                else
                  LogThis('Ok');
              end
            else
              begin
                LogThis('Удаление ссылок на записи из таблицы MEASURES...');
                q:='UPDATE measures SET ridcreatorid=NULL WHERE ridcreatorid='+s+';';
                LogThis('QUERY: '+q);
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  begin
                    LogThis('Ошибка!');
                    if bExitOnError then
                      Exit;
                  end
                else
                  LogThis('Ok');
              end;
            ACTION_UpdateRecords.Execute;
            if SG_Mode_Users.Visible then
              SG_Mode_Users.SetFocus;
          end
        else
          LogThis('Операция отменена пользователем');
      end;
    3:
      begin
        (* !!!ДОПИСАТЬ!!! *)
      end;
  end;
end;

procedure TMainForm.Maintenance_CorrectUnfinishedMeasures; // коррекция "неоканчивающихся" мероприятий - где поле начала мероприятия заполнено, а поле окончания - нет
var
  q, s1: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  // получение количества попадающих под запрос мероприятий
  LogThis('Корректировка мероприятий, где указана дата начала, но не указана дата окончания');
  LogThis('Получение количества попадающих под действие записей');
  q:='SELECT COUNT(*) FROM measures WHERE (!(measurestartdatetime IS NULL)) AND (measurestopdatetime IS NULL);';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            MessageDlg('Не удалось получить количество записей из таблицы MEASURES, попадающих под корректировку!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0);
            Exit;
          end;
        ResultRow:=mysql_fetch_row(ResultSet);
        s1:=string(ResultRow[0]);
        LogThis('Найдено записей: '+s1);
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if StrToIntDef(s1, 0)=0 then
    begin
      LogThis('CANCEL: Операция отменена, т.к. подходящие записи отсутствуют');
      MessageDlg('В базе отсутствуют записи, где указана дата начала, но не указана дата окончания меропрития.', mtInformation, [mbOk], 0);
      Exit;
    end;
  // непосредственно сама операция
  if (MessageDlg('Вы хотите произвести коррекцию записей о мероприятиях, где указана дата начала, но не указана дата окончания меропрития?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      Application.ProcessMessages;
      LogThis('Корректировка записей в таблице MEASURES...');
      q:='UPDATE measures SET measurestopdatetime=CONCAT(LEFT(measurestartdatetime,10),'+#39+' 23:59:59'+#39+') WHERE (!(measurestartdatetime IS NULL)) AND (measurestopdatetime IS NULL);';
      LogThis('QUERY: '+q);
      if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
        begin
          LogThis('Ошибка!');
          if bExitOnError then
            Exit;
        end
      else
        LogThis('Ok');
    end;
end;

procedure TMainForm.Maintenance_EraseAllMeasuresOutdatedBySelectedDate;
var
  q, s, s1, quantity: string;
  j, k, MaxWidth: integer;
  RF: TReportForm;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  with TSelectDateForm.Create(Self) do
    try
      DateTimePicker1.Date:=Date;
      ShowModal;
    finally
      s:=FormatDateTime('dd.mm.yyyy', DateTimePicker1.DateTime);
      s1:=FormatDateTime('yyyy-mm-dd', DateTimePicker1.DateTime);
      b:=ModalResult=mrOk;
      Free;
    end;
  // получение количества попадающих под запрос мероприятий
  q:='SELECT COUNT(*) FROM measures WHERE (LEFT(measurestopdatetime,10)<'+#39+s1+#39+');';
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            MessageDlg('Не удалось получить количество записей из таблицы MEASURES, попадающих под удаление!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
              mtError, [mbYes, mbNo], 0);
            Exit;
          end;
        ResultRow:=mysql_fetch_row(ResultSet);
        quantity:=string(ResultRow[0]);
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet); // и в заключении освободить выборку
      end;
    end;
  if StrToIntDef(quantity, 0)=0 then
    begin
      MessageDlg('В базе отсутствуют записи с устаревшими на указанную дату ('+DateToStr(Date)+') мероприятиями.', mtInformation, [mbOk], 0);
      Exit;
    end;
  // непосредственно сама операция
  if b=False then
    Exit;
  if (MessageDlg('Вы хотите удалить все записи о мероприятиях (общим количеством '+quantity+'), закончившихся ранее указанной даты ('+s+')?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      RF:=TReportForm.Create(Self);
      try
        RF.Gauge1.MaxValue:=2;
        RF.StringGrid1.ColWidths[0]:=280;
        RF.StringGrid1.ColWidths[1]:=36;
        RF.Show;
        // шаг 1
        RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Сохранение записей в таблице ERASEDMEASURES...';
        q:='INSERT INTO erasedmeasures SELECT * FROM measures WHERE (LEFT(measurestopdatetime,10)<'+#39+s1+#39+');';
        if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
          begin
            RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!';
            if bExitOnError then
              Exit;
          end
        else
          RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
        RF.Gauge1.AddProgress(1);
        RF.Refresh;
        Application.ProcessMessages;
        RF.StringGrid1.RowCount:=RF.StringGrid1.RowCount+1;
        // шаг 2
        RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Удаление записей из таблицы MEASURES...';
        q:='DELETE FROM measures WHERE (LEFT(measurestopdatetime,10)<'+#39+s1+#39+');';
        if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
          RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!'
        else
          RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
        RF.Gauge1.AddProgress(1);
        RF.Refresh;
        Application.ProcessMessages;
      finally
        while RF.Gauge1.Progress<RF.Gauge1.MaxValue do
          RF.Gauge1.AddProgress(1);
        if RF<>nil then
          begin
            RF.Hide;
            with RF.StringGrid1 do
              begin
                for j:=0 to 1 do
                  begin
                    ColWidths[j]:=1;
                    MaxWidth:=1;
                    for k:=0 to RowCount-1 do
                      if MaxWidth<RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5 then
                        MaxWidth:=RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5;
                    ColWidths[j]:=MaxWidth;
                  end;
                if ColWidths[0]+ColWidths[1]<RF.StringGrid1.Width-4 then
                  ColWidths[0]:=RF.StringGrid1.Width-ColWidths[1]-4;
              end;
            RF.Button1.Enabled:=True;
            if GetCurrentMode=0 then
              UpdateCurrentList;
            RF.ShowModal;
            RF.Free;
          end;
      end;
    end;
end;

procedure TMainForm.N30Click(Sender: TObject);
begin
  Maintenance_CorrectUnfinishedMeasures;
end;

procedure TMainForm.N31Click(Sender: TObject);
begin
  Maintenance_EraseAllOutdatedMeasures;
end;

procedure TMainForm.N32Click(Sender: TObject);
begin
  Maintenance_EraseAllMeasuresOutdatedBySelectedDate;
end;

procedure TMainForm.SG_Mode_MeasuresSelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if MI_WebBrowser.Checked then
    WebBrowser1.Navigate(sWebQuery+SG_Mode_Measures.Cells[0, ARow]);
  if SG_Mode_Measures.Visible then
    SG_Mode_Measures.SetFocus;
end;

procedure TMainForm.SG_KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key in [VK_INSERT, VK_ADD, VK_F7] then
    ACTION_AddRecord.Execute;
  if Key in [VK_DELETE, VK_SUBTRACT, VK_F8] then
    ACTION_DeleteRecord.Execute;
  if KEy in [VK_SPACE, VK_RETURN, VK_F4, VK_F2] then
    ACTION_EditRecord.Execute;
end;

procedure TMainForm.ACTION_AddRecordExecute(Sender: TObject);
var
  b: boolean;
  j, k, MaxWidth: integer;
  RF: TReportForm;
  sNewLogin, sNewPwd, sNewRealName, sNewOper, sNewAdmin: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  dtNewMeaStartDateTime, dtNewMeaStopDateTime: TDateTime;
  tNewMeasureDuration: TTime;
  iQuantity, iNewMeaRID, iNewOrgType, iNewOrgName, iNewMeaType, iNewMeaName, iNewMeaAuthor, iNewMeaProducer: integer;
  sNewMeaRID, sNewMeaType, sNewMeaName, sNewMeaAuthor, sNewMeaProducer, sNewMeaTicketPrice, sNewMeaPerformer, sNewMeaOrganizer, sNewMeaInfo: string;
  bNewMeaStartDateTime, bNewMeaStopDateTime, bNewMeaPremier, bNewMeaTeenagers, bNewMeaChildren, bNewMeaAsNew: boolean;
  s, q, sNewOrgTypeRID, sNewOrgRID, sNewOrgType, sNewOrgName, sNewOrgAddress, sNewOrgHowToReach, sNewOrgPhones, sNewOrgInfo: string;
begin
  iQuantity:=-1;
  iNewMeaRID:=-1;
  iNewOrgType:=-1;
  iNewOrgName:=-1;
  iNewMeaType:=-1;
  iNewMeaName:=-1;
  iNewMeaAuthor:=-1;
  iNewMeaProducer:=-1;
  case GetCurrentMode of
    0:
      begin
        with TMeasuresForm.Create(Self) do
          try
            DATETIMEPICKER_StartDate.DateTime:=Now;
            DATETIMEPICKER_StartTime.DateTime:=DATETIMEPICKER_StartDate.DateTime;
            DATETIMEPICKER_StopDate.DateTime:=DATETIMEPICKER_StartDate.DateTime;
            DATETIMEPICKER_StopTime.DateTime:=DATETIMEPICKER_StartDate.DateTime;
            CHECKBOX_AsNew.Checked:=True;
            CHECKBOX_AsNew.Enabled:=False;
            EDIT_MeaOperator.Text:=MainForm.sUserRealName;
            UpdateControlsState;
            ShowModal;
          finally
            b:=ModalResult=mrOk;
            sNewMeaRID:=EDIT_MeaRID.Text;
            sNewOrgType:=COMBOBOX_OrgType.Text;
            sNewOrgName:=COMBOBOX_OrgName.Text;
            sNewMeaType:=COMBOBOX_MeaType.Text;
            sNewMeaName:=COMBOBOX_MeaName.Text;
            sNewMeaAuthor:=COMBOBOX_MeaAuthor.Text;
            sNewMeaProducer:=COMBOBOX_MeaProducer.Text;
            bNewMeaStartDateTime:=CHECKBOX_StartDateTime.Checked;
            dtNewMeaStartDateTime:=DATETIMEPICKER_StartTime.DateTime;
            bNewMeaStopDateTime:=CHECKBOX_StopDateTime.Checked;
            dtNewMeaStopDateTime:=DATETIMEPICKER_StopTime.DateTime;
            tNewMeasureDuration:=DATETIMEPICKER_MeasureDuration.Time;
            sNewMeaTicketPrice:=MEMO_MeaTicketPrice.Text;
            sNewMeaPerformer:=EDIT_MeaPerformer.Text;
            sNewMeaOrganizer:=EDIT_MeaOrganizer.Text;
            sNewMeaInfo:=MEMO_MeaInfo.Text;
            bNewMeaPremier:=CHECKBOX_MeaPremier.Checked;
            bNewMeaTeenagers:=CHECKBOX_MeaTeenagers.Checked;
            bNewMeaChildren:=CHECKBOX_MeaChildren.Checked;
            bNewMeaAsNew:=CHECKBOX_AsNew.Checked;
            Free;
          end;
        if b then
          begin
            // получение RID типа организации
            q:='SELECT organizationtypes.id, COUNT(*) FROM organizationtypes WHERE organizationtypes.organizationtype='+#39+sNewOrgType+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewOrgType:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewOrgType:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // получение RID наименования организации
            q:='SELECT organizationnames.id, COUNT(*) FROM organizationnames WHERE organizationnames.organizationname='+#39+sNewOrgName+#39+' AND organizationnames.organizationtypeid='+#39+IntToStr(iNewOrgType)+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONNAMES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewOrgName:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewOrgName:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // попытка получения RID типа мероприятия
            q:='SELECT measuretypes.id, COUNT(*) FROM measuretypes WHERE measuretypes.measuretype='+#39+sNewMeaType+#39+' AND measuretypes.organizationtypeid='+#39+IntToStr(iNewOrgType)+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURETYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError,
                        [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaType:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaType:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // добавление нового типа мероприятий
            if ((iNewMeaType<0)or(iQuantity<1)) then
              begin
                q:='INSERT INTO measuretypes (id, organizationtypeid, measuretype) VALUES (NULL, '+#39+IntToStr(iNewOrgType)+#39+', '+#39+sNewMeaType+#39+');';
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  if bExitOnError then
                    Exit;
                // получение RID типа мероприятия
                q:='SELECT measuretypes.id, COUNT(*) FROM measuretypes WHERE measuretypes.measuretype='+#39+sNewMeaType+#39+' AND measuretypes.organizationtypeid='+#39+IntToStr(iNewOrgType)+#39+' GROUP BY '+#39+#39+';';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                  begin
                    ResultSet:=mysql_store_result(MySQLConnectionHandler);
                    try
                      if ResultSet=nil then
                        begin
                          MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURETYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                            mtError, [mbOk], 0);
                          Exit;
                        end;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          iNewMeaType:=StrToIntDef(string(ResultRow[0]), -1);
                          iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                        end
                      else
                        Exit;
                    finally
                      if ResultSet<>nil then
                        mysql_free_result(ResultSet);
                    end;
                  end;
              end;
            // попытка получения RID наименования мероприятия
            q:='SELECT measurenames.id, COUNT(*) FROM measurenames WHERE measurenames.measurename='+#39+sNewMeaName+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURENAMES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError,
                        [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaName:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaName:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // добавление нового наименования мероприятий
            if ((iNewMeaName<0)or(iQuantity<1)) then
              begin
                q:='INSERT INTO measurenames (id, measurename) VALUES (NULL, '+#39+sNewMeaName+#39+');';
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  if bExitOnError then
                    Exit;
                // получение RID наименования мероприятия
                q:='SELECT measurenames.id, COUNT(*) FROM measurenames WHERE measurenames.measurename='+#39+sNewMeaName+#39+' GROUP BY '+#39+#39+';';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                  begin
                    ResultSet:=mysql_store_result(MySQLConnectionHandler);
                    try
                      if ResultSet=nil then
                        begin
                          MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURENAMES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                            mtError, [mbOk], 0);
                          Exit;
                        end;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          iNewMeaName:=StrToIntDef(string(ResultRow[0]), -1);
                          iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                        end
                      else
                        Exit;
                    finally
                      if ResultSet<>nil then
                        mysql_free_result(ResultSet);
                    end;
                  end;
              end;
            // попытка получения RID автора мероприятия
            q:='SELECT measureauthors.id, COUNT(*) FROM measureauthors WHERE measureauthors.measureauthor='+#39+sNewMeaAuthor+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREAUTHORS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaAuthor:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaAuthor:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // добавление нового автора мероприятий
            if ((iNewMeaAuthor<0)or(iQuantity<1)) then
              begin
                q:='INSERT INTO measureauthors (id, measureauthor) VALUES (NULL, '+#39+sNewMeaAuthor+#39+');';
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  if bExitOnError then
                    Exit;
                // получение RID автора мероприятия
                q:='SELECT measureauthors.id, COUNT(*) FROM measureauthors WHERE measureauthors.measureauthor='+#39+sNewMeaAuthor+#39+' GROUP BY '+#39+#39+';';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                  begin
                    ResultSet:=mysql_store_result(MySQLConnectionHandler);
                    try
                      if ResultSet=nil then
                        begin
                          MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREAUTHORS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                            mtError, [mbOk], 0);
                          Exit;
                        end;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          iNewMeaAuthor:=StrToIntDef(string(ResultRow[0]), -1);
                          iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                        end
                      else
                        Exit;
                    finally
                      if ResultSet<>nil then
                        mysql_free_result(ResultSet);
                    end;
                  end;
              end;
            // попытка получения RID режиссёра мероприятия
            q:='SELECT measureproducers.id, COUNT(*) FROM measureproducers WHERE measureproducers.measureproducer='+#39+sNewMeaProducer+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREPRODUCERS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaProducer:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaProducer:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // добавление нового автора мероприятий
            if ((iNewMeaProducer<0)or(iQuantity<1)) then
              begin
                q:='INSERT INTO measureproducers (id, measureproducer) VALUES (NULL, '+#39+sNewMeaProducer+#39+');';
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  if bExitOnError then
                    Exit;
                // получение RID автора мероприятия
                q:='SELECT measureproducers.id, COUNT(*) FROM measureproducers WHERE measureproducers.measureproducer='+#39+sNewMeaProducer+#39+' GROUP BY '+#39+#39+';';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                  begin
                    ResultSet:=mysql_store_result(MySQLConnectionHandler);
                    try
                      if ResultSet=nil then
                        begin
                          MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREPRODUCERS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                            mtError, [mbOk], 0);
                          Exit;
                        end;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          iNewMeaProducer:=StrToIntDef(string(ResultRow[0]), -1);
                          iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                        end
                      else
                        Exit;
                    finally
                      if ResultSet<>nil then
                        mysql_free_result(ResultSet);
                    end;
                  end;
              end;
            // проверка на наличие идентичной записи в таблице MEASURES
            q:='SELECT measures.id, COUNT(*) FROM measures WHERE '+'measures.organizationtypeid='+#39+IntToStr(iNewOrgType)+#39+' AND '+'measures.organizationnameid='+#39+IntToStr(iNewOrgName)+#39+' AND '+'measures.measuretypeid='+#39+IntToStr
              (iNewMeaType)+#39+' AND '+'measures.measurenameid='+#39+IntToStr(iNewMeaName)+#39+' AND '+'measures.measureauthorid='+#39+IntToStr(iNewMeaAuthor)+#39+' AND '+'measures.measureproducerid='+#39+IntToStr(iNewMeaProducer)+#39+' AND ';
            if bNewMeaStartDateTime then
              q:=q+'(measures.measurestartdatetime='+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStartDateTime)+#39+') AND '
            else
              q:=q+'(measures.measurestartdatetime IS NULL) AND ';
            if bNewMeaStopDateTime then
              q:=q+'(measures.measurestopdatetime='+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStopDateTime)+#39+') AND '
            else
              q:=q+'(measures.measurestopdatetime IS NULL) AND ';
            if FormatDateTime('hh:nn:ss', tNewMeasureDuration)<>'00:00:00' then
              q:=q+'measures.measureduration='+#39+FormatDateTime('hh:nn:ss', tNewMeasureDuration)+#39+' AND '
            else
              q:=q+'(measures.measureduration IS NULL) AND ';
            if sNewMeaTicketPrice<>'' then
              q:=q+'measures.measureticketprice='+#39+sNewMeaTicketPrice+#39+' AND '
            else
              q:=q+'(measures.measureticketprice IS NULL) AND ';
            if sNewMeaPerformer<>'' then
              q:=q+'measures.measureperformer='+#39+sNewMeaPerformer+#39+' AND '
            else
              q:=q+'(measures.measureperformer IS NULL) AND ';
            if sNewMeaOrganizer<>'' then
              q:=q+'measures.measureorganizer='+#39+sNewMeaOrganizer+#39+' AND '
            else
              q:=q+'(measures.measureorganizer IS NULL) AND ';
            if sNewMeaInfo<>'' then
              q:=q+'measures.measureinfo='+#39+sNewMeaInfo+#39+' AND '
            else
              q:=q+'(measures.measureinfo IS NULL) AND ';
            q:=q+'measures.measurepremier='+#39+IntToStr(integer(bNewMeaPremier))+#39+' AND ';
            q:=q+'measures.teenagersmeasure='+#39+IntToStr(integer(bNewMeaTeenagers))+#39+' AND ';
            q:=q+'measures.childrenmeasure='+#39+IntToStr(integer(bNewMeaChildren))+#39+' AND ';
            q:=q+'measures.ridcreatorid='+#39+IntToStr(iUserID)+#39;
            q:=q+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError,
                        [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaRID:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaRID:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            if (iNewMeaRID>=0)or(iQuantity>0) then
              if (MessageDlg('Найдена запись с данными, идентичными введённым. Вы всё равно хотите добавить данные в базу?', mtConfirmation, [mbYes, mbNo], 0)=mrNo) then
                Exit;
            if bNewMeaAsNew then
              begin
                q:='INSERT INTO measures (id, organizationtypeid, organizationnameid, measuretypeid, measurenameid, '+'measureauthorid, measureproducerid, measurestartdatetime, measurestopdatetime, measureduration, '+
                  'measureticketprice, measureperformer, measureorganizer, measureinfo, measurepremier, teenagersmeasure, '+'childrenmeasure, ridcreatorid) VALUES (NULL, '+#39+IntToStr(iNewOrgType)+#39+', '+#39+IntToStr(iNewOrgName)
                  +#39+', '+#39+IntToStr(iNewMeaType)+#39+', '+#39+IntToStr(iNewMeaName)+#39+', '+#39+IntToStr(iNewMeaAuthor)+#39+', '+#39+IntToStr(iNewMeaProducer)+#39+', ';
                if bNewMeaStartDateTime then
                  q:=q+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStartDateTime)+#39+', '
                else
                  q:=q+'NULL, ';
                if bNewMeaStopDateTime then
                  q:=q+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStopDateTime)+#39+', '
                else
                  q:=q+'NULL, ';
                if FormatDateTime('hh:nn:ss', tNewMeasureDuration)<>'00:00:00' then
                  q:=q+#39+FormatDateTime('hh:nn:ss', tNewMeasureDuration)+#39+', '
                else
                  q:=q+'NULL, ';
                if sNewMeaTicketPrice<>'' then
                  q:=q+#39+sNewMeaTicketPrice+#39+', '
                else
                  q:=q+'NULL, ';
                if sNewMeaPerformer<>'' then
                  q:=q+#39+sNewMeaPerformer+#39+', '
                else
                  q:=q+'NULL, ';
                if sNewMeaOrganizer<>'' then
                  q:=q+#39+sNewMeaOrganizer+#39+', '
                else
                  q:=q+'NULL, ';
                if sNewMeaInfo<>'' then
                  q:=q+#39+sNewMeaInfo+#39+', '
                else
                  q:=q+'NULL, ';
                q:=q+#39+IntToStr(integer(bNewMeaPremier))+#39+', ';
                q:=q+#39+IntToStr(integer(bNewMeaTeenagers))+#39+', ';
                q:=q+#39+IntToStr(integer(bNewMeaChildren))+#39+', ';
                q:=q+#39+IntToStr(iUserID)+#39+');';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  MessageDlg('Ошибка добавления записи в таблицу MEASURES!', mtError, [mbOk], 0)
                else
                  begin
                    UpdateCurrentList;
                    MessageDlg('Запись успешно добавлена.', mtInformation, [mbOk], 0);
                  end;
              end;
          end;
      end;
    1:
      begin
        with TOrganizationsForm.Create(Self) do
          try
            EDIT_OrgRID.Color:=clBtnFace;
            ShowModal;
          finally
            b:=ModalResult=mrOk;
            sNewOrgRID:=EDIT_OrgRID.Text;
            sNewOrgType:=COMBOBOX_OrgType.Text;
            sNewOrgName:=EDIT_OrgName.Text;
            sNewOrgAddress:=EDIT_OrgAddress.Text;
            sNewOrgHowToReach:=EDIT_OrgHowToReach.Text;
            sNewOrgPhones:=EDIT_OrgPhones.Text;
            sNewOrgInfo:=MEMO_OrgInfo.Text;
            if b then
              begin
                (* AddListedPhonesToDB(sNewOrgPhones);
                  AddListedPhonesToDB(sNewOrgInfo); *)
              end;
            Free;
          end;
        if b then
          begin
            // проверка на существование организации с таким же наименованием и типом
            q:=
              'SELECT organizationnames.id, COUNT(*) FROM organizationnames LEFT JOIN organizationtypes ON (organizationtypes.id=organizationnames.organizationtypeid) WHERE organizationtypes.organizationtype='+#39+sNewOrgType+
              #39+' AND organizationnames.organizationname='+#39+sNewOrgName+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблиц ORGANIZATIONTYPES, ORGANIZATIONNAMES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                          (mysql_errno(MySQLConnectionHandler)), mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      q:=string(ResultRow[1]);
                      s:=string(ResultRow[0]);
                    end
                  else
                    q:='0';
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            if StrToInt(q)>0 then
              begin
                MessageDlg('Организация с указанным типом и наименованием уже существует! Операция изменения информации об организации отменена.', mtWarning, [mbOk], 0);
                if SG_Mode_Users.Cols[0].IndexOf(s)<>-1 then
                  begin
                    SG_Mode_Users.Row:=SG_Mode_Users.Cols[0].IndexOf(s);
                    SG_Mode_Users.Col:=1;
                  end;
                Exit;
              end;
            // проверка на существование типа организации
            q:='SELECT organizationtypes.id, COUNT(*) FROM organizationtypes WHERE organizationtypes.organizationtype='+#39+sNewOrgType+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      q:=string(ResultRow[1]);
                      s:=string(ResultRow[0]);
                    end
                  else
                    q:='0';
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            RF:=TReportForm.Create(Self);
            try
              RF.Gauge1.MaxValue:=1;
              RF.StringGrid1.ColWidths[0]:=280;
              RF.StringGrid1.ColWidths[1]:=36;
              RF.Show;
              if StrToInt(q)>0 then
                begin
                  // тип организации уже существует
                  sNewOrgTypeRID:=s;
                end
              else
                begin
                  // создаём новый тип организации
                  RF.Gauge1.MaxValue:=2;
                  RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Добавление записи в таблицу ORGANIZATIONTYPES...';
                  q:='INSERT INTO organizationtypes (id, organizationtype) VALUES (NULL, '+#39+sNewOrgType+#39+');';
                  if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                    begin
                      RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!';
                      if bExitOnError then
                        Exit;
                    end
                  else
                    RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
                  RF.Gauge1.AddProgress(1);
                  RF.Refresh;
                  Application.ProcessMessages;
                  RF.StringGrid1.RowCount:=RF.StringGrid1.RowCount+1;
                  // получаем id нового номера типа организации
                  q:='SELECT organizationtypes.id, COUNT(*) FROM organizationtypes WHERE organizationtypes.organizationtype='+#39+sNewOrgType+#39+' GROUP BY '+#39+#39+';';
                  // MessageDlg(q,mtInformation,[mbOk],0);
                  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                    begin
                      ResultSet:=mysql_store_result(MySQLConnectionHandler);
                      try
                        if ResultSet=nil then
                          begin
                            MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                                (mysql_errno(MySQLConnectionHandler)), mtError, [mbOk], 0);
                            Exit;
                          end;
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow<>nil then
                          begin
                            q:=string(ResultRow[1]);
                            s:=string(ResultRow[0]);
                          end
                        else
                          q:='0';
                      finally
                        if ResultSet<>nil then
                          mysql_free_result(ResultSet);
                      end;
                    end;
                  sNewOrgTypeRID:=s;
                end;
              // непосредственно операция добавления записи
              // шаг 1
              RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Добавление записи в таблицу ORGANIZATIONNAMES...';
              q:='INSERT INTO organizationnames (id, organizationtypeid, organizationname, organizationaddress, organizationhowtoreach, organizationphones, organizationinfo, LMTS) VALUES (NULL, '+#39+sNewOrgTypeRID+#39+', ';
              (* if sNewOrgName='' then q:=q+'NULL, ' else *)
              q:=q+#39+sNewOrgName+#39+', ';
              if sNewOrgAddress='' then
                q:=q+'NULL, '
              else
                q:=q+#39+sNewOrgAddress+#39+', ';
              if sNewOrgHowToReach='' then
                q:=q+'NULL, '
              else
                q:=q+#39+sNewOrgHowToReach+#39+', ';
              if sNewOrgPhones='' then
                q:=q+'NULL, '
              else
                q:=q+#39+sNewOrgPhones+#39+', ';
              if sNewOrgInfo='' then
                q:=q+'NULL, NOW());'
              else
                q:=q+#39+sNewOrgInfo+#39+', NOW());';
              // MessageDlg(q,mtInformation,[mbOk],0);
              if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                begin
                  RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!';
                  if bExitOnError then
                    Exit;
                end
              else
                RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
              RF.Gauge1.AddProgress(1);
              RF.Refresh;
              Application.ProcessMessages;
            finally
              while RF.Gauge1.Progress<RF.Gauge1.MaxValue do
                RF.Gauge1.AddProgress(1);
              if RF<>nil then
                begin
                  RF.Hide;
                  with RF.StringGrid1 do
                    begin
                      for j:=0 to 1 do
                        begin
                          ColWidths[j]:=1;
                          MaxWidth:=1;
                          for k:=0 to RowCount-1 do
                            if MaxWidth<RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5 then
                              MaxWidth:=RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5;
                          ColWidths[j]:=MaxWidth;
                        end;
                      if ColWidths[0]+ColWidths[1]<RF.StringGrid1.Width-4 then
                        ColWidths[0]:=RF.StringGrid1.Width-ColWidths[1]-4;
                    end;
                  RF.Button1.Enabled:=True;
                  UpdateCurrentList;
                  RF.ShowModal;
                  RF.Free;
                end;
            end;
          end;
        if SG_Mode_Organizations.Visible then
          SG_Mode_Organizations.SetFocus;
      end;
    2:
      begin
        with TUsersForm.Create(Self) do
          try
            EDIT_UsrRID.Color:=clBtnFace;
            ShowModal;
          finally
            b:=ModalResult=mrOk;
            sNewLogin:=EDIT_UsrLogin.Text;
            sNewPwd:=EDIT_UsrPwd.Text;
            sNewRealName:=EDIT_UsrRealName.Text;
            sNewOper:=IntToStr(Integer(CB_UsrOperator.Checked=True));
            sNewAdmin:=IntToStr(Integer(CB_UsrAdministrator.Checked=True));
            Free;
          end;
        if b then
          begin
            // проверка на существование пользователя с таким же логином и паролем
            q:='SELECT id, COUNT(*) FROM users WHERE name='+#39+sNewLogin+#39+' AND password='+#39+sNewPwd+#39+' GROUP BY '+#39+#39+';';
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы USERS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError,
                        [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      q:=string(ResultRow[1]);
                      s:=string(ResultRow[0]);
                    end
                  else
                    q:='0';
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            if StrToInt(q)>0 then
              begin
                MessageDlg('Пользователь с идентичным логином и паролем уже существует! Операция добавления информации о новом пользователе отменена.', mtWarning, [mbOk], 0);
                SG_Mode_Users.Row:=SG_Mode_Users.Cols[0].IndexOf(s);
                SG_Mode_Users.Col:=1;
                Exit;
              end;
            // непосредственно операция добавления записи
            RF:=TReportForm.Create(Self);
            try
              RF.Gauge1.MaxValue:=2;
              RF.StringGrid1.ColWidths[0]:=280;
              RF.StringGrid1.ColWidths[1]:=36;
              RF.Show;
              // шаг 1
              RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Добавление новой записи в таблицу USERS...';
              q:='INSERT INTO users (id, name, realname, password, editor, administrator) VALUES (NULL, '+#39+sNewLogin+#39+', '+#39+sNewRealName+#39+', '+#39+sNewPwd+#39+', '+sNewOper+', '+sNewAdmin+');';
              if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                begin
                  RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!';
                  if bExitOnError then
                    Exit;
                end
              else
                RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
              RF.Gauge1.AddProgress(1);
              RF.Refresh;
              Application.ProcessMessages;
            finally
              while RF.Gauge1.Progress<RF.Gauge1.MaxValue do
                RF.Gauge1.AddProgress(1);
              if RF<>nil then
                begin
                  RF.Hide;
                  with RF.StringGrid1 do
                    begin
                      for j:=0 to 1 do
                        begin
                          ColWidths[j]:=1;
                          MaxWidth:=1;
                          for k:=0 to RowCount-1 do
                            if MaxWidth<RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5 then
                              MaxWidth:=RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5;
                          ColWidths[j]:=MaxWidth;
                        end;
                      if ColWidths[0]+ColWidths[1]<RF.StringGrid1.Width-4 then
                        ColWidths[0]:=RF.StringGrid1.Width-ColWidths[1]-4;
                    end;
                  RF.Button1.Enabled:=True;
                  UpdateCurrentList;
                  RF.ShowModal;
                  RF.Free;
                end;
            end;
          end;
        if SG_Mode_Users.Visible then
          SG_Mode_Users.SetFocus;
      end;
    3:
      begin
        (* !!!ДОПИСАТЬ!!! *)
      end;
  end;
end;

procedure TMainForm.ACTION_EditRecordExecute(Sender: TObject);
var
  b: boolean;
  j, k, MaxWidth: integer;
  RF: TReportForm;
  sNewLogin, sNewPwd, sNewRealName, sNewOper, sNewAdmin: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  dtNewMeaStartDateTime, dtNewMeaStopDateTime: TDateTime;
  tNewMeasureDuration: TTime;
  iQuantity, iNewMeaRID, iNewOrgType, iNewOrgName, iNewMeaType, iNewMeaName, iNewMeaAuthor, iNewMeaProducer: integer;
  sNewMeaRID, sNewMeaType, sNewMeaName, sNewMeaAuthor, sNewMeaProducer, sNewMeaTicketPrice, sNewMeaPerformer, sNewMeaOrganizer, sNewMeaInfo: string;
  bNewMeaStartDateTime, bNewMeaStopDateTime, bNewMeaPremier, bNewMeaTeenagers, bNewMeaChildren, bNewMeaAsNew: boolean;
  s, q, sNewOrgTypeRID, sNewOrgRID, sNewOrgType, sNewOrgName, sNewOrgAddress, sNewOrgHowToReach, sNewOrgPhones, sNewOrgInfo: string;
begin
  iQuantity:=-1;
  iNewMeaRID:=-1;
  iNewOrgType:=-1;
  iNewOrgName:=-1;
  iNewMeaType:=-1;
  iNewMeaName:=-1;
  iNewMeaAuthor:=-1;
  iNewMeaProducer:=-1;
  case GetCurrentMode of
    0:
      begin
        with TMeasuresForm.Create(Self) do
          try
            Caption:='Редактирование информации о мероприятии';
            EDIT_MeaRID.Text:=SG_Mode_Measures.Cells[0, SG_Mode_Measures.Row];
            COMBOBOX_OrgType.Items.Clear;
            COMBOBOX_OrgType.Items.Add(SG_Mode_Measures.Cells[1, SG_Mode_Measures.Row]);
            COMBOBOX_OrgType.ItemIndex:=COMBOBOX_OrgType.Items.IndexOf(SG_Mode_Measures.Cells[1, SG_Mode_Measures.Row]);
            if COMBOBOX_OrgType.Text<>'' then
              COMBOBOX_OrgType.Color:=clWindow
            else
              COMBOBOX_OrgType.Color:=clInfoBk;
            LABEL_OrgName.Enabled:=True;
            COMBOBOX_OrgName.Enabled:=True;
            CHECKBOX_OrgNameAsTemplate.Enabled:=True;
            COMBOBOX_OrgName.Items.Clear;
            COMBOBOX_OrgName.Items.Add(SG_Mode_Measures.Cells[2, SG_Mode_Measures.Row]);
            COMBOBOX_OrgName.ItemIndex:=COMBOBOX_OrgName.Items.IndexOf(SG_Mode_Measures.Cells[2, SG_Mode_Measures.Row]);
            if COMBOBOX_OrgName.Text<>'' then
              COMBOBOX_OrgName.Color:=clWindow
            else
              COMBOBOX_OrgName.Color:=clInfoBk;
            COMBOBOX_MeaType.Items.Clear;
            COMBOBOX_MeaType.Items.Add(SG_Mode_Measures.Cells[3, SG_Mode_Measures.Row]);
            COMBOBOX_MeaType.ItemIndex:=COMBOBOX_MeaType.Items.IndexOf(SG_Mode_Measures.Cells[3, SG_Mode_Measures.Row]);
            if COMBOBOX_MeaType.Text<>'' then
              COMBOBOX_MeaType.Color:=clWindow;
            COMBOBOX_MeaName.Items.Clear;
            COMBOBOX_MeaName.Items.Add(SG_Mode_Measures.Cells[4, SG_Mode_Measures.Row]);
            COMBOBOX_MeaName.ItemIndex:=COMBOBOX_MeaName.Items.IndexOf(SG_Mode_Measures.Cells[4, SG_Mode_Measures.Row]);
            if COMBOBOX_MeaName.Text<>'' then
              COMBOBOX_MeaName.Color:=clWindow;
            COMBOBOX_MeaAuthor.Items.Clear;
            COMBOBOX_MeaAuthor.Items.Add(SG_Mode_Measures.Cells[5, SG_Mode_Measures.Row]);
            COMBOBOX_MeaAuthor.ItemIndex:=COMBOBOX_MeaAuthor.Items.IndexOf(SG_Mode_Measures.Cells[5, SG_Mode_Measures.Row]);
            if COMBOBOX_MeaAuthor.Text<>'' then
              COMBOBOX_MeaAuthor.Color:=clWindow;
            COMBOBOX_MeaProducer.Items.Clear;
            COMBOBOX_MeaProducer.Items.Add(SG_Mode_Measures.Cells[6, SG_Mode_Measures.Row]);
            COMBOBOX_MeaProducer.ItemIndex:=COMBOBOX_MeaProducer.Items.IndexOf(SG_Mode_Measures.Cells[6, SG_Mode_Measures.Row]);
            if COMBOBOX_MeaProducer.Text<>'' then
              COMBOBOX_MeaProducer.Color:=clWindow;
            if SG_Mode_Measures.Cells[7, SG_Mode_Measures.Row]<>'' then
              begin
                try
                  DATETIMEPICKER_StartDate.DateTime:=StrToDateTime(StringReplace(SG_Mode_Measures.Cells[7, SG_Mode_Measures.Row], '-', '.', [rfReplaceAll]));
                  DATETIMEPICKER_StartTime.DateTime:=DATETIMEPICKER_StartDate.DateTime;
                  CHECKBOX_StartDateTime.Checked:=True;
                except
                  on EConvertError do
                    begin
                      CHECKBOX_StartDateTime.Checked:=False;
                      MessageDlg('Возникла ошибка при конвертации строки '+#39+SG_Mode_Measures.Cells[7, SG_Mode_Measures.Row]+#39+' в формат дата/время!', mtError, [mbOk], 0);
                    end;
                end;
              end;
            if SG_Mode_Measures.Cells[8, SG_Mode_Measures.Row]<>'' then
              begin
                try
                  DATETIMEPICKER_StopDate.DateTime:=StrToDateTime(StringReplace(SG_Mode_Measures.Cells[8, SG_Mode_Measures.Row], '-', '.', [rfReplaceAll]));
                  DATETIMEPICKER_StopTime.DateTime:=DATETIMEPICKER_StopDate.DateTime;
                  CHECKBOX_StopDateTime.Checked:=True;
                except
                  on EConvertError do
                    begin
                      CHECKBOX_StopDateTime.Checked:=False;
                      MessageDlg('Возникла ошибка при конвертации строки '+#39+SG_Mode_Measures.Cells[8, SG_Mode_Measures.Row]+#39+' в формат дата/время!', mtError, [mbOk], 0);
                    end;
                end;
              end;
            MEMO_MeaTicketPrice.Text:=SG_Mode_Measures.Cells[9, SG_Mode_Measures.Row];
            if SG_Mode_Measures.Cells[10, SG_Mode_Measures.Row]<>'' then
              DATETIMEPICKER_MeasureDuration.DateTime:=StrToTime(SG_Mode_Measures.Cells[10, SG_Mode_Measures.Row])
            else
              DATETIMEPICKER_MeasureDuration.DateTime:=0;
            EDIT_MeaPerformer.Text:=SG_Mode_Measures.Cells[11, SG_Mode_Measures.Row];
            EDIT_MeaOrganizer.Text:=SG_Mode_Measures.Cells[12, SG_Mode_Measures.Row];
            MEMO_MeaInfo.Text:=SG_Mode_Measures.Cells[13, SG_Mode_Measures.Row];
            CHECKBOX_MeaPremier.Checked:=SG_Mode_Measures.Cells[14, SG_Mode_Measures.Row]='Да';
            CHECKBOX_MeaTeenagers.Checked:=SG_Mode_Measures.Cells[15, SG_Mode_Measures.Row]='Да';
            CHECKBOX_MeaChildren.Checked:=SG_Mode_Measures.Cells[16, SG_Mode_Measures.Row]='Да';
            EDIT_MeaOperator.Text:=SG_Mode_Measures.Cells[17, SG_Mode_Measures.Row];
            EDIT_MeaLMTS.Text:=SG_Mode_Measures.Cells[18, SG_Mode_Measures.Row];
            if EDIT_MeaOperator.Text<>'' then
              EDIT_MeaOperator.Color:=clWindow;
            UpdateControlsState;
            ShowModal;
          finally
            b:=ModalResult=mrOk;
            sNewMeaRID:=EDIT_MeaRID.Text;
            sNewOrgType:=COMBOBOX_OrgType.Text;
            sNewOrgName:=COMBOBOX_OrgName.Text;
            sNewMeaType:=COMBOBOX_MeaType.Text;
            sNewMeaName:=COMBOBOX_MeaName.Text;
            sNewMeaAuthor:=COMBOBOX_MeaAuthor.Text;
            sNewMeaProducer:=COMBOBOX_MeaProducer.Text;
            bNewMeaStartDateTime:=CHECKBOX_StartDateTime.Checked;
            dtNewMeaStartDateTime:=DATETIMEPICKER_StartTime.DateTime;
            bNewMeaStopDateTime:=CHECKBOX_StopDateTime.Checked;
            dtNewMeaStopDateTime:=DATETIMEPICKER_StopTime.DateTime;
            tNewMeasureDuration:=DATETIMEPICKER_MeasureDuration.Time;
            sNewMeaTicketPrice:=MEMO_MeaTicketPrice.Text;
            sNewMeaPerformer:=EDIT_MeaPerformer.Text;
            sNewMeaOrganizer:=EDIT_MeaOrganizer.Text;
            sNewMeaInfo:=MEMO_MeaInfo.Text;
            bNewMeaPremier:=CHECKBOX_MeaPremier.Checked;
            bNewMeaTeenagers:=CHECKBOX_MeaTeenagers.Checked;
            bNewMeaChildren:=CHECKBOX_MeaChildren.Checked;
            bNewMeaAsNew:=CHECKBOX_AsNew.Checked;
            Free;
          end;
        if b then
          begin
            // получение RID типа организации
            q:='SELECT organizationtypes.id, COUNT(*) FROM organizationtypes WHERE organizationtypes.organizationtype='+#39+sNewOrgType+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewOrgType:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewOrgType:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // получение RID наименования организации
            q:='SELECT organizationnames.id, COUNT(*) FROM organizationnames WHERE organizationnames.organizationname='+#39+sNewOrgName+#39+' AND organizationnames.organizationtypeid='+#39+IntToStr(iNewOrgType)+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONNAMES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewOrgName:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewOrgName:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // попытка получения RID типа мероприятия
            q:='SELECT measuretypes.id, COUNT(*) FROM measuretypes WHERE measuretypes.measuretype='+#39+sNewMeaType+#39+' AND measuretypes.organizationtypeid='+#39+IntToStr(iNewOrgType)+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURETYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError,
                        [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaType:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaType:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // добавление нового типа мероприятий
            if ((iNewMeaType<0)or(iQuantity<1)) then
              begin
                q:='INSERT INTO measuretypes (id, organizationtypeid, measuretype) VALUES (NULL, '+#39+IntToStr(iNewOrgType)+#39+', '+#39+sNewMeaType+#39+');';
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  if bExitOnError then
                    Exit;
                // получение RID типа мероприятия
                q:='SELECT measuretypes.id, COUNT(*) FROM measuretypes WHERE measuretypes.measuretype='+#39+sNewMeaType+#39+' AND measuretypes.organizationtypeid='+#39+IntToStr(iNewOrgType)+#39+' GROUP BY '+#39+#39+';';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                  begin
                    ResultSet:=mysql_store_result(MySQLConnectionHandler);
                    try
                      if ResultSet=nil then
                        begin
                          MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURETYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                            mtError, [mbOk], 0);
                          Exit;
                        end;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          iNewMeaType:=StrToIntDef(string(ResultRow[0]), -1);
                          iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                        end
                      else
                        Exit;
                    finally
                      if ResultSet<>nil then
                        mysql_free_result(ResultSet);
                    end;
                  end;
              end;
            // попытка получения RID наименования мероприятия
            q:='SELECT measurenames.id, COUNT(*) FROM measurenames WHERE measurenames.measurename='+#39+sNewMeaName+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURENAMES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError,
                        [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaName:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaName:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // добавление нового наименования мероприятий
            if ((iNewMeaName<0)or(iQuantity<1)) then
              begin
                q:='INSERT INTO measurenames (id, measurename) VALUES (NULL, '+#39+sNewMeaName+#39+');';
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  if bExitOnError then
                    Exit;
                // получение RID наименования мероприятия
                q:='SELECT measurenames.id, COUNT(*) FROM measurenames WHERE measurenames.measurename='+#39+sNewMeaName+#39+' GROUP BY '+#39+#39+';';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                  begin
                    ResultSet:=mysql_store_result(MySQLConnectionHandler);
                    try
                      if ResultSet=nil then
                        begin
                          MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURENAMES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                            mtError, [mbOk], 0);
                          Exit;
                        end;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          iNewMeaName:=StrToIntDef(string(ResultRow[0]), -1);
                          iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                        end
                      else
                        Exit;
                    finally
                      if ResultSet<>nil then
                        mysql_free_result(ResultSet);
                    end;
                  end;
              end;
            // попытка получения RID автора мероприятия
            q:='SELECT measureauthors.id, COUNT(*) FROM measureauthors WHERE measureauthors.measureauthor='+#39+sNewMeaAuthor+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREAUTHORS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaAuthor:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaAuthor:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // добавление нового автора мероприятий
            if ((iNewMeaAuthor<0)or(iQuantity<1)) then
              begin
                q:='INSERT INTO measureauthors (id, measureauthor) VALUES (NULL, '+#39+sNewMeaAuthor+#39+');';
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  if bExitOnError then
                    Exit;
                // получение RID автора мероприятия
                q:='SELECT measureauthors.id, COUNT(*) FROM measureauthors WHERE measureauthors.measureauthor='+#39+sNewMeaAuthor+#39+' GROUP BY '+#39+#39+';';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                  begin
                    ResultSet:=mysql_store_result(MySQLConnectionHandler);
                    try
                      if ResultSet=nil then
                        begin
                          MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREAUTHORS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                            mtError, [mbOk], 0);
                          Exit;
                        end;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          iNewMeaAuthor:=StrToIntDef(string(ResultRow[0]), -1);
                          iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                        end
                      else
                        Exit;
                    finally
                      if ResultSet<>nil then
                        mysql_free_result(ResultSet);
                    end;
                  end;
              end;
            // попытка получения RID режиссёра мероприятия
            q:='SELECT measureproducers.id, COUNT(*) FROM measureproducers WHERE measureproducers.measureproducer='+#39+sNewMeaProducer+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREPRODUCERS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaProducer:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaProducer:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            // добавление нового автора мероприятий
            if ((iNewMeaProducer<0)or(iQuantity<1)) then
              begin
                q:='INSERT INTO measureproducers (id, measureproducer) VALUES (NULL, '+#39+sNewMeaProducer+#39+');';
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  if bExitOnError then
                    Exit;
                // получение RID автора мероприятия
                q:='SELECT measureproducers.id, COUNT(*) FROM measureproducers WHERE measureproducers.measureproducer='+#39+sNewMeaProducer+#39+' GROUP BY '+#39+#39+';';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                  begin
                    ResultSet:=mysql_store_result(MySQLConnectionHandler);
                    try
                      if ResultSet=nil then
                        begin
                          MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREPRODUCERS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                            mtError, [mbOk], 0);
                          Exit;
                        end;
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          iNewMeaProducer:=StrToIntDef(string(ResultRow[0]), -1);
                          iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                        end
                      else
                        Exit;
                    finally
                      if ResultSet<>nil then
                        mysql_free_result(ResultSet);
                    end;
                  end;
              end;
            // проверка на наличие идентичной записи в таблице MEASURES
            q:='SELECT measures.id, COUNT(*) FROM measures WHERE '+'measures.organizationtypeid='+#39+IntToStr(iNewOrgType)+#39+' AND '+'measures.organizationnameid='+#39+IntToStr(iNewOrgName)+#39+' AND '+'measures.measuretypeid='+#39+IntToStr
              (iNewMeaType)+#39+' AND '+'measures.measurenameid='+#39+IntToStr(iNewMeaName)+#39+' AND '+'measures.measureauthorid='+#39+IntToStr(iNewMeaAuthor)+#39+' AND '+'measures.measureproducerid='+#39+IntToStr(iNewMeaProducer)+#39+' AND ';
            if bNewMeaStartDateTime then
              q:=q+'(measures.measurestartdatetime='+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStartDateTime)+#39+') AND '
            else
              q:=q+'(measures.measurestartdatetime IS NULL) AND ';
            if bNewMeaStopDateTime then
              q:=q+'(measures.measurestopdatetime='+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStopDateTime)+#39+') AND '
            else
              q:=q+'(measures.measurestopdatetime IS NULL) AND ';
            if FormatDateTime('hh:nn:ss', tNewMeasureDuration)<>'00:00:00' then
              q:=q+'measures.measureduration='+#39+FormatDateTime('hh:nn:ss', tNewMeasureDuration)+#39+' AND '
            else
              q:=q+'(measures.measureduration IS NULL) AND ';
            if sNewMeaTicketPrice<>'' then
              q:=q+'measures.measureticketprice='+#39+sNewMeaTicketPrice+#39+' AND '
            else
              q:=q+'(measures.measureticketprice IS NULL) AND ';
            if sNewMeaPerformer<>'' then
              q:=q+'measures.measureperformer='+#39+sNewMeaPerformer+#39+' AND '
            else
              q:=q+'(measures.measureperformer IS NULL) AND ';
            if sNewMeaOrganizer<>'' then
              q:=q+'measures.measureorganizer='+#39+sNewMeaOrganizer+#39+' AND '
            else
              q:=q+'(measures.measureorganizer IS NULL) AND ';
            if sNewMeaInfo<>'' then
              q:=q+'measures.measureinfo='+#39+sNewMeaInfo+#39+' AND '
            else
              q:=q+'(measures.measureinfo IS NULL) AND ';
            q:=q+'measures.measurepremier='+#39+IntToStr(integer(bNewMeaPremier))+#39+' AND ';
            q:=q+'measures.teenagersmeasure='+#39+IntToStr(integer(bNewMeaTeenagers))+#39+' AND ';
            q:=q+'measures.childrenmeasure='+#39+IntToStr(integer(bNewMeaChildren))+#39+' AND ';
            q:=q+'measures.ridcreatorid='+#39+IntToStr(iUserID)+#39;
            q:=q+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError,
                        [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      iNewMeaRID:=StrToIntDef(string(ResultRow[0]), -1);
                      iQuantity:=StrToIntDef(string(ResultRow[1]), -1);
                    end
                  else
                    begin
                      iNewMeaRID:=-1;
                      iQuantity:=-1;
                    end;
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            if (iNewMeaRID>=0)or(iQuantity>0) then
              if (MessageDlg('Найдена запись с данными, идентичными введённым. Вы всё равно хотите добавить данные в базу?', mtConfirmation, [mbYes, mbNo], 0)=mrNo) then
                Exit;
            if bNewMeaAsNew then
              begin
                q:='INSERT INTO measures (id, organizationtypeid, organizationnameid, measuretypeid, measurenameid, '+'measureauthorid, measureproducerid, measurestartdatetime, measurestopdatetime, measureduration, '+
                  'measureticketprice, measureperformer, measureorganizer, measureinfo, measurepremier, teenagersmeasure, '+'childrenmeasure, ridcreatorid, LMTS) VALUES (NULL, '+#39+IntToStr(iNewOrgType)+#39+', '+#39+IntToStr(iNewOrgName)
                  +#39+', '+#39+IntToStr(iNewMeaType)+#39+', '+#39+IntToStr(iNewMeaName)+#39+', '+#39+IntToStr(iNewMeaAuthor)+#39+', '+#39+IntToStr(iNewMeaProducer)+#39+', ';
                if bNewMeaStartDateTime then
                  q:=q+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStartDateTime)+#39+', '
                else
                  q:=q+'NULL, ';
                if bNewMeaStopDateTime then
                  q:=q+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStopDateTime)+#39+', '
                else
                  q:=q+'NULL, ';
                if FormatDateTime('hh:nn:ss', tNewMeasureDuration)<>'00:00:00' then
                  q:=q+#39+FormatDateTime('hh:nn:ss', tNewMeasureDuration)+#39+', '
                else
                  q:=q+'NULL, ';
                if sNewMeaTicketPrice<>'' then
                  q:=q+#39+sNewMeaTicketPrice+#39+', '
                else
                  q:=q+'NULL, ';
                if sNewMeaPerformer<>'' then
                  q:=q+#39+sNewMeaPerformer+#39+', '
                else
                  q:=q+'NULL, ';
                if sNewMeaOrganizer<>'' then
                  q:=q+#39+sNewMeaOrganizer+#39+', '
                else
                  q:=q+'NULL, ';
                if sNewMeaInfo<>'' then
                  q:=q+#39+sNewMeaInfo+#39+', '
                else
                  q:=q+'NULL, ';
                q:=q+#39+IntToStr(integer(bNewMeaPremier))+#39+', ';
                q:=q+#39+IntToStr(integer(bNewMeaTeenagers))+#39+', ';
                q:=q+#39+IntToStr(integer(bNewMeaChildren))+#39+', ';
                q:=q+#39+IntToStr(iUserID)+#39+', NOW());';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  MessageDlg('Ошибка добавления записи в таблицу MEASURES!', mtError, [mbOk], 0)
                else
                  begin
                    UpdateCurrentList;
                    MessageDlg('Запись успешно добавлена.', mtInformation, [mbOk], 0);
                  end;
              end
            else
              begin
                q:='UPDATE measures SET '+'organizationtypeid='+#39+IntToStr(iNewOrgType)+#39+', '+'organizationnameid='+#39+IntToStr(iNewOrgName)+#39+', '+'measuretypeid='+#39+IntToStr(iNewMeaType)+#39+', '+'measurenameid='+#39+IntToStr(iNewMeaName)
                  +#39+', '+'measureauthorid='+#39+IntToStr(iNewMeaAuthor)+#39+', '+'measureproducerid='+#39+IntToStr(iNewMeaProducer)+#39+', ';
                if bNewMeaStartDateTime then
                  q:=q+'measurestartdatetime='+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStartDateTime)+#39+', '
                else
                  q:=q+'measurestartdatetime=NULL, ';
                if bNewMeaStopDateTime then
                  q:=q+'measurestopdatetime='+#39+FormatDateTime('yyyy-mm-dd hh:nn:ss', dtNewMeaStopDateTime)+#39+', '
                else
                  q:=q+'measurestopdatetime=NULL, ';
                if FormatDateTime('hh:nn:ss', tNewMeasureDuration)<>'00:00:00' then
                  q:=q+'measureduration='+#39+FormatDateTime('hh:nn:ss', tNewMeasureDuration)+#39+', '
                else
                  q:=q+'measureduration=NULL, ';
                if sNewMeaTicketPrice<>'' then
                  q:=q+'measureticketprice='+#39+sNewMeaTicketPrice+#39+', '
                else
                  q:=q+'measureticketprice=NULL, ';
                if sNewMeaPerformer<>'' then
                  q:=q+'measureperformer='+#39+sNewMeaPerformer+#39+', '
                else
                  q:=q+'measureperformer=NULL, ';
                if sNewMeaOrganizer<>'' then
                  q:=q+'measureorganizer='+#39+sNewMeaOrganizer+#39+', '
                else
                  q:=q+'measureorganizer=NULL, ';
                if sNewMeaInfo<>'' then
                  q:=q+'measureinfo='+#39+sNewMeaInfo+#39+', '
                else
                  q:=q+'measureinfo=NULL, ';
                q:=q+'measurepremier='+#39+IntToStr(integer(bNewMeaPremier))+#39+', ';
                q:=q+'teenagersmeasure='+#39+IntToStr(integer(bNewMeaTeenagers))+#39+', ';
                q:=q+'childrenmeasure='+#39+IntToStr(integer(bNewMeaChildren))+#39+', ';
                q:=q+'ridcreatorid='+#39+IntToStr(iUserID)+#39+', LMTS=NOW() WHERE id='+#39+sNewMeaRID+#39+';';
                // MessageDlg(q,mtInformation,[mbOk],0);
                if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                  MessageDlg('Ошибка внесения изменений в таблицу MEASURES!', mtError, [mbOk], 0)
                else
                  begin
                    UpdateCurrentList;
                    MessageDlg('Изменения успешно внесены.', mtInformation, [mbOk], 0);
                  end;
              end;
          end;
      end;
    1:
      begin
        with TOrganizationsForm.Create(Self) do
          try
            Caption:='Редактирование информации об организации';
            EDIT_OrgRID.Text:=SG_Mode_Organizations.Cells[0, SG_Mode_Organizations.Row];
            COMBOBOX_OrgType.Text:=SG_Mode_Organizations.Cells[1, SG_Mode_Organizations.Row];
            if COMBOBOX_OrgType.Text<>'' then
              COMBOBOX_OrgType.Color:=clWindow;
            EDIT_OrgName.Text:=SG_Mode_Organizations.Cells[2, SG_Mode_Organizations.Row];
            EDIT_OrgAddress.Text:=SG_Mode_Organizations.Cells[3, SG_Mode_Organizations.Row];
            EDIT_OrgHowToReach.Text:=SG_Mode_Organizations.Cells[4, SG_Mode_Organizations.Row];
            EDIT_OrgPhones.Text:=SG_Mode_Organizations.Cells[5, SG_Mode_Organizations.Row];
            { EDIT_OrgPhones.Text:=RemovePhoneTags(EDIT_OrgPhones.Text); }
            MEMO_OrgInfo.Text:=SG_Mode_Organizations.Cells[6, SG_Mode_Organizations.Row];
            EDIT_OrgLMTS.Text:=SG_Mode_Organizations.Cells[7, SG_Mode_Organizations.Row];
            { MEMO_OrgInfo.Text:=RemovePhoneTags(MEMO_OrgInfo.Text); }
            ShowModal;
          finally
            b:=ModalResult=mrOk;
            sNewOrgRID:=EDIT_OrgRID.Text;
            sNewOrgType:=COMBOBOX_OrgType.Text;
            sNewOrgName:=EDIT_OrgName.Text;
            sNewOrgAddress:=EDIT_OrgAddress.Text;
            sNewOrgHowToReach:=EDIT_OrgHowToReach.Text;
            sNewOrgPhones:=EDIT_OrgPhones.Text;
            sNewOrgInfo:=MEMO_OrgInfo.Text;
            if b then
              begin
                (* AddListedPhonesToDB(sNewOrgPhones);
                  AddListedPhonesToDB(sNewOrgInfo); *)
              end;
            Free;
          end;
        if b then
          begin
            // проверка на существование организации с таким же наименованием и типом
            q:=
              'SELECT organizationnames.id, COUNT(*) FROM organizationnames LEFT JOIN organizationtypes ON (organizationtypes.id=organizationnames.organizationtypeid) WHERE organizationtypes.organizationtype='+#39+sNewOrgType+
              #39+' AND organizationnames.organizationname='+#39+sNewOrgName+#39+' AND organizationnames.id<>'+sNewOrgRID+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблиц ORGANIZATIONTYPES, ORGANIZATIONNAMES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                          (mysql_errno(MySQLConnectionHandler)), mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      q:=string(ResultRow[1]);
                      s:=string(ResultRow[0]);
                    end
                  else
                    q:='0';
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            if StrToInt(q)>0 then
              begin
                MessageDlg('Организация с указанным типом и наименованием уже существует! Операция изменения информации об организации отменена.', mtWarning, [mbOk], 0);
                if SG_Mode_Users.Cols[0].IndexOf(s)<>-1 then
                  begin
                    SG_Mode_Users.Row:=SG_Mode_Users.Cols[0].IndexOf(s);
                    SG_Mode_Users.Col:=1;
                  end;
                Exit;
              end;
            // проверка на существование типа организации
            q:='SELECT organizationtypes.id, COUNT(*) FROM organizationtypes WHERE organizationtypes.organizationtype='+#39+sNewOrgType+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)),
                        mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      q:=string(ResultRow[1]);
                      s:=string(ResultRow[0]);
                    end
                  else
                    q:='0';
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            RF:=TReportForm.Create(Self);
            try
              RF.Gauge1.MaxValue:=1;
              RF.StringGrid1.ColWidths[0]:=280;
              RF.StringGrid1.ColWidths[1]:=36;
              RF.Show;
              if StrToInt(q)>0 then
                begin
                  // тип организации уже существует
                  sNewOrgTypeRID:=s;
                end
              else
                begin
                  // создаём новый тип организации
                  RF.Gauge1.MaxValue:=2;
                  RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Добавление записи в таблицу ORGANIZATIONTYPES...';
                  q:='INSERT INTO organizationtypes (id, organizationtype) VALUES (NULL, '+#39+sNewOrgType+#39+');';
                  if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                    begin
                      RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!';
                      if bExitOnError then
                        Exit;
                    end
                  else
                    RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
                  RF.Gauge1.AddProgress(1);
                  RF.Refresh;
                  Application.ProcessMessages;
                  RF.StringGrid1.RowCount:=RF.StringGrid1.RowCount+1;
                  // получаем id нового номера организации
                  q:='SELECT organizationtypes.id, COUNT(*) FROM organizationtypes WHERE organizationtypes.organizationtype='+#39+sNewOrgType+#39+' GROUP BY '+#39+#39+';';
                  // MessageDlg(q,mtInformation,[mbOk],0);
                  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                    begin
                      ResultSet:=mysql_store_result(MySQLConnectionHandler);
                      try
                        if ResultSet=nil then
                          begin
                            MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                                (mysql_errno(MySQLConnectionHandler)), mtError, [mbOk], 0);
                            Exit;
                          end;
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow<>nil then
                          begin
                            q:=string(ResultRow[1]);
                            s:=string(ResultRow[0]);
                          end
                        else
                          q:='0';
                      finally
                        if ResultSet<>nil then
                          mysql_free_result(ResultSet);
                      end;
                    end;
                  sNewOrgTypeRID:=s;
                end;
              // непосредственно операция добавления записи
              // шаг 1
              RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Изменение записи из таблицы ORGANIZATIONNAMES...';
              q:='UPDATE organizationnames SET organizationtypeid='+#39+sNewOrgTypeRID+#39+', organizationname=';
              (* if sNewOrgName='' then q:=q+'NULL' else *)
              q:=q+#39+sNewOrgName+#39;
              q:=q+', organizationaddress=';
              if sNewOrgAddress='' then
                q:=q+'NULL'
              else
                q:=q+#39+sNewOrgAddress+#39;
              q:=q+', organizationhowtoreach=';
              if sNewOrgHowToReach='' then
                q:=q+'NULL'
              else
                q:=q+#39+sNewOrgHowToReach+#39;
              q:=q+', organizationphones=';
              if sNewOrgPhones='' then
                q:=q+'NULL'
              else
                q:=q+#39+sNewOrgPhones+#39;
              q:=q+', organizationinfo=';
              if sNewOrgInfo='' then
                q:=q+'NULL'
              else
                q:=q+#39+sNewOrgInfo+#39;
              q:=q+', LMTS=NOW()';
              q:=q+' WHERE id='+sNewOrgRID+';';
              // MessageDlg(q,mtInformation,[mbOk],0);
              if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                begin
                  RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!';
                  if bExitOnError then
                    Exit;
                end
              else
                RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
              RF.Gauge1.AddProgress(1);
              RF.Refresh;
              Application.ProcessMessages;
            finally
              while RF.Gauge1.Progress<RF.Gauge1.MaxValue do
                RF.Gauge1.AddProgress(1);
              if RF<>nil then
                begin
                  RF.Hide;
                  with RF.StringGrid1 do
                    begin
                      for j:=0 to 1 do
                        begin
                          ColWidths[j]:=1;
                          MaxWidth:=1;
                          for k:=0 to RowCount-1 do
                            if MaxWidth<RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5 then
                              MaxWidth:=RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5;
                          ColWidths[j]:=MaxWidth;
                        end;
                      if ColWidths[0]+ColWidths[1]<RF.StringGrid1.Width-4 then
                        ColWidths[0]:=RF.StringGrid1.Width-ColWidths[1]-4;
                    end;
                  RF.Button1.Enabled:=True;
                  UpdateCurrentList;
                  RF.ShowModal;
                  RF.Free;
                end;
            end;
          end;
        if SG_Mode_Organizations.Visible then
          SG_Mode_Organizations.SetFocus;
      end;
    2:
      begin
        with TUsersForm.Create(Self) do
          try
            Caption:='Редактирование информации о пользователе';
            EDIT_UsrRID.Text:=SG_Mode_Users.Cells[0, SG_Mode_Users.Row];
            EDIT_UsrLogin.Text:=SG_Mode_Users.Cells[1, SG_Mode_Users.Row];
            EDIT_UsrPwd.Text:=SG_Mode_Users.Cells[2, SG_Mode_Users.Row];
            EDIT_UsrRealName.Text:=SG_Mode_Users.Cells[3, SG_Mode_Users.Row];
            CB_UsrOperator.Checked:=SG_Mode_Users.Cells[4, SG_Mode_Users.Row]='Да';
            CB_UsrAdministrator.Checked:=SG_Mode_Users.Cells[5, SG_Mode_Users.Row]='Да';
            ShowModal;
          finally
            b:=ModalResult=mrOk;
            sNewLogin:=EDIT_UsrLogin.Text;
            sNewPwd:=EDIT_UsrPwd.Text;
            sNewRealName:=EDIT_UsrRealName.Text;
            sNewOper:=IntToStr(Integer(CB_UsrOperator.Checked=True));
            sNewAdmin:=IntToStr(Integer(CB_UsrAdministrator.Checked=True));
            Free;
          end;
        if b then
          begin
            // проверка на существование пользователя с таким же логином и паролем
            q:='SELECT id, COUNT(*) FROM users WHERE id<>'+SG_Mode_Users.Cells[0, SG_Mode_Users.Row]+' AND name='+#39+sNewLogin+#39+' AND password='+#39+sNewPwd+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы USERS!'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)), mtError,
                        [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      q:=string(ResultRow[1]);
                      s:=string(ResultRow[0]);
                    end
                  else
                    q:='0';
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            if StrToInt(q)>0 then
              begin
                MessageDlg('Пользователь с идентичным логином и паролем уже существует! Операция изменения информации о пользователе отменена.', mtWarning, [mbOk], 0);
                SG_Mode_Users.Row:=SG_Mode_Users.Cols[0].IndexOf(s);
                SG_Mode_Users.Col:=1;
                Exit;
              end;
            // непосредственно операция добавления записи
            RF:=TReportForm.Create(Self);
            try
              RF.Gauge1.MaxValue:=2;
              RF.StringGrid1.ColWidths[0]:=280;
              RF.StringGrid1.ColWidths[1]:=36;
              RF.Show;
              // шаг 1
              RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Изменение записи из таблицы USERS...';
              q:='UPDATE users SET name='+#39+sNewLogin+#39+', password='+#39+sNewPwd+#39+', realname='+#39+sNewRealName+#39+', editor='+sNewOper+', administrator='+sNewAdmin+' WHERE id='+SG_Mode_Users.Cells[0, SG_Mode_Users.Row]+';';
              // MessageDlg(q,mtInformation,[mbOk],0);
              if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                begin
                  RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!';
                  if bExitOnError then
                    Exit;
                end
              else
                RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
              RF.Gauge1.AddProgress(1);
              RF.Refresh;
              Application.ProcessMessages;
            finally
              while RF.Gauge1.Progress<RF.Gauge1.MaxValue do
                RF.Gauge1.AddProgress(1);
              if RF<>nil then
                begin
                  RF.Hide;
                  with RF.StringGrid1 do
                    begin
                      for j:=0 to 1 do
                        begin
                          ColWidths[j]:=1;
                          MaxWidth:=1;
                          for k:=0 to RowCount-1 do
                            if MaxWidth<RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5 then
                              MaxWidth:=RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5;
                          ColWidths[j]:=MaxWidth;
                        end;
                      if ColWidths[0]+ColWidths[1]<RF.StringGrid1.Width-4 then
                        ColWidths[0]:=RF.StringGrid1.Width-ColWidths[1]-4;
                    end;
                  RF.Button1.Enabled:=True;
                  UpdateCurrentList;
                  RF.ShowModal;
                  RF.Free;
                end;
            end;
          end;
        if SG_Mode_Users.Visible then
          SG_Mode_Users.SetFocus;
      end;
    3:
      begin
        (* !!!ДОПИСАТЬ!!! *)
      end;
  end;
end;

procedure TMainForm.ACTION_OptionsExecute(Sender: TObject);
var
  i, j: integer;
begin
  with TOptionsForm.Create(Self) do
    try
      CHECKBOX_MaximizeMainWindow.Checked:=LoadBoolFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'MaximizeWindowOnStartup');
      RADIOGROUP_AlignColumns.ItemIndex:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'AlignColumnWidth');
      if RADIOGROUP_AlignColumns.ItemIndex=-1 then
        RADIOGROUP_AlignColumns.ItemIndex:=0;
      EDIT_ApplicationTitle.Text:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'ApplicationTitle');
      CHECKBOX_ShowServerNameInTitle.Checked:=LoadBoolFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'ShowHostnameInTitle');
      EDIT_LastUserLogin.Text:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastUser');
      EDIT_LastUserPwd.Text:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastUserPwd');
      CHECKBOX_SaveLastUser.Checked:=LoadBoolFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'StoreLastUser');
      BUTTON_DropLastUser.Enabled:=(EDIT_LastUserLogin.Text<>'')and(EDIT_LastUserPwd.Text<>'');
      j:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'ServersCount');
      if j>0 then
        for i:=0 to j-1 do
          COMBOBOX_Servers.Items.Add(LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(i+1), 'HostName'));
      COMBOBOX_Servers.ItemIndex:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastServer')-1;
      COMBOBOX_Servers.Enabled:=COMBOBOX_Servers.Items.Count>0;
      BUTTON_DeleteServer.Enabled:=COMBOBOX_Servers.Items.Count>0;
      i:=LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastServer');
      if (COMBOBOX_Servers.Items.Count>0)and(i>=1) then
        begin
          EDIT_HostName.Text:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(i), 'HostName');
          EDIT_UserLogin.Text:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(i), 'Login');
          EDIT_UserPwd.Text:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(i), 'Password');
          EDIT_Port.Text:=IntToStr(LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(i), 'Port'));
          EDIT_Timeout.Text:=IntToStr(LoadIntegerFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(i), 'TimeOut'));
          EDIT_DBName.Text:=LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(i), 'DBName');
          CHECKBOX_UseCompression.Checked:=LoadBoolFromRegistry('\Software\Vlad DraCooLa\OPERARM\ServerSettings'+IntToStr(i), 'UseCompression');
        end;
      if not bUserIsAdmin then
        begin
          GroupBox4.Visible:=False;
          GroupBox3.Height:=43;
          Height:=325;
          Button3.Visible:=False;
          COMBOBOX_Servers.Width:=225;
          EDIT_LastUserLogin.PasswordChar:='*';
          EDIT_LastUserLogin.Enabled:=False;
          EDIT_LastUserPwd.PasswordChar:='*';
          EDIT_LastUserPwd.Enabled:=False;
          Label2.Enabled:=False;
          Label3.Enabled:=False;
          BUTTON_DeleteServer.Visible:=False;
          CHECKBOX_SaveLastUser.Enabled:=False;
        end;
      ShowModal;
    finally
      Free;
    end;
end;

function TMainForm.LoadBoolFromRegistry(aKey, aValue: string): boolean;
begin
  Result:=False;
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      if OpenKeyReadOnly(aKey) then
        try
          Result:=ReadBool(aValue);
        except
          on ERegistryException do
            Result:=False;
        end;
    finally
      Free;
    end;
end;

function TMainForm.LoadIntegerFromRegistry(aKey, aValue: string): integer;
begin
  Result:=-1;
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      if OpenKeyReadOnly(aKey) then
        try
          Result:=ReadInteger(aValue);
        except
          on ERegistryException do
            Result:=-1;
        end;
    finally
      Free;
    end;
end;

function TMainForm.LoadStringFromRegistry(aKey, aValue: string): string;
begin
  Result:='';
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      if OpenKeyReadOnly(aKey) then
        try
          Result:=ReadString(aValue);
        except
          on ERegistryException do
            Result:='';
        end;
    finally
      Free;
    end;
end;

procedure TMainForm.Maintenance_EraseUnusedMeasureAuthors;
var
  q: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  SL: TStringList;
begin
  Application.ProcessMessages;
  Screen.Cursor:=crHourGlass;
  LogThis('Удаление незадействованных элементов таблицы MEASUREAUTHORS');
  SL:=TStringList.Create;
  // получение количества попадающих под запрос записей
  q:='SELECT measureauthors.id, COUNT(measures.measureauthorid) FROM measureauthors LEFT JOIN measures ON (measures.measureauthorid=measureauthors.id) GROUP BY measureauthors.id;';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
            Screen.Cursor:=crDefault;
            MessageDlg('Не удалось получить количество записей из таблицы MEASUREAUTHORS, попадающих под удаление!', mtError, [mbOk], 0);
            SL.Free;
            Exit;
          end;
        i:=mysql_num_rows(ResultSet);
        for j:=0 to i-1 do
          begin
            ResultRow:=mysql_fetch_row(ResultSet);
            if string(ResultRow[1])='0' then
              SL.Append(string(ResultRow[0]));
          end;
        LogThis('Найдено записей: '+IntToStr(SL.Count));
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if SL.Count=0 then
    begin
      Screen.Cursor:=crDefault;
      SL.Free;
      MessageDlg('Таблица авторов мероприятий (MEASUREAUTHORS) не содержит неиспользуемых записей.', mtInformation, [mbOk], 0);
      LogThis('CANCEL: Операция отменена, т.к. подходящие записи отсутствуют');
      Exit;
    end;
  // непосредственно сама операция
  if (MessageDlg('Вы хотите удалить все неиспользуемые записи об авторах (общим количеством '+IntToStr(SL.Count)+')?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      Application.ProcessMessages;
      for i:=0 to SL.Count-1 do
        begin
          LogThis('Сохранение записи RID '+SL.Strings[i]+' в таблице ERASEDMEASUREAUTHORS...');
          q:='INSERT INTO erasedmeasureauthors SELECT * FROM measureauthors WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
          LogThis('Удаление записи RID '+SL.Strings[i]+' из таблицы MEASUREAUTHORS...');
          q:='DELETE FROM measureauthors WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
        end;
    end
  else
    LogThis('CANCEL: Операция отменена пользователем.');
  SL.Free;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.Maintenance_EraseUnusedMeasureProducers;
var
  q: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  SL: TStringList;
begin
  Application.ProcessMessages;
  Screen.Cursor:=crHourGlass;
  LogThis('Удаление незадействованных элементов таблицы MEASUREPRODUCERS');
  SL:=TStringList.Create;
  // получение количества попадающих под запрос записей
  q:='SELECT measureproducers.id, COUNT(measures.measureproducerid) FROM measureproducers LEFT JOIN measures ON (measures.measureproducerid=measureproducers.id) GROUP BY measureproducers.id;';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
            Screen.Cursor:=crDefault;
            MessageDlg('Не удалось получить количество записей из таблицы MEASUREPRODUCERS, попадающих под удаление!', mtError, [mbOk], 0);
            SL.Free;
            Exit;
          end;
        i:=mysql_num_rows(ResultSet);
        for j:=0 to i-1 do
          begin
            ResultRow:=mysql_fetch_row(ResultSet);
            if string(ResultRow[1])='0' then
              SL.Append(string(ResultRow[0]));
          end;
        LogThis('Найдено записей: '+IntToStr(SL.Count));
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if SL.Count=0 then
    begin
      Screen.Cursor:=crDefault;
      SL.Free;
      MessageDlg('Таблица режиссёров мероприятий (MEASUREPRODUCERS) не содержит неиспользуемых записей.', mtInformation, [mbOk], 0);
      LogThis('CANCEL: Операция отменена, т.к. подходящие записи отсутствуют');
      Exit;
    end;
  // непосредственно сама операция
  if (MessageDlg('Вы хотите удалить все неиспользуемые записи о режиссёрах (общим количеством '+IntToStr(SL.Count)+')?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      Application.ProcessMessages;
      for i:=0 to SL.Count-1 do
        begin
          LogThis('Сохранение записи RID '+SL.Strings[i]+' в таблице ERASEDMEASUREPRODUCERS...');
          q:='INSERT INTO erasedmeasureproducers SELECT * FROM measureproducers WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
          LogThis('Удаление записи RID '+SL.Strings[i]+' из таблицы MEASUREPRODUCERS...');
          q:='DELETE FROM measureproducers WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
        end;
    end
  else
    LogThis('CANCEL: Операция отменена пользователем.');
  SL.Free;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.Maintenance_EraseUnusedMeasureNames;
var
  q: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  SL: TStringList;
begin
  Application.ProcessMessages;
  Screen.Cursor:=crHourGlass;
  LogThis('Удаление незадействованных элементов таблицы MEASURENAMES');
  SL:=TStringList.Create;
  // получение количества попадающих под запрос записей
  q:='SELECT measurenames.id, COUNT(measures.measurenameid) FROM measurenames LEFT JOIN measures ON (measures.measurenameid=measurenames.id) GROUP BY measurenames.id;';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
            Screen.Cursor:=crDefault;
            MessageDlg('Не удалось получить количество записей из таблицы MEASURENAMES, попадающих под удаление!', mtError, [mbOk], 0);
            SL.Free;
            Exit;
          end;
        i:=mysql_num_rows(ResultSet);
        for j:=0 to i-1 do
          begin
            ResultRow:=mysql_fetch_row(ResultSet);
            if string(ResultRow[1])='0' then
              SL.Append(string(ResultRow[0]));
          end;
        LogThis('Найдено записей: '+IntToStr(SL.Count));
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if SL.Count=0 then
    begin
      Screen.Cursor:=crDefault;
      SL.Free;
      MessageDlg('Таблица наименований мероприятий (MEASURENAMES) не содержит неиспользуемых записей.', mtInformation, [mbOk], 0);
      LogThis('CANCEL: Операция отменена, т.к. подходящие записи отсутствуют');
      Exit;
    end;
  // непосредственно сама операция
  if (MessageDlg('Вы хотите удалить все неиспользуемые записи о наименованиях мероприятий (общим количеством '+IntToStr(SL.Count)+')?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      Application.ProcessMessages;
      for i:=0 to SL.Count-1 do
        begin
          LogThis('Сохранение записи RID '+SL.Strings[i]+' в таблице ERASEDMEASURENAMES...');
          q:='INSERT INTO erasedmeasurenames SELECT * FROM measurenames WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
          LogThis('Удаление записи RID '+SL.Strings[i]+' из таблицы MEASURENAMES...');
          q:='DELETE FROM measurenames WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
        end;
    end
  else
    LogThis('CANCEL: Операция отменена пользователем.');
  if GetCurrentMode=0 then
    UpdateCurrentList;
  SL.Free;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.Maintenance_EraseUnusedMeasureTypes;
var
  q: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  SL: TStringList;
begin
  Application.ProcessMessages;
  Screen.Cursor:=crHourGlass;
  LogThis('Удаление незадействованных элементов таблицы MEASURETYPES');
  SL:=TStringList.Create;
  // получение количества попадающих под запрос записей
  q:='SELECT measuretypes.id, COUNT(measures.measuretypeid) FROM measuretypes LEFT JOIN measures ON (measures.measuretypeid=measuretypes.id) GROUP BY measuretypes.id;';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
            Screen.Cursor:=crDefault;
            MessageDlg('Не удалось получить количество записей из таблицы MEASURETYPES, попадающих под удаление!', mtError, [mbOk], 0);
            SL.Free;
            Exit;
          end;
        i:=mysql_num_rows(ResultSet);
        for j:=0 to i-1 do
          begin
            ResultRow:=mysql_fetch_row(ResultSet);
            if string(ResultRow[1])='0' then
              SL.Append(string(ResultRow[0]));
          end;
        LogThis('Найдено записей: '+IntToStr(SL.Count));
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if SL.Count=0 then
    begin
      Screen.Cursor:=crDefault;
      SL.Free;
      MessageDlg('Таблица типов мероприятий (MEASURETYPES) не содержит неиспользуемых записей.', mtInformation, [mbOk], 0);
      LogThis('CANCEL: Операция отменена, т.к. подходящие записи отсутствуют');
      Exit;
    end;
  // непосредственно сама операция
  if (MessageDlg('Вы хотите удалить все неиспользуемые записи о типах мероприятий (общим количеством '+IntToStr(SL.Count)+')?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      Application.ProcessMessages;
      for i:=0 to SL.Count-1 do
        begin
          LogThis('Сохранение записи RID '+SL.Strings[i]+' в таблице ERASEDMEASURETYPES...');
          q:='INSERT INTO erasedmeasuretypes SELECT * FROM measuretypes WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
          LogThis('Удаление записи RID '+SL.Strings[i]+' из таблицы MEASURETYPES...');
          q:='DELETE FROM measuretypes WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
        end;
    end
  else
    LogThis('CANCEL: Операция отменена пользователем.');
  SL.Free;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.Maintenance_EraseUnusedOrganizationNames;
var
  q: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  SL: TStringList;
begin
  Application.ProcessMessages;
  Screen.Cursor:=crHourGlass;
  LogThis('Удаление незадействованных элементов таблицы ORGANIZATIONNAMES');
  SL:=TStringList.Create;
  // получение количества попадающих под запрос записей
  q:='SELECT organizationnames.id, COUNT(measures.organizationnameid) FROM organizationnames LEFT JOIN measures ON (measures.organizationnameid=organizationnames.id) GROUP BY organizationnames.id;';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
            Screen.Cursor:=crDefault;
            MessageDlg('Не удалось получить количество записей из таблицы ORGANIZATIONNAMES, попадающих под удаление!', mtError, [mbOk], 0);
            SL.Free;
            Exit;
          end;
        i:=mysql_num_rows(ResultSet);
        for j:=0 to i-1 do
          begin
            ResultRow:=mysql_fetch_row(ResultSet);
            if string(ResultRow[1])='0' then
              SL.Append(string(ResultRow[0]));
          end;
        LogThis('Найдено записей: '+IntToStr(SL.Count));
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if SL.Count=0 then
    begin
      Screen.Cursor:=crDefault;
      SL.Free;
      MessageDlg('Таблица наименований организаций (ORGANIZATIONNAMES) не содержит неиспользуемых записей.', mtInformation, [mbOk], 0);
      LogThis('CANCEL: Операция отменена, т.к. подходящие записи отсутствуют');
      Exit;
    end;
  // непосредственно сама операция
  if (MessageDlg('Вы хотите удалить все неиспользуемые записи о наименованиях организаций (общим количеством '+IntToStr(SL.Count)+')?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      Application.ProcessMessages;
      for i:=0 to SL.Count-1 do
        begin
          LogThis('Сохранение записи RID '+SL.Strings[i]+' в таблице ERASEDORGANIZATIONNAMES...');
          q:='INSERT INTO erasedorganizationnames SELECT * FROM organizationnames WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
          LogThis('Удаление записи RID '+SL.Strings[i]+' из таблицы ORGANIZATIONNAMES...');
          q:='DELETE FROM organizationnames WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
        end;
    end
  else
    LogThis('CANCEL: Операция отменена пользователем.');
  if GetCurrentMode=1 then
    UpdateCurrentList;
  SL.Free;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.Maintenance_EraseUnusedOrganizationTypes;
var
  q: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  SL: TStringList;
begin
  Application.ProcessMessages;
  Screen.Cursor:=crHourGlass;
  LogThis('Удаление незадействованных элементов таблицы ORGANIZATIONTYPES');
  SL:=TStringList.Create;
  // получение количества попадающих под запрос записей
  q:='SELECT organizationtypes.id, COUNT(measures.organizationtypeid), COUNT(measuretypes.organizationtypeid), COUNT(organizationnames.organizationtypeid) '+
    'FROM organizationtypes LEFT JOIN measures ON (measures.organizationtypeid=organizationtypes.id) LEFT JOIN measuretypes ON (measuretypes.organizationtypeid=organizationtypes.id) '+
    'LEFT JOIN organizationnames ON (organizationnames.organizationtypeid=organizationtypes.id) GROUP BY organizationtypes.id;';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
            Screen.Cursor:=crDefault;
            MessageDlg('Не удалось получить количество записей из таблицы ORGANIZATIONTYPES, попадающих под удаление!', mtError, [mbOk], 0);
            SL.Free;
            Exit;
          end;
        i:=mysql_num_rows(ResultSet);
        for j:=0 to i-1 do
          begin
            ResultRow:=mysql_fetch_row(ResultSet);
            if (string(ResultRow[1])='0')and(string(ResultRow[2])='0')and(string(ResultRow[3])='0') then
              SL.Append(string(ResultRow[0]));
          end;
        LogThis('Найдено записей: '+IntToStr(SL.Count));
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if SL.Count=0 then
    begin
      Screen.Cursor:=crDefault;
      SL.Free;
      MessageDlg('Таблица типов организаций (ORGANIZATIONTYPES) не содержит неиспользуемых записей.', mtInformation, [mbOk], 0);
      LogThis('CANCEL: Операция отменена, т.к. подходящие записи отсутствуют');
      Exit;
    end;
  // непосредственно сама операция
  if (MessageDlg('Вы хотите удалить все неиспользуемые записи о типах организаций (общим количеством '+IntToStr(SL.Count)+')?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      Application.ProcessMessages;
      for i:=0 to SL.Count-1 do
        begin
          LogThis('Сохранение записи RID '+SL.Strings[i]+' в таблице ERASEDORGANIZATIONTYPES...');
          q:='INSERT INTO erasedorganizationtypes SELECT * FROM organizationtypes WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
          LogThis('Удаление записи RID '+SL.Strings[i]+' из таблицы ORGANIZATIONTYPES...');
          q:='DELETE FROM organizationtypes WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
        end;
    end
  else
    LogThis('CANCEL: Операция отменена пользователем.');
  SL.Free;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.Maintenance_EraseUnusedPhoneRefs; // удаление незадействованных ссылок на номера телефонов в базе данных _inform_
var
  q: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  SL: TStringList;
begin
  Application.ProcessMessages;
  Screen.Cursor:=crHourGlass;
  LogThis('Удаление незадействованных элементов таблицы PHONEREFS');
  SL:=TStringList.Create;
  // получение количества попадающих под запрос записей
  q:='SELECT phonerefs.id, phonerefs.phone, COUNT(organizationnames.id), COUNT(measures.id) FROM phonerefs '+'LEFT JOIN organizationnames ON ((organizationnames.organizationphones LIKE CONCAT('+#39+'%'+#39+',phonerefs.phone,'+#39+'%'+#39+')) '+
    'OR (organizationnames.organizationinfo LIKE CONCAT('+#39+'%'+#39+',phonerefs.phone,'+#39+'%'+#39+'))) '+'LEFT JOIN measures ON (measures.measureinfo LIKE CONCAT('+#39+'%'+#39+',phonerefs.phone,'+#39+'%'+#39+')) GROUP BY phonerefs.id;';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
            Screen.Cursor:=crDefault;
            MessageDlg('Не удалось получить количество записей из таблицы телефонных номеров (PHONEREFS), попадающих под удаление!', mtError, [mbOk], 0);
            SL.Free;
            Exit;
          end;
        i:=mysql_num_rows(ResultSet);
        for j:=0 to i-1 do
          begin
            ResultRow:=mysql_fetch_row(ResultSet);
            if (string(ResultRow[2])='0')and(string(ResultRow[3])='0') then
              SL.Append(string(ResultRow[0]));
          end;
        LogThis('Найдено записей: '+IntToStr(SL.Count));
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if SL.Count=0 then
    begin
      Screen.Cursor:=crDefault;
      SL.Free;
      MessageDlg('Таблица PHONEREFS не содержит неиспользуемых записей.', mtInformation, [mbOk], 0);
      LogThis('CANCEL: Операция отменена, т.к. подходящие записи отсутствуют');
      Exit;
    end;
  // непосредственно сама операция
  if (MessageDlg('Вы хотите удалить все неиспользуемые записи таблицы PHONEREFS (общим количеством '+IntToStr(SL.Count)+')?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      Application.ProcessMessages;
      for i:=0 to SL.Count-1 do
        begin
          LogThis('Удаление записи RID '+SL.Strings[i]+' из таблицы PHONEREFS...');
          q:='DELETE FROM phonerefs WHERE id='+#39+SL.Strings[i]+#39+';';
          LogThis('QUERY: '+q);
          if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
            begin
              LogThis('Ошибка!');
              LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
              LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
              if bExitOnError then
                begin
                  Screen.Cursor:=crDefault;
                  SL.Free;
                  Exit;
                end;
            end
          else
            LogThis('Ok');
        end;
    end
  else
    LogThis('CANCEL: Операция отменена пользователем.');
  if GetCurrentMode=3 then
    UpdateCurrentList;
  SL.Free;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.EraseAllGarbage; // полное удаление мусора из базы
begin
  Maintenance_CorrectUnfinishedMeasures; // коррекция конечной даты мероприятий
  Maintenance_EraseAllOutdatedMeasures; // удаление устаревших мероприятий
  Maintenance_EraseUnusedMeasureAuthors; // удаление незадействованных записей об авторах мероприятий
  Maintenance_EraseUnusedMeasureProducers; // удаление незадействованных записей о режиссёрах мероприятий
  Maintenance_EraseUnusedMeasureNames; // удаление незадействованных наименований мероприятий
  Maintenance_EraseUnusedMeasureTypes; // удаление незадействованных типов мероприятий
  Maintenance_EraseUnusedOrganizationNames; // удаление незадействованных наименований организаций
  Maintenance_EraseUnusedOrganizationTypes; // удаление незадействованных типов организаций
  Maintenance_EraseUnusedPhoneRefs; // удаление незадействованных ссылок на номера телефонов в базе данных _inform_
  UpdateCurrentList;
end;

procedure TMainForm.N34Click(Sender: TObject);
begin
  Maintenance_BaseAutoCorrection;
end;

procedure TMainForm.Maintenance_BaseAutoCorrection;
// процедура автоматической корректировки данных базы
var
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  q, f0, f1, f2, f3, f4, f5: string;
  r_num, i: integer;
begin
  if MessageDlg('Вы действительно хотите выполнить процедуру автоматической коррекции базы данных?', mtConfirmation, [mbYes, mbNo], 0)=mrNo then
    Exit;
  Application.ProcessMessages;
  Screen.Cursor:=crHourGlass;
  try
    q:='SELECT id, organizationtype FROM organizationtypes;';
    if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
      begin
        ResultSet:=mysql_store_result(MySQLConnectionHandler);
        try
          if ResultSet=nil then
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          r_num:=mysql_num_rows(ResultSet);
          for i:=0 to r_num-1 do
            begin
              ResultRow:=mysql_fetch_row(ResultSet);
              f0:=string(ResultRow[0]);
              f1:=ValidateString(string(ResultRow[1]));
              if f1<>'' then
                f1:='LCASE('+#39+f1+#39+')'
              else
                f1:='NULL';
              q:='UPDATE organizationtypes SET organizationtype='+f1+' WHERE id='+f0+';';
              TryExecuteUpdateQuery(q, MySQLConnectionHandler);
            end;
        finally
          if ResultSet<>nil then
            mysql_free_result(ResultSet);
        end;
      end;
    q:='SELECT id, organizationname, organizationaddress, organizationhowtoreach, organizationphones, organizationinfo FROM organizationnames;';
    if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
      begin
        ResultSet:=mysql_store_result(MySQLConnectionHandler);
        try
          if ResultSet=nil then
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONNAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          r_num:=mysql_num_rows(ResultSet);
          for i:=0 to r_num-1 do
            begin
              ResultRow:=mysql_fetch_row(ResultSet);
              f0:=string(ResultRow[0]);
              f1:=ValidateString(string(ResultRow[1]));
              if f1<>'' then
                f1:=#39+f1+#39
              else
                f1:='NULL';
              f2:=ValidateString(string(ResultRow[2]));
              if f2<>'' then
                f2:=#39+f2+#39
              else
                f2:='NULL';
              f3:=ValidateString(string(ResultRow[3]));
              if f3<>'' then
                f3:=#39+f3+#39
              else
                f3:='NULL';
              f4:=ValidateString(string(ResultRow[4]));
              if f4<>'' then
                f4:=#39+f4+#39
              else
                f4:='NULL';
              f5:=ValidateString(string(ResultRow[5]));
              if f5<>'' then
                f5:=#39+f5+#39
              else
                f5:='NULL';
              q:='UPDATE organizationnames SET organizationname='+f1+', organizationaddress='+f2+', organizationhowtoreach='+f3+', organizationphones='+f4+', organizationinfo='+f5+' WHERE id='+f0+';';
              TryExecuteUpdateQuery(q, MySQLConnectionHandler);
            end;
        finally
          if ResultSet<>nil then
            mysql_free_result(ResultSet);
        end;
      end;
    q:='SELECT id, measuretype FROM measuretypes;';
    if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
      begin
        ResultSet:=mysql_store_result(MySQLConnectionHandler);
        try
          if ResultSet=nil then
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURETYPES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          r_num:=mysql_num_rows(ResultSet);
          for i:=0 to r_num-1 do
            begin
              ResultRow:=mysql_fetch_row(ResultSet);
              f0:=string(ResultRow[0]);
              f1:=ValidateString(string(ResultRow[1]));
              if f1<>'' then
                f1:=#39+f1+#39
              else
                f1:='NULL';
              q:='UPDATE measuretypes SET measuretype='+f1+' WHERE id='+f0+';';
              TryExecuteUpdateQuery(q, MySQLConnectionHandler);
            end;
        finally
          if ResultSet<>nil then
            mysql_free_result(ResultSet);
        end;
      end;
    q:='SELECT id, measurename FROM measurenames;';
    if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
      begin
        ResultSet:=mysql_store_result(MySQLConnectionHandler);
        try
          if ResultSet=nil then
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURENAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          r_num:=mysql_num_rows(ResultSet);
          for i:=0 to r_num-1 do
            begin
              ResultRow:=mysql_fetch_row(ResultSet);
              f0:=string(ResultRow[0]);
              f1:=ValidateString(string(ResultRow[1]));
              if f1<>'' then
                f1:=#39+f1+#39
              else
                f1:='NULL';
              q:='UPDATE measurenames SET measurename='+f1+' WHERE id='+f0+';';
              TryExecuteUpdateQuery(q, MySQLConnectionHandler);
            end;
        finally
          if ResultSet<>nil then
            mysql_free_result(ResultSet);
        end;
      end;
    q:='SELECT id, measureauthor FROM measureauthors;';
    if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
      begin
        ResultSet:=mysql_store_result(MySQLConnectionHandler);
        try
          if ResultSet=nil then
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREAUTHORS! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          r_num:=mysql_num_rows(ResultSet);
          for i:=0 to r_num-1 do
            begin
              ResultRow:=mysql_fetch_row(ResultSet);
              f0:=string(ResultRow[0]);
              f1:=ValidateString(string(ResultRow[1]));
              if f1<>'' then
                f1:=#39+f1+#39
              else
                f1:='NULL';
              q:='UPDATE measureauthors SET measureauthor='+f1+' WHERE id='+f0+';';
              TryExecuteUpdateQuery(q, MySQLConnectionHandler);
            end;
        finally
          if ResultSet<>nil then
            mysql_free_result(ResultSet);
        end;
      end;
    q:='SELECT id, measureproducer FROM measureproducers;';
    if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
      begin
        ResultSet:=mysql_store_result(MySQLConnectionHandler);
        try
          if ResultSet=nil then
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREPRODUCERS! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          r_num:=mysql_num_rows(ResultSet);
          for i:=0 to r_num-1 do
            begin
              ResultRow:=mysql_fetch_row(ResultSet);
              f0:=string(ResultRow[0]);
              f1:=ValidateString(string(ResultRow[1]));
              if f1<>'' then
                f1:=#39+f1+#39
              else
                f1:='NULL';
              q:='UPDATE measureproducers SET measureproducer='+f1+' WHERE id='+f0+';';
              TryExecuteUpdateQuery(q, MySQLConnectionHandler);
            end;
        finally
          if ResultSet<>nil then
            mysql_free_result(ResultSet);
        end;
      end;
    q:='SELECT id, measureticketprice, measureperformer, measureorganizer, measureinfo FROM measures;';
    if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
      begin
        ResultSet:=mysql_store_result(MySQLConnectionHandler);
        try
          if ResultSet=nil then
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          r_num:=mysql_num_rows(ResultSet);
          for i:=0 to r_num-1 do
            begin
              ResultRow:=mysql_fetch_row(ResultSet);
              f0:=string(ResultRow[0]);
              f1:=ValidateString(string(ResultRow[1]));
              if f1<>'' then
                f1:=#39+f1+#39
              else
                f1:='NULL';
              f2:=ValidateString(string(ResultRow[2]));
              if f2<>'' then
                f2:=#39+f2+#39
              else
                f2:='NULL';
              f3:=ValidateString(string(ResultRow[3]));
              if f3<>'' then
                f3:=#39+f3+#39
              else
                f3:='NULL';
              f4:=ValidateString(string(ResultRow[4]));
              if f4<>'' then
                f4:=#39+f4+#39
              else
                f4:='NULL';
              q:='UPDATE measures SET measureticketprice='+f1+', measureperformer='+f2+', measureorganizer='+f3+', measureinfo='+f4+' WHERE id='+f0+';';
              TryExecuteUpdateQuery(q, MySQLConnectionHandler);
            end;
        finally
          if ResultSet<>nil then
            mysql_free_result(ResultSet);
        end;
      end;
  finally
    Screen.Cursor:=crDefault;
    UpdateCurrentList;
  end;
end;

procedure TMainForm.UpdateFilterPanel(Sender: TObject);
begin
  case GetCurrentMode of
    0:
      begin
        if COMBOBOX_OrganizationType.Text<>'' then
          COMBOBOX_OrganizationType.Color:=clWindow
        else
          COMBOBOX_OrganizationType.Color:=clInfoBk;
        // COMBOBOX_OrganizationType.Hint:=COMBOBOX_OrganizationType.Text;
        if COMBOBOX_OrganizationName.Text<>'' then
          COMBOBOX_OrganizationName.Color:=clWindow
        else
          COMBOBOX_OrganizationName.Color:=clInfoBk;
        // COMBOBOX_OrganizationName.Hint:=COMBOBOX_OrganizationName.Text;
        if COMBOBOX_MeasureType.Text<>'' then
          COMBOBOX_MeasureType.Color:=clWindow
        else
          COMBOBOX_MeasureType.Color:=clInfoBk;
        // COMBOBOX_MeasureType.Hint:=COMBOBOX_MeasureType.Text;
        if COMBOBOX_MeasureName.Text<>'' then
          COMBOBOX_MeasureName.Color:=clWindow
        else
          COMBOBOX_MeasureName.Color:=clInfoBk;
        // COMBOBOX_MeasureName.Hint:=COMBOBOX_MeasureName.Text;
        if COMBOBOX_MeasureAuthor.Text<>'' then
          COMBOBOX_MeasureAuthor.Color:=clWindow
        else
          COMBOBOX_MeasureAuthor.Color:=clInfoBk;
        // COMBOBOX_MeasureAuthor.Hint:=COMBOBOX_MeasureAuthor.Text;
        if COMBOBOX_MeasureProducer.Text<>'' then
          COMBOBOX_MeasureProducer.Color:=clWindow
        else
          COMBOBOX_MeasureProducer.Color:=clInfoBk;
        // COMBOBOX_MeasureProducer.Hint:=COMBOBOX_MeasureProducer.Text;
        if COMBOBOX_MeasureInfo.Text<>'' then
          COMBOBOX_MeasureInfo.Color:=clWindow
        else
          COMBOBOX_MeasureInfo.Color:=clInfoBk;
        // COMBOBOX_MeasureInfo.Hint:=COMBOBOX_MeasureInfo.Text;
        ACTION_ClearFilter.Enabled:=(COMBOBOX_OrganizationType.Text<>'')or(COMBOBOX_OrganizationName.Text<>'')or(COMBOBOX_MeasureType.Text<>'')or(COMBOBOX_MeasureName.Text<>'')or(COMBOBOX_MeasureAuthor.Text<>'')or(COMBOBOX_MeasureProducer.Text<>'')or
          (COMBOBOX_MeasureInfo.Text<>'')or(CHECKBOX_MeasureStartDateTime.Checked)or(CHECKBOX_MeasureStopDateTime.Checked)or(CHECKBOX_MeasurePremier.Checked)or(CHECKBOX_ChildrenMeasure.Checked)or(CHECKBOX_TeenagerMeasure.Checked);
        if Sender<>nil then
          BUTTON_Apply_Mode_Measures.Font.Style:=BUTTON_Apply_Mode_Measures.Font.Style+[fsBold];
      end;
    1:
      begin
        if COMBOBOX_OrganizationType2.Text<>'' then
          COMBOBOX_OrganizationType2.Color:=clWindow
        else
          COMBOBOX_OrganizationType2.Color:=clInfoBk;
        // COMBOBOX_OrganizationType2.Hint:=COMBOBOX_OrganizationType2.Text;
        if COMBOBOX_OrganizationName2.Text<>'' then
          COMBOBOX_OrganizationName2.Color:=clWindow
        else
          COMBOBOX_OrganizationName2.Color:=clInfoBk;
        // COMBOBOX_OrganizationName2.Hint:=COMBOBOX_OrganizationName2.Text;
        if COMBOBOX_OrganizationAddress.Text<>'' then
          COMBOBOX_OrganizationAddress.Color:=clWindow
        else
          COMBOBOX_OrganizationAddress.Color:=clInfoBk;
        // COMBOBOX_OrganizationAddress.Hint:=COMBOBOX_OrganizationAddress.Text;
        if COMBOBOX_OrganizationHowToReach.Text<>'' then
          COMBOBOX_OrganizationHowToReach.Color:=clWindow
        else
          COMBOBOX_OrganizationHowToReach.Color:=clInfoBk;
        // COMBOBOX_OrganizationHowToReach.Hint:=COMBOBOX_OrganizationHowToReach.Text;
        if COMBOBOX_OrganizationPhones.Text<>'' then
          COMBOBOX_OrganizationPhones.Color:=clWindow
        else
          COMBOBOX_OrganizationPhones.Color:=clInfoBk;
        // COMBOBOX_OrganizationPhones.Hint:=COMBOBOX_OrganizationPhones.Text;
        if COMBOBOX_OrganizationInfo.Text<>'' then
          COMBOBOX_OrganizationInfo.Color:=clWindow
        else
          COMBOBOX_OrganizationInfo.Color:=clInfoBk;
        // COMBOBOX_OrganizationInfo.Hint:=COMBOBOX_OrganizationInfo.Text;
        ACTION_ClearFilter.Enabled:=(COMBOBOX_OrganizationType2.Text<>'')or(COMBOBOX_OrganizationName2.Text<>'')or(COMBOBOX_OrganizationAddress.Text<>'')or(COMBOBOX_OrganizationHowToReach.Text<>'')or(COMBOBOX_OrganizationPhones.Text<>'')or
          (COMBOBOX_OrganizationInfo.Text<>'');
        if Sender<>nil then
          BUTTON_Apply_Mode_Organizations.Font.Style:=BUTTON_Apply_Mode_Organizations.Font.Style+[fsBold];
      end;
    2:
      begin
        ACTION_ClearFilter.Enabled:=CB_DBOperator.Checked or CB_DBAdministrator.Checked;
        if Sender<>nil then
          BUTTON_Apply_Mode_Users.Font.Style:=BUTTON_Apply_Mode_Users.Font.Style+[fsBold];
      end;
    3:
      begin
        (* !!!ДОПИСАТЬ!!! *)
      end;
  end;
end;

procedure TMainForm.COMBOBOX_OrganizationAddressDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_OrganizationAddress.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_OrganizationAddress.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(organizationaddress) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля ORGANIZATIONADDRESS, попадающих под введённый фильтр');
  q:='SELECT organizationaddress FROM organizationnames'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONNAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrganizationAddress.Text;
            COMBOBOX_OrganizationAddress.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_OrganizationAddress.Items.IndexOf(s)<0) then
                      COMBOBOX_OrganizationAddress.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_OrganizationAddress.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_OrganizationAddress.ItemIndex:=0
            else
              COMBOBOX_OrganizationAddress.ItemIndex:=COMBOBOX_OrganizationAddress.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_OrganizationAddress.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_OrganizationAddress.Hint:=COMBOBOX_OrganizationAddress.Text;
end;

procedure TMainForm.COMBOBOX_OrganizationHowToReachDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_OrganizationHowToReach.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_OrganizationHowToReach.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(organizationhowtoreach) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля ORGANIZATIONHOWTOREACH, попадающих под введённый фильтр');
  q:='SELECT organizationhowtoreach FROM organizationnames'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONNAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrganizationHowToReach.Text;
            COMBOBOX_OrganizationHowToReach.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_OrganizationHowToReach.Items.IndexOf(s)<0) then
                      COMBOBOX_OrganizationHowToReach.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_OrganizationHowToReach.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_OrganizationHowToReach.ItemIndex:=0
            else
              COMBOBOX_OrganizationHowToReach.ItemIndex:=COMBOBOX_OrganizationHowToReach.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_OrganizationHowToReach.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_OrganizationHowToReach.Hint:=COMBOBOX_OrganizationHowToReach.Text;
end;

procedure TMainForm.COMBOBOX_OrganizationPhonesDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_OrganizationPhones.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_OrganizationPhones.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(organizationphones) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля ORGANIZATIONPHONES, попадающих под введённый фильтр');
  q:='SELECT organizationphones FROM organizationnames'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONNAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrganizationPhones.Text;
            COMBOBOX_OrganizationPhones.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_OrganizationPhones.Items.IndexOf(s)<0) then
                      COMBOBOX_OrganizationPhones.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_OrganizationPhones.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_OrganizationPhones.ItemIndex:=0
            else
              COMBOBOX_OrganizationPhones.ItemIndex:=COMBOBOX_OrganizationPhones.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_OrganizationPhones.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_OrganizationPhones.Hint:=COMBOBOX_OrganizationPhones.Text;
end;

procedure TMainForm.COMBOBOX_OrganizationInfoDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_OrganizationInfo.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_OrganizationInfo.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(organizationinfo) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля ORGANIZATIONINFO, попадающих под введённый фильтр');
  q:='SELECT organizationinfo FROM organizationnames'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONNAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrganizationInfo.Text;
            COMBOBOX_OrganizationInfo.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_OrganizationInfo.Items.IndexOf(s)<0) then
                      COMBOBOX_OrganizationInfo.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_OrganizationInfo.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_OrganizationInfo.ItemIndex:=0
            else
              COMBOBOX_OrganizationInfo.ItemIndex:=COMBOBOX_OrganizationInfo.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_OrganizationInfo.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_OrganizationInfo.Hint:=COMBOBOX_OrganizationInfo.Text;
end;

procedure TMainForm.COMBOBOX_OrganizationType2DropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_OrganizationType2.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_OrganizationType2.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(organizationtype) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля ORGANIZATIONTYPE, попадающих под введённый фильтр');
  q:='SELECT organizationtype FROM organizationtypes'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrganizationType2.Text;
            COMBOBOX_OrganizationType2.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_OrganizationType2.Items.IndexOf(s)<0) then
                      COMBOBOX_OrganizationType2.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_OrganizationType2.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_OrganizationType2.ItemIndex:=0
            else
              COMBOBOX_OrganizationType2.ItemIndex:=COMBOBOX_OrganizationType2.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_OrganizationType2.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_OrganizationType2.Hint:=COMBOBOX_OrganizationType2.Text;
end;

procedure TMainForm.COMBOBOX_OrganizationName2DropDown(Sender: TObject);
var
  q, s, s1, s2: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if COMBOBOX_OrganizationType2.Text<>'' then
    begin
      s2:='';
      SL:=TStringList.Create;
      s2:=Trim(COMBOBOX_OrganizationType2.Text);
      while Pos('  ', s2)>0 do
        s2:=StringReplace(s2, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s2, SL, ' ');
      i:=SL.Count;
      s2:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s2<>'' then
                s2:=s2+' AND ';
              s2:=s2+'(UPPER(organizationtype) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          if s2<>'' then
            s2:=' ('+s2+')';
        end;
      SL.Free;
      if (COMBOBOX_OrganizationName2.Text<>'') then
        begin
          SL:=TStringList.Create;
          s:=Trim(COMBOBOX_OrganizationName2.Text);
          while Pos('  ', s)>0 do
            s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
          CutStringByLimiterToStringList(s, SL, ' ');
          i:=SL.Count;
          s:='';
          if i>0 then
            begin
              while (SL.Count>0) do
                begin
                  if s<>'' then
                    s:=s+' AND ';
                  s:=s+'(UPPER(organizationname) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
                  SL.Delete(0);
                end;
              if s<>'' then
                s:=' ('+s+')';
            end;
          SL.Free;
        end;
      if (s2<>'')and(s<>'') then
        s:=' WHERE'+s2+' AND '+s
      else
        begin
          if s2<>'' then
            s:=' WHERE'+s2
          else
            begin
              if s<>'' then
                s:=' WHERE'+s;
            end;
        end;
      q:='SELECT organizationname FROM organizationnames LEFT JOIN organizationtypes ON (organizationtypes.id=organizationtypeid)'+s+';';
    end
  else
    begin
      if (COMBOBOX_OrganizationName2.Text<>'') then
        begin
          SL:=TStringList.Create;
          s:=Trim(COMBOBOX_OrganizationName2.Text);
          while Pos('  ', s)>0 do
            s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
          CutStringByLimiterToStringList(s, SL, ' ');
          i:=SL.Count;
          s:='';
          if i>0 then
            begin
              while (SL.Count>0) do
                begin
                  if s<>'' then
                    s:=s+' AND ';
                  s:=s+'(UPPER(organizationname) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
                  SL.Delete(0);
                end;
              s:=' WHERE ('+s+')';
            end;
          SL.Free;
        end;
      q:='SELECT organizationname FROM organizationnames'+s+';';
    end;
  LogThis('Составление списка значений поля ORGANIZATIONNAME, попадающих под введённый фильтр');
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблиц ORGANIZATIONTYPES, ORGANIZATIONNAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))
                  +HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrganizationName2.Text;
            COMBOBOX_OrganizationName2.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_OrganizationName2.Items.IndexOf(s)<0) then
                      COMBOBOX_OrganizationName2.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_OrganizationName2.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_OrganizationName2.ItemIndex:=0
            else
              COMBOBOX_OrganizationName2.ItemIndex:=COMBOBOX_OrganizationName2.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_OrganizationName2.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_OrganizationName2.Hint:=COMBOBOX_OrganizationName2.Text;
end;

procedure TMainForm.COMBOBOX_MeasureAuthorDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_MeasureAuthor.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_MeasureAuthor.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(measureauthor) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля MEASUREAUTHOR, попадающих под введённый фильтр');
  q:='SELECT measureauthor FROM measureauthors'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREAUTHORS! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_MeasureAuthor.Text;
            COMBOBOX_MeasureAuthor.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_MeasureAuthor.Items.IndexOf(s)<0) then
                      COMBOBOX_MeasureAuthor.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_MeasureAuthor.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_MeasureAuthor.ItemIndex:=0
            else
              COMBOBOX_MeasureAuthor.ItemIndex:=COMBOBOX_MeasureAuthor.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_MeasureAuthor.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_MeasureAuthor.Hint:=COMBOBOX_MeasureAuthor.Text;
end;

procedure TMainForm.COMBOBOX_MeasureProducerDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_MeasureProducer.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_MeasureProducer.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(measureproducer) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля MEASUREPRODUCER, попадающих под введённый фильтр');
  q:='SELECT measureproducer FROM measureproducers'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREPRODUCERS! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_MeasureProducer.Text;
            COMBOBOX_MeasureProducer.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_MeasureProducer.Items.IndexOf(s)<0) then
                      COMBOBOX_MeasureProducer.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_MeasureProducer.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_MeasureProducer.ItemIndex:=0
            else
              COMBOBOX_MeasureProducer.ItemIndex:=COMBOBOX_MeasureProducer.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_MeasureProducer.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_MeasureProducer.Hint:=COMBOBOX_MeasureProducer.Text;
end;

procedure TMainForm.COMBOBOX_MeasureInfoDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_MeasureInfo.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_MeasureInfo.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(measureinfo) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля MEASUREINFO, попадающих под введённый фильтр');
  q:='SELECT measureinfo FROM measures'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_MeasureInfo.Text;
            COMBOBOX_MeasureInfo.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_MeasureInfo.Items.IndexOf(s)<0) then
                      COMBOBOX_MeasureInfo.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_MeasureInfo.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_MeasureInfo.ItemIndex:=0
            else
              COMBOBOX_MeasureInfo.ItemIndex:=COMBOBOX_MeasureInfo.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_MeasureInfo.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_MeasureInfo.Hint:=COMBOBOX_MeasureInfo.Text;
end;

procedure TMainForm.COMBOBOX_MeasureNameDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_MeasureName.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_MeasureName.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(measurename) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля MEASURENAME, попадающих под введённый фильтр');
  q:='SELECT measurename FROM measurenames'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURENAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_MeasureName.Text;
            COMBOBOX_MeasureName.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_MeasureName.Items.IndexOf(s)<0) then
                      COMBOBOX_MeasureName.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_MeasureName.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_MeasureName.ItemIndex:=0
            else
              COMBOBOX_MeasureName.ItemIndex:=COMBOBOX_MeasureName.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_MeasureName.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_MeasureName.Hint:=COMBOBOX_MeasureName.Text;
end;

procedure TMainForm.COMBOBOX_OrganizationTypeDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_OrganizationType.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_OrganizationType.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(organizationtype) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля ORGANIZATIONTYPE, попадающих под введённый фильтр');
  q:='SELECT organizationtype FROM organizationtypes'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrganizationType.Text;
            COMBOBOX_OrganizationType.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_OrganizationType.Items.IndexOf(s)<0) then
                      COMBOBOX_OrganizationType.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_OrganizationType.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_OrganizationType.ItemIndex:=0
            else
              COMBOBOX_OrganizationType.ItemIndex:=COMBOBOX_OrganizationType.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_OrganizationType.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_OrganizationType.Hint:=COMBOBOX_OrganizationType.Text;
end;

procedure TMainForm.N33Click(Sender: TObject);
begin
  EraseAllGarbage;
end;

procedure TMainForm.COMBOBOX_OrganizationNameDropDown(Sender: TObject);
var
  q, s, s1, s2: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if COMBOBOX_OrganizationType.Text<>'' then
    begin
      s2:='';
      SL:=TStringList.Create;
      s2:=Trim(COMBOBOX_OrganizationType.Text);
      while Pos('  ', s2)>0 do
        s2:=StringReplace(s2, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s2, SL, ' ');
      i:=SL.Count;
      s2:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s2<>'' then
                s2:=s2+' AND ';
              s2:=s2+'(UPPER(organizationtype) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          if s2<>'' then
            s2:=' ('+s2+')';
        end;
      SL.Free;
      if (COMBOBOX_OrganizationName.Text<>'') then
        begin
          SL:=TStringList.Create;
          s:=Trim(COMBOBOX_OrganizationName.Text);
          while Pos('  ', s)>0 do
            s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
          CutStringByLimiterToStringList(s, SL, ' ');
          i:=SL.Count;
          s:='';
          if i>0 then
            begin
              while (SL.Count>0) do
                begin
                  if s<>'' then
                    s:=s+' AND ';
                  s:=s+'(UPPER(organizationname) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
                  SL.Delete(0);
                end;
              if s<>'' then
                s:=' ('+s+')';
            end;
          SL.Free;
        end;
      if (s2<>'')and(s<>'') then
        s:=' WHERE'+s2+' AND '+s
      else
        begin
          if s2<>'' then
            s:=' WHERE'+s2
          else
            begin
              if s<>'' then
                s:=' WHERE'+s;
            end;
        end;
      q:='SELECT organizationname FROM organizationnames LEFT JOIN organizationtypes ON (organizationtypes.id=organizationtypeid)'+s+';';
    end
  else
    begin
      if (COMBOBOX_OrganizationName.Text<>'') then
        begin
          SL:=TStringList.Create;
          s:=Trim(COMBOBOX_OrganizationName.Text);
          while Pos('  ', s)>0 do
            s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
          CutStringByLimiterToStringList(s, SL, ' ');
          i:=SL.Count;
          s:='';
          if i>0 then
            begin
              while (SL.Count>0) do
                begin
                  if s<>'' then
                    s:=s+' AND ';
                  s:=s+'(UPPER(organizationname) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
                  SL.Delete(0);
                end;
              s:=' WHERE ('+s+')';
            end;
          SL.Free;
        end;
      q:='SELECT organizationname FROM organizationnames'+s+';';
    end;
  LogThis('Составление списка значений поля ORGANIZATIONNAME, попадающих под введённый фильтр');
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблиц ORGANIZATIONTYPES, ORGANIZATIONNAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))
                  +HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrganizationName.Text;
            COMBOBOX_OrganizationName.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_OrganizationName.Items.IndexOf(s)<0) then
                      COMBOBOX_OrganizationName.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_OrganizationName.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_OrganizationName.ItemIndex:=0
            else
              COMBOBOX_OrganizationName.ItemIndex:=COMBOBOX_OrganizationName.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_OrganizationName.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_OrganizationName.Hint:=COMBOBOX_OrganizationName.Text;
end;

procedure TMainForm.COMBOBOX_MeasureTypeDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  SL: TStringList;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  b: boolean;
begin
  s:='';
  if (COMBOBOX_MeasureType.Text<>'') then
    begin
      SL:=TStringList.Create;
      s:=Trim(COMBOBOX_MeasureType.Text);
      while Pos('  ', s)>0 do
        s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
      CutStringByLimiterToStringList(s, SL, ' ');
      i:=SL.Count;
      s:='';
      if i>0 then
        begin
          while (SL.Count>0) do
            begin
              if s<>'' then
                s:=s+' AND ';
              s:=s+'(UPPER(measuretype) LIKE UPPER('+#39+'% '+SL.Strings[0]+'%'+#39+'))';
              SL.Delete(0);
            end;
          s:=' WHERE ('+s+')';
        end;
      SL.Free;
    end;
  LogThis('Составление списка значений поля MEASURETYPE, попадающих под введённый фильтр');
  q:='SELECT measuretype FROM measuretypes'+s+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURETYPES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_MeasureType.Text;
            COMBOBOX_MeasureType.Clear;
            j:=mysql_num_rows(ResultSet);
            LogThis('Найдено записей: '+IntToStr(j));
            b:=False;
            for i:=0 to j-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                if s<>'' then
                  begin
                    if (COMBOBOX_MeasureType.Items.IndexOf(s)<0) then
                      COMBOBOX_MeasureType.Items.Append(s);
                  end
                else
                  if b=False then
                    begin
                      COMBOBOX_MeasureType.Items.Append(s);
                      b:=True;
                    end;
              end;
            if b=True then
              COMBOBOX_MeasureType.ItemIndex:=0
            else
              COMBOBOX_MeasureType.ItemIndex:=COMBOBOX_MeasureType.Items.IndexOf(s1);
            LogThis('Количество уникальных элементов добавлено в выпадающий список: '+IntToStr(COMBOBOX_MeasureType.Items.Count));
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  // COMBOBOX_MeasureType.Hint:=COMBOBOX_MeasureType.Text;
end;

(*
  function TMainForm.RemovePhoneTags(a: string):string;
  var
  s, s2: string;
  i: integer;
  begin
  s:='';
  s2:=StringReplace(a,PHONENUMBERTAG,'',[rfReplaceAll,rfIgnoreCase]);
  i:=Pos(PHONEINDEXTAG,s2);
  while i>0 do
  begin
  s:=s2;
  s2:=Copy(s,1,i-1);
  s:=Copy(s,i+1,Length(s));
  s2:=s2+Copy(s,Pos('~',s)+1,Length(s));
  i:=Pos(PHONEINDEXTAG,s2);
  end;
  Result:=s2;
  end;
*)
(*
  function TMainForm.InsertPhoneTags(a: string):string;
  var
  s, sPhoneIndex, sPhoneString: string;
  i, sl: integer;
  //q: string;
  //ResultSet: PMYSQL_RES;
  //ResultRow: PMYSQL_ROW;
  begin
  // внаяале убираем все тэги
  //RemovePhoneTags(a: string):string;
  // а теперь заново добавляем тэги
  s:='';
  sl:=Length(a);
  i:=0;
  while i<sl do
  begin
  Inc(i);
  if a[i]=' ' then
  begin
  if ((i+9)<=sl) then // если до коныа строки ещё может уместиться номер формата ХХХ-ХХ-ХХ, проверяем он ли это
  begin
  if (a[i+1] in ['0'..'9']) then
  begin
  if ((a[i+2] in ['0'..'9']) and (a[i+3] in ['0'..'9']) and (a[i+4] in [' ','-']) and (a[i+5] in ['0'..'9']) and (a[i+6] in ['0'..'9']) and (a[i+7] in [' ','-']) and (a[i+8] in ['0'..'9']) and (a[i+9] in ['0'..'9'])) then
  begin
  // да, похоже это номер такого формата
  if (MessageDlg('Является-ли в строке'+RN+RN+a+RN+RN+'подстрока'+RN+RN+a[i+1]+a[i+2]+a[i+3]+'-'+a[i+5]+a[i+6]+'-'+a[i+8]+a[i+9]+RN+RN+'номером телефона?',mtConfirmation,[mbYes,mbNo],0)=mrYes) then
  begin
  sPhoneString:=a[i+1]+a[i+2]+a[i+3]+a[i+5]+a[i+6]+a[i+8]+a[i+9];
  {
  q:='SELECT rowid FROM _inform_.firma_po WHERE broj_tel>'+#39+#39+' AND broj_tel='+#39+sPhoneString+#39+';';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
  begin
  ResultSet:=mysql_store_result(MySQLConnectionHandler);
  try
  if ResultSet=nil then
  begin
  LogThis('INFO: Нoмер телефона '+sPhoneString+' не найден в таблице _inform_.firma_po!');
  LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
  LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
  Screen.Cursor:=crDefault;
  Exit;
  end;
  ResultRow:=mysql_fetch_row(ResultSet);
  if ResultRow<>nil then
  sPhoneIndex:=string(ResultRow[0])
  else sPhoneIndex:='';
  finally
  if ResultSet<>nil then
  mysql_free_result(ResultSet);
  end;
  end;
  }
  s:=s+a[i]+PHONENUMBERTAG+a[i+1]+a[i+2]+a[i+3]+'-'+a[i+5]+a[i+6]+'-'+a[i+8]+a[i+9]+PHONEINDEXTAG+sPhoneIndex+'~';
  i:=i+9;
  end
  else
  begin
  s:=s+a[i];
  Continue;
  end;
  end;
  end
  else s:=s+a[i];
  end
  else s:=s+a[i];
  end
  else s:=s+a[i];
  end;
  Result:=s;
  end;
*)

procedure TMainForm.AddListedPhonesToDB(a: string);
var
  i, j, alength, pns, pnt: integer;
  s, sPhoneString, sPhoneNumString, q: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  // просматриваем всю строку на наличие номеров телефонов
  i:=0;
  alength:=Length(a);
  while i<alength do // делаем, пока не будет достигнут конец строки
    begin
      Inc(i); // переходим к следующему символу
      if a[i]=' ' then // если этот символ - пробел
        begin
          // определяем количество символов до конца строки в целях избежания исключительной ситуации выхода за пределы массива
          pns:=-1;
          if ((i+2)<=alength) then
            pns:=2;
          if ((i+3)<=alength) then
            pns:=3;
          if ((i+7)<=alength) then
            pns:=7;
          if ((i+9)<=alength) then
            pns:=9;
          pnt:=-1;
          if CharInSet(a[i+1], ['0'..'9']) then // если за пробелом следует цифра, то проверяем на попадение под шаблоны маски телефонов
            begin
              if ((pns>=9)and(pnt<0)) then
                if ((CharInSet(a[i+2], ['0'..'9']))and(CharInSet(a[i+3], ['0'..'9']))and(CharInSet(a[i+4], [' ', '-']))and(CharInSet(a[i+5], ['0'..'9']))and(CharInSet(a[i+6], ['0'..'9']))and(CharInSet(a[i+7], [' ', '-']))and(CharInSet(a[i+8],
                      ['0'..'9']))and(CharInSet(a[i+9], ['0'..'9']))) then
                  pnt:=9; // похоже на семизначный номер телефона с разделителями
              if ((pns>=7)and(pnt<0)) then
                if (CharInSet(a[i+2], ['0'..'9'])and(CharInSet(a[i+3], ['0'..'9']))and(CharInSet(a[i+4], ['0'..'9']))and(CharInSet(a[i+5], ['0'..'9']))and(CharInSet(a[i+6], ['0'..'9']))and(CharInSet(a[i+7], ['0'..'9']))and
                    (not(CharInSet(a[i+8], ['0'..'9'])))) then
                  pnt:=7; // похоже на семизначный номер телефона без разделителей
              if ((pns>=3)and(pnt<0)) then
                if (CharInSet(a[i+2], ['0'..'9'])and(CharInSet(a[i+3], ['0'..'9']))and(not(CharInSet(a[i+4], ['0'..'9'])))) then
                  pnt:=3; // похоже на трёхзначный номер телефона
              if ((pns>=2)and(pnt<0)) then
                if CharInSet(a[i+2], ['0'..'9'])and(not(CharInSet(a[i+3], ['0'..'9']))) then
                  pnt:=2; // похоже на двузначный номер телефона
              case pnt of
                2:
                  sPhoneString:=a[i+1]+a[i+2];
                3:
                  sPhoneString:=a[i+1]+a[i+2]+a[i+3];
                7:
                  sPhoneString:=a[i+1]+a[i+2]+a[i+3]+a[i+4]+a[i+5]+a[i+6]+a[i+7];
                9:
                  sPhoneString:=a[i+1]+a[i+2]+a[i+3]+'-'+a[i+5]+a[i+6]+'-'+a[i+8]+a[i+9];
              else
                sPhoneString:='';
              end;
              if (MessageDlg('Является-ли в строке'+RN+RN+a+RN+RN+'подстрока'+RN+RN+sPhoneString+RN+RN+'номером телефона?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
                begin
                  Inc(i, pnt);
                  // оставляем в номере только цифры
                  sPhoneNumString:='';
                  for j:=1 to Length(sPhoneString) do
                    if CharInSet(sPhoneString[j], ['0'..'9']) then
                      sPhoneNumString:=sPhoneNumString+sPhoneString[j];
                  // поиск в таблице rne.phonerefs
                  q:='SELECT id FROM phonerefs WHERE phone='+#39+sPhoneString+#39+';';
                  LogThis('QUERY: '+q);
                  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                    begin
                      ResultSet:=mysql_store_result(MySQLConnectionHandler);
                      try
                        if ResultSet=nil then
                          begin
                            LogThis('ERROR: Выборка пуста!');
                            LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
                            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
                          end;
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow<>nil then
                          s:=string(ResultRow[0])
                        else
                          s:='';
                      finally
                        if ResultSet<>nil then
                          mysql_free_result(ResultSet);
                      end;
                    end;
                  if s='' then // если номер не найден
                    begin
                      // поиск его в таблице _inform_.firma_po
                      q:='SELECT rowid FROM _inform_.firma_po WHERE broj_tel='+#39+sPhoneNumString+#39+';';
                      LogThis('QUERY: '+q);
                      // запрос из таблицы ...
                      if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
                        begin
                          ResultSet:=mysql_store_result(MySQLConnectionHandler);
                          try
                            if ResultSet=nil then
                              begin
                                LogThis('ERROR: Выборка пуста!');
                                LogThis('MySQL_Error: '+string(mysql_error(MySQLConnectionHandler)));
                                LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
                              end;
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              s:=string(ResultRow[0])
                            else
                              s:='';
                          finally
                            if ResultSet<>nil then
                              mysql_free_result(ResultSet);
                          end;
                        end;
                      // и добавление его в таблицу
                      LogThis('Добавление записи в таблицу PHONEREFS...');
                      j:=StrToIntDef(s, -1);
                      if j=-1 then
                        q:='INSERT INTO phonerefs (id, phone, firma_porowid) VALUES (NULL,'+#39+sPhoneString+#39+',NULL)'
                      else
                        q:='INSERT INTO phonerefs (id, phone, firma_porowid) VALUES (NULL,'+#39+sPhoneString+#39','+#39+IntToStr(j)+#39+')';
                      LogThis('QUERY: '+q);
                      // запрос из таблицы ...
                      if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
                        begin
                          LogThis('Ошибка!');
                          // if bExitOnError then Exit;
                        end
                      else
                        LogThis('Ok');
                    end;
                end;
            end;
        end;
    end;
end;

procedure TMainForm.ACTION_EditCutExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).CutToClipboard;
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).CutToClipboard;
end;

procedure TMainForm.ACTION_EditSelectAllExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).SelectAll;
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).SelectAll;
end;

procedure TMainForm.ACTION_EditClearExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).ClearSelection;
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).ClearSelection;
end;

procedure TMainForm.ACTION_EditPasteExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).PasteFromClipboard;
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).PasteFromClipboard;
end;

procedure TMainForm.ACTION_EditCopyExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).CopyToClipboard;
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).CopyToClipboard;
end;

procedure TMainForm.PopupMenu1Popup(Sender: TObject);
begin
  if PopupMenu1.PopupComponent is TMemo then
    begin
      TMemo(PopupMenu1.PopupComponent).SetFocus;
      ACTION_EditCut.Enabled:=TMemo(PopupMenu1.PopupComponent).SelText<>'';
      ACTION_EditCopy.Enabled:=TMemo(PopupMenu1.PopupComponent).SelText<>'';
      ACTION_EditClear.Enabled:=TMemo(PopupMenu1.PopupComponent).SelText<>'';
    end;
  if PopupMenu1.PopupComponent is TEdit then
    begin
      TMemo(PopupMenu1.PopupComponent).SetFocus;
      ACTION_EditCut.Enabled:=TEdit(PopupMenu1.PopupComponent).SelText<>'';
      ACTION_EditCopy.Enabled:=TEdit(PopupMenu1.PopupComponent).SelText<>'';
      ACTION_EditClear.Enabled:=TEdit(PopupMenu1.PopupComponent).SelText<>'';
    end;
end;

procedure TMainForm.ACTION_EditHTML_BRExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).SelText:='<BR>';
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).SelText:='<BR>';
end;

procedure TMainForm.ACTION_EditHTML_HRExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).SelText:='<HR>';
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).SelText:='<HR>';
end;

procedure TMainForm.ACTION_EditHTML_BExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).SelText:='<B>'+TMemo(Screen.ActiveControl).SelText+'</B>';
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).SelText:='<B>'+TEdit(Screen.ActiveControl).SelText+'</B>';
end;

procedure TMainForm.ACTION_EditHTML_IExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).SelText:='<I>'+TMemo(Screen.ActiveControl).SelText+'</I>';
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).SelText:='<I>'+TEdit(Screen.ActiveControl).SelText+'</I>';
end;

procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);
var
  i: integer;
  s, s1: string;
begin
  (* процедура преобразования строки в список строк (используя заданный разделитель) *)
  Destination.Sorted:=False;
  Destination.Clear;
  s:=Source;
  while Length(s)>0 do
    begin
      i:=Pos(Limiter, s);
      if (i=0) then
        begin
          Destination.Add(s);
          Exit;
        end
      else
        begin
          s1:=Copy(s, 0, i-1);
          Destination.Add(s1);
          s1:=Copy(s, i+1, Length(s));
          s:=s1;
        end;
    end;
end;

procedure TMainForm.LogThis(a: string);
var
  tf: TextFile;
  s: string;
begin
  (* процедура записи указанной строки в лог (в файл и в комбобокс) *)
  // запись в комбобокс
  s:=FormatDateTime('dd.mm.yyyy hh:nn:ss', Now)+'    '+a;
  // запись в файл
  s:=FormatDateTime('dd.mm.yyyy hh:nn:ss', Now)+'  '+a;
  AssignFile(tf, LOGFileName);
  if (not FileExists(LOGFileName)) then
    Rewrite(tf)
  else
    Append(tf);
  Writeln(tf, s);
  Flush(tf);
  CloseFile(tf);
end;

procedure TMainForm.Maintenance_EraseAllOutdatedMeasures;
var
  q, s: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  (* процедура удаления всех мероприятий, устаревших на текущую дату *)
  Screen.Cursor:=crHourGlass;
  LogThis('Удаление мероприятий, устаревших на текущую дату');
  LogThis('Проверка синхронности дат на сервере и локальном компьютере');
  q:='SELECT DATE_FORMAT(CURRENT_DATE, "%d.%m.%Y");';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Не удалось получить текущую дату с сервера MySQL!');
            LogThis('MySQL_Error: '+mysql_error(MySQLConnectionHandler));
            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
            Screen.Cursor:=crDefault;
            MessageDlg('Не удалось получить текущую дату с сервера MySQL!', mtError, [mbYes, mbNo], 0);
            Exit;
          end;
        ResultRow:=mysql_fetch_row(ResultSet);
        s:=string(ResultRow[0]);
        LogThis('Текущая дата на сервере: '+s);
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  LogThis('Текущая дата на локальном компьютере: '+DateToStr(Date));
  if StrToDate(s)<>Date then
    begin
      LogThis('ERROR: Текущая дата на локальном компьютере и на сервере MySQL отличаются!');
      Screen.Cursor:=crDefault;
      MessageDlg('Текущая дата на локальном компьютере и на сервере MySQL отличаются! Срочно обратитесь к администратору сети!'+HR+RN+
          'Во избежание возможной фатальной ошибки, воспользуйтесь функцией удаления мероприятий, устаревших на указанную дату.', mtError, [mbYes], 0);
      Exit;
    end;
  LogThis('Получение количества попадающих под действие записей');
  q:='SELECT COUNT(*) FROM measures WHERE (LEFT(measurestopdatetime,10)<CURRENT_DATE);';
  LogThis('QUERY: '+q);
  if TryExecuteSelectQuery(q, MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            LogThis('ERROR: Выборка пуста!');
            LogThis('MySQL_Error: '+mysql_error(MySQLConnectionHandler));
            LogThis('MySQL_ErrorNumber: '+IntToStr(mysql_errno(MySQLConnectionHandler)));
            Screen.Cursor:=crDefault;
            MessageDlg('Не удалось получить количество записей из таблицы MEASURES, попадающих под удаление!', mtError, [mbYes, mbNo], 0);
            Exit;
          end;
        ResultRow:=mysql_fetch_row(ResultSet);
        s:=string(ResultRow[0]);
        LogThis('Найдено записей: '+s);
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if StrToIntDef(s, 0)=0 then
    begin
      LogThis('Записи о мероприятиях, устаревших на текущую дату ('+DateToStr(Date)+'), в базе данных отсутствуют');
      Screen.Cursor:=crDefault;
      MessageDlg('Записи о мероприятиях, устаревших на текущую дату ('+DateToStr(Date)+'), в базе данных отсутствуют.', mtInformation, [mbOk], 0);
      Exit;
    end;
  Screen.Cursor:=crDefault;
  if (MessageDlg('Вы хотите удалить все записи о мероприятиях (общим количеством '+s+'), закончившихся ранее текущей даты ('+DateToStr(Date)+')?', mtConfirmation, [mbYes, mbNo], 0)=mrYes) then
    begin
      Application.ProcessMessages;
      Screen.Cursor:=crHourGlass;
      LogThis('Сохранение записей в таблице ERASEDMEASURES...');
      q:='INSERT INTO erasedmeasures SELECT * FROM measures WHERE (LEFT(measurestopdatetime,10)<CURRENT_DATE);';
      LogThis('QUERY: '+q);
      if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
        begin
          LogThis('Ошибка!');
          if bExitOnError then
            begin
              Screen.Cursor:=crDefault;
              Exit;
            end;
        end
      else
        LogThis('Ok');
      LogThis('Удаление записей из таблицы MEASURES...');
      q:='DELETE FROM measures WHERE (LEFT(measurestopdatetime,10)<CURRENT_DATE);';
      LogThis('QUERY: '+q);
      if not TryExecuteUpdateQuery(q, MySQLConnectionHandler) then
        begin
          LogThis('Ошибка!');
          if bExitOnError then
            begin
              Screen.Cursor:=crDefault;
              Exit;
            end;
        end
      else
        LogThis('Ok');
    end;
  Screen.Cursor:=crDefault;
end;

procedure TMainForm.ACTION_AboutProgramExecute(Sender: TObject);
begin
  (* процедура отображения информационного окна "О программе" *)
  with TPopUpForm.Create(Self) do
    try
      LABEL_ApplicationTitle.Caption:=Application.Title;
      IMAGE_ApplicationIcon.Picture.Assign(Application.Icon);
      LABEL_ApplicationVersion.Caption:=Format('Версия %s билд %s', [gsFileVersionInfo1.ProductVersion, gsFileVersionInfo1.GetBuildOnly]);
      LABEL_ApplicationCopyright.Caption:=gsFileVersionInfo1.LegalCopyright;
      ShowModal;
    finally
      Free;
    end;
end;

procedure TMainForm.ACTION_QuitProgramExecute(Sender: TObject);
begin
  (* процедура выхода из программы *)
  Close;
end;

procedure TMainForm.ACTION_ContextHelpExecute(Sender: TObject);
begin
  (* процедура отображения справки по текущему активному элементу управления программы *)
  Application.HelpContext(ActiveControl.HelpContext);
end;

procedure TMainForm.ACTION_HelpContentExecute(Sender: TObject);
begin
  (* процедура отображения оглавления справки по программе *)
  Application.HelpContext(0);
end;

procedure TMainForm.ACTION_EditHTML_UExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).SelText:='<U>'+TMemo(Screen.ActiveControl).SelText+'</U>';
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).SelText:='<U>'+TEdit(Screen.ActiveControl).SelText+'</U>';
end;

procedure TMainForm.ACTION_EditHTML_FONTExecute(Sender: TObject);
begin
  if Screen.ActiveControl is TMemo then
    TMemo(Screen.ActiveControl).SelText:='<FONT COLOR="RED">'+TMemo(Screen.ActiveControl).SelText+'</FONT>';
  if Screen.ActiveControl is TEdit then
    TEdit(Screen.ActiveControl).SelText:='<FONT COLOR="RED">'+TEdit(Screen.ActiveControl).SelText+'</FONT>';
end;

initialization

OleInitialize(nil);

finalization

OleUninitialize;

end.

// 1. Запрос на нахождение изменившихся номеров телефонов
// SELECT a.id, a.phone, a.phonedigits FROM rne.phonerefs a LEFT JOIN _inform_.firma_po b ON (a.firma_porowid=b.rowid) WHERE (a.phonedigits=b.broj_tel);
// 2. Запросы на нахождение элементов таблиц, в которых встречаются изменённые номера телефонов
// SELECT a.id FROM rne.measures a WHERE a.measureinfo LIKE '%220-15-41%';
// SELECT a.id FROM rne.organizationnames a WHERE a.organizationphones LIKE '%220-15-41%';
// SELECT a.id FROM rne.organizationnames a WHERE a.organizationinfo LIKE '%220-15-41%';
// 3. Запросы на замену старого номера телефона на новый
// UPDATE rne.organizationnames SET organizationphones=REPLACE(rne.organizationnames.organizationphones,'228-72-96',CONCAT(LEFT('2222222',3),'-',LEFT(RIGHT('2222222',4),2),'-',RIGHT('2222222',2))) WHERE (rne.organizationnames.organizationphones LIKE (CONCAT('%','228-72-96','%')));
// UPDATE rne.organizationnames SET organizationinfo=REPLACE(rne.organizationnames.organizationinfo,'228-72-96',CONCAT(LEFT('2222222',3),'-',LEFT(RIGHT('2222222',4),2),'-',RIGHT('2222222',2))) WHERE (rne.organizationnames.organizationinfo LIKE (CONCAT('%','228-72-96','%')));
// UPDATE rne.measures SET measureinfo=REPLACE(rne.measures.measureinfo,'228-72-96',CONCAT(LEFT('2222222',3),'-',LEFT(RIGHT('2222222',4),2),'-',RIGHT('2222222',2))) WHERE (rne.measures.measureinfo LIKE (CONCAT('%','228-72-96','%')));
