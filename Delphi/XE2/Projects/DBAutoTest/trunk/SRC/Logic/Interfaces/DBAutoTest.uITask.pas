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
    property Name: string read GetName write SetName;

    function GetSQL: TStringList;
    procedure SetSQL(const AValue: TStringList);
    property SQL: TStringList read GetSQL write SetSQL;

    function GetStatus: TTaskStatus;
    procedure SetStatus(const AValue: TTaskStatus);
    property Status: TTaskStatus read GetStatus write SetStatus;

    function GetStartTime: TDateTime;
    procedure SetStartTime(const AValue: TDateTime);
    property StartTime: TDateTime read GetStartTime write SetStartTime;

    function GetStopTime: TDateTime;
    procedure SetStopTime(const AValue: TDateTime);
    property StopTime: TDateTime read GetStopTime write SetStopTime;

    function GetTime: TTime;
    property Time: TTime read GetTime;
  end;

implementation

end.
