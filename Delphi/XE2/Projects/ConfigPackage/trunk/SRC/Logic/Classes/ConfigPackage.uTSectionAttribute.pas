unit ConfigPackage.uTSectionAttribute;

interface

type
  /// <summary>
  /// ����� ��������� ��� �������� ������������ ������ ini-�����
  /// </summary>
  /// <remarks>
  /// <para>
  /// <b>������ �������������:</b>
  /// </para>
  /// <para>
  /// [TSection('<i>������������ ������</i>')]
  /// </para>
  /// </remarks>
  TSectionAttribute = class(TCustomAttribute)
  public
    /// <summary>
    /// ����������� ������
    /// </summary>
    /// <param name="AName">
    /// ������������ ������
    /// </param>
    constructor Create(const AName: string); reintroduce;
  strict private
    FName: string;
    function GetName: string;
  public
    /// <summary>
    /// ������������ ������
    /// </summary>
    /// <remarks>
    /// ������ ��� ������
    /// </remarks>
    property Name: string read GetName nodefault;
  end;

implementation

constructor TSectionAttribute.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
end;

function TSectionAttribute.GetName: string;
begin
  Result := FName;
end;

end.
