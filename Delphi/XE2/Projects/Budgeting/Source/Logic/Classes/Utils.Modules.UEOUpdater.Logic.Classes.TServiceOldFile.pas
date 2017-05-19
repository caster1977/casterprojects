unit Utils.Modules.UEOUpdater.Logic.Classes.TServiceOldFile;

interface

uses
  Vcl.Controls, Utils.Modules.UEOUpdater.Logic.Interfaces.IServiceOldFile;

type
  TServiceOldFile = class(TInterfacedObject, IServiceOldFile)
  strict private
    function GetName(const aParent: TWinControl): string;
    function Check(const aName: string): Boolean;
    function LoadData(const aValue: IInterface): Boolean;
  end;

implementation

uses
  Vcl.Dialogs, System.Classes, System.SysUtils, System.IOUtils, Utils.Modules.UEOUpdater.Logic.Classes.TModelItem,
  Utils.Modules.UEOUpdater.Logic.Interfaces.IModelItems, Utils.Modules.UEOUpdater.Logic.Interfaces.IModelItem;

resourcestring
  RsDefaultExt = 'csv';
  RsFilters = 'Файлы с разделителями (*.csv)|*.csv|Все файлы (*.*)|*.*';
  RsTitle = 'Выберите файл выборки...';

function TServiceOldFile.Check(const aName: string): Boolean;
begin
  Result := TFile.Exists(aName);
end;

function TServiceOldFile.GetName(const aParent: TWinControl): string;
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

function TServiceOldFile.LoadData(const aValue: IInterface): Boolean;
var
  tmpFileStream: TFileStream;
  tmpReader: TStreamReader;
  tmpLine: string;
  tmpArray: TArray<string>;
  tmpItem: TArray<IModelItem>;
  tmpModelItems: IModelItems;
  i: Integer;
begin
  Result := False;

  if not Supports(aValue, IModelItems, tmpModelItems) then
    Exit;

  tmpModelItems.Items.Clear();

  if TFile.Exists(tmpModelItems.FileName) then
  begin
    tmpFileStream := TFileStream.Create(tmpModelItems.FileName, fmOpenRead);
    try
      tmpReader := TStreamReader.Create(tmpFileStream);
      try
        while not tmpReader.EndOfStream do
        begin
          tmpLine := tmpReader.ReadLine();
          tmpArray := tmpLine.Split([';']);
          if Length(tmpArray) < 10 then
            Continue;
          if not tmpModelItems.Items.ContainsKey(tmpArray[0]) then
          begin
            SetLength(tmpItem, 1);
            tmpItem[0] := TModelItem.Create(tmpArray);
            tmpModelItems.Items.Add(tmpArray[0], tmpItem);
          end
          else
          begin
            if tmpModelItems.Items.TryGetValue(tmpArray[0], tmpItem) then
            begin
              i := Length(tmpItem);
              SetLength(tmpItem, Succ(i));
              tmpItem[i] := TModelItem.Create(tmpArray);
              tmpModelItems.Items[tmpArray[0]] := tmpItem;
            end;
          end;
        end;
        Result := True;
      finally
        tmpReader.Free();
      end;
    finally
      tmpFileStream.Free();
    end;
  end;
end;

end.
