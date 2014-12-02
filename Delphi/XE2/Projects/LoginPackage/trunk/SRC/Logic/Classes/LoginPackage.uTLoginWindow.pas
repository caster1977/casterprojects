unit LoginPackage.uTLoginWindow;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  LoginPackage.uTLoginForm,
  Vcl.Graphics;

type
  TLoginWindow = class(TComponent)
  strict private
    FPosition: TPosition;
    function GetPosition: TPosition;
    procedure SetPosition(const AValue: TPosition);
  published
    property Position: TPosition read GetPosition write SetPosition default poDesktopCenter;

  strict private
    FLogin: string;
    function GetLogin: string;
    procedure SetLogin(const AValue: string);
  published
    property Login: string read GetLogin write SetLogin nodefault;

  strict private
    FPassword: string;
    function GetPassword: string;
    procedure SetPassword(const AValue: string);
  published
    property Password: string read GetPassword write SetPassword nodefault;

  strict private
    FTitle: string;
    function GetTitle: string;
    procedure SetTitle(const AValue: string);
  published
    property Title: string read GetTitle write SetTitle nodefault;

  strict private
    FIcon: TIcon;
    function GetIcon: TIcon;
    procedure SetIcon(const AValue: TIcon);
  published
    property Icon: TIcon read GetIcon write SetIcon nodefault;

  strict private
    FShowHelpButton: Boolean;
    function GetShowHelpButton: Boolean;
    procedure SetShowHelpButton(const AValue: Boolean);
  published
    property ShowHelpButton: Boolean read GetShowHelpButton write SetShowHelpButton default False;

  strict private
    FForm: TLoginForm;
    function GetForm: TLoginForm;
    procedure SetForm(const AValue: TLoginForm);
  strict protected
    property Form: TLoginForm read GetForm write SetForm nodefault;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Execute: Boolean;
  end;

procedure Register;

implementation

uses
  Winapi.Windows,
  System.SysUtils;

constructor TLoginWindow.Create(AOwner: TComponent);
begin
  inherited;
  FPosition := poDesktopCenter;
  FLogin := EmptyStr;
  FPassword := EmptyStr;
  FTitle := EmptyStr;
  FIcon := TIcon.Create;
  FShowHelpButton := False;
end;

function TLoginWindow.GetPassword: string;
begin
  Result := FPassword;
end;

function TLoginWindow.GetPosition: TPosition;
begin
  Result := FPosition;
end;

function TLoginWindow.GetShowHelpButton: Boolean;
begin
  Result := FShowHelpButton;
end;

function TLoginWindow.GetTitle: string;
begin
  Result := FTitle;
end;

function TLoginWindow.GetLogin: string;
begin
  Result := FLogin;
end;

destructor TLoginWindow.Destroy;
begin
  if Assigned(FForm) then
  begin
    FreeAndNil(FIcon);
  end;
  Form := nil;
  inherited;
end;

function TLoginWindow.GetForm: TLoginForm;
begin
  Result := FForm;
end;

function TLoginWindow.GetIcon: TIcon;
begin
  Result := FIcon;
end;

procedure TLoginWindow.SetLogin(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FLogin <> s then
  begin
    FLogin := s;
  end;
end;

procedure TLoginWindow.SetForm(const AValue: TLoginForm);
begin
  if FForm <> AValue then
  begin
    if Assigned(FForm) then
    begin
      FreeAndNil(FForm);
    end;
    FForm := AValue;
  end;
end;

procedure TLoginWindow.SetIcon(const AValue: TIcon);
begin
  Icon.Assign(AValue);
end;

procedure TLoginWindow.SetPassword(const AValue: string);
begin
  if FPassword <> AValue then
  begin
    FPassword := AValue;
  end;
end;

procedure TLoginWindow.SetPosition(const AValue: TPosition);
begin
  if FPosition <> AValue then
  begin
    FPosition := AValue;
  end;
end;

procedure TLoginWindow.SetShowHelpButton(const AValue: Boolean);
begin
  if FShowHelpButton <> AValue then
  begin
    FShowHelpButton := AValue;
  end;
end;

procedure TLoginWindow.SetTitle(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FTitle <> s then
  begin
    FTitle := s;
  end;
end;

function TLoginWindow.Execute: Boolean;
var
  fwi: FLASHWINFO;
begin
  Result := False;

  if Assigned(Form) then
  begin
    SetForegroundWindow(Form.Handle);

    fwi.cbSize := sizeof(FLASHWINFO);
    fwi.HWND := Form.Handle;
    fwi.dwFlags := FLASHW_TRAY or FLASHW_TIMERNOFG;
    fwi.uCount := 0;
    fwi.dwTimeout := 0;
    FlashWindowEx(fwi);
    Result := True;
    Exit;
  end;

  Form := TLoginForm.Create(Self, Login, Password, Title, Icon, ShowHelpButton);
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
    end;
  finally
    Form := nil;
  end;
end;

procedure Register;
begin
  RegisterComponents('CasterComponents', [TLoginWindow]);
end;

end.
