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
  uTDocumentArchivingBarcodeType;

type
  TDocumentArchivingBusinessLogic = class sealed(TCustomBusinessLogic,
    IDocumentArchivingBusinessLogic)
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
    FCurrentUserId: Integer;
    function GetCurrentUserId: Integer;
  public
    property CurrentUserId: Integer read GetCurrentUserId nodefault;

  private
    FArchiveBoxTypeId: Integer;
    function GetArchiveBoxTypeId: Integer;
  public
    property ArchiveBoxTypeId: Integer read GetArchiveBoxTypeId nodefault;

  private
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
    /// Процедура очистки указанного контрола
    /// </summary>
    procedure ClearControl(const AControl: TCustomControl);

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
  public
    procedure ShowCurrentBoxInfo;
    procedure ShowLastDocumentInfo;
    function PrintCurrentBoxSticker: Boolean;
    function PutCurrentBoxAside: Boolean;
    function CloseCurrentBox: Boolean;
    function DeleteCurrentBox: Boolean;
    function CurrentBoxIsFull: Boolean;
    procedure AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem);
    procedure ProcessBarcode(const ABarcode: string);
  public
    constructor Create(const AConnection: TCustomConnection;
      const ACurrentUserId, AArchiveBoxTypeId: Integer;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce; virtual;
  private
    function CreateDocumentItemByBarcode(const ABarcode: string): IArchiveDocumentItem;
    function CreateArchiveBoxItemByDocument(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;
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
  uIShowableField;

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

function TDocumentArchivingBusinessLogic.GetCurrentUserId: Integer;
begin
  Result := FCurrentUserId;
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

function TDocumentArchivingBusinessLogic.GetLastDocumentInfoControl: TCustomControl;
begin
  Result := FLastDocumentInfoControl;
end;

procedure TDocumentArchivingBusinessLogic.ClearControl(const AControl: TCustomControl);
var
  i: Integer;
  c: TControl;
begin
  if Assigned(AControl) then
  begin
    for i := AControl.ControlCount - 1 downto 0 do
    begin
      c := AControl.Controls[i];
      c.Parent := nil;
      FreeAndNil(c);
    end;
  end;
end;

procedure TDocumentArchivingBusinessLogic.SetCurrentBox(const AValue: IArchiveBoxItem);
begin
  if FCurrentBox <> AValue then
  begin
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

procedure TDocumentArchivingBusinessLogic.SetLastDocumentInfoControl(const AValue: TCustomControl);
begin
  if FLastDocumentInfoControl <> AValue then
  begin
    FLastDocumentInfoControl := AValue;
  end;
end;

procedure TDocumentArchivingBusinessLogic.Show(const AParentControl: TCustomControl;
  const AShowableItem: IShowable);
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

  ClearControl(AParentControl);
  old_height := AParentControl.Height;

  if Assigned(AShowableItem.ShowableFields) then
  begin
    for j := 0 to AShowableItem.ShowableFields.Count - 1 do
    begin
      c := GetControlByName('lblDocument' + IShowableField(AShowableItem.ShowableFields[j]).Name +
        'Caption', AParentControl);
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
        AParentControl.Height := Integer(AParentControl is TGroupBox) * 10 + l1.Margins.Top +
          l1.Margins.Bottom + AShowableItem.ShowableFields.Count * (17 + l1.Margins.Top);;
      end;
      l1.Name := 'lblDocument' + IShowableField(AShowableItem.ShowableFields[j]).Name + 'Caption';
      l1.Parent := AParentControl;
      l1.Caption := IShowableField(AShowableItem.ShowableFields[j]).Caption;
      l1.Left := 8;
      l1.Top := Integer(AParentControl is TGroupBox) * 10 + AParentControl.Margins.Top +
        AParentControl.Margins.Top + j * (17 + AParentControl.Margins.Top);

      c := GetControlByName('lblDocument' + IShowableField(AShowableItem.ShowableFields[j]).Name,
        AParentControl);
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
        AParentControl.Height := Integer(AParentControl is TGroupBox) * 10 + l2.Margins.Top +
          l2.Margins.Bottom + AShowableItem.ShowableFields.Count * (17 + l2.Margins.Top);
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
      l2.Top := Integer(AParentControl is TGroupBox) * 10 + AParentControl.Margins.Top +
        AParentControl.Margins.Top + j * (17 + AParentControl.Margins.Top);
    end;
  end;
end;

procedure TDocumentArchivingBusinessLogic.ShowCurrentBoxInfo;
var
  showable: IShowable;
begin
  if Supports(CurrentBox, IShowable, showable) then
  begin
    Show(CurrentBoxInfoControl, showable);
  end;
end;

procedure TDocumentArchivingBusinessLogic.ShowLastDocumentInfo;
var
  showable: IShowable;
begin
  if Supports(nil, IShowable, showable) then
  begin
    Show(LastDocumentInfoControl, showable);
  end;
end;

function TDocumentArchivingBusinessLogic.CloseBox(const ABox: IArchiveBoxItem): Boolean;
begin
  Result := False;
  if Assigned(ABox) then
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
        ClearControl(CurrentBoxInfoControl);
        CurrentBox := nil;
        DisplaySuccessMessage('Короб закрыт');
      end
      else
      begin
        DisplayErrorMessage('Не удалось закрыть короб');
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
begin
  Result := False;
  if Assigned(ABox) then
  begin
    ABox.StickerPrinted := True;
    Result := True;
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
      Result := CurrentBox.Save;
      if Result then
      begin
        CurrentBox.Load;
        ShowCurrentBoxInfo;
        DisplaySuccessMessage('Стикер на текущий короб распечатан');
      end
      else
      begin
        DisplayErrorMessage('Не удалось распечатать стикер на текущий короб');
      end;
    end;
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
      ABox.UserId := -1; // сбрасываем пользователя
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
      Result := CurrentBox.Save;
      if Result then
      begin
        ClearControl(CurrentBoxInfoControl);
        CurrentBox := nil;
        DisplaySuccessMessage('Текущий короб отложен');
      end
      else
      begin
        DisplayErrorMessage('Не удалось отложить текущий короб');
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
      // удаляем данные из базы
      Result := CurrentBox.Delete;
      if Result then
      begin
        ClearControl(CurrentBoxInfoControl);
        CurrentBox := nil;
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
    SetSQLForQuery(Query, Format('BSOArchiving_upd_AcceptanceRegister %d', [ABSO.BSOId]));
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

function TDocumentArchivingBusinessLogic.BoxIsFull(const ABox: IArchiveBoxItem): Boolean;
var
  box_capacity: Integer;
  box_documents_count: Integer;
begin
  box_capacity := GetBoxCapacity(ABox);
  box_documents_count := GetDocumentsCount(ABox);
  Result := ((box_capacity > -1) and (box_documents_count > -1)) and
    (box_documents_count >= box_capacity);
end;

function TDocumentArchivingBusinessLogic.CurrentBoxIsFull: Boolean;
begin
  Result := BoxIsFull(CurrentBox);
  if Result then
  begin
    DisplaySuccessMessage('Текущий короб заполнен');
  end
  else
  begin
    DisplayErrorMessage('Текущий короб не заполнен');
  end;
end;

function TDocumentArchivingBusinessLogic.AnalizeBarcode(const ABarcode: string)
  : TDocumentArchivingBarcodeType;
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
          Result := dabtUnknown;
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

function TDocumentArchivingBusinessLogic.IsForceNewBoxCommandBarcode
  (const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '010001';
end;

function TDocumentArchivingBusinessLogic.IsPutBoxAsideCommandBarcode
  (const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '010002';
end;

function TDocumentArchivingBusinessLogic.GetOpenedBoxQuantity(const ADocument
  : IArchiveDocumentItem): Integer;
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

function TDocumentArchivingBusinessLogic.GetOpenedBoxQuantity(const ATypeId,
  ACompanyId: Integer): Integer;
begin
  Result := -1;
  if (ATypeId > -1) and (ACompanyId > -1) then
  begin
    SetSQLForQuery(Query, Format('BSOArchiving_sel_OpenedArchiveBoxCount %d, %d',
      [ATypeId, ACompanyId]));
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

procedure TDocumentArchivingBusinessLogic.ProcessBarcode(const ABarcode: string);
var
  doc: IArchiveDocumentItem;
begin
  case AnalizeBarcode(ABarcode) of
    dabtUnknown:
      DisplayErrorMessage('Введён неизвестный штрих-код');
    dabtBSO:
      begin
        DisplaySuccessMessage('Введён штрих-код БСО');
        doc := CreateDocumentItemByBarcode(ABarcode);
        if Assigned(doc) then
        begin
          if Supports(doc, IShowable) then
          begin
            Show(LastDocumentInfoControl, doc as IShowable);
          end;
        end;
      end;
    dabtArchiveBox:
      DisplaySuccessMessage('Введён штрих-код архивного короба');
    dabtForceNewBoxCommand:
      begin
        DisplaySuccessMessage('Введён штрих-код команды создания нового короба');
        CloseCurrentBox;
      end;
    dabtPutBoxAsideCommand:
      begin
        DisplaySuccessMessage('Введён штрих-код команды откладывания короба');
        PutCurrentBoxAside;
      end;
  end;
end;

function TDocumentArchivingBusinessLogic.CreateDocumentItemByBarcode(const ABarcode: string)
  : IArchiveDocumentItem;
var
  item: TArchiveDocumentItemClass;
begin
  Result := nil;
  if IsBSOBarcode(ABarcode) then
  begin
    item := GetArchiveDocumentItemClassByTypeId(ArchiveBoxTypeId);
    Result := item.Create(Connection, -1);
    Result.FromString(ABarcode);
  end;
end;

function TDocumentArchivingBusinessLogic.CreateArchiveBoxItemByDocument
  (const ADocument: IArchiveDocumentItem): IArchiveBoxItem;
begin
  if Assigned(ADocument) then
  begin
    Result := TArchiveBoxItem.Create;
    Result.TypeId := ArchiveBoxTypeId;
    Result.CompanyId := 1; //ADocument.CompanyId;
    Result.Number := 1; // GetNewArchiveBoxNumber(ArchiveBoxTypeId, CompanyId);
    Result.Year := 2013; // ADocument.Year;
    Result.Barcode := '';
    Result.CreationDate := Now;
    Result.Save(Connection);
    Result.Load;
  end;
end;

end.
