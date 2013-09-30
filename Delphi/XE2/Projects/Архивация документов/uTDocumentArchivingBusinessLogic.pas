unit uTDocumentArchivingBusinessLogic;

interface

uses
  uIArchiveBoxItem,
  uTCustomBusinessLogic,
  uIShowable,
  Controls,
  DB,
  uTOnDisplayMessage,
  uIArchiveDocumentItem,
  uIDocumentArchivingBusinessLogic,
  uICustomBSOItem,
  uTDocumentArchivingBarcodeType;

type
  TDocumentArchivingBusinessLogic = class abstract(TCustomBusinessLogic, IDocumentArchivingBusinessLogic)
  private
    /// <summary>
    /// ������� "������������" ���������� ������
    /// </summary>
    /// <param name="ABox">
    /// �����
    /// </param>
    function ReleaseBox(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// ������� "������������" ���������� ������
    /// </summary>
    /// <param name="ABox">
    /// �����
    /// </param>
    /// <returns>
    /// ������� �� �������� �����
    /// </returns>
    function PutBoxAside(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// ������� ������ ������� ��� ���������� ������
    /// </summary>
    /// <param name="ABox">
    /// �����
    /// </param>
    /// <returns>
    /// ������� �� ����������� ������ �� �����
    /// </returns>
    function PrintBoxSticker(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// ������� �������� ���������� ������
    /// </summary>
    /// <param name="ABox">
    /// �����
    /// </param>
    /// <returns>
    /// ������� �� ������� �����
    /// </returns>
    function CloseBox(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// ������� �������� ���������� ������ �� �������������
    /// </summary>
    /// <param name="ABox">
    /// �����
    /// </param>
    /// <returns>
    /// �������� �� �����
    /// </returns>
    function BoxIsFull(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// ������� ����������� ����������� ���������� ���� ������
    /// ���������� ����
    /// </summary>
    /// <param name="AType">
    /// ��� ������
    /// </param>
    /// <returns>
    /// ���������� ���������� � ������ ���� ������
    /// </returns>
    function GetBoxCapacity(const AType: Integer): Integer; overload;

    /// <summary>
    /// ������� ����������� ����������� ���������� ���� ������
    /// ���������� ����
    /// </summary>
    /// <param name="ABox">
    /// �����
    /// </param>
    /// <returns>
    /// ���������� ���������� � ������ ���� ������
    /// </returns>
    function GetBoxCapacity(const ABox: IArchiveBoxItem): Integer; overload;

    /// <summary>
    /// ��������� ����������� ������ ���������� "�������������" �������
    /// </summary>
    procedure Show(const AParentControl: TCustomControl; const AShowableItem: IShowable);

    /// <summary>
    /// ���������, ����������� ����� ������ � ������� ������ � ��������� ��������� � ������� ������
    /// </summary>
    procedure UpdateCurrentInfo;

    /// <summary>
    /// ������� �������� �������� ������
    /// </summary>
    function CloseCurrentBox: Boolean;

    /// <summary>
    /// ������� ������ ������� �� ������� �����
    /// </summary>
    function PrintCurrentBoxSticker: Boolean;

    /// <summary>
    /// ������� �������� �������� ������
    /// </summary>
    function DeleteCurrentBox: Boolean;

    /// <summary>
    /// ������� ����������� "�������������" �������� ������
    /// </summary>
    function CurrentBoxIsFull: Boolean;

    /// <summary>
    /// ������� "������������" �������� ������
    /// </summary>
    function PutCurrentBoxAside: Boolean;

    /// <summary>
    /// ������� �������� ���������� ��������� �� �������� ������
    /// </summary>
    function GiveLastDocumentInCurrentBoxAway: Boolean;

    /// <summary>
    /// ������� �������� ���������� ��������� �� �������� ������
    /// </summary>
    function DeleteLastDocumentFromCurrentBox: Boolean;

    /// <summary>
    /// ������� ��������� ���������� ���������� � ��������� ������
    /// </summary>
    /// <param name="ABox">
    /// �����
    /// </param>
    /// <returns>
    /// ���������� ����������
    /// </returns>
    function GetDocumentCount(const ABox: IArchiveBoxItem): Integer;

    /// <summary>
    /// �������, ����������� ����������� ���������� ������ ��������� � �����
    /// </summary>
    /// <returns>
    /// ���������� <b>True</b> � ������, ���� ����� ��������� �������� � �����
    /// </returns>
    /// <remarks>
    /// ���������, �� ��� �� � ������ ������ ��������� ��������� �����������
    /// �������
    /// </remarks>
    function CanAddDocument: Boolean;

    /// <summary>
    /// ������� ��������� ������ ������ ��� ������ �� ��������� ����,
    /// �������� � ����
    /// </summary>
    /// <param name="ATypeId">
    /// ��� ������
    /// </param>
    /// <param name="ACompanyId">
    /// ������������� ��������
    /// </param>
    /// <param name="AYear">
    /// ���
    /// </param>
    /// <returns>
    /// ���������� ����� ��������� ������c����������������� ����
    /// </returns>
    function GetNewArchiveBoxNumber(const ATypeId, ACompanyId, AYear: Integer): Integer;

    function IsArchiveBoxBarcode(const ABarcode: string): Boolean;
    function IsBSOBarcode(const ABarcode: string): Boolean;
    function IsForceNewBoxCommandBarcode(const ABarcode: string): Boolean;
    function IsPutBoxAsideCommandBarcode(const ABarcode: string): Boolean;
    function IsGiveLastDocumentAwayBarcode(const ABarcode: string): Boolean;
    function IsCauseOfDamageBarcode(const ABarcode: string): Boolean;

  protected
    function AnalizeBarcode(const ABarcode: string): TDocumentArchivingBarcodeType;
    function CreateDocumentItemByBarcode(const ABarcode: string): IArchiveDocumentItem;
    function CreateArchiveBoxByDocument(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;
    function AddDocumentToCurrentBox(const ADocument: IArchiveDocumentItem): Boolean;
    function AddDocumentToOldestOpenedArchiveBox(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;

    /// <summary>
    /// ������� ��������� �������������� ������ �� ���������� ���������
    /// </summary>
    function GetArchiveBoxIdByDocument(const ADocument: IArchiveDocumentItem): Integer;

    /// <summary>
    /// ������� ��������� ���������� �������� ������� ��� ���� � ��������
    /// ��������������� ���������� ���������
    /// </summary>
    /// <param name="ADocument">
    /// ��������
    /// </param>
    /// <returns>
    /// ���������� �������
    /// </returns>
    function GetOpenedBoxQuantity(const ADocument: IArchiveDocumentItem): Integer; overload;

    /// <summary>
    /// ������� ��������� ���������� �������� ������� ��� ���� � ��������
    /// </summary>
    /// <param name="AType">
    /// ��� ������
    /// </param>
    /// <param name="ACompanyId">
    /// ������������� ��������
    /// </param>
    /// <returns>
    /// ���������� �������
    /// </returns>
    function GetOpenedBoxQuantity(const ATypeId, ACompanyId: Integer): Integer; overload;

    /// <summary>
    /// ��������� ���������� � ������� ����� ��������� � ��������� �����-�����
    /// </summary>
    /// <param name="AString">
    /// �����-��� ���������
    /// </param>
    procedure AddDocument(const AString: string); virtual; abstract;

  private
    FCurrentBox: IArchiveBoxItem;
  protected
    function GetCurrentBox: IArchiveBoxItem;
    procedure SetCurrentBox(const AValue: IArchiveBoxItem);
  public
    /// <summary>
    /// ������� �������� �����
    /// </summary>
    property CurrentBox: IArchiveBoxItem read GetCurrentBox write SetCurrentBox nodefault;

  private
    FCurrentDocument: IArchiveDocumentItem;
    function GetCurrentDocument: IArchiveDocumentItem;
    procedure SetCurrentDocument(const AValue: IArchiveDocumentItem);
  protected
    /// <summary>
    /// ������� �������� - ��������, ������ � ������� ��� ������ ��������
    /// </summary>
    /// <remarks>
    /// �� ���� � �� ��, ��� ��������� �������� � ������� ������!
    /// </remarks>
    property CurrentDocument: IArchiveDocumentItem read GetCurrentDocument write SetCurrentDocument nodefault;

  private
    FCurrentBoxInfoControl: TCustomControl;
    function GetCurrentBoxInfoControl: TCustomControl;
    procedure SetCurrentBoxInfoControl(const AValue: TCustomControl);
  protected
    /// <summary>
    /// �������, � ������� ����� ��������� ���������� � ������� ������
    /// </summary>
    property CurrentBoxInfoControl: TCustomControl read GetCurrentBoxInfoControl
      write SetCurrentBoxInfoControl nodefault;

  private
    FLastDocumentInfoControl: TCustomControl;
    function GetLastDocumentInfoControl: TCustomControl;
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);
  protected
    /// <summary>
    /// �������, � ������� ����� ��������� ���������� � ��������� ���������
    /// </summary>
    property LastDocumentInfoControl: TCustomControl read GetLastDocumentInfoControl
      write SetLastDocumentInfoControl nodefault;

  private
    FCurrentUserId: Integer;
    function GetCurrentUserId: Integer;
  protected
    /// <summary>
    /// ������������� �������� ������������
    /// </summary>
    property CurrentUserId: Integer read GetCurrentUserId nodefault;

  private
    FStep: Integer;
    function GetStep: Integer;
    procedure SetStep(const AValue: Integer);
  protected
    property Step: Integer read GetStep write SetStep nodefault;

  protected
    function GetArchiveBoxTypeId: Integer; virtual; abstract;
    /// <summary>
    /// ������������� ���� ��������� ������
    /// </summary>
    property ArchiveBoxTypeId: Integer read GetArchiveBoxTypeId nodefault;

  public
    constructor Create(const AConnection: TCustomConnection; const ACurrentUserId: Integer;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce; virtual;
    destructor Destroy; override;
    procedure ManualPrintCurrentBoxSticker;
    procedure ManualDeleteLastDocumentFromCurrentBox;
    function GetCurrentBoxDocumentCount: Integer;
    procedure ProcessString(const AString: string);

    function AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem): Boolean;
  end;

resourcestring
  RsEnterBarcodeOfDocumentOrCommand = '������� �����-��� ��������� ��� �������';

implementation

uses
  StdCtrls,
  SysUtils,
  uCommonRoutines,
  uIShowableField,
  uTArchiveBoxItem,
  uTReportDataModule,
  uIArchiveCompanyItem,
  uIArchiveBoxTypeItem,
  uTArchiveCompanyItem,
  uTArchiveBoxTypeItem,
  uICauseOfDamageList,
  uTCauseOfDamageList,
  uTArchiveDocumentListClass,
  uTArchiveDocumentItemClass,
  uIDamagedBSOItem,
  uTDamagedBSOItem,
  uTDamagedBSOList;

function TDocumentArchivingBusinessLogic.GetArchiveBoxIdByDocument(const ADocument: IArchiveDocumentItem): Integer;
begin
  Result := -1;
  if Assigned(ADocument) then
  begin
    Result := ADocument.AlreadyArchived(Connection);
  end;
end;

function TDocumentArchivingBusinessLogic.GetCurrentBox: IArchiveBoxItem;
begin
  Result := FCurrentBox;
end;

function TDocumentArchivingBusinessLogic.GetCurrentBoxInfoControl: TCustomControl;
begin
  Result := FCurrentBoxInfoControl;
end;

function TDocumentArchivingBusinessLogic.GetCurrentDocument: IArchiveDocumentItem;
begin
  Result := FCurrentDocument;
end;

function TDocumentArchivingBusinessLogic.GetCurrentUserId: Integer;
begin
  Result := FCurrentUserId;
end;

function TDocumentArchivingBusinessLogic.GetDocumentCount(const ABox: IArchiveBoxItem): Integer;
begin
  Result := -1;
  if Assigned(ABox) then
  begin
    if Assigned(ABox.Documents) then
    begin
      Result := ABox.Documents.Count;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.GetLastDocumentInfoControl: TCustomControl;
begin
  Result := FLastDocumentInfoControl;
end;

function TDocumentArchivingBusinessLogic.GetOpenedBoxQuantity(const ADocument: IArchiveDocumentItem): Integer;
var
  box: IArchiveBoxItem;
begin
  Result := -1;
  if Assigned(ADocument) then
  begin
    if ADocument.ArchiveBoxId > -1 then
    begin
      box := TArchiveBoxItem.Create(Connection, ADocument.ArchiveBoxId);
      if Assigned(box) then
      begin
        if (box.TypeId > -1) and (box.CompanyId > -1) then
        begin
          Result := GetOpenedBoxQuantity(box.TypeId, box.CompanyId);
        end;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.GetOpenedBoxQuantity(const ATypeId, ACompanyId: Integer): Integer;
begin
  Result := -1;
  if (ATypeId > -1) and (ACompanyId > -1) then
  begin
    SetSQLForQuery(Query, Format('BSOArchiving_sel_OpenedArchiveBoxCount %d, %d', [ATypeId, ACompanyId]), True);
    try
      if not Query.Eof then
      begin
        Result := Query.Fields[0].AsInteger;
      end;
    finally
      Query.Close;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.GetStep: Integer;
begin
  Result := FStep;
end;

function TDocumentArchivingBusinessLogic.GiveLastDocumentInCurrentBoxAway: Boolean;
begin
  Result := DeleteLastDocumentFromCurrentBox;
end;

procedure TDocumentArchivingBusinessLogic.SetCurrentBox(const AValue: IArchiveBoxItem);
begin
  if FCurrentBox <> AValue then
  begin
    ReleaseBox(FCurrentBox);
    FCurrentBox := AValue;
  end;
end;

procedure TDocumentArchivingBusinessLogic.SetCurrentBoxInfoControl(const AValue: TCustomControl);
begin
  if FCurrentBoxInfoControl <> AValue then
  begin
    FCurrentBoxInfoControl := AValue;
  end;
end;

procedure TDocumentArchivingBusinessLogic.SetCurrentDocument(const AValue: IArchiveDocumentItem);
begin
  if FCurrentDocument <> AValue then
  begin
    FCurrentDocument := AValue;
  end;
end;

procedure TDocumentArchivingBusinessLogic.SetLastDocumentInfoControl(const AValue: TCustomControl);
begin
  if FLastDocumentInfoControl <> AValue then
  begin
    FLastDocumentInfoControl := AValue;
  end;
end;

procedure TDocumentArchivingBusinessLogic.SetStep(const AValue: Integer);
begin
  if FStep <> AValue then
  begin
    FStep := AValue;
  end;
  if FStep = 0 then
  begin
    CurrentDocument := nil;
  end;
end;

function TDocumentArchivingBusinessLogic.AnalizeBarcode(const ABarcode: string): TDocumentArchivingBarcodeType;
var
  s: string;
begin
  s := Trim(ABarcode);

  if IsArchiveBoxBarcode(s) then
  begin
    Result := dabtArchiveBox;
  end
  else
  begin
    if IsBSOBarcode(s) then
    begin
      Result := dabtBSO;
    end
    else
    begin
      if IsForceNewBoxCommandBarcode(s) then
      begin
        Result := dabtForceNewBoxCommand
      end
      else
      begin
        if IsPutBoxAsideCommandBarcode(s) then
        begin
          Result := dabtPutBoxAsideCommand;
        end
        else
        begin
          if IsGiveLastDocumentAwayBarcode(s) then
          begin
            Result := dabtGiveDocumentAway;
          end
          else
          begin
            if IsCauseOfDamageBarcode(s) then
            begin
              Result := dabtCauseOfDamage;
            end
            else
            begin
              Result := dabtUnknown;
            end;
          end;
        end;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.BoxIsFull(const ABox: IArchiveBoxItem): Boolean;
var
  box_capacity: Integer;
  box_documents_count: Integer;
begin
  box_capacity := GetBoxCapacity(ABox);
  box_documents_count := GetDocumentCount(ABox);
  Result := ((box_capacity > -1) and (box_documents_count > -1)) and (box_documents_count >= box_capacity);
end;

function TDocumentArchivingBusinessLogic.GetBoxCapacity(const AType: Integer): Integer;
var
  box_type: IArchiveBoxTypeItem;
begin
  Result := -1;
  if AType <> -1 then
  begin
    if Assigned(Connection) then
    begin
      if Connection.Connected then
      begin
        box_type := TArchiveBoxTypeItem.Create(Connection, AType);
        Result := box_type.Capacity;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.GetBoxCapacity(const ABox: IArchiveBoxItem): Integer;
begin
  Result := -1;
  if Assigned(ABox) then
  begin
    Result := GetBoxCapacity(ABox.TypeId);
  end;
end;

function TDocumentArchivingBusinessLogic.CanAddDocument: Boolean;
begin
  Result := False;
  SetSQLForQuery(Query, Format('sys_sel_FlagValueInt %d', [79]), True);
  try
    if not Query.Eof then
    begin
      Result := Query.FieldByName('Value_Int').AsInteger = 0;
    end;
  finally
    Query.Close;
  end;
end;

function TDocumentArchivingBusinessLogic.CloseBox(const ABox: IArchiveBoxItem): Boolean;
begin
  Result := False;
  if Assigned(ABox) then
  begin
    if Assigned(ABox.Documents) then
    begin
      if ABox.Documents.Count > 0 then
      begin
        Result := PutBoxAside(ABox);
        if Result then
        begin
          if not ABox.Closed then
          begin
            ABox.ClosureDate := Now;
            ABox.Closed := True;
          end;
        end;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.ReleaseBox(const ABox: IArchiveBoxItem): Boolean;
begin
  Result := False;
  if Assigned(ABox) then
  begin
    ABox.UserId := -1;
    Result := ABox.Save(Connection);
  end;
end;

function TDocumentArchivingBusinessLogic.PutBoxAside(const ABox: IArchiveBoxItem): Boolean;
begin
  Result := False;
  if Assigned(ABox) then
  begin
    Result := ABox.StickerPrinted;
    if not Result then
    begin
      Result := PrintBoxSticker(ABox);
    end;
    if Result then
    begin
      Result := ReleaseBox(ABox);
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.PrintBoxSticker(const ABox: IArchiveBoxItem): Boolean;
var
  ac: IArchiveCompanyItem;
  abt: IArchiveBoxTypeItem;
begin
  Result := False;
  if Assigned(ABox) then
  begin
    ac := TArchiveCompanyItem.Create(Connection, ABox.CompanyId);
    abt := TArchiveBoxTypeItem.Create(Connection, ABox.TypeId);
    Result := PrintSticker(ABox.CompanyName, abt.Code, ac.Code, IntToStr(ABox.Year), Format('%.6d', [ABox.Number]),
      ABox.Barcode, True);
    if Result then
    begin
      ABox.StickerPrinted := True;
    end;
  end;
end;

procedure TDocumentArchivingBusinessLogic.UpdateCurrentInfo;
var
  showable: IShowable;
begin
  EmptyControl(CurrentBoxInfoControl);
  EmptyControl(LastDocumentInfoControl);

  if Assigned(CurrentBox) then
  begin
    if Supports(CurrentBox, IShowable, showable) then
    begin
      Show(CurrentBoxInfoControl, showable);
    end;

    if Assigned(CurrentBox.Documents) then
    begin
      if CurrentBox.Documents.Count > 0 then
      begin
        if Supports(CurrentBox.Documents[CurrentBox.Documents.Count - 1], IShowable, showable) then
        begin
          Show(LastDocumentInfoControl, showable);
        end;
      end;
    end;
  end;
end;

procedure TDocumentArchivingBusinessLogic.Show(const AParentControl: TCustomControl; const AShowableItem: IShowable);
var
  l1, l2: TLabel;
  j: Integer;
  c: TControl;
  old_height: Integer;
  wc: TWinControl;
begin
  if (not Assigned(AParentControl)) or (not Assigned(AShowableItem)) then
  begin
    Exit;
  end;

  EmptyControl(AParentControl);
  old_height := AParentControl.Height;

  if Assigned(AShowableItem.ShowableFields) then
  begin
    for j := 0 to AShowableItem.ShowableFields.Count - 1 do
    begin
      c := GetControlByName('lblDocument' + IShowableField(AShowableItem.ShowableFields[j]).Name + 'Caption',
        AParentControl);
      if Assigned(c) then
      begin
        l1 := c as TLabel;
      end
      else
      begin
        l1 := TLabel.Create(AParentControl);
      end;
      if j = 0 then
      begin
        AParentControl.Height := Integer(AParentControl is TGroupBox) * 10 + l1.Margins.Top + l1.Margins.Bottom +
          AShowableItem.ShowableFields.Count * (17 + l1.Margins.Top);;
      end;
      l1.Name := 'lblDocument' + IShowableField(AShowableItem.ShowableFields[j]).Name + 'Caption';
      l1.Parent := AParentControl;
      l1.Caption := IShowableField(AShowableItem.ShowableFields[j]).Caption;
      l1.Left := 8;
      l1.Top := Integer(AParentControl is TGroupBox) * 10 + AParentControl.Margins.Top + AParentControl.Margins.Top + j
        * (17 + AParentControl.Margins.Top);

      c := GetControlByName('lblDocument' + IShowableField(AShowableItem.ShowableFields[j]).Name, AParentControl);
      if Assigned(c) then
      begin
        l2 := c as TLabel;
      end
      else
      begin
        l2 := TLabel.Create(AParentControl);
      end;
      if j = 0 then
      begin
        AParentControl.Height := Integer(AParentControl is TGroupBox) * 10 + l2.Margins.Top + l2.Margins.Bottom +
          AShowableItem.ShowableFields.Count * (17 + l2.Margins.Top);
        wc := AParentControl.Parent;
        while Assigned(wc) do
        begin
          wc.Height := wc.Height - (old_height - AParentControl.Height);
          wc := wc.Parent;
        end;
      end;
      l2.Name := 'lblDocument' + IShowableField(AShowableItem.ShowableFields[j]).Name;
      l2.Caption := IShowableField(AShowableItem.ShowableFields[j]).Value;
      l2.Parent := AParentControl;
      l2.Left := AParentControl.ClientWidth div 2 + 8;
      l2.Top := Integer(AParentControl is TGroupBox) * 10 + AParentControl.Margins.Top + AParentControl.Margins.Top + j
        * (17 + AParentControl.Margins.Top);
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.PrintCurrentBoxSticker: Boolean;
begin
  Result := False;
  if Assigned(CurrentBox) then
  begin
    Result := PrintBoxSticker(CurrentBox);
    if Result then
    begin
      Result := CurrentBox.Save(Connection);
      if Result then
      begin
        CurrentBox.Load(Connection);
        UpdateCurrentInfo;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.CloseCurrentBox: Boolean;
begin
  Result := False;
  if Assigned(CurrentBox) then
  begin
    Result := CloseBox(CurrentBox);
    if Result then
    begin
      Result := CurrentBox.Save;
      if Result then
      begin
        CurrentBox := nil;
        UpdateCurrentInfo;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.DeleteCurrentBox: Boolean;
begin
  Result := False;
  if Assigned(CurrentBox) then
  begin
    Result := PutBoxAside(CurrentBox);
    if Result then
    begin
      Result := CurrentBox.Delete;
      if Result then
      begin
        CurrentBox := nil;
        UpdateCurrentInfo;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.DeleteLastDocumentFromCurrentBox: Boolean;
begin
  Result := False;
  if Assigned(CurrentBox) then
  begin
    if Assigned(CurrentBox.Documents) then
    begin
      Result := CurrentBox.Documents.Delete(CurrentBox.Documents.Count - 1);
      if Result then
      begin
        if (CurrentBox.Documents.Count = 0) and (not CurrentBox.StickerPrinted) then
        begin
          Result := DeleteCurrentBox;
        end;
        UpdateCurrentInfo;
      end;
    end;
  end;
end;

destructor TDocumentArchivingBusinessLogic.Destroy;
begin
  PutCurrentBoxAside;
  inherited;
end;

constructor TDocumentArchivingBusinessLogic.Create(const AConnection: TCustomConnection; const ACurrentUserId: Integer;
  const AOnDisplayMessage: TOnDisplayMessage);
begin
  inherited Create(AConnection, AOnDisplayMessage);
  FCurrentUserId := ACurrentUserId;
  Step := 0;
  DisplayInfoMessage(RsEnterBarcodeOfDocumentOrCommand);
end;

function TDocumentArchivingBusinessLogic.CurrentBoxIsFull: Boolean;
begin
  Result := BoxIsFull(CurrentBox);
end;

function TDocumentArchivingBusinessLogic.PutCurrentBoxAside: Boolean;
begin
  Result := False;
  if Assigned(CurrentBox) then
  begin
    Result := PutBoxAside(CurrentBox);
    if Result then
    begin
      Result := CurrentBox.Save(Connection);
      if Result then
      begin
        CurrentBox := nil;
        UpdateCurrentInfo;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.IsArchiveBoxBarcode(const ABarcode: string): Boolean;
var
  s: string;
begin
  s := Trim(ABarcode);
  Result := (Length(s) = 12) and IsNumericString(s);
end;

function TDocumentArchivingBusinessLogic.IsBSOBarcode(const ABarcode: string): Boolean;
var
  s: string;
begin
  s := Trim(ABarcode);
  Result := (Length(s) >= 14) and IsNumericString(s);
end;

function TDocumentArchivingBusinessLogic.IsCauseOfDamageBarcode(const ABarcode: string): Boolean;
var
  s: string;
  codl: ICauseOfDamageList;
  i: Integer;
begin
  Result := False;
  s := Trim(ABarcode);
  codl := TCauseOfDamageList.Create(Connection);
  if Assigned(codl) then
  begin
    codl.Load;
    for i := 0 to codl.Count - 1 do
    begin
      if codl.Item[i].Barcode = s then
      begin
        Result := True;
        Break;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.IsForceNewBoxCommandBarcode(const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '010001';
end;

function TDocumentArchivingBusinessLogic.IsPutBoxAsideCommandBarcode(const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '010002';
end;

function TDocumentArchivingBusinessLogic.IsGiveLastDocumentAwayBarcode(const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '010003';
end;

function TDocumentArchivingBusinessLogic.CreateDocumentItemByBarcode(const ABarcode: string): IArchiveDocumentItem;
var
  Item: TArchiveDocumentItemClass;
begin
  Result := nil;
  if IsBSOBarcode(ABarcode) then
  begin
    Item := GetArchiveDocumentItemClassByTypeId(ArchiveBoxTypeId);
    if Assigned(Item) then
    begin
      Result := Item.Create(Connection, -1);
      if Assigned(Result) then
      begin
        Result.FromString(ABarcode);
        Result.ArchivedByUser := CurrentUserId;
        Result.ArchivingDate := Now;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.GetNewArchiveBoxNumber(const ATypeId, ACompanyId, AYear: Integer): Integer;
begin
  Result := -1;
  SetSQLForQuery(Query, Format('BSOArchiving_GetNewArchiveBoxNumber %d, %d, %d', [ATypeId, ACompanyId, AYear]), True);
  try
    if not Query.Eof then
    begin
      Result := Query.Fields[0].AsInteger;
    end;
  finally
    Query.Close;
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
            if Result.Documents.Add(ADocument) > -1 then
            begin
              if not Result.Documents.Save then
              begin
                Result := nil;
              end;
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
          end;
        end;
      end
      else
      begin
        DisplayErrorMessage('�������� ��������� �� ������������� �������� ������' + sLineBreak +
          RsEnterBarcodeOfDocumentOrCommand);
      end;
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
        Result.Year := CurrentYear; { TODO -ov_ivanov : �������� �������� ������������� ���� ������ }
        Result.Number := GetNewArchiveBoxNumber(Result.TypeId, Result.CompanyId, Result.Year);
        if Result.Number > 0 then
        begin
          Result.Save(Connection);
          Result.Load;
          ADocument.ArchiveBoxId := Result.Id;
          ADocument.SequenceNumber := 1; // ����� ������� ������ � ����� ������
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

function TDocumentArchivingBusinessLogic.GetCurrentBoxDocumentCount: Integer;
begin
  Result := GetDocumentCount(CurrentBox);
end;

procedure TDocumentArchivingBusinessLogic.ManualPrintCurrentBoxSticker;
begin
  if PrintCurrentBoxSticker then
    DisplaySuccessMessage('������ �� ������� ����� ����������' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand)
  else
    DisplayErrorMessage('�� ������� ����������� ������ �� ������� �����' + sLineBreak +
      RsEnterBarcodeOfDocumentOrCommand);
end;

procedure TDocumentArchivingBusinessLogic.ManualDeleteLastDocumentFromCurrentBox;
begin
  if DeleteLastDocumentFromCurrentBox then
    DisplaySuccessMessage('��������� �������� �� �������� ������ �����' + sLineBreak +
      RsEnterBarcodeOfDocumentOrCommand)
  else
    DisplayErrorMessage('�� ������� ������� ��������� �������� �� �������� ������' + sLineBreak +
      RsEnterBarcodeOfDocumentOrCommand);
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
begin
  if AnalizeBarcode(AString) in [dabtUnknown, dabtForceNewBoxCommand, dabtPutBoxAsideCommand, dabtGiveDocumentAway] then
  begin
    Step := 0;
    case AnalizeBarcode(AString) of
      dabtUnknown:
        begin
          DisplayErrorMessage('����� ����������� �����-���' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
          Exit;
        end;
      dabtForceNewBoxCommand:
        begin
          if CloseCurrentBox then
            DisplaySuccessMessage('������� ����� ��� ������' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand)
          else
            DisplayErrorMessage('�� ������� ������� ������� �����' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
        end;
      dabtPutBoxAsideCommand:
        begin
          if PutCurrentBoxAside then
            DisplaySuccessMessage('������� ����� �������' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand)
          else
            DisplayErrorMessage('�� ������� �������� ������� �����' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
        end;
      dabtGiveDocumentAway:
        begin
          if GiveLastDocumentInCurrentBoxAway then
            DisplaySuccessMessage('��������� �������� �� �������� ������ �������' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand)
          else
            DisplayErrorMessage('�� ������� �������� ��������� �������� �� �������� ������' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand);
        end;
    end
  end
  else
  begin
    if CanAddDocument then
    begin
      AddDocument(AString);

      if Assigned(CurrentBox) then
      begin
        if Assigned(CurrentBox.Documents) then
        begin
          if (CurrentBox.Documents.Count = 2) and (not CurrentBox.StickerPrinted) then
          begin
            if PrintCurrentBoxSticker then
            begin
              DisplaySuccessMessage('�������� ��� ������� �������� � ������� �����' + sLineBreak +
                '������ �� ������� ����� ���������� �������������' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
            end;
          end;
        end;
      end;

      if CurrentBoxIsFull then
      begin
        if CloseCurrentBox then
        begin
          DisplaySuccessMessage('������� ����� �������� � ��� ������' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
        end;
      end;
    end
    else
    begin
      Step := 0;
      DisplayErrorMessage('�������� ������ ���������, ��������� ��� ��������� ����������� �������' + sLineBreak +
        '��������� ��������� ���������, ����� ������� �����-��� ��������� ��� �������');
    end;
  end;
  UpdateCurrentInfo;
end;

end.
