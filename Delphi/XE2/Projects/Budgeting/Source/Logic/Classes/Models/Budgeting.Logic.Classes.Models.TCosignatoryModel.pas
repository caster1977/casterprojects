unit Budgeting.Logic.Classes.Models.TCosignatoryModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICosignatoryModel;

type
  TCosignatoryModel = class(TInterfacedObject, ICosignatoryModel)
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

constructor TCosignatoryModel.Create(const AId, ABankId: Integer; const AName, AUNP, AAddress, AAgreementNumber: string; const AAgreementStart, AAgreementStop: TDate; const AAccount: string; const AActivity: Boolean);
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

function TCosignatoryModel.GetAccount(): string;
begin
  Result := FAccount;
end;

function TCosignatoryModel.GetActivity(): Boolean;
begin
  Result := FActivity;
end;

function TCosignatoryModel.GetAddress(): string;
begin
  Result := FAddress;
end;

function TCosignatoryModel.GetAgreementNumber(): string;
begin
  Result := FAgreementNumber;
end;

function TCosignatoryModel.GetAgreementStart(): TDate;
begin
  Result := FAgreementStart;
end;

function TCosignatoryModel.GetAgreementStop(): TDate;
begin
  Result := FAgreementStop;
end;

function TCosignatoryModel.GetBankId(): Integer;
begin
  Result := FBankId;
end;

function TCosignatoryModel.GetId(): Integer;
begin
  Result := FId;
end;

function TCosignatoryModel.GetName(): string;
begin
  Result := FName;
end;

function TCosignatoryModel.GetUNP(): string;
begin
  Result := FUNP;
end;

end.

