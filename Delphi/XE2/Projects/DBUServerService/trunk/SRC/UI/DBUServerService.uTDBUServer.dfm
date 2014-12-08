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
    CommandHandlers = <>
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
