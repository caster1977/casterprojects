unit uRetranslatorThreadClass;

interface

uses
  System.Classes,
  Winapi.Windows,
  uCommon;

type
  ///	<summary>
  ///	  �����, ��������� <b>TThread</b>, �������������� ���������� ����������
  ///	  ��� �������� ���������� �������������� ��������� ��� ������ �������
  ///	  <b>BroadcastSystemMessage</b>.
  ///	</summary>
  TRetranslatorThreadClass=class(TThread)
  strict private
    FPause: integer;
    FMessage: cardinal;
    FWParam: WPARAM;
    FLParam: LPARAM;
  protected
    procedure Execute; override;
  public
    ///	<summary>
    ///	  ����������� ������.
    ///	</summary>
    ///	<param name="Msg">
    ///	  ��������������������� ��������� (��������, ������������ ��������
    ///	  <b>RegisterWindowMessage</b>).�
    ///	</param>
    ///	<param name="wParam">
    ///	  <b>�������������� ��������.</b> ������ �������� ���������. ��
    ///	  ��������� ����� 0.
    ///	</param>
    ///	<param name="lParam">
    ///	  <b>�������������� ��������.</b> ������ �������� ���������. ��
    ///	  ��������� ����� 0.
    ///	</param>
    ///	<param name="Pause">
    ///	  <b>�������������� ��������.</b> ����� �������� � ������������ �����
    ///	  ������� �������� ���������. �� ��������� ����� 1000 (1 ���.)
    ///	</param>
    constructor Create(const Msg: cardinal; const wParam: WPARAM = 0; const lParam: LPARAM = 0; const Pause: integer=CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
  end;

implementation

var
  Recipients: DWORD=BSM_APPLICATIONS;

constructor TRetranslatorThreadClass.Create(const Msg: cardinal; const wParam: WPARAM = 0; const lParam: LPARAM = 0; const Pause: integer=CONST_DEFAULTVALUE_RETRANSLATORPAUSE);
begin
  inherited Create(True);
  Priority:=tpLower;
  FreeOnTerminate:=True;
  FPause:=Pause;
  FMessage:=Msg;
  FWParam:=wParam;
  FLParam:=lParam;
end;

procedure TRetranslatorThreadClass.Execute;
begin
  while not Terminated do
    begin
      BroadcastSystemMessage(BSF_IGNORECURRENTTASK or BSF_POSTMESSAGE, @Recipients, FMessage, FWParam, FLParam); // PostMessage(HWND_BROADCAST, FMessage, FWParam, FLParam);
      Sleep(FPause);
    end;
end;

end.
