object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'OperARM3 Log Server'
  ClientHeight = 460
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001001010000001000800680500001600000028000000100000002000
    0000010008000000000040010000000000000000000000010000000000000000
    0000FFFFFF000080000000808000800000008000800080800000C0C0C000C0DC
    C000F0CAA60033000000000033003300330033330000161616001C1C1C002222
    220029292900555555004D4D4D004242420039393900807CFF005050FF009300
    D600FFECCC00C6D6EF00D6E7E70090A9AD0000FF330000006600000099000000
    CC00003300000033330000336600003399000033CC000033FF00006600000066
    330000666600006699000066CC000066FF000099000000993300009966000099
    99000099CC000099FF0000CC000000CC330000CC660000CC990000CCCC0000CC
    FF0000FF660000FF990000FFCC0033FF0000FF00330033006600330099003300
    CC003300FF00FF3300003333330033336600333399003333CC003333FF003366
    00003366330033666600336699003366CC003366FF0033990000339933003399
    6600339999003399CC003399FF0033CC000033CC330033CC660033CC990033CC
    CC0033CCFF0033FF330033FF660033FF990033FFCC0033FFFF00660000006600
    330066006600660099006600CC006600FF006633000066333300663366006633
    99006633CC006633FF00666600006666330066666600666699006666CC006699
    00006699330066996600669999006699CC006699FF0066CC000066CC330066CC
    990066CCCC0066CCFF0066FF000066FF330066FF990066FFCC00CC00FF00FF00
    CC009999000099339900990099009900CC009900000099333300990066009933
    CC009900FF00996600009966330099336600996699009966CC009933FF009999
    330099996600999999009999CC009999FF0099CC000099CC330066CC660099CC
    990099CCCC0099CCFF0099FF000099FF330099CC660099FF990099FFCC0099FF
    FF00CC00000099003300CC006600CC009900CC00CC0099330000CC333300CC33
    6600CC339900CC33CC00CC33FF00CC660000CC66330099666600CC669900CC66
    CC009966FF00CC990000CC993300CC996600CC999900CC99CC00CC99FF00CCCC
    0000CCCC3300CCCC6600CCCC9900CCCCCC00CCCCFF00CCFF0000CCFF330099FF
    6600CCFF9900CCFFCC00CCFFFF00CC003300FF006600FF009900CC330000FF33
    3300FF336600FF339900FF33CC00FF33FF00FF660000FF663300CC666600FF66
    9900FF66CC00CC66FF00FF990000FF993300FF996600FF999900FF99CC00FF99
    FF00FFCC0000FFCC3300FFCC6600FFCC9900FFCCCC00FFCCFF00FFFF3300CCFF
    6600FFFF9900FFFFCC006666FF0066FF660066FFFF00FF666600FF66FF00FFFF
    66002100A5005F5F5F00777777008686860096969600CBCBCB00B2B2B200D7D7
    D700DDDDDD00E3E3E300EAEAEA00F1F1F100F8F8F800F0FBFF00A4A0A0008080
    80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000606
    0000060606000600060000060000000006000600000006000600060006000606
    0000060600000606000006000600060000000600000006000600060006000006
    0600060606000606000006000600404040400040404040004040404040004040
    0000004040004000404000004000404000000040400040004040004040004040
    0000004040004000404000000000404000000040404040004040404040000038
    3838383800003838000000383800383800000038380038380000003838003838
    0000003838003838383838383800383800000038380038380000003838003838
    0000003838003838000000383800003838383838000000383838383800001009
    0000C30000001110000033000000801000000000000018040000180000001807
    000018000000811800001818000018000000181800001818000081810000}
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 100
    Top = 0
    Width = 2
    Height = 441
    ExplicitHeight = 453
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 441
    Width = 624
    Height = 19
    Panels = <
      item
        Width = 18
      end
      item
        Width = -1
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 100
    Height = 441
    Align = alLeft
    Caption = ' '#1050#1083#1080#1077#1085#1090#1099': '
    Constraints.MinWidth = 71
    TabOrder = 1
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 96
      Height = 424
      Align = alClient
      BevelOuter = bvNone
      BorderWidth = 3
      TabOrder = 0
      object ClientsListBox: TListBox
        Left = 3
        Top = 3
        Width = 90
        Height = 418
        Hint = #1057#1087#1080#1089#1086#1082' '#1087#1086#1076#1082#1083#1102#1095#1080#1074#1096#1080#1093#1089#1103' '#1074' '#1085#1072#1089#1090#1086#1103#1097#1080#1081' '#1084#1086#1084#1077#1085#1090' '#1082#1083#1080#1077#1085#1090#1086#1074
        Align = alClient
        Color = clBtnFace
        ItemHeight = 13
        PopupMenu = ClientsListBoxPopupMenu
        TabOrder = 0
        OnDblClick = ClientsListBoxDblClick
        OnMouseDown = ClientsListBoxMouseDown
      end
    end
  end
  object Panel2: TPanel
    Left = 102
    Top = 0
    Width = 522
    Height = 441
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 0
      Top = 300
      Width = 522
      Height = 2
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 530
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 0
      Width = 522
      Height = 300
      Align = alTop
      Caption = ' '#1057#1087#1080#1089#1086#1082' '#1089#1086#1086#1073#1097#1077#1085#1080#1081' '
      TabOrder = 0
      object Panel3: TPanel
        Left = 2
        Top = 15
        Width = 518
        Height = 283
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 3
        TabOrder = 0
        object ListView1: TListView
          Left = 3
          Top = 3
          Width = 512
          Height = 277
          Align = alClient
          Columns = <
            item
              Caption = #1058#1080#1087
              Width = -2
              WidthType = (
                -2)
            end
            item
              Caption = #1044#1072#1090#1072
              Width = -2
              WidthType = (
                -2)
            end
            item
              Caption = #1042#1088#1077#1084#1103
              Width = -2
              WidthType = (
                -2)
            end
            item
              Caption = #1040#1076#1088#1077#1089
              Width = -2
              WidthType = (
                -2)
            end
            item
              Alignment = taRightJustify
              Caption = #1057#1086#1073#1099#1090#1080#1077
              Width = -2
              WidthType = (
                -2)
            end
            item
              Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
              Width = -2
              WidthType = (
                -2)
            end>
          ColumnClick = False
          ReadOnly = True
          RowSelect = True
          SmallImages = ImageList1
          TabOrder = 0
          ViewStyle = vsReport
          OnInsert = ListView1Insert
          OnSelectItem = ListView1SelectItem
        end
      end
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 302
      Width = 522
      Height = 139
      Align = alClient
      Caption = ' '#1055#1086#1076#1088#1086#1073#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1080' '
      TabOrder = 1
      object Panel4: TPanel
        Left = 2
        Top = 15
        Width = 518
        Height = 122
        Align = alClient
        BevelOuter = bvNone
        BorderWidth = 3
        TabOrder = 0
        object RichEdit1: TRichEdit
          Left = 3
          Top = 3
          Width = 512
          Height = 116
          Cursor = crNo
          Align = alClient
          Enabled = False
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          WantTabs = True
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Images = ImageList1
    Left = 50
    Top = 290
    object N2: TMenuItem
      Action = Action_Restore
      Default = True
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N6: TMenuItem
      Action = Action_Help
    end
    object N7: TMenuItem
      Action = Action_About
    end
    object N9: TMenuItem
      Caption = '-'
    end
    object N8: TMenuItem
      Action = Action_Quit
    end
  end
  object gsFileVersionInfo1: TgsFileVersionInfo
    Left = 20
    Top = 320
  end
  object ImageList1: TImageList
    AllocBy = 10
    Left = 20
    Top = 350
    Bitmap = {
      494C010107000900140010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000846B5A008C6B5A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000029296B0000006300000063000000630000004A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000946B4A00CE9C6B00AD7B4A00846B5A000000
      000000000000000000000000000000000000000000004A4A4A004A4A4A004A4A
      4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A4A004A4A
      4A004A4A4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002929
      AD000000840000008C0000008C0000008C0000008C0000008C00000084000000
      5200000000000000000000000000000000000000000000000000000000000000
      00000000000000000000946B4A00CEAD8400FFF7C60094634200846B5A000000
      000000000000000000000000000000000000AD7B6B00DEAD9C00D6AD9C00D6A5
      9C00CEA59C00CEA59400CE9C9400C69C9400C69C9400BD948C00BD948C00947B
      73004A4A4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000002929AD000000
      94000000940000009C0000009C000000A50000009C000000940000008C000000
      8C00000063000000000000000000000000000000000000000000000000000000
      0000947363008C634A00E7CEAD00FFDEB500FFDEB500AD846300522908006B42
      3100846B5A00000000000000000000000000AD7B6B00EFE7DE00FFEFDE00FFEF
      D600FFE7CE00FFE7CE00FFDEBD00FFDEBD00FFDEB500FFD6AD00FFD6A500DEAD
      AD00735A52004A4A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002929AD000000A5000808
      9C009C9CD6006B6BD6000000AD000000AD000000AD004A4ABD00B5B5E7002121
      A50000008C000000520000000000000000000000000000000000BDA59C00BDA5
      9C00D6B59C00E7CEAD00FFE7BD00FFEFC600FFFFD600F7D6B500DEBD9400AD8C
      63005A291000846B5A00000000000000000000000000C68C7B00FFF7E700FFEF
      DE006B9C5A00FFE7CE00FFE7CE00FFDEBD00FFDEBD00FFDEB500FFD6AD00F7BD
      B5007B635A004A4A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002929AD000000AD002929
      A500DEDED600FFFFFF006363D6000000B5004242C600E7E7EF00FFFFF7005A5A
      B50000009C0000008400000000000000000000000000CEB5A500EFDEC600EFD6
      BD00FFEFCE00FFD6B500C6734A00EF946300DE8C5A00DEA57B00FFE7C600F7D6
      B500D6B59400734229008C6B63000000000000000000CE947B00FFF7EF00FFF7
      E700298429007BAD6B00FFE7CE00FFE7CE00FFDEBD00FFDEBD00FFDEB500FFCE
      AD009C7B73004A4A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4AD6000000B5000000BD000000
      C6004A4AA500E7E7DE00FFFFFF009C9CE700EFEFF700FFFFF7007373BD000000
      B5000000AD000000A50010105A0000000000CEBDA500EFDEC600EFDEC600FFEF
      D600FFEFCE00FFFFE700B58463007B0000008C290000F7E7C600FFEFCE00FFE7
      C600F7D6B500DEBD9C005A2910000000000000000000CE9C8400F7EFEF00FFF7
      EF002984290029842900B5C69400FFE7CE00FFE7CE00FFDEBD00FFDEBD00FFDE
      B500DEA5A5004A4A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4AD6000808BD000000CE000000
      D6000000CE005252B500F7F7EF00FFFFFF00FFFFFF007373CE000000BD000000
      C6000000BD000000AD0010106B0000000000C6B5A500EFDEC600FFF7D600FFEF
      D600FFE7CE00FFFFEF00CEB594006B000000A55A3100FFFFF700FFE7CE00FFE7
      C600FFEFCE00FFE7C600AD8C6B0094736B002984290029842900298429002984
      29002984290018B5390008841000EFDEC600FFE7CE00FFE7CE00FFDEBD00FFDE
      BD00F7BDAD007B6B5A004A4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4AD6000808CE000808DE000808
      DE000000D6003939CE00EFEFEF00FFFFFF00FFFFFF005A5ADE000000CE000000
      CE000000C6000000BD0010107B0000000000CEBDAD00FFE7D600FFF7DE00FFEF
      D600FFEFD600FFFFF700CEAD940073000000A5523100FFFFF700FFEFCE00FFE7
      CE00FFEFCE00FFEFD600E7CEAD008C6B5A003194390052EF8C0042E77B0039D6
      6B0031CE630021BD420010AD210021842100FFEFD600FFE7CE00FFE7CE00FFDE
      BD00FFD6B5009C847B004A4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4AD6001010DE001010EF000808
      F7004242DE00E7E7EF00FFFFF700BDBDD600EFEFEF00FFFFFF006363E7000000
      D6000808CE000808C60021217B0000000000CEC6B500FFEFE700FFF7E700FFEF
      DE00FFF7DE00FFFFFF00D6C6AD0073000000A55A3100FFFFFF00FFEFD600FFEF
      D600FFEFD600FFF7DE00EFD6C600846B5A00319439004ADE730039CE630031C6
      5A0029BD520021BD4A0010A5210029842900FFEFDE00FFEFD600FFE7CE00FFE7
      CE00FFDEBD00E7A59C004A4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A4AD6002121E7002121FF003939
      EF00DEDEE700FFFFEF007373C6000000D6005252B500E7E7D600FFFFFF006363
      E7000808DE000808CE0010107B0000000000D6C6BD00FFF7EF00FFFFEF00FFF7
      E700FFFFEF00EFE7DE008C391800630000008C392100FFFFFF00FFF7DE00FFEF
      D600FFEFDE00FFFFE700F7DECE00947B73000000000000000000CE9C8400CED6
      BD00298C310021BD4A0021842900FFF7EF00FFF7E700FFEFDE00FFEFD600FFE7
      CE00FFE7CE00FFB5AD004A4A4A004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003131FF003131FF005252
      EF00B5B5C6007373CE000000EF000000EF000000EF005252B500ADADB5004A4A
      E7001818EF001818B5000000000000000000DED6CE00F7F7EF00FFFFFF00FFF7
      EF00FFFFFF00E7DECE00B5948400BDA59C00C6ADA500FFFFFF00FFF7E700FFEF
      DE00FFFFEF00FFFFFF00E7CEB500947B7300000000000000000000000000CE9C
      84003194390018842900F7FFF700FFFFF700FFF7EF00FFF7E700FFEFDE00FFE7
      D600FFDECE00FFC6B500A58C7B004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003131FF003939FF005252
      FF006B6BEF005252FF003939FF002121FF002929FF003939FF004242EF003131
      FF001818EF003131FF00000000000000000000000000E7E7E700FFFFFF00FFFF
      FF00FFFFF700FFFFFF00FFFFFF00FFCEA500FFFFEF00FFFFFF00FFF7EF00FFFF
      EF00FFFFFF00FFFFFF00AD94840000000000000000000000000000000000DEAD
      840029842900DEEFDE00FFFFFF00FFFFFF00FFFFF700FFF7EF00FFE7D600DEA5
      8400D6947300D68C6B00BD9C84004A4A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003131FF004A4A
      FF006B6BFF009494FF009494FF008484FF007373FF006363FF005252FF003131
      FF003131FF0000000000000000000000000000000000EFE7E700EFEFEF00FFFF
      FF00FFFFFF00FFFFFF008C524A005A0000009C422900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D6BDAD000000000000000000000000000000000000000000DEAD
      8400FFF7EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7EF00DEAD
      8400FFB54A00E7AD6B004A4A4A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003131
      FF003131FF006B6BFF008484FF009494FF007373FF005252FF005252F7003131
      FF00000000000000000000000000000000000000000000000000F7EFE700F7F7
      F700FFFFFF00FFFFFF00D6CECE0063424200C6B5AD00FFFFFF00FFFFFF00FFFF
      FF00EFDED6000000000000000000000000000000000000000000000000000000
      0000DEAD8400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DEAD
      8400E7BD94004A4A4A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003131FF003131FF003131FF003131FF003131FF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFE7DE00F7F7EF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DECEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD8400DEAD
      84004A4A4A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005242420052424200524242005242420052424200524242000000
      0000000000000000000000000000000000000000000000000000636363006363
      6300636363006363630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      840084848400848484008484840000000000000000000000000000000000B58C
      7B00B5948400F7E7D600EFE7DE00EFE7DE00F7E7DE00F7E7D600BDA59C005242
      42005242420000000000000000000000000000000000CEA5A500CE9C9C00D6A5
      9C00CE9C9C00BD8C8C0063636300636363006363630063636300636363006363
      63000000000000000000000000000000000000000000000000000831B5001031
      BD001839BD001839B5001839BD001039BD001031BD000831C6000831C6000029
      BD000029C6000021B50000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000BDA59C00F7E7
      DE00FFF7F700E7DED600DEB59C00D6A58C00E7C6BD00EFEFEF00F7F7F700F7E7
      D600E7CEBD0052424200000000000000000000000000CEA5A500CE9C9C00DEAD
      9C00FFD6A500F7C69C00EFB59C00DEAD9C00CE9C9C00C6949400A57373008463
      5A0063636300636363006363630000000000000000001039D6001842DE00294A
      DE002952DE002952DE002952DE002952DE00214ADE00184AE7001042E7000842
      E7000039E7000031D6000021B500000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00000000008484840000000000BDA59C00F7EFE700FFFF
      FF00C68C7300BD5A2900BD5A2900DEB59C00BD5A2900BD5A2900D69C8400F7F7
      F700F7E7DE00D6C6BD00524242000000000000000000CEA5A500EFC69C00CE9C
      9C00EFCEAD00FFE7B500FFDEAD00FFDEA500FFD6A500F7C69C00EFB59C00DEAD
      9C00D69C9C00CE9C9C00A57B730063636300000000001842DE002952E700315A
      E7004263E7007B94EF00E7EFFF00FFFFFF00FFFFFF00DEE7FF007394F700104A
      EF000842EF000039E7000029BD00000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000008484840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF00000000008484840000000000BDA59C00FFFFFF00CE6B
      4200BD5A2900BD5A2900C6A59400FFFFFF00E7845200BD5A2900BD5A2900D694
      7300FFFFF700F7E7D600524242000000000000000000CEA5A500F7D6B500F7D6
      AD00CE9C9C00F7EFBD00FFFFC600FFF7BD00FFEFB500FFE7B500FFDEAD00FFDE
      A500F7C69C00CE9C9C00CE9C9C006363630000000000214ADE00395AE7004263
      E700A5B5F700FFFFFF00BDCEF700738CEF006B8CEF00BDCEFF00FFFFFF009CB5
      F700084AEF000839E7000029C600000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000008484840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000BDA59C00FFFFFF00DE9C7B00BD5A
      2900CE633100CE633100CE6B3900D68C6300CE633100CE633100BD5A2900BD5A
      2900E7CEBD00F7EFEF00DECEC6005242420000000000CEA5A500F7E7BD00FFFF
      C600E7CEB500D6ADA500FFFFD600FFFFD600FFFFD600FFFFCE00FFFFC600FFEF
      BD00D6A59C00DEAD9C00CE9C9C0063636300000000002952E7004263E7008C9C
      EF00FFFFFF00849CEF00426BE7004263E7003163EF00295AEF007394F700FFFF
      FF006B8CF7000842E7000831C60000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00000000008484840000000000D6C6BD00FFF7F700C6633100BD5A
      2900CE633100BD5A2900CE846300F7E7DE00D66B3900BD5A2900CE633100BD5A
      2900CE734200FFFFFF00E7CEBD005242420000000000CEA5A500F7E7C600FFFF
      D600FFFFCE00DEB5A500DEBDB500FFFFEF00FFFFE700FFFFDE00FFFFD600D6AD
      A500DEB5A500FFDEA500CE9C9C006363630000000000315AE7004A6BE700EFEF
      FF00BDC6F7004A6BE7004A6BE700FFFFFF00FFFFFF00295AEF002152EF00B5C6
      FF00DEE7FF00184AE7001039C60000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00000000000000000000000000D6C6BD00F7DED600BD5A2900CE63
      3100CE633100BD5A2900D6845200FFFFFF00E7AD9400BD5A2900BD5A2900CE63
      3100BD5A2900FFEFEF00F7DED6005242420000000000CEA5A500F7E7D600FFFF
      E700F7E7CE00D6ADA500CE9C9C00DEBDBD00F7E7DE00F7EFDE00D6ADA500DEBD
      AD00FFF7C600FFF7BD00CE9C9C006363630000000000395AE700526BE700FFFF
      FF008494EF00526BE7004A6BE700FFFFFF00FFFFFF00295AE7002152E7006384
      EF00FFFFFF00184ADE001839C6000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000848400000000000084840000FFFF0000FFFF0000FF
      FF0000000000848484000000000000000000D6C6BD00F7D6CE00CE633100CE63
      3100CE633100CE633100BD5A2900DEAD9400FFF7F700EF9C7300BD5A2900CE63
      3100BD5A2900F7F7EF00EFE7DE005242420000000000D6A5A500EFDECE00DEBD
      B500CE9C9C00DED6D600DEF7F700CEC6C600BDADB500CE9C9C00C6A5A500DEBD
      AD00FFFFCE00FFFFCE00CE9C9C0063636300000000004263E7005A73EF00FFFF
      FF008494EF00526BE7004A63E700FFFFFF00FFFFFF002952E7002152E7006384
      EF00FFFFFF00214ADE001839BD000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000D6C6BD00FFEFE700D66B3900CE63
      3100CE633100BD5A2900BD5A2900BD5A2900E7CEC600FFFFFF00D66B3900CE63
      3100CE6B3900FFFFFF00F7DED6005242420000000000D6ADAD00CE9C9C00BDB5
      BD00FFFFFF00FFFFFF00F7FFFF00EFFFFF00EFFFFF00E7FFFF00DEFFFF00CEAD
      AD00DEBDB500FFFFDE00CE9C9C0063636300000000004A6BE700637BEF00EFF7
      FF00B5C6F700526BE7004A63E700FFFFFF00FFFFFF002952E700214AE700B5BD
      F700E7E7FF002952DE002142BD00000000000000000000000000000000000084
      840000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      000084848400000000000000000000000000D6C6BD00FFFFFF00F79C6B00D66B
      3900CE8C6B00F7EFE700D6845200BD5A2900D6947300FFFFFF00E78C5A00BD5A
      2900EF946300FFFFFF00D6C6BD005242420000000000CE9C9C009C8C9C005294
      BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00EFFFFF00E7FFFF00D6EF
      F700B59C9C00DEBDB500CE9C9C006363630000000000526BE7006B84EF0094AD
      F700FFFFFF008494EF004A63E7004263E700395AE7003152E7006B84EF00FFFF
      FF00738CEF002952DE002142BD00000000000000000000000000000000000084
      840000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      00000000000000000000000000000000000000000000D6C6BD00FFEFDE00EF84
      5200E7845200F7F7F700FFFFFF00DEBDAD00FFFFFF00F7F7F700DE734200D673
      3900FFF7EF00F7E7E70052424200000000000000000000000000CE9C9C00428C
      B500DEEFF700BDDEE7008CBDD60084B5CE00398CB500398CB500297BA5004273
      9C0073849C00CE9C9C00CE9C9C0063636300000000005A7BEF007B94EF00738C
      EF00A5B5F700FFFFFF00B5BDF7007384EF006B84EF00B5BDF700FFFFFF0094AD
      F7003152E7002952DE002142BD00000000000000000000000000000000000000
      00000084840000FFFF0000FFFF000000000000FFFF0000FFFF00000000008484
      84000000000000000000000000000000000000000000D6C6BD00FFFFFF00FFEF
      D600FFAD7300EFAD8C00EFE7DE00EFEFEF00F7E7E700FFA57B00F78C5A00F7DE
      CE00FFFFFF00D6C6BD0000000000000000000000000000000000000000003984
      A5004A7B9C00529CBD005ABDDE0073C6E7008CCEFF0094CEFF0094CEFF008CC6
      FF00B5A5BD00CE9C9C006363630000000000000000006B84EF008CA5EF008494
      EF006B8CEF0094ADF700EFF7FF00FFFFFF00FFFFFF00EFEFFF008C9CEF004263
      E700395AE7003152DE001839BD00000000000000000000000000000000000000
      00000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000D6C6BD00FFFF
      FF00FFFFFF00FFF7C600FFDEAD00FFD69C00FFC69400FFD6AD00FFFFFF00FFFF
      FF00D6C6BD000000000000000000000000000000000000000000000000000000
      0000CE9C9C00CE9C9C00A5E7EF0094EFFF0094E7FF0094DEFF009CCEF700BDA5
      B5006363630063636300000000000000000000000000738CEF009CADF7008CA5
      EF007B94EF00738CEF006B84EF00637BEF00637BEF005A7BEF005273E7004A6B
      E7004263E7002952DE001839BD00000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000848484000000
      000000000000000000000000000000000000000000000000000000000000D6C6
      BD00D6C6BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECEC600D6C6
      BD00000000000000000000000000000000000000000000000000000000000000
      000000000000CE9C9C00CE9C9C00ADD6DE00A5DEE700ADC6D600CE9C9C006363
      6300636363000000000000000000000000000000000000000000738CEF006384
      EF005A73EF005273E7004A6BE7004A6BE7004A6BE7004263E7003963E700395A
      E7003152E7002142DE0000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DECEC600D6C6BD00D6C6BD00D6C6BD00D6C6BD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEB5B500DEB5B500DEBDBD00636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484000084840000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFFFF3FFFFF0000F83FFE1F80070000
      E00FFC1F00070000C007F007000300008003C003800300008003800180030000
      0001000180030000000100000001000000010000000100000001000000010000
      00010000C000000080030000E000000080038001E0000000C0078003E0010000
      E00FC007F0030000F83FF01FF0070000F81FC3FFFFFFC001E007800FC0038000
      C003800180010000800180008001000080018000800100010000800080018001
      0000800080018003000080008001C003000080008001C007000080008001E007
      000080008001E00F8001C0008001F00F8003E0018001F01FC007F0038001F81F
      E00FF807C003F83FF83FFE1FFFFFFC7F00000000000000000000000000000000
      000000000000}
  end
  object ActionList1: TActionList
    Images = ImageList1
    Left = 50
    Top = 350
    object Action_Quit: TAction
      Caption = #1047#1072#1074#1077#1088#1096#1080#1090#1100' '#1088#1072#1073#1086#1090#1091
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 2
      ShortCut = 32883
      SecondaryShortCuts.Strings = (
        'F10'
        'Ctrl+Q')
      OnExecute = Action_QuitExecute
    end
    object Action_Help: TAction
      Caption = #1057#1087#1088#1072#1074#1082#1072
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 0
      ShortCut = 112
      SecondaryShortCuts.Strings = (
        'Ctrl+H')
      OnExecute = Action_HelpExecute
    end
    object Action_About: TAction
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077#1081' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' '#1080' '#1077#1105' '#1072#1074#1090#1086 +
        #1088#1077
      ImageIndex = 5
      ShortCut = 16496
      OnExecute = Action_AboutExecute
    end
    object Action_SendMessageToClient: TAction
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077'...'
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1090#1077#1082#1089#1090#1086#1074#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1082#1083#1080#1077#1085#1090#1089#1082 +
        #1086#1081' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 1
      OnExecute = Action_SendMessageToClientExecute
    end
    object Action_ManageClient: TAction
      Caption = #1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1082#1083#1080#1077#1085#1090#1086#1084'...'
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1091#1076#1072#1083#1105#1085#1085#1086#1075#1086' '#1091#1087#1088#1072#1074#1083#1077#1085#1080#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1085#1099#1084#1080' '#1082#1083 +
        #1080#1077#1085#1090#1072#1084#1080
    end
    object Action_Restore: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1075#1083#1072#1074#1085#1086#1075#1086' '#1086#1082#1085#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 6
      OnExecute = Action_RestoreExecute
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 20
    Top = 380
    object N1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object N16: TMenuItem
        Action = Action_Quit
      end
    end
    object N17: TMenuItem
      Caption = '&'#1050#1083#1080#1077#1085#1090#1099
      object N14: TMenuItem
        Action = Action_SendMessageToClient
      end
      object N13: TMenuItem
        Action = Action_ManageClient
      end
    end
    object miQuestion: TMenuItem
      Caption = '&?'
      object N11: TMenuItem
        Action = Action_Help
      end
      object N12: TMenuItem
        Action = Action_About
      end
    end
  end
  object ClientsListBoxPopupMenu: TPopupMenu
    OnPopup = ClientsListBoxPopupMenuPopup
    Left = 20
    Top = 290
    object miViewClientIP: TMenuItem
      Caption = 'IP-'#1072#1076#1088#1077#1089':'
      Enabled = False
    end
    object miViewClientLoggedUser: TMenuItem
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
      Enabled = False
    end
    object N19: TMenuItem
      Caption = '-'
    end
    object N15: TMenuItem
      Action = Action_SendMessageToClient
      Default = True
    end
    object N18: TMenuItem
      Action = Action_ManageClient
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 50
    Top = 380
  end
end
