unit OA5.uViewMessagesForm;

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
    btnDelete: TButton;
    btnClose: TButton;
    btnHelp: TButton;
    btnCreate: TButton;
    btnView: TButton;
  end;

implementation

{$R *.dfm}

end.
