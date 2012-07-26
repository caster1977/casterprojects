unit CastersPackage.Actions.DataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.ActnList,
  CastersPackage.Actions.Classes, Vcl.StdActns;

type
  TActionsDataModule = class(TDataModule)
    ActionList: TActionList;
    Action_Help: TAction_Help;
    Action_Apply: TAction_Apply;
    Action_Defaults: TAction_Defaults;
    Action_PreviousPage: TAction_PreviousPage;
    Action_NextPage: TAction_NextPage;
    Action_Restore: TAction_Restore;
    Action_About: TAction_About;
    Action_Configuration: TAction_Configuration;
    Action_Logon: TAction_Logon;
    Action_Logoff: TAction_Logoff;
    Action_Accounts: TAction_Accounts;
    Action_Report: TAction_Report;
    ImageListLarge: TImageList;
    ImageListSmall1: TImageList;
    ImageListSmall2: TImageList;
    QuitAction: TQuitAction;
    WindowCloseAction: TWindowCloseAction;
    FileMenuGroupAction: TFileMenuGroupAction;
    HelpMenuGroupAction: THelpMenuGroupAction;
    HelpContentsAction: THelpContentsAction;
    ActionMenuGroupAction: TActionMenuGroupAction;
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
