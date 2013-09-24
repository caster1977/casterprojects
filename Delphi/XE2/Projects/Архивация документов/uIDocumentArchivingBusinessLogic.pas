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

    /// <summary>
    /// Функция печати стикера для текущего архивного короба в ручном режиме
    /// </summary>
    function ManualPrintCurrentBoxSticker: Boolean;

    /// <summary>
    /// Функция "откладывания" текущего короба
    /// </summary>
    function PutCurrentBoxAside: Boolean;

    /// <summary>
    /// Функция удаления последнего документа из текущего короба
    /// </summary>
    function DeleteLastDocumentInCurrentBox: Boolean;

    /// <summary>
    /// Функция обработки введённой строки
    /// </summary>
    /// <param name="AString">
    /// Штрих-код или другие строковые данные
    /// </param>
    procedure ProcessString(const AString: string);

    /// <summary>
    /// Отметка указанного документа в реестре приёмки с ЛП
    /// </summary>
    /// <param name="ABSO">
    /// БСО
    /// </param>
    procedure AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem);
  end;

implementation

end.
