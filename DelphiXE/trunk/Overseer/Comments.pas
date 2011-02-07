unit Comments;

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
  jpeg;

type
  TCommentsForm=class(TForm)
    Image1: TImage;
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FSmallImage, FNormalImage: TJPEGImage;
    FTrigger: boolean;
    procedure SetNormalImage(const Value: TJPEGImage);
    procedure SetSmallImage(const Value: TJPEGImage);
  public
    property SmallImage: TJPEGImage read FSmallImage write SetSmallImage;
    property NormalImage: TJPEGImage read FNormalImage write SetNormalImage;
    destructor Destroy; override;
  end;

var
  CommentsForm: TCommentsForm;

implementation

{$R *.dfm}

destructor TCommentsForm.Destroy;
begin
  SmallImage.Free;
  NormalImage.Free;
  inherited;
end;

procedure TCommentsForm.FormCreate(Sender: TObject);
begin
  FTrigger:=False;
end;

procedure TCommentsForm.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    ModalResult:=mrClose;
end;

procedure TCommentsForm.Image1Click(Sender: TObject);
begin
  Hide;
  case FTrigger of
    False:
      Image1.Picture.Assign(NormalImage);
    True:
      Image1.Picture.Assign(SmallImage);
  end;
  FTrigger:=not FTrigger;
  Position:=poScreenCenter;
  Show;
end;

procedure TCommentsForm.SetNormalImage(const Value: TJPEGImage);
begin
  FNormalImage:=Value;
end;

procedure TCommentsForm.SetSmallImage(const Value: TJPEGImage);
begin
  FSmallImage:=Value;
end;

end.
