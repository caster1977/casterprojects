unit uTDamagedBSOList;

interface

uses
  uTDocuments;

type
  TDamagedBSOList = class sealed(TDocuments)
  public
    constructor Create; reintroduce; virtual; final;
  end;

implementation

uses
  uTDamagedBSO;

constructor TDamagedBSOList.Create;
begin
  inherited;
  ItemClass := TDamagedBSO;
end;

end.
