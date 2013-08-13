unit TAPEstimator.uTDirect3D9Gear;

interface

uses
  // Winapi.Direct3D,
  Winapi.Direct3D9,
  Winapi.D3DX9,
  Winapi.Windows;

type
  ArrayOfIDirect3DTexture9 = array [0 .. 0] of IDirect3DTexture9;
  PArrayOfIDirect3DTexture9 = ^ArrayOfIDirect3DTexture9;

  ArrayOfTD3DMaterial9 = array [0 .. 0] of TD3DMaterial9;
  PArrayOfTD3DMaterial9 = ^ArrayOfTD3DMaterial9;

  ArrayOfTD3DXMaterial = array [0 .. 0] of TD3DXMaterial;
  PArrayOfTD3DXMaterial = ^ArrayOfTD3DXMaterial;

  TDirect3D9Gear = class(TInterfacedObject)
  private
    FDirect3D9: IDirect3D9;
    function GetDirect3D9: IDirect3D9;
  public
    property Direct3D9: IDirect3D9 read GetDirect3D9 nodefault;
  private
    FDirect3DDevice9: IDirect3DDevice9;
    function GetDirect3DDevice9: IDirect3DDevice9;
  public
    property Direct3DDevice9: IDirect3DDevice9 read GetDirect3DDevice9 nodefault;
  private
    FHandle: HWND;
    function GetHandle: HWND;
    property Handle: HWND read GetHandle nodefault;
  private
    FFullScreen: Boolean;
    function GetFullScreen: Boolean;
    property FullScreen: Boolean read GetFullScreen nodefault;
  private
    FWidth: Integer;
    function GetWidth: Integer;
    property Width: Integer read GetWidth nodefault;
  private
    FHeight: Integer;
    function GetHeight: Integer;
    property Height: Integer read GetHeight nodefault;
  private
    function CreateDirect3D9: Boolean;
    procedure FreeDirect3D9;
    function ReCreateDirect3DDevice9: Boolean;
    procedure FreeDirect3DDevice9;
  private
    FVertexProcessing: DWORD;
    function GetVertexProcessing: DWORD;
    property VertexProcessing: DWORD read GetVertexProcessing nodefault;
  public
    constructor Create(const AHandle: HWND; const AWidth, AHeight: Integer;
      const AFullScreen: Boolean); reintroduce; virtual;
    destructor Destroy; override;
    function CreateDirect3DDevice9(const AHandle: HWND; const AWidth, AHeight: Integer;
      const AFullScreen: Boolean): Boolean;
  end;

implementation

uses
  VCL.Dialogs,
  System.SysUtils;

constructor TDirect3D9Gear.Create(const AHandle: HWND; const AWidth, AHeight: Integer;
  const AFullScreen: Boolean);
begin
  inherited Create;
  if not CreateDirect3D9 then
  begin
    raise Exception.Create('CreateDirect3D9');
  end;
  if not CreateDirect3DDevice9(AHandle, AWidth, AHeight, AFullScreen) then
  begin
    raise Exception.Create('CreateDirect3DDevice9');
  end;
end;

function TDirect3D9Gear.CreateDirect3DDevice9(const AHandle: HWND; const AWidth, AHeight: Integer;
  const AFullScreen: Boolean): Boolean;
begin
  FreeDirect3DDevice9;
  FHandle := AHandle;
  FWidth := AWidth;
  FHeight := AHeight;
  FFullScreen := AFullScreen;
  Result := ReCreateDirect3DDevice9;
end;

function TDirect3D9Gear.CreateDirect3D9: Boolean;
var
  d3d_caps9: TD3DCaps9;
begin
  FreeDirect3DDevice9;
  FreeDirect3D9;
  FDirect3D9 := Direct3DCreate9(D3D_SDK_VERSION);
  Result := Assigned(Direct3D9);

  if Result then
  begin
    Direct3D9.GetDeviceCaps(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, d3d_caps9);
    if (d3d_caps9.DevCaps and D3DDEVCAPS_HWTRANSFORMANDLIGHT) = D3DDEVCAPS_HWTRANSFORMANDLIGHT then
    begin
      FVertexProcessing := D3DCREATE_HARDWARE_VERTEXPROCESSING;
    end
    else
    begin
      FVertexProcessing := D3DCREATE_SOFTWARE_VERTEXPROCESSING;
    end;
  end;
end;

procedure TDirect3D9Gear.FreeDirect3D9;
begin
  FDirect3D9 := nil;
end;

procedure TDirect3D9Gear.FreeDirect3DDevice9;
begin
  FDirect3DDevice9 := nil;
end;

function TDirect3D9Gear.GetDirect3D9: IDirect3D9;
begin
  Result := FDirect3D9;
end;

function TDirect3D9Gear.GetDirect3DDevice9: IDirect3DDevice9;
begin
  Result := FDirect3DDevice9;
end;

function TDirect3D9Gear.GetFullScreen: Boolean;
begin
  Result := FFullScreen;
end;

function TDirect3D9Gear.GetHandle: HWND;
begin
  Result := FHandle;
end;

function TDirect3D9Gear.GetHeight: Integer;
begin
  Result := FHeight;
end;

function TDirect3D9Gear.GetVertexProcessing: DWORD;
begin
  Result := FVertexProcessing;
end;

function TDirect3D9Gear.GetWidth: Integer;
begin
  Result := FWidth;
end;

function TDirect3D9Gear.ReCreateDirect3DDevice9: Boolean;
var
  d3d_present_parameters: TD3DPresentParameters;
  d3d_display_mode: TD3DDisplayMode;
  window_rect, client_rect: TRect;
begin
  ZeroMemory(@d3d_present_parameters, sizeof(d3d_present_parameters));

  d3d_present_parameters.BackBufferWidth := Width;
  d3d_present_parameters.BackBufferHeight := Height;
  d3d_present_parameters.AutoDepthStencilFormat := D3DFMT_D16;
  d3d_present_parameters.EnableAutoDepthStencil := True;
  d3d_present_parameters.Windowed := not FullScreen;

  if FullScreen then
  begin
    d3d_present_parameters.SwapEffect := D3DSWAPEFFECT_FLIP;
    d3d_present_parameters.BackBufferFormat := D3DFMT_R5G6B5;
    d3d_present_parameters.FullScreen_RefreshRateInHz := D3DPRESENT_RATE_DEFAULT;
    d3d_present_parameters.PresentationInterval := D3DPRESENT_INTERVAL_DEFAULT;
  end
  else
  begin
    d3d_present_parameters.SwapEffect := D3DSWAPEFFECT_DISCARD;
    Direct3D9.GetAdapterDisplayMode(D3DADAPTER_DEFAULT, d3d_display_mode);
    d3d_present_parameters.BackBufferFormat := d3d_display_mode.Format;
    // GetWindowRect(Handle, window_rect);
    // GetClientRect(Handle, client_rect);
    // MoveWindow(Handle, client_rect.Left, client_rect.Top,
    // Width + (window_rect.Right - window_rect.Left) - (client_rect.Right - client_rect.Left),
    // Height + (window_rect.Bottom - window_rect.Top) -
    // (client_rect.Bottom - client_rect.Top), True);
  end;

  Result := Succeeded(Direct3D9.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, Handle,
    VertexProcessing, @d3d_present_parameters, FDirect3DDevice9));
end;

destructor TDirect3D9Gear.Destroy;
begin
  FreeDirect3DDevice9;
  FreeDirect3D9;
  inherited;
end;

end.
