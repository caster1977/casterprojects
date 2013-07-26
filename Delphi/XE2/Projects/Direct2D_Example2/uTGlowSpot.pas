unit uTGlowSpot;

interface

uses
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Direct2D;

type
  TGlowSpot = class
  strict private
    FX: Integer;
    function GetX: Integer;
    procedure SetX(const AValue: Integer);
  public
    property X: Integer read GetX write SetX nodefault;
  strict private
    FY: Integer;
    function GetY: Integer;
    procedure SetY(const AValue: Integer);
  public
    property Y: Integer read GetY write SetY nodefault;
  strict private
    FRadius: Integer;
    function GetRadius: Integer;
    procedure SetRadius(const AValue: Integer);
  public
    property Radius: Integer read GetRadius write SetRadius nodefault;
  strict private
    FAlpha: Extended;
    function GetAlpha: Extended;
    procedure SetAlpha(const AValue: Extended);
  public
    property Alpha: Extended read GetAlpha write SetAlpha nodefault;
  strict private
    FFadeIn: Boolean;
    function GetFadeIn: Boolean;
    procedure SetFadeIn(const AValue: Boolean);
  public
    property FadeIn: Boolean read GetFadeIn write SetFadeIn nodefault;
  strict private
    FColor: TColor;
    function GetColor: TColor;
    procedure SetColor(const AValue: TColor);
  public
    property Color: TColor read GetColor write SetColor nodefault;
  public
    constructor Create(AParent: TWinControl);
    procedure Paint(Canvas: TDirect2DCanvas);
  end;

implementation

uses
  Winapi.D2D1,
  Winapi.Windows;

constructor TGlowSpot.Create(AParent: TWinControl);
begin
  inherited Create;
  Alpha := 1;
  Radius := 40;
  FadeIn := False;
  Randomize;
  Color := RGB(Random(255), Random(255), Random(255));
end;

function TGlowSpot.GetAlpha: Extended;
begin
  Result := FAlpha;
end;

function TGlowSpot.GetColor: TColor;
begin
  Result := FColor;
end;

function TGlowSpot.GetFadeIn: Boolean;
begin
  Result := FFadeIn;
end;

function TGlowSpot.GetRadius: Integer;
begin
  Result := FRadius;
end;

function TGlowSpot.GetX: Integer;
begin
  Result := FX;
end;

function TGlowSpot.GetY: Integer;
begin
  Result := FY;
end;

procedure TGlowSpot.Paint(Canvas: TDirect2DCanvas);

  procedure PaintGlow(const Canvas: TDirect2DCanvas; const Alpha: Single;
    const X, Y, Radius: Integer; const Color: TColor);
  var
    Stops: array [0 .. 1] of TD2D1GradientStop;
    Gradient: ID2D1GradientStopCollection;
    BrushProperties: TD2D1RadialGradientBrushProperties;
    RadialBrush: ID2D1RadialGradientBrush;
    Brush: TDirect2DBrush;
  begin
    Stops[0].Position := 0;
    Stops[0].Color := D2D1ColorF(Color, Alpha);
    Stops[1].Position := 1;
    Stops[1].Color := D2D1ColorF(Color, 0);
    Canvas.RenderTarget.CreateGradientStopCollection(@Stops[0], Length(Stops), D2D1_GAMMA_2_2,
      D2D1_EXTEND_MODE_CLAMP, Gradient);
    BrushProperties.center := D2D1PointF(X, Y);
    BrushProperties.gradientOriginOffset.X := 0;
    BrushProperties.gradientOriginOffset.Y := 0;
    BrushProperties.radiusX := Radius;
    BrushProperties.radiusY := Radius;
    Canvas.RenderTarget.CreateRadialGradientBrush(BrushProperties, nil, Gradient, RadialBrush);
    Brush := TDirect2DBrush.Create(Canvas);
    Brush.Handle := RadialBrush;
    Canvas.Pen.Color := clNone;
    Canvas.Brush := Brush;
    Canvas.Ellipse(X - Radius, Y - Radius, X + Radius, Y + Radius);
  end;

begin
  PaintGlow(Canvas, Alpha, X, Y, Radius, Color);
end;

procedure TGlowSpot.SetAlpha(const AValue: Extended);
begin
  if FAlpha <> AValue then
  begin
    FAlpha := AValue;
  end;
end;

procedure TGlowSpot.SetColor(const AValue: TColor);
begin
  if FColor <> AValue then
  begin
    FColor := AValue;
  end;
end;

procedure TGlowSpot.SetFadeIn(const AValue: Boolean);
begin
  if FFadeIn <> AValue then
  begin
    FFadeIn := AValue;
  end;
end;

procedure TGlowSpot.SetRadius(const AValue: Integer);
begin
  if FRadius <> AValue then
  begin
    FRadius := AValue;
  end;
end;

procedure TGlowSpot.SetX(const AValue: Integer);
begin
  if FX <> AValue then
  begin
    FX := AValue;
  end;
end;

procedure TGlowSpot.SetY(const AValue: Integer);
begin
  if FY <> AValue then
  begin
    FY := AValue;
  end;
end;

end.
