unit CastersPackage.uTAddress;

interface

uses
  CastersPackage.uINormalized;

type
  TAddress = class(TInterfacedObject, INormalized)
  private
    FAddress: string;
    function GetAddress: string;
    property Address: string read GetAddress nodefault;
  private
    function GetAutoNormalizeData: Boolean;
    procedure SetAutoNormalizeData(const AValue: Boolean);
    property AutoNormalizeData: Boolean read GetAutoNormalizeData write SetAutoNormalizeData;
  private
    function IsNormalized: Boolean;
    procedure Normalize; overload; virtual; final;
    class function Normalize(const AAddress: string): string; overload; virtual; abstract;
  public
    class function Validate(const AAddress: string): Boolean; virtual; abstract;
    function IsValid: Boolean; virtual; final;
    constructor Create(const AAddress: string); virtual;
  end;

//  TEMailAddress = class(TAddress)
//  protected
//    class function Normalize(const AAddress: string): string; override;
//  public
//    class function Validate(const AAddress: string): Boolean; override;
//  end;
//
//  TWWWAddress = class(TAddress)
//  protected
//    class function Normalize(const AAddress: string): string; override;
//  public
//    class function Validate(const AAddress: string): Boolean; override;
//  end;

implementation

constructor TAddress.Create(const AAddress: string);
begin

  FAddress := Normalize(AAddress);
end;

function TAddress.GetAddress: string;
begin
  Result := FAddress;
end;

function TAddress.GetAutoNormalizeData: Boolean;
begin

end;

function TAddress.IsNormalized: Boolean;
begin

end;

function TAddress.IsValid: Boolean;
begin
  Result := Validate(Address);
end;

procedure TAddress.Normalize;
begin
  FAddress := Normalize(Address);
end;

procedure TAddress.SetAutoNormalizeData(const AValue: Boolean);
begin

end;

end.
