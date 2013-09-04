unit uTCustomDocument;

interface

uses
  Classes,
  Controls,
  ADODB,
  SqlExpr,
  DB,
  uICustomDocument;

type
  TCustomDocument = class abstract(TInterfacedObject, ICustomDocument)
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
  protected
    procedure Initialize; virtual;
    procedure Finalize; virtual;
    function GetLoadSQL: string; virtual; abstract;
  public
    procedure Load(const AADOConnection: TADOConnection); overload;
    procedure Load(const ASQLConnection: TSQLConnection); overload;
    procedure Load(const ADataSet: TDataSet); overload; virtual;
  protected
    procedure AddVisualizableField(const ACaption, AName: string);
    procedure ClearVisualizableFields;
  protected
    FVisualizableFields: TInterfaceList;
    FParentControl: TCustomControl;
  public
    procedure Show(const AParentControl: TCustomControl = nil); virtual;
  public
    constructor Create; virtual;
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

procedure TCustomDocument.Finalize;
begin
end;

function TCustomDocument.GetArchiveBoxId: Integer;
begin
  Result := FArchiveBoxId;
end;

function TCustomDocument.GetId: Integer;
begin
  Result := FId;
end;

function TCustomDocument.GetTypeId: Integer;
begin
  Result := FTypeId;
end;

function TCustomDocument.GetTypeName: string;
begin
  Result := FTypeName;
end;

procedure TCustomDocument.SetArchiveBoxId(const AValue: Integer);
begin
  if FArchiveBoxId <> AValue then
  begin
    FArchiveBoxId := AValue;
  end;
end;

procedure TCustomDocument.SetId(const AValue: Integer);
begin
  if FId <> AValue then
  begin
    FId := AValue;
  end;
end;

procedure TCustomDocument.SetTypeId(const AValue: Integer);
begin
  if FTypeId <> AValue then
  begin
    FTypeId := AValue;
  end;
end;

procedure TCustomDocument.SetTypeName(const AValue: string);
var
  s: string;
begin
  s := Trim(AValue);
  if FTypeName <> s then
  begin
    FTypeName := s;
  end;
end;

procedure TCustomDocument.Initialize;
begin
  Id := -1;
  ArchiveBoxId := -1;
  TypeId := -1;
  TypeName := EmptyStr;
end;

constructor TCustomDocument.Create;
begin
  inherited;
  FParentControl := nil;
  Initialize;
end;

procedure TCustomDocument.Load(const ADataSet: TDataSet);
begin
  if Assigned(ADataSet) then
  begin
    Id := ADataSet.FieldByName('Id').AsInteger;
    ArchiveBoxId := ADataSet.FieldByName('ArchiveBoxId').AsInteger;
    TypeId := ADataSet.FieldByName('TypeId').AsInteger;
    TypeName := ADataSet.FieldByName('TypeName').AsString;
  end;
end;

procedure TCustomDocument.ClearParentControl;
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

procedure TCustomDocument.Show(const AParentControl: TCustomControl);
var
  s: string;
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
        c := GetControlByName('lblDocument' + IDocumentField(FVisualizableFields[j]).Name + 'Caption',
          FParentControl);
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

        c := GetControlByName('lblDocument' + IDocumentField(FVisualizableFields[j]).Name, FParentControl);
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

procedure TCustomDocument.AddVisualizableField(const ACaption, AName: string);
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

procedure TCustomDocument.ClearVisualizableFields;
begin
  if Assigned(FVisualizableFields) then
  begin
    FreeAndNil(FVisualizableFields);
  end;
end;

destructor TCustomDocument.Destroy;
begin
  Finalize;
  ClearParentControl;
  ClearVisualizableFields;
  inherited;
end;

procedure TCustomDocument.Load(const AADOConnection: TADOConnection);
var
  q: TADOQuery;
begin
  if Assigned(AADOConnection) then
  begin
    if AADOConnection.Connected then
    begin
      q := TADOQuery.Create(nil);
      try
        q.Connection := AADOConnection;
        q.CommandTimeout := 60000;
        q.LockType := ltReadOnly;
        q.CursorType := ctOpenForwardOnly;
        q.SQL.Add(GetLoadSQL);
        q.Open;
        try
          Load(q);
        finally
          q.Close;
        end;
      finally
        FreeAndNil(q);
      end;
    end;
  end;
end;

procedure TCustomDocument.Load(const ASQLConnection: TSQLConnection);
var
  q: TSQLQuery;
begin
  if Assigned(ASQLConnection) then
  begin
    if ASQLConnection.Connected then
    begin
      q := TSQLQuery.Create(nil);
      try
        q.SQLConnection := ASQLConnection;
        q.SQL.Add(GetLoadSQL);
        q.Open;
        try
          Load(q);
        finally
          q.Close;
        end;
      finally
        FreeAndNil(q);
      end;
    end;
  end;
end;

end.
