unit CastersPackage.uTStateImage;

interface

uses
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.ComCtrls,
  Vcl.Graphics,
  Vcl.Controls;

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
    property State: Boolean read GetState write SetState default False;

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
    FStateImages: TImageList;
    function GetStateImages: TImageList;
    procedure SetStateImages(const AValue: TImageList);
  published
    property StateImages: TImageList read GetStateImages write SetStateImages nodefault;

  strict private
    procedure PaintState;
    procedure Bind;
  end;

procedure Register;

implementation

{$R *.dcr}

uses
  Winapi.CommCtrl,
  Vcl.ImgList,

  System.SysUtils,

  CastersPackage.uTHackControl,
  Winapi.Windows;

procedure Register;
begin
  RegisterComponents('CasterComponents', [TStateImage]);
end;

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
  BindPanelIndex := -1;
  { LoadImages; }
  FState := True;
  State := False;
end;

function TStateImage.GetBindPanelIndex: Integer;
begin
  Result := FBindPanelIndex;
end;

function TStateImage.GetState: Boolean;
begin
  Result := FState;
end;

function TStateImage.GetStateImages: TImageList;
begin
  Result := FStateImages;
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

procedure TStateImage.PaintState;
begin
  if Assigned(FStateImages) then
  begin
    FStateImages.GetIcon(Integer(State), Picture.Icon);
  end
  else
  begin
    Picture.Icon := nil;
  end;
  Invalidate;
end;

procedure TStateImage.SetBindPanelIndex(const AValue: Integer);
begin
  if FBindPanelIndex <> AValue then
  begin
    FBindPanelIndex := AValue;
  end;
end;

procedure TStateImage.SetState(const AValue: Boolean);
begin
  if FState <> AValue then
  begin
    FState := AValue;
    PaintState;
  end;
end;

procedure TStateImage.SetStateImages(const AValue: TImageList);
begin
  if FStateImages <> AValue then
  begin
    FStateImages := AValue;
    PaintState;
  end;
end;

procedure TStateImage.SetStatusBar(const AValue: TStatusBar);
begin
  if FStatusBar <> AValue then
  begin
    FStatusBar := AValue;
  end;
end;

{ function TStateImage.GetStateImages: TImageList;
  begin
  if not Assigned(FStateImages) then
  begin
  FStateImages := TImageList.Create(Self);
  if Assigned(FStateImages) then
  begin
  FStateImages.AllocBy := 1;
  FStateImages.ColorDepth := cd16Bit;
  end;
  end;
  Result := FStateImages;
  end;

  procedure TStateImage.LoadImages;
  begin
  // Image1.Picture.Bitmap := TMyBitmap.Create;
  // TMyBitmap(Image1.Picture.Bitmap).Load256ColorBitmap(hInstance, 'BITMAP_1');
  // Picture.Bitmap.StateImages.ResourceLoad(rtBitmap, 'BMP_NONACTIVE', clFuchsia);
  StateImages.ResourceLoad(rtBitmap, 'BMP_ACTIVE', clFuchsia);
  end; }

{ type
  TMyBitmap = class(Vcl.Graphics.TBitmap)
  public
  procedure Load256ColorBitmap(const AInstance: THandle; const ABitmapName: PChar);
  end;

  procedure TMyBitmap.Load256ColorBitmap(const AInstance: THandle; const ABitmapName: PChar);
  var
  h: THandle;
  size: LongInt;
  info: PBitmapInfo;
  file_header: TBitmapFileHeader;
  s: TMemoryStream;
  begin
  h := LoadResource(AInstance, FindResource(AInstance, ABitmapName, RT_BITMAP));
  if h <> 0 then
  begin
  try
  info := LockResource(h);
  size := GetSelectorLimit(Seg(info^)) + SizeOf(TBitmapFileHeader);

  file_header.bfType := $4D42;
  file_header.bfSize := size;
  file_header.bfReserved1 := 0;
  file_header.bfReserved2 := 0;
  file_header.bfOffBits := SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfoHeader);
  case info^.bmiHeader.biBitCount of
  1:
  file_header.bfOffBits := file_header.bfOffBits + 2 * 4;
  4:
  file_header.bfOffBits := file_header.bfOffBits + 16 * 4;
  8:
  file_header.bfOffBits := file_header.bfOffBits + 256 * 4;
  end;
  s := TMemoryStream.Create;
  try
  s.SetSize(size);
  s.Write(file_header, SizeOf(TBitmapFileHeader));
  s.Write(info^, size - SizeOf(TBitmapFileHeader));
  s.Position := 0;
  LoadFromStream(s);
  finally
  s.Free;
  end;
  finally
  FreeResource(h);
  end;
  end
  else
  begin
  raise EResNotFound.Create(Format('Не могу найти ресурс изображения %s', [ABitmapName]));
  end;
  end; }

end.
