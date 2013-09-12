unit uTCustomBusinessLogic;

interface

uses
  uICustomBusinessLogic,
  Classes,
  DB,
  SqlExpr,
  ADODB,
  uTOnDisplayMessage,
  uTMessageType;

type
  TCustomBusinessLogic = class abstract(TInterfacedObject, ICustomBusinessLogic)
  private
    FOnDisplayMessage: TOnDisplayMessage;
    function GetOnDisplayMessage: TOnDisplayMessage;
    procedure SetOnDisplayMessage(const AValue: TOnDisplayMessage);
  public
    property OnDisplayMessage: TOnDisplayMessage read GetOnDisplayMessage
      write SetOnDisplayMessage nodefault;

  private
    FConnection: TCustomConnection;
    function GetConnection: TCustomConnection;
  public
    property Connection: TCustomConnection read GetConnection nodefault;

  private
    FQuery: TDataSet;
    function GetQuery: TDataSet;
  protected
    property Query: TDataSet read GetQuery nodefault;

  private
    procedure DisplayMessage(const AType: TMessageType; const AText: string = '');
  protected
    procedure DisplayInfoMessage(const AText: string);
    procedure DisplayErrorMessage(const AText: string);
    procedure DisplaySuccessMessage(const AText: string);
    procedure ClearMessage;

  protected
    procedure CloseQuery;
  public
    constructor Create(const AConnection: TCustomConnection;
      const AOnDisplayMessage: TOnDisplayMessage = nil); virtual;
    destructor Destroy; override;
//    procedure ClearParentControl;
//    FParentControl: TCustomControl;
//    procedure Show(const AParentControl: TCustomControl = nil); virtual;
  end;

implementation

uses
  uCommonRoutines,
  SysUtils;

function TCustomBusinessLogic.GetConnection: TCustomConnection;
begin
  Result := FConnection;
end;

function TCustomBusinessLogic.GetOnDisplayMessage: TOnDisplayMessage;
begin
  Result := FOnDisplayMessage;
end;

function TCustomBusinessLogic.GetQuery: TDataSet;
begin
  Result := FQuery;
end;

procedure TCustomBusinessLogic.SetOnDisplayMessage(const AValue: TOnDisplayMessage);
begin
  FOnDisplayMessage := AValue;
end;

constructor TCustomBusinessLogic.Create(const AConnection: TCustomConnection;
  const AOnDisplayMessage: TOnDisplayMessage);
begin
  OnDisplayMessage := AOnDisplayMessage;
  FConnection := AConnection;
  FQuery := uCommonRoutines.GetQuery(Connection);
end;

procedure TCustomBusinessLogic.ClearMessage;
begin
  DisplayMessage(mtNone);
end;

procedure TCustomBusinessLogic.CloseQuery;
begin
  if Assigned(Query) then
  begin
    if Query.Active then
    begin
      Query.Close;
    end;
  end;
end;

destructor TCustomBusinessLogic.Destroy;
begin
  CloseQuery;
  FreeAndNil(FQuery);
  FConnection := nil;
  OnDisplayMessage := nil;
  inherited;
end;

procedure TCustomBusinessLogic.DisplayErrorMessage(const AText: string);
begin
  DisplayMessage(mtError, AText);
end;

procedure TCustomBusinessLogic.DisplayInfoMessage(const AText: string);
begin
  DisplayMessage(mtInfo, AText);
end;

procedure TCustomBusinessLogic.DisplaySuccessMessage(const AText: string);
begin
  DisplayMessage(mtSuccess, AText);
end;

procedure TCustomBusinessLogic.DisplayMessage(const AType: TMessageType; const AText: string);
begin
  if Assigned(OnDisplayMessage) then
  begin
    OnDisplayMessage(AType, AText);
  end;
end;

  //FParentControl := nil;

//procedure TArchiveDocumentItem.ClearParentControl;
//var
//  i: Integer;
//  c: TControl;
//begin
//  if Assigned(FParentControl) then
//  begin
//    for i := FParentControl.ControlCount - 1 downto 0 do
//    begin
//      c := FParentControl.Controls[i];
//      c.Parent := nil;
//      FreeAndNil(c);
//    end;
//  end;
//  FParentControl := nil;
//end;

//procedure TArchiveDocumentItem.Show(const AParentControl: TCustomControl);
//var
//  l1, l2: TLabel;
//  j: Integer;
//  c: TControl;
//begin
//  if (not Assigned(AParentControl)) and (not Assigned(FParentControl)) then
//  begin
//    Exit;
//  end;
//
//  if Assigned(AParentControl) then
//  begin
//    if FParentControl <> AParentControl then
//    begin
//      ClearParentControl;
//      FParentControl := AParentControl;
//    end;
//  end;
//
//  if Assigned(FParentControl) then
//  begin
//    if Assigned(FShowableFields) then
//    begin
//      for j := 0 to FShowableFields.Count - 1 do
//      begin
//        c := GetControlByName('lblDocument' + IShowableField(FShowableFields[j]).Name +
//          'Caption', FParentControl);
//        if Assigned(c) then
//        begin
//          l1 := c as TLabel;
//        end
//        else
//        begin
//          l1 := TLabel.Create(FParentControl);
//        end;
//        if j = 0 then
//        begin
//          FParentControl.Height := Integer(FParentControl is TGroupBox) * 10 + l1.Margins.Top +
//            l1.Margins.Bottom + FShowableFields.Count * (17 + l1.Margins.Top);;
//        end;
//        l1.Name := 'lblDocument' + IShowableField(FShowableFields[j]).Name + 'Caption';
//        l1.Parent := FParentControl;
//        l1.Caption := IShowableField(FShowableFields[j]).Caption;
//        l1.Left := 8;
//        l1.Top := Integer(FParentControl is TGroupBox) * 10 + FParentControl.Margins.Top +
//          FParentControl.Margins.Top + j * (17 + FParentControl.Margins.Top);
//
//        c := GetControlByName('lblDocument' + IShowableField(FShowableFields[j]).Name,
//          FParentControl);
//        if Assigned(c) then
//        begin
//          l2 := c as TLabel;
//        end
//        else
//        begin
//          l2 := TLabel.Create(FParentControl);
//        end;
//        if j = 0 then
//        begin
//          FParentControl.Height := Integer(FParentControl is TGroupBox) * 10 + l2.Margins.Top +
//            l2.Margins.Bottom + FShowableFields.Count * (17 + l2.Margins.Top);;
//        end;
//        l2.Name := 'lblDocument' + IShowableField(FShowableFields[j]).Name;
//        l2.Parent := FParentControl;
//        l2.Left := FParentControl.ClientWidth div 2 + 8;
//        l2.Top := Integer(FParentControl is TGroupBox) * 10 + FParentControl.Margins.Top +
//          FParentControl.Margins.Top + j * (17 + FParentControl.Margins.Top);
//      end;
//    end;
//  end;
//
//  SetLabelCaption(FParentControl, 'lblDocumentId', IntToStr(Id));
//  SetLabelCaption(FParentControl, 'lblDocumentTypeId', IntToStr(TypeId));
//  SetLabelCaption(FParentControl, 'lblDocumentArchiveBoxId', IntToStr(ArchiveBoxId));
//end;

//procedure TCustomBSOItem.Show(const AParentControl: TCustomControl);
//begin
//  inherited;
//  SetLabelCaption(FParentControl, 'lblDocumentBarcode', Barcode);
//  SetLabelCaption(FParentControl, 'lblDocumentCompanyId', IntToStr(CompanyId));
//  SetLabelCaption(FParentControl, 'lblDocumentCompanyName', CompanyName);
//  SetLabelCaption(FParentControl, 'lblDocumentSeries', Series);
//  SetLabelCaption(FParentControl, 'lblDocumentNumber', Number);
//end;

//  SetLabelCaption(FParentControl, 'lblDocumentCauseOfDamageId', IntToStr(CauseOfDamageId));
//  SetLabelCaption(FParentControl, 'lblDocumentCauseOfDamageName', CauseOfDamageName);

//  ClearParentControl;
end.
