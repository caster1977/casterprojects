unit uMainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Menus, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ImgList;

type
  TMainForm = class(TForm)
    ImageList1: TImageList;
    ActionManager1: TActionManager;
    Action_Quit: TAction;
    Action_About: TAction;
    Action_Configuration: TAction;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    StatusBar1: TStatusBar;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

const
  MUTEX_REQUEST_TIMEOUT=1000;

var
  HMapMutex: THandle;

function LockMap: Boolean;
begin
  Result:=True;
  HMapMutex:=CreateMutex(nil, False, PWideChar('SharedMemoryMutex'));
  if HMapMutex=0 then
    begin
      ShowMessage('Не могу создать мьютекс');
      Result:=False;
    end
  else
    if WaitForSingleObject(HMapMutex, MUTEX_REQUEST_TIMEOUT)=WAIT_FAILED then
      begin
        ShowMessage('Невозможно заблокировать объект отображения файла');
        Result:=False;
      end;
end;

procedure UnlockMap;
begin
  ReleaseMutex(HMapMutex);
  CloseHandle(HMapMutex);
end;

end.
