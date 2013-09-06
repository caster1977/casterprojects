unit uIDocument;

interface

uses
  Controls,
  uILoadableItem;

type
  IDocument = interface(ILoadableItem)
    ['{90EEBE6E-BE2C-41DC-B186-079F95C9B558}']
    function GetId: Integer;
    procedure SetId(const AValue: Integer);

    /// <summary>
    /// ������������� ���������
    /// </summary>
    property Id: Integer read GetId write SetId;

    /// <summary>
    /// ��������� ����������� ������ �������
    /// </summary>
    procedure Show(const AParentControl: TCustomControl = nil);
  end;

implementation

end.
