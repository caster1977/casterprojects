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
  Menus,
  ComCtrls,
  ImgList,
  ScktComp,
  getFVI,
  ShellAPI,
  StdCtrls,
  ExtCtrls,
  SHDocVw;

const
  WM_NOTIFYTRAYICON=WM_USER+$7258;
  STATUSBAR_STATE_PANEL_NUMBER: integer=0;
  STATUSBAR_HINT_PANEL_NUMBER: integer=1;
  WM_USER=$00000400;
  NIN_SELECT=(WM_USER+0);
  NINF_KEY=$00000001;
  NIN_KEYSELECT=NINF_KEY or NIN_SELECT;
  NIN_BALLOONSHOW=(WM_USER+2);
  NIN_BALLOONHIDE=(WM_USER+3);
  NIN_BALLOONTIMEOUT=(WM_USER+4);
  NIN_BALLOONUSERCLICK=(WM_USER+5);
  NIM_SETFOCUS=$00000003;
  NIM_SETVERSION=$00000004;
  NOTIFYICON_VERSION=3;
  NIF_STATE=$00000008;
  NIF_INFO=$00000010;
  NIF_GUID=$00000020;
  NIS_HIDDEN=$00000001;
  NIS_SHAREDICON=$00000002;
  NIIF_NONE=$00000000;
  NIIF_INFO=$00000001;
  NIIF_WARNING=$00000002;
  NIIF_ERROR=$00000003;
  NIIF_ICON_MASK=$0000000F;
  NIIF_NOSOUND=$00000010;

type
  PNotifyIconDataExA=^TNotifyIconDataExA;
  PNotifyIconDataExW=^TNotifyIconDataExW;
  PNotifyIconDataEx=PNotifyIconDataExA;

  _NOTIFYICONDATAEXA= record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..128] of AnsiChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array [0..255] of AnsiChar;
    uTimeout: UINT; // union with uVersion: UINT;
    szInfoTitle: array [0..63] of AnsiChar;
    dwInfoFlags: DWORD;
{$IFDEF _WIN32_IE_600}
    guidItem: TGUID;
{$ENDIF}
  end;

  _NOTIFYICONDATAEXW= record
    cbSize: DWORD;
    Wnd: HWND;
    uID: UINT;
    uFlags: UINT;
    uCallbackMessage: UINT;
    hIcon: HICON;
    szTip: array [0..128] of WideChar;
    dwState: DWORD;
    dwStateMask: DWORD;
    szInfo: array [0..255] of WideChar;
    uTimeout: UINT;
    szInfoTitle: array [0..63] of WideChar;
    dwInfoFlags: DWORD;
{$IFDEF _WIN32_IE_600}
    guidItem: TGUID;
{$ENDIF}
  end;

  _NOTIFYICONDATAEX=_NOTIFYICONDATAEXA;
  TNotifyIconDataExA=_NOTIFYICONDATAEXA;
  TNotifyIconDataExW=_NOTIFYICONDATAEXW;
  TNotifyIconDataEx=TNotifyIconDataExA;
  NOTIFYICONDATAEXA=_NOTIFYICONDATAEXA;
  NOTIFYICONDATAEXW=_NOTIFYICONDATAEXW;
  NOTIFYICONDATAEX=NOTIFYICONDATAEXA;

  TMainForm= class(TForm)
    PopupMenu1: TPopupMenu;
    gsFileVersionInfo1: TgsFileVersionInfo;
    ImageList1: TImageList;
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    StatusBar1: TStatusBar;
    N1: TMenuItem;
    miQuestion: TMenuItem;
    Action_Quit: TAction;
    Action_Help: TAction;
    Action_About: TAction;
    Action_SendMessageToClient: TAction;
    Action_ManageClient: TAction;
    Action_Restore: TAction;
    N2: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N3: TMenuItem;
    GroupBox1: TGroupBox;
    ClientsListBoxPopupMenu: TPopupMenu;
    N15: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    miViewClientIP: TMenuItem;
    miViewClientLoggedUser: TMenuItem;
    Splitter1: TSplitter;
    Timer1: TTimer;
    Panel1: TPanel;
    ClientsListBox: TListBox;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    ListView1: TListView;
    Splitter2: TSplitter;
    GroupBox3: TGroupBox;
    Panel4: TPanel;
    RichEdit1: TRichEdit;
    procedure ListView1Insert(Sender: TObject; Item: TListItem);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure ClientsListBoxDblClick(Sender: TObject);
    procedure ClientsListBoxPopupMenuPopup(Sender: TObject);
    procedure ClientsListBoxMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ServerSocket1ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure Action_RestoreExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Action_SendMessageToClientExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    dtDate: TDateTime;
    procedure DisplayHint(Sender: TObject);
    procedure Minimazing(Sender: TObject);
    procedure WMTRAYICONNOTIFY(var Msg: TMessage); message WM_NOTIFYTRAYICON;
  public
    bAbout_WindowExist: boolean;
    bSendMsgTo_WindowExist: boolean;
    sLastMessage: string;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  About,
  SendMsgTo;

var
  TrayIconDataEx: TNotifyIconDataEx;
  TrayIcon: TIcon;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  dtDate:=Date; { устанавливаем текущую дату - для архивации }
  if not(FileExists(ExpandFileName(Application.HelpFile))) then
    begin
      Action_Help.Enabled:=False;
      Action_Help.Visible:=False;
    end;
  Action_SendMessageToClient.Enabled:=ClientsListBox.Items.Count>0;
  Action_SendMessageToClient.Visible:=ClientsListBox.Items.Count>0;
  ShowWindow(Application.Handle, SW_HIDE);
  SetWindowLong(Application.Handle, GWL_EXSTYLE, GetWindowLong(Application.Handle, GWL_EXSTYLE)or WS_EX_TOOLWINDOW);
  TrayIcon:=MainForm.Icon;
  with TrayIconDataEx do
    begin
      cbSize:=SizeOf(TNotifyIconDataEx);
      Wnd:=MainForm.Handle;
      uID:=0;
      uFlags:=NIF_ICON or NIF_MESSAGE or NIF_TIP;
      uCallBackMessage:=WM_NOTIFYTRAYICON;
      hIcon:=TrayIcon.Handle;
      szTip:='OperARM3 Log Server';
    end;
  if Shell_NotifyIcon(NIM_ADD, @TrayIconDataEx)=False then
    ShowMessage('Thank''s to Billy');
  // ServerSocket1.Open;
  Application.OnMinimize:=Minimazing;
  Application.OnHint:=DisplayHint;
  gsFileVersionInfo1.Filename:=Application.ExeName;
  ClientsListBox.Enabled:=ClientsListBox.Items.Count>0;
end;

procedure CutStringByLimiterToStringList(Source: string; Destination: TStringList; Limiter: char);
var
  i: integer;
  s, s1: string;
begin
  (* процедура преобразования строки в список строк (используя заданный разделитель) *)
  Destination.Sorted:=False;
  Destination.Clear;
  s:=Source;
  while Length(s)>0 do
    begin
      i:=Pos(Limiter, s);
      if (i=0) then
        begin
          Destination.Add(s);
          Exit;
        end
      else
        begin
          s1:=Copy(s, 0, i-1);
          Destination.Add(s1);
          s1:=Copy(s, i+1, Length(s));
          s:=s1;
        end;
    end;
end;

procedure TMainForm.Minimazing(Sender: TObject);
begin
  MainForm.Visible:=False;
end;

procedure TMainForm.WMTRAYICONNOTIFY(var Msg: TMessage);
begin
  case Msg.LParam of
    WM_LBUTTONDBLCLK:
      Action_Restore.Execute;
    WM_LBUTTONDOWN:
      if MainForm.Visible then
        SetForegroundWindow(MainForm.Handle);
    WM_RBUTTONDOWN:
      begin
        SetForegroundWindow(MainForm.Handle);
        PopupMenu1.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y);
        PostMessage(MainForm.Handle, WM_NULL, 0, 0);
      end;
  end;
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
begin
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    MessageBox(MainForm.Handle, PChar('Извините, справочный файл к данной программе не найден.'), PChar('Ошибка!'), MB_OK+MB_ICONERROR);
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
{ var
  s: string;
  p: integer; }
begin
  TrayIconDataEx.cbSize:=SizeOf(TrayIconDataEx);
  TrayIconDataEx.uFlags:=TrayIconDataEx.uFlags or NIF_INFO;
  TrayIconDataEx.szInfo:='Info';
  TrayIconDataEx.szInfoTitle:='Message';
  TrayIconDataEx.uTimeOut:=5000;
  TrayIconDataEx.dwInfoFlags:=NIIF_INFO;
  Shell_NotifyIcon(NIM_MODIFY, @TrayIconDataEx);
  (*
    Action_Restore.Execute;
    if bAbout_WindowExist then
    begin
    SetForegroundWindow(FindWindow('TAboutForm','About "OperARM3 Log Server"...'));
    end
    else
    begin
    with TAboutForm.Create(Self) do
    try
    bAbout_WindowExist:=True;
    Button1.Visible:=True;
    Timer1.Enabled:=False;
    AlphaBlendValue:=222;
    Timer2.Enabled:=False;
    s:=gsFileVersionInfo1.FileVersion;
    p:=LastDelimiter('.',s);
    s:=copy(s,1,p-1);
    Label2.Caption:=Format('Версия %s билд %s',[s,gsFileVersionInfo1.GetBuildOnly]);
    Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
    ShowModal;
    finally
    Free;
    bAbout_WindowExist:=False;
    end;
    end;
    *)
end;

procedure TMainForm.Action_SendMessageToClientExecute(Sender: TObject);
var
  bForAll: boolean;
  // i: integer;
begin
  Action_Restore.Execute;
  if bSendMsgTo_WindowExist then
    begin
      SetForegroundWindow(FindWindow('TSendMsgToForm', nil));
    end
  else
    begin
      with TSendMsgToForm.Create(Self) do
        try
          bSendMsgTo_WindowExist:=True;
          SendMessageTo_Memo.Text:=sLastMessage;
          Action_Send.Enabled:=Trim(SendMessageTo_Memo.Text)<>'';
          ForAll_CheckBox.Enabled:=Action_Send.Enabled;
          MainForm.ActionList1.Images.GetIcon(Action_SendMessageToClient.ImageIndex, Icon);
          ShowModal;
        finally
          bForAll:=ForAll_CheckBox.Checked and(ModalResult=mrOk);
          sLastMessage:=SendMessageTo_Memo.Text;
          Free;
          bSendMsgTo_WindowExist:=False;
        end;
      if bForAll then
        begin
          // for j:=0 to MainForm.ServerSocket1.Socket.ActiveConnections-1 do
          // begin
          // if ListBox1.Items[i]=(MainForm.ServerSocket1.Socket.Connections[j].LocalAddress+':#'+IntToStr(j)) then
          // MainForm.ServerSocket1.Socket.Connections[j].SendText('Hello from server! #:)');
          // end;
        end
      else
        begin
          // for i:=0 to MainForm.ServerSocket1.Socket.ActiveConnections-1 do
          // if MainForm.ServerSocket1.Socket.Connections[i].LocalAddress=ClientsListBox.Items[ClientsListBox.ItemIndex] then
          // MainForm.ServerSocket1.Socket.Connections[i].SendText('Hello from server! #:)');
        end;
    end;
end;

procedure TMainForm.DisplayHint(Sender: TObject);
begin
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=MessageBox(MainForm.Handle, PChar('Вы действительно хотите сохранить на диске результаты работы и завершить работу программы?'), PChar('Подтверждение завершения работы программы'), MB_OKCANCEL+MB_ICONWARNING+MB_DEFBUTTON2)=IDOK;
  { TODO : Добавить при завершении программы запись настроек }
  if CanClose then
    begin
      // ServerSocket1.Close;
      Shell_NotifyIcon(NIM_DELETE, @TrayIconDataEx);
    end;
end;

procedure TMainForm.Action_RestoreExecute(Sender: TObject);
begin
  Application.Restore;
  MainForm.Visible:=True;
  SetForegroundWindow(MainForm.Handle);
end;

procedure TMainForm.ServerSocket1ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
var
  i: integer;
begin
  i:=ClientsListBox.Items.Add(Socket.LocalAddress);
  Action_SendMessageToClient.Enabled:=ClientsListBox.Items.Count>0;
  Action_SendMessageToClient.Visible:=ClientsListBox.Items.Count>0;
  if ClientsListBox.Items.Count>0 then
    begin
      ClientsListBox.Enabled:=True;
      ClientsListBox.Color:=clWindow;
      if ClientsListBox.ItemIndex<0 then
        ClientsListBox.ItemIndex:=i;
    end;
end;

procedure TMainForm.ServerSocket1ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  ClientsListBox.Items.Delete(ClientsListBox.Items.IndexOf(Socket.LocalAddress));
  Action_SendMessageToClient.Enabled:=ClientsListBox.Items.Count>0;
  Action_SendMessageToClient.Visible:=ClientsListBox.Items.Count>0;
  if ClientsListBox.Items.Count=0 then
    begin
      ClientsListBox.Enabled:=False;
      ClientsListBox.Color:=clBtnFace;
    end;
end;

procedure TMainForm.ClientsListBoxMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: integer;
begin
  if Button=mbRight then
    begin
      i:=ClientsListBox.ItemAtPos(Point(X, Y), True);
      if i>-1 then
        ClientsListBox.Selected[i]:=True;
    end;
end;

procedure TMainForm.ClientsListBoxPopupMenuPopup(Sender: TObject);
var
  sLoggedUser: string;
begin
  miViewClientIP.Caption:='IP-адрес:'+#09+ClientsListBox.Items[ClientsListBox.ItemIndex];
  miViewClientLoggedUser.Visible:=True;
  { TODO : Добавить получение имени залогированного пользователя, если он есть }
  // sLoggedUser:= ...;
  miViewClientLoggedUser.Visible:=sLoggedUser>'';
  miViewClientLoggedUser.Caption:='Пользователь: '+#09+sLoggedUser;
end;

procedure TMainForm.ClientsListBoxDblClick(Sender: TObject);
begin
  Action_SendMessageToClient.Execute;
end;

// for i:=0 to MainForm.ServerSocket1.Socket.ActiveConnections-1 do
// if MainForm.ServerSocket1.Socket.Connections[i].LocalAddress=ClientsListBox.Items[ClientsListBox.ItemIndex] then
// MainForm.ServerSocket1.Socket.Connections[i].SendText('OA3_GET_LOGGEDUSER');

procedure TMainForm.Timer1Timer(Sender: TObject);
// var
// a: TDateTime;
// s, p, c: string;
begin
  // a:=Date; // получаем текущую дату
  // if a>dtDate then // если текущая дата больше той, которая была сохранена в переменной
  // begin
  // DateTimeToString(s,'YYYYmmdd',dtDate); // получаем строку-суффикс для создания файла лога и дальнейшей его архивации
  // // создаем новый файл лога
  // // а старый файл лога упаковываем
  // p:=ExtractFilePath(ExpandFileName(Application.ExeName));
  // c:='mf -ep -rr -m5 -mc63:128t+ "'+p+'OA3Logs" "'+p+'OA3Log_'+s+'.log"';
  // ShellExecute(Application.Handle,'open',PChar('rar'),PChar(c),nil,SW_MINIMIZE);
  // end;
  // Timer1.Enabled:=False;
end;

procedure TMainForm.ServerSocket1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  Node: TListItem;
  s: string;
  i: integer;
  SL: TStringList;
begin
  s:=string(Socket.ReceiveText);
  SL:=TStringList.Create;
  try
    CutStringByLimiterToStringList(s, sl, #09);
    Node:=ListView1.Items.Add;
    // Node.Indent:=0;
    if SL[0]='ERROR' then
      begin
        Node.ImageIndex:=4;
        Node.Caption:='Ошибка!';
      end;
    if SL[0]='WARNING' then
      begin
        Node.ImageIndex:=3;
        Node.Caption:='Внимание!';
      end;
    if SL[0]='INFO' then
      begin
        Node.ImageIndex:=5;
        Node.Caption:='Информация';
      end;
    if SL[0]='SQL' then
      begin
        Node.ImageIndex:=-1;
        Node.Caption:='SQL-запрос';
      end;
    Node.StateIndex:=-1;
    Node.SubItems.Add(SL[1]); // Дата
    Node.SubItems.Add(SL[2]); // Время
    Node.SubItems.Add(Socket.LocalAddress); // IP-адрес
    Node.SubItems.Add(SL[3]); // ID
    if SL[4]='' then
      begin
        Node.SubItems.Add('<не указан>');
      end
    else
      Node.SubItems.Add(SL[4]); // Имя пользователя
    for i:=0 to Node.SubItems.Count-1 do
      Node.SubItemImages[i]:=-1;
    Node.SubItems.Add(SL[5]); // Текст сообщения
  finally
    SL.Free;
  end;
end;

procedure TMainForm.ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
var
  s: string;
  i: integer;
begin
  // отрисовка типа сообщения
  s:=Item.Caption;
  RichEdit1.Clear;
  RichEdit1.Lines.Append(s);
  RichEdit1.SelStart:=0;
  RichEdit1.SelLength:=Length(s);
  case Item.ImageIndex of
    -1:
      RichEdit1.SelAttributes.Color:=clBlue; // если сообщение - "SQL"
    3:
      RichEdit1.SelAttributes.Color:=clFuchsia; // если сообщение - "WARNING"
    4:
      RichEdit1.SelAttributes.Color:=clRed; // если сообщение - "ERROR"
    5:
      RichEdit1.SelAttributes.Color:=clGreen; // если сообщение - "INFO"
  end;
  RichEdit1.SelAttributes.Size:=18;
  RichEdit1.SelAttributes.Style:=[fsBold];
  // отрисовка даты
  i:=Length(RichEdit1.Text);
  RichEdit1.Lines.Append(ListView1.Column[1].Caption+':'+#09#09+Item.SubItems[0]);
  RichEdit1.SelStart:=i;
  RichEdit1.SelLength:=Length(ListView1.Column[1].Caption)+1;
  RichEdit1.SelAttributes.Style:=[fsBold];
  // отрисовка времени
  i:=Length(RichEdit1.Text);
  RichEdit1.Lines.Append(ListView1.Column[2].Caption+':'+#09#09+Item.SubItems[1]);
  RichEdit1.SelStart:=i;
  RichEdit1.SelLength:=Length(ListView1.Column[2].Caption)+1;
  RichEdit1.SelAttributes.Style:=[fsBold];
  // отрисовка адреса
  i:=Length(RichEdit1.Text);
  RichEdit1.Lines.Append(ListView1.Column[3].Caption+':'+#09#09+Item.SubItems[2]);
  RichEdit1.SelStart:=i;
  RichEdit1.SelLength:=Length(ListView1.Column[3].Caption)+1;
  RichEdit1.SelAttributes.Style:=[fsBold];
  // отрисовка номера события
  i:=Length(RichEdit1.Text);
  RichEdit1.Lines.Append(ListView1.Column[4].Caption+':'+#09+Item.SubItems[3]);
  RichEdit1.SelStart:=i;
  RichEdit1.SelLength:=Length(ListView1.Column[4].Caption)+1;
  RichEdit1.SelAttributes.Style:=[fsBold];
  // отрисовка имени пользователя
  i:=Length(RichEdit1.Text);
  RichEdit1.Lines.Append(ListView1.Column[5].Caption+':'+#09+Item.SubItems[4]);
  RichEdit1.SelStart:=i;
  RichEdit1.SelLength:=Length(ListView1.Column[5].Caption)+1;
  RichEdit1.SelAttributes.Style:=[fsBold];
  // отрисовка текста сообщения
  i:=Length(RichEdit1.Text);
  RichEdit1.Lines.Append('Текст:'+#09#09+Item.SubItems[5]);
  RichEdit1.SelStart:=i;
  RichEdit1.SelLength:=Length('Текст:');
  RichEdit1.SelAttributes.Style:=[fsBold];
end;

procedure TMainForm.ListView1Insert(Sender: TObject; Item: TListItem);
var
  i: integer;
begin
  for i:=0 to ListView1.Columns.Count-1 do
    begin
      if ListView1.Column[i].Width<>-1 then
        ListView1.Column[i].Width:=-1;
    end;
end;

end.
