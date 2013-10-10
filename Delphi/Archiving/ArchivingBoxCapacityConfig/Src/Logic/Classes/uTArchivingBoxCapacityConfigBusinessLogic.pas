unit uTArchivingBoxCapacityConfigBusinessLogic;

interface

uses
  uTCustomBusinessLogic,
  uIArchivingBoxCapacityConfigBusinessLogic,
  ValEdit,
  DB,
  uTOnDisplayMessage;

type
  TArchivingBoxCapacityConfigBusinessLogic = class {$IFNDEF VER150} sealed
{$ENDIF}(TCustomBusinessLogic, IArchivingBoxCapacityConfigBusinessLogic)
  private
    FValueListEditor: TValueListEditor;
    function GetValueListEditor: TValueListEditor;
    property ValueListEditor: TValueListEditor read GetValueListEditor nodefault;
  private
    procedure SetDocumentArchiving(const AValue: Boolean);
  public
    procedure EnableDocumentArchiving;
    procedure DisableDocumentArchiving;
    procedure LoadData;
    procedure SaveData;
    function DataWasChanged: Boolean;
    constructor Create(const AConnection: TCustomConnection; const AValueListEditor: TValueListEditor;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce;
  end;

implementation

uses
  SysUtils,
  Forms,
  Controls,
  uArchivingCommonRoutines;

procedure TArchivingBoxCapacityConfigBusinessLogic.SetDocumentArchiving(const AValue: Boolean);
var
  b: Boolean;
  s: string;
  old_cursor: TCursor;
  i: Integer;
begin
  s := EmptyStr;
  b := False;
  old_cursor := Screen.Cursor;
  Screen.Cursor := crSQLWait;
  try
    SetSQLForQuery(Query, Format('sys_set_FlagValueInt %d, %d', [79, Integer(AValue)]), True);
    try
      if not Query.Eof then
      begin
        if not Query.Eof then
        begin
          s := Query.Fields[0].AsString;
          b := Query.Fields[1].AsInteger = 0;
        end;
      end;
    finally
      Query.Close;
    end;
  finally
    Screen.Cursor := old_cursor;
    if not b then
    begin
      DisplayErrorMessage(s);
    end;
  end;
end;

constructor TArchivingBoxCapacityConfigBusinessLogic.Create(const AConnection: TCustomConnection;
  const AValueListEditor: TValueListEditor; const AOnDisplayMessage: TOnDisplayMessage);
begin
  inherited Create(AConnection, AOnDisplayMessage);
  FValueListEditor := AValueListEditor;
end;

function TArchivingBoxCapacityConfigBusinessLogic.DataWasChanged: Boolean;
begin
  Result := True;
end;

procedure TArchivingBoxCapacityConfigBusinessLogic.DisableDocumentArchiving;
begin
  SetDocumentArchiving(False);
end;

procedure TArchivingBoxCapacityConfigBusinessLogic.EnableDocumentArchiving;
begin
  SetDocumentArchiving(True);
end;

function TArchivingBoxCapacityConfigBusinessLogic.GetValueListEditor: TValueListEditor;
begin
  Result := FValueListEditor;
end;

procedure TArchivingBoxCapacityConfigBusinessLogic.LoadData;
begin

end;

procedure TArchivingBoxCapacityConfigBusinessLogic.SaveData;
begin

end;

end.
