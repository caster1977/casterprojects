unit uILoadableItem;

interface

uses
  DB;

type
  /// <summary>
  /// Интерфейс для доступа к объектам, умеющим загружаться из БД и
  /// записываться в БД
  /// </summary>
  ILoadableItem = interface
    ['{F5F51C86-2B21-4FA4-A7FD-570F609DBC00}']
    function GetId: Integer;

    /// <summary>
    /// Идентификатор записи
    /// </summary>
    property Id: Integer read GetId;
    /// <summary>
    /// Процедура загрузки данных из готового датасета для заполнения полей объекта
    /// </summary>
    procedure Load(const ADataSet: TDataSet); overload;

    /// <summary>
    /// Процедура загрузки данных из соединения для заполнения полей объекта
    /// </summary>
    procedure Load(const AConnection: TCustomConnection = nil); overload;

    /// <summary>
    /// Функция записи данных полей объекта в БД
    /// </summary>
    /// <param name="AConnection">
    /// Объект подключения к БД
    /// </param>
    /// <returns>
    /// Удалось ли выполнить запись в БД
    /// </returns>
    /// <remarks>
    /// Работает только для объектов, у которых свойство <b>Saveable</b>
    /// установлено в <b>True</b>
    /// </remarks>
    function Save(const AConnection: TCustomConnection = nil): Boolean;

    ///	<summary>
    ///	  Функция удаления данных об объекте из БД
    ///	</summary>
    ///	<param name="AConnection">
    ///	  Объект подключения к БД
    ///	</param>
    ///	<returns>
    ///	  Удалось ли выполнить удаление из БД
    ///	</returns>
    function Delete(const AConnection: TCustomConnection = nil): Boolean;
  end;

implementation

end.
