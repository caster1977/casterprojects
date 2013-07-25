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
  Vcl.Direct2D,
  Winapi.D2D1,
  Vcl.ExtCtrls;

type
  TMainForm = class(TForm)
    Timer1: TTimer;
    procedure FormResize(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  strict private
    FCanvas: TDirect2DCanvas;
    FImage: TImage;
    FFPS: Integer;
    FFrames: Integer;
    FStartTime: Cardinal;
    procedure WMEraseBkgnd(var AMessage: TWMEraseBkgnd); message WM_ERASEBKGND;
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

constructor TMainForm.Create(AOwner: TComponent);
begin
  inherited;
  FImage := TImage.Create(Self);
  FImage.Picture.LoadFromFile('img.tif');
  ClientHeight := FImage.Picture.Height;
end;

destructor TMainForm.Destroy;
begin
  FreeAndNil(FImage);
  FreeAndNil(FCanvas);
  inherited;
end;

procedure TMainForm.FormPaint(Sender: TObject);
var
  w, h: Integer;
  x, y: Integer;
  layer: ID2D1Layer;
  lp: TD2D1LayerParameters;
  // r1, r2: TRect;
  // gc: ID2D1GradientStopCollection;
  // gs: array [0 .. 1] of TD2D1GradientStop;
  // gb: ID2D1RadialGradientBrush;
const
  gpoints: array [0 .. 2] of TD2D1Point2F = ((x: 150; y: 50), (x: 280; y: 150), (x: 150; y: 350));
var
  pathGeometry: ID2D1PathGeometry;
  factory: ID2D1Factory;
  sink: ID2D1GeometrySink;

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
    x := 0;
    Pen.Color := clLtGray;
    while x < w do
    begin
      MoveTo(x, 0);
      LineTo(x, h);
      Inc(x, 10);
    end;

    y := 0;
    while y < h do
    begin
      MoveTo(0, y);
      LineTo(w, y);
      Inc(y, 10);
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
    { // ---- opacity mask test
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
      RenderTarget.PopLayer; }
{$ENDREGION}
{$REGION}
    // FPS
    Canvas.Font.Color := clRed;
    Canvas.Brush.Color := clNone;
    Canvas.Font.Size := 14;
    Canvas.TextOut(10, 10, FloatToStrF(FFPS, ffFixed, 2, 2) + ' FPS');
{$ENDREGION}
{$REGION}
    // ----geometry mask
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
    RenderTarget.PopLayer;
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
begin
  Inc(FFrames);
  if GetTickCount - FStartTime >= 1000 then
  begin
    FFPS := FFrames;
    FFrames := 0;
    FStartTime := GetTickCount;
  end;
end;

procedure TMainForm.WMEraseBkgnd(var AMessage: TWMEraseBkgnd);
begin
  AMessage.Result := 1;
end;

end.
