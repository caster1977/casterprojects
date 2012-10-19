unit Beeper.uTSignalList;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  Beeper.uISignalList,
  Beeper.uISignal;

type
  TSignalList = class(TInterfaceListOfGivenType<ISignal>, ISignalList)
  protected
    procedure Initialize; override;
  end;

implementation

resourcestring
  RsCantAddSignalToSignalList = '�� ������� �������� ������ � ������ ��������!';
  RsCantRemoveSignalFromSignalList = '�� ������� ������� ������ �� ������ ��������!';

procedure TSignalList.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddSignalToSignalList;
  RemoveItemErrorString := RsCantRemoveSignalFromSignalList;
end;

end.
