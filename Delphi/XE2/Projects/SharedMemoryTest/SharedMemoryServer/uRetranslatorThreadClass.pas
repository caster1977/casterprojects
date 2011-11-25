/// <summary>
/// Модуль-обёртка класса TRetranslatorThreadClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uRetranslatorThreadClass;

interface

uses
  System.Classes,
  Winapi.Windows,
  uCommon;

type
  /// <summary>
  /// Класс, наследник <b>TThread</b>, обеспечивающий трансляцию указанного
  /// при создании экземпляра класса оконного сообщения при помощи функции
  /// <b>BroadcastSystemMessage</b>.
  /// </summary>
  TRetranslatorThreadClass=class(TThread)
  strict private
    /// <summary>
    /// Время задержки в милисекундах между циклами передачи сообщения.
    /// </summary>
    FPause: integer;
    /// <summary>
    /// Идентификатор оконного сообщения (значение, возвращённое функцией
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
  protected
    /// <summary>
    /// Главный цикл потока
    /// </summary>
    procedure Execute; override;
  public
    /// <summary>
    /// Конструктор класса.
    /// </summary>
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
    constructor Create(const Msg: cardinal; const wParam: WPARAM=0; const lParam: LPARAM=0; const Pause: integer=CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
  end;

implementation

var
  /// <summary>
  /// Тип получателей сообщения (изначальное значение - только приложения)
  /// </summary>
  Recipients: DWORD=BSM_APPLICATIONS;

constructor TRetranslatorThreadClass.Create(const Msg: cardinal; const wParam: WPARAM=0; const lParam: LPARAM=0; const Pause: integer=CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
begin
  inherited Create(True);
  Priority:=tpLower;
  FreeOnTerminate:=True;
  FPause:=Pause;
  FMessage:=Msg;
  FWParam:=wParam;
  FLParam:=lParam;
end;

procedure TRetranslatorThreadClass.Execute;
begin
  while not Terminated do
    begin
      BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, FMessage, FWParam, FLParam); // PostMessage(HWND_BROADCAST, FMessage, FWParam, FLParam);
      Sleep(FPause);
    end;
end;

end.
