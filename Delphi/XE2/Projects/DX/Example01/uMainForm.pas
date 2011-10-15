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

procedure DrawBMP(Handle: THandle); stdcall; external 'Example01_MyDll.dll';

procedure TMainForm.FormClick(Sender: TObject);
begin
  DrawBMP(Canvas.Handle);
end;

end.
