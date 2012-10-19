unit Beeper.uTAboutForm;

interface

uses
  Vcl.Forms,
  Vcl.ActnList,
  System.Classes,
  CastersPackage.Actions.Classes,
  CastersPackage.uTGSFileVersionInfo,
  Vcl.ExtCtrls,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Graphics;

type
  TAboutForm = class(TForm)
    GSFileVersionInfo: TGSFileVersionInfo;
    ActionList: TActionList;
    actClose: TWindowCloseAction;
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
    procedure FormShow(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FadeTimerTimer(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
  strict protected
    FFirstShow: Boolean;
  public
    constructor Create(AOwner: TComponent; const AShowCloseButton: Boolean); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.SysUtils,
  Winapi.ShellAPI;

resourcestring
  RsVersionInfo = 'Версия %d.%d Release %d Build %d';

constructor TAboutForm.Create(AOwner: TComponent; const AShowCloseButton: Boolean);
begin
  inherited Create(AOwner);
  FFirstShow := True;
  actClose.Visible := AShowCloseButton;
  GSFileVersionInfo.Filename := Application.ExeName;
  lblTitle.Caption := Application.Title;
  imgApplicationIcon.Picture.Icon.Assign(Application.Icon);
  lblVersion.Caption := Format(RsVersionInfo, [GSFileVersionInfo.ModuleVersion.Major, GSFileVersionInfo.ModuleVersion.Minor, GSFileVersionInfo.ModuleVersion.Release,
    GSFileVersionInfo.ModuleVersion.Build]);
  lblLegalCopyright.Caption := GSFileVersionInfo.LegalCopyright;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  if FFirstShow then
  begin
    FFirstShow := False;
    if actClose.Visible then
    begin
      CloseTimer.Enabled := False;
      AlphaBlendValue := 222;
      FadeTimer.Enabled := False;
    end
    else
    begin
      CloseTimer.Enabled := True;
      AlphaBlendValue := 0;
      FadeTimer.Enabled := True;
    end;
  end;
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
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:vlad_dracula@tut.by'), nil, nil, SW_MAXIMIZE);
end;

end.
