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
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object TreeView2: TTreeView
    Left = 0
    Top = 0
    Width = 181
    Height = 256
    Align = alLeft
    AutoExpand = True
    HideSelection = False
    HotTrack = True
    Indent = 19
    ReadOnly = True
    TabOrder = 0
    OnChange = TreeView2Change
    Items.NodeData = {
      01060000002B0000000000000000000000FFFFFFFFFFFFFFFF00000000000000
      000918043D044204350440044404350439044104410000000000000000000000
      FFFFFFFFFFFFFFFF000000000000000014210435044004320435044004200038
      04200031043004370430042000340430043D043D044B0445042D000000000000
      0000000000FFFFFFFFFFFFFFFF00000000000000000A1B043E0433042D003A04
      3B04380435043D0442042D0000000000000000000000FFFFFFFFFFFFFFFF0000
      0000000000000A1B043E0433042D004104350440043204350440043B00000000
      00000000000000FFFFFFFFFFFFFFFF00000000000000001121043F0438044104
      3E043A0420003004320442043E04370430043C0435043D044B04250000000000
      000000000000FFFFFFFFFFFFFFFF0000000000000000061F0440043E04470435
      043504}
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
      Top = 215
      Width = 449
      Height = 39
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        449
        37)
      object btnApply: TButton
        Left = 208
        Top = 6
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
        Top = 6
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
        Top = 6
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
        Left = 114
        Top = 6
        Width = 26
        Height = 25
        TabOrder = 1
        Visible = False
        OnClick = btbtnLineUpClick
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
        Left = 146
        Top = 6
        Width = 26
        Height = 25
        TabOrder = 2
        Visible = False
        OnClick = btbtnLineDownClick
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
      Height = 213
      ActivePage = TabSheet1
      Align = alClient
      Style = tsButtons
      TabOrder = 0
      TabStop = False
      object TabSheet1: TTabSheet
        Caption = #1048#1085#1090#1077#1088#1092#1077#1081#1089
        TabVisible = False
        object ScrollBox1: TScrollBox
          Left = 0
          Top = 0
          Width = 441
          Height = 203
          VertScrollBar.Position = 110
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          TabOrder = 0
          object GroupBox1: TGroupBox
            Left = 0
            Top = 318
            Width = 424
            Height = 318
            Align = alTop
            Caption = ' '#1055#1086#1079#1080#1094#1080#1103' '#1076#1080#1072#1083#1086#1075#1086#1074#1099#1093' '#1086#1082#1086#1085' '
            TabOrder = 3
            object lblLoginFormPosition: TLabel
              Left = 11
              Top = 21
              Width = 94
              Height = 13
              Caption = #1054#1082#1085#1086' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103
            end
            object lblLoginFormPositionX: TLabel
              Left = 155
              Top = 21
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblLoginFormPositionY: TLabel
              Left = 242
              Top = 21
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblOptionsFormPositionY: TLabel
              Left = 242
              Top = 48
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblOptionsFormPositionX: TLabel
              Left = 155
              Top = 48
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblOptionsFormPosition: TLabel
              Left = 11
              Top = 48
              Width = 102
              Height = 13
              Caption = #1054#1082#1085#1086' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080
            end
            object lblUsersFormPosition: TLabel
              Left = 11
              Top = 75
              Width = 116
              Height = 13
              Caption = #1054#1082#1085#1086' '#1091#1095#1105#1090#1085#1099#1093' '#1079#1072#1087#1080#1089#1077#1081
            end
            object lblUsersFormPositionX: TLabel
              Left = 155
              Top = 75
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblUsersFormPositionY: TLabel
              Left = 242
              Top = 75
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblSetPasswordFormPosition: TLabel
              Left = 11
              Top = 102
              Width = 99
              Height = 13
              Caption = #1054#1082#1085#1086' '#1089#1084#1077#1085#1099' '#1087#1072#1088#1086#1083#1103
            end
            object lblSetPasswordFormPositionX: TLabel
              Left = 155
              Top = 102
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblSetPasswordFormPositionY: TLabel
              Left = 242
              Top = 102
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblStatisticFormPosition: TLabel
              Left = 11
              Top = 129
              Width = 87
              Height = 13
              Caption = #1054#1082#1085#1086' '#1089#1090#1072#1090#1080#1089#1090#1080#1082#1080
            end
            object lblStatisticFormPositionX: TLabel
              Left = 155
              Top = 129
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblStatisticFormPositionY: TLabel
              Left = 242
              Top = 129
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblMaintenanceFormPosition: TLabel
              Left = 11
              Top = 156
              Width = 119
              Height = 13
              Caption = #1054#1082#1085#1086' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1103' '#1041#1044
            end
            object lblMaintenanceFormPositionX: TLabel
              Left = 155
              Top = 156
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblMaintenanceFormPositionY: TLabel
              Left = 242
              Top = 156
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblClearingFormPosition: TLabel
              Left = 11
              Top = 183
              Width = 87
              Height = 13
              Caption = #1054#1082#1085#1086' '#1086#1095#1080#1089#1090#1082#1080' '#1041#1044
            end
            object lblClearingFormPositionX: TLabel
              Left = 155
              Top = 183
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblClearingFormPositionY: TLabel
              Left = 242
              Top = 183
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblCreateViewPostFormPosition: TLabel
              Left = 11
              Top = 237
              Width = 141
              Height = 13
              Caption = #1054#1082#1085#1086' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
            end
            object lblPhonesFormPosition: TLabel
              Left = 11
              Top = 264
              Width = 122
              Height = 13
              Caption = #1054#1082#1085#1086' '#1089#1087#1080#1089#1082#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074
            end
            object lblAddEditPhoneFormPosition: TLabel
              Left = 11
              Top = 291
              Width = 135
              Height = 13
              Caption = #1054#1082#1085#1086' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1090#1077#1083#1077#1092#1086#1085#1072
            end
            object lblViewPostListFormPosition: TLabel
              Left = 11
              Top = 210
              Width = 122
              Height = 13
              Caption = #1054#1082#1085#1086' '#1089#1087#1080#1089#1082#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
            end
            object lblViewPostListFormPositionX: TLabel
              Left = 155
              Top = 210
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblViewPostListFormPositionY: TLabel
              Left = 242
              Top = 210
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblCreateViewPostFormPositionX: TLabel
              Left = 155
              Top = 237
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblCreateViewPostFormPositionY: TLabel
              Left = 242
              Top = 237
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblPhonesFormPositionX: TLabel
              Left = 155
              Top = 264
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblPhonesFormPositionY: TLabel
              Left = 242
              Top = 264
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblAddEditPhoneFormPositionX: TLabel
              Left = 155
              Top = 291
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblAddEditPhoneFormPositionY: TLabel
              Left = 242
              Top = 291
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object edbxLoginFormPositionX: TEdit
              Left = 167
              Top = 18
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 0
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxLoginFormPositionY: TEdit
              Left = 254
              Top = 18
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 1
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxLoginFormPositionByCenter: TCheckBox
              Left = 329
              Top = 20
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = chkbxLoginFormPositionByCenterClick
            end
            object chkbxOptionsFormPositionByCenter: TCheckBox
              Left = 329
              Top = 47
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 3
              OnClick = chkbxOptionsFormPositionByCenterClick
            end
            object edbxOptionsFormPositionY: TEdit
              Left = 254
              Top = 45
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 4
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxOptionsFormPositionX: TEdit
              Left = 167
              Top = 45
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 5
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxUsersFormPositionX: TEdit
              Left = 167
              Top = 72
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 6
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxUsersFormPositionY: TEdit
              Left = 254
              Top = 72
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 7
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxUsersFormPositionByCenter: TCheckBox
              Left = 329
              Top = 74
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 8
              OnClick = chkbxUsersFormPositionByCenterClick
            end
            object edbxSetPasswordFormPositionX: TEdit
              Left = 167
              Top = 99
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 9
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxSetPasswordFormPositionY: TEdit
              Left = 254
              Top = 99
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 10
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxSetPasswordFormPositionByCenter: TCheckBox
              Left = 329
              Top = 101
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 11
              OnClick = chkbxSetPasswordFormPositionByCenterClick
            end
            object edbxStatisticFormPositionX: TEdit
              Left = 167
              Top = 126
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 12
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxStatisticFormPositionY: TEdit
              Left = 254
              Top = 126
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 13
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxStatisticFormPositionByCenter: TCheckBox
              Left = 329
              Top = 128
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 14
              OnClick = chkbxStatisticFormPositionByCenterClick
            end
            object edbxMaintenanceFormPositionX: TEdit
              Left = 167
              Top = 153
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 15
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxMaintenanceFormPositionY: TEdit
              Left = 254
              Top = 153
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 16
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxMaintenanceFormPositionByCenter: TCheckBox
              Left = 329
              Top = 155
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 17
              OnClick = chkbxMaintenanceFormPositionByCenterClick
            end
            object edbxClearingFormPositionX: TEdit
              Left = 167
              Top = 180
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 18
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxClearingFormPositionY: TEdit
              Left = 254
              Top = 180
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 19
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxClearingFormPositionByCenter: TCheckBox
              Left = 329
              Top = 182
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 20
              OnClick = chkbxClearingFormPositionByCenterClick
            end
            object edbxViewPostListFormPositionX: TEdit
              Left = 167
              Top = 207
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 21
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxViewPostListFormPositionY: TEdit
              Left = 254
              Top = 207
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 22
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxViewPostListFormPositionByCenter: TCheckBox
              Left = 329
              Top = 209
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 23
              OnClick = chkbxViewPostListFormPositionByCenterClick
            end
            object edbxCreateViewPostFormPositionX: TEdit
              Left = 167
              Top = 234
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 24
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxCreateViewPostFormPositionY: TEdit
              Left = 254
              Top = 234
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 25
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxCreateViewPostFormPositionByCenter: TCheckBox
              Left = 329
              Top = 236
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 26
              OnClick = chkbxCreateViewPostFormPositionByCenterClick
            end
            object edbxPhonesFormPositionX: TEdit
              Left = 167
              Top = 261
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 27
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxPhonesFormPositionY: TEdit
              Left = 254
              Top = 261
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 28
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxPhonesFormPositionByCenter: TCheckBox
              Left = 329
              Top = 263
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 29
              OnClick = chkbxPhonesFormPositionByCenterClick
            end
            object edbxAddEditPhoneFormPositionX: TEdit
              Left = 167
              Top = 288
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 30
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxAddEditPhoneFormPositionY: TEdit
              Left = 254
              Top = 288
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 31
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxAddEditPhoneFormPositionByCenter: TCheckBox
              Left = 329
              Top = 290
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 32
              OnClick = chkbxAddEditPhoneFormPositionByCenterClick
            end
          end
          object GroupBox3: TGroupBox
            Left = 0
            Top = -110
            Width = 424
            Height = 75
            Align = alTop
            Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1075#1083#1072#1074#1085#1086#1075#1086' '#1086#1082#1085#1072' '
            TabOrder = 0
            object lblMainFormWidth: TLabel
              Left = 155
              Top = 48
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblMainFormHeight: TLabel
              Left = 242
              Top = 48
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblMainFormPosition: TLabel
              Left = 11
              Top = 21
              Width = 42
              Height = 13
              Caption = #1055#1086#1079#1080#1094#1080#1103
            end
            object lblMainFormPositionX: TLabel
              Left = 155
              Top = 21
              Width = 6
              Height = 13
              Caption = 'x'
            end
            object lblMainFormPositionY: TLabel
              Left = 242
              Top = 21
              Width = 6
              Height = 13
              Caption = 'y'
            end
            object lblMainFormSize: TLabel
              Left = 11
              Top = 48
              Width = 43
              Height = 13
              Caption = #1056#1072#1079#1084#1077#1088#1099
            end
            object chkbxStartupFullScreen: TCheckBox
              Left = 329
              Top = 47
              Width = 90
              Height = 17
              Caption = #1085#1072' '#1074#1077#1089#1100' '#1101#1082#1088#1072#1085
              TabOrder = 5
              OnClick = chkbxStartupFullScreenClick
            end
            object edbxMainFormWidth: TEdit
              Left = 167
              Top = 45
              Width = 69
              Height = 21
              TabOrder = 3
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxMainFormHeight: TEdit
              Left = 254
              Top = 45
              Width = 69
              Height = 21
              TabOrder = 4
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxMainFormPositionX: TEdit
              Left = 167
              Top = 18
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 0
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object edbxMainFormPositionY: TEdit
              Left = 254
              Top = 18
              Width = 69
              Height = 21
              Enabled = False
              MaxLength = 4
              TabOrder = 1
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxMainFormPositionByCenter: TCheckBox
              Left = 329
              Top = 20
              Width = 74
              Height = 17
              Caption = #1087#1086' '#1094#1077#1085#1090#1088#1091
              Checked = True
              State = cbChecked
              TabOrder = 2
              OnClick = chkbxMainFormPositionByCenterClick
            end
          end
          object GroupBox2: TGroupBox
            Left = 0
            Top = 224
            Width = 424
            Height = 94
            Align = alTop
            Caption = ' '#1051#1086#1075#1080#1088#1086#1074#1072#1085#1080#1077' '
            TabOrder = 2
            object chkbxStoreLastLogin: TCheckBox
              Left = 11
              Top = 21
              Width = 251
              Height = 17
              Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1083#1086#1075#1080#1085' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
              TabOrder = 0
              OnClick = chkbxStoreLastLoginClick
            end
            object chkbxStoreLastPassword: TCheckBox
              Left = 11
              Top = 44
              Width = 251
              Height = 17
              Caption = #1047#1072#1087#1086#1084#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100' '#1087#1086#1089#1083#1077#1076#1085#1077#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
              Enabled = False
              TabOrder = 1
              OnClick = chkbxStoreLastPasswordClick
            end
            object chkbxAutoLogon: TCheckBox
              Left = 11
              Top = 67
              Width = 358
              Height = 17
              Hint = #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1092#1083#1072#1078#1086#1082' '#1076#1083#1103' '#1072#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1086#1075#1086' '#1083#1086#1075#1080#1088#1086#1074#1072#1085#1080#1103
              Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080' '#1083#1086#1075#1080#1088#1086#1074#1072#1090#1100#1089#1103' '#1087#1086#1076' '#1091#1082#1072#1079#1072#1085#1085#1099#1084' '#1083#1086#1075#1080#1085#1086#1084' '#1080' '#1087#1072#1088#1086#1083#1077#1084
              TabOrder = 2
            end
          end
          object GroupBox4: TGroupBox
            Left = 0
            Top = -35
            Width = 424
            Height = 259
            Align = alTop
            Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1072#1085#1077#1083#1077#1081' '#1075#1083#1072#1074#1085#1086#1075#1086' '#1086#1082#1085#1072' '
            TabOrder = 1
            object lblOrgPanelHalfHeight: TLabel
              Left = 11
              Top = 24
              Width = 143
              Height = 13
              Caption = #1042#1099#1089#1086#1090#1072' '#1087#1072#1085#1077#1083#1080' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
              FocusControl = edbxOrgPanelHeight
            end
            object lblDataPanelHalfWidth: TLabel
              Left = 11
              Top = 51
              Width = 121
              Height = 13
              Caption = #1064#1080#1088#1080#1085#1072' '#1087#1072#1085#1077#1083#1080' '#1076#1072#1085#1085#1099#1093
              FocusControl = edbxDataPanelWidth
            end
            object chkbxNoToolBar: TCheckBox
              Left = 11
              Top = 75
              Width = 296
              Height = 17
              Caption = #1053#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1082#1085#1086#1087#1086#1082' '#1087#1088#1080' '#1089#1090#1072#1088#1090#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
              TabOrder = 4
            end
            object chkbxNoStatusBar: TCheckBox
              Left = 11
              Top = 98
              Width = 306
              Height = 17
              Caption = #1053#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1089#1090#1072#1090#1091#1089#1072' '#1087#1088#1080' '#1089#1090#1072#1088#1090#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
              TabOrder = 5
            end
            object edbxOrgPanelHeight: TEdit
              Left = 167
              Top = 21
              Width = 69
              Height = 21
              TabOrder = 0
              OnChange = edbxOrgPanelHeightChange
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxOrgPanelHalfHeight: TCheckBox
              Left = 254
              Top = 23
              Width = 151
              Height = 17
              Caption = #1087#1086#1083#1086#1074#1080#1085#1072' '#1074#1099#1089#1086#1090#1099' '#1086#1082#1085#1072
              TabOrder = 1
              OnClick = chkbxOrgPanelHalfHeightClick
            end
            object edbxDataPanelWidth: TEdit
              Left = 167
              Top = 48
              Width = 69
              Height = 21
              TabOrder = 2
              OnChange = edbxDataPanelWidthChange
              OnKeyPress = edbxMainFormWidthKeyPress
            end
            object chkbxDataPanelHalfWidth: TCheckBox
              Left = 254
              Top = 50
              Width = 151
              Height = 17
              Caption = #1087#1086#1083#1086#1074#1080#1085#1072' '#1096#1080#1088#1080#1085#1099' '#1086#1082#1085#1072
              TabOrder = 3
              OnClick = chkbxDataPanelHalfWidthClick
            end
            object chkbxShowDataInOtherInfoPanel: TCheckBox
              Left = 11
              Top = 121
              Width = 382
              Height = 17
              Caption = #1042' '#1088#1077#1078#1080#1084#1077' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1074' '#1086#1082#1085#1077' '#1087#1088#1086#1095#1077#1081' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080
              TabOrder = 6
            end
            object chkbxMarkSearchedStrings: TCheckBox
              Left = 11
              Top = 167
              Width = 330
              Height = 17
              Caption = #1042' '#1088#1077#1078#1080#1084#1077' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1074#1099#1076#1077#1083#1103#1090#1100' '#1080#1089#1082#1086#1084#1099#1077' '#1092#1088#1072#1075#1084#1077#1085#1090#1099' '#1089#1090#1088#1086#1082' '
              TabOrder = 8
            end
            object chkbxPutTownAtTheEnd: TCheckBox
              Left = 11
              Top = 190
              Width = 330
              Height = 17
              Caption = #1055#1086#1084#1077#1089#1090#1080#1090#1100' '#1085#1072#1079#1074#1072#1085#1080#1077' '#1075#1086#1088#1086#1076#1072' '#1074' '#1082#1086#1085#1077#1094' '#1089#1090#1088#1086#1082#1080' '#1072#1076#1088#1077#1089#1072
              TabOrder = 9
            end
            object chkbxHideEditBoxToolTips: TCheckBox
              Left = 11
              Top = 213
              Width = 382
              Height = 17
              Caption = #1053#1077' '#1087#1086#1082#1072#1079#1099#1074#1072#1090#1100' '#1074#1089#1087#1083#1099#1074#1072#1102#1097#1080#1077' '#1087#1086#1076#1089#1082#1072#1079#1082#1080' '#1076#1083#1103' '#1087#1086#1083#1077#1081' '#1074#1074#1086#1076#1072
              TabOrder = 10
            end
            object chkbxShowSearchAddressOtherEditBox: TCheckBox
              Left = 11
              Top = 236
              Width = 398
              Height = 17
              Caption = 
                #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1087#1086#1083#1103' '#1074#1074#1086#1076#1072' '#1076#1083#1103' '#1072#1076#1088#1077#1089#1085#1086#1081' '#1080' "'#1087#1088#1086#1095#1077#1081'" '#1095#1072#1089#1090#1080' '#1089#1090#1088#1086#1082' '#1079#1072#1087#1088#1086#1089 +
                #1086#1074
              TabOrder = 11
            end
            object chkbxShowMeasuresListAsRichEdit: TCheckBox
              Left = 11
              Top = 144
              Width = 382
              Height = 17
              Caption = #1042' '#1088#1077#1078#1080#1084#1077' '#1087#1088#1086#1089#1084#1086#1090#1088#1072' '#1086#1073#1098#1077#1076#1080#1085#1103#1090#1100' '#1084#1077#1088#1086#1087#1088#1103#1090#1080#1103' '#1074' '#1086#1073#1097#1080#1081' '#1089#1087#1080'c'#1086#1082
              TabOrder = 7
            end
          end
        end
      end
      object TabSheet2: TTabSheet
        Caption = #1057#1077#1088#1074#1077#1088' '#1080' '#1073#1072#1079#1072' '#1076#1072#1085#1085#1099#1093
        ImageIndex = 1
        TabVisible = False
        object Label1: TLabel
          Left = 0
          Top = 6
          Width = 41
          Height = 13
          Caption = #1057#1077#1088#1074#1077#1088':'
          FocusControl = edbxMySQLHost
        end
        object Label2: TLabel
          Left = 0
          Top = 33
          Width = 29
          Height = 13
          Caption = #1055#1086#1088#1090':'
          FocusControl = edbxMySQLPort
        end
        object Label3: TLabel
          Left = 0
          Top = 60
          Width = 88
          Height = 13
          Caption = #1042#1088#1077#1084#1103' '#1086#1078#1080#1076#1072#1085#1080#1103':'
          FocusControl = edbxMySQLTimeout
        end
        object Label5: TLabel
          Left = 224
          Top = 60
          Width = 41
          Height = 13
          Caption = #1055#1072#1088#1086#1083#1100':'
          FocusControl = edbxMySQLPassword
        end
        object Label4: TLabel
          Left = 224
          Top = 33
          Width = 76
          Height = 13
          Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
          FocusControl = edbxMySQLUser
        end
        object Label6: TLabel
          Left = 224
          Top = 6
          Width = 69
          Height = 13
          Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093':'
          FocusControl = edbxMySQLDatabase
        end
        object edbxMySQLHost: TEdit
          Left = 97
          Top = 3
          Width = 120
          Height = 21
          TabOrder = 0
          Text = 'RNE4SERVER'
        end
        object edbxMySQLPort: TEdit
          Left = 97
          Top = 30
          Width = 120
          Height = 21
          TabOrder = 1
          Text = '3306'
        end
        object edbxMySQLTimeout: TEdit
          Left = 97
          Top = 57
          Width = 120
          Height = 21
          TabOrder = 2
          Text = '30'
        end
        object chkbxMySQLCompress: TCheckBox
          Left = 0
          Top = 84
          Width = 94
          Height = 17
          Caption = #1057#1078#1072#1090#1080#1077
          Checked = True
          State = cbChecked
          TabOrder = 3
        end
        object edbxMySQLDatabase: TEdit
          Left = 321
          Top = 3
          Width = 120
          Height = 21
          TabOrder = 4
          Text = 'rne4'
        end
        object edbxMySQLUser: TEdit
          Left = 321
          Top = 30
          Width = 120
          Height = 21
          TabOrder = 5
          Text = 'rne4'
        end
        object edbxMySQLPassword: TEdit
          Left = 321
          Top = 57
          Width = 120
          Height = 21
          PasswordChar = '*'
          TabOrder = 6
          Text = 'rne4admin'
        end
      end
      object TabSheet3: TTabSheet
        Caption = #1057#1087#1080#1089#1086#1082' '#1072#1074#1090#1086#1079#1072#1084#1077#1085#1099
        ImageIndex = 2
        TabVisible = False
        object lblAutoReplaceSorry: TLabel
          Left = 0
          Top = 0
          Width = 441
          Height = 203
          Align = alClient
          Alignment = taCenter
          Layout = tlCenter
          ExplicitWidth = 3
          ExplicitHeight = 13
        end
        object sgAutoReplaceList: TStringGrid
          Left = 0
          Top = 0
          Width = 441
          Height = 203
          Hint = #1057#1087#1080#1089#1086#1082' '#1089#1090#1088#1086#1082' '#1076#1083#1103' '#1072#1074#1090#1086#1079#1072#1084#1077#1085#1099
          Align = alClient
          ColCount = 3
          Ctl3D = True
          DefaultColWidth = 200
          DefaultRowHeight = 19
          RowCount = 1001
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goRowMoving, goEditing]
          ParentCtl3D = False
          TabOrder = 0
          Visible = False
          ColWidths = (
            14
            201
            202)
        end
      end
      object TabSheet4: TTabSheet
        Caption = #1055#1088#1086#1095#1077#1077
        ImageIndex = 3
        TabVisible = False
        object chkbxNoLogo: TCheckBox
          Left = 3
          Top = 3
          Width = 281
          Height = 17
          Caption = #1053#1077' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1086#1082#1085#1086' "'#1054' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'..." '#1087#1088#1080' '#1079#1072#1087#1091#1089#1082#1077
          TabOrder = 0
        end
        object chkbxShowID: TCheckBox
          Left = 3
          Top = 26
          Width = 336
          Height = 17
          Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' ID '#1079#1072#1087#1080#1089#1077#1081' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093' '#1087#1088#1080' '#1088#1072#1073#1086#1090#1077' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
          TabOrder = 1
        end
        object chkbxCustomHelpFile: TCheckBox
          Left = 3
          Top = 49
          Width = 176
          Height = 17
          Caption = #1057#1090#1086#1088#1086#1085#1085#1080#1081' '#1089#1087#1088#1072#1074#1086#1095#1085#1099#1081' '#1092#1072#1081#1083
          TabOrder = 2
          OnClick = chkbxCustomHelpFileClick
        end
        object edbxCustomHelpFile: TEdit
          Left = 185
          Top = 47
          Width = 226
          Height = 21
          Enabled = False
          TabOrder = 3
        end
        object btnChoiseCustomHelpFile: TButton
          Left = 417
          Top = 47
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 4
          OnClick = btnChoiseCustomHelpFileClick
        end
        object CheckBox1: TCheckBox
          Left = 3
          Top = 72
          Width = 310
          Height = 17
          Caption = #1053#1077' '#1090#1088#1077#1073#1086#1074#1072#1090#1100' '#1087#1086#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1103' '#1087#1088#1080' '#1074#1099#1093#1086#1076#1077#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
          TabOrder = 5
          Visible = False
        end
      end
      object TabSheet5: TTabSheet
        Caption = #1051#1086#1075'-'#1082#1083#1080#1077#1085#1090
        ImageIndex = 4
        TabVisible = False
        object chkbxCustomLogClientFile: TCheckBox
          Left = 0
          Top = 26
          Width = 110
          Height = 17
          Caption = #1059#1082#1072#1079#1072#1085#1085#1099#1081' '#1092#1072#1081#1083
          TabOrder = 1
          OnClick = chkbxCustomLogClientFileClick
        end
        object edbxCustomLogClientFile: TEdit
          Left = 116
          Top = 24
          Width = 295
          Height = 21
          Enabled = False
          TabOrder = 2
        end
        object btnChoiseCustomLogClientFile: TButton
          Left = 417
          Top = 24
          Width = 21
          Height = 21
          Caption = '...'
          TabOrder = 3
          OnClick = btnChoiseCustomLogClientFileClick
        end
        object chkbxUseLog: TCheckBox
          Left = 0
          Top = 3
          Width = 142
          Height = 17
          Caption = #1042#1077#1089#1090#1080' '#1083#1086#1075' '#1088#1072#1073#1086#1090#1099' '#1040#1056#1052
          TabOrder = 0
        end
      end
      object TabSheet6: TTabSheet
        Caption = #1051#1086#1075'-'#1089#1077#1088#1074#1077#1088
        ImageIndex = 5
        TabVisible = False
      end
    end
  end
end
