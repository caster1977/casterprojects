unit uTArchiveBoxTypes;

interface

uses
  uTLoadableList,
  DB,
  uIArchiveBoxType,
  uIArchiveBoxTypes;

type
  TArchiveBoxTypes = class sealed(TLoadableList, IArchiveBoxTypes)
  private
    function GetItem(const AIndex: Integer): IArchiveBoxType;
  public
    function GetItemById(const AId: Integer): IArchiveBoxType;
    property Item[const AIndex: Integer]: IArchiveBoxType read GetItem; default;
  public
    constructor Create; reintroduce; virtual; final;
  end;

implementation

uses
  uCommonRoutines,
  uTArchiveBoxType,
  SysUtils;

function TArchiveBoxTypes.GetItemById(const AId: Integer): IArchiveBoxType;
var
  i: Integer;
begin
  Result := nil;
  if AId > -1 then
  begin
    for i := 0 to Count - 1 do
    begin
      if Assigned(Items[i]) then
      begin
        if (Items[i] as IArchiveBoxType).Id = AId then
        begin
          Result := Items[i] as IArchiveBoxType;
          Break;
        end;
      end;
    end;
  end;
end;

constructor TArchiveBoxTypes.Create;
begin
  inherited;
  ItemClass := TArchiveBoxType;
end;

function TArchiveBoxTypes.GetItem(const AIndex: Integer): IArchiveBoxType;
begin
  Result := nil;
  if AIndex > -1 then
  begin
    if Assigned(Items) then
    begin
      if Count > AIndex then
      begin
        Result := Items[AIndex] as IArchiveBoxType;
      end;
    end;
  end;
end;

end.
