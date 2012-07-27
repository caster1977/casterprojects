unit Beeper.uISignalList;

interface

uses
  Beeper.uISignal,
  System.Classes;

type
  ISignalList = interface
    ['{D85F74EC-8C32-4132-9AAB-4F7BEF367ACE}']
    function GetItem(const AIndex: Integer): ISignal;
    procedure PutItem(const AIndex: Integer; const AItem: ISignal);
    function GetCount: Integer;
    procedure SetCount(const ANewCount: Integer);
    function Add(const AItem: ISignal): Integer;
    procedure Append(const AItems: ISignalList);
    procedure Insert(const AIndex: Integer; const AItem: ISignal);
    procedure Delete(const AIndex: Integer);
    procedure Exchange(const AIndex1, AIndex2: Integer);
    function Remove(const AItem: ISignal; const ASkipIfNotFound: Boolean = False): Integer; overload;
    procedure Remove(const AItems: ISignalList; const ASkipIfNotFound: Boolean = False); overload;
    procedure Clear;
    function First: ISignal;
    function Last: ISignal;
    function IndexOf(const AItem: ISignal): Integer;
    property Count: Integer read GetCount write SetCount;
    property Items[const AIndex: Integer]: ISignal read GetItem write PutItem; default;
  end;

implementation

end.
