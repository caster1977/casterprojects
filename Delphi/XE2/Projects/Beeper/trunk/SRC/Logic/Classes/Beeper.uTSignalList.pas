unit Beeper.uTSignalList;

interface

uses
  System.Classes,
  System.SysUtils,
  Beeper.uISignalList,
  Beeper.uISignal;

type
  ESignalList = class(Exception);

  TSignalList = class(TInterfacedObject, ISignalList)
  strict private
    FList: IInterfaceList;
    function GetItem(const AIndex: Integer): ISignal;
    procedure PutItem(const AIndex: Integer; const AItem: ISignal);
    function GetCount: Integer;
    procedure SetCount(const ANewCount: Integer);
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Initialize; virtual;
    function IndexOf(const AItem: ISignal): Integer;

    function Add(const AItem: ISignal): Integer;
    procedure Append(const AItems: ISignalList);
    procedure Insert(const AIndex: Integer; const AItem: ISignal);

    procedure Delete(const AIndex: Integer);
    procedure Exchange(const AIndex1, AIndex2: Integer);
    function Remove(const AItem: ISignal; const ASkipIfNotFound: Boolean = False): Integer; overload;
    procedure Remove(const AItems: ISignalList; const ASkipIfNotFound: Boolean = False); overload;
    procedure Clear;

    function First: ISignal;
    function Last: ISignal;

    property Count: Integer read GetCount write SetCount nodefault;
    property Items[const AIndex: Integer]: ISignal read GetItem write PutItem; default;
  end;

function GetISignalList: ISignalList;

implementation

resourcestring
  RsCantAddSignalToSignalList = 'Ќе удалось добавить сигнал в список сигналов!';
  RsCantRemoveSignalFromSignalList = 'Ќе удалось удалить сигнал из списка сигналов!';

function GetISignalList: ISignalList;
begin
  Result := TSignalList.Create;
end;

constructor TSignalList.Create;
begin
  inherited;
  Initialize;
end;

procedure TSignalList.Initialize;
begin
  FList := TInterfaceList.Create;
end;

destructor TSignalList.Destroy;
begin
  Clear;
  inherited;
end;

function TSignalList.Add(const AItem: ISignal): Integer;
begin
  Result := -1;
  if Assigned(FList) then
  begin
    Result := FList.Add(AItem);
  end;
end;

procedure TSignalList.Append(const AItems: ISignalList);
var
  i: Integer;
begin
  for i := 0 to AItems.Count - 1 do
  begin
    if Add(AItems[i]) = -1 then
    begin
      raise ESignalList.Create(RsCantAddSignalToSignalList);
    end;
  end;
end;

procedure TSignalList.Clear;
begin
  if Assigned(FList) then
  begin
    FList.Clear;
  end;
end;

procedure TSignalList.Delete(const AIndex: Integer);
begin
  if Assigned(FList) then
  begin
    FList.Delete(AIndex);
  end;
end;

procedure TSignalList.Exchange(const AIndex1, AIndex2: Integer);
begin
  if Assigned(FList) then
  begin
    FList.Exchange(AIndex1, AIndex2);
  end;
end;

function TSignalList.First: ISignal;
begin
  Result := GetItem(0);
end;

function TSignalList.GetCount: Integer;
begin
  Result := -1;
  if Assigned(FList) then
  begin
    Result := FList.Count;
  end;
end;

procedure TSignalList.SetCount(const ANewCount: Integer);
begin
  if Assigned(FList) then
  begin
    FList.Count := ANewCount;
  end;
end;

function TSignalList.IndexOf(const AItem: ISignal): Integer;
begin
  Result := -1;
  if Assigned(FList) then
  begin
    Result := FList.IndexOf(AItem);
  end;
end;

procedure TSignalList.Insert(const AIndex: Integer; const AItem: ISignal);
begin
  if Assigned(FList) then
  begin
    FList.Insert(AIndex, AItem);
  end;
end;

function TSignalList.Last: ISignal;
begin
  Result := Self.GetItem(Count - 1);
end;

procedure TSignalList.Remove(const AItems: ISignalList; const ASkipIfNotFound: Boolean);
var
  i: Integer;
begin
  for i := 0 to AItems.Count - 1 do
  begin
    if Remove(AItems[i], ASkipIfNotFound) = -1 then
    begin
      raise ESignalList.Create(RsCantRemoveSignalFromSignalList);
    end;
  end;
end;

function TSignalList.Remove(const AItem: ISignal; const ASkipIfNotFound: Boolean): Integer;
begin
  Result := -1;
  if Assigned(FList) and (not((IndexOf(AItem) = Result) and ASkipIfNotFound)) then
  begin
    Result := FList.Remove(AItem);
  end;
end;

function TSignalList.GetItem(const AIndex: Integer): ISignal;
begin
  Result := nil;
  if Assigned(FList) then
  begin
    Result := FList[AIndex] as ISignal;
  end;
end;

procedure TSignalList.PutItem(const AIndex: Integer; const AItem: ISignal);
begin
  if (AIndex >= 0) or (AIndex < Count) then
  begin
    if Assigned(FList) then
    begin
      FList[AIndex] := AItem;
    end;
  end;
end;

end.
