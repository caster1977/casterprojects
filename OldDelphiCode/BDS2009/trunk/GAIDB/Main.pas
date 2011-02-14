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
  ComCtrls,
  StdCtrls,
  Buttons,
  ExtCtrls,
  AppEvnts,
  getFVI,
  ToolWin,
  ActnMan,
  ActnCtrls,
  XPStyleActnCtrls,
  Menus,
  ImgList,
  ShellAPI,
  mysql,
  IniFiles,
  Spin,
  commctrl,
  XPMan;

type
  TLVGROUP= record
    cbSize: UINT;
    mask: UINT;
    pszHeader: LPWSTR;
    cchHeader: Integer;
    pszFooter: LPWSTR;
    cchFooter: Integer;
    iGroupId: Integer;
    stateMask: UINT;
    state: UINT;
    uAlign: UINT;
  end;

  tagLVITEMA=packed record
    mask: UINT;
    iItem: Integer;
    iSubItem: Integer;
    state: UINT;
    stateMask: UINT;
    pszText: PAnsiChar;
    cchTextMax: Integer;
    iImage: Integer;
    lParam: lParam;
    iIndent: Integer;
    iGroupId: Integer;
    cColumns: UINT;
    puColumns: PUINT;
  end;

  TLVITEMA=tagLVITEMA;

const
  LVM_ENABLEGROUPVIEW=LVM_FIRST+157;
  LVM_MOVEITEMTOGROUP=LVM_FIRST+154;
  LVM_INSERTGROUP=LVM_FIRST+145;
  LVM_REMOVEALLGROUPS=LVM_FIRST+160;

  LVIF_GROUPID=$0100;

  LVGF_HEADER=$00000001;
  LVGF_ALIGN=$00000008;
  LVGF_GROUPID=$00000010;

  LVGA_HEADER_LEFT=$00000001;
  LVGA_HEADER_CENTER=$00000002;
  LVGA_HEADER_RIGHT=$00000004;

const
  // опеределения для панели статуса
  EM_REDO=(WM_USER+84);
  EM_CANREDO=(WM_USER+85);
  STATUSBAR_ITEMS_COUNT_PANEL_NUMBER: integer=2;
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=3;
  DEFAULT_MAINFORMWIDTH=1024;
  DEFAULT_MAINFORMHEIGHT=768;
  EXISTINGICON_ID=0;
  DELETEDICON_ID=1;
  UNKNOWNICON_ID=2;

type
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL);
  // типы сообщений передаваемых в лог
  TParaAttr= record
    Alignment: TAlignment;
    FirstIndent: integer;
    LeftIndent: integer;
    Numbering: TNumberingStyle;
    RightIndent: integer;
    TabCount: integer;
  end;

  TTextAttr= record
    Charset: TFontCharset;
    Color: TColor;
    name: TFontName;
    Pitch: TFontPitch;
    Size: integer;
    Style: TFontStyles;
    Height: integer;
  end;

  TUserRec= record
    sID: string;
    sLogin: string;
    sPassword: string;
    sFullName: string;
    bIsAdmin: boolean;
    bDBEdition: boolean;
    bDBBackup: boolean;
    bDBCleaning: boolean;
    bDBDefragmentation: boolean;
    bDBMaintenance: boolean;
    bDBUsersEdition: boolean;
  end;

  TConfigurationRec= record
    bNoLogo: boolean;
    bShowID: boolean;
    bImmediatelyQuit: boolean;
    bLogged: boolean;
    bStoreLastLogin: boolean;
    sLastLogin: string;
    bStoreLastPassword: boolean;
    sLastPassword: string;
    bAutoLogon: boolean;
    bNoToolBar: boolean;
    bNoStatusBar: boolean;
    bShowFullSearchBar: boolean;
    iCustomMainFormWidth: integer;
    iCustomMainFormHeight: integer;
    bSaveSize: boolean;
    MainFormRect: TRect;
    bSetCustomMainFormSizes: boolean;
    bFullScreen: boolean;
    sMySQLHost: string;
    iMySQLPort: integer;
    iMySQLTimeout: integer;
    bMySQLCompress: boolean;
    sMySQLDatabase: string;
    sMySQLUser: string;
    sMySQLPassword: string;
    sCustomHelpFile: string;
    sCustomLogClientFile: string;
  end;

  // TMyNode=record
  // bSearched: boolean;
  // lwMySQLTableID: LongWord;
  // end;
  THackControl= class(TControl);
    TMainForm= class(TForm)MainMenu1: TMainMenu;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    gsFileVersionInfo1: TgsFileVersionInfo;
    ColorDialog1: TColorDialog;
    ApplicationEvents1: TApplicationEvents;
    pnlConnectedMode: TPanel;
    pnlSearch: TPanel;
    lblSearch: TLabel;
    edbxSearch: TEdit;
    btbtnMore: TBitBtn;
    btbtnSearch: TBitBtn;
    chkbxHideErased: TCheckBox;
    Action_Quit: TAction;
    ImageList1: TImageList;
    ImageList3: TImageList;
    miFile: TMenuItem;
    miQuit: TMenuItem;
    N2: TMenuItem;
    Action_Configuration: TAction;
    StatusBar1: TStatusBar;
    N1: TMenuItem;
    pmChangeTextColor: TPopupMenu;
    Action_About: TAction;
    Action_HelpContent: TAction;
    ProgressBar1: TProgressBar;
    ImageList2: TImageList;
    miHelp: TMenuItem;
    miAbout: TMenuItem;
    N5: TMenuItem;
    miHelpContent: TMenuItem;
    miView: TMenuItem;
    N3: TMenuItem;
    miToolbar: TMenuItem;
    miStatusbar: TMenuItem;
    N4: TMenuItem;
    Action_DB_Users: TAction;
    Action_DB_Statistic: TAction;
    N6: TMenuItem;
    N7: TMenuItem;
    Action_DB_Defragmentation: TAction;
    Action_DB_Cleaning: TAction;
    Action_DB_Maintenance: TAction;
    Action_DB_Backup: TAction;
    miActions: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    Action_DB_Connection: TAction;
    Action_DB_Disconnection: TAction;
    Action_DB_AddAuto: TAction;
    Action_DB_AddOwner: TAction;
    Action_DB_DeleteNode: TAction;
    Action_DB_RefreshList: TAction;
    Action_DB_RecoverNode: TAction;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    Image1: TImage;
    ImageList5: TImageList;
    pnlData: TPanel;
    Splitter1: TSplitter;
    pnlSearchResults: TPanel;
    pnlSearchResultsCreationModification: TPanel;
    pnlID: TPanel;
    lblIDCaption: TLabel;
    lblID: TLabel;
    pnlCreationModification: TPanel;
    lblCreation: TLabel;
    lblModification: TLabel;
    lblCreationCaption: TLabel;
    lblModificationCaption: TLabel;
    PageControl1: TPageControl;
    tsOwner: TTabSheet;
    tsAuto: TTabSheet;
    pnlOwnerGeneralInfo: TPanel;
    lblOwnerType: TLabel;
    lblOwnerSurname: TLabel;
    edbxOwnerSurname: TEdit;
    lblOwnerGivenNames: TLabel;
    edbxOwnerGivenNames: TEdit;
    lblOwnerTown: TLabel;
    cmbbxOwnerTown: TComboBox;
    cmbbxOwnerStreet: TComboBox;
    lblOwnerStreet: TLabel;
    lblOwnerHouse: TLabel;
    edbxOwnerHouse: TEdit;
    lblOwnerSubHouse: TLabel;
    edbxOwnerSubhouse: TEdit;
    lblOwnerFlat: TLabel;
    edbxOwnerFlat: TEdit;
    lblOwnerNationality: TLabel;
    edbxOwnerNationality: TEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Bevel3: TBevel;
    lblOwnerOtherInfo: TLabel;
    lblOwnerOtherInfoFull: TLabel;
    reOwnerOtherInfo: TRichEdit;
    pnlAutoGeneralInfo: TPanel;
    pnl7: TPanel;
    lblAutoRegistrationSign: TLabel;
    edbxAutoRegistrationSign: TEdit;
    Panel7: TPanel;
    Panel8: TPanel;
    Bevel2: TBevel;
    lblAutoComments: TLabel;
    meAutoComments: TMemo;
    lblAutoMarkModel: TLabel;
    cmbbxAutoMarkModel: TComboBox;
    lblAutoColor: TLabel;
    cmbbxAutoColor: TComboBox;
    lblAutoNumberOfCarriage: TLabel;
    lblAutoType: TLabel;
    cmbbxAutoType: TComboBox;
    edbxAutoMarkModel: TEdit;
    edbxAutoColor: TEdit;
    edbxAutoNumberOfCarriage: TEdit;
    edbxAutoType: TEdit;
    Panel5: TPanel;
    reAutoOtherInfo: TRichEdit;
    pnlEdit: TPanel;
    Action_PostMessage: TAction;
    Action_ViewMessages: TAction;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    edbxOwnerType: TEdit;
    edbxOwnerTown: TEdit;
    edbxOwnerStreet: TEdit;
    edbxOwnerAuthority: TEdit;
    ImageListForRichEditMenu: TImageList;
    ActionManager2: TActionManager;
    Action_RichEditCut: TAction;
    Action_RichEditUndo: TAction;
    Action_RichEditCopy: TAction;
    Action_RichEditPaste: TAction;
    Action_RichEditSelectAll: TAction;
    Action_RichEditErase: TAction;
    Action_RichEditRedo: TAction;
    Action_RichEditBold: TAction;
    Action_RichEditItalic: TAction;
    Action_RichEditUnderline: TAction;
    Action_RichEditLeftAlign: TAction;
    Action_RichEditCenterAlign: TAction;
    Action_RichEditRightAlign: TAction;
    Action_RichEditBullets: TAction;
    Action_RichEditEnlargeFont: TAction;
    Action_RichEditDecreaseFont: TAction;
    Action_RichEditFormatBySample: TAction;
    Action_RichEditDefaultFormat: TAction;
    Action_RichEditSetTextColor: TAction;
    tlbMsrRichEdit: TToolBar;
    ToolButton19: TToolButton;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton27: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    PopupMenu1: TPopupMenu;
    pmRichEdit: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    miCut: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    N25: TMenuItem;
    XPManifest1: TXPManifest;
    tsClear: TTabSheet;
    pnlOrgLV: TPanel;
    lvOwners: TListView;
    pnlMsrLV: TPanel;
    lvAutos: TListView;
    N26: TMenuItem;
    miGoToSearchString: TMenuItem;
    Splitter2: TSplitter;
    miGoToOrgPanel: TMenuItem;
    miGoToMsrPanel: TMenuItem;
    miGoToDataPanel: TMenuItem;
    Panel1: TPanel;
    Bevel5: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Panel4: TPanel;
    Bevel6: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    Panel9: TPanel;
    Bevel7: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Panel11: TPanel;
    Bevel9: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    Panel10: TPanel;
    Bevel8: TBevel;
    lblAutoOtherInfo: TLabel;
    lblAutoOtherInfoFull: TLabel;
    btnSave: TButton;
    btnClear: TButton;
    btnClone: TButton;
    btnCancel: TButton;
    lblOwnerCodeOfIssuingState: TLabel;
    edbxOwnerCodeOfIssuingState: TEdit;
    lblOwnerPassportNumber: TLabel;
    edbxOwnerPassportNumber: TEdit;
    lblOwnerSubname: TLabel;
    edbxOwnerSubname: TEdit;
    lblOwnerDateOfBirth: TLabel;
    dtpOwnerDateOfBirth: TDateTimePicker;
    lblOwnerPrivateNumber: TLabel;
    edbxOwnerPrivateNumber: TEdit;
    lblOwnerSex: TLabel;
    cmbbxOwnerSex: TComboBox;
    lblOwnerPlaceOfBirth: TLabel;
    edbxOwnerPlaceOfBirth: TEdit;
    lblOwnerDateOfIssue: TLabel;
    dtpOwnerDateOfIssue: TDateTimePicker;
    lblOwnerDateOfExpiry: TLabel;
    dtpOwnerDateOfExpiry: TDateTimePicker;
    lblOwnerAuthority: TLabel;
    cmbbxOwnerAuthority: TComboBox;
    cmbbxOwnerType: TComboBox;
    cmbbxOwnerCodeOfIssuingState: TComboBox;
    cmbbxOwnerNationality: TComboBox;
    edbxOwnerSex: TEdit;
    edbxAutoNumber: TEdit;
    lblAutoNumber: TLabel;
    lblAutoDateOfIssue: TLabel;
    dtpAutoDateOfIssue: TDateTimePicker;
    lblAutoYearOfEdition: TLabel;
    cmbbxAutoYearOfEdition: TComboBox;
    edbxAutoYearOfEdition: TEdit;
    edbxAutoMaximumMass: TEdit;
    lblAutoMaximumMass: TLabel;
    lblAutoMassWithoutLoad: TLabel;
    edbxAutoMassWithoutLoad: TEdit;
    edbxAutoDateOfIssue: TEdit;
    edbxOwnerDateOfBirth: TEdit;
    edbxOwnerDateOfIssue: TEdit;
    edbxOwnerDateOfExpiry: TEdit;
    procedure edbxOwnerSubnameExit(Sender: TObject);
    procedure edbxAutoNumberOfCarriageExit(Sender: TObject);
    procedure edbxAutoNumberExit(Sender: TObject);
    procedure edbxAutoMaximumMassExit(Sender: TObject);
    procedure edbxAutoMassWithoutLoadExit(Sender: TObject);
    procedure cmbbxOwnerTypeDropDown(Sender: TObject);
    procedure cmbbxOwnerTypeExit(Sender: TObject);
    procedure cmbbxOwnerCodeOfIssuingStateDropDown(Sender: TObject);
    procedure cmbbxOwnerCodeOfIssuingStateExit(Sender: TObject);
    procedure edbxOwnerPassportNumberExit(Sender: TObject);
    procedure edbxOwnerPrivateNumberExit(Sender: TObject);
    procedure edbxOwnerPlaceOfBirthExit(Sender: TObject);
    procedure cmbbxOwnerNationalityDropDown(Sender: TObject);
    procedure cmbbxOwnerNationalityExit(Sender: TObject);
    procedure cmbbxOwnerAuthorityDropDown(Sender: TObject);
    procedure cmbbxOwnerAuthorityExit(Sender: TObject);
    procedure lvOwnersResize(Sender: TObject);
    procedure btnCloneClick(Sender: TObject);
    procedure lvOwnersCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Action_DB_DefragmentationExecute(Sender: TObject);
    procedure Action_DB_CleaningExecute(Sender: TObject);
    procedure Action_DB_BackupExecute(Sender: TObject);
    procedure Action_DB_MaintenanceExecute(Sender: TObject);
    procedure Action_DB_RefreshListExecute(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure meAutoCommentsExit(Sender: TObject);
    procedure cmbbxAutoTypeExit(Sender: TObject);
    procedure cmbbxAutoColorExit(Sender: TObject);
    procedure cmbbxAutoMarkModelExit(Sender: TObject);
    procedure edbxAutoRegistrationSignExit(Sender: TObject);
    procedure cmbbxOwnerTownExit(Sender: TObject);
    procedure edbxOwnerFlatExit(Sender: TObject);
    procedure edbxOwnerSubhouseExit(Sender: TObject);
    procedure edbxOwnerHouseExit(Sender: TObject);
    procedure cmbbxOwnerStreetExit(Sender: TObject);
    procedure edbxOwnerGivenNamesExit(Sender: TObject);
    procedure edbxOwnerSurnameExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure Action_DB_AddAutoExecute(Sender: TObject);
    procedure Action_DB_AddOwnerExecute(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure lvAutosCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure miGoToDataPanelClick(Sender: TObject);
    procedure miGoToMsrPanelClick(Sender: TObject);
    procedure miGoToOrgPanelClick(Sender: TObject);
    procedure lvOwnersEnter(Sender: TObject);
    procedure lvAutosEnter(Sender: TObject);
    procedure lvAutosSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure Action_DB_RecoverNodeExecute(Sender: TObject);
    procedure Action_DB_DeleteNodeExecute(Sender: TObject);
    procedure miGoToSearchStringClick(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure lvOwnersSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvOwnersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlSearchExit(Sender: TObject);
    procedure pnlSearchEnter(Sender: TObject);
    procedure btbtnSearchClick(Sender: TObject);
    procedure pmChangeTextColorPopup(Sender: TObject);
    procedure reAutoOtherInfoContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure reOwnerOtherInfoContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure reOwnerOtherInfoSelectionChange(Sender: TObject);
    procedure reOwnerOtherInfoEnter(Sender: TObject);
    procedure reAutoOtherInfoEnter(Sender: TObject);
    procedure Action_RichEditSetTextColorExecute(Sender: TObject);
    procedure Action_RichEditDefaultFormatExecute(Sender: TObject);
    procedure Action_RichEditFormatBySampleExecute(Sender: TObject);
    procedure Action_RichEditDecreaseFontExecute(Sender: TObject);
    procedure Action_RichEditEnlargeFontExecute(Sender: TObject);
    procedure Action_RichEditBulletsExecute(Sender: TObject);
    procedure Action_RichEditRightAlignExecute(Sender: TObject);
    procedure Action_RichEditCenterAlignExecute(Sender: TObject);
    procedure Action_RichEditLeftAlignExecute(Sender: TObject);
    procedure Action_RichEditUnderlineExecute(Sender: TObject);
    procedure Action_RichEditItalicExecute(Sender: TObject);
    procedure Action_RichEditBoldExecute(Sender: TObject);
    procedure Action_RichEditRedoExecute(Sender: TObject);
    procedure Action_RichEditEraseExecute(Sender: TObject);
    procedure Action_RichEditPasteExecute(Sender: TObject);
    procedure Action_RichEditCopyExecute(Sender: TObject);
    procedure Action_RichEditUndoExecute(Sender: TObject);
    procedure Action_RichEditCutExecute(Sender: TObject);
    procedure Action_RichEditSelectAllExecute(Sender: TObject);
    procedure cmbbxAutoTypeDropDown(Sender: TObject);
    procedure cmbbxAutoColorDropDown(Sender: TObject);
    procedure cmbbxAutoMarkModelDropDown(Sender: TObject);
    procedure cmbbxOwnerStreetDropDown(Sender: TObject);
    procedure cmbbxOwnerTownDropDown(Sender: TObject);
    procedure Action_PostMessageExecute(Sender: TObject);
    procedure Action_ViewMessagesExecute(Sender: TObject);
    procedure btnMsrPhonesClick(Sender: TObject);
    procedure btnOwnerPhonesClick(Sender: TObject);
    procedure Action_DB_StatisticExecute(Sender: TObject);
    procedure Action_DB_DisconnectionExecute(Sender: TObject);
    procedure Action_DB_ConnectionExecute(Sender: TObject);
    procedure chkbxStartDateClick(Sender: TObject);
    procedure chkbxStopDateClick(Sender: TObject);
    procedure btbtnMoreClick(Sender: TObject);
    procedure Action_DB_UsersExecute(Sender: TObject);
    procedure miStatusbarClick(Sender: TObject);
    procedure miToolbarClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure Action_HelpContentExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
  private
    SessionLogEventCount: cardinal;
    ParaAttr: TParaAttr;
    TextAttr: TTextAttr;
    blvOwnerRedrawNow: boolean;
    blvAutoRedrawNow: boolean;
    iLastSelectedOrgIndex: integer;
    procedure SaveConfigIni;
    procedure LoadConfigIni;
    procedure UpdateSearchBar;
    procedure SetDefaultSettings(reA: TRichEdit);
    procedure Update_RichEditTools;
    procedure Refresh_NodeState(bFullRefresh: boolean);
    procedure Update_Actions;
    procedure SaveModifyOwner;
    procedure SaveModifyAuto;
  public
    clInfo: TColor;
    bParamShowID: boolean;
    bParamNoLogo: boolean;
    CurrentUser: TUserRec;
    MySQLConnectionHandler: PMYSQL;
    Configuration: TConfigurationRec;
    bAddingOwnerNow: boolean;
    bAddingAutoNow: boolean;
    procedure SetReady;
    procedure SetBusy;
    procedure LogThis(a: string; MessageType: TLogMessagesType);
    function ValidateString(s: string): string;
  end;

procedure DivideNumberAndSymbolParts(const Source: string; var Num: integer; var Sym: string);
function NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): AnsiString;
procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);
procedure HTMLtoRTF(html: string; var rtf: TRichedit);

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  About,
  Login,
  Options,
  Users,
  CreateViewPost,
  ViewPostList,
  Registry,
  Grids,
  Statistic; // , RichEditTools

procedure DivideNumberAndSymbolParts(const Source: string; var Num: integer; var Sym: string);
var
  i, j: integer;
  s: string;
begin
  s:='';
  // начиная с первого символа строки-источника находим позицию, с которой строка перестаёт состоять из цифр
  for j:=1 to Length(Source) do
    begin
      s:=s+Source[j];
      i:=StrToIntDef(s, -1);
      if i=-1 then
        Break; // останов цикла при "натыкании" на символ, который уже невозможно преобразовать в число
    end;
  Num:=StrToIntDef(Copy(Source, 0, j-1), 0);
  Sym:=Copy(Source, j, Length(Source)-j+1);
end;

function NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): AnsiString;
var
  z: PAnsiChar;
begin
  NormalizeStringForQuery:='';
  if ((ReturnNull)and(Trim(Source)='')) then
    NormalizeStringForQuery:='NULL'
  else
    begin
      z:=GetMemory(Length(PAnsiChar(Source))*2+1);
      try
        mysql_escape_string(z, PAnsiChar(Source), Length(PAnsiChar(Source)));
        if AddCommas then
          NormalizeStringForQuery:='"'+StrPas(z)+'"'
        else
          NormalizeStringForQuery:=StrPas(z);
      finally
        if z<>nil then
          FreeMemory(z);
      end;
    end;
end;

procedure HTMLtoRTF(html: string; var rtf: TRichedit);
var
  i, row: Integer; // dummy,
  cfont: TFont; { Standard sschrift }
  Tag, tagparams: string;
  params: TStringList;

  function GetTag(s: string; var i: Integer; var Tag, tagparams: string): Boolean;
  var
    a_tag: Boolean;
  begin
    GetTag:=False;
    Tag:='';
    tagparams:='';
    a_tag:=False;

    while i<=Length(s) do
      begin
        Inc(i);
        // es wird nochein tag geoffnet --> das erste war kein tag;
        if s[i]='<' then
          begin
            GetTag:=False;
            Exit;
          end;
        if s[i]='>' then
          begin
            GetTag:=True;
            Exit;
          end;
        if not a_tag then
          begin
            if s[i]=' ' then
              begin
                if Tag<>'' then
                  a_tag:=True;
              end
            else
              Tag:=Tag+s[i];
          end
        else
          tagparams:=tagparams+s[i];
      end;
  end;

  procedure GetTagParams(tagparams: string; var params: TStringList);
  var
    i: Integer;
    s: ansistring;
    gleich: Boolean;

    // kontrolliert ob nach dem zeichen bis zum nachsten zeichen ausser
    // leerzeichen ein Ist-Gleich-Zeichen kommt
    function notGleich(s: ansistring; i: Integer): Boolean;
    begin
      notGleich:=True;
      while i<=Length(s) do
        begin
          Inc(i);
          if s[i]='=' then
            begin
              notGleich:=False;
              Exit;
            end
          else
            if s[i]<>' ' then
              Exit;
        end;
    end;

  begin
    gleich:=False;
    Params.Clear;
    s:='';
    for i:=1 to Length(tagparams) do
      begin
        if (tagparams[i]<>' ') then
          begin
            if tagparams[i]<>'=' then
              gleich:=False;
            if (tagparams[i]<>'''')and(tagparams[i]<>'"') then
              s:=s+tagparams[i]
          end
        else
          begin
            if (notGleich(tagparams, i))and(not Gleich) then
              begin
                params.Add(s);
                s:='';
              end
            else
              Gleich:=True;
          end;
      end;
    params.Add(s);
  end;

  function HtmlToColor(Color: string): TColor;
  begin
    Result:=StringToColor('$'+Copy(Color, 6, 2)+Copy(Color, 4, 2)+Copy(Color, 2, 2));
  end;

  procedure TransformSpecialChars(var s: string; i: Integer);
  var
    c: string;
    z, z2: Byte;
    i2: Integer;
  const
    nchars=9;
    chars: array [1..nchars, 1..2] of string=(('O', 'O'), ('o', 'o'), ('A', 'A'), ('a', 'a'), ('U', 'U'), ('u', 'u'), ('?', '?'), ('<', '<'), ('>', '>'));
  begin
    // Maximal die nachsten 7 zeichen auf sonderzeichen uberprufen
    c:='';
    i2:=i;
    for z:=1 to 7 do
      begin
        c:=c+s[i2];
        for z2:=1 to nchars do
          begin
            if chars[z2, 1]=c then
              begin
                Delete(s, i, Length(c));
                Insert(chars[z2, 2], s, i);
                Exit;
              end;
          end;
        Inc(i2);
      end;
  end;

// HtmlTag Schriftgro?e in pdf gro?e umwandeln
  function CalculateRTFSize(pt: Integer): Integer;
  begin
    case pt of
      1:
        Result:=6;
      2:
        Result:=9;
      3:
        Result:=12;
      4:
        Result:=15;
      5:
        Result:=18;
      6:
        Result:=22;
    else
      Result:=30;
    end;
  end;

// Die Font-Stack Funktionen
type
  fontstack= record
    Font: array [1..100] of tfont;
    Pos: Byte;
  end;

  procedure CreateFontStack(var s: fontstack);
  begin
    s.Pos:=0;
  end;

  procedure PushFontStack(var s: Fontstack; fnt: TFont);
  begin
    Inc(s.Pos);
    s.Font[s.Pos]:=TFont.Create;
    s.Font[s.Pos].Assign(fnt);
  end;

  procedure PopFontStack(var s: Fontstack; var fnt: TFont);
  begin
    if (s.Font[s.Pos]<>nil)and(s.Pos>0) then
      begin
        fnt.Assign(s.Font[s.Pos]);
        // vom stack nehmen
        s.Font[s.Pos].Free;
        Dec(s.Pos);
      end;
  end;

  procedure FreeFontStack(var s: Fontstack);
  begin
    while s.Pos>0 do
      begin
        s.Font[s.Pos].Free;
        Dec(s.Pos);
      end;
  end;

var
  fo_cnt: array [1..1000] of tfont;
  fo_liste: array [1..1000] of Boolean;
  fo_pos: TStringList;
  fo_stk: FontStack;
  wordwrap, liste: Boolean;
begin
  CreateFontStack(fo_Stk);

  fo_Pos:=TStringList.Create;

  rtf.Lines.BeginUpdate;
  rtf.Lines.Clear;
  // Das wordwrap vom richedit merken
  wordwrap:=rtf.wordwrap;
  rtf.WordWrap:=False;

  // erste Zeile hinzufugen
  rtf.Lines.Add('');
  Params:=TStringList.Create;
  cfont:=TFont.Create;
  cfont.Assign(rtf.Font);

  i:=1;
  row:=0;
  Liste:=False;
  // Den eigentlichen Text holen und die Formatiorung merken
  rtf.selstart:=0;
  if Length(html)=0 then
    Exit;
  repeat
    if html[i]='<' then
      begin
        // dummy:=i;
        GetTag(html, i, Tag, tagparams);
        GetTagParams(tagparams, params);

        // Das Font-Tag
        if Uppercase(Tag)='FONT' then
          begin
            // Schrift auf fontstack sichern
            pushFontstack(fo_stk, cfont);
            if params.Values['size']<>'' then
              cfont.Size:=CalculateRTFSize(StrToInt(params.Values['size']));

            if params.Values['color']<>'' then
              cfont.Color:=htmltocolor(params.Values['color']);
          end
        else
          if Uppercase(Tag)='/FONT' then
            popFontstack(fo_stk, cfont)
          else // Die H-Tags-Uberschriften
            if Uppercase(Tag)='H1' then
              begin
                // Schrift auf fontstack sichern
                pushFontstack(fo_stk, cfont);
                cfont.Size:=6;
              end
            else
              if Uppercase(Tag)='/H1' then
                popFontstack(fo_stk, cfont)
              else // Die H-Tags-Uberschriften
                if Uppercase(Tag)='H2' then
                  begin
                    // Schrift auf fontstack sichern
                    pushFontstack(fo_stk, cfont);
                    cfont.Size:=9;
                  end
                else
                  if Uppercase(Tag)='/H2' then
                    popFontstack(fo_stk, cfont)
                  else // Die H-Tags-Uberschriften
                    if Uppercase(Tag)='H3' then
                      begin
                        // Schrift auf fontstack sichern
                        pushFontstack(fo_stk, cfont);
                        cfont.Size:=12;
                      end
                    else
                      if Uppercase(Tag)='/H3' then
                        popFontstack(fo_stk, cfont)
                      else // Die H-Tags-Uberschriften
                        if Uppercase(Tag)='H4' then
                          begin
                            // Schrift auf fontstack sichern
                            pushFontstack(fo_stk, cfont);
                            cfont.Size:=15;
                          end
                        else
                          if Uppercase(Tag)='/H4' then
                            popFontstack(fo_stk, cfont)
                          else // Die H-Tags-Uberschriften
                            if Uppercase(Tag)='H5' then
                              begin
                                // Schrift auf fontstack sichern
                                pushFontstack(fo_stk, cfont);
                                cfont.Size:=18;
                              end
                            else
                              if Uppercase(Tag)='/H5' then
                                popFontstack(fo_stk, cfont)
                              else // Die H-Tags-Uberschriften
                                if Uppercase(Tag)='H6' then
                                  begin
                                    // Schrift auf fontstack sichern
                                    pushFontstack(fo_stk, cfont);
                                    cfont.Size:=22;
                                  end
                                else
                                  if Uppercase(Tag)='/H6' then
                                    popFontstack(fo_stk, cfont)
                                  else // Die H-Tags-Uberschriften
                                    if Uppercase(Tag)='H7' then
                                      begin
                                        // Schrift auf fontstack sichern
                                        pushFontstack(fo_stk, cfont);
                                        cfont.Size:=27;
                                      end
                                    else
                                      if Uppercase(Tag)='/H7' then
                                        popFontstack(fo_stk, cfont)
                                      else // Bold-Tag
                                        if Uppercase(Tag)='B' then
                                          cfont.Style:=cfont.Style+[fsbold]
                                        else
                                          if Uppercase(Tag)='/B' then
                                            cfont.Style:=cfont.Style-[fsbold]
                                          else // Italic-Tag
                                            if Uppercase(Tag)='I' then
                                              cfont.Style:=cfont.Style+[fsitalic]
                                            else
                                              if Uppercase(Tag)='/I' then
                                                cfont.Style:=cfont.Style-[fsitalic]
                                              else // underline-Tag
                                                if Uppercase(Tag)='U' then
                                                  cfont.Style:=cfont.Style+[fsunderline]
                                                else
                                                  if Uppercase(Tag)='/U' then
                                                    cfont.Style:=cfont.Style-[fsunderline]
                                                  else // underline-Tag
                                                    if Uppercase(Tag)='UL' then
                                                      liste:=True
                                                    else
                                                      if Uppercase(Tag)='/UL' then
                                                        begin
                                                          liste:=False;
                                                          rtf.Lines.Add('');
                                                          Inc(row);
                                                          rtf.Lines.Add('');
                                                          Inc(row);
                                                        end
                                                      else // BR - Breakrow tag
                                                        if (Uppercase(Tag)='BR')or(Uppercase(Tag)='LI') then
                                                          begin
                                                            rtf.Lines.Add('');
                                                            Inc(row);
                                                          end;
        // unbekanntes tag als text ausgeben
        // else rtf.Lines[row]:=RTF.lines[row]+'<'+tag+' '+tagparams+'>';
        fo_pos.Add(IntToStr(rtf.selstart));
        fo_cnt[fo_pos.Count]:=TFont.Create;
        fo_cnt[fo_pos.Count].Assign(cfont);
        fo_liste[fo_pos.Count]:=liste;
      end
    else
      begin
        // Spezialzeichen ubersetzen
        if html[i]='&' then
          Transformspecialchars(html, i);
        if (Ord(html[i])<>13)and(Ord(html[i])<>10) then
          rtf.Lines[row]:=RTF.Lines[row]+html[i];
      end;
    Inc(i);
  until i>=Length(html);
  // dummy eintragen
  fo_pos.Add('999999');
  // Den fertigen Text formatieren
  for i:=0 to fo_pos.Count-2 do
    begin
      rtf.SelStart:=StrToInt(fo_pos[i]);
      rtf.SelLength:=StrToInt(fo_pos[i+1])-rtf.SelStart;
      rtf.SelAttributes.Style:=fo_cnt[i+1].Style;
      rtf.SelAttributes.Size:=fo_cnt[i+1].Size;
      rtf.SelAttributes.Color:=fo_cnt[i+1].Color;
      // die font wieder freigeben;
      fo_cnt[i+1].Free;
    end;
  // die Paragraphen also Listen setzen
  i:=0;
  while i<=fo_pos.Count-2 do
    begin
      if fo_liste[i+1] then
        begin
          rtf.SelStart:=StrToInt(fo_pos[i+1]);
          while fo_liste[i+1] do
            Inc(i);
          rtf.SelLength:=StrToInt(fo_pos[i-1])-rtf.SelStart;
          rtf.Paragraph.Numbering:=nsBullet;
        end;
      Inc(i);
    end;
  rtf.Lines.EndUpdate;
  Params.Free;
  cfont.Free;
  rtf.WordWrap:=wordwrap;
  FreeFontStack(fo_stk);
end;

procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);
var
  i: integer;
  s, s1: string;
begin
  s:=Source;
  if Destination=nil then
    Destination:=TStringList.Create
  else
    Destination.Clear;
  Destination.Sorted:=False;
  while Length(s)>0 do
    begin
      i:=Pos(Limiter, s);
      if i=0 then
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

function TMainForm.ValidateString(s: string): string;
var
  new_s: string;
  i, j: integer;
begin
  (* функция "подведения" заданной строки под стандартный вид базы *)
  // замена ' на \'
  new_s:=StringReplace(s, #39, '"', [rfReplaceAll]);
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

procedure TMainForm.LogThis(a: string; MessageType: TLogMessagesType);
var
  s, m, u: string;
  hGAIDBLogClient, hGAIDBLogClientListBox: HWND;
  aResult: LRESULT;
begin
  SessionLogEventCount:=SessionLogEventCount+1;
  case MessageType of
    lmtError:
      s:='ERROR';
    lmtWarning:
      s:='WARNING';
    lmtInfo:
      s:='INFO';
    lmtSQL:
      s:='SQL';
  end;
  if Configuration.bLogged then
    u:=CurrentUser.sLogin
  else
    u:='';
  m:=s+#09+ // тип сообщения
    StringReplace(FormatDateTime('dd.mm.yyyy hh:nn:ss', Now), ' ', #09, [rfReplaceAll])+#09+ // дата и время сообщения
    StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])+#09+ // порядковый номер сообщения
    u+#09+ // текущий залогированный пользователь
    a; // текст сообщения
  // проверка наличия окна лог-клиента и его перезапуск в случае отсутствия
  hGAIDBLogClient:=FindWindow('TMainForm', 'GAIDB Log Client'); // получение хэндла окна лог-клиента
  if (hGAIDBLogClient=0) then // если не было найдено окно лог-клиента
    begin
      Screen.Cursor:=crHourGlass;
      if ((Configuration.sCustomLogClientFile='')and FileExists(ExtractFilePath(ExpandFileName(Application.ExeName))+'GAIDBLogClient.exe')) then
        ShellExecute(Application.Handle, 'open', PChar(ExtractFilePath(ExpandFileName(Application.ExeName))+'GAIDBLogClient.exe'), nil, nil, SW_NORMAL); // попытаться его запустить вновь
      if ((Configuration.sCustomLogClientFile<>'')and FileExists(Configuration.sCustomLogClientFile)) then
        ShellExecute(Application.Handle, 'open', PChar(Configuration.sCustomLogClientFile), nil, nil, SW_NORMAL); // попытаться его запустить вновь
      while (hGAIDBLogClient=0) do
        begin
          Sleep(500); // заснуть на 500 милисекунд
          hGAIDBLogClient:=FindWindow('TMainForm', 'GAIDB Log Client'); // получение хэндла окна лог-клиента
        end;
      Screen.Cursor:=crDefault;
    end;
  hGAIDBLogClientListBox:=FindWindowEx(hGAIDBLogClient, HWND(nil), 'TListBox', ''); // получение хэндла окна лист-бокса лог-клиента
  if (hGAIDBLogClientListBox=0) then // если не было найдено окно лог-клиента
    MessageBox(Handle, PChar('Возникла ошибка при поиске окна списка лог-клиента!'+#13#10+'Обратитесь к администратору!'), PChar('Ошибка!'), MB_OK+MB_ICONERROR)
  else
    begin
      aResult:=SendMessage(hGAIDBLogClientListBox, LB_ADDSTRING, WPARAM(0), LPARAM(PChar(m)));
      if (aResult=LB_ERR) then
        MessageBox(Handle, PChar('Произошла ошибка при отправке сообщения лог-клиенту!'+#13#10+'Обратитесь к администратору!'), PChar('Ошибка!'), MB_OK+MB_ICONERROR);
      if (aResult=LB_ERRSPACE) then
        MessageBox(Handle, PChar('Произошла ошибка при отправке сообщения лог-клиенту - список переполнен!'+#13#10+'Обратитесь к администратору!'), PChar('Ошибка!'), MB_OK+MB_ICONERROR);
    end;
end;

procedure TMainForm.miGoToSearchStringClick(Sender: TObject);
begin
  if pnlConnectedMode.Visible and edbxSearch.Visible and edbxSearch.Enabled then
    edbxSearch.SetFocus;
end;

procedure TMainForm.miStatusbarClick(Sender: TObject);
var
  s: string;
begin
  SetBusy;
  StatusBar1.Visible:=miStatusbar.Checked;
  if StatusBar1.Visible then
    s:='включена'
  else
    s:='отключена';
  LogThis('Панель статуса '+s+'.', lmtInfo);
  SetReady;
end;

procedure TMainForm.miToolbarClick(Sender: TObject);
var
  s: string;
begin
  SetBusy;
  ActionToolBar1.Visible:=miToolbar.Checked;
  if ActionToolBar1.Visible then
    s:='включена'
  else
    s:='отключена';
  LogThis('Панель кнопок '+s+'.', lmtInfo);
  SetReady;
end;

procedure TMainForm.N26Click(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      pnlOwnerGeneralInfo.Visible:=not pnlOwnerGeneralInfo.Visible;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      pnlAutoGeneralInfo.Visible:=not pnlAutoGeneralInfo.Visible;
    end;
end;

procedure TMainForm.pmChangeTextColorPopup(Sender: TObject);
var
  bmB: TBitmap;
begin
  bmB:=TBitmap.Create;
  try
    if ColorDialog1.Execute then
      begin
        clInfo:=ColorDialog1.Color;
        if PageControl1.ActivePage=tsOwner then
          begin
            reOwnerOtherInfo.SelAttributes.Color:=clInfo;
          end;
        if PageControl1.ActivePage=tsAuto then
          begin
            reAutoOtherInfo.SelAttributes.Color:=clInfo;
          end;
        ImageListForRichEditMenu.GetBitmap(14, bmB);
        bmB.Canvas.Brush.Color:=clInfo;
        bmB.Canvas.FillRect(Rect(0, 14, 16, 16));
        ImageListForRichEditMenu.ReplaceMasked(14, bmB, bmB.Canvas.Pixels[0, 0]);
      end;
  finally
    bmB.Free;
  end;
end;

procedure TMainForm.pnlSearchEnter(Sender: TObject);
begin
  if btbtnSearch.default<>True then
    btbtnSearch.default:=True;
end;

procedure TMainForm.pnlSearchExit(Sender: TObject);
begin
  if btbtnSearch.default<>False then
    btbtnSearch.default:=False;
end;

procedure TMainForm.reAutoOtherInfoContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  Action_RichEditUndo.Enabled:=reAutoOtherInfo.Perform(EM_CANUNDO, 0, 0)<>0;
  Action_RichEditRedo.Enabled:=reAutoOtherInfo.Perform(EM_CANREDO, 0, 0)<>0;
end;

procedure TMainForm.reAutoOtherInfoEnter(Sender: TObject);
begin
  Update_RichEditTools;
end;

procedure TMainForm.reOwnerOtherInfoContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
begin
  Action_RichEditUndo.Enabled:=reOwnerOtherInfo.Perform(EM_CANUNDO, 0, 0)<>0;
  Action_RichEditRedo.Enabled:=reOwnerOtherInfo.Perform(EM_CANREDO, 0, 0)<>0;
end;

procedure TMainForm.reOwnerOtherInfoEnter(Sender: TObject);
begin
  Update_RichEditTools;
end;

procedure TMainForm.reOwnerOtherInfoSelectionChange(Sender: TObject);
begin
  Update_RichEditTools;
  if PageControl1.ActivePage=tsOwner then
    begin
      if Action_RichEditFormatBySample.Checked then
        begin
          reOwnerOtherInfo.Paragraph.Alignment:=ParaAttr.Alignment;
          reOwnerOtherInfo.Paragraph.FirstIndent:=ParaAttr.FirstIndent;
          reOwnerOtherInfo.Paragraph.LeftIndent:=ParaAttr.LeftIndent;
          reOwnerOtherInfo.Paragraph.Numbering:=ParaAttr.Numbering;
          reOwnerOtherInfo.Paragraph.RightIndent:=ParaAttr.RightIndent;
          reOwnerOtherInfo.Paragraph.TabCount:=ParaAttr.TabCount;
          reOwnerOtherInfo.SelAttributes.Charset:=TextAttr.Charset;
          reOwnerOtherInfo.SelAttributes.Color:=TextAttr.Color;
          reOwnerOtherInfo.SelAttributes.name:=TextAttr.name;
          reOwnerOtherInfo.SelAttributes.Pitch:=TextAttr.Pitch;
          reOwnerOtherInfo.SelAttributes.Size:=TextAttr.Size;
          reOwnerOtherInfo.SelAttributes.Style:=TextAttr.Style;
          reOwnerOtherInfo.SelAttributes.Height:=TextAttr.Height;
          Action_RichEditFormatBySample.Checked:=False;
        end;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      if Action_RichEditFormatBySample.Checked then
        begin
          reAutoOtherInfo.Paragraph.Alignment:=ParaAttr.Alignment;
          reAutoOtherInfo.Paragraph.FirstIndent:=ParaAttr.FirstIndent;
          reAutoOtherInfo.Paragraph.LeftIndent:=ParaAttr.LeftIndent;
          reAutoOtherInfo.Paragraph.Numbering:=ParaAttr.Numbering;
          reAutoOtherInfo.Paragraph.RightIndent:=ParaAttr.RightIndent;
          reAutoOtherInfo.Paragraph.TabCount:=ParaAttr.TabCount;
          reAutoOtherInfo.SelAttributes.Charset:=TextAttr.Charset;
          reAutoOtherInfo.SelAttributes.Color:=TextAttr.Color;
          reAutoOtherInfo.SelAttributes.name:=TextAttr.name;
          reAutoOtherInfo.SelAttributes.Pitch:=TextAttr.Pitch;
          reAutoOtherInfo.SelAttributes.Size:=TextAttr.Size;
          reAutoOtherInfo.SelAttributes.Style:=TextAttr.Style;
          reAutoOtherInfo.SelAttributes.Height:=TextAttr.Height;
          Action_RichEditFormatBySample.Checked:=False;
        end;
    end;
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
var
  s: string;
  p: integer;
begin
  SetBusy;
  with TAboutForm.Create(Self) do
    try
      Button1.Visible:=True;
      Timer1.Enabled:=False;
      AlphaBlendValue:=222;
      Timer2.Enabled:=False;
      s:=gsFileVersionInfo1.FileVersion;
      p:=LastDelimiter('.', s);
      s:=copy(s, 1, p-1);
      Label2.Caption:=Format('Версия %s билд %s', [s, gsFileVersionInfo1.GetBuildOnly]);
      Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
      LogThis('Окно "О программе..." показано.', lmtInfo);
      ShowModal;
    finally
      Free;
      LogThis('Окно "О программе..." скрыто.', lmtInfo);
    end;
  SetReady;
end;

procedure TMainForm.Action_DB_AddAutoExecute(Sender: TObject);
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  bAddingAutoNow:=True;
  lvAutos.Selected:=nil;
  // обновление значений панели создания/модификации
  lblCreationCaption.Visible:=False;
  lblCreation.Visible:=False;
  lblModificationCaption.Visible:=False;
  lblModification.Visible:=False;
  // обновление значений панели идентификатора
  if pnlID.Visible then
    begin
      lblIDCaption.Visible:=False;
      lblID.Visible:=False;
    end;
  // очистка значений контролов
  lblId.Caption:='';
  lblCreation.Caption:='';
  lblModification.Caption:='';
  edbxAutoNumber.Clear;
  dtpAutoDateOfIssue.Date:=Date;
  dtpAutoDateOfIssue.Time:=EncodeTime(0, 0, 0, 0);
  edbxAutoDateOfIssue.Clear;
  edbxAutoRegistrationSign.Clear;
  cmbbxAutoMarkModel.Clear;
  edbxAutoMarkModel.Clear;
  cmbbxAutoYearOfEdition.ItemIndex:=cmbbxAutoYearOfEdition.Items.IndexOf('');
  edbxAutoYearOfEdition.Clear;
  cmbbxAutoColor.Clear;
  edbxAutoColor.Clear;
  edbxAutoMaximumMass.Clear;
  edbxAutoNumberOfCarriage.Clear;
  edbxAutoMassWithoutLoad.Clear;
  cmbbxAutoType.Clear;
  edbxAutoType.Clear;
  meAutoComments.Clear;
  reAutoOtherInfo.Clear;
  SetDefaultSettings(reAutoOtherInfo);
  Update_RichEditTools;
  pnlEdit.Visible:=CurrentUser.bDBEdition;
  btnCancel.Enabled:=True;
  btnCancel.Visible:=True;
  PageControl1.ActivePage:=tsAuto;
  if edbxAutoNumber.Visible then
    edbxAutoNumber.SetFocus;
  Screen.Cursor:=crDefault;
  SetReady;
end;

procedure TMainForm.Action_DB_AddOwnerExecute(Sender: TObject);
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  bAddingOwnerNow:=True;
  if lvOwners.Selected<>nil then
    iLastSelectedOrgIndex:=lvOwners.Selected.index
  else
    if lvOwners.Items.Count>0 then
      iLastSelectedOrgIndex:=0
    else
      iLastSelectedOrgIndex:=-1;
  lvOwners.Selected:=nil;
  // обновление значений панели создания/модификации
  lblCreationCaption.Visible:=False;
  lblCreation.Visible:=False;
  lblModificationCaption.Visible:=False;
  lblModification.Visible:=False;
  // обновление значений панели идентификатора
  if pnlID.Visible then
    begin
      lblIDCaption.Visible:=False;
      lblID.Visible:=False;
    end;
  // очистка значений контролов
  lblId.Caption:='';
  lblCreation.Caption:='';
  lblModification.Caption:='';
  cmbbxOwnerType.Clear;
  edbxOwnerType.Clear;
  cmbbxOwnerCodeOfIssuingState.Clear;
  edbxOwnerCodeOfIssuingState.Clear;
  edbxOwnerPassportNumber.Clear;
  edbxOwnerSurname.Clear;
  edbxOwnerGivenNames.Clear;
  edbxOwnerSubname.Clear;
  cmbbxOwnerNationality.Clear;
  edbxOwnerNationality.Clear;
  dtpOwnerDateOfBirth.Date:=Date;
  dtpOwnerDateOfBirth.Time:=EncodeTime(0, 0, 0, 0);
  edbxOwnerDateOfBirth.Clear;
  edbxOwnerPlaceOfBirth.Clear;
  cmbbxOwnerSex.ItemIndex:=-1;
  edbxOwnerSex.Clear;
  edbxOwnerPrivateNumber.Clear;
  dtpOwnerDateOfIssue.Date:=Date;
  dtpOwnerDateOfIssue.Time:=EncodeTime(0, 0, 0, 0);
  edbxOwnerDateOfIssue.Clear;
  cmbbxOwnerAuthority.Clear;
  edbxOwnerAuthority.Clear;
  dtpOwnerDateOfExpiry.Date:=Date;
  dtpOwnerDateOfExpiry.Time:=EncodeTime(0, 0, 0, 0);
  edbxOwnerDateOfExpiry.Clear;
  cmbbxOwnerTown.Clear;
  edbxOwnerTown.Clear;
  cmbbxOwnerStreet.Clear;
  edbxOwnerStreet.Clear;
  edbxOwnerHouse.Clear;
  edbxOwnerSubHouse.Clear;
  edbxOwnerFlat.Clear;
  reOwnerOtherInfo.Clear;
  SetDefaultSettings(reOwnerOtherInfo);
  Update_RichEditTools;
  pnlEdit.Visible:=CurrentUser.bDBEdition;
  btnCancel.Enabled:=True;
  btnCancel.Visible:=True;
  PageControl1.ActivePage:=tsOwner;
  if cmbbxOwnerType.Visible then
    cmbbxOwnerType.SetFocus;
  Screen.Cursor:=crDefault;
  SetReady;
end;

procedure TMainForm.Action_DB_BackupExecute(Sender: TObject);
begin
  MessageBox(Handle, PChar('Данное действие на текущий момент в программе не реализовано.'), PChar('Невозможно выполнить операцию'), MB_OK+MB_ICONSTOP);
end;

procedure TMainForm.Action_DB_CleaningExecute(Sender: TObject);
begin
  MessageBox(Handle, PChar('Данное действие на текущий момент в программе не реализовано.'), PChar('Невозможно выполнить операцию'), MB_OK+MB_ICONSTOP);
end;

procedure TMainForm.Action_DB_ConnectionExecute(Sender: TObject);
var
  mr: TModalResult;
  s, q: string;
  pm: PMYSQL;
  i: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  SetBusy;
  ResultSet:=nil;
  LogThis('Выполняется открытие окна ввода пользователя и пароля...', lmtInfo);
  with TLoginForm.Create(Self) do
    try
      if (Configuration.bStoreLastLogin and(Configuration.sLastLogin<>'')) then
        begin
          edbxLogin.Text:=Configuration.sLastLogin;
          if (Configuration.bStoreLastPassword and(Configuration.sLastPassword<>'')) then
            begin
              edbxPassword.Text:=Configuration.sLastPassword;
              ModalResult:=mrOk;
            end
          else
            begin
              ActiveControl:=edbxLogin;
              ShowModal;
            end;
        end
      else
        begin
          ActiveControl:=edbxLogin;
          ShowModal;
        end;
    finally
      mr:=ModalResult;
      if mr=mrOk then
        begin
          CurrentUser.sLogin:=edbxLogin.Text;
          CurrentUser.sPassword:=edbxPassword.Text;
          Configuration.sLastLogin:=edbxLogin.Text;
          Configuration.sLastPassword:=edbxPassword.Text;
        end;
      Free;
    end;
  if mr=mrOk then
    begin
      StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:='';
      Application.ProcessMessages;
      LogThis('Данные пользователя введены...', lmtInfo);
      LogThis('Выполняется инициализация объекта соединения MySQL...', lmtInfo);
      MySQLConnectionHandler:=mysql_init(nil);
      if MySQLConnectionHandler<>nil then
        begin
          LogThis('Инициализация объекта соединения MySQL прошла успешно.', lmtInfo);
          LogThis('Выполняется попытка подключения к серверу MySQL...', lmtInfo);
          Screen.Cursor:=crHourGlass;
          pm:=mysql_real_connect(MySQLConnectionHandler, PChar(Configuration.sMySQLHost), PChar(Configuration.sMySQLUser), PChar(Configuration.sMySQLPassword), PChar(Configuration.sMySQLDatabase), Configuration.iMySQLPort, nil, 1);
          Screen.Cursor:=crDefault;
          if pm=MySQLConnectionHandler then
            begin
              LogThis('Подключение к серверу MySQL выполнено успешно.', lmtInfo);
              q:='SHOW TABLES FROM '+Configuration.sMySQLDatabase+' LIKE "_usr";';
              LogThis(q, lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.', lmtInfo);
                  ResultSet:=mysql_store_result(MySQLConnectionHandler);
                  if ResultSet<>nil then
                    begin
                      LogThis('Результирующая выборка получена успешно.', lmtInfo);
                      i:=mysql_num_rows(ResultSet);
                      if i=1 then
                        begin
                          LogThis('Таблица пользователей базы данных найдена успешно.', lmtInfo);
                          q:='SELECT COUNT(*) FROM _usr WHERE usr_login="'+CurrentUser.sLogin+'" AND usr_password_md5=md5("'+CurrentUser.sPassword+'") AND usr_erased="0";';
                          LogThis(q, lmtSQL);
                          i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                          if i=0 then
                            begin
                              LogThis('Запрос выполнен успешно.', lmtInfo);
                              ResultSet:=mysql_store_result(MySQLConnectionHandler);
                              if ResultSet<>nil then
                                begin
                                  LogThis('Результирующая выборка получена успешно.', lmtInfo);
                                  i:=mysql_num_rows(ResultSet);
                                  if i=1 then
                                    begin
                                      LogThis('Количество строк выборки соответствует требуемому.', lmtInfo);
                                      LogThis('Получение очередной строки выборки.', lmtInfo);
                                      ResultRow:=mysql_fetch_row(ResultSet);
                                      if ResultRow[0]='1' then
                                        begin
                                          LogThis('Указанный пользователь найден в базе данных', lmtInfo);
                                          LogThis('Освобождение ресурсов, занятых результатом выборки.', lmtInfo);
                                          if ResultSet<>nil then
                                            mysql_free_result(ResultSet);
                                          LogThis('Получение данных и прав доступа указанного пользователя...', lmtInfo);
                                          q:=
                                            'SELECT usr_id, usr_fullname, usr_is_admin, usr_can_edit_db, usr_can_backup_db, usr_can_clear_db, usr_can_defrag_db, usr_can_maintain_db, usr_can_edit_db_users FROM _usr WHERE usr_login="'+
                                            CurrentUser.sLogin+'" AND usr_password_md5=md5("'+CurrentUser.sPassword+'");';
                                          LogThis(q, lmtSQL);
                                          i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                                          if i=0 then
                                            begin
                                              LogThis('Запрос выполнен успешно.', lmtInfo);
                                              ResultSet:=mysql_store_result(MySQLConnectionHandler);
                                              if ResultSet<>nil then
                                                begin
                                                  LogThis('Результирующая выборка получена успешно.', lmtInfo);
                                                  i:=mysql_num_rows(ResultSet);
                                                  if i=1 then
                                                    begin
                                                      LogThis('Количество строк выборки соответствует требуемому.', lmtInfo);
                                                      LogThis('Получение очередной строки выборки.', lmtInfo);
                                                      ResultRow:=mysql_fetch_row(ResultSet);
                                                      if ResultRow<>nil then
                                                        begin
                                                          CurrentUser.sID:=ResultRow[0];
                                                          CurrentUser.sFullName:=ResultRow[1];
                                                          CurrentUser.bIsAdmin:=boolean(StrToIntDef(ResultRow[2], 0));
                                                          CurrentUser.bDBEdition:=boolean(StrToIntDef(ResultRow[3], 0));
                                                          CurrentUser.bDBBackup:=boolean(StrToIntDef(ResultRow[4], 0));
                                                          CurrentUser.bDBCleaning:=boolean(StrToIntDef(ResultRow[5], 0));
                                                          CurrentUser.bDBDefragmentation:=boolean(StrToIntDef(ResultRow[6], 0));
                                                          CurrentUser.bDBMaintenance:=boolean(StrToIntDef(ResultRow[7], 0));
                                                          CurrentUser.bDBUsersEdition:=boolean(StrToIntDef(ResultRow[8], 0));
                                                          LogThis('Получение данных и прав доступа указанного пользователя произведено успешно.', lmtInfo);
                                                          LogThis('Подключение пользователя к базе данных выполнено успешно.', lmtInfo);
                                                          // проверка на возможность подключения к базе
                                                          // не находится ли база в монопольном режиме доступа?
                                                          // LogThis('Проверка флагов программы...',lmtInfo);
                                                          // q:='SELECT COUNT(*) FROM _flags WHERE flag_name="flag_monopoly" AND flag_value="0";';
                                                          // LogThis(q,lmtSQL);
                                                          // i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                                                          // if i=0 then
                                                          // begin
                                                          // LogThis('Запрос выполнен успешно.',lmtInfo);
                                                          // ResultSet:=mysql_store_result(MySQLConnectionHandler);
                                                          // if ResultSet<>nil then
                                                          // begin
                                                          // LogThis('Результирующая выборка получена успешно.',lmtInfo);
                                                          // i:=mysql_num_rows(ResultSet);
                                                          // if i=1 then
                                                          // begin
                                                          // LogThis('Количество строк выборки соответствует требуемому.',lmtInfo);
                                                          // LogThis('Получение очередной строки выборки.',lmtInfo);
                                                          // ResultRow:=mysql_fetch_row(ResultSet);
                                                          // if (ResultRow[0]='1') then
                                                          // //if ((ResultRow[0]='1') or (not CurrentUser.bDBEdition)) then
                                                          // begin
                                                          // LogThis('Монопольный режим в настоящий момент не задействован...',lmtInfo);
                                                          /// /                                                                          if not CurrentUser.bDBEdition then
                                                          /// /                                                                            begin
                                                          /// /                                                                              LogThis('База находится в монопольном режиме, но пользователь имеет право на вход, так как не имеет прав на редактирование информации.',lmtWarning);
                                                          /// /                                                                            end;
                                                          Action_DB_Connection.Visible:=False;
                                                          Action_DB_Connection.Enabled:=False;
                                                          Action_DB_Disconnection.Visible:=True;
                                                          Action_DB_Disconnection.Enabled:=True;
                                                          pnlEdit.Visible:=False;
                                                          PageControl1.ActivePage:=tsClear;
                                                          // pnlEdit.Visible:=(not (PageControl1.ActivePage=tsClear))and CurrentUser.bDBEdition;
                                                          pnlConnectedMode.Visible:=True;
                                                          Configuration.bLogged:=True;
                                                          bAddingOwnerNow:=False;
                                                          bAddingAutoNow:=False;
                                                          btbtnMore.Tag:=0;
                                                          UpdateSearchBar;

                                                          cmbbxOwnerType.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerType.Visible:=not CurrentUser.bDBEdition;
                                                          cmbbxOwnerCodeOfIssuingState.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerCodeOfIssuingState.Visible:=not CurrentUser.bDBEdition;
                                                          edbxOwnerPassportNumber.readonly:=not CurrentUser.bDBEdition;
                                                          edbxOwnerSurname.readonly:=not CurrentUser.bDBEdition;
                                                          edbxOwnerGivenNames.readonly:=not CurrentUser.bDBEdition;
                                                          edbxOwnerSubname.readonly:=not CurrentUser.bDBEdition;
                                                          cmbbxOwnerNationality.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerNationality.Visible:=not CurrentUser.bDBEdition;
                                                          dtpOwnerDateOfBirth.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerDateOfBirth.Visible:=not CurrentUser.bDBEdition;
                                                          edbxOwnerPlaceOfBirth.readonly:=not CurrentUser.bDBEdition;
                                                          cmbbxOwnerSex.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerSex.Visible:=not CurrentUser.bDBEdition;
                                                          edbxOwnerPrivateNumber.readonly:=not CurrentUser.bDBEdition;
                                                          dtpOwnerDateOfIssue.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerDateOfIssue.Visible:=not CurrentUser.bDBEdition;
                                                          cmbbxOwnerAuthority.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerAuthority.Visible:=not CurrentUser.bDBEdition;
                                                          dtpOwnerDateOfExpiry.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerDateOfExpiry.Visible:=not CurrentUser.bDBEdition;
                                                          cmbbxOwnerTown.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerTown.Visible:=not CurrentUser.bDBEdition;
                                                          cmbbxOwnerStreet.Visible:=CurrentUser.bDBEdition;
                                                          edbxOwnerStreet.Visible:=not CurrentUser.bDBEdition;
                                                          edbxOwnerHouse.readonly:=not CurrentUser.bDBEdition;
                                                          edbxOwnerSubHouse.readonly:=not CurrentUser.bDBEdition;
                                                          edbxOwnerFlat.readonly:=not CurrentUser.bDBEdition;
                                                          reOwnerOtherInfo.readonly:=not CurrentUser.bDBEdition;

                                                          edbxAutoNumber.readonly:=not CurrentUser.bDBEdition;
                                                          dtpAutoDateOfIssue.Visible:=CurrentUser.bDBEdition;
                                                          edbxAutoDateOfIssue.Visible:=not CurrentUser.bDBEdition;
                                                          edbxAutoRegistrationSign.readonly:=not CurrentUser.bDBEdition;
                                                          cmbbxAutoMarkModel.Visible:=CurrentUser.bDBEdition;
                                                          edbxAutoMarkModel.Visible:=not CurrentUser.bDBEdition;
                                                          cmbbxAutoYearOfEdition.Visible:=CurrentUser.bDBEdition;
                                                          edbxAutoYearOfEdition.Visible:=not CurrentUser.bDBEdition;
                                                          cmbbxAutoColor.Visible:=CurrentUser.bDBEdition;
                                                          edbxAutoColor.Visible:=not CurrentUser.bDBEdition;
                                                          edbxAutoMaximumMass.readonly:=not CurrentUser.bDBEdition;
                                                          edbxAutoNumberOfCarriage.readonly:=not CurrentUser.bDBEdition;
                                                          edbxAutoMassWithoutLoad.readonly:=not CurrentUser.bDBEdition;
                                                          cmbbxAutoType.Visible:=CurrentUser.bDBEdition;
                                                          edbxAutoType.Visible:=not CurrentUser.bDBEdition;
                                                          meAutoComments.readonly:=not CurrentUser.bDBEdition;
                                                          reAutoOtherInfo.readonly:=not CurrentUser.bDBEdition;

                                                          edbxSearch.Clear;
                                                          // очистка окна результатов поиска
                                                          lvOwners.Items.BeginUpdate;
                                                          SendMessage(lvOwners.Handle, LVM_REMOVEALLGROUPS, 0, 0);
                                                          SendMessage(lvOwners.Handle, LVM_DELETEALLITEMS, 0, 0);
                                                          lvOwners.Items.EndUpdate;
                                                          lvAutos.Items.BeginUpdate;
                                                          SendMessage(lvAutos.Handle, LVM_REMOVEALLGROUPS, 0, 0);
                                                          SendMessage(lvAutos.Handle, LVM_DELETEALLITEMS, 0, 0);
                                                          lvAutos.Items.EndUpdate;
                                                          if CurrentUser.bDBEdition then
                                                            begin
                                                              lvOwners.SmallImages:=ImageList5;
                                                              lvAutos.SmallImages:=ImageList5;
                                                            end
                                                          else
                                                            begin
                                                              lvOwners.SmallImages:=nil;
                                                              lvAutos.SmallImages:=nil;
                                                              lvOwners.ColumnClick:=True;
                                                              lvOwners.ColumnClick:=False;
                                                              lvAutos.ColumnClick:=True;
                                                              lvAutos.ColumnClick:=False;
                                                            end;
                                                          lvOwners.OnResize(Sender);
                                                          // lvAutos.OnResize(Sender);
                                                          lblCreationCaption.Visible:=False;
                                                          lblCreation.Visible:=False;
                                                          lblModificationCaption.Visible:=False;
                                                          lblModification.Visible:=False;
                                                          lblIDCaption.Visible:=False;
                                                          lblID.Visible:=False;

                                                          // dtpStartDate.DateTime:=Now();
                                                          // dtpStartDate.Time:=EncodeTime(0,0,0,0);
                                                          // dtpStopDate.DateTime:=Now();
                                                          // dtpStopDate.Time:=EncodeTime(23,59,59,0);

                                                          StatusBar1.Panels[STATUSBAR_ITEMS_COUNT_PANEL_NUMBER].Width:=0;
                                                          StatusBar1.Panels[STATUSBAR_ITEMS_COUNT_PANEL_NUMBER].Text:='';
                                                          // reOrgOther.PlainText:=True;
                                                          // reOrgOther.PlainText:=False;
                                                          MainForm.ActiveControl:=edbxSearch;
                                                          // end
                                                          // else s:='В данный момент Вы не можете подключиться к базе данных,'+#13#10+'поскольку она используется в монопольном режиме другим пользователем!'+#13#10+'Данный запрет введён во избежание ошибок при обслуживании базы данных.'+#13#10+'За информацией обратитесь к администратору!';
                                                          // end
                                                          // else s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                                          // end
                                                          // else s:='Количество строк выборки ('+IntToStr(i)+')не соответствует требуемому (1)!';
                                                          // end
                                                          // else s:='Возникла ошибка при выполнении запроса!';
                                                        end
                                                      else
                                                        s:='Возникла ошибка при загрузке данных строки выборки!';
                                                    end
                                                  else
                                                    s:='Количество строк выборки ('+IntToStr(i)+')не соответствует требуемому (1)!';
                                                end
                                              else
                                                s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            end
                                          else
                                            s:='Возникла ошибка при выполнении запроса!';
                                        end
                                      else
                                        s:='Указанный пользователь не найден в базе данных, процесс подключения отменён!';
                                    end
                                  else
                                    s:='Количество строк выборки ('+IntToStr(i)+')не соответствует требуемому (1)!';
                                end
                              else
                                s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                            end
                          else
                            s:='Возникла ошибка при выполнении запроса!';
                        end
                      else
                        s:='Ошибка при поиске таблицы пользователей базы данных!';
                    end
                  else
                    s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                end
              else
                s:='Возникла ошибка при выполнении запроса!';
            end
          else
            begin
              i:=mysql_errno(MySQLConnectionHandler);
              // s:=mysql_error(MySQLConnectionHandler);
              if i=2003 then
                s:='Возникла ошибка при попытке подключения к серверу MySQL, так как сервер MySQL не запущен!'
              else
                s:='Возникла ошибка при попытке подключения к серверу MySQL!';
            end;
        end
      else
        s:='Возникла ошибка при инициализации объекта соединения MySQL!';
      if Action_DB_Connection.Visible then
        begin
          LogThis(s, lmtError);
          MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
      if ResultSet<>nil then
        begin
          LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
          mysql_free_result(ResultSet);
        end;
    end
  else
    LogThis('Ввод данных пользователя отменён.', lmtWarning);
  Update_Actions;
  SetReady;
end;

procedure TMainForm.Action_DB_DisconnectionExecute(Sender: TObject);
begin
  Action_DB_Connection.Visible:=True;
  Action_DB_Connection.Enabled:=True;
  Action_DB_Disconnection.Visible:=False;
  Action_DB_Disconnection.Enabled:=False;
  pnlConnectedMode.Visible:=False;
  UpdateSearchBar;
  StatusBar1.Panels[STATUSBAR_ITEMS_COUNT_PANEL_NUMBER].Text:='';
  StatusBar1.Panels[STATUSBAR_ITEMS_COUNT_PANEL_NUMBER].Width:=0;
  if MySQLConnectionHandler<>nil then
    begin
      mysql_close(MySQLConnectionHandler);
      MySQLConnectionHandler:=nil;
    end;
  Configuration.bLogged:=False;
  SaveConfigIni;
  Update_Actions;
end;

procedure TMainForm.Action_DB_MaintenanceExecute(Sender: TObject);
begin
  MessageBox(Handle, PChar('Данное действие на текущий момент в программе не реализовано.'), PChar('Невозможно выполнить операцию'), MB_OK+MB_ICONSTOP);
end;

procedure TMainForm.Action_DB_StatisticExecute(Sender: TObject);
var
  mr: TModalResult;
  q, s, sStartDate, sStopDate: string;
  i, j, k, l: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
  sIns, sMod, sDel, sRec: string;
  iSumIns, iSumMod, iSumDel, iSumRec: integer;
  HTML: WideString;
  r: cardinal;
  TempPathNameBuffer, TempFileNameBuffer: PAnsiChar;
  Year, Month, Day: word;
  dtNow: TDateTime;
  iNextMonth, iNextMonthYear: integer;
  Hour, Min, Sec, MSec: word;
  slTemp: TStringList;
begin
  SetBusy;
  // инициализация всех переменных
  bError:=False;
  ResultSet:=nil;
  TempPathNameBuffer:=nil;
  TempFileNameBuffer:=nil;
  LogThis('Попытка открытия окна формирования статистики...', lmtInfo);
  ProgressBar1.Position:=ProgressBar1.Min;
  iSumIns:=0;
  iSumMod:=0;
  iSumDel:=0;
  iSumRec:=0;
  // создание временного списка строк
  slTemp:=TStringList.Create;
  try
    with TStatisticForm.Create(Owner) do
      try
        chklbxUsers.Clear;
        ImageList2.GetIcon(4, Icon);
        btnHelp.Enabled:=Application.HelpFile<>'';
        // получение списка пользователей
        LogThis('Получение списка пользователей...', lmtInfo);
        q:='SELECT usr_fullname FROM _usr WHERE usr_erased="0" GROUP BY usr_fullname ORDER BY usr_fullname;';
        LogThis(q, lmtSQL);
        i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
        if i=0 then
          begin
            LogThis('Запрос выполнен успешно.', lmtInfo);
            ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
            if ResultSet<>nil then
              begin
                LogThis('Результирующая выборка получена успешно.', lmtInfo);
                i:=mysql_num_rows(ResultSet);
                if i>0 then
                  begin
                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                    ProgressBar1.Max:=i;
                    ProgressBar1.Step:=1;
                    for j:=0 to i-1 do
                      begin
                        LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', lmtInfo);
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow<>nil then
                          begin
                            LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', lmtInfo);
                            chklbxUsers.Items.Add(ResultRow[0]);
                          end
                        else
                          begin
                            s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                            bError:=True;
                          end;
                        ProgressBar1.StepIt;
                      end;
                    if ResultSet<>nil then
                      begin
                        LogThis('Освобождение ресурсов, занятых результатом выборки.', lmtInfo);
                        mysql_free_result(ResultSet);
                      end;
                    ProgressBar1.Position:=ProgressBar1.Min;
                    // получение списка годов при помощи выборки из БД
                    LogThis('Получение списка лет (годов)...', lmtInfo);
                    q:='SELECT LEFT(evn_datetime,4) FROM _evn GROUP BY LEFT(evn_datetime,4) ORDER BY LEFT(evn_datetime,4);';
                    LogThis(q, lmtSQL);
                    i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                    if i=0 then
                      begin
                        LogThis('Запрос выполнен успешно.', lmtInfo);
                        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                        if ResultSet<>nil then
                          begin
                            LogThis('Результирующая выборка получена успешно.', lmtInfo);
                            i:=mysql_num_rows(ResultSet);
                            if i>0 then
                              begin
                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                                ProgressBar1.Max:=i;
                                ProgressBar1.Step:=1;
                                for j:=0 to i-1 do
                                  begin
                                    LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', lmtInfo);
                                    ResultRow:=mysql_fetch_row(ResultSet);
                                    if ResultRow<>nil then
                                      begin
                                        LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', lmtInfo);
                                        cmbbxSelectedMonthYear.Items.Add(ResultRow[0]);
                                        cmbbxSelectedYear.Items.Add(ResultRow[0]);
                                        ProgressBar1.StepIt;
                                      end
                                    else
                                      begin
                                        s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                        bError:=True;
                                      end;
                                  end;
                              end
                            else
                              begin
                                s:='Формирование отчётов невозможно, так как в таблице статистических данных не было найдено ни одной записи! ';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                            bError:=True;
                          end;
                      end
                    else
                      begin
                        s:='Возникла ошибка при выполнении запроса!';
                        bError:=True;
                      end;
                  end
                else
                  begin
                    s:='В системе не зарегестрироывано ни одного пользователя!';
                    bError:=True;
                  end;
              end
            else
              begin
                s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                bError:=True;
              end;
          end
        else
          begin
            s:='Возникла ошибка при выполнении запроса!';
            bError:=True;
          end;
        if bError then
          begin
            LogThis(s, lmtError);
            MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          end
        else
          begin
            DecodeDate(Now(), Year, Month, Day);
            cmbbxSelectedMonthMonth.ItemIndex:=Month-1; // список начинается с нуля, поэтому отнимаем единицу
            if cmbbxSelectedMonthYear.Items.Count>0 then
              cmbbxSelectedMonthYear.ItemIndex:=cmbbxSelectedMonthYear.Items.IndexOf(IntToStr(Year));
            if cmbbxSelectedYear.Items.Count>0 then
              cmbbxSelectedYear.ItemIndex:=cmbbxSelectedYear.Items.IndexOf(IntToStr(Year));
          end;
        if ResultSet<>nil then
          begin
            LogThis('Освобождение ресурсов, занятых результатом выборки.', lmtInfo);
            mysql_free_result(ResultSet);
          end;
        ProgressBar1.Position:=ProgressBar1.Min;
        if bError=False then
          ShowModal;
      finally
        mr:=ModalResult;
        if mr=mrOk then
          begin
            dtNow:=Now;
            DecodeDate(dtNow, Year, Month, Day);
            DecodeTime(dtNow, Hour, Min, Sec, MSec);
            if RadioButton1.Checked then
              begin
                sStartDate:=DateToStr(dtpStartDate_stat.DateTime);
                sStopDate:=DateToStr(dtpStopDate_stat.DateTime);
              end;
            if RadioButton2.Checked then
              begin
                sStartDate:=DateToStr(EncodeDate(StrToInt(cmbbxSelectedMonthYear.Items[cmbbxSelectedMonthYear.ItemIndex]), cmbbxSelectedMonthMonth.ItemIndex+1, 1));
                // определение следующего месяца
                iNextMonth:=cmbbxSelectedMonthMonth.ItemIndex+2;
                iNextMonthYear:=StrToInt(cmbbxSelectedMonthYear.Items[cmbbxSelectedMonthYear.ItemIndex]);
                if iNextMonth=13 then
                  begin
                    iNextMonth:=1;
                    iNextMonthYear:=iNextMonthYear+1;
                  end;
                sStopDate:=DateToStr(EncodeDate(iNextMonthYear, iNextMonth, 1)-(EncodeDate(2004, 1, 2)-EncodeDate(2004, 1, 1)));
              end;
            if RadioButton3.Checked then
              begin
                sStartDate:=DateToStr(EncodeDate(StrToInt(cmbbxSelectedYear.Items[cmbbxSelectedYear.ItemIndex]), 1, 1));
                sStopDate:=DateToStr(EncodeDate(StrToInt(cmbbxSelectedYear.Items[cmbbxSelectedYear.ItemIndex]), 12, 31));
              end;
            HTML:='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">'+#13#10;
            HTML:=HTML+'<HTML>'+#13#10;
            HTML:=HTML+'  <HEAD>'+#13#10;
            HTML:=HTML+'    <TITLE>Статистика по работе пользователей АРМ &laquo;GAIDB&raquo;</TITLE>'+#13#10;
            HTML:=HTML+'    <META CONTENT="no-cache" HTTP-EQUIV="pragma">'+#13#10;
            HTML:=HTML+'    <META CONTENT="no-cache" HTTP-EQUIV="cache-control">'+#13#10;
            HTML:=HTML+'    <META CONTENT=Dynamic NAME=Document-state>'+#13#10;
            HTML:=HTML+'    <META content="text/html; charset=Windows-1251" http-equiv=Content-Type>'+#13#10;
            HTML:=HTML+'    <STYLE MEDIA="screen, print" TYPE="text/css">'+#13#10;
            HTML:=HTML+'      * {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 8pt; padding: 0; margin: 0; border-color: transparent; border-width: 0;}'+#13#10;
            HTML:=HTML+'      TABLE, TD {border-style: solid;}'+#13#10;
            HTML:=HTML+'    </STYLE>'+#13#10;
            HTML:=HTML+'  </HEAD>'+#13#10;
            HTML:=HTML+'  <BODY>'+#13#10;
            HTML:=HTML+'    <CENTER>'+#13#10;
            HTML:=HTML+'    <TABLE ALIGN="CENTER" BORDER="1" BGCOLOR="WHITE" WIDTH="656" STYLE="border-color: white; border-width: 0; table-layout: fixed; empty-cells: show; float: none; clear: both; border-collapse: collapse;">'+#13#10;
            HTML:=HTML+'      <TBODY VALIGN="MIDDLE" STYLE="border-color: white; border-width: 0;">'+#13#10;
            // определение параметров создаваемого отчёта
            if chkbxDetailed.Checked then
              begin
                // подробный отчёт
                HTML:=HTML+'        <TR>'+#13#10;
                HTML:=HTML+'          <TD HEIGHT="1px" STYLE="border-color: white; border-width: 0;" WIDTH="80px"></TD>'+#13#10;
                HTML:=HTML+'          <TD HEIGHT="1px" STYLE="border-color: white; border-width: 0;" WIDTH="70px"></TD>'+#13#10;
                HTML:=HTML+'          <TD HEIGHT="1px" STYLE="border-color: white; border-width: 0;" WIDTH="120px"></TD>'+#13#10;
                HTML:=HTML+'          <TD HEIGHT="1px" STYLE="border-color: white; border-width: 0;" WIDTH="386px"></TD>'+#13#10;
                HTML:=HTML+'        </TR>'+#13#10;
                HTML:=HTML+'        <TR><TD COLSPAN="4" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">';
                HTML:=HTML+'</TD></TR>'+#13#10;
                HTML:=HTML+'        <TR><TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">';
                HTML:=HTML+'Статистика&nbsp;по&nbsp;работе&nbsp;пользователей АРМ&nbsp;&laquo;GAIDB&raquo; за период с '+sStartDate+' по '+sStopDate+'<BR></TD></TR>'+#13#10;
                // перебираем список отмеченых пользователей
                for k:=0 to chklbxUsers.Count-1 do
                  begin
                    if chklbxUsers.Checked[k] then
                      begin
                        s:=chklbxUsers.Items[k];
                        // выборка данных из базы
                        q:='SELECT LEFT(evn_datetime,10), RIGHT(evn_datetime,8), evn_type, evn_details FROM _evn LEFT JOIN _usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" AND LEFT(evn_datetime,10) BETWEEN "'+Copy(sStartDate, 7, 4)+'-'+Copy
                          (sStartDate, 4, 2)+'-'+Copy(sStartDate, 0, 2)+'" AND "'+Copy(sStopDate, 7, 4)+'-'+Copy(sStopDate, 4, 2)+'-'+Copy(sStopDate, 0, 2)+'" ORDER BY LEFT(evn_datetime,10), RIGHT(evn_datetime,8);';
                        LogThis(q, lmtSQL);
                        i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                        if i=0 then
                          begin
                            LogThis('Запрос выполнен успешно.', lmtInfo);
                            ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                            if ResultSet<>nil then
                              begin
                                LogThis('Результирующая выборка получена успешно.', lmtInfo);
                                i:=mysql_num_rows(ResultSet);
                                if i>=0 then
                                  begin
                                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                                    ProgressBar1.Max:=i;
                                    ProgressBar1.Step:=1;
                                    HTML:=HTML+'        <TR>'+#13#10;
                                    HTML:=HTML+'          <TD VALIGN="TOP" COLSPAN="4" STYLE="text-align: left; font-size: 12pt; font-weight: bold; border-color: white; border-width: 0; padding: 20px 2px 2px 0px;">'+s+'</TD>'+#13#10;
                                    HTML:=HTML+'        </TR>'+#13#10;
                                    if i>0 then
                                      begin
                                        HTML:=HTML+'        <TR>'+#13#10;
                                        HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; font-size: 8pt; padding: 2px;">Дата</TD>'+#13#10;
                                        HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 8pt; padding: 2px;">Время</TD>'+#13#10;
                                        HTML:=HTML+'          <TD ';
                                        if not chkbxShowSQLQuery.Checked then
                                          HTML:=HTML+'COLSPAN="2" ';
                                        HTML:=HTML+'STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 8pt; padding: 2px;">Действие</TD>'+#13#10;
                                        if chkbxShowSQLQuery.Checked then
                                          HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 8pt; padding: 2px;">Текст&nbsp;SQL-запроса</TD>'+#13#10;
                                        HTML:=HTML+'        </TR>'+#13#10;
                                        for j:=0 to i-1 do
                                          begin
                                            LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', lmtInfo);
                                            ResultRow:=mysql_fetch_row(ResultSet);
                                            if ResultRow<>nil then
                                              begin
                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', lmtInfo);
                                                HTML:=HTML+'        <TR>'+#13#10;
                                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((i-1)-j)=0))+'px 2px; border-color: black; font-size: 8pt; padding: 2px;">'+Copy(ResultRow[0], 9, 2)
                                                  +'.'+Copy(ResultRow[0], 6, 2)+'.'+Copy(ResultRow[0], 0, 4)+'</TD>'+#13#10;
                                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((i-1)-j)=0))+'px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+ResultRow[1]+'</TD>'+#13#10;
                                                q:=ResultRow[2];
                                                if q='INS' then
                                                  q:='Создание';
                                                if q='MOD' then
                                                  q:='Испраление';
                                                if q='DEL' then
                                                  q:='Удаление';
                                                if q='REC' then
                                                  q:='Восстановление';
                                                HTML:=HTML+'          <TD ';
                                                if not chkbxShowSQLQuery.Checked then
                                                  HTML:=HTML+'COLSPAN="2" ';
                                                HTML:=HTML+'STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((i-1)-j)=0))+'px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+q+'</TD>'+#13#10;
                                                if chkbxShowSQLQuery.Checked then
                                                  HTML:=HTML+'          <TD STYLE="text-align: left; border-width: 0px 2px '+IntToStr(1+integer(((i-1)-j)=0))+'px 0px; border-color: black; font-size: 8pt; padding: 2px 2px 2px 5px;">'+ResultRow[3]
                                                    +'</TD>'+#13#10;
                                                HTML:=HTML+'        </TR>'+#13#10;
                                              end
                                            else
                                              begin
                                                s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                                bError:=True;
                                              end;
                                            ProgressBar1.StepIt;
                                          end;
                                      end
                                    else
                                      begin
                                        HTML:=HTML+'        <TR>'+#13#10;
                                        HTML:=HTML+'          <TD COLSPAN="4" STYLE="text-align: left; border-width: 0px; border-color: white; font-size: 8pt; padding: 2px 2px 2px 0px;">Данные по работе указанного пользователя отсутствуют.</TD>'+
                                          #13#10;
                                        HTML:=HTML+'        </TR>'+#13#10;
                                      end;
                                  end
                                else
                                  begin
                                    LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.', lmtInfo);
                                  end;
                              end
                            else
                              begin
                                s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='Возникла ошибка при выполнении запроса!';
                            bError:=True;
                          end;
                        if bError then
                          begin
                            LogThis(s, lmtError);
                            MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                          end;
                        if ResultSet<>nil then
                          begin
                            LogThis('Освобождение ресурсов, занятых результатом выборки.', lmtInfo);
                            mysql_free_result(ResultSet);
                          end;
                        ProgressBar1.Position:=ProgressBar1.Min;
                      end;
                  end;
                HTML:=HTML+'        <TR>'+#13#10;
                HTML:=HTML+'          <TD COLSPAN="4" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                HTML:=HTML+'        </TR>'+#13#10;
                HTML:=HTML+'        <TR>'+#13#10;
                HTML:=HTML+'          <TD COLSPAN="4" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">Отчёт подготовлен '+DateToStr(EncodeDate(Year, Month, Day))+' в '+TimeToStr
                  (EncodeTime(Hour, Min, Sec, MSec))+' при помощи АРМ &laquo;GAIDB&raquo;, &copy;&nbsp;2008&nbsp;by&nbsp;Kuzmenkov&nbsp;Ilya</TD>'+#13#10;
                HTML:=HTML+'        </TR>'+#13#10;
              end
            else
              begin
                // свёрнутый отчёт
                HTML:=HTML+'        <TR>'+#13#10;
                HTML:=HTML+'          <TD HEIGHT="1px" STYLE="border-color: white; border-width: 0;" WIDTH="80px"></TD>'+#13#10;
                HTML:=HTML+'          <TD HEIGHT="1px" STYLE="border-color: white; border-width: 0;" WIDTH="144px"></TD>'+#13#10;
                HTML:=HTML+'          <TD HEIGHT="1px" STYLE="border-color: white; border-width: 0;" WIDTH="144px"></TD>'+#13#10;
                HTML:=HTML+'          <TD HEIGHT="1px" STYLE="border-color: white; border-width: 0;" WIDTH="144px"></TD>'+#13#10;
                HTML:=HTML+'          <TD HEIGHT="1px" STYLE="border-color: white; border-width: 0;" WIDTH="144px"></TD>'+#13#10;
                HTML:=HTML+'        </TR>'+#13#10;
                HTML:=HTML+'        <TR><TD COLSPAN="5" STYLE="border-bottom-color: #CCCCCC; border-top-color: white; border-left-color: white; border-right-color: white; border-width: 0px 0px 1px 0px; font-size: 7pt; text-align: right;">';
                HTML:=HTML+'</TD></TR>'+#13#10;
                HTML:=HTML+'        <TR><TD COLSPAN="5" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">';
                HTML:=HTML+'Статистика&nbsp;по&nbsp;работе&nbsp;пользователей АРМ&nbsp;&laquo;GAIDB&raquo; за период с '+sStartDate+' по '+sStopDate+'<BR></TD></TR>'+#13#10;
                // перебираем список отмеченых пользователей
                for k:=0 to chklbxUsers.Count-1 do
                  begin
                    if chklbxUsers.Checked[k] then
                      begin
                        s:=chklbxUsers.Items[k];
                        // получаем список дат в которых есть данные по событиям
                        q:='SELECT LEFT(evn_datetime,10) FROM _evn LEFT JOIN _usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" AND LEFT(evn_datetime,10) BETWEEN "'+Copy(sStartDate, 7, 4)+'-'+Copy(sStartDate, 4, 2)+'-'+Copy(sStartDate, 0, 2)
                          +'" AND "'+Copy(sStopDate, 7, 4)+'-'+Copy(sStopDate, 4, 2)+'-'+Copy(sStopDate, 0, 2)+'" GROUP BY LEFT(evn_datetime,10) ORDER BY LEFT(evn_datetime,10);';
                        LogThis(q, lmtSQL);
                        i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                        if i=0 then
                          begin
                            LogThis('Запрос выполнен успешно.', lmtInfo);
                            ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                            if ResultSet<>nil then
                              begin
                                LogThis('Результирующая выборка получена успешно.', lmtInfo);
                                i:=mysql_num_rows(ResultSet);
                                if i>=0 then
                                  begin
                                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                                    ProgressBar1.Max:=i;
                                    ProgressBar1.Step:=1;
                                    slTemp.Clear;
                                    for j:=0 to i-1 do
                                      begin
                                        LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', lmtInfo);
                                        ResultRow:=mysql_fetch_row(ResultSet);
                                        if ResultRow<>nil then
                                          begin
                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', lmtInfo);
                                            slTemp.Add(ResultRow[0]);
                                          end
                                        else
                                          begin
                                            s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                            bError:=True;
                                          end;
                                        ProgressBar1.StepIt;
                                      end;
                                  end
                                else
                                  begin
                                    LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.', lmtInfo);
                                  end;
                                if ResultSet<>nil then
                                  begin
                                    LogThis('Освобождение ресурсов, занятых результатом выборки.', lmtInfo);
                                    mysql_free_result(ResultSet);
                                  end;
                              end
                            else
                              begin
                                s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='Возникла ошибка при выполнении запроса!';
                            bError:=True;
                          end;
                        ProgressBar1.Position:=ProgressBar1.Min;
                        if bError then
                          begin
                            LogThis(s, lmtError);
                            MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                          end
                          // перебираем полученный список дат и делаем выборки по типам действий для каждой из дат
                        else
                          begin
                            HTML:=HTML+'        <TR>'+#13#10;
                            HTML:=HTML+'          <TD VALIGN="TOP" COLSPAN="5" STYLE="text-align: left; font-size: 12pt; font-weight: bold; border-color: white; border-width: 0; padding: 20px 2px 2px 0px;">'+s+'</TD>'+#13#10;
                            HTML:=HTML+'        </TR>'+#13#10;
                            if i>0 then
                              begin
                                HTML:=HTML+'        <TR>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 2px; border-color: black; font-weight: bold; font-size: 8pt; padding: 2px;">Дата</TD>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 8pt; padding: 2px;">Создано</TD>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 8pt; padding: 2px;">Исправлено</TD>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 8pt; padding: 2px;">Удалено</TD>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 2px 2px 2px 0px; border-color: black; font-weight: bold; font-size: 8pt; padding: 2px;">Восстановлено</TD>'+#13#10;
                                HTML:=HTML+'        </TR>'+#13#10;
                                ProgressBar1.Max:=slTemp.Count;
                                ProgressBar1.Step:=1;
                                for j:=0 to slTemp.Count-1 do
                                  begin
                                    // получение количества добавленых элементов
                                    sIns:='0';
                                    s:=chklbxUsers.Items[k];
                                    q:='SELECT COUNT(*) FROM _evn LEFT JOIN _usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" AND evn_type="INS" AND LEFT(evn_datetime,10)="'+slTemp[j]+'" GROUP BY evn_type;';
                                    LogThis(q, lmtSQL);
                                    i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                                    if i=0 then
                                      begin
                                        LogThis('Запрос выполнен успешно.', lmtInfo);
                                        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Результирующая выборка получена успешно.', lmtInfo);
                                            i:=mysql_num_rows(ResultSet);
                                            if i>=0 then
                                              begin
                                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                                                for l:=0 to i-1 do
                                                  begin
                                                    LogThis('Получение очередной строки выборки ('+IntToStr(l)+').', lmtInfo);
                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                    if ResultRow<>nil then
                                                      begin
                                                        LogThis('Операция получения очередной строки выборки ('+IntToStr(l)+') прошла успешно.', lmtInfo);
                                                        sIns:=ResultRow[0];
                                                        iSumIns:=iSumIns+StrToInt(sIns);
                                                      end
                                                    else
                                                      begin
                                                        s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(l)+')!';
                                                        bError:=True;
                                                      end;
                                                    ProgressBar1.StepIt;
                                                  end;
                                              end
                                            else
                                              begin
                                                LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.', lmtInfo);
                                              end;
                                          end
                                        else
                                          begin
                                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            bError:=True;
                                          end;
                                      end
                                    else
                                      begin
                                        s:='Возникла ошибка при выполнении запроса!';
                                        bError:=True;
                                      end;
                                    // получение количества исправленных элементов
                                    sMod:='0';
                                    s:=chklbxUsers.Items[k];
                                    q:='SELECT COUNT(*) FROM _evn LEFT JOIN _usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" AND evn_type="MOD" AND LEFT(evn_datetime,10)="'+slTemp[j]+'" GROUP BY evn_type;';
                                    LogThis(q, lmtSQL);
                                    i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                                    if i=0 then
                                      begin
                                        LogThis('Запрос выполнен успешно.', lmtInfo);
                                        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Результирующая выборка получена успешно.', lmtInfo);
                                            i:=mysql_num_rows(ResultSet);
                                            if i>=0 then
                                              begin
                                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                                                for l:=0 to i-1 do
                                                  begin
                                                    LogThis('Получение очередной строки выборки ('+IntToStr(l)+').', lmtInfo);
                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                    if ResultRow<>nil then
                                                      begin
                                                        LogThis('Операция получения очередной строки выборки ('+IntToStr(l)+') прошла успешно.', lmtInfo);
                                                        sMod:=ResultRow[0];
                                                        iSumMod:=iSumMod+StrToInt(sMod);
                                                      end
                                                    else
                                                      begin
                                                        s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(l)+')!';
                                                        bError:=True;
                                                      end;
                                                    ProgressBar1.StepIt;
                                                  end;
                                              end
                                            else
                                              begin
                                                LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.', lmtInfo);
                                              end;
                                          end
                                        else
                                          begin
                                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            bError:=True;
                                          end;
                                      end
                                    else
                                      begin
                                        s:='Возникла ошибка при выполнении запроса!';
                                        bError:=True;
                                      end;
                                    // получение количества удалённых элементов
                                    sDel:='0';
                                    s:=chklbxUsers.Items[k];
                                    q:='SELECT COUNT(*) FROM _evn LEFT JOIN _usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" AND evn_type="DEL" AND LEFT(evn_datetime,10)="'+slTemp[j]+'" GROUP BY evn_type;';
                                    LogThis(q, lmtSQL);
                                    i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                                    if i=0 then
                                      begin
                                        LogThis('Запрос выполнен успешно.', lmtInfo);
                                        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Результирующая выборка получена успешно.', lmtInfo);
                                            i:=mysql_num_rows(ResultSet);
                                            if i>=0 then
                                              begin
                                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                                                for l:=0 to i-1 do
                                                  begin
                                                    LogThis('Получение очередной строки выборки ('+IntToStr(l)+').', lmtInfo);
                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                    if ResultRow<>nil then
                                                      begin
                                                        LogThis('Операция получения очередной строки выборки ('+IntToStr(l)+') прошла успешно.', lmtInfo);
                                                        sDel:=ResultRow[0];
                                                        iSumDel:=iSumDel+StrToInt(sDel);
                                                      end
                                                    else
                                                      begin
                                                        s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(l)+')!';
                                                        bError:=True;
                                                      end;
                                                    ProgressBar1.StepIt;
                                                  end;
                                              end
                                            else
                                              begin
                                                LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.', lmtInfo);
                                              end;
                                          end
                                        else
                                          begin
                                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            bError:=True;
                                          end;
                                      end
                                    else
                                      begin
                                        s:='Возникла ошибка при выполнении запроса!';
                                        bError:=True;
                                      end;
                                    // получение количества восстановленых элементов
                                    sRec:='0';
                                    s:=chklbxUsers.Items[k];
                                    q:='SELECT COUNT(*) FROM _evn LEFT JOIN _usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" AND evn_type="REC" AND LEFT(evn_datetime,10)="'+slTemp[j]+'" GROUP BY evn_type;';
                                    LogThis(q, lmtSQL);
                                    i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                                    if i=0 then
                                      begin
                                        LogThis('Запрос выполнен успешно.', lmtInfo);
                                        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Результирующая выборка получена успешно.', lmtInfo);
                                            i:=mysql_num_rows(ResultSet);
                                            if i>=0 then
                                              begin
                                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                                                for l:=0 to i-1 do
                                                  begin
                                                    LogThis('Получение очередной строки выборки ('+IntToStr(l)+').', lmtInfo);
                                                    ResultRow:=mysql_fetch_row(ResultSet);
                                                    if ResultRow<>nil then
                                                      begin
                                                        LogThis('Операция получения очередной строки выборки ('+IntToStr(l)+') прошла успешно.', lmtInfo);
                                                        sRec:=ResultRow[0];
                                                        iSumRec:=iSumRec+StrToInt(sRec);
                                                      end
                                                    else
                                                      begin
                                                        s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(l)+')!';
                                                        bError:=True;
                                                      end;
                                                    ProgressBar1.StepIt;
                                                  end;
                                              end
                                            else
                                              begin
                                                LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.', lmtInfo);
                                              end;
                                          end
                                        else
                                          begin
                                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            bError:=True;
                                          end;
                                      end
                                    else
                                      begin
                                        s:='Возникла ошибка при выполнении запроса!';
                                        bError:=True;
                                      end;
                                    // вывод результатов
                                    HTML:=HTML+'        <TR>'+#13#10;
                                    HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((slTemp.Count-1)-j)=0))+'px 2px; border-color: black; font-size: 8pt; padding: 2px;">'+Copy(slTemp[j], 9, 2)+'.'+Copy
                                      (slTemp[j], 6, 2)+'.'+Copy(slTemp[j], 0, 4)+'</TD>'+#13#10;
                                    HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((slTemp.Count-1)-j)=0))+'px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+sIns+'</TD>'+#13#10;
                                    HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((slTemp.Count-1)-j)=0))+'px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+sMod+'</TD>'+#13#10;
                                    HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((slTemp.Count-1)-j)=0))+'px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+sDel+'</TD>'+#13#10;
                                    HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((slTemp.Count-1)-j)=0))+'px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+sRec+'</TD>'+#13#10;
                                    HTML:=HTML+'        </TR>'+#13#10;
                                    ProgressBar1.StepIt;
                                  end;
                                // итого
                                HTML:=HTML+'        <TR>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 2px; border-color: black; font-size: 8pt; padding: 2px;">Итого:</TD>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+IntToStr(iSumIns)+'</TD>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+IntToStr(iSumMod)+'</TD>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+IntToStr(iSumDel)+'</TD>'+#13#10;
                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px 2px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+IntToStr(iSumRec)+'</TD>'+#13#10;
                                HTML:=HTML+'        </TR>'+#13#10;
                                ProgressBar1.Position:=ProgressBar1.Min;
                              end
                            else
                              begin
                                HTML:=HTML+'        <TR>'+#13#10;
                                HTML:=HTML+'          <TD COLSPAN="5" STYLE="text-align: left; border-width: 0px; border-color: white; font-size: 8pt; padding: 2px 2px 2px 0px;">Данные по работе указанного пользователя отсутствуют.</TD>'+#13#10;
                                HTML:=HTML+'        </TR>'+#13#10;
                              end;
                          end;
                      end;
                  end;
                HTML:=HTML+'        <TR>'+#13#10;
                HTML:=HTML+'          <TD COLSPAN="5" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                HTML:=HTML+'        </TR>'+#13#10;
                HTML:=HTML+'        <TR>'+#13#10;
                HTML:=HTML+'          <TD COLSPAN="5" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">Отчёт подготовлен '+DateToStr(EncodeDate(Year, Month, Day))+' в '+TimeToStr
                  (EncodeTime(Hour, Min, Sec, MSec))+' при помощи АРМ &laquo;GAIDB&raquo;, &copy;&nbsp;2008&nbsp;by&nbsp;Kuzmenkov&nbsp;Ilya</TD>'+#13#10;
                HTML:=HTML+'        </TR>'+#13#10;
              end;
            HTML:=HTML+'      </TBODY>'+#13#10;
            HTML:=HTML+'    </TABLE>'+#13#10;
            HTML:=HTML+'    </CENTER>'+#13#10;
            HTML:=HTML+'  </BODY>'+#13#10;
            HTML:=HTML+'</HTML>'+#13#10;
            with TStringList.Create do
              try
                Text:=HTML;
                LogThis('Получение пути временного каталога.', lmtInfo);
                GetMem(TempPathNameBuffer, 1024+1);
                r:=GetTempPath(1024, TempPathNameBuffer);
                if r>0 then
                  begin
                    if r>1024 then
                      begin
                        FreeMem(TempPathNameBuffer);
                        GetMem(TempPathNameBuffer, r+1);
                      end;
                    GetMem(TempFileNameBuffer, 1024+1);
                    LogThis('Получение имени временного файла.', lmtInfo);
                    GetTempFileName(TempPathNameBuffer, 'GAIDB', 0, TempFileNameBuffer);
                    q:=TempFileNameBuffer;
                    LogThis('Удаление файла '+#39+q+#39+'.', lmtInfo);
                    DeleteFile(q);
                    q:=ExtractFilePath(q)+Copy(ExtractFileName(q), 0, Length(ExtractFileName(q))-3)+'htm';
                    LogThis('Имя временного файла - '+#39+q+#39+'.', lmtInfo);
                    if not FileExists(q) then
                      begin
                        LogThis('Попытка сохраниея отчёта во временный файл '+#39+q+#39+'.', lmtInfo);
                        SaveToFile(q);
                        LogThis('Попытка открытия временного файла.', lmtInfo);
                        ShellExecute(Application.Handle, 'open', PChar(q), nil, nil, SW_MAXIMIZE);
                      end
                    else
                      begin
                        s:='Возникла ошибка при сохранении отчёта во временный файл '+#39+q+#39+' - указанный файл уже существует!';
                        bError:=True;
                      end;
                  end
                else
                  begin
                    s:='Возникла ошибка при получении пути временного каталога!';
                    bError:=True;
                  end;
                if bError then
                  begin
                    LogThis(s, lmtError);
                    MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                  end;
              finally
                if TempPathNameBuffer<>nil then
                  FreeMem(TempPathNameBuffer);
                if TempFileNameBuffer<>nil then
                  FreeMem(TempFileNameBuffer);
                Free;
              end;
          end;
        Free;
      end;
  finally
    slTemp.Free;
  end;
  SetReady;
end;

procedure TMainForm.Action_DB_UsersExecute(Sender: TObject);
begin
  SetBusy;
  LogThis('Попытка открытия окна списка пользователей...', lmtInfo);
  with TUsersForm.Create(Owner) do
    try
      ImageList2.GetIcon(4, Icon);
      { TODO : Загрузка текущей конфигурации и инициализация значений контролов }
      btnHelp.Enabled:=Application.HelpFile<>'';
      ShowModal;
    finally
      { TODO : Считывание значений контролов и запись конфигурации при mrOk }
      Free;
    end;
  SetReady;
end;

procedure TMainForm.SetBusy;
begin
  LogThis('Установлен режим "Занято".', lmtInfo);
  ImageList3.GetIcon(0, Image1.Picture.Icon);
  Application.ProcessMessages;
end;

procedure TMainForm.SetReady;
begin
  LogThis('Установлен режим "Готово".', lmtInfo);
  ImageList3.GetIcon(1, Image1.Picture.Icon);
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Action_RichEditBoldExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      if fsBold in reOwnerOtherInfo.SelAttributes.Style then
        reOwnerOtherInfo.SelAttributes.Style:=reOwnerOtherInfo.SelAttributes.Style-[fsBold]
      else
        reOwnerOtherInfo.SelAttributes.Style:=reOwnerOtherInfo.SelAttributes.Style+[fsBold];
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      if fsBold in reAutoOtherInfo.SelAttributes.Style then
        reAutoOtherInfo.SelAttributes.Style:=reAutoOtherInfo.SelAttributes.Style-[fsBold]
      else
        reAutoOtherInfo.SelAttributes.Style:=reAutoOtherInfo.SelAttributes.Style+[fsBold];
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditBulletsExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      reOwnerOtherInfo.Paragraph.Numbering:=TNumberingStyle(not boolean(reOwnerOtherInfo.Paragraph.Numbering));
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      reAutoOtherInfo.Paragraph.Numbering:=TNumberingStyle(not boolean(reAutoOtherInfo.Paragraph.Numbering));
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditItalicExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      if fsItalic in reOwnerOtherInfo.SelAttributes.Style then
        reOwnerOtherInfo.SelAttributes.Style:=reOwnerOtherInfo.SelAttributes.Style-[fsItalic]
      else
        reOwnerOtherInfo.SelAttributes.Style:=reOwnerOtherInfo.SelAttributes.Style+[fsItalic];
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      if fsItalic in reAutoOtherInfo.SelAttributes.Style then
        reAutoOtherInfo.SelAttributes.Style:=reAutoOtherInfo.SelAttributes.Style-[fsItalic]
      else
        reAutoOtherInfo.SelAttributes.Style:=reAutoOtherInfo.SelAttributes.Style+[fsItalic];
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditLeftAlignExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      reOwnerOtherInfo.Paragraph.Alignment:=taLeftJustify;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      reAutoOtherInfo.Paragraph.Alignment:=taLeftJustify;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditUnderlineExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      if fsUnderline in reOwnerOtherInfo.SelAttributes.Style then
        reOwnerOtherInfo.SelAttributes.Style:=reOwnerOtherInfo.SelAttributes.Style-[fsUnderline]
      else
        reOwnerOtherInfo.SelAttributes.Style:=reOwnerOtherInfo.SelAttributes.Style+[fsUnderline];
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      if fsUnderline in reAutoOtherInfo.SelAttributes.Style then
        reAutoOtherInfo.SelAttributes.Style:=reAutoOtherInfo.SelAttributes.Style-[fsUnderline]
      else
        reAutoOtherInfo.SelAttributes.Style:=reAutoOtherInfo.SelAttributes.Style+[fsUnderline];
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditCenterAlignExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      reOwnerOtherInfo.Paragraph.Alignment:=taCenter;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      reAutoOtherInfo.Paragraph.Alignment:=taCenter;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditCopyExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    if ActiveControl=reOwnerOtherInfo then
      reOwnerOtherInfo.CopyToClipboard;
  if PageControl1.ActivePage=tsAuto then
    if ActiveControl=reAutoOtherInfo then
      reAutoOtherInfo.CopyToClipboard;
end;

procedure TMainForm.Action_RichEditCutExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    if ActiveControl=reOwnerOtherInfo then
      reOwnerOtherInfo.CutToClipboard;
  if PageControl1.ActivePage=tsAuto then
    if ActiveControl=reAutoOtherInfo then
      reAutoOtherInfo.CutToClipboard;
end;

procedure TMainForm.Action_RichEditDecreaseFontExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    reOwnerOtherInfo.SelAttributes.Size:=reOwnerOtherInfo.SelAttributes.Size-1;
  if PageControl1.ActivePage=tsAuto then
    reAutoOtherInfo.SelAttributes.Size:=reAutoOtherInfo.SelAttributes.Size-1;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditDefaultFormatExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      SetDefaultSettings(reOwnerOtherInfo);
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      SetDefaultSettings(reAutoOtherInfo);
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditEnlargeFontExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      reOwnerOtherInfo.SelAttributes.Size:=reOwnerOtherInfo.SelAttributes.Size+1;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      reAutoOtherInfo.SelAttributes.Size:=reAutoOtherInfo.SelAttributes.Size+1;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditEraseExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    if ActiveControl=reOwnerOtherInfo then
      reOwnerOtherInfo.Perform(WM_CLEAR, 0, 0);
  if PageControl1.ActivePage=tsAuto then
    if ActiveControl=reAutoOtherInfo then
      reAutoOtherInfo.Perform(WM_CLEAR, 0, 0);
end;

procedure TMainForm.Action_RichEditFormatBySampleExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      if Action_RichEditFormatBySample.Checked then
        begin
          Action_RichEditFormatBySample.Checked:=False;
        end
      else
        begin
          ParaAttr.Alignment:=reOwnerOtherInfo.Paragraph.Alignment;
          ParaAttr.FirstIndent:=reOwnerOtherInfo.Paragraph.FirstIndent;
          ParaAttr.LeftIndent:=reOwnerOtherInfo.Paragraph.LeftIndent;
          ParaAttr.Numbering:=reOwnerOtherInfo.Paragraph.Numbering;
          ParaAttr.RightIndent:=reOwnerOtherInfo.Paragraph.RightIndent;
          ParaAttr.TabCount:=reOwnerOtherInfo.Paragraph.TabCount;
          TextAttr.Charset:=reOwnerOtherInfo.SelAttributes.Charset;
          TextAttr.Color:=reOwnerOtherInfo.SelAttributes.Color;
          TextAttr.name:=reOwnerOtherInfo.SelAttributes.name;
          TextAttr.Pitch:=reOwnerOtherInfo.SelAttributes.Pitch;
          TextAttr.Size:=reOwnerOtherInfo.SelAttributes.Size;
          TextAttr.Style:=reOwnerOtherInfo.SelAttributes.Style;
          TextAttr.Height:=reOwnerOtherInfo.SelAttributes.Height;
          Action_RichEditFormatBySample.Checked:=True;
        end;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      if Action_RichEditFormatBySample.Checked then
        begin
          Action_RichEditFormatBySample.Checked:=False;
        end
      else
        begin
          ParaAttr.Alignment:=reAutoOtherInfo.Paragraph.Alignment;
          ParaAttr.FirstIndent:=reAutoOtherInfo.Paragraph.FirstIndent;
          ParaAttr.LeftIndent:=reAutoOtherInfo.Paragraph.LeftIndent;
          ParaAttr.Numbering:=reAutoOtherInfo.Paragraph.Numbering;
          ParaAttr.RightIndent:=reAutoOtherInfo.Paragraph.RightIndent;
          ParaAttr.TabCount:=reAutoOtherInfo.Paragraph.TabCount;
          TextAttr.Charset:=reAutoOtherInfo.SelAttributes.Charset;
          TextAttr.Color:=reAutoOtherInfo.SelAttributes.Color;
          TextAttr.name:=reAutoOtherInfo.SelAttributes.name;
          TextAttr.Pitch:=reAutoOtherInfo.SelAttributes.Pitch;
          TextAttr.Size:=reAutoOtherInfo.SelAttributes.Size;
          TextAttr.Style:=reAutoOtherInfo.SelAttributes.Style;
          TextAttr.Height:=reAutoOtherInfo.SelAttributes.Height;
          Action_RichEditFormatBySample.Checked:=True;
        end;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditPasteExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    if ActiveControl=reOwnerOtherInfo then
      reOwnerOtherInfo.PasteFromClipboard;
  if PageControl1.ActivePage=tsAuto then
    if ActiveControl=reAutoOtherInfo then
      reAutoOtherInfo.PasteFromClipboard;
end;

procedure TMainForm.Action_RichEditSelectAllExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    if ActiveControl=reOwnerOtherInfo then
      reOwnerOtherInfo.SelectAll;
  if PageControl1.ActivePage=tsAuto then
    if ActiveControl=reAutoOtherInfo then
      reAutoOtherInfo.SelectAll;
end;

procedure TMainForm.Action_RichEditSetTextColorExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      reOwnerOtherInfo.SelAttributes.Color:=clInfo;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      reAutoOtherInfo.SelAttributes.Color:=clInfo;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditUndoExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    if ActiveControl=reOwnerOtherInfo then
      reOwnerOtherInfo.Undo;
  if PageControl1.ActivePage=tsAuto then
    if ActiveControl=reAutoOtherInfo then
      reAutoOtherInfo.Undo;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.btnOwnerPhonesClick(Sender: TObject);
begin
  // SetBusy;
  // LogThis('Попытка открытия окна списка телефонов организации...',lmtInfo);
  // with TPhonesForm.Create(Owner) do
  // try
  // ImageList2.GetIcon(19,Icon);
  // Caption:='GAIDB - Список телефонов организации';
  // Hint:='Окно просмотра списка телефонов организации';
  // pnlID.Visible:=Configuration.bShowID;
  // btnHelp.Enabled:=Application.HelpFile<>'';
  // btnCreate.Visible:=CurrentUser.bDBEdition;
  // btnEdit.Visible:=CurrentUser.bDBEdition;
  // btnErase.Visible:=CurrentUser.bDBEdition;
  // lvPhones.Column[0].Width:=-2;
  // lvPhones.Column[1].Width:=-2;
  // lvPhones.Column[2].Width:=-2;
  // lvPhones.Column[3].Width:=-2;
  // lvPhones.Column[4].Width:=-2;
  // ShowModal;
  // finally
  // { TODO : Считывание значений контролов и запись конфигурации при mrOk }
  // Free;
  // end;
  // SetReady;
end;

procedure TMainForm.btnMsrPhonesClick(Sender: TObject);
begin
  // SetBusy;
  // LogThis('Попытка открытия окна списка телефонов мероприятия...',lmtInfo);
  // with TPhonesForm.Create(Owner) do
  // try
  // ImageList2.GetIcon(19,Icon);
  // Caption:='GAIDB - Список телефонов мероприятия';
  // Hint:='Окно просмотра списка телефонов мероприятия';
  // pnlID.Visible:=Configuration.bShowID;
  // btnHelp.Enabled:=Application.HelpFile<>'';
  // btnCreate.Visible:=CurrentUser.bDBEdition;
  // btnEdit.Visible:=CurrentUser.bDBEdition;
  // btnErase.Visible:=CurrentUser.bDBEdition;
  // lvPhones.Column[0].Width:=-2;
  // lvPhones.Column[1].Width:=-2;
  // lvPhones.Column[2].Width:=-2;
  // lvPhones.Column[3].Width:=-2;
  // lvPhones.Column[4].Width:=-2;
  // ShowModal;
  // finally
  // { TODO : Считывание значений контролов и запись конфигурации при mrOk }
  // Free;
  // end;
  // SetReady;
end;

procedure TMainForm.chkbxStartDateClick(Sender: TObject);
begin
  // dtpStartDate.Enabled:=chkbxStartDate.Checked;
end;

procedure TMainForm.chkbxStopDateClick(Sender: TObject);
begin
  // dtpStopDate.Enabled:=chkbxStopDate.Checked;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  a: ATOM;
  b: boolean;
begin
  SetBusy;
  b:=False;
  CanClose:=False;
  if not Configuration.bImmediatelyQuit then
    b:=MessageBox(Handle, PChar('Вы действительно хотите завершить работу программы?'), PChar('GAIDB - Подтверждение выхода'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK;
  if (Configuration.bImmediatelyQuit or b) then
    begin
      if Action_DB_Disconnection.Visible then
        Action_DB_Disconnection.Execute;
      CanClose:=True;
    end;
  if CanClose then
    begin
      SaveConfigIni;
      // отправка сообщения программе Log Server о том, что было инициировано нормальное завершение работы
      a:=GlobalAddAtom('GAIDBNormalShutdown');
      if a=0 then
        begin
          LogThis('Возникла ошибка при создании атома "GAIDBNormalShutdown"!', lmtError);
        end;
      LogThis('Завершение работы программы.', lmtInfo);
    end;
  SetReady;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  s: string;
  i: integer;
  PanelRect: TRect;
  ThisYear, ThisMonth, ThisDay: word;
begin
  lvOwners.DoubleBuffered:=True;
  lvAutos.DoubleBuffered:=True;

  // инициализация элементов списка
  cmbbxAutoYearOfEdition.Clear;
  cmbbxAutoYearOfEdition.Items.Add('');
  DecodeDate(Now(), ThisYear, ThisMonth, ThisDay);
  for i:=1900 to ThisYear do
    cmbbxAutoYearOfEdition.Items.Add(IntToStr(i));

  LoadConfigIni;
  with MainForm.Constraints do
    begin
      MaxWidth:=0;
      MaxHeight:=0;
    end;
  if Configuration.bSetCustomMainFormSizes then
    begin
      MainForm.Width:=Configuration.iCustomMainFormWidth;
      MainForm.Height:=Configuration.iCustomMainFormHeight;
    end;
  if Configuration.bFullScreen then
    MainForm.WindowState:=wsMaximized;
  if Configuration.bSaveSize then
    MainForm.BoundsRect:=Configuration.MainFormRect;
  if FileExists(Configuration.sCustomHelpFile) then
    Application.HelpFile:=Configuration.sCustomHelpFile;
  if Configuration.bNoToolBar then
    begin
      miToolbar.Checked:=False;
      ActionToolBar1.Visible:=miToolbar.Checked;
    end;
  if Configuration.bNoStatusBar then
    begin
      miStatusbar.Checked:=False;
      StatusBar1.Visible:=miStatusbar.Checked;
    end;
  Configuration.bLogged:=False;
  blvOwnerRedrawNow:=False; // перерисовка окна результатов поиска отключена
  blvAutoRedrawNow:=False; // перерисовка окна результатов поиска отключена
  clInfo:=clRed;
  SessionLogEventCount:=0; // инициализация счётчика лога
  LogThis('Начало работы программы.', lmtInfo);
  SetBusy;
  THackControl(ProgressBar1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
  ProgressBar1.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right-PanelRect.Left, PanelRect.Bottom-PanelRect.Top);
  THackControl(Image1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
  Image1.SetBounds(PanelRect.Left+1, PanelRect.Top+1, PanelRect.Right-PanelRect.Left+1, PanelRect.Bottom-PanelRect.Top+1);
  gsFileVersionInfo1.Filename:=Application.ExeName;

  bParamNoLogo:=False;

  if ParamCount>0 then
    for i:=1 to ParamCount do
      begin
        s:=UpperCase(ParamStr(i));
        if s='/NOLOGO' then
          begin
            bParamNoLogo:=True;
            LogThis('В командной строке указан параметр "/NOLOGO",'+' отключающий вывод окна "О программе..." при запуске программы.', lmtInfo);
          end;
        if s='/SHOWID' then
          begin
            bParamShowID:=True;
            LogThis('В командной строке указан параметр "/SHOWID",'+' включающий отображение ID записей базы данных при работе программы.', lmtInfo);
          end;
      end;
  if not(bParamNoLogo or Configuration.bNoLogo) then
    begin
      with TAboutForm.Create(Self) do
        try
          Button1.Visible:=False;
          Timer1.Enabled:=True;
          AlphaBlendValue:=0;
          Timer2.Enabled:=True;
          s:=gsFileVersionInfo1.FileVersion;
          i:=LastDelimiter('.', s);
          s:=copy(s, 1, i-1);
          Label2.Caption:=Format('Версия %s билд %s', [s, gsFileVersionInfo1.GetBuildOnly]);
          Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
          LogThis('Окно "О программе..." показано.', lmtInfo);
          ShowModal;
        finally
          Free;
          LogThis('Окно "О программе..." скрыто.', lmtInfo);
        end;
    end;
  pnlID.Visible:=Configuration.bShowID;
  Update_Actions;
  if Configuration.bAutoLogon then
    begin
      if not Configuration.bLogged then
        Action_DB_Connection.Execute;
    end;
  SetReady;
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
var
  mr: TModalResult;
  i: integer;
  bError: boolean;
begin
  SetBusy;
  bError:=False;
  LogThis('Попытка открытия окна конфигурации программы...', lmtInfo);
  with TOptionsForm.Create(Owner) do
    try
      Screen.Cursor:=crHourGlass;
      // настройка компонентов интерфейса
      ImageList2.GetIcon(3, Icon);
      btnHelp.Enabled:=Application.HelpFile<>'';
      // выставление значений компонентов в соответствии с текущей конфигурацией
      chkbxStoreLastLogin.Checked:=Configuration.bStoreLastLogin;
      chkbxStoreLastPassword.Enabled:=chkbxStoreLastLogin.Checked;
      chkbxStoreLastPassword.Checked:=chkbxStoreLastLogin.Enabled and Configuration.bStoreLastPassword;
      chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Checked;
      chkbxAutoLogon.Checked:=chkbxStoreLastLogin.Enabled and chkbxStoreLastPassword.Checked and Configuration.bAutoLogon;
      chkbxNoToolBar.Checked:=Configuration.bNoToolBar;
      chkbxNoStatusBar.Checked:=Configuration.bNoStatusBar;
      chkbxShowFullSearchBar.Checked:=Configuration.bShowFullSearchBar;
      chkbxStartMainRect.Checked:=Configuration.bSetCustomMainFormSizes;
      edbxMainFormWidth.Text:=IntToStr(Configuration.iCustomMainFormWidth);
      edbxMainFormHeight.Text:=IntToStr(Configuration.iCustomMainFormHeight);
      edbxMainFormWidth.Enabled:=chkbxStartMainRect.Checked;
      edbxMainFormHeight.Enabled:=chkbxStartMainRect.Checked;
      chkbxStartupFullScreen.Checked:=Configuration.bFullScreen;
      chkbxCustomLogClientFile.Checked:=Configuration.sCustomLogClientFile<>'';
      edbxCustomLogClientFile.Text:=Configuration.sCustomLogClientFile;
      edbxCustomLogClientFile.Enabled:=chkbxCustomLogClientFile.Checked;
      btnChoiseCustomLogClientFile.Enabled:=chkbxCustomLogClientFile.Checked;
      chkbxSaveSize.Checked:=Configuration.bSaveSize;
      edbxMySQLHost.Text:=Configuration.sMySQLHost;
      edbxMySQLHost.Enabled:=not Configuration.bLogged;
      edbxMySQLPort.Text:=IntToStr(Configuration.iMySQLPort);
      edbxMySQLPort.Enabled:=not Configuration.bLogged;
      edbxMySQLTimeout.Text:=IntToStr(Configuration.iMySQLTimeout);
      edbxMySQLTimeout.Enabled:=not Configuration.bLogged;
      chkbxMySQLCompress.Checked:=Configuration.bMySQLCompress;
      chkbxMySQLCompress.Enabled:=not Configuration.bLogged;
      edbxMySQLDatabase.Text:=Configuration.sMySQLDatabase;
      edbxMySQLDatabase.Enabled:=not Configuration.bLogged;
      edbxMySQLUser.Text:=Configuration.sMySQLUser;
      edbxMySQLUser.Enabled:=not Configuration.bLogged;
      edbxMySQLPassword.Text:=Configuration.sMySQLPassword;
      edbxMySQLPassword.Enabled:=not Configuration.bLogged;
      chkbxNoLogo.Checked:=Configuration.bNoLogo or bParamNoLogo;
      chkbxNoLogo.Enabled:=not bParamNoLogo;
      chkbxShowID.Checked:=Configuration.bShowID or bParamShowID;
      chkbxShowID.Enabled:=not bParamShowID;
      chkbxCustomHelpFile.Checked:=Configuration.sCustomHelpFile<>'';
      edbxCustomHelpFile.Text:=Configuration.sCustomHelpFile;
      edbxCustomHelpFile.Enabled:=chkbxCustomHelpFile.Checked;
      btnChoiseCustomHelpFile.Enabled:=chkbxCustomHelpFile.Checked;
      sgAutoReplaceList.Visible:=Configuration.bLogged and CurrentUser.bDBEdition;
      lblAutoReplaceSorry.Visible:=not(Configuration.bLogged and CurrentUser.bDBEdition);
      // загрузка списка автозамены из базы данных
      for i:=0 to sgAutoReplaceList.RowCount-1 do
        sgAutoReplaceList.Rows[i].Clear;
      sgAutoReplaceList.Cells[1, 0]:='Исходная строка';
      sgAutoReplaceList.Cells[2, 0]:='Конечная строка';
      Screen.Cursor:=crDefault;
      if bError=False then
        ShowModal;
      { TODO : Загрузка текущей конфигурации и инициализация значений контролов }
    finally
      { TODO : Считывание значений контролов и запись конфигурации при mrOk }
      mr:=ModalResult;
      if mr=mrOk then
        begin
          Screen.Cursor:=crHourGlass;
          Configuration.bStoreLastLogin:=chkbxStoreLastLogin.Checked and chkbxStoreLastLogin.Enabled;
          Configuration.bStoreLastPassword:=chkbxStoreLastPassword.Checked and chkbxStoreLastPassword.Enabled;
          Configuration.bAutoLogon:=chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
          Configuration.bNoToolBar:=chkbxNoToolBar.Checked and chkbxNoToolBar.Enabled;
          Configuration.bNoStatusBar:=chkbxNoStatusBar.Checked and chkbxNoStatusBar.Enabled;
          Configuration.bShowFullSearchBar:=chkbxShowFullSearchBar.Checked and chkbxShowFullSearchBar.Enabled;
          UpdateSearchBar;
          Configuration.bSetCustomMainFormSizes:=chkbxStartMainRect.Checked and chkbxStartMainRect.Enabled;
          if Configuration.bSetCustomMainFormSizes then
            begin
              if edbxMainFormWidth.Enabled then
                Configuration.iCustomMainFormWidth:=StrToIntDef(edbxMainFormWidth.Text, DEFAULT_MAINFORMWIDTH);
              if edbxMainFormHeight.Enabled then
                Configuration.iCustomMainFormHeight:=StrToIntDef(edbxMainFormHeight.Text, DEFAULT_MAINFORMHEIGHT);
            end;
          Configuration.bFullScreen:=chkbxStartupFullScreen.Checked and chkbxStartupFullScreen.Enabled;
          if chkbxCustomHelpFile.Checked and FileExists(edbxCustomHelpFile.Text) then
            Configuration.sCustomHelpFile:=edbxCustomHelpFile.Text
          else
            Configuration.sCustomHelpFile:='';
          Configuration.bSaveSize:=chkbxSaveSize.Checked and chkbxSaveSize.Enabled;
          if edbxMySQLHost.Text<>'' then
            Configuration.sMySQLHost:=edbxMySQLHost.Text;
          if edbxMySQLPort.Text<>'' then
            Configuration.iMySQLPort:=StrToIntDef(edbxMySQLPort.Text, 3306);
          if edbxMySQLTimeout.Text<>'' then
            Configuration.iMySQLTimeout:=StrToIntDef(edbxMySQLTimeout.Text, 30);
          Configuration.bMySQLCompress:=chkbxMySQLCompress.Checked;
          if edbxMySQLDatabase.Text<>'' then
            Configuration.sMySQLDatabase:=edbxMySQLDatabase.Text;
          Configuration.sMySQLDatabase:=edbxMySQLDatabase.Text;
          Configuration.sMySQLUser:=edbxMySQLUser.Text;
          Configuration.sMySQLPassword:=edbxMySQLPassword.Text;
          Configuration.bNoLogo:=chkbxNoLogo.Checked and chkbxNoLogo.Enabled;
          Configuration.bShowID:=chkbxShowID.Checked and chkbxShowID.Enabled;
          pnlID.Visible:=Configuration.bShowID;
          if chkbxCustomLogClientFile.Checked and FileExists(edbxCustomLogClientFile.Text) then
            Configuration.sCustomLogClientFile:=edbxCustomLogClientFile.Text
          else
            Configuration.sCustomLogClientFile:='';
          // if sgAutoReplaceList.Visible then
          // begin
          // LogThis('Попытка очистки списка автозамены...',lmtInfo);
          // q:='DELETE FROM _autoreplace;';
          // LogThis(q,lmtSQL);
          // i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          // if i=0 then
          // begin
          // LogThis('Очистка списка автозамены произведена успешно.',lmtInfo);
          // // запись нового списка автозамены в базу данных
          // k:=0;
          // ProgressBar1.Position:=ProgressBar1.Min;
          // ProgressBar1.Max:=i;
          // ProgressBar1.Step:=1;
          // for j:=1 to sgAutoReplaceList.RowCount-1 do
          // begin
          // if (sgAutoReplaceList.Cells[1,j]<>'') and (sgAutoReplaceList.Cells[2,j]<>'') then
          // begin
          // k:=k+1;
          // q:='INSERT INTO _autoreplace VALUES ('+IntToStr(k)+', "'+sgAutoReplaceList.Cells[1,j]+'", "'+sgAutoReplaceList.Cells[2,j]+'")';
          // LogThis(q,lmtSQL);
          // i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          // if i=0 then
          // begin
          // LogThis('Запрос выполнен успешно.',lmtInfo);
          // i:=mysql_affected_rows(MySQLConnectionHandler);
          // if i=1 then
          // begin
          // LogThis('Количество строк выборки соответствует требуемому.',lmtInfo);
          // LogThis('Элемент списка автозамены номер '+IntToStr(k)+' успешно сохранён в таблице БД.',lmtInfo);
          // end
          // else
          // begin
          // s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
          // bError:=True;
          // end
          // end
          // else
          // begin
          // s:='Возникла ошибка при выполнении запроса!';
          // bError:=True;
          // end;
          // end;
          // ProgressBar1.StepIt;
          // end;
          // end
          // else
          // begin
          // s:='Возникла ошибка при очистке списка автозамены!';
          // bError:=True;
          // end;
          // if bError then
          // begin
          // LogThis(s,lmtError);
          // Screen.Cursor:=crDefault;
          // MessageBox(Handle,PChar(s),PChar('GAIDB - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          // end;
          // end;
          SaveConfigIni;
          ProgressBar1.Position:=ProgressBar1.Min;
        end;
      Free;
    end;
  Screen.Cursor:=crDefault;
  SetReady;
end;

procedure TMainForm.lvAutosCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  D: TDate;
  T: TTime;
  DT, DT2: TDateTime;
  Day, Month, Year: word;

begin
  if Item<>nil then
    begin
      if (Item.SubItems[1]>'')and(Length(Item.SubItems[1])=19) then
        begin
          D:=EncodeDate(StrToInt(Copy(Item.SubItems[1], 0, 4)), StrToInt(Copy(Item.SubItems[1], 6, 2)), StrToInt(Copy(Item.SubItems[1], 9, 2)));
          T:=StrToTime(Copy(Item.SubItems[1], 11, 9));
          DT:=D+T;
          DecodeDate(Now, Year, Month, Day);
          DT2:=EncodeDate(Year, Month, Day);
          if DT<DT2 then
            lvAutos.Canvas.Font.Color:=clGrayText
          else
            lvAutos.Canvas.Font.Color:=clWindowText;
        end;
    end;
end;

procedure TMainForm.lvAutosEnter(Sender: TObject);
var
  Item: TListItem;
begin
  if lvAutos.Selected<>nil then
    begin
      Item:=lvAutos.Selected;
      lvAutos.Selected:=nil;
      lvAutos.Selected:=Item;
    end
  else
    begin
      pnlEdit.Visible:=False;
      PageControl1.ActivePage:=tsClear;
    end;
  // pnlEdit.Visible:=(not (PageControl1.ActivePage=tsClear))and CurrentUser.bDBEdition;
end;

procedure TMainForm.lvOwnersCustomDrawSubItem(Sender: TCustomListView; Item: TListItem; SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if Item<>nil then
    begin
      if SubItem=2 then
        begin
          if (Item.SubItems[1]='0')or(Item.SubItems[1]='-') then
            begin
              lvOwners.Canvas.Font.Style:=[];
            end
          else
            begin
              lvOwners.Canvas.Font.Style:=[fsBold];
            end;
        end
      else
        begin
          lvOwners.Canvas.Font.Style:=[];
        end;
    end;
end;

procedure TMainForm.lvOwnersEnter(Sender: TObject);
var
  Item: TListItem;
begin
  if lvOwners.Selected<>nil then
    begin
      Item:=lvOwners.Selected;
      lvOwners.Selected:=nil;
      lvOwners.Selected:=Item;
    end
  else
    begin
      pnlEdit.Visible:=False;
      PageControl1.ActivePage:=tsClear;
    end;
  // pnlEdit.Visible:=(not (PageControl1.ActivePage=tsClear))and CurrentUser.bDBEdition;
end;

procedure TMainForm.lvOwnersKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_RIGHT then
    SendMessage(lvOwners.Handle, WM_HSCROLL, SB_PAGERIGHT, 0);
  if Key=VK_LEFT then
    SendMessage(lvOwners.Handle, WM_HSCROLL, SB_PAGELEFT, 0);
end;

procedure TMainForm.lvOwnersResize(Sender: TObject);
begin
  lvOwners.Column[0].Width:=((lvOwners.ClientWidth-lvOwners.Canvas.TextWidth('00000'))div 2);
  lvOwners.Column[1].Width:=((lvOwners.ClientWidth-lvOwners.Canvas.TextWidth('00000'))div 2);
  lvOwners.Column[2].Width:=lvOwners.Canvas.TextWidth('00000');
  // if (GetWindowLong(lvOwners.Handle,GWL_STYLE) and WS_VSCROLL)=WS_VSCROLL then
  // Label3.Caption:='Vertical scroll CW='+IntToStr(lvOwners.ClientWidth)+' W='+IntToStr(lvOwners.Width)+' 0='+IntToStr(lvOwners.Column[0].Width)+' 1='+IntToStr(lvOwners.Column[1].Width)+' 2='+IntToStr(lvOwners.Column[2].Width)
  // else Label3.Caption:='No Vertical scroll CW='+IntToStr(lvOwners.ClientWidth)+' W='+IntToStr(lvOwners.Width)+' 0='+IntToStr(lvOwners.Column[0].Width)+' 1='+IntToStr(lvOwners.Column[1].Width)+' 2='+IntToStr(lvOwners.Column[2].Width);
end;

procedure TMainForm.LoadConfigIni;
var
  IniFile: TIniFile;
begin
  IniFile:=TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'GAIDB.ini');
  with IniFile do
    try
      Configuration.bStoreLastLogin:=ReadBool('Интерфейс', 'bStoreLastLogin', False);
      Configuration.sLastLogin:=ReadString('Интерфейс', 'sLastLogin', '');
      Configuration.bStoreLastPassword:=ReadBool('Интерфейс', 'bStoreLastPassword', False);
      Configuration.sLastPassword:=ReadString('Интерфейс', 'sLastPassword', '');
      Configuration.bAutoLogon:=ReadBool('Интерфейс', 'bAutoLogon', False);
      Configuration.bShowFullSearchBar:=ReadBool('Интерфейс', 'bShowFullSearchBar', False);
      Configuration.bNoToolBar:=ReadBool('Интерфейс', 'bNoToolBar', False);
      Configuration.bNoStatusBar:=ReadBool('Интерфейс', 'bNoStatusBar', False);
      Configuration.bSetCustomMainFormSizes:=ReadBool('Интерфейс', 'bSetCustomMainFormSizes', False);
      Configuration.iCustomMainFormWidth:=ReadInteger('Интерфейс', 'iCustomMainFormWidth', 1024);
      Configuration.iCustomMainFormHeight:=ReadInteger('Интерфейс', 'iCustomMainFormHeight', 768);
      Configuration.bSaveSize:=ReadBool('Интерфейс', 'bSaveSize', False);
      Configuration.MainFormRect.Left:=ReadInteger('Интерфейс', 'iMainFormLeft', Screen.DesktopRect.Left);
      Configuration.MainFormRect.Top:=ReadInteger('Интерфейс', 'iMainFormTop', Screen.DesktopRect.Top);
      Configuration.MainFormRect.Right:=ReadInteger('Интерфейс', 'iMainFormRight', Screen.DesktopRect.Right);
      Configuration.MainFormRect.Bottom:=ReadInteger('Интерфейс', 'iMainFormBottom', Screen.DesktopRect.Bottom);
      Configuration.bFullScreen:=ReadBool('Интерфейс', 'bFullScreen', False);
      Configuration.sMySQLHost:=ReadString('Сервер и база данных', 'sMySQLHost', '');
      Configuration.iMySQLPort:=ReadInteger('Сервер и база данных', 'iMySQLPort', MYSQL_PORT);
      Configuration.iMySQLTimeout:=ReadInteger('Сервер и база данных', 'iMySQLTimeout', 30);
      Configuration.bMySQLCompress:=ReadBool('Сервер и база данных', 'bMySQLCompress', True);
      Configuration.sMySQLDatabase:=ReadString('Сервер и база данных', 'sMySQLDatabase', '');
      Configuration.sMySQLUser:=ReadString('Сервер и база данных', 'sMySQLUser', '');
      Configuration.sMySQLPassword:=ReadString('Сервер и база данных', 'sMySQLPassword', '');
      Configuration.bNoLogo:=ReadBool('Прочее', 'bNoLogo', False);
      Configuration.bShowID:=ReadBool('Прочее', 'bShowID', False);
      Configuration.sCustomHelpFile:=ReadString('Прочее', 'sCustomHelpFile', '');
      Configuration.sCustomLogClientFile:=ReadString('Лог-клиент', 'sCustomLogClientFile', '');
    finally
      Free;
    end;
  LogThis('Процесс чтения конфигурации завершен.', lmtInfo);
end;

procedure TMainForm.SaveConfigIni;
var
  IniFile: TIniFile;
begin
  LogThis('Производится запись конфигурации...', lmtInfo);
  IniFile:=TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'GAIDB.ini');
  with IniFile do
    try
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
      WriteBool('Интерфейс', 'bShowFullSearchBar', Configuration.bShowFullSearchBar);
      WriteBool('Интерфейс', 'bNoToolBar', Configuration.bNoToolBar);
      WriteBool('Интерфейс', 'bNoStatusBar', Configuration.bNoStatusBar);
      WriteBool('Интерфейс', 'bSetCustomMainFormSizes', Configuration.bSetCustomMainFormSizes);
      WriteInteger('Интерфейс', 'iCustomMainFormWidth', Configuration.iCustomMainFormWidth);
      WriteInteger('Интерфейс', 'iCustomMainFormHeight', Configuration.iCustomMainFormHeight);
      WriteBool('Интерфейс', 'bSaveSize', Configuration.bSaveSize);
      Configuration.MainFormRect:=MainForm.GetClientRect;
      WriteInteger('Интерфейс', 'iMainFormLeft', Configuration.MainFormRect.Left);
      WriteInteger('Интерфейс', 'iMainFormTop', Configuration.MainFormRect.Top);
      WriteInteger('Интерфейс', 'iMainFormRight', Configuration.MainFormRect.Right);
      WriteInteger('Интерфейс', 'iMainFormBottom', Configuration.MainFormRect.Bottom);
      WriteBool('Интерфейс', 'bFullScreen', Configuration.bFullScreen);
      WriteString('Сервер и база данных', 'sMySQLHost', Configuration.sMySQLHost);
      WriteString('Сервер и база данных', 'sMySQLHost', Configuration.sMySQLHost);
      WriteInteger('Сервер и база данных', 'iMySQLPort', Configuration.iMySQLPort);
      WriteInteger('Сервер и база данных', 'iMySQLTimeout', Configuration.iMySQLTimeout);
      WriteBool('Сервер и база данных', 'bMySQLCompress', Configuration.bMySQLCompress);
      WriteString('Сервер и база данных', 'sMySQLDatabase', Configuration.sMySQLDatabase);
      WriteString('Сервер и база данных', 'sMySQLUser', Configuration.sMySQLUser);
      WriteString('Сервер и база данных', 'sMySQLPassword', Configuration.sMySQLPassword);
      WriteBool('Прочее', 'bNoLogo', Configuration.bNoLogo);
      WriteBool('Прочее', 'bShowID', Configuration.bShowID);
      WriteString('Прочее', 'sCustomHelpFile', Configuration.sCustomHelpFile);
      if FileExists(Configuration.sCustomHelpFile) then
        Application.HelpFile:=Configuration.sCustomHelpFile;
      WriteString('Лог-клиент', 'sCustomLogClientFile', Configuration.sCustomLogClientFile);
    finally
      Free;
    end;
  LogThis('Процесс записи конфигурации завершен.', lmtInfo);
end;

procedure TMainForm.Action_HelpContentExecute(Sender: TObject);
begin
  SetBusy;
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    begin
      LogThis('Открыто окно оглавления справки.', lmtInfo);
      Application.HelpContext(0);
    end
  else
    begin
      LogThis('Файл правки к программе не найден!', lmtError);
      MessageBox(Handle, PChar('Извините, справочный файл к данной программе не найден.'), PChar('Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.Action_PostMessageExecute(Sender: TObject);
var
  mr: TModalResult;
  s, q: string;
  bError: boolean;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  TSL: TStringList;
  RTFStream: TMemoryStream;
  pacCaption, pacText: PAnsiChar;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  bError:=False;
  ResultSet:=nil;
  pacCaption:=nil;
  pacText:=nil;
  LogThis('Попытка открытия окна отправки сообщения...', lmtInfo);
  with TCreateViewPostForm.Create(Owner) do
    try
      ImageList2.GetIcon(18, Icon);
      Caption:='GAIDB - Новое сообщение';
      Hint:='Окно отправки сообщения';
      pnlID.Visible:=False;
      lblTo.Visible:=True;
      cmbbxTo.Visible:=True;
      edbxCaption.readonly:=False;
      meMessage.readonly:=False;
      pnlCreation.Visible:=False;
      btnClear.Visible:=True;
      btnProcess.Visible:=False;
      btnErase.Visible:=False;
      btnPrevious.Visible:=False;
      btnNext.Visible:=False;
      btnSend.Visible:=True;
      btnHelp.Enabled:=Application.HelpFile<>'';
      ActiveControl:=edbxCaption;
      cmbbxTo.Clear;
      // получение списка пользователей
      LogThis('Получение списка пользователей...', lmtInfo);
      q:='SELECT usr_fullname FROM _usr WHERE usr_erased="0" GROUP BY usr_fullname ORDER BY usr_fullname;';
      LogThis(q, lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
      if i=0 then
        begin
          LogThis('Запрос выполнен успешно.', lmtInfo);
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              LogThis('Результирующая выборка получена успешно.', lmtInfo);
              i:=mysql_num_rows(ResultSet);
              if i>0 then
                begin
                  LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                  ProgressBar1.Max:=i;
                  ProgressBar1.Step:=1;
                  for j:=0 to i-1 do
                    begin
                      LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', lmtInfo);
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', lmtInfo);
                          cmbbxTo.Items.Add(ResultRow[0]);
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                          bError:=True;
                        end;
                      ProgressBar1.StepIt;
                    end;
                end
              else
                begin
                  s:='В системе не зарегестрироывано ни одного пользователя!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
      if ResultSet<>nil then
        begin
          LogThis('Освобождение ресурсов, занятых результатом выборки.', lmtInfo);
          mysql_free_result(ResultSet);
        end;
      ProgressBar1.Position:=ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          LogThis(s, lmtError);
          MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else
        LogThis('Список пользователей получен успешно...', lmtInfo);
      if bError=False then
        begin
          cmbbxTo.Items.Add('[ группа администраторов ]');
          cmbbxTo.Items.Add('[ группа операторов ]');
          cmbbxTo.Items.Add('[ группа пользователей ]');
          ShowModal;
        end;
    finally
      mr:=ModalResult;
      if mr=mrOk then
        begin
          // определение id пользователя
          TSL:=TStringList.Create;
          try
            Screen.Cursor:=crHourGlass;
            if ((cmbbxTo.Text='[ группа администраторов ]')or(cmbbxTo.Text='[ группа операторов ]')or(cmbbxTo.Text='[ группа пользователей ]')) then
              begin
                if cmbbxTo.Text='[ группа администраторов ]' then
                  begin
                    LogThis('Получение списка идентификаторов администраторов...', lmtInfo);
                    q:='SELECT usr_id FROM _usr WHERE usr_erased="0" and usr_is_admin="1" GROUP BY usr_id ORDER BY usr_id;';
                  end;
                if cmbbxTo.Text='[ группа операторов ]' then
                  begin
                    LogThis('Получение списка идентификаторов операторов...', lmtInfo);
                    q:='SELECT usr_id FROM _usr WHERE usr_erased="0" and usr_can_edit_db="1" GROUP BY usr_id ORDER BY usr_id;';
                  end;
                if cmbbxTo.Text='[ группа пользователей ]' then
                  begin
                    LogThis('Получение списка идентификаторов пользователей...', lmtInfo);
                    q:='SELECT usr_id FROM _usr WHERE usr_erased="0" and usr_is_admin="0" GROUP BY usr_id ORDER BY usr_id;';
                  end;
              end
            else
              begin
                LogThis('Получение идентификатора указанного пользователя...', lmtInfo);
                q:='SELECT usr_id FROM _usr WHERE usr_fullname="'+cmbbxTo.Text+'" ORDER BY usr_id;';
              end;
            LogThis(q, lmtSQL);
            i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
            if i=0 then
              begin
                LogThis('Запрос выполнен успешно.', lmtInfo);
                ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                if ResultSet<>nil then
                  begin
                    LogThis('Результирующая выборка получена успешно.', lmtInfo);
                    i:=mysql_num_rows(ResultSet);
                    if i>0 then
                      begin
                        LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                        ProgressBar1.Max:=i;
                        ProgressBar1.Step:=1;
                        for j:=0 to i-1 do
                          begin
                            LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              begin
                                LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', lmtInfo);
                                TSL.Add(ResultRow[0]);
                              end
                            else
                              begin
                                s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                                bError:=True;
                              end;
                            ProgressBar1.StepIt;
                          end;
                      end
                    else
                      begin
                        s:='В системе не зарегестрироывано ни одного пользователя с такими правами!';
                        bError:=True;
                      end;
                  end
                else
                  begin
                    s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                    bError:=True;
                  end;
              end
            else
              begin
                s:='Возникла ошибка при выполнении запроса!';
                bError:=True;
              end;
            if ResultSet<>nil then
              begin
                LogThis('Освобождение ресурсов, занятых результатом выборки.', lmtInfo);
                mysql_free_result(ResultSet);
              end;
            ProgressBar1.Position:=ProgressBar1.Min;
            Screen.Cursor:=crDefault;
            if bError then
              begin
                LogThis(s, lmtError);
                MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else
              LogThis('Список идентификаторов получен успешно...', lmtInfo);
            // если в списке имеется один и более элемент, то в цикле выполняем запросы
            if not bError then
              begin
                RTFStream:=TMemoryStream.Create;
                try
                  // преобразование темы
                  pacCaption:=GetMemory(Length(edbxCaption.Text)*2+1);
                  mysql_escape_string(pacCaption, PAnsiChar(edbxCaption.Text), Length(edbxCaption.Text));
                  // преобразование сообщения
                  meMessage.Lines.SaveToStream(RTFStream);
                  RTFStream.Seek(0, soFromBeginning);
                  pacText:=GetMemory(RTFStream.Size*2+1);
                  mysql_escape_string(pacText, RTFStream.Memory, RTFStream.Size);
                  ProgressBar1.Max:=TSL.Count;
                  ProgressBar1.Step:=1;
                  for j:=0 to TSL.Count-1 do
                    begin
                      Screen.Cursor:=crHourGlass;
                      // добавление сообщения
                      LogThis('Добавление нового сообщения...', lmtInfo);
                      q:='INSERT INTO _msg (msg_id, msg_erased, msg_processed, msg_for_user_id, '+'msg_caption, msg_text, msg_created_at, msg_created_by_user_id) VALUES '+'(NULL, "0", "0", '+TSL.Strings[j]
                        +', "'+pacCaption+'", "'+pacText+'", Now(), '+CurrentUser.sID+');';
                      LogThis(q, lmtSQL);
                      i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                      if i=0 then
                        begin
                          LogThis('Запрос выполнен успешно.', lmtInfo);
                          i:=mysql_affected_rows(MySQLConnectionHandler);
                          if i=1 then
                            begin
                              LogThis('Количество строк выборки соответствует требуемому.', lmtInfo);
                              LogThis('Сообщение успешно отправлено получателю.', lmtInfo);
                            end
                          else
                            begin
                              s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                              bError:=True;
                            end
                        end
                      else
                        begin
                          s:='Возникла ошибка при выполнении запроса!';
                          bError:=True;
                        end;
                      Screen.Cursor:=crDefault;
                      ProgressBar1.StepIt;
                      if bError then
                        begin
                          LogThis(s, lmtError);
                          MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                        end;
                    end;
                  ProgressBar1.Position:=ProgressBar1.Min;
                finally
                  FreeMemory(pacCaption);
                  FreeMemory(pacText);
                  RTFStream.Free;
                end;
              end;
          finally
            TSL.Free;
          end;
        end;
      Free;
    end;
  SetReady;
end;

procedure TMainForm.Action_ViewMessagesExecute(Sender: TObject);
var
  Node: TListItem;
  s, q: string;
  bError: boolean;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  bError:=False;
  ResultSet:=nil;
  LogThis('Попытка открытия окна списка сообщений...', lmtInfo);
  with TViewPostListForm.Create(Owner) do
    try
      ImageList2.GetIcon(17, Icon);
      Caption:='GAIDB - Список сообщений';
      Hint:='Окно просмотра списка сообщений';
      pnlID.Visible:=Configuration.bShowID;
      btnHelp.Enabled:=Application.HelpFile<>'';
      lvMessages.Clear;
      // получение количества сообщений и заполнения списка
      LogThis('Получение списка пользователей...', lmtInfo);
      q:='SELECT msg_created_at, usr_fullname, msg_caption, msg_id, msg_processed FROM _msg LEFT JOIN _usr ON usr_id=msg_created_by_user_id  WHERE msg_for_user_id="'+CurrentUser.sID+'" AND msg_erased="0" ORDER BY msg_created_at;';
      LogThis(q, lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
      if i=0 then
        begin
          LogThis('Запрос выполнен успешно.', lmtInfo);
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              LogThis('Результирующая выборка получена успешно.', lmtInfo);
              i:=mysql_num_rows(ResultSet);
              if i>=0 then
                begin
                  LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                  ProgressBar1.Max:=i;
                  ProgressBar1.Step:=1;
                  for j:=0 to i-1 do
                    begin
                      LogThis('Получение очередной строки выборки ('+IntToStr(j)+').', lmtInfo);
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.', lmtInfo);
                          Node:=lvMessages.Items.Add;
                          Node.Caption:=ResultRow[0];
                          Node.SubItems.Add(ResultRow[1]);
                          Node.SubItems.Add(ResultRow[2]);
                          Node.SubItems.Add(ResultRow[3]);
                          Node.ImageIndex:=Integer(ResultRow[4]='1');
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(j)+')!';
                          bError:=True;
                        end;
                      ProgressBar1.StepIt;
                    end;
                  lvMessages.Column[0].Width:=-2;
                  lvMessages.Column[1].Width:=-2;
                  lvMessages.Column[2].Width:=-2;
                end
              else
                begin
                  s:='Возникла ошибка при получении количества строк выборки!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
      if ResultSet<>nil then
        begin
          LogThis('Освобождение ресурсов, занятых результатом выборки.', lmtInfo);
          mysql_free_result(ResultSet);
        end;
      ProgressBar1.Position:=ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          LogThis(s, lmtError);
          MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else
        LogThis('Список пользователей получен успешно...', lmtInfo);
      if bError=False then
        ShowModal;
    finally
      Free;
    end;
  SetReady;
end;

procedure TMainForm.cmbbxOwnerStreetDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+cmbbxOwnerStreet.Text+'>.', lmtInfo);
  cmbbxOwnerStreet.Text:=ValidateString(cmbbxOwnerStreet.Text);
  LogThis('Итоговая строки поиска - <'+cmbbxOwnerStreet.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  if (cmbbxOwnerStreet.Text<>'') then
    q:='SELECT psp_street FROM _psp WHERE psp_erased="0" AND UCASE(psp_street) LIKE UCASE("%'+cmbbxOwnerStreet.Text+'%") AND (!ISNULL(psp_street)) GROUP BY psp_street ORDER BY psp_street;'
  else
    q:='SELECT psp_street FROM _psp WHERE psp_erased="0" AND (!ISNULL(psp_street)) GROUP BY psp_street ORDER BY psp_street;';
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              s1:=cmbbxOwnerStreet.Text;
              cmbbxOwnerStreet.Clear;
              cmbbxOwnerStreet.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').', lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      s:=ResultRow[0];
                      cmbbxOwnerStreet.Items.Append(s);
                      LogThis('Полученная строка - <'+s+'>.', lmtInfo);
                    end
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
              cmbbxOwnerStreet.ItemIndex:=cmbbxOwnerStreet.Items.IndexOf(s1);
              cmbbxOwnerStreet.Items.EndUpdate;
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
    end
  else
    s:='Возникла ошибка при выполнении запроса!';
  if ResultSet<>nil then
    begin
      LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
      mysql_free_result(ResultSet);
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.cmbbxOwnerStreetExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOwnerStreet.Text:=ValidateString(cmbbxOwnerStreet.Text);
end;

procedure TMainForm.cmbbxOwnerTownDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+cmbbxOwnerTown.Text+'>.', lmtInfo);
  cmbbxOwnerTown.Text:=ValidateString(cmbbxOwnerTown.Text);
  LogThis('Итоговая строки поиска - <'+cmbbxOwnerTown.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  if (cmbbxOwnerTown.Text<>'') then
    q:='SELECT psp_town FROM _psp WHERE psp_erased="0" AND UCASE(psp_town) LIKE UCASE("%'+cmbbxOwnerTown.Text+'%") AND (!ISNULL(psp_town)) GROUP BY psp_town ORDER BY psp_town;'
  else
    q:='SELECT psp_town FROM _psp WHERE psp_erased="0" AND (!ISNULL(psp_town)) GROUP BY psp_town ORDER BY psp_town;';
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              s1:=cmbbxOwnerTown.Text;
              cmbbxOwnerTown.Clear;
              cmbbxOwnerTown.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').', lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      s:=ResultRow[0];
                      cmbbxOwnerTown.Items.Append(s);
                      LogThis('Полученная строка - <'+s+'>.', lmtInfo);
                    end
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
              cmbbxOwnerTown.ItemIndex:=cmbbxOwnerTown.Items.IndexOf(s1);
              cmbbxOwnerTown.Items.EndUpdate;
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
    end
  else
    s:='Возникла ошибка при выполнении запроса!';
  if ResultSet<>nil then
    begin
      LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
      mysql_free_result(ResultSet);
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.cmbbxOwnerTownExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOwnerTown.Text:=ValidateString(cmbbxOwnerTown.Text);
end;

procedure TMainForm.cmbbxOwnerTypeDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+cmbbxOwnerType.Text+'>.', lmtInfo);
  cmbbxOwnerType.Text:=ValidateString(cmbbxOwnerType.Text);
  LogThis('Итоговая строки поиска - <'+cmbbxOwnerType.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  if (cmbbxOwnerType.Text<>'') then
    q:='SELECT psp_type FROM _psp WHERE psp_erased="0" AND UCASE(psp_type) LIKE UCASE("%'+cmbbxOwnerType.Text+'%") AND (!ISNULL(psp_type)) GROUP BY psp_type ORDER BY psp_type;'
  else
    q:='SELECT psp_type FROM _psp WHERE psp_erased="0" AND (!ISNULL(psp_type)) GROUP BY psp_type ORDER BY psp_type;';
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              s1:=cmbbxOwnerType.Text;
              cmbbxOwnerType.Clear;
              cmbbxOwnerType.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').', lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      s:=ResultRow[0];
                      cmbbxOwnerType.Items.Append(s);
                      LogThis('Полученная строка - <'+s+'>.', lmtInfo);
                    end
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
              cmbbxOwnerType.ItemIndex:=cmbbxOwnerType.Items.IndexOf(s1);
              cmbbxOwnerType.Items.EndUpdate;
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
    end
  else
    s:='Возникла ошибка при выполнении запроса!';
  if ResultSet<>nil then
    begin
      LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
      mysql_free_result(ResultSet);
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.cmbbxOwnerTypeExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOwnerType.Text:=ValidateString(cmbbxOwnerType.Text);
end;

procedure TMainForm.cmbbxOwnerNationalityDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+cmbbxOwnerNationality.Text+'>.', lmtInfo);
  cmbbxOwnerNationality.Text:=ValidateString(cmbbxOwnerNationality.Text);
  LogThis('Итоговая строки поиска - <'+cmbbxOwnerNationality.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  if (cmbbxOwnerNationality.Text<>'') then
    q:='SELECT psp_nationality FROM _psp WHERE psp_erased="0" AND UCASE(psp_nationality) LIKE UCASE("%'+cmbbxOwnerNationality.Text+'%") AND (!ISNULL(psp_nationality)) GROUP BY psp_nationality ORDER BY psp_nationality;'
  else
    q:='SELECT psp_nationality FROM _psp WHERE psp_erased="0" AND (!ISNULL(psp_nationality)) GROUP BY psp_nationality ORDER BY psp_nationality;';
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              s1:=cmbbxOwnerNationality.Text;
              cmbbxOwnerNationality.Clear;
              cmbbxOwnerNationality.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').', lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      s:=ResultRow[0];
                      cmbbxOwnerNationality.Items.Append(s);
                      LogThis('Полученная строка - <'+s+'>.', lmtInfo);
                    end
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
              cmbbxOwnerNationality.ItemIndex:=cmbbxOwnerNationality.Items.IndexOf(s1);
              cmbbxOwnerNationality.Items.EndUpdate;
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
    end
  else
    s:='Возникла ошибка при выполнении запроса!';
  if ResultSet<>nil then
    begin
      LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
      mysql_free_result(ResultSet);
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.cmbbxOwnerNationalityExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOwnerNationality.Text:=ValidateString(cmbbxOwnerNationality.Text);
end;

procedure TMainForm.cmbbxOwnerAuthorityDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+cmbbxOwnerAuthority.Text+'>.', lmtInfo);
  cmbbxOwnerAuthority.Text:=ValidateString(cmbbxOwnerAuthority.Text);
  LogThis('Итоговая строки поиска - <'+cmbbxOwnerAuthority.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  if (cmbbxOwnerAuthority.Text<>'') then
    q:='SELECT psp_authority FROM _psp WHERE UCASE(psp_authority) LIKE UCASE("%'+cmbbxOwnerAuthority.Text+'%") AND psp_erased="0" AND (!ISNULL(psp_authority)) GROUP BY psp_authority ORDER BY psp_authority;'
  else
    q:='SELECT psp_authority FROM _psp WHERE psp_erased="0" AND (!ISNULL(psp_authority)) GROUP BY psp_authority ORDER BY psp_authority;';
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              s1:=cmbbxOwnerAuthority.Text;
              cmbbxOwnerAuthority.Clear;
              cmbbxOwnerAuthority.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').', lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      s:=ResultRow[0];
                      cmbbxOwnerAuthority.Items.Append(s);
                      LogThis('Полученная строка - <'+s+'>.', lmtInfo);
                    end
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
              cmbbxOwnerAuthority.ItemIndex:=cmbbxOwnerAuthority.Items.IndexOf(s1);
              cmbbxOwnerAuthority.Items.EndUpdate;
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
    end
  else
    s:='Возникла ошибка при выполнении запроса!';
  if ResultSet<>nil then
    begin
      LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
      mysql_free_result(ResultSet);
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.cmbbxOwnerAuthorityExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOwnerAuthority.Text:=ValidateString(cmbbxOwnerAuthority.Text);
end;

procedure TMainForm.cmbbxOwnerCodeOfIssuingStateDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+cmbbxOwnerCodeOfIssuingState.Text+'>.', lmtInfo);
  cmbbxOwnerCodeOfIssuingState.Text:=ValidateString(cmbbxOwnerCodeOfIssuingState.Text);
  LogThis('Итоговая строки поиска - <'+cmbbxOwnerCodeOfIssuingState.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  if (cmbbxOwnerCodeOfIssuingState.Text<>'') then
    q:='SELECT psp_code_of_issuing_state FROM _psp WHERE psp_erased="0" AND UCASE(psp_code_of_issuing_state) LIKE UCASE("%'+cmbbxOwnerCodeOfIssuingState.Text+
      '%") AND (!ISNULL(psp_code_of_issuing_state)) GROUP BY psp_code_of_issuing_state ORDER BY psp_code_of_issuing_state;'
  else
    q:='SELECT psp_code_of_issuing_state FROM _psp WHERE psp_erased="0" AND (!ISNULL(psp_code_of_issuing_state)) GROUP BY psp_code_of_issuing_state ORDER BY psp_code_of_issuing_state;';
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              s1:=cmbbxOwnerCodeOfIssuingState.Text;
              cmbbxOwnerCodeOfIssuingState.Clear;
              cmbbxOwnerCodeOfIssuingState.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').', lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      s:=ResultRow[0];
                      cmbbxOwnerCodeOfIssuingState.Items.Append(s);
                      LogThis('Полученная строка - <'+s+'>.', lmtInfo);
                    end
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
              cmbbxOwnerCodeOfIssuingState.ItemIndex:=cmbbxOwnerCodeOfIssuingState.Items.IndexOf(s1);
              cmbbxOwnerCodeOfIssuingState.Items.EndUpdate;
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
    end
  else
    s:='Возникла ошибка при выполнении запроса!';
  if ResultSet<>nil then
    begin
      LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
      mysql_free_result(ResultSet);
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.cmbbxOwnerCodeOfIssuingStateExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOwnerCodeOfIssuingState.Text:=ValidateString(cmbbxOwnerCodeOfIssuingState.Text);
end;

procedure TMainForm.cmbbxAutoMarkModelDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+cmbbxAutoMarkModel.Text+'>.', lmtInfo);
  cmbbxAutoMarkModel.Text:=ValidateString(cmbbxAutoMarkModel.Text);
  LogThis('Итоговая строки поиска - <'+cmbbxAutoMarkModel.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  if (cmbbxAutoMarkModel.Text<>'') then
    q:='SELECT tpsp_auto_mark_model FROM _tpsp WHERE tpsp_erased="0" AND UCASE(tpsp_auto_mark_model) LIKE UCASE("%'+cmbbxAutoMarkModel.Text+'%") AND (!ISNULL(tpsp_auto_mark_model)) GROUP BY tpsp_auto_mark_model ORDER BY tpsp_auto_mark_model;'
  else
    q:='SELECT tpsp_auto_mark_model FROM _tpsp WHERE tpsp_erased="0" AND (!ISNULL(tpsp_auto_mark_model)) GROUP BY tpsp_auto_mark_model ORDER BY tpsp_auto_mark_model;';
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              s1:=cmbbxAutoMarkModel.Text;
              cmbbxAutoMarkModel.Clear;
              cmbbxAutoMarkModel.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').', lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      s:=ResultRow[0];
                      cmbbxAutoMarkModel.Items.Append(s);
                      LogThis('Полученная строка - <'+s+'>.', lmtInfo);
                    end
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
              cmbbxAutoMarkModel.ItemIndex:=cmbbxAutoMarkModel.Items.IndexOf(s1);
              cmbbxAutoMarkModel.Items.EndUpdate;
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
    end
  else
    s:='Возникла ошибка при выполнении запроса!';
  if ResultSet<>nil then
    begin
      LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
      mysql_free_result(ResultSet);
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.cmbbxAutoMarkModelExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxAutoMarkModel.Text:=ValidateString(cmbbxAutoMarkModel.Text);
end;

procedure TMainForm.cmbbxAutoColorDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+cmbbxAutoColor.Text+'>.', lmtInfo);
  cmbbxAutoColor.Text:=ValidateString(cmbbxAutoColor.Text);
  LogThis('Итоговая строки поиска - <'+cmbbxAutoColor.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  if (cmbbxAutoColor.Text<>'') then
    q:='SELECT tpsp_auto_color FROM _tpsp WHERE tpsp_erased="0" AND UCASE(tpsp_auto_color) LIKE UCASE("%'+cmbbxAutoColor.Text+'%") AND (!ISNULL(tpsp_auto_color)) GROUP BY tpsp_auto_color ORDER BY tpsp_auto_color;'
  else
    q:='SELECT tpsp_auto_color FROM _tpsp WHERE tpsp_erased="0" AND (!ISNULL(tpsp_auto_color)) GROUP BY tpsp_auto_color ORDER BY tpsp_auto_color;';
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              s1:=cmbbxAutoColor.Text;
              cmbbxAutoColor.Clear;
              cmbbxAutoColor.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').', lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      s:=ResultRow[0];
                      cmbbxAutoColor.Items.Append(s);
                      LogThis('Полученная строка - <'+s+'>.', lmtInfo);
                    end
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
              cmbbxAutoColor.ItemIndex:=cmbbxAutoColor.Items.IndexOf(s1);
              cmbbxAutoColor.Items.EndUpdate;
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
    end
  else
    s:='Возникла ошибка при выполнении запроса!';
  if ResultSet<>nil then
    begin
      LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
      mysql_free_result(ResultSet);
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.cmbbxAutoColorExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxAutoColor.Text:=ValidateString(cmbbxAutoColor.Text);
end;

procedure TMainForm.cmbbxAutoTypeDropDown(Sender: TObject);
var
  q, s, s1: string;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+cmbbxAutoType.Text+'>.', lmtInfo);
  cmbbxAutoType.Text:=ValidateString(cmbbxAutoType.Text);
  LogThis('Итоговая строки поиска - <'+cmbbxAutoType.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  if (cmbbxAutoType.Text<>'') then
    q:='SELECT tpsp_auto_type FROM _tpsp WHERE tpsp_erased="0" AND UCASE(tpsp_auto_type) LIKE UCASE("%'+cmbbxAutoType.Text+'%") AND (!ISNULL(tpsp_auto_type)) GROUP BY tpsp_auto_type ORDER BY tpsp_auto_type;'
  else
    q:='SELECT tpsp_auto_type FROM _tpsp WHERE tpsp_erased="0" AND (!ISNULL(tpsp_auto_type)) GROUP BY tpsp_auto_type ORDER BY tpsp_auto_type;';
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              s1:=cmbbxAutoType.Text;
              cmbbxAutoType.Clear;
              cmbbxAutoType.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').', lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      s:=ResultRow[0];
                      cmbbxAutoType.Items.Append(s);
                      LogThis('Полученная строка - <'+s+'>.', lmtInfo);
                    end
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
              cmbbxAutoType.ItemIndex:=cmbbxAutoType.Items.IndexOf(s1);
              cmbbxAutoType.Items.EndUpdate;
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
    end
  else
    s:='Возникла ошибка при выполнении запроса!';
  if ResultSet<>nil then
    begin
      LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
      mysql_free_result(ResultSet);
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.cmbbxAutoTypeExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxAutoType.Text:=ValidateString(cmbbxAutoType.Text);
end;

procedure TMainForm.btbtnMoreClick(Sender: TObject);
begin
  btbtnMore.Tag:=integer(not boolean(btbtnMore.Tag));
  UpdateSearchBar;
end;

procedure TMainForm.Action_RichEditRedoExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    if ActiveControl=reOwnerOtherInfo then
      reOwnerOtherInfo.Perform(EM_UNDO, 0, 0);
  if PageControl1.ActivePage=tsAuto then
    if ActiveControl=reAutoOtherInfo then
      reAutoOtherInfo.Perform(EM_UNDO, 0, 0);
end;

procedure TMainForm.Action_RichEditRightAlignExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      reOwnerOtherInfo.Paragraph.Alignment:=taRightJustify;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      reAutoOtherInfo.Paragraph.Alignment:=taRightJustify;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.SetDefaultSettings(reA: TRichEdit);
begin
  reA.SelAttributes:=reA.DefAttributes;
  reA.Paragraph.Alignment:=taLeftJustify;
  reA.Paragraph.FirstIndent:=5;
  reA.Paragraph.LeftIndent:=5;
  reA.Paragraph.Numbering:=nsNone;
  reA.Paragraph.RightIndent:=5;
  reA.Paragraph.TabCount:=0;
end;

procedure TMainForm.Update_RichEditTools;
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      Action_RichEditBold.Checked:=fsBold in reOwnerOtherInfo.SelAttributes.Style;
      Action_RichEditItalic.Checked:=fsItalic in reOwnerOtherInfo.SelAttributes.Style;
      Action_RichEditUnderline.Checked:=fsUnderline in reOwnerOtherInfo.SelAttributes.Style;
      Action_RichEditLeftAlign.Checked:=reOwnerOtherInfo.Paragraph.Alignment=taLeftJustify;
      Action_RichEditCenterAlign.Checked:=reOwnerOtherInfo.Paragraph.Alignment=taCenter;
      Action_RichEditRightAlign.Checked:=reOwnerOtherInfo.Paragraph.Alignment=taRightJustify;
      Action_RichEditBullets.Checked:=reOwnerOtherInfo.Paragraph.Numbering=nsBullet;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      Action_RichEditBold.Checked:=fsBold in reAutoOtherInfo.SelAttributes.Style;
      Action_RichEditItalic.Checked:=fsItalic in reAutoOtherInfo.SelAttributes.Style;
      Action_RichEditUnderline.Checked:=fsUnderline in reAutoOtherInfo.SelAttributes.Style;
      Action_RichEditLeftAlign.Checked:=reAutoOtherInfo.Paragraph.Alignment=taLeftJustify;
      Action_RichEditCenterAlign.Checked:=reAutoOtherInfo.Paragraph.Alignment=taCenter;
      Action_RichEditRightAlign.Checked:=reAutoOtherInfo.Paragraph.Alignment=taRightJustify;
      Action_RichEditBullets.Checked:=reAutoOtherInfo.Paragraph.Numbering=nsBullet;
    end;
end;

procedure TMainForm.Refresh_NodeState(bFullRefresh: boolean);
var
  i, j: integer;
  s, q: string;
  bError: boolean;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
begin
  bError:=False;
  if bFullRefresh then
    begin
      if lvOwners.Items.Count>0 then
        begin
          LogThis('Производится обновление значков состояния владельцев.', lmtInfo);
          ProgressBar1.Max:=lvOwners.Items.Count-1;
          ProgressBar1.Step:=1;
          lvOwners.Items.BeginUpdate;
          for j:=0 to lvOwners.Items.Count-1 do
            begin
              if not bError then
                begin
                  s:=lvOwners.Items.Item[j].SubItems[2];
                  // LogThis('Производится обновление состояния владельца с ID='+s+'.',lmtInfo);
                  q:='SELECT psp_erased FROM _psp WHERE psp_id="'+s+'";';
                  // LogThis(q,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                  if i=0 then
                    begin
                      // LogThis('Запрос выполнен успешно.',lmtInfo);
                      ResultSet:=mysql_store_result(MySQLConnectionHandler);
                      try
                        if ResultSet<>nil then
                          begin
                            // LogThis('Результирующая выборка получена успешно.',lmtInfo);
                            i:=mysql_num_rows(ResultSet);
                            // LogThis('Количество строк выборки равно '+IntToStr(i)+'.',lmtInfo);
                            if (i=1) then
                              begin
                                // LogThis('Количество строк выборки ('+IntToStr(i)+') соответствует требуемому (1).',lmtInfo);
                                ResultRow:=mysql_fetch_row(ResultSet);
                                if ResultRow<>nil then
                                  begin
                                    if (ResultRow[0]='1') then
                                      lvOwners.Items.Item[j].ImageIndex:=DELETEDICON_ID
                                    else
                                      if (ResultRow[0]='0') then
                                        lvOwners.Items.Item[j].ImageIndex:=EXISTINGICON_ID
                                      else
                                        lvOwners.Items.Item[j].ImageIndex:=UNKNOWNICON_ID;
                                  end
                              end
                            else
                              begin
                                s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                            bError:=True;
                          end;
                      finally
                        if ResultSet<>nil then
                          begin
                            // LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
                            mysql_free_result(ResultSet);
                          end;
                      end;
                    end
                  else
                    begin
                      s:='Возникла ошибка при выполнении запроса!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
            end;
          lvOwners.Items.EndUpdate;
          ProgressBar1.Position:=ProgressBar1.Min;
          if bError then
            begin
              LogThis(s, lmtError);
              Screen.Cursor:=crDefault;
              MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else
            LogThis('Обновление значков состояния владельцев прошло успешно.', lmtInfo);
        end;
    end
  else
    begin
      if lvOwners.Items.Count>0 then
        begin
          LogThis('Производится обновление значков состояния выделенного владельца.', lmtInfo);
          ProgressBar1.Max:=1;
          ProgressBar1.Step:=1;
          lvOwners.Items.BeginUpdate;
          s:=lvOwners.Selected.SubItems[2];
          LogThis('Производится обновление состояния владельца с ID='+s+'.', lmtInfo);
          q:='SELECT psp_erased FROM _psp WHERE psp_id="'+s+'";';
          LogThis(q, lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.', lmtInfo);
              ResultSet:=mysql_store_result(MySQLConnectionHandler);
              try
                if ResultSet<>nil then
                  begin
                    LogThis('Результирующая выборка получена успешно.', lmtInfo);
                    i:=mysql_num_rows(ResultSet);
                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                    if (i=1) then
                      begin
                        LogThis('Количество строк выборки ('+IntToStr(i)+') соответствует требуемому (1).', lmtInfo);
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow<>nil then
                          begin
                            if (ResultRow[0]='1') then
                              lvOwners.Selected.ImageIndex:=DELETEDICON_ID
                            else
                              if (ResultRow[0]='0') then
                                lvOwners.Selected.ImageIndex:=EXISTINGICON_ID
                              else
                                lvOwners.Selected.ImageIndex:=UNKNOWNICON_ID;
                          end
                      end
                    else
                      begin
                        s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
                        bError:=True;
                      end;
                  end
                else
                  begin
                    s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                    bError:=True;
                  end;
              finally
                if ResultSet<>nil then
                  begin
                    LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
                    mysql_free_result(ResultSet);
                  end;
              end;
            end
          else
            begin
              s:='Возникла ошибка при выполнении запроса!';
              bError:=True;
            end;
          ProgressBar1.StepIt;
          lvOwners.Items.EndUpdate;
          ProgressBar1.Position:=ProgressBar1.Min;
          if bError then
            begin
              LogThis(s, lmtError);
              Screen.Cursor:=crDefault;
              MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else
            LogThis('Обновление значков состояния владельцев прошло успешно.', lmtInfo);
        end;
    end;
  if not bError then
    begin
      if lvAutos.Items.Count>0 then
        begin
          LogThis('Производится обновление значков состояния автосредств.', lmtInfo);
          ProgressBar1.Max:=lvAutos.Items.Count-1;
          ProgressBar1.Step:=1;
          lvAutos.Items.BeginUpdate;
          for j:=0 to lvAutos.Items.Count-1 do
            begin
              if not bError then
                begin
                  s:=lvAutos.Items.Item[j].SubItems[2];
                  // LogThis('Производится обновление состояния автосредства с ID='+s+'.',lmtInfo);
                  q:='SELECT tpsp_erased FROM _tpsp WHERE tpsp_id="'+s+'";';
                  // LogThis(q,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                  if i=0 then
                    begin
                      // LogThis('Запрос выполнен успешно.',lmtInfo);
                      ResultSet:=mysql_store_result(MySQLConnectionHandler);
                      try
                        if ResultSet<>nil then
                          begin
                            // LogThis('Результирующая выборка получена успешно.',lmtInfo);
                            i:=mysql_num_rows(ResultSet);
                            // LogThis('Количество строк выборки равно '+IntToStr(i)+'.',lmtInfo);
                            if (i=1) then
                              begin
                                // LogThis('Количество строк выборки ('+IntToStr(i)+') соответствует требуемому (1).',lmtInfo);
                                ResultRow:=mysql_fetch_row(ResultSet);
                                if ResultRow<>nil then
                                  begin
                                    if (ResultRow[0]='1') then
                                      lvAutos.Items.Item[j].ImageIndex:=DELETEDICON_ID
                                    else
                                      if (ResultRow[0]='0') then
                                        lvAutos.Items.Item[j].ImageIndex:=EXISTINGICON_ID
                                      else
                                        lvAutos.Items.Item[j].ImageIndex:=UNKNOWNICON_ID;
                                  end
                              end
                            else
                              begin
                                s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                            bError:=True;
                          end;
                      finally
                        if ResultSet<>nil then
                          begin
                            // LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
                            mysql_free_result(ResultSet);
                          end;
                      end;
                    end
                  else
                    begin
                      s:='Возникла ошибка при выполнении запроса!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end;
            end;
          lvAutos.Items.EndUpdate;
          ProgressBar1.Position:=ProgressBar1.Min;
          if bError then
            begin
              LogThis(s, lmtError);
              Screen.Cursor:=crDefault;
              MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else
            LogThis('Обновление значков состояния автосредств прошло успешно.', lmtInfo);
        end;
    end;
end;

procedure TMainForm.Action_DB_DefragmentationExecute(Sender: TObject);
begin
  MessageBox(Handle, PChar('Данное действие на текущий момент в программе не реализовано.'), PChar('Невозможно выполнить операцию'), MB_OK+MB_ICONSTOP);
end;

procedure TMainForm.Action_DB_DeleteNodeExecute(Sender: TObject);
var
  bError, b: boolean;
  s, s1, q, q1: string;
  i: integer;
begin
  SetBusy;
  bError:=False;
  if ActiveControl=lvOwners then
    begin
      if lvOwners.Selected<>nil then
        begin
          s1:=lvOwners.Selected.SubItems[2];
          b:=MessageBox(Handle, PChar('Вы подтверждаете пометку на удаление выделенного владельца и всех записаных на него автосредств?'), PChar('OA4 - Подтверждение пометки на удаление'), MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDYES;
          if b then
            begin
              Screen.Cursor:=crHourGlass;
              ProgressBar1.Max:=4;
              ProgressBar1.Step:=1;
              LogThis('Будет произведена попытка пометки на удаление всех автосредств владельца с ID='+s1, lmtWarning);
              // составление строки запроса
              q:='UPDATE _tpsp SET tpsp_erased="1" WHERE tpsp_psp_id="'+s1+'";';
              LogThis(q, lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.', lmtInfo);
                  ProgressBar1.StepIt;
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                  // запись статистики в БД
                  LogThis('Внесение записи в таблицу событий.', lmtInfo);
                  q1:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'DEL'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                  LogThis(q1, lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler, PChar(q1), Length(q1));
                  if i=0 then
                    begin
                      LogThis('Запрос выполнен успешно.', lmtInfo);
                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                      if (i=1) then
                        begin
                          LogThis('Запись в таблицу событий внесена успешно', lmtInfo);
                          ProgressBar1.StepIt;
                          LogThis('Будет произведена попытка пометки на удаление владельца с ID='+s1, lmtWarning);
                          q:='UPDATE _psp SET psp_erased="1" WHERE psp_id="'+s1+'";';
                          LogThis(q, lmtSQL);
                          i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                          if i=0 then
                            begin
                              LogThis('Запрос выполнен успешно.', lmtInfo);
                              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                              LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                              if i=1 then
                                begin
                                  LogThis('Пометка владельца на удаление произведена успешно', lmtInfo);
                                  ProgressBar1.StepIt;
                                  // запись статистики в БД
                                  LogThis('Внесение записи в таблицу событий.', lmtInfo);
                                  q1:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'DEL'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                                  LogThis(q1, lmtSQL);
                                  i:=mysql_real_query(MySQLConnectionHandler, PChar(q1), Length(q1));
                                  if i=0 then
                                    begin
                                      LogThis('Запрос выполнен успешно.', lmtInfo);
                                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                                      if (i=1) then
                                        begin
                                          LogThis('Запись в таблицу событий внесена успешно', lmtInfo);
                                          ProgressBar1.StepIt;
                                        end
                                      else
                                        begin
                                          s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                                          bError:=True;
                                        end;
                                    end
                                  else
                                    begin
                                      s:='Возникла ошибка при выполнении запроса!';
                                      bError:=True;
                                    end;
                                end
                              else
                                begin
                                  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                                  bError:=True;
                                end
                            end
                          else
                            begin
                              s:='Возникла ошибка при выполнении запроса!';
                              bError:=True;
                            end;
                        end
                      else
                        begin
                          s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                          bError:=True;
                        end;
                    end
                  else
                    begin
                      s:='Возникла ошибка при выполнении запроса!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Возникла ошибка при выполнении запроса!';
                  bError:=True;
                end;
              ProgressBar1.Position:=ProgressBar1.Min;
              Refresh_NodeState(False);
              Screen.Cursor:=crDefault;
              if bError then
                begin
                  LogThis(s, lmtError);
                  MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                end;
            end
          else
            LogThis('Попытка пометки на удаление владельца с ID='+s1+' была отменена.', lmtInfo);
        end;
    end;
  if ActiveControl=lvAutos then
    begin
      if lvAutos.Selected<>nil then
        begin
          s:=lvAutos.Selected.SubItems[2];
          Screen.Cursor:=crHourGlass;
          ProgressBar1.Max:=2;
          ProgressBar1.Step:=1;
          LogThis('Будет произведена попытка пометки на удаление автосредства с ID='+s, lmtWarning);
          // составление строки запроса
          q:='UPDATE _tpsp SET tpsp_erased="1" WHERE tpsp_id="'+s+'";';
          LogThis(q, lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.', lmtInfo);
              ProgressBar1.StepIt;
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
              if (i=1) then
                begin
                  LogThis('Пометка автосредства на удаление произведена успешно', lmtInfo);
                  ProgressBar1.StepIt;
                  // запись статистики в БД
                  LogThis('Внесение записи в таблицу событий.', lmtInfo);
                  q1:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'DEL'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                  LogThis(q1, lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler, PChar(q1), Length(q1));
                  if i=0 then
                    begin
                      LogThis('Запрос выполнен успешно.', lmtInfo);
                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                      if (i=1) then
                        begin
                          LogThis('Запись в таблицу событий внесена успешно', lmtInfo);
                          ProgressBar1.StepIt;
                        end
                      else
                        begin
                          s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                          bError:=True;
                        end;
                    end
                  else
                    begin
                      s:='Возникла ошибка при выполнении запроса!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Возникла ошибка при выполнении запроса!';
              bError:=True;
            end;
          ProgressBar1.Position:=ProgressBar1.Min;
          if CurrentUser.bDBEdition then
            Refresh_NodeState(False);
          Screen.Cursor:=crDefault;
          if bError then
            begin
              LogThis(s, lmtError);
              MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end;
        end;
    end;
  Update_Actions;
  SetReady;
end;

procedure TMainForm.Action_DB_RecoverNodeExecute(Sender: TObject);
var
  bError, b: boolean;
  s, q, q1: string;
  i: integer;
begin
  SetBusy;
  bError:=False;
  if ActiveControl=lvOwners then
    begin
      if lvOwners.Selected<>nil then
        begin
          s:=lvOwners.Selected.SubItems[2];
          Screen.Cursor:=crHourGlass;
          ProgressBar1.Max:=2;
          ProgressBar1.Step:=1;
          LogThis('Будет произведена попытка восстановления владельца с ID='+s, lmtWarning);
          // составление строки запроса
          q:='UPDATE _psp SET psp_erased="0" WHERE psp_id="'+s+'";';
          LogThis(q, lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.', lmtInfo);
              ProgressBar1.StepIt;
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
              if (i=1) then
                begin
                  LogThis('Восстановление владельца произведена успешно', lmtInfo);
                  ProgressBar1.StepIt;
                  // запись статистики в БД
                  LogThis('Внесение записи в таблицу событий.', lmtInfo);
                  q1:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'REC'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                  LogThis(q1, lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler, PChar(q1), Length(q1));
                  if i=0 then
                    begin
                      LogThis('Запрос выполнен успешно.', lmtInfo);
                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                      if (i=1) then
                        begin
                          LogThis('Запись в таблицу событий внесена успешно', lmtInfo);
                          ProgressBar1.StepIt;
                        end
                      else
                        begin
                          s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                          bError:=True;
                        end;
                    end
                  else
                    begin
                      s:='Возникла ошибка при выполнении запроса!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Возникла ошибка при выполнении запроса!';
              bError:=True;
            end;
          ProgressBar1.Position:=ProgressBar1.Min;
          if CurrentUser.bDBEdition then
            Refresh_NodeState(False);
          Screen.Cursor:=crDefault;
          if bError then
            begin
              LogThis(s, lmtError);
              MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end;
        end;
    end;

  if ActiveControl=lvAutos then
    begin
      if lvAutos.Selected<>nil then
        begin
          if lvOwners.Selected<>nil then
            if lvOwners.Selected.ImageIndex=DELETEDICON_ID then
              begin
                LogThis('Восстанавливаемое автосредство принадлежит удалённому владельцу!', lmtWarning);
                b:=MessageBox(Handle, PChar('Вы пытаетесь воостановить автосредство помеченного на удаление владельца.'+#10#13+'Данная операция невозможна без восстановления самой владельца.'+#10#13+
                      'Вы желаете восстановить владельца, к которому относится автосредство?'), PChar('OA4 - Подтверждение восстановления'), MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDYES;
                if b then
                  begin
                    s:=lvOwners.Selected.SubItems[2];
                    Screen.Cursor:=crHourGlass;
                    ProgressBar1.Max:=2;
                    ProgressBar1.Step:=1;
                    LogThis('Будет произведена попытка восстановления владельца с ID='+s, lmtWarning);
                    // составление строки запроса
                    q:='UPDATE _psp SET psp_erased="0" WHERE psp_id="'+s+'";';
                    LogThis(q, lmtSQL);
                    i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                    ProgressBar1.StepIt;
                    if i=0 then
                      begin
                        LogThis('Запрос выполнен успешно.', lmtInfo);
                        i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                        LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                        if (i=1) then
                          begin
                            LogThis('Восстановление владельца произведено успешно', lmtInfo);
                            // запись статистики в БД
                            LogThis('Внесение записи в таблицу событий.', lmtInfo);
                            q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'REC'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                            LogThis(q, lmtSQL);
                            i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                            ProgressBar1.StepIt;
                            if i=0 then
                              begin
                                LogThis('Запрос выполнен успешно.', lmtInfo);
                                i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                                LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                                if (i=1) then
                                  LogThis('Запись в таблицу событий внесена успешно', lmtInfo)
                                else
                                  begin
                                    s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                                    bError:=True;
                                  end;
                              end
                            else
                              begin
                                s:='Возникла ошибка при выполнении запроса!';
                                bError:=True;
                              end;
                          end
                        else
                          begin
                            s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                            bError:=True;
                          end;
                      end
                    else
                      begin
                        s:='Возникла ошибка при выполнении запроса!';
                        bError:=True;
                      end;
                    ProgressBar1.Position:=ProgressBar1.Min;
                    if CurrentUser.bDBEdition then
                      Refresh_NodeState(False);
                    Screen.Cursor:=crDefault;
                    if bError then
                      begin
                        LogThis(s, lmtError);
                        MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                      end;
                  end
                else
                  begin
                    // выход
                    LogThis('Восстанавление мероприятия и организации-владельца отменено.', lmtWarning);
                    Screen.Cursor:=crDefault;
                    SetReady;
                    Exit;
                  end;
              end;
          if not bError then
            begin
              s:=lvAutos.Selected.SubItems[2];
              Screen.Cursor:=crHourGlass;
              ProgressBar1.Max:=2;
              ProgressBar1.Step:=1;
              LogThis('Будет произведена попытка восстановления автосредства с ID='+s, lmtWarning);
              // составление строки запроса
              q:='UPDATE _tpsp SET tpsp_erased="0" WHERE tpsp_id="'+s+'";';
              LogThis(q, lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
              ProgressBar1.StepIt;
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.', lmtInfo);
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                  if (i=1) then
                    begin
                      LogThis('Восстановление автосредства произведено успешно', lmtInfo);
                      // запись статистики в БД
                      LogThis('Внесение записи в таблицу событий.', lmtInfo);
                      q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'REC'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                      LogThis(q, lmtSQL);
                      i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
                      ProgressBar1.StepIt;
                      if i=0 then
                        begin
                          LogThis('Запрос выполнен успешно.', lmtInfo);
                          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                          LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                          if (i=1) then
                            LogThis('Запись в таблицу событий внесена успешно', lmtInfo)
                          else
                            begin
                              s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                              bError:=True;
                            end;
                        end
                      else
                        begin
                          s:='Возникла ошибка при выполнении запроса!';
                          bError:=True;
                        end;
                    end
                  else
                    begin
                      s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Возникла ошибка при выполнении запроса!';
                  bError:=True;
                end;
              ProgressBar1.Position:=ProgressBar1.Min;
              if CurrentUser.bDBEdition then
                Refresh_NodeState(False);
              Screen.Cursor:=crDefault;
              if bError then
                begin
                  LogThis(s, lmtError);
                  MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                end;
            end;
        end;
    end;
  Update_Actions;
  SetReady;
end;

procedure TMainForm.Action_DB_RefreshListExecute(Sender: TObject);
begin
  MessageBox(Handle, PChar('Данное действие на текущий момент в программе не реализовано.'), PChar('Невозможно выполнить операцию'), MB_OK+MB_ICONSTOP);
end;

procedure TMainForm.edbxAutoMassWithoutLoadExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxAutoMassWithoutLoad.Text:=ValidateString(edbxAutoMassWithoutLoad.Text);
end;

procedure TMainForm.edbxAutoMaximumMassExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxAutoMaximumMass.Text:=ValidateString(edbxAutoMaximumMass.Text);
end;

procedure TMainForm.edbxAutoNumberExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxAutoNumber.Text:=ValidateString(edbxAutoNumber.Text);
end;

procedure TMainForm.edbxAutoNumberOfCarriageExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxAutoNumberOfCarriage.Text:=ValidateString(edbxAutoNumberOfCarriage.Text);
end;

procedure TMainForm.edbxAutoRegistrationSignExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxAutoRegistrationSign.Text:=ValidateString(edbxAutoRegistrationSign.Text);
end;

procedure TMainForm.edbxOwnerPassportNumberExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxOwnerPassportNumber.Text:=ValidateString(edbxOwnerPassportNumber.Text);
end;

procedure TMainForm.edbxOwnerPlaceOfBirthExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxOwnerPlaceOfBirth.Text:=ValidateString(edbxOwnerPlaceOfBirth.Text);
end;

procedure TMainForm.edbxOwnerPrivateNumberExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxOwnerPrivateNumber.Text:=ValidateString(edbxOwnerPrivateNumber.Text);
end;

procedure TMainForm.edbxOwnerGivenNamesExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxOwnerGivenNames.Text:=ValidateString(edbxOwnerGivenNames.Text);
end;

procedure TMainForm.edbxOwnerFlatExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxOwnerFlat.Text:=ValidateString(edbxOwnerFlat.Text);
end;

procedure TMainForm.edbxOwnerHouseExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxOwnerHouse.Text:=ValidateString(edbxOwnerHouse.Text);
end;

procedure TMainForm.edbxOwnerSurnameExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxOwnerSurname.Text:=ValidateString(edbxOwnerSurname.Text);
end;

procedure TMainForm.edbxOwnerSubhouseExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxOwnerSubhouse.Text:=ValidateString(edbxOwnerSubhouse.Text);
end;

procedure TMainForm.edbxOwnerSubnameExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    edbxOwnerSubname.Text:=ValidateString(edbxOwnerSubname.Text);
end;

procedure TMainForm.meAutoCommentsExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    meAutoComments.Text:=ValidateString(meAutoComments.Text);
end;

procedure TMainForm.miGoToDataPanelClick(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOwner then
    begin
      if pnlOwnerGeneralInfo.Visible then
        begin
          if pnlConnectedMode.Visible and cmbbxOwnerType.Visible and cmbbxOwnerType.Enabled then
            cmbbxOwnerType.SetFocus;
          if pnlConnectedMode.Visible and edbxOwnerType.Visible and edbxOwnerType.Enabled then
            edbxOwnerType.SetFocus;
        end
      else
        begin
          if pnlConnectedMode.Visible and reOwnerOtherInfo.Visible and reOwnerOtherInfo.Enabled then
            reOwnerOtherInfo.SetFocus;
        end;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      if pnlAutoGeneralInfo.Visible then
        begin
          if pnlConnectedMode.Visible and edbxAutoNumber.Visible and edbxAutoNumber.Enabled then
            edbxAutoNumber.SetFocus;
        end
      else
        begin
          if pnlConnectedMode.Visible and reOwnerOtherInfo.Visible and reOwnerOtherInfo.Enabled then
            reOwnerOtherInfo.SetFocus;
        end;
    end;
end;

procedure TMainForm.btnClearClick(Sender: TObject);
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  if PageControl1.ActivePage=tsOwner then
    begin
      cmbbxOwnerType.Clear;
      cmbbxOwnerCodeOfIssuingState.Clear;
      edbxOwnerPassportNumber.Clear;
      edbxOwnerSurname.Clear;
      edbxOwnerGivenNames.Clear;
      edbxOwnerSubname.Clear;
      cmbbxOwnerNationality.Clear;
      dtpOwnerDateOfBirth.Date:=Date;
      dtpOwnerDateOfBirth.Time:=EncodeTime(0, 0, 0, 0);
      edbxOwnerPlaceOfBirth.Clear;
      cmbbxOwnerSex.ItemIndex:=-1;
      edbxOwnerPrivateNumber.Clear;
      dtpOwnerDateOfIssue.Date:=Date;
      dtpOwnerDateOfIssue.Time:=EncodeTime(0, 0, 0, 0);
      cmbbxOwnerAuthority.Clear;
      dtpOwnerDateOfExpiry.Date:=Date;
      dtpOwnerDateOfExpiry.Time:=EncodeTime(0, 0, 0, 0);
      cmbbxOwnerTown.Clear;
      cmbbxOwnerStreet.Clear;
      edbxOwnerHouse.Clear;
      edbxOwnerSubHouse.Clear;
      edbxOwnerFlat.Clear;
      reOwnerOtherInfo.Clear;
      SetDefaultSettings(reOwnerOtherInfo);
      Update_RichEditTools;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      edbxAutoNumber.Clear;
      dtpAutoDateOfIssue.Date:=Date;
      dtpAutoDateOfIssue.Time:=EncodeTime(0, 0, 0, 0);
      edbxAutoRegistrationSign.Clear;
      cmbbxAutoMarkModel.Clear;
      cmbbxAutoYearOfEdition.ItemIndex:=cmbbxAutoYearOfEdition.Items.IndexOf('');
      cmbbxAutoColor.Clear;
      edbxAutoMaximumMass.Clear;
      edbxAutoNumberOfCarriage.Clear;
      edbxAutoMassWithoutLoad.Clear;
      cmbbxAutoType.Clear;
      meAutoComments.Clear;
      reAutoOtherInfo.Clear;
      SetDefaultSettings(reAutoOtherInfo);
      Update_RichEditTools;
    end;
  Screen.Cursor:=crDefault;
  SetReady;
end;

procedure TMainForm.Update_Actions;
begin
  Action_Quit.Enabled:=True;
  Action_Configuration.Enabled:=True;
  Action_About.Enabled:=True;
  Action_HelpContent.Enabled:=True;
  if Configuration.bLogged then
    begin
      Action_DB_Users.Visible:=CurrentUser.bDBUsersEdition;
      Action_DB_Statistic.Visible:=True;
      Action_DB_Defragmentation.Visible:=CurrentUser.bDBDefragmentation;
      Action_DB_Cleaning.Visible:=CurrentUser.bDBCleaning;
      Action_DB_Maintenance.Visible:=CurrentUser.bDBMaintenance;
      Action_DB_Backup.Visible:=CurrentUser.bDBBackup;
      Action_DB_Connection.Visible:=False;
      Action_DB_Disconnection.Visible:=True;
      Action_DB_AddOwner.Visible:=CurrentUser.bDBEdition;
      Action_DB_AddAuto.Visible:=CurrentUser.bDBEdition;
      Action_DB_RecoverNode.Visible:=CurrentUser.bDBEdition;
      Action_DB_DeleteNode.Visible:=CurrentUser.bDBEdition;
      Action_DB_RefreshList.Visible:=True;
      Action_PostMessage.Visible:=True;
      Action_ViewMessages.Visible:=True;
      Action_DB_Users.Enabled:=Action_DB_Users.Visible;
      Action_DB_Statistic.Enabled:=Action_DB_Statistic.Visible;
      Action_DB_Defragmentation.Enabled:=Action_DB_Defragmentation.Visible;
      Action_DB_Cleaning.Enabled:=Action_DB_Cleaning.Visible;
      Action_DB_Maintenance.Enabled:=Action_DB_Maintenance.Visible;
      Action_DB_Backup.Enabled:=Action_DB_Backup.Visible;
      Action_DB_Connection.Enabled:=Action_DB_Connection.Visible;
      Action_DB_Disconnection.Enabled:=Action_DB_Disconnection.Visible;
      Action_DB_AddOwner.Enabled:=Action_DB_AddOwner.Visible;
      if lvOwners.Focused then
        begin
          if lvOwners.Selected<>nil then
            begin
              Action_DB_AddAuto.Enabled:=CurrentUser.bDBEdition;
              Action_DB_RecoverNode.Enabled:=CurrentUser.bDBEdition and(lvOwners.Selected.ImageIndex=DELETEDICON_ID);
              Action_DB_DeleteNode.Enabled:=CurrentUser.bDBEdition and(lvOwners.Selected.ImageIndex=EXISTINGICON_ID);
            end
          else
            begin
              Action_DB_AddAuto.Enabled:=False;
              Action_DB_RecoverNode.Enabled:=False;
              Action_DB_DeleteNode.Enabled:=False;
            end;
        end;
      if lvAutos.Focused then
        begin
          if lvAutos.Selected<>nil then
            begin
              Action_DB_AddAuto.Enabled:=CurrentUser.bDBEdition;
              Action_DB_RecoverNode.Enabled:=CurrentUser.bDBEdition and(lvAutos.Selected.ImageIndex=DELETEDICON_ID);
              Action_DB_DeleteNode.Enabled:=CurrentUser.bDBEdition and(lvAutos.Selected.ImageIndex=EXISTINGICON_ID);
            end
          else
            begin
              Action_DB_AddAuto.Enabled:=False;
              Action_DB_RecoverNode.Enabled:=False;
              Action_DB_DeleteNode.Enabled:=False;
            end;
        end;
      if (not lvOwners.Focused)and(not lvAutos.Focused) then
        begin
          Action_DB_AddAuto.Enabled:=False;
          Action_DB_RecoverNode.Enabled:=False;
          Action_DB_DeleteNode.Enabled:=False;
        end;
      Action_DB_RefreshList.Enabled:=Action_DB_RefreshList.Visible;
      Action_PostMessage.Visible:=Action_PostMessage.Visible;
      Action_ViewMessages.Visible:=Action_PostMessage.Visible;
    end
  else
    begin
      Action_DB_Users.Visible:=False;
      Action_DB_Statistic.Visible:=False;
      Action_DB_Defragmentation.Visible:=False;
      Action_DB_Cleaning.Visible:=False;
      Action_DB_Maintenance.Visible:=False;
      Action_DB_Backup.Visible:=False;
      Action_DB_Connection.Visible:=True;
      Action_DB_Disconnection.Visible:=False;
      Action_DB_AddAuto.Visible:=False;
      Action_DB_AddOwner.Visible:=False;
      Action_DB_DeleteNode.Visible:=False;
      Action_DB_RefreshList.Visible:=False;
      Action_DB_RecoverNode.Visible:=False;
      Action_PostMessage.Visible:=False;
      Action_ViewMessages.Visible:=False;
      Action_DB_Users.Enabled:=Action_DB_Users.Visible;
      Action_DB_Statistic.Enabled:=Action_DB_Statistic.Visible;
      Action_DB_Defragmentation.Enabled:=Action_DB_Defragmentation.Visible;
      Action_DB_Cleaning.Enabled:=Action_DB_Cleaning.Visible;
      Action_DB_Maintenance.Enabled:=Action_DB_Maintenance.Visible;
      Action_DB_Backup.Enabled:=Action_DB_Backup.Visible;
      Action_DB_Connection.Enabled:=Action_DB_Connection.Visible;
      Action_DB_Disconnection.Enabled:=Action_DB_Disconnection.Visible;
      Action_DB_AddAuto.Enabled:=Action_DB_AddAuto.Visible;
      Action_DB_AddOwner.Enabled:=Action_DB_AddOwner.Visible;
      Action_DB_DeleteNode.Enabled:=Action_DB_DeleteNode.Visible;
      Action_DB_RefreshList.Enabled:=Action_DB_RefreshList.Visible;
      Action_DB_RecoverNode.Enabled:=Action_DB_RecoverNode.Visible;
      Action_PostMessage.Visible:=Action_PostMessage.Visible;
      Action_ViewMessages.Visible:=Action_PostMessage.Visible;
    end;
  // обновление "вилимости" разделителей
  ActionToolBar1.ActionControls[1].Visible:=Action_Quit.Visible;
  ActionToolBar1.ActionControls[4].Visible:=Action_DB_Connection.Visible or Action_DB_Disconnection.Visible;
  ActionToolBar1.ActionControls[10].Visible:=Action_DB_AddOwner.Visible or Action_DB_AddAuto.Visible or Action_DB_DeleteNode.Visible or Action_DB_RecoverNode.Visible or Action_DB_RefreshList.Visible;
  ActionToolBar1.ActionControls[15].Visible:=Action_DB_Cleaning.Visible or Action_DB_Defragmentation.Visible or Action_DB_Maintenance.Visible or Action_DB_Backup.Visible;
  ActionToolBar1.ActionControls[18].Visible:=Action_DB_Users.Visible or Action_DB_Statistic.Visible;
  ActionToolBar1.ActionControls[21].Visible:=Action_PostMessage.Visible or Action_ViewMessages.Visible;
  ActionToolBar1.ActionControls[23].Visible:=Action_Configuration.Visible;
  miActions.Visible:=Action_DB_Backup.Visible or Action_DB_Cleaning.Visible or Action_DB_Defragmentation.Visible or Action_DB_Maintenance.Visible or Action_DB_AddAuto.Visible or Action_DB_AddOwner.Visible or Action_DB_DeleteNode.Visible or
    Action_DB_RecoverNode.Visible or Action_DB_RefreshList.Visible or Action_PostMessage.Visible or Action_ViewMessages.Visible;
end;

procedure TMainForm.UpdateSearchBar;
var
  Bitmap: TBitmap;
begin
  if Configuration.bShowFullSearchBar then
    begin
      btbtnMore.Visible:=False;
      // chkbxStopDate.Visible:=True;
      // dtpStopDate.Visible:=True;
      // chkbxTour.Visible:=True;
      // chkbxAdultsOnly.Visible:=True;
      chkbxHideErased.Visible:=CurrentUser.bDBEdition;
      // chkbxHideOld.Visible:=True;
      btbtnMore.Tag:=1;
    end
  else
    begin
      btbtnMore.Visible:=True;
      // chkbxStopDate.Visible:=boolean(btbtnMore.Tag);
      // dtpStopDate.Visible:=boolean(btbtnMore.Tag);
      // chkbxTour.Visible:=boolean(btbtnMore.Tag);
      // chkbxAdultsOnly.Visible:=boolean(btbtnMore.Tag);
      chkbxHideErased.Visible:=CurrentUser.bDBEdition and boolean(btbtnMore.Tag);
      // chkbxHideOld.Visible:=boolean(btbtnMore.Tag);
    end;
  chkbxHideErased.Checked:=False;
  // chkbxHideOld.Checked:=not CurrentUser.bDBEdition;
  // chkbxPremier.Checked:=False;
  // chkbxChildren.Checked:=False;
  // chkbxTeenagers.Checked:=False;
  // chkbxTour.Checked:=False;
  // chkbxAdultsOnly.Checked:=False;
  // chkbxStartDate.Checked:=False;
  // chkbxStopDate.Checked:=False;
  Bitmap:=TBitmap.Create;
  try
    case btbtnMore.Tag of
      0:
        ImageList3.GetBitmap(3, Bitmap);
      1:
        ImageList3.GetBitmap(2, Bitmap);
    end;
    btbtnMore.Glyph.Assign(Bitmap);
    btbtnMore.Glyph.TransparentColor:=clFuchsia;
  finally
    Bitmap.Free;
  end;
  pnlSearch.AutoSize:=True;
end;

procedure TMainForm.btnCancelClick(Sender: TObject);
begin
  SetBusy;
  bAddingOwnerNow:=False;
  bAddingAutoNow:=False;
  if lvOwners.Items.Count>0 then
    lvOwners.ItemIndex:=iLastSelectedOrgIndex
  else
    lvOwnersSelectItem(Sender, nil, True);
  if lvOwners.Selected<>nil then
    lvOwners.SetFocus
  else
    edbxSearch.SetFocus;
  SetReady;
end;

procedure TMainForm.btnCloneClick(Sender: TObject);
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  if PageControl1.ActivePage=tsOwner then
    bAddingOwnerNow:=True;
  if PageControl1.ActivePage=tsAuto then
    bAddingAutoNow:=True;
  if lvOwners.Selected<>nil then
    iLastSelectedOrgIndex:=lvOwners.Selected.index
  else
    if lvOwners.Items.Count>0 then
      iLastSelectedOrgIndex:=0
    else
      iLastSelectedOrgIndex:=-1;
  // обновление значений панели создания/модификации
  lblCreationCaption.Visible:=False;
  lblCreation.Visible:=False;
  lblModificationCaption.Visible:=False;
  lblModification.Visible:=False;
  // обновление значений панели идентификатора
  if pnlID.Visible then
    begin
      lblIDCaption.Visible:=False;
      lblID.Visible:=False;
    end;
  // очистка значений контролов
  lblId.Caption:='';
  lblCreation.Caption:='';
  lblModification.Caption:='';
  btnCancel.Enabled:=True;
  btnCancel.Visible:=True;
  if PageControl1.ActivePage=tsOwner then
    begin
      if cmbbxOwnerType.Visible then
        cmbbxOwnerType.SetFocus;
    end;
  if PageControl1.ActivePage=tsAuto then
    begin
      if edbxAutoNumber.Visible then
        edbxAutoNumber.SetFocus;
    end;
  Screen.Cursor:=crDefault;
  SetReady;
end;

procedure TMainForm.btbtnSearchClick(Sender: TObject);
var
  s, s1, q, q1: string;
  bError: boolean;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  slA: TStringList;
  LvGroup: TLVGROUP;
  LvItemA: TLVITEMA;
  ListItem: TListItem;
  i, j: integer;
  pwcGroupName: PWideChar;
  GroupId: integer;
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+edbxSearch.Text+'>.', lmtInfo);
  s:=Trim(edbxSearch.Text);
  while Pos('  ', s)>0 do
    s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
  edbxSearch.Text:=s;
  LogThis('Итоговая строки поиска - <'+edbxSearch.Text+'>.', lmtInfo);
  Application.ProcessMessages;
  // очиска списков
  lvOwners.Items.BeginUpdate;
  blvOwnerRedrawNow:=True; // перерисовка окна результатов поиска включена
  SendMessage(lvOwners.Handle, LVM_REMOVEALLGROUPS, 0, 0);
  SendMessage(lvOwners.Handle, LVM_DELETEALLITEMS, 0, 0);
  lvOwners.Items.EndUpdate;
  lvAutos.Items.BeginUpdate;
  SendMessage(lvAutos.Handle, LVM_REMOVEALLGROUPS, 0, 0);
  SendMessage(lvAutos.Handle, LVM_DELETEALLITEMS, 0, 0);
  lvAutos.Items.EndUpdate;

  SendMessage(lvOwners.Handle, LVM_ENABLEGROUPVIEW, 1, 0);
  q1:='';
  q:='SELECT LEFT(TRIM(psp_surname),1) AS x1, '+ // 0
    'CONCAT(TRIM(psp_surname)," ",TRIM(psp_given_names)," ",TRIM(psp_subname)) AS x2, '+ // 1
    'COUNT(tpsp_id), '+ // 2
    'psp_id AS x3, '+ // 3
    'psp_erased, '+ // 4
    'psp_town, '+ // 5
    'psp_street, '+ // 6
    'psp_house_num, '+ // 7
    'psp_house_sym, '+ // 8
    'psp_subhouse_num, '+ // 9
    'psp_subhouse_sym, '+ // 10
    'psp_flat_num, '+ // 11
    'psp_flat_sym '+ // 12
    'FROM _psp '+'LEFT JOIN _tpsp ON tpsp_psp_id=psp_id ';
  if (chkbxHideErased.Visible and chkbxHideErased.Enabled and chkbxHideErased.Checked)or(not chkbxHideErased.Visible) then
    q:=q+'AND (tpsp_erased="0" OR ISNULL(tpsp_erased)) ';
  if (chkbxHideErased.Visible and chkbxHideErased.Enabled and chkbxHideErased.Checked)or(not chkbxHideErased.Visible) then
    q1:='psp_erased="0" ';
  // формирование строки запроса по тексту
  s:=edbxSearch.Text;
  while Pos('.', s)>0 do
    s:=StringReplace(s, '.', '!', [rfReplaceAll]);
  while Pos('*', s)>0 do
    s:=StringReplace(s, '*', '%', [rfReplaceAll]);
  slA:=TStringList.Create;
  try
    slA.Duplicates:=dupIgnore;
    CutStringByLimiterToStringList(s, slA, ' ');
    for i:=0 to slA.Count-1 do
      begin
        if q1>'' then
          q1:=q1+'AND ';
        if slA[i]>'' then
          begin
            q1:=q1+'('+'(psp_type LIKE "% '+slA[i]+'%") OR '+'(psp_type LIKE "% '+slA[i]+' %") OR '+

              '(psp_code_of_issuing_state LIKE "% '+slA[i]+'%") OR '+'(psp_code_of_issuing_state LIKE "% '+slA[i]+' %") OR '+

              '(psp_passport_number LIKE "% '+slA[i]+'%") OR '+'(psp_passport_number LIKE "% '+slA[i]+' %") OR '+

              '(psp_surname LIKE "% '+slA[i]+'%") OR '+'(psp_surname LIKE "% '+slA[i]+' %") OR '+

              '(psp_given_names LIKE "% '+slA[i]+'%") OR '+'(psp_given_names LIKE "% '+slA[i]+' %") OR '+

              '(psp_subname LIKE "% '+slA[i]+'%") OR '+'(psp_subname LIKE "% '+slA[i]+' %") OR '+

              '(psp_nationality LIKE "% '+slA[i]+'%") OR '+'(psp_nationality LIKE "% '+slA[i]+' %") OR '+

              '(psp_personal_number LIKE "% '+slA[i]+'%") OR '+'(psp_personal_number LIKE "% '+slA[i]+' %") OR '+

              '(psp_sex LIKE "% '+slA[i]+'%") OR '+'(psp_sex LIKE "% '+slA[i]+' %") OR '+

              '(psp_authority LIKE "% '+slA[i]+'%") OR '+'(psp_authority LIKE "% '+slA[i]+' %") OR '+

              '(psp_place_of_birth LIKE "% '+slA[i]+'%") OR '+'(psp_place_of_birth LIKE "% '+slA[i]+' %") OR '+

              '(psp_town LIKE "% '+slA[i]+'%") OR '+'(psp_town LIKE "% '+slA[i]+' %") OR '+

              '(psp_street LIKE "% '+slA[i]+'%") OR '+'(psp_street LIKE "% '+slA[i]+' %") OR '+

              '(psp_house_num LIKE "'+slA[i]+'%") OR '+'(psp_house_sym LIKE "'+slA[i]+'%") OR '+'(CONCAT(psp_house_num,psp_house_sym) LIKE "%'+slA[i]+'%") OR '+

              '(psp_subhouse_num LIKE "'+slA[i]+'%") OR '+'(psp_subhouse_sym LIKE "'+slA[i]+'%") OR '+'(CONCAT(psp_subhouse_num,psp_subhouse_sym) LIKE "%'+slA[i]+'%") OR '+

              '(psp_flat_num LIKE "'+slA[i]+'%") OR '+'(psp_flat_sym LIKE "'+slA[i]+'%") OR '+'(CONCAT(psp_flat_num,psp_flat_sym) LIKE "%'+slA[i]+'%") OR '+

              '(psp_other_info LIKE "% '+slA[i]+'%") OR '+'(psp_other_info LIKE "% '+slA[i]+' %") OR '+

              '(tpsp_number LIKE "% '+slA[i]+'%") OR '+'(tpsp_number LIKE "% '+slA[i]+' %") OR '+

              '(tpsp_auto_registration_sign LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_registration_sign LIKE "% '+slA[i]+' %") OR '+

              '(tpsp_auto_mark_model LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_mark_model LIKE "% '+slA[i]+' %") OR '+

              '(tpsp_auto_color LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_color LIKE "% '+slA[i]+' %") OR '+

              '(tpsp_auto_number_of_carriage LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_number_of_carriage LIKE "% '+slA[i]+' %") OR '+

              '(tpsp_auto_type LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_type LIKE "% '+slA[i]+' %") OR '+

              '(tpsp_auto_comments LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_comments LIKE "% '+slA[i]+' %") OR '+

              '(tpsp_other_info LIKE "% '+slA[i]+'%") OR '+'(tpsp_other_info LIKE "% '+slA[i]+' %")) ';
          end;
      end;
    while Pos('!%', q1)>0 do
      q1:=StringReplace(q1, '!%', '', [rfReplaceAll]);
    while Pos('! %', q1)>0 do
      q1:=StringReplace(q1, '! %', ' %', [rfReplaceAll]);
    while Pos('%%', q1)>0 do
      q1:=StringReplace(q1, '%%', '%', [rfReplaceAll]);
  finally
    slA.Free;
  end;
  if q1>'' then
    q:=q+'WHERE '+q1;
  q:=q+'GROUP BY x3 ORDER BY x1, x2;';
  s:='cxzasdewq';
  GroupId:=-1;
  LogThis(q, lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.', lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.', lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
              lvOwners.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  if not bError then
                    begin
                      // LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',lmtInfo);
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          // создание группы
                          if s<>ResultRow[0] then
                            begin
                              GroupId:=GroupId+1;
                              s:=ResultRow[0];
                              GetMem(pwcGroupName, SizeOf(WideChar)*1000);
                              try
                                FillChar(LvGroup, SizeOf(TLVGROUP), 0);
                                with LvGroup do
                                  begin
                                    cbSize:=SizeOf(TLVGROUP);
                                    mask:=LVGF_HEADER or LVGF_ALIGN or LVGF_GROUPID;
                                    pszHeader:=StringToWideChar(s, pwcGroupName, 1000);
                                    cchHeader:=Length(LvGroup.pszHeader);
                                    iGroupId:=GroupId;
                                    uAlign:=LVGA_HEADER_LEFT;
                                  end;
                                SendMessage(lvOwners.Handle, LVM_INSERTGROUP, -1, Longint(@LvGroup));
                              finally
                                FreeMem(pwcGroupName);
                              end;
                            end;
                          // создание элемента
                          if GroupId>-1 then
                            begin
                              ListItem:=lvOwners.Items.Add;
                              ListItem.Caption:=ResultRow[1];
                              // формирование строки адреса
                              s1:='';
                              if Trim(ResultRow[5])>'' then
                                begin
                                  if Trim(ResultRow[5])='Минск' then
                                    s1:='г. Минск'
                                  else
                                    s1:=Trim(ResultRow[5]);
                                end;
                              if Trim(ResultRow[6])>'' then
                                begin
                                  if s1>'' then
                                    begin
                                      if (Pos('проспект', Trim(ResultRow[6]))>0)or(Pos('бульвар', Trim(ResultRow[6]))>0)or(Pos('проезд', Trim(ResultRow[6]))>0)or(Pos('переулок', Trim(ResultRow[6]))>0)or(Pos('поселок', Trim(ResultRow[6]))>0)or
                                        (Pos('шоссе', Trim(ResultRow[6]))>0)or(Pos('тупик', Trim(ResultRow[6]))>0)or(Pos('тракт', Trim(ResultRow[6]))>0)or(Pos('микрорайон', Trim(ResultRow[6]))>0)or(Pos('площадь', Trim(ResultRow[6]))>0)or
                                        (Pos(' метро', Trim(ResultRow[6]))>0)or(Pos(' кольцо', Trim(ResultRow[6]))>0)or(Pos('деревня', Trim(ResultRow[6]))>0) then
                                        s1:=s1+', '
                                      else
                                        s1:=s1+', ул. ';
                                    end;
                                  s1:=s1+Trim(ResultRow[6]);
                                end;
                              if ((Trim(ResultRow[7])>'')and(Trim(ResultRow[7])<>'0'))or(Trim(ResultRow[8])>'') then
                                begin
                                  if s1>'' then
                                    s1:=s1+', д. ';
                                  s1:=s1+Trim(ResultRow[7])+Trim(ResultRow[8]);
                                end;
                              if ((Trim(ResultRow[9])>'')and(Trim(ResultRow[9])<>'0'))or(Trim(ResultRow[10])>'') then
                                begin
                                  if s1>'' then
                                    s1:=s1+', корп. ';
                                  s1:=s1+Trim(ResultRow[9])+Trim(ResultRow[10]);
                                end;
                              if ((Trim(ResultRow[11])>'')and(Trim(ResultRow[11])<>'0'))or(Trim(ResultRow[12])>'') then
                                begin
                                  if s1>'' then
                                    s1:=s1+', кв. ';
                                  s1:=s1+Trim(ResultRow[11])+Trim(ResultRow[12]);
                                end;
                              ListItem.SubItems.Add(s1);
                              if ResultRow[2]='0' then
                                ListItem.SubItems.Add('-')
                              else
                                ListItem.SubItems.Add(ResultRow[2]);
                              ListItem.SubItems.Add(ResultRow[3]);
                              if (ResultRow[4]='1') then
                                ListItem.ImageIndex:=DELETEDICON_ID
                              else
                                if (ResultRow[4]='0') then
                                  ListItem.ImageIndex:=EXISTINGICON_ID
                                else
                                  ListItem.ImageIndex:=UNKNOWNICON_ID;
                              with LvItemA do
                                begin
                                  FillChar(LvItemA, SizeOf(TLvItemA), 0);
                                  mask:=LVIF_GROUPID;
                                  iItem:=ListItem.index;
                                  iGroupId:=GroupId;
                                end;
                              SendMessage(lvOwners.Handle, LVM_SETITEM, 0, Longint(@LvItemA));
                            end;
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки!';
                          bError:=True;
                        end;
                      ProgressBar1.StepIt;
                    end;
                end;
              // вставить автоматическую "подгонку" ширины столбцов
              lvOwners.Items.EndUpdate;
              lvOwners.OnResize(nil);
            end
          else
            begin
              s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
          bError:=True;
        end;
      if ResultSet<>nil then
        begin
          LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
          mysql_free_result(ResultSet);
        end;
    end
  else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  if not bError then
    begin
      blvOwnerRedrawNow:=False; // перерисовка окна результатов поиска отключена
      lvOwners.SetFocus;
      if Sender<>nil then // если функция была вызвана из другой, а не по нажатию
        begin
          if lvOwners.Items.Count>0 then
            begin
              lvOwners.ItemIndex:=0;
              lvOwners.ItemFocused:=lvOwners.Items.Item[0];
            end
          else
            begin
              lvAutos.Items.BeginUpdate;
              SendMessage(lvAutos.Handle, LVM_REMOVEALLGROUPS, 0, 0);
              SendMessage(lvAutos.Handle, LVM_DELETEALLITEMS, 0, 0);
              lvAutos.Items.EndUpdate;
              // обновление значений панели создания/модификации
              lblCreationCaption.Visible:=False;
              lblCreation.Visible:=False;
              lblModificationCaption.Visible:=False;
              lblModification.Visible:=False;
              // обновление значений панели идентификатора
              if pnlID.Visible then
                begin
                  lblIDCaption.Visible:=False;
                  lblID.Visible:=False;
                end;
              // очистка значений контролов
              lblId.Caption:='';
              lblCreation.Caption:='';
              lblModification.Caption:='';
              Update_Actions;
            end;
        end;
    end;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      LogThis(s, lmtError);
      MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady;
end;

procedure TMainForm.miGoToMsrPanelClick(Sender: TObject);
begin
  if pnlConnectedMode.Visible and lvAutos.Visible and lvAutos.Enabled and(lvAutos.Items.Count>0) then
    lvAutos.SetFocus;
end;

procedure TMainForm.miGoToOrgPanelClick(Sender: TObject);
begin
  if pnlConnectedMode.Visible and lvOwners.Visible and lvOwners.Enabled and(lvOwners.Items.Count>0) then
    lvOwners.SetFocus;
end;
(*
  procedure TMainForm.btnSaveClick(Sender: TObject);
  var
  s, sMsrID, sOrgID: string;
  q, sRTF, sPlane, sa: AnsiString;
  RTFStream: TMemoryStream;
  pac: PAnsiChar;
  bError: boolean;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  i, j, iLastID, iOrgID, iMsrID, city_id, street_id, org_firm_code: integer;
  GroupId: integer;
  pwcGroupName: PWideChar;
  LvGroup: TLVGROUP;
  ListItem: TListItem;
  LvItemA: TLVITEMA;
  house_num, subhouse_num, flat_num: integer;
  house_sym, subhouse_sym, flat_sym: string;
  tp: TPoint;

  procedure DivideNumberAndSymbolParts(const Source: string; var Num: integer; var Sym: string);
  var
  i, j: integer;
  s: string;
  begin
  s:='';
  // начиная с первого символа строки-источника находим позицию, с которой строка перестаёт состоять из цифр
  for j:=1 to Length(Source) do
  begin
  s:=s+Source[j];
  i:=StrToIntDef(s,-1);
  if i=-1 then
  Break; // останов цикла при "натыкании" на символ, который уже невозможно преобразовать в число
  end;
  Num:=StrToIntDef(Copy(Source,0,j-1),0);
  Sym:=Copy(Source,j,Length(Source)-j+1);
  end;

  begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  sRTF:='';
  sPlane:='';
  bError:=False;
  iOrgID:=-1;
  iMsrID:=-1;
  org_firm_code:=-1;
  ProgressBar1.Step:=1;

  // получение ID города
  // получение / добавление ID улицы
  // получение / добавление ID org_firm_code
  // составление запроса на добавление / редактирование организации
  // добавление организации с получением ID добавленной организации
  // обновление данных в таблице фирм
  // обновление списка организаций
  // если добавленная есть в списке - установить курсор на неё, если нет - установить курсор на первой сверху организации

  if PageControl1.ActivePage=tsOwner then
  begin
  if bAddingOrgNow then
  begin
  LogThis('Производится добавление новой организации.',lmtInfo);
  ProgressBar1.Max:=9;
  end
  else
  begin
  if lvOwners.Selected<>nil then // определяем ID организации
  begin
  iOrgID:=StrToIntDef(lvOwners.Selected.SubItems[2],-1); // сохранение значения ID выделенной организации
  if iOrgID>=0 then
  LogThis('Производится внесение изменений в данные организации с ID='+IntToStr(iOrgID)+'.',lmtInfo)
  else
  begin
  s:='Возникла ошибка при получении ID редактируемой организации!';
  LogThis(s,lmtError);
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  MessageBox(Handle,PChar(s),PChar('GAIDB - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  SetReady;
  Exit;
  end;
  end
  else
  begin
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  SetReady;
  Exit;
  end;
  ProgressBar1.Max:=9;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;

  // подготовка информации полей редактирования организации для сохранения
  cmbbxOrgType.Text:=ValidateString(cmbbxOrgType.Text);
  edbxOrgName.Text:=ValidateString(edbxOrgName.Text);
  edbxOrgAddress.Text:=ValidateString(edbxOrgAddress.Text);
  cmbbxOrgTown.Text:=ValidateString(cmbbxOrgTown.Text);
  cmbbxOrgStreet.Text:=ValidateString(cmbbxOrgStreet.Text);
  edbxOrgHouse.Text:=ValidateString(edbxOrgHouse.Text);
  edbxOrgSubHouse.Text:=ValidateString(edbxOrgSubHouse.Text);
  edbxOrgFlat.Text:=ValidateString(edbxOrgFlat.Text);
  edbxOrgHowToReach.Text:=ValidateString(edbxOrgHowToReach.Text);
  cmbbxOrgWorkTime.Text:=ValidateString(cmbbxOrgWorkTime.Text);
  sPlane:=ValidateString(reOwnerOtherInfo.Text);
  DivideNumberAndSymbolParts(Trim(edbxOrgHouse.Text), house_num, house_sym); // получаем числовое и символьное значение дома
  DivideNumberAndSymbolParts(Trim(edbxOrgSubHouse.Text), subhouse_num, subhouse_sym); // получаем числовое и символьное значение корпуса
  DivideNumberAndSymbolParts(Trim(edbxOrgFlat.Text), flat_num, flat_sym); // получаем числовое и символьное значение квартиры
  ProgressBar1.StepIt;
  Application.ProcessMessages;

  // получение ID города
  city_id:=2507;
  ProgressBar1.StepIt;
  Application.ProcessMessages;

  // получение ID улицы
  street_id:=-1;
  q:='SELECT street_id FROM minsk.street WHERE name=UCASE('+NormalizeStringForQuery(cmbbxOrgStreet.Text, True, False)+') ORDER BY street_id;';
  LogThis(q,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
  begin
  LogThis('Запрос выполнен успешно.',lmtInfo);
  ResultSet:=mysql_store_result(MySQLConnectionHandler);
  try
  if ResultSet<>nil then
  begin
  LogThis('Результирующая выборка получена успешно.',lmtInfo);
  i:=mysql_num_rows(ResultSet);
  LogThis('Количество строк выборки равно '+IntToStr(i)+'.',lmtInfo);
  if (i>0) then
  begin
  LogThis('Попытка получения строки выборки.',lmtInfo);
  ResultRow:=mysql_fetch_row(ResultSet);
  if ResultRow<>nil then
  begin
  LogThis('Полученная строка - <'+ResultRow[0]+'>.',lmtInfo);
  street_id:=StrToIntDef(ResultRow[0],-1) // получен ID улицы (ID первого экземпляра)
  end
  else
  begin
  s:='Возникла ошибка при загрузке данных строки выборки!';
  bError:=True;
  end;
  end
  else
  if i=0 then
  street_id:=-1 // улица была не найдена, необходимо будет создать её
  else
  begin
  s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
  bError:=True;
  end;
  finally
  if ResultSet<>nil then
  begin
  LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
  mysql_free_result(ResultSet);
  end;
  end;
  end
  else
  begin
  s:='Возникла ошибка при выполнении запроса!';
  bError:=True;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  if bError then
  begin
  LogThis(s,lmtError);
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  MessageBox(Handle,PChar(s),PChar('GAIDB - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  SetReady;
  end;

  // добавление ID улицы
  if not bError then
  begin
  // если индекс записи улицы получен неверно, либо улица отсутствует в списке улиц, необходимо провести попытку создания улицы
  if street_id<0 then
  begin
  q:='INSERT INTO minsk.street (street_id, name, oper, date) VALUES (NULL, UCASE('+NormalizeStringForQuery(cmbbxOrgStreet.Text, True, False)+'), 0, NOW())';
  LogThis(q,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
  begin
  LogThis('Запрос выполнен успешно.',lmtInfo);
  iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной улицы
  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',lmtInfo);
  if (i=1) then
  begin
  LogThis('Добавление новой улицы произведено успешно',lmtInfo);
  street_id:=iLastID;
  end
  else
  begin
  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Возникла ошибка при выполнении запроса!';
  bError:=True;
  end;
  end;
  end;
  if not bError then
  begin
  if street_id<0 then
  begin
  s:='Не удалось получить идентификатор улицы!';
  bError:=True;
  end;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  if bError then
  begin
  LogThis(s,lmtError);
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  MessageBox(Handle,PChar(s),PChar('GAIDB - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  SetReady;
  end;

  // получение / добавление ID org_firm_code
  if not bError then
  begin
  if bAddingOrgNow then // добавление ID org_firm_code
  begin
  q:='INSERT INTO minsk.firma (firm_code, name, main, city_id, street_id, house_num, house_sym, subhouse_num, subhouse_sym, flat_num, flat_sym, comment, ext_comment, work, oper, date) VALUES (NULL, "';
  if Trim(edbxOrgName.Text)<>'' then
  q:=q+NormalizeStringForQuery(edbxOrgName.Text, False, False);
  q:=q+' |';
  if Trim(cmbbxOrgType.Text)<>'' then
  q:=q+NormalizeStringForQuery(cmbbxOrgType.Text, False, False);
  q:=q+'", '+
  '"!R", '+
  IntToStr(city_id)+', '+
  IntToStr(street_id)+', '+
  IntToStr(house_num)+', '+
  NormalizeStringForQuery(house_sym, True, False)+', '+
  IntToStr(subhouse_num)+', '+
  NormalizeStringForQuery(subhouse_sym, True, False)+', '+
  IntToStr(flat_num)+', '+
  NormalizeStringForQuery(flat_sym, True, False)+', '+
  '"", '+
  NormalizeStringForQuery(edbxOrgAddress.Text, True, True)+', '+
  '"", 0, NOW());';
  LogThis(q,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
  begin
  LogThis('Запрос выполнен успешно.',lmtInfo);
  iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной фирмы
  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',lmtInfo);
  if (i=1) then
  begin
  LogThis('Добавление новой фирмы произведено успешно',lmtInfo);
  org_firm_code:=iLastID;
  end
  else
  begin
  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Возникла ошибка при выполнении запроса!';
  bError:=True;
  end;
  end
  else // получение ID org_firm_code
  begin
  q:='SELECT org_firm_code FROM _org WHERE org_id='+IntToStr(iOrgID)+';';
  LogThis(q,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
  begin
  LogThis('Запрос выполнен успешно.',lmtInfo);
  ResultSet:=mysql_store_result(MySQLConnectionHandler);
  try
  if ResultSet<>nil then
  begin
  LogThis('Результирующая выборка получена успешно.',lmtInfo);
  i:=mysql_num_rows(ResultSet);
  LogThis('Количество строк выборки равно '+IntToStr(i)+'.',lmtInfo);
  if (i=1) then
  begin
  LogThis('Попытка получения строки выборки.',lmtInfo);
  ResultRow:=mysql_fetch_row(ResultSet);
  if ResultRow<>nil then
  begin
  LogThis('Полученная строка - <'+ResultRow[0]+'>.',lmtInfo);
  org_firm_code:=StrToIntDef(ResultRow[0],-1);
  end
  else
  begin
  s:='Возникла ошибка при загрузке данных строки выборки!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
  bError:=True;
  end;
  finally
  if ResultSet<>nil then
  begin
  LogThis('Освобождение ресурсов, занятых результатом выборки...',lmtInfo);
  mysql_free_result(ResultSet);
  end;
  end;
  end
  else
  begin
  s:='Возникла ошибка при выполнении запроса!';
  bError:=True;
  end;
  end;
  if not bError then
  begin
  if org_firm_code<0 then // если произошла ошибка при получении индекса записи, сгенерировать ошибку
  begin
  s:='Получен некорректный идентификатор номера записи в таблице minsk.firma!';
  bError:=True;
  end;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  if bError then
  begin
  LogThis(s,lmtError);
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  MessageBox(Handle,PChar(s),PChar('GAIDB - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  SetReady;
  end;
  end;

  // составление запроса на добавление / редактирование организации
  if not bError then
  begin
  if bAddingOrgNow then
  begin
  q:='INSERT INTO _org (org_id, org_erased, _org_type, _org_name, _org_address, org_firm_code, org_how_to_reach, org_work_time, org_other_info, org_other_info_rtf, org_created_at, org_created_by_user_id, org_modified_at, org_modified_by_user_id) VALUES '+
  '(NULL, "0", '+
  NormalizeStringForQuery(cmbbxOrgType.Text,True,True)+', '+
  NormalizeStringForQuery(edbxOrgName.Text,True,True)+', '+
  NormalizeStringForQuery(edbxOrgAddress.Text,True,True)+', '+
  IntToStr(org_firm_code)+', '+
  NormalizeStringForQuery(edbxOrgHowToReach.Text,True,True)+', '+
  NormalizeStringForQuery(cmbbxOrgWorkTime.Text,True,True)+', ';
  if Trim(sPlane)='' then // org_other_info, org_other_info_rtf
  q:=q+'NULL, NULL, '
  else
  begin
  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
  mysql_escape_string(pac, PAnsiChar(sPlane),Length(PAnsiChar(sPlane)));
  q:=q+'"'+StrPas(pac)+'", ';
  if pac<>nil then
  FreeMemory(pac);
  // преобразование текста RTF в строку с ESC-последовательностями
  RTFStream:=TMemoryStream.Create;
  try
  reOwnerOtherInfo.Lines.SaveToStream(RTFStream);
  RTFStream.Seek(0,soFromBeginning);
  pac:=GetMemory(RTFStream.Size*2+1);
  mysql_escape_string(pac,RTFStream.Memory,RTFStream.Size);
  q:=q+'"'+StrPas(pac)+'", ';
  finally
  if pac<>nil then
  FreeMemory(pac);
  RTFStream.Clear;
  RTFStream.Free;
  end;
  end;
  q:=q+'NOW(), '+CurrentUser.sID+', NOW(), '+CurrentUser.sID+');';
  end
  else
  begin
  q:='UPDATE _org SET '+
  '_org_type='+NormalizeStringForQuery(cmbbxOrgType.Text,True,True)+', '+
  '_org_name='+NormalizeStringForQuery(edbxOrgName.Text,True,True)+', '+
  '_org_address='+NormalizeStringForQuery(edbxOrgAddress.Text,True,True)+', '+
  'org_how_to_reach='+NormalizeStringForQuery(edbxOrgHowToReach.Text,True,True)+', '+
  'org_work_time='+NormalizeStringForQuery(cmbbxOrgWorkTime.Text,True,True)+', ';
  if Trim(sPlane)='' then // org_other_info, org_other_info_rtf
  begin
  q:=q+'org_other_info=NULL, ';
  q:=q+'org_other_info_rtf=NULL, ';
  end
  else
  begin
  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
  mysql_escape_string(pac, PAnsiChar(sPlane),Length(PAnsiChar(sPlane)));
  q:=q+'org_other_info="'+StrPas(pac)+'", ';
  if pac<>nil then
  FreeMemory(pac);
  // преобразование текста RTF в строку с ESC-последовательностями
  RTFStream:=TMemoryStream.Create;
  try
  reOwnerOtherInfo.Lines.SaveToStream(RTFStream);
  RTFStream.Seek(0,soFromBeginning);
  pac:=GetMemory(RTFStream.Size*2+1);
  mysql_escape_string(pac,RTFStream.Memory,RTFStream.Size);
  q:=q+'org_other_info_rtf="'+StrPas(pac)+'", ';
  finally
  if pac<>nil then
  FreeMemory(pac);
  RTFStream.Clear;
  RTFStream.Free;
  end;
  end;
  q:=q+'org_modified_at=NOW(), '+
  'org_modified_by_user_id='+CurrentUser.sID+' '+
  'WHERE org_id='+lvOwners.Selected.SubItems[2]+';';
  end;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;

  LogThis(q,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
  begin
  LogThis('Запрос выполнен успешно.',lmtInfo);
  iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной записи
  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',lmtInfo);
  if (i=1) then
  begin
  if bAddingOrgNow then
  begin
  iOrgID:=iLastID; // сохранение ID вставленной записи
  LogThis('Добавление данных о новой организации произведено успешно',lmtInfo);
  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'INS'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
  end
  else
  begin
  LogThis('Редактирование данных организации произведено успешно',lmtInfo);
  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'MOD'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
  end;
  Application.ProcessMessages;
  // запись статистики в БД
  LogThis('Внесение записи в таблицу событий.',lmtInfo);
  LogThis(q,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
  begin
  LogThis('Запрос выполнен успешно.',lmtInfo);
  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',lmtInfo);
  if (i=1) then
  LogThis('Запись в таблицу событий внесена успешно',lmtInfo)
  else
  begin
  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Возникла ошибка при выполнении запроса!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Возникла ошибка при выполнении запроса!';
  bError:=True;
  end;
  if not bError then
  begin
  if iOrgID<0 then // если произошла ошибка при получении индекса записи, сгенерировать ошибку
  begin
  s:='Получен некорректный идентификатор номера записи в таблице организаций!';
  bError:=True;
  end;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  if bError then
  begin
  LogThis(s,lmtError);
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  MessageBox(Handle,PChar(s),PChar('GAIDB - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  SetReady;
  end;

  // обновление данных в таблице фирм
  if not bError then
  begin
  if bAddingOrgNow then
  q:='UPDATE minsk.firma SET comment="'+IntToStr(iOrgID)+'", date=NOW() WHERE firm_code='+IntToStr(org_firm_code)+';'
  else
  begin
  q:='UPDATE minsk.firma SET name="';
  if Trim(edbxOrgName.Text)<>'' then
  q:=q+NormalizeStringForQuery(edbxOrgName.Text, False, False);
  q:=q+' |';
  if Trim(cmbbxOrgType.Text)<>'' then
  q:=q+NormalizeStringForQuery(cmbbxOrgType.Text, False, False);
  q:=q+'", '+
  'main="!R", '+
  'city_id='+IntToStr(city_id)+', '+
  'street_id='+IntToStr(street_id)+', '+
  'house_num='+IntToStr(house_num)+', '+
  'house_sym='+NormalizeStringForQuery(house_sym, True, False)+', '+
  'subhouse_num='+IntToStr(subhouse_num)+', '+
  'subhouse_sym='+NormalizeStringForQuery(subhouse_sym, True, False)+', '+
  'flat_num='+IntToStr(flat_num)+', '+
  'flat_sym='+NormalizeStringForQuery(flat_sym, True, False)+', '+
  'comment="'+IntToStr(iOrgID)+'", '+
  'ext_comment='+NormalizeStringForQuery(edbxOrgAddress.Text, True, True)+', '+
  'date=NOW() WHERE firm_code='+IntToStr(org_firm_code)+';';
  end;
  end;
  LogThis(q,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
  begin
  LogThis('Запрос выполнен успешно.',lmtInfo);
  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',lmtInfo);
  if (i=1) then
  LogThis('Постобработка данных записи таблицы фирмпроизведена успешно',lmtInfo)
  else
  begin
  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Возникла ошибка при выполнении запроса!';
  bError:=True;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  if bError then
  begin
  LogThis(s,lmtError);
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  MessageBox(Handle,PChar(s),PChar('GAIDB - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  SetReady;
  end;
  bAddingOrgNow:=False;

  btbtnSearchClick(nil); // когда допишу формирование запроса на основе усправляющих элементов, тогда нужно заменить код полной копией
  lvOwners.Items.BeginUpdate;
  for i:=0 to lvOwners.Items.Count-1 do
  if lvOwners.Items[i]<>nil then
  begin
  if lvOwners.Items[i].SubItems[2]=IntToStr(iOrgID) then
  begin
  lvOwners.ItemIndex:=i;
  lvOwners.ItemFocused:=lvOwners.Items.Item[i];
  tp:=lvOwners.ItemFocused.GetPosition;
  lvOwners.Scroll(tp.X,tp.Y-23);
  lvOwners.ItemFocused.MakeVisible(False);
  lvOwners.SetFocus;
  end;
  end;
  lvOwners.Items.EndUpdate;
  end;

  // подготовка данных для сохранения
  // получение ID выделенной организации/мероприятия
  // составление запроса на добавление / редактирование мероприятия
  // добавление мероприятия с получением ID добавленного мероприятия
  // обновление данных в таблице фирм
  // обновление списка мероприятий
  // обновление значения количества мероприятий в выделенной организации
  // если добавленное мероприятие есть в списке - установить курсор на него если нет - установить курсор на первое сверху мероприятие


  if PageControl1.ActivePage=tsAuto then
  begin

  // подготовка данных для сохранения
  cmbbxMsrType.Text:=ValidateString(cmbbxMsrType.Text);
  edbxMsrName.Text:=ValidateString(edbxMsrName.Text);
  cmbbxMsrAuthor.Text:=ValidateString(cmbbxMsrAuthor.Text);
  cmbbxMsrProducer.Text:=ValidateString(cmbbxMsrProducer.Text);
  cmbbxMsrPerformer.Text:=ValidateString(cmbbxMsrPerformer.Text);
  cmbbxMsrOrganizer.Text:=ValidateString(cmbbxMsrOrganizer.Text);
  meMsrTicketPrice.Text:=ValidateString(meMsrTicketPrice.Text);
  sPlane:=ValidateString(reAutoOtherInfo.Text);
  ProgressBar1.StepIt;
  Application.ProcessMessages;

  // получение ID выделенной организации/мероприятия
  if bAddingMsrNow then
  begin
  if lvOwners.Selected<>nil then // определяем ID организации
  begin
  iOrgID:=StrToIntDef(lvOwners.Selected.SubItems[2],-1); // сохранение значения ID выделенной организации
  if iOrgID>=0 then
  LogThis('Производится добавление нового мероприятия для организации с ID='+IntToStr(iOrgID)+'.',lmtInfo)
  else
  begin
  s:='Возникла ошибка при получении ID организации-владельца создаваемого мероприятия!';
  bError:=True;
  end;
  ProgressBar1.Max:=5;
  end
  else
  begin
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  SetReady;
  Exit;
  end;
  end
  else
  begin
  if lvOwners.Selected<>nil then // определяем ID организации
  begin
  iOrgID:=StrToIntDef(lvOwners.Selected.SubItems[2],-1); // сохранение значения ID выделенной организации
  if iOrgID>=0 then
  LogThis('Производится редактирование мероприятия принадлежащего организации с ID='+IntToStr(iOrgID)+'.',lmtInfo)
  else
  begin
  s:='Возникла ошибка при получении ID организации-владельца редактируемого мероприятия!';
  bError:=True;
  end;
  ProgressBar1.Max:=5;
  end
  else
  begin
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  SetReady;
  Exit;
  end;
  if lvAutos.Selected<>nil then // определяем ID редактируемого мероприятия
  begin
  iMsrID:=StrToIntDef(lvAutos.Selected.SubItems[2],-1); // сохранение значения ID выделенного мероприятия
  if iMsrID>=0 then
  begin
  LogThis('Производится внесение изменений в данные мероприятия с ID='+IntToStr(iMsrID)+'.',lmtInfo);
  end
  else
  begin
  s:='Возникла ошибка при получении ID редактируемого мероприятия!';
  bError:=True;
  end;
  ProgressBar1.Max:=2;
  end
  else
  begin
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  SetReady;
  Exit;
  end;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  if bError then
  begin
  LogThis(s,lmtError);
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  MessageBox(Handle,PChar(s),PChar('GAIDB - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  SetReady;
  end;

  // составление запроса на добавление / редактирование мероприятия
  if not bError then
  begin
  if bAddingMsrNow then
  begin
  q:='INSERT INTO _msr (msr_id, msr_erased, msr_start_datetime, msr_stop_datetime, _msr_duration, msr_organization_id, ';
  q:=q+'msr_is_premier, msr_is_tour, msr_for_children, msr_for_teenagers, msr_for_adults_only, ';
  q:=q+'msr_type, msr_name, msr_author, msr_producer, msr_performer, msr_organizer, msr_ticket_price, msr_other_info, msr_other_info_rtf, ';
  q:=q+'msr_created_at, msr_created_by_user_id, msr_modified_at, msr_modified_by_user_id) VALUES (';
  q:=q+'NULL, "0", '; // msr_id, msr_erased
  if chkbxMsrStart.Checked then // msr_start_datetime
  q:=q+'"'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStartDate.DateTime)+'", '
  else q:=q+'NULL, ';
  if chkbxMsrStop.Checked then // msr_stop_datetime
  q:=q+'"'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStopDate.DateTime)+'", '
  else q:=q+'NULL, ';
  q:=q+'NULL, '+IntToStr(iOrgID)+', '+ // _msr_duration, msr_organization_id
  '"'+IntToStr(integer(chkbxMsrIsPremier.Checked))+'", '+ // msr_is_premier
  '"'+IntToStr(integer(chkbxMsrIsTour.Checked))+'", '+ // msr_is_tour
  '"'+IntToStr(integer(chkbxMsrForChildren.Checked))+'", '+ // msr_for_children
  '"'+IntToStr(integer(chkbxMsrForTeenagers.Checked))+'", '+ // msr_for_teenagers
  '"'+IntToStr(integer(chkbxMsrForAdultsOnly.Checked))+'", '+ // msr_for_adults_only
  NormalizeStringForQuery(cmbbxMsrType.Text,True,True)+', '+ // msr_type
  NormalizeStringForQuery(edbxMsrName.Text,True,True)+', '+ // msr_name
  NormalizeStringForQuery(cmbbxMsrAuthor.Text,True,True)+', '+ // msr_author
  NormalizeStringForQuery(cmbbxMsrProducer.Text,True,True)+', '+ // msr_producer
  NormalizeStringForQuery(cmbbxMsrPerformer.Text,True,True)+', '+ // msr_performer
  NormalizeStringForQuery(cmbbxMsrOrganizer.Text,True,True)+', '+ // msr_organizer
  NormalizeStringForQuery(meMsrTicketPrice.Text,True,True)+', '; // msr_ticket_price
  if Trim(sPlane)='' then // msr_other_info, msr_other_info_rtf
  q:=q+'NULL, NULL, '
  else
  begin
  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
  mysql_escape_string(pac, PAnsiChar(sPlane),Length(PAnsiChar(sPlane)));
  q:=q+'"'+StrPas(pac)+'", ';
  if pac<>nil then
  FreeMemory(pac);
  // преобразование текста RTF в строку с ESC-последовательностями
  RTFStream:=TMemoryStream.Create;
  try
  reAutoOtherInfo.Lines.SaveToStream(RTFStream);
  RTFStream.Seek(0,soFromBeginning);
  pac:=GetMemory(RTFStream.Size*2+1);
  mysql_escape_string(pac,RTFStream.Memory,RTFStream.Size);
  q:=q+'"'+StrPas(pac)+'", ';
  finally
  if pac<>nil then
  FreeMemory(pac);
  RTFStream.Clear;
  RTFStream.Free;
  end;
  end;
  q:=q+'NOW(), ' +CurrentUser.sID+', '+'NOW(), ' +CurrentUser.sID+');';
  end
  else
  begin
  q:='UPDATE _msr SET ';
  if chkbxMsrStart.Checked then
  q:=q+'msr_start_datetime="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStartDate.DateTime)+'", '
  else q:=q+'msr_start_datetime=NULL, ';
  if chkbxMsrStop.Checked then
  q:=q+'msr_stop_datetime="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStopDate.DateTime)+'", '
  else q:=q+'msr_stop_datetime=NULL, ';
  q:=q+'msr_is_premier="'+IntToStr(integer(chkbxMsrIsPremier.Checked))+'", '+
  'msr_is_tour="'+IntToStr(integer(chkbxMsrIsTour.Checked))+'", '+
  'msr_for_children="'+IntToStr(integer(chkbxMsrForChildren.Checked))+'", '+
  'msr_for_teenagers="'+IntToStr(integer(chkbxMsrForTeenagers.Checked))+'", '+
  'msr_for_adults_only="'+IntToStr(integer(chkbxMsrForAdultsOnly.Checked))+'", '+
  'msr_type='+NormalizeStringForQuery(cmbbxMsrType.Text,True,True)+', '+
  'msr_name='+NormalizeStringForQuery(edbxMsrName.Text,True,True)+', '+
  'msr_author='+NormalizeStringForQuery(cmbbxMsrAuthor.Text,True,True)+', '+
  'msr_producer='+NormalizeStringForQuery(cmbbxMsrProducer.Text,True,True)+', '+
  'msr_performer='+NormalizeStringForQuery(cmbbxMsrPerformer.Text,True,True)+', '+
  'msr_organizer='+NormalizeStringForQuery(cmbbxMsrOrganizer.Text,True,True)+', '+
  'msr_ticket_price='+NormalizeStringForQuery(meMsrTicketPrice.Text,True,True)+', ';
  if Trim(sPlane)='' then
  q:=q+'msr_other_info=NULL, msr_other_info_rtf=NULL, '
  else
  begin
  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
  mysql_escape_string(pac, PAnsiChar(sPlane),Length(PAnsiChar(sPlane)));
  q:=q+'msr_other_info="'+StrPas(pac)+'", ';
  if pac<>nil then
  FreeMemory(pac);
  // преобразование текста RTF в строку с ESC-последовательностями
  RTFStream:=TMemoryStream.Create;
  try
  reAutoOtherInfo.Lines.SaveToStream(RTFStream);
  RTFStream.Seek(0,soFromBeginning);
  pac:=GetMemory(RTFStream.Size*2+1);
  mysql_escape_string(pac,RTFStream.Memory,RTFStream.Size);
  q:=q+'msr_other_info_rtf="'+StrPas(pac)+'", ';
  finally
  if pac<>nil then
  FreeMemory(pac);
  RTFStream.Clear;
  RTFStream.Free;
  end;
  end;
  q:=q+'msr_modified_at=NOW(), msr_modified_by_user_id='+CurrentUser.sID+' WHERE msr_id='+IntToStr(iMsrID)+';';
  end;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;

  LogThis(q,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
  begin
  LogThis('Запрос выполнен успешно.',lmtInfo);
  iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной записи
  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',lmtInfo);
  if (i=1) then
  begin
  if bAddingMsrNow then
  begin
  iMsrID:=iLastID; // сохранение ID вставленной записи
  LogThis('Добавление данных о новом мероприятии произведено успешно',lmtInfo);
  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'INS'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
  end
  else
  begin
  LogThis('Редактирование данных мероприятия произведено успешно',lmtInfo);
  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'MOD'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
  end;
  Application.ProcessMessages;
  // запись статистики в БД
  LogThis('Внесение записи в таблицу событий.',lmtInfo);
  LogThis(q,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
  begin
  LogThis('Запрос выполнен успешно.',lmtInfo);
  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',lmtInfo);
  if (i=1) then
  LogThis('Запись в таблицу событий внесена успешно',lmtInfo)
  else
  begin
  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Возникла ошибка при выполнении запроса!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
  bError:=True;
  end;
  end
  else
  begin
  s:='Возникла ошибка при выполнении запроса!';
  bError:=True;
  end;
  if not bError then
  begin
  if iMsrID<0 then // если произошла ошибка при получении индекса записи, сгенерировать ошибку
  begin
  s:='Получен некорректный идентификатор номера записи в таблице мероприятий!';
  bError:=True;
  end;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  if bError then
  begin
  LogThis(s,lmtError);
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  MessageBox(Handle,PChar(s),PChar('GAIDB - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  SetReady;
  end;
  bAddingMsrNow:=False;

  btbtnSearchClick(nil); // когда допишу формирование запроса на основе усправляющих элементов, тогда нужно заменить код полной копией

  lvOwners.Items.BeginUpdate;
  for i:=0 to lvOwners.Items.Count-1 do
  if lvOwners.Items[i]<>nil then
  begin
  if lvOwners.Items[i].SubItems[2]=IntToStr(iOrgID) then
  begin
  lvOwners.ItemIndex:=i;
  lvOwners.ItemFocused:=lvOwners.Items.Item[i];
  tp:=lvOwners.ItemFocused.GetPosition;
  lvOwners.Scroll(tp.X,tp.Y-23);
  lvOwners.ItemFocused.MakeVisible(False);
  end;
  end;
  lvOwners.Items.EndUpdate;
  lvAutos.Items.BeginUpdate;
  for i:=0 to lvAutos.Items.Count-1 do
  if lvAutos.Items[i]<>nil then
  begin
  if lvAutos.Items[i].SubItems[2]=IntToStr(iMsrID) then
  begin
  lvAutos.ItemIndex:=i;
  lvAutos.ItemFocused:=lvAutos.Items.Item[i];
  tp:=lvAutos.ItemFocused.GetPosition;
  lvAutos.Scroll(tp.X,tp.Y-23);
  lvAutos.ItemFocused.MakeVisible(False);
  lvAutos.SetFocus;
  end;
  end;
  lvAutos.Items.EndUpdate;
  end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  SetReady;
  end;
*)

procedure TMainForm.SaveModifyOwner;
var
  s: string;
  q, sRTF, sPlane: AnsiString;
  RTFStream: TMemoryStream;
  pac: PAnsiChar;
  bError: boolean;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  i, iLastID, iOwnerID, street_id: integer; // , org_firm_code
  house_num, subhouse_num, flat_num: integer;
  house_sym, subhouse_sym, flat_sym: string;
  tp: TPoint;
begin
  Screen.Cursor:=crHourGlass;
  sRTF:='';
  sPlane:='';
  bError:=False;
  iOwnerID:=-1;
  // org_firm_code:=-1;
  ProgressBar1.Step:=1;
  // составление запроса на добавление / редактирование организации
  // добавление организации с получением ID добавленной организации
  // обновление данных в таблице фирм
  // обновление списка организаций
  // если добавленная есть в списке - установить курсор на неё, если нет - установить курсор на первой сверху организации
  if PageControl1.ActivePage=tsOwner then
    begin
      if bAddingOwnerNow then
        begin
          LogThis('Производится добавление нового владельца.', lmtInfo);
          ProgressBar1.Max:=9;
        end
      else
        begin
          if lvOwners.Selected<>nil then // определяем ID владельца
            begin
              iOwnerID:=StrToIntDef(lvOwners.Selected.SubItems[2], -1); // сохранение значения ID выделенного владельца
              if iOwnerID>=0 then
                LogThis('Производится внесение изменений в данные владельца с ID='+IntToStr(iOwnerID)+'.', lmtInfo)
              else
                begin
                  s:='Возникла ошибка при получении ID редактируемой записи о владельце!';
                  LogThis(s, lmtError);
                  ProgressBar1.Position:=ProgressBar1.Min;
                  Screen.Cursor:=crDefault;
                  MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                  SetReady;
                  Exit;
                end;
            end
          else
            begin
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady;
              Exit;
            end;
          ProgressBar1.Max:=5;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // подготовка информации полей редактирования для сохранения
      cmbbxOwnerType.Text:=ValidateString(cmbbxOwnerType.Text);
      cmbbxOwnerCodeOfIssuingState.Text:=ValidateString(cmbbxOwnerCodeOfIssuingState.Text);
      edbxOwnerPassportNumber.Text:=ValidateString(edbxOwnerPassportNumber.Text);
      edbxOwnerSurname.Text:=ValidateString(edbxOwnerSurname.Text);
      edbxOwnerGivenNames.Text:=ValidateString(edbxOwnerGivenNames.Text);
      edbxOwnerSubname.Text:=ValidateString(edbxOwnerSubname.Text);
      cmbbxOwnerNationality.Text:=ValidateString(cmbbxOwnerNationality.Text);
      edbxOwnerPlaceOfBirth.Text:=ValidateString(edbxOwnerPlaceOfBirth.Text);
      edbxOwnerPrivateNumber.Text:=ValidateString(edbxOwnerPrivateNumber.Text);
      cmbbxOwnerAuthority.Text:=ValidateString(cmbbxOwnerAuthority.Text);
      cmbbxOwnerTown.Text:=ValidateString(cmbbxOwnerTown.Text);
      cmbbxOwnerStreet.Text:=ValidateString(cmbbxOwnerStreet.Text);
      sPlane:=ValidateString(reOwnerOtherInfo.Text);
      DivideNumberAndSymbolParts(Trim(edbxOwnerHouse.Text), house_num, house_sym); // получаем числовое и символьное значение дома
      DivideNumberAndSymbolParts(Trim(edbxOwnerSubHouse.Text), subhouse_num, subhouse_sym); // получаем числовое и символьное значение корпуса
      DivideNumberAndSymbolParts(Trim(edbxOwnerFlat.Text), flat_num, flat_sym); // получаем числовое и символьное значение квартиры
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // составление запроса на добавление / редактирование владельца
      if not bError then
        begin
          if bAddingOwnerNow then
            begin
              q:='INSERT INTO _psp (psp_id, psp_erased, psp_type, psp_code_of_issuing_state, psp_passport_number, psp_surname, psp_given_names, psp_subname, psp_nationality, psp_date_of_birth, psp_personal_number, psp_sex, '+
                'psp_place_of_birth, psp_date_of_issue, psp_authority, psp_date_of_expiry, psp_town, psp_street, psp_house_num, psp_house_sym, psp_subhouse_num, psp_subhouse_sym, psp_flat_num, psp_flat_sym, psp_other_info, '+
                'psp_other_info_rtf, psp_created_at, psp_created_by_user_id, psp_modified_at, psp_modified_by_user_id) VALUES '+'(NULL, "0", '+NormalizeStringForQuery(cmbbxOwnerType.Text, True, True)+', '+NormalizeStringForQuery
                (cmbbxOwnerCodeOfIssuingState.Text, True, True)+', '+NormalizeStringForQuery(edbxOwnerPassportNumber.Text, True, True)+', '+NormalizeStringForQuery(edbxOwnerSurname.Text, True, True)+', '+NormalizeStringForQuery
                (edbxOwnerGivenNames.Text, True, True)+', '+NormalizeStringForQuery(edbxOwnerSubname.Text, True, True)+', '+NormalizeStringForQuery(cmbbxOwnerNationality.Text, True, True)+', ';
              if dtpOwnerDateOfBirth.Date=Date then
                q:=q+'NULL, '
              else
                q:=q+'"'+FormatDateTime('yyyy-mm-dd', dtpOwnerDateOfBirth.DateTime)+'", ';
              q:=q+NormalizeStringForQuery(edbxOwnerPrivateNumber.Text, True, True)+', ';
              case cmbbxOwnerSex.ItemIndex of
                -1, 0:
                  q:=q+'NULL, ';
                1:
                  q:=q+'"муж", ';
                2:
                  q:=q+'"жен", ';
              end;
              q:=q+NormalizeStringForQuery(edbxOwnerPlaceOfBirth.Text, True, True)+', '+'"'+FormatDateTime('yyyy-mm-dd', dtpOwnerDateOfIssue.DateTime)+'", '+NormalizeStringForQuery(cmbbxOwnerAuthority.Text, True, True)+', '+'"'+FormatDateTime
                ('yyyy-mm-dd', dtpOwnerDateOfExpiry.DateTime)+'", '+NormalizeStringForQuery(cmbbxOwnerTown.Text, True, True)+', '+NormalizeStringForQuery(cmbbxOwnerStreet.Text, True, True)+', '+IntToStr(house_num)+', '+NormalizeStringForQuery
                (house_sym, True, False)+', '+IntToStr(subhouse_num)+', '+NormalizeStringForQuery(subhouse_sym, True, False)+', '+IntToStr(flat_num)+', '+NormalizeStringForQuery(flat_sym, True, False)+', ';
              if Trim(sPlane)='' then
                q:=q+'NULL, NULL, '
              else
                begin
                  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
                  mysql_escape_string(pac, PAnsiChar(sPlane), Length(PAnsiChar(sPlane)));
                  q:=q+'"'+StrPas(pac)+'", ';
                  if pac<>nil then
                    FreeMemory(pac);
                  // преобразование текста RTF в строку с ESC-последовательностями
                  RTFStream:=TMemoryStream.Create;
                  try
                    reOwnerOtherInfo.Lines.SaveToStream(RTFStream);
                    RTFStream.Seek(0, soFromBeginning);
                    pac:=GetMemory(RTFStream.Size*2+1);
                    mysql_escape_string(pac, RTFStream.Memory, RTFStream.Size);
                    q:=q+'"'+StrPas(pac)+'", ';
                  finally
                    if pac<>nil then
                      FreeMemory(pac);
                    RTFStream.Clear;
                    RTFStream.Free;
                  end;
                end;
              q:=q+'NOW(), '+CurrentUser.sID+', NOW(), '+CurrentUser.sID+');';
            end
          else
            begin
              q:='UPDATE _psp SET '+'psp_type='+NormalizeStringForQuery(cmbbxOwnerType.Text, True, True)+', '+'psp_code_of_issuing_state='+NormalizeStringForQuery(cmbbxOwnerCodeOfIssuingState.Text, True, True)
                +', '+'psp_passport_number='+NormalizeStringForQuery(edbxOwnerPassportNumber.Text, True, True)+', '+'psp_surname='+NormalizeStringForQuery(edbxOwnerSurname.Text, True, True)+', '+'psp_given_names='+NormalizeStringForQuery
                (edbxOwnerGivenNames.Text, True, True)+', '+'psp_subname='+NormalizeStringForQuery(edbxOwnerSubname.Text, True, True)+', '+'psp_nationality='+NormalizeStringForQuery(cmbbxOwnerNationality.Text, True, True)+', ';
              if dtpOwnerDateOfBirth.Date=Date then
                q:=q+'psp_date_of_birth=NULL, '
              else
                q:=q+'psp_date_of_birth="'+FormatDateTime('yyyy-mm-dd', dtpOwnerDateOfBirth.DateTime)+'", ';
              q:=q+'psp_personal_number='+NormalizeStringForQuery(edbxOwnerPrivateNumber.Text, True, True)+', ';
              case cmbbxOwnerSex.ItemIndex of
                -1, 0:
                  q:=q+'psp_sex=NULL, ';
                1:
                  q:=q+'psp_sex="муж", ';
                2:
                  q:=q+'psp_sex="жен", ';
              end;
              q:=q+'psp_place_of_birth='+NormalizeStringForQuery(edbxOwnerPlaceOfBirth.Text, True, True)+', '+'psp_date_of_issue="'+FormatDateTime('yyyy-mm-dd', dtpOwnerDateOfIssue.DateTime)+'", '+'psp_authority='+NormalizeStringForQuery
                (cmbbxOwnerAuthority.Text, True, True)+', '+'psp_date_of_expiry="'+FormatDateTime('yyyy-mm-dd', dtpOwnerDateOfExpiry.DateTime)+'", '+'psp_town='+NormalizeStringForQuery(cmbbxOwnerTown.Text, True, True)
                +', '+'psp_street='+NormalizeStringForQuery(cmbbxOwnerStreet.Text, True, True)+', '+'psp_house_num='+IntToStr(house_num)+', '+'psp_house_sym='+NormalizeStringForQuery(house_sym, True, False)+', '+'psp_subhouse_num='+IntToStr
                (subhouse_num)+', '+'psp_subhouse_sym='+NormalizeStringForQuery(subhouse_sym, True, False)+', '+'psp_flat_num='+IntToStr(flat_num)+', '+'psp_flat_sym='+NormalizeStringForQuery(flat_sym, True, False)+', ';
              if Trim(sPlane)='' then
                begin
                  q:=q+'psp_other_info=NULL, ';
                  q:=q+'psp_other_info_rtf=NULL, ';
                end
              else
                begin
                  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
                  mysql_escape_string(pac, PAnsiChar(sPlane), Length(PAnsiChar(sPlane)));
                  q:=q+'psp_other_info="'+StrPas(pac)+'", ';
                  if pac<>nil then
                    FreeMemory(pac);
                  // преобразование текста RTF в строку с ESC-последовательностями
                  RTFStream:=TMemoryStream.Create;
                  try
                    reOwnerOtherInfo.Lines.SaveToStream(RTFStream);
                    RTFStream.Seek(0, soFromBeginning);
                    pac:=GetMemory(RTFStream.Size*2+1);
                    mysql_escape_string(pac, RTFStream.Memory, RTFStream.Size);
                    q:=q+'psp_other_info_rtf="'+StrPas(pac)+'", ';
                  finally
                    if pac<>nil then
                      FreeMemory(pac);
                    RTFStream.Clear;
                    RTFStream.Free;
                  end;
                end;
              q:=q+'psp_modified_at=NOW(), '+'psp_modified_by_user_id='+CurrentUser.sID+' '+'WHERE psp_id='+lvOwners.Selected.SubItems[2]+';';
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      LogThis(q, lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
      if i=0 then
        begin
          LogThis('Запрос выполнен успешно.', lmtInfo);
          iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной записи
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
          if (i=1) then
            begin
              if bAddingOwnerNow then
                begin
                  iOwnerID:=iLastID; // сохранение ID вставленной записи
                  LogThis('Добавление данных о новом владельце произведено успешно', lmtInfo);
                  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'INS'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                end
              else
                begin
                  LogThis('Редактирование данных владельца произведено успешно', lmtInfo);
                  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'MOD'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                end;
              Application.ProcessMessages;
              // запись статистики в БД
              LogThis('Внесение записи в таблицу событий.', lmtInfo);
              LogThis(q, lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.', lmtInfo);
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                  if (i=1) then
                    LogThis('Запись в таблицу событий внесена успешно', lmtInfo)
                  else
                    begin
                      s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Возникла ошибка при выполнении запроса!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
      if not bError then
        begin
          if iOwnerID<0 then // если произошла ошибка при получении индекса записи, сгенерировать ошибку
            begin
              s:='Получен некорректный идентификатор номера записи в таблице владельцев!';
              bError:=True;
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s, lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady;
        end;

      bAddingOwnerNow:=False;

      btbtnSearchClick(nil);
      lvOwners.Items.BeginUpdate;
      for i:=0 to lvOwners.Items.Count-1 do
        if lvOwners.Items[i]<>nil then
          begin
            if lvOwners.Items[i].SubItems[2]=IntToStr(iOwnerID) then
              begin
                lvOwners.ItemIndex:=i;
                lvOwners.ItemFocused:=lvOwners.Items.Item[i];
                tp:=lvOwners.ItemFocused.GetPosition;
                lvOwners.Scroll(tp.X, tp.Y-23);
                lvOwners.ItemFocused.MakeVisible(False);
                lvOwners.SetFocus;
              end;
          end;
      lvOwners.Items.EndUpdate;
    end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  SetReady;
end;

procedure TMainForm.SaveModifyAuto;
var
  s: string;
  q, sRTF, sPlane: AnsiString;
  RTFStream: TMemoryStream;
  pac: PAnsiChar;
  bError: boolean;
  i, iLastID, iOwnerID, iAutoID: integer;
  tp: TPoint;
begin
  sRTF:='';
  sPlane:='';
  bError:=False;
  iAutoID:=-1;
  ProgressBar1.Step:=1;
  // подготовка данных для сохранения
  // получение ID выделенного владельца/автосредства
  // составление запроса на добавление / редактирование автосредства
  // добавление мероприятия с получением ID добавленного автосредства
  // - обновление данных в таблице фирм
  // обновление списка автосредств
  // обновление значения количества автосредств в выделенном владельце
  // если добавленное автосредство есть в списке - установить курсор на него если нет - установить курсор на первое сверху автосредство
  if PageControl1.ActivePage=tsAuto then
    begin
      ProgressBar1.Max:=5;
      // подготовка данных для сохранения
      edbxAutoNumber.Text:=ValidateString(edbxAutoNumber.Text);
      edbxAutoRegistrationSign.Text:=ValidateString(edbxAutoRegistrationSign.Text);
      cmbbxAutoMarkModel.Text:=ValidateString(cmbbxAutoMarkModel.Text);
      cmbbxAutoColor.Text:=ValidateString(cmbbxAutoColor.Text);
      edbxAutoMaximumMass.Text:=ValidateString(edbxAutoMaximumMass.Text);
      edbxAutoNumberOfCarriage.Text:=ValidateString(edbxAutoNumberOfCarriage.Text);
      edbxAutoMassWithoutLoad.Text:=ValidateString(edbxAutoMassWithoutLoad.Text);
      cmbbxAutoType.Text:=ValidateString(cmbbxAutoType.Text);
      meAutoComments.Text:=ValidateString(meAutoComments.Text);
      sPlane:=ValidateString(reAutoOtherInfo.Text);
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // получение ID выделенного владельца/автосредства
      if bAddingAutoNow then
        begin
          if lvOwners.Selected<>nil then // определяем ID владельца
            begin
              iOwnerID:=StrToIntDef(lvOwners.Selected.SubItems[2], -1); // сохранение значения ID выделенного владельца
              if iOwnerID>=0 then
                LogThis('Производится добавление нового автосредства для владельца с ID='+IntToStr(iOwnerID)+'.', lmtInfo)
              else
                begin
                  s:='Возникла ошибка при получении ID владельца создаваемого автосредства!';
                  bError:=True;
                end;
              ProgressBar1.Max:=5;
            end
          else
            begin
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady;
              Exit;
            end;
        end
      else
        begin
          if lvOwners.Selected<>nil then // определяем ID владельца
            begin
              iOwnerID:=StrToIntDef(lvOwners.Selected.SubItems[2], -1); // сохранение значения ID выделенного владельца
              if iOwnerID>=0 then
                LogThis('Производится редактирование автосредства принадлежащего владельцу с ID='+IntToStr(iOwnerID)+'.', lmtInfo)
              else
                begin
                  s:='Возникла ошибка при получении ID владельца редактируемого автосредства!';
                  bError:=True;
                end;
              ProgressBar1.Max:=5;
            end
          else
            begin
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady;
              Exit;
            end;
          if lvAutos.Selected<>nil then // определяем ID редактируемого автосредства
            begin
              iAutoID:=StrToIntDef(lvAutos.Selected.SubItems[2], -1); // сохранение значения ID выделенного автосредства
              if iAutoID>=0 then
                begin
                  LogThis('Производится внесение изменений в данные автосредства с ID='+IntToStr(iAutoID)+'.', lmtInfo);
                end
              else
                begin
                  s:='Возникла ошибка при получении ID редактируемого автосредства!';
                  bError:=True;
                end;
              ProgressBar1.Max:=2;
            end
          else
            begin
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady;
              Exit;
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s, lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady;
        end;

      // составление запроса на добавление / редактирование автосредства
      if not bError then
        begin
          if bAddingAutoNow then
            begin
              q:='INSERT INTO _tpsp (tpsp_id, tpsp_erased, tpsp_psp_id, tpsp_number, tpsp_date_of_issue, tpsp_auto_registration_sign, ';
              q:=q+'tpsp_auto_mark_model, tpsp_auto_year_of_edition, tpsp_auto_color, tpsp_auto_number_of_carriage, tpsp_auto_type, ';
              q:=q+'tpsp_auto_maximum_mass, tpsp_auto_mass_without_load, tpsp_auto_comments, tpsp_other_info, tpsp_other_info_rtf, ';
              q:=q+'tpsp_created_at, tpsp_created_by_user_id, tpsp_modified_at, tpsp_modified_by_user_id) VALUES (';
              q:=q+'NULL, "0", '+ // tpsp_id, tpsp_erased
                IntToStr(iOwnerID)+', '+ // tpsp_psp_id
                NormalizeStringForQuery(edbxAutoNumber.Text, True, True)+', '+ // tpsp_number
                '"'+FormatDateTime('yyyy-mm-dd', dtpAutoDateOfIssue.DateTime)+'", '+ // tpsp_date_of_issue
                NormalizeStringForQuery(edbxAutoRegistrationSign.Text, True, True)+', '+ // tpsp_auto_registration_sign
                NormalizeStringForQuery(cmbbxAutoMarkModel.Text, True, True)+', '+ // tpsp_auto_mark_model
                NormalizeStringForQuery(cmbbxAutoYearOfEdition.Text, True, True)+', '+ // tpsp_auto_year_of_edition
                NormalizeStringForQuery(cmbbxAutoColor.Text, True, True)+', '+ // tpsp_auto_color
                NormalizeStringForQuery(edbxAutoNumberOfCarriage.Text, True, True)+', '+ // tpsp_auto_number_of_carriage
                NormalizeStringForQuery(cmbbxAutoType.Text, True, True)+', '+ // tpsp_auto_type
                NormalizeStringForQuery(edbxAutoMaximumMass.Text, True, True)+', '+ // tpsp_auto_maximum_mass
                NormalizeStringForQuery(edbxAutoMassWithoutLoad.Text, True, True)+', '+ // tpsp_auto_mass_without_load
                NormalizeStringForQuery(meAutoComments.Text, True, True)+', '; // tpsp_auto_comments
              if Trim(sPlane)='' then // tpsp_other_info, tpsp_other_info_rtf
                q:=q+'NULL, NULL, '
              else
                begin
                  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
                  mysql_escape_string(pac, PAnsiChar(sPlane), Length(PAnsiChar(sPlane)));
                  q:=q+'"'+StrPas(pac)+'", ';
                  if pac<>nil then
                    FreeMemory(pac);
                  // преобразование текста RTF в строку с ESC-последовательностями
                  RTFStream:=TMemoryStream.Create;
                  try
                    reAutoOtherInfo.Lines.SaveToStream(RTFStream);
                    RTFStream.Seek(0, soFromBeginning);
                    pac:=GetMemory(RTFStream.Size*2+1);
                    mysql_escape_string(pac, RTFStream.Memory, RTFStream.Size);
                    q:=q+'"'+StrPas(pac)+'", ';
                  finally
                    if pac<>nil then
                      FreeMemory(pac);
                    RTFStream.Clear;
                    RTFStream.Free;
                  end;
                end;
              q:=q+'NOW(), '+CurrentUser.sID+', '+'NOW(), '+CurrentUser.sID+');';
            end
          else
            begin
              q:='UPDATE _tpsp SET '+'tpsp_number='+NormalizeStringForQuery(edbxAutoNumber.Text, True, True)+', '+ // tpsp_number
                'tpsp_date_of_issue="'+FormatDateTime('yyyy-mm-dd', dtpAutoDateOfIssue.DateTime)+'", '+ // tpsp_date_of_issue
                'tpsp_auto_registration_sign='+NormalizeStringForQuery(edbxAutoRegistrationSign.Text, True, True)+', '+ // tpsp_auto_registration_sign
                'tpsp_auto_mark_model='+NormalizeStringForQuery(cmbbxAutoMarkModel.Text, True, True)+', '+ // tpsp_auto_mark_model
                'tpsp_auto_year_of_edition='+NormalizeStringForQuery(cmbbxAutoYearOfEdition.Text, True, True)+', '+ // tpsp_auto_year_of_edition
                'tpsp_auto_color='+NormalizeStringForQuery(cmbbxAutoColor.Text, True, True)+', '+ // tpsp_auto_color
                'tpsp_auto_number_of_carriage='+NormalizeStringForQuery(edbxAutoNumberOfCarriage.Text, True, True)+', '+ // tpsp_auto_number_of_carriage
                'tpsp_auto_type='+NormalizeStringForQuery(cmbbxAutoType.Text, True, True)+', '+ // tpsp_auto_type
                'tpsp_auto_maximum_mass='+NormalizeStringForQuery(edbxAutoMaximumMass.Text, True, True)+', '+ // tpsp_auto_maximum_mass
                'tpsp_auto_mass_without_load='+NormalizeStringForQuery(edbxAutoMassWithoutLoad.Text, True, True)+', '+ // tpsp_auto_mass_without_load
                'tpsp_auto_comments='+NormalizeStringForQuery(meAutoComments.Text, True, True)+', '; // tpsp_auto_comments
              if Trim(sPlane)='' then
                q:=q+'tpsp_other_info=NULL, tpsp_other_info_rtf=NULL, '
              else
                begin
                  pac:=GetMemory(Length(PAnsiChar(sPlane))*2+1);
                  mysql_escape_string(pac, PAnsiChar(sPlane), Length(PAnsiChar(sPlane)));
                  q:=q+'tpsp_other_info="'+StrPas(pac)+'", ';
                  if pac<>nil then
                    FreeMemory(pac);
                  // преобразование текста RTF в строку с ESC-последовательностями
                  RTFStream:=TMemoryStream.Create;
                  try
                    reAutoOtherInfo.Lines.SaveToStream(RTFStream);
                    RTFStream.Seek(0, soFromBeginning);
                    pac:=GetMemory(RTFStream.Size*2+1);
                    mysql_escape_string(pac, RTFStream.Memory, RTFStream.Size);
                    q:=q+'tpsp_other_info_rtf="'+StrPas(pac)+'", ';
                  finally
                    if pac<>nil then
                      FreeMemory(pac);
                    RTFStream.Clear;
                    RTFStream.Free;
                  end;
                end;
              q:=q+'tpsp_modified_at=NOW(), tpsp_modified_by_user_id='+CurrentUser.sID+' WHERE tpsp_id='+IntToStr(iAutoID)+';';
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      LogThis(q, lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
      if i=0 then
        begin
          LogThis('Запрос выполнен успешно.', lmtInfo);
          iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной записи
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
          if (i=1) then
            begin
              if bAddingAutoNow then
                begin
                  iAutoID:=iLastID; // сохранение ID вставленной записи
                  LogThis('Добавление данных о новом автосредстве произведено успешно', lmtInfo);
                  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'INS'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                end
              else
                begin
                  LogThis('Редактирование данных автосредства произведено успешно', lmtInfo);
                  q:='INSERT INTO _evn VALUES (NULL, NOW(),'+#39+'MOD'+#39+','+#39+CurrentUser.sID+#39+','+#39+q+#39+');';
                end;
              Application.ProcessMessages;
              // запись статистики в БД
              LogThis('Внесение записи в таблицу событий.', lmtInfo);
              LogThis(q, lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.', lmtInfo);
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.', lmtInfo);
                  if (i=1) then
                    LogThis('Запись в таблицу событий внесена успешно', lmtInfo)
                  else
                    begin
                      s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Возникла ошибка при выполнении запроса!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому (1)!';
              bError:=True;
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
      if not bError then
        begin
          if iAutoID<0 then // если произошла ошибка при получении индекса записи, сгенерировать ошибку
            begin
              s:='Получен некорректный идентификатор номера записи в таблице автосредств!';
              bError:=True;
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s, lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady;
        end;

      bAddingAutoNow:=False;

      btbtnSearchClick(nil);

      lvOwners.Items.BeginUpdate;
      for i:=0 to lvOwners.Items.Count-1 do
        if lvOwners.Items[i]<>nil then
          begin
            if lvOwners.Items[i].SubItems[2]=IntToStr(iOwnerID) then
              begin
                lvOwners.ItemIndex:=i;
                lvOwners.ItemFocused:=lvOwners.Items.Item[i];
                tp:=lvOwners.ItemFocused.GetPosition;
                lvOwners.Scroll(tp.X, tp.Y-23);
                lvOwners.ItemFocused.MakeVisible(False);
              end;
          end;
      lvOwners.Items.EndUpdate;
      lvAutos.Items.BeginUpdate;
      for i:=0 to lvAutos.Items.Count-1 do
        if lvAutos.Items[i]<>nil then
          begin
            if lvAutos.Items[i].SubItems[2]=IntToStr(iAutoID) then
              begin
                lvAutos.ItemIndex:=i;
                lvAutos.ItemFocused:=lvAutos.Items.Item[i];
                tp:=lvAutos.ItemFocused.GetPosition;
                lvAutos.Scroll(tp.X, tp.Y-23);
                lvAutos.ItemFocused.MakeVisible(False);
                lvAutos.SetFocus;
              end;
          end;
      lvAutos.Items.EndUpdate;
    end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  ProgressBar1.Position:=ProgressBar1.Min;
end;

procedure TMainForm.btnSaveClick(Sender: TObject);
begin
  SetBusy;
  Screen.Cursor:=crHourGlass;
  if (PageControl1.ActivePage=tsOwner)or(PageControl1.ActivePage=tsAuto) then
    begin
      if PageControl1.ActivePage=tsOwner then
        SaveModifyOwner;
      if PageControl1.ActivePage=tsAuto then
        SaveModifyAuto;
    end;
  Screen.Cursor:=crDefault;
  SetReady;
end;

procedure TMainForm.lvAutosSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  s, q: AnsiString;
  bError: boolean;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  msA: TMemoryStream;
  i: integer;
  i_auto_id: integer;
begin
  bError:=False;
  ResultSet:=nil;
  if not blvAutoRedrawNow then // для ускорения составления списка после выборки
    begin
      // обновление значений панели создания/модификации
      lblCreationCaption.Visible:=(lvAutos.Selected<>nil);
      lblCreation.Visible:=(lvAutos.Selected<>nil);
      lblModificationCaption.Visible:=(lvAutos.Selected<>nil);
      lblModification.Visible:=(lvAutos.Selected<>nil);
      // обновление значений панели идентификатора
      if pnlID.Visible then
        begin
          lblIDCaption.Visible:=(lvAutos.Selected<>nil);
          lblID.Visible:=(lvAutos.Selected<>nil);
        end;
      Update_Actions;
      if lvAutos.Selected<>nil then
        begin
          i_auto_id:=StrToIntDef(lvAutos.Selected.SubItems[2], -1);
          if i_auto_id>-1 then
            LogThis('Попытка получения данных автосредства (ID#'+IntToStr(i_auto_id)+').', lmtInfo)
          else
            begin
              s:='Возникла ошибка в процессе получения ID автосредства!';
              bError:=True;
            end;
          if not bError then
            begin
              // очистка значений контролов
              lblId.Caption:='';
              lblCreation.Caption:='';
              lblModification.Caption:='';
              edbxAutoNumber.Clear;
              dtpAutoDateOfIssue.Date:=Date;
              dtpAutoDateOfIssue.Time:=EncodeTime(0, 0, 0, 0);
              edbxAutoDateOfIssue.Clear;
              edbxAutoRegistrationSign.Clear;
              cmbbxAutoMarkModel.Clear;
              edbxAutoMarkModel.Clear;
              cmbbxAutoYearOfEdition.ItemIndex:=cmbbxAutoYearOfEdition.Items.IndexOf('');
              edbxAutoYearOfEdition.Clear;
              cmbbxAutoColor.Clear;
              edbxAutoColor.Clear;
              edbxAutoMaximumMass.Clear;
              edbxAutoNumberOfCarriage.Clear;
              edbxAutoMassWithoutLoad.Clear;
              cmbbxAutoType.Clear;
              edbxAutoType.Clear;
              meAutoComments.Clear;
              reAutoOtherInfo.Clear;
              SetDefaultSettings(reAutoOtherInfo);
              q:='SELECT tpsp_number, '+ // 0
                'date_format(tpsp_date_of_issue,"%d.%m.%Y"), '+ // 1
                'tpsp_auto_registration_sign, '+ // 2
                'tpsp_auto_mark_model, '+ // 3
                'tpsp_auto_year_of_edition, '+ // 4
                'tpsp_auto_color, '+ // 5
                'tpsp_auto_maximum_mass, '+ // 6
                'tpsp_auto_number_of_carriage, '+ // 7
                'tpsp_auto_mass_without_load, '+ // 8
                'tpsp_auto_type, '+ // 9
                'tpsp_auto_comments, '+ // 10
                'tpsp_other_info, '+ // 11
                'tpsp_other_info_rtf, '+ // 12
                'date_format(tpsp_created_at,"%d.%m.%Y %T"), '+ // 13
                'uc.usr_fullname, '+ // 14
                'date_format(tpsp_modified_at,"%d.%m.%Y %T"), '+ // 15
                'um.usr_fullname '+ // 16
                'FROM _tpsp LEFT JOIN _usr uc ON uc.usr_id=tpsp_created_by_user_id LEFT JOIN _usr um ON um.usr_id=tpsp_modified_by_user_id '+'WHERE tpsp_id='+IntToStr(i_auto_id)+';';
              LogThis(q, lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.', lmtInfo);
                  ResultSet:=mysql_store_result(MySQLConnectionHandler);
                  if ResultSet<>nil then
                    begin
                      LogThis('Результирующая выборка получена успешно.', lmtInfo);
                      i:=mysql_num_rows(ResultSet);
                      LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                      if (i=1) then
                        begin
                          ProgressBar1.Max:=i;
                          ProgressBar1.Step:=1;
                          LogThis('Попытка получения строки выборки.', lmtInfo);
                          ResultRow:=mysql_fetch_row(ResultSet);
                          if ResultRow<>nil then
                            begin
                              lblID.Caption:=IntToStr(i_auto_id);
                              lblCreation.Caption:=ResultRow[14]+', '+ResultRow[13];
                              lblModification.Caption:=ResultRow[16]+', '+ResultRow[15];
                              edbxAutoNumber.Text:=ResultRow[0];
                              dtpAutoDateOfIssue.Date:=StrToDate(ResultRow[1]);
                              edbxAutoDateOfIssue.Text:=ResultRow[1];
                              edbxAutoRegistrationSign.Text:=ResultRow[2];
                              cmbbxAutoMarkModel.ItemIndex:=cmbbxAutoMarkModel.Items.Add(ResultRow[3]);
                              edbxAutoMarkModel.Text:=ResultRow[3];
                              cmbbxAutoYearOfEdition.ItemIndex:=cmbbxAutoYearOfEdition.Items.IndexOf(ResultRow[4]);
                              edbxAutoYearOfEdition.Text:=ResultRow[4];
                              cmbbxAutoColor.ItemIndex:=cmbbxAutoColor.Items.Add(ResultRow[5]);
                              edbxAutoColor.Text:=ResultRow[5];
                              edbxAutoMaximumMass.Text:=ResultRow[6];
                              edbxAutoNumberOfCarriage.Text:=ResultRow[7];
                              edbxAutoMassWithoutLoad.Text:=ResultRow[8];
                              cmbbxAutoType.ItemIndex:=cmbbxAutoType.Items.Add(ResultRow[9]);
                              edbxAutoType.Text:=ResultRow[9];
                              meAutoComments.Text:=StringReplace(ResultRow[10], '<BR>', #13#10, [rfReplaceAll]);
                              Application.ProcessMessages;
                              reAutoOtherInfo.Lines.BeginUpdate;
                              if Length(ResultRow[12])=0 then
                                begin
                                  if ResultRow[11]<>'' then
                                    begin
                                      s:=ResultRow[11];
                                      s:=s+' ';
                                      HTMLtoRTF(s, reAutoOtherInfo);
                                    end;
                                end
                              else
                                begin
                                  msA:=TMemoryStream.Create;
                                  try
                                    i:=StrLen(ResultRow[12]);
                                    msA.SetSize(i);
                                    msA.Seek(0, soFromBeginning);
                                    msA.write(ResultRow[12]^, i);
                                    msA.Seek(0, soFromBeginning);
                                    reAutoOtherInfo.Lines.LoadFromStream(msA);
                                  finally
                                    msA.Free;
                                  end;
                                end;
                              reAutoOtherInfo.Lines.EndUpdate;
                            end
                          else
                            begin
                              s:='Возникла ошибка при загрузке данных строки выборки!';
                              bError:=True;
                            end;
                          ProgressBar1.StepIt;
                        end
                      else
                        begin
                          s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
                          bError:=True;
                        end;
                    end
                  else
                    begin
                      s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Возникла ошибка при выполнении запроса!';
                  bError:=True;
                end;
              if ResultSet<>nil then
                begin
                  LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
                  mysql_free_result(ResultSet);
                end;
              ProgressBar1.Position:=ProgressBar1.Min;
            end;
          Screen.Cursor:=crDefault;
          if bError then
            begin
              LogThis(s, lmtError);
              pnlEdit.Visible:=False;
              PageControl1.ActivePage:=tsClear;
              MessageBox(Handle, PChar(s), PChar('OA4 - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else
            begin
              // обновление значений панели данных
              pnlEdit.Visible:=CurrentUser.bDBEdition;
              PageControl1.ActivePage:=tsAuto;
            end;
        end
      else
        begin
          pnlEdit.Visible:=False;
          PageControl1.ActivePage:=tsClear;
        end;
    end;
end;

procedure TMainForm.lvOwnersSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  s, q: AnsiString;
  bError: boolean;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  msA: TMemoryStream;
  LvGroup: TLVGROUP;
  LvItemA: TLVITEMA;
  ListItem: TListItem;
  i, j, i_owner_id: integer;
  pwcGroupName: PWideChar;
  GroupId: integer;
  slA: TStringList;
begin
  ResultSet:=nil;
  bError:=False;
  // преобразование строки поиска
  LogThis('Преобразование строки поиска - <'+edbxSearch.Text+'>.', lmtInfo);
  s:=Trim(edbxSearch.Text);
  while Pos('  ', s)>0 do
    s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
  edbxSearch.Text:=s;
  LogThis('Итоговая строки поиска - <'+edbxSearch.Text+'>.', lmtInfo);
  if not blvOwnerRedrawNow then // для ускорения составления списка после выборки
    begin
      // обновление значений панели создания/модификации
      lblCreationCaption.Visible:=(lvOwners.Selected<>nil);
      lblCreation.Visible:=(lvOwners.Selected<>nil);
      lblModificationCaption.Visible:=(lvOwners.Selected<>nil);
      lblModification.Visible:=(lvOwners.Selected<>nil);
      // обновление значений панели идентификатора
      if pnlID.Visible then
        begin
          lblIDCaption.Visible:=(lvOwners.Selected<>nil);
          lblID.Visible:=(lvOwners.Selected<>nil);
        end;
      Update_Actions;
      if lvOwners.Selected<>nil then
        begin
          i_owner_id:=StrToIntDef(lvOwners.Selected.SubItems[2], -1);
          if i_owner_id>-1 then
            LogThis('Попытка получения данных владельца (ID#'+IntToStr(i_owner_id)+').', lmtInfo)
          else
            begin
              s:='Возникла ошибка в процессе получения ID владельца!';
              bError:=True;
            end;
          if not bError then
            begin
              // обновление списка автосредств данного владельца
              blvAutoRedrawNow:=True;
              lvAutos.Items.BeginUpdate;
              SendMessage(lvAutos.Handle, LVM_REMOVEALLGROUPS, 0, 0);
              SendMessage(lvAutos.Handle, LVM_DELETEALLITEMS, 0, 0);
              lvAutos.Items.EndUpdate;
              SendMessage(lvAutos.Handle, LVM_ENABLEGROUPVIEW, 1, 0);
              q:='SELECT UPPER(tpsp_auto_type) AS x1, tpsp_auto_mark_model AS x2, '+'tpsp_auto_registration_sign AS x3, tpsp_number AS x4, tpsp_id AS x5, tpsp_erased AS x6 '+'FROM _tpsp '+'LEFT JOIN _psp ON psp_id=tpsp_psp_id '+'WHERE tpsp_psp_id='+
                IntToStr(i_owner_id)+' ';
              if (chkbxHideErased.Visible and chkbxHideErased.Enabled and chkbxHideErased.Checked)or(not chkbxHideErased.Visible) then
                q:=q+'AND tpsp_erased="0" ';
              // формирование  строки запроса
              s:=edbxSearch.Text;
              while Pos('.', s)>0 do
                s:=StringReplace(s, '.', '!', [rfReplaceAll]);
              while Pos('*', s)>0 do
                s:=StringReplace(s, '*', '%', [rfReplaceAll]);
              slA:=TStringList.Create;
              try
                slA.Duplicates:=dupIgnore;
                CutStringByLimiterToStringList(s, slA, ' ');
                for i:=0 to slA.Count-1 do
                  begin
                    if slA[i]>'' then
                      begin
                        q:=q+'AND ('+'(psp_type LIKE "% '+slA[i]+'%") OR '+'(psp_type LIKE "% '+slA[i]+' %") OR '+

                          '(psp_code_of_issuing_state LIKE "% '+slA[i]+'%") OR '+'(psp_code_of_issuing_state LIKE "% '+slA[i]+' %") OR '+

                          '(psp_passport_number LIKE "% '+slA[i]+'%") OR '+'(psp_passport_number LIKE "% '+slA[i]+' %") OR '+

                          '(psp_surname LIKE "% '+slA[i]+'%") OR '+'(psp_surname LIKE "% '+slA[i]+' %") OR '+

                          '(psp_given_names LIKE "% '+slA[i]+'%") OR '+'(psp_given_names LIKE "% '+slA[i]+' %") OR '+

                          '(psp_subname LIKE "% '+slA[i]+'%") OR '+'(psp_subname LIKE "% '+slA[i]+' %") OR '+

                          '(psp_nationality LIKE "% '+slA[i]+'%") OR '+'(psp_nationality LIKE "% '+slA[i]+' %") OR '+

                          '(psp_personal_number LIKE "% '+slA[i]+'%") OR '+'(psp_personal_number LIKE "% '+slA[i]+' %") OR '+

                          '(psp_sex LIKE "% '+slA[i]+'%") OR '+'(psp_sex LIKE "% '+slA[i]+' %") OR '+

                          '(psp_authority LIKE "% '+slA[i]+'%") OR '+'(psp_authority LIKE "% '+slA[i]+' %") OR '+

                          '(psp_place_of_birth LIKE "% '+slA[i]+'%") OR '+'(psp_place_of_birth LIKE "% '+slA[i]+' %") OR '+

                          '(psp_town LIKE "% '+slA[i]+'%") OR '+'(psp_town LIKE "% '+slA[i]+' %") OR '+

                          '(psp_street LIKE "% '+slA[i]+'%") OR '+'(psp_street LIKE "% '+slA[i]+' %") OR '+

                          '(psp_house_num LIKE "'+slA[i]+'%") OR '+'(psp_house_sym LIKE "'+slA[i]+'%") OR '+'(CONCAT(psp_house_num,psp_house_sym) LIKE "%'+slA[i]+'%") OR '+

                          '(psp_subhouse_num LIKE "'+slA[i]+'%") OR '+'(psp_subhouse_sym LIKE "'+slA[i]+'%") OR '+'(CONCAT(psp_subhouse_num,psp_subhouse_sym) LIKE "%'+slA[i]+'%") OR '+

                          '(psp_flat_num LIKE "'+slA[i]+'%") OR '+'(psp_flat_sym LIKE "'+slA[i]+'%") OR '+'(CONCAT(psp_flat_num,psp_flat_sym) LIKE "%'+slA[i]+'%") OR '+

                          '(psp_other_info LIKE "% '+slA[i]+'%") OR '+'(psp_other_info LIKE "% '+slA[i]+' %") OR '+

                          '(tpsp_number LIKE "% '+slA[i]+'%") OR '+'(tpsp_number LIKE "% '+slA[i]+' %") OR '+

                          '(tpsp_auto_registration_sign LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_registration_sign LIKE "% '+slA[i]+' %") OR '+

                          '(tpsp_auto_mark_model LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_mark_model LIKE "% '+slA[i]+' %") OR '+

                          '(tpsp_auto_color LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_color LIKE "% '+slA[i]+' %") OR '+

                          '(tpsp_auto_number_of_carriage LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_number_of_carriage LIKE "% '+slA[i]+' %") OR '+

                          '(tpsp_auto_type LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_type LIKE "% '+slA[i]+' %") OR '+

                          '(tpsp_auto_comments LIKE "% '+slA[i]+'%") OR '+'(tpsp_auto_comments LIKE "% '+slA[i]+' %") OR '+

                          '(tpsp_other_info LIKE "% '+slA[i]+'%") OR '+'(tpsp_other_info LIKE "% '+slA[i]+' %")) ';
                      end;
                  end;
                while Pos('!%', q)>0 do
                  q:=StringReplace(q, '!%', '', [rfReplaceAll]);
                while Pos('! %', q)>0 do
                  q:=StringReplace(q, '! %', ' %', [rfReplaceAll]);
                while Pos('%%', q)>0 do
                  q:=StringReplace(q, '%%', '%', [rfReplaceAll]);
              finally
                slA.Free;
              end;
              q:=q+'ORDER BY x1, x2, x3, x4;';
              s:='cxzasdewq';
              GroupId:=-1;
              LogThis(q, lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.', lmtInfo);
                  ResultSet:=mysql_store_result(MySQLConnectionHandler);
                  if ResultSet<>nil then
                    begin
                      LogThis('Результирующая выборка получена успешно.', lmtInfo);
                      i:=mysql_num_rows(ResultSet);
                      if (i>=0) then
                        begin
                          ProgressBar1.Max:=i;
                          ProgressBar1.Step:=1;
                          LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                          lvAutos.Items.BeginUpdate;
                          for j:=0 to (i-1) do
                            begin
                              if not bError then
                                begin
                                  ResultRow:=mysql_fetch_row(ResultSet);
                                  if ResultRow<>nil then
                                    begin
                                      // создание группы
                                      if s<>ResultRow[0] then
                                        begin
                                          GroupId:=GroupId+1;
                                          s:=ResultRow[0];
                                          GetMem(pwcGroupName, SizeOf(WideChar)*1000);
                                          try
                                            FillChar(LvGroup, SizeOf(TLVGROUP), 0);
                                            with LvGroup do
                                              begin
                                                cbSize:=SizeOf(TLVGROUP);
                                                mask:=LVGF_HEADER or LVGF_ALIGN or LVGF_GROUPID;
                                                pszHeader:=StringToWideChar(s, pwcGroupName, 1000);
                                                cchHeader:=Length(LvGroup.pszHeader);
                                                iGroupId:=GroupId;
                                                uAlign:=LVGA_HEADER_LEFT;
                                              end;
                                            SendMessage(lvAutos.Handle, LVM_INSERTGROUP, -1, Longint(@LvGroup));
                                          finally
                                            FreeMem(pwcGroupName);
                                          end;
                                        end;
                                      if GroupId>-1 then
                                        begin
                                          ListItem:=lvAutos.Items.Add;
                                          ListItem.Caption:=ResultRow[1];
                                          ListItem.SubItems.Add(ResultRow[2]);
                                          ListItem.SubItems.Add(ResultRow[3]);
                                          ListItem.SubItems.Add(ResultRow[4]);
                                          ListItem.ImageIndex:=StrToIntDef(ResultRow[5], 2);
                                          with LvItemA do
                                            begin
                                              FillChar(LvItemA, SizeOf(TLvItemA), 0);
                                              mask:=LVIF_GROUPID;
                                              iItem:=ListItem.index;
                                              iGroupId:=GroupId;
                                            end;
                                          SendMessage(lvAutos.Handle, LVM_SETITEM, 0, Longint(@LvItemA));
                                        end;
                                    end
                                  else
                                    begin
                                      s:='Возникла ошибка при загрузке данных строки выборки!';
                                      bError:=True;
                                    end;
                                  ProgressBar1.StepIt;
                                end;
                            end;
                          lvAutos.Items.EndUpdate;
                        end
                      else
                        begin
                          s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
                          bError:=True;
                        end;
                    end
                  else
                    begin
                      s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Возникла ошибка при выполнении запроса!';
                  bError:=True;
                end;
              if ResultSet<>nil then
                begin
                  LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
                  mysql_free_result(ResultSet);
                end;
              ProgressBar1.Position:=ProgressBar1.Min;
            end;
          blvAutoRedrawNow:=False; // перерисовка окна результатов поиска отключена
          if not bError then
            begin
              if lvAutos.Items.Count>0 then
                begin
                  lvAutos.ItemIndex:=0;
                  lvAutos.ItemFocused:=lvAutos.Items.Item[0];
                end;
            end;

          if not bError then
            begin
              // обновление значений панели организации
              btnCancel.Visible:=False;
              btnCancel.Enabled:=False;
              // очистка значений контролов
              lblId.Caption:='';
              lblCreation.Caption:='';
              lblModification.Caption:='';
              cmbbxOwnerType.Clear;
              edbxOwnerType.Clear;
              cmbbxOwnerCodeOfIssuingState.Clear;
              edbxOwnerCodeOfIssuingState.Clear;
              edbxOwnerPassportNumber.Clear;
              edbxOwnerSurname.Clear;
              edbxOwnerGivenNames.Clear;
              edbxOwnerSubname.Clear;
              cmbbxOwnerNationality.Clear;
              edbxOwnerNationality.Clear;
              dtpOwnerDateOfBirth.Date:=Date;
              dtpOwnerDateOfBirth.Time:=EncodeTime(0, 0, 0, 0);
              edbxOwnerDateOfBirth.Clear;
              edbxOwnerPlaceOfBirth.Clear;
              cmbbxOwnerSex.ItemIndex:=-1;
              edbxOwnerSex.Clear;
              edbxOwnerPrivateNumber.Clear;
              dtpOwnerDateOfIssue.Date:=Date;
              dtpOwnerDateOfIssue.Time:=EncodeTime(0, 0, 0, 0);
              edbxOwnerDateOfIssue.Clear;
              cmbbxOwnerAuthority.Clear;
              edbxOwnerAuthority.Clear;
              dtpOwnerDateOfExpiry.Date:=Date;
              dtpOwnerDateOfExpiry.Time:=EncodeTime(0, 0, 0, 0);
              edbxOwnerDateOfExpiry.Clear;
              cmbbxOwnerTown.Clear;
              edbxOwnerTown.Clear;
              cmbbxOwnerStreet.Clear;
              edbxOwnerStreet.Clear;
              edbxOwnerHouse.Clear;
              edbxOwnerSubHouse.Clear;
              edbxOwnerFlat.Clear;
              reOwnerOtherInfo.Clear;
              SetDefaultSettings(reOwnerOtherInfo);
              LogThis('Попытка получения данных владельца (ID#'+lvOwners.Selected.SubItems[2]+').', lmtInfo);
              q:='SELECT psp_type, '+ // 0
                'psp_code_of_issuing_state, '+ // 1
                'psp_passport_number, '+ // 2
                'psp_surname, '+ // 3
                'psp_given_names, '+ // 4
                'psp_subname, '+ // 5
                'psp_nationality, '+ // 6
                'date_format(psp_date_of_birth,"%d.%m.%Y"), '+ // 7
                'psp_place_of_birth, '+ // 8
                'psp_sex, '+ // 9
                'psp_personal_number, '+ // 10
                'date_format(psp_date_of_issue,"%d.%m.%Y"), '+ // 11
                'psp_authority, '+ // 12
                'date_format(psp_date_of_expiry,"%d.%m.%Y"), '+ // 13
                'psp_town, '+ // 14
                'psp_street, '+ // 15
                'psp_house_num, '+ // 16
                'psp_house_sym, '+ // 17
                'psp_subhouse_num, '+ // 18
                'psp_subhouse_sym, '+ // 19
                'psp_flat_num, '+ // 20
                'psp_flat_sym, '+ // 21
                'psp_other_info, '+ // 22
                'psp_other_info_rtf, '+ // 23
                'CONCAT(c.usr_fullname,", ",psp_created_at), '+ // 24
                'CONCAT(m.usr_fullname,", ",psp_modified_at) '+ // 25
                'FROM _psp '+'LEFT JOIN _usr c ON c.usr_id=psp_created_by_user_id '+'LEFT JOIN _usr m ON m.usr_id=psp_modified_by_user_id '+'WHERE psp_id='+IntToStr(i_owner_id)+';';
              LogThis(q, lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler, PChar(q), Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.', lmtInfo);
                  ResultSet:=mysql_store_result(MySQLConnectionHandler);
                  if ResultSet<>nil then
                    begin
                      LogThis('Результирующая выборка получена успешно.', lmtInfo);
                      i:=mysql_num_rows(ResultSet);
                      if (i=1) then
                        begin
                          ProgressBar1.Max:=i;
                          ProgressBar1.Step:=1;
                          LogThis('Количество строк выборки равно '+IntToStr(i)+'.', lmtInfo);
                          LogThis('Попытка получения строки выборки.', lmtInfo);
                          ResultRow:=mysql_fetch_row(ResultSet);
                          if ResultRow<>nil then
                            begin
                              lblID.Caption:=lvOwners.Selected.SubItems[2];
                              lblCreation.Caption:=ResultRow[24];
                              lblModification.Caption:=ResultRow[25];

                              cmbbxOwnerType.ItemIndex:=cmbbxOwnerType.Items.Add(ResultRow[0]);
                              edbxOwnerType.Text:=ResultRow[0];
                              cmbbxOwnerCodeOfIssuingState.ItemIndex:=cmbbxOwnerCodeOfIssuingState.Items.Add(ResultRow[1]);
                              edbxOwnerCodeOfIssuingState.Text:=ResultRow[1];
                              edbxOwnerPassportNumber.Text:=ResultRow[2];
                              edbxOwnerSurname.Text:=ResultRow[3];
                              edbxOwnerGivenNames.Text:=ResultRow[4];
                              edbxOwnerSubname.Text:=ResultRow[5];
                              cmbbxOwnerNationality.ItemIndex:=cmbbxOwnerNationality.Items.Add(ResultRow[6]);
                              edbxOwnerNationality.Text:=ResultRow[6];
                              dtpOwnerDateOfBirth.Date:=StrToDate(ResultRow[7]);
                              edbxOwnerDateOfBirth.Text:=ResultRow[7];
                              edbxOwnerPlaceOfBirth.Text:=ResultRow[8];
                              if ResultRow[9]='' then
                                cmbbxOwnerSex.ItemIndex:=-1
                              else
                                if ResultRow[9]='муж' then
                                  cmbbxOwnerSex.ItemIndex:=1
                                else
                                  if ResultRow[9]='жен' then
                                    cmbbxOwnerSex.ItemIndex:=2;
                              edbxOwnerSex.Text:=ResultRow[9];
                              edbxOwnerPrivateNumber.Text:=ResultRow[10];
                              dtpOwnerDateOfIssue.Date:=StrToDate(ResultRow[11]);
                              edbxOwnerDateOfIssue.Text:=ResultRow[11];
                              cmbbxOwnerAuthority.ItemIndex:=cmbbxOwnerAuthority.Items.Add(ResultRow[12]);
                              edbxOwnerAuthority.Text:=ResultRow[12];
                              dtpOwnerDateOfExpiry.Date:=StrToDate(ResultRow[13]);
                              edbxOwnerDateOfExpiry.Text:=ResultRow[13];
                              cmbbxOwnerTown.ItemIndex:=cmbbxOwnerTown.Items.Add(ResultRow[14]);
                              edbxOwnerTown.Text:=ResultRow[14];
                              cmbbxOwnerStreet.ItemIndex:=cmbbxOwnerStreet.Items.Add(ResultRow[15]);
                              edbxOwnerStreet.Text:=ResultRow[15];
                              s:=ResultRow[16];
                              if s='0' then
                                s:='';
                              edbxOwnerHouse.Text:=Trim(s+ResultRow[17]);
                              if edbxOwnerHouse.Text>'' then
                                edbxOwnerHouse.Text:=' '+edbxOwnerHouse.Text;
                              s:=ResultRow[18];
                              if s='0' then
                                s:='';
                              edbxOwnerSubHouse.Text:=Trim(s+ResultRow[19]);
                              if edbxOwnerSubHouse.Text>'' then
                                edbxOwnerSubHouse.Text:=' '+edbxOwnerSubHouse.Text;
                              s:=ResultRow[20];
                              if s='0' then
                                s:='';
                              edbxOwnerFlat.Text:=Trim(s+ResultRow[21]);
                              if edbxOwnerFlat.Text>'' then
                                edbxOwnerFlat.Text:=' '+edbxOwnerFlat.Text;
                              reOwnerOtherInfo.Lines.BeginUpdate;
                              if Length(ResultRow[23])=0 then
                                begin
                                  if ResultRow[22]<>'' then
                                    begin
                                      s:=ResultRow[22];
                                      s:=s+' ';
                                      HTMLtoRTF(s, reOwnerOtherInfo);
                                    end;
                                end
                              else
                                begin
                                  msA:=TMemoryStream.Create;
                                  try
                                    i:=StrLen(ResultRow[23]);
                                    msA.SetSize(i);
                                    msA.Seek(0, soFromBeginning);
                                    msA.write(ResultRow[23]^, i);
                                    msA.Seek(0, soFromBeginning);
                                    reOwnerOtherInfo.Lines.LoadFromStream(msA);
                                  finally
                                    msA.Free;
                                  end;
                                end;
                              reOwnerOtherInfo.Lines.EndUpdate;
                            end
                          else
                            begin
                              s:='Возникла ошибка при загрузке данных строки выборки!';
                              bError:=True;
                            end;
                          ProgressBar1.StepIt;
                        end
                      else
                        begin
                          s:='Получено некорректное количество строк результирующей выборки ('+IntToStr(i)+')!';
                          bError:=True;
                        end;
                    end
                  else
                    begin
                      s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Возникла ошибка при выполнении запроса!';
                  bError:=True;
                end;
              if ResultSet<>nil then
                begin
                  LogThis('Освобождение ресурсов, занятых результатом выборки...', lmtInfo);
                  mysql_free_result(ResultSet);
                end;
              ProgressBar1.Position:=ProgressBar1.Min;
            end;
          Screen.Cursor:=crDefault;
          if bError then
            begin
              LogThis(s, lmtError);
              pnlEdit.Visible:=False;
              PageControl1.ActivePage:=tsClear;
              MessageBox(Handle, PChar(s), PChar('GAIDB - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else
            begin
              // обновление значений панели данных
              pnlEdit.Visible:=CurrentUser.bDBEdition;
              PageControl1.ActivePage:=tsOwner;
            end;
        end
      else
        begin
          pnlEdit.Visible:=False;
          PageControl1.ActivePage:=tsClear;
        end;
    end;
end;

// var h : hwnd;
// h:=listview.Handle;
// if (GetWindowLong(h,GWL_STYLE) and WS_VSCROLL)=WS_VSCROLL then showmessage('vertical scroll');

// добавить обновление адреса в таблице владельцев при редактировании информации об владельцев

// переделать процедуры реакции на выделение элементов списков владельцев и техсредств
// переделать проверку на ошибки при запросах

end.
