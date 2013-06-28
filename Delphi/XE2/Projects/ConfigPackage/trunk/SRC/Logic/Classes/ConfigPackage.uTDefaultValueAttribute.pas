unit ConfigPackage.uTDefaultValueAttribute;

interface

uses
  System.Rtti;

type
  /// <summary>
  /// ����� ��������� ��� �������� �������� ��-��������� ��� ��������
  /// </summary>
  /// <remarks>
  /// <para>
  /// <b>������ �������������:</b>
  /// </para>
  /// <para>
  /// [TDefaultValue('<i>��������</i>')]
  /// </para>
  /// <para>
  /// [TDefaultValue(<i>True</i>)]
  /// </para>
  /// <para>
  /// [TDefaultValue(<i>22</i>)]
  /// </para>
  /// </remarks>
  TDefaultValueAttribute = class(TCustomAttribute)
  public
    /// <summary>
    /// ����������� ������ ��� �������� ���� <b>Integer</b>
    /// </summary>
    /// <param name="AValue">
    /// �������� ��-���������
    /// </param>
    constructor Create(const AValue: Integer); overload;

    /// <summary>
    /// ����������� ������ ��� �������� ���� <b>Boolean</b>
    /// </summary>
    /// <param name="AValue">
    /// �������� ��-���������
    /// </param>
    constructor Create(const AValue: Boolean); overload;

    /// <summary>
    /// ����������� ������ ��� �������� ���� <b>string</b>
    /// </summary>
    /// <param name="AValue">
    /// �������� ��-���������
    /// </param>
    constructor Create(const AValue: string); overload;
  strict private
    FValue: TValue;
    function GetValue: TValue;
  public
    /// <summary>
    /// �������� ��-���������
    /// </summary>
    property Value: TValue read FValue nodefault;
  end;

implementation

constructor TDefaultValueAttribute.Create(const AValue: Integer);
begin
  FValue := AValue;
end;

constructor TDefaultValueAttribute.Create(const AValue: Boolean);
begin
  FValue := AValue;
end;

constructor TDefaultValueAttribute.Create(const AValue: string);
begin
  FValue := AValue;
end;

function TDefaultValueAttribute.GetValue: TValue;
begin
  Result := FValue;
end;

end.
