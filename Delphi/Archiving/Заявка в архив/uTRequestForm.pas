unit uTRequestForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxSplitter,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  Data.DB, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, Vcl.ToolWin,
  Vcl.Buttons, Vcl.ImgList, cxPCdxBarPopupMenu, cxPC;

type
  TRequestForm = class(TForm)
    GroupBox2: TGroupBox;
    Panel4: TPanel;
    GroupBox1: TGroupBox;
    Panel5: TPanel;
    Panel6: TPanel;
    GroupBox3: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridDBTableView2: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    GroupBox4: TGroupBox;
    cxGrid3: TcxGrid;
    cxGridDBTableView3: TcxGridDBTableView;
    cxGridLevel3: TcxGridLevel;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    cxGridDBTableView1Column3: TcxGridDBColumn;
    cxGridDBTableView1Column4: TcxGridDBColumn;
    cxGridDBTableView1Column5: TcxGridDBColumn;
    ImageList1: TImageList;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton9: TToolButton;
    ToolButton11: TToolButton;
    cxGridDBTableView2Column1: TcxGridDBColumn;
    cxGridDBTableView2Column2: TcxGridDBColumn;
    cxGridDBTableView2Column3: TcxGridDBColumn;
    GroupBox5: TGroupBox;
    StatusBar1: TStatusBar;
    Label2: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    RadioButton1: TRadioButton;
    Panel2: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    RadioButton2: TRadioButton;
    Panel3: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    cxGridDBTableView3Column1: TcxGridDBColumn;
    cxGridDBTableView3Column3: TcxGridDBColumn;
    cxGridDBTableView3Column2: TcxGridDBColumn;
    cxGridDBTableView3Column4: TcxGridDBColumn;
    cxGridDBTableView3Column5: TcxGridDBColumn;
    Panel7: TPanel;
    ComboBox2: TComboBox;
    ComboBox1: TComboBox;
    ToolButton12: TToolButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    PageControl2: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Button2: TButton;
    Button3: TButton;
    ToolButton13: TToolButton;
    cxSplitter1: TcxSplitter;
    cxSplitter2: TcxSplitter;
    cxGridDBTableView2Column5: TcxGridDBColumn;
    cxGridDBTableView2Column6: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
  end;

var
  RequestForm: TRequestForm;

implementation

{$R *.dfm}

procedure TRequestForm.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;

end.
