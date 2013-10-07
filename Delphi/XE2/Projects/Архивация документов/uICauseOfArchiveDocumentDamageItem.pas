unit uICauseOfArchiveDocumentDamageItem;

interface

uses
  uILoadableItem;

type
  /// <summary>
  /// ��������� ��� ������� � ������� ������� "�����" ����������
  /// </summary>
  ICauseOfDamageItem = interface(ILoadableItem)
    ['{56F10AB4-0102-4528-84F4-17F4E7872194}']
    function GetName: string;

    /// <summary>
    /// ������������ ������� "�����" ���������
    /// </summary>
    property name: string read GetName;

    function GetBarcode: string;

    /// <summary>
    /// �����-��� ������� "�����" ���������
    /// </summary>
    property Barcode: string read GetBarcode;
  end;

implementation

end.
