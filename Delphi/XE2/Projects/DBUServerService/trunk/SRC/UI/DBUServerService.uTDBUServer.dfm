object DBUServer: TDBUServer
  OldCreateOrder = False
  DisplayName = 'DBU Server Service'
  BeforeUninstall = ServiceBeforeUninstall
  OnContinue = ServiceContinue
  OnPause = ServicePause
  OnShutdown = ServiceShutdown
  OnStart = ServiceStart
  OnStop = ServiceStop
  Height = 150
  Width = 215
  object IdCmdTCPServer: TIdCmdTCPServer
    Bindings = <
      item
        IP = '127.0.0.1'
        Port = 6000
      end>
    DefaultPort = 6000
    OnConnect = IdCmdTCPServerConnect
    OnDisconnect = IdCmdTCPServerDisconnect
    CommandHandlers = <
      item
        CmdDelimiter = ' '
        Command = 'TCP_CONNECTION_TEST'
        Disconnect = False
        ExceptionReply.Text.Strings = (
          'CONNECTION TEST FAIL')
        Name = 'ConnectionTestHandler'
        NormalReply.Code = '200'
        NormalReply.Text.Strings = (
          'CONNECTION TEST OK')
        ParamDelimiter = ' '
        ParseParams = True
        Tag = 0
        OnCommand = CmdTCPServerCommandHandlers0Command
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
