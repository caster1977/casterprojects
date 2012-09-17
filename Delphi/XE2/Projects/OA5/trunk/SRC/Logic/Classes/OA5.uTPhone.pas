unit OA5.uTPhone;

interface

uses
  System.Classes;

const
  DEFAULT_PHONE_TYPE = 0;

// ������� ��� (����� � �������� - 80172xxxxxx, 80173xxxxxx, 80175xxxxxx)
// ������� �������, (017, �� ����������� ��������� ������� "������� ���")
// ����������� ������� (015)
// ��������� ������� (016)
// ��������� ������� (021)
// ���������� ������� (022)
// ���������� ������� (023)
// ��� (80291xxxxxx, 80293xxxxxx, 80296xxxxxx, 80299xxxxxx, 8044xxxxxxx)
// ��� (80292xxxxxx, 80295xxxxxx, 80297xxxxxx, 80298xxxxxx, 8033xxxxxxx)
// ���� (80255xxxxxx, 80256xxxxxx, 80257xxxxxx, 80259xxxxxx)
// ������ (80294xxxxxx)

type
 TPhone = class(TInterfacedPersistent)
  {strict private
    function GetType: TPhoneType;
    procedure SetType(const AValue: TPhoneType);
  publi�
    property Number: string read GetNumber write SetNumber nodefault;
    property Type_: TPhoneType read GetType write SetType default DEFAULT_PHONE_TYPE;}
 end;

implementation

initialization

begin
  RegisterClass(TPhone);
end;

end.
