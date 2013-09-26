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
    DisplaySuccessMessage('������ �� ������� ����� ����������');
  end
  else
  begin
    DisplayErrorMessage('�� ������� ����������� ������ �� ������� �����');
  end;
end;

procedure TDocumentArchivingBusinessLogic.ManualDeleteLastDocumentFromCurrentBox;
begin
  if DeleteLastDocumentFromCurrentBox then
  begin
    DisplaySuccessMessage('��������� �������� �� �������� ������ �����');
  end
  else
  begin
    DisplayErrorMessage('�� ������� ������� ��������� �������� �� �������� ������');
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
      DisplayErrorMessage('����� ����������� �����-���');
    dabtBSO:
      begin
        DisplaySuccessMessage('����� �����-��� ���');
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
                DisplayErrorMessage(Format('�������� ��� ��� ������������� ����� (�����-��� ������ - %s)',
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
                    DisplaySuccessMessage('�������� �������� � ����� �������� �����');
                  end
                  else
                  begin
                    DisplayErrorMessage('�� ������� ������� ����� �������� ����� ��� ���������');
                  end;
                end
                else
                begin
                  CurrentBox := AddDocumentToOldestOpenedArchiveBox(CurrentDocument);
                  if Assigned(CurrentBox) then
                  begin
                    DisplaySuccessMessage('�������� �������� � ������������ �������� �����');
                  end
                  else
                  begin
                    DisplayErrorMessage('�� ������� �������� �������� � ������������ �������� �����');
                  end;
                end;
              end
              else
              begin
                if AddDocumentToCurrentBox(CurrentDocument) then
                begin
                  DisplaySuccessMessage('�������� �������� � ������� �������� �����');
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
                      DisplaySuccessMessage('������ �� ������� ����� ���������� �������������');
                    end
                    else
                    begin
                      DisplayErrorMessage('�� ������� ����������� ������ �� ������� ����� �������������');
                    end;
                  end;
                end;
              end;

              if CurrentBoxIsFull then
              begin
                if CloseCurrentBox then
                begin
                  DisplaySuccessMessage('������� ����� �������� � ��� ������');
                end
                else
                begin
                  DisplayErrorMessage('������� ����� ��������, �� ������� ��� �� �������');
                end;
              end;
            end;
          end;
        end
        else
        begin
          DisplayErrorMessage('�������� ������ ���������, ��������� ��� ��������� ����������� �������');
        end;
      end;
    dabtArchiveBox:
      begin
        DisplaySuccessMessage('����� �����-��� ��������� ������');
      end;
    dabtForceNewBoxCommand:
      begin
        if CloseCurrentBox then
        begin
          DisplaySuccessMessage('������� ����� ��� ������');
        end
        else
        begin
          DisplayErrorMessage('�� ������� ������� ������� �����');
        end;
      end;
    dabtPutBoxAsideCommand:
      begin
        if PutCurrentBoxAside then
        begin
          DisplaySuccessMessage('������� ����� �������');
        end
        else
        begin
          DisplayErrorMessage('�� ������� �������� ������� �����');
        end;
      end;
    dabtGiveDocumentAway:
      begin
        if GiveLastDocumentInCurrentBoxAway then
        begin
          DisplaySuccessMessage('��������� �������� �� �������� ������ �������');
        end
        else
        begin
          DisplayErrorMessage('�� ������� �������� ��������� �������� �� �������� ������');
        end;
      end;
  end;
  UpdateCurrentInfo;
end;

end.
