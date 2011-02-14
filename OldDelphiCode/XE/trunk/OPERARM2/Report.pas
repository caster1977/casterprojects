unit Report;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
  Grids,
  Gauges;

type
  TReportForm= class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Gauge1: TGauge;
  end;

var
  ReportForm: TReportForm;

implementation

{$R *.DFM}

end.
