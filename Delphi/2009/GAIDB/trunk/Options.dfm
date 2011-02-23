object OptionsForm: TOptionsForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = 'OA4 - '#1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103
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
  object TreeView2: TTreeView
    Left = 0
    Top = 0
    Width = 181
    Height = 256
    Align = alLeft
    AutoExpand = True
    HotTrack = True
    Indent = 19
    ReadOnly = True
    TabOrder = 0
    OnChange = TreeView2Change
    Items.NodeData = {
      01040000002B0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000918043D044204350440044404350439044104410000000000000000000000
      FFFFFFFFFFFFFFFF000000000000000014210435044004320435044004200038
      04200031043004370430042000340430043D043D044B0445042D000000000000
      0000000000FFFFFFFFFFFFFFFF00000000000000000A1B043E0433042D003A04
      3B04380435043D044204250000000000000000000000FFFFFFFFFFFFFFFF0000
      000000000000061F0440043E04470435043504}
  end
  object Panel2: TPanel
    Left = 181
    Top = 0
    Width = 453
    Height = 256
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    FullRepaint = False
    TabOrder = 1
    object pnlButtons: TPanel
      Left = 2
      Top = 217
      Width = 449
      Height = 37
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        449
        35)
      object btnApply: TButton
        Left = 208
        Top = 5
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Hint = 
          #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1074' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1080 +
          ' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
        Anchors = [akTop, akRight]
        Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
        Default = True
        ModalResult = 1
        TabOrder = 3
      end
      object btnClose: TButton
        Left = 288
        Top = 5
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Hint = 
          #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1089#1077#1093' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1074' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1080' '#1079#1072#1082 +
          #1088#1099#1090#1080#1103' '#1086#1082#1085#1072
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = '&'#1047#1072#1082#1088#1099#1090#1100
        ModalResult = 2
        TabOrder = 4
      end
      object btnHelp: TButton
        Left = 368
        Top = 5
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
        Anchors = [akTop, akRight]
        Caption = '&'#1057#1087#1088#1072#1074#1082#1072
        TabOrder = 5
      end
      object btnDefaults: TButton
        Left = 4
        Top = 6
        Width = 75
        Height = 25
        Cursor = crHandPoint
        Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1073#1088#1086#1089#1072' '#1074#1089#1077#1093' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1082' '#1079#1085#1072#1095#1077#1085#1080#1103#1084' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
        Anchors = [akTop, akRight]
        Caption = '&'#1057#1073#1088#1086#1089
        TabOrder = 0
        OnClick = btnDefaultsClick
      end
      object btbtnLineUp: TBitBtn
        Left = 120
        Top = 6
        Width = 26
        Height = 25
        TabOrder = 1
        Visible = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FF000000000000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF
          00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF000000000000000000000000FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FF000000000000FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF
          00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FF000000000000000000000000FF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
          0000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        Layout = blGlyphBottom
        Style = bsNew
      end
      object btbtnLineDown: TBitBtn
        Left = 152
        Top = 6
        Width = 26
        Height = 25
        TabOrder = 2
        Visible = False
        Glyph.Data = {
          36030000424D3603000000000000360000002800000010000000100000000100
          1800000000000003000000000000000000000000000000000000FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000
          0000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF000000000000FF00FFFF00FF000000000000FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF
          00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00000000
          0000000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FF000000000000FF00FFFF00FF000000000000FF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000000000000FF00FFFF
          00FFFF00FFFF00FF000000000000FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        Layout = blGlyphBottom
        Style = bsNew
      end
    end
    object PageControl1: TPageControl
      Left = 2
      Top = 2
      Width = 449
      Height = 215
      ActivePage = TabSheet1
      Align = alClient
      Style = tsButtons
      TabOrder = 0
      TabStop = False
      object TabSheet1: TTabSheet
        Caption = #1048#1085#1090#1077#1088#1092#1077#1081#1089
        TabVisible = False
        object GroupBox2: TGroupBox
          Left = 0
          Top = 0
          Width = 441
          Height = 205
          Align = alClient
          Caption = ' '#1048#1085#1090#1077#1088#1092#1077#1081#1089' '
          TabOrder = 0
          object Label9: TLabel
            Left = 265
            Top = 178
            Width = 6
            Height = 13
            Caption = 'x'
          end
          object Label10: TLabel
            Left = 352
            Top = 179
            Width = 6
            Height = 13
            Caption = 'y'
          end
          object chkbxStoreLastLogin: TCheckBox
            Left = 10
            Top = 16
            Width = 251
            Height = 17
            Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1083#1086#1075#1080#1085' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
            TabOrder = 0
            OnClick = chkbxStoreLastLoginClick
          end
          object chkbxStoreLastPassword: TCheckBox
            Left = 10
            Top = 39
            Width = 251
            Height = 17
            Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
            Enabled = False
            TabOrder = 1
            OnClick = chkbxStoreLastPasswordClick
          end
          object chkbxStartMainRect: TCheckBox
            Left = 10
            Top = 177
            Width = 216
            Height = 17
            Caption = #1057#1090#1072#1088#1090#1086#1074#1072#1090#1100' '#1089' '#1091#1082#1072#1079#1072#1085#1085#1099#1084#1080' '#1088#1072#1079#1084#1077#1088#1072#1084#1080
            TabOrder = 7
            OnClick = chkbxStartMainRectClick
          end
          object chkbxStartupFullScreen: TCheckBox
            Left = 10
            Top = 131
            Width = 171
            Height = 17
            Caption = #1056#1072#1079#1074#1086#1088#1072#1095#1080#1074#1072#1090#1100' '#1085#1072' '#1074#1077#1089#1100' '#1101#1082#1088#1072#1085
            TabOrder = 5
            OnClick = chkbxStartupFullScreenClick
          end
          object chkbxSaveSize: TCheckBox
            Left = 10
            Top = 154
            Width = 201
            Height = 17
            Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1088#1072#1079#1084#1077#1088#1099' '#1075#1083#1072#1074#1085#1086#1075#1086' '#1086#1082#1085#1072
            TabOrder = 6
            OnClick = chkbxSaveSizeClick
          end
          object edbxMainFormWidth: TEdit
            Left = 277
            Top = 175
            Width = 69
            Height = 21
            TabOrder = 8
          end
          object edbxMainFormHeight: TEdit
            Left = 364
            Top = 175
            Width = 69
            Height = 21
            TabOrder = 9
          end
          object chkbxAutoLogon: TCheckBox
            Left = 320
            Top = 39
            Width = 76
            Height = 17
            Hint = #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103
            Caption = #1040#1074#1090#1086#1083#1086#1075#1086#1085
            TabOrder = 2
          end
          object chkbxNoToolBar: TCheckBox
            Left = 10
            Top = 62
            Width = 296
            Height = 17
            Caption = #1053#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1082#1085#1086#1087#1086#1082' '#1087#1088#1080' '#1089#1090#1072#1088#1090#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
            TabOrder = 3
          end
          object chkbxNoStatusBar: TCheckBox
            Left = 10
            Top = 85
            Width = 306
            Height = 17
            Caption = #1053#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1089#1090#1072#1090#1091#1089#1072' '#1087#1088#1080' '#1089#1090#1072#1088#1090#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
            TabOrder = 4
          end
          object chkbxShowFullSearchBar: TCheckBox
            Left = 10
            Top = 108
            Width = 306
            Height = 17
            Caption = #1042#1089#1077#1075#1076#1072' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1087#1086#1080#1089#1082#1072' '#1094#1077#1083#1080#1082#1086#1084
            TabOrder = 10
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1057#1077#1088#1074#1077#1088' '#1080' '#1073#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
        ImageIndex = 1
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox1: TGroupBox
          Left = 0
          Top = 0
          Width = 441
          Height = 205
          Align = alClient
          Caption = ' '#1057#1077#1088#1074#1077#1088' '#1080' '#1073#1072#1079#1072' '#1076#1072#1085#1085#1099#1093' '
          TabOrder = 0
          object Label1: TLabel
            Left = 10
            Top = 20
            Width = 41
            Height = 13
            Caption = #1057#1077#1088#1074#1077#1088':'
            FocusControl = edbxMySQLHost
          end
          object Label2: TLabel
            Left = 10
            Top = 45
            Width = 29
            Height = 13
            Caption = #1055#1086#1088#1090':'
            FocusControl = edbxMySQLPort
          end
          object Label3: TLabel
            Left = 10
            Top = 70
            Width = 88
            Height = 13
            Caption = #1042#1088#1077#1084#1103' '#1086#1078#1080#1076#1072#1085#1080#1103':'
            FocusControl = edbxMySQLTimeout
          end
          object Label4: TLabel
            Left = 235
            Top = 46
            Width = 76
            Height = 13
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
            FocusControl = edbxMySQLUser
          end
          object Label5: TLabel
            Left = 235
            Top = 71
            Width = 41
            Height = 13
            Caption = #1055#1072#1088#1086#1083#1100':'
            FocusControl = edbxMySQLPassword
          end
          object Label6: TLabel
            Left = 235
            Top = 20
            Width = 69
            Height = 13
            Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093':'
            FocusControl = edbxMySQLDatabase
          end
          object edbxMySQLHost: TEdit
            Left = 110
            Top = 17
            Width = 96
            Height = 21
            TabOrder = 0
            Text = 'GAISERVER'
          end
          object edbxMySQLPort: TEdit
            Left = 110
            Top = 42
            Width = 96
            Height = 21
            TabOrder = 1
            Text = '3306'
          end
          object edbxMySQLTimeout: TEdit
            Left = 110
            Top = 67
            Width = 96
            Height = 21
            TabOrder = 2
            Text = '30'
          end
          object chkbxMySQLCompress: TCheckBox
            Left = 10
            Top = 94
            Width = 94
            Height = 17
            Caption = #1057#1078#1072#1090#1080#1077
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
          object edbxMySQLDatabase: TEdit
            Left = 335
            Top = 17
            Width = 96
            Height = 21
            TabOrder = 4
            Text = 'gai'
          end
          object edbxMySQLPassword: TEdit
            Left = 335
            Top = 68
            Width = 96
            Height = 21
            PasswordChar = '*'
            TabOrder = 6
            Text = 'sqladmin'
          end
          object edbxMySQLUser: TEdit
            Left = 335
            Top = 43
            Width = 96
            Height = 21
            TabOrder = 5
            Text = 'gai'
          end
        end
      end
      object TabSheet3: TTabSheet
        Caption = #1057#1087#1080#1089#1086#1082' '#1072#1074#1090#1086#1079#1072#1084#1077#1085#1099
        ImageIndex = 2
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox3: TGroupBox
          Left = 0
          Top = 0
          Width = 441
          Height = 205
          Align = alClient
          Caption = ' '#1057#1087#1080#1089#1086#1082' '#1072#1074#1090#1086#1079#1072#1084#1077#1085#1099' '
          TabOrder = 0
          object lblAutoReplaceSorry: TLabel
            Left = 2
            Top = 15
            Width = 3
            Height = 13
            Align = alClient
            Alignment = taCenter
            Layout = tlCenter
          end
          object sgAutoReplaceList: TStringGrid
            Left = 2
            Top = 15
            Width = 437
            Height = 188
            Hint = #1057#1087#1080#1089#1086#1082' '#1089#1090#1088#1086#1082' '#1076#1083#1103' '#1072#1074#1090#1086#1079#1072#1084#1077#1085#1099
            Align = alClient
            ColCount = 3
            Ctl3D = True
            DefaultColWidth = 200
            DefaultRowHeight = 19
            RowCount = 1001
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowMoving, goEditing, goAlwaysShowEditor]
            ParentCtl3D = False
            TabOrder = 0
            Visible = False
            ColWidths = (
              14
              200
              200)
          end
        end
      end
      object TabSheet4: TTabSheet
        Caption = #1055#1088#1086#1095#1077#1077
        ImageIndex = 3
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox5: TGroupBox
          Left = 0
          Top = 0
          Width = 441
          Height = 205
          Align = alClient
          Caption = ' '#1055#1088#1086#1095#1077#1077' '
          TabOrder = 0
          object chkbxNoLogo: TCheckBox
            Left = 10
            Top = 18
            Width = 281
            Height = 17
            Caption = #1053#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1086#1082#1085#1086' "'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'..." '#1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
            TabOrder = 0
          end
          object chkbxShowID: TCheckBox
            Left = 10
            Top = 41
            Width = 336
            Height = 17
            Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' ID '#1079#1072#1087#1080#1089#1077#1081' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093' '#1087#1088#1080' '#1088#1072#1073#1086#1090#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
            TabOrder = 1
          end
          object chkbxCustomHelpFile: TCheckBox
            Left = 10
            Top = 64
            Width = 176
            Height = 17
            Caption = #1057#1090#1086#1088#1086#1085#1085#1080#1081' '#1089#1087#1088#1072#1074#1086#1095#1085#1099#1081' '#1092#1072#1081#1083
            TabOrder = 2
            OnClick = chkbxCustomHelpFileClick
          end
          object edbxCustomHelpFile: TEdit
            Left = 185
            Top = 61
            Width = 221
            Height = 21
            Enabled = False
            TabOrder = 3
          end
          object btnChoiseCustomHelpFile: TButton
            Left = 412
            Top = 61
            Width = 21
            Height = 21
            Caption = '...'
            TabOrder = 4
            OnClick = btnChoiseCustomHelpFileClick
          end
        end
      end
      object TabSheet5: TTabSheet
        Caption = #1051#1086#1075'-'#1082#1083#1080#1077#1085#1090
        ImageIndex = 4
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object GroupBox4: TGroupBox
          Left = 0
          Top = 0
          Width = 441
          Height = 205
          Align = alClient
          Caption = ' '#1051#1086#1075'-'#1082#1083#1080#1077#1085#1090' '
          TabOrder = 0
          object chkbxCustomLogClientFile: TCheckBox
            Left = 10
            Top = 18
            Width = 116
            Height = 17
            Caption = #1059#1082#1072#1079#1072#1085#1085#1099#1081' '#1092#1072#1081#1083
            TabOrder = 0
            OnClick = chkbxCustomLogClientFileClick
          end
          object edbxCustomLogClientFile: TEdit
            Left = 127
            Top = 16
            Width = 279
            Height = 21
            Enabled = False
            TabOrder = 1
          end
          object btnChoiseCustomLogClientFile: TButton
            Left = 412
            Top = 16
            Width = 21
            Height = 21
            Caption = '...'
            TabOrder = 2
            OnClick = btnChoiseCustomLogClientFileClick
          end
        end
      end
      object TabSheet6: TTabSheet
        Caption = #1051#1086#1075'-'#1089#1077#1088#1074#1077#1088
        ImageIndex = 5
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
      end
    end
  end
end
