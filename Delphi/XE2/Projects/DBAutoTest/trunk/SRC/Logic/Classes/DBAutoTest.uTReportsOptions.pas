unit DBAutoTest.uTReportsOptions;

interface

uses
  ConfigPackage.uTCustomSection,
  ConfigPackage.uTDefaultValueAttribute,
  ConfigPackage.uTSectionAttribute,
  DBAutoTest.uConsts;

type
  [TSection(REPORTS_SECTION)]
  TReportsOptions = class(TCustomSection)
  public
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_GENEDATE_FASTREPORT_DOCUMENT)]
    property EnableGenerateFastReportDocument: Boolean index 0 read GetBooleanValue write SetBooleanValue;
    [TDefaultValue(CONFIGURATION_DEFAULT_ENABLE_GENEDATE_EXCEL_DOCUMENT)]
    property EnableGenerateExcelDocument: Boolean index 1 read GetBooleanValue write SetBooleanValue;
  end;

implementation

end.
