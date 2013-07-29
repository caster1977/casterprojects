unit TAPEstimator.Configuration.uTRecents;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  TAPEstimator.Configuration.uIRecents,
  TAPEstimator.Configuration.uIRecent;

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
  RsCantAddRecentToRecents =
    '�� ������� �������� ����� �������� ���� � ������ ����� �������� ������.';
  RsCantRemoveRecentFromRecents =
    '�� ������� ������� ����� �������� ���� �� ������ ����� �������� ������.';

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

end.
