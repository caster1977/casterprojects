unit uReportForm;

interface

uses
  ActnList,
  ActnMan,
  CheckLst,
  Classes,
  ComCtrls,
  Controls,
  ExtCtrls,
  Forms,
  ImgList,
  PlatformDefaultStyleActnCtrls,
  StdCtrls,
  uLogProvider,
  Windows;

type
  TReportForm=class(TForm)
    Panel1: TPanel;
    chklbxUsers: TCheckListBox;
    lbChooseUsers: TLabel;
    btnSelectNone: TButton;
    btnSelectAll: TButton;
    Panel2: TPanel;
    Bevel1: TBevel;
    btnClose: TButton;
    btnHelp: TButton;
    btnCreate: TButton;
    GroupBox1: TGroupBox;
    rbChoisenDate: TRadioButton;
    rbChoisenMonth: TRadioButton;
    rbChoisenQuarter: TRadioButton;
    rbChoisenYear: TRadioButton;
    rbChoisenPeriod: TRadioButton;
    GroupBox2: TGroupBox;
    rbGroupByHours: TRadioButton;
    rbGroupByDays: TRadioButton;
    rbGroupByWeeks: TRadioButton;
    rbGroupByMonths: TRadioButton;
    rbGroupByQuarters: TRadioButton;
    rbGroupByYears: TRadioButton;
    cbChoisenMonth_Month: TComboBox;
    cbChoisenMonth_Year: TComboBox;
    dtpChoisenDate: TDateTimePicker;
    cbChoisenQuarter_Quarter: TComboBox;
    cbChoisenQuarter_Year: TComboBox;
    cbChoisenYear: TComboBox;
    dtpChoisenPeriod_Start: TDateTimePicker;
    dtpChoisenPeriod_Stop: TDateTimePicker;
    GroupBox3: TGroupBox;
    chkbxDetailed: TCheckBox;
    chkbxShowSQLQueries: TCheckBox;
    chkbxShowIdleUsers: TCheckBox;
    chkbxWeekStartsFromDayOfBeginning: TCheckBox;
    ilStatisticFormSmallImages: TImageList;
    Log: TLogProvider;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_SelectAll: TAction;
    Action_SelectNone: TAction;
    Action_Close: TAction;
    Action_Create: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_SelectAllExecute(Sender: TObject);
    procedure Action_SelectNoneExecute(Sender: TObject);
    procedure Action_CreateExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure chkbxDetailedClick(Sender: TObject);
  strict private
    dtLastDate: TDate;

    dtLastWeekStart, dtLastWeekStop: TDate;

    dtLastMonthStart, dtLastMonthStop: TDate;
    wLastMonth_Month, wLastMonth_Year: word;

    dtLastQuarterStart, dtLastQuarterStop: TDate;
    wLastQuarter_Quarter, wLastQuarter_Year: word;

    dtLastYearStart, dtLastYearStop: TDate;
    wLastYear: word;

    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure ProcedureFooter;
    procedure Do_Create;
    procedure Do_Close;
    procedure Do_Help;
    procedure Do_SelectAll;
    procedure Do_SelectNone;
    procedure Do_UpdateLastDates;
    procedure Do_UpdateActions;
    procedure Do_SwitchDetailed;
  end;

implementation

{$R *.dfm}

uses
  SysUtils,
  DateUtils,
  uRoutines,
  uMainForm;

procedure TReportForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TReportForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TReportForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TReportForm.Action_SelectAllExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_SelectAll.Caption+'"', '{14A91B39-D3D7-49C4-9F19-D253DE7AB611}');
  Do_SelectAll;
  ProcedureFooter;
end;

procedure TReportForm.Action_SelectNoneExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_SelectNone.Caption+'"', '{2E28DFC0-7D3C-4E6E-B105-CFEC8B796E11}');
  Do_SelectNone;
  ProcedureFooter;
end;

procedure TReportForm.chkbxDetailedClick(Sender: TObject);
begin
  ProcedureHeader('Процедура отклика на щелчок на флажке "'+chkbxDetailed.Caption+'"', '{8A3559CE-76D8-4EEC-95A0-06D5BA525295}');
  Do_SwitchDetailed;
  ProcedureFooter;
end;

procedure TReportForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{D290B7F6-9D16-47E1-90F0-FEAAB5120E56}');
  Do_Close;
  ProcedureFooter;
end;

procedure TReportForm.Action_CreateExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Create.Caption+'"', '{C4CEAC65-3699-4660-871E-12985753ECBB}');
  Do_Create;
  ProcedureFooter;
end;

procedure TReportForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{EA5978B9-4365-4889-B596-01C327D07D72}');
  Do_Help;
  ProcedureFooter;
end;

procedure TReportForm.Do_Create;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{4B55786C-4198-48B1-8F00-56DBD8D6736A}');
  ModalResult:=mrOk;
  Log.SendInfo('Попытка формирования статистического отчёта по работе пользователей была подтверждена пользователем.');
  Log.SendInfo('Окно формирования статистических отчётов по работе пользователей закрыто.');
  ProcedureFooter;
end;

procedure TReportForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{95ED87E6-F0C7-48B0-9108-4B59EDC3B329}');

  ModalResult:=mrClose;
  Log.SendInfo('Попытка формирования статистических отчётов по работе пользователей была отменена пользователем.');
  Log.SendInfo('Окно формирования статистических отчётов по работе пользователей закрыто.');

  ProcedureFooter;
end;

procedure TReportForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{5CAE68D5-AECE-492A-8CA8-7A802E28F93B}');
  bError:=False;

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TReportForm.Do_SelectAll;
var
  i: integer;
begin
  ProcedureHeader('Процедура выделения всех элементов спика пользователей', '{40DE70C8-A47D-441A-93A4-A142CA28214E}');

  for i:=0 to chklbxUsers.Count-1 do
    chklbxUsers.Checked[i]:=True;
  Do_UpdateActions;

  ProcedureFooter;
end;

procedure TReportForm.Do_SelectNone;
var
  i: integer;
begin
  ProcedureHeader('Процедура снятия выделения со всех элементов спика пользователей', '{40DE70C8-A47D-441A-93A4-A142CA28214E}');

  for i:=0 to chklbxUsers.Count-1 do
    chklbxUsers.Checked[i]:=False;
  Do_UpdateActions;

  ProcedureFooter;
end;

procedure TReportForm.Do_UpdateLastDates;
var
  dtNow: TDateTime;
  dtDayDuration: TDateTime;
  Day, Month, Year: word;
begin
  ProcedureHeader('Процедура обновления значений "предыдущих" дат', '{27348EBC-CC42-4754-B611-206BB1DA553F}');

  dtNow:=Now;
  DecodeDate(dtNow, Year, Month, Day);

  dtDayDuration:=EncodeDate(2008, 1, 3)-EncodeDate(2008, 1, 2);

  dtLastDate:=dtNow-dtDayDuration;

  dtLastWeekStart:=StartOfTheWeek(StartOfTheWeek(dtNow)-dtDayDuration);
  dtLastWeekStop:=EndOfTheWeek(StartOfTheWeek(dtNow)-dtDayDuration);

  dtLastMonthStart:=StartOfTheMonth(StartOfTheMonth(dtNow)-dtDayDuration);
  dtLastMonthStop:=EndOfTheMonth(StartOfTheMonth(dtNow)-dtDayDuration);
  DecodeDate(dtLastMonthStart, wLastMonth_Year, wLastMonth_Month, Day);

  case Month of
    1..3:
      begin
        wLastQuarter_Quarter:=4;
        wLastQuarter_Year:=Year-1;
        dtLastQuarterStart:=EncodeDate(wLastQuarter_Year, 10, 1);
        dtLastQuarterStop:=EncodeDate(wLastQuarter_Year, 12, 31);
      end;
    4..6:
      begin
        wLastQuarter_Quarter:=1;
        wLastQuarter_Year:=Year;
        dtLastQuarterStart:=EncodeDate(wLastQuarter_Year, 1, 1);
        dtLastQuarterStop:=EncodeDate(wLastQuarter_Year, 3, 31);
      end;
    7..9:
      begin
        wLastQuarter_Quarter:=2;
        wLastQuarter_Year:=Year;
        dtLastQuarterStart:=EncodeDate(wLastQuarter_Year, 4, 1);
        dtLastQuarterStop:=EncodeDate(wLastQuarter_Year, 6, 30);
      end;
    10..12:
      begin
        wLastQuarter_Quarter:=3;
        wLastQuarter_Year:=Year;
        dtLastQuarterStart:=EncodeDate(wLastQuarter_Year, 7, 1);
        dtLastQuarterStop:=EncodeDate(wLastQuarter_Year, 9, 30);
      end;
  end;

  dtLastYearStart:=StartOfTheYear(StartOfTheYear(dtNow)-dtDayDuration);
  dtLastYearStop:=EndOfTheYear(StartOfTheYear(dtNow)-dtDayDuration);
  DecodeDate(dtLastYearStart, wLastYear, Month, Day);

  ProcedureFooter;
end;

procedure TReportForm.FormCreate(Sender: TObject);
const
  ICON_STATISTIC=0;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{84933C2E-2797-40EF-96C1-0E13F61295CD}');

  ilStatisticFormSmallImages.GetIcon(ICON_STATISTIC, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('Действие "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, 'в', 'от')+'ключено.');

  with MainForm.Configuration do
    begin
      // установка параметров протоколирования в соответствии с настройками программы
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // установка положения окна конфигурации в соответсвии со значениями конфигурации программы
      if ReportFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if ReportFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if ReportFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=ReportFormPosition.x;
          if ReportFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if ReportFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=ReportFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TReportForm.FormShow(Sender: TObject);
var
  i: integer;
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{021C76A7-4D4B-482B-8DFA-1F9923F7899A}');

  Do_UpdateLastDates;

  // заполнение списков годов
  // данные В АРХИВАХ есть начиная с 2008 года!!!
  with cbChoisenMonth_Year do
    begin
      Clear;
      for i:=2008 to wLastMonth_Year do
        Items.Append(IntToStr(i));
    end;

  with cbChoisenQuarter_Year do
    begin
      Clear;
      for i:=2008 to wLastQuarter_Year do
        Items.Append(IntToStr(i));
    end;

  with cbChoisenYear do
    begin
      Clear;
      for i:=2008 to wLastYear do
        Items.Append(IntToStr(i));
    end;

  dtpChoisenDate.DateTime:=dtLastDate;
  cbChoisenMonth_Month.ItemIndex:=wLastMonth_Month-1;
  cbChoisenMonth_Year.ItemIndex:=cbChoisenMonth_Year.Items.IndexOf(IntToStr(wLastMonth_Year));

  cbChoisenQuarter_Quarter.ItemIndex:=wLastQuarter_Quarter-1;
  cbChoisenQuarter_Year.ItemIndex:=cbChoisenQuarter_Year.Items.IndexOf(IntToStr(wLastQuarter_Year));

  cbChoisenYear.ItemIndex:=cbChoisenYear.Items.IndexOf(IntToStr(wLastYear));

  dtpChoisenPeriod_Start.DateTime:=dtLastDate;
  dtpChoisenPeriod_Stop.DateTime:=dtLastDate;

  rbChoisenMonth.Checked:=rbChoisenMonth.Enabled;
  rbGroupByDays.Checked:=rbGroupByDays.Enabled;
  chkbxShowSQLQueries.Enabled:=chkbxDetailed.Enabled and chkbxDetailed.Checked;

  Do_UpdateActions;

  Log.SendInfo('Отображено окно формирования статистических отчётов по работе пользователей.');

  ProcedureFooter;
end;

procedure TReportForm.Do_UpdateActions;
var
  i: integer;
  b: boolean;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{C46D65CB-16C9-4200-8F05-DBA4AE839B73}');

  b:=False;
  for i:=0 to chklbxUsers.Count-1 do
    b:=b or chklbxUsers.Checked[i];
  Action_Create.Enabled:=(rbChoisenDate.Checked or rbChoisenMonth.Checked or rbChoisenQuarter.Checked or rbChoisenYear.Checked or rbChoisenPeriod.Checked)and
    (rbGroupByHours.Checked or rbGroupByDays.Checked or rbGroupByWeeks.Checked or rbGroupByMonths.Checked or rbGroupByQuarters.Checked or rbGroupByYears.Checked)and b;
  Log.SendDebug('Действие "'+Action_Create.Caption+'" '+Routines.GetConditionalString(Action_Create.Enabled, 'в', 'от')+'ключено.');
  btnClose.Default:=not Action_Create.Enabled;
  btnCreate.Default:=Action_Create.Enabled;

  ProcedureFooter;
end;

procedure TReportForm.Do_SwitchDetailed;
var
  b: boolean;
begin
  ProcedureHeader('Процедура реакции на переключение состояния флажка "'+chkbxShowSQLQueries.Caption+'"', '{EBD05A59-B466-47D6-8E79-930DA5F4B713}');

  b:=chkbxDetailed.Checked;
  chkbxShowSQLQueries.Enabled:=b;
  if not b then
    chkbxShowSQLQueries.Checked:=False;
  Log.SendDebug('Флажок "'+chkbxDetailed.Caption+'" '+Routines.GetConditionalString(b, 'в', 'от')+'ключен.');

  ProcedureFooter;
end;

end.
