unit uConfigurationForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ActnList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan, Vcl.ImgList;

type
  TConfigurationForm = class(TForm)
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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

{$R *.dfm}

end.
