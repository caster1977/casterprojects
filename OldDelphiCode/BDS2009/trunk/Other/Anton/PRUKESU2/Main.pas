unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, XPStyleActnCtrls, ActnList, ActnMan, ComCtrls, Menus,
  AppEvnts, getFVI, Grids, ValEdit, IniFiles, ComPort, StdCtrls;

type
  TMainForm = class(TForm)
    MainMenu1: TMainMenu;
    StatusBar1: TStatusBar;
    ActionManager1: TActionManager;
    ImageList1: TImageList;
    ImageList2: TImageList;
    Action_Quit: TAction;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    N4: TMenuItem;
    N5: TMenuItem;
    Action_Open: TAction;
    OpenDialog1: TOpenDialog;
    N6: TMenuItem;
    SaveDialog1: TSaveDialog;
    Action_SaveAs: TAction;
    N7: TMenuItem;
    Action_Save: TAction;
    N8: TMenuItem;
    Action_Help: TAction;
    N9: TMenuItem;
    gsFileVersionInfo1: TgsFileVersionInfo;
    Action_About: TAction;
    N10: TMenuItem;
    N11: TMenuItem;
    Action_ReadKESU: TAction;
    Action_WriteKESU: TAction;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    miCOM2: TMenuItem;
    PageControl1: TPageControl;
    Parameters: TTabSheet;
    Graphs: TTabSheet;
    ValueListEditor1: TValueListEditor;
    ValueListEditor2: TValueListEditor;
    miCOM1: TMenuItem;
    eAvaibleBytes: TEdit;
    eReadBuffer: TEdit;
    procedure miCOM2Click(Sender: TObject);
    procedure miCOM1Click(Sender: TObject);
    procedure ValueListEditor2Validate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: string);
    procedure Action_SaveExecute(Sender: TObject);
    procedure Action_WriteKESUExecute(Sender: TObject);
    procedure Action_ReadKESUExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure Action_SaveAsExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_OpenExecute(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
  private
    { Private declarations }
    FPort: TComPort;
    sSaveFileName: string;
    slPresent, slKP, slDFilter: TStringList;
    ifWorkFile: TIniFile;
    procedure Save;
    procedure OnReadByte(const B : Byte; PortState : TComStat; ErrCode, ModemState : Cardinal);
  public
    { Public declarations }
    procedure SetPortProperties;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

Uses About;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.SimpleText:=GetLongHint(Application.Hint);
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
//	s: string;
  i: integer;
begin
  slPresent:=TStringList.Create;
  slKP:=TStringList.Create;
  slDFilter:=TStringList.Create;
  with slPresent do
    begin
      Add('Есть');
      Add('Нет');
    end;
  with slKP do
    begin
      Add('6-ти ступенчатая');
      Add('4-х ступенчатая');
      Add('Нет');
    end;
  with slDFilter do
    begin
      Add('Включение сигнализтора при замыкании');
      Add('Включение сигнализтора при размыкании');
      Add('Нет');
    end;
  gsFileVersionInfo1.Filename:=Application.ExeName; // получение информации о версии файла и инициализация объект0
//  with TAboutForm.Create(Self) do // отображение окна "О программе..."
//		try
//			Button1.Visible:=False;
//			Timer1.Enabled:=True;
//			AlphaBlendValue:=0;
//			Timer2.Enabled:=True;
//			s:=gsFileVersionInfo1.FileVersion;
//			i:= LastDelimiter('.',s);
//			s:= copy(s,1,i-1);
//			Label2.Caption:=Format('Версия %s билд %s',[s,gsFileVersionInfo1.GetBuildOnly]);
//			Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
//			ShowModal;
//		finally
//			Free;
//		end;
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  SaveDialog1.InitialDir:=OpenDialog1.InitialDir;
  for i:=0 to 9 do
    begin
      ValueListEditor1.ItemProps[i].EditStyle:=esPickList;
      ValueListEditor1.ItemProps[i].ReadOnly:=True;
    end;
  for i:=0 to 4 do
    ValueListEditor1.ItemProps[i].PickList:=slPresent;
  ValueListEditor1.ItemProps[5].PickList:=slKP;
  for i:=6 to 9 do
    ValueListEditor1.ItemProps[i].PickList:=slDFilter;
  for i:=0 to 9 do
    ValueListEditor1.Cells[1,i+1]:=ValueListEditor1.ItemProps[i].PickList.Strings[0];
  for i:=0 to (ValueListEditor2.Strings.Count-1) do
      ValueListEditor2.ItemProps[i].EditMask:='999;0; ';
//      ValueListEditor2.Cells[1,i]:='0';
  FPort:= TComPort.Create(Self);
  FPort.OnReadByte:= OnReadByte;
  //SetEnabledControls;
end;

procedure TMainForm.Action_OpenExecute(Sender: TObject);
begin
  if OpenDialog1.Execute then
    begin
      sSaveFileName:=ExpandFileName(OpenDialog1.FileName);
//      MessageBox(Application.Handle,PChar(sSaveFileName),'Файл записи',MB_OK);
      ifWorkFile:=TIniFile.Create(sSaveFileName);
      ValueListEditor1.Cells[1,1]:=ifWorkFile.ReadString('Узлы и агрегаты','ППВМ',ValueListEditor1.Cells[1,1]);
      ifWorkFile.Free;
    end;
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
begin
	if (FileExists(ExpandFileName(Application.HelpFile))) then
		Application.HelpContext(0)
	else MessageBox(MainForm.Handle,PChar('Извините, справочный файл к данной программе не найден.'),PChar('Ошибка!'),MB_OK+MB_ICONERROR);
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
var
	s: string;
	p: integer;
begin
  with TAboutForm.Create(Self) do
		try
      Button1.Visible:=True;
      Timer1.Enabled:=False;
      AlphaBlendValue:=222;
      Timer2.Enabled:=False;
			s:=gsFileVersionInfo1.FileVersion;
			p:= LastDelimiter('.',s);
			s:= copy(s,1,p-1);
			Label2.Caption:=Format('Версия %s билд %s',[s,gsFileVersionInfo1.GetBuildOnly]);
			Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
			ShowModal;
		finally
			Free;
		end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  slPresent.Free;
  slKP.Free;
  slDFilter.Free;
  FPort.Free;
end;

procedure TMainForm.Action_ReadKESUExecute(Sender: TObject);
begin
  FPort.Close;
  if miCOM1.Checked then FPort.ComNumber:=1;
  if miCOM2.Checked then FPort.ComNumber:=2;
  SetPortProperties;
  FPort.Open;
  if FPort.Connected then
    begin
      MessageBox(Application.Handle,'Порт успешно открыт','',MB_OK);
      FPort.ReadActive:=True;
      MessageBox(Application.Handle,'Начала Опрос порта','',MB_OK);
      {дописать процедуру чтения из порта}
//      FPort.ReadActive:=False;
    end
  else
    MessageBox(Application.Handle,'Ошибка открытия порта','',MB_OK);
//  FPort.Close;
end;

procedure TMainForm.Action_WriteKESUExecute(Sender: TObject);
begin
  FPort.Close;
  if miCOM1.Checked then FPort.ComNumber:=1;
  if miCOM2.Checked then FPort.ComNumber:=2;
  SetPortProperties;
  FPort.Open;
  if FPort.Connected then
    begin
      MessageBox(Application.Handle,'Порт успешно открыт','',MB_OK);
      FPort.ReadActive:=True;
      MessageBox(Application.Handle,'Начала Опрос порта','',MB_OK);
      {дописать процедуру чтения из порта}
      FPort.WriteByte(8);
      FPort.WriteByte(9);
      FPort.ReadActive:=False;
    end
  else
    MessageBox(Application.Handle,'Ошибка открытия порта','',MB_OK);
  FPort.Close;
end;

procedure TMainForm.Action_SaveAsExecute(Sender: TObject);
begin
  if SaveDialog1.Execute then
    begin
      sSaveFileName:=ExpandFileName(SaveDialog1.FileName);
      Save;
    end;
end;

procedure TMainForm.Action_SaveExecute(Sender: TObject);
begin
  if sSaveFileName<>'' then
    Save
  else
    if SaveDialog1.Execute then
      begin
        sSaveFileName:=ExpandFileName(SaveDialog1.FileName);
        Save;
      end;
end;

procedure TMainForm.Save;
begin
//      MessageBox(Application.Handle,PChar(sSaveFileName),'Файл записи',MB_OK);
  ifWorkFile:=TIniFile.Create(sSaveFileName);
  ifWorkFile.WriteString('Узлы и агрегаты','ППВМ',ValueListEditor1.Cells[1,1]);
  ifWorkFile.Free;
end;

procedure TMainForm.ValueListEditor2Validate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: string);
var
  i: integer;
begin
  i:=StrToIntDef(KeyValue,0);
  if i>100 then
    ValueListEditor2.Cells[ACol,ARow]:='100'
  else
    ValueListEditor2.Cells[ACol,ARow]:=IntToStr(i);
end;

procedure TMainForm.OnReadByte(const B : Byte; PortState : TComStat; ErrCode, ModemState : Cardinal);
Var S : String;  AvaibleBytes : Cardinal;
begin
 { Отображаем число полученных, но еще не прочитанных байт}
 AvaibleBytes:= PortState.cbInQue;
 eAvaibleBytes.Text:= IntToStr(AvaibleBytes);
 {Теперь нет необходимости проверять наличие байта для чтения,}
 {событие OnReadByte вызывается только после считывания байта }
 S:= eReadBuffer.Text;
 S:= S + Format('$%X',[B]);
 If Length(S) > 40 then Delete(S, 1, 3);
 eReadBuffer.Text:= S;
end;

{Задание свойств порта}
procedure TMainForm.SetPortProperties;
begin
 {Длина байта}
 FPort.ByteSize:= bs8;
 {Число стоп-бит. Так как Windows оставляет контроль за}
 {правильностью настроек на программиста, то запрещаем }
 {выставлять 2 стоп-бита для не 5-битовых данных       }
 FPort.Stopbits:= sb1BITS;
 {Контроль четности}
 FPort.Parity  := ptNONE;
 {Скорость передачи}
 FPort.BaudRate:= br9600;
end;

procedure TMainForm.miCOM1Click(Sender: TObject);
begin
  miCOM1.Checked:=True;
end;

procedure TMainForm.miCOM2Click(Sender: TObject);
begin
  miCOM2.Checked:=True;
end;

end.
