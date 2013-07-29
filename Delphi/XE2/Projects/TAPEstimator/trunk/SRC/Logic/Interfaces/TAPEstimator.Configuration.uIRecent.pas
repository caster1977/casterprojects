unit TAPEstimator.Configuration.uIRecent;

interface

uses
  System.Classes;

type
  IRecent = interface
    ['{F723C4E9-F220-4B63-BCFE-3B7E5E5D6223}']
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
