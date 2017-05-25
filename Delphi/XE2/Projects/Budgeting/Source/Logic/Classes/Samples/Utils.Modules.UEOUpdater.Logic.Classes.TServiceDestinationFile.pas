unit Utils.Modules.UEOUpdater.Logic.Classes.TServiceDestinationFile;

interface

uses
  Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceDestinationFile, System.Classes;

type
  TServiceDestinationFile = class(TInterfacedObject, IServiceDestinationFile)
  strict private
    FWriter: TStreamWriter;
    procedure Open(const aName: string);
    procedure WriteLine(const aValue: string);
    procedure Close();

  public
    destructor Destroy(); override;
  end;

implementation

uses
  System.SysUtils, System.IOUtils;

procedure TServiceDestinationFile.Close;
begin
  if Assigned(FWriter) then
  begin
    if Assigned(FWriter.BaseStream) then
      FWriter.BaseStream.Free();
    FreeAndNil(FWriter);
  end;
end;

destructor TServiceDestinationFile.Destroy;
begin
  try
    Close();
  finally
    inherited;
  end;
end;

procedure TServiceDestinationFile.Open(const aName: string);
begin
  FWriter := TStreamWriter.Create(TFileStream.Create(aName, fmCreate), TEncoding.UTF8);
end;

procedure TServiceDestinationFile.WriteLine(const aValue: string);
begin
  if Assigned(FWriter) then
    FWriter.WriteLine(aValue);
end;

end.
