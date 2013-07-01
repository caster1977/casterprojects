unit DBAutoTest.uTRecentsPropertiesForm;

interface

uses
  CastersPackage.Actions.Classes,
  DBAutoTest.uIRecents,
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
  Vcl.ComCtrls,
  Vcl.StdActns,
  System.Actions,
  Vcl.ActnList,
  Vcl.Samples.Spin,
  Vcl.Menus;

type
  TRecentsPropertiesForm = class(TForm)
    ActionList: TActionList;
    actCancel: TAction;
    actApply: TAction;
    actClear: TAction;
    actHelp: TAction_Help;
    actDelete: TAction;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    lvRecentsList: TListView;
    pnlTop: TPanel;
    lblRecentsListSize: TLabel;
    lblRecentsList: TLabel;
    seRecentsSize: TSpinEdit;
    pnlBottom: TPanel;
    btnClear: TButton;
    Bevel1: TBevel;
    btnDelete: TButton;
    btnDeleteNotExists: TButton;
    actDeleteNotExists: TAction;
    lblSizeHint: TLabel;
    pmRecentList: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    actSelectAll: TAction;
    actSelectAll1: TMenuItem;
    procedure actCancelExecute(Sender: TObject);
    procedure seRecentsSizeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actApplyUpdate(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actClearUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actDeleteNotExistsExecute(Sender: TObject);
    procedure actDeleteNotExistsUpdate(Sender: TObject);
    procedure seRecentsSizeExit(Sender: TObject);
    procedure lvRecentsListCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure actSelectAllUpdate(Sender: TObject);
    procedure actSelectAllExecute(Sender: TObject);

  strict private
    procedure RefreshRecentsList;
  public
    constructor Create(AOwner: TComponent; const ARecents: IRecents; const ASize: Integer); reintroduce; virtual;

  strict private
    FOriginalRecents: IRecents;
    function GetOriginalRecents: IRecents;
    property OriginalRecents: IRecents read GetOriginalRecents nodefault;

  strict private
    FOriginalSize: Integer;
    function GetOriginalSize: Integer;
    property OriginalSize: Integer read GetOriginalSize nodefault;

  strict private
    FRecents: IRecents;
    function GetRecents: IRecents;
    property Recents: IRecents read GetRecents nodefault;

  strict private
    function GetSize: Integer;
    procedure SetSize(const AValue: Integer);
  public
    property Size: Integer read GetSize write SetSize nodefault;
  end;

implementation

{$R *.dfm}

uses
  DBAutoTest.uTRecents,
  DBAutoTest.uIRecent;

resourcestring
  RsARecentsIsNil = 'ARecents is nil.';
  RsSizeHint = '(%d - %d)';
  RsEnterNumber = '¬ведите число от %d до %d';

procedure TRecentsPropertiesForm.actApplyExecute(Sender: TObject);
var
  i: Integer;
begin
  if Assigned(OriginalRecents) then
  begin
    OriginalRecents.Clear;
    if Assigned(Recents) then
    begin
      for i := 0 to Size - 1 do
      begin
        if i > Recents.Count - 1 then
        begin
          Break;
        end;
        OriginalRecents.Add(Recents[i]);
      end;
    end;
  end;
  ModalResult := mrOk;
end;

procedure TRecentsPropertiesForm.actApplyUpdate(Sender: TObject);
begin
  actApply.Enabled := (not Recents.Equals(OriginalRecents)) or (Size <> OriginalSize);
  btnApply.Default := actApply.Enabled;
  btnCancel.Default := not actApply.Enabled;
end;

procedure TRecentsPropertiesForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TRecentsPropertiesForm.actClearExecute(Sender: TObject);
begin
  Recents.Clear;
  RefreshRecentsList;
end;

procedure TRecentsPropertiesForm.actClearUpdate(Sender: TObject);
begin
  actClear.Enabled := lvRecentsList.Items.Count > 0;
end;

procedure TRecentsPropertiesForm.actDeleteExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := lvRecentsList.Items.Count - 1 downto 0 do
  begin
    if lvRecentsList.Items[i].Selected then
    begin
      Recents.Remove(IRecent(lvRecentsList.Items[i].Data));
    end;
  end;
  RefreshRecentsList;
end;

procedure TRecentsPropertiesForm.actDeleteNotExistsExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := Recents.Count - 1 downto 0 do
  begin
    if not Recents[i].Exists then
    begin
      Recents.Delete(i);
    end;
  end;
  RefreshRecentsList;
end;

procedure TRecentsPropertiesForm.actDeleteNotExistsUpdate(Sender: TObject);
var
  i: Integer;
  b: Boolean;
begin
  b := False;
  for i := 0 to Recents.Count - 1 do
  begin
    if not Recents[i].Exists then
    begin
      b := True;
      Break;
    end;
  end;
  actDeleteNotExists.Enabled := b;
end;

procedure TRecentsPropertiesForm.actDeleteUpdate(Sender: TObject);
begin
  actDelete.Enabled := lvRecentsList.SelCount > 0;
end;

procedure TRecentsPropertiesForm.actSelectAllExecute(Sender: TObject);
begin
  lvRecentsList.SelectAll;
end;

procedure TRecentsPropertiesForm.actSelectAllUpdate(Sender: TObject);
begin
  actSelectAll.Enabled := lvRecentsList.Items.Count > 0;
end;

function TRecentsPropertiesForm.GetOriginalRecents: IRecents;
begin
  Result := FOriginalRecents;
end;

function TRecentsPropertiesForm.GetSize: Integer;
begin
  Result := seRecentsSize.Value;
end;

procedure TRecentsPropertiesForm.lvRecentsListCustomDrawItem(Sender: TCustomListView; Item: TListItem; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  lvRecentsList.Canvas.Font.Color := clBlack;
  if Assigned(Item.Data) then
  begin
    if not IRecent(Item.Data).Exists then
    begin
      lvRecentsList.Canvas.Font.Color := clGray;
    end;
  end;
end;

function TRecentsPropertiesForm.GetRecents: IRecents;
begin
  if not Assigned(FRecents) then
  begin
    FRecents := GetIRecents;
    if Assigned(OriginalRecents) then
    begin
      FRecents.Assign(OriginalRecents);
    end;
  end;
  Result := FRecents;
end;

procedure TRecentsPropertiesForm.RefreshRecentsList;
  procedure ResizeColumn;
  begin
    lvRecentsList.Column[0].Width := lvRecentsList.Width - (lvRecentsList.BevelWidth * 2) - 2;
    lvRecentsList.FlatScrollBars := False;
    lvRecentsList.FlatScrollBars := True;
    if (GetWindowLong(lvRecentsList.Handle, GWL_STYLE) and WS_VSCROLL) = WS_VSCROLL then
    begin
      lvRecentsList.Column[0].Width := lvRecentsList.Column[0].Width - GetSystemMetrics(SM_CXVSCROLL);
    end;
  end;

var
  i: Integer;
  r: IRecent;
  node: TListItem;
begin
  lvRecentsList.Items.BeginUpdate;
  try
    lvRecentsList.Items.Clear;
    if Assigned(Recents) then
    begin
      for i := 0 to Size - 1 do
      begin
        if i > Recents.Count - 1 then
        begin
          Break;
        end;
        r := Recents.Items[i];
        if Assigned(r) then
        begin
          node := lvRecentsList.Items.Add;
          node.Data := Pointer(r);
          node.Caption := r.FullName;
        end;
      end;
    end;
    ResizeColumn;
  finally
    lvRecentsList.Items.EndUpdate;
  end;
end;

procedure TRecentsPropertiesForm.seRecentsSizeExit(Sender: TObject);
begin
  seRecentsSize.Value := Size;
end;

procedure TRecentsPropertiesForm.seRecentsSizeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      begin
        actCancel.Execute;
      end;
    VK_RETURN:
      begin
        if actApply.Enabled then
        begin
          actApply.Execute;
        end
        else
        begin
          actCancel.Execute;
        end;
      end;
  end;
end;

procedure TRecentsPropertiesForm.SetSize(const AValue: Integer);
var
  i: Integer;
begin
  i := AValue;
  if i > seRecentsSize.MaxValue then
  begin
    i := seRecentsSize.MaxValue;
  end;
  if i < seRecentsSize.MinValue then
  begin
    i := seRecentsSize.MinValue;
  end;
  if seRecentsSize.Value <> i then
  begin
    seRecentsSize.Value := i;
  end;
end;

function TRecentsPropertiesForm.GetOriginalSize: Integer;
begin
  Result := FOriginalSize;
end;

constructor TRecentsPropertiesForm.Create(AOwner: TComponent; const ARecents: IRecents; const ASize: Integer);
begin
  Assert(Assigned(ARecents), RsARecentsIsNil);
  inherited Create(AOwner);
  FOriginalRecents := ARecents;
  FOriginalSize := ASize;
  Size := OriginalSize;
  lblSizeHint.Caption := Format(RsSizeHint, [seRecentsSize.MinValue, seRecentsSize.MaxValue]);
  seRecentsSize.Hint := Format(RsEnterNumber, [seRecentsSize.MinValue, seRecentsSize.MaxValue]);
  RefreshRecentsList;
end;

end.
