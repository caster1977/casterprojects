unit OA5.uTUnknownPhone;

interface

uses
  OA5.uTCustomPhone,
  OA5.uTPhoneTypes,
  OA5.uICustomPhone;

type
  TUnknownPhone = class(TCustomPhone)
  end;

function GetUnknownPhoneAsICustomPhone: ICustomPhone;

implementation

function GetUnknownPhoneAsICustomPhone: ICustomPhone;
begin
  Result := TUnknownPhone.Create;
end;

end.
