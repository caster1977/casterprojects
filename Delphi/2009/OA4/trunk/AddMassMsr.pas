unit AddMassMsr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TAddMassMsrForm = class(TForm)
    lvMsrDateTimeList: TListView;
    btnDelete: TButton;
    MonthCalendar1: TMonthCalendar;
    edbxTime: TEdit;
    btnInsert: TButton;
    Bevel1: TBevel;
    pnlButtons: TPanel;
    btnAccept: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    lblPeriod: TLabel;
    Bevel2: TBevel;
    btnClear: TButton;
    procedure btnAcceptClick(Sender: TObject);
    procedure lvMsrDateTimeListCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure btnClearClick(Sender: TObject);
    procedure edbxTimeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MonthCalendar1Click(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lvMsrDateTimeListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure btnDeleteClick(Sender: TObject);
  private
    procedure Update_ListViewScrollBarVisibility;
    procedure Update_SelectedPeriod;
    procedure Update_ButtonState;
    function Validate_TimeString(aString: string): string;
    function IsStringIsTime(aString: string): boolean;
  public
  end;

var
  AddMassMsrForm: TAddMassMsrForm;

implementation

{$R *.dfm}

uses Main;

procedure TAddMassMsrForm.btnAcceptClick(Sender: TObject);
begin
  if MessageBox(Handle,PChar('—генерировано меропри€тий: '+IntToStr(lvMsrDateTimeList.Items.Count)+'. ¬ы дествительно хотите их добавить?'),PChar('OA4 - ѕодтверждение добавлени€'),MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK then
    ModalResult:=mrOk;
end;

procedure TAddMassMsrForm.btnClearClick(Sender: TObject);
begin
  lvMsrDateTimeList.Clear;
  Update_ButtonState;
  Update_ListViewScrollBarVisibility;
end;

procedure TAddMassMsrForm.btnDeleteClick(Sender: TObject);
begin
  if lvMsrDateTimeList.Selected<>nil then
    lvMsrDateTimeList.Selected.Delete;
  Update_ButtonState;
  Update_ListViewScrollBarVisibility;
end;

procedure TAddMassMsrForm.edbxTimeChange(Sender: TObject);
begin
  Update_ButtonState;
end;

procedure TAddMassMsrForm.FormCreate(Sender: TObject);
begin
  MonthCalendar1.Date:=SysUtils.Date;
  MonthCalendar1.EndDate:=SysUtils.Date;
  btnHelp.Enabled:=Application.HelpFile<>'';
end;

procedure TAddMassMsrForm.FormShow(Sender: TObject);
begin
  Update_SelectedPeriod;
  Update_ListViewScrollBarVisibility;
  Update_ButtonState;
end;

procedure TAddMassMsrForm.lvMsrDateTimeListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  Update_ButtonState;
  Update_ListViewScrollBarVisibility;
end;

procedure TAddMassMsrForm.MonthCalendar1Click(Sender: TObject);
begin
  Update_SelectedPeriod;
end;

procedure TAddMassMsrForm.Update_SelectedPeriod;
begin
  if FormatDateTime('dd.mm.yyyy',MonthCalendar1.Date)=FormatDateTime('dd.mm.yyyy',MonthCalendar1.EndDate) then
    lblPeriod.Caption:=DateToStr(MonthCalendar1.Date)
  else lblPeriod.Caption:='c '+DateToStr(MonthCalendar1.Date)+' по '+DateToStr(MonthCalendar1.EndDate);
end;

procedure TAddMassMsrForm.Update_ButtonState;
begin
   btnInsert.Enabled:=IsStringIsTime(edbxTime.Text);
   btnDelete.Enabled:=lvMsrDateTimeList.Selected<>nil;
   btnClear.Enabled:=lvMsrDateTimeList.Items.Count>0;
   btnAccept.Enabled:=lvMsrDateTimeList.Items.Count>0;
end;

procedure TAddMassMsrForm.Update_ListViewScrollBarVisibility;
var
  h : HWND;
begin
  h:=lvMsrDateTimeList.Handle;
  if (GetWindowLong(h,GWL_STYLE) and WS_VSCROLL)=WS_VSCROLL then
    begin
      lvMsrDateTimeList.Column[1].Width:=(
        lvMsrDateTimeList.Width - (lvMsrDateTimeList.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL)
        ) div 2;
      lvMsrDateTimeList.Column[0].Width:=
        lvMsrDateTimeList.Width - (lvMsrDateTimeList.BevelWidth*2)-2-GetSystemMetrics(SM_CXVSCROLL)
        - lvMsrDateTimeList.Column[1].Width;
    end
  else
    begin
      lvMsrDateTimeList.Column[1].Width:=(
        lvMsrDateTimeList.Width - (lvMsrDateTimeList.BevelWidth*2) - 2
        ) div 2;
      lvMsrDateTimeList.Column[0].Width:=
        lvMsrDateTimeList.Width - (lvMsrDateTimeList.BevelWidth*2) - 2
        - lvMsrDateTimeList.Column[1].Width;
    end;
  lvMsrDateTimeList.FlatScrollBars:=False;
  lvMsrDateTimeList.FlatScrollBars:=True;
end;

function TAddMassMsrForm.Validate_TimeString(aString: string): string;
var
  s: string;
begin
  s:=aString;
  // замена символа табул€ции на пробел
	while Pos(#09,s)>0 do s:=StringReplace(s,#09,' ',[rfReplaceAll]);
  // замена символа зап€той на пробел
	while Pos(',',s)>0 do s:=StringReplace(s,',',' ',[rfReplaceAll]);
	// удаление двойных пробелов
	while Pos('  ',s)>0 do s:=StringReplace(s,'  ',' ',[rfReplaceAll]);
  // замена символа "." на ":"
  while Pos('.',s)>0 do s:=StringReplace(s,'.',':',[rfReplaceAll]);
  // замена символа "-" на ":"
  while Pos('-',s)>0 do s:=StringReplace(s,'-',':',[rfReplaceAll]);
  // замена символа ":"
  s:=StringReplace(s,' :',':',[rfReplaceAll]);
	s:=StringReplace(s,': ',':',[rfReplaceAll]);
  // удаление граничных пробелов
	s:=Trim(s);
  Result:=s;
end;

function TAddMassMsrForm.IsStringIsTime(aString: string): boolean;
var
  b: boolean;
  aSL: TStringList;
  i: integer;
  s: string;
  aTime: TTime;
begin
  b:=True;
  s:=Validate_TimeString(aString);

  if s='' then // если строка пуста - возращаем "false"
    b:=False;
  aSL:=TStringList.Create;
  try
    aSL.Duplicates:=dupIgnore;
    aSL.Sorted:=True;
    CutStringByLimiterToStringList(s, aSL, ' ');
    for i:=0 to aSL.Count-1 do
      begin
        if Length(aSL[i])<>5 then // если строка не соответствует формату „„:ћћ - возращаем "false"
          b:=False
        else
          begin
            aTime:=EncodeTime(1,2,3,4);
            if StrToTimeDef(aSL[i]+':00',aTime)=aTime then // если возникает ошибка при преобразовании строки в формат времени - возращаем "false"
              b:=False;
          end;
      end;
  finally
    aSl.Free;
  end;

  Result:=b;
end;

procedure TAddMassMsrForm.btnInsertClick(Sender: TObject);
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
  edbxTime.Text:=Validate_TimeString(edbxTime.Text);
  dtLengthOfDay:=EncodeDate(2004,1,2)-EncodeDate(2004,1,1);
  // в цикле перебираем даты
  // в цикле перебираем элементы списка строк со впеменем
  // вставл€ем получившиес€ пары дата-врем€ в листвью

  // набиваем список уникальных дат
  if MonthCalendar1.EndDate>MonthCalendar1.Date then
    begin
      // если дата окончани€ больше чем дата начала
      DecodeDate(MonthCalendar1.Date, wStartYear, wStartMonth, wStartDay);
      DecodeDate(MonthCalendar1.EndDate, wStopYear, wStopMonth, wStopDay);
    end
  else
    begin
      // если дата начала больше чем дата окончани€
      DecodeDate(MonthCalendar1.EndDate, wStartYear, wStartMonth, wStartDay);
      DecodeDate(MonthCalendar1.Date, wStopYear, wStopMonth, wStopDay);
    end;

  aSLDates:=TStringList.Create;
  try
    aSLDates.Duplicates:=dupIgnore;
    aSLDates.Sorted:=True;

    dtNextDay:=EncodeDate(wStartYear, wStartMonth, wStartDay);
    repeat
      aSLDates.Add(FormatDateTime('dd.mm.yyyy',dtNextDay));
      dtNextDay:=dtNextDay+dtLengthOfDay;
    until dtNextDay>EncodeDate(wStopYear, wStopMonth, wStopDay);

    aSLTimes:=TStringList.Create;
    try
      aSLTimes.Duplicates:=dupIgnore;
      aSLTimes.Sorted:=True;
      CutStringByLimiterToStringList(edbxTime.Text, aSLTimes, ' ');
      // цикл заполнени€
      for j:=0 to aSLDates.Count-1 do
        begin
          for i:=0 to aSLTimes.Count-1 do
            begin
              if Length(aSLTimes[i])=5 then // если строка соответствует формату „„:ћћ
                begin
                  aTime:=EncodeTime(1,2,3,4);
                  s:=aSLTimes[i]+':00';
                  aValidatedTime:=StrToTimeDef(s,aTime);
                  if aValidatedTime<>aTime then // если не возникает ошибка при преобразовании строки в формат времени
                    begin
                      // проверка на наличие в списке элемента с идентичными данными
                      b:=True;
                      for k:=0 to lvMsrDateTimeList.Items.Count-1 do
                        if (lvMsrDateTimeList.Items[k].Caption=aSLDates[j]) and (lvMsrDateTimeList.Items[k].SubItems[0]=FormatDateTime('hh:nn:ss',aValidatedTime)) then
                          b:=False;
                      // если элемент с идентичными данными не был найден в списке - добавл€ем новый
                      if b then
                        begin
                          aListItem:=lvMsrDateTimeList.Items.Add;
                          aListItem.SubItems.Add(FormatDateTime('hh:nn:ss',aValidatedTime));
                          aListItem.Caption:=aSLDates[j];
                        end;
                    end;
                end;
            end;
        end;
      // окончание цикла заполнени€
      lvMsrDateTimeList.AlphaSort;
    finally
      aSLTimes.Free;
    end;
  finally
    aSLDates.Free;
  end;
  Update_ListViewScrollBarVisibility;
  Update_ButtonState;
end;

procedure TAddMassMsrForm.lvMsrDateTimeListCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
var
  aDate: TDate;
  aTime: TTime;
begin
  aDate:=EncodeDate(1900,01,01);
  aTime:=EncodeTime(1,2,3,4);

  if (Item1=nil) or (Item2=nil) then
    begin
      Compare:=0;
      Exit;
    end;
  if (Item1.SubItems.Count<>1) or (Item2.SubItems.Count<>1) then
    begin
      Compare:=0;
      Exit;
    end;
  if (Item1.SubItems[0]='') or (Item2.SubItems[0]='') then
    begin
      Compare:=0;
      Exit;
    end;

  if (Item1<>nil) and (Item2<>nil) then
    if (Item1.SubItems.Count=1) and (Item1.SubItems.Count=1) then
      if (Item1.SubItems[0]<>'') and (Item2.SubItems[0]<>'') then
        begin
          if (StrToDateDef(Item1.Caption,aDate)=aDate) or (StrToDateDef(Item2.Caption,aDate)=aDate)
          or (StrToTimeDef(Item1.SubItems[0],aTime)=aTime) or (StrToTimeDef(Item2.SubItems[0],aTime)=aTime) then
            Compare:=0
          else
            begin
              if (StrToDateTimeDef(Item1.Caption+' '+Item1.SubItems[0],aDate+aTime)=aDate+aTime) or (StrToDateTimeDef(Item2.Caption+' '+Item2.SubItems[0],aDate+aTime)=aDate+aTime) then
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
        end
      else Compare:=0
    else Compare:=0
  else Compare:=0;
end;

end.
