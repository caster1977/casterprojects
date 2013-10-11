unit uIArchivingBoxCapacityConfigBusinessLogic;

interface

uses
  uICustomBusinessLogic;

type
  /// <summary>
  /// Интерфейс доступа к объекту бизнес-логики процесса настройки объёма коробов
  /// </summary>
  IArchivingBoxCapacityConfigBusinessLogic = interface(ICustomBusinessLogic)
    ['{D8E92F43-14A8-446B-8802-BA4ED0B9EF8D}']
    /// <summary>
    /// Процедура включения доступа к функционалу архивации документов
    /// </summary>
    procedure EnableDocumentArchiving;
    /// <summary>
    /// Процедура отключения доступа к функционалу архивации документов
    /// </summary>
    procedure DisableDocumentArchiving;
    /// <summary>
    /// Процедура загрузки данных из БД в компонент
    /// </summary>
    procedure LoadData;

    ///	<summary>
    ///	  Функция записи данных из компонента в БД
    ///	</summary>
    ///	<returns>
    ///	  Удалось ли выполнить запись данных
    ///	</returns>
    function SaveData: Boolean;
    /// <summary>
    /// Функция, определяющая, были ли изменены данные с момента загрузки
    /// </summary>
    function DataWasChanged: Boolean;
  end;

implementation

end.
