unit uTAcceptanceOfBoxesToArchiveBusinessLogic;

interface

uses
  uIArchiveBoxItem,
  uTCustomBusinessLogic,
  uIShowable,
  Controls,
  DB,
  uTOnDisplayMessage,
  uIAcceptanceOfBoxesToArchiveBusinessLogic,
  uTDocumentArchivingBarcodeType;

type
  TAcceptanceOfBoxesToArchiveBusinessLogic = class {$IFNDEF VER150} abstract {$ENDIF}
    (TCustomBusinessLogic, IAcceptanceOfBoxesToArchiveBusinessLogic)
  private
    /// <summary>
    /// ������� �������� ���������� ������
    /// </summary>
    /// <param name="ABox">
    /// �����
    /// </param>
    function AcceptBox(const ABox: IArchiveBoxItem): Boolean;

    /// <summary>
    /// ���������, ����������� ����� ������ � ��������� �������� ������
    /// </summary>
    procedure UpdateInfo;

    function IsArchiveBoxBarcode(const ABarcode: string): Boolean;
  private
    /// <summary>
    /// ������� ������� ��������� �����-����
    /// </summary>
    /// <param name="ABarcode">
    /// �����-���
    /// </param>
    /// <returns>
    /// ��� �����-����
    /// </returns>
    function AnalizeBarcode(const ABarcode: string): TDocumentArchivingBarcodeType;

    /// <summary>
    /// ������� ��������� ������� ������ �� ���������� �����-����
    /// </summary>
    /// <param name="ABarcode">
    /// �����-��� ������
    /// </param>
    /// <returns>
    /// ������ ������
    /// </returns>
    function GetBoxItemByBarcode(const ABarcode: string): IArchiveBoxItem;
  private
    FLastBox: IArchiveBoxItem;
  protected
    function GetLastBox: IArchiveBoxItem;
    procedure SetLastBox(const AValue: IArchiveBoxItem);
  public
    /// <summary>
    /// ��������� �������� � ����� �����
    /// </summary>
    property LastBox: IArchiveBoxItem read GetLastBox write SetLastBox nodefault;

  private
    FLastBoxInfoControl: TCustomControl;
    function GetLastBoxInfoControl: TCustomControl;
    procedure SetLastBoxInfoControl(const AValue: TCustomControl);
  protected
    /// <summary>
    /// �������, � ������� ����� ��������� ���������� � ��������� �������� � ����� ������
    /// </summary>
    property LastBoxInfoControl: TCustomControl read GetLastBoxInfoControl write SetLastBoxInfoControl nodefault;

  private
    FCurrentUserId: Integer;
    function GetCurrentUserId: Integer;
  protected
    /// <summary>
    /// ������������� �������� ������������
    /// </summary>
    property CurrentUserId: Integer read GetCurrentUserId nodefault;

  public
    constructor Create(const AConnection: TCustomConnection; const ACurrentUserId: Integer;
      const AOnDisplayMessage: TOnDisplayMessage = nil); reintroduce; virtual;
    procedure ProcessString(const AString: string);
  end;

resourcestring
  RsEnterBoxBarcode = '������� �����-��� ������';

implementation

uses
  StdCtrls,
  SysUtils,
  Windows,
  Forms,
  uArchivingCommonRoutines,
  uIShowableField,
  uTArchiveBoxItem;

function TAcceptanceOfBoxesToArchiveBusinessLogic.GetLastBox: IArchiveBoxItem;
begin
  Result := FLastBox;
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.GetLastBoxInfoControl: TCustomControl;
begin
  Result := FLastBoxInfoControl;
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.GetCurrentUserId: Integer;
begin
  Result := FCurrentUserId;
end;

procedure TAcceptanceOfBoxesToArchiveBusinessLogic.SetLastBox(const AValue: IArchiveBoxItem);
begin
  if FLastBox <> AValue then
  begin
    FLastBox := AValue;
  end;
end;

procedure TAcceptanceOfBoxesToArchiveBusinessLogic.SetLastBoxInfoControl(const AValue: TCustomControl);
begin
  if FLastBoxInfoControl <> AValue then
  begin
    FLastBoxInfoControl := AValue;
  end;
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.AnalizeBarcode(const ABarcode: string): TDocumentArchivingBarcodeType;
var
  s: string;
begin
  s := Trim(ABarcode);

  if IsArchiveBoxBarcode(s) then
  begin
    Result := dabtArchiveBox;
  end
  else
  begin
    Result := dabtUnknown;
  end;
end;

procedure TAcceptanceOfBoxesToArchiveBusinessLogic.UpdateInfo;
var
  showable: IShowable;
begin
  EmptyControl(LastBoxInfoControl);

  if Assigned(LastBox) then
  begin
    if Supports(LastBox, IShowable, showable) then
    begin
      ShowShowableItem(LastBoxInfoControl, showable);
    end;
  end;
end;

constructor TAcceptanceOfBoxesToArchiveBusinessLogic.Create(const AConnection: TCustomConnection;
  const ACurrentUserId: Integer; const AOnDisplayMessage: TOnDisplayMessage);
begin
  inherited Create(AConnection, AOnDisplayMessage);
  FCurrentUserId := ACurrentUserId;
  DisplayInfoMessage(RsEnterBoxBarcode);
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.IsArchiveBoxBarcode(const ABarcode: string): Boolean;
var
  s: string;
begin
  s := Trim(ABarcode);
  Result := (Length(s) = 12) and IsNumericString(s);
end;

procedure TAcceptanceOfBoxesToArchiveBusinessLogic.ProcessString(const AString: string);
var
  box: IArchiveBoxItem;
begin
  if AnalizeBarcode(AString) = dabtArchiveBox then
  begin
    box := GetBoxItemByBarcode(AString);
    if Assigned(box) then
    begin
      if box.Closed then
      begin
        if not box.Archived then
        begin
          if AcceptBox(box) then
          begin
            LastBox := box;
            DisplaySuccessMessage('����� ������ � �����' + sLineBreak + RsEnterBoxBarcode);
          end
          else
          begin
            DisplayErrorMessage('�� ������� ������� ����� � �����' + sLineBreak + RsEnterBoxBarcode);
          end;
        end
        else
        begin
          DisplayErrorMessage('������ ����� ��� ��� ������ � ����� �����' + sLineBreak + RsEnterBoxBarcode);
        end;
      end
      else
      begin
        DisplayErrorMessage('����� � ��������� �����-����� �� ����������� ��� ����� � �����' + sLineBreak +
          RsEnterBoxBarcode);
      end;
    end
    else
    begin
      DisplayErrorMessage('�� ������� ����� ������ �� ������ � ��������� �����-�����' + sLineBreak + RsEnterBoxBarcode);
    end;
  end
  else
  begin
    DisplayErrorMessage('����� ����������� �����-���' + sLineBreak + RsEnterBoxBarcode);
    Exit;
  end;
  UpdateInfo;
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.GetBoxItemByBarcode(const ABarcode: string): IArchiveBoxItem;
begin
  Result := nil;
  if IsArchiveBoxBarcode(ABarcode) then
  begin
    Result := TArchiveBoxItem.Create(Connection, -1);
    if Assigned(Result) then
    begin
      if not Result.FromString(ABarcode) then
      begin
        Result := nil;
      end;
    end;
  end;
end;

function TAcceptanceOfBoxesToArchiveBusinessLogic.AcceptBox(const ABox: IArchiveBoxItem): Boolean;
begin
  Result := False;
  if Assigned(ABox) then
  begin
    if not(ABox.Archived) then
    begin
      ABox.Archived := True;
      ABox.ArchivingDate := Now;
      Result := ABox.Save(Connection);
    end;
  end;
end;

end.
