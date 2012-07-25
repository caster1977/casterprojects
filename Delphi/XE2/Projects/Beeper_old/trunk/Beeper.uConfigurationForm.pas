unit Beeper.uConfigurationForm;

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
  ExtCtrls,
  StdCtrls;

type
  TConfigurationForm=class(TForm)
    ButtonOk: TButton;
    ButtonCancel: TButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    ComboBox2: TComboBox;
    Bevel1: TBevel;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    procedure UpdateButtonState;
  end;

implementation

{$R *.dfm}

procedure TConfigurationForm.CheckBox1Click(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TConfigurationForm.UpdateButtonState;
begin
  ButtonOk.Enabled:=not((CheckBox1.Checked=CheckBox4.Checked)and(CheckBox2.Checked=CheckBox5.Checked)and(CheckBox3.Checked=CheckBox6.Checked)and(ComboBox1.ItemIndex=ComboBox2.ItemIndex));
  ButtonOk.default:=not((CheckBox1.Checked=CheckBox4.Checked)and(CheckBox2.Checked=CheckBox5.Checked)and(CheckBox3.Checked=CheckBox6.Checked)and(ComboBox1.ItemIndex=ComboBox2.ItemIndex));
  ButtonCancel.default:=((CheckBox1.Checked=CheckBox4.Checked)and(CheckBox2.Checked=CheckBox5.Checked)and(CheckBox3.Checked=CheckBox6.Checked)and(ComboBox1.ItemIndex=ComboBox2.ItemIndex));
end;

end.
