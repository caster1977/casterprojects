unit CastersPackage.uTCOMInitClass;

interface

uses
  ActiveX;

type
  TCOMInitClass = class(TInterfacedObject, IUnknown)
  strict private
    FNeedToUninitialize: Boolean;
  public
    constructor Create(const ACoInit: Integer = COINIT_MULTITHREADED + COINIT_SPEED_OVER_MEMORY);
    destructor Destroy; override;
  end;

function NewCOMInitClass(const ACoInit: Integer = COINIT_MULTITHREADED + COINIT_SPEED_OVER_MEMORY): IUnknown;

implementation

function NewCOMInitClass(const ACoInit: Integer = COINIT_MULTITHREADED + COINIT_SPEED_OVER_MEMORY): IUnknown;
begin
  Result := TCOMInitClass.Create(ACoInit);
end;

constructor TCOMInitClass.Create(const ACoInit: Integer = COINIT_MULTITHREADED + COINIT_SPEED_OVER_MEMORY);
begin
  inherited Create;
  FNeedToUninitialize := Succeeded(CoInitializeEx(nil, ACoInit));
end;

destructor TCOMInitClass.Destroy;
begin
  if FNeedToUninitialize then
  begin
    CoUninitialize;
  end;
  inherited;
end;

end.
