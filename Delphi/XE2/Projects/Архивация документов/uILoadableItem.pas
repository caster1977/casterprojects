unit uILoadableItem;

interface

uses
  DB;

type
  /// <summary>
  /// ��������� ��� ������� � ��������, ������� ����������� �� �� �
  /// ������������ � ��
  /// </summary>
  ILoadableItem = interface
    ['{F5F51C86-2B21-4FA4-A7FD-570F609DBC00}']
    function GetId: Integer;

    /// <summary>
    /// ������������� ������
    /// </summary>
    property Id: Integer read GetId;
    /// <summary>
    /// ��������� �������� ��������� �������� �������� ��� ���������� ����� �������
    /// </summary>
    procedure Load(const ADataSet: TDataSet); overload;

    /// <summary>
    /// ��������� �������� ��������� ���������� ��� ���������� ����� �������
    /// </summary>
    procedure Load(const AConnection: TCustomConnection); overload;

    /// <summary>
    /// ������� ������ ������ ����� ������� � ��
    /// </summary>
    /// <param name="AConnection">
    /// ������ ����������� � ��
    /// </param>
    /// <returns>
    /// ������� �� ��������� ������ � ��
    /// </returns>
    /// <remarks>
    /// �������� ������ ��� ��������, � ������� �������� <b>Saveable</b>
    /// ����������� � <b>True</b>
    /// </remarks>
    function Save(const AConnection: TCustomConnection): Boolean;
  end;

implementation

end.
