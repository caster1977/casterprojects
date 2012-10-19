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
  RsCantAddSignalToSignalList = 'Ќе удалось добавить сигнал в список сигналов!';
  RsCantRemoveSignalFromSignalList = 'Ќе удалось удалить сигнал из списка сигналов!';

procedure TSignalList.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddSignalToSignalList;
  RemoveItemErrorString := RsCantRemoveSignalFromSignalList;
end;

end.
