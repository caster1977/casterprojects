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
  DirectDraw,
  Vcl.AppEvnts;

type
  TMainForm=class(TForm)
    ApplicationEvents1: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ApplicationEvents1Restore(Sender: TObject);
    procedure ApplicationEvents1Activate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
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
  // ��������������� ����������, ������������� ���������� ������ GDI
  hRet: HRESULT; // ��� ������� ���������� ��������
  DC: HDC;
  wrkCanvas: TCanvas; // ��������������� ������, ������� �����
begin
  while True do
    begin // ��������, r�� �������� ��������� ������������
      hRet:=FDDSPrimary.GetDC(DC); // ������ �������� ����������
      if Succeeded(hRet) then
        begin
          wrkCanvas:=TCanvas.Create;
          wrkCanvas.Handle:=DC;
          wrkCanvas.Ellipse(Left+50, Top+50, Left+100, Top+100);
          wrkCanvas.Free;
          FDDSPrimary.ReleaseDC(DC);
          Break;
        end;
      // ����������� ��������, ���� ������������ if hRet = DDERR_SURFACELOST then begin
      hRet:=FDDSPrimary._Restore;
      // ���� �� ������� ������������, ������ ���������� ������
      // ������ ������� �� DDERR_WASSTILLDRAWING, ������������� �����������
      if (hRet<>DD_OK) and (hRet<>DDERR_WASSTILLDRAWING) then
        Break;
    end;
end;

procedure TMainForm.ErrorOut(hRet: HRESULT; const FuncName: string);
begin
  MessageBox(Handle, PChar(FuncName+': '+#13+DDErrorString(hRet)), PChar(Caption), MB_OK or MB_ICONSTOP);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  hRet: HRESULT; // ��� ������� ���������� ��������
  ddsd: TDDSurfaceDesc2; // ��������������� ��������� begin
begin
  FDDSPrimary:=nil; // ������� ������ �������� ��� ���-�������
  FDD:=nil;
  // �������� �������� ������� DirectDraw
  hRet:=DirectDrawCreateEx(nil, FDD, IDirectDraw7, nil);
  if hRet<>DD_OK then
    begin
      ErrorOut(hRet, 'DirectDrawCreateEx');
      Exit;
    end;
  // ������ ������� ����������
  hRet:=FDD.SetCooperativeLevel(Handle, DDSCL_FULLSCREEN or DDSCL_EXCLUSIVE);
  if hRet<>DD_OK then
    begin
      ErrorOut(hRet, 'SetCooperativeLevel');
      Exit;
    end;
  {
  hRet:=FDD.SetDisplayMode(640, 480, 32, 0, 0);
  if hRet<>DD_OK then
    begin
      ErrorOut(hRet, 'SetDisplayMode');
      Exit;
    end;
  }
  // ��������� ���� ��������������� ���������
  ZeroMemory(@ddsd, SizeOf(ddsd));
  ddsd.dwSize:=SizeOf(ddsd); // ���� ������� ���������
  ddsd.dwFlags:=DDSD_CAPS; // ����� ����������� ��������� �����������
  ddsd.ddsCaps.dwCaps:=DDSCAPS_PRIMARYSURFACE;
  // ���������� �������� ��������� �����������
  hRet:=FDD.CreateSurface(ddsd, FDDSPrimary, nil);
  if hRet<>DD_OK then
    begin
      ErrorOut(hRet, 'Create Primary Surface');
      Exit;
    end;
  OnResize:=FormResize;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  if Assigned(FDD) then
    begin // ������� �� ���������� �������� �������
      // ������� �� ���������� ��������� �����������
      if Assigned(FDDSPrimary) then
        FDDSPrimary:=nil;
      FDD:=nil;
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

procedure TMainForm.ApplicationEvents1Restore(Sender: TObject);
var
  // ��������������� ����������, ������������� ���������� ������ GDI
  hRet: HRESULT; // ��� ������� ���������� ��������
  DC: HDC;
  wrkCanvas: TCanvas; // ��������������� ������, ������� �����
begin
  WindowState:=wsMaximized;
  while True do
    begin // ��������, r�� �������� ��������� ������������
      hRet:=FDDSPrimary.GetDC(DC); // ������ �������� ����������
      if Succeeded(hRet) then
        begin
          wrkCanvas:=TCanvas.Create;
          wrkCanvas.Handle:=DC;
          wrkCanvas.Ellipse(Left+50, Top+50, Left+100, Top+100);
          wrkCanvas.Free;
          FDDSPrimary.ReleaseDC(DC);
          Break;
        end;
      // ����������� ��������, ���� ������������ if hRet = DDERR_SURFACELOST then begin
      hRet:=FDDSPrimary._Restore;
      // ���� �� ������� ������������, ������ ���������� ������
      // ������ ������� �� DDERR_WASSTILLDRAWING, ������������� �����������
      if (hRet<>DD_OK) and (hRet<>DDERR_WASSTILLDRAWING) then
        Break;
    end;
end;

procedure TMainForm.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer; var Resize: Boolean);
begin
  Resize:=NewHeight>=110; // ������ ���� �� ������ ���� ������ 110
end;

end.
