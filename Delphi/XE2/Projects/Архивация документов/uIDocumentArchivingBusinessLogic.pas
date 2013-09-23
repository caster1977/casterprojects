unit uIDocumentArchivingBusinessLogic;

interface

uses
  Controls,
  uICustomBusinessLogic,
  uIArchiveBoxItem,
  uIShowable,
  uIArchiveDocumentItem,
  uICustomBSOItem,
  uTDocumentArchivingBarcodeType,
  uIArchiveDocumentList;

type
  /// <summary>
  /// Интерфейс доступа к объекту бизнес-логики процесса архивации документов
  /// </summary>
  IDocumentArchivingBusinessLogic = interface(ICustomBusinessLogic)
    ['{B4D4317B-5679-4A31-9F53-F31CFFD99A6F}']
    function GetCurrentBox: IArchiveBoxItem;
    procedure SetCurrentBox(const AValue: IArchiveBoxItem);

    /// <summary>
    /// Текущий архивный короб
    /// </summary>
    property CurrentBox: IArchiveBoxItem read GetCurrentBox write SetCurrentBox;

    function GetCurrentBoxInfoControl: TCustomControl;
    procedure SetCurrentBoxInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// Контрол, в который будет выводится информация о текущем коробе
    /// </summary>
    property CurrentBoxInfoControl: TCustomControl read GetCurrentBoxInfoControl write SetCurrentBoxInfoControl;

    function GetLastDocumentInfoControl: TCustomControl;
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// Контрол, в который будет выводится информация о последнем документе
    /// </summary>
    property LastDocumentInfoControl: TCustomControl read GetLastDocumentInfoControl write SetLastDocumentInfoControl;

    function GetCurrentUserId: Integer;
    /// <summary>
    /// Идентификатор текущего пользователя
    /// </summary>
    property CurrentUserId: Integer read GetCurrentUserId;

    function GetArchiveBoxTypeId: Integer;
    /// <summary>
    /// Идентификатор типа архивного короба
    /// </summary>
    property ArchiveBoxTypeId: Integer read GetArchiveBoxTypeId;

    /// <summary>
    /// Процедура, выполняющая вывод в контрол данных о текущем коробе
    /// </summary>
    /// <param name="AControl">
    /// Родительский контрол, в котором будут выведены данные
    /// </param>
    procedure ShowCurrentBoxInfo;

    /// <summary>
    /// Процедура, выполняющая вывод в контрол данных о последнем документе
    /// </summary>
    /// <param name="AControl">
    /// Родительский контрол, в котором будут выведены данные
    /// </param>
    procedure ShowLastDocumentInfo;

    /// <summary>
    /// Функция печати стикера для текущего архивного короба
    /// </summary>
    function PrintCurrentBoxSticker: Boolean;

    /// <summary>
    /// Функция "откладывания" текущего короба
    /// </summary>
    function PutCurrentBoxAside: Boolean;

    /// <summary>
    /// Функция закрытия текущего короба
    /// </summary>
    function CloseCurrentBox: Boolean;

    /// <summary>
    /// Функция удаления текущего короба
    /// </summary>
    function DeleteCurrentBox: Boolean;

    /// <summary>
    /// Функция удаления полседнего документа из текущего короба
    /// </summary>
    function DeleteLastDocument: Boolean;

    /// <summary>
    /// Функция определения "заполненности" текущего короба
    /// </summary>
    function ArchiveBoxIsFull: Boolean;

    /// <summary>
    /// Отметка указанного документа в реестре приёмки с ЛП
    /// </summary>
    /// <param name="ABSO">
    /// БСО
    /// </param>
    procedure AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem);

    /// <summary>
    /// Функция обработки введённого штрих-кода
    /// </summary>
    /// <param name="ABarcode">
    /// Штрих-код
    /// </param>
    procedure ProcessBarcode(const ABarcode: string);
  end;

implementation

end.
