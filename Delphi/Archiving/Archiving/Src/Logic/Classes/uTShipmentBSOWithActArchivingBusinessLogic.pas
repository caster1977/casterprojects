unit uTShipmentBSOWithActArchivingBusinessLogic;

interface

uses
  uTDocumentArchivingBusinessLogic,
  uTArchiveDocumentItemClass;

type
  TShipmentBSOWithActArchivingBusinessLogic = class {$IFNDEF VER150} sealed {$ENDIF}(TDocumentArchivingBusinessLogic)
  protected
    procedure AddDocument(const AString: string); override; {$IFNDEF VER150} final; {$ENDIF}
    function GetArchiveBoxTypeId: Integer; override; {$IFNDEF VER150} final; {$ENDIF}
    function GetArchiveDocumentItemClass: TArchiveDocumentItemClass; override; {$IFNDEF VER150} final; {$ENDIF}
  end;

implementation

uses
  SysUtils,
  uTDocumentArchivingBarcodeType,
  uIArchiveBoxItem,
  uTArchiveBoxItem,
  uTShipmentBSOWithActItem;

function TShipmentBSOWithActArchivingBusinessLogic.GetArchiveBoxTypeId: Integer;
begin
  Result := 2;
end;

function TShipmentBSOWithActArchivingBusinessLogic.GetArchiveDocumentItemClass: TArchiveDocumentItemClass;
begin
  Result := TShipmentBSOWithActItem;
end;

procedure TShipmentBSOWithActArchivingBusinessLogic.AddDocument(const AString: string);
var
  i: Integer;
  box: IArchiveBoxItem;
begin
  if AnalizeBarcode(AString) = dabtBSO then
  begin
    CurrentDocument := CreateDocumentItemByBarcode(AString);
    if Assigned(CurrentDocument) then
    begin
      if CurrentDocument.Valid(Connection) then
      begin
        i := GetArchiveBoxIdByDocument(CurrentDocument);
        if i > -1 then
        begin
          box := TArchiveBoxItem.Create(Connection, i);
          if Assigned(box) then
          begin
            DisplayErrorMessage(Format('Документ уже был заархивирован ранее (штрих-код короба - %s)' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand, [box.Barcode]));
          end;
        end
        else
        begin
          if not Assigned(CurrentBox) then
          begin
            i := GetOpenedBoxQuantity(ArchiveBoxTypeId, CurrentDocument.CompanyId);
            if i = 0 then
            begin
              CurrentBox := CreateArchiveBoxByDocument(CurrentDocument);
              if Assigned(CurrentBox) then
              begin
                DisplaySuccessMessage('Документ добавлен в новый архивный короб' + sLineBreak +
                  RsEnterBarcodeOfDocumentOrCommand);
              end;
            end
            else
            begin
              CurrentBox := AddDocumentToOldestOpenedArchiveBox(CurrentDocument);
              if Assigned(CurrentBox) then
              begin
                DisplaySuccessMessage('Документ добавлен в существующий архивный короб' + sLineBreak +
                  RsEnterBarcodeOfDocumentOrCommand);
              end
              else
              begin
                DisplayErrorMessage('Не удалось добавить документ в существующий архивный короб' + sLineBreak +
                  RsEnterBarcodeOfDocumentOrCommand);
              end;
            end;
          end
          else
          begin
            if AddDocumentToCurrentBox(CurrentDocument) then
            begin
              DisplaySuccessMessage('Документ добавлен в текущий архивный короб' + sLineBreak +
                RsEnterBarcodeOfDocumentOrCommand);
            end;
          end;
        end;
      end
      else
      begin
        DisplayErrorMessage('Неверный тип документа' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
      end;
    end
    else
    begin
      DisplayErrorMessage('Документ с указанным штрих-кодом не найден в базе данных' + sLineBreak +
        RsEnterBarcodeOfDocumentOrCommand);
    end;
  end;
end;

end.
