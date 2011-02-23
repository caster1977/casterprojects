unit SendMsgTo;

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
  StdCtrls,
  ActnList,
  CheckLst,
  ButtonGroup,
  ImgList,
  Buttons,
  ExtCtrls,
  Main;

type
  TSendMsgToForm= class(TForm)
    MessageGroupBox: TGroupBox;
    SendMessageTo_Memo: TMemo;
    ActionList1: TActionList;
    Action_Send: TAction;
    Action_Close: TAction;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Action_Help: TAction;
    ForAll_CheckBox: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure SendMessageTo_MemoChange(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_SendExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

var
  SendMsgToForm: TSendMsgToForm;

implementation

uses
  ScktComp;
{$R *.dfm}

procedure TSendMsgToForm.FormCreate(Sender: TObject);
begin
  if not(FileExists(ExpandFileName(Application.HelpFile))) then
    begin
      Action_Help.Enabled:=False;
      Action_Help.Visible:=False;
    end;
end;

procedure TSendMsgToForm.Action_CloseExecute(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TSendMsgToForm.Action_SendExecute(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TSendMsgToForm.Action_HelpExecute(Sender: TObject);
begin
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    MessageBox(SendMsgToForm.Handle, PChar('Извините, справочный файл к данной программе не найден.'), PChar('Ошибка!'), MB_OK+MB_ICONERROR);
end;

procedure TSendMsgToForm.SendMessageTo_MemoChange(Sender: TObject);
begin
  Action_Send.Enabled:=Trim(SendMessageTo_Memo.Text)<>'';
  ForAll_CheckBox.Enabled:=Action_Send.Enabled;
end;

procedure TSendMsgToForm.FormShow(Sender: TObject);
begin
  SendMessageTo_Memo.SelectAll;
end;

end.
