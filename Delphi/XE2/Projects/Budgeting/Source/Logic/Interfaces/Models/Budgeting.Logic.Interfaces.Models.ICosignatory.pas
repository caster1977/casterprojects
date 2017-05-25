unit Budgeting.Logic.Interfaces.Models.ICosignatory;

interface

type
  ICosignatory = interface
    ['{B4B71664-DA58-492E-A678-75C2E06DE515}']
    function GetId(): Integer;
    property Id: Integer read GetId;

    function GetBankId(): Integer;
    property BankId: Integer read GetBankId;

    function GetName(): string;
    property Name: string read GetName;

    function GetUNP(): string;
    property UNP: string read GetUNP;

    function GetAddress(): string;
    property Address: string read GetAddress;

    function GetAgreementNumber(): string;
    property AgreementNumber: string read GetAgreementNumber;

    function GetAgreementStart(): TDate;
    property AgreementStart: TDate read GetAgreementStart;

    function GetAgreementStop(): TDate;
    property AgreementStop: TDate read GetAgreementStop;

    function GetAccount(): string;
    property Account: string read GetAccount;

    function GetActivity(): Boolean;
    property Activity: Boolean read GetActivity;
  end;

implementation

end.
