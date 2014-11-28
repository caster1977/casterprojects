unit Main;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  CheckLst,
  ExtCtrls;

type
  TMainForm = class(TForm)
    Panel1: TPanel;
    btnGetProsessAffinity: TButton;
    btnExit: TButton;
    btnSetProsessAffinity: TButton;
    cbProcessor1: TCheckBox;
    cbProcessor2: TCheckBox;
    cbProcessor3: TCheckBox;
    cbProcessor4: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure btnSetProsessAffinityClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnGetProsessAffinityClick(Sender: TObject);
  strict private
    h: NativeUInt;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.btnGetProsessAffinityClick(Sender: TObject);
var
  ProcessAffinityMask, SystemAffinityMask: NativeUInt;
  b: Cardinal;
  es: string;
begin
  b := Cardinal(GetProcessAffinityMask(h, ProcessAffinityMask, SystemAffinityMask));
  if (b = 0) then
  begin
    es := 'Error ocurred while getting process affinity. Error Code: ' + IntToStr(GetLastError);
    MessageBox(ClientHandle, PChar(es), 'Error!', MB_OK + MB_ICONERROR);
  end;
  cbProcessor1.Enabled := Boolean(SystemAffinityMask and 1);
  cbProcessor2.Enabled := Boolean(SystemAffinityMask and 2);
  cbProcessor3.Enabled := Boolean(SystemAffinityMask and 4);
  cbProcessor4.Enabled := Boolean(SystemAffinityMask and 8);
  cbProcessor1.Checked := Boolean(ProcessAffinityMask and 1);
  cbProcessor2.Checked := Boolean(ProcessAffinityMask and 2);
  cbProcessor3.Checked := Boolean(ProcessAffinityMask and 4);
  cbProcessor4.Checked := Boolean(ProcessAffinityMask and 8);
  btnSetProsessAffinity.Enabled := cbProcessor1.Enabled or cbProcessor2.Enabled or
    cbProcessor3.Enabled or cbProcessor4.Enabled;
end;

procedure TMainForm.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.btnSetProsessAffinityClick(Sender: TObject);
var
  a: NativeUInt;
  es: string;
begin
  a := 0;
  if cbProcessor1.Enabled then
    a := a + (LongWord(cbProcessor1.Checked) shl 0);
  if cbProcessor2.Enabled then
    a := a + (LongWord(cbProcessor2.Checked) shl 1);
  if cbProcessor3.Enabled then
    a := a + (LongWord(cbProcessor3.Checked) shl 2);
  if cbProcessor4.Enabled then
    a := a + (LongWord(cbProcessor4.Checked) shl 3);
  if Cardinal(SetProcessAffinityMask(h, a)) = 0 then
  begin
    es := 'Error ocurred while setting process affinity. Error Code: ' + IntToStr(GetLastError);
    MessageBox(ClientHandle, PChar(es), 'Error!', MB_OK + MB_ICONERROR);
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  h := GetCurrentProcess;
end;

end.
