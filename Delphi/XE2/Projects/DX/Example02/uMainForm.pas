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
  Vcl.Dialogs;

type
  TMainForm=class(TForm)
    procedure FormClick(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

type
  TDrawBMP=procedure(Handle: THandle); stdcall;

procedure TMainForm.FormClick(Sender: TObject);
var
  hcDll: THandle; // Указатель на библиотеку
  procDrawBMP: TDrawBMP; // Подгружаемая функция
begin
  hcDll:=LoadLibrary('Example01_MyDll.dll'); // Динамическая загрузка DLL
  if hcDll<=HINSTANCE_ERROR then
    begin // Загрузка не удалась
      MessageDlg('Отсутствует библиотека Example01_MyDll.dll!', mtError, [mbOK], 0);
      Exit;
    end;
  // Библиотека загружена. Получаем адрес точки входа нужной функции
  procDrawBMP:=GetProcAddress(hCDll, 'DrawBMP');
  // проверка на успешность операции связывания
  if not Assigned(procDrawBMP) then
    begin
      MessageDlg('В библиотеке Example01_MyDll.dll отсутствует функция DrawBMP!', mtError, [mbOK], 0);
      Exit;
    end;
  procDrawBMP(Canvas.Handle); // Вызываем функцию
  FreeLibrary(hcDll); // Выгружаем библиотеку
end;

end.
