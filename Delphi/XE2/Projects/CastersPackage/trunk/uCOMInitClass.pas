unit uCOMInitClass;

interface

uses
  ActiveX;

type
  TCOMInitClass=class(TInterfacedObject, IUnknown)
  strict private
    NeedToUninitialize: Boolean;
  public
    constructor Create(const CO_INIT: integer=COINIT_MULTITHREADED+COINIT_SPEED_OVER_MEMORY);
    destructor Destroy; override;
  end;

function NewCOMInitClass(const CO_INIT: integer=COINIT_MULTITHREADED+COINIT_SPEED_OVER_MEMORY): IUnknown;

implementation

function NewCOMInitClass(const CO_INIT: integer=COINIT_MULTITHREADED+COINIT_SPEED_OVER_MEMORY): IUnknown;
begin
  Result:=TCOMInitClass.Create(CO_INIT) as IUnknown;
end;

{ TCOMInitClass }

constructor TCOMInitClass.Create(const CO_INIT: integer=COINIT_MULTITHREADED+COINIT_SPEED_OVER_MEMORY);
begin
  inherited Create;
  NeedToUninitialize:=Succeeded(CoInitializeEx(nil, CO_INIT));
end;

destructor TCOMInitClass.Destroy;
begin
  if NeedToUninitialize then
    CoUninitialize();
  inherited;
end;

end.
