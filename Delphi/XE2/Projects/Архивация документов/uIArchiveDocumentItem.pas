unit uIArchiveDocumentItem;

interface

uses
  DB,
  Classes,
  Controls,
  uILoadableItem;

type
  /// <summary>
  /// ��������� ��� ������� � ������� ��������� ���������
  /// </summary>
  IArchiveDocumentItem = interface(ILoadableItem)
    ['{90EEBE6E-BE2C-41DC-B186-079F95C9B558}']
    function GetArchiveBoxId: Integer;
    procedure SetArchiveBoxId(const AValue: Integer);

    /// <summary>
    /// ������������� ��������� ������
    /// </summary>
    property ArchiveBoxId: Integer read GetArchiveBoxId write SetArchiveBoxId;

    function GetArchivedByUser: Integer;
    procedure SetArchivedByUser(const AValue: Integer);

    /// <summary>
    /// ������������� ������������, ����������������� ��������
    /// </summary>
    property ArchivedByUser: Integer read GetArchivedByUser write SetArchivedByUser;

    function GetArchivingDate: TDateTime;
    procedure SetArchivingDate(const AValue: TDateTime);

    /// <summary>
    /// ���� ��������� ���������
    /// </summary>
    property ArchivingDate: TDateTime read GetArchivingDate write SetArchivingDate;

    function GetIssued: Boolean;
    procedure SetIssued(const AValue: Boolean);

    /// <summary>
    /// ��� �� ����� �����
    /// </summary>
    property Issued: Boolean read GetIssued write SetIssued;

    function GetIssuedToUser: Integer;
    procedure SetIssuedToUser(const AValue: Integer);

    /// <summary>
    /// ������������� ������������, �������� ��� ����� ��������
    /// </summary>
    property IssuedToUser: Integer read GetIssuedToUser write SetIssuedToUser;

    function GetIssuanceDate: TDateTime;
    procedure SetIssuanceDate(const AValue: TDateTime);

    /// <summary>
    /// ���� ������ ��������� �� ������
    /// </summary>
    property IssuanceDate: TDateTime read GetIssuanceDate write SetIssuanceDate;

    function GetCompanyId: Integer;
    procedure SetCompanyId(const AValue: Integer);

    /// <summary>
    /// ������������� ��������
    /// </summary>
    property CompanyId: Integer read GetCompanyId write SetCompanyId;

    function GetCompanyName: string;
    procedure SetCompanyName(const AValue: string);

    /// <summary>
    /// ������������ ��������
    /// </summary>
    property CompanyName: string read GetCompanyName write SetCompanyName;

    function GetBarcode: string;
    procedure SetBarcode(const AValue: string);

    /// <summary>
    /// �����-��� ���������
    /// </summary>
    property Barcode: string read GetBarcode write SetBarcode;

    /// <summary>
    /// ������� ������������� ����� ������� ����������, ������������� �
    /// �������� ������
    /// </summary>
    /// <param name="AValue">
    /// ������, ���������� �������� ��� ������������� ����� �������
    /// </param>
    /// <returns>
    /// ������� �� ��������� �������������
    /// </returns>
    /// <remarks>
    /// ���������� ���������������
    /// </remarks>
    function FromString(const AValue: string): Boolean;

    function GetSequenceNumber: Integer;
    procedure SetSequenceNumber(const AValue: Integer);

    /// <summary>
    /// ���������� ����� � �������� ������
    /// </summary>
    property SequenceNumber: Integer read GetSequenceNumber write SetSequenceNumber;

    /// <summary>
    /// ������� ��� ����������� ��������� ������, � ������� ������� ��������
    /// </summary>
    /// <param name="AConnection">
    /// ������ ����������� � ��
    /// </param>
    /// <returns>
    /// ������������� ������ � ������� ���������� ��������� ��������, ���� -1
    /// (���� �������� ��� �� ��� �������������)
    /// </returns>
    function AlreadyArchived(const AConnection: TCustomConnection = nil): Integer;
  end;

implementation

end.
