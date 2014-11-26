unit DBUShared.uIDBUServerLogRecord;

interface

uses
  System.Classes;

type
  IDBUServerLogRecord = interface
    ['{0DFB9136-F30F-46B1-8E81-E66ECDB4D6FA}']
    function GetDateTime: TDateTime;
    procedure SetDateTime(const AValue: TDateTime);
    property DateTime: TDateTime read GetDateTime write SetDateTime;

    function GetDatabaseType: string;
    procedure SetDatabaseType(const AValue: string);
    property DatabaseType: string read GetDatabaseType write SetDatabaseType;

    function GetCreator: string;
    procedure SetCreator(const AValue: string);
    property Creator: string read GetCreator write SetCreator;

    function GetFirstNumber: Integer;
    procedure SetFirstNumber(const AValue: Integer);
    property FirstNumber: Integer read GetFirstNumber write SetFirstNumber;

    function GetQuantity: Integer;
    procedure SetQuantity(const AValue: Integer);
    property Quantity: Integer read GetQuantity write SetQuantity;

    function ToString: string;
  end;

implementation

end.
