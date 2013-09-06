unit uICustomList;

interface

uses
  DB;

type
  ICustomList = interface
  ['{BAA33C23-E05A-4545-B421-4ABB81716F48}']
    function GetCount: Integer;

    ///	<summary>
    ///	  Количество элементов в списке
    ///	</summary>
    property Count: Integer read GetCount;
  end;

implementation

end.
