unit Options;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls,
  Registry;

type
  TOptionsForm= class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    CHECKBOX_MaximizeMainWindow: TCheckBox;
    RADIOGROUP_AlignColumns: TRadioGroup;
    CHECKBOX_ShowServerNameInTitle: TCheckBox;
    EDIT_ApplicationTitle: TEdit;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EDIT_LastUserLogin: TEdit;
    EDIT_LastUserPwd: TEdit;
    BUTTON_DropLastUser: TButton;
    CHECKBOX_SaveLastUser: TCheckBox;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    COMBOBOX_Servers: TComboBox;
    GroupBox4: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    EDIT_HostName: TEdit;
    EDIT_UserLogin: TEdit;
    EDIT_UserPwd: TEdit;
    EDIT_Port: TEdit;
    BUTTON_AddServer: TButton;
    CHECKBOX_UseCompression: TCheckBox;
    EDIT_Timeout: TEdit;
    EDIT_DBName: TEdit;
    BUTTON_DeleteServer: TButton;
    BUTTON_Apply: TButton;
    BUTTON_Cancel: TButton;
    BUTTON_Help: TButton;
    procedure BUTTON_DropLastUserClick(Sender: TObject);
  end;

var
  OptionsForm: TOptionsForm;

implementation

uses
  Main;
{$R *.DFM}

procedure TOptionsForm.BUTTON_DropLastUserClick(Sender: TObject);
begin
  with TRegistry.Create do
    try
      RootKey:=HKEY_CURRENT_USER;
      if OpenKey('\Software\Vlad DraCooLa\OPERARM', False)=True then
        begin
          DeleteValue('LastUser');
          DeleteValue('LastUserPwd');
          WriteBool('StoreLastUser', False);
        end;
    finally
      Free;
    end;
  EDIT_LastUserLogin.Text:=MainForm.LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastUser');
  EDIT_LastUserPwd.Text:=MainForm.LoadStringFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'LastUserPwd');
  CHECKBOX_SaveLastUser.Checked:=MainForm.LoadBoolFromRegistry('\Software\Vlad DraCooLa\OPERARM', 'StoreLastUser');
  BUTTON_DropLastUser.Enabled:=(EDIT_LastUserLogin.Text<>'')and(EDIT_LastUserPwd.Text<>'');
end;

end.
