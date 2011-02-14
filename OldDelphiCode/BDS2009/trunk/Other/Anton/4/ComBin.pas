unit ComBin;

interface

uses
  Windows, SysUtils, Classes, Forms, ComPort;

Type
 {Событие при получении нового значения}
 TNewValueRead = procedure(const Value : Single) of object;

 SingleArray = Array [1..4] of Byte;

 {Реализация простого бинарного протокола обмена}
 TComBin = class(TComponent)
  private
    FComPort : TComPort; {транспортный компонент}
    FStartByte : Byte;   {байт начала посылки   }
    FEndByte   : Byte;   {байт конца посылки    }
    FOnNewValueRead : TNewValueRead; {событие}
    FByteIndex : Integer; {счетчик байт посылки}
    FInBuffer  : SingleArray; {буфер для числа}
    FUseCS     : Boolean; {проверка контрольной суммы}
    procedure SetComPort(const Value: TComPort);
    procedure OnPortReadPacket(const Packet: Pointer;
         const Size: Integer; const ErrCode: Cardinal);
    function  GetPacketSize : Integer;
   {Вычисление контрольной суммы для числа Single}
    function  GetCSSingle(AValue : Single) : Byte;
   {Вычисление контрольной суммы для SingleArray}
    function  GetCSBuf(Buf : SingleArray) : Byte;
  Public
   Constructor Create(AOwner : TComponent); override;
   Destructor  Destroy; override;
   Procedure   Notification(AComponent: TComponent; Operation: TOperation); override;
  Published
   {Привязка к компоненту TComPort}
   Property ComPort : TComPort read FComPort write SetComPort;
   {Стартовый байт}
   Property StartByte: Byte read FStartByte write FStartByte;
   {Завершающий байт}
   Property EndByte  : Byte read FEndByte write FEndByte;
   {Проверка контрольной суммы}
   Property UseCS : Boolean read FUseCS write FUseCS;
  Published
   {Событие при получении новой строки}
   Property OnNewValueRead : TNewValueRead read FOnNewValueRead write FOnNewValueRead;
  Public
   {Передача числа, согласно протоколу. }
   Procedure SendValue(const AValue : Single);
 End;

Procedure Register;

implementation

{Добавление ресурса с иконкой для палитры компонент}
{$R *.dcr}

Procedure Register;
Begin
 RegisterComponents('Comm', [TComBin]);
End;

Constructor TComBin.Create(AOwner : TComponent);
Begin
 Inherited Create(AOwner);
 FByteIndex:= 0;
End;

Destructor  TComBin.Destroy;
Begin
 Inherited Destroy;
End;

{Вызывается при операциях в редакторе форм Delphi.}
procedure TComBin.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  {Если компонент TComPort удалили с формы...}
  if (Operation = opRemove) and (FComPort <> nil) then begin
    if AComponent = FComPort then FComPort:= nil;
  end;
end;

{Вычисление контрольной суммы для числа Single}
function  TComBin.GetCSSingle(AValue : Single) : Byte;
Var Buf : SingleArray;
begin
 Move(AValue, Buf, SizeOf(Buf));
 Result:= GetCSBuf(Buf);
end;

{Вычисление контрольной суммы для SingleArray}
function  TComBin.GetCSBuf(Buf : SingleArray) : Byte;
var i : Integer;
begin
 Result:= 0;
 {$R-}
 For i:= Low(Buf) to High(Buf) do begin
  Result:= Result + Buf[i];
 End;
 {$R+}
end;

{Передача числа, согласно протоколу}
procedure TComBin.SendValue(const AValue : Single);
Var CS : Byte;
begin
 If Assigned(FComPort) then
  If FComPort.Connected then begin
   {Послать символ начала посылки}
   FComPort.WriteBuffer(@FStartByte, SizeOf(FStartByte));
   {Послать число}
   FComPort.WriteBuffer(@AValue    , SizeOf(AValue    ));
   {Послать символ завершения посылки}
   FComPort.WriteBuffer(@FEndByte  , SizeOf(FEndByte  ));
   {контрольная сумма, если включено}
   If FUseCS then begin
    CS:= GetCSSingle(AValue);
    FComPort.WriteBuffer(@CS, SizeOf(CS));
   End;
  End;
end;

{Привязка к компоненту TComPort}
procedure TComBin.SetComPort(const Value: TComPort);
begin
 FComPort:= nil;
 If Value <> nil then begin
  FComPort:= Value;
  {Заставляем компонент TComPort}
  {пересылать уведомления редактора}
  {форм этому компоненту}
  FComPort.FreeNotification(Self);
  {Перехватываем обработчик получения новых пакетов}
  FComPort.OnReadPacket:= OnPortReadPacket;
 End;
end;

{Вычисление размера передаваемого пакета}
function TComBin.GetPacketSize : Integer;
begin
 Result:= SizeOf(FStartByte) + SizeOf(Single) + SizeOf(FEndByte);
 If FUseCS then {+контрольная сумма}
  Inc(Result);
end;

{Обработка получения нового значения}
procedure TComBin.OnPortReadPacket(const Packet: Pointer;
        const Size: Integer; const ErrCode: Cardinal);
Var B : Byte; i : Integer; bNextByte : Boolean; AValue : Single;
begin
 For i:= 0 to Size-1 do begin
  B:= Byte(Pointer(LongInt(Packet)+i)^);
  bNextByte:= False;
  Case FByteIndex of
   0: begin     // ожидается символ начала посылки
     bNextByte:= (B = FStartByte);
   End;{0}
   1..4: begin // получение числа
    FInBuffer[FByteIndex]:= B;
    bNextByte:= True;
   End; {1..4}
   5: begin   // ожидается символ конца посылки
     bNextByte:= (B = FEndByte);
   End; {5}
   6: begin
     bNextByte:= (B= GetCSBuf(FInBuffer));
   End; {6}
  End;

  If bNextByte then begin
   {переходим к ожиданию следующего}
   {байта посылки}
   Inc(FByteIndex);
  End else begin
   {неверный формат посылки}
   {начинаем ожидание сначала}
   FByteIndex:= 0;
  End;

  {посылка закончена}
  If FByteIndex = GetPacketSize then begin
   Try
    Try
     {Переписываем буфер в число Single}
     Move(FInBuffer, AValue, SizeOf(AValue));
    Except End;
    {Вызываем обработчик}
    If Assigned(FOnNewValueRead) then
     FOnNewValueRead(AValue);
   Finally
    {Независимо от ошибок начинаем отсчет снова}
    FByteIndex:= 0;
   End; 
  End;
 End;
 
end;



end.
 