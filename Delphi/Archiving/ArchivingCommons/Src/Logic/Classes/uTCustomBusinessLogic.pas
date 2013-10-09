unit uTCustomBusinessLogic;

interface

uses
  uICustomBusinessLogic,
  Classes,
  DB,
  uTOnDisplayMessage,
  uTMessageType;

type
  TCustomBusinessLogic = class {$IFNDEF VER150} abstract {$ENDIF}(TInterfacedObject, ICustomBusinessLogic)
  private
    FOnDisplayMessage: TOnDisplayMessage;
{$IFDEF VER150}
  protected
{$ENDIF}
    function GetOnDisplayMessage: TOnDisplayMessage;
    procedure SetOnDisplayMessage(const AValue: TOnDisplayMessage);
  public
    property OnDisplayMessage: TOnDisplayMessage read GetOnDisplayMessage write SetOnDisplayMessage nodefault;

  private
    FConnection: TCustomConnection;
{$IFDEF VER150}
  protected
{$ENDIF}
    function GetConnection: TCustomConnection;
  public
    property Connection: TCustomConnection read GetConnection nodefault;

  private
    FQuery: TDataSet;
{$IFDEF VER150}
  protected
{$ENDIF}
    function GetQuery: TDataSet;
  protected
    property Query: TDataSet read GetQuery nodefault;

  private
    procedure DisplayMessage(const AType: TMessageType; const AText: string = '');
  protected
    procedure DisplayInfoMessage(const AText: string);
    procedure DisplayErrorMessage(const AText: string);
    procedure DisplaySuccessMessage(const AText: string);
    procedure ClearMessage;

  protected
    procedure CloseQuery;
  public
    constructor Create(const AConnection: TCustomConnection; const AOnDisplayMessage: TOnDisplayMessage = nil); virtual;
    destructor Destroy; override;
  end;

implementation

uses
  uArchivingCommonRoutines,
  SysUtils;

function TCustomBusinessLogic.GetConnection: TCustomConnection;
begin
  Result := FConnection;
end;

function TCustomBusinessLogic.GetOnDisplayMessage: TOnDisplayMessage;
begin
  Result := FOnDisplayMessage;
end;

function TCustomBusinessLogic.GetQuery: TDataSet;
begin
  Result := FQuery;
end;

procedure TCustomBusinessLogic.SetOnDisplayMessage(const AValue: TOnDisplayMessage);
begin
  FOnDisplayMessage := AValue;
end;

constructor TCustomBusinessLogic.Create(const AConnection: TCustomConnection;
  const AOnDisplayMessage: TOnDisplayMessage);
begin
  OnDisplayMessage := AOnDisplayMessage;
  FConnection := AConnection;
  FQuery := uArchivingCommonRoutines.GetQuery(Connection);
end;

procedure TCustomBusinessLogic.ClearMessage;
begin
  DisplayMessage(mtNone);
end;

procedure TCustomBusinessLogic.CloseQuery;
begin
  if Assigned(Query) then
  begin
    if Query.Active then
    begin
      Query.Close;
    end;
  end;
end;

destructor TCustomBusinessLogic.Destroy;
begin
  CloseQuery;
  FreeAndNil(FQuery);
  FConnection := nil;
  OnDisplayMessage := nil;
  inherited;
end;

procedure TCustomBusinessLogic.DisplayErrorMessage(const AText: string);
begin
  DisplayMessage(mtError, AText);
end;

procedure TCustomBusinessLogic.DisplayInfoMessage(const AText: string);
begin
  DisplayMessage(mtInfo, AText);
end;

procedure TCustomBusinessLogic.DisplaySuccessMessage(const AText: string);
begin
  DisplayMessage(mtSuccess, AText);
end;

procedure TCustomBusinessLogic.DisplayMessage(const AType: TMessageType; const AText: string);
begin
  if Assigned(OnDisplayMessage) then
  begin
    FOnDisplayMessage(AType, AText);
  end;
end;

end.
