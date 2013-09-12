unit uIArchiveDocumentItem;

interface

uses
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

    function GetShowableFields: IInterfaceList;

    /// <summary>
    /// ������ ����� ��������� ���������, ������� ���������� ���������� ���
    /// ������ ��� ������ ������ ������ <b>Show</b> ������-�������
    /// </summary>
    property ShowableFields: IInterfaceList read GetShowableFields;
  end;

implementation

end.
