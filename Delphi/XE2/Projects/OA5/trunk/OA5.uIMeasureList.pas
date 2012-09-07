unit OA5.uIMeasureList;

interface

uses
  System.Classes,
  OA5.uIMeasure;

type
  IMeasureList = interface
    ['{5E8836C1-9622-4F7B-AFA2-523E54B5149B}']
    procedure AfterCreate;
    procedure BeforeDestroy;

    function GetItem(const AIndex: Integer): IMeasure;
    procedure PutItem(const AIndex: Integer; const AItem: IMeasure);

    function GetCount: Integer;
    procedure SetCount(const ANewCount: Integer);

    function Add(const AItem: IMeasure): Integer;
    procedure Append(const AItems: IMeasureList);
    procedure Insert(const AIndex: Integer; const AItem: IMeasure);

    procedure Delete(const AIndex: Integer);
    function Remove(const AItem: IMeasure; const ASkipIfNotFound: Boolean = False): Integer; overload;
    procedure Remove(const AItems: IMeasureList; const ASkipIfNotFound: Boolean = False); overload;
    procedure Clear;

    function First: IMeasure;
    function Last: IMeasure;

    procedure Exchange(const AIndex1, AIndex2: Integer);
    function IndexOf(const AItem: IMeasure): Integer;

    property Count: Integer read GetCount write SetCount;
    property Items[const AIndex: Integer]: IMeasure read GetItem write PutItem; default;
  end;

implementation

end.
