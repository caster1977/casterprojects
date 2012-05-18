unit Beeper.uDataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.AppEvnts,
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnList,
  Vcl.ActnMan,
  CastersPackage.getFVI,
  CastersPackage.Actions.Classes,
  Vcl.StdActns;

type
  TDataModule1 = class(TDataModule)
    PopupMenu: TPopupMenu;
    ImageListSmall: TImageList;
    TrayIcon: TTrayIcon;
    MainMenu: TMainMenu;
    ApplicationEvents: TApplicationEvents;
    ImageListLarge: TImageList;
    ActionManager1: TActionManager;
    procedure TrayIconClick(Sender: TObject);
  end;

var
  DataModule1: TDataModule1;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

uses
  VCL.Forms,
  Winapi.Windows,
  Beeper.uMainForm;

procedure TDataModule1.TrayIconClick(Sender: TObject);
begin
  if Assigned(Application.MainForm) then
    if Application.MainForm.Visible then
      SetForegroundWindow(Application.MainForm.Handle);
end;

end.
