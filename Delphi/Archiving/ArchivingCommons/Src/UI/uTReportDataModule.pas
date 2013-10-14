{$DEFINE NOPRINT}
unit uTReportDataModule;

interface

uses
  SysUtils,
  Classes,
  frxClass,
  uIArchiveBoxItem;

type
  TReportDataModule = class(TDataModule)
    frxArchiveBoxSticker10x10: TfrxReport;
    frxArchiveBoxSticker20x10: TfrxReport;
    procedure frxArchiveBoxSticker10x10AfterPrintReport(Sender: TObject);
  end;

  TStickerType = (st10x10, st20x10);

function PrintSticker(const ACompanyName, ATypeCode, ACompanyCode, AYear, ANumber, ABarcode: string;
  const AStickerType: TStickerType; const ASilent: Boolean = True): Boolean;

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
  const AStickerType: TStickerType; const ASilent: Boolean): Boolean;
var
  form: TReportDataModule;
  memo: TfrxMemoView;
  barcode: TfrxBarcodeView;
begin
  form := TReportDataModule.Create(Application.Mainform);
  try
    case AStickerType of
      st10x10:
        begin
          memo := TfrxMemoView(form.frxArchiveBoxSticker10x10.FindObject('CompanyName'));
          memo.memo.Clear;
          memo.memo.Add(ACompanyName);

          memo := TfrxMemoView(form.frxArchiveBoxSticker10x10.FindObject('TypeCode'));
          memo.memo.Clear;
          memo.memo.Add(ATypeCode);

          memo := TfrxMemoView(form.frxArchiveBoxSticker10x10.FindObject('CompanyCode'));
          memo.memo.Clear;
          memo.memo.Add(ACompanyCode);

          memo := TfrxMemoView(form.frxArchiveBoxSticker10x10.FindObject('Year'));
          memo.memo.Clear;
          memo.memo.Add(AYear);

          memo := TfrxMemoView(form.frxArchiveBoxSticker10x10.FindObject('Number'));
          memo.memo.Clear;
          memo.memo.Add(ANumber);

          barcode := TfrxBarcodeView(form.frxArchiveBoxSticker10x10.FindObject('BarCode'));
          barcode.Text := ABarcode;

          form.frxArchiveBoxSticker10x10.PrepareReport;
          form.frxArchiveBoxSticker10x10.PrintOptions.Duplex := dmNone;
          form.frxArchiveBoxSticker10x10.PrintOptions.ShowDialog := not ASilent;
          form.frxArchiveBoxSticker10x10.PrintOptions.Copies := 1;
{$IFNDEF NOPRINT}
          if ASilent then
          begin
            form.frxArchiveBoxSticker10x10.Print;
          end
          else
          begin
            form.frxArchiveBoxSticker10x10.ShowPreparedReport;
          end;
{$ENDIF}
        end;
      st20x10:
        begin
          memo := TfrxMemoView(form.frxArchiveBoxSticker20x10.FindObject('CompanyName'));
          memo.memo.Clear;
          memo.memo.Add(ACompanyName);

          memo := TfrxMemoView(form.frxArchiveBoxSticker20x10.FindObject('TypeCode'));
          memo.memo.Clear;
          memo.memo.Add(ATypeCode);

          memo := TfrxMemoView(form.frxArchiveBoxSticker20x10.FindObject('CompanyCode'));
          memo.memo.Clear;
          memo.memo.Add(ACompanyCode);

          memo := TfrxMemoView(form.frxArchiveBoxSticker20x10.FindObject('Year'));
          memo.memo.Clear;
          memo.memo.Add(AYear);

          memo := TfrxMemoView(form.frxArchiveBoxSticker20x10.FindObject('Number'));
          memo.memo.Clear;
          memo.memo.Add(ANumber);

          barcode := TfrxBarcodeView(form.frxArchiveBoxSticker20x10.FindObject('BarCode'));
          barcode.Text := ABarcode;

          form.frxArchiveBoxSticker20x10.PrepareReport;
          form.frxArchiveBoxSticker20x10.PrintOptions.Duplex := dmNone;
          form.frxArchiveBoxSticker20x10.PrintOptions.ShowDialog := not ASilent;
          form.frxArchiveBoxSticker20x10.PrintOptions.Copies := 1;

{$IFNDEF NOPRINT}
          if ASilent then
          begin
            form.frxArchiveBoxSticker20x10.Print;
          end
          else
          begin
            form.frxArchiveBoxSticker20x10.ShowPreparedReport;
          end;
{$ENDIF}
        end;
    end;
  finally
{$IFDEF NOPRINT}
    Result := True;
{$ELSE}
    Result := FStickerWasPrinted;
{$ENDIF}
    FreeAndNil(form);
  end;
end;

procedure TReportDataModule.frxArchiveBoxSticker10x10AfterPrintReport(Sender: TObject);
begin
  FStickerWasPrinted := True;
end;

initialization

FStickerWasPrinted := False;

end.
