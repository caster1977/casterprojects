unit uTArchivingBoxCapacityConfigMainForm;

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
  Actions,
  ActnList,
  Grids,
  ValEdit,
  StdCtrls,
  ExtCtrls,
  DBXMSSQL,
  SqlExpr,
  DB,
  ADODB,
  uIArchivingBoxCapacityConfigBusinessLogic;

type
  TArchivingBoxCapacityConfigMainForm = class(TForm)
    pnlButtons: TPanel;
    btnCancel: TButton;
    btnSave: TButton;
    vleArchiveBoxCapacity: TValueListEditor;
    ActionList: TActionList;
    actSave: TAction;
    actCancel: TAction;
    ADOConnection: TADOConnection;
    SQLConnection: TSQLConnection;
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actSaveUpdate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure vleArchiveBoxCapacityValidate(Sender: TObject; ACol, ARow: Integer; const KeyName, KeyValue: string);
  private
    FLogic: IArchivingBoxCapacityConfigBusinessLogic;
    function GetLogic: IArchivingBoxCapacityConfigBusinessLogic;
    property Logic: IArchivingBoxCapacityConfigBusinessLogic read GetLogic nodefault;
  private
    procedure SetCaptions;
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  ArchivingBoxCapacityConfigMainForm: TArchivingBoxCapacityConfigMainForm;

implementation

{$R *.dfm}

uses
  uTArchivingBoxCapacityConfigBusinessLogic;

resourcestring
  RsSave = 'Применить';
  RsCancel = 'Отмена';
  RsTypes = 'Тип архивного короба';
  RsCapacity = 'Кол-во документов';
  RsCaption = 'Настройка объёма архивных коробов';

procedure TArchivingBoxCapacityConfigMainForm.actCancelExecute(Sender: TObject);
begin
  Close;
end;

procedure TArchivingBoxCapacityConfigMainForm.actSaveExecute(Sender: TObject);
begin
  if Logic.SaveData then
  begin
    actCancel.Execute;
  end;
end;

procedure TArchivingBoxCapacityConfigMainForm.actSaveUpdate(Sender: TObject);
begin
  (Sender as TAction).Enabled := Logic.DataWasChanged;
end;

constructor TArchivingBoxCapacityConfigMainForm.Create(AOwner: TComponent);
begin
  inherited;
  SetCaptions;
  Logic.DisableDocumentArchiving;
  Logic.LoadData;
end;

procedure TArchivingBoxCapacityConfigMainForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Logic.EnableDocumentArchiving;
end;

function TArchivingBoxCapacityConfigMainForm.GetLogic: IArchivingBoxCapacityConfigBusinessLogic;
begin
  if not Assigned(FLogic) then
  begin
    FLogic := TArchivingBoxCapacityConfigBusinessLogic.Create(ADOConnection, vleArchiveBoxCapacity);
  end;
  Result := FLogic;
end;

procedure TArchivingBoxCapacityConfigMainForm.SetCaptions;
begin
  Caption := RsCaption;
  actSave.Caption := RsSave;
  actCancel.Caption := RsCancel;
  vleArchiveBoxCapacity.TitleCaptions.Strings[0] := RsTypes;
  vleArchiveBoxCapacity.TitleCaptions.Strings[1] := RsCapacity;
end;

procedure TArchivingBoxCapacityConfigMainForm.vleArchiveBoxCapacityValidate(Sender: TObject; ACol, ARow: Integer;
  const KeyName, KeyValue: string);
begin
  vleArchiveBoxCapacity.Values[KeyName] := IntToStr(StrToIntDef(Trim(KeyValue), 0));
end;

end.
