unit uICauseOfDamageList;

interface

uses
  uILoadableList,
  uICauseOfDamageItem;

type
  /// <summary>
  /// ��������� ��� ������� � ������� ������ ������ "�����" ����������
  /// </summary>
  ICauseOfDamageList = interface(ILoadableList)
    ['{F5C40A5E-ADC5-47A6-9C5B-89A5F4D98DCA}']

    ///	<summary>
    ///	  ������� ��������� ������ ��������� "�����" ���������� ���������
    ///	  ���������������
    ///	</summary>
    ///	<param name="AId">
    ///	  �������������
    ///	</param>
    ///	<returns>
    ///	  ������� "�����"
    ///	</returns>
    function GetItemById(const AId: Integer): ICauseOfDamageItem;
    function GetItem(const AIndex: Integer): ICauseOfDamageItem;

    ///	<summary>
    ///	  ������ ������ "�����" ����������
    ///	</summary>
    ///	<param name="AIndex">
    ///	  ���������� ����� �������� � �������
    ///	</param>
    property Item[const AIndex: Integer]: ICauseOfDamageItem read GetItem; default;
  end;

implementation

end.
