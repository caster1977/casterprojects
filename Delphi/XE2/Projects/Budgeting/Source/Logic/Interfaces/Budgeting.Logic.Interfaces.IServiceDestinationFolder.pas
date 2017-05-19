unit Budgeting.Logic.Interfaces.IServiceDestinationFolder;

interface

uses
  Vcl.Controls;

type
  IServiceDestinationFolder = interface
    function GetName(const aParent: TWinControl): string;
    function Check(const aName: string): Boolean;
  end;

implementation

end.
