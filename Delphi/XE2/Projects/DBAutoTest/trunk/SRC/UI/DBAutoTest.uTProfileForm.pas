unit DBAutoTest.uTProfileForm;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.StdActns,
  CastersPackage.Actions.Classes,
  System.Actions,
  Vcl.ActnList,
  Data.DB,
  Data.Win.ADODB,
  Vcl.Mask,
  Vcl.ComCtrls,
  Vcl.ImgList;

type
  TProfileForm = class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    btnDefaults: TButton;
    btnHelp: TButton;
    ActionList: TActionList;
    actApply: TAction;
    actCancel: TAction;
    actHelp: TAction_Help;
    gbConnection: TGroupBox;
    lblServerName: TLabel;
    cmbServerName: TComboBox;
    lblDatabaseName: TLabel;
    cmbDatabaseName: TComboBox;
    lblLogin: TLabel;
    lblPassword: TLabel;
    ebLogin: TEdit;
    mePassword: TMaskEdit;
    ADOConnection: TADOConnection;
    rbWinNTSecurity: TRadioButton;
    lblSecurity: TLabel;
    rbLoginAndPassword: TRadioButton;
    btnTestConnection: TButton;
    actTestConnection: TAction;
    cbUseEmptyPassword: TCheckBox;
    cbAllowPasswordSaving: TCheckBox;
    actUseWinNTSecurity: TAction;
    gbTop: TGroupBox;
    cmbPageName: TComboBox;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    PageControl: TPageControl;
    tsConnection: TTabSheet;
    ImageList: TImageList;
    actDefaults: TAction_Defaults;
    actPreviousPage: TAction_PreviousPage;
    actNextPage: TAction_NextPage;
    pnlTop: TPanel;
    actUseLoginAndPassword: TAction;
    actAllowPasswordSaving: TAction;
    actUseEmptyPassword: TAction;
    procedure actUseWinNTSecurityExecute(Sender: TObject);
    procedure actAllowPasswordSavingUpdate(Sender: TObject);
    procedure actUseEmptyPasswordUpdate(Sender: TObject);
    procedure actUseLoginAndPasswordExecute(Sender: TObject);
    procedure actUseEmptyPasswordExecute(Sender: TObject);
    procedure actAllowPasswordSavingExecute(Sender: TObject);
    procedure cmbServerNameChange(Sender: TObject);
    procedure cmbServerNameDropDown(Sender: TObject);
    procedure cmbServerNameSelect(Sender: TObject);
    procedure cmbServerNameKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actCancelExecute(Sender: TObject);
  private
    procedure GetServerList(const aList: TStrings);
    procedure GetDatabasesList(const aList: TStrings);
  end;

implementation

{$R *.dfm}

uses
  CastersPackage.UNetSrvList,
  DBAutoTest.uConsts;

procedure TProfileForm.actAllowPasswordSavingExecute(Sender: TObject);
begin
  //
end;

procedure TProfileForm.actAllowPasswordSavingUpdate(Sender: TObject);
begin
  actAllowPasswordSaving.Enabled := actUseLoginAndPassword.Checked;
end;

procedure TProfileForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TProfileForm.actUseEmptyPasswordExecute(Sender: TObject);
begin
  //
end;

procedure TProfileForm.actUseEmptyPasswordUpdate(Sender: TObject);
begin
  actUseEmptyPassword.Enabled := actUseLoginAndPassword.Checked;
end;

procedure TProfileForm.actUseLoginAndPasswordExecute(Sender: TObject);
begin
  lblLogin.Enabled := True;
  ebLogin.Enabled := True;
  lblPassword.Enabled := True;
  mePassword.Enabled := True;
end;

procedure TProfileForm.actUseWinNTSecurityExecute(Sender: TObject);
begin
  lblLogin.Enabled := False;
  ebLogin.Enabled := False;
  lblPassword.Enabled := False;
  mePassword.Enabled := False;
end;

procedure TProfileForm.cmbServerNameChange(Sender: TObject);
begin
  lblDatabaseName.Enabled := (Trim(cmbServerName.Text) > EmptyStr) or
    (cmbServerName.ItemIndex > -1);
  cmbDatabaseName.Enabled := lblDatabaseName.Enabled;
end;

procedure TProfileForm.cmbServerNameDropDown(Sender: TObject);
begin
  GetServerList(cmbServerName.Items);
end;

procedure TProfileForm.cmbServerNameKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    GetDatabasesList(cmbDatabaseName.Items);
  end;
end;

procedure TProfileForm.cmbServerNameSelect(Sender: TObject);
begin
  GetDatabasesList(cmbDatabaseName.Items);
  lblDatabaseName.Enabled := (Trim(cmbServerName.Text) > EmptyStr) or
    (cmbServerName.ItemIndex > -1);
  cmbDatabaseName.Enabled := lblDatabaseName.Enabled;
end;

procedure TProfileForm.GetServerList(const aList: TStrings);
var
  aSrvs: IServerList;
  i: Integer;
begin
  aList.BeginUpdate;
  try
    aList.Clear;
    aSrvs := MakeServerList('', '', SV_TYPE_SQLSERVER);
    for i := 0 to aSrvs.Count - 1 do
      aList.AddObject(aSrvs[i].Svr_Name, TObject(aSrvs[i].svr_Type));
  finally
    aList.EndUpdate;
  end;
end;

procedure TProfileForm.GetDatabasesList(const aList: TStrings);
var
  q: TADOQuery;
  s: string;
begin
  aList.BeginUpdate;
  try
    if cmbServerName.ItemIndex > -1 then
    begin
      s := cmbServerName.Items[cmbServerName.ItemIndex];
    end
    else
    begin
      s := cmbServerName.Text;
    end;
    ADOConnection.ConnectionString := Format(ADO_CONNECTION_STRING_PREFIX, [s]);
    if actUseWinNTSecurity.Checked then
    begin
      ADOConnection.ConnectionString := ADOConnection.ConnectionString +
        ADO_CONNECTION_STRING_SUFFIX_INTEGRATED_SECURITY;
    end
    else
    begin
      ADOConnection.ConnectionString := ADOConnection.ConnectionString +
        Format(ADO_CONNECTION_STRING_SUFFIX_USER_ID, [ebLogin.Text]);
      ADOConnection.ConnectionString := ADOConnection.ConnectionString +
        Format(ADO_CONNECTION_STRING_SUFFIX_PERSIST_SECURITY_INFO,
        [BoolToStr(actAllowPasswordSaving.Checked, True)]);
      if actAllowPasswordSaving.Checked then
      begin
        ADOConnection.ConnectionString := ADOConnection.ConnectionString +
          Format(ADO_CONNECTION_STRING_SUFFIX_PASSWORD, [mePassword.Text]);
      end;
    end;

    ADOConnection.Connected := True;
    try
      q := TADOQuery.Create(Self);
      try
        q.Connection := ADOConnection;
        aList.Clear;
        q.SQL.Text :=
          'SELECT sd.name FROM sys.databases sd WHERE  HAS_DBACCESS(sd.name) = 1 ORDER BY sd.name';
        q.Open;
        while not q.Eof do
        begin
          aList.Add(q.Fields[0].AsString);
          q.Next;
        end;
      finally
        q.Close;
        FreeAndNil(q);
      end;
    finally
      ADOConnection.Connected := False;
    end;
  finally
    aList.EndUpdate;
  end;
end;

end.
