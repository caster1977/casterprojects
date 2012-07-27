unit Beeper.uTSignalList;

interface

uses
  System.IniFiles,
  Beeper.uISignalList,
  Beeper.uISignal,
  System.Classes;

type
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

    property Count: Integer read GetCount write SetCount;
    property Items[const AIndex: Integer]: ISignal read GetItem write PutItem; default;
  end;

implementation

uses
  Beeper.uResourceStrings,
  Beeper.uConsts;

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
  Result := FList.Add(AItem);
end;

procedure TSignalList.Append(const AItems: ISignalList);
var
  i: Integer;
begin
  for i := 0 to AItems.Count - 1 do
    Add(AItems[i]);
end;

procedure TSignalList.Clear;
begin
  FList.Clear;
end;

procedure TSignalList.Delete(const AIndex: Integer);
begin
  FList.Delete(AIndex);
end;

procedure TSignalList.Exchange(const AIndex1, AIndex2: Integer);
begin
  FList.Exchange(AIndex1, AIndex2);
end;

function TSignalList.First: ISignal;
begin
  Result := GetItem(0);
end;

function TSignalList.GetCount: Integer;
begin
  Result := FList.Count;
end;

procedure TSignalList.SetCount(const ANewCount: Integer);
begin
  FList.Count := ANewCount;
end;

function TSignalList.IndexOf(const AItem: ISignal): Integer;
begin
  Result := FList.IndexOf(AItem);
end;

procedure TSignalList.Insert(const AIndex: Integer; const AItem: ISignal);
begin
  FList.Insert(AIndex, AItem);
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
    Remove(AItems[i], ASkipIfNotFound);
end;

function TSignalList.Remove(const AItem: ISignal; const ASkipIfNotFound: Boolean): Integer;
var
  i: Integer;
begin
  Result := -1;
  i := IndexOf(AItem);
  if (i = -1) and ASkipIfNotFound then
    Exit;
  Result := FList.Remove(AItem);
end;

function TSignalList.GetItem(const AIndex: Integer): ISignal;
begin
  Result := FList[AIndex] as ISignal;
end;

procedure TSignalList.PutItem(const AIndex: Integer; const AItem: ISignal);
begin
  if (AIndex >= 0) or (AIndex < Count) then
    FList[AIndex] := AItem;
end;

end.
