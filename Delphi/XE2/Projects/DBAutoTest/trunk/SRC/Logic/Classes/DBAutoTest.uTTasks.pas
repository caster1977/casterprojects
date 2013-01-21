unit DBAutoTest.uTTasks;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBAutoTest.uITasks,
  DBAutoTest.uITask;

type
  TTasks = class(TInterfaceListOfGivenType<ITask>, ITasks)
  protected
    procedure Initialize; override;
  end;

function GetITasks: ITasks;

implementation

resourcestring
  RsCantAddTaskToTaskList = '�� ������� �������� ���� � ������ ������.';
  RsCantRemoveTaskFromTaskList = '�� ������� ������� ���� �� ������ ������.';

function GetITasks: ITasks;
begin
  Result := TTasks.Create;
end;

procedure TTasks.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddTaskToTaskList;
  RemoveItemErrorString := RsCantRemoveTaskFromTaskList;
end;

end.
