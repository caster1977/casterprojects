unit DBAutoTest.uTRecent;

interface

uses
  DBAutoTest.uIRecent,
  DBAutoTest.uConsts,
  CastersPackage.uICustomized,
  System.Classes;

type
  TRecent = class(TInterfacedObject, IRecent, ICustomized)
  strict private
    FFullName: string;
    function GetExists: Boolean;
    function GetFullName: string;
    function GetShortName: string;
    procedure SetFullName(const AValue: string);
  protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual; final;
    destructor Destroy; override; final;
    property FullName: string read GetFullName write SetFullName nodefault;
    property ShortName: string read GetShortName nodefault;
    property Exists: Boolean read GetExists nodefault;
  end;

function GetIRecent: IRecent;

implementation

uses
  System.SysUtils;

function GetIRecent: IRecent;
begin
  Result := TRecent.Create;
end;

constructor TRecent.Create;
begin
  inherited;
  Initialize;
end;

destructor TRecent.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TRecent.Finalize;
begin
end;

function TRecent.GetExists: Boolean;
begin
  Result := FileExists(FullName);
end;

function TRecent.GetFullName: string;
begin
  Result := FFullName;
end;

function TRecent.GetShortName: string;
begin
  Result := ExtractFileName(FullName);
end;

procedure TRecent.Initialize;
begin
  FullName := DEFAULT_FULL_NAME;
end;

procedure TRecent.SetFullName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FFullName <> s then
  begin
    FFullName := s;
  end;
end;

end.
