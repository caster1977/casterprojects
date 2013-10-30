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
    /// <summary>
    /// Функция, возвращающая количество документов в текущем коробе
    /// </summary>
    /// <returns>
    /// Количество документов в текущем коробе
    /// </returns>
    function GetCurrentBoxDocumentCount: Integer;

    /// <summary>
    /// Процедура установки оконного контрола для вывода информации о
    /// текущем коробе
    /// </summary>
    /// <param name="AValue">
    /// Оконный контрол
    /// </param>
    procedure SetCurrentBoxInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// Процедура установки оконного контрола для вывода информации о
    /// последнем документе в текущем коробе
    /// </summary>
    /// <param name="AValue">
    /// Оконный контрол
    /// </param>
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// Процедура удаления последнего документа из текущего короба
    /// </summary>
    procedure ManualDeleteLastDocumentFromCurrentBox;

    /// <summary>
    /// Процедура печати стикера для текущего архивного короба в ручном режиме
    /// </summary>
    procedure ManualPrintCurrentBoxSticker;

    /// <summary>
    /// Функция обработки введённой строки
    /// </summary>
    /// <param name="AString">
    /// Штрих-код или другие строковые данные
    /// </param>
    procedure ProcessString(const AString: string);
  end;

implementation

end.
