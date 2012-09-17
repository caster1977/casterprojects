unit Beeper.uTConfigurationForm;

interface

uses
  Vcl.Forms,
  Vcl.ImgList,
  CastersPackage.Actions.Classes,
  Vcl.StdActns,
  System.Classes,
  Vcl.ActnList,
  Vcl.Controls,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  Vcl.ExtCtrls;

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
  end;

implementation

{$R *.dfm}

procedure TConfigurationForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
