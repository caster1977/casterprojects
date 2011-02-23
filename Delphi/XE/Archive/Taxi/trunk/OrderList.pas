unit OrderList;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ToolWin,
  ActnMan,
  ActnCtrls,
  XPStyleActnCtrls,
  ActnList,
  Grids,
  ComCtrls,
  ImgList,
  ExtCtrls;

type
  THackControl= class(TControl);
    TOrderListForm= class(TForm)StatusBar1: TStatusBar;
    ActionManager1: TActionManager;
    ImageList1: TImageList;
    Action_FindOrder: TAction;
    Action_AllOrders: TAction;
    Action_ExportToWord: TAction;
    Action_PlayRecord: TAction;
    Action_StopRecord: TAction;
    Action_ViewInfo: TAction;
    Action_CloseForm: TAction;
    Action_CloseFormSaveFilter: TAction;
    Image1: TImage;
    StringGrid1: TStringGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    procedure Action_CloseFormSaveFilterExecute(Sender: TObject);
    procedure Action_CloseFormExecute(Sender: TObject);
    procedure Action_StopRecordExecute(Sender: TObject);
    procedure Action_AllOrdersExecute(Sender: TObject);
    procedure Action_FindOrderExecute(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OrderListForm: TOrderListForm;

implementation

{$R *.dfm}

procedure TOrderListForm.Action_AllOrdersExecute(Sender: TObject);
begin
  //
end;

procedure TOrderListForm.Action_CloseFormExecute(Sender: TObject);
begin
  Close;
end;

procedure TOrderListForm.Action_CloseFormSaveFilterExecute(Sender: TObject);
begin
  Close;
end;

procedure TOrderListForm.Action_FindOrderExecute(Sender: TObject);
begin
  //
end;

procedure TOrderListForm.Action_StopRecordExecute(Sender: TObject);
begin
  //
end;

procedure TOrderListForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  ModalResult:=mrCancel;
end;

procedure TOrderListForm.FormCreate(Sender: TObject);
var
  PanelRect: TRect;
begin
  with StringGrid1 do
    begin
      Cells[0, 0]:='№ п/п';
      Cells[1, 0]:='Время';
      Cells[2, 0]:='Операция';
      Cells[3, 0]:='Диспетчер';
      Cells[4, 0]:='Позывн.';
      Cells[5, 0]:='Срок';
      Cells[6, 0]:='Описание';
    end;
  THackControl(Image1).SetParent(ToolBar1);
  PanelRect:=ToolBar1.Controls[ToolBar1.ControlCount-1].BoundsRect;
  Image1.SetBounds(PanelRect.Left+1, PanelRect.Top+1, PanelRect.Right-PanelRect.Left+1, PanelRect.Bottom-PanelRect.Top+1);
end;

procedure TOrderListForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_SUBTRACT then
    begin
      Action_CloseFormSaveFilter.Execute;
    end;
end;

procedure TOrderListForm.FormResize(Sender: TObject);
begin
  StringGrid1.ColWidths[6]:=StringGrid1.Width-(StringGrid1.ColWidths[0]+StringGrid1.ColWidths[1]+StringGrid1.ColWidths[2]+StringGrid1.ColWidths[3]+StringGrid1.ColWidths[4]+StringGrid1.ColWidths[5]+(StringGrid1.BevelWidth*4+8));
end;

end.
