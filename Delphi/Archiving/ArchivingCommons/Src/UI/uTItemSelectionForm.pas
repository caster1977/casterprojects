unit uTItemSelectionForm;

interface

uses
  Controls,
  Forms,
  CheckLst,
  StdCtrls,
  Classes,
  ExtCtrls,
  Actions,
  ActnList,
  DB,
  ImgList;

type
  TItemSelectionForm = class(TForm)
    pnlBottom: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    clbList: TCheckListBox;
    ActionList: TActionList;
    actApply: TAction;
    actCancel: TAction;
    ImageList: TImageList;
    btnPreviousPage: TButton;
    btnNextPage: TButton;
    actSelectAll: TAction;
    actSelectNone: TAction;
    procedure actCancelExecute(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actSelectNoneExecute(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);
    procedure actSelectAllUpdate(Sender: TObject);
    procedure actSelectNoneUpdate(Sender: TObject);
  private
    FConnection: TCustomConnection;
    FStoredProcName: string;
    FResultTableName: string;
    FInitialStates: array of Boolean;
    procedure SetCaptions;
    procedure FillList;
  public
    constructor Create(const AConnection: TCustomConnection; const ACaption, AStoredProcName, AResultTableName: string);
      reintroduce;
  end;

function ShowItemSelectionForm(const AConnection: TCustomConnection;
  const ACaption, AStoredProcName, AResultTableName: string): TModalResult;

implementation

{$R *.dfm}

uses
  uArchivingCommonConsts,
  uArchivingCommonRoutines,
  SysUtils,
  AnsiStrings,
  Dialogs;

resourcestring
  RsAConnectionIsNil = 'AConnection is nil';
  RsAStoredProcNameIsEmptyStr = 'AStoredProcName is EmptyStr';
  RsAResultTableNameIsEmptyStr = 'AResultTableName is EmptyStr';
  RsWrongAResultTableName = 'Wrong AResultTableName';
  RsApply = '&Применить';
  RsCancel = '&Отмена';
  RsAddObjectError = 'Не удалось создать элемент списка.';

function ShowItemSelectionForm(const AConnection: TCustomConnection;
  const ACaption, AStoredProcName, AResultTableName: string): TModalResult;
var
  form: TItemSelectionForm;
begin
  Result := mrNone;
  form := TItemSelectionForm.Create(AConnection, ACaption, AStoredProcName, AResultTableName);
  try
    Result := form.ShowModal;
  finally
    form.Free;
  end;
end;

procedure TItemSelectionForm.actApplyExecute(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TItemSelectionForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

constructor TItemSelectionForm.Create(const AConnection: TCustomConnection;
  const ACaption, AStoredProcName, AResultTableName: string);
begin
  inherited Create(Application.MainForm);
  Assert(Assigned(AConnection), RsAConnectionIsNil);
  Assert(Trim(AStoredProcName) > EmptyStr, RsAStoredProcNameIsEmptyStr);
  Assert(Trim(AResultTableName) > EmptyStr, RsAResultTableNameIsEmptyStr);
  Assert(LeftStr(Trim(AResultTableName), 4) = CONST_TMP_TABLE_PREFIX, RsWrongAResultTableName);
  Caption := ACaption;
  FConnection := AConnection;
  FStoredProcName := AStoredProcName;
  FResultTableName := AResultTableName;
  SetCaptions;
  FillList;
end;

procedure TItemSelectionForm.FillList;
var
  ds: TDataSet;
  i: Integer;
  name: string;
  id: Integer;
  chk: Boolean;
begin
  if Assigned(FConnection) then
  begin
    ds := GetQuery(FConnection);
    if Assigned(ds) then
    begin
      try
        SetSQLForQuery(ds, FStoredProcName, True);
        try
          clbList.Items.BeginUpdate;
          try
            clbList.Items.Clear;
            SetLength(FInitialStates, 0);
            while not ds.Eof do
            begin
              name := ds.FieldValues[CONST_NAME];
              id := ds.FieldValues[CONST_ID];
              i := clbList.Items.AddObject(name, Pointer(id));
              SetLength(FInitialStates, Length(FInitialStates) + 1);
              if i < 0 then
              begin
                ShowMessage(RsAddObjectError);
                ModalResult := mrCancel;
              end
              else
              begin
                chk := ds.FieldValues['Checked'{CONST_CHECKED}];
                clbList.Checked[i] := chk;
                FInitialStates[i] := chk;
                ds.Next;
              end;
            end;
          finally
            clbList.Items.EndUpdate;
          end;
        finally
          ds.Close;
        end;
      finally
        FreeAndNil(ds);
      end;
    end;
  end;
end;

procedure TItemSelectionForm.SetCaptions;
begin
  actApply.Caption := RsApply;
  actCancel.Caption := RsCancel;
end;

procedure TItemSelectionForm.actSelectAllExecute(Sender: TObject);
begin
  clbList.CheckAll(cbChecked);
end;

procedure TItemSelectionForm.actSelectAllUpdate(Sender: TObject);
var
  i: Integer;
  b: Boolean;
begin
  b := False;
  for i := 0 to clbList.Items.Count - 1 do
  begin
    if not clbList.Checked[i] then
    begin
      b := True;
      Break;
    end;
  end;
  if not actSelectAll.Enabled = b then
  begin
    actSelectAll.Enabled := b;
  end;
end;

procedure TItemSelectionForm.actSelectNoneExecute(Sender: TObject);
begin
  clbList.CheckAll(cbUnchecked);
end;

procedure TItemSelectionForm.actSelectNoneUpdate(Sender: TObject);
var
  i: Integer;
  b: Boolean;
begin
  b := False;
  for i := 0 to clbList.Items.Count - 1 do
  begin
    if clbList.Checked[i] then
    begin
      b := True;
      Break;
    end;
  end;
  if not actSelectNone.Enabled = b then
  begin
    actSelectNone.Enabled := b;
  end;
end;

end.
