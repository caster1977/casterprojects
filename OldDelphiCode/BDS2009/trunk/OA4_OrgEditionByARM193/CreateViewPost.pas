unit CreateViewPost;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, ExtCtrls, StdCtrls, CheckLst, Buttons, mysql, Main, Grids;

type
	TCreateViewPostForm = class(TForm)
		pnlButtons: TPanel;
    btnSend: TButton;
		btnClose: TButton;
		btnHelp: TButton;
    btnClear: TButton;
    Panel1: TPanel;
    pnlID: TPanel;
    lblPostIDCaption: TLabel;
    lblPostID: TLabel;
    Bevel4: TBevel;
    pnlCreation: TPanel;
    lblPostCreatedAtByCaption: TLabel;
    lblPostCreatedAtBy: TLabel;
    Bevel1: TBevel;
    meMessage: TMemo;
    Panel3: TPanel;
    lblCaption: TLabel;
    edbxCaption: TEdit;
    lblTo: TLabel;
    cmbbxTo: TComboBox;
    lblMessage: TLabel;
    btnProcess: TButton;
    btnPrevious: TButton;
    btnNext: TButton;
    btnErase: TButton;
    procedure meMessageKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnProcessClick(Sender: TObject);
    procedure btnEraseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  end;

var
  CreateViewPostForm: TCreateViewPostForm;

implementation

{$R *.dfm}

procedure TCreateViewPostForm.btnClearClick(Sender: TObject);
begin
  edbxCaption.Clear;
  cmbbxTo.ItemIndex:=-1;
  meMessage.Clear;
end;

procedure TCreateViewPostForm.btnEraseClick(Sender: TObject);
var
  s, s_msg_id, q: string;
  b, b1, bError: boolean;
  i: integer;
  GroupGUID: string;
begin
  GroupGUID:='{A1431DB8-7ED1-4A16-9929-13D2D805AD40}';
  bError:=False;
  b1:=False;
  MainForm.LogThis('������� �������� ���������...',GroupGUID,lmtInfo);
  b:=MessageBox(Handle,PChar('�� ������������� ������ ������� ������� ���������?'),PChar('OA4 - ������������� ��������'),MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK;
  if b then
    begin
      Screen.Cursor:=crHourGlass;
      MainForm.ProgressBar1.Max:=2;
      MainForm.ProgressBar1.Step:=1;
      MainForm.LogThis('�������� ��������� ������������ �������������...',GroupGUID,lmtInfo);
      // ��������� ID ����������� ���������
      s_msg_id:=lblPostID.Caption;
      // ������������ ������� �� �������� ��������� �� ��
      MainForm.LogThis('�������� ���������...',GroupGUID,lmtInfo);
      q:='UPDATE '+MainForm.Configuration.sMySQLDatabase+'._msg SET msg_erased="1" WHERE msg_id='+s_msg_id+';';
      MainForm.LogThis(q,GroupGUID,lmtSQL);
      i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
      if i=0 then
        begin
          MainForm.LogThis('������ �������� �������.',GroupGUID,lmtInfo);
          i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
          if i=1 then
            begin
              MainForm.LogThis('���������� �������� ����� ������������� ���������� (1).',GroupGUID,lmtInfo);
              MainForm.LogThis('��������� ������� �������.',GroupGUID,lmtInfo);
              b1:=True;
            end
          else
            begin
              s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
              bError:=True;
            end;
          MainForm.ProgressBar1.StepIt;
        end
      else
        begin
          s:='�������� ������ ��� ���������� �������!';
          bError:=True;
        end;
      MainForm.ProgressBar1.StepIt;
      Application.ProcessMessages;
      // ������ ���������� � ��
      if not bError then
        begin
          MainForm.LogThis('�������� ������ � ������� �������.',GroupGUID,lmtInfo);
          q:='INSERT INTO '+MainForm.Configuration.sMySQLDatabase+'._evn VALUES (NULL, NOW(),"DEL","msg",'+s_msg_id+','+MainForm.CurrentUser.sID+','+#39+q+#39+');';
          MainForm.LogThis(q,GroupGUID,lmtSQL);
          i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
          if i=0 then
            begin
              MainForm.LogThis('������ �������� �������.',GroupGUID,lmtInfo);
              i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
              MainForm.LogThis('���������� ������������ ����� ����� '+IntToStr(i)+'.',GroupGUID,lmtInfo);
              if (i=1) then
                MainForm.LogThis('������ � ������� ������� ������� �������',GroupGUID,lmtInfo)
              else
                begin
                  s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
                  bError:=True;
                end;
            end
          else
            begin
              s:='�������� ������ ��� ���������� �������!';
              bError:=True;
            end;
        end;
      MainForm.ProgressBar1.StepIt;
      Application.ProcessMessages;
      MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
      Screen.Cursor:=crDefault;
      if bError then
        begin
          MainForm.LogThis(s,GroupGUID,lmtError);
          MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
    end
  else MainForm.LogThis('�������� ��������� �������� �������������...',GroupGUID,lmtInfo);
  if b1 then
    ModalResult:=mrOk;
end;

procedure TCreateViewPostForm.btnProcessClick(Sender: TObject);
var
  s, q: string;
  b1, bError: boolean;
  i: integer;
  GroupGUID: string;
begin
  GroupGUID:='{47B42EC0-B65C-43DD-A297-D1FAEB94D9EC}';
  Screen.Cursor:=crHourGlass;
  bError:=False;
  b1:=False;
  MainForm.LogThis('������� ������� ��������� ��� ������������...',GroupGUID,lmtInfo);
  // ��������� ID ����������� ���������
  s:=lblPostID.Caption;
  // ������������ ������� �� �������� ��������� �� ��
  MainForm.LogThis('������� ���������...',GroupGUID,lmtInfo);
  MainForm.ProgressBar1.Max:=1;
  MainForm.ProgressBar1.Step:=1;
  q:='UPDATE '+MainForm.Configuration.sMySQLDatabase+'._msg SET msg_processed="1" WHERE msg_id='+s+';';
  MainForm.LogThis(q,GroupGUID,lmtSQL);
  i:=mysql_real_query(MainForm.MySQLConnectionHandler,PChar(q),Length(q));
  if i=0 then
    begin
      MainForm.LogThis('������ �������� �������.',GroupGUID,lmtInfo);
      i:=mysql_affected_rows(MainForm.MySQLConnectionHandler);
      if i=1 then
        begin
          MainForm.ProgressBar1.Max:=i;
          MainForm.ProgressBar1.Step:=1;
          MainForm.LogThis('���������� ������������ ����� ������������� ���������� (1).',GroupGUID,lmtInfo);
          MainForm.LogThis('��������� ������� �������.',GroupGUID,lmtInfo);
          b1:=True;
          MainForm.ProgressBar1.StepIt;
        end
      else
        begin
          s:='���������� ������������ ����� ('+IntToStr(i)+') �� ������������� ���������� (1)!';
          bError:=True;
        end;
    end
  else
    begin
      s:='�������� ������ ��� ���������� �������!';
      bError:=True;
    end;
  MainForm.ProgressBar1.Position:=MainForm.ProgressBar1.Min;
  Screen.Cursor:=crDefault;
  if bError then
    begin
      MainForm.LogThis(s,GroupGUID,lmtError);
      MessageBox(Handle,PChar(s),PChar('OA4 - ������!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  if b1 then
    ModalResult:=mrYes;
end;

procedure TCreateViewPostForm.FormShow(Sender: TObject);
begin
  btnSend.Enabled:=((edbxCaption.Text<>'') and (cmbbxTo.ItemIndex>-1) and (meMessage.Text<>''));
  if btnSend.Enabled then
    begin
      btnSend.Hint:='������� ��� �������� ���������';
      btnSend.Default:=True;
    end
  else
    begin
      btnSend.Hint:='�� ������ ��������� ���� "���� ���������", "�������" � "����� ���������" ����� ��������� ���������';
      btnSend.Default:=False;
    end;
end;

procedure TCreateViewPostForm.meMessageKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    ModalResult:=mrCancel;
end;

end.
