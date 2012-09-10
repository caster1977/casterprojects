object ViewMessageForm: TViewMessageForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1086#1083#1091#1095#1077#1085#1085#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
  ClientHeight = 322
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 624
    Height = 284
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      624
      284)
    object lblFrom: TLabel
      Left = 0
      Top = 30
      Width = 44
      Height = 13
      Caption = '&'#1054#1090' '#1082#1086#1075#1086':'
      FocusControl = edbxFrom
    end
    object lblTheme: TLabel
      Left = 0
      Top = 3
      Width = 28
      Height = 13
      Caption = '&'#1058#1077#1084#1072':'
      FocusControl = edbxTheme
    end
    object lblWhen: TLabel
      Left = 311
      Top = 30
      Width = 66
      Height = 13
      Anchors = [akTop, akRight]
      Caption = '&'#1054#1090#1087#1088#1072#1074#1083#1077#1085#1086':'
      FocusControl = edbxWhen
    end
    object reMessage: TRichEdit
      Left = 0
      Top = 54
      Width = 624
      Height = 230
      Hint = #1058#1077#1082#1089#1090' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Align = alBottom
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
      WantReturns = False
    end
    object edbxTheme: TEdit
      Left = 50
      Top = 0
      Width = 574
      Height = 21
      Hint = #1058#1077#1084#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
      Text = '<'#1055#1091#1089#1090#1086'>'
    end
    object edbxFrom: TEdit
      Left = 50
      Top = 27
      Width = 255
      Height = 21
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 1
      Text = '<'#1055#1091#1089#1090#1086'>'
    end
    object edbxWhen: TEdit
      Left = 383
      Top = 27
      Width = 243
      Height = 21
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1077#1083#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Anchors = [akTop, akRight]
      ReadOnly = True
      TabOrder = 2
      Text = '<'#1055#1091#1089#1090#1086'>'
    end
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 290
    Width = 624
    Height = 32
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    Color = clHotLight
    TabOrder = 1
    DesignSize = (
      624
      30)
    object btnProcess: TButton
      Left = 0
      Top = 5
      Width = 179
      Height = 25
      Cursor = crHandPoint
      Action = actProcess
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
    object btnPrevious: TButton
      Left = 274
      Top = 5
      Width = 83
      Height = 25
      Cursor = crHandPoint
      Action = actPrevious
      Anchors = [akTop, akRight]
      TabOrder = 2
    end
    object btnNext: TButton
      Left = 363
      Top = 5
      Width = 83
      Height = 25
      Cursor = crHandPoint
      Action = actNext
      Anchors = [akTop, akRight]
      TabOrder = 3
    end
    object btnHelp: TButton
      Left = 541
      Top = 5
      Width = 83
      Height = 25
      Cursor = crHandPoint
      Action = actHelp
      Anchors = [akTop, akRight]
      TabOrder = 5
    end
    object btnDelete: TButton
      Left = 185
      Top = 5
      Width = 83
      Height = 25
      Cursor = crHandPoint
      Action = actDelete
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btnClose: TButton
      Left = 452
      Top = 5
      Width = 83
      Height = 25
      Cursor = crHandPoint
      Action = actClose
      Anchors = [akTop, akRight]
      Cancel = True
      Default = True
      TabOrder = 4
    end
  end
  object ImageList: TImageList
    AllocBy = 2
    Left = 248
    Top = 128
    Bitmap = {
      494C0101020020007C0210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005346450053464500534645005346450053464500534645000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B58E
      7B00B5928400F7E3D600EFE3DE00EFE3DE00F7E7DE00F7E3D600BDA69C005346
      450053464500000000000000000000000000B7A2930063493500634935006349
      3500634935006349350063493500634935006349350000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDA69C00F7E7
      DE00FFF3F700E7DBD600DEB29C00D6A68C00E7C7BD00EFEBEF00F7F3F700F7E3
      D600E7CBBD00534645000000000000000000B7A29300FCFBFA00EAE0D800EADF
      D700E6D9D100E0D2C800DACABE00D6C4B8006349350000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDA69C00F7EBE700FFFF
      FF00C68E7300BD5D2900BD5D2900DEB29C00BD5D2900BD5D2900D69E8400F7F3
      F700F7E7DE00D6C7BD005346450000000000B7A29300FCFBFA00EBB69A00E3B2
      9700DBAC9300D4A79000CCA28E00D6C4B8006349350063493500634935006349
      3500634935006349350063493500634935000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDA69C00FFFFFF00CE6D
      4200BD5D2900BD5D2900C6A29400FFFFFF00E7825200BD5D2900BD5D2900D696
      7300FFFBF700F7E3D6005346450000000000BBA69700FEFEFD00FCFBFA00F9F5
      F300F5EEEA00EEE5DF00E9DDD500D6C4B80063493500E1C9BB00DDC1B200DABA
      A900D6B2A000D2AA9700CFA48F00634935000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDA69C00FFFBFF00DE9E7B00BD5D
      2900CE653100CE653100CE693900D68A6300CE653100CE653100BD5D2900BD5D
      2900E7CBBD00F7EFEF00DECBC60053464500C1AB9C00FDFDFC00EAB79A00E3B2
      9700DBAD9300D3A79000CCA28D00D6C4B80063493500F4E9E200F1E2D900EEDA
      D000EAD3C700E7CDBF00D2AA9700634935000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD00FFF7F700C6613100BD5D
      2900CE653100BD5D2900CE866300F7E7DE00D6693900BD5D2900CE653100BD5D
      2900CE714200FFFFFF00E7CBBD0053464500C7B2A300FDFCFB00FDFCFC00FEFD
      FD00FDFBF900F2EBE700D8D5D300D7C6BA0063493500C2B3A800F6ECE500F1E2
      D900EEDAD000EAD3C700D6B2A000634935000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD00F7DFD600BD5D2900CE65
      3100CE653100BD5D2900D6825200FFFBFF00E7AE9400BD5D2900BD5D2900CE65
      3100BD5D2900FFEFEF00F7DFD60053464500CFB9A900FCFBFA00EAB79900E4B2
      9700DCAC9400B7A29300644A3600644A3600644A3600D1C3BB00D5CBC300F4EA
      E500F1E2D900EEDAD000DABAA900634935000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD00F7D7CE00CE653100CE65
      3100CE653100CE653100BD5D2900DEAA9400FFF7F700EF9E7300BD5D2900CE65
      3100BD5D2900F7F3EF00EFE3DE0053464500D4BEAF00FCFBFA00FCFBFA00FCFB
      FA00FDFCFB00BBA69600D4C5BA00644A3600E2DDD900FDFBFA00FCF9F700F8F1
      EC001F47D70025409E00DDC1B200634935000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD00FFEFE700D6693900CE65
      3100CE653100BD5D2900BD5D2900BD5D2900E7CFC600FFFFFF00D6693900CE65
      3100CE693900FFFBFF00F7DFD60053464500D8C2B200FCFBFA00FCFBFA00FCFB
      FA00FCFBFA00C7B1A200644A3600E2DDD9000000000000000000FDFBFA00FBF6
      F3003C5EF6001F47D700E1C9BB00634935000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD00FFFFFF00F79A6B00D669
      3900CE8E6B00F7EBE700D6825200BD5D2900D6967300FFFFFF00E78E5A00BD5D
      2900EF926300FFFFFF00D6C7BD0053464500D8C2B200D8C2B200D4BFAE00D4BF
      AE00CEB8A900C8B2A300E9E2DE0000000000000000000000000000000000FDFB
      FA00FBF6F300F8F0EB00F4E9E200634935000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6C7BD00FFEBDE00EF86
      5200E7825200F7F7F700FFFFFF00DEBAAD00FFFFFF00F7F7F700DE714200D671
      3900FFF3EF00F7E7E7005346450000000000000000000000000000000000C5AF
      A000E9D9CF00E9D9CF00E9D9CF00E9D9CF00E7D5CA00E4CEC200E0C7B900DCBF
      AF00D8B6A500D4AF9C00D1A89400A99688000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6C7BD00FFFFFF00FFEF
      D600FFAA7300EFAA8C00EFE3DE00EFEFEF00F7E7E700FFA67B00F78E5A00F7DB
      CE00FFFFFF00D6C7BD0000000000000000000000000000000000000000000000
      0000CBB7AA00F3EEEB00FCFCFC00FAF7F600F8F1EE00F5EBE600F3E4DC00F1DE
      D500EFDBCF00E8D4C900B09B8D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6C7BD00FFFF
      FF00FFFFFF00FFF3C600FFDFAD00FFD39C00FFC79400FFD7AD00FFFFFF00FFFF
      FF00D6C7BD000000000000000000000000000000000000000000000000000000
      000000000000CBB7AA00F3EEEB0000000000FDFBFA00FAF5F300F7EFEA00F4E8
      E200E8D7CE00B09C8E0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6C7
      BD00D6C7BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFBFF00DECBC600D6C7
      BD00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CBB7AA00F3EEEB0000000000FEFCFC00FCF8F700F3EC
      E800B09D90000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DECBC600D6C7BD00D6C7BD00D6C7BD00D6C7BD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C5AFA000C5AFA000C5AFA000C4AE9F00C2AD
      9E00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F81FFFFF00000000E007007F00000000
      C003007F00000000800100000000000080010000000000000000000000000000
      000000000000000000000000000000000000000000000000000000C000000000
      000001E0000000008001E000000000008003F00100000000C007F90300000000
      E00FFC8700000000F83FFE0F0000000000000000000000000000000000000000
      000000000000}
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 248
    Top = 80
    object actClose: TAction
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      OnExecute = actCloseExecute
    end
    object actHelp: TAction
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1089#1087#1088#1072#1074#1082#1091'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1089#1087#1088#1072#1074#1086#1095#1085#1086#1075#1086' '#1092#1072#1081#1083#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 0
      OnExecute = actHelpExecute
      OnUpdate = actHelpUpdate
    end
    object actDelete: TAction
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1076#1072#1085#1085#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      OnExecute = actDeleteExecute
    end
    object actPrevious: TAction
      Caption = #1055'&'#1088#1077#1076#1099#1076#1091#1097#1077#1077
      Hint = 
        #1055#1088#1077#1076#1099#1076#1091#1097#1077#1077' '#1085#1077#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1082' '#1087#1088#1077#1076#1099#1076 +
        #1091#1097#1077#1084#1091' '#1085#1077#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1084#1091' '#1089#1086#1086#1073#1097#1077#1085#1080#1102
      OnExecute = actPreviousExecute
    end
    object actNext: TAction
      Caption = #1057'&'#1083#1077#1076#1091#1102#1097#1077#1077
      Hint = 
        #1057#1083#1077#1076#1091#1102#1097#1077#1077' '#1085#1077#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1082' '#1089#1083#1077#1076#1091#1102#1097 +
        #1077#1084#1091' '#1085#1077#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1084#1091' '#1089#1086#1086#1073#1097#1077#1085#1080#1102
      OnExecute = actNextExecute
    end
    object actProcess: TAction
      Caption = '&'#1055#1086#1084#1077#1090#1080#1090#1100' '#1082#1072#1082' '#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1077
      Hint = 
        #1055#1086#1089#1090#1072#1074#1080#1090#1100' '#1087#1086#1084#1077#1090#1082#1091' '#1086' '#1087#1088#1086#1095#1090#1077#1085#1080#1080'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1084#1077#1090#1082#1080' '#1090#1077#1082#1091#1097#1077#1075#1086' '#1089#1086#1086#1073#1097 +
        #1077#1085#1080#1103', '#1082#1072#1082' '#1087#1088#1086#1095#1080#1090#1072#1085#1085#1086#1075#1086
      OnExecute = actProcessExecute
    end
  end
end
