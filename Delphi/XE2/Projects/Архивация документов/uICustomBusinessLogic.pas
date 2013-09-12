unit uICustomBusinessLogic;

interface

uses
  uTOnDisplayMessage,
  DB;

type
  ICustomBusinessLogic = interface
    ['{6368C99D-F403-435C-AA90-B9908A442F26}']
    function GetOnDisplayMessage: TOnDisplayMessage;
    procedure SetOnDisplayMessage(const AValue: TOnDisplayMessage);
    property OnDisplayMessage: TOnDisplayMessage read GetOnDisplayMessage write SetOnDisplayMessage;

    procedure DisplayInfoMessage(const AText: string);
    procedure DisplayErrorMessage(const AText: string);
    procedure DisplaySuccessMessage(const AText: string);
    procedure ClearMessage;

    function GetQuery: TDataSet;
    property Query: TDataSet read GetQuery;

    function GetConnection: TCustomConnection;
    property Connection: TCustomConnection read GetConnection;

    procedure CloseQuery;
  end;

    /// <summary>
    /// Процедура отображения данных объекта
    /// </summary>
    //procedure Show(const AParentControl: TCustomControl = nil);

implementation

end.
