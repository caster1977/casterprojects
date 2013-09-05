unit uIArchiveCompanies;

interface

uses
  DB,
  uIArchiveCompany;

type
  IArchiveCompanies = interface
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
    function GetArchiveCompanyById(const AId: Integer): IArchiveCompany;

    ///	<summary>
    ///	  Процедура загрузки списка из базы данных
    ///	</summary>
    ///	<param name="AConnection">
    ///	  Объект подключения к базе данных
    ///	</param>
    procedure Load(const AConnection: TCustomConnection); overload;

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
