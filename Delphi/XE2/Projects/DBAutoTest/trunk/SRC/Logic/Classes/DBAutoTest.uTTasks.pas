unit DBAutoTest.uTTasks;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBAutoTest.uITasks,
  DBAutoTest.uIProfile,
  DBAutoTest.uITask;

type
  TTasks = class(TInterfaceListOfGivenType<ITask>, ITasks)
  strict protected
    procedure Initialize; override;
  public
    procedure Run;
  end;

function GetITasks: ITasks;

implementation

uses
  System.Classes,
  DBAutoTest.uTTaskThread;

resourcestring
  RsCantAddTaskToTasks = 'Не удалось добавить тест в список тестов.';
  RsCantRemoveTaskFromTasks = 'Не удалось удалить тест из списка тестов.';

function GetITasks: ITasks;
begin
  Result := TTasks.Create;
end;

procedure TTasks.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddTaskToTasks;
  RemoveItemErrorString := RsCantRemoveTaskFromTasks;
end;

procedure TTasks.Run;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].Enabled then
    begin
      //with TTaskThread.Create(Self, ADOConnectionString) do
      begin
      end;
      { TODO : добавить запуск привязанного треда }
    end;
  end;
end;

initialization

begin
  RegisterClass(TTasks);
end;

end.
