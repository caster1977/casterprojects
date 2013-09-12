unit uTDamagedBSOList;

interface

uses
  uTArchiveDocumentList;

type
  TDamagedBSOList = class sealed(TArchiveDocumentList)
  public
    constructor Create; reintroduce; virtual; final;
  end;

implementation

uses
  uTDamagedBSOItem;

constructor TDamagedBSOList.Create;
begin
  inherited;
  ItemClass := TDamagedBSOItem;
end;

end.
