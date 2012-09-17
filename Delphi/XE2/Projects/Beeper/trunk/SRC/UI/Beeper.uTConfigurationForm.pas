unit Beeper.uTConfigurationForm;

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
  Vcl.ComCtrls,
  Vcl.ExtCtrls,
  Vcl.StdActns,
  CastersPackage.Actions.Classes,
  Vcl.ActnList,
  Vcl.ImgList;

type
  TConfigurationForm = class(TForm)
    pnlHeader: TPanel;
    gbHeader: TGroupBox;
    cbPage: TComboBox;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    pnlButtons: TPanel;
    btnApply: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnDefaults: TButton;
    Panel1: TPanel;
    gbPage: TGroupBox;
    pcPage: TPageControl;
    tsInterface: TTabSheet;
    chkbxShowSplashAtStart: TCheckBox;
    chkbxShowToolbar: TCheckBox;
    chkbxShowStatusbar: TCheckBox;
    chkbxShowConfirmationOnQuit: TCheckBox;
    tsOther: TTabSheet;
    chkbxLaunchAtStartup: TCheckBox;
    ImageList: TImageList;
    ActionList: TActionList;
    actApply: TAction_Apply;
    actDefaults: TAction_Defaults;
    Action_Help: TAction_Help;
    actCancel: TAction_Cancel;
    actPreviousPage: TAction_PreviousPage;
    actNextPage: TAction_NextPage;
    procedure actCancelExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ConfigurationForm: TConfigurationForm;

implementation

{$R *.dfm}

procedure TConfigurationForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
