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
  hcDll: THandle; // ��������� �� ����������
  procDrawBMP: TDrawBMP; // ������������ �������
begin
  hcDll:=LoadLibrary('Example01_MyDll.dll'); // ������������ �������� DLL
  if hcDll<=HINSTANCE_ERROR then
    begin // �������� �� �������
      MessageDlg('����������� ���������� Example01_MyDll.dll!', mtError, [mbOK], 0);
      Exit;
    end;
  // ���������� ���������. �������� ����� ����� ����� ������ �������
  procDrawBMP:=GetProcAddress(hCDll, 'DrawBMP');
  // �������� �� ���������� �������� ����������
  if not Assigned(procDrawBMP) then
    begin
      MessageDlg('� ���������� Example01_MyDll.dll ����������� ������� DrawBMP!', mtError, [mbOK], 0);
      Exit;
    end;
  procDrawBMP(Canvas.Handle); // �������� �������
  FreeLibrary(hcDll); // ��������� ����������
end;

end.
