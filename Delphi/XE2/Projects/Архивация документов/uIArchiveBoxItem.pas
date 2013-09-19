unit uIArchiveBoxItem;

interface

uses
  uILoadableItem,
  uIArchiveDocumentList;

type
  /// <summary>
  /// ��������� ������� � �������� ���� "�������� �����"
  /// </summary>
  IArchiveBoxItem = interface(ILoadableItem)
    ['{59858136-1220-46A2-B333-760F1A964A37}']
    function GetCreationDate: TDateTime;
    procedure SetCreationDate(const AValue: TDateTime);

    /// <summary>
    /// ���� � ����� �������� ������
    /// </summary>
    property CreationDate: TDateTime read GetCreationDate write SetCreationDate;

    function GetBarcode: string;

    /// <summary>
    /// �����-��� ������
    /// </summary>
    property Barcode: string read GetBarcode;

    function GetClosed: Boolean;
    procedure SetClosed(const AValue: Boolean);

    /// <summary>
    /// ������ �� �����
    /// </summary>
    property Closed: Boolean read GetClosed write SetClosed;

    function GetClosureDate: TDateTime;
    procedure SetClosureDate(const AValue: TDateTime);

    /// <summary>
    /// ���� � ����� �������� ������
    /// </summary>
    property ClosureDate: TDateTime read GetClosureDate write SetClosureDate;

    function GetCompanyId: Integer;
    procedure SetCompanyId(const AValue: Integer);

    /// <summary>
    /// ������������� �������� ������
    /// </summary>
    property CompanyId: Integer read GetCompanyId write SetCompanyId;

    function GetCompanyName: string;
    procedure SetCompanyName(const AValue: string);

    /// <summary>
    /// ������������ �������� ������
    /// </summary>
    property CompanyName: string read GetCompanyName write SetCompanyName;

    function GetNumber: Integer;
    procedure SetNumber(const AValue: Integer);

    /// <summary>
    /// ���������� ����� ������ � ����
    /// </summary>
    property Number: Integer read GetNumber write SetNumber;

    function GetRegistryPrinted: Boolean;
    procedure SetRegistryPrinted(const AValue: Boolean);

    /// <summary>
    /// ��� �� ���������� ������ ������
    /// </summary>
    property RegistryPrinted: Boolean read GetRegistryPrinted write SetRegistryPrinted;

    function GetStickerPrinted: Boolean;
    procedure SetStickerPrinted(const AValue: Boolean);

    /// <summary>
    /// ��� �� ���������� ������ ������
    /// </summary>
    property StickerPrinted: Boolean read GetStickerPrinted write SetStickerPrinted;

    function GetTypeId: Integer;
    procedure SetTypeId(const AValue: Integer);

    /// <summary>
    /// ������������� ���� ������
    /// </summary>
    property TypeId: Integer read GetTypeId write SetTypeId;

    function GetTypeName: string;
    procedure SetTypeName(const AValue: string);

    /// <summary>
    /// ������������� ���� ������
    /// </summary>
    property TypeName: string read GetTypeName write SetTypeName;

    function GetYear: Integer;
    procedure SetYear(const AValue: Integer);

    /// <summary>
    /// ��� ������
    /// </summary>
    property Year: Integer read GetYear write SetYear;

    function GetUserId: Integer;
    procedure SetUserId(const AValue: Integer);

    /// <summary>
    /// ������������� ������������, ����������� � �������
    /// </summary>
    property UserId: Integer read GetUserId write SetUserId;

    function GetDocuments: IArchiveDocumentList;

    /// <summary>
    /// ������ ���������� � ������
    /// </summary>
    property Documents: IArchiveDocumentList read GetDocuments;
  end;

implementation

end.
