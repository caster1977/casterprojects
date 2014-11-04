{ ------------------------------------------------------------------------------
  Unit     : fisSysMenu.pas
  Purpose  : Adds menu items to the system menu for a form
  Copyright: © First Internet Software House 2000, http://www.fishouse.com
  Status   : Shareware
  Contact  : support@fishouse.com
  ------------------------------------------------------------------------------

  History:

  Date                By      Comments
  ----                ----    --------
  11 May 2000         ME      Created, converted from C++ Builder

}
unit CastersPackage.fisSysMenu;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  forms,
  menus;

const
  TAB = #9;

type
  TWndFarProc = function: integer; stdcall;

  TfisSysMenu = class(TComponent)
  private
    FEnabled: boolean;
    FMenu: TPopupmenu;
    prOwner: TForm;
    prOldFormWndProc: TWndMethod;
  protected
    procedure SetEnabled(const Value: boolean);
    procedure SetMenu(const Value: TPopupmenu);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure NewFormWindowProc(var message: TMessage);
    procedure CreateMenuItems;
    procedure DeleteMenuItems;
    procedure CallClickHandler(aMenu: TMenuitem; aCommand: integer);
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Enabled: boolean read FEnabled write SetEnabled default true;
    property Menu: TPopupmenu read FMenu write SetMenu;
  end;

var
  prOldAppWndProc: TWndFarProc = nil;
  prInstanceCount: integer = 0;

procedure register;

implementation

{$R *.dcr}

procedure register;
begin
  RegisterComponents('CasterComponents', [TfisSysMenu]);
end;

// The new window procedure and helper function are global because passing
// a class function pointer in to an API callback routine does not work...

function FindSysMenu(aOwner: TComponent; aIgnore: TfisSysMenu): TfisSysMenu;
var
  lCount: integer;
begin
  for lCount := 0 to aOwner.ComponentCount - 1 do
  begin
    if aOwner.Components[lCount].InheritsFrom(TfisSysMenu) then
    begin
      if aOwner.Components[lCount] <> aIgnore then
      begin
        result := TfisSysMenu(aOwner.Components[lCount]);
        exit;
      end;
    end; // if owner
  end; // for componentcount
  result := nil;
end;

// New application window proc
function NewAppWndProc(wnd: HWND; uMsg: UINT; aWParam: WPARAM; aLParam: LPARAM): LRESULT; stdcall;
var
  lSelf: TfisSysMenu;
  lKeyMsg: TWMKEY;
begin
  case uMsg of
    CM_APPKEYDOWN:
      begin
        lSelf := FindSysMenu(Screen.ActiveForm, nil);
        if (assigned(lSelf) and assigned(lSelf.FMenu) and (lSelf.FEnabled)) then
        begin
          lKeyMsg.Msg := uMsg;
          lKeyMsg.CharCode := aWParam;
          lKeyMsg.KeyData := aLParam;
          lSelf.FMenu.IsShortCut(lKeyMsg);
          lSelf.CreateMenuItems;
        end;
      end;
  end;
  result := CallWindowProc(@prOldAppWndProc, wnd, uMsg, aWParam, aLParam);
end;

{ TfisSysMenu }

constructor TfisSysMenu.Create(aOwner: TComponent);
begin
  inherited;

  if FindSysMenu(aOwner, self) <> nil then
    raise EComponentError.Create('Only one instance allowed');

  FEnabled := true;
  FMenu := nil;
  prOwner := TForm(aOwner);
  if not(csDesigning in ComponentState) then
  begin
    prOldFormWndProc := prOwner.WindowProc;
    prOwner.WindowProc := NewFormWindowProc;
    inc(prInstanceCount);
    if prInstanceCount = 1 then
      prOldAppWndProc := TWndFarProc(SetWindowLong(Application.Handle, GWL_WNDPROC,
        Longint(@NewAppWndProc)));
  end;
end;

destructor TfisSysMenu.Destroy;
begin
  if not(csDesigning in ComponentState) then
  begin
    if assigned(Owner) then
      prOwner.WindowProc := prOldFormWndProc;
    dec(prInstanceCount);
    if prInstanceCount = 0 then
      SetWindowLong(Application.Handle, GWL_WNDPROC, Longint(@prOldAppWndProc));
  end;
  DeleteMenuItems;
  inherited;
end;

procedure TfisSysMenu.SetEnabled(const Value: boolean);
begin
  FEnabled := Value;
  if FEnabled then
    CreateMenuItems
  else
    DeleteMenuItems;
end;

procedure TfisSysMenu.SetMenu(const Value: TPopupmenu);
begin
  FMenu := Value;
  if assigned(FMenu) then
  begin
    FMenu.FreeNotification(self);
    if FEnabled then
      CreateMenuItems;
  end
  else
    DeleteMenuItems;
end;

procedure TfisSysMenu.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) and (AComponent = FMenu) and (not(csDestroying in ComponentState)) then
  begin
    FMenu := nil;
    DeleteMenuItems;
  end;
end;

procedure TfisSysMenu.NewFormWindowProc(var message: TMessage);
begin
  case message.Msg of
    WM_SYSCOMMAND:
      if (assigned(FMenu)) and (FEnabled) then
        CallClickHandler(FMenu.Items, message.WPARAM);
    WM_DESTROY:
      DeleteMenuItems;
  end;
  prOldFormWndProc(message);
end;

procedure TfisSysMenu.CallClickHandler(aMenu: TMenuitem; aCommand: integer);
var
  lCount: integer;
begin
  for lCount := 0 to aMenu.count - 1 do
  begin
    if aMenu[lCount].Command = aCommand then
    begin
      if assigned(aMenu[lCount].OnClick) then
      begin
        aMenu.Items[lCount].OnClick(aMenu.Items[lCount]);
        CreateMenuItems;
      end; // if click handler assigned
      break;
    end; // if clicked menu = our menu item
    // recurse for submenus
    if aMenu.Items[lCount].count <> 0 then
      CallClickHandler(aMenu.Items[lCount], aCommand);
  end; // for lcount = 0 to amenu-1
end;

procedure TfisSysMenu.CreateMenuItems;
var
  SysMenu: HMENU;
  lCount, lFlags: integer;
  lCaption: string;
begin
  DeleteMenuItems;
  if (assigned(Owner) and assigned(FMenu)) then
  begin
    SysMenu := GetsystemMenu(prOwner.Handle, false);
    AppendMenu(SysMenu, MF_SEPARATOR, $E000, '');
    for lCount := 0 to FMenu.Items.count - 1 do
    begin
      lFlags := MF_STRING;
      if FMenu.Items.Items[lCount].Caption = '-' then
        lFlags := MF_SEPARATOR;
      if FMenu.Items.Items[lCount].Checked then
      begin
        lFlags := lFlags or MF_CHECKED;
        if FMenu.Items.Items[lCount].RadioItem then
          lFlags := lFlags or MFT_RADIOCHECK;
      end;
      if not FMenu.Items.Items[lCount].Enabled then
        lFlags := lFlags or MF_GRAYED;
      if FMenu.Items.Items[lCount].break = mbBarBreak then
        lFlags := lFlags or MF_MENUBARBREAK;
      if FMenu.Items.Items[lCount].break = mbBreak then
        lFlags := lFlags or MF_MENUBREAK;
      lCaption := FMenu.Items.Items[lCount].Caption;
      if FMenu.Items.Items[lCount].ShortCut <> 0 then
      begin
        lCaption := lCaption + TAB + ShortCutToText(Menu.Items.Items[lCount].ShortCut);
      end;
      if FMenu.Items.Items[lCount].count <> 0 then
        AppendMenu(SysMenu, MF_POPUP, integer(FMenu.Items.Items[lCount].Handle),
          Pchar(FMenu.Items.Items[lCount].Caption))
      else
        AppendMenu(SysMenu, lFlags, FMenu.Items.Items[lCount].Command, Pchar(lCaption));
    end;
  end;
end;

procedure TfisSysMenu.DeleteMenuItems;
var
  SysMenu: HMENU;
  Ownerhandle: HWND;
begin
  // need to check for FMenu as well because D5 causes notification to be
  // run on the destroy which causes this routine to be run when there is
  // no system menu to get hold of. notifications unassigns FMenu so we check
  // it here.
  if assigned(Owner) then
  begin
    Ownerhandle := prOwner.Handle;
    SysMenu := GetsystemMenu(Ownerhandle, false);
    // remove until no more left
    while RemoveMenu(SysMenu, 7, MF_BYPOSITION) do
    begin
    end;
  end;
end;

end.
