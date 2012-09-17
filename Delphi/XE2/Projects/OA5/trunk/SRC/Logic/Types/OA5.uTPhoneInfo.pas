unit OA5.uTPhoneInfo;

interface

uses
  OA5.uTPhoneTypes,
  OA5.uTStationaryProviders,
  OA5.uTMobileProviders;

type
  TPhoneInfo = packed record
    case Provider: TPhoneTypes of
      ptUnknown:
        ();
      ptStationary:
        (Stationary: TStationaryProviders);
      ptMobile:
        (Mobile: TMobileProviders);
  end;

implementation

end.
