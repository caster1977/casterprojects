unit Beeper.uISignalList;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  Beeper.uISignal;

type
  ISignalList = interface(IInterfaceListOfGivenType<ISignal>)
    ['{D85F74EC-8C32-4132-9AAB-4F7BEF367ACE}']
  end;

function GetISignalList: ISignalList;

implementation

uses
  Beeper.uTSignalList;

function GetISignalList: ISignalList;
begin
  Result := TSignalList.Create;
end;

end.
