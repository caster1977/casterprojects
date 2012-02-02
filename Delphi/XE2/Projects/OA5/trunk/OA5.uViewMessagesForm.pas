unit OA5.uViewMessagesForm;

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
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  CastersPackage.uLogProvider,
  Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls,
  Vcl.ActnMan, Vcl.ComCtrls;

type
  TViewMessagesForm=class(TForm)
    btnDelete: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnCreate: TButton;
    btnView: TButton;
    Bevel2: TBevel;
    ilViewMessagesFormSmallImages: TImageList;
    ActionManager1: TActionManager;
    Action_Close: TAction;
    Action_Help: TAction;
    Action_Delete: TAction;
    Log: TLogProvider;
    Action_Create: TAction;
    Action_Open: TAction;
    ListView1: TListView;
  end;

implementation

{$R *.dfm}

end.
