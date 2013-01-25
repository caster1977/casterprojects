unit OA5.uTAboutForm;

interface

uses
  Vcl.ComCtrls,
  CastersPackage.uTRefreshBusyStateMethod,
  OA5.uTOA5LogForm,
  System.Classes,
  Vcl.ActnList,
  CastersPackage.uTGSFileVersionInfo,
  Vcl.ExtCtrls,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Graphics, System.Actions;

type
  TAboutForm = class(TOA5LogForm)
    GSFileVersionInfo: TGSFileVersionInfo;
    ActionList: TActionList;
    actClose: TAction;
    FadeTimer: TTimer;
    CloseTimer: TTimer;
    Shape: TShape;
    imgApplicationIcon: TImage;
    lblTitle: TLabel;
    lblVersion: TLabel;
    lblLegalCopyright: TLabel;
    lblEMail: TLabel;
    lblEMailAddress: TLabel;
    btnClose: TButton;
    procedure actCloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CloseTimerTimer(Sender: TObject);
    procedure FadeTimerTimer(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
  strict private
    FFirstShow: Boolean;
  public
    constructor Create(AOwner: TComponent; const AShowCloseButton: Boolean;
      ABusyCounter: PInteger = nil; ARefreshBusyStateMethod: TRefreshBusyStateMethod = nil;
      AProgressBar: TProgressBar = nil); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  Vcl.Forms,
  CastersPackage.uResourceStrings,
  Winapi.Windows,
  System.SysUtils,
  Winapi.ShellAPI;

resourcestring
  RsAboutForm = '"О программе..."';
  RsVersionInfo = 'Версия %d.%d Release %d Build %d';
  RsEMailClickEventHandlerProcedure =
    'Процедура-обработчик щелчка по метке адреса электронной почты';

constructor TAboutForm.Create(AOwner: TComponent; const AShowCloseButton: Boolean;
  ABusyCounter: PInteger; ARefreshBusyStateMethod: TRefreshBusyStateMethod;
  AProgressBar: TProgressBar);
begin
  inherited Create(AOwner, ABusyCounter, ARefreshBusyStateMethod, AProgressBar);
  FFirstShow := True;
  actClose.Visible := AShowCloseButton;
  GSFileVersionInfo.Filename := Application.ExeName;
  lblVersion.Caption := Format(RsVersionInfo, [GSFileVersionInfo.ModuleVersion.Major,
    GSFileVersionInfo.ModuleVersion.Minor, GSFileVersionInfo.ModuleVersion.Release,
    GSFileVersionInfo.ModuleVersion.Build]);
  lblLegalCopyright.Caption := GSFileVersionInfo.LegalCopyright;
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsAboutForm]),
    '{0B2B4443-33C8-44ED-8E91-C55FFCBB75E4}');
  ProcedureFooter;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsAboutForm]),
    '{BF30B1AE-7EA8-42ED-A2E1-6BB23BE961B3}');
  if FFirstShow then
  begin
    FFirstShow := False;
    if actClose.Visible then
    begin
      FadeTimer.Enabled := False;
      AlphaBlendValue := 222;
      CloseTimer.Enabled := False;
    end
    else
    begin
      FadeTimer.Enabled := True;
      AlphaBlendValue := 0;
      CloseTimer.Enabled := True;
    end;
    Log.SendInfo(Format(RsWindowShowed, [RsAboutForm]));
  end;
  ProcedureFooter;
end;

procedure TAboutForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]),
    '{D141CB7B-C326-4B85-BDFC-5F5107598AEA}');
  CloseModalWindowWithCancelResult(RsAboutForm, '{AB7A1A05-3D91-4D07-A810-625F107DC2CA}');
  ProcedureFooter;
end;

procedure TAboutForm.CloseTimerTimer(Sender: TObject);
begin
  ProcedureHeader('Процедура закрытия окна по истечению счётчика таймера',
    '{1A3ED186-8181-467D-8491-E6C021EB2174}');
  CloseModalWindowWithCancelResult(RsAboutForm, '{ADA7E65F-7D54-4E83-A06F-AA8DEE769379}');
  ProcedureFooter;
end;

procedure TAboutForm.FadeTimerTimer(Sender: TObject);
begin
  // Процедура реакции на срабатывание таймера, отвечающего за плавное увеличение прозрачности окна
  if ((AlphaBlendValue + 17) <= 222) then
  begin
    AlphaBlendValue := AlphaBlendValue + 17;
  end;
end;

procedure TAboutForm.lblEMailAddressClick(Sender: TObject);
begin
  ProcedureHeader(RsEMailClickEventHandlerProcedure, '{A2E28A1B-21CE-4B40-8CB7-944094FAB627}');
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:vlad_dracula@tut.by'), nil, nil,
    SW_MAXIMIZE);
  ProcedureFooter;
end;

end.
