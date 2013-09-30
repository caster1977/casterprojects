unit uTShipmentBSOWithActArchivingBusinessLogic;

interface

uses
  uTDocumentArchivingBusinessLogic,
  uTArchiveDocumentItemClass;

type
  TShipmentBSOWithActArchivingBusinessLogic = class sealed(TDocumentArchivingBusinessLogic)
  protected
    procedure AddDocument(const AString: string); override; final;
    function GetArchiveBoxTypeId: Integer; override; final;
    function GetArchiveDocumentItemClass: TArchiveDocumentItemClass; override; final;
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
        end;
      end;
  end;
end;

end.
