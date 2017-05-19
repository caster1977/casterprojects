unit RoutinesPackage.Logic.TTXTDataSetWriter;

interface

uses
  RoutinesPackage.Logic.TDelimitedTextDataSetWriter;

type
  TTXTDataSetWriter = class(TDelimitedTextDataSetWriter)
  strict protected
    class function GetDelimiter(): string; override;

  public
    class function GetExtension(): string; override;
  end;

implementation

class function TTXTDataSetWriter.GetExtension(): string;
begin
  Result := 'txt';
end;

class function TTXTDataSetWriter.GetDelimiter(): string;
begin
  Result := #$9;
end;

end.
