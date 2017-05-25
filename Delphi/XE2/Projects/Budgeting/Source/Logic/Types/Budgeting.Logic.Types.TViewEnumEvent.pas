unit Budgeting.Logic.Types.TViewEnumEvent;

interface

type
  TViewEnumEvent = (
    veInitialization,
    veCloseQuery, veQuitUpdate, veConfigurationExecute, veConfigurationUpdate, veAboutExecute, veAboutUpdate,
    veHelpContextExecute, veHelpContextUpdate, veStatusBarExecute, veToolBarExecute, veConnectExecute, veConnectUpdate, veDisconnectExecute,
    veDisconnectUpdate,
    veEntityChanged,
    veRefreshExecute,
    veRefreshUpdate,
    veExportToExcelExecute, veExportToExcelUpdate,
    veSelectedRecordChanged,
    veAddExecute, veAddUpdate,
    veEditExecute, veEditUpdate,
    veDeleteExecute, veDeleteUpdate,
    veCancelExecute,
    veCancelUpdate,
    veSaveExecute,
    veSaveUpdate
    );

implementation

end.
