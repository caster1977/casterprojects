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
 TReadByteEvent = procedure (const B : Byte; PortState : TComStat; ErrCode, ModemState : Cardinal) of object;

 TComPort = class; {опережающее описание}

 {читающий поток}
 TReadThread = class(TThread)
   FOwner  : TComPort;
   FByte   : Byte;
   FPState : TComStat;
   FMState : Cardinal;
   FErrCode: Cardinal;
  Protected
   Procedure Execute; override;
   Procedure DoReadByte;
  Public
   Constructor Create(AOwner : TComPort); 
 End;

 TComPort = class(TComponent)
  Protected
    FBaseAddress : Word;      {базовый адрес порта}
    FHandle      : THandle;   {дескриптор порта}
    FBaudRate    : TBaudRate; {скорость обмена (бод)}
    FByteSize    : TByteSize; {число бит в байте}
    FParity      : TParity;   {четность}
    FStopbits    : TStopbits; {число стоп-бит}
    FOnReadByte  : TReadByteEvent;{событие "получение байта"}
    FReadThread  : TReadThread; {читающий поток}
    Procedure DoOpenPort; {открытие порта}
    Procedure DoClosePort; {закрытие порта}
    Procedure ApplyComSettings; {установка параметров порта}
  Private
    FComNumber: Integer;
    function  GetConnected: Boolean;
    procedure SetConnected(const Value: Boolean);
    procedure SetComNumber(const Value: Integer);
    procedure SetBaudRate(const Value: TBaudRate);
    procedure SetByteSize(const Value: TByteSize);
    procedure SetParity(const Value: TParity);
    procedure SetStopbits(const Value: TStopbits);
    procedure SetReadActive(const Value: Boolean);
    function  GetReadActive: Boolean;
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
    {Передает один байт. В случае успеха возвращает True}
    Function  WriteByte(const B : Byte) : Boolean;
  Public
    {Номер порта. При изменении порт переоткрывается, если был открыт}
    Property ComNumber  : Integer read FComNumber    write SetComNumber;
    {Возвращает True, если порт открыт}
    Property Connected : Boolean read GetConnected write SetConnected;
    {Скорость обмена}
    Property BaudRate  : TBaudRate read FBaudRate write SetBaudRate;
    {Число бит в байте}
    Property ByteSize  : TByteSize read FByteSize write SetByteSize;
    {Четность}
    Property Parity    : TParity   read FParity   write SetParity;
    {Число стоп-бит}
    Property Stopbits  : TStopbits read FStopbits write SetStopbits;
    {Активность чтения порта}
    Property ReadActive : Boolean  read GetReadActive write SetReadActive;
   Public
    {Событие, вызываемое при получении байта}
    Property OnReadByte : TReadByteEvent read FOnReadByte write FOnReadByte;
 End;

implementation

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
 FHandle:= INVALID_HANDLE_VALUE;
 FReadThread:= nil;
End;

Destructor  TComPort.Destroy;
Begin
 DoClosePort;
 Inherited Destroy;
End;

function TComPort.GetConnected: Boolean;
begin
 Result:= (FHandle <> INVALID_HANDLE_VALUE);
end;

procedure TComPort.SetConnected(const Value: Boolean);
begin
 If Value then DoOpenPort else DoClosePort;
end;

Function TComPort.Connect : Boolean;
Begin
 DoOpenPort;
 Result:= Connected;
End;

Procedure TComPort.Open;
Begin
 DoOpenPort;
End;

Procedure TComPort.Close;
Begin
 DoClosePort;
End;

procedure TComPort.SetComNumber(const Value: Integer);
var Active : Boolean;
begin
 If FComNumber = Value then Exit;
 Active:= Connected; {сохраним значение активности порта}
 If Active then DoClosePort; {закрыть порт перед изменением индекса}
 FComNumber:= Value; {устанавливаем новое значение номера порта}
 If Active then DoOpenPort; {открыть порт, если он был открыт}
end;

{открытие порта}
Procedure TComPort.DoOpenPort;
Var ComName : String;
Begin
 If Connected then Exit;

 {Для портов 1..9 можно использовать простые имена COM1..COM9,}
 {но для портов 10-256 надо писать полное имя. Для общности   }
 {будем всегда использовать полное имя порта                  }
 ComName:= Format('\\.\COM%-d', [FComNumber]);

 {Открытие последовательного порта }
 FHandle:= CreateFile(
            PChar(ComName), {передаем имя открываемого порта}
            GENERIC_READ or GENERIC_WRITE, {ресурс для чтения и записи}
            0, { не разделяемый ресурс }
            nil, { Нет атрибутов защиты }
            OPEN_EXISTING, {вернуть ошибку, если ресурс не существует}
            FILE_ATTRIBUTE_NORMAL or FILE_FLAG_OVERLAPPED, {асинхронный режим доступа}
            0 { Должно быть 0 для COM портов }
           ) ;
 {Если ошибка открытия порта - выход}
 If not Connected then Exit;
 {Инициализация порта}
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

{установка параметров порта}
Procedure TComPort.ApplyComSettings;
Var dcb: TDCB; {структура описания параметров порта}
Begin
 If not Connected then Exit;

 { Чистка структуры }
 FillChar(dcb, SizeOf(dcb), 0);
 { Пеле DCBLength должно содержать размер структуры }
 dcb.DCBLength:= SizeOf(dcb);
 { Скорость обмена (бод) }
 dcb.BaudRate := WindowsBaudRates[FBaudRate];
 { Windows не поддерживает не бинарный режим работы последовательных портов }
 dcb.Flags    := dcb_Binary;
 { Число бит в байте }
 dcb.ByteSize := 5 + Ord(FByteSize);
 { Контроль четности }
 dcb.Parity   := Ord(FParity);
 { Число стоп бит }
 dcb.StopBits := Ord(FStopbits);
 { Установить новые настройки порта }
 SetCommState(FHandle, dcb);
End;


procedure TComPort.SetBaudRate(const Value: TBaudRate);
begin
 If FBaudRate = Value then Exit;
 FBaudRate:= Value;
 ApplyComSettings;
end;

procedure TComPort.SetByteSize(const Value: TByteSize);
begin
 If FByteSize = Value then Exit;
 FByteSize:= Value;
 ApplyComSettings;
end;

procedure TComPort.SetParity(const Value: TParity);
begin
 If FParity = Value then Exit;
 FParity := Value;
 ApplyComSettings;
end;

procedure TComPort.SetStopbits(const Value: TStopbits);
begin
 If FStopbits = Value then Exit;
 FStopbits := Value;
 ApplyComSettings;
end;

Function TComPort.GetState(var CodeError : Cardinal) : TComStat;
Begin
 {Возвращает структуру состояния порта и код ошибок}
 ClearCommError(FHandle, CodeError, @Result);
End;

Function TComPort.WriteByte(const B : Byte) : Boolean;
Var Signaled, RealWrite, BytesTrans : Cardinal;   
    WriteOL : TOverLapped; {структура для асинхронной записи}
Begin
 Result:= False;

 {создание события для асинхронной записи}
 FillChar(WriteOL, SizeOf(WriteOL), 0);
 WriteOL.hEvent:= CreateEvent(nil, True, True, nil);
 
 Try
   {начало асинхронной записи}
   WriteFile(FHandle, B, 1, RealWrite, @WriteOL);
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

Function TComPort.GetModemState : Cardinal;
Begin
 {Возвращает состояние модема}
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

{Класс TReadThread class}
Constructor TReadThread.Create(AOwner : TComPort);
Begin
 Inherited Create(True);
 FOwner:= AOwner;
End;

{Основная функция потока}
Procedure TReadThread.Execute;
Var B : Byte; CurrentState : TComStat;
    AvaibleBytes, ErrCode, ModemState, RealRead : Cardinal;
    ReadOL : TOverLapped; {структура для асинхронного чтения}
    Signaled, Mask : DWORD;
    BytesTrans : DWORD; {не используется для WaitCommEvent}
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

       //после GetOverlappedResult в переменной mask, которая передавалась
       //в WaitCommEvent, появятся флаги произошедших событий, либо 0 в
       // случае ошибки.
       If (Mask and EV_RXCHAR) <> 0 then begin
        {Получаем состояние порта (линий и модема)}
        CurrentState:= GetState(ErrCode);
        ModemState  := GetModemState;

        { Число полученных, но еще не прочитанных байт}
        AvaibleBytes:= CurrentState.cbInQue;
        { Проверка числа доступный байт}
        If AvaibleBytes > 0 then begin
         If ReadFile(FHandle, B, 1, RealRead, @ReadOL) then begin
          {сохраняем параметры вызова события}
          FByte   := B;
          FPState := CurrentState;
          FMState := ModemState;
          FErrCode:= ErrCode;
          {Вызываем событие OnReadByte. Для синхронизации с VCL}
          {надо вызвать метод Synchronize                      }
          Synchronize(DoReadByte);
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
Procedure TReadThread.DoReadByte;
Begin
 With FOwner do begin
  If Assigned(FOnReadByte) then
   FOnReadByte(FByte, FPState, FErrCode, FMState);
 End;
End;

end.
