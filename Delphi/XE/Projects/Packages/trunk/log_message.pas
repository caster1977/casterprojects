{ ************************************************************************************************ }
{ }
{ XML Data Binding }
{ }
{ Generated on: 03.03.2011 16:13:36 }
{ Generated from: C:\Users\caster\Documents\RAD Studio\Projects\Packages\log_message.xml }
{ Settings stored in: C:\Users\caster\Documents\RAD Studio\Projects\Packages\log_message.xdb }
{ }
{ ************************************************************************************************ }

unit log_message;

interface

uses
  xmldom,
  XMLDoc,
  XMLIntf;

type

  { Forward Decls }

  TLogMessagesType=(lmtError, lmtWarning, lmtInfo, lmtSQL, lmtDebug);

  IXMLLog_messageType=interface;
  IXMLApplicationType=interface;
  IXMLFormType=interface;
  IXMLMethodType=interface;
  IXMLMessageType=interface;
  IXMLDateType=interface;
  IXMLTimeType=interface;

  { IXMLLog_messageType }

  IXMLLog_messageType=interface(IXMLNode)
    ['{D369590A-DCB8-4037-91B3-7FDC2A8D763B}']
    { Property Accessors }
    function Get_Host: UnicodeString;
    function Get_Application: IXMLApplicationType;
    function Get_Message: IXMLMessageType;
    procedure Set_Host(Value: UnicodeString);
    { Methods & Properties }
    property Host: UnicodeString read Get_Host write Set_Host;
    property Application: IXMLApplicationType read Get_Application;
    property Message: IXMLMessageType read Get_Message;
  end;

  { IXMLApplicationType }

  IXMLApplicationType=interface(IXMLNode)
    ['{4AC2DB0D-251C-40DA-8AB4-C984303CB858}']
    { Property Accessors }
    function Get_Handle: Integer;
    function Get_FileName: UnicodeString;
    function Get_FilePath: UnicodeString;
    function Get_Form: IXMLFormType;
    function Get_Method: IXMLMethodType;
    function Get_User: UnicodeString;
    procedure Set_Handle(Value: Integer);
    procedure Set_FileName(Value: UnicodeString);
    procedure Set_FilePath(Value: UnicodeString);
    procedure Set_User(Value: UnicodeString);
    { Methods & Properties }
    property Handle: Integer read Get_Handle write Set_Handle;
    property FileName: UnicodeString read Get_FileName write Set_FileName;
    property FilePath: UnicodeString read Get_FilePath write Set_FilePath;
    property Form: IXMLFormType read Get_Form;
    property Method: IXMLMethodType read Get_Method;
    property User: UnicodeString read Get_User write Set_User;
  end;

  { IXMLFormType }

  IXMLFormType=interface(IXMLNode)
    ['{75C4B607-659E-4506-AB54-D5764271DD6A}']
    { Property Accessors }
    function Get_Handle: Integer;
    function Get_Name: UnicodeString;
    procedure Set_Handle(Value: Integer);
    procedure Set_Name(Value: UnicodeString);
    { Methods & Properties }
    property Handle: Integer read Get_Handle write Set_Handle;
    property Name: UnicodeString read Get_Name write Set_Name;
  end;

  { IXMLMethodType }

  IXMLMethodType=interface(IXMLNode)
    ['{159F6D95-415B-47F6-B1D6-0F625B3ED75C}']
    { Property Accessors }
    function Get_Guid: UnicodeString;
    procedure Set_Guid(Value: UnicodeString);
    { Methods & Properties }
    property Guid: UnicodeString read Get_Guid write Set_Guid;
  end;

  { IXMLMessageType }

  IXMLMessageType=interface(IXMLNode)
    ['{FDC16AEC-DE9B-4C0C-8BDF-3563E91E5DB1}']
    { Property Accessors }
    function Get_Index: LongWord;
    function Get_Date: IXMLDateType;
    function Get_Time: IXMLTimeType;
    function Get_MessageType: TLogMessagesType;
    function Get_Text: UnicodeString;
    procedure Set_Index(Value: LongWord);
    procedure Set_MessageType(Value: TLogMessagesType);
    procedure Set_Text(Value: UnicodeString);
    { Methods & Properties }
    property Index: LongWord read Get_Index write Set_Index;
    property Date: IXMLDateType read Get_Date;
    property Time: IXMLTimeType read Get_Time;
    property MessageType: TLogMessagesType read Get_MessageType write Set_MessageType;
    property Text: UnicodeString read Get_Text write Set_Text;
  end;

  { IXMLDateType }

  IXMLDateType=interface(IXMLNode)
    ['{68264EE4-A6FD-4F3A-B989-7D0C54FCDBAE}']
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
    ['{3CB1FA20-0239-4F0F-BE7B-0927E7F1AC25}']
    { Property Accessors }
    function Get_Hour: Word;
    function Get_Minute: Word;
    function Get_Second: Word;
    function Get_MSecond: Word;
    procedure Set_Hour(Value: Word);
    procedure Set_Minute(Value: Word);
    procedure Set_Second(Value: Word);
    procedure Set_MSecond(Value: Word);
    { Methods & Properties }
    property Hour: Word read Get_Hour write Set_Hour;
    property Minute: Word read Get_Minute write Set_Minute;
    property Second: Word read Get_Second write Set_Second;
    property MSecond: Word read Get_MSecond write Set_MSecond;
  end;

  { Forward Decls }

  TXMLLog_messageType=class;
  TXMLApplicationType=class;
  TXMLFormType=class;
  TXMLMethodType=class;
  TXMLMessageType=class;
  TXMLDateType=class;
  TXMLTimeType=class;

  { TXMLLog_messageType }

  TXMLLog_messageType=class(TXMLNode, IXMLLog_messageType)
  protected
    { IXMLLog_messageType }
    function Get_Host: UnicodeString;
    function Get_Application: IXMLApplicationType;
    function Get_Message: IXMLMessageType;
    procedure Set_Host(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

  { TXMLApplicationType }

  TXMLApplicationType=class(TXMLNode, IXMLApplicationType)
  protected
    { IXMLApplicationType }
    function Get_Handle: Integer;
    function Get_FileName: UnicodeString;
    function Get_FilePath: UnicodeString;
    function Get_Form: IXMLFormType;
    function Get_Method: IXMLMethodType;
    function Get_User: UnicodeString;
    procedure Set_Handle(Value: Integer);
    procedure Set_FileName(Value: UnicodeString);
    procedure Set_FilePath(Value: UnicodeString);
    procedure Set_User(Value: UnicodeString);
  public
    procedure AfterConstruction; override;
  end;

  { TXMLFormType }

  TXMLFormType=class(TXMLNode, IXMLFormType)
  protected
    { IXMLFormType }
    function Get_Handle: Integer;
    function Get_Name: UnicodeString;
    procedure Set_Handle(Value: Integer);
    procedure Set_Name(Value: UnicodeString);
  end;

  { TXMLMethodType }

  TXMLMethodType=class(TXMLNode, IXMLMethodType)
  protected
    { IXMLMethodType }
    function Get_Guid: UnicodeString;
    procedure Set_Guid(Value: UnicodeString);
  end;

  { TXMLMessageType }

  TXMLMessageType=class(TXMLNode, IXMLMessageType)
  protected
    { IXMLMessageType }
    function Get_Index: LongWord;
    function Get_Date: IXMLDateType;
    function Get_Time: IXMLTimeType;
    function Get_MessageType: TLogMessagesType;
    function Get_Text: UnicodeString;
    procedure Set_Index(Value: LongWord);
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
    function Get_MSecond: Word;
    procedure Set_Hour(Value: Word);
    procedure Set_Minute(Value: Word);
    procedure Set_Second(Value: Word);
    procedure Set_MSecond(Value: Word);
  end;

  { Global Functions }

function Getlog_message(Doc: IXMLDocument): IXMLLog_messageType;
function Loadlog_message(const FileName: string): IXMLLog_messageType;
function Newlog_message: IXMLLog_messageType;

const
  TargetNamespace='';

implementation

{ Global Functions }

function Getlog_message(Doc: IXMLDocument): IXMLLog_messageType;
begin
  Result:=Doc.GetDocBinding('log_message', TXMLLog_messageType, TargetNamespace) as IXMLLog_messageType;
end;

function Loadlog_message(const FileName: string): IXMLLog_messageType;
begin
  Result:=LoadXMLDocument(FileName).GetDocBinding('log_message', TXMLLog_messageType, TargetNamespace) as IXMLLog_messageType;
end;

function Newlog_message: IXMLLog_messageType;
begin
  Result:=NewXMLDocument.GetDocBinding('log_message', TXMLLog_messageType, TargetNamespace) as IXMLLog_messageType;
end;

{ TXMLLog_messageType }

procedure TXMLLog_messageType.AfterConstruction;
begin
  RegisterChildNode('application', TXMLApplicationType);
  RegisterChildNode('message', TXMLMessageType);
  inherited;
end;

function TXMLLog_messageType.Get_Host: UnicodeString;
begin
  Result:=ChildNodes['host'].Text;
end;

procedure TXMLLog_messageType.Set_Host(Value: UnicodeString);
begin
  ChildNodes['host'].NodeValue:=Value;
end;

function TXMLLog_messageType.Get_Application: IXMLApplicationType;
begin
  Result:=ChildNodes['application'] as IXMLApplicationType;
end;

function TXMLLog_messageType.Get_Message: IXMLMessageType;
begin
  Result:=ChildNodes['message'] as IXMLMessageType;
end;

{ TXMLApplicationType }

procedure TXMLApplicationType.AfterConstruction;
begin
  RegisterChildNode('form', TXMLFormType);
  RegisterChildNode('method', TXMLMethodType);
  inherited;
end;

function TXMLApplicationType.Get_Handle: Integer;
begin
  Result:=ChildNodes['handle'].NodeValue;
end;

procedure TXMLApplicationType.Set_Handle(Value: Integer);
begin
  ChildNodes['handle'].NodeValue:=Value;
end;

function TXMLApplicationType.Get_FileName: UnicodeString;
begin
  Result:=ChildNodes['filename'].Text;
end;

procedure TXMLApplicationType.Set_FileName(Value: UnicodeString);
begin
  ChildNodes['filename'].NodeValue:=Value;
end;

function TXMLApplicationType.Get_FilePath: UnicodeString;
begin
  Result:=ChildNodes['filepath'].Text;
end;

procedure TXMLApplicationType.Set_FilePath(Value: UnicodeString);
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

function TXMLFormType.Get_Handle: Integer;
begin
  Result:=ChildNodes['handle'].NodeValue;
end;

procedure TXMLFormType.Set_Handle(Value: Integer);
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

{ TXMLMessageType }

procedure TXMLMessageType.AfterConstruction;
begin
  RegisterChildNode('date', TXMLDateType);
  RegisterChildNode('time', TXMLTimeType);
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

function TXMLTimeType.Get_MSecond: Word;
begin
  Result:=ChildNodes['msecond'].NodeValue;
end;

procedure TXMLTimeType.Set_Minute(Value: Word);
begin
  ChildNodes['minute'].NodeValue:=Value;
end;

procedure TXMLTimeType.Set_MSecond(Value: Word);
begin
  ChildNodes['msecond'].NodeValue:=Value;
end;

function TXMLTimeType.Get_Second: Word;
begin
  Result:=ChildNodes['second'].NodeValue;
end;

procedure TXMLTimeType.Set_Second(Value: Word);
begin
  ChildNodes['second'].NodeValue:=Value;
end;

end.
