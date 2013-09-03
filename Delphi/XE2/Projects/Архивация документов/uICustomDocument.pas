unit uICustomDocument;

interface

uses
  Controls,
  DB;

type
  ICustomDocument = interface
    ['{90EEBE6E-BE2C-41DC-B186-079F95C9B558}']

    /// <summary>
    /// Функция получения строки запроса SQL, выбирающего данные для
    /// заполнения полей объекта
    /// </summary>
    function GetSQLForLoad: string;

    /// <summary>
    /// Процедура загрузки данных для заполнения полей объекта из набора
    /// данных
    /// </summary>
    procedure Load(const ASource: TDataSet);

    /// <summary>
    /// Процедура отображения данных объекта
    /// </summary>
    procedure Show(const AParentControl: TCustomControl = nil);
  end;

implementation

end.
