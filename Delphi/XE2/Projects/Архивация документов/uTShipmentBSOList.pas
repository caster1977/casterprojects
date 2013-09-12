unit uTShipmentBSOList;

interface

uses
  uTArchiveDocumentList;

type
  TShipmentBSOList = class sealed(TArchiveDocumentList)
  public
    constructor Create; override; final;
  end;

implementation

uses
  uTShipmentBSOItem;

constructor TShipmentBSOList.Create;
begin
  inherited;
  ItemClass := TShipmentBSOItem;
end;

end.
