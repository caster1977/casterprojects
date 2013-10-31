unit uILoadableList;

interface

uses
  uILoadableItem,
  DB;

type
  /// <summary>
  /// Интерфейс для доступа к объектам списка объектов, умеющих загружаться и записываться в БД
  /// </summary>
  ILoadableList = interface
    ['{6592595D-9B17-4BCD-9167-BC94B31A5687}']
    function GetCount: Integer;

    /// <summary>
    /// Количество элементов в списке
    /// </summary>
    property Count: Integer read GetCount;

    /// <summary>
    /// Функция получения порядкового номера указанного элемента списка
    /// </summary>
    function IndexOf(const AItem: ILoadableItem): Integer;

    /// <summary>
    /// Процедура загрузки элементов списка из базы данных
    /// </summary>
    /// <param name="AConnection">
    /// Объект подключения к базе данных
    /// </param>
    procedure Load(const AConnection: TCustomConnection = nil);

    /// <summary>
    /// Функция для создания нового элемента списка
    /// </summary>
    function Add: Integer; overload;

    /// <summary>
    /// Функция для добавления указанного элемента в список
    /// </summary>
    function Add(const AItem: ILoadableItem): Integer; overload;

    /// <summary>
    /// Процедура записи значений полей элементов списка в базу данных
    /// </summary>
    /// <param name="AConnection">
    /// Объект подключения к базе данных
    /// </param>
    /// <returns>
    /// Удалось ли выполнить запись в БД
    /// </returns>
    /// <remarks>
    /// Работает только для списка объектов, у которых свойство
    /// <b>Saveable</b> установлено в <b>True</b>
    /// </remarks>
    function Save(const AConnection: TCustomConnection = nil): Boolean;

    /// <summary>
    /// Процедура удаления указанного элемента списка
    /// </summary>
    /// <param name="AIndex">
    /// Индекс элемента списка
    /// </param>
    /// <param name="AConnection">
    /// Объект подключения к БД
    /// </param>
    /// <returns>
    /// Удалось ли удалить элемент списка
    /// </returns>
    function Delete(const AIndex: Integer; const AConnection: TCustomConnection = nil): Boolean;

    /// <summary>
    /// Функция очистки списка
    /// </summary>
    /// <param name="AConnection">
    /// Объект подключения к БД
    /// </param>
    /// <returns>
    /// Удалось ли выполнить очистку списка
    /// </returns>
    function Clear(const AConnection: TCustomConnection = nil): Boolean;

    /// <summary>
    /// Процедура копирования объектов исходного списка в текущий список
    /// текущего объекта
    /// </summary>
    /// <param name="AValue">
    /// Исходный список
    /// </param>
    /// <remarks>
    /// Создаётся дубликат объектов исходного списка
    /// </remarks>
    procedure Assign(const AValue: ILoadableList);

    function GetItem(const AIndex: Integer): ILoadableItem;
    procedure PutItem(const AIndex: Integer; const AItem: ILoadableItem);

    /// <summary>
    /// Свойство доступа к массиву элементов списка
    /// </summary>
    /// <param name="AIndex">
    /// Индекс элемента в списке
    /// </param>
    property Item[const AIndex: Integer]: ILoadableItem read GetItem write PutItem; default;
  end;

implementation

end.
