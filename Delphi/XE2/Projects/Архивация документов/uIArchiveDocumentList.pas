unit uIArchiveDocumentList;

interface

uses
  uILoadableList,
  uIArchiveDocumentItem;

type
  /// <summary>
  /// Интерфейс для доступа к объктам списка архивных документов
  /// </summary>
  IArchiveDocumentList = interface(ILoadableList)
    ['{7CE6B5BB-CBB6-4E35-9A29-0BE6DE8FC655}']
    /// <summary>
    /// Функция получения ссылки на документ с указанным идентификатором
    /// </summary>
    /// <param name="AId">
    /// Идентификатор
    /// </param>
    /// <returns>
    /// Документ
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveDocumentItem;

    function GetItem(const AIndex: Integer): IArchiveDocumentItem;

    /// <summary>
    /// Массив документов
    /// </summary>
    /// <param name="AIndex">
    /// Порядковый номер элемента в массиве
    /// </param>
    property Item[const AIndex: Integer]: IArchiveDocumentItem read GetItem; default;
  end;

implementation

end.
