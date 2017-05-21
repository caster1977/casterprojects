unit Budgeting.Logic.Classes.TPresenter;

interface

uses
  System.SysUtils,
  Data.DB,
  Budgeting.Logic.Interfaces.IPresenter,
  Budgeting.Logic.Interfaces.IView,
  Budgeting.Logic.TViewEnumEvent;

type
  TPresenter = class(TInterfacedObject, IPresenter)
  strict protected
    FView: IView;
    FProcessign: Boolean;
    FConnection: TCustomConnection;
    procedure OnEventSimple(aValue: TViewEnumEvent); virtual; abstract;
    procedure Initialize(); virtual;
    function GetConnectionString(): string;

  public
    constructor Create(const aView: IView); reintroduce; virtual;
  end;

implementation

uses
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  Budgeting.Logic.Classes.Configuration.Section.TDatabaseConnection;

constructor TPresenter.Create(const aView: IView);
begin
  Assert(Assigned(aView));
  inherited Create();
  FProcessign := False;
  FView := aView;
  FConnection := FView.GetConnection(GetConnectionString());
  FView.SetOnEventSimple(OnEventSimple);
  FView.StorePresenter(Self);
  Initialize();
end;

function TPresenter.GetConnectionString(): string;
begin
  Result := Format('Server=%s;Database=%s;MARS=yes;OSAuthent=Yes;DriverID=MSSQL;User_Name=%s;Password=%s;LoginTimeout=%d',
    [TConfiguration.Get(TConfiguration).Section<TDatabaseConnection>.Host.Trim(), TConfiguration.Get(TConfiguration).Section<TDatabaseConnection>.Database.Trim(),
    'root', 'qweasdzxc', TConfiguration.Get(TConfiguration).Section<TDatabaseConnection>.ConnectionTimeOut]);
end;

procedure TPresenter.Initialize();
begin
end;

end.
