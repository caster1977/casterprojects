unit TAPEstimator.uETAPWrongSymbol;

interface

uses
  System.SysUtils;

type
  ETAPWrongSymbol = class(Exception)
  public
    constructor Create(const AMsg: string; const ASymbol: Char); reintroduce; virtual;
  strict private
    function GetSymbol: Char;
  public
    FSymbol: Char;
    property Symbol: Char read GetSymbol;
  end;

implementation

constructor ETAPWrongSymbol.Create(const AMsg: string; const ASymbol: Char);
begin
  FSymbol := ASymbol;
  inherited Create(Format(AMsg, [ASymbol]));
end;

function ETAPWrongSymbol.GetSymbol: Char;
begin
  Result := FSymbol;
end;

end.
