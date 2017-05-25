unit Budgeting.Logic.Classes.Models.TCosignatory;

interface

uses
  Budgeting.Logic.Interfaces.ICosignatory;

type
  TCosignatory = class(TInterfacedObject, ICosignatory)
  strict private
    FId: Integer;
    FBankId: Integer;
    FName: string;
    FUNP: string;
    FAddress: string;
    FAgreementNumber: string;
    FAgreementStart: TDate;
    FAgreementStop: TDate;
    FAccount: string;
    FActivity: Boolean;
    function GetId(): Integer;
    function GetBankId(): Integer;
    function GetName(): string;
    function GetUNP(): string;
    function GetAddress(): string;
    function GetAgreementNumber(): string;
    function GetAgreementStart(): TDate;
    function GetAgreementStop(): TDate;
    function GetAccount(): string;
    function GetActivity(): Boolean;
  public
    constructor Create(const AId, ABankId: Integer; const AName, AUNP, AAddress, AAgreementNumber: string; const AAgreementStart, AAgreementStop: TDate; const AAccount: string; const AActivity: Boolean); reintroduce; virtual;
  end;

implementation

uses
  System.SysUtils;

constructor TCosignatory.Create(const AId, ABankId: Integer; const AName, AUNP, AAddress, AAgreementNumber: string; const AAgreementStart, AAgreementStop: TDate; const AAccount: string; const AActivity: Boolean);
begin
  inherited Create();
  FId := AId;
  FBankId := ABankId;
  FName := AName;
  FUNP := AUNP;
  FAddress := AAddress;
  FAgreementNumber := AAgreementNumber;
  FAgreementStart := AAgreementStart;
  FAgreementStop := AAgreementStop;
  FAccount := AAccount;
  FActivity := AActivity;
end;

function TCosignatory.GetAccount(): string;
begin
  Result := FAccount;
end;

function TCosignatory.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TCosignatory.GetAddress(): string;
begin
  Result := FAddress;
end;

function TCosignatory.GetAgreementNumber(): string;
begin
  Result := FAgreementNumber;
end;

function TCosignatory.GetAgreementStart(): TDate;
begin
  Result := FAgreementStart;
end;

function TCosignatory.GetAgreementStop(): TDate;
begin
  Result := FAgreementStop;
end;

function TCosignatory.GetBankId(): Integer;
begin
  Result := FBankId;
end;

function TCosignatory.GetId(): Integer;
begin
  Result := FId;
end;

function TCosignatory.GetName(): string;
begin
  Result := FName;
end;

function TCosignatory.GetUNP(): string;
begin
  Result := FUNP;
end;

end.

