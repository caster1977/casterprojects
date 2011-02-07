{$DEFINE _WIN32_IE_600}
unit VDTrayIcon;

interface

uses
  Classes, Windows, Messages, Graphics, Controls;
type
  PNotifyIconDataExA = ^TNotifyIconDataExA;
  PNotifyIconDataExW = ^TNotifyIconDataExW;
  PNotifyIconDataEx = PNotifyIconDataExA;
  _NOTIFYICONDATAEXA = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..127] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array [0..255] of AnsiChar;
    uTimeoutOrVersion: UINT;
    szInfoTitle: array [0..63] of AnsiChar;
    dwInfoFlags: DWORD;
{$IFDEF _WIN32_IE_600}
    guidItem: TGUID;
{$ENDIF}
  end;
  _NOTIFYICONDATAEXW = record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..127] of WideChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array [0..255] of WideChar;
    uTimeoutOrVersion: UINT;
    szInfoTitle: array [0..63] of WideChar;
    dwInfoFlags: DWORD;
{$IFDEF _WIN32_IE_600}
    guidItem: TGUID;
{$ENDIF}
  end;
  _NOTIFYICONDATAEX = _NOTIFYICONDATAEXA;
  TNotifyIconDataExA = _NOTIFYICONDATAEXA;
  TNotifyIconDataExW = _NOTIFYICONDATAEXW;
  TNotifyIconDataEx = TNotifyIconDataExA;
  NOTIFYICONDATAEXA = _NOTIFYICONDATAEXA;
  NOTIFYICONDATAEXW = _NOTIFYICONDATAEXW;
  NOTIFYICONDATAEX = NOTIFYICONDATAEXA;
const
  WM_NOTIFYTRAYICON = WM_USER + $1977;
  WM_NOTIFYTRAYICONSHOW = WM_NOTIFYTRAYICON + 1;
  WM_NOTIFYTRAYICONHIDE = WM_NOTIFYTRAYICON + 2;

  NOTIFYICON_VERSION  = 3;

  NIM_ADD         = $00000000;
  NIM_MODIFY      = $00000001;
  NIM_DELETE      = $00000002;

  NIN_SELECT      = (WM_USER + 0);
  NINF_KEY        = $00000001;
  NIN_KEYSELECT   = NINF_KEY or NIN_SELECT;

  NIN_BALLOONSHOW = (WM_USER + 2);
  NIN_BALLOONHIDE = (WM_USER + 3);
  NIN_BALLOONTIMEOUT = (WM_USER + 4);
  NIN_BALLOONUSERCLICK = (WM_USER + 5);

  NIM_SETFOCUS    = $00000003;
  NIM_SETVERSION  = $00000004;

  NIF_MESSAGE     = $00000001;
  NIF_ICON        = $00000002;
  NIF_TIP         = $00000004;
  NIF_STATE       = $00000008;
  NIF_INFO        = $00000010;
  NIF_GUID        = $00000020;

  NIS_HIDDEN      = $00000001;
  NIS_SHAREDICON  = $00000002;

  NIIF_NONE       = $00000000;
  NIIF_INFO       = $00000001;
  NIIF_WARNING    = $00000002;
  NIIF_ERROR      = $00000003;
  NIIF_ICON_MASK  = $0000000F;
  NIIF_NOSOUND    = $00000010;

function Shell_NotifyIcon(dwMessage: DWORD; lpData: PNotifyIconDataEx): BOOL; stdcall;
function Shell_NotifyIconA(dwMessage: DWORD; lpData: PNotifyIconDataExA): BOOL; stdcall;
function Shell_NotifyIconW(dwMessage: DWORD; lpData: PNotifyIconDataExW): BOOL; stdcall;

type
  TBalloonStyle = (bsNone, bsInfo, bsWarning, bsError);
  TVDTrayIcon = class(TComponent)
  private
    IconDataEx: TNotifyIconDataEx;
    FVisible: boolean;
    FIcon: TIcon;
    FTip: string;
    FInfo: string;
    FInfoTitle: string;
    FWindowHandle: HWND;
    FTimeOut: LongWord;
    FBalloonStyle: TBalloonStyle;
    FOnClick: TNotifyEvent;
    FOnHide: TNotifyEvent;
    FOnShow: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnRightClick: TMouseEvent;
    FOnBalloonShow: TNotifyEvent;
    FOnBalloonHide: TNotifyEvent;
    FOnBalloonTimeOut: TNotifyEvent;
    FOnBalloonClick: TNotifyEvent;
    procedure SetVisible(const Value: Boolean);
    procedure SetTimeOut(const Value: LongWord);
    procedure SetTip(const Value: string);
    procedure SetIcon(const Value: TIcon);
    procedure WndProc(var msg : TMessage);
  protected
    IconExists: boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddIcon: boolean;
    function ModifyIcon: boolean;
    function DeleteIcon: boolean;
    function ShowBalloon: boolean;
    function SetVersion: boolean;
  published
    property Visible: Boolean read FVisible write SetVisible stored True default True;
    property Icon: TIcon read FIcon write SetIcon;
    property Tip: string read FTip write SetTip;
    property Info: string read FInfo write FInfo;
    property InfoTitle: string read FInfoTitle write FInfoTitle;
    property TimeOut: LongWord read FTimeOut write SetTimeOut default 10000;
    property BalloonStyle: TBalloonStyle read FBalloonStyle write FBalloonStyle default bsNone;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnHide: TNotifyEvent read FOnHide write FOnHide;
    property OnShow: TNotifyEvent read FOnShow write FOnShow;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnRightClick: TMouseEvent read FOnRightClick write FOnRightClick;
    property OnBalloonShow: TNotifyEvent read FOnBalloonShow write FOnBalloonShow;
    property OnBalloonHide: TNotifyEvent read FOnBalloonHide write FOnBalloonHide;
    property OnBalloonTimeOut: TNotifyEvent read FOnBalloonTimeOut write FOnBalloonTimeOut;
    property OnBalloonClick: TNotifyEvent read FOnBalloonClick write FOnBalloonClick;
  end;

procedure Register;

implementation
uses
  SysUtils;

function Shell_NotifyIcon; external 'shell32.dll' name 'Shell_NotifyIconA';
function Shell_NotifyIconA; external 'shell32.dll' name 'Shell_NotifyIconA';
function Shell_NotifyIconW; external 'shell32.dll' name 'Shell_NotifyIconW';

procedure Register;
begin
  RegisterComponents('MyComponents', [TVDTrayIcon]);
end;

{ TVDTrayIcon }

constructor TVDTrayIcon.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FWindowHandle:=AllocateHWnd(WndProc);
  FIcon:=TIcon.Create;
  FTimeOut:=10000;
  IconExists:=False;
  FVisible:=True;
end;

destructor TVDTrayIcon.Destroy;
begin
  FIcon.Free;
  DeAllocateHWnd(FWindowHandle);
  inherited Destroy;
end;

procedure TVDTrayIcon.WndProc(var Msg : TMessage);
var
  MouseCoord: Tpoint;
begin
  case Msg.Msg of
    WM_NOTIFYTRAYICON:
      begin
        case Msg.LParam of
          WM_LBUTTONDBLCLK:
            begin
              if Assigned(FOnDblClick) then
                FOnDblClick(Self);
            end;
          WM_LBUTTONUP:
            begin
              if Assigned(FOnClick) then
                FOnClick(Self);
            end;
          WM_RBUTTONUP:
            begin
              if Assigned(FOnRightClick) then
                begin
                  GetCursorPos(MouseCoord);
                  FOnRightClick(Self,mbRight,[],MouseCoord.X,MouseCoord.Y);
                end;
            end;
          NIN_BALLOONSHOW:
            {Sent when the balloon is shown}
            begin
              if Assigned(FOnBalloonShow) then
                FOnBalloonShow(Self);
            end;
          NIN_BALLOONHIDE:
            {Sent when the balloon disappears? When the icon is deleted,
            for example. This message is not sent if the balloon is dismissed because of
            a timeout or mouse click by the user. }
            begin
              if Assigned(FOnBalloonHide) then
                FOnBalloonHide(Self);
            end;
          NIN_BALLOONTIMEOUT:
            {Sent when the balloon is dismissed because of a timeout.}
            begin
              if Assigned(FOnBalloonTimeOut) then
                FOnBalloonTimeOut(Self);
            end;
          NIN_BALLOONUSERCLICK:
            {Sent when the balloon is dismissed because the user clicked the mouse.
            Note: in XP there's Close button on he balloon tips, when click the button,
            send NIN_BALLOONTIMEOUT message actually.}
            begin
              if Assigned(FOnBalloonClick) then
                FOnBalloonClick(Self);
            end;
        end;
      end;
    WM_NOTIFYTRAYICONSHOW:
      begin
        if Assigned(FOnShow) then
          FOnShow(Self);
      end;
    WM_NOTIFYTRAYICONHIDE:
      begin
        if Assigned(FOnHide) then
          FOnHide(Self);
      end;
    end;
  inherited;
end;

procedure TVDTrayIcon.SetIcon(const Value: TIcon);
begin
  if Value <> FIcon then
    begin
      FIcon.Assign(Value);
      if IconExists then
        ModifyIcon;
    end;
end;

procedure TVDTrayIcon.SetTimeOut(const Value: LongWord);
begin
  if Value>30000 then
    FTimeOut:=30000
  else
    if Value<10000 then
      FTimeOut:=10000
    else FTimeOut:=Value;
end;

function TVDTrayIcon.DeleteIcon: boolean;
var
  b: boolean;
begin
  b:=Shell_NotifyIcon(NIM_DELETE,@IconDataEx);
  IconExists:=False;
  Result:=b;
end;

procedure TVDTrayIcon.SetVisible(const Value: Boolean);
begin
  FVisible:=Value;
  if IconExists then
    begin
      ModifyIcon;
      if FVisible then
        SendMessage(FWindowHandle,WM_NOTIFYTRAYICONSHOW,0,0)
      else
        SendMessage(FWindowHandle,WM_NOTIFYTRAYICONHIDE,0,0);
    end;
end;

procedure TVDTrayIcon.SetTip(const Value: string);
begin
  FTip:=Value;
  if IconExists then
    ModifyIcon;
end;

function TVDTrayIcon.AddIcon: boolean;
begin
  IconDataEx.cbSize:=SizeOf(IconDataEx);
  IconDataEx.Wnd:=FWindowHandle;
  IconDataEx.uID:=1;
  IconDataEx.uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP or NIF_STATE;
  IconDataEx.uCallbackMessage:=WM_NOTIFYTRAYICON;
  IconDataEx.hIcon:=FIcon.Handle;
  StrPLCopy(IconDataEx.szTip,FTip,SizeOf(IconDataEx.szTip)-1);
  IconDataEx.dwStateMask:=NIS_HIDDEN;
  IconDataEx.dwState:=(integer(not FVisible) and NIS_HIDDEN);
  IconExists:=Shell_NotifyIcon(NIM_ADD,@IconDataEx);
  Result:=IconExists;
end;

function TVDTrayIcon.ModifyIcon: boolean;
begin
  IconDataEx.cbSize:=SizeOf(IconDataEx);
  IconDataEx.Wnd:=FWindowHandle;
  IconDataEx.uID:=1;
  IconDataEx.uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP or NIF_STATE;
  IconDataEx.uCallbackMessage:=WM_NOTIFYTRAYICON;
  IconDataEx.hIcon:=FIcon.Handle;
  StrPLCopy(IconDataEx.szTip,FTip,SizeOf(IconDataEx.szTip)-1);
  IconDataEx.dwStateMask:=NIS_HIDDEN;
  IconDataEx.dwState:=(integer(not FVisible) and NIS_HIDDEN);
  Result:=Shell_NotifyIcon(NIM_MODIFY,@IconDataEx);
end;

function TVDTrayIcon.SetVersion: boolean;
begin
  IconDataEx.uTimeoutOrVersion:=NOTIFYICON_VERSION;
  Result:=Shell_NotifyIcon(NIM_SETVERSION, @IconDataEx);
end;

function TVDTrayIcon.ShowBalloon: boolean;
begin
  IconDataEx.cbSize:=SizeOf(IconDataEx);
  IconDataEx.uFlags:=NIF_INFO;
  IconDataEx.uTimeoutOrVersion:=FTimeOut;
  case FBalloonStyle of
    bsNone: IconDataEx.dwInfoFlags:=NIIF_NONE;
    bsInfo: IconDataEx.dwInfoFlags:=NIIF_INFO;
    bsWarning: IconDataEx.dwInfoFlags:=NIIF_WARNING;
    bsError: IconDataEx.dwInfoFlags:=NIIF_ERROR;
  end;
  StrPLCopy(IconDataEx.szInfo,FInfo,SizeOf(IconDataEx.szInfo)-1);
  StrPLCopy(IconDataEx.szInfoTitle,FInfoTitle,SizeOf(IconDataEx.szInfoTitle)-1);
  Result:=Shell_NotifyIcon(NIM_MODIFY,@IconDataEx);
end;

end.
