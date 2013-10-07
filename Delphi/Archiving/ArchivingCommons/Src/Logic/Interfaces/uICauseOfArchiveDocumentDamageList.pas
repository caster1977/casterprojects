unit uICauseOfArchiveDocumentDamageList;

interface

uses
  uILoadableList,
  uICauseOfArchiveDocumentDamageItem;

type
  /// <summary>
  /// ��������� ��� ������� � ������� ������ ������ "�����" ����������
  /// </summary>
  ICauseOfArchiveDocumentDamageList = interface(ILoadableList)
    ['{F5C40A5E-ADC5-47A6-9C5B-89A5F4D98DCA}']

    /// <summary>
    /// ������� ��������� ������ ��������� "�����" ���������� ���������
    /// ���������������
    /// </summary>
    /// <param name="AId">
    /// �������������
    /// </param>
    /// <returns>
    /// ������� "�����"
    /// </returns>
    function GetItemById(const AId: Integer): ICauseOfArchiveDocumentDamageItem;
    function GetItem(const AIndex: Integer): ICauseOfArchiveDocumentDamageItem;

    /// <summary>
    /// ������ ������ "�����" ����������
    /// </summary>
    /// <param name="AIndex">
    /// ���������� ����� �������� � �������
    /// </param>
    property Item[const AIndex: Integer]: ICauseOfArchiveDocumentDamageItem read GetItem; default;
  end;

implementation

end.
