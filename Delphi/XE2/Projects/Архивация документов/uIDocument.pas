unit uIDocument;

interface

uses
  Controls,
  DB,
  SqlExpr,
  ADODB;

type
  IDocument = interface
    ['{90EEBE6E-BE2C-41DC-B186-079F95C9B558}']

    /// <summary>
    /// ��������� �������� ���������� ���������� ����� �������
    /// </summary>
    procedure Load(const AConnection: TCustomConnection); overload;

    /// <summary>
    /// ��������� �������� ���������� ���������� ����� �������
    /// </summary>
    procedure Load(const ADataSet: TDataSet); overload;

    /// <summary>
    /// ��������� ����������� ������ �������
    /// </summary>
    procedure Show(const AParentControl: TCustomControl = nil);
  end;

implementation

end.
