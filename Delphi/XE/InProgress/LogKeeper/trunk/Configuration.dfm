object ConfigurationForm: TConfigurationForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
  ClientHeight = 239
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 202
    Width = 594
    Height = 37
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkTile
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 0
    object btnApply: TButton
      Left = 334
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1088#1080#1084#1077#1085#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1074' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1080 +
        ' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      Default = True
      ModalResult = 1
      TabOrder = 1
    end
    object btnClose: TButton
      Left = 421
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1089#1077#1093' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1074' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1080' '#1079#1072#1082 +
        #1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      ModalResult = 2
      TabOrder = 2
    end
    object btnHelp: TButton
      Left = 508
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      TabOrder = 3
    end
    object btnDefaults: TButton
      Left = 5
      Top = 5
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1073#1088#1086#1089#1072' '#1074#1089#1077#1093' '#1085#1072#1089#1090#1088#1086#1077#1082' '#1082' '#1079#1085#1072#1095#1077#1085#1080#1103#1084' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
      Caption = '&'#1057#1073#1088#1086#1089
      TabOrder = 0
      OnClick = btnDefaultsClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 55
    Align = alTop
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 1
    object gbHeader: TGroupBox
      Left = 5
      Top = 5
      Width = 584
      Height = 45
      Align = alClient
      Caption = ' '#1053#1072#1089#1090#1088#1086#1081#1082#1080': '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object cbPage: TComboBox
        Left = 10
        Top = 15
        Width = 510
        Height = 21
        Style = csDropDownList
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
        OnSelect = cbPageSelect
        Items.Strings = (
          ' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1072
          ' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1082' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093' MySQL'
          ' '#1074#1077#1076#1077#1085#1080#1103' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' '#1088#1072#1073#1086#1090#1099)
      end
      object btnNextPage: TButton
        Left = 554
        Top = 15
        Width = 22
        Height = 22
        Cursor = crHandPoint
        Action = Action_NextPage
        Images = MainForm.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
      end
      object btnPreviousPage: TButton
        Left = 526
        Top = 15
        Width = 22
        Height = 22
        Cursor = crHandPoint
        Action = Action_PreviousPage
        Images = MainForm.ImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 55
    Width = 594
    Height = 147
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 2
    object gbPage: TGroupBox
      Left = 5
      Top = 5
      Width = 584
      Height = 137
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object PageControl1: TPageControl
        Left = 10
        Top = 5
        Width = 566
        Height = 130
        ActivePage = TabSheet1
        Align = alCustom
        Style = tsButtons
        TabOrder = 0
        TabStop = False
        object TabSheet1: TTabSheet
          Caption = ' '#1080#1085#1090#1077#1088#1092#1077#1081#1089#1072
          TabVisible = False
          object lblOrgPanelHalfHeight: TLabel
            Left = 0
            Top = 51
            Width = 117
            Height = 13
            Caption = #1042#1099#1089#1086#1090#1072' '#1075#1083#1072#1074#1085#1086#1075#1086' '#1086#1082#1085#1072':'
            FocusControl = edbxMainFormHeight
          end
          object Label1: TLabel
            Left = 0
            Top = 78
            Width = 137
            Height = 13
            Caption = #1055#1086#1083#1086#1078#1077#1085#1080#1077' '#1075#1083#1072#1074#1085#1086#1075#1086' '#1086#1082#1085#1072':'
            FocusControl = edbxMainFormHeight
          end
          object edbxMainFormHeight: TEdit
            Left = 143
            Top = 48
            Width = 63
            Height = 21
            TabOrder = 4
            Text = '200'
            OnKeyPress = edbxMainFormHeightKeyPress
          end
          object chkbxFullScreen: TCheckBox
            Left = 285
            Top = 50
            Width = 273
            Height = 17
            Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1075#1083#1072#1074#1085#1086#1077' '#1086#1082#1085#1086' '#1074#1086' '#1074#1077#1089#1100' '#1101#1082#1088#1072#1085
            TabOrder = 5
            OnClick = chkbxFullScreenClick
          end
          object chkbxCustomHelpFile: TCheckBox
            Left = 0
            Top = 25
            Width = 279
            Height = 17
            Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' c'#1090#1086#1088#1086#1085#1085#1080#1081' '#1089#1087#1088#1072#1074#1086#1095#1085#1099#1081' '#1092#1072#1081#1083
            TabOrder = 1
            OnClick = chkbxCustomHelpFileClick
          end
          object edbxCustomHelpFile: TEdit
            Left = 285
            Top = 23
            Width = 246
            Height = 21
            Enabled = False
            TabOrder = 2
          end
          object btnChoiseCustomHelpFile: TButton
            Left = 537
            Top = 21
            Width = 21
            Height = 21
            Caption = '...'
            TabOrder = 3
            OnClick = btnChoiseCustomHelpFileClick
          end
          object cbMainFormAlignment: TComboBox
            Left = 143
            Top = 75
            Width = 63
            Height = 21
            Style = csDropDownList
            ItemIndex = 1
            TabOrder = 6
            Text = #1074#1085#1080#1079#1091
            Items.Strings = (
              #1074#1074#1077#1088#1093#1091
              #1074#1085#1080#1079#1091)
          end
          object chkbxAlwaysShowTrayIcon: TCheckBox
            Left = 0
            Top = 0
            Width = 273
            Height = 17
            Caption = #1042#1089#1077#1075#1076#1072' '#1086#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1080#1082#1086#1085#1082#1091' '#1074' '#1090#1088#1077#1077
            TabOrder = 0
          end
        end
        object TabSheet2: TTabSheet
          Caption = ' '#1087#1072#1088#1072#1084#1077#1090#1088#1086#1074' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103' '#1082' '#1073#1072#1079#1077' '#1076#1072#1085#1085#1099#1093' MySQL'
          ImageIndex = 1
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object lblMySQLHost: TLabel
            Left = 0
            Top = 3
            Width = 41
            Height = 13
            Caption = #1057#1077#1088#1074#1077#1088':'
            FocusControl = edbxMySQLHost
          end
          object lblMySQLPort: TLabel
            Left = 0
            Top = 30
            Width = 29
            Height = 13
            Caption = #1055#1086#1088#1090':'
            FocusControl = edbxMySQLPort
          end
          object lblMySQLTimeout: TLabel
            Left = 0
            Top = 57
            Width = 88
            Height = 13
            Caption = #1042#1088#1077#1084#1103' '#1086#1078#1080#1076#1072#1085#1080#1103':'
            FocusControl = edbxMySQLTimeout
          end
          object lblMySQLPassword: TLabel
            Left = 285
            Top = 57
            Width = 41
            Height = 13
            Caption = #1055#1072#1088#1086#1083#1100':'
            FocusControl = edbxMySQLPassword
          end
          object lblMySQLUser: TLabel
            Left = 285
            Top = 32
            Width = 76
            Height = 13
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100':'
            FocusControl = edbxMySQLUser
          end
          object lblMySQLDatabase: TLabel
            Left = 285
            Top = 3
            Width = 69
            Height = 13
            Caption = #1041#1072#1079#1072' '#1076#1072#1085#1085#1099#1093':'
            FocusControl = edbxMySQLDatabase
          end
          object edbxMySQLHost: TEdit
            Left = 103
            Top = 0
            Width = 170
            Height = 21
            TabOrder = 0
            Text = 'LOGKEEPERSERVER'
          end
          object edbxMySQLPort: TEdit
            Left = 103
            Top = 27
            Width = 170
            Height = 21
            TabOrder = 1
            Text = '3306'
          end
          object edbxMySQLTimeout: TEdit
            Left = 103
            Top = 54
            Width = 170
            Height = 21
            TabOrder = 2
            Text = '30'
          end
          object chkbxMySQLCompress: TCheckBox
            Left = 0
            Top = 81
            Width = 273
            Height = 17
            Caption = #1057#1078#1072#1090#1080#1077' '#1076#1072#1085#1085#1099#1093
            Checked = True
            State = cbChecked
            TabOrder = 3
          end
          object edbxMySQLDatabase: TEdit
            Left = 388
            Top = 0
            Width = 170
            Height = 21
            TabOrder = 4
            Text = 'LogKeeper'
          end
          object edbxMySQLUser: TEdit
            Left = 388
            Top = 27
            Width = 170
            Height = 21
            TabOrder = 5
            Text = 'LogKeeper'
          end
          object edbxMySQLPassword: TEdit
            Left = 388
            Top = 54
            Width = 170
            Height = 21
            PasswordChar = '*'
            TabOrder = 6
            Text = 'LogKeeperAdmin'
          end
        end
        object TabSheet3: TTabSheet
          Caption = ' '#1074#1077#1076#1077#1085#1080#1103' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' '#1088#1072#1073#1086#1090#1099
          ImageIndex = 2
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Label2: TLabel
            Left = 285
            Top = 0
            Width = 254
            Height = 13
            Caption = #1057#1073#1088#1072#1089#1099#1074#1072#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083' '#1088#1072#1073#1086#1090#1099' '#1074' '#1090#1077#1082#1089#1090#1086#1074#1099#1081' '#1092#1072#1081#1083':'
          end
          object Bevel1: TBevel
            Left = 0
            Top = 19
            Width = 273
            Height = 99
            Shape = bsFrame
          end
          object Label3: TLabel
            Left = 0
            Top = 0
            Width = 152
            Height = 13
            Caption = #1042#1077#1089#1090#1080' '#1083#1086#1075' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099':'
          end
          object Bevel2: TBevel
            Left = 285
            Top = 19
            Width = 273
            Height = 99
            Shape = bsFrame
          end
          object chkbxKeepInfoLog: TCheckBox
            Left = 9
            Top = 25
            Width = 257
            Height = 17
            Caption = #1074#1099#1074#1086#1076#1080#1090#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1086#1085#1085#1099#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
            TabOrder = 0
          end
          object chkbxKeepWarningLog: TCheckBox
            Left = 9
            Top = 48
            Width = 257
            Height = 17
            Caption = #1074#1099#1074#1086#1076#1080#1090#1100' '#1074#1072#1078#1085#1099#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
            TabOrder = 1
          end
          object chkbxKeepErrorLog: TCheckBox
            Left = 9
            Top = 71
            Width = 257
            Height = 17
            Caption = #1074#1099#1074#1086#1076#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1086#1073' '#1086#1096#1080#1073#1082#1072#1093
            TabOrder = 2
          end
          object chkbxKeepSQLLog: TCheckBox
            Left = 9
            Top = 94
            Width = 257
            Height = 17
            Caption = #1074#1099#1074#1086#1076#1080#1090#1100' '#1090#1077#1082#1089#1090' SQL-'#1079#1072#1087#1088#1086#1089#1086#1074
            TabOrder = 3
          end
          object chkbxFlushLogOnStringsQuantity: TCheckBox
            Left = 294
            Top = 48
            Width = 195
            Height = 17
            Caption = #1087#1088#1080' '#1076#1086#1089#1090#1080#1078#1077#1085#1080#1080' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1072' '#1089#1090#1088#1086#1082
            TabOrder = 5
            OnClick = chkbxFlushLogOnStringsQuantityClick
          end
          object chkbxFlushLogOnExit: TCheckBox
            Left = 294
            Top = 25
            Width = 257
            Height = 17
            Caption = #1087#1088#1080' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1080' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
            TabOrder = 4
          end
          object edbxFlushLogOnStringsQuantity: TEdit
            Left = 495
            Top = 48
            Width = 56
            Height = 21
            TabOrder = 6
            Text = '10000'
            OnKeyPress = edbxFlushLogOnStringsQuantityKeyPress
          end
          object chkbxFlushLogOnClearingLog: TCheckBox
            Left = 294
            Top = 71
            Width = 257
            Height = 17
            Caption = #1087#1088#1080' '#1086#1087#1077#1088#1072#1094#1080#1080' '#1086#1095#1080#1089#1090#1082#1080' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
            TabOrder = 7
          end
          object chkbxFlushLogOnApply: TCheckBox
            Left = 294
            Top = 94
            Width = 257
            Height = 17
            Caption = #1087#1088#1080' '#1085#1072#1078#1072#1090#1080#1080' '#1082#1085#1086#1087#1082#1080' "'#1055#1088#1080#1084#1077#1085#1080#1090#1100'"'
            TabOrder = 8
          end
        end
      end
    end
  end
  object ActionManager1: TActionManager
    Images = MainForm.ImageList1
    Left = 160
    Top = 208
    StyleName = 'Platform Default'
    object Action_PreviousPage: TAction
      Hint = 
        #1055#1088#1077#1076#1099#1076#1091#1097#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1081' '#1089#1090#1088#1072#1085#1080#1094#1099' ' +
        #1085#1072#1089#1090#1088#1086#1077#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 25
      OnExecute = Action_PreviousPageExecute
    end
    object Action_NextPage: TAction
      Hint = 
        #1057#1083#1077#1076#1091#1102#1097#1072#1103' '#1089#1090#1088#1072#1085#1080#1094#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1089#1083#1077#1076#1091#1102#1097#1077#1081' '#1089#1090#1088#1072#1085#1080#1094#1099' '#1085#1072 +
        #1089#1090#1088#1086#1077#1082' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 24
      OnExecute = Action_NextPageExecute
    end
  end
end
