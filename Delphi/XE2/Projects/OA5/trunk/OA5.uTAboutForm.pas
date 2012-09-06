unit OA5.uTAboutForm;

interface

uses
  CastersPackage.uTGSFileVersionInfo,
  CastersPackage.uTLogForm,
  Vcl.Forms,
  Vcl.ComCtrls,
  System.Classes,
  Vcl.ActnList,
  Vcl.ExtCtrls,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.Graphics;

type
  TAboutForm = class(TLogForm)
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
    procedure _Close;
  public
    constructor Create(AOwner: TComponent; const AShowCloseButton: Boolean; ABusyCounter: PInteger = nil;
      AIncrease: TBusyStateMethod = nil; ADecrease: TBusyStateMethod = nil; ARefresh: TBusyStateMethod = nil;
      AProgressBar: TProgressBar = nil); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.SysUtils,
  Winapi.ShellAPI;

resourcestring
  RsAboutForm = '"О программе..."';
  RsVersionInfo = 'Версия %d.%d Release %d Build %d';
  RsEMailClickEventHandlerProcedure = 'Процедура-обработчик щелчка по метке адреса электронной почты';

constructor TAboutForm.Create(AOwner: TComponent; const AShowCloseButton: Boolean; ABusyCounter: PInteger;
  AIncrease, ADecrease, ARefresh: TBusyStateMethod; AProgressBar: TProgressBar);
begin
  inherited Create(AOwner, ABusyCounter, AIncrease, ADecrease, ARefresh, AProgressBar);
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
  ProcedureHeader(Format(RsEventHandlerOfFormCreation, [RsAboutForm]), '{0B2B4443-33C8-44ED-8E91-C55FFCBB75E4}');
  ProcedureFooter;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsAboutForm]), '{BF30B1AE-7EA8-42ED-A2E1-6BB23BE961B3}');
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
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{D141CB7B-C326-4B85-BDFC-5F5107598AEA}');
  _Close;
  ProcedureFooter;
end;

procedure TAboutForm._Close;
begin
  ProcedureHeader(Format(RsCloseModalWithCancelProcedure, [RsAboutForm]), '{0C17F685-16BC-4D7F-B964-287B74A1CABF}');
  ModalResult := mrCancel;
  Log.SendInfo(Format(RsWindowClosedByUser, [RsAboutForm]));
  ProcedureFooter;
end;

procedure TAboutForm.CloseTimerTimer(Sender: TObject);
begin
  ProcedureHeader('Процедура закрытия окна по истечению счётчика таймера', '{1A3ED186-8181-467D-8491-E6C021EB2174}');
  _Close;
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
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:vlad_dracula@tut.by'), nil, nil, SW_MAXIMIZE);
  ProcedureFooter;
end;

end.
