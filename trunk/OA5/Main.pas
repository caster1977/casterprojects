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
  OA5Types,
  ExtCtrls;

type
  THackControl=class(TControl);

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
    ilMainFormSmallImages: TImageList;
    ilMainFormBigImages: TImageList;
    pbMain: TProgressBar;
    imState: TImage;
    ilMainFormStateIcons: TImageList;
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
  private
    bFirstRun: boolean;
    bAboutWindowExist: boolean;
    procedure LogThis(const aMessage, aLogGroupGIUD: string; aMessageType: TLogMessagesType);
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter(aLogGroupGUID: string);
    procedure PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
    procedure PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);

    procedure Update_Actions;

    procedure Do_About(const aButtonVisible: boolean);
    procedure Do_Help;
    procedure Do_Configuration;
  public
    iBusyCounter: integer;
    procedure ShowErrorBox(const aHandle: HWND; const aErrorMessage: string; const aLogGroupGUID: string);
    procedure Inc_BusyState(const aLogGroupGUID: string);
    procedure Dec_BusyState(const aLogGroupGUID: string);
    procedure Refresh_BusyState(const aLogGroupGUID: string);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  CommCtrl,
  About,
  Configuration,
  OA5Consts,
  OA5Routines;

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
  MainForm.Inc_BusyState(aLogGroupGUID);
  Application.ProcessMessages;
end;

procedure TMainForm.ProcedureFooter(aLogGroupGUID: string);
begin
  MainForm.Dec_BusyState(aLogGroupGUID);
  LogThis('Окончание процедуры.', aLogGroupGUID, lmtDebug);
  Application.ProcessMessages;
end;

procedure TMainForm.PreShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  LogThis('Производится попытка отображения модального окна '+aWindowName+'.', aLogGroupGUID, lmtDebug);
  with MainForm do
    begin
      aOldBusyState:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
    end;
end;

procedure TMainForm.PostShowModal(const aWindowName: string; const aLogGroupGUID: string; var aOldBusyState: integer);
begin
  with MainForm do
    begin
      iBusyCounter:=aOldBusyState; // возвращение старого значения счётчика
      Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
    end;
  LogThis('Окно '+aWindowName+' скрыто.', aLogGroupGUID, lmtDebug);
end;

procedure TMainForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage, aLogGroupGUID: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage, aLogGroupGUID)
  else
    LogThis('Процедура выполнена без ошибок.', aLogGroupGUID, lmtDebug);
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TMainForm.ShowErrorBox(const aHandle: HWND; const aErrorMessage: string; const aLogGroupGUID: string);
var
  iOldBusyCounter: integer;
begin
  LogThis(aErrorMessage, aLogGroupGUID, lmtError);

  iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
  Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора

  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(MainForm.Caption+' - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  Application.ProcessMessages;

  iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
  Refresh_BusyState(aLogGroupGUID); // обновление состояния индикатора
  Application.ProcessMessages;
end;

procedure TMainForm.Refresh_BusyState(const aLogGroupGUID: string);
begin
  LogThis('Установлен режим "'+Routines_GetConditionalMessage(iBusyCounter>0, 'Занято', 'Готово')+'".', aLogGroupGUID, lmtDebug);
  with MainForm do
    begin
      if iBusyCounter>0 then
        begin
          ilMainFormStateIcons.GetIcon(ICON_BUSY, imState.Picture.Icon);
          // Screen.Cursor:=crHourGlass;
        end
      else
        begin
          ilMainFormStateIcons.GetIcon(ICON_READY, imState.Picture.Icon);
          // Screen.Cursor:=crDefault;
        end;
      { TODO : Убрать ремарки }
      // if not Configuration.bNoStatusBar then
      StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=Routines_GetConditionalMessage(iBusyCounter>0, 'Пожалуйста, подождите...', 'Готово');
    end;
  Application.ProcessMessages;
end;

procedure TMainForm.Inc_BusyState(const aLogGroupGUID: string);
begin
  with MainForm do
    begin
      iBusyCounter:=iBusyCounter+1;
      if iBusyCounter<0 then
        iBusyCounter:=0;
      Refresh_BusyState(aLogGroupGUID);
    end;
end;

procedure TMainForm.Dec_BusyState(const aLogGroupGUID: string);
begin
  with MainForm do
    begin
      iBusyCounter:=iBusyCounter-1;
      if iBusyCounter<0 then
        iBusyCounter:=0;
      Refresh_BusyState(aLogGroupGUID);
    end;
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

procedure TMainForm.Action_HelpExecute(Sender: TObject);
const
  LogGroupGUID: string='{833A3420-BD1D-4E91-B93C-52B5E6097903}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', LogGroupGUID);
  Do_Help;
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

procedure TMainForm.Do_Help;
const
  LogGroupGUID: string='{75115337-2C85-4E66-8682-600655E65900}';
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура открытия справочного файла программы', LogGroupGUID);

  LogThis('Производится попытка открытия справочного файла программы...', LogGroupGUID, lmtInfo);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    Routines_GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{C8F9C829-6C14-494B-A3E4-8BB9C81315DD}';
var
  PanelRect: TRect;
begin
  bFirstRun:=True;

  // предварительная инициализация компонентов
  THackControl(pbMain).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
  pbMain.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right-PanelRect.Left, PanelRect.Bottom-PanelRect.Top);

  THackControl(imState).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
  imState.SetBounds(PanelRect.Left+1, PanelRect.Top+1, PanelRect.Right-PanelRect.Left+1, PanelRect.Bottom-PanelRect.Top+1);

  Update_Actions;
end;

procedure TMainForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{C4BC0413-F2EF-4D45-8B02-E6CA2C908B04}';
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID);

  if bFirstRun then
    begin
      iBusyCounter:=0;
      bFirstRun:=False;
    end;
  Refresh_BusyState(LogGroupGUID);

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Update_Actions;
const
  LogGroupGUID: string='{455018F4-DC3C-4B17-876A-65E39F204633}';
begin
  ProcedureHeader('Процедура обновления состояния действий соединения с сервером', LogGroupGUID);

  { TODO : Убрать ремарки }
  (*
    Action_Logon.Enabled:=not CurrentUser.bLogged;
    Action_Logon.Visible:=Action_Logon.Enabled;
    Action_Logout.Enabled:=not Action_Logon.Enabled;
    Action_Logout.Visible:=Action_Logout.Enabled;
    LogThis(PWideChar('Действие "'+Action_Logon.Caption+'" '+Routines_GetConditionalMessage(Action_Logon.Enabled, 'включено', 'отключено')+', '+'действие "'+Action_Logout.Caption+'" '+Routines_GetConditionalMessage(Action_Logout.Enabled, 'включено',
    'отключено')+'.'), LogGroupGUID, lmtDebug);
    Action_Accounts.Enabled:=CurrentUser.bLogged and CurrentUser.bIsAdmin;
    Action_Accounts.Visible:=Action_Accounts.Enabled;
    Action_Process.Enabled:=CurrentUser.bLogged;
    Action_Process.Visible:=Action_Process.Enabled;
    miActions.Visible:=Action_Process.Visible or Action_Process.Visible;
    Application.ProcessMessages;
  *)

  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
const
  LogGroupGUID: string='{2F075D7E-750D-4B06-903F-73D8717518B1}';
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Configuration.Caption+'"', LogGroupGUID);
  Do_Configuration;
  ProcedureFooter(LogGroupGUID);
end;

procedure TMainForm.Do_Configuration;
const
  LogGroupGUID: string='{797493AC-5FA8-4E65-89C1-7FB0CC1C5824}';
  sModalWinName: string='настроек программы';
var
  sErrorMessage: string;
  bError: boolean;
  ConfigurationForm: TConfigurationForm;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, LogGroupGUID);
  bError:=False;

  ConfigurationForm:=TConfigurationForm.Create(Self);
  with ConfigurationForm do
    try
      PreShowModal(sModalWinName, LogGroupGUID, iBusy);
      ShowModal;
    finally
      PostShowModal(sModalWinName, LogGroupGUID, iBusy);
      Free;
    end;


  PreFooter(Handle, bError, sErrorMessage, LogGroupGUID);
  ProcedureFooter(LogGroupGUID);
end;

end.
