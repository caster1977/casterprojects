unit DBUServerService.uTSQLSubject;

interface

uses
  DBUServerService.uISQLSubject,
  CastersPackage.uICustomized,
  System.Classes;

type
  TSQLSubject = class(TInterfacedObject, ISQLSubject, ICustomized)
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

function GetISQLSubject: ISQLSubject;

implementation

uses
  System.SysUtils,
  System.StrUtils;

function GetISQLSubject: ISQLSubject;
begin
  Result := TSQLSubject.Create;
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
    Format('[ClassName: %s] Name: %s, Abbreviation: %s', [ClassName, Name, Abbreviation]);
end;

end.
