unit uTTestedDocumentArchivingLogic;

interface

uses
  uIArchiveBoxItem,
  uTCustomBusinessLogic,
  uIShowable,
  Controls,
  DB,
  uTOnDisplayMessage,
  uIArchiveDocumentItem,
  uTDocumentArchivingBarcodeType;

type
  TTestedDocumentArchivingLogic = class abstract(TCustomBusinessLogic)
  protected
    /// <summary>
    /// Функция "освобождения" указанного короба
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    function ReleaseBox(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// Функция "откладывания" указанного короба
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    /// <returns>
    /// Удалось ли отложить короб
    /// </returns>
    function PutBoxAside(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// Функция печати стикера для указанного короба
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    /// <returns>
    /// Удалось ли распечатать стикер на короб
    /// </returns>
    function PrintBoxSticker(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// Функция закрытия указанного короба
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    /// <returns>
    /// Удалось ли закрыть короб
    /// </returns>
    function CloseBox(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// Функция проверки указанного короба на заполненность
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    /// <returns>
    /// Заполнен ли короб
    /// </returns>
    function BoxIsFull(const ABox: IArchiveBoxItem): Boolean;

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
    /// Процедура, выполняющая вывод данных о текущем коробе и последнем документе в текущем коробе
    /// </summary>
    procedure UpdateCurrentInfo;

    /// <summary>
    /// Функция закрытия текущего короба
    /// </summary>
    function CloseCurrentBox: Boolean;

    /// <summary>
    /// Функция печати стикера на текущий короб
    /// </summary>
    function PrintCurrentBoxSticker: Boolean;

    /// <summary>
    /// Функция удаления текущего короба
    /// </summary>
    function DeleteCurrentBox: Boolean;

    /// <summary>
    /// Функция определения "заполненности" текущего короба
    /// </summary>
    function CurrentBoxIsFull: Boolean;

    /// <summary>
    /// Функция "откладывания" текущего короба
    /// </summary>
    function PutCurrentBoxAside: Boolean;

    function GiveLastDocumentInCurrentBoxAway: Boolean;

    function DeleteLastDocumentFromCurrentBox: Boolean;

    /// <summary>
    /// Функция получения количества документов в указанном коробе
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    /// <returns>
    /// Количество документов
    /// </returns>
    function GetDocumentCount(const ABox: IArchiveBoxItem): Integer;

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

    /// <summary>
    /// Функция получения идентификатора короба по указанному документу
    /// </summary>
    function GetArchiveBoxIdByDocument(const ADocument: IArchiveDocumentItem): Integer;

    /// <summary>
    /// Функция получения нового номера для короба по указанным типу,
    /// компании и году
    /// </summary>
    /// <param name="ATypeId">
    /// Тип короба
    /// </param>
    /// <param name="ACompanyId">
    /// Идентификатор компании
    /// </param>
    /// <param name="AYear">
    /// Год
    /// </param>
    /// <returns>
    /// Порядковый номер архивного короба c начала указанного года
    /// </returns>
    function GetNewArchiveBoxNumber(const ATypeId, ACompanyId, AYear: Integer): Integer;

    function AnalizeBarcode(const ABarcode: string): TDocumentArchivingBarcodeType;

    function CreateDocumentItemByBarcode(const ABarcode: string): IArchiveDocumentItem;
    function CreateArchiveBoxByDocument(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;
    function AddDocumentToCurrentBox(const ADocument: IArchiveDocumentItem): Boolean;
    function AddDocumentToOldestOpenedArchiveBox(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;

    function IsArchiveBoxBarcode(const ABarcode: string): Boolean;
    function IsBSOBarcode(const ABarcode: string): Boolean;
    function IsForceNewBoxCommandBarcode(const ABarcode: string): Boolean;
    function IsPutBoxAsideCommandBarcode(const ABarcode: string): Boolean;
    function IsGiveLastDocumentAwayBarcode(const ABarcode: string): Boolean;
    function IsCauseOfDamageBarcode(const ABarcode: string): Boolean;

  public
    procedure ManualPrintCurrentBoxSticker;
    procedure ManualDeleteLastDocumentFromCurrentBox;
    function GetCurrentBoxDocumentCount: Integer;

  private
    FCurrentBox: IArchiveBoxItem;
  protected
    function GetCurrentBox: IArchiveBoxItem;
    procedure SetCurrentBox(const AValue: IArchiveBoxItem);
  public
    /// <summary>
    /// Текущий архивный короб
    /// </summary>
    property CurrentBox: IArchiveBoxItem read GetCurrentBox write SetCurrentBox nodefault;

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
  protected
    property CurrentDocument: IArchiveDocumentItem read GetCurrentDocument write SetCurrentDocument nodefault;

  private
    FCurrentBoxInfoControl: TCustomControl;
    function GetCurrentBoxInfoControl: TCustomControl;
  protected
    procedure SetCurrentBoxInfoControl(const AValue: TCustomControl);
    /// <summary>
    /// Контрол, в который будет выводится информация о текущем коробе
    /// </summary>
    property CurrentBoxInfoControl: TCustomControl read GetCurrentBoxInfoControl
      write SetCurrentBoxInfoControl nodefault;

  private
    FLastDocumentInfoControl: TCustomControl;
    function GetLastDocumentInfoControl: TCustomControl;
  protected
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);
    /// <summary>
    /// Контрол, в который будет выводится информация о последнем документе
    /// </summary>
    property LastDocumentInfoControl: TCustomControl read GetLastDocumentInfoControl
      write SetLastDocumentInfoControl nodefault;

  private
    FArchiveBoxTypeId: Integer;
    function GetArchiveBoxTypeId: Integer;
    /// <summary>
    /// Идентификатор типа архивного короба
    /// </summary>
  protected
    property ArchiveBoxTypeId: Integer read GetArchiveBoxTypeId nodefault;

  private
    FCurrentUserId: Integer;
    function GetCurrentUserId: Integer;
    /// <summary>
    /// Идентификатор текущего пользователя
    /// </summary>
  protected
    property CurrentUserId: Integer read GetCurrentUserId nodefault;

  private
    FStep: Integer;
    function GetStep: Integer;
    procedure SetStep(const AValue: Integer);
  protected
    property Step: Integer read GetStep write SetStep nodefault;

  public
    constructor Create(const AConnection: TCustomConnection; const ACurrentUserId, AArchiveBoxTypeId: Integer;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce; virtual;
    destructor Destroy; override;
  end;

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
  uTArchiveDocumentItemClass;

function TTestedDocumentArchivingLogic.GetArchiveBoxIdByDocument(const ADocument: IArchiveDocumentItem): Integer;
begin
  Result := -1;
  if Assigned(ADocument) then
  begin
    Result := ADocument.AlreadyArchived(Connection);
  end;
end;

function TTestedDocumentArchivingLogic.GetArchiveBoxTypeId: Integer;
begin
  Result := FArchiveBoxTypeId;
end;

function TTestedDocumentArchivingLogic.GetCurrentBox: IArchiveBoxItem;
begin
  Result := FCurrentBox;
end;

function TTestedDocumentArchivingLogic.GetCurrentBoxInfoControl: TCustomControl;
begin
  Result := FCurrentBoxInfoControl;
end;

function TTestedDocumentArchivingLogic.GetCurrentDocument: IArchiveDocumentItem;
begin
  Result := FCurrentDocument;
end;

function TTestedDocumentArchivingLogic.GetCurrentUserId: Integer;
begin
  Result := FCurrentUserId;
end;

function TTestedDocumentArchivingLogic.GetDocumentCount(const ABox: IArchiveBoxItem): Integer;
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

function TTestedDocumentArchivingLogic.GetLastDocumentInfoControl: TCustomControl;
begin
  Result := FLastDocumentInfoControl;
end;

function TTestedDocumentArchivingLogic.GetOpenedBoxQuantity(const ADocument: IArchiveDocumentItem): Integer;
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

function TTestedDocumentArchivingLogic.GetOpenedBoxQuantity(const ATypeId, ACompanyId: Integer): Integer;
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

function TTestedDocumentArchivingLogic.GetStep: Integer;
begin
  Result := FStep;
end;

function TTestedDocumentArchivingLogic.GiveLastDocumentInCurrentBoxAway: Boolean;
begin
  Result := DeleteLastDocumentFromCurrentBox;
end;

procedure TTestedDocumentArchivingLogic.SetCurrentBox(const AValue: IArchiveBoxItem);
begin
  if FCurrentBox <> AValue then
  begin
    ReleaseBox(FCurrentBox);
    FCurrentBox := AValue;
  end;
end;

procedure TTestedDocumentArchivingLogic.SetCurrentBoxInfoControl(const AValue: TCustomControl);
begin
  if FCurrentBoxInfoControl <> AValue then
  begin
    FCurrentBoxInfoControl := AValue;
  end;
end;

procedure TTestedDocumentArchivingLogic.SetCurrentDocument(const AValue: IArchiveDocumentItem);
begin
  if FCurrentDocument <> AValue then
  begin
    FCurrentDocument := AValue;
  end;
end;

procedure TTestedDocumentArchivingLogic.SetLastDocumentInfoControl(const AValue: TCustomControl);
begin
  if FLastDocumentInfoControl <> AValue then
  begin
    FLastDocumentInfoControl := AValue;
  end;
end;

procedure TTestedDocumentArchivingLogic.SetStep(const AValue: Integer);
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

function TTestedDocumentArchivingLogic.AnalizeBarcode(const ABarcode: string): TDocumentArchivingBarcodeType;
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

function TTestedDocumentArchivingLogic.BoxIsFull(const ABox: IArchiveBoxItem): Boolean;
var
  box_capacity: Integer;
  box_documents_count: Integer;
begin
  box_capacity := GetBoxCapacity(ABox);
  box_documents_count := GetDocumentCount(ABox);
  Result := ((box_capacity > -1) and (box_documents_count > -1)) and (box_documents_count >= box_capacity);
end;

function TTestedDocumentArchivingLogic.GetBoxCapacity(const AType: Integer): Integer;
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

function TTestedDocumentArchivingLogic.GetBoxCapacity(const ABox: IArchiveBoxItem): Integer;
begin
  Result := -1;
  if Assigned(ABox) then
  begin
    Result := GetBoxCapacity(ABox.TypeId);
  end;
end;

function TTestedDocumentArchivingLogic.CanAddDocument: Boolean;
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

function TTestedDocumentArchivingLogic.CloseBox(const ABox: IArchiveBoxItem): Boolean;
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

function TTestedDocumentArchivingLogic.ReleaseBox(const ABox: IArchiveBoxItem): Boolean;
begin
  Result := False;
  if Assigned(ABox) then
  begin
    ABox.UserId := -1;
    Result := ABox.Save(Connection);
  end;
end;

function TTestedDocumentArchivingLogic.PutBoxAside(const ABox: IArchiveBoxItem): Boolean;
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

function TTestedDocumentArchivingLogic.PrintBoxSticker(const ABox: IArchiveBoxItem): Boolean;
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

procedure TTestedDocumentArchivingLogic.UpdateCurrentInfo;
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

procedure TTestedDocumentArchivingLogic.Show(const AParentControl: TCustomControl; const AShowableItem: IShowable);
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

function TTestedDocumentArchivingLogic.PrintCurrentBoxSticker: Boolean;
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

function TTestedDocumentArchivingLogic.CloseCurrentBox: Boolean;
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

function TTestedDocumentArchivingLogic.DeleteCurrentBox: Boolean;
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

function TTestedDocumentArchivingLogic.DeleteLastDocumentFromCurrentBox: Boolean;
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

destructor TTestedDocumentArchivingLogic.Destroy;
begin
  PutCurrentBoxAside;
  // CurrentBox := nil;
  inherited;
end;

constructor TTestedDocumentArchivingLogic.Create(const AConnection: TCustomConnection;
  const ACurrentUserId, AArchiveBoxTypeId: Integer; const AOnDisplayMessage: TOnDisplayMessage);
begin
  inherited Create(AConnection, AOnDisplayMessage);
  FCurrentUserId := ACurrentUserId;
  FArchiveBoxTypeId := AArchiveBoxTypeId;
  Step := 0;
  DisplayInfoMessage('Введите штрих-код документа или команды');
end;

function TTestedDocumentArchivingLogic.CurrentBoxIsFull: Boolean;
begin
  Result := BoxIsFull(CurrentBox);
end;

function TTestedDocumentArchivingLogic.PutCurrentBoxAside: Boolean;
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

function TTestedDocumentArchivingLogic.IsArchiveBoxBarcode(const ABarcode: string): Boolean;
var
  s: string;
begin
  s := Trim(ABarcode);
  Result := (Length(s) = 12) and IsNumericString(s);
end;

function TTestedDocumentArchivingLogic.IsBSOBarcode(const ABarcode: string): Boolean;
var
  s: string;
begin
  s := Trim(ABarcode);
  Result := (Length(s) >= 14) and IsNumericString(s);
end;

function TTestedDocumentArchivingLogic.IsCauseOfDamageBarcode(const ABarcode: string): Boolean;
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

function TTestedDocumentArchivingLogic.IsForceNewBoxCommandBarcode(const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '010001';
end;

function TTestedDocumentArchivingLogic.IsPutBoxAsideCommandBarcode(const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '010002';
end;

function TTestedDocumentArchivingLogic.IsGiveLastDocumentAwayBarcode(const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '010003';
end;

function TTestedDocumentArchivingLogic.CreateDocumentItemByBarcode(const ABarcode: string): IArchiveDocumentItem;
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

function TTestedDocumentArchivingLogic.GetNewArchiveBoxNumber(const ATypeId, ACompanyId, AYear: Integer): Integer;
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

function TTestedDocumentArchivingLogic.AddDocumentToOldestOpenedArchiveBox(const ADocument: IArchiveDocumentItem)
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

function TTestedDocumentArchivingLogic.AddDocumentToCurrentBox(const ADocument: IArchiveDocumentItem): Boolean;
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
        DisplayErrorMessage('Компания документа не соответствует компании короба' + sLineBreak + 'Введите штрих-код документа или команды');
      end;
    end;
  end;
end;

function TTestedDocumentArchivingLogic.CreateArchiveBoxByDocument(const ADocument: IArchiveDocumentItem)
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
          ADocument.SequenceNumber := 1; // номер первого бланка в новом коробе
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

function TTestedDocumentArchivingLogic.GetCurrentBoxDocumentCount: Integer;
begin
  Result := GetDocumentCount(CurrentBox);
end;

procedure TTestedDocumentArchivingLogic.ManualPrintCurrentBoxSticker;
begin
  if PrintCurrentBoxSticker then
    DisplaySuccessMessage('Стикер на текущий короб распечатан' + sLineBreak + 'Введите штрих-код документа или команды')
  else
    DisplayErrorMessage('Не удалось распечатать стикер на текущий короб' + sLineBreak + 'Введите штрих-код документа или команды');
end;

procedure TTestedDocumentArchivingLogic.ManualDeleteLastDocumentFromCurrentBox;
begin
  if DeleteLastDocumentFromCurrentBox then
    DisplaySuccessMessage('Последний документ из текущего короба удалён' + sLineBreak + 'Введите штрих-код документа или команды')
  else
    DisplayErrorMessage('Не удалось удалить последний документ из текущего короба' + sLineBreak + 'Введите штрих-код документа или команды');
end;

end.
