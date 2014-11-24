unit DBUServerService.uIDBUServerLogRecords;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBUServerService.uIDBUServerLogRecord;

type
  IDBUServerLogRecords = interface(IInterfaceListOfGivenType<IDBUServerLogRecord>)
    ['{71DDF980-37CD-4CF2-B03E-1C014A8BFE90}']
  end;

implementation

end.
