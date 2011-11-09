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
    procedure FormShow(Sender: TObject);
  strict private
    USER_WM_READDATA, USER_WM_WRITEDATA, USER_WM_DONE: cardinal;
    function Do_RegisterWindowMessages: boolean;
  protected
    procedure WndProc(var Message: TMessage); override;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uCommon;

procedure TMainForm.FormCreate(Sender: TObject);
// var
// ffile: THandle;
// ffileMapObj: THandle;
// lpBaseAdd: PChar;
// str: string;
begin
  // // ffile := CreateFile('C:\ffile.txt', GENERIC_ALL, FILE_SHARE_WRITE, nil, CREATE_NEW, FILE_ATTRIBUTE_NORMAL, 0);
  // ffile:=CreateFile('ffile.txt', GENERIC_ALL, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  // if (ffile=INVALID_HANDLE_VALUE) then
  // ShowMessage('C:\pzdc!');
  // Edit1.Text:=IntToStr(ffile);
  // Edit2.Text:=IntToStr(DWORD(-1)); // посмотрел код ошибки
  // ffileMapObj:=CreateFileMapping(ffile, // Ссылка на файл
  // nil, // указатель на запись типа TSecurityAttributes
  // PAGE_READWRITE, // способ совместного использования создаваемого объекта
  // 0, // старший разряд 64-битного значения размера выделяемого объема памяти для совместного доступа
  // 1, // размер файла подкачки
  // 'MySharedValue' // имя объекта файлового отображения
  // );
  // if (ffileMapObj<>0) then
  // ShowMessage('Операция создания Swap-файла удалась');
  // lpBaseAdd:=MapViewOfFile(ffileMapObj, FILE_MAP_WRITE, 0, 0, 0);
  // if (lpBaseAdd=nil) then
  // ShowMessage('Не могу подключить FileMapping!');
  // SetLength(Str, 12);
  // CopyMemory(Pointer(Str), lbBaseAdd, 12);
  // Memo1.Lines.Add(str); // по идее тут я в мемо должен получить кусок своего текстового файла
  // этого не происходит
end;

procedure TMainForm.FormShow(Sender: TObject);
begin
  if Do_RegisterWindowMessages then;
end;

function TMainForm.Do_RegisterWindowMessages: boolean;
resourcestring
  RegisterWindowErrorMessage='Не удалось выполнить операцию регистрации оконного сообщения! Код ошибки: ';
begin
  try
    USER_WM_READDATA:=RegisterWindowMessage(PWideChar(TEXT_READDATA));
    if USER_WM_READDATA=0 then
      raise Exception.Create(RegisterWindowErrorMessage+IntToStr(GetLastError));
    USER_WM_WRITEDATA:=RegisterWindowMessage(PWideChar(TEXT_WRITEDATA));
    if USER_WM_WRITEDATA=0 then
      raise Exception.Create(RegisterWindowErrorMessage+IntToStr(GetLastError));
    USER_WM_DONE:=RegisterWindowMessage(PWideChar(TEXT_DONE));
    if USER_WM_DONE=0 then
      raise Exception.Create(RegisterWindowErrorMessage+IntToStr(GetLastError));
  except
    on E: Exception do
      MessageBox(Handle, PWideChar(E.Message), PWideChar(Caption+' - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  end;
end;

procedure TMainForm.WndProc(var Message: TMessage);
var
  lpData: Pointer;
  lLineSize, ltemp: Integer;
  lpBuffer: array of Byte;
begin
  inherited;
  if message.Msg=USER_WM_READDATA then;
  if message.Msg=USER_WM_WRITEDATA then;
  if message.Msg=USER_WM_DONE then;
end;

{
  try
  if message.Msg=FtWM_CLIENT_WRITE then
  begin
  isListened:=True;
  LogFile.Add(llTRACE, TEXT_WM_SERVER_READ);
  lpData:=MapViewOfFile(FhSharedMemory, FILE_MAP_READ, 0, 0, BlockSize);
  if lpData=nil then
  begin
  Exit;
  RaiseLastOSError;
  end;
  lLineSize:=message.WParam;
  LogFile.Add(llTRACE, TEXT_WRITE_SIZE_OF_INPUT+IntToStr(lLineSize));
  SetLength(lpBuffer, lLineSize);
  LogFile.Add(llTRACE, TEXT_READ_DATA_SHARED_MEMORY);
  CopyMemory(@lpBuffer[0], Pointer(Integer(lpData)+4), lLineSize);
  LogFile.Add(llTRACE, TEXT_SERVER_READ_BEG);
  BlockWrite(FFile, lpBuffer, lLineSize, ltemp);
  LogFile.Add(llTRACE, TEXT_SERVER_READ_END);
  UnmapViewOfFile(lpData);
  LogFile.Add(llTRACE, TEXT_SLEEP+FloatToStr(TransferFileTimeInterval/1000)+TEXT_SECOND);
  Sleep(TransferFileTimeInterval);
  LogFile.Add(llTRACE, TEXT_WM_SERVER_POST);
  PostMessage(HWND_BROADCAST, FtWM_SERVER_READ, 0, 0);
  end;
  if message.Msg=FtWM_EOF then
  begin
  CloseFile(FFile);
  LogFile.Add(llINFO, TEXT_FILE_TRANSFERAD);
  end;
  except
  on e: Exception do
  begin
  LogFile.Add(llERROR, TEXT_ERROR_PREFIX+e.Message);
  end;
  end;
}
end.
