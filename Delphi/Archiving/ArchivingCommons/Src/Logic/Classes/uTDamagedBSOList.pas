unit uTDamagedBSOList;

interface

uses
  DB,
  uTArchiveDocumentList;

type
  TDamagedBSOList = class {$IFNDEF VER150} sealed {$ENDIF}(TArchiveDocumentList)
  public
    constructor Create(const AConnection: TCustomConnection); override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  uTDamagedBSOItem;

constructor TDamagedBSOList.Create(const AConnection: TCustomConnection);
begin
  inherited;
  ItemClass := TDamagedBSOItem;
end;

end.
