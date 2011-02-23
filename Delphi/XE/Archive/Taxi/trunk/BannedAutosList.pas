unit BannedAutosList;

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
    TBannedAutosForm= class(TForm)ActionManager1: TActionManager;
    ImageList1: TImageList;
    Action_TimedBan: TAction;
    Action_Ban: TAction;
    Action_RemoveBan: TAction;
    Action_CloseForm: TAction;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton9: TToolButton;
    Panel2: TPanel;
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    Panel3: TPanel;
    Panel4: TPanel;
    StringGrid2: TStringGrid;
    Splitter1: TSplitter;
    procedure FormShow(Sender: TObject);
    procedure Action_RemoveBanExecute(Sender: TObject);
    procedure Action_CloseFormExecute(Sender: TObject);
    procedure Action_BanExecute(Sender: TObject);
    procedure Action_TimedBanExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BannedAutosForm: TBannedAutosForm;

implementation

{$R *.dfm}

uses
  TimedBan,
  BanReason,
  RemoveBan,
  RemoveBanPass;

procedure TBannedAutosForm.Action_BanExecute(Sender: TObject);
begin
  with TBanReasonForm.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TBannedAutosForm.Action_CloseFormExecute(Sender: TObject);
begin
  Close;
end;

procedure TBannedAutosForm.Action_RemoveBanExecute(Sender: TObject);
var
  mr: TModalResult;
begin
  with TRemoveBanForm.Create(Self) do
    try
      ShowModal;
    finally
      mr:=ModalResult;
      Free;
    end;
  if mr=mrOk then
    with TRemoveBanPassForm.Create(Self) do
      try
        ShowModal;
      finally
        Free;
      end;
end;

procedure TBannedAutosForm.Action_TimedBanExecute(Sender: TObject);
begin
  with TTimedBanForm.Create(Self) do
    try
      ShowModal;
    finally
      Free;
    end;
end;

procedure TBannedAutosForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  ModalResult:=mrCancel;
end;

procedure TBannedAutosForm.FormCreate(Sender: TObject);
begin
  with StringGrid1 do
    begin
      Cells[0, 0]:='Позыв.';
      Cells[1, 0]:='Тел.';
      Cells[2, 0]:='Марка';
      Cells[3, 0]:='Тип кузова';
      Cells[4, 0]:='Цвет';
      Cells[5, 0]:='Номер';
      Cells[6, 0]:='Номер TAXI';
      Cells[7, 0]:='Водитель';
      Cells[8, 0]:='Примечание';
    end;
  with StringGrid2 do
    begin
      Cells[0, 0]:='Дата установки';
      Cells[1, 0]:='Длительность';
      Cells[2, 0]:='Дата окончания';
      Cells[3, 0]:='Категория';
    end;
end;

procedure TBannedAutosForm.FormResize(Sender: TObject);
begin
  StringGrid2.ColWidths[3]:=StringGrid1.Width-(StringGrid2.ColWidths[0]+StringGrid2.ColWidths[1]+StringGrid2.ColWidths[2]+(StringGrid1.BevelWidth*4+5));
end;

procedure TBannedAutosForm.FormShow(Sender: TObject);
begin
  WindowState:=wsMaximized;
end;

end.
