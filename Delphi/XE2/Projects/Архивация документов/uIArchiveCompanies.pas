unit uIArchiveCompanies;

interface

uses
  uILoadableList,
  uIArchiveCompany;

type
  IArchiveCompanies = interface(ILoadableList)
    ['{4F99D11B-9566-4B7A-B728-B9FB97C6E9D8}']
    ///	<summary>
    ///	  Функция получения ссылки на компанию с указанным идентификатором
    ///	</summary>
    ///	<param name="AId">
    ///	  Идентификатор
    ///	</param>
    ///	<returns>
    ///	  Компания
    ///	</returns>
    function GetItemById(const AId: Integer): IArchiveCompany;

    function GetItem(const AIndex: Integer): IArchiveCompany;

    ///	<summary>
    ///	  Массив архивных компаний
    ///	</summary>
    ///	<param name="AIndex">
    ///	  Порядковый номер элемента в массиве
    ///	</param>
    property Items[const AIndex: Integer]: IArchiveCompany read GetItem; default;
  end;

implementation

end.
