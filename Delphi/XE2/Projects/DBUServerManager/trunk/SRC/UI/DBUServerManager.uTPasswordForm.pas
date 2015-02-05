unit DBUServerManager.uTPasswordForm;

interface

uses
  DBUShared.uIUsers,
  DBUShared.uIUser,
  CastersPackage.uICustomized,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ImgList,
  CastersPackage.Actions.Classes,
  Vcl.StdActns,
  System.Actions,
  Vcl.ActnList,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

const
  DEFAULT_PASSWORD = '';
  DEFAULT_SHOW_SYMBOLS = False;

type
  TPasswordForm = class(TForm, ICustomized)
    ImageList: TImageList;
    ActionList: TActionList;
    actGeneratePassword: TAction;
    actShowSymbols: TAction;
    actApply: TAction;
    actCancel: TAction;
    actDefaults: TAction_Defaults;
    actHelp: TAction_Help;
    grpMain: TGroupBox;
    ledPassword: TLabeledEdit;
    ledConfirmation: TLabeledEdit;
    chkShowSymbols: TCheckBox;
    btnGeneratePassword: TButton;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    btnDefaults: TButton;
    btnHelp: TButton;
    procedure actApplyExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actShowSymbolsExecute(Sender: TObject);
    procedure actGeneratePasswordExecute(Sender: TObject);
    procedure ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure actApplyUpdate(Sender: TObject);
    procedure actDefaultsExecute(Sender: TObject);
    procedure actDefaultsUpdate(Sender: TObject);

  strict protected
    procedure Finalize; virtual;
    procedure Initialize; virtual;
  protected
    constructor Create(AOwner: TComponent); override; final;
  public
    destructor Destroy; override; final;

  strict private
    function GetPassword: string;
    procedure SetPassword(const AValue: string);
    property Password: string read GetPassword write SetPassword nodefault;

  strict private
    function GetConfirmation: string;
    procedure SetConfirmation(const AValue: string);
    property Confirmation: string read GetConfirmation write SetConfirmation nodefault;

  strict private
    function GetShowSymbols: Boolean;
    procedure SetShowSymbols(const AValue: Boolean);
    property ShowSymbols: Boolean read GetShowSymbols write SetShowSymbols default DEFAULT_SHOW_SYMBOLS;

  strict private
    function GetPasswordHash: string;
  private
    property PasswordHash: string read GetPasswordHash nodefault;
  end;

function ShowPasswordForm(const AOwner: TComponent; out APasswordHash: string): Boolean;

exports ShowPasswordForm;

implementation

{$R *.dfm}

uses
  System.StrUtils,
  System.Math,
  CastersPackage.uRoutines;

resourcestring
  RsAOwnerIsNil = 'AOwner is nil.';

function ShowPasswordForm(const AOwner: TComponent; out APasswordHash: string): Boolean;
var
  form: TPasswordForm;
begin
  Assert(Assigned(AOwner), RsAOwnerIsNil);

  Result := False;
  try
    form := TPasswordForm.Create(AOwner);
    try
      Result := form.ShowModal = mrOk;
      if Result then
      begin
        APasswordHash := form.PasswordHash;
      end;
    finally
      form.Free;
    end;
  except
  end;
end;

procedure TPasswordForm.actApplyExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TPasswordForm.Initialize;
begin
  Password := DEFAULT_PASSWORD;
  Confirmation := DEFAULT_PASSWORD;
  ShowSymbols := DEFAULT_SHOW_SYMBOLS;
end;

constructor TPasswordForm.Create(AOwner: TComponent);
begin
  inherited;
  Initialize;
end;

destructor TPasswordForm.Destroy;
begin
  Finalize;
  inherited;
end;

procedure TPasswordForm.Finalize;
begin
end;

procedure TPasswordForm.actApplyUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (Length(Password) > 0) and ((Password = Confirmation) or ShowSymbols);
end;

procedure TPasswordForm.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TPasswordForm.actDefaultsExecute(Sender: TObject);
begin
  Initialize;
end;

procedure TPasswordForm.actDefaultsUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := (Password <> DEFAULT_PASSWORD) or (Confirmation <> DEFAULT_PASSWORD) or (ShowSymbols <> DEFAULT_SHOW_SYMBOLS);
end;

procedure TPasswordForm.actGeneratePasswordExecute(Sender: TObject);
begin
  ShowSymbols := True;
  Password := Routines.GeneratePassword;
end;

procedure TPasswordForm.ActionListUpdate(Action: TBasicAction; var Handled: Boolean);
begin
  ledPassword.PasswordChar := (IfThen(actShowSymbols.Checked, #0, '*'))[1];
  ledConfirmation.Enabled := not actShowSymbols.Checked;
  if not ledConfirmation.Enabled then
  begin
    ledConfirmation.Clear;
  end;
end;

procedure TPasswordForm.actShowSymbolsExecute(Sender: TObject);
begin
  // заглушка
end;

function TPasswordForm.GetPassword: string;
begin
  Result := Trim(ledPassword.Text);
end;

function TPasswordForm.GetConfirmation: string;
begin
  Result := Trim(ledConfirmation.Text);
end;

function TPasswordForm.GetShowSymbols: Boolean;
begin
  Result := actShowSymbols.Checked;
end;

function TPasswordForm.GetPasswordHash: string;
begin
  Result := Routines.Hash(Password);
end;

procedure TPasswordForm.SetPassword(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if ledPassword.Text <> s then
  begin
    ledPassword.Text := s;
  end;
end;

procedure TPasswordForm.SetConfirmation(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if ledConfirmation.Text <> s then
  begin
    ledConfirmation.Text := s;
  end;
end;

procedure TPasswordForm.SetShowSymbols(const AValue: Boolean);
begin
  if actShowSymbols.Checked <> AValue then
  begin
    actShowSymbols.Checked := AValue;
  end;
end;

end.
