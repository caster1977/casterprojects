object UserForm: TUserForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 6
  ClientHeight = 185
  ClientWidth = 342
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
  object pnlButtons: TPanel
    Left = 0
    Top = 154
    Width = 342
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    Constraints.MaxHeight = 31
    Constraints.MinHeight = 31
    TabOrder = 0
    DesignSize = (
      342
      31)
    object btnApply: TButton
      Left = 105
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actApply
      Anchors = [akTop, akRight]
      TabOrder = 1
    end
    object btnCancel: TButton
      Left = 186
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actCancel
      Anchors = [akTop, akRight]
      Cancel = True
      TabOrder = 2
    end
    object btnDefaults: TButton
      Left = 0
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actDefaults
      TabOrder = 0
    end
    object btnHelp: TButton
      Left = 267
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actHelp
      Anchors = [akTop, akRight]
      TabOrder = 3
    end
  end
  object grpMain: TGroupBox
    Left = 0
    Top = 0
    Width = 342
    Height = 154
    Align = alClient
    TabOrder = 1
    DesignSize = (
      342
      154)
    object ledLogin: TLabeledEdit
      Left = 8
      Top = 24
      Width = 326
      Height = 21
      EditLabel.Width = 34
      EditLabel.Height = 13
      EditLabel.Caption = '&'#1051#1086#1075#1080#1085':'
      TabOrder = 0
    end
    object ledPassword: TLabeledEdit
      Left = 8
      Top = 64
      Width = 298
      Height = 21
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = #1055'&'#1072#1088#1086#1083#1100':'
      TabOrder = 1
    end
    object ledFullName: TLabeledEdit
      Left = 8
      Top = 104
      Width = 326
      Height = 21
      EditLabel.Width = 62
      EditLabel.Height = 13
      EditLabel.Caption = #1055#1086#1083#1085#1086#1077' &'#1080#1084#1103':'
      TabOrder = 3
    end
    object chkBlocked: TCheckBox
      Left = 174
      Top = 131
      Width = 160
      Height = 17
      Caption = #1047#1072#1073#1083#1086#1082#1080#1088#1086#1074#1072#1085
      TabOrder = 5
    end
    object chkAdministrator: TCheckBox
      Left = 8
      Top = 131
      Width = 160
      Height = 17
      Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
      TabOrder = 4
    end
    object btnNextPage: TButton
      Left = 312
      Top = 64
      Width = 22
      Height = 21
      Cursor = crHandPoint
      Action = actGeneratePassword
      Anchors = [akTop, akRight]
      Images = ImageList
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 88
    Top = 64
    object actCancel: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1054#1090#1084#1077#1085#1072
      Hint = #1054#1090#1084#1077#1085#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      OnExecute = actCancelExecute
    end
    object actApply: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      Hint = #1055#1088#1080#1084#1077#1085#1080#1090#1100'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      OnExecute = actApplyExecute
    end
    object actHelp: TAction_Help
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Enabled = False
      Hint = #1057#1087#1088#1072#1074#1082#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 0
      ShortCut = 112
    end
    object actDefaults: TAction_Defaults
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = #1057'&'#1073#1088#1086#1089
      Hint = 
        #1057#1073#1088#1086#1089#1080#1090#1100' '#1079#1085#1072#1095#1077#1085#1080#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1073#1088#1086#1089#1072' '#1074#1089#1077#1093' '#1079#1085#1072#1095#1077#1085#1080#1081' '#1082' '#1079#1085#1072#1095#1077#1085#1080#1103#1084' '#1087 +
        #1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    end
    object actGeneratePassword: TAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Hint = #1043#1077#1085#1077#1088#1072#1094#1080#1103' '#1087#1072#1088#1086#1083#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1075#1077#1085#1077#1088#1072#1094#1080#1080' '#1085#1086#1074#1086#1075#1086' '#1087#1072#1088#1086#1083#1103
      ImageIndex = 1
    end
  end
  object ImageList: TImageList
    ColorDepth = cd32Bit
    AllocBy = 3
    Left = 88
    Top = 16
    Bitmap = {
      494C010102000800380010001000FFFFFFFF2110FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000514443FF514443FF514443FF514443FF514443FF514443FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B58E
      79FFB59284FFF7E3D6FFEFE3DEFFEFE3DEFFF7E7DEFFF7E3D6FFBDA69CFF5144
      43FF514443FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BDA69CFFF7E7
      DEFFFFF3F7FFE7DBD6FFDEB29CFFD6A68CFFE7C7BDFFEFEBEFFFF7F3F7FFF7E3
      D6FFE7CBBDFF514443FF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDA69CFFF7EBE7FFFFFF
      FFFFC68E71FFBD5B27FFBD5B27FFDEB29CFFBD5B27FFBD5B27FFD69E84FFF7F3
      F7FFF7E7DEFFD6C7BDFF514443FF000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003E6F5E8F0F0F0F1000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDA69CFFFFFFFFFFCE6B
      40FFBD5B27FFBD5B27FFC6A294FFFFFFFFFFE78250FFBD5B27FFBD5B27FFD696
      71FFFFFBF7FFF7E3D6FF514443FF00000000000000003F665980009964FF0099
      64FF268B69CF0F0F0F10000000000000000000000000272C2A303F6659803F66
      59801B9168DF268B69CF0F0F0F10000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDA69CFFFFFBFFFFDE9E79FFBD5B
      27FFCE632FFFCE632FFFCE6737FFD68A61FFCE632FFFCE632FFFBD5B27FFBD5B
      27FFE7CBBDFFF7EFEFFFDECBC6FF514443FF00000000303936403F6659803F66
      59800E9567EF268B69CF0F0F0F1000000000272C2A300E9567EF009964FF0099
      64FF009964FF009964FF37464050000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BDFFFFF7F7FFC65F2FFFBD5B
      27FFCE632FFFBD5B27FFCE8661FFF7E7DEFFD66737FFBD5B27FFCE632FFFBD5B
      27FFCE6F40FFFFFFFFFFE7CBBDFF514443FF0000000000000000000000000000
      0000272C2A300E9567EF268B69CF303936400E9567EF268B69CF0F0F0F100000
      00002F8569BF3C514A6000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BDFFF7DFD6FFBD5B27FFCE63
      2FFFCE632FFFBD5B27FFD68250FFFFFBFFFFE7AE94FFBD5B27FFBD5B27FFCE63
      2FFFBD5B27FFFFEFEFFFF7DFD6FF514443FF0000000000000000000000000000
      000000000000272C2A300E9567EF1B9168DF367F66AF0F0F0F10000000000000
      0000272C2A300000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BDFFF7D7CEFFCE632FFFCE63
      2FFFCE632FFFCE632FFFBD5B27FFDEAA94FFFFF7F7FFEF9E71FFBD5B27FFCE63
      2FFFBD5B27FFF7F3EFFFEFE3DEFF514443FF0000000000000000000000000000
      000000000000272C2A300E9567EF009964FF268B69CF0F0F0F10000000000000
      0000272C2A300000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BDFFFFEFE7FFD66737FFCE63
      2FFFCE632FFFBD5B27FFBD5B27FFBD5B27FFE7CFC6FFFFFFFFFFD66737FFCE63
      2FFFCE6737FFFFFBFFFFF7DFD6FF514443FF0000000000000000000000000000
      0000272C2A300E9567EF268B69CF303936400E9567EF268B69CF0F0F0F100000
      00002F8569BF3C514A6000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6C7BDFFFFFFFFFFF79A69FFD667
      37FFCE8E69FFF7EBE7FFD68250FFBD5B27FFD69671FFFFFFFFFFE78E58FFBD5B
      27FFEF9261FFFFFFFFFFD6C7BDFF514443FF00000000303936403F6659803F66
      59800E9567EF268B69CF0F0F0F1000000000272C2A300E9567EF009964FF0099
      64FF009964FF009964FF37464050000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6C7BDFFFFEBDEFFEF86
      50FFE78250FFF7F7F7FFFFFFFFFFDEBAADFFFFFFFFFFF7F7F7FFDE6F40FFD66F
      37FFFFF3EFFFF7E7E7FF514443FF00000000000000003F665980009964FF0099
      64FF268B69CF0F0F0F10000000000000000000000000272C2A303F6659803F66
      59801B9168DF268B69CF0F0F0F10000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6C7BDFFFFFFFFFFFFEF
      D6FFFFAA71FFEFAA8CFFEFE3DEFFEFEFEFFFF7E7E7FFFFA679FFF78E58FFF7DB
      CEFFFFFFFFFFD6C7BDFF00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003E6F5E8F0F0F0F1000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6C7BDFFFFFF
      FFFFFFFFFFFFFFF3C6FFFFDFADFFFFD39CFFFFC794FFFFD7ADFFFFFFFFFFFFFF
      FFFFD6C7BDFF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6C7
      BDFFD6C7BDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBFFFFDECBC6FFD6C7
      BDFF000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DECBC6FFD6C7BDFFD6C7BDFFD6C7BDFFD6C7BDFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00F81FFFFF00000000E007FFFF00000000
      C003FFFF000000008001FFF30000000080018381000000000000810100000000
      0000F013000000000000F837000000000000F837000000000000F01300000000
      000081010000000080018381000000008003FFF300000000C007FFFF00000000
      E00FFFFF00000000F83FFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
