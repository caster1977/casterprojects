/// <summary>
/// Модуль, содержащий описание интерфейса <b>IArchiveBox</b>
/// </summary>
unit uIArchiveBox;

interface

uses
  uIDocument;

type
  /// <summary>
  /// Интерфейс "<b>Архивный короб</b>"
  /// </summary>
  IArchiveBox = interface
    ['{C2984458-D3DF-4EB2-9D28-8756E9DD51F4}']
    function GetId: Integer;
    procedure SetId(const AValue: Integer);

    /// <summary>
    /// Идентификатор архивного короба
    /// </summary>
    property Id: Integer read GetId write SetId;

    function GetName: string;

    ///	<summary>
    ///	  Наименование (код) короба
    ///	</summary>
    ///	<remarks>
    ///	  Генерируется на основе значений полей TypeId, CompanyId, Year, Number
    ///	</remarks>
    property Name: string read GetName;

    function GetTypeId: Integer;
    procedure SetTypeId(const AValue: Integer);

    /// <summary>
    /// Идентификатор типа короба
    /// </summary>
    property TypeId: Integer read GetTypeId write SetTypeId;

    function GetTypeName: string;
    procedure SetTypeName(const AValue: string);

    /// <summary>
    /// Наименование типа короба
    /// </summary>
    property TypeName: string read GetTypeName write SetTypeName;

    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);

    /// <summary>
    /// Штрих-код короба
    /// </summary>
    property Barcode: string read GetBarcode write SetBarcode;

    function GetYear: Integer;
    procedure SetYear(const AValue: Integer);

    /// <summary>
    /// Год короба
    /// </summary>
    property Year: Integer read GetYear write SetYear;

    function GetNumber: string;
    procedure SetNumber(const AValue: string);

    /// <summary>
    /// Порядковый номер короба в году
    /// </summary>
    property Number: string read GetNumber write SetNumber;

    function GetCompanyId: Integer;
    procedure SetCompanyId(const AValue: Integer);

    /// <summary>
    /// Идентификатор компании короба
    /// </summary>
    property CompanyId: Integer read GetCompanyId write SetCompanyId;

    function GetCompanyName: string;
    procedure SetCompanyName(const AValue: string);

    /// <summary>
    /// Наименование компании короба
    /// </summary>
    property CompanyName: string read GetCompanyName write SetCompanyName;

    /// <summary>
    /// Функция добавления документа в короб
    /// </summary>
    /// <param name="AValue">
    /// Документ
    /// </param>
    function AddDocument(const AValue: IDocument): Integer;
    /// <summary>
    /// Процедура удаления последнего документа из короба
    /// </summary>
    procedure DeleteLastDocument;

    function GetDocument(const AIndex: Integer): IDocument;

    /// <summary>
    /// Список документов в коробе
    /// </summary>
    /// <param name="AIndex">
    /// Индекс документа в коробе
    /// </param>
    property Documents[const AIndex: Integer]: IDocument read GetDocument; default;

    function GetDocumentCount: Integer;

    /// <summary>
    /// Количество документов в коробе
    /// </summary>
    property DocumentCount: Integer read GetDocumentCount;
  end;

implementation

end.
