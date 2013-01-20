unit DBAutoTest.uTTaskList;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBAutoTest.uITaskList,
  DBAutoTest.uITask;

type
  TTaskList = class(TInterfaceListOfGivenType<ITask>, ITaskList)
  protected
    procedure Initialize; override;
  end;

function GetISignalList: ITaskList;

implementation

resourcestring
  RsCantAddTaskToTaskList = 'Ќе удалось добавить тест в список тестов.';
  RsCantRemoveTaskFromTaskList = 'Ќе удалось удалить тест из списка тестов.';

function GetISignalList: ITaskList;
begin
  Result := TTaskList.Create;
end;

procedure TTaskList.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddTaskToTaskList;
  RemoveItemErrorString := RsCantRemoveTaskFromTaskList;
end;

end.
