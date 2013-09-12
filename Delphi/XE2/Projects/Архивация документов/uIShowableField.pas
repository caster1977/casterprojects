unit uIShowableField;

interface

type
  IShowableField = interface
    ['{0EDC1B3E-4F99-483A-911F-37DAD5EC2104}']
    function GetCaption: string;

    /// <summary>
    /// ��������� ���� ��� ������ � ���� ��������� �����
    /// </summary>
    property Caption: string read GetCaption;

    function GetName: string;

    /// <summary>
    /// ������������ ����
    /// </summary>
    /// <remarks>
    /// ������������ ��� ���������� �����
    /// </remarks>
    property Name: string read GetName;

    function GetValue: string;

    ///	<summary>
    ///	�������� ���� � ���� ��������� ������
    ///	</summary>
    property Value: string read GetValue;
  end;

implementation

end.
