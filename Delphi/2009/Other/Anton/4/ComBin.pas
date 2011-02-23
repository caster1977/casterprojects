unit ComBin;

interface

uses
  Windows, SysUtils, Classes, Forms, ComPort;

Type
 {������� ��� ��������� ������ ��������}
 TNewValueRead = procedure(const Value : Single) of object;

 SingleArray = Array [1..4] of Byte;

 {���������� �������� ��������� ��������� ������}
 TComBin = class(TComponent)
  private
    FComPort : TComPort; {������������ ���������}
    FStartByte : Byte;   {���� ������ �������   }
    FEndByte   : Byte;   {���� ����� �������    }
    FOnNewValueRead : TNewValueRead; {�������}
    FByteIndex : Integer; {������� ���� �������}
    FInBuffer  : SingleArray; {����� ��� �����}
    FUseCS     : Boolean; {�������� ����������� �����}
    procedure SetComPort(const Value: TComPort);
    procedure OnPortReadPacket(const Packet: Pointer;
         const Size: Integer; const ErrCode: Cardinal);
    function  GetPacketSize : Integer;
   {���������� ����������� ����� ��� ����� Single}
    function  GetCSSingle(AValue : Single) : Byte;
   {���������� ����������� ����� ��� SingleArray}
    function  GetCSBuf(Buf : SingleArray) : Byte;
  Public
   Constructor Create(AOwner : TComponent); override;
   Destructor  Destroy; override;
   Procedure   Notification(AComponent: TComponent; Operation: TOperation); override;
  Published
   {�������� � ���������� TComPort}
   Property ComPort : TComPort read FComPort write SetComPort;
   {��������� ����}
   Property StartByte: Byte read FStartByte write FStartByte;
   {����������� ����}
   Property EndByte  : Byte read FEndByte write FEndByte;
   {�������� ����������� �����}
   Property UseCS : Boolean read FUseCS write FUseCS;
  Published
   {������� ��� ��������� ����� ������}
   Property OnNewValueRead : TNewValueRead read FOnNewValueRead write FOnNewValueRead;
  Public
   {�������� �����, �������� ���������. }
   Procedure SendValue(const AValue : Single);
 End;

Procedure Register;

implementation

{���������� ������� � ������� ��� ������� ���������}
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

{���������� ��� ��������� � ��������� ���� Delphi.}
procedure TComBin.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;
  {���� ��������� TComPort ������� � �����...}
  if (Operation = opRemove) and (FComPort <> nil) then begin
    if AComponent = FComPort then FComPort:= nil;
  end;
end;

{���������� ����������� ����� ��� ����� Single}
function  TComBin.GetCSSingle(AValue : Single) : Byte;
Var Buf : SingleArray;
begin
 Move(AValue, Buf, SizeOf(Buf));
 Result:= GetCSBuf(Buf);
end;

{���������� ����������� ����� ��� SingleArray}
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

{�������� �����, �������� ���������}
procedure TComBin.SendValue(const AValue : Single);
Var CS : Byte;
begin
 If Assigned(FComPort) then
  If FComPort.Connected then begin
   {������� ������ ������ �������}
   FComPort.WriteBuffer(@FStartByte, SizeOf(FStartByte));
   {������� �����}
   FComPort.WriteBuffer(@AValue    , SizeOf(AValue    ));
   {������� ������ ���������� �������}
   FComPort.WriteBuffer(@FEndByte  , SizeOf(FEndByte  ));
   {����������� �����, ���� ��������}
   If FUseCS then begin
    CS:= GetCSSingle(AValue);
    FComPort.WriteBuffer(@CS, SizeOf(CS));
   End;
  End;
end;

{�������� � ���������� TComPort}
procedure TComBin.SetComPort(const Value: TComPort);
begin
 FComPort:= nil;
 If Value <> nil then begin
  FComPort:= Value;
  {���������� ��������� TComPort}
  {���������� ����������� ���������}
  {���� ����� ����������}
  FComPort.FreeNotification(Self);
  {������������� ���������� ��������� ����� �������}
  FComPort.OnReadPacket:= OnPortReadPacket;
 End;
end;

{���������� ������� ������������� ������}
function TComBin.GetPacketSize : Integer;
begin
 Result:= SizeOf(FStartByte) + SizeOf(Single) + SizeOf(FEndByte);
 If FUseCS then {+����������� �����}
  Inc(Result);
end;

{��������� ��������� ������ ��������}
procedure TComBin.OnPortReadPacket(const Packet: Pointer;
        const Size: Integer; const ErrCode: Cardinal);
Var B : Byte; i : Integer; bNextByte : Boolean; AValue : Single;
begin
 For i:= 0 to Size-1 do begin
  B:= Byte(Pointer(LongInt(Packet)+i)^);
  bNextByte:= False;
  Case FByteIndex of
   0: begin     // ��������� ������ ������ �������
     bNextByte:= (B = FStartByte);
   End;{0}
   1..4: begin // ��������� �����
    FInBuffer[FByteIndex]:= B;
    bNextByte:= True;
   End; {1..4}
   5: begin   // ��������� ������ ����� �������
     bNextByte:= (B = FEndByte);
   End; {5}
   6: begin
     bNextByte:= (B= GetCSBuf(FInBuffer));
   End; {6}
  End;

  If bNextByte then begin
   {��������� � �������� ����������}
   {����� �������}
   Inc(FByteIndex);
  End else begin
   {�������� ������ �������}
   {�������� �������� �������}
   FByteIndex:= 0;
  End;

  {������� ���������}
  If FByteIndex = GetPacketSize then begin
   Try
    Try
     {������������ ����� � ����� Single}
     Move(FInBuffer, AValue, SizeOf(AValue));
    Except End;
    {�������� ����������}
    If Assigned(FOnNewValueRead) then
     FOnNewValueRead(AValue);
   Finally
    {���������� �� ������ �������� ������ �����}
    FByteIndex:= 0;
   End; 
  End;
 End;
 
end;



end.
 