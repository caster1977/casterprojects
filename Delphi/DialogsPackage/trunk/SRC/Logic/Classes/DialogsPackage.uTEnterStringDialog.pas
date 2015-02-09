unit DialogsPackage.uTEnterStringDialog;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  DialogsPackage.uTEnterStringForm,
  Vcl.Graphics;

type
  TEnterStringDialog = class(TComponent)
  strict private
    FPosition: TPosition;
    function GetPosition: TPosition;
    procedure SetPosition(const AValue: TPosition);
  published
    property Position: TPosition read GetPosition write SetPosition default poDesktopCenter;

  strict private
    FTitle: string;
    function GetTitle: string;
    procedure SetTitle(const AValue: string);
  published
    property Title: string read GetTitle write SetTitle nodefault;

  strict private
    FPrompt: string;
    function GetPrompt: string;
    procedure SetPrompt(const AValue: string);
  published
    property Prompt: string read GetPrompt write SetPrompt nodefault;

  strict private
    FHint: string;
    function GetHint: string;
    procedure SetHint(const AValue: string);
  published
    property Hint: string read GetHint write SetHint nodefault;

  strict private
    FValue: string;
    function GetValue: string;
    procedure SetValue(const AValue: string);
  published
    property Value: string read GetValue write SetValue nodefault;

  strict private
    FMaxLength: Integer;
    function GetMaxLength: Integer;
    procedure SetMaxLength(const AValue: Integer);
  published
    property MaxLength: Integer read GetMaxLength write SetMaxLength default 0;

  strict private
    FNumeric: Boolean;
    function GetNumeric: Boolean;
    procedure SetNumeric(const AValue: Boolean);
  published
    property Numeric: Boolean read GetNumeric write SetNumeric default False;

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
    FForm: TEnterStringForm;
    function GetForm: TEnterStringForm;
    procedure SetForm(const AValue: TEnterStringForm);
  strict protected
    property Form: TEnterStringForm read GetForm write SetForm nodefault;

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

constructor TEnterStringDialog.Create(AOwner: TComponent);
begin
  inherited;
  FPosition := poDesktopCenter;
  FTitle := EmptyStr;
  FPrompt := EmptyStr;
  FHint := EmptyStr;
  FValue := EmptyStr;
  FMaxLength := 0;
  FIcon := TIcon.Create;
  FShowHelpButton := False;
  FNumeric := False;
end;

function TEnterStringDialog.GetPrompt: string;
begin
  Result := FPrompt;
end;

function TEnterStringDialog.GetPosition: TPosition;
begin
  Result := FPosition;
end;

function TEnterStringDialog.GetShowHelpButton: Boolean;
begin
  Result := FShowHelpButton;
end;

function TEnterStringDialog.GetTitle: string;
begin
  Result := FTitle;
end;

function TEnterStringDialog.GetValue: string;
begin
  Result := FValue;
end;

destructor TEnterStringDialog.Destroy;
begin
  if Assigned(FForm) then
  begin
    FreeAndNil(FIcon);
  end;
  Form := nil;
  inherited;
end;

function TEnterStringDialog.GetForm: TEnterStringForm;
begin
  Result := FForm;
end;

function TEnterStringDialog.GetHint: string;
begin
  Result := FHint;
end;

function TEnterStringDialog.GetIcon: TIcon;
begin
  Result := FIcon;
end;

function TEnterStringDialog.GetMaxLength: Integer;
begin
  Result := FMaxLength;
end;

function TEnterStringDialog.GetNumeric: Boolean;
begin
  Result := FNumeric;
end;

procedure TEnterStringDialog.SetValue(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FValue <> s then
  begin
    FValue := s;
  end;
end;

procedure TEnterStringDialog.SetForm(const AValue: TEnterStringForm);
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

procedure TEnterStringDialog.SetHint(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FHint <> s then
  begin
    FHint := s;
  end;
end;

procedure TEnterStringDialog.SetIcon(const AValue: TIcon);
begin
  Icon.Assign(AValue);
end;

procedure TEnterStringDialog.SetMaxLength(const AValue: Integer);
begin
  if FMaxLength <> AValue then
  begin
    FMaxLength := AValue;
  end;
end;

procedure TEnterStringDialog.SetNumeric(const AValue: Boolean);
begin
  if FNumeric <> AValue then
  begin
    FNumeric := AValue;
  end;
end;

procedure TEnterStringDialog.SetPrompt(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FPrompt <> s then
  begin
    FPrompt := s;
  end;
end;

procedure TEnterStringDialog.SetPosition(const AValue: TPosition);
begin
  if FPosition <> AValue then
  begin
    FPosition := AValue;
  end;
end;

procedure TEnterStringDialog.SetShowHelpButton(const AValue: Boolean);
begin
  if FShowHelpButton <> AValue then
  begin
    FShowHelpButton := AValue;
  end;
end;

procedure TEnterStringDialog.SetTitle(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FTitle <> s then
  begin
    FTitle := s;
  end;
end;

function TEnterStringDialog.Execute: Boolean;
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

  Form := TEnterStringForm.Create(Self, Title, Prompt, Value, Hint, Icon, MaxLength, Numeric, ShowHelpButton);
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
      Value := Form.Value;
    end;
  finally
    Form := nil;
  end;
end;

procedure Register;
begin
  RegisterComponents('CasterComponents', [TEnterStringDialog]);
end;

end.
