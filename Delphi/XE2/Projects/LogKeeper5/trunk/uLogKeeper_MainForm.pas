unit uLogKeeper_MainForm;

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
  CastersPackage.uLogProvider,
  ExtCtrls,
  ComCtrls,
  ImgList,
  AppEvnts;

type
  TMainForm=class(TForm)
    Log: TLogProvider;
    StatusBar1: TStatusBar;
    pbMain: TProgressBar;
    imState: TImage;
    ilMainFormStateIcons: TImageList;
    ApplicationEvents1: TApplicationEvents;
    procedure FormShow(Sender: TObject);
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
  strict private
    bFirstRun: boolean;
    iBusyCounter: integer;
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreShowModal(const aWindowName: string; var aOldBusyState: integer);
    procedure PostShowModal(const aWindowName: string; var aOldBusyState: integer);
    procedure PreFooter(aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure ShowErrorBox(const aHandle: HWND; const aErrorMessage: string);
    procedure Inc_BusyState;
    procedure Dec_BusyState;
    procedure Refresh_BusyState;
  end;

var
  MainForm: TMainForm;
  msgLogKeeperClientQuery, msgLogKeeperClientAnswer: cardinal;

implementation

{$R *.dfm}

uses
  uLogKeeper_Consts,
  CastersPackage.uRoutines;

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
        ilMainFormStateIcons.GetIcon(ICON_BUSY, imState.Picture.Icon)
      else
        ilMainFormStateIcons.GetIcon(ICON_READY, imState.Picture.Icon);
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

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  if Msg.message=msgLogKeeperClientQuery then
    begin
      PostMessage(Msg.wParam, msgLogKeeperClientAnswer, Handle, 0);
      Handled:=True;
      MessageBox(Handle, PWideChar('Получено сообщение msgLogKeeperClientQuery в форму '+Name+'!'), PWideChar('LogKeeper - Информация!'), MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
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

procedure TMainForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('Процедура-обработчик события отображения окна', '{9F96D348-2423-4E7C-94F0-833BA86269F3}');

  if bFirstRun then
    begin
      iBusyCounter:=0;
      bFirstRun:=False;
    end;
  Refresh_BusyState;

  ProcedureFooter;
end;

initialization
  msgLogKeeperClientQuery:=RegisterWindowMessage('msgLogKeeperClientQuery');
  msgLogKeeperClientAnswer:=RegisterWindowMessage('msgLogKeeperClientAnswer');
end.
