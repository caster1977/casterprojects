unit OA5.uTPhone;

interface

uses
  System.Classes;

const
  DEFAULT_PHONE_TYPE = 0;

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

type
 TPhone = class(TInterfacedPersistent)
  {strict private
    function GetType: TPhoneType;
    procedure SetType(const AValue: TPhoneType);
  publiс
    property Number: string read GetNumber write SetNumber nodefault;
    property Type_: TPhoneType read GetType write SetType default DEFAULT_PHONE_TYPE;}
 end;

implementation

initialization

begin
  RegisterClass(TPhone);
end;

end.
