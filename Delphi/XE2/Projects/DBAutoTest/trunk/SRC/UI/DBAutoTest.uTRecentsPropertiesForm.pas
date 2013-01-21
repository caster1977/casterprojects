unit DBAutoTest.uTRecentsPropertiesForm;

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
  Vcl.ComCtrls,
  Vcl.StdActns,
  CastersPackage.Actions.Classes,
  System.Actions,
  Vcl.ActnList,
  Vcl.Samples.Spin,
  DBAutoTest.uIRecents;

type
  TRecentsPropertiesForm=class(TForm)
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
    seRecentsListSize: TSpinEdit;
    pnlBottom: TPanel;
    btnClear: TButton;
    Bevel1: TBevel;
    Button1: TButton;
    btnDeleteNotExists: TButton;
    actDeleteNotExists: TAction;
    procedure actCancelExecute(Sender: TObject);
    procedure seRecentsListSizeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure actApplyUpdate(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actClearExecute(Sender: TObject);
    procedure actClearUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actDeleteNotExistsExecute(Sender: TObject);
    procedure actDeleteNotExistsUpdate(Sender: TObject);
  strict private
    FOriginalRecentsListSize: Integer;
    FOriginalRecents: IRecents;
    FRecents: IRecents;
    function GetOriginalRecents: IRecents;
    function GetOriginalRecentsListSize: Integer;
    function GetRecents: IRecents;
    procedure RefreshRecentsList;
    property OriginalRecentsListSize: Integer read GetOriginalRecentsListSize nodefault;
    property OriginalRecents: IRecents read GetOriginalRecents nodefault;
    property Recents: IRecents read GetRecents nodefault;
  public
    constructor Create(AOwner: TComponent; const ARecents: IRecents; const ARecentsListSize: Integer); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses
  DBAutoTest.uTRecents,
  DBAutoTest.uIRecent;

resourcestring
  RsARecentsIsNil='ARecents is nil.';

procedure TRecentsPropertiesForm.actApplyExecute(Sender: TObject);
begin
  if Assigned(OriginalRecents) then
    begin
      OriginalRecents.Clear;
      if Assigned(Recents) then
        begin
          OriginalRecents.Append(Recents);
        end;
    end;
  ModalResult:=mrOk;
end;

procedure TRecentsPropertiesForm.actApplyUpdate(Sender: TObject);
begin
  actApply.Enabled:=Recents.Equals(OriginalRecents);
  btnApply.Default:=actApply.Enabled;
end;

procedure TRecentsPropertiesForm.actCancelExecute(Sender: TObject);
begin
  ModalResult:=mrCancel;
end;

procedure TRecentsPropertiesForm.actClearExecute(Sender: TObject);
begin
  Recents.Clear;
  RefreshRecentsList;
end;

procedure TRecentsPropertiesForm.actClearUpdate(Sender: TObject);
begin
  actClear.Enabled:=lvRecentsList.Items.Count>0;
end;

procedure TRecentsPropertiesForm.actDeleteExecute(Sender: TObject);
var
  i: Integer;
begin
  for i:=lvRecentsList.Items.Count-1 to 0 do
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
  for i:=Recents.Count-1 downto 0 do
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
  b:=False;
  for i:=0 to Recents.Count-1 do
    begin
      if not Recents[i].Exists then
        begin
          b:=True;
          Break;
        end;
    end;
  actDeleteNotExists.Enabled:=b;
end;

procedure TRecentsPropertiesForm.actDeleteUpdate(Sender: TObject);
begin
  actDelete.Enabled:=lvRecentsList.SelCount>0;
end;

function TRecentsPropertiesForm.GetOriginalRecents: IRecents;
begin
  Result:=FOriginalRecents;
end;

function TRecentsPropertiesForm.GetOriginalRecentsListSize: Integer;
begin
  Result := FOriginalRecentsListSize;
end;

function TRecentsPropertiesForm.GetRecents: IRecents;
begin
  // если список не был создан
  if not Assigned(FRecents) then
    begin
      // создаём список
      FRecents:=GetIRecents;
      // и если оригинальный список создан
      if Assigned(OriginalRecents) then
        begin
          // копируем все элементы их оригинального списка
          FRecents.Append(OriginalRecents);
        end;
    end;
  Result:=FRecents;
end;

procedure TRecentsPropertiesForm.RefreshRecentsList;
begin

end;

procedure TRecentsPropertiesForm.seRecentsListSizeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    begin
      actCancel.Execute;
    end;
end;

constructor TRecentsPropertiesForm.Create(AOwner: TComponent; const ARecents: IRecents; const ARecentsListSize: Integer);
begin
  // Assert(Assigned(ARecents), RsARecentsIsNil);
  inherited Create(AOwner);
  FOriginalRecentsListSize := ARecentsListSize;
  FOriginalRecents:=ARecents;
end;

  { TODO : добавить проперти RecentsListSize для задания размера листав интерфейсе }
end.
