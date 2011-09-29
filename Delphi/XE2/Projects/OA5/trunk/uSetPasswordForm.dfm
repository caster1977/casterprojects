object SetPasswordForm: TSetPasswordForm
  Left = 0
  Top = 0
  Hint = #1054#1082#1085#1086' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1087#1072#1088#1086#1083#1103' '#1091#1095#1105#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103' '#1091#1095#1105#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
  ClientHeight = 121
  ClientWidth = 294
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
  DesignSize = (
    294
    121)
  PixelsPerInch = 96
  TextHeight = 13
  object lblPassword: TLabel
    Left = 8
    Top = 11
    Width = 76
    Height = 13
    Caption = '&'#1053#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100':'
    FocusControl = mePassword
  end
  object lblConfirmation: TLabel
    Left = 8
    Top = 38
    Width = 87
    Height = 13
    Caption = '&'#1055#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077':'
    FocusControl = meConfirmation
  end
  object Bevel2: TBevel
    Left = 0
    Top = 80
    Width = 294
    Height = 41
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 56
    ExplicitWidth = 212
  end
  object meConfirmation: TMaskEdit
    Left = 101
    Top = 35
    Width = 185
    Height = 21
    Hint = #1055#1086#1074#1090#1086#1088#1085#1086' '#1074#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    TextHint = #1055#1086#1074#1090#1086#1088#1085#1086' '#1074#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
  end
  object mePassword: TMaskEdit
    Left = 101
    Top = 8
    Width = 185
    Height = 21
    Hint = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    OnChange = FieldsChange
  end
  object chkbxShowPassword: TCheckBox
    Left = 8
    Top = 57
    Width = 278
    Height = 17
    Hint = #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1074#1074#1077#1076#1105#1085#1085#1086#1075#1086' '#1087#1072#1088#1086#1083#1103
    Anchors = [akLeft, akTop, akRight]
    Caption = '&'#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1087#1072#1088#1086#1083#1100
    TabOrder = 2
    OnClick = chkbxShowPasswordClick
  end
  object btnApply: TButton
    Left = 118
    Top = 88
    Width = 81
    Height = 25
    Cursor = crHandPoint
    Action = Action_Apply
    Anchors = [akRight, akBottom]
    TabOrder = 3
  end
  object btnHelp: TButton
    Left = 8
    Top = 88
    Width = 81
    Height = 25
    Cursor = crHandPoint
    Action = Action_Help
    Anchors = [akLeft, akBottom]
    TabOrder = 4
  end
  object btnClose: TButton
    Left = 205
    Top = 88
    Width = 81
    Height = 25
    Cursor = crHandPoint
    Action = Action_Close
    Anchors = [akRight, akBottom]
    Cancel = True
    Default = True
    TabOrder = 5
  end
  object Log: TLogProvider
    LogFile.Enabled = True
    LogFile.FileNameSuffix = 'OA5_SetPasswordForm'
    LogClient.Enabled = True
    Left = 200
    Top = 56
  end
  object ActionManager1: TActionManager
    Images = ilSetPasswordFormSmallImages
    Left = 168
    Top = 56
    StyleName = 'Platform Default'
    object Action_Apply: TAction
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = 
        #1055#1088#1080#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1087#1072#1088#1086#1083#1103' '#1080' '#1079#1072#1082#1088#1099 +
        #1090#1080#1103' '#1086#1082#1085#1072
      OnExecute = Action_ApplyExecute
    end
    object Action_Close: TAction
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      Hint = 
        #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1089#1077#1093' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1080' '#1079#1072#1082#1088#1099 +
        #1090#1080#1103' '#1086#1082#1085#1072
      OnExecute = Action_CloseExecute
    end
    object Action_Help: TAction
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1089#1087#1088#1072#1074#1082#1091'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1089#1087#1088#1072#1074#1086#1095#1085#1086#1075#1086' '#1092#1072#1081#1083#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 0
      OnExecute = Action_HelpExecute
    end
  end
  object ilSetPasswordFormSmallImages: TImageList
    AllocBy = 2
    Left = 232
    Top = 56
    Bitmap = {
      494C010102000400280010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005346450053464500534645005346450053464500534645000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008E8E8E008E8E8E000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B58E
      7B00B5928400F7E3D600EFE3DE00EFE3DE00F7E7DE00F7E3D600BDA69C005346
      4500534645000000000000000000000000000000000000000000000000000000
      0000000000008E8E8E0053535300313131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDA69C00F7E7
      DE00FFF3F700E7DBD600DEB29C00D6A68C00E7C7BD00EFEBEF00F7F3F700F7E3
      D600E7CBBD005346450000000000000000000000000000000000000000000000
      0000D4D4D400DADADA00C1C1C1003D3D3D000000000000000000000000000000
      00003B484F005D5D5D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDA69C00F7EBE7000000
      0000C68E7300BD5D2900BD5D2900DEB29C00BD5D2900BD5D2900D69E8400F7F3
      F700F7E7DE00D6C7BD0053464500000000000000000000000000000000000000
      0000CCCCCC00CBCBCB00B4B4B4004645450000000000000000000000000071B0
      CD005CA6BB005050500000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDA69C0000000000CE6D
      4200BD5D2900BD5D2900C6A2940000000000E7825200BD5D2900BD5D2900D696
      7300FFFBF700F7E3D60053464500000000000000000000000000000000000000
      0000C7C7C700C7C7C700A2A2A2004E4E4E0000000000000000009BC2D9007EC4
      EB005CAED5007373730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDA69C00FFFBFF00DE9E7B00BD5D
      2900CE653100CE653100CE693900D68A6300CE653100CE653100BD5D2900BD5D
      2900E7CBBD00F7EFEF00DECBC600534645000000000000000000000000000000
      0000BBBBBB00BFBFBF008E8E8E006262620000000000000000006DACCC0073CA
      FD00347B9F007373730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD00FFF7F700C6613100BD5D
      2900CE653100BD5D2900CE866300F7E7DE00D6693900BD5D2900CE653100BD5D
      2900CE71420000000000E7CBBD00534645000000000000000000000000000000
      0000A6A6A600A6A4A2007F7976005959590000000000A8C2D40070C5E9004CB2
      EE00315C73000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD00F7DFD600BD5D2900CE65
      3100CE653100BD5D2900D6825200FFFBFF00E7AE9400BD5D2900BD5D2900CE65
      3100BD5D2900FFEFEF00F7DFD600534645000000000000000000545454004D4D
      4D00BCBAB800899095005C7F9600303134005A6D7A0055A7D30046A8E90040A2
      D600717F88000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD00F7D7CE00CE653100CE65
      3100CE653100CE653100BD5D2900DEAA9400FFF7F700EF9E7300BD5D2900CE65
      3100BD5D2900F7F3EF00EFE3DE005346450000000000B7B7B700BBBBBB00AAA9
      A900B2AFB00066B3DE0053C2FF003C87B700408AB0005DC2FD002A91DB003978
      9D00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD00FFEFE700D6693900CE65
      3100CE653100BD5D2900BD5D2900BD5D2900E7CFC60000000000D6693900CE65
      3100CE693900FFFBFF00F7DFD60053464500DFDFDF00CCCCCC00B1B1B100E2DC
      DA009FCDE80061CCFF0043ACFF008CF5FF0080E9FF00339AE3002B80BE00545B
      6200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BD0000000000F79A6B00D669
      3900CE8E6B00F7EBE700D6825200BD5D2900D696730000000000E78E5A00BD5D
      2900EF92630000000000D6C7BD0053464500D6D6D600D8D8D8009B9997008990
      960072D8F60049B7FF00378CDB0069A5B00089E2F50049AFFF003185C7002D3A
      4400898989000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6C7BD00FFEBDE00EF86
      5200E7825200F7F7F70000000000DEBAAD0000000000F7F7F700DE714200D671
      3900FFF3EF00F7E7E7005346450000000000D2D2D200E9E9EA00A09B970076A0
      BF00B1F5FF004DABFF003B87CC009B858300778A920067B1E60054BAFF00316C
      9400898989000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6C7BD0000000000FFEF
      D600FFAA7300EFAA8C00EFE3DE00EFEFEF00F7E7E700FFA67B00F78E5A00F7DB
      CE0000000000D6C7BD000000000000000000C6C5C500E0E0E000E1DFDE00BCCB
      D900BADAFB00C6EBFF0072CAFF0077C1D400A0837E003680BF0047B1FF004662
      7800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6C7BD000000
      000000000000FFF3C600FFDFAD00FFD39C00FFC79400FFD7AD00000000000000
      0000D6C7BD00000000000000000000000000C1BBB500AE9C8800595B5C00B0AD
      AA00BCC0C200A8C9E400B7F1FE009BE1E600AB8B86004B93D400328BD5008989
      8900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6C7
      BD00D6C7BD0000000000000000000000000000000000FFFBFF00DECBC600D6C7
      BD0000000000000000000000000000000000D2D0CF00CAB09500969492004F4F
      4F003E3E3E00504E4E0072849200ABA0A200A3A9A50051B5F9005788B6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DECBC600D6C7BD00D6C7BD00D6C7BD00D6C7BD00000000000000
      00000000000000000000000000000000000000000000C9C7C500B6ABA100AFAA
      A400B5B4B300AEA9A900B1A4A200BCBABE00A7D6F50093D1FC00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F81FFCFF00000000E007F8FF00000000
      C003F0F3000000009001F0E300000000A101F0C3000000000000F0C300000000
      0004F087000000000000C007000000000000800F000000000040000F00000000
      40440007000000008281000700000000A00B000F00000000D837000F00000000
      E78F001F00000000F83F803F0000000000000000000000000000000000000000
      000000000000}
  end
end
