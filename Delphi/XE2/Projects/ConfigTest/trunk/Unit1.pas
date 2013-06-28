unit Unit1;

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
  ConfigPackage.uTIniFileSerilizator;

type
  TForm1 = class(TForm)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Configuration: TIniFileSerilizator;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.IniFiles,
  Unit2;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Configuration := TIniFileSerilizator.Create;
  Configuration.RegisterOptions(TProxyOptions);
  Configuration.Section<TProxyOptions>.Active := True;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  if Assigned(Configuration) then
  begin
    FreeAndNil(Configuration);
  end;
end;

end.
