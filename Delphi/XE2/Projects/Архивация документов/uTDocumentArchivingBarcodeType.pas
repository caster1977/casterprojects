unit uTDocumentArchivingBarcodeType;

interface

type
  /// <summary>
  /// ���� �����-�����, ������������ ��� ��������� ����������
  /// </summary>
  TDocumentArchivingBarcodeType = (
    /// <summary>
    /// ����������� ���
    /// </summary>
    dabtUnknown,

    /// <summary>
    /// �����-��� ���
    /// </summary>
    dabtBSO,

    /// <summary>
    /// �����-��� ��������� ������
    /// </summary>
    dabtArchiveBox,

    /// <summary>
    /// �����-��� ������� �������� ������ ������
    /// </summary>
    dabtForceNewBoxCommand,

    /// <summary>
    /// �����-��� ������� ������������ �������� ������
    /// </summary>
    dabtPutBoxAsideCommand);

implementation

end.
