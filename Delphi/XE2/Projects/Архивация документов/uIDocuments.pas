unit uIDocuments;

interface

uses
  uIDocument,
  uILoadableList;

type
  IDocuments = interface(ILoadableList)
    ['{7CE6B5BB-CBB6-4E35-9A29-0BE6DE8FC655}']
    /// <summary>
    /// Функция получения ссылки на документ с указанным идентификатором
    /// </summary>
    /// <param name="AId">
    /// Идентификатор
    /// </param>
    /// <returns>
    /// Компания
    /// </returns>
    function GetItemById(const AId: Integer): IDocument;

    function GetItem(const AIndex: Integer): IDocument;

    /// <summary>
    /// Массив документов
    /// </summary>
    /// <param name="AIndex">
    /// Порядковый номер элемента в массиве
    /// </param>
    property Items[const AIndex: Integer]: IDocument read GetItem; default;


    ///	<summary>
    ///	  Функция добавления документа в короб
    ///	</summary>
    function Add(const AValue: IDocument): Integer;

    /// <summary>
    /// Процедура удаления последнего документа из короба
    /// </summary>
    procedure DeleteLast;
  end;

implementation

end.
