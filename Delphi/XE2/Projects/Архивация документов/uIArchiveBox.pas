/// <summary>
/// ������, ���������� �������� ���������� <b>IArchiveBox</b>
/// </summary>
unit uIArchiveBox;

interface

uses
  uIDocument,
  uIDocumentBox,
  uILoadableList;

type
  IArchiveBox = interface(IDocumentBox)
    ['{C2984458-D3DF-4EB2-9D28-8756E9DD51F4}']
    function GetTypeId: Integer;
    procedure SetTypeId(const AValue: Integer);

    /// <summary>
    /// ������������� ���� ������
    /// </summary>
    property TypeId: Integer read GetTypeId write SetTypeId;

    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);

    /// <summary>
    /// �����-��� ������
    /// </summary>
    property Barcode: string read GetBarcode write SetBarcode;

    function GetYear: Integer;
    procedure SetYear(const AValue: Integer);

    /// <summary>
    /// ��� ������
    /// </summary>
    property Year: Integer read GetYear write SetYear;

    function GetNumber: Integer;
    procedure SetNumber(const AValue: Integer);

    /// <summary>
    /// ���������� ����� ������ � ����
    /// </summary>
    property Number: Integer read GetNumber write SetNumber;

    function GetCompanyId: Integer;
    procedure SetCompanyId(const AValue: Integer);

    /// <summary>
    /// ������������� �������� ������
    /// </summary>
    property CompanyId: Integer read GetCompanyId write SetCompanyId;

    function GetClosureDate: TDateTime;
    procedure SetClosureDate(const AValue: TDateTime);

    ///	<summary>
    ///	  ���� � ����� �������� ������
    ///	</summary>
    property ClosureDate: TDateTime read GetClosureDate write SetClosureDate;

    function GetClosed: Boolean;
    procedure SetClosed(const AValue: Boolean);

    ///	<summary>
    ///	  ������ �� �����
    ///	</summary>
    property Closed: Boolean read GetClosed write SetClosed;

    function GetRegistryPrinted: Boolean;
    procedure SetRegistryPrinted(const AValue: Boolean);

    ///	<summary>
    ///	  ��� �� ���������� ������ ������
    ///	</summary>
    property RegistryPrinted: Boolean read GetRegistryPrinted write SetRegistryPrinted;

    function GetStickerPrinted: Boolean;
    procedure SetStickerPrinted(const AValue: Boolean);

    ///	<summary>
    ///	  ��� �� ���������� ������ ������
    ///	</summary>
    property StickerPrinted: Boolean read GetStickerPrinted write SetStickerPrinted;

  end;

implementation

end.
