unit LoginPackage.Logic.TLoginWindow;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Graphics,
  LoginPackage.UI.TLoginForm;

type
  TLoginWindow = class(TComponent)
  strict private
    FPosition: TPosition;
    function GetPosition(): TPosition;
    procedure SetPosition(const aValue: TPosition);
  published
    property Position: TPosition read GetPosition write SetPosition default poScreenCenter;

  strict private
    FLogin: string;
    function GetLogin(): string;
    procedure SetLogin(const aValue: string);
  published
    property Login: string read GetLogin write SetLogin nodefault;

  strict private
    FPassword: string;
    function GetPassword(): string;
    procedure SetPassword(const aValue: string);
  published
    property Password: string read GetPassword write SetPassword nodefault;

  strict private
    FWindowsAuthentification: Boolean;
    function GetWindowsAuthentification(): Boolean;
    procedure SetWindowsAuthentification(const aValue: Boolean);
  published
    property WindowsAuthentification: Boolean read GetWindowsAuthentification write SetWindowsAuthentification default True;

  strict private
    FTitle: string;
    function GetTitle(): string;
    procedure SetTitle(const aValue: string);
  published
    property Title: string read GetTitle write SetTitle nodefault;

  strict private
    FIcon: TIcon;
    function GetIcon(): TIcon;
    procedure SetIcon(const aValue: TIcon);
  published
    property Icon: TIcon read GetIcon write SetIcon nodefault;

  strict private
    FShowHelpButton: Boolean;
    function GetShowHelpButton(): Boolean;
    procedure SetShowHelpButton(const aValue: Boolean);
  published
    property ShowHelpButton: Boolean read GetShowHelpButton write SetShowHelpButton default False;

  strict private
    FForm: TLoginForm;
    function GetForm(): TLoginForm;
    procedure SetForm(const aValue: TLoginForm);
  strict protected
    property Form: TLoginForm read GetForm write SetForm nodefault;

  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy(); override;
    function Execute(): Boolean;
  end;

procedure Register();

implementation

uses
  Winapi.Windows,
  System.SysUtils;

procedure Register();
begin
  RegisterComponents('CasterComponents', [TLoginWindow]);
end;

constructor TLoginWindow.Create(aOwner: TComponent);
begin
  inherited;
  FPosition := poScreenCenter;
  FLogin := EmptyStr;
  FPassword := EmptyStr;
  FWindowsAuthentification := True;
  FTitle := EmptyStr;
  FIcon := TIcon.Create();
  FShowHelpButton := False;
end;

function TLoginWindow.GetPassword(): string;
begin
  Result := FPassword;
end;

function TLoginWindow.GetPosition(): TPosition;
begin
  Result := FPosition;
end;

function TLoginWindow.GetShowHelpButton(): Boolean;
begin
  Result := FShowHelpButton;
end;

function TLoginWindow.GetTitle(): string;
begin
  Result := FTitle;
end;

function TLoginWindow.GetWindowsAuthentification(): Boolean;
begin
  Result := FWindowsAuthentification;
end;

function TLoginWindow.GetLogin(): string;
begin
  Result := FLogin;
end;

destructor TLoginWindow.Destroy();
begin
  try
    if Assigned(FForm) then
    begin
      FreeAndNil(FIcon);
    end;
    Form := nil;
  finally
    inherited;
  end;
end;

function TLoginWindow.GetForm(): TLoginForm;
begin
  Result := FForm;
end;

function TLoginWindow.GetIcon(): TIcon;
begin
  Result := FIcon;
end;

procedure TLoginWindow.SetLogin(const aValue: string);
var
  s: string;
begin
  s := aValue.Trim();
  if FLogin <> s then
  begin
    FLogin := s;
  end;
end;

procedure TLoginWindow.SetForm(const aValue: TLoginForm);
begin
  if FForm <> aValue then
  begin
    if Assigned(FForm) then
    begin
      FreeAndNil(FForm);
    end;
    FForm := aValue;
  end;
end;

procedure TLoginWindow.SetIcon(const aValue: TIcon);
begin
  Icon.Assign(aValue);
end;

procedure TLoginWindow.SetPassword(const aValue: string);
begin
  if FPassword <> aValue then
  begin
    FPassword := aValue;
  end;
end;

procedure TLoginWindow.SetPosition(const aValue: TPosition);
begin
  if FPosition <> aValue then
  begin
    FPosition := aValue;
  end;
end;

procedure TLoginWindow.SetShowHelpButton(const aValue: Boolean);
begin
  if FShowHelpButton <> aValue then
  begin
    FShowHelpButton := aValue;
  end;
end;

procedure TLoginWindow.SetTitle(const aValue: string);
var
  s: string;
begin
  s := aValue.Trim();
  if FTitle <> s then
  begin
    FTitle := s;
  end;
end;

procedure TLoginWindow.SetWindowsAuthentification(const aValue: Boolean);
begin
  if FWindowsAuthentification <> aValue then
  begin
    FWindowsAuthentification := aValue;
  end;
end;

function TLoginWindow.Execute(): Boolean;
var
  fwi: FLASHWINFO;
begin
  Result := False;

  if Assigned(Form) then
  begin
    SetForegroundWindow(Form.Handle);

    fwi.cbSize := SizeOf(FLASHWINFO);
    fwi.HWND := Form.Handle;
    fwi.dwFlags := FLASHW_TRAY or FLASHW_TIMERNOFG;
    fwi.uCount := 0;
    fwi.dwTimeout := 0;
    FlashWindowEx(fwi);
    Exit(True);
  end;

  Form := TLoginForm.Create(Self, Login, Password, WindowsAuthentification, Title, Icon, ShowHelpButton);
  if not Assigned(Form) then
  begin
    Exit;
  end;

  try
    if Form.Position <> Position then
    begin
      Form.Position := Position;
    end;
    Result := Form.ShowModal = mrOk;
    if Result then
    begin
      Login := Form.Login;
      Password := Form.Password;
      WindowsAuthentification := Form.WindowsAuthentification;
    end;
  finally
    Form := nil;
  end;
end;

end.
