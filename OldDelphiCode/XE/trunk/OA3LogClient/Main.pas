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
  ActnList,
  ToolWin,
  ActnMan,
  ActnCtrls,
  XPStyleActnCtrls,
  Menus,
  ImgList,
  ComCtrls,
  StdCtrls,
  getFVI,
  ScktComp,
  AppEvnts,
  ShellAPI;

const
  WM_NOTIFYTRAYICON=WM_USER+1;
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_ITEMS_COUNT_PANEL_NUMBER: integer=1;
  STATUSBAR_HINT_PANEL_NUMBER: integer=2;

type
  TMainForm= class(TForm)
    StatusBar1: TStatusBar;
    ImageList1: TImageList;
    ActionManager1: TActionManager;
    Action_Quit: TAction;
    ActionToolBar1: TActionToolBar;
    ListBox1: TListBox;
    Action_About: TAction;
    Action_Help: TAction;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu1: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N9: TMenuItem;
    N8: TMenuItem;
    ImageList2: TImageList;
    Action_Restore: TAction;
    gsFileVersionInfo1: TgsFileVersionInfo;
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure Action_RestoreExecute(Sender: TObject);
    procedure ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
  private
    procedure WMTRAYICONNOTIFY(var Msg: TMessage); message WM_NOTIFYTRAYICON;
  public
    bAbout_WindowExist: boolean;
    bStartingNormalShutdown: boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  About;

var
  TrayIconData: TNotifyIconData;
  TrayIcon: TIcon;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close; // инициировать завершение приложения
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
begin
  if (FileExists(ExpandFileName(Application.HelpFile))) then // если на диске существует файл справки
    Application.HelpContext(0) // отобразить оглавление справки
  else
    MessageBox(MainForm.Handle, PChar('Извините, справочный файл к данной программе не найден.'), PChar('Ошибка!'), MB_OK+MB_ICONERROR); // иначе - выдать сообщение об ошибке
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
var
  s: string;
  p: integer;
begin
  Action_Restore.Execute; // развернуть окно программы
  if bAbout_WindowExist then // если окно "О программе..." уже где-то выведено
    SetForegroundWindow(FindWindow('TAboutForm', 'About "OperARM3 Log Client"...')) // вытащить его на передний план
  else // иначе
    begin
      with TAboutForm.Create(Self) do // создать окно "О программе..."
        try // попытаться выполнить нижеследующие действия
          bAbout_WindowExist:=True; // установить флаг в состояние "окно есть"
          Button1.Visible:=True; // отобразить кнопку "Закрыть окно"
          Timer1.Enabled:=False; // отключить таймер, отвечающий за "плавное" появление окна
          AlphaBlendValue:=222; // установить степень непрозрачности окна
          Timer2.Enabled:=False; // отключить таймер, отвечающий за автоматическое закрытие окна по истечению промежутка времени
          s:=gsFileVersionInfo1.FileVersion; // получить строку формата X.X.X.X с версией приложения
          p:=LastDelimiter('.', s); // найти позицию последней токи в версии приложения
          s:=copy(s, 1, p-1); // и скопировать всю строку до этого места
          Label2.Caption:=Format('Версия %s билд %s', [s, gsFileVersionInfo1.GetBuildOnly]); // вывести строку с версией и билдом приложения
          Label3.Caption:=gsFileVersionInfo1.LegalCopyright; // вывести информацию о копирайте приложения
          ShowModal; // отобразить окно на экране, как модальное
        finally // и в любом случае - удалось или не удалось выполнить что-либо из вышеперечисленных действий
          Free; // закрыть окно и очистить память
          bAbout_WindowExist:=False; // установить флаг в состояние "окна нет"
        end;
    end;
end;

procedure TMainForm.WMTRAYICONNOTIFY(var Msg: TMessage);
begin
  case Msg.LParam of
    WM_LBUTTONDBLCLK:
      begin
        Action_Restore.Execute;
      end;
    WM_LBUTTONDOWN:
      begin
        if MainForm.Visible then
          SetForegroundWindow(MainForm.Handle);
      end;
    WM_RBUTTONDOWN:
      begin
        SetForegroundWindow(MainForm.Handle);
        PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
        PostMessage(MainForm.Handle, WM_NULL, 0, 0);
      end;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  s: string;
begin
  gsFileVersionInfo1.Filename:=Application.ExeName; // подключение модуля получения информации о приложении (версия, копирайт и т.д.)
  if not(FileExists(ExpandFileName(Application.HelpFile))) then // если не найден файл справки к программе
    begin
      Action_Help.Enabled:=False; // делаем недоступным действие вызова справки
      Action_Help.Visible:=False; // делаем невидимым действие вызова справки
    end;
  // если при предыдущем запуске остались непереданные сообщения - загрузить их из файла
  s:=ExtractFilePath(ExpandFileName(Application.ExeName))+'OA3_UnSendedLog.dat';
  if FileExists(s) then
    ListBox1.Items.LoadFromFile(s);
  // ClientSocket1.Open;
  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE)or WS_EX_TOOLWINDOW);
  TrayIcon:=Application.Icon;
  with TrayIconData do
    begin
      cbSize:=SizeOf(TNotifyIconData);
      Wnd:=MainForm.Handle;
      uID:=1;
      uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP;
      uCallBackMessage:=WM_NOTIFYTRAYICON;
      hIcon:=TrayIcon.Handle;
      szTip:=('OperARM3 Log Client');
    end;
  Shell_NotifyIcon(NIM_ADD, @TrayIconData);
  ApplicationEvents1.OnIdle:=ApplicationEvents1Idle;
end;

procedure TMainForm.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  // LastSocketErrorEvent:=ErrorEvent;
  // if ErrorEvent=eeConnect then
  // begin
  // ErrorCode:=0;
  // if MessageBox(MainForm.Handle,PChar('Произошла ошибка при подключению к лог-серверу!'),PChar('Ошибка!'),MB_OKCANCEL+MB_DEFBUTTON1+MB_ICONERROR)=IDOK then
  // begin
  // ClientSocket1.Close;
  // ClientSocket1.Open;
  // end;
  // end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ListBox1.Items.Count>0 then
    CanClose:=MessageBox(MainForm.Handle, PChar('Вы действительно хотите сохранить на диске результаты работы и завершить работу программы?'), PChar(MainForm.Caption+' - '+'Подтверждение завершения работы программы'),
      MB_OKCANCEL+MB_ICONWARNING+MB_DEFBUTTON2)=IDOK;
  if CanClose then
    begin
      Shell_NotifyIcon(NIM_DELETE, @TrayIconData);
      // ClientSocket1.Close;
      ListBox1.Items.SaveToFile(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA3_UnSendedLog.dat'); // если остались непереданные сообщения - записать их в файл
    end;
end;

procedure TMainForm.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
begin
  // ListBox1.Items.Add(Socket.ReceiveText);
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint); // вывести на панели статуса строку с текущей всплывающей подсказкой
end;

procedure TMainForm.ApplicationEvents1Idle(Sender: TObject; var Done: Boolean);
var
  hOA3: HWND;
begin
  StatusBar1.Panels[STATUSBAR_ITEMS_COUNT_PANEL_NUMBER].Text:='Сообщений:'+#09#09+IntToStr(ListBox1.Items.Count); // вывести на панели статуса строку с текущей всплывающей подсказкой
  ListBox1.Enabled:=ListBox1.Items.Count>0;
  if ((ListBox1.ItemIndex<0)and(ListBox1.Enabled)) then
    ListBox1.ItemIndex:=0;
  // if ListBox1.Items.Count>0 then
  // begin
  // while (ListBox1.Items.Count>0) and (ClientSocket1.Socket.Connected) do
  // begin
  // { TODO : Отправка первой в списке строки на лог-сервер}
  // ClientSocket1.Socket.SendText(ListBox1.Items[0]);
  // ListBox1.Items.Delete(0); // удаление первой строки в списке
  // end;
  // if not ClientSocket1.Socket.Connected then
  // begin
  // if (LastSocketErrorEvent=eeConnect) then
  // if MessageBox(MainForm.Handle,PChar('Произошла ошибка при подключению к лог-серверу!'),PChar('Ошибка!'),MB_OKCANCEL+MB_DEFBUTTON1+MB_ICONERROR)=IDOK then
  // begin
  // ClientSocket1.Close;
  // ClientSocket1.Open;
  // end;
  // end;
  // end;
  // проверка наличия программы OA3
  hOA3:=FindWindow('TMainForm', 'OperARM3'); // получение хэндла окна лог-клиента
  if (hOA3=0) then // если не было найдено окно операторской программы
    begin
      // MessageBox(MainForm.Handle,PChar('Приложение было закрыто!'),PChar('Ошибка!'),MB_OK+MB_ICONEXCLAMATION);
      { TODO : Передача недоотправленных сообщений на сервер
        и завершение работы программы. }
      Close; // инициировать завершение приложения
    end;
end;

procedure TMainForm.Action_RestoreExecute(Sender: TObject);
begin
  Application.Restore;
  MainForm.Visible:=True;
  SetForegroundWindow(MainForm.Handle);
end;

procedure TMainForm.ApplicationEvents1Minimize(Sender: TObject);
begin
  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE)or WS_EX_TOOLWINDOW);
  MainForm.Visible:=False;
end;

end.
