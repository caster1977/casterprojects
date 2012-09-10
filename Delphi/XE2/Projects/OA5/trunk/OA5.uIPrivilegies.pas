unit OA5.uIPrivilegies;

interface

type
  IPrivilegies = interface
    ['{8591B178-CA0E-455E-A823-9C21A34B118F}']
    function GetAccount: Boolean;
    function GetClear: Boolean;
    function GetEdit: Boolean;
    function GetReport: Boolean;
    procedure SetAccount(const Value: Boolean);
    procedure SetClear(const Value: Boolean);
    procedure SetEdit(const Value: Boolean);
    procedure SetReport(const Value: Boolean);
    property Edit: Boolean read GetEdit write SetEdit;
    property Clear: Boolean read GetClear write SetClear;
    property Account: Boolean read GetAccount write SetAccount;
    property Report: Boolean read GetReport write SetReport;
  end;

implementation

end.
