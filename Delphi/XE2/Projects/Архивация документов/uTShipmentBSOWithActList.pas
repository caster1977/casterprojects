unit uTShipmentBSOWithActList;

interface

uses
  uTArchiveDocumentList;

type
  TShipmentBSOWithActList = class sealed(TArchiveDocumentList)
  public
    constructor Create; override; final;
  end;

implementation

uses
  uTShipmentBSOWithActItem;

constructor TShipmentBSOWithActList.Create;
begin
  inherited;
  ItemClass := TShipmentBSOWithActItem;
end;

end.
