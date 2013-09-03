unit uTCustomDocument;

interface

uses
  Classes,
  Controls,
  DB,
  uICustomDocument;

type
  TCustomDocument = class(TInterfacedObject, ICustomDocument)
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
    procedure Load(const ASource: TDataSet); virtual;
    procedure AddField(const ACaption, AName: string);
    procedure ClearFields;
    function GetSQLForLoad: string; virtual; abstract;
  protected
    FFields: TInterfaceList;
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

procedure TCustomDocument.Load(const ASource: TDataSet);
begin
  if Assigned(ASource) then
  begin
    Id := ASource.FieldByName('Id').AsInteger;
    ArchiveBoxId := ASource.FieldByName('ArchiveBoxId').AsInteger;
    TypeId := ASource.FieldByName('TypeId').AsInteger;
    TypeName := ASource.FieldByName('TypeName').AsString;
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
    if Assigned(FFields) then
    begin
      for j := 0 to FFields.Count - 1 do
      begin
        c := GetControlByName('lblDocument' + IDocumentField(FFields[j]).Name + 'Caption',
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
            l1.Margins.Bottom + FFields.Count * (17 + l1.Margins.Top);;
        end;
        l1.Name := 'lblDocument' + IDocumentField(FFields[j]).Name + 'Caption';
        l1.Parent := FParentControl;
        l1.Caption := IDocumentField(FFields[j]).Caption;
        l1.Left := 8;
        l1.Top := Integer(FParentControl is TGroupBox) * 10 + FParentControl.Margins.Top +
          FParentControl.Margins.Top + j * (17 + FParentControl.Margins.Top);

        c := GetControlByName('lblDocument' + IDocumentField(FFields[j]).Name, FParentControl);
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
            l2.Margins.Bottom + FFields.Count * (17 + l2.Margins.Top);;
        end;
        l2.Name := 'lblDocument' + IDocumentField(FFields[j]).Name;
        l2.Parent := FParentControl;
        // l2.Caption := IDocumentField(FFields[j]).Caption;
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

procedure TCustomDocument.AddField(const ACaption, AName: string);
var
  f: IDocumentField;
begin
  if not Assigned(FFields) then
  begin
    FFields := TInterfaceList.Create;
  end;
  if Assigned(FFields) then
  begin
    f := TDocumentField.Create(Trim(ACaption), Trim(AName));
    FFields.Add(f);
  end;
end;

procedure TCustomDocument.ClearFields;
begin
  if Assigned(FFields) then
  begin
    FreeAndNil(FFields);
  end;
end;

destructor TCustomDocument.Destroy;
begin
  Finalize;
  ClearParentControl;
  ClearFields;
  inherited;
end;

end.
