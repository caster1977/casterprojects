unit uIDocumentArchivingBusinessLogic;

interface

uses
  Controls,
  uICustomBusinessLogic,
  uIArchiveBoxItem,
  uIShowable;

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
    property CurrentBoxInfoControl: TCustomControl read GetCurrentBoxInfoControl
      write SetCurrentBoxInfoControl;

    function GetLastDocumentInfoControl: TCustomControl;
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// �������, � ������� ����� ��������� ���������� � ��������� ���������
    /// </summary>
    property LastDocumentInfoControl: TCustomControl read GetLastDocumentInfoControl
      write SetLastDocumentInfoControl;

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
    /// ������� ����������� "�������������" �������� ������
    /// </summary>
    function CurrentBoxIsFull: Boolean;
  end;

implementation

end.
