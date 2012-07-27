unit Beeper.uIConfiguration;

interface

uses
  System.IniFiles,
  CastersPackage.uIIniFileDataStorage,
  Beeper.uISignalList;

type
  IConfiguration = interface(IIniFileDataStorage)
    ['{C6590F16-FD1C-4F10-AF66-F5AA590C5494}']
    procedure Initialize;

    function GetSoundEnabled: Boolean;
    procedure SetSoundEnabled(const AValue: Boolean);

    function GetModifierOff: Integer;
    procedure SetModifierOff(const AValue: Integer);

    function GetModifierOn: Integer;
    procedure SetModifierOn(const AValue: Integer);

    function GetVirtualKeyOff: Cardinal;
    procedure SetVirtualKeyOff(const AValue: Cardinal);

    function GetVirtualKeyOn: Cardinal;
    procedure SetVirtualKeyOn(const AValue: Cardinal);

    function GetSignalList: ISignalList;
    procedure SetSignalList(const AValue: ISignalList);

    function GetShowBaloonHints: Boolean;
    procedure SetShowBaloonHints(const AValue: Boolean);

    property ShowBaloonHints: Boolean read GetShowBaloonHints write SetShowBaloonHints;
    property SoundEnabled: Boolean read GetSoundEnabled write SetSoundEnabled;
    property ModifierOff: Integer read GetModifierOff write SetModifierOff;
    property ModifierOn: Integer read GetModifierOn write SetModifierOn;
    property VirtualKeyOff: Cardinal read GetVirtualKeyOff write SetVirtualKeyOff;
    property VirtualKeyOn: Cardinal read GetVirtualKeyOn write SetVirtualKeyOn;
    property SignalList: ISignalList read GetSignalList write SetSignalList;
  end;

implementation

end.
