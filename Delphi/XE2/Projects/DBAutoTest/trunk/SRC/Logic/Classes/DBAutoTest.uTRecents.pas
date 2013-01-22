unit DBAutoTest.uTRecents;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBAutoTest.uIRecents,
  DBAutoTest.uIRecent;

type
  TRecents = class(TInterfaceListOfGivenType<IRecent>, IRecents)
  protected
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
