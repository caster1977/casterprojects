unit uIArchiveBoxTypeList;

interface

uses
  uILoadableList,
  uIArchiveBoxTypeItem;

type
  IArchiveBoxTypeList = interface(ILoadableList)
    ['{3B0BED3A-C586-4ECD-A6AD-FEE5BB554248}']
    /// <summary>
    /// Функция получения ссылки на тип архивного короба с указанным идентификатором
    /// </summary>
    /// <param name="AId">
    /// Идентификатор
    /// </param>
    /// <returns>
    /// Тип короба
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveBoxTypeItem;
    // function GetItem(const AIndex: Integer): IArchiveBoxTypeItem;
    // /// <summary>
    // /// Массив типов архивных коробов
    // /// </summary>
    // /// <param name="AIndex">
    // /// Порядковый номер элемента в массиве
    // /// </param>
    // property Items[const AIndex: Integer]: IArchiveBoxTypeItem read GetItem; default;
  end;

implementation

end.
