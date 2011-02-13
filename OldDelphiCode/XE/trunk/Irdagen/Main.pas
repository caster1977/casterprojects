unit Main;

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
  ComCtrls,
  Menus,
  ImgList,
  ActnList,
  DBTables,
  IniFiles,
  Grids,
  ExtCtrls,
  StdCtrls,
  ToolWin,
  getFVI;

type
  TMainForm=class(TForm)
    StatusBar: TStatusBar;
    ActionList1: TActionList;
    ACTION_Exit: TAction;
    ACTION_HelpContents: TAction;
    ACTION_About: TAction;
    ACTION_Options: TAction;
    ImageList1: TImageList;
    MainMenu1: TMainMenu;
    N7: TMenuItem;
    N27: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N2: TMenuItem;
    mi_Help: TMenuItem;
    mi_HelpDivider: TMenuItem;
    mi_About: TMenuItem;
    CoolBar1: TCoolBar;
    Panel2: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton11: TToolButton;
    ACTION_QueryTextVisibilityState: TAction;
    mi_OptionsDivider: TMenuItem;
    N1: TMenuItem;
    Memo1: TMemo;
    ACTION_CopySQL: TAction;
    ACTION_SaveSQL: TAction;
    ToolButton4: TToolButton;
    ToolButton6: TToolButton;
    N3: TMenuItem;
    N4: TMenuItem;
    mi_Query: TMenuItem;
    ACTION_ClearSQL: TAction;
    ACTIONClearQueryText1: TMenuItem;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Bevel2: TBevel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    RADIOBUTTON_Yesterday: TRadioButton;
    RADIOBUTTON_Today: TRadioButton;
    RADIOBUTTON_LastWeekToYesterday: TRadioButton;
    RADIOBUTTON_From1stToYesterday: TRadioButton;
    RADIOBUTTON_PrevMonth: TRadioButton;
    RADIOBUTTON_Another: TRadioButton;
    Panel3: TPanel;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    CHECKBOX_GenerateDayQuery: TCheckBox;
    CHECKBOX_GeneratePeriodQuery: TCheckBox;
    CHECKBOX_GenerateDayDropQuery: TCheckBox;
    Edit1: TEdit;
    ACTION_ChoisePrijavesExportFile: TAction;
    ACTION_UpdateDates: TAction;
    ACTION_RebuildSQL: TAction;
    ToolButton7: TToolButton;
    N5: TMenuItem;
    N6: TMenuItem;
    ToolButton8: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    N8: TMenuItem;
    N9: TMenuItem;
    gsFileVersionInfo1: TgsFileVersionInfo;
    procedure ACTION_ExitExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure ACTION_OptionsExecute(Sender: TObject);
    procedure ACTION_QueryTextVisibilityStateExecute(Sender: TObject);
    procedure ACTION_CopySQLExecute(Sender: TObject);
    procedure ACTION_SaveSQLExecute(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure ACTION_ClearSQLExecute(Sender: TObject);
    procedure ACTION_ChoisePrijavesExportFileExecute(Sender: TObject);
    procedure ACTION_UpdateDatesExecute(Sender: TObject);
    procedure ACTION_RebuildSQLExecute(Sender: TObject);
  private
    sSourceFile: string;
    Today, Yesterday, PrevMonth_FirstDay, PrevMonth_LastDay, CurrentMonth_FirstDay: TDate;
    procedure DisplayHint(Sender: TObject);
    procedure UpdateMenuVisibility;
  public
    CFGFileName, HLPFileName: TFileName;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.ACTION_OptionsExecute(Sender: TObject);
begin
  UpdateMenuVisibility;
end;

procedure TMainForm.UpdateMenuVisibility;
begin
  mi_OptionsDivider.Visible:=ACTION_Options.Visible;
  mi_HelpDivider.Visible:=ACTION_HelpContents.Visible;
  mi_Query.Visible:=ACTION_SaveSQL.Visible or ACTION_ClearSQL.Visible or ACTION_CopySQL.Visible;
end;

procedure TMainForm.DisplayHint(Sender: TObject);
begin
  StatusBar.Panels[1].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.ACTION_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Memo1.Lines.Count>0 then
      if MessageDlg('Скопировать текст запроса в буфер обмена?', mtConfirmation, [mbYes, mbNo], 0)=mrYes then
        ACTION_CopySQL.Execute;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  Year, Month, Day: word;
  PrevYear, PrevMonth, PrevDay: Word;
  i: integer;
begin
  // Panel2.Align:=alClient;
  for i:=0 to ToolBar1.ButtonCount-1 do
    begin
      ToolBar1.Buttons[i].Cursor:=crHandPoint;
      if ToolBar1.Buttons[i].Style=tbsButton then
        ToolBar1.Buttons[i].AutoSize:=True;
    end;
  Application.OnHint:=DisplayHint;
  ImageList1.GetIcon(10, Application.Icon);
  MainForm.Icon:=Application.Icon;
  gsFileVersionInfo1.Filename:=Application.ExeName;
  CFGFileName:=Copy(Application.ExeName, 0, Length(Application.ExeName)-3)+'cfg';
  with TIniFile.Create(CFGFileName) do
    try
      Application.Title:=ReadString('COMMON', 'ApplicationTitle', gsFileVersionInfo1.ProductName);
      MainForm.Caption:=Application.Title;
    finally
      Free;
    end;
  HLPFileName:=Copy(ExtractFileName(Application.ExeName), 0, Length(ExtractFileName(Application.ExeName))-3)+'hlp';
  if FileExists(HLPFileName) then
    Application.HelpFile:=HLPFileName;
  ACTION_HelpContents.Enabled:=Application.HelpFile<>'';
  ACTION_HelpContents.Visible:=ACTION_HelpContents.Enabled;
  // вывод окна "О программе..."
  // инифиализация переменных программы
  DecodeDate(Now, Year, Month, Day);
  Today:=EncodeDate(Year, Month, Day);
  Yesterday:=Today-(EncodeDate(2004, 1, 2)-EncodeDate(2004, 1, 1));
  CurrentMonth_FirstDay:=EncodeDate(Year, Month, 1);
  PrevMonth_LastDay:=CurrentMonth_FirstDay-(EncodeDate(2004, 1, 2)-EncodeDate(2004, 1, 1));
  DecodeDate(PrevMonth_LastDay, PrevYear, PrevMonth, PrevDay);
  PrevMonth_FirstDay:=EncodeDate(PrevYear, PrevMonth, 1);
  DateTimePicker1.DateTime:=Yesterday;
  DateTimePicker2.DateTime:=Yesterday;
  ACTION_UpdateDatesExecute(RADIOBUTTON_Yesterday);
  UpdateMenuVisibility;
end;

procedure TMainForm.ACTION_QueryTextVisibilityStateExecute(Sender: TObject);
begin
  ACTION_QueryTextVisibilityState.Checked:=not ACTION_QueryTextVisibilityState.Checked;
  Memo1.Visible:=ACTION_QueryTextVisibilityState.Checked;
end;

procedure TMainForm.ACTION_CopySQLExecute(Sender: TObject);
begin
  with Memo1 do
    begin
      SelectAll;
      CopyToClipboard;
      SelLength:=0;
    end;
end;

procedure TMainForm.ACTION_SaveSQLExecute(Sender: TObject);
begin
  if Memo1.Lines.Count>0 then
    with TSaveDialog.Create(Self) do
      try
        Filter:='Файл запроса MySQL (*.sql)|*.sql|Текстовый файл (*.txt)|*.txt';
        DefaultExt:='sql';
        Title:='Введите имя файла для сохранения запроса...';
        FilterIndex:=1;
        if Execute then
          if FileName='' then
            MessageDlg('Не задано имя файла для сохранения запроса!', mtError, [mbOk], 0)
          else
            begin
              try
                Memo1.Lines.SaveToFile(FileName);
              except
                on EWriteError do
                  MessageDlg('Не удалось записать текст запроса в файл!', mtError, [mbOk], 0);
                on EFCreateError do
                  MessageDlg('Ошибка создания файла!', mtError, [mbOk], 0);
              end;
              // ACTION_ClearSQL.Execute;
              MessageDlg('Текст SQL-запроса был успешно сохранён в файл.', mtInformation, [mbOk], 0);
            end;
      finally
        Free;
      end;
end;

procedure TMainForm.Memo1Change(Sender: TObject);
begin
  ACTION_CopySQL.Enabled:=(Memo1.Lines.Count=0);
  ACTION_SaveSQL.Enabled:=(Memo1.Lines.Count=0);
end;

procedure TMainForm.ACTION_ClearSQLExecute(Sender: TObject);
begin
  Panel2.Visible:=False;
  Memo1.Clear;
  Panel2.Visible:=True;
  ACTION_SaveSQL.Enabled:=False;
  ACTION_CopySQL.Enabled:=False;
  ACTION_ClearSQL.Enabled:=False;
end;

procedure TMainForm.ACTION_ChoisePrijavesExportFileExecute(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      Filter:='prijave*.sql, prijave_q*.sql|prijave*.sql|Файлы запросов MySQL (*.sql)|*.sql|Все файлы (*.*)|*.*';
      Title:='Выберите файл, содержащий данные таблиц prijave, prijave_q, сохранённые в виде MySQL-запроса';
      FilterIndex:=1;
      if Execute then
        begin
          if ((FileName<>'')and FileExists(FileName)) then
            begin
              sSourceFile:=FileName;
              ACTION_RebuildSQL.Enabled:=True;
              ACTION_SaveSQL.Enabled:=False;
              ACTION_CopySQL.Enabled:=False;
              MainForm.Caption:=Application.Title+' - '+sSourceFile;
            end
        end;
    finally
      Free;
    end;
end;

procedure TMainForm.ACTION_UpdateDatesExecute(Sender: TObject);
var
  Year, Month, Day, Year1, Month1, Day1, Year2, Month2, Day2, Year3, Month3, Day3: Word;
  iTag: integer;
  sMonth1, sMonth2, sDay1, sDay2: string;
  DayLength: TDate;
  bMonthStart, bYearStart, bMonthEnd, bYearEnd: boolean;
begin
  iTag:=0;
  if Sender is TRadioButton then
    iTag:=TRadioButton(Sender).Tag;
  if Sender is TDateTimePicker then
    iTag:=TDateTimePicker(Sender).Tag;
  if iTag in [1..8] then
    begin
      Memo1.Clear;
      ACTION_SaveSQL.Enabled:=False;
      DecodeDate(Today, Year, Month, Day);
      DayLength:=EncodeDate(2004, 1, 2)-EncodeDate(2004, 1, 1);
      DateTimePicker1.Enabled:=iTag in [6..8];
      DateTimePicker2.Enabled:=iTag in [6..8];
      case iTag of
        1:
          begin
            DateTimePicker1.Date:=Yesterday;
            DateTimePicker2.Date:=Yesterday;
          end;
        2:
          begin
            DateTimePicker1.Date:=Today;
            DateTimePicker2.Date:=Today;
          end;
        3:
          begin
            DateTimePicker1.Date:=Yesterday-(DayLength*7);
            DateTimePicker2.Date:=Yesterday;
          end;
        4:
          begin
            DateTimePicker1.Date:=CurrentMonth_FirstDay;
            DateTimePicker2.Date:=Yesterday;
          end;
        5:
          begin
            DateTimePicker1.Date:=PrevMonth_FirstDay;
            DateTimePicker2.Date:=PrevMonth_LastDay;
          end;
        6, 7, 8:
          begin
            if DateTimePicker1.Date>DateTimePicker2.Date then
              MessageDlg('Дата конца периода не может быть меньше даты начала периода!'+#10#13+'Произведите корректировку даты!', mtError, [mbOK], 0);
          end;
      end;
      DecodeDate(DateTimePicker1.Date, Year1, Month1, Day1);
      DecodeDate(DateTimePicker2.Date, Year2, Month2, Day2);
      sMonth1:=IntToStr(Month1);
      if Month1<10 then
        sMonth1:='0'+sMonth1;
      sDay1:=IntToStr(Day1);
      if Day1<10 then
        sDay1:='0'+sDay1;
      sMonth2:=IntToStr(Month2);
      if Month2<10 then
        sMonth2:='0'+sMonth2;
      sDay2:=IntToStr(Day2);
      if Day2<10 then
        sDay2:='0'+sDay2;
      // определяем, является ли стартовая дата началом месяца
      DecodeDate(DateTimePicker1.Date-DayLength, Year3, Month3, Day3);
      bMonthStart:=(Month3<>Month1);
      // и года
      bYearStart:=(Year3<>Year1)and(Month3<>Month1);
      // определяем, является ли конечная дата концом месяца
      DecodeDate(DateTimePicker2.Date+DayLength, Year3, Month3, Day3);
      bMonthEnd:=(Month3<>Month2);
      // и года
      bYearEnd:=(Year3<>Year2)and(Month3<>Month2);
      if (Year1=Year2) then
        begin
          if (Month1=Month2) then
            if (Day1=Day2) then
              begin
                // год, месяц и день равны
                Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+sDay1;
              end
            else
              begin
                // год и месяц равны
                Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+sDay1+'-'+sDay2;
                // проверка запроса за месяц
                if (bMonthStart and bMonthEnd) then
                  Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1;
              end
          else
            if (Day1=Day2) then
              begin
                // год и день равны
                Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+'-'+sMonth2;
              end
            else
              begin
                // год равен
                Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+sDay1+'-'+sMonth2+sDay2;
                // проверка запроса за несколько месяцев разных лет
                if (bMonthStart and bMonthEnd and(Year1<>Year2)) then
                  Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+'-'+IntToStr(Year2)+sMonth2;
                // проверка запроса за несколько месяцев одного года
                if (bMonthStart and bMonthEnd and(Year1=Year2)) then
                  Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+'-'+sMonth2;
                // проверка запроса за год
                if (bYearStart and bYearEnd) then
                  Edit1.Text:='irda_'+IntToStr(Year1);
              end
        end
      else
        begin
          if (Month1=Month2) then
            if (Day1=Day2) then
              begin
                // года не равны, а месяц и день равны
                Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+sDay1+'-'+IntToStr(Year2)+sMonth2+sDay2;
              end
            else
              begin
                // год и день не равны, а месяц равен
                Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+sDay1+'-'+IntToStr(Year2)+sMonth2+sDay2;
                // проверка на несколько месяцев разных лет
                if (bMonthStart and bMonthEnd and(Year1<>Year2)) then
                  Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+'-'+IntToStr(Year2)+sMonth2;
              end
          else
            if (Day1=Day2) then
              begin
                // год и месяц не равны
                Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+sDay1+'-'+IntToStr(Year2)+sMonth2+sDay2;
              end
            else
              begin
                // год, месяц и день не равны
                Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+sDay1+'-'+IntToStr(Year2)+sMonth2+sDay2;
                // проверка на несколько месяцев разных лет
                if (bMonthStart and bMonthEnd and(Year1<>Year2)) then
                  Edit1.Text:='irda_'+IntToStr(Year1)+sMonth1+'-'+IntToStr(Year2)+sMonth2;
                // проверка запроса по годам
                if (bYearStart and bYearEnd and(Year1<>Year2)) then
                  Edit1.Text:='irda_'+IntToStr(Year1)+'-'+IntToStr(Year2);
              end
        end;
    end;
end;

procedure TMainForm.ACTION_RebuildSQLExecute(Sender: TObject);
var
  SF: TextFile;
  S, S1, S2, S3: string;
  SL, SL1: TStringList;
  BeginDate, EndDate, CurrentDate, OneDay: TDate;
  Year, Month, Day: word;
  i, j: integer;
  suffix: string;

  procedure add_replace_(s: string);
  begin
    with Memo1.Lines do
      begin
        // заменить записи, содержащиеся в таблице "vlad.ird_20040216_final" записями из таблицы "vlad.ird_20040216_temp_rm_notnull"
        // и подставить соответствующее значение поля "sifra" из таблицы "vlad.prijave_q_temp"
        Append('REPLACE INTO vlad.ird_'+SL1.Strings[i]+'_final');
        Append('SELECT id,i.ani,i.ddi,'+#39#39+',i.call_datetime,i.dur,i.rc,i.srv,i.rm,p.sifra,i.izg,i.izgnum,i.druga_info,i.v_oper,i.v_mreza,i.qid,i.ccid,i.d_qid,i.d_ccid,i.qdur');
        Append('FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull i LEFT JOIN vlad.prijave_temp p ON i.rm=p.rm');
        Append('WHERE i.rm>0 AND ADDDATE(i.call_datetime, INTERVAL '+s+') BETWEEN p.poc AND p.zav AND i.sifra=0;');
        // очистить временную таблицу "vlad.ird_20040216_temp_rm_notnull"
        Append('DELETE FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull;');
        // вновь заполнить временную таблицу "vlad.ird_20040216_temp_rm_notnull" записями таблицы "vlad.ird_20040216_final", в которых ещё не указан шифр телефониста (sifra=0)
        Append('INSERT INTO vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull SELECT * FROM vlad.ird_'+SL1.Strings[i]+'_final WHERE sifra=0;');
      end;
  end;

begin
  if ((sSourceFile<>'')and(FileExists(sSourceFile))) then
    begin
      // произвести непосредственно перегонку файла и построить новый внутри Memo
      Screen.Cursor:=crHourGlass;
      GroupBox2.Enabled:=False;
      GroupBox3.Enabled:=False;
      Panel2.Enabled:=False;
      ACTION_ChoisePrijavesExportFile.Enabled:=False;
      ACTION_RebuildSQL.Enabled:=False;
      ACTION_SaveSQL.Enabled:=False;
      ACTION_Exit.Enabled:=False;
      Memo1.Clear;
      SL:=TStringList.Create;
      SL1:=TStringList.Create;
      OneDay:=EncodeDate(2004, 1, 2)-EncodeDate(2004, 1, 1);
      BeginDate:=DateTimePicker1.Date;
      EndDate:=DateTimePicker2.Date;
      CurrentDate:=BeginDate;
      repeat
        DecodeDate(CurrentDate, Year, Month, Day);
        S3:=IntToStr(Year)+'-';
        if Month<10 then
          S3:=S3+'0';
        S3:=S3+IntToStr(Month)+'-';
        if Day<10 then
          S3:=S3+'0';
        S3:=S3+IntToStr(Day);
        SL.Append(S3);
        S3:=IntToStr(Year);
        if Month<10 then
          S3:=S3+'0';
        S3:=S3+IntToStr(Month);
        if Day<10 then
          S3:=S3+'0';
        S3:=S3+IntToStr(Day);
        SL1.Append(S3);
        CurrentDate:=CurrentDate+OneDay;
      until CurrentDate>EndDate;
{$I-}
      AssignFile(SF, sSourceFile);
      Reset(SF);
      while not Eof(SF) do
        begin
          ReadLn(SF, S);
          S1:=Trim(S);
          if S1<>'' then
            if S1[1]<>'#' then
              begin
                S1:=StringReplace(S1, 'DROP TABLE IF EXISTS prijave;', 'DROP TABLE IF EXISTS vlad.prijave;', [rfReplaceAll, rfIgnoreCase]);
                S1:=StringReplace(S1, 'DROP TABLE IF EXISTS prijave_q;', 'DROP TABLE IF EXISTS vlad.prijave_q;', [rfReplaceAll, rfIgnoreCase]);
                S2:=StringReplace(S1, 'decimal(8,0)', 'int(8)', [rfReplaceAll, rfIgnoreCase]);
                S1:=StringReplace(S2, '=ISAM', '=MyISAM', [rfReplaceAll, rfIgnoreCase]);
                S2:=UpperCase(Copy(S1, 1, length('INSERT')));
                if (S2='INSERT') then
                  begin
                    Application.ProcessMessages;
                    for i:=0 to SL.Count-1 do
                      begin
                        if Pos(SL.Strings[i], S1)>0 then
                          begin
                            Memo1.Lines.Append(S1);
                            Break;
                          end;
                      end;
                  end
                else
                  Memo1.Lines.Append(S1);
              end;
        end;
      CloseFile(SF);
      // генерация подневных запросов
      if (CHECKBOX_GenerateDayQuery.Enabled and CHECKBOX_GenerateDayQuery.Checked) then
        for i:=0 to SL1.Count-1 do
          begin
            with Memo1.Lines do
              begin
                // работаем с указанной базой данных
                Append('ALTER TABLE vlad.prijave TYPE=MyISAM;');
                Append('ALTER TABLE vlad.prijave_q TYPE=MyISAM;');
                Append('ALTER TABLE vlad.prijave_q ADD INDEX rm (rm), ADD INDEX vripoc (vripoc), ADD INDEX datzav (datzav), ADD INDEX vrizav (vrizav);');
                Append('ALTER TABLE vlad.prijave ADD INDEX rm (rm), ADD INDEX vripoc (vripoc), ADD INDEX datzav (datzav), ADD INDEX vrizav (vrizav);');
                // создаём временную таблицу для выборки данных за одни указанные сутки из таблицы "prijave", предварительно удалив возможно существующую
                Append('DROP TABLE IF EXISTS vlad.prijave_temp;');
                Append('CREATE TABLE vlad.prijave_temp (');
                Append('rbr int(8) NOT NULL auto_increment,');
                Append('sifra char(20) NOT NULL default '+#39#39+',');
                Append('rm char(6) default NULL,');
                Append('poc datetime default '+#39+'0000-00-00 00:00:00'+#39+',');
                Append('zav datetime default '+#39+'0000-00-00 00:00:00'+#39+',');
                Append('stiglo decimal(4,0) default NULL,');
                Append('obradio decimal(4,0) default NULL,');
                Append('tsred decimal(4,0) default NULL,');
                Append('kratki decimal(4,0) default NULL,');
                Append('orgset decimal(4,0) default NULL,');
                Append('connack decimal(4,0) default NULL,');
                Append('orgdur decimal(4,0) default NULL,');
                Append('paused decimal(7,0) default NULL,');
                Append('wait decimal(7,0) default NULL,');
                Append('trans decimal(4,0) default '+#39+'0'+#39+',');
                Append('wrap decimal(7,0) default NULL,');
                Append('nums char(30) default NULL,');
                Append('closed decimal(10,0) default '+#39+'1'+#39+',');
                Append('ccid decimal(3,0) default '+#39+'1'+#39+',');
                Append('PRIMARY KEY (rbr),');
                Append('KEY sifra (sifra),');
                Append('KEY rm (rm),');
                Append('KEY poc (poc),');
                Append('KEY zav (zav)');
                Append(') TYPE=MyISAM PACK_KEYS=1;');
                // создаём временную таблицу для выборки данных за одни указанные сутки из таблицы "prijave_q", предварительно удалив возможно существующую
                Append('DROP TABLE IF EXISTS prijave_q_temp;');
                Append('CREATE TABLE vlad.prijave_q_temp (');
                Append('sifra char(20) NOT NULL default '+#39#39+',');
                Append('rm char(6) default NULL,');
                Append('poc datetime default '+#39+'0000-00-00 00:00:00'+#39+',');
                Append('zav datetime default '+#39+'0000-00-00 00:00:00'+#39+',');
                Append('stiglo decimal(5,0) default NULL,');
                Append('obradio decimal(5,0) default NULL,');
                Append('tsred decimal(5,0) default NULL,');
                Append('kratki decimal(5,0) default NULL,');
                Append('wait decimal(5,0) default NULL,');
                Append('odbio decimal(5,0) default NULL,');
                Append('trans decimal(5,0) default NULL,');
                Append('qid decimal(5,0) default NULL,');
                Append('ccid decimal(4,0) NOT NULL default '+#39+'0'+#39+',');
                Append('priority decimal(4,0) NOT NULL default '+#39+'0'+#39+',');
                Append('KEY sifra (sifra),');
                Append('KEY rm (rm),');
                Append('KEY poc (poc),');
                Append('KEY zav (zav)');
                Append(') TYPE=MyISAM PACK_KEYS=1;');
                // создаём временную таблицу для выборки записей, у которых поле rm РАВНО 0, из таблицы "ird_20040216", предварительно удалив возможно существующую
                Append('DROP TABLE IF EXISTS vlad.ird_'+SL1.Strings[i]+'_temp_rm_null;');
                Append('CREATE TABLE vlad.ird_'+SL1.Strings[i]+'_temp_rm_null (');
                Append('id int(10) unsigned NOT NULL auto_increment,');
                Append('ani char(32) NOT NULL default '+#39#39+',');
                Append('ddi char(32) NOT NULL default '+#39#39+',');
                Append('location char(32) NOT NULL default '+#39#39+',');
                Append('call_datetime datetime default '+#39+'0000-00-00 00:00:00'+#39+',');
                Append('dur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                Append('rc decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('srv decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('rm decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('sifra char(20) NOT NULL default '+#39+'0'+#39+',');
                Append('izg decimal(3,0) NOT NULL default '+#39#39+',');
                Append('izgnum char(32) NOT NULL default '+#39#39+',');
                Append('druga_info decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('v_oper char(8) default NULL,');
                Append('v_mreza char(8) default NULL,');
                Append('qid decimal(3,0) default NULL,');
                Append('ccid decimal(3,0) default NULL,');
                Append('d_qid decimal(3,0) default NULL,');
                Append('d_ccid decimal(3,0) default NULL,');
                Append('qdur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                Append('UNIQUE KEY id (id),');
                Append('KEY ani (ani),');
                Append('KEY ddi (ddi),');
                Append('KEY call_datetime (call_datetime),');
                Append('KEY dur (dur),');
                Append('KEY rc (rc),');
                Append('KEY rm (rm),');
                Append('KEY sifra (sifra),');
                Append('KEY izg (izg),');
                Append('KEY izgnum (izgnum),');
                Append('KEY druga_info (druga_info),');
                Append('KEY v_oper (v_oper),');
                Append('KEY v_mreza (v_mreza),');
                Append('KEY qdur (qdur)');
                Append(') TYPE=MyISAM PACK_KEYS=1;');
                // создаём временную таблицу для выборки записей, у которых поле rm НЕ РАВНО 0, из таблицы "ird_20040216", предварительно удалив возможно существующую
                Append('DROP TABLE IF EXISTS vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull;');
                Append('CREATE TABLE vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull (');
                Append('id int(10) unsigned NOT NULL auto_increment,');
                Append('ani char(32) NOT NULL default '+#39#39+',');
                Append('ddi char(32) NOT NULL default '+#39#39+',');
                Append('location char(32) NOT NULL default '+#39#39+',');
                Append('call_datetime datetime default '+#39+'0000-00-00 00:00:00'+#39+',');
                Append('dur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                Append('rc decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('srv decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('rm decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('sifra char(20) NOT NULL default '+#39+'0'+#39+',');
                Append('izg decimal(3,0) NOT NULL default '+#39#39+',');
                Append('izgnum char(32) NOT NULL default '+#39#39+',');
                Append('druga_info decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('v_oper char(8) default NULL,');
                Append('v_mreza char(8) default NULL,');
                Append('qid decimal(3,0) default NULL,');
                Append('ccid decimal(3,0) default NULL,');
                Append('d_qid decimal(3,0) default NULL,');
                Append('d_ccid decimal(3,0) default NULL,');
                Append('qdur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                Append('UNIQUE KEY id (id),');
                Append('KEY ani (ani),');
                Append('KEY ddi (ddi),');
                Append('KEY call_datetime (call_datetime),');
                Append('KEY dur (dur),');
                Append('KEY rc (rc),');
                Append('KEY rm (rm),');
                Append('KEY sifra (sifra),');
                Append('KEY izg (izg),');
                Append('KEY izgnum (izgnum),');
                Append('KEY druga_info (druga_info),');
                Append('KEY v_oper (v_oper),');
                Append('KEY v_mreza (v_mreza),');
                Append('KEY qdur (qdur)');
                Append(') TYPE=MyISAM PACK_KEYS=1;');
                // создаём таблицу для выборки записей в которых указан шифр телефонистки, обслужившей звонок, и всех записей о звонках на автоинформатор из таблицы "arj.ird_20040216", предварительно удалив возможно существующую
                Append('DROP TABLE IF EXISTS vlad.ird_'+SL1.Strings[i]+'_final;');
                Append('CREATE TABLE vlad.ird_'+SL1.Strings[i]+'_final (');
                Append('id int(10) unsigned NOT NULL auto_increment,');
                Append('ani char(32) NOT NULL default '+#39#39+',');
                Append('ddi char(32) NOT NULL default '+#39#39+',');
                Append('location char(32) NOT NULL default '+#39#39+',');
                Append('call_datetime datetime default '+#39+'0000-00-00 00:00:00'+#39+',');
                Append('dur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                Append('rc decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('srv decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('rm decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('sifra char(20) NOT NULL default '+#39+'0'+#39+',');
                Append('izg decimal(3,0) NOT NULL default '+#39#39+',');
                Append('izgnum char(32) NOT NULL default '+#39#39+',');
                Append('druga_info decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('v_oper char(8) default NULL,');
                Append('v_mreza char(8) default NULL,');
                Append('qid decimal(3,0) default NULL,');
                Append('ccid decimal(3,0) default NULL,');
                Append('d_qid decimal(3,0) default NULL,');
                Append('d_ccid decimal(3,0) default NULL,');
                Append('qdur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                Append('UNIQUE KEY id (id),');
                Append('KEY ani (ani),');
                Append('KEY ddi (ddi),');
                Append('KEY call_datetime (call_datetime),');
                Append('KEY dur (dur),');
                Append('KEY rc (rc),');
                Append('KEY rm (rm),');
                Append('KEY sifra (sifra),');
                Append('KEY izg (izg),');
                Append('KEY izgnum (izgnum),');
                Append('KEY druga_info (druga_info),');
                Append('KEY v_oper (v_oper),');
                Append('KEY v_mreza (v_mreza),');
                Append('KEY qdur (qdur)');
                Append(') TYPE=MyISAM PACK_KEYS=1;');
                // создаём таблицу для выборки записей в которых не удалось определить телефонистку, обслужившую звонок,  из таблицы "arj.ird_20040216", предварительно удалив возможно существующую
                Append('DROP TABLE IF EXISTS vlad.ird_'+SL1.Strings[i]+'_errors;');
                Append('CREATE TABLE vlad.ird_'+SL1.Strings[i]+'_errors (');
                Append('id int(10) unsigned NOT NULL auto_increment,');
                Append('ani char(32) NOT NULL default '+#39#39+',');
                Append('ddi char(32) NOT NULL default '+#39#39+',');
                Append('location char(32) NOT NULL default '+#39#39+',');
                Append('call_datetime datetime default '+#39+'0000-00-00 00:00:00'+#39+',');
                Append('dur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                Append('rc decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('srv decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('rm decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('sifra char(20) NOT NULL default '+#39+'0'+#39+',');
                Append('izg decimal(3,0) NOT NULL default '+#39#39+',');
                Append('izgnum char(32) NOT NULL default '+#39#39+',');
                Append('druga_info decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                Append('v_oper char(8) default NULL,');
                Append('v_mreza char(8) default NULL,');
                Append('qid decimal(3,0) default NULL,');
                Append('ccid decimal(3,0) default NULL,');
                Append('d_qid decimal(3,0) default NULL,');
                Append('d_ccid decimal(3,0) default NULL,');
                Append('qdur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                Append('UNIQUE KEY id (id),');
                Append('KEY ani (ani),');
                Append('KEY ddi (ddi),');
                Append('KEY call_datetime (call_datetime),');
                Append('KEY dur (dur),');
                Append('KEY rc (rc),');
                Append('KEY rm (rm),');
                Append('KEY sifra (sifra),');
                Append('KEY izg (izg),');
                Append('KEY izgnum (izgnum),');
                Append('KEY druga_info (druga_info),');
                Append('KEY v_oper (v_oper),');
                Append('KEY v_mreza (v_mreza),');
                Append('KEY qdur (qdur)');
                Append(') TYPE=MyISAM PACK_KEYS=1;');
                // вставляем во временную таблицу "prijave_q_temp" все логирования за ближайшие три дня из таблицы "prijave_q"
                Append('INSERT INTO vlad.prijave_q_temp');
                Append('SELECT sifra,rm,CONCAT(DATE_FORMAT(datpoc,"%y%m%d"),TIME_FORMAT(vripoc,"%H%i%s")),CONCAT(DATE_FORMAT(datzav,"%y%m%d"),TIME_FORMAT(vrizav,"%H%i%s")),stiglo,obradio,tsred,kratki,wait,odbio,trans,qid,ccid,priority');
                Append('FROM vlad.prijave_q');
                Append('WHERE datpoc BETWEEN ADDDATE('+#39+SL1.Strings[i]+#39+', INTERVAL -1 DAY) AND '+#39+SL1.Strings[i]+#39+' AND datzav BETWEEN '+#39+SL1.Strings[i]+#39+' AND ADDDATE('+#39+SL1.Strings[i]+#39+', INTERVAL 1 DAY);');
                // вставляем во временную таблицу "prijave_temp" все логирования за ближайшие три дня из таблицы "prijave"
                Append('INSERT INTO vlad.prijave_temp');
                Append('SELECT rbr,sifra,rm,CONCAT(DATE_FORMAT(datpoc,"%y%m%d"),TIME_FORMAT(vripoc,"%H%i%s")),CONCAT(DATE_FORMAT(datzav,"%y%m%d"),');
                Append('TIME_FORMAT(vrizav,"%H%i%s")),stiglo,obradio,tsred,kratki,orgset,connack,orgdur,paused,wait,trans,wrap,nums,closed,ccid FROM vlad.prijave');
                Append('WHERE datpoc BETWEEN ADDDATE('+#39+SL1.Strings[i]+#39+', INTERVAL -1 DAY) AND '+#39+SL1.Strings[i]+#39+' AND datzav BETWEEN '+#39+SL1.Strings[i]+#39+' AND ADDDATE('+#39+SL1.Strings[i]+#39+', INTERVAL 1 DAY);');
                // вставляем все записи во временную таблицу "vlad.ird_20040216_temp_rm_null" из таблицы "arj.ird_20040216"
                Append('INSERT INTO vlad.ird_'+SL1.Strings[i]+'_temp_rm_null SELECT '+#39#39+',ani,ddi,'+#39#39+
                  ',CONCAT(DATE_FORMAT(datum,"%y%m%d"),TIME_FORMAT(vrijeme,"%H%i%s")),dur,rc,srv,rm,0,izg,izgnum,druga_info,v_oper,v_mreza,qid,ccid,d_qid,d_ccid,qdur FROM arj.ird_'+SL1.Strings[i]+';');
                // вставляем все записи во временную таблицу "vlad.ird_20040216_temp_rm_notnull" из таблицы "vlad.ird_20040216_temp_rm_null"
                Append('INSERT INTO vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull SELECT * FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_null;');
                // вставляем ВСЕ записи, взятые из таблицы "arj.ird_20040216" в финальную таблицу "vlad.ird_20040216_final"
                Append('INSERT INTO vlad.ird_'+SL1.Strings[i]+'_final SELECT * FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull;');
                // удаляем из таблицы "vlad.ird_20040216_temp_rm_null" все записи где указано рабочее место (поле rm>0)
                // теперь в таблице "vlad.ird_20040216_temp_rm_null" остаются только те записи, которые были обслужены автоинформатором
                Append('DELETE FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_null WHERE rm>0;');
                // удаляем из таблицы "vlad.ird_20040216_temp_rm_notnull" все записи где не указано рабочее место (поле rm=0)
                // теперь в таблице "vlad.ird_20040216_temp_rm_notnull" остаются только те записи, которые были обслужены телефонистами
                Append('DELETE FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull WHERE rm=0;');
                // удаляем из таблицы "vlad.ird_20040216_final" все записи где не указано рабочее место (поле rm=0)
                // теперь в таблице "vlad.ird_20040216_final" остаются только те записи, которые были обслужены телефонистами
                Append('DELETE FROM vlad.ird_'+SL1.Strings[i]+'_final WHERE rm=0;');
                // заменить записи, содержащиеся в таблице "vlad.ird_20040216_final" записями из таблицы "vlad.ird_20040216_temp_rm_notnull"
                // и подставить соответствующее значение поля "sifra" из таблицы "vlad.prijave_q_temp"
                Append('REPLACE INTO vlad.ird_'+SL1.Strings[i]+'_final');
                Append('SELECT id,i.ani,i.ddi,'+#39#39+',i.call_datetime,i.dur,i.rc,i.srv,i.rm,p.sifra,i.izg,i.izgnum,i.druga_info,i.v_oper,i.v_mreza,i.qid,i.ccid,i.d_qid,i.d_ccid,i.qdur');
                Append('FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull i LEFT JOIN vlad.prijave_q_temp p ON i.rm=p.rm');
                Append('WHERE i.rm>0 AND i.qid=p.qid AND i.call_datetime BETWEEN p.poc AND p.zav;');
                // очистить временную таблицу "vlad.ird_20040216_temp_rm_notnull"
                Append('DELETE FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull;');
                // вновь заполнить временную таблицу "vlad.ird_20040216_temp_rm_notnull" записями таблицы "vlad.ird_20040216_final", в которых ещё не указан шифр телефониста (sifra=0)
                Append('INSERT INTO vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull SELECT * FROM vlad.ird_'+SL1.Strings[i]+'_final WHERE sifra=0;');
                // заменить записи, содержащиеся в таблице "vlad.ird_20040216_final" записями из таблицы "vlad.ird_20040216_temp_rm_notnull"
                // и подставить соответствующее значение поля "sifra" из таблицы "vlad.prijave_q_temp"
                Append('REPLACE INTO vlad.ird_'+SL1.Strings[i]+'_final');
                Append('SELECT id,i.ani,i.ddi,'+#39#39+',i.call_datetime,i.dur,i.rc,i.srv,i.rm,p.sifra,i.izg,i.izgnum,i.druga_info,i.v_oper,i.v_mreza,i.qid,i.ccid,i.d_qid,i.d_ccid,i.qdur');
                Append('FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull i LEFT JOIN vlad.prijave_temp p ON i.rm=p.rm');
                Append('WHERE i.rm>0 AND i.call_datetime BETWEEN p.poc AND p.zav AND i.sifra=0;');
                // очистить временную таблицу "vlad.ird_20040216_temp_rm_notnull"
                Append('DELETE FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull;');
                // вновь заполнить временную таблицу "vlad.ird_20040216_temp_rm_notnull" записями таблицы "vlad.ird_20040216_final", в которых ещё не указан шифр телефониста (sifra=0)
                Append('INSERT INTO vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull SELECT * FROM vlad.ird_'+SL1.Strings[i]+'_final WHERE sifra=0;');
                add_replace_('10 SECOND');
                add_replace_('-10 SECOND');
                add_replace_('20 SECOND');
                add_replace_('-20 SECOND');
                add_replace_('30 SECOND');
                add_replace_('-30 SECOND');
                add_replace_('40 SECOND');
                add_replace_('-40 SECOND');
                add_replace_('50 SECOND');
                add_replace_('-50 SECOND');
                add_replace_('1 MINUTE');
                add_replace_('-1 MINUTE');
                add_replace_('2 MINUTE');
                add_replace_('-2 MINUTE');
                add_replace_('3 MINUTE');
                add_replace_('-3 MINUTE');
                add_replace_('4 MINUTE');
                add_replace_('-4 MINUTE');
                add_replace_('5 MINUTE');
                add_replace_('-5 MINUTE');
                // теперь вставляем в финальную таблицу "vlad.ird_20040216_final" все записи, обслуженные автоинформатором
                Append('INSERT INTO vlad.ird_'+SL1.Strings[i]+'_final SELECT * FROM vlad.ird_'+SL1.Strings[i]+'_temp_rm_null;');
                // удаляем все временные таблицы
                Append('DROP TABLE IF EXISTS vlad.ird_'+SL1.Strings[i]+'_temp_rm_null;');
                Append('DROP TABLE IF EXISTS vlad.ird_'+SL1.Strings[i]+'_temp_rm_notnull;');
                Append('DROP TABLE IF EXISTS vlad.prijave_q_temp;');
                Append('DROP TABLE IF EXISTS vlad.prijave_temp;');
                // заполняем поле location
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (г.Минск)'+#39+' WHERE LENGTH(ani)=8 AND LEFT(ani,2)='+#39+'02'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (г.Минск)'+#39+' WHERE LENGTH(ani)=11 AND LEFT(ani,5)='+#39+'00172'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Таксофоны (г.Минск)'+#39+' WHERE LENGTH(ani)=8 AND LEFT(ani,2)='+#39+'08'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Таксофоны (г.Минск)'+#39+' WHERE LENGTH(ani)=11 AND LEFT(ani,5)='+#39+'00178'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (пригород)'+#39+' WHERE LENGTH(ani)=8 AND LEFT(ani,2)='+#39+'05'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (пригород)'+#39+' WHERE LENGTH(ani)=11 AND LEFT(ani,5)='+#39+'00175'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Мобильные телефоны (Velcom)'+#39+' WHERE LENGTH(ani)=10 AND LEFT(ani,4)='+#39+'0293'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Мобильные телефоны (Velcom)'+#39+' WHERE LENGTH(ani)=10 AND LEFT(ani,4)='+#39+'0296'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Мобильные телефоны (МТС)'+#39+' WHERE LENGTH(ani)=10 AND LEFT(ani,4)='+#39+'0295'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Мобильные телефоны (МТС)'+#39+' WHERE LENGTH(ani)=10 AND LEFT(ani,4)='+#39+'0297'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Мобильные телефоны (Белсел)'+#39+' WHERE LENGTH(ani)=11 AND LEFT(ani,5)='+#39+'00294'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Мобильные телефоны (Белсел)'+#39+' WHERE LENGTH(ani)=11 AND LEFT(ani,5)='+#39+'00292'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Мобильные телефоны (Белсел)'+#39+' WHERE LENGTH(ani)=12 AND LEFT(ani,5)='+#39+'00292'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (Трансгаз)'+#39+' WHERE LENGTH(ani)=11 AND LEFT(ani,5)='+#39+'00176'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (спецузел)'+#39+' WHERE LENGTH(ani)=7 AND LEFT(ani,5)='+#39+'00170'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (спецузел)'+#39+' WHERE LENGTH(ani)=11 AND LEFT(ani,5)='+#39+'00170'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (спецузел)'+#39+' WHERE LENGTH(ani)=8 AND LEFT(ani,5)='+#39+'0017E'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (спецузел)'+#39+' WHERE LENGTH(ani)=9 AND LEFT(ani,5)='+#39+'00226'+#39+';');
                Append('UPDATE vlad.ird_'+SL1.Strings[i]+'_final SET location='+#39+'Телефоны (межгород)'+#39+' WHERE LEFT(ddi,3)='+#39+'990'+#39+' OR LEFT(ddi,4)='+#39+'2222'+#39+';');
                // вставляем в таблицу "vlad.ird_20040216_errors" ошибок все записи из финальной таблицы "vlad.ird_20040216_final", для которых так и не удалось выяснить шифр телефонистки
                // таюлица "vlad.ird_20040216_errors" является чисто информативной, записи из неё впоследствии НЕ НУЖНО переносить в таблицу "vlad.ird_20040216_final"
                Append('INSERT INTO vlad.ird_'+SL1.Strings[i]+'_errors');
                Append('SELECT * FROM vlad.ird_'+SL1.Strings[i]+'_final WHERE sifra=0 AND rm>0 ORDER BY rm, call_datetime;');
              end;
          end;
      // генерация объединяющих и удаляющих хапросов
      if (CHECKBOX_GeneratePeriodQuery.Enabled and CHECKBOX_GeneratePeriodQuery.Checked) then
        begin
          with Memo1.Lines do
            begin
              for i:=0 to 1 do
                begin
                  if (i=0) then
                    suffix:='_final'
                  else
                    suffix:='_errors';
                  Append('DROP TABLE IF EXISTS '+Edit1.Text+suffix+';');
                  Append('CREATE TABLE '+Edit1.Text+suffix+' (');
                  Append('ani char(32) NOT NULL default '+#39#39+',');
                  Append('ddi char(32) NOT NULL default '+#39#39+',');
                  Append('location char(32) NOT NULL default '+#39#39+',');
                  Append('call_datetime datetime default '+#39+'0000-00-00 00:00:00'+#39+',');
                  Append('dur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                  Append('rc decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                  Append('srv decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                  Append('rm decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                  Append('sifra char(20) NOT NULL default '+#39+'0'+#39+',');
                  Append('izg decimal(3,0) NOT NULL default '+#39#39+',');
                  Append('izgnum char(32) NOT NULL default '+#39#39+',');
                  Append('druga_info decimal(3,0) NOT NULL default '+#39+'0'+#39+',');
                  Append('v_oper char(8) default NULL,');
                  Append('v_mreza char(8) default NULL,');
                  Append('qid decimal(3,0) default NULL,');
                  Append('ccid decimal(3,0) default NULL,');
                  Append('d_qid decimal(3,0) default NULL,');
                  Append('d_ccid decimal(3,0) default NULL,');
                  Append('qdur decimal(11,0) NOT NULL default '+#39+'0'+#39+',');
                  Append('KEY ani (ani),');
                  Append('KEY ddi (ddi),');
                  Append('KEY call_datetime (call_datetime),');
                  Append('KEY dur (dur),');
                  Append('KEY rc (rc),');
                  Append('KEY rm (rm),');
                  Append('KEY sifra (sifra),');
                  Append('KEY izg (izg),');
                  Append('KEY izgnum (izgnum),');
                  Append('KEY druga_info (druga_info),');
                  Append('KEY v_oper (v_oper),');
                  Append('KEY v_mreza (v_mreza),');
                  Append('KEY qdur (qdur)');
                  Append(') TYPE=MyISAM PACK_KEYS=1;');
                  for j:=0 to SL1.Count-1 do
                    begin
                      Append('INSERT INTO '+Edit1.Text+suffix+' SELECT ani,ddi,location,call_datetime,dur,rc,srv,rm,sifra,izg,izgnum,druga_info,v_oper,v_mreza,qid,ccid,d_qid,d_ccid,qdur FROM vlad.ird_'+SL1.Strings[j]+suffix+';');
                      if ((CHECKBOX_GenerateDayDropQuery.Checked)and(CHECKBOX_GenerateDayDropQuery.Enabled)) then
                        Append('DROP TABLE IF EXISTS vlad.ird_'+SL1.Strings[j]+suffix+';');
                    end;
                end;
              // Append('# удаление из финальной таблицы данных, продублированных в таблице ошибок');
              // Append('#DELETE FROM vlad.'+Edit1.Text+'_final WHERE sifra=0 AND rm>0;');
              // Append('# внесение в финальную таблицу данных, из таблицы ошибок');
              // Append('#INSERT INTO vlad.'+Edit1.Text+'_final SELECT * FROM vlad.'+Edit1.Text+'_errors; # WHERE sifra>0;');
              // Append('# очистка таблицы ошибок');
              // Append('#DELETE FROM vlad.'+Edit1.Text+'_errors; # WHERE sifra>0;');
            end;
        end;
      SL.Free;
      SL1.Free;
{$I+}
      ACTION_Exit.Enabled:=True;
      Panel2.Enabled:=True;
      ACTION_ChoisePrijavesExportFile.Enabled:=True;
      ACTION_RebuildSQL.Enabled:=True;
      ACTION_CopySQL.Enabled:=True;
      ACTION_ClearSQL.Enabled:=True;
      if Memo1.Lines.Count>0 then
        ACTION_SaveSQL.Enabled:=True;
      GroupBox2.Enabled:=True;
      GroupBox3.Enabled:=True;
      Screen.Cursor:=crDefault;
    end;
end;

end.
