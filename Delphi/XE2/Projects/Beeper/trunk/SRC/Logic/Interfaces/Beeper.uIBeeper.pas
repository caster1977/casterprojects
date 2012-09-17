unit Beeper.uIBeeper;

interface

type
  IBeeper = interface
    ['{6AE9248D-648A-4426-8735-D5652AFBA86B}']
    procedure ShowError;
    function StartSession: boolean;
    function StopSession: boolean;
    procedure SendActivationSignal;
  end;

implementation

end.
