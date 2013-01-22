(*
  Добавить пункт к системному меню приложения
  --------------------------------------------------------------------------------



  Системное меню вызывается по нажатию на иконку окна. Оно содержит такие команды как "Развернуть", "Восстановить", "Переместить" и т.д. Так вот, теперь у вас появилась возможность добавлять новые пункты к системному меню приложения и обрабатывать их нажатие! Для этого воспользуемся функцией AppendMenu(). В качестве параметров этой функции нужно указать:

  Дескриптор того меню, которое мы хотим изменять
  Флаг, контролирующий появление и поведение пункта меню. может принимать следующие значения:
  MF_BITMAP Для использование изображение в качестве пункта меню. Тогда послежний параметр должен содержать дескриптор изображения.
  MF_CHECKED Устанавливает контрольную метку возле пункта меню.
  MF_DISABLED Показывает, что пункт меню будет неактивным. Его нельзя будет выделить и он приобретёт серое состояние.
  MF_ENABLED Делает пункт меню активным.
  MF_GRAYED Делает пункт меню недоступным.
  MF_MENUBARBREAK Функция похожа на MF_MENUBREAK. Позволяет последующие пункты меню размещать в новой колонке, отделяемой от текущей вертикальной чертой.
  MF_MENUBREAK Позволяет последующие пункты меню размещать в новой колонке, но не отделяет их вертикальной линией.
  MF_OWNERDRAW Указывает, что пункт меню должен будет прорисовываться самостоятельно. До отображения меню в первый раз окно посылает сообщение WM_MEASUREITEM для того, чтобы узнать какой должна быть ширина меню. Так же посылает сообщение WM_DRAWITEM в тот момент, когда пункт меню должен обновляться.
  MF_POPUP Характеризует меню, которое будет открывать подменю или контекстное меню. Тогда последний параметр должен содержать дескриптор этого пункта меню.
  MF_SEPARATOR Отделительная горизонтальная линия. Линия не может становиться неактивной или активной. В данном случае последний параметр будет игнорироваться.
  MF_STRING Показывает, что пункт меню будет содержать строку, которая должна быть указана в последнем параметре.
  MF_UNCHECKED Снимает контрольную метку около пункта меню.
  Идентификатор нового пункта меню. Если значение флага MF_POPUP, тогда этот параметр должен содержать дескриптор контекстного меню.
  Содержание нового пункта меню. Так же зависит от значения флага. Если он содержит такие константа как MF_BITMAP, MF_OWNERDRAW или MF_STRING, тогда здесь нужно указывать: дескриптор изображения, собственную прорисовку пункта меню или строку.
  Если функция выполняется успешно - она возвращает значение отличное от нуля, в противном случае - 0.

  Давайте разберём пример:

  Создайте новой приложение и по созданию окна [Событие OnCreate()] напишите такой код:



  procedure TForm1.FormCreate(Sender: TObject);
  begin
  AppendMenu(GetSystemMenu(Handle, FALSE), MF_SEPARATOR, 0, '');
  AppendMenu(GetSystemMenu(Handle, FALSE), MF_STRING, SC_MyMenuItem, 'Delphi World - это КРУТО!');
  end;




  Здесь мы добавляем два новых пункта в системное меню приложения. Сначала разделительную горизонтальную линию, о чём свидетельствует значение флага MF_SEPARATOR, а затем, пункт меню, который будет содержать строку. Это видно по значению флага MF_STRING. Сама строка, как вы видите указывается в последнем пункте меню. Но это ещё не всё, так же нужно предусмотреть вариант, когда пользователь нажмёт на наш новый пункт меню. Нужно генерировать новое сообщение Windows и обрабатывать его. Для этого в частных объявлениях, т.е. в директиве private напишем такой код:



  private
  { Private declarations }
  procedure WMSysCommand(var Msg: TWMSysCommand); message WM_SYSCOMMAND;




  В разделе implementation напишем следующее:



  const
  SC_MyMenuItem = WM_USER + 1;

  procedure TForm1.WMSysCommand(var Msg: TWMSysCommand);
  begin
  if Msg.CmdType = SC_MyMenuItem then
  ShowMessage('Был нажат наш пункт меню!!!')
  else
  inherited;
  end;







  Добавляем пункты в системное меню Windows
  --------------------------------------------------------------------------------


  Оформил: DeeCo


  Автор: MAD Rodrguez

  Вы, наверное, задавались вопросом, почему системное меню постоянно одно и тоже ? Пример показывает, как добавить туда такие пункты как "About" или "Information", или что-нибудь ещё.

  Совместимость: Delphi 3.x (или выше)

  Нам понадобится две вещи, первая это Item ID, который может быть любым целым числом. Второе это Описание(Caption) для нашего пункта меню. Нам понадобится также процедура, которая будет принимать сообщения Window для определения нажатия на наш пункт меню.

  unit OhYeah;
  interface uses SysUtils,
  WinTypes, WinProcs, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  Menus;
  type
  TForm1 = class(TForm)
  procedure FormCreate(Sender:
  TObject);
  private {Private
  declarations} public {Public declarations}
  procedure WinMsg(var Msg:
  TMsg; var Handled: Boolean);
  procedure DoWhatEever;
  end;
  var
  Form1: TForm1;
  implementation{$R *.DFM}const
  ItemID = 99; // ID номер для пункта меню.  Может быть  любым

  procedure Tform1.WinMsg(var Msg: TMsg; var Handled: Boolean);
  begin
  if
  Msg.Message = WM_SYSCOMMAND then
  if Msg.WParam = ItemID then
  DoWhatEver;
  end;

  procedure TForm1.FormCreate(Sender: TObject);
  begin
  Application.OnMessage := WinMsg;
  AppendMenu(GetSystemMenu(Form1.Handle, False), MF_SEPARATOR, 0, '');
  AppendMenu(GetSystemMenu(Form1.Handle,
  False), MF_BYPOSITION, ItemID, '&amp;My menu');
  AppendMenu(GetSystemMenu
  (Application.Handle, False), MF_SEPARATOR, 0, '');
  AppendMenu(GetSystemMenu(Application.Handle, False),
  MF_BYPOSITION, ItemID, 'My menu minimized');
  end;

  procedure TForm1.DoWhatEver;
  begin
  Exit; // Вы можете добавить здесь всё, что угодно
  end;
  end.






  Изменить системное меню
  --------------------------------------------------------------------------------



  Многие, наверное, уже задумывались над тем, как же внести изменения в системное меню. На примере вы видите, что кнопка закрытия окна неактивна. К тому же команда "Закрыть" вообще отсутствует в системном меню. Системное меню вызывается по щелчку на иконке окна или Alt+Space.

  Если вы напишите следующий код на создание окна (событие OnCreate), то сможете сами в этом убедиться.



  procedure TForm1.FormCreate(Sender: TObject);
  var
  hMenuHandle: HMENU;
  begin
  hMenuHandle := GetSystemMenu(Handle, false);
  if hMenuHandle <> 0 then
  DeleteMenu(hMenuHandle, SC_CLOSE, MF_BYCOMMAND);
  end;




  Объявляем переменную типа HMENU. Получаем дескриптор своего системного меню и помещаем его в переменную:

  Получить дескриптор позволяет функция GetSystemMenu(). Ей в качестве параметра указываем ключевое слово Handle - оно указывает, что будет получен дескриптор нашего системного меню. Второй параметр, равный false, означает, что возвращаемое функцией значение будет не нулевое, а равное дескриптору меню окна.

  Функция DeleteMenu позволяет удалить пункт меню. Сначала ей указываем дескриптор меню - hMenuHandle, затем (SC_CLOSE) значение, идентифицирующее пункт меню, которое может принимать следующие значания:

  sc_close
  "Закрыть",
  sc_move
  "Переместить",
  sc_size
  "Размер",
  sc_minimize
  "Свернуть",
  sc_maximize
  "Развернуть"
  Последний параметр (MF_BYCOMMAND) означает, что предыдущий параметр дает идентификатор пункта меню. Если бы предыдущий параметр указывал на положение пункта меню, отсчитываемое от нуля, тогда бы мы написали MF_BYPOSITION.

  Вот теперь вы можете смело менять наличие и активность того или иного пункта системного меню! Плюс к тому, если вы заботитесь о наличии и активности кнопок на заголовочной полосе, соответствующих пунктам меню, то можете поэкспериментировать со свойствами окна BorderStyle & BorderIcons.
*)

unit CastersPackage.uSysMenu;

interface

uses
  Classes,
  Menus,
  Windows,
  Controls,
  Forms,
  Messages;

type
  TSysMenuLocationKind = (smtTaskBar, smtWindowBar);
  TSysMenuLocation = set of TSysMenuLocationKind;

  TSysMenu = class(TComponent)
  private
    FFormMenuHandle: HMENU;
    FApplicationMenuHandle: HMENU;
    FFormHandle: HWND;
    FApplicationHandle: HWND;
    FMenu: TPopupMenu;
    FVisible: boolean;
    FLocation: TSysMenuLocation;
    // OldWinMsg: TMessageEvent; //
    procedure SetLocation(const Value: TSysMenuLocation);
    procedure SetVisible(const Value: boolean);
    procedure SetMenu(const Value: TPopupMenu);
    procedure AddMenus;
    procedure DeleteMenus;
    procedure Refresh;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure WinMsg(var Msg: tagMSG; var Handled: boolean);
  published
    property Menu: TPopupMenu read FMenu write SetMenu;
    property Visible: boolean read FVisible write SetVisible stored True default True;
    property Location: TSysMenuLocation read FLocation write SetLocation
      default [smtTaskBar, smtWindowBar];
  end;

procedure register;

implementation

procedure register;
begin
  RegisterComponents('CasterComponents', [TSysMenu]);
end;

{ TSysMenu }

constructor TSysMenu.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner is TWinControl then
    FFormHandle := TWinControl(AOwner).Handle;
  FFormMenuHandle := GetSystemMenu(FFormHandle, False);
  if TWinControl(AOwner).Owner is TApplication then
    FApplicationHandle := TApplication(TWinControl(AOwner).Owner).Handle;
  FApplicationMenuHandle := GetSystemMenu(FApplicationHandle, False);
  FLocation := [smtTaskBar, smtWindowBar];
  FVisible := True;
  FMenu := nil;
  // if AOwner is TWinControl then //
  // if TWinControl(Owner).Owner is TApplication then //
  // if Assigned(TApplication(TWinControl(Owner).Owner).OnMessage) then //
  // begin //
  // OldWinMsg:=TApplication(TWinControl(Owner).Owner).OnMessage; //
  // end; //
  Refresh;
end;

procedure TSysMenu.AddMenus;

  procedure AddMenu(AMenuHandle: HWND);
  var
    i: integer;
  begin
    for i := 0 to FMenu.Items.Count - 1 do
    begin
      if FMenu.Items[i].IsLine then
        AppendMenu(AMenuHandle, MF_SEPARATOR, 0, '')
      else
        AppendMenu(AMenuHandle, MF_STRING, i, PChar(FMenu.Items[i].Caption));
    end;
  end;

begin
  if FMenu = nil then
    Exit;
  if smtTaskBar in Location then
  begin
    FApplicationMenuHandle := GetSystemMenu(FApplicationHandle, False);
    AddMenu(FApplicationMenuHandle);
  end;
  if smtWindowBar in Location then
  begin
    FFormMenuHandle := GetSystemMenu(FFormHandle, False);
    AddMenu(FFormMenuHandle);
  end;
  if Owner is TWinControl then
    if TWinControl(Owner).Owner is TApplication then
      TApplication(TWinControl(Owner).Owner).OnMessage := WinMsg;
end;

procedure TSysMenu.WinMsg(var Msg: tagMSG; var Handled: boolean);
var
  i: word;
begin
  if Msg.message = WM_SYSCOMMAND then
  begin
    for i := 0 to FMenu.Items.Count - 1 do
      if Msg.wParam = i then
        FMenu.Items[i].OnClick(nil);
  end;
  // OldWinMsg(Msg, Handled); //
end;

procedure TSysMenu.DeleteMenus;
begin
  // TApplication(TWinControl(Owner).Owner).OnMessage:=OldWinMsg; //
  if smtTaskBar in Location then
    GetSystemMenu(FApplicationHandle, True);
  if smtWindowBar in Location then
    GetSystemMenu(FFormHandle, True);
end;

destructor TSysMenu.Destroy;
begin
  if FVisible then
    DeleteMenus;
  inherited;
end;

procedure TSysMenu.SetLocation(const Value: TSysMenuLocation);
begin
  if FLocation <> Value then
    FLocation := Value;
  Refresh;
end;

procedure TSysMenu.SetMenu(const Value: TPopupMenu);
begin
  if FMenu <> Value then
    FMenu := Value;
  Refresh;
end;

procedure TSysMenu.SetVisible(const Value: boolean);
begin
  if FVisible <> Value then
    FVisible := Value;
  Refresh;
end;

procedure TSysMenu.Refresh;
begin
  DeleteMenus;
  if FVisible then
    AddMenus;
end;

end.
