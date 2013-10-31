unit uTDocumentArchivingBarcodeType;

interface

type
  /// <summary>
  /// Типы штрих-кодов, используемых при архивации документов
  /// </summary>
  TDocumentArchivingBarcodeType = (
    /// <summary>
    /// Неизвестный код
    /// </summary>
    dabtUnknown,

    /// <summary>
    /// Штрих-код БСО
    /// </summary>
    dabtBSO,

    /// <summary>
    /// Штрих-код архивного короба
    /// </summary>
    dabtArchiveBox,

    /// <summary>
    /// Штрих-код команды создания нового короба
    /// </summary>
    dabtForceNewBoxCommand,

    /// <summary>
    /// Штрих-код команды откладывания текущего короба
    /// </summary>
    dabtPutBoxAsideCommand,

    /// <summary>
    /// Штрих-код команды передачи последнего документа
    /// </summary>
    dabtGiveDocumentAway,

    /// <summary>
    /// Штрих-код порчи БСО
    /// </summary>
    dabtCauseOfDamage);

implementation

end.
