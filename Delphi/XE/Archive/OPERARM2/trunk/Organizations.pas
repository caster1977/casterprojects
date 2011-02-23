unit Organizations;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  Menus,
  Main,
  mysql;

type
  TOrganizationsForm= class(TForm)
    GroupBox1: TGroupBox;
    LABEL_OrgName: TLabel;
    LABEL_OrgType: TLabel;
    COMBOBOX_OrgType: TComboBox;
    EDIT_OrgAddress: TEdit;
    EDIT_OrgHowToReach: TEdit;
    EDIT_OrgPhones: TEdit;
    MEMO_OrgInfo: TMemo;
    LABEL_OrgAddress: TLabel;
    LABEL_OrgHowToReach: TLabel;
    LABEL_OrgPhones: TLabel;
    LABEL_OrgInfo: TLabel;
    BUTTON_Apply: TButton;
    BUTTON_Cancel: TButton;
    BUTTON_Help: TButton;
    Label1: TLabel;
    EDIT_OrgName: TEdit;
    EDIT_OrgRID: TEdit;
    BUTTON_Validate: TButton;

    Label3: TLabel;
    EDIT_OrgLMTS: TEdit;
    procedure EDIT_OrgRIDChange(Sender: TObject);
    procedure EDIT_OrgNameChange(Sender: TObject);
    procedure EDIT_OrgAddressChange(Sender: TObject);
    procedure EDIT_OrgHowToReachChange(Sender: TObject);
    procedure EDIT_OrgPhonesChange(Sender: TObject);
    procedure MEMO_OrgInfoChange(Sender: TObject);
    procedure COMBOBOX_OrgTypeChange(Sender: TObject);
    procedure BUTTON_ApplyClick(Sender: TObject);
    procedure BUTTON_ValidateClick(Sender: TObject);
    procedure COMBOBOX_OrgTypeDropDown(Sender: TObject);
    procedure COMBOBOX_OrgTypeClick(Sender: TObject);
    procedure EDIT_OrgLMTSChange(Sender: TObject);
  end;

var
  OrganizationsForm: TOrganizationsForm;

implementation

{$R *.DFM}

procedure TOrganizationsForm.EDIT_OrgRIDChange(Sender: TObject);
begin
  if EDIT_OrgRID.Text='' then
    EDIT_OrgRID.Color:=clInfoBk
  else
    EDIT_OrgRID.Color:=clWindow;
  BUTTON_Validate.Enabled:=True;
  BUTTON_Apply.Enabled:=False;
  // EDIT_OrgRID.Hint:=EDIT_OrgRID.Text;
end;

procedure TOrganizationsForm.EDIT_OrgNameChange(Sender: TObject);
begin
  if EDIT_OrgName.Text='' then
    EDIT_OrgName.Color:=clInfoBk
  else
    EDIT_OrgName.Color:=clWindow;
  BUTTON_Validate.Enabled:=True;
  BUTTON_Apply.Enabled:=False;
  // EDIT_OrgName.Hint:=EDIT_OrgName.Text;
end;

procedure TOrganizationsForm.EDIT_OrgAddressChange(Sender: TObject);
begin
  if EDIT_OrgAddress.Text='' then
    EDIT_OrgAddress.Color:=clInfoBk
  else
    EDIT_OrgAddress.Color:=clWindow;
  BUTTON_Validate.Enabled:=True;
  BUTTON_Apply.Enabled:=False;
  // EDIT_OrgAddress.Hint:=EDIT_OrgAddress.Text;
end;

procedure TOrganizationsForm.EDIT_OrgHowToReachChange(Sender: TObject);
begin
  if EDIT_OrgHowToReach.Text='' then
    EDIT_OrgHowToReach.Color:=clInfoBk
  else
    EDIT_OrgHowToReach.Color:=clWindow;
  BUTTON_Validate.Enabled:=True;
  BUTTON_Apply.Enabled:=False;
  // EDIT_OrgHowToReach.Hint:=EDIT_OrgHowToReach.Text;
end;

procedure TOrganizationsForm.EDIT_OrgPhonesChange(Sender: TObject);
begin
  if EDIT_OrgPhones.Text='' then
    EDIT_OrgPhones.Color:=clInfoBk
  else
    EDIT_OrgPhones.Color:=clWindow;
  BUTTON_Validate.Enabled:=True;
  BUTTON_Apply.Enabled:=False;
  // EDIT_OrgPhones.Hint:=EDIT_OrgPhones.Text;
end;

procedure TOrganizationsForm.MEMO_OrgInfoChange(Sender: TObject);
begin
  if MEMO_OrgInfo.Text='' then
    MEMO_OrgInfo.Color:=clInfoBk
  else
    MEMO_OrgInfo.Color:=clWindow;
  BUTTON_Validate.Enabled:=True;
  BUTTON_Apply.Enabled:=False;
  // MEMO_OrgInfo.Hint:=MEMO_OrgInfo.Text;
end;

procedure TOrganizationsForm.COMBOBOX_OrgTypeChange(Sender: TObject);
begin
  if COMBOBOX_OrgType.Text='' then
    COMBOBOX_OrgType.Color:=clInfoBk
  else
    COMBOBOX_OrgType.Color:=clWindow;
  BUTTON_Validate.Enabled:=True;
  BUTTON_Apply.Enabled:=False;
  // COMBOBOX_OrgType.Hint:=COMBOBOX_OrgType.Text;
end;

procedure TOrganizationsForm.BUTTON_ApplyClick(Sender: TObject);
begin
  {
    if EDIT_OrgName.Text='' then
    begin
    MessageDlg('¬ы должны об€зательно указать наименование организации!',mtWarning,[mbOk],0);
    if EDIT_OrgName.Visible then EDIT_OrgName.SetFocus;
    end
    else
    if (COMBOBOX_OrgType.Text='') then
    begin
    MessageDlg('¬ы должны об€зательно указать (либо выбрать из списка) тип организации!',mtWarning,[mbOk],0);
    if COMBOBOX_OrgType.Visible then COMBOBOX_OrgType.SetFocus;
    end;
    if (EDIT_OrgName.Text<>'') and (COMBOBOX_OrgType.Text<>'') then
    }
  ModalResult:=mrOk;
end;

procedure TOrganizationsForm.BUTTON_ValidateClick(Sender: TObject);
begin
  COMBOBOX_OrgType.Text:=MainForm.ValidateString(COMBOBOX_OrgType.Text);
  EDIT_OrgName.Text:=MainForm.ValidateString(EDIT_OrgName.Text);
  EDIT_OrgAddress.Text:=MainForm.ValidateString(EDIT_OrgAddress.Text);
  EDIT_OrgHowToReach.Text:=MainForm.ValidateString(EDIT_OrgHowToReach.Text);
  EDIT_OrgPhones.Text:=MainForm.ValidateString(EDIT_OrgPhones.Text);
  MEMO_OrgInfo.Text:=MainForm.ValidateString(MEMO_OrgInfo.Text);
  BUTTON_Validate.Enabled:=False;
  BUTTON_Apply.Enabled:=True;
  if BUTTON_Apply.Visible then
    BUTTON_Apply.SetFocus;
end;

procedure TOrganizationsForm.COMBOBOX_OrgTypeDropDown(Sender: TObject);
var
  q, s, s1: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  i: integer;
begin
  if COMBOBOX_OrgType.Text<>'' then
    q:='SELECT organizationtype FROM organizationtypes WHERE UCASE(organizationtype) LIKE UCASE('+#39+'%'+COMBOBOX_OrgType.Text+'%'+#39+');'
  else
    q:='SELECT organizationtype FROM organizationtypes;';
  if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            if (MessageDlg('Ќе удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES! ѕродолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrgType.Text;
            COMBOBOX_OrgType.Clear;
            for i:=0 to mysql_num_rows(ResultSet)-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                COMBOBOX_OrgType.Items.Append(s);
              end;
            COMBOBOX_OrgType.ItemIndex:=COMBOBOX_OrgType.Items.IndexOf(s1);
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
  if COMBOBOX_OrgType.Text='' then
    COMBOBOX_OrgType.Color:=clInfoBk
  else
    COMBOBOX_OrgType.Color:=clWindow;
  // COMBOBOX_OrgType.Hint:=COMBOBOX_OrgType.Text;
end;

procedure TOrganizationsForm.COMBOBOX_OrgTypeClick(Sender: TObject);
begin
  if COMBOBOX_OrgType.Text='' then
    COMBOBOX_OrgType.Color:=clInfoBk
  else
    COMBOBOX_OrgType.Color:=clWindow;
  // COMBOBOX_OrgType.Hint:=COMBOBOX_OrgType.Text;
end;

procedure TOrganizationsForm.EDIT_OrgLMTSChange(Sender: TObject);
begin
  if EDIT_OrgLMTS.Text='' then
    EDIT_OrgLMTS.Color:=clInfoBk
  else
    EDIT_OrgLMTS.Color:=clWindow;
  EDIT_OrgLMTS.Enabled:=True;
  EDIT_OrgLMTS.Enabled:=False;
  // EDIT_OrgLMTS.Hint:=EDIT_OrgLMTS.Text;
end;

end.
