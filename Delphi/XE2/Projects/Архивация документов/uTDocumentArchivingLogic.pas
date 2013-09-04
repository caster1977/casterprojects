unit uTDocumentArchivingLogic;

interface

uses
  Classes,
  DB,
  SqlExpr,
  ADODB,
  uTOnShowMessage;

type
  TDocumentArchivingLogic = class abstract(TInterfacedObject)
  private
    FConnection: TCustomConnection;
    function GetConnection: TCustomConnection;
  public
    property Connection: TCustomConnection read GetConnection nodefault;

  private
    FOnShowMessage: TOnShowMessage;
    function GetOnShowMessage: TOnShowMessage;
    procedure SetOnShowMessage(const AValue: TOnShowMessage);
  public
    property OnShowMessage: TOnShowMessage read GetOnShowMessage write SetOnShowMessage nodefault;

  public
    constructor Create(const AADOConnection: TADOConnection; const AOnShowMessage: TOnShowMessage = nil);
      overload; virtual;
    constructor Create(const ASQLConnection: TSQLConnection; const AOnShowMessage: TOnShowMessage = nil);
      overload; virtual;
  end;

implementation

function TDocumentArchivingLogic.GetConnection: TCustomConnection;
begin
  Result := FConnection;
end;

function TDocumentArchivingLogic.GetOnShowMessage: TOnShowMessage;
begin
  Result := FOnShowMessage;
end;

procedure TDocumentArchivingLogic.SetOnShowMessage(const AValue: TOnShowMessage);
begin
  FOnShowMessage := AValue;
end;

constructor TDocumentArchivingLogic.Create(const AADOConnection: TADOConnection; const AOnShowMessage: TOnShowMessage);
begin
  FConnection := AADOConnection;
  FOnShowMessage := AOnShowMessage;
end;

constructor TDocumentArchivingLogic.Create(const ASQLConnection: TSQLConnection; const AOnShowMessage: TOnShowMessage);
begin
  FConnection := ASQLConnection;
  FOnShowMessage := AOnShowMessage;
end;

end.
