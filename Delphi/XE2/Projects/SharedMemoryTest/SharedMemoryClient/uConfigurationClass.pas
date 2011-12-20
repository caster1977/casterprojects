unit uConfigurationClass;

interface

uses
  uCommonConfigurationClass;

type
  TConfigurationClass=class(TCommonConfigurationClass)
  public
    constructor Create(const IniFileName: string='');
    property SharedMemoryName;
    property KeepLogTypes;
    property SharedMemSize;
    property ShowSplashAtStart;
    property ShowStatusbar;
    property ScrollLogToBottom;
    property WatchPause;
    property PlaySoundOnComplete;
    property ConfigurationFormPage;
    property ConfigurationFormPosition;
    property MainFormPosition;
  end;

implementation

constructor TConfigurationClass.Create(const IniFileName: string='');
begin
  inherited Create(IniFileName);
end;

end.
