program SharedMemoryCOMApplication;

uses
  Winapi.Windows,
  Winapi.Messages,
  Winapi.ActiveX,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IOUtils;

type
  ISharedMemoryCOM=interface
    ['{ECCCF7AA-A2AC-4FFE-9A2C-8CD240474640}']
    function GetSharedMemoryName: WideString;
  end;

  TSharedMemoryCOM=class(TInterfacedObject, ISharedMemoryCOM)
  strict private
    NeedToUninitialize: Boolean;
  public
    constructor Create(const CO_INIT: integer=COINIT_MULTITHREADED+COINIT_SPEED_OVER_MEMORY);
    destructor Destroy; override;
    function GetSharedMemoryName: WideString;
  end;

{$R *.res}

function NewSharedMemoryCOM(const CO_INIT: integer=COINIT_MULTITHREADED+COINIT_SPEED_OVER_MEMORY): IUnknown;
begin
  Result:=TSharedMemoryCOM.Create(CO_INIT) as IUnknown;
end;

{ TSharedMemoryCOM }

constructor TSharedMemoryCOM.Create(const CO_INIT: integer);
begin
  inherited Create;
  NeedToUninitialize:=Succeeded(CoInitializeEx(nil, CO_INIT));
end;

destructor TSharedMemoryCOM.Destroy;
begin
  if NeedToUninitialize then
    CoUninitialize();
  inherited;
end;

function TSharedMemoryCOM.GetSharedMemoryName: WideString;
begin
  Result:=TPath.GetGUIDFileName(False);
  // Result:=TPath.GetRandomFileName;
  // Result:=TPath.GetTempFileName;
end;

begin
  NewSharedMemoryCOM;

end.
