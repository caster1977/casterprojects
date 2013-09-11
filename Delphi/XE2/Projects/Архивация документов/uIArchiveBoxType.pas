unit uIArchiveBoxType;

interface

uses
  DB,
  uILoadableItem;

type
  IArchiveBoxType = interface(ILoadableItem)
    ['{09801B9D-D9D9-4E1B-BD4A-F22F935308E3}']
    function GetName: string;

    /// <summary>
    /// ������������ ���� ��������� ������
    /// </summary>
    property Name: string read GetName;

    function GetCode: string;

    /// <summary>
    /// ��� ���� ��������� ������
    /// </summary>
    property Code: string read GetCode;

    function GetCapacity: Integer;

    /// <summary>
    /// ����������� ���� ��������� ������
    /// </summary>
    property Capacity: Integer read GetCapacity;
  end;

implementation

end.
