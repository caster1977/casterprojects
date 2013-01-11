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

function GetISignalList: ISignalList;

implementation

uses
  Beeper.uTSignal;

resourcestring
  RsCantAddSignalToSignalList = 'Ќе удалось добавить сигнал в список сигналов!';
  RsCantRemoveSignalFromSignalList = 'Ќе удалось удалить сигнал из списка сигналов!';

function GetISignalList: ISignalList;
begin
  Result := TSignalList.Create;
end;

procedure TSignalList.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddSignalToSignalList;
  RemoveItemErrorString := RsCantRemoveSignalFromSignalList;
end;

end.
