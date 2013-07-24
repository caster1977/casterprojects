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
  DirectDraw;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    // FDD: IDirectDraw;
    FDD7: IDirectDraw7;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  hRet: HRESULT; // Вспомогательная переменная
begin
  {
    // Создание главного объекта DirectDraw
    FDD:=nil; // Это обязательно для повышения надежности работы
    FDD7:=nil; // Это обязательно для повышения надежности работы
    hRet:=DirectDrawCreate(nil, FDD, nil);
    if Failed(hRet) then // Проверка успешности предыдущего действия
    ShowMessage('Ошибка при выполнении DirectDrawCreate') // Поддерживается ли интерфейс 7-й версии DirectX
    else
    hRet:=FDD.QueryInterface(IID_IDirectDraw7, FDD7);
    if Failed(hRet) then // Или один из двух, или оба интерфейса не получены
    ShowMessage('DirectX 7-й версии не доступен')
    else
    ShowMessage('DirectX 7-й версии доступен');
    // Освобождение памяти, занятой объектами if Assigned (FDD7) then FDD7 := nil;
    if Assigned(FDD7) then
    FDD7:=nil;
    if Assigned(FDD) then
    FDD:=nil;
  }
  FDD7 := nil; // Это обязательно для повышения надежности работы
  try // Включаем защищенный режим
    try // ... finally
      // Создание главного объекта DirectDraw
      hRet := DirectDrawCreateEx(nil, FDD7, IDirectDraw7, nil);
      if Failed(hRet) // Вслучае ошибки наверняка сюда не доберемся
      then
        ShowMessage('DirectX 7-й версии не доступен')
      else
        ShowMessage('DirectX 7-й версии доступен');
    finally // Влюбом случае производим освобождение памяти
      if Assigned(FDD7) then
        FDD7 := nil;
    end;
  except // Вслучае ошибки информируем о неудаче
    ShowMessage('DirectX 7-й версии не доступен')
  end;
end;

end.
