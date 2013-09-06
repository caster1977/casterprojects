unit uILoadableList;

interface

uses
  uICustomList,
  DB;

type
  ILoadableList = interface(ICustomList)
  ['{6592595D-9B17-4BCD-9167-BC94B31A5687}']
      /// <summary>
    /// Процедура загрузки элементов списка из базы данных
    /// </summary>
    /// <param name="AConnection">
    /// Объект подключения к базе данных
    /// </param>
    procedure Load(const AConnection: TCustomConnection);
  end;

implementation

end.
