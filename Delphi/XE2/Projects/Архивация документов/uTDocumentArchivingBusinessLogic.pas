unit uTDocumentArchivingBusinessLogic;

interface

uses
  uTCustomBusinessLogic,
  uIDocumentArchivingBusinessLogic,
  uIArchiveBoxItem,
  uICustomBSOItem,
  Controls,
  DB,
  uTOnDisplayMessage,
  uIShowable,
  uIArchiveDocumentItem,
  uTDocumentArchivingBarcodeType,
  uIArchiveDocumentList;

type
  TDocumentArchivingBusinessLogic = class sealed(TCustomBusinessLogic, IDocumentArchivingBusinessLogic)
  public
    function ManualPrintCurrentBoxSticker: Boolean;
    function PutCurrentBoxAside: Boolean;
    function DeleteLastDocumentInCurrentBox: Boolean;
    function GiveLastDocumentInCurrentBoxAway: Boolean;

    procedure AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem);
    procedure ProcessString(const AString: string);
    constructor Create(const AConnection: TCustomConnection; const ACurrentUserId, AArchiveBoxTypeId: Integer;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce; virtual;
    destructor Destroy; override;

  private
    FCurrentBox: IArchiveBoxItem;
    function GetCurrentBox: IArchiveBoxItem;
    procedure SetCurrentBox(const AValue: IArchiveBoxItem);
  public
    property CurrentBox: IArchiveBoxItem read GetCurrentBox write SetCurrentBox nodefault;

  private
    FCurrentBoxInfoControl: TCustomControl;
    function GetCurrentBoxInfoControl: TCustomControl;
    procedure SetCurrentBoxInfoControl(const AValue: TCustomControl);
  public
    property CurrentBoxInfoControl: TCustomControl read GetCurrentBoxInfoControl
      write SetCurrentBoxInfoControl nodefault;

  private
    FLastDocumentInfoControl: TCustomControl;
    function GetLastDocumentInfoControl: TCustomControl;
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);
  public
    property LastDocumentInfoControl: TCustomControl read GetLastDocumentInfoControl
      write SetLastDocumentInfoControl nodefault;

  private
    FArchiveBoxTypeId: Integer;
    function GetArchiveBoxTypeId: Integer;
    /// <summary>
    /// Идентификатор типа архивного короба
    /// </summary>
    property ArchiveBoxTypeId: Integer read GetArchiveBoxTypeId nodefault;

  private
    FCurrentUserId: Integer;
    function GetCurrentUserId: Integer;
    /// <summary>
    /// Идентификатор текущего пользователя
    /// </summary>
    property CurrentUserId: Integer read GetCurrentUserId nodefault;

  private
    FCurrentDocument: IArchiveDocumentItem;
    function GetCurrentDocument: IArchiveDocumentItem;
    procedure SetCurrentDocument(const AValue: IArchiveDocumentItem);
    /// <summary>
    /// Текущий документ - документ, данные о котором ещё только вводятся
    /// </summary>
    /// <remarks>
    /// Не одно и то же, что последний документ в текущем коробе!
    /// </remarks>
    property CurrentDocument: IArchiveDocumentItem read GetCurrentDocument write SetCurrentDocument nodefault;

  private
    /// <summary>
    /// Процедура, выполняющая вывод данных о текущем коробе и последнем документе в текущем коробе
    /// </summary>
    procedure UpdateCurrentInfo;

    /// <summary>
    /// Функция закрытия текущего короба
    /// </summary>
    function CloseCurrentBox: Boolean;

    /// <summary>
    /// Функция удаления текущего короба
    /// </summary>
    function DeleteCurrentBox: Boolean;

    /// <summary>
    /// Функция определения "заполненности" текущего короба
    /// </summary>
    function CurrentBoxIsFull: Boolean;

    /// <summary>
    /// Функция определения вместимости указанного типа короба
    /// указанного типа
    /// </summary>
    /// <param name="AType">
    /// Тип короба
    /// </param>
    /// <returns>
    /// Количество документов в данном типе короба
    /// </returns>
    function GetBoxCapacity(const AType: Integer): Integer; overload;

    /// <summary>
    /// Функция определения вместимости указанного типа короба
    /// указанного типа
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    /// <returns>
    /// Количество документов в данном типе короба
    /// </returns>
    function GetBoxCapacity(const ABox: IArchiveBoxItem): Integer; overload;

    /// <summary>
    /// Процедура отображения данных указанного "отображаемого" объекта
    /// </summary>
    procedure Show(const AParentControl: TCustomControl; const AShowableItem: IShowable);

    /// <summary>
    /// Функция получения количества открытых коробов для типа и компании
    /// соответствующих указанному документу
    /// </summary>
    /// <param name="ADocument">
    /// Документ
    /// </param>
    /// <returns>
    /// Количество коробов
    /// </returns>
    function GetOpenedBoxQuantity(const ADocument: IArchiveDocumentItem): Integer; overload;

    /// <summary>
    /// Функция получения количества открытых коробов для типа и компании
    /// </summary>
    /// <param name="AType">
    /// Тип короба
    /// </param>
    /// <param name="ACompanyId">
    /// Идентификатор компании
    /// </param>
    /// <returns>
    /// Количество коробов
    /// </returns>
    function GetOpenedBoxQuantity(const ATypeId, ACompanyId: Integer): Integer; overload;

    function CloseBox(const ABox: IArchiveBoxItem): Boolean;
    function PutBoxAside(const ABox: IArchiveBoxItem): Boolean;
    function PrintBoxSticker(const ABox: IArchiveBoxItem): Boolean;
    function BoxIsFull(const ABox: IArchiveBoxItem): Boolean;
    function GetDocumentsCount(const ABox: IArchiveBoxItem): Integer;
    function AnalizeBarcode(const ABarcode: string): TDocumentArchivingBarcodeType;
    function IsArchiveBoxBarcode(const ABarcode: string): Boolean;
    function IsBSOBarcode(const ABarcode: string): Boolean;
    function IsForceNewBoxCommandBarcode(const ABarcode: string): Boolean;
    function IsPutBoxAsideCommandBarcode(const ABarcode: string): Boolean;
    function IsGiveLastDocumentAwayBarcode(const ABarcode: string): Boolean;
    function CreateDocumentItemByBarcode(const ABarcode: string): IArchiveDocumentItem;
    function CreateArchiveBoxByDocument(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;
    function AddDocumentToCurrentBox(const ADocument: IArchiveDocumentItem): Boolean;
    function GetNewArchiveBoxNumber(const ATypeId, ACompanyId, AYear: Integer): Integer;
    function AddDocumentToOldestOpenedArchiveBox(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;
    function ReleaseBox(const AArchiveBoxItem: IArchiveBoxItem): Boolean;
    function PrintCurrentBoxSticker: Boolean;
    /// <summary>
    /// Функция, проверяющая возможность добавления нового документа в короб
    /// </summary>
    /// <returns>
    /// Возвращает <b>True</b> в случае, если можно добавлять документ в короб
    /// </returns>
    /// <remarks>
    /// Проверяет, не идёт ли в данный момент процедура настройки вместимости
    /// коробов
    /// </remarks>
    function CanAddDocument: Boolean;
  end;

implementation

uses
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

function TDocumentArchivingBusinessLogic.GetLastDocumentInfoControl: TCustomControl;
begin
  Result := FLastDocumentInfoControl;
end;

procedure TDocumentArchivingBusinessLogic.SetCurrentBox(const AValue: IArchiveBoxItem);
begin
  if FCurrentBox <> AValue then
  begin
    if Assigned(FCurrentBox) then
    begin
      if not ReleaseBox(FCurrentBox) then
      begin
        DisplayErrorMessage('Не удалось освободить текущий короб');
      end;
    end;
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
          // закрываем короб
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

function TDocumentArchivingBusinessLogic.CloseCurrentBox: Boolean;
begin
  Result := False;
  if Assigned(CurrentBox) then
  begin
    Result := CloseBox(CurrentBox);
    if Result then
    begin
      // записываем данные в базу
      Result := CurrentBox.Save;
      if Result then
      begin
        CurrentBox := nil;
        UpdateCurrentInfo;
      end;
    end;
  end;
end;

constructor TDocumentArchivingBusinessLogic.Create(const AConnection: TCustomConnection;
  const ACurrentUserId, AArchiveBoxTypeId: Integer; const AOnDisplayMessage: TOnDisplayMessage);
begin
  inherited Create(AConnection, AOnDisplayMessage);
  FCurrentUserId := ACurrentUserId;
  FArchiveBoxTypeId := AArchiveBoxTypeId;
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

function TDocumentArchivingBusinessLogic.PrintCurrentBoxSticker: Boolean;
begin
  Result := False;
  if Assigned(CurrentBox) then
  begin
    Result := PrintBoxSticker(CurrentBox);
    if Result then
    begin
      // записываем данные в базу
      Result := CurrentBox.Save(Connection);
      if Result then
      begin
        CurrentBox.Load(Connection);
        UpdateCurrentInfo;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.ManualPrintCurrentBoxSticker: Boolean;
begin
  Result := PrintCurrentBoxSticker;
  if Result then
  begin
    DisplaySuccessMessage('Стикер на текущий короб распечатан');
  end
  else
  begin
    DisplayErrorMessage('Не удалось распечатать стикер на текущий короб');
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
      Result := PrintBoxSticker(ABox); // печатаем стикер
    end;
    if Result then
    begin
      if not ReleaseBox(ABox) then
      begin
        DisplayErrorMessage('Не удалось освободить текущий короб');
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.PutCurrentBoxAside: Boolean;
begin
  Result := False;
  if Assigned(CurrentBox) then
  begin
    Result := PutBoxAside(CurrentBox);
    if Result then
    begin
      // записываем данные в базу
      Result := CurrentBox.Save(Connection);
      if Result then
      begin
        CurrentBox := nil;
        UpdateCurrentInfo;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.ReleaseBox(const AArchiveBoxItem: IArchiveBoxItem): Boolean;
begin
  Result := False;
  if Assigned(AArchiveBoxItem) then
  begin
    AArchiveBoxItem.UserId := -1;
    Result := AArchiveBoxItem.Save(Connection);
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
      // удаляем короб из базы
      Result := CurrentBox.Delete;
      if Result then
      begin
        CurrentBox := nil;
        UpdateCurrentInfo;
        DisplaySuccessMessage('Текущий короб удалён');
      end
      else
      begin
        DisplayErrorMessage('Не удалось удалить текущий короб');
      end;
    end;
  end;
end;

procedure TDocumentArchivingBusinessLogic.AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem);
begin
  if Assigned(ABSO) then
  begin
    SetSQLForQuery(Query, Format('BSOArchiving_upd_AcceptanceRegister %d', [ABSO.BSOId]), True);
    try
      if not Query.Eof then
      begin
        if Query.Fields[0].AsInteger > -1 then
        begin
          DisplaySuccessMessage('Документ принят по реестру ЛП');
        end
        else
        begin
          DisplayErrorMessage('Документ не принят по реестру ЛП');
        end;
      end;
    finally
      Query.Close;
    end;
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
            Result := dabtUnknown;
          end;
        end;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.IsArchiveBoxBarcode(const ABarcode: string): Boolean;
begin
  Result := Length(Trim(ABarcode)) = 12;
end;

function TDocumentArchivingBusinessLogic.IsBSOBarcode(const ABarcode: string): Boolean;
begin
  Result := Length(Trim(ABarcode)) >= 14;
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

function TDocumentArchivingBusinessLogic.GetArchiveBoxTypeId: Integer;
begin
  Result := FArchiveBoxTypeId;
end;

function TDocumentArchivingBusinessLogic.CreateDocumentItemByBarcode(const ABarcode: string): IArchiveDocumentItem;
var
  item: TArchiveDocumentItemClass;
begin
  Result := nil;
  if IsBSOBarcode(ABarcode) then
  begin
    item := GetArchiveDocumentItemClassByTypeId(ArchiveBoxTypeId);
    Result := item.Create(Connection, -1);
    Result.FromString(ABarcode);
    Result.ArchivedByUser := CurrentUserId;
    Result.ArchivingDate := Now;
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
      if Result > -1 then
      begin
        DisplaySuccessMessage('Получен номер для нового короба');
      end
      else
      begin
        DisplayErrorMessage('Не удалось получить номер для нового короба');
      end;
    end;
  finally
    Query.Close;
  end;
end;

function TDocumentArchivingBusinessLogic.GetDocumentsCount(const ABox: IArchiveBoxItem): Integer;
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

function TDocumentArchivingBusinessLogic.BoxIsFull(const ABox: IArchiveBoxItem): Boolean;
var
  box_capacity: Integer;
  box_documents_count: Integer;
begin
  box_capacity := GetBoxCapacity(ABox);
  box_documents_count := GetDocumentsCount(ABox);
  Result := ((box_capacity > -1) and (box_documents_count > -1)) and (box_documents_count >= box_capacity);
end;

function TDocumentArchivingBusinessLogic.CurrentBoxIsFull: Boolean;
begin
  Result := BoxIsFull(CurrentBox);
end;

function TDocumentArchivingBusinessLogic.DeleteLastDocumentInCurrentBox: Boolean;
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
      end;
    end;
  end;
  if Result then
  begin
    UpdateCurrentInfo;
    DisplaySuccessMessage('Последний документ удалён');
  end
  else
  begin
    DisplayErrorMessage('Не удалось удалить последний документ');
  end;
end;

destructor TDocumentArchivingBusinessLogic.Destroy;
begin
  if Assigned(CurrentBox) then
  begin
    CurrentBox := nil;
  end;
  inherited;
end;

function TDocumentArchivingBusinessLogic.CreateArchiveBoxByDocument(const ADocument: IArchiveDocumentItem)
  : IArchiveBoxItem;
begin
  Result := nil;
  if Assigned(ADocument) then
  begin
    if CanAddDocument then
    begin
      DisplaySuccessMessage('Документ можно добавлять');
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
      DisplaySuccessMessage('Документ можно добавлять');
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
      DisplaySuccessMessage('Документ можно добавлять');
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

function TDocumentArchivingBusinessLogic.GiveLastDocumentInCurrentBoxAway: Boolean;
begin
  Result := DeleteLastDocumentInCurrentBox;
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

procedure TDocumentArchivingBusinessLogic.ProcessString(const AString: string);
var
  doc: IArchiveDocumentItem;
  i: Integer;
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
          doc := CreateDocumentItemByBarcode(AString);
          if Assigned(doc) then
          begin
            if not Assigned(CurrentBox) then
            begin
              i := GetOpenedBoxQuantity(ArchiveBoxTypeId, doc.CompanyId);
              if i = 0 then
              begin
                CurrentBox := CreateArchiveBoxByDocument(doc);
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
                CurrentBox := AddDocumentToOldestOpenedArchiveBox(doc);
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
              if AddDocumentToCurrentBox(doc) then
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
        end
        else
        begin
          DisplayErrorMessage('Документ нельзя добавлять, поскольку идёт настройка вместимости коробов');
        end;
      end;
    dabtArchiveBox:
      DisplaySuccessMessage('Введён штрих-код архивного короба');
    dabtForceNewBoxCommand:
      begin
        DisplaySuccessMessage('Введён штрих-код команды создания нового короба');
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
        DisplaySuccessMessage('Введён штрих-код команды откладывания короба');
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
        DisplaySuccessMessage('Введён штрих-код команды передачи последнего документа');
        if GiveLastDocumentInCurrentBoxAway then
        begin
          DisplaySuccessMessage('Последний документ передан');
        end
        else
        begin
          DisplayErrorMessage('Не удалось передать последний документ');
        end;
      end;
  end;
  UpdateCurrentInfo;
end;

end.
