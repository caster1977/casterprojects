unit uRoutines;

interface

uses
  Classes;

type
  Routines=class
  public
    /// <summary>
    /// Функция для получения IP-адреса локального компьютера
    /// </summary>
    /// <remarks>
    /// <para>
    /// <b>Классовая функция</b> (работает без необходимости создавать
    /// экземпляр класса):
    /// </para>
    /// <para>
    /// <i>
    /// <b>... = Routines.GetLocalIP;</b>
    /// </i>
    /// </para>
    /// </remarks>
    class function GetLocalIP: string;
    class function GetConditionalString(const Condition: Boolean; TrueString, FalseString: string): string; static;
    class procedure CopyStringToClipboard(const Value: string); static;
    class procedure CutStringByLimiterToStringList(const Source: string; var Destination: TStringList; const Limiter: char); static;
    class procedure GenerateError(const aMessage: string; out aErrorMessage: string; out aErrorFlag: boolean); static;
    class function ValidatePhoneString(const Value: string): string; static;
    class function IsStringIsPhone(const aString: string): boolean; static;
    class procedure AddApplicationToRunKey(const RunName, ApplicationName: string); static;
    class procedure DeleteApplicationFromRunKey(const RunName: string); static;
    class function IsApplicationInRunKey(const RunName: string): Boolean; static;

    /// <summary>
    /// Функция обрабатывает строку данных организаций или мероприятий,
    /// приводя её к стандартному виду, используемому в программе <b>OA5</b>
    /// </summary>
    /// <param name="Source">
    /// Исходная строка для преобразования
    /// </param>
    /// <returns>
    /// Результат обработки исходной строки
    /// </returns>
    /// <remarks>
    /// <para>
    /// <b>Классовая функция</b> (работает без необходимости создавать
    /// экземпляр класса):
    /// </para>
    /// <para>
    /// <b>... = Routines.PrepareStringForRNE5(...);</b>
    /// </para>
    /// </remarks>
    class function PrepareStringForRNE5(Source: string): string; overload;
    class function PrepareStringForRNE5(Source: AnsiString): AnsiString; overload;
  end;

implementation

uses
  Windows,
  WinSock,
  mysql,
  System.AnsiStrings,
  System.SysUtils,
  Clipbrd,
  Registry;

class function Routines.GetLocalIP: string;
const
  WSVer=$101;
var
  wsaData: TWSAData;
  P: PHostEnt;
  Buf: array [0..127] of Char;
begin
  Result:='';
  if WSAStartup(WSVer, wsaData)=0 then
    begin
      if GetHostName(@Buf, 128)=0 then
        begin
          P:=GetHostByName(@Buf);
          if P<>nil then
            Result:=string(iNet_ntoa(PInAddr(p^.h_addr_list^)^));
        end;
      WSACleanup;
    end;
end;

class function Routines.GetConditionalString(const Condition: Boolean; TrueString, FalseString: string): string;
begin
  if Condition then
    Result:=TrueString
  else
    Result:=FalseString;
end;

class procedure Routines.CopyStringToClipboard(const Value: string);
begin
  ClipBoard.Clear;
  ClipBoard.SetTextBuf(PWideChar(Value));
end;

class procedure Routines.CutStringByLimiterToStringList(const Source: string; var Destination: TStringList; const Limiter: char);
var
  i: integer;
  s, s1: string;
begin
  s:=Source;
  if Assigned(Destination) then
    Destination.Clear
  else
    Destination:=TStringList.Create;

  Destination.Sorted:=False;
  while Length(s)>0 do
    begin
      i:=Pos(Limiter, s);
      if i=0 then
        begin
          Destination.Add(s);
          Exit;
        end
      else
        begin
          s1:=Copy(s, 0, i-1);
          Destination.Append(s1);
          s1:=Copy(s, i+1, Length(s));
          s:=s1;
        end;
    end;
end;

class procedure Routines.GenerateError(const aMessage: string; out aErrorMessage: string; out aErrorFlag: boolean);
begin
  aErrorMessage:=aMessage;
  aErrorFlag:=True;
end;

class function Routines.ValidatePhoneString(const Value: string): string;
var
  s: string;
begin
  s:=Value;
  // замена символов на пробел
  while Pos(#09, s)>0 do
    s:=StringReplace(s, #09, ' ', [rfReplaceAll]);
  while Pos(',', s)>0 do
    s:=StringReplace(s, ',', ' ', [rfReplaceAll]);
  while Pos('.', s)>0 do
    s:=StringReplace(s, '.', ' ', [rfReplaceAll]);
  // замена символа звёздочки на процент
  while Pos('*', s)>0 do
    s:=StringReplace(s, '*', '%', [rfReplaceAll]);
  // удаление двойных пробелов
  while Pos('  ', s)>0 do
    s:=StringReplace(s, '  ', ' ', [rfReplaceAll]);
  // удаление граничных пробелов
  s:=Trim(s);
  Result:=s;
end;

class function Routines.IsStringIsPhone(const aString: string): boolean;
var
  b: boolean;
  aSL: TStringList;
  i: integer;
  s: string;
begin
  b:=True;
  s:=Routines.ValidatePhoneString(aString);

  if s='' then // если строка пуста - возращаем "false"
    b:=False;
  // проверка строки на наличие "лишних" символов
  for i:=1 to Length(s)-1 do
    if not CharInSet(s[i], ['0'..'9', ' ', '%', '_']) then
      b:=False;
  aSL:=TStringList.Create;
  try
    aSL.Duplicates:=dupIgnore;
    aSL.Sorted:=True;
    Routines.CutStringByLimiterToStringList(s, aSL, ' ');
    for i:=0 to aSL.Count-1 do
      if (Length(aSL[i])<3)or(Length(aSL[i])>12) then
        b:=False;
  finally
    aSl.Free;
  end;

  Result:=b;
end;

class procedure Routines.AddApplicationToRunKey(const RunName, ApplicationName: string);
begin
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      try
        WriteString(RunName, ApplicationName);
      except
        on ERegistryException do;
      end;
    finally
      CloseKey;
      Free;
    end;
end;

class function Routines.IsApplicationInRunKey(const RunName: string): Boolean;
begin
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', False);
      Result:=ValueExists(RunName);
    finally
      CloseKey;
      Free;
    end;
end;

class procedure Routines.DeleteApplicationFromRunKey(const RunName: string);
begin
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True);
      if ValueExists(RunName) then
        try
          DeleteValue(RunName);
        except
          on ERegistryException do;
        end;
    finally
      CloseKey;
      Free;
    end;
end;

class function Routines.PrepareStringForRNE5(Source: string): string;
var
  new_s: string;
  i, j: integer;
begin
  (* функция "подведения" заданной строки под стандартный вид базы *)
  // замена ' на \'
  new_s:=StringReplace(Source, #39, '"', [rfReplaceAll]);
  // замена двойных косых кавычек
  new_s:=StringReplace(new_s, #171, '"', [rfReplaceAll]);
  new_s:=StringReplace(new_s, #187, '"', [rfReplaceAll]);
  // замена букв Ё на Е
  new_s:=StringReplace(new_s, 'Ё', 'Е', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'ё', 'е', [rfReplaceAll]);
  // предварительное удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // удаление ограничивающих парных кавычек
  if new_s>'' then
    if (new_s[1]='"')and(new_s[Length(new_s)]='"') then
      new_s:=copy(new_s, 2, Length(new_s)-2);
  // замена символов перевода строки и возврата каретки на пробелы
  new_s:=StringReplace(new_s, #10, ' ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, #13, ' ', [rfReplaceAll]);
  // замена символа "."
  new_s:=StringReplace(new_s, ' .', '.', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. ', '.', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '.', '. ', [rfReplaceAll]);
  // замена трёх точек на многоточие
  new_s:=StringReplace(new_s, '. . . ', '... ', [rfReplaceAll]);
  // замена символа ","
  new_s:=StringReplace(new_s, ' ,', ',', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ', ', ',', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ',', ', ', [rfReplaceAll]);
  // замена символа "-"
  new_s:=StringReplace(new_s, ' -', '-', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '- ', '-', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '-', '- ', [rfReplaceAll]);
  // замена символа ":"
  new_s:=StringReplace(new_s, ' :', ':', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ': ', ':', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ':', ': ', [rfReplaceAll]);
  // корректировка случая "цифра-тире(двоеточие)-цифра" для дат и времени
  for j:=0 to 9 do
    for i:=0 to 9 do
      begin
        new_s:=StringReplace(new_s, IntToStr(j)+'- '+IntToStr(i), IntToStr(j)+'-'+IntToStr(i), [rfReplaceAll]);
        new_s:=StringReplace(new_s, IntToStr(j)+': '+IntToStr(i), IntToStr(j)+':'+IntToStr(i), [rfReplaceAll]);
        new_s:=StringReplace(new_s, IntToStr(j)+'. '+IntToStr(i), IntToStr(j)+':'+IntToStr(i), [rfReplaceAll]);
      end;
  // замена символа """
  new_s:=StringReplace(new_s, ' "', '"', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '" ', '"', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '"', ' " ', [rfReplaceAll]);
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // замена символов "[" и "]"
  new_s:=StringReplace(new_s, ' [', '[', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '[ ', '[', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '[', ' [ ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' ]', ']', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '] ', ']', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ']', ' ] ', [rfReplaceAll]);
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // замена символов "[" и "]"
  new_s:=StringReplace(new_s, ' <', '<', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< ', '<', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '<', ' < ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' >', '>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '> ', '>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '>', ' > ', [rfReplaceAll]);
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // замена символов "(" и ")"
  new_s:=StringReplace(new_s, ' (', '(', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '( ', '(', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '(', ' ( ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' )', ')', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ') ', ')', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ')', ' ) ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ') ,', '),', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ') .', ').', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ') ;', ');', [rfReplaceAll]);
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while Pos('  ', new_s)>0 do
    new_s:=StringReplace(new_s, '  ', ' ', [rfReplaceAll]);
  // ПРОЧИЕ ЗАМЕНЫ
  // если не указано сокращение "город" перед Минск, вставляем
  if Pos('Минск,', new_s)=1 then
    new_s:='г. '+new_s;
  if Pos('Минск.', new_s)=1 then
    new_s:='г. '+new_s;
  if Pos('Минск ', new_s)=1 then
    new_s:='г. '+new_s;
  new_s:=StringReplace(new_s, 'www. ', 'www.', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. by', '.by', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. ru', '.ru', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. com', '.com', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. net', '.net', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. org', '.org', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. open', '.open', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '. tut', '.tut', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'mailto: ', 'mailto:', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'mail: ', 'mail:', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'E- mail', 'E-mail', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'E- Mail', 'E-mail', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'e- Mail', 'E-mail', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'e- mail', 'E-mail', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'http: /', 'http:/', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' atava.', 'atava.', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< BR >', '<BR>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< HR >', '<HR>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< B >', '<B>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< /B >', '</B>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< A ', '<A ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< /A >', '</A>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< FONT ', '<FONT ', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '< /FONT >', '</FONT>', [rfReplaceAll]);
  new_s:=StringReplace(new_s, '<FONT COLOR= " RED " >', '<FONT COLOR="RED">', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'карины', 'корины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'карыны', 'корины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'пр. Скорины', 'пр- т Ф. Скорины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'пр. Ф. Скорины', 'пр- т Ф. Скорины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, 'пр- т Скорины', 'пр- т Ф. Скорины', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' р- он', ' р- н', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' р- он,', ' р- н,', [rfReplaceAll]);
  new_s:=StringReplace(new_s, ' р- он.', ' р- н.', [rfReplaceAll]);

  // ДОПИСАТЬ!!!
  // здесь нужно вставить обработку списка автозамен из окна опций

  // финальное удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  // добавление пробела в начале текстовой строки
  if new_s>'' then
    new_s:=' '+new_s;
  Result:=new_s;
end;

class function Routines.PrepareStringForRNE5(Source: AnsiString): AnsiString;
var
  new_s: AnsiString;
  i, j: integer;
begin
  (* функция "подведения" заданной строки под стандартный вид базы *)
  // замена ' на \'
  new_s:=AnsiReplaceStr(Source, #39, '"');
  // замена двойных косых кавычек
  new_s:=AnsiReplaceStr(new_s, #171, '"');
  new_s:=AnsiReplaceStr(new_s, #187, '"');
  // замена букв Ё на Е
  new_s:=AnsiReplaceStr(new_s, 'Ё', 'Е');
  new_s:=AnsiReplaceStr(new_s, 'ё', 'е');
  // предварительное удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while AnsiPos(AnsiString('  '), new_s)>0 do
    new_s:=AnsiReplaceStr(new_s, '  ', ' ');
  // удаление ограничивающих парных кавычек
  if new_s>'' then
    if (new_s[1]='"')and(new_s[Length(new_s)]='"') then
      new_s:=copy(new_s, 2, Length(new_s)-2);
  // замена символов перевода строки и возврата каретки на пробелы
  new_s:=AnsiReplaceStr(new_s, #10, ' ');
  new_s:=AnsiReplaceStr(new_s, #13, ' ');
  // замена символа "."
  new_s:=AnsiReplaceStr(new_s, ' .', '.');
  new_s:=AnsiReplaceStr(new_s, '. ', '.');
  new_s:=AnsiReplaceStr(new_s, '.', '. ');
  // замена трёх точек на многоточие
  new_s:=AnsiReplaceStr(new_s, '. . . ', '... ');
  // замена символа ","
  new_s:=AnsiReplaceStr(new_s, ' ,', ',');
  new_s:=AnsiReplaceStr(new_s, ', ', ',');
  new_s:=AnsiReplaceStr(new_s, ',', ', ');
  // замена символа "-"
  new_s:=AnsiReplaceStr(new_s, ' -', '-');
  new_s:=AnsiReplaceStr(new_s, '- ', '-');
  new_s:=AnsiReplaceStr(new_s, '-', '- ');
  // замена символа ":"
  new_s:=AnsiReplaceStr(new_s, ' :', ':');
  new_s:=AnsiReplaceStr(new_s, ': ', ':');
  new_s:=AnsiReplaceStr(new_s, ':', ': ');
  // корректировка случая "цифра-тире(двоеточие)-цифра" для дат и времени
  for j:=0 to 9 do
    for i:=0 to 9 do
      begin
        new_s:=AnsiReplaceStr(new_s, AnsiString(IntToStr(j)+'- '+IntToStr(i)), AnsiString(IntToStr(j)+'-'+IntToStr(i)));
        new_s:=AnsiReplaceStr(new_s, AnsiString(IntToStr(j)+': '+IntToStr(i)), AnsiString(IntToStr(j)+':'+IntToStr(i)));
        new_s:=AnsiReplaceStr(new_s, AnsiString(IntToStr(j)+'. '+IntToStr(i)), AnsiString(IntToStr(j)+':'+IntToStr(i)));
      end;
  // замена символа """
  new_s:=AnsiReplaceStr(new_s, ' "', '"');
  new_s:=AnsiReplaceStr(new_s, '" ', '"');
  new_s:=AnsiReplaceStr(new_s, '"', ' " ');
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while AnsiPos(AnsiString('  '), new_s)>0 do
    new_s:=AnsiReplaceStr(new_s, '  ', ' ');
  // замена символов "[" и "]"
  new_s:=AnsiReplaceStr(new_s, ' [', '[');
  new_s:=AnsiReplaceStr(new_s, '[ ', '[');
  new_s:=AnsiReplaceStr(new_s, '[', ' [ ');
  new_s:=AnsiReplaceStr(new_s, ' ]', ']');
  new_s:=AnsiReplaceStr(new_s, '] ', ']');
  new_s:=AnsiReplaceStr(new_s, ']', ' ] ');
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while AnsiPos(AnsiString('  '), new_s)>0 do
    new_s:=AnsiReplaceStr(new_s, '  ', ' ');
  // замена символов "[" и "]"
  new_s:=AnsiReplaceStr(new_s, ' <', '<');
  new_s:=AnsiReplaceStr(new_s, '< ', '<');
  new_s:=AnsiReplaceStr(new_s, '<', ' < ');
  new_s:=AnsiReplaceStr(new_s, ' >', '>');
  new_s:=AnsiReplaceStr(new_s, '> ', '>');
  new_s:=AnsiReplaceStr(new_s, '>', ' > ');
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while AnsiPos(AnsiString('  '), new_s)>0 do
    new_s:=AnsiReplaceStr(new_s, '  ', ' ');
  // замена символов "(" и ")"
  new_s:=AnsiReplaceStr(new_s, ' (', '(');
  new_s:=AnsiReplaceStr(new_s, '( ', '(');
  new_s:=AnsiReplaceStr(new_s, '(', ' ( ');
  new_s:=AnsiReplaceStr(new_s, ' )', ')');
  new_s:=AnsiReplaceStr(new_s, ') ', ')');
  new_s:=AnsiReplaceStr(new_s, ')', ' ) ');
  new_s:=AnsiReplaceStr(new_s, ') ,', '),');
  new_s:=AnsiReplaceStr(new_s, ') .', ').');
  new_s:=AnsiReplaceStr(new_s, ') ;', ');');
  // удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  while AnsiPos(AnsiString('  '), new_s)>0 do
    new_s:=AnsiReplaceStr(new_s, '  ', ' ');
  // ПРОЧИЕ ЗАМЕНЫ
  // если не указано сокращение "город" перед Минск, вставляем
  if AnsiPos(AnsiString('Минск,'), new_s)=1 then
    new_s:='г. '+new_s;
  if AnsiPos(AnsiString('Минск.'), new_s)=1 then
    new_s:='г. '+new_s;
  if AnsiPos(AnsiString('Минск '), new_s)=1 then
    new_s:='г. '+new_s;
  new_s:=AnsiReplaceStr(new_s, 'www. ', 'www.');
  new_s:=AnsiReplaceStr(new_s, '. by', '.by');
  new_s:=AnsiReplaceStr(new_s, '. ru', '.ru');
  new_s:=AnsiReplaceStr(new_s, '. com', '.com');
  new_s:=AnsiReplaceStr(new_s, '. net', '.net');
  new_s:=AnsiReplaceStr(new_s, '. org', '.org');
  new_s:=AnsiReplaceStr(new_s, '. open', '.open');
  new_s:=AnsiReplaceStr(new_s, '. tut', '.tut');
  new_s:=AnsiReplaceStr(new_s, 'mailto: ', 'mailto:');
  new_s:=AnsiReplaceStr(new_s, 'mail: ', 'mail:');
  new_s:=AnsiReplaceStr(new_s, 'E- mail', 'E-mail');
  new_s:=AnsiReplaceStr(new_s, 'E- Mail', 'E-mail');
  new_s:=AnsiReplaceStr(new_s, 'e- Mail', 'E-mail');
  new_s:=AnsiReplaceStr(new_s, 'e- mail', 'E-mail');
  new_s:=AnsiReplaceStr(new_s, 'http: /', 'http:/');
  new_s:=AnsiReplaceStr(new_s, ' atava.', 'atava.');
  new_s:=AnsiReplaceStr(new_s, '< BR >', '<BR>');
  new_s:=AnsiReplaceStr(new_s, '< HR >', '<HR>');
  new_s:=AnsiReplaceStr(new_s, '< B >', '<B>');
  new_s:=AnsiReplaceStr(new_s, '< /B >', '</B>');
  new_s:=AnsiReplaceStr(new_s, '< A ', '<A ');
  new_s:=AnsiReplaceStr(new_s, '< /A >', '</A>');
  new_s:=AnsiReplaceStr(new_s, '< FONT ', '<FONT ');
  new_s:=AnsiReplaceStr(new_s, '< /FONT >', '</FONT>');
  new_s:=AnsiReplaceStr(new_s, '<FONT COLOR= " RED " >', '<FONT COLOR="RED">');
  new_s:=AnsiReplaceStr(new_s, 'карины', 'корины');
  new_s:=AnsiReplaceStr(new_s, 'карыны', 'корины');
  new_s:=AnsiReplaceStr(new_s, 'пр. Скорины', 'пр- т Ф. Скорины');
  new_s:=AnsiReplaceStr(new_s, 'пр. Ф. Скорины', 'пр- т Ф. Скорины');
  new_s:=AnsiReplaceStr(new_s, 'пр- т Скорины', 'пр- т Ф. Скорины');
  new_s:=AnsiReplaceStr(new_s, ' р- он', ' р- н');
  new_s:=AnsiReplaceStr(new_s, ' р- он,', ' р- н,');
  new_s:=AnsiReplaceStr(new_s, ' р- он.', ' р- н.');

  // ДОПИСАТЬ!!!
  // здесь нужно вставить обработку списка автозамен из окна опций

  // финальное удаление двойных и граничных пробелов
  new_s:=Trim(new_s);
  // добавление пробела в начале текстовой строки
  if new_s>'' then
    new_s:=' '+new_s;
  Result:=new_s;
end;

end.
