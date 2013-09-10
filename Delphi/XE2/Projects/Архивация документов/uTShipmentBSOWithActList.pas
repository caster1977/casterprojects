unit uTShipmentBSOWithActList;

interface

uses
  uTDocuments;

type
  TShipmentBSOWithActList = class sealed(TDocuments)
  protected
    function GetLoadSQL: string; override; final;
  public
    constructor Create; override; final;
  end;

implementation

uses
  uTShipmentBSOWithAct;

constructor TShipmentBSOWithActList.Create;
begin
  inherited;
  ItemClass := TShipmentBSOWithAct;
end;

function TShipmentBSOWithActList.GetLoadSQL: string;
begin
  Result := 'SELECT ...';
end;

end.
