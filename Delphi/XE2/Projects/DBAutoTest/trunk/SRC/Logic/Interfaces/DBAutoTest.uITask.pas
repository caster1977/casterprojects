unit DBAutoTest.uITask;

interface

uses
  System.Classes;

type
  ITask = interface
    ['{F336E692-7815-4511-B0C9-71E310602CF0}']
    procedure Run;
    function GetEnabled: Boolean;
    function GetGroup: string;
    function GetName: string;
    function GetSQL: TStringList;
    procedure SetEnabled(const AValue: Boolean);
    procedure SetGroup(const AValue: string);
    procedure SetName(const AValue: string);
    procedure SetSQL(const AValue: TStringList);
    property Group: string read GetGroup write SetGroup;
    property name: string read GetName write SetName;
    property SQL: TStringList read GetSQL write SetSQL;
    property Enabled: Boolean read GetEnabled write SetEnabled;
  end;

implementation

end.
