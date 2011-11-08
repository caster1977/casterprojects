unit uMainForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ActnList,
  Vcl.Menus,
  Vcl.ImgList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.ComCtrls,
  Vcl.StdCtrls;

type
  TMainForm=class(TForm)
    MainMenu1: TMainMenu;
    ActionManager1: TActionManager;
    ImageList1: TImageList;
    Action_Quit: TAction;
    Action_About: TAction;
    Action_Configuration: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    StatusBar1: TStatusBar;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
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

procedure TMainForm.FormCreate(Sender: TObject);
//var
//  ffile: THandle;
//  ffileMapObj: THandle;
//  lpBaseAdd: PChar;
//  str: string;
begin
//  // ffile := CreateFile('C:\ffile.txt', GENERIC_ALL, FILE_SHARE_WRITE, nil, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);
//  ffile:=CreateFile('ffile.txt', GENERIC_ALL, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
//  if (ffile=INVALID_HANDLE_VALUE) then
//    ShowMessage('C:\pzdc!');
//  Edit1.Text:=IntToStr(ffile);
//  Edit2.Text:=IntToStr(DWORD(-1)); // посмотрел код ошибки
//  ffileMapObj:=CreateFileMapping(ffile, // Ссылка на файл
//    nil, // указатель на запись типа TSecurityAttributes
//    PAGE_READWRITE, // способ совместного использования создаваемого объекта
//    0, // старший разряд 64-битного значения размера выделяемого объема памяти для совместного доступа
//    1, // размер файла подкачки
//    'MySharedValue' // имя объекта файлового отображения
//    );
//  if (ffileMapObj<>0) then
//    ShowMessage('Операция создания Swap-файла удалась');
//  lpBaseAdd:=MapViewOfFile(ffileMapObj, FILE_MAP_WRITE, 0, 0, 0);
//  if (lpBaseAdd=nil) then
//    ShowMessage('Не могу подключить FileMapping!');
//  SetLength(Str, 12);
//  CopyMemory(Pointer(Str), lbBaseAdd, 12);
//  Memo1.Lines.Add(str); // по идее тут я в мемо должен получить кусок своего текстового файла
  // этого не происходит
end;

end.
