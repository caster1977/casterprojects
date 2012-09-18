unit OA5.uTMobilePhone;

interface

uses
  OA5.uTCustomPhone,
  OA5.uTPhoneTypes,
  OA5.uTMobileProviders,
  OA5.uICustomPhone;

type
  TMobilePhone = class(TCustomPhone)
  private
    FProvider: TMobileProviders;
    function GetProvider: TMobileProviders;
    procedure SetProvider(const AValue: TMobileProviders);
  public
    constructor Create; override;
    function PhoneTypeToString: string; override;
    property Provider: TMobileProviders read GetProvider write SetProvider default mpUnknown;
  end;

function GetMobilePhoneAsICustomPhone: ICustomPhone;

implementation

uses
  System.SysUtils,
  OA5.uResourceStrings,
  OA5.uConsts;

function GetMobilePhoneAsICustomPhone: ICustomPhone;
begin
  Result := TMobilePhone.Create;
end;

constructor TMobilePhone.Create;
begin
  inherited Create(ptMobile);
  Provider := mpUnknown;
end;

function TMobilePhone.GetProvider: TMobileProviders;
begin
  Result := FProvider;
end;

function TMobilePhone.PhoneTypeToString: string;
begin
  Result := inherited + Format(RsPhoneTypeSuffix, [PHONE_MOBILE_PROVIDERS[Provider]])
end;

procedure TMobilePhone.SetProvider(const AValue: TMobileProviders);
begin
  if FProvider <> AValue then
  begin
    FProvider := AValue;
  end;
end;

end.
