unit About;

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
  ExtCtrls,
  StdCtrls,
  ShellAPI,
  Main,
  ImgList;

type
  TAboutForm= class(TForm)
    Timer1: TTimer;
    Image1: TImage;
    Timer2: TTimer;
    Image2: TImage;
    ImageList1: TImageList;
    procedure Image2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Image2MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Image2Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutForm: TAboutForm;

implementation

{$R *.dfm}

procedure TAboutForm.Image2Click(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TAboutForm.Image2MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Bitmap: TBitmap;
begin
  Bitmap:=TBitmap.Create;
  try
    ImageList1.GetBitmap(1, Bitmap);
    Image2.Picture.Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

procedure TAboutForm.Image2MouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  Bitmap: TBitmap;
begin
  Bitmap:=TBitmap.Create;
  try
    ImageList1.GetBitmap(0, Bitmap);
    Image2.Picture.Assign(Bitmap);
  finally
    Bitmap.Free;
  end;
end;

procedure TAboutForm.Timer1Timer(Sender: TObject);
begin
  ModalResult:=mrOk;
end;

procedure TAboutForm.Timer2Timer(Sender: TObject);
begin
  if ((AlphaBlendValue+17)<=222) then
    AlphaBlendValue:=AlphaBlendValue+17;
end;

end.
