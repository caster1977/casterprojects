unit uTShipmentBSOArchivingBusinessLogic;

interface

uses
  uTDocumentArchivingBusinessLogic,
  uTArchiveDocumentItemClass;

type
  TShipmentBSOArchivingBusinessLogic = class sealed(TDocumentArchivingBusinessLogic)
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
  uTShipmentBSOItem;

function TShipmentBSOArchivingBusinessLogic.GetArchiveBoxTypeId: Integer;
begin
  Result := 1;
end;

function TShipmentBSOArchivingBusinessLogic.GetArchiveDocumentItemClass: TArchiveDocumentItemClass;
begin
  Result := TShipmentBSOItem;
end;

procedure TShipmentBSOArchivingBusinessLogic.AddDocument(const AString: string);
var
  i: Integer;
  box: IArchiveBoxItem;
begin
  if AnalizeBarcode(AString) = dabtBSO then
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
          DisplayErrorMessage(Format('�������� ��� ��� ������������� ����� (�����-��� ������ - %s)' + sLineBreak +
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
              DisplaySuccessMessage('�������� �������� � ����� �������� �����' + sLineBreak +
                RsEnterBarcodeOfDocumentOrCommand);
            end;
          end
          else
          begin
            CurrentBox := AddDocumentToOldestOpenedArchiveBox(CurrentDocument);
            if Assigned(CurrentBox) then
            begin
              DisplaySuccessMessage('�������� �������� � ������������ �������� �����' + sLineBreak +
                RsEnterBarcodeOfDocumentOrCommand);
            end;
          end;
        end
        else
        begin
          if AddDocumentToCurrentBox(CurrentDocument) then
          begin
            DisplaySuccessMessage('�������� �������� � ������� �������� �����' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand);
          end;
        end;
      end;
    end;
  end;
end;

end.
