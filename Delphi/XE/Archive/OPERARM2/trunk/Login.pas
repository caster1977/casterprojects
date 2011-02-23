unit Login;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Grids,
  ExtCtrls,
  StdCtrls,
  IniFiles;

type
  TLoginForm= class(TForm)
    Panel1: TPanel;
    BUTTON_Cancel: TButton;
    BUTTON_Apply: TButton;
    Label1: TLabel;
    EDIT_UserName: TEdit;
    Label2: TLabel;
    EDIT_UserPassword: TEdit;
    Image1: TImage;
  end;

var
  LoginForm: TLoginForm;

implementation

uses
  Main;
{$R *.DFM}

end.
