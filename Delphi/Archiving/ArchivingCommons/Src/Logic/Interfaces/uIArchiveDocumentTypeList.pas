unit uIArchiveDocumentTypeList;

interface

uses
  uILoadableList,
  uIArchiveDocumentTypeItem;

type
  IArchiveDocumentTypeList = interface(ILoadableList)
    ['{193075BB-88E2-43AB-83D2-BB16475B253F}']
    /// <summary>
    /// Функция получения ссылки на тип архивного документа с указанным идентификатором
    /// </summary>
    /// <param name="AId">
    /// Идентификатор
    /// </param>
    /// <returns>
    /// Тип документа
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveDocumentTypeItem;
    function GetItem(const AIndex: Integer): IArchiveDocumentTypeItem;
    /// <summary>
    /// Массив типов архивных документов
    /// </summary>
    /// <param name="AIndex">
    /// Порядковый номер элемента в массиве
    /// </param>
    property Items[const AIndex: Integer]: IArchiveDocumentTypeItem read GetItem; default;
  end;

implementation

end.
