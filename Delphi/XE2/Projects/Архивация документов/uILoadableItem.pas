unit uILoadableItem;

interface

uses
  DB;

type
  ILoadableItem = interface
    ['{F5F51C86-2B21-4FA4-A7FD-570F609DBC00}']
    /// <summary>
    /// ��������� �������� ���������� ���������� ����� �������
    /// </summary>
    procedure Load(const ADataSet: TDataSet);
  end;

implementation

end.
