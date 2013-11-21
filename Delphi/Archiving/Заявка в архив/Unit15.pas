unit Unit15;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DBXMSSQL, Vcl.ImgList,
  System.Actions, Vcl.ActnList, Data.Win.ADODB, Data.DB, Data.SqlExpr,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls;

type
  TForm15 = class(TForm)
    pnlButtons: TPanel;
    SQLConnection: TSQLConnection;
    ADOConnection: TADOConnection;
    ActionList: TActionList;
    actPrintSticker: TAction;
    actDeleteLastDocument: TAction;
    ImageList: TImageList;
    gbCurrentBox: TGroupBox;
    gbLastDocument: TGroupBox;
    gbBarcode: TGroupBox;
    edBarcode: TEdit;
    gbHint: TGroupBox;
    btnClose: TButton;
    actClose: TAction;
    lblHint: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form15: TForm15;

implementation

{$R *.dfm}

{ TForm15 }

end.
