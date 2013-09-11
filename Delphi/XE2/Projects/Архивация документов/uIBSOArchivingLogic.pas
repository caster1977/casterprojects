unit uIBSOArchivingLogic;

interface

uses
  uIDocumentArchivingLogic,
  uIDocument,
  uIArchiveBox,
  uIArchiveCompanies,
  uIArchiveBoxTypes;

type
  IBSOArchivingLogic = interface(IDocumentArchivingLogic)
    ['{48F51256-F7AB-49D3-9593-AFFA2A2DFAB7}']
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
    function GetOpenedBoxQuantity(const ADocument: IDocument): Integer; overload;

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
    function GetOpenedBoxQuantity(const AType, ACompanyId: Integer): Integer; overload;

    function GetArchiveCompanies: IArchiveCompanies;

    ///	<summary>
    ///	  ������ �������� ��������
    ///	</summary>
    property ArchiveCompanies: IArchiveCompanies read GetArchiveCompanies;

    function GetArchiveBoxTypes: IArchiveBoxTypes;

    ///	<summary>
    ///	  ������ ����� �������� �������
    ///	</summary>
    property ArchiveBoxTypes: IArchiveBoxTypes read GetArchiveBoxTypes;

    ///	<summary>
    ///	  ��������� �������� �������� ������
    ///	</summary>
    procedure CloseCurrentBox;
  end;

implementation

end.
