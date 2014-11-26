{ **** UBPFD *********** by delphibase.endimus.com ****
  >> Получение списка серверов в локальной сети

  Класс-оболочка для функции NetServerEnum.

  Примечание. Проверялось только под WinNT/Win2000 (ничего другого под рукой нет).

  Методы
  ------------------
  Create( AServer, ADomain : string; AServerMask : longint );

  AServer - имя сервера, на котором выполняется функция;
  ADomain - имя домена, для которого запрашивается список серверов;
  AServerMask - флаги, задающие, список серверов какого типа следует получить.
  Этот параметр представляет собой набор флагов SV_TYPE_XXXX. подробнее -
  в исходнике и справке по функции WinAPI NetServerEnum.

  Refresh.
  Обновление списка серверов. Автоматически вызывается при создании класса,
  а также при присвоении значения свойству ServerMask.

  Свойства
  ------------------
  Servers[ index : integer ] : TServerInfo
  Список объектов TServerInfo, содержащих информацию о найденных серверах
  - имя, версию, флаги.

  Count : integer
  Количество найденных серверов

  ServerMask : longint
  Маска поиска серверов. См. описание параметра AServerMask в конструкторе.

  Зависимости: Classes
  Автор:       vuk
  Copyright:   Алексей Вуколов
  Дата:        26 апреля 2002 г.
  ***************************************************** }

unit CastersPackage.UNetSrvList;

interface

uses
  Classes;

const
  SV_TYPE_WORKSTATION = $00000001; // All LAN Manager workstations
  SV_TYPE_SERVER = $00000002; // All LAN Manager servers
  SV_TYPE_SQLSERVER = $00000004; // Any server running with Microsoft SQL Server
  SV_TYPE_DOMAIN_CTRL = $00000008; // Primary domain controller
  SV_TYPE_DOMAIN_BAKCTRL = $00000010; // Backup domain controller
  SV_TYPE_TIMESOURCE = $00000020; // Server running the Timesource service
  SV_TYPE_AFP = $00000040; // Apple File Protocol servers
  SV_TYPE_NOVELL = $00000080; // Novell servers
  SV_TYPE_DOMAIN_MEMBER = $00000100; // LAN Manager 2.x Domain Member
  SV_TYPE_LOCAL_LIST_ONLY = $40000000; // Servers maintained by the browser
  SV_TYPE_PRINT = $00000200; // Server sharing print queue
  SV_TYPE_DIALIN = $00000400; // Server running dial-in service
  SV_TYPE_XENIX_SERVER = $00000800; // Xenix server
  SV_TYPE_MFPN = $00004000; // Microsoft File and Print for Netware
  SV_TYPE_NT = $00001000; // Windows NT (either Workstation or Server)
  SV_TYPE_WFW = $00002000; // Server running Windows for Workgroups
  SV_TYPE_SERVER_NT = $00008000; // Windows NT non-DC server
  SV_TYPE_POTENTIAL_BROWSER = $00010000; // Server that can run the Browser service
  SV_TYPE_BACKUP_BROWSER = $00020000; // Server running a Browser service as backup
  SV_TYPE_MASTER_BROWSER = $00040000; // Server running the master Browser service
  SV_TYPE_DOMAIN_MASTER = $00080000; // Server running the domain master Browser
  SV_TYPE_DOMAIN_ENUM = $80000000; // Primary Domain
  SV_TYPE_WINDOWS = $00400000; // Windows 95 or later
  SV_TYPE_ALL = $FFFFFFFF; // All servers

type
  IServerInfo = interface(IUnknown)
    ['{436FB6D7-1947-486F-9141-C51684E02292}']
    function getSvr_Comment: WideString;
    function getSvr_Name: WideString;
    function getSvr_Platform_ID: integer;
    function getSvr_Type: integer;
    function getSvr_Version_Major: integer;
    function getSvr_Version_Minor: integer;

    property Svr_Platform_ID: integer read getSvr_Platform_ID;
    property Svr_Name: WideString read getSvr_Name;
    property Svr_Version_Major: integer read getSvr_Version_Major;
    property Svr_Version_Minor: integer read getSvr_Version_Minor;
    property Svr_Type: integer read getSvr_Type;
    property Svr_Comment: WideString read getSvr_Comment;
  end;

  IServerInfoImpl = interface(IServerInfo)
    ['{B30FBF50-CD6B-4F6B-B91F-94940988304C}']
    procedure setSvr_Comment(const Value: WideString);
    procedure setSvr_Name(const Value: WideString);
    procedure setSvr_Platform_ID(const Value: integer);
    procedure setSvr_Type(const Value: integer);
    procedure setSvr_Version_Major(const Value: integer);
    procedure setSvr_Version_Minor(const Value: integer);
  end;

  IServerList = interface(IUnknown)
    ['{C921B671-9D2F-4CFE-A2FC-C80BC68FB58F}']
    function GetServer(Index: integer): IServerInfo;
    function GetCount: integer;
    function getServerMask: longint;
    procedure SetServerMask(const Value: longint);

    procedure Refresh;
    property Servers[index: integer]: IServerInfo read GetServer; default;
    property Count: integer read GetCount;
    property ServerMask: longint read getServerMask write SetServerMask;
  end;

function MakeServerList(const aServer, aDomain: string; const aServerMask: longint): IServerList;

implementation

uses
  Sysutils;

type
  TServerInfo = class(TInterfacedObject, IServerInfo, IServerInfoImpl)
  private
    fSvr_Platform_ID: integer;
    fSvr_Name: WideString;
    fSvr_Version_Major: integer;
    fSvr_Version_Minor: integer;
    fSvr_Type: integer;
    fSvr_Comment: WideString;
    function getSvr_Comment: WideString;
    function getSvr_Name: WideString;
    function getSvr_Platform_ID: integer;
    function getSvr_Type: integer;
    function getSvr_Version_Major: integer;
    function getSvr_Version_Minor: integer;
    procedure setSvr_Comment(const Value: WideString);
    procedure setSvr_Name(const Value: WideString);
    procedure setSvr_Platform_ID(const Value: integer);
    procedure setSvr_Type(const Value: integer);
    procedure setSvr_Version_Major(const Value: integer);
    procedure setSvr_Version_Minor(const Value: integer);
  public
    property Svr_Platform_ID: integer read getSvr_Platform_ID;
    property Svr_Name: WideString read getSvr_Name;
    property Svr_Version_Major: integer read getSvr_Version_Major;
    property Svr_Version_Minor: integer read getSvr_Version_Minor;
    property Svr_Type: integer read getSvr_Type;
    property Svr_Comment: WideString read getSvr_Comment;
  end;

  TServerList = class(TInterfaceList, IServerList)
  private
  protected
    // FList: TInterfaceList;
    FServer, FDomain: WideString;
    FServerMask: longint;
    function GetServer(Index: integer): IServerInfo;
    function getServerMask: longint;
    procedure SetServerMask(const Value: longint);
  public
    constructor Create(aServer, aDomain: string; aServerMask: longint);
    destructor Destroy; override;
    procedure Refresh;
    property Servers[index: integer]: IServerInfo read GetServer; default;
    property Count: integer read GetCount;
    property ServerMask: longint read getServerMask write SetServerMask;
  end;

  TServer_Info_101 = record
    Svr_Platform_ID: integer;
    Svr_Name: PWideChar;
    Svr_Version_Major, Svr_Version_Minor, Svr_Type: integer;
    Svr_Comment: PWideChar;
  end;

  TServer_Infos_101 = array [1 .. ($1FFFFFFF div SizeOf(TServer_Info_101))] of TServer_Info_101;

function MakeServerList(const aServer, aDomain: string; const aServerMask: longint): IServerList;
begin
  Result := TServerList.Create(aServer, aDomain, aServerMask);
end;

function NetServerEnum(ServerName: PWideChar; Level: longint; var BufPtr: pointer; PrefMaxLen: longint;
  var EntriesRead, TotalEntries: longint; ServType: longint; Domain: PWideChar; var ResumeHandle: integer): longint;
  stdcall; external 'netapi32.dll' name 'NetServerEnum';

constructor TServerList.Create(aServer, aDomain: string; aServerMask: longint);
begin
  inherited Create;
  FServer := aServer;
  FDomain := aDomain;
  FServerMask := aServerMask;
  Refresh;
end;

destructor TServerList.Destroy;
begin
  Clear;
  inherited Destroy;
end;

function TServerList.GetServer(Index: integer): IServerInfo;
begin
  Result := Items[index] as IServerInfo;
end;

procedure TServerList.Refresh;
var
  EntRead, EntTotal, Resume, i: integer;
  Info: integer;
  Itm: IServerInfoImpl;
  Data: pointer;
  pServer, pDomain: PWideChar;
begin
  if FServer <> '' then
    pServer := PWideChar(FServer)
  else
    pServer := nil;
  if FDomain <> '' then
    pDomain := PWideChar(FDomain)
  else
    pDomain := nil;

  Clear;

  Info := NetServerEnum(pServer, 101, Data, -1, EntRead, EntTotal, FServerMask, pDomain, Resume);

  if Info = 0 then

    for i := 1 to EntRead do
    begin
      Itm := TServerInfo.Create;
      with TServer_Infos_101(Data^)[i] do
      begin
        Itm.setSvr_Platform_ID(Svr_Platform_ID);
        Itm.setSvr_Name(Svr_Name);
        Itm.setSvr_Version_Major(Svr_Version_Major);
        Itm.setSvr_Version_Minor(Svr_Version_Minor);
        Itm.setSvr_Type(Svr_Type);
        Itm.setSvr_Comment(Svr_Comment);
      end;
      Add(Itm);
    end
  else
    raise Exception.Create('Cannot get server list');

end;

procedure TServerList.SetServerMask(const Value: longint);
begin
  FServerMask := Value;
  Refresh;
end;

function TServerList.getServerMask: longint;
begin
  Result := FServerMask;
end;

{ TServerInfo }

function TServerInfo.getSvr_Comment: WideString;
begin
  Result := fSvr_Comment;
end;

function TServerInfo.getSvr_Name: WideString;
begin
  Result := fSvr_Name;
end;

function TServerInfo.getSvr_Platform_ID: integer;
begin
  Result := fSvr_Platform_ID;
end;

function TServerInfo.getSvr_Type: integer;
begin
  Result := fSvr_Type;
end;

function TServerInfo.getSvr_Version_Major: integer;
begin
  Result := fSvr_Version_Major;
end;

function TServerInfo.getSvr_Version_Minor: integer;
begin
  Result := fSvr_Version_Minor;
end;

procedure TServerInfo.setSvr_Comment(const Value: WideString);
begin
  fSvr_Comment := Value;
end;

procedure TServerInfo.setSvr_Name(const Value: WideString);
begin
  fSvr_Name := Value;
end;

procedure TServerInfo.setSvr_Platform_ID(const Value: integer);
begin
  fSvr_Platform_ID := Value;
end;

procedure TServerInfo.setSvr_Type(const Value: integer);
begin
  fSvr_Type := Value;
end;

procedure TServerInfo.setSvr_Version_Major(const Value: integer);
begin
  fSvr_Version_Major := Value;
end;

procedure TServerInfo.setSvr_Version_Minor(const Value: integer);
begin
  fSvr_Version_Minor := Value;
end;

end.
