unit OA5.uTCustomPhone;

interface

uses
  OA5.uICustomPhone,
  System.Classes,
  OA5.uTPhoneTypes,
  CastersPackage.uINormalized;

type
  TCustomPhone = class(TInterfacedObject, ICustomPhone, INormalized)
  strict private
    FAutoNormalizeData: Boolean;
    FId: Int64;
    FPhoneNumber: string;
    FPhoneType: TPhoneTypes;
    FComments: string;
    FCheckDate: TDate;
    FCreationDateTime: TDateTime;
    FModificationDateTime: TDateTime;
    FPriority: Byte;
    function GetAutoNormalizeData: Boolean;
    procedure SetAutoNormalizeData(const AValue: Boolean);
    function GetCheckDate: TDate;
    procedure SetCheckDate(const AValue: TDate);
    function GetComments: string;
    procedure SetComments(const AValue: string);
    function GetCreationDateTime: TDateTime;
    procedure SetCreationDateTime(const AValue: TDateTime);
    function GetId: Int64;
    procedure SetId(const AValue: Int64);
    function GetModificationDateTime: TDateTime;
    procedure SetModificationDateTime(const AValue: TDateTime);
    function GetPhoneNumber: string;
    procedure SetPhoneNumber(const AValue: string);
    function GetPriority: Byte;
    procedure SetPriority(const AValue: Byte);
    procedure SetPhoneType(const AValue: TPhoneTypes);
    function GetPhoneType: TPhoneTypes;
  protected
    constructor Create(const APhoneType: TPhoneTypes); overload;
  public
    constructor Create; overload; virtual;
    function IsNormalized: Boolean; virtual;
    procedure Normalize; virtual;
    function PhoneTypeToString: string; virtual;
    property AutoNormalizeData: Boolean read GetAutoNormalizeData write SetAutoNormalizeData
      default False;
    property Id: Int64 read GetId write SetId default -1;
    property PhoneNumber: string read GetPhoneNumber write SetPhoneNumber nodefault;
    property PhoneType: TPhoneTypes read GetPhoneType write SetPhoneType default ptUnknown;
    property Comments: string read GetComments write SetComments nodefault;
    property CheckDate: TDate read GetCheckDate write SetCheckDate nodefault;
    property CreationDateTime: TDateTime read GetCreationDateTime
      write SetCreationDateTime nodefault;
    property ModificationDateTime: TDateTime read GetModificationDateTime
      write SetModificationDateTime nodefault;
    property Priority: Byte read GetPriority write SetPriority default 0;
  end;

function GetINormalized(const ACustomPhone: ICustomPhone): INormalized; overload;

implementation

uses
  CastersPackage.uRoutines,
  System.DateUtils,
  OA5.uConsts,
  System.SysUtils;

function GetINormalized(const ACustomPhone: ICustomPhone): INormalized; overload;
begin
  Result := nil;
  if Assigned(ACustomPhone) then
  begin
    if Supports(ACustomPhone, INormalized) then
    begin
      Result := ACustomPhone as INormalized;
    end;
  end;
end;

constructor TCustomPhone.Create;
begin
  PhoneType := ptUnknown;
end;

constructor TCustomPhone.Create(const APhoneType: TPhoneTypes);
begin
  PhoneType := APhoneType;
end;

function TCustomPhone.GetAutoNormalizeData: Boolean;
begin
  Result := FAutoNormalizeData;
end;

function TCustomPhone.GetCheckDate: TDate;
begin
  Result := FCheckDate;
end;

function TCustomPhone.GetComments: string;
begin
  Result := FComments;
end;

function TCustomPhone.GetCreationDateTime: TDateTime;
begin
  Result := FCreationDateTime;
end;

function TCustomPhone.GetId: Int64;
begin
  Result := FId;
end;

function TCustomPhone.GetModificationDateTime: TDateTime;
begin
  Result := FModificationDateTime;
end;

function TCustomPhone.GetPhoneNumber: string;
begin
  Result := FPhoneNumber;
end;

function TCustomPhone.GetPhoneType: TPhoneTypes;
begin
  Result := FPhoneType;
end;

function TCustomPhone.GetPriority: Byte;
begin
  Result := FPriority;
end;

function TCustomPhone.PhoneTypeToString: string;
begin
  Result := PHONE_TYPES[PhoneType];
end;

procedure TCustomPhone.SetAutoNormalizeData(const AValue: Boolean);
begin
  Routines.SetField(AValue, FAutoNormalizeData);
end;

procedure TCustomPhone.SetCheckDate(const AValue: TDate);
begin
  Routines.SetField(AValue, FCheckDate);
end;

procedure TCustomPhone.SetComments(const AValue: string);
begin
  Routines.SetField(AValue, FComments);
end;

procedure TCustomPhone.SetCreationDateTime(const AValue: TDateTime);
begin
  Routines.SetField(AValue, FCreationDateTime);
end;

procedure TCustomPhone.SetId(const AValue: Int64);
begin
  Routines.SetField(AValue, FId);
end;

procedure TCustomPhone.SetModificationDateTime(const AValue: TDateTime);
begin
  Routines.SetField(AValue, FModificationDateTime);
end;

procedure TCustomPhone.SetPhoneNumber(const AValue: string);
begin
  Routines.SetField(AValue, FPhoneNumber);
end;

procedure TCustomPhone.SetPhoneType(const AValue: TPhoneTypes);
begin
  if FPhoneType <> AValue then
  begin
    FPhoneType := AValue;
  end;
end;

procedure TCustomPhone.SetPriority(const AValue: Byte);
begin
  Routines.SetField(AValue, FPriority);
end;

function TCustomPhone.IsNormalized: Boolean;
begin
  Result := True;
  { TODO : Разработать алгоритм проверки нормализованности телефона. }
end;

procedure TCustomPhone.Normalize;
begin
  if not IsNormalized then
  begin
    { TODO : Разработать алгоритм нормализации телефона. }
  end;
end;

end.
