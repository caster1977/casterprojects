unit uIArchiveDocumentItem;

interface

uses
  Classes,
  Controls,
  uILoadableItem;

type
  /// <summary>
  /// Интерфейс для доступа к объекту архивного документа
  /// </summary>
  IArchiveDocumentItem = interface(ILoadableItem)
    ['{90EEBE6E-BE2C-41DC-B186-079F95C9B558}']
    function GetArchiveBoxId: Integer;
    procedure SetArchiveBoxId(const AValue: Integer);

    /// <summary>
    /// Идентификатор архивного короба
    /// </summary>
    property ArchiveBoxId: Integer read GetArchiveBoxId write SetArchiveBoxId;

    function GetArchivedByUser: Integer;
    procedure SetArchivedByUser(const AValue: Integer);

    /// <summary>
    /// Идентификатор пользователя, заархивировавшего документ
    /// </summary>
    property ArchivedByUser: Integer read GetArchivedByUser write SetArchivedByUser;

    function GetArchivingDate: TDateTime;
    procedure SetArchivingDate(const AValue: TDateTime);

    /// <summary>
    /// Дата архивации документа
    /// </summary>
    property ArchivingDate: TDateTime read GetArchivingDate write SetArchivingDate;

    function GetIssued: Boolean;
    procedure SetIssued(const AValue: Boolean);

    /// <summary>
    /// Был ли выдан бланк
    /// </summary>
    property Issued: Boolean read GetIssued write SetIssued;

    function GetIssuedToUser: Integer;
    procedure SetIssuedToUser(const AValue: Integer);

    /// <summary>
    /// Идентификатор пользователя, которому был выдан документ
    /// </summary>
    property IssuedToUser: Integer read GetIssuedToUser write SetIssuedToUser;

    function GetIssuanceDate: TDateTime;
    procedure SetIssuanceDate(const AValue: TDateTime);

    /// <summary>
    /// Дата выдачи документа из архива
    /// </summary>
    property IssuanceDate: TDateTime read GetIssuanceDate write SetIssuanceDate;

    function GetShowableFields: IInterfaceList;

    /// <summary>
    /// Список полей архивного документа, которые необходимо отображать при
    /// выводе при помощи вызова метода <b>Show</b> бизнес-объекта
    /// </summary>
    property ShowableFields: IInterfaceList read GetShowableFields;
  end;

implementation

end.
