unit uICauseOfArchiveDocumentDamageList;

interface

uses
  uILoadableList,
  uICauseOfArchiveDocumentDamageItem;

type
  /// <summary>
  /// Интерфейс для доступа к объктам списка причин "порчи" документов
  /// </summary>
  ICauseOfArchiveDocumentDamageList = interface(ILoadableList)
    ['{F5C40A5E-ADC5-47A6-9C5B-89A5F4D98DCA}']

    /// <summary>
    /// Функция получения ссылки на причину "порчи" документа с указанным
    /// идентификатором
    /// </summary>
    /// <param name="AId">
    /// Идентификатор
    /// </param>
    /// <returns>
    /// Причина "порчи"
    /// </returns>
    function GetItemById(const AId: Integer): ICauseOfArchiveDocumentDamageItem;
    function GetItem(const AIndex: Integer): ICauseOfArchiveDocumentDamageItem;

    /// <summary>
    /// Массив причин "порчи" документов
    /// </summary>
    /// <param name="AIndex">
    /// Порядковый номер элемента в массиве
    /// </param>
    property Item[const AIndex: Integer]: ICauseOfArchiveDocumentDamageItem read GetItem; default;
  end;

implementation

end.
