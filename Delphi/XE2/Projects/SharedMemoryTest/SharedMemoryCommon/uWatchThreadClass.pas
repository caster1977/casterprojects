/// <summary>
/// Модуль-обёртка класса TWatchThreadClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uWatchThreadClass;

interface

uses
  System.Classes,
  Winapi.Windows,
  uCommon;

type

  /// <summary>
  /// Класс, наследник <b>TThread</b>, обеспечивающий проверку существования окна с указанным
  /// при создании экземпляра класса значением Handle.
  /// </summary>
  TWatchThreadClass=class(TThread)
  strict private
    /// <summary>
    /// Handle окна, за существованием которого необходимо следить
    /// </summary>
    FWatchHandle: Thandle;

    /// <summary>
    /// Handle окна, в которое необходимо отправить сообщение о пропадании окна
    /// </summary>
    FListenerHandle: Thandle;

    /// <summary>
    /// Идентификатор оконного сообщения (значение, возвращённое функцией
    /// <b>RegisterWindowMessage</b>).
    /// </summary>
    FMessage: cardinal;

    /// <summary>
    /// Первый агрумент сообщения
    /// </summary>
    FWParam: WPARAM;

    /// <summary>
    /// Второй агрумент сообщения
    /// </summary>
    FLParam: LPARAM;

    /// <summary>
    /// Время задержки в милисекундах между циклами тестирования Handle
    /// </summary>
    FPause: integer;
  protected

    /// <summary>
    /// Главный цикл потока
    /// </summary>
    procedure Execute; override;
  public

    /// <summary>
    /// Конструктор класса.
    /// </summary>
    /// <param name="WatchHandle">
    /// <b>Handle</b> окна, за существованием которого необходимо следить
    /// </param>
    /// <param name="ListenerHandle">
    /// <b>Handle</b> окна, в которое необходимо отправить сообщение о
    /// пропадании окна
    /// </param>
    /// <param name="Msg">
    /// Идентификатор оконного сообщения (значение, возвращённое функцией
    /// <b>RegisterWindowMessage</b>).
    /// </param>
    /// <param name="wParam">
    /// <b>Необязательный параметр.</b> Первый агрумент сообщения. По
    /// умолчанию равен 0.
    /// </param>
    /// <param name="lParam">
    /// <b>Необязательный параметр.</b> Второй аргумент сообщения. По
    /// умолчанию равен 0.
    /// </param>
    /// <param name="Pause">
    /// <b>Необязательный параметр.</b> Время задержки в милисекундах между
    /// циклами передачи сообщения. По умолчанию равен 1000 (1 сек.)
    /// </param>
    constructor Create(const WatchHandle, ListenerHandle: THandle; const Msg: cardinal; const wParam: WPARAM=0; const lParam: LPARAM=0; const Pause: integer=CONST_DEFAULTVALUE_WATCHPAUSE);
  end;

implementation

constructor TWatchThreadClass.Create(const WatchHandle, ListenerHandle: THandle; const Msg: cardinal; const wParam: WPARAM=0; const lParam: LPARAM=0; const Pause: integer=CONST_DEFAULTVALUE_WATCHPAUSE);
begin
  inherited Create(True);
  Priority:=tpLower;
  FreeOnTerminate:=True;
  FWatchHandle:=WatchHandle;
  FListenerHandle:=ListenerHandle;
  FMessage:=Msg;
  FWParam:=wParam;
  FLParam:=lParam;
  FPause:=Pause;
end;

procedure TWatchThreadClass.Execute;
begin
  inherited;
  while not Terminated do
    begin
      if not IsWindow(FWatchHandle) then
        PostMessage(FListenerHandle, FMessage, FWParam, FLParam);
      Sleep(FPause);
    end;
end;

end.
