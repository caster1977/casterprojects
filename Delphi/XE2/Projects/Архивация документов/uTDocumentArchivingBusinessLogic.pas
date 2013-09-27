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
          DisplayErrorMessage('����� ����������� �����-���' + sLineBreak + '������� �����-��� ��������� ��� �������');
          Exit;
        end;
      dabtForceNewBoxCommand:
        begin
          if CloseCurrentBox then
            DisplaySuccessMessage('������� ����� ��� ������' + sLineBreak + '������� �����-��� ��������� ��� �������')
          else
            DisplayErrorMessage('�� ������� ������� ������� �����' + sLineBreak + '������� �����-��� ��������� ��� �������');
        end;
      dabtPutBoxAsideCommand:
        begin
          if PutCurrentBoxAside then
            DisplaySuccessMessage('������� ����� �������' + sLineBreak + '������� �����-��� ��������� ��� �������')
          else
            DisplayErrorMessage('�� ������� �������� ������� �����' + sLineBreak + '������� �����-��� ��������� ��� �������');
        end;
      dabtGiveDocumentAway:
        begin
          if GiveLastDocumentInCurrentBoxAway then
            DisplaySuccessMessage('��������� �������� �� �������� ������ �������' + sLineBreak + '������� �����-��� ��������� ��� �������')
          else
            DisplayErrorMessage('�� ������� �������� ��������� �������� �� �������� ������' + sLineBreak + '������� �����-��� ��������� ��� �������');
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
              DisplaySuccessMessage('�������� ��� ������� �������� � ������� �����' + sLineBreak + '������ �� ������� ����� ���������� �������������' + sLineBreak + '������� �����-��� ��������� ��� �������');
            end;
          end;
        end;
      end;

      if CurrentBoxIsFull then
      begin
        if CloseCurrentBox then
        begin
          DisplaySuccessMessage('������� ����� �������� � ��� ������' + sLineBreak + '������� �����-��� ��������� ��� �������');
        end;
      end;
    end
    else
    begin
      Step := 0;
      DisplayErrorMessage('�������� ������ ���������, ��������� ��� ��������� ����������� �������' + sLineBreak + '��������� ��������� ���������, ����� ������� �����-��� ��������� ��� �������');
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
            DisplayInfoMessage('������� �����-��� ����� ���������');
          end
          else
          begin
            box := TArchiveBoxItem.Create(Connection, i);
            if Assigned(box) then
            begin
              DisplayErrorMessage(Format('�������� ��� ��� ������������� ����� (�����-��� ������ - %s)' + sLineBreak + '������� �����-��� ��������� ��� �������',
                [box.Barcode]));
            end;
          end;
        end
        else
        begin
          Step := 0;
          DisplayInfoMessage('�������� � ��������� �����-����� �� ������ � ���� ������' + sLineBreak + '������� �����-��� ��������� ��� �������');
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
                        DisplaySuccessMessage('�������� �������� � ����� �������� �����' + sLineBreak + '������� �����-��� ��������� ��� �������');
                      end;
                    end
                    else
                    begin
                      CurrentBox := AddDocumentToOldestOpenedArchiveBox(CurrentDocument);
                      if Assigned(CurrentBox) then
                      begin
                        DisplaySuccessMessage('�������� �������� � ������������ �������� �����' + sLineBreak + '������� �����-��� ��������� ��� �������');
                      end;
                    end;
                  end
                  else
                  begin
                    if AddDocumentToCurrentBox(CurrentDocument) then
                    begin
                      DisplaySuccessMessage('�������� �������� � ������� �������� �����' + sLineBreak + '������� �����-��� ��������� ��� �������');
                    end;
                  end;
                  Break;
                end;
              end;
            end;
          end
          else
          begin
            DisplayErrorMessage('�������� �� ��� ��������, �.�. �� ��� ����� �����-��� ����� ���������' + sLineBreak + '������� �����-��� ��������� ��� �������');
          end;
        end
        else
        begin
          DisplayInfoMessage('������� �����-��� ��������� ��� �������');
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
              DisplayErrorMessage(Format('�������� ��� ��� ������������� ����� (�����-��� ������ - %s)' + sLineBreak + '������� �����-��� ��������� ��� �������',
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
                  DisplaySuccessMessage('�������� �������� � ����� �������� �����' + sLineBreak + '������� �����-��� ��������� ��� �������');
                end;
              end
              else
              begin
                CurrentBox := AddDocumentToOldestOpenedArchiveBox(CurrentDocument);
                if Assigned(CurrentBox) then
                begin
                  DisplaySuccessMessage('�������� �������� � ������������ �������� �����' + sLineBreak + '������� �����-��� ��������� ��� �������');
                end;
              end;
            end
            else
            begin
              if AddDocumentToCurrentBox(CurrentDocument) then
              begin
                DisplaySuccessMessage('�������� �������� � ������� �������� �����' + sLineBreak + '������� �����-��� ��������� ��� �������');
              end;
            end;
          end;
        end;
      end;
  end;
end;

end.
