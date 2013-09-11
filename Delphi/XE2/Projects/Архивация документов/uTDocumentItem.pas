unit uTDocumentItem;

interface

uses
  DB,
  Controls,
  Classes,
  uTLoadableItem,
  uIDocumentItem;

type
  TDocumentItem = class(TLoadableItem, IDocumentItem)
  private
    FArchiveBoxId: Integer;
    function GetArchiveBoxId: Integer;
    procedure SetArchiveBoxId(const AValue: Integer);
  public
    property ArchiveBoxId: Integer read GetArchiveBoxId write SetArchiveBoxId nodefault;

  private
    FTypeId: Integer;
    function GetTypeId: Integer;
    procedure SetTypeId(const AValue: Integer);
  public
    property TypeId: Integer read GetTypeId write SetTypeId nodefault;

  private
    FTypeName: string;
    function GetTypeName: string;
    procedure SetTypeName(const AValue: string);
  public
    property TypeName: string read GetTypeName write SetTypeName nodefault;
  public
    procedure Load(const ADataSet: TDataSet); override;
  protected
    FVisualizableFields: TInterfaceList;
    FParentControl: TCustomControl;
    procedure AddVisualizableField(const ACaption, AName: string);
    procedure ClearVisualizableFields;
  private
    procedure ClearParentControl;
  public
    procedure Show(const AParentControl: TCustomControl = nil); virtual;

  public
    constructor Create; override;
    destructor Destroy; override;

  protected
    class function GetDocumentType: Integer; virtual;
  public
    function GetLoadSQL: string; override; final;
  end;

implementation

uses
  SysUtils,
  StdCtrls,
  Types,
  uCommonRoutines,
  uIDocumentField,
  uTDocumentField;

function TDocumentItem.GetArchiveBoxId: Integer;
begin
  Result := FArchiveBoxId;
end;

class function TDocumentItem.GetDocumentType: Integer;
begin
  Result := -1;
end;

function TDocumentItem.GetId: Integer;
begin
  Result := FId;
end;

function TDocumentItem.GetLoadSQL(const AId: Integer): string;
begin
  Result := Format('BSOArchiving_sel_ArchiveDocuments %d, %d', [Id, GetDocumentType]);
end;

function TDocumentItem.GetTypeId: Integer;
begin
  Result := FTypeId;
end;

function TDocumentItem.GetTypeName: string;
begin
  Result := FTypeName;
end;

procedure TDocumentItem.SetArchiveBoxId(const AValue: Integer);
begin
  if FArchiveBoxId <> AValue then
  begin
    FArchiveBoxId := AValue;
  end;
end;

procedure TDocumentItem.SetId(const AValue: Integer);
begin
  if FId <> AValue then
  begin
    FId := AValue;
  end;
end;

procedure TDocumentItem.SetTypeId(const AValue: Integer);
begin
  if FTypeId <> AValue then
  begin
    FTypeId := AValue;
  end;
end;

procedure TDocumentItem.SetTypeName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FTypeName <> s then
  begin
    FTypeName := s;
  end;
end;

constructor TDocumentItem.Create;
begin
  inherited;
  FParentControl := nil;
  Id := -1;
  ArchiveBoxId := -1;
  TypeId := -1;
  TypeName := EmptyStr;
end;

procedure TDocumentItem.Load(const ADataSet: TDataSet);
begin
  if Assigned(ADataSet) then
  begin
    Id := ADataSet.FieldByName('Id').AsInteger;
    ArchiveBoxId := ADataSet.FieldByName('ArchiveBoxId').AsInteger;
    TypeId := ADataSet.FieldByName('TypeId').AsInteger;
    TypeName := ADataSet.FieldByName('TypeName').AsString;
  end;
end;

procedure TDocumentItem.ClearParentControl;
var
  i: Integer;
  c: TControl;
begin
  if Assigned(FParentControl) then
  begin
    for i := FParentControl.ControlCount - 1 downto 0 do
    begin
      c := FParentControl.Controls[i];
      c.Parent := nil;
      FreeAndNil(c);
    end;
  end;
  FParentControl := nil;
end;

procedure TDocumentItem.Show(const AParentControl: TCustomControl);
var
  l1, l2: TLabel;
  j: Integer;
  c: TControl;
begin
  if (not Assigned(AParentControl)) and (not Assigned(FParentControl)) then
  begin
    Exit;
  end;

  if Assigned(AParentControl) then
  begin
    if FParentControl <> AParentControl then
    begin
      ClearParentControl;
      FParentControl := AParentControl;
    end;
  end;

  if Assigned(FParentControl) then
  begin
    if Assigned(FVisualizableFields) then
    begin
      for j := 0 to FVisualizableFields.Count - 1 do
      begin
        c := GetControlByName('lblDocument' + IDocumentField(FVisualizableFields[j]).Name +
          'Caption', FParentControl);
        if Assigned(c) then
        begin
          l1 := c as TLabel;
        end
        else
        begin
          l1 := TLabel.Create(FParentControl);
        end;
        if j = 0 then
        begin
          FParentControl.Height := Integer(FParentControl is TGroupBox) * 10 + l1.Margins.Top +
            l1.Margins.Bottom + FVisualizableFields.Count * (17 + l1.Margins.Top);;
        end;
        l1.Name := 'lblDocument' + IDocumentField(FVisualizableFields[j]).Name + 'Caption';
        l1.Parent := FParentControl;
        l1.Caption := IDocumentField(FVisualizableFields[j]).Caption;
        l1.Left := 8;
        l1.Top := Integer(FParentControl is TGroupBox) * 10 + FParentControl.Margins.Top +
          FParentControl.Margins.Top + j * (17 + FParentControl.Margins.Top);

        c := GetControlByName('lblDocument' + IDocumentField(FVisualizableFields[j]).Name,
          FParentControl);
        if Assigned(c) then
        begin
          l2 := c as TLabel;
        end
        else
        begin
          l2 := TLabel.Create(FParentControl);
        end;
        if j = 0 then
        begin
          FParentControl.Height := Integer(FParentControl is TGroupBox) * 10 + l2.Margins.Top +
            l2.Margins.Bottom + FVisualizableFields.Count * (17 + l2.Margins.Top);;
        end;
        l2.Name := 'lblDocument' + IDocumentField(FVisualizableFields[j]).Name;
        l2.Parent := FParentControl;
        l2.Left := FParentControl.ClientWidth div 2 + 8;
        l2.Top := Integer(FParentControl is TGroupBox) * 10 + FParentControl.Margins.Top +
          FParentControl.Margins.Top + j * (17 + FParentControl.Margins.Top);
      end;
    end;
  end;

  SetLabelCaption(FParentControl, 'lblDocumentId', IntToStr(Id));
  SetLabelCaption(FParentControl, 'lblDocumentTypeId', IntToStr(TypeId));
  SetLabelCaption(FParentControl, 'lblDocumentTypeName', TypeName);
  SetLabelCaption(FParentControl, 'lblDocumentArchiveBoxId', IntToStr(ArchiveBoxId));
end;

procedure TDocumentItem.AddVisualizableField(const ACaption, AName: string);
var
  f: IDocumentField;
begin
  if not Assigned(FVisualizableFields) then
  begin
    FVisualizableFields := TInterfaceList.Create;
  end;
  if Assigned(FVisualizableFields) then
  begin
    f := TDocumentField.Create(Trim(ACaption), Trim(AName));
    FVisualizableFields.Add(f);
  end;
end;

procedure TDocumentItem.ClearVisualizableFields;
begin
  if Assigned(FVisualizableFields) then
  begin
    FreeAndNil(FVisualizableFields);
  end;
end;

destructor TDocumentItem.Destroy;
begin
  ClearParentControl;
  ClearVisualizableFields;
  inherited;
end;

end.
