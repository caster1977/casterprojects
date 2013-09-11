unit uICauseOfDamageList;

interface

uses
  uILoadableList,
  uICauseOfDamageItem;

type
  /// <summary>
  /// Интерфейс для доступа к объктам списка причин "порчи" документов
  /// </summary>
  ICauseOfDamageList = interface(ILoadableList)
    ['{F5C40A5E-ADC5-47A6-9C5B-89A5F4D98DCA}']

    ///	<summary>
    ///	  Функция получения ссылки на причину "порчи" документа с указанным
    ///	  идентификатором
    ///	</summary>
    ///	<param name="AId">
    ///	  Идентификатор
    ///	</param>
    ///	<returns>
    ///	  Причина "порчи"
    ///	</returns>
    function GetItemById(const AId: Integer): ICauseOfDamageItem;
    function GetItem(const AIndex: Integer): ICauseOfDamageItem;

    ///	<summary>
    ///	  Массив причин "порчи" документов
    ///	</summary>
    ///	<param name="AIndex">
    ///	  Порядковый номер элемента в массиве
    ///	</param>
    property Item[const AIndex: Integer]: ICauseOfDamageItem read GetItem; default;
  end;

implementation

end.
