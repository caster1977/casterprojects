unit CastersPackage.uINormalized;

interface

type
  INormalized = interface
    ['{AD602BB0-347C-4223-B729-4CE1CC8A1E0F}']
    function GetAutoNormalizeData: Boolean;
    procedure SetAutoNormalizeData(const AValue: Boolean);
    /// <summary>
    /// ��������� �� ��� ������ ������ � ���� ������������� ��������� ��
    /// ������������?
    /// </summary>
    /// <remarks>
    /// ��� �� �������� �������� ����� �������� ��� �������� ������� �����
    /// �����������<b>Create(<i>��������</i>);</b>
    /// </remarks>
    property AutoNormalizeData: Boolean read GetAutoNormalizeData write SetAutoNormalizeData;
    /// <summary>
    /// ����������������� ������ ������ (������ ����������������)
    /// </summary>
    /// <returns>
    /// <para>
    /// ���� ������������ ������ <i>
    /// <b>�� ���������</b>
    /// </i> - ����� ���������� <b>True</b>.
    /// </para>
    /// <para>
    /// ���� ������������ ������ <i>
    /// <b>���������</b>
    /// </i>, ����� ���������� <b>False</b>.
    /// </para>
    /// </returns>
    /// <remarks>
    /// ��. ����� ��������� <b>Normalize</b>
    /// </remarks>
    function IsNormalized: Boolean;
    /// <summary>
    /// ��������� ������������ �������� ������ ������
    /// </summary>
    /// <remarks>
    /// ��. ����� ������� <b>Normalized</b>
    /// </remarks>
    procedure Normalize;
  end;

implementation

end.
