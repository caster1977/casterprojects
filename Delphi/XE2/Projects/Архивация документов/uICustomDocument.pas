unit uICustomDocument;

interface

uses
  Controls,
  DB;

type
  ICustomDocument = interface
    ['{90EEBE6E-BE2C-41DC-B186-079F95C9B558}']

    /// <summary>
    /// ������� ��������� ������ ������� SQL, ����������� ������ ���
    /// ���������� ����� �������
    /// </summary>
    function GetSQLForLoad: string;

    /// <summary>
    /// ��������� �������� ���������� ���������� ����� ��������� ������
    /// ������
    /// </summary>
    procedure Load(const ASource: TDataSet);

    /// <summary>
    /// ��������� ����������� ������ �������
    /// </summary>
    procedure Show(const AParentControl: TCustomControl = nil);
  end;

implementation

end.
