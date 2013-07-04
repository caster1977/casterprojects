unit DBAutoTest.Profile.uTTaskSaving;

interface

uses
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute,
  DBAutoTest.uConsts;

type
  [TSection(TASK_SAVING_SECTION)]
  TTaskSaving = class(TCustomSection)
  public
    [TDefaultValue(PROFILE_DEFAULT_ENABLE_STORE_TASKS)]
    property EnableStoreTasks: Boolean index 0 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(PROFILE_DEFAULT_ENABLE_STORE_ONLY_ENABLED_TASKS)]
    property EnableStoreOnlyEnabledTasks: Boolean index 1 read GetBooleanValue write SetBooleanValue;
  end;

implementation

end.
