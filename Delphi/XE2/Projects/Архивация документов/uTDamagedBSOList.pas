unit uTDamagedBSOList;

interface

uses
  DB,
  uTArchiveDocumentList;

type
  TDamagedBSOList = class sealed(TArchiveDocumentList)
  public
    constructor Create(const AConnection: TCustomConnection); override; final;
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
