unit uIDocuments;

interface

uses
  uIDocument,
  uILoadableList;

type
  IDocuments = interface(ILoadableList)
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
    function GetItemById(const AId: Integer): IDocument;

    function GetItem(const AIndex: Integer): IDocument;

    /// <summary>
    /// ������ ����������
    /// </summary>
    /// <param name="AIndex">
    /// ���������� ����� �������� � �������
    /// </param>
    property Items[const AIndex: Integer]: IDocument read GetItem; default;


    ///	<summary>
    ///	  ������� ���������� ��������� � �����
    ///	</summary>
    function Add(const AValue: IDocument): Integer;

    /// <summary>
    /// ��������� �������� ���������� ��������� �� ������
    /// </summary>
    procedure DeleteLast;
  end;

implementation

end.
