unit uTShowableField;

interface

uses
  uIShowableField;

type
  TShowableField = class(TInterfacedObject, IShowableField)
  private
    FName: string;
    function GetName: string;
    procedure SetName(const AValue: string);
  public
    property Name: string read GetName write SetName nodefault;

  private
    FCaption: string;
    function GetCaption: string;
    procedure SetCaption(const AValue: string);
  public
    property Caption: string read GetCaption write SetCaption nodefault;

  public
    constructor Create(const ACaption, AName: string); reintroduce;
  end;

implementation

uses
  SysUtils;

constructor TShowableField.Create(const ACaption, AName: string);
begin
  name := AName;
  Caption := ACaption;
end;

function TShowableField.GetCaption: string;
begin
  Result := FCaption;
end;

function TShowableField.GetName: string;
begin
  Result := FName;
end;

procedure TShowableField.SetCaption(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCaption <> s then
  begin
    FCaption := s;
  end;
end;

procedure TShowableField.SetName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FName <> s then
  begin
    FName := s;
  end;
end;

end.
