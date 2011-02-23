unit Statistic;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, ExtCtrls, StdCtrls, CheckLst, Buttons, mysql, Main;

type
	TStatisticForm = class(TForm)
		Panel2: TPanel;
		pnlButtons: TPanel;
    btnCreate: TButton;
		btnClose: TButton;
		btnHelp: TButton;
    Panel1: TPanel;
    chklbxUsers: TCheckListBox;
    btbtnUnselectAll: TBitBtn;
    btbtnSelectAll: TBitBtn;
		Label1: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    dtpStartDate_stat: TDateTimePicker;
    dtpStopDate_stat: TDateTimePicker;
    chkbxDetailed: TCheckBox;
    cmbbxSelectedYear: TComboBox;
    cmbbxSelectedMonthYear: TComboBox;
    cmbbxSelectedMonthMonth: TComboBox;
    Label2: TLabel;
    chkbxShowSQLQuery: TCheckBox;
    procedure chkbxDetailedClick(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btbtnUnselectAllClick(Sender: TObject);
    procedure btbtnSelectAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  StatisticForm: TStatisticForm;

implementation

{$R *.dfm}

procedure TStatisticForm.btbtnSelectAllClick(Sender: TObject);
var
	i: integer;
begin
	for i := 0 to chklbxUsers.Count - 1 do
		chklbxUsers.Checked[i]:=True;
	RadioButton1Click(Sender);
end;

procedure TStatisticForm.btbtnUnselectAllClick(Sender: TObject);
var
	i: integer;
begin
	for i := 0 to chklbxUsers.Count - 1 do
		chklbxUsers.Checked[i]:=False;
	RadioButton1Click(Sender);
end;

procedure TStatisticForm.chkbxDetailedClick(Sender: TObject);
begin
	chkbxShowSQLQuery.Enabled:=chkbxDetailed.Checked;
	if not chkbxShowSQLQuery.Enabled then
		chkbxShowSQLQuery.Checked:=False;
end;

procedure TStatisticForm.FormCreate(Sender: TObject);
begin
	dtpStartDate_stat.DateTime:=Now();
	dtpStartDate_stat.Time:=EncodeTime(0,0,0,0);
	dtpStopDate_stat.DateTime:=Now();
	dtpStopDate_stat.Time:=EncodeTime(0,0,0,0);
end;

procedure TStatisticForm.RadioButton1Click(Sender: TObject);
var
	i: integer;
	b: boolean;
begin
	b:=False;
	for i:=0 to chklbxUsers.Count-1 do
		b:=boolean(integer(b)+integer(chklbxUsers.Checked[i]));
	btnCreate.Enabled:=(RadioButton1.Checked or RadioButton2.Checked or RadioButton3.Checked) and b;
	btnClose.Default:=not btnCreate.Enabled;
	btnCreate.Default:=btnCreate.Enabled;
end;

end.
