unit uISearchedBSOItem;

interface

uses
  uicustombsoitem,
  utcustombsoitem,
  uIArchiveDocumentItem;

type
  ISearchedBSOItem = interface(ICustomBSOItem)
    ['{9DCE1D0E-098C-4696-8BA9-FE42B4517A55}']
    procedure SetStatusId(const AValue: Integer);
    function GetStatusId: Integer;

    ///	<summary>
    ///	  ������������� ������� ��������� ���������
    ///	</summary>
    property StatusId: Integer read GetStatusId write SetStatusId;

    function GetStatusName: string;
    procedure SetStatusName(const AValue: string);

    ///	<summary>
    ///	  ������������ ������� ��������� ���������
    ///	</summary>
    property StatusName: string read GetStatusName write SetStatusName;

    procedure SetArchiveBoxTypeName(const AValue: string);
    function GetArchiveBoxTypeName: string;

    ///	<summary>
    ///	  ������������ ���� ��������� ������
    ///	</summary>
    property ArchiveBoxTypeName: string read GetArchiveBoxTypeName write SetArchiveBoxTypeName;
  end;

implementation

end.
