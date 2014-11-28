object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'OA4'
  ClientHeight = 714
  ClientWidth = 1008
  Color = clBtnFace
  Constraints.MaxHeight = 772
  Constraints.MaxWidth = 1032
  Constraints.MinHeight = 600
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesigned
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 900
    Top = 45
    Width = 16
    Height = 16
    Hint = #1048#1085#1076#1080#1082#1072#1090#1086#1088' '#1075#1086#1090#1086#1074#1085#1086#1089#1090#1080
    AutoSize = True
    Constraints.MaxHeight = 16
    Constraints.MaxWidth = 16
    Constraints.MinHeight = 16
    Constraints.MinWidth = 16
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 0
    Width = 1008
    Height = 44
    Cursor = crHandPoint
    Hint = '|'#1055#1072#1085#1077#1083#1100' '#1082#1085#1086#1087#1086#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    ActionManager = ActionManager1
    Caption = 'ActionToolBar1'
    ColorMap.HighlightColor = clWhite
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = clWhite
    EdgeBorders = [ebBottom]
    EdgeOuter = esLowered
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    Spacing = 0
  end
  object pnlConnectedMode: TPanel
    Left = 0
    Top = 44
    Width = 1008
    Height = 650
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    Visible = False
    object Splitter1: TSplitter
      Left = 665
      Top = 45
      Height = 605
      Align = alRight
      AutoSnap = False
      MinSize = 340
      ExplicitLeft = 668
    end
    object pnlSearch: TPanel
      Left = 0
      Top = 0
      Width = 1008
      Height = 45
      Align = alTop
      BevelEdges = [beBottom]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 0
      OnEnter = pnlSearchEnter
      OnExit = pnlSearchExit
      object Label11: TLabel
        Left = 10
        Top = -1
        Width = 23
        Height = 21
        Caption = '[F3]'
        Constraints.MaxHeight = 21
        Constraints.MinHeight = 21
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object Image_MessageStatus: TImage
        Left = 772
        Top = 2
        Width = 16
        Height = 16
        Cursor = crHandPoint
        Hint = #1059' '#1042#1072#1089' '#1077#1089#1090#1100' '#1085#1077#1087#1088#1086#1095#1080#1090#1072#1085#1085#1099#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103'!'
        Picture.Data = {
          055449636F6E0000010001001010000001000800680500001600000028000000
          1000000020000000010008000000000000000000000000000000000000000000
          000000008360590066666600A1777300A37A7600BB8B8A00C392910040769900
          4D79990073839900998C9900CC999900CE9B9900CF9C9900D09D9900D6A39900
          DBA89900DDAA9900E8B59900EAB79900CF9D9A00DFAF9B00CF9F9C00F2C39C00
          F5C59C00F5C79D00D6A79E00EFC19E00B3999F00C99D9F00C99F9F00CF9F9F00
          FFD3A000DFB5A200D6ACA300CEA6A500D6ACA500FFD8A5002B79A600C1A1A600
          D9B3A6003881A700D0A7A700D6ACA700FFDAA700D1A9A900ECCAAA00DFBEAB00
          CEACAC00FFDFAC00DFBFAD00F2D3AD00E6CAB000F2D6B000DCB9B100DFBFB100
          FFE4B1003D8CB3003F8CB300408CB300BEA6B300BFADB300D9B3B300DFBFB600
          DFBFB700FFEAB7005096B900569CB900B6A5B900BCB3B900DCB9B900DFBFBA00
          FCEBBB00F2E3BD00FFF0BD00F5E9BF00FFF2BF00FFF6C300FFF8C500CBC3C600
          FFF9C600F2E6C700F2E6CA00FFFCCA0080B3CC00FFFFCC00ECD9CE00FFFFCF00
          F2E6D000FFFFD0008FBCD200AEC3D200DBD1D200FFFFD300FCF9D400FCF9D500
          5EB8D900ACD3D900FFFFD900F2E6DD00F5ECDE00FFFFDF00FFFFE000FFFFE200
          70C2E600A4D8E600BFD9E600FFFFE800A2E3EC009BCAF200DFECF200D0EFF200
          DBF0F2008BCEF900DAF9F900FCF9F900000000008BC4FF0091CCFF0093CFFF00
          95D9FF0096E2FF0097ECFF00E2FFFF00E6FFFF00E8FFFF00ECFFFF00EFFFFF00
          F3FFFF00F4FFFF00F9FFFF00FCFFFF00FFFFFF00000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000007373010101017373737373737373737373220A0E0A04010101010101
          7373737373220C141F16110F0B0502000101017373221A132D3730241F171210
          0D0A030173223432154A4D4B40373024180B0A017322484F33235D5C58524D47
          19100A017322505C56273F6A66645E21202B0A017322576551230A4662632A2E
          4C490A01732955351E5B6F4E3C0A263156540A01732C0A447282807E7C7A712F
          36610A01731D0941838383817F7D7B6E1B3E0A0173731D3A6D69595339382506
          080A0A017373732807425F6770767574430A0173737373731D1D6B7978776C3B
          0101737373737373731D1D60685A1C0101737373737373737373733D3D450173
          73737373C3FF0000800F00008001000080000000800000008000000080000000
          80000000800000008000000080000000C0000000E0010000F0030000F8070000
          FE1F0000}
        Visible = False
        OnClick = Action_ViewMessagesExecute
      end
      object Label1: TLabel
        Left = 113
        Top = 21
        Width = 23
        Height = 21
        Caption = '[F4]'
        Constraints.MaxHeight = 21
        Constraints.MinHeight = 21
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object edbxSearchName: TEdit
        Left = 41
        Top = 0
        Width = 145
        Height = 21
        TabOrder = 0
        OnEnter = edbxSearchNameEnter
        OnExit = edbxSearchNameExit
      end
      object btbtnSearch: TBitBtn
        Left = 494
        Top = 0
        Width = 22
        Height = 21
        Cursor = crHandPoint
        Hint = 
          #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1090#1073#1086#1088#1072' '#1089' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1077#1084' '#1091#1089#1090#1072#1085#1086#1074#1083#1077#1085#1085#1099#1093' '#1092#1080#1083#1100#1090#1088 +
          #1086#1074
        Default = True
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF00E00000C000FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          FF0000F00000C000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF0000F00000C000FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF00FF0000F00000C000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00FF0000F00000C0
          00FF00FFFF00FFFF00FFFF00FFFF00FF00E00000E00000E00000E00000E00000
          E00000E00000E00000FF0000FF0000F00000C000FF00FFFF00FFFF00FFFF00FF
          00FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF0000FF
          0000E000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FF00FF0000FF0000E000FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00E00000FF0000E000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FF00E00000FF0000E000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF00E00000FF0000E000FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          FF0000E000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        Layout = blGlyphBottom
        Style = bsNew
        TabOrder = 3
        OnClick = btbtnSearchClick
      end
      object chkbxStartDate: TCheckBox
        Left = 522
        Top = 0
        Width = 28
        Height = 21
        Hint = 
          #1055#1088#1080' '#1074#1082#1083#1102#1095#1077#1085#1085#1086#1084' '#1092#1083#1072#1078#1082#1077' '#1073#1091#1076#1091#1090' '#1086#1090#1086#1073#1088#1072#1085#1099' '#1074#1089#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103' '#1085#1077' '#1086#1082#1086#1085#1095#1080#1074#1096 +
          #1080#1077#1089#1103' '#1085#1072' '#1091#1082#1072#1079#1072#1085#1085#1091#1102' '#1076#1072#1090#1091
        Caption = #1089
        TabOrder = 4
        OnClick = chkbxStartDateClick
      end
      object dtpStartDate: TDateTimePicker
        Left = 552
        Top = 0
        Width = 86
        Height = 21
        Hint = #1059#1082#1072#1078#1080#1090#1077' '#1076#1072#1090#1091' '#1085#1072#1095#1072#1083#1072' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103' '#1076#1083#1103' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1080
        Date = 38742.000000000000000000
        Time = 38742.000000000000000000
        Enabled = False
        TabOrder = 5
      end
      object chkbxStopDate: TCheckBox
        Left = 646
        Top = 0
        Width = 30
        Height = 21
        Hint = 
          #1055#1088#1080' '#1074#1082#1083#1102#1095#1077#1085#1085#1086#1084' '#1092#1083#1072#1078#1082#1077' '#1073#1091#1076#1091#1090' '#1091#1082#1072#1079#1072#1085#1099' '#1074#1089#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103' '#1085#1072#1095#1080#1085#1072#1102#1097#1080#1077#1089#1103 +
          ' '#1085#1077' '#1087#1086#1079#1076#1085#1077#1077' '#1091#1082#1072#1079#1072#1085#1085#1086#1081' '#1076#1072#1090#1099
        Caption = #1087#1086
        TabOrder = 6
        OnClick = chkbxStopDateClick
      end
      object dtpStopDate: TDateTimePicker
        Left = 680
        Top = 0
        Width = 86
        Height = 21
        Hint = #1059#1082#1072#1078#1080#1090#1077' '#1076#1072#1090#1091' '#1086#1082#1086#1085#1095#1072#1085#1080#1103' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103' '#1076#1083#1103' '#1092#1080#1083#1100#1090#1088#1072#1094#1080#1080
        Date = 38742.000000000000000000
        Time = 38742.000000000000000000
        Enabled = False
        TabOrder = 7
      end
      object chkbxTeenagers: TCheckBox
        Left = 283
        Top = 22
        Width = 91
        Height = 21
        Hint = 
          #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1086#1090#1073#1086#1088#1072' '#1090#1086#1083#1100#1082#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081' '#1089' '#1087#1088#1080#1079#1085#1072#1082#1086#1084' "'#1087#1086#1076#1088 +
          #1086#1089#1090#1082#1086#1074#1086#1077'"'
        Caption = #1087#1086#1076#1088#1086#1089#1090#1082#1086#1074#1086#1077
        TabOrder = 10
      end
      object chkbxChildren: TCheckBox
        Left = 216
        Top = 22
        Width = 61
        Height = 21
        Hint = 
          #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1086#1090#1073#1086#1088#1072' '#1090#1086#1083#1100#1082#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081' '#1089' '#1087#1088#1080#1079#1085#1072#1082#1086#1084' "'#1076#1077#1090#1089 +
          #1082#1086#1077'"'
        Caption = #1076#1077#1090#1089#1082#1086#1077
        TabOrder = 9
      end
      object chkbxPremier: TCheckBox
        Left = 141
        Top = 22
        Width = 69
        Height = 21
        Hint = 
          #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1086#1090#1073#1086#1088#1072' '#1090#1086#1083#1100#1082#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081' '#1089' '#1087#1088#1080#1079#1085#1072#1082#1086#1084' "'#1087#1088#1077#1084 +
          #1100#1077#1088#1072'"'
        Caption = #1087#1088#1077#1084#1100#1077#1088#1072
        TabOrder = 8
      end
      object chkbxTour: TCheckBox
        Left = 380
        Top = 22
        Width = 66
        Height = 21
        Hint = 
          #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1086#1090#1073#1086#1088#1072' '#1090#1086#1083#1100#1082#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081' '#1089' '#1087#1088#1080#1079#1085#1072#1082#1086#1084' "'#1075#1072#1089#1090 +
          #1088#1086#1083#1080'"'
        Caption = #1075#1072#1089#1090#1088#1086#1083#1080
        TabOrder = 11
      end
      object chkbxAdultsOnly: TCheckBox
        Left = 452
        Top = 22
        Width = 88
        Height = 21
        Hint = 
          #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1086#1090#1073#1086#1088#1072' '#1090#1086#1083#1100#1082#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081' '#1089' '#1087#1088#1080#1079#1085#1072#1082#1086#1084' "'#1090#1086#1083#1100 +
          #1082#1086' '#1076#1083#1103' '#1074#1079#1088#1086#1089#1083#1099#1093'"'
        Caption = #1076#1083#1103' '#1074#1079#1088#1086#1089#1083#1099#1093
        TabOrder = 12
      end
      object chkbxHideErased: TCheckBox
        Left = 670
        Top = 22
        Width = 118
        Height = 21
        Hint = 
          #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1089#1082#1088#1099#1090#1080#1103' '#1087#1086#1084#1077#1095#1077#1085#1085#1099#1093' '#1085#1072' '#1091#1076#1072#1083#1077#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081'/' +
          #1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081
        Caption = #1089#1082#1088#1099#1090#1100' '#1091#1076#1072#1083#1105#1085#1085#1099#1077
        TabOrder = 14
      end
      object chkbxHideOld: TCheckBox
        Left = 546
        Top = 22
        Width = 118
        Height = 21
        Hint = #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1089#1082#1088#1099#1090#1080#1103' '#1091#1089#1090#1072#1088#1077#1074#1096#1080#1093' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081
        Caption = #1089#1082#1088#1099#1090#1100' '#1091#1089#1090#1072#1088#1077#1074#1096#1080#1077
        TabOrder = 13
      end
      object stPhonesMark: TStaticText
        Left = 5
        Top = 24
        Width = 102
        Height = 16
        Alignment = taCenter
        AutoSize = False
        BorderStyle = sbsSingle
        Caption = #1045#1057#1058#1068' '#1058#1045#1051#1045#1060#1054#1053#1067
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ShowAccelChar = False
        TabOrder = 15
        Transparent = False
        Visible = False
      end
      object edbxSearchAddress: TEdit
        Left = 192
        Top = 0
        Width = 145
        Height = 21
        TabOrder = 1
        OnEnter = edbxSearchAddressEnter
        OnExit = edbxSearchAddressExit
      end
      object edbxSearchOther: TEdit
        Left = 343
        Top = 0
        Width = 145
        Height = 21
        TabOrder = 2
        OnEnter = edbxSearchOtherEnter
        OnExit = edbxSearchOtherExit
      end
    end
    object pnlData: TPanel
      Left = 668
      Top = 45
      Width = 340
      Height = 605
      Align = alRight
      BevelEdges = [beLeft]
      BevelKind = bkTile
      BevelOuter = bvNone
      Constraints.MinWidth = 340
      ParentColor = True
      TabOrder = 2
      object PageControl1: TPageControl
        Left = 0
        Top = 0
        Width = 338
        Height = 605
        ActivePage = tsMsr
        Align = alClient
        Style = tsButtons
        TabOrder = 0
        TabStop = False
        object tsClear: TTabSheet
          Caption = 'tsClear'
          ImageIndex = -1
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object tsOrg: TTabSheet
          Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1094#1080#1103
          ImageIndex = -1
          TabVisible = False
          object Panel2: TPanel
            Left = 0
            Top = 13
            Width = 330
            Height = 582
            Align = alClient
            BevelEdges = []
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object reOrgOtherInfo: TRichEdit
              Left = 0
              Top = 0
              Width = 330
              Height = 582
              Align = alClient
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              PopupMenu = pmRichEdit
              ReadOnly = True
              ScrollBars = ssVertical
              TabOrder = 0
              Zoom = 100
              OnContextPopup = reOrgOtherInfoContextPopup
              OnEnter = reOrgOtherInfoEnter
              OnSelectionChange = reOrgOtherInfoSelectionChange
            end
          end
          object Panel9: TPanel
            Left = 0
            Top = 0
            Width = 330
            Height = 13
            Align = alTop
            AutoSize = True
            BevelEdges = []
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            DesignSize = (
              330
              13)
            object Bevel7: TBevel
              Left = 0
              Top = 7
              Width = 330
              Height = 6
              Anchors = [akLeft, akTop, akRight]
              Shape = bsTopLine
              ExplicitWidth = 333
            end
            object Label5: TLabel
              Left = 5
              Top = 0
              Width = 99
              Height = 13
              Caption = ' '#1055#1072#1085#1077#1083#1100' '#1076#1072#1085#1085#1099#1093' '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
              Layout = tlCenter
            end
            object Label6: TLabel
              Left = 121
              Top = 0
              Width = 204
              Height = 13
              Anchors = [akRight, akBottom]
              Caption = ' <F7> - '#1087#1077#1088#1077#1093#1086#1076' '#1074' '#1087#1072#1085#1077#1083#1100' '#1076#1072#1085#1085#1099#1093' '
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
              Layout = tlCenter
              ExplicitLeft = 124
            end
          end
        end
        object tsMsr: TTabSheet
          Caption = #1052#1077#1088#1086#1087#1088#1080#1103#1090#1080#1077
          ImageIndex = -1
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlMesureGeneralInfo: TPanel
            Left = 0
            Top = 13
            Width = 330
            Height = 335
            Align = alTop
            BevelEdges = []
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            object pnl7: TPanel
              Left = 0
              Top = 0
              Width = 330
              Height = 264
              Align = alTop
              BevelEdges = []
              BevelOuter = bvNone
              ParentColor = True
              TabOrder = 0
              DesignSize = (
                330
                264)
              object lblMsrName: TLabel
                Left = 2
                Top = 34
                Width = 142
                Height = 13
                Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
                Color = clBtnFace
                FocusControl = edbxMsrName
                ParentColor = False
                Transparent = False
                Layout = tlCenter
              end
              object lblMsrType: TLabel
                Left = 2
                Top = 0
                Width = 87
                Height = 13
                Caption = #1058#1080#1087' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
                Color = clBtnFace
                FocusControl = cmbbxMsrType
                ParentColor = False
                Transparent = False
                Layout = tlCenter
              end
              object lblMsrAuthor: TLabel
                Left = 2
                Top = 68
                Width = 100
                Height = 13
                Caption = #1040#1074#1090#1086#1088' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
                Color = clBtnFace
                FocusControl = cmbbxMsrAuthor
                ParentColor = False
                Transparent = False
                Layout = tlCenter
              end
              object lblMsrProducer: TLabel
                Left = 2
                Top = 102
                Width = 117
                Height = 13
                Caption = #1056#1077#1078#1080#1089#1089#1105#1088' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
                Color = clBtnFace
                FocusControl = cmbbxMsrProducer
                ParentColor = False
                Transparent = False
                Layout = tlCenter
              end
              object lblMsrPerformer: TLabel
                Left = 2
                Top = 136
                Width = 135
                Height = 13
                Caption = #1048#1089#1087#1086#1083#1085#1080#1090#1077#1083#1100' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
                Color = clBtnFace
                FocusControl = cmbbxMsrPerformer
                ParentColor = False
                Transparent = False
                Layout = tlCenter
              end
              object lblMsrOrganizer: TLabel
                Left = 2
                Top = 170
                Width = 135
                Height = 13
                Caption = #1054#1088#1075#1072#1085#1080#1079#1072#1090#1086#1088' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
                Color = clBtnFace
                FocusControl = cmbbxMsrOrganizer
                ParentColor = False
                Transparent = False
                Layout = tlCenter
              end
              object Bevel4: TBevel
                Left = 0
                Top = 209
                Width = 230
                Height = 6
                Anchors = [akLeft, akTop, akRight]
                Shape = bsTopLine
                ExplicitWidth = 260
              end
              object edbxMsrOrganizer: TEdit
                Left = 0
                Top = 183
                Width = 230
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 10
                OnEnter = edbxMsrOrganizerEnter
                OnExit = edbxMsrOrganizerExit
              end
              object edbxMsrPerformer: TEdit
                Left = 0
                Top = 149
                Width = 230
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 8
                OnEnter = edbxMsrPerformerEnter
                OnExit = edbxMsrPerformerExit
              end
              object edbxMsrProducer: TEdit
                Left = 0
                Top = 115
                Width = 230
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 6
                OnEnter = edbxMsrProducerEnter
                OnExit = edbxMsrProducerExit
              end
              object edbxMsrAuthor: TEdit
                Left = 0
                Top = 81
                Width = 230
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 4
                OnEnter = edbxMsrAuthorEnter
                OnExit = edbxMsrAuthorExit
              end
              object edbxMsrName: TEdit
                Left = 0
                Top = 47
                Width = 330
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 2
                OnEnter = edbxMsrNameEnter
                OnExit = edbxMsrNameExit
              end
              object edbxMsrType: TEdit
                Left = 0
                Top = 13
                Width = 330
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                ReadOnly = True
                TabOrder = 1
                OnEnter = edbxMsrTypeEnter
                OnExit = edbxMsrTypeExit
              end
              object cmbbxMsrType: TComboBox
                Left = 0
                Top = 13
                Width = 330
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                TabOrder = 0
                OnDropDown = cmbbxMsrTypeDropDown
                OnExit = cmbbxMsrTypeExit
              end
              object gpbxMsrFlags: TGroupBox
                Left = 233
                Top = 76
                Width = 97
                Height = 83
                Anchors = [akTop, akRight]
                Caption = ' '#1055#1086#1084#1077#1090#1082#1080' '
                TabOrder = 12
                object chkbxMsrForAdultsOnly: TCheckBox
                  Left = 3
                  Top = 66
                  Width = 91
                  Height = 13
                  Caption = #1076#1083#1103' '#1074#1079#1088#1086#1089#1083#1099#1093
                  TabOrder = 4
                  OnClick = chkbxMsrForAdultsOnlyClick
                end
                object chkbxMsrIsTour: TCheckBox
                  Left = 3
                  Top = 27
                  Width = 68
                  Height = 13
                  Caption = #1075#1072#1089#1090#1088#1086#1083#1080
                  TabOrder = 1
                end
                object chkbxMsrIsPremier: TCheckBox
                  Left = 3
                  Top = 14
                  Width = 68
                  Height = 13
                  Caption = #1087#1088#1077#1084#1100#1077#1088#1072
                  TabOrder = 0
                end
                object chkbxMsrForChildren: TCheckBox
                  Left = 3
                  Top = 40
                  Width = 91
                  Height = 13
                  Caption = #1076#1077#1090#1089#1082#1086#1077
                  TabOrder = 2
                end
                object chkbxMsrForTeenagers: TCheckBox
                  Left = 3
                  Top = 53
                  Width = 91
                  Height = 13
                  Caption = #1087#1086#1076#1088#1086#1089#1090#1082#1086#1074#1086#1077
                  TabOrder = 3
                end
              end
              object pnlMsrDateTime: TPanel
                Left = 0
                Top = 215
                Width = 233
                Height = 49
                BevelEdges = []
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 11
                object dtpMsrStopDate: TDateTimePicker
                  Left = 76
                  Top = 27
                  Width = 83
                  Height = 22
                  Constraints.MaxHeight = 22
                  Constraints.MinHeight = 22
                  Date = 39083.000000000000000000
                  Time = 39083.000000000000000000
                  Enabled = False
                  TabOrder = 4
                  OnChange = dtpMsrStartDateChange
                end
                object chkbxMsrStop: TCheckBox
                  Left = 0
                  Top = 27
                  Width = 73
                  Height = 22
                  Caption = #1086#1082#1086#1085#1095#1072#1085#1080#1077
                  Constraints.MaxHeight = 22
                  Constraints.MinHeight = 22
                  TabOrder = 3
                  OnClick = chkbxMsrStopClick
                end
                object dtpMsrStartDate: TDateTimePicker
                  Left = 76
                  Top = 0
                  Width = 83
                  Height = 22
                  Date = 39083.000000000000000000
                  Time = 39083.000000000000000000
                  Enabled = False
                  TabOrder = 1
                  OnChange = dtpMsrStartDateChange
                end
                object chkbxMsrStart: TCheckBox
                  Left = 0
                  Top = 0
                  Width = 73
                  Height = 22
                  Caption = #1085#1072#1095#1072#1083#1086
                  Constraints.MaxHeight = 22
                  Constraints.MinHeight = 22
                  TabOrder = 0
                  OnClick = chkbxMsrStartClick
                end
                object dtpMsrStartTime: TDateTimePicker
                  Left = 162
                  Top = 0
                  Width = 68
                  Height = 22
                  Date = 38718.000000000000000000
                  Time = 38718.000000000000000000
                  Enabled = False
                  Kind = dtkTime
                  ParentShowHint = False
                  ShowHint = False
                  TabOrder = 2
                  OnChange = dtpMsrStartDateChange
                end
                object dtpMsrStopTime: TDateTimePicker
                  Left = 162
                  Top = 27
                  Width = 68
                  Height = 22
                  Constraints.MaxHeight = 22
                  Constraints.MinHeight = 22
                  Date = 38718.000000000000000000
                  Time = 38718.000000000000000000
                  Enabled = False
                  Kind = dtkTime
                  TabOrder = 5
                  OnChange = dtpMsrStartDateChange
                end
              end
              object cmbbxMsrAuthor: TComboBox
                Left = 0
                Top = 81
                Width = 230
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                TabOrder = 3
                OnDropDown = cmbbxMsrAuthorDropDown
                OnExit = cmbbxMsrAuthorExit
              end
              object cmbbxMsrProducer: TComboBox
                Left = 0
                Top = 115
                Width = 230
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                TabOrder = 5
                OnDropDown = cmbbxMsrProducerDropDown
                OnExit = cmbbxMsrProducerExit
              end
              object cmbbxMsrPerformer: TComboBox
                Left = 0
                Top = 149
                Width = 230
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                TabOrder = 7
                OnDropDown = cmbbxMsrPerformerDropDown
                OnExit = cmbbxMsrPerformerExit
              end
              object cmbbxMsrOrganizer: TComboBox
                Left = 0
                Top = 183
                Width = 230
                Height = 21
                Anchors = [akLeft, akTop, akRight]
                TabOrder = 9
                OnDropDown = cmbbxMsrOrganizerDropDown
                OnExit = cmbbxMsrOrganizerExit
              end
              object gpbxMsrDuration: TGroupBox
                Left = 233
                Top = 157
                Width = 97
                Height = 107
                Anchors = [akTop, akRight]
                Caption = ' '#1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100' '
                TabOrder = 13
                DesignSize = (
                  97
                  107)
                object Bevel1: TBevel
                  Left = 1
                  Top = 81
                  Width = 93
                  Height = 6
                  Anchors = [akLeft, akTop, akRight]
                  Shape = bsTopLine
                end
                object lblMsrDurationMinutes: TLabel
                  Left = 53
                  Top = 58
                  Width = 30
                  Height = 23
                  Caption = #1084#1080#1085#1091#1090
                  Color = clBtnFace
                  Constraints.MaxHeight = 23
                  Constraints.MinHeight = 23
                  ParentColor = False
                  Layout = tlCenter
                end
                object lblMsrDurationHours: TLabel
                  Left = 53
                  Top = 36
                  Width = 29
                  Height = 23
                  Caption = #1095#1072#1089#1086#1074
                  Color = clBtnFace
                  Constraints.MaxHeight = 23
                  Constraints.MinHeight = 23
                  ParentColor = False
                  Layout = tlCenter
                end
                object lblMsrDurationDays: TLabel
                  Left = 53
                  Top = 14
                  Width = 29
                  Height = 23
                  Caption = #1089#1091#1090#1086#1082
                  Color = clBtnFace
                  Constraints.MaxHeight = 23
                  Constraints.MinHeight = 23
                  ParentColor = False
                  Layout = tlCenter
                end
                object spedMsrDurationMinutes: TSpinEdit
                  Left = 3
                  Top = 58
                  Width = 44
                  Height = 22
                  AutoSize = False
                  Enabled = False
                  MaxValue = 59
                  MinValue = 0
                  TabOrder = 2
                  Value = 0
                  OnChange = spedMsrDurationDaysChange
                end
                object spedMsrDurationHours: TSpinEdit
                  Left = 3
                  Top = 36
                  Width = 44
                  Height = 22
                  AutoSize = False
                  Enabled = False
                  MaxValue = 23
                  MinValue = 0
                  TabOrder = 1
                  Value = 0
                  OnChange = spedMsrDurationDaysChange
                end
                object spedMsrDurationDays: TSpinEdit
                  Left = 3
                  Top = 14
                  Width = 44
                  Height = 22
                  AutoSize = False
                  Enabled = False
                  MaxValue = 0
                  MinValue = 0
                  TabOrder = 0
                  Value = 0
                  OnChange = spedMsrDurationDaysChange
                end
                object chkbxMsrUnknownDuration: TCheckBox
                  Left = 6
                  Top = 83
                  Width = 86
                  Height = 22
                  Caption = #1085#1077#1080#1079#1074#1077#1089#1090#1085#1072#1103
                  TabOrder = 3
                  OnClick = chkbxMsrUnknownDurationClick
                end
              end
            end
            object Panel7: TPanel
              Left = 0
              Top = 264
              Width = 330
              Height = 71
              Align = alTop
              BevelEdges = []
              BevelOuter = bvNone
              ParentColor = True
              TabOrder = 1
              object Panel8: TPanel
                Left = 0
                Top = 0
                Width = 330
                Height = 13
                Align = alTop
                AutoSize = True
                BevelEdges = []
                BevelOuter = bvNone
                ParentColor = True
                TabOrder = 0
                DesignSize = (
                  330
                  13)
                object Bevel2: TBevel
                  Left = 0
                  Top = 7
                  Width = 330
                  Height = 6
                  Anchors = [akLeft, akTop, akRight]
                  Shape = bsTopLine
                  ExplicitWidth = 490
                end
                object lblMsrTicketPrice: TLabel
                  Left = 8
                  Top = 0
                  Width = 60
                  Height = 13
                  Caption = ' '#1057#1090#1086#1080#1084#1086#1089#1090#1100' '
                  Transparent = False
                  Layout = tlCenter
                end
              end
              object meMsrTicketPrice: TMemo
                Left = 0
                Top = 13
                Width = 330
                Height = 58
                Align = alClient
                ScrollBars = ssVertical
                TabOrder = 1
                OnExit = meMsrTicketPriceExit
              end
            end
          end
          object Panel5: TPanel
            Left = 0
            Top = 348
            Width = 330
            Height = 198
            Align = alClient
            BevelEdges = []
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            object Panel10: TPanel
              Left = 0
              Top = 0
              Width = 330
              Height = 13
              Align = alTop
              AutoSize = True
              BevelEdges = []
              BevelOuter = bvNone
              ParentColor = True
              TabOrder = 0
              DesignSize = (
                330
                13)
              object Bevel8: TBevel
                Left = 0
                Top = 7
                Width = 330
                Height = 6
                Anchors = [akLeft, akTop, akRight]
                Shape = bsTopLine
                ExplicitWidth = 490
              end
              object Label7: TLabel
                Left = 5
                Top = 0
                Width = 124
                Height = 13
                Caption = ' '#1055#1088#1086#1095#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103' '
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = False
                Layout = tlCenter
              end
              object Label8: TLabel
                Left = 154
                Top = 0
                Width = 171
                Height = 13
                Anchors = [akRight, akBottom]
                Caption = ' <Ctrl+1> - '#1088#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1086#1082#1085#1086' '
                Enabled = False
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = [fsBold]
                ParentFont = False
                Transparent = False
                Layout = tlCenter
                ExplicitLeft = 157
              end
            end
            object reMsrOtherInfo: TRichEdit
              Left = 0
              Top = 13
              Width = 330
              Height = 185
              Align = alClient
              Font.Charset = RUSSIAN_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              PopupMenu = pmRichEdit
              TabOrder = 1
              Zoom = 100
              OnContextPopup = reMsrOtherInfoContextPopup
              OnEnter = reMsrOtherInfoEnter
            end
          end
          object Panel11: TPanel
            Left = 0
            Top = 0
            Width = 330
            Height = 13
            Align = alTop
            AutoSize = True
            BevelEdges = []
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 2
            DesignSize = (
              330
              13)
            object Bevel9: TBevel
              Left = 0
              Top = 7
              Width = 330
              Height = 6
              Anchors = [akLeft, akTop, akRight]
              Shape = bsTopLine
              ExplicitWidth = 333
            end
            object Label9: TLabel
              Left = 5
              Top = 0
              Width = 99
              Height = 13
              Caption = ' '#1055#1072#1085#1077#1083#1100' '#1076#1072#1085#1085#1099#1093' '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
              Layout = tlCenter
            end
            object Label10: TLabel
              Left = 121
              Top = 0
              Width = 204
              Height = 13
              Anchors = [akRight, akBottom]
              Caption = ' <F7> - '#1087#1077#1088#1077#1093#1086#1076' '#1074' '#1087#1072#1085#1077#1083#1100' '#1076#1072#1085#1085#1099#1093' '
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
              Layout = tlCenter
              ExplicitLeft = 124
            end
          end
          object pnlMsrEdit: TPanel
            Left = 0
            Top = 546
            Width = 330
            Height = 49
            Align = alBottom
            BevelEdges = []
            BevelOuter = bvNone
            TabOrder = 3
            object tlbMsrRichEdit: TToolBar
              Left = 0
              Top = 0
              Width = 330
              Height = 22
              Hint = #1069#1090#1086' '#1087#1072#1085#1077#1083#1100' '#1080#1085#1089#1090#1088#1091#1084#1077#1085#1090#1086#1074' '#1088#1077#1076#1072#1082#1090#1086#1088#1072
              AutoSize = True
              DisabledImages = ImageListForRichEditMenu
              HotImages = ImageListForRichEditMenu
              Images = ImageListForRichEditMenu
              TabOrder = 0
              Transparent = False
              Wrapable = False
              object ToolButton19: TToolButton
                Left = 0
                Top = 0
                Action = Action_RichEditBold
                AllowAllUp = True
                Style = tbsCheck
              end
              object ToolButton20: TToolButton
                Left = 23
                Top = 0
                Action = Action_RichEditItalic
                AllowAllUp = True
                Style = tbsCheck
              end
              object ToolButton21: TToolButton
                Left = 46
                Top = 0
                Action = Action_RichEditUnderline
                AllowAllUp = True
                Style = tbsCheck
              end
              object ToolButton22: TToolButton
                Left = 69
                Top = 0
                Width = 8
                Caption = 'ToolButton9'
                ImageIndex = 8
                Style = tbsSeparator
              end
              object ToolButton23: TToolButton
                Left = 77
                Top = 0
                Action = Action_RichEditLeftAlign
                Grouped = True
                Style = tbsCheck
              end
              object ToolButton24: TToolButton
                Left = 100
                Top = 0
                Action = Action_RichEditCenterAlign
                Grouped = True
                Style = tbsCheck
              end
              object ToolButton25: TToolButton
                Left = 123
                Top = 0
                Action = Action_RichEditRightAlign
                Grouped = True
                Style = tbsCheck
              end
              object ToolButton26: TToolButton
                Left = 146
                Top = 0
                Width = 8
                Caption = 'ToolButton10'
                ImageIndex = 8
                Style = tbsSeparator
              end
              object ToolButton27: TToolButton
                Left = 154
                Top = 0
                Action = Action_RichEditBullets
                AutoSize = True
                Style = tbsCheck
              end
              object ToolButton28: TToolButton
                Left = 177
                Top = 0
                Width = 8
                Caption = 'ToolButton11'
                ImageIndex = 8
                Style = tbsSeparator
                Visible = False
              end
              object ToolButton29: TToolButton
                Left = 185
                Top = 0
                Action = Action_RichEditSetTextColor
                DropdownMenu = pmChangeTextColor
                Style = tbsDropDown
              end
              object ToolButton30: TToolButton
                Left = 223
                Top = 0
                Width = 8
                Caption = 'ToolButton12'
                ImageIndex = 8
                Style = tbsSeparator
              end
              object ToolButton31: TToolButton
                Left = 231
                Top = 0
                Action = Action_RichEditEnlargeFont
              end
              object ToolButton32: TToolButton
                Left = 254
                Top = 0
                Action = Action_RichEditDecreaseFont
              end
              object ToolButton33: TToolButton
                Left = 277
                Top = 0
                Width = 8
                Caption = 'ToolButton15'
                ImageIndex = 10
                Style = tbsSeparator
              end
              object ToolButton34: TToolButton
                Left = 285
                Top = 0
                Action = Action_RichEditFormatBySample
                Style = tbsCheck
              end
              object ToolButton35: TToolButton
                Left = 308
                Top = 0
                Width = 8
                Caption = 'ToolButton18'
                ImageIndex = 12
                Style = tbsSeparator
              end
              object ToolButton36: TToolButton
                Left = 316
                Top = 0
                Action = Action_RichEditDefaultFormat
              end
            end
            object btnSave: TButton
              Left = 2
              Top = 24
              Width = 71
              Height = 25
              Cursor = crHandPoint
              Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1074' '#1041#1044' '#1087#1088#1086#1080#1079#1074#1077#1076#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
              Caption = #1057#1086#1093#1088#1072#1085#1077#1085#1080#1077
              TabOrder = 1
              OnClick = btnSaveClick
            end
            object btnClear: TButton
              Left = 79
              Top = 24
              Width = 71
              Height = 25
              Cursor = crHandPoint
              Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1073#1099#1089#1090#1088#1086#1081' '#1086#1095#1080#1089#1090#1082#1080' '#1074#1089#1077#1093' '#1087#1086#1083#1077#1081' '#1074#1074#1086#1076#1072
              Caption = #1054#1095#1080#1089#1090#1082#1072
              TabOrder = 2
              OnClick = btnClearClick
            end
            object btnClone: TButton
              Left = 233
              Top = 24
              Width = 36
              Height = 25
              Cursor = crHandPoint
              Hint = 
                #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1085#1086#1074#1086#1081' '#1079#1072#1087#1080#1089#1080' '#1085#1072' '#1086#1089#1085#1086#1074#1077' '#1076#1072#1085#1085#1099#1093' '#1090#1077#1082#1091#1097#1077#1081' '#1079#1072#1087#1080#1089 +
                #1080
              Caption = #1050#1083#1086#1085
              TabOrder = 4
              Visible = False
              OnClick = btnCloneClick
            end
            object btnCancel: TButton
              Left = 156
              Top = 24
              Width = 71
              Height = 25
              Cursor = crHandPoint
              Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1087#1088#1086#1080#1079#1074#1077#1076#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
              Caption = #1054#1090#1084#1077#1085#1072
              TabOrder = 3
              OnClick = btnCancelClick
            end
            object btbtnCopyToMsrBuffer: TBitBtn
              Left = 275
              Top = 24
              Width = 25
              Height = 25
              Cursor = crHandPoint
              Hint = 
                #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1099#1077' '#1074' '#1073#1091#1092#1077#1088#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1076#1072#1085#1085#1099#1093' '#1086' '#1084#1077#1088#1086#1087 +
                #1088#1080#1103#1090#1080#1080' '#1074#1086' '#1074#1088#1077#1084#1077#1085#1085#1086#1084' '#1073#1091#1092#1077#1088#1077
              Glyph.Data = {
                96010000424D9601000000000000960000002800000010000000100000000100
                08000000000000010000120B0000120B0000180000001800000000000000FFFF
                FF00FF00FF0099333300CC6666006633330099666600CC999900A4A0A0009966
                3300CC996600FFCC9900F0CAA600FFECCC0099996600F1F1F100EAEAEA00DDDD
                DD00D7D7D700CCCCCC00C0C0C0009696960086868600FFFFFF00020202020206
                050505050505050505020202020202060F100D0D0D0D0D0D0502020202020206
                100D0D0D0C0C0C0C05020202020202060D0B0B0B0B0B0B0C0502020605050506
                0F0C0C0C0C0C0D120302020611120C060F0D0D0C0C0C0D12090202060D0D0D06
                010B0B0B0B0B0B11060202060D0B0B06010D0D0D0D0D0D11060202060F0C0C06
                0101010F0F111308060202060F0D0D060101010101070E0606020206010B0B06
                0101010101060A0602020206010D0C06070707070706040202020206010F0F13
                1314071506020202020202060101010101070716060202020202020601010101
                01060A0602020202020202061414141414060A02020202020202}
              Layout = blGlyphBottom
              PopupMenu = pmUseMultibufferrMenu
              Style = bsNew
              TabOrder = 6
              OnClick = btbtnCopyToMsrBufferClick
            end
            object btbtnPasteFromMsrBuffer: TBitBtn
              Left = 306
              Top = 24
              Width = 24
              Height = 25
              Cursor = crHandPoint
              Hint = 
                #1042#1089#1090#1072#1074#1080#1090#1100' '#1076#1072#1085#1085#1099#1099#1077' '#1080#1079' '#1073#1091#1092#1077#1088#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1089#1090#1072#1074#1082#1080' '#1080#1079' '#1074#1088#1077#1084#1077#1085#1085#1086#1075#1086' '#1073#1091#1092 +
                #1077#1088#1072' '#1088#1072#1085#1077#1077' '#1089#1086#1093#1088#1072#1085#1105#1085#1085#1099#1093' '#1076#1072#1085#1085#1099#1093' '#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1080
              Glyph.Data = {
                06030000424D0603000000000000060100002800000020000000100000000100
                08000000000000020000120B0000120B0000340000003400000000000000FFFF
                FF00FF00FF0099666600CC999900A4A0A000CC996600F0CAA600FFECCC003399
                990066FFFF0066CCCC0099FFFF006699990099CCCC00CCFFFF00D6E7E70090A9
                AD000099CC00F0FBFF003399CC0066CCFF006699CC0099CCFF00C6D6EF00F5F5
                F500F1F1F100EAEAEA00E7E7E700E3E3E300E0E0E000DDDDDD00D9D9D900D7D7
                D700D3D3D300CDCDCD00CCCCCC00C2C2C200C0C0C000B6B6B600B2B2B200A8A8
                A800999999009898980096969600949494008F8F8F008C8C8C00868686007C7C
                7C0075757500FFFFFF0002020214140303030303030303030302020202313131
                3131313131313131310202021215152808080808080808080302020232292929
                202020202020202031020212170A0A2808080707070707080302023227292929
                2020252525252520310202141715152808080707070707080302023125292929
                202025252525252031020214170C0A281B0807070707071F0302023125252929
                1E2025252525252231020214170C0C281A0808080808081D0302023125252529
                1C2020202020202231020214180C0C281A0807070707081B0302023123252529
                1C2025252525201E31020214180F0C28011A08080808081F0302023123202529
                191C20202020202231020214180F0F28010101011A1B26040302023123202029
                191919191C1E27293102021418130F28010101010124060602020231221C2029
                1919191919252F2F02020214101313281A0101010107060D02020231221C1929
                1C19191919252E31020202141001132824242424242611140202023123191C29
                2525252525272E3102020214100124282828111126100B140202023122192529
                29292B2E27222F31020202140F21052828282828051015140202023120232B29
                292929292B232931020202020B262C2421212128300E1402020202022E272F25
                232323293129310202020202021609052828282A0914020202020202022E322D
                2929292E323102020202}
              Layout = blGlyphBottom
              NumGlyphs = 2
              PopupMenu = pmUseMultibufferrMenu
              Style = bsNew
              TabOrder = 7
              OnClick = btbtnPasteFromMsrBufferClick
            end
            object btbtnAddMassMsr: TBitBtn
              Left = 244
              Top = 24
              Width = 25
              Height = 25
              Cursor = crHandPoint
              Hint = 
                #1052#1072#1089#1089#1086#1074#1086#1077' '#1088#1072#1079#1084#1085#1086#1078#1077#1085#1080#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1076#1080#1072#1083#1086#1075#1086#1074#1086#1075 +
                #1086' '#1086#1082#1085#1072' '#1084#1072#1089#1089#1086#1074#1086#1075#1086' '#1088#1072#1079#1084#1085#1086#1078#1077#1085#1080#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
              Glyph.Data = {
                6A010000424D6A010000000000006A0000002800000010000000100000000100
                08000000000000010000120B0000120B00000D0000000D00000000000000FFFF
                FF00FF00FF0000800000006600000033000033CC33003399330000CC33000099
                330033CC660033CC9900FFFFFF00020202020404040402020202020202020202
                0202030909030202020202020202020202020309080304040202020202020202
                02020307060309030202020202020404040403060A030404040402020202030A
                0A0A0A0A0A070909090302020202030A0A0A0A0A0A0A06080903050502020309
                0909090A0A0909090903090302020202030A030B0A0307070709090305050202
                0308030B0B030A0909090903030302020202030B0B030A030707070909030202
                0202030A0A030B030A090909090302020202020207060B030A03020202020202
                02020202030A0A030B0302020202020202020202020207060B03020202020202
                020202020202030A0A0302020202}
              Layout = blGlyphBottom
              Style = bsNew
              TabOrder = 5
              OnClick = btbtnAddMassMsrClick
            end
          end
        end
      end
    end
    object pnlSearchResults: TPanel
      Left = 0
      Top = 45
      Width = 665
      Height = 605
      Align = alClient
      BevelEdges = [beRight]
      BevelOuter = bvNone
      Constraints.MinWidth = 370
      TabOrder = 1
      object pnlSearchResultsCreationModification: TPanel
        Left = 0
        Top = 0
        Width = 665
        Height = 592
        Align = alClient
        AutoSize = True
        BevelEdges = []
        BevelOuter = bvNone
        Constraints.MinWidth = 100
        ParentColor = True
        TabOrder = 0
        OnResize = pnlSearchResultsCreationModificationResize
        object Splitter2: TSplitter
          Left = 0
          Top = 256
          Width = 665
          Height = 3
          Cursor = crVSplit
          Align = alTop
          ExplicitTop = 0
          ExplicitWidth = 345
        end
        object pnlCreationModification: TPanel
          Left = 0
          Top = 565
          Width = 665
          Height = 27
          Hint = 
            #1055#1072#1085#1077#1083#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086' '#1076#1072#1090#1077' '#1080' '#1074#1088#1077#1084#1077#1085#1080' '#1089#1086#1079#1076#1072#1085#1080#1103'/'#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1079#1072#1087#1080#1089#1080' '#1041#1044' ' +
            #1080' '#1086' '#1086#1087#1077#1088#1072#1090#1086#1088#1077', '#1074#1099#1087#1086#1083#1085#1080#1074#1096#1077#1084' '#1076#1072#1085#1085#1099#1077' '#1076#1077#1081#1089#1090#1074#1080#1103
          Align = alBottom
          BevelEdges = []
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 2
          object lblCreation: TLabel
            Left = 111
            Top = 0
            Width = 5
            Height = 13
            Caption = '?'
            Enabled = False
            Transparent = True
            Visible = False
          end
          object lblModification: TLabel
            Left = 157
            Top = 14
            Width = 5
            Height = 13
            Caption = '?'
            Enabled = False
            Transparent = True
            Visible = False
          end
          object lblCreationCaption: TLabel
            Left = 2
            Top = 0
            Width = 103
            Height = 13
            Caption = #1050#1090#1086' '#1080' '#1082#1086#1075#1076#1072' '#1089#1086#1079#1076#1072#1083':'
            Transparent = True
            Visible = False
          end
          object lblModificationCaption: TLabel
            Left = 2
            Top = 14
            Width = 149
            Height = 13
            Caption = #1050#1090#1086' '#1080' '#1082#1086#1075#1076#1072' '#1084#1086#1076#1080#1092#1080#1094#1080#1088#1086#1074#1072#1083':'
            Transparent = True
            Visible = False
          end
        end
        object pnlOrgLV: TPanel
          Left = 0
          Top = 0
          Width = 665
          Height = 256
          Align = alTop
          BevelEdges = []
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 0
          object lvOrg: TListView
            Left = 0
            Top = 13
            Width = 665
            Height = 243
            Hint = 
              #1044#1083#1103' '#1085#1072#1074#1080#1075#1072#1094#1080#1080' '#1087#1086' '#1089#1087#1080#1089#1082#1091' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '#1080#1089#1087#1086#1083#1100#1079#1091#1081#1090#1077' '#1082#1083#1072#1074#1080#1096#1080' '#1082#1091#1088#1089#1086#1088#1072' ' +
              #1042#1042#1045#1056#1061', '#1042#1053#1048#1047
            Align = alClient
            Columns = <
              item
                AutoSize = True
                Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
              end
              item
                AutoSize = True
                Caption = #1040#1076#1088#1077#1089' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080
              end
              item
                Alignment = taCenter
                Caption = #1052#1077#1088'-'#1103
                Width = 45
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = lvOrgColumnClick
            OnCustomDrawSubItem = lvOrgCustomDrawSubItem
            OnEnter = lvOrgEnter
            OnKeyDown = lvOrgKeyDown
            OnKeyUp = lvOrgKeyUp
            OnResize = lvOrgResize
            OnSelectItem = lvOrgSelectItem
          end
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 665
            Height = 13
            Align = alTop
            AutoSize = True
            BevelEdges = []
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            DesignSize = (
              665
              13)
            object Bevel6: TBevel
              Left = 0
              Top = 7
              Width = 665
              Height = 6
              Anchors = [akLeft, akRight, akBottom]
              Shape = bsTopLine
              ExplicitWidth = 670
            end
            object lblOrgListCaption: TLabel
              Left = 5
              Top = 0
              Width = 142
              Height = 13
              Anchors = [akLeft, akBottom]
              Caption = ' '#1057#1087#1080#1089#1086#1082' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' (0) '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
              Layout = tlCenter
            end
            object Label4: TLabel
              Left = 432
              Top = 0
              Width = 227
              Height = 13
              Anchors = [akRight, akBottom]
              Caption = ' <F5> - '#1087#1077#1088#1077#1093#1086#1076' '#1082' '#1089#1087#1080#1089#1082#1091' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081' '
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
              Layout = tlCenter
              ExplicitLeft = 437
            end
          end
        end
        object pnlMsrLV: TPanel
          Left = 0
          Top = 259
          Width = 665
          Height = 306
          Align = alClient
          AutoSize = True
          BevelEdges = []
          BevelOuter = bvNone
          ParentColor = True
          TabOrder = 1
          object lvMsr: TListView
            Left = 0
            Top = 13
            Width = 665
            Height = 293
            Hint = 
              #1044#1083#1103' '#1085#1072#1074#1080#1075#1072#1094#1080#1080' '#1087#1086' '#1089#1087#1080#1089#1082#1091' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081' '#1080#1089#1087#1086#1083#1100#1079#1091#1081#1090#1077' '#1082#1083#1072#1074#1080#1096#1080' '#1082#1091#1088#1089#1086#1088#1072' ' +
              #1042#1042#1045#1056#1061', '#1042#1053#1048#1047
            Align = alClient
            Columns = <
              item
                Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
                Width = 469
              end
              item
                Caption = #1053#1072#1095#1072#1083#1086
                Width = 100
              end
              item
                Caption = #1054#1082#1086#1085#1095#1072#1085#1080#1077
                Width = 100
              end>
            HideSelection = False
            ReadOnly = True
            RowSelect = True
            TabOrder = 0
            ViewStyle = vsReport
            OnColumnClick = lvMsrColumnClick
            OnCustomDrawItem = lvMsrCustomDrawItem
            OnEnter = lvMsrEnter
            OnKeyDown = lvMsrKeyDown
            OnSelectItem = lvMsrSelectItem
          end
          object Panel1: TPanel
            Left = 0
            Top = 0
            Width = 665
            Height = 13
            Align = alTop
            AutoSize = True
            BevelEdges = []
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            DesignSize = (
              665
              13)
            object Bevel5: TBevel
              Left = 0
              Top = 7
              Width = 665
              Height = 6
              Anchors = [akLeft, akRight, akBottom]
              Shape = bsTopLine
              ExplicitWidth = 670
            end
            object lblMsrListCaption: TLabel
              Left = 5
              Top = 0
              Width = 144
              Height = 13
              Anchors = [akLeft, akBottom]
              Caption = ' '#1057#1087#1080#1089#1086#1082' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081' (0) '
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
              Layout = tlCenter
            end
            object Label2: TLabel
              Left = 430
              Top = 0
              Width = 229
              Height = 13
              Anchors = [akRight, akBottom]
              Caption = ' <F6> - '#1087#1077#1088#1077#1093#1086#1076' '#1082' '#1089#1087#1080#1089#1082#1091' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081' '
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              Transparent = False
              Layout = tlCenter
              ExplicitLeft = 435
            end
          end
          object reMsr: TRichEdit
            Left = 0
            Top = 13
            Width = 665
            Height = 293
            Align = alClient
            Font.Charset = RUSSIAN_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 2
            Visible = False
            Zoom = 100
          end
        end
      end
      object pnlID: TPanel
        Left = 0
        Top = 592
        Width = 665
        Height = 13
        Hint = #1055#1072#1085#1077#1083#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086#1073' '#1080#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088#1077' '#1079#1072#1087#1080#1089#1080' '#1041#1044
        Align = alBottom
        BevelEdges = []
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        Visible = False
        object lblIDCaption: TLabel
          Left = 2
          Top = 0
          Width = 123
          Height = 13
          Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1079#1072#1087#1080#1089#1080':'
          Transparent = True
          Layout = tlCenter
          Visible = False
        end
        object lblID: TLabel
          Left = 131
          Top = 0
          Width = 5
          Height = 13
          Caption = '?'
          Enabled = False
          Transparent = True
          Visible = False
        end
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 694
    Width = 1008
    Height = 20
    Hint = #1055#1072#1085#1077#1083#1100' '#1089#1090#1072#1090#1091#1089#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    Panels = <
      item
        Alignment = taCenter
        Width = 20
      end
      item
        Alignment = taCenter
        Width = 100
      end
      item
        Alignment = taCenter
        Width = 0
      end
      item
        Width = 50
      end>
  end
  object ProgressBar1: TProgressBar
    Left = 799
    Top = 65
    Width = 98
    Height = 18
    Hint = #1048#1085#1076#1080#1082#1072#1090#1086#1088' '#1087#1088#1086#1075#1088#1077#1089#1089#1072' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1086#1087#1077#1088#1072#1094#1080#1081
    Constraints.MaxHeight = 18
    Constraints.MaxWidth = 98
    Constraints.MinHeight = 18
    Constraints.MinWidth = 98
    Step = 1
    TabOrder = 3
  end
  object MainMenu1: TMainMenu
    Images = ImageList2
    Left = 40
    Top = 575
    object miFile: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object N20: TMenuItem
        Action = Action_DB_Connection
      end
      object N21: TMenuItem
        Action = Action_DB_Disconnection
      end
      object N19: TMenuItem
        Caption = '-'
      end
      object N1: TMenuItem
        Action = Action_Configuration
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object miQuit: TMenuItem
        Action = Action_Quit
      end
    end
    object miActions: TMenuItem
      Caption = '&'#1044#1077#1081#1089#1090#1074#1080#1103
      object N10: TMenuItem
        Action = Action_DB_Backup
      end
      object N11: TMenuItem
        Action = Action_DB_Cleaning
      end
      object N12: TMenuItem
        Action = Action_DB_Defragmentation
      end
      object N9: TMenuItem
        Action = Action_DB_Maintenance
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object N14: TMenuItem
        Action = Action_DB_AddMeasure
      end
      object N17: TMenuItem
        Action = Action_DB_DeleteNode
      end
      object N16: TMenuItem
        Action = Action_DB_RecoverNode
      end
      object N18: TMenuItem
        Action = Action_DB_RefreshList
      end
      object N22: TMenuItem
        Caption = '-'
      end
      object N24: TMenuItem
        Action = Action_PostMessage
      end
      object N23: TMenuItem
        Action = Action_ViewMessages
      end
      object miOpenOtherPanel: TMenuItem
        Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1086#1082#1085#1086' '#1087#1088#1086#1095#1077#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
        ShortCut = 16433
        Visible = False
        OnClick = miOpenOtherPanelClick
      end
      object miGoToSearchString: TMenuItem
        Caption = #1055#1077#1088#1077#1093#1086#1076' '#1082' '#1089#1090#1088#1086#1082#1077' '#1087#1086#1080#1089#1082#1072
        ShortCut = 114
        Visible = False
        OnClick = miGoToSearchStringClick
      end
      object miGoToCheckboxesInSearchString: TMenuItem
        Caption = #1055#1077#1088#1077#1093#1086#1076' '#1082' '#1089#1090#1088#1086#1082#1077' '#1092#1083#1072#1075#1086#1074' '#1089#1090#1088#1086#1082#1080' '#1087#1086#1080#1089#1082#1072
        ShortCut = 115
        Visible = False
        OnClick = miGoToCheckboxesInSearchStringClick
      end
      object miGoToOrgPanel: TMenuItem
        Caption = #1055#1077#1088#1077#1093#1086#1076' '#1082' '#1087#1072#1085#1077#1083#1080' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
        ShortCut = 116
        Visible = False
        OnClick = miGoToOrgPanelClick
      end
      object miGoToMsrPanel: TMenuItem
        Caption = #1055#1077#1088#1077#1093#1086#1076' '#1082' '#1087#1072#1085#1077#1083#1080' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081
        ShortCut = 117
        Visible = False
        OnClick = miGoToMsrPanelClick
      end
      object miGoToDataPanel: TMenuItem
        Caption = #1055#1077#1088#1077#1093#1086#1076' '#1082' '#1087#1072#1085#1077#1083#1080' '#1076#1072#1085#1085#1099#1093
        ShortCut = 118
        Visible = False
        OnClick = miGoToDataPanelClick
      end
      object miGoToPhones: TMenuItem
        Caption = #1055#1077#1088#1077#1093#1086#1076' '#1082' '#1089#1087#1080#1089#1082#1091' '#1090#1077#1083#1077#1092#1086#1085#1086#1074
        ShortCut = 120
        Visible = False
      end
    end
    object miView: TMenuItem
      Caption = '&'#1042#1080#1076
      object N3: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1072#1085#1077#1083#1077#1081'...'
        object miToolbar: TMenuItem
          AutoCheck = True
          Caption = #1055#1072#1085#1077#1083#1100' '#1082#1085#1086#1087#1086#1082
          Checked = True
          Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1082#1088#1099#1090#1080#1103'/'#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1087#1072#1085#1077#1083#1080' '#1082#1085#1086#1087#1086#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
          OnClick = miToolbarClick
        end
        object miStatusbar: TMenuItem
          AutoCheck = True
          Caption = #1055#1072#1085#1077#1083#1100' '#1089#1090#1072#1090#1091#1089#1072
          Checked = True
          Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1082#1088#1099#1090#1080#1103'/'#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1087#1072#1085#1077#1083#1080' '#1089#1090#1072#1090#1091#1089#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
          OnClick = miStatusbarClick
        end
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object N6: TMenuItem
        Action = Action_DB_Users
      end
      object N7: TMenuItem
        Action = Action_DB_Statistic
      end
    end
    object miHelp: TMenuItem
      Caption = '&?'
      object miHelpContent: TMenuItem
        Action = Action_HelpContent
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object miAbout: TMenuItem
        Action = Action_About
      end
    end
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items.CaptionOptions = coNone
        Items = <
          item
            Action = Action_Quit
            ImageIndex = 0
            ShortCut = 32883
          end
          item
            Caption = '-'
          end
          item
            Action = Action_DB_Connection
            ImageIndex = 10
          end
          item
            Visible = False
            Action = Action_DB_Disconnection
            ImageIndex = 11
          end
          item
            Caption = '-'
          end
          item
            Action = Action_DB_AddMeasure
            ImageIndex = 13
          end
          item
            Action = Action_DB_DeleteNode
            ImageIndex = 15
            ShortCut = 119
          end
          item
            Action = Action_DB_RecoverNode
            ImageIndex = 14
            ShortCut = 32887
          end
          item
            Action = Action_DB_RefreshList
            ImageIndex = 16
          end
          item
            Caption = '-'
          end
          item
            Action = Action_DB_Backup
            ImageIndex = 8
          end
          item
            Action = Action_DB_Cleaning
            ImageIndex = 7
          end
          item
            Action = Action_DB_Defragmentation
            ImageIndex = 6
          end
          item
            Action = Action_DB_Maintenance
            ImageIndex = 9
          end
          item
            Caption = '-'
          end
          item
            Action = Action_DB_Users
            ImageIndex = 4
          end
          item
            Action = Action_DB_Statistic
            ImageIndex = 5
          end
          item
            Caption = '-'
          end
          item
            Action = Action_PostMessage
            ImageIndex = 18
          end
          item
            Action = Action_ViewMessages
            ImageIndex = 17
          end
          item
            Caption = '-'
          end
          item
            Action = Action_Configuration
            ImageIndex = 3
          end
          item
            Caption = '-'
          end
          item
            Action = Action_HelpContent
            ImageIndex = 2
            ShortCut = 112
          end
          item
            Action = Action_About
            ImageIndex = 1
          end>
        ActionBar = ActionToolBar1
      end>
    Images = ImageList1
    Left = 250
    Top = 575
    StyleName = 'XP Style'
    object Action_DB_Maintenance: TAction
      Category = 'Action'
      Caption = #1054#1073#1089'&'#1083#1091#1078#1080#1074#1072#1085#1080#1077' '#1041#1044'...'
      Hint = 
        #1054#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077' '#1041#1044'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1087#1086#1083#1085#1086#1075#1086' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1103' '#1073 +
        #1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 9
      OnExecute = Action_DB_MaintenanceExecute
    end
    object Action_DB_Connection: TAction
      Category = 'Action'
      Caption = #1055#1086#1076#1082#1083#1102#1095'&'#1077#1085#1080#1077' '#1082' '#1041#1044
      Hint = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077' '#1082' '#1041#1044'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1082' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 10
      OnExecute = Action_DB_ConnectionExecute
    end
    object Action_DB_Disconnection: TAction
      Category = 'Action'
      Caption = #1054#1090#1082#1083'&'#1102#1095#1077#1085#1080#1077' '#1086#1090' '#1041#1044
      Enabled = False
      Hint = #1054#1090#1082#1083#1102#1095#1077#1085#1080#1077' '#1086#1090' '#1041#1044'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1083#1102#1095#1077#1085#1080#1103' '#1086#1090' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 11
      Visible = False
      OnExecute = Action_DB_DisconnectionExecute
    end
    object Action_DB_Backup: TAction
      Category = 'Action'
      Caption = '&'#1056#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1077' '#1041#1044'...'
      Hint = 
        #1056#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1077' '#1041#1044'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1087#1088#1086#1094#1077#1076#1091#1088#1099' '#1088#1077#1079#1077#1088#1074#1080#1088#1086#1074 +
        #1072#1085#1080#1103' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 8
      OnExecute = Action_DB_BackupExecute
    end
    object Action_DB_Cleaning: TAction
      Category = 'Action'
      Caption = '&'#1063#1080#1089#1090#1082#1072' '#1041#1044'...'
      Hint = 
        #1063#1080#1089#1090#1082#1072' '#1041#1044'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1082#1086#1088#1088#1077#1082#1090#1080#1088#1086#1074#1082#1080' '#1080' '#1095#1080#1089#1090#1082#1080' '#1090#1072#1073#1083#1080 +
        #1094' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 7
      OnExecute = Action_DB_CleaningExecute
    end
    object Action_DB_Users: TAction
      Category = 'View'
      Caption = #1059#1095#1105#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080'...'
      Enabled = False
      Hint = 
        #1059#1095#1105#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1089#1087#1080#1089#1082#1072' '#1091#1095#1105#1090#1085#1099#1093' '#1079#1072#1087#1080#1089#1077#1081 +
        ' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 4
      OnExecute = Action_DB_UsersExecute
    end
    object Action_HelpContent: TAction
      Category = '?'
      Caption = '&'#1057#1086#1076#1077#1088#1078#1072#1085#1080#1077'...'
      Hint = 
        #1054#1075#1083#1072#1074#1083#1077#1085#1080#1077' '#1089#1087#1088#1072#1074#1082#1080'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1086#1075#1083#1072#1074#1083#1077#1085#1080#1103' '#1089#1087#1088#1072#1074 +
        #1082#1080
      ImageIndex = 2
      SecondaryShortCuts.Strings = (
        'Ctrl+H')
      ShortCut = 112
      OnExecute = Action_HelpContentExecute
    end
    object Action_Quit: TAction
      Category = 'File'
      Caption = #1042'&'#1099#1093#1086#1076
      Hint = #1042#1099#1093#1086#1076'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 0
      SecondaryShortCuts.Strings = (
        'F10')
      ShortCut = 32883
      OnExecute = Action_QuitExecute
    end
    object Action_About: TAction
      Category = '?'
      Caption = '&'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      Hint = 
        #1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077#1081' '#1086' '#1087#1088#1086#1075 +
        #1088#1072#1084#1084#1077' '#1080' '#1077#1105' '#1072#1074#1090#1086#1088#1077
      ImageIndex = 1
      OnExecute = Action_AboutExecute
    end
    object Action_Configuration: TAction
      Category = 'File'
      Caption = #1050#1086#1085#1092#1080'&'#1075#1091#1088#1072#1094#1080#1103'...'
      Hint = 
        #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080' '#1087#1088#1086#1075#1088#1072 +
        #1084#1084#1099
      ImageIndex = 3
      SecondaryShortCuts.Strings = (
        'Ctrl+O')
      OnExecute = Action_ConfigurationExecute
    end
    object Action_DB_Statistic: TAction
      Category = 'View'
      Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072'...'
      Hint = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1089#1090#1072#1090#1080#1089#1090#1080#1095#1077#1089#1082#1086#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
      ImageIndex = 5
      OnExecute = Action_DB_StatisticExecute
    end
    object Action_DB_Defragmentation: TAction
      Category = 'Action'
      Caption = #1044#1077#1092#1088#1072#1075#1084#1077#1085#1090#1072#1094#1080#1103' '#1041#1044'...'
      Hint = 
        #1044#1077#1092#1088#1072#1075#1084#1077#1085#1090#1072#1094#1080#1103' '#1041#1044'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1086#1074#1077#1076#1077#1085#1080#1103' '#1076#1077#1092#1088#1072#1075#1084#1077#1085#1090#1072#1094#1080#1080' '#1073#1072#1079#1099' ' +
        #1076#1072#1085#1085#1099#1093
      ImageIndex = 6
      OnExecute = Action_DB_DefragmentationExecute
    end
    object Action_DB_AddMeasure: TAction
      Category = 'Action'
      Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' &'#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103'...'
      Hint = 
        #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103 +
        ' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1080' '#1074' '#1073#1072#1079#1091' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 13
      OnExecute = Action_DB_AddMeasureExecute
    end
    object Action_DB_DeleteNode: TAction
      Category = 'Action'
      Caption = #1055#1086#1084#1077#1090#1080#1090#1100' '#1085#1072' &'#1091#1076#1072#1083#1077#1085#1080#1077
      Hint = 
        #1059#1076#1072#1083#1077#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1084#1077#1090#1082#1080' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1085#1072' '#1091#1076 +
        #1072#1083#1077#1085#1080#1077' '#1080#1079' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 15
      SecondaryShortCuts.Strings = (
        'F8')
      ShortCut = 119
      OnExecute = Action_DB_DeleteNodeExecute
    end
    object Action_DB_RefreshList: TAction
      Category = 'Action'
      Caption = #1054'&'#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072
      Hint = 
        #1054#1073#1085#1086#1074#1083#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1086#1090#1086#1073#1088#1072#1078#1072#1077#1084#1086#1075#1086' '#1089#1087#1080#1089#1082#1072' '#1079#1072 +
        #1087#1080#1089#1077#1081' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
      ImageIndex = 16
      OnExecute = Action_DB_RefreshListExecute
    end
    object Action_DB_RecoverNode: TAction
      Category = 'Action'
      Caption = #1057#1085#1103#1090#1100' '#1087#1086#1084#1077#1090#1082#1091' '#1086#1073' '#1091#1076#1072#1083#1077#1085#1080#1080
      Hint = 
        #1042#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103' '#1101#1083#1077#1084#1077#1085#1090#1072' '#1073#1072#1079#1099 +
        ' '#1076#1072#1085#1085#1099#1093', '#1087#1086#1084#1077#1095#1077#1085#1085#1086#1075#1086' '#1085#1072' '#1091#1076#1072#1083#1077#1085#1080#1077
      ImageIndex = 14
      ShortCut = 32887
      OnExecute = Action_DB_RecoverNodeExecute
    end
    object Action_PostMessage: TAction
      Category = 'Action'
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077'...'
      Hint = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      ImageIndex = 18
      OnExecute = Action_PostMessageExecute
    end
    object Action_ViewMessages: TAction
      Category = 'Action'
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088#1077#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1103'...'
      Hint = #1057#1087#1080#1089#1086#1082' '#1089#1086#1086#1073#1097#1077#1085#1080#1081'...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1089#1087#1080#1089#1082#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      ImageIndex = 17
      OnExecute = Action_ViewMessagesExecute
    end
  end
  object ColorDialog1: TColorDialog
    Left = 100
    Top = 575
  end
  object ApplicationEvents1: TApplicationEvents
    OnHint = ApplicationEvents1Hint
    OnMessage = ApplicationEvents1Message
    Left = 280
    Top = 575
  end
  object ImageList1: TImageList
    AllocBy = 22
    Height = 32
    ImageType = itMask
    Width = 32
    Left = 130
    Top = 575
    Bitmap = {
      494C010117002900940020002000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      000000000000360000002800000080000000C000000001002000000000000080
      0100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009484
      7B0094847B009484840094847B008C847B008C847B008C847B008C847B008C84
      7B008C847B008C847B008C847B008C847B008C847B008C847B008C847B008C84
      7B008C847B008C847B0094847B0094847B0094847B0094847B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000005A0000006B00000073000000730000006B0000005A0000004A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C69C8C00C69C
      8C00C69C8C00CE9C8C00C69C8C00C69C8C00C6948C00C6948C00C6948C00C694
      8C00C6948C00C6948C00C6948C00C6948C00C6948C00C6948C00C6948C00C694
      8C00C6948C00C6948C00C6948C00C6948C00DE948C0094847B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000007300000084000000
      8C00000084000000840000008400000084000000840000008400000084000000
      840000006B000000390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300FFD6
      BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6
      BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFCE
      9C00FFCE9C00FFCE9C00FFCE9C00FFCE9400D694840094847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200525252006B6B6B007B7B84007B7B84007B7B84007B7B84007B7B84007B7B
      7B007B7B7B007B7B84007B7B84007B7B84007B7B84007B7B84007B7B84007B7B
      84007B7B84007B7B84007B7B84007B7B84007B7B84007B7B8400525252006B6B
      6B00101010000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000007B000000940000008C00000084000000
      8400000084000000840000008400000084000000840000008400000084000000
      7B00000084000000840000007300000039000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300E7E7
      E700FFE7CE00FFDECE00FFDEC600FFDEC600FFDEC6008C5A5A008C5A5A008C5A
      5A00FFDEBD00C69C8C00A5736B00A5736B00A5736B00A5736B00A5736B00A573
      6300A5736300C6947300FFCE9400FFCE9C00D694840094847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200BDC6C600CEC6C600FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700848C8C00EFF7
      F700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000940000008C0000008C0000008C0000008C000000
      8C0000008C0000009400000094000000940000008C0000008C0000008C000000
      84000000840000007B00000084000000840000004A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300E7E7
      E700FFE7CE00FFE7CE00FFDECE00FFDEC600FFDEC6008C5A5A008C5A5A008C5A
      5A00FFDEBD00EFCEB500E7BDAD00E7BDA500E7BDA500E7BDA500E7B58C00E7B5
      8400E7B58400EFBD8C00FFCE9400FFCE9C00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200B5B5B500C6BDB500FFF7F700F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EF
      EF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EF
      EF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00F7EFEF00FFF7F700848C8C00DEDE
      DE00000000000000000000000000000000000000000000000000000000000000
      00000000000000009C0000008C0000008C0000008C0000009400000094000000
      9C0000009C0000009C0000009C0000009C0000009C0000009400000094000000
      8C0000008C00000084000000840000007B0000008C0000005A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300E7E7
      E700FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDEC6008C5A5A008C5A5A008C5A
      5A00FFDEC600FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFD6AD00FFCE8C00FFCE
      9400FFCE9400FFCE9400FFCE9400FFCEAD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200B5B5B500C6BDB500F7EFEF00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7
      DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7
      DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7EFEF00848C8C00DEDE
      DE00000000000000000000000000000000000000000000000000000000000000
      00000000A500000094000000940000009400000094000000940000009C000000
      A5000000A5000000A5000000A5000000A5000000A50000009C0000009C000000
      940000008C0000008C0000008C000000840000007B0000008C00000052000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300E7E7
      E700FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDEC600FFDE
      C600FFDEC600FFDEC600FFDEC600FFDEBD00FFDEBD00FFCE9C00FFCE8C00FFCE
      8C00FFCE8C00FFCE9400FFD6AD00FFD6BD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200B5B5B500C6ADA500F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7
      DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7
      DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7E7DE00F7EFEF00848C8C00DEDE
      DE00000000000000000000000000000000000000000000000000000000000000
      A500000094000000940000009C0000009C004A4ABD005A5AC60000009C000000
      A5000000AD000000AD000000AD000000AD000000AD000000A5000000A5000000
      9C005A5AC6003939B50000008C0000008C00000084000000840000008C000000
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300E7E7
      E700FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7CE008C5A5A008C5A5A008C5A
      5A00FFDEC600D6AD9C00BD8C8400BD8C8400BD8C8400BD846B00BD846B00BD84
      6B00BD8C7300CEA59400FFD6B500FFD6BD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200BDC6C600C6ADA500F7E7DE00F7DED600F7DED600F7DED600F7DED600F7DE
      D600F7DED600F7DED600F7DED600F7DED600F7DED600F7DED600F7DED600F7DE
      D600F7DED600F7DED600F7DED600F7DED600F7DED600F7E7DE0094949400DEDE
      DE000000000000000000000000000000000000000000000000002121AD000000
      9C0000009C000000A5000000A5002121AD00FFFFFF00FFFFFF004A4ACE000000
      A5000000AD000000AD000000AD000000B5000000AD000000AD000000A5004A4A
      BD00FFFFFF00FFFFFF002121AD0000008C000000940000008C0000008C000000
      8400000008000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300E7EF
      EF00FFE7D600FFE7D600FFE7D600FFE7CE00FFE7CE008C5A5A008C5A5A008C5A
      5A00FFDEC600DEBDAD00D6AD9C00D6AD9C00CEA58400D69C7300D69C7300CEA5
      8400CEA59400DEB5A500FFD6BD00FFD6BD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200BDC6C600C6ADA500F7D6C600F7D6C600F7D6C600F7D6C600F7D6C600F7D6
      C600F7D6C600F7D6C600F7D6C600F7D6C600F7D6C600F7D6C600F7D6C600F7D6
      C600F7D6C600F7D6C600F7D6C600F7D6C600F7D6C600F7DED60094949400DEDE
      DE000000000000000000000000000000000000000000000000000000B5000000
      9C000000A5000000AD003131AD00D6D6BD00FFFFF700FFFFFF00FFFFFF004242
      CE000000AD000000B5000000B5000000B5000000B5000000AD004A4ABD00EFEF
      D600FFFFFF00FFFFFF00FFFFFF003131AD00000094000000940000008C000000
      9400000052000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300EFEF
      EF00FFE7D600FFE7D600FFE7D600FFE7D600FFE7CE008C5A5A008C5A5A008C5A
      5A00FFE7CE00FFDEC600FFDEC600FFDEC600FFCE8C00FFCE8C00FFD6A500FFDE
      BD00FFDEBD00FFDEBD00FFD6BD00FFD6BD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200BDC6C600C69C8C00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6
      AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6
      AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7D6C6009C9C9C00DEDE
      DE0000000000000000000000000000000000000000002929BD000000A5000000
      A5000000AD000000B50073738C00CECEA500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF004A4ACE000000AD000000B5000000B5000000B5004A4ABD00F7F7DE00FFFF
      FF00FFFFFF00FFFFFF00F7F7DE008484AD000000A50000009C00000094000000
      940000008C000000080000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300EFEF
      EF00FFEFD600FFE7D600FFE7D600FFE7D600FFE7D600FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFE7CE00FFDECE00FFCE8C00FFC68400FFD6B500FFDEC600FFDE
      C600FFDEBD00FFDEBD00FFDEBD00FFD6BD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200BDC6C600C69C8C00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6
      AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6
      AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7C6AD00F7CEBD009C9C9C00DEDE
      DE0000000000000000000000000000000000000000000000A5000000A5000000
      AD000000B5000000BD000000B5005A5A6B00C6C6AD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF004242CE000000B5000000B5004A4ACE00F7F7DE00FFFFF700FFFF
      FF00FFFFFF00EFEFCE0073739C000000AD000000AD000000A50000009C000000
      940000009C000000390000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300EFEF
      EF00FFEFDE002900DE002900DE002900DE00FFE7D6009473DE005229DE005229
      DE005229DE005229DE005229DE005A396B0008314A00526B6300CE732900B563
      31008C4A4A005A31AD00EFCEC600FFD6BD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200BDC6C600C69C8C00F7B59C00F7B59C00F7B59C00F7B59C00F7B59C00F7B5
      9C00F7B59C00F7B59C00F7B59C00F7B59C00F7B59C00F7B59C00F7B59C00F7B5
      9C00F7B59C00F7B59C00F7B59C00F7B59C00F7B59C00F7C6AD009CA5A500DEDE
      DE0000000000000000000000000000000000000000000000A5000000AD000000
      B5000000BD000000C6000000CE000000BD0052527300C6C6A500FFFFFF00FFFF
      FF00FFFFFF00FFFFFF003939CE005252DE00FFFFFF00FFFFF700FFFFFF00FFFF
      FF00E7E7CE006B6B94000000B5000000BD000000B5000000AD000000A5000000
      9C0000009C0000006B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300EFEF
      EF00FFEFDE002900DE002900DE002900DE00FFE7D600E7CED600D6BDD600D6B5
      D600D6B5D600D6B5D600D6B5D600D6B5CE004A7B9C00A56B2900FFD6AD00FFCE
      9C00EFA55200D67B1800D6843100EFAD7300D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200BDC6C600C69C8C00F7B59C00F7B59C00F7B59C00F7B59C00F7B59C00F7B5
      9C00F7B59C00F7B59C00F7B59C00F7B59C00F7B59C00FFB59400F7B59C00F7B5
      9C00F7B59C00F7B59C00F7B59C00F7B59C00F7B59C00EFBDAD009CA5A500DEDE
      DE00000000000000000000000000000000006363D6000000AD000000B5000000
      BD000000C6000000CE000000CE000000D6000000BD0063637B00C6C6AD00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EFEF
      CE0073739C000000B5000000C6000000BD000000BD000000B5000000AD000000
      9C0000009C0000008C0010102100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300EFEF
      EF00FFEFDE002900DE002900DE002900DE00FFEFD600FFE7D600FFE7D600FFE7
      D600FFE7D600FFE7CE00FFE7CE00FFE7CE00F7DECE00AD732900EFBD8C00FFEF
      D600FFDEBD00FFCEA500F7B57B00DE842900CE731000AD733900000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200C6CED600CE947B00FFA58400FFA58400FFA58400FFA58400FFA58400FFA5
      8400FFA58400FFA58400FFA58400FFA58400FFA58400FFA58400FFA58400FFA5
      8400FFA58400FFA58400FFA58400FFA58400FFA58400E7A58C00ADADB500DEDE
      DE00000000000000000000000000000000003939CE000808B5000000BD000000
      C6000000CE000000CE000000D6000000CE000000D6000000BD006B6B8400D6D6
      BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7F7DE008484
      AD000000BD000000C6000000C6000000C6000000BD000000BD000000B5000000
      A5000000A50000009C0010102100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300EFEF
      EF00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7
      D600FFE7D600FFE7D600FFE7D600FFE7CE00FFE7CE00FFDEBD00E79C5200DE84
      2900EFAD7300FFE7CE00FFDEC600FFD6A500F7B57B00E7943900BD6B1800BD6B
      1800000000000000000000000000000000000000000000000000000000004242
      4200CECED600D6947B00FFA58400FFA58400FFA58400FFA58400FFA58400FFA5
      8400FFA58400FFA58400FFA58400FFA58400FFA58400FFA58400FFA58400FFA5
      8400FFA58400FFA58400FFA58400FFA58400FFA58400E7A58C00ADADB500DEDE
      DE00000000000000000000000000000000001818C6000808BD000808C6000808
      CE000808CE000808D6000000D6000000D6000000D6000000D6000000C6008484
      AD00FFFFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008C8CD6000000
      C6000000CE000000C6000000C6000000C6000000C6000000BD000000B5000000
      AD000000A5000000AD0010102100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300EFF7
      F700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE008C5A5A008C5A5A008C5A
      5A00FFE7D600C69C9400A5737300A5737300A5737300A5737300AD847B00B573
      4A009C521000C6630800E79C5200F7D6AD00FFDEC600F7CEA500847B7B00ADAD
      B50029299C0029299C0000000000000000000000000000000000000000004242
      4200CECED600D6947B00FF9C7300FF9C7300FF9C7300FF9C7300FF9C7300FF9C
      7300FF9C7300FF9C7300FF9C7300FF9C7300FF9C7300FF9C7300FF9C7300FF9C
      7300FF9C7300FF9C7300FF9C7300FF9C7300FF9C7300E7A58C00ADADB500DEDE
      DE00000000000000000000000000000000001010C6000808C6000808CE000808
      D6000808DE000808DE000808DE000000D6000000D6000000D6000000D600424A
      C600FFFFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF7003939CE000000
      C6000000CE000000CE000000CE000000CE000000CE000000C6000000BD000000
      B5000000AD000000BD0010102100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300F7F7
      F700FFEFE700FFEFE700FFEFE700FFEFDE00FFEFDE008C5A5A008C5A5A008C5A
      5A00FFEFDE00EFD6C600E7CEBD00E7CEBD00E7CEBD00E7CEBD00E7CEBD00E7C6
      B500DEBDA500D6BDAD00F7C69C00DE8C3900DE8C3900CEA57B00ADADB5008484
      CE001039C6001042C6004A4AB500000000000000000000000000000000004242
      4200CECED6009C847B00A58C8400A58C8400A58C8400A58C8400A58C8400A58C
      8400A58C8400A58C8400A58C8400A58C8400A58C84009C847B009C847B009C84
      7B009C847B009C847B009C847B009C847B009C847B009C847B00ADADB500DEDE
      DE00000000000000000000000000000000001818CE000808C6000808D6000808
      DE000808E7000808E7000808E7000000DE000000D6000000D6004242CE00EFEF
      D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004242
      DE000000C6000000CE000000CE000000D6000808CE000000CE000000C6000000
      B5000000AD000000BD0010102100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300F7F7
      F700FFF7E700FFF7E700FFEFE700FFEFE700FFEFE7008C5A5A008C5A5A008C5A
      5A00FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7D600FFE7D600FFE7D600FFE7
      D600FFE7CE00FFE7CE00FFE7CE00FFD6BD00D68C7300AD733900737373005252
      9C002163DE001042C6006363BD00000000000000000000000000000000004242
      4200E7E7EF00E7E7EF00E7E7EF00E7E7EF00E7E7EF00E7E7EF00EFF7F700EFF7
      F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700CECE
      D600000000000000000000000000000000003939D6001010CE001010D6001010
      E7001010EF001010EF000808E7000000E7000000DE004242CE00EFEFD600FFFF
      F700FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF004242DE000000CE000000D6000000D6000808D6000808CE000808C6000000
      BD000808B5000000B50029293100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300F7F7
      F700FFF7EF00FFF7E700FFF7E700FFEFE700FFEFE700FFEFE700FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7D600FFE7
      D600FFE7CE00FFE7CE00FFE7CE00FFD6BD00D69484008C847B00000000000000
      00004A4AB5006363BD0000000000000000000000000000000000000000004242
      4200E7E7EF00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDE
      DE00DEDEDE00E7E7EF00E7E7EF00E7E7EF00E7E7EF00E7E7EF00EFF7F700EFF7
      F700EFF7F700EFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700CECE
      D600000000000000000000000000000000006363E7001010D6001010E7001818
      EF001818F7001818F7000808F7000000EF004242DE00EFEFD600FFFFF700FFFF
      FF00FFFFFF00EFEFD6008484AD008484AD00DEDEC600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF004A4AE7000000D6000000DE000808DE000808D6000808CE000808
      BD000808BD000000A5004A4A5200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300F7F7
      F700FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFE7008C5A5A008C5A5A008C5A
      5A00FFEFDE00D6B5AD00BD948C00BD948C00BD948C00BD948C00BD948C00BD94
      8C00BD948C00D6B5A500FFE7CE00FFD6BD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200E7E7EF00DEDEDE00DEDEDE00DEDEDE00DEDEDE00E7E7EF00E7E7EF00EFF7
      F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700EFF7F700FFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700FFF7F700CECE
      D60000000000000000000000000000000000000000001818D6001818E7001818
      F7002121FF001818FF000000FF004A4AE700EFEFCE00FFFFF700FFFFFF00FFFF
      FF00EFEFCE0073739C000000D6000000D60073738C00CECEAD00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF004A4AE7000000E7000808E7000808DE000808CE000808
      C6000808C6000000940000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300F7F7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E7008C5A5A008C5A5A008C5A
      5A00FFEFE700E7C6BD00CEB5A500CEB5A500CEB5A500CEB5A500D6B5A500D6AD
      A500CEADA500DEC6B500FFE7D600FFD6BD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200E7E7EF00DEDEDE00DEDEDE00DEDEDE00B5B5B5009C9C9C007B7B84007B7B
      8400848C8C00848C8C009C9C9C009C9C9C009C9C9C00ADADAD009CA5A500ADAD
      AD00ADADAD009CA5A500B5B5B500FFF7F700FFF7F700FFF7F700FFF7F700CECE
      D60000000000000000000000000000000000000000001010DE002121EF002121
      FF002121FF002121FF006363D600E7E7C600FFFFF700FFFFFF00FFFFFF00E7E7
      C60073739C000000DE000000EF000000EF000000D60063637B00C6C6A500FFFF
      FF00FFFFFF00FFFFFF00FFFFFF005252DE000000EF000808E7001010D6000808
      C6000808CE001818630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300F7F7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF008C5A5A008C5A5A008C5A
      5A00FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      D600FFE7D600FFE7D600FFE7D600FFD6BD00D69484008C847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200E7E7EF00DEDEDE00DEDEDE00DEDEDE00B5B5B500DEDEDE00EFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700EFF7F700EFF7F7006B6B6B00CECED600DEDE
      DE00DEDEDE00DEDEDE009C9C9C00FFF7F700FFF7F700FFF7F700FFF7F700CECE
      D60000000000000000000000000000000000000000003131E7002121EF002929
      FF003131FF002929FF0073739C00D6D6BD00FFFFFF00FFFFFF00E7E7C6006B6B
      94000000E7000000EF000000E7000000E7000000EF000000D60052527300BDBD
      9C00FFFFFF00FFFFFF00D6D6A5007373BD001010F7001010E7001010D6001010
      CE000808C6005A5A6B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300F7F7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      E700FFEFE700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFD600FFE7D600FFE7D600FFD6BD00D694840094847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200E7E7EF00DEDEDE00DEDEDE00DEDEDE00B5B5B500DEDEDE00E7E7EF00EFF7
      F700EFF7F700EFF7F700EFF7F700E7E7EF00E7E7EF007B7B7B00DEDEDE00DEDE
      DE00DEDEDE00DEDEDE00ADADAD00FFF7F700FFF7F700FFF7F700FFF7F700CECE
      D6000000000000000000000000000000000000000000000000002121EF003131
      FF003939FF003939FF003939FF0073739C00D6D6BD00D6D6BD006B6B94000000
      F7000000F7000000EF000000E7000000EF000000EF000000F7000000DE005252
      7300BDBD9C00C6C69C005A5AAD001818FF001818FF001818E7001818DE001010
      DE00101094000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300F7FF
      F700FFF7F700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7E700FFF7E700FFEFE700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFEFD600FFD6BD00D68C840094847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200E7E7EF00DEDEDE00DEDEDE00DEDEDE00B5B5B500DEDEDE00E7E7EF00E7E7
      EF00EFF7F700EFF7F700EFF7F700E7E7EF00EFE7E7007B7B8400DEDEDE00DEDE
      DE00DEDEDE00E7E7EF00ADADAD00FFF7F700FFF7F700FFF7F700FFF7F700CECE
      D6000000000000000000000000000000000000000000000000003939F7002929
      FF003939FF004A4AFF004A4AFF004A4AFF006B6B84006B6B84002121FF001010
      FF000808FF000000FF000000F7000000F7000000F7000808FF000808FF001818
      F7005A5A6B004A4A94002121FF002121FF002121FF002121EF001818E7001010
      D60073738C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300FFFF
      FF00FFFFF7008C5A5A008C5A5A008C5A5A00FFF7EF00AD848400A57B7300A57B
      7300A57B7300A57B7300A57B7300A57B7300A57B7300A57B7300FFEFE700FFEF
      DE00F7B5B500F7A5A500F7A5A500FF9C9C00D694840094847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200E7E7EF00DEDEDE00DEDEDE00DEDEDE00B5B5B500DEDEDE00E7E7EF00EFF7
      F700EFF7F700EFF7F700EFF7F700E7E7EF00E7E7EF007B7B8400DEDEDE00E7E7
      EF00E7E7EF00EFF7F700ADADAD00FFF7F700FFF7F700FFF7F700FFF7F700CECE
      D600000000000000000000000000000000000000000000000000000000002121
      FF003939FF004A4AFF005A5AFF006363FF006363FF005A5AF7005252FF004242
      FF003131FF002121FF001818FF001818FF001818FF002121FF003131FF003131
      FF003939F7003939FF003131FF003131FF002929FF002121EF001818EF004A4A
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300FFFF
      FF00FFFFF7008C5A5A008C5A5A008C5A5A00FFF7F700EFDED600E7D6CE00E7D6
      CE00E7D6CE00E7D6CE00E7D6CE00E7D6CE00E7D6CE00E7D6CE00FFEFE700E7B5
      9400EFA55200E7943900DE8C3100D6843100BD8C6B0094847B00000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200E7E7EF00DEDEDE00DEDEDE00DEDEDE00B5B5B500DEDEDE00E7E7EF00EFF7
      F700EFF7F700FFF7F700EFF7F700E7E7EF00E7E7EF007B7B8400DEDEDE00E7E7
      EF00E7E7EF00EFF7F700ADADAD00FFF7F700FFF7F700FFF7F700FFF7F700DEDE
      DE00949494000000000000000000000000000000000000000000000000000000
      00002929FF004242FF005A5AFF006B6BFF007B7BFF008484FF008484FF007373
      FF006363FF005252FF004A4AFF004242FF004A4AFF004A4AFF005252FF005252
      FF004A4AFF004A4AFF003939FF003939FF002929F7002121F7002929BD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300FFFF
      FF00FFFFFF008C5A5A008C5A5A008C5A5A00FFFFF700FFF7F700FFF7F700FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFE700EFC6
      9C00FFBD6300FFA52900FFA52900CE8C520094847B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000004242
      4200EFF7F700DEDEDE00DEDEDE00E7E7EF00B5B5B500DEDEDE00EFF7F700FFF7
      F700FFF7F700FFF7F700FFF7F700EFF7F700F7EFEF00848C8C00FFF7F700FFF7
      F700FFF7F700FFF7F700BDC6C600FFF7F700FFF7F700FFF7F700FFF7F7009494
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000002929FF004A4AFF006363FF007B7BFF008C8CFF009494FF009494
      FF009494FF008C8CFF007B7BFF007B7BFF007373FF007373FF006B6BFF006363
      FF005A5AFF004A4AFF004242FF003131FF002121FF002929D600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFF7F700FFF7
      F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700EFC6
      AD00FFCE8400FFB55200D69C6B0094847B000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B5B5
      B5009CA5A5009C9C9C009C9C9C009C9C9C009CA5A500ADADAD00B5B5B500B5B5
      B500B5B5B500B5B5B500B5B5B500B5B5B500B5B5B500313131006B6B6B006B6B
      6B006B6B6B006B6B6B00424242009C9C9C009494940094949400949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002929FF004A4AFF006B6BFF007B7BFF009494FF00A5A5
      FF00A5A5FF00A5A5FF00A5A5FF009C9CFF008C8CFF008484FF007373FF006B6B
      FF005A5AFF004A4AFF003939FF002121FF004242DE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFF
      F700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700EFD6
      AD00FFDE9400CE9C730094847B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000003939FF004242FF006363FF007B7BFF008C8C
      FF009C9CFF00A5A5FF00A5A5FF009C9CFF008C8CFF007B7BFF006B6BFF005A5A
      FF004A4AFF003939FF002121EF008C8CD6000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00F7FFF700F7F7F700F7F7F700F7F7F700EFF7
      F700EFEFEF00EFEFEF00EFEFEF00EFEFEF00E7E7E700E7E7E700E7E7E700EFD6
      B500CEAD8C0094847B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000003939FF004242FF006363
      FF007373FF008484FF008484FF007B7BFF007373FF006363FF005252FF003939
      FF002929FF006B6BF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000BD847300BD84
      7300BD847300BD847300BD847300BD847300BD847300BD847300BD847300BD84
      7300BD847300BD847300BD847300BD847300BD847300BD847300BD847300BD84
      730094847B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B6BFF005A5AFF005252FF004A4AFF005252FF006363FF007B84FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006363630063636300636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A5A5A005A5A5A005A5A5A00635A5200525252005A5A5A005A5A5A006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6A58C009C7B5A00846339007B52
      2900734A2900734A21006B4221006B4221006B4221006B4221006B4221006B42
      21006B4221006B4221006B4221006B4221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000063636300A5848400EFE7E7008C736B006363
      6300636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000AD632100AD63
      2100B55A1000B5521000AD4A1000A5421000A5421000AD4A0800B55208008452
      2900636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6A58C00FFF7F700E7CEBD00EFC6
      AD00EFBD9C00F7B59400FFAD8400FFAD7300FFA57300FFA56B00FF9C6B00FF9C
      6300FF9C6300FF945A00FF9452006B4221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063636300AD8C8C00736B6B00EFE7E700EFE7E700DEC6
      C600947B73006363630063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BD6B2100AD4A1000BD5A
      1000CE6B1800D6731000C6631000B5521000AD4A1000AD4A0800AD4A0800AD4A
      0800000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6A58C00FFFFF700FFFFF700FFF7
      EF00FFF7EF00FFEFE700FFEFDE00FFE7DE00FFE7D600FFDECE00FFDEC600FFD6
      C600FFD6BD00FFD6B500FF945A006B4221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063636300947B7B0084737300736B6B00E7D6D600E7CECE00E7CE
      CE00E7CECE00DEB5B5008C736B00636363006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B55A1000BD631800DE842100E784
      2100D6731800AD4A1000BD631800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEAD9400734221007342
      2100734221007342210073422100734221007342210073422100734221007342
      2100734221007342210073422100734221007342210073422100734221007342
      210073422100734221000000000000000000CEA58C00FFFFFF00FFFFF700FFF7
      EF00FFF7EF00FFEFE700FFEFDE00FFE7DE00FFE7D600FFDECE00FFDEC600FFD6
      C600FFD6BD00FFD6B500FF9C63006B4221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063636300A584840084737300847373009C949400CEC6C600D6B5B500DEB5
      B500DEB5B500DEB5B500D6B5B500CEADAD00846B630063636300636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000AD4A1000D67B2100E78C2900E78C2100D67B
      1800AD5210000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEAD9400FFFFFF00F7E7
      D600F7DECE00F7D6C600EFCEBD00EFCEBD00EFCEBD00EFCEBD00EFCEBD00EFCE
      B500EFC6B500EFC6AD00EFC6AD00EFBDA500EFBD9C00EFB59C00E7B59400E7AD
      8400E7A58400734221000000000000000000CEAD9400FFFFFF00FFFFFF00FFF7
      F700FFF7EF00FF946300FFEFE700F7734200EF733900EF632900EF5A1800EF4A
      0800FFD6BD00FFD6BD00FF9C63006B4221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      63009C848400947B7B00947B7B00B5A5A50084ADBD006B9CB500CECECE00CEBD
      BD00CEA5A500CE9C9C00CE9C9C00CE9C9C00CEA5A500BD9C9C00735A52006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5521000DE842900EF942900E78C2900DE842100AD4A
      1000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEAD9400FFFFFF00FFFF
      FF00FFFFF700FFF7F700FFEFE700FFEFE700FFEFDE00FFE7DE00FFE7D600FFDE
      D600F7DECE00F7DECE00F7D6C600F7D6C600F7D6BD00F7CEBD00F7CEB500F7CE
      B500E7A58C00734221000000000000000000CEAD9400FFFFFF00FFFFFF00FFFF
      F700FFF7F700FFF7EF00FFF7EF00FFEFE700FFEFDE00FFE7D600FFE7D600FFDE
      CE00FFDEC600FFD6BD00FF9C63006B4221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063636300A594
      94009C8484009C848400B5ADAD003984AD001073D60094FFFF0052B5CE006B9C
      B500CECECE00CEB5B500CE9C9C00CE949400CE949400CE949400C6A5A5006363
      6300000000006363630063636300636363006363630063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5521000C66B1800EF943100EF942900E78C2900B5521000A563
      2900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B8C940018313900182939001021
      29000818210000101800000008000000000000000000CEAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFF7EF00FFF7EF00FFEFE700FFEFE700FFEFDE00FFE7
      D600FFE7D600F7DECE00F7DECE00F7DEC600F7D6C600F7D6BD00F7D6BD00F7CE
      BD00E7A58C00734221000000000000000000CEAD9400FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FF946300FFF7EF00F7734200EF733900EF632900EF5A1800EF4A
      0800FFDECE00FFDEC600FF9C6B006B4221000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063636300AD949400A594
      9400AD94940084A5B5000873BD001884F7001873F70094FFFF009CFFFF0094FF
      FF006BCEDE0063A5BD00BDC6C600CEC6C600CE949400CE8C8C00BD948C006363
      630063636300B5949400B5949400B58C8C00B58C8C00AD848400636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000B5521000E78C2900EF942900E7942900DE7B2100B55210005A5A
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B8C940094EFFF0042BDE70039B5
      E70031ADDE0031ADDE0029A5D60029A5D600219CCE00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00CEA58C00BD9C8400BD9C8400BD9C8400BD9C8400BD9C8400BD9C
      8400FFE7DE00F7E7D600FFDED600F7DECE00F7DEC600F7D6C600F7D6C600F7D6
      BD00E7AD8C00734221000000000000000000CEAD9400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFF7EF00FFF7EF00FFEFE700FFEFE700FFE7DE00FFE7
      D600FFE7CE00FFDECE00FFA56B006B422100CEB5AD00AD9484008C6B52007342
      2100734221007342210073422100734221007342210073422100734221007342
      21007342210073422100000000000000000063636300B5949400B5949400AD9C
      9C0084ADBD00088CDE001094FF001884F7001884F70000CEFF0042E7FF0084F7
      FF009CFFFF009CFFFF006BCEDE0063A5BD00BDC6C600CEBDBD00BD9494006363
      6300CEBDBD00DEC6C600DEC6C600C6A5AD00C6A5A500CEADAD00BD9C9C008C5A
      5A00636363000000000000000000000000000000000000000000000000000000
      000000000000B5521000EF943100EF942900E7942900D6732100BD5A10005A5A
      5A00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B55208004A4239000000000000000000000000000000
      0000000000000000000000000000000000006B8C9400ADF7FF0063CEFF0052C6
      F70042C6F70042C6F70039BDF70031B5EF0029B5EF00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7F700FFF7EF00FFF7EF00FFEF
      E700FFEFE700FFE7DE00FFE7DE00FFE7D600FFDECE00F7DECE00F7DEC600F7D6
      C600E7AD9400734221000000000000000000CEAD9400FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FF946300FFFFF700F7734200EF733900EF632900EF5A1800EF4A
      0800FFE7D600FFE7CE00FFA56B006B422100F7EFE700F7DED600F7D6C600EFCE
      B500EFC6B500EFC6AD00EFC6AD00EFBDA500EFBDA500EFB59C00EFB59400E7AD
      8400E7A58400734221000000000000000000C69C9C00BD9C9C00C6ADAD004A94
      BD0008ADFF00109CFF00108CF7001884F70000CEFF001094BD000094C60000CE
      FF0021DEFF0063EFFF009CFFFF009CFFFF007BE7EF0073A5BD0063636300ADAD
      AD00CECECE00D6D6CE00D6BDBD00BDA5A500A5949400AD848400BD949400CEAD
      AD00AD8484006363630000000000000000000000000000000000000000000000
      000000000000C6631800EF9C3100EF942900E7942900CE731800BD5A18005A5A
      5A00000000000000000000000000000000000000000000000000000000000000
      000000000000AD4A0800BD520800B55208004242420000000000000000000000
      0000000000000000000000000000000000006B8C9400ADF7FF008CE7FF007BE7
      FF0073DEFF006BDEFF0063D6FF005AD6FF004ACEFF00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00CEAD9400C6A58C00C6A58C00C6A58C00C6A58C00C6A58C00C69C
      8C00BD9C8400BD9C8400BD9C8400FFE7DE00F7E7D600F7DECE00F7DECE00F7DE
      CE00E7B59400734221000000000000000000CEB59C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFF7EF00FFF7EF00FFEF
      E700FFEFDE00FFE7D600FFA573006B422100FFF7EF00FFEFE700FFEFDE00FFDE
      D600F7DECE00F7DECE00F7D6C600F7D6C600F7D6BD00F7CEBD00F7CEB500F7CE
      B500E7A58C00734221000000000000000000CEA5A500CEBDBD003994B50000BD
      FF0008ADFF00109CFF00108CF70008ADFF0000C6F700A5BDC60052C6DE001094
      BD00109CCE0000CEFF0000CEFF0042E7FF0094FFFF003984A50063636300C6BD
      BD00D6D6D600DED6D600C6A5AD00DEC6C600ADA5A500A58C8C00AD848400CEAD
      AD00CE9C9C00636363000000000000000000000000005A5A5A005A5A5A005A5A
      5A00C66B2100CE732100EF943100EF943100EF942900D67B2100B55A10004242
      42005A5A5A005A5A5A005A5A5A00636363000000000000000000000000000000
      0000AD4A0800C65A0000CE630000B5520800A55210004A4A4A00000000000000
      0000000000000000000000000000000000006B8C9400B5F7FF0094EFFF008CE7
      FF007BE7FF0073DEFF006BDEFF005AD6FF0052D6FF00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFF7
      EF00FFF7EF00FFEFEF00FFEFE700FFEFDE00FFE7DE00FFE7D600FFE7D600FFDE
      CE00EFB59400734221000000000000000000D6B59C00FFFFFF00C6F7CE007BDE
      8C0073DE7B0063DE6B005AD66B0052CE5A0052C6520052C6520052C6520052C6
      5200FFEFE700FFEFDE00FFAD7B006B422100FFF7EF00FFF7EF00FFEFE700FFE7
      D600FFE7D600F7DECE00F7DECE00F7DEC600F7D6C600F7D6BD00F7D6BD00F7CE
      BD00E7A58C00734221000000000000000000CEADAD00BDBDC60000B5E70000BD
      FF0008ADFF001094FF001094FF0008C6F700397B940010A5D60000C6FF008CCE
      D60063CEE70018B5DE003984A50000B5E70010CEFF003984A500AD848400D6D6
      D600DEDEDE00DEDEDE00BD9C9C00DEC6C600AD8C8C00AD848400AD8C8C00CEAD
      AD00CEA5A500636363000000000000000000B5521000C66B2100C6632100C663
      2100CE732100E78C3100EF943100EF942900EF942900DE842100CE6B1800BD5A
      1800BD5A1000BD5A1000B55A1000A56B3100000000000000000000000000B552
      0800C65A0000CE630000CE630000CE630000AD4A08008C4A18005A5A5A000000
      0000000000000000000000000000000000006B8C9400B5F7FF0094EFFF008CEF
      FF0084E7FF007BE7FF006BDEFF0063D6FF005AD6FF00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00CEAD9400C6A58C00C6A58C00C6A58C00C6A58C00C6A58C00C69C
      8C00BD9C8400BD9C8400FFF7EF00FFEFE700FFEFE700FFE7DE00FFE7DE00F7E7
      D600EFB59C00734221000000000000000000D6B59C00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFF7
      EF00FFEFE700FFEFE700FFAD84006B422100E7DED600DECEBD00CEB59C00BD9C
      8400BD9C8400F7E7D600F7DED600F7DECE00F7DEC600F7D6C600F7D6C600F7D6
      BD00E7AD8C00734221000000000000000000000000004284AD000094CE000894
      DE0008ADFF001094FF0010CEFF0018B5DE0084CEE70008C6F7006384940031AD
      CE0000C6FF0010C6EF0084D6E70000C6FF00218CB50063636300DEDEDE00EFEF
      EF00EFEFEF00DED6D600CE9C9C00CEADAD00B57B7B00B57B7B00BD848400D6B5
      B500CE9C9C0063636300000000000000000000000000B5521000D67B2100D67B
      2100E7943100EF9C3100EF943100EF942900E7942900E78C2900DE842100CE6B
      1800CE6B1800C66B1000B5521000000000000000000000000000B5520800BD5A
      0800CE630000CE630000CE630000CE630000C6630000AD4A0800634231006B6B
      6B00000000000000000000000000000000006B8C9400BDF7FF009CEFFF0094EF
      FF008CE7FF007BE7FF0073DEFF006BDEFF005AD6FF00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFF7F700FFF7F700FFF7EF00FFF7EF00FFEFE700FFEFE700FFEF
      DE00EFB59C00734221000000000000000000D6B59C00FFFFFF00BDEFC6007BDE
      8C0073DE7B0063DE6B005AD66B0052CE5A0052C6520052C6520052C6520052C6
      5200FFF7EF00FFEFE700F7B58C006B422100FFFFFF00FFF7F700FFF7EF00FFEF
      E700FFEFE700FFE7DE00FFE7DE00FFE7D600FFDECE00F7DECE00F7DEC600F7D6
      C600E7AD9400734221000000000000000000298CBD00088CDE00088CDE001084
      E7000884CE0042CEFF0063BDD6009CADB50021CEF7000094CE0029C6EF0010CE
      FF007B949C006BB5C60000CEFF00218CB50063636300B5949400CE9C9C00DEC6
      C600EFEFEF00CEB5B500CEADAD00C68C8C00BD737300C6737300C67B7B00CEAD
      AD00636363000000000000000000000000000000000000000000AD4A1000E794
      3100EF9C3100EF9C3100EF9C3100EF942900E7942900E78C2900E78C2100E784
      2100D6731800B5521000000000000000000000000000B55A1000BD5A0800CE6B
      0000CE630000CE630000CE630000CE630000CE630000C65A0000AD4A08004A42
      3900737373000000000000000000000000006B8C9400BDFFFF00A5F7FF009CEF
      FF0094EFFF0084E7FF007BE7FF0073DEFF0063DEFF00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFF7F700FFF7F700FFF7EF000031F7000031F7000029
      C600EFBD9C00734221000000000000000000D6B5A500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      F700FFF7EF00FFEFE700F7B58C006B422100EFDED600DECEBD00D6B5A500C6A5
      8C00C69C8C00BD9C8400BD9C8400BD9C8400F7E7D600FFDECE00F7DECE00F7DE
      CE00E7B594007342210000000000000000000094C60000CEFF006BE7FF0010CE
      FF000873BD004AC6F7007BF7FF006BEFFF0063CEE700BDCECE0031C6E700108C
      BD0031B5D60000CEFF00218CB50063636300AD9C9C00BD8C8C00E7B58C00DEB5
      B500CE949400CE949400CE949400C6737300CE6B6B00CE6B6B00CE6B6B006363
      630000000000000000000000000000000000000000000000000000000000B55A
      1800EF9C3100EF9C3100EF943100EF942900EF942900E78C2900E78C2100DE7B
      1800AD4A1000000000000000000000000000B5632100B5520800CE6B0000CE6B
      0000CE630000CE630000CE630000CE630000CE630000CE630000BD5A0000B552
      0800424242007B7B7B0000000000000000006B8C9400C6FFFF00A5F7FF009CF7
      FF0094EFFF008CEFFF0084E7FF007BE7FF006BDEFF00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F7002952FF002952FF000031
      F700EFBDA500734221000000000000000000D6B5A500FFFFFF00BDEFC6007BDE
      8C0073DE7B0063DE6B005AD66B0052CE5A0052C65200FFFFFF00FFFFFF00E7C6
      BD00EFC6A500F7B59400F7B58C006B422100FFFFFF00FFFFFF00FFFFF700FFF7
      EF00FFF7EF00FFEFE700FFEFE700FFEFDE00FFE7DE00FFE7D600FFE7D600FFDE
      CE00EFB59400734221000000000000000000108CBD0021DEFF0031DEFF0010BD
      FF000884CE001894E7007BF7FF0084F7F70084F7FF006BEFFF006BE7F700BDDE
      DE0039D6FF00218CB5006363630000000000BD9CA500BD8C8C00FFA50800FFB5
      3100F7C68C00E7AD9C00CE848400C6737300C65A6300C65A6300636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000BD5A1800EF9C3100EF9C3100EF942900E7942900E78C2900DE842100B552
      1000000000000000000000000000BD733100B5521000D66B0800CE6B0000CE6B
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000B552
      0800AD5208004A4A4A0000000000000000006B8C9400C6FFFF00ADF7FF00A5F7
      FF009CEFFF0094EFFF008CE7FF007BE7FF0073DEFF00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005A73FF002952FF000031
      F700EFC6AD00734221000000000000000000D6BDA500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEAD94009C7B
      5A007B5A31006B4221006B4221006B422100EFDED600DECEBD00CEAD9C00C6A5
      8C00C69C8C00BD9C8400BD9C8400FFEFE700FFEFE700FFE7DE00FFE7DE00F7E7
      D600EFB59C007342210000000000000000005AA5C6006BC6E700B5FFFF0084EF
      FF0031D6FF001894BD0039C6F700006BAD00107BAD006BD6E7007BEFF70042CE
      FF001894E7002184D6006363630000000000BD9CA500CE947300FFAD1800FFAD
      1800FFAD1800FFB53100FFC67300E7AD8400D68C8400C6737300BD737300735A
      5200636363006363630000000000000000000000000000000000000000000000
      000000000000C6631800EF943100EF942900E7942900E78C2900B55210000000
      0000000000000000000000000000AD4A1000BD5A1000BD520800BD5A0800CE6B
      0000CE630000CE630000CE630000CE630000CE630000C65A0000C65A0000C65A
      0000AD4A08009C5A210073737300000000006B8C9400CEFFFF00ADF7FF00A5F7
      FF00A5F7FF009CEFFF008CEFFF0084E7FF007BE7FF00CEAD9400FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      F700FFE7DE00734221000000000000000000DEBDA500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEAD9400F7DE
      C600FFCEB500F7C6A500734A2900EFDED600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFF7F700FFF7EF00FFF7EF00FFEFE700FFEFE700FFEFDE00FFE7
      DE00EFB59C00734221000000000000000000000000005AA5C6005AADCE0094EF
      F700BDFFFF0084F7FF004AE7FF0031D6FF0018BDFF000094CE000094CE0039D6
      FF0010CEFF00088CDE006363630000000000BD9CA500D6946300FFB53100FFB5
      3100FFB53100FFB53100FFB53100FFBD3900FFBD5A00EFB56B00DE9C8400CE8C
      8C00B57B7B006363630063636300000000000000000000000000000000000000
      000000000000CE6B2900CE732100EF942900EF942900BD631800000000000000
      000000000000000000000000000000000000000000000000000000000000BD5A
      0800CE630000CE630000CE630000CE630000C65A0000AD4A0800AD4A0800AD4A
      0800AD4A0800B54A080000000000000000006B8C9400CEFFFF00B5FFFF00ADF7
      FF00A5F7FF009CF7FF0094EFFF008CEFFF0084E7FF00D6B5A500DEBDAD00DEBD
      AD00DEBDAD00DEBDAD00DEBDAD00DEBDAD00DEBDAD00DEBDAD00DEBDAD00DEBD
      AD00DEBDA500DEB59C00DEB59C00DEB59C00DEB59C00DEB59C00DEAD9400DEAD
      8C00DEAD8C00C69C8C000000000000000000DEBDA500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEAD9400FFEF
      E700FFDECE007B523100EFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFF7F700FFF7F700FFF7EF000031F7000031F7000029
      C600EFBD9C007342210000000000000000000000000000000000000000005AA5
      C6005AADCE0063BDD6009CF7F700BDFFFF00BDFFFF0094F7FF004AE7FF0031DE
      FF0010C6EF00298CBD006363630000000000BD9CAD00E7A55200FFBD3900FFBD
      4200FFBD4200FFBD4A00FFBD4A00FFBD4200FFBD4200FFBD4200FFBD4A00F7AD
      4A00DE9C6B00CE6B6B0063636300000000000000000000000000000000000000
      00000000000000000000BD632100D67B2100CE6B180000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD4A
      0800CE630000CE630000CE630000CE630000AD4A08008C522900000000000000
      0000000000000000000000000000000000006B8C9400D6FFFF00B5FFFF00B5FF
      FF00ADF7FF00A5F7FF009CEFFF0094EFFF008CE7FF007BE7FF0073DEFF006BDE
      FF005AD6FF0052D6FF004ACEFF0042C6FF0039C6FF0031BDF70029BDF70021B5
      F70021B5F70018ADEF0010A5EF0008A5E7000094DE000073AD00183139000000
      000000000000000000000000000000000000DEBDA500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEB59C00FFEF
      E7008C6B4A00EFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700315AFF00184AFF000031
      F700EFBDA5007342210000000000000000000000000000000000000000000000
      000000000000000000005AA5C6005AADCE0063BDD60073BDDE005AADCE004AA5
      CE004AA5CE00636363000000000000000000BD9CAD00F7B55200FFBD4A00FFC6
      4A00FFC65200FFC65200FFC65200FFC65200FFC65200FFC64A00FFC64A00FFBD
      4200FFBD3900CE6B5A0063636300000000000000000000000000000000000000
      0000000000000000000000000000B55A18000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A542
      1000CE630000CE630000CE630000CE630000A54208006B5A5200000000000000
      0000000000000000000000000000000000006B8C9400D6FFFF00B5FFFF00B5FF
      FF00ADFFFF00A5F7FF00A5F7FF0094EFFF008CEFFF0084E7FF007BE7FF0073DE
      FF0063D6FF005AD6FF0052CEFF004ACEFF0042C6FF0039C6FF0031BDF70029BD
      F70021B5F70018ADEF0010ADEF0010A5EF000094DE00087BB50029394A000000
      000000000000000000000000000000000000DEBDA500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00CEB59C00AD84
      6B00EFDED600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005A73FF00315AFF000031
      F700EFC6AD007342210000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000C6A5AD00FFBD5A00FFC65200FFCE
      6300FFCE6300FFCE6B00FFCE6B00FFCE6B00FFCE6B00FFCE6300FFC65200FFC6
      5200FFBD4A00CE7B730063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD4A
      0800CE630000CE630000CE630000C65A0000AD4A0800AD632100000000000000
      0000000000000000000000000000000000006B8C9400D6FFFF00B5FFFF00B5FF
      FF00B5FFFF00ADF7FF00A5F7FF009CEFFF0094EFFF008CE7FF0084E7FF0073DE
      FF006BDEFF0063D6FF005AD6FF004ACEFF0042CEFF0039C6FF0031BDF70029BD
      F70029B5F70021B5F70018ADEF0010A5EF000094DE00087BB500314A52000000
      000000000000000000000000000000000000DEBDA500DEBDA500DEBDA500D6BD
      A500D6BDA500D6B5A500D6B59C00D6B59C00D6B59C00CEB59C00D6B59C00F7E7
      DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7
      F700FFE7DE007342210000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6ADB500D6AD9C00FFC66300FFCE6B00FFCE
      6B00FFD67300FFD67300FFD67300FFD67300FFD67300FFCE6B00FFCE6B00FFCE
      6300F7B55A00CE84840063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD4A
      0800CE630000CE630000CE630000B5520800AD52100000000000000000000000
      0000000000000000000000000000000000006B8C9400DEFFFF00B5FFFF00B5FF
      FF00B5FFFF00ADF7FF00ADF7FF00A5F7FF009CEFFF0094EFFF0084E7FF007BE7
      FF0073DEFF006BDEFF005AD6FF0052CEFF004ACEFF0042C6FF0039C6FF0031BD
      F70029BDF70021B5F70018ADEF0018ADEF00089CE700108CBD00394A5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000EFDED600F7E7DE00F7E7DE00F7EFE700F7E7
      DE00F7DECE00EFD6C600EFD6C600EFD6C600EFD6C600EFD6C600EFD6C600EFD6
      C600EFCEBD00EFC6AD00EFC6AD00EFC6AD00EFBDA500EFBDA500EFB59400E7AD
      8C00E7A58400B5947B0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6ADB500DEBD9400FFCE6B00FFD67300FFDE
      7B00FFDE8400FFDE8400FFDE8400FFDE8400FFDE8400FFDE7B00FFD67300FFCE
      6B00EFAD6300BD84840063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5520800C65A
      0800CE630000CE630000C6630000AD4A0800AD63210000000000000000000000
      0000000000000000000000000000000000006B8C9400DEFFFF00B5FFFF00B5FF
      FF00B5FFFF00B5FFFF00ADFFFF00A5F7FF00A5F7FF009CEFFF0094EFFF0084E7
      FF007BE7FF0073DEFF006BDEFF005AD6FF0052CEFF004ACEFF0042C6FF0031BD
      FF0031BDF70029BDF70021B5F70018ADEF0010ADEF00219CCE00394A5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000D6AD9400F7EFE700FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFF7F700FFF7F700FFF7EF00FFF7EF00FFF7E700FFEF
      E700FFEFE700FFEFDE00FFE7DE00FFE7DE00FFE7D600FFE7D600FFE7D600F7DE
      CE00B5947B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CEBDBD00DEBD9400FFD67300FFDE7B00FFE7
      8C00FFE78C00FFE79400FFE79400FFE79400FFE79400FFE78C00FFDE8400FFDE
      7B00E7A56B00B584840063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B5521000BD5A0800CE6B
      0000CE630000CE630000B54A0800AD6321000000000000000000000000000000
      0000000000000000000000000000000000006B8C9400E7FFFF00DEFFFF00D6FF
      FF00D6FFFF00CEFFFF00C6FFFF00BDF7FF00B5F7FF00B5F7FF00ADF7FF00A5EF
      FF009CE7FF0094E7FF008CDEFF008CDEFF0084DEFF007BDEFF007BDEFF007BDE
      FF0073D6FF0073D6FF0073D6FF006BD6FF0063CEFF0042BDE700738C94000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D6AD9400F7EFEF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFF7F700FFF7EF00FFF7
      EF00FFF7EF00FFEFE700FFEFE700FFEFE700FFE7DE00FFE7DE00EFDECE00B594
      7B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CEC6C600F7C68C00FFDE7B00FFE78C00FFE7
      9400FFE79C00FFEFA500FFEFA500FFEFA500FFE79C00FFE79C00FFE79400FFDE
      8400DE9C6B009C7B7B0063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000A5632900AD521000BD5A0800CE6B0800CE6B
      0000CE630000B5520800B55A1800000000000000000000000000000000000000
      0000000000000000000000000000000000007B9CA5006B8C94006B8C94006B8C
      94006B8C94006B8C94006B849400638C94006384940063849400637B8C005A7B
      8C005A7384005273840052738400526B7B004A6B7B004A6B7B004A6B7B004A6B
      7B004A6B7B004A6B7B004A6B7B004A6B7B004A6B7B00849CA500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000D6AD9400F7EF
      EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFF7
      F700FFF7EF00FFF7EF00FFEFEF00FFEFE700FFEFE700F7DECE00B5947B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000E7D6D600E7C67B00FFDE8400FFE79400FFE7
      9C00FFEFA500FFF7B500FFF7B500FFF7B500FFF7B500FFEFA500FFE79C00FFE7
      9400CE947300947B730063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B5521000AD4A
      1000AD4A1000B5521000AD4A1000B5521000CE6B0800D66B0800CE6B0800BD5A
      0800AD4A0800B563180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008CA5AD00ADE7EF00ADE7EF00ADE7
      EF00ADE7EF00ADE7EF00A5DEE700A5DEE700A5DEE7009CCEDE0094C6CE0084B5
      BD006B8C94000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D6AD
      9400F7EFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700FFFFF700FFF7F700FFF7EF00FFF7EF00F7E7D600B5947B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6BDBD00E7D6D600D6B57B00FFDE8C00FFE79C00FFEF
      A500FFF7B500FFFFC600FFFFC600FFFFC600FFFFBD00FFF7B500FFEFA500FFDE
      9400CE8C7300947B730063636300000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000AD4A
      1000BD5A1000C66B1000C6631000BD5A1000B5521000AD4A0800AD4A1000B552
      1000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073949C009CD6DE00CEFF
      FF00CEFFFF00CEFFFF00B5F7FF00ADEFFF00A5EFFF00A5EFFF009CD6DE006B8C
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6B5A500F7EFEF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFF700F7E7DE00BDA58C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDBDBD00DEDEDE00ADA5A500AD9C9C00BDA59C00CEB5
      9C00D6C6A500EFE7BD00F7F7C600F7F7C600FFFFC600FFFFBD00FFEFA500FFDE
      9400CE9484008C736B0063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BD631800BD5A1000C6631800CE7B420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009CADB5007B9C
      A5006B8C94006B8C94006B8C94006B8C94006B8C9C00849CA5009CADB5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEBDAD00F7EFEF00FFF7F700FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFF7F700F7EFE700C6AD9C000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6BDBD00D6D6CE00D6D6CE00CEC6C600CEBDBD00C6AD
      B500C6ADAD00BDA5A500BDA5A500BDA59C00CEB59C00DEC69C00E7CE9400E7CE
      9400C68C8C00846B630063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEC6B500E7D6CE00F7EFE700FFF7F700FFF7F700F7F7
      F700EFE7DE00E7CEC600CEB5AD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CEBD
      BD00CEBDBD00CEBDBD00C6ADB500C6A5AD00CEB5B500C6A5AD00C69C9C00BD94
      9400A57B73008C736B0063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000E7D6C600E7CEC600DEC6BD00DEC6
      BD00DEC6BD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEC6C600DEC6C600CEB5B500C6A5
      A500C6A5A5006363630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006363630063636300636363006363630063636300636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000006363630063636300636363006363630063636300636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300636363006363630063636300636363006363630063636300636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6A59400D6A59C00CE9C9400CE9C8C00C69C8C00C69C8C00C6948C00C694
      8C00C6948C00C6948C00C6948C00C6948C00C6948C00C6948C00C6948C00C694
      8C00C6948C00C6948C00C6948C00C6948C00C6948C00C6948C00DE948C006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000D6A59400D6A59C00CE9C9400CE9C8C00C69C8C00C69C8C00C6948C00C694
      8C00C6948C00C6948C00C6948C00C6948C00C6948C00C6948C00C6948C00C694
      8C00C6948C00C6948C00C6948C00C6948C00C6948C00C6948C00DE948C006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CEB5AD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6
      BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6
      BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFCE9C00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000CEB5AD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6
      BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6
      BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFD6BD00FFCE9C00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000094DE000094DE000094DE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CEB5AD00E7E7E700FFE7CE00FFDECE00FFDEC600FFDEC600FFDEC600FFDE
      C600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFD6BD00FFD6BD00FFD6B500FFD6
      B500FFD6B500FFD6B500FFD6B500FFD6AD00FFD6AD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000CEB5AD00E7E7E700FFE7CE00FFDECE00FFDEC600FFDEC600FFDEC600FFDE
      C600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFD6BD00FFD6BD00FFD6B500FFD6
      B500FFD6B500FFD6B500FFD6B500FFD6AD00FFD6AD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400000000000000
      0000000000000000000000ADF70000ADF7000094DE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CEB5AD00E7E7E700FFE7CE00FFE7CE00FFDECE00FFDEC600FFDEC600FFDE
      C600FFDEC600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFD6BD00FFD6
      BD00FFD6B500FFD6B500FFD6B500FFD6B500FFD6B500FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000CEB5AD00E7E7E700FFE7CE00FFE7CE00FFDECE00FFDEC600FFDEC600FFDE
      C600FFDEC600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFD6BD00FFD6
      BD00FFD6B500FFD6B500FFD6B500FFD6B500FFD6B500FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00219C0000219C0000219C000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00219C0000219C0000219C000084848400000000000000
      000000000000000000000000000000ADF7000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CEB5AD00E7E7E700FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDE
      C600FFDEC600FFDEC600FFDEC600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFD6
      BD00FFD6BD00FFD6B500FFD6B500FFD6B500FFD6B500FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000CEB5AD00E7E7E700FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDEC600FFDE
      C600FFDEC600FFDEC600FFDEC600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFD6
      BD00FFD6BD00FFD6B500FFD6B500FFD6B500FFD6B500FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018A50000219C0000219C000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018A50000219C0000219C000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6BDAD00E7E7E700FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDE
      C600FFDEC600FFDEC600FFDEC600FFDEC600FFDEC600FFDEBD00FFDEBD00FFDE
      BD00FFD6BD00FFD6BD00FFD6B500FFD6B500FFD6B500FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000D6BDAD00E7E7E700FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFDE
      C600FFDEC600FFDEC600FFDEC600FFDEC600FFDEC600FFDEBD00FFDEBD00FFDE
      BD00FFD6BD00FFD6BD00FFD6B500FFD6B500FFD6B500FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018A5000021A50000219C000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018A5000021A50000219C000084848400000000000000
      0000000000000094DE000094DE000094DE000094DE000094DE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D6BDAD00E7E7E700FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFDEC600FFDEC600FFDEC600FFDEC600FFDEC600FFDEBD00FFDE
      BD00FFDEBD00FFDEBD00FFD6BD00FFD6B500FFD6B500FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000D6BDAD00E7E7E700FFE7D600FFE7CE00FFE7CE00FFE7CE006B6B6B006B6B
      6B00FFE7CE00FFDEC600FFDEC600FFDEC600FFDEC600FFDEC600FFDEBD00FFDE
      BD00FFDEBD00FFDEBD00FFD6BD00FFD6B500FFD6B500FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018A5000018A5000018A5000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018A5000018A5000018A50000848484000000000094FF
      FF0000ADF70000ADF70000ADF70000ADF70000ADF70000ADF7000094DE000094
      DE00000000000000000000000000000000000000000000000000000000000000
      0000D6BDAD00EFEFEF00FFE7D600FFE7D600FFE7D600FFE7CE00FFE7CE00FFE7
      CE00FFE7CE00FFE7CE00FFDEC600FFDEC600FFDEC600FFDEC600FFDEC600FFDE
      C600FFDEBD00FFDEBD00FFDEBD00FFD6BD00FFD6BD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000D6BDAD00EFEFEF00FFE7D600FFE7D600FFE7D6007B5AEF002900DE003929
      A50063636300FFE7CE00FFDEC600FFDEC600FFDEC600FFDEC600FFDEC600FFDE
      C6006352B5002900DE00FFDEBD00FFD6BD00FFD6BD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018AD000018A5000018A5000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018AD000018A5000018A50000848484000000000000AD
      F70000ADF70000ADF70000ADF70000ADF70000ADF70000ADF70000ADF70000AD
      F7000094DE000000000000000000000000000000000000000000000000000000
      0000D6BDB500EFEFEF00FFE7D600FFE7D600FFE7D600FFE7D600FFE7CE00FFE7
      CE00FFE7CE00FFE7CE0029D63100FFDEC600FFDEC600FFDEC600FFDEC600FFDE
      C600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFD6BD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000D6BDB500EFEFEF00FFE7D600FFE7D600FFE7D6007B5AEF002900DE003108
      DE00524A6B0063636300FFE7CE00FFDEC600FFDEC600FFDEC600FFDEC6004229
      C6002900DE005A42B500FFDEBD00FFDEBD00FFD6BD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018AD000018AD000018A5000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000DE000000DE000000DE000000
      000084848400FFFFFF0018AD000018AD000018A50000848484000000000000AD
      F70000ADF70000ADF70000ADF70000ADF70000ADF70000ADF70000ADF70000AD
      F7000094DE000000000000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFD600FFE7D600FFE7D600FFE7D600FFE7D600FFE7
      D600FFE7CE0029D6310000CE100029D63100FFE7CE00FFDEC600FFDEC600FFDE
      C600FFDEC600FFDEC600FFDEBD00FFDEBD00FFDEBD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFD600FFE7D600FFE7D600FFE7D6007B5AEF002900
      DE003918D6005A5A5A00FFE7CE00FFE7CE00FFE7CE00FFDEC6003918CE002900
      DE005A42B500FFDEC600FFDEBD00FFDEBD00FFDEBD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0018B5000018AD000018AD000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000DE000000DE000000DE000000
      000084848400FFFFFF0018B5000018AD000018AD0000848484000000000000AD
      F70000ADF70000ADF70000ADF70000ADF70000ADF70000ADF70000ADF70000AD
      F7000094DE000000000000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7D600FFE7
      D60010CE210010E7210010E7210008D6180029D63100FFE7CE00FFDEC600FFDE
      C600FFDEC600FFDEC600FFDEC600FFDEC600FFDEBD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7D6007B63
      EF002900DE005239C60063636300FFE7CE00FFE7CE003918CE002900DE005A42
      B500FFDEC600FFDEC600FFDEC600FFDEC600FFDEBD00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0018B5000018B5000018AD000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      000000000000FFFFFF0018B5000018B5000018AD000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000ADF7000094DE0000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFE7D60008CE
      100010E7210039E7420042D64A0029E7390018DE290029D63100FFE7CE00FFE7
      CE00FFDEC600FFDEC600FFDEC600FFDEC600FFDEC600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7
      D6007B63EF002900DE005231C60052525A003110C6002900D6005A42B500FFE7
      CE00FFDEC600FFDEC600FFDEC600FFDEC600FFDEC600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      840084848400FFFFFF0018B5000018B5000018B5000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      840084848400FFFFFF0018B5000018B5000018B5000084848400848484008484
      8400848484008484840084848400848484008484840084848400848484000000
      000000ADF7000094DE0000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFDE00FFEFDE00FFEFDE00FFEFDE0010D6210018E7
      290039E7420042E74A00FFE7D60052DE5A0029DE390010D6180029D63100FFE7
      CE00FFE7CE00FFDEC600FFDEC600FFDEC600FFDEC600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFE7
      D600FFE7D6007B5AEF002900DE002900D6002900D6006B638C00FFE7CE00FFE7
      CE00FFE7CE00FFDEC600FFDEC600FFDEC600FFDEC600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0008D6000010CE000010CE000010C6000010C6000010C6
      000010BD000010BD000010BD000018B5000018B5000018B5000018AD000018AD
      000018A5000018A5000021A50000219C0000219C0000219C0000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0008D6000010CE000010CE000010C6000010C6000010C6
      000010BD000010BD000010BD000018B5000018B5000018B5000018AD000018AD
      000018A5000018A5000021A50000219C0000219C0000219C0000848484000000
      000000ADF7000094DE0000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFDE00FFEFDE00FFEFDE00FFEFDE0018E7290039E7
      420042E74A00FFE7D600FFE7D600FFE7D60052DE5A0029DE390021D6310029D6
      3100FFE7CE00FFE7CE00FFDECE00FFDEC600FFDEC600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000DEC6B500EFEFEF00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFD600FFE7D6002908DE002900DE004229C6006B638C00FFE7CE00FFE7
      CE00FFE7CE00FFE7CE00FFDECE00FFDEC600FFDEC600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0008D6000010D6000010CE000010CE000010C6000010C6
      000010C6000010BD000010BD000018BD000018B5000018B5000018B5000018AD
      000018AD000018A5000018A5000021A50000219C0000219C0000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0008D6000010D6000010CE000010CE000010C6000010C6
      000010C6000010BD000010BD000018BD000018B5000018B5000018B5000018AD
      000018AD000018A5000018A5000021A50000219C0000219C0000848484000000
      000000ADF7000094DE0000000000000000000000000000000000000000000000
      0000E7CEBD00EFF7F700FFEFE700FFEFE700FFEFDE00FFEFDE0039E7420052E7
      5A00FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7D60052DE5A0018DE290039CE
      420029D63100FFE7CE00FFE7CE00FFDECE00FFDEC600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000E7CEBD00EFF7F700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFDE003918CE002900DE005A42B5003108E7005A39D6006B638C00FFE7
      CE00FFE7CE00FFE7CE00FFE7CE00FFDECE00FFDEC600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0008D6000008D6000010D6000010CE000010CE000010CE
      000010C6000010C6000010BD000010BD000018BD000018B5000018B5000018AD
      000018AD000018AD000018A5000018A5000021A50000219C0000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0008D6000008D6000010D6000010CE000010CE000010CE
      000010C6000010C6000010BD000010BD000018BD000018B5000018B5000018AD
      000018AD000018AD000018A5000018A5000021A50000219C0000848484000000
      000000ADF7000094DE0000000000000000000000000000000000000000000000
      0000E7CEBD00F7F7F700FFEFE700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7D60052DE5A0010DE
      210042D64A0029D63100FFE7CE00FFE7CE00FFE7CE00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000E7CEBD00F7F7F700FFEFE700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEF
      DE003918CE002900DE005A42B500FFEFD600FFE7D6004218E7004A29DE006B63
      8C00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0010C6000010BD000010BD0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF0010C6000010BD000010BD0000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00848484000000
      00000094DE000000000000000000000000000000000000000000000000000000
      0000E7CEBD00F7F7F700FFF7E700FFF7E700FFEFE700FFEFE700FFEFE700FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7D60052DE
      5A0010DE210042D64A0029D63100FFE7CE00FFE7CE00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000E7CEBD00F7F7F700FFF7E700FFF7E700FFEFE700FFEFE700FFEFE7003910
      CE002900DE005A42B500FFEFDE00FFEFDE00FFEFD600FFE7D6005A42E7003108
      DE006B638C00FFE7D600FFE7CE00FFE7CE00FFE7CE00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      840084848400FFFFFF0010C6000010C6000010BD000084848400000000008484
      8400848484008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400848484008484
      840084848400FFFFFF0010C6000010C6000010BD000084848400000000008484
      8400848484008484840084848400848484008484840084848400848484000000
      00000094DE000000000000000000000000000000000000000000000000000000
      0000EFD6BD00F7F7F700FFF7EF00FFF7E700FFF7E700FFEFE700FFEFE700FFEF
      E700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFE7D600FFE7
      D60052DE5A0018DE210018DE2100FFE7CE00FFE7CE00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000EFD6BD00F7F7F700FFF7EF00FFF7E700FFF7E700FFEFE7003910CE002900
      DE005A42B500FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFE7D6005A42
      E7002900DE00FFE7D600FFE7D600FFE7CE00FFE7CE00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0010C6000010C6000010C6000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B21
      FF000000DE000000DE006B21FF000000DE000000DE000000DE000000DE000000
      DE0084848400FFFFFF0010C6000010C6000010C60000848484000000000000AD
      F70000ADF70094FFFF0094FFFF0000ADF70000ADF70000ADF70000ADF70000AD
      F7000094DE000000000000000000000000000000000000000000000000000000
      0000EFD6BD00F7F7F700FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFE700FFEF
      E700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      D600FFE7D6005AE763005AE76300FFE7D600FFE7CE00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000EFD6BD00F7F7F700FFF7EF00FFF7EF00FFF7E7004218E7002900DE004229
      C600FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      D600FFE7D600FFE7D600FFE7D600FFE7D600FFE7CE00FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0010CE000010C6000010C6000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B21
      FF000000DE000000DE006B21FF000000DE000000DE000000DE000000DE000000
      DE0084848400FFFFFF0010CE000010C6000010C60000848484000000000094FF
      FF0094FFFF0000ADF70000ADF70000ADF70000ADF70000ADF7000094DE000094
      DE00000000000000000000000000000000000000000000000000000000000000
      0000EFD6C600F7F7F700FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFF7
      E700FFEFE700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFD600FFE7D600FFE7D600FFE7D600FFE7D600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000EFD6C600F7F7F700FFF7EF00FFF7EF00FFF7EF003110E7004A29E700FFF7
      E700FFEFE700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFD600FFE7D600FFE7D600FFE7D600FFE7D600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0010CE000010CE000010C6000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B21
      FF000000DE000000DE006B21FF000000DE000000DE000000DE000000DE000000
      DE0084848400FFFFFF0010CE000010CE000010C6000084848400000000000000
      00000000000094FFFF0094FFFF0094FFFF0094FFFF0094FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EFD6C600F7F7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      E700FFF7E700FFF7E700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7D600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000EFD6C600F7F7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      E700FFF7E700FFF7E700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFE7D600FFE7D600FFE7D600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0010CE000010CE000010CE000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B21
      FF000000DE000000DE006B21FF006B21FF000000DE000000DE000000DE000000
      DE0084848400FFFFFF0010CE000010CE000010CE000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7DEC600F7FFF700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7E700FFEFE700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFE7D600FFE7D600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000F7DEC600F7FFF700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7E700FFEFE700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFE7D600FFE7D600FFD6BD00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0008D6000010D6000010CE000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B21
      FF000000DE000000DE006B21FF006B21FF000000DE000000DE000000DE000000
      DE0084848400FFFFFF0008D6000010D6000010CE00008484840000000000FF6B
      2100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7DEC600F7FFF700FFFFF700FFF7F700FFF7F700FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFE700FFEFE700FFEFE700FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFD6BD00D68C84006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000F7DEC600F7FFF700FFFFF700FFF7F700FFF7F700FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFE700FFEFE700FFEFE700FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFD6BD00D68C84006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF0008D6000008D6000010D6000084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B21FF000000DE006B21FF006B21FF000000DE000000DE000000DE000000
      DE0084848400FFFFFF0008D6000008D6000010D600008484840000000000FF6B
      2100FF6B2100FF6B2100FF6B2100BD3900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7DEC600FFFFFF00FFFFF700FFFFF700FFFFF700FFF7F700FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFE700FFEFE700FFEF
      E700FFEFE700FFEFDE00F7B5B500F7ADAD00F7A5A500FF9C9C00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000F7DEC600FFFFFF00FFFFF700FFFFF700FFFFF700FFF7F700FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7E700FFEFE700FFEFE700FFEF
      E700FFEFE700FFEFDE00F7B5B500F7ADAD00F7A5A500FF9C9C00D69484006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B21FF000000DE006B21FF006B21FF000000DE000000DE000000DE000000
      DE0084848400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000FF6B
      2100FF6B2100FF6B2100FF6B2100BD3900000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7DEC600FFFFFF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7F700FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFEFE700FFEF
      E700FFEFE700E7B59400EFA54200E7943900DE8C3100D6843100BD8C6B006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000F7DEC600FFFFFF00FFFFF700FFFFF700FFFFF700FFFFF700FFF7F700FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFEFE700FFEF
      E700FFEFE700E7B59400EFA54200E7943900DE8C3100D6843100BD8C6B006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484008484840084848400848484008484840084848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B21FF000000DE000000DE000000DE000000DE000000DE000000DE000000
      DE0084848400848484008484840084848400848484008484840000000000FF6B
      2100FF6B2100BD390000BD390000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFE7CE00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      F700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFEFE700EFC69C00FFBD6300FFAD3100FFA52100CE8C5200636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFE7CE00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFFF700FFFFF700FFFF
      F700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFEFE700EFC69C00FFBD6300FFAD3100FFA52100CE8C5200636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006B21FF006B21FF000000DE000000DE000000DE000000DE000000
      DE000000BD000000BD00000000000000000000000000FF9C6B00FF9C6B00FF9C
      6B00FF9C6B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFE7CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFF
      F700FFFFF700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      E700FFF7E700EFC6AD00FFCE8400FFB55200D69C6B0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFE7CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700FFFF
      F700FFFFF700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      E700FFF7E700EFC6AD00FFCE8400FFB55200D69C6B0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006B21FF006B21FF006B21FF006B21FF006B21
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFE7CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      F700FFFFF700FFFFF700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7E700EFD6AD00FFDE9400CE9C73006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFE7CE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFF
      F700FFFFF700FFFFF700FFF7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7E700EFD6AD00FFDE9400CE9C73006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFE7D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFF700F7F7F700F7F7
      F700F7F7F700EFF7F700EFEFEF00EFEFEF00EFEFEF00EFEFEF00E7E7E700E7E7
      E700E7E7E700EFD6B500CEAD8C00636363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFE7D600FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFF700F7F7F700F7F7
      F700F7F7F700EFF7F700EFEFEF00EFEFEF00EFEFEF00EFEFEF00E7E7E700E7E7
      E700E7E7E700EFD6B500CEAD8C00636363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFD6AD00FFDEBD00FFD6BD00FFD6B500F7D6B500F7D6B500F7D6B500EFCE
      B500EFCEAD00EFCEAD00EFC6AD00E7C6AD00E7C6AD00E7C6AD00E7C6A500DEBD
      A500DEBDA500E7C6AD00AD9C9400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFD6AD00FFDEBD00FFD6BD00FFD6B500F7D6B500F7D6B500F7D6B500EFCE
      B500EFCEAD00EFCEAD00EFC6AD00E7C6AD00E7C6AD00E7C6AD00E7C6A500DEBD
      A500DEBDA500E7C6AD00AD9C9400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006363630063636300636363006363630063636300636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000737384007B7B8C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5A7B005A5A
      7B004242630073737300000000000000000000000000000000005A5A73004242
      6B005A5A73000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      6300636363005A52520052525200313131003131310042313100524239006363
      6300636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063637B00734AA500BD73AD00C67BA500735294007373
      8C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000007B7BE7002121
      CE002121CE00212173007373730000000000000000002929C6002121D6002929
      C6005A5A73000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006363630063636300524A
      42005A5A5A008C8C8C00D6D6D60094848400846B6B00635A5200424242003129
      2900524231006363630063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063637B006B52B500A573BD00A584BD00B584B500EF94A5008463
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000737373005A5A5A005A5A5A005A5A5A005A5A5A00737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      D6002121CE002121D60018185200292931002929AD002921D6002929CE005A5A
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000063636300636363004A4A4A007B7B7B00ADAD
      AD00B5B5B500CECECE00CECECE008C8484004A4242003131310052525200846B
      6B0052525200312929004A393100636363006363630063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063637B004242C6007363D6007B7BD6002973F7000039D6009C73B500E7A5
      BD00525A840000000000000000000000000000000000737373005A5A5A005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A000073AD000073A5000073A5000073A5000073AD00006BA500424242005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A005A5A5A005A5A5A005A5A5A000000000000000000737373005A5A5A005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005252
      63002139D6002929DE002129BD002129B5002929E7002929DE0029294A005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A5A005A5A
      5A005A5A5A005A5A5A005A5A5A00000000000000000000000000000000000000
      0000000000006363630063636300525252009C9C9C00CECECE00D6D6D600C6C6
      C6009C9C9C00A5A5A500949494007B7373004A42420031313100313131003131
      3100424242007B6B63007B6B63004A4A4A003129290052423100636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005A63
      7B002131CE004A5AE7008C8CE700426BE7000029C600000894007352A500E7B5
      CE004A4A8C000000000000000000000000002121210021212100212121002121
      2100212121002121210021212100212121002121210021212100212121002121
      210010ADDE0029C6EF0029BDDE0029BDDE0029C6EF00007BAD00212121002121
      2100212121002121210021212100212121002121210021212100212121002121
      2100212121002121210042424200000000002121210021212100212121002121
      2100212121002121210021212100212121002121210021212100212121002121
      2100189CDE002942DE003131EF003131EF003131EF0010398400212121002121
      2100212121002121210021212100212121002121210021212100212121002121
      2100212121002121210042424200000000000000000000000000000000006363
      630063636300736B6B009C9C9C00D6D6D600D6D6D600CECECE00B5B5B5009494
      9400A5A5A500B5B5B500B5B5B500736B6B00424242004A4A4A005A5A5A006363
      63006B6B6B00736B6B006B6B6B007B7373008C7B7B0073737300312929004A39
      3100636363006363630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063637B000021
      DE00214AFF00A5B5FF005A7BFF005252DE003142D6003931AD009C73BD00C6AD
      DE0063638C000000000000000000000000009C9C9C00A5A5A500A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A50021ADD60073D6EF0084EFFF007BE7FF006BD6F7000884B500A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A5002121210042424200000000009C9C9C00A5A5A500A5A5A500A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A50021ADD600426BCE003131F7003931F7003131D60008314A008C8C8C00A5A5
      A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5A500A5A5
      A500A5A5A5002121210042424200000000000000000063636300636363009494
      9400BDBDBD00DEDEDE00D6D6D600C6CECE00A5A5A500A5A5A500B5B5B500B5B5
      B500B5B5B500ADADAD00A5A5A50063636300424242005252520063636300736B
      6B00737373007B7B7B0084848400949494009C9C9C009C8484009C8484009494
      9400525252004231310063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063637B000021DE001042
      FF009CB5FF00184AFF000031FF001031EF004242CE007B63D600BDADE700424A
      AD00000000000000000000000000000000009C9C9C00FFF7DE00FFF7DE00FFF7
      DE00FFF7E700FFF7E700FFF7DE00FFF7DE00FFF7DE00FFF7E700FFF7E700FFF7
      E70031ADD600BDE7EF00CEF7FF00C6F7FF00ADE7F700188CBD00FFF7DE00FFF7
      DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7
      DE00FFF7DE00212121005A5A5A00000000009C9C9C00FFF7DE00FFF7DE00FFF7
      DE00FFF7E700FFF7E700FFF7DE00FFF7DE00FFF7DE00FFF7E700FFF7E700FFF7
      E700297BB5004242F7005A5AFF004A4AFF003939FF0021299C00736B6300DED6
      C600FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7DE00FFF7
      DE00FFF7DE00212121005A5A5A00000000006363630094949C00CECECE00DEDE
      DE00CECECE00B5B5B500A59C9C00B5B5B500BDBDB500B5B5B500B5B5B500ADAD
      AD00A5A5A500ADADAD00CECECE00949494005A5A5A00424242004A4A4A006363
      6300737373007B7B7B00848484009494940094949400A59C9C00AD848400EFC6
      C600FFC6C600ADA59C0052423100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000063637B000021DE001042FF009CB5
      FF00184AFF000031FF000031FF000018D6002939CE00A5A5EF00394ABD000000
      0000000000000000000000000000000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C004AB5DE00DEEFEF00FFFFFF00FFFFFF00D6EFF7001094BD009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C0000000000000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C007B7B
      84003942F7005252FF006B6BE7008484E7005A5AFF004242FF0029297B005252
      52008C8C8C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C009C9C9C00000000000000000094949C0094949400C6C6C600ADAD
      AD00A5A5A500BDBDBD00BDBDB500B5B5B500B5B5B500ADADAD00ADADAD00C6C6
      C600EFEFEF00DEDEDE00B5B5B50094949400CECECE00C6C6C6008C8C8C005252
      5200424242005A5A5A007B7B7B00949494009C9C9C00B59C9C00AD8C8C00D6AD
      AD00DEBDBD00CEA5A5004A423900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000063637B000021DE001042FF00A5B5FF00184A
      FF000031FF000031FF000018D6001029D600949CF700314ABD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000021A5D60042B5DE004AB5DE0031ADD60029ADD60042ADD600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005A5A
      E7006B6BFF006363F7003173A50031ADD600527BF7006363FF006363F7004A4A
      7B00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000094949400A5A5A500BDBDB500BDBD
      BD00B5B5B500B5B5B500ADADAD00ADADAD00BDBDBD00E7E7E700EFEFEF00E7E7
      E700DEDEDE00D6D6D600C6C6C600BDBDBD00BDBDBD00C6C6C600C6C6C600CECE
      CE00BDBDBD0094949400525252004A4A4A006B6B6B00A58C8C00AD848400CEAD
      AD00D6B5B500BD9C9C004A393100000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063637B000021DE000839FF0094ADFF00214AFF000031
      FF000031FF000018D6000829DE007B94FF002142C60073737B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009C9C9C00FFF7E700A5A5A5002121210052525200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A5AFF005A5A
      FF007B7BFF006B6BA500FFEFDE00A5A5A500212139005252CE006B6BFF007373
      F700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A500BDBDBD00B5B5B500B5B5
      B500ADADAD00B5B5B500D6D6D600EFEFEF00EFEFEF00EFEFEF00E7E7E700D6D6
      D600C6C6C600B5B5B5005A42420052423100524239007B6B63008C8484009C94
      9400A5A5A500A5A5A500BDB5B500B5B5B5007B7B7B005A5A5A0052525200AD9C
      9C00D6C6C600C6B5B500524A4200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063637B000021DE000839FF0094ADFF002152FF000031FF000031
      FF000018D6000021DE007B94FF001839C600A5A5AD00FFF7F700C6C6C6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000094949400EFDECE00848484001818180042424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000094949400EFDECE00848484001818180042424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A500B5B5B500B5B5B500C6CE
      CE00DEDEDE00DEDEDE00DEDEDE00DEE7E700DEDEDE00CECECE00CECECE00DEDE
      DE00E7E7E700946363005A4242005A424200423131004A39310052423100635A
      52008C848400CECECE00E7DEDE00DEDEDE00DEC6C600DEC6C600B5B5B5009494
      94002952FF00FFFFFF0052393900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063637B000021DE000839FF0094ADFF00214AFF000031FF000031FF000018
      D6000829DE00738CFF002142C600A5A5A500F7F7EF00FFF7F700FFF7F7009494
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006B6B6B007B736B00313131001010100018181800636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006B6B6B007B736B00313131001010100018181800636363007373
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A500CECECE007B7B7B00635A
      5200524239004A4A4A004A4A4A005A5A5A00848484009C9C9C00ADADAD00C6C6
      C600CECECE00FF9C9C00C6636300AD52520094848400ADADAD00736B6B005242
      31004A393100524231007B6B6300EFEFEF00CECECE00D6ADAD009C9494007373
      7300DEDEFF00214AFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      7B000039D600084AFF0094ADFF002152FF000031FF000031FF000018D6000829
      DE00738CFF002142CE00ADA5AD00F7EFEF00F7EFEF00F7F7EF00C6BDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A5A5A004A4A4A008C8C8C00A59C9C008C7B7B004A4A4A00393939004A4A
      4A005A5A5A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      73005A5A5A004A4A4A008C8C8C00A59C9C008C7B7B004A4A4A00393939004A4A
      4A005A5A5A007373730000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A5009C9C9C00A5A5A500BD7B
      7B0084736B00CE8C8C00CEB5B500B58C8C007B635A005252520052525200736B
      6B008C8C8C00CE8C8C00C6636300AD5A5A00BDA5A500F7F7F700EFD6D600D6D6
      D600A5A5A5006B5A5200C6B5B5009CADFF009C949400423131006B5A5A00B5B5
      B500DEDEFF002952FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000063637B00005A
      D6000873FF0094B5FF002152FF000031FF000031FF000018D6000829DE007B94
      FF001842CE007B7B8400E7D6D600F7EFE700F7EFEF00F7EFEF00E7E7E700A5A5
      A500E7E7E700D6CECE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000525252006363
      630094949400DEDEDE00D6D6D600ADA5A5007B6B6B00524A4A007B6B6B006B5A
      5A00424242004242420052525200737373000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073737300525252006363
      630094949400DEDEDE00DEDEDE00ADA5A5007B6B6B00524A4A007B6B6B006B5A
      5A00424242004242420052525200737373000000000000000000000000000000
      000000000000000000000000000000000000000000007B7B7B00DEDEDE00C67B
      7B00B57B7B00C67B7B00D6C6C600C6949400BD949400A57B7B00CEA5A500AD94
      94007B6B6B00CE8C8C00C6636300B55A5A009C848400CE949400D66B6B00F7E7
      E700F7F7F700EFE7E7009CADFF00214AFF00D6D6D600A5949400BDA5A500F7F7
      F7001042FF002952FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063637B000073D600089C
      FF009CC6FF002152FF000031FF000031FF000018D6000829DE007B94FF002142
      CE000000000000000000000000008C8C8400D6CECE00F7EFEF00F7F7EF00F7F7
      EF00FFF7F700FFF7F700948C8C00000000000000000000000000000000000000
      000000000000000000000000000073737300525252007B7B7B00CECECE00DEDE
      DE0042424200BDBDBD0084848400736B6B006B63630031313100313131003131
      3100736363006B5A5A006B636300393939004A4A4A005A5A5A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000073737300525252007B7B7B00CECECE00DEDE
      DE0042424200BDBDBD0084848400736B6B006B63630031313100313131003131
      3100736363006B5A5A006B636300393939004A4A4A005A5A5A00737373000000
      0000000000000000000000000000000000000000000084848400DEDEDE00C67B
      7B00C67B7B00C67B7B00CE9C9C0084737300A57B7B00CE949400CE9C9C00CE9C
      9C00D6ADAD00CE8C8C00C6636300BD5252009C848400B57B7B00AD424200EFC6
      C600FFFFFF009CADFF000039FF00214AFF00214AFF00214AFF00214AFF000031
      FF000031FF00214AFF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000002942840008B5FF0094CE
      FF002952FF000031FF000031FF000018D6000829DE007B94FF002142CE000000
      00000000000000000000000000000000000000000000D6CECE00F7EFE700F7EF
      EF00F7F7EF00CEC6C60000000000000000000000000000000000000000000000
      000000000000636363005A5A5A00A5A5A500D6D6D600DEDEDE00D6D6D6009C9C
      9C00636363006B6B6B0094949400A59C9C00635A5A004A4A4A00636363006B6B
      6B006B6B6B006B6B6B006B6363008C7B7B006B5A5A00524A4A00424242005252
      5200737373000000000000000000000000000000000000000000000000000000
      000000000000636363005A5A5A00A5A5A500D6D6D600DEDEDE00D6D6D6009C9C
      9C00636363006B6B6B0094949400A59C9C00635A5A004A4A4A00636363006B6B
      6B006B6B6B006B6B6B006B6363008C7B7B006B5A5A00524A4A00424242005252
      5200737373000000000000000000000000000000000084848400DEDEDE00C67B
      7B00C67B7B00A57B7B00C6949400BD949400AD8C8C008C7B7B00847373008C7B
      7B00BD949400CE8C8C00C6636300AD5A5A00B59C9C00B58C8C00AD424200D6AD
      AD009CADFF000031FF000031FF000031FF000031FF000031FF000031FF000031
      FF00214AFF000000000000000000000000000000000000000000000000007B7B
      7B007B7B7B009C9C9C009C9C9C009494940073737B00B5B5B5007384C6002952
      FF000031FF000031FF000018D6000042D6007BADFF002142CE00000000000000
      000000000000000000000000000000000000000000008C8C8400F7EFE700F7EF
      EF00E7DEDE009494940000000000000000000000000000000000000000005A5A
      5A007B7B7B00BDBDBD00DEDEDE00D6D6D600BDBDBD007B7B7B00636363009494
      9400B5B5B500B5B5B500ADADAD008C8C8C00525252004A4A4A00636363006B6B
      6B00737373007B7B7B00848484007B7B7B004A4A4A007B6B6B00846B6B007363
      6300424242004A4A4A0063636300000000000000000000000000737373005A5A
      5A007B7B7B00BDBDBD00DEDEDE00DEDEDE00BDBDBD007B7B7B00636363009494
      9400B5B5B500B5B5B500ADADAD008C8C8C00525252004A4A4A00636363006B6B
      6B00737373007B7B7B00848484007B7B7B004A4A4A007B6B6B00846B6B007363
      6300424242004A4A4A0063636300000000000000000084848400DEDEDE00C67B
      7B00A5737300C6949400BD949400B59C9C00AD949400A57B7B00A5737300C67B
      7B00B57B7B00CE8C8C00C6636300AD525200CEB5B500CE9C9C0094292900AD8C
      8C00E7E7E7009CADFF00214AFF00214AFF007B9CFF007B9CFF007B9CFF007B9C
      FF0000000000000000000000000000000000000000000000000073737B009C9C
      9C00A5A5A500A5A5A500B5B5B500CECECE00BDBDBD00ADADAD009C9C9C004A5A
      C6000031FF000018D6000052D60073B5FF002152CE0000000000000000000000
      0000000000000000000000000000000000000000000000000000CEC6BD00F7EF
      E700F7EFE700B5B5B5009C9C9C009494940000000000848484009C9C9C00CECE
      CE00DEDEDE00C6C6C6009C9C9C006B6B6B007B7B7B00ADADAD00BDBDBD00B5B5
      B500ADADAD00A5A5A500B5B5B500A5A5A500525252004A4A4A00636363006B6B
      6B00737373007B7B7B008484840073737300313131003131310042424200BD9C
      9C00EFBDBD00B5949400424242007373730000000000848484009C9C9C00CECE
      CE00DEDEDE00C6C6C6009C9C9C006B6B6B007B7B7B00ADADAD00BDBDBD00B5B5
      B500ADADAD00ADADAD00B5B5B500A5A5A500525252004A4A4A00636363006B6B
      6B00737373007B7B7B008484840073737300313131003131310042424200BD9C
      9C00EFBDBD00B594940042424200000000000000000084848400DEDEDE00C67B
      7B00846B6B00BD949400846B6B007B635A00A57B7B00AD8C8C008C7B7B00C67B
      7B0094737300CE8C8C00C6636300B5525200C6A5A500E7B5B500AD424200A57B
      7B00ADADAD00EFEFEF009CADFF000031FF00E7D6D600DEB5B500DEADAD009C94
      9400000000000000000000000000000000000000000073737B0094949400A5A5
      A500A5A5A500A5A5A500B5B5B500CECECE00BDBDBD00BDBDBD009C9C9C009494
      9400394AB5000063D60073CEFF00215ACE007B7B7B0000000000000000000000
      0000000000000000000000000000000000000000000000000000ADA5A500EFE7
      E700F7EFE700F7EFEF00F7EFEF0094949400B5B5B500C6C6C60094949400ADAD
      AD00848484007B7B7B009C9C9C00BDBDBD00B5B5B500B5B5B500ADADAD00B5B5
      B500D6D6D600EFEFEF00DEDEDE0084848400CECECE00ADADAD00848484006363
      6300636363007B7B7B008484840073737300313131003131310031313100AD94
      9400E7B5B500EFBDBD00424242007373730073737300C6C6C60094949400ADAD
      AD00848484007B7B7B009C9C9C00BDBDBD00B5B5B500B5B5B500ADADAD00B5B5
      B500D6D6D600EFEFEF00DEDEDE0084848400CECECE00ADADAD00848484006363
      6300636363007B7B7B008484840073737300313131003131310031313100AD94
      9400E7B5B500EFBDBD0042424200000000000000000084848400DEDEDE00C68C
      8C00846B6B00AD8C8C0084736B005A42420084736B00A59C9C00847373008473
      7300BD949400CE9C9C00C6636300AD5252009C848400D6D6D600EFD6D600DEDE
      DE00BDBDBD00B5B5B500F7F7F7009CADFF00BDA5A500CE636300AD5A5A005242
      310000000000000000000000000000000000000000008C8C8C009C9C9C009C9C
      9C009C9C9C00A5A5A500ADADAD00CECECE00BDBDBD00BDBDBD00CECECE008484
      8400A5A5A500427BC6001863CE00AD737B00948C8C0000000000000000000000
      0000000000000000000000000000000000000000000000000000ADA5A500EFE7
      DE00EFE7E700F7EFE700F7EFEF008C8C8C00ADADAD00949494007B7B7B009494
      9400BDBDBD00BDBDBD00B5B5B500ADADAD00B5B5B500C6C6C600E7E7E700EFEF
      EF00E7E7E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00D6D6D600D6D6D600D6D6
      D600B5B5B5008C8C8C006B6B6B00636363004A4A4A0039393900313131009C84
      8400C6A5A500D6B5B5004242420073737300ADADAD00949494007B7B7B009494
      9400BDBDBD00BDBDBD00B5B5B500ADADAD00B5B5B500C6C6C600E7E7E700EFEF
      EF00E7E7E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00D6D6D600D6D6D600D6D6
      D600B5B5B5008C8C8C006B6B6B00636363004A4A4A0039393900313131009C84
      8400C6A5A500D6B5B50042424200000000000000000084848400DEDEDE00CE94
      94008C7B7B00A58484009C848400A5949400B59C9C007B7373007B6B6B007B6B
      6B00C68C8C00CE9C9C00B55A5A00CE636300A55A5A008C636300A57B7B00AD9C
      9C009C9C9C0094949400ADADAD00F7E7E700BDA5A500CE636300B55A5A005242
      3100000000000000000000000000000000007B7B7B00ADADAD00A5A5A5009C9C
      9C00C6C6C600BDBDBD00ADADAD00CECECE00B5B5B500C6C6C600D6D6D600B5B5
      B500949494006B525200AD737B00F79C9C009473730000000000000000000000
      0000000000000000000000000000000000000000000000000000D6C6BD00EFDE
      DE00EFDEDE008C8C8C00948C8C0000000000ADADAD00B5B5B500BDBDBD00BDBD
      BD00B5B5B500B5B5B500C6C6C600DEDEDE00EFEFEF00EFEFEF00E7E7E700E7E7
      E700D6D6D600CECECE00C6C6C600CECECE00CECECE00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00ADADAD00C6BDBD00B5ADAD008C8484007B7373006B5A5A00847B
      7B00AD949400BD9C9C004242420073737300ADADAD00B5B5B500BDBDBD00BDBD
      BD00B5B5B500B5B5B500C6C6C600DEDEDE00EFEFEF00EFEFEF00EFEFEF00E7E7
      E700D6D6D600CECECE00C6C6C600CECECE00CECECE00BDBDBD00BDBDBD00BDBD
      BD00BDBDBD00ADADAD00C6BDBD00B5ADAD008C8484007B7373006B5A5A00847B
      7B00AD949400BD9C9C0042424200000000000000000084848400DEDEDE00CE9C
      9C00CE9C9C00847373008C7B7B00847373007B6B6B006B6B6B00AD8C8C007B6B
      6B00AD848400CE9C9C00BD525200CE636300C6636300BD525200C6636300B552
      5200A55A5A009C5A5A008C5252008C525200734A4A00C6636300AD5A5A005242
      3100000000000000000000000000000000007B7B7B00B5B5B500ADADAD00CECE
      CE00949494008C8C8C00BDBDBD00CECECE00B5B5B500C6C6C600D6D6D600ADAD
      AD00ADADAD0084636300EF9C9C00F79C9C00CE84840000000000000000000000
      000000000000000000000000000000000000000000008C848400FFCECE00EFDE
      D600DED6CE008C8484000000000000000000ADADAD00B5B5B500B5B5B500C6C6
      C600D6D6D600E7E7E700DEDEDE00E7E7E700E7E7E700DEDEDE00CECECE00D6D6
      D600E7E7E700F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7E700DEDE
      DE00EFEFEF00F7F7F700FFFFFF00E7E7E700E7CECE00E7CECE00BDB5B500ADAD
      AD009C8C8C00A58C8C004A4A4A0073737300ADADAD00B5B5B500B5B5B500C6C6
      C600D6D6D600E7E7E700DEDEDE00E7E7E700E7E7E700DEDEDE00CECECE00D6D6
      D600E7E7E700F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7E700DEDE
      DE00EFEFEF00F7F7F700FFFFFF00E7E7E700E7CECE00E7CECE00BDB5B500ADAD
      AD009C8C8C00A58C8C004A4A4A00000000000000000084848400DEDEDE00D6AD
      AD00BD9C9C00CEADAD009C8C8C00847373007B737300B59C9C00CEADAD00BDA5
      A5007B737300CE9C9C00CE636300AD5252008C636300A57B7B0094636300AD52
      5200AD525200BD525200C6636300B55A5A00C6636300CE636300B55A5A005242
      3100000000000000000000000000000000007B7B7B00BDBDBD00D6D6D6009C9C
      9C00000000000000000000000000B5B5B500B5B5B500C6C6C600DEDEDE00ADAD
      AD00BDBDBD0094737300E79C9C00E79C9C00F79C9C00AD7B7B00000000000000
      0000000000000000000000000000000000008C848400EFB5B500FFC6C600FFCE
      CE00EFDED600DED6CE008484840000000000B5B5B500CECECE00E7E7E700E7E7
      E700E7E7E700D6D6D600A5A5A500CECECE00EFEFEF00EFEFEF00DEDEDE00E7E7
      E700EFEFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7E700DEDE
      DE00EFEFEF00F7F7F700FFFFFF00F7F7F700EFEFEF00EFD6D600DED6D6008484
      84009C9C9C008C8C8C008C8C8C0000000000B5B5B500CECECE00E7E7E700E7E7
      E700EFEFEF00D6D6D600A5A5A500CECECE00EFEFEF00EFEFEF00DEDEDE00E7E7
      E700EFEFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7E700DEDE
      DE00EFEFEF00F7F7F700FFFFFF00F7F7F700EFEFEF00EFD6D600DED6D6008484
      84009C9C9C008C8C8C000000000000000000000000008C8C8C00949494009494
      9400C6B5B500CEB5B500CEBDBD00DEBDBD00CEBDBD00DEBDBD00D6B5B500CEBD
      BD00C6A5A500CE9C9C00C6636300944A4A00AD9C9C00E7E7E700D6D6D600C6CE
      CE00BDB5B500B59C9C00A57373009C5A5A00AD525200CE636300AD5A5A005242
      3100000000000000000000000000000000007B7B7B00DEDEDE00A5A5A5000000
      000000000000000000000000000094949400ADADAD00C6C6C600DEDEDE00A5A5
      A500B5B5B5008C848400DE9C9C00E79C9C00EF9C9C00EF9C9C00C68484008C7B
      7B000000000000000000949494009C7B7B00F7ADAD00FFB5B500FFBDBD00FFC6
      C600FFCECE00EFDED6008C8484000000000000000000B5B5B500BDBDBD00C6C6
      C600F7F7F700A5A5A50073737300424242004A4A4A0073737300ADADAD00DEDE
      DE00EFEFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7E700DEDE
      DE00EFEFEF00F7F7F700FFFFFF00F7F7F700E7E7E700B5ADAD009C9C9C008C8C
      8C000000000000000000000000000000000000000000B5B5B500BDBDBD00C6C6
      C600F7F7F700A5A5A50073737300424242004A4A4A0073737300ADADAD00DEDE
      DE00EFEFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7E700DEDE
      DE00EFEFEF00F7F7F700FFFFFF00F7F7F700EFEFEF00B5ADAD009C9C9C00A5A5
      A500000000000000000000000000000000000000000000000000525A5A004A4A
      4A0052525200636363006B6B6B007B7B7B0094949400ADA59C00C6BDBD00D6C6
      C600DEC6C600CEA5A500C66363009C525200B59C9C00D6D6D600CECECE00DEDE
      DE00E7E7E700DEE7E700E7E7E700D6D6D600846B6B00C6636300B55A5A005242
      3100000000000000000000000000000000008C8C8C00A5A5A500000000000000
      0000000000000000000000000000000000008C8C8C00C6C6C600E7E7E700A5A5
      A500BDBDBD007B7373008C737300846B6B00E79C9C00EF9C9C00F79C9C00F79C
      9C00F7949400F7949400FF9C9C00FFA5A500FFADAD00FFB5B500D69C9C008C7B
      7B00B5949400BD9C9C0000000000000000000000000000000000000000000000
      0000B5B5B500B5B5B500B5B5B500D6D6D600C6C6C6008C8C8C00ADADAD00DEDE
      DE00EFEFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7E700DEDE
      DE00EFEFEF00DEDEDE00BDBDBD00B5B5B500B5B5B50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5B5B500B5B5B500B5B5B500D6D6D600C6C6C6008C8C8C00ADADAD00DEDE
      DE00EFEFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700EFEFEF00E7E7E700DEDE
      DE00EFEFEF00DEDEDE00BDBDBD00B5B5B500B5B5B50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006B6B6B006B6B6B005A5A5A004A4A4A00525252005A5A5A006363
      6300736B6B00CEA5A500BD5252009C525200B59C9C00CECECE00C6C6C600C6C6
      C600C6C6C600CECECE00CECECE00F7F7F70094848400C6636300AD5A5A005242
      3100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000009C9C9C00BDBDBD00C6C6C600E7E7E700A5A5
      A500C6C6C60000000000000000008C7B7B00DE9C9C00E79C9C00EF9C9C00F79C
      9C00F79C9C00FF9C9C00FF9C9C00FF9C9C00FFA5A500FFADAD00D69C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5B5B500B5B5B500B5B5B500CECE
      CE00EFEFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700E7E7E700B5B5B500A5A5
      A500ADADAD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5B5B500B5B5B500B5B5B500CECE
      CE00EFEFEF00F7F7F700FFFFFF00FFFFFF00F7F7F700E7E7E700B5B5B500A5A5
      A500ADADAD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B6B
      6B005A5A5A00CEA5A500C6636300AD525200A5949400CECECE00C6C6C600C6C6
      C600CECECE00C6CECE00C6C6C600E7E7E7008C7B7B00BD525200B55A5A005242
      3100000000000000000000000000000000000000000000000000000000000000
      000000000000000000008C8C8C00EFEFEF00BDBDBD00CECECE00EFEFEF00CECE
      CE008484840000000000000000009C7B7B00D69C9C00DE9C9C00B57B7B00AD7B
      7B00EF9C9C00F7949400EF9494009C6B6B00F79C9C00FFA5A500FFADAD009484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5B5B500B5B5B500BDBDBD00BDBDBD00B5B5B500B5B5B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5B5B500B5B5B500BDBDBD00BDBDBD00B5B5B500B5B5B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEADAD00BD525200944A4A00AD8C8C00DEDEDE00C6C6C600CEC6
      C600C6CECE00C6CECE00C6C6C600EFEFEF008C7B7B00C6636300B55A5A005242
      3100000000000000000000000000000000000000000000000000000000000000
      00000000000084848400C6C6C600FFFFF700CECECE00D6D6D600C6C6C6008C8C
      8C0000000000000000000000000084737300B5848400B5848400000000008C84
      8400EF9C9C00F79C9C00BD7B7B000000000094737300FF9C9C00B57B7B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEADAD00C67B7B00B5737300AD9C9C00DEDEDE00DEDEDE00E7E7
      E700E7E7E700DEDEDE00DEDEDE00F7F7F7008C7B7B00C6636300AD5A5A005242
      3900000000000000000000000000000000000000000000000000000000000000
      00007B7B7B00CECECE00D6D6D600D6D6D600ADADAD008C8C8C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D69C9C00EF9C9C009C7373000000000000000000948C8C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ADADAD00ADADAD00ADAD
      AD00ADADAD00ADADAD00ADADAD00ADADAD009C848400C6636300B55A5A007B63
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BDA5A500BDA5A500949494000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007373730073737300737373007373730073737300737373007373
      7300737373007373730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000031108C002110C600292173002921730000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000636363003939390042312900423931005A4A4200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373007373
      73007B6B6B007B6B6B008C4242008C4239008C3939008C3939008C4239007342
      39006B4A42007B6B6B0073737300737373000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000003110
      8C002110C6002100E7002900DE00292173001031B50029217300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006363
      6300524A42006B6B6B00CECECE00A58C8C006B6363004A4A4A00635A52005242
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000073737300737373008C636300BD52
      5200CE636300CE7B7B00D69C9400E7A5A500F7949400EF8C8C00D6848400CE6B
      6B00CE5A6300B53942008C393900634239007373730073737300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000031108C002110C6002100
      E7002900E7002900E7002100DE00292173001810C6001821A500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063636300635A52008484
      8400CECECE00D6D6D600CECECE00A58C8C0031313100524A4A006B6363006352
      52004A4A4A004239310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000737373008C6B6B00CE6B6B00D69C9400F7C6
      BD00FFBDBD00FFB5B500FFADAD00FFADA500FFA5A500FFA59C00FF9C9C00FF94
      9400F7949400EF848400CE636300B55252008C39390063423900737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000031108C002110C6002100E7002900E7002900
      E7002900E7002100E7002110C600292173002908D6001818B5007B0073007B00
      73007B0073007B00730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000006363630084737300BDBDBD00D6D6D6008C8C
      8C00B5B5B500B5B5B5009C9C9C00947B7B003131310031313100313131003931
      31007363630073636300524A4A00423129005242390000000000000000000000
      000000000000000000000000000000000000000000006B6B6B006B6B6B008C52
      31008442290084422900844229008442290084422900844229006B4A31006B52
      4A006B635A006B6B6B006B6B6B006B6B6B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000073737300A5737300D69C9400F7CEC600FFC6BD00FFBD
      BD00FFBDB500FFB5B500FFADAD00FFB5AD00FFADAD00FFA5A500FF9C9C00FF94
      9400F78C8C00EF8C8C00E7848400E77B7B00CE636300BD5A5A00633931007373
      7300000000000000000000000000000000000000000000000000000000000000
      00000000000031108C002118B5002100E7002900E7002900E7002900E7001800
      E7002108D60042299C009C632100C694000094734A0042299C00DE00EF00FF00
      FF00E700EF00CE00DE007B007300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000063636300636363007B7B7B00CECECE00D6D6D600CECECE00CECECE009C9C
      9C009C9C9C00B5B5B500B5B5B5008473730039313100424A4A00524A4A00524A
      4A005A5252005A5A5A005A5A5A00947B7B0073636300393129004A3129000000
      00000000000000000000000000000000000000000000B5523100C6421000D64A
      2100DE523100E75A3900EF5A4200FF635200FF635200FF635200CE4A2100D64A
      2100D64A2100A53918007B4221006B524A006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B006B6B
      6B006B6B6B006B6B6B0000000000000000000000000000000000000000000000
      00000000000073737300B59C9C00EFB5B500F7CEC600FFCEC600FFC6BD00FFC6
      BD00FFC6C600F7CEC600F7D6CE00F7D6CE00F7DED600F7DED600F7DED600F7D6
      CE00F7B5B500EFADA500E7848400DE7B7B00DE737300C6636300BD5A5A006339
      3100737373000000000000000000000000000000000000000000000000003110
      8C002118B5002108E7002900E7002900E7002100E7001800E7002100D6006B00
      94009C393900CE9C0000D6A50000C68C0000D6AD0800DE4A0000FF00FF00FF00
      FF00D600DE00CE00DE007B007300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000636363006363
      63009C9C9C00D6D6D600D6D6D600CECECE00B5B5B5009C9C9C00ADADAD00BDBD
      BD00B5B5B500ADADAD009C9C9C006B6B6B00393131005A5A5A006B6B6B007373
      73007B7B7B00848484008C848400949494008C8484009C848400A58C8C005242
      39004231290000000000000000000000000000000000C6421000D64A2100DE52
      3100EF5A4200FF635200FF6B5200FF735A00FF735A00F76B4A00D68C5200CE5A
      2900FF635200FF635200E75A3900C64210006B4A31002163210021632100186B
      18001873180021942100188C1800188C1800188C1800108C100018731800186B
      1800315A39006B6B6B006B6B6B00000000000000000000000000000000000000
      000073737300AD848C00EFC6BD00F7D6CE00FFCEC600FFC6C600FFCEC600FFCE
      C600FFCEC600F7CEC600F7CEC600F7D6CE00F7D6CE00F7D6CE00F7D6CE00F7D6
      CE00F7DED600F7DED600F7DED600F7C6BD00D6848400CE6B6B00C65A5A00BD42
      4A00737373007373730000000000000000000000000031108C002118B5002108
      DE002900E7002900E7002100E7001800E7002100DE0052089C00B5104A00FF10
      000073420000D6AD0000D6A50000C68C0000CEA50800DE4A0000FF00FF00F700
      FF00D600DE00C600CE007B007300000000000000000000000000000000000000
      0000000000000000000000000000000000006363630063636300BDBDBD00D6D6
      D600D6D6D600C6C6C600A5A5A500A59C9C00BDBDBD00B5B5B500B5B5B500ADAD
      AD00A5A5A500ADADAD00BDBDBD0063636300424242004A4A4A00636363006B6B
      6B007B7B7B00848484008C848400949494009C9C9C00B59C9C00947B7B00F7C6
      C600D6B5B5005A4A4200000000000000000000000000C6421000DE523100EF5A
      4200FF635200FF735A00FF7B6300FF7B6300FF846B00C6522900FFE7B500D68C
      5200F76B5200FF6B5200FF635200EF5A42009C5A180042B542004AC64A00299C
      29002194210052C6520052C652004ABD4A0042BD420039B5390029AD290029AD
      290008840800187318006B6B6B00000000000000000000000000000000000000
      0000A57B8400EFB5B500F7D6CE00FFC6BD00FFBDBD00FFC6BD00FFC6BD00FFC6
      BD00FFC6BD00FFC6C600FFCEC600FFCEC600FFCEC600F7CEC600F7CEC600F7D6
      CE00F7D6CE00F7D6CE00F7D6CE00F7D6CE00F7DED600E7ADA500C6636300BD52
      52009C3939007373730000000000000000001818B5002108D6002900E7002900
      E7002900DE002100DE002900D6005208AD00B5104A00FF210000FF100000FF21
      000073420000D6B50000D6A50000C68C0000CEA50800DE4A0000FF00FF00FF00
      FF00CE00DE00B500C6007B007300000000000000000000000000000000000000
      0000000000000000000000000000000000009494940094949400D6D6D600B5B5
      B500A5A5A500B5B5B500BDBDBD00B5B5B500B5B5B500ADADAD00ADADAD00BDBD
      BD00E7E7E700EFEFEF00ADADAD00BDBDBD00C6C6C6008C8C8C005A525200424A
      4A005A5A5A007B7B7B008C8484008C8C8C00A59C9C00B59C9C00947B7B00D6B5
      B500E7BDBD0084737300000000000000000000000000C6522900E75A3900FF63
      5200FF735A00FF7B6300FF846B00FF8C6B00D6633100EFBD8C00FFE7B500EFBD
      8C00E7634200FF7B6300FF6B5200FF635200AD63290052C652005AC65A0073AD
      5A0084AD63004AB54A0063CE63005AC65A0052C6520042BD420039B5390029AD
      290018941800187318006B6B6B00000000000000000000000000000000007373
      7300AD8C8C00F7DED600FFBDBD00FFB5B500FFB5B500FFB5B500FFBDB500FFBD
      B500FFBDBD00FFC6BD00FFC6BD00FFC6BD00FFC6BD00FFC6C600FFCEC600FFCE
      C600FFCEC600F7CEC600F7CEC600F7D6CE00F7D6CE00F7D6CE00E7ADA500BD5A
      5A00B54A4A006342390073737300000000001821BD002900DE002900DE002900
      DE002900DE002900DE00B5104A00F7310800FF310000FF310000FF4A0000FF4A
      000073420000DEC60000D6A50000BD7B0000CE9C0000DE4A0000FF00FF00FF00
      FF00C600CE00A500BD007B007300000000000000000000000000000000000000
      0000000000000000000000000000000000008C8C8C00ADADAD00B5B5B500BDBD
      BD00BDBDBD00B5B5B500ADADAD00ADADAD00B5B5B500D6D6D600EFEFEF00E7E7
      E700DEDEDE00DEDEDE00D6D6D600D6D6D600CECECE00CECECE00CECECE00BDBD
      BD00949494005A5A5A004A4A4A006B6B6B008C8C8C00B59C9C00947B7B00C6A5
      A500D6B5B500736B6B00000000000000000000000000CE5A2900E75A3900FF6B
      5A00FF7B6300FF846B00FF947300EF845A00D68C5200FFDEA500FFDEA500FFDE
      A500D65A3100FF846B00FF735A00FF635200AD6329006BCE6B0042A54200BDDE
      AD00FFF7EF004A9C420073D673006BCE6B0063CE630052C6520042BD420039B5
      390018941800187318006B6B6B0000000000000000000000000000000000AD8C
      8C00EFC6BD00FFBDB500FFADAD00FFADAD00FFADAD00FFB5AD00FFB5AD00FFB5
      B500FFB5B500FFB5B500FFBDB500FFBDB500FFBDBD00FFBDBD00FFC6BD00FFC6
      BD00FFC6BD00FFC6C600FFCEC600FFCEC600FFCEC600F7CEC600F7CEC600E7A5
      A500B54A4A008C39390073737300000000001821BD002900E7002900DE002900
      D6002100E7003100D600F7310800FF4A0000FF4A0000F7630000F75A0000F75A
      000073420000E7DE0000CE9C0000BD7B0000CE9C0000DE4A0000FF00FF00EF00
      F700B500BD009C00B5007B0073000000000000000000DE4A0000DE4A0000DE4A
      0000DE4A0000DE4A0000000000000000000094949400BDBDBD00BDBDBD00B5B5
      B500ADADAD00B5B5B500CECECE00EFEFEF00EFEFEF00EFEFEF00E7E7E700DEDE
      DE00CECECE00C6C6C600ADADAD00A5A5A5009C9C9C008C8C8C008C8484009494
      9400ADADAD00BDBDBD00B5B5B500847B7B0052525200524A52006B5A5A00B594
      9400BD9C9C006B63630000000000000000000000000000000000CE5A2900EF73
      5200FF7B6300FF8C6B00FF946B00CE5A2900FFCE9C00FFCE9C00FFCE9C00FFCE
      9C00D6734200FF8C6B00FF7B6300F76B4A00947B310073D67300399C3900FFFF
      F700FFFFF700CEE7C600399C39007BD67B006BD66B0063CE63004AC64A0039B5
      3900187318006B6B6B000000000000000000000000000000000000000000AD8C
      8C00F7D6CE00FFA5A500FFA5A500FFA5A500FFADA500FFADA500FFADAD00FFAD
      AD00FFADAD00FFB5AD00FFB5AD00FFB5B500FFB5B500FFB5B500FFBDB500FFBD
      B500FFBDBD00FFBDBD00FFC6BD00FFC6BD00FFC6BD00FFC6C600FFCEC600FFCE
      C600D6949400AD424200844A4A00737373001821BD002900E7002900DE002900
      DE002100E7003100D600EF4A0800F7630000F7630000F77B0000F77B0000F77B
      000073420000D6AD0000CE9C0000C68C0000C68C0000DE4A0000EF00F700D608
      DE009C00B5009400AD007B00730000000000DEBD0000EFBD0000EFBD0000EFBD
      0000EFBD0000D69C000094420800A563080094949400B5B5B500ADADAD00C6C6
      C600E7E7E700EFEFEF00EFEFEF00EFEFEF00E7E7E700D6D6D600C6C6C600CECE
      CE00D6D6D600D6D6D600CECECE00B5B5B500949494007B7B7B007B7B7B009C9C
      9C00CECECE00E7E7E700EFEFEF00D6D6D600E7BDBD00BDBDBD008C848400847B
      7B00A58C8C00635A52000000000000000000000000000000000000000000D663
      3100EF735200FF8C6B00CE5A2900EF9C7B00BD8C8400BD8C8400EFBD8C00FFBD
      9400D6734200FF8C7300FF7B5A00B54218007BCE6B007BD67B006BAD6300FFFF
      FF00FFFFFF00FFFFFF0084B5840063C663007BD67B006BCE6B005AC65A00299C
      290018731800000000000000000000000000000000000000000000000000AD8C
      8C00FFB5AD00FF9C9C00FF9C9C00FFA59C00FFA5A500FFA5A500FFA5A500FFA5
      A500FFADA500FFADA500FFADAD00FFADAD00FFADAD00FFB5AD00FFB5AD00FFB5
      B500FFB5B500FFB5B500FFBDB500FFBDB500FFBDBD00FFBDBD00FFC6BD00FFC6
      BD00FFADA500B55252006B4A4200737373001821BD002900E7002900DE002900
      DE002100E7003100D600DE630800F78C0000F78C0000F78C0000F78C0000F77B
      000073420000CE9C0000FFEF0000F7DE0000D69C3100DE4A0000CE00DE00B510
      CE008C00A5008C00A5007B00730000000000DEBD0000FFEF0000F7DE0000F7DE
      0000F7DE0000DEAD0000BD7B0000A563080094949400DEDEDE00EFEFEF00EFEF
      EF00E7E7E700EFEFF700EFEFF700DEDEDE00D6D6D600CECECE00C6C6C600BDBD
      BD00ADADAD009C8C8C00847B7B0063636B003163A50031739C00524A4A007363
      6300A5A5A500DEDEDE00F7F7F700EFEFF700E7E7E700F7CECE00949494009494
      9400636363000000000000000000000000000000000000000000000000000000
      0000B5634A00B54218004A214A0000006B00000873000008730010086B007B4A
      6B00D65A3100D65A3100846318006BC663007BD67B008CE78C006BAD6300FFF7
      EF00FFF7EF00FFEFDE00FFEFDE004A9C420073CE73006BD66B0052BD5200427B
      420000000000000000000000000000000000000000000000000000000000B59C
      9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C00FFA5
      9C00FFA5A500FFA5A500FFA5A500FFA5A500FFADA500FFADA500FFADAD00FFAD
      AD00FFADAD00FFB5AD00FFB5AD00FFB5B500FFB5B500FFB5B500FFBDB500FFBD
      B500FFB5B500B5525200844A4A00737373001821BD002900E7002900DE002900
      DE002100E7003100D600E7730800FFAD0000FF940000FF940000DE7B0000946B
      00007342000042940000D69C3100DE528C00C610D600B510CE00A510BD00A510
      BD009400AD006B0094007B00730000000000DEBD0000EFCE0000EFBD0000EFCE
      0000EFCE0000DEB50000D69C0000A5630800949494009494940094949400DEDE
      DE00F7F7F700F7F7F700EFEFF700DEDEDE00C6C6C600ADADAD008C8C8C00847B
      7B004A637B00426B8C000873B500006BAD00006BAD00006BAD00217BC600524A
      420084737300BDBDBD00EFEFEF00EFEFEF006363630063636300636363006363
      6300000000000000000000000000000000000000000000000000000000004A4A
      4A0018181800000000000000100008217B001029940010299400082994000018
      7B0031184A00635A5A006BAD6300399C39006BD66B008CE78C0084AD6300DED6
      BD006B9CAD00398CB5006B9CAD009CB5A5004A94310042A54200427B42000000
      000000000000000000000000000000000000000000007373730073737300B584
      8C00FF949400FF949400FF949400FF949400FF949400FF9C9C00FF9C9C00FF9C
      9C00FF9C9C00FF9C9C00FF9C9C00FFA59C00FFA5A500FFA5A500FFA5A500FFA5
      A500FFADA500FFADA500FFADAD00FFADAD00FFADAD00FFB5AD00FFB5AD00FFB5
      B500FFB5B500D6737B006B4A4200737373001821BD002900E7002900DE002900
      DE002100E7003100D600EF840800FFAD0000DE7B0000946B00002194000008A5
      0000188C0000217300008C298C00BD00DE00A500BD00A510BD00C631D600EF4A
      F700F752F700AD29C6007B0073000000000000000000DEBD0000DEAD0000DEB5
      0000DEBD0000DEBD0000C6940000A56308000000000000000000000000009494
      94009494940094949400BDBDBD0094949400848484005A6B7B00426B8C003994
      C600107BBD00107BBD00107BBD000873B500107BBD00107BBD00218CEF002173
      AD005A4A42006363630063636300636363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000101010000808
      0800080808000000080008296B0010319C001039A5001039A5001039A5001039
      A50000187B002931520000000000000000004A9C42004A9C4200317B52000873
      B5001884CE001884D6001884CE00107BBD00006B7300315A39006B6B6B000000
      0000000000000000000000000000000000008C636300A5421000AD523100D66B
      6B00F78C8C00F78C8C00F78C8C00F7949400FF949400FF949400FF949400FF94
      9400FF949400FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C00FFA5
      9C00FFA5A500FFA5A500FFA5A500FFA5A500FFADA500FFADA500FFADAD00FFAD
      AD00FFADAD00D67B8400844A4A00737373001821BD002900E7002900DE002900
      DE002100E7003900D600DE6308009C8400004294000008BD000008BD000018B5
      000021940000298C00008C298C00B510CE00C642D600EF73F700FF94FF00F7B5
      FF00F7B5FF00FF94FF007B297300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006B6B6B00426B8C002173AD00187BCE00187BCE00187B
      CE00187BCE00187BCE001884D60042A5EF005AC6FF005AC6FF0039A5FF00187B
      CE00424A4A006363630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000018181800080808001010
      10000808080008296B00184AAD00184AAD00184AB500184AB500184AB500184A
      AD001039A50008186B0000000000000000000000000000000000000000002994
      F7002994F7002994F7002994F7002994F7001884D600105A8C00635A5A006B6B
      6B0000000000000000000000000000000000B5521800CE630000C6630000CE63
      6300CE636300CE636300CE636300CE636300CE636300CE636300CE636300CE63
      6300CE636300CE636300CE636300CE636300CE636300F78C8C00FF9C9C00FF9C
      9C00FF9C9C00FF9C9C00FF9C9C00FFA59C00FFA5A500FFA5A500FFA5A500FFA5
      A500FFADA500D67B840073737300000000001821BD002900E7002900DE002900
      DE002900E7003100D600318C080000DE000018C6000008CE000008CE000008D6
      000018A5000042940000AD73A500F7B5FF00FFD6FF00FFEFFF00FFEFFF00FFD6
      FF000000000000000000298C000021730000399C210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000399CE70039A5E700218CE700218CE7001884D600218CE700319C
      E70052BDFF005AC6FF0063CEFF005AC6FF004AADF70052BDFF004AB5FF002994
      EF003184CE005A4A390063636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000010101000101010001818
      1800080808001852B5001852BD00185AC600185AC600185AC600185AC6001852
      BD001852BD0000298400105AA5000000000000000000217BB500319CFF00319C
      FF00319CFF00319CFF00319CFF00319CFF00319CFF00218CE700295A6B006B6B
      6B0000000000000000000000000000000000B55A1800CE630000CE630000CE63
      0000CE630000CE630000CE630000CE630000CE630000CE630000CE630000CE63
      0000CE630000D66B00004A4A4A0073737300AD737300B57B7B00FF949400FF94
      9400FF949400FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C00FF9C9C00FFA5
      9C00FFA5A500D6737B0073737300000000001821BD002900E7002900DE002900
      DE002900E7002908D60008C6080000F7000008D6000000EF000000F7000000DE
      000018A500002194000094ADA500FFD6FF00FFD6FF00F7B5FF00000000000000
      000000000000188C000018A5000029AD1000399C210000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000039A5E7002994EF002994EF002994EF00319CEF00399CF7005AC6FF0052B5
      EF0052BDFF0052BDFF0063CEFF0052BDFF004AB5FF003194DE005AC6FF00319C
      EF001884D6004A4A4A005A4A4200636363000000000000000000000000000000
      0000000000000000000000000000000000001818180018181800181818002121
      2100081829002163C6002163CE00216BCE00216BD600216BD600216BD6002163
      CE002163CE0010429C00295A6B00000000001073A500218CE70039A5FF0039A5
      FF0039A5FF0039A5FF0039A5FF0039A5FF0039A5FF00319CFF00107BBD005A63
      63006B6B6B00000000000000000000000000B54A4A00FFC69400FFC69400FFC6
      9400FFC69400FFC69400FFC69400FFC69400FFC69400FFC69400FFC69400FFC6
      9400FFC69400EFA55A007B3921007373730000000000AD737300F78C8C00F78C
      8C00F7949400FF949400FF949400FF949400FF949400FF9C9C00FF9C9C00FF9C
      9C00FF9C9C007373730000000000000000002121BD003108E7003108DE003108
      DE003108E7002908D60008C6080000FF000000F7000000EF000010DE000021CE
      100029D6180029AD100000737B004A6BCE009C39B50000000000000000000000
      000018B5000008CE000018B5000052FF5200529C390000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000052B5EF00399CE70052B5EF0063CEFF005AC6FF005AC6FF004AADF70063CE
      FF0039A5E7004AADFF00319CE7005AC6FF00319CE700399CF700107BC6004AB5
      FF001884D60073524200315A7300636363000000000000000000000000000000
      0000000000000000000000000000000000001818180021212100292929002929
      290010101000216BD6002173DE002973DE00297BE700297BE700297BE7002973
      DE002173D6001052B50029315200000000001073A50039A5FF0042ADFF0042AD
      FF0042ADFF0042ADFF0042ADFF0042ADFF0042A5FF0039A5FF002994E700295A
      6B006B6B6B00000000000000000000000000AD523100FFC68400FFC68400FFC6
      8400FFC68400FFC68400FFC68400FFC68400FFC68400FFC68400FFC68400FFC6
      8400FFC68400F7B573008439180073737300000000009C6B6B00DE7B7B00F78C
      8C00F78C8C00F78C8C00F78C8C00F78C8C00F7949400FF949400FF949400FF94
      9400F79494007373730000000000000000002129BD003918EF003918E7003918
      DE003918EF003918DE0008D6000000F7000021CE10004AC6390063F75A006BFF
      6B0063F75A0042CE4200007BAD00007BAD0073420000000000000000000008CE
      000000F7000021CE100052FF52006BB55A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063C6FF007BC6F70052BDFF0052BDFF004AADFF0042A5F700399C
      E70052BDFF002184C600319CEF00297BCE0052BDFF002184DE00218CEF001063
      B5008C8C8C00427BB500427BB5005A3921006363630000000000000000000000
      0000000000000000000000000000000000001818180029292900292929003131
      3100212121002163B5002984EF00298CF7003194FF003194FF003194FF00298C
      F700297BE700185AC600295A6B00000000001073A50042ADFF0042ADFF004AB5
      FF004AB5FF004AB5FF004AB5FF004AADFF0042ADFF0042ADFF0042A5FF002163
      84006B6B6B000000000000000000000000009C5A6300C66B3100F7B57300F7B5
      7300F7B57300F7B57300F7B57300F7B57300F7B57300F7B57300F7B57300F7B5
      7300F7B57300F7B57300CE6B180073737300000000009C8484009C848400EF84
      8400EF848400EF848400EF8C8C00F78C8C00F78C8C00F78C8C00F78C8C00F78C
      8C00737373000000000000000000000000002939C6004A29E7004A29E7004229
      DE004A29E7004229DE0029AD100073D65A00A5EF9C00A5EF9C00A5EF9C0073D6
      6B0031A573000094CE000084CE00007BAD0073420000529C390008CE000000EF
      000021CE100052FF52006BB55A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063C6FF0063C6FF004AB5FF0042A5F700319CEF002994
      EF002184DE0052BDFF00107BC600218CEF00216BC6007394AD00426B9C00399C
      E700298CE70052BDFF006B737B00945A31005A4A390063636300000000000000
      0000000000000000000000000000000000001818180029292900393939003939
      39003939390010295A00298CF7003194FF00319CFF0039A5FF00319CFF00319C
      FF003194FF001063BD00295A6B00000000001073A5004AB5FF004AB5FF0052B5
      FF0052B5FF0052B5FF0052B5FF004AB5FF004AB5FF004AADFF0042ADFF00216B
      9C006B6B6B0000000000000000000000000000000000AD523100EFAD6300EFAD
      6300EFAD6300EFAD6300EFAD6300EFAD6300EFAD6300EFAD6300EFAD6300EFAD
      6300EFAD6300EFAD6300D67B29006B4A4200000000000000000094737300E77B
      7B00E7848400E7848400EF848400EF848400EF848400EF848400EF8C8C007373
      7300000000000000000000000000000000002939C6005239EF004A31E7004A31
      E7005239EF004A31E700425A940094ADA500A5EF9C0094ADA500427373000094
      CE0000A5F70000A5F7000084CE000084CE0073420000529C390010DE000029D6
      180052FF52006BB55A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000042A5E70039A5F7004AADF7002184
      DE00107BBD00216BC600737373006B6B6B0042A5F700297BD60052BDFF00529C
      CE0084848400BD6B3900FFC68C00CE7B4A007B4A290063636300000000000000
      0000000000000000000000000000000000000000000018181800393939004242
      42004A4A4A002929290010295A0010429C001852D600216BDE002984EF003194
      F7003194FF00105AA500105AA500000000001073A50052B5FF0052BDFF0052BD
      FF0052BDFF0052BDFF0052BDFF0052BDFF0052B5FF004AB5FF004AB5FF00107B
      BD006B6B6B00000000000000000000000000000000009C5A6300B55A1800EF9C
      5200EF9C5200EF9C5200EF9C5200EF9C5200EF9C5200EF9C5200EF9C5200EF9C
      5200EF9C5200EF9C5200DE8C39007B392100737373000000000094737300D66B
      6B00E77B7B00E77B7B00E77B7B00E77B7B00E7848400E7848400737373000000
      000000000000000000000000000000000000394AC600634AEF005A42E7005A42
      E7005A4AEF005A4AEF005A42F7005A42E700425A94001821A5002921730000A5
      F70000ADF70000ADF7000084CE000084CE0073420000000000006BB55A006BB5
      5A006BB55A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000042A5E7008C73
      5A00399CF70042ADFF00319CE70052BDFF007394AD009C947B00CE7B3100DE7B
      2100D6731000CE6B0000DE842900F7BD8400BD946B0063636300000000000000
      0000000000000000000000000000000000000000000029292900393939004A4A
      4A004A4A4A00635A5A00636363004A4A4A001821290000105A0008218C001031
      9C0008296B000810180000000000000000001073A50052BDFF0052BDFF0039A5
      DE00399CDE004AB5F70052B5FF0052BDFF0052BDFF0052B5FF0042ADEF001073
      A5006B6B6B0000000000000000000000000000000000000000009C6B6B00C66B
      2900E7944200E7944200E7944200E7944200E7944200E7944200E7944200E794
      4200E7944200E7944200E7944200B55218007373730000000000A57B7B009C84
      8400DE737300DE737300DE737300DE7B7B00DE7B7B0073737300000000000000
      000000000000000000000000000000000000394AC6006B5AF7006352E7006352
      E7006B5AEF006B5AEF005A52DE004A5AD6001842CE001021C6002921730000AD
      F70000BDF70000BDF7000094CE00008CDE007342000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A510
      BD007B2973000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00008CCEF700A5A5A500F7BD8400EFAD6300EFAD6300E79C4A00E7944200DE84
      3100DE7B2100D6731000CE6B0000DE8C3900F7BD840063636300000000000000
      0000000000000000000000000000000000000000000000000000292929005252
      520052525200636363008484840094949400A5A5A50073737300424242002929
      2900292929003939390000000000000000001073A500107BBD001073A5002184
      C6003994C600398CB5002184C6001884CE001884D6002184C600217BAD001063
      8C00000000000000000000000000000000000000000000000000000000009C5A
      6300B55A1800DE843100DE8C3900DE843100DE843100DE843100DE8C3900DE84
      3100DE8C3900DE843100DE843100A54208007373730000000000000000009C84
      8400D66B6B00D6737B00DE737300737373007373730000000000000000000000
      0000000000000000000000000000000000004252C6007B6BF7006B63EF006B5A
      E7006B63EF004252C6002952C6002139E7001821F7001821F7002921730000B5
      E70000CEF70000CEF7000094CE000094E7007342000000000000000000000000
      0000000000000000000000000000000000000000000000000000B518BD00F700
      FF00C600CE007B29730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DE8C4200DE8C4200F7BD7B00EFAD6300EFAD6300E79C4A00E794
      4200DE843100D67B1800CE630000CE7329009C6B420000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002121
      2100635A5A0073737300848484008C8C8C00A5A5A500A5A5A5007B7B7B004A4A
      4A0018181800000000000000000000000000107BBD001073A5003994C600429C
      D60052ADD6007BBDE70094CEEF009CCEE70063ADD6003994C6001873A5004273
      9C00000000000000000000000000000000000000000000000000000000000000
      00009C5A6300B55A1800CE6B1800DE842100D67B2900DE842100D6732100DE84
      2100D6732100DE842100D6732100BD6310007373730000000000000000009473
      7300737373007373730073737300000000000000000000000000000000000000
      0000000000000000000000000000000000004252C600846BF7006B63EF004A5A
      D6003952C6004A5AD6005A6BEF005A52FF004A42FF002139E700087BD60000CE
      EF0000D6F70000D6F7000094CE000094E7007342000000000000000000000000
      00000000000000000000000000000000000000000000B518BD00FF00FF00CE00
      DE00E718EF009C188C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000D68C5200EFA55A00EFAD6300DE8C4200E794
      4200DE8C3900A53900006B392100636363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000029292900636363008C8C8C0094949400848484006B6B6B00424242002929
      290000000000000000000000000000000000000000001073A500398CB50052AD
      D6007BBDE70084C6E7009CCEEF009CCEE70063ADD6003994C6001073A5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000AD523100AD4A1000C6630000D6731000D6731000D673
      1000D6731000D6731000D6731000CE6B10007373730000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003952C600636BE7004A6BCE004A6B
      CE00737BEF00737BF700737BF7005A6BEF00188CD60000C6DE0000EFFF0000EF
      FF0000CEEF0000BDD60000C6DE0000CEEF007342000000000000000000000000
      000000000000000000000000000000000000AD21B500FF00FF00D608DE00EF31
      EF00EF5AEF00EF5AEF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CE7B
      4200DE8C4200DE843100A54210005A3921006363630000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002929290029292900292929002929290029292900292929000000
      00000000000000000000000000000000000000000000000000001073A500429C
      D60094CEE700A5D6EF0094CEE7007BBDE70052ADD600217BAD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AD523100B55A1800B5521800B552
      1800AD4A0000BD520000C65A0000C65A0000C65A000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000004A6BCE006B73DE00636BE700737B
      EF00737BF700738CEF003194D60000C6DE0000EFFF0000EFFF0000D6E70021BD
      DE0031D6E70031FFFF0010E7EF0010E7EF000000000000000000000000000000
      0000000000000000000000000000AD21B500FF00FF00D608DE00EF4AEF00EF73
      F700EF5AEF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CE7B4200DE8C4200DE843100A53900006B39210063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001073
      A5001073A5001073A5001073A5001073A5001073A50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000A57B7B00A57B7B00A57B7B00A57B7B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008494EF00738CEF008494
      EF00738CEF00738CEF0000D6E70000FFFF0000D6E70021BDDE0063D6EF0084F7
      FF0063D6EF0010E7EF0010E7EF00000000000000000000000000000000000000
      00000000000000000000AD21B500FF00FF00D608DE00EF73F700FF94FF00EF5A
      EF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CE7B4200DE8C4200DE843100AD4A08006B392100636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000BDD60031D6E70063D6EF0084F7FF0084F7FF0010E7
      EF0010E7EF000000000000000000000000000000000000000000000000000000
      0000000000009C39B500F700FF00D608DE00E784EF00F7B5FF00EF5AEF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CE7B4200DE8C3900DE843100A5421000636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000BDD60000BDD60063D6EF0010E7EF0010E7EF000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000EF5AEF00C610D600E784EF00FFD6FF00EF5AEF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CE7B4200B5633100CE7B4200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000EF5AEF00D673E7008C298C0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFEFFF00FFFFFF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005221
      3100390018000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00C6CEE7001839
      B50000219C0008299C0000219C0008299C0008299C0008299C0008299C000829
      9C0008299C0008299C0008299C0008299C0008299C0008299C0008299C000021
      A5000021A50000219C0000219C000021A50000219C0000219C0000219C000829
      9C001839B500ADB5DE00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000C68C63007B42
      3100390018000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005242
      4200524242005242420052424200524242005242420052424200524242005242
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000007373
      7300737373000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00C6CEE7000829AD000829
      AD000831BD000831BD001839B5001839B5001839B5001839B5001839B5001839
      B5001839B5001839B5001839B5000831BD001839B5000831BD000831BD000831
      BD000831BD000831BD000831BD000831BD000831BD000831BD000831BD000029
      B5000021A50000219C00ADB5DE00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CE9C7300DEAD84007B42
      3100390018000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B58C7B00B58C7B00D6C6
      BD00E7D6CE00F7DED600F7DED600F7DED600F7DED600F7DED600E7DED600D6C6
      BD00524242005242420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000737373004A4A
      4A004A4A4A007373730000000000000000000000000000000000000000000000
      00000000000000000000737373006B6363005A5A5A0073737300000000000000
      000000000000000000000000000000000000FFFFFF003152CE000029C6000831
      CE001839C6001839C6002142D6002142D6002142D6002142D6002142D6002142
      D6002142D6002142D6002142D6002142D6001039DE002142D6001039DE001039
      DE001039DE001039DE000831CE000031DE000031DE000031D6000031D6000029
      C6000029C6000021A5001839B500FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000BD946B00DEB58C00E7B58C007B42
      3100390018000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5949400EFD6CE00F7E7D600F7EF
      E700F7EFEF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7EF
      EF00F7E7DE00E7DED60052424200524242000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000737373005A5242005A4A
      31004A3929004A4A4A0000000000000000000000000000000000737373006363
      6300737373007B5252007B5252008C63630063424200524242005A5A5A007373
      730000000000000000000000000000000000FFFFFF000031D6001039DE001039
      DE001842DE002142D6002952DE002952DE002952DE002952DE002952DE002952
      DE002952DE002952DE002952DE002952DE00214AE700214AE700214AE7001842
      DE00104AEF001842DE000842E7000842E7000039E7000039E7000039E7000031
      D6000031D6000029B50000219C00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CEAD8C00CEAD8400EFC69C00E7B58C008452
      4A00390018000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000B5949400B5949400F7DED600F7F7EF00F7F7F700F7F7
      F700EFEFEF00DEDEDE00DEDEDE00EFEFEF00EFEFEF00F7F7F700F7F7F700EFEF
      EF00F7F7F700F7F7F700F7EFE700E7DED6005242420052424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000007B736B00FFC68400E78C
      3900CE6B1800424242000000000000000000000000000810AD000810AD001810
      8C006B4A5A00AD848400D6B5B500B5ADAD00A59C9C008C737300634242005242
      42005A5A5A00737373000000000000000000FFFFFF000031DE001039DE001842
      DE00214AE7002952E7003152E7003152E700315AE700315AE700315AE7003152
      E7003152E7003152E700295AE700295AE700295AE7002152EF002152E700184A
      E700184AE700104AEF00104AEF000842E7000842E7000039E7000039E7000031
      DE000031D6000029C60000219C00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009473
      84009473840084636B009C737300BD9C7B00D6AD8C00EFC69C00DEB58C008452
      4A005A2942003900180000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B5949400F7EFE700F7EFE700F7F7F700F7F7F700F7F7F700E7DE
      D600BDB5AD00C68C7300BD735200C67B5A00BD735200CE8C6B00D6A58C00E7CE
      C600EFEFEF00F7F7F700F7F7F700F7F7F700F7E7DE00BDA59C00524242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094847B00F7B57300DE84
      2900B563210042424200000000000000000029299C001052FF001052FF001863
      FF00424AB500DEC6C600DEBDBD00B5ADAD00ADA5A500ADA5A500AD9C9C008C6B
      6B00634242004A4242006363630000000000FFFFFF000031DE001842DE00214A
      E7002952E7003152E700315AE700395AE700395AE700395AE700395AE7004263
      E7008C9CEF00BDCEF700E7EFFF00FFFFFF00FFFFFF00E7EFFF00BDCEF7007B9C
      F700295AEF002152EF00104AEF00104AEF000842E7000842E7000039E7000039
      E7000031D6000029C60000219C00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000008C63520084636B00734239008C63
      52009C6B5A00A57B6300BD947B00C6A58400DEB59400EFC69C00DEB58C00B58C
      6B006B3931004A18210039001800522131000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000B5949400F7EFE700F7F7EF00F7F7F700F7F7F700EFE7E700D6A58C00CE73
      4200BD5A2900BD5A2900BD5A3100CE846300CE734200BD5A2900BD5A2900BD5A
      2900CE846300D6C6BD00F7F7F700EFEFEF00F7F7F700F7E7DE00BDA59C005242
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000094847B00F7B57300DE84
      2900B5632900393939006B6363007363630018108C001052FF001863FF002173
      FF0031319C00DEC6C600DEB5B500B5949400ADA5A500ADA5A500ADA5A500ADA5
      A500AD9C9C008C6363005A42420073737300FFFFFF000031DE001842DE002952
      E7003152E700315AE700395AE700395AE7004263E7004263E7008C9CEF00F7FF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00EFF7FF007B9CF700184AE700104AEF00104AEF000842E7000039E7000039
      E7000031D6000029C60000219C00FFFFFF000000000000000000000000000000
      00000000000000000000B59C94008C6352008C635200AD846B00B59C7B00BD9C
      7B00BD9C7B00BD9C7B00C6A58400D6AD8C00EFC69C00EFCEA500DEBD9400CEAD
      8C00BD9C7300BD946B0084524A00632929004208210073525A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DED6D600F7F7EF00F7F7F700F7F7F700E7DED600CE846300BD5A2900BD5A
      2900BD5A2900C6633900C6A59400EFEFEF00F7EFEF00D68C6300BD5A2900BD5A
      2900BD5A2900BD5A3100D6A58C00EFEFEF00F7F7F700F7F7F700F7E7DE005242
      4200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073635200F7B57300DE84
      2900B56329004A424200946B6B00C6ADAD00424AB5001052FF001863FF00297B
      FF0031319C00D6A5A500CE9C9C00A57373009C6B6B00A5848400B59C9C00B59C
      9C007BE79C009C8C84005A42420073737300FFFFFF001039DE001842DE003152
      E700315AE700395AE7004263E7004263E7004263E700BDCEF700FFFFFF00FFFF
      FF00E7EFFF0094A5F700637BEF003963EF003963EF00527BEF008C9CEF00E7EF
      FF00FFFFFF00FFFFFF00B5BDF700104AEF00104AEF000842E7000842E7000039
      E7000031DE000029C60000219C00FFFFFF000000000000000000000000000000
      000000000000B59C9400A57B6300BD9C7B00BDA58400C6A58C00C6AD8C00D6AD
      8C00DEB59400DEBD9400E7BD9C00EFCEA500FFD6AD00FFD6AD00EFCEA500DEBD
      9400D6AD8C00C6A58C00BD9C7B00BD947300946352004A182100522131000000
      000000000000000000000000000000000000000000000000000000000000DEBD
      AD00F7EFE700F7F7F700F7F7F700E7CEC600C66B3900BD5A2900C6633100C663
      3100CE633100BD846300BDBDBD00FFFFFF00FFFFFF00EFCEBD00C6633100C663
      3100C6633100BD5A2900BD5A2900CE8C6B00EFEFEF00F7F7F700F7F7F700F7DE
      D600524242000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000073635200EFA56300D673
      1000B5632900A5949400EFE7E700EFDEDE00424AB5001863FF002173FF003184
      FF0031218C00D6A5A500D6B5B500BD9C9C00AD8484009C6B6B009C6B6B00A57B
      7B00B5949400A57B7B005A42420073737300FFFFFF001039DE00214AE7003152
      E700395AE7004263E7004263E7004A6BE700BDCEF700FFFFFF00FFFFFF00A5B5
      F700426BE7004263E7004263E7003963EF003963EF003163EF00295AEF00295A
      EF008C9CEF00FFFFFF00FFFFFF00B5BDF700104AEF00104AEF000842E7000039
      E7000031DE002142C6000021A500FFFFFF000000000000000000000000000000
      0000AD8C7B00B5947B00BDA58400C6AD8C00D6B59C00DEC6A500EFC6A500F7CE
      AD00FFE7BD00FFE7BD00FFE7BD00FFE7BD00FFE7BD00FFE7BD00FFDEBD00FFDE
      B500EFC6A500E7BD9C00D6B59400CEAD8C00BD9C7B00B58C6B00632929004208
      210000000000000000000000000000000000000000000000000000000000DEBD
      AD00FFFFFF00F7F7F700F7DED600C66B3900C6633100C6633100CE633100CE63
      3100CE633100CE6B4200BDBDBD00FFFFFF00FFFFFF00D6A58C00CE633100CE63
      3100CE633100C6633100C6633100BD5A2900D69C7B00EFEFEF00F7F7F700F7EF
      EF00524242000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C7B6300EFA56300D673
      1000BD6B4200BDBDBD00EFE7E700E7DEDE00424AB5001863FF00297BFF003994
      FF0031319400DEC6C600DEBDBD00BD9C9C00A5737300AD848400AD8C8C00A573
      73009C6B6B00946363005A42420073737300FFFFFF001039DE002952E700315A
      E7004263E7004263E7004A63E7008C9CEF00FFFFFF00FFFFFF0094A5F700426B
      E700426BE700426BE7004263E7004263E7003963EF003163EF003163EF00295A
      EF002152EF007394F700FFFFFF00FFFFFF007B9CF700104AEF000842E7000842
      E7001039DE002142C6000021A500FFFFFF00000000000000000000000000BD9C
      8C00B59C8400C6AD9400CEB59C00DEC6A500F7D6B500FFDEBD00FFE7BD00F7CE
      AD00A55A3100D67B4A00CE845200CE845200CE845200E79C6B00E79C6B00CE84
      5200FFDEB500FFD6B500EFCEA500E7BD9C00D6B59400C6A58C00BD9473007342
      3900420821000000000000000000000000000000000000000000DEBDAD00FFEF
      EF00F7F7F700F7F7F700CE846300C6633100C6633100CE633100CE633100CE63
      3100CE633100CE633100CE846300EFC6B500D6A58C00CE633100CE633100CE63
      3100CE633100CE633100C6633100C6633100BD5A2900DEBDAD00F7F7F700F7F7
      F700F7DED6005242420000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C7B6300EFA56300D673
      1000BD6B4200B5ADAD00DEB5B500CE9C9C002939A5002173FF003184FF00429C
      FF0031319400DEC6C600DEBDBD00BD9C9C00B5848400C68C8C00B5848400AD84
      8400B58C8C009C6B6B005A42420073737300FFFFFF001842DE002952E700395A
      E7004263E7004A63E7005A73EF00F7FFFF00FFFFFF00A5B5F7004A6BE7004A6B
      E7004A6BE700426BE7004263E700FFFFFF00FFFFFF003163EF003163EF00295A
      EF002152EF002152EF008C9CEF00FFFFFF00EFF7FF002152EF00104AEF001039
      DE001039DE002142C6000021A500FFFFFF000000000000000000B59C8C00B59C
      8C00C6AD9400D6BDA500E7CEB500FFDEBD00FFE7C600FFE7C600FFE7C600FFDE
      BD00B5845A009C421800AD421000C6632900C6632900AD421000A5522900D6A5
      7B00FFDEBD00FFDEBD00FFDEBD00FFD6B500E7C6A500D6B59400C6A58C00BD94
      7300632929005221310000000000000000000000000000000000DEBDAD00FFFF
      FF00FFFFFF00EFC6AD00BD5A2900C6633100CE633100CE633100CE633100CE63
      3100CE633100CE633100CE633100CE633100CE633100CE633100CE633100CE63
      3100CE633100CE633100CE633100C6633100C6633100CE734200EFE7E700F7F7
      F700F7EFEF005242420000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000009C7B6300E79C4A00D66B
      1000945A3900AD848400DEBDBD00E7D6D60008219400217BFF003994FF004AA5
      FF0031318C00DEC6C600DEBDBD00C6949400B5848400CE9C9C00CE9C9C00CE94
      9400B58484009C6B6B005A42420073737300FFFFFF001842DE003152E7004263
      E7004A63E7004A6BE70094A5F700FFFFFF00E7EFFF00526BE7004A6BE7004A6B
      E7004A6BE700426BE7004263E700FFFFFF00FFFFFF003163EF003163EF00295A
      EF002152EF002152EF002152EF00E7EFFF00FFFFFF007394F700104AEF00104A
      EF001039DE002142C6000021A500FFFFFF0000000000B59C8C00B59C8C00C6AD
      9C00D6BDA500EFD6BD00FFE7C600FFE7C600FFE7C600FFE7C600FFE7C600FFE7
      C600FFF7D600C69473008C290000942900009429000084391000F7CEAD00FFEF
      CE00FFDEBD00FFDEBD00FFDEBD00FFDEBD00FFDEB500EFC6A500D6B59C00C6AD
      8C00B58C6B004A182100522131000000000000000000DEBDAD00F7E7DE00FFFF
      FF00F7F7F700CE846300C6633100CE633100CE6B3100CE6B3100CE633100CE63
      3100CE633100CE633100D69C7B00EFC6AD00EFC6AD00D6734A00CE633100CE63
      3100CE633100CE633100CE633100CE633100C6633100BD5A2900DEBDAD00FFFF
      FF00F7F7F700E7DED60052424200000000000000000084848400848484008484
      840084848400848484008484840084848400848484009C7B6300E79C4A00D66B
      1000945A4A00BDBDBD00EFE7E700EFDEDE0008219400298CFF00429CFF0052AD
      FF0031318C00DEC6C600DEBDBD00C6949400B5848400BD8C8C00CE9C9C00CE9C
      9C00BD8C8C009C6B6B005A42420073737300FFFFFF001842DE00315AE7004263
      E7004A6BE7004A6BE700CED6FF00FFFFFF00A5B5F700526BE7004A6BE7004A6B
      E7004A6BE700426BE7004263E700FFFFFF00FFFFFF003163EF003163EF00295A
      EF002152EF002152EF002152EF007B9CF700FFFFFF00BDCEF700184AE7001842
      DE001039DE002142C60008299C00FFFFFF0000000000CEAD9C00C6AD9C00D6BD
      A500EFD6BD00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7C600FFE7
      C600FFEFCE00C69C7B00842900009C31000094290000A5522900FFDEBD00FFE7
      C600FFE7C600FFE7BD00FFDEBD00FFDEBD00FFDEBD00FFDEBD00E7CEAD00D6BD
      9C00C6AD8C0094635200522131000000000000000000DEBDAD00FFEFEF00FFFF
      FF00EFE7DE00C6633100CE633100CE6B3100CE6B3100CE6B3100CE633100CE63
      3100CE633100CE633100BDB5AD00FFFFFF00FFFFFF00DE946B00C6633100CE63
      3100CE633100CE633100CE633100CE633100CE633100BD5A2900CE846300F7F7
      F700FFFFFF00F7DED60052424200000000000084B5003963730021637B002163
      7B0021637B0021637B0021637B0021637B00295A7300C69C6B00E79C4A00D66B
      1000945A4A00BDBDBD00EFE7E700EFDEDE0008219400298CFF004AA5FF005ABD
      FF0031318C00DEC6C600DEBDBD00C6949400B5848400AD7B7B009C6B6B00B584
      8400BD8C8C009C6B6B005A42420073737300FFFFFF00214AE700395AE7004A6B
      E700526BE7005273E700EFF7FF00FFFFFF00738CEF00526BE700526BE7004A6B
      E7004A6BE700426BE7004263E700FFFFFF00FFFFFF003163EF00295AE700295A
      E7002152EF002152E7002152EF004A6BEF00FFFFFF00EFF7FF00184AE700184A
      E7002142D6002142C60008299C00FFFFFF00BDA59C00BDA59C00D6BDA500E7CE
      B500FFE7CE00FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00FFEFD600C69C7B00842900009C31000094290000A5522900FFDEBD00FFE7
      CE00FFE7C600FFE7C600FFE7C600FFE7C600FFE7C600FFE7C600FFDEBD00E7C6
      AD00D6BD9C00C6A58400420821005221310000000000DEBDAD00FFFFF700FFFF
      FF00EFB59C00C6633100CE6B3100D66B3900CE6B3100CE633100CE633100CE63
      3100CE633100CE633100BDB5AD00FFFFFF00FFFFFF00EFAD8C00CE633100CE63
      3100CE633100CE633100CE633100CE6B3100CE633100C6633100CE734200EFE7
      DE00F7F7F700F7E7DE0052424200000000000084B50031A5D6004AB5E7004AB5
      EF004AB5EF004AB5EF004AB5EF004AB5EF003994C600C69C6B00E78C3900D66B
      1000945A4A00BDBDBD00EFE7E700EFDEDE00082194002984EF00317BDE003984
      DE0039318400DEC6C600DEBDBD00C68C8C00B5848400B5848400B5848400B584
      8400AD7B7B00A56363005A42420073737300FFFFFF00214AE7004263E7004A6B
      E7005273E7005273E700FFFFFF00FFFFFF005273E700526BE7004A6BE7004A6B
      E7004A63E7004263E7004263E700FFFFFF00FFFFFF00315AE700295AE700295A
      E7002152EF002152E700184AE700184AE700FFFFFF00FFFFFF00184AE700214A
      E7002142D6002142C60008299C00FFFFFF00BDA59C00CEB5A500DEC6B500F7DE
      C600FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFE7CE00FFE7CE00FFE7
      CE00FFEFD600C69C7B00842900009C31000094290000A55A3100FFDEC600FFE7
      CE00FFE7C600FFE7C600FFE7C600FFE7C600FFE7C600FFE7C600FFE7C600F7D6
      B500DEC6A500CEB59C0084524A006B42520000000000DEBDAD00FFFFFF00FFFF
      FF00DEAD9400CE633100CE6B3900D66B3900CE6B3100CE633100CE633100CE63
      3100CE633100CE633100BD846B00EFEFEF00FFFFFF00FFF7EF00D68C6300CE63
      3100CE633100CE633100CE633100CE6B3100CE6B3100CE633100C66B3900E7DE
      D600FFFFFF00F7EFE70052424200000000003994C6004AB5E7006BD6FF006BD6
      FF006BD6FF006BD6FF006BD6FF006BD6FF0052849C00C69C6B00E78C3900D673
      1800945A4A00EFEFEF00EFE7E700EFDEDE003931840073738400636363004242
      420063529400DEC6C600DEBDBD00C68C8C00B5848400C6949400AD7B7B00A573
      7300BD8C8C00A56363005A42420073737300FFFFFF00214AE7004263E700526B
      E7005A73EF005A73EF00FFFFFF00FFFFFF005273E700526BE700526BE7004A6B
      E7004A63E7004263E7004263E700FFFFFF00FFFFFF00315AE700295AE700295A
      E7002152E7002152E7002152E700184AE700FFFFFF00FFFFFF002152E700214A
      E7002142D6002142C6001029A500FFFFFF00CEB5A500D6C6B500E7D6C600FFE7
      D600FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEF
      D600FFEFDE00C69C7B00842900009C31000094290000A55A3100FFDEC600FFE7
      CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7C600FFE7CE00FFDE
      C600E7CEB500D6BDA500AD846B0063394A0000000000DEBDAD00FFFFFF00FFFF
      FF00D69C8400CE6B3100D66B3900D66B3900CE6B3100CE633100CE633100CE63
      3100CE633100CE633100C66B3900BDA59C00F7F7F700FFFFFF00FFF7EF00D68C
      6300CE633100CE633100CE633100CE6B3100CE6B3100CE633100CE6B3900EFDE
      CE00FFFFFF00F7EFE700524242000000000031A5D60042ADD60073D6FF006BD6
      FF006BD6FF006BD6FF006BD6FF006BD6FF0052849C00C69C6B00A56B3900B563
      210094635A00EFEFEF00EFE7E700EFDEDE00D6CED600A5A5A500D6D6D6009494
      9400D6BDBD00DEC6C600DEBDBD00CE8C8C00A5737300C6949400CE9C9C00CE9C
      9C00BD8C8C00A56363005A42420073737300FFFFFF002952E7004A63E7005A73
      EF005A73EF005A7BEF00E7EFFF00FFFFFF00738CEF005273E7004A6BE7004A6B
      E7004A63E7004263E7004263E700FFFFFF00FFFFFF00315AE700295AE7002952
      E7002952E7002152E7002152E7003963EF00FFFFFF00EFF7FF002152E700214A
      E7002142D6002142C6001029A500FFFFFF00CEBDB500D6C6BD00EFDECE00FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFEFD600FFEFD600FFEFD600FFEF
      D600FFF7DE00C69C8400842900009C31000094290000A55A3100FFDEC600FFEF
      D600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00EFD6BD00DEC6A500B58C7B0063394A0000000000DEBDAD00FFFFFF00FFFF
      FF00EFAD8C00D66B3900D6733900D66B3900CE6B3100CE633100CE633100CE63
      3100CE633100CE633100CE633100C6633100BDB5AD00F7F7F700FFFFFF00FFF7
      EF00D68C6300CE633100CE633100CE6B3100CE6B3900CE6B3100CE6B3900F7DE
      D600FFFFFF00F7EFE700524242000000000042ADD6003994C60084DEFF0073DE
      FF0073DEFF0073DEFF0073DEFF0073DEFF005A94A50042424200D6D6D6007373
      7300524A4A00EFEFEF00EFE7E700EFDEDE00BDB5B500CECECE00BDC6C6008484
      8400DEC6C600DEC6C600DEBDBD00CE848400C6737300B56B6B00A5737300B584
      8400BD8C8C00A56363005A42420073737300FFFFFF003152E7004A6BE7005A7B
      EF005A7BEF005A7BEF00CED6FF00FFFFFF00A5B5F700526BE7004A6BE7004A6B
      E7004A63E7004263E7004263E700FFFFFF00FFFFFF003152E7003152E7002952
      E7002952E7002152E700214AE700738CEF00FFFFFF00CED6FF00214AE7002952
      DE00294AD6002142C6001029A500FFFFFF00CEC6B500D6CEBD00EFDED600FFEF
      DE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFF7E700C69C8400842900009C31000094290000A55A3100FFDEC600FFEF
      D600FFE7D600FFE7D600FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7CE00FFE7
      CE00EFD6C600DECEB500B5948C0063394A0000000000DEBDAD00FFFFFF00FFFF
      FF00EFB59C00D6733900DE734200D6733900D66B3900CE633100CE633100CE63
      3100CE633100CE633100CE633100CE633100C6633100D6C6BD00FFFFFF00FFFF
      FF00F7E7D600CE6B3900CE633100D66B3900D66B3900CE6B3100CE6B4200F7E7
      DE00FFFFFF00F7EFE70052424200000000004ABDD60031A5D60094E7FF007BDE
      FF0073BDD60084B5C6005A94A5005A94A50073D6F70063848C00848484007373
      7300BDBDBD00EFEFEF00DED6D600A5A5A500D6D6D600D6D6D600ADADB500B5B5
      BD00A5A5A500948C8C00DEBDBD00CE848400C6737300C6737300C6737300C673
      7300B56B6B00A56363005A42420073737300FFFFFF003152E700526BE7005A7B
      EF00637BEF00637BEF00A5B5F700FFFFFF00E7EFFF005273E700526BE7004A6B
      E7004A63E7004263E7004263E700FFFFFF00FFFFFF003152E7003152E7002952
      E7002952E700214AE700214AE700E7EFFF00FFFFFF008C9CEF002952E7002952
      DE00294AD6002142C6001029A500FFFFFF00D6C6BD00D6CEBD00EFE7D600FFF7
      E700FFF7E700FFF7E700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEF
      DE00FFFFEF00CEA58C008C2900009C31000094290000A55A3100FFE7CE00FFEF
      DE00FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEF
      D600EFD6C600DECEB500B5948C0063394A0000000000DEBDAD00FFF7F700FFFF
      FF00F7DECE00DE7B4200E77B4A00DE734200D66B3900CE6B3100CE633100CE63
      3100CE633100CE633100CE633100CE633100CE633100CE734200EFE7E700FFFF
      FF00FFFFFF00DE946B00CE633100D66B3900D6733900CE6B3100D68C6300FFF7
      F700FFFFFF00F7E7DE0052424200000000004ABDD60042ADD6009CDEF70063AD
      BD00C6C6C600FFFFFF00D6BDBD00BD9494004A4A4A007B7B7B00C6C6C600BDBD
      BD00A5A5A500A5A5A500B5B5B500FFFFFF00EFEFEF00CECECE00BDBDBD00C6C6
      C600DEDEDE00E7E7E7009C9C9C00F7E7E700E7BDBD00D68C8C00CE6B6B00CE6B
      6B00CE6B6B00B55A5A005A42420073737300FFFFFF003152E7005273E7006B84
      EF006B84EF006B84EF006B84EF00F7FFFF00FFFFFF00A5B5F700526BE7004A6B
      E7004A63E7004263E7004263E700FFFFFF00FFFFFF00315AE7003152E7003152
      E7002952E7002952E7008C9CEF00FFFFFF00EFF7FF00315AE7002952E7002952
      DE00294AD6002142C6001029A500FFFFFF00D6C6BD00DECEC600EFE7D600FFF7
      E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7
      E700F7E7CE00AD633900942900009C31000094290000A55A3100FFE7D600FFF7
      DE00FFEFDE00FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEFD600FFEF
      DE00F7DEC600DECEB500B5948C006B42520000000000DEBDAD00FFEFE700FFFF
      FF00FFFFFF00EF946300EF845200E77B4A00D6733900CE6B3900C68C7300DEAD
      9400DEBDAD00D6734A00CE633100CE633100CE633100CE633100E7CEC600FFFF
      FF00FFFFFF00EFB59C00D66B3900D6733900DE734200CE6B3100EFAD8C00FFFF
      FF00FFFFFF00F7DED600524242000000000052BDD60052BDEF009CD6EF006B8C
      9400D6D6D600DEDEDE00C6C6C600AD9C9C006B6363006B636300BDBDBD00C6C6
      C600CECECE0094949400B5B5B500EFEFEF00FFFFFF00949494007B7B7B00D6D6
      D600D6D6D600EFEFEF00C6BDBD00F7E7E700F7E7E700F7E7E700F7DEDE00E7BD
      BD00D68C8C00B55A5A006342420073737300FFFFFF00315AE7005A73EF006B84
      EF006B84EF006B84EF006B84EF00A5B5F700FFFFFF00FFFFFF0094A5F7004A6B
      E7004A6BE7004263E7004263E7004263E700395AE700315AE7003152E7003152
      E7003152E7005273E700FFFFFF00FFFFFF008C9CEF002952E7002952E7002952
      DE00294AD6002142C6001029A500FFFFFF00D6CEBD00DED6CE00EFE7DE00FFF7
      EF00FFF7EF00FFF7E700FFF7E700FFF7E700FFF7E700FFF7E700FFF7EF00D6B5
      9C00843910007B2100008421000084210000731800008C523100FFE7D600FFF7
      E700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFD600FFF7DE00FFF7
      E700F7DECE00E7D6C600B59484009473840000000000DEBDAD00F7DED600FFFF
      FF00FFFFFF00F7C6AD00F78C5A00EF845200E77B4A00D6734A00D6C6BD00F7F7
      F700FFFFFF00EFC6AD00C6633100CE633100CE633100CE734200EFE7DE00FFFF
      FF00FFFFFF00D6A58C00D66B3900DE7B4200DE7B4200DE734200FFDED600FFFF
      FF00FFFFFF00EFDECE00524242000000000052BDD6005AC6F7009CD6EF008494
      9C00BDBDBD00BDBDBD00C6C6C600CECECE008484840073737300ADADAD00B5B5
      B500BDC6C600CECECE008C8C8C00949494008C8C8C00A5A5A5008C8484009C94
      9400CECECE00D6D6D600A5949400E7C6C600E7C6C600E7C6C600DEBDBD00C6AD
      AD00AD848400946363009C84840000000000FFFFFF00315AE7005A7BEF006B84
      EF00738CEF00738CEF006B84EF00637BEF00BDCEF700FFFFFF00FFFFFF00A5B5
      F7004A6BE7004A63E7004263E7004263E700395AE700395AE7003152E7003152
      E7008C9CEF00FFFFFF00FFFFFF00B5BDF7003152E7002952E7003152E7002952
      DE00294AD6002142C6001029A500FFFFFF00D6C6BD00DED6D600EFE7DE00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00DEC6
      B500A57B6300A57B6300A57B63009C6B5A0084523100A57B6300FFEFDE00FFF7
      E700FFF7E700FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFEFDE00FFFFEF00FFF7
      DE00F7DECE00E7D6C6009C6B5A00000000000000000000000000DEBDAD00FFFF
      FF00FFFFFF00FFF7F700FFA57300FF946300F7945A00E77B4A00C6A59400F7F7
      EF00FFFFFF00FFFFFF00EFB59C00D6734A00D6845200E7CEBD00FFFFFF00FFFF
      FF00EFEFEF00DE946B00DE734200E77B4A00DE734200EFAD8C00FFFFFF00FFFF
      FF00F7EFE7005242420000000000000000005AC6DE006BD6F70073C6E7007B94
      9400D6D6D600BDBDBD00FFFFFF00FFFFFF00737373007B7B7B009C9C9C00A5A5
      A500B5B5B500BDBDBD00CECECE00CECECE00ADADAD007B737300D6A5A5008C84
      8400BDC6C60084848400A57B7B00AD7B7B008C5A5A008C5A5A00946B6B009C84
      84009C848400000000000000000000000000FFFFFF00395AE7005A7BEF00738C
      EF007B94EF00738CEF00738CEF006B84EF00637BEF00BDCEF700FFFFFF00FFFF
      FF00E7EFFF00A5B5F7006B84EF004263E7004263E7005273E7008C9CEF00E7EF
      FF00FFFFFF00FFFFFF00B5BDF7003152E7003152E7003152E7003152E7003152
      E700294AD6002142C6001029A500FFFFFF00D6C6BD00DED6CE00E7DEDE00F7EF
      E700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7E700FFF7
      E700FFF7E700FFF7E700FFF7E700FFF7E700FFEFDE00FFF7EF00FFF7EF00FFEF
      DE00EFDECE00E7CEB5008C637300000000000000000000000000DEBDAD00F7E7
      DE00FFFFFF00FFFFFF00FFE7D600FFA56B00FFA56B00FF946300D68C6300CECE
      CE00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFFFF700FFFFFF00FFFFFF00F7F7
      F700DECEC600EF845200EF845200EF845200EF946300FFF7EF00FFFFFF00FFFF
      FF00EFDECE005242420000000000000000005AC6DE007BD6FF0052BDEF00BDEF
      F70063848C0094ADAD008C8C8C006B6B6B00A5A5A500BDBDBD00B5B5B500A5A5
      A500A5A5A500ADADAD0094ADAD006B949C007B8C8C0094848400A57373007363
      6300848C8C009484840073636300000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00395AE7006B84EF007B94
      EF008C9CEF007B94EF007B94EF00738CEF006B84EF00637BEF00A5B5F700F7FF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7FFFF0094A5F700395AE700315AE700315AE7003152E7003152E7002952
      DE00294AD6002142C6001029A500FFFFFF0000000000E7DED600E7DEDE00EFEF
      E700FFFFF700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFEFE700F7DEC600FFEFE700FFF7EF00FFF7EF00FFF7
      EF00FFF7E700FFF7E700FFF7E700FFF7E700FFF7EF00FFF7EF00FFF7EF00F7E7
      D600EFDECE00AD8C84000000000000000000000000000000000000000000DEBD
      AD00FFFFFF00FFFFFF00FFFFFF00FFF7C600FFB58400FFB58400FFA56B00DE9C
      7B00DED6D600EFEFEF00F7F7F700FFFFFF00F7F7F700FFFFFF00F7F7F700F7DE
      D600EF9C7300F7945A00FF946300FF946300FFE7D600FFFFFF00FFFFFF00F7EF
      E700BDB5AD000000000000000000000000006BC6DE0084DEFF005AC6F700CEF7
      FF0094FFFF0094FFFF0094FFFF0094FFFF0094FFFF0094FFFF007BCECE007BCE
      CE007BCECE0094FFFF0094FFFF0094FFFF0094FFFF0084DEDE007BE7FF0084DE
      DE0094F7F700D6DEDE009C848400000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF004263E700738CEF008C9C
      EF0094A5F7008C9CEF007B94EF007B94EF006B84EF006B84EF006B84EF006B84
      EF00A5B5F700CED6FF00F7FFFF00FFFFFF00FFFFFF00F7FFFF00CED6FF0094A5
      F7005A73EF004A63E7004263E7004263E700395AE700395AE700315AE7003152
      E700294AD6002142C60008299C00FFFFFF0000000000E7E7E700E7DED600E7E7
      E700F7EFEF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00D6BDA5009C421800D67B4A00D67B4A00E7C6AD00FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00F7EFDE00EFE7
      D600DEC6B500C6ADAD000000000000000000000000000000000000000000DEBD
      AD00F7DED600FFFFFF00FFFFFF00FFFFFF00FFEFD600FFD69C00FFC69400FFB5
      8400FFB58C00EFC6AD00DECEC600D6C6BD00DECEC600D6C6BD00EFC6AD00FFAD
      7B00FFA56B00FFA56B00FFAD7B00FFEFD600FFFFFF00FFFFFF00FFF7F700EFD6
      C600BDB5AD000000000000000000000000006BC6DE008CE7FF006BD6FF007BD6
      FF00BDF7FF00BDF7FF00BDF7FF00BDF7FF00BDF7FF00BDF7FF00BDF7FF00BDF7
      FF00BDF7FF00BDF7FF00BDF7FF00BDF7FF00BDF7FF00BDF7FF00BDF7FF00BDF7
      FF00BDF7FF00BDF7FF0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF004A63E700738CEF0094A5
      F700A5B5F70094A5F7008C9CEF007B94EF00738CEF00738CEF006B84EF006B84
      EF006B84EF00637BEF00637BEF005A7BEF005A7BEF005A7BEF005A73EF005A73
      EF005A73EF00526BE7004A6BE7004A6BE7004263E7004263E700395AE7003152
      E700294AD6001839B50008299C00FFFFFF000000000000000000F7EFE700E7E7
      DE00EFE7E700F7F7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7F7008C52310084210000C6632900BD5A2100AD633900FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00F7EFE700EFE7DE00EFDE
      CE00BDA59C000000000000000000000000000000000000000000000000000000
      0000DEBDAD00F7E7E700FFFFFF00FFFFFF00FFFFFF00FFFFEF00FFF7C600FFEF
      B500FFD6AD00FFD69C00FFC69400FFBD8C00FFBD8C00FFBD8C00FFBD8400FFB5
      8400FFBD8C00FFD6AD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7DED600BDB5
      AD00000000000000000000000000000000006BC6DE0094E7FF007BE7FF0073DE
      FF0073DEFF0073DEFF0073DEFF0073DEFF0073DEFF0073DEFF0073DEFF0073DE
      FF0073DEFF0073DEFF0073DEFF0073DEFF0073DEFF0073DEFF005AC6F7003963
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF004A63E7007B94EF0094A5
      F700A5B5F70094A5F70094A5F7007B94EF007B94EF00738CEF00738CEF006B84
      EF006B84EF006B84EF006B84EF00637BEF00637BEF00637BEF00637BEF005A7B
      EF005A73EF005A73E700526BE7004A6BE7004A63E7004263E700315AE7003152
      E7002142D6001839B50008299C00FFFFFF00000000000000000000000000F7EF
      E700E7E7DE00EFE7E700F7F7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00F7F7EF007B4231007318000094290000731800008C523100F7EFE700FFF7
      EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00F7F7EF00EFEFE700EFDED600CEBD
      B500000000000000000000000000000000000000000000000000000000000000
      000000000000DEBDAD00F7E7DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      EF00FFFFE700FFFFD600FFF7C600FFEFB500FFEFB500FFEFB500FFEFB500FFF7
      C600FFF7EF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7DED600BDB5AD000000
      00000000000000000000000000000000000073C6E7009CEFFF0084E7FF0084E7
      FF0084E7FF0084E7FF0084E7FF0084E7FF0084E7FF009CEFFF009CEFFF009CEF
      FF009CEFFF009CEFFF009CEFFF009CEFFF009CEFFF009CEFFF007BD6F700527B
      8400000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF005A73EF006B84EF0094A5
      F70094A5F70094A5F7008C9CEF007B94EF00738CEF00738CEF006B84EF006B84
      EF00637BEF00637BEF00637BEF005A7BEF005A7BEF005A7BEF005A73EF005A73
      EF005273E700526BE7004A6BE7004A6BE7004263E700395AE7003152E7002952
      DE002142D6001839B5001839B500FFEFFF000000000000000000000000000000
      0000F7EFE700E7E7E700EFEFEF00F7F7F700FFF7EF00FFF7EF00FFF7EF00FFF7
      EF00FFF7EF00BDA59C005A210800520800005A210800CEB5A500FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00FFFFF700F7F7EF00F7EFE700E7D6CE00DECEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEBDAD00F7E7D600FFF7F700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFEFEF00DEBDAD00BDB5AD00000000000000
      00000000000000000000000000000000000073CEE700B5F7FF008CF7FF008CF7
      FF008CF7FF008CF7FF008CF7FF008CF7FF00CEF7FF00ADDEEF0084CEE70084CE
      E70084CEE70084CEE70084CEE70084CEE70084CEE70084CEE7006BC6DE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00CED6FF004A63E7006B84
      EF007B94EF00738CEF006B84EF00637BEF005A7BEF005A73EF005A73EF00526B
      E700526BE700526BE7004A6BE7004A6BE7004A6BE7004A6BE7004A63E7004263
      E7004263E700395AE700395AE700395AE700315AE7003152E7002952DE001842
      DE001839C6000831BD00ADB5DE00FFFFFF000000000000000000000000000000
      000000000000E7E7E700EFEFE700EFEFEF00F7EFF700F7F7F700FFF7EF00FFF7
      EF00FFF7EF00FFF7EF00E7DED600C6B5B500E7DED600FFF7EF00FFF7EF00FFF7
      EF00FFF7F700FFF7F700F7EFEF00F7EFE700E7D6CE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEBDAD00DEBDAD00F7E7DE00FFFFF700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7F7EF00DEBDAD00BDB5AD000000000000000000000000000000
      00000000000000000000000000000000000073C6E700CEF7FF00BDF7FF00ADFF
      FF00ADFFFF00ADFFFF00ADFFFF00CEF7FF009CD6EF003994C600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00BDCEF700637B
      EF004263E7004263E700395AE700315AE7003152E7003152E7003152E7003152
      E7003152E7003152E7003152E7003152E7002952E7002952E7002952E700214A
      E700214AE700214AE700214AE700214AE7001842DE001842DE001039DE001039
      DE003152CE00ADB5DE00FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000F7F7EF00F7EFEF00EFEFEF00EFF7F700F7F7
      F700F7F7F700FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7EF00FFF7F700F7F7
      F700F7F7F700F7EFE700E7DEDE00F7F7EF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DEBDAD00DEBDAD00F7E7
      D600F7EFE700FFF7EF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFEFEF00F7E7
      DE00D6C6BD00DEBDAD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084CEE70084CEE70084CE
      E70084CEE70084CEE70084CEE70073C6E70073BDD60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFEFFF00FFFFFF0000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFF7F700F7EFE700EFEF
      E700EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00EFEFEF00F7EFE700F7EF
      E700FFF7EF00FFF7F70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DEBD
      AD00DEBDAD00DEBDAD00DEBDAD00DEBDAD00DEBDAD00DEBDAD00DEBDAD00DEBD
      AD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000080000000C00000000100010000000000000C00000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFF00000000
      E000003FFFFFFFFFFFF01FFF00000000C000003FFFFFFFFFFF8003FF00000000
      C000003FE0000007FE0000FF00000000C000003FE0000007FC00007F00000000
      C000003FE0000007F800003F00000000C000003FE0000007F000001F00000000
      C000003FE0000007E000000F00000000C000003FE0000007C000000700000000
      C000003FE0000007C000000700000000C000003FE00000078000000300000000
      C000003FE00000078000000300000000C000003FE00000078000000300000000
      C000003FE00000070000000100000000C000003FE00000070000000100000000
      C000000FE00000070000000100000000C0000003E00000070000000100000000
      C0000001E00000070000000100000000C0000001E00000070000000100000000
      C0000033E00000070000000100000000C000003FE00000078000000300000000
      C000003FE00000078000000300000000C000003FE00000078000000300000000
      C000003FE0000007C000000700000000C000003FE0000007C000000700000000
      C000003FE0000007E000000F00000000C000003FE0000007F000001F00000000
      C000007FE000000FF800003F00000000C00000FFE000001FFC00007F00000000
      C00001FFFFFFFFFFFE0000FF00000000C00003FFFFFFFFFFFF8003FF00000000
      C00007FFFFFFFFFFFFF01FFF00000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFF1FFFFFFFF00FFFFFFFFFFF0000FFFFFE07FFFF
      FFC007FFFFFFFFFF0000FFFFFC01FFFFFF800FFFFFFFFFFF0000FFFFF8007FFF
      FF01FFFFFF8000030000FFFFF0001FFFFE07FFFFFF8000030000FFFFE0000FFF
      FC0FFFFFFF8000030000FFFFC000083FF80FFFFF000000030000FFFF8000000F
      F80FFFFF000000030000000300000007F80FFCFF000000030000000300000003
      F80FF87F0000000300000003000000038000F03F000000030000000300000003
      0000E01F0000000300000003800000038001C00F000000030000000300000007
      C003800700000003000000030000000FE007000300000003000000030001000F
      F00E0003000000030000000300010003F81E0001000000030000000380010001
      F83FE0030000000300000003E0010001FC7FE03F0000001F00000003FC030001
      FEFFE03F0000001F00000003FFFF0001FFFFE03F0000001F00000003FFFE0001
      FFFFE07F0000001FFE000003FFFE0001FFFFC07F0000001FFF000007FFFE0001
      FFFF80FF0000001FFF80000FFFFE0001FFFE01FF0000003FFFC0001FFFFE0001
      FFC003FF0007FFFFFFE0003FFFFC0001FFE00FFF800FFFFFFFF0007FFFFC0001
      FFF87FFFC01FFFFFFFF800FFFFFC0001FFFFFFFFFFFFFFFFFFFC01FFFFFFE001
      FFFFFFFFFFFFFFFFFFFF07FFFFFFFF03FFFFFFFFFF3F3E7FFFFFFFFFFFFFFFFF
      FFFFFFFFFF9F3E7FF800000FF800000FFFFFFFFFFF9E783FF000000FF000000F
      FFFFFFFFFFCE701FF000000FF000000FFFF01FFFFFC0001FF000000FF000000F
      FFF01FFFFFC0001FF000000FF000000FFFF01FFFFF90001FF000000FF000000F
      FFF01FFFFF900007F000000FF000000FFFF01FFFFF900003F000000FF000000F
      FFF01FFFFE000001F000000FF000000FFFF01FFFFC000001F000000FF000000F
      FFF01FFFFC000001F000000FF000000FFFF01FFFFC000000F000000FF000000F
      F000000FF0000000F000000FF000000FF000000FF0000000F000000FF000000F
      F000000FE0000000F000000FF000000FF000000FC0000000F000000FF000000F
      F000000FC0000000F000000FF000000FF000000FC0000000F000000FF000000F
      F000000F80000001F000000FF000000FFFF01FFF80000001F000000FF000000F
      FFF01FFF80000001F000000FF000000FFFF01FFF80000003F000000FF000000F
      FFF01FFF80000007F000000FF000000FFFF01FFF8000001FF000000FF000000F
      FFF01FFF8000003FF000000FF000000FFFF01FFFC000003FF000000FF000000F
      FFF01FFFC000003FF000001FF000001FFFFFFFFFC000007FF000003FF000003F
      FFFFFFFFE00000FFF000007FF000007FFFFFFFFFF00303FFF00000FFF00000FF
      FFFFFFFFFC07FFFFF00001FFF00001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFF81FFFFFFFFF3FFFFFFFFFFFC3C7FFFFE007FFFFFFFC0FFFFFFFFFFFC187FF
      FF8001FFFFFFF80FFFF81FFFFFE00FFFFE00003FFFFFF0078000000180000001
      F800000FFFFFE0070000000100000001E0000003FFFFC0070000000100000001
      80000001FFFF800F000000010000000100000001FFFF001F0000000300000003
      00000001FFFE003FFFF03FFFFFE00FFF00000001FFFC003FFFF83FFFFFC00FFF
      00000001FFF8001FFFF83FFFFFF83FFF00000001FFF0000FFFF81FFFFFF80FFF
      00000003FFE0001FFFF007FFFFE003FF00000003FFC00003FFC000FFFF8000FF
      80000003FF800E01FE00003FFE00001F80000003FF801F83F8000007F8000007
      80000007E0003F83E0000001C00000018000000FC0007FC08000000080000001
      8000000F80007FC000000000000000018000000F80007FC00000000000000001
      8000000F00007FC100000000000000018000000F00007F830000000000000001
      8000000F0E003F0100000001000000038000000F1E000C018000000F8000000F
      C000000F3F000003F000007FF000007FF800000FFE06001FFF0007FFFF0007FF
      FFE0000FFC06000FFFF03FFFFFF03FFFFFF8000FF80E211FFFFFFFFFFFFFFFFF
      FFF8000FF03FF1BFFFFFFFFFFFFFFFFFFFFF800FFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFF1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFF803FFFFF87FFFFFF83FFFFFFFFFFFFFC000FFFFE03FFFFFE00FFF
      FFFFFFFFFF00003FFF803FFFFF8003FFE007FFFFFE00001FFE0003FFFE00007F
      8000FFFFFC00000FF80001FFF000001F80000003F8000007E00001FFC0000007
      80000001F0000003800001FF0000000380000001F0000003000001FF00000003
      80000001E0000001000001FF0000000380000001E00000010000018300000003
      C0000003E00000000000010000000003E0000007E00000000000010000000007
      F000000FE0000000000001000000000FE000001F8000000000000180E00000FF
      C003001F00000000000001FFFC0003FF8003E00F0000000100000C7FF80001FF
      8001800F000000010000387FF00000FF00010007000080030000707FF00000FF
      0001000700008003000060FFF800007F0001000700008007000001FFFC00003F
      000100078000C00F000003FFFF00003F800100078000401F000047FFFFC0003F
      80030007C000403F00007FE7FFF0003FC003000FE000607F00007FC3FFF8007F
      E007000FF00061FF00007F83FFFE00FFF00F801FFC007FFF00007F03FFFFE07F
      F81FC03FFF007FFF0000FE07FFFFF03FFFFFE07FFFF0FFFF8001FC0FFFFFF81F
      FFFFFFFFFFFFFFFFFC07F81FFFFFFC1FFFFFFFFFFFFFFFFFFC1FF83FFFFFFE3F
      FFFFFFFFFFFFFFFFFFFFFC7FFFFFFFFFC0000003FFFFE7FFFFFFFFFFFFFFFFFF
      80000001FFFFC7FFFFE00FFFFFE7FFFF00000000FFFF87FFFF8003FFFFC3FC3F
      00000000FFFF07FFFF0000FFFF83C00F00000000FFFE07FFFC00003FFF838003
      00000000FFE003FFF800001FFF83000100000000FF0000FFF000000FFF800000
      00000000FC00003FF000000FFF80000000000000F800001FE0000007FF800000
      00000000F000000FE0000007FF80000000000000E0000007C0000003FF800000
      00000000C0000003C0000003FF80000000000000800000018000000180000000
      0000000080000001800000010000000000000000000000008000000100000000
      0000000000000000800000010000000000000000000000008000000100000000
      0000000000000000800000010000000000000000000000008000000100000000
      0000000000000000800000010000000000000000000000008000000100000000
      000000000000000080000001000000010000000000000001C000000300000007
      0000000000000001C0000003000001FF0000000080000003E0000007000001FF
      0000000080000003E0000007000003FF00000000C0000007F000000F00000FFF
      00000000E000000FF800001F00000FFF00000000F000001FFC00003F00001FFF
      00000000F800007FFE0000FF003FFFFF80000001FE0000FFFF8003FF807FFFFF
      C0000003FF8003FFFFE00FFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList3: TImageList
    AllocBy = 5
    Left = 190
    Top = 575
    Bitmap = {
      494C010105000900840010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFEFE700F7D6CE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FFF7F700BD6B4A00BD6B3900EFDED60000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F7EFEF00BD632900F7940000E7840800B55A2900EFE7DE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F7E7
      DE00B56B5200F7D6A500FFA50800FFAD1000E78C1800BD632100EFE7E7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFDED600BD73
      5A00F7DEAD00FFBD4200FFBD4200FFBD4200FFBD4200FFAD2100C6631800E7D6
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F7E7DE00C6846B00F7DE
      BD00FFDE7300FFD66B00FFD67300FFD67300FFD66B00FFD67300FFBD3900C66B
      2100E7D6D6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7E7E700BD735A00EFE7E700FFEF
      9C00FFEF9C00FFEF9C00FFEF9C00FFEF9C00FFEF9C00FFEF9400FFCE5A00F7A5
      1000C66B1800E7D6D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFCE4A00F7BD3100FFDE5A00FFD6
      5200FFF7D600FFFFC600FFFFBD00FFFFBD00FFF7B500FFBD5200FF733100FF73
      3100F7946300C67B5A00EFE7DE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFDE5A00FFFFC600FFFFC600FFFFCE00FFFFBD00AD521800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFD64200FFEF9C00FFEF7B00FFEF7B00FFEF7B00C6521000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFEFA500FFE78400FFE78C00FFE78C00FFE78C00FFBD9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      00000000000052527B004242730039396B003939730039397300525273000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000527B520042734200396B39003973390039733900527352000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000006B6B
      8C00425294006B84C60094B5E700A5CEEF0094BDE70094BDE700738CC6004A52
      9400525273000000000000000000000000000000000000000000000000006B8C
      6B00429442006BC66B0094E79400A5EFA50094E7940094E7940073C673004A94
      4A0052735200000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000737394004A5A
      A50084ADEF009CCEF700ADD6F700B5DEFF00ADD6FF00ADD6FF009CCEF7008CB5
      EF004A5AA5005252730000000000000000000000000000000000739473004AA5
      4A0084EF84009CF79C00ADF7AD00B5FFB500ADFFB500ADFFB5009CF79C008CEF
      8C004AA54A00527352000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000039428C006B94
      E70084B5EF0094BDF700A5CEF700ADCEF700A5CEF700A5CEF70094BDF70084B5
      EF00739CE700424A8C0000000000000000000000000000000000398C39006BE7
      6B0084EF840094F79400A5F7AD00ADF7AD00A5F7AD00A5F7AD0094F7940084EF
      840073E77300428C42000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000006B6B94004A5ABD006B94
      E7007BA5EF0084ADEF008CB5F70094B5F7008CB5F7008CB5F70084ADEF007B9C
      EF006B94E7004A5AB5004A4A730000000000000000006B946B004ABD4A006BE7
      6B007BEF7B0084EF84008CF78C0094F794008CF78C008CF78C0084EF84007BEF
      7B006BE76B004AB54A004A734A0000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000004A4A7B004A63CE006384
      E7006B8CEF007394EF00739CF700739CEF00739CEF00739CEF006B94EF006B8C
      E700637BDE004A63CE003939730000000000000000004A7B4A004ACE4A0063E7
      63006BEF6B0073EF730073F7730073EF730073EF730073EF73006BEF6B006BE7
      6B0063DE63004ACE4A003973390000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000004A4A7B004A63CE006384
      E7006B8CEF007394EF00739CF700739CEF00739CEF00739CEF006B94EF006B8C
      E700637BDE004A63CE003939730000000000000000004A7B4A004ACE4A0063E7
      63006BEF6B0073EF730073F7730073EF730073EF730073EF73006BEF6B006BE7
      6B0063DE63004ACE4A003973390000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF0000000000424273004252D6004A63
      E7005273EF005A73EF005A7BEF00637BEF005A7BEF005A7BEF005A73E700526B
      DE004A63DE004252CE0039396B0000000000000000004273420042D642004AE7
      4A0052EF52005AEF5A005AEF5A0063EF63005AEF5A005AEF5A005AE75A0052DE
      52004ADE4A0042CE4200396B390000000000FF00FF00FF00FF00FF00FF00FF00
      FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000004A4A7B002931C6002931
      DE003139EF003142EF003942EF003942EF003142E7003142E7003142DE002939
      D6002931CE002931BD004242730000000000000000004A7B4A0029C6290029DE
      290031EF310031EF310039EF390039EF390031E7310031E7310031DE310029D6
      290029CE290029BD29004273420000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000073739C002118B5001010
      D6001010E7001810EF001818EF001818EF001810DE001810DE001810D6001010
      C6001010BD001818A50052527B000000000000000000739C730018B5180010D6
      100010E7100010EF100018EF180018EF180010DE100010DE100010D6100010C6
      100010BD100018A51800527B520000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000000000000039398C004242
      DE005252E700635AEF00635AF7006363EF006363EF006363EF005A5ADE005A52
      D6004A4ACE0039398C0000000000000000000000000000000000398C390042DE
      420052E752005AEF5A005AF75A0063EF630063EF630063EF63005ADE5A0052D6
      52004ACE4A00398C39000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF0000000000000000008484A5005A52
      A5009C9CEF00B5B5F700B5B5F700BDB5F700B5B5F700B5B5F700B5B5EF00A5A5
      E7005A5AA5006B6B8C000000000000000000000000000000000084A5840052A5
      52009CEF9C00B5F7B500B5F7B500B5F7BD00B5F7B500B5F7B500B5EFB500A5E7
      A5005AA55A006B8C6B000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000008484
      A50063639400ADADCE00CECEE700DEDEF700CECEE700CECEE700ADADCE006363
      94007373940000000000000000000000000000000000000000000000000084A5
      840063946300ADCEAD00CEE7CE00DEF7DE00CEE7CE00CEE7CE00ADCEAD006394
      630073947300000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      00000000000073739C004A4A8400424273004A4A7B004A4A7B006B6B94000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000739C73004A844A00427342004A7B4A004A7B4A006B946B000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FFFF000000000000FFFF000000000000
      FFFF000000000000FCFF000000000000F87F000000000000F03F000000000000
      E01F000000000000C00F00000000000080070000000000000003000000000000
      0001000000000000F03F000000000000F03F000000000000F03F000000000000
      FFFF000000000000FFFF000000000000FFFFFFFF00000000F81FF81F00000000
      E007E00700000000C003C00300000000C003C003000000008001800100000000
      8001800100000000800180010000000080018001000000008001800100000000
      8001800100000000C003C00300000000C003C00300000000E007E00700000000
      F81FF81F00000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
  object pmChangeTextColor: TPopupMenu
    OwnerDraw = True
    OnPopup = pmChangeTextColorPopup
    Left = 10
    Top = 575
  end
  object ImageList2: TImageList
    AllocBy = 33
    Left = 160
    Top = 575
    Bitmap = {
      494C010122002900940010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009000000001002000000000000090
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000006000000060000000600000006000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000080000000A0200000A02000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000080000000A0400000C04000008000000060000000600000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF0000E7E70000E7E700FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000080000040A0400040C040000080000000A0200000800000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7FFFF0042E7E70000E7E70000E7E70042E7E700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000060000000600000006000000060
      00000080000040C0400040C06000008000000060000000600000006000000060
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF0042E7E70000E7E70000E7E70000E7E70000E7E70042E7E700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000080000040C0600040C0600040C0
      600040C0600040C0600040C0600040A0400000A0400000A0200000A020000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084E7E70000E7E70000E7E70000E7E70000E7E70000E7E70000E7E70042E7
      E700FFFFFF00FFFFFF00FFFFFF00FFFFFF000080000040E0800040E0800040E0
      800040E0800040E0600040C0600040C0600040C0400000C0400000A040000080
      0000006000000060000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF0084E7
      E70084E7E70042E7E70000E7E70000E7E70000E7E70000E7E70000FFFF0000FF
      FF0042E7E700FFFFFF00FFFFFF00FFFFFF000080000000A0200000A0200000A0
      20000080200040E0800040C06000008020000080200000802000008020000080
      000000A020000080000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF0084E7E70084E7
      E70084E7E70084E7E70042E7E70000E7E70000E7E70000FFFF0000FFFF0000FF
      FF0000FFFF0042E7E700FFFFFF00FFFFFF0000000000000000000080000040E0
      80000080000040E0800040E080000080000040C0600040C0600040C0400000C0
      400000A040000080000000600000006000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF0084E7E70084E7E70084E7
      E70084E7E70084E7E70084E7E70042E7E70000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0042E7E700FFFFFF0000000000000000000080000000A0
      20000080000040E0800040E080000080000040C0600000802000008020000080
      2000008020000080000000A02000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00F7FFFF0084E7E70084E7
      E70084E7E70084E7E70084E7E700F7FFFF0084E7E70000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084E7E700FFFFFF000000000000000000000000000000
      00000080000040E0800040E080000080000040E080000080000040C0600040C0
      600040C0400000C0400000A04000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00F7FFFF0084E7
      E70084E7E70084E7E700F7FFFF00F7FFFF00FFFFFF0084E7E70000FFFF0000FF
      FF0000FFFF0084E7E700FFFFFF00FFFFFF000000000000000000000000000000
      00000080000040A0400040A040000080000040E080000080000040C060000080
      2000008020000080200000802000008000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00F7FF
      FF0084E7E700F7FFFF00F7FFFF00FFFFFF00FFFFFF00FFFFFF0084E7E70000FF
      FF0084E7E700FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000080000040E0800040E080000080000040E080000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084E7
      E700FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000000000000080000040A0400040A040000080000040E080000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000080000040E0800040E080000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000080000040A0400040A040000080
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000737373006B6B6B005A5A5A0073737300737373007373
      730000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000F7FFFF0084C6E70084C6E70084C6E70084C6E700F7FFFF000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A5008484840094848400736B6B004A4A4A00525252008C8C
      8C0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000F7FF
      FF0042A5E7000084E7000084E7000084E7000084E7000084E7000084E70042A5
      E700F7FFFF000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500A5A5A500B5A5A500BDA5A500E7BDBD00947B7B007B7B
      7B0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000F7FFFF000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E700F7FFFF0000000000000000000000FF000000FF000000FF000000
      FF000000FF004263E700C6A5E700F7FFFF00F7FFFF00C6A5E7004263E7000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500A5A5A500737373004A4A4A005A5252006B5A5A007B7B
      7B0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F7FFFF0084E7C60084E7A500C6DEC600FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F7FFFF000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E700F7FFFF00000000000000FF000000FF000000FF000000
      FF004263E700F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF004263
      E7000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500ADADAD0073737300525252004A4A4A006B6363007B7B
      7B0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF0084E7A500C6DEC600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000042A5E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E70042A5E700000000000000FF000000FF000000FF000000
      FF00C6A5E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6A5
      E7000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500B5B5B500848484004A4A4A005A525200636363007B7B
      7B0000000000000000000000000000000000FFFFFF00FFFFFF00C6DEC600C6DE
      C600C6DEC600FFFFFF00FFFFFF00C6DEC60084E7A500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E7000084E700F7FFFF000000FF000000FF000000FF000000
      FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FF
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500BDBDBD007B7B7B005A5A5A004A4A4A00636363007B7B
      7B0000000000000000000000000000000000F7FFFF00C6DEC60084E7A50084E7
      A50084E7A500C6DEC600FFFFFF00F7FFFF0084E7A500C6DEC600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0084C6E7000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E7000084E70084C6E7000000FF000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500BDBDBD0052CE7B0042C66B0052C67B0052635A007B7B
      7B0000000000000000000000000000000000F7FFFF00F7FFFF00C6DEC60084E7
      A50084E7A50042C68400C6DEC600FFFFFF00F7FFFF0084E7C600F7FFFF00F7FF
      FF00FFFFFF00FFFFFF00F7FFFF00FFFFFF0084C6E7000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E7000084E70084C6E7000000FF000000FF000000FF000000
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500C6C6C60063D68C0039D66B0042E77B00426B4A007B7B
      7B0000000000000000000000000000000000FFFFFF00F7FFFF00F7FFFF00C6DE
      C600C6DEC60084E7A50084C6A500F7FFFF00FFFFFF00F7FFFF00C6DEC600C6DE
      C60084E7C60084E7C60084E7C60084E7C60084C6E7000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E7000084E70084C6E7000000FF000000FF000000FF000000
      FF00F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FF
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500CECECE0073E794004AE7840031CE6300396342007B7B
      7B0000000000000000000000000000000000FFFFFF00FFFFFF00F7FFFF00F7FF
      FF00C6DEC600C6DEC60084E7A50084E7A500F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00C6DEC60084E7C60084E7A500C6DEC60084C6E7000084E7000084E7000084
      E7000084E7000084E7000084E7000084E7000084E700F7FFFF0042A5E70084E7
      E70042A5E7000084E7000084E70084C6E7000000FF000000FF000000FF000000
      FF00C6A5E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6A5
      E7000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500CECECE0063AD73004ABD630039AD5A004A6352007B7B
      7B0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00F7FF
      FF00F7FFFF00C6DEC60084E7C60084E7A500C6DEC600FFFFFF00F7FFFF00C6DE
      C60084E7C600C6DEC600C6DEC600F7FFFF00F7FFFF000084E7000084E7000084
      E7000084E7000084E7000084E7000084E70084E7E700F7FFFF0084E7E70084C6
      E70084C6E7000084E7000084E700F7FFFF000000FF000000FF000000FF000000
      FF004263E700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004263
      E7000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500C6C6C6008C8C8C008C8C8C008C8C8C006B6B6B008C8C
      8C0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00C6DEC600C6DEC600C6DE
      C600C6DEC600F7FFFF00F7FFFF00FFFFFF000000000042A5E7000084E7000084
      E7000084E7000084E7000084E7000084E700F7FFFF00F7FFFF00C6DEC60042A5
      E70084E7E7000084E70042A5E700000000000000FF000000FF000000FF000000
      FF000021E700F7FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF000021
      E7000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A500ADADAD00636363007B7B7B008C8C8C00848484008C8C
      8C0000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6DEC600F7FFFF00F7FF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000F7FFFF000084E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E7000084E700F7FFFF00000000000000FF000000FF000000FF000000
      FF000000FF008484E700FFFFFF00FFFFFF00FFFFFF00F7FFFF008484E7000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000A5A5A50031292900734A4A008C8C8C008C8C8C008C8C8C000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F7FFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000000084C6E7000084
      E7000084E7000084E7000084E7000084E7000084E7000084E7000084E7000084
      E7000084E70084C6E70000000000000000000000FF000000FF000000FF000000
      FF000000FF000021E70084A5E700F7FFFF00F7FFFF0084A5E7000021E7000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000007B7373009C8484000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000000084E7
      E70042A5E7000084E7000084E7000084E7000084E7000084E7000084E70042A5
      E70084E7E7000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF004242E7008463E7008463E7004242E7000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      000000000000000000007B7B7B009C8484000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      00000000000084E7E70084C6E70042A5E70042A5E70084C6E70084E7E700FFFF
      FF00000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00000000008C8C8C00525252007373
      7300000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5736B0073424200734242007342420073424200734242007342
      420073424200734242007342420000000000000000008C8C8C00525252007373
      7300000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00ADADAD0073738C00AD848C005A5A
      5A00737373000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5736B00FFFFE700F7EFDE00F7EFD600F7EFD600F7EFD600F7E7
      CE00F7EFD600EFDEC6007342420000000000ADADAD0073738C00AD848C005A5A
      5A00737373000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF008CB5CE00428CDE007373AD00AD8C
      8C005A5A5A007373730000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5736B00F7EFDE00F7DEBD00F7D6BD00F7D6BD00EFD6B500EFD6
      B500EFDEBD00E7D6BD0073424200000000008CB5CE00428CDE007373AD00AD8C
      8C005A5A5A007373730000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00BDE7FF0052BDFF004284DE007B7B
      A500AD8C8C005A5A5A0073737300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5736B00FFEFDE00FFC69400FFC69400FFC69400FFC69400FFC6
      9400FFC69400E7D6BD007342420000000000BDE7FF0052BDFF004284DE007B7B
      A500AD8C8C005A5A5A0073737300000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF0000000000A5DEFF0052BDFF004284
      DE007B7BA500AD8C8C005A5A5A00949494000000000000000000000000000000
      00000000000000000000000000000000000000000000A5736B00734242007342
      420073424200A5736B00FFF7E700F7DEBD00F7D6B500F7D6B500F7D6B500F7D6
      AD00F7DEC600E7D6C60084524A000000000000000000A5DEFF0052BDFF004284
      DE007B7BA500AD8C8C005A5A5A00949494000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF0000000000000000008CCEFF0052BD
      FF004284D6007B7BA5009C7B840084848400A5A5A5006B6B6B00525252005252
      5200636363008C8C8C00000000000000000000000000A5736B00FFFFE700F7EF
      DE00F7EFD600A5736B00FFF7EF00FFDEBD00FFDEBD00FFDEB500F7D6B500F7D6
      B500F7DEC600E7D6C60084524A000000000000000000000000008CCEFF0052BD
      FF004284D6007B7BA5009C7B840084848400A5A5A5006B6B6B00525252005252
      5200636363008C8C8C000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000008CCE
      FF0052BDFF005A8CCE008C8C8C008C737300BD9C8400CEB59400E7C6AD00D6B5
      A5008C737300525252008C8C8C000000000000000000A5736B00F7EFDE00F7DE
      BD00F7D6BD00A5736B00FFFFF700FFC69400FFC69400FFC69400FFC69400FFC6
      9400FFC69400EFDECE008C5A5A00000000000000000000000000000000008CCE
      FF0052BDFF005A8CCE008C8C8C008C737300BD9C8400CEB59400E7C6AD00D6B5
      A5008C737300525252008C8C8C0000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      0000A5DEFF00CED6D600AD8C8C00F7CEAD00FFF7C600FFFFD600FFFFDE00FFFF
      DE00F7EFE7009C848400525252008C8C8C0000000000A5736B00FFEFDE00FFC6
      9400FFC69400A5736B00FFFFFF00FFE7CE00FFE7C600FFDEC600FFDEC600FFE7
      C600FFF7DE00E7D6CE008C5A5A00000000000000000000000000000000000000
      0000A5DEFF00CED6D600AD8C8C00F7CEAD00FFF7C600848CDE00848CDE00FFFF
      DE00F7EFE7009C848400525252008C8C8C00FF00FF00FF00FF00FF00FF00FF00
      FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000E7CECE00EFCEA500FFF7C600FFF7C600FFFFDE00FFFFEF00FFFF
      FF00FFFFFF00F7EFDE007B6363006B6B6B0000000000A5736B00FFF7E700F7DE
      BD00F7D6B500A5736B00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700E7D6
      D600C6B5AD00A59494009C635A00000000000000000000000000000000000000
      000000000000E7CECE00EFCEA500FFF7C600848CDE000031FF000031FF00848C
      DE00FFFFFF00F7EFDE007B6363006B6B6B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000E7BDB500FFF7C600FFE7B500FFFFC600FFFFDE00FFFFEF00FFFF
      FF00FFFFF700FFFFDE00B59C8C005252520000000000A5736B00FFF7EF00FFDE
      BD00FFDEBD00A5736B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A573
      6B00A5736B00A5736B00A5736B00000000000000000000000000000000000000
      000000000000E7BDB500FFF7C600214AF7000031FF00214AFF000031FF004263
      FF00FFFFF700FFFFDE00B59C8C0052525200FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000E7BDA500FFF7CE00FFDEAD00FFF7C600FFFFD600FFFFE700FFFF
      EF00FFFFE700FFFFDE00CEB59C005252520000000000A5736B00FFFFF700FFC6
      9400FFC69400A5736B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A573
      6B00E7A55200B5735A0000000000000000000000000000000000000000000000
      000000000000E7BDA500FFF7CE00425AEF00848CDE00FFFFD6006384F7000031
      FF00848CDE00FFFFDE00CEB59C0052525200FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000E7BDA500FFF7CE00FFE7BD00FFEFBD00FFFFCE00FFFFD600FFFF
      DE00FFFFDE00FFFFD600CEAD94006B6B6B0000000000A5736B00FFFFFF00FFE7
      CE00FFE7C600A5736B00A5736B00A5736B00A5736B00A5736B00A5736B00A573
      6B00AD6B6B000000000000000000000000000000000000000000000000000000
      000000000000E7BDA500FFF7CE00FFE7BD00FFEFBD00FFFFCE00FFFFD6001042
      FF00214AFF00FFFFD600CEAD94006B6B6B00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000E7C6B500FFF7CE00FFF7D600FFE7BD00FFF7BD00FFF7C600FFFF
      C600FFF7C600FFF7C600B59484008C8C8C0000000000A5736B00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700E7D6D600C6B5AD00A59494009C635A000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E7C6B500FFF7CE00FFF7D600FFE7BD00FFF7BD00FFF7C6008C9C
      DE000031FF008494E700B59484008C8C8C00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      000000000000DEC6C600EFDEC600FFFFFF00FFF7EF00FFEFBD00FFDEAD00FFE7
      B500FFF7BD00F7D6AD00947373000000000000000000A5736B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A5736B00A5736B00A5736B00A5736B000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DEC6C600EFDEC600FFFFFF00FFF7EF00FFEFBD00FFDEAD00FFE7
      B5003152F7003152EF009473730000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      00000000000000000000DEBDBD00F7E7DE00FFFFEF00FFFFCE00FFEFBD00FFF7
      C600F7CEA500BD948C00000000000000000000000000A5736B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A5736B00E7A55200B5735A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEBDBD00F7E7DE00FFFFEF00FFFFCE00FFEFBD00FFF7
      C600F7CEA500BD948C000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      0000000000000000000000000000DEC6C600D6B59C00CEAD8C00E7BD9C00DEB5
      A5008C8C8C0000000000000000000000000000000000A5736B00A5736B00A573
      6B00A5736B00A5736B00A5736B00A5736B00AD6B6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEC6C600D6B59C00CEAD8C00E7BD9C00DEB5
      A5008C8C8C00000000000000000000000000000000008C7B73007B6B63007363
      5A0073635A0073635A0073635A0073635A0073635A0073635A0073635A007B6B
      63008C7B73000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00AD7B6B00DEAD9C00D6AD9C00D6A5
      9C00D6A59400CEA59C00CE9C9400C69C9400C69C9400C6949400B5948C00C694
      8C007B6B63000000000000000000000000000000000000000000944239009442
      3900C69C9C00C69C9C00C69C9C00C69C9C00C69C9C00C69C9C00C69C9C009431
      2900944239000000000000000000000000000000000000000000000000000000
      000000000000000000005A6373005A637300636B8400636B84005A6373000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00B5847300FFE7CE00FFE7CE00FFDE
      C600FFDEC6008C5A5A008C5A5A00F7CEB500A5736B00A5736300AD7B6B00FFC6
      A50073635A000000000000000000000000000000000094423900CE636300C663
      6300E7E7E7009429290094292900E7E7E700E7E7E700E7E7E700CECECE009429
      29009C4242009442390000000000000000000000000000000000000000000000
      0000636B84004252BD001831DE000821CE000818B5004252B500636B8C006B6B
      6B005A637300000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00BD8C7300FFE7CE00FFE7CE00FFE7
      CE00FFDEC6008C5A5A008C5A5A00EFCEB500FFCE9400FFC68400FFCE9C00F7BD
      A50073635A000000000000000000000000000000000094423900CE636300C663
      6300E7E7E7009429290094292900E7E7E700E7E7E700E7E7E700CECECE009429
      29009C424200944239000000000000000000000000000000000000000000636B
      84001029EF001029F7001029F7001029F7001029F7001029F7000821CE004A52
      AD00636B8400636B84000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00C68C7B00FFE7D600FFE7D600FFE7
      CE00FFE7CE00FFDEC600EFD6BD00B59C8C00735A3900846B4A009C847300D6AD
      9400735A52000000000000000000000000000000000094423900CE636300C663
      6300E7E7E7009429290094292900E7E7E700E7E7E700E7E7E700CECECE009429
      29009C42420094423900000000000000000000000000000000001029F7001029
      F7001029F7002139F7000821D6000821D6000821D6001029F7001029F7000821
      D6004A5AA5006B6B6B000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00CE947B00FFEFDE002900DE002900
      DE00FFE7CE003910DE002900DE009473BD00CE8C390094737300734A3100846B
      5A00524A42000000000000000000000000000000000094423900CE636300C663
      6300E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700CECECE009429
      29009C42420094423900000000000000000000000000000000001029F7001029
      F7001029F700000000000000000000000000000000002139F7001029F7001029
      F7000821C6005A637300636B840000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00CE9C8400FFEFDE002900DE002900
      DE00FFE7D600FFE7CE00FFE7CE00F7D6C6008C8C8400BDA57B00EFB57300B57B
      4200523118005252520000000000000000000000000094423900CE636300C663
      6300CE636300C6737300C6737300CE6B6B00C6636300CE6B6B00CE636300C663
      6300CE636300944239000000000000000000000000001029F7001029F7000821
      D600000000000000000000000000000000002139F7001029F7001029F7001029
      F7001029EF005263A5005A63730000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00D6A58400FFEFE700FFEFDE00FFEF
      DE00FFEFD600FFE7D600FFE7D600FFE7CE00FFE7CE00E7C6A500E7AD7B00FFD6
      B500F7C69400BD844A006B6B6B007B7B84000000000094423900BD636300C67B
      7B00CE9C9C00CEADAD00CEADAD00CEADAD00CEA5A500CEA5A500CEADAD00CEAD
      AD00CE636300944239000000000000000000000000002139F7001029F7000821
      D6000000000000000000000000002139F7001029F7002139F700000000000821
      D6001029F7004252BD00636B840000000000FF00FF00FF00FF00FF00FF00FF00
      FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFF7E700FFEFE700FFEF
      DE00FFEFDE008C5A5A008C5A5A00F7DECE00A5737300A5737300CEA59400EFBD
      A500B5845200C6AD94005A73D600395ABD000000000094423900CE636300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE636300944239000000000000000000000000001029F7001029F7000821
      D60000000000000000002139F7001029F7002139F70000000000000000000821
      D6001029F7005263BD00636B840000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF000000000000000000FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFF7EF00FFF7E700FFEF
      E700FFEFDE008C5A5A008C5A5A00FFE7D600E7CEBD00E7CEBD00F7D6BD00F7CE
      BD0073635A00000000009C9CCE00ADB5DE000000000094423900CE636300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE636300944239000000000000000000000000001029F7001029F7000821
      D600000000002139F7001029F7002139F7000000000000000000000000000821
      D6001029F7005263BD000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF0000000000000000000000000000000000FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFF7EF00FFF7EF00FFF7
      E700FFEFE700FFEFE700FFEFDE00FFEFDE00FFEFD600FFE7D600FFE7D600F7CE
      BD007B635A000000000000000000000000000000000094423900CE636300FFFF
      FF00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00FFFF
      FF00CE636300944239000000000000000000000000001029F7001029F7001029
      F7002139F7001029F7002139F700000000000000000000000000000000001029
      F7001029F700636B84000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF000000000000000000FF00FF00FF00FF000000000000000000FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFFF7008C5A5A008C5A
      5A00F7E7DE008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A00EFCEBD00F7CE
      BD008C7B73000000000000000000000000000000000094423900CE636300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE63630094423900000000000000000000000000000000001029F7001029
      F7001029F7001029F700000000000000000000000000000000002139F7001029
      F7001029F700000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00000000000000
      0000FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFFF7008C5A5A008C5A
      5A00FFF7EF00FFF7EF00FFF7E700FFEFE700FFD6CE00FFD6CE00F7B5AD00B58C
      7B008C7B73000000000000000000000000000000000094423900CE636300FFFF
      FF00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00CECECE00FFFF
      FF00CE63630094423900000000000000000000000000000000001029F7001029
      F7001029F7000821D6000821D6000821C6000821D6001029F7001029F7001029
      F70000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFFFF00FFFFF700FFFF
      F700FFF7F700FFF7EF00FFF7EF00FFF7E700F7A54200F7A54200E79442009484
      7B00000000000000000000000000000000000000000094423900CE636300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00CE6363009442390000000000000000000000000000000000000000001029
      F7001029F7001029F7001029F7001029F7001029F7001029F7001029F7000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400FFFFFF00FFFFFF00FFFF
      FF00FFFFF700FFFFF700FFF7EF00FFF7EF00DEAD8400EFB573008C7363000000
      000000000000000000000000000000000000000000000000000094423900FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00944239000000000000000000000000000000000000000000000000000000
      0000000000001029F7001029F7001029F7001029F70000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00DEAD8400DEAD8400DEAD8400DEAD
      8400DEAD8400DEAD8400DEAD8C00D6A58400DEAD84008C7B7300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
      FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006B635A006B635A006B635A006B63630073737300000000000000
      000000000000000000000000000000000000000000000000000000000000BDA5
      94006B5242006B4A3900634A3100634A3100634A3100634A3100634A3100634A
      3100634A3100634A3100634A3100634A3100B5A59400634A3100634A3100634A
      3100634A3100634A3100634A3100634A3100634A310000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000063636300636363000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C66B2900A5633100BD631800B5521000AD4A1800B56B2900000000000000
      000000000000000000000000000000000000000000000000000000000000BDA5
      9400FFFFF700EFE7DE00EFD6C600E7CEBD00E7C6B500DEBDAD00DEB5A500DEAD
      9C00D6A58C00D6A58C00D69C8400634A3100B5A59400FFFFFF00EFE7DE00EFDE
      D600E7DED600E7D6CE00DECEBD00D6C6BD00634A310000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000063636300B59C9C00E7D6D6006363630063636300000000000000
      000000000000000000000000000000000000000000000000000000000000C66B
      2900CE732100D67B2100B5632100000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000BDAD
      9C00FFFFFF00FFF7F700FFF7F700F7EFE700F7E7DE00F7DED600F7DECE00F7D6
      C600F7D6C600EFCEBD00D6A58C00634A3100B5A59400FFFFFF00EFB59C00E7B5
      9400DEAD9400D6A59400CEA58C00D6C6BD00634A3100634A3100634A3100634A
      3100634A3100634A3100634A3100634A31000000000000000000000000000000
      00006363630073636300A59C9C00FFE7E700E7CECE00D6B5B500636363006363
      6300000000000000000000000000000000000000000000000000C66B2900D67B
      2100EF942900B563210000000000000000000000000000000000000000000000
      00000000000000000000000000000000000073848C006B7B8400636B7300BDAD
      9C00FFFFFF00C6ADA500B59C9400AD9C8C00AD948400A5948400F7DED600F7DE
      CE00F7D6C600EFD6C600DEAD9C00634A3100BDA59400FFFFFF00FFFFFF00FFF7
      F700F7EFEF00EFE7DE00EFDED600D6C6BD00634A3100E7CEBD00DEC6B500DEBD
      AD00D6B5A500D6AD9400CEA58C00634A31000000000000000000000000006363
      6300846B6B0094847B00C6949400C6949400E7BDBD00DEADAD00D6ADAD00CEAD
      A500636363006363630000000000000000000000000000000000C66B2900E78C
      2900DE8421008452310000000000000000000000000000000000000000000000
      00000000000000000000000000000000000073849400A5DEF70073CEEF00C6AD
      9C00FFFFFF00D6C6B500C6AD9C00C6AD9C00BDA59400B5A59400B59C8C00F7DE
      D600F7DECE00F7D6C600DEB59C00634A3100C6AD9C00FFFFFF00EFB59C00E7B5
      9400DEAD9400D6A59400CEA58C00D6C6BD00634A3100F7EFE700F7E7DE00EFDE
      D600EFD6C600E7CEBD00D6AD9400634A31000000000000000000636363009C7B
      7B00AD948400738CA50063ADD6008CC6CE00C6949400C6949400D69C9C00CE94
      9400CE8C8C00B5948C0063636300000000000000000000000000C66B2900EF94
      3100DE8421007B4A290052524A00736B63000000000000000000B55A1800BD52
      0000000000000000000000000000000000007B8C9400ADEFF70094E7FF00C6B5
      A500FFFFFF00FFFFFF00FFFFFF00FFFFF700FFF7F700FFEFEF00F7EFE700F7E7
      DE00F7E7D600F7DECE00DEBDA500634A3100C6B5A500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7EFE700DED6D600D6C6BD00634A3100C6B5AD00F7EFE700F7E7
      DE00EFDED600EFD6C600D6B5A500634A31000000000063636300B58C8C00A594
      8C005A94B5001073DE004AADF7009CFFFF008CDEE7008CBDCE00C6949400C694
      9400CE8C8C00CE8C8C006363630000000000C66B2900C66B2100E78C2900EF94
      3100E78C2900C66B1800BD5A1000A56B420000000000AD633100C6630000CE63
      0000AD5208000000000000000000000000007B8C9C00B5EFF7009CEFFF00CEB5
      A500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7EF00FFEF
      E7001842D60021429C00E7C6B500634A3100CEBDAD00FFFFFF00EFB59C00E7B5
      9400DEAD9400B5A59400634A3100634A3100634A3100D6C6BD00D6CEC600F7EF
      E700F7E7DE00EFDED600DEBDAD00634A310063636300C6949400AD9C9C00429C
      CE00187BF7001073DE0008A5F70021DEF70073FFFF0094FFFF008CE7EF0084BD
      CE00C6949400C6949400636363000000000000000000C66B2900EF9C3100EF94
      3100EF942900DE842100B563210000000000CE630000CE630000CE630000CE63
      0000C66300009C521800000000000000000084949C00B5EFFF00ADEFFF00CEB5
      A500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF7F700FFF7
      EF00395AF7001842D600EFD6CE006B4A3900D6BDAD00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00BDA59400D6C6BD00634A3100E7DEDE00FFFFFF00FFFFF700FFF7
      EF001842D60021429C00DEC6B500634A3100CEA59C00A5A5AD0029A5DE0000AD
      FF00108CF700089CFF0021C6EF00429CBD0000ADE70018CEF7005AF7FF0084FF
      FF0073CEDE006363630000000000000000000000000000000000C66B2900EF94
      3100E78C2900BD6B210000000000CE630000BD5A0800CE630000CE630000CE63
      0000CE630000BD5A0000AD6B31000000000084949C00BDF7FF00ADF7F700CEB5
      A500FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      F700FFF7F700FFF7EF00F7EFE7006B5A4200DEC6B500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00C6B5A500634A3100E7DEDE00FFFFFF00FFFFFF00FFFFFF00FFF7
      F700395AF7001842D600E7CEBD00634A3100C6ADAD0042B5DE0000B5FF001094
      FF001094FF0008B5EF00429CB50039CEEF00219CC60031B5DE0000A5D60010BD
      E70052C6E700636363000000000000000000000000000000000000000000C66B
      2900CE73210000000000CE630000A5735200A5735200C6733100CE630000CE63
      0000AD521000A5735200A5735200A5735200849CA500BDF7FF00B5EFFF00CEB5
      A500CEB5A500CEB5A500C6B5A500C6ADA500C6AD9C00C6AD9C00BDAD9C00BDA5
      9C00BDA59400BDA59400BDA59400BDA59400DEC6B500DEC6B500D6BDAD00D6BD
      AD00CEBDAD00CEB5A500EFE7DE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFF7F700FFF7EF00F7EFE700634A31000884D6000884D6000884D6001094
      FF0010BDFF00429CB50042BDDE00219CC6004AB5D60021C6EF004ABDDE0018A5
      DE00636363000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B55A1800C6630000C663
      00008C5229000000000000000000000000008C9CA500BDF7FF00B5EFFF00B5EF
      FF00ADF7F700A5EFFF0094E7FF008CE7FF007BDEFF006BD6FF0063CEF70052C6
      F7004ABDEF00189CCE0063737B0000000000000000000000000000000000C6AD
      A500EFDECE00EFDECE00EFDECE00EFDECE00E7D6CE00E7CEC600E7C6BD00DEBD
      AD00DEB5A500D6AD9C00D6AD9400AD948C000894D60010A5EF0018B5EF0021A5
      E7006BD6E70084CEDE0031C6E70031B5D60018B5DE0052A5BD0021B5E7006363
      6300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B55A1800CE630000BD5A
      0000AD7342000000000000000000000000008CA5AD00BDF7FF00BDF7FF00BDF7
      FF00BDF7FF00B5F7FF00ADEFFF00A5EFFF0094E7FF008CDEFF007BDEFF0073D6
      FF006BCEF7005ABDEF0063737B00000000000000000000000000000000000000
      0000CEB5AD00F7EFEF00FFFFFF00FFF7F700FFF7EF00F7EFE700F7E7DE00F7DE
      D600EFDECE00EFD6CE00B59C8C000000000010ADDE0042F7FF0018B5EF000884
      D6006BE7FF006BEFF70094E7E7007BE7F70052B5D60021B5E700428CAD006363
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000000000008C847B00846B5A00A55A2900CE630000C65A0000AD73
      4200000000000000000000000000000000008CA5AD008CA5AD008CA5AD008CA5
      AD008CA5AD008C9CAD008C9CA5008C9CA500849CA500849CA5008494A5008494
      A5008494A50084949C0000000000000000000000000000000000000000000000
      000000000000CEB5AD00F7EFEF00FFFFFF00FFFFFF00FFF7F700F7EFEF00F7EF
      E700EFD6CE00B59C8C00000000000000000063B5CE006BD6EF006BEFFF0031BD
      E70039C6EF001894CE0031B5D60063E7F70031B5D60021A5E700427BAD006363
      6300000000000000000000000000000000000000000000000000000000000000
      000000000000BD6B3100B5521000BD5A1000BD5A0800BD631800AD7342000000
      0000000000000000000000000000000000008CA5AD00B5E7EF00B5EFFF00B5EF
      FF00ADEFF70094E7F7008CA5AD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000CEB5AD00F7EFEF00FFFFFF00FFFFFF00FFFFF700F7EF
      EF00B59C94000000000000000000000000000000000063B5CE0063B5CE008CE7
      EF0063E7FF0063DEF7005ACEEF0039CEEF0021DEFF0008ADE700636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000008CA5AD008CA5AD008CA5
      AD008CA5AD008CA5AD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6ADA500C6ADA500C6ADA500C6AD9C00C6AD
      9C000000000000000000000000000000000000000000000000000000000063B5
      CE0063B5CE0063B5CE0063B5CE0063B5CE0063B5CE0063636300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000730000007300000073000000730000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000730000007300000073000000730000000000000094
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073000018A5310018B5310000730000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073000018A5310018B53100007300000000000000AD
      F700000000000000000000000000000000000000000000000000000000000000
      00000000000029D6310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001818
      FF00000000000000000000000000000000000000000000000000000000001810
      BD00000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073000018AD390021BD420000730000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073000018AD390021BD4200007300000094DE000094
      DE000094DE000000000000000000000000000000000000000000000000000000
      000029D6310000CE100029D63100000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A29FF000831
      FF001829FF0000000000000000000000000000000000000000003910D6000010
      BD000810B5000000000000000000000000000000000000000000000000000000
      000000000000000000000073000021AD420021BD4A0000730000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073000021AD420021BD4A000073000000ADF70000AD
      F70000ADF70000ADF700000000000000000000000000000000000000000010CE
      210010E7210010E7210008D6180029D631000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002942
      FF001031FF000029FF000000000000000000000000002110CE000010CE001010
      CE00000000000000000000000000000000000000000000000000007300000073
      000000730000007300000073000029BD520029C65A0000730000007300000073
      0000007300000073000000000000000000000000000000000000007300000073
      000000730000007300000073000029BD520029C65A0000730000007300000073
      000000730000007300000000000000000000000000000000000008CE100010E7
      210039E7420042D64A0029E7390018DE290029D6310000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003142FF001031FF000821FF00000000002110DE000018E7001010D6000000
      0000000000000000000000000000000000000000000000000000007300004AE7
      84004AE77B0042DE730039D66B0039D66B0031CE630029BD5A0021AD420018AD
      390010A529000073000000000000000000000000000000000000007300004AE7
      84004AE77B0042DE730039D66B0039D66B0031CE630029BD5A0021AD420018AD
      390010A52900007300000094DE00000000000000000010D6210018E7290039E7
      420042E74A000000000052DE5A0029DE390010D6180029D63100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005239FF001031FF000018F7000818EF003110DE00000000000000
      00000000000000000000000000000000000000000000000000000073000052EF
      8C004AE784004AE77B0042DE730039D66B0031CE630029C65A0021BD4A0018BD
      390018B5310000730000000000000000000000000000000000000073000052EF
      8C004AE784004AE77B0042DE730039D66B0031CE630029C65A0021BD4A0018BD
      390018B53100007300000094DE00000000000000000018E7290039E7420042E7
      4A0000000000000000000000000052DE5A0029DE390021D6310029D631000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002142FF000831FF000818F70000000000000000000000
      0000000000000000000000000000000000000000000000000000087B10000073
      000000730000007300000073000042DE730039D66B0000730000007300000073
      0000007300000073000000000000000000000000000000000000087B10000073
      000000730000007300000073000042DE730039D66B0000730000007300000073
      0000007300000073000000000000000000000000000039E7420052E75A000000
      00000000000000000000000000000000000052DE5A0018DE290039CE420029D6
      3100000000000000000000000000000000000000000000000000000000000000
      000000000000395AFF00294AFF003139FF001031FF000018EF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073000042E77B0042DE730000730000000000000000
      000000000000000000000000000000000000000000006B21FF000000DE000000
      DE000000DE000000DE000073000042E77B0042DE73000073000094FFFF0000AD
      F70000ADF70000ADF70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052DE5A0010DE210042D6
      4A0029D631000000000000000000000000000000000000000000000000000000
      00004263FF00395AFF00525AFF00000000004A5AFF001842FF000018EF000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000007300004AE7840042DE7B0000730000000000000000
      000000000000000000000000000000000000000000006B21FF000000DE000000
      DE000000DE000000DE00007300004AE7840042DE7B000073000094FFFF0094FF
      FF0094FFFF000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000052DE5A0010DE
      210042D64A0029D631000000000000000000000000000000000000000000526B
      FF005273FF00735AFF000000000000000000000000004A52FF00294AFF000021
      F700000000000000000000000000000000000000000000000000000000000000
      000000000000000000000073000052EF84004AE7840000730000000000000000
      000000000000000000000000000000000000000000006B21FF000000DE000000
      DE000000DE000000DE000073000052EF84004AE7840000730000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000052DE
      5A0018DE210018DE2100000000000000000000000000000000005A73FF005A7B
      FF006B6BFF0000000000000000000000000000000000000000004A52FF003152
      FF000021FF000000000000000000000000000000000000000000000000000000
      0000000000000000000000730000007300000073000000730000000000000000
      00000000000000000000000000000000000000000000000000000000DE006B21
      FF000000DE000000DE0000730000007300000073000000730000FF6B2100BD39
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005AE763005AE7630000000000000000000000000000000000000000006B7B
      FF00000000000000000000000000000000000000000000000000000000005A52
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B21FF000000
      DE000000DE000000DE000000BD0000000000FF9C6B00FF9C6B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000063636300636363006363
      6300000000000000000000000000000000000000000000000000000000000000
      00002952FF002952FF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000737373005A5A5A005A5A5A005A5A5A00737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007B7BA50031317300292939004A4A4A005A5A5A0031315A00212163005A5A
      7300000000000000000000000000000000005242310052423100524231005242
      3100636363006363630063636300636363006363630000000000000000000000
      0000000000002952FF000031FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000735A
      9C00B57BB5008C6B9400000000000000000000000000737373005A5A5A005A5A
      5A005A5A5A000073AD000073A5000073A5000073AD00006BA500424242005A5A
      5A005A5A5A005A5A5A005A5A5A005A5A5A0000000000737373005A5A5A005A5A
      5A0042428C002121DE001818AD0000315200084284002121E7002121BD004242
      52005A5A5A005A5A5A005A5A5A005A5A5A00B5737300CE6363007B635A009C94
      9400524231005242310052423100524231005242310063636300636363006363
      630000000000000000000031FF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000424AB5007373
      DE000839C600B584BD0000000000000000002121210021212100212121002121
      21002121210010ADDE0029C6EF0029BDDE0029C6EF00007BAD00212121002121
      2100212121002121210021212100424242002121210021212100212121002121
      210021212100216BDE002929E7002129AD002929CE002929D600181829002121
      210021212100212121002121210042424200B5737300CE6363007B635A00DEBD
      BD00E7B5B500D6D6D600B5B5B500D6D6D6009CADFF0052423100634A42006363
      630000000000000000000031FF00000000000000000000000000000000000000
      000000000000000000000000000000000000000000002139C600637BFF00314A
      F7004A4AC6009484CE0000000000000000009C9C9C00FFF7DE00FFF7DE00FFF7
      E700FFF7E70031ADD600BDE7EF00CEF7FF00ADE7F700188CBD00FFF7DE00FFF7
      DE00FFF7DE00FFF7DE00212121005A5A5A009C9C9C00FFF7DE00FFF7DE00FFF7
      E700FFF7E70031ADD600636BDE003131F7003131EF0010427B00FFF7DE00FFF7
      DE00FFF7DE00FFF7DE00212121005A5A5A00C67B7B00CE63630073635A00AD7B
      7B00C6636300B5B5B500F7EFEF009CADFF00214AFF00EFD6D600BDA5A500C6BD
      BD00000000001042FF000031FF00000000000000000000000000000000000000
      0000000000000000000000000000000000002139C6005A7BFF000039FF000021
      DE006373DE000000000000000000000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C004AB5DE00DEEFEF00FFFFFF00D6EFF7001094BD009C9C9C009C9C
      9C009C9C9C009C9C9C009C9C9C00000000009C9C9C009C9C9C009C9C9C009C9C
      9C009C9C9C004AADD6006363DE004A4AFF003939F70010297300737373009C9C
      9C009C9C9C009C9C9C009C9C9C0000000000C67B7B00CE636300846B6B00BD7B
      7B00AD424200CECECE009CADFF000039FF00214AFF00214AFF00214AFF00214A
      FF000031FF000031FF000031FF00000000000000000000000000000000000000
      00000000000000000000000000002139C6005A7BFF000039FF000021E7004A63
      E7008C94B5000000000000000000000000000000000000000000000000000000
      00000000000021A5D60042B5DE004AB5D600299CC60042A5CE00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002152AD005252FF00526BD6005263F7004242F70042426B000000
      000000000000000000000000000000000000C67B7B00CE636300846B6B00C694
      9400A53939009CADFF000031FF000031FF000031FF000031FF000031FF000031
      FF000031FF00214AFF0000000000000000000000000000000000000000000000
      000000000000000000002142BD005A7BFF000039FF000021E7004263EF009C9C
      C600F7F7EF00ADA5A50000000000000000000000000000000000000000000000
      0000000000000000000084848400ADA594001010100039393900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A5AFF005A5AFF005A5ABD009C948C00212142005A5AEF004A4ADE000000
      000000000000000000000000000000000000BD7B7B00CE6363008C636300E7D6
      D600CEA5A500CECECE009CADFF00214AFF00214AFF007B9CFF007B9CFF007B9C
      FF007B9CFF000000000000000000000000000000000000000000000000000000
      000000000000216BBD005A8CFF000039FF000021E7004A63E700737B9400ADAD
      A500EFE7E700DEDED600EFE7E700000000000000000000000000000000000000
      000000000000949494004A4A4A008C8484003129290018181800525252008C8C
      8C00000000000000000000000000000000000000000000000000000000000000
      000000000000949494004A4A4A008C8484003129290018181800525252007373
      730000000000000000000000000000000000C67B7B00CE636300A55A5A009463
      6300947B7B00948C8C00C6BDBD009CADFF000031FF00EFD6D600BDA5A500BDAD
      AD00000000000000000000000000000000000000000000000000949494009C9C
      9C007B848C004A94EF000039FF000029E7004A6BE70000000000000000000000
      0000A5A5A500F7EFEF00BDBDBD00000000000000000000000000000000008484
      8400737373008C8C8C00A5A5A500736B6B00393939004A424200524A4A004A4A
      4A00525252007373730000000000000000000000000000000000000000008484
      8400737373008C8C8C00A5A5A500736B6B00393939004A424200524A4A004A4A
      4A0052525200737373000000000000000000BD7B7B00CE6363008C525200A55A
      5A00B55A5A00CE636300B55A5A00D6BDBD009CADFF00E7B5B500844A4A006363
      630000000000000000000000000000000000000000008C8C8C00A5A5A500BDBD
      BD00BDBDBD00848CA5000842D600428CE7000000000000000000000000000000
      000000000000D6CECE00E7DEDE00A5A59C00000000008C8C8C008C8C8C00CECE
      CE00A5A5A5007B7B7B00848484007B7B7B004A4A4A00737373007B7B7B00736B
      6B007363630052525200525252007B7B7B00000000008C8C8C008C8C8C00CECE
      CE00A5A5A5007B7B7B00848484007B7B7B004A4A4A00737373007B7B7B00736B
      6B007363630052525200525252007B7B7B00C68C8C00CE6363008C636300E7E7
      E700C6C6C600ADADA500A58C8C00AD7B7B00D6C6C600DEADAD00844A4A006363
      6300000000000000000000000000000000008C8C8C009C9C9C00B5B5B500BDBD
      BD00BDBDBD00B5B5B500738494009C7B9C000000000000000000000000000000
      000000000000D6CEC600D6CEC6009C9C9C00A5A5A500ADADAD009C9C9C008484
      8400A5A5A500BDBDBD00D6D6D6008C8C8C007B7B7B006B6B6B00848484006363
      630031313100B59C9C008C7373006B6B6B00A5A5A500ADADAD009C9C9C008484
      8400A5A5A500BDBDBD00D6D6D6008C8C8C007B7B7B006B6B6B00848484006363
      630031313100B59C9C008C7373006B6B6B00C68C8C00CE636300846B6B00BDBD
      BD00C6C6C600BDBDBD00CECECE00DEDEDE00C6C6C600A55A5A00844A4A006363
      63000000000000000000000000000000000094949400BDBDBD0000000000A5A5
      A500BDBDBD00C6C6C600A5949400EF9C9C00B584840000000000000000000000
      0000A5949400FFCECE00C6B5B500000000009C9C9C009C9C9C00B5B5B500C6C6
      C600E7E7E700E7E7E700D6D6D600DEDEDE00D6D6D600C6C6C6009C9C9C007B73
      73004242420094848400847373007B7B7B009C9C9C009C9C9C00B5B5B500C6C6
      C600E7E7E700E7E7E700D6D6D600DEDEDE00D6D6D600C6C6C6009C9C9C007B73
      73004242420094848400847373007B7B7B00C68C8C00CE636300846B6B00BDBD
      BD00C6C6C600BDBDB500C6C6C600BDBDBD00BDBDBD00A55A5A00844A4A006363
      6300000000000000000000000000000000009C9C9C0000000000000000000000
      0000B5B5B500C6C6C600A59C9C00AD848400EF9C9C00C6848400AD8C8C00BD8C
      8C00FFB5B500D6A5A500D6B5B50000000000BDBDBD00D6D6D600DEDEDE00C6C6
      C600E7E7E700DEDEDE00F7F7F700FFFFFF00EFEFEF00DEDEDE00F7F7F700EFEF
      EF00DECECE008C8C8C008C8C8C00000000009C9C9C00D6D6D600DEDEDE00C6C6
      C600E7E7E700DEDEDE00F7F7F700FFFFFF00EFEFEF00DEDEDE00F7F7F700EFEF
      EF00DECECE008C8C8C008C8C8C0000000000C68C8C00CE636300846B6B00C6C6
      C600EFEFEF00E7E7E700EFEFEF00DEDEDE00BDBDBD00A55A5A00844A4A006363
      630000000000000000000000000000000000000000000000000000000000A5A5
      A500C6C6C600CECECE00A5A5A50000000000DE9C9C00CE8C8C00F79C9C00DE8C
      8C00FFA5A500AD9494000000000000000000BDBDBD00BDBDBD00BDBDBD007B7B
      7B006B6B6B00BDBDBD00F7F7F700FFFFFF00EFEFEF00DEDEDE00F7F7F700CECE
      CE00C6C6C600BDBDBD000000000000000000000000009C9C9C009C9C9C007B7B
      7B006B6B6B00BDBDBD00F7F7F700FFFFFF00EFEFEF00DEDEDE00F7F7F7009C9C
      9C009C9C9C009C9C9C000000000000000000AD848400C67B7B00BD9C9C00ADAD
      AD00ADADAD00ADADAD00CECECE00DEDEDE00BDBDBD00A55A5A008C5252006363
      630000000000000000000000000000000000000000000000000094949400DEDE
      DE00B5B5B5000000000000000000000000009C8C8C0000000000EF9C9C00A594
      9400A58C8C00000000000000000000000000000000000000000000000000BDBD
      BD00BDBDBD00CECECE00D6D6D600E7E7E700CECECE00D6D6D600BDBDBD000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C009C9C9C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000ADADAD00ADADAD00ADADAD00A55A5A00636363000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000073737300737373007373730073737300737373000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000006B3129007B4A39006B3121009C736B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000636363006363630063636300736363000000
      0000000000000000000000000000000000000000000073737300737373007373
      73006B6B6B006B6B6B006B6B6B006B6B6B006B6B6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007373730073737300734239008439390084393100633931005A3931007373
      7300737373000000000000000000000000000000000000000000000000000000
      00006B3931005229B500390894000821DE00392142006B3931006B3129000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006363630063636300A59C9C008473730073636300636363006363
      6300636363000000000000000000000000006B6B6B00B5634A008C5231008C52
      31008C5231008C5231006B524A006B635A00737373006B6B6B006B6B6B006B6B
      6B006B6B6B0073737300737373006B6B6B000000000000000000000000007373
      73009C5A6300DE948C00D6949400D6949400D6949400D6737B00D6737B00B54A
      4A00633931007373730000000000000000000000000000000000733931005229
      B50039107B001000FF000800FF001810D60021109C009C00A5009C00A5006B31
      2900000000000000000000000000000000000000000000000000000000006363
      630063636300C6C6C600949494008C8C8C006B63630031313100524A4200736B
      6B0084737300635252006363630000000000E7634200DE523100FF635200FF73
      5A00F76B4A00D6734200F76B4A00D64A2100315A3900315A3900299C29004A94
      3100299C290021632100315A39006B6B6B00000000000000000073737300D69C
      9400F7C6C600F7C6BD00F7C6BD00F7CEC600F7CEC600F7C6BD00E7A5A500DE7B
      7B00CE636300633931007373730000000000000000005229B50042106B001000
      F7000000FF002100E7007B426300C6AD0000C65A7B00FF00FF00AD00AD006B39
      290000000000000000000000000000000000000000006363630063636300BDBD
      BD009C9C9C008C8C8C008C8C8C00A5A5A500525252005A5A5A00737373008484
      840094949400C6A5A5009C84840063636300D68C5200FF635200FF7B6300FF8C
      6B00D68C5200FFCE9C00F76B5200FF6B5200947B31004AB54A006BAD630063CE
      630052C6520039B53900219421006B6B6B0000000000D6844A00D69C9400F7CE
      C600FFA5A500FFADA500F7C6BD00F7CEC600F7CEC600F7D6CE00F7D6CE00F7C6
      BD00E7A5A500C663630063393100737373005229B5002108DE001000FF002100
      EF0084007300FF000000FF8C0000D6CE0000F76B6300FF00FF0094009C007339
      31006B3129006B3129006B3129006B312900636363009C9C9C00A5A5A5008C8C
      8C008C8C8C00ADADAD00BDBDBD00A5A5A500BDBDBD009C9C9C006B6B6B006B6B
      6B008C8C8C00BD9C9C00DEB5B5006363630000000000E7634200FF846B00EF84
      5A00FFCE9C00FFCE9C00EF735200FF6B5A0084AD630084B58400FFEFDE004AB5
      4A0073D673004AC64A004A9431006B6B6B0000000000C6636300EFC6BD00EF84
      8400FFA5A500FFADA500FFADA500FFBDB500F7C6BD00F7C6BD00F7C6BD00F7CE
      C600F7CEC600D69494009C393900633931001810DE002100F7002100E700F729
      1000FF4A0000FF420000EF9C0000BDB50000E75A6300EF00FF007B008400D69C
      0000D69C0000D69C0000D69C0000632921009C9C9C008C8C8C008C8C8C00CECE
      CE00DEDEDE00CECECE00BDBDBD00ADADAD00847B7B0063636B006B6B6B00A59C
      9C00847373005A5A5A00A5949400636363000000000000000000B5634A004A21
      4A00293152007B4A6B00B5634A00947B31007BD67B008CE78C00FFF7EF00BDDE
      AD005AC65A0042A54200000000000000000000000000D6844A00E77B7B00F78C
      8C00FFA59C00FF949400FFADAD00FFADAD00FFADAD00F7B5B500F7B5B500FFBD
      B500F7C6BD00F7C6BD00BD5A5A00633931002110D6001800EF002900E700FF73
      0000FF8C0000FF730000D68C0000E7DE0000D6426B00AD00E70063007300D69C
      0000FFFF0000FFF70000D69C0000A5847B008C8C8C00B5B5B500EFEFEF00EFEF
      EF00D6D6D6009C9C9C00848C8400525A5A00424A4A00424A4A00635A52009C9C
      9C00D6D6D6006363630063636300000000000000000010101000000008000829
      6B001039A5001029940008186B00525252006BAD630042739C00107BBD00217B
      B500317B52004A4A4A00000000000000000000000000D66B6B00DE7B7B00EF84
      8400EF848400EF8C8C00EF8C8C00FFA59C00FFA5A500FFA5A500FFADA500FFAD
      AD00F7B5B500FFB5AD00BD848400633931002110D6002100EF003100E700E784
      000084AD000029A5000018840000C6429400E742FF00FF84FF0094299400D69C
      0000CEAD7300C6A56B00C69C7300000000000000000000000000B5B5B500B5B5
      B5005A5A5A004A4A4A002173AD00107BBD002184C600319CE7004A424200635A
      520063636300000000000000000000000000393939001818180010295A00184A
      B5001852BD001852B50010299400525252006B9CAD002994F700319CFF00319C
      FF002994F700295A6B0084848400000000005A393100D66B6B00D66B6B00D66B
      6B00D66B6B00D66B6B00D66B6B00CE6B6B00E7848400FF9C9C00FF9C9C00FF9C
      9C00FFA5A500FFA5A500D6848400633931002108CE002900EF002900E70000CE
      000000F7000000EF0000089C0000D69CE700EFC6EF00DEB5CE00298C08002184
      08007B4A420000000000000000000000000000000000000000000000000042A5
      E700218CEF002994EF004AADF7004AADF7004AADF70052BDFF003184CE005A4A
      4200000000000000000000000000000000001010100029292900082994002173
      DE002173D6002173D600185AC6005A6363003994C60042A5FF0042A5FF0042A5
      FF0039A5FF002184C6006B6B6B00000000005A3931005A3931005A3931005A39
      31005A3931005A3931005A39310000000000D66B6B00EF8C8C00FF949400FF94
      9400FF9C9C00FF9C9C00D6848400633931002918D6003900F7003108DE0000FF
      000018FF000052FF290039D618001073B500C6A5C600297B180010FF10005AA5
      4200000000000000000000000000000000000000000000000000000000005AC6
      FF005AC6FF0052BDFF0042A5E700319CE700319CE7002184DE00318CDE004239
      3100636363000000000000000000000000002929290031313100295A6B003194
      FF00319CFF003194F700216BD6005A636300429CD6004AB5FF004AB5FF004AB5
      FF004AADFF002994E7006363630000000000D6844A00F7B57B00F7BD7B00F7BD
      7B00F7BD7B00F7BD7B00F7B57B00CE63630000000000DE7B7B00EF8C8C00EF8C
      8C00F78C8C00F78C8C0073737300000000003931D6005221F7004229E7006BAD
      6B00C6EF94006BBD9C0008ADDE00006BDE00214A210021FF08006BA552000000
      000000000000000000007B295A00000000000000000000000000000000000000
      000063ADDE0042A5F700298CE7003994D600107BBD002184DE004294CE00848C
      84005A4A39006363630000000000000000006B6B6B004A4A4A00393939004242
      42001039A5002163C600105A8C007B7B7B0052ADD6004AB5F7004AB5F70052BD
      FF0052B5FF0042ADEF006B6B6B0000000000C6636300D6844A00EFA55A00EFA5
      5A00EFA55A00EFA55A00EFA55A00C663630000000000CE636300DE7B7B00E784
      8400E7848400BD8484007373730000000000524ADE006B4AF7006B4AF7005A42
      EF002910B500004AE70000C6FF00008CE700006BDE0021FF0800000000000000
      0000000000007B295A007B295A007B295A000000000000000000000000000000
      0000000000000000000063ADDE0063ADDE0094949400BD6B3900D6731000DE84
      2900DE8429006363630000000000000000000000000039393900636363008C8C
      8C00A5A5A5004A4A4A00424242000000000063ADD600217BB50052ADD60063AD
      D600429CD6001073A5006B9CAD000000000000000000D6844A00DE8C3900DE8C
      3900DE8C3900DE8C3900DE8C3900CE63630000000000CE636300D6848400D684
      8400D68484007373730000000000000000006363DE006B63E7005263D6004A39
      EF002108F7000094E70000E7FF0000ADF700006BDE0000000000000000000000
      0000B510A500FF08FF00BD94AD006B3129000000000000000000000000000000
      0000000000000000000000000000E79C4A00EFAD6300E79C4A00DE843100CE73
      29006363630000000000000000000000000000000000000000006B6B6B00635A
      5A00635A5A0063636300000000000000000000000000398CB50084C6E700A5D6
      EF00429CD6006B9CAD0000000000000000000000000000000000C6636300D67B
      1800DE843100D67B2900DE843100CE63630000000000CE636300D68484007373
      7300000000000000000000000000000000005273DE006B7BF700738CFF00399C
      F70000D6EF0000F7FF0018FFFF0008CEE700006BDE000000000000000000AD18
      9400FF21FF00DE52DE00DE8CE700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EFA55A00BD5A
      18008C6352006363630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000398CB500398C
      B500398CB5000000000000000000000000000000000000000000000000000000
      0000C66B3100D6844A00D6844A00CE6363000000000000000000000000000000
      00000000000000000000000000000000000000000000738CFF00738CFF0000EF
      EF004AFFFF0073D6E70018FFFF00000000000000000000000000BD31BD00FF39
      FF00DE8CE700DE8CE70000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000E79C
      4A00CE7329006363630000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000073D6
      E70073D6E7000000000000000000000000000000000000000000D66BDE00DE8C
      E700DE8CE7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AD846300CE732900000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000000000000000000000000000846B5A008C6B5A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005242420052424200524242005242420052424200524242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000007B7B7B00848484007B7B7B000000000000000000000000007B7B
      7B007B7B7B007B7B7B000000000000000000FFFFFF008494DE000831B5001031
      BD001839BD001839B5001839BD001039BD001031BD000831C6000831C6000029
      BD000029C6000021B5007B94D600FFFFFF000000000000000000000000000000
      0000000000000000000000000000946B4A00CE9C6B00AD7B4A00846B5A000000
      000000000000000000000000000000000000000000000000000000000000B58C
      7B00B5948400F7E7D600EFE7DE00EFE7DE00F7E7DE00F7E7D600BDA59C005242
      4200524242000000000000000000000000000000000000000000000000000000
      00007B7B7B004A4A4A00525252009C9C9C007B7B7B006B6B6B006B5A5A00735A
      5A004A4A4A005A5A5A007B7B7B0000000000FFFFFF001039D6001842DE00294A
      DE002952DE002952DE002952DE002952DE00214ADE00184AE7001042E7000842
      E7000039E7000031D6000021B500FFFFFF000000000000000000000000000000
      00000000000000000000946B4A00CEAD8400FFF7C60094634200846B5A000000
      0000000000000000000000000000000000000000000000000000BDA59C00F7E7
      DE00FFF7F700E7DED600DEB59C00D6A58C00E7C6BD00EFEFEF00F7F7F700F7E7
      D600E7CEBD005242420000000000000000000000000000000000000000000000
      0000AD947300DE8C39006B52390052526B000031DE001039C600D6BDBD00B5AD
      AD009C8C8C006B525200524A4A007B7B7B00FFFFFF001842DE002952E700315A
      E7004263E7007B94EF00E7EFFF00FFFFFF00FFFFFF00DEE7FF007394F700104A
      EF000842EF000039E7000029BD00FFFFFF000000000000000000000000000000
      0000947363008C634A00E7CEAD00FFDEB500FFDEB500AD846300522908006B42
      3100846B5A0000000000000000000000000000000000BDA59C00F7EFE700FFFF
      FF00C68C7300BD5A2900BD5A2900DEB59C00BD5A2900BD5A2900D69C8400F7F7
      F700F7E7DE00D6C6BD0052424200000000000000000000000000000000000000
      0000AD947300DE8C3900845A4A007B6B8C001052FF002163E700D6ADAD00AD84
      8400A58C8C009CBD9C007B736B006B6B6B00FFFFFF00214ADE00395AE7004263
      E700A5B5F700FFFFFF00BDCEF700738CEF006B8CEF00BDCEFF00FFFFFF009CB5
      F700084AEF000839E7000029C600FFFFFF000000000000000000BDA59C00BDA5
      9C00D6B59C00E7CEAD00FFE7BD00FFEFC600FFFFD600F7D6B500DEBD9400AD8C
      63005A291000846B5A00000000000000000000000000BDA59C00FFFFFF00CE6B
      4200BD5A2900BD5A2900C6A59400FFFFFF00E7845200BD5A2900BD5A2900D694
      7300FFFFF700F7E7D60052424200000000000000000000000000000000000000
      0000AD947300DE8C3100BDA59400ADA5C600186BFF003173E700D6B5B500BD94
      9400A5737300A57373007B5A5A006B6B6B00FFFFFF002952E7004263E7008C9C
      EF00FFFFFF00849CEF00426BE7004263E7003163EF00295AEF007394F700FFFF
      FF006B8CF7000842E7000831C600FFFFFF0000000000CEB5A500EFDEC600EFD6
      BD00FFEFCE00FFD6B500C6734A00EF946300DE8C5A00DEA57B00FFE7C600F7D6
      B500D6B59400734229008C6B630000000000BDA59C00FFFFFF00DE9C7B00BD5A
      2900CE633100CE633100CE6B3900D68C6300CE633100CE633100BD5A2900BD5A
      2900E7CEBD00F7EFEF00DECEC600524242000000000084848400848484008484
      8400AD947300DE7B2100B5847B00A58CA500217BFF004284DE00DEBDBD00BD94
      9400CE9C9C00BD8C8C00845A5A006B6B6B00FFFFFF00315AE7004A6BE700EFEF
      FF00BDC6F7004A6BE7004A6BE700FFFFFF00FFFFFF00295AEF002152EF00B5C6
      FF00DEE7FF00184AE7001039C600FFFFFF00CEBDA500EFDEC600EFDEC600FFEF
      D600FFEFCE00FFFFE700B58463007B0000008C290000F7E7C600FFEFCE00FFE7
      C600F7D6B500DEBD9C005A29100000000000D6C6BD00FFF7F700C6633100BD5A
      2900CE633100BD5A2900CE846300F7E7DE00D66B3900BD5A2900CE633100BD5A
      2900CE734200FFFFFF00E7CEBD005242420021A5D600316B840021637B002163
      7B0094847300DE7B2900B59C9C00ADADC600298CFF00529CDE00DEBDBD00BD8C
      8C00A5737300BD8C8C00845A5A006B6B6B00FFFFFF00395AE700526BE700FFFF
      FF008494EF00526BE7004A6BE700FFFFFF00FFFFFF00295AE7002152E7006384
      EF00FFFFFF00184ADE001839C600FFFFFF00C6B5A500EFDEC600FFF7D600FFEF
      D600FFE7CE00FFFFEF00CEB594006B000000A55A3100FFFFF700FFE7CE00FFE7
      C600FFEFCE00FFE7C600AD8C6B0094736B00D6C6BD00F7DED600BD5A2900CE63
      3100CE633100BD5A2900D6845200FFFFFF00E7AD9400BD5A2900BD5A2900CE63
      3100BD5A2900FFEFEF00F7DED6005242420021A5D6006BCEFF006BCEFF006BCE
      FF00A5845A00DE7B31008C8C8C00BDB5CE009CB5D60052638C00DEBDBD00BD8C
      8C00B5848400BD848400845A5A006B6B6B00FFFFFF004263E7005A73EF00FFFF
      FF008494EF00526BE7004A63E700FFFFFF00FFFFFF002952E7002152E7006384
      EF00FFFFFF00214ADE001839BD00FFFFFF00CEBDAD00FFE7D600FFF7DE00FFEF
      D600FFEFD600FFFFF700CEAD940073000000A5523100FFFFF700FFEFCE00FFE7
      CE00FFEFCE00FFEFD600E7CEAD008C6B5A00D6C6BD00F7D6CE00CE633100CE63
      3100CE633100CE633100BD5A2900DEAD9400FFF7F700EF9C7300BD5A2900CE63
      3100BD5A2900F7F7EF00EFE7DE0052424200319CC6007BDEFF0063BDDE0073DE
      FF00847B7300A58C8400B5ADAD00CEC6C600E7DEDE00BDBDBD00C6ADAD00C684
      8400BD7B7B00BD848400845252006B6B6B00FFFFFF004A6BE700637BEF00EFF7
      FF00B5C6F700526BE7004A63E700FFFFFF00FFFFFF002952E700214AE700B5BD
      F700E7E7FF002952DE002142BD00FFFFFF00CEC6B500FFEFE700FFF7E700FFEF
      DE00FFF7DE00FFFFFF00D6C6AD0073000000A55A3100FFFFFF00FFEFD600FFEF
      D600FFEFD600FFF7DE00EFD6C600846B5A00D6C6BD00FFEFE700D66B3900CE63
      3100CE633100BD5A2900BD5A2900BD5A2900E7CEC600FFFFFF00D66B3900CE63
      3100CE6B3900FFFFFF00F7DED600524242004AB5D60084BDCE00E7E7E700B59C
      9C005A636300A5A5A500B5B5B500DEDEDE00D6D6D600DEDEDE00C6C6C600F7DE
      DE00DEADAD00CE7B7B00945A5A0094949400FFFFFF00526BE7006B84EF0094AD
      F700FFFFFF008494EF004A63E7004263E700395AE7003152E7006B84EF00FFFF
      FF00738CEF002952DE002142BD00FFFFFF00D6C6BD00FFF7EF00FFFFEF00FFF7
      E700FFFFEF00EFE7DE008C391800630000008C392100FFFFFF00FFF7DE00FFEF
      D600FFEFDE00FFFFE700F7DECE00947B7300D6C6BD00FFFFFF00F79C6B00D66B
      3900CE8C6B00F7EFE700D6845200BD5A2900D6947300FFFFFF00E78C5A00BD5A
      2900EF946300FFFFFF00D6C6BD005242420063CEE7008CADBD00CECECE00D6D6
      D60073737300ADADAD00BDBDBD00B5B5B5009C9C9C00ADA5A500ADADAD00DEC6
      C600CEADAD00B59494009494940000000000FFFFFF005A7BEF007B94EF00738C
      EF00A5B5F700FFFFFF00B5BDF7007384EF006B84EF00B5BDF700FFFFFF0094AD
      F7003152E7002952DE002142BD00FFFFFF00DED6CE00F7F7EF00FFFFFF00FFF7
      EF00FFFFFF00E7DECE00B5948400BDA59C00C6ADA500FFFFFF00FFF7E700FFEF
      DE00FFFFEF00FFFFFF00E7CEB500947B730000000000D6C6BD00FFEFDE00EF84
      5200E7845200F7F7F700FFFFFF00DEBDAD00FFFFFF00F7F7F700DE734200D673
      3900FFF7EF00F7E7E70052424200000000007BD6EF0084C6DE00B5DEE700ADC6
      C600ADC6CE009CB5B50094B5B5008CC6C6008C9C9C008C9C9C00948C8C009494
      940000000000000000000000000000000000FFFFFF006B84EF008CA5EF008494
      EF006B8CEF0094ADF700EFF7FF00FFFFFF00FFFFFF00EFEFFF008C9CEF004263
      E700395AE7003152DE001839BD00FFFFFF0000000000E7E7E700FFFFFF00FFFF
      FF00FFFFF700FFFFFF00FFFFFF00FFCEA500FFFFEF00FFFFFF00FFF7EF00FFFF
      EF00FFFFFF00FFFFFF00AD9484000000000000000000D6C6BD00FFFFFF00FFEF
      D600FFAD7300EFAD8C00EFE7DE00EFEFEF00F7E7E700FFA57B00F78C5A00F7DE
      CE00FFFFFF00D6C6BD00000000000000000084DEEF0073D6FF009CE7FF009CEF
      FF009CEFFF009CEFFF009CEFFF009CEFFF009CEFFF00ADDEEF00949494000000
      000000000000000000000000000000000000FFFFFF00738CEF009CADF7008CA5
      EF007B94EF00738CEF006B84EF00637BEF00637BEF005A7BEF005273E7004A6B
      E7004263E7002952DE001839BD00FFFFFF0000000000EFE7E700EFEFEF00FFFF
      FF00FFFFFF00FFFFFF008C524A005A0000009C422900FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D6BDAD0000000000000000000000000000000000D6C6BD00FFFF
      FF00FFFFFF00FFF7C600FFDEAD00FFD69C00FFC69400FFD6AD00FFFFFF00FFFF
      FF00D6C6BD000000000000000000000000009CDEF70084EFFF0084EFFF0084EF
      FF00BDEFFF009CDEF7009CDEF7009CDEF7009CDEF700ADD6E700000000000000
      000000000000000000000000000000000000FFFFFF00B5BDF700738CEF006384
      EF005A73EF005273E7004A6BE7004A6BE7004A6BE7004263E7003963E700395A
      E7003152E7002142DE008C9CDE00FFFFFF000000000000000000F7EFE700F7F7
      F700FFFFFF00FFFFFF00D6CECE0063424200C6B5AD00FFFFFF00FFFFFF00FFFF
      FF00EFDED600000000000000000000000000000000000000000000000000D6C6
      BD00D6C6BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DECEC600D6C6
      BD0000000000000000000000000000000000BDE7F700ADE7F700A5E7F700ADE7
      F70094CEE7000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000EFE7DE00F7F7EF00FFFFFF00FFFFFF00FFFFFF00FFFFF700DECEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DECEC600D6C6BD00D6C6BD00D6C6BD00D6C6BD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF000000F0FF000000000000F0FF00000000
      0000F03F000000000000F03F000000000000000F000000000000000F00000000
      000000030000000000000003000000000000C000000000000000C00000000000
      0000F000000000000000F000000000000000FC0F000000000000FC0F00000000
      0000FF0F000000000000FF0F00000000FC0F0000F81F0000F80F0000E0070000
      F80F0000C0030000F80F000080010000F80F000080010000F80F000000000000
      F80F000000000000F80F000000000000F80F000000000000F80F000000000000
      F80F000000000000F80F000080010000F80F000080010000F81F0000C0030000
      FCFF0000E0070000FCFF0000F80F000000008FFFF8018FFF000007FFF80107FF
      000003FFF80103FF000001FFF80101FF000080FF800180FF0000C0038001C003
      0000E0018001E0010000F0008001F0000000F8008001F8000000F8008001F800
      0000F8008003F8000000F8008007F8000000F800801FF8000000F801801FF801
      0000FC03803FFC030000FE07807FFE078007FFFFFFFF00000007C007FC1F0000
      00078003F007000000078003E003000000078003C003000000078003C7810000
      000380038F010000000080038E210000000080038C6100000004800388E30000
      0007800381E3000000078003C3C7000000078003C00F0000000F8003E01F0000
      001FC007F87F0000003FFFFFFFFF0000FFFFFFFFFFFFFFFFF83FE000007FFCFF
      F03FE000007FF83FE1FFE0000000F00FC3FF00000000E003C3FF00000000C001
      C0CF00000000800100870000000000018103000000000003C201000000000003
      E400000000000007FF870001E000000FFF870001F001000FFC0F0003F803000F
      F81F01FFFC07801FFFFF83FFFE0FE03FFFFFF76FFFFFFFFFFFFFF6C7FFFFFFFF
      FC3FF807FFFFFFFFFC3FF407FBFFEFEFFC3FF401F1FFC7C7FC3FE001E0FFE38F
      C003C000C07FF11FC003C000843FF83FC00380008E1FFC7FC00380009F0FF83F
      FC3F0001FF87F11FFC3F0001FFC3E38FFC3F0007FFE3C7C7FC3F8007FFF3EFEF
      FFFF800FFFFFFFFFFFFFC11FFFFFFFFF8FF3FFFFFC1FF00F0079FFE380008000
      000DFFC300000000000DFF83000000000009FF07000100010001FE07F83FF81F
      0003FC03FC3FF01F0007F801F80FF80F000FC071E003E003000F80F880008000
      000F00F800000000000F207100000000000F700100010001000FE10300038003
      000FC747E01FF01FFC1FFFFFFFFFFFFFFFFFFC1FFC3FFE1F807FF007F01FF807
      0000E003C00FE0010000C001800F800000008000000000008000800000000000
      C003800000000001800380000001C007000100000007E00F00010100000FE007
      00010081001DF003000100810038FC03810180830070FE07C383C08F0061FFC3
      FFC7F0FF81C3FFE3FFFFFFFFE7C7FFF38001FF3FF81FF8E30000FE1FE007F001
      0000FC1FC003F0000000F0078001F0000000C0038001F0000000800100008000
      0000000100000000000000000000000000000000000000000000000000000000
      0000000000000001000000008001000F000080018003001F00008003C007003F
      0000C007E00F07FF8001F01FF83FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageList5: TImageList
    Left = 220
    Top = 575
    Bitmap = {
      494C010104000900840010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400848484008484840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000848400000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000029D6310000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001818
      FF00000000000000000000000000000000000000000000000000000000001810
      BD00000000000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000008484840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000848484000000000000000000000000000000
      00000000000000000000FFEFE700F7D6CE000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000029D6310000CE100029D63100000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005A29FF000831
      FF001829FF0000000000000000000000000000000000000000003910D6000010
      BD000810B5000000000000000000000000000084840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0084848400000000008484840000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000000000000000000000000000000000000000
      000000000000FFF7F700BD6B4A00BD6B3900EFDED60000000000000000000000
      00000000000000000000000000000000000000000000000000000000000010CE
      210010E7210010E7210008D6180029D631000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002942
      FF001031FF000029FF000000000000000000000000002110CE000010CE001010
      CE0000000000000000000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF000000000084848400000000000000000000000000000000000000
      0000F7EFEF00BD632900F7940000E7840800B55A2900EFE7DE00000000000000
      000000000000000000000000000000000000000000000000000008CE100010E7
      210039E7420042D64A0029E7390018DE290029D6310000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003142FF001031FF000821FF00000000002110DE000018E7001010D6000000
      000000000000000000000000000000000000000000000084840000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00000000000000000000000000000000000000000000000000F7E7
      DE00B56B5200F7D6A500FFA50800FFAD1000E78C1800BD632100EFE7E7000000
      0000000000000000000000000000000000000000000010D6210018E7290039E7
      420042E74A000000000052DE5A0029DE390010D6180029D63100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005239FF001031FF000018F7000818EF003110DE00000000000000
      00000000000000000000000000000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000848400000000000084840000FFFF0000FFFF0000FF
      FF00000000008484840000000000000000000000000000000000EFDED600BD73
      5A00F7DEAD00FFBD4200FFBD4200FFBD4200FFBD4200FFAD2100C6631800E7D6
      DE00000000000000000000000000000000000000000018E7290039E7420042E7
      4A0000000000000000000000000052DE5A0029DE390021D6310029D631000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002142FF000831FF000818F70000000000000000000000
      00000000000000000000000000000000000000000000000000000084840000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF000000000000000000000000000000000000000000F7E7DE00C6846B00F7DE
      BD00FFDE7300FFD66B00FFD67300FFD67300FFD66B00FFD67300FFBD3900C66B
      2100E7D6D6000000000000000000000000000000000039E7420052E75A000000
      00000000000000000000000000000000000052DE5A0018DE290039CE420029D6
      3100000000000000000000000000000000000000000000000000000000000000
      000000000000395AFF00294AFF003139FF001031FF000018EF00000000000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      000084848400000000000000000000000000F7E7E700BD735A00EFE7E700FFEF
      9C00FFEF9C00FFEF9C00FFEF9C00FFEF9C00FFEF9C00FFEF9400FFCE5A00F7A5
      1000C66B1800E7D6D60000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052DE5A0010DE210042D6
      4A0029D631000000000000000000000000000000000000000000000000000000
      00004263FF00395AFF00525AFF00000000004A5AFF001842FF000018EF000000
      0000000000000000000000000000000000000000000000000000000000000084
      840000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000000000FFCE4A00F7BD3100FFDE5A00FFD6
      5200FFF7D600FFFFC600FFFFBD00FFFFBD00FFF7B500FFBD5200FF733100FF73
      3100F7946300C67B5A00EFE7DE00000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000052DE5A0010DE
      210042D64A0029D631000000000000000000000000000000000000000000526B
      FF005273FF00735AFF000000000000000000000000004A52FF00294AFF000021
      F700000000000000000000000000000000000000000000000000000000000000
      00000084840000FFFF0000FFFF000000000000FFFF0000FFFF00000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FFDE5A00FFFFC600FFFFC600FFFFCE00FFFFBD00AD521800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000052DE
      5A0018DE210018DE2100000000000000000000000000000000005A73FF005A7B
      FF006B6BFF0000000000000000000000000000000000000000004A52FF003152
      FF000021FF000000000000000000000000000000000000000000000000000000
      00000084840000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFD64200FFEF9C00FFEF7B00FFEF7B00FFEF7B00C6521000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005AE763005AE7630000000000000000000000000000000000000000006B7B
      FF00000000000000000000000000000000000000000000000000000000005A52
      FF00000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FFEFA500FFE78400FFE78C00FFE78C00FFE78C00FFBD9C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000084840000FFFF0000FFFF0000FFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000848400008484000084840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFC001FFFFFFFFFFFF8000FFFF
      FFFFFFFF0000FFFFFBFFEFEF0000FCFFF1FFC7C70001F87FE0FFE38F8001F03F
      C07FF11F8003E01F843FF83FC003C00F8E1FFC7FC00780079F0FF83FE0070003
      FF87F11FE00F0001FFC3E38FF00FF03FFFE3C7C7F01FF03FFFF3EFEFF81FF03F
      FFFFFFFFF83FFFFFFFFFFFFFFC7FFFFF00000000000000000000000000000000
      000000000000}
  end
  object ImageListForRichEditMenu: TImageList
    AllocBy = 18
    Left = 310
    Top = 575
    Bitmap = {
      494C010113001A00880010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006B6B6B006B6B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BDBDBD0052636B007B7B7B0000000000000000000000
      000000000000000000000000000000000000000000007B5AEF002900DE003929
      A5006363630000000000BDBDBD0052636B007B7B7B0000000000000000000000
      00006352B5002900DE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A5A5A0029292900B5B5B50000000000848484000000000029292900B5B5
      B500000000000000000000000000000000000000000000000000000000000000
      000000000000B5B5B500526B7300427B940021394200A5A5A500000000000000
      000000000000000000000000000000000000000000007B5AEF002900DE003108
      DE00524A6B0063636300526B7300427B940021394200A5A5A500000000004229
      C6002900DE005A42B50000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939390000000000000000009494940000000000B5B5B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BDBDBD006373840063BDD60042ADC6003194B50021394200A5A5A5000000
      00000000000000000000000000000000000000000000000000007B5AEF002900
      DE003918D6005A5A5A0063BDD60042ADC6003194B500213942003918CE002900
      DE005A42B5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006363630063636300848484002929290018181800000000000000
      000000000000000000000000000000000000000000000000000000000000BDBD
      BD007394A50084D6E70073D6E70063BDD60042ADC6003194B50021394200A5A5
      A500000000000000000000000000000000000000000000000000000000007B63
      EF002900DE005239C6006363630063BDD60042ADC6003918CE002900DE005A42
      B500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6C6C60063636300000000000000000084848400000000000000
      0000000000000000000000000000000000000000000000000000D6D6D60084BD
      C60094DEE70084E7F70084DEF70073D6E70063BDD60042ADC6003194B5003142
      5200C6C6C6000000000000000000000000000000000000000000D6D6D60084BD
      C6007B63EF002900DE005231C60052525A003110C6002900D6005A42B5003142
      5200C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000039393900848484000000000000000000000000000000
      000000000000000000000000000000000000000000000000000094C6D600B5EF
      F700C6FFFF00A5EFF70094E7F70084DEF70073D6E70063BDD600639CA500635A
      5200524A4200BDBDBD000000000000000000000000000000000094C6D600B5EF
      F700C6FFFF007B5AEF002900DE002900D6002900D6006B638C00639CA500635A
      5200524A4200BDBDBD0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000084848400000000005A5A5A0000000000000000000000
      0000000000000000000000000000000000000000000094D6E700B5EFF700C6FF
      FF00C6FFFF00B5FFFF00B5F7FF0094E7F70084DEF70084BDC600636363008484
      840063636300524A420000000000000000000000000094D6E700B5EFF700C6FF
      FF00C6FFFF00B5FFFF002908DE002900DE004229C6006B638C00636363008484
      840063636300524A420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000B5B5B50000000000000000000000
      00000000000000000000000000000000000000000000A5DEE700C6FFFF00C6FF
      FF00C6FFFF00C6FFFF00C6FFFF00B5FFFF0094CED600847B8400A59CA500847B
      73007373730052524200000000000000000000000000A5DEE700C6FFFF00C6FF
      FF00C6FFFF003918CE002900DE005A42B5003108E7005A39D6006B638C00847B
      7300737373005252420000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6000000000000000000000000000000
      000000000000000000000000000000000000000000000000000094C6D60084BD
      C600B5F7F700C6FFFF00C6FFFF00B5E7E700A5A5A500E7E7E700948C8400B5AD
      B500525252008C8C8C000000000000000000000000000000000094C6D60084BD
      C6003918CE002900DE005A42B500B5E7E700A5A5A5004218E7004A29DE006B63
      8C00525252008C8C8C0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003939390000000000000000000000000000000000000000000000
      00008CBDCE0084B5C600B5DEE700B5B5B500F7EFF700D6CEC600E7DEE7008484
      840084636300634A4A00BDBDBD00000000000000000000000000000000003910
      CE002900DE005A42B500B5DEE700B5B5B500F7EFF700D6CEC6005A42E7003108
      DE006B638C00634A4A00BDBDBD00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B6B6B004A4A4A0039393900000000000000000000000000000000000000
      000000000000DEDEDE00B5B5B500E7E7E700D6CED600E7E7E700A5A5A500C69C
      9400D663630094394200634A4A00BDBDBD0000000000000000003910CE002900
      DE005A42B500DEDEDE00B5B5B500E7E7E700D6CED600E7E7E700A5A5A5005A42
      E7002900DE0094394200634A4A00BDBDBD000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      840084848400737373006B6B6B00525252000000000000000000000000000000
      00000000000000000000D6D6D600B5B5B500B5B5B500B5B5B500CECECE00B58C
      9400D6949400D663630094394200634A4A00000000004218E7002900DE004229
      C6000000000000000000D6D6D600B5B5B500B5B5B500B5B5B500CECECE00B58C
      9400D6949400D663630094394200634A4A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6949400E7949400B56B7300846B7300000000003110E7004A29E7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C6949400E7949400B56B7300846B73000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6949400C68C9400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6949400C68C9400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A500313131008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000FF000000FF000000FF000000
      FF000000FF000000FF000000FF000000FF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000737373006B6B6B003131
      3100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CECECE00C6C6
      C600C6C6C60000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000CECECE00C6C6
      C600C6C6C60000000000000000000000000000000000C6C6C600C6C6C600C6C6
      C600C6C6C6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000A5A5A50073737300A5A5
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B6B
      6B003131310039393900000000000000000000000000A5A5A500212121002121
      2100212121002929290000000000000000000000000000000000000000006B6B
      6B003131310039393900000000000000000000000000A5A5A500212121002121
      2100212121002929290000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000393939000000000000000000000000000000000000000000848484002121
      2100292929000000000000000000000000000000000000000000000000000000
      0000393939000000000000000000000000000000000000000000848484002121
      2100292929000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00006B6B6B005A5A5A00CECECE00BDBDBD00BDBDBD00CECECE00292929002121
      2100636363000000000000000000000000000000000000000000000000000000
      00006B6B6B005A5A5A00CECECE00BDBDBD00BDBDBD00CECECE00292929002121
      2100636363000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B5B5B500393939009494
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003131310052525200525252005252520039393900313131002121
      2100000000000000000000000000000000000000000000000000000000000000
      0000000000003131310052525200525252005252520039393900313131002121
      2100000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484003939
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005A5A5A00CECECE00000000000000000039393900313131005A5A
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000005A5A5A00CECECE00000000000000000039393900313131005A5A
      5A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B5B5B50084848400B5B5
      B500000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000ADADAD005A5A5A0000000000BDBDBD003131310031313100BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      000000000000ADADAD005A5A5A0000000000BDBDBD003131310031313100BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000042424200000000005252520031313100424242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000042424200000000005252520031313100424242000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848484007B7B7B003131310031313100B5B5B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000848484007B7B7B003131310031313100B5B5B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD00393939009494
      9400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000424242004242420039393900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000424242004242420039393900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848484003939
      3900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A4A4A0042424200BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000004A4A4A0042424200BDBDBD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BDBDBD0084848400BDBD
      BD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6006B6B6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C6006B6B6B0000000000000000008484
      84004A4A4A005252520042424200393939000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484004A4A4A007B7B7B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A5A5A000808080008080800080808000808080008080800080808000808
      08005A5A5A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000313131000808
      08000808080018181800000000000808080008080800080808005A5A5A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002929290000000000000000006B6B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000001010
      100008080800B5B5B500000000005A5A5A000808080042424200000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000ADAD
      AD000808080021212100000000002121210008080800B5B5B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005A5A5A000808080063636300080808000808080000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006363630039393900000000000000000000000000101010000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000008080800080808003131310018181800ADADAD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000636363002929290063636300000000000000000008080800080808000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000525252000808080084848400ADADAD0000000000ADADAD000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000313131000000000000000000000000000000000008080800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000080808000808080000000000ADADAD0000000000ADAD
      AD00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009C9C9C00080808005252520000000000B5B5B5000000
      0000737373000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000018181800181818000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000004A4A4A00101010000808080031313100000000002929
      2900080808002929290000000000000000000000000000000000000000005A5A
      5A00000000000000000063636300000000004242420018181800000000006B6B
      6B00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000188C
      CE00188CCE008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A5A008C5A
      5A008C5A5A008C5A5A008C5A5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000188CCE0073C6
      EF0063C6EF00BDB5AD00FFE7D600FFEFDE00F7EFD600F7EFD600F7EFD600F7E7
      D600F7E7CE00F7E7CE008C5A5A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000B5000000B5000000000000000000000000007B5A
      0000ADFFFF007B5A0000ADFFFF007B5A0000ADFFFF007B5A0000ADFFFF007B5A
      0000ADFFFF008C8C8C0008080800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000188CCE008CE7F7007BEF
      FF0073EFFF00BDB5AD00F7DECE00F7DEC600F7D6B500F7D6B500F7D6B500F7D6
      AD00EFD6B500EFDEC6008C5A5A0000000000000000000000B5000000B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000B5000000B50000000000000000000000000000000000ADFF
      FF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFF
      FF00ADFFFF00080808008C8C8C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000188CCE008CE7F7007BE7
      FF006BE7FF00BDB5AD00F7E7D600F7DEC600F7D6AD00F7D6AD00F7D6AD00F7CE
      A500F7D6B500EFDEC6008C5A5A0000000000000000000000B5000000B5000000
      B500000000000000000000000000000000000000000000000000000000000000
      00000000B5000000B50000000000000000000000000000000000000000007B5A
      0000ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF008C8C8C000808
      0800080808008C8C8C00ADFFFF0000000000000000006B6B6B00292929001818
      1800737373000000000063636300101010000808080063636300000000007373
      730018181800292929006B6B6B000000000000000000188CCE0094E7F7008CEF
      FF007BEFFF00BDB5AD00F7E7DE00F7DEC600F7D6B500F7D6B500F7D6B500F7D6
      AD00F7D6B500EFDECE008C5A5A0000000000000000000000B5000000B5000000
      B5000000B5000000000000000000000000000000000000000000000000000000
      B5000000B500000000000000000000000000000000000000000000000000ADFF
      FF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00080808000000
      0000CECECE000808080008080800000000000000000000000000A5A5A5001010
      1000313131000000000000000000101010000000000000000000000000003131
      310010101000A5A5A500000000000000000000000000188CCE00A5E7F7009CEF
      FF008CEFFF00BDB5AD00FFEFE700FFE7D600FFDEC600F7DEC600F7DEBD00F7DE
      BD00F7DEC600EFE7D6008C5A5A000000000000000000000000000000D6000000
      BD000000B5000000B500000000000000000000000000000000000000B5000000
      B500000000000000000000000000000000000000000000000000000000007B5A
      0000ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00080808000000
      000000000000CECECE0010101000000000000000000000000000000000007373
      7300181818006B6B6B00000000000000000000000000000000006B6B6B001818
      18007373730000000000000000000000000000000000188CCE00ADE7F700ADF7
      FF009CF7FF00BDB5AD00FFF7EF00FFE7C600FFD6AD00FFD6AD00FFD6AD00FFCE
      A500F7DEBD00F7EFDE008C5A5A00000000000000000000000000000000000000
      00000000B5000000B5000000B500000000000000B5000000B5000000B5000000
      000000000000000000000000000000000000000000000000000000000000ADFF
      FF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00080808000000
      0000D6D6D60008080800ADFFFF00000000000000000000000000000000000000
      0000525252003131310063636300000000000000000063636300313131005252
      52000000000000000000000000000000000000000000188CCE00B5EFF700BDF7
      FF00ADF7FF00BDB5AD00FFF7F700FFF7EF00FFEFDE00FFEFDE00FFE7D600FFEF
      DE00F7EFDE00E7DED6008C5A5A00000000000000000000000000000000000000
      0000000000000000B5000000C6000000C6000000CE000000B500000000000000
      0000000000000000000000000000000000000000000000000000000000007B5A
      0000ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00080808000000
      000008080800ADFFFF007B5A0000000000000000000000000000000000000000
      00008C8C8C001818180008080800000000000000000008080800181818008C8C
      8C000000000000000000000000000000000000000000188CCE00C6EFF700D6FF
      FF00BDF7FF00BDB5AD00FFF7F700FFFFFF00FFFFFF00FFFFF700FFFFF700EFE7
      DE00C6ADA500B59C8C008C5A5A00000000000000000000000000000000000000
      000000000000000000000000C6000000C6000000DE0000000000000000000000
      000000000000000000000000000000000000000000007B5A00007B5A00007B5A
      00007B5A00007B5A0000ADFFFF00ADFFFF00ADFFFF00ADFFFF00000000000808
      0800ADFFFF00ADFFFF00ADFFFF00000000000000000000000000000000000000
      0000000000004242420018181800080808000808080018181800424242000000
      00000000000000000000000000000000000000000000188CCE00C6EFF700E7FF
      FF00D6FFFF00BDB5AD00FFFFF700FFFFFF00FFFFFF00FFFFFF00FFFFFF00D6BD
      B500D6945200F77B420000000000000000000000000000000000000000000000
      0000000000000000B5000000D6000000CE000000DE000000EF00000000000000
      00000000000000000000000000000000000000000000000000007B5A00007B5A
      00007B5A0000ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFF
      FF00ADFFFF00ADFFFF007B5A0000000000000000000000000000000000000000
      0000636363001010100094949400000000000000000094949400101010006363
      63000000000000000000000000000000000000000000188CCE00CEEFF700F7FF
      FF00E7FFFF00BDB5AD00FFEFE700FFF7EF00FFF7EF00FFEFEF00FFF7EF00DEB5
      A500B59C6B00188CCE0000000000000000000000000000000000000000000000
      00000000E7000000DE000000D60000000000000000000000E7000000EF000000
      0000000000000000000000000000000000000000000000000000000000007B5A
      0000ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFFFF00ADFF
      FF00ADFFFF00ADFFFF00ADFFFF00000000000000000000000000000000008C8C
      8C00181818008C8C8C00000000001010100008080800000000008C8C8C001818
      18008C8C8C0000000000000000000000000000000000188CCE00D6EFF700FFFF
      FF00F7FFFF00BDB5AD00BDB5AD00BDB5AD00BDB5AD00BDB5AD00BDB5AD00BDB5
      AD006BB5CE00188CCE0000000000000000000000000000000000000000000000
      FF000000DE000000EF00000000000000000000000000000000000000FF000000
      F70000000000000000000000000000000000000000000000000000000000ADFF
      FF00ADFFFF00ADFFFF00ADFFFF007B5A0000ADFFFF00ADFFFF00ADFFFF00ADFF
      FF00ADFFFF00ADFFFF007B5A00000000000000000000000000008C8C8C002121
      210094949400000000004A4A4A0008080800080808004A4A4A00000000009494
      9400212121008C8C8C00000000000000000000000000188CCE00D6EFF700F7F7
      F7009CB5BD0094B5BD0094B5BD0094B5BD008CB5BD008CB5BD009CC6CE00D6FF
      FF006BCEF700188CCE00000000000000000000000000000000000000F7000000
      F7000000FF000000000000000000000000000000000000000000000000000000
      F7000000F700000000000000000000000000000000000000000000000000ADFF
      FF00ADFFFF00ADFFFF007B5A00007B5A0000ADFFFF00ADFFFF00ADFFFF00ADFF
      FF00ADFFFF00ADFFFF00ADFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000188CCE00DEF7FF00D6BD
      B500AD8C8400C6B5AD00C6B5AD00C6B5AD00C6B5AD00C6ADA500A5847B00DEE7
      DE007BD6F700188CCE000000000000000000000000000000F7000000F7000000
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000000F7000000000000000000000000000000000000000000ADFF
      FF00ADFFFF007B5A00007B5A00007B5A00007B5A0000ADFFFF007B5A0000ADFF
      FF007B5A0000ADFFFF007B5A0000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000188CCE00A5C6
      DE007B848C00DECEC600FFF7F700F7F7F700F7F7F700C6B5AD006B848C0073C6
      E700188CCE000000000000000000000000000000F7000000F7000000F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000007B5A00007B5A00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000188C
      CE00188CCE008C7B6B008C7B6B008C7B6B008C7B6B008C7B6B00188CCE00188C
      CE00000000000000000000000000000000000000F7000000F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000007B5A00000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5736B0073424200734242007342420073424200734242007342
      4200734242007342420073424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000094310000A539
      0000A53100009C31000000000000000000000000000094310000A53100009C31
      0000942900000000000000000000000000000000000000000000000000000000
      000000000000A5736B00FFFFE700F7EFDE00F7EFD600F7EFD600F7EFD600F7E7
      CE00F7EFD600EFDEC60073424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C3100000000
      000000000000942900009429000000000000942900009C310000000000000000
      0000942900000000000000000000000000000000000000000000000000000000
      000000000000A5736B00F7EFDE00F7DEBD00F7D6BD00F7D6BD00EFD6B500EFD6
      B500EFDEBD00E7D6BD0073424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C3100000000
      0000000000000000000094290000000000009429000000000000000000000000
      0000942900000000000000000000000000000000000000000000000000000000
      000000000000A5736B00FFEFDE00FFC69400FFC69400FFC69400FFC69400FFC6
      9400FFC69400E7D6BD0073424200000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C3100009429
      0000000000000000000094290000000000009429000000000000000000008C21
      00009429000000000000000000000000000000000000A5736B00734242007342
      420073424200A5736B00FFF7E700F7DEBD00F7D6B500F7D6B500F7D6B500F7D6
      AD00F7DEC600E7D6C60084524A00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000A539
      00009C310000A53100009C310000000000009C3100009C310000942900009429
      00000000000000000000000000000000000000000000A5736B00FFFFE700F7EF
      DE00F7EFD600A5736B00FFF7EF00FFDEBD00FFDEBD00FFDEB500F7D6B500F7D6
      B500F7DEC600E7D6C60084524A00000000000000000000000000840000008400
      0000840000008400000084000000000000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000000000000084000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      00009C310000A52900008C2900006B2910008C2900009C290000942900000000
      00000000000000000000000000000000000000000000A5736B00F7EFDE00F7DE
      BD00F7D6BD00A5736B00FFFFF700FFC69400FFC69400FFC69400FFC69400FFC6
      9400FFC69400EFDECE008C5A5A00000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000008400
      0000840000008400000000000000000000000000000000000000000000000000
      000000000000000000006B4A39009C8484009429000000000000000000000000
      00000000000000000000000000000000000000000000A5736B00FFEFDE00FFC6
      9400FFC69400A5736B00FFFFFF00FFE7CE00FFE7C600FFDEC600FFDEC600FFE7
      C600FFF7DE00E7D6CE008C5A5A00000000000000000000000000840000008400
      0000840000000000000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000004A393100B59C9C00BDA5A5006B5A520052423900000000000000
      00000000000000000000000000000000000000000000A5736B00FFF7E700F7DE
      BD00F7D6B500A5736B00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFFFF700E7D6
      D600C6B5AD00A59494009C635A00000000000000000000000000840000008400
      0000000000008400000000000000000000000000000000000000000000000000
      0000000000008400000000000000000000000000000000000000840000000000
      0000000000000000000000000000000000000000000000000000840000000000
      0000840000008400000000000000000000000000000000000000000000000000
      0000000000008C736B00E7D6D60073635A00AD8C8C009C7B73004A3931000000
      00000000000000000000000000000000000000000000A5736B00FFF7EF00FFDE
      BD00FFDEBD00A5736B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A573
      6B00A5736B00A5736B00A5736B00000000000000000000000000840000000000
      0000000000000000000084000000840000000000000000000000000000000000
      0000840000000000000000000000000000000000000000000000000000008400
      0000000000000000000000000000000000008400000084000000000000000000
      0000000000008400000000000000000000000000000000000000000000000000
      000052423100E7DEDE00AD9C9C004A312900A5848400C6A5A500634A42000000
      00000000000000000000000000000000000000000000A5736B00FFFFF700FFC6
      9400FFC69400A5736B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A573
      6B00E7A55200B5735A0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      0000000000000000000000000000000000000000000000000000000000000000
      0000840000008400000084000000840000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009473
      6B0094847B00E7E7E7005A4A3900000000005A4A3900C6A59C0094736B009473
      6B000000000000000000000000000000000000000000A5736B00FFFFFF00FFE7
      CE00FFE7C600A5736B00A5736B00A5736B00A5736B00A5736B00A5736B00A573
      6B00AD6B6B000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005242
      3100CEC6C600948C8400000000000000000000000000846B6300B59494005242
      31000000000000000000000000000000000000000000A5736B00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFFFF700E7D6D600C6B5AD00A59494009C635A000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B5A
      4A00B5A59C0052393100000000000000000000000000523931009C7B7B006B52
      4A000000000000000000000000000000000000000000A5736B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A5736B00A5736B00A5736B00A5736B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000006B5A
      4A00735A520000000000000000000000000000000000000000006B524A006B52
      4A000000000000000000000000000000000000000000A5736B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A5736B00E7A55200B5735A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005242
      3100000000000000000000000000000000000000000000000000000000005242
      31000000000000000000000000000000000000000000A5736B00A5736B00A573
      6B00A5736B00A5736B00A5736B00A5736B00AD6B6B0000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFFCFFF0000
      FFFFFC7F84730000F10FF83F80230000FB1FF01FC0070000F83FE00FE00F0000
      F93FC007C0070000FC7FC003C0030000FC7F800380030000FE7F800380030000
      FEFFC003C0030000FFFBF001E0010000FFF1F800C0000000FFE0FC008C000000
      FFFFFFF09FF00000FFFFFFF9FFF90000FFFFFFFF0000FFFFFFFF8FFF0000FFFF
      F8018C03C787C787FFFF8FFFE383E3838001FFFFF7C7F7C7FFFFFFFFF007F007
      F8018FFFF80FF80FFFFF8C03F98FF98F80018FFFF90FF90FFFFFFFFFFD1FFD1F
      F801FFFFFC1FFC1FFFFF8FFFFE3FFE3F80018C03FE3FFE3FFFFF8FFFFE7FFE60
      FFFFFFFFFFFFFFF1FFFFFFFFFFFFFFFBFFFFFFFFFFFFFFFFFFFFF007FFFFFFFF
      FFFFFFFF801FE007C21FFF0FFFFFFFFFE23FFF9F80018001E23FFF9FFFFFFFFF
      F07FF81F801FE007F83FF19FFFFFFFFFF81FF39F80018001FC8FF39FFFFFFFFF
      FC47F39F801FE007FC23E10FFFFFFFFFFFFFFFFF80018001FFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE001FFFFFFFFFFFFC001FFFCE001FFFF
      80019FF9E001FFFF80018FF3E0018421800187E7E011C6638001C3CFE019E247
      8001F11FE011F00F8001F83FE011F00F8001FC7F8001F81F8003F83FC001F00F
      8003F19FE001E2478003E3CFE001C4238003C7E7E001FFFF80038FFBE001FFFF
      C0071FFFFCFFFFFFE00F3FFFFEFFFFFFFFFFFFFFFFFFF801FFFFFFFFC387F801
      FFFFFFFFD937F801FFFFFFFFDD77F801FFFFFFFFCD678001FFF7EFFFE10F8001
      C1F7EF83F01F8001C3FBDFC3FC7F8001C7FBDFE3F83F8001CBFBDFD3F81F8001
      DCF7EF3BF01F8003FF0FF0FFE10F8007FFFFFFFFE38F801FFFFFFFFFE38F801F
      FFFFFFFFE7CF803FFFFFFFFFEFEF807F00000000000000000000000000000000
      000000000000}
  end
  object ActionManager2: TActionManager
    Images = ImageListForRichEditMenu
    Left = 340
    Top = 575
    StyleName = 'XP Style'
    object Action_RichEditCut: TAction
      Caption = #1042#1099#1088#1077#1079#1072#1090#1100
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1088#1077#1079#1072#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072' '#1080' '#1087#1086#1084#1077#1097#1077#1085#1080#1103' '#1077#1075#1086' '#1074' '#1073#1091#1092#1077#1088 +
        ' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 2
      OnExecute = Action_RichEditCutExecute
    end
    object Action_RichEditUndo: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1087#1086#1089#1083#1077#1076#1085#1080#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      ImageIndex = 0
      OnExecute = Action_RichEditUndoExecute
    end
    object Action_RichEditCopy: TAction
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 3
      OnExecute = Action_RichEditCopyExecute
    end
    object Action_RichEditPaste: TAction
      Caption = #1042#1089#1090#1072#1074#1080#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1089#1090#1072#1074#1082#1080' '#1090#1077#1082#1089#1090#1072' '#1080#1079' '#1073#1091#1092#1077#1088#1072' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 4
      OnExecute = Action_RichEditPasteExecute
    end
    object Action_RichEditSelectAll: TAction
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1105
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1075#1086' '#1090#1077#1082#1089#1090#1072
      ImageIndex = 6
      OnExecute = Action_RichEditSelectAllExecute
    end
    object Action_RichEditErase: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072
      ImageIndex = 5
      OnExecute = Action_RichEditEraseExecute
    end
    object Action_RichEditRedo: TAction
      Caption = #1042#1077#1088#1085#1091#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1086#1079#1074#1088#1072#1090#1072' '#1086#1090#1084#1077#1085#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      ImageIndex = 1
      OnExecute = Action_RichEditRedoExecute
    end
    object Action_RichEditBold: TAction
      Caption = #1046#1080#1088#1085#1099#1081' '#1096#1088#1080#1092#1090
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1095#1090#1086#1073#1099' '#1089#1076#1077#1083#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1078#1080#1088#1085#1099#1084
      ImageIndex = 7
      OnExecute = Action_RichEditBoldExecute
    end
    object Action_RichEditItalic: TAction
      Caption = #1053#1072#1082#1083#1086#1085#1085#1099#1081' '#1096#1088#1080#1092#1090
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1095#1090#1086#1073#1099' '#1089#1076#1077#1083#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090'  '#1085#1072#1082#1083#1086#1085#1085#1099#1084
      ImageIndex = 8
      OnExecute = Action_RichEditItalicExecute
    end
    object Action_RichEditUnderline: TAction
      Caption = #1055#1086#1076#1095#1105#1088#1082#1085#1091#1090#1099#1081' '#1096#1088#1080#1092#1090
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1095#1090#1086#1073#1099' '#1089#1076#1077#1083#1072#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1081' '#1090#1077#1082#1089#1090' '#1087#1086#1076#1095#1105#1088#1082#1085#1091#1090#1099#1084
      ImageIndex = 9
      OnExecute = Action_RichEditUnderlineExecute
    end
    object Action_RichEditLeftAlign: TAction
      Caption = #1055#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102
      GroupIndex = 1
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1087#1072#1088#1072#1075#1088#1072#1092#1086#1074' '#1087#1086' '#1083#1077#1074#1086#1084#1091' '#1082#1088#1072#1102
      ImageIndex = 10
      OnExecute = Action_RichEditLeftAlignExecute
    end
    object Action_RichEditCenterAlign: TAction
      Caption = #1055#1086' '#1094#1077#1085#1090#1088#1091
      GroupIndex = 1
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1087#1072#1088#1072#1075#1088#1072#1092#1086#1074' '#1087#1086' '#1094#1077#1085#1090#1088#1091
      ImageIndex = 11
      OnExecute = Action_RichEditCenterAlignExecute
    end
    object Action_RichEditRightAlign: TAction
      Caption = #1055#1086' '#1087#1088#1072#1074#1086#1084#1091' '#1082#1088#1072#1102
      GroupIndex = 1
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1088#1072#1074#1085#1080#1074#1072#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1087#1072#1088#1072#1075#1088#1072#1092#1086#1074' '#1087#1086' '#1087#1088#1072#1074#1086#1084#1091' '#1082#1088#1072#1102
      ImageIndex = 12
      OnExecute = Action_RichEditRightAlignExecute
    end
    object Action_RichEditBullets: TAction
      Caption = #1052#1072#1088#1082#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1089#1087#1080#1089#1086#1082
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1084#1077#1090#1082#1080' '#1074#1099#1076#1077#1083#1077#1085#1085#1099#1093' '#1089#1090#1088#1086#1082' '#1082#1072#1082' '#1084#1072#1088#1082#1080#1088#1086#1074#1072#1085#1085#1086#1075#1086' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 13
      OnExecute = Action_RichEditBulletsExecute
    end
    object Action_RichEditEnlargeFont: TAction
      Caption = #1059#1074#1077#1083#1080#1095#1080#1090#1100' '#1096#1088#1080#1092#1090
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1074#1077#1083#1080#1095#1077#1085#1080#1103' '#1096#1088#1080#1092#1090#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1072' '#1085#1072' 1'#1087#1090
      ImageIndex = 15
      OnExecute = Action_RichEditEnlargeFontExecute
    end
    object Action_RichEditDecreaseFont: TAction
      Caption = #1059#1084#1077#1085#1080#1096#1080#1090#1100' '#1096#1088#1080#1092#1090
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1084#1077#1085#1100#1096#1077#1085#1080#1103' '#1096#1088#1080#1092#1090#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1072' '#1085#1072' 1'#1087#1090
      ImageIndex = 16
      OnExecute = Action_RichEditDecreaseFontExecute
    end
    object Action_RichEditFormatBySample: TAction
      Caption = #1060#1086#1088#1084#1072#1090' '#1087#1086' '#1086#1073#1088#1072#1079#1094#1091
      ImageIndex = 17
      OnExecute = Action_RichEditFormatBySampleExecute
    end
    object Action_RichEditDefaultFormat: TAction
      Caption = #1059#1073#1088#1072#1090#1100' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1077
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1092#1086#1088#1084#1072#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072
      ImageIndex = 18
      OnExecute = Action_RichEditDefaultFormatExecute
    end
    object Action_RichEditSetTextColor: TAction
      Caption = #1062#1074#1077#1090' '#1090#1077#1082#1089#1090#1072
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1103' '#1094#1074#1077#1090#1072' '#1096#1088#1080#1092#1090#1072' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1090#1077#1082#1089#1090#1072
      ImageIndex = 14
      OnExecute = Action_RichEditSetTextColorExecute
    end
  end
  object PopupMenu1: TPopupMenu
    OwnerDraw = True
    Left = 370
    Top = 575
  end
  object pmRichEdit: TPopupMenu
    Images = ImageListForRichEditMenu
    Left = 400
    Top = 575
    object MenuItem1: TMenuItem
      Action = Action_RichEditUndo
    end
    object MenuItem2: TMenuItem
      Action = Action_RichEditRedo
    end
    object MenuItem3: TMenuItem
      Caption = '-'
    end
    object miCut: TMenuItem
      Action = Action_RichEditCut
    end
    object MenuItem4: TMenuItem
      Action = Action_RichEditCopy
    end
    object MenuItem5: TMenuItem
      Action = Action_RichEditPaste
    end
    object N27: TMenuItem
      Action = Action_RichEditErase
    end
    object N28: TMenuItem
      Caption = '-'
    end
    object N29: TMenuItem
      Action = Action_RichEditSelectAll
    end
    object MenuItem6: TMenuItem
      Caption = '-'
    end
    object MenuItem7: TMenuItem
      Caption = #1064#1088#1080#1092#1090'...'
      Visible = False
    end
    object N25: TMenuItem
      Caption = #1057#1087#1080#1089#1086#1082'...'
      Visible = False
    end
  end
  object Timer_MessageStatus: TTimer
    Enabled = False
    Interval = 60000
    OnTimer = Timer_MessageStatusTimer
    Left = 461
    Top = 575
  end
  object pmUseMultibufferrMenu: TPopupMenu
    OnPopup = pmUseMultibufferrMenuPopup
    Left = 492
    Top = 575
    object miUseMultiBuffer: TMenuItem
      AutoCheck = True
      Caption = #1048#1089#1087#1083#1100#1079#1086#1074#1072#1090#1100' '#1084#1091#1083#1100#1090#1080#1073#1091#1092#1077#1088
      Hint = #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1080#1089#1087#1086#1083#1100#1079#1086#1074#1072#1085#1080#1103' '#1092#1091#1085#1082#1094#1080#1081' '#1084#1091#1083#1100#1090#1080#1073#1091#1092#1077#1088#1072
      OnClick = miUseMultiBufferClick
    end
  end
end
