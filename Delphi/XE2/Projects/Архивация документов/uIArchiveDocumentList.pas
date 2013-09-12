unit uIArchiveDocumentList;

interface

uses
  uILoadableList,
  uIArchiveDocumentItem;

type
  /// <summary>
  /// ��������� ��� ������� � ������� ������ �������� ����������
  /// </summary>
  IArchiveDocumentList = interface(ILoadableList)
    ['{7CE6B5BB-CBB6-4E35-9A29-0BE6DE8FC655}']
    /// <summary>
    /// ������� ��������� ������ �� �������� � ��������� ���������������
    /// </summary>
    /// <param name="AId">
    /// �������������
    /// </param>
    /// <returns>
    /// ��������
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveDocumentItem;

    function GetItem(const AIndex: Integer): IArchiveDocumentItem;

    /// <summary>
    /// ������ ����������
    /// </summary>
    /// <param name="AIndex">
    /// ���������� ����� �������� � �������
    /// </param>
    property Item[const AIndex: Integer]: IArchiveDocumentItem read GetItem; default;
  end;

implementation

end.
