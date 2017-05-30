unit Budgeting.Logic.Classes.Presenters.TCustomPresenter;

interface

uses
  System.SysUtils,
  Data.DB,
  FireDAC.Comp.Client,
  Budgeting.Logic.Interfaces.Presenters.ICustomPresenter,
  Budgeting.Logic.Interfaces.Views.ICustomView,
  Budgeting.Logic.Types.TViewEnumEvent;

type
  TCustomPresenter = class(TInterfacedObject, ICustomPresenter)
  strict private
    function GetConnection(const aConnectionString: string): TFDConnection;
  strict protected
    FView: ICustomView;
    FProcessign: Boolean;
    FConnection: TFDConnection;
    procedure OnEventSimple(aValue: TViewEnumEvent); virtual; abstract;
    procedure Initialize(); virtual;
    function GetConnectionString(): string;
  public
    constructor Create(const aView: ICustomView); reintroduce; virtual;
    destructor Destroy(); override;
  end;

implementation

uses
  CodeSiteLogging,
  Budgeting.Logic.Classes.Configuration.TConfiguration,
  FireDAC.Stan.ASync,
  FireDAC.DApt,
  FireDAC.Stan.Def,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  System.StrUtils,
  Budgeting.Logic.Classes.Configuration.Sections.TDatabaseSection,
  Budgeting.Logic.Interfaces.Views.ICustomEditView;

constructor TCustomPresenter.Create(const aView: ICustomView);
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

function TCustomPresenter.GetConnectionString(): string;
begin
  Result := Format('Server=%s;Database=%s;MARS=yes;OSAuthent=Yes;DriverID=MSSQL;User_Name=%s;Password=%s;LoginTimeout=%d',
    [TConfiguration.Get(TConfiguration).Section<TDatabaseSection>.Host.Trim(), TConfiguration.Get(TConfiguration)
    .Section<TDatabaseSection>.Database.Trim(), 'r81t', 'M+fL5lT7lGqW8RGoVyN1UAFDzNoM2u17T7I2M+izrHo=', TConfiguration.Get(TConfiguration).Section<TDatabaseSection>.ConnectionTimeOut]);
end;

destructor TCustomPresenter.Destroy();
begin
  try
    if Assigned(FView) then
    begin
      FView.StorePresenter(nil);
      FView.SetOnEventSimple(nil);
    end;
  finally
    inherited;
  end;
end;

function TCustomPresenter.GetConnection(const aConnectionString: string): TFDConnection;
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

procedure TCustomPresenter.Initialize();
begin
  OnEventSimple(veInitialization);
end;

end.
