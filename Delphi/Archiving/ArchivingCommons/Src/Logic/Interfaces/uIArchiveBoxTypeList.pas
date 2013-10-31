unit uIArchiveBoxTypeList;

interface

uses
  uILoadableList,
  uIArchiveBoxTypeItem;

type
  IArchiveBoxTypeList = interface(ILoadableList)
    ['{3B0BED3A-C586-4ECD-A6AD-FEE5BB554248}']
    /// <summary>
    /// ������� ��������� ������ �� ��� ��������� ������ � ��������� ���������������
    /// </summary>
    /// <param name="AId">
    /// �������������
    /// </param>
    /// <returns>
    /// ��� ������
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveBoxTypeItem;
    // function GetItem(const AIndex: Integer): IArchiveBoxTypeItem;
    // /// <summary>
    // /// ������ ����� �������� �������
    // /// </summary>
    // /// <param name="AIndex">
    // /// ���������� ����� �������� � �������
    // /// </param>
    // property Items[const AIndex: Integer]: IArchiveBoxTypeItem read GetItem; default;
  end;

implementation

end.
