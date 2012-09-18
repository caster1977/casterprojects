unit OA5.uTPhone;

interface

uses
  System.Classes,
  OA5.uICustomPhone;

type
  TPhone = class(TInterfacedPersistent)
  strict private
    FPhone: ICustomPhone;
    function GetTypeName: string;
  public
    constructor Create(const APhone: ICustomPhone);
    property TypeName: string read GetTypeName nodefault;
  end;

implementation

uses
  OA5.uTCustomPhone,
  OA5.uTUnknownPhone,
  OA5.uTStationaryPhone,
  OA5.uTMobilePhone,
  System.SysUtils;

constructor TPhone.Create(const APhone: ICustomPhone);
begin
  FPhone := APhone;
  if not Assigned(FPhone) then
  begin
    FPhone := GetUnknownPhoneAsICustomPhone;
  end;
end;

// Минская ГТС (город и пригород - 80172xxxxxx, 80173xxxxxx, 80175xxxxxx)
// Минская область, (017, за исключением теоефонов филиала "Минская ГТС")
// Гродненская область (015)
// Брестская область (016)
// Витебская область (021)
// Могилёвская область (022)
// Гомельская область (023)
// МЦС (80291xxxxxx, 80293xxxxxx, 80296xxxxxx, 80299xxxxxx, 8044xxxxxxx)
// МТС (80292xxxxxx, 80295xxxxxx, 80297xxxxxx, 80298xxxxxx, 8033xxxxxxx)
// БеСТ (80255xxxxxx, 80256xxxxxx, 80257xxxxxx, 80259xxxxxx)
// БелСел (80294xxxxxx)

function TPhone.GetTypeName: string;
begin
  Result := EmptyStr;
  if Assigned(FPhone) then
  begin
    Result := FPhone.PhoneTypeToString;
  end;
end;

initialization

begin
  RegisterClass(TPhone);
end;

end.
