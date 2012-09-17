/// <summary>
/// Модуль-обёртка класса TConfigurationClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit SharedMemoryClient.uConfigurationClass;

interface

uses
  SharedMemoryCommon.uCommonConfigurationClass;

type
  TConfigurationClass = class(TCommonConfigurationClass)
  public
    property ConfigurationFormPage;
    property ConfigurationFormPosition;
    property KeepLogTypes;
    property MainFormPosition;
    property PlaySoundOnComplete;
    property ScrollLogToBottom;
    property SharedMemoryName;
    property SharedMemSize;
    property ShowConfirmationOnQuit;
    property ShowSplashAtStart;
    property ShowStatusbar;
    property WatchPause;
  end;

implementation

end.
