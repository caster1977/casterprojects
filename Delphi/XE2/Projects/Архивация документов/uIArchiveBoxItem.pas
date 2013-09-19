unit uIArchiveBoxItem;

interface

uses
  uILoadableItem,
  uIArchiveDocumentList;

type
  /// <summary>
  /// Интерфейс доступа к объектам типа "Архивный короб"
  /// </summary>
  IArchiveBoxItem = interface(ILoadableItem)
    ['{59858136-1220-46A2-B333-760F1A964A37}']
    function GetCreationDate: TDateTime;
    procedure SetCreationDate(const AValue: TDateTime);

    /// <summary>
    /// Дата и время создания короба
    /// </summary>
    property CreationDate: TDateTime read GetCreationDate write SetCreationDate;

    function GetBarcode: string;

    /// <summary>
    /// Штрих-код короба
    /// </summary>
    property Barcode: string read GetBarcode;

    function GetClosed: Boolean;
    procedure SetClosed(const AValue: Boolean);

    /// <summary>
    /// Закрыт ли короб
    /// </summary>
    property Closed: Boolean read GetClosed write SetClosed;

    function GetClosureDate: TDateTime;
    procedure SetClosureDate(const AValue: TDateTime);

    /// <summary>
    /// Дата и время закрытия короба
    /// </summary>
    property ClosureDate: TDateTime read GetClosureDate write SetClosureDate;

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

    function GetNumber: Integer;
    procedure SetNumber(const AValue: Integer);

    /// <summary>
    /// Порядковый номер короба в году
    /// </summary>
    property Number: Integer read GetNumber write SetNumber;

    function GetRegistryPrinted: Boolean;
    procedure SetRegistryPrinted(const AValue: Boolean);

    /// <summary>
    /// Был ли распечатан реестр короба
    /// </summary>
    property RegistryPrinted: Boolean read GetRegistryPrinted write SetRegistryPrinted;

    function GetStickerPrinted: Boolean;
    procedure SetStickerPrinted(const AValue: Boolean);

    /// <summary>
    /// Был ли распечатан стикер короба
    /// </summary>
    property StickerPrinted: Boolean read GetStickerPrinted write SetStickerPrinted;

    function GetTypeId: Integer;
    procedure SetTypeId(const AValue: Integer);

    /// <summary>
    /// Идентификатор типа короба
    /// </summary>
    property TypeId: Integer read GetTypeId write SetTypeId;

    function GetTypeName: string;
    procedure SetTypeName(const AValue: string);

    /// <summary>
    /// Наименгование типа короба
    /// </summary>
    property TypeName: string read GetTypeName write SetTypeName;

    function GetYear: Integer;
    procedure SetYear(const AValue: Integer);

    /// <summary>
    /// Год короба
    /// </summary>
    property Year: Integer read GetYear write SetYear;

    function GetUserId: Integer;
    procedure SetUserId(const AValue: Integer);

    /// <summary>
    /// Идентификатор пользователя, работающего с коробом
    /// </summary>
    property UserId: Integer read GetUserId write SetUserId;

    function GetDocuments: IArchiveDocumentList;

    /// <summary>
    /// Список документов в коробе
    /// </summary>
    property Documents: IArchiveDocumentList read GetDocuments;
  end;

implementation

end.
