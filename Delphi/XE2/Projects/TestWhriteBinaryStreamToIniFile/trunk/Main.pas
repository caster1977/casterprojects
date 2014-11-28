unit Main;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  IniFiles;

type
  TMainForm= class(TForm)
    procedure FormCreate(Sender: TObject);
  end;

  ba= array [0..399] of byte;

var
  graf: array [0..0] of ba;
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  b: TMemoryStream;
  i: integer;
begin
  for i:=0 to sizeof(ba) do
    graf[0][i]:=ord('A');
  b:=TMemoryStream.Create;
  try
    with TIniFile.Create(ExtractFilePath(Application.ExeName)+'inifile.ini') do
      try
        b.write(graf[0], sizeof(ba));
        b.Seek(0, soFromBeginning); // обязательно постувить курсок потока на начало !!!
        WriteBinaryStream('section1', 'stream1', b);
      finally
        Free;
      end;
  finally
    b.Free;
  end;
end;

end.
