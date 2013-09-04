unit uICustomDocument;

interface

uses
  Controls,
  DB,
  SqlExpr,
  ADODB;

type
  ICustomDocument = interface
    ['{90EEBE6E-BE2C-41DC-B186-079F95C9B558}']

    /// <summary>
    /// Процедура загрузки данных для заполнения полей объекта
    /// </summary>
    procedure Load(const AADOConnection: TADOConnection); overload;

    /// <summary>
    /// Процедура загрузки данных для заполнения полей объекта
    /// </summary>
    procedure Load(const ASQLConnection: TSQLConnection); overload;

    /// <summary>
    /// Процедура отображения данных объекта
    /// </summary>
    procedure Show(const AParentControl: TCustomControl = nil);
  end;

implementation

end.
