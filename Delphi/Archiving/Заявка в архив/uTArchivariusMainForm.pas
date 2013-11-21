unit uTArchivariusMainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ComCtrls,
  Vcl.ToolWin,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxCustomData,
  cxFilter,
  cxData,
  cxDataStorage,
  cxEdit,
  cxNavigator,
  Data.DB,
  cxDBData,
  cxContainer,
  cxGroupBox,
  cxSplitter,
  cxGridLevel,
  cxClasses,
  cxGridCustomView,
  cxGridCustomTableView,
  cxGridTableView,
  cxGridDBTableView,
  cxGrid,
  Vcl.ImgList,
  Vcl.ExtCtrls,
  cxPCdxBarPopupMenu,
  cxPC,
  cxGridBandedTableView,
  cxGridDBBandedTableView,
  System.Actions,
  Vcl.ActnList;

type
  TArchivariusMainForm = class(TForm)
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    cxPageControl4: TcxPageControl;
    cxTabSheet10: TcxTabSheet;
    cxTabSheet13: TcxTabSheet;
    ToolBar18: TToolBar;
    ToolButton108: TToolButton;
    ToolButton109: TToolButton;
    ToolButton112: TToolButton;
    ToolButton113: TToolButton;
    ToolButton114: TToolButton;
    ToolButton116: TToolButton;
    cxGrid18: TcxGrid;
    cxGridDBTableView17: TcxGridDBTableView;
    cxGridDBColumn75: TcxGridDBColumn;
    cxGridDBColumn76: TcxGridDBColumn;
    cxGridDBColumn77: TcxGridDBColumn;
    cxGridDBColumn78: TcxGridDBColumn;
    cxGridDBColumn79: TcxGridDBColumn;
    cxGridDBColumn80: TcxGridDBColumn;
    cxGridLevel17: TcxGridLevel;
    cxGrid19: TcxGrid;
    cxGridDBTableView18: TcxGridDBTableView;
    cxGridDBColumn81: TcxGridDBColumn;
    cxGridDBColumn82: TcxGridDBColumn;
    cxGridDBColumn83: TcxGridDBColumn;
    cxGridDBColumn84: TcxGridDBColumn;
    cxGridDBColumn85: TcxGridDBColumn;
    cxGridLevel18: TcxGridLevel;
    ToolBar19: TToolBar;
    ToolButton117: TToolButton;
    ToolButton118: TToolButton;
    ToolButton121: TToolButton;
    ToolButton123: TToolButton;
    ToolButton128: TToolButton;
    ActionList1: TActionList;
    actRejectQuery: TAction;
    actIssuanceByQuery: TAction;
    actDeleteSelectionJob: TAction;
    actDocumentSelectionBySelectionJob: TAction;
    actRefresh: TAction;
    actExportToExcel: TAction;
    ToolButton2: TToolButton;
    ToolButton4: TToolButton;
    procedure actRejectQueryExecute(Sender: TObject);
    procedure actIssuanceByQueryExecute(Sender: TObject);
    procedure actDeleteSelectionJobExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actExportToExcelExecute(Sender: TObject);
    procedure actDocumentSelectionBySelectionJobExecute(Sender: TObject);
  end;

var
  ArchivariusMainForm: TArchivariusMainForm;

implementation

{$R *.dfm}

procedure TArchivariusMainForm.actDeleteSelectionJobExecute(Sender: TObject);
begin
  MessageBox(Handle, PWideChar('Вы действительно хотите удалить выделенное задание на отбор документов?'),
    PWideChar('Подтверждение удаления задания на отбор документов'), MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2);
end;

procedure TArchivariusMainForm.actDocumentSelectionBySelectionJobExecute(
  Sender: TObject);
begin
  //
end;

procedure TArchivariusMainForm.actExportToExcelExecute(Sender: TObject);
begin
  //
end;

procedure TArchivariusMainForm.actIssuanceByQueryExecute(Sender: TObject);
begin
  MessageBox(Handle, PWideChar('Вы действительно хотите выдать документы из архива согласно выделенному запросу?'),
    PWideChar('Подтверждение выдачи документов согласно запроса'), MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2);
end;

procedure TArchivariusMainForm.actRefreshExecute(Sender: TObject);
begin
  //
end;

procedure TArchivariusMainForm.actRejectQueryExecute(Sender: TObject);
begin
  MessageBox(Handle, PWideChar('Вы действительно хотите отклонить выделенный запрос на выдачу документов из архива?'),
    PWideChar('Подтверждение отклонения запроса на выдачу'), MB_OKCANCEL + MB_ICONWARNING + MB_DEFBUTTON2);
end;

end.
