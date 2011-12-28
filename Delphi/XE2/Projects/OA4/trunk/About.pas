unit About;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  ShellAPI,
  getFVI,
  ActnList,
  PlatformDefaultStyleActnCtrls,
  ActnMan,
  jpeg;

type
  TAboutForm= class(TForm)
    Timer1: TTimer;
    Shape1: TShape;
    Image1: TImage;
    Label1: TLabel;
    lblVersion: TLabel;
    lblLegalCopyright: TLabel;
    lblEMailAddress: TLabel;
    btnClose: TButton;
    Timer2: TTimer;
    Label4: TLabel;
    gsFileVersionInfo1: TgsFileVersionInfo;
    ActionManager1: TActionManager;
    Action_Close: TAction;
    procedure Timer2Timer(Sender: TObject);
    procedure lblEMailAddressClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
  private
    procedure Do_Close;
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

uses
  Main;

procedure TAboutForm.FormCreate(Sender: TObject);
const
  LogGroupGUID: string='{B04ADB19-4F96-4D7B-A9B7-FC2B891323FF}';
begin
  // ProcedureHeader('Процедура-обработчик события создания окна', LogGroupGUID, False, False);
  Action_Close.Visible:=False;
  // ProcedureFooter(LogGroupGUID, False, False);
end;

procedure TAboutForm.FormShow(Sender: TObject);
const
  LogGroupGUID: string='{73556280-CF79-4830-B748-12EE211E0EA8}';
begin
  // ProcedureHeader('Процедура-обработчик события отображения окна', LogGroupGUID, False, False);
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
  btnClose.default:=Action_Close.Visible;
  lblVersion.Caption:=Format('Версия %d.%d Release %d Build %d', [gsFileVersionInfo1.ModuleVersion.Major, gsFileVersionInfo1.ModuleVersion.Minor, gsFileVersionInfo1.ModuleVersion.Release, gsFileVersionInfo1.ModuleVersion.Build]);
  lblLegalCopyright.Caption:=gsFileVersionInfo1.LegalCopyright;
  // LogThis('Отображено окно "О программе...".', LogGroupGUID, lmtInfo);
  // ProcedureFooter(LogGroupGUID, False, False);
end;

procedure TAboutForm.Action_CloseExecute(Sender: TObject);
const
  LogGroupGUID: string='{AA6E4A00-7399-4CAF-9240-44FE392DB672}';
begin
  // ProcedureHeader('Процедура-обработчик действия "'+Action_Close.Caption+'"', LogGroupGUID, True, True);
  Do_Close;
  // ProcedureFooter(LogGroupGUID, True, True);
end;

procedure TAboutForm.Do_Close;
const
  LogGroupGUID: string='{B11F94C8-0546-49F8-B202-5B55B3245C29}';
begin
  // ProcedureHeader('Процедура закрытия модального окна с результатом mrClose', LogGroupGUID, False, False);
  ModalResult:=mrClose;
  // ProcedureFooter(LogGroupGUID, False, False);
end;

procedure TAboutForm.lblEMailAddressClick(Sender: TObject);
const
  LogGroupGUID: string='{F2BC7A05-00DD-4BCA-83B9-1E0F2559B317}';
begin
  // ProcedureHeader('Процедура-обработчик щелчка по метке адреса электронной почты', LogGroupGUID, True, True);
  ShellExecute(Application.Handle, 'open', PWideChar('mailto:vlad_dracula@tut.by'), nil, nil, SW_MAXIMIZE);
  // ProcedureFooter(LogGroupGUID, True, True);
end;

procedure TAboutForm.Timer1Timer(Sender: TObject);
const
  LogGroupGUID: string='{2DD24AB4-DA29-4F7D-99D7-EFC39F4951B0}';
begin
  // ProcedureHeader('Процедура закрытия окна по истечению счётчика таймера', LogGroupGUID, False, False);
  Do_Close;
  // ProcedureFooter(LogGroupGUID, False, False);
end;

procedure TAboutForm.Timer2Timer(Sender: TObject);
const
  LogGroupGUID: string='{E0E4BE66-AEE0-4FDB-9158-E7DA00D479A4}';
begin
  // ProcedureHeader('Процедура реакции на срабатывание таймера, отвечающего за плавное увеличение прозрачности окна', LogGroupGUID, False, False);
  if ((AlphaBlendValue+17)<=222) then
    AlphaBlendValue:=AlphaBlendValue+17;
  // ProcedureFooter(LogGroupGUID, False, False);
end;

end.
