unit SHDocVw_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 06.10.2008 11:14:57 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\WINDOWS\system32\ieframe.dll (1)
// LIBID: {EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}
// LCID: 0
// Helpfile: 
// HelpString: Microsoft Internet Controls
// DepndLst: 
//   (1) v2.0 stdole, (C:\WINDOWS\system32\stdole2.tlb)
// Errors:
//   Hint: Symbol 'WebBrowser_V1' renamed to 'CppWebBrowser_V1'
//   Hint: Symbol 'WebBrowser' renamed to 'CppWebBrowser'
//   Hint: Symbol 'InternetExplorer' renamed to 'CppInternetExplorer'
//   Hint: Symbol 'ShellBrowserWindow' renamed to 'CppShellBrowserWindow'
//   Hint: Symbol 'ShellWindows' renamed to 'CppShellWindows'
//   Hint: Symbol 'ShellUIHelper' renamed to 'CppShellUIHelper'
//   Hint: Symbol 'ShellNameSpace' renamed to 'ShellFavoritesNameSpace'
//   Hint: Symbol 'CScriptErrorList' renamed to 'CppCScriptErrorList'
//   Hint: Symbol 'Type' renamed to 'type_'
//   Hint: Parameter 'Type' of IWebBrowser.Type changed to 'Type_'
//   Hint: Parameter 'Property' of DWebBrowserEvents.PropertyChange changed to 'Property_'
//   Hint: Parameter 'Property' of IWebBrowserApp.PutProperty changed to 'Property_'
//   Hint: Parameter 'Property' of IWebBrowserApp.GetProperty changed to 'Property_'
//   Hint: Parameter 'Type' of IShellUIHelper.AddDesktopComponent changed to 'Type_'
//   Hint: Parameter 'var' of IShellNameSpace.Expand changed to 'var_'
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleCtrls, OleServer, StdVCL, Variants;
  


// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  SHDocVwMajorVersion = 1;
  SHDocVwMinorVersion = 1;

  LIBID_SHDocVw: TGUID = '{EAB22AC0-30C1-11CF-A7EB-0000C05BAE0B}';

  IID_IWebBrowser: TGUID = '{EAB22AC1-30C1-11CF-A7EB-0000C05BAE0B}';
  DIID_DWebBrowserEvents: TGUID = '{EAB22AC2-30C1-11CF-A7EB-0000C05BAE0B}';
  IID_IWebBrowserApp: TGUID = '{0002DF05-0000-0000-C000-000000000046}';
  IID_IWebBrowser2: TGUID = '{D30C1661-CDAF-11D0-8A3E-00C04FC9E26E}';
  DIID_DWebBrowserEvents2: TGUID = '{34A715A0-6587-11D0-924A-0020AFC7AC4D}';
  CLASS_CppWebBrowser_V1: TGUID = '{EAB22AC3-30C1-11CF-A7EB-0000C05BAE0B}';
  CLASS_CppWebBrowser: TGUID = '{8856F961-340A-11D0-A96B-00C04FD705A2}';
  CLASS_CppInternetExplorer: TGUID = '{0002DF01-0000-0000-C000-000000000046}';
  CLASS_CppShellBrowserWindow: TGUID = '{C08AFD90-F2A1-11D1-8455-00A0C91F3880}';
  DIID_DShellWindowsEvents: TGUID = '{FE4106E0-399A-11D0-A48C-00A0C90A8F39}';
  IID_IShellWindows: TGUID = '{85CB6900-4D95-11CF-960C-0080C7F4EE85}';
  CLASS_CppShellWindows: TGUID = '{9BA05972-F6A8-11CF-A442-00A0C90A8F39}';
  IID_IShellUIHelper: TGUID = '{729FE2F8-1EA8-11D1-8F85-00C04FC2FBE1}';
  IID_IShellUIHelper2: TGUID = '{A7FE6EDA-1932-4281-B881-87B31B8BC52C}';
  CLASS_CppShellUIHelper: TGUID = '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';
  DIID_DShellNameSpaceEvents: TGUID = '{55136806-B2DE-11D1-B9F2-00A0C98BC547}';
  IID_IShellFavoritesNameSpace: TGUID = '{55136804-B2DE-11D1-B9F2-00A0C98BC547}';
  IID_IShellNameSpace: TGUID = '{E572D3C9-37BE-4AE2-825D-D521763E3108}';
  CLASS_ShellFavoritesNameSpace: TGUID = '{55136805-B2DE-11D1-B9F2-00A0C98BC547}';
  CLASS_ShellShellNameSpace: TGUID = '{2F2F1F96-2BC1-4B1C-BE28-EA3774F4676A}';
  IID_IScriptErrorList: TGUID = '{F3470F24-15FD-11D2-BB2E-00805FF7EFCA}';
  CLASS_CppCScriptErrorList: TGUID = '{EFD01300-160F-11D2-BB2E-00805FF7EFCA}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum CommandStateChangeConstants
type
  CommandStateChangeConstants = TOleEnum;
const
  CSC_UPDATECOMMANDS = $FFFFFFFF;
  CSC_NAVIGATEFORWARD = $00000001;
  CSC_NAVIGATEBACK = $00000002;

// Constants for enum OLECMDID
type
  OLECMDID = TOleEnum;
const
  OLECMDID_OPEN = $00000001;
  OLECMDID_NEW = $00000002;
  OLECMDID_SAVE = $00000003;
  OLECMDID_SAVEAS = $00000004;
  OLECMDID_SAVECOPYAS = $00000005;
  OLECMDID_PRINT = $00000006;
  OLECMDID_PRINTPREVIEW = $00000007;
  OLECMDID_PAGESETUP = $00000008;
  OLECMDID_SPELL = $00000009;
  OLECMDID_PROPERTIES = $0000000A;
  OLECMDID_CUT = $0000000B;
  OLECMDID_COPY = $0000000C;
  OLECMDID_PASTE = $0000000D;
  OLECMDID_PASTESPECIAL = $0000000E;
  OLECMDID_UNDO = $0000000F;
  OLECMDID_REDO = $00000010;
  OLECMDID_SELECTALL = $00000011;
  OLECMDID_CLEARSELECTION = $00000012;
  OLECMDID_ZOOM = $00000013;
  OLECMDID_GETZOOMRANGE = $00000014;
  OLECMDID_UPDATECOMMANDS = $00000015;
  OLECMDID_REFRESH = $00000016;
  OLECMDID_STOP = $00000017;
  OLECMDID_HIDETOOLBARS = $00000018;
  OLECMDID_SETPROGRESSMAX = $00000019;
  OLECMDID_SETPROGRESSPOS = $0000001A;
  OLECMDID_SETPROGRESSTEXT = $0000001B;
  OLECMDID_SETTITLE = $0000001C;
  OLECMDID_SETDOWNLOADSTATE = $0000001D;
  OLECMDID_STOPDOWNLOAD = $0000001E;
  OLECMDID_ONTOOLBARACTIVATED = $0000001F;
  OLECMDID_FIND = $00000020;
  OLECMDID_DELETE = $00000021;
  OLECMDID_HTTPEQUIV = $00000022;
  OLECMDID_HTTPEQUIV_DONE = $00000023;
  OLECMDID_ENABLE_INTERACTION = $00000024;
  OLECMDID_ONUNLOAD = $00000025;
  OLECMDID_PROPERTYBAG2 = $00000026;
  OLECMDID_PREREFRESH = $00000027;
  OLECMDID_SHOWSCRIPTERROR = $00000028;
  OLECMDID_SHOWMESSAGE = $00000029;
  OLECMDID_SHOWFIND = $0000002A;
  OLECMDID_SHOWPAGESETUP = $0000002B;
  OLECMDID_SHOWPRINT = $0000002C;
  OLECMDID_CLOSE = $0000002D;
  OLECMDID_ALLOWUILESSSAVEAS = $0000002E;
  OLECMDID_DONTDOWNLOADCSS = $0000002F;
  OLECMDID_UPDATEPAGESTATUS = $00000030;
  OLECMDID_PRINT2 = $00000031;
  OLECMDID_PRINTPREVIEW2 = $00000032;
  OLECMDID_SETPRINTTEMPLATE = $00000033;
  OLECMDID_GETPRINTTEMPLATE = $00000034;
  OLECMDID_PAGEACTIONBLOCKED = $00000037;
  OLECMDID_PAGEACTIONUIQUERY = $00000038;
  OLECMDID_FOCUSVIEWCONTROLS = $00000039;
  OLECMDID_FOCUSVIEWCONTROLSQUERY = $0000003A;
  OLECMDID_SHOWPAGEACTIONMENU = $0000003B;
  OLECMDID_ADDTRAVELENTRY = $0000003C;
  OLECMDID_UPDATETRAVELENTRY = $0000003D;
  OLECMDID_UPDATEBACKFORWARDSTATE = $0000003E;
  OLECMDID_OPTICAL_ZOOM = $0000003F;
  OLECMDID_OPTICAL_GETZOOMRANGE = $00000040;
  OLECMDID_WINDOWSTATECHANGED = $00000041;

// Constants for enum OLECMDF
type
  OLECMDF = TOleEnum;
const
  OLECMDF_SUPPORTED = $00000001;
  OLECMDF_ENABLED = $00000002;
  OLECMDF_LATCHED = $00000004;
  OLECMDF_NINCHED = $00000008;
  OLECMDF_INVISIBLE = $00000010;
  OLECMDF_DEFHIDEONCTXTMENU = $00000020;

// Constants for enum OLECMDEXECOPT
type
  OLECMDEXECOPT = TOleEnum;
const
  OLECMDEXECOPT_DODEFAULT = $00000000;
  OLECMDEXECOPT_PROMPTUSER = $00000001;
  OLECMDEXECOPT_DONTPROMPTUSER = $00000002;
  OLECMDEXECOPT_SHOWHELP = $00000003;

// Constants for enum tagREADYSTATE
type
  tagREADYSTATE = TOleEnum;
const
  READYSTATE_UNINITIALIZED = $00000000;
  READYSTATE_LOADING = $00000001;
  READYSTATE_LOADED = $00000002;
  READYSTATE_INTERACTIVE = $00000003;
  READYSTATE_COMPLETE = $00000004;

// Constants for enum SecureLockIconConstants
type
  SecureLockIconConstants = TOleEnum;
const
  secureLockIconUnsecure = $00000000;
  secureLockIconMixed = $00000001;
  secureLockIconSecureUnknownBits = $00000002;
  secureLockIconSecure40Bit = $00000003;
  secureLockIconSecure56Bit = $00000004;
  secureLockIconSecureFortezza = $00000005;
  secureLockIconSecure128Bit = $00000006;

// Constants for enum ShellWindowTypeConstants
type
  ShellWindowTypeConstants = TOleEnum;
const
  SWC_EXPLORER = $00000000;
  SWC_BROWSER = $00000001;
  SWC_3RDPARTY = $00000002;
  SWC_CALLBACK = $00000004;
  SWC_DESKTOP = $00000008;

// Constants for enum ShellWindowFindWindowOptions
type
  ShellWindowFindWindowOptions = TOleEnum;
const
  SWFO_NEEDDISPATCH = $00000001;
  SWFO_INCLUDEPENDING = $00000002;
  SWFO_COOKIEPASSED = $00000004;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IWebBrowser = interface;
  IWebBrowserDisp = dispinterface;
  DWebBrowserEvents = dispinterface;
  IWebBrowserApp = interface;
  IWebBrowserAppDisp = dispinterface;
  IWebBrowser2 = interface;
  IWebBrowser2Disp = dispinterface;
  DWebBrowserEvents2 = dispinterface;
  DShellWindowsEvents = dispinterface;
  IShellWindows = interface;
  IShellWindowsDisp = dispinterface;
  IShellUIHelper = interface;
  IShellUIHelperDisp = dispinterface;
  IShellUIHelper2 = interface;
  IShellUIHelper2Disp = dispinterface;
  DShellNameSpaceEvents = dispinterface;
  IShellFavoritesNameSpace = interface;
  IShellFavoritesNameSpaceDisp = dispinterface;
  IShellNameSpace = interface;
  IShellNameSpaceDisp = dispinterface;
  IScriptErrorList = interface;
  IScriptErrorListDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  CppWebBrowser_V1 = IWebBrowser;
  CppWebBrowser = IWebBrowser2;
  CppInternetExplorer = IWebBrowser2;
  CppShellBrowserWindow = IWebBrowser2;
  CppShellWindows = IShellWindows;
  CppShellUIHelper = IShellUIHelper2;
  ShellFavoritesNameSpace = IShellNameSpace;
  ShellShellNameSpace = IShellNameSpace;
  CppCScriptErrorList = IScriptErrorList;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  POleVariant1 = ^OleVariant; {*}


// *********************************************************************//
// Interface: IWebBrowser
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EAB22AC1-30C1-11CF-A7EB-0000C05BAE0B}
// *********************************************************************//
  IWebBrowser = interface(IDispatch)
    ['{EAB22AC1-30C1-11CF-A7EB-0000C05BAE0B}']
    procedure GoBack; safecall;
    procedure GoForward; safecall;
    procedure GoHome; safecall;
    procedure GoSearch; safecall;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; 
                       var TargetFrameName: OleVariant; var PostData: OleVariant; 
                       var Headers: OleVariant); safecall;
    procedure Refresh; safecall;
    procedure Refresh2(var Level: OleVariant); safecall;
    procedure Stop; safecall;
    function Get_Application: IDispatch; safecall;
    function Get_Parent: IDispatch; safecall;
    function Get_Container: IDispatch; safecall;
    function Get_Document: IDispatch; safecall;
    function Get_TopLevelContainer: WordBool; safecall;
    function Get_type_: WideString; safecall;
    function Get_Left: Integer; safecall;
    procedure Set_Left(pl: Integer); safecall;
    function Get_Top: Integer; safecall;
    procedure Set_Top(pl: Integer); safecall;
    function Get_Width: Integer; safecall;
    procedure Set_Width(pl: Integer); safecall;
    function Get_Height: Integer; safecall;
    procedure Set_Height(pl: Integer); safecall;
    function Get_LocationName: WideString; safecall;
    function Get_LocationURL: WideString; safecall;
    function Get_Busy: WordBool; safecall;
    property Application: IDispatch read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Container: IDispatch read Get_Container;
    property Document: IDispatch read Get_Document;
    property TopLevelContainer: WordBool read Get_TopLevelContainer;
    property type_: WideString read Get_type_;
    property Left: Integer read Get_Left write Set_Left;
    property Top: Integer read Get_Top write Set_Top;
    property Width: Integer read Get_Width write Set_Width;
    property Height: Integer read Get_Height write Set_Height;
    property LocationName: WideString read Get_LocationName;
    property LocationURL: WideString read Get_LocationURL;
    property Busy: WordBool read Get_Busy;
  end;

// *********************************************************************//
// DispIntf:  IWebBrowserDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {EAB22AC1-30C1-11CF-A7EB-0000C05BAE0B}
// *********************************************************************//
  IWebBrowserDisp = dispinterface
    ['{EAB22AC1-30C1-11CF-A7EB-0000C05BAE0B}']
    procedure GoBack; dispid 100;
    procedure GoForward; dispid 101;
    procedure GoHome; dispid 102;
    procedure GoSearch; dispid 103;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; 
                       var TargetFrameName: OleVariant; var PostData: OleVariant; 
                       var Headers: OleVariant); dispid 104;
    procedure Refresh; dispid -550;
    procedure Refresh2(var Level: OleVariant); dispid 105;
    procedure Stop; dispid 106;
    property Application: IDispatch readonly dispid 200;
    property Parent: IDispatch readonly dispid 201;
    property Container: IDispatch readonly dispid 202;
    property Document: IDispatch readonly dispid 203;
    property TopLevelContainer: WordBool readonly dispid 204;
    property type_: WideString readonly dispid 205;
    property Left: Integer dispid 206;
    property Top: Integer dispid 207;
    property Width: Integer dispid 208;
    property Height: Integer dispid 209;
    property LocationName: WideString readonly dispid 210;
    property LocationURL: WideString readonly dispid 211;
    property Busy: WordBool readonly dispid 212;
  end;

// *********************************************************************//
// DispIntf:  DWebBrowserEvents
// Flags:     (4112) Hidden Dispatchable
// GUID:      {EAB22AC2-30C1-11CF-A7EB-0000C05BAE0B}
// *********************************************************************//
  DWebBrowserEvents = dispinterface
    ['{EAB22AC2-30C1-11CF-A7EB-0000C05BAE0B}']
    procedure BeforeNavigate(const URL: WideString; Flags: Integer; 
                             const TargetFrameName: WideString; var PostData: OleVariant; 
                             const Headers: WideString; var Cancel: WordBool); dispid 100;
    procedure NavigateComplete(const URL: WideString); dispid 101;
    procedure StatusTextChange(const Text: WideString); dispid 102;
    procedure ProgressChange(Progress: Integer; ProgressMax: Integer); dispid 108;
    procedure DownloadComplete; dispid 104;
    procedure CommandStateChange(Command: Integer; Enable: WordBool); dispid 105;
    procedure DownloadBegin; dispid 106;
    procedure NewWindow(const URL: WideString; Flags: Integer; const TargetFrameName: WideString; 
                        var PostData: OleVariant; const Headers: WideString; var Processed: WordBool); dispid 107;
    procedure TitleChange(const Text: WideString); dispid 113;
    procedure FrameBeforeNavigate(const URL: WideString; Flags: Integer; 
                                  const TargetFrameName: WideString; var PostData: OleVariant; 
                                  const Headers: WideString; var Cancel: WordBool); dispid 200;
    procedure FrameNavigateComplete(const URL: WideString); dispid 201;
    procedure FrameNewWindow(const URL: WideString; Flags: Integer; 
                             const TargetFrameName: WideString; var PostData: OleVariant; 
                             const Headers: WideString; var Processed: WordBool); dispid 204;
    procedure Quit(var Cancel: WordBool); dispid 103;
    procedure WindowMove; dispid 109;
    procedure WindowResize; dispid 110;
    procedure WindowActivate; dispid 111;
    procedure PropertyChange(const Property_: WideString); dispid 112;
  end;

// *********************************************************************//
// Interface: IWebBrowserApp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002DF05-0000-0000-C000-000000000046}
// *********************************************************************//
  IWebBrowserApp = interface(IWebBrowser)
    ['{0002DF05-0000-0000-C000-000000000046}']
    procedure Quit; safecall;
    procedure ClientToWindow(var pcx: SYSINT; var pcy: SYSINT); safecall;
    procedure PutProperty(const Property_: WideString; vtValue: OleVariant); safecall;
    function GetProperty(const Property_: WideString): OleVariant; safecall;
    function Get_Name: WideString; safecall;
    function Get_HWND: Integer; safecall;
    function Get_FullName: WideString; safecall;
    function Get_Path: WideString; safecall;
    function Get_Visible: WordBool; safecall;
    procedure Set_Visible(pBool: WordBool); safecall;
    function Get_StatusBar: WordBool; safecall;
    procedure Set_StatusBar(pBool: WordBool); safecall;
    function Get_StatusText: WideString; safecall;
    procedure Set_StatusText(const StatusText: WideString); safecall;
    function Get_ToolBar: SYSINT; safecall;
    procedure Set_ToolBar(Value: SYSINT); safecall;
    function Get_MenuBar: WordBool; safecall;
    procedure Set_MenuBar(Value: WordBool); safecall;
    function Get_FullScreen: WordBool; safecall;
    procedure Set_FullScreen(pbFullScreen: WordBool); safecall;
    property Name: WideString read Get_Name;
    property HWND: Integer read Get_HWND;
    property FullName: WideString read Get_FullName;
    property Path: WideString read Get_Path;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property StatusBar: WordBool read Get_StatusBar write Set_StatusBar;
    property StatusText: WideString read Get_StatusText write Set_StatusText;
    property ToolBar: SYSINT read Get_ToolBar write Set_ToolBar;
    property MenuBar: WordBool read Get_MenuBar write Set_MenuBar;
    property FullScreen: WordBool read Get_FullScreen write Set_FullScreen;
  end;

// *********************************************************************//
// DispIntf:  IWebBrowserAppDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {0002DF05-0000-0000-C000-000000000046}
// *********************************************************************//
  IWebBrowserAppDisp = dispinterface
    ['{0002DF05-0000-0000-C000-000000000046}']
    procedure Quit; dispid 300;
    procedure ClientToWindow(var pcx: SYSINT; var pcy: SYSINT); dispid 301;
    procedure PutProperty(const Property_: WideString; vtValue: OleVariant); dispid 302;
    function GetProperty(const Property_: WideString): OleVariant; dispid 303;
    property Name: WideString readonly dispid 0;
    property HWND: Integer readonly dispid -515;
    property FullName: WideString readonly dispid 400;
    property Path: WideString readonly dispid 401;
    property Visible: WordBool dispid 402;
    property StatusBar: WordBool dispid 403;
    property StatusText: WideString dispid 404;
    property ToolBar: SYSINT dispid 405;
    property MenuBar: WordBool dispid 406;
    property FullScreen: WordBool dispid 407;
    procedure GoBack; dispid 100;
    procedure GoForward; dispid 101;
    procedure GoHome; dispid 102;
    procedure GoSearch; dispid 103;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; 
                       var TargetFrameName: OleVariant; var PostData: OleVariant; 
                       var Headers: OleVariant); dispid 104;
    procedure Refresh; dispid -550;
    procedure Refresh2(var Level: OleVariant); dispid 105;
    procedure Stop; dispid 106;
    property Application: IDispatch readonly dispid 200;
    property Parent: IDispatch readonly dispid 201;
    property Container: IDispatch readonly dispid 202;
    property Document: IDispatch readonly dispid 203;
    property TopLevelContainer: WordBool readonly dispid 204;
    property type_: WideString readonly dispid 205;
    property Left: Integer dispid 206;
    property Top: Integer dispid 207;
    property Width: Integer dispid 208;
    property Height: Integer dispid 209;
    property LocationName: WideString readonly dispid 210;
    property LocationURL: WideString readonly dispid 211;
    property Busy: WordBool readonly dispid 212;
  end;

// *********************************************************************//
// Interface: IWebBrowser2
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D30C1661-CDAF-11D0-8A3E-00C04FC9E26E}
// *********************************************************************//
  IWebBrowser2 = interface(IWebBrowserApp)
    ['{D30C1661-CDAF-11D0-8A3E-00C04FC9E26E}']
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                        var TargetFrameName: OleVariant; var PostData: OleVariant; 
                        var Headers: OleVariant); safecall;
    function QueryStatusWB(cmdID: OLECMDID): OLECMDF; safecall;
    procedure ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; var pvaIn: OleVariant; 
                     var pvaOut: OleVariant); safecall;
    procedure ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant; 
                             var pvarSize: OleVariant); safecall;
    function Get_ReadyState: tagREADYSTATE; safecall;
    function Get_Offline: WordBool; safecall;
    procedure Set_Offline(pbOffline: WordBool); safecall;
    function Get_Silent: WordBool; safecall;
    procedure Set_Silent(pbSilent: WordBool); safecall;
    function Get_RegisterAsBrowser: WordBool; safecall;
    procedure Set_RegisterAsBrowser(pbRegister: WordBool); safecall;
    function Get_RegisterAsDropTarget: WordBool; safecall;
    procedure Set_RegisterAsDropTarget(pbRegister: WordBool); safecall;
    function Get_TheaterMode: WordBool; safecall;
    procedure Set_TheaterMode(pbRegister: WordBool); safecall;
    function Get_AddressBar: WordBool; safecall;
    procedure Set_AddressBar(Value: WordBool); safecall;
    function Get_Resizable: WordBool; safecall;
    procedure Set_Resizable(Value: WordBool); safecall;
    property ReadyState: tagREADYSTATE read Get_ReadyState;
    property Offline: WordBool read Get_Offline write Set_Offline;
    property Silent: WordBool read Get_Silent write Set_Silent;
    property RegisterAsBrowser: WordBool read Get_RegisterAsBrowser write Set_RegisterAsBrowser;
    property RegisterAsDropTarget: WordBool read Get_RegisterAsDropTarget write Set_RegisterAsDropTarget;
    property TheaterMode: WordBool read Get_TheaterMode write Set_TheaterMode;
    property AddressBar: WordBool read Get_AddressBar write Set_AddressBar;
    property Resizable: WordBool read Get_Resizable write Set_Resizable;
  end;

// *********************************************************************//
// DispIntf:  IWebBrowser2Disp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {D30C1661-CDAF-11D0-8A3E-00C04FC9E26E}
// *********************************************************************//
  IWebBrowser2Disp = dispinterface
    ['{D30C1661-CDAF-11D0-8A3E-00C04FC9E26E}']
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                        var TargetFrameName: OleVariant; var PostData: OleVariant; 
                        var Headers: OleVariant); dispid 500;
    function QueryStatusWB(cmdID: OLECMDID): OLECMDF; dispid 501;
    procedure ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; var pvaIn: OleVariant; 
                     var pvaOut: OleVariant); dispid 502;
    procedure ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant; 
                             var pvarSize: OleVariant); dispid 503;
    property ReadyState: tagREADYSTATE readonly dispid -525;
    property Offline: WordBool dispid 550;
    property Silent: WordBool dispid 551;
    property RegisterAsBrowser: WordBool dispid 552;
    property RegisterAsDropTarget: WordBool dispid 553;
    property TheaterMode: WordBool dispid 554;
    property AddressBar: WordBool dispid 555;
    property Resizable: WordBool dispid 556;
    procedure Quit; dispid 300;
    procedure ClientToWindow(var pcx: SYSINT; var pcy: SYSINT); dispid 301;
    procedure PutProperty(const Property_: WideString; vtValue: OleVariant); dispid 302;
    function GetProperty(const Property_: WideString): OleVariant; dispid 303;
    property Name: WideString readonly dispid 0;
    property HWND: Integer readonly dispid -515;
    property FullName: WideString readonly dispid 400;
    property Path: WideString readonly dispid 401;
    property Visible: WordBool dispid 402;
    property StatusBar: WordBool dispid 403;
    property StatusText: WideString dispid 404;
    property ToolBar: SYSINT dispid 405;
    property MenuBar: WordBool dispid 406;
    property FullScreen: WordBool dispid 407;
    procedure GoBack; dispid 100;
    procedure GoForward; dispid 101;
    procedure GoHome; dispid 102;
    procedure GoSearch; dispid 103;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; 
                       var TargetFrameName: OleVariant; var PostData: OleVariant; 
                       var Headers: OleVariant); dispid 104;
    procedure Refresh; dispid -550;
    procedure Refresh2(var Level: OleVariant); dispid 105;
    procedure Stop; dispid 106;
    property Application: IDispatch readonly dispid 200;
    property Parent: IDispatch readonly dispid 201;
    property Container: IDispatch readonly dispid 202;
    property Document: IDispatch readonly dispid 203;
    property TopLevelContainer: WordBool readonly dispid 204;
    property type_: WideString readonly dispid 205;
    property Left: Integer dispid 206;
    property Top: Integer dispid 207;
    property Width: Integer dispid 208;
    property Height: Integer dispid 209;
    property LocationName: WideString readonly dispid 210;
    property LocationURL: WideString readonly dispid 211;
    property Busy: WordBool readonly dispid 212;
  end;

// *********************************************************************//
// DispIntf:  DWebBrowserEvents2
// Flags:     (4112) Hidden Dispatchable
// GUID:      {34A715A0-6587-11D0-924A-0020AFC7AC4D}
// *********************************************************************//
  DWebBrowserEvents2 = dispinterface
    ['{34A715A0-6587-11D0-924A-0020AFC7AC4D}']
    procedure StatusTextChange(const Text: WideString); dispid 102;
    procedure ProgressChange(Progress: Integer; ProgressMax: Integer); dispid 108;
    procedure CommandStateChange(Command: Integer; Enable: WordBool); dispid 105;
    procedure DownloadBegin; dispid 106;
    procedure DownloadComplete; dispid 104;
    procedure TitleChange(const Text: WideString); dispid 113;
    procedure PropertyChange(const szProperty: WideString); dispid 112;
    procedure BeforeNavigate2(const pDisp: IDispatch; var URL: OleVariant; var Flags: OleVariant; 
                              var TargetFrameName: OleVariant; var PostData: OleVariant; 
                              var Headers: OleVariant; var Cancel: WordBool); dispid 250;
    procedure NewWindow2(var ppDisp: IDispatch; var Cancel: WordBool); dispid 251;
    procedure NavigateComplete2(const pDisp: IDispatch; var URL: OleVariant); dispid 252;
    procedure DocumentComplete(const pDisp: IDispatch; var URL: OleVariant); dispid 259;
    procedure OnQuit; dispid 253;
    procedure OnVisible(Visible: WordBool); dispid 254;
    procedure OnToolBar(ToolBar: WordBool); dispid 255;
    procedure OnMenuBar(MenuBar: WordBool); dispid 256;
    procedure OnStatusBar(StatusBar: WordBool); dispid 257;
    procedure OnFullScreen(FullScreen: WordBool); dispid 258;
    procedure OnTheaterMode(TheaterMode: WordBool); dispid 260;
    procedure WindowSetResizable(Resizable: WordBool); dispid 262;
    procedure WindowSetLeft(Left: Integer); dispid 264;
    procedure WindowSetTop(Top: Integer); dispid 265;
    procedure WindowSetWidth(Width: Integer); dispid 266;
    procedure WindowSetHeight(Height: Integer); dispid 267;
    procedure WindowClosing(IsChildWindow: WordBool; var Cancel: WordBool); dispid 263;
    procedure ClientToHostWindow(var CX: Integer; var CY: Integer); dispid 268;
    procedure SetSecureLockIcon(SecureLockIcon: Integer); dispid 269;
    procedure FileDownload(ActiveDocument: WordBool; var Cancel: WordBool); dispid 270;
    procedure NavigateError(const pDisp: IDispatch; var URL: OleVariant; var Frame: OleVariant; 
                            var StatusCode: OleVariant; var Cancel: WordBool); dispid 271;
    procedure PrintTemplateInstantiation(const pDisp: IDispatch); dispid 225;
    procedure PrintTemplateTeardown(const pDisp: IDispatch); dispid 226;
    procedure UpdatePageStatus(const pDisp: IDispatch; var nPage: OleVariant; var fDone: OleVariant); dispid 227;
    procedure PrivacyImpactedStateChange(bImpacted: WordBool); dispid 272;
    procedure NewWindow3(var ppDisp: IDispatch; var Cancel: WordBool; dwFlags: LongWord; 
                         const bstrUrlContext: WideString; const bstrUrl: WideString); dispid 273;
    procedure SetPhishingFilterStatus(PhishingFilterStatus: Integer); dispid 282;
    procedure WindowStateChanged(dwWindowStateFlags: LongWord; dwValidFlagsMask: LongWord); dispid 283;
  end;

// *********************************************************************//
// DispIntf:  DShellWindowsEvents
// Flags:     (4096) Dispatchable
// GUID:      {FE4106E0-399A-11D0-A48C-00A0C90A8F39}
// *********************************************************************//
  DShellWindowsEvents = dispinterface
    ['{FE4106E0-399A-11D0-A48C-00A0C90A8F39}']
    procedure WindowRegistered(lCookie: Integer); dispid 200;
    procedure WindowRevoked(lCookie: Integer); dispid 201;
  end;

// *********************************************************************//
// Interface: IShellWindows
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {85CB6900-4D95-11CF-960C-0080C7F4EE85}
// *********************************************************************//
  IShellWindows = interface(IDispatch)
    ['{85CB6900-4D95-11CF-960C-0080C7F4EE85}']
    function Get_Count: Integer; safecall;
    function Item(index: OleVariant): IDispatch; safecall;
    function _NewEnum: IUnknown; safecall;
    procedure Register(const pid: IDispatch; HWND: Integer; swClass: SYSINT; out plCookie: Integer); safecall;
    procedure RegisterPending(lThreadId: Integer; var pvarloc: OleVariant; 
                              var pvarlocRoot: OleVariant; swClass: SYSINT; out plCookie: Integer); safecall;
    procedure Revoke(lCookie: Integer); safecall;
    procedure OnNavigate(lCookie: Integer; var pvarloc: OleVariant); safecall;
    procedure OnActivated(lCookie: Integer; fActive: WordBool); safecall;
    function FindWindowSW(var pvarloc: OleVariant; var pvarlocRoot: OleVariant; swClass: SYSINT; 
                          out pHWND: Integer; swfwOptions: SYSINT): IDispatch; safecall;
    procedure OnCreated(lCookie: Integer; const punk: IUnknown); safecall;
    procedure ProcessAttachDetach(fAttach: WordBool); safecall;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IShellWindowsDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {85CB6900-4D95-11CF-960C-0080C7F4EE85}
// *********************************************************************//
  IShellWindowsDisp = dispinterface
    ['{85CB6900-4D95-11CF-960C-0080C7F4EE85}']
    property Count: Integer readonly dispid 1610743808;
    function Item(index: OleVariant): IDispatch; dispid 0;
    function _NewEnum: IUnknown; dispid -4;
    procedure Register(const pid: IDispatch; HWND: Integer; swClass: SYSINT; out plCookie: Integer); dispid 1610743811;
    procedure RegisterPending(lThreadId: Integer; var pvarloc: OleVariant; 
                              var pvarlocRoot: OleVariant; swClass: SYSINT; out plCookie: Integer); dispid 1610743812;
    procedure Revoke(lCookie: Integer); dispid 1610743813;
    procedure OnNavigate(lCookie: Integer; var pvarloc: OleVariant); dispid 1610743814;
    procedure OnActivated(lCookie: Integer; fActive: WordBool); dispid 1610743815;
    function FindWindowSW(var pvarloc: OleVariant; var pvarlocRoot: OleVariant; swClass: SYSINT; 
                          out pHWND: Integer; swfwOptions: SYSINT): IDispatch; dispid 1610743816;
    procedure OnCreated(lCookie: Integer; const punk: IUnknown); dispid 1610743817;
    procedure ProcessAttachDetach(fAttach: WordBool); dispid 1610743818;
  end;

// *********************************************************************//
// Interface: IShellUIHelper
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {729FE2F8-1EA8-11D1-8F85-00C04FC2FBE1}
// *********************************************************************//
  IShellUIHelper = interface(IDispatch)
    ['{729FE2F8-1EA8-11D1-8F85-00C04FC2FBE1}']
    procedure ResetFirstBootMode; safecall;
    procedure ResetSafeMode; safecall;
    procedure RefreshOfflineDesktop; safecall;
    procedure AddFavorite(const URL: WideString; var Title: OleVariant); safecall;
    procedure AddChannel(const URL: WideString); safecall;
    procedure AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                  var Left: OleVariant; var Top: OleVariant; var Width: OleVariant; 
                                  var Height: OleVariant); safecall;
    function IsSubscribed(const URL: WideString): WordBool; safecall;
    procedure NavigateAndFind(const URL: WideString; const strQuery: WideString; 
                              var varTargetFrame: OleVariant); safecall;
    procedure ImportExportFavorites(fImport: WordBool; const strImpExpPath: WideString); safecall;
    procedure AutoCompleteSaveForm(var Form: OleVariant); safecall;
    procedure AutoScan(const strSearch: WideString; const strFailureUrl: WideString; 
                       var pvarTargetFrame: OleVariant); safecall;
    procedure AutoCompleteAttach(var Reserved: OleVariant); safecall;
    function ShowBrowserUI(const bstrName: WideString; var pvarIn: OleVariant): OleVariant; safecall;
  end;

// *********************************************************************//
// DispIntf:  IShellUIHelperDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {729FE2F8-1EA8-11D1-8F85-00C04FC2FBE1}
// *********************************************************************//
  IShellUIHelperDisp = dispinterface
    ['{729FE2F8-1EA8-11D1-8F85-00C04FC2FBE1}']
    procedure ResetFirstBootMode; dispid 1;
    procedure ResetSafeMode; dispid 2;
    procedure RefreshOfflineDesktop; dispid 3;
    procedure AddFavorite(const URL: WideString; var Title: OleVariant); dispid 4;
    procedure AddChannel(const URL: WideString); dispid 5;
    procedure AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                  var Left: OleVariant; var Top: OleVariant; var Width: OleVariant; 
                                  var Height: OleVariant); dispid 6;
    function IsSubscribed(const URL: WideString): WordBool; dispid 7;
    procedure NavigateAndFind(const URL: WideString; const strQuery: WideString; 
                              var varTargetFrame: OleVariant); dispid 8;
    procedure ImportExportFavorites(fImport: WordBool; const strImpExpPath: WideString); dispid 9;
    procedure AutoCompleteSaveForm(var Form: OleVariant); dispid 10;
    procedure AutoScan(const strSearch: WideString; const strFailureUrl: WideString; 
                       var pvarTargetFrame: OleVariant); dispid 11;
    procedure AutoCompleteAttach(var Reserved: OleVariant); dispid 12;
    function ShowBrowserUI(const bstrName: WideString; var pvarIn: OleVariant): OleVariant; dispid 13;
  end;

// *********************************************************************//
// Interface: IShellUIHelper2
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A7FE6EDA-1932-4281-B881-87B31B8BC52C}
// *********************************************************************//
  IShellUIHelper2 = interface(IShellUIHelper)
    ['{A7FE6EDA-1932-4281-B881-87B31B8BC52C}']
    procedure AddSearchProvider(const URL: WideString); safecall;
    procedure RunOnceShown; safecall;
    procedure SkipRunOnce; safecall;
    procedure CustomizeSettings(fSQM: WordBool; fPhishing: WordBool; const bstrLocale: WideString); safecall;
    function SqmEnabled: WordBool; safecall;
    function PhishingEnabled: WordBool; safecall;
    function BrandImageUri: WideString; safecall;
    procedure SkipTabsWelcome; safecall;
    procedure DiagnoseConnection; safecall;
    procedure CustomizeClearType(fSet: WordBool); safecall;
    function IsSearchProviderInstalled(const URL: WideString): LongWord; safecall;
    function IsSearchMigrated: WordBool; safecall;
    function DefaultSearchProvider: WideString; safecall;
    procedure RunOnceRequiredSettingsComplete(fComplete: WordBool); safecall;
    function RunOnceHasShown: WordBool; safecall;
    function SearchGuideUrl: WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IShellUIHelper2Disp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {A7FE6EDA-1932-4281-B881-87B31B8BC52C}
// *********************************************************************//
  IShellUIHelper2Disp = dispinterface
    ['{A7FE6EDA-1932-4281-B881-87B31B8BC52C}']
    procedure AddSearchProvider(const URL: WideString); dispid 14;
    procedure RunOnceShown; dispid 15;
    procedure SkipRunOnce; dispid 16;
    procedure CustomizeSettings(fSQM: WordBool; fPhishing: WordBool; const bstrLocale: WideString); dispid 17;
    function SqmEnabled: WordBool; dispid 18;
    function PhishingEnabled: WordBool; dispid 19;
    function BrandImageUri: WideString; dispid 20;
    procedure SkipTabsWelcome; dispid 21;
    procedure DiagnoseConnection; dispid 22;
    procedure CustomizeClearType(fSet: WordBool); dispid 23;
    function IsSearchProviderInstalled(const URL: WideString): LongWord; dispid 24;
    function IsSearchMigrated: WordBool; dispid 25;
    function DefaultSearchProvider: WideString; dispid 26;
    procedure RunOnceRequiredSettingsComplete(fComplete: WordBool); dispid 27;
    function RunOnceHasShown: WordBool; dispid 28;
    function SearchGuideUrl: WideString; dispid 29;
    procedure ResetFirstBootMode; dispid 1;
    procedure ResetSafeMode; dispid 2;
    procedure RefreshOfflineDesktop; dispid 3;
    procedure AddFavorite(const URL: WideString; var Title: OleVariant); dispid 4;
    procedure AddChannel(const URL: WideString); dispid 5;
    procedure AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                  var Left: OleVariant; var Top: OleVariant; var Width: OleVariant; 
                                  var Height: OleVariant); dispid 6;
    function IsSubscribed(const URL: WideString): WordBool; dispid 7;
    procedure NavigateAndFind(const URL: WideString; const strQuery: WideString; 
                              var varTargetFrame: OleVariant); dispid 8;
    procedure ImportExportFavorites(fImport: WordBool; const strImpExpPath: WideString); dispid 9;
    procedure AutoCompleteSaveForm(var Form: OleVariant); dispid 10;
    procedure AutoScan(const strSearch: WideString; const strFailureUrl: WideString; 
                       var pvarTargetFrame: OleVariant); dispid 11;
    procedure AutoCompleteAttach(var Reserved: OleVariant); dispid 12;
    function ShowBrowserUI(const bstrName: WideString; var pvarIn: OleVariant): OleVariant; dispid 13;
  end;

// *********************************************************************//
// DispIntf:  DShellNameSpaceEvents
// Flags:     (4096) Dispatchable
// GUID:      {55136806-B2DE-11D1-B9F2-00A0C98BC547}
// *********************************************************************//
  DShellNameSpaceEvents = dispinterface
    ['{55136806-B2DE-11D1-B9F2-00A0C98BC547}']
    procedure FavoritesSelectionChange(cItems: Integer; hItem: Integer; const strName: WideString; 
                                       const strUrl: WideString; cVisits: Integer; 
                                       const strDate: WideString; fAvailableOffline: Integer); dispid 1;
    procedure SelectionChange; dispid 2;
    procedure DoubleClick; dispid 3;
    procedure Initialized; dispid 4;
  end;

// *********************************************************************//
// Interface: IShellFavoritesNameSpace
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {55136804-B2DE-11D1-B9F2-00A0C98BC547}
// *********************************************************************//
  IShellFavoritesNameSpace = interface(IDispatch)
    ['{55136804-B2DE-11D1-B9F2-00A0C98BC547}']
    procedure MoveSelectionUp; safecall;
    procedure MoveSelectionDown; safecall;
    procedure ResetSort; safecall;
    procedure NewFolder; safecall;
    procedure Synchronize; safecall;
    procedure Import; safecall;
    procedure Export; safecall;
    procedure InvokeContextMenuCommand(const strCommand: WideString); safecall;
    procedure MoveSelectionTo; safecall;
    function Get_SubscriptionsEnabled: WordBool; safecall;
    function CreateSubscriptionForSelection: WordBool; safecall;
    function DeleteSubscriptionForSelection: WordBool; safecall;
    procedure SetRoot(const bstrFullPath: WideString); safecall;
    property SubscriptionsEnabled: WordBool read Get_SubscriptionsEnabled;
  end;

// *********************************************************************//
// DispIntf:  IShellFavoritesNameSpaceDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {55136804-B2DE-11D1-B9F2-00A0C98BC547}
// *********************************************************************//
  IShellFavoritesNameSpaceDisp = dispinterface
    ['{55136804-B2DE-11D1-B9F2-00A0C98BC547}']
    procedure MoveSelectionUp; dispid 1;
    procedure MoveSelectionDown; dispid 2;
    procedure ResetSort; dispid 3;
    procedure NewFolder; dispid 4;
    procedure Synchronize; dispid 5;
    procedure Import; dispid 6;
    procedure Export; dispid 7;
    procedure InvokeContextMenuCommand(const strCommand: WideString); dispid 8;
    procedure MoveSelectionTo; dispid 9;
    property SubscriptionsEnabled: WordBool readonly dispid 10;
    function CreateSubscriptionForSelection: WordBool; dispid 11;
    function DeleteSubscriptionForSelection: WordBool; dispid 12;
    procedure SetRoot(const bstrFullPath: WideString); dispid 13;
  end;

// *********************************************************************//
// Interface: IShellNameSpace
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E572D3C9-37BE-4AE2-825D-D521763E3108}
// *********************************************************************//
  IShellNameSpace = interface(IShellFavoritesNameSpace)
    ['{E572D3C9-37BE-4AE2-825D-D521763E3108}']
    function Get_EnumOptions: Integer; safecall;
    procedure Set_EnumOptions(pgrfEnumFlags: Integer); safecall;
    function Get_SelectedItem: IDispatch; safecall;
    procedure Set_SelectedItem(const pItem: IDispatch); safecall;
    function Get_Root: OleVariant; safecall;
    procedure Set_Root(pvar: OleVariant); safecall;
    function Get_Depth: SYSINT; safecall;
    procedure Set_Depth(piDepth: SYSINT); safecall;
    function Get_Mode: SYSUINT; safecall;
    procedure Set_Mode(puMode: SYSUINT); safecall;
    function Get_Flags: LongWord; safecall;
    procedure Set_Flags(pdwFlags: LongWord); safecall;
    procedure Set_TVFlags(dwFlags: LongWord); safecall;
    function Get_TVFlags: LongWord; safecall;
    function Get_Columns: WideString; safecall;
    procedure Set_Columns(const bstrColumns: WideString); safecall;
    function Get_CountViewTypes: SYSINT; safecall;
    procedure SetViewType(iType: SYSINT); safecall;
    function SelectedItems: IDispatch; safecall;
    procedure Expand(var_: OleVariant; iDepth: SYSINT); safecall;
    procedure UnselectAll; safecall;
    property EnumOptions: Integer read Get_EnumOptions write Set_EnumOptions;
    property SelectedItem: IDispatch read Get_SelectedItem write Set_SelectedItem;
    property Root: OleVariant read Get_Root write Set_Root;
    property Depth: SYSINT read Get_Depth write Set_Depth;
    property Mode: SYSUINT read Get_Mode write Set_Mode;
    property Flags: LongWord read Get_Flags write Set_Flags;
    property TVFlags: LongWord read Get_TVFlags write Set_TVFlags;
    property Columns: WideString read Get_Columns write Set_Columns;
    property CountViewTypes: SYSINT read Get_CountViewTypes;
  end;

// *********************************************************************//
// DispIntf:  IShellNameSpaceDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {E572D3C9-37BE-4AE2-825D-D521763E3108}
// *********************************************************************//
  IShellNameSpaceDisp = dispinterface
    ['{E572D3C9-37BE-4AE2-825D-D521763E3108}']
    property EnumOptions: Integer dispid 14;
    property SelectedItem: IDispatch dispid 15;
    property Root: OleVariant dispid 16;
    property Depth: SYSINT dispid 17;
    property Mode: SYSUINT dispid 18;
    property Flags: LongWord dispid 19;
    property TVFlags: LongWord dispid 20;
    property Columns: WideString dispid 21;
    property CountViewTypes: SYSINT readonly dispid 22;
    procedure SetViewType(iType: SYSINT); dispid 23;
    function SelectedItems: IDispatch; dispid 24;
    procedure Expand(var_: OleVariant; iDepth: SYSINT); dispid 25;
    procedure UnselectAll; dispid 26;
    procedure MoveSelectionUp; dispid 1;
    procedure MoveSelectionDown; dispid 2;
    procedure ResetSort; dispid 3;
    procedure NewFolder; dispid 4;
    procedure Synchronize; dispid 5;
    procedure Import; dispid 6;
    procedure Export; dispid 7;
    procedure InvokeContextMenuCommand(const strCommand: WideString); dispid 8;
    procedure MoveSelectionTo; dispid 9;
    property SubscriptionsEnabled: WordBool readonly dispid 10;
    function CreateSubscriptionForSelection: WordBool; dispid 11;
    function DeleteSubscriptionForSelection: WordBool; dispid 12;
    procedure SetRoot(const bstrFullPath: WideString); dispid 13;
  end;

// *********************************************************************//
// Interface: IScriptErrorList
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F3470F24-15FD-11D2-BB2E-00805FF7EFCA}
// *********************************************************************//
  IScriptErrorList = interface(IDispatch)
    ['{F3470F24-15FD-11D2-BB2E-00805FF7EFCA}']
    procedure advanceError; safecall;
    procedure retreatError; safecall;
    function canAdvanceError: Integer; safecall;
    function canRetreatError: Integer; safecall;
    function getErrorLine: Integer; safecall;
    function getErrorChar: Integer; safecall;
    function getErrorCode: Integer; safecall;
    function getErrorMsg: WideString; safecall;
    function getErrorUrl: WideString; safecall;
    function getAlwaysShowLockState: Integer; safecall;
    function getDetailsPaneOpen: Integer; safecall;
    procedure setDetailsPaneOpen(fDetailsPaneOpen: Integer); safecall;
    function getPerErrorDisplay: Integer; safecall;
    procedure setPerErrorDisplay(fPerErrorDisplay: Integer); safecall;
  end;

// *********************************************************************//
// DispIntf:  IScriptErrorListDisp
// Flags:     (4432) Hidden Dual OleAutomation Dispatchable
// GUID:      {F3470F24-15FD-11D2-BB2E-00805FF7EFCA}
// *********************************************************************//
  IScriptErrorListDisp = dispinterface
    ['{F3470F24-15FD-11D2-BB2E-00805FF7EFCA}']
    procedure advanceError; dispid 10;
    procedure retreatError; dispid 11;
    function canAdvanceError: Integer; dispid 12;
    function canRetreatError: Integer; dispid 13;
    function getErrorLine: Integer; dispid 14;
    function getErrorChar: Integer; dispid 15;
    function getErrorCode: Integer; dispid 16;
    function getErrorMsg: WideString; dispid 17;
    function getErrorUrl: WideString; dispid 18;
    function getAlwaysShowLockState: Integer; dispid 23;
    function getDetailsPaneOpen: Integer; dispid 19;
    procedure setDetailsPaneOpen(fDetailsPaneOpen: Integer); dispid 20;
    function getPerErrorDisplay: Integer; dispid 21;
    procedure setPerErrorDisplay(fPerErrorDisplay: Integer); dispid 22;
  end;


// *********************************************************************//
// OLE Control Proxy class declaration
// Control Name     : TCppWebBrowser
// Help String      : WebBrowser Control
// Default Interface: IWebBrowser2
// Def. Intf. DISP? : No
// Event   Interface: DWebBrowserEvents2
// TypeFlags        : (34) CanCreate Control
// *********************************************************************//
  TCppWebBrowserStatusTextChange = procedure(ASender: TObject; const Text: WideString) of object;
  TCppWebBrowserProgressChange = procedure(ASender: TObject; Progress: Integer; ProgressMax: Integer) of object;
  TCppWebBrowserCommandStateChange = procedure(ASender: TObject; Command: Integer; Enable: WordBool) of object;
  TCppWebBrowserTitleChange = procedure(ASender: TObject; const Text: WideString) of object;
  TCppWebBrowserPropertyChange = procedure(ASender: TObject; const szProperty: WideString) of object;
  TCppWebBrowserBeforeNavigate2 = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                              var URL: OleVariant; 
                                                              var Flags: OleVariant; 
                                                              var TargetFrameName: OleVariant; 
                                                              var PostData: OleVariant; 
                                                              var Headers: OleVariant; 
                                                              var Cancel: WordBool) of object;
  TCppWebBrowserNewWindow2 = procedure(ASender: TObject; var ppDisp: IDispatch; var Cancel: WordBool) of object;
  TCppWebBrowserNavigateComplete2 = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                                var URL: OleVariant) of object;
  TCppWebBrowserDocumentComplete = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                               var URL: OleVariant) of object;
  TCppWebBrowserOnVisible = procedure(ASender: TObject; Visible: WordBool) of object;
  TCppWebBrowserOnToolBar = procedure(ASender: TObject; ToolBar: WordBool) of object;
  TCppWebBrowserOnMenuBar = procedure(ASender: TObject; MenuBar: WordBool) of object;
  TCppWebBrowserOnStatusBar = procedure(ASender: TObject; StatusBar: WordBool) of object;
  TCppWebBrowserOnFullScreen = procedure(ASender: TObject; FullScreen: WordBool) of object;
  TCppWebBrowserOnTheaterMode = procedure(ASender: TObject; TheaterMode: WordBool) of object;
  TCppWebBrowserWindowSetResizable = procedure(ASender: TObject; Resizable: WordBool) of object;
  TCppWebBrowserWindowSetLeft = procedure(ASender: TObject; Left: Integer) of object;
  TCppWebBrowserWindowSetTop = procedure(ASender: TObject; Top: Integer) of object;
  TCppWebBrowserWindowSetWidth = procedure(ASender: TObject; Width: Integer) of object;
  TCppWebBrowserWindowSetHeight = procedure(ASender: TObject; Height: Integer) of object;
  TCppWebBrowserWindowClosing = procedure(ASender: TObject; IsChildWindow: WordBool; 
                                                            var Cancel: WordBool) of object;
  TCppWebBrowserClientToHostWindow = procedure(ASender: TObject; var CX: Integer; var CY: Integer) of object;
  TCppWebBrowserSetSecureLockIcon = procedure(ASender: TObject; SecureLockIcon: Integer) of object;
  TCppWebBrowserFileDownload = procedure(ASender: TObject; ActiveDocument: WordBool; 
                                                           var Cancel: WordBool) of object;
  TCppWebBrowserNavigateError = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                            var URL: OleVariant; 
                                                            var Frame: OleVariant; 
                                                            var StatusCode: OleVariant; 
                                                            var Cancel: WordBool) of object;
  TCppWebBrowserPrintTemplateInstantiation = procedure(ASender: TObject; const pDisp: IDispatch) of object;
  TCppWebBrowserPrintTemplateTeardown = procedure(ASender: TObject; const pDisp: IDispatch) of object;
  TCppWebBrowserUpdatePageStatus = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                               var nPage: OleVariant; 
                                                               var fDone: OleVariant) of object;
  TCppWebBrowserPrivacyImpactedStateChange = procedure(ASender: TObject; bImpacted: WordBool) of object;
  TCppWebBrowserNewWindow3 = procedure(ASender: TObject; var ppDisp: IDispatch; 
                                                         var Cancel: WordBool; dwFlags: LongWord; 
                                                         const bstrUrlContext: WideString; 
                                                         const bstrUrl: WideString) of object;
  TCppWebBrowserSetPhishingFilterStatus = procedure(ASender: TObject; PhishingFilterStatus: Integer) of object;
  TCppWebBrowserWindowStateChanged = procedure(ASender: TObject; dwWindowStateFlags: LongWord; 
                                                                 dwValidFlagsMask: LongWord) of object;

  TCppWebBrowser = class(TOleControl)
  private
    FOnStatusTextChange: TCppWebBrowserStatusTextChange;
    FOnProgressChange: TCppWebBrowserProgressChange;
    FOnCommandStateChange: TCppWebBrowserCommandStateChange;
    FOnDownloadBegin: TNotifyEvent;
    FOnDownloadComplete: TNotifyEvent;
    FOnTitleChange: TCppWebBrowserTitleChange;
    FOnPropertyChange: TCppWebBrowserPropertyChange;
    FOnBeforeNavigate2: TCppWebBrowserBeforeNavigate2;
    FOnNewWindow2: TCppWebBrowserNewWindow2;
    FOnNavigateComplete2: TCppWebBrowserNavigateComplete2;
    FOnDocumentComplete: TCppWebBrowserDocumentComplete;
    FOnQuit: TNotifyEvent;
    FOnVisible: TCppWebBrowserOnVisible;
    FOnToolBar: TCppWebBrowserOnToolBar;
    FOnMenuBar: TCppWebBrowserOnMenuBar;
    FOnStatusBar: TCppWebBrowserOnStatusBar;
    FOnFullScreen: TCppWebBrowserOnFullScreen;
    FOnTheaterMode: TCppWebBrowserOnTheaterMode;
    FOnWindowSetResizable: TCppWebBrowserWindowSetResizable;
    FOnWindowSetLeft: TCppWebBrowserWindowSetLeft;
    FOnWindowSetTop: TCppWebBrowserWindowSetTop;
    FOnWindowSetWidth: TCppWebBrowserWindowSetWidth;
    FOnWindowSetHeight: TCppWebBrowserWindowSetHeight;
    FOnWindowClosing: TCppWebBrowserWindowClosing;
    FOnClientToHostWindow: TCppWebBrowserClientToHostWindow;
    FOnSetSecureLockIcon: TCppWebBrowserSetSecureLockIcon;
    FOnFileDownload: TCppWebBrowserFileDownload;
    FOnNavigateError: TCppWebBrowserNavigateError;
    FOnPrintTemplateInstantiation: TCppWebBrowserPrintTemplateInstantiation;
    FOnPrintTemplateTeardown: TCppWebBrowserPrintTemplateTeardown;
    FOnUpdatePageStatus: TCppWebBrowserUpdatePageStatus;
    FOnPrivacyImpactedStateChange: TCppWebBrowserPrivacyImpactedStateChange;
    FOnNewWindow3: TCppWebBrowserNewWindow3;
    FOnSetPhishingFilterStatus: TCppWebBrowserSetPhishingFilterStatus;
    FOnWindowStateChanged: TCppWebBrowserWindowStateChanged;
    FIntf: IWebBrowser2;
    function  GetControlInterface: IWebBrowser2;
  protected
    procedure CreateControl;
    procedure InitControlData; override;
    function Get_Application: IDispatch;
    function Get_Parent: IDispatch;
    function Get_Container: IDispatch;
    function Get_Document: IDispatch;
  public
    procedure GoBack;
    procedure GoForward;
    procedure GoHome;
    procedure GoSearch;
    procedure Navigate(const URL: WideString); overload;
    procedure Navigate(const URL: WideString; var Flags: OleVariant); overload;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; var TargetFrameName: OleVariant); overload;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; 
                       var TargetFrameName: OleVariant; var PostData: OleVariant); overload;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; 
                       var TargetFrameName: OleVariant; var PostData: OleVariant; 
                       var Headers: OleVariant); overload;
    procedure Refresh;
    procedure Refresh2; overload;
    procedure Refresh2(var Level: OleVariant); overload;
    procedure Stop;
    procedure Quit;
    procedure ClientToWindow(var pcx: SYSINT; var pcy: SYSINT);
    procedure PutProperty(const Property_: WideString; vtValue: OleVariant);
    function GetProperty(const Property_: WideString): OleVariant;
    procedure Navigate2(var URL: OleVariant); overload;
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant); overload;
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant; var TargetFrameName: OleVariant); overload;
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                        var TargetFrameName: OleVariant; var PostData: OleVariant); overload;
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                        var TargetFrameName: OleVariant; var PostData: OleVariant; 
                        var Headers: OleVariant); overload;
    function QueryStatusWB(cmdID: OLECMDID): OLECMDF;
    procedure ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT); overload;
    procedure ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; var pvaIn: OleVariant); overload;
    procedure ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; var pvaIn: OleVariant; 
                     var pvaOut: OleVariant); overload;
    procedure ShowBrowserBar(var pvaClsid: OleVariant); overload;
    procedure ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant); overload;
    procedure ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant; 
                             var pvarSize: OleVariant); overload;
    property  ControlInterface: IWebBrowser2 read GetControlInterface;
    property  DefaultInterface: IWebBrowser2 read GetControlInterface;
    property Application: IDispatch index 200 read GetIDispatchProp;
    property Parent: IDispatch index 201 read GetIDispatchProp;
    property Container: IDispatch index 202 read GetIDispatchProp;
    property Document: IDispatch index 203 read GetIDispatchProp;
    property TopLevelContainer: WordBool index 204 read GetWordBoolProp;
    property type_: WideString index 205 read GetWideStringProp;
    property LocationName: WideString index 210 read GetWideStringProp;
    property LocationURL: WideString index 211 read GetWideStringProp;
    property Busy: WordBool index 212 read GetWordBoolProp;
    property Name: WideString index 0 read GetWideStringProp;
    property HWND: Integer index -515 read GetIntegerProp;
    property FullName: WideString index 400 read GetWideStringProp;
    property Path: WideString index 401 read GetWideStringProp;
    property ReadyState: TOleEnum index -525 read GetTOleEnumProp;
  published
    property Anchors;
    property  TabStop;
    property  Align;
    property  DragCursor;
    property  DragMode;
    property  ParentShowHint;
    property  PopupMenu;
    property  ShowHint;
    property  TabOrder;
    property  OnDragDrop;
    property  OnDragOver;
    property  OnEndDrag;
    property  OnEnter;
    property  OnExit;
    property  OnStartDrag;
    property Visible: WordBool index 402 read GetWordBoolProp write SetWordBoolProp stored False;
    property StatusBar: WordBool index 403 read GetWordBoolProp write SetWordBoolProp stored False;
    property StatusText: WideString index 404 read GetWideStringProp write SetWideStringProp stored False;
    property ToolBar: Integer index 405 read GetIntegerProp write SetIntegerProp stored False;
    property MenuBar: WordBool index 406 read GetWordBoolProp write SetWordBoolProp stored False;
    property FullScreen: WordBool index 407 read GetWordBoolProp write SetWordBoolProp stored False;
    property Offline: WordBool index 550 read GetWordBoolProp write SetWordBoolProp stored False;
    property Silent: WordBool index 551 read GetWordBoolProp write SetWordBoolProp stored False;
    property RegisterAsBrowser: WordBool index 552 read GetWordBoolProp write SetWordBoolProp stored False;
    property RegisterAsDropTarget: WordBool index 553 read GetWordBoolProp write SetWordBoolProp stored False;
    property TheaterMode: WordBool index 554 read GetWordBoolProp write SetWordBoolProp stored False;
    property AddressBar: WordBool index 555 read GetWordBoolProp write SetWordBoolProp stored False;
    property Resizable: WordBool index 556 read GetWordBoolProp write SetWordBoolProp stored False;
    property OnStatusTextChange: TCppWebBrowserStatusTextChange read FOnStatusTextChange write FOnStatusTextChange;
    property OnProgressChange: TCppWebBrowserProgressChange read FOnProgressChange write FOnProgressChange;
    property OnCommandStateChange: TCppWebBrowserCommandStateChange read FOnCommandStateChange write FOnCommandStateChange;
    property OnDownloadBegin: TNotifyEvent read FOnDownloadBegin write FOnDownloadBegin;
    property OnDownloadComplete: TNotifyEvent read FOnDownloadComplete write FOnDownloadComplete;
    property OnTitleChange: TCppWebBrowserTitleChange read FOnTitleChange write FOnTitleChange;
    property OnPropertyChange: TCppWebBrowserPropertyChange read FOnPropertyChange write FOnPropertyChange;
    property OnBeforeNavigate2: TCppWebBrowserBeforeNavigate2 read FOnBeforeNavigate2 write FOnBeforeNavigate2;
    property OnNewWindow2: TCppWebBrowserNewWindow2 read FOnNewWindow2 write FOnNewWindow2;
    property OnNavigateComplete2: TCppWebBrowserNavigateComplete2 read FOnNavigateComplete2 write FOnNavigateComplete2;
    property OnDocumentComplete: TCppWebBrowserDocumentComplete read FOnDocumentComplete write FOnDocumentComplete;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnVisible: TCppWebBrowserOnVisible read FOnVisible write FOnVisible;
    property OnToolBar: TCppWebBrowserOnToolBar read FOnToolBar write FOnToolBar;
    property OnMenuBar: TCppWebBrowserOnMenuBar read FOnMenuBar write FOnMenuBar;
    property OnStatusBar: TCppWebBrowserOnStatusBar read FOnStatusBar write FOnStatusBar;
    property OnFullScreen: TCppWebBrowserOnFullScreen read FOnFullScreen write FOnFullScreen;
    property OnTheaterMode: TCppWebBrowserOnTheaterMode read FOnTheaterMode write FOnTheaterMode;
    property OnWindowSetResizable: TCppWebBrowserWindowSetResizable read FOnWindowSetResizable write FOnWindowSetResizable;
    property OnWindowSetLeft: TCppWebBrowserWindowSetLeft read FOnWindowSetLeft write FOnWindowSetLeft;
    property OnWindowSetTop: TCppWebBrowserWindowSetTop read FOnWindowSetTop write FOnWindowSetTop;
    property OnWindowSetWidth: TCppWebBrowserWindowSetWidth read FOnWindowSetWidth write FOnWindowSetWidth;
    property OnWindowSetHeight: TCppWebBrowserWindowSetHeight read FOnWindowSetHeight write FOnWindowSetHeight;
    property OnWindowClosing: TCppWebBrowserWindowClosing read FOnWindowClosing write FOnWindowClosing;
    property OnClientToHostWindow: TCppWebBrowserClientToHostWindow read FOnClientToHostWindow write FOnClientToHostWindow;
    property OnSetSecureLockIcon: TCppWebBrowserSetSecureLockIcon read FOnSetSecureLockIcon write FOnSetSecureLockIcon;
    property OnFileDownload: TCppWebBrowserFileDownload read FOnFileDownload write FOnFileDownload;
    property OnNavigateError: TCppWebBrowserNavigateError read FOnNavigateError write FOnNavigateError;
    property OnPrintTemplateInstantiation: TCppWebBrowserPrintTemplateInstantiation read FOnPrintTemplateInstantiation write FOnPrintTemplateInstantiation;
    property OnPrintTemplateTeardown: TCppWebBrowserPrintTemplateTeardown read FOnPrintTemplateTeardown write FOnPrintTemplateTeardown;
    property OnUpdatePageStatus: TCppWebBrowserUpdatePageStatus read FOnUpdatePageStatus write FOnUpdatePageStatus;
    property OnPrivacyImpactedStateChange: TCppWebBrowserPrivacyImpactedStateChange read FOnPrivacyImpactedStateChange write FOnPrivacyImpactedStateChange;
    property OnNewWindow3: TCppWebBrowserNewWindow3 read FOnNewWindow3 write FOnNewWindow3;
    property OnSetPhishingFilterStatus: TCppWebBrowserSetPhishingFilterStatus read FOnSetPhishingFilterStatus write FOnSetPhishingFilterStatus;
    property OnWindowStateChanged: TCppWebBrowserWindowStateChanged read FOnWindowStateChanged write FOnWindowStateChanged;
  end;

// *********************************************************************//
// The Class CoCppInternetExplorer provides a Create and CreateRemote method to          
// create instances of the default interface IWebBrowser2 exposed by              
// the CoClass CppInternetExplorer. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCppInternetExplorer = class
    class function Create: IWebBrowser2;
    class function CreateRemote(const MachineName: string): IWebBrowser2;
  end;

  TCppInternetExplorerStatusTextChange = procedure(ASender: TObject; const Text: WideString) of object;
  TCppInternetExplorerProgressChange = procedure(ASender: TObject; Progress: Integer; 
                                                                   ProgressMax: Integer) of object;
  TCppInternetExplorerCommandStateChange = procedure(ASender: TObject; Command: Integer; 
                                                                       Enable: WordBool) of object;
  TCppInternetExplorerTitleChange = procedure(ASender: TObject; const Text: WideString) of object;
  TCppInternetExplorerPropertyChange = procedure(ASender: TObject; const szProperty: WideString) of object;
  TCppInternetExplorerBeforeNavigate2 = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                                    var URL: OleVariant; 
                                                                    var Flags: OleVariant; 
                                                                    var TargetFrameName: OleVariant; 
                                                                    var PostData: OleVariant; 
                                                                    var Headers: OleVariant; 
                                                                    var Cancel: WordBool) of object;
  TCppInternetExplorerNewWindow2 = procedure(ASender: TObject; var ppDisp: IDispatch; 
                                                               var Cancel: WordBool) of object;
  TCppInternetExplorerNavigateComplete2 = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                                      var URL: OleVariant) of object;
  TCppInternetExplorerDocumentComplete = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                                     var URL: OleVariant) of object;
  TCppInternetExplorerOnVisible = procedure(ASender: TObject; Visible: WordBool) of object;
  TCppInternetExplorerOnToolBar = procedure(ASender: TObject; ToolBar: WordBool) of object;
  TCppInternetExplorerOnMenuBar = procedure(ASender: TObject; MenuBar: WordBool) of object;
  TCppInternetExplorerOnStatusBar = procedure(ASender: TObject; StatusBar: WordBool) of object;
  TCppInternetExplorerOnFullScreen = procedure(ASender: TObject; FullScreen: WordBool) of object;
  TCppInternetExplorerOnTheaterMode = procedure(ASender: TObject; TheaterMode: WordBool) of object;
  TCppInternetExplorerWindowSetResizable = procedure(ASender: TObject; Resizable: WordBool) of object;
  TCppInternetExplorerWindowSetLeft = procedure(ASender: TObject; Left: Integer) of object;
  TCppInternetExplorerWindowSetTop = procedure(ASender: TObject; Top: Integer) of object;
  TCppInternetExplorerWindowSetWidth = procedure(ASender: TObject; Width: Integer) of object;
  TCppInternetExplorerWindowSetHeight = procedure(ASender: TObject; Height: Integer) of object;
  TCppInternetExplorerWindowClosing = procedure(ASender: TObject; IsChildWindow: WordBool; 
                                                                  var Cancel: WordBool) of object;
  TCppInternetExplorerClientToHostWindow = procedure(ASender: TObject; var CX: Integer; 
                                                                       var CY: Integer) of object;
  TCppInternetExplorerSetSecureLockIcon = procedure(ASender: TObject; SecureLockIcon: Integer) of object;
  TCppInternetExplorerFileDownload = procedure(ASender: TObject; ActiveDocument: WordBool; 
                                                                 var Cancel: WordBool) of object;
  TCppInternetExplorerNavigateError = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                                  var URL: OleVariant; 
                                                                  var Frame: OleVariant; 
                                                                  var StatusCode: OleVariant; 
                                                                  var Cancel: WordBool) of object;
  TCppInternetExplorerPrintTemplateInstantiation = procedure(ASender: TObject; const pDisp: IDispatch) of object;
  TCppInternetExplorerPrintTemplateTeardown = procedure(ASender: TObject; const pDisp: IDispatch) of object;
  TCppInternetExplorerUpdatePageStatus = procedure(ASender: TObject; const pDisp: IDispatch; 
                                                                     var nPage: OleVariant; 
                                                                     var fDone: OleVariant) of object;
  TCppInternetExplorerPrivacyImpactedStateChange = procedure(ASender: TObject; bImpacted: WordBool) of object;
  TCppInternetExplorerNewWindow3 = procedure(ASender: TObject; var ppDisp: IDispatch; 
                                                               var Cancel: WordBool; 
                                                               dwFlags: LongWord; 
                                                               const bstrUrlContext: WideString; 
                                                               const bstrUrl: WideString) of object;
  TCppInternetExplorerSetPhishingFilterStatus = procedure(ASender: TObject; PhishingFilterStatus: Integer) of object;
  TCppInternetExplorerWindowStateChanged = procedure(ASender: TObject; dwWindowStateFlags: LongWord; 
                                                                       dwValidFlagsMask: LongWord) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCppInternetExplorer
// Help String      : Internet Explorer Application.
// Default Interface: IWebBrowser2
// Def. Intf. DISP? : No
// Event   Interface: DWebBrowserEvents2
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCppInternetExplorerProperties= class;
{$ENDIF}
  TCppInternetExplorer = class(TOleServer)
  private
    FOnStatusTextChange: TCppInternetExplorerStatusTextChange;
    FOnProgressChange: TCppInternetExplorerProgressChange;
    FOnCommandStateChange: TCppInternetExplorerCommandStateChange;
    FOnDownloadBegin: TNotifyEvent;
    FOnDownloadComplete: TNotifyEvent;
    FOnTitleChange: TCppInternetExplorerTitleChange;
    FOnPropertyChange: TCppInternetExplorerPropertyChange;
    FOnBeforeNavigate2: TCppInternetExplorerBeforeNavigate2;
    FOnNewWindow2: TCppInternetExplorerNewWindow2;
    FOnNavigateComplete2: TCppInternetExplorerNavigateComplete2;
    FOnDocumentComplete: TCppInternetExplorerDocumentComplete;
    FOnQuit: TNotifyEvent;
    FOnVisible: TCppInternetExplorerOnVisible;
    FOnToolBar: TCppInternetExplorerOnToolBar;
    FOnMenuBar: TCppInternetExplorerOnMenuBar;
    FOnStatusBar: TCppInternetExplorerOnStatusBar;
    FOnFullScreen: TCppInternetExplorerOnFullScreen;
    FOnTheaterMode: TCppInternetExplorerOnTheaterMode;
    FOnWindowSetResizable: TCppInternetExplorerWindowSetResizable;
    FOnWindowSetLeft: TCppInternetExplorerWindowSetLeft;
    FOnWindowSetTop: TCppInternetExplorerWindowSetTop;
    FOnWindowSetWidth: TCppInternetExplorerWindowSetWidth;
    FOnWindowSetHeight: TCppInternetExplorerWindowSetHeight;
    FOnWindowClosing: TCppInternetExplorerWindowClosing;
    FOnClientToHostWindow: TCppInternetExplorerClientToHostWindow;
    FOnSetSecureLockIcon: TCppInternetExplorerSetSecureLockIcon;
    FOnFileDownload: TCppInternetExplorerFileDownload;
    FOnNavigateError: TCppInternetExplorerNavigateError;
    FOnPrintTemplateInstantiation: TCppInternetExplorerPrintTemplateInstantiation;
    FOnPrintTemplateTeardown: TCppInternetExplorerPrintTemplateTeardown;
    FOnUpdatePageStatus: TCppInternetExplorerUpdatePageStatus;
    FOnPrivacyImpactedStateChange: TCppInternetExplorerPrivacyImpactedStateChange;
    FOnNewWindow3: TCppInternetExplorerNewWindow3;
    FOnSetPhishingFilterStatus: TCppInternetExplorerSetPhishingFilterStatus;
    FOnWindowStateChanged: TCppInternetExplorerWindowStateChanged;
    FIntf: IWebBrowser2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TCppInternetExplorerProperties;
    function GetServerProperties: TCppInternetExplorerProperties;
{$ENDIF}
    function GetDefaultInterface: IWebBrowser2;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Application: IDispatch;
    function Get_Parent: IDispatch;
    function Get_Container: IDispatch;
    function Get_Document: IDispatch;
    function Get_TopLevelContainer: WordBool;
    function Get_type_: WideString;
    function Get_Left: Integer;
    procedure Set_Left(pl: Integer);
    function Get_Top: Integer;
    procedure Set_Top(pl: Integer);
    function Get_Width: Integer;
    procedure Set_Width(pl: Integer);
    function Get_Height: Integer;
    procedure Set_Height(pl: Integer);
    function Get_LocationName: WideString;
    function Get_LocationURL: WideString;
    function Get_Busy: WordBool;
    function Get_Name: WideString;
    function Get_HWND: Integer;
    function Get_FullName: WideString;
    function Get_Path: WideString;
    function Get_Visible: WordBool;
    procedure Set_Visible(pBool: WordBool);
    function Get_StatusBar: WordBool;
    procedure Set_StatusBar(pBool: WordBool);
    function Get_StatusText: WideString;
    procedure Set_StatusText(const StatusText: WideString);
    function Get_ToolBar: SYSINT;
    procedure Set_ToolBar(Value: SYSINT);
    function Get_MenuBar: WordBool;
    procedure Set_MenuBar(Value: WordBool);
    function Get_FullScreen: WordBool;
    procedure Set_FullScreen(pbFullScreen: WordBool);
    function Get_ReadyState: tagREADYSTATE;
    function Get_Offline: WordBool;
    procedure Set_Offline(pbOffline: WordBool);
    function Get_Silent: WordBool;
    procedure Set_Silent(pbSilent: WordBool);
    function Get_RegisterAsBrowser: WordBool;
    procedure Set_RegisterAsBrowser(pbRegister: WordBool);
    function Get_RegisterAsDropTarget: WordBool;
    procedure Set_RegisterAsDropTarget(pbRegister: WordBool);
    function Get_TheaterMode: WordBool;
    procedure Set_TheaterMode(pbRegister: WordBool);
    function Get_AddressBar: WordBool;
    procedure Set_AddressBar(Value: WordBool);
    function Get_Resizable: WordBool;
    procedure Set_Resizable(Value: WordBool);
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IWebBrowser2);
    procedure Disconnect; override;
    procedure GoBack;
    procedure GoForward;
    procedure GoHome;
    procedure GoSearch;
    procedure Navigate(const URL: WideString); overload;
    procedure Navigate(const URL: WideString; var Flags: OleVariant); overload;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; var TargetFrameName: OleVariant); overload;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; 
                       var TargetFrameName: OleVariant; var PostData: OleVariant); overload;
    procedure Navigate(const URL: WideString; var Flags: OleVariant; 
                       var TargetFrameName: OleVariant; var PostData: OleVariant; 
                       var Headers: OleVariant); overload;
    procedure Refresh;
    procedure Refresh2; overload;
    procedure Refresh2(var Level: OleVariant); overload;
    procedure Stop;
    procedure Quit;
    procedure ClientToWindow(var pcx: SYSINT; var pcy: SYSINT);
    procedure PutProperty(const Property_: WideString; vtValue: OleVariant);
    function GetProperty(const Property_: WideString): OleVariant;
    procedure Navigate2(var URL: OleVariant); overload;
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant); overload;
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant; var TargetFrameName: OleVariant); overload;
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                        var TargetFrameName: OleVariant; var PostData: OleVariant); overload;
    procedure Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                        var TargetFrameName: OleVariant; var PostData: OleVariant; 
                        var Headers: OleVariant); overload;
    function QueryStatusWB(cmdID: OLECMDID): OLECMDF;
    procedure ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT); overload;
    procedure ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; var pvaIn: OleVariant); overload;
    procedure ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; var pvaIn: OleVariant; 
                     var pvaOut: OleVariant); overload;
    procedure ShowBrowserBar(var pvaClsid: OleVariant); overload;
    procedure ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant); overload;
    procedure ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant; 
                             var pvarSize: OleVariant); overload;
    property DefaultInterface: IWebBrowser2 read GetDefaultInterface;
    property Application: IDispatch read Get_Application;
    property Parent: IDispatch read Get_Parent;
    property Container: IDispatch read Get_Container;
    property Document: IDispatch read Get_Document;
    property TopLevelContainer: WordBool read Get_TopLevelContainer;
    property type_: WideString read Get_type_;
    property LocationName: WideString read Get_LocationName;
    property LocationURL: WideString read Get_LocationURL;
    property Busy: WordBool read Get_Busy;
    property Name: WideString read Get_Name;
    property HWND: Integer read Get_HWND;
    property FullName: WideString read Get_FullName;
    property Path: WideString read Get_Path;
    property ReadyState: tagREADYSTATE read Get_ReadyState;
    property Left: Integer read Get_Left write Set_Left;
    property Top: Integer read Get_Top write Set_Top;
    property Width: Integer read Get_Width write Set_Width;
    property Height: Integer read Get_Height write Set_Height;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property StatusBar: WordBool read Get_StatusBar write Set_StatusBar;
    property StatusText: WideString read Get_StatusText write Set_StatusText;
    property ToolBar: SYSINT read Get_ToolBar write Set_ToolBar;
    property MenuBar: WordBool read Get_MenuBar write Set_MenuBar;
    property FullScreen: WordBool read Get_FullScreen write Set_FullScreen;
    property Offline: WordBool read Get_Offline write Set_Offline;
    property Silent: WordBool read Get_Silent write Set_Silent;
    property RegisterAsBrowser: WordBool read Get_RegisterAsBrowser write Set_RegisterAsBrowser;
    property RegisterAsDropTarget: WordBool read Get_RegisterAsDropTarget write Set_RegisterAsDropTarget;
    property TheaterMode: WordBool read Get_TheaterMode write Set_TheaterMode;
    property AddressBar: WordBool read Get_AddressBar write Set_AddressBar;
    property Resizable: WordBool read Get_Resizable write Set_Resizable;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCppInternetExplorerProperties read GetServerProperties;
{$ENDIF}
    property OnStatusTextChange: TCppInternetExplorerStatusTextChange read FOnStatusTextChange write FOnStatusTextChange;
    property OnProgressChange: TCppInternetExplorerProgressChange read FOnProgressChange write FOnProgressChange;
    property OnCommandStateChange: TCppInternetExplorerCommandStateChange read FOnCommandStateChange write FOnCommandStateChange;
    property OnDownloadBegin: TNotifyEvent read FOnDownloadBegin write FOnDownloadBegin;
    property OnDownloadComplete: TNotifyEvent read FOnDownloadComplete write FOnDownloadComplete;
    property OnTitleChange: TCppInternetExplorerTitleChange read FOnTitleChange write FOnTitleChange;
    property OnPropertyChange: TCppInternetExplorerPropertyChange read FOnPropertyChange write FOnPropertyChange;
    property OnBeforeNavigate2: TCppInternetExplorerBeforeNavigate2 read FOnBeforeNavigate2 write FOnBeforeNavigate2;
    property OnNewWindow2: TCppInternetExplorerNewWindow2 read FOnNewWindow2 write FOnNewWindow2;
    property OnNavigateComplete2: TCppInternetExplorerNavigateComplete2 read FOnNavigateComplete2 write FOnNavigateComplete2;
    property OnDocumentComplete: TCppInternetExplorerDocumentComplete read FOnDocumentComplete write FOnDocumentComplete;
    property OnQuit: TNotifyEvent read FOnQuit write FOnQuit;
    property OnVisible: TCppInternetExplorerOnVisible read FOnVisible write FOnVisible;
    property OnToolBar: TCppInternetExplorerOnToolBar read FOnToolBar write FOnToolBar;
    property OnMenuBar: TCppInternetExplorerOnMenuBar read FOnMenuBar write FOnMenuBar;
    property OnStatusBar: TCppInternetExplorerOnStatusBar read FOnStatusBar write FOnStatusBar;
    property OnFullScreen: TCppInternetExplorerOnFullScreen read FOnFullScreen write FOnFullScreen;
    property OnTheaterMode: TCppInternetExplorerOnTheaterMode read FOnTheaterMode write FOnTheaterMode;
    property OnWindowSetResizable: TCppInternetExplorerWindowSetResizable read FOnWindowSetResizable write FOnWindowSetResizable;
    property OnWindowSetLeft: TCppInternetExplorerWindowSetLeft read FOnWindowSetLeft write FOnWindowSetLeft;
    property OnWindowSetTop: TCppInternetExplorerWindowSetTop read FOnWindowSetTop write FOnWindowSetTop;
    property OnWindowSetWidth: TCppInternetExplorerWindowSetWidth read FOnWindowSetWidth write FOnWindowSetWidth;
    property OnWindowSetHeight: TCppInternetExplorerWindowSetHeight read FOnWindowSetHeight write FOnWindowSetHeight;
    property OnWindowClosing: TCppInternetExplorerWindowClosing read FOnWindowClosing write FOnWindowClosing;
    property OnClientToHostWindow: TCppInternetExplorerClientToHostWindow read FOnClientToHostWindow write FOnClientToHostWindow;
    property OnSetSecureLockIcon: TCppInternetExplorerSetSecureLockIcon read FOnSetSecureLockIcon write FOnSetSecureLockIcon;
    property OnFileDownload: TCppInternetExplorerFileDownload read FOnFileDownload write FOnFileDownload;
    property OnNavigateError: TCppInternetExplorerNavigateError read FOnNavigateError write FOnNavigateError;
    property OnPrintTemplateInstantiation: TCppInternetExplorerPrintTemplateInstantiation read FOnPrintTemplateInstantiation write FOnPrintTemplateInstantiation;
    property OnPrintTemplateTeardown: TCppInternetExplorerPrintTemplateTeardown read FOnPrintTemplateTeardown write FOnPrintTemplateTeardown;
    property OnUpdatePageStatus: TCppInternetExplorerUpdatePageStatus read FOnUpdatePageStatus write FOnUpdatePageStatus;
    property OnPrivacyImpactedStateChange: TCppInternetExplorerPrivacyImpactedStateChange read FOnPrivacyImpactedStateChange write FOnPrivacyImpactedStateChange;
    property OnNewWindow3: TCppInternetExplorerNewWindow3 read FOnNewWindow3 write FOnNewWindow3;
    property OnSetPhishingFilterStatus: TCppInternetExplorerSetPhishingFilterStatus read FOnSetPhishingFilterStatus write FOnSetPhishingFilterStatus;
    property OnWindowStateChanged: TCppInternetExplorerWindowStateChanged read FOnWindowStateChanged write FOnWindowStateChanged;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCppInternetExplorer
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCppInternetExplorerProperties = class(TPersistent)
  private
    FServer:    TCppInternetExplorer;
    function    GetDefaultInterface: IWebBrowser2;
    constructor Create(AServer: TCppInternetExplorer);
  protected
    function Get_Application: IDispatch;
    function Get_Parent: IDispatch;
    function Get_Container: IDispatch;
    function Get_Document: IDispatch;
    function Get_TopLevelContainer: WordBool;
    function Get_type_: WideString;
    function Get_Left: Integer;
    procedure Set_Left(pl: Integer);
    function Get_Top: Integer;
    procedure Set_Top(pl: Integer);
    function Get_Width: Integer;
    procedure Set_Width(pl: Integer);
    function Get_Height: Integer;
    procedure Set_Height(pl: Integer);
    function Get_LocationName: WideString;
    function Get_LocationURL: WideString;
    function Get_Busy: WordBool;
    function Get_Name: WideString;
    function Get_HWND: Integer;
    function Get_FullName: WideString;
    function Get_Path: WideString;
    function Get_Visible: WordBool;
    procedure Set_Visible(pBool: WordBool);
    function Get_StatusBar: WordBool;
    procedure Set_StatusBar(pBool: WordBool);
    function Get_StatusText: WideString;
    procedure Set_StatusText(const StatusText: WideString);
    function Get_ToolBar: SYSINT;
    procedure Set_ToolBar(Value: SYSINT);
    function Get_MenuBar: WordBool;
    procedure Set_MenuBar(Value: WordBool);
    function Get_FullScreen: WordBool;
    procedure Set_FullScreen(pbFullScreen: WordBool);
    function Get_ReadyState: tagREADYSTATE;
    function Get_Offline: WordBool;
    procedure Set_Offline(pbOffline: WordBool);
    function Get_Silent: WordBool;
    procedure Set_Silent(pbSilent: WordBool);
    function Get_RegisterAsBrowser: WordBool;
    procedure Set_RegisterAsBrowser(pbRegister: WordBool);
    function Get_RegisterAsDropTarget: WordBool;
    procedure Set_RegisterAsDropTarget(pbRegister: WordBool);
    function Get_TheaterMode: WordBool;
    procedure Set_TheaterMode(pbRegister: WordBool);
    function Get_AddressBar: WordBool;
    procedure Set_AddressBar(Value: WordBool);
    function Get_Resizable: WordBool;
    procedure Set_Resizable(Value: WordBool);
  public
    property DefaultInterface: IWebBrowser2 read GetDefaultInterface;
  published
    property Left: Integer read Get_Left write Set_Left;
    property Top: Integer read Get_Top write Set_Top;
    property Width: Integer read Get_Width write Set_Width;
    property Height: Integer read Get_Height write Set_Height;
    property Visible: WordBool read Get_Visible write Set_Visible;
    property StatusBar: WordBool read Get_StatusBar write Set_StatusBar;
    property StatusText: WideString read Get_StatusText write Set_StatusText;
    property ToolBar: SYSINT read Get_ToolBar write Set_ToolBar;
    property MenuBar: WordBool read Get_MenuBar write Set_MenuBar;
    property FullScreen: WordBool read Get_FullScreen write Set_FullScreen;
    property Offline: WordBool read Get_Offline write Set_Offline;
    property Silent: WordBool read Get_Silent write Set_Silent;
    property RegisterAsBrowser: WordBool read Get_RegisterAsBrowser write Set_RegisterAsBrowser;
    property RegisterAsDropTarget: WordBool read Get_RegisterAsDropTarget write Set_RegisterAsDropTarget;
    property TheaterMode: WordBool read Get_TheaterMode write Set_TheaterMode;
    property AddressBar: WordBool read Get_AddressBar write Set_AddressBar;
    property Resizable: WordBool read Get_Resizable write Set_Resizable;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoCppShellBrowserWindow provides a Create and CreateRemote method to          
// create instances of the default interface IWebBrowser2 exposed by              
// the CoClass CppShellBrowserWindow. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCppShellBrowserWindow = class
    class function Create: IWebBrowser2;
    class function CreateRemote(const MachineName: string): IWebBrowser2;
  end;

// *********************************************************************//
// The Class CoCppShellWindows provides a Create and CreateRemote method to          
// create instances of the default interface IShellWindows exposed by              
// the CoClass CppShellWindows. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCppShellWindows = class
    class function Create: IShellWindows;
    class function CreateRemote(const MachineName: string): IShellWindows;
  end;

  TCppShellWindowsWindowRegistered = procedure(ASender: TObject; lCookie: Integer) of object;
  TCppShellWindowsWindowRevoked = procedure(ASender: TObject; lCookie: Integer) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCppShellWindows
// Help String      : ShellDispatch Load in Shell Context
// Default Interface: IShellWindows
// Def. Intf. DISP? : No
// Event   Interface: DShellWindowsEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCppShellWindowsProperties= class;
{$ENDIF}
  TCppShellWindows = class(TOleServer)
  private
    FOnWindowRegistered: TCppShellWindowsWindowRegistered;
    FOnWindowRevoked: TCppShellWindowsWindowRevoked;
    FIntf: IShellWindows;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TCppShellWindowsProperties;
    function GetServerProperties: TCppShellWindowsProperties;
{$ENDIF}
    function GetDefaultInterface: IShellWindows;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_Count: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IShellWindows);
    procedure Disconnect; override;
    function Item: IDispatch; overload;
    function Item(index: OleVariant): IDispatch; overload;
    function _NewEnum: IUnknown;
    procedure Register(const pid: IDispatch; HWND: Integer; swClass: SYSINT; out plCookie: Integer);
    procedure RegisterPending(lThreadId: Integer; var pvarloc: OleVariant; 
                              var pvarlocRoot: OleVariant; swClass: SYSINT; out plCookie: Integer);
    procedure Revoke(lCookie: Integer);
    procedure OnNavigate(lCookie: Integer; var pvarloc: OleVariant);
    procedure OnActivated(lCookie: Integer; fActive: WordBool);
    function FindWindowSW(var pvarloc: OleVariant; var pvarlocRoot: OleVariant; swClass: SYSINT; 
                          out pHWND: Integer; swfwOptions: SYSINT): IDispatch;
    procedure OnCreated(lCookie: Integer; const punk: IUnknown);
    procedure ProcessAttachDetach(fAttach: WordBool);
    property DefaultInterface: IShellWindows read GetDefaultInterface;
    property Count: Integer read Get_Count;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCppShellWindowsProperties read GetServerProperties;
{$ENDIF}
    property OnWindowRegistered: TCppShellWindowsWindowRegistered read FOnWindowRegistered write FOnWindowRegistered;
    property OnWindowRevoked: TCppShellWindowsWindowRevoked read FOnWindowRevoked write FOnWindowRevoked;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCppShellWindows
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCppShellWindowsProperties = class(TPersistent)
  private
    FServer:    TCppShellWindows;
    function    GetDefaultInterface: IShellWindows;
    constructor Create(AServer: TCppShellWindows);
  protected
    function Get_Count: Integer;
  public
    property DefaultInterface: IShellWindows read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoCppShellUIHelper provides a Create and CreateRemote method to          
// create instances of the default interface IShellUIHelper2 exposed by              
// the CoClass CppShellUIHelper. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCppShellUIHelper = class
    class function Create: IShellUIHelper2;
    class function CreateRemote(const MachineName: string): IShellUIHelper2;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TCppShellUIHelper
// Help String      : 
// Default Interface: IShellUIHelper2
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TCppShellUIHelperProperties= class;
{$ENDIF}
  TCppShellUIHelper = class(TOleServer)
  private
    FIntf: IShellUIHelper2;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TCppShellUIHelperProperties;
    function GetServerProperties: TCppShellUIHelperProperties;
{$ENDIF}
    function GetDefaultInterface: IShellUIHelper2;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IShellUIHelper2);
    procedure Disconnect; override;
    procedure ResetFirstBootMode;
    procedure ResetSafeMode;
    procedure RefreshOfflineDesktop;
    procedure AddFavorite(const URL: WideString); overload;
    procedure AddFavorite(const URL: WideString; var Title: OleVariant); overload;
    procedure AddChannel(const URL: WideString);
    procedure AddDesktopComponent(const URL: WideString; const Type_: WideString); overload;
    procedure AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                  var Left: OleVariant); overload;
    procedure AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                  var Left: OleVariant; var Top: OleVariant); overload;
    procedure AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                  var Left: OleVariant; var Top: OleVariant; var Width: OleVariant); overload;
    procedure AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                  var Left: OleVariant; var Top: OleVariant; var Width: OleVariant; 
                                  var Height: OleVariant); overload;
    function IsSubscribed(const URL: WideString): WordBool;
    procedure NavigateAndFind(const URL: WideString; const strQuery: WideString; 
                              var varTargetFrame: OleVariant);
    procedure ImportExportFavorites(fImport: WordBool; const strImpExpPath: WideString);
    procedure AutoCompleteSaveForm; overload;
    procedure AutoCompleteSaveForm(var Form: OleVariant); overload;
    procedure AutoScan(const strSearch: WideString; const strFailureUrl: WideString); overload;
    procedure AutoScan(const strSearch: WideString; const strFailureUrl: WideString; 
                       var pvarTargetFrame: OleVariant); overload;
    procedure AutoCompleteAttach; overload;
    procedure AutoCompleteAttach(var Reserved: OleVariant); overload;
    function ShowBrowserUI(const bstrName: WideString; var pvarIn: OleVariant): OleVariant;
    procedure AddSearchProvider(const URL: WideString);
    procedure RunOnceShown;
    procedure SkipRunOnce;
    procedure CustomizeSettings(fSQM: WordBool; fPhishing: WordBool; const bstrLocale: WideString);
    function SqmEnabled: WordBool;
    function PhishingEnabled: WordBool;
    function BrandImageUri: WideString;
    procedure SkipTabsWelcome;
    procedure DiagnoseConnection;
    procedure CustomizeClearType(fSet: WordBool);
    function IsSearchProviderInstalled(const URL: WideString): LongWord;
    function IsSearchMigrated: WordBool;
    function DefaultSearchProvider: WideString;
    procedure RunOnceRequiredSettingsComplete(fComplete: WordBool);
    function RunOnceHasShown: WordBool;
    function SearchGuideUrl: WideString;
    property DefaultInterface: IShellUIHelper2 read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TCppShellUIHelperProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TCppShellUIHelper
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TCppShellUIHelperProperties = class(TPersistent)
  private
    FServer:    TCppShellUIHelper;
    function    GetDefaultInterface: IShellUIHelper2;
    constructor Create(AServer: TCppShellUIHelper);
  protected
  public
    property DefaultInterface: IShellUIHelper2 read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoShellFavoritesNameSpace provides a Create and CreateRemote method to          
// create instances of the default interface IShellNameSpace exposed by              
// the CoClass ShellFavoritesNameSpace. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShellFavoritesNameSpace = class
    class function Create: IShellNameSpace;
    class function CreateRemote(const MachineName: string): IShellNameSpace;
  end;

  TShellFavoritesNameSpaceFavoritesSelectionChange = procedure(ASender: TObject; cItems: Integer; 
                                                                                 hItem: Integer; 
                                                                                 const strName: WideString; 
                                                                                 const strUrl: WideString; 
                                                                                 cVisits: Integer; 
                                                                                 const strDate: WideString; 
                                                                                 fAvailableOffline: Integer) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TShellFavoritesNameSpace
// Help String      : 
// Default Interface: IShellNameSpace
// Def. Intf. DISP? : No
// Event   Interface: DShellNameSpaceEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TShellFavoritesNameSpaceProperties= class;
{$ENDIF}
  TShellFavoritesNameSpace = class(TOleServer)
  private
    FOnFavoritesSelectionChange: TShellFavoritesNameSpaceFavoritesSelectionChange;
    FOnSelectionChange: TNotifyEvent;
    FOnDoubleClick: TNotifyEvent;
    FOnInitialized: TNotifyEvent;
    FIntf: IShellNameSpace;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TShellFavoritesNameSpaceProperties;
    function GetServerProperties: TShellFavoritesNameSpaceProperties;
{$ENDIF}
    function GetDefaultInterface: IShellNameSpace;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_SubscriptionsEnabled: WordBool;
    function Get_EnumOptions: Integer;
    procedure Set_EnumOptions(pgrfEnumFlags: Integer);
    function Get_SelectedItem: IDispatch;
    procedure Set_SelectedItem(const pItem: IDispatch);
    function Get_Root: OleVariant;
    procedure Set_Root(pvar: OleVariant);
    function Get_Depth: SYSINT;
    procedure Set_Depth(piDepth: SYSINT);
    function Get_Mode: SYSUINT;
    procedure Set_Mode(puMode: SYSUINT);
    function Get_Flags: LongWord;
    procedure Set_Flags(pdwFlags: LongWord);
    procedure Set_TVFlags(dwFlags: LongWord);
    function Get_TVFlags: LongWord;
    function Get_Columns: WideString;
    procedure Set_Columns(const bstrColumns: WideString);
    function Get_CountViewTypes: SYSINT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IShellNameSpace);
    procedure Disconnect; override;
    procedure MoveSelectionUp;
    procedure MoveSelectionDown;
    procedure ResetSort;
    procedure NewFolder;
    procedure Synchronize;
    procedure Import;
    procedure Export;
    procedure InvokeContextMenuCommand(const strCommand: WideString);
    procedure MoveSelectionTo;
    function CreateSubscriptionForSelection: WordBool;
    function DeleteSubscriptionForSelection: WordBool;
    procedure SetRoot(const bstrFullPath: WideString);
    procedure SetViewType(iType: SYSINT);
    function SelectedItems: IDispatch;
    procedure Expand(var_: OleVariant; iDepth: SYSINT);
    procedure UnselectAll;
    property DefaultInterface: IShellNameSpace read GetDefaultInterface;
    property SubscriptionsEnabled: WordBool read Get_SubscriptionsEnabled;
    property SelectedItem: IDispatch read Get_SelectedItem write Set_SelectedItem;
    property Root: OleVariant read Get_Root write Set_Root;
    property CountViewTypes: SYSINT read Get_CountViewTypes;
    property EnumOptions: Integer read Get_EnumOptions write Set_EnumOptions;
    property Depth: SYSINT read Get_Depth write Set_Depth;
    property Mode: SYSUINT read Get_Mode write Set_Mode;
    property Flags: LongWord read Get_Flags write Set_Flags;
    property TVFlags: LongWord read Get_TVFlags write Set_TVFlags;
    property Columns: WideString read Get_Columns write Set_Columns;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TShellFavoritesNameSpaceProperties read GetServerProperties;
{$ENDIF}
    property OnFavoritesSelectionChange: TShellFavoritesNameSpaceFavoritesSelectionChange read FOnFavoritesSelectionChange write FOnFavoritesSelectionChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnDoubleClick: TNotifyEvent read FOnDoubleClick write FOnDoubleClick;
    property OnInitialized: TNotifyEvent read FOnInitialized write FOnInitialized;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TShellFavoritesNameSpace
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TShellFavoritesNameSpaceProperties = class(TPersistent)
  private
    FServer:    TShellFavoritesNameSpace;
    function    GetDefaultInterface: IShellNameSpace;
    constructor Create(AServer: TShellFavoritesNameSpace);
  protected
    function Get_SubscriptionsEnabled: WordBool;
    function Get_EnumOptions: Integer;
    procedure Set_EnumOptions(pgrfEnumFlags: Integer);
    function Get_SelectedItem: IDispatch;
    procedure Set_SelectedItem(const pItem: IDispatch);
    function Get_Root: OleVariant;
    procedure Set_Root(pvar: OleVariant);
    function Get_Depth: SYSINT;
    procedure Set_Depth(piDepth: SYSINT);
    function Get_Mode: SYSUINT;
    procedure Set_Mode(puMode: SYSUINT);
    function Get_Flags: LongWord;
    procedure Set_Flags(pdwFlags: LongWord);
    procedure Set_TVFlags(dwFlags: LongWord);
    function Get_TVFlags: LongWord;
    function Get_Columns: WideString;
    procedure Set_Columns(const bstrColumns: WideString);
    function Get_CountViewTypes: SYSINT;
  public
    property DefaultInterface: IShellNameSpace read GetDefaultInterface;
  published
    property EnumOptions: Integer read Get_EnumOptions write Set_EnumOptions;
    property Depth: SYSINT read Get_Depth write Set_Depth;
    property Mode: SYSUINT read Get_Mode write Set_Mode;
    property Flags: LongWord read Get_Flags write Set_Flags;
    property TVFlags: LongWord read Get_TVFlags write Set_TVFlags;
    property Columns: WideString read Get_Columns write Set_Columns;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoShellShellNameSpace provides a Create and CreateRemote method to          
// create instances of the default interface IShellNameSpace exposed by              
// the CoClass ShellShellNameSpace. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoShellShellNameSpace = class
    class function Create: IShellNameSpace;
    class function CreateRemote(const MachineName: string): IShellNameSpace;
  end;

  TShellShellNameSpaceFavoritesSelectionChange = procedure(ASender: TObject; cItems: Integer; 
                                                                             hItem: Integer; 
                                                                             const strName: WideString; 
                                                                             const strUrl: WideString; 
                                                                             cVisits: Integer; 
                                                                             const strDate: WideString; 
                                                                             fAvailableOffline: Integer) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TShellShellNameSpace
// Help String      : Shell ShellNameSpace Class
// Default Interface: IShellNameSpace
// Def. Intf. DISP? : No
// Event   Interface: DShellNameSpaceEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TShellShellNameSpaceProperties= class;
{$ENDIF}
  TShellShellNameSpace = class(TOleServer)
  private
    FOnFavoritesSelectionChange: TShellShellNameSpaceFavoritesSelectionChange;
    FOnSelectionChange: TNotifyEvent;
    FOnDoubleClick: TNotifyEvent;
    FOnInitialized: TNotifyEvent;
    FIntf: IShellNameSpace;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps: TShellShellNameSpaceProperties;
    function GetServerProperties: TShellShellNameSpaceProperties;
{$ENDIF}
    function GetDefaultInterface: IShellNameSpace;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_SubscriptionsEnabled: WordBool;
    function Get_EnumOptions: Integer;
    procedure Set_EnumOptions(pgrfEnumFlags: Integer);
    function Get_SelectedItem: IDispatch;
    procedure Set_SelectedItem(const pItem: IDispatch);
    function Get_Root: OleVariant;
    procedure Set_Root(pvar: OleVariant);
    function Get_Depth: SYSINT;
    procedure Set_Depth(piDepth: SYSINT);
    function Get_Mode: SYSUINT;
    procedure Set_Mode(puMode: SYSUINT);
    function Get_Flags: LongWord;
    procedure Set_Flags(pdwFlags: LongWord);
    procedure Set_TVFlags(dwFlags: LongWord);
    function Get_TVFlags: LongWord;
    function Get_Columns: WideString;
    procedure Set_Columns(const bstrColumns: WideString);
    function Get_CountViewTypes: SYSINT;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IShellNameSpace);
    procedure Disconnect; override;
    procedure MoveSelectionUp;
    procedure MoveSelectionDown;
    procedure ResetSort;
    procedure NewFolder;
    procedure Synchronize;
    procedure Import;
    procedure Export;
    procedure InvokeContextMenuCommand(const strCommand: WideString);
    procedure MoveSelectionTo;
    function CreateSubscriptionForSelection: WordBool;
    function DeleteSubscriptionForSelection: WordBool;
    procedure SetRoot(const bstrFullPath: WideString);
    procedure SetViewType(iType: SYSINT);
    function SelectedItems: IDispatch;
    procedure Expand(var_: OleVariant; iDepth: SYSINT);
    procedure UnselectAll;
    property DefaultInterface: IShellNameSpace read GetDefaultInterface;
    property SubscriptionsEnabled: WordBool read Get_SubscriptionsEnabled;
    property SelectedItem: IDispatch read Get_SelectedItem write Set_SelectedItem;
    property Root: OleVariant read Get_Root write Set_Root;
    property CountViewTypes: SYSINT read Get_CountViewTypes;
    property EnumOptions: Integer read Get_EnumOptions write Set_EnumOptions;
    property Depth: SYSINT read Get_Depth write Set_Depth;
    property Mode: SYSUINT read Get_Mode write Set_Mode;
    property Flags: LongWord read Get_Flags write Set_Flags;
    property TVFlags: LongWord read Get_TVFlags write Set_TVFlags;
    property Columns: WideString read Get_Columns write Set_Columns;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TShellShellNameSpaceProperties read GetServerProperties;
{$ENDIF}
    property OnFavoritesSelectionChange: TShellShellNameSpaceFavoritesSelectionChange read FOnFavoritesSelectionChange write FOnFavoritesSelectionChange;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnDoubleClick: TNotifyEvent read FOnDoubleClick write FOnDoubleClick;
    property OnInitialized: TNotifyEvent read FOnInitialized write FOnInitialized;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TShellShellNameSpace
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TShellShellNameSpaceProperties = class(TPersistent)
  private
    FServer:    TShellShellNameSpace;
    function    GetDefaultInterface: IShellNameSpace;
    constructor Create(AServer: TShellShellNameSpace);
  protected
    function Get_SubscriptionsEnabled: WordBool;
    function Get_EnumOptions: Integer;
    procedure Set_EnumOptions(pgrfEnumFlags: Integer);
    function Get_SelectedItem: IDispatch;
    procedure Set_SelectedItem(const pItem: IDispatch);
    function Get_Root: OleVariant;
    procedure Set_Root(pvar: OleVariant);
    function Get_Depth: SYSINT;
    procedure Set_Depth(piDepth: SYSINT);
    function Get_Mode: SYSUINT;
    procedure Set_Mode(puMode: SYSUINT);
    function Get_Flags: LongWord;
    procedure Set_Flags(pdwFlags: LongWord);
    procedure Set_TVFlags(dwFlags: LongWord);
    function Get_TVFlags: LongWord;
    function Get_Columns: WideString;
    procedure Set_Columns(const bstrColumns: WideString);
    function Get_CountViewTypes: SYSINT;
  public
    property DefaultInterface: IShellNameSpace read GetDefaultInterface;
  published
    property EnumOptions: Integer read Get_EnumOptions write Set_EnumOptions;
    property Depth: SYSINT read Get_Depth write Set_Depth;
    property Mode: SYSUINT read Get_Mode write Set_Mode;
    property Flags: LongWord read Get_Flags write Set_Flags;
    property TVFlags: LongWord read Get_TVFlags write Set_TVFlags;
    property Columns: WideString read Get_Columns write Set_Columns;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoCppCScriptErrorList provides a Create and CreateRemote method to          
// create instances of the default interface IScriptErrorList exposed by              
// the CoClass CppCScriptErrorList. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoCppCScriptErrorList = class
    class function Create: IScriptErrorList;
    class function CreateRemote(const MachineName: string): IScriptErrorList;
  end;

procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

procedure TCppWebBrowser.InitControlData;
const
  CEventDispIDs: array [0..34] of DWORD = (
    $00000066, $0000006C, $00000069, $0000006A, $00000068, $00000071,
    $00000070, $000000FA, $000000FB, $000000FC, $00000103, $000000FD,
    $000000FE, $000000FF, $00000100, $00000101, $00000102, $00000104,
    $00000106, $00000108, $00000109, $0000010A, $0000010B, $00000107,
    $0000010C, $0000010D, $0000010E, $0000010F, $000000E1, $000000E2,
    $000000E3, $00000110, $00000111, $0000011A, $0000011B);
  CControlData: TControlData2 = (
    ClassID: '{8856F961-340A-11D0-A96B-00C04FD705A2}';
    EventIID: '{34A715A0-6587-11D0-924A-0020AFC7AC4D}';
    EventCount: 35;
    EventDispIDs: @CEventDispIDs;
    LicenseKey: nil (*HR:$80040111*);
    Flags: $00000000;
    Version: 401);
begin
  ControlData := @CControlData;
  TControlData2(CControlData).FirstEventOfs := Cardinal(@@FOnStatusTextChange) - Cardinal(Self);
end;

procedure TCppWebBrowser.CreateControl;

  procedure DoCreate;
  begin
    FIntf := IUnknown(OleObject) as IWebBrowser2;
  end;

begin
  if FIntf = nil then DoCreate;
end;

function TCppWebBrowser.GetControlInterface: IWebBrowser2;
begin
  CreateControl;
  Result := FIntf;
end;

function TCppWebBrowser.Get_Application: IDispatch;
begin
    Result := DefaultInterface.Application;
end;

function TCppWebBrowser.Get_Parent: IDispatch;
begin
    Result := DefaultInterface.Parent;
end;

function TCppWebBrowser.Get_Container: IDispatch;
begin
    Result := DefaultInterface.Container;
end;

function TCppWebBrowser.Get_Document: IDispatch;
begin
    Result := DefaultInterface.Document;
end;

procedure TCppWebBrowser.GoBack;
begin
  DefaultInterface.GoBack;
end;

procedure TCppWebBrowser.GoForward;
begin
  DefaultInterface.GoForward;
end;

procedure TCppWebBrowser.GoHome;
begin
  DefaultInterface.GoHome;
end;

procedure TCppWebBrowser.GoSearch;
begin
  DefaultInterface.GoSearch;
end;

procedure TCppWebBrowser.Navigate(const URL: WideString);
begin
  DefaultInterface.Navigate(URL, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppWebBrowser.Navigate(const URL: WideString; var Flags: OleVariant);
begin
  DefaultInterface.Navigate(URL, Flags, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppWebBrowser.Navigate(const URL: WideString; var Flags: OleVariant; 
                                  var TargetFrameName: OleVariant);
begin
  DefaultInterface.Navigate(URL, Flags, TargetFrameName, EmptyParam, EmptyParam);
end;

procedure TCppWebBrowser.Navigate(const URL: WideString; var Flags: OleVariant; 
                                  var TargetFrameName: OleVariant; var PostData: OleVariant);
begin
  DefaultInterface.Navigate(URL, Flags, TargetFrameName, PostData, EmptyParam);
end;

procedure TCppWebBrowser.Navigate(const URL: WideString; var Flags: OleVariant; 
                                  var TargetFrameName: OleVariant; var PostData: OleVariant; 
                                  var Headers: OleVariant);
begin
  DefaultInterface.Navigate(URL, Flags, TargetFrameName, PostData, Headers);
end;

procedure TCppWebBrowser.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TCppWebBrowser.Refresh2;
begin
  DefaultInterface.Refresh2(EmptyParam);
end;

procedure TCppWebBrowser.Refresh2(var Level: OleVariant);
begin
  DefaultInterface.Refresh2(Level);
end;

procedure TCppWebBrowser.Stop;
begin
  DefaultInterface.Stop;
end;

procedure TCppWebBrowser.Quit;
begin
  DefaultInterface.Quit;
end;

procedure TCppWebBrowser.ClientToWindow(var pcx: SYSINT; var pcy: SYSINT);
begin
  DefaultInterface.ClientToWindow(pcx, pcy);
end;

procedure TCppWebBrowser.PutProperty(const Property_: WideString; vtValue: OleVariant);
begin
  DefaultInterface.PutProperty(Property_, vtValue);
end;

function TCppWebBrowser.GetProperty(const Property_: WideString): OleVariant;
begin
  Result := DefaultInterface.GetProperty(Property_);
end;

procedure TCppWebBrowser.Navigate2(var URL: OleVariant);
begin
  DefaultInterface.Navigate2(URL, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppWebBrowser.Navigate2(var URL: OleVariant; var Flags: OleVariant);
begin
  DefaultInterface.Navigate2(URL, Flags, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppWebBrowser.Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                                   var TargetFrameName: OleVariant);
begin
  DefaultInterface.Navigate2(URL, Flags, TargetFrameName, EmptyParam, EmptyParam);
end;

procedure TCppWebBrowser.Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                                   var TargetFrameName: OleVariant; var PostData: OleVariant);
begin
  DefaultInterface.Navigate2(URL, Flags, TargetFrameName, PostData, EmptyParam);
end;

procedure TCppWebBrowser.Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                                   var TargetFrameName: OleVariant; var PostData: OleVariant; 
                                   var Headers: OleVariant);
begin
  DefaultInterface.Navigate2(URL, Flags, TargetFrameName, PostData, Headers);
end;

function TCppWebBrowser.QueryStatusWB(cmdID: OLECMDID): OLECMDF;
begin
  Result := DefaultInterface.QueryStatusWB(cmdID);
end;

procedure TCppWebBrowser.ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT);
begin
  DefaultInterface.ExecWB(cmdID, cmdexecopt, EmptyParam, EmptyParam);
end;

procedure TCppWebBrowser.ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; var pvaIn: OleVariant);
begin
  DefaultInterface.ExecWB(cmdID, cmdexecopt, pvaIn, EmptyParam);
end;

procedure TCppWebBrowser.ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; var pvaIn: OleVariant; 
                                var pvaOut: OleVariant);
begin
  DefaultInterface.ExecWB(cmdID, cmdexecopt, pvaIn, pvaOut);
end;

procedure TCppWebBrowser.ShowBrowserBar(var pvaClsid: OleVariant);
begin
  DefaultInterface.ShowBrowserBar(pvaClsid, EmptyParam, EmptyParam);
end;

procedure TCppWebBrowser.ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant);
begin
  DefaultInterface.ShowBrowserBar(pvaClsid, pvarShow, EmptyParam);
end;

procedure TCppWebBrowser.ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant; 
                                        var pvarSize: OleVariant);
begin
  DefaultInterface.ShowBrowserBar(pvaClsid, pvarShow, pvarSize);
end;

class function CoCppInternetExplorer.Create: IWebBrowser2;
begin
  Result := CreateComObject(CLASS_CppInternetExplorer) as IWebBrowser2;
end;

class function CoCppInternetExplorer.CreateRemote(const MachineName: string): IWebBrowser2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CppInternetExplorer) as IWebBrowser2;
end;

procedure TCppInternetExplorer.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{0002DF01-0000-0000-C000-000000000046}';
    IntfIID:   '{D30C1661-CDAF-11D0-8A3E-00C04FC9E26E}';
    EventIID:  '{34A715A0-6587-11D0-924A-0020AFC7AC4D}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCppInternetExplorer.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IWebBrowser2;
  end;
end;

procedure TCppInternetExplorer.ConnectTo(svrIntf: IWebBrowser2);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TCppInternetExplorer.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TCppInternetExplorer.GetDefaultInterface: IWebBrowser2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCppInternetExplorer.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCppInternetExplorerProperties.Create(Self);
{$ENDIF}
end;

destructor TCppInternetExplorer.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCppInternetExplorer.GetServerProperties: TCppInternetExplorerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TCppInternetExplorer.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    102: if Assigned(FOnStatusTextChange) then
         FOnStatusTextChange(Self, Params[0] {const WideString});
    108: if Assigned(FOnProgressChange) then
         FOnProgressChange(Self,
                           Params[0] {Integer},
                           Params[1] {Integer});
    105: if Assigned(FOnCommandStateChange) then
         FOnCommandStateChange(Self,
                               Params[0] {Integer},
                               Params[1] {WordBool});
    106: if Assigned(FOnDownloadBegin) then
         FOnDownloadBegin(Self);
    104: if Assigned(FOnDownloadComplete) then
         FOnDownloadComplete(Self);
    113: if Assigned(FOnTitleChange) then
         FOnTitleChange(Self, Params[0] {const WideString});
    112: if Assigned(FOnPropertyChange) then
         FOnPropertyChange(Self, Params[0] {const WideString});
    250: if Assigned(FOnBeforeNavigate2) then
         FOnBeforeNavigate2(Self,
                            Params[0] {const IDispatch},
                            OleVariant((TVarData(Params[1]).VPointer)^) {var OleVariant},
                            OleVariant((TVarData(Params[2]).VPointer)^) {var OleVariant},
                            OleVariant((TVarData(Params[3]).VPointer)^) {var OleVariant},
                            OleVariant((TVarData(Params[4]).VPointer)^) {var OleVariant},
                            OleVariant((TVarData(Params[5]).VPointer)^) {var OleVariant},
                            WordBool((TVarData(Params[6]).VPointer)^) {var WordBool});
    251: if Assigned(FOnNewWindow2) then
         FOnNewWindow2(Self,
                       IDispatch((TVarData(Params[0]).VPointer)^) {var IDispatch},
                       WordBool((TVarData(Params[1]).VPointer)^) {var WordBool});
    252: if Assigned(FOnNavigateComplete2) then
         FOnNavigateComplete2(Self,
                              Params[0] {const IDispatch},
                              OleVariant((TVarData(Params[1]).VPointer)^) {var OleVariant});
    259: if Assigned(FOnDocumentComplete) then
         FOnDocumentComplete(Self,
                             Params[0] {const IDispatch},
                             OleVariant((TVarData(Params[1]).VPointer)^) {var OleVariant});
    253: if Assigned(FOnQuit) then
         FOnQuit(Self);
    254: if Assigned(FOnVisible) then
         FOnVisible(Self, Params[0] {WordBool});
    255: if Assigned(FOnToolBar) then
         FOnToolBar(Self, Params[0] {WordBool});
    256: if Assigned(FOnMenuBar) then
         FOnMenuBar(Self, Params[0] {WordBool});
    257: if Assigned(FOnStatusBar) then
         FOnStatusBar(Self, Params[0] {WordBool});
    258: if Assigned(FOnFullScreen) then
         FOnFullScreen(Self, Params[0] {WordBool});
    260: if Assigned(FOnTheaterMode) then
         FOnTheaterMode(Self, Params[0] {WordBool});
    262: if Assigned(FOnWindowSetResizable) then
         FOnWindowSetResizable(Self, Params[0] {WordBool});
    264: if Assigned(FOnWindowSetLeft) then
         FOnWindowSetLeft(Self, Params[0] {Integer});
    265: if Assigned(FOnWindowSetTop) then
         FOnWindowSetTop(Self, Params[0] {Integer});
    266: if Assigned(FOnWindowSetWidth) then
         FOnWindowSetWidth(Self, Params[0] {Integer});
    267: if Assigned(FOnWindowSetHeight) then
         FOnWindowSetHeight(Self, Params[0] {Integer});
    263: if Assigned(FOnWindowClosing) then
         FOnWindowClosing(Self,
                          Params[0] {WordBool},
                          WordBool((TVarData(Params[1]).VPointer)^) {var WordBool});
    268: if Assigned(FOnClientToHostWindow) then
         FOnClientToHostWindow(Self,
                               Integer((TVarData(Params[0]).VPointer)^) {var Integer},
                               Integer((TVarData(Params[1]).VPointer)^) {var Integer});
    269: if Assigned(FOnSetSecureLockIcon) then
         FOnSetSecureLockIcon(Self, Params[0] {Integer});
    270: if Assigned(FOnFileDownload) then
         FOnFileDownload(Self,
                         Params[0] {WordBool},
                         WordBool((TVarData(Params[1]).VPointer)^) {var WordBool});
    271: if Assigned(FOnNavigateError) then
         FOnNavigateError(Self,
                          Params[0] {const IDispatch},
                          OleVariant((TVarData(Params[1]).VPointer)^) {var OleVariant},
                          OleVariant((TVarData(Params[2]).VPointer)^) {var OleVariant},
                          OleVariant((TVarData(Params[3]).VPointer)^) {var OleVariant},
                          WordBool((TVarData(Params[4]).VPointer)^) {var WordBool});
    225: if Assigned(FOnPrintTemplateInstantiation) then
         FOnPrintTemplateInstantiation(Self, Params[0] {const IDispatch});
    226: if Assigned(FOnPrintTemplateTeardown) then
         FOnPrintTemplateTeardown(Self, Params[0] {const IDispatch});
    227: if Assigned(FOnUpdatePageStatus) then
         FOnUpdatePageStatus(Self,
                             Params[0] {const IDispatch},
                             OleVariant((TVarData(Params[1]).VPointer)^) {var OleVariant},
                             OleVariant((TVarData(Params[2]).VPointer)^) {var OleVariant});
    272: if Assigned(FOnPrivacyImpactedStateChange) then
         FOnPrivacyImpactedStateChange(Self, Params[0] {WordBool});
    273: if Assigned(FOnNewWindow3) then
         FOnNewWindow3(Self,
                       IDispatch((TVarData(Params[0]).VPointer)^) {var IDispatch},
                       WordBool((TVarData(Params[1]).VPointer)^) {var WordBool},
                       Params[2] {LongWord},
                       Params[3] {const WideString},
                       Params[4] {const WideString});
    282: if Assigned(FOnSetPhishingFilterStatus) then
         FOnSetPhishingFilterStatus(Self, Params[0] {Integer});
    283: if Assigned(FOnWindowStateChanged) then
         FOnWindowStateChanged(Self,
                               Params[0] {LongWord},
                               Params[1] {LongWord});
  end; {case DispID}
end;

function TCppInternetExplorer.Get_Application: IDispatch;
begin
    Result := DefaultInterface.Application;
end;

function TCppInternetExplorer.Get_Parent: IDispatch;
begin
    Result := DefaultInterface.Parent;
end;

function TCppInternetExplorer.Get_Container: IDispatch;
begin
    Result := DefaultInterface.Container;
end;

function TCppInternetExplorer.Get_Document: IDispatch;
begin
    Result := DefaultInterface.Document;
end;

function TCppInternetExplorer.Get_TopLevelContainer: WordBool;
begin
    Result := DefaultInterface.TopLevelContainer;
end;

function TCppInternetExplorer.Get_type_: WideString;
begin
    Result := DefaultInterface.type_;
end;

function TCppInternetExplorer.Get_Left: Integer;
begin
    Result := DefaultInterface.Left;
end;

procedure TCppInternetExplorer.Set_Left(pl: Integer);
begin
  DefaultInterface.Set_Left(pl);
end;

function TCppInternetExplorer.Get_Top: Integer;
begin
    Result := DefaultInterface.Top;
end;

procedure TCppInternetExplorer.Set_Top(pl: Integer);
begin
  DefaultInterface.Set_Top(pl);
end;

function TCppInternetExplorer.Get_Width: Integer;
begin
    Result := DefaultInterface.Width;
end;

procedure TCppInternetExplorer.Set_Width(pl: Integer);
begin
  DefaultInterface.Set_Width(pl);
end;

function TCppInternetExplorer.Get_Height: Integer;
begin
    Result := DefaultInterface.Height;
end;

procedure TCppInternetExplorer.Set_Height(pl: Integer);
begin
  DefaultInterface.Set_Height(pl);
end;

function TCppInternetExplorer.Get_LocationName: WideString;
begin
    Result := DefaultInterface.LocationName;
end;

function TCppInternetExplorer.Get_LocationURL: WideString;
begin
    Result := DefaultInterface.LocationURL;
end;

function TCppInternetExplorer.Get_Busy: WordBool;
begin
    Result := DefaultInterface.Busy;
end;

function TCppInternetExplorer.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TCppInternetExplorer.Get_HWND: Integer;
begin
    Result := DefaultInterface.HWND;
end;

function TCppInternetExplorer.Get_FullName: WideString;
begin
    Result := DefaultInterface.FullName;
end;

function TCppInternetExplorer.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

function TCppInternetExplorer.Get_Visible: WordBool;
begin
    Result := DefaultInterface.Visible;
end;

procedure TCppInternetExplorer.Set_Visible(pBool: WordBool);
begin
  DefaultInterface.Set_Visible(pBool);
end;

function TCppInternetExplorer.Get_StatusBar: WordBool;
begin
    Result := DefaultInterface.StatusBar;
end;

procedure TCppInternetExplorer.Set_StatusBar(pBool: WordBool);
begin
  DefaultInterface.Set_StatusBar(pBool);
end;

function TCppInternetExplorer.Get_StatusText: WideString;
begin
    Result := DefaultInterface.StatusText;
end;

procedure TCppInternetExplorer.Set_StatusText(const StatusText: WideString);
  { Warning: The property StatusText has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.StatusText := StatusText;
end;

function TCppInternetExplorer.Get_ToolBar: SYSINT;
begin
    Result := DefaultInterface.ToolBar;
end;

procedure TCppInternetExplorer.Set_ToolBar(Value: SYSINT);
begin
  DefaultInterface.Set_ToolBar(Value);
end;

function TCppInternetExplorer.Get_MenuBar: WordBool;
begin
    Result := DefaultInterface.MenuBar;
end;

procedure TCppInternetExplorer.Set_MenuBar(Value: WordBool);
begin
  DefaultInterface.Set_MenuBar(Value);
end;

function TCppInternetExplorer.Get_FullScreen: WordBool;
begin
    Result := DefaultInterface.FullScreen;
end;

procedure TCppInternetExplorer.Set_FullScreen(pbFullScreen: WordBool);
begin
  DefaultInterface.Set_FullScreen(pbFullScreen);
end;

function TCppInternetExplorer.Get_ReadyState: tagREADYSTATE;
begin
    Result := DefaultInterface.ReadyState;
end;

function TCppInternetExplorer.Get_Offline: WordBool;
begin
    Result := DefaultInterface.Offline;
end;

procedure TCppInternetExplorer.Set_Offline(pbOffline: WordBool);
begin
  DefaultInterface.Set_Offline(pbOffline);
end;

function TCppInternetExplorer.Get_Silent: WordBool;
begin
    Result := DefaultInterface.Silent;
end;

procedure TCppInternetExplorer.Set_Silent(pbSilent: WordBool);
begin
  DefaultInterface.Set_Silent(pbSilent);
end;

function TCppInternetExplorer.Get_RegisterAsBrowser: WordBool;
begin
    Result := DefaultInterface.RegisterAsBrowser;
end;

procedure TCppInternetExplorer.Set_RegisterAsBrowser(pbRegister: WordBool);
begin
  DefaultInterface.Set_RegisterAsBrowser(pbRegister);
end;

function TCppInternetExplorer.Get_RegisterAsDropTarget: WordBool;
begin
    Result := DefaultInterface.RegisterAsDropTarget;
end;

procedure TCppInternetExplorer.Set_RegisterAsDropTarget(pbRegister: WordBool);
begin
  DefaultInterface.Set_RegisterAsDropTarget(pbRegister);
end;

function TCppInternetExplorer.Get_TheaterMode: WordBool;
begin
    Result := DefaultInterface.TheaterMode;
end;

procedure TCppInternetExplorer.Set_TheaterMode(pbRegister: WordBool);
begin
  DefaultInterface.Set_TheaterMode(pbRegister);
end;

function TCppInternetExplorer.Get_AddressBar: WordBool;
begin
    Result := DefaultInterface.AddressBar;
end;

procedure TCppInternetExplorer.Set_AddressBar(Value: WordBool);
begin
  DefaultInterface.Set_AddressBar(Value);
end;

function TCppInternetExplorer.Get_Resizable: WordBool;
begin
    Result := DefaultInterface.Resizable;
end;

procedure TCppInternetExplorer.Set_Resizable(Value: WordBool);
begin
  DefaultInterface.Set_Resizable(Value);
end;

procedure TCppInternetExplorer.GoBack;
begin
  DefaultInterface.GoBack;
end;

procedure TCppInternetExplorer.GoForward;
begin
  DefaultInterface.GoForward;
end;

procedure TCppInternetExplorer.GoHome;
begin
  DefaultInterface.GoHome;
end;

procedure TCppInternetExplorer.GoSearch;
begin
  DefaultInterface.GoSearch;
end;

procedure TCppInternetExplorer.Navigate(const URL: WideString);
begin
  DefaultInterface.Navigate(URL, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppInternetExplorer.Navigate(const URL: WideString; var Flags: OleVariant);
begin
  DefaultInterface.Navigate(URL, Flags, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppInternetExplorer.Navigate(const URL: WideString; var Flags: OleVariant; 
                                        var TargetFrameName: OleVariant);
begin
  DefaultInterface.Navigate(URL, Flags, TargetFrameName, EmptyParam, EmptyParam);
end;

procedure TCppInternetExplorer.Navigate(const URL: WideString; var Flags: OleVariant; 
                                        var TargetFrameName: OleVariant; var PostData: OleVariant);
begin
  DefaultInterface.Navigate(URL, Flags, TargetFrameName, PostData, EmptyParam);
end;

procedure TCppInternetExplorer.Navigate(const URL: WideString; var Flags: OleVariant; 
                                        var TargetFrameName: OleVariant; var PostData: OleVariant; 
                                        var Headers: OleVariant);
begin
  DefaultInterface.Navigate(URL, Flags, TargetFrameName, PostData, Headers);
end;

procedure TCppInternetExplorer.Refresh;
begin
  DefaultInterface.Refresh;
end;

procedure TCppInternetExplorer.Refresh2;
begin
  DefaultInterface.Refresh2(EmptyParam);
end;

procedure TCppInternetExplorer.Refresh2(var Level: OleVariant);
begin
  DefaultInterface.Refresh2(Level);
end;

procedure TCppInternetExplorer.Stop;
begin
  DefaultInterface.Stop;
end;

procedure TCppInternetExplorer.Quit;
begin
  DefaultInterface.Quit;
end;

procedure TCppInternetExplorer.ClientToWindow(var pcx: SYSINT; var pcy: SYSINT);
begin
  DefaultInterface.ClientToWindow(pcx, pcy);
end;

procedure TCppInternetExplorer.PutProperty(const Property_: WideString; vtValue: OleVariant);
begin
  DefaultInterface.PutProperty(Property_, vtValue);
end;

function TCppInternetExplorer.GetProperty(const Property_: WideString): OleVariant;
begin
  Result := DefaultInterface.GetProperty(Property_);
end;

procedure TCppInternetExplorer.Navigate2(var URL: OleVariant);
begin
  DefaultInterface.Navigate2(URL, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppInternetExplorer.Navigate2(var URL: OleVariant; var Flags: OleVariant);
begin
  DefaultInterface.Navigate2(URL, Flags, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppInternetExplorer.Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                                         var TargetFrameName: OleVariant);
begin
  DefaultInterface.Navigate2(URL, Flags, TargetFrameName, EmptyParam, EmptyParam);
end;

procedure TCppInternetExplorer.Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                                         var TargetFrameName: OleVariant; var PostData: OleVariant);
begin
  DefaultInterface.Navigate2(URL, Flags, TargetFrameName, PostData, EmptyParam);
end;

procedure TCppInternetExplorer.Navigate2(var URL: OleVariant; var Flags: OleVariant; 
                                         var TargetFrameName: OleVariant; var PostData: OleVariant; 
                                         var Headers: OleVariant);
begin
  DefaultInterface.Navigate2(URL, Flags, TargetFrameName, PostData, Headers);
end;

function TCppInternetExplorer.QueryStatusWB(cmdID: OLECMDID): OLECMDF;
begin
  Result := DefaultInterface.QueryStatusWB(cmdID);
end;

procedure TCppInternetExplorer.ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT);
begin
  DefaultInterface.ExecWB(cmdID, cmdexecopt, EmptyParam, EmptyParam);
end;

procedure TCppInternetExplorer.ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; 
                                      var pvaIn: OleVariant);
begin
  DefaultInterface.ExecWB(cmdID, cmdexecopt, pvaIn, EmptyParam);
end;

procedure TCppInternetExplorer.ExecWB(cmdID: OLECMDID; cmdexecopt: OLECMDEXECOPT; 
                                      var pvaIn: OleVariant; var pvaOut: OleVariant);
begin
  DefaultInterface.ExecWB(cmdID, cmdexecopt, pvaIn, pvaOut);
end;

procedure TCppInternetExplorer.ShowBrowserBar(var pvaClsid: OleVariant);
begin
  DefaultInterface.ShowBrowserBar(pvaClsid, EmptyParam, EmptyParam);
end;

procedure TCppInternetExplorer.ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant);
begin
  DefaultInterface.ShowBrowserBar(pvaClsid, pvarShow, EmptyParam);
end;

procedure TCppInternetExplorer.ShowBrowserBar(var pvaClsid: OleVariant; var pvarShow: OleVariant; 
                                              var pvarSize: OleVariant);
begin
  DefaultInterface.ShowBrowserBar(pvaClsid, pvarShow, pvarSize);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCppInternetExplorerProperties.Create(AServer: TCppInternetExplorer);
begin
  inherited Create;
  FServer := AServer;
end;

function TCppInternetExplorerProperties.GetDefaultInterface: IWebBrowser2;
begin
  Result := FServer.DefaultInterface;
end;

function TCppInternetExplorerProperties.Get_Application: IDispatch;
begin
    Result := DefaultInterface.Application;
end;

function TCppInternetExplorerProperties.Get_Parent: IDispatch;
begin
    Result := DefaultInterface.Parent;
end;

function TCppInternetExplorerProperties.Get_Container: IDispatch;
begin
    Result := DefaultInterface.Container;
end;

function TCppInternetExplorerProperties.Get_Document: IDispatch;
begin
    Result := DefaultInterface.Document;
end;

function TCppInternetExplorerProperties.Get_TopLevelContainer: WordBool;
begin
    Result := DefaultInterface.TopLevelContainer;
end;

function TCppInternetExplorerProperties.Get_type_: WideString;
begin
    Result := DefaultInterface.type_;
end;

function TCppInternetExplorerProperties.Get_Left: Integer;
begin
    Result := DefaultInterface.Left;
end;

procedure TCppInternetExplorerProperties.Set_Left(pl: Integer);
begin
  DefaultInterface.Set_Left(pl);
end;

function TCppInternetExplorerProperties.Get_Top: Integer;
begin
    Result := DefaultInterface.Top;
end;

procedure TCppInternetExplorerProperties.Set_Top(pl: Integer);
begin
  DefaultInterface.Set_Top(pl);
end;

function TCppInternetExplorerProperties.Get_Width: Integer;
begin
    Result := DefaultInterface.Width;
end;

procedure TCppInternetExplorerProperties.Set_Width(pl: Integer);
begin
  DefaultInterface.Set_Width(pl);
end;

function TCppInternetExplorerProperties.Get_Height: Integer;
begin
    Result := DefaultInterface.Height;
end;

procedure TCppInternetExplorerProperties.Set_Height(pl: Integer);
begin
  DefaultInterface.Set_Height(pl);
end;

function TCppInternetExplorerProperties.Get_LocationName: WideString;
begin
    Result := DefaultInterface.LocationName;
end;

function TCppInternetExplorerProperties.Get_LocationURL: WideString;
begin
    Result := DefaultInterface.LocationURL;
end;

function TCppInternetExplorerProperties.Get_Busy: WordBool;
begin
    Result := DefaultInterface.Busy;
end;

function TCppInternetExplorerProperties.Get_Name: WideString;
begin
    Result := DefaultInterface.Name;
end;

function TCppInternetExplorerProperties.Get_HWND: Integer;
begin
    Result := DefaultInterface.HWND;
end;

function TCppInternetExplorerProperties.Get_FullName: WideString;
begin
    Result := DefaultInterface.FullName;
end;

function TCppInternetExplorerProperties.Get_Path: WideString;
begin
    Result := DefaultInterface.Path;
end;

function TCppInternetExplorerProperties.Get_Visible: WordBool;
begin
    Result := DefaultInterface.Visible;
end;

procedure TCppInternetExplorerProperties.Set_Visible(pBool: WordBool);
begin
  DefaultInterface.Set_Visible(pBool);
end;

function TCppInternetExplorerProperties.Get_StatusBar: WordBool;
begin
    Result := DefaultInterface.StatusBar;
end;

procedure TCppInternetExplorerProperties.Set_StatusBar(pBool: WordBool);
begin
  DefaultInterface.Set_StatusBar(pBool);
end;

function TCppInternetExplorerProperties.Get_StatusText: WideString;
begin
    Result := DefaultInterface.StatusText;
end;

procedure TCppInternetExplorerProperties.Set_StatusText(const StatusText: WideString);
  { Warning: The property StatusText has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.StatusText := StatusText;
end;

function TCppInternetExplorerProperties.Get_ToolBar: SYSINT;
begin
    Result := DefaultInterface.ToolBar;
end;

procedure TCppInternetExplorerProperties.Set_ToolBar(Value: SYSINT);
begin
  DefaultInterface.Set_ToolBar(Value);
end;

function TCppInternetExplorerProperties.Get_MenuBar: WordBool;
begin
    Result := DefaultInterface.MenuBar;
end;

procedure TCppInternetExplorerProperties.Set_MenuBar(Value: WordBool);
begin
  DefaultInterface.Set_MenuBar(Value);
end;

function TCppInternetExplorerProperties.Get_FullScreen: WordBool;
begin
    Result := DefaultInterface.FullScreen;
end;

procedure TCppInternetExplorerProperties.Set_FullScreen(pbFullScreen: WordBool);
begin
  DefaultInterface.Set_FullScreen(pbFullScreen);
end;

function TCppInternetExplorerProperties.Get_ReadyState: tagREADYSTATE;
begin
    Result := DefaultInterface.ReadyState;
end;

function TCppInternetExplorerProperties.Get_Offline: WordBool;
begin
    Result := DefaultInterface.Offline;
end;

procedure TCppInternetExplorerProperties.Set_Offline(pbOffline: WordBool);
begin
  DefaultInterface.Set_Offline(pbOffline);
end;

function TCppInternetExplorerProperties.Get_Silent: WordBool;
begin
    Result := DefaultInterface.Silent;
end;

procedure TCppInternetExplorerProperties.Set_Silent(pbSilent: WordBool);
begin
  DefaultInterface.Set_Silent(pbSilent);
end;

function TCppInternetExplorerProperties.Get_RegisterAsBrowser: WordBool;
begin
    Result := DefaultInterface.RegisterAsBrowser;
end;

procedure TCppInternetExplorerProperties.Set_RegisterAsBrowser(pbRegister: WordBool);
begin
  DefaultInterface.Set_RegisterAsBrowser(pbRegister);
end;

function TCppInternetExplorerProperties.Get_RegisterAsDropTarget: WordBool;
begin
    Result := DefaultInterface.RegisterAsDropTarget;
end;

procedure TCppInternetExplorerProperties.Set_RegisterAsDropTarget(pbRegister: WordBool);
begin
  DefaultInterface.Set_RegisterAsDropTarget(pbRegister);
end;

function TCppInternetExplorerProperties.Get_TheaterMode: WordBool;
begin
    Result := DefaultInterface.TheaterMode;
end;

procedure TCppInternetExplorerProperties.Set_TheaterMode(pbRegister: WordBool);
begin
  DefaultInterface.Set_TheaterMode(pbRegister);
end;

function TCppInternetExplorerProperties.Get_AddressBar: WordBool;
begin
    Result := DefaultInterface.AddressBar;
end;

procedure TCppInternetExplorerProperties.Set_AddressBar(Value: WordBool);
begin
  DefaultInterface.Set_AddressBar(Value);
end;

function TCppInternetExplorerProperties.Get_Resizable: WordBool;
begin
    Result := DefaultInterface.Resizable;
end;

procedure TCppInternetExplorerProperties.Set_Resizable(Value: WordBool);
begin
  DefaultInterface.Set_Resizable(Value);
end;

{$ENDIF}

class function CoCppShellBrowserWindow.Create: IWebBrowser2;
begin
  Result := CreateComObject(CLASS_CppShellBrowserWindow) as IWebBrowser2;
end;

class function CoCppShellBrowserWindow.CreateRemote(const MachineName: string): IWebBrowser2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CppShellBrowserWindow) as IWebBrowser2;
end;

class function CoCppShellWindows.Create: IShellWindows;
begin
  Result := CreateComObject(CLASS_CppShellWindows) as IShellWindows;
end;

class function CoCppShellWindows.CreateRemote(const MachineName: string): IShellWindows;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CppShellWindows) as IShellWindows;
end;

procedure TCppShellWindows.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{9BA05972-F6A8-11CF-A442-00A0C90A8F39}';
    IntfIID:   '{85CB6900-4D95-11CF-960C-0080C7F4EE85}';
    EventIID:  '{FE4106E0-399A-11D0-A48C-00A0C90A8F39}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCppShellWindows.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IShellWindows;
  end;
end;

procedure TCppShellWindows.ConnectTo(svrIntf: IShellWindows);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TCppShellWindows.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TCppShellWindows.GetDefaultInterface: IShellWindows;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCppShellWindows.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCppShellWindowsProperties.Create(Self);
{$ENDIF}
end;

destructor TCppShellWindows.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCppShellWindows.GetServerProperties: TCppShellWindowsProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TCppShellWindows.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    200: if Assigned(FOnWindowRegistered) then
         FOnWindowRegistered(Self, Params[0] {Integer});
    201: if Assigned(FOnWindowRevoked) then
         FOnWindowRevoked(Self, Params[0] {Integer});
  end; {case DispID}
end;

function TCppShellWindows.Get_Count: Integer;
begin
    Result := DefaultInterface.Count;
end;

function TCppShellWindows.Item: IDispatch;
begin
  Result := DefaultInterface.Item(EmptyParam);
end;

function TCppShellWindows.Item(index: OleVariant): IDispatch;
begin
  Result := DefaultInterface.Item(index);
end;

function TCppShellWindows._NewEnum: IUnknown;
begin
  Result := DefaultInterface._NewEnum;
end;

procedure TCppShellWindows.Register(const pid: IDispatch; HWND: Integer; swClass: SYSINT; 
                                    out plCookie: Integer);
begin
  DefaultInterface.Register(pid, HWND, swClass, plCookie);
end;

procedure TCppShellWindows.RegisterPending(lThreadId: Integer; var pvarloc: OleVariant; 
                                           var pvarlocRoot: OleVariant; swClass: SYSINT; 
                                           out plCookie: Integer);
begin
  DefaultInterface.RegisterPending(lThreadId, pvarloc, pvarlocRoot, swClass, plCookie);
end;

procedure TCppShellWindows.Revoke(lCookie: Integer);
begin
  DefaultInterface.Revoke(lCookie);
end;

procedure TCppShellWindows.OnNavigate(lCookie: Integer; var pvarloc: OleVariant);
begin
  DefaultInterface.OnNavigate(lCookie, pvarloc);
end;

procedure TCppShellWindows.OnActivated(lCookie: Integer; fActive: WordBool);
begin
  DefaultInterface.OnActivated(lCookie, fActive);
end;

function TCppShellWindows.FindWindowSW(var pvarloc: OleVariant; var pvarlocRoot: OleVariant; 
                                       swClass: SYSINT; out pHWND: Integer; swfwOptions: SYSINT): IDispatch;
begin
  Result := DefaultInterface.FindWindowSW(pvarloc, pvarlocRoot, swClass, pHWND, swfwOptions);
end;

procedure TCppShellWindows.OnCreated(lCookie: Integer; const punk: IUnknown);
begin
  DefaultInterface.OnCreated(lCookie, punk);
end;

procedure TCppShellWindows.ProcessAttachDetach(fAttach: WordBool);
begin
  DefaultInterface.ProcessAttachDetach(fAttach);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCppShellWindowsProperties.Create(AServer: TCppShellWindows);
begin
  inherited Create;
  FServer := AServer;
end;

function TCppShellWindowsProperties.GetDefaultInterface: IShellWindows;
begin
  Result := FServer.DefaultInterface;
end;

function TCppShellWindowsProperties.Get_Count: Integer;
begin
    Result := DefaultInterface.Count;
end;

{$ENDIF}

class function CoCppShellUIHelper.Create: IShellUIHelper2;
begin
  Result := CreateComObject(CLASS_CppShellUIHelper) as IShellUIHelper2;
end;

class function CoCppShellUIHelper.CreateRemote(const MachineName: string): IShellUIHelper2;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CppShellUIHelper) as IShellUIHelper2;
end;

procedure TCppShellUIHelper.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{64AB4BB7-111E-11D1-8F79-00C04FC2FBE1}';
    IntfIID:   '{A7FE6EDA-1932-4281-B881-87B31B8BC52C}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TCppShellUIHelper.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IShellUIHelper2;
  end;
end;

procedure TCppShellUIHelper.ConnectTo(svrIntf: IShellUIHelper2);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TCppShellUIHelper.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TCppShellUIHelper.GetDefaultInterface: IShellUIHelper2;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TCppShellUIHelper.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TCppShellUIHelperProperties.Create(Self);
{$ENDIF}
end;

destructor TCppShellUIHelper.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TCppShellUIHelper.GetServerProperties: TCppShellUIHelperProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TCppShellUIHelper.ResetFirstBootMode;
begin
  DefaultInterface.ResetFirstBootMode;
end;

procedure TCppShellUIHelper.ResetSafeMode;
begin
  DefaultInterface.ResetSafeMode;
end;

procedure TCppShellUIHelper.RefreshOfflineDesktop;
begin
  DefaultInterface.RefreshOfflineDesktop;
end;

procedure TCppShellUIHelper.AddFavorite(const URL: WideString);
begin
  DefaultInterface.AddFavorite(URL, EmptyParam);
end;

procedure TCppShellUIHelper.AddFavorite(const URL: WideString; var Title: OleVariant);
begin
  DefaultInterface.AddFavorite(URL, Title);
end;

procedure TCppShellUIHelper.AddChannel(const URL: WideString);
begin
  DefaultInterface.AddChannel(URL);
end;

procedure TCppShellUIHelper.AddDesktopComponent(const URL: WideString; const Type_: WideString);
begin
  DefaultInterface.AddDesktopComponent(URL, Type_, EmptyParam, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppShellUIHelper.AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                                var Left: OleVariant);
begin
  DefaultInterface.AddDesktopComponent(URL, Type_, Left, EmptyParam, EmptyParam, EmptyParam);
end;

procedure TCppShellUIHelper.AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                                var Left: OleVariant; var Top: OleVariant);
begin
  DefaultInterface.AddDesktopComponent(URL, Type_, Left, Top, EmptyParam, EmptyParam);
end;

procedure TCppShellUIHelper.AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                                var Left: OleVariant; var Top: OleVariant; 
                                                var Width: OleVariant);
begin
  DefaultInterface.AddDesktopComponent(URL, Type_, Left, Top, Width, EmptyParam);
end;

procedure TCppShellUIHelper.AddDesktopComponent(const URL: WideString; const Type_: WideString; 
                                                var Left: OleVariant; var Top: OleVariant; 
                                                var Width: OleVariant; var Height: OleVariant);
begin
  DefaultInterface.AddDesktopComponent(URL, Type_, Left, Top, Width, Height);
end;

function TCppShellUIHelper.IsSubscribed(const URL: WideString): WordBool;
begin
  Result := DefaultInterface.IsSubscribed(URL);
end;

procedure TCppShellUIHelper.NavigateAndFind(const URL: WideString; const strQuery: WideString; 
                                            var varTargetFrame: OleVariant);
begin
  DefaultInterface.NavigateAndFind(URL, strQuery, varTargetFrame);
end;

procedure TCppShellUIHelper.ImportExportFavorites(fImport: WordBool; const strImpExpPath: WideString);
begin
  DefaultInterface.ImportExportFavorites(fImport, strImpExpPath);
end;

procedure TCppShellUIHelper.AutoCompleteSaveForm;
begin
  DefaultInterface.AutoCompleteSaveForm(EmptyParam);
end;

procedure TCppShellUIHelper.AutoCompleteSaveForm(var Form: OleVariant);
begin
  DefaultInterface.AutoCompleteSaveForm(Form);
end;

procedure TCppShellUIHelper.AutoScan(const strSearch: WideString; const strFailureUrl: WideString);
begin
  DefaultInterface.AutoScan(strSearch, strFailureUrl, EmptyParam);
end;

procedure TCppShellUIHelper.AutoScan(const strSearch: WideString; const strFailureUrl: WideString; 
                                     var pvarTargetFrame: OleVariant);
begin
  DefaultInterface.AutoScan(strSearch, strFailureUrl, pvarTargetFrame);
end;

procedure TCppShellUIHelper.AutoCompleteAttach;
begin
  DefaultInterface.AutoCompleteAttach(EmptyParam);
end;

procedure TCppShellUIHelper.AutoCompleteAttach(var Reserved: OleVariant);
begin
  DefaultInterface.AutoCompleteAttach(Reserved);
end;

function TCppShellUIHelper.ShowBrowserUI(const bstrName: WideString; var pvarIn: OleVariant): OleVariant;
begin
  Result := DefaultInterface.ShowBrowserUI(bstrName, pvarIn);
end;

procedure TCppShellUIHelper.AddSearchProvider(const URL: WideString);
begin
  DefaultInterface.AddSearchProvider(URL);
end;

procedure TCppShellUIHelper.RunOnceShown;
begin
  DefaultInterface.RunOnceShown;
end;

procedure TCppShellUIHelper.SkipRunOnce;
begin
  DefaultInterface.SkipRunOnce;
end;

procedure TCppShellUIHelper.CustomizeSettings(fSQM: WordBool; fPhishing: WordBool; 
                                              const bstrLocale: WideString);
begin
  DefaultInterface.CustomizeSettings(fSQM, fPhishing, bstrLocale);
end;

function TCppShellUIHelper.SqmEnabled: WordBool;
begin
  Result := DefaultInterface.SqmEnabled;
end;

function TCppShellUIHelper.PhishingEnabled: WordBool;
begin
  Result := DefaultInterface.PhishingEnabled;
end;

function TCppShellUIHelper.BrandImageUri: WideString;
begin
  Result := DefaultInterface.BrandImageUri;
end;

procedure TCppShellUIHelper.SkipTabsWelcome;
begin
  DefaultInterface.SkipTabsWelcome;
end;

procedure TCppShellUIHelper.DiagnoseConnection;
begin
  DefaultInterface.DiagnoseConnection;
end;

procedure TCppShellUIHelper.CustomizeClearType(fSet: WordBool);
begin
  DefaultInterface.CustomizeClearType(fSet);
end;

function TCppShellUIHelper.IsSearchProviderInstalled(const URL: WideString): LongWord;
begin
  Result := DefaultInterface.IsSearchProviderInstalled(URL);
end;

function TCppShellUIHelper.IsSearchMigrated: WordBool;
begin
  Result := DefaultInterface.IsSearchMigrated;
end;

function TCppShellUIHelper.DefaultSearchProvider: WideString;
begin
  Result := DefaultInterface.DefaultSearchProvider;
end;

procedure TCppShellUIHelper.RunOnceRequiredSettingsComplete(fComplete: WordBool);
begin
  DefaultInterface.RunOnceRequiredSettingsComplete(fComplete);
end;

function TCppShellUIHelper.RunOnceHasShown: WordBool;
begin
  Result := DefaultInterface.RunOnceHasShown;
end;

function TCppShellUIHelper.SearchGuideUrl: WideString;
begin
  Result := DefaultInterface.SearchGuideUrl;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TCppShellUIHelperProperties.Create(AServer: TCppShellUIHelper);
begin
  inherited Create;
  FServer := AServer;
end;

function TCppShellUIHelperProperties.GetDefaultInterface: IShellUIHelper2;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoShellFavoritesNameSpace.Create: IShellNameSpace;
begin
  Result := CreateComObject(CLASS_ShellFavoritesNameSpace) as IShellNameSpace;
end;

class function CoShellFavoritesNameSpace.CreateRemote(const MachineName: string): IShellNameSpace;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShellFavoritesNameSpace) as IShellNameSpace;
end;

procedure TShellFavoritesNameSpace.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{55136805-B2DE-11D1-B9F2-00A0C98BC547}';
    IntfIID:   '{E572D3C9-37BE-4AE2-825D-D521763E3108}';
    EventIID:  '{55136806-B2DE-11D1-B9F2-00A0C98BC547}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TShellFavoritesNameSpace.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IShellNameSpace;
  end;
end;

procedure TShellFavoritesNameSpace.ConnectTo(svrIntf: IShellNameSpace);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TShellFavoritesNameSpace.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TShellFavoritesNameSpace.GetDefaultInterface: IShellNameSpace;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TShellFavoritesNameSpace.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TShellFavoritesNameSpaceProperties.Create(Self);
{$ENDIF}
end;

destructor TShellFavoritesNameSpace.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TShellFavoritesNameSpace.GetServerProperties: TShellFavoritesNameSpaceProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TShellFavoritesNameSpace.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnFavoritesSelectionChange) then
         FOnFavoritesSelectionChange(Self,
                                     Params[0] {Integer},
                                     Params[1] {Integer},
                                     Params[2] {const WideString},
                                     Params[3] {const WideString},
                                     Params[4] {Integer},
                                     Params[5] {const WideString},
                                     Params[6] {Integer});
    2: if Assigned(FOnSelectionChange) then
         FOnSelectionChange(Self);
    3: if Assigned(FOnDoubleClick) then
         FOnDoubleClick(Self);
    4: if Assigned(FOnInitialized) then
         FOnInitialized(Self);
  end; {case DispID}
end;

function TShellFavoritesNameSpace.Get_SubscriptionsEnabled: WordBool;
begin
    Result := DefaultInterface.SubscriptionsEnabled;
end;

function TShellFavoritesNameSpace.Get_EnumOptions: Integer;
begin
    Result := DefaultInterface.EnumOptions;
end;

procedure TShellFavoritesNameSpace.Set_EnumOptions(pgrfEnumFlags: Integer);
begin
  DefaultInterface.Set_EnumOptions(pgrfEnumFlags);
end;

function TShellFavoritesNameSpace.Get_SelectedItem: IDispatch;
begin
    Result := DefaultInterface.SelectedItem;
end;

procedure TShellFavoritesNameSpace.Set_SelectedItem(const pItem: IDispatch);
begin
  DefaultInterface.Set_SelectedItem(pItem);
end;

function TShellFavoritesNameSpace.Get_Root: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Root;
end;

procedure TShellFavoritesNameSpace.Set_Root(pvar: OleVariant);
begin
  DefaultInterface.Set_Root(pvar);
end;

function TShellFavoritesNameSpace.Get_Depth: SYSINT;
begin
    Result := DefaultInterface.Depth;
end;

procedure TShellFavoritesNameSpace.Set_Depth(piDepth: SYSINT);
begin
  DefaultInterface.Set_Depth(piDepth);
end;

function TShellFavoritesNameSpace.Get_Mode: SYSUINT;
begin
    Result := DefaultInterface.Mode;
end;

procedure TShellFavoritesNameSpace.Set_Mode(puMode: SYSUINT);
begin
  DefaultInterface.Set_Mode(puMode);
end;

function TShellFavoritesNameSpace.Get_Flags: LongWord;
begin
    Result := DefaultInterface.Flags;
end;

procedure TShellFavoritesNameSpace.Set_Flags(pdwFlags: LongWord);
begin
  DefaultInterface.Set_Flags(pdwFlags);
end;

procedure TShellFavoritesNameSpace.Set_TVFlags(dwFlags: LongWord);
begin
  DefaultInterface.Set_TVFlags(dwFlags);
end;

function TShellFavoritesNameSpace.Get_TVFlags: LongWord;
begin
    Result := DefaultInterface.TVFlags;
end;

function TShellFavoritesNameSpace.Get_Columns: WideString;
begin
    Result := DefaultInterface.Columns;
end;

procedure TShellFavoritesNameSpace.Set_Columns(const bstrColumns: WideString);
  { Warning: The property Columns has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Columns := bstrColumns;
end;

function TShellFavoritesNameSpace.Get_CountViewTypes: SYSINT;
begin
    Result := DefaultInterface.CountViewTypes;
end;

procedure TShellFavoritesNameSpace.MoveSelectionUp;
begin
  DefaultInterface.MoveSelectionUp;
end;

procedure TShellFavoritesNameSpace.MoveSelectionDown;
begin
  DefaultInterface.MoveSelectionDown;
end;

procedure TShellFavoritesNameSpace.ResetSort;
begin
  DefaultInterface.ResetSort;
end;

procedure TShellFavoritesNameSpace.NewFolder;
begin
  DefaultInterface.NewFolder;
end;

procedure TShellFavoritesNameSpace.Synchronize;
begin
  DefaultInterface.Synchronize;
end;

procedure TShellFavoritesNameSpace.Import;
begin
  DefaultInterface.Import;
end;

procedure TShellFavoritesNameSpace.Export;
begin
  DefaultInterface.Export;
end;

procedure TShellFavoritesNameSpace.InvokeContextMenuCommand(const strCommand: WideString);
begin
  DefaultInterface.InvokeContextMenuCommand(strCommand);
end;

procedure TShellFavoritesNameSpace.MoveSelectionTo;
begin
  DefaultInterface.MoveSelectionTo;
end;

function TShellFavoritesNameSpace.CreateSubscriptionForSelection: WordBool;
begin
  Result := DefaultInterface.CreateSubscriptionForSelection;
end;

function TShellFavoritesNameSpace.DeleteSubscriptionForSelection: WordBool;
begin
  Result := DefaultInterface.DeleteSubscriptionForSelection;
end;

procedure TShellFavoritesNameSpace.SetRoot(const bstrFullPath: WideString);
begin
  DefaultInterface.SetRoot(bstrFullPath);
end;

procedure TShellFavoritesNameSpace.SetViewType(iType: SYSINT);
begin
  DefaultInterface.SetViewType(iType);
end;

function TShellFavoritesNameSpace.SelectedItems: IDispatch;
begin
  Result := DefaultInterface.SelectedItems;
end;

procedure TShellFavoritesNameSpace.Expand(var_: OleVariant; iDepth: SYSINT);
begin
  DefaultInterface.Expand(var_, iDepth);
end;

procedure TShellFavoritesNameSpace.UnselectAll;
begin
  DefaultInterface.UnselectAll;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TShellFavoritesNameSpaceProperties.Create(AServer: TShellFavoritesNameSpace);
begin
  inherited Create;
  FServer := AServer;
end;

function TShellFavoritesNameSpaceProperties.GetDefaultInterface: IShellNameSpace;
begin
  Result := FServer.DefaultInterface;
end;

function TShellFavoritesNameSpaceProperties.Get_SubscriptionsEnabled: WordBool;
begin
    Result := DefaultInterface.SubscriptionsEnabled;
end;

function TShellFavoritesNameSpaceProperties.Get_EnumOptions: Integer;
begin
    Result := DefaultInterface.EnumOptions;
end;

procedure TShellFavoritesNameSpaceProperties.Set_EnumOptions(pgrfEnumFlags: Integer);
begin
  DefaultInterface.Set_EnumOptions(pgrfEnumFlags);
end;

function TShellFavoritesNameSpaceProperties.Get_SelectedItem: IDispatch;
begin
    Result := DefaultInterface.SelectedItem;
end;

procedure TShellFavoritesNameSpaceProperties.Set_SelectedItem(const pItem: IDispatch);
begin
  DefaultInterface.Set_SelectedItem(pItem);
end;

function TShellFavoritesNameSpaceProperties.Get_Root: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Root;
end;

procedure TShellFavoritesNameSpaceProperties.Set_Root(pvar: OleVariant);
begin
  DefaultInterface.Set_Root(pvar);
end;

function TShellFavoritesNameSpaceProperties.Get_Depth: SYSINT;
begin
    Result := DefaultInterface.Depth;
end;

procedure TShellFavoritesNameSpaceProperties.Set_Depth(piDepth: SYSINT);
begin
  DefaultInterface.Set_Depth(piDepth);
end;

function TShellFavoritesNameSpaceProperties.Get_Mode: SYSUINT;
begin
    Result := DefaultInterface.Mode;
end;

procedure TShellFavoritesNameSpaceProperties.Set_Mode(puMode: SYSUINT);
begin
  DefaultInterface.Set_Mode(puMode);
end;

function TShellFavoritesNameSpaceProperties.Get_Flags: LongWord;
begin
    Result := DefaultInterface.Flags;
end;

procedure TShellFavoritesNameSpaceProperties.Set_Flags(pdwFlags: LongWord);
begin
  DefaultInterface.Set_Flags(pdwFlags);
end;

procedure TShellFavoritesNameSpaceProperties.Set_TVFlags(dwFlags: LongWord);
begin
  DefaultInterface.Set_TVFlags(dwFlags);
end;

function TShellFavoritesNameSpaceProperties.Get_TVFlags: LongWord;
begin
    Result := DefaultInterface.TVFlags;
end;

function TShellFavoritesNameSpaceProperties.Get_Columns: WideString;
begin
    Result := DefaultInterface.Columns;
end;

procedure TShellFavoritesNameSpaceProperties.Set_Columns(const bstrColumns: WideString);
  { Warning: The property Columns has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Columns := bstrColumns;
end;

function TShellFavoritesNameSpaceProperties.Get_CountViewTypes: SYSINT;
begin
    Result := DefaultInterface.CountViewTypes;
end;

{$ENDIF}

class function CoShellShellNameSpace.Create: IShellNameSpace;
begin
  Result := CreateComObject(CLASS_ShellShellNameSpace) as IShellNameSpace;
end;

class function CoShellShellNameSpace.CreateRemote(const MachineName: string): IShellNameSpace;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ShellShellNameSpace) as IShellNameSpace;
end;

procedure TShellShellNameSpace.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2F2F1F96-2BC1-4B1C-BE28-EA3774F4676A}';
    IntfIID:   '{E572D3C9-37BE-4AE2-825D-D521763E3108}';
    EventIID:  '{55136806-B2DE-11D1-B9F2-00A0C98BC547}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TShellShellNameSpace.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IShellNameSpace;
  end;
end;

procedure TShellShellNameSpace.ConnectTo(svrIntf: IShellNameSpace);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TShellShellNameSpace.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TShellShellNameSpace.GetDefaultInterface: IShellNameSpace;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TShellShellNameSpace.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TShellShellNameSpaceProperties.Create(Self);
{$ENDIF}
end;

destructor TShellShellNameSpace.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TShellShellNameSpace.GetServerProperties: TShellShellNameSpaceProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TShellShellNameSpace.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1: if Assigned(FOnFavoritesSelectionChange) then
         FOnFavoritesSelectionChange(Self,
                                     Params[0] {Integer},
                                     Params[1] {Integer},
                                     Params[2] {const WideString},
                                     Params[3] {const WideString},
                                     Params[4] {Integer},
                                     Params[5] {const WideString},
                                     Params[6] {Integer});
    2: if Assigned(FOnSelectionChange) then
         FOnSelectionChange(Self);
    3: if Assigned(FOnDoubleClick) then
         FOnDoubleClick(Self);
    4: if Assigned(FOnInitialized) then
         FOnInitialized(Self);
  end; {case DispID}
end;

function TShellShellNameSpace.Get_SubscriptionsEnabled: WordBool;
begin
    Result := DefaultInterface.SubscriptionsEnabled;
end;

function TShellShellNameSpace.Get_EnumOptions: Integer;
begin
    Result := DefaultInterface.EnumOptions;
end;

procedure TShellShellNameSpace.Set_EnumOptions(pgrfEnumFlags: Integer);
begin
  DefaultInterface.Set_EnumOptions(pgrfEnumFlags);
end;

function TShellShellNameSpace.Get_SelectedItem: IDispatch;
begin
    Result := DefaultInterface.SelectedItem;
end;

procedure TShellShellNameSpace.Set_SelectedItem(const pItem: IDispatch);
begin
  DefaultInterface.Set_SelectedItem(pItem);
end;

function TShellShellNameSpace.Get_Root: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Root;
end;

procedure TShellShellNameSpace.Set_Root(pvar: OleVariant);
begin
  DefaultInterface.Set_Root(pvar);
end;

function TShellShellNameSpace.Get_Depth: SYSINT;
begin
    Result := DefaultInterface.Depth;
end;

procedure TShellShellNameSpace.Set_Depth(piDepth: SYSINT);
begin
  DefaultInterface.Set_Depth(piDepth);
end;

function TShellShellNameSpace.Get_Mode: SYSUINT;
begin
    Result := DefaultInterface.Mode;
end;

procedure TShellShellNameSpace.Set_Mode(puMode: SYSUINT);
begin
  DefaultInterface.Set_Mode(puMode);
end;

function TShellShellNameSpace.Get_Flags: LongWord;
begin
    Result := DefaultInterface.Flags;
end;

procedure TShellShellNameSpace.Set_Flags(pdwFlags: LongWord);
begin
  DefaultInterface.Set_Flags(pdwFlags);
end;

procedure TShellShellNameSpace.Set_TVFlags(dwFlags: LongWord);
begin
  DefaultInterface.Set_TVFlags(dwFlags);
end;

function TShellShellNameSpace.Get_TVFlags: LongWord;
begin
    Result := DefaultInterface.TVFlags;
end;

function TShellShellNameSpace.Get_Columns: WideString;
begin
    Result := DefaultInterface.Columns;
end;

procedure TShellShellNameSpace.Set_Columns(const bstrColumns: WideString);
  { Warning: The property Columns has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Columns := bstrColumns;
end;

function TShellShellNameSpace.Get_CountViewTypes: SYSINT;
begin
    Result := DefaultInterface.CountViewTypes;
end;

procedure TShellShellNameSpace.MoveSelectionUp;
begin
  DefaultInterface.MoveSelectionUp;
end;

procedure TShellShellNameSpace.MoveSelectionDown;
begin
  DefaultInterface.MoveSelectionDown;
end;

procedure TShellShellNameSpace.ResetSort;
begin
  DefaultInterface.ResetSort;
end;

procedure TShellShellNameSpace.NewFolder;
begin
  DefaultInterface.NewFolder;
end;

procedure TShellShellNameSpace.Synchronize;
begin
  DefaultInterface.Synchronize;
end;

procedure TShellShellNameSpace.Import;
begin
  DefaultInterface.Import;
end;

procedure TShellShellNameSpace.Export;
begin
  DefaultInterface.Export;
end;

procedure TShellShellNameSpace.InvokeContextMenuCommand(const strCommand: WideString);
begin
  DefaultInterface.InvokeContextMenuCommand(strCommand);
end;

procedure TShellShellNameSpace.MoveSelectionTo;
begin
  DefaultInterface.MoveSelectionTo;
end;

function TShellShellNameSpace.CreateSubscriptionForSelection: WordBool;
begin
  Result := DefaultInterface.CreateSubscriptionForSelection;
end;

function TShellShellNameSpace.DeleteSubscriptionForSelection: WordBool;
begin
  Result := DefaultInterface.DeleteSubscriptionForSelection;
end;

procedure TShellShellNameSpace.SetRoot(const bstrFullPath: WideString);
begin
  DefaultInterface.SetRoot(bstrFullPath);
end;

procedure TShellShellNameSpace.SetViewType(iType: SYSINT);
begin
  DefaultInterface.SetViewType(iType);
end;

function TShellShellNameSpace.SelectedItems: IDispatch;
begin
  Result := DefaultInterface.SelectedItems;
end;

procedure TShellShellNameSpace.Expand(var_: OleVariant; iDepth: SYSINT);
begin
  DefaultInterface.Expand(var_, iDepth);
end;

procedure TShellShellNameSpace.UnselectAll;
begin
  DefaultInterface.UnselectAll;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TShellShellNameSpaceProperties.Create(AServer: TShellShellNameSpace);
begin
  inherited Create;
  FServer := AServer;
end;

function TShellShellNameSpaceProperties.GetDefaultInterface: IShellNameSpace;
begin
  Result := FServer.DefaultInterface;
end;

function TShellShellNameSpaceProperties.Get_SubscriptionsEnabled: WordBool;
begin
    Result := DefaultInterface.SubscriptionsEnabled;
end;

function TShellShellNameSpaceProperties.Get_EnumOptions: Integer;
begin
    Result := DefaultInterface.EnumOptions;
end;

procedure TShellShellNameSpaceProperties.Set_EnumOptions(pgrfEnumFlags: Integer);
begin
  DefaultInterface.Set_EnumOptions(pgrfEnumFlags);
end;

function TShellShellNameSpaceProperties.Get_SelectedItem: IDispatch;
begin
    Result := DefaultInterface.SelectedItem;
end;

procedure TShellShellNameSpaceProperties.Set_SelectedItem(const pItem: IDispatch);
begin
  DefaultInterface.Set_SelectedItem(pItem);
end;

function TShellShellNameSpaceProperties.Get_Root: OleVariant;
var
  InterfaceVariant : OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  Result := InterfaceVariant.Root;
end;

procedure TShellShellNameSpaceProperties.Set_Root(pvar: OleVariant);
begin
  DefaultInterface.Set_Root(pvar);
end;

function TShellShellNameSpaceProperties.Get_Depth: SYSINT;
begin
    Result := DefaultInterface.Depth;
end;

procedure TShellShellNameSpaceProperties.Set_Depth(piDepth: SYSINT);
begin
  DefaultInterface.Set_Depth(piDepth);
end;

function TShellShellNameSpaceProperties.Get_Mode: SYSUINT;
begin
    Result := DefaultInterface.Mode;
end;

procedure TShellShellNameSpaceProperties.Set_Mode(puMode: SYSUINT);
begin
  DefaultInterface.Set_Mode(puMode);
end;

function TShellShellNameSpaceProperties.Get_Flags: LongWord;
begin
    Result := DefaultInterface.Flags;
end;

procedure TShellShellNameSpaceProperties.Set_Flags(pdwFlags: LongWord);
begin
  DefaultInterface.Set_Flags(pdwFlags);
end;

procedure TShellShellNameSpaceProperties.Set_TVFlags(dwFlags: LongWord);
begin
  DefaultInterface.Set_TVFlags(dwFlags);
end;

function TShellShellNameSpaceProperties.Get_TVFlags: LongWord;
begin
    Result := DefaultInterface.TVFlags;
end;

function TShellShellNameSpaceProperties.Get_Columns: WideString;
begin
    Result := DefaultInterface.Columns;
end;

procedure TShellShellNameSpaceProperties.Set_Columns(const bstrColumns: WideString);
  { Warning: The property Columns has a setter and a getter whose
    types do not match. Delphi was unable to generate a property of
    this sort and so is using a Variant as a passthrough. }
var
  InterfaceVariant: OleVariant;
begin
  InterfaceVariant := DefaultInterface;
  InterfaceVariant.Columns := bstrColumns;
end;

function TShellShellNameSpaceProperties.Get_CountViewTypes: SYSINT;
begin
    Result := DefaultInterface.CountViewTypes;
end;

{$ENDIF}

class function CoCppCScriptErrorList.Create: IScriptErrorList;
begin
  Result := CreateComObject(CLASS_CppCScriptErrorList) as IScriptErrorList;
end;

class function CoCppCScriptErrorList.CreateRemote(const MachineName: string): IScriptErrorList;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_CppCScriptErrorList) as IScriptErrorList;
end;

procedure Register;
begin
  RegisterComponents(dtlOcxPage, [TCppWebBrowser]);
  RegisterComponents(dtlServerPage, [TCppInternetExplorer, TCppShellWindows, TCppShellUIHelper, TShellFavoritesNameSpace, 
    TShellShellNameSpace]);
end;

end.
