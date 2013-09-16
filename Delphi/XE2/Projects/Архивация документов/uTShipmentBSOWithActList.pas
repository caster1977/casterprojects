unit uTShipmentBSOWithActList;

interface

uses
  DB,
  uTArchiveDocumentList;

type
  TShipmentBSOWithActList = class sealed(TArchiveDocumentList)
  public
    constructor Create(const AConnection: TCustomConnection); override; final;
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
