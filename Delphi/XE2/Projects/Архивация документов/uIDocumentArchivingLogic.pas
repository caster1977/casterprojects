unit uIDocumentArchivingLogic;

interface

uses
  uICustomBusinessLogic,
  uIDocument,
  uIArchiveBox;

type
  IDocumentArchivingLogic = interface(ICustomBusinessLogic)
    ['{B4D4317B-5679-4A31-9F53-F31CFFD99A6F}']
    function GetCurrentBox: IArchiveBox;
    /// <summary>
    /// Текущий архивный короб
    /// </summary>
    property CurrentBox: IArchiveBox read GetCurrentBox;
    /// <summary>
    /// Функция определения вместимости указанного типа короба
    /// указанного типа
    /// </summary>
    /// <param name="AType">
    /// Тип короба
    /// </param>
    /// <returns>
    /// Количество документов в данном типе короба
    /// </returns>
    function GetBoxCapacity(const AType: Integer): Integer; overload;
    /// <summary>
    /// Функция определения вместимости указанного типа короба
    /// указанного типа
    /// </summary>
    /// <param name="ABox">
    /// Короб
    /// </param>
    /// <returns>
    /// Количество документов в данном типе короба
    /// </returns>
    function GetBoxCapacity(const ABox: IArchiveBox): Integer; overload;
    /// <summary>
    /// Процедура добавления документа в короб (с проверкой)
    /// </summary>
    /// <param name="ADocument">
    /// Документ
    /// </param>
    procedure TryAddDocument(const ADocument: IDocument);
  end;

implementation

end.
