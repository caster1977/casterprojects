unit CastersPackage.uTStringGridEx;

interface

uses
  Vcl.Grids;

type
  TStringGridEx = class(TStringGrid)
  public
    procedure MoveRow(FromIndex, ToIndex: Longint);
  end;

procedure register;

implementation

uses
  System.Classes;

procedure register;
begin
  RegisterComponents('CasterComponents', [TStringGridEx]);
end;

procedure TStringGridEx.MoveRow(FromIndex, ToIndex: Integer);
begin
  inherited;
end;

end.
