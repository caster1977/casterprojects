unit Budgeting.Logic.Interfaces.IModelItem;

interface

uses
  System.Classes;

type
  IModelItem = interface
    function GetA(): string;

    /// <summary>
    /// Номер ГТД
    /// </summary>
    property A: string read GetA;

    function GetB(): string;
    /// <summary>
    /// Номер временного ГТД
    /// </summary>
    property B: string read GetB;

    function GetC(): string;
    /// <summary>
    /// Номер приходного документа
    /// </summary>
    property C: string read GetC;

    function GetD(): string;
    /// <summary>
    /// Сумма прихода
    /// </summary>
    property D: string read GetD;

    function GetE(): string;
    /// <summary>
    /// Код валюты
    /// </summary>
    property E: string read GetE;

    function GetF(): string;
    /// <summary>
    /// Дата учёта
    /// </summary>
    property F: string read GetF;

    function GetG(): string;
    procedure SetG(const aValue: string);
    /// <summary>
    /// Остаток на начало периода
    /// </summary>
    property G: string read GetG write SetG;

    function GetH(): string;
    procedure SetH(const aValue: string);
    /// <summary>
    /// Приходы за период
    /// </summary>
    property H: string read GetH write SetH;

    function GetI(): string;
    procedure SetI(const aValue: string);
    /// <summary>
    /// Расходы за период
    /// </summary>
    property I: string read GetI write SetI;

    function GetJ(): string;
    procedure SetJ(const aValue: string);
    /// <summary>
    /// Остаток на конец периода
    /// </summary>
    property J: string read GetJ write SetJ;

    function GetK(): string;
    procedure SetK(const aValue: string);
    /// <summary>
    /// Остаток на начало периода
    /// </summary>
    property K: string read GetK write SetK;

    function GetL(): string;
    procedure SetL(const aValue: string);
    /// <summary>
    /// Приходы за период
    /// </summary>
    property L: string read GetL write SetL;

    function GetM(): string;
    procedure SetM(const aValue: string);
    /// <summary>
    /// Расходы за период
    /// </summary>
    property M: string read GetM write SetM;

    function GetN(): string;
    procedure SetN(const aValue: string);
    /// <summary>
    /// Остаток на конец периода
    /// </summary>
    property N: string read GetN write SetN;

    function AsArray(): TArray<string>;
  end;

implementation

end.
