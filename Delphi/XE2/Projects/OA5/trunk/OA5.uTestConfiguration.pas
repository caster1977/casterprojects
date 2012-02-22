unit OA5.uTestConfiguration;

interface

uses
  System.IniFiles,
  System.SysUtils,
  System.Generics.Collections;

type
  EConfiguration=class(Exception);

  ISection=interface(IInterface)
    ['{C7AFE17A-6A0E-460D-89E7-91C235BE4AA2}']
    function GetName: string;
    function GetFileName: string;
    procedure Load;
    procedure Save;
    procedure Loading;
    procedure Saving;
    property name: string read GetName;
    property FileName: string read GetFileName;
  end;

  TCustomSection=class(TInterfacedObject, ISection)
  strict private
    FName: string;
    FFileName: string;
    function GetName: string;
    function GetFileName: string;
  strict protected
    procedure Loading; virtual;
    procedure Saving; virtual;
  public
    constructor Create(const aName, aFileName: string); virtual;
    procedure Load; virtual; abstract;
    procedure Save; virtual; abstract;
    property name: string read GetName nodefault;
    property FileName: string read GetFileName nodefault;
  end;

  TCustomIniFileSection=class(TCustomSection)
  strict private
    FIniFile: TIniFile;
  protected
    procedure Write(const Key: string; const Value: string); overload;
    procedure Write(const Key: string; const Value: integer); overload;
    procedure Write(const Key: string; const Value: boolean); overload;
    function Read(const Key: string; const Default: string): string; overload;
    function Read(const Key: string; const Default: integer): integer; overload;
    function Read(const Key: string; const Default: boolean): boolean; overload;
    property IniFile: TIniFile read FIniFile write FIniFile nodefault;
  public
    constructor Create(const aName, aFileName: string); override;
    destructor Destroy; override;
    procedure Load; override; final;
    procedure Save; override; final;
  end;

  TCustomXMLFileSection=class(TCustomSection)
  end;

  TInterfaceIniFileSection=class(TCustomIniFileSection)
  public
    constructor Create(const aFileName: string); reintroduce; virtual;
  end;

  IConfiguration=interface(IInterface)
    ['{D65B5FAF-890A-41A5-839A-C3EBCAA8CFEC}']
    procedure Load;
    procedure Save;
  end;

  TCustomConfiguration=class(TInterfacedObject, IConfiguration)
  strict protected
    FFileName: string;
    FSections: TList<ISection>;
  public
    constructor Create(const aFileName: string; const aSections: TList<ISection>);
    procedure Load;
    procedure Save;
    destructor Destroy; override;
  end;

implementation

uses
  Vcl.Forms;

resourcestring
  TEXT_WRONG_FILENAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_SAVE_ERROR='Произошла ошибка при попытке записи в файл конфигурации!';

  TEXT_INIFILESECTION_INTERFACE='Интерфейс';
  TEXT_INIFILESECTION_LOGS='Протоколирование';
  TEXT_INIFILESECTION_DIALOGS_POSITION='Положение диалоговых окон';
  TEXT_INIFILESECTION_IDENTIFICATION='Идентификация';
  TEXT_INIFILESECTION_SERVERS='Сервера и базы данных';
  TEXT_INIFILESECTION_REPORTS='Формирование отчётов';
  TEXT_INIFILESECTION_OTHER='Прочие';
  TEXT_INIFILESECTION_MAINFORM='Главное окно';
  TEXT_INIFILESECTION_INFO='Отображение информации';

constructor TCustomSection.Create(const aName, aFileName: string);
var
  s: string;
begin
  inherited Create;

  s:=Trim(aName);
  if FName<>s then
    FName:=s;

  s:=Trim(aFileName);
  if FFileName<>s then
    FFileName:=s;
end;

function TCustomSection.GetFileName: string;
begin
  Result:=FFileName;
end;

function TCustomSection.GetName: string;
begin
  Result:=FName;
end;

procedure TCustomSection.Loading;
begin
  if FFileName='' then
    raise EConfiguration.Create(TEXT_WRONG_FILENAME);
end;

procedure TCustomSection.Saving;
begin
  if FFileName='' then
    raise EConfiguration.Create(TEXT_WRONG_FILENAME);
end;

constructor TCustomIniFileSection.Create(const aName, aFileName: string);
begin
  inherited;
  FIniFile:=TIniFile.Create(FileName);
end;

destructor TCustomIniFileSection.Destroy;
begin
  FreeAndNil(FIniFile);
  inherited;
end;

procedure TCustomIniFileSection.Load;
begin
  inherited;
  if Assigned(IniFile) then
    Loading;
end;

function TCustomIniFileSection.Read(const Key, Default: string): string;
begin
  Result:=IniFile.ReadString(name, Key, default);
end;

function TCustomIniFileSection.Read(const Key: string; const Default: integer): integer;
begin
  Result:=IniFile.ReadInteger(name, Key, default);
end;

function TCustomIniFileSection.Read(const Key: string; const Default: boolean): boolean;
begin
  Result:=IniFile.ReadBool(name, Key, default);
end;

procedure TCustomIniFileSection.Save;
begin
  inherited;
  if Assigned(IniFile) then
    try
      Saving;
    except
      on EIniFileException do
        raise EIniFileException.Create(TEXT_SAVE_ERROR);
    end;
end;

procedure TCustomIniFileSection.Write(const Key: string; const Value: boolean);
begin
  IniFile.WriteBool(name, Key, Value);
end;

procedure TCustomIniFileSection.Write(const Key: string; const Value: integer);
begin
  IniFile.WriteInteger(name, Key, Value);
end;

procedure TCustomIniFileSection.Write(const Key, Value: string);
begin
  IniFile.WriteString(name, Key, Value);
end;

constructor TInterfaceIniFileSection.Create(const aFileName: string);
begin
  inherited Create(TEXT_INIFILESECTION_INTERFACE, aFileName);
end;

constructor TCustomConfiguration.Create(const aFileName: string; const aSections: TList<ISection>);
resourcestring
  TEXT_ERROR_SECTIONLISTCREATING='Не удалось создать список объектов секций!';
  TEXT_ERROR_SECTIONCREATING='Не удалось создать объект секции "%s"!';
var
  i: integer;
  s: string;
begin
  inherited Create;
  s:=Trim(aFileName);
  if s='' then
    FFileName:=ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')
  else
    FFileName:=s;

  FSections.Create;
  if not Assigned(FSections) then
    EConfiguration.Create(TEXT_ERROR_SECTIONLISTCREATING)
  else
    try
      for i:=0 to aSections.Count do
        if FSections.Add(aSections[i])<0 then
          EConfiguration.Create(Format(TEXT_ERROR_SECTIONCREATING, [aSections[i].Name]));
    except
      FreeAndNil(FSections);
    end;
end;

destructor TCustomConfiguration.Destroy;
var
  i: integer;
begin
  if Assigned(FSections) then
    with FSections do
      for i:=Count-1 downto 0 do
        begin
          Items[i]:=nil;
          Delete(i);
        end;
  inherited;
end;

procedure TCustomConfiguration.Load;
var
  i: integer;
begin
  if Assigned(FSections) then
    with FSections do
      for i:=0 to Count-1 do
        Items[i].Load;
end;

procedure TCustomConfiguration.Save;
var
  i: integer;
begin
  if Assigned(FSections) then
    with FSections do
      for i:=0 to Count-1 do
        Items[i].Save;
end;

end.
