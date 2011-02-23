unit AddEditPhone;

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
  ComCtrls,
  ExtCtrls,
  StdCtrls,
  CheckLst,
  Buttons,
  mysql,
  Main,
  Grids;

type
  TAddEditPhoneForm=class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnClear: TButton;
    Panel1: TPanel;
    pnlID: TPanel;
    lblIDCaption: TLabel;
    lblPhoneID: TLabel;
    Bevel4: TBevel;
    pnlModification: TPanel;
    Label3: TLabel;
    lblPhoneModifiedAt: TLabel;
    Bevel1: TBevel;
    mePhoneComments: TMemo;
    Panel3: TPanel;
    lblPhoneNumber: TLabel;
    edbxPhoneNumber: TEdit;
    lblPhoneType: TLabel;
    cmbbxPhoneType: TComboBox;
    lblPhoneComments: TLabel;
    lblPhoneCompared: TLabel;
    dtpPhoneCompared: TDateTimePicker;
    edbxPhonePriority: TEdit;
    lblPhonePriority: TLabel;
    procedure edbxPhoneNumberExit(Sender: TObject);
    procedure edbxPhonePriorityEnter(Sender: TObject);
    procedure edbxPhonePriorityExit(Sender: TObject);
    procedure edbxPhonePriorityChange(Sender: TObject);
    procedure edbxPhonePriorityKeyPress(Sender: TObject; var Key: Char);
    procedure edbxPhoneNumberChange(Sender: TObject);
    procedure mePhoneCommentsExit(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  end;

var
  AddEditPhoneForm: TAddEditPhoneForm;

implementation

{$R *.dfm}

function StringIsNumeric(aString: string): boolean; // ������� ��������, ������� �� ������-�������� �� �������� ��������
var
  i: integer;
  b: boolean;
begin
  b:=True; // ����������� ������������� ���������� ���������� "������"
  for i:=1 to Length(aString) do // � ����� ���������� ������� ���� �������� ������-���������
    begin
      if not CharInSet(aString[i], ['0'..'9']) then // ���� ��������� ������ �� �������� ������
        b:=False; // �� ����������� ���������� �������� "����"
    end;
  Result:=b; // ���������� ��������� �������
end;

procedure TAddEditPhoneForm.btnClearClick(Sender: TObject); // ���������-���������� ������� ������ "��������"
// ��������� ������� ���� "����� �����" � �������� ������ � ���� ����� ������ ��������
var
  GroupGUID: string;
begin
  GroupGUID:='{62C2C08D-089E-4C00-AC4C-D742606ADA05}';
  MainForm.Set_Busy(GroupGUID); // �������� ��������� "���������"
  Screen.Cursor:=crHourGlass; // ������ ������ � ����� �������� �����
  Application.ProcessMessages; // ����������� ������������ ��������� ���������
  dtpPhoneCompared.Date:=EncodeDate(1900, 01, 01); // ������� ���� "������"
  mePhoneComments.Clear; // ������� ���� "�����������"
  edbxPhoneNumber.Clear; // ������� ���� "����� ��������"
  // ��� ������� ���� "����� ��������" ����������� ���������-����������
  // � ����� ���� ����� "��� ��������" ������������ � �� ������� � ������ ���������
  edbxPhoneNumber.SetFocus; // �������� ������ ����� � ���� "����� ��������"
  Screen.Cursor:=crDefault; // ������ ���������� ������
  MainForm.Set_Ready(GroupGUID); // �������� ��������� ����������
  Application.ProcessMessages; // ����������� ������������ ��������� ���������
end;

procedure TAddEditPhoneForm.edbxPhoneNumberChange(Sender: TObject);
var
  sPhone: string; // ���������� ��� �������� �������� "���������" �� ��������-������������ ������ � ������� ��������
begin
  sPhone:= // �������� ��������� �� ��������-������������ ������ � ������� ��������
    StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(edbxPhoneNumber.Text, ' ', '', [rfReplaceAll]), // ������� �� ��������
    '(', '', [rfReplaceAll]), // �� ������� ������
    ')', '', [rfReplaceAll]), '-', '', [rfReplaceAll]), // �� ������ ������
    '+', '', [rfReplaceAll]), // �� ������ �����
    '[', '', [rfReplaceAll]), // �� ���������� ������
    ']', '', [rfReplaceAll]);
  if StringIsNumeric(sPhone) then // ���� ������ ������� �� ����
    begin
      if (Pos('2', sPhone)=1)and(Length(sPhone)=Length('2')+6) then // ���������� ����� ��������� ��������� �� 2
        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('������������')
      else
        if (Pos('3', sPhone)=1)and(Length(sPhone)=Length('3')+6) then // ���������� ����� ��������� ��������� �� 3
          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('������������')
        else
          if (Pos('5', sPhone)=1)and(Length(sPhone)=Length('5')+6) then // ���������� ����� ����������� ��������� �� 5
            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('������������')
          else
            if (Pos('375255', sPhone)=1)and(Length(sPhone)=Length('375255')+6) then // ���������� ����� ��������� ����
              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
            else
              if (Pos('80255', sPhone)=1)and(Length(sPhone)=Length('80255')+6) then
                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
              else
                if (Pos('0255', sPhone)=1)and(Length(sPhone)=Length('0255')+6) then
                  cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                else
                  if (Pos('00255', sPhone)=1)and(Length(sPhone)=Length('00255')+6) then
                    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                  else
                    if (Pos('375256', sPhone)=1)and(Length(sPhone)=Length('375256')+6) then // ���������� ����� ��������� ����
                      cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                    else
                      if (Pos('80256', sPhone)=1)and(Length(sPhone)=Length('80256')+6) then
                        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                      else
                        if (Pos('0256', sPhone)=1)and(Length(sPhone)=Length('0256')+6) then
                          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                        else
                          if (Pos('00256', sPhone)=1)and(Length(sPhone)=Length('00256')+6) then
                            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                          else
                            if (Pos('375257', sPhone)=1)and(Length(sPhone)=Length('375257')+6) then // ���������� ����� ��������� ����
                              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                            else
                              if (Pos('80257', sPhone)=1)and(Length(sPhone)=Length('80257')+6) then
                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                              else
                                if (Pos('0257', sPhone)=1)and(Length(sPhone)=Length('0257')+6) then
                                  cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                                else
                                  if (Pos('00257', sPhone)=1)and(Length(sPhone)=Length('00257')+6) then
                                    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                                  else
                                    if (Pos('375259', sPhone)=1)and(Length(sPhone)=Length('375259')+6) then // ���������� ����� ��������� ����
                                      cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                                    else
                                      if (Pos('80259', sPhone)=1)and(Length(sPhone)=Length('80259')+6) then
                                        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                                      else
                                        if (Pos('0259', sPhone)=1)and(Length(sPhone)=Length('0259')+6) then
                                          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                                        else
                                          if (Pos('00259', sPhone)=1)and(Length(sPhone)=Length('00259')+6) then
                                            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (life:)/����)')
                                          else
                                            if (Pos('375294', sPhone)=1)and(Length(sPhone)=Length('375294')+6) then // ���������� ����� ��������� ������
                                              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Diallog/������)')
                                            else
                                              if (Pos('80294', sPhone)=1)and(Length(sPhone)=Length('80294')+6) then
                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Diallog/������)')
                                              else
                                                if (Pos('0294', sPhone)=1)and(Length(sPhone)=Length('0294')+6) then
                                                  cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Diallog/������)')
                                                else
                                                  if (Pos('00294', sPhone)=1)and(Length(sPhone)=Length('00294')+6) then
                                                    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Diallog/������)')
                                                  else
                                                    if (Pos('375297', sPhone)=1)and(Length(sPhone)=Length('375297')+6) then // ���������� ����� ��������� ���
                                                      cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                    else
                                                      if (Pos('80297', sPhone)=1)and(Length(sPhone)=Length('80297')+6) then
                                                        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                      else
                                                        if (Pos('0297', sPhone)=1)and(Length(sPhone)=Length('0297')+6) then
                                                          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                        else
                                                          if (Pos('00297', sPhone)=1)and(Length(sPhone)=Length('00297')+6) then
                                                            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                          else
                                                            if (Pos('375295', sPhone)=1)and(Length(sPhone)=Length('375295')+6) then
                                                              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                            else
                                                              if (Pos('80295', sPhone)=1)and(Length(sPhone)=Length('80295')+6) then
                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                              else
                                                                if (Pos('0295', sPhone)=1)and(Length(sPhone)=Length('0295')+6) then
                                                                  cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                else
                                                                  if (Pos('00295', sPhone)=1)and(Length(sPhone)=Length('00295')+6) then
                                                                    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                  else
                                                                    if (Pos('375292', sPhone)=1)and(Length(sPhone)=Length('375292')+6) then
                                                                      cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                    else
                                                                      if (Pos('80292', sPhone)=1)and(Length(sPhone)=Length('80292')+6) then
                                                                        cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                      else
                                                                        if (Pos('0292', sPhone)=1)and(Length(sPhone)=Length('0292')+6) then
                                                                          cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                        else
                                                                          if (Pos('00292', sPhone)=1)and(Length(sPhone)=Length('00292')+6) then
                                                                            cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                          else
                                                                            if (Pos('375298', sPhone)=1)and(Length(sPhone)=Length('375298')+6) then
                                                                              cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                            else
                                                                              if (Pos('80298', sPhone)=1)and(Length(sPhone)=Length('80298')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                              else
                                                                                if (Pos('0298', sPhone)=1)and(Length(sPhone)=Length('0298')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                                else
                                                                                if (Pos('00298', sPhone)=1)and(Length(sPhone)=Length('00298')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                                else
                                                                                if (Pos('37533', sPhone)=1)and(Length(sPhone)=Length('37533')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                                else
                                                                                if (Pos('8033', sPhone)=1)and(Length(sPhone)=Length('8033')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                                else
                                                                                if (Pos('033', sPhone)=1)and(Length(sPhone)=Length('033')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                                else
                                                                                if (Pos('0033', sPhone)=1)and(Length(sPhone)=Length('0033')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (���)')
                                                                                else
                                                                                if (Pos('375296', sPhone)=1)and(Length(sPhone)=Length('375296')+6) then // ���������� ����� ��������� ���
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('80296', sPhone)=1)and(Length(sPhone)=Length('80296')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('0296', sPhone)=1)and(Length(sPhone)=Length('0296')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('00296', sPhone)=1)and(Length(sPhone)=Length('00296')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('375293', sPhone)=1)and(Length(sPhone)=Length('375293')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('80293', sPhone)=1)and(Length(sPhone)=Length('80293')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('0293', sPhone)=1)and(Length(sPhone)=Length('0293')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('00293', sPhone)=1)and(Length(sPhone)=Length('00293')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('375291', sPhone)=1)and(Length(sPhone)=Length('375291')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('80291', sPhone)=1)and(Length(sPhone)=Length('80291')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('0291', sPhone)=1)and(Length(sPhone)=Length('0291')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('00291', sPhone)=1)and(Length(sPhone)=Length('00291')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('375299', sPhone)=1)and(Length(sPhone)=Length('375299')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('80299', sPhone)=1)and(Length(sPhone)=Length('80299')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('0299', sPhone)=1)and(Length(sPhone)=Length('0299')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('00299', sPhone)=1)and(Length(sPhone)=Length('00299')+6) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('37544', sPhone)=1)and(Length(sPhone)=Length('37544')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('8044', sPhone)=1)and(Length(sPhone)=Length('8044')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('044', sPhone)=1)and(Length(sPhone)=Length('044')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                if (Pos('0044', sPhone)=1)and(Length(sPhone)=Length('0044')+7) then
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('��������� (Velcom/���)')
                                                                                else
                                                                                cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf('');
    end
  else
    cmbbxPhoneType.ItemIndex:=cmbbxPhoneType.Items.IndexOf(''); // ���� ������ ������� �� �� ����
end;

procedure TAddEditPhoneForm.edbxPhoneNumberExit(Sender: TObject);
begin
  edbxPhoneNumber.Text:=StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(StringReplace(Trim(edbxPhoneNumber.Text), '  ', ' ', [rfReplaceAll]), // ������� ������� �������
    ' ', '-', [rfReplaceAll]), // �������� ������� �� ����
    '(', '-', [rfReplaceAll]), // �� ������� ������
    ')', '-', [rfReplaceAll]), ' -', '-', [rfReplaceAll]), // ������� �� ��������
    '- ', '-', [rfReplaceAll]), // ������� �� ��������
    '--', '-', [rfReplaceAll]), // ������� �� ������ ����
    '--', '-', [rfReplaceAll]); // ������� �� ������ ����
  if edbxPhoneNumber.Text>'' then // ���� � ������ ��� ����� ������ ������� ����� - �������
    while CharInSet(edbxPhoneNumber.Text[1], ['-', ',', '.']) do
      edbxPhoneNumber.Text:=copy(edbxPhoneNumber.Text, 2, Length(edbxPhoneNumber.Text)-1);
  if edbxPhoneNumber.Text>'' then
    while CharInSet(edbxPhoneNumber.Text[Length(edbxPhoneNumber.Text)], ['-', ',', '.']) do
      edbxPhoneNumber.Text:=copy(edbxPhoneNumber.Text, 1, Length(edbxPhoneNumber.Text)-1);
end;

procedure TAddEditPhoneForm.edbxPhonePriorityChange(Sender: TObject);
begin
  if StrToIntDef(edbxPhonePriority.Text, 0)<0 then
    edbxPhonePriority.Text:='0';
  if StrToIntDef(edbxPhonePriority.Text, 0)>254 then
    edbxPhonePriority.Text:='254';
end;

procedure TAddEditPhoneForm.edbxPhonePriorityEnter(Sender: TObject);
begin
  if StrToIntDef(edbxPhonePriority.Text, -1)=-1 then
    edbxPhonePriority.Text:='0';
end;

procedure TAddEditPhoneForm.edbxPhonePriorityExit(Sender: TObject);
begin
  if StrToIntDef(edbxPhonePriority.Text, -1)=-1 then
    edbxPhonePriority.Text:='0';
end;

procedure TAddEditPhoneForm.edbxPhonePriorityKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key:=#0; // "��������" ��� ��������� �������
end;

procedure TAddEditPhoneForm.mePhoneCommentsExit(Sender: TObject); // ���������-���������� ����� ������ ����� ����� "�����������"
begin
  if MainForm.CurrentUser.bDBEdition then // ���� ������������ ����� ����� �������������� ��
    mePhoneComments.Text:=ValidateString(mePhoneComments.Text); // �� ��������� ��������� �������� ������ ���� ����� "�����������"
end;

end.
