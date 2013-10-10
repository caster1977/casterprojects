object ArchivingBoxCapacityConfigMainForm: TArchivingBoxCapacityConfigMainForm
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  BorderWidth = 6
  Caption = 'RsCaption'
  ClientHeight = 241
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 210
    Width = 470
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      470
      31)
    object btnCancel: TButton
      Left = 395
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actCancel
      Anchors = [akRight, akBottom]
      Cancel = True
      TabOrder = 1
    end
    object btnSave: TButton
      Left = 315
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actSave
      Anchors = [akRight, akBottom]
      TabOrder = 0
    end
  end
  object vleArchiveBoxCapacity: TValueListEditor
    Left = 0
    Top = 0
    Width = 470
    Height = 210
    Align = alClient
    Strings.Strings = (
      '=')
    TabOrder = 1
    TitleCaptions.Strings = (
      'RsTypes'
      'RsCapacity')
    OnValidate = vleArchiveBoxCapacityValidate
    ColWidths = (
      384
      80)
  end
  object ActionList: TActionList
    Left = 88
    Top = 135
    object actSave: TAction
      Caption = 'RsSave'
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
    end
    object actCancel: TAction
      Caption = 'RsCancel'
      OnExecute = actCancelExecute
    end
  end
  object ADOConnection: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI10.1;Integrated Security=SSPI;Persist Security I' +
      'nfo=False;User ID="";Initial Catalog=RTL;Data Source=MOSTRA-822;' +
      'Initial File Name="";Server SPN=""'
    Provider = 'SQLNCLI10.1'
    Left = 160
    Top = 141
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
    Left = 264
    Top = 141
  end
end
