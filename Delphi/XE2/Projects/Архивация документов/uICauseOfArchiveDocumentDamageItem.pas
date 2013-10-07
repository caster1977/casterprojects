unit uICauseOfArchiveDocumentDamageItem;

interface

uses
  uILoadableItem;

type
  /// <summary>
  /// Интерфейс для доступа к объктам причины "порчи" документов
  /// </summary>
  ICauseOfDamageItem = interface(ILoadableItem)
    ['{56F10AB4-0102-4528-84F4-17F4E7872194}']
    function GetName: string;

    /// <summary>
    /// Наименование причины "порчи" документа
    /// </summary>
    property name: string read GetName;

    function GetBarcode: string;

    /// <summary>
    /// Штрих-код причины "порчи" документа
    /// </summary>
    property Barcode: string read GetBarcode;
  end;

implementation

end.
