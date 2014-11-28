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
  Menus,
  StdCtrls,
  CastersPackage.uTfisSysMenu;

type
  TMainForm = class(TForm)
    PopupMenu1: TPopupMenu;
    About1: TMenuItem;
    N2: TMenuItem;
    Options1: TMenuItem;
    CheckBox1: TCheckBox;
    N3: TMenuItem;
    fisSysMenu1: TfisSysMenu;
    procedure CheckBox1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.About1Click(Sender: TObject);
begin
  MessageBox(Application.Handle, 'Вы щёлкнули по кнопке ABOUT.', 'Внимание!',
    MB_OK + MB_ICONINFORMATION);
end;

procedure TMainForm.Options1Click(Sender: TObject);
begin
  MessageBox(Application.Handle, 'Вы щёлкнули по кнопке OPTIONS.', 'Внимание!',
    MB_OK + MB_ICONINFORMATION);
end;

procedure TMainForm.CheckBox1Click(Sender: TObject);
begin
  fisSysMenu1.Enabled := CheckBox1.Checked;
end;

end.
