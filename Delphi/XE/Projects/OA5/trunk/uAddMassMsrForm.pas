unit uAddMassMsrForm;

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
  ComCtrls,
  ImgList,
  uLogProvider,
  PlatformDefaultStyleActnCtrls,
  ActnList,
  ActnMan;

type
  TAddMassMsrForm=class(TForm)
    pnlButtons: TPanel;
    btnAccept: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    Panel1: TPanel;
    Panel3: TPanel;
    lblPeriod: TLabel;
    MonthCalendar1: TMonthCalendar;
    Label1: TLabel;
    Bevel1: TBevel;
    Panel2: TPanel;
    Edit1: TEdit;
    Button1: TButton;
    ListView1: TListView;
    Button2: TButton;
    Button3: TButton;
    ActionManager1: TActionManager;
    Log: TLogProvider;
    ilAddMassMsrFormSmallImages: TImageList;
    Action_Help: TAction;
    Action_Add: TAction;
    Action_Delete: TAction;
    Action_Clear: TAction;
    Action_Close: TAction;
    Action_Confirm: TAction;
    procedure FormCreate(Sender: TObject);
  strict private
    procedure ProcedureHeader(aTitle, aLogGroupGUID: string);
    procedure ProcedureFooter;
  end;

var
  AddMassMsrForm: TAddMassMsrForm;

implementation

{$R *.dfm}

uses
  uMainForm;

procedure TAddMassMsrForm.FormCreate(Sender: TObject);
const
  ICON_ADDMASSMSR=5;
begin
  ProcedureHeader('Процедура-обработчик события создания окна', '{6CE0EB9F-9EDA-47A9-B181-9D02DA831366}');

  ilAddMassMsrFormSmallImages.GetIcon(ICON_ADDMASSMSR, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';

  ProcedureFooter;
end;

procedure TAddMassMsrForm.ProcedureHeader(aTitle, aLogGroupGUID: string);
begin
  Log.EnterMethod(aTitle, aLogGroupGUID);
  MainForm.Inc_BusyState;
  Application.ProcessMessages;
end;

procedure TAddMassMsrForm.ProcedureFooter;
begin
  MainForm.Dec_BusyState;
  Log.ExitMethod;
  Application.ProcessMessages;
end;

end.
