unit uTShipmentBSOWithActList;

interface

uses
  uTDocuments;

type
  TShipmentBSOWithActList = class sealed(TDocuments)
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

end.
