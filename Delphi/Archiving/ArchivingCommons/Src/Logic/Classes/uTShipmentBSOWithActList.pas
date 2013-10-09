unit uTShipmentBSOWithActList;

interface

uses
  DB,
  uTArchiveDocumentList;

type
  TShipmentBSOWithActList = class {$IFNDEF VER150} sealed {$ENDIF}(TArchiveDocumentList)
  public
    constructor Create(const AConnection: TCustomConnection); override; {$IFNDEF VER150} final; {$ENDIF}
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
