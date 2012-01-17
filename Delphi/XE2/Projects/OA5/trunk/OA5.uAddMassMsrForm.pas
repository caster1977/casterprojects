unit OA5.uAddMassMsrForm;

interface

uses
  Windows,
  Controls,
  Forms,
  ExtCtrls,
  StdCtrls,
  ComCtrls,
  CastersPackage.uLogProvider,
  ActnList,
  ActnMan,
  ImgList,
  Classes,
  PlatformDefaultStyleActnCtrls;

type
  TAddMassMsrForm=class(TForm)
    pnlButtons: TPanel;
    btnAccept: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    Panel1: TPanel;
    Panel3: TPanel;
    lblPeriod: TLabel;
    MonthCalendar1: TMonthCalendar;
    Label1: TLabel;
    Bevel1: TBevel;
    Panel2: TPanel;
    edbxTime: TEdit;
    Button1: TButton;
    lvMsrDateTimeList: TListView;
    Button2: TButton;
    Button3: TButton;
    ActionManager1: TActionManager;
    Log: TLogProvider;
    ilAddMassMsrFormSmallImages: TImageList;
    Action_Help: TAction;
    Action_Add: TAction;
    Action_Delete: TAction;
    Action_Clear: TAction;
    Action_Close: TAction;
    Action_Confirm: TAction;
    procedure FormCreate(Sender: TObject);
    procedure Action_ConfirmExecute(Sender: TObject);
    procedure Action_ClearExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_DeleteExecute(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_AddExecute(Sender: TObject);
    procedure edbxTimeChange(Sender: TObject);
    procedure MonthCalendar1Click(Sender: TObject);
    procedure lvMsrDateTimeListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure lvMsrDateTimeListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
    procedure FormShow(Sender: TObject);
  strict private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure ProcedureFooter;
    procedure Do_Confirm;
    procedure Do_Clear;
    procedure Do_Help;
    procedure Do_Add;
    procedure Do_Delete;
    procedure Do_Close;
    procedure Do_UpdateActions;
    procedure Do_UpdateListViewScrollBarVisibility;
    procedure Do_UpdateSelectedPeriod;
  end;

implementation

{$R *.dfm}

uses
  SysUtils,
  CastersPackage.uRoutines,
  OA5.uMainForm;

function Validate_TimeString(const aString: string): string;
var
  s: string;
begin
  s:=aString;
  // замена символа табуляции на пробел
  while Pos(#09, s)>0 do
    s:=StringReplace(s, #09, ' ', [rfReplaceAll]);
  // замена символа запятой на пробел
  while Pos(',', s)>0 do
    s:=StringReplace(s, ',', ' ', [rfReplaceAll]);
  // удаление двойных пробелов
  while Pos('  ', s)>0 do
    s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
  // замена символа "." на ":"
  while Pos('.', s)>0 do
    s:=StringReplace(s, '.', ':', [rfReplaceAll]);
  // замена символа "-" на ":"
  while Pos('-', s)>0 do
    s:=StringReplace(s, '-', ':', [rfReplaceAll]);
  // замена символа ":"
  s:=StringReplace(s, ' :', ':', [rfReplaceAll]);
  s:=StringReplace(s, ': ', ':', [rfReplaceAll]);
  // удаление граничных пробелов
  Result:=Trim(s);
end;

function IsStringIsTime(const aString: string): boolean;
var
  b: boolean;
  aSL: TStringList;
  i: integer;
  s: string;
  aTime: TTime;
begin
  s:=Validate_TimeString(aString);
  b:=not(s=''); // если строка пуста - возращаем "false"
  if b then
    begin
      aSL:=TStringList.Create;
      try
        aSL.Duplicates:=dupIgnore;
        aSL.Sorted:=True;
        Routines.CutStringByLimiterToStringList(s, aSL, ' ');
        for i:=0 to aSL.Count-1 do
          begin
            if Length(aSL[i])<>5 then // если строка не соответствует формату ЧЧ:ММ - возращаем "false"
              b:=False
            else
              begin
                aTime:=EncodeTime(1, 2, 3, 4);
                b:=not(StrToTimeDef(aSL[i]+':00', aTime)=aTime); // если возникает ошибка при преобразовании строки в формат времени - возращаем "false"
              end;
          end;
      finally
        aSl.Free;
      end;
    end;
  Result:=b;
end;

procedure TAddMassMsrForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TAddMassMsrForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TAddMassMsrForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TAddMassMsrForm.Do_Add;
var
  aSLDates, aSLTimes: TStringList;
  i, j, k: integer;
  s: string;
  b: boolean;
  aTime, aValidatedTime: TTime;
  aListItem: TListItem;
  dtLengthOfDay, dtNextDay: TDateTime;

  wStartYear, wStartMonth, wStartDay, wStopYear, wStopMonth, wStopDay: word;
begin
  ProcedureHeader('Процедура добавления указанных сеансов мероприятия в список', '{C0AD6CA7-C22C-4694-A1BF-384E624AC64F}');

  edbxTime.Text:=Validate_TimeString(edbxTime.Text);
  dtLengthOfDay:=EncodeDate(2011, 1, 2)-EncodeDate(2011, 1, 1);
  // в цикле перебираем даты
  // в цикле перебираем элементы списка строк с временем
  // вставляем получившиеся пары дата-время в листвью

  // набиваем список уникальных дат
  if MonthCalendar1.EndDate>MonthCalendar1.Date then
    begin
      // если дата окончания больше чем дата начала
      DecodeDate(MonthCalendar1.Date, wStartYear, wStartMonth, wStartDay);
      DecodeDate(MonthCalendar1.EndDate, wStopYear, wStopMonth, wStopDay);
    end
  else
    begin
      // если дата начала больше чем дата окончания
      DecodeDate(MonthCalendar1.EndDate, wStartYear, wStartMonth, wStartDay);
      DecodeDate(MonthCalendar1.Date, wStopYear, wStopMonth, wStopDay);
    end;

  aSLDates:=TStringList.Create;
  try
    aSLDates.Duplicates:=dupIgnore;
    aSLDates.Sorted:=True;

    dtNextDay:=EncodeDate(wStartYear, wStartMonth, wStartDay);
    repeat
      aSLDates.Add(FormatDateTime('dd.mm.yyyy', dtNextDay));
      dtNextDay:=dtNextDay+dtLengthOfDay;
    until dtNextDay>EncodeDate(wStopYear, wStopMonth, wStopDay);

    aSLTimes:=TStringList.Create;
    try
      aSLTimes.Duplicates:=dupIgnore;
      aSLTimes.Sorted:=True;
      Routines.CutStringByLimiterToStringList(edbxTime.Text, aSLTimes, ' ');
      // цикл заполнения
      for j:=0 to aSLDates.Count-1 do
        begin
          for i:=0 to aSLTimes.Count-1 do
            begin
              if Length(aSLTimes[i])=5 then // если строка соответствует формату ЧЧ:ММ
                begin
                  aTime:=EncodeTime(1, 2, 3, 4);
                  s:=aSLTimes[i]+':00';
                  aValidatedTime:=StrToTimeDef(s, aTime);
                  if aValidatedTime<>aTime then // если не возникает ошибка при преобразовании строки в формат времени
                    begin
                      // проверка на наличие в списке элемента с идентичными данными
                      b:=True;
                      for k:=0 to lvMsrDateTimeList.Items.Count-1 do
                        if (lvMsrDateTimeList.Items[k].Caption=aSLDates[j])and(lvMsrDateTimeList.Items[k].SubItems[0]=FormatDateTime('hh:nn:ss', aValidatedTime)) then
                          b:=False;
                      // если элемент с идентичными данными не был найден в списке - добавляем новый
                      if b then
                        begin
                          aListItem:=lvMsrDateTimeList.Items.Add;
                          aListItem.SubItems.Add(FormatDateTime('hh:nn:ss', aValidatedTime));
                          aListItem.Caption:=aSLDates[j];
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
  Do_UpdateListViewScrollBarVisibility;
  Do_UpdateActions;

  ProcedureFooter;
end;

procedure TAddMassMsrForm.Do_Clear;
begin
  ProcedureHeader('Процедура очистки списка сеансов мероприятия', '{FC414DAF-DD07-4497-99C2-DB5A764E4C3C}');

  lvMsrDateTimeList.Clear;
  Do_UpdateActions;

  ProcedureFooter;
end;

procedure TAddMassMsrForm.Do_Confirm;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrOk', '{11BCABC0-58E5-4962-BFE0-077941762018}');

  if MessageBox(Handle, PChar('Сгенерировано мероприятий: '+IntToStr(lvMsrDateTimeList.Items.Count)+'. Вы дествительно хотите их добавить?'), PChar('OA5 - Подтверждение добавления'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK then
    ModalResult:=mrOk;
  Log.SendInfo('Попытка массового размножения меропритий была подтверждена пользователем.');
  Log.SendInfo('Окно массового размножения мероприятий закрыто.');

  ProcedureFooter;
end;

procedure TAddMassMsrForm.Do_Delete;
begin
  ProcedureHeader('Процедура удаления элемента списка сеансов мероприятия', '{45B04FFE-2A83-4313-A882-A31CE7B8E8F9}');

  if lvMsrDateTimeList.Selected<>nil then
    lvMsrDateTimeList.Selected.Delete;
  Do_UpdateActions;
  Do_UpdateListViewScrollBarVisibility;

  ProcedureFooter;
end;

procedure TAddMassMsrForm.Do_UpdateActions;
begin
  ProcedureHeader('Процедура обновления состояния действий', '{E82D3684-F61B-4852-B94D-10AE52F902CF}');

  Action_Add.Enabled:=IsStringIsTime(edbxTime.Text);
  Log.SendDebug('Действие "'+Action_Add.Caption+'" '+Routines.GetConditionalString(Action_Add.Enabled, 'в', 'от')+'ключено.');
  Action_Delete.Enabled:=lvMsrDateTimeList.Selected<>nil;
  Log.SendDebug('Действие "'+Action_Delete.Caption+'" '+Routines.GetConditionalString(Action_Delete.Enabled, 'в', 'от')+'ключено.');
  Action_Clear.Enabled:=lvMsrDateTimeList.Items.Count>0;
  Log.SendDebug('Действие "'+Action_Clear.Caption+'" '+Routines.GetConditionalString(Action_Clear.Enabled, 'в', 'от')+'ключено.');
  Action_Confirm.Enabled:=lvMsrDateTimeList.Items.Count>0;
  Log.SendDebug('Действие "'+Action_Confirm.Caption+'" '+Routines.GetConditionalString(Action_Confirm.Enabled, 'в', 'от')+'ключено.');

  ProcedureFooter;
end;

procedure TAddMassMsrForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура вызова контекстной справки', '{D1DAEF81-21C3-4CFF-9865-C04B135F3D09}');
  bError:=False;

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TAddMassMsrForm.Do_UpdateListViewScrollBarVisibility;
var
  h: HWND;
begin
  ProcedureHeader('Процедура обновления состояния видимости полосы прокрутки списка сеансов мероприятия', '{2628E08E-7A4D-4BC8-B5BA-B95A8615D047}');

  h:=lvMsrDateTimeList.Handle;
  if (GetWindowLong(h, GWL_STYLE)and WS_VSCROLL)=WS_VSCROLL then
    begin
      lvMsrDateTimeList.Column[1].Width:=(lvMsrDateTimeList.Width-(lvMsrDateTimeList.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL))div 2;
      lvMsrDateTimeList.Column[0].Width:=lvMsrDateTimeList.Width-(lvMsrDateTimeList.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL)-lvMsrDateTimeList.Column[1].Width;
    end
  else
    begin
      lvMsrDateTimeList.Column[1].Width:=(lvMsrDateTimeList.Width-(lvMsrDateTimeList.BevelWidth*2)-2)div 2;
      lvMsrDateTimeList.Column[0].Width:=lvMsrDateTimeList.Width-(lvMsrDateTimeList.BevelWidth*2)-2-lvMsrDateTimeList.Column[1].Width;
    end;
  lvMsrDateTimeList.FlatScrollBars:=False;
  lvMsrDateTimeList.FlatScrollBars:=True;

  ProcedureFooter;
end;

procedure TAddMassMsrForm.Do_UpdateSelectedPeriod;
begin
  ProcedureHeader('Процедура обновления строки, отображающей выбранный период дат', '{05B9DC85-9DC8-4AF1-9ACE-31A2B8A22609}');

  if FormatDateTime('dd.mm.yyyy', MonthCalendar1.Date)=FormatDateTime('dd.mm.yyyy', MonthCalendar1.EndDate) then
    lblPeriod.Caption:=DateToStr(MonthCalendar1.Date)
  else
    lblPeriod.Caption:='c '+DateToStr(MonthCalendar1.Date)+' по '+DateToStr(MonthCalendar1.EndDate);

  ProcedureFooter;
end;

procedure TAddMassMsrForm.edbxTimeChange(Sender: TObject);
begin
  Do_UpdateActions;
end;

procedure TAddMassMsrForm.Do_Close;
begin
  ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', '{4BA6D5D6-5088-4A74-99C8-20678DCF154B}');

  ModalResult:=mrClose;
  Log.SendInfo('Попытка массового размножения меропритий была отменена пользователем.');
  Log.SendInfo('Окно массового размножения мероприятий закрыто.');

  ProcedureFooter;
end;

procedure TAddMassMsrForm.Action_AddExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Clear.Caption+'"', '{5FA66CD8-6E21-4C85-8AB1-E025F46D5FA2}');
  Do_Add;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.Action_ClearExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Clear.Caption+'"', '{5FA66CD8-6E21-4C85-8AB1-E025F46D5FA2}');
  Do_Clear;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', '{13451965-16E5-4B77-BFD8-922789209438}');
  Do_Close;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.Action_ConfirmExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Confirm.Caption+'"', '{440C6967-9A24-456C-A074-687F4CD5FE74}');
  Do_Confirm;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.Action_DeleteExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Delete.Caption+'"', '{A37BFF88-E2A2-439B-9E92-E7C0522777A0}');
  Do_Delete;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{D31E7D84-CC7A-4011-85ED-5DFA3B9EE5A4}');
  Do_Help;
  ProcedureFooter;
end;

procedure TAddMassMsrForm.FormCreate(Sender: TObject);
const
  ICON_ADDMASSMSR=5;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{C60DAAE3-5E20-473B-8895-240001F68D38}');

  ilAddMassMsrFormSmallImages.GetIcon(ICON_ADDMASSMSR, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('Действие "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, 'в', 'от')+'ключено.');

  with MainForm.Configuration do
    begin
      // установка параметров протоколирования в соответствии с настройками программы
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // установка положения окна конфигурации в соответсвии со значениями конфигурации программы
      if AddMassMsrFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if AddMassMsrFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if AddMassMsrFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=AddMassMsrFormPosition.x;
          if AddMassMsrFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if AddMassMsrFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=AddMassMsrFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TAddMassMsrForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{6C7BB6E1-D099-4E75-A5D5-00C46AD07C39}');

  Do_UpdateSelectedPeriod;
  Do_UpdateListViewScrollBarVisibility;
  Do_UpdateActions;
  Log.SendInfo('Отображено окно массового размножения мероприятий.');

  ProcedureFooter;
end;

procedure TAddMassMsrForm.lvMsrDateTimeListCompare(Sender: TObject; Item1, Item2: TListItem; Data: Integer; var Compare: Integer);
var
  aDate: TDate;
  aTime: TTime;
begin
  aDate:=EncodeDate(1900, 01, 01);
  aTime:=EncodeTime(1, 2, 3, 4);

  if (not Assigned(Item1))or(not Assigned(Item2)) then
    begin
      Compare:=0;
      Exit;
    end;
  if (Item1.SubItems.Count<>1)or(Item2.SubItems.Count<>1) then
    begin
      Compare:=0;
      Exit;
    end;
  if (Item1.SubItems[0]='')or(Item2.SubItems[0]='') then
    begin
      Compare:=0;
      Exit;
    end;

  if (StrToDateDef(Item1.Caption, aDate)=aDate)or(StrToDateDef(Item2.Caption, aDate)=aDate)or(StrToTimeDef(Item1.SubItems[0], aTime)=aTime)or(StrToTimeDef(Item2.SubItems[0], aTime)=aTime) then
    Compare:=0
  else
    begin
      if (StrToDateTimeDef(Item1.Caption+' '+Item1.SubItems[0], aDate+aTime)=aDate+aTime)or(StrToDateTimeDef(Item2.Caption+' '+Item2.SubItems[0], aDate+aTime)=aDate+aTime) then
        Compare:=0
      else
        begin
          if StrToDateTime(Item1.Caption+' '+Item1.SubItems[0])>StrToDateTime(Item2.Caption+' '+Item2.SubItems[0]) then
            Compare:=1
          else
            if StrToDateTime(Item1.Caption+' '+Item1.SubItems[0])<StrToDateTime(Item2.Caption+' '+Item2.SubItems[0]) then
              Compare:=-1
            else
              if StrToDateTime(Item1.Caption+' '+Item1.SubItems[0])=StrToDateTime(Item2.Caption+' '+Item2.SubItems[0]) then
                Compare:=0;
        end;
    end;
end;

procedure TAddMassMsrForm.lvMsrDateTimeListSelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  ProcedureHeader('Процедура-обработчик выделения элемента списка сеансов мероприятия', '{1004A198-53BD-4B37-9226-A45306C0017C}');

  Do_UpdateActions;
  Do_UpdateListViewScrollBarVisibility;

  ProcedureFooter;
end;

procedure TAddMassMsrForm.MonthCalendar1Click(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик щелчка на элементе управления "Календарь"', '{79F0C9AB-973E-4A91-B8FA-3669BF04575F}');

  Do_UpdateSelectedPeriod;

  ProcedureFooter;
end;

end.
