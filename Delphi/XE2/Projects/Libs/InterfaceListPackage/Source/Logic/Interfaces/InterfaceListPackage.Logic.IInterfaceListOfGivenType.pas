unit InterfaceListPackage.Logic.IInterfaceListOfGivenType;

interface

type
  IInterfaceListOfGivenType<T: IInterface> = interface
    ['{CAA4BD57-6B34-4049-B339-1CDC686C5CA8}']
    function Equals(const AItems: IInterfaceListOfGivenType<T>): Boolean;
    procedure Assign(const AItems: IInterfaceListOfGivenType<T>);
    function Add(const AItem: T): Integer;
    procedure Append(const AItems: IInterfaceListOfGivenType<T>);
    procedure Insert(const AIndex: Integer; const AItem: T);
    procedure Delete(const AIndex: Integer);
    function Remove(const AItem: T; const ASkipIfNotFound: Boolean = False): Integer; overload;
    procedure Remove(const AItems: IInterfaceListOfGivenType<T>; const ASkipIfNotFound: Boolean = False); overload;
    procedure Clear;
    function First: T;
    function Last: T;
    procedure Exchange(const AIndex1, AIndex2: Integer);
    function IndexOf(const AItem: T): Integer;
    function GetCount: Integer;
    procedure SetCount(const ANewCount: Integer);
    property Count: Integer read GetCount write SetCount;
    function GetItem(const AIndex: Integer): T;
    procedure PutItem(const AIndex: Integer; const AItem: T);
    property Items[const AIndex: Integer]: T read GetItem write PutItem; default;
  end;

implementation

end.
