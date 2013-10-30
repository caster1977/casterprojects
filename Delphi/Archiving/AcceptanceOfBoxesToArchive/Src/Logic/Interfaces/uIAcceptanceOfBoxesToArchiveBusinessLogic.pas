unit uIAcceptanceOfBoxesToArchiveBusinessLogic;

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
  /// Интерфейс доступа к объекту бизнес-логики процесса приёмки коробов в архив
  /// </summary>
  IAcceptanceOfBoxesToArchiveBusinessLogic = interface(ICustomBusinessLogic)
    ['{561D3DE0-DBFC-4CD0-BA84-476145EB08C0}']
    /// <summary>
    /// Процедура установки оконного контрола для вывода информации о
    /// последнем принятом в архив коробе
    /// </summary>
    /// <param name="AValue">
    /// Оконный контрол
    /// </param>
    procedure SetLastBoxInfoControl(const AValue: TCustomControl);

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
