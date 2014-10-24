unit CastersPackage.uTStateImage;

interface

uses
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.ComCtrls;

type
  TStateImage = class(TImage)
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AutoSize default True;
    property Transparent default True;
    property Width default 16;
    property Height default 16;

  strict private
    FState: Boolean;
  strict protected
    function GetState: Boolean;
    procedure SetState(const AValue: Boolean);
  published
    property State: Boolean read GetState write SetState default True;

  private
    FStatusBar: TStatusBar;
    function GetStatusBar: TStatusBar;
    procedure SetStatusBar(const AValue: TStatusBar);
  published
    property StatusBar: TStatusBar read GetStatusBar write SetStatusBar nodefault;

  private
    FBindPanelIndex: Integer;
    function GetBindPanelIndex: Integer;
    procedure SetBindPanelIndex(const AValue: Integer);
  published
    property BindPanelIndex: Integer read GetBindPanelIndex write SetBindPanelIndex default -1;

  strict private
    procedure PaintState(const AValue: Boolean);
    procedure Bind;
  end;

procedure Register;

implementation

// {$R *.dcr}

uses
  System.Types,
  Winapi.Windows,
  Winapi.CommCtrl,
  CastersPackage.uTHackControl;

procedure TStateImage.Bind;
var
  r: TRect;
begin
  if not(csDesigning in ComponentState) then
  begin
    if not Assigned(StatusBar) then
    begin
      Exit;
    end;

    if BindPanelIndex < 0 then
    begin
      Exit;
    end;

    THackControl(Self).SetParent(StatusBar);
    SendMessage(StatusBar.Handle, SB_GETRECT, BindPanelIndex, Integer(@r));
    SetBounds(r.Left + 2, r.Top + 1, r.Right - r.Left - 4, r.Bottom - r.Top - 4);
  end;
end;

constructor TStateImage.Create(AOwner: TComponent);
begin
  inherited;
  AutoSize := True;
  Transparent := True;
  Width := 16;
  Height := 16;
  Constraints.MaxHeight := 16;
  Constraints.MaxWidth := 16;
  Constraints.MinHeight := 16;
  Constraints.MinWidth := 16;
  FState := True;
end;

procedure Register;
begin
  RegisterComponents('CasterComponents', [TStateImage]);
end;

function TStateImage.GetBindPanelIndex: Integer;
begin
  Result := FBindPanelIndex;
end;

function TStateImage.GetState: Boolean;
begin
  Result := FState;
end;

function TStateImage.GetStatusBar: TStatusBar;
begin
  Result := FStatusBar;
end;

procedure TStateImage.Loaded;
begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
    Bind;
  end;
end;

procedure TStateImage.SetBindPanelIndex(const AValue: Integer);
begin
  if FBindPanelIndex <> AValue then
  begin
    if Assigned(StatusBar) then
    begin
      if not StatusBar.SimplePanel then
      begin
        if (AValue > -1) and (AValue <= Pred(StatusBar.Panels.Count)) then
        begin
          FBindPanelIndex := AValue;
        end;
      end;
    end;
  end;
end;

procedure TStateImage.SetState(const AValue: Boolean);
begin
  if FState <> AValue then
  begin
    FState := AValue;
    PaintState(FState);
  end;
end;

procedure TStateImage.SetStatusBar(const AValue: TStatusBar);
begin
  if FStatusBar <> AValue then
  begin
    FStatusBar := AValue;
  end;
end;

procedure TStateImage.PaintState(const AValue: Boolean);
begin
  // FStateImages.GetIcon(Integer(AValue), Picture.Icon);
end;

end.
