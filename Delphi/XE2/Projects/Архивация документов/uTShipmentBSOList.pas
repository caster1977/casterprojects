unit uTShipmentBSOList;

interface

uses
  uTDocuments;

type
  TShipmentBSOList = class sealed(TDocuments)
  protected
    function GetLoadSQL: string; override; final;
  public
    constructor Create; reintroduce; virtual; final;
  end;

implementation

uses
  uTShipmentBSO;

constructor TShipmentBSOList.Create;
begin
  inherited Create(TShipmentBSO);
end;

function TShipmentBSOList.GetLoadSQL: string;
begin
  Result := 'SELECT ...';
end;

end.
