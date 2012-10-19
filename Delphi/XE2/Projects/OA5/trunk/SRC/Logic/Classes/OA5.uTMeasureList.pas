unit OA5.uTMeasureList;

interface

uses
  CastersPackage.uTInterfaceListOfGivenType,
  System.Classes,
  OA5.uIMeasure,
  OA5.uIMeasureList,
  CastersPackage.uINormalized,
  CastersPackage.uICustomized;

const
  DEFAULT_MEASURE_LIST_AUTO_NORMALIZE_DATA = False;

type
  /// <summary>
  /// Класс списка интерфейсов типа <b>IMeasure</b>.
  /// </summary>
  /// <remarks>
  /// См. также описание интерфейса <b>IMeasure</b> и класса <b>TMeasure</b>.
  /// </remarks>
  TMeasureList = class(TInterfaceListOfGivenType<IMeasure>, IMeasureList, INormalized, ICustomized)
  strict private
    FAutoNormalizeData: Boolean;
    function GetAutoNormalizeData: Boolean;
    procedure SetAutoNormalizeData(const AValue: Boolean);
  protected
    procedure Initialize; override;
  public
    function Equals(Obj: TObject): Boolean; override;
    procedure Assign(Source: TPersistent); override;
    function IsNormalized: Boolean;
    procedure Normalize;
    property AutoNormalizeData: Boolean read GetAutoNormalizeData write SetAutoNormalizeData default DEFAULT_MEASURE_LIST_AUTO_NORMALIZE_DATA;
  end;

implementation

resourcestring
  RsCantAddMeasureToMeasureList = 'Не удалось добавить мероприятие в список мероприятий.';
  RsCantRemoveMeasureFromMeasureList = 'Не удалось удалить мероприятие из списка мероприятий!';

procedure TMeasureList.Initialize;
begin
  inherited;
  AddItemErrorString := RsCantAddMeasureToMeasureList;
  RemoveItemErrorString := RsCantRemoveMeasureFromMeasureList;
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
  for i := 0 to Count - 1 do
  begin
    if Assigned(Items[i]) then
    begin
      if not(Items[i] as INormalized).IsNormalized then
      begin
        Exit;
      end;
    end;
  end;
  Result := True;
end;

procedure TMeasureList.Normalize;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
  begin
    if Assigned(Items[i]) then
    begin
      (Items[i] as INormalized).Normalize;
    end;
  end;
end;

procedure TMeasureList.Assign(Source: TPersistent);
var
  o: TMeasureList;
  i: Integer;
begin
  if Source is TMeasureList then
  begin
    o := Source as TMeasureList;
    AutoNormalizeData := o.AutoNormalizeData;
    Count := o.Count;
    for i := 0 to o.Count - 1 do
    begin
      Items[i] := o.Items[i];
    end;
  end
  else
  begin
    inherited;
  end;
end;

function TMeasureList.Equals(Obj: TObject): Boolean;
var
  o: TMeasureList;
  i: Integer;
begin
  Result := False;
  if Obj is TMeasureList then
  begin
    o := Obj as TMeasureList;
    Result := (AutoNormalizeData = o.AutoNormalizeData) and (Count = o.Count);
    if Result then
      for i := 0 to o.Count - 1 do
      begin
        Result := Result and (Items[i] = o.Items[i]);
      end;
  end
  else
  begin
    inherited;
  end;
end;

initialization

begin
  RegisterClass(TMeasureList);
end;

end.
