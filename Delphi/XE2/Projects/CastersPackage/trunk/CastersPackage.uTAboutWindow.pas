unit CastersPackage.uTAboutWindow;

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
  strict private
    FShowSplash: Boolean;
    function GetShowSplash: Boolean;
    procedure SetShowSplash(const AValue: Boolean);
  published
    property ShowSplash: Boolean read GetShowSplash write SetShowSplash default True;
  strict private
    FFirstShow: Boolean;
    FForm: TForm;
    function GetForm: TForm;
    property Form: TForm read GetForm nodefault;
  strict private
    procedure Initialize;
    procedure Finalize;
    procedure FreeForm;
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Show;
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

procedure TAboutWindow.Initialize;
begin
  FFirstShow := True;
  FShowSplash := True;
  FPosition := poScreenCenter;
  FEMail := 'vlad_dracula@tut.by';
end;

procedure TAboutWindow.Finalize;
begin
  FreeForm;
end;


function TAboutWindow.GetPosition: TPosition;
begin
  Result := FPosition;
end;

function TAboutWindow.GetShowSplash: Boolean;
begin
  Result := FShowSplash;
end;

procedure TAboutWindow.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if ShowSplash then
    begin
      Show;
      FFirstShow := False;
    end;
    FreeForm;
  end;
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
  if Assigned(FForm) then
  begin
    FreeAndNil(FForm);
  end;
  if not Assigned(FForm) then
  begin
    FForm := TAboutForm.Create(Self, FFirstShow, EMail);
  end;
  Result := FForm;
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
  if Form.Position <> Position then
  begin
    Form.Position := Position;
  end;
end;

procedure TAboutWindow.SetShowSplash(const AValue: Boolean);
begin
  if FShowSplash <> AValue then
  begin
    FShowSplash := AValue;
  end;
end;

procedure TAboutWindow.Show;
begin
  Form.ShowModal;
  FFirstShow := False;
end;

procedure Register;
begin
  RegisterComponents('CasterComponents', [TAboutWindow]);
end;

end.
