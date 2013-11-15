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
  uArchivingCommonResourceStrings,
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
            DisplayErrorMessage(Format(RsDocumentAlreadyArchived + sLineBreak + RsEnterBarcodeOfDocumentOrCommand,
              [box.Barcode]));
          end;
        end
        else
        begin
          if not Assigned(CurrentBox) then
          begin
            i := GetOpenedBoxQuantity(ArchiveBoxTypeId, CurrentDocument.CompanyId, CurrentDocument.Year);
            if i = 0 then
            begin
              CurrentBox := CreateArchiveBoxByDocument(CurrentDocument);
              if Assigned(CurrentBox) then
              begin
                DisplaySuccessMessage(RsDocumentAddedToTheNewBox + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
              end;
            end
            else
            begin
              CurrentBox := AddDocumentToOldestOpenedArchiveBox(CurrentDocument);
              if Assigned(CurrentBox) then
              begin
                DisplaySuccessMessage(RsDocumentAddedToExistingBox + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
              end
              else
              begin
                DisplayErrorMessage(RsCantAddDocumentToTheExisingBox + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
              end;
            end;
          end
          else
          begin
            if AddDocumentToCurrentBox(CurrentDocument) then
            begin
              DisplaySuccessMessage(RsDocumentAddedToTheCurrentBox + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
            end;
          end;
        end;
      end
      else
      begin
        DisplayErrorMessage(RsWrongDocumentType + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
      end;
    end
    else
    begin
      DisplayErrorMessage(RsDocumentNotFound + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
    end;
  end;
end;

end.
