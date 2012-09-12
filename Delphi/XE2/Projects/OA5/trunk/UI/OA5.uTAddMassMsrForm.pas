unit OA5.uTAddMassMsrForm;

interface

uses
  OA5.uTOA5PositionedLogForm,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TAddMassMsrForm = class(TOA5PositionedLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actAdd: TAction;
    actDelete: TAction;
    actClear: TAction;
    actConfirm: TAction;
    actClose: TAction;
    actHelp: TAction;
    pnlTop: TPanel;
    pnlLeft: TPanel;
    MonthCalendar: TMonthCalendar;
    lblPeriod: TLabel;
    Bevel: TBevel;
    edbxTime: TEdit;
    btnAdd: TButton;
    pnlRight: TPanel;
    lvMsrDateTimeList: TListView;
    btnDelete: TButton;
    btnClear: TButton;
    pnlButtons: TPanel;
    btnAccept: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure actConfirmExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure MonthCalendarClick(Sender: TObject);
    procedure lvMsrDateTimeListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvMsrDateTimeListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure FormShow(Sender: TObject);
    procedure actAddUpdate(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actClearUpdate(Sender: TObject);
    procedure actConfirmUpdate(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
  strict private
    procedure _Confirm;
    procedure _Clear;
    procedure _Help;
    procedure _Add;
    procedure _Delete;
    procedure _Close;
    procedure _UpdateListViewScrollBarVisibility;
    procedure _UpdateSelectedPeriod;
  end;

implementation

{$R *.dfm}

uses
  System.SysUtils,
  CastersPackage.uRoutines,
  OA5.uTMainForm,
  Winapi.Windows,
  CastersPackage.uResourceStrings,
  VCL.Forms;

resourcestring
  RsAddMassMsrForm = 'массового размножения мероприятий';

const
  ICON_ADDMASSMSR = 5;

function Validate_TimeString(const aString: string): string;
var
  s: string;
begin
  s := aString;
  // замена символа табуляции на пробел
  while Pos(#09, s) > 0 do
  begin
    s := StringReplace(s, #09, ' ', [rfReplaceAll]);
  end;
  // замена символа запятой на пробел
  while Pos(',', s) > 0 do
  begin
    s := StringReplace(s, ',', ' ', [rfReplaceAll]);
  end;
  // удаление двойных пробелов
  while Pos('  ', s) > 0 do
  begin
    s := StringReplace(s, '  ', ' ', [rfReplaceAll]);
  end;
  // замена символа "." на ":"
  while Pos('.', s) > 0 do
  begin
    s := StringReplace(s, '.', ':', [rfReplaceAll]);
  end;
  // замена символа "-" на ":"
  while Pos('-', s) > 0 do
  begin
    s := StringReplace(s, '-', ':', [rfReplaceAll]);
  end;
  // замена символа ":"
  s := StringReplace(s, ' :', ':', [rfReplaceAll]);
  s := StringReplace(s, ': ', ':', [rfReplaceAll]);
  // удаление граничных пробелов
  Result := Trim(s);
end;

function IsStringIsTime(const aString: string): Boolean;
var
  b: Boolean;
  aSL: TStringList;
  i: Integer;
  s: string;
  aTime: TTime;
begin
  s := Validate_TimeString(aString);
  b := not(s = EmptyStr); // если строка пуста - возращаем "false"
  if b then
  begin
    aSL := TStringList.Create;
    try
      aSL.Duplicates := dupIgnore;
      aSL.Sorted := True;
      Routines.CutStringByLimiterToStringList(s, aSL, ' ');
      for i := 0 to aSL.Count - 1 do
      begin
        if Length(aSL[i]) <> 5 then // если строка не соответствует формату ЧЧ:ММ - возращаем "false"
        begin
          b := False;
        end
        else
        begin
          aTime := EncodeTime(1, 2, 3, 4);
          b := not(StrToTimeDef(aSL[i] + ':00', aTime) = aTime);
          // если возникает ошибка при преобразовании строки в формат времени - возращаем "false"
        end;
      end;
    finally
      aSL.Free;
    end;
  end;
  Result := b;
end;

procedure TAddMassMsrForm._Add;
var
  aSLDates: TStringList;
  aSLTimes: TStringList;
  i: Integer;
  j: Integer;
  k: Integer;
  s: string;
  b: Boolean;
  aTime: TTime;
  aValidatedTime: TTime;
  aListItem: TListItem;
  dtLengthOfDay: TDateTime;
  dtNextDay: TDateTime;
  wStartYear: word;
  wStartMonth: word;
  wStartDay: word;
  wStopYear: word;
  wStopMonth: word;
  wStopDay: word;
begin
  ProcedureHeader('Процедура добавления указанных сеансов мероприятия в список',
    '{C0AD6CA7-C22C-4694-A1BF-384E624AC64F}');

  edbxTime.Text := Validate_TimeString(edbxTime.Text);
  dtLengthOfDay := EncodeDate(2011, 1, 2) - EncodeDate(2011, 1, 1);
  // в цикле перебираем даты
  // в цикле перебираем элементы списка строк с временем
  // вставляем получившиеся пары дата-время в листвью

  // набиваем список уникальных дат
  if MonthCalendar.EndDate > MonthCalendar.Date then
  begin
    // если дата окончания больше чем дата начала
    DecodeDate(MonthCalendar.Date, wStartYear, wStartMonth, wStartDay);
    DecodeDate(MonthCalendar.EndDate, wStopYear, wStopMonth, wStopDay);
  end
  else
  begin
    // если дата начала больше чем дата окончания
    DecodeDate(MonthCalendar.EndDate, wStartYear, wStartMonth, wStartDay);
    DecodeDate(MonthCalendar.Date, wStopYear, wStopMonth, wStopDay);
  end;

  aSLDates := TStringList.Create;
  try
    aSLDates.Duplicates := dupIgnore;
    aSLDates.Sorted := True;

    dtNextDay := EncodeDate(wStartYear, wStartMonth, wStartDay);
    repeat
      aSLDates.Add(FormatDateTime('dd.mm.yyyy', dtNextDay));
      dtNextDay := dtNextDay + dtLengthOfDay;
    until dtNextDay > EncodeDate(wStopYear, wStopMonth, wStopDay);

    aSLTimes := TStringList.Create;
    try
      aSLTimes.Duplicates := dupIgnore;
      aSLTimes.Sorted := True;
      Routines.CutStringByLimiterToStringList(edbxTime.Text, aSLTimes, ' ');
      // цикл заполнения
      for j := 0 to aSLDates.Count - 1 do
      begin
        for i := 0 to aSLTimes.Count - 1 do
        begin
          if Length(aSLTimes[i]) = 5 then // если строка соответствует формату ЧЧ:ММ
          begin
            aTime := EncodeTime(1, 2, 3, 4);
            s := aSLTimes[i] + ':00';
            aValidatedTime := StrToTimeDef(s, aTime);
            if aValidatedTime <> aTime then // если не возникает ошибка при преобразовании строки в формат времени
            begin
              // проверка на наличие в списке элемента с идентичными данными
              b := True;
              for k := 0 to lvMsrDateTimeList.Items.Count - 1 do
              begin
                if (lvMsrDateTimeList.Items[k].Caption = aSLDates[j]) and
                  (lvMsrDateTimeList.Items[k].SubItems[0] = FormatDateTime('hh:nn:ss', aValidatedTime)) then
                begin
                  b := False;
                end;
              end;
              // если элемент с идентичными данными не был найден в списке - добавляем новый
              if b then
              begin
                aListItem := lvMsrDateTimeList.Items.Add;
                aListItem.SubItems.Add(FormatDateTime('hh:nn:ss', aValidatedTime));
                aListItem.Caption := aSLDates[j];
              end;
            end;
          end;
        end;
      end;
      // окончание цикла заполнения
      lvMsrDateTimeList.AlphaSort;
    finally
      aSLTimes.Free;
    end;
  finally
    aSLDates.Free;
  end;
  _UpdateListViewScrollBarVisibility;

  ProcedureFooter;
end;

procedure TAddMassMsrForm._Clear;
begin
  ProcedureHeader('Процедура очистки списка сеансов мероприятия', '{FC414DAF-DD07-4497-99C2-DB5A764E4C3C}');

  lvMsrDateTimeList.Clear;

  ProcedureFooter;
end;

procedure TAddMassMsrForm._Confirm;
begin
  ProcedureHeader(Format(RsCloseModalWithOkProcedure, [RsAddMassMsrForm]), '{11BCABC0-58E5-4962-BFE0-077941762018}');

  if MessageBox(Handle, PChar('Сгенерировано мероприятий: ' + IntToStr(lvMsrDateTimeList.Items.Count) +
    '. Вы дествительно хотите их добавить?'), PChar(Application.Title + ' - Подтверждение добавления'),
    MB_OKCANCEL + MB_ICONQUESTION + MB_DEFBUTTON2) = IDOK then
  begin
    ModalResult := mrOk;
  end;
  Log.SendInfo('Попытка массового размножения меропритий была подтверждена пользователем.');
  Log.SendInfo(Format(RsWindowClosed, [RsAddMassMsrForm]));

  ProcedureFooter;
end;

procedure TAddMassMsrForm._Delete;
begin
  ProcedureHeader('Процедура удаления элемента списка сеансов мероприятия', '{45B04FFE-2A83-4313-A882-A31CE7B8E8F9}');

  if lvMsrDateTimeList.Selected <> nil then
    lvMsrDateTimeList.Selected.Delete;
  _UpdateListViewScrollBarVisibility;

  ProcedureFooter;
end;

procedure TAddMassMsrForm._Help;
begin
  ProcedureHeader(RsContextHelpProcedure, '{1198290A-D679-4AC4-AF2D-BFBD620F89E2}');
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

procedure TAddMassMsrForm._UpdateListViewScrollBarVisibility;
var
  h: HWND;
begin
  ProcedureHeader('Процедура обновления состояния видимости полосы прокрутки списка сеансов мероприятия',
    '{2628E08E-7A4D-4BC8-B5BA-B95A8615D047}');

  h := lvMsrDateTimeList.Handle;
  if (GetWindowLong(h, GWL_STYLE) and WS_VSCROLL) = WS_VSCROLL then
  begin
    lvMsrDateTimeList.Column[1].Width := (lvMsrDateTimeList.Width - (lvMsrDateTimeList.BevelWidth * 2) - 2 -
      GetSystemMetrics(SM_CXVSCROLL)) div 2;
    lvMsrDateTimeList.Column[0].Width := lvMsrDateTimeList.Width - (lvMsrDateTimeList.BevelWidth * 2) - 2 -
      GetSystemMetrics(SM_CXVSCROLL) - lvMsrDateTimeList.Column[1].Width;
  end
  else
  begin
    lvMsrDateTimeList.Column[1].Width := (lvMsrDateTimeList.Width - (lvMsrDateTimeList.BevelWidth * 2) - 2) div 2;
    lvMsrDateTimeList.Column[0].Width := lvMsrDateTimeList.Width - (lvMsrDateTimeList.BevelWidth * 2) - 2 -
      lvMsrDateTimeList.Column[1].Width;
  end;
  lvMsrDateTimeList.FlatScrollBars := False;
  lvMsrDateTimeList.FlatScrollBars := True;

  ProcedureFooter;
end;

procedure TAddMassMsrForm._UpdateSelectedPeriod;
begin
  ProcedureHeader('Процедура обновления строки, отображающей выбранный период дат',
    '{05B9DC85-9DC8-4AF1-9ACE-31A2B8A22609}');

  if FormatDateTime('dd.mm.yyyy', MonthCalendar.Date) = FormatDateTime('dd.mm.yyyy', MonthCalendar.EndDate) then
    lblPeriod.Caption := DateToStr(MonthCalendar.Date)
  else
    lblPeriod.Caption := 'c ' + DateToStr(MonthCalendar.Date) + ' по ' + DateToStr(MonthCalendar.EndDate);

  ProcedureFooter;
end;

procedure TAddMassMsrForm._Close;
begin
  ProcedureHeader(Format(RsCloseModalWithCancelProcedure, [RsAddMassMsrForm]),
    '{4BA6D5D6-5088-4A74-99C8-20678DCF154B}');

  ModalResult := mrCancel;
  Log.SendInfo('Попытка массового размножения меропритий была отменена пользователем.');
  Log.SendInfo(Format(RsWindowClosedByUser, [RsAddMassMsrForm]));

  ProcedureFooter;
end;

procedure TAddMassMsrForm.actAddExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actAdd.Caption]), '{5FA66CD8-6E21-4C85-8AB1-E025F46D5FA2}');
  _Add;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.actClearExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClear.Caption]), '{5FA66CD8-6E21-4C85-8AB1-E025F46D5FA2}');
  _Clear;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{13451965-16E5-4B77-BFD8-922789209438}');
  _Close;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.actConfirmExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actConfirm.Caption]),
    '{440C6967-9A24-456C-A074-687F4CD5FE74}');
  _Confirm;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.actDeleteExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actDelete.Caption]), '{A37BFF88-E2A2-439B-9E92-E7C0522777A0}');
  _Delete;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{D31E7D84-CC7A-4011-85ED-5DFA3B9EE5A4}');
  _Help;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{ADE69D60-880D-463E-9776-5E197AD9212E}');
    actHelp.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actHelp));
    ProcedureFooter;
  end;
end;

procedure TAddMassMsrForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsAddMassMsrForm]), '{C60DAAE3-5E20-473B-8895-240001F68D38}');

  ImageList.GetIcon(ICON_ADDMASSMSR, Icon);
  with MainForm.Configuration do
  begin
    // установка параметров протоколирования в соответствии с настройками программы
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;
  end;

  ProcedureFooter;
end;

procedure TAddMassMsrForm.FormShow(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsAddMassMsrForm]), '{6C7BB6E1-D099-4E75-A5D5-00C46AD07C39}');
  _UpdateSelectedPeriod;
  _UpdateListViewScrollBarVisibility;
  Log.SendInfo(Format(RsWindowShowed, [RsAddMassMsrForm]));
  ProcedureFooter;
end;

procedure TAddMassMsrForm.lvMsrDateTimeListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer;
  var Compare: Integer);
var
  aDate: TDate;
  aTime: TTime;
begin
  aDate := EncodeDate(1900, 01, 01);
  aTime := EncodeTime(1, 2, 3, 4);

  if (not Assigned(Item1)) or (not Assigned(Item2)) then
  begin
    Compare := 0;
    Exit;
  end;
  if (Item1.SubItems.Count <> 1) or (Item2.SubItems.Count <> 1) then
  begin
    Compare := 0;
    Exit;
  end;
  if (Item1.SubItems[0] = EmptyStr) or (Item2.SubItems[0] = EmptyStr) then
  begin
    Compare := 0;
    Exit;
  end;

  if (StrToDateDef(Item1.Caption, aDate) = aDate) or (StrToDateDef(Item2.Caption, aDate) = aDate) or
    (StrToTimeDef(Item1.SubItems[0], aTime) = aTime) or (StrToTimeDef(Item2.SubItems[0], aTime) = aTime) then
    Compare := 0
  else
  begin
    if (StrToDateTimeDef(Item1.Caption + ' ' + Item1.SubItems[0], aDate + aTime) = aDate + aTime) or
      (StrToDateTimeDef(Item2.Caption + ' ' + Item2.SubItems[0], aDate + aTime) = aDate + aTime) then
      Compare := 0
    else
    begin
      if StrToDateTime(Item1.Caption + ' ' + Item1.SubItems[0]) > StrToDateTime(Item2.Caption + ' ' + Item2.SubItems[0])
      then
        Compare := 1
      else
        if StrToDateTime(Item1.Caption + ' ' + Item1.SubItems[0]) <
          StrToDateTime(Item2.Caption + ' ' + Item2.SubItems[0]) then
          Compare := -1
        else
          if StrToDateTime(Item1.Caption + ' ' + Item1.SubItems[0])
            = StrToDateTime(Item2.Caption + ' ' + Item2.SubItems[0]) then
            Compare := 0;
    end;
  end;
end;

procedure TAddMassMsrForm.lvMsrDateTimeListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  ProcedureHeader('Процедура-обработчик выделения элемента списка сеансов мероприятия',
    '{1004A198-53BD-4B37-9226-A45306C0017C}');

  _UpdateListViewScrollBarVisibility;

  ProcedureFooter;
end;

procedure TAddMassMsrForm.MonthCalendarClick(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик щелчка на элементе управления "Календарь"',
    '{79F0C9AB-973E-4A91-B8FA-3669BF04575F}');

  _UpdateSelectedPeriod;

  ProcedureFooter;
end;

procedure TAddMassMsrForm.actAddUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := IsStringIsTime(edbxTime.Text);
  if actAdd.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actAdd.Caption]), '{335FB31A-4340-4CE6-870A-7998E8A66EED}');
    actAdd.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actAdd));
    ProcedureFooter;
  end;
end;

procedure TAddMassMsrForm.actDeleteUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := lvMsrDateTimeList.Selected <> nil;
  if actDelete.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actDelete.Caption]),
      '{748F40FE-3AAD-45AA-AFF6-BFAD901BC997}');
    actDelete.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actDelete));
    ProcedureFooter;
  end;
end;

procedure TAddMassMsrForm.actClearUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := lvMsrDateTimeList.Items.Count > 0;
  if actClear.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actClear.Caption]), '{F520340E-0BE2-4EE6-9B3E-F8C3F3AF1D16}');
    actClear.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actClear));
    ProcedureFooter;
  end;
end;

procedure TAddMassMsrForm.actConfirmUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := lvMsrDateTimeList.Items.Count > 0;
  if actConfirm.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actConfirm.Caption]),
      '{4ECF3B13-FB14-4A53-8B56-5DC90A501AB8}');
    actConfirm.Enabled := b;
    Log.SendDebug(GetActionUpdateLogMessage(actConfirm));
    ProcedureFooter;
  end;
end;

end.
