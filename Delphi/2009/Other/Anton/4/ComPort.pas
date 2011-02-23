unit ComPort;

interface


uses
  Windows, SysUtils, Classes, Forms;

Type
 TBaudRate = (
    br110, br300, br600, br1200, br2400, br4800, br9600,
    br14400, br19200, br38400, br56000, br57600, br115200
 );
 TByteSize = (
  bs5, bs6, bs7, bs8
 );
 TParity = (
  ptNONE, ptODD, ptEVEN, ptMARK, ptSPACE
 );
 TStopbits = (
  sb1BITS, sb1HALFBITS, sb2BITS
 );

 {тип события при получении байта}
 TReadPacketEvent = procedure (const Packet : Pointer; const Size : Integer; const ErrCode: Cardinal) of object;

 TComPort = class; {опережающее описание}

 {читающий поток}
 TReadThread = class(TThread)
   FOwner    : TComPort;
   FInBuffer : Pointer; {входной буфер}
   FErrCode  : Cardinal;{сохраняет код ошибок}
   FCount    : Integer; {реально прочитанное число байт}
  Protected
   Procedure Execute; override;
   Procedure DoReadPacket;
  Public
   Constructor Create(AOwner : TComPort);
   Destructor  Destroy; override;
 End;

 TComProp = class(TPersistent)
  Private
   FBaudRate    : TBaudRate; {скорость обмена (бод)}
   FByteSize    : TByteSize; {число бит в байте}
   FParity      : TParity;   {четность}
   FStopbits    : TStopbits; {число стоп-бит}
   function  GetDCB: TDCB;
   procedure SetDCB(const Value: TDCB);
  Public
   Property DCB : TDCB read GetDCB write SetDCB;
  Published
   {Скорость обмена}
   Property BaudRate  : TBaudRate read FBaudRate write FBaudRate;
   {Число бит в байте}
   Property ByteSize  : TByteSize read FByteSize write FByteSize;
   {Четность}
   Property Parity    : TParity   read FParity   write FParity;
   {Число стоп-бит}
   Property Stopbits  : TStopbits read FStopbits write FStopbits;
 End;

 TComPort = class(TComponent)
  Protected
    FComNumber   : Integer;   {номер порта}
    FHandle      : THandle;   {дескриптор порта}
    FOnReadPacket: TReadPacketEvent;{событие "получение пакета"}
    FReadThread  : TReadThread; {читающий поток}
    FInBufSize   : Cardinal; {размер входной очереди }
    FWaitFullBuffer : Boolean; {ожидание наполнения буфера}
    FComProp     : TComProp; {свойства порта}
    Procedure DoOpenPort; {открытие порта}
    Procedure DoClosePort; {закрытие порта}
    Procedure ApplyComSettings;
  Private
    function  GetConnected: Boolean;
    procedure SetConnected(const Value: Boolean);
    procedure SetComNumber(const Value: Integer);
    procedure SetReadActive(const Value: Boolean);
    function  GetReadActive: Boolean;
    procedure SetInBufSize(const Value: Cardinal);
  Public
    Constructor Create(AOwner : TComponent); override;
    Destructor  Destroy; override;
  Public
    {Открывает/закрывает порт}
    Procedure Open;
    Procedure Close;
    {Возвращает True, если порт открыт}
    Function  Connect : Boolean;
    {Возвращает структуру состояния порта ComStat, а в    }
    {переменной CodeError возвращается текущий код ошибки }
    Function  GetState(var CodeError : Cardinal) : TComStat;
    {Возвращает состояние модема}
    Function  GetModemState : Cardinal;
    {Передает буфер. В случае успеха возвращает True}
    Function  WriteBuffer(const P : PChar; const Size : Integer) : Boolean;
    {Передает строку. В случае успеха возвращает True}
    Function  WriteString(const S : String) : Boolean;
    {Возвращает строковое имя порта}
    Function  GetComName(FullName : Boolean) : String;
    {Диалог настройки параметров порта}
    Function  CommDialog : Boolean;
  Public  
    {Активность чтения порта}
    Property ReadActive : Boolean  read GetReadActive write SetReadActive;
    {Возвращает True, если порт открыт}
    Property Connected : Boolean read GetConnected write SetConnected;
  Published
    {Номер порта. При изменении порт переоткрывается, если был открыт}
    Property ComNumber  : Integer read FComNumber    write SetComNumber;
    {Параметры порта}
    Property ComProp : TComProp read FComProp write FComProp;
    {Размер входного буфера}
    Property InBufSize  : Cardinal read FInBufSize write SetInBufSize;
    {Ожидание наполнения буфера}
    Property WaitFullBuffer : Boolean read FWaitFullBuffer write FWaitFullBuffer;
   Published
    {Событие, вызываемое при получении байта}
    Property OnReadPacket : TReadPacketEvent read FOnReadPacket write FOnReadPacket;
   Public {Дополнительные функции}
    {Получение базового адреса}
    Function GetBaseAddress : Word;
    {Управление линией DTR}
    Procedure ToggleDTR(State : Boolean);
    {Управление линией RTS}
    Procedure ToggleRTS(State : Boolean);
    {Перечисление всех COM портов}
    Class procedure EnumComPorts(Ports: TStrings);
    Class procedure EnumComPortsEx(Ports: TStrings);
 End;

implementation

uses
  Dialogs, WinSpool, Math;

{Добавление ресурса с иконкой для палитры компонент}
{$R *.dcr}

Const
  WindowsBaudRates: array[br110..br115200] of DWORD = (
    CBR_110, CBR_300, CBR_600, CBR_1200, CBR_2400, CBR_4800, CBR_9600,
    CBR_14400, CBR_19200, CBR_38400, CBR_56000, CBR_57600, CBR_115200
    {CRB_128000, CBR_256000 - описаны в Windows.pas, но не используются}
  );

Const
  dcb_Binary              = $00000001;
  dcb_ParityCheck         = $00000002;
  dcb_OutxCtsFlow         = $00000004;
  dcb_OutxDsrFlow         = $00000008;
  dcb_DtrControlMask      = $00000030;
  dcb_DtrControlDisable   = $00000000;
  dcb_DtrControlEnable    = $00000010;
  dcb_DtrControlHandshake = $00000020;
  dcb_DsrSensivity        = $00000040;
  dcb_TXContinueOnXoff    = $00000080;
  dcb_OutX                = $00000100;
  dcb_InX                 = $00000200;
  dcb_ErrorChar           = $00000400;
  dcb_NullStrip           = $00000800;
  dcb_RtsControlMask      = $00003000;
  dcb_RtsControlDisable   = $00000000;
  dcb_RtsControlEnable    = $00001000;
  dcb_RtsControlHandshake = $00002000;
  dcb_RtsControlToggle    = $00003000;
  dcb_AbortOnError        = $00004000;
  dcb_Reserveds           = $FFFF8000;
  
Constructor TComPort.Create(AOwner : TComponent);
Begin
 Inherited Create(AOwner);
 FComNumber:= 1;
 FComProp  := TComProp.Create; {свойства порта}
 FHandle:= INVALID_HANDLE_VALUE;
 FReadThread:= nil;
 FInBufSize := 10;
 FWaitFullBuffer:= False; 
End;

Destructor  TComPort.Destroy;
Begin
 {Закрываем порт и соединение}
 DoClosePort;
 FComProp.Free;
 Inherited Destroy;
End;

Procedure TComPort.ApplyComSettings;
Begin
 If not Connected then Exit;
 { Установить настройки порта, согласно DCB }
 SetCommState(FHandle, FComProp.DCB);
End;

{Диалог настройки параметров порта}
Function TComPort.CommDialog : Boolean;
Var ComCfg : TCommConfig;
Begin
 ZeroMemory(@ComCfg, SizeOf(TCommConfig));
 ComCfg.dwSize:= SizeOf(TCommConfig);
 ComCfg.dcb   := FComProp.DCB;
 Result:= CommConfigDialog(PChar(GetComName(False)), 0, ComCfg);
 If Result then begin
  FComProp.DCB:= ComCfg.dcb;
  ApplyComSettings;
 End;
End;

{Изменение размера входного буфера}
procedure TComPort.SetInBufSize(const Value: Cardinal);
begin
 {Разрешаем менять только при выключенном соединении}
 If Connected then Exit;
 {Нельзя задать нулевое или неверное значение размера}
 If Value <= 0 then Exit;
 {Запоминаем новый размер буфера}
 FInBufSize:= Value;
end;

function TComPort.GetConnected: Boolean;
begin
 Result:= (FHandle <> INVALID_HANDLE_VALUE);
end;

procedure TComPort.SetConnected(const Value: Boolean);
begin
 If Value then DoOpenPort else DoClosePort;
end;

{Установка соединения}
Function TComPort.Connect : Boolean;
Begin
 DoOpenPort;
 Result:= Connected;
End;

{Установка соединения (дублирует Connect:= True)}
Procedure TComPort.Open;
Begin
 DoOpenPort;
End;

{Закрытие соединения (дублирует Connect:= False)}
Procedure TComPort.Close;
Begin
 DoClosePort;
End;

{Установка номера порта}
procedure TComPort.SetComNumber(const Value: Integer);
var Active : Boolean;
begin
 If FComNumber = Value then Exit;
 Active:= Connected; {сохраним значение активности порта}
 If Active then DoClosePort; {закрыть порт перед изменением индекса}
 FComNumber:= Value; {устанавливаем новое значение номера порта}
 If Active then DoOpenPort; {открыть порт, если он был открыт}
end;

{Возвращает строковое имя порта}
Function TComPort.GetComName(FullName : Boolean) : String;
Begin
 {Для портов 1..9 можно использовать простые имена COM1..COM9,}
 {но для портов 10-256 надо писать полное имя. Для общности   }
 {будем всегда использовать полное имя порта, за исключением  }
 {вызова CommConfigDialog }
 If FullName then
  Result:= Format('\\.\COM%-d', [FComNumber])
 Else
  Result:= Format('COM%-d', [FComNumber]);
End;

{открытие порта}
Procedure TComPort.DoOpenPort;
Begin
 If Connected then Exit;
 {Запрещаем подключение в среде разработки}
 If csDesigning in ComponentState then Exit;

 {Открытие последовательного порта }
 FHandle:= CreateFile(
            PChar(GetComName(True)), {передаем имя открываемого порта}
            GENERIC_READ or GENERIC_WRITE, {ресурс для чтения и записи}
            0, { не разделяемый ресурс }
            nil, { Нет атрибутов защиты }
            OPEN_EXISTING, {вернуть ошибку, если ресурс не существует}
            FILE_ATTRIBUTE_NORMAL or FILE_FLAG_OVERLAPPED, {асинхронный режим доступа}
            0 { Должно быть 0 для COM портов }
           ) ;
 {Если ошибка открытия порта - выход}
 If not Connected then Exit;
 {Задание параметров порта}
 ApplyComSettings;
 {Создание читающего потока}
 If not Assigned(FReadThread) then
  FReadThread:= TReadThread.Create(Self);
End;

{закрытие порта}
Procedure TComPort.DoClosePort;
Begin
 If not Connected then Exit;
 {Замораживаем поток чтения}
 ReadActive:= False;
 {Уничтожение читающего потока}
 FReadThread.FreeOnTerminate:= True;
 FReadThread.Terminate;
 FReadThread:= nil;
 {Освобождение дескриптора порта}
 CloseHandle(FHandle);
 {Сброс дескриптора порта}
 FHandle:= INVALID_HANDLE_VALUE;
End;

{Возвращает структуру состояния порта и код ошибок}
Function TComPort.GetState(var CodeError : Cardinal) : TComStat;
Begin
 ClearCommError(FHandle, CodeError, @Result);
End;

{Передача строки}
Function  TComPort.WriteString(const S : String) : Boolean;
Begin
 Result:= WriteBuffer(PChar(S), Length(S));
End;

{Передача буфера данных}
Function  TComPort.WriteBuffer(const P : PChar; const Size : Integer) : Boolean;
Var Signaled, RealWrite, BytesTrans : Cardinal;   
    WriteOL : TOverLapped; {структура для асинхронной записи}
Begin
 Result:= False;
 If P = nil then Exit;

 {создание события для асинхронной записи}
 FillChar(WriteOL, SizeOf(WriteOL), 0);
 WriteOL.hEvent:= CreateEvent(nil, True, True, nil);
 
 Try
   {начало асинхронной записи}
   WriteFile(FHandle, P^, Size, RealWrite, @WriteOL);
   {ожидания завершения асинхронной операции}
   Signaled:= WaitForSingleObject(WriteOL.hEvent, INFINITE);
   {получение результата асинхронной операции}
   Result  :=
      (Signaled = WAIT_OBJECT_0) and
      (GetOverlappedResult(FHandle, WriteOL, BytesTrans, False));
 Finally
  {освобождение дескриптора события}
  CloseHandle(WriteOL.hEvent);
 End;  
End;

{Возвращает состояние модема}
Function TComPort.GetModemState : Cardinal;
Begin
 GetCommModemStatus(FHandle, Result);
End;

{Активность чтения порта}
procedure TComPort.SetReadActive(const Value: Boolean);
begin
 If not Assigned(FReadThread) then Exit;
 
 If Value then begin
  If FReadThread.Suspended     then FReadThread.Resume;
 End else begin
  If not FReadThread.Suspended then FReadThread.Suspend;
 End; 
end;

function TComPort.GetReadActive: Boolean;
begin
 Result:= False;
 If Assigned(FReadThread) then
  Result:= not FReadThread.Suspended;
end;

{ недокументированный код функции - получение базового адреса в dx}
Function TComPort.GetBaseAddress : Word;
Begin
 EscapeCommFunction(FHandle, 10);
 Asm
  mov  Result, dx
 End;
End;

{Управление линией DTR}
Procedure TComPort.ToggleDTR(State : Boolean);
const Funcs: Array[Boolean] of Cardinal = (CLRDTR, SETDTR);
Begin
 If Connected then
  EscapeCommFunction(FHandle, Funcs[State]);
End;

{Управление линией RTS}
Procedure TComPort.ToggleRTS(State : Boolean);
const Funcs: Array[Boolean] of Cardinal = (CLRRTS, SETRTS);
Begin
 If Connected then
  EscapeCommFunction(FHandle, Funcs[State]);
End;

{ перечисление имен всех доступных коммуникационных портов}
class procedure TComPort.EnumComPorts(Ports: TStrings);
var
  BytesNeeded, Returned, I: DWORD;
  Success: Boolean;
  PortsPtr: Pointer;
  InfoPtr: PPortInfo1;
  TempStr: string;
begin
 {Запрос размера нужного буфера}
 Success := EnumPorts(nil, 1, nil, 0, BytesNeeded, Returned);

 If (not Success) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) then begin
  {Отводим нужный блок памяти}
  GetMem(PortsPtr, BytesNeeded);
  Try
   {Получаем список имен портов}
   Success := EnumPorts(nil, 1, PortsPtr, BytesNeeded, BytesNeeded, Returned);

   {Переписываем имена в StringList, отсеивая не COM-порты}
   For I := 0 to Returned - 1 do begin
    InfoPtr := PPortInfo1(DWORD(PortsPtr) + I * SizeOf(TPortInfo1));
    TempStr := InfoPtr^.pName;
    If Copy(TempStr, 1, 3) = 'COM' then
     Ports.Add(TempStr);
   End;
  Finally
   {Освобождаем буфер}
   FreeMem(PortsPtr);
  End;
 End;
end;

{ перечисление всех доступных коммуникационных портов и их описаний}
class procedure TComPort.EnumComPortsEx(Ports: TStrings);
var
  BytesNeeded, Returned, I: DWORD;
  Success: Boolean;
  PortsPtr: Pointer;
  InfoPtr: PPortInfo2;
  TempStr: string;
  Description : string;
begin
 {Запрос размера нужного буфера}
 Success := EnumPorts(nil, 2, nil, 0, BytesNeeded, Returned);

 If (not Success) and (GetLastError = ERROR_INSUFFICIENT_BUFFER) then begin
  {Отводим нужный блок памяти}
  GetMem(PortsPtr, BytesNeeded);
  Try
   {Получаем список имен портов и их описания}
   Success := EnumPorts(nil, 2, PortsPtr, BytesNeeded, BytesNeeded, Returned);

   {Переписываем имена в StringList, отсеивая не COM-порты}
   For I := 0 to Returned - 1 do begin
    InfoPtr := PPortInfo2(DWORD(PortsPtr) + I * SizeOf(TPortInfo2));
    TempStr := InfoPtr^.pPortName;

    {Добавляем описание порта, если оно есть}
    Description:= '';
    If InfoPtr^.pDescription <> nil then
     Description:= ' ' + InfoPtr^.pDescription;

    {Переписываем имена в StringList, отсеивая не COM-порты}
    If Copy(TempStr, 1, 3) = 'COM' then begin
     TempStr:= TempStr + Description;
     Ports.Add(TempStr);
    End;
   End;
  Finally
   {Освобождаем буфер}
   FreeMem(PortsPtr);
  End;
 end;
end;

{Класс TReadThread }
Constructor TReadThread.Create(AOwner : TComPort);
Begin
 Inherited Create(True);
 FOwner:= AOwner;
 {Создаем новый буфер}
 GetMem(FInBuffer, FOwner.FInBufSize);
End;

Destructor  TReadThread.Destroy;
Begin
 {Освобождаем буфер}
 FreeMem(FInBuffer);
 Inherited Destroy;
End;

{Основная функция потока}
Procedure TReadThread.Execute;
Var CurrentState : TComStat;
    AvaibleBytes, ErrCode, RealRead : Cardinal;
    ReadOL : TOverLapped; {структура для асинхронного чтения}
    Signaled, Mask : DWORD;
    BytesTrans : DWORD; {не используется для WaitCommEvent}
    bReadable : Boolean; {готовность к чтению данных}
Begin
 With FOwner do begin
  Try
    {создание события для асинхронного чтения}
    FillChar(ReadOL, SizeOf(ReadOL), 0);
    ReadOL.hEvent:= CreateEvent(nil, True, True, nil);

    {Маска событий, которые будет отслеживать читающий поток }
    {Пока это только получение символа                       }
    SetCommMask(FHandle, EV_RXCHAR);

    While (not Terminated) and Connected do begin {пока порт открыт}
     { Ждем одного из событий }
     WaitCommEvent(FHandle, Mask, @ReadOL);

     Signaled:= WaitForSingleObject(ReadOL.hEvent, INFINITE);

     If (Signaled  = WAIT_OBJECT_0) then begin
      If GetOverlappedResult(FHandle, ReadOL, BytesTrans, False) then begin

       {после GetOverlappedResult в переменной mask, которая}
       {передавалась в WaitCommEvent, появятся флаги произошедших }
       {событий, либо 0 в случае ошибки.}
       If (Mask and EV_RXCHAR) <> 0 then begin
        {Получаем состояние порта (линий и модема)}
        CurrentState:= GetState(ErrCode);

        { Число полученных, но еще не прочитанных байт}
        AvaibleBytes:= CurrentState.cbInQue;
        { Проверка числа доступных байт}
        If FWaitFullBuffer then begin
         {ждать только полного буфера}
         bReadable:= AvaibleBytes >= FInBufSize;
        End else begin
         {ждать любого числа байт}
         bReadable:= AvaibleBytes > 0;
        End;

        If bReadable then begin
         {Чистка буфера}
         ZeroMemory(FInBuffer, FInBufSize);
         If ReadFile(FHandle, FInBuffer^, Min(FInBufSize, AvaibleBytes), RealRead, @ReadOL) then begin
          {сохраняем параметры вызова события}
          FErrCode:= ErrCode;        
          FCount  := RealRead;
          {Вызываем событие OnReadByte. Для синхронизации с VCL}
          {надо вызвать метод Synchronize                      }
          Synchronize(DoReadPacket);
         End;
        End;

       End;
      End;
     End;
    End;

  Finally
   {закрытие дескриптора сигнального объекта}
   CloseHandle(ReadOL.hEvent);
   {Сброс события и маски ожидания}
   SetCommMask(FHandle, 0);
  End;
 End;

End;

{Вызывается для передачи события о приходе байта}
{в основной компонент через метод Synchronize   }
Procedure TReadThread.DoReadPacket;
Begin
 With FOwner do begin
  If Assigned(OnReadPacket) then
   OnReadPacket(FInBuffer, FCount, FErrCode);
 End;
End;

{ TComProp }

function TComProp.GetDCB: TDCB;
begin
 { Чистка структуры }
 ZeroMemory(@Result, SizeOf(TDCB));
 { Пеле DCBLength должно содержать размер структуры }
 Result.DCBLength:= SizeOf(TDCB);
 { Скорость обмена (бод) }
 Result.BaudRate := WindowsBaudRates[FBaudRate];
 { Windows не поддерживает не бинарный режим работы последовательных портов }
 Result.Flags    := dcb_Binary;
 { Число бит в байте }
 Result.ByteSize := 5 + Ord(FByteSize);
 { Контроль четности }
 Result.Parity   := Ord(FParity);
 { Число стоп бит }
 Result.StopBits := Ord(FStopbits);
end;

procedure TComProp.SetDCB(const Value: TDCB);
var i : TBaudRate;
begin
 {скорость обмена (бод)}
 FBaudRate:= br110;
 For i:= Low(WindowsBaudRates) to High(WindowsBaudRates) do begin
  If Value.BaudRate = WindowsBaudRates[i] then begin
   FBaudRate:= i;
   Break;
  End;
 End;
 {число бит в байте}
 FByteSize:= TByteSize(Value.ByteSize-5);
 {четность}
 FParity  := TParity(Value.Parity);
 {число стоп-бит}
 FStopbits:= TStopBits(Value.StopBits);
end;

end.
