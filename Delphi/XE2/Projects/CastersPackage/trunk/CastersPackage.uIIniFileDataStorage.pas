unit CastersPackage.uIIniFileDataStorage;

interface

uses
  System.IniFiles;

type
  IIniFileDataStorage=interface(IUnknown)
    ['{C9872120-1001-47E3-B832-AC6BE58B52E0}']
    procedure AfterLoad;
    procedure BeforeSave;
    procedure Loading(const AIniFile: TCustomIniFile);
    procedure Saving(const AIniFile: TCustomIniFile);
    procedure Load;
    procedure Save;
  end;

implementation

end.
