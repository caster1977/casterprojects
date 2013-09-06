unit uIArchiveCompanies;

interface

uses
  uILoadableList,
  uIArchiveCompany;

type
  IArchiveCompanies = interface(ILoadableList)
    ['{4F99D11B-9566-4B7A-B728-B9FB97C6E9D8}']
    ///	<summary>
    ///	  ������� ��������� ������ �� �������� � ��������� ���������������
    ///	</summary>
    ///	<param name="AId">
    ///	  �������������
    ///	</param>
    ///	<returns>
    ///	  ��������
    ///	</returns>
    function GetItemById(const AId: Integer): IArchiveCompany;

    function GetItem(const AIndex: Integer): IArchiveCompany;

    ///	<summary>
    ///	  ������ �������� ��������
    ///	</summary>
    ///	<param name="AIndex">
    ///	  ���������� ����� �������� � �������
    ///	</param>
    property Items[const AIndex: Integer]: IArchiveCompany read GetItem; default;
  end;

implementation

end.
