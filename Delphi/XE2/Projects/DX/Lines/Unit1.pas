unit Unit1;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Direct3D9,
  D3DX9,
  DXFunc,
  ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Panel1Resize(Sender: TObject);
    procedure RePaintPanel;
  end;

type
  TCustomVertex = packed record
    x, y, z, rwh: Single;
    color: DWORD;
  end;

var
  Form1: TForm1;
  pD3D: IDirect3D9 = nil;
  pD3DDevice: IDirect3DDevice9 = nil;

  VertexBuf: IDirect3DVertexBuffer9; // буфер вернин

implementation

{$R *.dfm}

uses
  Winapi.DXTypes;

procedure TForm1.FormActivate(Sender: TObject);
begin
  RePaint;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  pD3D := nil;
  pD3DDevice := nil;
end;

procedure TForm1.Panel1Resize(Sender: TObject);
begin
  pD3D := nil;
  pD3DDevice := nil;
  RePaintPanel;
end;

procedure TForm1.RePaintPanel;
var
//  Pixel: array [0 .. 5] of TCustomVertex;
  Pixel: array [0 .. 11] of TCustomVertex;
  pPixel: Pointer;
  d3dviewport: td3dviewport9;
begin
  DX3DInit(pD3D, pD3DDevice, Panel1.Handle, Panel1.Width, Panel1.Height, D3DFMT_A8R8G8B8, False);
  pD3DDevice.CreateVertexBuffer(SizeOf(Pixel), 0, D3DFVF_XYZRHW or D3DFVF_DIFFUSE, D3DPOOL_DEFAULT,
    VertexBuf, nil);
  // получаем параметры окна вывода
  pD3DDevice.GetViewport(d3dviewport);
  //ShowMessage('X: ' + IntToStr(d3dviewport.X) + ', Y: ' + IntToStr(d3dviewport.Y) + ', Width: ' + IntToStr(d3dviewport.Width) + ', Height: ' + IntToStr(d3dviewport.Height));

  // установка параметров вершин
  ZeroMemory(@Pixel, SizeOf(Pixel));

  Pixel[0].x := 10;
  Pixel[0].y := 10;
  Pixel[0].rwh := 1;
  Pixel[0].color := $00C0C0C0; // $AARRGGBB

  Pixel[1].x := 10;
  Pixel[1].y := d3dviewport.Height - 10;
  Pixel[1].rwh := 1;
  Pixel[1].color := $00C0C0C0; // $AARRGGBB

  Pixel[2].x := 10;
  Pixel[2].y := d3dviewport.Height - 10;
  Pixel[2].rwh := 1;
  Pixel[2].color := $00C0C0C0; // $AARRGGBB

  Pixel[3].x := d3dviewport.Width - 10;
  Pixel[3].y := d3dviewport.Height - 10;
  Pixel[3].rwh := 1;
  Pixel[3].color := $00C0C0C0; // $AARRGGBB

  Pixel[4].x := 10;
  Pixel[4].y := 10;
  Pixel[4].rwh := 1;
  Pixel[4].color := $00C0C0C0; // $AARRGGBB

  Pixel[5].x := 15;
  Pixel[5].y := 15;
  Pixel[5].rwh := 1;
  Pixel[5].color := $00C0C0C0; // $AARRGGBB

  Pixel[6].x := 10;
  Pixel[6].y := 10;
  Pixel[6].rwh := 1;
  Pixel[6].color := $00C0C0C0; // $AARRGGBB

  Pixel[7].x := 5;
  Pixel[7].y := 15;
  Pixel[7].rwh := 1;
  Pixel[7].color := $00C0C0C0; // $AARRGGBB

  Pixel[8].x := d3dviewport.Width - 10;
  Pixel[8].y := d3dviewport.Height - 10;
  Pixel[8].rwh := 1;
  Pixel[8].color := $00C0C0C0; // $AARRGGBB

  Pixel[9].x := d3dviewport.Width - 15;
  Pixel[9].y := d3dviewport.Height - 15;
  Pixel[9].rwh := 1;
  Pixel[9].color := $00C0C0C0; // $AARRGGBB

  Pixel[10].x := d3dviewport.Width - 10;
  Pixel[10].y := d3dviewport.Height - 10;
  Pixel[10].rwh := 1;
  Pixel[10].color := $00C0C0C0; // $AARRGGBB

  Pixel[11].x := d3dviewport.Width - 15;
  Pixel[11].y := d3dviewport.Height - 5;
  Pixel[11].rwh := 1;
  Pixel[11].color := $00C0C0C0; // $AARRGGBB
  {
  // установка параметров вершин
  ZeroMemory(@Pixel, SizeOf(Pixel));
  Pixel[0].x := d3dviewport.Width div 2 - 50;
  Pixel[0].y := d3dviewport.Height div 2 - 30;
  Pixel[0].rwh := 1;
  Pixel[0].color := $00FFFF00; // $AARRGGBB

  Pixel[1].x := d3dviewport.Width div 2 + 30;
  Pixel[1].y := d3dviewport.Height div 2 + 50;
  Pixel[1].rwh := 1;
  Pixel[1].color := $00FF00FF; // $AARRGGBB

  Pixel[2].x := d3dviewport.Width div 2 + 30;
  Pixel[2].y := d3dviewport.Height div 2 + 50;
  Pixel[2].rwh := 1;
  Pixel[2].color := $00FF0000; // $AARRGGBB

  Pixel[3].x := d3dviewport.Width div 2;
  Pixel[3].y := d3dviewport.Height div 2;
  Pixel[3].rwh := 1;
  Pixel[3].color := $00FF00FF; // $AARRGGBB

  Pixel[4].x := d3dviewport.Width div 2;
  Pixel[4].y := d3dviewport.Height div 2;
  Pixel[4].rwh := 1;
  Pixel[4].color := $00FF00F0; // $AARRGGBB

  Pixel[5].x := d3dviewport.Width div 2 - 50;
  Pixel[5].y := d3dviewport.Height div 2 - 30;
  Pixel[5].rwh := 1;
  Pixel[5].color := $00FFFFF0; // $AARRGGBB}

  // блокировка доступа к буферу вершин
  VertexBuf.Lock(0, SizeOf(Pixel), pPixel, 0);
  // копируем в буфер данные
  CopyMemory(pPixel, @Pixel, SizeOf(Pixel));
  // разблокировка буфера
  VertexBuf.Unlock;

  Timer1.Enabled := true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  if Assigned(pD3DDevice) then
  begin
    // чистим устройство
    pD3DDevice.Clear(0, nil, D3DCLEAR_TARGET, D3DCOLOR_XRGB(255, 0, 0), 1, 0);
    // начало сцены
    pD3DDevice.BeginScene;
    // связываем буфер вершин с потоком данных устройства
    pD3DDevice.SetStreamSource(0, VertexBuf, 0, SizeOf(TCustomVertex));
    // устанавливаем формат вершин
    pD3DDevice.SetFVF(D3DFVF_XYZRHW or D3DFVF_DIFFUSE);
    // рисуем примитив
    pD3DDevice.DrawPrimitive(D3DPT_LINELIST, 0, 6);
    // завершаем сцену
    pD3DDevice.EndScene;
    // переключение буферов
    pD3DDevice.Present(nil, nil, 0, nil);
  end;
end;

end.
