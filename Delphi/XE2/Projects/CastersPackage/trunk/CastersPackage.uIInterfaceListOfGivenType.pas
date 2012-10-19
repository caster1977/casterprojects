unit CastersPackage.uIInterfaceListOfGivenType;

interface

type
  IInterfaceListOfGivenType<T: IInterface> = interface
    ['{CAA4BD57-6B34-4049-B339-1CDC686C5CA8}']
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

  (*
    ICar = interface
    ['{89398A1E-913F-42DA-A65C-88CB3F40808D}']
    end;

    TCar = class(TInterfacedObject, ICar)
    end;

    ICarList = interface(IInterfaceListOfGivenType<ICar>)
    ['{AA0A1D68-AB7B-49F1-BCCE-0EADE6CDBA1D}']
    end;

    TCarList = class(TInterfaceListOfGivenType<ICar>, ICarList)
    end;
  *)

implementation

end.
