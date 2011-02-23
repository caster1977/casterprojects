unit SelectDate;

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
  StdCtrls,
  ComCtrls;

type
  TSelectDateForm= class(TForm)
    DateTimePicker1: TDateTimePicker;
    Button1: TButton;
    Button2: TButton;
  end;

var
  SelectDateForm: TSelectDateForm;

implementation

{$R *.DFM}

end.
