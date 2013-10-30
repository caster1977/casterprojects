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
    /// <summary>
    /// �������, ������������ ���������� ���������� � ������� ������
    /// </summary>
    /// <returns>
    /// ���������� ���������� � ������� ������
    /// </returns>
    function GetCurrentBoxDocumentCount: Integer;

    /// <summary>
    /// ��������� ��������� �������� �������� ��� ������ ���������� �
    /// ������� ������
    /// </summary>
    /// <param name="AValue">
    /// ������� �������
    /// </param>
    procedure SetCurrentBoxInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// ��������� ��������� �������� �������� ��� ������ ���������� �
    /// ��������� ��������� � ������� ������
    /// </summary>
    /// <param name="AValue">
    /// ������� �������
    /// </param>
    procedure SetLastDocumentInfoControl(const AValue: TCustomControl);

    /// <summary>
    /// ��������� �������� ���������� ��������� �� �������� ������
    /// </summary>
    procedure ManualDeleteLastDocumentFromCurrentBox;

    /// <summary>
    /// ��������� ������ ������� ��� �������� ��������� ������ � ������ ������
    /// </summary>
    procedure ManualPrintCurrentBoxSticker;

    /// <summary>
    /// ������� ��������� �������� ������
    /// </summary>
    /// <param name="AString">
    /// �����-��� ��� ������ ��������� ������
    /// </param>
    procedure ProcessString(const AString: string);
  end;

implementation

end.
