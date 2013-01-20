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
  RsCantAddTaskToTaskList = '�� ������� �������� ���� � ������ ������.';
  RsCantRemoveTaskFromTaskList = '�� ������� ������� ���� �� ������ ������.';

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
