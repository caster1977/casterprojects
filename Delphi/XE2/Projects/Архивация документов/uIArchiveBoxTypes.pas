unit uIArchiveBoxTypes;

interface

uses
  uILoadableList,
  uIArchiveBoxType;

type
  IArchiveBoxTypes = interface(ILoadableList)
    ['{3B0BED3A-C586-4ECD-A6AD-FEE5BB554248}']
    ///	<summary>
    ///	  ������� ��������� ������ �� ��� ��������� ������ � ��������� ���������������
    ///	</summary>
    ///	<param name="AId">
    ///	  �������������
    ///	</param>
    ///	<returns>
    ///	  ��������
    ///	</returns>
    function GetItemById(const AId: Integer): IArchiveBoxType;

    function GetItem(const AIndex: Integer): IArchiveBoxType;

    ///	<summary>
    ///	  ������ ����� �������� �������
    ///	</summary>
    ///	<param name="AIndex">
    ///	  ���������� ����� �������� � �������
    ///	</param>
    property Items[const AIndex: Integer]: IArchiveBoxType read GetItem; default;
  end;

implementation

end.
