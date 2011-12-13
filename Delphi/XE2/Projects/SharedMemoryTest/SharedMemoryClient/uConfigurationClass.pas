unit uConfigurationClass;

interface

uses
  uCommonConfigurationClass;

type
  TConfigurationClass=class(TCommonConfigurationClass)
  public
    constructor Create(const IniFileName: string='');
    property KeepLogTypes;
    property SharedMemoryName;
    property SharedMemSize;
    property ShowSplashAtStart;
    property ShowStatusbar;
    property ScrollLogToBottom;
    property WatchPause;
  end;

implementation

constructor TConfigurationClass.Create(const IniFileName: string='');
begin
  inherited Create(IniFileName);
end;

end.
