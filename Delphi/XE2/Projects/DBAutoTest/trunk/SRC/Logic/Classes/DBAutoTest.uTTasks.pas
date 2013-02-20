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
    procedure Run(const AADOConnectionString: WideString);
  end;

function GetITasks: ITasks;

implementation

uses
  System.Classes,
  System.SysUtils,
  DBAutoTest.uConsts,
  DBAutoTest.uETaskThread,
  DBAutoTest.uTTaskThread;

resourcestring
  RsCantAddTaskToTasks = '�� ������� �������� ���� � ������ ������.';
  RsCantRemoveTaskFromTasks = '�� ������� ������� ���� �� ������ ������.';

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

procedure TTasks.Run(const AADOConnectionString: WideString);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if Items[i].Enabled then
    begin
      with TTaskThread.Create(Items[i], AADOConnectionString) do
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

initialization

begin
  RegisterClass(TTasks);
end;

end.
