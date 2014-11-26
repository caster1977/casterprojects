unit CastersPackage.uTStringGridEx;

interface

uses
  Vcl.Grids;

type
  TStringGridEx = class(TStringGrid)
  public
    procedure MoveRow(AFromIndex, AToIndex: Longint);
  end;

procedure register;

implementation

uses
  System.Classes;

procedure register;
begin
  RegisterComponents('CasterComponents', [TStringGridEx]);
end;

procedure TStringGridEx.MoveRow(AFromIndex, AToIndex: Integer);
begin
  inherited;
end;

end.
