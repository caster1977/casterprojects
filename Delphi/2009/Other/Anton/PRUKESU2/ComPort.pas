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

 {��� ������� ��� ��������� �����}
 TReadByteEvent = procedure (const B : Byte; PortState : TComStat; ErrCode, ModemState : Cardinal) of object;

 TComPort = class; {����������� ��������}

 {�������� �����}
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
    FBaseAddress : Word;      {������� ����� �����}
    FHandle      : THandle;   {���������� �����}
    FBaudRate    : TBaudRate; {�������� ������ (���)}
    FByteSize    : TByteSize; {����� ��� � �����}
    FParity      : TParity;   {��������}
    FStopbits    : TStopbits; {����� ����-���}
    FOnReadByte  : TReadByteEvent;{������� "��������� �����"}
    FReadThread  : TReadThread; {�������� �����}
    Procedure DoOpenPort; {�������� �����}
    Procedure DoClosePort; {�������� �����}
    Procedure ApplyComSettings; {��������� ���������� �����}
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
    {���������/��������� ����}
    Procedure Open;
    Procedure Close;
    {���������� True, ���� ���� ������}
    Function  Connect : Boolean;
    {���������� ��������� ��������� ����� ComStat, � �    }
    {���������� CodeError ������������ ������� ��� ������ }
    Function  GetState(var CodeError : Cardinal) : TComStat;
    {���������� ��������� ������}
    Function  GetModemState : Cardinal;
    {�������� ���� ����. � ������ ������ ���������� True}
    Function  WriteByte(const B : Byte) : Boolean;
  Public
    {����� �����. ��� ��������� ���� ���������������, ���� ��� ������}
    Property ComNumber  : Integer read FComNumber    write SetComNumber;
    {���������� True, ���� ���� ������}
    Property Connected : Boolean read GetConnected write SetConnected;
    {�������� ������}
    Property BaudRate  : TBaudRate read FBaudRate write SetBaudRate;
    {����� ��� � �����}
    Property ByteSize  : TByteSize read FByteSize write SetByteSize;
    {��������}
    Property Parity    : TParity   read FParity   write SetParity;
    {����� ����-���}
    Property Stopbits  : TStopbits read FStopbits write SetStopbits;
    {���������� ������ �����}
    Property ReadActive : Boolean  read GetReadActive write SetReadActive;
   Public
    {�������, ���������� ��� ��������� �����}
    Property OnReadByte : TReadByteEvent read FOnReadByte write FOnReadByte;
 End;

implementation

Const
  WindowsBaudRates: array[br110..br115200] of DWORD = (
    CBR_110, CBR_300, CBR_600, CBR_1200, CBR_2400, CBR_4800, CBR_9600,
    CBR_14400, CBR_19200, CBR_38400, CBR_56000, CBR_57600, CBR_115200
    {CRB_128000, CBR_256000 - ������� � Windows.pas, �� �� ������������}
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
 Active:= Connected; {�������� �������� ���������� �����}
 If Active then DoClosePort; {������� ���� ����� ���������� �������}
 FComNumber:= Value; {������������� ����� �������� ������ �����}
 If Active then DoOpenPort; {������� ����, ���� �� ��� ������}
end;

{�������� �����}
Procedure TComPort.DoOpenPort;
Var ComName : String;
Begin
 If Connected then Exit;

 {��� ������ 1..9 ����� ������������ ������� ����� COM1..COM9,}
 {�� ��� ������ 10-256 ���� ������ ������ ���. ��� ��������   }
 {����� ������ ������������ ������ ��� �����                  }
 ComName:= Format('\\.\COM%-d', [FComNumber]);

 {�������� ����������������� ����� }
 FHandle:= CreateFile(
            PChar(ComName), {�������� ��� ������������ �����}
            GENERIC_READ or GENERIC_WRITE, {������ ��� ������ � ������}
            0, { �� ����������� ������ }
            nil, { ��� ��������� ������ }
            OPEN_EXISTING, {������� ������, ���� ������ �� ����������}
            FILE_ATTRIBUTE_NORMAL or FILE_FLAG_OVERLAPPED, {����������� ����� �������}
            0 { ������ ���� 0 ��� COM ������ }
           ) ;
 {���� ������ �������� ����� - �����}
 If not Connected then Exit;
 {������������� �����}
 ApplyComSettings;
 {�������� ��������� ������}
 If not Assigned(FReadThread) then
  FReadThread:= TReadThread.Create(Self);
End;

{�������� �����}
Procedure TComPort.DoClosePort;
Begin
 If not Connected then Exit;
 {������������ ����� ������}
 ReadActive:= False;
 {����������� ��������� ������}
 FReadThread.FreeOnTerminate:= True;
 FReadThread.Terminate;
 FReadThread:= nil;
 {������������ ����������� �����}
 CloseHandle(FHandle);
 {����� ����������� �����}
 FHandle:= INVALID_HANDLE_VALUE;
End;

{��������� ���������� �����}
Procedure TComPort.ApplyComSettings;
Var dcb: TDCB; {��������� �������� ���������� �����}
Begin
 If not Connected then Exit;

 { ������ ��������� }
 FillChar(dcb, SizeOf(dcb), 0);
 { ���� DCBLength ������ ��������� ������ ��������� }
 dcb.DCBLength:= SizeOf(dcb);
 { �������� ������ (���) }
 dcb.BaudRate := WindowsBaudRates[FBaudRate];
 { Windows �� ������������ �� �������� ����� ������ ���������������� ������ }
 dcb.Flags    := dcb_Binary;
 { ����� ��� � ����� }
 dcb.ByteSize := 5 + Ord(FByteSize);
 { �������� �������� }
 dcb.Parity   := Ord(FParity);
 { ����� ���� ��� }
 dcb.StopBits := Ord(FStopbits);
 { ���������� ����� ��������� ����� }
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
 {���������� ��������� ��������� ����� � ��� ������}
 ClearCommError(FHandle, CodeError, @Result);
End;

Function TComPort.WriteByte(const B : Byte) : Boolean;
Var Signaled, RealWrite, BytesTrans : Cardinal;   
    WriteOL : TOverLapped; {��������� ��� ����������� ������}
Begin
 Result:= False;

 {�������� ������� ��� ����������� ������}
 FillChar(WriteOL, SizeOf(WriteOL), 0);
 WriteOL.hEvent:= CreateEvent(nil, True, True, nil);
 
 Try
   {������ ����������� ������}
   WriteFile(FHandle, B, 1, RealWrite, @WriteOL);
   {�������� ���������� ����������� ��������}
   Signaled:= WaitForSingleObject(WriteOL.hEvent, INFINITE);
   {��������� ���������� ����������� ��������}
   Result  :=
      (Signaled = WAIT_OBJECT_0) and
      (GetOverlappedResult(FHandle, WriteOL, BytesTrans, False));
 Finally
  {������������ ����������� �������}
  CloseHandle(WriteOL.hEvent);
 End;  
End;

Function TComPort.GetModemState : Cardinal;
Begin
 {���������� ��������� ������}
 GetCommModemStatus(FHandle, Result);
End;

{���������� ������ �����}
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

{����� TReadThread class}
Constructor TReadThread.Create(AOwner : TComPort);
Begin
 Inherited Create(True);
 FOwner:= AOwner;
End;

{�������� ������� ������}
Procedure TReadThread.Execute;
Var B : Byte; CurrentState : TComStat;
    AvaibleBytes, ErrCode, ModemState, RealRead : Cardinal;
    ReadOL : TOverLapped; {��������� ��� ������������ ������}
    Signaled, Mask : DWORD;
    BytesTrans : DWORD; {�� ������������ ��� WaitCommEvent}
Begin
 With FOwner do begin
  Try
    {�������� ������� ��� ������������ ������}
    FillChar(ReadOL, SizeOf(ReadOL), 0);
    ReadOL.hEvent:= CreateEvent(nil, True, True, nil);

    {����� �������, ������� ����� ����������� �������� ����� }
    {���� ��� ������ ��������� �������                       }
    SetCommMask(FHandle, EV_RXCHAR);

    While (not Terminated) and Connected do begin {���� ���� ������}
     { ���� ������ �� ������� }
     WaitCommEvent(FHandle, Mask, @ReadOL);

     Signaled:= WaitForSingleObject(ReadOL.hEvent, INFINITE);

     If (Signaled  = WAIT_OBJECT_0) then begin
      If GetOverlappedResult(FHandle, ReadOL, BytesTrans, False) then begin

       //����� GetOverlappedResult � ���������� mask, ������� ������������
       //� WaitCommEvent, �������� ����� ������������ �������, ���� 0 �
       // ������ ������.
       If (Mask and EV_RXCHAR) <> 0 then begin
        {�������� ��������� ����� (����� � ������)}
        CurrentState:= GetState(ErrCode);
        ModemState  := GetModemState;

        { ����� ����������, �� ��� �� ����������� ����}
        AvaibleBytes:= CurrentState.cbInQue;
        { �������� ����� ��������� ����}
        If AvaibleBytes > 0 then begin
         If ReadFile(FHandle, B, 1, RealRead, @ReadOL) then begin
          {��������� ��������� ������ �������}
          FByte   := B;
          FPState := CurrentState;
          FMState := ModemState;
          FErrCode:= ErrCode;
          {�������� ������� OnReadByte. ��� ������������� � VCL}
          {���� ������� ����� Synchronize                      }
          Synchronize(DoReadByte);
         End;
        End;

       End;
      End;
     End;
    End;

  Finally
   {�������� ����������� ����������� �������} 
   CloseHandle(ReadOL.hEvent);
   {����� ������� � ����� ��������}
   SetCommMask(FHandle, 0);
  End;
 End;

End;

{���������� ��� �������� ������� � ������� �����}
{� �������� ��������� ����� ����� Synchronize   }
Procedure TReadThread.DoReadByte;
Begin
 With FOwner do begin
  If Assigned(FOnReadByte) then
   FOnReadByte(FByte, FPState, FErrCode, FMState);
 End;
End;

end.
