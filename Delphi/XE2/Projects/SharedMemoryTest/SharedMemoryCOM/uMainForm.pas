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
  Vcl.StdCtrls;

type
  TMainForm=class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  strict private
    FSharedMemoryName: WideString;
  public
    property SharedMemoryName: WideString read FSharedMemoryName;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  Winapi.ShellAPI,
  System.IOUtils;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  WinExec(PAnsiChar(AnsiString(Application.Exename+' -RegServer')), SW_NORMAL);
//  WinExec(PAnsiChar(AnsiString(Application.Exename+' -RegServer')), SW_NORMAL);
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  FSharedMemoryName:=TPath.GetGUIDFileName(True);
  Edit1.Text:=FSharedMemoryName;
end;

end.
