unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, PlatformDefaultStyleActnCtrls, ActnList, ActnMan,
  ImgList;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    StatusBar1: TStatusBar;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ActionManager1: TActionManager;
    Action_Quit: TAction;
    Action_About: TAction;
    Action_Help: TAction;
    Action_Configuration: TAction;
    Action_Accounts: TAction;
    Action_Reports: TAction;
    Action_Logon: TAction;
    Action_Logout: TAction;
    N5: TMenuItem;
    N6: TMenuItem;
    O1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    miStatusBar: TMenuItem;
    ilSmallImages: TImageList;
    ilBigImages: TImageList;
    procedure Action_QuitExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.Action_QuitExecute(Sender: TObject);
const
  LogGroupGUID: string='{3EB0BDC1-4DB7-44CF-AAE6-5303BB2B41D4}';
begin
//  ProcedureHeader('Процедура-обработчик действия "'+Action_Quit.Caption+'"', LogGroupGUID);
  Close;
//  ProcedureFooter(LogGroupGUID);
end;

end.
