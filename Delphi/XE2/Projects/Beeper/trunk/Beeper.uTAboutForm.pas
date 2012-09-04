unit Beeper.uTAboutForm;

interface

uses
  CastersPackage.Actions.Classes,
  CastersPackage.uTGSFileVersionInfo,
  Vcl.Forms,
  Vcl.ExtCtrls,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Graphics,
  System.Classes,
  Vcl.ActnList;

type
  TAboutForm = class(TForm)
    Shape1: TShape;
    Timer1: TTimer;
    Timer2: TTimer;
    lblEMail: TLabel;
    lblEMailAddress: TLabel;
    btnClose: TButton;
    lblLegalCopyright: TLabel;
    lblVersion: TLabel;
    imgApplicationIcon: TImage;
    lblTitle: TLabel;
    GSFileVersionInfo: TGSFileVersionInfo;
    ActionList: TActionList;
    actClose: TWindowCloseAction;
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent; const AShowCloseButton: boolean); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.SysUtils,
  Winapi.ShellAPI;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  if actClose.Visible then
  begin
    Timer1.Enabled := False;
    AlphaBlendValue := 222;
    Timer2.Enabled := False;
  end
  else
  begin
    Timer1.Enabled := True;
    AlphaBlendValue := 0;
    Timer2.Enabled := True;
  end;
  btnClose.Default := actClose.Visible;
  lblTitle.Caption := Application.Title;
  imgApplicationIcon.Picture.Icon.Assign(Application.Icon);
  lblVersion.Caption := Format('Версия %d.%d Release %d Build %d', [GSFileVersionInfo.ModuleVersion.Major,
    GSFileVersionInfo.ModuleVersion.Minor, GSFileVersionInfo.ModuleVersion.Release,
    GSFileVersionInfo.ModuleVersion.Build]);
  lblLegalCopyright.Caption := GSFileVersionInfo.LegalCopyright;
end;

constructor TAboutForm.Create(AOwner: TComponent; const AShowCloseButton: boolean);
begin
  inherited Create(AOwner);
  actClose.Visible := AShowCloseButton;
  GSFileVersionInfo.Filename := Application.ExeName;
end;

procedure TAboutForm.Timer1Timer(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TAboutForm.Timer2Timer(Sender: TObject);
begin
  if ((AlphaBlendValue + 17) <= 222) then
  begin
    AlphaBlendValue := AlphaBlendValue + 17;
  end;
end;

procedure TAboutForm.lblEMailAddressClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:vlad_dracula@tut.by'), nil, nil, SW_MAXIMIZE);
end;

end.
