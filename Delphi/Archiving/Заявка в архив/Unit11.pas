unit Unit11;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxContainer,
  cxPCdxBarPopupMenu, Vcl.ImgList, cxGridBandedTableView,
  cxGridDBBandedTableView, cxPC, cxSplitter, cxGroupBox, Vcl.ComCtrls,
  Vcl.ToolWin, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid;

type
  TForm11 = class(TForm)
    StatusBar1: TStatusBar;
    ToolBar3: TToolBar;
    cxGrid2: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    cxGridDBTableView1Column3: TcxGridDBColumn;
    cxGridDBTableView1Column4: TcxGridDBColumn;
    cxGridDBTableView1Column5: TcxGridDBColumn;
    cxGridDBTableView1Column6: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    cxGridDBTableView1Column7: TcxGridDBColumn;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton8: TToolButton;
    procedure ToolButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form11: TForm11;

implementation

{$R *.dfm}

procedure TForm11.ToolButton3Click(Sender: TObject);
begin
  MessageBox(Handle, PWideChar('Короб со штрих-кодом 030113000001 не был принят в архив. Вы хотите принять данный короб в архив?'),
    PWideChar('Подтверждение принятия короба в архив'), MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON1);
  MessageBox(Handle, PWideChar('Вы действительно хотите пометить выделенный короб, как утерянный?'),
    PWideChar('Подтверждение'), MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2);
  MessageBox(Handle, PWideChar('Вы действительно хотите пометить выделенный документ, как утерянный?'),
    PWideChar('Подтверждение'), MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2);
  MessageBox(Handle, PWideChar('Вы действительно хотите удалить задание на раскладку документов по коробам?'),
    PWideChar('Подтверждение удаления задания на раскладку'), MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2);
end;

end.
