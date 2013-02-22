unit DBAutoTest.uITask;

interface

uses
  System.Classes,
  DBAutoTest.uTTaskStatus;

type
  ITask = interface
    ['{F336E692-7815-4511-B0C9-71E310602CF0}']
    function GetEnabled: Boolean;
    procedure SetEnabled(const AValue: Boolean);
    property Enabled: Boolean read GetEnabled write SetEnabled;

    function GetGroup: string;
    procedure SetGroup(const AValue: string);
    property Group: string read GetGroup write SetGroup;

    function GetName: string;
    procedure SetName(const AValue: string);
    property name: string read GetName write SetName;

    function GetSQL: TStringList;
    procedure SetSQL(const AValue: TStringList);
    property SQL: TStringList read GetSQL write SetSQL;

    function GetStatus: TTaskStatus;
    procedure SetStatus(const AValue: TTaskStatus);
    property Status: TTaskStatus read GetStatus write SetStatus;
  end;

implementation

end.
