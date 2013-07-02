unit Unit2;

interface

uses
  ConfigPackage.uTCustomOptions,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute;

type

  [TSection('Proxy')]
  TProxyOptions = class(TCustomOptions)
  public
    [TDefaultValue('proxy.example.com')]
    property ProxyField: string index 0 read GetStringValue write SetStringValue;
    [TDefaultValue(80)]
    property PortField: Integer index 1 read GetIntegerValue write SetIntegerValue;
    [TDefaultValue(True)]
    property Active: Boolean index 2 read GetBooleanValue write SetBooleanValue;
  end;

implementation

end.
