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
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
{
  function GetSharedMemoryName: WideString;
  begin
  Result:=TPath.GetGUIDFileName(True);
  // Result:=TPath.GetRandomFileName;
  // Result:=TPath.GetTempFileName;
  end;
}

end.
