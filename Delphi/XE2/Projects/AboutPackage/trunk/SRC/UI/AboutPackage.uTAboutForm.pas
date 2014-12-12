unit AboutPackage.uTAboutForm;

interface

uses
  Vcl.Forms,
  Vcl.ActnList,
  System.Classes,
  AboutPackage.uTGSFileVersionInfo,
  Vcl.ExtCtrls,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Graphics,
  System.Actions;

type
  TAboutForm = class(TForm)
    ActionList: TActionList;
    CloseTimer: TTimer;
    FadeTimer: TTimer;
    Shape: TShape;
    imgApplicationIcon: TImage;
    lblTitle: TLabel;
    lblVersion: TLabel;
    lblLegalCopyright: TLabel;
    lblEMail: TLabel;
    lblEMailAddress: TLabel;
    btnClose: TButton;
    GSFileVersionInfo: TGSFileVersionInfo;
    actClose: TAction;
    procedure FormShow(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FadeTimerTimer(Sender: TObject);
    procedure actCloseUpdate(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);

  strict private
    FSplash: Boolean;
    function GetSplash: Boolean;
    property Splash: Boolean read GetSplash nodefault;

  strict private
    FEMail: string;
    function GetEMail: string;
    property EMail: string read GetEMail nodefault;

  public
    constructor Create(const AOwner: TComponent; const ASplash: Boolean; const AEMail: string); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.SysUtils,
  Winapi.ShellAPI;

resourcestring
  RsVersionInfo = 'Версия %d.%d Release %d Build %d';
  RsCaption = 'О программе "%s"';

constructor TAboutForm.Create(const AOwner: TComponent; const ASplash: Boolean; const AEMail: string);
var
  s: string;
begin
  inherited Create(AOwner);
  FSplash := ASplash;
  FEMail := AEMail;
  actClose.Visible := not Splash;
  if not(csDesigning in ComponentState) then
  begin
    GSFileVersionInfo.Filename := Application.ExeName;
    s := GSFileVersionInfo.InternalName;
    Caption := Format(RsCaption, [s]);
    lblTitle.Caption := s;
    imgApplicationIcon.Picture.Icon.Assign(Application.Icon);
    lblVersion.Caption := Format(RsVersionInfo, [GSFileVersionInfo.ModuleVersion.Major,
      GSFileVersionInfo.ModuleVersion.Minor, GSFileVersionInfo.ModuleVersion.Release,
      GSFileVersionInfo.ModuleVersion.Build]);
    lblLegalCopyright.Caption := GSFileVersionInfo.LegalCopyright;
  end;
  lblEMailAddress.Caption := EMail;
  lblEMail.Left := (Width - (lblEMail.Width + 6 + lblEMailAddress.Width)) div 2;
  lblEMailAddress.Left := lblEMail.Left + lblEMail.Width + 6;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  if Splash then
  begin
    CloseTimer.Enabled := True;
    AlphaBlendValue := 0;
    FadeTimer.Enabled := True;
  end
  else
  begin
    CloseTimer.Enabled := False;
    AlphaBlendValue := 222;
    FadeTimer.Enabled := False;
  end;
end;

function TAboutForm.GetEMail: string;
begin
  Result := FEMail;
end;

function TAboutForm.GetSplash: Boolean;
begin
  Result := FSplash;
end;

procedure TAboutForm.actCloseExecute(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TAboutForm.actCloseUpdate(Sender: TObject);
begin
  actClose.Visible := not Splash;
end;

procedure TAboutForm.CloseTimerTimer(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TAboutForm.FadeTimerTimer(Sender: TObject);
begin
  if ((AlphaBlendValue + 17) <= 222) then
  begin
    AlphaBlendValue := AlphaBlendValue + 17;
  end;
end;

procedure TAboutForm.lblEMailAddressClick(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:' + EMail), nil, nil, SW_MAXIMIZE);
end;

end.
