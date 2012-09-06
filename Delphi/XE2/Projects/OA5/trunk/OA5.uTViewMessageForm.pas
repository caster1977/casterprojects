unit OA5.uTViewMessageForm;

interface

uses
  CastersPackage.uTLogForm,
  Vcl.Forms,
  System.Classes,
  Vcl.ActnList,
  Vcl.ImgList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TViewMessageForm = class(TLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actHelp: TAction;
    actClose: TAction;
    actDelete: TAction;
    actPrevious: TAction;
    actNext: TAction;
    actProcess: TAction;
    pnlMain: TPanel;
    lblTheme: TLabel;
    edbxTheme: TEdit;
    lblFrom: TLabel;
    edbxFrom: TEdit;
    lblWhen: TLabel;
    edbxWhen: TEdit;
    pnlButtons: TPanel;
    reMessage: TRichEdit;
    btnClose: TButton;
    btnHelp: TButton;
    btnProcess: TButton;
    btnDelete: TButton;
    btnPrevious: TButton;
    btnNext: TButton;
    procedure FormShow(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actPreviousExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actProcessExecute(Sender: TObject);
    procedure actHelpUpdate(Sender: TObject);
  strict private
    procedure _Help;
    procedure _Close;
    procedure _Delete;
    procedure _Next;
    procedure _Previous;
    procedure _Process;
  end;

implementation

{$R *.dfm}

uses
  OA5.uMainForm,
  CastersPackage.uRoutines,
  System.SysUtils;

resourcestring
  RsViewMessageForm = '��������� ����������� ���������';

const
  ICON_VIEWMESSAGE = 1;

procedure TViewMessageForm.FormCreate(Sender: TObject);
begin
  ProcedureHeader(RsEventHandlerOfFormCreation, '{6BC67F23-9F87-48D9-BEBC-C2C3EB02E4ED}');

  ImageList.GetIcon(ICON_VIEWMESSAGE, Icon);
  with MainForm.Configuration do
  begin
    // ��������� ���������� ���������������� � ������������ � ����������� ���������
    Log.UserName := MainForm.CurrentUser.Login;
    Log.AllowedTypes := KeepLogTypes;
    Log.Enabled := EnableLog;

    // ��������� ��������� ���� � ����������� �� ���������� ������������ ���������
    if ViewMessageFormPosition.bCenter then
    begin
      Position := poScreenCenter;
    end
    else
    begin
      Position := poDesigned;
      if ViewMessageFormPosition.x < Screen.WorkAreaLeft then
      begin
        Left := Screen.WorkAreaLeft;
      end
      else
      begin
        if ViewMessageFormPosition.x > Screen.WorkAreaLeft + Screen.WorkAreaWidth then
        begin
          Left := Screen.WorkAreaLeft + Screen.WorkAreaWidth - Width;
        end
        else
        begin
          Left := ViewMessageFormPosition.x;
        end;
      end;
      if ViewMessageFormPosition.y < Screen.WorkAreaTop then
      begin
        Top := Screen.WorkAreaTop;
      end
      else
      begin
        if ViewMessageFormPosition.y > Screen.WorkAreaTop + Screen.WorkAreaHeight then
        begin
          Top := Screen.WorkAreaTop + Screen.WorkAreaHeight - Height;
        end
        else
        begin
          Top := ViewMessageFormPosition.y;
        end;
      end;
    end;
  end;

  ProcedureFooter;
end;

procedure TViewMessageForm.FormShow(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfFormShowing, [RsViewMessageForm]), '{9BFE180F-1D7B-4070-AE05-291F6C449091}');
  Log.SendInfo(Format(RsWindowShowed, [RsViewMessageForm]));
  ProcedureFooter;
end;

procedure TViewMessageForm.actCloseExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actClose.Caption]), '{C51BD81D-B224-409C-9AE1-985C0263C371}');
  _Close;
  ProcedureFooter;
end;

procedure TViewMessageForm.actDeleteExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actDelete.Caption]), '{2E33FC92-7CA7-429D-B729-AACB73242320}');
  _Delete;
  ProcedureFooter;
end;

procedure TViewMessageForm.actHelpExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actHelp.Caption]), '{C6AC5679-39E1-4FD7-81E4-79CBE93831A5}');
  _Help;
  ProcedureFooter;
end;

procedure TViewMessageForm.actHelpUpdate(Sender: TObject);
var
  b: Boolean;
begin
  b := Application.HelpFile <> EmptyStr;
  if actHelp.Enabled <> b then
  begin
    ProcedureHeader(Format(RsEventHandlerOfActionUpdate, [actHelp.Caption]), '{ADE69D60-880D-463E-9776-5E197AD9212E}');
    actHelp.Enabled := b;
    Log.SendDebug('�������� "' + actHelp.Caption + '" ' + Routines.GetConditionalString(b, '�', '��') + '�������.');
    ProcedureFooter;
  end;
end;

procedure TViewMessageForm.actNextExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actNext.Caption]), '{646509D5-B6E4-4BA8-ACB1-D3FC3E7D6909}');
  _Next;
  ProcedureFooter;
end;

procedure TViewMessageForm.actPreviousExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actPrevious.Caption]), '{F1B8E1BE-3D35-4D60-A962-1C33B0E2140E}');
  _Previous;
  ProcedureFooter;
end;

procedure TViewMessageForm.actProcessExecute(Sender: TObject);
begin
  ProcedureHeader(Format(RsEventHandlerOfActionExecute, [actProcess.Caption]), '{DE989347-B026-45D2-B6BA-21A502C1F8F9}');
  _Process;
  ProcedureFooter;
end;

procedure TViewMessageForm._Close;
begin
  ProcedureHeader('��������� �������� ���������� ���� � ����������� mrClose', '{25E73E71-59EF-4E44-BCFE-482B953B7469}');

  ModalResult := mrClose;
  Log.SendInfo(Format(RsWindowClosedByUser, [RsViewMessageForm]));

  ProcedureFooter;
end;

procedure TViewMessageForm._Delete;
begin
  ProcedureHeader('��������� �������� �������� ���������', '{876CA1BB-200F-4922-9D2D-59FBCB5A2506}');

  { TODO : �������� }

  ProcedureFooter;
end;

procedure TViewMessageForm._Help;
begin
  ProcedureHeader(RsContextHelpProcedure, '{BD937891-4495-4529-8E8B-A630DCD93E12}');

  Log.SendInfo(RsTryingToOpenHelpFile);
  if (FileExists(ExpandFileName(Application.HelpFile))) then
  begin
    Application.HelpContext(HelpContext);
  end
  else
  begin
    GenerateError(RsHelpFileNonFound);
  end;

  ProcedureFooter;
end;

procedure TViewMessageForm._Next;
begin
  ProcedureHeader('��������� �������� � ��������� ���������', '{CEC95D15-EAE9-4A73-850C-62F7230F1813}');

  { TODO : �������� }

  ProcedureFooter;
end;

procedure TViewMessageForm._Previous;
begin
  ProcedureHeader('��������� �������� � ����������� ���������', '{493DAAC0-4DF7-479A-84AB-7E4D79758C31}');

  { TODO : �������� }

  ProcedureFooter;
end;

procedure TViewMessageForm._Process;
begin
  ProcedureHeader('��������� ������� ��������� ��� ������������', '{DAA1A662-2261-4B3A-B4F7-04A1BCEAEE09}');

  { TODO : �������� }

  ProcedureFooter;
end;

end.
