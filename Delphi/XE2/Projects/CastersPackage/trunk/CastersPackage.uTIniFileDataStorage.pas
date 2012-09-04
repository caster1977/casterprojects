unit CastersPackage.uTIniFileDataStorage;

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils,
  CastersPackage.uIIniFileDataStorage;

type
  EIniFileDataStorage = class(Exception);

  TIniFileDataStorage = class(TInterfacedPersistent, IIniFileDataStorage)
  strict protected
    FIniFileName: string;
    procedure Initialize; virtual; abstract;
    procedure Loading(const AIniFile: TCustomIniFile); virtual; abstract;
    procedure AfterLoad; virtual; abstract;
    procedure BeforeSave; virtual; abstract;
    procedure Saving(const AIniFile: TCustomIniFile); virtual; abstract;
  protected
    constructor Create(const AIniFileName: string = ''); virtual;
  public
    procedure Load; virtual; final;
    procedure Save; virtual; final;
  end;

  TIniFileDataStorageClass = class of TIniFileDataStorage;

implementation

uses
  Vcl.Forms;

resourcestring
  TEXT_WRONG_INIFILE_NAME = 'Имя файла конфигурации не должно быть пустым!';
  TEXT_SAVE_INIFILE_ERROR = 'Произошла ошибка при попытке записи данных в файл конфигурации!';

constructor TIniFileDataStorage.Create(const AIniFileName: string);
var
  s: string;
begin
  inherited Create;
  s := Trim(AIniFileName);
  if s = EmptyStr then
    FIniFileName := ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')
  else
    FIniFileName := s;
  Initialize;
end;

procedure TIniFileDataStorage.Load;
var
  ini_file: TCustomIniFile;
begin
  if FIniFileName = EmptyStr then
    raise EIniFileDataStorage.Create(TEXT_WRONG_INIFILE_NAME);
  ini_file := TMemIniFile.Create(FIniFileName);
  try
    Loading(ini_file);
    if ini_file is TMemIniFile then
    begin
      (ini_file as TMemIniFile).Clear;
      (ini_file as TMemIniFile).UpdateFile;
    end;
  finally
    ini_file.Free;
  end;
  AfterLoad;
end;

procedure TIniFileDataStorage.Save;
var
  ini_file: TCustomIniFile;
begin
  BeforeSave;
  if FIniFileName = EmptyStr then
    raise EIniFileDataStorage.Create(TEXT_WRONG_INIFILE_NAME);
  ini_file := TMemIniFile.Create(FIniFileName);
  try
    try
      Saving(ini_file);
      if ini_file is TMemIniFile then
        (ini_file as TMemIniFile).UpdateFile;
    except
      on EIniFileException do
        raise EIniFileException.Create(TEXT_SAVE_INIFILE_ERROR);
    end;
  finally
    ini_file.Free;
  end;
end;

initialization

begin
  RegisterClass(TIniFileDataStorage);
end;

end.
