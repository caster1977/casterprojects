unit ViewPost;

interface

uses
	Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
	Dialogs, ComCtrls, ExtCtrls, StdCtrls, CheckLst, Buttons, mysql, Main, Grids;

type
	TViewPostForm = class(TForm)
		pnlButtons: TPanel;
    btnCreate: TButton;
		btnClose: TButton;
		btnHelp: TButton;
    StringGrid1: TStringGrid;
    btnEdit: TButton;
    btnDelete: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ViewPostForm: TViewPostForm;

implementation

{$R *.dfm}

end.
