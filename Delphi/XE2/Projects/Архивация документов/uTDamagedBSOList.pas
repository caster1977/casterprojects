unit uTDamagedBSOList;

interface

uses
  uTDocuments;

type
  TDamagedBSOList = class sealed(TDocuments)
  protected
    function GetLoadSQL: string; override; final;
  public
    constructor Create; reintroduce; virtual; final;
  end;

implementation

uses
  uTDamagedBSO;

constructor TDamagedBSOList.Create;
begin
  inherited Create(TDamagedBSO);
end;

function TDamagedBSOList.GetLoadSQL: string;
begin
  Result := 'SELECT ...';
end;

end.
