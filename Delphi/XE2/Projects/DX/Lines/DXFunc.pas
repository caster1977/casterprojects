unit dxfunc;

interface

uses
  Direct3D,
  Direct3D9,
  D3DX9,
  windows,
  SySUtils;
//  AnsiStrings;

type
  PAIDirect3DTexture9 = ^AIDirect3DTexture9;
  AIDirect3DTexture9 = array [0 .. 0] of IDirect3DTexture9;

  AD3DMATERIAL9 = array [0 .. 0] of TD3DMATERIAL9;
  PAD3DMATERIAL9 = ^AD3DMATERIAL9;

  AD3DXMATERIAL = array [0 .. 0] of TD3DXMATERIAL;
  PAD3DXMATERIAL = ^AD3DXMATERIAL;

function DX3DInit(var ppiD3D9: IDirect3D9; var ppiD3DDevice9: IDirect3DDevice9; hWnd: THandle;
  iWidth, iHeight: Integer; iColor: _D3DFORMAT; FullScreen: Boolean): Boolean;

function LoadMesh(FileName: string; ppiD3DDevice9: IDirect3DDevice9; var ppMesh: ID3DXMesh;
  var pMeshTextures: PAIDirect3DTexture9; var pMeshMaterials: PAD3DMATERIAL9): DWORD;

implementation

function DX3DInit(var ppiD3D9: IDirect3D9; var ppiD3DDevice9: IDirect3DDevice9; hWnd: THandle;
  iWidth, iHeight: Integer; iColor: _D3DFORMAT; FullScreen: Boolean): Boolean;
var
  d3dpp: TD3DPresentParameters;
  wndRect, clientRect: TRect;
  d3ddm: TD3DDISPLAYMODE;
  Flags: DWORD;
  hRes: HRESULT;
  Aspect: real;
  matProjection: TD3DXMatrix;
begin
  Result := false;

  ppiD3D9 := Direct3DCreate9(D3D_SDK_VERSION);
  if ppiD3D9 = nil then
    exit;

  // Заполняем основные параметры представления
  ZeroMemory(@d3dpp, sizeof(d3dpp));

  d3dpp.BackBufferWidth := iWidth;
  d3dpp.BackBufferHeight := iHeight;
  d3dpp.AutoDepthStencilFormat := D3DFMT_D16;
  d3dpp.EnableAutoDepthStencil := TRUE;

  if (FullScreen) then
  begin
    /// ///////////////////////////////////////////////////////
    // Полноэкранный режим                                  //
    /// ///////////////////////////////////////////////////////
    // Установка параметров полноэкранного режима
    d3dpp.BackBufferFormat := D3DFMT_R5G6B5;
    d3dpp.SwapEffect := D3DSWAPEFFECT_FLIP;
    d3dpp.Windowed := false;
    d3dpp.FullScreen_RefreshRateInHz := D3DPRESENT_RATE_DEFAULT;
    d3dpp.PresentationInterval := D3DPRESENT_INTERVAL_DEFAULT;
  end
  else
  begin
    /// ///////////////////////////////////////////////////////
    // Оконный режим                                        //
    /// ///////////////////////////////////////////////////////
    GetWindowRect(hWnd, wndRect);
    GetClientRect(hWnd, clientRect);

    iWidth := iWidth + (wndRect.right - wndRect.left) - (clientRect.right - clientRect.left);
    iHeight := iHeight + (wndRect.bottom - wndRect.top) - (clientRect.bottom - clientRect.top);

    MoveWindow(hWnd, clientRect.left, clientRect.top, iWidth, iHeight, TRUE);

    // Получить формат пикселя
    ppiD3D9.GetAdapterDisplayMode(D3DADAPTER_DEFAULT, d3ddm);

    // Установка параметров
    d3dpp.BackBufferFormat := d3ddm.Format;
    d3dpp.SwapEffect := D3DSWAPEFFECT_DISCARD;
    d3dpp.Windowed := TRUE;
  end;

  Flags := D3DCREATE_MIXED_VERTEXPROCESSING;

  // Создать 3D устройство
  hRes := ppiD3D9.CreateDevice(D3DADAPTER_DEFAULT, D3DDEVTYPE_HAL, hWnd, Flags, @d3dpp,
    ppiD3DDevice9);
  if (FAILED(hRes)) then
    exit;

  // Установить перспективу
  Aspect := d3dpp.BackBufferWidth / d3dpp.BackBufferHeight;
  D3DXMatrixPerspectiveFovLH(matProjection, D3DX_PI / 4.0, Aspect, 0.1, 2000.0);
  ppiD3DDevice9.SetTransform(D3DTS_PROJECTION, matProjection);

  ppiD3DDevice9.SetRenderState(D3DRS_LIGHTING, DWORD(false));

  Result := TRUE;
end;

function LoadMesh(FileName: string; ppiD3DDevice9: IDirect3DDevice9; var ppMesh: ID3DXMesh;
  var pMeshTextures: PAIDirect3DTexture9; var pMeshMaterials: PAD3DMATERIAL9): DWORD;
type
  PD3DXMaterialArray = ^TD3DXMaterialArray;
  TD3DXMaterialArray = array [0 .. 0] of TD3DXMATERIAL;
const
  strPrefix = '..\';
  lenPrefix = Length(strPrefix);
var
  pD3DXMtrlBuffer: ID3DXBuffer;
  d3dxMaterials: PD3DXMaterialArray;
  i: DWORD;
  dwNumMaterials: DWORD;
  strTexture: array [0 .. MAX_PATH - 1] of Char;
begin
  Result := 0;
  if FAILED(D3DXLoadMeshFromX(pChar(FileName), D3DXMESH_SYSTEMMEM, ppiD3DDevice9, nil,
    @pD3DXMtrlBuffer, nil, @dwNumMaterials, ppMesh)) then
  begin
    if FAILED(D3DXLoadMeshFromX(pChar('..\' + FileName), D3DXMESH_SYSTEMMEM, ppiD3DDevice9, nil,
      @pD3DXMtrlBuffer, nil, @dwNumMaterials, ppMesh)) then
    begin
      MessageBox(0, pChar('Could not find ' + FileName), '', MB_OK);
      exit;
    end;
  end;
  d3dxMaterials := pD3DXMtrlBuffer.GetBufferPointer;
  GetMem(pMeshMaterials, sizeof(TD3DMATERIAL9) * dwNumMaterials);
  GetMem(pMeshTextures, sizeof(IDirect3DTexture9) * dwNumMaterials);
  ZeroMemory(pMeshTextures, sizeof(IDirect3DTexture9) * dwNumMaterials);
  i := 0;
  while (i < dwNumMaterials) do
  begin
    pMeshMaterials[i] := d3dxMaterials[i].MatD3D;
    pMeshMaterials[i].Ambient := pMeshMaterials[i].Diffuse;
    pMeshTextures[i] := nil;
    if (d3dxMaterials[i].pTextureFilename <> nil) and (StrLen(d3dxMaterials[i].pTextureFilename) > 0)
    then
    begin
      if FAILED(D3DXCreateTextureFromFile(ppiD3DDevice9, PWideChar(d3dxMaterials[i].pTextureFilename),
        pMeshTextures[i])) then
      begin
        StrLCopy(strTexture, strPrefix, MAX_PATH);
        StrLCopy(strTexture + lenPrefix, PWideChar(d3dxMaterials[i].pTextureFilename), MAX_PATH - lenPrefix);
        if FAILED(D3DXCreateTextureFromFile(ppiD3DDevice9, strTexture, pMeshTextures[i])) then
        begin
          MessageBox(0, 'Could not find texture map', '', MB_OK);
        end;
      end;
    end;
    Inc(i);
  end;
  pD3DXMtrlBuffer := nil;
  Result := dwNumMaterials;
end;

end.

