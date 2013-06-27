unit DBAutoTest.uIConfigurationProperties;

interface

type
  IConfigurationProperties = interface
    ['{D92A2CAD-4E06-4F6B-BEB7-650B21F6007F}']
    function GetEnablePlaySoundOnComplete: Boolean;
    procedure SetEnablePlaySoundOnComplete(const AValue: Boolean);
    property EnablePlaySoundOnComplete: Boolean read GetEnablePlaySoundOnComplete write SetEnablePlaySoundOnComplete;

    function GetEnableQuitConfirmation: Boolean;
    procedure SetEnableQuitConfirmation(const AValue: Boolean);
    property EnableQuitConfirmation: Boolean read GetEnableQuitConfirmation write SetEnableQuitConfirmation;

    function GetEnableSplashAtStart: Boolean;
    procedure SetEnableSplashAtStart(const AValue: Boolean);
    property EnableSplashAtStart: Boolean read GetEnableSplashAtStart write SetEnableSplashAtStart;

    function GetEnableStatusbar: Boolean;
    procedure SetEnableStatusbar(const AValue: Boolean);
    property EnableStatusbar: Boolean read GetEnableStatusbar write SetEnableStatusbar;

    function GetEnableToolbar: Boolean;
    procedure SetEnableToolbar(const AValue: Boolean);
    property EnableToolbar: Boolean read GetEnableToolbar write SetEnableToolbar;

    function GetEnableStoreMainFormSizesAndPosition: Boolean;
    procedure SetEnableStoreMainFormSizesAndPosition(const AValue: Boolean);
    property EnableStoreMainFormSizesAndPosition: Boolean read GetEnableStoreMainFormSizesAndPosition write SetEnableStoreMainFormSizesAndPosition;

    function GetEnableGenerateExcelDocument: Boolean;
    procedure SetEnableGenerateExcelDocument(const AValue: Boolean);
    property EnableGenerateExcelDocument: Boolean read GetEnableGenerateExcelDocument write SetEnableGenerateExcelDocument;

    function GetEnableGenerateFastReportDocument: Boolean;
    procedure SetEnableGenerateFastReportDocument(const AValue: Boolean);
    property EnableGenerateFastReportDocument: Boolean read GetEnableGenerateFastReportDocument write SetEnableGenerateFastReportDocument;
  end;

implementation

end.
