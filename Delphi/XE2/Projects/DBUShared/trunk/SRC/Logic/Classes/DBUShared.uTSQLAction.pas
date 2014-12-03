unit DBUShared.uTSQLAction;

interface

uses
  DBUShared.uISQLAction,
  CastersPackage.uICustomized,
  System.Classes,
  CastersPackage.uIListItemAdapter,
  Vcl.ComCtrls;

type
  TSQLAction = class(TInterfacedObject, ISQLAction, ICustomized, IListItemAdapter)
  strict protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual; final;
    destructor Destroy; override; final;

  strict private
    FName: string;
    function GetName: string;
    procedure SetName(const AValue: string);
  public
    property Name: string read GetName write SetName nodefault;

  strict private
    FAbbreviation: string;
    function GetAbbreviation: string;
    procedure SetAbbreviation(const AValue: string);
  public
    property Abbreviation: string read GetAbbreviation write SetAbbreviation nodefault;

  public
    function ToString: string; override;
    procedure AppendToListView(const AListView: TListView); virtual;
  end;

function GetISQLAction: ISQLAction; overload;
function GetISQLAction(const AName, AAbbreviation: string): ISQLAction; overload;

implementation

uses
  System.SysUtils,
  System.StrUtils;

function GetISQLAction: ISQLAction;
begin
  Result := TSQLAction.Create;
end;

function GetISQLAction(const AName, AAbbreviation: string): ISQLAction;
begin
  Result := GetISQLAction;

  if not Assigned(Result) then
  begin
    Exit;
  end;

  Result.Name := Trim(AName);
  Result.Abbreviation := Trim(AAbbreviation);
end;

procedure TSQLAction.AppendToListView(const AListView: TListView);
var
  a: ISQLAction;
  li: TListItem;
begin
  if not Assigned(AListView) then
  begin
    Exit;
  end;

  if not Assigned(AListView.Items) then
  begin
    Exit;
  end;

  li := AListView.Items.Add;

  if not Assigned(li) then
  begin
    Exit;
  end;

  li.Caption := Name;

  if Assigned(li.SubItems) then
  begin
    li.SubItems.Add(Abbreviation);

    if Supports(Self, ISQLAction, a) then
    begin
      li.Data := Pointer(a);
    end;
  end;
end;

constructor TSQLAction.Create;
begin
  inherited;
  Initialize;
end;

destructor TSQLAction.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TSQLAction.Initialize;
begin
  Name := EmptyStr;
  Abbreviation := EmptyStr;
end;

procedure TSQLAction.Finalize;
begin
end;

function TSQLAction.GetAbbreviation: string;
begin
  Result := FAbbreviation;
end;

function TSQLAction.GetName: string;
begin
  Result := FName;
end;

procedure TSQLAction.SetAbbreviation(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FAbbreviation <> s then
  begin
    FAbbreviation := s;
  end;
end;

procedure TSQLAction.SetName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FName <> s then
  begin
    FName := s;
  end;
end;

function TSQLAction.ToString: string;
begin
  Result := IfThen(inherited > EmptyStr, inherited + sLineBreak) +
    Format('=> Name: %s, Abbreviation: %s', [Name, Abbreviation]);
end;

end.
