unit DBUShared.uISQLSubject;

interface

uses
  System.Classes;

type
  ISQLSubject = interface
    ['{4AADE810-C9A7-4154-9A5F-9AE6A9DB5A9B}']
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
