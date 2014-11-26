unit DBUShared.uIDBUServerLogRecords;

interface

uses
  CastersPackage.uIInterfaceListOfGivenType,
  System.Classes,
  DBUShared.uIDBUServerLogRecord;

type
  IDBUServerLogRecords = interface(IInterfaceListOfGivenType<IDBUServerLogRecord>)
    ['{71DDF980-37CD-4CF2-B03E-1C014A8BFE90}']
    procedure ToStringList(var AList: TStrings; const ADatabaseType: string = ''; const ASeparator: string = '^^');
  end;

implementation

end.
