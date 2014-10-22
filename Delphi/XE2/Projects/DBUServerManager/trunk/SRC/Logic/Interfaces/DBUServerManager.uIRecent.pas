unit DBUServerManager.uIRecent;

interface

uses
  System.Classes;

type
  IRecent = interface
    ['{6907C26B-DFD1-4521-904F-360D96FA2623}']
    function GetExists: Boolean;
    property Exists: Boolean read GetExists;

    function GetFullName: string;
    procedure SetFullName(const AValue: string);
    property FullName: string read GetFullName write SetFullName;

    function GetShortName: string;
    property ShortName: string read GetShortName;
  end;

implementation

end.
