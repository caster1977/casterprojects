unit uIArchiveDocumentItem;

interface

uses
  DB,
  Classes,
  Controls,
  uILoadableItem;

type
  /// <summary>
  /// Интерфейс для доступа к объекту архивного документа
  /// </summary>
  IArchiveDocumentItem = interface(ILoadableItem)
    ['{90EEBE6E-BE2C-41DC-B186-079F95C9B558}']
    function GetArchiveBoxId: Integer;
    procedure SetArchiveBoxId(const AValue: Integer);

    /// <summary>
    /// Идентификатор архивного короба
    /// </summary>
    property ArchiveBoxId: Integer read GetArchiveBoxId write SetArchiveBoxId;

    function GetArchivedByUser: Integer;
    procedure SetArchivedByUser(const AValue: Integer);

    /// <summary>
    /// Идентификатор пользователя, заархивировавшего документ
    /// </summary>
    property ArchivedByUser: Integer read GetArchivedByUser write SetArchivedByUser;

    function GetArchivingDate: TDateTime;
    procedure SetArchivingDate(const AValue: TDateTime);

    /// <summary>
    /// Дата архивации документа
    /// </summary>
    property ArchivingDate: TDateTime read GetArchivingDate write SetArchivingDate;

    function GetIssued: Boolean;
    procedure SetIssued(const AValue: Boolean);

    /// <summary>
    /// Был ли выдан бланк
    /// </summary>
    property Issued: Boolean read GetIssued write SetIssued;

    function GetIssuedToUser: Integer;
    procedure SetIssuedToUser(const AValue: Integer);

    /// <summary>
    /// Идентификатор пользователя, которому был выдан документ
    /// </summary>
    property IssuedToUser: Integer read GetIssuedToUser write SetIssuedToUser;

    function GetIssuanceDate: TDateTime;
    procedure SetIssuanceDate(const AValue: TDateTime);

    /// <summary>
    /// Дата выдачи документа из архива
    /// </summary>
    property IssuanceDate: TDateTime read GetIssuanceDate write SetIssuanceDate;

    function GetCompanyId: Integer;
    procedure SetCompanyId(const AValue: Integer);

    /// <summary>
    /// Идентификатор компании
    /// </summary>
    property CompanyId: Integer read GetCompanyId write SetCompanyId;

    function GetCompanyName: string;
    procedure SetCompanyName(const AValue: string);

    /// <summary>
    /// Наименование компании
    /// </summary>
    property CompanyName: string read GetCompanyName write SetCompanyName;

    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);

    /// <summary>
    /// Штрих-код документа
    /// </summary>
    property Barcode: string read GetBarcode write SetBarcode;

    /// <summary>
    /// Функция инициализации полей объекта значениями, содержащимися в
    /// входящей строке
    /// </summary>
    /// <param name="AValue">
    /// Строка, содержащая значения для инициализации полей объекта
    /// </param>
    /// <returns>
    /// Удалось ли выполнить инициализацию
    /// </returns>
    /// <remarks>
    /// Работает по принципу парсера
    /// </remarks>
    function FromString(const AValue: string): Boolean;

    function GetSequenceNumber: Integer;
    procedure SetSequenceNumber(const AValue: Integer);

    /// <summary>
    /// Порядковый номер в архивном коробе
    /// </summary>
    property SequenceNumber: Integer read GetSequenceNumber write SetSequenceNumber;

    /// <summary>
    /// Функция для определения архивного короба, в который помещён документ
    /// </summary>
    /// <param name="AConnection">
    /// Объект подключения к БД
    /// </param>
    /// <returns>
    /// Идентификатор короба в котором содержится указанный документ, либо -1
    /// (если документ ещё не был заархивирован)
    /// </returns>
    function AlreadyArchived(const AConnection: TCustomConnection = nil): Integer;
  end;

implementation

end.
