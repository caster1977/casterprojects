unit DBUShared.uISQLAction;

interface

uses
  System.Classes;

type
  ISQLAction = interface
    ['{4AB1153F-8552-4EE1-9864-3873D7935F8A}']
    function GetName: string;
    procedure SetName(const AValue: string);
    property name: string read GetName write SetName;

    function GetAbbreviation: string;
    procedure SetAbbreviation(const AValue: string);
    property Abbreviation: string read GetAbbreviation write SetAbbreviation;

    function ToString: string;
  end;

implementation

end.
