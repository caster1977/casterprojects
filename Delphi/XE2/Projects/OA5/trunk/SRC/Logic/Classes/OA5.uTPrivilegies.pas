unit OA5.uTPrivilegies;

interface

uses
  System.Classes,
  OA5.uIPrivilegies,
  OA5.uDefaultConsts;

type
  TPrivilegies = class(TInterfacedPersistent, IPrivilegies)
  strict private
    FEditing: Boolean;
    FClearing: Boolean;
    FAccounting: Boolean;
    FReporting: Boolean;
    function GetAccounting: Boolean;
    function GetClearing: Boolean;
    function GetEditing: Boolean;
    function GetReporting: Boolean;
    procedure SetAccounting(const AValue: Boolean);
    procedure SetClearing(const AValue: Boolean);
    procedure SetEditing(const AValue: Boolean);
    procedure SetReporting(const AValue: Boolean);
  public
    constructor Create; virtual;
    function Equals(Obj: TObject): Boolean; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Editing: Boolean read GetEditing write SetEditing
      default DEFAULT_PRIVILEGIES_ACCOUNTING;
    property Clearing: Boolean read GetClearing write SetClearing
      default DEFAULT_PRIVILEGIES_CLEARING;
    property Accounting: Boolean read GetAccounting write SetAccounting
      default DEFAULT_PRIVILEGIES_EDITING;
    property Reporting: Boolean read GetReporting write SetReporting
      default DEFAULT_PRIVILEGIES_REPORTING;
  end;

function GetIPrivilegies: IPrivilegies;

implementation

uses
  CastersPackage.uRoutines;

function GetIPrivilegies: IPrivilegies;
begin
  Result := TPrivilegies.Create;
end;

procedure TPrivilegies.Assign(Source: TPersistent);
var
  o: TPrivilegies;
begin
  if Source is TPrivilegies then
  begin
    o := Source as TPrivilegies;
    Accounting := o.Accounting;
    Editing := o.Editing;
    Clearing := o.Clearing;
    Reporting := o.Reporting;
  end
  else
  begin
    inherited;
  end;
end;

constructor TPrivilegies.Create;
begin
  inherited;
  Routines.SetField(DEFAULT_PRIVILEGIES_ACCOUNTING, FAccounting);
  Routines.SetField(DEFAULT_PRIVILEGIES_CLEARING, FClearing);
  Routines.SetField(DEFAULT_PRIVILEGIES_EDITING, FEditing);
  Routines.SetField(DEFAULT_PRIVILEGIES_REPORTING, FReporting);
end;

function TPrivilegies.Equals(Obj: TObject): Boolean;
var
  o: TPrivilegies;
begin
  Result := False;
  if Obj is TPrivilegies then
  begin
    o := Obj as TPrivilegies;
    Result := (Accounting = o.Accounting) and (Editing = o.Editing) and (Clearing = o.Clearing) and
      (Reporting = o.Reporting);
  end
  else
  begin
    inherited;
  end;
end;

function TPrivilegies.GetAccounting: Boolean;
begin
  Result := FAccounting;
end;

function TPrivilegies.GetClearing: Boolean;
begin
  Result := FClearing;
end;

function TPrivilegies.GetEditing: Boolean;
begin
  Result := FEditing;
end;

function TPrivilegies.GetReporting: Boolean;
begin
  Result := FReporting;
end;

procedure TPrivilegies.SetAccounting(const AValue: Boolean);
begin
  Routines.SetField(AValue, FAccounting);
end;

procedure TPrivilegies.SetClearing(const AValue: Boolean);
begin
  Routines.SetField(AValue, FClearing);
end;

procedure TPrivilegies.SetEditing(const AValue: Boolean);
begin
  Routines.SetField(AValue, FEditing);
end;

procedure TPrivilegies.SetReporting(const AValue: Boolean);
begin
  Routines.SetField(AValue, FReporting);
end;

initialization

begin
  RegisterClass(TPrivilegies);
end;

end.
