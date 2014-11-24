object DBUServer: TDBUServer
  OldCreateOrder = False
  OnDestroy = ServiceDestroy
  DisplayName = 'DBU Server Service'
  BeforeUninstall = ServiceBeforeUninstall
  OnContinue = ServiceContinue
  OnPause = ServicePause
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 90
  Width = 120
  object IdCmdTCPServer: TIdCmdTCPServer
    Bindings = <>
    DefaultPort = 0
    OnConnect = IdCmdTCPServerConnect
    OnDisconnect = IdCmdTCPServerDisconnect
    CommandHandlers = <
      item
        CmdDelimiter = ' '
        Command = 'TCP_RESERVE_NEW_DBUPDATE_NUMBER'
        Disconnect = False
        Name = 'GetReserveNewDBUpdateNumbersHandler'
        NormalReply.Code = '200'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = GetReserveNewDBUpdateNumbersCommand
      end
      item
        CmdDelimiter = ' '
        Command = 'TCP_CONNECTION_TEST'
        Disconnect = False
        ExceptionReply.Text.Strings = (
          'CONNECTION TEST FAIL')
        Name = 'ConnectionTestHandler'
        NormalReply.Code = '201'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = IdCmdTCPServerCommandHandlers1Command
      end
      item
        CmdDelimiter = ' '
        Command = 'TCP_GET_DBU_NEW_NUMBER_LOG'
        Disconnect = False
        Name = 'NewNumberLogHandler'
        NormalReply.Code = '202'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = NewNumberLogCommand
      end
      item
        CmdDelimiter = ' '
        Command = 'TCP_GET_DBU_SQL_ACTION_ITEMS'
        Disconnect = False
        Name = 'GetSqlActionItemsHandler'
        NormalReply.Code = '203'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = GetSqlActionItemsCommand
      end
      item
        CmdDelimiter = ' '
        Command = 'TCP_GET_DBU_SQL_SUBJ_ITEMS'
        Disconnect = False
        Name = 'GetSqlSubjItemsHandler'
        NormalReply.Code = '204'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = GetSqlSubjItemsCommand
      end
      item
        CmdDelimiter = ' '
        Command = 'TCP_GET_DBU_NEW_NUMBER_LOG_GRID'
        Disconnect = False
        Name = 'GetNewNumberLogGridHandler'
        NormalReply.Code = '205'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = GetNewNumberLogGridCommand
      end
      item
        CmdDelimiter = ' '
        Command = 'TCP_GET_DBU_DATABASE_TYPE_ITEMS'
        Disconnect = False
        Name = 'GetDbuDatabaseTypeItemsHandler'
        NormalReply.Code = '206'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = GetDbuDatabaseTypeItemsCommand
      end
      item
        CmdDelimiter = ' '
        Command = 'TCP_GET_DBU_STATES_ITEMS'
        Disconnect = False
        Name = 'GetDbuStatesItemsHandler'
        NormalReply.Code = '207'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = GetDbuStatesItemsCommand
      end
      item
        CmdDelimiter = ' '
        Command = 'TCP_ADD_NEW_DATABASE_TYPE'
        Disconnect = False
        Name = 'AddNewDatabaseTypeHandler'
        NormalReply.Code = '208'
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = AddNewDatabaseTypeCommand
      end>
    ExceptionReply.Code = '500'
    ExceptionReply.Text.Strings = (
      'Unknown Internal Error')
    Greeting.Code = '200'
    Greeting.Text.Strings = (
      'Welcome')
    HelpReply.Code = '100'
    HelpReply.Text.Strings = (
      'Help follows')
    MaxConnectionReply.Code = '300'
    MaxConnectionReply.Text.Strings = (
      'Too many connections. Try again later.')
    ReplyTexts = <>
    ReplyUnknownCommand.Code = '400'
    ReplyUnknownCommand.Text.Strings = (
      'Unknown Command')
    Left = 40
    Top = 16
  end
end
