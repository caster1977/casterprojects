unit uMainForm;

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
  uUserClass,
  uConfigurationClass,
  ExtCtrls,
  CodeSiteLogging,
  uLogProvider,
  StdCtrls,
  Sockets,
  IdTCPConnection,
  IdTCPClient,
  IdBaseComponent,
  IdComponent,
  IdUDPBase,
  IdUDPClient,
  xmldom,
  XMLIntf,
  msxmldom,
  XMLDoc;

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
    Log: TLogProvider;
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    bFirstRun: boolean;
    bAboutWindowExist: boolean;
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreShowModal(const aWindowName: string; var aOldBusyState: integer);
    procedure PostShowModal(const aWindowName: string; var aOldBusyState: integer);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);

    procedure Update_Actions;

    procedure Do_About(const aButtonVisible: boolean);
    procedure Do_Help;
    procedure Do_Configuration;
  public
    Configuration: TConfiguration;
    CurrentUser: TUser;
    iBusyCounter: integer;
    procedure ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);
    procedure Inc_BusyState;
    procedure Dec_BusyState;
    procedure Refresh_BusyState;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  CommCtrl,
  uAboutForm,
  uConfigurationForm,
  OA5Consts,
  uRoutines;

procedure TMainForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TMainForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TMainForm.PreShowModal(const aWindowName: string; var aOldBusyState: integer);
begin
  Log.SendDebug('Производится попытка отображения модального окна '+aWindowName+'.');
  with MainForm do
    begin
      aOldBusyState:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
      iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
      Refresh_BusyState; // обновление состояния индикатора
    end;
end;

procedure TMainForm.PostShowModal(const aWindowName: string; var aOldBusyState: integer);
begin
  with MainForm do
    begin
      iBusyCounter:=aOldBusyState; // возвращение старого значения счётчика
      Refresh_BusyState; // обновление состояния индикатора
    end;
  Log.SendDebug('Окно '+aWindowName+' скрыто.');
end;

procedure TMainForm.PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('Процедура выполнена без ошибок.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TMainForm.ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);
var
  iOldBusyCounter: integer;
begin
  Log.SendError(aErrorMessage);

  iOldBusyCounter:=iBusyCounter; // сохранение значения счётчика действий, требующих состояния "занято"
  iBusyCounter:=0; // обнуление счётчика перед открытием модального окна
  Refresh_BusyState; // обновление состояния индикатора

  MessageBox(aHandle, PWideChar(aErrorMessage), PWideChar(MainForm.Caption+' - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  Application.ProcessMessages;

  iBusyCounter:=iOldBusyCounter; // возвращение старого значения счётчика
  Refresh_BusyState; // обновление состояния индикатора
  Application.ProcessMessages;
end;

procedure TMainForm.Refresh_BusyState;
begin
  Log.SendDebug('Установлен режим "'+Routines.GetConditionalString(iBusyCounter>0, 'Занято', 'Готово')+'".');
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
      StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=Routines.GetConditionalString(iBusyCounter>0, 'Пожалуйста, подождите...', 'Готово');
    end;
  Application.ProcessMessages;
end;

procedure TMainForm.Inc_BusyState;
begin
  with MainForm do
    begin
      iBusyCounter:=iBusyCounter+1;
      if iBusyCounter<0 then
        iBusyCounter:=0;
      Refresh_BusyState;
    end;
end;

procedure TMainForm.Dec_BusyState;
begin
  with MainForm do
    begin
      iBusyCounter:=iBusyCounter-1;
      if iBusyCounter<0 then
        iBusyCounter:=0;
      Refresh_BusyState;
    end;
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_About.Caption+'"', '{90CC0AAB-ED7C-46FF-97FF-4431F18EBA1A}');
  Do_About(True);
  ProcedureFooter;
end;

procedure TMainForm.Do_About(const aButtonVisible: boolean);
const
  sModalWinName: string='"О программе..."';
var
  AboutForm: TAboutForm;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, '{754C2801-ED59-4595-AC3E-20DBF98F6779}');

  if bAboutWindowExist then
    SetForegroundWindow(FindWindow('TAboutForm', 'About "OVERSEER"...'))
  else
    begin
      AboutForm:=TAboutForm.Create(Self);
      with AboutForm do
        try
          bAboutWindowExist:=True;
          Action_Close.Visible:=aButtonVisible;
          PreShowModal(sModalWinName, iBusy);
          ShowModal;
        finally
          PostShowModal(sModalWinName, iBusy);
          Free;
          bAboutWindowExist:=False;
        end;
    end;

  ProcedureFooter;
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Help.Caption+'"', '{D066E67D-C195-440D-94C2-6757C427DCF6}');
  Do_Help;
  ProcedureFooter;
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Quit.Caption+'"', '{5DB14721-5FC4-4B42-B0DB-4E7C323A2AA2}');
  Close;
  ProcedureFooter;
end;

procedure TMainForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('Процедура открытия справочного файла программы', '{457E450C-4870-4B17-9594-EB7F91B4578E}');

  Log.SendInfo('Производится попытка открытия справочного файла программы...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    Routines.GenerateError('Извините, справочный файл к данной программе не найден.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  PanelRect: TRect;

  procedure BindMainProgressBarToStatusBar;
  begin
    THackControl(pbMain).SetParent(StatusBar1);
    SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
    pbMain.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right-PanelRect.Left, PanelRect.Bottom-PanelRect.Top-1);
  end;

  procedure BindStateImageToStatusBar;
  begin
    THackControl(imState).SetParent(StatusBar1);
    SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
    imState.SetBounds(PanelRect.Left+2, PanelRect.Top+1, PanelRect.Right-PanelRect.Left-4, PanelRect.Bottom-PanelRect.Top-4);
  end;

begin
  bFirstRun:=True;
  CurrentUser:=TUser.Create;
  Configuration:=TConfiguration.Create;
  try
    Configuration.Load;
  except
    Application.HandleException(Self);
  end;

  BindMainProgressBarToStatusBar;
  BindStateImageToStatusBar;

  Update_Actions;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Configuration.Free;
  CurrentUser.Free;
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{9FD296B5-1A3D-4E90-85CA-492271D2B6A9}');

  if bFirstRun then
    begin
      iBusyCounter:=0;
      bFirstRun:=False;
    end;
  Refresh_BusyState;

  ProcedureFooter;
end;

procedure TMainForm.Update_Actions;
begin
  ProcedureHeader('Процедура обновления состояния действий соединения с сервером', '{03351462-40CF-47ED-AE96-3F9E0D9EA148}');

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

  ProcedureFooter;
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик действия "'+Action_Configuration.Caption+'"', '{024B2718-8D00-49A1-9E1E-C02CB2696CE0}');
  Do_Configuration;
  ProcedureFooter;
end;

procedure TMainForm.Do_Configuration;
const
  sModalWinName: string='настроек программы';
var
  sErrorMessage: string;
  bError: boolean;
  OptionsForm: TOptionsForm;
  iBusy: integer;
begin
  ProcedureHeader('Процедура отображения окна '+sModalWinName, '{6D4FF7B1-8713-4149-B8C1-04AC2C48F116}');
  bError:=False;

  OptionsForm:=TOptionsForm.Create(Self);
  with OptionsForm do
    try
      // инициализация значений контролов исходя из текущей конфигурации




      PreShowModal(sModalWinName, iBusy);
      ShowModal;
    finally
      PostShowModal(sModalWinName, iBusy);
      if ModalResult=mrOk then
        try
          Configuration.Save;
        except
          Application.HandleException(Self);
        end;
      Free;
    end;

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

end.
