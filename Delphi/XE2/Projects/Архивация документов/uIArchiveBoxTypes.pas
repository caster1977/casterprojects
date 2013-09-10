unit uIArchiveBoxTypes;

interface

uses
  uILoadableList,
  uIArchiveBoxType;

type
  IArchiveBoxTypes = interface(ILoadableList)
    ['{3B0BED3A-C586-4ECD-A6AD-FEE5BB554248}']
    ///	<summary>
    ///	  Функция получения ссылки на тип архивного короба с указанным идентификатором
    ///	</summary>
    ///	<param name="AId">
    ///	  Идентификатор
    ///	</param>
    ///	<returns>
    ///	  Компания
    ///	</returns>
    function GetItemById(const AId: Integer): IArchiveBoxType;

    function GetItem(const AIndex: Integer): IArchiveBoxType;

    ///	<summary>
    ///	  Массив типов архивных коробов
    ///	</summary>
    ///	<param name="AIndex">
    ///	  Порядковый номер элемента в массиве
    ///	</param>
    property Items[const AIndex: Integer]: IArchiveBoxType read GetItem; default;
  end;

implementation

end.
