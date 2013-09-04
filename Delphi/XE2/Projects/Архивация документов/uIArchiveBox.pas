/// <summary>
/// ������, ���������� �������� ���������� <b>IArchiveBox</b>
/// </summary>
unit uIArchiveBox;

interface

uses
  uICustomDocument;

type
  /// <summary>
  /// ��������� "<b>�������� �����</b>"
  /// </summary>
  IArchiveBox = interface
    ['{C2984458-D3DF-4EB2-9D28-8756E9DD51F4}']
    function GetId: Integer;
    procedure SetId(const AValue: Integer);

    /// <summary>
    /// ������������� ��������� ������
    /// </summary>
    property Id: Integer read GetId write SetId;

    function GetName: string;
    procedure SetName(const AValue: string);

    /// <summary>
    /// ������������ (���) ������
    /// </summary>
    property name: string read GetName write SetName;

    function GetTypeId: Integer;
    procedure SetTypeId(const AValue: Integer);

    /// <summary>
    /// ������������� ���� ������
    /// </summary>
    property TypeId: Integer read GetTypeId write SetTypeId;

    function GetTypeName: string;
    procedure SetTypeName(const AValue: string);

    /// <summary>
    /// ������������ ���� ������
    /// </summary>
    property TypeName: string read GetTypeName write SetTypeName;

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

    function GetNumber: string;
    procedure SetNumber(const AValue: string);

    /// <summary>
    /// ���������� ����� ������ � ����
    /// </summary>
    property Number: string read GetNumber write SetNumber;

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

    /// <summary>
    /// ������� ���������� ��������� � �����
    /// </summary>
    function AddDocument(const AValue: ICustomDocument): Integer;

    /// <summary>
    /// ��������� �������� ���������� ��������� �� ������
    /// </summary>
    procedure DeleteLastDocument;

    function GetDocument(const AIndex: Integer): ICustomDocument;
    property Documents[const AIndex: Integer]: ICustomDocument read GetDocument; default;

    function GetDocumentCount: Integer;
    property DocumentCount: Integer read GetDocumentCount;
  end;

implementation

end.
