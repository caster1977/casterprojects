unit DBAutoTest.uTTaskForm;

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
  System.Actions,
  Vcl.ActnList,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  DBAutoTest.uConsts,
  DBAutoTest.uITask,
  DBAutoTest.uITasks,
  Vcl.StdActns,
  CastersPackage.Actions.Classes;

type
  TTaskForm = class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    pnlTop: TPanel;
    meSQL: TMemo;
    lblGroup: TLabel;
    cmbGroup: TComboBox;
    lblName: TLabel;
    cmbName: TComboBox;
    lblSQL: TLabel;
    ActionList: TActionList;
    btnClear: TButton;
    btnHelp: TButton;
    actCancel: TAction;
    actApply: TAction;
    actClear: TAction;
    actHelp: TAction_Help;
    procedure actClearUpdate(Sender: TObject);
    procedure actApplyUpdate(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
  strict private
    FTaskEnabled: Boolean;
    FTasks: ITasks;
    FTaskIndex: Integer;
    function GetTaskGroup: string;
    procedure SetTaskGroup(const AValue: string);
    function GetTaskName: string;
    procedure SetTaskName(const AValue: string);
    function GetTaskSQL: TStringList;
    procedure SetTaskSQL(const AValue: TStringList);
    function GetTaskEnabled: Boolean;
    procedure SetTaskEnabled(const AValue: Boolean);
    function GetTasks: ITasks;
    function GetTaskIndex: Integer;
    property Tasks: ITasks read GetTasks nodefault;
    property TaskGroup: string read GetTaskGroup write SetTaskGroup nodefault;
    property TaskName: string read GetTaskName write SetTaskName nodefault;
    property TaskSQL: TStringList read GetTaskSQL write SetTaskSQL default DEFAULT_TASK_SQL;
    property TaskEnabled: Boolean read GetTaskEnabled write SetTaskEnabled
      default DEFAULT_TASK_ENABLED;
  public
    constructor Create(AOwner: TComponent; const ATasks: ITasks; const AIndex: Integer = -1);
      reintroduce; virtual;
    property TaskIndex: Integer read GetTaskIndex nodefault;
  end;

implementation

{$R *.dfm}

uses
  DBAutoTest.uTTask,
  DBAutoTest.uETasks;

resourcestring
  RsAddTaskCaption = '���������� �����';
  RsEditTaskCaption = '�������������� �����';
  RsATasksIsNil = 'ATasks is nil.';
  RsWrongAIndexValue = 'Wrong AIndex value (%d).';
  RsITaskIsNil = 'ITask is nil.';
  RsCantAddTaskToTasks = '�� ������� �������� ���� � ������ ������.';

procedure TTaskForm.actApplyExecute(Sender: TObject);
var
  task: ITask;
  i: Integer;
begin
  if TaskIndex = -1 then
  begin
    task := GetITask;
    i := Tasks.Add(task);
    if i < 0 then
    begin
      raise ETasks.Create(RsCantAddTaskToTasks);
    end
    else
    begin
      FTaskIndex := i;
    end;
  end
  else
  begin
    task := Tasks[TaskIndex];
  end;
  task.Group := TaskGroup;
  task.Name := TaskName;
  task.SQL := TaskSQL;
  task.Enabled := TaskEnabled;
  ModalResult := mrOk;
end;

procedure TTaskForm.actApplyUpdate(Sender: TObject);
begin
  actApply.Enabled := (TaskGroup <> EmptyStr) and (TaskName <> EmptyStr) and
    (TaskSQL.Text <> EmptyStr);
end;

procedure TTaskForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TTaskForm.actClearExecute(Sender: TObject);
begin
  TaskGroup := EmptyStr;
  TaskName := EmptyStr;
  TaskSQL.Clear;
end;

procedure TTaskForm.actClearUpdate(Sender: TObject);
begin
  actClear.Enabled := (TaskGroup <> EmptyStr) and (TaskName <> EmptyStr) and
    (TaskSQL.Text <> EmptyStr);
end;

constructor TTaskForm.Create(AOwner: TComponent; const ATasks: ITasks; const AIndex: Integer);
  procedure FillGroups;
  var
    i: Integer;
    s: string;
  begin
    cmbGroup.Items.BeginUpdate;
    try
      cmbGroup.Items.Clear;
      for i := 0 to Tasks.Count - 1 do
      begin
        s := Tasks[i].Group;
        if cmbGroup.Items.IndexOf(s) < 0 then
        begin
          cmbGroup.Items.Append(s);
        end;
      end;
    finally
      cmbGroup.Items.EndUpdate;
    end;
  end;

  procedure FillNames;
  var
    i: Integer;
    s: string;
  begin
    cmbName.Items.BeginUpdate;
    try
      cmbName.Items.Clear;
      for i := 0 to Tasks.Count - 1 do
      begin
        s := Tasks[i].Name;
        if cmbName.Items.IndexOf(s) < 0 then
        begin
          cmbName.Items.Append(s);
        end;
      end;
    finally
      cmbName.Items.EndUpdate;
    end;
  end;

var
  task: ITask;
begin
  Assert(Assigned(ATasks), RsATasksIsNil);
  Assert((AIndex >= -1) and (AIndex < ATasks.Count), Format(RsWrongAIndexValue, [AIndex]));
  if AIndex > -1 then
  begin
    Assert(Assigned(ATasks[AIndex]), RsITaskIsNil);
  end;
  inherited Create(AOwner);
  FTasks := ATasks;
  FTaskIndex := AIndex;
  FillGroups;
  FillNames;
  if TaskIndex = -1 then
  begin
    Caption := RsAddTaskCaption;
    TaskGroup := DEFAULT_TASK_GROUP;
    TaskName := DEFAULT_TASK_NAME;
    TaskSQL := DEFAULT_TASK_SQL;
    TaskEnabled := DEFAULT_TASK_ENABLED;
  end
  else
  begin
    Caption := RsEditTaskCaption;
    task := Tasks[TaskIndex];
    TaskGroup := task.Group;
    TaskName := task.Name;
    TaskSQL := task.SQL;
    TaskEnabled := task.Enabled;
  end;
end;

function TTaskForm.GetTaskEnabled: Boolean;
begin
  Result := FTaskEnabled;
end;

function TTaskForm.GetTaskGroup: string;
var
  i: Integer;
begin
  Result := Trim(cmbGroup.Text);
  i := cmbGroup.ItemIndex;
  if i > -1 then
  begin
    Result := Trim(cmbGroup.Items[i]);
  end;
end;

function TTaskForm.GetTasks: ITasks;
begin
  Result := FTasks;
end;

function TTaskForm.GetTaskIndex: Integer;
begin
  Result := FTaskIndex;
end;

function TTaskForm.GetTaskName: string;
var
  i: Integer;
begin
  Result := Trim(cmbName.Text);
  i := cmbName.ItemIndex;
  if i > -1 then
  begin
    Result := Trim(cmbName.Items[i]);
  end;
end;

function TTaskForm.GetTaskSQL: TStringList;
begin
  Result := TStringList.Create;
  Result.AddStrings(meSQL.Lines);
end;

procedure TTaskForm.SetTaskEnabled(const AValue: Boolean);
begin
  if FTaskEnabled <> AValue then
  begin
    FTaskEnabled := AValue;
  end;
end;

procedure TTaskForm.SetTaskGroup(const AValue: string);
var
  s: string;
  i: Integer;
begin
  s := Trim(AValue);
  i := cmbGroup.Items.IndexOf(s);
  if i = -1 then
  begin
    i := cmbGroup.Items.Add(s);
  end;
  cmbGroup.ItemIndex := i;
end;

procedure TTaskForm.SetTaskName(const AValue: string);
var
  s: string;
  i: Integer;
begin
  s := Trim(AValue);
  i := cmbName.Items.IndexOf(s);
  if i = -1 then
  begin
    i := cmbName.Items.Add(s);
  end;
  cmbName.ItemIndex := i;
end;

procedure TTaskForm.SetTaskSQL(const AValue: TStringList);
begin
  if meSQL.Lines <> AValue then
  begin
    meSQL.Lines.BeginUpdate;
    try
      meSQL.Lines.Clear;
      if Assigned(AValue) then
      begin
        meSQL.Lines.AddStrings(AValue);
      end;
    finally
      meSQL.Lines.EndUpdate;
    end;
  end;
end;

end.