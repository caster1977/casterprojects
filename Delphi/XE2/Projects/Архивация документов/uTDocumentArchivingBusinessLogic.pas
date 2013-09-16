unit uTDocumentArchivingBusinessLogic;

interface

uses
  uTCustomBusinessLogic,
  uIDocumentArchivingBusinessLogic,
  uIArchiveBoxItem,
  uIArchiveDocumentItem,
  Controls,
  uIShowable;

type
  TDocumentArchivingBusinessLogic = class sealed(TCustomBusinessLogic,
    IDocumentArchivingBusinessLogic)
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
    function GetOpenedBoxQuantity(const AType, ACompanyId: Integer): Integer; overload;

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

  public
    procedure ShowCurrentBoxInfo;
    procedure ShowLastDocumentInfo;
    function PrintCurrentBoxSticker: Boolean;
    function PutCurrentBoxAside: Boolean;
    function CloseCurrentBox: Boolean;
    function DeleteCurrentBox: Boolean;
    function CurrentBoxIsFull: Boolean;
  private
    function CloseBox(const ABox: IArchiveBoxItem): Boolean;
    function PutBoxAside(const ABox: IArchiveBoxItem): Boolean;
    function PrintBoxSticker(const ABox: IArchiveBoxItem): Boolean;
    function BoxIsFull(const ABox: IArchiveBoxItem): Boolean;
    function GetDocumentsCount(const ABox: IArchiveBoxItem): Integer;
  end;

implementation

uses
  uIArchiveBoxTypeItem,
  uTArchiveBoxTypeItem,
  SysUtils,
  StdCtrls,
  uCommonRoutines,
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

function TDocumentArchivingBusinessLogic.GetDocumentsCount(
  const ABox: IArchiveBoxItem): Integer;
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
begin
  if (not Assigned(AParentControl)) or (not Assigned(AShowableItem)) then
  begin
    Exit;
  end;

  ClearControl(AParentControl);

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
          l2.Margins.Bottom + AShowableItem.ShowableFields.Count * (17 + l2.Margins.Top);;
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

function TDocumentArchivingBusinessLogic.GetOpenedBoxQuantity(const ADocument
  : IArchiveDocumentItem): Integer;
begin

end;

function TDocumentArchivingBusinessLogic.GetOpenedBoxQuantity(const AType,
  ACompanyId: Integer): Integer;
begin

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
      SetSQLForQuery(Query, Format('BSOArchiving_del_ArchiveBox %d', [CurrentBox.Id]), True);
      try
        if not Query.Eof then
        begin
          Result := Query.Fields[0].AsInteger > -1;
        end;
      finally
        Query.Close;
      end;
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

function TDocumentArchivingBusinessLogic.BoxIsFull(
  const ABox: IArchiveBoxItem): Boolean;
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
  if Result then
  begin
    DisplaySuccessMessage('Текущий короб заполнен');
  end
  else
  begin
    DisplayErrorMessage('Текущий короб не заполнен');
  end;
end;

end.
