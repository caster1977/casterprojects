unit uTShowableField;

interface

uses
  uIShowableField;

type
  TShowableField = class(TInterfacedObject, IShowableField)
  private
    FName: string;
    function GetName: string;
  public
    property Name: string read GetName nodefault;

  private
    FCaption: string;
    function GetCaption: string;
  public
    property Caption: string read GetCaption nodefault;

  private
    FValue: string;
    function GetValue: string;
  public
    property Value: string read GetValue nodefault;

  public
    constructor Create(const ACaption, AName, AValue: string); reintroduce;
  end;

implementation

uses
  SysUtils;

constructor TShowableField.Create(const ACaption, AName, AValue: string);
begin
  FName := Trim(AName);
  FCaption := Trim(ACaption);
  FValue := Trim(AValue);
end;

function TShowableField.GetCaption: string;
begin
  Result := FCaption;
end;

function TShowableField.GetName: string;
begin
  Result := FName;
end;

function TShowableField.GetValue: string;
begin
  Result := FValue;
end;

end.
