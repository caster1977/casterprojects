unit uTDocument;

interface

uses
  Classes,
  uTLoadableItem,
  Controls,
  ADODB,
  SqlExpr,
  DB,
  uIDocument;

type
  TDocument = class abstract(TLoadableItem, IDocument)
  private
    FId: Integer;
    function GetId: Integer;
    procedure SetId(const AValue: Integer);
  public
    property Id: Integer read GetId write SetId nodefault;
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
    procedure AddVisualizableField(const ACaption, AName: string);
    procedure ClearVisualizableFields;
  protected
    FVisualizableFields: TInterfaceList;
    FParentControl: TCustomControl;
  public
    procedure Show(const AParentControl: TCustomControl = nil); virtual;
  public
    constructor Create; override;
    destructor Destroy; override;
  private
    procedure ClearParentControl;
  end;

implementation

uses
  SysUtils,
  StdCtrls,
  Types,
  uCommonRoutines,
  uIDocumentField,
  uTDocumentField;

function TDocument.GetArchiveBoxId: Integer;
begin
  Result := FArchiveBoxId;
end;

function TDocument.GetId: Integer;
begin
  Result := FId;
end;

function TDocument.GetTypeId: Integer;
begin
  Result := FTypeId;
end;

function TDocument.GetTypeName: string;
begin
  Result := FTypeName;
end;

procedure TDocument.SetArchiveBoxId(const AValue: Integer);
begin
  if FArchiveBoxId <> AValue then
  begin
    FArchiveBoxId := AValue;
  end;
end;

procedure TDocument.SetId(const AValue: Integer);
begin
  if FId <> AValue then
  begin
    FId := AValue;
  end;
end;

procedure TDocument.SetTypeId(const AValue: Integer);
begin
  if FTypeId <> AValue then
  begin
    FTypeId := AValue;
  end;
end;

procedure TDocument.SetTypeName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FTypeName <> s then
  begin
    FTypeName := s;
  end;
end;

constructor TDocument.Create;
begin
  inherited;
  FParentControl := nil;
  Id := -1;
  ArchiveBoxId := -1;
  TypeId := -1;
  TypeName := EmptyStr;
end;

procedure TDocument.Load(const ADataSet: TDataSet);
begin
  if Assigned(ADataSet) then
  begin
    Id := ADataSet.FieldByName('Id').AsInteger;
    ArchiveBoxId := ADataSet.FieldByName('ArchiveBoxId').AsInteger;
    TypeId := ADataSet.FieldByName('TypeId').AsInteger;
    TypeName := ADataSet.FieldByName('TypeName').AsString;
  end;
end;

procedure TDocument.ClearParentControl;
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

procedure TDocument.Show(const AParentControl: TCustomControl);
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
        // l2.Caption := IDocumentField(FVisualizableFields[j]).Caption;
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

procedure TDocument.AddVisualizableField(const ACaption, AName: string);
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

procedure TDocument.ClearVisualizableFields;
begin
  if Assigned(FVisualizableFields) then
  begin
    FreeAndNil(FVisualizableFields);
  end;
end;

destructor TDocument.Destroy;
begin
  ClearParentControl;
  ClearVisualizableFields;
  inherited;
end;

end.
