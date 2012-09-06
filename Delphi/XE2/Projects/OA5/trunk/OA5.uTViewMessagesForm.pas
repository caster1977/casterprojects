unit OA5.uTViewMessagesForm;

interface

uses
  CastersPackage.uTLogForm,
  System.Classes,
  Vcl.Controls,
  Vcl.ImgList,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ActnList,
  Vcl.ComCtrls;

type
  TViewMessagesForm = class(TLogForm)
    ImageList: TImageList;
    ActionList: TActionList;
    actClose: TAction;
    actHelp: TAction;
    actDelete: TAction;
    actCreate: TAction;
    actOpen: TAction;
    ListView: TListView;
    pnlButtons: TPanel;
    btnCreate: TButton;
    btnView: TButton;
    btnDelete: TButton;
    btnClose: TButton;
    btnHelp: TButton;
  end;

implementation

{$R *.dfm}

end.
