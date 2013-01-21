unit DBAutoTest.uTTask;

interface

uses
  DBAutoTest.uITask,
  DBAutoTest.uConsts,
  CastersPackage.uICustomized,
  System.Classes;

type
  TTask = class(TInterfacedObject, ITask, ICustomized)
  strict private
    FGroup: string;
    FName: string;
    FSQL: TStringList;
    FEnabled: Boolean;
    function GetEnabled: Boolean;
    function GetGroup: string;
    function GetName: string;
    function GetSQL: TStringList;
    procedure SetEnabled(const AValue: Boolean);
    procedure SetGroup(const AValue: string);
    procedure SetName(const AValue: string);
    procedure SetSQL(const AValue: TStringList);
  protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual; final;
    destructor Destroy; override;
    property Group: string read GetGroup write SetGroup nodefault;
    property name: string read GetName write SetName nodefault;
    property SQL: TStringList read GetSQL write SetSQL default DEFAULT_TASK_SQL;
    property Enabled: Boolean read GetEnabled write SetEnabled default DEFAULT_TASK_ENABLED;
  end;

function GetITask: ITask;

implementation

uses
  System.SysUtils;

function GetITask: ITask;
begin
  Result := TTask.Create;
end;

constructor TTask.Create;
begin
  inherited;
  Initialize;
end;

destructor TTask.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TTask.Finalize;
begin
  FreeAndNil(FSQL);
end;

function TTask.GetEnabled: Boolean;
begin
  Result := FEnabled;
end;

function TTask.GetGroup: string;
begin
  Result := FGroup;
end;

function TTask.GetName: string;
begin
  Result := FName;
end;

function TTask.GetSQL: TStringList;
begin
  if not Assigned(FSQL) then
  begin
    FSQL := TStringList.Create;
  end;
  Result := FSQL;
end;

procedure TTask.Initialize;
begin
  Enabled := DEFAULT_TASK_ENABLED;
  Group := DEFAULT_TASK_GROUP;
  name := DEFAULT_TASK_NAME;
  SQL := DEFAULT_TASK_SQL;
end;

procedure TTask.SetEnabled(const AValue: Boolean);
begin
  if FEnabled <> AValue then
  begin
    FEnabled := AValue;
  end;
end;

procedure TTask.SetGroup(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FGroup <> s then
  begin
    FGroup := s;
  end;
end;

procedure TTask.SetName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FName <> s then
  begin
    FName := s;
  end;
end;

procedure TTask.SetSQL(const AValue: TStringList);
begin
  if FSQL <> AValue then
  begin
    if Assigned(AValue) then
    begin
      FSQL.Clear;
      FSQL.AddStrings(AValue);
    end
    else
    begin
      FreeAndNil(FSQL);
    end;
  end;
end;

end.
