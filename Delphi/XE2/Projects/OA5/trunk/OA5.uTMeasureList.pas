unit OA5.uTMeasureList;

interface

uses
  System.Classes,
  System.SysUtils,
  OA5.uIMeasureList,
  OA5.uIMeasure,
  OA5.uINormalized;

const
  DEFAULT_MEASURE_LIST_AUTO_NORMALIZE_DATA = False;

type
  /// <summary>
  /// Класс исключения для объектов типа <b>TMeasureList</b>.
  /// </summary>
  /// <remarks>
  /// См. также описание класса <b>TMeasureList</b>.
  /// </remarks>
  EMeasureList = class(Exception);

  /// <summary>
  /// Класс списка интерфейсов типа <b>IMeasure</b>.
  /// </summary>
  /// <remarks>
  /// См. также описание интерфейса <b>IMeasure</b> и класса <b>TMeasure</b>.
  /// </remarks>
  TMeasureList = class(TInterfacedObject, IMeasureList, INormalized)
  strict private
    FAutoNormalizeData: Boolean;
    FList: IInterfaceList;
    function GetItem(const AIndex: Integer): IMeasure;
    procedure PutItem(const AIndex: Integer; const AItem: IMeasure);
    function GetCount: Integer;
    procedure SetCount(const ANewCount: Integer);
    function GetAutoNormalizeData: Boolean;
    procedure SetAutoNormalizeData(const AValue: Boolean);
  public
    constructor Create; reintroduce; virtual;
    destructor Destroy; override;
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    function IndexOf(const AItem: IMeasure): Integer;

    function Add(const AItem: IMeasure): Integer;
    procedure Append(const AItems: IMeasureList);
    procedure Insert(const AIndex: Integer; const AItem: IMeasure);

    procedure Delete(const AIndex: Integer);
    procedure Exchange(const AIndex1, AIndex2: Integer);
    function Remove(const AItem: IMeasure; const ASkipIfNotFound: Boolean = False): Integer; overload;
    procedure Remove(const AItems: IMeasureList; const ASkipIfNotFound: Boolean = False); overload;
    procedure Clear;

    function First: IMeasure;
    function Last: IMeasure;

    function IsNormalized: Boolean;
    procedure Normalize;

    property Count: Integer read GetCount write SetCount nodefault;
    property Items[const AIndex: Integer]: IMeasure read GetItem write PutItem; default;
    property AutoNormalizeData: Boolean read GetAutoNormalizeData write SetAutoNormalizeData
      default DEFAULT_MEASURE_LIST_AUTO_NORMALIZE_DATA;
  end;

function GetIMeasureList: IMeasureList;
function GetINormalized(const AMeasureList: IMeasureList): INormalized; overload;

implementation

resourcestring
  RsCantAddMeasureToMeasureList = 'Не удалось добавить мероприятие в список мероприятий.';
  RsCantRemoveMeasureFromMeasureList = 'Не удалось удалить мероприятие из списка мероприятий!';

function GetIMeasureList: IMeasureList;
begin
  Result := TMeasureList.Create;
end;

function GetINormalized(const AMeasureList: IMeasureList): INormalized; overload;
begin
  Result := nil;
  if Assigned(AMeasureList) then
  begin
    if Supports(AMeasureList, INormalized) then
    begin
      Result := AMeasureList as INormalized;
    end;
  end;
end;

function TMeasureList.Add(const AItem: IMeasure): Integer;
begin
  Result := -1;
  if Assigned(FList) then
  begin
    Result := FList.Add(AItem);
  end;
end;

procedure TMeasureList.Append(const AItems: IMeasureList);
var
  i: Integer;
begin
  for i := 0 to AItems.Count - 1 do
  begin
    if Add(AItems[i]) = -1 then
    begin
      raise EMeasureList.Create(RsCantAddMeasureToMeasureList);
    end;
  end;
end;

procedure TMeasureList.Clear;
begin
  if Assigned(FList) then
  begin
    FList.Clear;
  end;
end;

constructor TMeasureList.Create;
begin
  inherited;
  FList := TInterfaceList.Create;
  Initialize;
end;

procedure TMeasureList.Initialize;
begin
end;

destructor TMeasureList.Destroy;
begin
  Finalize;
  Clear;
  inherited;
end;

procedure TMeasureList.Finalize;
begin
end;

procedure TMeasureList.Delete(const AIndex: Integer);
begin
  if Assigned(FList) then
  begin
    FList.Delete(AIndex);
  end;
end;

procedure TMeasureList.Exchange(const AIndex1, AIndex2: Integer);
begin
  if Assigned(FList) then
  begin
    FList.Exchange(AIndex1, AIndex2);
  end;
end;

function TMeasureList.First: IMeasure;
begin
  Result := GetItem(0);
end;

function TMeasureList.GetCount: Integer;
begin
  Result := -1;
  if Assigned(FList) then
  begin
    Result := FList.Count;
  end;
end;

function TMeasureList.GetItem(const AIndex: Integer): IMeasure;
begin
  Result := nil;
  if Assigned(FList) then
  begin
    Result := FList[AIndex] as IMeasure;
  end;
end;

function TMeasureList.IndexOf(const AItem: IMeasure): Integer;
begin
  Result := -1;
  if Assigned(FList) then
  begin
    Result := FList.IndexOf(AItem);
  end;
end;

procedure TMeasureList.Insert(const AIndex: Integer; const AItem: IMeasure);
begin
  if Assigned(FList) then
  begin
    FList.Insert(AIndex, AItem);
  end;
end;

function TMeasureList.Last: IMeasure;
begin
  Result := Self.GetItem(Count - 1);
end;

procedure TMeasureList.PutItem(const AIndex: Integer; const AItem: IMeasure);
begin
  if (AIndex >= 0) or (AIndex < Count) then
  begin
    if Assigned(FList) then
    begin
      FList[AIndex] := AItem;
    end;
  end;
end;

procedure TMeasureList.Remove(const AItems: IMeasureList; const ASkipIfNotFound: Boolean);
var
  i: Integer;
begin
  for i := 0 to AItems.Count - 1 do
  begin
    if Remove(AItems[i], ASkipIfNotFound) = -1 then
    begin
      raise EMeasureList.Create(RsCantRemoveMeasureFromMeasureList);
    end;
  end;
end;

function TMeasureList.Remove(const AItem: IMeasure; const ASkipIfNotFound: Boolean): Integer;
begin
  Result := -1;
  if Assigned(FList) and (not((IndexOf(AItem) = Result) and ASkipIfNotFound)) then
  begin
    Result := FList.Remove(AItem);
  end;
end;

procedure TMeasureList.SetCount(const ANewCount: Integer);
begin
  if Assigned(FList) then
  begin
    FList.Count := ANewCount;
  end;
end;

function TMeasureList.GetAutoNormalizeData: Boolean;
begin
  Result := FAutoNormalizeData;
end;

procedure TMeasureList.SetAutoNormalizeData(const AValue: Boolean);
begin
  if FAutoNormalizeData <> AValue then
  begin
    FAutoNormalizeData := AValue;
  end;
end;

function TMeasureList.IsNormalized: Boolean;
var
  i: Integer;
begin
  Result := True;
  if Assigned(FList) then
  begin
    for i := 0 to Count - 1 do
    begin
      if not(FList.Items[i] as INormalized).IsNormalized then
      begin
        Exit;
      end;
    end;
    Result := True;
  end;
end;

procedure TMeasureList.Normalize;
var
  i: Integer;
begin
  if Assigned(FList) then
  begin
    for i := 0 to Count - 1 do
    begin
      (FList.Items[i] as INormalized).Normalize;
    end;
  end;
end;

end.
