unit OA5.uTStationaryPhone;

interface

uses
  OA5.uTCustomPhone,
  OA5.uTPhoneTypes,
  OA5.uTStationaryProviders,
  OA5.uICustomPhone;

type
  TStationaryPhone = class(TCustomPhone)
  private
    FProvider: TStationaryProviders;
    function GetProvider: TStationaryProviders;
    procedure SetProvider(const AValue: TStationaryProviders);
  public
    constructor Create; override;
    function PhoneTypeToString: string; override;
    property Provider: TStationaryProviders read GetProvider write SetProvider nodefault;
  end;

function GetStationaryPhoneAsICustomPhone: ICustomPhone;

implementation

uses
  System.SysUtils,
  OA5.uResourceStrings,
  OA5.uConsts;

function GetStationaryPhoneAsICustomPhone: ICustomPhone;
begin
  Result := TStationaryPhone.Create;
end;

constructor TStationaryPhone.Create;
begin
  inherited Create(ptStationary);
  Provider := spUnknown;
end;

function TStationaryPhone.GetProvider: TStationaryProviders;
begin
  Result := FProvider;
end;

function TStationaryPhone.PhoneTypeToString: string;
begin
  Result := inherited + Format(RsPhoneTypeSuffix, [PHONE_STATIONARY_PROVIDERS[Provider]]);
end;

procedure TStationaryPhone.SetProvider(const AValue: TStationaryProviders);
begin
  if FProvider <> AValue then
  begin
    FProvider := AValue;
  end;
end;

end.
