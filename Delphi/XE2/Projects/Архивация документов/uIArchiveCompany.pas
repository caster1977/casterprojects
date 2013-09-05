unit uIArchiveCompany;

interface

uses
  DB;

type
  IArchiveCompany = interface
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

    ///	<summary>
    ///	  Процедура загрузки данных объекта из текущей записи набора данных
    ///	  (результирующей выборки)
    ///	</summary>
    ///	<param name="ADataSet">
    ///	  Набор данных
    ///	</param>
    procedure Load(const ADataSet: TDataSet);
  end;

implementation

end.
