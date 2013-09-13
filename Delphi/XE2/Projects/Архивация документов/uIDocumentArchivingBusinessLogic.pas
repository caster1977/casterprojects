unit uIDocumentArchivingBusinessLogic;

interface

uses
  Controls,
  uICustomBusinessLogic,
  uIArchiveBoxItem,
  uIShowable;

type
  ///	<summary>
  ///	  ��������� ������� � ������� ������-������ �������� ��������� ����������
  ///	</summary>
  IDocumentArchivingBusinessLogic = interface(ICustomBusinessLogic)
    ['{B4D4317B-5679-4A31-9F53-F31CFFD99A6F}']
    function GetCurrentBox: IArchiveBoxItem;
    /// <summary>
    /// ������� �������� �����
    /// </summary>
    property CurrentBox: IArchiveBoxItem read GetCurrentBox;
    /// <summary>
    /// ������� ����������� ����������� ���������� ���� ������
    /// ���������� ����
    /// </summary>
    /// <param name="AType">
    /// ��� ������
    /// </param>
    /// <returns>
    /// ���������� ���������� � ������ ���� ������
    /// </returns>
    function GetBoxCapacity(const AType: Integer): Integer; overload;
    /// <summary>
    /// ������� ����������� ����������� ���������� ���� ������
    /// ���������� ����
    /// </summary>
    /// <param name="ABox">
    /// �����
    /// </param>
    /// <returns>
    /// ���������� ���������� � ������ ���� ������
    /// </returns>
    function GetBoxCapacity(const ABox: IArchiveBoxItem): Integer; overload;
    /// <summary>
    /// ������� ��������� ���������� �������� ������� ��� ���� � ��������
    /// ��������������� ���������� ���������
    /// </summary>
    /// <param name="ADocument">
    /// ��������
    /// </param>
    /// <returns>
    /// ���������� �������
    /// </returns>
    //function GetOpenedBoxQuantity(const ADocument: IDocument): Integer; overload;

    /// <summary>
    /// ������� ��������� ���������� �������� ������� ��� ���� � ��������
    /// </summary>
    /// <param name="AType">
    /// ��� ������
    /// </param>
    /// <param name="ACompanyId">
    /// ������������� ��������
    /// </param>
    /// <returns>
    /// ���������� �������
    /// </returns>
    //function GetOpenedBoxQuantity(const AType, ACompanyId: Integer): Integer; overload;
    /// <summary>
    /// ��������� ����������� ������ ���������� "�������������" �������
    /// </summary>
    //procedure ShowShowableItem(const AParentControl: TCustomControl; const AShowableItem: IShowable);

    ///	<summary>
    ///	  ��������� "������������" ���������� ������
    ///	</summary>
    ///	<param name="ABox">
    ///	  �����
    ///	</param>
//    procedure PutBoxAside(const ABox: IArchiveBoxItem);

    ///	<summary>
    ///	  ��������� �������� ���������� ������
    ///	</summary>
    ///	<param name="ABox">
    ///	  �����
    ///	</param>
//    procedure CloseBox(const ABox: IArchiveBoxItem);

//    procedure DeleteBox(const ABox: IArchiveBoxItem);
  end;

implementation

end.
