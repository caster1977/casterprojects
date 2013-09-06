unit uIArchiveCompany;

interface

uses
  DB,
  uILoadableItem;

type
  IArchiveCompany = interface(ILoadableItem)
    ['{07B55416-6B9A-4F7F-82D7-59C773D296A8}']
    function GetId: Integer;

    ///	<summary>
    ///	  Идентификатор компании
    ///	</summary>
    property Id: Integer read GetId;

    function GetCode: string;

    ///	<summary>
    ///	  Код компании
    ///	</summary>
    property Code: string read GetCode;
  end;

implementation

end.
