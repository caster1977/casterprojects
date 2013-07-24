unit uMainForm;

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
  DirectDraw;

type
  TMainForm = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    // FDD: IDirectDraw;
    FDD7: IDirectDraw7;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
var
  hRet: HRESULT; // ��������������� ����������
begin
  {
    // �������� �������� ������� DirectDraw
    FDD:=nil; // ��� ����������� ��� ��������� ���������� ������
    FDD7:=nil; // ��� ����������� ��� ��������� ���������� ������
    hRet:=DirectDrawCreate(nil, FDD, nil);
    if Failed(hRet) then // �������� ���������� ����������� ��������
    ShowMessage('������ ��� ���������� DirectDrawCreate') // �������������� �� ��������� 7-� ������ DirectX
    else
    hRet:=FDD.QueryInterface(IID_IDirectDraw7, FDD7);
    if Failed(hRet) then // ��� ���� �� ����, ��� ��� ���������� �� ��������
    ShowMessage('DirectX 7-� ������ �� ��������')
    else
    ShowMessage('DirectX 7-� ������ ��������');
    // ������������ ������, ������� ��������� if Assigned (FDD7) then FDD7 := nil;
    if Assigned(FDD7) then
    FDD7:=nil;
    if Assigned(FDD) then
    FDD:=nil;
  }
  FDD7 := nil; // ��� ����������� ��� ��������� ���������� ������
  try // �������� ���������� �����
    try // ... finally
      // �������� �������� ������� DirectDraw
      hRet := DirectDrawCreateEx(nil, FDD7, IDirectDraw7, nil);
      if Failed(hRet) // ������� ������ ��������� ���� �� ���������
      then
        ShowMessage('DirectX 7-� ������ �� ��������')
      else
        ShowMessage('DirectX 7-� ������ ��������');
    finally // ������ ������ ���������� ������������ ������
      if Assigned(FDD7) then
        FDD7 := nil;
    end;
  except // ������� ������ ����������� � �������
    ShowMessage('DirectX 7-� ������ �� ��������')
  end;
end;

end.
