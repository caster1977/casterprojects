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
  public
    procedure ManualPrintCurrentBoxSticker;
    procedure ManualDeleteLastDocumentFromCurrentBox;
    procedure ProcessString(const AString: string);
    function GetCurrentBoxDocumentCount: Integer;
    function AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem): Boolean;
  private
    function CreateArchiveBoxByDocument(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;
    function AddDocumentToCurrentBox(const ADocument: IArchiveDocumentItem): Boolean;
    function AddDocumentToOldestOpenedArchiveBox(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;
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
  uTArchiveCompanyItem;

function TDocumentArchivingBusinessLogic.GetCurrentBoxDocumentCount: Integer;
begin
  Result := GetDocumentCount(CurrentBox);
end;

procedure TDocumentArchivingBusinessLogic.ManualPrintCurrentBoxSticker;
begin
  if PrintCurrentBoxSticker then
  begin
    DisplaySuccessMessage('Стикер на текущий короб распечатан');
  end
  else
  begin
    DisplayErrorMessage('Не удалось распечатать стикер на текущий короб');
  end;
end;

procedure TDocumentArchivingBusinessLogic.ManualDeleteLastDocumentFromCurrentBox;
begin
  if DeleteLastDocumentFromCurrentBox then
  begin
    DisplaySuccessMessage('Последний документ из текущего короба удалён');
  end
  else
  begin
    DisplayErrorMessage('Не удалось удалить последний документ из текущего короба');
  end;
end;

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

function TDocumentArchivingBusinessLogic.CreateArchiveBoxByDocument(const ADocument: IArchiveDocumentItem)
  : IArchiveBoxItem;
begin
  Result := nil;
  if Assigned(ADocument) then
  begin
    if CanAddDocument then
    begin
      Result := TArchiveBoxItem.Create;
      if Assigned(Result) then
      begin
        Result.UserId := CurrentUserId;
        Result.CreationDate := Now;
        Result.TypeId := ArchiveBoxTypeId;
        Result.CompanyId := ADocument.CompanyId;
        Result.Year := CurrentYear; { TODO -ov_ivanov : изменить алгоритм инициализации года короба }
        Result.Number := GetNewArchiveBoxNumber(Result.TypeId, Result.CompanyId, Result.Year);
        if Result.Number > 0 then
        begin
          Result.Save(Connection);
          Result.Load;
          ADocument.ArchiveBoxId := Result.Id;
          ADocument.SequenceNumber := 1; // первый бланк в новом коробе
          Result.Documents.Add(ADocument);
          Result.Documents.Save;
        end
        else
        begin
          Result := nil;
        end;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.AddDocumentToCurrentBox(const ADocument: IArchiveDocumentItem): Boolean;
begin
  Result := False;
  if Assigned(ADocument) and Assigned(CurrentBox) then
  begin
    if CanAddDocument then
    begin
      if ADocument.CompanyId = CurrentBox.CompanyId then
      begin
        ADocument.ArchiveBoxId := CurrentBox.Id;
        if Assigned(CurrentBox.Documents) then
        begin
          ADocument.SequenceNumber := CurrentBox.Documents.Count + 1;
          if CurrentBox.Documents.Add(ADocument) > -1 then
          begin
            Result := CurrentBox.Documents.Save;
          end
          else
          begin
            DisplayErrorMessage('Документ не удалось добавить в короб');
          end;
        end;
      end
      else
      begin
        DisplayErrorMessage('Компания документа не соответствует компании короба');
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.AddDocumentToOldestOpenedArchiveBox(const ADocument: IArchiveDocumentItem)
  : IArchiveBoxItem;
var
  old_box_id: Integer;
begin
  Result := nil;
  if Assigned(ADocument) then
  begin
    if CanAddDocument then
    begin
      old_box_id := -1;
      SetSQLForQuery(Query, Format('BSOArchiving_sel_OldestOpenedArchiveBox %d, %d',
        [ArchiveBoxTypeId, ADocument.CompanyId]), True);
      try
        if not Query.Eof then
        begin
          old_box_id := Query.Fields[0].AsInteger;
          if old_box_id > -1 then
          begin
            DisplaySuccessMessage('Получен идентифкатор старейшего открытого короба');
          end
          else
          begin
            DisplayErrorMessage('Не удалось получить идентифкатор старейшего открытого короба');
          end;
        end;
      finally
        Query.Close;
      end;
      if old_box_id > -1 then
      begin
        Result := TArchiveBoxItem.Create(Connection, old_box_id);
        if Assigned(Result) then
        begin
          Result.UserId := CurrentUserId;
          Result.Save(Connection);
          Result.Load;
          ADocument.ArchiveBoxId := Result.Id;
          if Assigned(Result.Documents) then
          begin
            ADocument.SequenceNumber := Result.Documents.Count + 1;
            Result.Documents.Add(ADocument);
            Result.Documents.Save;
          end
          else
          begin
            Result := nil;
          end;
        end
        else
        begin
          Result := nil;
        end;
      end;
    end
    else
    begin
      DisplayErrorMessage('Компания документа не соответствует компании короба');
    end;
  end;
end;

procedure TDocumentArchivingBusinessLogic.ProcessString(const AString: string);
var
  i: Integer;
  box: IArchiveBoxItem;
begin
  case ArchiveBoxTypeId of
    1:
      ;
    2:
      ;
    5:
      ;
  else
    begin
      Exit;
    end;
  end;

  case AnalizeBarcode(AString) of
    dabtUnknown:
      DisplayErrorMessage('Введён неизвестный штрих-код');
    dabtBSO:
      begin
        DisplaySuccessMessage('Введён штрих-код БСО');
        if CanAddDocument then
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
                DisplayErrorMessage(Format('Документ уже был заархивирован ранее (штрих-код короба - %s)',
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
                    DisplaySuccessMessage('Документ добавлен в новый архивный короб');
                  end
                  else
                  begin
                    DisplayErrorMessage('Не удалось создать новый архивный короб для документа');
                  end;
                end
                else
                begin
                  CurrentBox := AddDocumentToOldestOpenedArchiveBox(CurrentDocument);
                  if Assigned(CurrentBox) then
                  begin
                    DisplaySuccessMessage('Документ добавлен в существующий архивный короб');
                  end
                  else
                  begin
                    DisplayErrorMessage('Не удалось добавить документ в существующий архивный короб');
                  end;
                end;
              end
              else
              begin
                if AddDocumentToCurrentBox(CurrentDocument) then
                begin
                  DisplaySuccessMessage('Документ добавлен в текущий архивный короб');
                end;
              end;

              if Assigned(CurrentBox) then
              begin
                if Assigned(CurrentBox.Documents) then
                begin
                  if (CurrentBox.Documents.Count = 2) and (not CurrentBox.StickerPrinted) then
                  begin
                    if PrintCurrentBoxSticker then
                    begin
                      DisplaySuccessMessage('Стикер на текущий короб распечатан автоматически');
                    end
                    else
                    begin
                      DisplayErrorMessage('Не удалось распечатать стикер на текущий короб автоматически');
                    end;
                  end;
                end;
              end;

              if CurrentBoxIsFull then
              begin
                if CloseCurrentBox then
                begin
                  DisplaySuccessMessage('Текущий короб заполнен и был закрыт');
                end
                else
                begin
                  DisplayErrorMessage('Текущий короб заполнен, но закрыть его не удалось');
                end;
              end;
            end;
          end;
        end
        else
        begin
          DisplayErrorMessage('Документ нельзя добавлять, поскольку идёт настройка вместимости коробов');
        end;
      end;
    dabtArchiveBox:
      begin
        DisplaySuccessMessage('Введён штрих-код архивного короба');
      end;
    dabtForceNewBoxCommand:
      begin
        if CloseCurrentBox then
        begin
          DisplaySuccessMessage('Текущий короб был закрыт');
        end
        else
        begin
          DisplayErrorMessage('Не удалось закрыть текущий короб');
        end;
      end;
    dabtPutBoxAsideCommand:
      begin
        if PutCurrentBoxAside then
        begin
          DisplaySuccessMessage('Текущий короб отложен');
        end
        else
        begin
          DisplayErrorMessage('Не удалось отложить текущий короб');
        end;
      end;
    dabtGiveDocumentAway:
      begin
        if GiveLastDocumentInCurrentBoxAway then
        begin
          DisplaySuccessMessage('Последний документ из текущего короба передан');
        end
        else
        begin
          DisplayErrorMessage('Не удалось передать последний документ из текущего короба');
        end;
      end;
  end;
  UpdateCurrentInfo;
end;

end.
