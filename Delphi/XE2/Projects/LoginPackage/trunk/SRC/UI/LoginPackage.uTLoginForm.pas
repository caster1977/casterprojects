unit LoginPackage.uTLoginForm;

interface

uses
  Vcl.ExtCtrls,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.Mask,
  Vcl.StdCtrls,
  System.Actions,
  Vcl.Forms;

type
  TLoginForm = class(TForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actHelp: TAction;
    actEnter: TAction;
    actClose: TAction;
    pnlButtons: TPanel;
    btnHelp: TButton;
    btnEnter: TButton;
    btnClose: TButton;
    lblLogin: TLabel;
    edbxLogin: TEdit;
    lblPassword: TLabel;
    mePassword: TMaskEdit;
    procedure actEnterExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actEnterUpdate(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
  public
    constructor Create(const AOwner: TComponent; const ALogin, APassword: string); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.SysUtils;

const
  MESSAGE_TYPE_ERROR: Cardinal = MB_OK + MB_ICONERROR + MB_DEFBUTTON1;

  ICON_LOGIN = 1;

resourcestring
  RsLoginForm = 'авторизации';
  RsHelpFileNonFound = 'Извините, справочный файл к данной программе не найден.';

procedure TLoginForm.actEnterExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TLoginForm.actCloseExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TLoginForm.actHelpExecute(Sender: TObject);
begin
  if (FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    MessageBox(Handle, PWideChar(RsHelpFileNonFound), PWideChar(Application.Title + ' - Предупреждение'),
      MESSAGE_TYPE_ERROR);
  end;
end;

procedure TLoginForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    actHelp.Enabled := b;
  end;
end;

constructor TLoginForm.Create(const AOwner: TComponent; const ALogin, APassword: string);
begin
  inherited Create(AOwner);
  ImageList.GetIcon(ICON_LOGIN, Icon);
end;

procedure TLoginForm.actEnterUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := edbxLogin.Text <> EmptyStr;
  if actEnter.Enabled <> b then
  begin
    actEnter.Enabled := b;
  end;
  if btnEnter.Default <> b then
  begin
    btnEnter.Default := b;
  end;
  if btnClose.Default <> (not b) then
  begin
    btnClose.Default := not b;
  end;
end;

end.
