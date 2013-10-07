unit uIArchiveDocumentTypeItem;

interface

uses
  DB,
  uILoadableItem;

type
  /// <summary>
  /// Интерфейс для доступа к объктам типов архивных документов
  /// </summary>
  IArchiveDocumentTypeItem = interface(ILoadableItem)
    ['{DE1FF771-63F1-402F-84B5-A960059808C3}']
    function GetName: string;

    /// <summary>
    /// Наименование типа архивного документа
    /// </summary>
    property Name: string read GetName;
  end;

implementation

end.
