unit Utils.Modules.UEOUpdater.Logic.Classes.TServiceNewFile;

interface

uses
  Vcl.Controls, System.Classes, Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceNewFile;

type
  TServiceNewFile = class(TInterfacedObject, IServiceNewFile)
  strict private
    FReader: TStreamReader;
    function GetName(const aParent: TWinControl): string;
    function Check(const aName: string): Boolean;
    procedure Open(const aName: string);
    function ReadLine(): string;
    procedure Close();
    function GetEof(): Boolean;

  public
    destructor Destroy(); override;
  end;

implementation

uses
  Vcl.Dialogs, System.SysUtils, System.IOUtils;

resourcestring
  RsDefaultExt = 'csv';
  RsFilters = 'Файлы с разделителями (*.csv)|*.csv|Все файлы (*.*)|*.*';
  RsTitle = 'Выберите файл выборки...';

function TServiceNewFile.Check(const aName: string): Boolean;
begin
  Result := TFile.Exists(aName);
end;

procedure TServiceNewFile.Close;
begin
  if Assigned(FReader) then
  begin
    if Assigned(FReader.BaseStream) then
      FReader.BaseStream.Free();
    FreeAndNil(FReader);
  end;
end;

destructor TServiceNewFile.Destroy;
begin
  try
    Close();
  finally
    inherited;
  end;
end;

function TServiceNewFile.GetEof: Boolean;
begin
  Result := True;
  if Assigned(FReader) then
    Result := FReader.EndOfStream;
end;

function TServiceNewFile.GetName(const aParent: TWinControl): string;
var
  tmpForm: TOpenDialog;
begin
  Result := EmptyStr;
  tmpForm := TOpenDialog.Create(aParent);
  try
    tmpForm.DefaultExt := RsDefaultExt;
    tmpForm.Filter := RsFilters;
    tmpForm.Options := tmpForm.Options + [ofReadOnly, ofFileMustExist];
    tmpForm.Title := RsTitle;
    tmpForm.FilterIndex := 1;
    if not tmpForm.Execute(aParent.Handle) then
    begin
      Exit;
    end;
    Result := tmpForm.FileName;
  finally
    tmpForm.Free();
  end;
end;

procedure TServiceNewFile.Open(const aName: string);
begin
  if TFile.Exists(aName) then
    FReader := TStreamReader.Create(TFileStream.Create(aName, fmOpenRead));
end;

function TServiceNewFile.ReadLine: string;
begin
  Result := EmptyStr;
  if Assigned(FReader) then
    Result := FReader.ReadLine();
end;

end.
