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
  MPlayer,
  ComCtrls,
  ToolWin,
  ActnMan,
  ActnCtrls,
  ActnMenus,
  XPStyleActnCtrls,
  ActnList,
  Menus,
  ExtCtrls,
  XPMan,
  ImgList,
  getFVI,
  AppEvnts,
  IniFiles,
  ToolTip;

type
  TMainForm=class(TForm)
    TrayIcon1: TTrayIcon;
    MainMenu1: TMainMenu;
    PopupMenu1: TPopupMenu;
    ActionManager1: TActionManager;
    StatusBar1: TStatusBar;
    Action_Quit: TAction;
    ImageList2: TImageList;
    ActionQuit1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Action_About: TAction;
    ApplicationEvents1: TApplicationEvents;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Action_Help: TAction;
    ActionHelp1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    ListView1: TListView;
    ActionToolBar1: TActionToolBar;
    Action_Create: TAction;
    Action_Erase: TAction;
    Action_Edit: TAction;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    Action_Restore: TAction;
    N16: TMenuItem;
    Action_Start: TAction;
    Action_Stop: TAction;
    Action_Configuration: TAction;
    N17: TMenuItem;
    N18: TMenuItem;
    procedure ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
    procedure Action_ConfigurationExecute(Sender: TObject);
    procedure Action_StopExecute(Sender: TObject);
    procedure Action_StartExecute(Sender: TObject);
    procedure ListView1Deletion(Sender: TObject; Item: TListItem);
    procedure ListView1Insert(Sender: TObject; Item: TListItem);
    procedure ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
    procedure Action_RestoreExecute(Sender: TObject);
    procedure Action_EditExecute(Sender: TObject);
    procedure Action_EraseExecute(Sender: TObject);
    procedure Action_CreateExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure TrayIcon1Click(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure SaveConfigIni;
    procedure LoadConfigIni;
    procedure MyOnTimer(Sender: TObject);
  private
    bShowBaloonHints: boolean;
    bSoundEnabled: boolean;
    iMod_On, iMod_Off: integer;
    cVK_On, cVK_Off: cardinal;
    procedure RestoreMainForm;
    procedure Update_Actions;
    procedure Update_IconHint;
    procedure WMHotkey(var msg: TWMHotkey); message WM_HOTKEY;
    procedure AssignHotkeys;
    procedure RemoveHotkeys;
    // procedure TrackMouseMove(AHandle: HWND);
  public
    bAboutWindowExist: boolean;
    bSignalingActive: boolean; // сигнализация включена
  end;

var
  MainForm: TMainForm;
  ToolTipForm: TToolTipForm;

implementation

{$R *.dfm}

uses
  About,
  Signal,
  Configuration,
  StdCtrls,
  MMSystem;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
var
  s: string;
  p: integer;
begin
  if bAboutWindowExist then
    SetForegroundWindow(FindWindow('TAboutForm', 'About "Beeper"...'))
  else
    begin
      bAboutWindowExist:=True;
      with TAboutForm.Create(Self) do
        try
          Button1.Visible:=True;
          Timer1.Enabled:=False;
          AlphaBlendValue:=222;
          Timer2.Enabled:=False;
          s:=gsFileVersionInfo1.FileVersion;
          p:=LastDelimiter('.', s);
          s:=copy(s, 1, p-1);
          Label2.Caption:=Format('Версия %s билд %s', [s, gsFileVersionInfo1.GetBuildOnly]);
          Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
          ShowModal;
        finally
          Free;
          bAboutWindowExist:=False;
        end;
    end;
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
begin
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(0)
  else
    MessageBox(MainForm.Handle, PChar('Извините, справочный файл к данной программе не найден.'), PChar(MainForm.Caption+' - '+'Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.Action_RestoreExecute(Sender: TObject);
begin
  RestoreMainForm;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.SimpleText:=GetLongHint(Application.Hint);
end;

procedure TMainForm.ApplicationEvents1Minimize(Sender: TObject);
begin
  Update_IconHint;
  TrayIcon1.Visible:=True;
  MainForm.Visible:=False;
end;

procedure TMainForm.TrayIcon1Click(Sender: TObject);
begin
  if MainForm.Visible then
    SetForegroundWindow(MainForm.Handle);
end;

procedure TMainForm.TrayIcon1DblClick(Sender: TObject);
begin
  RestoreMainForm;
end;

procedure TMainForm.RestoreMainForm;
var
  fwi: FLASHWINFO;
begin
  if bAboutWindowExist then
    begin
      with fwi do
        begin
          cbSize:=sizeof(FLASHWINFO);
          hwnd:=Application.Handle;
          dwFlags:=FLASHW_TRAY or FLASHW_TIMERNOFG;
          uCount:=0;
          dwTimeout:=0;
        end;
      FlashWindowEx(fwi);
    end
  else
    begin
      MainForm.Visible:=True;
      SetForegroundWindow(MainForm.Handle);
      TrayIcon1.Visible:=False;
      Application.Restore;
    end;
end;

procedure TMainForm.Action_EditExecute(Sender: TObject);
var
  mr: TModalResult;
  s: string;
  i: integer;
  Bitmap: TBitmap;
begin
  with TSignalForm.Create(Self) do
    try
      Caption:='Редактирование сигнала';
      Bitmap:=TBitmap.Create;
      try
        ImageList1.GetBitmap(0, Bitmap);
        PlayButton.Glyph.Assign(Bitmap);
        PlayButton.Glyph.TransparentColor:=clNone;
      finally
        Bitmap.Free;
      end;
      PlayButton.Enabled:=False;
      // UpdatePlayButtonState;
      Edit1.Text:=Trim(ListView1.Selected.Caption); // наименование сигнала
      Edit2.Text:=Trim(ListView1.Selected.SubItems[2]);
      // длительность сигнала в секундах
      ComboBox1.ItemIndex:=0;
      ComboBox2.Items.Clear;
      ComboBox2.ItemIndex:=ComboBox2.Items.Add(Trim(ListView1.Selected.SubItems[1])); // имя звукового файла
      UpdateOkButtonState;
      ShowModal;
    finally
      mr:=ModalResult;
      if mr=mrOk then
        begin
          s:=Trim(Edit2.Text);
          i:=StrToIntDef(s, -1);
          case ComboBox1.ItemIndex of
            0:
              i:=i*1;
            1:
              i:=i*60;
            2:
              i:=i*3600;
          end;
          ListView1.Items.BeginUpdate;
          TTimer(ListView1.Selected.Data).Interval:=i*1000;
          ListView1.Selected.Caption:=Trim(Edit1.Text);
          // наименование сигнала
          ListView1.Selected.SubItems[0]:=IntToStr(i)+' секунд';
          // периодичность сигнала (строка)
          ListView1.Selected.SubItems[1]:=Trim(ComboBox2.Items[ComboBox2.ItemIndex]); // имя звукового файла
          ListView1.Selected.SubItems[2]:=IntToStr(i);
          // длительность сигнала в секундах
          ListView1.Selected.Selected:=True;
          ListView1.Selected.Focused:=True;
          TTimer(ListView1.Selected.Data).OnTimer:=MyOnTimer;
          ListView1.Items.EndUpdate;
        end;
      Free;
    end;
  Update_IconHint;
end;

procedure TMainForm.Action_EraseExecute(Sender: TObject);
begin
  if ListView1.Selected<>nil then
    if MessageBox(Handle, PChar('Вы действительно хотите удалить данный сигнал?'), PChar('Подтверждение удаления'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK then
      begin
        ListView1.Selected.Delete;
        ListView1.ItemFocused:=nil;
        ListView1.Selected:=nil;
      end;
  Update_IconHint;
end;

procedure TMainForm.Action_StartExecute(Sender: TObject);
var
  i: integer;
  NewTimer: TTimer;
begin
  for i:=0 to ListView1.Items.Count-1 do
    if ListView1.Items[i].Checked then
      begin
        NewTimer:=TTimer(ListView1.Items[i].Data);
        NewTimer.Enabled:=True;
      end;
  bSignalingActive:=True;
  if TrayIcon1.Visible then
    begin
      TrayIcon1.BalloonHint:='Сигналы запущены';
      TrayIcon1.BalloonTitle:='Информация';
      TrayIcon1.BalloonFlags:=bfInfo;
      if bShowBaloonHints then
        TrayIcon1.ShowBalloonHint;
    end;
  if bSoundEnabled then
    PlaySound('WAVE_0', HInstance, SND_RESOURCE or SND_ASYNC);
  Update_Actions;
end;

procedure TMainForm.Action_StopExecute(Sender: TObject);
var
  i: integer;
begin
  for i:=0 to ListView1.Items.Count-1 do
    TTimer(ListView1.Items[i].Data).Enabled:=False;
  bSignalingActive:=False;
  if TrayIcon1.Visible then
    begin
      TrayIcon1.BalloonHint:='Сигналы остановлены';
      TrayIcon1.BalloonTitle:='Информация';
      TrayIcon1.BalloonFlags:=bfInfo;
      if bShowBaloonHints then
        TrayIcon1.ShowBalloonHint;
    end;
  if bSoundEnabled then
    PlaySound('WAVE_1', HInstance, SND_RESOURCE or SND_ASYNC);
  Update_Actions;
end;

procedure TMainForm.Update_Actions;
begin
  Action_Create.Enabled:=True;
  Action_Edit.Enabled:=ListView1.Selected<>nil;
  Action_Erase.Enabled:=ListView1.Selected<>nil;
  Action_Start.Enabled:=not bSignalingActive;
  Action_Stop.Enabled:=bSignalingActive;
end;

procedure TMainForm.Update_IconHint;
var
  s: string;
  i: integer;
  b: boolean;
begin
  s:=UpperCase(StringReplace(ExtractFileName(Application.ExeName), ExtractFileExt(Application.ExeName), '', [rfIgnoreCase]));
  if bSignalingActive then
    s:=s+sLineBreak+'Сигналы активированы.'
  else
    s:=s+sLineBreak+'Сигналы деактивированы.';
  if ListView1.Items.Count>0 then
    begin
      b:=False;
      for i:=0 to ListView1.Items.Count-1 do
        if ListView1.Items[i].Checked then
          b:=True;
      if b then
        begin
          s:=s+sLineBreak+sLineBreak+'Список активных сигналов (всего: '+IntToStr(ListView1.Items.Count)+'):';
          for i:=0 to ListView1.Items.Count-1 do
            if ListView1.Items[i].Checked then
              s:=s+sLineBreak+IntToStr(i+1)+'. '+ListView1.Items[i].Caption+' - '+ListView1.Items[i].SubItems[0];
        end;
    end;
  // TrayIcon1.Hint:=s;
end;

procedure TMainForm.ListView1SelectItem(Sender: TObject; Item: TListItem; Selected: Boolean);
begin
  Update_Actions;
end;

procedure TMainForm.SaveConfigIni;
var
  IniFile: TIniFile;
  s: string;
  i: integer;
begin
  s:=ExtractFilePath(Application.ExeName)+StringReplace(ExtractFileName(Application.ExeName), ExtractFileExt(Application.ExeName), '.ini', [rfIgnoreCase]);
  IniFile:=TIniFile.Create(s);
  with IniFile do
    try
      WriteBool('Подсказки', 'В трее', bShowBaloonHints);
      WriteBool('Звуки', 'Включены', bSoundEnabled);

      WriteInteger('Горячие клавиши', 'Модификатор включения', iMod_On);
      WriteInteger('Горячие клавиши', 'Клавиша включения', cVK_On);
      WriteInteger('Горячие клавиши', 'Модификатор отключения', iMod_Off);
      WriteInteger('Горячие клавиши', 'Клавиша отключения', cVK_Off);

      WriteInteger('Сигналы', 'Количество', ListView1.Items.Count);
      for i:=0 to ListView1.Items.Count-1 do
        begin
          WriteString('Сигнал_'+IntToStr(i), 'Наименование', ListView1.Items[i].Caption);
          WriteInteger('Сигнал_'+IntToStr(i), 'Периодичность', StrToInt(ListView1.Items[i].SubItems[2]));
          WriteString('Сигнал_'+IntToStr(i), 'Файл', ListView1.Items[i].SubItems[1]);
          WriteBool('Сигнал_'+IntToStr(i), 'Включен', ListView1.Items[i].Checked);
        end;
    finally
      Free;
    end;
end;

procedure TMainForm.ListView1Deletion(Sender: TObject; Item: TListItem);
var
  i: integer;
begin
  // при удалении элемента необходимо удалить принадлежащий ему таймер
  TTimer(Item.Data).Enabled:=False;
  TTimer(Item.Data).OnTimer:=nil;
  TTimer(Item.Data).Interval:=0;
  TTimer(Item.Data).Free;
  for i:=0 to ListView1.Items.Count-1 do
    TTimer(ListView1.Items[i].Data).Tag:=i;
end;

procedure TMainForm.LoadConfigIni;
var
  IniFile: TIniFile;
  s, s1, s2: string;
  quantity, i, i1: integer;
  Node: TListItem;
  b: boolean;
begin
  s:=ExtractFilePath(Application.ExeName)+StringReplace(ExtractFileName(Application.ExeName), ExtractFileExt(Application.ExeName), '.ini', [rfIgnoreCase]);
  IniFile:=TIniFile.Create(s);
  with IniFile do
    try
      ListView1.Clear;
      bShowBaloonHints:=ReadBool('Подсказки', 'В трее', True);
      bSoundEnabled:=ReadBool('Звуки', 'Включены', True);
      iMod_On:=ReadInteger('Горячие клавиши', 'Модификатор включения', MOD_SHIFT+MOD_ALT);
      iMod_Off:=ReadInteger('Горячие клавиши', 'Модификатор отключения', MOD_CONTROL+MOD_ALT+MOD_SHIFT);
      cVK_On:=ReadInteger('Горячие клавиши', 'Клавиша включения', VK_F12);
      cVK_Off:=ReadInteger('Горячие клавиши', 'Клавиша отключения', VK_F12);
      quantity:=ReadInteger('Сигналы', 'Количество', 0);
      for i:=0 to quantity-1 do
        begin
          s1:=ReadString('Сигнал_'+IntToStr(i), 'Наименование', '');
          i1:=ReadInteger('Сигнал_'+IntToStr(i), 'Периодичность', 0);
          s2:=ReadString('Сигнал_'+IntToStr(i), 'Файл', '');
          b:=ReadBool('Сигнал_'+IntToStr(i), 'Включен', False);
          if ((s1<>'')and(i1>0)and(s2<>'')) then
            begin
              Node:=ListView1.Items.Add;
              Node.Caption:=s1;
              Node.SubItems.Add(IntToStr(i1)+' секунд');
              Node.SubItems.Add(s2);
              Node.SubItems.Add(IntToStr(i1));
              Node.Checked:=b;
              TTimer(Node.Data).OnTimer:=MyOnTimer;
              TTimer(Node.Data).Interval:=i1*1000;
              TTimer(Node.Data).Tag:=Node.index;
            end;
        end;
    finally
      Free;
    end;
end;

procedure TMainForm.Action_CreateExecute(Sender: TObject);
var
  Node: TListItem;
  mr: TModalResult;
  s: string;
  i: integer;
  Bitmap: TBitmap;
begin
  with TSignalForm.Create(Self) do
    try
      Caption:='Создание сигнала';
      UpdateOkButtonState;
      Bitmap:=TBitmap.Create;
      try
        ImageList1.GetBitmap(0, Bitmap);
        PlayButton.Glyph.Assign(Bitmap);
        PlayButton.Glyph.TransparentColor:=clNone;
      finally
        Bitmap.Free;
      end;
      PlayButton.Enabled:=False;
      ShowModal;
    finally
      mr:=ModalResult;
      if mr=mrOk then
        begin
          s:=Trim(Edit2.Text);
          i:=StrToIntDef(s, -1);
          case ComboBox1.ItemIndex of
            0:
              i:=i*1;
            1:
              i:=i*60;
            2:
              i:=i*3600;
          end;
          Node:=ListView1.Items.Add;
          Node.Caption:=Trim(Edit1.Text); // наименование сигнала
          Node.SubItems.Add(IntToStr(i)+' секунд');
          // периодичность сигнала (строка)
          Node.SubItems.Add(Trim(ComboBox2.Items[ComboBox2.ItemIndex]));
          // имя звукового файла
          Node.SubItems.Add(IntToStr(i)); // длительность сигнала в секундах
          Node.Selected:=True;
          Node.Focused:=True;
          TTimer(Node.Data).OnTimer:=MyOnTimer;
          TTimer(Node.Data).Interval:=i*1000;
          TTimer(Node.Data).Tag:=Node.index;
        end;
      Free;
    end;
  Update_IconHint;
end;

procedure TMainForm.ListView1Insert(Sender: TObject; Item: TListItem);
var
  NewTimer: TTimer;
begin
  NewTimer:=TTimer.Create(ListView1);
  NewTimer.Enabled:=False;
  NewTimer.Interval:=0;
  Item.Data:=NewTimer;
end;

procedure TMainForm.MyOnTimer(Sender: TObject);
var
  s: string;
  pac: PWideChar;
  Hour, Min, Sec, MSec: word;
begin
  if bSignalingActive then
    begin
      s:=Trim(ListView1.Items[TTimer(Sender).Tag].SubItems[1]);
      DecodeTime(Now, Hour, Min, Sec, MSec);
      TrayIcon1.BalloonHint:=TimeToStr(EncodeTime(Hour, Min, Sec, MSec))+' - Сработал сигнал '+'"'+Trim(ListView1.Items[TTimer(Sender).Tag].Caption)+'"';
      TrayIcon1.BalloonTitle:=''; // Внимание!
      TrayIcon1.BalloonFlags:=bfWarning;
      if bShowBaloonHints then
        TrayIcon1.ShowBalloonHint;
      pac:=PWideChar(s);
      if bSoundEnabled then
        PlaySound(pac, 0, SND_FILENAME or SND_ASYNC);
    end;
end;

procedure TMainForm.WMHotkey(var msg: TWMHotkey);
begin
  case msg.hotkey of
    1:
      if not bSignalingActive then
        Action_Start.Execute;
    2:
      if bSignalingActive then
        Action_Stop.Execute;
  end;
end;

procedure TMainForm.Action_ConfigurationExecute(Sender: TObject);
begin
  with TConfigurationForm.Create(Self) do
    try
      CheckBox1.Checked:=(iMod_On and MOD_CONTROL)>0;
      CheckBox2.Checked:=(iMod_On and MOD_ALT)>0;
      CheckBox3.Checked:=(iMod_On and MOD_SHIFT)>0;

      CheckBox4.Checked:=(iMod_Off and MOD_CONTROL)>0;
      CheckBox5.Checked:=(iMod_Off and MOD_ALT)>0;
      CheckBox6.Checked:=(iMod_Off and MOD_SHIFT)>0;

      case cVK_On of
        VK_F9:
          ComboBox1.ItemIndex:=0;
        VK_F10:
          ComboBox1.ItemIndex:=1;
        VK_F11:
          ComboBox1.ItemIndex:=2;
        VK_F12:
          ComboBox1.ItemIndex:=3;
      else
        ComboBox1.ItemIndex:=-1;
      end;

      case cVK_Off of
        VK_F9:
          ComboBox2.ItemIndex:=0;
        VK_F10:
          ComboBox2.ItemIndex:=1;
        VK_F11:
          ComboBox2.ItemIndex:=2;
        VK_F12:
          ComboBox2.ItemIndex:=3;
      else
        ComboBox2.ItemIndex:=-1;
      end;

      CheckBox7.Checked:=bShowBaloonHints;
      CheckBox8.Checked:=bSoundEnabled;

      ShowModal;
    finally
      if ModalResult=mrOk then
        begin
          iMod_On:=0;
          if CheckBox1.Checked then
            iMod_On:=iMod_On+MOD_CONTROL;
          if CheckBox2.Checked then
            iMod_On:=iMod_On+MOD_ALT;
          if CheckBox3.Checked then
            iMod_On:=iMod_On+MOD_SHIFT;
          iMod_Off:=0;
          if CheckBox4.Checked then
            iMod_Off:=iMod_Off+MOD_CONTROL;
          if CheckBox5.Checked then
            iMod_Off:=iMod_Off+MOD_ALT;
          if CheckBox6.Checked then
            iMod_Off:=iMod_Off+MOD_SHIFT;
          case ComboBox1.ItemIndex of
            0:
              cVK_On:=VK_F9;
            1:
              cVK_On:=VK_F10;
            2:
              cVK_On:=VK_F11;
            3:
              cVK_On:=VK_F12;
          else
            cVK_On:=0;
          end;
          case ComboBox2.ItemIndex of
            0:
              cVK_Off:=VK_F9;
            1:
              cVK_Off:=VK_F10;
            2:
              cVK_Off:=VK_F11;
            3:
              cVK_Off:=VK_F12;
          else
            cVK_Off:=0;
          end;
          RemoveHotkeys;
          AssignHotkeys;
          bShowBaloonHints:=CheckBox7.Checked;
          bSoundEnabled:=CheckBox8.Checked;
        end;
      Free;
    end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:=MessageBox(Handle, PChar('Вы действительно хотите завершить работу программы?'), PChar('OA4 - Подтверждение выхода'), MB_OKCANCEL+MB_ICONQUESTION+MB_DEFBUTTON2)=IDOK;
  if CanClose then
    begin
      ToolTipForm.Visible:=False;
      ToolTipForm.Free;
      bSignalingActive:=False;
      SaveConfigIni;
      RemoveHotkeys;
    end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  s: string;
  i: integer;
begin
  bSignalingActive:=False;
  ToolTipForm:=TToolTipForm.Create(Self);
  ToolTipForm.Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-ToolTipForm.Height;
  ToolTipForm.Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-ToolTipForm.Width;
  ToolTipForm.Visible:=False;
  LoadConfigIni;
  AssignHotkeys;
  if not(FileExists(ExpandFileName(Application.HelpFile))) then
    begin
      Action_Help.Enabled:=False;
      Action_Help.Visible:=False;
    end;
  MainForm.Visible:=False;
  TrayIcon1.BalloonTimeout:=0;
  TrayIcon1.Visible:=True;
  Update_Actions;
  with TAboutForm.Create(Self) do
    try
      Button1.Visible:=False;
      Timer1.Enabled:=True;
      AlphaBlendValue:=0;
      Timer2.Enabled:=True;
      s:=gsFileVersionInfo1.FileVersion;
      i:=LastDelimiter('.', s);
      s:=copy(s, 1, i-1);
      Label2.Caption:=Format('Версия %s билд %s', [s, gsFileVersionInfo1.GetBuildOnly]);
      Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
      ShowModal;
    finally
      Free;
    end;
  Update_IconHint;
end;

procedure TMainForm.AssignHotkeys;
begin
  if not RegisterHotkey(Handle, 1, iMod_On, cVK_On) then
    MessageBox(Handle, PChar('Не удалось назначить горячую клавишу для запуска сигналов.'), PChar('BEEPER - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  if not RegisterHotkey(Handle, 2, iMod_Off, cVK_Off) then
    MessageBox(Handle, PChar('Не удалось назначить горячую клавишу для останова сигналов.'), PChar('BEEPER - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
end;

procedure TMainForm.RemoveHotkeys;
begin
  if not UnRegisterHotkey(Handle, 2) then
    MessageBox(Handle, PChar('Не удалось освободить горячую клавишу предназначеную для останова сигналов.'), PChar('BEEPER - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
  if not UnRegisterHotkey(Handle, 1) then
    MessageBox(Handle, PChar('Не удалось освободить горячую клавишу предназначеную для запуска сигналов.'), PChar('BEEPER - Ошибка!'), MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
end;

procedure TMainForm.ApplicationEvents1Message(var Msg: tagMSG; var Handled: Boolean);
begin
  case Msg.message of
    WM_SYSTEM_TRAY_MESSAGE:
      begin
        case Msg.lParam of
          WM_MOUSEHOVER:
            TrayIcon1.Hint:='WM_MOUSEHOVER';
          WM_MOUSELEAVE:
            TrayIcon1.Hint:='WM_MOUSELEAVE';
        end;
      end;
  end;
end;

end.

// негде поставить галочку "запускаться при старте windows
// вшей туда какой нить стандартный beep ) или просто путь к файлу C:\WINDOWS\Media\chord.wav
