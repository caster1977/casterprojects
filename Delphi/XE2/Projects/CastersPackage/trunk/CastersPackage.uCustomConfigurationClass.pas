unit CastersPackage.uCustomConfigurationClass;

interface

uses
  System.IniFiles,
  System.SysUtils;

type
  IConfiguration = interface(IInterface)
    ['{CF958C07-639A-4B2C-9032-01596F27A6F7}']
    procedure Loading(const IniFile: TIniFile);
    procedure Saving(const IniFile: TIniFile);
    procedure Load;
    procedure Save;
  end;

  TCustomConfiguration = class(TInterfacedObject,IConfiguration)
  protected
    FIniFileName: string;
    procedure Loading(const IniFile: TIniFile); virtual;
    procedure Saving(const IniFile: TIniFile); virtual;
  public
    constructor Create(const IniFileName: string='');
    procedure Load;
    procedure Save;
  end;

  EConfiguration = class(Exception);

implementation

resourcestring
  TEXT_WRONG_INIFILE_NAME='Имя файла конфигурации не должно быть пустым!';
  TEXT_SAVE_INIFILE_ERROR='Произошла ошибка при попытке записи настроек программы в файл конфигурации!';

procedure TCustomConfiguration.Load;
var
  IniFile: TIniFile;
begin
  if FIniFileName>'' then
    begin
      IniFile:=TIniFile.Create(FIniFileName);
      try
        Loading(IniFile);
      finally
        IniFile.Free;
      end
    end
  else
    raise EConfiguration.Create(TEXT_WRONG_INIFILE_NAME);
end;

procedure TCustomConfiguration.Save;
var
  IniFile: TIniFile;
begin
  if FIniFileName>'' then
    begin
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
    end
  else
    raise EConfiguration.Create(TEXT_WRONG_INIFILE_NAME);
end;

end.
