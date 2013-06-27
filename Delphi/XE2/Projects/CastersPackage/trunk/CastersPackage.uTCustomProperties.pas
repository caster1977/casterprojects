unit CastersPackage.uTCustomProperties;

interface

uses
  System.Classes,
  CastersPackage.uIModified,
  CastersPackage.uICustomized;

type
  TCustomProperties = class(TInterfacedObject, IModified, ICustomized)
  strict private
    FModified: Boolean;
  strict protected
    function GetModified: Boolean; virtual;
  strict private
    procedure SetModified(const AValue: Boolean);
  strict protected
    property Modified: Boolean read GetModified write SetModified nodefault;
  strict protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
  public
    constructor Create; reintroduce; virtual; final;
    destructor Destroy; override; final;
  end;

implementation

constructor TCustomProperties.Create;
begin
  inherited;
  Initialize;
end;

destructor TCustomProperties.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TCustomProperties.Finalize;
begin
end;

function TCustomProperties.GetModified: Boolean;
begin
  Result := FModified;
end;

procedure TCustomProperties.Initialize;
begin
  Modified := False;
end;

procedure TCustomProperties.SetModified(const AValue: Boolean);
begin
  if FModified <> AValue then
  begin
    FModified := AValue;
  end;
end;

end.
