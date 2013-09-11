object TestLogicMainForm: TTestLogicMainForm
  Left = 0
  Top = 0
  BorderWidth = 6
  Caption = 'TestLogicMainForm'
  ClientHeight = 249
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 31
    Width = 372
    Height = 218
    Align = alClient
    Caption = 'GroupBox1'
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 372
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Button1: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 25
      Action = actTestLogic
      TabOrder = 0
    end
  end
  object SQLConnection: TSQLConnection
    ConnectionName = 'MSSQLConnection'
    DriverName = 'MSSQL'
    LoginPrompt = False
    Params.Strings = (
      'SchemaOverride=sa.dbo'
      'DriverName=MSSQL'
      'HostName=MOSTRA-822'
      'DataBase=RTL'
      'User_Name=user'
      'Password=password'
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OS Authentication=True'
      'Prepare SQL=False'
      'ConnectTimeout=60'
      'Mars_Connection=False')
    Left = 296
    Top = 113
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI10.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=RTL;Data Source=MOSTRA-822;' +
      'Initial File Name="";Server SPN=""'
    Provider = 'SQLNCLI10.1'
    Left = 216
    Top = 113
  end
  object ActionList: TActionList
    Left = 128
    Top = 104
    object actTestLogic: TAction
      Caption = 'Test Logic'
      OnExecute = actTestLogicExecute
    end
  end
end
