unit uTRequestListForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.ImgList, Vcl.ToolWin,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData,
  cxGridBandedTableView, cxGridDBBandedTableView, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid;

type
  TRequestListForm = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton5: TToolButton;
    ImageList1: TImageList;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    ImageList2: TImageList;
    Label2: TLabel;
    Label6: TLabel;
    DateTimePicker2: TDateTimePicker;
    Label5: TLabel;
    DateTimePicker1: TDateTimePicker;
    Button5: TButton;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    cxGrid1DBBandedTableView1: TcxGridDBBandedTableView;
    procedure ToolButton1Click(Sender: TObject);
  end;

var
  RequestListForm: TRequestListForm;

implementation

{$R *.dfm}

uses
  uTRequestForm;

procedure TRequestListForm.ToolButton1Click(Sender: TObject);
begin
  with TRequestForm.Create(Self) do
  try
    ShowModal;
  finally
    Free;
  end;
end;

end.
