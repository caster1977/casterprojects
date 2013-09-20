{$DEFINE NOPRINT}
unit uTReportDataModule;

interface

uses
  System.SysUtils,
  System.Classes,
  frxClass,
  uIArchiveBoxItem;

type
  TReportDataModule = class(TDataModule)
    frxArchiveBoxSticker: TfrxReport;
    procedure frxArchiveBoxStickerAfterPrintReport(Sender: TObject);
  end;

function PrintSticker(const ACompanyName, ATypeCode, ACompanyCode, AYear, ANumber, ABarcode: string;
  const ASilent: Boolean = True): Boolean;

exports PrintSticker;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

uses
  frxBarcode,
  Forms,
  Dialogs;

var
  FStickerWasPrinted: Boolean;

function PrintSticker(const ACompanyName, ATypeCode, ACompanyCode, AYear, ANumber, ABarcode: string;
  const ASilent: Boolean): Boolean;
var
  form: TReportDataModule;
  memo: TfrxMemoView;
  barcode: TfrxBarcodeView;
begin
  form := TReportDataModule.Create(Application.Mainform);
  try
    memo := TfrxMemoView(form.frxArchiveBoxSticker.FindObject('CompanyName'));
    memo.memo.Clear;
    memo.memo.Add(ACompanyName);

    memo := TfrxMemoView(form.frxArchiveBoxSticker.FindObject('TypeCode'));
    memo.memo.Clear;
    memo.memo.Add(ATypeCode);

    memo := TfrxMemoView(form.frxArchiveBoxSticker.FindObject('CompanyCode'));
    memo.memo.Clear;
    memo.memo.Add(ACompanyCode);

    memo := TfrxMemoView(form.frxArchiveBoxSticker.FindObject('Year'));
    memo.memo.Clear;
    memo.memo.Add(AYear);

    memo := TfrxMemoView(form.frxArchiveBoxSticker.FindObject('Number'));
    memo.memo.Clear;
    memo.memo.Add(ANumber);

    barcode := TfrxBarcodeView(form.frxArchiveBoxSticker.FindObject('BarCode'));
    barcode.Text := ABarcode;

    form.frxArchiveBoxSticker.PrepareReport;
    form.frxArchiveBoxSticker.PrintOptions.Duplex := dmNone;
    form.frxArchiveBoxSticker.PrintOptions.ShowDialog := not ASilent;
    form.frxArchiveBoxSticker.PrintOptions.Copies := 1;
{$IFNDEF NOPRINT}
    if ASilent then
    begin
      form.frxArchiveBoxSticker.Print;
    end
    else
    begin
      form.frxArchiveBoxSticker.ShowPreparedReport;
    end;
{$ENDIF}
  finally
{$IFDEF NOPRINT}
    Result := True;
{$ELSE}
    Result := FStickerWasPrinted;
{$ENDIF}
    FreeAndNil(form);
  end;
end;

procedure TReportDataModule.frxArchiveBoxStickerAfterPrintReport(Sender: TObject);
begin
  FStickerWasPrinted := True;
end;

initialization

FStickerWasPrinted := False;

end.
