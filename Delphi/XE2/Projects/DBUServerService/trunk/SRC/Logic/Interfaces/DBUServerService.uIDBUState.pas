unit DBUServerService.uIDBUState;

interface

uses
  System.Classes,
  Vcl.Graphics;

type
  IDBUState = interface
    ['{807F01DF-7C0F-421C-9631-0B8C41F42C80}']
    function GetId: Integer;
    procedure SetId(const AValue: Integer);
    property Id: Integer read GetId write SetId;

    function GetName: string;
    procedure SetName(const AValue: string);
    property Name: string read GetName write SetName;

    function GetFlags: Word;
    procedure SetFlags(const AValue: Word);
    property Flags: Word read GetFlags write SetFlags;

    function GetIcon: TIcon;
    procedure SetIcon(const AValue: TIcon);
    property Icon: TIcon read GetIcon write SetIcon;

    function ToString: string;
  end;

implementation

end.
