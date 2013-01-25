unit OA5.uConsts;

interface

uses
  OA5.uTPhoneTypes,
  OA5.uTStationaryProviders,
  OA5.uTMobileProviders,
  OA5.uResourceStrings;

const
  PHONE_TYPES: array [low(TPhoneTypes) .. high(TPhoneTypes)] of string = (RsUnknown,
    RsPhoneTypeStationary, RsPhoneTypeMobile);
  PHONE_STATIONARY_PROVIDERS: array [low(TStationaryProviders) .. high(TStationaryProviders)
    ] of string = (RsUnknown, RsMGTS, RsMinskArea, RsGrodnoArea, RsBrestArea, RsVitebskArea,
    RsMogilevArea, RsGomelArea);
  PHONE_MOBILE_PROVIDERS: array [low(TMobileProviders) .. high(TMobileProviders)
    ] of string = (RsUnknown, RsProviderMTS, RsProviderMCS, RsProviderBelSel, RsProviderBeST);

  PHONE_PREFIXES_MTS = ['1', '2'];

implementation

end.
