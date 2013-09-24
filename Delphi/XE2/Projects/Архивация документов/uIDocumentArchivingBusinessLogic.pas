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

    /// <summary>
    /// ������� ������ ������� ��� �������� ��������� ������ � ������ ������
    /// </summary>
    function ManualPrintCurrentBoxSticker: Boolean;

    /// <summary>
    /// ������� "������������" �������� ������
    /// </summary>
    function PutCurrentBoxAside: Boolean;

    /// <summary>
    /// ������� �������� ���������� ��������� �� �������� ������
    /// </summary>
    function DeleteLastDocumentInCurrentBox: Boolean;

    /// <summary>
    /// ������� ��������� �������� ������
    /// </summary>
    /// <param name="AString">
    /// �����-��� ��� ������ ��������� ������
    /// </param>
    procedure ProcessString(const AString: string);

    /// <summary>
    /// ������� ���������� ��������� � ������� ������ � ��
    /// </summary>
    /// <param name="ABSO">
    /// ���
    /// </param>
    procedure AcceptBSOByAcceptanceRegister(const ABSO: ICustomBSOItem);
  end;

implementation

end.
