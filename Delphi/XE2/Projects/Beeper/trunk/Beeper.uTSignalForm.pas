unit Beeper.uTSignalForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Beeper.uISignal;

type
  TSignalForm = class(TForm)
    ImageList: TImageList;
    ledTitle: TLabeledEdit;
    Label2: TLabel;
    ledPeriod: TLabeledEdit;
    cmbxPeriodType: TComboBox;
    ActionList: TActionList;
    Button1: TButton;
    Button2: TButton;
    ComboBox2: TComboBox;
    Button3: TButton;
    PlayButton: TBitBtn;
    CheckBox1: TCheckBox;
    procedure ledPeriodKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
  strict private
    function GetSignal: ISignal;
  public
    property Signal: ISignal read GetSignal nodefault;
  end;

implementation

{$R *.dfm}

uses
  Winapi.MMSystem,
  Beeper.uTSignal,
  Beeper.uConsts,
  Beeper.uTPeriodType;

procedure TSignalForm.FormCreate(Sender: TObject);
var
  pt: TPeriodType;
begin
  cmbxPeriodType.Clear;
  for pt := Low(TPeriodType) to High(TPeriodType) do
    cmbxPeriodType.Items.Add(PERIODS[pt]);
end;

function TSignalForm.GetSignal: ISignal;
begin
  Result := TSignal.Create;
  Result.Title := Trim(ledTitle.Text);
end;

procedure TSignalForm.ledPeriodKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key, ['0'..'9', #8]) then
    Key:=#0; // "погасить" все остальные клавиши
end;

end.
