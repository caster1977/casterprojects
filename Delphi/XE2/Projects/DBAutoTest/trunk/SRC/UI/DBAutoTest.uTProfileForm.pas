unit DBAutoTest.uTProfileForm;

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
  Vcl.ExtCtrls,
  Vcl.StdActns,
  CastersPackage.Actions.Classes,
  System.Actions,
  Vcl.ActnList,
  Data.DB,
  Data.Win.ADODB,
  Vcl.Mask, Data.Bind.EngExt, Vcl.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.Components;

type
  TProfileForm = class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    btnHelp: TButton;
    ActionList: TActionList;
    actClear: TAction;
    actApply: TAction;
    actCancel: TAction;
    actHelp: TAction_Help;
    GroupBox1: TGroupBox;
    lblGroup: TLabel;
    cmbGroup: TComboBox;
    lblName: TLabel;
    cmbName: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    MaskEdit1: TMaskEdit;
    ADOConnection: TADOConnection;
    RadioButton1: TRadioButton;
    Label3: TLabel;
    RadioButton2: TRadioButton;
    Button1: TButton;
    actTestConnection: TAction;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    actUseWinNTSecurity: TAction;
  end;

implementation

{$R *.dfm}

end.
