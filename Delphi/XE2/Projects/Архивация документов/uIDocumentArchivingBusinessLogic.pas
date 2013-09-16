unit uIDocumentArchivingBusinessLogic;

interface

uses
  Controls,
  uICustomBusinessLogic,
  uIArchiveBoxItem,
  uIShowable;

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
    property CurrentBoxInfoControl: TCustomControl read GetCurrentBoxInfoControl
      write SetCurrentBoxInfoControl;

    function GetLastDocumentInfoControl: TCustomControl;
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// Контрол, в который будет выводится информация о последнем документе
    /// </summary>
    property LastDocumentInfoControl: TCustomControl read GetLastDocumentInfoControl
      write SetLastDocumentInfoControl;

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
    /// Функция определения "заполненности" текущего короба
    /// </summary>
    function CurrentBoxIsFull: Boolean;
  end;

implementation

end.
