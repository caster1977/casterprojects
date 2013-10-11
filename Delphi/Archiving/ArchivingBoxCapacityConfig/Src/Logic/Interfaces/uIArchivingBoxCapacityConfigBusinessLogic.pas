unit uIArchivingBoxCapacityConfigBusinessLogic;

interface

uses
  uICustomBusinessLogic;

type
  /// <summary>
  /// ��������� ������� � ������� ������-������ �������� ��������� ������ �������
  /// </summary>
  IArchivingBoxCapacityConfigBusinessLogic = interface(ICustomBusinessLogic)
    ['{D8E92F43-14A8-446B-8802-BA4ED0B9EF8D}']
    /// <summary>
    /// ��������� ��������� ������� � ����������� ��������� ����������
    /// </summary>
    procedure EnableDocumentArchiving;
    /// <summary>
    /// ��������� ���������� ������� � ����������� ��������� ����������
    /// </summary>
    procedure DisableDocumentArchiving;
    /// <summary>
    /// ��������� �������� ������ �� �� � ���������
    /// </summary>
    procedure LoadData;

    ///	<summary>
    ///	  ������� ������ ������ �� ���������� � ��
    ///	</summary>
    ///	<returns>
    ///	  ������� �� ��������� ������ ������
    ///	</returns>
    function SaveData: Boolean;
    /// <summary>
    /// �������, ������������, ���� �� �������� ������ � ������� ��������
    /// </summary>
    function DataWasChanged: Boolean;
  end;

implementation

end.
