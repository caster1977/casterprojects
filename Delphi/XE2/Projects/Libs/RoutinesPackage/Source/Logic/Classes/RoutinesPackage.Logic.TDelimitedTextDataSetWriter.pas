unit RoutinesPackage.Logic.TDelimitedTextDataSetWriter;

interface

uses
  RoutinesPackage.Logic.TDataSetWriter;

type
  TDelimitedTextDataSetWriter = class(TDataSetWriter)
  strict protected
    class function GetDelimiter(): string; virtual; abstract;
    function Saving(): Boolean; override;
  end;

implementation

uses
  CodeSiteLogging,
  Data.DB,
  System.SysUtils,
  System.StrUtils,
  System.Math,
  System.Classes;

function TDelimitedTextDataSetWriter.Saving(): Boolean;
var
  i: Integer;
  j: Integer;
  s: string;
  tmpArray: TArray<string>;
  tmpDelimiter: string;
  tmpFormatSettings: TFormatSettings;
  tmpWriter: TStreamWriter;
begin
  Result := False;

  {$IFDEF DEBUG}
  CodeSite.EnterMethod(Self, 'Saving()');
  try
    {$ENDIF}
    try
      // получение разделителя
      tmpDelimiter := GetDelimiter();
      tmpDelimiter := IfThen(tmpDelimiter = #32, #$A0, tmpDelimiter);

      // установка параметров локали
      tmpFormatSettings := TFormatSettings.Create('ru-RU');
      tmpFormatSettings.DecimalSeparator := '.';

      // установка количества колонок
      SetLength(tmpArray, FSource.FieldCount);

      CodeSite.SendDateTime(csmCheckPoint, 'Создание потока...', Now());

      tmpWriter := TStreamWriter.Create(TStringStream.Create(), TEncoding.GetEncoding(1251));
      try
        tmpWriter.AutoFlush := False;
        tmpWriter.BaseStream.Seek(0, soBeginning);

        CodeSite.SendDateTime(csmCheckPoint, 'Выгрузка шапки в поток...', Now());
        // добавление шапки
        for i := 0 to Pred(FSource.FieldCount) do
        begin
          s := FSource.FieldDefList.FieldDefs[i].Name;

          if i < Length(FTitle) then
          begin
            s := IfThen(FTitle[i].Trim().IsEmpty(), s, FTitle[i].Trim());
          end;

          tmpArray[i] := s;
        end;
        tmpWriter.WriteLine(string.Join(tmpDelimiter, tmpArray));
        CodeSite.SendDateTime(csmGreen, 'Выгрузка шапки успешно завершена.', Now());

        CodeSite.SendDateTime(csmCheckPoint, 'Выгрузка данных в поток...', Now());
        // добавление данных
        while not FSource.Eof do
        begin
          for j := 0 to Pred(FSource.Fields.Count) do
          begin
            if FSource.Fields[j].DataType in [ftFloat, ftCurrency] then
            begin
              tmpArray[j] := FormatFloat('0.#####', FSource.Fields[j].AsFloat, tmpFormatSettings).Trim();
            end
            else
            begin
              tmpArray[j] := FSource.Fields[j].AsString.Replace(tmpDelimiter, #32, [rfReplaceAll]).Trim();
            end;
          end;
          tmpWriter.WriteLine(string.Join(tmpDelimiter, tmpArray));

          FSource.Next();
        end;
        tmpWriter.Flush();

        CodeSite.SendDateTime(csmGreen, 'Выгрузка данных в поток успешно завершена.', Now());

        CodeSite.SendDateTime(csmCheckPoint, 'Сохранение данных в файл...', Now());

        (tmpWriter.BaseStream as TStringStream).SaveToFile(FDestinationFileName);

        CodeSite.SendDateTime(csmGreen, 'Сохранение данных в файл успешно завершено', Now());

        tmpWriter.Close();

        CodeSite.SendDateTime(csmCheckPoint, 'Закрытие потока...', Now());

        Result := True;
      finally
        if Assigned(tmpWriter.BaseStream) then
          tmpWriter.BaseStream.Free();
        tmpWriter.Free();
      end;
    except
      on e: Exception do
      begin
        CodeSite.SendException(e);
      end;
    end;
    {$IFDEF DEBUG}
  finally
    CodeSite.ExitMethod(Self, 'Saving()', Result);
  end;
  {$ENDIF}
end;

end.
