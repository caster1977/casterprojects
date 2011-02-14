object ViewPostListForm: TViewPostListForm
  Left = 0
  Top = 0
  Hint = #1054#1082#1085#1086' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103' '#1089#1090#1072#1090#1080#1089#1090#1080#1095#1077#1089#1082#1080#1093' '#1086#1090#1095#1105#1090#1086#1074
  ActiveControl = lvMessages
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = 'OA4 - '#1055#1088#1086#1089#1084#1086#1090#1088' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
  ClientHeight = 256
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 215
    Width = 634
    Height = 41
    Align = alBottom
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      630
      37)
    object btnCreate: TButton
      Left = 6
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Caption = #1057#1086'&'#1079#1076#1072#1090#1100
      TabOrder = 0
      OnClick = btnCreateClick
    end
    object btnClose: TButton
      Left = 460
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      Default = True
      ModalResult = 2
      TabOrder = 3
    end
    object btnHelp: TButton
      Left = 541
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      Anchors = [akTop, akRight]
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      TabOrder = 4
    end
    object btnView: TButton
      Left = 87
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Caption = '&'#1054#1090#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = btnViewClick
    end
    object btnErase: TButton
      Left = 168
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      TabOrder = 2
      OnClick = btnEraseClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 634
    Height = 215
    Hint = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1079#1072#1087#1080#1089#1080' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
    Align = alClient
    BevelEdges = []
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object pnlID: TPanel
      Left = 0
      Top = 190
      Width = 634
      Height = 25
      Hint = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1079#1072#1087#1080#1089#1080' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      Align = alBottom
      BevelEdges = []
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object lblIDCaption: TLabel
        Left = 0
        Top = 6
        Width = 123
        Height = 13
        Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1079#1072#1087#1080#1089#1080':'
        Transparent = False
        Layout = tlCenter
      end
      object lblID: TLabel
        Left = 129
        Top = 6
        Width = 5
        Height = 13
        Caption = '?'
        Enabled = False
        Transparent = False
      end
      object Bevel4: TBevel
        Left = 0
        Top = 0
        Width = 634
        Height = 6
        Align = alTop
        Shape = bsTopLine
        ExplicitTop = 20
        ExplicitWidth = 233
      end
    end
    object lvMessages: TListView
      Left = 0
      Top = 0
      Width = 634
      Height = 190
      Hint = #1057#1087#1080#1089#1086#1082' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      Align = alClient
      Columns = <
        item
          Caption = #1057#1086#1079#1076#1072#1085#1086
          Width = 111
        end
        item
          Caption = #1040#1074#1090#1086#1088
          Width = 77
        end
        item
          Caption = #1058#1077#1084#1072
          Width = 442
        end>
      ColumnClick = False
      GridLines = True
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      SmallImages = ilPost
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = lvMessagesDblClick
      OnSelectItem = lvMessagesSelectItem
    end
  end
  object ilPost: TImageList
    AllocBy = 2
    Height = 15
    Width = 19
    Left = 375
    Top = 105
    Bitmap = {
      494C010102000400040013000F00FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      00000000000036000000280000004C0000000F0000000100200000000000D011
      000000000000000000000000000000000000000000009D968C006B5942006B59
      42006B5942006B5942006B5942006B5942006B5942006B5942006B5942006B59
      42006B5942006B5942006B5942006B5942006B5942009D968C00000000000000
      00009D968C006B5942006B5942006B5942006B5942006B5942006B5942006B59
      42006B5942006B5942006B5942006B5942006B5942006B5942006B5942006B59
      42009D968C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009D968C00AA9D8D00F4F0EC00F8F5F200F8F5F200F8F5F200F8F5F200F8F5
      F200F8F5F200F8F5F200F8F5F200F8F5F200F8F5F200F8F5F200F8F5F200F8F5
      F200F4F0EC00AA9D8D009D968C009D968C00ACA19200FBF9F800FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FBF9F800ACA192009D968C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B594200F1EBE500D8C9B700CBB6
      9F00CBB69F00CBB69F00CBB69F00CBB69F00C8B29B00C0AA9300C8B29B00CBB6
      9F00CBB69F00CBB69F00CBB69F00CBB69F00D8C9B700F1EBE5006B5942006B59
      4200F8F6F300DBCDBC00CBB69F00CBB69F00CBB69F00CBB69F00CBB69F00CBB6
      9F0087745C00CBB69F00CBB69F00CBB69F00CBB69F00CBB69F00CBB69F00DBCD
      BC00F8F6F3006B59420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B594200F0EAE400D0BDA900D0BDA900D0BDA900D0BDA900D0BDA900CBB7
      A200B49F8800B29D8600B49F8800CBB7A200D0BDA900D0BDA900D0BDA900D0BD
      A900D0BDA900F0EAE4006B5942006B594200F1ECE600D6C4B200D6C4B200D6C4
      B200D6C4B200D6C4B200C0AF9C0087745C00BC966F0087745C00C0AF9C00D6C4
      B200D6C4B200D6C4B200D6C4B200D6C4B200F1ECE6006B594200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B594200EEE7E000D6C4B200D6C4
      B200D6C4B200D6C4B200D0BDAB00B3A08B008C7A63008C7962008C7A6300B3A0
      8B00D0BDAB00D6C4B200D6C4B200D6C4B200D6C4B200EEE7E0006B5942006B59
      4200EEE8E000DBCCBB00DBCCBB00DBCCBB00DBCCBB00B6A794009B7F6000E5B4
      8400E5B48400E4B383009A7F6000B6A79400DBCCBB00DBCCBB00DBCCBB00DBCC
      BB00EEE8E0006B59420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B594200EDE5DD00DBCCBB00DBCCBB00DBCCBB00D5C5B400AD9C87008775
      5F00C1AE9800CEB9A400C1AE980087755F00AD9C8700D5C5B400DBCCBB00DBCC
      BB00DBCCBB00EDE5DD006B5942006B594200ECE5DD00E0D3C500E0D3C500DFD2
      C400B2A18D00BE997400F2BF8E00F1BE8C00F1BE8C00F0BD8B00F0BD8B00BC96
      6F00B1A08C00DFD2C300E0D3C500E0D3C500ECE5DD006B594200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B594200ECE5DD00E0D3C500E0D3
      C500DACDBD00A695820098887500D1C0AF00D8C8B600D8C8B600D8C8B600D1C0
      AF0098887500A6958200DACDBD00E0D3C500E0D3C500ECE5DD006B5942006B59
      4200ECE5DC00E5DBCF00DCD2C400B29E8800EBC39C00FDD2A500FDD0A200FDCF
      A000FDCFA000FDCC9A00FDCB9700FDCA9600EBBB8B00B19C8300DCD1C400E5DB
      CF00ECE5DC006B59420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B594200EDE6DE00E5DBCF00D9CDBE0096857300AE9F8F00E2D6C900E2D6
      C900E2D6C900E2D6C900E2D6C900E2D6C900E2D6C900AE9F8F0096857300D9CD
      BE00E5DBCF00EDE6DE006B5942006B594200EDE6DE00E2D9CF009C7C4D00FFEC
      DA00FFDAB400FFD8B100FFD7AE00FFD5AB00FFD5AB00FFD2A400FFD0A100FFCF
      9E00FFCD9B00FFE5CC009C7C4D00DAD0C400EDE6DE006B594200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B594200EFE8E100D8CDC0009586
      7300C3B8AC00EBE4DB00EBE4DB00EBE4DB00EBE4DB00EBE4DB00EBE4DB00EBE4
      DB00EBE4DB00EBE4DB00C3B8AC0095867300D8CDC000EFE8E1006B5942006B59
      4200D6CEC30077654F00D7820100FFFFFF00FFDFBE00FFDDBB00FFDCB800FFDA
      B500FFDAB500FFD7AF00FFD6AB00FFD4A800FFD2A500FFFFFF00D78201007564
      4D00D6CEC3006B59420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B594200D8D0C50096887800DCD6CE00F5F2ED00F5F2ED00F5F2ED00F5F2
      ED00F5F2ED00F5F2ED00F5F2ED00F5F2ED00F5F2ED00F5F2ED00F5F2ED00DCD6
      CE0096887800D8D0C5006B5942009D968C006F5D4500A0876C00D7820200FFFF
      FF00FFE4C900FFE2C500FFE1C200FFDFBF00FFDFBF00FFDCB800FFDBB500FFD9
      B200FFD7AF00FFFFFF00D78202008C775B006D5B44009D968C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009D968C0073624D00F2F0ED00FCFA
      F900FCFAF900FCFAF900FCFAF900FCFAF900FCFAF900FCFAF900FCFAF900FCFA
      F900FCFAF900FCFAF900FCFAF900FCFAF900F2F0ED0073624D009D968C000000
      00009D968C007C684F00D7820100FFFFFF00FFE9D300FFE7D000FFE6CD00FFE4
      CA00FFE4CA00FFE1C300FFE0C000FFDEBC00FFDDB900FFFFFF00D78201007662
      4A009D968C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009D968C006B5942006B5942006B5942006B5942006B5942006B59
      42006B5942006B5942006B5942006B5942006B5942006B5942006B5942006B59
      42006B5942009D968C0000000000000000000000000000000000D7820100FFFF
      FF00FFEEDD00FFECDA00FFEBD700FFE9D400FFE9D400FFE6CE00FFE5CB00FFE3
      C700FFE2C300FFFFFF00D7820100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D7820100FFFFFF00FFF3E700FFF1E400FFF0E100FFEE
      DE00FFEEDE00FFEBD800FFEAD500FFE8D200FFE6CE00FFFFFF00D78201000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D7820100FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00D7820100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D08A2100D7820100D7820100D7820100D7820100D782
      0100D7820100D7820100D7820100D7820100D7820100D7820100D08A21000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000424D3E000000000000003E000000280000004C0000000F00000001000100
      00000000B40000000000000000000000000000000000000000000000FFFFFF00
      8000300004000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000100004000000
      0000000080003C001C00000000000000FFFFFC001C00000000000000FFFFFC00
      1C00000000000000FFFFFC001C00000000000000000000000000000000000000
      00000000000000000000}
  end
end
