unit DBUShared.uTSQLSubject;

interface

uses
  DBUShared.uISQLSubject,
  CastersPackage.uICustomized,
  System.Classes,
  CastersPackage.uIListItemAdapter,
  Vcl.ComCtrls;

type
  TSQLSubject = class(TInterfacedObject, ISQLSubject, ICustomized, IListItemAdapter)
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

function GetISQLSubject: ISQLSubject; overload;
function GetISQLSubject(const AName, AAbbreviation: string): ISQLSubject; overload;

implementation

uses
  System.SysUtils,
  System.StrUtils;

function GetISQLSubject: ISQLSubject;
begin
  Result := TSQLSubject.Create;
end;

function GetISQLSubject(const AName, AAbbreviation: string): ISQLSubject;
begin
  Result := GetISQLSubject;

  if not Assigned(Result) then
  begin
    Exit;
  end;

  Result.Name := Trim(AName);
  Result.Abbreviation := Trim(AAbbreviation);
end;


procedure TSQLSubject.AppendToListView(const AListView: TListView);
var
  a: ISQLSubject;
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

    if Supports(Self, ISQLSubject, a) then
    begin
      li.Data := Pointer(a);
    end;
  end;
end;

constructor TSQLSubject.Create;
begin
  inherited;
  Initialize;
end;

destructor TSQLSubject.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TSQLSubject.Initialize;
begin
  Name := EmptyStr;
  Abbreviation := EmptyStr;
end;

procedure TSQLSubject.Finalize;
begin
end;

function TSQLSubject.GetAbbreviation: string;
begin
  Result := FAbbreviation;
end;

function TSQLSubject.GetName: string;
begin
  Result := FName;
end;

procedure TSQLSubject.SetAbbreviation(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FAbbreviation <> s then
  begin
    FAbbreviation := s;
  end;
end;

procedure TSQLSubject.SetName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FName <> s then
  begin
    FName := s;
  end;
end;

function TSQLSubject.ToString: string;
begin
  Result := IfThen(inherited > EmptyStr, inherited + sLineBreak) +
    Format('=> Name: %s, Abbreviation: %s', [Name, Abbreviation]);
end;

end.
