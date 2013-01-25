unit CastersPackage.uIIniFileDataStorage;

interface

uses
  System.IniFiles,
  CastersPackage.uIModified;

type
  IIniFileDataStorage = interface(IModified)
    ['{C9872120-1001-47E3-B832-AC6BE58B52E0}']
    procedure AfterLoad;
    procedure BeforeSave;
    procedure Loading;
    procedure Saving;
    procedure Load;
    procedure Save;
  end;

implementation

end.
