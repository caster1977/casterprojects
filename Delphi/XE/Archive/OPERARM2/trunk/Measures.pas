unit Measures;

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
  ComCtrls,
  Main,
  Organizations,
  mysql,
  Menus;

type
  TMeasuresForm= class(TForm)
    GroupBox1: TGroupBox;
    LABEL_MeaRID: TLabel;
    EDIT_MeaRID: TEdit;
    LABEL_OrgType: TLabel;
    COMBOBOX_OrgType: TComboBox;
    LABEL_OrgName: TLabel;
    CHECKBOX_StartDateTime: TCheckBox;
    DATETIMEPICKER_StartDate: TDateTimePicker;
    DATETIMEPICKER_StartTime: TDateTimePicker;
    DATETIMEPICKER_StopTime: TDateTimePicker;
    DATETIMEPICKER_StopDate: TDateTimePicker;
    CHECKBOX_StopDateTime: TCheckBox;
    LABEL_MeaDuration: TLabel;
    DATETIMEPICKER_MeasureDuration: TDateTimePicker;
    CHECKBOX_AutoMeasureDuration: TCheckBox;
    COMBOBOX_OrgName: TComboBox;
    LABEL_MeaType: TLabel;
    LABEL_MeaName: TLabel;
    LABEL_MeaAuthor: TLabel;
    COMBOBOX_MeaAuthor: TComboBox;
    COMBOBOX_MeaType: TComboBox;
    COMBOBOX_MeaName: TComboBox;
    Button_AddNewOrg: TButton;
    LABEL_MeaProducer: TLabel;
    COMBOBOX_MeaProducer: TComboBox;
    LABEL_MeaTicketPrice: TLabel;
    LABEL_MeaOrganizer: TLabel;
    LABEL_MeaPerformer: TLabel;
    MEMO_MeaInfo: TMemo;
    LABEL_MeaInfo: TLabel;
    CHECKBOX_MeaPremier: TCheckBox;
    CHECKBOX_MeaTeenagers: TCheckBox;
    CHECKBOX_MeaChildren: TCheckBox;
    CHECKBOX_AsNew: TCheckBox;
    LABEL_MeaOperator: TLabel;
    EDIT_MeaOperator: TEdit;
    CHECKBOX_MeaInfoAsTemplate: TCheckBox;
    CHECKBOX_MeaOrganizerAsTemplate: TCheckBox;
    CHECKBOX_MeaPerformerAsTemplate: TCheckBox;
    CHECKBOX_MeaTicketPriceAsTemplate: TCheckBox;
    CHECKBOX_MeaProducerAsTemplate: TCheckBox;
    CHECKBOX_MeaAuthorAsTemplate: TCheckBox;
    CHECKBOX_MeaNameAsTemplate: TCheckBox;
    CHECKBOX_MeaTypeAsTemplate: TCheckBox;
    CHECKBOX_OrgNameAsTemplate: TCheckBox;
    CHECKBOX_OrgTypeAsTemplate: TCheckBox;
    BUTTON_Validate: TButton;
    BUTTON_Apply: TButton;
    BUTTON_Cancel: TButton;
    BUTTON_Help: TButton;
    BUTTON_ClearNonChecked: TButton;
    EDIT_MeaOrganizer: TEdit;
    EDIT_MeaPerformer: TEdit;
    MEMO_MeaTicketPrice: TMemo;
    Label3: TLabel;
    EDIT_MeaLMTS: TEdit;
    procedure COMBOBOX_OrgTypeChange(Sender: TObject);
    procedure BUTTON_ValidateClick(Sender: TObject);
    procedure BUTTON_ApplyClick(Sender: TObject);
    procedure CHECKBOX_OrgTypeAsTemplateClick(Sender: TObject);
    procedure CHECKBOX_MeaProducerAsTemplateClick(Sender: TObject);
    procedure CHECKBOX_MeaPerformerAsTemplateClick(Sender: TObject);
    procedure CHECKBOX_MeaOrganizerAsTemplateClick(Sender: TObject);
    procedure CHECKBOX_MeaInfoAsTemplateClick(Sender: TObject);
    procedure CHECKBOX_MeaTicketPriceAsTemplateClick(Sender: TObject);
    procedure CHECKBOX_MeaAuthorAsTemplateClick(Sender: TObject);
    procedure CHECKBOX_MeaNameAsTemplateClick(Sender: TObject);
    procedure CHECKBOX_MeaTypeAsTemplateClick(Sender: TObject);
    procedure CHECKBOX_StartDateTimeClick(Sender: TObject);
    procedure CHECKBOX_StopDateTimeClick(Sender: TObject);
    procedure CHECKBOX_AsNewClick(Sender: TObject);
    procedure DATETIMEPICKER_StartDateChange(Sender: TObject);
    procedure DATETIMEPICKER_StartTimeChange(Sender: TObject);
    procedure COMBOBOX_MeaAuthorDropDown(Sender: TObject);
    procedure COMBOBOX_MeaProducerDropDown(Sender: TObject);
    procedure COMBOBOX_OrgTypeDropDown(Sender: TObject);
    procedure COMBOBOX_OrgNameDropDown(Sender: TObject);
    procedure COMBOBOX_MeaTypeDropDown(Sender: TObject);
    procedure COMBOBOX_MeaNameDropDown(Sender: TObject);
    procedure CHECKBOX_OrgNameAsTemplateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DATETIMEPICKER_StopDateChange(Sender: TObject);
    procedure DATETIMEPICKER_StopTimeChange(Sender: TObject);
    procedure BUTTON_ClearNonCheckedClick(Sender: TObject);
    procedure ChangeTextValue(Sender: TObject);
    procedure Button_AddNewOrgClick(Sender: TObject);
    procedure DATETIMEPICKER_MeasureDurationChange(Sender: TObject);
    procedure EDIT_MeaLMTSChange(Sender: TObject);
  private
    procedure SetToValidate;
  public
    procedure UpdateControlsState;
  end;

var
  MeasuresForm: TMeasuresForm;

implementation

{$R *.DFM}

uses
  Report;

procedure TMeasuresForm.UpdateControlsState;
begin
  if EDIT_MeaRID.Text='' then
    EDIT_MeaRID.Color:=clBtnFace
  else
    EDIT_MeaRID.Color:=clWindow;
  if CHECKBOX_OrgTypeAsTemplate.Checked then
    COMBOBOX_OrgType.Color:=clBtnFace
  else
    if COMBOBOX_OrgType.Text='' then
      COMBOBOX_OrgType.Color:=clInfoBk
    else
      COMBOBOX_OrgType.Color:=clWindow;
  if CHECKBOX_OrgNameAsTemplate.Checked then
    COMBOBOX_OrgName.Color:=clBtnFace
  else
    if COMBOBOX_OrgName.Text='' then
      COMBOBOX_OrgName.Color:=clInfoBk
    else
      COMBOBOX_OrgName.Color:=clWindow;
  if CHECKBOX_MeaTypeAsTemplate.Checked then
    COMBOBOX_MeaType.Color:=clBtnFace
  else
    if COMBOBOX_MeaType.Text='' then
      COMBOBOX_MeaType.Color:=clInfoBk
    else
      COMBOBOX_MeaType.Color:=clWindow;
  if CHECKBOX_MeaNameAsTemplate.Checked then
    COMBOBOX_MeaName.Color:=clBtnFace
  else
    if COMBOBOX_MeaName.Text='' then
      COMBOBOX_MeaName.Color:=clInfoBk
    else
      COMBOBOX_MeaName.Color:=clWindow;
  if CHECKBOX_MeaAuthorAsTemplate.Checked then
    COMBOBOX_MeaAuthor.Color:=clBtnFace
  else
    if COMBOBOX_MeaAuthor.Text='' then
      COMBOBOX_MeaAuthor.Color:=clInfoBk
    else
      COMBOBOX_MeaAuthor.Color:=clWindow;
  if CHECKBOX_MeaProducerAsTemplate.Checked then
    COMBOBOX_MeaProducer.Color:=clBtnFace
  else
    if COMBOBOX_MeaProducer.Text='' then
      COMBOBOX_MeaProducer.Color:=clInfoBk
    else
      COMBOBOX_MeaProducer.Color:=clWindow;
  if CHECKBOX_MeaTicketPriceAsTemplate.Checked then
    MEMO_MeaTicketPrice.Color:=clBtnFace
  else
    if MEMO_MeaTicketPrice.Text='' then
      MEMO_MeaTicketPrice.Color:=clInfoBk
    else
      MEMO_MeaTicketPrice.Color:=clWindow;
  if CHECKBOX_MeaPerformerAsTemplate.Checked then
    EDIT_MeaPerformer.Color:=clBtnFace
  else
    if EDIT_MeaPerformer.Text='' then
      EDIT_MeaPerformer.Color:=clInfoBk
    else
      EDIT_MeaPerformer.Color:=clWindow;
  if CHECKBOX_MeaOrganizerAsTemplate.Checked then
    EDIT_MeaOrganizer.Color:=clBtnFace
  else
    if EDIT_MeaOrganizer.Text='' then
      EDIT_MeaOrganizer.Color:=clInfoBk
    else
      EDIT_MeaOrganizer.Color:=clWindow;
  if CHECKBOX_MeaInfoAsTemplate.Checked then
    MEMO_MeaInfo.Color:=clBtnFace
  else
    if MEMO_MeaInfo.Text='' then
      MEMO_MeaInfo.Color:=clInfoBk
    else
      MEMO_MeaInfo.Color:=clWindow;
  CHECKBOX_OrgTypeAsTemplate.Enabled:=COMBOBOX_OrgType.Text<>'';
  CHECKBOX_OrgNameAsTemplate.Enabled:=COMBOBOX_OrgName.Text<>'';
  CHECKBOX_MeaTypeAsTemplate.Enabled:=COMBOBOX_MeaType.Text<>'';
  CHECKBOX_MeaNameAsTemplate.Enabled:=COMBOBOX_MeaName.Text<>'';
  CHECKBOX_MeaAuthorAsTemplate.Enabled:=COMBOBOX_MeaAuthor.Text<>'';
  CHECKBOX_MeaProducerAsTemplate.Enabled:=COMBOBOX_MeaProducer.Text<>'';
  CHECKBOX_MeaTicketPriceAsTemplate.Enabled:=MEMO_MeaTicketPrice.Text<>'';
  CHECKBOX_MeaPerformerAsTemplate.Enabled:=EDIT_MeaPerformer.Text<>'';
  CHECKBOX_MeaOrganizerAsTemplate.Enabled:=EDIT_MeaOrganizer.Text<>'';
  CHECKBOX_MeaInfoAsTemplate.Enabled:=MEMO_MeaInfo.Text<>'';
  BUTTON_Validate.Enabled:=True;
  BUTTON_Apply.Enabled:=False;
end;

procedure TMeasuresForm.BUTTON_ValidateClick(Sender: TObject);
begin
  (* // данный фрагмент кода удалён из обработки, т.к. вся валидация типа и наименования организации производится на стадии добавления организаций
    s:=MainForm.ValidateString(COMBOBOX_OrgType.Text);
    COMBOBOX_OrgType.Items.Clear;
    COMBOBOX_OrgType.Items.Add(s);
    COMBOBOX_OrgType.ItemIndex:=COMBOBOX_OrgType.Items.IndexOf(s);
    s:=MainForm.ValidateString(COMBOBOX_OrgName.Text);
    COMBOBOX_OrgName.Items.Clear;
    COMBOBOX_OrgName.Items.Add(s);
    COMBOBOX_OrgName.ItemIndex:=COMBOBOX_OrgName.Items.IndexOf(s);
    *)
  COMBOBOX_MeaType.Text:=MainForm.ValidateString(COMBOBOX_MeaType.Text);
  COMBOBOX_MeaName.Text:=MainForm.ValidateString(COMBOBOX_MeaName.Text);
  COMBOBOX_MeaAuthor.Text:=MainForm.ValidateString(COMBOBOX_MeaAuthor.Text);
  COMBOBOX_MeaProducer.Text:=MainForm.ValidateString(COMBOBOX_MeaProducer.Text);
  MEMO_MeaTicketPrice.Text:=MainForm.ValidateString(MEMO_MeaTicketPrice.Text);
  EDIT_MeaPerformer.Text:=MainForm.ValidateString(EDIT_MeaPerformer.Text);
  EDIT_MeaOrganizer.Text:=MainForm.ValidateString(EDIT_MeaOrganizer.Text);
  MEMO_MeaInfo.Text:=MainForm.ValidateString(MEMO_MeaInfo.Text);
  BUTTON_Validate.Enabled:=False;
  BUTTON_Apply.Enabled:=True;
  if BUTTON_Apply.Visible then
    BUTTON_Apply.SetFocus;
end;

procedure TMeasuresForm.BUTTON_ApplyClick(Sender: TObject);
begin
  (*
    if COMBOBOX_MeaType.Text='' then
    begin
    MessageDlg('Вы должны обязательно указать (либо выбрать из списка) тип мероприятия!',mtWarning,[mbOk],0);
    if COMBOBOX_MeaType.Visible then COMBOBOX_MeaType.SetFocus;
    end
    else
    if (COMBOBOX_MeaName.Text='') or (COMBOBOX_MeaName.Text='%') then
    begin
    MessageDlg('Вы должны обязательно указать (либо выбрать из списка) наименование мероприятия!',mtWarning,[mbOk],0);
    if COMBOBOX_MeaName.Visible then COMBOBOX_MeaName.SetFocus;
    end;
    if (COMBOBOX_MeaType.Text<>'') and (COMBOBOX_MeaName.Text<>'') then
    *)
  ModalResult:=mrOk;
end;

procedure TMeasuresForm.SetToValidate;
begin
  BUTTON_Validate.Enabled:=True;
  BUTTON_Apply.Enabled:=False;
end;

procedure TMeasuresForm.COMBOBOX_MeaAuthorDropDown(Sender: TObject);
var
  q, s, s1: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  i: integer;
begin
  if COMBOBOX_MeaAuthor.Text<>'' then
    q:='SELECT measureauthor FROM measureauthors WHERE UCASE(measureauthor) LIKE UCASE('+#39+'%'+COMBOBOX_MeaAuthor.Text+'%'+#39+');'
  else
    q:='SELECT measureauthor FROM measureauthors;';
  if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREAUTHORS! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_MeaAuthor.Text;
            COMBOBOX_MeaAuthor.Items.Clear;
            for i:=0 to mysql_num_rows(ResultSet)-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                COMBOBOX_MeaAuthor.Items.Append(s);
              end;
            COMBOBOX_MeaAuthor.ItemIndex:=COMBOBOX_MeaAuthor.Items.IndexOf(s1);
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
end;

procedure TMeasuresForm.COMBOBOX_MeaProducerDropDown(Sender: TObject);
var
  q, s, s1: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  i: integer;
begin
  if COMBOBOX_MeaProducer.Text<>'' then
    q:='SELECT measureproducer FROM measureproducers WHERE UCASE(measureproducer) like UCASE('+#39+'%'+COMBOBOX_MeaProducer.Text+'%'+#39+');'
  else
    q:='SELECT measureproducer FROM measureproducers;';
  // MessageDlg(q,mtInformation,[mbOk],0);
  if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASUREPRODUCERS! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_MeaProducer.Text;
            COMBOBOX_MeaProducer.Items.Clear;
            for i:=0 to mysql_num_rows(ResultSet)-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                COMBOBOX_MeaProducer.Items.Append(s);
              end;
            COMBOBOX_MeaProducer.ItemIndex:=COMBOBOX_MeaProducer.Items.IndexOf(s1);
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
end;

procedure TMeasuresForm.COMBOBOX_OrgTypeChange(Sender: TObject);
begin
  COMBOBOX_OrgNameDropDown(Self);
  COMBOBOX_MeaTypeDropDown(Self);
  UpdateControlsState;
end;

procedure TMeasuresForm.COMBOBOX_OrgTypeDropDown(Sender: TObject);
var
  q, s, s1: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  i: integer;
begin
  q:='SELECT organizationtype FROM organizationtypes;';
  if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
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
end;

procedure TMeasuresForm.COMBOBOX_OrgNameDropDown(Sender: TObject);
var
  q, s, s1: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  i: integer;
begin
  q:='SELECT organizationname FROM organizationnames LEFT JOIN organizationtypes ON (organizationtypes.id=organizationtypeid) WHERE organizationtype='+#39+COMBOBOX_OrgType.Text+#39+';';
  if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            if (MessageDlg('Не удалось получить результирующую выборку из таблиц ORGANIZATIONTYPES, ORGANIZATIONNAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))
                  +HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_OrgName.Text;
            COMBOBOX_OrgName.Clear;
            for i:=0 to mysql_num_rows(ResultSet)-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                COMBOBOX_OrgName.Items.Append(s);
              end;
            COMBOBOX_OrgName.ItemIndex:=COMBOBOX_OrgName.Items.IndexOf(s1);
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
end;

procedure TMeasuresForm.COMBOBOX_MeaTypeDropDown(Sender: TObject);
var
  q, s, s1: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  i: integer;
begin
  if COMBOBOX_MeaType.Text<>'' then
    q:='SELECT measuretype FROM measuretypes LEFT JOIN organizationtypes ON (organizationtypes.id=measuretypes.organizationtypeid) WHERE organizationtypes.organizationtype='+#39+COMBOBOX_OrgType.Text+#39+' AND UCASE(measuretype) LIKE UCASE('+#39+'%'+
      COMBOBOX_MeaType.Text+'%'+#39+');'
  else
    q:='SELECT measuretype FROM measuretypes LEFT JOIN organizationtypes ON (organizationtypes.id=measuretypes.organizationtypeid) WHERE organizationtypes.organizationtype='+#39+COMBOBOX_OrgType.Text+#39+';';
  if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            if (MessageDlg('Не удалось получить результирующую выборку из таблиц ORGANIZATIONTYPES, MEASURETYPES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))
                  +HR+'MySQL_ErrorNumber: '+IntToStr(mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_MeaType.Text;
            COMBOBOX_MeaType.Items.Clear;
            for i:=0 to mysql_num_rows(ResultSet)-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                COMBOBOX_MeaType.Items.Append(s);
              end;
            COMBOBOX_MeaType.ItemIndex:=COMBOBOX_MeaType.Items.IndexOf(s1);
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
end;

procedure TMeasuresForm.COMBOBOX_MeaNameDropDown(Sender: TObject);
var
  q, s, s1: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  i: integer;
begin
  if COMBOBOX_MeaName.Text<>'' then
    q:='SELECT measurename FROM measurenames WHERE UCASE(measurename) LIKE UCASE('+#39+'%'+COMBOBOX_MeaName.Text+'%'+#39+');'
  else
    q:='SELECT measurename FROM measurenames;';
  if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
    begin
      ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
      try
        if ResultSet=nil then
          begin
            if (MessageDlg('Не удалось получить результирующую выборку из таблицы MEASURENAMES! Продолжать выполнение операции?'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                  (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbYes, mbNo], 0)=mrNo) then
              Exit;
          end
        else
          begin
            s1:=COMBOBOX_MeaName.Text;
            COMBOBOX_MeaName.Items.Clear;
            for i:=0 to mysql_num_rows(ResultSet)-1 do
              begin
                ResultRow:=mysql_fetch_row(ResultSet);
                s:=string(ResultRow[0]);
                COMBOBOX_MeaName.Items.Append(s);
              end;
            COMBOBOX_MeaName.ItemIndex:=COMBOBOX_MeaName.Items.IndexOf(s1);
          end;
      finally
        if ResultSet<>nil then
          mysql_free_result(ResultSet);
      end;
    end;
end;

procedure TMeasuresForm.FormShow(Sender: TObject);
begin
  CHECKBOX_MeaOrganizerAsTemplate.Enabled:=EDIT_MeaOrganizer.Text<>'';
  CHECKBOX_MeaInfoAsTemplate.Enabled:=MEMO_MeaInfo.Text<>'';
end;

procedure TMeasuresForm.CHECKBOX_OrgTypeAsTemplateClick(Sender: TObject);
begin
  if COMBOBOX_OrgType.Text<>'' then
    begin
      COMBOBOX_OrgType.Enabled:=not CHECKBOX_OrgTypeAsTemplate.Checked;
      Button_AddNewOrg.Enabled:=not CHECKBOX_OrgTypeAsTemplate.Checked;
    end;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_OrgNameAsTemplateClick(Sender: TObject);
begin
  if COMBOBOX_OrgName.Text<>'' then
    COMBOBOX_OrgName.Enabled:=not CHECKBOX_OrgNameAsTemplate.Checked;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_MeaTypeAsTemplateClick(Sender: TObject);
begin
  if COMBOBOX_MeaType.Text<>'' then
    COMBOBOX_MeaType.Enabled:=not CHECKBOX_MeaTypeAsTemplate.Checked;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_MeaNameAsTemplateClick(Sender: TObject);
begin
  if COMBOBOX_MeaName.Text<>'' then
    COMBOBOX_MeaName.Enabled:=not CHECKBOX_MeaNameAsTemplate.Checked;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_MeaAuthorAsTemplateClick(Sender: TObject);
begin
  if COMBOBOX_MeaAuthor.Text<>'' then
    COMBOBOX_MeaAuthor.Enabled:=not CHECKBOX_MeaAuthorAsTemplate.Checked;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_MeaProducerAsTemplateClick(Sender: TObject);
begin
  if COMBOBOX_MeaProducer.Text<>'' then
    COMBOBOX_MeaProducer.Enabled:=not CHECKBOX_MeaProducerAsTemplate.Checked;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_StartDateTimeClick(Sender: TObject);
begin
  DATETIMEPICKER_StartDate.Enabled:=CHECKBOX_StartDateTime.Checked;
  DATETIMEPICKER_StartTime.Enabled:=CHECKBOX_StartDateTime.Checked;
  if CHECKBOX_StartDateTime.Checked then
    begin
      DATETIMEPICKER_StartDate.Color:=clWindow;
      DATETIMEPICKER_StartTime.Color:=clWindow;
    end
  else
    begin
      DATETIMEPICKER_StartDate.Color:=clBtnFace;
      DATETIMEPICKER_StartTime.Color:=clBtnFace;
    end;
  SetToValidate;
end;

procedure TMeasuresForm.DATETIMEPICKER_StartDateChange(Sender: TObject);
begin
  DATETIMEPICKER_StartTime.DateTime:=DATETIMEPICKER_StartDate.DateTime;
end;

procedure TMeasuresForm.DATETIMEPICKER_StartTimeChange(Sender: TObject);
begin
  DATETIMEPICKER_StartDate.DateTime:=DATETIMEPICKER_StartTime.DateTime;
end;

procedure TMeasuresForm.CHECKBOX_StopDateTimeClick(Sender: TObject);
begin
  DATETIMEPICKER_StopDate.Enabled:=CHECKBOX_StopDateTime.Checked;
  DATETIMEPICKER_StopTime.Enabled:=CHECKBOX_StopDateTime.Checked;
  if CHECKBOX_StopDateTime.Checked then
    begin
      DATETIMEPICKER_StopDate.Color:=clWindow;
      DATETIMEPICKER_StopTime.Color:=clWindow;
    end
  else
    begin
      DATETIMEPICKER_StopDate.Color:=clBtnFace;
      DATETIMEPICKER_StopTime.Color:=clBtnFace;
    end;
  SetToValidate;
end;

procedure TMeasuresForm.DATETIMEPICKER_StopDateChange(Sender: TObject);
begin
  DATETIMEPICKER_StopTime.DateTime:=DATETIMEPICKER_StopDate.DateTime;
end;

procedure TMeasuresForm.DATETIMEPICKER_StopTimeChange(Sender: TObject);
begin
  DATETIMEPICKER_StopDate.DateTime:=DATETIMEPICKER_StopTime.DateTime;
end;

procedure TMeasuresForm.CHECKBOX_MeaTicketPriceAsTemplateClick(Sender: TObject);
begin
  if MEMO_MeaTicketPrice.Text<>'' then
    MEMO_MeaTicketPrice.Enabled:=not CHECKBOX_MeaTicketPriceAsTemplate.Checked;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_MeaPerformerAsTemplateClick(Sender: TObject);
begin
  if EDIT_MeaPerformer.Text<>'' then
    EDIT_MeaPerformer.Enabled:=not CHECKBOX_MeaPerformerAsTemplate.Checked;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_MeaOrganizerAsTemplateClick(Sender: TObject);
begin
  if EDIT_MeaOrganizer.Text<>'' then
    EDIT_MeaOrganizer.Enabled:=not CHECKBOX_MeaOrganizerAsTemplate.Checked;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_MeaInfoAsTemplateClick(Sender: TObject);
begin
  if MEMO_MeaInfo.Text<>'' then
    MEMO_MeaInfo.Enabled:=not CHECKBOX_MeaInfoAsTemplate.Checked;
  UpdateControlsState;
end;

procedure TMeasuresForm.CHECKBOX_AsNewClick(Sender: TObject);
begin
  CHECKBOX_AsNew.Enabled:=not CHECKBOX_AsNew.Checked;
  Caption:='Добавление информации о новом мероприятии (на основе существующей записи RID '+EDIT_MeaRID.Text+')';
  EDIT_MeaRID.Text:='';
  EDIT_MeaOperator.Text:=MainForm.sUserRealName;
  UpdateControlsState;
  SetToValidate;
end;

procedure TMeasuresForm.BUTTON_ClearNonCheckedClick(Sender: TObject);
begin
  if ((not CHECKBOX_OrgTypeAsTemplate.Checked)and(CHECKBOX_OrgTypeAsTemplate.Enabled)) then
    COMBOBOX_OrgType.Clear;
  if ((not CHECKBOX_OrgNameAsTemplate.Checked)and(CHECKBOX_OrgNameAsTemplate.Enabled)) then
    COMBOBOX_OrgName.Clear;
  if ((not CHECKBOX_MeaNameAsTemplate.Checked)and(CHECKBOX_MeaNameAsTemplate.Enabled)) then
    COMBOBOX_MeaName.Clear;
  if ((not CHECKBOX_MeaTypeAsTemplate.Checked)and(CHECKBOX_MeaTypeAsTemplate.Enabled)) then
    COMBOBOX_MeaType.Clear;
  if ((not CHECKBOX_MeaAuthorAsTemplate.Checked)and(CHECKBOX_MeaAuthorAsTemplate.Enabled)) then
    COMBOBOX_MeaAuthor.Clear;
  if ((not CHECKBOX_MeaProducerAsTemplate.Checked)and(CHECKBOX_MeaProducerAsTemplate.Enabled)) then
    COMBOBOX_MeaProducer.Clear;
  if CHECKBOX_StartDateTime.Enabled then
    CHECKBOX_StartDateTime.Checked:=False;
  if CHECKBOX_StopDateTime.Enabled then
    CHECKBOX_StopDateTime.Checked:=False;
  DATETIMEPICKER_MeasureDuration.Time:=0;
  if ((not CHECKBOX_MeaTicketPriceAsTemplate.Checked)and(CHECKBOX_MeaTicketPriceAsTemplate.Enabled)) then
    MEMO_MeaTicketPrice.Clear;
  if ((not CHECKBOX_MeaPerformerAsTemplate.Checked)and(CHECKBOX_MeaPerformerAsTemplate.Enabled)) then
    EDIT_MeaPerformer.Clear;
  if ((not CHECKBOX_MeaOrganizerAsTemplate.Checked)and(CHECKBOX_MeaOrganizerAsTemplate.Enabled)) then
    EDIT_MeaOrganizer.Clear;
  if ((not CHECKBOX_MeaInfoAsTemplate.Checked)and(CHECKBOX_MeaInfoAsTemplate.Enabled)) then
    MEMO_MeaInfo.Clear;
  if (CHECKBOX_MeaPremier.Enabled and CHECKBOX_MeaPremier.Checked) then
    CHECKBOX_MeaPremier.Checked:=False;
  if (CHECKBOX_MeaTeenagers.Enabled and CHECKBOX_MeaTeenagers.Checked) then
    CHECKBOX_MeaTeenagers.Checked:=False;
  if (CHECKBOX_MeaChildren.Enabled and CHECKBOX_MeaChildren.Checked) then
    CHECKBOX_MeaChildren.Checked:=False;
  UpdateControlsState;
end;

procedure TMeasuresForm.ChangeTextValue(Sender: TObject);
begin
  UpdateControlsState;
end;

procedure TMeasuresForm.Button_AddNewOrgClick(Sender: TObject);
var
  b: boolean;
  sNewOrgRID, sNewOrgType, sNewOrgName, sNewOrgAddress, sNewOrgHowToReach, sNewOrgPhones, sNewOrgInfo, sNewOrgTypeRID, q, s: string;
  ResultSet: PMYSQL_RES;
  ResultRow: PMYSQL_ROW;
  RF: TReportForm;
  j, k, MaxWidth: integer;
begin
  with TOrganizationsForm.Create(Self) do
    try
      EDIT_OrgRID.Color:=clBtnFace;
      ShowModal;
    finally
      b:=ModalResult=mrOk;
      sNewOrgRID:=EDIT_OrgRID.Text;
      sNewOrgType:=COMBOBOX_OrgType.Text;
      sNewOrgName:=EDIT_OrgName.Text;
      sNewOrgAddress:=EDIT_OrgAddress.Text;
      sNewOrgHowToReach:=EDIT_OrgHowToReach.Text;
      sNewOrgPhones:=EDIT_OrgPhones.Text;
      sNewOrgInfo:=MEMO_OrgInfo.Text;
      Free;
    end;
  if b then
    begin
      // проверка на существование организации с таким же наименованием и типом
      q:=
        'SELECT organizationnames.id, COUNT(*) FROM organizationnames LEFT JOIN organizationtypes ON (organizationtypes.id=organizationnames.organizationtypeid) WHERE organizationtypes.organizationtype='+#39+sNewOrgType+
        #39+' AND organizationnames.organizationname='+#39+sNewOrgName+#39+' GROUP BY '+#39+#39+';';
      // MessageDlg(q,mtInformation,[mbOk],0);
      if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
        begin
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          try
            if ResultSet=nil then
              begin
                MessageDlg('Не удалось получить результирующую выборку из таблиц ORGANIZATIONTYPES, ORGANIZATIONNAMES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                    (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbOk], 0);
                Exit;
              end;
            ResultRow:=mysql_fetch_row(ResultSet);
            if ResultRow<>nil then
              begin
                q:=string(ResultRow[1]);
                s:=string(ResultRow[0]);
              end
            else
              q:='0';
          finally
            if ResultSet<>nil then
              mysql_free_result(ResultSet);
          end;
        end;
      if StrToInt(q)>0 then
        begin
          MessageDlg('Организация с указанным типом и наименованием уже существует! Операция изменения информации об организации отменена.', mtWarning, [mbOk], 0);
          COMBOBOX_OrgType.Clear;
          COMBOBOX_OrgType.ItemIndex:=COMBOBOX_OrgType.Items.Add(sNewOrgType);
          COMBOBOX_OrgName.Clear;
          COMBOBOX_OrgName.ItemIndex:=COMBOBOX_OrgName.Items.Add(sNewOrgName);
          UpdateControlsState;
          Exit;
        end;
      // проверка на существование типа организации
      q:='SELECT organizationtypes.id, COUNT(*) FROM organizationtypes WHERE organizationtypes.organizationtype='+#39+sNewOrgType+#39+' GROUP BY '+#39+#39+';';
      // MessageDlg(q,mtInformation,[mbOk],0);
      if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
        begin
          ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
          try
            if ResultSet=nil then
              begin
                MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                    (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbOk], 0);
                Exit;
              end;
            ResultRow:=mysql_fetch_row(ResultSet);
            if ResultRow<>nil then
              begin
                q:=string(ResultRow[1]);
                s:=string(ResultRow[0]);
              end
            else
              q:='0';
          finally
            if ResultSet<>nil then
              mysql_free_result(ResultSet);
          end;
        end;
      RF:=TReportForm.Create(Self);
      try
        RF.Gauge1.MaxValue:=1;
        RF.StringGrid1.ColWidths[0]:=280;
        RF.StringGrid1.ColWidths[1]:=36;
        RF.Show;
        if StrToInt(q)>0 then
          begin
            // тип организации уже существует
            sNewOrgTypeRID:=s;
          end
        else
          begin
            // создаём новый тип организации
            RF.Gauge1.MaxValue:=2;
            RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Добавление записи в таблицу ORGANIZATIONTYPES...';
            q:='INSERT INTO organizationtypes (id, organizationtype) VALUES (NULL, '+#39+sNewOrgType+#39+');';
            if not MainForm.TryExecuteUpdateQuery(q, MainForm.MySQLConnectionHandler) then
              begin
                RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!';
                if bExitOnError then
                  Exit;
              end
            else
              RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
            RF.Gauge1.AddProgress(1);
            RF.Refresh;
            Application.ProcessMessages;
            RF.StringGrid1.RowCount:=RF.StringGrid1.RowCount+1;
            // получаем id нового номера типа организации
            q:='SELECT organizationtypes.id, COUNT(*) FROM organizationtypes WHERE organizationtypes.organizationtype='+#39+sNewOrgType+#39+' GROUP BY '+#39+#39+';';
            // MessageDlg(q,mtInformation,[mbOk],0);
            if MainForm.TryExecuteSelectQuery(q, MainForm.MySQLConnectionHandler) then
              begin
                ResultSet:=mysql_store_result(MainForm.MySQLConnectionHandler);
                try
                  if ResultSet=nil then
                    begin
                      MessageDlg('Не удалось получить результирующую выборку из таблицы ORGANIZATIONTYPES!'+HR+RN+'MySQL_Error: '+string(mysql_error(MainForm.MySQLConnectionHandler))+HR+'MySQL_ErrorNumber: '+IntToStr
                          (mysql_errno(MainForm.MySQLConnectionHandler)), mtError, [mbOk], 0);
                      Exit;
                    end;
                  ResultRow:=mysql_fetch_row(ResultSet);
                  if ResultRow<>nil then
                    begin
                      q:=string(ResultRow[1]);
                      s:=string(ResultRow[0]);
                    end
                  else
                    q:='0';
                finally
                  if ResultSet<>nil then
                    mysql_free_result(ResultSet);
                end;
              end;
            sNewOrgTypeRID:=s;
          end;
        // непосредственно операция добавления записи
        // шаг 1
        RF.StringGrid1.Cells[0, RF.StringGrid1.RowCount-1]:='Добавление записи в таблицу ORGANIZATIONNAMES...';
        q:='INSERT INTO organizationnames (id, organizationtypeid, organizationname, organizationaddress, organizationhowtoreach, organizationphones, organizationinfo, LMTS) VALUES (NULL, '+#39+sNewOrgTypeRID+#39+', ';
        (* if sNewOrgName='' then q:=q+'NULL, ' else *)
        q:=q+#39+sNewOrgName+#39+', ';
        if sNewOrgAddress='' then
          q:=q+'NULL, '
        else
          q:=q+#39+sNewOrgAddress+#39+', ';
        if sNewOrgHowToReach='' then
          q:=q+'NULL, '
        else
          q:=q+#39+sNewOrgHowToReach+#39+', ';
        if sNewOrgPhones='' then
          q:=q+'NULL, '
        else
          q:=q+#39+sNewOrgPhones+#39+', ';
        // if sNewOrgInfo='' then q:=q+'NULL);' else q:=q+#39+sNewOrgInfo+#39+');';
        if sNewOrgInfo='' then
          q:=q+'NULL, NOW());'
        else
          q:=q+#39+sNewOrgInfo+#39+', NOW());';
        // MessageDlg(q,mtInformation,[mbOk],0);
        if not MainForm.TryExecuteUpdateQuery(q, MainForm.MySQLConnectionHandler) then
          begin
            RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ошибка!';
            if bExitOnError then
              Exit;
          end
        else
          RF.StringGrid1.Cells[1, RF.StringGrid1.RowCount-1]:='Ok.';
        RF.Gauge1.AddProgress(1);
        RF.Refresh;
        Application.ProcessMessages;
      finally
        while RF.Gauge1.Progress<RF.Gauge1.MaxValue do
          RF.Gauge1.AddProgress(1);
        if RF<>nil then
          begin
            RF.Hide;
            with RF.StringGrid1 do
              begin
                for j:=0 to 1 do
                  begin
                    ColWidths[j]:=1;
                    MaxWidth:=1;
                    for k:=0 to RowCount-1 do
                      if MaxWidth<RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5 then
                        MaxWidth:=RF.StringGrid1.Canvas.TextWidth(Cells[j, k])+5;
                    ColWidths[j]:=MaxWidth;
                  end;
                if ColWidths[0]+ColWidths[1]<RF.StringGrid1.Width-4 then
                  ColWidths[0]:=RF.StringGrid1.Width-ColWidths[1]-4;
              end;
            RF.Button1.Enabled:=True;
            COMBOBOX_OrgType.Clear;
            COMBOBOX_OrgType.ItemIndex:=COMBOBOX_OrgType.Items.Add(sNewOrgType);
            COMBOBOX_OrgName.Clear;
            COMBOBOX_OrgName.ItemIndex:=COMBOBOX_OrgName.Items.Add(sNewOrgName);
            UpdateControlsState;
            RF.ShowModal;
            RF.Free;
          end;
      end;
    end;
end;

procedure TMeasuresForm.DATETIMEPICKER_MeasureDurationChange(Sender: TObject);
begin
  (*
    if CHECKBOX_AutoMeasureDuration.Checked then
    if CHECKBOX_StartDateTime.Checked then
    begin
    CHECKBOX_StopDateTime.Checked:=True;
    DATETIMEPICKER_StopDate.DateTime:=DATETIMEPICKER_StartDate.DateTime+DATETIMEPICKER_MeasureDuration.Time;
    DATETIMEPICKER_StopTime.DateTime:=DATETIMEPICKER_StopDate.DateTime;
    end;
    *)
end;

procedure TMeasuresForm.EDIT_MeaLMTSChange(Sender: TObject);
begin
  if EDIT_MeaLMTS.Text='' then
    EDIT_MeaLMTS.Color:=clInfoBk
  else
    EDIT_MeaLMTS.Color:=clWindow;
  EDIT_MeaLMTS.Enabled:=True;
  EDIT_MeaLMTS.Enabled:=False;
  // EDIT_MeaLMTS.Hint:=EDIT_MeaLMTS.Text;
end;

end.
