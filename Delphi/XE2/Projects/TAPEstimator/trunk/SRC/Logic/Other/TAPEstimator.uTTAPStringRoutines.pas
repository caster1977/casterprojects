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
    class function Valid(const AValue: string): Boolean;
  end;

implementation

uses
  System.SysUtils,
  VCL.Dialogs,
  CastersPackage.uRoutines,
  System.Character,
  TAPEstimator.uTTAPCommandPrefixes,
  TAPEstimator.uTTAPNonCommandChars;

class function TTAPStringRoutines.IsComment(const AValue: string): Boolean;
var
  s: string;
begin
  s := Trim(AValue); // убираем пробелы с начала и конца строки
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
  s := Trim(AValue); // убираем пробелы с начала и конца строки
  if not IsComment(s) then // если строка не является комментарием, продолжаем нормализацию
  begin
    s := AnsiUpperCase(s);
    s1 := EmptyStr;
    for i := low(string) to Length(s) - 1 + low(string) do
    begin
      if i > low(string) then
      begin
        if CharInSet(s[i], TTAPCommandPrefixes) and (s1[Length(s1) - 1 + low(string)] <> ' ') then
        begin
          s1 := s1 + ' ';
        end;
      end;
      s1 := s1 + s[i];
    end;
    s := s1;
  end;
  Result := s; // возвращаем нормализованную строку
end;

class function TTAPStringRoutines.Normalized(const AValue: string): Boolean;
begin
  Result := AValue <> Normalize(AValue); // если строка совпадает с нормализованным значением, значит она является нормализованной
end;

class function TTAPStringRoutines.ToStringList(const AValue: string): TStringList;
begin
  Result := TStringList.Create;
  Routines.CutStringByLimiterToStringList(AValue, Result, ' '); // разбиваем строку на подстроки и возвращаем их в виде списка
end;

class function TTAPStringRoutines.Valid(const AValue: string): Boolean;
var
  s: string;
  i: Integer;
begin
  Result := IsComment(AValue);
  if not Result then // если строка не является комментарием, продолжаем валидацию
  begin
    s := Normalize(AValue);
    Result := True;
    for i := low(string) to Length(s) - 1 + low(string) do
    begin
      if not CharInSet(s[i], TTAPCommandPrefixes + TTAPNonCommandChars) then
      begin
        Result := False;
        Break;
      end;
    end;
  end;
end;

initialization

ShowMessage(BoolToStr(TTAPStringRoutines.Valid(TTAPStringRoutines.Normalize(' G90G1Z0f350 y10z20  ')), True));

end.
