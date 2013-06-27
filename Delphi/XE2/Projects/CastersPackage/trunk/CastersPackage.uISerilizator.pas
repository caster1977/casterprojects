unit CastersPackage.uISerilizator;

interface

uses
  CastersPackage.uTProcedureOfObject;

type

  ISerilizator = interface
    ['{56D530BA-6BE7-4C51-9069-25379A3B6513}']
    procedure Load;
    procedure Save;

    function GetLoading: TProcedureOfObject;
    procedure SetLoading(const AValue: TProcedureOfObject);
    property Loading: TProcedureOfObject read GetLoading write SetLoading;

    function GetSaving: TProcedureOfObject;
    procedure SetSaving(const AValue: TProcedureOfObject);
    property Saving: TProcedureOfObject read GetSaving write SetSaving;

    function GetBeforeSave: TProcedureOfObject;
    procedure SetBeforeSave(const AValue: TProcedureOfObject);
    property BeforeSave: TProcedureOfObject read GetBeforeSave write SetBeforeSave;

    function GetAfterLoad: TProcedureOfObject;
    procedure SetAfterLoad(const AValue: TProcedureOfObject);
    property AfterLoad: TProcedureOfObject read GetAfterLoad write SetAfterLoad;
  end;

  TIniFileSerilizator = class

  end;

implementation

end.
