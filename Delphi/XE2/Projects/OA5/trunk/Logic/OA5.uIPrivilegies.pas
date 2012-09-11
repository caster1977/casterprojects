unit OA5.uIPrivilegies;

interface

type
  IPrivilegies = interface
    ['{8591B178-CA0E-455E-A823-9C21A34B118F}']
    function GetAccounting: Boolean;
    function GetClearing: Boolean;
    function GetEditing: Boolean;
    function GetReporting: Boolean;
    procedure SetAccounting(const AValue: Boolean);
    procedure SetClearing(const AValue: Boolean);
    procedure SetEditing(const AValue: Boolean);
    procedure SetReporting(const AValue: Boolean);
    property Accounting: Boolean read GetAccounting write SetAccounting;
    property Clearing: Boolean read GetClearing write SetClearing;
    property Editing: Boolean read GetEditing write SetEditing;
    property Reporting: Boolean read GetReporting write SetReporting;
  end;

implementation

end.
