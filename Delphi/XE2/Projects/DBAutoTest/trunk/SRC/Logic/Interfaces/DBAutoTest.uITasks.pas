unit DBAutoTest.uITasks;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBAutoTest.uITask;

type
  ITasks = interface(IInterfaceListOfGivenType<ITask>)
    ['{4003E584-E070-40E9-A9BF-71D29D2D4763}']
    procedure Run(const
      ASourceADOConnectionString,
      ADestinationADOConnectionString,
      ASourceServerName,
      ASourceDatabeseName: WideString);
  end;

implementation

end.
