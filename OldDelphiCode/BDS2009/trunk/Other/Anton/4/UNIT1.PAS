unit Unit1;

interface
                                
uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, Buttons, Spin, Mask, 
  ComPort, ComCtrls, ComBin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    btnClose: TBitBtn;
    ParamPanel: TPanel;
    rgPortIndex: TRadioGroup;
    GroupBox1: TGroupBox;
    bRead: TSpeedButton;
    btnClearReadBuf: TSpeedButton;
    GroupBox2: TGroupBox;
    btnSend: TSpeedButton;
    btnOpenPort: TSpeedButton;
    btnClosePort: TSpeedButton;
    StatusBar: TStatusBar;
    ESendValue: TEdit;
    lbBufRead: TListBox;
    FPort: TComPort;
    btnComProperty: TSpeedButton;
    ComBin: TComBin;
    cbUseCS: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure bReadClick(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure btnClearReadBufClick(Sender: TObject);
    procedure btnOpenPortClick(Sender: TObject);
    procedure btnClosePortClick(Sender: TObject);
    procedure btnComPropertyClick(Sender: TObject);
    procedure rgPortIndexClick(Sender: TObject);
    procedure cbUseCSClick(Sender: TObject);
    procedure ComBinNewValueRead(const Value: Single);
  private
  public
   procedure SetEnabledControls; 
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

{инициализация состояния кнопок}
procedure TForm1.FormCreate(Sender: TObject);
begin
 SetEnabledControls;
end;

{Изменение номера порта}
procedure TForm1.rgPortIndexClick(Sender: TObject);
begin
 FPort.ComNumber:= rgPortIndex.ItemIndex+1;
end;

{Кнопка открытия порта}
procedure TForm1.btnOpenPortClick(Sender: TObject);
begin
 FPort.Close;
 FPort.ComNumber:= rgPortIndex.ItemIndex+1;
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
 btnComProperty.Enabled:= Active;
 btnSend.Enabled:= Active;
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

{Очистить буфер чтения}
procedure TForm1.btnClearReadBufClick(Sender: TObject);
begin
 lbBufRead.Items.Clear;
end;

{Передача числа с плавающей точкой}
procedure TForm1.btnSendClick(Sender: TObject);
Var V : Single;
begin
 Try
  V:= StrToFloat(ESendValue.Text);
 Except
  MessageDlg('Неверный формат числа', mtError, [mbOK], 0);
  Exit;
 End; 
 ComBin.SendValue(V);
end;

{Настройка порта}
procedure TForm1.btnComPropertyClick(Sender: TObject);
begin
 FPort.CommDialog;
end;

{Получение нового числа}
procedure TForm1.ComBinNewValueRead(const Value: Single);
begin
 lbBufRead.Items.Add(FloatToStr(Value));
end;

{Включить использование контрольной суммы}
procedure TForm1.cbUseCSClick(Sender: TObject);
begin
 ComBin.UseCS:= cbUseCS.Checked;
end;


end.
