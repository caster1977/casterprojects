unit uTShipmentBSOList;

interface

uses
  uTDocuments;

type
  TShipmentBSOList = class sealed(TDocuments)
  public
    constructor Create; override; final;
  end;

implementation

uses
  uTShipmentBSO;

constructor TShipmentBSOList.Create;
begin
  inherited;
  ItemClass := TShipmentBSO;
end;

end.
