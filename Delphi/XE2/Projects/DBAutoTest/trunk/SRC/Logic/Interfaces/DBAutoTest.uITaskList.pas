unit DBAutoTest.uITaskList;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBAutoTest.uITask;

type
  ITaskList = interface(IInterfaceListOfGivenType<ITask>)
    ['{4003E584-E070-40E9-A9BF-71D29D2D4763}']
  end;

implementation

end.
