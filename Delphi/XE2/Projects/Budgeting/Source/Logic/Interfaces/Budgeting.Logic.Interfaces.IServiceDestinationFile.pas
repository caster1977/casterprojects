unit Budgeting.Logic.Interfaces.IServiceDestinationFile;

interface

uses
  Vcl.Controls;

type
  IServiceDestinationFile = interface
    procedure Open(const aName: string);
    procedure WriteLine(const aValue: string);
    procedure Close();
  end;

implementation

end.
