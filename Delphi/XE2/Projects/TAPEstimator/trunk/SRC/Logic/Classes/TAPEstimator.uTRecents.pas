unit TAPEstimator.uTRecents;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  TAPEstimator.uIRecents,
  TAPEstimator.uIRecent;

type
  TRecents = class(TInterfaceListOfGivenType<IRecent>, IRecents)
  strict protected
    procedure Initialize; override;
  end;

function GetIRecents: IRecents;

implementation

uses
  System.Classes;

resourcestring
  RsCantAddRecentToRecents = '�� ������� �������� ����� �������� ���� � ������ ����� �������� ������.';
  RsCantRemoveRecentFromRecents = '�� ������� ������� ����� �������� ���� �� ������ ����� �������� ������.';

function GetIRecents: IRecents;
begin
  Result := TRecents.Create;
end;

procedure TRecents.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddRecentToRecents;
  RemoveItemErrorString := RsCantRemoveRecentFromRecents;
end;

initialization

begin
  RegisterClass(TRecents);
end;

end.
