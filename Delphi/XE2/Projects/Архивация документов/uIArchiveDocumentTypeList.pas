unit uIArchiveDocumentTypeList;

interface

uses
  uILoadableList,
  uIArchiveDocumentTypeItem;

type
  IArchiveDocumentTypeList = interface(ILoadableList)
    ['{193075BB-88E2-43AB-83D2-BB16475B253F}']
    /// <summary>
    /// ������� ��������� ������ �� ��� ��������� ��������� � ��������� ���������������
    /// </summary>
    /// <param name="AId">
    /// �������������
    /// </param>
    /// <returns>
    /// ��� ���������
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveDocumentTypeItem;
    function GetItem(const AIndex: Integer): IArchiveDocumentTypeItem;
    /// <summary>
    /// ������ ����� �������� ����������
    /// </summary>
    /// <param name="AIndex">
    /// ���������� ����� �������� � �������
    /// </param>
    property Items[const AIndex: Integer]: IArchiveDocumentTypeItem read GetItem; default;
  end;

implementation

end.
