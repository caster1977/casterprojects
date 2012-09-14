unit OA5.uConfigurationClass2;

interface

uses
  System.IniFiles,
  OA5.uTestConfiguration;

const
  DefaultValue_ShowSplashAtStart=True;
  DefaultValue_ShowToolbar=True;
  DefaultValue_ShowStatusbar=True;
  DefaultValue_ShowEditboxHints=True;
  DefaultValue_ShowCommonSearchEditbox=True;
  DefaultValue_ShowID=False;
  DefaultValue_UseMultibuffer=True;
  DefaultValue_ShowConfirmationOnQuit=True;

resourcestring
  TEXT_ShowSplashAtStart='bShowSplashAtStart';
  TEXT_ShowToolbar='bShowToolbar';
  TEXT_ShowStatusbar='bShowStatusbar';
  TEXT_ShowEditboxHints='bShowEditboxHints';
  TEXT_ShowCommonSearchEditbox='bShowCommonSearchEditbox';
  TEXT_ShowID='bShowID';
  TEXT_UseMultibuffer='bUseMultibuffer';
  TEXT_ShowConfirmationOnQuit='ShowConfirmationOnQuit';

type
  TIFS_Interface=class(TInterfaceIniFileSection)
  strict private
    FShowSplashAtStart: boolean; // Отображать окно "О программе..." при запуске
    FShowToolbar: boolean; // Отображать панель кнопок
    FShowStatusbar: boolean; // Отображать панель статуса
    FShowEditboxHints: boolean; // Отображать всплывающие подсказки для полей ввода
    FShowCommonSearchEditbox: boolean; // Отображать единое поле ввода для поиска данных
    FShowID: boolean; // Отображать поле ID записей базы данных при работе программы
    FUseMultibuffer: boolean; // Использовать мультибуфер для операций копирования мероприятий
    FShowConfirmationOnQuit: boolean; // Требовать подтверждение при выходе из программы
    procedure SetShowCommonSearchEditbox(const Value: boolean);
    procedure SetShowConfirmationOnQuit(const Value: boolean);
    procedure SetShowEditboxHints(const Value: boolean);
    procedure SetShowID(const Value: boolean);
    procedure SetShowSplashAtStart(const Value: boolean);
    procedure SetShowStatusbar(const Value: boolean);
    procedure SetShowToolbar(const Value: boolean);
    procedure SetUseMultibuffer(const Value: boolean);
  strict protected
    procedure Loading; override;
    procedure Saving; override;
  public
    constructor Create(const aFileName: string); override;
    property ShowSplashAtStart: boolean read FShowSplashAtStart write SetShowSplashAtStart default DefaultValue_ShowSplashAtStart;
    property ShowToolbar: boolean read FShowToolbar write SetShowToolbar default DefaultValue_ShowToolbar;
    property ShowStatusbar: boolean read FShowStatusbar write SetShowStatusbar default DefaultValue_ShowStatusbar;
    property ShowEditboxHints: boolean read FShowEditboxHints write SetShowEditboxHints default DefaultValue_ShowEditboxHints;
    property ShowCommonSearchEditbox: boolean read FShowCommonSearchEditbox write SetShowCommonSearchEditbox default DefaultValue_ShowCommonSearchEditbox;
    property ShowID: boolean read FShowID write SetShowID default DefaultValue_ShowID;
    property UseMultibuffer: boolean read FUseMultibuffer write SetUseMultibuffer default DefaultValue_UseMultibuffer;
    property ShowConfirmationOnQuit: boolean read FShowConfirmationOnQuit write SetShowConfirmationOnQuit default DefaultValue_ShowConfirmationOnQuit;
  end;

implementation

constructor TIFS_Interface.Create(const aFileName: string);
begin
  inherited;
  FShowSplashAtStart:=DefaultValue_ShowSplashAtStart;
  FShowToolbar:=DefaultValue_ShowToolbar;
  FShowStatusbar:=DefaultValue_ShowStatusbar;
  FShowEditboxHints:=DefaultValue_ShowEditboxHints;
  FShowCommonSearchEditbox:=DefaultValue_ShowCommonSearchEditbox;
  FShowID:=DefaultValue_ShowID;
  FUseMultibuffer:=DefaultValue_UseMultibuffer;
  FShowConfirmationOnQuit:=DefaultValue_ShowConfirmationOnQuit;
end;

procedure TIFS_Interface.Loading;
begin
  inherited;
  ShowSplashAtStart:=read(TEXT_ShowSplashAtStart, DefaultValue_ShowSplashAtStart);
  ShowToolbar:=read(TEXT_ShowToolbar, DefaultValue_ShowToolbar);
  ShowStatusbar:=read(TEXT_ShowStatusbar, DefaultValue_ShowStatusbar);
  ShowEditboxHints:=read(TEXT_ShowEditboxHints, DefaultValue_ShowEditboxHints);
  ShowCommonSearchEditbox:=read(TEXT_ShowCommonSearchEditbox, DefaultValue_ShowCommonSearchEditbox);
  ShowID:=read(TEXT_ShowID, DefaultValue_ShowID);
  UseMultibuffer:=read(TEXT_UseMultibuffer, DefaultValue_UseMultibuffer);
  ShowConfirmationOnQuit:=read(TEXT_ShowConfirmationOnQuit, DefaultValue_ShowConfirmationOnQuit);
end;

procedure TIFS_Interface.Saving;
begin
  inherited;
  write(TEXT_ShowSplashAtStart, ShowSplashAtStart);
  write(TEXT_ShowToolbar, ShowToolbar);
  write(TEXT_ShowStatusbar, ShowStatusbar);
  write(TEXT_ShowEditboxHints, ShowEditboxHints);
  write(TEXT_ShowCommonSearchEditbox, ShowCommonSearchEditbox);
  write(TEXT_ShowID, ShowID);
  write(TEXT_UseMultibuffer, UseMultibuffer);
  write(TEXT_ShowConfirmationOnQuit, ShowConfirmationOnQuit);
end;

procedure TIFS_Interface.SetShowCommonSearchEditbox(const Value: boolean);
begin
  if FShowCommonSearchEditbox<>Value then
    FShowCommonSearchEditbox:=Value;
end;

procedure TIFS_Interface.SetShowConfirmationOnQuit(const Value: boolean);
begin
  if FShowConfirmationOnQuit<>Value then
    FShowConfirmationOnQuit:=Value;
end;

procedure TIFS_Interface.SetShowEditboxHints(const Value: boolean);
begin
  if FShowEditboxHints<>Value then
    FShowEditboxHints:=Value;
end;

procedure TIFS_Interface.SetShowID(const Value: boolean);
begin
  if FShowID<>Value then
    FShowID:=Value;
end;

procedure TIFS_Interface.SetShowSplashAtStart(const Value: boolean);
begin
  if FShowSplashAtStart<>Value then
    FShowSplashAtStart:=Value;
end;

procedure TIFS_Interface.SetShowStatusbar(const Value: boolean);
begin
  if FShowStatusbar<>Value then
    FShowStatusbar:=Value;
end;

procedure TIFS_Interface.SetShowToolbar(const Value: boolean);
begin
  if FShowToolbar<>Value then
    FShowToolbar:=Value;
end;

procedure TIFS_Interface.SetUseMultibuffer(const Value: boolean);
begin
  if FUseMultibuffer<>Value then
    FUseMultibuffer:=Value;
end;

end.
