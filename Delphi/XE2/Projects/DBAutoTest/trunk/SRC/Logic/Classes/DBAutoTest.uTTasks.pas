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
    procedure Run;
  end;

function GetITasks: ITasks;

implementation

uses
  System.Classes;

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

procedure TTasks.Run;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    Items[i].Run;
  end;
end;

initialization

begin
  RegisterClass(TTasks);
end;

end.
