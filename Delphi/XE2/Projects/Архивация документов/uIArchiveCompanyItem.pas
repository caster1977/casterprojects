unit uIArchiveCompanyItem;

interface

uses
  DB,
  uILoadableItem;

type
  /// <summary>
  /// Интерфейс для доступа к объктам архивных компаний
  /// </summary>
  IArchiveCompanyItem = interface(ILoadableItem)
    ['{07B55416-6B9A-4F7F-82D7-59C773D296A8}']
    function GetId: Integer;

    /// <summary>
    /// Идентификатор компании
    /// </summary>
    property Id: Integer read GetId;

    function GetName: string;

    /// <summary>
    /// Наименование компании
    /// </summary>
    property Name: string read GetName;
    function GetCode: string;

    /// <summary>
    /// Код компании
    /// </summary>
    property Code: string read GetCode;
  end;

implementation

end.
