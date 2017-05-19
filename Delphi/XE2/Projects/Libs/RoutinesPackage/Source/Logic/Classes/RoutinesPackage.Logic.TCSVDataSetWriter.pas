unit RoutinesPackage.Logic.TCSVDataSetWriter;

interface

uses
  RoutinesPackage.Logic.TDelimitedTextDataSetWriter;

type
  TCSVDataSetWriter = class(TDelimitedTextDataSetWriter)
  strict protected
    class function GetDelimiter(): string; override;

  public
    class function GetExtension(): string; override;
  end;

implementation

class function TCSVDataSetWriter.GetExtension(): string;
begin
  Result := 'csv';
end;

class function TCSVDataSetWriter.GetDelimiter(): string;
begin
  Result := ';';
end;

end.
