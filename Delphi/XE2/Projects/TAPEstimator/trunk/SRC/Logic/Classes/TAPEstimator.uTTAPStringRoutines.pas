unit TAPEstimator.uTTAPStringRoutines;

interface

uses
  System.Classes;

type
  /// <summary>
  /// Класс, содержащий процедуры и функции для работы со строками TAP-файла
  /// </summary>
  TTAPStringRoutines = class

    /// <summary>
    /// Классовая функция, опередляющая, является ли исходная строка
    /// комментарием
    /// </summary>
    /// <param name="AValue">
    /// исходная строка
    /// </param>
    /// <returns>
    /// Если строка является комментарием, будет возвращено значение
    /// <b>True</b>, в противном случае будет возвращено <b>False</b>.
    /// </returns>
    class function IsComment(const AValue: string): Boolean; static;

    /// <summary>
    /// Классовая функция, определяющая, является ли исходная строка
    /// нормализованной
    /// </summary>
    /// <param name="AValue">
    /// исходная строка
    /// </param>
    /// <returns>
    /// Если строка является нормализованной, будет возвращено значение
    /// <b>True</b>, в противном случае будет возвращено <b>False</b>.
    /// </returns>
    class function Normalized(const AValue: string): Boolean; static;

    /// <summary>
    /// Классовая функция, выполняющая нормализацию исходной строки
    /// </summary>
    /// <param name="AValue">
    /// исходная строка
    /// </param>
    /// <returns>
    /// нормализованная строка
    /// </returns>
    class function Normalize(const AValue: string): string;

    /// <summary>
    /// Классовая функция, выполняющая разбиение исходной строки на подстроки
    /// и помещение их в список строк
    /// </summary>
    /// <param name="AValue">
    /// исходная строка
    /// </param>
    /// <returns>
    /// результирующий список строк
    /// </returns>
    class function ToStringList(const AValue: string): TStringList; static;

    /// <summary>
    /// Классовая функция, определяющая, содержит ли исходная строка только
    /// корректные символы
    /// </summary>
    /// <param name="AValue">
    /// исходная строка
    /// </param>
    /// <returns>
    /// Если строка является корректной, будет возвращено значение <b>True</b>
    /// , в противном случае будет возвращено <b>False</b>.
    /// </returns>
    class function Valid(const AValue: string; out AWrongSymbol: Char): Boolean;
  end;

implementation

uses
  System.SysUtils,
  VCL.Dialogs,
  CastersPackage.uRoutines,
  System.Character,
  TAPEstimator.uTTAPCommandPrefixes,
  TAPEstimator.uTTAPNonCommandChars,
  TAPEstimator.uETAPWrongSymbol;

{var
  sTAPString: string;
  cWrongSymbol: Char;}

class function TTAPStringRoutines.IsComment(const AValue: string): Boolean;
var
  s: string;
begin
  // убираем пробелы с начала и конца строки
  s := Trim(AValue);
  Result :=
  // минимальной строкой с комментарием является строка [],
  // поэтому длина строки должна быть минимум 2 символа
    (Length(s) > 1) and
  // строка должна начинаться на [
    (s[low(string)] = '[') and
  // и оканчиваться на ]
    (s[Length(s) - 1 + low(string)] = ']');
end;

class function TTAPStringRoutines.Normalize(const AValue: string): string;
var
  s: string;
  s1: string;
  i: Integer;
begin
  s1 := EmptyStr;
  // убираем пробелы с начала и конца строки
  s := Trim(AValue);
  // если строка не является комментарием, продолжаем нормализацию
  if not IsComment(s) then
  begin
    // преобразуем строку в верхний регистр
    s := AnsiUpperCase(s);
    // перебираем все символы в строке
    for i := low(string) to Length(s) - 1 + low(string) do
    begin
      if i > low(string) then // если символ не является первым в строке
      begin
        // если символ является префиксом команды
        if CharInSet(s[i], TTAPCommandPrefixes) and
        // и предыдущий символ не был префиксом команды либо пробелом
          (not CharInSet(s[i - 1], TTAPCommandPrefixes + [' '])) then
        begin
          // вставляем пробел перед очередным сисмволом
          s1 := s1 + ' ';
        end;
      end;
      // добавляем очередной символ
      s1 := s1 + s[i];
    end;
    // возвращаем нормализованную строку
    s := s1;
  end;
  // возвращаем строку
  Result := s;
end;

class function TTAPStringRoutines.Normalized(const AValue: string): Boolean;
begin
  // если строка совпадает с нормализованным значением, значит она является нормализованной
  Result := AValue <> Normalize(AValue);
end;

class function TTAPStringRoutines.ToStringList(const AValue: string): TStringList;
begin
  // создаём список строк
  Result := TStringList.Create;
  // разбиваем строку на подстроки и возвращаем их в виде списка
  Routines.CutStringByLimiterToStringList(AValue, Result, ' ');
end;

class function TTAPStringRoutines.Valid(const AValue: string; out AWrongSymbol: Char): Boolean;
var
  s: string;
  i: Integer;
begin
  AWrongSymbol := Char(0);
  Result := IsComment(AValue);
  // если строка не является комментарием, продолжаем валидацию
  if not Result then
  begin
    // получаем нормализованную версию строки
    s := Normalize(AValue);
    // устанавливаем результат по умолчанию "истина"
    Result := True;
    // перебираем все символы в строке
    for i := low(string) to Length(s) - 1 + low(string) do
    begin
      // если символ не относится к допустимым форматом
      if not CharInSet(s[i], TTAPCommandPrefixes + TTAPNonCommandChars) then
      begin
        // возвращаем "ложь"
        Result := False;
        // прекращаем работу цикла
        AWrongSymbol := s[i];
        Break;
      end;
    end;
  end;
end;

{initialization

sTAPString := ' G90G1Z0f350 y10z20 xyz ';
try
  if TTAPStringRoutines.Valid(TTAPStringRoutines.Normalize(sTAPString), cWrongSymbol) then
  begin
    ShowMessage(TTAPStringRoutines.Normalize(sTAPString));
  end
  else
  begin
    raise ETAPWrongSymbol.Create('Некорректный символ [%s] в строке.', cWrongSymbol);
  end;
except
  on E: Exception do
  begin
    ShowMessage(E.Message);
  end;
end;}

end.
