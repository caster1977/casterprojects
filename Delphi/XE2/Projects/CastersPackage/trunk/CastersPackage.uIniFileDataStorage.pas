unit CastersPackage.uIniFileDataStorage;

interface

uses
  System.Classes,
  System.IniFiles,
  System.SysUtils;

type
  EIniFileDataStorage=class(Exception);

  IIniFileDataStorage=interface(IInterface)
    ['{C9872120-1001-47E3-B832-AC6BE58B52E0}']
    procedure AfterLoad;
    procedure BeforeSave;
    procedure Loading(const IniFile: TIniFile);
    procedure Saving(const IniFile: TIniFile);
    procedure Load;
    procedure Save;
  end;

  TIniFileDataStorage=class(TInterfacedPersistent, IIniFileDataStorage)
  strict protected
    FIniFileName: string;
    procedure AfterLoad; virtual; abstract;
    procedure BeforeSave; virtual; abstract;
    procedure Loading(const IniFile: TIniFile); virtual; abstract;
    procedure Saving(const IniFile: TIniFile); virtual; abstract;
  public
    procedure Load; virtual; final;
    procedure Save; virtual; final;
    constructor Create(const IniFileName: string=''); virtual;
  end;

  TIniFileDataStorageClass = class of TIniFileDataStorage;

implementation

uses
  Vcl.Forms;

resourcestring
  TEXT_WRONG_INIFILE_NAME='��� ����� ������������ �� ������ ���� ������!';
  TEXT_SAVE_INIFILE_ERROR='��������� ������ ��� ������� ������ ������ � ���� ������������!';

constructor TIniFileDataStorage.Create(const IniFileName: string);
var
  s: string;
begin
  inherited Create;
  s:=Trim(IniFileName);
  if s=EmptyStr then
    FIniFileName:=ChangeFileExt(ExpandFileName(Application.ExeName), '.ini')
  else
    FIniFileName:=s;
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