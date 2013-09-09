unit uIDocumentBox;

interface

uses
  uIDocument,
  uIDocuments,
  uILoadableItem;

type
  IDocumentBox = interface(ILoadableItem)
    ['{A740729A-0BFE-4A7D-87FC-712AFA02A4D4}']
    function GetId: Integer;
    procedure SetId(const AValue: Integer);

    /// <summary>
    /// Идентификатор архивного короба
    /// </summary>
    property Id: Integer read GetId write SetId;

    function GetDocuments: IDocuments;

    /// <summary>
    /// Список архивных компаний
    /// </summary>
    property Documents: IDocuments read GetDocuments;
  end;

implementation

end.
