unit uTShipmentBSOArchivingBusinessLogic;

interface

uses
  uTDocumentArchivingBusinessLogic;

type
  TShipmentBSOArchivingBusinessLogic = class sealed(TDocumentArchivingBusinessLogic)
  protected
    procedure ProcessDocument(const AString: string); override; final;
    function GetArchiveBoxTypeId: Integer; override; final;
  end;

implementation

uses
  SysUtils,
  uTDocumentArchivingBarcodeType,
  uIArchiveBoxItem,
  uTArchiveBoxItem;

function TShipmentBSOArchivingBusinessLogic.GetArchiveBoxTypeId: Integer;
begin
  Result := 1;
end;

procedure TShipmentBSOArchivingBusinessLogic.ProcessDocument(const AString: string);
var
  i: Integer;
  box: IArchiveBoxItem;
begin
  case AnalizeBarcode(AString) of
    dabtBSO:
      begin
        CurrentDocument := CreateDocumentItemByBarcode(AString);
        if Assigned(CurrentDocument) then
        begin
          i := GetArchiveBoxIdByDocument(CurrentDocument);
          if i > -1 then
          begin
            box := TArchiveBoxItem.Create(Connection, i);
            if Assigned(box) then
            begin
              DisplayErrorMessage(Format('Документ уже был заархивирован ранее (штрих-код короба - %s)' + sLineBreak + 'Введите штрих-код документа или команды',
                [box.Barcode]));
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
                  DisplaySuccessMessage('Документ добавлен в новый архивный короб' + sLineBreak + 'Введите штрих-код документа или команды');
                end;
              end
              else
              begin
                CurrentBox := AddDocumentToOldestOpenedArchiveBox(CurrentDocument);
                if Assigned(CurrentBox) then
                begin
                  DisplaySuccessMessage('Документ добавлен в существующий архивный короб' + sLineBreak + 'Введите штрих-код документа или команды');
                end;
              end;
            end
            else
            begin
              if AddDocumentToCurrentBox(CurrentDocument) then
              begin
                DisplaySuccessMessage('Документ добавлен в текущий архивный короб' + sLineBreak + 'Введите штрих-код документа или команды');
              end;
            end;
          end;
        end;
      end;
  end;
end;

end.
