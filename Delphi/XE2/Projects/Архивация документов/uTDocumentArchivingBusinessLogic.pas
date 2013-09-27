unit uTDocumentArchivingBusinessLogic;

interface

uses
  uTTestedDocumentArchivingLogic,
  uIDocumentArchivingBusinessLogic,
  uIArchiveBoxItem,
  uICustomBSOItem,
  uIArchiveDocumentItem;

type
  TDocumentArchivingBusinessLogic = class sealed(TTestedDocumentArchivingLogic, IDocumentArchivingBusinessLogic)
  private
    procedure ProcessShipmentBSO(const AString: string);
    procedure ProcessDamagedBSO(const AString: string);
  public
    procedure ProcessString(const AString: string);

    function AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem): Boolean;
  end;

implementation

uses
  uTDocumentArchivingBarcodeType,
  uTArchiveDocumentListClass,
  uCommonRoutines,
  uIArchiveBoxTypeItem,
  uTArchiveBoxTypeItem,
  uTArchiveDocumentItemClass,
  uTArchiveBoxItem,
  SysUtils,
  StdCtrls,
  uIShowableField,
  uTReportDataModule,
  uIArchiveCompanyItem,
  uIDamagedBSOItem,
  uTDamagedBSOItem,
  uTDamagedBSOList,
  uICauseOfDamageList,
  uTCauseOfDamageList,
  uTArchiveCompanyItem;

function TDocumentArchivingBusinessLogic.AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem): Boolean;
begin
  Result := False;
  if Assigned(ABSO) then
  begin
    SetSQLForQuery(Query, Format('BSOArchiving_upd_AcceptanceRegister %d', [ABSO.BSOId]), True);
    try
      if not Query.Eof then
      begin
        Result := Query.Fields[0].AsInteger > -1;
      end;
    finally
      Query.Close;
    end;
  end;
end;

procedure TDocumentArchivingBusinessLogic.ProcessString(const AString: string);
begin
  if AnalizeBarcode(AString) in [dabtUnknown, dabtForceNewBoxCommand, dabtPutBoxAsideCommand, dabtGiveDocumentAway] then
  begin
    Step := 0;
    case AnalizeBarcode(AString) of
      dabtUnknown:
        begin
          DisplayErrorMessage('Введён неизвестный штрих-код' + sLineBreak + 'Введите штрих-код документа или команды');
          Exit;
        end;
      dabtForceNewBoxCommand:
        begin
          if CloseCurrentBox then
            DisplaySuccessMessage('Текущий короб был закрыт' + sLineBreak + 'Введите штрих-код документа или команды')
          else
            DisplayErrorMessage('Не удалось закрыть текущий короб' + sLineBreak + 'Введите штрих-код документа или команды');
        end;
      dabtPutBoxAsideCommand:
        begin
          if PutCurrentBoxAside then
            DisplaySuccessMessage('Текущий короб отложен' + sLineBreak + 'Введите штрих-код документа или команды')
          else
            DisplayErrorMessage('Не удалось отложить текущий короб' + sLineBreak + 'Введите штрих-код документа или команды');
        end;
      dabtGiveDocumentAway:
        begin
          if GiveLastDocumentInCurrentBoxAway then
            DisplaySuccessMessage('Последний документ из текущего короба передан' + sLineBreak + 'Введите штрих-код документа или команды')
          else
            DisplayErrorMessage('Не удалось передать последний документ из текущего короба' + sLineBreak + 'Введите штрих-код документа или команды');
        end;
    end
  end
  else
  begin
    if CanAddDocument then
    begin
      case ArchiveBoxTypeId of
        1, 2:
          ProcessShipmentBSO(AString);
        5:
          ProcessDamagedBSO(AString);
      end;

      if Assigned(CurrentBox) then
      begin
        if Assigned(CurrentBox.Documents) then
        begin
          if (CurrentBox.Documents.Count = 2) and (not CurrentBox.StickerPrinted) then
          begin
            if PrintCurrentBoxSticker then
            begin
              DisplaySuccessMessage('Документ был успешно добавлен в текущий короб' + sLineBreak + 'Стикер на текущий короб распечатан автоматически' + sLineBreak + 'Введите штрих-код документа или команды');
            end;
          end;
        end;
      end;

      if CurrentBoxIsFull then
      begin
        if CloseCurrentBox then
        begin
          DisplaySuccessMessage('Текущий короб заполнен и был закрыт' + sLineBreak + 'Введите штрих-код документа или команды');
        end;
      end;
    end
    else
    begin
      Step := 0;
      DisplayErrorMessage('Документ нельзя добавлять, поскольку идёт настройка вместимости коробов' + sLineBreak + 'Дождитесь окончания настройки, затем введите штрих-код документа или команды');
    end;
  end;
  UpdateCurrentInfo;
end;

procedure TDocumentArchivingBusinessLogic.ProcessDamagedBSO(const AString: string);
var
  codl: ICauseOfDamageList;
  i: Integer;
  box: IArchiveBoxItem;
begin
  case Step of
    0:
      begin
        CurrentDocument := CreateDocumentItemByBarcode(AString);
        if Assigned(CurrentDocument) then
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
              DisplayErrorMessage(Format('Документ уже был заархивирован ранее (штрих-код короба - %s)' + sLineBreak + 'Введите штрих-код документа или команды',
                [box.Barcode]));
            end;
          end;
        end
        else
        begin
          Step := 0;
          DisplayInfoMessage('Документ с указанным штрих-кодом не найден в базе данных' + sLineBreak + 'Введите штрих-код документа или команды');
        end;
      end;
    1:
      begin
        if Assigned(CurrentDocument) then
        begin
          if AnalizeBarcode(AString) = dabtCauseOfDamage then
          begin
            codl := TCauseOfDamageList.Create(Connection);
            if Assigned(codl) then
            begin
              codl.Load;
              for i := 0 to codl.Count - 1 do
              begin
                if codl.Item[i].Barcode = AString then
                begin
                  (CurrentDocument as TDamagedBSOItem).CauseOfDamageId := codl.Item[i].Id;
                  (CurrentDocument as TDamagedBSOItem).CauseOfDamageName := codl.Item[i].name;
                  if not Assigned(CurrentBox) then
                  begin
                    if GetOpenedBoxQuantity(ArchiveBoxTypeId, CurrentDocument.CompanyId) = 0 then
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
                  Break;
                end;
              end;
            end;
          end
          else
          begin
            DisplayErrorMessage('Документ не был добавлен, т.к. не был введён штрих-код порчи документа' + sLineBreak + 'Введите штрих-код документа или команды');
          end;
        end
        else
        begin
          DisplayInfoMessage('Введите штрих-код документа или команды');
        end;
        Step := 0;
      end;
  end;
end;

procedure TDocumentArchivingBusinessLogic.ProcessShipmentBSO(const AString: string);
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
