unit Direct2D_Example2.uTMainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,

  Vcl.Direct2D,
  Winapi.D2D1,
  uTGlowSpotList;

type
  TMainForm = class(TForm)
    Timer1: TTimer;
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
  strict private
    FCanvas: TDirect2DCanvas;
    FImage: TImage;
    FFPS: Integer;
    FFrames: Integer;
    FStartTime: Cardinal;
    FSpots: TGlowSpotList;
    procedure WMEraseBkgnd(var AMessage: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMTouch(var AMessage: TMessage); message WM_TOUCH;
    function GetCanvas: TDirect2DCanvas;
    procedure UpdateFPS;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TDirect2DCanvas read GetCanvas nodefault;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  System.Types,
  uTGlowSpot;

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited;
  FSpots := TGlowSpotList.Create;
  FImage := TImage.Create(Self);
  FImage.Picture.LoadFromFile('img.tif');
  ClientHeight := FImage.Picture.Height;
  RegisterTouchWindow(Handle, 0);
end;

destructor TMainForm.Destroy;
begin
  UnregisterTouchWindow(Handle);
  FreeAndNil(FImage);
  FreeAndNil(FSpots);
  FreeAndNil(FCanvas);
  inherited;
end;

procedure TMainForm.FormMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  spot: TGlowSpot;
begin
  if ssTouch in Shift then
  begin
    Exit;
  end;
  spot := TGlowSpot.Create(Self);
  spot.X := X;
  spot.Y := Y;
  FSpots.Add(spot);
end;

procedure TMainForm.FormPaint(Sender: TObject);
var
  w, h: Integer;
  X, Y: Integer;
  layer: ID2D1Layer;
  lp: TD2D1LayerParameters;
  // r1, r2: TRect;
  gc: ID2D1GradientStopCollection;
  gs: array [0 .. 1] of TD2D1GradientStop;
  gb: ID2D1RadialGradientBrush;
const
  gpoints: array [0 .. 2] of TD2D1Point2F = ((X: 150; Y: 50), (X: 280; Y: 150), (X: 150; Y: 350));
var
//  pathGeometry: ID2D1PathGeometry;
//  factory: ID2D1Factory;
//  sink: ID2D1GeometrySink;
  spot: TGlowSpot;

  function D2D1InfiniteRect: TD2D1RectF;
  begin
    Result.top := -MINSHORT;
    Result.left := -MINSHORT;
    Result.right := MAXSHORT;
    Result.bottom := MAXSHORT;
  end;

begin
  h := ClientHeight;
  w := ClientWidth;

  with Canvas do
  begin
    BeginDraw;
    RenderTarget.SetTransform(TD2DMatrix3x2F.Identity);

    Brush.Color := clBlack;
    Rectangle(0, 0, w, h);
{$REGION}
    X := 0;
    Pen.Color := clLtGray;
    while X < w do
    begin
      MoveTo(X, 0);
      LineTo(X, h);
      Inc(X, 10);
    end;

    Y := 0;
    while Y < h do
    begin
      MoveTo(0, Y);
      LineTo(w, Y);
      Inc(Y, 10);
    end;
{$ENDREGION}
{$REGION}
    {
      r1 := Rect(w div 2 - 50, h div 2 - 50, w div 2 + 50, h div 2 + 50);
      r2 := Rect(w div 2 - 100, h div 2 - 100, w div 2 + 100, h div 2 + 100);

      Brush.Color := clSilver;
      FillRect(r1);
      Brush.Color := clGray;
      FrameRect(r2);
    }
{$ENDREGION}
{$REGION}
    // Draw(0, 0, FImage.Picture.Graphic);
{$ENDREGION}
{$REGION}
    { // ------ bounds rect
      RenderTarget.SetTransform(TD2DMatrix3x2F.Translation(10, 10));
      RenderTarget.CreateLayer(nil, layer);

      zeroMemory(@lp, sizeof(lp));
      lp.contentBounds := D2D1RectF(20, 20, 420, 520);
      lp.opacity := 0.75;
      RenderTarget.PushLayer(lp, layer);

      Draw(0, 0, FImage.Picture.Graphic);
      // renderTarget.DrawBitmap(bitmap);

      RenderTarget.PopLayer; }
{$ENDREGION}
{$REGION}
     // ---- opacity mask test
      RenderTarget.SetTransform(TD2DMatrix3x2F.Translation(20, 20));
      RenderTarget.CreateLayer(nil, layer);

      ZeroMemory(@lp, SizeOf(lp));
      lp.contentBounds := D2D1InfiniteRect;
      lp.maskAntialiasMode := D2D1_ANTIALIAS_MODE_PER_PRIMITIVE;
      lp.maskTransform := TD2DMatrix3x2F.Identity;
      lp.opacity := 1;
      gs[0].position := 0;
      gs[0].Color := D2D1ColorF(clWhite, 1);
      gs[1].position := 1;
      gs[1].Color := D2D1ColorF(clWhite, 0);
      RenderTarget.CreateGradientStopCollection(@gs, 2, D2D1_GAMMA_2_2, D2D1_EXTEND_MODE_CLAMP, gc);

      RenderTarget.CreateRadialGradientBrush(D2D1RadialGradientBrushProperties(D2D1PointF(200, 300),
      D2D1PointF(0, 0), 200, 300), nil, gc, gb);
      lp.opacityBrush := gb;
      // canvas.CreateBrush([clBlack,clWhite],D2D1PointF(50,50),D2D1PointF(0,0),50,50);
      lp.layerOptions := D2D1_LAYER_OPTIONS_NONE;

      RenderTarget.PushLayer(lp, layer);
      Draw(0, 0, FImage.Picture.Graphic);
      RenderTarget.PopLayer;
{$ENDREGION}
{$REGION}
    {// ----geometry mask
    RenderTarget.SetTransform(TD2DMatrix3x2F.Translation(65, 50));
    RenderTarget.CreateLayer(nil, layer);

    RenderTarget.GetFactory(factory);
    factory.CreatePathGeometry(pathGeometry);
    pathGeometry.Open(sink);
    sink.SetFillMode(D2D1_FILL_MODE_WINDING);
    sink.BeginFigure(D2D1PointF(0, 25), D2D1_FIGURE_BEGIN_FILLED);
    sink.AddLines(@gpoints, 3);
    sink.EndFigure(D2D1_FIGURE_END_CLOSED);
    sink.Close;

    ZeroMemory(@lp, SizeOf(lp));
    lp.contentBounds := D2D1InfiniteRect;
    lp.geometricMask := pathGeometry;
    lp.maskAntialiasMode := D2D1_ANTIALIAS_MODE_PER_PRIMITIVE;
    lp.maskTransform := TD2DMatrix3x2F.Identity;
    lp.opacity := 0.75;
    lp.layerOptions := D2D1_LAYER_OPTIONS_NONE;

    RenderTarget.PushLayer(lp, layer);
    Draw(0, 0, FImage.Picture.Graphic);
    RenderTarget.PopLayer;}
{$ENDREGION}
{$REGION}
    // FPS
    Canvas.Font.Color := clRed;
    Canvas.Brush.Color := clNone;
    Canvas.Font.Size := 14;
    Canvas.TextOut(10, 10, FloatToStrF(FFPS, ffFixed, 2, 2) + ' FPS');
{$ENDREGION}
{$REGION}
    // spots
    RenderTarget.SetTransform(TD2DMatrix3x2F.Identity);
    for spot in FSpots do
    begin
      spot.Paint(Canvas);
    end;
{$ENDREGION}
    EndDraw;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
var
  a: D2D1_SIZE_U;
  render_target: ID2D1HwndRenderTarget;
begin
  if Supports(Canvas.RenderTarget, ID2D1HwndRenderTarget, render_target) then
  begin
    a := D2D1SizeU(ClientWidth, ClientHeight);
    render_target.Resize(a);
    Invalidate;
  end;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  FFPS := 0;
  FFrames := 0;
  FStartTime := GetTickCount;
end;

function TMainForm.GetCanvas: TDirect2DCanvas;
begin
  if not Assigned(FCanvas) then
  begin
    FCanvas := TDirect2DCanvas.Create(Handle);
    (Canvas.RenderTarget as ID2D1HwndRenderTarget).SetDpi(96, 96);
  end;
  Result := FCanvas;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
begin
  UpdateFPS;
  Paint;
end;

procedure TMainForm.UpdateFPS;
var
  spot: TGlowSpot;
begin
  Inc(FFrames);
  if GetTickCount - FStartTime >= 1000 then
  begin
    FFPS := FFrames;
    FFrames := 0;
    FStartTime := GetTickCount;
  end;
  for spot in FSpots do
  begin
    if spot.FadeIn then
    begin
      spot.Alpha := spot.Alpha + 0.012;
    end
    else
    begin
      spot.Alpha := spot.Alpha - 0.012;
    end;

    if spot.Alpha < 0.3 then
    begin
      spot.FadeIn := True;
      spot.Alpha := 0.4
    end
    else
    begin
      if spot.Alpha > 1 then
      begin
        spot.FadeIn := False;
      end;
    end;
  end;
end;

procedure TMainForm.WMEraseBkgnd(var AMessage: TWMEraseBkgnd);
begin
  AMessage.Result := 1;
end;

procedure TMainForm.WMTouch(var AMessage: TMessage);

  function TouchPointToPoint(const ATouchPoint: TTouchInput): TPoint;
  begin
    Result := Point(ATouchPoint.X div 100, ATouchPoint.Y div 100);
    PhysicalToLogicalPoint(Handle, Result);
  end;

var
  touch_inputs: array of TTouchInput;
  touch_input: TTouchInput;
  handled: Boolean;
  Point: TPoint;
  spot: TGlowSpot;
begin
  handled := False;
  try
    SetLength(touch_inputs, AMessage.WParam);
    GetTouchInputInfo(AMessage.LParam, AMessage.WParam, @touch_inputs[0], SizeOf(TTouchInput));
    try
      for touch_input in touch_inputs do
      begin
        Point := TouchPointToPoint(touch_input);
        spot := TGlowSpot.Create(Self);
        spot.X := Point.X;
        spot.Y := Point.Y;
        FSpots.Add(spot);
      end;
      handled := True;
    finally
      CloseTouchInputHandle(AMessage.LParam);
    end;
  finally
    if not handled then
    begin
      inherited;
    end;
  end;
end;

end.
