unit CastersPackage.uISingletonAppSession;

interface

type
  ISingletonAppSession = interface
    ['{CE8C06B6-49A1-45C2-93E0-79574FB16779}']

    /// <summary>
    /// Процедура отображения диалога с сообщением об ошибке
    /// </summary>
    procedure ShowError;

    /// <summary>
    /// Функция создания уникальной сессии
    /// </summary>
    function Start: Boolean;

    /// <summary>
    /// Функция остановки уникальной сессии
    /// </summary>
    function Stop: Boolean;

    /// <summary>
    /// Процедура отправки программе сообщения о необходимости самоактивации
    /// (всплывания)
    /// </summary>
    procedure Activate;
  end;

implementation

end.
