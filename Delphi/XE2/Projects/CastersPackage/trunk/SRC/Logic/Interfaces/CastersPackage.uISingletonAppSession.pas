unit CastersPackage.uISingletonAppSession;

interface

type
  ISingletonAppSession = interface
    ['{CE8C06B6-49A1-45C2-93E0-79574FB16779}']

    /// <summary>
    /// ��������� ����������� ������� � ���������� �� ������
    /// </summary>
    procedure ShowError;

    /// <summary>
    /// ������� �������� ���������� ������
    /// </summary>
    function Start: Boolean;

    /// <summary>
    /// ������� ��������� ���������� ������
    /// </summary>
    function Stop: Boolean;

    /// <summary>
    /// ��������� �������� ��������� ��������� � ������������� �������������
    /// (����������)
    /// </summary>
    procedure Activate;
  end;

implementation

end.
