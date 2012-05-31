unit OA5.uINormalized;

interface

type
  INormalized = interface(IUnknown)
  ['{AD602BB0-347C-4223-B729-4CE1CC8A1E0F}']
    function GetAutoNormalizeData: boolean;
    procedure SetAutoNormalizeData(const Value: boolean);
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
    function Normalized: boolean;
    /// <summary>
    /// ��������� ������������ �������� ������ ������
    /// </summary>
    /// <remarks>
    /// ��. ����� ������� <b>Normalized</b>
    /// </remarks>
    procedure Normalize;
    /// <summary>
    /// ��������� �� ��� ������ ������ � ���� ������������� ��������� ��
    /// ������������?
    /// </summary>
    /// <remarks>
    /// ��� �� �������� �������� ����� �������� ��� �������� ������� �����
    /// �����������<b>Create(<i>��������</i>);</b>
    /// </remarks>
    property _AutoNormalizeData: boolean read GetAutoNormalizeData write SetAutoNormalizeData;
  end;

implementation

end.
