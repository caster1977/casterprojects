unit OA5.uViewMessageForm;

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
  Vcl.ImgList,
  CastersPackage.uLogProvider, Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan;

type
  TViewMessageForm=class(TForm)
    ilViewMessageFormSmallImages: TImageList;
    Log: TLogProvider;
    ActionManager1: TActionManager;
    Action_Help: TAction;
    Action_Close: TAction;
    procedure FormShow(Sender: TObject);
    procedure Action_CloseExecute(Sender: TObject);
    procedure Action_HelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  strict private
    procedure ProcedureHeader(const aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
    procedure PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
    procedure Do_Help;
    procedure Do_Close;
    procedure Do_UpdateActions;
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.uRoutines,
  OA5.uMainForm;

procedure TViewMessageForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

procedure TViewMessageForm.ProcedureHeader(const aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TViewMessageForm.PreFooter(const aHandle: HWND; const aError: boolean; const aErrorMessage: string);
begin
  if aError then
    MainForm.ShowErrorBox(aHandle, aErrorMessage)
  else
    Log.SendDebug('��������� ��������� ��� ������.');
  MainForm.pbMain.Position:=MainForm.pbMain.Min;
end;

procedure TViewMessageForm.FormCreate(Sender: TObject);
const
  ICON_VIEWMESSAGE=1;
begin
  ProcedureHeader('���������-���������� ������� �������� ����', '{6BC67F23-9F87-48D9-BEBC-C2C3EB02E4ED}');

  ilViewMessageFormSmallImages.GetIcon(ICON_VIEWMESSAGE, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  Log.SendDebug('�������� "'+Action_Help.Caption+'" '+Routines.GetConditionalString(Action_Help.Enabled, '�', '��')+'�������.');

  with MainForm.Configuration do
    begin
      // ��������� ���������� ���������������� � ������������ � ����������� ���������
      Log.UserName:=MainForm.CurrentUser.Login;
      Log.AllowedTypes:=KeepLogTypes;
      Log.Enabled:=EnableLog;

      // ��������� ��������� ���� � ����������� �� ���������� ������������ ���������
      if ViewMessageFormPosition.bCenter then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if ViewMessageFormPosition.x<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if ViewMessageFormPosition.x>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=ViewMessageFormPosition.x;
          if ViewMessageFormPosition.y<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if ViewMessageFormPosition.y>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=ViewMessageFormPosition.y;
        end;
    end;

  ProcedureFooter;
end;

procedure TViewMessageForm.FormShow(Sender: TObject);
begin
  ProcedureHeader('���������-���������� ������� ����������� ����', '{9BFE180F-1D7B-4070-AE05-291F6C449091}');
  Do_UpdateActions;
  Log.SendInfo('���������� ���� ��������� ����������� ���������.');
  ProcedureFooter;
end;

procedure TViewMessageForm.Action_CloseExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Close.Caption+'"', '{C51BD81D-B224-409C-9AE1-985C0263C371}');
  Do_Close;
  ProcedureFooter;
end;

procedure TViewMessageForm.Action_HelpExecute(Sender: TObject);
begin
  ProcedureHeader('���������-���������� �������� "'+Action_Help.Caption+'"', '{F63639D0-EE85-4695-B7F7-C8DDF5DA9E52}');
  Do_Help;
  ProcedureFooter;
end;

procedure TViewMessageForm.Do_Close;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', '{25E73E71-59EF-4E44-BCFE-482B953B7469}');

  ModalResult:=mrClose;
  Log.SendInfo('���� ��������� ����������� ��������� ������� �������������.');

  ProcedureFooter;
end;

procedure TViewMessageForm.Do_Help;
var
  bError: boolean;
  sErrorMessage: string;
begin
  ProcedureHeader('��������� ������ ����������� �������', '{BD937891-4495-4529-8E8B-A630DCD93E12}');
  bError:=False;

  Log.SendInfo('������������ ������� �������� ����������� ����� ���������...');
  if (FileExists(ExpandFileName(Application.HelpFile))) then
    Application.HelpContext(HelpContext)
  else
    Routines.GenerateError('��������, ���������� ���� � ������ ��������� �� ������.', sErrorMessage, bError);

  PreFooter(Handle, bError, sErrorMessage);
  ProcedureFooter;
end;

procedure TViewMessageForm.Do_UpdateActions;
var
  b: boolean;
begin
  ProcedureHeader('��������� ���������� ��������� ��������', '{E046A30F-9B2A-4787-87B1-C186769154AA}');

//  b:=(cmbbxTo.ItemIndex>-1)or(leTheme.Text<>'')or(reMessage.Text<>'');
//  if Action_Clear.Enabled<>b then
//    begin
//      Action_Clear.Enabled:=b;
//      Log.SendDebug('�������� "'+Action_Clear.Caption+'" '+Routines.GetConditionalString(Action_Clear.Enabled, '�', '��')+'�������.');
//    end;
//
//  b:=(cmbbxTo.ItemIndex>-1)and(leTheme.Text<>'')and(reMessage.Text<>'');
//  if Action_Send.Enabled<>b then
//    begin
//      Action_Send.Enabled:=b;
//      Log.SendDebug('�������� "'+Action_Send.Caption+'" '+Routines.GetConditionalString(Action_Send.Enabled, '�', '��')+'�������.');
//      btnSend.Default:=b;
//      btnClose.Default:=not b;
//    end;

  ProcedureFooter;
end;

end.
