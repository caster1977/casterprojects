unit CastersPackage.uIModified;

interface

type
  IModified = interface
    ['{F93D1503-1273-45BC-8325-0CCE8F939A40}']
    function GetModified: Boolean;
    property Modified: Boolean read GetModified;
  end;

implementation

end.
