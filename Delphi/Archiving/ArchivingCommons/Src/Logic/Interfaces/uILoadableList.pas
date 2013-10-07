unit uILoadableList;

interface

uses
  uILoadableItem,
  DB;

type
  /// <summary>
  /// ��������� ��� ������� � �������� ������ ��������, ������� ����������� � ������������ � ��
  /// </summary>
  ILoadableList = interface
    ['{6592595D-9B17-4BCD-9167-BC94B31A5687}']
    function GetCount: Integer;

    /// <summary>
    /// ���������� ��������� � ������
    /// </summary>
    property Count: Integer read GetCount;

    /// <summary>
    /// ������� ��������� ����������� ������ ���������� �������� ������
    /// </summary>
    function IndexOf(const AItem: ILoadableItem): Integer;

    /// <summary>
    /// ��������� �������� ��������� ������ �� ���� ������
    /// </summary>
    /// <param name="AConnection">
    /// ������ ����������� � ���� ������
    /// </param>
    procedure Load(const AConnection: TCustomConnection = nil);

    /// <summary>
    /// ������� ��� �������� ������ �������� ������
    /// </summary>
    function Add: Integer; overload;

    /// <summary>
    /// ������� ��� ���������� ���������� �������� � ������
    /// </summary>
    function Add(const AItem: ILoadableItem): Integer; overload;

    /// <summary>
    /// ��������� ������ �������� ����� ��������� ������ � ���� ������
    /// </summary>
    /// <param name="AConnection">
    /// ������ ����������� � ���� ������
    /// </param>
    /// <returns>
    /// ������� �� ��������� ������ � ��
    /// </returns>
    /// <remarks>
    /// �������� ������ ��� ������ ��������, � ������� ��������
    /// <b>Saveable</b> ����������� � <b>True</b>
    /// </remarks>
    function Save(const AConnection: TCustomConnection = nil): Boolean;

    /// <summary>
    /// ��������� �������� ���������� �������� ������
    /// </summary>
    /// <param name="AIndex">
    /// ������ �������� ������
    /// </param>
    /// <param name="AConnection">
    /// ������ ����������� � ��
    /// </param>
    /// <returns>
    /// ������� �� ������� ������� ������
    /// </returns>
    function Delete(const AIndex: Integer; const AConnection: TCustomConnection = nil): Boolean;

    /// <summary>
    /// ������� ������� ������
    /// </summary>
    /// <param name="AConnection">
    /// ������ ����������� � ��
    /// </param>
    /// <returns>
    /// ������� �� ��������� ������� ������
    /// </returns>
    function Clear(const AConnection: TCustomConnection = nil): Boolean;
  end;

implementation

end.
