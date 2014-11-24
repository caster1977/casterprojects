unit DBUServerService.uTSQLAction;

interface

uses
  DBUServerService.uISQLAction,
  CastersPackage.uICustomized,
  System.Classes;

type
  TSQLAction = class(TInterfacedObject, ISQLAction, ICustomized)
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
  end;

function GetISQLAction: ISQLAction;

implementation

uses
  System.SysUtils,
  System.StrUtils;

function GetISQLAction: ISQLAction;
begin
  Result := TSQLAction.Create;
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
    Format('[ClassName: %s] Name: %s, Abbreviation: %s', [ClassName, Name, Abbreviation]);
end;

end.
