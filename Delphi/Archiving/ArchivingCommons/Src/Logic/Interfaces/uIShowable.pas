unit uIShowable;

interface

uses
  Classes;

type
  /// <summary>
  /// ��������� ������� � ��������, ������� ������������ ����
  /// </summary>
  /// <remarks>
  /// ������������ ��� ����������� ������ ����������� �� ��������� ���������
  /// ����� ������� ��� ������������ <b>Show</b> ������-�������
  /// </remarks>
  IShowable = interface
    ['{539C995D-3987-47CA-95A6-6482AC7A2887}']
    function GetShowableFields: IInterfaceList;

    /// <summary>
    /// ������ ������������ �����
    /// </summary>
    property ShowableFields: IInterfaceList read GetShowableFields;

    /// <summary>
    /// ��������� ���������� ���� � ������ ������������ �����
    /// </summary>
    /// <param name="ACaption">
    /// ����� ��������� ����
    /// </param>
    /// <param name="AName">
    /// ������������ ����
    /// </param>
    /// <param name="AValue">
    /// �������� ���� � ���� ������
    /// </param>
    procedure AddShowableField(const ACaption, AName, AValue: string);

    /// <summary>
    /// ���������, ����������� ������ ������������ ����� ������
    /// </summary>
    procedure FillShowableFieldsList;
  end;

implementation

end.
