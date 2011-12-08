/// <summary>
/// ������-������ ������ TWatchThreadClass
/// </summary>
/// <remarks>
/// (C)opyright 2011 by Vlad Ivanov aka Caster
/// </remarks>
unit uWatchThreadClass;

interface

uses
  System.Classes,
  Winapi.Windows,
  uCommon;

type

  /// <summary>
  /// �����, ��������� <b>TThread</b>, �������������� �������� ������������� ���� � ���������
  /// ��� �������� ���������� ��������������� Handle.
  /// </summary>
  TWatchThreadClass=class(TThread)
  strict private
    /// <summary>
    /// Handle ����, �� �������������� �������� ���������� �������
    /// </summary>
    FWatchHandle: Thandle;

    /// <summary>
    /// Handle ����, � ������� ���������� ��������� ��������� � ���������� ����
    /// </summary>
    FListenerHandle: Thandle;

    /// <summary>
    /// ��������������������� ��������� (��������, ������������ ��������
    /// <b>RegisterWindowMessage</b>).
    /// </summary>
    FMessage: cardinal;

    /// <summary>
    /// ������ �������� ���������
    /// </summary>
    FWParam: WPARAM;

    /// <summary>
    /// ������ �������� ���������
    /// </summary>
    FLParam: LPARAM;

    /// <summary>
    /// ����� �������� � ������������ ����� ������� ������������ Handle
    /// </summary>
    FPause: integer;
  protected

    /// <summary>
    /// ������� ���� ������
    /// </summary>
    procedure Execute; override;
  public

    /// <summary>
    /// ����������� ������.
    /// </summary>
    /// <param name="WatchHandle">
    /// <b>Handle</b> ����, �� �������������� �������� ���������� �������
    /// </param>
    /// <param name="ListenerHandle">
    /// <b>Handle</b> ����, � ������� ���������� ��������� ��������� �
    /// ���������� ����
    /// </param>
    /// <param name="Msg">
    /// ��������������������� ��������� (��������, ������������ ��������
    /// <b>RegisterWindowMessage</b>).
    /// </param>
    /// <param name="wParam">
    /// <b>�������������� ��������.</b> ������ �������� ���������. ��
    /// ��������� ����� 0.
    /// </param>
    /// <param name="lParam">
    /// <b>�������������� ��������.</b> ������ �������� ���������. ��
    /// ��������� ����� 0.
    /// </param>
    /// <param name="Pause">
    /// <b>�������������� ��������.</b> ����� �������� � ������������ �����
    /// ������� �������� ���������. �� ��������� ����� 1000 (1 ���.)
    /// </param>
    constructor Create(const WatchHandle, ListenerHandle: THandle; const Msg: cardinal; const wParam: WPARAM=0; const lParam: LPARAM=0; const Pause: integer=CONST_DEFAULTVALUE_WATCHPAUSE);
  end;

implementation

constructor TWatchThreadClass.Create(const WatchHandle, ListenerHandle: THandle; const Msg: cardinal; const wParam: WPARAM=0; const lParam: LPARAM=0; const Pause: integer=CONST_DEFAULTVALUE_WATCHPAUSE);
begin
  inherited Create(True);
  Priority:=tpLower;
  FreeOnTerminate:=True;
  FWatchHandle:=WatchHandle;
  FListenerHandle:=ListenerHandle;
  FMessage:=Msg;
  FWParam:=wParam;
  FLParam:=lParam;
  FPause:=Pause;
end;

procedure TWatchThreadClass.Execute;
begin
  inherited;
  while not Terminated do
    begin
      if not IsWindow(FWatchHandle) then
        PostMessage(FListenerHandle, FMessage, FWParam, FLParam);
      Sleep(FPause);
    end;
end;

end.
