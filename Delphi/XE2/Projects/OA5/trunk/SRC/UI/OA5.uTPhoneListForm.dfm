object PhoneListForm: TPhoneListForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1089#1087#1080#1089#1082#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074
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
  PixelsPerInch = 96
  TextHeight = 13
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
    ExplicitLeft = -152
    ExplicitTop = 211
    DesignSize = (
      624
      30)
    object btnCreate: TButton
      Left = 0
      Top = 5
      Width = 65
      Height = 25
      Cursor = crHandPoint
      Action = actCreate
      TabOrder = 0
    end
    object btnEdit: TButton
      Left = 71
      Top = 5
      Width = 65
      Height = 25
      Cursor = crHandPoint
      Action = actEdit
      TabOrder = 1
    end
    object btnHelp: TButton
      Left = 543
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Action = actHelp
      Anchors = [akTop, akRight]
      TabOrder = 6
    end
    object btnDelete: TButton
      Left = 142
      Top = 5
      Width = 65
      Height = 25
      Cursor = crHandPoint
      Action = actDelete
      TabOrder = 2
    end
    object btnClose: TButton
      Left = 456
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Action = actClose
      Anchors = [akTop, akRight]
      Cancel = True
      Default = True
      TabOrder = 5
    end
    object btnConnect: TButton
      Left = 213
      Top = 5
      Width = 116
      Height = 25
      Cursor = crHandPoint
      Action = actConnect
      TabOrder = 3
    end
    object btnVoice: TButton
      Left = 335
      Top = 5
      Width = 115
      Height = 25
      Cursor = crHandPoint
      Action = actVoice
      TabOrder = 4
    end
  end
  object ListView1: TListView
    Left = 0
    Top = 0
    Width = 624
    Height = 284
    Align = alTop
    Anchors = [akLeft, akTop, akRight, akBottom]
    Columns = <
      item
        Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072
      end
      item
        Caption = #1058#1080#1087' '#1090#1077#1083#1077#1092#1086#1085#1072
      end
      item
        Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
      end
      item
        Caption = #1057#1074#1077#1088#1077#1085
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object ActionList: TActionList
    Left = 224
    Top = 72
    object actCreate: TAction
      Caption = #1057#1086#1079'&'#1076#1072#1090#1100
      Hint = #1057#1086#1079#1076#1072#1090#1100' '#1085#1086#1074#1099#1081' '#1090#1077#1083#1077#1092#1086#1085'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1090#1077#1083#1077#1092#1086#1085#1072
    end
    object actEdit: TAction
      Caption = '&'#1048#1079#1084#1077#1085#1080#1090#1100
      Hint = #1048#1079#1084#1077#1085#1080#1090#1100' '#1090#1077#1083#1077#1092#1086#1085'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1090#1077#1083#1077#1092#1086#1085#1072
    end
    object actDelete: TAction
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      Hint = #1059#1076#1072#1083#1080#1090#1100' '#1090#1077#1083#1077#1092#1086#1085'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1090#1077#1083#1077#1092#1086#1085#1072
    end
    object actHelp: TAction
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1089#1087#1088#1072#1074#1082#1091'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1089#1087#1088#1072#1074#1086#1095#1085#1086#1075#1086' '#1092#1072#1081#1083#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      OnExecute = actHelpExecute
      OnUpdate = actHelpUpdate
    end
    object actClose: TAction
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      Hint = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      OnExecute = actCloseExecute
    end
    object actConnect: TAction
      Caption = #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077' '#1040' '#1089' '#1041
      Hint = 
        #1057#1086#1077#1076#1080#1085#1077#1085#1080#1077' '#1040' '#1089' '#1041'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1077#1076#1080#1085#1077#1085#1080#1103' '#1079#1074#1086#1085#1103#1097#1077#1075#1086' '#1089' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1084' '#1085 +
        #1086#1084#1077#1088#1086#1084' '#1090#1077#1083#1077#1092#1086#1085#1072
    end
    object actVoice: TAction
      Caption = #1053#1072' '#1088#1077#1095#1077#1074#1091#1102' '#1082#1072#1088#1090#1091
      Hint = 
        #1054#1090#1087#1088#1072#1074#1082#1072' '#1085#1072' '#1088#1077#1095#1077#1074#1091#1102' '#1082#1072#1088#1090#1091'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1085#1086#1084#1077#1088 +
        #1072' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1085#1072' '#1088#1077#1095#1077#1074#1091#1102' '#1082#1072#1088#1090#1091
    end
  end
  object ImageList: TImageList
    Left = 280
    Top = 72
    Bitmap = {
      494C010107000900240010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000F7FFFF0084C6E70084C6E70084C6E70084C6E700F7FFFF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000F7FF
      FF0042A5E7000084E7000084E7000084E7000084E7000084E7000084E70042A5
      E700F7FFFF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000F7FFFF000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E700F7FFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000E7E70000E7E700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7FFFF0084E7C60084E7A500C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F7FFFF000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E700F7FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7FFFF0042E7E70000E7E70000E7E70042E7E700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF0084E7A500C6DEC600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000042A5E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E70042A5E700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0042E7E70000E7E70000E7E70000E7E70000E7E70042E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600C6DE
      C600C6DEC600FFFFFF00FFFFFF00C6DEC60084E7A500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E7000084E700F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084E7E70000E7E70000E7E70000E7E70000E7E70000E7E70000E7E70042E7
      E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00C6DEC60084E7A50084E7
      A50084E7A500C6DEC600FFFFFF00F7FFFF0084E7A500C6DEC600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084C6E7000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E7000084E70084C6E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF0084E7
      E70084E7E70042E7E70000E7E70000E7E70000E7E70000E7E70000FFFF0000FF
      FF0042E7E700FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00C6DEC60084E7
      A50084E7A50042C68400C6DEC600FFFFFF00F7FFFF0084E7C600F7FFFF00F7FF
      FF00FFFFFF00FFFFFF00F7FFFF00FFFFFF0084C6E7000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E7000084E70084C6E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0084E7E70084E7
      E70084E7E70084E7E70042E7E70000E7E70000E7E70000FFFF0000FFFF0000FF
      FF0000FFFF0042E7E700FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FFFF00C6DE
      C600C6DEC60084E7A50084C6A500F7FFFF00FFFFFF00F7FFFF00C6DEC600C6DE
      C60084E7C60084E7C60084E7C60084E7C60084C6E7000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E7000084E70084C6E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084E7E70084E7E70084E7
      E70084E7E70084E7E70084E7E70042E7E70000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0042E7E700FFFFFF00FFFFFF00FFFFFF00F7FFFF00F7FF
      FF00C6DEC600C6DEC60084E7A50084E7A500F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00C6DEC60084E7C60084E7A500C6DEC60084C6E7000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E700F7FFFF0042A5E70084E7
      E70042A5E7000084E7000084E70084C6E7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F7FFFF0084E7E70084E7
      E70084E7E70084E7E70084E7E700F7FFFF0084E7E70000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084E7E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FF
      FF00F7FFFF00C6DEC60084E7C60084E7A500C6DEC600FFFFFF00F7FFFF00C6DE
      C60084E7C600C6DEC600C6DEC600F7FFFF00F7FFFF000084E7000084E7000084
      E7000084E7000084E7000084E7000084E70084E7E700F7FFFF0084E7E70084C6
      E70084C6E7000084E7000084E700F7FFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00F7FFFF0084E7
      E70084E7E70084E7E700F7FFFF00F7FFFF00FFFFFF0084E7E70000FFFF0000FF
      FF0000FFFF0084E7E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00C6DEC600C6DEC600C6DE
      C600C6DEC600F7FFFF00F7FFFF00FFFFFF000000000042A5E7000084E7000084
      E7000084E7000084E7000084E7000084E700F7FFFF00F7FFFF00C6DEC60042A5
      E70084E7E7000084E70042A5E700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00F7FF
      FF0084E7E700F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF0084E7E70000FF
      FF0084E7E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600F7FFFF00F7FF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F7FFFF000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E700F7FFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084E7
      E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000084C6E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E70084C6E70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084E7
      E70042A5E7000084E7000084E7000084E7000084E7000084E7000084E70042A5
      E70084E7E7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000084E7E70084C6E70042A5E70042A5E70084C6E70084E7E700FFFF
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000737373006B6B6B005A5A5A0073737300737373007373
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000005242420052424200524242005242420052424200524242000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000063636300636363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A5008484840094848400736B6B004A4A4A00525252008C8C
      8C0000000000000000000000000000000000000000000000000000000000B58C
      7B00B5948400F7E7D600EFE7DE00EFE7DE00F7E7DE00F7E7D600BDA59C005242
      4200524242000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00000000000063636300B59C9C00E7D6D6006363630063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A500A5A5A500B5A5A500BDA5A500E7BDBD00947B7B007B7B
      7B00000000000000000000000000000000000000000000000000BDA59C00F7E7
      DE00FFF7F700E7DED600DEB59C00D6A58C00E7C6BD00EFEFEF00F7F7F700F7E7
      D600E7CEBD005242420000000000000000000000FF000000FF000000FF000000
      FF000000FF004263E700C6A5E700F7FFFF00F7FFFF00C6A5E7004263E7000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      00006363630073636300A59C9C00FFE7E700E7CECE00D6B5B500636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A500A5A5A500737373004A4A4A005A5252006B5A5A007B7B
      7B000000000000000000000000000000000000000000BDA59C00F7EFE700FFFF
      FF00C68C7300BD5A2900BD5A2900DEB59C00BD5A2900BD5A2900D69C8400F7F7
      F700F7E7DE00D6C6BD0052424200000000000000FF000000FF000000FF000000
      FF004263E700F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF004263
      E7000000FF000000FF000000FF000000FF000000000000000000000000006363
      6300846B6B0094847B00C6949400C6949400E7BDBD00DEADAD00D6ADAD00CEAD
      A500636363006363630000000000000000000000000000000000000000000000
      000000000000A5A5A500ADADAD0073737300525252004A4A4A006B6363007B7B
      7B000000000000000000000000000000000000000000BDA59C00FFFFFF00CE6B
      4200BD5A2900BD5A2900C6A59400FFFFFF00E7845200BD5A2900BD5A2900D694
      7300FFFFF700F7E7D60052424200000000000000FF000000FF000000FF000000
      FF00C6A5E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6A5
      E7000000FF000000FF000000FF000000FF000000000000000000636363009C7B
      7B00AD948400738CA50063ADD6008CC6CE00C6949400C6949400D69C9C00CE94
      9400CE8C8C00B5948C0063636300000000000000000000000000000000000000
      000000000000A5A5A500B5B5B500848484004A4A4A005A525200636363007B7B
      7B0000000000000000000000000000000000BDA59C00FFFFFF00DE9C7B00BD5A
      2900CE633100CE633100CE6B3900D68C6300CE633100CE633100BD5A2900BD5A
      2900E7CEBD00F7EFEF00DECEC600524242000000FF000000FF000000FF000000
      FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FF
      FF000000FF000000FF000000FF000000FF000000000063636300B58C8C00A594
      8C005A94B5001073DE004AADF7009CFFFF008CDEE7008CBDCE00C6949400C694
      9400CE8C8C00CE8C8C0063636300000000000000000000000000000000000000
      000000000000A5A5A500BDBDBD007B7B7B005A5A5A004A4A4A00636363007B7B
      7B0000000000000000000000000000000000D6C6BD00FFF7F700C6633100BD5A
      2900CE633100BD5A2900CE846300F7E7DE00D66B3900BD5A2900CE633100BD5A
      2900CE734200FFFFFF00E7CEBD00524242000000FF000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF000000FF0063636300C6949400AD9C9C00429C
      CE00187BF7001073DE0008A5F70021DEF70073FFFF0094FFFF008CE7EF0084BD
      CE00C6949400C694940063636300000000000000000000000000000000000000
      000000000000A5A5A500BDBDBD0052CE7B0042C66B0052C67B0052635A007B7B
      7B0000000000000000000000000000000000D6C6BD00F7DED600BD5A2900CE63
      3100CE633100BD5A2900D6845200FFFFFF00E7AD9400BD5A2900BD5A2900CE63
      3100BD5A2900FFEFEF00F7DED600524242000000FF000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF000000FF00CEA59C00A5A5AD0029A5DE0000AD
      FF00108CF700089CFF0021C6EF00429CBD0000ADE70018CEF7005AF7FF0084FF
      FF0073CEDE006363630000000000000000000000000000000000000000000000
      000000000000A5A5A500C6C6C60063D68C0039D66B0042E77B00426B4A007B7B
      7B0000000000000000000000000000000000D6C6BD00F7D6CE00CE633100CE63
      3100CE633100CE633100BD5A2900DEAD9400FFF7F700EF9C7300BD5A2900CE63
      3100BD5A2900F7F7EF00EFE7DE00524242000000FF000000FF000000FF000000
      FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FF
      FF000000FF000000FF000000FF000000FF00C6ADAD0042B5DE0000B5FF001094
      FF001094FF0008B5EF00429CB50039CEEF00219CC60031B5DE0000A5D60010BD
      E70052C6E7006363630000000000000000000000000000000000000000000000
      000000000000A5A5A500CECECE0073E794004AE7840031CE6300396342007B7B
      7B0000000000000000000000000000000000D6C6BD00FFEFE700D66B3900CE63
      3100CE633100BD5A2900BD5A2900BD5A2900E7CEC600FFFFFF00D66B3900CE63
      3100CE6B3900FFFFFF00F7DED600524242000000FF000000FF000000FF000000
      FF00C6A5E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6A5
      E7000000FF000000FF000000FF000000FF000884D6000884D6000884D6001094
      FF0010BDFF00429CB50042BDDE00219CC6004AB5D60021C6EF004ABDDE0018A5
      DE00636363000000000000000000000000000000000000000000000000000000
      000000000000A5A5A500CECECE0063AD73004ABD630039AD5A004A6352007B7B
      7B0000000000000000000000000000000000D6C6BD00FFFFFF00F79C6B00D66B
      3900CE8C6B00F7EFE700D6845200BD5A2900D6947300FFFFFF00E78C5A00BD5A
      2900EF946300FFFFFF00D6C6BD00524242000000FF000000FF000000FF000000
      FF004263E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004263
      E7000000FF000000FF000000FF000000FF000894D60010A5EF0018B5EF0021A5
      E7006BD6E70084CEDE0031C6E70031B5D60018B5DE0052A5BD0021B5E7006363
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A500C6C6C6008C8C8C008C8C8C008C8C8C006B6B6B008C8C
      8C000000000000000000000000000000000000000000D6C6BD00FFEFDE00EF84
      5200E7845200F7F7F700FFFFFF00DEBDAD00FFFFFF00F7F7F700DE734200D673
      3900FFF7EF00F7E7E70052424200000000000000FF000000FF000000FF000000
      FF000021E700F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF000021
      E7000000FF000000FF000000FF000000FF0010ADDE0042F7FF0018B5EF000884
      D6006BE7FF006BEFF70094E7E7007BE7F70052B5D60021B5E700428CAD006363
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A500ADADAD00636363007B7B7B008C8C8C00848484008C8C
      8C000000000000000000000000000000000000000000D6C6BD00FFFFFF00FFEF
      D600FFAD7300EFAD8C00EFE7DE00EFEFEF00F7E7E700FFA57B00F78C5A00F7DE
      CE00FFFFFF00D6C6BD0000000000000000000000FF000000FF000000FF000000
      FF000000FF008484E700FFFFFF00FFFFFF00FFFFFF00F7FFFF008484E7000000
      FF000000FF000000FF000000FF000000FF0063B5CE006BD6EF006BEFFF0031BD
      E70039C6EF001894CE0031B5D60063E7F70031B5D60021A5E700427BAD006363
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000A5A5A50031292900734A4A008C8C8C008C8C8C008C8C8C000000
      0000000000000000000000000000000000000000000000000000D6C6BD00FFFF
      FF00FFFFFF00FFF7C600FFDEAD00FFD69C00FFC69400FFD6AD00FFFFFF00FFFF
      FF00D6C6BD000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000021E70084A5E700F7FFFF00F7FFFF0084A5E7000021E7000000
      FF000000FF000000FF000000FF000000FF000000000063B5CE0063B5CE008CE7
      EF0063E7FF0063DEF7005ACEEF0039CEEF0021DEFF0008ADE700636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7373009C8484000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6C6
      BD00D6C6BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECEC600D6C6
      BD00000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF004242E7008463E7008463E7004242E7000000FF000000
      FF000000FF000000FF000000FF000000FF0000000000000000000000000063B5
      CE0063B5CE0063B5CE0063B5CE0063B5CE0063B5CE0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B7B7B009C8484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DECEC600D6C6BD00D6C6BD00D6C6BD00D6C6BD00000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000F81F000000000000E0070000
      00000000C0030000000000008001000000000000800100000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000080010000000000008001000000000000C0030000
      00000000E007000000000000F80F0000FFFFFC0FF81F0000FCFFF80FE0070000
      F83FF80FC0030000F00FF80F80010000E003F80F80010000C001F80F00000000
      8001F80F000000000001F80F000000000003F80F000000000003F80F00000000
      0007F80F00000000000FF80F80010000000FF80F80030000000FF81FC0070000
      801FFCFFE00F0000E03FFCFFF83F000000000000000000000000000000000000
      000000000000}
  end
end
