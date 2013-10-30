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
  uTDocumentArchivingBarcodeType,
  uTArchiveDocumentItemClass;

type
  TDocumentArchivingBusinessLogic = class {$IFNDEF VER150} abstract {$ENDIF}
    (TCustomBusinessLogic, IDocumentArchivingBusinessLogic)
  private
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

    /// <summary>
    /// Функция передачи последнего документа из текущего короба
    /// </summary>
    function GiveLastDocumentInCurrentBoxAway: Boolean;

    /// <summary>
    /// Функция удаления последнего документа из текущего короба
    /// </summary>
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

    function IsArchiveBoxBarcode(const ABarcode: string): Boolean;
    function IsBSOBarcode(const ABarcode: string): Boolean;
    function IsForceNewBoxCommandBarcode(const ABarcode: string): Boolean;
    function IsPutBoxAsideCommandBarcode(const ABarcode: string): Boolean;
    function IsGiveLastDocumentAwayBarcode(const ABarcode: string): Boolean;
    function IsCauseOfDamageBarcode(const ABarcode: string): Boolean;
    function ShowBoxBarcodeDialog(const ABoxBarcode: string): string;
  protected
    function AnalizeBarcode(const ABarcode: string): TDocumentArchivingBarcodeType;
    function CreateDocumentItemByBarcode(const ABarcode: string): IArchiveDocumentItem;
    function CreateArchiveBoxByDocument(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;
    function AddDocumentToCurrentBox(const ADocument: IArchiveDocumentItem): Boolean;
    function AddDocumentToOldestOpenedArchiveBox(const ADocument: IArchiveDocumentItem): IArchiveBoxItem;

    /// <summary>
    /// Функция получения идентификатора короба по указанному документу
    /// </summary>
    function GetArchiveBoxIdByDocument(const ADocument: IArchiveDocumentItem): Integer;

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
    /// Процедура добавления в текущий короб документа с указанным штрих-кодом
    /// </summary>
    /// <param name="AString">
    /// Штрих-код документа
    /// </param>
    procedure AddDocument(const AString: string); virtual; abstract;
  public
    /// <summary>
    /// Функция приёмки БСО по реестру
    /// </summary>
    /// <param name="ABarcode">
    /// Штрих-код БСО
    /// </param>
    /// <returns>
    /// Удалось ли принять по реестру
    /// </returns>
    function AcceptBSOByAcceptanceRegister(const ABarcode: string): Boolean;
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
  protected
    /// <summary>
    /// Текущий документ - документ, данные о котором ещё только вводятся
    /// </summary>
    /// <remarks>
    /// Не одно и то же, что последний документ в текущем коробе!
    /// </remarks>
    property CurrentDocument: IArchiveDocumentItem read GetCurrentDocument write SetCurrentDocument nodefault;

  private
    FCurrentBoxInfoControl: TCustomControl;
    function GetCurrentBoxInfoControl: TCustomControl;
    procedure SetCurrentBoxInfoControl(const AValue: TCustomControl);
  protected
    /// <summary>
    /// Контрол, в который будет выводится информация о текущем коробе
    /// </summary>
    property CurrentBoxInfoControl: TCustomControl read GetCurrentBoxInfoControl
      write SetCurrentBoxInfoControl nodefault;

  private
    FLastDocumentInfoControl: TCustomControl;
    function GetLastDocumentInfoControl: TCustomControl;
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);
  protected
    /// <summary>
    /// Контрол, в который будет выводится информация о последнем документе
    /// </summary>
    property LastDocumentInfoControl: TCustomControl read GetLastDocumentInfoControl
      write SetLastDocumentInfoControl nodefault;

  private
    FCurrentUserId: Integer;
    function GetCurrentUserId: Integer;
  protected
    /// <summary>
    /// Идентификатор текущего пользователя
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
    /// Идентификатор типа архивного короба
    /// </summary>
    property ArchiveBoxTypeId: Integer read GetArchiveBoxTypeId nodefault;

  protected
    function GetArchiveDocumentItemClass: TArchiveDocumentItemClass; virtual; abstract;
    /// <summary>
    /// Тип класса документов, участвующих в данном бизнес-процессе
    /// </summary>
    property ArchiveDocumentItemClass: TArchiveDocumentItemClass read GetArchiveDocumentItemClass nodefault;
  public
    constructor Create(const AConnection: TCustomConnection; const ACurrentUserId: Integer;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce; virtual;
    destructor Destroy; override;
    procedure ManualPrintCurrentBoxSticker;
    procedure ManualDeleteLastDocumentFromCurrentBox;
    function GetCurrentBoxDocumentCount: Integer;
    procedure ProcessString(const AString: string);
  end;

resourcestring
  RsEnterBarcodeOfDocumentOrCommand = 'Введите штрих-код документа или команды';

implementation

uses
  StdCtrls,
  SysUtils,
  Windows,
  Forms,
  uTEnterStringForm,
  uArchivingCommonRoutines,
  uIShowableField,
  uTArchiveBoxItem,
  uTReportDataModule,
  uIArchiveCompanyItem,
  uIArchiveBoxTypeItem,
  uTArchiveCompanyItem,
  uTArchiveBoxTypeItem,
  uICauseOfArchiveDocumentDamageItem,
  uICauseOfArchiveDocumentDamageList,
  uTCauseOfArchiveDocumentDamageList,
  uTArchiveDocumentListClass,
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
    SetSQLForQuery(Query, Format('Archiving_sel_OpenedArchiveBoxCount %d, %d', [ATypeId, ACompanyId]), True);
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
      box_type := TArchiveBoxTypeItem.Create(Connection, AType);
      Result := box_type.Capacity;
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
      Result := Query.FieldByName('Value_Int').AsInteger = 1;
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
      if Assigned(ABox.Documents) then
      begin
        if ABox.Documents.Count > 0 then
        begin
          Result := PrintBoxSticker(ABox);
        end
        else
        begin
          Result := True;
        end;
      end
      else
      begin
        Result := True;
      end;
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
      ABox.Barcode, st20x10, True);
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
      ShowShowableItem(CurrentBoxInfoControl, showable);
    end;

    if Assigned(CurrentBox.Documents) then
    begin
      if CurrentBox.Documents.Count > 0 then
      begin
        if Supports(CurrentBox.Documents[CurrentBox.Documents.Count - 1], IShowable, showable) then
        begin
          ShowShowableItem(LastDocumentInfoControl, showable);
        end;
      end;
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
  codl: ICauseOfArchiveDocumentDamageList;
  i: Integer;
  a: ICauseOfArchiveDocumentDamageItem;
begin
  Result := False;
  s := Trim(ABarcode);
  codl := TCauseOfArchiveDocumentDamageList.Create(Connection);
  if Assigned(codl) then
  begin
    codl.Load;
    for i := 0 to codl.Count - 1 do
    begin
      if Supports(codl.Item[i], ICauseOfArchiveDocumentDamageItem, a) then
      begin
        if a.Barcode = s then
        begin
          Result := True;
          Break;
        end;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.IsForceNewBoxCommandBarcode(const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '001001';
end;

function TDocumentArchivingBusinessLogic.IsPutBoxAsideCommandBarcode(const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '001002';
end;

function TDocumentArchivingBusinessLogic.IsGiveLastDocumentAwayBarcode(const ABarcode: string): Boolean;
begin
  Result := Trim(ABarcode) = '001003';
end;

function TDocumentArchivingBusinessLogic.CreateDocumentItemByBarcode(const ABarcode: string): IArchiveDocumentItem;
begin
  Result := nil;
  if IsBSOBarcode(ABarcode) then
  begin
    if Assigned(ArchiveDocumentItemClass) then
    begin
      Result := ArchiveDocumentItemClass.Create(Connection, -1);
      if Assigned(Result) then
      begin
        if Result.FromString(ABarcode) then
        begin
          Result.ArchivedByUser := CurrentUserId;
          Result.ArchivingDate := Now;
        end
        else
        begin
          Result := nil;
        end;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.GetNewArchiveBoxNumber(const ATypeId, ACompanyId, AYear: Integer): Integer;
begin
  Result := -1;
  SetSQLForQuery(Query, Format('Archiving_GetNewArchiveBoxNumber %d, %d, %d', [ATypeId, ACompanyId, AYear]), True);
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
      SetSQLForQuery(Query, Format('Archiving_sel_OldestOpenedArchiveBox %d, %d, %d',
        [ArchiveBoxTypeId, ADocument.CompanyId, ADocument.Year]), True);
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
          if Result.Barcode = ShowBoxBarcodeDialog(Result.Barcode) then
          begin
            Result.UserId := CurrentUserId;
            Result.Save(Connection);
            Result.Load(Connection);
            ADocument.ArchiveBoxId := Result.Id;
            if Assigned(Result.Documents) then
            begin
              ADocument.SequenceNumber := Result.Documents.Count + 1;
              if Result.Documents.Add(ADocument) > -1 then
              begin
                if not ADocument.Save(Connection) then
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
        if ADocument.Year = CurrentBox.Year then
        begin
          ADocument.ArchiveBoxId := CurrentBox.Id;
          if Assigned(CurrentBox.Documents) then
          begin
            ADocument.SequenceNumber := CurrentBox.Documents.Count + 1;
            if CurrentBox.Documents.Add(ADocument) > -1 then
            begin
              Result := ADocument.Save(Connection);
            end;
          end;
        end
        else
        begin
          DisplayErrorMessage('Год документа не соответствует году короба' + sLineBreak +
            RsEnterBarcodeOfDocumentOrCommand);
        end;
      end
      else
      begin
        DisplayErrorMessage('Компания документа не соответствует компании короба' + sLineBreak +
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
        Result.Year := ADocument.Year;
        Result.Number := GetNewArchiveBoxNumber(Result.TypeId, Result.CompanyId, Result.Year);
        if Result.Number > 0 then
        begin
          Result.Save(Connection);
          Result.Load;
          ADocument.ArchiveBoxId := Result.Id;
          ADocument.SequenceNumber := 1; // номер первого бланка в новом коробе
          if Result.Documents.Add(ADocument) > -1 then
          begin
            if not ADocument.Save(Connection) then
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

function TDocumentArchivingBusinessLogic.GetCurrentBoxDocumentCount: Integer;
begin
  Result := GetDocumentCount(CurrentBox);
end;

procedure TDocumentArchivingBusinessLogic.ManualPrintCurrentBoxSticker;
begin
  if PrintCurrentBoxSticker then
    DisplaySuccessMessage('Стикер на текущий короб распечатан' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand)
  else
    DisplayErrorMessage('Не удалось распечатать стикер на текущий короб' + sLineBreak +
      RsEnterBarcodeOfDocumentOrCommand);
end;

procedure TDocumentArchivingBusinessLogic.ManualDeleteLastDocumentFromCurrentBox;
begin
  if DeleteLastDocumentFromCurrentBox then
    DisplaySuccessMessage('Последний документ из текущего короба удалён' + sLineBreak +
      RsEnterBarcodeOfDocumentOrCommand)
  else
    DisplayErrorMessage('Не удалось удалить последний документ из текущего короба' + sLineBreak +
      RsEnterBarcodeOfDocumentOrCommand);
end;

procedure TDocumentArchivingBusinessLogic.ProcessString(const AString: string);
var
  b: Boolean;
begin
  if AnalizeBarcode(AString) in [dabtUnknown, dabtForceNewBoxCommand, dabtPutBoxAsideCommand, dabtGiveDocumentAway] then
  begin
    Step := 0;
    case AnalizeBarcode(AString) of
      dabtUnknown:
        begin
          DisplayErrorMessage('Введён неизвестный штрих-код' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
          Exit;
        end;
      dabtForceNewBoxCommand:
        begin
          if Assigned(CurrentBox) then
          begin
            if CurrentBoxIsFull then
            begin
              b := True;
            end
            else
            begin
              b := MessageBox(Application.Handle,
                'Текущий короб не полон. Вы действительно хотите закрыть текущий короб?', 'Подтверждение',
                MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2) = IDOK;
            end;
            if b then
            begin
              if CloseCurrentBox then
                DisplaySuccessMessage('Текущий короб был закрыт' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand)
              else
                DisplayErrorMessage('Не удалось закрыть текущий короб' + sLineBreak +
                  RsEnterBarcodeOfDocumentOrCommand);
            end
            else
              DisplayInfoMessage('Закрытие текущего короба было отменено' + sLineBreak +
                RsEnterBarcodeOfDocumentOrCommand);
          end
          else
          begin
            DisplayErrorMessage('Нельзя закрыть текущий короб, т.к. нет текущего короба' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand);
          end;
        end;
      dabtPutBoxAsideCommand:
        begin
          if Assigned(CurrentBox) then
          begin
            if CurrentBoxIsFull then
            begin
              DisplayErrorMessage('Текущий короб нельзя отложить, т.к. он заполнен' + sLineBreak +
                RsEnterBarcodeOfDocumentOrCommand);
            end
            else
            begin
              if PutCurrentBoxAside then
                DisplaySuccessMessage('Текущий короб отложен' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand)
              else
                DisplayErrorMessage('Не удалось отложить текущий короб' + sLineBreak +
                  RsEnterBarcodeOfDocumentOrCommand);
            end;
          end
          else
          begin
            DisplayErrorMessage('Нельзя отложить текущий короб, т.к. нет текущего короба' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand);
          end;
        end;
      dabtGiveDocumentAway:
        begin
          if GiveLastDocumentInCurrentBoxAway then
            DisplaySuccessMessage('Последний документ из текущего короба передан' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand)
          else
            DisplayErrorMessage('Не удалось передать последний документ из текущего короба' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand);
        end;
    end
  end
  else
  begin
    if CanAddDocument then
    begin
      if AnalizeBarcode(AString) = dabtBSO then
      begin
        if AcceptBSOByAcceptanceRegister(AString) then
        begin
          DisplaySuccessMessage('Документ принят по реестру ЛП');
        end
        else
        begin
          DisplayErrorMessage('Документ не принят по реестру ЛП');
        end;
      end;

      if not CurrentBoxIsFull then
      begin
        AddDocument(AString);
      end
      else
      begin
        DisplayErrorMessage('Нельзя добавлять документы в короб, т.к. текущий короб был заполнен' + sLineBreak +
          RsEnterBarcodeOfDocumentOrCommand);
      end;

      if Assigned(CurrentBox) then
      begin
        if Assigned(CurrentBox.Documents) then
        begin
          if (CurrentBox.Documents.Count = 2) and (not CurrentBox.StickerPrinted) then
          begin
            if PrintCurrentBoxSticker then
            begin
              DisplaySuccessMessage('Документ был успешно добавлен в текущий короб' + sLineBreak +
                'Стикер на текущий короб распечатан автоматически' + sLineBreak + RsEnterBarcodeOfDocumentOrCommand);
            end;
          end;
        end;
      end;

      if CurrentBoxIsFull then
      begin
        UpdateCurrentInfo;
        if MessageBox(Application.Handle, 'Текущий короб заполнен. Вы хотите закрыть текущий короб?', 'Подтверждение',
          MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON1) = IDOK then
        begin
          if CloseCurrentBox then
          begin
            DisplaySuccessMessage('Текущий короб заполнен и был закрыт' + sLineBreak +
              RsEnterBarcodeOfDocumentOrCommand);
          end;
        end;
      end;
    end
    else
    begin
      Step := 0;
      DisplayErrorMessage('Документ нельзя добавлять, поскольку идёт настройка вместимости коробов' + sLineBreak +
        'Дождитесь окончания настройки, затем введите штрих-код документа или команды');
    end;
  end;
  UpdateCurrentInfo;
end;

function TDocumentArchivingBusinessLogic.AcceptBSOByAcceptanceRegister(const ABarcode: string): Boolean;
var
  s: string;
begin
  Result := False;
  s := Trim(ABarcode);
  if AnalizeBarcode(s) = dabtBSO then
  begin
    SetSQLForQuery(Query, Format('Archiving_upd_AcceptanceRegister ''%s''', [s]), True);
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

destructor TDocumentArchivingBusinessLogic.Destroy;
begin
  if CurrentBoxIsFull then
  begin
    if CloseCurrentBox then
    begin
      MessageBox(Application.Handle, 'Текущий короб был закрыт, т.к. он заполнен.' + sLineBreak + 'Упакуйте короб.',
        'Предупреждение', MB_OK + MB_ICONWARNING + MB_DEFBUTTON1);
    end;
  end
  else
  begin
    if PutCurrentBoxAside then
    begin
      MessageBox(Application.Handle, 'Текущий короб был отложен, т.к. он не был заполнен.', 'Информация',
        MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON1);
    end;
  end;
  inherited;
end;

function TDocumentArchivingBusinessLogic.ShowBoxBarcodeDialog(const ABoxBarcode: string): string;
var
  form: TEnterStringForm;
begin
  Result := EmptyStr;
  form := TEnterStringForm.Create('Подтверждение', Format('Найдите короб со штрих-кодом %s и введите штрих-код',
    [ABoxBarcode]), 12, True);
  try
    form.ShowModal;
    if form.ModalResult = mrOk then
    begin
      Result := form.Value;
    end;
  finally
    FreeAndNil(form);
  end;
end;

end.
