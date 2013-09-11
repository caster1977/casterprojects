unit uIArchiveCompanyList;

interface

uses
  uILoadableList,
  uIArchiveCompanyItem;

type
  /// <summary>
  /// ��������� ��� ������� � ������� ������ �������� ��������
  /// </summary>
  IArchiveCompanyList = interface(ILoadableList)
    ['{4F99D11B-9566-4B7A-B728-B9FB97C6E9D8}']
    /// <summary>
    /// ������� ��������� ������ �� �������� � ��������� ���������������
    /// </summary>
    /// <param name="AId">
    /// �������������
    /// </param>
    /// <returns>
    /// ��������
    /// </returns>
    function GetItemById(const AId: Integer): IArchiveCompanyItem;
    function GetItem(const AIndex: Integer): IArchiveCompanyItem;
    /// <summary>
    /// ������ �������� ��������
    /// </summary>
    /// <param name="AIndex">
    /// ���������� ����� �������� � �������
    /// </param>
    property Item[const AIndex: Integer]: IArchiveCompanyItem read GetItem; default;
  end;

implementation

end.
