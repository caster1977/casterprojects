unit Unit1;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls, Spin, ComPort;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnClose: TBitBtn;
    ParamPanel: TPanel;
    rgPortIndex: TRadioGroup;
    rgDataLen: TRadioGroup;
    rgStopBits: TRadioGroup;
    rgBaud: TRadioGroup;
    rgParity: TRadioGroup;
    GroupBox1: TGroupBox;
    bRead: TSpeedButton;
    Panel3: TPanel;
    Bevel2: TBevel;
    DR: TShape;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    OE: TShape;
    PE: TShape;
    FE: TShape;
    BD: TShape;
    DCD: TShape;
    RI: TShape;
    CTS: TShape;
    DSR: TShape;
    TERI: TShape;
    Label12: TLabel;
    eReadBuffer: TEdit;
    btnClearReadBuf: TSpeedButton;
    GroupBox2: TGroupBox;
    btnSend: TSpeedButton;
    seSendByte: TSpinEdit;
    btnOpenPort: TSpeedButton;
    btnClosePort: TSpeedButton;
    StatusBar: TStatusBar;
    eAvaibleBytes: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure bReadClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnClearReadBufClick(Sender: TObject);
    procedure btnOpenPortClick(Sender: TObject);
    procedure btnClosePortClick(Sender: TObject);
    procedure rgDataLenClick(Sender: TObject);
    procedure rgStopBitsClick(Sender: TObject);
    procedure rgParityClick(Sender: TObject);
    procedure rgBaudClick(Sender: TObject);
  private
    { Компонент для доступа к порту. Будем создавать его}
    { динамически.                                      }
    FPort : TComPort;
    procedure OnReadByte(const B : Byte; PortState : TComStat; ErrCode, ModemState : Cardinal);    
  public
   procedure SetPortProperties;
   procedure SetEnabledControls; 
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{ Создание компонента доступа к портам при создании формы }
procedure TForm1.FormCreate(Sender: TObject);
begin
 FPort:= TComPort.Create(Self);
 FPort.OnReadByte:= OnReadByte;
 SetEnabledControls;
end;

{Вызывается при уничтожении формы (выходе из программы) }
procedure TForm1.FormDestroy(Sender: TObject);
begin
 FPort.Free;
end;

{Кнопка открытия порта}
procedure TForm1.btnOpenPortClick(Sender: TObject);
begin
 FPort.Close;
 FPort.ComNumber:= rgPortIndex.ItemIndex+1;
 SetPortProperties;
 FPort.Open;
 If FPort.Connected then
  StatusBar.Panels[0].Text:= 'Порт успешно открыт'
 Else
  StatusBar.Panels[0].Text:= 'Ошибка открытия порта';
 SetEnabledControls;
end;

procedure TForm1.btnClosePortClick(Sender: TObject);
begin
 FPort.Close;
 StatusBar.Panels[0].Text:= '';
 SetEnabledControls;
 bRead.Down:= False;
end;

procedure TForm1.SetEnabledControls;
Var Active : Boolean;
begin
 Active:= FPort.Connected;
 btnClosePort.Enabled:= Active;
 rgPortIndex.Enabled := not Active;
 btnOpenPort.Enabled := not Active;
 rgDataLen.Enabled   := Active;
 rgStopBits.Enabled  := Active;
 rgParity.Enabled    := Active;
 rgBaud.Enabled      := Active;
end;

{Задание свойств порта}
procedure TForm1.SetPortProperties;
begin
 rgDataLenClick(nil);
 rgStopBitsClick(nil);
 rgParityClick(nil);
 rgBaudClick(nil);
end;


{Кнопка закрытия программы}
procedure TForm1.btnCloseClick(Sender: TObject);
begin
 Close;
end;

{Кнопка опроса порта}
procedure TForm1.bReadClick(Sender: TObject);
begin
 FPort.ReadActive:= bRead.Down;
end;

Const {Цвета индикаторов}
 IColor : Array [Boolean] of TColor = (clWhite, clGreen);

procedure TForm1.OnReadByte(const B : Byte; PortState : TComStat; ErrCode, ModemState : Cardinal);
Var S : String;  AvaibleBytes : Cardinal;
begin
 { Отображаем число полученных, но еще не прочитанных байт}
 AvaibleBytes:= PortState.cbInQue;
 eAvaibleBytes.Text:= IntToStr(AvaibleBytes);

 {Теперь нет необходимости проверять наличие байта для чтения,}
 {событие OnReadByte вызывается только после считывания байта }
 S:= eReadBuffer.Text;
 S:= S + Format('$%X',[B]);
 If Length(S) > 40 then Delete(S, 1, 3);
 eReadBuffer.Text:= S;

 {Отображение индикаторов состояния порта}
 { Данные готовы   }
 DR.Brush.Color:= IColor[AvaibleBytes >  0];
 { Переполнение    }
 OE.Brush.Color:= IColor[(ErrCode and CE_OVERRUN ) <> 0];
 { Ошибка паритета }
 PE.Brush.Color:= IColor[(ErrCode and CE_RXPARITY) <> 0];
 { Ошибка кадра    }
 FE.Brush.Color:= IColor[(ErrCode and CE_FRAME   ) <> 0];
 { Обрыв линии     }
 BD.Brush.Color:= IColor[(ErrCode and CE_BREAK   ) <> 0];

 {Отображение индикаторов состояния модема}
 ModemState:= FPort.GetModemState;
 {Сигнал DCD (data carrier detect)}
 DCD.Brush.Color := IColor[(ModemState and MS_RLSD_ON) <> 0];
 {Состояние линии RI (ring indicator)}
 RI .Brush.Color := IColor[(ModemState and MS_RING_ON) <> 0];
 {Состояние линии DSR (data set ready)}
 DSR.Brush.Color := IColor[(ModemState and MS_DSR_ON ) <> 0];
 {Состояние линии CTS (clear to send)}
 CTS.Brush.Color := IColor[(ModemState and MS_CTS_ON ) <> 0];
 { Сигнал "спад огибающей" (окончание звонка) }
 { Не определяется в Windows 						      }
 {TERI.Brush.Color:= IColor[(CurrentState and $04) <> 0];}
end;

{Очистить буфер чтения}
procedure TForm1.btnClearReadBufClick(Sender: TObject);
begin
 eReadBuffer.Text:= '';
end;

{Отправка байта}
procedure TForm1.btnSendClick(Sender: TObject);
begin
 FPort.WriteByte(seSendByte.Value);
end;

{Длина байта}
procedure TForm1.rgDataLenClick(Sender: TObject);
begin
 FPort.ByteSize:= TByteSize(rgDataLen.ItemIndex);
end;

{Число стоп-бит. Так как Windows оставляет контроль за}
{правильностью настроек на программиста, то запрещаем }
{выставлять 2 стоп-бита для не 5-битовых данных       }
procedure TForm1.rgStopBitsClick(Sender: TObject);
begin
 Case rgStopBits.ItemIndex of
  0: // 1 стоп-бит
   FPort.Stopbits:= sb1BITS;
  1: // 2 (1.5) стоп-бита
   If rgDataLen.ItemIndex = 0 then FPort.Stopbits:= sb1HALFBITS
    Else FPort.Stopbits:= sb2BITS;
 End;
end;

{Контроль четности}
procedure TForm1.rgParityClick(Sender: TObject);
begin
 FPort.Parity  := TParity(rgParity.ItemIndex);
end;

{Скорость передачи}
procedure TForm1.rgBaudClick(Sender: TObject);
begin
 FPort.BaudRate:= TBaudRate(rgBaud.ItemIndex);
end;

end.
