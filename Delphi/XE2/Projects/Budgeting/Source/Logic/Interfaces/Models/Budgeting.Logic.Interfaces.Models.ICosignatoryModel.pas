unit Budgeting.Logic.Interfaces.Models.ICosignatoryModel;

interface

uses
  Budgeting.Logic.Interfaces.Models.ICustomModel;

type
  ICosignatoryModel = interface(ICustomModel)
    ['{B4B71664-DA58-492E-A678-75C2E06DE515}']
    function GetId_Bank(): Integer;
    property Id_Bank: Integer read GetId_Bank;

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
