unit uIDocumentArchivingBusinessLogic;

interface

uses
  Controls,
  uICustomBusinessLogic,
  uIArchiveBoxItem,
  uIShowable,
  uIArchiveDocumentItem,
  uICustomBSOItem,
  uTDocumentArchivingBarcodeType,
  uIArchiveDocumentList;

type
  /// <summary>
  /// ��������� ������� � ������� ������-������ �������� ��������� ����������
  /// </summary>
  IDocumentArchivingBusinessLogic = interface(ICustomBusinessLogic)
    ['{B4D4317B-5679-4A31-9F53-F31CFFD99A6F}']
    function GetCurrentBox: IArchiveBoxItem;
    procedure SetCurrentBox(const AValue: IArchiveBoxItem);

    /// <summary>
    /// ������� �������� �����
    /// </summary>
    property CurrentBox: IArchiveBoxItem read GetCurrentBox write SetCurrentBox;

    function GetCurrentBoxInfoControl: TCustomControl;
    procedure SetCurrentBoxInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// �������, � ������� ����� ��������� ���������� � ������� ������
    /// </summary>
    property CurrentBoxInfoControl: TCustomControl read GetCurrentBoxInfoControl write SetCurrentBoxInfoControl;

    function GetLastDocumentInfoControl: TCustomControl;
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// �������, � ������� ����� ��������� ���������� � ��������� ���������
    /// </summary>
    property LastDocumentInfoControl: TCustomControl read GetLastDocumentInfoControl write SetLastDocumentInfoControl;

    function GetCurrentUserId: Integer;
    /// <summary>
    /// ������������� �������� ������������
    /// </summary>
    property CurrentUserId: Integer read GetCurrentUserId;

    function GetArchiveBoxTypeId: Integer;
    /// <summary>
    /// ������������� ���� ��������� ������
    /// </summary>
    property ArchiveBoxTypeId: Integer read GetArchiveBoxTypeId;

    /// <summary>
    /// ���������, ����������� ����� � ������� ������ � ������� ������
    /// </summary>
    /// <param name="AControl">
    /// ������������ �������, � ������� ����� �������� ������
    /// </param>
    procedure ShowCurrentBoxInfo;

    /// <summary>
    /// ���������, ����������� ����� � ������� ������ � ��������� ���������
    /// </summary>
    /// <param name="AControl">
    /// ������������ �������, � ������� ����� �������� ������
    /// </param>
    procedure ShowLastDocumentInfo;

    /// <summary>
    /// ������� ������ ������� ��� �������� ��������� ������
    /// </summary>
    function PrintCurrentBoxSticker: Boolean;

    /// <summary>
    /// ������� "������������" �������� ������
    /// </summary>
    function PutCurrentBoxAside: Boolean;

    /// <summary>
    /// ������� �������� �������� ������
    /// </summary>
    function CloseCurrentBox: Boolean;

    /// <summary>
    /// ������� �������� �������� ������
    /// </summary>
    function DeleteCurrentBox: Boolean;

    /// <summary>
    /// ������� �������� ���������� ��������� �� �������� ������
    /// </summary>
    function DeleteLastDocument: Boolean;

    /// <summary>
    /// ������� ����������� "�������������" �������� ������
    /// </summary>
    function ArchiveBoxIsFull: Boolean;

    /// <summary>
    /// ������� ���������� ��������� � ������� ������ � ��
    /// </summary>
    /// <param name="ABSO">
    /// ���
    /// </param>
    procedure AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem);

    /// <summary>
    /// ������� ��������� ��������� �����-����
    /// </summary>
    /// <param name="ABarcode">
    /// �����-���
    /// </param>
    procedure ProcessBarcode(const ABarcode: string);
  end;

implementation

end.
