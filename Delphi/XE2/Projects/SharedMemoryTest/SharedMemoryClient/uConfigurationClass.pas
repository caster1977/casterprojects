unit uConfigurationClass;

interface

uses
  uCommonConfigurationClass;

type
  TConfigurationClass=class(TCommonConfigurationClass)
  public
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

end.
