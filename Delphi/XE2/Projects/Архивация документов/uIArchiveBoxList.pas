unit uIArchiveBoxList;

interface

uses
  uILoadableList,
  uIArchiveBoxItem;

type
  IArchiveBoxList = interface(ILoadableList)
    ['{06A29FB9-B336-460E-B887-6420598B2CAF}']
    /// <summary>
    /// Функция получения ссылки на архивный короб с указанным идентификатором
    /// </summary>
    /// <param name="AId">
    /// Идентификатор
    /// </param>
    /// <returns>
    /// Короб
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveBoxItem;
    function GetItem(const AIndex: Integer): IArchiveBoxItem;
    /// <summary>
    /// Массив архивных коробов
    /// </summary>
    /// <param name="AIndex">
    /// Порядковый номер элемента в массиве
    /// </param>
    property Items[const AIndex: Integer]: IArchiveBoxItem read GetItem; default;
  end;

implementation

end.
