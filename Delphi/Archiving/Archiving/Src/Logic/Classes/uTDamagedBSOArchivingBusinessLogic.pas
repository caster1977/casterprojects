unit uTDamagedBSOArchivingBusinessLogic;

interface

uses
  uTDocumentArchivingBusinessLogic,
  uTArchiveDocumentItemClass;

type
  TDamagedBSOArchivingBusinessLogic = class {$IFNDEF VER150} sealed {$ENDIF}(TDocumentArchivingBusinessLogic)
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
  uICauseOfArchiveDocumentDamageList,
  uTCauseOfArchiveDocumentDamageList,
  uICauseOfArchiveDocumentDamageItem,
  uIDamagedBSOItem,
  uTDamagedBSOItem;

function TDamagedBSOArchivingBusinessLogic.GetArchiveBoxTypeId: Integer;
begin
  Result := 5;
end;

function TDamagedBSOArchivingBusinessLogic.GetArchiveDocumentItemClass: TArchiveDocumentItemClass;
begin
  Result := TDamagedBSOItem;
end;

procedure TDamagedBSOArchivingBusinessLogic.AddDocument(const AString: string);
var
  codl: ICauseOfArchiveDocumentDamageList;
  a: ICauseOfArchiveDocumentDamageItem;
  i: Integer;
  box: IArchiveBoxItem;
  idbsoi: IDamagedBSOItem;
begin
  case Step of
    0:
      begin
        if AnalizeBarcode(AString) = dabtBSO then
        begin
          CurrentDocument := CreateDocumentItemByBarcode(AString);
          if Assigned(CurrentDocument) then
          begin
            if CurrentDocument.Valid(Connection) then
            begin
              i := GetArchiveBoxIdByDocument(CurrentDocument);
              if i = -1 then
              begin
                Step := 1;
                DisplayInfoMessage('Введите штрих-код порчи документа');
              end
              else
              begin
                box := TArchiveBoxItem.Create(Connection, i);
                if Assigned(box) then
                begin
                  DisplayErrorMessage(Format('Документ уже был заархивирован ранее (штрих-код короба - %s)' + sLineBreak
                    + RsEnterBarcodeOfDocumentOrCommand, [box.Barcode]));
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
            Step := 0;
            DisplayErrorMessage('Документ с указанным штрих-кодом не найден в базе данных' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand);
          end;
        end;
      end;
    1:
      begin
        if Assigned(CurrentDocument) then
        begin
          if AnalizeBarcode(AString) = dabtCauseOfDamage then
          begin
            codl := TCauseOfArchiveDocumentDamageList.Create(Connection);
            if Assigned(codl) then
            begin
              codl.Load;
              for i := 0 to codl.Count - 1 do
              begin
                if Supports(codl.Item[i], ICauseOfArchiveDocumentDamageItem, a) then
                begin
                  if a.Barcode = AString then
                  begin
                    if Supports(CurrentDocument, IDamagedBSOItem, idbsoi) then
                    begin
                      idbsoi.CauseOfDamageId := a.Id;
                      idbsoi.CauseOfDamageName := a.name;
                    end;
                    if not Assigned(CurrentBox) then
                    begin
                      if GetOpenedBoxQuantity(ArchiveBoxTypeId, CurrentDocument.CompanyId) = 0 then
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
                          DisplayErrorMessage('Не удалось добавить документ в существующий архивный короб' + sLineBreak
                            + RsEnterBarcodeOfDocumentOrCommand);
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
                    Break;
                  end;
                end;
              end;
            end;
          end
          else
          begin
            DisplayErrorMessage('Документ не был добавлен, т.к. не был введён штрих-код порчи документа' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand);
          end;
        end
        else
        begin
          DisplayInfoMessage(RsEnterBarcodeOfDocumentOrCommand);
        end;
        Step := 0;
      end;
  end;
end;

end.
