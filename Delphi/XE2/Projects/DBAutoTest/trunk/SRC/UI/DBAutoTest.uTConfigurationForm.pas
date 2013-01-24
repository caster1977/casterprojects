unit DBAutoTest.uTConfigurationForm;

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
  Vcl.ImgList,
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  CastersPackage.Actions.Classes,
  Vcl.StdActns,
  System.Actions,
  Vcl.ActnList;

type
  TConfigurationForm = class(TForm)
    actApply: TAction;
    actCancel: TAction;
    actDefaults: TAction_Defaults;
    actHelp: TAction_Help;
    ActionList: TActionList;
    actNextPage: TAction_NextPage;
    actPreviousPage: TAction_PreviousPage;
    btnApply: TButton;
    btnCancel: TButton;
    btnDefaults: TButton;
    btnHelp: TButton;
    btnNextPage: TButton;
    btnPreviousPage: TButton;
    cbPageName: TComboBox;
    chkbxPlaySoundOnComplete: TCheckBox;
    chkbxShowConfirmationOnQuit: TCheckBox;
    chkbxShowSplashAtStart: TCheckBox;
    chkbxShowStatusbar: TCheckBox;
    chkbxShowToolbar: TCheckBox;
    gbInterface: TGroupBox;
    gbOther: TGroupBox;
    gbResults: TGroupBox;
    gbTop: TGroupBox;
    ImageList: TImageList;
    PageControl: TPageControl;
    pnlButtons: TPanel;
    pnlTop: TPanel;
    tsInterface: TTabSheet;
    tsOther: TTabSheet;
    tsResults: TTabSheet;
    procedure actCancelExecute(Sender: TObject);
    procedure actNextPageExecute(Sender: TObject);
    procedure actPreviousPageExecute(Sender: TObject);
  private
    procedure SelectPage;
  end;

implementation

{$R *.dfm}

procedure TConfigurationForm.actCancelExecute(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TConfigurationForm.actNextPageExecute(Sender: TObject);
var
  i: Integer;
begin
  i := cbPageName.ItemIndex + 1;
  if i > cbPageName.Items.Count - 1 then
  begin
    i := 0;
  end;
  cbPageName.ItemIndex := i;
  SelectPage;
end;

procedure TConfigurationForm.actPreviousPageExecute(Sender: TObject);
var
  i: Integer;
begin
  i := cbPageName.ItemIndex - 1;
  if i < 0 then
  begin
    i := cbPageName.Items.Count - 1;
  end;
  cbPageName.ItemIndex := i;
  SelectPage;
end;

procedure TConfigurationForm.SelectPage;
var
  i: Integer;
begin
  for i := 0 to PageControl.PageCount - 1 do
  begin
    if PageControl.Pages[i].Caption = cbPageName.Items[cbPageName.ItemIndex] then
    begin
      PageControl.ActivePageIndex := i;
      Break;
    end;
  end;
end;

end.
