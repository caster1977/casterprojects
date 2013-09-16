unit uTShipmentBSOList;

interface

uses
  DB,
  uTArchiveDocumentList;

type
  TShipmentBSOList = class sealed(TArchiveDocumentList)
  public
    constructor Create(const AConnection: TCustomConnection); override; final;
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
