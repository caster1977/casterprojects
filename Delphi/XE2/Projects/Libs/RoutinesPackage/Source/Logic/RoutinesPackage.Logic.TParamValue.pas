unit RoutinesPackage.Logic.TParamValue;

interface

uses
  Data.DB;

type
  TParamValue = record
  public
    Value: Variant;
    ValueType: TFieldType;
    class function Create(const aValue: Variant): TParamValue; overload; static; inline;
    class function Create(const aValue: Variant; aValueType: TFieldType): TParamValue; overload; static; inline;
  end;

implementation

class function TParamValue.Create(const aValue: Variant): TParamValue;
begin
  Result := Create(aValue, ftUnknown);
end;

class function TParamValue.Create(const aValue: Variant; aValueType: TFieldType): TParamValue;
begin
  Result.Value := aValue;
  Result.ValueType := aValueType;
end;

end.
