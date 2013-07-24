unit uMainForm;

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
  Winapi.DirectDraw,
  Vcl.AppEvnts;

type
  TMainForm = class(TForm)
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Restore(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Deactivate(Sender: TObject);
  private
    FDD: IDirectDraw7;
    FDDSPrimary: IDirectDrawSurface7;
    procedure Do_Paint;
    procedure ErrorOut(hRet: HRESULT; const FuncName: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Do_Paint;
var
  // Вспомогательный дескриптор, идентификатор устройства вывода GDI
  hRet: HRESULT; // Для анализа успешности действий
  DC: HDC;
  wrkCanvas: TCanvas; // Вспомогательный объект, рабочая канва
  ddbltfx: TDDBLTFX;
  wrkBitmap: TBitmap;
begin
  ZeroMemory(@ddbltfx, SizeOf(ddbltfx)); // Обнуляем все поля
  ddbltfx.dwSize := SizeOf(ddbltfx); // Обязательно задаем размер
  ddbltfx.dwFillColor := 0; // Цвет заполнения - черный
  while True do
  begin
    hRet := FDDSPrimary.Blt(nil, nil, nil, DDBLT_COLORFILL or DDBLT_WAIT, @ddbltfx);
    if hRet = DDERR_SURFACELOST then
    begin
      hRet := FDDSPrimary._Restore;
      if hRet <> DD_OK then
        Break;
    end
    else
      Break;
  end;

  while True do
  begin
    hRet := FDDSPrimary.GetDC(DC);
    if Succeeded(hRet) then
    begin
      wrkCanvas := TCanvas.Create;
      wrkCanvas.Handle := DC;
      wrkBitmap := TBitmap.Create;
      wrkBitmap.LoadFromFile('..\..\07f0fc36ca9c1e45814ba0448ad44d70.bmp');
      wrkCanvas.Draw(100, 100, wrkBitmap);
      wrkCanvas.Ellipse(Left + 50, Top + 50, Left + 100, Top + 100);
      wrkBitmap.Free;
      wrkCanvas.Free;
      FDDSPrimary.ReleaseDC(DC);
      Break;
    end;
    if hRet = DDERR_SURFACELOST then
    begin
      hRet := FDDSPrimary._Restore;
      if hRet <> DD_OK then
        Break;
    end;
    if hRet <> DDERR_WASSTILLDRAWING then
      Break;
  end;
end;

procedure TMainForm.ErrorOut(hRet: HRESULT; const FuncName: string);
begin
  MessageBox(Handle, PChar(FuncName + ': ' + sLineBreak + DDErrorString(hRet)), PChar(Caption),
    MB_OK or MB_ICONSTOP);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  hRet: HRESULT; // Для анализа успешности действий
  ddsd: TDDSurfaceDesc2; // Вспомогательная структура begin
begin
  FDDSPrimary := nil; // Вначале работы обнуляем все СОМ-объекты
  FDD := nil;
  // Создание главного объекта DirectDraw
  hRet := DirectDrawCreateEx(nil, FDD, IDirectDraw7, nil);
  if hRet <> DD_OK then
  begin
    ErrorOut(hRet, 'DirectDrawCreateEx');
    Exit;
  end;
  // Задаем уровень кооперации
  hRet := FDD.SetCooperativeLevel(Handle, DDSCL_FULLSCREEN or DDSCL_EXCLUSIVE);
  if hRet <> DD_OK then
  begin
    ErrorOut(hRet, 'SetCooperativeLevel');
    Exit;
  end;

  hRet := FDD.SetDisplayMode(1024, 768, 32, 0, 0);
  if hRet <> DD_OK then
  begin
    ErrorOut(hRet, 'SetDisplayMode');
    Exit;
  end;

  // Заполняем поля вспомогательной структуры
  ZeroMemory(@ddsd, SizeOf(ddsd));
  ddsd.dwSize := SizeOf(ddsd); // Поле размера структуры
  ddsd.dwFlags := DDSD_CAPS; // Будет создаваться первичная поверхность
  ddsd.ddsCaps.dwCaps := DDSCAPS_PRIMARYSURFACE;
  // Собственно создание первичной поверхности
  hRet := FDD.CreateSurface(ddsd, FDDSPrimary, nil);
  if hRet <> DD_OK then
  begin
    ErrorOut(hRet, 'Create Primary Surface');
    Exit;
  end;
  OnResize := FormResize;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FDD) then
  begin // Связана ли переменная главного объекта
    // Связана ли переменная первичной поверхности
    if Assigned(FDDSPrimary) then
      FDDSPrimary := nil;
    FDD := nil;
  end;
end;

procedure TMainForm.FormPaint(Sender: TObject);
begin
  Do_Paint;
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  Do_Paint;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  Do_Paint;
end;

procedure TMainForm.ApplicationEvents1Activate(Sender: TObject);
begin
  Do_Paint;
end;

procedure TMainForm.ApplicationEvents1Deactivate(Sender: TObject);
begin
  Application.Minimize;
end;

procedure TMainForm.ApplicationEvents1Restore(Sender: TObject);
begin
  WindowState := wsMaximized;
  Do_Paint;
end;

procedure TMainForm.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
  var Resize: Boolean);
begin
  Resize := NewHeight >= 110; // Высота окна не должна быть меньше 110
end;

end.
