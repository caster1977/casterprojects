unit OA5.uConfigurationClass2;

interface

uses
  System.IniFiles,
  OA5.uTestConfiguration;

type
  TIFS_Interface=class(TInterfaceIniFileSection)
  strict protected
    procedure Loading; override;
    procedure Saving; override;
  end;

implementation

procedure TIFS_Interface.Loading;
begin
  inherited;
  Read();
end;

procedure TIFS_Interface.Saving;
begin
  inherited;
  Write();
end;

end.
