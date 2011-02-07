unit Signal;

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
  Buttons,
  StdCtrls,
  ImgList;

type
  TSignalForm=class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Button1: TButton;
    Label4: TLabel;
    ComboBox1: TComboBox;
    PlayButton: TBitBtn;
    ButtonOk: TButton;
    ButtonCancel: TButton;
    Bevel1: TBevel;
    ComboBox2: TComboBox;
    ImageList1: TImageList;
    procedure PlayButtonClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
  public
    procedure UpdateOkButtonState;
    procedure UpdatePlayButtonState;
  end;

var
  SignalForm: TSignalForm;

implementation

{$R *.dfm}

uses
  MMSystem;

procedure TSignalForm.PlayButtonClick(Sender: TObject);
var
  s: string;
  pac: PWideChar;
begin
  PlayButton.Tag:=integer(not boolean(PlayButton.Tag));
  s:=Trim(ComboBox2.Items[ComboBox2.ItemIndex]);
  pac:=PWideChar(s);
  UpdatePlayButtonState;
  PlayButton.Enabled:=False;
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;
  sndPlaySound(pac, SND_FILENAME or SND_SYNC);
  PlayButton.Enabled:=True;
  Screen.Cursor:=crDefault;
end;

procedure TSignalForm.Button1Click(Sender: TObject);
begin
  with TOpenDialog.Create(Self) do
    try
      Filter:='Звуковой файл WAV (*.wav)|*.wav'; // |Звуковой файл (*.mp3)|*.mp3';
      DefaultExt:='wav';
      Title:='Выберите звуковой файл...';
      FilterIndex:=1;
      Options:=[ofReadOnly, ofFileMustExist];
      if Execute then
        if FileName='' then
          MessageDlg('Не выбран звуковой файл!', mtError, [mbOk], 0)
        else
          begin
            if FileExists(FileName) then
              begin
                if ComboBox2.Items.IndexOf(FileName)=-1 then
                  ComboBox2.ItemIndex:=ComboBox2.Items.Add(FileName)
                else
                  ComboBox2.ItemIndex:=ComboBox2.Items.IndexOf(FileName);
              end;
          end;
    finally
      Free;
    end;
  UpdateOkButtonState;
end;

procedure TSignalForm.Edit2Change(Sender: TObject);
begin
  UpdateOkButtonState;
end;

procedure TSignalForm.UpdateOkButtonState;
var
  b1, b2, b3, b4: boolean;
begin
  b1:=Trim(Edit1.Text)>'';
  b2:=StrToIntDef(Trim(Edit2.Text), -1)>0;
  b3:=ComboBox1.ItemIndex in [0..2];
  b4:=FileExists(Trim(ComboBox2.Text));
  ButtonOk.Enabled:=b1 and b2 and b3 and b4;
  ButtonOk.default:=ButtonOk.Enabled;
  ButtonCancel.default:=not ButtonOk.Enabled;
  PlayButton.Enabled:=b4;
end;

procedure TSignalForm.UpdatePlayButtonState;
// var
// Bitmap: TBitmap;
begin
  // Bitmap:=TBitmap.Create;
  // try
  // case PlayButton.Tag of
  // 0: ImageList1.GetBitmap(0,Bitmap);
  // 1: ImageList1.GetBitmap(1,Bitmap);
  // end;
  // PlayButton.Glyph.Assign(Bitmap);
  // PlayButton.Glyph.TransparentColor:=clNone;
  // finally
  // Bitmap.Free;
  // end;
end;

end.
