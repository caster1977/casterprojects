unit uConfigurationForm;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan,
  Vcl.ImgList;

type
  TConfigurationForm=class(TForm)
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnDefaults: TButton;
    ilConfigurationFormSmallImages: TImageList;
    ActionManager1: TActionManager;
    Action_Defaults: TAction;
    Action_Apply: TAction;
    Action_Close: TAction;
    Action_Help: TAction;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  end;

implementation

{$R *.dfm}

uses
  uMainForm,
  uCommon;

procedure TConfigurationForm.FormCreate(Sender: TObject);
const
  ICON_CONFIGURATION=5;
begin
  ilConfigurationFormSmallImages.GetIcon(ICON_CONFIGURATION, Icon);
  Action_Help.Enabled:=Application.HelpFile<>'';
  MainForm.LogDebug('Действие "'+Action_Help.Caption+'" '+CommonFunctions.GetConditionalString(Action_Help.Enabled, 'в', 'от')+'ключено.');

  with MainForm.Configuration do
    begin
      // установка положения окна конфигурации в соответсвии со значениями конфигурации программы
      if ConfigurationFormPosition.Centered then
        Position:=poScreenCenter
      else
        begin
          Position:=poDesigned;
          if ConfigurationFormPosition.Left<Screen.WorkAreaLeft then
            Left:=Screen.WorkAreaLeft
          else
            if ConfigurationFormPosition.Left>Screen.WorkAreaLeft+Screen.WorkAreaWidth then
              Left:=Screen.WorkAreaLeft+Screen.WorkAreaWidth-Width
            else
              Left:=ConfigurationFormPosition.Left;
          if ConfigurationFormPosition.Top<Screen.WorkAreaTop then
            Top:=Screen.WorkAreaTop
          else
            if ConfigurationFormPosition.Top>Screen.WorkAreaTop+Screen.WorkAreaHeight then
              Top:=Screen.WorkAreaTop+Screen.WorkAreaHeight-Height
            else
              Top:=ConfigurationFormPosition.Top;
        end;
    end;
end;

procedure TConfigurationForm.FormShow(Sender: TObject);
begin
  MainForm.LogInfo('Отображено окно настроек программы.');
end;

end.
