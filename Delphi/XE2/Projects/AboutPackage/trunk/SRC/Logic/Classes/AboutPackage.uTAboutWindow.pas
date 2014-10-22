unit AboutPackage.uTAboutWindow;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  AboutPackage.uTAboutForm;

type
  TAboutWindow = class(TComponent)
  strict private
    FPosition: TPosition;
    function GetPosition: TPosition;
    procedure SetPosition(const AValue: TPosition);
  published
    property Position: TPosition read GetPosition write SetPosition default poScreenCenter;

  strict private
    FEMail: string;
    function GetEMail: string;
    procedure SetEMail(const AValue: string);
  published
    property EMail: string read GetEMail write SetEMail nodefault;

  strict private
    FForm: TAboutForm;
    function GetForm: TAboutForm;
    procedure SetForm(const AValue: TAboutForm);
  strict protected
    property Form: TAboutForm read GetForm write SetForm nodefault;

  public
    constructor Create(AOwner: TComponent); override;
    procedure Show(const ASplash: Boolean = False);
    procedure Hide;
  end;

procedure Register;

implementation

uses
  Winapi.Windows,
  System.SysUtils;

constructor TAboutWindow.Create(AOwner: TComponent);
begin
  inherited;
  FPosition := poScreenCenter;
  FEMail := 'caster1977@yandex.ru';
end;

function TAboutWindow.GetPosition: TPosition;
begin
  Result := FPosition;
end;

function TAboutWindow.GetEMail: string;
begin
  Result := FEMail;
end;

function TAboutWindow.GetForm: TAboutForm;
begin
  Result := FForm;
end;

procedure TAboutWindow.SetEMail(const AValue: string);
begin
  if FEMail <> AValue then
  begin
    FEMail := AValue;
  end;
end;

procedure TAboutWindow.SetForm(const AValue: TAboutForm);
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

procedure TAboutWindow.SetPosition(const AValue: TPosition);
begin
  if FPosition <> AValue then
  begin
    FPosition := AValue;
  end;
end;

procedure TAboutWindow.Show(const ASplash: Boolean);
var
  fwi: FLASHWINFO;
begin
  if Assigned(Form) then
  begin
    SetForegroundWindow(Form.Handle);

    fwi.cbSize := sizeof(FLASHWINFO);
    fwi.HWND := Form.Handle;
    fwi.dwFlags := FLASHW_TRAY or FLASHW_TIMERNOFG;
    fwi.uCount := 0;
    fwi.dwTimeout := 0;
    FlashWindowEx(fwi);
    Exit;
  end;

  Form := TAboutForm.Create(Self, ASplash, EMail);
  if not Assigned(Form) then
  begin
    Exit;
  end;

  try
    if Form.Position <> Position then
    begin
      Form.Position := Position;
    end;
    Form.ShowModal;
  finally
    Form := nil;
  end;
end;

procedure TAboutWindow.Hide;
begin
  if not Assigned(Form) then
  begin
    Exit;
  end;

  if not Form.Visible then
  begin
    Exit;
  end;

  Form.ModalResult := mrOk;
end;

procedure Register;
begin
  RegisterComponents('CasterComponents', [TAboutWindow]);
end;

end.
