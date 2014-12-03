unit DBUShared.uIDatabaseType;

interface

uses
  System.Classes;

type
  IDatabaseType = interface
    ['{8846C8D7-5A96-45B1-B1D6-048D35D98EA8}']
    function GetId: Integer;
    procedure SetId(const AValue: Integer);
    property Id: Integer read GetId write SetId;

    function GetName: string;
    procedure SetName(const AValue: string);
    property Name: string read GetName write SetName;

    function ToString: string;
  end;

implementation

end.
