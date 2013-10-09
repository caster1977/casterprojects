unit uTShipmentBSOList;

interface

uses
  DB,
  uTArchiveDocumentList;

type
  TShipmentBSOList = class {$IFNDEF VER150} sealed {$ENDIF}(TArchiveDocumentList)
  public
    constructor Create(const AConnection: TCustomConnection); override; {$IFNDEF VER150} final; {$ENDIF}
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
