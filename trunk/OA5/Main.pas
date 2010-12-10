unit Main;

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
  Menus,
  ComCtrls,
  PlatformDefaultStyleActnCtrls,
  ActnList,
  ActnMan,
  ImgList,
  OA5Types;

type
  TMainForm=class(TForm)
    MainMenu1: TMainMenu;
    StatusBar1: TStatusBar;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ActionManager1: TActionManager;
    Action_Quit: TAction;
    Action_About: TAction;
    Action_Help: TAction;
    Action_Configuration: TAction;
    Action_Accounts: TAction;
    Action_Reports: TAction;
    Action_Logon: TAction;
    Action_Logout: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    O1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    miStatusBar: TMenuItem;
    ilSmallImages: TImageList;
    ilBigImages: TImageList;
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
  private
    bAboutWindowExist: boolean;
    procedure LogThis(const aMessage, aLogGroupGIUD: string; aMessageType: TLogMessagesType);
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
    procedure PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);

    procedure Do_About(const aButtonVisible: boolean);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  About;

procedure TMainForm.LogThis(const aMessage, aLogGroupGIUD: string; aMessageType: TLogMessagesType);
{ TODO : Убрать ремарки }
(*
  var
  i: integer;
  ListItem: TListItem;
  s: string;
  m: AnsiString;
  aCopyData: TCopyDataStruct;
*)
begin
  { TODO : Убрать ремарки }
  (*
    i:=-1;
    SessionLogEventCount:=SessionLogEventCount+1;

    if Configuration.bUseExternalLog then
    begin
    case aMessageType of
    lmtError:
    s:='ERROR  ';
    lmtWarning:
    s:='WARNING';
    lmtInfo:
    s:='INFO   ';
    lmtSQL:
    s:='SQL    ';
    lmtDebug:
    s:='DEBUG  ';
    end;
    m:=AnsiString(Application.ExeName+#09+CurrentUser.sLogin+#09+ // текущий залогированный пользователь
    s+#09+ // тип сообщения
    StringReplace(FormatDateTime('dd.mm.yyyy hh:nn:ss', Now), ' ', #09, [rfReplaceAll])+#09+
    // дата и время сообщения
    aLogGroupGIUD+#09+StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])+#09+
    // порядковый номер сообщения
    aMessage); // текст сообщения
    // проверка наличия LogKeeper и его запуск в случае отсутствия
    if IsWindow(hLogKeeper) then
    begin // если LogKeeper запущен
    with aCopyData do
    begin
    dwData:=0;
    cbData:=Length(m)+1;
    lpData:=PAnsiChar(m);
    end;
    SendMessage(hLogKeeper, WM_COPYDATA, Longint(MainForm.Handle), Longint(@aCopyData));
    // LogThis('Произведена отправка программе лог-клиента строки данных: ['+m+']', LogGroupGUID, lmtDebug);
    end
    else
    begin
    Configuration.bUseExternalLog:=False;
    pnlLog.Visible:=not Configuration.bUseExternalLog;
    Height:=600-152*integer(Configuration.bUseExternalLog);
    Timer1.Enabled:=Configuration.bUseExternalLog;
    end;
    end;
    if not Configuration.bUseExternalLog then
    begin
    if (((Configuration.bKeepErrorLog)and(aMessageType=lmtError))or((Configuration.bKeepWarningLog)and(aMessageType=lmtWarning))or((Configuration.bKeepInfoLog)and(aMessageType=lmtInfo))or((Configuration.bKeepSQLLog)and(aMessageType=lmtSQL))or
    ((Configuration.bKeepDebugLog)and(aMessageType=lmtDebug))) then
    begin
    case aMessageType of
    lmtError:
    i:=ICON_ERROR;
    lmtWarning:
    i:=ICON_WARNING;
    lmtInfo:
    i:=ICON_INFO;
    lmtSQL:
    i:=ICON_SQL;
    lmtDebug:
    i:=ICON_DEBUG;
    end;
    ListItem:=lvLog.Items.Add;
    ListItem.ImageIndex:=i; // тип сообщения
    ListItem.Caption:=FormatDateTime('dd.mm.yyyy hh:nn:ss', Now); // дата и время сообщения
    ListItem.SubItems.Add(aLogGroupGIUD);
    ListItem.SubItems.Add(StringReplace(Format('%10u', [SessionLogEventCount]), ' ', '0', [rfReplaceAll])); // порядковый номер сообщения
    ListItem.SubItems.Add(CurrentUser.sLogin); // текущий залогированный пользователь
    ListItem.SubItems.Add(aMessage); // текст сообщения
    if (Configuration.iFlushLogOnStringsQuantity>0)and(lvLog.Items.Count=Configuration.iFlushLogOnStringsQuantity) then
    Do_FlushLogToFile;
    if Configuration.bScrollToLastLogMessage then
    SendMessage(lvLog.Handle, LVM_ENSUREVISIBLE, lvLog.Items.Count-1, 0);
    end;
    end;
  *)
end;

procedure TMainForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  LogThis('['+aTitle+']', aLogGroupGUID, lmtDebug);
  LogThis('Начало процедуры...', aLogGroupGUID, lmtDebug);
  { TODO : Убрать ремарки }
  // MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TMainForm.ProcedureFooter(aLogGroupGUID: string);
begin
  { TODO : Убрать ремарки }
  // MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TMainForm.PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  LogThis('Производится попытка отображения модального окна '+aWindowName+'.', aLogGroupGUID, lmtDebug);
  with MainForm do
    begin
      { TODO : Убрать ремарки }
      (*
        aOldBusyState:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
        iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
        Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
      *)
    end;
end;

procedure TMainForm.PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  with MainForm do
    begin
      { TODO : Убрать ремарки }
      (*
        iBusyCounter:=aOldBusyState; // возвращение старого значения счётчика
        Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
      *)
    end;
  LogThis('Окно '+aWindowName+' скрыто.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
const
  LogGroupGUID: string='{44236B13-4C15-4E14-95CF-E114A38D09B4}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_About.Caption+'"', LogGroupGUID);
  Do_About(True);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_About(const aButtonVisible: boolean);
const
  LogGroupGUID: string='{12AD944B-B412-4D41-A2AB-1836C6352752}';
  sModalWinName: string='"О программе..."';
var
  AboutForm: TAboutForm;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);

  if bAboutWindowExist then
    SetForegroundWindow(FindWindow('TAboutForm', 'About "OVERSEER"...'))
  else
    begin
      AboutForm:=TAboutForm.Create(Self);
      with AboutForm do
        try
          bAboutWindowExist:=True;
          Action_Close.Visible:=aButtonVisible;
          PreShowModal(sModalWinName, LogGroupGUID, iBusy);
          ShowModal;
        finally
          PostShowModal(sModalWinName, LogGroupGUID, iBusy);
          Free;
          bAboutWindowExist:=False;
        end;
    end;

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
const
  LogGroupGUID: string='{54E1F179-4466-488D-95E5-3834A9FE152E}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Quit.Caption+'"', LogGroupGUID);
  Close;
  ProcedureFooter(LogGroupGUID);
end;

end.
