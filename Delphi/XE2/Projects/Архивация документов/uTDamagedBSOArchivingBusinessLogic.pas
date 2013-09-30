unit uTDamagedBSOArchivingBusinessLogic;

interface

uses
  uTDocumentArchivingBusinessLogic;

type
  TDamagedBSOArchivingBusinessLogic = class sealed(TDocumentArchivingBusinessLogic)
  protected
    procedure ProcessDocument(const AString: string); override; final;
    function GetArchiveBoxTypeId: Integer; override; final;
  end;

implementation

uses
  SysUtils,
  uTDocumentArchivingBarcodeType,
  uIArchiveBoxItem,
  uTArchiveBoxItem,
  uICauseOfDamageList,
  uTCauseOfDamageList,
  uTDamagedBSOItem;

function TDamagedBSOArchivingBusinessLogic.GetArchiveBoxTypeId: Integer;
begin
  Result := 5;
end;

procedure TDamagedBSOArchivingBusinessLogic.ProcessDocument(const AString: string);
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

end.
