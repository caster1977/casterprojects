unit CastersPackage.uTIniFileDataStorage;

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils,
  CastersPackage.uIIniFileDataStorage;

type
  EIniFileDataStorage=class(Exception);

  TIniFileDataStorage=class(TInterfacedPersistent, IIniFileDataStorage)
  strict protected
    FIniFileName: string;
    procedure Initialize; virtual; abstract;
    procedure Loading(const AIniFile: TIniFile); virtual; abstract;
    procedure AfterLoad; virtual; abstract;
    procedure BeforeSave; virtual; abstract;
    procedure Saving(const AIniFile: TIniFile); virtual; abstract;
  public
    procedure Load; virtual; final;
    procedure Save; virtual; final;
    constructor Create(const AIniFileName: string=''); virtual;
  end;

  TIniFileDataStorageClass = class of TIniFileDataStorage;

implementation

uses
  Vcl.Forms;

resourcestring
  TEXT_WRONG_INIFILE_NAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_SAVE_INIFILE_ERROR='Произошла ошибка при попытке записи данных в файл конфигурации!';

constructor TIniFileDataStorage.Create(const AIniFileName: string);
var
  s: string;
begin
  inherited Create;
  s:=Trim(AIniFileName);
  if s=EmptyStr then
    FIniFileName:=ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')
  else
    FIniFileName:=s;
  Initialize;
end;

procedure TIniFileDataStorage.Load;
var
  IniFile: TIniFile;
begin
  if FIniFileName=EmptyStr then
    raise EIniFileDataStorage.Create(TEXT_WRONG_INIFILE_NAME);
  IniFile:=TIniFile.Create(FIniFileName);
  try
    Loading(IniFile);
  finally
    IniFile.Free;
  end;
  AfterLoad;
end;

procedure TIniFileDataStorage.Save;
var
  IniFile: TIniFile;
begin
  BeforeSave;
  if FIniFileName=EmptyStr then
    raise EIniFileDataStorage.Create(TEXT_WRONG_INIFILE_NAME);
  IniFile:=TIniFile.Create(FIniFileName);
  try
    try
      Saving(IniFile);
    except
      on EIniFileException do
        raise EIniFileException.Create(TEXT_SAVE_INIFILE_ERROR);
    end;
  finally
    IniFile.Free;
  end;
end;

initialization

RegisterClass(TIniFileDataStorage);

end.
