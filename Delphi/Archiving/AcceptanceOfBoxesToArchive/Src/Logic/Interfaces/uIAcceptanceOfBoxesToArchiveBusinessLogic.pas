unit uIAcceptanceOfBoxesToArchiveBusinessLogic;

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
  /// ��������� ������� � ������� ������-������ �������� ������ ������� � �����
  /// </summary>
  IAcceptanceOfBoxesToArchiveBusinessLogic = interface(ICustomBusinessLogic)
    ['{561D3DE0-DBFC-4CD0-BA84-476145EB08C0}']
    /// <summary>
    /// ��������� ��������� �������� �������� ��� ������ ���������� �
    /// ��������� �������� � ����� ������
    /// </summary>
    /// <param name="AValue">
    /// ������� �������
    /// </param>
    procedure SetLastBoxInfoControl(const AValue: TCustomControl);

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
