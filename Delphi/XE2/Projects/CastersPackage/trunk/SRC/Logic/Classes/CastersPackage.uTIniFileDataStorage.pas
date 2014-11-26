unit CastersPackage.uTIniFileDataStorage;

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils,
  CastersPackage.uICustomized,
  CastersPackage.uIModified,
  CastersPackage.uIIniFileDataStorage,
  CastersPackage.uEIniFileDataStorage;

type
  TIniFileDataStorage = class(TInterfacedPersistent, IIniFileDataStorage, ICustomized, IModified)
  strict private
    FIniFileName: string;

  strict private
    FModified: Boolean;
  strict protected
    function GetModified: Boolean; virtual;
  strict private
    procedure SetModified(const AValue: Boolean);
  strict protected
    property Modified: Boolean read GetModified write SetModified nodefault;

  strict private
    FIniFile: TCustomIniFile;
    function GetIniFile: TCustomIniFile; virtual;
  strict protected
    property IniFile: TCustomIniFile read GetIniFile nodefault;

  strict protected
    constructor Create(const AIniFileName: string = ''); virtual;
    procedure Initialize; virtual; abstract;
    procedure Finalize; virtual;
    procedure Loading; virtual; abstract;
    procedure AfterLoad; virtual;
    procedure BeforeSave; virtual;
    procedure Saving; virtual; abstract;
  public
    destructor Destroy; override;
    procedure Load; virtual; final;
    procedure Save; virtual; final;
  end;

implementation

resourcestring
  RsWrongIniFilename = 'Имя файла конфигурации не должно быть пустым!';
  RsSaveIniFileError = 'Произошла ошибка при попытке записи данных в файл конфигурации!';

procedure TIniFileDataStorage.AfterLoad;
begin
end;

procedure TIniFileDataStorage.BeforeSave;
begin
end;

constructor TIniFileDataStorage.Create(const AIniFileName: string);
var
  s: string;
begin
  inherited Create;
  s := Trim(AIniFileName);
  if s = EmptyStr then
  begin
    FIniFileName := ChangeFileExt(ExpandFileName(ParamStr(0)), '.ini');
  end
  else
  begin
    FIniFileName := s;
  end;
  FIniFile := nil;
  Initialize;
  Modified := False;
end;

destructor TIniFileDataStorage.Destroy;
begin
  Finalize;
  if Assigned(FIniFile) then
  begin
    FreeAndNil(FIniFile);
  end;
  inherited;
end;

procedure TIniFileDataStorage.Finalize;
begin
end;

function TIniFileDataStorage.GetIniFile: TCustomIniFile;
begin
  Result := FIniFile;
end;

function TIniFileDataStorage.GetModified: Boolean;
begin
  Result := FModified;
end;

procedure TIniFileDataStorage.Load;
begin
  if FIniFileName = EmptyStr then
  begin
    raise EIniFileDataStorage.Create(RsWrongIniFilename);
  end;
  FIniFile := TMemIniFile.Create(FIniFileName);
  try
    Loading;
    if IniFile is TMemIniFile then
    begin
      (IniFile as TMemIniFile).Clear;
      (IniFile as TMemIniFile).UpdateFile;
    end;
    Modified := False;
  finally
    FreeAndNil(FIniFile);
  end;
  AfterLoad;
end;

procedure TIniFileDataStorage.Save;
begin
  BeforeSave;
  if FIniFileName = EmptyStr then
  begin
    raise EIniFileDataStorage.Create(RsWrongIniFilename);
  end;
  FIniFile := TMemIniFile.Create(FIniFileName);
  try
    try
      Saving;
      if IniFile is TMemIniFile then
      begin
        (IniFile as TMemIniFile).UpdateFile;
      end;
      Modified := False;
    except
      on EIniFileException do
      begin
        raise EIniFileException.Create(RsSaveIniFileError);
      end;
    end;
  finally
    FreeAndNil(FIniFile);
  end;
end;

procedure TIniFileDataStorage.SetModified(const AValue: Boolean);
begin
  if FModified <> AValue then
  begin
    FModified := AValue;
  end;
end;

end.
