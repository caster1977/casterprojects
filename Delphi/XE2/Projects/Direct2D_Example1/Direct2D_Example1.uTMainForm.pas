unit Direct2D_Example1.uTMainForm;

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
  Winapi.D2D1;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
  private
    FFactory: ID2D1Factory;
    FRenderTarget: ID2D1HwndRenderTarget;
    FBrush1: ID2D1SolidColorBrush;
    FBrush2: ID2D1SolidColorBrush;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  size: TD2D1SizeU;
begin
  D2D1CreateFactory(D2D1_FACTORY_TYPE_SINGLE_THREADED, IID_ID2D1Factory, nil, FFactory);

  size := D2D1SizeU(ClientWidth, ClientHeight);

  FFactory.CreateHwndRenderTarget(D2D1RenderTargetProperties, D2D1HwndRenderTargetProperties(Handle,
    size), FRenderTarget);

  FRenderTarget.CreateSolidColorBrush(D2D1ColorF(0.7, 0.7, 0.75, 1), nil, FBrush1);
  FRenderTarget.CreateSolidColorBrush(D2D1ColorF(0.5, 0.5, 0.55, 1), nil, FBrush2);
end;

procedure TMainForm.FormPaint(Sender: TObject);
var
  size: D2D1_SIZE_F;
  w, h: Integer;
  x, y: Integer;
  r1, r2: TD2DRectF;
begin
  FRenderTarget.BeginDraw;
  try
    FRenderTarget.SetTransform(TD2DMatrix3x2F.Identity);
    FRenderTarget.Clear(D2D1ColorF(1, 1, 1, 1));
    FRenderTarget.GetSize(size);

    w := round(size.width);
    h := round(size.height);

    x := 0;
    while x < w do
    begin
      FRenderTarget.DrawLine(D2D1PointF(x, 0), D2D1PointF(x, h), FBrush1, 0.5);
      Inc(x, 10);
    end;

    y := 0;
    while y < h do
    begin
      FRenderTarget.DrawLine(D2D1PointF(0, y), D2D1PointF(w, y), FBrush1, 0.5);
      Inc(y, 10);
    end;

    r1 := D2D1RectF(w div 2 - 50, h div 2 - 50, w div 2 + 50, h div 2 + 50);
    r2 := D2D1RectF(w div 2 - 100, h div 2 - 100, w div 2 + 100, h div 2 + 100);

    FRenderTarget.FillRectangle(r1, FBrush1);
    FRenderTarget.DrawRectangle(r2, FBrush2);
  finally
    FRenderTarget.EndDraw;
  end;
end;

procedure TMainForm.FormResize(Sender: TObject);
var
  a: D2D1_SIZE_U;
begin
  a := D2D1SizeU(ClientWidth, ClientHeight);
  FRenderTarget.Resize(a);
  Invalidate;
end;

end.
