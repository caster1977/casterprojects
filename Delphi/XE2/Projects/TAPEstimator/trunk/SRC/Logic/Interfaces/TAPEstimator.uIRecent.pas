unit TAPEstimator.uIRecent;

interface

uses
  System.Classes;

type
  IRecent = interface
    ['{F723C4E9-F220-4B63-BCFE-3B7E5E5D6223}']
    function GetExists: Boolean;
    function GetFullName: string;
    function GetShortName: string;
    procedure SetFullName(const AValue: string);
    property FullName: string read GetFullName write SetFullName;
    property ShortName: string read GetShortName;
    property Exists: Boolean read GetExists;
  end;

implementation

end.
