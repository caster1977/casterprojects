unit DBAutoTest.uTTasks;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  DBAutoTest.uITasks,
  DBAutoTest.uITask;

type
  TTasks = class(TInterfaceListOfGivenType<ITask>, ITasks)
  strict protected
    procedure Initialize; override;
  public
    procedure Run(const ASourceADOConnectionString, ADestinationADOConnectionString: WideString);
  end;

function GetITasks: ITasks;

implementation

uses
  System.SysUtils,
  DBAutoTest.uConsts,
  DBAutoTest.uTTaskStatus,
  DBAutoTest.uETaskThread,
  DBAutoTest.uTTaskThread;

resourcestring
  RsCantAddTaskToTasks = 'Ќе удалось добавить тест в список тестов.';
  RsCantRemoveTaskFromTasks = 'Ќе удалось удалить тест из списка тестов.';

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

procedure TTasks.Run(const ASourceADOConnectionString, ADestinationADOConnectionString: WideString);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Status := tsUnknown;
    if Items[i].Enabled then
    begin
      with TTaskThread.Create(Items[i], ASourceADOConnectionString, ADestinationADOConnectionString) do
        try
          Start;
        except
          on e: Exception do
          begin
            raise ETaskThread.Create(e.Message);
          end;
        end;
    end;
  end;
end;

end.
