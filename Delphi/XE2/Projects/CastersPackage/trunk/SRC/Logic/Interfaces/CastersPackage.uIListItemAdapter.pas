unit CastersPackage.uIListItemAdapter;

interface

uses
  Vcl.ComCtrls;

type
  IListItemAdapter = interface
    ['{E51C03DF-1E8A-46F6-B581-30FC806A7AAC}']
    procedure AppendToListView(const AListView: TListView);
  end;

implementation

end.
