unit uTCustomBusinessLogic;

interface

uses
  uICustomBusinessLogic,
  Classes,
  DB,
  SqlExpr,
  ADODB,
  uTOnDisplayMessage,
  uTMessageType;

type
  TCustomBusinessLogic = class abstract(TInterfacedObject, ICustomBusinessLogic)
  private
    FOnDisplayMessage: TOnDisplayMessage;
    function GetOnDisplayMessage: TOnDisplayMessage;
    procedure SetOnDisplayMessage(const AValue: TOnDisplayMessage);
  public
    property OnDisplayMessage: TOnDisplayMessage read GetOnDisplayMessage
      write SetOnDisplayMessage nodefault;

  private
    FConnection: TCustomConnection;
    function GetConnection: TCustomConnection;
  public
    property Connection: TCustomConnection read GetConnection nodefault;

  private
    FQuery: TDataSet;
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
    constructor Create(const AADOConnection: TADOConnection;
      const AOnDisplayMessage: TOnDisplayMessage = nil); overload; virtual;
    constructor Create(const ASQLConnection: TSQLConnection;
      const AOnDisplayMessage: TOnDisplayMessage = nil); overload; virtual;
    destructor Destroy; override;
  end;

implementation

uses
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

constructor TCustomBusinessLogic.Create(const AADOConnection: TADOConnection;
  const AOnDisplayMessage: TOnDisplayMessage);
begin
  OnDisplayMessage := AOnDisplayMessage;
  FConnection := AADOConnection;
  FQuery := TADOQuery.Create(nil);
  (Query as TADOQuery).Connection := (Connection as TADOConnection);
  (Query as TADOQuery).CommandTimeout := 60000;
  (Query as TADOQuery).LockType := ltReadOnly;
  (Query as TADOQuery).CursorType := ctOpenForwardOnly;
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

constructor TCustomBusinessLogic.Create(const ASQLConnection: TSQLConnection;
  const AOnDisplayMessage: TOnDisplayMessage);
begin
  OnDisplayMessage := AOnDisplayMessage;
  FConnection := ASQLConnection;
  FQuery := TSQLQuery.Create(nil);
  (Query as TSQLQuery).SQLConnection := (Connection as TSQLConnection);
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
    OnDisplayMessage(AType, AText);
  end;
end;

end.
