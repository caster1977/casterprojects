unit CastersPackage.uTEnterStringForm;

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
  Vcl.Graphics,
  Vcl.Forms;

type
  TEnterStringForm = class(TForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actHelp: TAction;
    actApply: TAction;
    actClose: TAction;
    pnlButtons: TPanel;
    btnHelp: TButton;
    btnApply: TButton;
    btnClose: TButton;
    lblValue: TLabel;
    edtValue: TEdit;
    procedure actApplyExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure actApplyUpdate(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  strict private
    function GetValue: string;
  public
    property Value: string read GetValue nodefault;

  public
    constructor Create(const AOwner: TComponent; const ACaption, ATitle: string;
      const AValue: string = ''; const AIcon: TIcon = nil; const AMaxLength: Integer = 0;
      const ANumeric: Boolean = False; const AShowHelpButton: Boolean = False);
      reintroduce; virtual;
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
  RsHelpFileNonFound = 'Извините, справочный файл к данной программе не найден.';
  RsWarning = '%s - Предупреждение';

procedure SetNumbersOnly(const AHandle: HWND);
begin
  SetWindowLong(AHandle, GWL_STYLE, GetWindowLong(AHandle, GWL_STYLE) or ES_NUMBER);
end;

procedure TEnterStringForm.actApplyExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TEnterStringForm.actCloseExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TEnterStringForm.actHelpExecute(Sender: TObject);
begin
  if FileExists(ExpandFileName(Application.HelpFile)) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    MessageBox(Handle, PWideChar(RsHelpFileNonFound),
      PWideChar(Format(RsWarning, [Application.Title])), MESSAGE_TYPE_ERROR);
  end;
end;

procedure TEnterStringForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Trim(Application.HelpFile) > EmptyStr;
  if actHelp.Enabled <> b then
  begin
    actHelp.Enabled := b;
  end;
end;

constructor TEnterStringForm.Create(const AOwner: TComponent;
  const ACaption, ATitle, AValue: string; const AIcon: TIcon; const AMaxLength: Integer;
  const ANumeric: Boolean; const AShowHelpButton: Boolean);
var
  s: string;
begin
  inherited Create(AOwner);
  Caption := Trim(ACaption);
  lblValue.Caption := Trim(ATitle);
  if ANumeric then
  begin
    SetNumbersOnly(edtValue.Handle);
  end;
  edtValue.MaxLength := AMaxLength;

  actHelp.Visible := AShowHelpButton;

  s := Trim(ACaption);
  edtValue.Text := Trim(AValue);

  if Assigned(AIcon) then
  begin
    if AIcon.Handle > 0 then
    begin
      Icon := AIcon;
    end
    else
    begin
      ImageList.GetIcon(ICON_LOGIN, Icon);
    end;
  end
  else
  begin
    ImageList.GetIcon(ICON_LOGIN, Icon);
  end;
end;

procedure TEnterStringForm.FormActivate(Sender: TObject);
begin
  try
    edtValue.SetFocus;
  except
  end;
end;

function TEnterStringForm.GetValue: string;
begin
  Result := Trim(edtValue.Text);
end;

procedure TEnterStringForm.actApplyUpdate(Sender: TObject);
var
  b: Boolean;
begin
  inherited;
  b := Length(Value) > 0;
  if actApply.Enabled <> b then
  begin
    actApply.Enabled := b;
  end;
  if btnApply.Default <> b then
  begin
    btnApply.Default := b;
  end;
  if btnClose.Default <> (not b) then
  begin
    btnClose.Default := not b;
  end;
end;

end.
