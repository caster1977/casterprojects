unit OA5.uTReportForm;

interface

uses
  CastersPackage.uTPositionedLogForm,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.CheckLst,
  Vcl.ExtCtrls;

type
  TReportForm = class(TPositionedLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actSelectAll: TAction;
    actSelectNone: TAction;
    actCreate: TAction;
    actClose: TAction;
    actHelp: TAction;
    pnlLeft: TPanel;
    pnlUsers: TPanel;
    lblChooseUsers: TLabel;
    btnSelectAll: TButton;
    btnSelectNone: TButton;
    chklbxUsers: TCheckListBox;
    pnlRight: TPanel;
    gbPeriod: TGroupBox;
    rbChoisenDate: TRadioButton;
    dtpChoisenDate: TDateTimePicker;
    rbChoisenMonth: TRadioButton;
    cbChoisenMonth_Month: TComboBox;
    cbChoisenMonth_Year: TComboBox;
    rbChoisenQuarter: TRadioButton;
    cbChoisenQuarter_Quarter: TComboBox;
    cbChoisenQuarter_Year: TComboBox;
    rbChoisenYear: TRadioButton;
    cbChoisenYear: TComboBox;
    rbChoisenPeriod: TRadioButton;
    dtpChoisenPeriod_Start: TDateTimePicker;
    dtpChoisenPeriod_Stop: TDateTimePicker;
    gbGroupBy: TGroupBox;
    lblBy: TLabel;
    cmbbxGroupByPeriod: TComboBox;
    gbAdditional: TGroupBox;
    chkbxDetailed: TCheckBox;
    chkbxShowSQLQueries: TCheckBox;
    chkbxShowIdleUsers: TCheckBox;
    chkbxWeekStartsFromDayOfBeginning: TCheckBox;
    pnlButtons: TPanel;
    btnCreate: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actSelectNoneExecute(Sender: TObject);
    procedure actCreateExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkbxDetailedClick(Sender: TObject);
    procedure chklbxUsersClickCheck(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
    procedure actSelectAllUpdate(Sender: TObject);
    procedure actSelectNoneUpdate(Sender: TObject);
    procedure actCreateUpdate(Sender: TObject);
  strict private
    АLastDate: TDate;
    FLastWeekStart: TDate;
    FLastWeekStop: TDate;
    FLastMonthStart: TDate;
    FLastMonthStop: TDate;
    FLastMonth_Month: Word;
    FLastMonth_Year: Word;
    FLastQuarterStart: TDate;
    FLastQuarterStop: TDate;
    FLastQuarter_Quarter: Word;
    FLastQuarter_Year: Word;
    FLastYearStart: TDate;
    FLastYearStop: TDate;
    FLastYear: Word;
    procedure _Create;
    procedure _Close;
    procedure _Help;
    procedure _SelectAll;
    procedure _SelectNone;
    procedure _UpdateLastDates;
    procedure _SwitchDetailed;
  end;

implementation

{$R *.dfm}

uses
  Vcl.Forms,
  CastersPackage.uTLogForm,
  System.SysUtils,
  System.DateUtils,
  CastersPackage.uRoutines,
  OA5.uMainForm;

const
  ICON_STATISTIC = 0;

resourcestring
  RsReportForm = 'формирования статистических отчётов по работе пользователей';

procedure TReportForm.actSelectAllExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actSelectAll.Caption]),
    '{14A91B39-D3D7-49C4-9F19-D253DE7AB611}');
  _SelectAll;
  ProcedureFooter;
end;

procedure TReportForm.actSelectAllUpdate(Sender: TObject);
var
  b: Boolean;
  i: Integer;
begin
  b := False;
  for i := 0 to chklbxUsers.Items.Count - 1 do
  begin
    if not chklbxUsers.Checked[i] then
    begin
      b := True;
      Break;
    end;
  end;
  b := (chklbxUsers.Items.Count > 0) and b;
  if actSelectAll.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actSelectAll.Caption]),
      '{71FE28EC-CC3B-4E72-978D-F534FFD2E2C7}');
    actSelectAll.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actSelectAll));
    ProcedureFooter;
  end;
end;

procedure TReportForm.actSelectNoneExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actSelectNone.Caption]),
    '{2E28DFC0-7D3C-4E6E-B105-CFEC8B796E11}');
  _SelectNone;
  ProcedureFooter;
end;

procedure TReportForm.actSelectNoneUpdate(Sender: TObject);
var
  b: Boolean;
  i: Integer;
begin
  b := False;
  for i := 0 to chklbxUsers.Items.Count - 1 do
  begin
    if chklbxUsers.Checked[i] then
    begin
      b := True;
      Break;
    end;
  end;
  b := (chklbxUsers.Items.Count > 0) and b;
  if actSelectNone.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actSelectNone.Caption]),
      '{CFD84C36-9A02-46E0-B166-8E79EE356622}');
    actSelectNone.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actSelectNone));
    ProcedureFooter;
  end;
end;

procedure TReportForm.chkbxDetailedClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "' + chkbxDetailed.Caption + '"',
    '{8A3559CE-76D8-4EEC-95A0-06D5BA525295}');
  _SwitchDetailed;
  ProcedureFooter;
end;

procedure TReportForm.chklbxUsersClickCheck(Sender: TObject);
begin
  (* ProcedureHeader('Процедура реакции на пеметку/снятие пометки чекбокса в списке пользователей',
    '{ABB897ED-01E2-42F0-B85F-DFF2467830A9}');
    _UpdateActions;
    ProcedureFooter; *)
end;

procedure TReportForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{D290B7F6-9D16-47E1-90F0-FEAAB5120E56}');
  _Close;
  ProcedureFooter;
end;

procedure TReportForm.actCreateExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actCreate.Caption]), '{C4CEAC65-3699-4660-871E-12985753ECBB}');
  _Create;
  ProcedureFooter;
end;

procedure TReportForm.actCreateUpdate(Sender: TObject);
var
  i: Integer;
  b: Boolean;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{C46D65CB-16C9-4200-8F05-DBA4AE839B73}');

  b := False;
  for i := 0 to chklbxUsers.Count - 1 do
  begin
    b := b or chklbxUsers.Checked[i];
  end;
  b := b and (rbChoisenDate.Checked or rbChoisenMonth.Checked or rbChoisenQuarter.Checked or rbChoisenYear.Checked or
    rbChoisenPeriod.Checked) and (cmbbxGroupByPeriod.ItemIndex > -1);
  if actCreate.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actCreate.Caption]),
      '{42F1CD4C-614D-40B7-BD9F-A64CA7C1ABD6}');
    actCreate.Enabled := b;
    if btnCreate.Default <> b then
    begin
      btnCreate.Default := b;
    end;
    if btnClose.Default <> (not b) then
    begin
      btnClose.Default := not b;
    end;
    ProcedureFooter;
  end;
end;

procedure TReportForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{4A44C954-EC7F-4C4F-8C87-B9B19B83AA8B}');
  _Help;
  ProcedureFooter;
end;

procedure TReportForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{876209CD-9450-437C-BECD-39568ECD2FC0}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

procedure TReportForm._Create;
begin
  ProcedureHeader(Format(RsCloseModalWithOkProcedure, [RsReportForm]), '{4B55786C-4198-48B1-8F00-56DBD8D6736A}');
  ModalResult := mrOk;
  Log.SendInfo('Попытка формирования статистического отчёта по работе пользователей была подтверждена пользователем.');
  Log.SendInfo(Format(RsWindowClosedByUser, [RsReportForm]));
  ProcedureFooter;
end;

procedure TReportForm._Close;
begin
  ProcedureHeader(Format(RsCloseModalWithCancelProcedure, [RsReportForm]), '{95ED87E6-F0C7-48B0-9108-4B59EDC3B329}');

  ModalResult := mrCancel;
  Log.SendInfo('Попытка формирования статистических отчётов по работе пользователей была отменена пользователем.');
  Log.SendInfo(Format(RsWindowClosedByUser, [RsReportForm]));

  ProcedureFooter;
end;

procedure TReportForm._Help;
begin
  ProcedureHeader(RsContextHelpProcedure, '{CCEFD9CE-4903-4688-85C9-239F10B3C6A3}');

  Log.SendInfo(RsTryingToOpenHelpFile);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    GenerateError(RsHelpFileNonFound);
  end;

  ProcedureFooter;
end;

procedure TReportForm._SelectAll;
var
  i: Integer;
begin
  ProcedureHeader('Процедура выделения всех элементов спика пользователей', '{40DE70C8-A47D-441A-93A4-A142CA28214E}');

  for i := 0 to chklbxUsers.Count - 1 do
  begin
    chklbxUsers.Checked[i] := True;
  end;

  ProcedureFooter;
end;

procedure TReportForm._SelectNone;
var
  i: Integer;
begin
  ProcedureHeader('Процедура снятия выделения со всех элементов спика пользователей',
    '{40DE70C8-A47D-441A-93A4-A142CA28214E}');

  for i := 0 to chklbxUsers.Count - 1 do
  begin
    chklbxUsers.Checked[i] := False;
  end;

  ProcedureFooter;
end;

procedure TReportForm._UpdateLastDates;
var
  dtNow: TDateTime;
  dtDayDuration: TDateTime;
  Day, Month, Year: Word;
begin
  ProcedureHeader('Процедура обновления значений "предыдущих" дат', '{27348EBC-CC42-4754-B611-206BB1DA553F}');

  dtNow := Now;
  DecodeDate(dtNow, Year, Month, Day);

  dtDayDuration := EncodeDate(2008, 1, 3) - EncodeDate(2008, 1, 2);

  АLastDate := dtNow - dtDayDuration;

  FLastWeekStart := StartOfTheWeek(StartOfTheWeek(dtNow) - dtDayDuration);
  FLastWeekStop := EndOfTheWeek(StartOfTheWeek(dtNow) - dtDayDuration);

  FLastMonthStart := StartOfTheMonth(StartOfTheMonth(dtNow) - dtDayDuration);
  FLastMonthStop := EndOfTheMonth(StartOfTheMonth(dtNow) - dtDayDuration);
  DecodeDate(FLastMonthStart, FLastMonth_Year, FLastMonth_Month, Day);

  case Month of
    1 .. 3:
      begin
        FLastQuarter_Quarter := 4;
        FLastQuarter_Year := Year - 1;
        FLastQuarterStart := EncodeDate(FLastQuarter_Year, 10, 1);
        FLastQuarterStop := EncodeDate(FLastQuarter_Year, 12, 31);
      end;
    4 .. 6:
      begin
        FLastQuarter_Quarter := 1;
        FLastQuarter_Year := Year;
        FLastQuarterStart := EncodeDate(FLastQuarter_Year, 1, 1);
        FLastQuarterStop := EncodeDate(FLastQuarter_Year, 3, 31);
      end;
    7 .. 9:
      begin
        FLastQuarter_Quarter := 2;
        FLastQuarter_Year := Year;
        FLastQuarterStart := EncodeDate(FLastQuarter_Year, 4, 1);
        FLastQuarterStop := EncodeDate(FLastQuarter_Year, 6, 30);
      end;
    10 .. 12:
      begin
        FLastQuarter_Quarter := 3;
        FLastQuarter_Year := Year;
        FLastQuarterStart := EncodeDate(FLastQuarter_Year, 7, 1);
        FLastQuarterStop := EncodeDate(FLastQuarter_Year, 9, 30);
      end;
  end;

  FLastYearStart := StartOfTheYear(StartOfTheYear(dtNow) - dtDayDuration);
  FLastYearStop := EndOfTheYear(StartOfTheYear(dtNow) - dtDayDuration);
  DecodeDate(FLastYearStart, FLastYear, Month, Day);

  ProcedureFooter;
end;

procedure TReportForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsReportForm]),  '{84933C2E-2797-40EF-96C1-0E13F61295CD}');

  ImageList.GetIcon(ICON_STATISTIC, Icon);
  with MainForm.Configuration do
  begin
    // установка параметров протоколирования в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;
  end;
  _UpdateLastDates;
  ProcedureFooter;
end;

procedure TReportForm.FormShow(Sender: TObject);
var
  i: Integer;
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsReportForm]), '{021C76A7-4D4B-482B-8DFA-1F9923F7899A}');

  // заполнение списков годов
  // данные В АРХИВАХ есть начиная с 2008 года!!!
  with cbChoisenMonth_Year do
  begin
    Clear;
    for i := 2008 to FLastMonth_Year do
    begin
      Items.Append(IntToStr(i));
    end;
  end;

  with cbChoisenQuarter_Year do
  begin
    Clear;
    for i := 2008 to FLastQuarter_Year do
    begin
      Items.Append(IntToStr(i));
    end;
  end;

  with cbChoisenYear do
  begin
    Clear;
    for i := 2008 to FLastYear do
    begin
      Items.Append(IntToStr(i));
    end;
  end;

  dtpChoisenDate.DateTime := АLastDate;
  cbChoisenMonth_Month.ItemIndex := FLastMonth_Month - 1;
  cbChoisenMonth_Year.ItemIndex := cbChoisenMonth_Year.Items.IndexOf(IntToStr(FLastMonth_Year));

  cbChoisenQuarter_Quarter.ItemIndex := FLastQuarter_Quarter - 1;
  cbChoisenQuarter_Year.ItemIndex := cbChoisenQuarter_Year.Items.IndexOf(IntToStr(FLastQuarter_Year));

  cbChoisenYear.ItemIndex := cbChoisenYear.Items.IndexOf(IntToStr(FLastYear));

  dtpChoisenPeriod_Start.DateTime := АLastDate;
  dtpChoisenPeriod_Stop.DateTime := АLastDate;

  rbChoisenMonth.Checked := rbChoisenMonth.Enabled;
  chkbxShowSQLQueries.Enabled := chkbxDetailed.Enabled and chkbxDetailed.Checked;

  Log.SendInfo(Format(RsWindowShowed, [RsReportForm]));

  ProcedureFooter;
end;

procedure TReportForm._SwitchDetailed;
var
  b: Boolean;
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "' + chkbxShowSQLQueries.Caption + '"',
    '{EBD05A59-B466-47D6-8E79-930DA5F4B713}');

  b := chkbxDetailed.Checked;
  chkbxShowSQLQueries.Enabled := b;
  if not b then
    chkbxShowSQLQueries.Checked := False;
  Log.SendDebug('Флажок "' + chkbxDetailed.Caption + '" ' + Routines.GetConditionalString(b, 'в', 'от') + 'ключен.');

  ProcedureFooter;
end;

end.
