unit Beeper.uDataModule;

interface

uses
  System.SysUtils, System.Classes, Vcl.AppEvnts, Vcl.Menus, Vcl.ExtCtrls,
  Vcl.ImgList, Vcl.Controls, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnList,
  Vcl.ActnMan, CastersPackage.getFVI;

type
  TDataModule1 = class(TDataModule)
    PopupMenu: TPopupMenu;
    ActionManager: TActionManager;
    ImageListSmall: TImageList;
    TrayIcon: TTrayIcon;
    MainMenu: TMainMenu;
    ApplicationEvents: TApplicationEvents;
    ImageListLarge: TImageList;
    gsFileVersionInfo: TgsFileVersionInfo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
