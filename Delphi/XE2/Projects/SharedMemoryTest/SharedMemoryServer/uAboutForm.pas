unit uAboutForm;

interface

uses
  Forms,
  ActnList,
  ActnMan,
  ExtCtrls,
  getFVI,
  StdCtrls,
  Classes,
  PlatformDefaultStyleActnCtrls,
  Controls,
  Graphics;

type
  TAboutForm=class(TForm)
    Shape1: TShape;
    ActionManager1: TActionManager;
    Action_Close: TAction;
    Timer1: TTimer;
    Timer2: TTimer;
    lblEMail: TLabel;
    lblEMailAddress: TLabel;
    btnClose: TButton;
    lblLegalCopyright: TLabel;
    lblVersion: TLabel;
    imgApplicationIcon: TImage;
    lblTitle: TLabel;
    gsFileVersionInfo1: TgsFileVersionInfo;
    procedure Action_CloseExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
  strict private
    procedure Do_Close;
  end;

implementation

{$R *.dfm}

uses
  Winapi.Windows,
  System.SysUtils,
  Winapi.ShellAPI,
  uMainForm,
  uCommon;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  // процедура-обработчик события создания окна
  gsFileVersionInfo1.Filename:=Application.ExeName;
  Action_Close.Visible:=False;
end;

procedure TAboutForm.FormShow(Sender: TObject);
begin
  // процедура-обработчик события отображения окна
  if Action_Close.Visible then
    begin
      Timer1.Enabled:=False;
      AlphaBlendValue:=222;
      Timer2.Enabled:=False;
    end
  else
    begin
      Timer1.Enabled:=True;
      AlphaBlendValue:=0;
      Timer2.Enabled:=True;
    end;
  btnClose.Default:=Action_Close.Visible;
  lblVersion.Caption:=Format(TEXT_APPLICATION_VERSION, [gsFileVersionInfo1.ModuleVersion.Major, gsFileVersionInfo1.ModuleVersion.Minor, gsFileVersionInfo1.ModuleVersion.Release, gsFileVersionInfo1.ModuleVersion.Build]);
  lblLegalCopyright.Caption:=gsFileVersionInfo1.LegalCopyright;
  MainForm.LogInfo(Format(TEXT_WINDOW_SHOWED, [TEXT_ABOUTFORM_SUFFIX]));
end;

procedure TAboutForm.Action_CloseExecute(Sender: TObject);
begin
  // процедура-обработчик действия Action_Close
  Do_Close;
end;

procedure TAboutForm.Do_Close;
begin
  // процедура закрытия модального окна с результатом mrClose
  ModalResult:=mrClose;
  MainForm.LogInfo(Format(TEXT_WINDOW_CLOSED, [TEXT_ABOUTFORM_SUFFIX]));
end;

procedure TAboutForm.Timer1Timer(Sender: TObject);
begin
  // процедура закрытия окна по истечению счётчика таймера
  Do_Close;
end;

procedure TAboutForm.Timer2Timer(Sender: TObject);
begin
  // процедура реакции на срабатывание таймера, отвечающего за плавное увеличение прозрачности окна
  if ((AlphaBlendValue+17)<=222) then
    AlphaBlendValue:=AlphaBlendValue+17;
end;

procedure TAboutForm.lblEMailAddressClick(Sender: TObject);
begin
  // процедура-обработчик щелчка по метке адреса электронной почты
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:caster@mgts.by'), nil, nil, SW_MAXIMIZE);
end;

end.
