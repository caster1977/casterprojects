{ ************************************************************************************************** }
{ }
{ XML Data Binding }
{ }
{ Generated on: 10.03.2011 13:06:04 }
{ Generated from: C:\Users\caster\Documents\RAD Studio\Projects\Packages\logkeeperdata.xml }
{ Settings stored in: C:\Users\caster\Documents\RAD Studio\Projects\Packages\logkeeperdata.xdb }
{ }
{ ************************************************************************************************** }

unit LogKeeperData;

interface

uses
  xmldom,
  XMLDoc,
  XMLIntf,
  Windows;

type

  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL, lmtDebug);
  TLogMessagesTypes=set of TLogMessagesType;

  { Forward Decls }

  IXMLLogkeeperdataType=interface;
  IXMLMessageType=interface;
  IXMLDateType=interface;
  IXMLTimeType=interface;
  IXMLApplicationType=interface;
  IXMLFormType=interface;
  IXMLMethodType=interface;

  { IXMLLogkeeperdataType }

  IXMLLogkeeperdataType=interface(IXMLNodeCollection)
    ['{CAB01F41-32B7-48E7-BAB5-3E0BCDDF593A}']
    { Property Accessors }
    function Get_Message(index: Integer): IXMLMessageType;
    { Methods & Properties }
    function Add: IXMLMessageType;
    function Insert(const index: Integer): IXMLMessageType;
    property message[index: Integer]: IXMLMessageType read Get_Message; default;
  end;

  { IXMLMessageType }

  IXMLMessageType=interface(IXMLNode)
    ['{2ABF8C0B-ED63-4D3A-8964-485BFF7ADD4D}']
    { Property Accessors }
    function Get_Index: LongWord;
    function Get_Date: IXMLDateType;
    function Get_Time: IXMLTimeType;
    function Get_Host: UnicodeString;
    function Get_Application: IXMLApplicationType;
    function Get_MessageType: TLogMessagesType;
    function Get_Text: UnicodeString;
    procedure Set_Index(Value: LongWord);
    procedure Set_Host(Value: UnicodeString);
    procedure Set_MessageType(Value: TLogMessagesType);
    procedure Set_Text(Value: UnicodeString);
    { Methods & Properties }
    property index: LongWord read Get_Index write Set_Index;
    property Date: IXMLDateType read Get_Date;
    property Time: IXMLTimeType read Get_Time;
    property Host: UnicodeString read Get_Host write Set_Host;
    property Application: IXMLApplicationType read Get_Application;
    property MessageType: TLogMessagesType read Get_MessageType write Set_MessageType;
    property Text: UnicodeString read Get_Text write Set_Text;
  end;

  { IXMLDateType }

  IXMLDateType=interface(IXMLNode)
    ['{5B81058A-27FD-4607-9DD1-7EBE6760C83B}']
    { Property Accessors }
    function Get_Day: Word;
    function Get_Month: Word;
    function Get_Year: Word;
    procedure Set_Day(Value: Word);
    procedure Set_Month(Value: Word);
    procedure Set_Year(Value: Word);
    { Methods & Properties }
    property Day: Word read Get_Day write Set_Day;
    property Month: Word read Get_Month write Set_Month;
    property Year: Word read Get_Year write Set_Year;
  end;

  { IXMLTimeType }

  IXMLTimeType=interface(IXMLNode)
    ['{4EBE96E5-8734-4590-9301-4B7C7BB62DC7}']
    { Property Accessors }
    function Get_Hour: Word;
    function Get_Minute: Word;
    function Get_Second: Word;
    function Get_Msecond: Word;
    procedure Set_Hour(Value: Word);
    procedure Set_Minute(Value: Word);
    procedure Set_Second(Value: Word);
    procedure Set_Msecond(Value: Word);
    { Methods & Properties }
    property Hour: Word read Get_Hour write Set_Hour;
    property Minute: Word read Get_Minute write Set_Minute;
    property Second: Word read Get_Second write Set_Second;
    property Msecond: Word read Get_Msecond write Set_Msecond;
  end;

  { IXMLApplicationType }

  IXMLApplicationType=interface(IXMLNode)
    ['{FE2E3F8E-A7DA-4D13-A952-B56DF0CDB35C}']
    { Property Accessors }
    function Get_Handle: HWnd;
    function Get_Filename: UnicodeString;
    function Get_Filepath: UnicodeString;
    function Get_Form: IXMLFormType;
    function Get_Method: IXMLMethodType;
    function Get_User: UnicodeString;
    procedure Set_Handle(Value: HWnd);
    procedure Set_Filename(Value: UnicodeString);
    procedure Set_Filepath(Value: UnicodeString);
    procedure Set_User(Value: UnicodeString);
    { Methods & Properties }
    property Handle: HWnd read Get_Handle write Set_Handle;
    property Filename: UnicodeString read Get_Filename write Set_Filename;
    property Filepath: UnicodeString read Get_Filepath write Set_Filepath;
    property Form: IXMLFormType read Get_Form;
    property Method: IXMLMethodType read Get_Method;
    property User: UnicodeString read Get_User write Set_User;
  end;

  { IXMLFormType }

  IXMLFormType=interface(IXMLNode)
    ['{21CE6901-3013-441B-A9D2-1D81DD8FD340}']
    { Property Accessors }
    function Get_Handle: HWnd;
    function Get_Name: UnicodeString;
    procedure Set_Handle(Value: HWnd);
    procedure Set_Name(Value: UnicodeString);
    { Methods & Properties }
    property Handle: HWnd read Get_Handle write Set_Handle;
    property name: UnicodeString read Get_Name write Set_Name;
  end;

  { IXMLMethodType }

  IXMLMethodType=interface(IXMLNode)
    ['{DFC10CF6-46E1-4034-9EFC-EC54DF9F2CA5}']
    { Property Accessors }
    function Get_Guid: UnicodeString;
    procedure Set_Guid(Value: UnicodeString);
    { Methods & Properties }
    property Guid: UnicodeString read Get_Guid write Set_Guid;
  end;

  { Forward Decls }

  TXMLLogkeeperdataType=class;
  TXMLMessageType=class;
  TXMLDateType=class;
  TXMLTimeType=class;
  TXMLApplicationType=class;
  TXMLFormType=class;
  TXMLMethodType=class;

  { TXMLLogkeeperdataType }

  TXMLLogkeeperdataType=class(TXMLNodeCollection, IXMLLogkeeperdataType)
  protected
    { IXMLLogkeeperdataType }
    function Get_Message(index: Integer): IXMLMessageType;
    function Add: IXMLMessageType;
    function Insert(const index: Integer): IXMLMessageType;
  public
    procedure AfterConstruction; override;
  end;

  { TXMLMessageType }

  TXMLMessageType=class(TXMLNode, IXMLMessageType)
  protected
    { IXMLMessageType }
    function Get_Index: LongWord;
    function Get_Date: IXMLDateType;
    function Get_Time: IXMLTimeType;
    function Get_Host: UnicodeString;
    function Get_Application: IXMLApplicationType;
    function Get_MessageType: TLogMessagesType;
    function Get_Text: UnicodeString;
    procedure Set_Index(Value: LongWord);
    procedure Set_Host(Value: UnicodeString);
    procedure Set_MessageType(Value: TLogMessagesType);
    procedure Set_Text(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

  { TXMLDateType }

  TXMLDateType=class(TXMLNode, IXMLDateType)
  protected
    { IXMLDateType }
    function Get_Day: Word;
    function Get_Month: Word;
    function Get_Year: Word;
    procedure Set_Day(Value: Word);
    procedure Set_Month(Value: Word);
    procedure Set_Year(Value: Word);
  end;

  { TXMLTimeType }

  TXMLTimeType=class(TXMLNode, IXMLTimeType)
  protected
    { IXMLTimeType }
    function Get_Hour: Word;
    function Get_Minute: Word;
    function Get_Second: Word;
    function Get_Msecond: Word;
    procedure Set_Hour(Value: Word);
    procedure Set_Minute(Value: Word);
    procedure Set_Second(Value: Word);
    procedure Set_Msecond(Value: Word);
  end;

  { TXMLApplicationType }

  TXMLApplicationType=class(TXMLNode, IXMLApplicationType)
  protected
    { IXMLApplicationType }
    function Get_Handle: HWnd;
    function Get_Filename: UnicodeString;
    function Get_Filepath: UnicodeString;
    function Get_Form: IXMLFormType;
    function Get_Method: IXMLMethodType;
    function Get_User: UnicodeString;
    procedure Set_Handle(Value: HWnd);
    procedure Set_Filename(Value: UnicodeString);
    procedure Set_Filepath(Value: UnicodeString);
    procedure Set_User(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

  { TXMLFormType }

  TXMLFormType=class(TXMLNode, IXMLFormType)
  protected
    { IXMLFormType }
    function Get_Handle: HWnd;
    function Get_Name: UnicodeString;
    procedure Set_Handle(Value: HWnd);
    procedure Set_Name(Value: UnicodeString);
  end;

  { TXMLMethodType }

  TXMLMethodType=class(TXMLNode, IXMLMethodType)
  protected
    { IXMLMethodType }
    function Get_Guid: UnicodeString;
    procedure Set_Guid(Value: UnicodeString);
  end;

  { Global Functions }

function GetLogKeeperData(Doc: IXMLDocument): IXMLLogkeeperdataType;
function LoadlogKeeperData(const FileName: string): IXMLLogkeeperdataType;
function NewlogKeeperData: IXMLLogkeeperdataType;

const
  TargetNamespace='';

implementation

{ Global Functions }

function GetLogKeeperData(Doc: IXMLDocument): IXMLLogkeeperdataType;
begin
  Result:=Doc.GetDocBinding('logkeeperdata', TXMLLogkeeperdataType, TargetNamespace) as IXMLLogkeeperdataType;
end;

function LoadLogKeeperData(const FileName: string): IXMLLogkeeperdataType;
begin
  Result:=LoadXMLDocument(FileName).GetDocBinding('logkeeperdata', TXMLLogkeeperdataType, TargetNamespace) as IXMLLogkeeperdataType;
end;

function NewLogKeeperData: IXMLLogkeeperdataType;
begin
  Result:=NewXMLDocument.GetDocBinding('logkeeperdata', TXMLLogkeeperdataType, TargetNamespace) as IXMLLogkeeperdataType;
end;

{ TXMLLogkeeperdataType }

procedure TXMLLogkeeperdataType.AfterConstruction;
begin
  RegisterChildNode('message', TXMLMessageType);
  ItemTag:='message';
  ItemInterface:=IXMLMessageType;
  inherited;
end;

function TXMLLogkeeperdataType.Get_Message(index: Integer): IXMLMessageType;
begin
  Result:=List[index] as IXMLMessageType;
end;

function TXMLLogkeeperdataType.Add: IXMLMessageType;
begin
  Result:=AddItem(-1) as IXMLMessageType;
end;

function TXMLLogkeeperdataType.Insert(const index: Integer): IXMLMessageType;
begin
  Result:=AddItem(index) as IXMLMessageType;
end;

{ TXMLMessageType }

procedure TXMLMessageType.AfterConstruction;
begin
  RegisterChildNode('date', TXMLDateType);
  RegisterChildNode('time', TXMLTimeType);
  RegisterChildNode('application', TXMLApplicationType);
  inherited;
end;

function TXMLMessageType.Get_Index: LongWord;
begin
  Result:=ChildNodes['index'].NodeValue;
end;

procedure TXMLMessageType.Set_Index(Value: LongWord);
begin
  ChildNodes['index'].NodeValue:=Value;
end;

function TXMLMessageType.Get_Date: IXMLDateType;
begin
  Result:=ChildNodes['date'] as IXMLDateType;
end;

function TXMLMessageType.Get_Time: IXMLTimeType;
begin
  Result:=ChildNodes['time'] as IXMLTimeType;
end;

function TXMLMessageType.Get_Host: UnicodeString;
begin
  Result:=ChildNodes['host'].Text;
end;

procedure TXMLMessageType.Set_Host(Value: UnicodeString);
begin
  ChildNodes['host'].NodeValue:=Value;
end;

function TXMLMessageType.Get_Application: IXMLApplicationType;
begin
  Result:=ChildNodes['application'] as IXMLApplicationType;
end;

function TXMLMessageType.Get_MessageType: TLogMessagesType;
begin
  Result:=ChildNodes['type'].NodeValue;
end;

procedure TXMLMessageType.Set_MessageType(Value: TLogMessagesType);
begin
  ChildNodes['type'].NodeValue:=Value;
end;

function TXMLMessageType.Get_Text: UnicodeString;
begin
  Result:=ChildNodes['text'].Text;
end;

procedure TXMLMessageType.Set_Text(Value: UnicodeString);
begin
  ChildNodes['text'].NodeValue:=Value;
end;

{ TXMLDateType }

function TXMLDateType.Get_Day: Word;
begin
  Result:=ChildNodes['day'].NodeValue;
end;

procedure TXMLDateType.Set_Day(Value: Word);
begin
  ChildNodes['day'].NodeValue:=Value;
end;

function TXMLDateType.Get_Month: Word;
begin
  Result:=ChildNodes['month'].NodeValue;
end;

procedure TXMLDateType.Set_Month(Value: Word);
begin
  ChildNodes['month'].NodeValue:=Value;
end;

function TXMLDateType.Get_Year: Word;
begin
  Result:=ChildNodes['year'].NodeValue;
end;

procedure TXMLDateType.Set_Year(Value: Word);
begin
  ChildNodes['year'].NodeValue:=Value;
end;

{ TXMLTimeType }

function TXMLTimeType.Get_Hour: Word;
begin
  Result:=ChildNodes['hour'].NodeValue;
end;

procedure TXMLTimeType.Set_Hour(Value: Word);
begin
  ChildNodes['hour'].NodeValue:=Value;
end;

function TXMLTimeType.Get_Minute: Word;
begin
  Result:=ChildNodes['minute'].NodeValue;
end;

procedure TXMLTimeType.Set_Minute(Value: Word);
begin
  ChildNodes['minute'].NodeValue:=Value;
end;

function TXMLTimeType.Get_Second: Word;
begin
  Result:=ChildNodes['second'].NodeValue;
end;

procedure TXMLTimeType.Set_Second(Value: Word);
begin
  ChildNodes['second'].NodeValue:=Value;
end;

function TXMLTimeType.Get_Msecond: Word;
begin
  Result:=ChildNodes['msecond'].NodeValue;
end;

procedure TXMLTimeType.Set_Msecond(Value: Word);
begin
  ChildNodes['msecond'].NodeValue:=Value;
end;

{ TXMLApplicationType }

procedure TXMLApplicationType.AfterConstruction;
begin
  RegisterChildNode('form', TXMLFormType);
  RegisterChildNode('method', TXMLMethodType);
  inherited;
end;

function TXMLApplicationType.Get_Handle: HWnd;
begin
  Result:=ChildNodes['handle'].NodeValue;
end;

procedure TXMLApplicationType.Set_Handle(Value: HWnd);
begin
  ChildNodes['handle'].NodeValue:=Value;
end;

function TXMLApplicationType.Get_Filename: UnicodeString;
begin
  Result:=ChildNodes['filename'].Text;
end;

procedure TXMLApplicationType.Set_Filename(Value: UnicodeString);
begin
  ChildNodes['filename'].NodeValue:=Value;
end;

function TXMLApplicationType.Get_Filepath: UnicodeString;
begin
  Result:=ChildNodes['filepath'].Text;
end;

procedure TXMLApplicationType.Set_Filepath(Value: UnicodeString);
begin
  ChildNodes['filepath'].NodeValue:=Value;
end;

function TXMLApplicationType.Get_Form: IXMLFormType;
begin
  Result:=ChildNodes['form'] as IXMLFormType;
end;

function TXMLApplicationType.Get_Method: IXMLMethodType;
begin
  Result:=ChildNodes['method'] as IXMLMethodType;
end;

function TXMLApplicationType.Get_User: UnicodeString;
begin
  Result:=ChildNodes['user'].Text;
end;

procedure TXMLApplicationType.Set_User(Value: UnicodeString);
begin
  ChildNodes['user'].NodeValue:=Value;
end;

{ TXMLFormType }

function TXMLFormType.Get_Handle: HWnd;
begin
  Result:=ChildNodes['handle'].NodeValue;
end;

procedure TXMLFormType.Set_Handle(Value: HWnd);
begin
  ChildNodes['handle'].NodeValue:=Value;
end;

function TXMLFormType.Get_Name: UnicodeString;
begin
  Result:=ChildNodes['name'].Text;
end;

procedure TXMLFormType.Set_Name(Value: UnicodeString);
begin
  ChildNodes['name'].NodeValue:=Value;
end;

{ TXMLMethodType }

function TXMLMethodType.Get_Guid: UnicodeString;
begin
  Result:=ChildNodes['guid'].Text;
end;

procedure TXMLMethodType.Set_Guid(Value: UnicodeString);
begin
  ChildNodes['guid'].NodeValue:=Value;
end;

end.
