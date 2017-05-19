unit Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceOldFile;

interface

uses
  Vcl.Controls;

type
  IServiceOldFile = interface
    ['{0EF8CFA4-10A3-4844-B8A5-718E7ADD44BD}']
    function GetName(const aParent: TWinControl): string;
    function Check(const aName: string): Boolean;
    function LoadData(const aValue: IInterface): Boolean;
  end;

implementation

end.
