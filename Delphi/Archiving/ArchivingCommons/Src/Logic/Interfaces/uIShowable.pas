unit uIShowable;

interface

uses
  Classes;

type
  /// <summary>
  /// Интерфейс доступа к объектам, имеющим отображаемые поля
  /// </summary>
  /// <remarks>
  /// Используется для обеспечения работы функционала по отрисовке указанных
  /// полей объекта при помощи метода <b>Show</b> бизнес-объекта
  /// </remarks>
  IShowable = interface
    ['{539C995D-3987-47CA-95A6-6482AC7A2887}']
    function GetShowableFields: IInterfaceList;

    /// <summary>
    /// Список отображаемых полей
    /// </summary>
    property ShowableFields: IInterfaceList read GetShowableFields;

    /// <summary>
    /// Процедура добавления поля в список отображаемых полей
    /// </summary>
    /// <param name="ACaption">
    /// Текст заголовка поля
    /// </param>
    /// <param name="AName">
    /// Наименование поля
    /// </param>
    /// <param name="AValue">
    /// Значение поля в виде строки
    /// </param>
    procedure AddShowableField(const ACaption, AName, AValue: string);

    /// <summary>
    /// Процедура, заполняющая список  отображаемых полей класса
    /// </summary>
    procedure FillShowableFieldsList;
  end;

implementation

end.
