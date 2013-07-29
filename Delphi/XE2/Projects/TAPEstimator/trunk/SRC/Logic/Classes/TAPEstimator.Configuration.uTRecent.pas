unit TAPEstimator.Configuration.uTRecent;

interface

uses
  System.Classes,
  CastersPackage.uIInitializable,
  TAPEstimator.uConsts,
  TAPEstimator.Configuration.uIRecent;

type
  TRecent = class(TInterfacedObject, IRecent, IInitializable)
  strict private
    FFullName: string;
    function GetFullName: string;
    procedure SetFullName(const AValue: string);
  public
    property FullName: string read GetFullName write SetFullName nodefault;
  strict private
    function GetShortName: string;
  public
    property ShortName: string read GetShortName nodefault;
  strict private
    function GetExists: Boolean;
  public
    property Exists: Boolean read GetExists nodefault;
  strict protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; virtual; final;
    destructor Destroy; override; final;
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

procedure TRecent.Initialize;
begin
  FullName := RECENT_DEFAULT_FULL_NAME;
end;

procedure TRecent.Finalize;
begin
end;

function TRecent.GetFullName: string;
begin
  Result := FFullName;
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

function TRecent.GetExists: Boolean;
begin
  Result := FileExists(FullName);
end;

function TRecent.GetShortName: string;
begin
  Result := ExtractFileName(FullName);
end;

end.
