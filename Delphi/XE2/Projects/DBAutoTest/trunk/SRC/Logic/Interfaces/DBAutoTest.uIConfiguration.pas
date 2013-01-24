unit DBAutoTest.uIConfiguration;

interface

uses
  System.IniFiles,
  CastersPackage.uIIniFileDataStorage;

type
  IConfiguration = interface(IIniFileDataStorage)
    ['{ADD776D2-4F6E-42D3-B5DD-8565A2910226}']
    function GetEnablePlaySoundOnComplete: Boolean;
    function GetEnableQuitConfirmation: Boolean;
    function GetEnableSplashAtStart: Boolean;
    function GetEnableStatusbar: Boolean;
    function GetEnableToolbar: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    procedure SetEnableStatusbar(const AValue: Boolean);
    procedure SetEnableToolbar(const AValue: Boolean);
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete write SetEnablePlaySoundOnComplete;
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation write SetEnableQuitConfirmation;
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart;
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar;
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar;
  end;

implementation

end.
