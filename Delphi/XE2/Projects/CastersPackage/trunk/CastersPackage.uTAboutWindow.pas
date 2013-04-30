unit CastersPackage.uTAboutWindow;

interface

uses
  System.Classes,
  Vcl.Controls,
  Vcl.Forms,
  CastersPackage.uICustomized;

type
  TAboutWindow = class(TComponent, ICustomized)
  strict private
    FForm: TForm;
    function GetForm: TForm;
    property Form: TForm read GetForm nodefault;
    procedure ApplyProperties;
    procedure Initialize;
    procedure Finalize;
  strict private
    FPosition: TPosition;
    function GetPosition: TPosition;
    procedure SetPosition(const AValue: TPosition);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Show;
  published
    property Position: TPosition read GetPosition write SetPosition default poScreenCenter;
  end;

procedure Register;

implementation

uses
  Vcl.Dialogs,
  System.SysUtils,
  CastersPackage.uTAboutForm;

constructor TAboutWindow.Create(AOwner: TComponent);
begin
  inherited;
  Initialize;
end;

destructor TAboutWindow.Destroy;
begin
  Finalize;
  inherited;
end;

function TAboutWindow.GetPosition: TPosition;
begin
  Result := FPosition;
end;

procedure TAboutWindow.Initialize;
begin
  FPosition := poScreenCenter;
end;

procedure TAboutWindow.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    Show;
  end;
end;

procedure TAboutWindow.Finalize;
begin
  FreeAndNil(FForm);
end;

function TAboutWindow.GetForm: TForm;
begin
  if not Assigned(FForm) then
  begin
    FForm := TAboutForm.Create(Self, True);
  end;
  Result := FForm;
end;

procedure TAboutWindow.SetPosition(const AValue: TPosition);
begin
  if FPosition <> AValue then
  begin
    FPosition := AValue;
  end;
  ApplyProperties;
end;

procedure TAboutWindow.ApplyProperties;
begin
  if Form.Position <> Position then
  begin
    Form.Position := Position;
  end;
end;

procedure TAboutWindow.Show;
begin
  Form.ShowModal;
end;

procedure Register;
begin
  RegisterComponents('CasterComponents', [TAboutWindow]);
end;

end.
