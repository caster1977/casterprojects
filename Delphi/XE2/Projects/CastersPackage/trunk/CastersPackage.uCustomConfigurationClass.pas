unit CastersPackage.uCustomConfigurationClass;

interface

uses
  System.IniFiles,
  System.SysUtils;

type
  IConfiguration=interface(IInterface)
    ['{CF958C07-639A-4B2C-9032-01596F27A6F7}']
    procedure Loading(const IniFile: TIniFile);
    procedure Saving(const IniFile: TIniFile);
    procedure Load;
    procedure Save;
  end;

  EConfiguration=class(Exception);

  TCustomConfiguration=class(TInterfacedObject, IConfiguration)
  strict protected
    FIniFileName: string;
    procedure Loading(const IniFile: TIniFile); virtual; abstract;
    procedure Saving(const IniFile: TIniFile); virtual; abstract;
  public
    constructor Create(const IniFileName: string='');
    procedure Load;
    procedure Save;
  end;

implementation

uses
  Vcl.Forms;

resourcestring
  TEXT_WRONG_INIFILE_NAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_SAVE_INIFILE_ERROR='Произошла ошибка при попытке записи настроек программы в файл конфигурации!';

constructor TCustomConfiguration.Create(const IniFileName: string);
begin
  inherited Create;
  if Trim(IniFileName)='' then
    FIniFileName:=ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')
  else
    FIniFileName:=Trim(IniFileName);
end;

procedure TCustomConfiguration.Load;
var
  IniFile: TIniFile;
begin
  if FIniFileName='' then
    raise EConfiguration.Create(TEXT_WRONG_INIFILE_NAME);
  IniFile:=TIniFile.Create(FIniFileName);
  try
    Loading(IniFile);
  finally
    IniFile.Free;
  end
end;

procedure TCustomConfiguration.Save;
var
  IniFile: TIniFile;
begin
  if FIniFileName='' then
    raise EConfiguration.Create(TEXT_WRONG_INIFILE_NAME);
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
  end
end;

end.
