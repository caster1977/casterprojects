unit DBUServerManager.uTRecents;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBUServerManager.uIRecents,
  DBUServerManager.uIRecent;

type
  TRecents = class(TInterfaceListOfGivenType<IRecent>, IRecents)
  strict protected
    procedure Initialize; override;
  end;

function GetIRecents: IRecents;

implementation

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
