unit uIDocumentItem;

interface

uses
  Controls,
  uILoadableItem;

type
  IDocumentItem = interface(ILoadableItem)
    ['{90EEBE6E-BE2C-41DC-B186-079F95C9B558}']
    /// <summary>
    /// ��������� ����������� ������ �������
    /// </summary>
    procedure Show(const AParentControl: TCustomControl = nil);
  end;

implementation

end.
