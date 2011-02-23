unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, StdCtrls, Buttons, ExtCtrls, AppEvnts, getFVI,
  ToolWin, ActnMan, ActnCtrls, XPStyleActnCtrls, Menus, ImgList, ShellAPI, mysql,
  IniFiles, Spin, commctrl, XPMan;
type
   TLVGROUP=record
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

  TLVGROUPMETRICS=record
    cbSize: UINT;
    mask: UINT;
    Left: UINT;
    Top: UINT;
    Right: UINT;
    Bottom: UINT;
    crLeft: COLORREF;
    crTop: COLORREF;
    crRight: COLORREF;
    crBottom: COLORREF;
    crHeader: COLORREF;
    crFooter: COLORREF;
  end;

  EDITBALLOONTIP=record
    cbStruct: DWORD;
    pszTitle: LPCWSTR;
    pszText: LPCWSTR;
    ttiIcon: integer; // TTI_ERROR, TTI_INFO, TTI_NONE, TTI_WARNING, TTI_INFO_LARGE, TTI_WARNING_LARGE, TTI_ERROR_LARGE
  end;

const
  ECM_FIRST          =$01500; // Edit control messages
  BCM_FIRST          =$01600; // Button control messages
  CBM_FIRST          =$01700; // Combobox control messages

  EM_SETCUEBANNER	   =ECM_FIRST + 1;
  EM_SHOWBALLOONTIP  =ECM_FIRST + 3; // Show a balloon tip associated to the edit control
  EM_HIDEBALLOONTIP  =ECM_FIRST + 4; // Hide any balloon tip associated with the edit control

  LVM_ENABLEGROUPVIEW=LVM_FIRST + 157;
  LVM_MOVEITEMTOGROUP=LVM_FIRST + 154;
  LVM_INSERTGROUP    =LVM_FIRST + 145;
  LVM_REMOVEALLGROUPS=LVM_FIRST + 160;
  LVM_GETGROUPMETRICS=LVM_FIRST + 156;
  LVM_SETGROUPMETRICS=LVM_FIRST + 155;

  LVIF_GROUPID=$0100;

  LVGF_HEADER =$00000001;
  LVGF_ALIGN  =$00000008;
  LVGF_GROUPID=$00000010;

  LVGA_HEADER_LEFT  =$00000001;
  LVGA_HEADER_CENTER=$00000002;
  LVGA_HEADER_RIGHT =$00000004;

  LVGMF_NONE          =$00000000;
  LVGMF_BORDERSIZE    =$00000001;
  LVGMF_BORDERCOLOR   =$00000002;
  LVGMF_TEXTCOLOR     =$00000004;

	EM_REDO =	(WM_USER + 84);
	EM_CANREDO=(WM_USER + 85);

  // опеределения для панели статуса
  //STATUSBAR_ITEMS_COUNT_PANEL_NUMBER: integer=2;
  STATUSBAR_SERVER_NAME: integer=2;
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_PROGRESS_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=3;

  DEFAULT_MAINFORMWIDTH=1024;
  DEFAULT_MAINFORMHEIGHT=768;
  DEFAULT_DATAPANELWIDTH=340;
  DEFAULT_ORGPANELHEIGHT=200;

	EXISTINGICON_ID=0;
	DELETEDICON_ID=1;
  UNKNOWNICON_ID=2;

  INFO_GET_FIRMA_BY_CODE		=1;
  INFO_GET_OTDEL_BY_CODE		=2;
  INFO_GET_FIRMA_BY_PHONE		=3;
  INFO_GET_ABON_BY_PHONE		=4;
  INFO_GET_FIRMA_BY_NAME		=5;
  INFO_GET_PRONOUNCE_PHONE	=6;
  INFO_GET_CONNECT_PHONE		=7;

type
  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL); // типы сообщений передаваемых в лог
  tTTI=(TTI_NONE, TTI_INFO, TTI_WARNING, TTI_ERROR);
  TParaAttr=record
    Alignment: TAlignment;
    FirstIndent: integer;
    LeftIndent: integer;
    Numbering: TNumberingStyle;
    RightIndent: integer;
    TabCount: integer;
  end;
  TTextAttr=record
    Charset: TFontCharset;
    Color: TColor;
    Name: TFontName;
    Pitch: TFontPitch;
    Size: integer;
    Style: TFontStyles;
    Height: integer;
  end;
  TUserRec=record
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
  TFormPosition=record
    bCenter: boolean;
    x, y: integer;
  end;
  TConfigurationRec=record
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
    bShowDataInOtherInfoPanel: boolean;
    bShowMeasuresListAsRichEdit: boolean;
    bMarkSearchedStrings: boolean;
    bPutTownAtTheEnd: boolean;
    bHideEditBoxToolTips: boolean;
    bShowSearchAddressOtherEditBox: boolean;
    iOrgSortColumn: integer;
    iMsrSortColumn: integer;
    bFullScreen: boolean;
    fpMainForm: TFormPosition;
    iMainFormWidth: integer;
    iMainFormHeight: integer;
    iOrgPanelHeight: integer;
    bOrgPanelHalfHeight: boolean;
    iDataPanelWidth: integer;
    bDataPanelHalfWidth: boolean;
    fpLoginForm: TFormPosition;
    fpOptionsForm: TFormPosition;
    fpUsersForm: TFormPosition;
    fpSetPasswordForm: TFormPosition;
    fpStatisticForm: TFormPosition;
    fpMaintenanceForm: TFormPosition;
    fpClearingForm: TFormPosition;
    fpViewPostListForm: TFormPosition;
    fpCreateViewPostForm: TFormPosition;
    fpPhonesForm: TFormPosition;
    fpAddEditPhoneForm: TFormPosition;

    sMySQLHost: string;
    iMySQLPort: integer;
    iMySQLTimeout: integer;
    bMySQLCompress: boolean;
    sMySQLDatabase: string;
    sMySQLUser: string;
    sMySQLPassword: string;
    sCustomHelpFile: string;
    bUseLog: boolean;
    sCustomLogClientFile: string;
  end;
  THackControl=class(TControl);
  TMainForm=class(TForm)
    MainMenu1: TMainMenu;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    gsFileVersionInfo1: TgsFileVersionInfo;
    ColorDialog1: TColorDialog;
    ApplicationEvents1: TApplicationEvents;
    pnlConnectedMode: TPanel;
    pnlSearch: TPanel;
    edbxSearchName: TEdit;
    btbtnSearch: TBitBtn;
    chkbxStartDate: TCheckBox;
    dtpStartDate: TDateTimePicker;
    chkbxStopDate: TCheckBox;
    dtpStopDate: TDateTimePicker;
    chkbxTeenagers: TCheckBox;
    chkbxChildren: TCheckBox;
    chkbxPremier: TCheckBox;
    chkbxTour: TCheckBox;
    chkbxAdultsOnly: TCheckBox;
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
    Action_DB_AddMeasure: TAction;
    Action_DB_AddOrganization: TAction;
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
    tsOrg: TTabSheet;
    tsMsr: TTabSheet;
    pnlOrganizationGeneralInfo: TPanel;
    lblOrgType: TLabel;
    cmbbxOrgType: TComboBox;
    lblOrgName: TLabel;
    edbxOrgName: TEdit;
    lblOrgAddress: TLabel;
    edbxOrgAddress: TEdit;
    lblOrgTown: TLabel;
    cmbbxOrgTown: TComboBox;
    cmbbxOrgStreet: TComboBox;
    lblOrgStreet: TLabel;
    lblOrgHouse: TLabel;
    edbxOrgHouse: TEdit;
    lblOrgSubHouse: TLabel;
    edbxOrgSubHouse: TEdit;
    lblOrgFlat: TLabel;
    edbxOrgFlat: TEdit;
    lblOrgHowToReach: TLabel;
    edbxOrgHowToReach: TEdit;
    lblOrgWorkTime: TLabel;
    cmbbxOrgWorkTime: TComboBox;
    Panel2: TPanel;
    Panel3: TPanel;
    Bevel3: TBevel;
    lblOrgOtherInfo: TLabel;
    lblOrgOtherInfoFull: TLabel;
    reOrgOtherInfo: TRichEdit;
    pnlMesureGeneralInfo: TPanel;
    pnl7: TPanel;
    lblMsrName: TLabel;
    lblMsrType: TLabel;
    edbxMsrName: TEdit;
    edbxMsrType: TEdit;
    cmbbxMsrType: TComboBox;
    gpbxMsrDuration: TGroupBox;
    lblMsrDurationMinutes: TLabel;
    lblMsrDurationHours: TLabel;
    lblMsrDurationDays: TLabel;
    spedMsrDurationMinutes: TSpinEdit;
    spedMsrDurationHours: TSpinEdit;
    spedMsrDurationDays: TSpinEdit;
    gpbxMsrFlags: TGroupBox;
    chkbxMsrForAdultsOnly: TCheckBox;
    chkbxMsrIsTour: TCheckBox;
    chkbxMsrIsPremier: TCheckBox;
    chkbxMsrForChildren: TCheckBox;
    chkbxMsrForTeenagers: TCheckBox;
    pnlMsrDateTime: TPanel;
    dtpMsrStopDate: TDateTimePicker;
    chkbxMsrStop: TCheckBox;
    dtpMsrStartDate: TDateTimePicker;
    chkbxMsrStart: TCheckBox;
    dtpMsrStartTime: TDateTimePicker;
    dtpMsrStopTime: TDateTimePicker;
    Panel7: TPanel;
    Panel8: TPanel;
    Bevel2: TBevel;
    lblMsrTicketPrice: TLabel;
    meMsrTicketPrice: TMemo;
    lblMsrAuthor: TLabel;
    cmbbxMsrAuthor: TComboBox;
    lblMsrProducer: TLabel;
    cmbbxMsrProducer: TComboBox;
    lblMsrPerformer: TLabel;
    cmbbxMsrPerformer: TComboBox;
    lblMsrOrganizer: TLabel;
    cmbbxMsrOrganizer: TComboBox;
    edbxMsrAuthor: TEdit;
    edbxMsrProducer: TEdit;
    edbxMsrPerformer: TEdit;
    edbxMsrOrganizer: TEdit;
    Panel5: TPanel;
    reMsrOtherInfo: TRichEdit;
    Bevel4: TBevel;
    pnlEdit: TPanel;
    Action_PostMessage: TAction;
    Action_ViewMessages: TAction;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    edbxOrgType: TEdit;
    edbxOrgTown: TEdit;
    edbxOrgStreet: TEdit;
    edbxOrgWorkTime: TEdit;
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
    lvOrg: TListView;
    pnlMsrLV: TPanel;
    lvMsr: TListView;
    miOpenOtherPanel: TMenuItem;
    miGoToSearchString: TMenuItem;
    Splitter2: TSplitter;
    miGoToOrgPanel: TMenuItem;
    miGoToMsrPanel: TMenuItem;
    miGoToDataPanel: TMenuItem;
    Panel1: TPanel;
    Bevel5: TBevel;
    lblMsrListCaption: TLabel;
    Label2: TLabel;
    Panel4: TPanel;
    Bevel6: TBevel;
    lblOrgListCaption: TLabel;
    Label4: TLabel;
    Panel10: TPanel;
    Bevel8: TBevel;
    Label7: TLabel;
    Label8: TLabel;
    miGoToPhones: TMenuItem;
    chkbxHideOld: TCheckBox;
    btnSave: TButton;
    btnClear: TButton;
    btnClone: TButton;
    btnCancel: TButton;
    Label11: TLabel;
    Panel9: TPanel;
    Bevel7: TBevel;
    Label5: TLabel;
    Label6: TLabel;
    Panel11: TPanel;
    Bevel9: TBevel;
    Label9: TLabel;
    Label10: TLabel;
    stPhonesMark: TStaticText;
    Image_MessageStatus: TImage;
    Timer_MessageStatus: TTimer;
    chkbxMsrUnknownDuration: TCheckBox;
    Bevel1: TBevel;
    edbxSearchAddress: TEdit;
    edbxSearchOther: TEdit;
    reMsr: TRichEdit;
    procedure edbxSearchOtherEnter(Sender: TObject);
    procedure edbxSearchOtherExit(Sender: TObject);
    procedure edbxSearchAddressEnter(Sender: TObject);
    procedure edbxSearchAddressExit(Sender: TObject);
    procedure chkbxMsrUnknownDurationClick(Sender: TObject);
    procedure lvOrgColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvMsrColumnClick(Sender: TObject; Column: TListColumn);
    procedure Timer_MessageStatusTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvMsrKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvOrgKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure lvOrgResize(Sender: TObject);
    procedure pnlSearchResultsCreationModificationResize(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure edbxMsrTypeExit(Sender: TObject);
    procedure edbxMsrTypeEnter(Sender: TObject);
    procedure edbxMsrProducerEnter(Sender: TObject);
    procedure edbxMsrProducerExit(Sender: TObject);
    procedure edbxMsrPerformerExit(Sender: TObject);
    procedure edbxMsrPerformerEnter(Sender: TObject);
    procedure edbxMsrOrganizerEnter(Sender: TObject);
    procedure edbxMsrOrganizerExit(Sender: TObject);
    procedure edbxMsrNameEnter(Sender: TObject);
    procedure edbxMsrAuthorExit(Sender: TObject);
    procedure edbxMsrAuthorEnter(Sender: TObject);
    procedure edbxOrgWorkTimeExit(Sender: TObject);
    procedure edbxOrgWorkTimeEnter(Sender: TObject);
    procedure edbxOrgHowToReachEnter(Sender: TObject);
    procedure edbxOrgFlatEnter(Sender: TObject);
    procedure edbxOrgSubHouseEnter(Sender: TObject);
    procedure edbxOrgHouseEnter(Sender: TObject);
    procedure edbxOrgStreetEnter(Sender: TObject);
    procedure edbxOrgStreetExit(Sender: TObject);
    procedure edbxOrgTownExit(Sender: TObject);
    procedure edbxOrgTownEnter(Sender: TObject);
    procedure edbxOrgAddressEnter(Sender: TObject);
    procedure edbxOrgTypeExit(Sender: TObject);
    procedure edbxOrgTypeEnter(Sender: TObject);
    procedure edbxOrgNameEnter(Sender: TObject);
    procedure edbxSearchNameExit(Sender: TObject);
    procedure edbxSearchNameEnter(Sender: TObject);
    procedure btnCloneClick(Sender: TObject);
    procedure lvOrgCustomDrawSubItem(Sender: TCustomListView; Item: TListItem;
      SubItem: Integer; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure Action_DB_DefragmentationExecute(Sender: TObject);
    procedure Action_DB_CleaningExecute(Sender: TObject);
    procedure Action_DB_BackupExecute(Sender: TObject);
    procedure Action_DB_MaintenanceExecute(Sender: TObject);
    procedure Action_DB_RefreshListExecute(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure meMsrTicketPriceExit(Sender: TObject);
    procedure cmbbxMsrOrganizerExit(Sender: TObject);
    procedure cmbbxMsrPerformerExit(Sender: TObject);
    procedure cmbbxMsrProducerExit(Sender: TObject);
    procedure cmbbxMsrAuthorExit(Sender: TObject);
    procedure edbxMsrNameExit(Sender: TObject);
    procedure cmbbxMsrTypeExit(Sender: TObject);
    procedure cmbbxOrgTownExit(Sender: TObject);
    procedure cmbbxOrgWorkTimeExit(Sender: TObject);
    procedure edbxOrgHowToReachExit(Sender: TObject);
    procedure edbxOrgFlatExit(Sender: TObject);
    procedure edbxOrgSubHouseExit(Sender: TObject);
    procedure edbxOrgHouseExit(Sender: TObject);
    procedure cmbbxOrgStreetExit(Sender: TObject);
    procedure edbxOrgAddressExit(Sender: TObject);
    procedure cmbbxOrgTypeExit(Sender: TObject);
    procedure edbxOrgNameExit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure Action_DB_AddMeasureExecute(Sender: TObject);
    procedure Action_DB_AddOrganizationExecute(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure lvMsrCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure miGoToDataPanelClick(Sender: TObject);
    procedure miGoToMsrPanelClick(Sender: TObject);
    procedure miGoToOrgPanelClick(Sender: TObject);
    procedure dtpMsrStartDateChange(Sender: TObject);
    procedure lvOrgEnter(Sender: TObject);
    procedure lvMsrEnter(Sender: TObject);
    procedure lvMsrSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Action_DB_RecoverNodeExecute(Sender: TObject);
    procedure Action_DB_DeleteNodeExecute(Sender: TObject);
    procedure miGoToSearchStringClick(Sender: TObject);
    procedure miOpenOtherPanelClick(Sender: TObject);
    procedure lvOrgSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvOrgKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pnlSearchExit(Sender: TObject);
    procedure pnlSearchEnter(Sender: TObject);
    procedure btbtnSearchClick(Sender: TObject);
    procedure cmbbxOrgTypeDropDown(Sender: TObject);
    procedure pmChangeTextColorPopup(Sender: TObject);
    procedure reMsrOtherInfoContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure reOrgOtherInfoContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure reOrgOtherInfoSelectionChange(Sender: TObject);
    procedure reOrgOtherInfoEnter(Sender: TObject);
    procedure reMsrOtherInfoEnter(Sender: TObject);
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
    procedure cmbbxMsrOrganizerDropDown(Sender: TObject);
    procedure cmbbxMsrPerformerDropDown(Sender: TObject);
    procedure cmbbxMsrProducerDropDown(Sender: TObject);
    procedure cmbbxMsrAuthorDropDown(Sender: TObject);
    procedure cmbbxMsrTypeDropDown(Sender: TObject);
    procedure cmbbxOrgWorkTimeDropDown(Sender: TObject);
    procedure cmbbxOrgStreetDropDown(Sender: TObject);
    procedure cmbbxOrgTownDropDown(Sender: TObject);
    procedure Action_PostMessageExecute(Sender: TObject);
    procedure Action_ViewMessagesExecute(Sender: TObject);
    procedure spedMsrDurationDaysChange(Sender: TObject);
    procedure chkbxMsrForAdultsOnlyClick(Sender: TObject);
    procedure chkbxMsrStopClick(Sender: TObject);
    procedure chkbxMsrStartClick(Sender: TObject);
    procedure Action_DB_StatisticExecute(Sender: TObject);
    procedure Action_DB_DisconnectionExecute(Sender: TObject);
    procedure Action_DB_ConnectionExecute(Sender: TObject);
    procedure chkbxStartDateClick(Sender: TObject);
    procedure chkbxStopDateClick(Sender: TObject);
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
    bNormalizeNow: boolean;
    blvOrgRedrawNow: boolean;
    blvMsrRedrawNow: boolean;
    bDoubleESC: boolean;
    iLastSelectedOrgIndex: integer;
(*
    function LoadDataFromRegistry(aKey, aValue: string; var Value: string): boolean; overload;
    function LoadDataFromRegistry(aKey, aValue: string; var Value: boolean): boolean; overload;
    function LoadDataFromRegistry(aKey, aValue: string; var Value: integer): boolean;  overload;
*)
    procedure SaveConfigIni;
    procedure LoadConfigIni;
    procedure UpdateSearchBar;
		procedure SetDefaultSettings(reA: TRichEdit);
    procedure Update_RichEditTools;
    procedure Refresh_NodeState(bFullRefresh: boolean);
    procedure SaveModifyOrg;
    procedure SaveModifyMsr;
    procedure OnMove(var Msg: TWMMove); message WM_MOVE;
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
    procedure MarkSearchedTextInRichEdit(aString: string; aRichEdit: TRichEdit);
    procedure TryToSet_lvOrg_Focused;
    procedure TryToSet_reOrgOtherInfo_Focused;
    procedure TryToSet_reMsrOtherInfo_Focused;

    procedure TryToSet_lvMsr_Focused;
    procedure TryToSet_reMsr_Focused;

    procedure TryToSet_edbxSearchName_Focused;

    procedure TryToSet_cmbbxOrgType_Focused;
    procedure TryToSet_edbxOrgType_Focused;

    procedure TryToSet_cmbbxMsrType_Focused;
    procedure TryToSet_edbxMsrType_Focused;
    
    procedure ShowEditBaloonTip(aEdit: TEdit; aTitle, aText: string; aIconType: tTTI);
    procedure HideEditBaloonTip(aEdit: TEdit);
  public
    clInfo: TColor;
    bParamShowID: boolean;
    bParamNoLogo: boolean;
    CurrentUser: TUserRec;
    MySQLConnectionHandler: PMYSQL;
    Configuration: TConfigurationRec;
    bAddingOrgNow: boolean;
    bAddingMsrNow: boolean;
    slLastSearchedName, slLastSearchedAddress, slLastSearchedOther: TStringList;
    procedure SetReady(aLogGroupGUID: string);
    procedure SetBusy(aLogGroupGUID: string);
    procedure LogThis(a, sGroupGIUD: string; MessageType: TLogMessagesType);
    function ValidateString(s: string): string;
    procedure Update_Actions;
    procedure Update_PhonesMark;
    procedure Update_OrgListCaption;
    procedure Update_MsrListCaption;
  end;
  procedure DivideNumberAndSymbolParts(const Source: string; var Num: integer; var Sym: string);
  function NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): AnsiString;
  procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);
  procedure HTMLtoRTF(html: string; var rtf: TRichedit);

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses About, Login, Options, Statistic, Users, Phones, CreateViewPost, ViewPostList, Registry, Grids, Maintenance, Clearing, // , RichEditTools
StrUtils;


procedure a1(aData, aLabel: string; aRichEdit: TRichEdit);
var
  iSelLenght: integer;
begin
  if Trim(aData)>'' then
    begin
      aRichEdit.SelStart:=0;
      aRichEdit.SelLength:=0;
      aRichEdit.Lines.Insert(0,aLabel+': '+Trim(aData));

      iSelLenght:=Length(aLabel+': '+Trim(aData));
      aRichEdit.SelStart:=0;
      aRichEdit.SelLength:=iSelLenght;
      aRichEdit.SelAttributes.Color:=clBlack;
      aRichEdit.Paragraph.Alignment:=taLeftJustify;
      aRichEdit.SelAttributes.Style:=[];

      iSelLenght:=Length(aLabel)+1;
      aRichEdit.SelStart:=0;
      aRichEdit.SelLength:=iSelLenght;
      aRichEdit.SelAttributes.Style:=[fsBold];
    end;
end;

procedure TMainForm.LogThis(a, sGroupGIUD: string; MessageType: TLogMessagesType);
var
  s, m, u: string;
  hOA4LogClient, hOA4LogClientListBox: HWND;
  aResult: LRESULT;
begin
  if not Configuration.bUseLog then
    Exit;
  SessionLogEventCount:=SessionLogEventCount+1;
  case MessageType of
    lmtError:   s:='ERROR  ';
    lmtWarning: s:='WARNING';
    lmtInfo:    s:='INFO   ';
    lmtSQL:     s:='SQL    ';
  end;
  if Configuration.bLogged then
    u:=CurrentUser.sLogin
  else u:='';
  m:=s+#09+ // тип сообщения
    StringReplace(FormatDateTime('dd.mm.yyyy hh:nn:ss',Now),' ',#09,[rfReplaceAll])+#09+ // дата и время сообщения
    sGroupGIUD+#09+
    StringReplace(Format('%10u',[SessionLogEventCount]),' ','0',[rfReplaceAll])+#09+ // порядковый номер сообщения
    u+#09+ // текущий залогированный пользователь
    a; // текст сообщения
  // проверка наличия окна лог-клиента и его перезапуск в случае отсутствия
  hOA4LogClient:=FindWindow('TMainForm','OA4 Log Client'); // получение хэндла окна лог-клиента
  if (hOA4LogClient=0) then // если не было найдено окно лог-клиента
    begin
      Screen.Cursor:=crHourGlass;
      if ((Configuration.sCustomLogClientFile='') and FileExists(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4LogClient.exe')) then
        ShellExecute(Application.Handle,'open',PChar(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4LogClient.exe'),nil,nil,SW_NORMAL); // попытаться его запустить вновь
      if ((Configuration.sCustomLogClientFile<>'') and FileExists(Configuration.sCustomLogClientFile)) then
        ShellExecute(Application.Handle,'open',PChar(Configuration.sCustomLogClientFile),nil,nil,SW_NORMAL); // попытаться его запустить вновь
      while (hOA4LogClient=0) do
        begin
          Sleep(500); // заснуть на 500 милисекунд
          hOA4LogClient:=FindWindow('TMainForm','OA4 Log Client'); // получение хэндла окна лог-клиента
        end;
      Screen.Cursor:=crDefault;
    end;
  hOA4LogClientListBox:=FindWindowEx(hOA4LogClient,HWND(nil),'TListBox',''); // получение хэндла окна лист-бокса лог-клиента
  if (hOA4LogClientListBox=0) then // если не было найдено окно лог-клиента
    MessageBox(Handle,PChar('Возникла ошибка при поиске окна списка лог-клиента!'+#13#10+'Обратитесь к администратору!'),PChar('Ошибка!'),MB_OK+MB_ICONERROR)
  else
    begin
      aResult:=SendMessage(hOA4LogClientListBox,LB_ADDSTRING,WPARAM(0),LPARAM(PChar(m)));
      if (aResult=LB_ERR) then
        MessageBox(Handle,PChar('Произошла ошибка при отправке сообщения лог-клиенту!'+#13#10+'Обратитесь к администратору!'),PChar('Ошибка!'),MB_OK+MB_ICONERROR);
      if (aResult=LB_ERRSPACE) then
        MessageBox(Handle,PChar('Произошла ошибка при отправке сообщения лог-клиенту - список переполнен!'+#13#10+'Обратитесь к администратору!'),PChar('Ошибка!'),MB_OK+MB_ICONERROR);
    end;
end;

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

function NormalizeStringForQuery(const Source: string; AddCommas, ReturnNull: boolean): AnsiString;
var
  z: PAnsiChar;
begin
  NormalizeStringForQuery:='';
  if ((ReturnNull) and (Trim(Source)='')) then
    NormalizeStringForQuery:='NULL'
  else
    begin
      z:=GetMemory(Length(PAnsiChar(Source))*2+1);
      try
        mysql_escape_string(z, PAnsiChar(Source),Length(PAnsiChar(Source)));
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

    while i <= Length(s) do
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
                if Tag <> '' then a_tag:=True;
              end
            else
              Tag:=Tag + s[i];
          end
        else
          tagparams:=tagparams + s[i];
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
      while i <= Length(s) do
        begin
          Inc(i);
          if s[i]='=' then
            begin
              notGleich:=False;
              Exit;
            end
          else if s[i]<>' ' then Exit;
        end;
    end;
    begin
      gleich:=False;
      Params.Clear;
      s:='';
      for i:=1 to Length(tagparams) do
        begin
          if (tagparams[i] <> ' ') then
            begin
              if tagparams[i] <> '=' then gleich:=False;
              if (tagparams[i] <> '''') and (tagparams[i] <> '"') then s:=s + tagparams[i]
            end
          else
            begin
              if (notGleich(tagparams, i)) and (not Gleich) then
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
      Result:=StringToColor('$' + Copy(Color, 6, 2) + Copy(Color, 4, 2) + Copy(Color, 2, 2));
    end;

    procedure TransformSpecialChars(var s: string; i: Integer);
    var
      c: string;
      z, z2: Byte;
      i2: Integer;
    const
      nchars=9;
      chars: array[1..nchars, 1..2] of string =
        (('O', 'O'), ('o', 'o'), ('A', 'A'), ('a', 'a'),
        ('U', 'U'), ('u', 'u'), ('?', '?'), ('<', '<'),
        ('>', '>'));
    begin
      // Maximal die nachsten 7 zeichen auf sonderzeichen uberprufen
      c:='';
      i2:=i;
      for z:=1 to 7 do
        begin
          c:=c + s[i2];
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
        1: Result:=6;
        2: Result:=9;
        3: Result:=12;
        4: Result:=15;
        5: Result:=18;
        6: Result:=22;
      else
        Result:=30;
      end;
    end;

// Die Font-Stack Funktionen
type
  fontstack = record
    Font: array[1..100] of tfont;
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
    if (s.Font[s.Pos] <> nil) and (s.Pos > 0) then
      begin
        fnt.Assign(s.Font[s.Pos]);
        // vom stack nehmen
        s.Font[s.Pos].Free;
        Dec(s.Pos);
      end;
  end;

  procedure FreeFontStack(var s: Fontstack);
  begin
    while s.Pos > 0 do
      begin
        s.Font[s.Pos].Free;
        Dec(s.Pos);
      end;
  end;
var
  fo_cnt: array[1..1000] of tfont;
  fo_liste: array[1..1000] of Boolean;
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
  if Length(html)=0 then Exit;
  repeat
    if html[i]='<' then
      begin
        //dummy:=i;
        GetTag(html, i, Tag, tagparams);
        GetTagParams(tagparams, params);

        // Das Font-Tag
        if Uppercase(Tag)='FONT' then
          begin
            // Schrift auf fontstack sichern
            pushFontstack(fo_stk, cfont);
            if params.Values['size'] <> '' then
              cfont.Size:=CalculateRTFSize(StrToInt(params.Values['size']));

            if params.Values['color'] <> '' then cfont.Color :=
              htmltocolor(params.Values['color']);
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
                                          cfont.Style:=cfont.Style + [fsbold]
                                        else
                                          if Uppercase(Tag)='/B' then
                                            cfont.Style:=cfont.Style - [fsbold]
                                          else // Italic-Tag
                                            if Uppercase(Tag)='I' then
                                              cfont.Style:=cfont.Style + [fsitalic]
                                            else
                                              if Uppercase(Tag)='/I' then
                                                cfont.Style:=cfont.Style - [fsitalic]
                                              else // underline-Tag
                                                if Uppercase(Tag)='U' then
                                                  cfont.Style:=cfont.Style + [fsunderline]
                                                else
                                                  if Uppercase(Tag)='/U' then
                                                    cfont.Style:=cfont.Style - [fsunderline]
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
                                                      if (Uppercase(Tag)='BR') or (Uppercase(Tag)='LI') then
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
        if (Ord(html[i]) <> 13) and (Ord(html[i]) <> 10) then
          rtf.Lines[row]:=RTF.Lines[row] + html[i];
      end;
    Inc(i);
  until i >= Length(html);
  // dummy eintragen
  fo_pos.Add('999999');
  // Den fertigen Text formatieren
  for i:=0 to fo_pos.Count - 2 do
    begin
      rtf.SelStart:=StrToInt(fo_pos[i]);
      rtf.SelLength:=StrToInt(fo_pos[i + 1]) - rtf.SelStart;
      rtf.SelAttributes.Style:=fo_cnt[i + 1].Style;
      rtf.SelAttributes.Size:=fo_cnt[i + 1].Size;
      rtf.SelAttributes.Color:=fo_cnt[i + 1].Color;
      // die font wieder freigeben;
      fo_cnt[i + 1].Free;
    end;
  // die Paragraphen also Listen setzen
  i:=0;
  while i <= fo_pos.Count - 2 do
    begin
      if fo_liste[i + 1] then
        begin
          rtf.SelStart:=StrToInt(fo_pos[i + 1]);
          while fo_liste[i + 1] do
            Inc(i);
          rtf.SelLength:=StrToInt(fo_pos[i - 1]) - rtf.SelStart;
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
  if Destination=nil
    then Destination:=TStringList.Create
    else Destination.Clear;
  Destination.Sorted:=False;
  while Length(s)>0 do
    begin
      i:=Pos(Limiter,s);
      if i=0 then
        begin
          Destination.Add(s);
          Exit;
        end
      else
        begin
          s1:=Copy(s,0,i-1);
          Destination.Add(s1);
          s1:=Copy(s,i+1,Length(s));
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
	new_s:=StringReplace(s,#39,'"',[rfReplaceAll]);
	// предварительное удаление двойных и граничных пробелов
	new_s:=Trim(new_s);
	while Pos('  ',new_s)>0 do new_s:=StringReplace(new_s,'  ',' ',[rfReplaceAll]);
	// удаление ограничивающих парных кавычек
	if new_s>'' then
		if (new_s[1]='"') and (new_s[Length(new_s)]='"') then
			new_s:=copy(new_s,2,Length(new_s)-2);
	// замена символов перевода строки и возврата каретки на пробелы
	new_s:=StringReplace(new_s,#10,' ',[rfReplaceAll]);
	new_s:=StringReplace(new_s,#13,' ',[rfReplaceAll]);
	// замена символа "."
	new_s:=StringReplace(new_s,' .','.',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'. ','.',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'.','. ',[rfReplaceAll]);
	// замена трёх точек на многоточие
	new_s:=StringReplace(new_s,'. . . ','... ',[rfReplaceAll]);
	// замена символа ","
	new_s:=StringReplace(new_s,' ,',',',[rfReplaceAll]);
	new_s:=StringReplace(new_s,', ',',',[rfReplaceAll]);
	new_s:=StringReplace(new_s,',',', ',[rfReplaceAll]);
	// замена символа "-"
	new_s:=StringReplace(new_s,' -','-',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'- ','-',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'-','- ',[rfReplaceAll]);
	// замена символа ":"
	new_s:=StringReplace(new_s,' :',':',[rfReplaceAll]);
	new_s:=StringReplace(new_s,': ',':',[rfReplaceAll]);
	new_s:=StringReplace(new_s,':',': ',[rfReplaceAll]);
	// корректировка случая "цифра-тире(двоеточие)-цифра" для дат и времени
	for j:=0 to 9 do for i:=0 to 9 do
		begin
			new_s:=StringReplace(new_s,IntToStr(j)+'- '+IntToStr(i),IntToStr(j)+'-'+IntToStr(i),[rfReplaceAll]);
			new_s:=StringReplace(new_s,IntToStr(j)+': '+IntToStr(i),IntToStr(j)+':'+IntToStr(i),[rfReplaceAll]);
			new_s:=StringReplace(new_s,IntToStr(j)+'. '+IntToStr(i),IntToStr(j)+':'+IntToStr(i),[rfReplaceAll]);
		end;
	// замена символа """
	new_s:=StringReplace(new_s,' "','"',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'" ','"',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'"',' " ',[rfReplaceAll]);
	// удаление двойных и граничных пробелов
	new_s:=Trim(new_s);
	while Pos('  ',new_s)>0 do new_s:=StringReplace(new_s,'  ',' ',[rfReplaceAll]);
	// замена символов "[" и "]"
	new_s:=StringReplace(new_s,' [','[',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'[ ','[',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'[',' [ ',[rfReplaceAll]);
	new_s:=StringReplace(new_s,' ]',']',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'] ',']',[rfReplaceAll]);
	new_s:=StringReplace(new_s,']',' ] ',[rfReplaceAll]);
	// удаление двойных и граничных пробелов
	new_s:=Trim(new_s);
	while Pos('  ',new_s)>0 do new_s:=StringReplace(new_s,'  ',' ',[rfReplaceAll]);
	// замена символов "[" и "]"
	new_s:=StringReplace(new_s,' <','<',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'< ','<',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'<',' < ',[rfReplaceAll]);
	new_s:=StringReplace(new_s,' >','>',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'> ','>',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'>',' > ',[rfReplaceAll]);
	// удаление двойных и граничных пробелов
	new_s:=Trim(new_s);
	while Pos('  ',new_s)>0 do new_s:=StringReplace(new_s,'  ',' ',[rfReplaceAll]);
	// замена символов "(" и ")"
	new_s:=StringReplace(new_s,' (','(',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'( ','(',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'(',' ( ',[rfReplaceAll]);
	new_s:=StringReplace(new_s,' )',')',[rfReplaceAll]);
	new_s:=StringReplace(new_s,') ',')',[rfReplaceAll]);
	new_s:=StringReplace(new_s,')',' ) ',[rfReplaceAll]);
	new_s:=StringReplace(new_s,') ,','),',[rfReplaceAll]);
	new_s:=StringReplace(new_s,') .',').',[rfReplaceAll]);
	new_s:=StringReplace(new_s,') ;',');',[rfReplaceAll]);
	// удаление двойных и граничных пробелов
	new_s:=Trim(new_s);
	while Pos('  ',new_s)>0 do new_s:=StringReplace(new_s,'  ',' ',[rfReplaceAll]);
	// ПРОЧИЕ ЗАМЕНЫ
	// если не указано сокращение "город" перед Минск, вставляем
	if Pos('Минск,',new_s)=1 then new_s:='г. '+new_s;
	if Pos('Минск.',new_s)=1 then new_s:='г. '+new_s;
  if Pos('Минск ',new_s)=1 then new_s:='г. '+new_s;
	new_s:=StringReplace(new_s,'www. ','www.',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'. by','.by',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'. ru','.ru',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'. com','.com',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'. net','.net',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'. org','.org',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'. open','.open',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'. tut','.tut',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'mailto: ','mailto:',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'mail: ','mail:',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'E- mail','E-mail',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'E- Mail','E-mail',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'e- Mail','E-mail',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'e- mail','E-mail',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'http: /','http:/',[rfReplaceAll]);
	new_s:=StringReplace(new_s,' atava.','atava.',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'< BR >','<BR>',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'< HR >','<HR>',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'< B >','<B>',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'< /B >','</B>',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'< A ','<A ',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'< /A >','</A>',[rfReplaceAll]);
  new_s:=StringReplace(new_s,'< FONT ','<FONT ',[rfReplaceAll]);
  new_s:=StringReplace(new_s,'< /FONT >','</FONT>',[rfReplaceAll]);
  new_s:=StringReplace(new_s,'<FONT COLOR= " RED " >','<FONT COLOR="RED">',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'карины','корины',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'карыны','корины',[rfReplaceAll]);
  new_s:=StringReplace(new_s,'пр. Скорины','пр- т Ф. Скорины',[rfReplaceAll]);
  new_s:=StringReplace(new_s,'пр. Ф. Скорины','пр- т Ф. Скорины',[rfReplaceAll]);
	new_s:=StringReplace(new_s,'пр- т Скорины','пр- т Ф. Скорины',[rfReplaceAll]);
	new_s:=StringReplace(new_s,' р- он',' р- н',[rfReplaceAll]);
	new_s:=StringReplace(new_s,' р- он,',' р- н,',[rfReplaceAll]);
	new_s:=StringReplace(new_s,' р- он.',' р- н.',[rfReplaceAll]);

	// ДОПИСАТЬ!!!
	// здесь нужно вставить обработку списка автозамен из окна опций

	// финальное удаление двойных и граничных пробелов
	new_s:=Trim(new_s);
	// добавление пробела в начале текстовой строки
	if new_s>'' then new_s:=' '+new_s;
	Result:=new_s;
end;

(*
function TMainForm.LoadDataFromRegistry(aKey, aValue: string; var Value: string): boolean;
var
  s: string;
begin
  Result:=False;
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      if OpenKeyReadOnly(aKey) then
        try
          s:=ReadString(aValue);
          Value:=s;
          Result:=True;
        except
          on ERegistryException do Result:=False;
        end;
    finally
      Free;
    end;
end;

function TMainForm.LoadDataFromRegistry(aKey, aValue: string; var Value: boolean): boolean;
var
  b: boolean;
begin
  Result:=False;
  with TRegistry.Create do
    try
      RootKey:= HKEY_CURRENT_USER;
      if OpenKeyReadOnly(aKey) then
        try
          b:=ReadBool(aValue);
          Value:=b;
          Result:=True;
        except
          on ERegistryException do Result:=False;
        end;
    finally
      Free;
    end;
end;

function TMainForm.LoadDataFromRegistry(aKey, aValue: string; var Value: integer): boolean;
var
  i: integer;
begin
  Result:=False;
  with TRegistry.Create do
    try
      RootKey:= HKEY_CURRENT_USER;
      if OpenKeyReadOnly(aKey) then
        try
          i:=ReadInteger(aValue);
          Value:=i;
          Result:=True;
        except
          on ERegistryException do Result:=False;
        end;
    finally
      Free;
    end;
end;
*)

procedure TMainForm.miStatusbarClick(Sender: TObject);
var
  s: string;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{3923C6B2-30D0-418D-9285-099AA15CDCC3}';
  SetBusy(LogGroupGUID);
  StatusBar1.Visible:=miStatusbar.Checked;
  if StatusBar1.Visible
    then s:='включена'
    else s:='отключена';
  LogThis('Панель статуса '+s+'.',LogGroupGUID,lmtInfo);
  SetReady(LogGroupGUID);
end;

procedure TMainForm.miToolbarClick(Sender: TObject);
var
  s: string;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{E531233C-900C-453F-B548-C5F25D29745D}';
  SetBusy(LogGroupGUID);
  ActionToolBar1.Visible:=miToolbar.Checked;
  if ActionToolBar1.Visible then
    s:='включена'
  else s:='отключена';
  LogThis('Панель кнопок '+s+'.',LogGroupGUID,lmtInfo);
  SetReady(LogGroupGUID);
end;

procedure TMainForm.miOpenOtherPanelClick(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      if Panel3.Visible then
        pnlOrganizationGeneralInfo.Visible:=not pnlOrganizationGeneralInfo.Visible;
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      if Panel10.Visible then
        pnlMesureGeneralInfo.Visible:=not pnlMesureGeneralInfo.Visible;
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
        if PageControl1.ActivePage=tsOrg then
          begin
            reOrgOtherInfo.SelAttributes.Color:=clInfo;
          end;
        if PageControl1.ActivePage=tsMsr then
          begin
            reMsrOtherInfo.SelAttributes.Color:=clInfo;
          end;
        ImageListForRichEditMenu.GetBitmap(14,bmB);
        bmB.Canvas.Brush.Color:=clInfo;
        bmB.Canvas.FillRect(Rect(0,14,16,16));
        ImageListForRichEditMenu.ReplaceMasked(14,bmB,bmB.Canvas.Pixels[0,0]);
      end;
  finally
    bmB.Free;
  end;
end;

procedure TMainForm.pnlSearchEnter(Sender: TObject);
begin
	if btbtnSearch.Default<>True then
		btbtnSearch.Default:=True;
end;

procedure TMainForm.pnlSearchExit(Sender: TObject);
begin
	if btbtnSearch.Default<>False then
		btbtnSearch.Default:=False;
end;

procedure TMainForm.reMsrOtherInfoContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  Action_RichEditUndo.Enabled:=reMsrOtherInfo.Perform(EM_CANUNDO,0,0)<>0;
  Action_RichEditRedo.Enabled:=reMsrOtherInfo.Perform(EM_CANREDO,0,0)<>0;
end;

procedure TMainForm.reMsrOtherInfoEnter(Sender: TObject);
begin
  Update_RichEditTools;
end;

procedure TMainForm.reOrgOtherInfoContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin
  Action_RichEditUndo.Enabled:=reOrgOtherInfo.Perform(EM_CANUNDO,0,0)<>0;
  Action_RichEditRedo.Enabled:=reOrgOtherInfo.Perform(EM_CANREDO,0,0)<>0;
end;

procedure TMainForm.reOrgOtherInfoEnter(Sender: TObject);
begin
  Update_RichEditTools;
end;

procedure TMainForm.reOrgOtherInfoSelectionChange(Sender: TObject);
begin
  Update_RichEditTools;
  if PageControl1.ActivePage=tsOrg then
    begin
      if Action_RichEditFormatBySample.Checked then
        begin
          reOrgOtherInfo.Paragraph.Alignment:=ParaAttr.Alignment;
          reOrgOtherInfo.Paragraph.FirstIndent:=ParaAttr.FirstIndent;
          reOrgOtherInfo.Paragraph.LeftIndent:=ParaAttr.LeftIndent;
          reOrgOtherInfo.Paragraph.Numbering:=ParaAttr.Numbering;
          reOrgOtherInfo.Paragraph.RightIndent:=ParaAttr.RightIndent;
          reOrgOtherInfo.Paragraph.TabCount:=ParaAttr.TabCount;
          reOrgOtherInfo.SelAttributes.Charset:=TextAttr.Charset;
          reOrgOtherInfo.SelAttributes.Color:=TextAttr.Color;
          reOrgOtherInfo.SelAttributes.Name:=TextAttr.Name;
          reOrgOtherInfo.SelAttributes.Pitch:=TextAttr.Pitch;
          reOrgOtherInfo.SelAttributes.Size:=TextAttr.Size;
          reOrgOtherInfo.SelAttributes.Style:=TextAttr.Style;
          reOrgOtherInfo.SelAttributes.Height:=TextAttr.Height;
          Action_RichEditFormatBySample.Checked:=False;
        end;
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      if Action_RichEditFormatBySample.Checked then
        begin
          reMsrOtherInfo.Paragraph.Alignment:=ParaAttr.Alignment;
          reMsrOtherInfo.Paragraph.FirstIndent:=ParaAttr.FirstIndent;
          reMsrOtherInfo.Paragraph.LeftIndent:=ParaAttr.LeftIndent;
          reMsrOtherInfo.Paragraph.Numbering:=ParaAttr.Numbering;
          reMsrOtherInfo.Paragraph.RightIndent:=ParaAttr.RightIndent;
          reMsrOtherInfo.Paragraph.TabCount:=ParaAttr.TabCount;
          reMsrOtherInfo.SelAttributes.Charset:=TextAttr.Charset;
          reMsrOtherInfo.SelAttributes.Color:=TextAttr.Color;
          reMsrOtherInfo.SelAttributes.Name:=TextAttr.Name;
          reMsrOtherInfo.SelAttributes.Pitch:=TextAttr.Pitch;
          reMsrOtherInfo.SelAttributes.Size:=TextAttr.Size;
          reMsrOtherInfo.SelAttributes.Style:=TextAttr.Style;
          reMsrOtherInfo.SelAttributes.Height:=TextAttr.Height;
          Action_RichEditFormatBySample.Checked:=False;
        end;
    end;
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
var
  s: string;
  p: integer;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{4966EB83-4593-42DC-9720-B2245F3C6964}';
  SetBusy(LogGroupGUID);
  with TAboutForm.Create(Self) do
    try
      Button1.Visible:=True;
      Timer1.Enabled:=False;
      AlphaBlendValue:=222;
      Timer2.Enabled:=False;
      s:=gsFileVersionInfo1.FileVersion;
      p:= LastDelimiter('.',s);
      s:= copy(s,1,p-1);
      Label2.Caption:=Format('Версия %s билд %s',[s,gsFileVersionInfo1.GetBuildOnly]);
      Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
      LogThis('Окно "О программе..." показано.',LogGroupGUID,lmtInfo);
      ShowModal;
    finally
      Free;
      LogThis('Окно "О программе..." скрыто.',LogGroupGUID,lmtInfo);
    end;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_DB_AddMeasureExecute(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{8B61DE2D-7B96-4EF7-8DE8-513B6687DCDA}';
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  bAddingMsrNow:=True;
  lvMsr.Selected:=nil;
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
  //очистка значений контролов
  lblId.Caption:='';
  lblCreation.Caption:='';
  lblModification.Caption:='';
	cmbbxMsrType.Clear;
	edbxMsrType.Clear;
	edbxMsrName.Clear;
  cmbbxMsrAuthor.Clear;
  edbxMsrAuthor.Clear;
  cmbbxMsrProducer.Clear;
  edbxMsrProducer.Clear;
  cmbbxMsrPerformer.Clear;
  edbxMsrPerformer.Clear;
  cmbbxMsrOrganizer.Clear;
  edbxMsrOrganizer.Clear;
  chkbxMsrIsPremier.Checked:=False;
  chkbxMsrIsTour.Checked:=False;
  chkbxMsrForChildren.Checked:=False;
  chkbxMsrForTeenagers.Checked:=False;
  chkbxMsrForAdultsOnly.Checked:=False;
  chkbxMsrStart.Checked:=False;
  chkbxMsrStop.Checked:=False;
  dtpMsrStartDate.Date:=Date;
  dtpMsrStartTime.Time:=EncodeTime(0,0,0,0);
  dtpMsrStopDate.Date:=Date;
  dtpMsrStopTime.Time:=EncodeTime(0,0,0,0);
  chkbxMsrUnknownDuration.Checked:=True;
  meMsrTicketPrice.Clear;
	reMsrOtherInfo.Clear;
  SetDefaultSettings(reMsrOtherInfo);
  Update_RichEditTools;
  pnlEdit.Visible:=CurrentUser.bDBEdition;
  btnCancel.Enabled:=True;
  btnCancel.Visible:=True;
  PageControl1.ActivePage:=tsMsr;
  TryToSet_cmbbxMsrType_Focused;
  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_DB_AddOrganizationExecute(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{5BFD1ED8-888F-4491-B83C-204D39C6F8F5}';
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  bAddingOrgNow:=True;
  if lvOrg.Selected<>nil then
    iLastSelectedOrgIndex:=lvOrg.Selected.Index
  else
    if lvOrg.Items.Count>0 then
      iLastSelectedOrgIndex:=0
    else iLastSelectedOrgIndex:=-1;
  lvOrg.Selected:=nil;
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
  //очистка значений контролов
  lblId.Caption:='';
  lblCreation.Caption:='';
  lblModification.Caption:='';
  edbxOrgType.Clear;
  cmbbxOrgType.Clear;
  edbxOrgName.Clear;
  edbxOrgAddress.Clear;
  edbxOrgTown.Clear;
  cmbbxOrgTown.Clear;
  edbxOrgStreet.Clear;
  cmbbxOrgStreet.Clear;
  edbxOrgHouse.Clear;
  edbxOrgSubHouse.Clear;
  edbxOrgFlat.Clear;
  edbxOrgHowToReach.Clear;
  edbxOrgWorkTime.Clear;
  cmbbxOrgWorkTime.Clear;
  reOrgOtherInfo.Clear;
  SetDefaultSettings(reOrgOtherInfo);
  Update_RichEditTools;
  pnlEdit.Visible:=CurrentUser.bDBEdition;
  btnCancel.Enabled:=True;
  btnCancel.Visible:=True;
  PageControl1.ActivePage:=tsOrg;
  TryToSet_cmbbxOrgType_Focused;
  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_DB_BackupExecute(Sender: TObject);
begin
  MessageBox(Handle,PChar('Данное действие на текущий момент в программе не реализовано.'),PChar('Невозможно выполнить операцию'),MB_OK+MB_ICONSTOP);
end;

procedure TMainForm.Action_DB_CleaningExecute(Sender: TObject);
var
  bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{251755BF-5D69-40A3-BDB7-EA67361E5BA9}';
  // MessageBox(Handle,PChar('Данное действие на текущий момент в программе не реализовано.'),PChar('Невозможно выполнить операцию'),MB_OK+MB_ICONSTOP);
  SetBusy(LogGroupGUID);
  bError:=False;
  LogThis('Попытка открытия окна очистки базы данных...',LogGroupGUID,lmtInfo);
  with TClearingForm.Create(Owner) do
    try
      Screen.Cursor:=crHourGlass;
      // настройка компонентов интерфейса
      ImageList2.GetIcon(7,Icon);
      if Configuration.fpClearingForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Top:=Configuration.fpClearingForm.y;
          Left:=Configuration.fpClearingForm.x;
        end;
      Screen.Cursor:=crDefault;
      if bError=False then
        ShowModal;
    finally
      Configuration.fpClearingForm.y:=Top;
      Configuration.fpClearingForm.x:=Left;
      Free;
    end;
  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_DB_ConnectionExecute(Sender: TObject);
var
  mr: TModalResult;
  s, q: string;
  pm: PMYSQL;
  i: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{A6FBE8D3-4ECD-4232-8E81-14896E25EA9A}';
  SetBusy(LogGroupGUID);
  ResultSet:=nil;
  LogThis('Выполняется открытие окна ввода пользователя и пароля...',LogGroupGUID,lmtInfo);
  with TLoginForm.Create(Self) do
    try
      if Configuration.fpLoginForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Left:=Configuration.fpLoginForm.x;
          Top:=Configuration.fpLoginForm.y;
        end;
      if (Configuration.bStoreLastLogin and (Configuration.sLastLogin<>'')) then
        begin
          edbxLogin.Text:=Configuration.sLastLogin;
          if (Configuration.bStoreLastPassword and (Configuration.sLastPassword<>'')) then
            begin
              edbxPassword.Text:=Configuration.sLastPassword;
              if Configuration.bAutoLogon then
                ModalResult:=mrOk
              else
                begin
                  ActiveControl:=btnOk;
                  ShowModal;
                end;
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
      Configuration.fpLoginForm.x:=Left;
      Configuration.fpLoginForm.y:=Top;
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
      LogThis('Данные пользователя введены...',LogGroupGUID,lmtInfo);
      LogThis('Выполняется инициализация объекта соединения MySQL...',LogGroupGUID,lmtInfo);
      MySQLConnectionHandler:=mysql_init(nil);
      if MySQLConnectionHandler<>nil then
        begin
          LogThis('Инициализация объекта соединения MySQL прошла успешно.',LogGroupGUID,lmtInfo);
          LogThis('Выполняется попытка подключения к серверу MySQL...',LogGroupGUID,lmtInfo);
          Screen.Cursor:=crHourGlass;
          pm:=mysql_real_connect(MySQLConnectionHandler,PChar(Configuration.sMySQLHost),PChar(Configuration.sMySQLUser),PChar(Configuration.sMySQLPassword),PChar(Configuration.sMySQLDatabase),Configuration.iMySQLPort,nil,1);
          Screen.Cursor:=crDefault;
          if pm=MySQLConnectionHandler then
            begin
              LogThis('Подключение к серверу MySQL выполнено успешно.',LogGroupGUID,lmtInfo);
              q:='SHOW TABLES FROM '+Configuration.sMySQLDatabase+' LIKE "_usr";';
              LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                  ResultSet:=mysql_store_result(MySQLConnectionHandler);
                  if ResultSet<>nil then
                    begin
                      LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                      i:=mysql_num_rows(ResultSet);
                      if i=1 then
                        begin
                          LogThis('Таблица пользователей базы данных найдена успешно.',LogGroupGUID,lmtInfo);
                          q:='SELECT COUNT(*) FROM '+Configuration.sMySQLDatabase+'._usr WHERE usr_login="'+CurrentUser.sLogin+'" AND usr_password_md5=md5("'+CurrentUser.sPassword+'") AND usr_erased="0";';
                          LogThis(q,LogGroupGUID,lmtSQL);
                          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                          if i=0 then
                            begin
                              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                              ResultSet:=mysql_store_result(MySQLConnectionHandler);
                              if ResultSet<>nil then
                                begin
                                  LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                                  i:=mysql_num_rows(ResultSet);
                                  if i=1 then
                                    begin
                                      LogThis('Количество строк выборки соответствует требуемому.',LogGroupGUID,lmtInfo);
                                      LogThis('Получение очередной строки выборки.',LogGroupGUID,lmtInfo);
                                      ResultRow:=mysql_fetch_row(ResultSet);
                                      if ResultRow[0]='1' then
                                        begin
                                          LogThis('Указанный пользователь найден в базе данных!',LogGroupGUID,lmtInfo);
                                          LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
                                          if ResultSet<>nil then
                                            mysql_free_result(ResultSet);
                                          LogThis('Получение данных и прав доступа указанного пользователя...',LogGroupGUID,lmtInfo);
                                          q:='SELECT usr_id, usr_fullname, usr_is_admin, usr_can_edit_db, usr_can_backup_db, usr_can_clear_db, usr_can_defrag_db, usr_can_maintain_db, usr_can_edit_db_users FROM '+Configuration.sMySQLDatabase+'._usr WHERE usr_login="'+CurrentUser.sLogin+'" AND usr_password_md5=md5("'+CurrentUser.sPassword+'");';
                                          LogThis(q,LogGroupGUID,lmtSQL);
                                          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                                          if i=0 then
                                            begin
                                              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                                              ResultSet:=mysql_store_result(MySQLConnectionHandler);
                                              if ResultSet<>nil then
                                                begin
                                                  LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                                                  i:=mysql_num_rows(ResultSet);
                                                  if i=1 then
                                                    begin
                                                      LogThis('Количество строк выборки соответствует требуемому.',LogGroupGUID,lmtInfo);
                                                      LogThis('Получение очередной строки выборки.',LogGroupGUID,lmtInfo);
                                                      ResultRow:=mysql_fetch_row(ResultSet);
                                                      if ResultRow<>nil then
                                                        begin
                                                          //sLastSearchedText:='';
                                                          CurrentUser.sID:=ResultRow[0];
                                                          CurrentUser.sFullName:=ResultRow[1];
                                                          CurrentUser.bIsAdmin:=boolean(StrToIntDef(ResultRow[2],0));
                                                          CurrentUser.bDBEdition:=boolean(StrToIntDef(ResultRow[3],0));
                                                          CurrentUser.bDBBackup:=boolean(StrToIntDef(ResultRow[4],0));
                                                          CurrentUser.bDBCleaning:=boolean(StrToIntDef(ResultRow[5],0));
                                                          CurrentUser.bDBDefragmentation:=boolean(StrToIntDef(ResultRow[6],0));
                                                          CurrentUser.bDBMaintenance:=boolean(StrToIntDef(ResultRow[7],0));
                                                          CurrentUser.bDBUsersEdition:=boolean(StrToIntDef(ResultRow[8],0));
                                                          LogThis('Получение данных и прав доступа указанного пользователя произведено успешно.',LogGroupGUID,lmtInfo);
                                                          LogThis('Подключение пользователя к базе данных выполнено успешно.',LogGroupGUID,lmtInfo);
                                                          // проверка на возможность подключения к базе
                                                          // не находится ли база в монопольном режиме доступа?
//                                                          LogThis('Проверка флагов программы...',LogGroupGUID,lmtInfo);
//                                                          q:='SELECT COUNT(*) FROM '+Configuration.sMySQLDatabase+'._flags WHERE flag_name="flag_monopoly" AND flag_value="0";';
//                                                          LogThis(q,LogGroupGUID,lmtSQL);
//                                                          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
//                                                          if i=0 then
//                                                            begin
//                                                              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
//                                                              ResultSet:=mysql_store_result(MySQLConnectionHandler);
//                                                              if ResultSet<>nil then
//                                                                begin
//                                                                  LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
//                                                                  i:=mysql_num_rows(ResultSet);
//                                                                  if i=1 then
//                                                                    begin
//                                                                      LogThis('Количество строк выборки соответствует требуемому.',LogGroupGUID,lmtInfo);
//                                                                      LogThis('Получение очередной строки выборки.',LogGroupGUID,lmtInfo);
//                                                                      ResultRow:=mysql_fetch_row(ResultSet);
//                                                                      if (ResultRow[0]='1') then
//                                                                      //if ((ResultRow[0]='1') or (not CurrentUser.bDBEdition)) then
//                                                                        begin
//                                                                          LogThis('Монопольный режим в настоящий момент не задействован...',LogGroupGUID,lmtInfo);
////                                                                          if not CurrentUser.bDBEdition then
////                                                                            begin
////                                                                              LogThis('База находится в монопольном режиме, но пользователь имеет право на вход, так как не имеет прав на редактирование информации.',LogGroupGUID,lmtWarning);
////                                                                            end;
                                                                          Action_DB_Connection.Visible:=False;
                                                                          Action_DB_Connection.Enabled:=False;
                                                                          Action_DB_Disconnection.Visible:=True;
                                                                          Action_DB_Disconnection.Enabled:=True;
                                                                          pnlEdit.Visible:=False;
                                                                          PageControl1.ActivePage:=tsClear;
                                                                          //pnlEdit.Visible:=(not (PageControl1.ActivePage=tsClear))and CurrentUser.bDBEdition;



                                                                          pnlConnectedMode.Visible:=True; // !!!!!!!!!!!!!!!!!!
                                                                          if Configuration.bDataPanelHalfWidth then
                                                                            pnlData.Width:=(pnlConnectedMode.Width-Splitter1.Width) div 2
                                                                          else pnlData.Width:=Configuration.iDataPanelWidth;

                                                                          if Configuration.bOrgPanelHalfHeight then
                                                                            pnlOrgLV.Height:=(pnlSearchResultsCreationModification.Height-pnlCreationModification.Height-Splitter2.Height) div 2
                                                                          else pnlOrgLV.Height:=Configuration.iOrgPanelHeight;
                                                                          Application.ProcessMessages;

                                                                          Configuration.bLogged:=True;
                                                                          bAddingOrgNow:=False;
                                                                          bAddingMsrNow:=False;
                                                                          //btbtnMore.Tag:=0; // демонтаж кнопкм
                                                                          UpdateSearchBar;
                                                                          cmbbxOrgType.Visible:=CurrentUser.bDBEdition;
                                                                          edbxOrgType.Visible:=not CurrentUser.bDBEdition;
                                                                          edbxOrgName.ReadOnly:=not CurrentUser.bDBEdition;
                                                                          edbxOrgAddress.ReadOnly:=not CurrentUser.bDBEdition;
                                                                          edbxOrgTown.Visible:=not CurrentUser.bDBEdition;
                                                                          cmbbxOrgTown.Visible:=CurrentUser.bDBEdition;
                                                                          edbxOrgStreet.Visible:=not CurrentUser.bDBEdition;
                                                                          cmbbxOrgStreet.Visible:=CurrentUser.bDBEdition;
                                                                          edbxOrgHouse.ReadOnly:=not CurrentUser.bDBEdition;
                                                                          edbxOrgSubHouse.ReadOnly:=not CurrentUser.bDBEdition;
                                                                          edbxOrgFlat.ReadOnly:=not CurrentUser.bDBEdition;
                                                                          edbxOrgHowToReach.ReadOnly:=not CurrentUser.bDBEdition;
                                                                          cmbbxOrgWorkTime.Visible:=CurrentUser.bDBEdition;
                                                                          edbxOrgWorkTime.Visible:=not CurrentUser.bDBEdition;
                                                                          reOrgOtherInfo.ReadOnly:=not CurrentUser.bDBEdition;

                                                                          cmbbxMsrType.Visible:=CurrentUser.bDBEdition;
                                                                          edbxMsrType.Visible:=not CurrentUser.bDBEdition;
                                                                          edbxMsrName.ReadOnly:=not CurrentUser.bDBEdition;
                                                                          cmbbxMsrAuthor.Visible:=CurrentUser.bDBEdition;
                                                                          edbxMsrAuthor.Visible:=not CurrentUser.bDBEdition;
                                                                          cmbbxMsrProducer.Visible:=CurrentUser.bDBEdition;
                                                                          edbxMsrProducer.Visible:=not CurrentUser.bDBEdition;
                                                                          cmbbxMsrPerformer.Visible:=CurrentUser.bDBEdition;
                                                                          edbxMsrPerformer.Visible:=not CurrentUser.bDBEdition;
                                                                          cmbbxMsrOrganizer.Visible:=CurrentUser.bDBEdition;
                                                                          edbxMsrOrganizer.Visible:=not CurrentUser.bDBEdition;
                                                                          pnlMsrDateTime.Enabled:=CurrentUser.bDBEdition;
                                                                          gpbxMsrDuration.Enabled:=CurrentUser.bDBEdition;
                                                                          gpbxMsrFlags.Enabled:=CurrentUser.bDBEdition;
                                                                          meMsrTicketPrice.ReadOnly:=not CurrentUser.bDBEdition;
                                                                          reMsrOtherInfo.ReadOnly:=not CurrentUser.bDBEdition;

                                                                          // очистка окна результатов поиска
                                                                          reMsr.Lines.BeginUpdate;
                                                                          reMsr.Clear;
                                                                          SendMessage(reMsr.Handle, WM_HSCROLL, SB_TOP, 0);
                                                                          reMsr.Lines.EndUpdate;

                                                                          lvOrg.Items.BeginUpdate;
                                                                          SendMessage(lvOrg.Handle, LVM_REMOVEALLGROUPS, 0, 0);
                                                                          SendMessage(lvOrg.Handle, LVM_DELETEALLITEMS, 0, 0);
                                                                          lvOrg.Items.EndUpdate;

                                                                          lvMsr.Items.BeginUpdate;
                                                                          SendMessage(lvMsr.Handle, LVM_REMOVEALLGROUPS, 0, 0);
                                                                          SendMessage(lvMsr.Handle, LVM_DELETEALLITEMS, 0, 0);
                                                                          lvMsr.Items.EndUpdate;

                                                                          if CurrentUser.bDBEdition then
                                                                            begin
                                                                              lvOrg.SmallImages:=ImageList5;
                                                                              lvMsr.SmallImages:=ImageList5;
                                                                              lvOrg.ColumnClick:=True;
                                                                              lvOrg.ColumnClick:=False;
                                                                              lvOrg.ColumnClick:=True;
                                                                              lvOrgColumnClick(Sender, lvOrg.Columns[Configuration.iOrgSortColumn]);
                                                                              lvMsr.ColumnClick:=True;
                                                                              lvMsr.ColumnClick:=False;
                                                                              lvMsr.ColumnClick:=True;
                                                                              lvMsrColumnClick(Sender, lvMsr.Columns[Configuration.iMsrSortColumn]);
                                                                            end
                                                                          else
                                                                            begin
                                                                              lvOrg.SmallImages:=nil;
                                                                              lvMsr.SmallImages:=nil;
                                                                              lvOrg.ColumnClick:=True;
                                                                              lvOrg.ColumnClick:=False;
                                                                              //lvOrg.ColumnClick:=True;
                                                                              lvOrgColumnClick(Sender, lvOrg.Columns[Configuration.iOrgSortColumn]);
                                                                              lvMsr.ColumnClick:=True;
                                                                              lvMsr.ColumnClick:=False;
                                                                              //lvMsr.ColumnClick:=True;
                                                                              lvMsrColumnClick(Sender, lvMsr.Columns[Configuration.iMsrSortColumn]);
                                                                            end;
                                                                          lvOrg.OnResize(Sender);
                                                                          //lvMsr.OnResize(Sender);
                                                                          if Configuration.bShowMeasuresListAsRichEdit and (not CurrentUser.bDBEdition) then
                                                                            begin
                                                                              lvMsr.Visible:=False;
                                                                              reMsr.Visible:=True;
                                                                            end
                                                                          else
                                                                            begin
                                                                              reMsr.Visible:=False;
                                                                              lvMsr.Visible:=True;
                                                                            end;
                                                                          lblCreationCaption.Visible:=False;
                                                                          lblCreation.Visible:=False;
                                                                          lblModificationCaption.Visible:=False;
                                                                          lblModification.Visible:=False;
                                                                          lblIDCaption.Visible:=False;
                                                                          lblID.Visible:=False;

                                                                          StatusBar1.Panels[STATUSBAR_SERVER_NAME].Width:=StatusBar1.Canvas.TextWidth(Configuration.sMySQLHost)+6;
                                                                          StatusBar1.Panels[STATUSBAR_SERVER_NAME].Text:=Configuration.sMySQLHost;
                                                                          //reOrgOther.PlainText:=True;
                                                                          //reOrgOther.PlainText:=False;
                                                                          Update_PhonesMark;
                                                                          MainForm.ActiveControl:=edbxSearchName;
                                                                          Update_OrgListCaption;
                                                                          Update_MsrListCaption;
                                                                          Timer_MessageStatus.Enabled:=True;
                                                                          Timer_MessageStatusTimer(Sender);
//                                                                        end
//                                                                      else s:='В данный момент Вы не можете подключиться к базе данных,'+#13#10+'поскольку она используется в монопольном режиме другим пользователем!'+#13#10+'Данный запрет введён во избежание ошибок при обслуживании базы данных.'+#13#10+'За информацией обратитесь к администратору!';
//                                                                    end
//                                                                  else s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
//                                                                end
//                                                              else s:='Количество строк выборки ('+IntToStr(i)+')не соответствует требуемому (1)!';
//                                                            end
//                                                          else s:='Возникла ошибка при выполнении запроса!';
                                                        end
                                                      else s:='Возникла ошибка при загрузке данных строки выборки!';
                                                    end
                                                  else s:='Количество строк выборки ('+IntToStr(i)+')не соответствует требуемому (1)!';
                                                end
                                              else s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            end
                                          else s:='Возникла ошибка при выполнении запроса!';
                                        end
                                      else s:='Указанный пользователь не найден в базе данных, процесс подключения отменён!';
                                    end
                                  else s:='Количество строк выборки ('+IntToStr(i)+')не соответствует требуемому (1)!';
                                end
                              else s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                            end
                          else s:='Возникла ошибка при выполнении запроса!';
                        end
                      else s:='Ошибка при поиске таблицы пользователей базы данных!';
                    end
                  else s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                end
              else s:='Возникла ошибка при выполнении запроса!';
            end
          else
            begin
              i:=mysql_errno(MySQLConnectionHandler);
//              s:=mysql_error(MySQLConnectionHandler);
              if i=2003 then
                s:='Возникла ошибка при попытке подключения к серверу MySQL, так как сервер MySQL не запущен!'
              else s:='Возникла ошибка при попытке подключения к серверу MySQL!';
            end;
        end
      else s:='Возникла ошибка при инициализации объекта соединения MySQL!';
      if ResultSet<>nil then
        begin
          LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
          mysql_free_result(ResultSet);
        end;
      if Action_DB_Connection.Visible then
        begin
          LogThis(s,LogGroupGUID,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
    end
  else LogThis('Ввод данных пользователя отменён.',LogGroupGUID,lmtWarning);
  Update_Actions;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_DB_DisconnectionExecute(Sender: TObject);
begin
  Action_DB_Connection.Visible:=True;
  Action_DB_Connection.Enabled:=True;
  Action_DB_Disconnection.Visible:=False;
  Action_DB_Disconnection.Enabled:=False;
  pnlConnectedMode.Visible:=False;
  Configuration.bLogged:=False;
  Timer_MessageStatus.Enabled:=False;
  UpdateSearchBar;
  StatusBar1.Panels[STATUSBAR_SERVER_NAME].Width:=0;
  StatusBar1.Panels[STATUSBAR_SERVER_NAME].Text:='';
  if MySQLConnectionHandler<>nil then
    begin
      mysql_close(MySQLConnectionHandler);
      MySQLConnectionHandler:=nil;
    end;
  SaveConfigIni;
  Update_Actions;
end;

procedure TMainForm.Action_DB_MaintenanceExecute(Sender: TObject);
var
  bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{B67ABC1F-85C1-4B63-9BAA-3AE7821F72C2}';
  SetBusy(LogGroupGUID);
  bError:=False;
  LogThis('Попытка открытия окна полного обслуживания базы данных...',LogGroupGUID,lmtInfo);
  with TMaintenanceForm.Create(Owner) do
    try
      Screen.Cursor:=crHourGlass;
      // настройка компонентов интерфейса
      ImageList2.GetIcon(9,Icon);
      if Configuration.fpMaintenanceForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Top:=Configuration.fpMaintenanceForm.y;
          Left:=Configuration.fpMaintenanceForm.x;
        end;
      Screen.Cursor:=crDefault;
      if bError=False then
        ShowModal;
    finally
      Configuration.fpMaintenanceForm.y:=Top;
      Configuration.fpMaintenanceForm.x:=Left;
      Free;
    end;
  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.SetBusy(aLogGroupGUID: string);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:=aLogGroupGUID;
  LogThis('Установлен режим "Занято".',LogGroupGUID,lmtInfo);
  ImageList3.GetIcon(0,Image1.Picture.Icon);
  Application.ProcessMessages;
end;

procedure TMainForm.SetReady(aLogGroupGUID: string);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:=aLogGroupGUID;
  LogThis('Установлен режим "Готово".',LogGroupGUID,lmtInfo);
  ImageList3.GetIcon(1,Image1.Picture.Icon);
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Action_RichEditBoldExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      if fsBold in reOrgOtherInfo.SelAttributes.Style then
        reOrgOtherInfo.SelAttributes.Style:=reOrgOtherInfo.SelAttributes.Style-[fsBold]
      else reOrgOtherInfo.SelAttributes.Style:=reOrgOtherInfo.SelAttributes.Style+[fsBold];
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      if fsBold in reMsrOtherInfo.SelAttributes.Style then
        reMsrOtherInfo.SelAttributes.Style:=reMsrOtherInfo.SelAttributes.Style-[fsBold]
      else reMsrOtherInfo.SelAttributes.Style:=reMsrOtherInfo.SelAttributes.Style+[fsBold];
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditBulletsExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      reOrgOtherInfo.Paragraph.Numbering:=TNumberingStyle(not boolean(reOrgOtherInfo.Paragraph.Numbering));
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      reMsrOtherInfo.Paragraph.Numbering:=TNumberingStyle(not boolean(reMsrOtherInfo.Paragraph.Numbering));
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditItalicExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      if fsItalic in reOrgOtherInfo.SelAttributes.Style then
        reOrgOtherInfo.SelAttributes.Style:=reOrgOtherInfo.SelAttributes.Style-[fsItalic]
      else reOrgOtherInfo.SelAttributes.Style:=reOrgOtherInfo.SelAttributes.Style+[fsItalic];
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      if fsItalic in reMsrOtherInfo.SelAttributes.Style then
        reMsrOtherInfo.SelAttributes.Style:=reMsrOtherInfo.SelAttributes.Style-[fsItalic]
      else reMsrOtherInfo.SelAttributes.Style:=reMsrOtherInfo.SelAttributes.Style+[fsItalic];
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditLeftAlignExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      reOrgOtherInfo.Paragraph.Alignment:=taLeftJustify;
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      reMsrOtherInfo.Paragraph.Alignment:=taLeftJustify;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditUnderlineExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      if fsUnderline in reOrgOtherInfo.SelAttributes.Style then
        reOrgOtherInfo.SelAttributes.Style:=reOrgOtherInfo.SelAttributes.Style-[fsUnderline]
      else reOrgOtherInfo.SelAttributes.Style:=reOrgOtherInfo.SelAttributes.Style+[fsUnderline];
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      if fsUnderline in reMsrOtherInfo.SelAttributes.Style then
        reMsrOtherInfo.SelAttributes.Style:=reMsrOtherInfo.SelAttributes.Style-[fsUnderline]
      else reMsrOtherInfo.SelAttributes.Style:=reMsrOtherInfo.SelAttributes.Style+[fsUnderline];
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditCenterAlignExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      reOrgOtherInfo.Paragraph.Alignment:=taCenter;
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      reMsrOtherInfo.Paragraph.Alignment:=taCenter;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditCopyExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    if ActiveControl=reOrgOtherInfo then
      reOrgOtherInfo.CopyToClipboard;
  if PageControl1.ActivePage=tsMsr then
    if ActiveControl=reMsrOtherInfo then
      reMsrOtherInfo.CopyToClipboard;
end;

procedure TMainForm.Action_RichEditCutExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    if ActiveControl=reOrgOtherInfo then
      reOrgOtherInfo.CutToClipboard;
  if PageControl1.ActivePage=tsMsr then
    if ActiveControl=reMsrOtherInfo then
      reMsrOtherInfo.CutToClipboard;
end;

procedure TMainForm.Action_RichEditDecreaseFontExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    reOrgOtherInfo.SelAttributes.Size:=reOrgOtherInfo.SelAttributes.Size-1;
  if PageControl1.ActivePage=tsMsr then
    reMsrOtherInfo.SelAttributes.Size:=reMsrOtherInfo.SelAttributes.Size-1;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditDefaultFormatExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      SetDefaultSettings(reOrgOtherInfo);
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      SetDefaultSettings(reMsrOtherInfo);
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditEnlargeFontExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      reOrgOtherInfo.SelAttributes.Size:=reOrgOtherInfo.SelAttributes.Size+1;
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      reMsrOtherInfo.SelAttributes.Size:=reMsrOtherInfo.SelAttributes.Size+1;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditEraseExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    if ActiveControl=reOrgOtherInfo then
      reOrgOtherInfo.Perform(WM_CLEAR,0,0);
  if PageControl1.ActivePage=tsMsr then
    if ActiveControl=reMsrOtherInfo then
      reMsrOtherInfo.Perform(WM_CLEAR,0,0);
end;

procedure TMainForm.Action_RichEditFormatBySampleExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      if Action_RichEditFormatBySample.Checked then
        begin
          Action_RichEditFormatBySample.Checked:=False;
        end
      else
        begin
          ParaAttr.Alignment:=reOrgOtherInfo.Paragraph.Alignment;
          ParaAttr.FirstIndent:=reOrgOtherInfo.Paragraph.FirstIndent;
          ParaAttr.LeftIndent:=reOrgOtherInfo.Paragraph.LeftIndent;
          ParaAttr.Numbering:=reOrgOtherInfo.Paragraph.Numbering;
          ParaAttr.RightIndent:=reOrgOtherInfo.Paragraph.RightIndent;
          ParaAttr.TabCount:=reOrgOtherInfo.Paragraph.TabCount;
          TextAttr.Charset:=reOrgOtherInfo.SelAttributes.Charset;
          TextAttr.Color:=reOrgOtherInfo.SelAttributes.Color;
          TextAttr.Name:=reOrgOtherInfo.SelAttributes.Name;
          TextAttr.Pitch:=reOrgOtherInfo.SelAttributes.Pitch;
          TextAttr.Size:=reOrgOtherInfo.SelAttributes.Size;
          TextAttr.Style:=reOrgOtherInfo.SelAttributes.Style;
          TextAttr.Height:=reOrgOtherInfo.SelAttributes.Height;
			    Action_RichEditFormatBySample.Checked:=True;
        end;
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      if Action_RichEditFormatBySample.Checked then
        begin
          Action_RichEditFormatBySample.Checked:=False;
        end
      else
        begin
          ParaAttr.Alignment:=reMsrOtherInfo.Paragraph.Alignment;
          ParaAttr.FirstIndent:=reMsrOtherInfo.Paragraph.FirstIndent;
          ParaAttr.LeftIndent:=reMsrOtherInfo.Paragraph.LeftIndent;
          ParaAttr.Numbering:=reMsrOtherInfo.Paragraph.Numbering;
          ParaAttr.RightIndent:=reMsrOtherInfo.Paragraph.RightIndent;
          ParaAttr.TabCount:=reMsrOtherInfo.Paragraph.TabCount;
          TextAttr.Charset:=reMsrOtherInfo.SelAttributes.Charset;
          TextAttr.Color:=reMsrOtherInfo.SelAttributes.Color;
          TextAttr.Name:=reMsrOtherInfo.SelAttributes.Name;
          TextAttr.Pitch:=reMsrOtherInfo.SelAttributes.Pitch;
          TextAttr.Size:=reMsrOtherInfo.SelAttributes.Size;
          TextAttr.Style:=reMsrOtherInfo.SelAttributes.Style;
          TextAttr.Height:=reMsrOtherInfo.SelAttributes.Height;
			    Action_RichEditFormatBySample.Checked:=True;
        end;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditPasteExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    if ActiveControl=reOrgOtherInfo then
      reOrgOtherInfo.PasteFromClipboard;
  if PageControl1.ActivePage=tsMsr then
    if ActiveControl=reMsrOtherInfo then
      reMsrOtherInfo.PasteFromClipboard;
end;

procedure TMainForm.Action_RichEditSelectAllExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    if ActiveControl=reOrgOtherInfo then
      reOrgOtherInfo.SelectAll;
  if PageControl1.ActivePage=tsMsr then
    if ActiveControl=reMsrOtherInfo then
      reMsrOtherInfo.SelectAll;
end;

procedure TMainForm.Action_RichEditSetTextColorExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      reOrgOtherInfo.SelAttributes.Color:=clInfo;
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      reMsrOtherInfo.SelAttributes.Color:=clInfo;
    end;
  Update_RichEditTools;
end;

procedure TMainForm.Action_RichEditUndoExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    if ActiveControl=reOrgOtherInfo then
      reOrgOtherInfo.Undo;
  if PageControl1.ActivePage=tsMsr then
    if ActiveControl=reMsrOtherInfo then
      reMsrOtherInfo.Undo;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.chkbxMsrForAdultsOnlyClick(Sender: TObject);
begin
  chkbxMsrForChildren.Enabled:=not chkbxMsrForAdultsOnly.Checked;
  chkbxMsrForTeenagers.Enabled:=not chkbxMsrForAdultsOnly.Checked;
  chkbxMsrForChildren.Checked:=not chkbxMsrForAdultsOnly.Checked and not chkbxMsrForChildren.Enabled;
  chkbxMsrForTeenagers.Checked:=not chkbxMsrForAdultsOnly.Checked and not chkbxMsrForTeenagers.Enabled;
end;

procedure TMainForm.chkbxStartDateClick(Sender: TObject);
begin
  dtpStartDate.Enabled:=chkbxStartDate.Checked;
end;

procedure TMainForm.chkbxStopDateClick(Sender: TObject);
begin
  dtpStopDate.Enabled:=chkbxStopDate.Checked;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  s: string;
  i: integer;
  PanelRect: TRect;
  pwcGroupName: PWideChar;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{2407AA97-1792-4064-8423-58FD9F9138DE}';
  bNormalizeNow:=False;
  lvOrg.DoubleBuffered:=True;
  lvMsr.DoubleBuffered:=True;
  MainForm.Constraints.MaxWidth:=0;
  MainForm.Constraints.MaxHeight:=0;
  bDoubleESC:=False;

  slLastSearchedName:=TStringList.Create;
  slLastSearchedAddress:=TStringList.Create;
  slLastSearchedOther:=TStringList.Create;

  LoadConfigIni;

  bNormalizeNow:=True;

  MainForm.WindowState:=wsNormal;
  MainForm.Width:=Configuration.iMainFormWidth;
  MainForm.Height:=Configuration.iMainFormHeight;

  if Configuration.fpMainForm.bCenter then
    MainForm.Position:=poScreenCenter
  else
    begin
      MainForm.Position:=poDesigned;
      MainForm.Left:=Configuration.fpMainForm.x;
      MainForm.Top:=Configuration.fpMainForm.y;
    end;

  if Configuration.bFullScreen then
    begin
      MainForm.Position:=poDesigned;
      MainForm.WindowState:=wsMaximized;
    end;

  bNormalizeNow:=False;

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
  //sLastSearchedText:='';
  StatusBar1.Panels[STATUSBAR_SERVER_NAME].Width:=0;
  StatusBar1.Panels[STATUSBAR_SERVER_NAME].Text:='';
  blvOrgRedrawNow:=False; // перерисовка окна результатов поиска отключена
  blvMsrRedrawNow:=False; // перерисовка окна результатов поиска отключена
  clInfo:=clRed;
  SessionLogEventCount:=0; // инициализация счётчика лога
  LogThis('Начало работы программы.',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  THackControl(ProgressBar1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
  ProgressBar1.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right - PanelRect.Left, PanelRect.Bottom - PanelRect.Top);
  THackControl(Image1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
  Image1.SetBounds(PanelRect.Left+1, PanelRect.Top+1, PanelRect.Right - PanelRect.Left+1, PanelRect.Bottom - PanelRect.Top+1);
  gsFileVersionInfo1.Filename:=Application.ExeName;

  bParamNoLogo:=False;

  if ParamCount>0 then
    for i:=1 to ParamCount do
      begin
        s:=UpperCase(ParamStr(i));
        if s='/NOLOGO' then
          begin
            bParamNoLogo:=True;
            LogThis('В командной строке указан параметр "/NOLOGO",'+
              ' отключающий вывод окна "О программе..." при запуске программы.','',
              lmtInfo);
          end;
        if s='/SHOWID' then
          begin
            bParamShowID:=True;
            LogThis('В командной строке указан параметр "/SHOWID",'+
              ' включающий отображение ID записей базы данных при работе программы.','',
              lmtInfo);
          end;
      end;
  if not (bParamNoLogo or Configuration.bNoLogo) then
    begin
      with TAboutForm.Create(Self) do
        try
          Button1.Visible:=False;
          Timer1.Enabled:=True;
          AlphaBlendValue:=0;
          Timer2.Enabled:=True;
          s:=gsFileVersionInfo1.FileVersion;
          i:=LastDelimiter('.',s);
          s:=copy(s,1,i-1);
          Label2.Caption:=Format('Версия %s билд %s',[s,gsFileVersionInfo1.GetBuildOnly]);
          Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
          LogThis('Окно "О программе..." показано.',LogGroupGUID,lmtInfo);
          ShowModal;
        finally
          Free;
          LogThis('Окно "О программе..." скрыто.',LogGroupGUID,lmtInfo);
        end;
    end;
  pnlID.Visible:=Configuration.bShowID;
  Update_Actions;

  GetMem(pwcGroupName, SizeOf(WideChar)*1000);
  try
    SendMessage(edbxSearchName.Handle,EM_SETCUEBANNER,WPARAM(0),LPARAM(StringToWideChar('Поле названия', pwcGroupName, 1000)));
  finally
    FreeMem(pwcGroupName);
  end;

  GetMem(pwcGroupName, SizeOf(WideChar)*1000);
  try
    SendMessage(edbxSearchAddress.Handle,EM_SETCUEBANNER,WPARAM(0),LPARAM(StringToWideChar('Поле местоположения', pwcGroupName, 1000)));
  finally
    FreeMem(pwcGroupName);
  end;

  GetMem(pwcGroupName, SizeOf(WideChar)*1000);
  try
    SendMessage(edbxSearchOther.Handle,EM_SETCUEBANNER,WPARAM(0),LPARAM(StringToWideChar('Поле названия и инфо', pwcGroupName, 1000)));
  finally
    FreeMem(pwcGroupName);
  end;

  if Configuration.bAutoLogon then
    begin
      if not Configuration.bLogged then
        Action_DB_Connection.Execute;
    end;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
var
  mr: TModalResult;
  q, s: string;
  i, j, k: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  bError: boolean;
  iLastSelected: integer;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{510E517C-F880-4315-A74B-C9F194019C31}';
  SetBusy(LogGroupGUID);
  bError:=False;
  ResultSet:=nil;
  LogThis('Попытка открытия окна конфигурации программы...',LogGroupGUID,lmtInfo);
  with TOptionsForm.Create(Owner) do
    try
      Screen.Cursor:=crHourGlass;
      // настройка компонентов интерфейса
      ImageList2.GetIcon(3,Icon);
      btnHelp.Enabled:=Application.HelpFile<>'';
      ScrollBox1.VertScrollBar.Position:=0;

      // выставление значений компонентов в соответствии с текущей конфигурацией

      chkbxStoreLastLogin.Checked:=Configuration.bStoreLastLogin;
      chkbxStoreLastPassword.Enabled:=chkbxStoreLastLogin.Checked;
      chkbxStoreLastPassword.Checked:=chkbxStoreLastLogin.Enabled and Configuration.bStoreLastPassword;
      chkbxAutoLogon.Enabled:=chkbxStoreLastLogin.Checked and chkbxStoreLastPassword.Checked;
      chkbxAutoLogon.Checked:=chkbxStoreLastLogin.Enabled and chkbxStoreLastPassword.Checked and Configuration.bAutoLogon;
      chkbxNoToolBar.Checked:=Configuration.bNoToolBar;
      chkbxNoStatusBar.Checked:=Configuration.bNoStatusBar;
      chkbxShowDataInOtherInfoPanel.Checked:=Configuration.bShowDataInOtherInfoPanel;
      chkbxShowMeasuresListAsRichEdit.Checked:=Configuration.bShowMeasuresListAsRichEdit;
      chkbxMarkSearchedStrings.Checked:=Configuration.bMarkSearchedStrings;
      chkbxPutTownAtTheEnd.Checked:=Configuration.bPutTownAtTheEnd;
      chkbxHideEditBoxToolTips.Checked:=Configuration.bHideEditBoxToolTips;
      chkbxShowSearchAddressOtherEditBox.Checked:=Configuration.bShowSearchAddressOtherEditBox;

      edbxLoginFormPositionX.Text:=IntToStr(Configuration.fpLoginForm.x);
      edbxLoginFormPositionY.Text:=IntToStr(Configuration.fpLoginForm.y);
      chkbxLoginFormPositionByCenter.Checked:=Configuration.fpLoginForm.bCenter;

      edbxOptionsFormPositionX.Text:=IntToStr(Configuration.fpOptionsForm.x);
      edbxOptionsFormPositionY.Text:=IntToStr(Configuration.fpOptionsForm.y);
      chkbxOptionsFormPositionByCenter.Checked:=Configuration.fpOptionsForm.bCenter;

      edbxUsersFormPositionX.Text:=IntToStr(Configuration.fpUsersForm.x);
      edbxUsersFormPositionY.Text:=IntToStr(Configuration.fpUsersForm.y);
      chkbxUsersFormPositionByCenter.Checked:=Configuration.fpUsersForm.bCenter;

      edbxSetPasswordFormPositionX.Text:=IntToStr(Configuration.fpSetPasswordForm.x);
      edbxSetPasswordFormPositionY.Text:=IntToStr(Configuration.fpSetPasswordForm.y);
      chkbxSetPasswordFormPositionByCenter.Checked:=Configuration.fpSetPasswordForm.bCenter;

      edbxStatisticFormPositionX.Text:=IntToStr(Configuration.fpStatisticForm.x);
      edbxStatisticFormPositionY.Text:=IntToStr(Configuration.fpStatisticForm.y);
      chkbxStatisticFormPositionByCenter.Checked:=Configuration.fpStatisticForm.bCenter;

      edbxMaintenanceFormPositionX.Text:=IntToStr(Configuration.fpMaintenanceForm.x);
      edbxMaintenanceFormPositionY.Text:=IntToStr(Configuration.fpMaintenanceForm.y);
      chkbxMaintenanceFormPositionByCenter.Checked:=Configuration.fpMaintenanceForm.bCenter;

      edbxClearingFormPositionX.Text:=IntToStr(Configuration.fpClearingForm.x);
      edbxClearingFormPositionY.Text:=IntToStr(Configuration.fpClearingForm.y);
      chkbxClearingFormPositionByCenter.Checked:=Configuration.fpClearingForm.bCenter;

      edbxViewPostListFormPositionX.Text:=IntToStr(Configuration.fpViewPostListForm.x);
      edbxViewPostListFormPositionY.Text:=IntToStr(Configuration.fpViewPostListForm.y);
      chkbxViewPostListFormPositionByCenter.Checked:=Configuration.fpViewPostListForm.bCenter;

      edbxCreateViewPostFormPositionX.Text:=IntToStr(Configuration.fpCreateViewPostForm.x);
      edbxCreateViewPostFormPositionY.Text:=IntToStr(Configuration.fpCreateViewPostForm.y);
      chkbxCreateViewPostFormPositionByCenter.Checked:=Configuration.fpCreateViewPostForm.bCenter;

      edbxPhonesFormPositionX.Text:=IntToStr(Configuration.fpPhonesForm.x);
      edbxPhonesFormPositionY.Text:=IntToStr(Configuration.fpPhonesForm.y);
      chkbxPhonesFormPositionByCenter.Checked:=Configuration.fpPhonesForm.bCenter;

      edbxAddEditPhoneFormPositionX.Text:=IntToStr(Configuration.fpAddEditPhoneForm.x);
      edbxAddEditPhoneFormPositionY.Text:=IntToStr(Configuration.fpAddEditPhoneForm.y);
      chkbxAddEditPhoneFormPositionByCenter.Checked:=Configuration.fpAddEditPhoneForm.bCenter;

      chkbxUseLog.Checked:=Configuration.bUseLog;
      chkbxCustomLogClientFile.Checked:=Configuration.sCustomLogClientFile<>'';
      edbxCustomLogClientFile.Text:=Configuration.sCustomLogClientFile;
      edbxCustomLogClientFile.Enabled:=chkbxCustomLogClientFile.Checked;
      btnChoiseCustomLogClientFile.Enabled:=chkbxCustomLogClientFile.Checked;
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
      lblAutoReplaceSorry.Visible:=not (Configuration.bLogged and CurrentUser.bDBEdition);
      // загрузка списка автозамены из базы данных
      for i:=0 to sgAutoReplaceList.RowCount-1 do
        sgAutoReplaceList.Rows[i].Clear;
      sgAutoReplaceList.Cells[1,0]:='Исходная строка';
      sgAutoReplaceList.Cells[2,0]:='Конечная строка';
      if Configuration.bLogged then
        begin
          // получение списка пользователей
          LogThis('Получение списка автозамены...',LogGroupGUID,lmtInfo);
          q:='SELECT arl_source, arl_destination FROM '+Configuration.sMySQLDatabase+'._autoreplace ORDER BY arl_id;';
          LogThis(q,LogGroupGUID,lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
              ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
              if ResultSet<>nil then
                begin
                  LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                  i:=mysql_num_rows(ResultSet);
                  if i>=0 then
                    begin
                      LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                      ProgressBar1.Max:=i;
                      ProgressBar1.Step:=1;
                      for j:=0 to i-1 do
                        begin
                          LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',LogGroupGUID,lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                          if ResultRow<>nil then
                            begin
                              LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',LogGroupGUID,lmtInfo);
                              sgAutoReplaceList.Cells[1,j+1]:=ResultRow[0];
                              sgAutoReplaceList.Cells[2,j+1]:=ResultRow[1];
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
                      s:='Возникла ошибка при получении колчиества срок результирующей выборки!';
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
              LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
              mysql_free_result(ResultSet);
            end;
          ProgressBar1.Position:=ProgressBar1.Min;
          if bError then
            begin
              LogThis(s,LogGroupGUID,lmtError);
	            Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end;
        end;

      // определение полноэкранного режима

      Configuration.bFullScreen:=MainForm.WindowState=wsMaximized;

      // установка позиции главного окна

      edbxMainFormPositionX.Enabled:=not (Configuration.bFullScreen or Configuration.fpMainForm.bCenter);
      if edbxMainFormPositionX.Enabled then
        edbxMainFormPositionX.Text:=IntToStr(Configuration.fpMainForm.x)
      else edbxMainFormPositionX.Clear;

      edbxMainFormPositionY.Enabled:=not (Configuration.bFullScreen or Configuration.fpMainForm.bCenter);
      if edbxMainFormPositionY.Enabled then
        edbxMainFormPositionY.Text:=IntToStr(Configuration.fpMainForm.y)
      else  edbxMainFormPositionY.Clear;

      chkbxMainFormPositionByCenter.Enabled:=not Configuration.bFullScreen;
      if chkbxMainFormPositionByCenter.Enabled then
        chkbxMainFormPositionByCenter.Checked:=Configuration.fpMainForm.bCenter
      else chkbxMainFormPositionByCenter.Checked:=False;

      // установка размеров главного окна

      edbxMainFormWidth.Enabled:=not Configuration.bFullScreen;
      if edbxMainFormWidth.Enabled then
        edbxMainFormWidth.Text:=IntToStr(Configuration.iMainFormWidth)
      else edbxMainFormWidth.Clear;

      edbxMainFormHeight.Enabled:=not Configuration.bFullScreen;
      if edbxMainFormHeight.Enabled then
        edbxMainFormHeight.Text:=IntToStr(Configuration.iMainFormHeight)
      else edbxMainFormHeight.Clear;

      chkbxStartupFullScreen.Checked:=Configuration.bFullScreen;

      // установка позиции диалогового окна LoginForm

      edbxLoginFormPositionX.Enabled:=not Configuration.fpLoginForm.bCenter;
      if edbxLoginFormPositionX.Enabled then
        edbxLoginFormPositionX.Text:=IntToStr(Configuration.fpLoginForm.x)
      else edbxLoginFormPositionX.Clear;

      edbxLoginFormPositionY.Enabled:=not Configuration.fpLoginForm.bCenter;
      if edbxLoginFormPositionY.Enabled then
        edbxLoginFormPositionY.Text:=IntToStr(Configuration.fpLoginForm.y)
      else edbxLoginFormPositionY.Clear;

      chkbxLoginFormPositionByCenter.Checked:=Configuration.fpLoginForm.bCenter;

      // установка позиции диалогового окна OptionsForm

      edbxOptionsFormPositionX.Enabled:=not Configuration.fpOptionsForm.bCenter;
      if edbxOptionsFormPositionX.Enabled then
        edbxOptionsFormPositionX.Text:=IntToStr(Configuration.fpOptionsForm.x)
      else edbxOptionsFormPositionX.Clear;

      edbxOptionsFormPositionY.Enabled:=not Configuration.fpOptionsForm.bCenter;
      if edbxOptionsFormPositionY.Enabled then
        edbxOptionsFormPositionY.Text:=IntToStr(Configuration.fpOptionsForm.y)
      else edbxOptionsFormPositionY.Clear;

      chkbxOptionsFormPositionByCenter.Checked:=Configuration.fpOptionsForm.bCenter;

      // установка позиции диалогового окна UsersForm

      edbxUsersFormPositionX.Enabled:=not Configuration.fpUsersForm.bCenter;
      if edbxUsersFormPositionX.Enabled then
        edbxUsersFormPositionX.Text:=IntToStr(Configuration.fpUsersForm.x)
      else edbxUsersFormPositionX.Clear;

      edbxUsersFormPositionY.Enabled:=not Configuration.fpUsersForm.bCenter;
      if edbxUsersFormPositionY.Enabled then
        edbxUsersFormPositionY.Text:=IntToStr(Configuration.fpUsersForm.y)
      else edbxUsersFormPositionY.Clear;

      chkbxUsersFormPositionByCenter.Checked:=Configuration.fpUsersForm.bCenter;

      // установка позиции диалогового окна SetPasswordForm

      edbxSetPasswordFormPositionX.Enabled:=not Configuration.fpSetPasswordForm.bCenter;
      if edbxSetPasswordFormPositionX.Enabled then
        edbxSetPasswordFormPositionX.Text:=IntToStr(Configuration.fpSetPasswordForm.x)
      else edbxSetPasswordFormPositionX.Clear;

      edbxSetPasswordFormPositionY.Enabled:=not Configuration.fpSetPasswordForm.bCenter;
      if edbxSetPasswordFormPositionY.Enabled then
        edbxSetPasswordFormPositionY.Text:=IntToStr(Configuration.fpSetPasswordForm.y)
      else edbxSetPasswordFormPositionY.Clear;

      chkbxSetPasswordFormPositionByCenter.Checked:=Configuration.fpSetPasswordForm.bCenter;

      // установка позиции диалогового окна StatisticForm

      edbxStatisticFormPositionX.Enabled:=not Configuration.fpStatisticForm.bCenter;
      if edbxStatisticFormPositionX.Enabled then
        edbxStatisticFormPositionX.Text:=IntToStr(Configuration.fpStatisticForm.x)
      else edbxStatisticFormPositionX.Clear;

      edbxStatisticFormPositionY.Enabled:=not Configuration.fpStatisticForm.bCenter;
      if edbxStatisticFormPositionY.Enabled then
        edbxStatisticFormPositionY.Text:=IntToStr(Configuration.fpStatisticForm.y)
      else edbxStatisticFormPositionY.Clear;

      chkbxStatisticFormPositionByCenter.Checked:=Configuration.fpStatisticForm.bCenter;

      // установка позиции диалогового окна MaintenanceForm

      edbxMaintenanceFormPositionX.Enabled:=not Configuration.fpMaintenanceForm.bCenter;
      if edbxMaintenanceFormPositionX.Enabled then
        edbxMaintenanceFormPositionX.Text:=IntToStr(Configuration.fpMaintenanceForm.x)
      else edbxMaintenanceFormPositionX.Clear;

      edbxMaintenanceFormPositionY.Enabled:=not Configuration.fpMaintenanceForm.bCenter;
      if edbxMaintenanceFormPositionY.Enabled then
        edbxMaintenanceFormPositionY.Text:=IntToStr(Configuration.fpMaintenanceForm.y)
      else edbxMaintenanceFormPositionY.Clear;

      chkbxMaintenanceFormPositionByCenter.Checked:=Configuration.fpMaintenanceForm.bCenter;

      // установка позиции диалогового окна ClearingForm

      edbxClearingFormPositionX.Enabled:=not Configuration.fpClearingForm.bCenter;
      if edbxClearingFormPositionX.Enabled then
        edbxClearingFormPositionX.Text:=IntToStr(Configuration.fpClearingForm.x)
      else edbxClearingFormPositionX.Clear;

      edbxClearingFormPositionY.Enabled:=not Configuration.fpClearingForm.bCenter;
      if edbxClearingFormPositionY.Enabled then
        edbxClearingFormPositionY.Text:=IntToStr(Configuration.fpClearingForm.y)
      else edbxClearingFormPositionY.Clear;

      chkbxClearingFormPositionByCenter.Checked:=Configuration.fpClearingForm.bCenter;

      // установка позиции диалогового окна ViewPostListForm

      edbxViewPostListFormPositionX.Enabled:=not Configuration.fpViewPostListForm.bCenter;
      if edbxViewPostListFormPositionX.Enabled then
        edbxViewPostListFormPositionX.Text:=IntToStr(Configuration.fpViewPostListForm.x)
      else edbxViewPostListFormPositionX.Clear;

      edbxViewPostListFormPositionY.Enabled:=not Configuration.fpViewPostListForm.bCenter;
      if edbxViewPostListFormPositionY.Enabled then
        edbxViewPostListFormPositionY.Text:=IntToStr(Configuration.fpViewPostListForm.y)
      else edbxViewPostListFormPositionY.Clear;

      chkbxViewPostListFormPositionByCenter.Checked:=Configuration.fpViewPostListForm.bCenter;

      // установка позиции диалогового окна CreateViewPostForm

      edbxCreateViewPostFormPositionX.Enabled:=not Configuration.fpCreateViewPostForm.bCenter;
      if edbxCreateViewPostFormPositionX.Enabled then
        edbxCreateViewPostFormPositionX.Text:=IntToStr(Configuration.fpCreateViewPostForm.x)
      else edbxCreateViewPostFormPositionX.Clear;

      edbxCreateViewPostFormPositionY.Enabled:=not Configuration.fpCreateViewPostForm.bCenter;
      if edbxCreateViewPostFormPositionY.Enabled then
        edbxCreateViewPostFormPositionY.Text:=IntToStr(Configuration.fpCreateViewPostForm.y)
      else edbxCreateViewPostFormPositionY.Clear;

      chkbxCreateViewPostFormPositionByCenter.Checked:=Configuration.fpCreateViewPostForm.bCenter;

      // установка позиции диалогового окна PhonesForm

      edbxPhonesFormPositionX.Enabled:=not Configuration.fpPhonesForm.bCenter;
      if edbxPhonesFormPositionX.Enabled then
        edbxPhonesFormPositionX.Text:=IntToStr(Configuration.fpPhonesForm.x)
      else edbxPhonesFormPositionX.Clear;

      edbxPhonesFormPositionY.Enabled:=not Configuration.fpPhonesForm.bCenter;
      if edbxPhonesFormPositionY.Enabled then
        edbxPhonesFormPositionY.Text:=IntToStr(Configuration.fpPhonesForm.y)
      else edbxPhonesFormPositionY.Clear;

      chkbxPhonesFormPositionByCenter.Checked:=Configuration.fpPhonesForm.bCenter;

      // установка позиции диалогового окна AddEditPhoneForm

      edbxAddEditPhoneFormPositionX.Enabled:=not Configuration.fpAddEditPhoneForm.bCenter;
      if edbxAddEditPhoneFormPositionX.Enabled then
        edbxAddEditPhoneFormPositionX.Text:=IntToStr(Configuration.fpAddEditPhoneForm.x)
      else edbxAddEditPhoneFormPositionX.Clear;

      edbxAddEditPhoneFormPositionY.Enabled:=not Configuration.fpAddEditPhoneForm.bCenter;
      if edbxAddEditPhoneFormPositionY.Enabled then
        edbxAddEditPhoneFormPositionY.Text:=IntToStr(Configuration.fpAddEditPhoneForm.y)
      else edbxAddEditPhoneFormPositionY.Clear;

      chkbxAddEditPhoneFormPositionByCenter.Checked:=Configuration.fpAddEditPhoneForm.bCenter;

      // установка позиции сплиттеров

      edbxOrgPanelHeight.Enabled:=not Configuration.bOrgPanelHalfHeight;
      if edbxOrgPanelHeight.Enabled then
        edbxOrgPanelHeight.Text:=IntToStr(Configuration.iOrgPanelHeight)
      else edbxOrgPanelHeight.Clear;

      chkbxOrgPanelHalfHeight.Checked:=Configuration.bOrgPanelHalfHeight;

      edbxDataPanelWidth.Enabled:=not Configuration.bDataPanelHalfWidth;
      if edbxDataPanelWidth.Enabled then
        edbxDataPanelWidth.Text:=IntToStr(Configuration.iDataPanelWidth)
      else edbxDataPanelWidth.Clear;

      chkbxDataPanelHalfWidth.Checked:=Configuration.bDataPanelHalfWidth;

      if Configuration.fpOptionsForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Top:=Configuration.fpOptionsForm.y;
          Left:=Configuration.fpOptionsForm.x;
        end;
      Screen.Cursor:=crDefault;
      if bError=False then
        ShowModal;
      { TODO : Загрузка текущей конфигурации и инициализация значений контролов }
    finally
      mr:=ModalResult;
      if mr=mrOk then
        begin
	        Screen.Cursor:=crHourGlass;

          if edbxMainFormPositionX.Enabled then
            Configuration.fpMainForm.x:=StrToIntDef(edbxMainFormPositionX.Text,0);

          if edbxMainFormPositionY.Enabled then
            Configuration.fpMainForm.y:=StrToIntDef(edbxMainFormPositionY.Text,0);

          Configuration.fpMainForm.bCenter:=chkbxMainFormPositionByCenter.Enabled and chkbxMainFormPositionByCenter.Checked;

          if edbxMainFormWidth.Enabled then
            Configuration.iMainFormWidth:=StrToIntDef(edbxMainFormWidth.Text,DEFAULT_MAINFORMWIDTH);

          if edbxMainFormHeight.Enabled then
            Configuration.iMainFormHeight:=StrToIntDef(edbxMainFormHeight.Text,DEFAULT_MAINFORMHEIGHT);

          Configuration.bFullScreen:=chkbxStartupFullScreen.Checked and chkbxStartupFullScreen.Enabled;

          Configuration.bDataPanelHalfWidth:=chkbxDataPanelHalfWidth.Checked;

          if edbxDataPanelWidth.Enabled then
            Configuration.iDataPanelWidth:=StrToIntDef(edbxDataPanelWidth.Text,DEFAULT_DATAPANELWIDTH);

          Configuration.bOrgPanelHalfHeight:=chkbxOrgPanelHalfHeight.Checked;

          if edbxOrgPanelHeight.Enabled then
            Configuration.iOrgPanelHeight:=StrToIntDef(edbxOrgPanelHeight.Text,DEFAULT_ORGPANELHEIGHT);

          bNormalizeNow:=True;

          MainForm.WindowState:=wsNormal;
          MainForm.Width:=Configuration.iMainFormWidth;
          MainForm.Height:=Configuration.iMainFormHeight;

          if Configuration.fpMainForm.bCenter then
            MainForm.Position:=poScreenCenter
          else
            begin
              MainForm.Position:=poDesigned;
              MainForm.Left:=Configuration.fpMainForm.x;
              MainForm.Top:=Configuration.fpMainForm.y;
            end;

          if Configuration.bFullScreen then
            begin
              MainForm.Position:=poDesigned;
              MainForm.WindowState:=wsMaximized;
            end;

          if Configuration.bDataPanelHalfWidth then
            pnlData.Width:=(pnlConnectedMode.Width-Splitter1.Width) div 2
          else pnlData.Width:=Configuration.iDataPanelWidth;

          if Configuration.bOrgPanelHalfHeight then
            pnlOrgLV.Height:=(pnlSearchResultsCreationModification.Height-pnlCreationModification.Height-Splitter2.Height) div 2
          else pnlOrgLV.Height:=Configuration.iOrgPanelHeight;

          bNormalizeNow:=False;

          if chkbxCustomHelpFile.Checked and FileExists(edbxCustomHelpFile.Text) then
            Configuration.sCustomHelpFile:=edbxCustomHelpFile.Text
          else Configuration.sCustomHelpFile:='';

          Configuration.bStoreLastLogin:=chkbxStoreLastLogin.Checked and chkbxStoreLastLogin.Enabled;
          Configuration.bStoreLastPassword:=chkbxStoreLastPassword.Checked and chkbxStoreLastPassword.Enabled;
          Configuration.bAutoLogon:=chkbxAutoLogon.Checked and chkbxAutoLogon.Enabled;
          Configuration.bShowDataInOtherInfoPanel:=chkbxShowDataInOtherInfoPanel.Checked and chkbxShowDataInOtherInfoPanel.Enabled;
          Configuration.bShowMeasuresListAsRichEdit:=chkbxShowMeasuresListAsRichEdit.Checked and chkbxShowMeasuresListAsRichEdit.Enabled;
          Configuration.bMarkSearchedStrings:=chkbxMarkSearchedStrings.Checked and chkbxMarkSearchedStrings.Enabled;
          Configuration.bPutTownAtTheEnd:=chkbxPutTownAtTheEnd.Checked and chkbxPutTownAtTheEnd.Enabled;
          Configuration.bHideEditBoxToolTips:=chkbxHideEditBoxToolTips.Checked and chkbxHideEditBoxToolTips.Enabled;
          Configuration.bShowSearchAddressOtherEditBox:=chkbxShowSearchAddressOtherEditBox.Checked and chkbxShowSearchAddressOtherEditBox.Enabled;

          Configuration.bNoToolBar:=chkbxNoToolBar.Checked and chkbxNoToolBar.Enabled;
          miToolbar.Checked:=not Configuration.bNoToolBar;
          ActionToolBar1.Visible:=miToolbar.Checked;

          Configuration.bNoStatusBar:=chkbxNoStatusBar.Checked and chkbxNoStatusBar.Enabled;
          miStatusbar.Checked:=not Configuration.bNoStatusBar;
          StatusBar1.Visible:=miStatusbar.Checked;

          UpdateSearchBar;

          if pnlConnectedMode.Visible then
            begin
              reOrgOtherInfo.Visible:=False;
              reOrgOtherInfo.Visible:=True;
              reMsrOtherInfo.Visible:=False;
              reMsrOtherInfo.Visible:=True;
              TryToSet_edbxSearchName_Focused;
            end;

          if Configuration.bShowMeasuresListAsRichEdit and (not CurrentUser.bDBEdition) then
            begin
              lvMsr.Visible:=False;
              reMsr.Visible:=True;
            end
          else
            begin
              reMsr.Visible:=False;
              lvMsr.Visible:=True;
            end;

          if (MainForm.PageControl1.ActivePage=tsOrg) and pnlConnectedMode.Visible then
            begin
              if lvOrg.Selected<>nil then
                iLastSelected:=lvOrg.Selected.Index
              else
                if lvOrg.Items.Count>0 then
                  iLastSelected:=0
                else iLastSelected:=-1;
              lvOrg.Selected:=nil;
              if lvOrg.Items.Count>0 then
                lvOrg.ItemIndex:=iLastSelected
              else lvOrgSelectItem(Sender,nil,True);
              if lvOrg.Selected<>nil then
                TryToSet_lvOrg_Focused
              else TryToSet_edbxSearchName_Focused;
            end;

          if (MainForm.PageControl1.ActivePage=tsMsr) and pnlConnectedMode.Visible  then
            begin
              if lvMsr.Selected<>nil then
                iLastSelected:=lvMsr.Selected.Index
              else
                if lvMsr.Items.Count>0 then
                  iLastSelected:=0
                else iLastSelected:=-1;
              lvMsr.Selected:=nil;
              if lvMsr.Items.Count>0 then
                lvMsr.ItemIndex:=iLastSelected
              else lvMsrSelectItem(Sender,nil,True);
              if Configuration.bShowMeasuresListAsRichEdit then
                begin
                  if (Trim(reMsr.Text)<>'') then
                    TryToSet_reMsr_Focused
                  else TryToSet_edbxSearchName_Focused;
                end
              else
                begin
                  if (lvMsr.Selected<>nil) then
                    TryToSet_lvMsr_Focused
                  else TryToSet_edbxSearchName_Focused;
                end;
            end;

          Configuration.fpLoginForm.x:=StrToIntDef(edbxLoginFormPositionX.Text,0);
          Configuration.fpLoginForm.y:=StrToIntDef(edbxLoginFormPositionY.Text,0);
          Configuration.fpLoginForm.bCenter:=chkbxLoginFormPositionByCenter.Checked;

          Configuration.fpOptionsForm.x:=StrToIntDef(edbxOptionsFormPositionX.Text,0);
          Configuration.fpOptionsForm.y:=StrToIntDef(edbxOptionsFormPositionY.Text,0);
          Configuration.fpOptionsForm.bCenter:=chkbxOptionsFormPositionByCenter.Checked;

          Configuration.fpUsersForm.x:=StrToIntDef(edbxUsersFormPositionX.Text,0);
          Configuration.fpUsersForm.y:=StrToIntDef(edbxUsersFormPositionY.Text,0);
          Configuration.fpUsersForm.bCenter:=chkbxUsersFormPositionByCenter.Checked;

          Configuration.fpSetPasswordForm.x:=StrToIntDef(edbxSetPasswordFormPositionX.Text,0);
          Configuration.fpSetPasswordForm.y:=StrToIntDef(edbxSetPasswordFormPositionY.Text,0);
          Configuration.fpSetPasswordForm.bCenter:=chkbxSetPasswordFormPositionByCenter.Checked;

          Configuration.fpStatisticForm.x:=StrToIntDef(edbxStatisticFormPositionX.Text,0);
          Configuration.fpStatisticForm.y:=StrToIntDef(edbxStatisticFormPositionY.Text,0);
          Configuration.fpStatisticForm.bCenter:=chkbxStatisticFormPositionByCenter.Checked;

          Configuration.fpMaintenanceForm.x:=StrToIntDef(edbxMaintenanceFormPositionX.Text,0);
          Configuration.fpMaintenanceForm.y:=StrToIntDef(edbxMaintenanceFormPositionY.Text,0);
          Configuration.fpMaintenanceForm.bCenter:=chkbxMaintenanceFormPositionByCenter.Checked;

          Configuration.fpClearingForm.x:=StrToIntDef(edbxClearingFormPositionX.Text,0);
          Configuration.fpClearingForm.y:=StrToIntDef(edbxClearingFormPositionY.Text,0);
          Configuration.fpClearingForm.bCenter:=chkbxClearingFormPositionByCenter.Checked;

          Configuration.fpViewPostListForm.x:=StrToIntDef(edbxViewPostListFormPositionX.Text,0);
          Configuration.fpViewPostListForm.y:=StrToIntDef(edbxViewPostListFormPositionY.Text,0);
          Configuration.fpViewPostListForm.bCenter:=chkbxViewPostListFormPositionByCenter.Checked;

          Configuration.fpCreateViewPostForm.x:=StrToIntDef(edbxCreateViewPostFormPositionX.Text,0);
          Configuration.fpCreateViewPostForm.y:=StrToIntDef(edbxCreateViewPostFormPositionY.Text,0);
          Configuration.fpCreateViewPostForm.bCenter:=chkbxCreateViewPostFormPositionByCenter.Checked;

          Configuration.fpPhonesForm.x:=StrToIntDef(edbxPhonesFormPositionX.Text,0);
          Configuration.fpPhonesForm.y:=StrToIntDef(edbxPhonesFormPositionY.Text,0);
          Configuration.fpPhonesForm.bCenter:=chkbxPhonesFormPositionByCenter.Checked;

          Configuration.fpAddEditPhoneForm.x:=StrToIntDef(edbxAddEditPhoneFormPositionX.Text,0);
          Configuration.fpAddEditPhoneForm.y:=StrToIntDef(edbxAddEditPhoneFormPositionY.Text,0);
          Configuration.fpAddEditPhoneForm.bCenter:=chkbxAddEditPhoneFormPositionByCenter.Checked;

          if edbxMySQLHost.Text<>'' then
            Configuration.sMySQLHost:=edbxMySQLHost.Text;
          if edbxMySQLPort.Text<>'' then
            Configuration.iMySQLPort:=StrToIntDef(edbxMySQLPort.Text,3306);
          if edbxMySQLTimeout.Text<>'' then
            Configuration.iMySQLTimeout:=StrToIntDef(edbxMySQLTimeout.Text,30);
          Configuration.bMySQLCompress:=chkbxMySQLCompress.Checked;
          if edbxMySQLDatabase.Text<>'' then
            Configuration.sMySQLDatabase:=edbxMySQLDatabase.Text;
          Configuration.sMySQLDatabase:=edbxMySQLDatabase.Text;
          Configuration.sMySQLUser:=edbxMySQLUser.Text;
          Configuration.sMySQLPassword:=edbxMySQLPassword.Text;
          Configuration.bNoLogo:=chkbxNoLogo.Checked and chkbxNoLogo.Enabled;
          Configuration.bShowID:=chkbxShowID.Checked and chkbxShowID.Enabled;
          pnlID.Visible:=Configuration.bShowID;
          Configuration.bUseLog:=chkbxUseLog.Checked and chkbxUseLog.Enabled;
          if chkbxCustomLogClientFile.Checked and FileExists(edbxCustomLogClientFile.Text) then
            Configuration.sCustomLogClientFile:=edbxCustomLogClientFile.Text
          else
            Configuration.sCustomLogClientFile:='';
          if sgAutoReplaceList.Visible then
            begin
              LogThis('Попытка очистки списка автозамены...',LogGroupGUID,lmtInfo);
              q:='DELETE FROM '+Configuration.sMySQLDatabase+'._autoreplace;';
              LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('Очистка списка автозамены произведена успешно.',LogGroupGUID,lmtInfo);
                  // запись нового списка автозамены в базу данных
                  k:=0;
                  ProgressBar1.Position:=ProgressBar1.Min;
                  ProgressBar1.Max:=i;
                  ProgressBar1.Step:=1;
                  for j:=1 to sgAutoReplaceList.RowCount-1 do
                    begin
                      if (sgAutoReplaceList.Cells[1,j]<>'') and (sgAutoReplaceList.Cells[2,j]<>'') then
                        begin
                          k:=k+1;
                          q:='INSERT INTO '+Configuration.sMySQLDatabase+'._autoreplace VALUES ('+IntToStr(k)+', "'+sgAutoReplaceList.Cells[1,j]+'", "'+sgAutoReplaceList.Cells[2,j]+'")';
                          LogThis(q,LogGroupGUID,lmtSQL);
                          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                          if i=0 then
                            begin
                              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                              i:=mysql_affected_rows(MySQLConnectionHandler);
                              if i=1 then
                                begin
                                  LogThis('Количество строк выборки соответствует требуемому.',LogGroupGUID,lmtInfo);
                                  LogThis('Элемент списка автозамены номер '+IntToStr(k)+' успешно сохранён в таблице БД.',LogGroupGUID,lmtInfo);
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
                        end;
                      ProgressBar1.StepIt;
                    end;
                end
              else
                begin
                  s:='Возникла ошибка при очистке списка автозамены!';
                  bError:=True;
                end;
              if bError then
                begin
                  LogThis(s,LogGroupGUID,lmtError);
	                Screen.Cursor:=crDefault;
                  MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                end;
            end;
          SaveConfigIni;
          ProgressBar1.Position:=ProgressBar1.Min;
        end;
      Free;
    end;
  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.lvMsrColumnClick(Sender: TObject; Column: TListColumn);
var
	i: integer;
  lvOrgSelectedItem: TListItem;
begin
	Configuration.iMsrSortColumn:=0;
	for i:=0 to (lvMsr.Columns.Count-1) do
		begin
			if (Column.Caption=lvMsr.Columns[i].Caption)
				then
					begin
            if CurrentUser.bDBEdition then
						  lvMsr.Columns[i].ImageIndex:=3
            else lvMsr.Columns[i].ImageIndex:=-1;
						Configuration.iMsrSortColumn:=i;
					end
				else lvMsr.Columns[i].ImageIndex:=-1;
		end;
  lvOrgSelectedItem:=lvOrg.Selected;
  lvOrg.Selected:=nil;
  lvOrg.Selected:=lvOrgSelectedItem;
end;

procedure TMainForm.lvMsrCustomDrawItem(Sender: TCustomListView;
  Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
var
  D: TDate;
  T: TTime;
  DT, DT2: TDateTime;
  Day, Month, Year: word;
begin
  if Item<>nil then
    begin
      if (Item.SubItems[1]>'') and (Length(Item.SubItems[1])=16) then
        begin
          D:=EncodeDate(
          StrToInt(Copy(Item.SubItems[1],7,4)),
          StrToInt(Copy(Item.SubItems[1],4,2)),
          StrToInt(Copy(Item.SubItems[1],1,2)));
          if (Item.SubItems[3]>'') and (Length(Item.SubItems[3])=8) then
            T:=StrToTime(Item.SubItems[3])
          else T:=StrToTime(Copy(Item.SubItems[1],12,5)+':00');
          DT:=D+T;
          DecodeDate(Now,Year,Month,Day);
          DT2:=EncodeDate(Year,Month,Day);
          if DT<DT2 then
            lvMsr.Canvas.Font.Color:=clGrayText
          else lvMsr.Canvas.Font.Color:=clWindowText;
        end;
    end;
end;

procedure TMainForm.lvMsrEnter(Sender: TObject);
var
  Item: TListItem;
begin
  if lvMsr.Selected<>nil then
    begin
      Item:=lvMsr.Selected;
      lvMsr.Selected:=nil;
      lvMsr.Selected:=Item;
    end
  else
    begin
      pnlEdit.Visible:=False;
      PageControl1.ActivePage:=tsClear;
    end;
  //pnlEdit.Visible:=(not (PageControl1.ActivePage=tsClear))and CurrentUser.bDBEdition;
end;

procedure TMainForm.lvMsrKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{08C7E5BF-E7D9-403B-B22D-57F0DEFA85BC}';
  if Key=VK_RETURN then
    begin
      if (PageControl1.ActivePage=tsMsr) and pnlConnectedMode.Visible and
      ((stPhonesMark.Visible and (stPhonesMark.Font.Color=clRed) and (stPhonesMark.Caption='ЕСТЬ ТЕЛЕФОНЫ')) or CurrentUser.bDBEdition) then
      begin
        SetBusy(LogGroupGUID);
        LogThis('Попытка открытия окна списка телефонов мероприятия...',LogGroupGUID,lmtInfo);
        with TPhonesForm.Create(Owner) do
          try
            ImageList2.GetIcon(19,Icon);
            Caption:='OA4 - Список телефонов мероприятия';
            Hint:='Окно просмотра списка телефонов мероприятия';
            pnlModification.Visible:=lvPhones.Items.Count>0;
            pnlID.Visible:=Configuration.bShowID and (lvPhones.Items.Count>0);
            btnHelp.Enabled:=Application.HelpFile<>'';
            btnCreate.Visible:=CurrentUser.bDBEdition;
            btnEdit.Visible:=CurrentUser.bDBEdition;
            btnErase.Visible:=CurrentUser.bDBEdition;
            lvPhones.Column[3].Width:=70;
            lvPhones.Column[1].Width:=160;
            lvPhones.Column[0].Width:=150;
            lvPhones.Column[2].Width:=-2;
            if Configuration.fpPhonesForm.bCenter then
              Position:=poScreenCenter
            else
              begin
                Position:=poDesigned;
                Top:=Configuration.fpPhonesForm.y;
                Left:=Configuration.fpPhonesForm.x;
              end;
            ShowModal;
          finally
            Configuration.fpPhonesForm.y:=Top;
            Configuration.fpPhonesForm.x:=Left;
            Free;
          end;
        Update_PhonesMark;
        SetReady(LogGroupGUID);
      end;
    end;
end;

procedure TMainForm.lvOrgColumnClick(Sender: TObject; Column: TListColumn);
var
	i, iOrgID: integer;
  tp: TPoint;
begin
	Configuration.iOrgSortColumn:=0;
  iOrgID:=-1;
	for i:=0 to (lvOrg.Columns.Count-1) do
		begin
			if (Column.Caption=lvOrg.Columns[i].Caption)
				then
					begin
            if CurrentUser.bDBEdition then
						  lvOrg.Columns[i].ImageIndex:=3
            else lvOrg.Columns[i].ImageIndex:=-1;
						Configuration.iOrgSortColumn:=i;
					end
				else lvOrg.Columns[i].ImageIndex:=-1;
		end;
  if lvOrg.Items.Count>0 then
    begin
      if lvOrg.Selected<>nil then // определяем ID организации
        iOrgID:=StrToIntDef(lvOrg.Selected.SubItems[2],-1); // сохранение значения ID выделенной организации

      btbtnSearchClick(nil);

      lvOrg.Items.BeginUpdate;
      for i:=0 to lvOrg.Items.Count-1 do
        if lvOrg.Items[i]<>nil then
          begin
            if lvOrg.Items[i].SubItems[2]=IntToStr(iOrgID) then
              begin
                lvOrg.ItemIndex:=i;
                lvOrg.ItemFocused:=lvOrg.Items.Item[i];
                tp:=lvOrg.ItemFocused.GetPosition;
                lvOrg.Scroll(tp.X,tp.Y-23);
                lvOrg.ItemFocused.MakeVisible(False);
                TryToSet_lvOrg_Focused;
              end;
          end;
      lvOrg.Items.EndUpdate;
    end;
end;

procedure TMainForm.lvOrgCustomDrawSubItem(Sender: TCustomListView;
  Item: TListItem; SubItem: Integer; State: TCustomDrawState;
  var DefaultDraw: Boolean);
begin
  if Item<>nil then
    begin
      if SubItem=2 then
        begin
          if (Item.SubItems[1]='0') or (Item.SubItems[1]='-') then
            begin
              lvOrg.Canvas.Font.Style:=[];
              lvOrg.Canvas.Font.Color:=clBlack;
            end
          else
            begin
              lvOrg.Canvas.Font.Style:=[fsBold];
              lvOrg.Canvas.Font.Color:=clRed;
            end;
        end
      else
        begin
          lvOrg.Canvas.Font.Style:=[];
          lvOrg.Canvas.Font.Color:=clBlack;
        end;
    end;
end;

procedure TMainForm.lvOrgEnter(Sender: TObject);
var
  Item: TListItem;
begin
  if lvOrg.Selected<>nil then
    begin
      Item:=lvOrg.Selected;
      lvOrg.Selected:=nil;
      lvOrg.Selected:=Item;
    end
  else
    begin
      pnlEdit.Visible:=False;
      PageControl1.ActivePage:=tsClear;
    end;
  //pnlEdit.Visible:=(not (PageControl1.ActivePage=tsClear))and CurrentUser.bDBEdition;
end;

procedure TMainForm.lvOrgKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{EA7382DE-C928-4B75-81C4-9F91109C585D}';
  if Key=VK_RETURN then
    begin
      if (PageControl1.ActivePage=tsOrg) and pnlConnectedMode.Visible and
      ((stPhonesMark.Visible and (stPhonesMark.Font.Color=clRed) and (stPhonesMark.Caption='ЕСТЬ ТЕЛЕФОНЫ')) or CurrentUser.bDBEdition) then
        begin
          SetBusy(LogGroupGUID);
          LogThis('Попытка открытия окна списка телефонов организации...',LogGroupGUID,lmtInfo);
          with TPhonesForm.Create(Owner) do
            try
              ImageList2.GetIcon(19,Icon);
              Caption:='OA4 - Список телефонов организации';
              Hint:='Окно просмотра списка телефонов организации';
              pnlModification.Visible:=lvPhones.Items.Count>0;
              pnlID.Visible:=Configuration.bShowID and (lvPhones.Items.Count>0);
              btnHelp.Enabled:=Application.HelpFile<>'';
              btnCreate.Visible:=CurrentUser.bDBEdition;
              btnEdit.Visible:=CurrentUser.bDBEdition;
              btnErase.Visible:=CurrentUser.bDBEdition;
              lvPhones.Column[3].Width:=70;
              lvPhones.Column[1].Width:=160;
              lvPhones.Column[0].Width:=150;
              lvPhones.Column[2].Width:=-2;
              if Configuration.fpPhonesForm.bCenter then
                Position:=poScreenCenter
              else
                begin
                  Position:=poDesigned;
                  Top:=Configuration.fpPhonesForm.y;
                  Left:=Configuration.fpPhonesForm.x;
                end;
              ShowModal;
            finally
              Configuration.fpPhonesForm.y:=Top;
              Configuration.fpPhonesForm.x:=Left;
              Free;
            end;
          Update_PhonesMark;
          SetReady(LogGroupGUID);
        end;
    end;
	if Key=VK_RIGHT then
    SendMessage(lvOrg.Handle, WM_HSCROLL, SB_PAGERIGHT, 0);
	if Key=VK_LEFT then
    SendMessage(lvOrg.Handle, WM_HSCROLL, SB_PAGELEFT, 0);
end;

procedure TMainForm.Action_HelpContentExecute(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{D21D3CE2-E1D5-42E9-ABAC-5A8B9B9F2A71}';
  SetBusy(LogGroupGUID);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    begin
      LogThis('Открыто окно оглавления справки.',LogGroupGUID,lmtInfo);
      Application.HelpContext(0);
    end
  else
    begin
      LogThis('Файл правки к программе не найден!',LogGroupGUID,lmtError);
      MessageBox(Handle,PChar('Извините, справочный файл к данной программе не найден.'),PChar('Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_PostMessageExecute(Sender: TObject);
var
  mr: TModalResult;
  s, q: string;
  bError: boolean;
  i, j, iLastID: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  TSL: TStringList;
  RTFStream: TMemoryStream;
	pacCaption, pacText: PAnsiChar;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{53284435-BF5F-42EF-9148-348D2797D79B}';
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  bError:=False;
  ResultSet:=nil;
  pacCaption:=nil;
  pacText:=nil;
  iLastID:=-1;
  LogThis('Попытка открытия окна отправки сообщения...',LogGroupGUID,lmtInfo);
  with TCreateViewPostForm.Create(Owner) do
    try
      ImageList2.GetIcon(18,Icon);
      Caption:='OA4 - Новое сообщение';
      Hint:='Окно отправки сообщения';
      pnlID.Visible:=False;
      lblTo.Visible:=True;
      cmbbxTo.Visible:=True;
      edbxCaption.ReadOnly:=False;
      meMessage.ReadOnly:=False;
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
      LogThis('Получение списка пользователей...',LogGroupGUID,lmtInfo);
      q:='SELECT DISTINCT usr_fullname FROM '+Configuration.sMySQLDatabase+'._usr WHERE usr_erased="0" ORDER BY usr_fullname;';
      LogThis(q,LogGroupGUID,lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
              i:=mysql_num_rows(ResultSet);
              if i>0 then
                begin
                  LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                  ProgressBar1.Max:=i;
                  ProgressBar1.Step:=1;
                  for j:=0 to i-1 do
                    begin
                      LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',LogGroupGUID,lmtInfo);
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',LogGroupGUID,lmtInfo);
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
          LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
          mysql_free_result(ResultSet);
        end;
      ProgressBar1.Position:=ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          LogThis(s,LogGroupGUID,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else LogThis('Список пользователей получен успешно...',LogGroupGUID,lmtInfo);
      if Configuration.fpCreateViewPostForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Top:=Configuration.fpCreateViewPostForm.y;
          Left:=Configuration.fpCreateViewPostForm.x;
        end;
      if bError=False then
        begin
          cmbbxTo.Items.Add('[ группа администраторов ]');
          cmbbxTo.Items.Add('[ группа операторов ]');
          cmbbxTo.Items.Add('[ группа пользователей ]');
          ShowModal;
        end;
    finally
      mr:=ModalResult;
      Configuration.fpCreateViewPostForm.y:=Top;
      Configuration.fpCreateViewPostForm.x:=Left;
      if mr=mrOk then
        begin
          // определение id пользователя
          TSL:=TStringList.Create;
          try
            Screen.Cursor:=crHourGlass;
            if ((cmbbxTo.Text='[ группа администраторов ]') or (cmbbxTo.Text='[ группа операторов ]') or (cmbbxTo.Text='[ группа пользователей ]')) then
              begin
                if cmbbxTo.Text='[ группа администраторов ]' then
                  begin
                    LogThis('Получение списка идентификаторов администраторов...',LogGroupGUID,lmtInfo);
                    q:='SELECT DISTINCT usr_id FROM '+Configuration.sMySQLDatabase+'._usr WHERE usr_erased="0" and usr_is_admin="1" ORDER BY usr_id;';
                  end;
                if cmbbxTo.Text='[ группа операторов ]' then
                  begin
                    LogThis('Получение списка идентификаторов операторов...',LogGroupGUID,lmtInfo);
                    q:='SELECT DISTINCT usr_id FROM '+Configuration.sMySQLDatabase+'._usr WHERE usr_erased="0" and usr_can_edit_db="1" ORDER BY usr_id;';
                  end;
                if cmbbxTo.Text='[ группа пользователей ]' then
                  begin
                    LogThis('Получение списка идентификаторов пользователей...',LogGroupGUID,lmtInfo);
                    q:='SELECT DISTINCT usr_id FROM '+Configuration.sMySQLDatabase+'._usr WHERE usr_erased="0" and usr_is_admin="0" ORDER BY usr_id;';
                  end;
              end
            else
              begin
                LogThis('Получение идентификатора указанного пользователя...',LogGroupGUID,lmtInfo);
                q:='SELECT usr_id FROM '+Configuration.sMySQLDatabase+'._usr WHERE usr_fullname="'+cmbbxTo.Text+'" ORDER BY usr_id;';
              end;
            LogThis(q,LogGroupGUID,lmtSQL);
            i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
            if i=0 then
              begin
                LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                if ResultSet<>nil then
                  begin
                    LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                    i:=mysql_num_rows(ResultSet);
                    if i>0 then
                      begin
                        LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                        ProgressBar1.Max:=i;
                        ProgressBar1.Step:=1;
                        for j:=0 to i-1 do
                          begin
                            LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',LogGroupGUID,lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              begin
                                LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',LogGroupGUID,lmtInfo);
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
                LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
                mysql_free_result(ResultSet);
              end;
            ProgressBar1.Position:=ProgressBar1.Min;
	          Screen.Cursor:=crDefault;
            if bError then
              begin
                LogThis(s,LogGroupGUID,lmtError);
                MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              end
            else LogThis('Список идентификаторов получен успешно...',LogGroupGUID,lmtInfo);
            // если в списке имеется один и более элемент, то в цикле выполняем запросы
            if not bError then
              begin
	              RTFStream:=TMemoryStream.Create;
	              try
                  // преобразование темы
                  pacCaption:=GetMemory(Length(edbxCaption.Text)*2+1);
                  mysql_escape_string(pacCaption,PAnsiChar(edbxCaption.Text),Length(edbxCaption.Text));
                  // преобразование сообщения
                  meMessage.Lines.SaveToStream(RTFStream);
                  RTFStream.Seek(0,soFromBeginning);
                  pacText:=GetMemory(RTFStream.Size*2+1);
                  mysql_escape_string(pacText,RTFStream.Memory,RTFStream.Size);
                  ProgressBar1.Max:=TSL.Count*2;
                  ProgressBar1.Step:=1;
                  Screen.Cursor:=crHourGlass;
                  for j:=0 to TSL.Count-1 do
                    begin
                      if not bError then
                        begin
                          // добавление сообщения
                          LogThis('Добавление нового сообщения...',LogGroupGUID,lmtInfo);
                          q:= 'INSERT INTO '+Configuration.sMySQLDatabase+'._msg (msg_id, msg_erased, msg_processed, msg_for_user_id, '+
                              'msg_caption, msg_text, msg_created_at, msg_created_by_user_id) VALUES '+
                              '(NULL, "0", "0", '+TSL.Strings[j]+', "'+pacCaption+'", "'+pacText+'", Now(), '+CurrentUser.sID+');';
                          LogThis(q,LogGroupGUID,lmtSQL);
                          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                          if i=0 then
                            begin
                              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                              iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной записи
                              i:=mysql_affected_rows(MySQLConnectionHandler);
                              if i=1 then
                                begin
                                  LogThis('Количество строк выборки соответствует требуемому.',LogGroupGUID,lmtInfo);
                                  LogThis('Сообщение успешно отправлено получателю.',LogGroupGUID,lmtInfo);
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
                          MainForm.ProgressBar1.StepIt;
                          Application.ProcessMessages;
                          // запись статистики в БД
                          if not bError then
                            begin
                              MainForm.LogThis('Внесение записи в таблицу событий.',LogGroupGUID,lmtInfo);
                              q:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"INS","msg",'+IntToStr(iLastID)+','+MainForm.CurrentUser.sID+','+#39+q+#39+');';
                              MainForm.LogThis(q,LogGroupGUID,lmtSQL);
                              i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
                              if i=0 then
                                begin
                                  MainForm.LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                                  MainForm.LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                                  if (i=1) then
                                    MainForm.LogThis('Запись в таблицу событий внесена успешно.',LogGroupGUID,lmtInfo)
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
                          MainForm.ProgressBar1.StepIt;
                          Application.ProcessMessages;
                          if bError then
                            begin
                              Screen.Cursor:=crDefault;
                              LogThis(s,LogGroupGUID,lmtError);
                              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                            end;
                        end;
                    end;
                  ProgressBar1.Position:=ProgressBar1.Min;
                  Screen.Cursor:=crDefault;
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
  Timer_MessageStatusTimer(Sender);
  SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_ViewMessagesExecute(Sender: TObject);
var
  Node: TListItem;
  s, q: string;
  bError: boolean;
  i, j: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{35EB5A59-E7B8-472B-B1AE-104CB6DA16C6}';
  SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
  bError:=False;
  ResultSet:=nil;
  LogThis('Попытка открытия окна списка сообщений...',LogGroupGUID,lmtInfo);
  with TViewPostListForm.Create(Owner) do
    try
      ImageList2.GetIcon(17,Icon);
      Caption:='OA4 - Список сообщений';
      Hint:='Окно просмотра списка сообщений';
      pnlID.Visible:=Configuration.bShowID;
      btnHelp.Enabled:=Application.HelpFile<>'';
      lvMessages.Clear;
      // получение количества сообщений и заполнения списка
      LogThis('Получение списка сообщений...',LogGroupGUID,lmtInfo);
      q:='SELECT msg_created_at, usr_fullname, msg_caption, msg_id, msg_processed FROM '+Configuration.sMySQLDatabase+'._msg LEFT JOIN '+Configuration.sMySQLDatabase+'._usr ON usr_id=msg_created_by_user_id  WHERE msg_for_user_id="'+CurrentUser.sID+'" AND msg_erased="0" ORDER BY msg_created_at;';
      LogThis(q,LogGroupGUID,lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
              i:=mysql_num_rows(ResultSet);
              if i>=0 then
                begin
                  LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                  ProgressBar1.Max:=i;
                  ProgressBar1.Step:=1;
                  for j:=0 to i-1 do
                    begin
                      LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',LogGroupGUID,lmtInfo);
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',LogGroupGUID,lmtInfo);
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
          LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
          mysql_free_result(ResultSet);
        end;
      ProgressBar1.Position:=ProgressBar1.Min;
	    Screen.Cursor:=crDefault;
      if bError then
        begin
          LogThis(s,LogGroupGUID,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else LogThis('Список сообщений получен успешно...',LogGroupGUID,lmtInfo);
      if Configuration.fpViewPostListForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Top:=Configuration.fpViewPostListForm.y;
          Left:=Configuration.fpViewPostListForm.x;
        end;
      if bError=False then
        ShowModal;
    finally
      Configuration.fpViewPostListForm.y:=Top;
      Configuration.fpViewPostListForm.x:=Left;
      Free;
    end;
  Timer_MessageStatusTimer(Sender);
  SetReady(LogGroupGUID);
end;

procedure TMainForm.cmbbxOrgStreetExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOrgStreet.Text:=ValidateString(cmbbxOrgStreet.Text);
end;

procedure TMainForm.cmbbxOrgTownExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOrgTown.Text:=ValidateString(cmbbxOrgTown.Text);
end;

procedure TMainForm.cmbbxOrgWorkTimeExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOrgWorkTime.Text:=ValidateString(cmbbxOrgWorkTime.Text);
end;

procedure TMainForm.cmbbxMsrTypeExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxMsrType.Text:=ValidateString(cmbbxMsrType.Text);
end;

procedure TMainForm.cmbbxMsrAuthorExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxMsrAuthor.Text:=ValidateString(cmbbxMsrAuthor.Text);
end;

procedure TMainForm.cmbbxMsrProducerExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxMsrProducer.Text:=ValidateString(cmbbxMsrProducer.Text);
end;

procedure TMainForm.cmbbxMsrPerformerExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxMsrPerformer.Text:=ValidateString(cmbbxMsrPerformer.Text);
end;

procedure TMainForm.cmbbxMsrOrganizerExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxMsrOrganizer.Text:=ValidateString(cmbbxMsrOrganizer.Text);
end;

procedure TMainForm.Action_RichEditRedoExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    if ActiveControl=reOrgOtherInfo then
      reOrgOtherInfo.Perform(EM_UNDO,0,0);
  if PageControl1.ActivePage=tsMsr then
    if ActiveControl=reMsrOtherInfo then
      reMsrOtherInfo.Perform(EM_UNDO,0,0);
end;

procedure TMainForm.Action_RichEditRightAlignExecute(Sender: TObject);
begin
  if PageControl1.ActivePage=tsOrg then
    begin
      reOrgOtherInfo.Paragraph.Alignment:=taRightJustify;
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      reMsrOtherInfo.Paragraph.Alignment:=taRightJustify;
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
  if PageControl1.ActivePage=tsOrg then
    begin
      Action_RichEditBold.Checked:=fsBold in reOrgOtherInfo.SelAttributes.Style;
      Action_RichEditItalic.Checked:=fsItalic in reOrgOtherInfo.SelAttributes.Style;
      Action_RichEditUnderline.Checked:=fsUnderline in reOrgOtherInfo.SelAttributes.Style;
      Action_RichEditLeftAlign.Checked:=reOrgOtherInfo.Paragraph.Alignment=taLeftJustify;
      Action_RichEditCenterAlign.Checked:=reOrgOtherInfo.Paragraph.Alignment=taCenter;
      Action_RichEditRightAlign.Checked:=reOrgOtherInfo.Paragraph.Alignment=taRightJustify;
      Action_RichEditBullets.Checked:=reOrgOtherInfo.Paragraph.Numbering=nsBullet;
    end;
  if PageControl1.ActivePage=tsMsr then
    begin
      Action_RichEditBold.Checked:=fsBold in reMsrOtherInfo.SelAttributes.Style;
      Action_RichEditItalic.Checked:=fsItalic in reMsrOtherInfo.SelAttributes.Style;
      Action_RichEditUnderline.Checked:=fsUnderline in reMsrOtherInfo.SelAttributes.Style;
      Action_RichEditLeftAlign.Checked:=reMsrOtherInfo.Paragraph.Alignment=taLeftJustify;
      Action_RichEditCenterAlign.Checked:=reMsrOtherInfo.Paragraph.Alignment=taCenter;
      Action_RichEditRightAlign.Checked:=reMsrOtherInfo.Paragraph.Alignment=taRightJustify;
      Action_RichEditBullets.Checked:=reMsrOtherInfo.Paragraph.Numbering=nsBullet;
    end;
end;

procedure TMainForm.Refresh_NodeState(bFullRefresh: boolean);
var
	i, j: integer;
	s, q: string;
	bError: boolean;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{A17D7012-A5F2-4468-A00D-8D39776BFE79}';
	bError:=False;
  if bFullRefresh then
    begin
      if lvOrg.Items.Count>0 then
        begin
          LogThis('Производится обновление значков состояния организаций.',LogGroupGUID,lmtInfo);
          ProgressBar1.Max:=lvOrg.Items.Count-1;
          ProgressBar1.Step:=1;
          lvOrg.Items.BeginUpdate;
          for j:=0 to lvOrg.Items.Count-1 do
            begin
              if not bError then
                begin
                  s:=lvOrg.Items.Item[j].SubItems[2];
                  // LogThis('Производится обновление состояния организации с ID='+s+'.',LogGroupGUID,lmtInfo);
                  q:='SELECT org_erased FROM '+Configuration.sMySQLDatabase+'._org WHERE org_id="'+s+'";';
                  // LogThis(q,LogGroupGUID,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                  if i=0 then
		                begin
			                // LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                      try
			                  if ResultSet<>nil then
				                  begin
					                  // LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					                  i:=mysql_num_rows(ResultSet);
                            // LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
					                  if (i=1) then
						                  begin
                                // LogThis('Количество строк выборки ('+IntToStr(i)+') соответствует требуемому (1).',LogGroupGUID,lmtInfo);
                                ResultRow:=mysql_fetch_row(ResultSet);
                                if ResultRow<>nil then
                                  begin
                                    if (ResultRow[0]='1') then
                                      lvOrg.Items.Item[j].ImageIndex:=DELETEDICON_ID
                                    else
                                      if (ResultRow[0]='0') then
                                        lvOrg.Items.Item[j].ImageIndex:=EXISTINGICON_ID
                                      else lvOrg.Items.Item[j].ImageIndex:=UNKNOWNICON_ID;
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
                            // LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
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
          lvOrg.Items.EndUpdate;
          ProgressBar1.Position:=ProgressBar1.Min;
          if bError then
            begin
              LogThis(s,LogGroupGUID,lmtError);
              Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else LogThis('Обновление значков состояния организаций прошло успешно.',LogGroupGUID,lmtInfo);
        end;
    end
  else
    begin
      if lvOrg.Items.Count>0 then
        begin
          LogThis('Производится обновление значков состояния выделенной организации.',LogGroupGUID,lmtInfo);
          ProgressBar1.Max:=1;
          ProgressBar1.Step:=1;
          lvOrg.Items.BeginUpdate;
          s:=lvOrg.Selected.SubItems[2];
          LogThis('Производится обновление состояния организации с ID='+s+'.',LogGroupGUID,lmtInfo);
          q:='SELECT org_erased FROM '+Configuration.sMySQLDatabase+'._org WHERE org_id="'+s+'";';
          LogThis(q,LogGroupGUID,lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
              ResultSet:=mysql_store_result(MySQLConnectionHandler);
              try
                if ResultSet<>nil then
                  begin
                    LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                    i:=mysql_num_rows(ResultSet);
                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                    if (i=1) then
                      begin
                        LogThis('Количество строк выборки ('+IntToStr(i)+') соответствует требуемому (1).',LogGroupGUID,lmtInfo);
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow<>nil then
                          begin
                            if (ResultRow[0]='1') then
                              lvOrg.Selected.ImageIndex:=DELETEDICON_ID
                            else
                              if (ResultRow[0]='0') then
                                lvOrg.Selected.ImageIndex:=EXISTINGICON_ID
                              else lvOrg.Selected.ImageIndex:=UNKNOWNICON_ID;
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
                    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
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
          lvOrg.Items.EndUpdate;
          ProgressBar1.Position:=ProgressBar1.Min;
          if bError then
            begin
              LogThis(s,LogGroupGUID,lmtError);
              Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else LogThis('Обновление значков состояния организаций прошло успешно.',LogGroupGUID,lmtInfo);
        end;
    end;
  if not bError then
    begin
      if lvMsr.Items.Count>0 then
        begin
          LogThis('Производится обновление значков состояния мероприятий.',LogGroupGUID,lmtInfo);
          ProgressBar1.Max:=lvMsr.Items.Count-1;
          ProgressBar1.Step:=1;
          lvMsr.Items.BeginUpdate;
          for j:=0 to lvMsr.Items.Count-1 do
            begin
              if not bError then
                begin
                  s:=lvMsr.Items.Item[j].SubItems[2];
                  // LogThis('Производится обновление состояния мероприятия с ID='+s+'.',LogGroupGUID,lmtInfo);
                  q:='SELECT msr_erased FROM '+Configuration.sMySQLDatabase+'._msr WHERE msr_id="'+s+'";';
                  // LogThis(q,LogGroupGUID,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                  if i=0 then
		                begin
			                // LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			                ResultSet:=mysql_store_result(MySQLConnectionHandler);
                      try
			                  if ResultSet<>nil then
				                  begin
					                  // LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					                  i:=mysql_num_rows(ResultSet);
                            // LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
					                  if (i=1) then
						                  begin
                                // LogThis('Количество строк выборки ('+IntToStr(i)+') соответствует требуемому (1).',LogGroupGUID,lmtInfo);
                                ResultRow:=mysql_fetch_row(ResultSet);
                                if ResultRow<>nil then
                                  begin
                                    if (ResultRow[0]='1') then
                                      lvMsr.Items.Item[j].ImageIndex:=DELETEDICON_ID
                                    else
                                      if (ResultRow[0]='0') then
                                        lvMsr.Items.Item[j].ImageIndex:=EXISTINGICON_ID
                                      else lvMsr.Items.Item[j].ImageIndex:=UNKNOWNICON_ID;
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
                            // LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
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
          lvMsr.Items.EndUpdate;
          ProgressBar1.Position:=ProgressBar1.Min;
          if bError then
            begin
              LogThis(s,LogGroupGUID,lmtError);
              Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else LogThis('Обновление значков состояния мероприятий прошло успешно.',LogGroupGUID,lmtInfo);
        end;
    end;
end;

procedure TMainForm.Action_DB_DefragmentationExecute(Sender: TObject);
begin
  MessageBox(Handle,PChar('Данное действие на текущий момент в программе не реализовано.'),PChar('Невозможно выполнить операцию'),MB_OK+MB_ICONSTOP);
end;

procedure TMainForm.Action_DB_DeleteNodeExecute(Sender: TObject);
var
	bError, b: boolean;
	s, s1, q, q1: string;
	i: integer;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{442A2CB0-5B04-4BF9-B3AD-2E2AEB8C119D}';
	SetBusy(LogGroupGUID);
	bError:=False;
  if ActiveControl=lvOrg then
    begin
      if lvOrg.Selected<>nil then
        begin
          s1:=lvOrg.Selected.SubItems[2];
					b:=MessageBox(Handle,PChar('Вы подтверждаете пометку на удаление выделенной организации и всех относящихся к нему мероприятий?'),PChar('OA4 - Подтверждение пометки на удаление'),MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDYES;
          if b then
            begin
	            Screen.Cursor:=crHourGlass;
              ProgressBar1.Max:=4;
              ProgressBar1.Step:=1;
              LogThis('Будет произведена попытка пометки на удаление всех мероприятий организации с ID='+s1,LogGroupGUID,lmtWarning);
							// составление строки запроса
							q:='UPDATE '+Configuration.sMySQLDatabase+'._msr SET msr_erased="1" WHERE msr_organization_id="'+s1+'";';
							LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                  ProgressBar1.StepIt;
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                  // запись статистики в БД
                  LogThis('Внесение записи в таблицу событий.',LogGroupGUID,lmtInfo);
                  q1:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"DEL","msr",0,'+CurrentUser.sID+','+#39+q+#39+');';
                  LogThis(q1,LogGroupGUID,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler,PChar(q1),Length(q1));
                  if i=0 then
                    begin
                      LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                      if (i=1) then
                        begin
                          LogThis('Запись в таблицу событий внесена успешно',LogGroupGUID,lmtInfo);
                          ProgressBar1.StepIt;
                          LogThis('Будет произведена попытка пометки на удаление организации с ID='+s1,LogGroupGUID,lmtWarning);
                          q:='UPDATE '+Configuration.sMySQLDatabase+'._org SET org_erased="1" WHERE org_id="'+s1+'";';
                          LogThis(q,LogGroupGUID,lmtSQL);
                          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                          if i=0 then
                            begin
                              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                              LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                              if i=1 then
                                begin
                                  LogThis('Пометка организации на удаление произведена успешно',LogGroupGUID,lmtInfo);
                                  ProgressBar1.StepIt;
                                  // запись статистики в БД
                                  LogThis('Внесение записи в таблицу событий.',LogGroupGUID,lmtInfo);
                                  q1:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"DEL","org",'+s1+','+CurrentUser.sID+','+#39+q+#39+');';
                                  LogThis(q1,LogGroupGUID,lmtSQL);
                                  i:=mysql_real_query(MySQLConnectionHandler,PChar(q1),Length(q1));
                                  if i=0 then
                                    begin
                                      LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                                      if (i=1) then
                                        begin
                                          LogThis('Запись в таблицу событий внесена успешно',LogGroupGUID,lmtInfo);
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
                  LogThis(s,LogGroupGUID,lmtError);
                  MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                end;
            end
          else
            LogThis('Попытка пометки на удаление организации с ID='+s1+' была отменена.',LogGroupGUID,lmtInfo);
        end;
    end;
  if ActiveControl=lvMsr then
    begin
      if lvMsr.Selected<>nil then
        begin
          s:=lvMsr.Selected.SubItems[2];
          Screen.Cursor:=crHourGlass;
          ProgressBar1.Max:=2;
          ProgressBar1.Step:=1;
          LogThis('Будет произведена попытка пометки на удаление мероприятия с ID='+s,LogGroupGUID,lmtWarning);
          // составление строки запроса
          q:='UPDATE '+Configuration.sMySQLDatabase+'._msr SET msr_erased="1" WHERE msr_id="'+s+'";';
          LogThis(q,LogGroupGUID,lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
              ProgressBar1.StepIt;
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
              if (i=1) then
                begin
                  LogThis('Пометка мероприятия на удаление произведена успешно',LogGroupGUID,lmtInfo);
                  ProgressBar1.StepIt;
                  // запись статистики в БД
                  LogThis('Внесение записи в таблицу событий.',LogGroupGUID,lmtInfo);
                  q1:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"DEL","msr",'+s+','+CurrentUser.sID+','+#39+q+#39+');';
                  LogThis(q1,LogGroupGUID,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler,PChar(q1),Length(q1));
                  if i=0 then
                    begin
                      LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                      if (i=1) then
                        begin
                          LogThis('Запись в таблицу событий внесена успешно',LogGroupGUID,lmtInfo);
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
              LogThis(s,LogGroupGUID,lmtError);
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end;
        end;
    end;
  Update_Actions;
	SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_DB_RecoverNodeExecute(Sender: TObject);
var
	bError, b: boolean;
	s, q, q1: string;
	i: integer;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{E41063C4-1F4D-4A62-837A-0DA56B7B68C1}';
	SetBusy(LogGroupGUID);
	bError:=False;
  if ActiveControl=lvOrg then
    begin
      if lvOrg.Selected<>nil then
        begin
          s:=lvOrg.Selected.SubItems[2];
          Screen.Cursor:=crHourGlass;
          ProgressBar1.Max:=2;
          ProgressBar1.Step:=1;
          LogThis('Будет произведена попытка восстановления организации с ID='+s,LogGroupGUID,lmtWarning);
          // составление строки запроса
          q:='UPDATE '+Configuration.sMySQLDatabase+'._org SET org_erased="0" WHERE org_id="'+s+'";';
          LogThis(q,LogGroupGUID,lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
              ProgressBar1.StepIt;
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
              if (i=1) then
                begin
                  LogThis('Восстановление организации произведена успешно',LogGroupGUID,lmtInfo);
                  ProgressBar1.StepIt;
                  // запись статистики в БД
                  LogThis('Внесение записи в таблицу событий.',LogGroupGUID,lmtInfo);
                  q1:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"REC","org",'+s+','+CurrentUser.sID+','+#39+q+#39+');';
                  LogThis(q1,LogGroupGUID,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler,PChar(q1),Length(q1));
                  if i=0 then
                    begin
                      LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                      if (i=1) then
                        begin
                          LogThis('Запись в таблицу событий внесена успешно',LogGroupGUID,lmtInfo);
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
              LogThis(s,LogGroupGUID,lmtError);
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end;
        end;
    end;


  if ActiveControl=lvMsr then
    begin
      if lvMsr.Selected<>nil then
        begin
          if lvOrg.Selected<>nil then
            if lvOrg.Selected.ImageIndex=DELETEDICON_ID then
              begin
                LogThis('Восстанавливаемое мероприятие принадлежит удалённой организации!',LogGroupGUID,lmtWarning);
                b:=MessageBox(Handle,PChar('Вы пытаетесь воостановить мероприятие помеченной на удаление организации.'+#10#13+
                  'Данная операция невозможна без восстановления самой организации.'+#10#13+
                  'Вы желаете восстановить организацию, к которой относится мероприятие?'),
                  PChar('OA4 - Подтверждение восстановления'),MB_YESNO+MB_ICONEXCLAMATION+MB_DEFBUTTON2)=IDYES;
                if b then
                  begin
                    s:=lvOrg.Selected.SubItems[2];
                    Screen.Cursor:=crHourGlass;
                    ProgressBar1.Max:=2;
                    ProgressBar1.Step:=1;
                    LogThis('Будет произведена попытка восстановления организации с ID='+s,LogGroupGUID,lmtWarning);
                    // составление строки запроса
                    q:='UPDATE '+Configuration.sMySQLDatabase+'._org SET org_erased="0" WHERE org_id="'+s+'";';
                    LogThis(q,LogGroupGUID,lmtSQL);
                    i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                    ProgressBar1.StepIt;
                    if i=0 then
                      begin
                        LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                        i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                        LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                        if (i=1) then
                          begin
                            LogThis('Восстановление организации произведено успешно',LogGroupGUID,lmtInfo);
                            // запись статистики в БД
                            LogThis('Внесение записи в таблицу событий.',LogGroupGUID,lmtInfo);
                            q:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"REC","org",'+s+','+CurrentUser.sID+','+#39+q+#39+');';
                            LogThis(q,LogGroupGUID,lmtSQL);
                            i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                            ProgressBar1.StepIt;
                            if i=0 then
                              begin
                                LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                                i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                                LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                                if (i=1) then
                                  LogThis('Запись в таблицу событий внесена успешно',LogGroupGUID,lmtInfo)
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
                        LogThis(s,LogGroupGUID,lmtError);
                        MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                      end;
                  end
                else
                  begin
                    // выход
                    LogThis('Восстанавление мероприятия и организации-владельца отменено.',LogGroupGUID,lmtWarning);
                    Screen.Cursor:=crDefault;
                    SetReady(LogGroupGUID);
                    Exit;
                  end;
              end;
          if not bError then
            begin
              s:=lvMsr.Selected.SubItems[2];
              Screen.Cursor:=crHourGlass;
              ProgressBar1.Max:=2;
              ProgressBar1.Step:=1;
              LogThis('Будет произведена попытка восстановления мероприятия с ID='+s,LogGroupGUID,lmtWarning);
              // составление строки запроса
              q:='UPDATE '+Configuration.sMySQLDatabase+'._msr SET msr_erased="0" WHERE msr_id="'+s+'";';
              LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              ProgressBar1.StepIt;
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                  if (i=1) then
                    begin
                      LogThis('Восстановление мероприятия произведено успешно.',LogGroupGUID,lmtInfo);
                      // запись статистики в БД
                      LogThis('Внесение записи в таблицу событий.',LogGroupGUID,lmtInfo);
                      q:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"REC","msr",'+s+','+CurrentUser.sID+','+#39+q+#39+');';
                      LogThis(q,LogGroupGUID,lmtSQL);
                      i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                      ProgressBar1.StepIt;
                      if i=0 then
                        begin
                          LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                          LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                          if (i=1) then
                            LogThis('Запись в таблицу событий внесена успешно.',LogGroupGUID,lmtInfo)
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
                  LogThis(s,LogGroupGUID,lmtError);
                  MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                end;
            end;
        end;
    end;
  Update_Actions;
	SetReady(LogGroupGUID);
end;

procedure TMainForm.Action_DB_RefreshListExecute(Sender: TObject);
begin
  MessageBox(Handle,PChar('Данное действие на текущий момент в программе не реализовано.'),PChar('Невозможно выполнить операцию'),MB_OK+MB_ICONSTOP);
end;

procedure TMainForm.spedMsrDurationDaysChange(Sender: TObject);
var
  a1: Comp;
  t1, t2: TTimeStamp;
begin
  if chkbxMsrStart.Checked and chkbxMsrStop.Checked then
    begin
      dtpMsrStartDate.Time:=dtpMsrStartTime.Time;
      dtpMsrStopDate.Time:=dtpMsrStopTime.Time;
      dtpMsrStartTime.Date:=dtpMsrStartDate.Date;
      dtpMsrStopTime.Date:=dtpMsrStopDate.Date;
    end;
  if spedMsrDurationDays.Focused or spedMsrDurationHours.Focused or spedMsrDurationMinutes.Focused then
    if ((spedMsrDurationDays.Text<>'') and (spedMsrDurationHours.Text<>'') and (spedMsrDurationMinutes.Text<>'')) then
      begin
        t1:=DateTimeToTimeStamp(dtpMsrStartDate.DateTime);
        t1.Date:=t1.Date+spedMsrDurationDays.Value;
        a1:=TimeStampToMSecs(t1)+(spedMsrDurationMinutes.Value*60000)+(spedMsrDurationHours.Value*3600000);
        t2:=MSecsToTimeStamp(a1);
        dtpMsrStopDate.DateTime:=TimeStampToDateTime(t2);
        dtpMsrStopTime.DateTime:=TimeStampToDateTime(t2);
      end;
end;

procedure TMainForm.edbxMsrAuthorEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxMsrAuthor.Text)<>'' then
        ShowEditBaloonTip(edbxMsrAuthor, lblMsrAuthor.Caption, Trim(edbxMsrAuthor.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxMsrAuthor, lblMsrAuthor.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxMsrAuthorExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxMsrAuthor);
end;

procedure TMainForm.edbxMsrNameEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxMsrName.Text)<>'' then
        ShowEditBaloonTip(edbxMsrName, lblMsrName.Caption, Trim(edbxMsrName.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxMsrName, lblMsrName.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxMsrNameExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxMsrName);
  if CurrentUser.bDBEdition then
    edbxMsrName.Text:=ValidateString(edbxMsrName.Text);
end;

procedure TMainForm.edbxMsrOrganizerEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxMsrOrganizer.Text)<>'' then
        ShowEditBaloonTip(edbxMsrOrganizer, lblMsrOrganizer.Caption, Trim(edbxMsrOrganizer.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxMsrOrganizer, lblMsrOrganizer.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxMsrOrganizerExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxMsrOrganizer);
end;

procedure TMainForm.edbxMsrPerformerEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxMsrPerformer.Text)<>'' then
        ShowEditBaloonTip(edbxMsrPerformer, lblMsrPerformer.Caption, Trim(edbxMsrPerformer.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxMsrPerformer, lblMsrPerformer.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxMsrPerformerExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxMsrPerformer);
end;

procedure TMainForm.edbxMsrProducerEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxMsrProducer.Text)<>'' then
        ShowEditBaloonTip(edbxMsrProducer, lblMsrProducer.Caption, Trim(edbxMsrProducer.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxMsrProducer, lblMsrProducer.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxMsrProducerExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxMsrProducer);
end;

procedure TMainForm.edbxMsrTypeEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxMsrType.Text)<>'' then
        ShowEditBaloonTip(edbxMsrType, lblMsrType.Caption, Trim(edbxMsrType.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxMsrType, lblMsrType.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxMsrTypeExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxMsrType);
end;

procedure TMainForm.edbxOrgAddressEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgAddress.Text)<>'' then
        ShowEditBaloonTip(edbxOrgAddress, lblOrgAddress.Caption, Trim(edbxOrgAddress.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgAddress, lblOrgAddress.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxOrgAddressExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgAddress);
  if CurrentUser.bDBEdition then
    edbxOrgAddress.Text:=ValidateString(edbxOrgAddress.Text);
end;

procedure TMainForm.edbxOrgFlatEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgFlat.Text)<>'' then
        ShowEditBaloonTip(edbxOrgFlat, lblOrgFlat.Caption, Trim(edbxOrgFlat.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgFlat, lblOrgFlat.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxOrgFlatExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgFlat);
  if CurrentUser.bDBEdition then
    edbxOrgFlat.Text:=ValidateString(edbxOrgFlat.Text);
end;

procedure TMainForm.edbxOrgHouseEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgHouse.Text)<>'' then
        ShowEditBaloonTip(edbxOrgHouse, lblOrgHouse.Caption, Trim(edbxOrgHouse.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgHouse, lblOrgHouse.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxOrgHouseExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgHouse);
  if CurrentUser.bDBEdition then
    edbxOrgHouse.Text:=ValidateString(edbxOrgHouse.Text);
end;

procedure TMainForm.edbxOrgHowToReachEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgHowToReach.Text)<>'' then
        ShowEditBaloonTip(edbxOrgHowToReach, lblOrgHowToReach.Caption, Trim(edbxOrgHowToReach.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgHowToReach, lblOrgHowToReach.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxOrgHowToReachExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgHowToReach);
  if CurrentUser.bDBEdition then
    edbxOrgHowToReach.Text:=ValidateString(edbxOrgHowToReach.Text);
end;

procedure TMainForm.edbxOrgNameEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgName.Text)<>'' then
        ShowEditBaloonTip(edbxOrgName, lblOrgName.Caption, Trim(edbxOrgName.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgName, lblOrgName.Caption, '<пусто>', TTI_NONE)
    end;
end;

procedure TMainForm.edbxOrgNameExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgName);
  if CurrentUser.bDBEdition then
    edbxOrgName.Text:=ValidateString(edbxOrgName.Text);
end;

procedure TMainForm.edbxOrgStreetEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgStreet.Text)<>'' then
        ShowEditBaloonTip(edbxOrgStreet, lblOrgStreet.Caption, Trim(edbxOrgStreet.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgStreet, lblOrgStreet.Caption, '<пусто>', TTI_NONE);
    end;
end;

procedure TMainForm.edbxOrgStreetExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgStreet);
end;

procedure TMainForm.edbxOrgSubHouseEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgSubHouse.Text)<>'' then
        ShowEditBaloonTip(edbxOrgSubHouse, lblOrgSubHouse.Caption, Trim(edbxOrgSubHouse.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgSubHouse, lblOrgSubHouse.Caption, '<пусто>', TTI_NONE);
    end;
end;

procedure TMainForm.edbxOrgSubHouseExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgSubHouse);
  if CurrentUser.bDBEdition then
    edbxOrgSubHouse.Text:=ValidateString(edbxOrgSubHouse.Text);
end;

procedure TMainForm.cmbbxOrgTypeExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    cmbbxOrgType.Text:=ValidateString(cmbbxOrgType.Text);
end;

procedure TMainForm.edbxOrgTownEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgTown.Text)<>'' then
        ShowEditBaloonTip(edbxOrgTown, lblOrgTown.Caption, Trim(edbxOrgTown.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgTown, lblOrgTown.Caption, '<пусто>', TTI_NONE);
    end;
end;

procedure TMainForm.edbxOrgTownExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgTown);
end;

procedure TMainForm.edbxOrgTypeEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgType.Text)<>'' then
        ShowEditBaloonTip(edbxOrgType, lblOrgType.Caption, Trim(edbxOrgType.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgType, lblOrgType.Caption, '<пусто>', TTI_NONE);
    end;
end;

procedure TMainForm.edbxOrgTypeExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgType);
end;

procedure TMainForm.edbxOrgWorkTimeEnter(Sender: TObject);
begin
  if (not CurrentUser.bDBEdition) and (not Configuration.bHideEditBoxToolTips) then
    begin
      if Trim(edbxOrgWorkTime.Text)<>'' then
        ShowEditBaloonTip(edbxOrgWorkTime, lblOrgWorkTime.Caption, Trim(edbxOrgWorkTime.Text), TTI_NONE)
      else ShowEditBaloonTip(edbxOrgWorkTime, lblOrgWorkTime.Caption, '<пусто>', TTI_NONE);
    end;
end;

procedure TMainForm.edbxOrgWorkTimeExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxOrgWorkTime);
end;

procedure TMainForm.edbxSearchAddressEnter(Sender: TObject);
begin
  if not Configuration.bHideEditBoxToolTips then
    ShowEditBaloonTip(edbxSearchAddress, 'Подсказка', 'Введите адресную часть строк искомой информации '+
      'и нажмите клавишу ENTER для выполнения запроса. Для отображения полного списка очистите поле '+
      'и нажмите клавишу ENTER.', TTI_INFO);
end;

procedure TMainForm.edbxSearchAddressExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxSearchAddress);
end;

procedure TMainForm.edbxSearchNameEnter(Sender: TObject);
begin
  if not Configuration.bHideEditBoxToolTips then
    ShowEditBaloonTip(edbxSearchName, 'Подсказка', 'Введите фрагменты строк наименования искомой информации '+
      'и нажмите клавишу ENTER для выполнения запроса. Для отображения полного списка очистите поле '+
      'и нажмите клавишу ENTER.', TTI_INFO);
end;

procedure TMainForm.edbxSearchNameExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxSearchName);
end;

procedure TMainForm.edbxSearchOtherEnter(Sender: TObject);
begin
  if not Configuration.bHideEditBoxToolTips then
    ShowEditBaloonTip(edbxSearchOther, 'Подсказка', 'Введите фрагменты строк прочей искомой информации '+
      'и нажмите клавишу ENTER для выполнения запроса. Для отображения полного списка очистите поле '+
      'и нажмите клавишу ENTER.', TTI_INFO);
end;

procedure TMainForm.edbxSearchOtherExit(Sender: TObject);
begin
  HideEditBaloonTip(edbxSearchOther);
end;

procedure TMainForm.chkbxMsrStartClick(Sender: TObject);
begin
  dtpMsrStartDate.Enabled:=chkbxMsrStart.Checked;
  dtpMsrStartTime.Enabled:=chkbxMsrStart.Checked;
  spedMsrDurationDays.Enabled:=chkbxMsrUnknownDuration.Enabled and not chkbxMsrUnknownDuration.Checked and chkbxMsrStart.Checked and chkbxMsrStop.Checked;
  spedMsrDurationHours.Enabled:=spedMsrDurationDays.Enabled;
  spedMsrDurationMinutes.Enabled:=spedMsrDurationDays.Enabled;
  lblMsrDurationDays.Enabled:=spedMsrDurationDays.Enabled;
  lblMsrDurationHours.Enabled:=spedMsrDurationDays.Enabled;
  lblMsrDurationMinutes.Enabled:=spedMsrDurationDays.Enabled;
  if not spedMsrDurationDays.Enabled then
    spedMsrDurationDays.Value:=0;
  if not spedMsrDurationHours.Enabled then
    spedMsrDurationHours.Value:=0;
  if not spedMsrDurationMinutes.Enabled then
    spedMsrDurationMinutes.Value:=0;
  dtpMsrStartDateChange(Sender);
end;

procedure TMainForm.chkbxMsrStopClick(Sender: TObject);
begin
  dtpMsrStopDate.Enabled:=chkbxMsrStop.Checked;
	dtpMsrStopTime.Enabled:=chkbxMsrStop.Checked;
  spedMsrDurationDays.Enabled:=chkbxMsrUnknownDuration.Enabled and not chkbxMsrUnknownDuration.Checked and chkbxMsrStart.Checked and chkbxMsrStop.Checked;
  spedMsrDurationHours.Enabled:=spedMsrDurationDays.Enabled;
  spedMsrDurationMinutes.Enabled:=spedMsrDurationDays.Enabled;
  lblMsrDurationDays.Enabled:=spedMsrDurationDays.Enabled;
  lblMsrDurationHours.Enabled:=spedMsrDurationDays.Enabled;
  lblMsrDurationMinutes.Enabled:=spedMsrDurationDays.Enabled;
  dtpMsrStartDateChange(Sender);
end;

procedure TMainForm.chkbxMsrUnknownDurationClick(Sender: TObject);
begin
  spedMsrDurationDays.Enabled:=chkbxMsrUnknownDuration.Enabled and not chkbxMsrUnknownDuration.Checked and chkbxMsrStart.Checked and chkbxMsrStop.Checked;
  spedMsrDurationHours.Enabled:=spedMsrDurationDays.Enabled;
  spedMsrDurationMinutes.Enabled:=spedMsrDurationDays.Enabled;
  lblMsrDurationDays.Enabled:=spedMsrDurationDays.Enabled;
  lblMsrDurationHours.Enabled:=spedMsrDurationDays.Enabled;
  lblMsrDurationMinutes.Enabled:=spedMsrDurationDays.Enabled;
  dtpMsrStartDateChange(Sender);
end;

procedure TMainForm.meMsrTicketPriceExit(Sender: TObject);
begin
  if CurrentUser.bDBEdition then
    meMsrTicketPrice.Text:=ValidateString(meMsrTicketPrice.Text);
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
      Action_DB_AddOrganization.Visible:=CurrentUser.bDBEdition;
      Action_DB_AddMeasure.Visible:=CurrentUser.bDBEdition;
      Action_DB_RecoverNode.Visible:=CurrentUser.bDBEdition;
      Action_DB_DeleteNode.Visible:=CurrentUser.bDBEdition;
      Action_DB_RefreshList.Visible:=False; // !!!
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
      Action_DB_AddOrganization.Enabled:=Action_DB_AddOrganization.Visible;
      if lvOrg.Focused then
        begin
          if lvOrg.Selected<>nil then
            begin
              Action_DB_AddMeasure.Enabled:=CurrentUser.bDBEdition;
              Action_DB_RecoverNode.Enabled:=CurrentUser.bDBEdition and (lvOrg.Selected.ImageIndex=DELETEDICON_ID);
              Action_DB_DeleteNode.Enabled:=CurrentUser.bDBEdition and (lvOrg.Selected.ImageIndex=EXISTINGICON_ID);
            end
          else
            begin
              Action_DB_AddMeasure.Enabled:=False;
              Action_DB_RecoverNode.Enabled:=False;
              Action_DB_DeleteNode.Enabled:=False;
            end;
        end;
      if lvMsr.Focused then
        begin
          if lvMsr.Selected<>nil then
            begin
              Action_DB_AddMeasure.Enabled:=CurrentUser.bDBEdition;
              Action_DB_RecoverNode.Enabled:=CurrentUser.bDBEdition and (lvMsr.Selected.ImageIndex=DELETEDICON_ID);
              Action_DB_DeleteNode.Enabled:=CurrentUser.bDBEdition and (lvMsr.Selected.ImageIndex=EXISTINGICON_ID);
            end
          else
            begin
              Action_DB_AddMeasure.Enabled:=False;
              Action_DB_RecoverNode.Enabled:=False;
              Action_DB_DeleteNode.Enabled:=False;
            end;
        end;
      if (not lvOrg.Focused) and (not lvMsr.Focused) then
        begin
          Action_DB_AddMeasure.Enabled:=False;
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
      Action_DB_AddMeasure.Visible:=False;
      Action_DB_AddOrganization.Visible:=False;
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
      Action_DB_AddMeasure.Enabled:=Action_DB_AddMeasure.Visible;
      Action_DB_AddOrganization.Enabled:=Action_DB_AddOrganization.Visible;
      Action_DB_DeleteNode.Enabled:=Action_DB_DeleteNode.Visible;
      Action_DB_RefreshList.Enabled:=Action_DB_RefreshList.Visible;
      Action_DB_RecoverNode.Enabled:=Action_DB_RecoverNode.Visible;
      Action_PostMessage.Visible:=Action_PostMessage.Visible;
      Action_ViewMessages.Visible:=Action_PostMessage.Visible;
    end;
  // обновление "вилимости" разделителей
	ActionToolBar1.ActionControls[1].Visible:=Action_Quit.Visible;
	ActionToolBar1.ActionControls[4].Visible:=Action_DB_Connection.Visible or Action_DB_Disconnection.Visible;
	ActionToolBar1.ActionControls[10].Visible:=Action_DB_AddOrganization.Visible or Action_DB_AddMeasure.Visible or Action_DB_DeleteNode.Visible or Action_DB_RecoverNode.Visible or Action_DB_RefreshList.Visible;
	ActionToolBar1.ActionControls[15].Visible:=Action_DB_Cleaning.Visible or Action_DB_Defragmentation.Visible or Action_DB_Maintenance.Visible or Action_DB_Backup.Visible;
	ActionToolBar1.ActionControls[18].Visible:=Action_DB_Users.Visible or Action_DB_Statistic.Visible;
  ActionToolBar1.ActionControls[21].Visible:=Action_PostMessage.Visible or Action_ViewMessages.Visible;
	ActionToolBar1.ActionControls[23].Visible:=Action_Configuration.Visible;
  miActions.Visible:=Action_DB_Backup.Visible or Action_DB_Cleaning.Visible or Action_DB_Defragmentation.Visible or
    Action_DB_Maintenance.Visible or Action_DB_AddMeasure.Visible or Action_DB_AddOrganization.Visible or
    Action_DB_DeleteNode.Visible or Action_DB_RecoverNode.Visible or Action_DB_RefreshList.Visible or
    Action_PostMessage.Visible or Action_ViewMessages.Visible;
end;

procedure TMainForm.btnCancelClick(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{923F0DC4-1B9B-4719-B29C-E839D7D87E1A}';
  SetBusy(LogGroupGUID);
  bAddingOrgNow:=False;
  bAddingMsrNow:=False;
  if lvOrg.Items.Count>0 then
    lvOrg.ItemIndex:=iLastSelectedOrgIndex
  else lvOrgSelectItem(Sender,nil,True);
  if (lvOrg.Selected<>nil) then
    TryToSet_lvOrg_Focused
  else TryToSet_edbxSearchName_Focused;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.btnCloneClick(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{7DE3F2CC-1469-4AE8-AF3B-B3EB633C6719}';
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  if PageControl1.ActivePage=tsOrg then
    bAddingOrgNow:=True;
  if PageControl1.ActivePage=tsMsr then
    bAddingMsrNow:=True;
  if lvOrg.Selected<>nil then
    iLastSelectedOrgIndex:=lvOrg.Selected.Index
  else
    if lvOrg.Items.Count>0 then
      iLastSelectedOrgIndex:=0
    else iLastSelectedOrgIndex:=-1;
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
  //очистка значений контролов
  lblId.Caption:='';
  lblCreation.Caption:='';
  lblModification.Caption:='';
  btnCancel.Enabled:=True;
  btnCancel.Visible:=True;
  if PageControl1.ActivePage=tsOrg then
    TryToSet_cmbbxOrgType_Focused;
  if PageControl1.ActivePage=tsMsr then
    TryToSet_cmbbxMsrType_Focused;
  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
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
//  LvGroupMetrics: TLVGROUPMETRICS;
  ListItem: TListItem;
  i, j: integer;
  pwcGroupName: PWideChar;
  GroupId: integer;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{C823D68B-B899-4FAC-BE0A-64F6DA515092}';
  SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	bError:=False;

  slLastSearchedName.Clear;
  slLastSearchedAddress.Clear;
  slLastSearchedOther.Clear;

	// преобразование строки поиска
	LogThis('Преобразование строки поиска - <'+edbxSearchName.Text+'>.',LogGroupGUID,lmtInfo);
	s:=Trim(edbxSearchName.Text);
	while Pos('  ',s)>0 do s:=StringReplace(s,'  ',' ',[rfReplaceAll]);
	edbxSearchName.Text:=s;
	LogThis('Итоговая строки поиска - <'+edbxSearchName.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;
  // очиска списков
  lvOrg.Items.BeginUpdate;
  blvOrgRedrawNow:=True; // перерисовка окна результатов поиска включена
  SendMessage(lvOrg.Handle, LVM_REMOVEALLGROUPS, 0, 0);
  SendMessage(lvOrg.Handle, LVM_DELETEALLITEMS, 0, 0);
  lvOrg.Items.EndUpdate;

  lvMsr.Items.BeginUpdate;
  SendMessage(lvMsr.Handle, LVM_REMOVEALLGROUPS, 0, 0);
  SendMessage(lvMsr.Handle, LVM_DELETEALLITEMS, 0, 0);
  lvMsr.Items.EndUpdate;

  reMsr.Lines.BeginUpdate;
  reMsr.Clear;
  SendMessage(reMsr.Handle, WM_HSCROLL, SB_TOP, 0);
  reMsr.Lines.EndUpdate;

  SendMessage(lvOrg.Handle, LVM_ENABLEGROUPVIEW, 1, 0);
  q1:='';
  q:='SELECT UCASE(TRIM(SUBSTRING_INDEX(f.name,"|",-1))) AS x1, '+
  'TRIM(SUBSTRING_INDEX(f.name,"|",1)) AS x2, '+
  '_org_address AS x3, '+
  'COUNT(msr_id) AS x4, '+
  'org_id AS x5, '+
  'org_erased AS x6, '+
  'a_c.name, '+
  'a_s.name, '+
  'f.house_num, '+
  'f.house_sym, '+
  'f.subhouse_num, '+
  'f.subhouse_sym, '+
  'f.flat_num, '+
  'f.flat_sym '+
  'FROM '+Configuration.sMySQLDatabase+'._org '+
  'LEFT JOIN minsk.firma f ON f.firm_code=org_firm_code '+
  'LEFT JOIN minsk.city a_c ON a_c.city_id=f.city_id and a_c.alt="0" '+ 
  'LEFT JOIN minsk.street a_s ON a_s.street_id=f.street_id '+
  'LEFT JOIN '+Configuration.sMySQLDatabase+'._msr m ON msr_organization_id=org_id ';
  if (chkbxHideErased.Visible and chkbxHideErased.Enabled and chkbxHideErased.Checked) or (not chkbxHideErased.Visible) then
    q:=q+'AND (msr_erased="0" OR ISNULL(msr_erased)) ';
  if chkbxHideOld.Enabled and chkbxHideOld.Checked then
    q:=q+'AND ((msr_stop_datetime>="'+FormatDateTime('yyyy-mm-dd',Now)+' 00:00:00") OR ISNULL(msr_stop_datetime)) ';
  q:=q+'LEFT JOIN minsk.otdel o ON o.firm_code=f.firm_code ';


  q:=q+'LEFT JOIN '+Configuration.sMySQLDatabase+'._phn ON phn_otdel_id=o.otdel_id ';



  if (chkbxHideErased.Visible and chkbxHideErased.Enabled and chkbxHideErased.Checked) or (not chkbxHideErased.Visible) then
    q1:='org_erased="0" ';
  if chkbxPremier.Visible and chkbxPremier.Enabled and chkbxPremier.Checked then
    begin
      if q1>'' then
        q1:=q1+'AND ';
      q1:=q1+'msr_is_premier="1" ';
    end;
  if chkbxTour.Visible and chkbxTour.Enabled and chkbxTour.Checked then
    begin
      if q1>'' then
        q1:=q1+'AND ';
      q1:=q1+'msr_is_tour="1" ';
    end;
  if chkbxChildren.Visible and chkbxChildren.Enabled and chkbxChildren.Checked then
    begin
      if q1>'' then
        q1:=q1+'AND ';
      q1:=q1+'msr_for_children="1" ';
    end;
  if chkbxTeenagers.Visible and chkbxTeenagers.Enabled and chkbxTeenagers.Checked then
    begin
      if q1>'' then
        q1:=q1+'AND ';
      q1:=q1+'msr_for_teenagers="1" ';
    end;
  if chkbxAdultsOnly.Visible and chkbxAdultsOnly.Enabled and chkbxAdultsOnly.Checked then
    begin
      if q1>'' then
        q1:=q1+'AND ';
      q1:=q1+'msr_for_adults_only="1" ';
    end;
  if chkbxStartDate.Visible and chkbxStartDate.Enabled and chkbxStartDate.Checked then
    // будут отобраны все мероприятия не окончившиеся на указанную дату
    begin
      if q1>'' then
        q1:=q1+'AND ';
      q1:=q1+'(ISNULL(msr_stop_datetime) OR (msr_stop_datetime>="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpStartDate.DateTime)+'")) ';
    end;
  if chkbxStopDate.Visible and chkbxStopDate.Enabled and chkbxStopDate.Checked then
    // будут указаны все мероприятия начинающиеся не позднее указанной даты
    begin
      if q1>'' then
        q1:=q1+'AND ';
      q1:=q1+'(ISNULL(msr_start_datetime) OR (msr_start_datetime<="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpStopDate.DateTime)+'")) ';
    end;

	// формирование строки запроса по тексту
	s:=edbxSearchName.Text;
	while Pos('.',s)>0 do s:=StringReplace(s,'.','~~~',[rfReplaceAll]);
  while Pos('*',s)>0 do s:=StringReplace(s,'*','%',[rfReplaceAll]);
	slA:=TStringList.Create;
	try
	  slA.Duplicates:=dupIgnore;
		CutStringByLimiterToStringList(s,slA,' ');
    for i:=0 to slA.Count-1 do
      begin
        if q1>'' then
          q1:=q1+'AND ';
        if slA[i]>'' then
          begin
            if Pos('~~~',slA[i])>0 then
              begin
                q1:=q1+'('+
                '(f.name LIKE "% '+slA[i]+'%") OR '+
                '(f.name LIKE "% '+slA[i]+' %") OR '+
                '(f.name LIKE "% '+slA[i]+'!%") OR '+
                '(f.name LIKE "% '+slA[i]+'.%") OR '+
                '(f.name LIKE "% '+slA[i]+',%") OR '+
                '(f.name LIKE "% '+slA[i]+'-%") OR '+
                '(f.name LIKE "% '+slA[i]+'!%") OR '+
                '(f.name LIKE "% '+slA[i]+'?%") OR '+
                '(f.name LIKE "% '+slA[i]+':%") OR '+
                '(f.name LIKE "% '+slA[i]+';%") OR '+

                '(_org_address LIKE "% '+slA[i]+'%") OR '+
                '(_org_address LIKE "% '+slA[i]+' %") OR '+
                '(_org_address LIKE "% '+slA[i]+'!%") OR '+
                '(_org_address LIKE "% '+slA[i]+'.%") OR '+
                '(_org_address LIKE "% '+slA[i]+',%") OR '+
                '(_org_address LIKE "% '+slA[i]+'-%") OR '+
                '(_org_address LIKE "% '+slA[i]+'!%") OR '+
                '(_org_address LIKE "% '+slA[i]+'?%") OR '+
                '(_org_address LIKE "% '+slA[i]+':%") OR '+
                '(_org_address LIKE "% '+slA[i]+';%") OR '+

                '(a_s.name LIKE "% '+slA[i]+'%") OR '+
                '(a_s.name LIKE "% '+slA[i]+' %") OR '+
                '(a_s.name LIKE "% '+slA[i]+'!%") OR '+
                '(a_s.name LIKE "% '+slA[i]+'.%") OR '+
                '(a_s.name LIKE "% '+slA[i]+',%") OR '+
                '(a_s.name LIKE "% '+slA[i]+'-%") OR '+
                '(a_s.name LIKE "% '+slA[i]+'!%") OR '+
                '(a_s.name LIKE "% '+slA[i]+'?%") OR '+
                '(a_s.name LIKE "% '+slA[i]+':%") OR '+
                '(a_s.name LIKE "% '+slA[i]+';%") OR '+

                '(f.house_num LIKE "'+slA[i]+'%") OR '+
                '(f.house_sym LIKE "'+slA[i]+'%") OR '+

                '(CONCAT(f.house_num,f.house_sym) LIKE "%'+slA[i]+'%") OR '+

                '(f.subhouse_num LIKE "'+slA[i]+'%") OR '+
                '(f.subhouse_sym LIKE "'+slA[i]+'%") OR '+

                '(CONCAT(f.subhouse_num,f.subhouse_sym) LIKE "%'+slA[i]+'%") OR '+

                '(f.flat_num LIKE "'+slA[i]+'%") OR '+
                '(f.flat_sym LIKE "'+slA[i]+'%") OR '+

                '(CONCAT(f.flat_num,f.flat_sym) LIKE "%'+slA[i]+'%") OR '+

                '(org_how_to_reach LIKE "% '+slA[i]+'%") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+' %") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+'!%") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+'.%") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+',%") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+'-%") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+'!%") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+'?%") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+':%") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+';%") OR '+

                '(org_work_time LIKE "% '+slA[i]+'%") OR '+
                '(org_work_time LIKE "% '+slA[i]+' %") OR '+
                '(org_work_time LIKE "% '+slA[i]+'!%") OR '+
                '(org_work_time LIKE "% '+slA[i]+'.%") OR '+
                '(org_work_time LIKE "% '+slA[i]+',%") OR '+
                '(org_work_time LIKE "% '+slA[i]+'-%") OR '+
                '(org_work_time LIKE "% '+slA[i]+'!%") OR '+
                '(org_work_time LIKE "% '+slA[i]+'?%") OR '+
                '(org_work_time LIKE "% '+slA[i]+':%") OR '+
                '(org_work_time LIKE "% '+slA[i]+';%") OR '+

                '(org_other_info LIKE "% '+slA[i]+'%") OR '+
                '(org_other_info LIKE "% '+slA[i]+' %") OR '+
                '(org_other_info LIKE "% '+slA[i]+'!%") OR '+
                '(org_other_info LIKE "% '+slA[i]+'.%") OR '+
                '(org_other_info LIKE "% '+slA[i]+',%") OR '+
                '(org_other_info LIKE "% '+slA[i]+'-%") OR '+
                '(org_other_info LIKE "% '+slA[i]+'!%") OR '+
                '(org_other_info LIKE "% '+slA[i]+'?%") OR '+
                '(org_other_info LIKE "% '+slA[i]+':%") OR '+
                '(org_other_info LIKE "% '+slA[i]+';%") OR '+

                '(msr_type LIKE "% '+slA[i]+'%") OR '+
                '(msr_type LIKE "% '+slA[i]+' %") OR '+
                '(msr_type LIKE "% '+slA[i]+'!%") OR '+
                '(msr_type LIKE "% '+slA[i]+'.%") OR '+
                '(msr_type LIKE "% '+slA[i]+',%") OR '+
                '(msr_type LIKE "% '+slA[i]+'-%") OR '+
                '(msr_type LIKE "% '+slA[i]+'!%") OR '+
                '(msr_type LIKE "% '+slA[i]+'?%") OR '+
                '(msr_type LIKE "% '+slA[i]+':%") OR '+
                '(msr_type LIKE "% '+slA[i]+';%") OR '+

                '(msr_name LIKE "% '+slA[i]+'%") OR '+
                '(msr_name LIKE "% '+slA[i]+' %") OR '+
                '(msr_name LIKE "% '+slA[i]+'!%") OR '+
                '(msr_name LIKE "% '+slA[i]+'.%") OR '+
                '(msr_name LIKE "% '+slA[i]+',%") OR '+
                '(msr_name LIKE "% '+slA[i]+'-%") OR '+
                '(msr_name LIKE "% '+slA[i]+'!%") OR '+
                '(msr_name LIKE "% '+slA[i]+'?%") OR '+
                '(msr_name LIKE "% '+slA[i]+':%") OR '+
                '(msr_name LIKE "% '+slA[i]+';%") OR '+

                '(msr_author LIKE "% '+slA[i]+'%") OR '+
                '(msr_author LIKE "% '+slA[i]+' %") OR '+
                '(msr_author LIKE "% '+slA[i]+'!%") OR '+
                '(msr_author LIKE "% '+slA[i]+'.%") OR '+
                '(msr_author LIKE "% '+slA[i]+',%") OR '+
                '(msr_author LIKE "% '+slA[i]+'-%") OR '+
                '(msr_author LIKE "% '+slA[i]+'!%") OR '+
                '(msr_author LIKE "% '+slA[i]+'?%") OR '+
                '(msr_author LIKE "% '+slA[i]+':%") OR '+
                '(msr_author LIKE "% '+slA[i]+';%") OR '+

                '(msr_producer LIKE "% '+slA[i]+'%") OR '+
                '(msr_producer LIKE "% '+slA[i]+' %") OR '+
                '(msr_producer LIKE "% '+slA[i]+'!%") OR '+
                '(msr_producer LIKE "% '+slA[i]+'.%") OR '+
                '(msr_producer LIKE "% '+slA[i]+',%") OR '+
                '(msr_producer LIKE "% '+slA[i]+'-%") OR '+
                '(msr_producer LIKE "% '+slA[i]+'!%") OR '+
                '(msr_producer LIKE "% '+slA[i]+'?%") OR '+
                '(msr_producer LIKE "% '+slA[i]+':%") OR '+
                '(msr_producer LIKE "% '+slA[i]+';%") OR '+

                '(msr_performer LIKE "% '+slA[i]+'%") OR '+
                '(msr_performer LIKE "% '+slA[i]+' %") OR '+
                '(msr_performer LIKE "% '+slA[i]+'!%") OR '+
                '(msr_performer LIKE "% '+slA[i]+'.%") OR '+
                '(msr_performer LIKE "% '+slA[i]+',%") OR '+
                '(msr_performer LIKE "% '+slA[i]+'-%") OR '+
                '(msr_performer LIKE "% '+slA[i]+'!%") OR '+
                '(msr_performer LIKE "% '+slA[i]+'?%") OR '+
                '(msr_performer LIKE "% '+slA[i]+':%") OR '+
                '(msr_performer LIKE "% '+slA[i]+';%") OR '+

                '(msr_organizer LIKE "% '+slA[i]+'%") OR '+
                '(msr_organizer LIKE "% '+slA[i]+' %") OR '+
                '(msr_organizer LIKE "% '+slA[i]+'!%") OR '+
                '(msr_organizer LIKE "% '+slA[i]+'.%") OR '+
                '(msr_organizer LIKE "% '+slA[i]+',%") OR '+
                '(msr_organizer LIKE "% '+slA[i]+'-%") OR '+
                '(msr_organizer LIKE "% '+slA[i]+'!%") OR '+
                '(msr_organizer LIKE "% '+slA[i]+'?%") OR '+
                '(msr_organizer LIKE "% '+slA[i]+':%") OR '+
                '(msr_organizer LIKE "% '+slA[i]+';%") OR '+

                '(msr_ticket_price LIKE "% '+slA[i]+'%") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+' %") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+'!%") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+'.%") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+',%") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+'-%") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+'!%") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+'?%") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+':%") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+';%") OR '+

                '(msr_other_info LIKE "% '+slA[i]+'%") OR '+
                '(msr_other_info LIKE "% '+slA[i]+' %") OR '+
                '(msr_other_info LIKE "% '+slA[i]+'!%") OR '+
                '(msr_other_info LIKE "% '+slA[i]+'.%") OR '+
                '(msr_other_info LIKE "% '+slA[i]+',%") OR '+
                '(msr_other_info LIKE "% '+slA[i]+'-%") OR '+
                '(msr_other_info LIKE "% '+slA[i]+'!%") OR '+
                '(msr_other_info LIKE "% '+slA[i]+'?%") OR '+
                '(msr_other_info LIKE "% '+slA[i]+':%") OR '+
                '(msr_other_info LIKE "% '+slA[i]+';%") OR '+

                '(phn_comments LIKE "% '+slA[i]+'%") OR '+
                '(phn_comments LIKE "% '+slA[i]+' %") OR '+
                '(phn_comments LIKE "% '+slA[i]+'!%") OR '+
                '(phn_comments LIKE "% '+slA[i]+'.%") OR '+
                '(phn_comments LIKE "% '+slA[i]+',%") OR '+
                '(phn_comments LIKE "% '+slA[i]+'-%") OR '+
                '(phn_comments LIKE "% '+slA[i]+'!%") OR '+
                '(phn_comments LIKE "% '+slA[i]+'?%") OR '+
                '(phn_comments LIKE "% '+slA[i]+':%") OR '+
                '(phn_comments LIKE "% '+slA[i]+';%") OR '+

                '(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(phone),"-","")," ",""),"+",""),"(",""),")","") LIKE "'+slA[i]+'")) ';
              end
            else
              begin
                q1:=q1+'('+
                '(f.name LIKE "% '+slA[i]+'%") OR '+
                '(_org_address LIKE "% '+slA[i]+'%") OR '+
                '(a_s.name LIKE "% '+slA[i]+'%") OR '+
                '(f.house_num LIKE "'+slA[i]+'%") OR '+
                '(f.house_sym LIKE "'+slA[i]+'%") OR '+
                '(CONCAT(f.house_num,f.house_sym) LIKE "%'+slA[i]+'%") OR '+
                '(f.subhouse_num LIKE "'+slA[i]+'%") OR '+
                '(f.subhouse_sym LIKE "'+slA[i]+'%") OR '+
                '(CONCAT(f.subhouse_num,f.subhouse_sym) LIKE "%'+slA[i]+'%") OR '+
                '(f.flat_num LIKE "'+slA[i]+'%") OR '+
                '(f.flat_sym LIKE "'+slA[i]+'%") OR '+
                '(CONCAT(f.flat_num,f.flat_sym) LIKE "%'+slA[i]+'%") OR '+
                '(org_how_to_reach LIKE "% '+slA[i]+'%") OR '+
                '(org_work_time LIKE "% '+slA[i]+'%") OR '+
                '(org_other_info LIKE "% '+slA[i]+'%") OR '+
                '(msr_type LIKE "% '+slA[i]+'%") OR '+
                '(msr_name LIKE "% '+slA[i]+'%") OR '+
                '(msr_author LIKE "% '+slA[i]+'%") OR '+
                '(msr_producer LIKE "% '+slA[i]+'%") OR '+
                '(msr_performer LIKE "% '+slA[i]+'%") OR '+
                '(msr_organizer LIKE "% '+slA[i]+'%") OR '+
                '(msr_ticket_price LIKE "% '+slA[i]+'%") OR '+
                '(msr_other_info LIKE "% '+slA[i]+'%") OR '+
                '(phn_comments LIKE "% '+slA[i]+'%") OR '+
                '(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(phone),"-","")," ",""),"+",""),"(",""),")","") LIKE "'+slA[i]+'")) ';
              end;
          end;
      end;

    while Pos('~~~%',q1)>0  do q1:=StringReplace(q1,'~~~%','',[rfReplaceAll]);
    while Pos('~~~ %',q1)>0 do q1:=StringReplace(q1,'~~~ %',' %',[rfReplaceAll]);
    while Pos('~~~!%',q1)>0 do q1:=StringReplace(q1,'~~~!%','!%',[rfReplaceAll]);
    while Pos('~~~.%',q1)>0 do q1:=StringReplace(q1,'~~~.%','.%',[rfReplaceAll]);
    while Pos('~~~,%',q1)>0 do q1:=StringReplace(q1,'~~~,%',',%',[rfReplaceAll]);
    while Pos('~~~-%',q1)>0 do q1:=StringReplace(q1,'~~~-%','-%',[rfReplaceAll]);
    while Pos('~~~!%',q1)>0 do q1:=StringReplace(q1,'~~~!%','!%',[rfReplaceAll]);
    while Pos('~~~?%',q1)>0 do q1:=StringReplace(q1,'~~~?%','?%',[rfReplaceAll]);
    while Pos('~~~:%',q1)>0 do q1:=StringReplace(q1,'~~~:%',':%',[rfReplaceAll]);
    while Pos('~~~;%',q1)>0 do q1:=StringReplace(q1,'~~~;%',';%',[rfReplaceAll]);
    while Pos('~~~',q1)>0 do q1:=StringReplace(q1,'~~~','',[rfReplaceAll]);
    while Pos('%%',q1)>0 do q1:=StringReplace(q1,'%%','%',[rfReplaceAll]);
	finally
		slA.Free;
	end;
  if q1>'' then
    q:=q+'WHERE '+q1;

  case Configuration.iOrgSortColumn of
    0: q:=q+'GROUP BY x5 ORDER BY x1, x2, a_s.name, x4;';
    1: q:=q+'GROUP BY x5 ORDER BY x1, a_s.name, x2, x4;';
    2: q:=q+'GROUP BY x5 ORDER BY x1, x4, x2, a_s.name;';
  else q:=q+'GROUP BY x5 ORDER BY x1, x2, a_s.name, x4;';
  end;
  s:='cxzasdewq';
  GroupId:=-1;
  LogThis(q,LogGroupGUID,lmtSQL);
  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
    begin
      LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
      ResultSet:=mysql_store_result(MySQLConnectionHandler);
      if ResultSet<>nil then
        begin
          LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
          i:=mysql_num_rows(ResultSet);
          if (i>=0) then
            begin
              ProgressBar1.Max:=i;
              ProgressBar1.Step:=1;
              LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
              lvOrg.Items.BeginUpdate;
              for j:=0 to (i-1) do
                begin
                  if not bError then
                    begin
                      // LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
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
                                SendMessage(lvOrg.Handle, LVM_INSERTGROUP, -1, Longint(@LvGroup));
                              finally
                                FreeMem(pwcGroupName);
                              end;
                            end;
                          // создание элемента
                          if GroupId>-1 then
                            begin
                              ListItem:=lvOrg.Items.Add;
                              ListItem.Caption:=ResultRow[1];
                              // формирование строки адреса
                              s1:='';
//                              if Trim(ResultRow[6])>'' then
//                                begin
//                                  if Trim(ResultRow[6])='МИНСК ОИР' then
//                                    s1:='г. Минск'
//                                  else s1:=Trim(ResultRow[6]);
//                                end;
//                              if Trim(ResultRow[7])>'' then
//                                begin
//                                  if s1>'' then
//                                    begin
//                                      if (Pos('ПРОСПЕКТ',Trim(ResultRow[7]))>0) or
//                                      (Pos('БУЛЬВАР',Trim(ResultRow[7]))>0) or
//                                      (Pos('ПРОЕЗД',Trim(ResultRow[7]))>0) or
//                                      (Pos('ПЕРЕУЛОК',Trim(ResultRow[7]))>0) or
//                                      (Pos('ПОСЕЛОК',Trim(ResultRow[7]))>0) or
//                                      (Pos('ШОССЕ',Trim(ResultRow[7]))>0) or
//                                      (Pos('ТУПИК',Trim(ResultRow[7]))>0) or
//                                      (Pos('ТРАКТ',Trim(ResultRow[7]))>0) or
//                                      (Pos('МИКРОРАЙОН',Trim(ResultRow[7]))>0) or
//                                      (Pos('ПЛОЩАДЬ',Trim(ResultRow[7]))>0) or
//                                      (Pos(' МЕТРО',Trim(ResultRow[7]))>0) or
//                                      (Pos(' КОЛЬЦО',Trim(ResultRow[7]))>0) or
//                                      (Pos('ДЕРЕВНЯ',Trim(ResultRow[7]))>0) then
//                                        s1:=s1+', '
//                                      else s1:=s1+', ул. ';
//                                    end;
//                                  s1:=s1+Trim(ResultRow[7]);
//                                end;
                              if Trim(ResultRow[7])>'' then
                                begin
                                  if (Pos('ПРОСПЕКТ',Trim(ResultRow[7]))>0) or
                                    (Pos('БУЛЬВАР',Trim(ResultRow[7]))>0) or
                                    (Pos('ПРОЕЗД',Trim(ResultRow[7]))>0) or
                                    (Pos('ПЕРЕУЛОК',Trim(ResultRow[7]))>0) or
                                    (Pos('ПОСЕЛОК',Trim(ResultRow[7]))>0) or
                                    (Pos('ШОССЕ',Trim(ResultRow[7]))>0) or
                                    (Pos('ТУПИК',Trim(ResultRow[7]))>0) or
                                    (Pos('ТРАКТ',Trim(ResultRow[7]))>0) or
                                    (Pos('МИКРОРАЙОН',Trim(ResultRow[7]))>0) or
                                    (Pos('ПЛОЩАДЬ',Trim(ResultRow[7]))>0) or
                                    (Pos(' МЕТРО',Trim(ResultRow[7]))>0) or
                                    (Pos(' КОЛЬЦО',Trim(ResultRow[7]))>0) or
                                    (Pos('ДЕРЕВНЯ',Trim(ResultRow[7]))>0) then
                                      begin
                                        s1:=s1+Trim(ResultRow[7]);
                                        s1:=StringReplace(s1,' ПРОСПЕКТ',' ПР-Т',[rfReplaceAll]);
                                        s1:=StringReplace(s1,' ПЛОЩАДЬ',' ПЛ.',[rfReplaceAll]);
                                        s1:=StringReplace(s1,' ПРОЕЗД',' ПР-Д',[rfReplaceAll]);
                                      end
                                    else s1:=s1+'ул. '+Trim(ResultRow[7]);
                                end;
                              if ((Trim(ResultRow[8])>'') and (Trim(ResultRow[8])<>'0')) or (Trim(ResultRow[9])>'') then
                                begin
                                  if s1>'' then
                                    s1:=s1+', д. ';
                                  s1:=s1+Trim(ResultRow[8])+Trim(ResultRow[9]);
                                end;
                              if ((Trim(ResultRow[10])>'') and (Trim(ResultRow[10])<>'0')) or (Trim(ResultRow[11])>'') then
                                begin
                                  if s1>'' then
                                    s1:=s1+', корп. ';
                                  s1:=s1+Trim(ResultRow[10])+Trim(ResultRow[11]);
                                end;
                              if ((Trim(ResultRow[12])>'') and (Trim(ResultRow[12])<>'0')) or (Trim(ResultRow[13])>'') then
                                begin
                                  if s1>'' then
                                    s1:=s1+', кв. ';
                                  s1:=s1+Trim(ResultRow[12])+Trim(ResultRow[13]);
                                end;
                              if Configuration.bPutTownAtTheEnd then
                                begin
                                  if s1>'' then
                                    begin
                                      if Trim(ResultRow[6])>'' then
                                        begin
                                          if Trim(ResultRow[6])='МИНСК ОИР' then
                                            s1:=s1+', г. Минск'
                                          else s1:=s1+', '+Trim(ResultRow[6]);
                                        end;
                                    end;
                                end
                              else
                                begin
                                  if s1>'' then
                                    begin
                                      if Trim(ResultRow[6])>'' then
                                        begin
                                          if Trim(ResultRow[6])='МИНСК ОИР' then
                                            s1:='г. Минск, '+s1
                                          else s1:=Trim(ResultRow[6])+', '+s1;
                                        end;
                                    end;
                                end;

                              if Trim(ResultRow[2])>'' then
                                begin
                                  if s1>'' then
                                    s1:=s1+' [ '+Trim(ResultRow[2])+' ]'
                                  else s1:=s1+'[ '+Trim(ResultRow[2])+' ]';
                                end;
                              ListItem.SubItems.Add(s1);
                              if ResultRow[3]='0' then
                                ListItem.SubItems.Add('-')
                              else ListItem.SubItems.Add('+');
                              //else ListItem.SubItems.Add(ResultRow[3]);
                              ListItem.SubItems.Add(ResultRow[4]);
                              if (ResultRow[5]='1') then
                                ListItem.ImageIndex:=DELETEDICON_ID
                              else
                                if (ResultRow[5]='0') then
                                  ListItem.ImageIndex:=EXISTINGICON_ID
                                else ListItem.ImageIndex:=UNKNOWNICON_ID;
                              with LvItemA do
                                begin
                                  FillChar(LvItemA, SizeOf(TLvItemA), 0);
                                  mask:=LVIF_GROUPID;
                                  iItem:=ListItem.Index;
                                  iGroupId:=GroupId;
                                end;
                              SendMessage(lvOrg.Handle, LVM_SETITEM, 0, Longint(@LvItemA));
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
              lvOrg.Items.EndUpdate;
//              lvOrg.OnResize(nil);
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
          LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
          mysql_free_result(ResultSet);
        end;
    end
  else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  lvOrgResize(Sender);
  if not bError then
    begin
      blvOrgRedrawNow:=False; // перерисовка окна результатов поиска отключена
      TryToSet_lvOrg_Focused;
      if Sender<>nil then // если функция была вызвана из другой, а не по нажатию
        begin
          if lvOrg.Items.Count>0 then
            begin
              lvOrg.ItemIndex:=lvOrg.Items.IndexOf(lvOrg.TopItem);
              lvOrg.ItemFocused:=lvOrg.TopItem;
            end
          else
            begin
              lvMsr.Items.BeginUpdate;
              SendMessage(lvMsr.Handle, LVM_REMOVEALLGROUPS, 0, 0);
              SendMessage(lvMsr.Handle, LVM_DELETEALLITEMS, 0, 0);
              lvMsr.Items.EndUpdate;
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
              //очистка значений контролов
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
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  Update_PhonesMark;
  Update_OrgListCaption;
  Update_MsrListCaption;
	SetReady(LogGroupGUID);
end;

procedure TMainForm.lvMsrSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  s, q: AnsiString;
  bError: boolean;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
  msA: TMemoryStream;
  i: integer;
  i_msr_id: integer;
  iSelStart, iSelLenght: integer;
  sMsrType, sMsrName, sMsrAuthor, sMsrProducer, sMsrPerformer, sMsrOrganizer, sMsrTicketPrice: string;
  bMsrIsPremier, bMsrIsTour, bMsrForChildren, bMsrForTeenagers, bMsrForAdultsOnly, bMsrUnknownDuration: boolean;
  sMarks, sStartDateTime, sStopDateTime, sDuration: string;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{61FED36B-8576-46C3-A916-6AF4EA07B7B5}';
	bError:=False;
  ResultSet:=nil;
  if not blvMsrRedrawNow then // для ускорения составления списка после выборки
    begin
      // обновление значений панели создания/модификации
      lblCreationCaption.Visible:=(lvMsr.Selected<>nil);
      lblCreation.Visible:=(lvMsr.Selected<>nil);
      lblModificationCaption.Visible:=(lvMsr.Selected<>nil);
      lblModification.Visible:=(lvMsr.Selected<>nil);
      // обновление значений панели идентификатора
      if pnlID.Visible then
        begin
          lblIDCaption.Visible:=(lvMsr.Selected<>nil);
          lblID.Visible:=(lvMsr.Selected<>nil);
        end;
      Update_Actions;
      if lvMsr.Selected<>nil then
        begin
          SendMessage(lvMsr.Handle, LVM_ENSUREVISIBLE, lvMsr.Selected.Index, 0);
          i_msr_id:=StrToIntDef(lvMsr.Selected.SubItems[2],-1);
          if i_msr_id>-1 then
            LogThis('Попытка получения данных мероприятия (ID#'+IntToStr(i_msr_id)+').',LogGroupGUID,lmtInfo)
          else
            begin
              s:='Возникла ошибка в процессе получения ID мероприятия-владельца!';
              bError:=True;
            end;
          if not bError then
            begin
              //очистка значений контролов
              lblId.Caption:='';
              lblCreation.Caption:='';
              lblModification.Caption:='';
			        cmbbxMsrType.Clear;
			        edbxMsrType.Clear;
			        edbxMsrName.Clear;
              cmbbxMsrAuthor.Clear;
              edbxMsrAuthor.Clear;
              cmbbxMsrProducer.Clear;
              edbxMsrProducer.Clear;
              cmbbxMsrPerformer.Clear;
              edbxMsrPerformer.Clear;
              cmbbxMsrOrganizer.Clear;
              edbxMsrOrganizer.Clear;
              chkbxMsrStart.Checked:=False;
              chkbxMsrStop.Checked:=False;
              dtpMsrStartDate.Date:=Date;
              dtpMsrStartTime.Time:=EncodeTime(0,0,0,0);
              dtpMsrStopDate.Date:=Date;
              dtpMsrStopTime.Time:=EncodeTime(0,0,0,0);
              meMsrTicketPrice.Clear;
			        reMsrOtherInfo.Clear;
              SetDefaultSettings(reMsrOtherInfo);
			        q:='SELECT msr_type, msr_name, msr_author, msr_producer, msr_performer, msr_organizer, '+
              'date_format(msr_start_datetime,"%d.%m.%Y"), date_format(msr_start_datetime,"%T"), '+
              'date_format(msr_stop_datetime,"%d.%m.%Y"), date_format(msr_stop_datetime,"%T"), '+
              'msr_is_premier, msr_is_tour, msr_for_children, msr_for_teenagers, msr_for_adults_only, '+
              'msr_ticket_price, msr_other_info, msr_other_info_rtf, '+
              'date_format(msr_created_at,"%d.%m.%Y %T"), uc.usr_fullname, date_format(msr_modified_at,"%d.%m.%Y %T"), um.usr_fullname, msr_unknown_duration '+
              'FROM '+Configuration.sMySQLDatabase+'._msr LEFT JOIN '+Configuration.sMySQLDatabase+'._usr uc ON uc.usr_id=msr_created_by_user_id LEFT JOIN '+Configuration.sMySQLDatabase+'._usr um ON um.usr_id=msr_modified_by_user_id '+
              'WHERE msr_id='+IntToStr(i_msr_id)+';';
			        LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
		            begin
			            LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			            ResultSet:=mysql_store_result(MySQLConnectionHandler);
			            if ResultSet<>nil then
				            begin
					            LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					            i:=mysql_num_rows(ResultSet);
                      LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                      if (i=1) then
						            begin
                          ProgressBar1.Max:=i;
                          ProgressBar1.Step:=1;
									        LogThis('Попытка получения строки выборки.',LogGroupGUID,lmtInfo);
                          ResultRow:=mysql_fetch_row(ResultSet);
									        if ResultRow<>nil then
                            begin
                              sMsrType:=ResultRow[0];
                              sMsrName:=ResultRow[1];
                              sMsrAuthor:=ResultRow[2];
                              sMsrProducer:=ResultRow[3];
                              sMsrPerformer:=ResultRow[4];
                              sMsrOrganizer:=ResultRow[5];
                              sMsrTicketPrice:=StringReplace(ResultRow[15],'<BR>',#13#10,[rfReplaceAll]);
                              bMsrIsPremier:=ResultRow[10]='1';
                              bMsrIsTour:=ResultRow[11]='1';
                              bMsrForChildren:=ResultRow[12]='1';
                              bMsrForTeenagers:=ResultRow[13]='1';
                              bMsrForAdultsOnly:=ResultRow[14]='1';
                              bMsrUnknownDuration:=ResultRow[22]='1';

                              lblID.Caption:=IntToStr(i_msr_id);
                              lblCreation.Caption:=ResultRow[19]+', '+ResultRow[18];
                              lblModification.Caption:=ResultRow[21]+', '+ResultRow[20];

                              cmbbxMsrType.ItemIndex:=cmbbxMsrType.Items.Add(sMsrType);
                              edbxMsrType.Text:=sMsrType;
                              edbxMsrName.Text:=sMsrName;
                              cmbbxMsrAuthor.ItemIndex:=cmbbxMsrAuthor.Items.Add(sMsrAuthor);
                              edbxMsrAuthor.Text:=sMsrAuthor;
                              cmbbxMsrProducer.ItemIndex:=cmbbxMsrProducer.Items.Add(sMsrProducer);
                              edbxMsrProducer.Text:=sMsrProducer;
                              cmbbxMsrPerformer.ItemIndex:=cmbbxMsrPerformer.Items.Add(sMsrPerformer);
                              edbxMsrPerformer.Text:=sMsrPerformer;
                              cmbbxMsrOrganizer.ItemIndex:=cmbbxMsrOrganizer.Items.Add(sMsrOrganizer);
                              edbxMsrOrganizer.Text:=sMsrOrganizer;
                              if (Length(ResultRow[6])>0) then
                                dtpMsrStartDate.Date:=StrToDate(ResultRow[6]);
                              if (Length(ResultRow[7])>0) then
                                dtpMsrStartTime.Time:=StrToTime(ResultRow[7]);
                              chkbxMsrStart.Checked:=(Length(ResultRow[6])>0) and (Length(ResultRow[7])>0);
                              if (Length(ResultRow[8])>0) then
                                dtpMsrStopDate.Date:=StrToDate(ResultRow[8]);
                              if (Length(ResultRow[9])>0) then
                                dtpMsrStopTime.Time:=StrToTime(ResultRow[9]);
											        chkbxMsrStop.Checked:=(Length(ResultRow[8])>0) and (Length(ResultRow[9])>0);
                              chkbxMsrIsPremier.Checked:=bMsrIsPremier;
                              chkbxMsrIsTour.Checked:=bMsrIsTour;
                              chkbxMsrForChildren.Checked:=bMsrForChildren;
                              chkbxMsrForTeenagers.Checked:=bMsrForTeenagers;
                              chkbxMsrForAdultsOnly.Checked:=bMsrForAdultsOnly;
                              chkbxMsrUnknownDuration.Checked:=bMsrUnknownDuration;
                              meMsrTicketPrice.Text:=sMsrTicketPrice;
                              Application.ProcessMessages;
                              reMsrOtherInfo.Lines.BeginUpdate;
                              if Length(ResultRow[17])=0 then
                                begin
                                  if ResultRow[16]<>'' then
                                    begin
                                      s:=ResultRow[16];
                                      s:=s+' ';
                                      HTMLtoRTF(s,reMsrOtherInfo);
                                    end;
                                end
                              else
                                begin
													        msA:=TMemoryStream.Create;
                                  try
                                    i:=StrLen(ResultRow[17]);
                                    msA.SetSize(i);
                                    msA.Seek(0, soFromBeginning);
                                    msA.Write(ResultRow[17]^,i);
                                    msA.Seek(0, soFromBeginning);
                                    reMsrOtherInfo.Lines.LoadFromStream(msA);
                                  finally
                                    msA.Free;
                                  end;
                                end;
                              if Configuration.bShowDataInOtherInfoPanel and (not CurrentUser.bDBEdition) then
                                begin
                                  sMarks:='';
                                  if bMsrIsPremier then
                                    begin
                                      if sMarks>'' then
                                        sMarks:=sMarks+', ';
                                      sMarks:=sMarks+'премьера';
                                    end;
                                  if bMsrIsTour then
                                    begin
                                      if sMarks>'' then
                                        sMarks:=sMarks+', ';
                                      sMarks:=sMarks+'гастроли';
                                    end;
                                  if bMsrForChildren then
                                    begin
                                      if sMarks>'' then
                                        sMarks:=sMarks+', ';
                                      sMarks:=sMarks+'детское';
                                    end;
                                  if bMsrForTeenagers then
                                    begin
                                      if sMarks>'' then
                                        sMarks:=sMarks+', ';
                                      sMarks:=sMarks+'подростковое';
                                    end;
                                  if bMsrForAdultsOnly then
                                    begin
                                      if sMarks>'' then
                                        sMarks:=sMarks+', ';
                                      sMarks:=sMarks+'только для взрослых';
                                    end;

                                  sDuration:='';
                                  if spedMsrDurationDays.Value>0 then
                                    begin
                                      if sDuration>'' then
                                        sDuration:=sDuration+', ';
                                      sDuration:=sDuration+IntToStr(spedMsrDurationDays.Value)+' '+lblMsrDurationDays.Caption;
                                    end;
                                  if spedMsrDurationHours.Value>0 then
                                    begin
                                      if sDuration>'' then
                                        sDuration:=sDuration+', ';
                                      sDuration:=sDuration+IntToStr(spedMsrDurationHours.Value)+' '+lblMsrDurationHours.Caption;
                                    end;
                                  if spedMsrDurationMinutes.Value>0 then
                                    begin
                                      if sDuration>'' then
                                        sDuration:=sDuration+', ';
                                      sDuration:=sDuration+IntToStr(spedMsrDurationMinutes.Value)+' '+lblMsrDurationMinutes.Caption;
                                    end;

                                  sStartDateTime:='';
                                  if (Length(ResultRow[6])>0) then
                                    sStartDateTime:=sStartDateTime+ResultRow[6];
                                  if (Length(ResultRow[7])>0) then
                                    begin
                                      if sStartDateTime>'' then
                                        sStartDateTime:=sStartDateTime+' ';
                                      sStartDateTime:=sStartDateTime+ResultRow[7];
                                    end;

                                  sStopDateTime:='';
                                  if (Length(ResultRow[8])>0) then
                                    sStopDateTime:=sStopDateTime+ResultRow[8];
                                  if (Length(ResultRow[9])>0) then
                                    begin
                                      if sStopDateTime>'' then
                                        sStopDateTime:=sStopDateTime+' ';
                                      sStopDateTime:=sStopDateTime+ResultRow[9];
                                    end;

                                  // принцип таков
                                  // ставим курсор в самое начало и назинаем добавлять строки задом наперёд каждый раз в начало текста
                                  reMsrOtherInfo.SelStart:=0;
                                  reMsrOtherInfo.SelLength:=0;
                                  reMsrOtherInfo.Lines.Insert(0,#09+#09+#09+#09+#09+#09);
                                  reMsrOtherInfo.SelStart:=0;
                                  reMsrOtherInfo.SelLength:=Length(#09+#09+#09+#09+#09+#09);
                                  SetDefaultSettings(reMsrOtherInfo);
                                  reMsrOtherInfo.SelAttributes.Style:=[fsUnderline];

                                  a1(sMarks, Trim(gpbxMsrFlags.Caption), reMsrOtherInfo); // пометки
                                  if bMsrUnknownDuration then
                                    a1('неизвестная', Trim(gpbxMsrDuration.Caption), reMsrOtherInfo) // длительность
                                  else a1(sDuration, Trim(gpbxMsrDuration.Caption), reMsrOtherInfo); // длительность
                                  a1(sStopDateTime, 'Окончание мероприятия', reMsrOtherInfo); // окончание
                                  a1(sStartDateTime, 'Начало мероприятия', reMsrOtherInfo); // начало
                                  a1(sMsrTicketPrice, Trim(lblMsrTicketPrice.Caption), reMsrOtherInfo); // стоимость
                                  a1(sMsrOrganizer, lblMsrOrganizer.Caption, reMsrOtherInfo); // организатор
                                  a1(sMsrPerformer, lblMsrPerformer.Caption, reMsrOtherInfo); // исполнитель
                                  a1(sMsrProducer, lblMsrProducer.Caption, reMsrOtherInfo); // режиссер
                                  a1(sMsrAuthor, lblMsrAuthor.Caption, reMsrOtherInfo); // автор
                                  a1(sMsrName, lblMsrName.Caption, reMsrOtherInfo); // наименование
                                  a1(sMsrType, lblMsrType.Caption, reMsrOtherInfo); // тип
                                end;
                              if Configuration.bMarkSearchedStrings and (not CurrentUser.bDBEdition) then
                                MarkSearchedTextInRichEdit(edbxSearchName.Text, reMsrOtherInfo);
                              reMsrOtherInfo.WordWrap:=False;
                              reMsrOtherInfo.WordWrap:=True;
                              reMsrOtherInfo.Lines.EndUpdate;
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
                  LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
                  mysql_free_result(ResultSet);
                end;
              ProgressBar1.Position:=ProgressBar1.Min;
            end;
  	      Screen.Cursor:=crDefault;
  	      if bError then
  		      begin
  			      LogThis(s,LogGroupGUID,lmtError);
              pnlEdit.Visible:=False;
              PageControl1.ActivePage:=tsClear;
  			      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else
            begin
              // обновление значений панели данных
              pnlEdit.Visible:=CurrentUser.bDBEdition;
              if CurrentUser.bDBEdition then
                begin
                  Panel10.Visible:=True;
                  pnlMesureGeneralInfo.Visible:=True;
                end
              else
                begin
                  Panel10.Visible:=not Configuration.bShowDataInOtherInfoPanel;
                  pnlMesureGeneralInfo.Visible:=not Configuration.bShowDataInOtherInfoPanel;
                end;
              PageControl1.ActivePage:=tsMsr;
            end;
        end
      else
        begin
          pnlEdit.Visible:=False;
          PageControl1.ActivePage:=tsClear;
        end;
    end;
  Update_PhonesMark;
  Update_MsrListCaption;
end;

procedure TMainForm.SaveModifyMsr;
var
  s: string;
  q, sRTF, sPlane: AnsiString;
	RTFStream: TMemoryStream;
	pac: PAnsiChar;
  bError: boolean;
  i, iLastID, iOrgID, iMsrID: integer;
  tp: TPoint;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{2628A6CA-1EA8-4563-9CA9-BA0D6D41D1DD}';
  sRTF:='';
  sPlane:='';
  bError:=False;
//  iOrgID:=-1;
  iMsrID:=-1;
  ProgressBar1.Step:=1;
  // подготовка данных для сохранения
  // получение ID выделенной организации/мероприятия
  // составление запроса на добавление / редактирование мероприятия
  // добавление мероприятия с получением ID добавленного мероприятия
  // обновление данных в таблице фирм
  // обновление списка мероприятий
  // обновление значения количества мероприятий в выделенной организации
  // если добавленное мероприятие есть в списке - установить курсор на него если нет - установить курсор на первое сверху мероприятие
  if PageControl1.ActivePage=tsMsr then
    begin
      ProgressBar1.Max:=5;
      // подготовка данных для сохранения
      cmbbxMsrType.Text:=ValidateString(cmbbxMsrType.Text);
      edbxMsrName.Text:=ValidateString(edbxMsrName.Text);
      cmbbxMsrAuthor.Text:=ValidateString(cmbbxMsrAuthor.Text);
      cmbbxMsrProducer.Text:=ValidateString(cmbbxMsrProducer.Text);
      cmbbxMsrPerformer.Text:=ValidateString(cmbbxMsrPerformer.Text);
      cmbbxMsrOrganizer.Text:=ValidateString(cmbbxMsrOrganizer.Text);
      meMsrTicketPrice.Text:=ValidateString(meMsrTicketPrice.Text);
      sPlane:=ValidateString(reMsrOtherInfo.Text);
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // получение ID выделенной организации/мероприятия
      if bAddingMsrNow then
        begin
          if lvOrg.Selected<>nil then // определяем ID организации
            begin
              iOrgID:=StrToIntDef(lvOrg.Selected.SubItems[2],-1); // сохранение значения ID выделенной организации
              if iOrgID>=0 then
                LogThis('Производится добавление нового мероприятия для организации с ID='+IntToStr(iOrgID)+'.',LogGroupGUID,lmtInfo)
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
              SetReady(LogGroupGUID);
              Exit;
            end;
        end
      else
        begin
          if lvOrg.Selected<>nil then // определяем ID организации
            begin
              iOrgID:=StrToIntDef(lvOrg.Selected.SubItems[2],-1); // сохранение значения ID выделенной организации
              if iOrgID>=0 then
                LogThis('Производится редактирование мероприятия принадлежащего организации с ID='+IntToStr(iOrgID)+'.',LogGroupGUID,lmtInfo)
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
              SetReady(LogGroupGUID);
              Exit;
            end;
          if lvMsr.Selected<>nil then // определяем ID редактируемого мероприятия
            begin
              iMsrID:=StrToIntDef(lvMsr.Selected.SubItems[2],-1); // сохранение значения ID выделенного мероприятия
              if iMsrID>=0 then
                begin
                  LogThis('Производится внесение изменений в данные мероприятия с ID='+IntToStr(iMsrID)+'.',LogGroupGUID,lmtInfo);
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
              SetReady(LogGroupGUID);
              Exit;
            end;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s,LogGroupGUID,lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady(LogGroupGUID);
        end;

      // составление запроса на добавление / редактирование мероприятия
      if not bError then
        begin
          if bAddingMsrNow then
            begin
              q:='INSERT INTO '+Configuration.sMySQLDatabase+'._msr (msr_id, msr_erased, msr_start_datetime, msr_stop_datetime, msr_unknown_duration, _msr_duration, msr_organization_id, ';
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
              q:=q+'"'+IntToStr(integer(chkbxMsrUnknownDuration.Checked))+'", '+ // msr_unknown_duration
              'NULL, '+IntToStr(iOrgID)+', '+ // _msr_duration, msr_organization_id
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
		                reMsrOtherInfo.Lines.SaveToStream(RTFStream);
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
              q:='UPDATE '+Configuration.sMySQLDatabase+'._msr SET ';
              if chkbxMsrStart.Checked then
                q:=q+'msr_start_datetime="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStartDate.DateTime)+'", '
              else q:=q+'msr_start_datetime=NULL, ';
              if chkbxMsrStop.Checked then
                q:=q+'msr_stop_datetime="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpMsrStopDate.DateTime)+'", '
              else q:=q+'msr_stop_datetime=NULL, ';
              q:=q+'msr_unknown_duration="'+IntToStr(integer(chkbxMsrUnknownDuration.Checked))+'", '+ // msr_unknown_duration
              'msr_is_premier="'+IntToStr(integer(chkbxMsrIsPremier.Checked))+'", '+
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
		                reMsrOtherInfo.Lines.SaveToStream(RTFStream);
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

      LogThis(q,LogGroupGUID,lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
          iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной записи
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
          if (i=1) then
            begin
              if bAddingMsrNow then
                begin
                  iMsrID:=iLastID; // сохранение ID вставленной записи
                  LogThis('Добавление данных о новом мероприятии произведено успешно.',LogGroupGUID,lmtInfo);
                end
              else LogThis('Редактирование данных мероприятия произведено успешно.',LogGroupGUID,lmtInfo);
              // запись статистики в БД
              LogThis('Внесение записи в таблицу событий.',LogGroupGUID,lmtInfo);
              if bAddingMsrNow then
                q:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"INS","msr",'+IntToStr(iMsrID)+','+CurrentUser.sID+','+#39+q+#39+');'
              else q:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"MOD","msr",'+IntToStr(iMsrID)+','+CurrentUser.sID+','+#39+q+#39+');';
              LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                  if (i=1) then
                    LogThis('Запись в таблицу событий внесена успешно.',LogGroupGUID,lmtInfo)
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
          LogThis(s,LogGroupGUID,lmtError);
          ProgressBar1.Position:=ProgressBar1.Min;
          Screen.Cursor:=crDefault;
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          SetReady(LogGroupGUID);
        end;
      bAddingMsrNow:=False;

      btbtnSearchClick(nil); // когда допишу формирование запроса на основе усправляющих элементов, тогда нужно заменить код полной копией

      lvOrg.Items.BeginUpdate;
      for i:=0 to lvOrg.Items.Count-1 do
        if lvOrg.Items[i]<>nil then
          begin
            if lvOrg.Items[i].SubItems[2]=IntToStr(iOrgID) then
              begin
                lvOrg.ItemIndex:=i;
                lvOrg.ItemFocused:=lvOrg.Items.Item[i];
                tp:=lvOrg.ItemFocused.GetPosition;
                lvOrg.Scroll(tp.X,tp.Y-23);
                lvOrg.ItemFocused.MakeVisible(False);
              end;
          end;
      lvOrg.Items.EndUpdate;
      lvMsr.Items.BeginUpdate;
      for i:=0 to lvMsr.Items.Count-1 do
        if lvMsr.Items[i]<>nil then
          begin
            if lvMsr.Items[i].SubItems[2]=IntToStr(iMsrID) then
              begin
                lvMsr.ItemIndex:=i;
                lvMsr.ItemFocused:=lvMsr.Items.Item[i];
                tp:=lvMsr.ItemFocused.GetPosition;
                lvMsr.Scroll(tp.X,tp.Y-23);
                lvMsr.ItemFocused.MakeVisible(False);
                TryToSet_lvMsr_Focused;
              end;
          end;
      lvMsr.Items.EndUpdate;
    end;
  ProgressBar1.StepIt;
  Application.ProcessMessages;
  ProgressBar1.Position:=ProgressBar1.Min;

end;

procedure TMainForm.btnSaveClick(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{A007C1F4-62E1-4DB7-929B-7B6907F1ABBB}';
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  if (PageControl1.ActivePage=tsOrg) or (PageControl1.ActivePage=tsMsr) then
    begin
      if PageControl1.ActivePage=tsOrg then
        SaveModifyOrg;
      if PageControl1.ActivePage=tsMsr then
        SaveModifyMsr;
    end;
  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
end;

procedure TMainForm.SaveModifyOrg;
var
  s: string;
  q, sRTF, sPlane: AnsiString;
	RTFStream: TMemoryStream;
	pac: PAnsiChar;
  bError: boolean;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
  i, iLastID, iOrgID, city_id, street_id, org_firm_code: integer;
  house_num, subhouse_num, flat_num: integer;
  house_sym, subhouse_sym, flat_sym: string;
  tp: TPoint;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{39FCA825-7ACE-4965-B6D5-731FCF0B2140}';
  Screen.Cursor:=crHourGlass;
  sRTF:='';
  sPlane:='';
  bError:=False;
  iOrgID:=-1;
  org_firm_code:=-1;
  city_id:=-1;
  street_id:=-1;
  ProgressBar1.Step:=1;
  // получение ID города
  // получение / добавление ID улицы
  // получение / добавление ID org_firm_code
  // составление запроса на добавление / редактирование организации
  // добавление организации с получением ID добавленной организации
  // обновление данных в таблице фирм
  // обновление списка организаций
  // если добавленная есть в списке - установить курсор на неё, если нет - установить курсор на первой сверху организации
  if PageControl1.ActivePage=tsOrg then
    begin
      if bAddingOrgNow then
        begin
          LogThis('Производится добавление новой организации.',LogGroupGUID,lmtInfo);
          ProgressBar1.Max:=9;
        end
      else
        begin
          if lvOrg.Selected<>nil then // определяем ID организации
            begin
              iOrgID:=StrToIntDef(lvOrg.Selected.SubItems[2],-1); // сохранение значения ID выделенной организации
              if iOrgID>=0 then
                LogThis('Производится внесение изменений в данные организации с ID='+IntToStr(iOrgID)+'.',LogGroupGUID,lmtInfo)
              else
                begin
                  s:='Возникла ошибка при получении ID редактируемой организации!';
                  Application.ProcessMessages;
                  LogThis(s,LogGroupGUID,lmtError);
                  ProgressBar1.Position:=ProgressBar1.Min;
                  Screen.Cursor:=crDefault;
                  MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                  SetReady(LogGroupGUID);
                  Exit;
                end;
            end
          else
            begin
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady(LogGroupGUID);
              Exit;
            end;
          ProgressBar1.Max:=9;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // подготовка информации полей редактирования организации для сохранения
      if not bError then
        begin
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
          sPlane:=ValidateString(reOrgOtherInfo.Text);
          DivideNumberAndSymbolParts(Trim(edbxOrgHouse.Text), house_num, house_sym); // получаем числовое и символьное значение дома
          DivideNumberAndSymbolParts(Trim(edbxOrgSubHouse.Text), subhouse_num, subhouse_sym); // получаем числовое и символьное значение корпуса
          DivideNumberAndSymbolParts(Trim(edbxOrgFlat.Text), flat_num, flat_sym); // получаем числовое и символьное значение квартиры
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // получение ID города
      if not bError then
        begin
          city_id:=2507;
        end;
      ProgressBar1.StepIt;
      Application.ProcessMessages;

      // получение ID улицы
      if not bError then
        begin
          street_id:=-1;
          q:='SELECT street_id FROM minsk.street WHERE name=UCASE('+NormalizeStringForQuery(cmbbxOrgStreet.Text, True, False)+') ORDER BY street_id;';
          LogThis(q,LogGroupGUID,lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
              ResultSet:=mysql_store_result(MySQLConnectionHandler);
              try
                if ResultSet<>nil then
                  begin
                    LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                    i:=mysql_num_rows(ResultSet);
                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                    if (i>0) then
                      begin
                        LogThis('Попытка получения строки выборки.',LogGroupGUID,lmtInfo);
                        ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow<>nil then
                          begin
                            LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
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
                    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
                    mysql_free_result(ResultSet);
                  end;
              end;
            end
          else
            begin
              s:='Возникла ошибка при выполнении запроса!';
              bError:=True;
            end;
          if bError then
            begin
              Application.ProcessMessages;
              LogThis(s,LogGroupGUID,lmtError);
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              SetReady(LogGroupGUID);
            end
          else
            begin
              ProgressBar1.StepIt;
              Application.ProcessMessages;
            end;
        end;

        
      // добавление ID улицы
      if not bError then
        begin
          // если индекс записи улицы получен неверно, либо улица отсутствует в списке улиц, необходимо провести попытку создания улицы
          if street_id<0 then
            begin
              Screen.Cursor:=crDefault;
              if MessageBox(Handle,PChar('Вы действительно хотите добавить новую улицу "'+NormalizeStringForQuery(cmbbxOrgStreet.Text, True, False)+'" в справочник улиц?'),PChar('OA4 - Подтверждение добавления'),MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK then
                begin
                  Screen.Cursor:=crHourGlass;
                  LogThis('Добавление новой улицы "'+NormalizeStringForQuery(cmbbxOrgStreet.Text, True, False)+'" в справочник улиц подтверждено пользователем.',LogGroupGUID,lmtInfo);
                  q:='INSERT INTO minsk.street (street_id, name, oper, date) VALUES (NULL, UCASE('+NormalizeStringForQuery(cmbbxOrgStreet.Text, True, False)+'), 0, NOW())';
                  LogThis(q,LogGroupGUID,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                  if i=0 then
                    begin
                      LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                      iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной улицы
                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                      if (i=1) then
                        begin
                          LogThis('Добавление новой улицы произведено успешно.',LogGroupGUID,lmtInfo);
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
                end
              else
                begin
                  LogThis('Добавление новой улицы "'+NormalizeStringForQuery(cmbbxOrgStreet.Text, True, False)+'" в справочник улиц отменено пользователем!',LogGroupGUID,lmtWarning);
                  ProgressBar1.Position:=ProgressBar1.Min;
                  Screen.Cursor:=crDefault;
                  Application.ProcessMessages;
                  SetReady(LogGroupGUID);
                  Exit;
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

          if bError then
            begin
              Application.ProcessMessages;
              LogThis(s,LogGroupGUID,lmtError);
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              SetReady(LogGroupGUID);
            end
          else
            begin
              ProgressBar1.StepIt;
              Application.ProcessMessages;
            end;
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
              LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                  iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной фирмы
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                  if (i=1) then
                    begin
                      LogThis('Добавление новой фирмы произведено успешно.',LogGroupGUID,lmtInfo);
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
              q:='SELECT org_firm_code FROM '+Configuration.sMySQLDatabase+'._org WHERE org_id='+IntToStr(iOrgID)+';';
              LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                  ResultSet:=mysql_store_result(MySQLConnectionHandler);
                  try
                    if ResultSet<>nil then
                      begin
                        LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                        i:=mysql_num_rows(ResultSet);
                        LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                        if (i=1) then
                          begin
                            LogThis('Попытка получения строки выборки.',LogGroupGUID,lmtInfo);
                            ResultRow:=mysql_fetch_row(ResultSet);
                            if ResultRow<>nil then
                              begin
                                LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
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
                        LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
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
          if bError then
            begin
              Application.ProcessMessages;
              LogThis(s,LogGroupGUID,lmtError);
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              SetReady(LogGroupGUID);
            end
          else
            begin
              ProgressBar1.StepIt;
              Application.ProcessMessages;
            end;
        end;


      // составление запроса на добавление / редактирование организации
      if not bError then
        begin
          if bAddingOrgNow then
            begin
              q:='INSERT INTO '+Configuration.sMySQLDatabase+'._org (org_id, org_erased, _org_type, _org_name, _org_address, org_firm_code, org_how_to_reach, org_work_time, org_other_info, org_other_info_rtf, org_created_at, org_created_by_user_id, org_modified_at, org_modified_by_user_id) VALUES '+
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
                    reOrgOtherInfo.Lines.SaveToStream(RTFStream);
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
              q:='UPDATE '+Configuration.sMySQLDatabase+'._org SET '+
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
                    reOrgOtherInfo.Lines.SaveToStream(RTFStream);
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
              'WHERE org_id='+IntToStr(iOrgID)+';';
            end;
          Application.ProcessMessages;
          LogThis(q,LogGroupGUID,lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
              iLastID:=mysql_insert_id(MainForm.MySQLConnectionHandler); // сохранение ID вставленной записи
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
              if (i=1) then
                begin
                  if bAddingOrgNow then
                    begin
                      iOrgID:=iLastID; // сохранение ID вставленной записи
                      LogThis('Добавление данных о новой организации произведено успешно.',LogGroupGUID,lmtInfo);
                    end
                  else LogThis('Редактирование данных организации произведено успешно.',LogGroupGUID,lmtInfo);
                  // запись статистики в БД
                  LogThis('Внесение записи в таблицу событий.',LogGroupGUID,lmtInfo);
                  if bAddingOrgNow then
                    q:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"INS","org",'+IntToStr(iOrgID)+','+CurrentUser.sID+','+#39+q+#39+');'
                  else q:='INSERT INTO '+Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"MOD","org",'+IntToStr(iOrgID)+','+CurrentUser.sID+','+#39+q+#39+');';
                  LogThis(q,LogGroupGUID,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                  if i=0 then
                    begin
                      LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                      LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                      if (i=1) then
                        LogThis('Запись в таблицу событий внесена успешно.',LogGroupGUID,lmtInfo)
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
          if bError then
            begin
              Application.ProcessMessages;
              LogThis(s,LogGroupGUID,lmtError);
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              SetReady(LogGroupGUID);
            end
          else
            begin
              ProgressBar1.StepIt;
              Application.ProcessMessages;
            end;
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
          LogThis(q,LogGroupGUID,lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
              if (i=1) then
                LogThis('Постобработка данных записи таблицы фирм произведена успешно.',LogGroupGUID,lmtInfo)
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
          if bError then
            begin
              Application.ProcessMessages;
              LogThis(s,LogGroupGUID,lmtError);
              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
              SetReady(LogGroupGUID);
            end
          else
            begin
              ProgressBar1.StepIt;
              Application.ProcessMessages;
            end;
        end;

      // обновление данных в таблице minsk.otdel
      if not bError then
        begin
          // так как номера телефонов могут быть только у уже существующей в БД организации
          if not bAddingOrgNow then
            begin
              q:='UPDATE minsk.otdel SET '+
              'city_id='+IntToStr(city_id)+', '+
              'street_id='+IntToStr(street_id)+', '+
              'house_num='+IntToStr(house_num)+', '+
              'house_sym='+NormalizeStringForQuery(house_sym, True, False)+', '+
              'subhouse_num='+IntToStr(subhouse_num)+', '+
              'subhouse_sym='+NormalizeStringForQuery(subhouse_sym, True, False)+', '+
              'flat_num='+IntToStr(flat_num)+', '+
              'flat_sym='+NormalizeStringForQuery(flat_sym, True, False)+', '+
              'date=NOW() WHERE firm_code='+IntToStr(org_firm_code)+';';
              LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
                begin
                  LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                  i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
                  LogThis('Количество обработанных строк равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                  if (i>=0) then
                    LogThis('Постобработка данных записей таблицы отделов произведена успешно.',LogGroupGUID,lmtInfo)
                  else
                    begin
                      s:='Количество обработанных строк ('+IntToStr(i)+') не соответствует требуемому!';
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
                  Application.ProcessMessages;
                  LogThis(s,LogGroupGUID,lmtError);
                  ProgressBar1.Position:=ProgressBar1.Min;
                  Screen.Cursor:=crDefault;
                  MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                  SetReady(LogGroupGUID);
                end;
            end;
        end;
      ProgressBar1.StepIt; 
      Application.ProcessMessages;

      bAddingOrgNow:=False;

      btbtnSearchClick(nil); // когда допишу формирование запроса на основе усправляющих элементов, тогда нужно заменить код полной копией

      lvOrg.Items.BeginUpdate;
      for i:=0 to lvOrg.Items.Count-1 do
        if lvOrg.Items[i]<>nil then
          begin
            if lvOrg.Items[i].SubItems[2]=IntToStr(iOrgID) then
              begin
                lvOrg.ItemIndex:=i;
                lvOrg.ItemFocused:=lvOrg.Items.Item[i];
                tp:=lvOrg.ItemFocused.GetPosition;
                lvOrg.Scroll(tp.X,tp.Y-23);
                lvOrg.ItemFocused.MakeVisible(False);
                TryToSet_lvOrg_Focused;
              end;
          end;
      lvOrg.Items.EndUpdate;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  SetReady(LogGroupGUID);
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
  Year,Month,Day: word;
  dtNow: TDateTime;
  iNextMonth, iNextMonthYear: integer;
  Hour, Min, Sec, MSec: word;
  slTemp: TStringList;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{C733B748-AFE6-46CD-9D9C-405D886D752C}';
  SetBusy(LogGroupGUID);
  // инициализация всех переменных
  bError:=False;
  ResultSet:=nil;
  TempPathNameBuffer:=nil;
  TempFileNameBuffer:=nil;
  LogThis('Попытка открытия окна формирования статистики...',LogGroupGUID,lmtInfo);
  ProgressBar1.Position:=ProgressBar1.Min;
  // создание временного списка строк
  slTemp:=TStringList.Create;
  try
    with TStatisticForm.Create(Owner) do
      try
        chklbxUsers.Clear;
        ImageList2.GetIcon(5,Icon);
        btnHelp.Enabled:=Application.HelpFile<>'';
        // получение списка пользователей
        LogThis('Получение списка пользователей...',LogGroupGUID,lmtInfo);
        q:='SELECT DISTINCT usr_fullname FROM '+Configuration.sMySQLDatabase+'._usr WHERE usr_erased="0" ORDER BY usr_fullname;';
        LogThis(q,LogGroupGUID,lmtSQL);
        i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
        if i=0 then
          begin
            LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
            ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
            if ResultSet<>nil then
              begin
                LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                i:=mysql_num_rows(ResultSet);
                if i>0 then
                  begin
                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                    ProgressBar1.Max:=i;
                    ProgressBar1.Step:=1;
                    for j:=0 to i-1 do
                      begin
                        LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',LogGroupGUID,lmtInfo);
                          ResultRow:=mysql_fetch_row(ResultSet);
                        if ResultRow<>nil then
                          begin
                            LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',LogGroupGUID,lmtInfo);
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
                        LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
                        mysql_free_result(ResultSet);
                      end;
                    ProgressBar1.Position:=ProgressBar1.Min;
                    // получение списка годов при помощи выборки из БД
                    LogThis('Получение списка лет (годов)...',LogGroupGUID,lmtInfo);
                    q:='SELECT DISTINCT LEFT(evn_datetime,4) FROM '+Configuration.sMySQLDatabase+'._evn ORDER BY LEFT(evn_datetime,4);';
                    LogThis(q,LogGroupGUID,lmtSQL);
                    i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                    if i=0 then
                      begin
                        LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                        ResultSet:=mysql_store_result(MySQLConnectionHandler);
                        if ResultSet<>nil then
                          begin
                            LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                            i:=mysql_num_rows(ResultSet);
                            if i>0 then
                              begin
                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                                ProgressBar1.Max:=i;
                                ProgressBar1.Step:=1;
                                for j:=0 to i-1 do
                                  begin
                                    LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',LogGroupGUID,lmtInfo);
                                    ResultRow:=mysql_fetch_row(ResultSet);
                                    if ResultRow<>nil then
                                      begin
                                        LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',LogGroupGUID,lmtInfo);
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
            LogThis(s,LogGroupGUID,lmtError);
            MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
          end
        else
          begin
            DecodeDate(Now(),Year,Month,Day);
            cmbbxSelectedMonthMonth.ItemIndex:=Month-1; // список начинается с нуля, поэтому отнимаем единицу
            if cmbbxSelectedMonthYear.Items.Count>0 then
              cmbbxSelectedMonthYear.ItemIndex:=cmbbxSelectedMonthYear.Items.IndexOf(IntToStr(Year));
            if cmbbxSelectedYear.Items.Count>0 then
              cmbbxSelectedYear.ItemIndex:=cmbbxSelectedYear.Items.IndexOf(IntToStr(Year));
          end;
        if ResultSet<>nil then
          begin
            LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
            mysql_free_result(ResultSet);
          end;
        ProgressBar1.Position:=ProgressBar1.Min;
        if Configuration.fpStatisticForm.bCenter then
          Position:=poScreenCenter
        else
          begin
            Position:=poDesigned;
            Top:=Configuration.fpStatisticForm.y;
            Left:=Configuration.fpStatisticForm.x;
          end;
        if bError=False then
          ShowModal;
      finally
        Application.ProcessMessages;
        mr:=ModalResult;
        Configuration.fpStatisticForm.y:=Top;
        Configuration.fpStatisticForm.x:=Left;
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
                sStartDate:=DateToStr(EncodeDate(StrToInt(cmbbxSelectedMonthYear.Items[cmbbxSelectedMonthYear.ItemIndex]),cmbbxSelectedMonthMonth.ItemIndex+1,1));
                // определение следующего месяца
                iNextMonth:=cmbbxSelectedMonthMonth.ItemIndex+2;
                iNextMonthYear:=StrToInt(cmbbxSelectedMonthYear.Items[cmbbxSelectedMonthYear.ItemIndex]);
                if iNextMonth=13 then
                  begin
                    iNextMonth:=1;
                    iNextMonthYear:=iNextMonthYear+1;
                  end;
                sStopDate:=DateToStr(EncodeDate(iNextMonthYear,iNextMonth,1)-(EncodeDate(2004,1,2)-EncodeDate(2004,1,1)));
              end;
            if RadioButton3.Checked then
              begin
                sStartDate:=DateToStr(EncodeDate(StrToInt(cmbbxSelectedYear.Items[cmbbxSelectedYear.ItemIndex]),1,1));
                sStopDate:=DateToStr(EncodeDate(StrToInt(cmbbxSelectedYear.Items[cmbbxSelectedYear.ItemIndex]),12,31));
              end;
            HTML:='<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">'+#13#10;
            HTML:=HTML+'<HTML>'+#13#10;
            HTML:=HTML+'  <HEAD>'+#13#10;
            HTML:=HTML+'    <TITLE>Статистика по работе пользователей АРМ услуги "Отдых и развлечения" за период с '+sStartDate+' по '+sStopDate+'</TITLE>'+#13#10;
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
                HTML:=HTML+'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD></TR>'+#13#10;
                HTML:=HTML+'        <TR><TD COLSPAN="4" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">';
                HTML:=HTML+'Статистика&nbsp;по&nbsp;работе&nbsp;пользователей АРМ&nbsp;&laquo;Отдых&nbsp;и&nbsp;развлечения&raquo; за период с '+sStartDate+' по '+sStopDate+'<BR></TD></TR>'+#13#10;
                // перебираем список отмеченых пользователей
                for k:=0 to chklbxUsers.Count-1 do
                  begin
                    if chklbxUsers.Checked[k] then
                      begin
                        s:=chklbxUsers.Items[k];
                        // выборка данных из базы
                        q:='SELECT LEFT(evn_datetime,10), RIGHT(evn_datetime,8), evn_type, evn_object, evn_object_id, evn_details FROM '+Configuration.sMySQLDatabase+'._evn LEFT JOIN '+Configuration.sMySQLDatabase+'._usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" AND LEFT(evn_datetime,10) BETWEEN "'+Copy(sStartDate,7,4)+'-'+Copy(sStartDate,4,2)+'-'+Copy(sStartDate,0,2)+'" AND "'+Copy(sStopDate,7,4)+'-'+Copy(sStopDate,4,2)+'-'+Copy(sStopDate,0,2)+'" ORDER BY LEFT(evn_datetime,10), RIGHT(evn_datetime,8);';
                        LogThis(q,LogGroupGUID,lmtSQL);
                        i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                        if i=0 then
                          begin
                            LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                            ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                            if ResultSet<>nil then
                              begin
                                LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                                i:=mysql_num_rows(ResultSet);
                                if i>=0 then
                                  begin
                                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
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
                                            LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',LogGroupGUID,lmtInfo);
                                            ResultRow:=mysql_fetch_row(ResultSet);
                                            if ResultRow<>nil then
                                              begin
                                                LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',LogGroupGUID,lmtInfo);
                                                HTML:=HTML+'        <TR>'+#13#10;
                                                HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((i-1)-j)=0))+'px 2px; border-color: black; font-size: 8pt; padding: 2px;">'+Copy(ResultRow[0],9,2)+'.'+Copy(ResultRow[0],6,2)+'.'+Copy(ResultRow[0],0,4)+'</TD>'+#13#10;
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
                                                if ResultRow[3]>'' then
                                                  q:=q+' ';
                                                if StrToIntDef(ResultRow[4],-1)=0 then
                                                  begin
                                                    if ResultRow[3]='msr' then
                                                      q:=q+' группы мероприятий';
                                                  end
                                                else
                                                  begin
                                                    if ResultRow[3]='usr' then
                                                      q:=q+'пользователя';
                                                    if ResultRow[3]='phn' then
                                                      q:=q+'телефона';
                                                    if ResultRow[3]='msg' then
                                                      q:=q+'сообщения';
                                                    if ResultRow[3]='org' then
                                                      q:=q+'организации';
                                                    if ResultRow[3]='msr' then
                                                      q:=q+'мероприятия';
                                                    if StrToIntDef(ResultRow[4],-1)>-1 then
                                                      q:=q+' ID #'+ResultRow[4];
                                                  end;
                                                HTML:=HTML+'          <TD ';
                                                if not chkbxShowSQLQuery.Checked then
                                                  HTML:=HTML+'COLSPAN="2" ';
                                                HTML:=HTML+'STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((i-1)-j)=0))+'px 0px; border-color: black; font-size: 8pt; padding: 2px;">'+q+'</TD>'+#13#10;
                                                if chkbxShowSQLQuery.Checked then
                                                  HTML:=HTML+'          <TD STYLE="text-align: left; border-width: 0px 2px '+IntToStr(1+integer(((i-1)-j)=0))+'px 0px; border-color: black; font-size: 8pt; padding: 2px 2px 2px 5px;">'+ResultRow[5]+'</TD>'+#13#10;



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
                                        HTML:=HTML+'          <TD COLSPAN="4" STYLE="text-align: left; border-width: 0px; border-color: white; font-size: 8pt; padding: 2px 2px 2px 0px;">Данные по работе указанного пользователя отсутствуют.</TD>'+#13#10;
                                        HTML:=HTML+'        </TR>'+#13#10;
                                      end;
                                  end
                                else
                                  begin
                                    LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.',LogGroupGUID,lmtInfo);
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
                            LogThis(s,LogGroupGUID,lmtError);
                            MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                          end;
                        if ResultSet<>nil then
                          begin
                            LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
                            mysql_free_result(ResultSet);
                          end;
                        ProgressBar1.Position:=ProgressBar1.Min;
                      end;
                  end;
                HTML:=HTML+'        <TR>'+#13#10;
                HTML:=HTML+'          <TD COLSPAN="4" HEIGHT="20" STYLE="text-align: left; color: #EEEEEE; font-size: 5pt; border-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;"></TD>'+#13#10;
                HTML:=HTML+'        </TR>'+#13#10;
                HTML:=HTML+'        <TR>'+#13#10;
                HTML:=HTML+'          <TD COLSPAN="4" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">Отчёт подготовлен '+DateToStr(EncodeDate(Year, Month, Day))+' в '+TimeToStr(EncodeTime(Hour, Min, Sec,MSec))+' при помощи АРМ услуги &laquo;Отдых и развлечения&raquo;, &copy;&nbsp;2008&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10;
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
                HTML:=HTML+'Справочно-информационный цех<BR>филиала &laquo;Минская городская телефонная сеть&raquo;<BR>РУП &laquo;Белтелеком&raquo;</TD></TR>'+#13#10;
                HTML:=HTML+'        <TR><TD COLSPAN="5" STYLE="border-color: white; border-width: 0; text-align: center; font-size: 13pt; font-weight: bold; padding: 20px 0px 3px 0px;">';
                HTML:=HTML+'Статистика&nbsp;по&nbsp;работе&nbsp;пользователей АРМ&nbsp;&laquo;Отдых&nbsp;и&nbsp;развлечения&raquo; за период с '+sStartDate+' по '+sStopDate+'<BR></TD></TR>'+#13#10;
                // перебираем список отмеченых пользователей
                for k:=0 to chklbxUsers.Count-1 do
                  begin
                    iSumIns:=0;
                    iSumMod:=0;
                    iSumDel:=0;
                    iSumRec:=0;
                    if chklbxUsers.Checked[k] then
                      begin
                        s:=chklbxUsers.Items[k];
                        // получаем список дат в которых есть данные по событиям
                        q:='SELECT DISTINCT LEFT(evn_datetime,10) FROM '+Configuration.sMySQLDatabase+'._evn LEFT JOIN '+Configuration.sMySQLDatabase+'._usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" AND LEFT(evn_datetime,10) BETWEEN "'+Copy(sStartDate,7,4)+'-'+Copy(sStartDate,4,2)+'-'+Copy(sStartDate,0,2)+'" AND "'+Copy(sStopDate,7,4)+'-'+Copy(sStopDate,4,2)+'-'+Copy(sStopDate,0,2)+'" ORDER BY LEFT(evn_datetime,10);';
                        LogThis(q,LogGroupGUID,lmtSQL);
                        i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                        if i=0 then
                          begin
                            LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                            ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                            if ResultSet<>nil then
                              begin
                                LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                                i:=mysql_num_rows(ResultSet);
                                if i>=0 then
                                  begin
                                    LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                                    ProgressBar1.Max:=i;
                                    ProgressBar1.Step:=1;
                                    slTemp.Clear;
                                    for j:=0 to i-1 do
                                      begin
                                        LogThis('Получение очередной строки выборки ('+IntToStr(j)+').',LogGroupGUID,lmtInfo);
                                        ResultRow:=mysql_fetch_row(ResultSet);
                                        if ResultRow<>nil then
                                          begin
                                            LogThis('Операция получения очередной строки выборки ('+IntToStr(j)+') прошла успешно.',LogGroupGUID,lmtInfo);
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
                                    LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.',LogGroupGUID,lmtInfo);
                                  end;
                                if ResultSet<>nil then
                                  begin
                                    LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
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
                            LogThis(s,LogGroupGUID,lmtError);
                            MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
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
                                    q:='SELECT evn_datetime, evn_type, evn_object, evn_object_id FROM '+Configuration.sMySQLDatabase+'._evn '+
                                      'LEFT JOIN '+Configuration.sMySQLDatabase+'._usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" '+
                                      'AND evn_type="INS" AND LEFT(evn_datetime,10)="'+slTemp[j]+'" '+
                                      'GROUP BY evn_type, evn_object, evn_object_id;';
                                    LogThis(q,LogGroupGUID,lmtSQL);
                                    i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                                    if i=0 then
                                      begin
                                        LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                                        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                                            i:=mysql_num_rows(ResultSet);
                                            if i>=0 then
                                              begin
                                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                                                sIns:=IntToStr(i);
                                                iSumIns:=iSumIns+StrToInt(sIns);
//                                                for l:=0 to i-1 do
//                                                  begin
//                                                    LogThis('Получение очередной строки выборки ('+IntToStr(l)+').',LogGroupGUID,lmtInfo);
//                                                    ResultRow:=mysql_fetch_row(ResultSet);
//                                                    if ResultRow<>nil then
//                                                      begin
//                                                        LogThis('Операция получения очередной строки выборки ('+IntToStr(l)+') прошла успешно.',LogGroupGUID,lmtInfo);
//                                                      end
//                                                    else
//                                                      begin
//                                                        s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(l)+')!';
//                                                        bError:=True;
//                                                      end;
//                                                  end;
                                              end
                                            else
                                              begin
                                                LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.',LogGroupGUID,lmtInfo);
                                              end;
                                          end
                                        else
                                          begin
                                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            bError:=True;
                                          end;
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
                                            mysql_free_result(ResultSet);
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
                                    q:='SELECT evn_datetime, evn_type, evn_object, evn_object_id FROM '+Configuration.sMySQLDatabase+'._evn '+
                                      'LEFT JOIN '+Configuration.sMySQLDatabase+'._usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" '+
                                      'AND evn_type="MOD" AND LEFT(evn_datetime,10)="'+slTemp[j]+'" '+
                                      'GROUP BY evn_type, evn_object, evn_object_id;';
                                    LogThis(q,LogGroupGUID,lmtSQL);
                                    i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                                    if i=0 then
                                      begin
                                        LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                                        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                                            i:=mysql_num_rows(ResultSet);
                                            if i>=0 then
                                              begin
                                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                                                sMod:=IntToStr(i);
                                                iSumMod:=iSumMod+StrToInt(sMod);
//                                                for l:=0 to i-1 do
//                                                  begin
//                                                    LogThis('Получение очередной строки выборки ('+IntToStr(l)+').',LogGroupGUID,lmtInfo);
//                                                    ResultRow:=mysql_fetch_row(ResultSet);
//                                                    if ResultRow<>nil then
//                                                      begin
//                                                        LogThis('Операция получения очередной строки выборки ('+IntToStr(l)+') прошла успешно.',LogGroupGUID,lmtInfo);
//                                                      end
//                                                    else
//                                                      begin
//                                                        s:='Возникла ошибка при загрузке данных строки выборки (порядковый номер строки равен '+IntToStr(l)+')!';
//                                                        bError:=True;
//                                                      end;
//                                                  end;
                                              end
                                            else
                                              begin
                                                LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.',LogGroupGUID,lmtInfo);
                                              end;
                                          end
                                        else
                                          begin
                                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            bError:=True;
                                          end;
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
                                            mysql_free_result(ResultSet);
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
                                    q:='SELECT evn_datetime, evn_type, evn_object, evn_object_id FROM '+Configuration.sMySQLDatabase+'._evn '+
                                      'LEFT JOIN '+Configuration.sMySQLDatabase+'._usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" '+
                                      'AND evn_type="DEL" AND LEFT(evn_datetime,10)="'+slTemp[j]+'" '+
                                      'GROUP BY evn_type, evn_object, evn_object_id;';
                                    LogThis(q,LogGroupGUID,lmtSQL);
                                    i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                                    if i=0 then
                                      begin
                                        LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                                        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                                            i:=mysql_num_rows(ResultSet);
                                            if i>=0 then
                                              begin
                                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                                                sDel:=IntToStr(i);
                                                iSumDel:=iSumDel+StrToInt(sDel);
                                              end
                                            else LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.',LogGroupGUID,lmtInfo);
                                          end
                                        else
                                          begin
                                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            bError:=True;
                                          end;
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
                                            mysql_free_result(ResultSet);
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
                                    q:='SELECT evn_datetime, evn_type, evn_object, evn_object_id FROM '+Configuration.sMySQLDatabase+'._evn '+
                                      'LEFT JOIN '+Configuration.sMySQLDatabase+'._usr ON usr_id=evn_by_user_id WHERE usr_fullname="'+s+'" '+
                                      'AND evn_type="REC" AND LEFT(evn_datetime,10)="'+slTemp[j]+'" '+
                                      'GROUP BY evn_type, evn_object, evn_object_id;';
                                    LogThis(q,LogGroupGUID,lmtSQL);
                                    i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                                    if i=0 then
                                      begin
                                        LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                                        ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                                            i:=mysql_num_rows(ResultSet);
                                            if i>=0 then
                                              begin
                                                LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                                                sRec:=IntToStr(i);
                                                iSumRec:=iSumRec+StrToInt(sRec);
                                              end
                                            else
                                              begin
                                                LogThis('Данных по работе пользователя "'+s+'" в базе данных не найдено.',LogGroupGUID,lmtInfo);
                                              end;
                                          end
                                        else
                                          begin
                                            s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                                            bError:=True;
                                          end;
                                        if ResultSet<>nil then
                                          begin
                                            LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
                                            mysql_free_result(ResultSet);
                                          end;
                                      end
                                    else
                                      begin
                                        s:='Возникла ошибка при выполнении запроса!';
                                        bError:=True;
                                      end;
                                    // вывод результатов
                                    HTML:=HTML+'        <TR>'+#13#10;
                                    HTML:=HTML+'          <TD STYLE="text-align: center; border-width: 0px 2px '+IntToStr(1+integer(((slTemp.Count-1)-j)=0))+'px 2px; border-color: black; font-size: 8pt; padding: 2px;">'+Copy(slTemp[j],9,2)+'.'+Copy(slTemp[j],6,2)+'.'+Copy(slTemp[j],0,4)+'</TD>'+#13#10;
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
                HTML:=HTML+'          <TD COLSPAN="5" STYLE="text-align: center; font-size: 5pt; border-bottom-color: white; border-top-color: #CCCCCC; border-left-color: white; border-right-color: white; border-width: 1px 0px 0px 0px; padding-top: 1px;">Отчёт подготовлен '+DateToStr(EncodeDate(Year, Month, Day))+' в '+TimeToStr(EncodeTime(Hour, Min, Sec,MSec))+' при помощи АРМ услуги &laquo;Отдых и развлечения&raquo;, &copy;&nbsp;2008&nbsp;by&nbsp;Vlad&nbsp;Ivanov</TD>'+#13#10;
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
                LogThis('Получение пути временного каталога.',LogGroupGUID,lmtInfo);
                GetMem(TempPathNameBuffer,1024+1);
                r:=GetTempPath(1024,TempPathNameBuffer);
                if r>0 then
                  begin
                    if r>1024 then
                      begin
                        FreeMem(TempPathNameBuffer);
                        GetMem(TempPathNameBuffer,r+1);
                      end;
                    GetMem(TempFileNameBuffer,1024+1);
                    LogThis('Получение имени временного файла.',LogGroupGUID,lmtInfo);
                    GetTempFileName(TempPathNameBuffer,'OA4',0,TempFileNameBuffer);
                    q:=TempFileNameBuffer;
                    LogThis('Удаление файла '+#39+q+#39+'.',LogGroupGUID,lmtInfo);
                    DeleteFile(q);
                    q:=ExtractFilePath(q)+Copy(ExtractFileName(q),0,Length(ExtractFileName(q))-3)+'htm';
                    LogThis('Имя временного файла - '+#39+q+#39+'.',LogGroupGUID,lmtInfo);
                    if not FileExists(q) then
                      begin
                        LogThis('Попытка сохраниея отчёта во временный файл '+#39+q+#39+'.',LogGroupGUID,lmtInfo);
                        SaveToFile(q);
                        LogThis('Попытка открытия временного файла.',LogGroupGUID,lmtInfo);
                        ShellExecute(Application.Handle,'open',PChar(q),nil,nil,SW_MAXIMIZE);
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
                    LogThis(s,LogGroupGUID,lmtError);
                    MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
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
  SetReady(LogGroupGUID);
end;

procedure TMainForm.OnMove(var Msg: TWMMove);
begin
  inherited;
  if not bNormalizeNow then
    begin
      Configuration.fpMainForm.x:=MainForm.Left;
      Configuration.fpMainForm.y:=MainForm.Top;
    end;
end;

procedure TMainForm.lvOrgKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  s, q, sParameter: string;
  bError: boolean;
  aCopyData: TCopyDataStruct;
  hTargetWnd: HWND;
  i, i_org_id, i_firm_code: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{EE52BA68-3414-4688-BE5E-55DA82C2AA27}';
  bError:=False;
  i_org_id:=-1;
  ResultSet:=nil;
  i_firm_code:=-1;

  if Key=VK_F11 then
    begin
      if pnlConnectedMode.Visible and lvOrg.Visible and lvOrg.Enabled and (lvOrg.Items.Count>0) then
        begin
          if lvOrg.Selected<>nil then
            begin
              SetBusy(LogGroupGUID);
              Screen.Cursor:=crHourGlass;

              ProgressBar1.Step:=1;
              ProgressBar1.Max:=3;
              ProgressBar1.Position:=ProgressBar1.Min;

              Application.ProcessMessages;

              // попытка получения ID организации-владельца
              if not bError then
                begin
                  i_org_id:=StrToIntDef(lvOrg.Selected.SubItems[2],-1);
                  if i_org_id>-1 then
                    LogThis('Попытка получения данных организации (ID#'+IntToStr(i_org_id)+').',LogGroupGUID,lmtInfo)
                  else
                    begin
                      s:='Возникла ошибка в процессе получения ID организации-владельца!';
                      bError:=True;
                    end;
                  if bError then
                    begin
                      LogThis(s,LogGroupGUID,lmtError);
                      Screen.Cursor:=crDefault;
                      Application.ProcessMessages;
                      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                    end
                  else
                    begin
                      ProgressBar1.StepIt;
                      Application.ProcessMessages;
                    end;
                end;

              // попытка получения ID записи в таблице фирм
              if not bError then
                begin
                  q:='SELECT org_firm_code FROM '+Configuration.sMySQLDatabase+'._org WHERE org_id='+IntToStr(i_org_id)+';';
                  LogThis(q,LogGroupGUID,lmtSQL);
                  i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
                  if i=0 then
                    begin
                      LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
                      ResultSet:=mysql_store_result(MySQLConnectionHandler);
                      if ResultSet<>nil then
                        begin
                          LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                          i:=mysql_num_rows(ResultSet);
                          LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                          if (i=1) then
                            begin
                              LogThis('Количество строк выборки ('+IntToStr(i)+') соответствует требуемому (1).',LogGroupGUID,lmtInfo);
                              ResultRow:=mysql_fetch_row(ResultSet);
                              if ResultRow<>nil then
                                i_firm_code:=StrToIntDef(ResultRow[0],-1)
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
                    end
                  else
                    begin
                      s:='Возникла ошибка при выполнении запроса!';
                      bError:=True;
                    end;
                  if ResultSet<>nil then
                    begin
                      LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
                      mysql_free_result(ResultSet);
                    end;
                  if bError then
                    begin
                      LogThis(s,LogGroupGUID,lmtError);
                      Screen.Cursor:=crDefault;
                      Application.ProcessMessages;
                      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                    end
                  else
                    begin
                      ProgressBar1.StepIt;
                      Application.ProcessMessages;
                    end;
                end;

              // попытка передачи данных в программу-получатель
              if not bError then
                begin
                  if i_firm_code>-1 then
                    begin
                      hTargetWnd:=FindWindow('TMainForm','OA4');
                      //hTargetWnd:=FindWindowEx(0, 0, nil, PChar('Безымянный - BaseInfo'));
                      if hTargetWnd <> 0 then
                        begin
                          sParameter:=IntToStr(INFO_GET_FIRMA_BY_CODE)+':'+IntToStr(i_firm_code);
                          with aCopyData do
                            begin
                              dwData:=0;
                              cbData:=StrLen(PChar(sParameter)) + 1;
                              lpData:=PChar(sParameter);
                            end;
                          SendMessage(hTargetWnd, WM_COPYDATA, Longint(Handle), Longint(@aCopyData));
                          LogThis('Произведена отправка во внешнюю программу следующей строки данных: ['+sParameter+']',LogGroupGUID,lmtInfo);
                        end
                      else
                        begin
                          s:='Не найдена програма-получатель данных!';
                          bError:=True;
                        end;
                    end
                  else
                    begin
                      s:='Был получен некорректный номер идентификатора фирмы!';
                      bError:=True;
                    end;

                  if bError then
                    begin
                      LogThis(s,LogGroupGUID,lmtError);
                      Screen.Cursor:=crDefault;
                      Application.ProcessMessages;
                      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
                    end
                  else
                    begin
                      ProgressBar1.StepIt;
                      Application.ProcessMessages;
                    end;
                end;


              ProgressBar1.Position:=ProgressBar1.Min;
              Screen.Cursor:=crDefault;
              SetReady(LogGroupGUID);
              Application.ProcessMessages;
            end;



        end;
    end;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  if not bNormalizeNow then
    begin
      Configuration.iMainFormWidth:=MainForm.Width;
      Configuration.iMainFormHeight:=MainForm.Height;
      Configuration.fpMainForm.x:=MainForm.Left;
      Configuration.fpMainForm.y:=MainForm.Top;
    end;
  if Configuration.bOrgPanelHalfHeight then
    pnlOrgLV.Height:=(pnlSearchResultsCreationModification.Height-pnlCreationModification.Height-Splitter2.Height) div 2;
  if Configuration.bDataPanelHalfWidth then
    pnlData.Width:=(pnlConnectedMode.Width-Splitter1.Width) div 2;
end;

procedure TMainForm.lvOrgResize(Sender: TObject);
var
  h : HWND;
begin
  lvOrg.Column[2].Width:=45; // lvOrg.Canvas.TextWidth('00000000');
  h:=lvOrg.Handle;
  if (GetWindowLong(h,GWL_STYLE) and WS_VSCROLL)=WS_VSCROLL then
    begin
      lvOrg.Column[1].Width:=(
        lvOrg.Width - lvOrg.Column[2].Width - (lvOrg.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL)
        ) div 2;
      lvOrg.Column[0].Width:=
        lvOrg.Width - lvOrg.Column[2].Width - (lvOrg.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL)
        - lvOrg.Column[1].Width;
    end
  else
    begin
      lvOrg.Column[1].Width:=(
        lvOrg.Width - lvOrg.Column[2].Width - (lvOrg.BevelWidth*2) - 2
        ) div 2;
      lvOrg.Column[0].Width:=
        lvOrg.Width - lvOrg.Column[2].Width - (lvOrg.BevelWidth*2) - 2
        - lvOrg.Column[1].Width;
    end;
  lvOrg.FlatScrollBars:=False;
  lvOrg.FlatScrollBars:=True;
end;

procedure TMainForm.pnlSearchResultsCreationModificationResize(Sender: TObject);
var
  h : HWND;
begin
  lvMsr.Column[2].Width:=100;
  lvMsr.Column[1].Width:=100;
  h:=lvMsr.Handle;
  if (GetWindowLong(h,GWL_STYLE) and WS_VSCROLL)=WS_VSCROLL then
    begin
      lvMsr.Column[0].Width:=
        lvMsr.Width-lvMsr.Column[2].Width-lvMsr.Column[1].Width-(lvMsr.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL)
    end
  else
    begin
      lvMsr.Column[0].Width:=
        lvMsr.Width-lvMsr.Column[2].Width-lvMsr.Column[1].Width-(lvMsr.BevelWidth*2)-2;
    end;
  lvMsr.FlatScrollBars:=False;
  lvMsr.FlatScrollBars:=True;
//  StringGrid1.ColWidths[2]:=StringGrid1.Width-(StringGrid1.ColWidths[0]+StringGrid1.ColWidths[1]+StringGrid1.ColWidths[3]+(StringGrid1.BevelWidth*4+4));
end;


procedure TMainForm.cmbbxOrgTypeDropDown(Sender: TObject);
var
	q, s, s1: string;
	i, j: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
	bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{9418F27A-B707-4A19-A512-C973BD5F0FD5}';
  LogThis('[Процедура формирования списка строк для выпадающего списка поля "'+lblOrgType.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры.',LogGroupGUID,lmtInfo);
	SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	Application.ProcessMessages;

	bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;

	LogThis('Преобразование строки поиска - <'+cmbbxOrgType.Text+'>.',LogGroupGUID,lmtInfo);
	cmbbxOrgType.Text:=ValidateString(cmbbxOrgType.Text);
	LogThis('Итоговая строки поиска - <'+cmbbxOrgType.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;

	if (cmbbxOrgType.Text<>'') then
		q:='SELECT DISTINCT name FROM minsk.grp WHERE UCASE(name) LIKE UCASE("%'+cmbbxOrgType.Text+'%") AND (!ISNULL(name)) ORDER BY name;'
	else q:='SELECT DISTINCT name FROM minsk.grp WHERE (!ISNULL(name)) ORDER BY name;';

	LogThis(q,LogGroupGUID,lmtSQL);
	i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if (i>=0) then
						begin
              ProgressBar1.Max:=i;
							LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
							s1:=cmbbxOrgType.Text;
							cmbbxOrgType.Items.BeginUpdate;
							cmbbxOrgType.Clear;
							for j:=0 to (i-1) do
								begin
                  if not bError then
                    begin
									    LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
									    ResultRow:=mysql_fetch_row(ResultSet);
									    if ResultRow<>nil then
										    begin
                          MainForm.LogThis('Операция получения очередной строки выборки прошла успешно.',LogGroupGUID,lmtInfo);
											    cmbbxOrgType.Items.Append(ResultRow[0]);
											    LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
										    end
									    else
										    begin
											    s:='Возникла ошибка при загрузке данных строки выборки!';
											    bError:=True;
										    end;
                      ProgressBar1.StepIt;
                    end;
								end;
              if not bError then
                cmbbxOrgType.ItemIndex:=cmbbxOrgType.Items.IndexOf(s1)
              else cmbbxOrgType.Clear;
							cmbbxOrgType.Items.EndUpdate;
						end
					else
						begin
							s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
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
			    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			    mysql_free_result(ResultSet);
		    end;
		end
	else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  if bError then
    begin
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.cmbbxOrgTownDropDown(Sender: TObject);
var
	q, s, s1: string;
	i, j: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
	bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{5A22C0BF-DEC7-48F9-BFC5-AD7147F08A6D}';
  LogThis('[Процедура формирования списка строк для выпадающего списка поля "'+lblOrgTown.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры.',LogGroupGUID,lmtInfo);
	SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	Application.ProcessMessages;

	bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;

	LogThis('Преобразование строки поиска - <'+cmbbxOrgTown.Text+'>.',LogGroupGUID,lmtInfo);
	cmbbxOrgTown.Text:=ValidateString(cmbbxOrgTown.Text);
	LogThis('Итоговая строки поиска - <'+cmbbxOrgTown.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;

	if (cmbbxOrgTown.Text<>'') then
		q:='SELECT DISTINCT name FROM minsk.city WHERE UCASE(name) LIKE UCASE("%'+cmbbxOrgTown.Text+'%") AND region_id>0 AND mobile="0" AND alt="0" AND (!ISNULL(name)) ORDER BY name;'
	else q:='SELECT DISTINCT name FROM minsk.city WHERE region_id>0 AND mobile="0" AND alt="0" AND (!ISNULL(name)) ORDER BY name;';

	LogThis(q,LogGroupGUID,lmtSQL);
	i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if (i>=0) then
						begin
              ProgressBar1.Max:=i;
							LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
							s1:=cmbbxOrgTown.Text;
							cmbbxOrgTown.Items.BeginUpdate;
							cmbbxOrgTown.Clear;
							for j:=0 to (i-1) do
								begin
                  if not bError then
                    begin
									    LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
									    ResultRow:=mysql_fetch_row(ResultSet);
									    if ResultRow<>nil then
										    begin
                          MainForm.LogThis('Операция получения очередной строки выборки прошла успешно.',LogGroupGUID,lmtInfo);
											    cmbbxOrgTown.Items.Append(ResultRow[0]);
											    LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
										    end
									    else
										    begin
											    s:='Возникла ошибка при загрузке данных строки выборки!';
											    bError:=True;
										    end;
                      ProgressBar1.StepIt;
                    end;
								end;
              if not bError then
                cmbbxOrgTown.ItemIndex:=cmbbxOrgTown.Items.IndexOf(s1)
              else cmbbxOrgTown.Clear;
							cmbbxOrgTown.Items.EndUpdate;
						end
					else
						begin
							s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
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
			    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			    mysql_free_result(ResultSet);
		    end;
		end
	else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  if bError then
    begin
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.cmbbxOrgStreetDropDown(Sender: TObject);
var
	q, s, s1: string;
	i, j: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
	bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{8AE1FDE4-16BB-4DC4-8E58-7C09531477AF}';
  LogThis('[Процедура формирования списка строк для выпадающего списка поля "'+lblOrgStreet.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры.',LogGroupGUID,lmtInfo);
	SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	Application.ProcessMessages;

	bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;

	LogThis('Преобразование строки поиска - <'+cmbbxOrgStreet.Text+'>.',LogGroupGUID,lmtInfo);
	cmbbxOrgStreet.Text:=ValidateString(cmbbxOrgStreet.Text);
	LogThis('Итоговая строки поиска - <'+cmbbxOrgStreet.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;

	if (cmbbxOrgStreet.Text<>'') then
		q:='SELECT DISTINCT name FROM minsk.street WHERE UCASE(name) LIKE UCASE("%'+cmbbxOrgStreet.Text+'%") AND (!ISNULL(name)) ORDER BY name;'
	else q:='SELECT DISTINCT name FROM minsk.street WHERE (!ISNULL(name)) ORDER BY name;';

	LogThis(q,LogGroupGUID,lmtSQL);
	i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if (i>=0) then
						begin
              ProgressBar1.Max:=i;
							LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
							s1:=cmbbxOrgStreet.Text;
							cmbbxOrgStreet.Items.BeginUpdate;
							cmbbxOrgStreet.Clear;
							for j:=0 to (i-1) do
								begin
                  if not bError then
                    begin
									    LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
									    ResultRow:=mysql_fetch_row(ResultSet);
									    if ResultRow<>nil then
										    begin
                          MainForm.LogThis('Операция получения очередной строки выборки прошла успешно.',LogGroupGUID,lmtInfo);
											    cmbbxOrgStreet.Items.Append(ResultRow[0]);
											    LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
										    end
									    else
										    begin
											    s:='Возникла ошибка при загрузке данных строки выборки!';
											    bError:=True;
										    end;
                      ProgressBar1.StepIt;
                    end;
								end;
              if not bError then
                cmbbxOrgStreet.ItemIndex:=cmbbxOrgStreet.Items.IndexOf(s1)
              else cmbbxOrgStreet.Clear;
							cmbbxOrgStreet.Items.EndUpdate;
						end
					else
						begin
							s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
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
			    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			    mysql_free_result(ResultSet);
		    end;
		end
	else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  if bError then
    begin
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.cmbbxOrgWorkTimeDropDown(Sender: TObject);
var
	q, s, s1: string;
	i, j: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
	bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{7817080B-5410-4281-92E2-704BCB654887}';
  LogThis('[Процедура формирования списка строк для выпадающего списка поля "'+lblOrgWorkTime.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры.',LogGroupGUID,lmtInfo);
	SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	Application.ProcessMessages;

	bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;

	LogThis('Преобразование строки поиска - <'+cmbbxOrgWorkTime.Text+'>.',LogGroupGUID,lmtInfo);
	cmbbxOrgWorkTime.Text:=ValidateString(cmbbxOrgWorkTime.Text);
	LogThis('Итоговая строки поиска - <'+cmbbxOrgWorkTime.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;

	if (cmbbxOrgWorkTime.Text<>'') then
		q:='SELECT DISTINCT org_work_time FROM '+Configuration.sMySQLDatabase+'._org WHERE UCASE(org_work_time) LIKE UCASE("%'+cmbbxOrgWorkTime.Text+'%") AND org_erased="0" AND (!ISNULL(org_work_time)) ORDER BY org_work_time;'
	else q:='SELECT DISTINCT org_work_time FROM '+Configuration.sMySQLDatabase+'._org WHERE org_erased="0" AND (!ISNULL(org_work_time)) ORDER BY org_work_time;';

	LogThis(q,LogGroupGUID,lmtSQL);
	i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if (i>=0) then
						begin
              ProgressBar1.Max:=i;
							LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
							s1:=cmbbxOrgWorkTime.Text;
							cmbbxOrgWorkTime.Items.BeginUpdate;
							cmbbxOrgWorkTime.Clear;
							for j:=0 to (i-1) do
								begin
                  if not bError then
                    begin
									    LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
									    ResultRow:=mysql_fetch_row(ResultSet);
									    if ResultRow<>nil then
										    begin
                          MainForm.LogThis('Операция получения очередной строки выборки прошла успешно.',LogGroupGUID,lmtInfo);
											    cmbbxOrgWorkTime.Items.Append(ResultRow[0]);
											    LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
										    end
									    else
										    begin
											    s:='Возникла ошибка при загрузке данных строки выборки!';
											    bError:=True;
										    end;
                      ProgressBar1.StepIt;
                    end;
								end;
              if not bError then
                cmbbxOrgWorkTime.ItemIndex:=cmbbxOrgWorkTime.Items.IndexOf(s1)
              else cmbbxOrgWorkTime.Clear;
							cmbbxOrgWorkTime.Items.EndUpdate;
						end
					else
						begin
							s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
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
			    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			    mysql_free_result(ResultSet);
		    end;
		end
	else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  if bError then
    begin
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.cmbbxMsrTypeDropDown(Sender: TObject);
var
	q, s, s1: string;
	i, j: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
	bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{7383D942-3B9D-419B-98F6-ECC530B93828}';
  LogThis('[Процедура формирования списка строк для выпадающего списка поля "'+lblMsrType.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры.',LogGroupGUID,lmtInfo);
	SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	Application.ProcessMessages;

	bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;

	LogThis('Преобразование строки поиска - <'+cmbbxMsrType.Text+'>.',LogGroupGUID,lmtInfo);
	cmbbxMsrType.Text:=ValidateString(cmbbxMsrType.Text);
	LogThis('Итоговая строки поиска - <'+cmbbxMsrType.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;

	if (cmbbxMsrType.Text<>'') then
		q:='SELECT DISTINCT msr_type FROM '+Configuration.sMySQLDatabase+'._msr WHERE UCASE(msr_type) LIKE UCASE("%'+cmbbxMsrType.Text+'%") AND msr_erased="0" AND (!ISNULL(msr_type)) ORDER BY msr_type;'
	else q:='SELECT DISTINCT msr_type FROM '+Configuration.sMySQLDatabase+'._msr WHERE msr_erased="0" AND (!ISNULL(msr_type)) ORDER BY msr_type;';

	LogThis(q,LogGroupGUID,lmtSQL);
	i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if (i>=0) then
						begin
              ProgressBar1.Max:=i;
							LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
							s1:=cmbbxMsrType.Text;
							cmbbxMsrType.Items.BeginUpdate;
							cmbbxMsrType.Clear;
							for j:=0 to (i-1) do
								begin
                  if not bError then
                    begin
									    LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
									    ResultRow:=mysql_fetch_row(ResultSet);
									    if ResultRow<>nil then
										    begin
                          MainForm.LogThis('Операция получения очередной строки выборки прошла успешно.',LogGroupGUID,lmtInfo);
											    cmbbxMsrType.Items.Append(ResultRow[0]);
											    LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
										    end
									    else
										    begin
											    s:='Возникла ошибка при загрузке данных строки выборки!';
											    bError:=True;
										    end;
                      ProgressBar1.StepIt;
                    end;
								end;
              if not bError then
                cmbbxMsrType.ItemIndex:=cmbbxMsrType.Items.IndexOf(s1)
              else cmbbxMsrType.Clear;
							cmbbxMsrType.Items.EndUpdate;
						end
					else
						begin
							s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
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
			    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			    mysql_free_result(ResultSet);
		    end;
		end
	else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  if bError then
    begin
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.cmbbxMsrAuthorDropDown(Sender: TObject);
var
	q, s, s1: string;
	i, j: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
	bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{4F919EA5-CCE7-44A2-BC9D-F406BE4A2DA8}';
  LogThis('[Процедура формирования списка строк для выпадающего списка поля "'+lblMsrAuthor.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры.',LogGroupGUID,lmtInfo);
	SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	Application.ProcessMessages;

	bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;

	LogThis('Преобразование строки поиска - <'+cmbbxMsrAuthor.Text+'>.',LogGroupGUID,lmtInfo);
	cmbbxMsrAuthor.Text:=ValidateString(cmbbxMsrAuthor.Text);
	LogThis('Итоговая строки поиска - <'+cmbbxMsrAuthor.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;

	if (cmbbxMsrAuthor.Text<>'') then
		q:='SELECT DISTINCT msr_author FROM '+Configuration.sMySQLDatabase+'._msr WHERE UCASE(msr_author) LIKE UCASE("%'+cmbbxMsrAuthor.Text+'%") AND msr_erased="0" AND (!ISNULL(msr_author)) ORDER BY msr_author;'
	else q:='SELECT DISTINCT msr_author FROM '+Configuration.sMySQLDatabase+'._msr WHERE msr_erased="0" AND (!ISNULL(msr_author)) ORDER BY msr_author;';

	LogThis(q,LogGroupGUID,lmtSQL);
	i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if (i>=0) then
						begin
              ProgressBar1.Max:=i;
							LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
							s1:=cmbbxMsrAuthor.Text;
							cmbbxMsrAuthor.Items.BeginUpdate;
							cmbbxMsrAuthor.Clear;
							for j:=0 to (i-1) do
								begin
                  if not bError then
                    begin
									    LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
									    ResultRow:=mysql_fetch_row(ResultSet);
									    if ResultRow<>nil then
										    begin
                          MainForm.LogThis('Операция получения очередной строки выборки прошла успешно.',LogGroupGUID,lmtInfo);
											    cmbbxMsrAuthor.Items.Append(ResultRow[0]);
											    LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
										    end
									    else
										    begin
											    s:='Возникла ошибка при загрузке данных строки выборки!';
											    bError:=True;
										    end;
                      ProgressBar1.StepIt;
                    end;
								end;
              if not bError then
                cmbbxMsrAuthor.ItemIndex:=cmbbxMsrAuthor.Items.IndexOf(s1)
              else cmbbxMsrAuthor.Clear;
							cmbbxMsrAuthor.Items.EndUpdate;
						end
					else
						begin
							s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
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
			    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			    mysql_free_result(ResultSet);
		    end;
		end
	else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  if bError then
    begin
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.cmbbxMsrProducerDropDown(Sender: TObject);
var
	q, s, s1: string;
	i, j: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
	bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{78995C79-3B3B-4405-B400-C9D9996B2A5E}';
  LogThis('[Процедура формирования списка строк для выпадающего списка поля "'+lblMsrProducer.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры.',LogGroupGUID,lmtInfo);
	SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	Application.ProcessMessages;

	bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;

	LogThis('Преобразование строки поиска - <'+cmbbxMsrProducer.Text+'>.',LogGroupGUID,lmtInfo);
	cmbbxMsrProducer.Text:=ValidateString(cmbbxMsrProducer.Text);
	LogThis('Итоговая строки поиска - <'+cmbbxMsrProducer.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;

	if (cmbbxMsrProducer.Text<>'') then
		q:='SELECT DISTINCT msr_producer FROM '+Configuration.sMySQLDatabase+'._msr WHERE UCASE(msr_producer) LIKE UCASE("%'+cmbbxMsrProducer.Text+'%") AND msr_erased="0" AND (!ISNULL(msr_producer)) ORDER BY msr_producer;'
	else q:='SELECT DISTINCT msr_producer FROM '+Configuration.sMySQLDatabase+'._msr WHERE msr_erased="0" AND (!ISNULL(msr_producer)) ORDER BY msr_producer;';

	LogThis(q,LogGroupGUID,lmtSQL);
	i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if (i>=0) then
						begin
              ProgressBar1.Max:=i;
							LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
							s1:=cmbbxMsrProducer.Text;
							cmbbxMsrProducer.Items.BeginUpdate;
							cmbbxMsrProducer.Clear;
							for j:=0 to (i-1) do
								begin
                  if not bError then
                    begin
									    LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
									    ResultRow:=mysql_fetch_row(ResultSet);
									    if ResultRow<>nil then
										    begin
                          MainForm.LogThis('Операция получения очередной строки выборки прошла успешно.',LogGroupGUID,lmtInfo);
											    cmbbxMsrProducer.Items.Append(ResultRow[0]);
											    LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
										    end
									    else
										    begin
											    s:='Возникла ошибка при загрузке данных строки выборки!';
											    bError:=True;
										    end;
                      ProgressBar1.StepIt;
                    end;
								end;
              if not bError then
                cmbbxMsrProducer.ItemIndex:=cmbbxMsrProducer.Items.IndexOf(s1)
              else cmbbxMsrProducer.Clear;
							cmbbxMsrProducer.Items.EndUpdate;
						end
					else
						begin
							s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
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
			    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			    mysql_free_result(ResultSet);
		    end;
		end
	else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  if bError then
    begin
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.cmbbxMsrPerformerDropDown(Sender: TObject);
var
	q, s, s1: string;
	i, j: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
	bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{A54FF1C0-36BD-4BEE-B7B0-801CA40D03EE}';
  LogThis('[Процедура формирования списка строк для выпадающего списка поля "'+lblMsrPerformer.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры.',LogGroupGUID,lmtInfo);
	SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	Application.ProcessMessages;

	bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;

	LogThis('Преобразование строки поиска - <'+cmbbxMsrPerformer.Text+'>.',LogGroupGUID,lmtInfo);
	cmbbxMsrPerformer.Text:=ValidateString(cmbbxMsrPerformer.Text);
	LogThis('Итоговая строки поиска - <'+cmbbxMsrPerformer.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;

	if (cmbbxMsrPerformer.Text<>'') then
		q:='SELECT DISTINCT msr_performer FROM '+Configuration.sMySQLDatabase+'._msr WHERE UCASE(msr_performer) LIKE UCASE("%'+cmbbxMsrPerformer.Text+'%") AND msr_erased="0" AND (!ISNULL(msr_performer)) ORDER BY msr_performer;'
	else q:='SELECT DISTINCT msr_performer FROM '+Configuration.sMySQLDatabase+'._msr WHERE msr_erased="0" AND (!ISNULL(msr_performer)) ORDER BY msr_performer;';

	LogThis(q,LogGroupGUID,lmtSQL);
	i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if (i>=0) then
						begin
              ProgressBar1.Max:=i;
							LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
							s1:=cmbbxMsrPerformer.Text;
							cmbbxMsrPerformer.Items.BeginUpdate;
							cmbbxMsrPerformer.Clear;
							for j:=0 to (i-1) do
								begin
                  if not bError then
                    begin
									    LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
									    ResultRow:=mysql_fetch_row(ResultSet);
									    if ResultRow<>nil then
										    begin
                          MainForm.LogThis('Операция получения очередной строки выборки прошла успешно.',LogGroupGUID,lmtInfo);
											    cmbbxMsrPerformer.Items.Append(ResultRow[0]);
											    LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
										    end
									    else
										    begin
											    s:='Возникла ошибка при загрузке данных строки выборки!';
											    bError:=True;
										    end;
                      ProgressBar1.StepIt;
                    end;
								end;
              if not bError then
                cmbbxMsrPerformer.ItemIndex:=cmbbxMsrPerformer.Items.IndexOf(s1)
              else cmbbxMsrPerformer.Clear;
							cmbbxMsrPerformer.Items.EndUpdate;
						end
					else
						begin
							s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
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
			    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			    mysql_free_result(ResultSet);
		    end;
		end
	else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  if bError then
    begin
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.cmbbxMsrOrganizerDropDown(Sender: TObject);
var
	q, s, s1: string;
	i, j: integer;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
	bError: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{796C1809-BA48-45E2-8FDD-36983123393F}';
  LogThis('[Процедура формирования списка строк для выпадающего списка поля "'+lblMsrOrganizer.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры.',LogGroupGUID,lmtInfo);
	SetBusy(LogGroupGUID);
	Screen.Cursor:=crHourGlass;
	Application.ProcessMessages;

	bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;

	LogThis('Преобразование строки поиска - <'+cmbbxMsrOrganizer.Text+'>.',LogGroupGUID,lmtInfo);
	cmbbxMsrOrganizer.Text:=ValidateString(cmbbxMsrOrganizer.Text);
	LogThis('Итоговая строки поиска - <'+cmbbxMsrOrganizer.Text+'>.',LogGroupGUID,lmtInfo);
	Application.ProcessMessages;

	if (cmbbxMsrOrganizer.Text<>'') then
		q:='SELECT DISTINCT msr_organizer FROM '+Configuration.sMySQLDatabase+'._msr WHERE UCASE(msr_organizer) LIKE UCASE("%'+cmbbxMsrOrganizer.Text+'%") AND msr_erased="0" AND (!ISNULL(msr_organizer)) ORDER BY msr_organizer;'
	else q:='SELECT DISTINCT msr_organizer FROM '+Configuration.sMySQLDatabase+'._msr WHERE msr_erased="0" AND (!ISNULL(msr_organizer)) ORDER BY msr_organizer;';

	LogThis(q,LogGroupGUID,lmtSQL);
	i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
	if i=0 then
		begin
			LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			ResultSet:=mysql_store_result(MySQLConnectionHandler);
			if ResultSet<>nil then
				begin
					LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					i:=mysql_num_rows(ResultSet);
					if (i>=0) then
						begin
              ProgressBar1.Max:=i;
							LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
							s1:=cmbbxMsrOrganizer.Text;
							cmbbxMsrOrganizer.Items.BeginUpdate;
							cmbbxMsrOrganizer.Clear;
							for j:=0 to (i-1) do
								begin
                  if not bError then
                    begin
									    LogThis('Попытка получения очередной строки выборки (#'+IntToStr(j)+').',LogGroupGUID,lmtInfo);
									    ResultRow:=mysql_fetch_row(ResultSet);
									    if ResultRow<>nil then
										    begin
                          MainForm.LogThis('Операция получения очередной строки выборки прошла успешно.',LogGroupGUID,lmtInfo);
											    cmbbxMsrOrganizer.Items.Append(ResultRow[0]);
											    LogThis('Полученная строка - <'+ResultRow[0]+'>.',LogGroupGUID,lmtInfo);
										    end
									    else
										    begin
											    s:='Возникла ошибка при загрузке данных строки выборки!';
											    bError:=True;
										    end;
                      ProgressBar1.StepIt;
                    end;
								end;
              if not bError then
                cmbbxMsrOrganizer.ItemIndex:=cmbbxMsrOrganizer.Items.IndexOf(s1)
              else cmbbxMsrOrganizer.Clear;
							cmbbxMsrOrganizer.Items.EndUpdate;
						end
					else
						begin
							s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
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
			    LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			    mysql_free_result(ResultSet);
		    end;
		end
	else
    begin
      s:='Возникла ошибка при выполнении запроса!';
      bError:=True;
    end;
  ProgressBar1.Position:=ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  Application.ProcessMessages;
  if bError then
    begin
      LogThis(s,LogGroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end
  else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.Timer_MessageStatusTimer(Sender: TObject);
var
  s, q: string;
  bError: boolean;
  i: integer;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{40E84160-7233-4B46-9DAE-35FEA83AA9BC}';
  LogThis('[Процедура обновления вида индикатора наличия новых сообщений]',LogGroupGUID,lmtInfo);

  if Configuration.bLogged then
    begin
      LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
	    //SetBusy(LogGroupGUID);
	    Screen.Cursor:=crHourGlass;
	    Application.ProcessMessages;

      bError:=False;
      //ResultSet:=nil;
      //ProgressBar1.Position:=ProgressBar1.Min;
      //ProgressBar1.Step:=1;
      //ProgressBar1.Max:=1;

      q:='SELECT COUNT(*) FROM '+Configuration.sMySQLDatabase+'._msg '+
      'LEFT JOIN '+Configuration.sMySQLDatabase+'._usr ON usr_id=msg_created_by_user_id '+
      'WHERE msg_for_user_id="'+CurrentUser.sID+'" AND msg_erased="0" AND msg_processed="0";';

      LogThis(q,LogGroupGUID,lmtSQL);
      i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          if ResultSet<>nil then
            begin
              LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
              i:=mysql_num_rows(ResultSet);
              if (i=1) then
                begin
                  LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    Image_MessageStatus.Visible:=StrToIntDef(ResultRow[0],-1)>0
                  else
                    begin
                      s:='Возникла ошибка при загрузке данных строки выборки!';
                      bError:=True;
                    end;
                end
              else
                begin
                  s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
                  bError:=True;
                end;
              //ProgressBar1.StepIt;
            end
          else
            begin
              s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
              bError:=True;
            end;
          if ResultSet<>nil then
            begin
              LogThis('Освобождение ресурсов, занятых результатом выборки.',LogGroupGUID,lmtInfo);
              mysql_free_result(ResultSet);
            end;
        end
      else
        begin
          s:='Возникла ошибка при выполнении запроса!';
          bError:=True;
        end;
      ProgressBar1.Position:=ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s,LogGroupGUID,lmtError);
          Image_MessageStatus.Visible:=False;
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
	    //SetReady(LogGroupGUID);
      LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
    end;
end;

procedure TMainForm.Update_PhonesMark;
var
  s, q: AnsiString;
  bError: boolean;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
  i, i_org_id, i_msr_id: integer;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{F2D14669-DF01-4D3C-9036-253BF5E210B5}';
  LogThis('[Процедура обновления вида индикатора наличия телефонных номеров]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

  q:='';
  bError:=False;
  ProgressBar1.Position:=ProgressBar1.Min;
  ProgressBar1.Step:=1;
  ProgressBar1.Max:=1;

  if (PageControl1.ActivePage=tsOrg) or (PageControl1.ActivePage=tsMsr) then
    begin
      if PageControl1.ActivePage=tsOrg then
        begin
          if lvOrg.Selected<>nil then
            begin
              i_org_id:=StrToIntDef(lvOrg.Selected.SubItems[2],-1);
              if i_org_id>-1 then
                begin
                  LogThis('Попытка получения данных организации (ID#'+IntToStr(i_org_id)+').',LogGroupGUID,lmtInfo);
                  q:='SELECT COUNT(*) FROM '+Configuration.sMySQLDatabase+'._phn LEFT JOIN minsk.otdel ON otdel_id=phn_otdel_id '+
                  'WHERE phn_owner_is_measure="0" AND phn_owner_id='+IntToStr(i_org_id)+';';
                end
              else
                begin
                  s:='Возникла ошибка в процессе получения ID организации-владельца!';
                  bError:=True;
                end;
            end;
        end;
      if PageControl1.ActivePage=tsMsr then
        begin
          if lvMsr.Selected<>nil then
            begin
              i_msr_id:=StrToIntDef(lvMsr.Selected.SubItems[2],-1);
              if i_msr_id>-1 then
                begin
                  LogThis('Попытка получения данных мероприятия (ID#'+IntToStr(i_msr_id)+').',LogGroupGUID,lmtInfo);
                  q:='SELECT COUNT(*) FROM '+Configuration.sMySQLDatabase+'._phn LEFT JOIN minsk.otdel ON otdel_id=phn_otdel_id '+
                  'WHERE phn_owner_is_measure="1" AND phn_owner_id='+IntToStr(i_msr_id)+';';
                end
              else
                begin
                  s:='Возникла ошибка в процессе получения ID мероприятия-владельца!';
                  bError:=True;
                end;
            end;
        end;

      if not bError then
        begin
          LogThis(q,LogGroupGUID,lmtSQL);
          i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
              ResultSet:=mysql_store_result(MySQLConnectionHandler);
              if ResultSet<>nil then
                begin
                  LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
                  i:=mysql_num_rows(ResultSet);
                  if (i=1) then
                    begin
                      LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
                      ResultRow:=mysql_fetch_row(ResultSet);
                      if ResultRow<>nil then
                        begin
                          stPhonesMark.Visible:=StrToIntDef(ResultRow[0],-1)>=0;
                          if StrToIntDef(ResultRow[0],-1)=0 then
                            begin
                              stPhonesMark.Caption:='НЕТ ТЕЛЕФОНОВ';
                              stPhonesMark.Font.Color:=clGray;
                            end
                          else
                            if StrToIntDef(ResultRow[0],-1)>0 then
                              begin
                                stPhonesMark.Caption:='ЕСТЬ ТЕЛЕФОНЫ';
                                stPhonesMark.Font.Color:=clRed;
                              end
                            else stPhonesMark.Visible:=False;
                        end
                      else
                        begin
                          s:='Возникла ошибка при загрузке данных строки выборки!';
                          bError:=True;
                        end;
                    end
                  else
                    begin
                      s:='Получено недопустимое количество строк результирующей выборки ('+IntToStr(i)+')!';
                      bError:=True;
                    end;
                  ProgressBar1.StepIt;
                end
              else
                begin
                  s:='Не удалось получить результирующую выборку по последнему SQL-запросу!';
                  bError:=True;
                end;
              if ResultSet<>nil then
                begin
                  LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
                  mysql_free_result(ResultSet);
                end;
            end
          else
            begin
              s:='Возникла ошибка при выполнении запроса!';
              bError:=True;
            end;
        end;
      ProgressBar1.Position:=ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      Application.ProcessMessages;
      if bError then
        begin
          LogThis(s,LogGroupGUID,lmtError);
          stPhonesMark.Visible:=False;
          Application.ProcessMessages;
          MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end
      else LogThis('Процедера выполнена без ошибок.',LogGroupGUID,lmtInfo);
    end
  else stPhonesMark.Visible:=False;
  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.btnClearClick(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{75FAD5A8-4EE8-4E48-B474-195DEB93AE6C}';
  LogThis('[Процедура обработки нажатия кнопки "'+btnClear.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;
  if (PageControl1.ActivePage=tsOrg) or (PageControl1.ActivePage=tsMsr) then
    if MessageBox(Handle,PChar('Вы действительно хотите очистить все поля панели данных?'),PChar('OA4 - Подтверждение очистки'),MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK then
      begin
        LogThis('Очистка полей ввоа панели данных была подтверждена пользователем.',LogGroupGUID,lmtInfo);
        if PageControl1.ActivePage=tsOrg then
          begin
            LogThis('Выполняется очистка полей ввоа панели данных организации...',LogGroupGUID,lmtInfo);
            cmbbxOrgType.Clear;
            edbxOrgName.Clear;
            edbxOrgAddress.Clear;
            cmbbxOrgTown.Clear;
            cmbbxOrgStreet.Clear;
            edbxOrgHouse.Clear;
            edbxOrgSubHouse.Clear;
            edbxOrgFlat.Clear;
            edbxOrgHowToReach.Clear;
            cmbbxOrgWorkTime.Clear;
            reOrgOtherInfo.Clear;
            SetDefaultSettings(reOrgOtherInfo);
            Update_RichEditTools;
          end;
        if PageControl1.ActivePage=tsMsr then
          begin
            LogThis('Выполняется очистка полей ввоа панели данных мероприятия...',LogGroupGUID,lmtInfo);
            cmbbxMsrType.Clear;
            edbxMsrName.Clear;
            cmbbxMsrAuthor.Clear;
            cmbbxMsrProducer.Clear;
            cmbbxMsrPerformer.Clear;
            cmbbxMsrOrganizer.Clear;
            chkbxMsrIsPremier.Checked:=False;
            chkbxMsrIsTour.Checked:=False;
            chkbxMsrForChildren.Checked:=False;
            chkbxMsrForTeenagers.Checked:=False;
            chkbxMsrForAdultsOnly.Checked:=False;
            chkbxMsrStart.Checked:=False;
            chkbxMsrStop.Checked:=False;
            dtpMsrStartDate.Date:=Date;
            dtpMsrStartTime.Time:=EncodeTime(0,0,0,0);
            dtpMsrStopDate.Date:=Date;
            dtpMsrStopTime.Time:=EncodeTime(0,0,0,0);
            chkbxMsrUnknownDuration.Checked:=True;
            meMsrTicketPrice.Clear;
            reMsrOtherInfo.Clear;
            SetDefaultSettings(reMsrOtherInfo);
            Update_RichEditTools;
          end;
      end
    else LogThis('Очистка полей ввоа панели данных была отменена пользователем.',LogGroupGUID,lmtInfo);
  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.lvOrgSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  s, q: AnsiString;
  bError: boolean;
	ResultSet: PMYSQL_RES;
	ResultRow: PMYSQL_ROW;
  msA: TMemoryStream;
  LvGroup: TLVGROUP;
  LvItemA: TLVITEMA;
  ListItem: TListItem;
  i, j, k, i_org_id: integer;
  pwcGroupName: PWideChar;
  GroupId: integer;
	slA: TStringList;
  iSelStart, iSelLenght: integer;
  sOrgWorkTime, sOrgHowToReach, sOrgHouse, sOrgSubHouse, sOrgFlat, sOrgStreet,
  sOrgTown, sOrgAddress, sOrgName, sOrgType: string;
  s1: string;
  LogGroupGUID: string;

  TextStream: TStringStream;
  UnitedText, Separator, Tmp: string;

  sMsrID, sMsrCreation, sMsrModification, sMsrType, sMsrName, sMsrAuthor, sMsrProducer, sMsrPerformer, sMsrOrganizer, sMsrTicketPrice: string;
  bMsrIsPremier, bMsrIsTour, bMsrForChildren, bMsrForTeenagers, bMsrForAdultsOnly, bMsrUnknownDuration: boolean;
  sMarks, sStartDateTime, sStopDateTime, sDuration: string;
  dtStartDateTime, dtStopDateTime: TDateTime;

  c1: Comp;
  c2: Int64 absolute c1;
  t1, t2: TTimeStamp;
  iDays, iHours, iMinutes: integer;

begin
  LogGroupGUID:='{70E289B4-6C15-4AB0-B09A-D5E5E028F6B6}';
 	ResultSet:=nil;
	bError:=False;
  Separator:= ''; //Separator:= '\par \brdrb\brdrdb \par '; // строка-разеделитель
  UnitedText:='';

	// преобразование строки поиска
	LogThis('Преобразование строки поиска - <'+edbxSearchName.Text+'>.',LogGroupGUID,lmtInfo);
	s:=Trim(edbxSearchName.Text);
	while Pos('  ',s)>0 do s:=StringReplace(s,'  ',' ',[rfReplaceAll]);
	edbxSearchName.Text:=s;
	LogThis('Итоговая строки поиска - <'+edbxSearchName.Text+'>.',LogGroupGUID,lmtInfo);
  if not blvOrgRedrawNow then // для ускорения составления списка после выборки
    begin
      // обновление значений панели создания/модификации
      lblCreationCaption.Visible:=(lvOrg.Selected<>nil);
      lblCreation.Visible:=(lvOrg.Selected<>nil);
      lblModificationCaption.Visible:=(lvOrg.Selected<>nil);
      lblModification.Visible:=(lvOrg.Selected<>nil);
      // обновление значений панели идентификатора
      if pnlID.Visible then
        begin
          lblIDCaption.Visible:=(lvOrg.Selected<>nil);
          lblID.Visible:=(lvOrg.Selected<>nil);
        end;
      Update_Actions;
      if lvOrg.Selected<>nil then
        begin
          SendMessage(lvOrg.Handle, LVM_ENSUREVISIBLE, lvOrg.Selected.Index, 0);
          i_org_id:=StrToIntDef(lvOrg.Selected.SubItems[2],-1);
          if i_org_id>-1 then
            LogThis('Попытка получения данных организации (ID#'+IntToStr(i_org_id)+').',LogGroupGUID,lmtInfo)
          else
            begin
              s:='Возникла ошибка в процессе получения ID организации-владельца!';
              bError:=True;
            end;
          if not bError then
            begin
              // обновление списка мероприятий данной организации
              blvMsrRedrawNow:=True;
              lvMsr.Items.BeginUpdate;
              SendMessage(lvMsr.Handle, LVM_REMOVEALLGROUPS, 0, 0);
              SendMessage(lvMsr.Handle, LVM_DELETEALLITEMS, 0, 0);
              lvMsr.Items.EndUpdate;
              SendMessage(lvMsr.Handle, LVM_ENABLEGROUPVIEW, 1, 0);
              q:='SELECT UCASE(TRIM(msr_type)) AS x1, TRIM(msr_name) AS x2, '+
              'DATE_FORMAT(msr_start_datetime,"%d.%m.%Y %H:%i") AS x3, '+
              'DATE_FORMAT(msr_stop_datetime, "%d.%m.%Y %H:%i") AS x4, '+
              'msr_id AS x5, '+
              'msr_erased AS x6, '+
              'DATE_FORMAT(msr_stop_datetime, "%H:%i:%s") AS x7';


              // кусок запроса для формирования списка мероприятий в виде ришэдита
              if Configuration.bShowMeasuresListAsRichEdit then
                begin
                  q:=q+', msr_type, msr_name, msr_author, msr_producer, msr_performer, msr_organizer, '+
                  'date_format(msr_start_datetime,"%d.%m.%Y"), date_format(msr_start_datetime,"%T"), '+
                  'date_format(msr_stop_datetime,"%d.%m.%Y"), date_format(msr_stop_datetime,"%T"), '+
                  'msr_is_premier, msr_is_tour, msr_for_children, msr_for_teenagers, msr_for_adults_only, msr_unknown_duration, '+
                  'msr_ticket_price, msr_other_info, msr_other_info_rtf, '+
                  'date_format(msr_created_at,"%d.%m.%Y %T"), uc.usr_fullname, date_format(msr_modified_at,"%d.%m.%Y %T"), um.usr_fullname';
                end;
              //
              q:=q+' FROM '+Configuration.sMySQLDatabase+'._msr '+
              'LEFT JOIN '+Configuration.sMySQLDatabase+'._org ON org_id=msr_organization_id '+
              'LEFT JOIN minsk.firma f ON f.firm_code=org_firm_code '+
              'LEFT JOIN minsk.otdel o ON o.firm_code=f.firm_code '+
              'LEFT JOIN '+Configuration.sMySQLDatabase+'._phn ON phn_otdel_id=o.otdel_id '+
              'LEFT JOIN minsk.street a_s ON a_s.street_id=f.street_id '+
              'LEFT JOIN minsk.city a_c ON a_c.city_id=f.city_id and a_c.alt="0" ';
              // кусок запроса для формирования списка мероприятий в виде ришэдита
              if Configuration.bShowMeasuresListAsRichEdit then
                begin
                  q:=q+'LEFT JOIN '+Configuration.sMySQLDatabase+'._usr uc ON uc.usr_id=msr_created_by_user_id '+
                  'LEFT JOIN '+Configuration.sMySQLDatabase+'._usr um ON um.usr_id=msr_modified_by_user_id ';
                end;
              q:=q+'WHERE msr_organization_id='+IntToStr(i_org_id)+' ';
              if (chkbxHideErased.Visible and chkbxHideErased.Enabled and chkbxHideErased.Checked) or (not chkbxHideErased.Visible) then
                q:=q+'AND msr_erased="0" ';
              if chkbxHideOld.Enabled and chkbxHideOld.Checked then
                q:=q+'AND ((msr_stop_datetime>="'+FormatDateTime('yyyy-mm-dd',Now)+' 00:00:00") OR ISNULL(msr_stop_datetime)) ';
              if chkbxStartDate.Visible and chkbxStartDate.Enabled and chkbxStartDate.Checked then // будут отобраны все мероприятия не окончившиеся на указанную дату
                q:=q+'AND (ISNULL(msr_stop_datetime) OR (msr_stop_datetime>="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpStartDate.DateTime)+'")) ';
              if chkbxStopDate.Visible and chkbxStopDate.Enabled and chkbxStopDate.Checked then // будут указаны все мероприятия начинающиеся не позднее указанной даты
                q:=q+'AND (ISNULL(msr_start_datetime) OR (msr_start_datetime<="'+FormatDateTime('yyyy-mm-dd hh:nn:ss',dtpStopDate.DateTime)+'")) ';
              if chkbxPremier.Visible and chkbxPremier.Enabled and chkbxPremier.Checked then
                q:=q+'AND msr_is_premier="1" ';
              if chkbxTour.Visible and chkbxTour.Enabled and chkbxTour.Checked then
                q:=q+'AND msr_is_tour="1" ';
              if chkbxChildren.Visible and chkbxChildren.Enabled and chkbxChildren.Checked then
                q:=q+'AND msr_for_children="1" ';
              if chkbxTeenagers.Visible and chkbxTeenagers.Enabled and chkbxTeenagers.Checked then
                q:=q+'AND msr_for_teenagers="1" ';
              if chkbxAdultsOnly.Visible and chkbxAdultsOnly.Enabled and chkbxAdultsOnly.Checked then
                q:=q+'AND msr_for_adults_only="1" ';
	            // формирование  строки запроса
	            s:=edbxSearchName.Text;
	            while Pos('.',s)>0 do s:=StringReplace(s,'.','~~~',[rfReplaceAll]);
              while Pos('*',s)>0 do s:=StringReplace(s,'*','%',[rfReplaceAll]);
	            slA:=TStringList.Create;
	            try
	              slA.Duplicates:=dupIgnore;
		            CutStringByLimiterToStringList(s,slA,' ');
                for i:=0 to slA.Count-1 do
                  begin
                    if slA[i]>'' then
                      begin
                        if Pos('~~~',slA[i])>0 then
                          begin
                            q:=q+'AND ('+
                            '(f.name LIKE "% '+slA[i]+'%") OR '+
                            '(f.name LIKE "% '+slA[i]+' %") OR '+
                            '(f.name LIKE "% '+slA[i]+'!%") OR '+
                            '(f.name LIKE "% '+slA[i]+'.%") OR '+
                            '(f.name LIKE "% '+slA[i]+',%") OR '+
                            '(f.name LIKE "% '+slA[i]+'-%") OR '+
                            '(f.name LIKE "% '+slA[i]+'!%") OR '+
                            '(f.name LIKE "% '+slA[i]+'?%") OR '+
                            '(f.name LIKE "% '+slA[i]+':%") OR '+
                            '(f.name LIKE "% '+slA[i]+';%") OR '+

                            '(_org_address LIKE "% '+slA[i]+'%") OR '+
                            '(_org_address LIKE "% '+slA[i]+' %") OR '+
                            '(_org_address LIKE "% '+slA[i]+'!%") OR '+
                            '(_org_address LIKE "% '+slA[i]+'.%") OR '+
                            '(_org_address LIKE "% '+slA[i]+',%") OR '+
                            '(_org_address LIKE "% '+slA[i]+'-%") OR '+
                            '(_org_address LIKE "% '+slA[i]+'!%") OR '+
                            '(_org_address LIKE "% '+slA[i]+'?%") OR '+
                            '(_org_address LIKE "% '+slA[i]+':%") OR '+
                            '(_org_address LIKE "% '+slA[i]+';%") OR '+

                            '(a_s.name LIKE "% '+slA[i]+'%") OR '+
                            '(a_s.name LIKE "% '+slA[i]+' %") OR '+
                            '(a_s.name LIKE "% '+slA[i]+'!%") OR '+
                            '(a_s.name LIKE "% '+slA[i]+'.%") OR '+
                            '(a_s.name LIKE "% '+slA[i]+',%") OR '+
                            '(a_s.name LIKE "% '+slA[i]+'-%") OR '+
                            '(a_s.name LIKE "% '+slA[i]+'!%") OR '+
                            '(a_s.name LIKE "% '+slA[i]+'?%") OR '+
                            '(a_s.name LIKE "% '+slA[i]+':%") OR '+
                            '(a_s.name LIKE "% '+slA[i]+';%") OR '+

                            '(f.house_num LIKE "'+slA[i]+'%") OR '+
                            '(f.house_sym LIKE "'+slA[i]+'%") OR '+
                            '(CONCAT(f.house_num,f.house_sym) LIKE "%'+slA[i]+'%") OR '+
                            '(f.subhouse_num LIKE "'+slA[i]+'%") OR '+
                            '(f.subhouse_sym LIKE "'+slA[i]+'%") OR '+
                            '(CONCAT(f.subhouse_num,f.subhouse_sym) LIKE "%'+slA[i]+'%") OR '+
                            '(f.flat_num LIKE "'+slA[i]+'%") OR '+
                            '(f.flat_sym LIKE "'+slA[i]+'%") OR '+
                            '(CONCAT(f.flat_num,f.flat_sym) LIKE "%'+slA[i]+'%") OR '+

                            '(org_how_to_reach LIKE "% '+slA[i]+'%") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+' %") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+'!%") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+'.%") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+',%") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+'-%") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+'!%") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+'?%") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+':%") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+';%") OR '+

                            '(org_work_time LIKE "% '+slA[i]+'%") OR '+
                            '(org_work_time LIKE "% '+slA[i]+' %") OR '+
                            '(org_work_time LIKE "% '+slA[i]+'!%") OR '+
                            '(org_work_time LIKE "% '+slA[i]+'.%") OR '+
                            '(org_work_time LIKE "% '+slA[i]+',%") OR '+
                            '(org_work_time LIKE "% '+slA[i]+'-%") OR '+
                            '(org_work_time LIKE "% '+slA[i]+'!%") OR '+
                            '(org_work_time LIKE "% '+slA[i]+'?%") OR '+
                            '(org_work_time LIKE "% '+slA[i]+':%") OR '+
                            '(org_work_time LIKE "% '+slA[i]+';%") OR '+

                            '(org_other_info LIKE "% '+slA[i]+'%") OR '+
                            '(org_other_info LIKE "% '+slA[i]+' %") OR '+
                            '(org_other_info LIKE "% '+slA[i]+'!%") OR '+
                            '(org_other_info LIKE "% '+slA[i]+'.%") OR '+
                            '(org_other_info LIKE "% '+slA[i]+',%") OR '+
                            '(org_other_info LIKE "% '+slA[i]+'-%") OR '+
                            '(org_other_info LIKE "% '+slA[i]+'!%") OR '+
                            '(org_other_info LIKE "% '+slA[i]+'?%") OR '+
                            '(org_other_info LIKE "% '+slA[i]+':%") OR '+
                            '(org_other_info LIKE "% '+slA[i]+';%") OR '+

                            '(msr_type LIKE "% '+slA[i]+'%") OR '+
                            '(msr_type LIKE "% '+slA[i]+' %") OR '+
                            '(msr_type LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_type LIKE "% '+slA[i]+'.%") OR '+
                            '(msr_type LIKE "% '+slA[i]+',%") OR '+
                            '(msr_type LIKE "% '+slA[i]+'-%") OR '+
                            '(msr_type LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_type LIKE "% '+slA[i]+'?%") OR '+
                            '(msr_type LIKE "% '+slA[i]+':%") OR '+
                            '(msr_type LIKE "% '+slA[i]+';%") OR '+

                            '(msr_name LIKE "% '+slA[i]+'%") OR '+
                            '(msr_name LIKE "% '+slA[i]+' %") OR '+
                            '(msr_name LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_name LIKE "% '+slA[i]+'.%") OR '+
                            '(msr_name LIKE "% '+slA[i]+',%") OR '+
                            '(msr_name LIKE "% '+slA[i]+'-%") OR '+
                            '(msr_name LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_name LIKE "% '+slA[i]+'?%") OR '+
                            '(msr_name LIKE "% '+slA[i]+':%") OR '+
                            '(msr_name LIKE "% '+slA[i]+';%") OR '+

                            '(msr_author LIKE "% '+slA[i]+'%") OR '+
                            '(msr_author LIKE "% '+slA[i]+' %") OR '+
                            '(msr_author LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_author LIKE "% '+slA[i]+'.%") OR '+
                            '(msr_author LIKE "% '+slA[i]+',%") OR '+
                            '(msr_author LIKE "% '+slA[i]+'-%") OR '+
                            '(msr_author LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_author LIKE "% '+slA[i]+'?%") OR '+
                            '(msr_author LIKE "% '+slA[i]+':%") OR '+
                            '(msr_author LIKE "% '+slA[i]+';%") OR '+

                            '(msr_producer LIKE "% '+slA[i]+'%") OR '+
                            '(msr_producer LIKE "% '+slA[i]+' %") OR '+
                            '(msr_producer LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_producer LIKE "% '+slA[i]+'.%") OR '+
                            '(msr_producer LIKE "% '+slA[i]+',%") OR '+
                            '(msr_producer LIKE "% '+slA[i]+'-%") OR '+
                            '(msr_producer LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_producer LIKE "% '+slA[i]+'?%") OR '+
                            '(msr_producer LIKE "% '+slA[i]+':%") OR '+
                            '(msr_producer LIKE "% '+slA[i]+';%") OR '+

                            '(msr_performer LIKE "% '+slA[i]+'%") OR '+
                            '(msr_performer LIKE "% '+slA[i]+' %") OR '+
                            '(msr_performer LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_performer LIKE "% '+slA[i]+'.%") OR '+
                            '(msr_performer LIKE "% '+slA[i]+',%") OR '+
                            '(msr_performer LIKE "% '+slA[i]+'-%") OR '+
                            '(msr_performer LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_performer LIKE "% '+slA[i]+'?%") OR '+
                            '(msr_performer LIKE "% '+slA[i]+':%") OR '+
                            '(msr_performer LIKE "% '+slA[i]+';%") OR '+

                            '(msr_organizer LIKE "% '+slA[i]+'%") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+' %") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+'.%") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+',%") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+'-%") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+'?%") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+':%") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+';%") OR '+

                            '(msr_ticket_price LIKE "% '+slA[i]+'%") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+' %") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+'.%") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+',%") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+'-%") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+'?%") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+':%") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+';%") OR '+

                            '(msr_other_info LIKE "% '+slA[i]+'%") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+' %") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+'.%") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+',%") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+'-%") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+'!%") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+'?%") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+':%") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+';%") OR '+

                            '(phn_comments LIKE "% '+slA[i]+'%") OR '+
                            '(phn_comments LIKE "% '+slA[i]+' %") OR '+
                            '(phn_comments LIKE "% '+slA[i]+'!%") OR '+
                            '(phn_comments LIKE "% '+slA[i]+'.%") OR '+
                            '(phn_comments LIKE "% '+slA[i]+',%") OR '+
                            '(phn_comments LIKE "% '+slA[i]+'-%") OR '+
                            '(phn_comments LIKE "% '+slA[i]+'!%") OR '+
                            '(phn_comments LIKE "% '+slA[i]+'?%") OR '+
                            '(phn_comments LIKE "% '+slA[i]+':%") OR '+
                            '(phn_comments LIKE "% '+slA[i]+';%") OR '+

                            '(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(phone),"-","")," ",""),"+",""),"(",""),")","") LIKE "'+slA[i]+'")) ';
                          end
                        else
                          begin
                            q:=q+'AND ('+
                            '(f.name LIKE "% '+slA[i]+'%") OR '+
                            '(_org_address LIKE "% '+slA[i]+'%") OR '+
                            '(a_s.name LIKE "% '+slA[i]+'%") OR '+
                            '(f.house_num LIKE "'+slA[i]+'%") OR '+
                            '(f.house_sym LIKE "'+slA[i]+'%") OR '+
                            '(CONCAT(f.house_num,f.house_sym) LIKE "%'+slA[i]+'%") OR '+
                            '(f.subhouse_num LIKE "'+slA[i]+'%") OR '+
                            '(f.subhouse_sym LIKE "'+slA[i]+'%") OR '+
                            '(CONCAT(f.subhouse_num,f.subhouse_sym) LIKE "%'+slA[i]+'%") OR '+
                            '(f.flat_num LIKE "'+slA[i]+'%") OR '+
                            '(f.flat_sym LIKE "'+slA[i]+'%") OR '+
                            '(CONCAT(f.flat_num,f.flat_sym) LIKE "%'+slA[i]+'%") OR '+
                            '(org_how_to_reach LIKE "% '+slA[i]+'%") OR '+
                            '(org_work_time LIKE "% '+slA[i]+'%") OR '+
                            '(org_other_info LIKE "% '+slA[i]+'%") OR '+
                            '(msr_type LIKE "% '+slA[i]+'%") OR '+
                            '(msr_name LIKE "% '+slA[i]+'%") OR '+
                            '(msr_author LIKE "% '+slA[i]+'%") OR '+
                            '(msr_producer LIKE "% '+slA[i]+'%") OR '+
                            '(msr_performer LIKE "% '+slA[i]+'%") OR '+
                            '(msr_organizer LIKE "% '+slA[i]+'%") OR '+
                            '(msr_ticket_price LIKE "% '+slA[i]+'%") OR '+
                            '(msr_other_info LIKE "% '+slA[i]+'%") OR '+
                            '(phn_comments LIKE "% '+slA[i]+'%") OR '+
                            '(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(TRIM(phone),"-","")," ",""),"+",""),"(",""),")","") LIKE "'+slA[i]+'")) ';
                          end;
                      end;
                  end;
                while Pos('~~~%',q)>0  do q:=StringReplace(q,'~~~%','',[rfReplaceAll]);
                while Pos('~~~ %',q)>0 do q:=StringReplace(q,'~~~ %',' %',[rfReplaceAll]);
                while Pos('~~~!%',q)>0 do q:=StringReplace(q,'~~~!%','!%',[rfReplaceAll]);
                while Pos('~~~.%',q)>0 do q:=StringReplace(q,'~~~.%','.%',[rfReplaceAll]);
                while Pos('~~~,%',q)>0 do q:=StringReplace(q,'~~~,%',',%',[rfReplaceAll]);
                while Pos('~~~-%',q)>0 do q:=StringReplace(q,'~~~-%','-%',[rfReplaceAll]);
                while Pos('~~~!%',q)>0 do q:=StringReplace(q,'~~~!%','!%',[rfReplaceAll]);
                while Pos('~~~?%',q)>0 do q:=StringReplace(q,'~~~?%','?%',[rfReplaceAll]);
                while Pos('~~~:%',q)>0 do q:=StringReplace(q,'~~~:%',':%',[rfReplaceAll]);
                while Pos('~~~;%',q)>0 do q:=StringReplace(q,'~~~;%',';%',[rfReplaceAll]);
                while Pos('~~~',q)>0 do q:=StringReplace(q,'~~~','',[rfReplaceAll]);
                while Pos('%%',q)>0 do q:=StringReplace(q,'%%','%',[rfReplaceAll]);
	            finally
		            slA.Free;
	            end;
              q:=q+'GROUP BY x5 ';
              case Configuration.iMsrSortColumn of
                0: q:=q+'ORDER BY x1, x2, msr_start_datetime, msr_stop_datetime;';
                1: q:=q+'ORDER BY x1, msr_start_datetime, x2, msr_stop_datetime;';
                2: q:=q+'ORDER BY x1, msr_stop_datetime, x2, msr_start_datetime;';
              else q:=q+'ORDER BY x1, x2, msr_start_datetime, msr_stop_datetime;';
              end;
              s:='cxzasdewq';
              GroupId:=-1;
		          LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
		            begin
			            LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			            ResultSet:=mysql_store_result(MySQLConnectionHandler);
			            if ResultSet<>nil then
				            begin
					            LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					            i:=mysql_num_rows(ResultSet);
					            if (i>=0) then
						            begin
                          ProgressBar1.Max:=i;
                          ProgressBar1.Step:=1;
							            LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);

							            lvMsr.Items.BeginUpdate; // !!!!

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
                                            SendMessage(lvMsr.Handle, LVM_INSERTGROUP, -1, Longint(@LvGroup));
                                          finally
                                            FreeMem(pwcGroupName);
                                          end;
                                        end;
                                      if GroupId>-1 then
                                        begin
                                          ListItem:=lvMsr.Items.Add;
                                          ListItem.Caption:=ResultRow[1];
                                          ListItem.SubItems.Add(ResultRow[2]);
                                          ListItem.SubItems.Add(ResultRow[3]);
                                          ListItem.SubItems.Add(ResultRow[4]);
                                          ListItem.ImageIndex:=StrToIntDef(ResultRow[5],2);
                                          with LvItemA do
                                            begin
                                              FillChar(LvItemA, SizeOf(TLvItemA), 0);
                                              mask:=LVIF_GROUPID;
                                              iItem:=ListItem.Index;
                                              iGroupId:=GroupId;
                                            end;
                                          ListItem.SubItems.Add(ResultRow[6]);
                                          SendMessage(lvMsr.Handle, LVM_SETITEM, 0, Longint(@LvItemA));
                                        end;

                                      // прорисовка очередного элемента списка мероприятий в ричэдите
                                      if Configuration.bShowMeasuresListAsRichEdit and (not CurrentUser.bDBEdition) then
                                        begin
                                          sMsrID:=ResultRow[4];
                                          sMsrType:=ResultRow[7];
                                          sMsrName:=ResultRow[8];
                                          sMsrAuthor:=ResultRow[9];
                                          sMsrProducer:=ResultRow[10];
                                          sMsrPerformer:=ResultRow[11];
                                          sMsrOrganizer:=ResultRow[12];
                                          bMsrIsPremier:=ResultRow[17]='1';
                                          bMsrIsTour:=ResultRow[18]='1';
                                          bMsrForChildren:=ResultRow[19]='1';
                                          bMsrForTeenagers:=ResultRow[20]='1';
                                          bMsrForAdultsOnly:=ResultRow[21]='1';
                                          bMsrUnknownDuration:=ResultRow[22]='1';
                                          sMsrTicketPrice:=StringReplace(ResultRow[23],'<BR>',#13#10,[rfReplaceAll]);
                                          sMsrCreation:=ResultRow[27]+', '+ResultRow[26];
                                          sMsrModification:=ResultRow[29]+', '+ResultRow[28];

                                          sMarks:='';
                                          if bMsrIsPremier then
                                            begin
                                              if sMarks>'' then
                                                sMarks:=sMarks+', ';
                                              sMarks:=sMarks+'премьера';
                                            end;
                                          if bMsrIsTour then
                                            begin
                                              if sMarks>'' then
                                                sMarks:=sMarks+', ';
                                              sMarks:=sMarks+'гастроли';
                                            end;
                                          if bMsrForChildren then
                                            begin
                                              if sMarks>'' then
                                                sMarks:=sMarks+', ';
                                              sMarks:=sMarks+'детское';
                                            end;
                                          if bMsrForTeenagers then
                                            begin
                                              if sMarks>'' then
                                                sMarks:=sMarks+', ';
                                              sMarks:=sMarks+'подростковое';
                                            end;
                                          if bMsrForAdultsOnly then
                                            begin
                                              if sMarks>'' then
                                                sMarks:=sMarks+', ';
                                              sMarks:=sMarks+'только для взрослых';
                                            end;

                                          sStartDateTime:='';
                                          if (Length(ResultRow[13])>0) then
                                            sStartDateTime:=sStartDateTime+ResultRow[13];
                                          if (Length(ResultRow[14])>0) then
                                            begin
                                              if sStartDateTime>'' then
                                                sStartDateTime:=sStartDateTime+' ';
                                              sStartDateTime:=sStartDateTime+ResultRow[14];
                                            end;

                                          sStopDateTime:='';
                                          if (Length(ResultRow[15])>0) then
                                            sStopDateTime:=sStopDateTime+ResultRow[15];
                                          if (Length(ResultRow[16])>0) then
                                            begin
                                              if sStopDateTime>'' then
                                                sStopDateTime:=sStopDateTime+' ';
                                              sStopDateTime:=sStopDateTime+ResultRow[16];
                                            end;

                                          sDuration:='';
                                          if not bMsrUnknownDuration then // если длительность не является неизвестной - попытаться высчитать длительность на основе начала и окончания
                                            begin
                                              dtStartDateTime:=StrToDateTimeDef(Trim(sStartDateTime),EncodeDate(1900,1,1));
                                              if dtStartDateTime<>EncodeDate(1900,1,1) then
                                                begin
                                                  dtStopDateTime:=StrToDateTimeDef(Trim(sStopDateTime),EncodeDate(1900,1,1));
                                                  if dtStopDateTime<>EncodeDate(1900,1,1) then
                                                    begin
                                                      // если попали в данную ветку - то и дата/время начала и дата/время конца мероприятия
                                                      // интерпретирован\лись нормально
                                                      // значит можно начать вычисления длительности
                                                      t1:=DateTimeToTimeStamp(dtStartDateTime);
                                                      t2:=DateTimeToTimeStamp(dtStopDateTime);
                                                      c1:=TimeStampToMSecs(t2)-TimeStampToMSecs(t1);
                                                      if (c2>0) then
                                                        begin
                                                          iDays:=Int64(c2) div Int64(86400000);
                                                          c2:=Int64(c2)-Int64((Int64(iDays)*Int64(86400000)));
                                                          iHours:=c2 div 3600000;
                                                          c2:=c2-iHours*3600000;
                                                          iMinutes:=c2 div 60000;
                                                        end
                                                      else
                                                        begin
                                                          dtStopDateTime:=dtStartDateTime;
                                                          iDays:=0;
                                                          iHours:=0;
                                                          iMinutes:=0;
                                                        end;
                                                      // к этому моменту переменные дней, часов и минут уже полностью расчитаны
                                                      if iDays>0 then
                                                        begin
                                                          if sDuration>'' then
                                                            sDuration:=sDuration+', ';
                                                          sDuration:=sDuration+IntToStr(iDays)+' '+lblMsrDurationDays.Caption;
                                                        end;
                                                      if iHours>0 then
                                                        begin
                                                          if sDuration>'' then
                                                            sDuration:=sDuration+', ';
                                                          sDuration:=sDuration+IntToStr(iHours)+' '+lblMsrDurationHours.Caption;
                                                        end;
                                                      if iMinutes>0 then
                                                        begin
                                                          if sDuration>'' then
                                                            sDuration:=sDuration+', ';
                                                          sDuration:=sDuration+IntToStr(iMinutes)+' '+lblMsrDurationMinutes.Caption;
                                                        end;
                                                    end;
                                                end;
                                            end;

                                          Application.ProcessMessages;

                                          reMsrOtherInfo.Lines.BeginUpdate; // !!!!!

                                          if Length(ResultRow[25])=0 then
                                            begin
                                              if ResultRow[24]<>'' then
                                                begin
                                                  s:=ResultRow[24];
                                                  s:=s+' ';
                                                  HTMLtoRTF(s,reMsrOtherInfo);
                                                end;
                                            end
                                          else
                                            begin
                                              msA:=TMemoryStream.Create;
                                              try
                                                k:=StrLen(ResultRow[25]);
                                                msA.SetSize(k);
                                                msA.Seek(0, soFromBeginning);
                                                msA.Write(ResultRow[25]^,k);
                                                msA.Seek(0, soFromBeginning);
                                                reMsrOtherInfo.Lines.LoadFromStream(msA);
                                              finally
                                                msA.Free;
                                              end;
                                            end;

                                          // принцип таков
                                          // ставим курсор в самое начало и назинаем добавлять строки задом наперёд каждый раз в начало текста
                                          reMsrOtherInfo.SelStart:=0;
                                          reMsrOtherInfo.SelLength:=0;
                                          reMsrOtherInfo.Lines.Insert(0,'----------------------------------------------------------------');
                                          reMsrOtherInfo.SelStart:=0;
                                          reMsrOtherInfo.SelLength:=Length('----------------------------------------------------------------');
                                          SetDefaultSettings(reMsrOtherInfo);
                                          reMsrOtherInfo.SelAttributes.Style:=[fsBold];
                                          reMsrOtherInfo.Paragraph.Alignment:=taLeftJustify;

                                          a1(sMarks, Trim(gpbxMsrFlags.Caption), reMsrOtherInfo); // пометки


                                          if bMsrUnknownDuration then
                                            a1('неизвестная', Trim(gpbxMsrDuration.Caption), reMsrOtherInfo) // длительность
                                          else a1(sDuration, Trim(gpbxMsrDuration.Caption), reMsrOtherInfo); // длительность

                                          a1(sStopDateTime, 'Окончание мероприятия', reMsrOtherInfo); // окончание
                                          a1(sStartDateTime, 'Начало мероприятия', reMsrOtherInfo); // начало
                                          a1(sMsrTicketPrice, Trim(lblMsrTicketPrice.Caption), reMsrOtherInfo); // стоимость
                                          a1(sMsrOrganizer, lblMsrOrganizer.Caption, reMsrOtherInfo); // организатор
                                          a1(sMsrPerformer, lblMsrPerformer.Caption, reMsrOtherInfo); // исполнитель
                                          a1(sMsrProducer, lblMsrProducer.Caption, reMsrOtherInfo); // режиссер
                                          a1(sMsrAuthor, lblMsrAuthor.Caption, reMsrOtherInfo); // автор
                                          a1(sMsrName, lblMsrName.Caption, reMsrOtherInfo); // наименование
                                          a1(sMsrType, lblMsrType.Caption, reMsrOtherInfo); // тип

                                          // добавление лидируещей строки-разделителя с порядковым номером мероприятия

                                          reMsrOtherInfo.SelStart:=0;
                                          reMsrOtherInfo.SelLength:=0;
                                          reMsrOtherInfo.Lines.Insert(0,'-------------------- '+IntToStr(j+1)+'/'+IntToStr(i)+' --------------------');
                                          reMsrOtherInfo.SelStart:=0;
                                          reMsrOtherInfo.SelLength:=Length('-------------------- '+IntToStr(j+1)+'/'+IntToStr(i)+' --------------------');
                                          reMsrOtherInfo.SelAttributes.Color:=clTeal;
                                          reMsrOtherInfo.SelAttributes.Size:=reMsrOtherInfo.SelAttributes.Size+5;
                                          reMsrOtherInfo.Paragraph.Alignment:=taLeftJustify;
                                          reMsrOtherInfo.SelAttributes.Style:=[fsBold];


                                          if Configuration.bMarkSearchedStrings and (not CurrentUser.bDBEdition) then
                                            begin
                                              if not Configuration.bShowMeasuresListAsRichEdit  then
                                                begin
                                                  MarkSearchedTextInRichEdit(edbxSearchName.Text, reMsrOtherInfo);
                                                  reMsrOtherInfo.WordWrap:=False;
                                                  reMsrOtherInfo.WordWrap:=True;
                                                end;
                                            end;

                                          // добавление сформированного результата в общий список
                                          TextStream:= TStringStream.Create('');
                                          try
                                            reMsrOtherInfo.Lines.SaveToStream(TextStream);
                                            Tmp:=TextStream.DataString;
                                          finally
                                            TextStream.Free;
                                          end;
                                          reMsrOtherInfo.Clear;
                                          if i-1>0 then
                                            if j=0 then
                                              Tmp:=copy(Tmp,0,Length(Tmp)-5)
                                            else
                                              if j=i-1 then
                                                Tmp:=Separator+Copy(Tmp,2,Length(Tmp))
                                              else Tmp:=Separator+Copy(Tmp,2,Length(Tmp)-5);

                                          UnitedText:=UnitedText+Tmp;

                                          reMsrOtherInfo.Lines.EndUpdate; // !!!!!
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
                          TextStream:= TStringStream.Create(UnitedText);
                          try
                            reMsr.Lines.BeginUpdate; // !!!!
                            reMsr.Clear;
                            SendMessage(reMsr.Handle, WM_HSCROLL, SB_TOP, 0);
                            reMsr.Lines.LoadFromStream(TextStream);
                            MarkSearchedTextInRichEdit(edbxSearchName.Text, reMsr);
                            reMsr.WordWrap:=False;
                            reMsr.WordWrap:=True;
                            reMsr.Lines.EndUpdate; // !!!!
                          finally
                            TextStream.Free;
                          end;

                          lvMsr.Items.EndUpdate; // !!!!!

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
			            LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			            mysql_free_result(ResultSet);
		            end;
              ProgressBar1.Position:=ProgressBar1.Min;
            end;
          if not bError then
            begin
              if lvMsr.Items.Count>0 then
                begin
                  lvMsr.ItemIndex:=lvMsr.Items.IndexOf(lvMsr.TopItem);
                  lvMsr.ItemFocused:=lvMsr.TopItem;
                end;
            end;
          blvMsrRedrawNow:=False; // перерисовка окна результатов поиска отключена
          pnlSearchResultsCreationModificationResize(Sender);
          if not bError then
            begin
              // обновление значений панели организации
              btnCancel.Visible:=False;
              btnCancel.Enabled:=False;
              //очистка значений контролов
              lblId.Caption:='';
              lblCreation.Caption:='';
              lblModification.Caption:='';
			        cmbbxOrgType.Clear;
			        edbxOrgType.Clear;
			        edbxOrgName.Clear;
			        edbxOrgAddress.Clear;
              cmbbxOrgTown.Clear;
              edbxOrgTown.Clear;
              cmbbxOrgStreet.Clear;
              edbxOrgStreet.Clear;
              edbxOrgHouse.Clear;
              edbxOrgSubHouse.Clear;
              edbxOrgFlat.Clear;
			        edbxOrgHowToReach.Clear;
			        cmbbxOrgWorkTime.Clear;
			        edbxOrgWorkTime.Clear;
			        reOrgOtherInfo.Clear;
			        SetDefaultSettings(reOrgOtherInfo);
              LogThis('Попытка получения данных организации (ID#'+lvOrg.Selected.SubItems[2]+').',LogGroupGUID,lmtInfo);
			        q:='SELECT CONCAT(" ",TRIM(SUBSTRING_INDEX(f.name,"|",-1))), CONCAT(" ",TRIM(SUBSTRING_INDEX(f.name,"|",1))), _org_address, '+
              'a_c.name, a_s.name, f.house_num, f.house_sym, f.subhouse_num, f.subhouse_sym, f.flat_num, f.flat_sym, '+
              'org_how_to_reach, org_work_time, org_other_info, org_other_info_rtf, '+
              'CONCAT(c.usr_fullname,", ",org_created_at), CONCAT(m.usr_fullname,", ",org_modified_at) '+
              'FROM '+Configuration.sMySQLDatabase+'._org LEFT JOIN minsk.firma f ON firm_code=org_firm_code LEFT JOIN minsk.city a_c ON a_c.city_id=f.city_id and a_c.alt="0" '+
              'LEFT JOIN minsk.street a_s ON a_s.street_id=f.street_id LEFT JOIN '+Configuration.sMySQLDatabase+'._usr c ON c.usr_id=org_created_by_user_id '+
              'LEFT JOIN '+Configuration.sMySQLDatabase+'._usr m ON m.usr_id=org_modified_by_user_id WHERE org_id='+IntToStr(i_org_id)+';';
			        LogThis(q,LogGroupGUID,lmtSQL);
              i:=mysql_real_query(MySQLConnectionHandler,PChar(q),Length(q));
              if i=0 then
		            begin
			            LogThis('Запрос выполнен успешно.',LogGroupGUID,lmtInfo);
			            ResultSet:=mysql_store_result(MySQLConnectionHandler);
			            if ResultSet<>nil then
				            begin
					            LogThis('Результирующая выборка получена успешно.',LogGroupGUID,lmtInfo);
					            i:=mysql_num_rows(ResultSet);
					            if (i=1) then
						            begin
                          ProgressBar1.Max:=i;
                          ProgressBar1.Step:=1;
							            LogThis('Количество строк выборки равно '+IntToStr(i)+'.',LogGroupGUID,lmtInfo);
									        LogThis('Попытка получения строки выборки.',LogGroupGUID,lmtInfo);
									        ResultRow:=mysql_fetch_row(ResultSet);
                          if ResultRow<>nil then
										        begin
                              sOrgType:=ResultRow[0];

                              sOrgName:=ResultRow[1];

                              sOrgAddress:=ResultRow[2];

                              sOrgTown:=ResultRow[3];

                              sOrgStreet:=ResultRow[4];

                              sOrgHouse:=ResultRow[5];
                              if sOrgHouse='0' then
                                sOrgHouse:='';
                              sOrgHouse:=Trim(sOrgHouse+ResultRow[6]);
                              if sOrgHouse>'' then
                                sOrgHouse:=' '+sOrgHouse;

                              sOrgSubHouse:=ResultRow[7];
                              if sOrgSubHouse='0' then
                                sOrgSubHouse:='';
                              sOrgSubHouse:=Trim(sOrgSubHouse+ResultRow[8]);
                              if sOrgSubHouse>'' then
                                sOrgSubHouse:=' '+sOrgSubHouse;

                              sOrgFlat:=ResultRow[9];
                              if sOrgFlat='0' then
                                sOrgFlat:='';
                              sOrgFlat:=Trim(sOrgFlat+ResultRow[10]);
                              if sOrgFlat>'' then
                                sOrgFlat:=' '+sOrgFlat;

                              sOrgHowToReach:=ResultRow[11];

                              sOrgWorkTime:=ResultRow[12];

                              lblID.Caption:=lvOrg.Selected.SubItems[2];
                              lblCreation.Caption:=ResultRow[15];
											        lblModification.Caption:=ResultRow[16];
                              cmbbxOrgType.ItemIndex:=cmbbxOrgType.Items.Add(sOrgType);
                              edbxOrgType.Text:=sOrgType;
                              edbxOrgAddress.Text:=sOrgAddress;
                              cmbbxOrgTown.ItemIndex:=cmbbxOrgTown.Items.Add(sOrgTown);
                              edbxOrgTown.Text:=sOrgTown;
                              cmbbxOrgStreet.ItemIndex:=cmbbxOrgStreet.Items.Add(sOrgStreet);
                              edbxOrgStreet.Text:=sOrgStreet;
                              edbxOrgHouse.Text:=sOrgHouse;
                              edbxOrgSubHouse.Text:=sOrgSubHouse;
                              edbxOrgFlat.Text:=sOrgFlat;
                              cmbbxOrgWorkTime.ItemIndex:=cmbbxOrgWorkTime.Items.Add(sOrgWorkTime);
                              edbxOrgWorkTime.Text:=sOrgWorkTime;
                              edbxOrgName.Text:=sOrgName;
                              edbxOrgHowToReach.Text:=sOrgHowToReach;
                              reOrgOtherInfo.Lines.BeginUpdate;
                              if Length(ResultRow[14])=0 then
                                begin
                                  if ResultRow[13]<>'' then
                                    begin
                                      s:=ResultRow[13];
                                      s:=s+' ';
                                      HTMLtoRTF(s,reOrgOtherInfo);
                                    end;
                                end
                              else
                                begin
													        msA:=TMemoryStream.Create;
                                  try
                                    i:=StrLen(ResultRow[14]);
                                    msA.SetSize(i);
                                    msA.Seek(0, soFromBeginning);
                                    msA.Write(ResultRow[14]^,i);
                                    msA.Seek(0, soFromBeginning);
                                    reOrgOtherInfo.Lines.LoadFromStream(msA);
                                  finally
                                    msA.Free;
                                  end;
                                end;
                              if Configuration.bShowDataInOtherInfoPanel and (not CurrentUser.bDBEdition) then
                                begin
                                  // принцип таков
                                  // ставим курсор в самое начало и назинаем добавлять строки задом наперёд каждый раз в начало текста

                                  reOrgOtherInfo.SelStart:=0;
                                  reOrgOtherInfo.SelLength:=0;
                                  reOrgOtherInfo.Lines.Insert(0,#09+#09+#09+#09+#09+#09);
                                  reOrgOtherInfo.SelStart:=0;
                                  reOrgOtherInfo.SelLength:=Length(#09+#09+#09+#09+#09+#09);
                                  SetDefaultSettings(reOrgOtherInfo);
                                  reOrgOtherInfo.SelAttributes.Style:=[fsUnderline];

                                  // время работы
                                  if Trim(sOrgWorkTime)>'' then
                                    begin
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=0;
                                      reOrgOtherInfo.Lines.Insert(0,lblOrgWorkTime.Caption+': '+Trim(sOrgWorkTime));

                                      iSelLenght:=Length(lblOrgWorkTime.Caption+': '+Trim(sOrgWorkTime));
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Color:=clBlack;
                                      reOrgOtherInfo.Paragraph.Alignment:=taLeftJustify;
                                      reOrgOtherInfo.SelAttributes.Style:=[];

                                      iSelLenght:=Length(lblOrgWorkTime.Caption)+1;
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Style:=[fsBold];
                                    end;

                                  // как проекакь
                                  if Trim(sOrgHowToReach)>'' then
                                    begin
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=0;
                                      reOrgOtherInfo.Lines.Insert(0,lblOrgHowToReach.Caption+': '+Trim(sOrgHowToReach));

                                      iSelLenght:=Length(lblOrgHowToReach.Caption+': '+Trim(sOrgHowToReach));
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Color:=clBlack;
                                      reOrgOtherInfo.Paragraph.Alignment:=taLeftJustify;
                                      reOrgOtherInfo.SelAttributes.Style:=[];

                                      iSelLenght:=Length(lblOrgHowToReach.Caption)+1;
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Style:=[fsBold];
                                    end;



                                  // формирование строки адреса
                                  s1:='';
                                  if Trim(sOrgTown)>'' then
                                    begin
                                      if Trim(sOrgTown)='МИНСК ОИР' then
                                        s1:='г. Минск'
                                      else s1:=Trim(sOrgTown);
                                  end;
                                  if Trim(sOrgStreet)>'' then
                                    begin
                                      if s1>'' then
                                        begin
                                          if (Pos('ПРОСПЕКТ',Trim(sOrgStreet))>0) or
                                          (Pos('БУЛЬВАР',Trim(sOrgStreet))>0) or
                                          (Pos('ПРОЕЗД',Trim(sOrgStreet))>0) or
                                          (Pos('ПЕРЕУЛОК',Trim(sOrgStreet))>0) or
                                          (Pos('ПОСЕЛОК',Trim(sOrgStreet))>0) or
                                          (Pos('ШОССЕ',Trim(sOrgStreet))>0) or
                                          (Pos('ТУПИК',Trim(sOrgStreet))>0) or
                                          (Pos('ТРАКТ',Trim(sOrgStreet))>0) or
                                          (Pos('МИКРОРАЙОН',Trim(sOrgStreet))>0) or
                                          (Pos('ПЛОЩАДЬ',Trim(sOrgStreet))>0) or
                                          (Pos(' МЕТРО',Trim(sOrgStreet))>0) or
                                          (Pos(' КОЛЬЦО',Trim(sOrgStreet))>0) or
                                          (Pos('ДЕРЕВНЯ',Trim(sOrgStreet))>0) then
                                            s1:=s1+', '
                                          else s1:=s1+', ул. ';
                                        end;
                                      s1:=s1+Trim(sOrgStreet);
                                    end;
                                    if Trim(sOrgHouse)>'' then
                                      begin
                                        if s1>'' then
                                          s1:=s1+', д. ';
                                        s1:=s1+Trim(sOrgHouse);
                                      end;
                                    if Trim(sOrgSubHouse)>'' then
                                      begin
                                        if s1>'' then
                                          s1:=s1+', корп. ';
                                        s1:=s1+Trim(sOrgSubHouse);
                                      end;
                                    if Trim(sOrgFlat)>'' then
                                      begin
                                        if s1>'' then
                                          s1:=s1+', кв. ';
                                        s1:=s1+Trim(sOrgFlat);
                                      end;
                                    if Trim(sOrgAddress)>'' then
                                      begin
                                        if s1>'' then
                                          s1:=s1+' ';
                                        s1:=s1+'   [ '+Trim(sOrgAddress)+' ]';
                                      end;
                                  if Trim(s1)>'' then
                                    begin
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=0;
                                      reOrgOtherInfo.Lines.Insert(0,lblOrgAddress.Caption+': '+Trim(s1));

                                      iSelLenght:=Length(lblOrgAddress.Caption+': '+Trim(s1));
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Color:=clBlack;
                                      reOrgOtherInfo.Paragraph.Alignment:=taLeftJustify;
                                      reOrgOtherInfo.SelAttributes.Style:=[];

                                      iSelLenght:=Length(lblOrgAddress.Caption)+1;
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Style:=[fsBold];
                                    end;

                                  // наименование организации
                                  if Trim(sOrgName)>'' then
                                    begin
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=0;
                                      reOrgOtherInfo.Lines.Insert(0,lblOrgName.Caption+': '+Trim(sOrgName));

                                      iSelLenght:=Length(lblOrgName.Caption+': '+Trim(sOrgName));
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Color:=clBlack;
                                      reOrgOtherInfo.Paragraph.Alignment:=taLeftJustify;
                                      reOrgOtherInfo.SelAttributes.Style:=[];

                                      iSelLenght:=Length(lblOrgName.Caption)+1;
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Style:=[fsBold];
                                    end;

                                  // тип организации
                                  if Trim(sOrgType)>'' then
                                    begin
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=0;
                                      reOrgOtherInfo.Lines.Insert(0,lblOrgType.Caption+': '+Trim(sOrgType));

                                      iSelLenght:=Length(lblOrgType.Caption+': '+Trim(sOrgType));
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Color:=clBlack;
                                      reOrgOtherInfo.Paragraph.Alignment:=taLeftJustify;
                                      reOrgOtherInfo.SelAttributes.Style:=[];

                                      iSelLenght:=Length(lblOrgType.Caption)+1;
                                      reOrgOtherInfo.SelStart:=0;
                                      reOrgOtherInfo.SelLength:=iSelLenght;
                                      reOrgOtherInfo.SelAttributes.Style:=[fsBold];
                                    end;
                                end;
                              if Configuration.bMarkSearchedStrings and (not CurrentUser.bDBEdition) then
                                MarkSearchedTextInRichEdit(edbxSearchName.Text, reOrgOtherInfo);
                              reOrgOtherInfo.WordWrap:=False;
                              reOrgOtherInfo.WordWrap:=True;
                              reOrgOtherInfo.Lines.EndUpdate;
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
			            LogThis('Освобождение ресурсов, занятых результатом выборки...',LogGroupGUID,lmtInfo);
			            mysql_free_result(ResultSet);
		            end;
              ProgressBar1.Position:=ProgressBar1.Min;
            end;
  	      Screen.Cursor:=crDefault;
  	      if bError then
  		      begin
  			      LogThis(s,LogGroupGUID,lmtError);
              pnlEdit.Visible:=False;
              PageControl1.ActivePage:=tsClear;
  			      MessageBox(Handle,PChar(s),PChar('OA4 - Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
            end
          else
            begin
              // обновление значений панели данных
              pnlEdit.Visible:=CurrentUser.bDBEdition;
              PageControl1.ActivePage:=tsOrg;
              if CurrentUser.bDBEdition then
                begin
                  Panel3.Visible:=True;
                  pnlOrganizationGeneralInfo.Visible:=True;
                end
              else
                begin
                  Panel3.Visible:=not Configuration.bShowDataInOtherInfoPanel;
                  pnlOrganizationGeneralInfo.Visible:=not Configuration.bShowDataInOtherInfoPanel;
                end;
            end;
        end
      else
        begin
          pnlEdit.Visible:=False;
          PageControl1.ActivePage:=tsClear;
          reMsr.Clear;
          lvMsr.Clear;
        end;
    end;
  Update_PhonesMark;
  Update_OrgListCaption;
  Update_MsrListCaption;
end;

procedure TMainForm.dtpMsrStartDateChange(Sender: TObject);
var
  a1: Comp;
  a2: Int64 absolute a1;
  t1, t2: TTimeStamp;
begin
  dtpMsrStartDate.Time:=dtpMsrStartTime.Time;
  dtpMsrStopDate.Time:=dtpMsrStopTime.Time;
  dtpMsrStartTime.Date:=dtpMsrStartDate.Date;
  dtpMsrStopTime.Date:=dtpMsrStopDate.Date;
  if chkbxMsrStart.Checked and chkbxMsrStop.Checked then
    begin
      // получаем дату начала, дату конца и высчитываем длителность мероприятия
      t1:=DateTimeToTimeStamp(dtpMsrStartDate.DateTime);
      t2:=DateTimeToTimeStamp(dtpMsrStopDate.DateTime);
      a1:=TimeStampToMSecs(t2)-TimeStampToMSecs(t1);
      if (a2>0) then
        begin
          spedMsrDurationDays.Value:=Int64(a2) div Int64(86400000);
          a2:=Int64(a2)-Int64((Int64(spedMsrDurationDays.Value)*Int64(86400000)));
          spedMsrDurationHours.Value:=a2 div 3600000;
          a2:=a2-spedMsrDurationHours.Value*3600000;
          spedMsrDurationMinutes.Value:=a2 div 60000;
        end
      else
        begin
          dtpMsrStopDate.DateTime:=dtpMsrStartDate.DateTime;
          dtpMsrStopTime.DateTime:=dtpMsrStartTime.DateTime;
          spedMsrDurationDays.Value:=0;
          spedMsrDurationHours.Value:=0;
          spedMsrDurationMinutes.Value:=0;
        end;
    end
  else
    begin
      spedMsrDurationDays.Value:=0;
      spedMsrDurationHours.Value:=0;
      spedMsrDurationMinutes.Value:=0;
    end;
end;

procedure TMainForm.TryToSet_edbxSearchName_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{93BE030F-94AA-4465-8AF9-0AAC0189CDA2}';
  LogThis('[Процедура установки фокуса ввода на строку поиска по наименованию]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if edbxSearchName.Visible and edbxSearchName.Enabled then
    edbxSearchName.SetFocus;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.TryToSet_lvOrg_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{CB297F79-10A4-4422-AA1C-90DDA55AF6AB}';
  LogThis('[Процедура установки фокуса ввода на список организаций]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if lvOrg.Visible and lvOrg.Enabled then
    lvOrg.SetFocus;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.TryToSet_lvMsr_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{923B6A3A-0610-4C61-AAC6-6DC881DB71F7}';
  LogThis('[Процедура установки фокуса ввода на список мероприятий]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if lvMsr.Visible and lvMsr.Enabled then
    lvMsr.SetFocus;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.TryToSet_reMsr_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{FF2B3DF6-76A2-4A44-A2F6-A3B9EEF085BC}';
  LogThis('[Процедура установки фокуса ввода на развёрнутый список мероприятий]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if reMsr.Visible and reMsr.Enabled then
    begin
      reMsr.SelStart:=0;
      reMsr.SelLength:=0;
      reMsr.SetFocus;
    end;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.TryToSet_reOrgOtherInfo_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{728E8871-5212-4CE3-96FD-12BE74172A83}';
  LogThis('[Процедура установки фокуса ввода на поле ввода прочей информации об организации]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if reOrgOtherInfo.Visible and reOrgOtherInfo.Enabled then
    begin
      reOrgOtherInfo.SelStart:=0;
      reOrgOtherInfo.SelLength:=0;
      reOrgOtherInfo.SetFocus;
    end;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.TryToSet_reMsrOtherInfo_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{EDEDB408-AE36-4F0A-9029-0AA731134319}';
  LogThis('[Процедура установки фокуса ввода на поле ввода прочей информации о мероприятии]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if reMsrOtherInfo.Visible and reMsrOtherInfo.Enabled then
    begin
      reMsrOtherInfo.SelStart:=0;
      reMsrOtherInfo.SelLength:=0;
      reMsrOtherInfo.SetFocus;
    end;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.TryToSet_cmbbxOrgType_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{F946ADB3-5DE7-4C01-9355-1811523556A3}';
  LogThis('[Процедура установки фокуса ввода на строку выпадающего списка типов организаций]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if cmbbxOrgType.Visible and cmbbxOrgType.Enabled then
    cmbbxOrgType.SetFocus;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.TryToSet_edbxOrgType_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{19466E9D-4E8F-44BD-8683-D069E3F85581}';
  LogThis('[Процедура установки фокуса ввода на строку типов организаций]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if edbxOrgType.Visible and edbxOrgType.Enabled then
    edbxOrgType.SetFocus;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.TryToSet_cmbbxMsrType_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{9250C5EC-E9A5-4484-B864-8ED09765FE70}';
  LogThis('[Процедура установки фокуса ввода на строку выпадающего списка типов мероприятий]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if cmbbxMsrType.Visible and cmbbxMsrType.Enabled then
    cmbbxMsrType.SetFocus;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.TryToSet_edbxMsrType_Focused;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{E297A6A6-5617-4853-A9D3-A73147143D9B}';
  LogThis('[Процедура установки фокуса ввода на строку типов мероприятий]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if edbxMsrType.Visible and edbxMsrType.Enabled then
    edbxMsrType.SetFocus;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.miGoToSearchStringClick(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{8E45CC95-33A1-484A-A960-CD2E1A630B99}';
  LogThis('[Процедура передачи фокуса ввода в панель поиска главной формы]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

	if pnlConnectedMode.Visible then
    TryToSet_edbxSearchName_Focused;

  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.miGoToOrgPanelClick(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{0F7E6BF6-C7CB-48AB-BC7A-DFF14250B9BC}';
  LogThis('[Процедура передачи фокуса ввода в панель организаций главной формы]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

  if pnlConnectedMode.Visible and (lvOrg.Items.Count>0) then
    TryToSet_lvOrg_Focused;

  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.miGoToMsrPanelClick(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{67FC9C0B-DB14-4B13-AF14-0A54C5EF1DEC}';
  LogThis('[Процедура передачи фокуса ввода в панель мероприятий главной формы]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

	if pnlConnectedMode.Visible and (lvMsr.Items.Count>0) then
    if (not CurrentUser.bDBEdition) and Configuration.bShowMeasuresListAsRichEdit then
      TryToSet_reMsr_Focused
    else TryToSet_lvMsr_Focused;

  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.miGoToDataPanelClick(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{A17BA54E-EB4C-4AAB-A5F0-7D52493EC887}';
  LogThis('[Процедура передачи фокуса ввода в панель данных главной формы]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

  if pnlConnectedMode.Visible then
    begin
      if PageControl1.ActivePage=tsOrg then
        if pnlOrganizationGeneralInfo.Visible then
          if CurrentUser.bDBEdition then
            TryToSet_cmbbxOrgType_Focused
          else TryToSet_edbxOrgType_Focused
        else TryToSet_reOrgOtherInfo_Focused;
      if PageControl1.ActivePage=tsMsr then
        if pnlMesureGeneralInfo.Visible then
          if CurrentUser.bDBEdition then
            TryToSet_cmbbxMsrType_Focused
          else TryToSet_edbxMsrType_Focused
        else TryToSet_reMsrOtherInfo_Focused;
    end;

  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.Update_OrgListCaption;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{2D60BB49-C75A-4954-BB62-C78F4F2D8C28}';
  LogThis('[Процедура обновления количества элементов и порядкового номера текущего элемента списка организаций]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if (lvOrg.Items.Count>0) and (lvOrg.Selected<>nil) then
    begin
      lblOrgListCaption.Caption:=' Список организаций ('+IntToStr(lvOrg.Items.Count)+'/'+IntToStr(lvOrg.Selected.Index+1)+') ';
      LogThis('Полученная строка - <'+IntToStr(lvOrg.Items.Count)+'/'+IntToStr(lvOrg.Selected.Index+1)+'>.',LogGroupGUID,lmtInfo);
    end
  else
    begin
      lblOrgListCaption.Caption:=' Список организаций ('+IntToStr(lvOrg.Items.Count)+') ';
      LogThis('Полученная строка - <'+IntToStr(lvOrg.Items.Count)+'>.',LogGroupGUID,lmtInfo);
    end;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.Update_MsrListCaption;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{FDDE6E50-8AAB-4338-A0ED-88807B00E46B}';
  LogThis('[Процедура обновления количества элементов и порядкового номера текущего элемента списка мероприятий]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if ((lvMsr.Items.Count>0) and (lvMsr.Selected<>nil) and lvMsr.Visible) then
    begin
      lblMsrListCaption.Caption:=' Список мероприятий ('+IntToStr(lvMsr.Items.Count)+'/'+IntToStr(lvMsr.Selected.Index+1)+') ';
      LogThis('Полученная строка - <'+IntToStr(lvMsr.Items.Count)+'/'+IntToStr(lvMsr.Selected.Index+1)+'>.',LogGroupGUID,lmtInfo);
    end
  else
    begin
      lblMsrListCaption.Caption:=' Список мероприятий ('+IntToStr(lvMsr.Items.Count)+') ';
      LogThis('Полученная строка - <'+IntToStr(lvMsr.Items.Count)+'>.',LogGroupGUID,lmtInfo);
    end;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.ShowEditBaloonTip(aEdit: TEdit; aTitle, aText: string; aIconType: tTTI);
var
  aEDITBALLOONTIP: EDITBALLOONTIP;
  pwcTitle, pwcText: PWideChar;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{062C6F3D-3786-426A-A601-6EAC73D4AF22}';
  LogThis('[Процедура отображения всплывающей подсказки поля ввода]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  GetMem(pwcTitle, SizeOf(WideChar)*1000);
  GetMem(pwcText, SizeOf(WideChar)*1000);
  try
    FillChar(aEDITBALLOONTIP, SizeOf(aEDITBALLOONTIP), 0);
    aEDITBALLOONTIP.cbStruct:=SizeOf(aEDITBALLOONTIP);
    aEDITBALLOONTIP.pszTitle:=StringToWideChar(aTitle, pwcTitle, 1000);;
    aEDITBALLOONTIP.pszText:=StringToWideChar(aText, pwcText, 1000);;
    aEDITBALLOONTIP.ttiIcon:=integer(aIconType);
    SendMessage(aEdit.Handle,EM_SHOWBALLOONTIP,WPARAM(0),LPARAM(@aEDITBALLOONTIP));
  finally
    FreeMem(pwcText);
    FreeMem(pwcTitle);
  end;

  MainForm.LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.HideEditBaloonTip(aEdit: TEdit);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{3B861384-5961-4F64-9686-BBDE9485B116}';
  LogThis('[Процедура скрытия всплывающей подсказки поля ввода]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  SendMessage(aEdit.Handle, EM_HIDEBALLOONTIP, WPARAM(0), LPARAM(0));

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{BE603527-6A49-42B5-B9DC-1AEC461FA7FB}';
  LogThis('[Процедура обработки нажатия клавиши клавиатуры в основном окне приложения]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  if Key=VK_ESCAPE then
    begin
      if bDoubleESC then
        begin
          LogThis('Зафиксировано повторное нажатие клавиши ESC.',LogGroupGUID,lmtInfo);
          UpdateSearchBar;
	        if pnlConnectedMode.Visible then
            TryToSet_edbxSearchName_Focused;
          LogThis('Выполнена очистка полей ввода панели поиска',LogGroupGUID,lmtInfo);
          bDoubleESC:=False;
        end
      else
        begin
          LogThis('Зафиксировано одиночное нажатие клавиши ESC.',LogGroupGUID,lmtInfo);
          bDoubleESC:=True;
        end;
    end
  else bDoubleESC:=False;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.UpdateSearchBar;
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{51DCB6AF-44E7-47C2-A2C5-7123D22602A6}';
  LogThis('[Процедура обновления элементов интерфейса панели поиска]', LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  chkbxPremier.Visible:=True;
  chkbxChildren.Visible:=True;
  chkbxTeenagers.Visible:=True;
  chkbxTour.Visible:=True;
  chkbxAdultsOnly.Visible:=True;
  chkbxHideErased.Visible:=CurrentUser.bDBEdition;
  chkbxHideOld.Visible:=True;

  slLastSearchedName.Clear;
  slLastSearchedAddress.Clear;
  slLastSearchedOther.Clear;

  edbxSearchName.Clear;
  edbxSearchAddress.Clear;
  edbxSearchOther.Clear;

  if Configuration.bShowSearchAddressOtherEditBox then
    begin
      edbxSearchName.Width:=145;
      edbxSearchAddress.Visible:=True;
      edbxSearchOther.Visible:=True;
      edbxSearchAddress.Top:=edbxSearchName.Top;
      edbxSearchOther.Top:=edbxSearchName.Top;
    end
  else
    begin
      edbxSearchAddress.Visible:=False;
      edbxSearchOther.Visible:=False;
      edbxSearchName.Width:=447;
    end;

  chkbxStartDate.Checked:=False;
  dtpStartDate.DateTime:=Now();
  dtpStartDate.Time:=EncodeTime(0,0,0,0);
  chkbxStopDate.Checked:=False;
  dtpStopDate.DateTime:=Now();
  dtpStopDate.Time:=EncodeTime(23,59,59,0);
  chkbxPremier.Checked:=False;
  chkbxChildren.Checked:=False;
  chkbxTeenagers.Checked:=False;
  chkbxTour.Checked:=False;
  chkbxAdultsOnly.Checked:=False;
  chkbxHideErased.Checked:=False;
  chkbxHideOld.Checked:=not CurrentUser.bDBEdition;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.LoadConfigIni;
var
  IniFile: TIniFile;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{63E75C26-0624-4CCF-98F8-C25DF139C061}';
  LogThis('[Процедура чтения конфигурации из файла *.ini]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  IniFile:=TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4.ini');
  with IniFile do
    try
      Configuration.bStoreLastLogin:=ReadBool('Интерфейс','bStoreLastLogin',False);
      Configuration.sLastLogin:=ReadString('Интерфейс','sLastLogin','');
      Configuration.bStoreLastPassword:=ReadBool('Интерфейс','bStoreLastPassword',False);
      Configuration.sLastPassword:=ReadString('Интерфейс','sLastPassword','');
      Configuration.bAutoLogon:=ReadBool('Интерфейс','bAutoLogon',False);
      Configuration.bShowDataInOtherInfoPanel:=ReadBool('Интерфейс','bShowDataInOtherInfoPanel',False);
      Configuration.bShowMeasuresListAsRichEdit:=ReadBool('Интерфейс','bShowMeasuresListAsRichEdit',False);
      Configuration.bMarkSearchedStrings:=ReadBool('Интерфейс','bMarkSearchedStrings',False);
      Configuration.bPutTownAtTheEnd:=ReadBool('Интерфейс','bPutTownAtTheEnd',False);
      Configuration.bHideEditBoxToolTips:=ReadBool('Интерфейс','bHideEditBoxToolTips',False);
      Configuration.bShowSearchAddressOtherEditBox:=ReadBool('Интерфейс','bShowSearchAddressOtherEditBox',False);
      Configuration.iOrgSortColumn:=ReadInteger('Интерфейс','iOrgSortColumn',0);
      Configuration.iMsrSortColumn:=ReadInteger('Интерфейс','iMsrSortColumn',0);
      Configuration.bNoToolBar:=ReadBool('Интерфейс','bNoToolBar',False);
      Configuration.bNoStatusBar:=ReadBool('Интерфейс','bNoStatusBar',False);

      Configuration.fpMainForm.x:=ReadInteger('Интерфейс','iMainFormX',0);
      Configuration.fpMainForm.y:=ReadInteger('Интерфейс','iMainFormY',0);
      Configuration.fpMainForm.bCenter:=ReadBool('Интерфейс','bMainFormCenter',True);

      Configuration.iMainFormWidth:=ReadInteger('Интерфейс','iMainFormWidth',DEFAULT_MAINFORMWIDTH);
      Configuration.iMainFormHeight:=ReadInteger('Интерфейс','iMainFormHeight',DEFAULT_MAINFORMHEIGHT);
      Configuration.bFullScreen:=ReadBool('Интерфейс','bFullScreen',False);

      Configuration.iOrgPanelHeight:=ReadInteger('Интерфейс','iOrgPanelHeight',100);
      Configuration.bOrgPanelHalfHeight:=ReadBool('Интерфейс','bOrgPanelHalfHeight',True);
      Configuration.iDataPanelWidth:=ReadInteger('Интерфейс','iDataPanelWidth',DEFAULT_DATAPANELWIDTH);
      Configuration.bDataPanelHalfWidth:=ReadBool('Интерфейс','bDataPanelHalfWidth',False);

      Configuration.fpLoginForm.x:=ReadInteger('Интерфейс','iLoginFormX',0);
      Configuration.fpLoginForm.y:=ReadInteger('Интерфейс','iLoginFormY',0);
      Configuration.fpLoginForm.bCenter:=ReadBool('Интерфейс','bLoginFormCenter',True);

      Configuration.fpOptionsForm.x:=ReadInteger('Интерфейс','iOptionsFormX',0);
      Configuration.fpOptionsForm.y:=ReadInteger('Интерфейс','iOptionsFormY',0);
      Configuration.fpOptionsForm.bCenter:=ReadBool('Интерфейс','bOptionsFormCenter',True);

      Configuration.fpUsersForm.x:=ReadInteger('Интерфейс','iUsersForm',0);
      Configuration.fpUsersForm.y:=ReadInteger('Интерфейс','iUsersForm',0);
      Configuration.fpUsersForm.bCenter:=ReadBool('Интерфейс','bUsersFormCenter',True);

      Configuration.fpSetPasswordForm.x:=ReadInteger('Интерфейс','iSetPasswordForm',0);
      Configuration.fpSetPasswordForm.y:=ReadInteger('Интерфейс','iSetPasswordForm',0);
      Configuration.fpSetPasswordForm.bCenter:=ReadBool('Интерфейс','bSetPasswordFormCenter',True);

      Configuration.fpSetPasswordForm.x:=ReadInteger('Интерфейс','iSetPasswordForm',0);
      Configuration.fpSetPasswordForm.y:=ReadInteger('Интерфейс','iSetPasswordForm',0);
      Configuration.fpSetPasswordForm.bCenter:=ReadBool('Интерфейс','bSetPasswordFormCenter',True);

      Configuration.fpStatisticForm.x:=ReadInteger('Интерфейс','iStatisticForm',0);
      Configuration.fpStatisticForm.y:=ReadInteger('Интерфейс','iStatisticForm',0);
      Configuration.fpStatisticForm.bCenter:=ReadBool('Интерфейс','bStatisticFormCenter',True);

      Configuration.fpMaintenanceForm.x:=ReadInteger('Интерфейс','iMaintenanceForm',0);
      Configuration.fpMaintenanceForm.y:=ReadInteger('Интерфейс','iMaintenanceForm',0);
      Configuration.fpMaintenanceForm.bCenter:=ReadBool('Интерфейс','bMaintenanceFormCenter',True);

      Configuration.fpClearingForm.x:=ReadInteger('Интерфейс','iClearingForm',0);
      Configuration.fpClearingForm.y:=ReadInteger('Интерфейс','iClearingForm',0);
      Configuration.fpClearingForm.bCenter:=ReadBool('Интерфейс','bClearingFormCenter',True);

      Configuration.fpViewPostListForm.x:=ReadInteger('Интерфейс','iViewPostListForm',0);
      Configuration.fpViewPostListForm.y:=ReadInteger('Интерфейс','iViewPostListForm',0);
      Configuration.fpViewPostListForm.bCenter:=ReadBool('Интерфейс','bViewPostListFormCenter',True);

      Configuration.fpCreateViewPostForm.x:=ReadInteger('Интерфейс','iCreateViewPostForm',0);
      Configuration.fpCreateViewPostForm.y:=ReadInteger('Интерфейс','iCreateViewPostForm',0);
      Configuration.fpCreateViewPostForm.bCenter:=ReadBool('Интерфейс','bCreateViewPostFormCenter',True);

      Configuration.fpPhonesForm.x:=ReadInteger('Интерфейс','iPhonesForm',0);
      Configuration.fpPhonesForm.y:=ReadInteger('Интерфейс','iPhonesForm',0);
      Configuration.fpPhonesForm.bCenter:=ReadBool('Интерфейс','bPhonesFormCenter',True);

      Configuration.fpAddEditPhoneForm.x:=ReadInteger('Интерфейс','iAddEditPhoneForm',0);
      Configuration.fpAddEditPhoneForm.y:=ReadInteger('Интерфейс','iAddEditPhoneForm',0);
      Configuration.fpAddEditPhoneForm.bCenter:=ReadBool('Интерфейс','bAddEditPhoneFormCenter',True);

      Configuration.sMySQLHost:=ReadString('Сервер и база данных','sMySQLHost','');
      Configuration.iMySQLPort:=ReadInteger('Сервер и база данных','iMySQLPort',MYSQL_PORT);
      Configuration.iMySQLTimeout:=ReadInteger('Сервер и база данных','iMySQLTimeout',30);
      Configuration.bMySQLCompress:=ReadBool('Сервер и база данных','bMySQLCompress',True);
      Configuration.sMySQLDatabase:=ReadString('Сервер и база данных','sMySQLDatabase','');
      Configuration.sMySQLUser:=ReadString('Сервер и база данных','sMySQLUser','');
      Configuration.sMySQLPassword:=ReadString('Сервер и база данных','sMySQLPassword','');

      Configuration.bNoLogo:=ReadBool('Прочее','bNoLogo',False);
      Configuration.bShowID:=ReadBool('Прочее','bShowID',False);
      Configuration.sCustomHelpFile:=ReadString('Прочее','sCustomHelpFile','');

      Configuration.bUseLog:=ReadBool('Лог-клиент','bUseLog',True);
      Configuration.sCustomLogClientFile:=ReadString('Лог-клиент','sCustomLogClientFile','');

      LogThis('Конфигурация считана успешно.',LogGroupGUID,lmtInfo);
    finally
      Free;
    end;
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.SaveConfigIni;
var
  IniFile: TIniFile;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{95BD6C93-11E1-4421-B293-7D6E4AF858C1}';
  LogThis('[Процедура сохранения конфигурации в файл *.ini]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  Application.ProcessMessages;

  IniFile:=TIniFile.Create(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4.ini');
  LogThis('Путь и имя файла конфигурации: ['+IniFile.FileName+'].',LogGroupGUID,lmtInfo);
  with IniFile do
    try
      WriteBool('Интерфейс','bStoreLastLogin',Configuration.bStoreLastLogin);
      if Configuration.bStoreLastLogin then
        WriteString('Интерфейс','sLastLogin',Configuration.sLastLogin)
      else DeleteKey('Интерфейс','sLastLogin');
      WriteBool('Интерфейс','bStoreLastPassword',Configuration.bStoreLastPassword);
      if Configuration.bStoreLastPassword then
        WriteString('Интерфейс','sLastPassword',Configuration.sLastPassword)
      else DeleteKey('Интерфейс','sLastPassword');
      if Configuration.bAutoLogon then
        WriteBool('Интерфейс','bAutoLogon',Configuration.bAutoLogon)
      else DeleteKey('Интерфейс','bAutoLogon');
      WriteBool('Интерфейс','bShowDataInOtherInfoPanel',Configuration.bShowDataInOtherInfoPanel);
      WriteBool('Интерфейс','bShowMeasuresListAsRichEdit',Configuration.bShowMeasuresListAsRichEdit);
      WriteBool('Интерфейс','bMarkSearchedStrings',Configuration.bMarkSearchedStrings);
      WriteBool('Интерфейс','bPutTownAtTheEnd',Configuration.bPutTownAtTheEnd);
      WriteBool('Интерфейс','bHideEditBoxToolTips',Configuration.bHideEditBoxToolTips);
      WriteBool('Интерфейс','bShowSearchAddressOtherEditBox',Configuration.bShowSearchAddressOtherEditBox);
      WriteInteger('Интерфейс','iOrgSortColumn',Configuration.iOrgSortColumn);
      WriteInteger('Интерфейс','iMsrSortColumn',Configuration.iMsrSortColumn);
      WriteBool('Интерфейс','bNoToolBar',Configuration.bNoToolBar);
      WriteBool('Интерфейс','bNoStatusBar',Configuration.bNoStatusBar);

      WriteBool('Интерфейс','bFullScreen',Configuration.bFullScreen);

      WriteInteger('Интерфейс','iMainFormWidth',Configuration.iMainFormWidth);
      WriteInteger('Интерфейс','iMainFormHeight',Configuration.iMainFormHeight);

      Configuration.fpMainForm.x:=MainForm.Left;
      Configuration.fpMainForm.y:=MainForm.Top;
      WriteInteger('Интерфейс','iMainFormX',Configuration.fpMainForm.x);
      WriteInteger('Интерфейс','iMainFormY',Configuration.fpMainForm.y);
      WriteBool('Интерфейс','bMainFormCenter',Configuration.fpMainForm.bCenter);

      WriteInteger('Интерфейс','iOrgPanelHeight',Configuration.iOrgPanelHeight);
      WriteBool('Интерфейс','bOrgPanelHalfHeight',Configuration.bOrgPanelHalfHeight);
      WriteInteger('Интерфейс','iDataPanelWidth',Configuration.iDataPanelWidth);
      WriteBool('Интерфейс','bDataPanelHalfWidth',Configuration.bDataPanelHalfWidth);

      WriteInteger('Интерфейс','iLoginFormX',Configuration.fpLoginForm.x);
      WriteInteger('Интерфейс','iLoginFormY',Configuration.fpLoginForm.y);
      WriteBool('Интерфейс','bLoginFormCenter',Configuration.fpLoginForm.bCenter);

      WriteInteger('Интерфейс','iOptionsFormX',Configuration.fpOptionsForm.x);
      WriteInteger('Интерфейс','iOptionsFormY',Configuration.fpOptionsForm.y);
      WriteBool('Интерфейс','bOptionsFormCenter',Configuration.fpOptionsForm.bCenter);

      WriteInteger('Интерфейс','iUsersForm',Configuration.fpUsersForm.x);
      WriteInteger('Интерфейс','iUsersForm',Configuration.fpUsersForm.y);
      WriteBool('Интерфейс','bUsersFormCenter',Configuration.fpUsersForm.bCenter);

      WriteInteger('Интерфейс','iSetPasswordForm',Configuration.fpSetPasswordForm.x);
      WriteInteger('Интерфейс','iSetPasswordForm',Configuration.fpSetPasswordForm.y);
      WriteBool('Интерфейс','bSetPasswordFormCenter',Configuration.fpSetPasswordForm.bCenter);

      WriteInteger('Интерфейс','iSetPasswordForm',Configuration.fpSetPasswordForm.x);
      WriteInteger('Интерфейс','iSetPasswordForm',Configuration.fpSetPasswordForm.y);
      WriteBool('Интерфейс','bSetPasswordFormCenter',Configuration.fpSetPasswordForm.bCenter);

      WriteInteger('Интерфейс','iStatisticForm',Configuration.fpStatisticForm.x);
      WriteInteger('Интерфейс','iStatisticForm',Configuration.fpStatisticForm.y);
      WriteBool('Интерфейс','bStatisticFormCenter',Configuration.fpStatisticForm.bCenter);

      WriteInteger('Интерфейс','iMaintenanceForm',Configuration.fpMaintenanceForm.x);
      WriteInteger('Интерфейс','iMaintenanceForm',Configuration.fpMaintenanceForm.y);
      WriteBool('Интерфейс','bMaintenanceFormCenter',Configuration.fpMaintenanceForm.bCenter);

      WriteInteger('Интерфейс','iClearingForm',Configuration.fpClearingForm.x);
      WriteInteger('Интерфейс','iClearingForm',Configuration.fpClearingForm.y);
      WriteBool('Интерфейс','bClearingFormCenter',Configuration.fpClearingForm.bCenter);

      WriteInteger('Интерфейс','iViewPostListForm',Configuration.fpViewPostListForm.x);
      WriteInteger('Интерфейс','iViewPostListForm',Configuration.fpViewPostListForm.y);
      WriteBool('Интерфейс','bViewPostListFormCenter',Configuration.fpViewPostListForm.bCenter);

      WriteInteger('Интерфейс','iCreateViewPostForm',Configuration.fpCreateViewPostForm.x);
      WriteInteger('Интерфейс','iCreateViewPostForm',Configuration.fpCreateViewPostForm.y);
      WriteBool('Интерфейс','bCreateViewPostFormCenter',Configuration.fpCreateViewPostForm.bCenter);

      WriteInteger('Интерфейс','iPhonesForm',Configuration.fpPhonesForm.x);
      WriteInteger('Интерфейс','iPhonesForm',Configuration.fpPhonesForm.y);
      WriteBool('Интерфейс','bPhonesFormCenter',Configuration.fpPhonesForm.bCenter);

      WriteInteger('Интерфейс','iAddEditPhoneForm',Configuration.fpAddEditPhoneForm.x);
      WriteInteger('Интерфейс','iAddEditPhoneForm',Configuration.fpAddEditPhoneForm.y);
      WriteBool('Интерфейс','bAddEditPhoneFormCenter',Configuration.fpAddEditPhoneForm.bCenter);

      WriteString('Сервер и база данных','sMySQLHost',Configuration.sMySQLHost);
      WriteString('Сервер и база данных','sMySQLHost',Configuration.sMySQLHost);
      WriteInteger('Сервер и база данных','iMySQLPort',Configuration.iMySQLPort);
      WriteInteger('Сервер и база данных','iMySQLTimeout',Configuration.iMySQLTimeout);
      WriteBool('Сервер и база данных','bMySQLCompress',Configuration.bMySQLCompress);
      WriteString('Сервер и база данных','sMySQLDatabase',Configuration.sMySQLDatabase);
      WriteString('Сервер и база данных','sMySQLUser',Configuration.sMySQLUser);
      WriteString('Сервер и база данных','sMySQLPassword',Configuration.sMySQLPassword);

      WriteBool('Прочее','bNoLogo',Configuration.bNoLogo);
      WriteBool('Прочее','bShowID',Configuration.bShowID);
      WriteString('Прочее','sCustomHelpFile',Configuration.sCustomHelpFile);
      if FileExists(Configuration.sCustomHelpFile) then
        Application.HelpFile:=Configuration.sCustomHelpFile;
      WriteBool('Лог-клиент','bUseLog',Configuration.bUseLog);
      WriteString('Лог-клиент','sCustomLogClientFile',Configuration.sCustomLogClientFile);
      LogThis('Конфигурация сохранена успешно.',LogGroupGUID,lmtInfo);
    finally
      Free;
    end;

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
var
  a: ATOM;
  b: boolean;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{98820E3D-0168-459B-8902-19391BEFBDDE}';
  LogThis('[Процедура завершения работы приложения]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

  b:=False;
  CanClose:=False;
  if not Configuration.bImmediatelyQuit then
    begin
      Screen.Cursor:=crDefault;
      b:=MessageBox(Handle,PChar('Вы действительно хотите завершить работу программы?'),PChar('OA4 - Подтверждение выхода'),MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK;
      Screen.Cursor:=crHourGlass;
      if b then
        LogThis('Завершение работы приложения было подтверждено.',LogGroupGUID,lmtInfo)
      else LogThis('Завершение работы приложения было отменено пользователем.',LogGroupGUID,lmtInfo);
    end
  else LogThis('Завершение работы приложения было подтверждено программой (установлен флаг немедленного выхода).',LogGroupGUID,lmtInfo);
  if (Configuration.bImmediatelyQuit or b) then
    begin
      if Action_DB_Disconnection.Visible then
        Action_DB_Disconnection.Execute;
      CanClose:=True;
    end;
  if CanClose then
    begin
      SaveConfigIni;

      slLastSearchedName.Free;
      slLastSearchedAddress.Free;
      slLastSearchedOther.Free;

      // отправка сообщения программе Log Server о том, что было инициировано нормальное завершение работы
      LogThis('Попытка создания атома "OA4NormalShutdown"...',LogGroupGUID,lmtInfo);
      a:=GlobalAddAtom('OA4NormalShutdown');
      if a=0 then
        LogThis('Возникла ошибка при создании атома "OA4NormalShutdown"!',LogGroupGUID,lmtError)
      else LogThis('Атом "OA4NormalShutdown" был создан успешно.',LogGroupGUID,lmtInfo);
      LogThis('Производится завершение работы приложения...',LogGroupGUID,lmtInfo);
    end
  else LogThis('Разрешение на завершение работы приложения не было получено!',LogGroupGUID,lmtInfo);

  SetReady(LogGroupGUID);
  Screen.Cursor:=crDefault;
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.Action_DB_UsersExecute(Sender: TObject);
var
  LogGroupGUID: string;
begin
  LogGroupGUID:='{5C035718-6065-4D40-9676-41467EB8AC50}';
  LogThis('[Процедура открытия окна "'+Action_DB_Users.Caption+'"]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

  with TUsersForm.Create(Owner) do
    try
      ImageList2.GetIcon(4,Icon);
      if Configuration.fpUsersForm.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          Top:=Configuration.fpUsersForm.y;
          Left:=Configuration.fpUsersForm.x;
        end;
      btnHelp.Enabled:=Application.HelpFile<>'';
      Screen.Cursor:=crDefault;
      ShowModal;
    finally
      Screen.Cursor:=crHourGlass;
      Configuration.fpUsersForm.y:=Top;
      Configuration.fpUsersForm.x:=Left;
      Free;
    end;
  Update_Actions;

  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.WMCopyData(var Msg: TWMCopyData);
var
  cText: array[0..1023] of Char;
  sData: string;
  ch0: Char;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{CF997A1C-AE2D-46F2-80FA-BC47740D0C47}';
  SetForegroundWindow(Application.Handle);
  LogThis('[Процедура получения данных из внешнего процесса]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);
  SetBusy(LogGroupGUID);
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

  StrLCopy(cText, Msg.CopyDataStruct.lpData, Msg.CopyDataStruct.cbData);
  LogThis(PChar('Данные, полученые из внешнего процесса: ['+cText+']'),LogGroupGUID,lmtInfo);

  UpdateSearchBar;
  ch0:=cText[0];
  if ((ch0 in ['1'..'7']) and (cText[1]=':')) then
    begin
      sData:=Copy(cText,3,Length(cText)-3);
      LogThis(PChar('Данные прошли валидацию.'),LogGroupGUID,lmtInfo);
      case ch0 of
        '1': // INFO_GET_FIRMA_BY_CODE		=1;
          begin
            LogThis(PChar('Получена команда получения информации об организации с кодом фирмы равным ['+sData+'].'),LogGroupGUID,lmtInfo);
          end;
        '2': // INFO_GET_OTDEL_BY_CODE		=2;
          begin
            LogThis(PChar('Получена команда получения информации о мероприятии с кодом отдела равным ['+sData+'].'),LogGroupGUID,lmtInfo);
          end;
        '3': LogThis(PChar('Получена команда получения информации о фирме по номеру телефона ['+sData+'].'),LogGroupGUID,lmtInfo); // INFO_GET_FIRMA_BY_PHONE=3;
        '4': LogThis(PChar('Получена команда получения информации об абоненте по номеру телефона ['+sData+'].'),LogGroupGUID,lmtInfo); // INFO_GET_ABON_BY_PHONE=4;
        '5': LogThis(PChar('Получена команда получения информации о фирме по наименованию ['+sData+'].'),LogGroupGUID,lmtInfo); // INFO_GET_FIRMA_BY_NAME=5;
        '6': LogThis(PChar('Получена команда отправки номера телефона ['+sData+'] на речевую карту.'),LogGroupGUID,lmtInfo); // INFO_GET_PRONOUNCE_PHONE=6;
        '7': LogThis(PChar('Получена команда соединения входящего соединения с номером телефона ['+sData+'].'),LogGroupGUID,lmtInfo); // INFO_GET_CONNECT_PHONE=7;
      end;
    end
  else LogThis(PChar('Данные не прошли валидацию!'),LogGroupGUID,lmtWarning);

  Screen.Cursor:=crDefault;
  SetReady(LogGroupGUID);
  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

procedure TMainForm.MarkSearchedTextInRichEdit(aString: string; aRichEdit: TRichEdit);
var
  aSL: TStringList;
  i, j: integer;
  aRichEdit_UpperCasePlainText, aString_Validated, s: AnsiString;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{8C0A5D1E-0A7A-45B5-9E49-A88F45113D60}';
  LogThis('[Процедура выделения искомых строк в тексте компонента RichEdit]',LogGroupGUID,lmtInfo);
  LogThis('Начало процедуры...',LogGroupGUID,lmtInfo);

  if (Trim(aString)>'') and (Trim(aRichEdit.Text)>'') then
    begin
      LogThis('',LogGroupGUID,lmtInfo);
      // преобразование строки поиска
      // преобразование и сохранение в переменную текста ричэдита
      aRichEdit_UpperCasePlainText:=AnsiUpperCase(aRichEdit.Text);
      aString_Validated:=AnsiUpperCase(Trim(aString));
      while Pos('  ',aString_Validated)>0 do
        aString_Validated:=StringReplace(aString_Validated,'  ',' ',[rfReplaceAll]);
	    aSL:=TStringList.Create;
	    try
	      aSL.Duplicates:=dupIgnore;
        CutStringByLimiterToStringList(aString_Validated, aSL, ' ');
        for i:=0 to aSL.Count-1 do
          begin
            // в цикле ищем все слова, содержашиеся в списке по всему тексту
            // и выделяем их красным фоном и белым цветом
            s:=aSL[i];
            // если вначале идёт звёздочка

            if (s[1]='*') or (s[1]='.') then
              s:=Copy(s,2,Length(s)-1);
            if (s[Length(s)]='*') or (s[Length(s)]='.') then
              s:=Copy(s,1,Length(s)-1);
            //if s[1]='*' then
            //  s:=Copy(s,2,Length(s)-1)
            //else s:=' '+s;

            j:=1;
            while PosEx(s,aRichEdit_UpperCasePlainText,j)>0 do
              begin
                j:=PosEx(s,aRichEdit_UpperCasePlainText,j);
                if j>0 then
                  begin
                    aRichEdit.SelStart:=j-1;
                    aRichEdit.SelLength:=Length(s);

                    //aRichEdit.SelStart:=j-1+integer(s[1]=' ');
                    //aRichEdit.SelLength:=Length(aSL[i])-1+integer(s[1]=' ');

                  end;
                if aRichEdit.SelText>'' then
                  begin
                    aRichEdit.SelAttributes.Color:=clRed;
                    aRichEdit.SelAttributes.Style:=aRichEdit.SelAttributes.Style+[fsBold,fsUnderline];
                    aRichEdit.SelAttributes.Size:=aRichEdit.SelAttributes.Size+5;
                  end;
                j:=j+1;
              end;
          end;
	    finally
		    aSL.Free;
	    end;
    end
  else LogThis('Искомая строка или строка текста пустые.',LogGroupGUID,lmtInfo);

  LogThis('Окончание процедуры.',LogGroupGUID,lmtInfo);
end;

end.

// переделать процедуры реакции на выделение элементов списков организаций и мероприятий
// переделать проверку на ошибки при запросах

//Написать обработку прогрессбара во всех выпадающих списках
//добавить курсор с часами во всех нужных местах проги

// !!!! "завернуть" выполнение запросов в условие проверки ошибки!!! в некоторых случаях ошибочно вынесен за границы условия!!!

//          if Configuration.bDataPanelHalfWidth then
//            pnlData.Width:=(pnlConnectedMode.Width-Splitter1.Width) div 2
//          else pnlData.Width:=Configuration.iDataPanelWidth;
//
//          if Configuration.bOrgPanelHalfHeight then
//            pnlOrgLV.Height:=(pnlSearchResultsCreationModification.Height-pnlCreationModification.Height-Splitter2.Height) div 2
//          else pnlOrgLV.Height:=Configuration.iOrgPanelHeight;
//  DEFAULT_ORGPANELHEIGHT=200; доделать сохранение высоты и ширины панелей после изменения их размеров при помощи сплиттера

// при установке окна по центру экрана слетают группы в списке организаций
