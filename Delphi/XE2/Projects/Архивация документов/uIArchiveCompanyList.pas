unit uIArchiveCompanyList;

interface

uses
  uILoadableList,
  uIArchiveCompanyItem;

type
  /// <summary>
  /// Интерфейс для доступа к объктам списка архивных компаний
  /// </summary>
  IArchiveCompanyList = interface(ILoadableList)
    ['{4F99D11B-9566-4B7A-B728-B9FB97C6E9D8}']
    /// <summary>
    /// Функция получения ссылки на компанию с указанным идентификатором
    /// </summary>
    /// <param name="AId">
    /// Идентификатор
    /// </param>
    /// <returns>
    /// Компания
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveCompanyItem;
    function GetItem(const AIndex: Integer): IArchiveCompanyItem;
    /// <summary>
    /// Массив архивных компаний
    /// </summary>
    /// <param name="AIndex">
    /// Порядковый номер элемента в массиве
    /// </param>
    property Item[const AIndex: Integer]: IArchiveCompanyItem read GetItem; default;
  end;

implementation

end.
