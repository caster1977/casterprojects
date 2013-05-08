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
    FFirst: Boolean;
    FForm: TForm;
    function GetForm: TForm;
    property Form: TForm read GetForm nodefault;
    procedure Initialize;
    procedure Finalize;
    procedure FreeForm;
  strict private
    FPosition: TPosition;
    function GetPosition: TPosition;
    procedure SetPosition(const AValue: TPosition);
  strict private
    FEMail: string;
    function GetEMail: string;
    procedure SetEMail(const AValue: string);
  strict private
    FShowSplash: Boolean;
    function GetShowSplash: Boolean;
    procedure SetShowSplash(const AValue: Boolean);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Show;
  published
    property Position: TPosition read GetPosition write SetPosition default poScreenCenter;
    property EMail: string read GetEMail write SetEMail nodefault;
    property ShowSplash: Boolean read GetShowSplash write SetShowSplash default True;
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

function TAboutWindow.GetShowSplash: Boolean;
begin
  Result := FShowSplash;
end;

procedure TAboutWindow.Initialize;
begin
  FFirst := True;
  FPosition := poScreenCenter;
  FEMail := 'vlad_dracula@tut.by';
end;

procedure TAboutWindow.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    Show;
    FFirst := False;
    FreeForm;
  end;
end;

procedure TAboutWindow.Finalize;
begin
  FreeForm;
end;

procedure TAboutWindow.FreeForm;
begin
  FreeAndNil(FForm);
end;

function TAboutWindow.GetEMail: string;
begin
  Result := FEMail;
end;

function TAboutWindow.GetForm: TForm;
begin
  if not Assigned(FForm) then
  begin
    FForm := TAboutForm.Create(Self, FFirst, EMail);
  end;
  Result := FForm;
end;

procedure TAboutWindow.SetEMail(const AValue: string);
begin
  if FEMail <> AValue then
  begin
    FEMail := AValue;
  end;
//  if Form.Position <> Position then
//  begin
//    Form.Position := Position;
//  end;
end;

procedure TAboutWindow.SetPosition(const AValue: TPosition);
begin
  if FPosition <> AValue then
  begin
    FPosition := AValue;
  end;
  if Form.Position <> Position then
  begin
    Form.Position := Position;
  end;
end;

procedure TAboutWindow.SetShowSplash(const AValue: Boolean);
begin

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
