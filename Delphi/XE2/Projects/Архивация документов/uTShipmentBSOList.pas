unit uTShipmentBSOList;

interface

uses
  uTDocuments;

type
  TShipmentBSOList = class sealed(TDocuments)
  protected
    function GetLoadSQL: string; override; final;
  public
    constructor Create; override; final;
  end;

implementation

uses
  uTShipmentBSO;

constructor TShipmentBSOList.Create;
begin
  inherited;
  ItemClass := TShipmentBSO;
end;

function TShipmentBSOList.GetLoadSQL: string;
begin
  Result := 'SELECT ...';
end;

end.
