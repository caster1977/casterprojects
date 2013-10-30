unit uTAcceptanceOfBoxesToArchiveBusinessLogic;

interface

uses
  uIArchiveBoxItem,
  uTCustomBusinessLogic,
  DB,
  Controls,
  uTOnDisplayMessage,
  uIAcceptanceOfBoxesToArchiveBusinessLogic,
  uTDocumentArchivingBarcodeType;

type
  TAcceptanceOfBoxesToArchiveBusinessLogic = class {$IFNDEF VER150} abstract {$ENDIF}
    (TCustomBusinessLogic, IAcceptanceOfBoxesToArchiveBusinessLogic)
  private
    /// <summary>
    /// Функция принятия указанного короба
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    function AcceptBox(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// Процедура, выполняющая вывод данных о последнем приянтом коробе
    /// </summary>
    procedure UpdateInfo;

    /// <summary>
    /// Функция анализа введённого штрих-кода
    /// </summary>
    /// <param name="ABarcode">
    /// Штрих-код
    /// </param>
    /// <returns>
    /// Тип штрих-кода
    /// </returns>
    function AnalizeBarcode(const ABarcode: string): TDocumentArchivingBarcodeType;

    /// <summary>
    /// Функция получения объекта короба по указанному штрих-коду
    /// </summary>
    /// <param name="ABarcode">
    /// Штрих-код короба
    /// </param>
    /// <returns>
    /// Объект короба
    /// </returns>
    function GetBoxItemByBarcode(const ABarcode: string): IArchiveBoxItem;

  private
    FLastBox: IArchiveBoxItem;
    function GetLastBox: IArchiveBoxItem;
    procedure SetLastBox(const AValue: IArchiveBoxItem);
  public
    /// <summary>
    /// Последний принятый в архив короб
    /// </summary>
    property LastBox: IArchiveBoxItem read GetLastBox write SetLastBox nodefault;

  private
    FLastBoxInfoControl: TCustomControl;
    function GetLastBoxInfoControl: TCustomControl;
    procedure SetLastBoxInfoControl(const AValue: TCustomControl);
  public
    /// <summary>
    /// Контрол, в который будет выводится информация о последнем приянтом в архив коробе
    /// </summary>
    property LastBoxInfoControl: TCustomControl read GetLastBoxInfoControl
      write SetLastBoxInfoControl nodefault;

  public
    constructor Create(const AConnection: TCustomConnection;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce; virtual;
    procedure ProcessString(const AString: string);
  end;

resourcestring
  RsEnterBoxBarcode = 'Введите штрих-код короба';

implementation

uses
  uIShowable,
  SysUtils,
  uArchivingCommonRoutines,
  uTArchiveBoxItem;

function TAcceptanceOfBoxesToArchiveBusinessLogic.GetLastBox: IArchiveBoxItem;
begin
  Result := FLastBox;
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.GetLastBoxInfoControl: TCustomControl;
begin
  Result := FLastBoxInfoControl;
end;

procedure TAcceptanceOfBoxesToArchiveBusinessLogic.SetLastBox(const AValue: IArchiveBoxItem);
begin
  if FLastBox <> AValue then
  begin
    FLastBox := AValue;
  end;
end;

procedure TAcceptanceOfBoxesToArchiveBusinessLogic.SetLastBoxInfoControl
  (const AValue: TCustomControl);
begin
  if FLastBoxInfoControl <> AValue then
  begin
    FLastBoxInfoControl := AValue;
  end;
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.AnalizeBarcode(const ABarcode: string)
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
    Result := dabtUnknown;
  end;
end;

procedure TAcceptanceOfBoxesToArchiveBusinessLogic.UpdateInfo;
var
  showable: IShowable;
begin
  EmptyControl(LastBoxInfoControl);

  if Assigned(LastBox) then
  begin
    if Supports(LastBox, IShowable, showable) then
    begin
      ShowShowableItem(LastBoxInfoControl, showable);
    end;
  end;
end;

constructor TAcceptanceOfBoxesToArchiveBusinessLogic.Create(const AConnection: TCustomConnection;
  const AOnDisplayMessage: TOnDisplayMessage);
begin
  inherited Create(AConnection, AOnDisplayMessage);
  DisplayInfoMessage(RsEnterBoxBarcode);
end;

procedure TAcceptanceOfBoxesToArchiveBusinessLogic.ProcessString(const AString: string);
var
  box: IArchiveBoxItem;
begin
  if AnalizeBarcode(AString) = dabtArchiveBox then
  begin
    box := GetBoxItemByBarcode(AString);
    if Assigned(box) then
    begin
      if box.Closed then
      begin
        if not box.Archived then
        begin
          if AcceptBox(box) then
          begin
            LastBox := box;
            DisplaySuccessMessage('Короб принят в архив' + sLineBreak + RsEnterBoxBarcode);
          end
          else
          begin
            DisplayErrorMessage('Не удалось принять короб в архив' + sLineBreak +
              RsEnterBoxBarcode);
          end;
        end
        else
        begin
          DisplayErrorMessage('Данный короб уже был принят в архив ранее' + sLineBreak +
            RsEnterBoxBarcode);
        end;
      end
      else
      begin
        DisplayErrorMessage('Короб с указанным штрих-кодом не подготовлен для сдачи в архив' +
          sLineBreak + RsEnterBoxBarcode);
      end;
    end
    else
    begin
      DisplayErrorMessage('Не удалось найти данные по коробу с указанным штрих-кодом' + sLineBreak +
        RsEnterBoxBarcode);
    end;
  end
  else
  begin
    DisplayErrorMessage('Введён неизвестный штрих-код' + sLineBreak + RsEnterBoxBarcode);
    Exit;
  end;
  UpdateInfo;
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.GetBoxItemByBarcode(const ABarcode: string)
  : IArchiveBoxItem;
begin
  Result := nil;
  if IsArchiveBoxBarcode(ABarcode) then
  begin
    Result := TArchiveBoxItem.Create(Connection, -1);
    if Assigned(Result) then
    begin
      if not Result.FromString(ABarcode) then
      begin
        Result := nil;
      end;
    end;
  end;
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.AcceptBox(const ABox: IArchiveBoxItem): Boolean;
begin
  Result := False;
  if Assigned(ABox) then
  begin
    if not(ABox.Archived) then
    begin
      ABox.Archived := True;
      ABox.ArchivingDate := Now;
      Result := ABox.Save(Connection);
    end;
  end;
end;

end.
