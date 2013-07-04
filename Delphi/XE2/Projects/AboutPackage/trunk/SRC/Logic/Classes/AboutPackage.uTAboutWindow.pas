unit AboutPackage.uTAboutWindow;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms;

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
  public
    constructor Create(AOwner: TComponent); override;
    procedure Show(const ASplash: Boolean = False);
  end;

procedure Register;

implementation

uses
  Vcl.Dialogs,
  System.SysUtils,
  AboutPackage.uTAboutForm;

constructor TAboutWindow.Create(AOwner: TComponent);
begin
  inherited;
  FPosition := poScreenCenter;
  FEMail := 'vlad_dracula@tut.by';
end;

function TAboutWindow.GetPosition: TPosition;
begin
  Result := FPosition;
end;

function TAboutWindow.GetEMail: string;
begin
  Result := FEMail;
end;

procedure TAboutWindow.SetEMail(const AValue: string);
begin
  if FEMail <> AValue then
  begin
    FEMail := AValue;
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
  form: TAboutForm;
begin
  form := TAboutForm.Create(Self, ASplash, EMail);
  try
    if Form.Position <> Position then
    begin
      Form.Position := Position;
    end;
    form.ShowModal;
  finally
    FreeAndNil(form);
  end;
end;

procedure Register;
begin
  RegisterComponents('CasterComponents', [TAboutWindow]);
end;

end.
