unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, CommCtrl, Menus, AppEvnts, ActnList,
  XPStyleActnCtrls, ActnMan, getFVI, ImgList, ToolWin, ActnCtrls, ExtCtrls,
  VDTrayIcon;
const
	STATUSBAR_ITEMS_COUNT_PANEL_NUMBER: integer = 0;
	STATUSBAR_STATE_PANEL_NUMBER: integer = 1;
	STATUSBAR_PROGRESS_PANEL_NUMBER: integer = 2;
  STATUSBAR_HINT_PANEL_NUMBER: integer = 3;

type
  THackControl = class(TControl);
  TMainForm = class(TForm)
    StatusBar1: TStatusBar;
    ApplicationEvents1: TApplicationEvents;
    PopupMenu1: TPopupMenu;
    gsFileVersionInfo1: TgsFileVersionInfo;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_About: TAction;
    Action_Quit: TAction;
    Action_Restore: TAction;
    ImageList1: TImageList;
    O1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ActionRestore1: TMenuItem;
    ActionToolBar1: TActionToolBar;
    ListBox1: TListBox;
    Timer1: TTimer;
    ImageList2: TImageList;
    ProgressBar1: TProgressBar;
    Image1: TImage;
    VDTrayIcon1: TVDTrayIcon;
    PopupMenu2: TPopupMenu;
    Action_CopyStringToBuffer: TAction;
    N5: TMenuItem;
    Memo1: TMemo;
    Action_Clear: TAction;
    N6: TMenuItem;
    procedure Action_ClearExecute(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure Action_CopyStringToBufferExecute(Sender: TObject);
    procedure VDTrayIcon1RightClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure VDTrayIcon1DblClick(Sender: TObject);
    procedure VDTrayIcon1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Action_RestoreExecute(Sender: TObject);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure Action_QuitExecute(Sender: TObject);
    procedure Action_AboutExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure WMCopyData(var Msg: TWMCopyData); message WM_COPYDATA;
  private
    procedure SetReady;
    procedure SetBusy;
    procedure RestoreMainForm;
  public
		bAboutWindowExist: boolean;
		bStartingNormalShutdown: boolean;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
uses About, ShellAPI;

procedure TMainForm.SetBusy;
begin
  ImageList2.GetIcon(3,Image1.Picture.Icon);
  Image1.Repaint;
  Application.ProcessMessages;
end;

procedure TMainForm.SetReady;
begin
  ImageList2.GetIcon(4,Image1.Picture.Icon);
  Image1.Repaint;
  Application.ProcessMessages;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
	s: string;
  PanelRect: TRect;
begin
  THackControl(ProgressBar1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_PROGRESS_PANEL_NUMBER, Integer(@PanelRect));
  ProgressBar1.SetBounds(PanelRect.Left, PanelRect.Top, PanelRect.Right - PanelRect.Left, PanelRect.Bottom - PanelRect.Top);
  THackControl(Image1).SetParent(StatusBar1);
  SendMessage(StatusBar1.Handle, SB_GETRECT, STATUSBAR_STATE_PANEL_NUMBER, Integer(@PanelRect));
	Image1.SetBounds(PanelRect.Left+1, PanelRect.Top+1, PanelRect.Right - PanelRect.Left+1, PanelRect.Bottom - PanelRect.Top+1);
  gsFileVersionInfo1.Filename:=Application.ExeName;
	if not (FileExists(ExpandFileName(Application.HelpFile))) then
		begin
			Action_Help.Enabled:=False;
			Action_Help.Visible:=False;
		end;
	s:=ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4_UnSendedLog.dat';
	if FileExists(s) then
		ListBox1.Items.LoadFromFile(s);
  MainForm.Visible:=False;
  VDTrayIcon1.Visible:=True;
  if not VDTrayIcon1.AddIcon then
    begin
      MessageBox(Application.Handle,'Возникла ошибка при добавлении иконки в трей!',
        'Внимание!',MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;
  if not VDTrayIcon1.SetVersion then
    begin
      MessageBox(Application.Handle,'Возникла ошибка при установки версии иконки в трее!',
        'Внимание!',MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
    end;

  MainForm.Width:=Screen.WorkAreaWidth;
  MainForm.Height:=200;
  MainForm.Top:=Screen.WorkAreaHeight-MainForm.Height;
  MainForm.Left:=Screen.WorkAreaLeft;

  SetReady;
end;

procedure TMainForm.PopupMenu2Popup(Sender: TObject);
begin
  Action_CopyStringToBuffer.Enabled:=(ListBox1.Count>0) and (ListBox1.ItemIndex>=0);
end;

procedure TMainForm.ApplicationEvents1Minimize(Sender: TObject);
begin
  VDTrayIcon1.Visible:=True;
  MainForm.Visible:=False;
//  ShowWindow(Application.Handle, SW_HIDE);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  // если оновная программа найдена - выдать сообщение
  // о запрете завершения данной программы
  // и сделать CanClose:=False;
	if (FindWindow('TMainForm','OA4')<>0) then // если не было найдено окно операторской программы
    begin
      MessageBox(MainForm.Handle,
				PChar('Работу данной программы завершать нельзя, т.к. в'+#10#13+'данный момент она используется программой "OA4"!'),
        PChar(MainForm.Caption+' - '+'Внимание!'),
        MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
      CanClose:=False;
    end
  // если основная программа не найдена - записать результаты работы,
  // выдать сообщение о ненормальном завершении работы, если нужно,
  // и завершить работу программы, установив CanClose:=True;
  else
    begin
      // записываем результаты работы
      if ListBox1.Items.Count>0 then
				ListBox1.Items.SaveToFile(ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4_UnSendedLog.dat'); // если остались непереданные сообщения - записать их в файл
      // удаляем иконку из трея
      if not VDTrayIcon1.DeleteIcon then
        begin
          MessageBox(Application.Handle,'Возникла ошибка при удалении иконки в трее!',
            PChar(MainForm.Caption+' - '+'Внимание!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
        end;
    end;
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
      VDTrayIcon1.Visible:=False;
      Application.Restore;
    end;
//  ShowWindow(Application.Handle, SW_SHOW);
end;

procedure TMainForm.Action_ClearExecute(Sender: TObject);
begin
  if (ListBox1.Count>0) then
    begin
      ListBox1.Items.BeginUpdate;
      ListBox1.Clear;
      ListBox1.Items.EndUpdate;
    end;
end;

procedure TMainForm.Action_CopyStringToBufferExecute(Sender: TObject);
var
  s: string;
begin
  if (ListBox1.Count>0) and (ListBox1.ItemIndex>=0) then
    begin
      s:=ListBox1.Items[ListBox1.ItemIndex];
      Memo1.Lines.BeginUpdate;
      Memo1.Clear;
      Memo1.Lines.Append(s);
      Memo1.Lines.EndUpdate;
      Memo1.SelectAll;
      Memo1.CopyToClipboard;
    end;
end;

procedure TMainForm.Action_HelpExecute(Sender: TObject);
begin
	if (FileExists(ExpandFileName(Application.HelpFile))) then
		Application.HelpContext(0)
	else MessageBox(MainForm.Handle,PChar('Извините, справочный файл к данной программе не найден.'),PChar(MainForm.Caption+' - '+'Ошибка!'),MB_OK+MB_ICONERROR+MB_DEFBUTTON1);
end;

procedure TMainForm.Action_AboutExecute(Sender: TObject);
var
	s: string;
	p: integer;
begin
	if bAboutWindowExist then
    begin
			SetForegroundWindow(FindWindow('TAboutForm','About "OA4 Log Server"...'));
    end
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
					p:=LastDelimiter('.',s);
					s:=copy(s,1,p-1);
					Label2.Caption:=Format('Версия %s билд %s',[s,gsFileVersionInfo1.GetBuildOnly]);
					Label3.Caption:=gsFileVersionInfo1.LegalCopyright;
					ShowModal;
				finally
					Free;
					bAboutWindowExist:=False;
				end;
		end;
end;

procedure TMainForm.Action_QuitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.ApplicationEvents1Hint(Sender: TObject);
begin
  StatusBar1.Panels[STATUSBAR_HINT_PANEL_NUMBER].Text:=GetLongHint(Application.Hint);
end;

procedure TMainForm.Action_RestoreExecute(Sender: TObject);
begin
  RestoreMainForm;
end;

procedure TMainForm.Timer1Timer(Sender: TObject);
var
  s: string;
  i: HWND;
  a: ATOM;
begin
  if StatusBar1.Panels[STATUSBAR_ITEMS_COUNT_PANEL_NUMBER].Text<>'Сообщений:'+#09#09+IntToStr(ListBox1.Items.Count) then
    StatusBar1.Panels[STATUSBAR_ITEMS_COUNT_PANEL_NUMBER].Text:='Сообщений:'+#09#09+IntToStr(ListBox1.Items.Count);
	ListBox1.Enabled:=ListBox1.Items.Count>0;
	if ((ListBox1.ItemIndex<0) and (ListBox1.Enabled)) then
		ListBox1.ItemIndex:=0;
	i:=FindWindow('TMainForm','OA4');
  if i=0 then // если окно основной программы пропало
    begin
      Timer1.Enabled:=False; // останавливаем таймер
      if not bStartingNormalShutdown then // если не установлена переменная нормального завершения работы
        begin
					a:=GlobalFindAtom('OA4NormalShutdown'); // пытаемся найти атом
          if a<>0 then // если нашли
            begin
              bStartingNormalShutdown:=True; // устанавливаем переменную нормального завершения работы в true
              GlobalDeleteAtom(a); // удалить глобальный атом
            end;
        end;
      if not bStartingNormalShutdown then // если в итоге переменная нормального завершения работы так и не установлена
        begin
					ListBox1.Items.Add('ERROR'+#09+ // если ненормальное завершение работы основной программы - записать его в лог
						StringReplace(FormatDateTime('dd.mm.yyyy hh:nn:ss',Now),' ',#09,[rfReplaceAll])+#09+ // дата и время сообщения
		        '9999999999'+#09+ // порядковый номер сообщения
		        ''+#09+ // текущий залогированный пользователь
						'Обнаружено аварийное завершение работы программы "OA4"!'); // само сообщение
//          MessageBox(MainForm.Handle, // и выдать сообщение на экран
//            PChar('Обнаружено аварийное завершение работы программы "OA4"!'),
//            PChar(MainForm.Caption+' - '+'Внимание!'),
//            MB_OK+MB_ICONWARNING+MB_DEFBUTTON1);
					if MessageBox(Application.Handle, PChar('Работа приложения "OA4" была некорректно завершена!'+#13#10+'Вы хотите вновь запустить программу "OA4"?'),PChar(MainForm.Caption+' - '+'Ошибка!'),MB_YESNO+MB_ICONERROR+MB_DEFBUTTON1)=IDYES then // если пользователь решает всё же перезапустить приложение
            begin
              {$IFDEF DEBUG}
							s:='D:\My Documents\Borland Studio Projects\OA4\OA4.exe';
							{$ELSE}
              s:=ExtractFilePath(ExpandFileName(Application.ExeName))+'OA4.exe';
              {$ENDIF}
              if FileExists(s) then // если файл основного приложения найден
                ShellExecute(Application.Handle,'open',PChar(s),nil,nil,SW_NORMAL); // запустить его
              Sleep(5000); // заснуть на пять секунд, пока запускается основное приложение
              Timer1.Enabled:=True; // снова включить таймер
            end
          else Close;
        end
      else // если был установлен флаг нормального завершения работы
        Close; // завершить работу
    end;
end;

procedure TMainForm.VDTrayIcon1Click(Sender: TObject);
begin
  if MainForm.Visible then
    SetForegroundWindow(MainForm.Handle);
end;

procedure TMainForm.VDTrayIcon1DblClick(Sender: TObject);
begin
  RestoreMainForm;
end;

procedure TMainForm.VDTrayIcon1RightClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  SetForegroundWindow(MainForm.Handle);
  if PopupMenu1<>nil then
    PopupMenu1.Popup(X,Y);
  PostMessage(MainForm.Handle, WM_NULL, 0, 0);
end;

procedure TMainForm.WMCopyData(var Msg: TWMCopyData);
var
  cText: array[0..1023] of AnsiChar;
  LogGroupGUID: string;
begin
  LogGroupGUID:='{C97C8AAB-0F61-45AD-B0EA-CA7F55372516}';
  Screen.Cursor:=crHourGlass;
  Application.ProcessMessages;

  StrLCopy(cText, Msg.CopyDataStruct.lpData, Msg.CopyDataStruct.cbData);
  ListBox1.Items.Add(cText);

  Screen.Cursor:=crDefault;
end;

end.
