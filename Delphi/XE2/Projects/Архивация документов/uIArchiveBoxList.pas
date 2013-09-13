unit uIArchiveBoxList;

interface

uses
  uILoadableList,
  uIArchiveBoxItem;

type
  IArchiveBoxList = interface(ILoadableList)
    ['{06A29FB9-B336-460E-B887-6420598B2CAF}']
    /// <summary>
    /// ������� ��������� ������ �� �������� ����� � ��������� ���������������
    /// </summary>
    /// <param name="AId">
    /// �������������
    /// </param>
    /// <returns>
    /// �����
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveBoxItem;
    function GetItem(const AIndex: Integer): IArchiveBoxItem;
    /// <summary>
    /// ������ �������� �������
    /// </summary>
    /// <param name="AIndex">
    /// ���������� ����� �������� � �������
    /// </param>
    property Items[const AIndex: Integer]: IArchiveBoxItem read GetItem; default;
  end;

implementation

end.
