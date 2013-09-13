unit uTDocumentArchivingBusinessLogic;

interface

uses
  uTCustomBusinessLogic,
  uIDocumentArchivingBusinessLogic,
  uIArchiveBoxItem;

type
  TDocumentArchivingBusinessLogic = class sealed(TCustomBusinessLogic,
    IDocumentArchivingBusinessLogic)
  private
    FCurrentBox: IArchiveBoxItem;
    function GetCurrentBox: IArchiveBoxItem;
  public
    property CurrentBox: IArchiveBoxItem read GetCurrentBox nodefault;
  public
    function GetBoxCapacity(const AType: Integer): Integer; overload;
    function GetBoxCapacity(const ABox: IArchiveBoxItem): Integer; overload;
    // procedure ClearParentControl;
    // FParentControl: TCustomControl;
    // procedure Show(const AParentControl: TCustomControl = nil); virtual;
  end;

implementation

uses
  uIArchiveBoxTypeItem,
  uTArchiveBoxTypeItem;

function TDocumentArchivingBusinessLogic.GetBoxCapacity(const AType: Integer): Integer;
var
  box_type: IArchiveBoxTypeItem;
begin
  Result := -1;
  if AType <> -1 then
  begin
    if Assigned(Connection) then
    begin
      if Connection.Connected then
      begin
        box_type := TArchiveBoxTypeItem.Create(Connection, AType);
        Result := box_type.Capacity;
      end;
    end;
  end;
end;

function TDocumentArchivingBusinessLogic.GetBoxCapacity(const ABox: IArchiveBoxItem): Integer;
begin
  Result := -1;
  if Assigned(ABox) then
  begin
    Result := GetBoxCapacity(ABox.TypeId);
  end;
end;

function TDocumentArchivingBusinessLogic.GetCurrentBox: IArchiveBoxItem;
begin
  Result := FCurrentBox;
end;

// FParentControl := nil;

// procedure TArchiveDocumentItem.ClearParentControl;
// var
// i: Integer;
// c: TControl;
// begin
// if Assigned(FParentControl) then
// begin
// for i := FParentControl.ControlCount - 1 downto 0 do
// begin
// c := FParentControl.Controls[i];
// c.Parent := nil;
// FreeAndNil(c);
// end;
// end;
// FParentControl := nil;
// end;

// procedure TArchiveDocumentItem.Show(const AParentControl: TCustomControl);
// var
// l1, l2: TLabel;
// j: Integer;
// c: TControl;
// begin
// if (not Assigned(AParentControl)) and (not Assigned(FParentControl)) then
// begin
// Exit;
// end;
//
// if Assigned(AParentControl) then
// begin
// if FParentControl <> AParentControl then
// begin
// ClearParentControl;
// FParentControl := AParentControl;
// end;
// end;
//
// if Assigned(FParentControl) then
// begin
// if Assigned(FShowableFields) then
// begin
// for j := 0 to FShowableFields.Count - 1 do
// begin
// c := GetControlByName('lblDocument' + IShowableField(FShowableFields[j]).Name +
// 'Caption', FParentControl);
// if Assigned(c) then
// begin
// l1 := c as TLabel;
// end
// else
// begin
// l1 := TLabel.Create(FParentControl);
// end;
// if j = 0 then
// begin
// FParentControl.Height := Integer(FParentControl is TGroupBox) * 10 + l1.Margins.Top +
// l1.Margins.Bottom + FShowableFields.Count * (17 + l1.Margins.Top);;
// end;
// l1.Name := 'lblDocument' + IShowableField(FShowableFields[j]).Name + 'Caption';
// l1.Parent := FParentControl;
// l1.Caption := IShowableField(FShowableFields[j]).Caption;
// l1.Left := 8;
// l1.Top := Integer(FParentControl is TGroupBox) * 10 + FParentControl.Margins.Top +
// FParentControl.Margins.Top + j * (17 + FParentControl.Margins.Top);
//
// c := GetControlByName('lblDocument' + IShowableField(FShowableFields[j]).Name,
// FParentControl);
// if Assigned(c) then
// begin
// l2 := c as TLabel;
// end
// else
// begin
// l2 := TLabel.Create(FParentControl);
// end;
// if j = 0 then
// begin
// FParentControl.Height := Integer(FParentControl is TGroupBox) * 10 + l2.Margins.Top +
// l2.Margins.Bottom + FShowableFields.Count * (17 + l2.Margins.Top);;
// end;
// l2.Name := 'lblDocument' + IShowableField(FShowableFields[j]).Name;
// l2.Parent := FParentControl;
// l2.Left := FParentControl.ClientWidth div 2 + 8;
// l2.Top := Integer(FParentControl is TGroupBox) * 10 + FParentControl.Margins.Top +
// FParentControl.Margins.Top + j * (17 + FParentControl.Margins.Top);
// end;
// end;
// end;
//
// SetLabelCaption(FParentControl, 'lblDocumentId', IntToStr(Id));
// SetLabelCaption(FParentControl, 'lblDocumentTypeId', IntToStr(TypeId));
// SetLabelCaption(FParentControl, 'lblDocumentArchiveBoxId', IntToStr(ArchiveBoxId));
// end;

// procedure TCustomBSOItem.Show(const AParentControl: TCustomControl);
// begin
// inherited;
// SetLabelCaption(FParentControl, 'lblDocumentBarcode', Barcode);
// SetLabelCaption(FParentControl, 'lblDocumentCompanyId', IntToStr(CompanyId));
// SetLabelCaption(FParentControl, 'lblDocumentCompanyName', CompanyName);
// SetLabelCaption(FParentControl, 'lblDocumentSeries', Series);
// SetLabelCaption(FParentControl, 'lblDocumentNumber', Number);
// end;

// SetLabelCaption(FParentControl, 'lblDocumentCauseOfDamageId', IntToStr(CauseOfDamageId));
// SetLabelCaption(FParentControl, 'lblDocumentCauseOfDamageName', CauseOfDamageName);

// ClearParentControl;

end.
