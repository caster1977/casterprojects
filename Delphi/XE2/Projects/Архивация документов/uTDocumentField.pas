unit uTDocumentField;

interface

uses
  uIDocumentField;

type
  TDocumentField = class(TInterfacedObject, IDocumentField)
  private
    FName: string;
    function GetName: string;
    procedure SetName(const AValue: string);
  public
    property name: string read GetName write SetName nodefault;
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

constructor TDocumentField.Create(const ACaption, AName: string);
begin
  name := AName;
  Caption := ACaption;
end;

function TDocumentField.GetCaption: string;
begin
  Result := FCaption;
end;

function TDocumentField.GetName: string;
begin
  Result := FName;
end;

procedure TDocumentField.SetCaption(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FCaption <> s then
  begin
    FCaption := s;
  end;
end;

procedure TDocumentField.SetName(const AValue: string);
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
