unit Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceNewFile;

interface

uses
  Vcl.Controls;

type
  IServiceNewFile = interface
    ['{D745E101-7AF4-40DD-9A5D-A61AC33CDC9B}']
    function GetName(const aParent: TWinControl): string;
    function Check(const aName: string): Boolean;
    procedure Open(const aName: string);
    function ReadLine(): string;
    procedure Close();
    function GetEof(): Boolean;
    property Eof: Boolean read GetEof;
  end;

implementation

end.
