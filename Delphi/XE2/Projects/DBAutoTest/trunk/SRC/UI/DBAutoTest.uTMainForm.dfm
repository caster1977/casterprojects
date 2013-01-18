object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 416
  ClientWidth = 381
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 397
    Width = 381
    Height = 19
    Panels = <>
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 381
    Height = 397
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 8
    TabOrder = 1
    ExplicitLeft = 176
    ExplicitTop = 136
    ExplicitWidth = 185
    ExplicitHeight = 41
    object pnlButtons: TPanel
      Left = 8
      Top = 356
      Width = 365
      Height = 33
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object btnProcess: TButton
        Left = 290
        Top = 8
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Align = alRight
        Caption = 'btnProcess'
        TabOrder = 0
        ExplicitLeft = 298
      end
      object btnProfiles: TButton
        Left = 0
        Top = 8
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Align = alLeft
        Caption = 'btnProfiles'
        TabOrder = 1
        ExplicitLeft = 8
      end
      object pnlTopButtonSpacer: TPanel
        Left = 0
        Top = 0
        Width = 365
        Height = 8
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        ExplicitLeft = 152
        ExplicitTop = 16
        ExplicitWidth = 185
      end
    end
    object ListView1: TListView
      Left = 8
      Top = 8
      Width = 365
      Height = 348
      Cursor = crHandPoint
      Align = alClient
      Columns = <
        item
          Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1090#1077#1089#1090#1072
          Width = 250
        end
        item
          Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
          Width = -2
          WidthType = (
            -2)
        end>
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object MainMenu: TMainMenu
    Images = ImageList
    Left = 104
    Top = 48
    object N1: TMenuItem
      Action = actFileMenuGroup
      object N4: TMenuItem
        Action = actQuit
      end
    end
    object N2: TMenuItem
      Action = actActionMenuGroup
    end
    object N3: TMenuItem
      Action = actHelpMenuGroup
      object N6: TMenuItem
        Action = actHelpContents
      end
      object N5: TMenuItem
        Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
        Hint = 
          #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077 +
          #1081' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' '#1080' '#1077#1105' '#1072#1074#1090#1086#1088#1077
        ImageIndex = 1
      end
    end
  end
  object ActionList: TActionList
    Images = ImageList
    Left = 104
    Top = 120
    object actHelpMenuGroup: THelpMenuGroupAction
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
    end
    object actFileMenuGroup: TFileMenuGroupAction
      Category = #1060#1072#1081#1083
      Caption = '&'#1060#1072#1081#1083
    end
    object actActionMenuGroup: TActionMenuGroupAction
      Category = #1044#1077#1081#1089#1090#1074#1080#1077
      Caption = '&'#1044#1077#1081#1089#1090#1074#1080#1077
    end
    object actHelpContents: THelpContentsAction
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = '&'#1054#1075#1083#1072#1074#1083#1077#1085#1080#1077
      Enabled = False
      Hint = 
        #1054#1075#1083#1072#1074#1083#1077#1085#1080#1077' '#1089#1087#1088#1072#1074#1082#1080'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103' '#1089#1087#1088#1072#1074 +
        #1082#1080' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 2
      ShortCut = 112
    end
    object actAbout: TAction
      Category = #1057#1087#1088#1072#1074#1082#1072
      Caption = #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      Hint = 
        #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077 +
        #1081' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' '#1080' '#1077#1105' '#1072#1074#1090#1086#1088#1077
      ImageIndex = 3
    end
    object actQuit: TQuitAction
      Category = #1060#1072#1081#1083
      Caption = '&'#1042#1099#1093#1086#1076
      Hint = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1088#1072#1073#1086#1090#1099'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 5
      ShortCut = 32883
      OnExecute = actQuitExecute
    end
  end
  object ImageList: TImageList
    Left = 40
    Top = 48
    Bitmap = {
      494C0101060008000C0010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF009999CC000033CC000033
      CC003333CC003333CC003333CC000033CC000033CC000033CC000033CC000033
      CC000033CC000033CC006699CC00FFFFFF00FFFFFF009999CC000033CC000033
      CC003333CC003333CC003333CC000033CC000033CC000033CC000033CC000033
      CC000033CC000033CC006699CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF000033CC003333CC003333
      CC003366CC003366CC003366CC003366CC003333CC003333CC000033CC000033
      CC000033CC000033CC000033CC00FFFFFF00FFFFFF000033CC003333CC003333
      CC003366CC003366CC003366CC003366CC003333CC003333CC000033CC000033
      CC000033CC000033CC000033CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF003333CC003366CC003366
      CC003366CC006699FF00F1F1F100FFFFFF00FFFFFF00D6E7E7006699FF000033
      FF000033FF000033CC000033CC00FFFFFF00FFFFFF003333CC003366CC003366
      CC003366CC006699FF00F1F1F100FFFFFF00FFFFFF00D6E7E7006699FF000033
      FF000033FF000033CC000033CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF003333CC003366CC003366
      CC0099CCFF00FFFFFF00C6D6EF006699FF006699FF00CCCCFF00FFFFFF0099CC
      FF000033FF000033CC000033CC00FFFFFF00FFFFFF003333CC003366CC003366
      CC0099CCFF00FFFFFF00C6D6EF006699FF006699FF00CCCCFF00FFFFFF0099CC
      FF000033FF000033CC000033CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF003366CC003366CC009999
      FF00FFFFFF009999FF003366CC003366CC003366FF003366FF006699FF00FFFF
      FF006699FF000033CC000033CC00FFFFFF00FFFFFF003366CC003366CC009999
      FF00FFFFFF009999FF003366CC003366CC003366FF003366FF006699FF00FFFF
      FF006699FF000033CC000033CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF003366CC003366CC00F1F1
      F100CCCCFF003366CC003366CC00FFFFFF00FFFFFF003366FF003366FF00CCCC
      FF00D6E7E7003333CC000033CC00FFFFFF00FFFFFF003366CC003366CC00F1F1
      F100CCCCFF003366CC003366CC00FFFFFF00FFFFFF003366FF003366FF00CCCC
      FF00D6E7E7003333CC000033CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF003366CC006666CC00FFFF
      FF009999FF006666CC003366CC00FFFFFF00FFFFFF003366CC003366CC006699
      FF00FFFFFF003333CC003333CC00FFFFFF00FFFFFF003366CC006666CC00FFFF
      FF009999FF006666CC003366CC00FFFFFF00FFFFFF003366CC003366CC006699
      FF00FFFFFF003333CC003333CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF003366CC006666FF00FFFF
      FF009999FF006666CC005050FF00FFFFFF00FFFFFF003366CC003366CC006699
      FF00FFFFFF003333CC003333CC00FFFFFF00FFFFFF003366CC006666FF00FFFF
      FF009999FF006666CC005050FF00FFFFFF00FFFFFF003366CC003366CC006699
      FF00FFFFFF003333CC003333CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF003366CC006666FF00F0FB
      FF00C6D6EF006666CC005050FF00FFFFFF00FFFFFF003366CC003333CC00CCCC
      FF00EAEAEA003366CC003333CC00FFFFFF00FFFFFF003366CC006666FF00F0FB
      FF00C6D6EF006666CC005050FF00FFFFFF00FFFFFF003366CC003333CC00CCCC
      FF00EAEAEA003366CC003333CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF006666CC00807CFF009999
      FF00FFFFFF009999FF005050FF003366CC003366CC003366CC00807CFF00FFFF
      FF006699FF003366CC003333CC00FFFFFF00FFFFFF006666CC00807CFF009999
      FF00FFFFFF009999FF005050FF003366CC003366CC003366CC00807CFF00FFFF
      FF006699FF003366CC003333CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF006666FF006699FF006699
      FF0099CCFF00FFFFFF00CCCCFF00807CFF00807CFF00CCCCFF00FFFFFF009999
      FF003366CC003366CC003333CC00FFFFFF00FFFFFF006666FF006699FF006699
      FF0099CCFF00FFFFFF00CCCCFF00807CFF00807CFF00CCCCFF00FFFFFF009999
      FF003366CC003366CC003333CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00807CFF009999FF009999
      FF006699FF009999FF00F0FBFF00FFFFFF00FFFFFF00F1F1F1009999FF003366
      CC003366CC003366CC003333CC00FFFFFF00FFFFFF00807CFF009999FF009999
      FF006699FF009999FF00F0FBFF00FFFFFF00FFFFFF00F1F1F1009999FF003366
      CC003366CC003366CC003333CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF006699FF009999FF009999
      FF006699FF006699FF00807CFF006666FF006666FF006666FF006666CC003366
      CC003366CC003366CC003333CC00FFFFFF00FFFFFF006699FF009999FF009999
      FF006699FF006699FF00807CFF006666FF006666FF006666FF006666CC003366
      CC003366CC003366CC003333CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00CCCCFF006699FF006699
      FF006666FF006666CC003366CC003366CC003366CC003366CC003366CC003366
      CC003366CC003333CC009999CC00FFFFFF00FFFFFF00CCCCFF006699FF006699
      FF006666FF006666CC003366CC003366CC003366CC003366CC003366CC003366
      CC003366CC003333CC009999CC00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000009966660099666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009966660099666600000000000000
      000000000000000000000000000000000000FFFFFF009999CC000033CC000033
      CC003333CC003333CC003333CC000033CC000033CC000033CC000033CC000033
      CC000033CC000033CC006699CC00FFFFFF000000000000000000000000000000
      000000000000000000000000000099663300CC99660099663300996666000000
      000000000000000000000000000000000000000000000000000000000000CC99
      6600CC999900FFECCC00E3E3E300E3E3E300EAEAEA00FFECCC00CC9999004D4D
      4D004D4D4D000000000000000000000000000000000000000000000000000000
      000000000000000000000000000099663300CC99660099663300996666000000
      000000000000000000000000000000000000FFFFFF000033CC003333CC003333
      CC003366CC003366CC003366CC003366CC003333CC003333CC000033CC000033
      CC000033CC000033CC000033CC00FFFFFF000000000000000000000000000000
      0000000000000000000099663300CC999900FFECCC0099663300996666000000
      0000000000000000000000000000000000000000000000000000CC999900EAEA
      EA00F8F8F800DDDDDD00CCCC9900CC999900F0CAA600EAEAEA00F1F1F100FFEC
      CC00F0CAA6004D4D4D0000000000000000000000000000000000000000000000
      0000000000000000000099663300CC999900FFECCC0099663300996666000000
      000000000000000000000000000000000000FFFFFF003333CC003366CC003366
      CC003366CC006699FF00F1F1F100FFFFFF00FFFFFF00D6E7E7006699FF000033
      FF000033FF000033CC000033CC00FFFFFF000000000000000000000000000000
      00009966660099663300F0CAA600F0CAA600F0CAA60099996600663300006633
      33009966660000000000000000000000000000000000CC999900EAEAEA00FFFF
      FF00CC996600CC663300CC663300CCCC9900CC663300CC663300CC999900F1F1
      F100EAEAEA00CBCBCB004D4D4D00000000000000000000000000000000000000
      00009966660099663300F0CAA600F0CAA600F0CAA60099996600663300006633
      330099666600000000000000000000000000FFFFFF003333CC003366CC003366
      CC0099CCFF00FFFFFF00C6D6EF006699FF006699FF00CCCCFF00FFFFFF0099CC
      FF000033FF000033CC000033CC00FFFFFF000000000000000000CC999900CC99
      9900CCCC9900F0CAA600FFECCC00FFECCC00FFFFCC00F0CAA600CCCC99009999
      66006633000099666600000000000000000000000000CC999900FFFFFF00CC66
      3300CC663300CC663300CC999900FFFFFF00CC996600CC663300CC663300CC99
      6600F8F8F800FFECCC004D4D4D00000000000000000000000000CC999900CC99
      9900CCCC9900F0CAA600FFECCC00FFECCC00FFFFCC00F0CAA600CCCC99009999
      660066330000996666000000000000000000FFFFFF003366CC003366CC009999
      FF00FFFFFF009999FF003366CC003366CC003366FF003366FF006699FF00FFFF
      FF006699FF000033CC000033CC00FFFFFF0000000000CCCC9900FFECCC00F0CA
      A600FFECCC00F0CAA600CC663300FF996600CC996600CC996600FFECCC00F0CA
      A600CCCC9900663333009966660000000000CC999900FFFFFF00CC996600CC66
      3300CC663300CC663300CC663300CC996600CC663300CC663300CC663300CC66
      3300F0CAA600F1F1F100CCCCCC004D4D4D0000000000CCCC9900FFECCC00F0CA
      A600FFECCC00F0CAA600CC663300FF996600CC996600CC996600FFECCC00F0CA
      A600CCCC9900663333009966660000000000FFFFFF003366CC003366CC00F1F1
      F100CCCCFF003366CC003366CC00FFFFFF00FFFFFF003366FF003366FF00CCCC
      FF00D6E7E7003333CC000033CC00FFFFFF00CCCC9900FFECCC00FFECCC00FFEC
      CC00FFECCC00F1F1F100CC9966008000000099330000FFECCC00FFECCC00FFEC
      CC00F0CAA600CCCC99006633000000000000CBCBCB00F8F8F800CC663300CC66
      3300CC663300CC663300CC996600EAEAEA00CC663300CC663300CC663300CC66
      3300CC663300FFFFFF00F0CAA6004D4D4D00CCCC9900FFECCC00FFECCC00FFEC
      CC00FFECCC00F1F1F100CC9966008000000099330000FFECCC00FFECCC00FFEC
      CC00F0CAA600CCCC99006633000000000000FFFFFF003366CC006666CC00FFFF
      FF009999FF006666CC003366CC00FFFFFF00FFFFFF003366CC003366CC006699
      FF00FFFFFF003333CC003333CC00FFFFFF00B2B2B200FFECCC00FFECCC00FFEC
      CC00FFECCC00F8F8F800CCCC99006600000099663300F8F8F800FFECCC00FFEC
      CC00FFECCC00FFECCC009999660099666600CBCBCB00FFECCC00CC663300CC66
      3300CC663300CC663300CC996600FFFFFF00CC999900CC663300CC663300CC66
      3300CC663300F1F1F100FFECCC004D4D4D00B2B2B200FFECCC00FFECCC00FFEC
      CC00FFECCC00F8F8F800CCCC99006600000099663300F8F8F800FFECCC00FFEC
      CC00FFECCC00FFECCC009999660099666600FFFFFF003366CC006666FF00FFFF
      FF009999FF006666CC005050FF00FFFFFF00FFFFFF003366CC003366CC006699
      FF00FFFFFF003333CC003333CC00FFFFFF00C0C0C000FFECCC00FFECCC00FFEC
      CC00FFECCC00F8F8F800CC9999008000000099663300F8F8F800FFECCC00FFEC
      CC00FFECCC00FFECCC00F0CAA60099666600CBCBCB00FFCCCC00CC663300CC66
      3300CC663300CC663300CC663300CC999900F8F8F800FF996600CC663300CC66
      3300CC663300F1F1F100E3E3E3004D4D4D00C0C0C000FFECCC00FFECCC00FFEC
      CC00FFECCC00F8F8F800CC9999008000000099663300F8F8F800FFECCC00FFEC
      CC00FFECCC00FFECCC00F0CAA60099666600FFFFFF003366CC006666FF00F0FB
      FF00C6D6EF006666CC005050FF00FFFFFF00FFFFFF003366CC003333CC00CCCC
      FF00EAEAEA003366CC003333CC00FFFFFF00C0C0C000F1F1F100F1F1F100FFEC
      CC00FFECCC00FFFFFF00CCCC99008000000099663300FFFFFF00FFECCC00FFEC
      CC00FFECCC00FFECCC00FFCCCC0099666600CBCBCB00F1F1F100CC663300CC66
      3300CC663300CC663300CC663300CC663300CCCCCC00FFFFFF00CC663300CC66
      3300CC663300FFFFFF00FFECCC004D4D4D00C0C0C000F1F1F100F1F1F100FFEC
      CC00FFECCC00FFFFFF00CCCC99008000000099663300FFFFFF00FFECCC00FFEC
      CC00FFECCC00FFECCC00FFCCCC0099666600FFFFFF006666CC00807CFF009999
      FF00FFFFFF009999FF005050FF003366CC003366CC003366CC00807CFF00FFFF
      FF006699FF003366CC003333CC00FFFFFF00CBCBCB00F1F1F100F8F8F800F1F1
      F100F8F8F800E3E3E300993333006600000099333300FFFFFF00FFECCC00FFEC
      CC00FFECCC00F1F1F100FFECCC0080808000CBCBCB00FFFFFF00FF996600CC66
      3300CC996600EAEAEA00CC996600CC663300CC996600FFFFFF00CC996600CC66
      3300FF996600FFFFFF00CBCBCB004D4D4D00CBCBCB00F1F1F100F8F8F800F1F1
      F100F8F8F800E3E3E300993333006600000099333300FFFFFF00FFECCC00FFEC
      CC00FFECCC00F1F1F100FFECCC0080808000FFFFFF006666FF006699FF006699
      FF0099CCFF00FFFFFF00CCCCFF00807CFF00807CFF00CCCCFF00FFFFFF009999
      FF003366CC003366CC003333CC00FFFFFF00D7D7D700F1F1F100FFFFFF00F1F1
      F100FFFFFF00D7D7D700CC999900CC999900CC999900FFFFFF00F1F1F100FFEC
      CC00F8F8F800FFFFFF00F0CAA6008080800000000000CBCBCB00FFECCC00FF99
      6600CC996600F1F1F100FFFFFF00F0CAA600FFFFFF00F1F1F100CC663300CC66
      3300F1F1F100EAEAEA004D4D4D0000000000D7D7D700F1F1F100FFFFFF00F1F1
      F100FFFFFF00D7D7D700CC999900CC999900CC999900FFFFFF00F1F1F100FFEC
      CC00F8F8F800FFFFFF00F0CAA60080808000FFFFFF00807CFF009999FF009999
      FF006699FF009999FF00F0FBFF00FFFFFF00FFFFFF00F1F1F1009999FF003366
      CC003366CC003366CC003333CC00FFFFFF0000000000E3E3E300FFFFFF00FFFF
      FF00F8F8F800FFFFFF00FFFFFF00FFCC9900F8F8F800FFFFFF00F1F1F100F8F8
      F800FFFFFF00FFFFFF00969696000000000000000000CBCBCB00FFFFFF00FFEC
      CC00FF996600FF999900E3E3E300EAEAEA00EAEAEA00FF996600FF996600FFEC
      CC00FFFFFF00CBCBCB00000000000000000000000000E3E3E300FFFFFF00FFFF
      FF00F8F8F800FFFFFF00FFFFFF00FFCC9900F8F8F800FFFFFF00F1F1F100F8F8
      F800FFFFFF00FFFFFF009696960000000000FFFFFF006699FF009999FF009999
      FF006699FF006699FF00807CFF006666FF006666FF006666FF006666CC003366
      CC003366CC003366CC003333CC00FFFFFF0000000000EAEAEA00EAEAEA00FFFF
      FF00FFFFFF00FFFFFF00996633006600000099333300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CCCC990000000000000000000000000000000000CBCBCB00FFFF
      FF00FFFFFF00FFECCC00F0CAA600FFCC9900FFCC9900F0CAA600FFFFFF00FFFF
      FF00CBCBCB0000000000000000000000000000000000EAEAEA00EAEAEA00FFFF
      FF00FFFFFF00FFFFFF00996633006600000099333300FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CCCC99000000000000000000FFFFFF00CCCCFF006699FF006699
      FF006666FF006666CC003366CC003366CC003366CC003366CC003366CC003366
      CC003366CC003333CC009999CC00FFFFFF000000000000000000EAEAEA00F1F1
      F100FFFFFF00FFFFFF00CCCCCC0066333300B2B2B200FFFFFF00FFFFFF00FFFF
      FF00DDDDDD00000000000000000000000000000000000000000000000000CBCB
      CB00CBCBCB00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CCCCCC00CBCB
      CB00000000000000000000000000000000000000000000000000EAEAEA00F1F1
      F100FFFFFF00FFFFFF00CCCCCC0066333300B2B2B200FFFFFF00FFFFFF00FFFF
      FF00DDDDDD0000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000E3E3E300F1F1F100FFFFFF00FFFFFF00FFFFFF00F8F8F800CCCCCC000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCCCCC00CBCBCB00CBCBCB00CBCBCB00CBCBCB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E3E3E300F1F1F100FFFFFF00FFFFFF00FFFFFF00F8F8F800CCCCCC000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0080018001000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000080018001000000008001FF3FF81FFF3F0000FE1FE007FE1F
      0000FC1FC003FC1F0000F0078001F0070000C0038001C0030000800100008001
      0000000100000001000000000000000000000000000000000000000000000000
      00000000000000000000000080010000000080018003800100008003C0078003
      0000C007E00FC0078001F01FF83FF01F00000000000000000000000000000000
      000000000000}
  end
end
