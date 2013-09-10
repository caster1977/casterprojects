/// <summary>
/// Модуль, содержащий описание интерфейса <b>IArchiveBox</b>
/// </summary>
unit uIArchiveBox;

interface

uses
  uIDocument,
  uIDocumentBox,
  uILoadableList;

type
  IArchiveBox = interface(IDocumentBox)
    ['{C2984458-D3DF-4EB2-9D28-8756E9DD51F4}']
    function GetTypeId: Integer;
    procedure SetTypeId(const AValue: Integer);

    /// <summary>
    /// Идентификатор типа короба
    /// </summary>
    property TypeId: Integer read GetTypeId write SetTypeId;

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

    function GetNumber: Integer;
    procedure SetNumber(const AValue: Integer);

    /// <summary>
    /// Порядковый номер короба в году
    /// </summary>
    property Number: Integer read GetNumber write SetNumber;

    function GetCompanyId: Integer;
    procedure SetCompanyId(const AValue: Integer);

    /// <summary>
    /// Идентификатор компании короба
    /// </summary>
    property CompanyId: Integer read GetCompanyId write SetCompanyId;

    function GetClosureDate: TDateTime;
    procedure SetClosureDate(const AValue: TDateTime);

    ///	<summary>
    ///	  Дата и время закрытия короба
    ///	</summary>
    property ClosureDate: TDateTime read GetClosureDate write SetClosureDate;

    function GetClosed: Boolean;
    procedure SetClosed(const AValue: Boolean);

    ///	<summary>
    ///	  Закрыт ли короб
    ///	</summary>
    property Closed: Boolean read GetClosed write SetClosed;

    function GetRegistryPrinted: Boolean;
    procedure SetRegistryPrinted(const AValue: Boolean);

    ///	<summary>
    ///	  Был ли распечатан реестр короба
    ///	</summary>
    property RegistryPrinted: Boolean read GetRegistryPrinted write SetRegistryPrinted;

    function GetStickerPrinted: Boolean;
    procedure SetStickerPrinted(const AValue: Boolean);

    ///	<summary>
    ///	  Был ли распечатан стикер короба
    ///	</summary>
    property StickerPrinted: Boolean read GetStickerPrinted write SetStickerPrinted;

  end;

implementation

end.
