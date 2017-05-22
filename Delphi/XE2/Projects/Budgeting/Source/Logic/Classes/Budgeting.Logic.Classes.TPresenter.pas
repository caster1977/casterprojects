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
  strict private
    function GetConnection(const aConnectionString: string): TCustomConnection;
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
  CodeSiteLogging,
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  FireDAC.Comp.Client,
  FireDAC.Stan.ASync,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  Budgeting.Logic.Classes.Configuration.Section.TDatabaseConnection;

constructor TPresenter.Create(const aView: IView);
begin
  Assert(Assigned(aView));
  inherited Create();
  FProcessign := False;
  FView := aView;
  FConnection := GetConnection(GetConnectionString());
  FView.SetOnEventSimple(OnEventSimple);
  FView.StorePresenter(Self);
  Initialize();
end;

function TPresenter.GetConnectionString(): string;
begin
  Result := Format('Server=%s;Database=%s;MARS=yes;OSAuthent=Yes;DriverID=MSSQL;User_Name=%s;Password=%s;LoginTimeout=%d',
    [TConfiguration.Get(TConfiguration).Section<TDatabaseConnection>.Host.Trim(), TConfiguration.Get(TConfiguration)
    .Section<TDatabaseConnection>.Database.Trim(), 'root', 'qweasdzxc', TConfiguration.Get(TConfiguration).Section<TDatabaseConnection>.ConnectionTimeOut]);
end;

function TPresenter.GetConnection(const aConnectionString: string): TCustomConnection;
var
  tmpConnection: TFDConnection;
begin
  {$IFDEF DEBUG}
  Result := nil;
   CodeSite.EnterMethod(Self, 'GetConnection()');
  try
    {$ENDIF}
    try
      {$REGION 'Создание подлюкчения к БД'}
      tmpConnection := TFDConnection.Create(nil);
      if Assigned(tmpConnection) then
      begin
        tmpConnection.LoginPrompt := False;
        tmpConnection.FetchOptions.AutoClose := False;
        tmpConnection.FetchOptions.Mode := fmAll;
        tmpConnection.ResourceOptions.SilentMode := True;
        tmpConnection.ResourceOptions.DirectExecute := True;
        tmpConnection.ResourceOptions.MacroCreate := False;
        tmpConnection.ResourceOptions.MacroExpand := False;
        tmpConnection.ConnectionString := aConnectionString;
        {$IFDEF DEBUG}
        CodeSite.Send('ConnectionString', tmpConnection.ConnectionString);
        {$ENDIF}
      end;
      Result := tmpConnection;
      {$ENDREGION}
    except
      on e: Exception do
      begin
        CodeSite.SendException(e);
        raise;
      end;
    end;
    {$IFDEF DEBUG}
  finally
    CodeSite.ExitMethod(Self, 'GetConnection()');
  end;
  {$ENDIF}
end;

procedure TPresenter.Initialize();
begin
end;

end.
