object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Overseer'
  ClientHeight = 552
  ClientWidth = 794
  Color = clBtnFace
  Constraints.MaxHeight = 600
  Constraints.MaxWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 2
    Top = 534
    Width = 16
    Height = 16
    Hint = #1048#1085#1076#1080#1082#1072#1090#1086#1088' '#1075#1086#1090#1086#1074#1085#1086#1089#1090#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '
    AutoSize = True
    Constraints.MaxHeight = 16
    Constraints.MaxWidth = 16
    Constraints.MinHeight = 16
    Constraints.MinWidth = 16
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 532
    Width = 794
    Height = 20
    Hint = #1055#1072#1085#1077#1083#1100' '#1089#1090#1072#1090#1091#1089#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
    Panels = <
      item
        Width = 20
      end
      item
        Width = 100
      end
      item
        Width = 674
      end>
  end
  object pbMain: TProgressBar
    Left = 21
    Top = 534
    Width = 98
    Height = 18
    Hint = #1048#1085#1076#1080#1082#1072#1090#1086#1088' '#1087#1088#1086#1075#1088#1077#1089#1089#1072' '#1074#1099#1087#1086#1083#1085#1103#1077#1084#1086#1081' '#1086#1087#1077#1088#1072#1094#1080#1080
    Constraints.MaxHeight = 18
    Constraints.MaxWidth = 98
    Constraints.MinHeight = 18
    Constraints.MinWidth = 98
    Step = 1
    TabOrder = 0
  end
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 794
    Height = 532
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object pnlLog: TPanel
      Left = 0
      Top = 380
      Width = 794
      Height = 152
      Hint = #1055#1072#1085#1077#1083#1100' '#1083#1086#1075#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      Align = alBottom
      BevelOuter = bvNone
      BorderWidth = 4
      TabOrder = 0
      object GroupBox7: TGroupBox
        Left = 4
        Top = 4
        Width = 786
        Height = 144
        Align = alClient
        Caption = ' '#1055#1072#1085#1077#1083#1100' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '
        TabOrder = 0
        DesignSize = (
          786
          144)
        object Panel5: TPanel
          Left = 751
          Top = 15
          Width = 33
          Height = 127
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object btnMaximazeLogPanel: TButton
            Left = 6
            Top = 0
            Width = 22
            Height = 22
            Cursor = crHandPoint
            Hint = 
              #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1087#1072#1085#1077#1083#1100'|'#1053#1072#1078#1080#1090#1077' '#1076#1083#1103' '#1088#1072#1079#1074#1086#1088#1072#1095#1080#1074#1072#1085#1080#1103' '#1087#1072#1085#1077#1083#1080' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' '#1088#1072#1073 +
              #1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099' '#1085#1072' '#1074#1089#1105' '#1086#1082#1085#1086
            ImageIndex = 17
            Images = ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = Action_MaximizeLogPanelExecute
          end
          object btnRestoreLogPanel: TButton
            Left = 6
            Top = 28
            Width = 22
            Height = 22
            Cursor = crHandPoint
            Hint = 
              #1057#1074#1077#1088#1085#1091#1090#1100' '#1087#1072#1085#1077#1083#1100'|'#1053#1072#1078#1080#1090#1077' '#1076#1083#1103' '#1074#1086#1079#1074#1088#1072#1097#1077#1085#1080#1103' '#1087#1072#1085#1077#1083#1080' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' '#1088#1072#1073#1086#1090#1099' '#1087 +
              #1088#1086#1075#1088#1072#1084#1084#1099' '#1082' '#1085#1086#1088#1084#1072#1083#1100#1085#1099#1084' '#1088#1072#1079#1084#1077#1088#1072#1084
            Enabled = False
            ImageIndex = 16
            Images = ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = Action_RestoreLogPanelExecute
          end
        end
        object PageControl2: TPageControl
          Left = 8
          Top = 15
          Width = 743
          Height = 128
          ActivePage = tsLog
          Align = alCustom
          Anchors = [akLeft, akTop, akRight, akBottom]
          HotTrack = True
          MultiLine = True
          TabOrder = 1
          TabPosition = tpBottom
          object tsLog: TTabSheet
            Caption = #1055#1088#1086#1090#1086#1082#1086#1083' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvLog: TListView
              Left = 0
              Top = 0
              Width = 733
              Height = 99
              Cursor = crHandPoint
              Align = alCustom
              Anchors = [akLeft, akTop, akRight, akBottom]
              Columns = <
                item
                  Width = 130
                end
                item
                  Width = 240
                end
                item
                  Width = 0
                end
                item
                  Width = 0
                end
                item
                  Width = -2
                  WidthType = (
                    -2)
                end>
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ReadOnly = True
              RowSelect = True
              ParentFont = False
              PopupMenu = pmLog
              ShowColumnHeaders = False
              SmallImages = ImageList1
              SortType = stBoth
              TabOrder = 0
              ViewStyle = vsReport
              OnCustomDrawItem = lvLogCustomDrawItem
              OnCustomDrawSubItem = lvLogCustomDrawSubItem
              OnKeyDown = lvLogKeyDown
            end
          end
          object tsActions: TTabSheet
            Caption = #1055#1088#1086#1075#1088#1077#1089#1089' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1076#1077#1081#1089#1090#1074#1080#1081
            ImageIndex = 1
            ExplicitLeft = 0
            ExplicitTop = 0
            ExplicitWidth = 0
            ExplicitHeight = 0
            object lvActionList: TListViewEx
              Left = 0
              Top = 0
              Width = 733
              Height = 99
              Cursor = crHandPoint
              Align = alCustom
              Anchors = [akLeft, akTop, akRight, akBottom]
              Columns = <
                item
                  Caption = '*'
                  MaxWidth = 20
                  MinWidth = 20
                  Width = 20
                end
                item
                  Caption = #1055#1088#1086#1075#1088#1077#1089#1089' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103
                  Width = 125
                end
                item
                  Alignment = taCenter
                  Caption = #1044#1072#1090#1072'/'#1074#1088#1077#1084#1103' '#1079#1072#1087#1091#1089#1082#1072
                  Width = 120
                end
                item
                  Alignment = taRightJustify
                  Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100', '#1084#1089
                  Width = -2
                  WidthType = (
                    -2)
                end
                item
                  AutoSize = True
                  Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1076#1077#1081#1089#1090#1074#1080#1103
                end>
              ColumnClick = False
              GridLines = True
              ReadOnly = True
              RowSelect = True
              PopupMenu = pm_ProcessedActions
              SmallImages = ilActionList
              TabOrder = 0
              ViewStyle = vsReport
              OnInsert = lvActionListInsert
              OnResize = lvActionListResize
              OnEndColumnResize = lvActionListEndColumnResize
              OnDividerDblClick = lvActionListDividerDblClick
              OnScroll = lvActionListScroll
              OnMouseWheel = lvActionListMouseWheel
            end
          end
        end
        object chkbxScrollToLastLogMessage: TCheckBox
          Left = 620
          Top = 124
          Width = 125
          Height = 17
          Hint = 
            #1042#1082#1083#1102#1095#1080#1090#1100'/'#1074#1099#1082#1083#1102#1095#1080#1090#1100' '#1087#1088#1086#1082#1088#1091#1090#1082#1091' '#1089#1087#1080#1089#1082#1072' '#1087#1088#1086#1090#1086#1082#1086#1083#1072' '#1082' '#1087#1086#1089#1083#1077#1076#1085#1077#1084#1091' '#1076#1086#1073#1072#1074 +
            #1083#1077#1085#1085#1086#1084#1091' '#1089#1086#1086#1073#1097#1077#1085#1080#1102
          Anchors = [akLeft, akBottom]
          Caption = #1087#1088#1086#1082#1088#1091#1090#1082#1072' '#1074#1085#1080#1079
          TabOrder = 2
          OnClick = chkbxScrollToLastLogMessageClick
        end
      end
    end
    object pnlConnectedMode: TPanel
      Left = 0
      Top = 0
      Width = 794
      Height = 380
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      Visible = False
      object PageControl1: TPageControl
        Left = 345
        Top = 44
        Width = 449
        Height = 296
        ActivePage = ts_SIC_09
        Align = alCustom
        Style = tsButtons
        TabOrder = 3
        TabStop = False
        object ts_SIC_01: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-01-...'
          ImageIndex = 7
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_SIC_01: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 4. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lb_SIC_01: TLabel
              Left = 8
              Top = 16
              Width = 147
              Height = 13
              Caption = #1059#1082#1072#1078#1080#1090#1077' '#1085#1086#1084#1077#1088#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object btnAdd_SIC_01: TButton
              Left = 359
              Top = 30
              Width = 75
              Height = 25
              Cursor = crHandPoint
              Action = Action_AddPhones_SIC_01
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object btnDelete_SIC_01: TButton
              Left = 359
              Top = 61
              Width = 75
              Height = 25
              Cursor = crHandPoint
              Action = Action_DeletePhone_SIC_01
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
            end
            object btnClear_SIC_01: TButton
              Left = 359
              Top = 92
              Width = 75
              Height = 25
              Cursor = crHandPoint
              Action = Action_ClearPhones_SIC_01
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
            end
            object eb_SIC_01: TEdit
              Left = 8
              Top = 32
              Width = 345
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074' '#1073#1077#1079' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1077#1081' '#1095#1077#1088#1077#1079' '#1087#1088#1086#1073#1077#1083'...'
              OnChange = eb_SIC_01Change
            end
            object lv_SIC_01: TListView
              Left = 8
              Top = 61
              Width = 345
              Height = 192
              Hint = #1057#1087#1080#1089#1086#1082' '#1085#1086#1084#1077#1088#1086#1074' '#1090#1077#1083#1077#1092#1086#1085#1086#1074', '#1080#1089#1087#1086#1083#1100#1079#1091#1077#1084#1099#1093' '#1087#1088#1080' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1080' '#1086#1090#1095#1105#1090#1072
              Columns = <
                item
                  Width = 0
                end
                item
                  Alignment = taRightJustify
                  Caption = #8470' '#1087'/'#1087
                  Width = -2
                  WidthType = (
                    -2)
                end
                item
                  Caption = #1053#1086#1084#1077#1088' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1072#1073#1086#1085#1077#1085#1090#1072' ('#1085#1086#1084#1077#1088' '#1040')'
                  Width = -2
                  WidthType = (
                    -2)
                end>
              ColumnClick = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              GridLines = True
              HideSelection = False
              ReadOnly = True
              RowSelect = True
              ParentFont = False
              TabOrder = 2
              ViewStyle = vsReport
              OnSelectItem = lv_SIC_01SelectItem
            end
            object cbShowUnserved_SIC_01: TCheckBox
              Left = 8
              Top = 259
              Width = 426
              Height = 17
              Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1074#1099#1079#1086#1074#1099', '#1085#1077' '#1087#1086#1083#1091#1095#1080#1074#1096#1080#1077' '#1086#1090#1074#1077#1090#1072' '#1057#1058'-'#1087#1083#1072#1090#1092#1086#1088#1084#1099
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
            end
          end
        end
        object ts_SIC_02: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-02-...'
          ImageIndex = 1
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_SIC_02: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 4. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object rbDetailedReport_SIC_02: TRadioButton
              Left = 8
              Top = 16
              Width = 426
              Height = 17
              Caption = #1087#1086#1076#1088#1086#1073#1085#1099#1081' '#1086#1090#1095#1105#1090' - '#1092#1086#1088#1084#1072' '#8470' '#1057#1048#1062'-02-1-...'
              Checked = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              TabStop = True
            end
            object rbSortedReport_SIC_02: TRadioButton
              Left = 8
              Top = 39
              Width = 426
              Height = 17
              Caption = #1086#1090#1095#1105#1090' '#1089' '#1089#1086#1088#1090#1080#1088#1086#1074#1082#1086#1081' '#1080' '#1080#1090#1086#1075#1072#1084#1080' '#1087#1086' '#1060'.'#1048'.'#1054'. - '#1092#1086#1088#1084#1072' '#8470' '#1057#1048#1062'-02-2-...'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
          end
        end
        object ts_SIC_03: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-03-...'
          ImageIndex = 4
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_SIC_03: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 3. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lbPhoneNet_SIC_03: TLabel
              Left = 8
              Top = 16
              Width = 92
              Height = 13
              Caption = #1058#1077#1083#1077#1092#1086#1085#1085#1072#1103' '#1089#1077#1090#1100':'
              FocusControl = cbPhoneNet_SIC_03
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object cbPhoneNet_SIC_03: TComboBox
              Left = 8
              Top = 35
              Width = 426
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Items.Strings = (
                
                  #1052#1062#1057' (80291xxxxxx, 80293xxxxxx, 80296xxxxxx, 80299xxxxxx, 8044xxx' +
                  'xxxx)'
                
                  #1052#1058#1057' (80292xxxxxx, 80295xxxxxx, 80297xxxxxx, 80298xxxxxx, 8033xxx' +
                  'xxxx)'
                #1041#1077#1057#1058' (80255xxxxxx, 80256xxxxxx, 80257xxxxxx, 80259xxxxxx)'
                #1041#1077#1083#1057#1077#1083' (80294xxxxxx)')
            end
          end
        end
        object ts_SIC_04: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-04-...'
          ImageIndex = 8
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_SIC_04: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 4. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object rbAllUsers_SIC_04: TRadioButton
              Left = 8
              Top = 16
              Width = 426
              Height = 17
              Caption = #1087#1086' '#1074#1089#1077#1084' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#1084
              Checked = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              TabStop = True
              OnClick = rbUsers_SIC_04Click
            end
            object rbSelectedUsers_SIC_04: TRadioButton
              Left = 8
              Top = 39
              Width = 258
              Height = 17
              Caption = #1087#1086' '#1091#1082#1072#1079#1072#1085#1085#1099#1084' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#1084
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnClick = rbUsers_SIC_04Click
            end
            object btnRefreshUserList_SIC_04: TButton
              Left = 272
              Top = 35
              Width = 134
              Height = 25
              Cursor = crHandPoint
              Action = Action_RefreshUserList_SIC_04
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageMargins.Left = 2
              Images = ImageList1
              ParentFont = False
              TabOrder = 2
            end
            object cbShowIdleUsers_SIC_04: TCheckBox
              Left = 8
              Top = 236
              Width = 426
              Height = 17
              Caption = 
                #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081', '#1085#1077' '#1080#1079#1084#1077#1085#1103#1074#1096#1080#1093' '#1041#1044' '#1074' '#1091#1082#1072#1079#1072#1085#1085#1099#1081' '#1074#1088#1077#1084#1077#1085#1085#1086#1081 +
                ' '#1087#1077#1088#1080#1086#1076
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object clbUsers_SIC_04: TCheckListBox
              Left = 8
              Top = 66
              Width = 398
              Height = 118
              OnClickCheck = clbUsers_SIC_04ClickCheck
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 13
              ParentFont = False
              PopupMenu = pm_SIC_04
              Sorted = True
              TabOrder = 3
            end
            object btnSelectAllUsers_SIC_04: TButton
              Left = 412
              Top = 66
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1091#1089#1083#1091#1075
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 3
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnClick = Action_SelectAllUsers_SIC_04Execute
            end
            object btnUnselectAllUsers_SIC_04: TButton
              Left = 412
              Top = 94
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = 
                #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1089#1086' '#1074#1089#1077#1093' '#1075#1086#1083#1086#1089#1086#1074#1099#1093' '#1091 +
                #1089#1083#1091#1075
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 2
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              OnClick = Action_UnselectAllUsers_SIC_04Execute
            end
            object cbCreateDetailedReport_SIC_04: TCheckBox
              Left = 8
              Top = 190
              Width = 426
              Height = 17
              Caption = 
                #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1076#1088#1086#1073#1085#1099#1081' '#1086#1090#1095#1105#1090' ('#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080' '#1080#1075#1085#1086#1088#1080#1088#1091#1102#1090#1089#1103'!' +
                ')'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              OnClick = cbCreateDetailedReport_SIC_04Click
            end
            object cbShowSQLQueries_SIC_04: TCheckBox
              Left = 8
              Top = 213
              Width = 426
              Height = 17
              Caption = #1054#1090#1086#1073#1088#1072#1078#1072#1090#1100' '#1090#1077#1082#1089#1090' SQL-'#1079#1072#1087#1088#1086#1089#1086#1074
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object cbWeekStartsFromDayOfBeginning_SIC_04: TCheckBox
              Left = 8
              Top = 259
              Width = 426
              Height = 17
              Caption = #1054#1090#1089#1095#1080#1090#1099#1074#1072#1090#1100' '#1085#1077#1076#1077#1083#1102' '#1086#1090' '#1076#1085#1103' '#1085#1077#1076#1077#1083#1080' '#1085#1072#1095#1072#1083#1072' '#1088#1072#1089#1095#1105#1090#1085#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 9
            end
          end
        end
        object ts_SIC_05: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-05-...'
          ImageIndex = 5
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_SIC_05: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 4. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lbService_SIC_05: TLabel
              Left = 8
              Top = 16
              Width = 64
              Height = 13
              Caption = #1059#1089#1083#1091#1075#1072' '#1057#1048#1062':'
              FocusControl = cbService_SIC_05
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object cbWeekStartsFromDayOfBeginning_SIC_05: TCheckBox
              Left = 8
              Top = 59
              Width = 426
              Height = 17
              Caption = #1054#1090#1089#1095#1080#1090#1099#1074#1072#1090#1100' '#1085#1077#1076#1077#1083#1102' '#1086#1090' '#1076#1085#1103' '#1085#1077#1076#1077#1083#1080' '#1085#1072#1095#1072#1083#1072' '#1088#1072#1089#1095#1105#1090#1085#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
            object cbService_SIC_05: TComboBox
              Left = 8
              Top = 32
              Width = 426
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
          end
        end
        object ts_SIC_06: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-06-...'
          ImageIndex = 12
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_SIC_06: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 3. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lbService_SIC_06: TLabel
              Left = 8
              Top = 16
              Width = 64
              Height = 13
              Caption = #1059#1089#1083#1091#1075#1072' '#1057#1048#1062':'
              FocusControl = cbService_SIC_06
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object cbService_SIC_06: TComboBox
              Left = 8
              Top = 32
              Width = 426
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
        end
        object ts_SIC_07: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-07-...'
          ImageIndex = 2
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_SIC_07: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 4. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object cbWeekStartsFromDayOfBeginning_SIC_07: TCheckBox
              Left = 8
              Top = 16
              Width = 426
              Height = 17
              Caption = #1054#1090#1089#1095#1080#1090#1099#1074#1072#1090#1100' '#1085#1077#1076#1077#1083#1102' '#1086#1090' '#1076#1085#1103' '#1085#1077#1076#1077#1083#1080' '#1085#1072#1095#1072#1083#1072' '#1088#1072#1089#1095#1105#1090#1085#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
            end
          end
        end
        object ts_SIC_08: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-08-...'
          ImageIndex = 6
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
        end
        object ts_SIC_09: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-09-...'
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_SIC_09: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 3. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lbPhoneNet_SIC_09: TLabel
              Left = 8
              Top = 16
              Width = 92
              Height = 13
              Caption = #1058#1077#1083#1077#1092#1086#1085#1085#1072#1103' '#1089#1077#1090#1100':'
              FocusControl = cbPhoneNet_SIC_09
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object cbPhoneNet_SIC_09: TComboBox
              Left = 8
              Top = 32
              Width = 426
              Height = 21
              Style = csDropDownList
              DropDownCount = 13
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              Items.Strings = (
                #1087#1086' '#1074#1089#1077#1084' '#1086#1087#1077#1088#1072#1090#1086#1088#1072#1084' ('#1089#1091#1084#1084#1072#1088#1085#1072#1103')'
                
                  #1052#1080#1085#1089#1082#1072#1103' '#1043#1058#1057' ('#1075#1086#1088#1086#1076' '#1080' '#1087#1088#1080#1075#1086#1088#1086#1076' - 80172xxxxxx, 80173xxxxxx, 80175x' +
                  'xxxxx)'
                
                  #1052#1080#1085#1089#1082#1072#1103' '#1086#1073#1083#1072#1089#1090#1100', (017, '#1079#1072' '#1080#1089#1082#1083#1102#1095#1077#1085#1080#1077#1084' '#1090#1077#1086#1077#1092#1086#1085#1086#1074' '#1092#1080#1083#1080#1072#1083#1072' "'#1052#1080#1085#1089#1082#1072#1103 +
                  ' '#1043#1058#1057'")'
                #1043#1088#1086#1076#1085#1077#1085#1089#1082#1072#1103' '#1086#1073#1083#1072#1089#1090#1100' (015)'
                #1041#1088#1077#1089#1090#1089#1082#1072#1103' '#1086#1073#1083#1072#1089#1090#1100' (016)'
                #1042#1080#1090#1077#1073#1089#1082#1072#1103' '#1086#1073#1083#1072#1089#1090#1100' (021)'
                #1052#1086#1075#1080#1083#1105#1074#1089#1082#1072#1103' '#1086#1073#1083#1072#1089#1090#1100' (022)'
                #1043#1086#1084#1077#1083#1100#1089#1082#1072#1103' '#1086#1073#1083#1072#1089#1090#1100' (023)'
                
                  #1052#1062#1057' (80291xxxxxx, 80293xxxxxx, 80296xxxxxx, 80299xxxxxx, 8044xxx' +
                  'xxxx)'
                
                  #1052#1058#1057' (80292xxxxxx, 80295xxxxxx, 80297xxxxxx, 80298xxxxxx, 8033xxx' +
                  'xxxx)'
                #1041#1077#1057#1058' (80255xxxxxx, 80256xxxxxx, 80257xxxxxx, 80259xxxxxx)'
                #1041#1077#1083#1057#1077#1083' (80294xxxxxx)'
                #1087#1088#1086#1095#1080#1077' ('#1079#1074#1086#1085#1082#1080', '#1085#1077' '#1074#1086#1096#1077#1076#1096#1080#1077' '#1074' '#1087#1088#1077#1076#1099#1076#1091#1097#1080#1077' '#1075#1088#1091#1087#1087#1099')')
            end
            object btnSelectAllServices_SIC_09: TButton
              Left = 412
              Top = 59
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1091#1089#1083#1091#1075
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 3
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = Action_SelectAllServices_SIC_09Execute
            end
            object btnUnselectAllServices_SIC_09: TButton
              Left = 412
              Top = 143
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1089#1086' '#1074#1089#1077#1093' '#1091#1089#1083#1091#1075
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 2
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 3
              OnClick = Action_UnselectAllServices_SIC_09Execute
            end
            object lvServices_SIC_09: TListView
              Left = 8
              Top = 59
              Width = 398
              Height = 171
              Checkboxes = True
              Columns = <
                item
                  Caption = #1053#1086#1084#1077#1088' '#1091#1089#1083#1091#1075#1080
                  Width = -2
                  WidthType = (
                    -2)
                end
                item
                  Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077' '#1091#1089#1083#1091#1075#1080
                  Width = -2
                  WidthType = (
                    -2)
                end>
              ColumnClick = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              GridLines = True
              HideSelection = False
              ReadOnly = True
              RowSelect = True
              ParentFont = False
              PopupMenu = pm_SIC_09
              SmallImages = ImageList1
              TabOrder = 1
              ViewStyle = vsReport
              OnSelectItem = lv_SIC_01SelectItem
              OnItemChecked = lvServices_SIC_09ItemChecked
            end
            object btnSelectOralServices_SIC_09: TButton
              Left = 412
              Top = 87
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1075#1086#1083#1086#1089#1086#1074#1099#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1090#1086#1083#1100#1082#1086' '#1075#1086#1083#1086#1089#1086#1074#1099#1093' '#1091#1089#1083#1091#1075
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 12
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 4
              OnClick = Action_SelectOralServices_SIC_09Execute
            end
            object btnSelectAutoServices_SIC_09: TButton
              Left = 412
              Top = 115
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = 
                #1042#1099#1076#1077#1083#1080#1090#1100' '#1072#1074#1090#1086#1080#1085#1092#1086#1088#1084#1072#1090#1086#1088'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1090#1086#1083#1100#1082#1086' '#1091#1089#1083#1091#1075#1080' '#1072#1074#1090#1086 +
                #1080#1085#1092#1086#1088#1084#1072#1090#1086#1088#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 32
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              OnClick = Action_SelectAutoServices_SIC_09Execute
            end
            object cbSummaryReport_SIC_09: TCheckBox
              Left = 8
              Top = 236
              Width = 426
              Height = 17
              Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1082#1088#1072#1090#1082#1080#1081' '#1086#1090#1095#1105#1090' ('#1073#1077#1079' '#1076#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1077#1081' '#1079#1074#1086#1085#1082#1086#1074')'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              OnClick = cbSummaryReport_SIC_09Click
            end
            object cbOldReport_SIC_09: TCheckBox
              Left = 8
              Top = 259
              Width = 426
              Height = 17
              Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1091#1087#1088#1086#1097#1105#1085#1085#1099#1081' '#1086#1090#1095#1105#1090' ('#1092#1086#1088#1084#1072' '#1091#1089#1090#1072#1088#1077#1074#1096#1077#1075#1086' '#1086#1073#1088#1072#1079#1094#1072')'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
              OnClick = cbOldReport_SIC_09Click
            end
          end
        end
        object ts_SIC_10: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-10-...'
          ImageIndex = 10
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_SIC_10: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 4. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object Label2: TLabel
              Left = 8
              Top = 16
              Width = 120
              Height = 13
              Caption = #1043#1088#1091#1087#1087#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081':'
              FocusControl = cbCCID_SIC_10
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object rbAllUsers_SIC_10: TRadioButton
              Left = 8
              Top = 62
              Width = 426
              Height = 17
              Caption = #1087#1086' '#1074#1089#1077#1084' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#1084
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
              OnClick = rbUsers_SIC_10Click
            end
            object rbSelectedUsers_SIC_10: TRadioButton
              Left = 8
              Top = 85
              Width = 258
              Height = 17
              Caption = #1087#1086' '#1091#1082#1072#1079#1072#1085#1085#1099#1084' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103#1084
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
              OnClick = rbUsers_SIC_10Click
            end
            object btnRefreshUserList_SIC_10: TButton
              Left = 272
              Top = 81
              Width = 134
              Height = 25
              Cursor = crHandPoint
              Action = Action_RefreshUserList_SIC_10
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageMargins.Left = 2
              Images = ImageList1
              ParentFont = False
              TabOrder = 3
            end
            object clbUsers_SIC_10: TCheckListBox
              Left = 8
              Top = 112
              Width = 398
              Height = 118
              OnClickCheck = clbUsers_SIC_10ClickCheck
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ItemHeight = 13
              ParentFont = False
              PopupMenu = pm_SIC_10
              Sorted = True
              TabOrder = 4
            end
            object btnSelectAllUsers_SIC_10: TButton
              Left = 412
              Top = 112
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1091#1089#1083#1091#1075
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 3
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 5
              OnClick = Action_SelectAllUsers_SIC_10Execute
            end
            object btnUnselectAllUsers_SIC_10: TButton
              Left = 412
              Top = 140
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = 
                #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1089#1086' '#1074#1089#1077#1093' '#1075#1086#1083#1086#1089#1086#1074#1099#1093' '#1091 +
                #1089#1083#1091#1075
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 2
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 6
              OnClick = Action_UnselectAllUsers_SIC_10Execute
            end
            object cbCreateDetailedReport_SIC_10: TCheckBox
              Left = 8
              Top = 236
              Width = 426
              Height = 17
              Caption = 
                #1060#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1076#1088#1086#1073#1085#1099#1081' '#1086#1090#1095#1105#1090' ('#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080' '#1080#1075#1085#1086#1088#1080#1088#1091#1102#1090#1089#1103'!' +
                ')'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 7
            end
            object cbWeekStartsFromDayOfBeginning_SIC_10: TCheckBox
              Left = 8
              Top = 259
              Width = 426
              Height = 17
              Caption = #1054#1090#1089#1095#1080#1090#1099#1074#1072#1090#1100' '#1085#1077#1076#1077#1083#1102' '#1086#1090' '#1076#1085#1103' '#1085#1077#1076#1077#1083#1080' '#1085#1072#1095#1072#1083#1072' '#1088#1072#1089#1095#1105#1090#1085#1086#1075#1086' '#1087#1077#1088#1080#1086#1076#1072
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 8
            end
            object cbCCID_SIC_10: TComboBox
              Left = 8
              Top = 35
              Width = 426
              Height = 21
              Style = csDropDownList
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              OnChange = rbUsers_SIC_10Click
              Items.Strings = (
                #1074#1089#1077' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
                #1090#1086#1083#1100#1082#1086' '#1090#1077#1083#1077#1092#1086#1085#1080#1089#1090#1099' '#1062#1054#1042
                #1090#1086#1083#1100#1082#1086' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1099' '#1058#1062#1054#1050' '#1080' BackOffice')
            end
          end
        end
        object TabSheet7: TTabSheet
          Caption = 
            #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1072#1073#1083#1080#1094' '#1076#1072#1085#1085#1099#1093' '#1074#1093#1086#1076#1103#1097#1080#1093'/'#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1074#1099#1079#1086#1074#1086#1074' (<i/o>rd_<' +
            'yyyymmdd>, <i/o>rd_<yyyy>[mm][dd][_[yyyy][mm][dd]])'
          ImageIndex = 6
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object gb_XRD: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 3. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object cbRecreateXRD: TCheckBox
              Left = 8
              Top = 62
              Width = 426
              Height = 17
              Caption = #1055#1088#1086#1074#1077#1089#1090#1080' '#1087#1077#1088#1077#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1072#1073#1083#1080#1094'('#1099') xrd_<yyyymmdd>'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 2
            end
            object ebCustomNameOfXRDA: TEdit
              Left = 40
              Top = 154
              Width = 394
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 6
              Text = 'xrda_xxxxxx'
            end
            object cbCustomNameOfXRDA: TCheckBox
              Left = 24
              Top = 131
              Width = 410
              Height = 17
              Caption = 
                #1048#1079#1084#1077#1085#1080#1090#1100' '#1080#1084#1103' '#1090#1072#1073#1083#1080#1094#1099' xrda_<yyyy>[mm][dd][_[yyyy][mm][dd]] '#1085#1072' '#1091#1082#1072 +
                #1079#1072#1085#1085#1086#1077':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 5
              OnClick = cbCustomNameOfXRDAClick
            end
            object cbRecreateXRDA: TCheckBox
              Left = 8
              Top = 108
              Width = 426
              Height = 17
              Caption = 
                #1055#1088#1086#1074#1077#1089#1090#1080' '#1087#1077#1088#1077#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099' xrda_<yyyy>[mm][dd][_[yyyy][mm' +
                '][dd]]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 4
              OnClick = cbRecreateXRDAClick
            end
            object rbIRD: TRadioButton
              Left = 8
              Top = 16
              Width = 426
              Height = 17
              Caption = #1074#1093#1086#1076#1103#1097#1080#1077' '#1079#1074#1086#1085#1082#1080' ('#1090#1072#1073#1083#1080#1094#1072' ird[a]_...)'
              Checked = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              TabStop = True
            end
            object rbORD: TRadioButton
              Left = 8
              Top = 39
              Width = 426
              Height = 17
              Caption = #1080#1089#1093#1086#1076#1103#1097#1080#1077' '#1079#1074#1086#1085#1082#1080' ('#1090#1072#1073#1083#1080#1094#1072' ord[a]_...)'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 1
            end
            object cbCreateXRDA: TCheckBox
              Left = 8
              Top = 85
              Width = 426
              Height = 17
              Caption = 
                #1055#1088#1086#1074#1077#1089#1090#1080' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1072#1073#1083#1080#1094#1099' xrda_<yyyy>[mm][dd][_[yyyy][mm][dd' +
                ']]'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              OnClick = cbCreateXRDAClick
            end
          end
        end
        object TabSheet1: TTabSheet
          Caption = #1057#1085#1103#1090#1080#1077' '#1086#1087#1083#1072#1090#1099' '#1079#1072' '#1079#1074#1086#1085#1086#1082' '#1085#1072' '#1075#1086#1083#1086#1089#1086#1074#1099#1077' '#1089#1083#1091#1078#1073#1099' '#1057#1048#1062
          ImageIndex = 9
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox3: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 3. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            object lblPhonesNumbers: TLabel
              Left = 8
              Top = 16
              Width = 147
              Height = 13
              Caption = #1059#1082#1072#1078#1080#1090#1077' '#1085#1086#1084#1077#1088#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074':'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
            end
            object btnResfeshCallsList_Payoff: TButton
              Left = 300
              Top = 30
              Width = 134
              Height = 25
              Cursor = crHandPoint
              Action = Action_RefreshCallsList_Payoff
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageMargins.Left = 2
              Images = ImageList1
              ParentFont = False
              TabOrder = 0
            end
            object btnSelectAllCalls_Payoff: TButton
              Left = 412
              Top = 61
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1075#1086#1083#1086#1089#1086#1074#1099#1093' '#1091#1089#1083#1091#1075
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 3
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 1
              OnClick = Action_SelectAllCalls_PayoffExecute
            end
            object btnUnselectAllCalls_Payoff: TButton
              Left = 412
              Top = 89
              Width = 22
              Height = 22
              Cursor = crHandPoint
              Hint = 
                #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1089#1086' '#1074#1089#1077#1093' '#1075#1086#1083#1086#1089#1086#1074#1099#1093' '#1091 +
                #1089#1083#1091#1075
              Enabled = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ImageIndex = 2
              Images = ImageList1
              ParentFont = False
              ParentShowHint = False
              ShowHint = True
              TabOrder = 2
              OnClick = Action_UnselectAllCalls_PayoffExecute
            end
            object ebPhonesList_Payoff: TEdit
              Left = 8
              Top = 32
              Width = 286
              Height = 21
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 3
              TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1084#1077#1088#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074' '#1073#1077#1079' '#1088#1072#1079#1076#1077#1083#1080#1090#1077#1083#1077#1081' '#1095#1077#1088#1077#1079' '#1087#1088#1086#1073#1077#1083'...'
              OnChange = ebPhonesList_PayoffChange
            end
            object lvPhonesList_Payoff: TListView
              Left = 8
              Top = 61
              Width = 398
              Height = 215
              Checkboxes = True
              Columns = <
                item
                  Caption = #1053#1086#1084#1077#1088' '#1072#1073#1086#1085#1077#1085#1090#1072
                  Width = -2
                  WidthType = (
                    -2)
                end
                item
                  Caption = #1053#1086#1084#1077#1088' '#1091#1089#1083#1091#1075#1080
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
                  Caption = #1044#1083#1080#1090#1077#1083#1100#1085#1086#1089#1090#1100
                  Width = -2
                  WidthType = (
                    -2)
                end
                item
                  Caption = #1056#1072#1073#1086#1095#1077#1077' '#1084#1077#1089#1090#1086
                  Width = -2
                  WidthType = (
                    -2)
                end
                item
                  Caption = #1041#1099#1083' '#1083#1080' '#1074#1099#1076#1072#1085' '#1085#1086#1084#1077#1088
                  Width = -2
                  WidthType = (
                    -2)
                end
                item
                  Caption = #1042#1099#1076#1072#1085#1085#1099#1081' '#1085#1086#1084#1077#1088
                  Width = -2
                  WidthType = (
                    -2)
                end
                item
                  Caption = #1042#1088#1077#1084#1103' '#1086#1090#1074#1077#1090#1072' '#1087#1083#1072#1090#1092#1086#1088#1084#1099
                  Width = -2
                  WidthType = (
                    -2)
                end
                item
                  Caption = #1042#1088#1077#1084#1103' '#1086#1090#1074#1077#1090#1072' '#1086#1087#1077#1088#1072#1090#1086#1088#1072
                  Width = -2
                  WidthType = (
                    -2)
                end>
              ColumnClick = False
              DoubleBuffered = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              GridLines = True
              ReadOnly = True
              RowSelect = True
              ParentDoubleBuffered = False
              ParentFont = False
              ParentShowHint = False
              PopupMenu = pm_Payoff
              ShowHint = True
              TabOrder = 4
              ViewStyle = vsReport
              OnItemChecked = lvPhonesList_PayoffItemChecked
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1086#1074' '#1074#1099#1075#1088#1091#1079#1082#1080' '#1076#1083#1103' '#1040#1057#1050#1056
          ImageIndex = 11
          TabVisible = False
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object GroupBox4: TGroupBox
            Left = 0
            Top = 0
            Width = 441
            Height = 286
            Align = alClient
            Caption = ' 3. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1088#1086#1095#1080#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099': '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 794
        Height = 52
        Align = alTop
        BevelOuter = bvNone
        BorderWidth = 4
        TabOrder = 0
        object GroupBox1: TGroupBox
          Left = 4
          Top = 4
          Width = 786
          Height = 44
          Align = alClient
          Caption = ' 1. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1076#1077#1081#1089#1090#1074#1080#1077': '
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          DesignSize = (
            786
            44)
          object cbActionsList: TComboBox
            Left = 8
            Top = 16
            Width = 743
            Height = 21
            Style = csDropDownList
            Anchors = [akLeft, akTop, akRight]
            DropDownCount = 20
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnChange = cbActionsListChange
            Items.Strings = (
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-01-...'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-02-...'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-03-...'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-04-...'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-05-...'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-06-...'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-07-...'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-08-...'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-09-...'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1086#1090#1095#1105#1090#1072' '#1087#1086' '#1092#1086#1088#1084#1077' '#8470' '#1057#1048#1062'-10-...'
              
                #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1090#1072#1073#1083#1080#1094' '#1076#1072#1085#1085#1099#1093' '#1074#1093#1086#1076#1103#1097#1080#1093'/'#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1074#1099#1079#1086#1074#1086#1074' (<i/o>rd_<' +
                'yyyymmdd>, <i/o>rd_<yyyy>[mm][dd][_[yyyy][mm][dd]])'
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1086#1074' prijave_'#1075#1075#1075#1075#1084#1084#1076#1076' '#1080' prijave_q_'#1075#1075#1075#1075#1084#1084#1076#1076
              #1057#1085#1103#1090#1080#1077' '#1086#1087#1083#1072#1090#1099' '#1079#1072' '#1079#1074#1086#1085#1086#1082' '#1085#1072' '#1075#1086#1083#1086#1089#1086#1074#1099#1077' '#1089#1083#1091#1078#1073#1099' '#1057#1048#1062
              #1060#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1077' '#1092#1072#1081#1083#1086#1074' '#1074#1099#1075#1088#1091#1079#1082#1080' '#1076#1083#1103' '#1040#1057#1050#1056)
          end
          object btnActionComments: TButton
            Left = 757
            Top = 16
            Width = 22
            Height = 21
            Cursor = crHandPoint
            Action = Action_Comments
            Images = ImageList1
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
          end
        end
      end
      object btnProcess: TButton
        Left = 624
        Top = 350
        Width = 166
        Height = 25
        Cursor = crHandPoint
        Action = Action_Process
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ImageMargins.Left = 2
        Images = ImageList1
        ParentFont = False
        TabOrder = 4
      end
      object gbGroupingPeriod: TGroupBox
        Left = 4
        Top = 338
        Width = 612
        Height = 42
        Caption = ' 3. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1087#1072#1088#1072#1084#1077#1090#1088#1099' '#1075#1088#1091#1087#1087#1080#1088#1086#1074#1082#1080' '#1076#1072#1085#1085#1099#1093' '#1086#1090#1095#1105#1090#1072':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object rbGroupByYears: TRadioButton
          Left = 8
          Top = 16
          Width = 93
          Height = 17
          Caption = #1087#1086' '#1075#1086#1076#1072#1084
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          OnClick = ChangeGroupping
        end
        object rbGroupByQuarters: TRadioButton
          Left = 107
          Top = 16
          Width = 93
          Height = 17
          Caption = #1087#1086' '#1082#1074#1072#1088#1090#1072#1083#1072#1084
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ChangeGroupping
        end
        object rbGroupByMonths: TRadioButton
          Left = 206
          Top = 16
          Width = 93
          Height = 17
          Caption = #1087#1086' '#1084#1077#1089#1103#1094#1072#1084
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = ChangeGroupping
        end
        object rbGroupByWeeks: TRadioButton
          Left = 305
          Top = 16
          Width = 93
          Height = 17
          Caption = #1087#1086' '#1085#1077#1076#1077#1083#1103#1084
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = ChangeGroupping
        end
        object rbGroupByDays: TRadioButton
          Left = 404
          Top = 16
          Width = 93
          Height = 17
          Caption = #1087#1086' '#1076#1085#1103#1084
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = ChangeGroupping
        end
        object rbGroupByHours: TRadioButton
          Left = 503
          Top = 16
          Width = 93
          Height = 17
          Caption = #1087#1086' '#1095#1072#1089#1072#1084
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = ChangeGroupping
        end
      end
      object GroupBox2: TGroupBox
        Left = 4
        Top = 50
        Width = 335
        Height = 286
        Align = alCustom
        Caption = ' 2. '#1042#1099#1073#1077#1088#1080#1090#1077' '#1074#1088#1077#1084#1077#1085#1085#1086#1081' '#1087#1077#1088#1080#1086#1076': '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        object rbLastDate: TRadioButton
          Left = 8
          Top = 16
          Width = 319
          Height = 17
          Caption = '&1) '#1087#1088#1086#1096#1077#1076#1096#1080#1081' '#1076#1077#1085#1100' (00.00.0000)'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          OnClick = TimePeriodChange
        end
        object rbLastWeek: TRadioButton
          Left = 8
          Top = 70
          Width = 319
          Height = 17
          Caption = '&3) '#1087#1088#1086#1096#1077#1076#1096#1072#1103' '#1085#1077#1076#1077#1083#1103' (00.00.0000-00.00.0000)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          OnClick = TimePeriodChange
        end
        object rbLastMonth: TRadioButton
          Left = 8
          Top = 97
          Width = 319
          Height = 17
          Caption = '&4) '#1087#1088#1086#1096#1077#1076#1096#1080#1081' '#1084#1077#1089#1103#1094' (xxxxxxxx 0000 '#1075#1086#1076#1072')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          OnClick = TimePeriodChange
        end
        object rbLastQuarter: TRadioButton
          Left = 8
          Top = 151
          Width = 319
          Height = 17
          Caption = '&6) '#1087#1088#1086#1096#1077#1076#1096#1080#1081' '#1082#1074#1072#1088#1090#1072#1083' (xx '#1082#1074#1072#1088#1090#1072#1083' 0000 '#1075#1086#1076#1072')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 8
          OnClick = TimePeriodChange
        end
        object rbLastYear: TRadioButton
          Left = 8
          Top = 205
          Width = 320
          Height = 17
          Caption = '&8) '#1087#1088#1086#1096#1077#1076#1096#1080#1081' '#1075#1086#1076' (0000 '#1075#1086#1076')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 12
          OnClick = TimePeriodChange
        end
        object rbChoisenYear: TRadioButton
          Left = 8
          Top = 232
          Width = 225
          Height = 17
          Caption = '&9) '#1091#1082#1072#1079#1072#1085#1099#1081' '#1075#1086#1076':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 13
          OnClick = TimePeriodChange
        end
        object cbChoisenQuarter_Year: TComboBox
          Left = 239
          Top = 176
          Width = 88
          Height = 21
          Style = csDropDownList
          DropDownCount = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 11
          Items.Strings = (
            '2000'
            '2001'
            '2002'
            '2003'
            '2004'
            '2005'
            '2006'
            '2007'
            '2008'
            '2009'
            '2010')
        end
        object rbChoisenQuarter: TRadioButton
          Left = 8
          Top = 178
          Width = 132
          Height = 17
          Caption = '&7) '#1091#1082#1072#1079#1072#1085#1099#1081' '#1082#1074#1072#1088#1090#1072#1083':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 9
          OnClick = TimePeriodChange
        end
        object cbChoisenYear: TComboBox
          Left = 239
          Top = 230
          Width = 88
          Height = 21
          Style = csDropDownList
          DropDownCount = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 14
          Items.Strings = (
            '2000'
            '2001'
            '2002'
            '2003'
            '2004'
            '2005'
            '2006'
            '2007'
            '2008'
            '2009')
        end
        object cbChoisenQuarter_Quarter: TComboBox
          Left = 145
          Top = 176
          Width = 88
          Height = 21
          Style = csDropDownList
          DropDownCount = 4
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 10
          Items.Strings = (
            'I'
            'II'
            'III'
            'IV')
        end
        object rbChoisenMonth: TRadioButton
          Left = 8
          Top = 124
          Width = 121
          Height = 17
          Caption = '&5) '#1091#1082#1072#1079#1072#1085#1099#1081' '#1084#1077#1089#1103#1094':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
          OnClick = TimePeriodChange
        end
        object cbChoisenMonth_Month: TComboBox
          Left = 145
          Top = 122
          Width = 88
          Height = 21
          Style = csDropDownList
          DropDownCount = 12
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          Items.Strings = (
            #1103#1085#1074#1072#1088#1100
            #1092#1077#1074#1088#1072#1083#1100
            #1084#1072#1088#1090
            #1072#1087#1088#1077#1083#1100
            #1084#1072#1081
            #1080#1102#1085#1100
            #1080#1102#1083#1100
            #1072#1074#1075#1091#1089#1090
            #1089#1077#1085#1090#1103#1073#1088#1100
            #1086#1082#1090#1103#1073#1088#1100
            #1085#1086#1103#1073#1088#1100
            #1076#1077#1082#1072#1073#1088#1100)
        end
        object cbChoisenMonth_Year: TComboBox
          Left = 239
          Top = 122
          Width = 88
          Height = 21
          Style = csDropDownList
          DropDownCount = 10
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
          Items.Strings = (
            '2000'
            '2001'
            '2002'
            '2003'
            '2004'
            '2005'
            '2006'
            '2007'
            '2008'
            '2009'
            '2010')
        end
        object rbChoisenDate: TRadioButton
          Left = 8
          Top = 44
          Width = 225
          Height = 17
          Caption = '&2) '#1091#1082#1072#1079#1072#1085#1099#1081' '#1076#1077#1085#1100':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = TimePeriodChange
        end
        object dtpChoisenDate: TDateTimePicker
          Left = 239
          Top = 42
          Width = 88
          Height = 21
          Date = 39819.637429282390000000
          Time = 39819.637429282390000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object dtpChoisenPeriod_Start: TDateTimePicker
          Left = 145
          Top = 257
          Width = 88
          Height = 21
          Date = 39819.637429282390000000
          Time = 39819.637429282390000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 16
          OnChange = TimePeriodChange
        end
        object rbChoisenPeriod: TRadioButton
          Left = 8
          Top = 259
          Width = 121
          Height = 17
          Caption = '&0) '#1091#1082#1072#1079#1072#1085#1099#1081' '#1087#1077#1088#1080#1086#1076':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 15
          OnClick = TimePeriodChange
        end
        object dtpChoisenPeriod_Stop: TDateTimePicker
          Left = 239
          Top = 257
          Width = 88
          Height = 21
          Date = 39819.637429282390000000
          Time = 39819.637429282390000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 17
          OnChange = TimePeriodChange
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Images = ImageList1
    Left = 480
    Top = 424
    object N5: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object N10: TMenuItem
        Action = Action_Logon
      end
      object N11: TMenuItem
        Action = Action_Logout
      end
      object N13: TMenuItem
        Caption = '-'
      end
      object N32: TMenuItem
        Action = Action_OpenReportsFolder
      end
      object N15: TMenuItem
        Caption = '-'
      end
      object N17: TMenuItem
        Action = Action_Configuration
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object N7: TMenuItem
        Action = Action_Quit
      end
    end
    object miActions: TMenuItem
      Caption = '&'#1044#1077#1081#1089#1090#1074#1080#1077
      object N26: TMenuItem
        Action = Action_Process
      end
      object N25: TMenuItem
        Action = Action_ProcessSelectedActions
      end
      object N16: TMenuItem
        Caption = '-'
      end
      object N22: TMenuItem
        Action = Action_Accounts
      end
    end
    object N14: TMenuItem
      Caption = '&'#1042#1080#1076
      object miStatusbar: TMenuItem
        AutoCheck = True
        Caption = #1055#1072#1085#1077#1083#1100' '#1089#1090#1072#1090#1091#1089#1072
        Checked = True
        OnClick = miStatusbarClick
      end
    end
    object N6: TMenuItem
      Caption = '&?'
      object N8: TMenuItem
        Action = Action_Help
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object O2: TMenuItem
        Action = Action_About
      end
    end
  end
  object ImageList1: TImageList
    AllocBy = 34
    Left = 384
    Top = 424
    Bitmap = {
      494C01012200A000840510001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000009000000001002000000000000090
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000ECA6A6FFECA6A6FFCF8C8CFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000ECA6A6FFCF8C
      8CFFECA6A6FF0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000A060000060400000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000ECA6A6FFECA6A6FFCF8C8CFF00000000ECA6
      A6FFCF8C8CFFECA6A6FF00000000000000000000000040606000000000000000
      000000000000004060000040A0000060A000006060000060400000A0400000A0
      60000060600000C0A00000606000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000ECA6A6FFCF8C8CFF0000
      0000ECA6A6FFCF8C8CFF00000000000000000000000040606000000000000000
      00000040A0000060A0000060A0000060A00000A0600000C0A00000C0A00000C0
      A00000C0A00000C0A00000C0A00000A040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000545454FF545454FF545454FF606060FF0000000000000000ECA6A6FFCF8C
      8CFF00000000ECA6A6FFCF8C8CFF000000000000000040606000000000000060
      A0000060C00000A0C0000060C0000060C00000A0400000C0A00000C0A00000C0
      A00000C0A00000C0A00080E0C000006040000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005454
      54FF9F9F9FFFABABABFFAEAEAEFFC3C3C3FF545454FF0000000000000000ECA6
      A6FFCF8C8CFF00000000ECA6A6FF000000000000000000000000404040000060
      C0000060A00040A0C0004060C0000060C0000080800000A0400000A0400000A0
      400000A0400080C0C00000A04000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000545454FF7878
      78FFABABABFFC7C7C7FFC9C9C9FFAEAEAEFFBFBFBFFF545454FF000000000000
      0000ECA6A6FF00000000ECA6A6FF0000000080606000000000000040A00000A0
      E0000060A00080A0C0004060C0000060C00040A0C0004060C00040A0C0000040
      C00000A040000060400000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000545454FF6A67
      67FF504343FF504343FF9C9999FFCCCCCCFFADADADFF868686FF606060FF0000
      0000ECA6A6FF00000000ECA6A6FF0000000080606000000000000040A00040A0
      E0004060C00040A0C0000060C0000060C00040A0C0004060C00040A0E0000060
      A000000000008060600000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000766262FF515151FF5043
      43FF857070FF9A7777FF5C5C5CFFB6B6B6FFC7C7C7FFB6B6B6FF545454FF0000
      00000000000000000000000000000000000000000000404040000060A00080C0
      E0004060C00080C0E0004060C0000060C00080C0E0000060C00080C0E0000060
      C000402020008060600000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F3F3FFF947A7AFF454545FF7171
      71FF8A8A8AFF787878FF907474FF545454FFC7C7C7FFADADADFF545454FF0000
      00000000000000000000000000000000000000000000406060000060A00080C0
      E00040A0C00080C0E00040A0C0000060C00080C0E0004060C00080C0E0000060
      C000404040000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B3C3CFFDAB5B5FF3A3A3AFF8383
      83FFC7C7C7FF9B9B9BFF727272FF545454FFB1B1B1FFA5A5A5FF545454FF0000
      00000000000000000000000000000000000000000000000000000060A00080C0
      E00080A0E00080C0E00080A0C0000060C000C0DCC00040A0C00080C0E0000060
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006F3F3FFFF5F5F5FF4A4A4AFF4E4E
      4EFFFFFFFFFFC7C7C7FF727272FF696969FF969696FF959595FF545454FF0000
      00000000000000000000000000000000000000000000000000000060A000F0FB
      FF0000A0C00040A0E00040A0C00080A0C00040A0C00000A0C00080C0E0000060
      C000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006B3C3CFFB38E8EFFC9C9C9FF3939
      39FF4D4D4DFF6C6C6CFF545454FF6C6C6CFF7E7E7EFF868686FF606060FF0000
      00000000000000000000000000000000000000000000404040004060600080C0
      E00080C0E00040C0E00040A0E00040C0E00080A0E00080A0E00080C0E0000040
      A000406060004040400000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000006F3F3FFF6F3F3FFF564B
      4BFF393939FF464646FF525252FF5C5C5CFF606060FF545454FF000000000000
      0000000000000000000000000000000000008060600080606000000000000040
      A0004060C00040A0C0004060C00040A0E0004060C00000A0C0004060A0000000
      0000000000008060600080606000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000606060FF353535FF3F3F3FFF4D4D4DFF5C5C5CFF00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004060600080406000804040004040400000406000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000040404000404040004020200000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000406060008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000080808000406060008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A4A0A00000000000000000004060
      6000808080000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A4A0A00080808000C08080004060
      6000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000066666600666666000000000000000000000000000000
      0000000000000000000000000000000000000000000040A0C0008060A0000000
      0000406060000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000080A0C0004080E0008080A000C080
      8000806060008060600000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000066666600B09E9F00E5D7D5006666660066666600000000000000
      0000000000000000000000000000000000000000000080C0E000000000000000
      0000A4A0A0000000000080606000000000000000000000000000000000000000
      00000000000000000000000000000000000080E0E00040C0E0004080E0008080
      A000C08080008060600080606000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000009999000099
      9900009999000099990000999900009999000099990000999900009999000099
      9900009999000099990000000000000000000000000000000000000000000000
      00006666660074616100A59B9A00FCE5E500E4C9C900D1B5B200666666006666
      6600000000000000000000000000000000000000000080C0E00080C0E00040A0
      C0008060A0000000000040606000806060000000000000000000000000000000
      0000000000000000000000000000000000000000000080E0E00040C0E0004080
      E0008080A000C080800080606000808080000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000999900F8F8
      F80099CCFF0099FFFF0099CCFF0099FFFF0099CCFF0099CCFF0099CCFF0099CC
      FF0066CCCC000099990000000000000000000000000000000000000000006666
      6600866F6E0090817B00C1959000C1959000E6BDBA00D9AEAE00D6ACAB00CAAA
      A700666666006666660000000000000000000000000000000000000000000000
      000040A0C0000000000080808000808080000000000040606000000000004040
      40000000000000000000000000000000000000000000000000000000000040A0
      E0004080C0008080A00000000000000000008080800040606000000000004040
      4000000000000000000000000000000000000000000000999900F8F8F80099FF
      FF0099FFFF0099CCFF0099FFFF0099CCFF0099FFFF0099CCFF0099CCFF0099CC
      FF0066CCCC00000000000099990000000000000000000000000066666600997C
      7C00AC908700778FA20067AAD1008EC5CB00C1959000C1959000D39D9C00CE93
      9300CE8D8D00B5908C00666666000000000000000000000000000000000080C0
      E00080A0E00080A0C0008080800080808000A4A0A000A4A0A000A4A0A000A4A0
      A000808080008060600080606000000000000000000000000000000000000000
      000040A0E00000000000808080008080800000000000C0A0800000000000C0A0
      A000000000008060600080808000000000000000000000999900F8F8F80099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099CCFF0099FFFF0099CCFF0099CC
      FF00009999000000000000999900000000000000000066666600B18D8900A692
      8F005890B0001572DB004EAAF7009CFBF9008ADCE4008ABBC900C1959000C195
      9000CE8D8D00CE8D8D0066666600000000000000000000000000000000000000
      000080C0E00080C0C000A4A0A000C0C0A000F0CAA600F0CAA600F0CAA600F0CA
      A600C0C0C0008080800080606000804040000000000000000000000000000000
      000080E0E00000000000A4A0A000F0CAA60000000000F0CAA60000000000F0CA
      A6000000000080808000806060000000000000999900F8F8F80099FFFF0099FF
      FF0099FFFF0099FFFF0099CCFF0099FFFF0099FFFF0099CCFF0099FFFF0066CC
      CC000000000066CCCC0066CCCC000000000066666600C1959000AD9C9D00459D
      CB001978F5001572DB0008A2F60027D8F30077F9FF0091FCFB0089E1E90083BD
      CB00C1959000C195900066666600000000000000000000000000000000000000
      000000000000C0C0C000C0C0A000F0CAA600F0CAA600FFFFFF00F0FBFF00FFFF
      FF00F0FBFF00A4A0A00080606000808080000000000000000000000000000000
      00000000000000000000F0CAA600F0CAA60000000000FFFFFF0000000000FFFF
      FF0000000000C0DCC000806060000000000000999900F8F8F80099FFFF0099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099CCFF0099FFFF0099CCFF0066CC
      CC000000000066CCCC0066CCCC0000000000CCA09E00A2A2AA0028A7D80003AB
      FD00168CF700099CFF0023C3E900479AB80002ADE1001CCBF10059F3FF0084FF
      FE0076CBDC006666660000000000000000000000000000000000000000000000
      000000000000F0CAA600F0CAA600F0CAA600F0FBFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0FBFF0080806000406060000000000000000000000000000000
      00000000000000000000F0CAA600F0CAA60000000000FFFFFF0000000000FFFF
      FF00000000000000000000000000406060000099990000999900009999000099
      9900009999000099990000999900009999000099990000999900009999000099
      990066CCCC0099FFFF0066CCCC0000000000C3A9AC0047B7DB0000B7FD001194
      FB001194FB0009B3EA004499B5003EC9EC00219FC30033B3D90007A3D20013BB
      E70050C0E1006666660000000000000000000000000000000000000000000000
      000000000000F0CAA600F0CAA600F0CAA600F0CAA600FFFFFF00F0FBFF00FFFF
      FF00FFFFFF00FFFFFF00A4A0A000406060000000000000000000000000000000
      000000000000F0CAA600F0CAA600F0CAA600F0CAA600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0A0A000406060000000000000999900F8F8F80099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FF
      FF0099FFFF0099FFFF0066CCCC00000000000B85D3000B85D3000B85D3001194
      FB0012BAFA004499B50043BDDF00219FC3004BB3D00025C4EC004ABFDE0019A6
      D800666666000000000000000000000000000000000000000000000000000000
      000000000000F0CAA600F0CAA600F0CAA600F0CAA600FFFFFF00FFFFFF00F0FB
      FF00FFFFFF00FFFFFF00C0A0A000806060000000000000000000000000000000
      000000000000F0CAA600FFFFFF00F0CAA600F0CAA600FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0A0A000806060000000000000999900F8F8F80099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF0099FFFF00F8F8F800F8F8
      F800F8F8F800F8F8F80066CCCC00000000000E97D30015A4EC001EB7E90021A2
      E5006CD1E00087CFD90036C4E60036B3D7001DB5DD0057A5BC0025B5E1006666
      6600000000000000000000000000000000000000000000000000000000000000
      000000000000F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0A0A000808080000000000000000000000000000000
      000000000000F0CAA600FFFFFF00F0CAA600F0CAA600F0CAA600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0A08000808080000000000000999900F8F8F80099FF
      FF0099FFFF0099FFFF0099FFFF0099FFFF00F8F8F80000999900009999000099
      99000099990000999900009999000000000011ACD90046F5FF001EB7E9000B85
      D3006AE0F9006FEAF60093E1E4007AE1F00055B7D20022B4E100468AAA006666
      6600000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000F0CAA600F0FBFF00F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600A4A0A000000000000000000000000000000000000000
      000000000000C0C0C000F0CAA600FFFFFF00F0FBFF00F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600C080800000000000000000000000000000999900F8F8
      F800F8F8F800F8F8F800F8F8F800F8F8F8000099990000000000000000000000
      00000000000000000000000000000000000064B0CF006FD2E8006CE8FC0037B8
      E5003CC4EE001E97CB0031B3D70065E2F10031B3D70023A0E200407DA9006666
      6600000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F0CAA600F0FBFF00F0FBFF00F0CAA600F0CAA600F0CA
      A600F0CAA600C0C0A00000000000000000000000000000000000000000000000
      00000000000000000000F0CAA600F0FBFF00FFFFFF00F0CAA600F0CAA600F0CA
      A600F0CAA600C0A0A00000000000000000000000000000000000000000000099
      9900009999000099990000999900009999000000000000000000000000000000
      0000000000000000000000000000000000000000000064B0CF0064B0CF008CE2
      EB0065E4F80061DAF5005ECCEF003DCEED0023DBFF000EACE500666666000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0DCC000C0DCC000F0CAA600F0CAA600F0CA
      A600C0C0A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0DCC000F0CAA600F0CAA600F0CAA600F0CA
      A600C0A0A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000064B0
      CF0064B0CF0064B0CF0064B0CF0064B0CF0064B0CF0066666600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C080600080404000804040008040400080404000804040008040
      4000804040008040400080404000000000000000000080808000406060008080
      8000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0806000FFFFFF00F0FBFF00F0FBFF00F0FBFF00F0FBFF00F0CA
      A600F0FBFF00F0CAA6008040400000000000A4A0A00000000000000000004060
      6000808080000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0806000F0FBFF00F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA60080404000000000000000000040A0C0008060A0000000
      0000406060000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000404040008060
      6000000000000000000000000000404040008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000040404000808080000000000000000000000000004020
      2000A4A0A0000000000000000000000000000000000000000000000000000000
      000000000000C0806000F0FBFF00F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA60080404000000000000000000080C0E000000000000000
      0000A4A0A0000000000080606000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000040606000C0C0C000C0DC
      C000808080000000000040404000C0C0C000F0FBFF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000040404000C0C0C000F0FBFF00808080000000000040202000C0C0
      C000F0FBFF00A4A0A00000000000000000000000000080606000804040008040
      400080404000C0806000FFFFFF00F0CAA600F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA60080404000000000000000000080C0E00080C0E00040A0
      C0008060A0000000000040606000806060000000000000000000000000000000
      000000000000000000000000000000000000000000000000000040404000C0C0
      C000F0FBFF00808080000000000040404000C0C0C000F0FBFF00A4A0A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000040404000C0C0C000F0FBFF00808080000000000040202000C0C0C000F0FB
      FF00A4A0A000000000000000000000000000000000000000000000000000F0CA
      A600F0CAA600C08060000000000000000000F0CAA600F0CAA60000000000F0CA
      A600000000000000000000000000000000000000000000000000000000000000
      000040A0C0000000000080808000808080000000000040606000000000004040
      4000000000000000000000000000000000000000000000000000000000004040
      4000C0C0C000F0FBFF00808080000000000040202000C0C0C000F0FBFF00A4A0
      A000000000000000000000000000000000000000000000000000000000004040
      4000C0C0C000F0FBFF00808080000000000040202000C0C0C000F0FBFF00A4A0
      A0000000000000000000000000000000000000000000C0806000FFFFFF000000
      0000F0CAA60000000000FFFFFF00F0CAA60000000000F0CAA60000000000F0CA
      A60000000000F0CAA600806060000000000000000000000000000000000080C0
      E00080A0E00080A0C0008080800080808000A4A0A000A4A0A000A4A0A000A4A0
      A000808080008060600080606000000000000000000000000000000000000000
      000040404000C0C0C000F0FBFF00808080000000000040202000C0C0C000F0FB
      FF00A4A0A000000000000000000000000000000000000000000040404000C0C0
      C000F0FBFF00808080000000000040404000C0C0C000F0FBFF00A4A0A0000000
      00000000000000000000000000000000000000000000C0806000000000000000
      0000F0CAA60000000000FFFFFF00F0CAA60000000000F0CAA60000000000F0CA
      A60000000000F0CAA60080606000000000000000000000000000000000000000
      000080C0E00080C0C000A4A0A000C0C0A000F0CAA600F0CAA600F0CAA600F0CA
      A600C0C0C0008080800080606000804040000000000000000000000000000000
      00000000000040404000C0C0C000F0FBFF00808080000000000040202000C0C0
      C000F0FBFF00A4A0A00000000000000000000000000040606000C0C0C000C0DC
      C000808080000000000040404000C0C0C000F0FBFF0080808000000000000000
      00000000000000000000000000000000000000000000C0806000FFFFFF00F0CA
      A600F0CAA60000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000C0DC
      C00000000000C0A0A00080606000000000000000000000000000000000000000
      000000000000C0C0C000C0C0A000F0CAA600F0CAA600FFFFFF00F0FBFF00FFFF
      FF00F0FBFF00A4A0A00080606000808080000000000000000000000000000000
      000040404000C0C0C000F0FBFF00808080000000000040202000C0C0C000F0FB
      FF00A4A0A000000000000000000000000000000000000000000040404000C0C0
      C000F0FBFF00808080000000000040404000C0C0C000F0FBFF00A4A0A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F0CAA60000000000FFFFFF00FFFFFF0000000000FFFFFF0000000000C0A0
      8000000000000000000000000000000000000000000000000000000000000000
      000000000000F0CAA600F0CAA600F0CAA600F0FBFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F0FBFF0080806000406060000000000000000000000000004040
      4000C0C0C000F0FBFF00808080000000000040202000C0C0C000F0FBFF00A4A0
      A000000000000000000000000000000000000000000000000000000000004040
      4000C0C0C000F0FBFF00808080000000000040202000C0C0C000F0FBFF00A4A0
      A0000000000000000000000000000000000000000000C0806000FFFFFF00F0CA
      A600F0CAA600C0806000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C080
      6000C0A06000C080600000000000000000000000000000000000000000000000
      000000000000F0CAA600F0CAA600F0CAA600F0CAA600FFFFFF00F0FBFF00FFFF
      FF00FFFFFF00FFFFFF00A4A0A00040606000000000000000000040404000C0C0
      C000F0FBFF00808080000000000040404000C0C0C000F0FBFF00A4A0A0000000
      0000000000000000000000000000000000000000000000000000000000000000
      000040404000C0C0C000F0FBFF00808080000000000040202000C0C0C000F0FB
      FF00A4A0A00000000000000000000000000000000000C0806000FFFFFF00F0CA
      A600F0CAA600C0806000C0A0A000C0A0A000C0A0A000C0A0A000C0A0A000C080
      6000C08060000000000000000000000000000000000000000000000000000000
      000000000000F0CAA600F0CAA600F0CAA600F0CAA600FFFFFF00FFFFFF00F0FB
      FF00FFFFFF00FFFFFF00C0A0A000806060000000000040606000C0C0C000C0DC
      C000808080000000000040404000C0C0C000F0FBFF0080808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000040404000C0C0C000F0FBFF00808080000000000040202000C0C0
      C000F0FBFF00A4A0A000000000000000000000000000C0806000FFFFFF00FFFF
      FF00FFFFFF00C0C0C000C0C0C000C0C0A000C0A0A000C0808000806060000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000F0CAA600F0CAA600F0CAA600F0CAA600F0CAA600FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C0A0A000808080000000000000000000404040008060
      6000000000000000000000000000404040008080800000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000040404000808080000000000000000000000000004020
      2000A4A0A00000000000000000000000000000000000C0806000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C0A0A000C0808000C0808000C06060000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C0C0C000F0CAA600F0FBFF00F0CAA600F0CAA600F0CAA600F0CA
      A600F0CAA600F0CAA600A4A0A000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0806000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00C0806000C0806000C0806000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F0CAA600F0FBFF00F0FBFF00F0CAA600F0CAA600F0CA
      A600F0CAA600C0C0A00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C0806000C0C0C000C0C0
      C000C0C0C000C0C0C000C0C0C000C0806000C080600000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C0DCC000C0DCC000F0CAA600F0CAA600F0CA
      A600C0C0A0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000B8858500B885
      8500B8858500B8858500B8858500B8858500B8858500B8858500B8858500B885
      8500B88585000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000006E6E6E006E6E
      6E00000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFEEDA00FFF6EB00FFF0
      E800FFECD500FFE7D500FFEAD000FFE5CF00FFE5D000FFE6D100FFEDCD00FFF2
      CE00B88585000000000000000000000000000000000000000000000000000000
      000000000000C7DDC738C7DDC738000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005F6172005F61720065688200656882005F6172000000
      00000000000000000000000000000000000000000000795FEA002900DF003F28
      A600656565000000000000000000000000000000000000000000000000000000
      00006250B2002E07D800000000000000000000000000FFE3DC00F7C18C00E491
      3A00EFB98C00ECAD7900ECAD7900F9B17600F5A56400EDA66800DA812B00FFEB
      D100B88585000000000000000000000000000000000000000000000000000000
      0000C7DDC738006600FF006600FFC7DDC7380000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000656882004553B9001F35DB000E24CC000A1EB7004652B00064698B006A6A
      6A005F61720000000000000000000000000000000000795FEA002900DF00300A
      DB00534E6A006565650000000000000000000000000000000000000000004629
      C3002900DF005A46B600000000000000000000000000FFEADE00F9C89F00E89A
      4A00F6C79900F2BF8E00FEC69800483532006698B600DCA08300DF8B3D00FFE8
      D400B8858500000000000000000000000000000000000000000000000000C7DD
      C738006600FF1EB231FF1FB133FF006600FFC7DDC73800000000000000000000
      0000000000000000000000000000000000000000000000000000000000006568
      8200122BEB00142EF500142EF500142EF500142EF500132DF0000E24CC004A56
      AA00656882006568820000000000000000000000000000000000795FEA002900
      DF003D1CD2005F5F5F00000000000000000000000000000000003A18CD002E07
      D8005A46B60000000000000000000000000000000000FFE9DD00FFE1CD00FACF
      AD00F6C49900F4C19500F6C08A00ECAF7E00B2A08A00FFDDAD00C1835800FFEE
      DB00B88585000000000000000000000000000000000000000000C7DDC7380066
      00FF31C24FFF22B738FF1AB02DFF21B437FF006600FFC7DDC738000000000000
      0000000000000000000000000000000000000000000000000000142EF500142E
      F500142EF500223BF5000F26D6000F26D6000E25D100142EF500142EF5000F26
      D6004F5AA7006D6D6D0000000000000000000000000000000000000000007A60
      EB002900DF005238C3006464640000000000000000003A18CD002E07D8005A46
      B6000000000000000000000000000000000000000000FFF4EA00FBD0A900F2A9
      5C00FFF0F100FFE9E200FFEAE500FFEEDB00F1D4C700DAB8AE00FFDEBB00EC9B
      52004639410000000000000000000000000000000000C7DDC738006600FF47D3
      6DFF3BCB5EFF25A83BFF006600FF1BA92EFF1DB132FF006600FFC7DDC7380000
      0000000000000000000000000000000000000000000000000000142EF500142E
      F500142EF50000000000000000000000000000000000223AF500142EF500142E
      F5000D22C6005F61720065688200000000000000000000000000000000000000
      00007A60EB002900DF005137C30053505E003312C7002C06D7005A46B6000000
      00000000000000000000000000000000000000000000FFF2E600FFEADB00FCD8
      BB00F9CFA900F9C89F00F7CBA200F5C29700F6C29600F9C39200C5A28D00ECD3
      C200FFB97C000D0000000000000000000000C7DDC738006600FF4FD679FF53DE
      7FFF31B54DFF006600FFC7DDC738006600FF179D27FF1EAE31FF006600FFC7DD
      C7380000000000000000000000000000000000000000142EF500142EF5000F26
      D60000000000000000000000000000000000223AF500132DF000142EF500142E
      F500122BEB005760A5005F617200000000000000000000000000000000000000
      000000000000795FEA002900DF002C06D7002B05D6006A628C00000000000000
      00000000000000000000000000000000000000000000FFFDF300FFDBBC00FBBE
      8100FCD9BB00FCD5B400FAD1AD00F8CEA800F6C59D00F7C9A300F6B47000C79E
      9C00F3D1BF00FFDB9800534538000000000000000000C7DDC738006600FF41C5
      63FF006600FFC7DDC7380000000000000000C7DDC738006600FF19AA2BFF0066
      00FFC7DDC73800000000000000000000000000000000233BF600142EF5000F26
      D600000000000000000000000000223AF500132DF000233BF600000000000F26
      D600142EF5004553B90065688200000000000000000000000000000000000000
      000000000000000000002F08D9002900DF00472BC4006A628C00000000000000
      00000000000000000000000000000000000000000000FFFFF400FFDEC200FCC1
      7A00FDD9BB00FDD9B800FBD4B000FCD2AE00FACFA900FBCCA600F3B47500FFFD
      EE006B413D00E5C0A20091C1FF00091351000000000000000000C7DDC7380066
      00FFC7DDC73800000000000000000000000000000000C7DDC7384A924AB5149D
      21FF006600FFC7DDC738000000000000000000000000142EF500142EF5000F26
      D6000000000000000000223AF500142EF500233BF60000000000000000000F26
      D600142EF5005561BF0065688200000000000000000000000000000000000000
      0000000000003A18CD002E07D8005A46B600360FE000593DD6006A628C000000
      00000000000000000000000000000000000000000000FFFEF000FFFDFD00FFF7
      F700FFFCFC00FFF2EF00FFF2EE00FFF2EE00FFEEE800FFEBE400FFEBE400FFF5
      E700B88585002C221B00151D4A0026242A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E3EEE31CC7DD
      C738006600FF006600FFC7DDC7380000000000000000142EF500142EF5000E25
      D10000000000223AF500142EF500233BF6000000000000000000000000000F26
      D600142EF5005763BC0000000000000000000000000000000000000000000000
      00003A18CD002900DF005A46B6000000000000000000431FE2004A28DD006A62
      8C000000000000000000000000000000000000000000FFFFF900FFFDFC00FFFC
      FB00FFF7F200FFF9F500FFF4EE00FFEDE400FFF0EA00FFEEE700FFE9DE00FFFD
      F100B88585000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C7DDC738006600FF006600FFC7DDC73800000000142EF500142EF500142E
      F500223AF500132DF000233BF60000000000000000000000000000000000142E
      F500132DF0006568820000000000000000000000000000000000000000003917
      CC002900DF005A46B600000000000000000000000000000000005F40E700350E
      DF006A628C0000000000000000000000000000000000FFFFF700FFFFFF00FFFA
      F800FFFBFA00FFF7F200FFF5F100FFFAF700FFEEE600FFF0E900FFFEFF00FFFF
      FF00B88585000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C7DDC738000000000000000000000000142EF500142E
      F500142EF500132DF00000000000000000000000000000000000233BF600142E
      F500142EF50000000000000000000000000000000000000000003917CC002900
      DF005A46B6000000000000000000000000000000000000000000000000005F40
      E7002900DF0000000000000000000000000000000000FFFFFD00FFFFFF00FFFF
      FF00FFFFFF00FFFBF800FFFCFA00FFF7F200FFFBF900FAE5D400EE986200FE90
      5F006C5655000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000142EF500142E
      F500142EF5000F26D6000F26D6000C21C1000F26D600142EF500142EF500142E
      F5000000000000000000000000000000000000000000411DE0002900DF004629
      C300000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFBF900FFFAF700F0DCD300FFBB4400CF9A
      5200000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000142E
      F500142EF500142EF500142EF500142EF500142EF500142EF500142EF5000000
      000000000000000000000000000000000000000000003610E1004D2CE1000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFDEE00D0B08B000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000142EF500142EF500142EF500142EF50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FDCFA100FDCFA100FDCF
      A100FDCFA100FDCFA100FDCFA100FDCFA100FDCFA100FDCFA100000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000054B082C7309F68F0309F68F054B082C7000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000080808000808080008080800000000000000
      0000000000000000000000000000000000000000000000000000000000000808
      0800080808000808080000000000000000000000000000000000000000000808
      0800080808000808080000000000000000000000000000000000000000000000
      00002E9E66F3249A5FFF249A5FFF249A5FFF249A5FFF249A5FFF249A5FFF2E9E
      66F3000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000808080008080800ADAEAD0008080800080808000000
      0000000000000000000000000000000000000000000000000000080808000808
      0800ADAEAD000808080008080800000000000000000000000000080808000808
      0800ADAEAD00080808000808080000000000000000000000000000000000249A
      5FFF249A5FFF249A5FFF249A5FFF249A5FFF249A5FFF249A5FFF249A5FFF249A
      5FFF249A5FFF0000000000000000000000000000000000000000000000000000
      0000000000000000000003760700037607000376070003760700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000808080008080800ADAEAD00FFFFFF00ADAEAD00080808000808
      080000000000000000000000000000000000000000000000000008080800ADAE
      AD00FFFFFF00ADAEAD000808080008080800000000000808080008080800ADAE
      AD00FFFFFF00ADAEAD0008080800000000000000000000000000269D62FF269D
      62FF269D62FF269D62FF269D62FF269D62FF269D62FF269D62FF269D62FF269D
      62FF269D62FF269D62FF00000000000000000000000000000000000000000000
      000000000000000000000376070018A430001AB3330003760700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000808080008080800ADAEAD00FFFFFF00ADAEAD00FFFFFF00ADAEAD000808
      0800080808000000000000000000000000000000000000000000080808000808
      0800ADAEAD00FFFFFF00ADAEAD00080808000808080008080800ADAEAD00FFFF
      FF00ADAEAD000808080008080800000000000000000033A36CF3299F65FF299F
      65FF299F65FF299F65FF51AF81FFF9FBFAFF51AF81FF299F65FF299F65FF299F
      65FF299F65FF299F65FF33A36CF3000000000000000000000000000000000000
      00000000000000000000037607001DA93A0020B9400003760700000000000000
      0000000000000000000000000000000000000000000000000000000000000808
      080008080800ADAEAD00FFFFFF00ADAEAD0008080800ADAEAD00FFFFFF00ADAE
      AD00080808000808080000000000000000000000000000000000000000000808
      080008080800ADAEAD00FFFFFF00ADAEAD0008080800ADAEAD00FFFFFF00ADAE
      AD0008080800080808000000000000000000000000002DA36AFF2DA36AFF2CA3
      69FF2DA36AFF54B385FFF0F7F4FFF8FBFAFFEFF6F3FF44AD7AFF2DA36AFF2DA3
      6AFF2DA36AFF2DA36AFF2DA36AFF000000000000000000000000000000000000
      000000000000000000000376070021AE430026BF4D0003760700000000000000
      0000000000000000000000000000000000000000000000000000080808000808
      0800ADAEAD00FFFFFF00ADAEAD00080808000808080008080800ADAEAD00FFFF
      FF00ADAEAD000808080008080800000000000000000000000000000000000808
      08000808080008080800ADAEAD00FFFFFF00ADAEAD00FFFFFF00ADAEAD000808
      0800080808000808080000000000000000005FBB8EC731A76EFF31A76EFF31A7
      6EFF58B789FFF7FAF9FFEDF6F2FFC6E1D4FFF2F8F6FFEDF6F1FF47B07DFF31A7
      6EFF31A76EFF31A76EFF31A76EFF000000000000000000000000037607000376
      070003760700037607000376070029B953002EC75D0003760700037607000376
      070003760700037607000000000000000000000000000000000008080800ADAE
      AD00FFFFFF00ADAEAD000808080008080800ADAEAD000808080008080800ADAE
      AD00FFFFFF00ADAEAD0008080800000000000000000000000000080808000808
      0800ADAEAD000808080008080800ADAEAD00FFFFFF00ADAEAD00080808000808
      0800ADAEAD0008080800080808000000000041B07DF035AB74FF31A76EFF69BE
      95FFFCFDFDFFDCEEE5FF68BC94FF35AB74FF5BB98DFFF5F9F7FFE6F4EEFF4CB5
      84FF35AB74FF36AC75FF36AC75FF40AF7CF00000000000000000037607004DE5
      800048E17B0040D973003BD46E003BD46E0032CB64002DBF590021AD42001DA9
      3A0016A22B000376070000000000000000000000000000000000080808000808
      0800ADAEAD000808080008080800ADAEAD00FFFFFF00ADAEAD00080808000808
      0800ADAEAD00080808000808080000000000000000000000000008080800ADAE
      AD00FFFFFF00ADAEAD000808080008080800ADAEAD000808080008080800ADAE
      AD00FFFFFF00ADAEAD00080808000000000047B381F03CAF7AFF31A76EFFF4F9
      F7FF8FCFB0FF32A86FFF31A76EFF31A76EFF31A76EFF58B789FFF6F9F8FFE3F2
      EBFF47B07DFF3CAF7AFF3CAF7AFF47B381F000000000000000000376070055ED
      88004DE5800048E17B0040D973003BD46E0032CB64002EC75D0026BF4D001FB8
      3D001AB333000376070000000000000000000000000000000000000000000808
      08000808080008080800ADAEAD00FFFFFF00ADAEAD00FFFFFF00ADAEAD000808
      0800080808000808080000000000000000000000000000000000080808000808
      0800ADAEAD00FFFFFF00ADAEAD00080808000808080008080800ADAEAD00FFFF
      FF00ADAEAD000808080008080800000000006AC39BC742B481FF35AB74FF36AC
      75FF35AB74FF36AC75FF35AB74FF35AB74FF36AC75FF35AB74FF5CBA8EFFF8FA
      FAFFCDE9DCFF41B380FF41B380FF6AC39BC700000000000000000C7812000376
      070003760700037607000370060040D9730038D16B0003700600037006000370
      0600037006000370060000000000000000000000000000000000000000000808
      080008080800ADAEAD00FFFFFF00ADAEAD0008080800ADAEAD00FFFFFF00ADAE
      AD00080808000808080000000000000000000000000000000000000000000808
      080008080800ADAEAD00FFFFFF00ADAEAD0008080800ADAEAD00FFFFFF00ADAE
      AD00080808000808080000000000000000000000000048B886FF48B886FF48B8
      86FF48B886FF48B886FF48B886FF48B886FF48B886FF48B886FF48B886FF76C8
      A4FFEFF6F3FF48B886FF48B886FF000000000000000000000000000000000000
      000000000000000000000370060047E07A0040D9730003700600000000000000
      0000000000000000000000000000000000000000000000000000080808000808
      0800ADAEAD00FFFFFF00ADAEAD00080808000808080008080800ADAEAD00FFFF
      FF00ADAEAD000808080008080800000000000000000000000000000000000000
      00000808080008080800ADAEAD00FFFFFF00ADAEAD00FFFFFF00ADAEAD000808
      0800080808000000000000000000000000000000000056BF91F34EBC8CFF4EBC
      8CFF4EBC8CFF4EBC8CFF48B886FF48B886FF4EBC8CFF4EBC8CFF4FBD8DFF4EBC
      8CFF4EBC8CFF4EBC8CFF56BF91F3000000000000000000000000000000000000
      00000000000000000000037006004DE5800045DE780003700600000000000000
      000000000000000000000000000000000000000000000000000008080800ADAE
      AD00FFFFFF00ADAEAD000808080008080800000000000808080008080800ADAE
      AD00FFFFFF00ADAEAD0008080800000000000000000000000000000000000000
      0000000000000808080008080800ADAEAD00FFFFFF00ADAEAD00080808000808
      080000000000000000000000000000000000000000000000000055C092FF54C0
      91FF55C092FF54C091FF4EBC8CFF4EBC8CFF54C091FF54C091FF55C092FF54C0
      91FF54C091FF55C092FF00000000000000000000000000000000000000000000
      000000000000000000000370060052EB85004DE5800003700600000000000000
      0000000000000000000000000000000000000000000000000000080808000808
      0800ADAEAD000808080008080800000000000000000000000000080808000808
      0800ADAEAD000808080008080800000000000000000000000000000000000000
      000000000000000000000808080008080800ADAEAD0008080800080808000000
      0000000000000000000000000000000000000000000000000000000000005BC3
      97FF5BC397FF5BC397FF5BC397FF5CC498FF5BC397FF5BC397FF5CC498FF5BC3
      97FF5BC397FF0000000000000000000000000000000000000000000000000000
      0000000000000000000003700600037006000370060003700600000000000000
      0000000000000000000000000000000000000000000000000000000000000808
      0800080808000808080000000000000000000000000000000000000000000808
      0800080808000808080000000000000000000000000000000000000000000000
      0000000000000000000000000000080808000808080008080800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000067C89FF360C69BFF60C69BFF60C69BFF61C79DFF61C79DFF61C79DFF67C8
      9FF3000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000087D4B4C76FCCA5F06FCCA5F086D4B4C7000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000808080008080
      8000808080008080800080808000808080008080800080808000808080008080
      800080808000808080008080800000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F0FBFF00C0C0C000F0FB
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000071717100717171007171
      71006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D0000000000000000000000
      0000000000000000000000000000000000000000000000808000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000008080800080808000FFFFFF00C0C0C000C0C0C000C0DC
      C000FFFFFF00FFFFFF00C0C0C000808080008080800000000000402020008080
      8000C0C0C000C0C0C000C0C0C000F0FBFF000000000000000000000000000000
      0000000000002C2C6C0005056300000065000000600000004F00000000000000
      0000000000000000000000000000000000006D6D6D00B1654D008C5036008C50
      36008C5036008C5036006C554C006A635F00717171006D6D6D006D6D6D006D6D
      6D006D6D6D0071717100717171006D6D6D000080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000080808000C0C0C00000000000404040004040
      4000A4A0A000FFFFFF0040404000000000000000000040606000C0C0C000C0C0
      C000000000000000000040202000C0C0C0000000000000000000000000002929
      AC000000840000008E0000008E0000008F0000008C0000008800000081000101
      540000000000000000000000000000000000E0664200DC513100F9635000FD72
      5C00F1684E00D7744500F1684E00D24C270035593800355938002F982D004890
      37002F982D0025662500355938006D6D6D000080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0080808000000000008080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000080808000A4A0A00040202000A4A0A0004020
      200080606000C0DCC00000000000C0C0C000C0C0C00040202000A4A0A000C0DC
      C000000000008060600040606000C0C0C00000000000000000002929AC000000
      96000000970000009B0000009F000000A00000009D000000970000008F000000
      880000006200000000000000000000000000D5885500F9635000FD7C6400FC8B
      6D00D5885500FFCF9C00F36D5300FD6A5700917930004DB34D006AA9660063CA
      630052C252003CB73C00239023006D6D6D000080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0080808000000000008080800000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF000000000000000000FFFFFF00C0DCC000808080004040
      4000404040004040400080808000FFFFFF00FFFFFF00C0C0C00040404000A4A0
      A00000000000A4A0A000FFFFFF00FFFFFF00000000002929AC000101A3000808
      9E009999D4006868D0000000AC000000AE000000A9004848B800B7B7E3002727
      A50000008C0001015200000000000000000000000000E0664200FD846900EB80
      5900FFCF9C00FFCF9C00EF765600FD6B580080AB670080B38000FFEFDF004DB3
      4D0075D275004FC14F00489037006D6D6D00000000000080800000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00000000008080800000000000FFFFFF0080606000402020000000
      0000806060000000000080808000FFFFFF00FFFFFF00C0DCC000402020008080
      800000000000A4A0A000FFFFFF00FFFFFF00000000002929AC000000AB002828
      A300DEDED200FEFEFF006464D4000000B3004646C000E7E7EC00FFFFF7005E5E
      B70000009A000202870000000000000000000000000000000000B1654D004C21
      4F002E3457007F4C6E00B1654D00917930007CD77C008FE08F00FFF7E800BFD9
      AC005BC55B0044A644000000000000000000000000000080800000FFFF0000FF
      FF0000FFFF0000FFFF0000FFFF000000000000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF00000000000000000000000000F0FBFF0000000000402020008060
      6000F0FBFF004020200080808000FFFFFF00FFFFFF00A4A0A00040404000C0C0
      C00000000000A4A0A000FFFFFF00FFFFFF004B4BD3000707B1000303B9000000
      C2004C4CA700E6E6D900FCFCFF009E9EE600E8E9F400FFFFF1007575B9000606
      B1000101AB000202A00013145D0000000000000000001717170005070E000D29
      6800143AA000102F9500081D6C00545454006AA96600427399001579BA00247D
      B600377D57004D4D4D00000000000000000000000000000000000080800000FF
      FF0000FFFF0000FFFF0000808000000000000080800000FFFF0000FFFF0000FF
      FF0000000000808080000000000000000000C0DCC00040202000A4A0A0008060
      6000C0C0C000C0C0C00040404000A4A0A000C0C0C00040202000C0DCC000C0C0
      C00000000000A4A0A000FFFFFF00FFFFFF004B4BD3000808BB000707C8000505
      D1000000C8005353B600F2F2ED00FFFFFF00FFFFFC007575C9000000BE000101
      C3000303B8000303AC0010106F00000000003F3F3F001A1A1A00102C5B001A4D
      B3001C56BC001B51B700102F950054545400699AAE002C92F1003399FF003399
      FF002C92F1002C586F00848484000000000000000000000000000080800000FF
      FF0000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF0000FF
      FF0000000000000000000000000000000000FFFFFF0040202000404040000000
      0000C0DCC000F0FBFF0000000000806060004040400000000000FFFFFF00C0C0
      C00040202000C0C0C000FFFFFF00FFFFFF004B4BD3000C0CC9000D0DD8000B0B
      DC000000D6003C3DCE00EEEFED00FFFFFF00FFFFFD005858DB000000CA000303
      CB000606C5000606B800121279000000000012121200282828000F2D93002774
      DA002671D7002671D7001E5AC0005A6064003F95C30040A6FF0040A6FF0040A6
      FF003DA2FF002385C6006D6D6D00000000000000000000000000000000000080
      800000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      000080808000000000000000000000000000FFFFFF00FFFFFF00F0FBFF00FFFF
      FF0080A0C00040406000C0C0C000C0C0C000C0C0C000FFFFFF0040606000C0C0
      C000FFFFFF00FFFFFF00FFFFFF00FFFFFF004B4BD3001414D8001717EA000B0B
      F1004343DB00E4E4EA00FDFDF500BABAD400EAEAE800FEFEFF006363E5000303
      D7000A0ACF000A0AC30021217F00000000002C2C2C00363636002C586F003191
      F9003399FF003694F700246AD0005A606400479FD0004BB1FF004BB1FF004DB3
      FF0049AFFF002D92E60066666600000000000000000000000000000000000080
      800000FFFF0000FFFF0000000000000000000000000000FFFF0000FFFF000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF004040A00040408000002080004040800040404000C0C0C000002060008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF004B4BD3002626E5002222FB003F3F
      E900DCDCE500FDFDEE007373C5000303D7005151B000E3E3D600FFFFFE006161
      E5000808DB000F0FCA0012127900000000006D6D6D004A4A4A003F3F3F004646
      4600143FA4002060C600135F88007E7E7E0057A9D7004DB3F2004DB3F20055BB
      FF0051B7FF0043A8ED006D6D6D00000000000000000000000000000000000000
      00000080800000FFFF0000FFFF000000000000FFFF0000FFFF00000000008080
      800000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF008060A0008060800000208000000080004040A00040606000000080008080
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000003131FB003232FF005252
      ED00B3B3C2007777CA000000EA000000EC000000E8005252B400ADADB0004D4D
      E1001818ED001818B10000000000000000000000000038383800666666008F8F
      8F00A4A4A4004D4D4D00464646000000000063ABD200247DB60057A9D70063AB
      D200479FD0001372A200699AAE00000000000000000000000000000000000000
      00000080800000FFFF0000FFFF0000FFFF0000FFFF0000FFFF00000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00F0FBFF00F0FBFF004040A000002080008080800040208000002060008060
      A000FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000003131FB003E3EFB005353
      FF006868EF005757F9003838FF002525FD002929FF003838FC004242EB003232
      FF001F1FE9003131FB00000000000000000000000000000000006D6D6D00605E
      5E00605E5E00666666000000000000000000000000003A8BB70084C0E400A3D0
      EA00479FD000699AAE0000000000000000000000000000000000000000000000
      0000000000000080800000FFFF0000FFFF0000FFFF0000000000808080000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF008080C0000020A000C0C0C00040406000002080008060
      8000FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000003131FB004949
      FD006E6EFF009191FF009393FF008484FF007676FF006767FF005151FF003131
      FB003131FB000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003A8BB7003A8B
      B7003A8BB7000000000000000000000000000000000000000000000000000000
      0000000000000080800000FFFF0000FFFF0000FFFF0000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004040A0004020A0008080
      A000FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000003131
      FB003131FB006969FE008787FF009292FF007676FF005353FF005151F3003131
      FB00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000808000008080000080800000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0DCC000F0FB
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      0000000000003131FB003131FB003131FB003131FB003131FB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000070707000585858005858580058585800707070000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007979A000363675002B2B3D004D4D4D005858580036365900232367005B5B
      7600000000000000000000000000000000000000000000000000000000000000
      0000000000007979790083838300797979000000000000000000000000007979
      7900797979007979790000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000004B5000004B5000000000070707000585858005858
      5800585858000176A9000171A3000171A3000275A800016FA200404040005858
      5800585858005858580058585800585858000000000070707000585858005858
      580041418D002727DE001D1DA90002365700084680002727E0002424BA004343
      5400585858005858580058585800585858000000000000000000000000000000
      0000797979004E4E4E00535353009B9B9B00797979006B6B6B006C5A5A00755D
      5D004F4848005E5E5E007979790000000000000000000004B5000004B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000004B5000004B500000000002626260026262600262626002626
      26002626260015ADD9002BC1EB002AB8DF0028C0EA00057EAF00262626002626
      2600262626002626260026262600404040002626260026262600262626002626
      2600262626002169D9002C2DE1002129A800282ACB00282FD5001E1D2E002626
      2600262626002626260026262600404040000000000000000000000000000000
      0000AF927500DF8D3A0069503C0054546F000732DE001538C700D6B8B800B7AB
      AB009D8C8C006B575700524C4C0079797900000000000004B5000004B5000004
      B500000000000000000000000000000000000000000000000000000000000000
      00000004B5000004B500000000000000000099999900FFF1DF00FFF1DF00FFF1
      E000FFF1E00032ADD500BBE5EF00CDF7FF00AFE4F200198FBD00FFF1DF00FFF1
      DF00FFF1DF00FFF1DF00262626005858580099999900FFF1DF00FFF1DF00FFF1
      E000FFF1E00032ACD500606FDD003332F3003433EE0015437C00FFF1DF00FFF1
      DF00FFF1DF00FFF1DF0026262600585858000000000000000000000000000000
      0000AF927500DF8D3A00825D4D007E6B8E001257FF002667E300D3AAAA00AA80
      8000A78A8A0098BD9D007F756E006A6A6A00000000000004B5000004B5000004
      B5000004B5000000000000000000000000000000000000000000000000000004
      B5000004B5000000000000000000000000009999990099999900999999009999
      9900999999004DB6D800DAEBEF00FFFFFF00D4EEF5001590BE00999999009999
      9900999999009999990099999900000000009999990099999900999999009999
      99009999990049AAD1006167DC004F4FFF003F3DF500152F7600737373009999
      9900999999009999990099999900000000000000000000000000000000000000
      0000AF927500DE8A3700BCA09300ABA0C0001B69FF003377E000D6B3B300B893
      9300A1727200A07272007F5E5E006A6A6A0000000000000000000004D6000004
      BD000004B5000004B500000000000000000000000000000000000004B5000004
      B500000000000000000000000000000000000000000000000000000000000000
      00000000000025A7D20040B1D80048B0D2002B9FC60044A6C800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002656AD005455FD00546AD4005462F0004444F100424269000000
      0000000000000000000000000000000000000000000083838300838383008383
      8300AF927500D97D2600B2857D00A289A700257EFF004187DE00DBBFBF00BD91
      9100CC999900BD8B8B00815B5B006A6A6A000000000000000000000000000000
      00000004B5000004B5000004B500000000000004B5000004B5000004B5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000082828200AAA195001414140038383800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005C5CFF005C5CFF005A59BE0098908B00222246005D5DEB004D4DDC000000
      00000000000000000000000000000000000026A0D30032698200266079002662
      7C0093867000DB7E2B00B39D9800AFA8C4002E8FFF005199DC00DBBFBF00BE8F
      8F00A6737300BC898900825A5A006A6A6A000000000000000000000000000000
      0000000000000004B5000004C6000004C6000004CE000004B500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000929292004F4F4F008E828100332F2F001D1D1D00535353008888
      8800000000000000000000000000000000000000000000000000000000000000
      000000000000929292004F4F4F008E828100332F2F001D1D1D00535353007171
      71000000000000000000000000000000000026A0D30069CFFF0069CFFF0069CF
      FF00A1805E00DC7E30008F8C8C00BDB6C9009AB3D40054648E00DBBFBF00BF8D
      8D00B6838300B9868600825858006A6A6A000000000000000000000000000000
      000000000000000000000004C6000004C6000004DE0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008080
      8000747474008C8C8C00A5A5A500746F6F003E3B3B0048434300574E4E004E4B
      4B00555555007171710000000000000000000000000000000000000000008080
      8000747474008C8C8C00A5A5A500746F6F003E3B3B0048434300574E4E004E4B
      4B0055555500717171000000000000000000329BC7007EDBFF0067BAD90074DA
      FF00817C7200A28F8700B2AFAF00C9C3C300E0DEDF00BEB9BA00C6ADAD00C282
      8200BA7A7A00BC878700835656006E6E6E000000000000000000000000000000
      0000000000000004B5000004D6000004CE000004DE000004EF00000000000000
      000000000000000000000000000000000000000000008888880088888800C9C9
      C900A3A3A3007F7F7F00828282007C7B7B004D4D4D00707070007C7C7C00736D
      6D007464640056505000515151007A7A7A00000000008888880088888800C9C9
      C900A3A3A3007F7F7F00828282007C7B7B004D4D4D00707070007C7C7C00736D
      6D007464640056505000515151007A7A7A004AB3D40083B8CC00E1E1E100B49B
      9B005E636500A1A1A100B6B4B400DFDFDF00D6D6D600DDDEDE00C6C4C400F0DA
      DA00DEA8A800CE7C7C00975C5C00929292000000000000000000000000000000
      00000004E7000004DE000004D60000000000000000000004E7000004EF000000
      000000000000000000000000000000000000A5A5A500AEAEAE00989898008282
      8200A4A4A400B9B9B900D1D1D1008E8E8E00787878006B6B6B00818181006161
      610033333300B79898008A7676006A6A6A00A5A5A500AEAEAE00989898008282
      8200A4A4A400B9B9B900D1D1D1008E8E8E00787878006B6B6B00818181006161
      610033333300B79898008A7676006A6A6A0065C8E2008AABBB00CFCFCF00D4D4
      D40073737300AEAEAE00BABABA00B2B2B2009C9A9A00A8A3A300AFADAD00DDC0
      C000CAABAB00B390900092929200000000000000000000000000000000000004
      FF000004DE000004EF00000000000000000000000000000000000004FF000004
      F700000000000000000000000000000000009F9F9F009C9C9C00B5B5B500C7C7
      C700E1E1E100E6E6E600D0D0D000D8D8D800D1D1D100C3C3C3009A9999007C77
      77004542420093808000847575007C7C7C009F9F9F009C9C9C00B5B5B500C7C7
      C700E1E1E100E6E6E600D0D0D000D8D8D800D1D1D100C3C3C3009A9999007C77
      77004542420093808000847575007C7C7C0078D3ED0087C0DA00B3DFE100AAC3
      C400AEC7C8009AB3B40097B0B1008DC0C2008999990089999C00928989009292
      92000000000000000000000000000000000000000000000000000004F7000004
      F7000004FF000000000000000000000000000000000000000000000000000004
      F7000004F700000000000000000000000000B9B9B900D3D3D300DEDEDE00C7C7
      C700E1E1E100DFDFDF00F2F2F200FCFCFC00ECECEC00DFDFDF00F7F7F700EEEA
      EA00DECCCC008F8A8A008D888800000000009F9F9F00D3D3D300DEDEDE00C7C7
      C700E1E1E100DFDFDF00F2F2F200FCFCFC00ECECEC00DFDFDF00F7F7F700EEEA
      EA00DECCCC008F8A8A008D8888000000000087D8EF0073D3FC009AE6FF009DEA
      FF009DEAFF009DEAFF009DEAFF009DEAFF009DEAFF00ADDCE800929292000000
      000000000000000000000000000000000000000000000004F7000004F7000004
      F700000000000000000000000000000000000000000000000000000000000000
      0000000000000004F7000000000000000000B9B9B900B9B9B900BABABA007878
      78006B6B6B00B8B8B800F2F2F200FCFCFC00ECECEC00DFDFDF00F7F7F700CACA
      CA00C0C0C000B9B9B9000000000000000000000000009F9F9F009F9F9F007878
      78006B6B6B00B8B8B800F2F2F200FCFCFC00ECECEC00DFDFDF00F7F7F7009F9F
      9F009F9F9F009F9F9F0000000000000000009DDFF00084EAFF0084EAFF0084EA
      FF00B8EDFC009FDEF1009FDEF1009FDEF1009FDEF100AAD5E300000000000000
      0000000000000000000000000000000000000004F7000004F7000004F7000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000B9B9
      B900B9B9B900C8C8C800D5D5D500E6E6E600CDCDCD00D3D3D300B9B9B9000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F009F9F9F000000
      000000000000000000000000000000000000BEE5F200AAE3F200A3E3F200AAE3
      F20095CDE0000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000004F7000004F700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      0000000000005346450053464500534645005346450053464500534645000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000085695E008F6F5B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5756B0073414200734142007341420073414200734142007341
      420073414200734142007341420000000000FFFFFF008596DC000F30B5001636
      B8001A39B8001A39B7001839BB001739B9001337BD000D35C0000A32C000072F
      BE00022CC0000026B6007F90D100FFFFFF00000000000000000000000000B58E
      7B00B5928400F7E3D600EFE3DE00EFE3DE00F7E7DE00F7E3D600BDA69C005346
      4500534645000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000966B4B00CE9F6F00AB784D0085695E000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5756B00FFFBE700F7EFDE00F7EBD600F7EBD600F7EBD600F7E7
      CE00F7EBD600EFDFC6007345420000000000FFFFFF001138D4001F44D9002A4D
      DA002F51DA002E51DB002C51DB002951DC00244FDF001C4BE0001547E0000D42
      E000053AE0000132D7000026B500FFFFFF000000000000000000BDA69C00F7E7
      DE00FFF3F700E7DBD600DEB29C00D6A68C00E7C7BD00EFEBEF00F7F3F700F7E3
      D600E7CBBD005346450000000000000000000000000000000000000000000000
      00000000000000000000966B4B00CAAA8700FFF7C4009463410085695E000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000A5756B00F7EFDE00F7DBBD00F7D7BD00F7D7BD00EFD7B500EFD3
      B500EFDBBD00E7D3BD007345420000000000FFFFFF001941DE002C50E1003759
      E3004464E5007E94ED00E2E8FB00FFFFFF00FFFFFF00DCE4FB007192F100134B
      E9000A43E8000439E000022BBE00FFFFFF0000000000BDA69C00F7EBE700FFFF
      FF00C68E7300BD5D2900BD5D2900DEB29C00BD5D2900BD5D2900D69E8400F7F3
      F700F7E7DE00D6C7BD0053464500000000000000000000000000000000000000
      0000937565008A644C00E7CAA800FFDCB300FFDCB300AF87640055280E006844
      360085695E000000000000000000000000000000000000000000000000000000
      000000000000A5756B00FFEFDE00FFC79400FFC79400FFC79400FFC79400FFC7
      9400FFC79400E7D3BD007345420000000000FFFFFF002248DF00385AE3004363
      E400A2B2F200FFFFFF00BBC8F600728FEE006F8FEF00BACAF800FFFFFF0098B1
      F6000E48E900083EE100052EC100FFFFFF0000000000BDA69C00FFFFFF00CE6D
      4200BD5D2900BD5D2900C6A29400FFFFFF00E7825200BD5D2900BD5D2900D696
      7300FFFBF700F7E3D60053464500000000000000000000000000BAA79D00BAA7
      9D00D2B69900E7CAA800FDE4BF00FFE9C700FFF8D100F5D6B300D8B89300AD89
      64005E2F150085695E00000000000000000000000000A5756B00734142007341
      420073414200A5756B00FFF7E700F7DBBD00F7D7B500F7D7B500F7D7B500F7D3
      AD00F7DFC600E7D3C60084514A0000000000FFFFFF002C51E1004261E4008B9E
      EE00FFFFFF008398EE004669E6004066E7003763E8002C5DE9007294F100FFFF
      FF006B8DF0000F43E1000B33C100FFFFFF00BDA69C00FFFBFF00DE9E7B00BD5D
      2900CE653100CE653100CE693900D68A6300CE653100CE653100BD5D2900BD5D
      2900E7CBBD00F7EFEF00DECBC6005346450000000000C9B6A700E8DBC700EDD5
      B800FFEBCC00F8D6B700C0704F00E9956300DD8D5C00DFA67B00FFE7C300F4D6
      B100D7B6940073472900896F65000000000000000000A5756B00FFFBE700F7EF
      DE00F7EBD600A5756B00FFF7EF00FFDBBD00FFDBBD00FFDBB500F7D7B500F7D7
      B500F7DFC600E7D7C60084514A0000000000FFFFFF003558E2004B68E500EBEF
      FC00BBC6F5004E6DE600496AE600FFFFFF00FFFFFF002D5CE8002456E800B6C7
      F800DBE3FB001848E0001238C200FFFFFF00D6C7BD00FFF7F700C6613100BD5D
      2900CE653100BD5D2900CE866300F7E7DE00D6693900BD5D2900CE653100BD5D
      2900CE714200FFFFFF00E7CBBD0053464500CBB8A200E8DBC700EED8C100FFEF
      D100FFEECF00FFFFE200B4816200790000008F2E0600F7E5C400FFEDCB00FFE7
      C300F5D7B700DABD9B005B2D14000000000000000000A5756B00F7EFDE00F7DB
      BD00F7D7BD00A5756B00FFFBF700FFC79400FFC79400FFC79400FFC79400FFC7
      9400FFC79400EFDFCE008C5D5A0000000000FFFFFF003F5FE400536FE700FFFF
      FF008195ED00506DE6004868E500FFFFFF00FFFFFF002C58E6002352E6006587
      EE00FFFFFF001F4CDF00183CC000FFFFFF00D6C7BD00F7DFD600BD5D2900CE65
      3100CE653100BD5D2900D6825200FFFBFF00E7AE9400BD5D2900BD5D2900CE65
      3100BD5D2900FFEFEF00F7DFD60053464500C5B2A000E8DBC700FFF0D700FFEC
      D200FFE7CE00FFFFED00CFB295006F000000A4583700FFFFF000FFE7C900FFE5
      C600FFEAC900FCE3C500AD8A6B0090766D0000000000A5756B00FFEFDE00FFC7
      9400FFC79400A5756B00FFFFFF00FFE3CE00FFE3C600FFDFC600FFDFC600FFE3
      C600FFF3DE00E7D7CE008C5D5A0000000000FFFFFF004564E5005A75E800FFFF
      FF008195ED00506CE6004867E500FFFFFF00FFFFFF002C55E4002450E4006483
      EC00FFFFFF00254EDE001D3FBF00FFFFFF00D6C7BD00F7D7CE00CE653100CE65
      3100CE653100CE653100BD5D2900DEAA9400FFF7F700EF9E7300BD5D2900CE65
      3100BD5D2900F7F3EF00EFE3DE0053464500CFBFAE00F8E7D500FFF4DF00FFEC
      D600FFECD600FFFFF300CDAF940074000000A5573600FFFFF100FFE8CF00FFE5
      CA00FFEACF00FFEBD100E4CAAF00886A5C0000000000A5756B00FFF7E700F7DB
      BD00F7D7B500A5756B00FFFFFF00FFFFFF00FFFBFF00FFFBF700FFFBF700E7D7
      D600C6B2AD00A59294009C655A0000000000FFFFFF004F6CE600637DE800EFF1
      FD00B7C2F500516CE6004865E400FFFFFF00FFFFFF002C52E200264EE200B0BF
      F500E0E6FB002A50DC002141BF00FFFFFF00D6C7BD00FFEFE700D6693900CE65
      3100CE653100BD5D2900BD5D2900BD5D2900E7CFC600FFFFFF00D6693900CE65
      3100CE693900FFFBFF00F7DFD60053464500CFC2B700FDEFE000FFF4E300FFEF
      DE00FFF0DC00FFFFFF00D6C1AA0077000000A6583600FFFFF800FFEDD500FFE9
      D000FFECD200FFF2D900ECD7C000866A5C0000000000A5756B00FFF7EF00FFDB
      BD00FFDBBD00A5756B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A575
      6B00A5756B00A5756B00A5756B0000000000FFFFFF00536FE7006C85EA0097A9
      F100FFFFFF008093ED004C67E5004261E4003A5BE3003054E2006C86EB00FFFF
      FF00728AEC002D51DC002342BE00FFFFFF00D6C7BD00FFFFFF00F79A6B00D669
      3900CE8E6B00F7EBE700D6825200BD5D2900D6967300FFFFFF00E78E5A00BD5D
      2900EF926300FFFFFF00D6C7BD0053464500D0C7BD00FDF5E900FFF8EB00FFF2
      E600FFFDEF00EFE6DA008C3D1E00650000008C3C2300FFFFFE00FFF0DD00FFEB
      D600FFEED900FFFAE500F2DEC900977E720000000000A5756B00FFFBF700FFC7
      9400FFC79400A5756B00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A575
      6B00E7A25200B5715A000000000000000000FFFFFF005E79E8007A91EC007089
      EB00A6B5F200FFFFFF00B1BDF4007086EA006B83E900B0BDF400FFFFFF0095A8
      F0003053E1002F52DB002342BD00FFFFFF0000000000D6C7BD00FFEBDE00EF86
      5200E7825200F7F7F700FFFFFF00DEBAAD00FFFFFF00F7F7F700DE714200D671
      3900FFF3EF00F7E7E7005346450000000000DFD4C800F7F4EF00FFFFF900FFF6
      EC00FFFFF900E6D9C900B3938200BAA59A00C2AEA300FFFFF800FFF4E300FFEE
      DC00FFFAEB00FFFFFC00E2CAB400977E720000000000A5756B00FFFFFF00FFE3
      CE00FFE3C600A5756B00A5756B00A5756B00A5756B00A5756B00A5756B00A575
      6B00AD6D6B00000000000000000000000000FFFFFF006B85EA008DA1EF008097
      ED006F88EB0097A8F000EEF0FC00FFFFFF00FFFFFF00E9EDFC00899DEE004162
      E4003A5CE3003053DC001E3EBC00FFFFFF0000000000D6C7BD00FFFFFF00FFEF
      D600FFAA7300EFAA8C00EFE3DE00EFEFEF00F7E7E700FFA67B00F78E5A00F7DB
      CE00FFFFFF00D6C7BD00000000000000000000000000E4E5E500FFFFFF00FFFF
      FA00FFFBF300FFFFFF00FFFFFA00F9C8A600FFFEEE00FFFFFF00FFF5E800FFFA
      EF00FFFFFF00FFFFFF00AF9787000000000000000000A5756B00FFFFFF00FFFF
      FF00FFFBFF00FFFBF700FFFBF700E7D7D600C6B2AD00A59294009C655A000000
      000000000000000000000000000000000000FFFFFF00778EEC009DAEF1008CA0
      EF007990EC007089EB006A83E900657EE900627CE9005D78E8005673E7004E6C
      E6004162E4002F52DB001939BA00FFFFFF000000000000000000D6C7BD00FFFF
      FF00FFFFFF00FFF3C600FFDFAD00FFD39C00FFC79400FFD7AD00FFFFFF00FFFF
      FF00D6C7BD0000000000000000000000000000000000ECE7E200EDEDEF00FFFF
      FF00FFFFFF00FFFFFF008E574E005D0000009A452800FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00D1BDAD00000000000000000000000000A5756B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A5756B00A5756B00A5756B00A5756B000000
      000000000000000000000000000000000000FFFFFF00B2BFF400768DEC006781
      EA005B76E8005470E7004F6CE6004A69E6004B69E5004665E5003F60E3003B5D
      E3003154E2002347D8008A9BDE00FFFFFF00000000000000000000000000D6C7
      BD00D6C7BD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFBFF00DECBC600D6C7
      BD00000000000000000000000000000000000000000000000000F1EBE600F2F4
      F500FFFFFF00FFFFFF00D7CEC90062414400C5B5AF00FFFFFF00FFFFFF00FFFF
      FE00E8DED50000000000000000000000000000000000A5756B00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00A5756B00E7A25200B5715A00000000000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000000000
      000000000000DECBC600D6C7BD00D6C7BD00D6C7BD00D6C7BD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EAE3DC00F6F3EF00FFFFFF00FFFFFF00FFFFFF00FBF8F400D8CBC3000000
      00000000000000000000000000000000000000000000A5756B00A5756B00A575
      6B00A5756B00A5756B00A5756B00A5756B00AD6D6B0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000052517B004241730039386B003938730039387300525173000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005279520042714200396939003971390039713900527152000000
      00000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00000000000000000000000000000000006B69
      8C00425194006B86C60094B6E700A5CFEF0094BEE70094BEE700738EC6004A51
      9400525173000000000000000000000000000000000000000000000000006B8E
      6B00429642006BC76B0094E79400A5EFA50094E7940094E7940073C773004A96
      4A00527152000000000000000000000000000000000084868400CED7D600CED7
      D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7
      D600CED7D600CED7D600FFFFFF00000000000000000084868400CED7D600CED7
      D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7D600CED7
      D600CED7D600CED7D600FFFFFF00000000000000000000000000737194004A59
      A50084AEEF009CCFF700ADD7F700B5DFFF00ADD7FF00ADD7FF009CCFF7008CB6
      EF004A59A5005251730000000000000000000000000000000000739673004AA6
      4A0084EF84009CF79C00ADF7AD00B5FFB500ADFFB500ADFFB5009CF79C008CEF
      8C004AA64A00527152000000000000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000000000000039418C006B96
      E70084B6EF0094BEF700A5CFF700ADCFF700A5CFF700A5CFF70094BEF70084B6
      EF00739EE70042498C0000000000000000000000000000000000398E39006BE7
      6B0084EF840094F79400A5F7AD00ADF7AD00A5F7AD00A5F7AD0094F7940084EF
      840073E77300428E42000000000000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000006B6994004A59BD006B96
      E7007BA6EF0084AEEF008CB6F70094B6F7008CB6F7008CB6F70084AEEF007B9E
      EF006B96E7004A59B5004A49730000000000000000006B966B004ABE4A006BE7
      6B007BEF7B0084EF84008CF78C0094F794008CF78C008CF78C0084EF84007BEF
      7B006BE76B004AB64A004A714A0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000004A497B004A61CE006386
      E7006B8EEF007396EF00739EF700739EEF00739EEF00739EEF006B96EF006B8E
      E7006379DE004A61CE003938730000000000000000004A794A004ACF4A0063E7
      63006BEF6B0073EF730073F7730073EF730073EF730073EF73006BEF6B006BE7
      6B0063DF63004ACF4A003971390000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF000000000000000000000000000000000000000000FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000004A497B004A61CE006386
      E7006B8EEF007396EF00739EF700739EEF00739EEF00739EEF006B96EF006B8E
      E7006379DE004A61CE003938730000000000000000004A794A004ACF4A0063E7
      63006BEF6B0073EF730073F7730073EF730073EF730073EF73006BEF6B006BE7
      6B0063DF63004ACF4A003971390000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF000000000000000000FFFFFF00000000000000000000000000FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF000000000000000000424173004251D6004A61
      E7005271EF005A71EF005A79EF006379EF005A79EF005A79EF005A71E7005269
      DE004A61DE004251CE0039386B0000000000000000004271420042D742004AE7
      4A0052EF52005AEF5A005AEF5A0063EF63005AEF5A005AEF5A005AE75A0052DF
      52004ADF4A0042CF42003969390000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF0000000000FFFFFF00FFFFFF00FFFFFF00000000000000000000000000FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000004A497B002930C6002930
      DE003138EF003141EF003941EF003941EF003141E7003141E7003141DE002938
      D6002930CE002930BD004241730000000000000000004A794A0029C7290029DF
      290031EF310031EF310039EF390039EF390031E7310031E7310031DF310029D7
      290029CF290029BE29004271420000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000000000000000
      0000FFFFFF00CED7D600FFFFFF00000000000000000073719C002118B5001010
      D6001010E7001810EF001818EF001818EF001810DE001810DE001810D6001010
      C6001010BD001818A50052517B000000000000000000739E730018B6180010D7
      100010E7100010EF100018EF180018EF180010DF100010DF100010D7100010C7
      100010BE100018A618005279520000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000000000
      0000FFFFFF00CED7D600FFFFFF0000000000000000000000000039388C004241
      DE005251E7006359EF006359F7006361EF006361EF006361EF005A59DE005A51
      D6004A49CE0039388C0000000000000000000000000000000000398E390042DF
      420052E752005AEF5A005AF75A0063EF630063EF630063EF63005ADF5A0052D7
      52004ACF4A00398E39000000000000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
      0000FFFFFF00CED7D600FFFFFF000000000000000000000000008486A5005A51
      A5009C9EEF00B5B6F700B5B6F700BDB6F700B5B6F700B5B6F700B5B6EF00A5A6
      E7005A59A5006B698C000000000000000000000000000000000084A6840052A6
      52009CEF9C00B5F7B500B5F7B500B5F7BD00B5F7B500B5F7B500B5EFB500A5E7
      A5005AA65A006B8E6B000000000000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF0000000000000000008486840042414200FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00CED7D600FFFFFF00000000000000000000000000000000008486
      A50063619400ADAECE00CECFE700DEDFF700CECFE700CECFE700ADAECE006361
      94007371940000000000000000000000000000000000000000000000000084A6
      840063966300ADCFAD00CEE7CE00DEF7DE00CEE7CE00CEE7CE00ADCFAD006396
      6300739673000000000000000000000000000000000084868400424142004241
      4200424142004241420042414200424142004241420042414200424142004241
      420042414200CED7D600FFFFFF00000000000000000084868400424142004241
      4200424142004241420042414200424142004241420042414200424142004241
      420042414200CED7D600FFFFFF00000000000000000000000000000000000000
      00000000000073719C004A498400424173004A497B004A497B006B6994000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000739E73004A864A00427142004A794A004A794A006B966B000000
      0000000000000000000000000000000000000000000084868400848684008486
      8400848684008486840084868400848684008486840084868400848684008486
      84008486840084868400FFFFFF00000000000000000084868400848684008486
      8400848684008486840084868400848684008486840084868400848684008486
      84008486840084868400FFFFFF00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000900000000100010000000000800400000000000000000000
      000000000000000000000000FFFFFF00FF1FFFFF00000000FFC7FFF300000000
      FE23B80100000000FF93B00000000000F0C9A00000000000E065C00100000000
      C035400300000000C015400B00000000801F800300000000001F800700000000
      001FC00F00000000001FC00F00000000001F800300000000803F201900000000
      F07FF83F00000000FFFFFC7F000000008FFF8FFFFFFFFFFF04D107FFFFFFFCFF
      035603FFE000F83F015601FFC000F00F005680FFC000E003800180018000C001
      E001600080008001F00040000000000188007800000000038800880000000003
      8800F800800000078800F8008000000F0000F8008001000F8801F801C07F000F
      DC03FC03E0FF801FFE07FE07FFFFE03FFFFFFFFFF8018FFFFFFFFFFFF80104D1
      C63FFC63F8010356801FF801F8010156800FF001800100568007E00180018001
      C003C0030000E001E00180070000F000F001800F0000D800E001800780018800
      C003C003800300008007E00180078800800FF001801F8800801FF801801F8801
      C63FFC63803F8C03FFFFFFFF807FFE07FFFFC007FFFFFFFFCFFF8007F9FFFC1F
      87F38007F0FFF00783E38007E07FE003C3C78007C03FC003E18F8007801FC781
      F01F8003000F8F01F83F800183078E21FC3F8000C7838C61F81F8000FFC188E3
      F18F8007FFF081E3E3C78007FFFDC3C7C7E78007FFFFC00F8FFF800FFFFFE01F
      9FFF801FFFFFF87FFFFF803FFFFFFFFFFFFFFFFFFC3FFFFFFE3FE3E3F00FFFFF
      FC1FC1C1E007FC3FF80FC081C003FC3FF007C0018001FC3FE003E0038001FC3F
      C001E0030001C003C001C0010000C003C001C0010000C003E003C0010000C003
      E003E0038001FC3FC001F0078001FC3FC081F80FC003FC3FC1C1FC1FE007FC3F
      E3E3FE3FF00FFFFFFFFFFFFFFC3FFFFFFFFFC0010000FFFF807F80000000F83F
      000000000000E00F000000000000C00700000001000080038000800100008003
      C0038003000000018003C003000000010001C007000000010001E00700000001
      0001E00F000000010001F00F000080038101F01F00008003C383F81F0000C007
      FFC7F83F0000E00FFFFFFC7F0000F83FFFFFFC1FF00FF8E3FFFC80008000F001
      9FF900000000F0008FF300000000F00087E700010001F000C3CFF83FF81F8000
      F11FFC3FF01F0000F83FF80FF80F0000FC7FE003E0030000F83F800080000000
      F19F000000000001E3CF00000000000FC7E700010001001F8FFB00038003003F
      1FFFE01FF01F07FF3FFFFFFFFFFFFFFF8001F81FFF3FF8010000E007FE1FF801
      0000C003FC1FF80100008001F007F80100008001C00380010000000080018001
      0000000000018001000000000000800100000000000080010000000000008001
      00000000000080030000800100008007000080038001801F0000C0078003801F
      0000E00FC007803F8001F83FF01F807FFFFFFFFFFFFFFFFFF81FF81F80018001
      E007E00780018001C003C00380018001C003C003800180018001800180018001
      8001800180018001800180018001800180018001800180018001800180018001
      8001800180018001C003C00380018001C003C00380018001E007E00780018001
      F81FF81F80018001FFFFFFFFFFFFFFFF00000000000000000000000000000000
      000000000000}
  end
  object ApplicationEvents1: TApplicationEvents
    OnHint = ApplicationEvents1Hint
    OnMessage = ApplicationEvents1Message
    OnMinimize = ApplicationEvents1Minimize
    OnRestore = ApplicationEvents1Restore
    Left = 544
    Top = 424
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items.CaptionOptions = coNone
        Items = <
          item
            Action = Action_Quit
            ImageIndex = 4
            ShortCut = 32883
          end
          item
            Action = Action_Help
            ImageIndex = 1
            ShortCut = 112
          end
          item
            Action = Action_About
            ImageIndex = 2
            ShortCut = 123
          end>
      end
      item
        Items.CaptionOptions = coNone
        Items = <
          item
            Action = Action_Quit
            ImageIndex = 4
            ShortCut = 32883
          end
          item
            Action = Action_Help
            ImageIndex = 1
            ShortCut = 112
          end
          item
            Action = Action_About
            ImageIndex = 2
            ShortCut = 123
          end>
      end
      item
        Items.CaptionOptions = coNone
        Items = <
          item
            Action = Action_Quit
            ImageIndex = 4
            ShortCut = 32883
          end
          item
            Caption = '-'
          end
          item
            Action = Action_Help
            ImageIndex = 1
            ShortCut = 112
          end
          item
            Action = Action_About
            ImageIndex = 2
            ShortCut = 123
          end>
      end
      item
        Items.CaptionOptions = coNone
        Items = <
          item
            Action = Action_Quit
            ImageIndex = 4
            ShortCut = 32883
          end
          item
            Caption = '-'
          end
          item
            Action = Action_Help
            ImageIndex = 1
            ShortCut = 112
          end
          item
            Action = Action_About
            ImageIndex = 2
            ShortCut = 123
          end>
      end
      item
      end>
    Images = ImageList1
    Left = 512
    Top = 424
    StyleName = 'XP Style'
    object Action_CopySQLFromLogToClipboard: TAction
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' SQL-'#1079#1072#1087#1088#1086#1089
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103' '#1090#1077#1082#1089#1090#1072' SQL-'#1079#1072#1087#1088#1086#1089#1072' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 14
      OnExecute = Action_CopySQLFromLogToClipboardExecute
    end
    object Action_CopyLogStringToClipboard: TAction
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1089#1090#1088#1086#1082#1080' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 7
      OnExecute = Action_CopyLogStringToClipboardExecute
    end
    object Action_ClearLogList: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1095#1080#1089#1090#1082#1080' '#1089#1087#1080#1089#1082#1072
      ImageIndex = 8
      OnExecute = Action_ClearLogListExecute
    end
    object Action_CopyGUIDStringToClipboard: TAction
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' GUID'
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1082#1086#1087#1080#1088#1086#1074#1072#1085#1080#1103' GUID '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1081' '#1089#1090#1088#1086#1082#1080' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ImageIndex = 26
      OnExecute = Action_CopyGUIDStringToClipboardExecute
    end
    object Action_FindSpecifiedGUID: TAction
      Caption = #1055#1086#1080#1089#1082' '#1091#1082#1072#1079#1072#1085#1085#1086#1075#1086' GUID...'
      Hint = 
        #1055#1086#1080#1089#1082' '#1091#1082#1072#1079#1072#1085#1085#1086#1075#1086' GUID...|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1074#1074#1086#1076#1072' GUID '#1080' ' +
        #1076#1072#1083#1100#1085#1077#1081#1096#1077#1075#1086' '#1077#1075#1086' '#1087#1086#1080#1089#1082#1072' '#1074' '#1089#1087#1080#1089#1082#1077' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      ImageIndex = 29
      OnExecute = Action_FindSpecifiedGUIDExecute
    end
    object Action_FindPreviousWithSuchGUID: TAction
      Caption = #1055#1086#1080#1089#1082' GUID '#1074#1074#1077#1088#1093' [F2]'
      Hint = 
        #1055#1086#1080#1089#1082' GUID '#1074#1074#1077#1088#1093' [F2]|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1082' '#1087#1088#1077#1076#1099#1076#1091#1097#1077#1081' '#1089#1090#1088#1086#1082#1077' '#1089 +
        ' '#1090#1072#1082#1080#1084' '#1078#1077' GUID'
      ImageIndex = 28
      OnExecute = Action_FindPreviousWithSuchGUIDExecute
    end
    object Action_FindNextWithSuchGUID: TAction
      Caption = #1055#1086#1080#1089#1082' GUID '#1074#1085#1080#1079' [F3]'
      Hint = 
        #1055#1086#1080#1089#1082' GUID '#1074#1085#1080#1079' [F3]|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1077#1088#1077#1093#1086#1076#1072' '#1082' '#1089#1083#1077#1076#1091#1102#1097#1077#1081' '#1089#1090#1088#1086#1082#1077' '#1089' '#1090 +
        #1072#1082#1080#1084' '#1078#1077' GUID'
      ImageIndex = 27
      OnExecute = Action_FindNextWithSuchGUIDExecute
    end
    object Action_Restore: TAction
      Caption = '&'#1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1075#1083#1072#1074#1085#1086#1075#1086' '#1086#1082#1085#1072' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      OnExecute = Action_RestoreExecute
    end
    object Action_Help: TAction
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072'...'
      Hint = #1057#1087#1088#1072#1074#1082#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077
      ImageIndex = 5
      ShortCut = 112
      OnExecute = Action_HelpExecute
    end
    object Action_About: TAction
      Caption = '&O '#1087#1088#1086#1075#1088#1072#1084#1084#1077'...'
      Hint = 
        #1048#1085#1092#1086#1088#1084#1072#1094#1080#1103' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1077 +
        #1081' '#1086' '#1087#1088#1086#1075#1088#1072#1084#1084#1077' '#1080' '#1077#1105' '#1072#1074#1090#1086#1088#1077
      ImageIndex = 6
      ShortCut = 123
      OnExecute = Action_AboutExecute
    end
    object Action_Quit: TAction
      Caption = '&'#1042#1099#1093#1086#1076
      Hint = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1088#1072#1073#1086#1090#1099'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103' '#1088#1072#1073#1086#1090#1099' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 4
      ShortCut = 32883
      SecondaryShortCuts.Strings = (
        'Alt+X'
        'F10')
      OnExecute = Action_QuitExecute
    end
    object Action_Logon: TAction
      Caption = #1053#1072#1095#1072#1083#1086' '#1089#1077#1072#1085#1089#1072' '#1088#1072#1073#1086#1090#1099
      Hint = 
        #1053#1072#1095#1072#1083#1086' '#1089#1077#1072#1085#1089#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1074#1074#1086#1076#1072' '#1083#1086#1075#1080#1085#1072' '#1080' '#1087#1072#1088#1086#1083#1103 +
        ' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080' '#1085#1072#1095#1072#1083#1072' '#1089#1077#1072#1085#1089#1072' '#1088#1072#1073#1086#1090#1099' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 9
      OnExecute = Action_LogonExecute
    end
    object Action_Logout: TAction
      Caption = #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1089#1077#1072#1085#1089#1072' '#1088#1072#1073#1086#1090#1099
      Hint = 
        #1047#1072#1074#1077#1088#1096#1077#1085#1080#1077' '#1089#1077#1072#1085#1089#1072'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1074#1077#1088#1096#1077#1085#1080#1103' '#1089#1077#1072#1085#1089#1072' '#1088#1072#1073#1086#1090#1099' '#1090#1077#1082#1091#1097#1077#1075#1086' ' +
        #1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 10
      Visible = False
      OnExecute = Action_LogoutExecute
    end
    object Action_Configuration: TAction
      Caption = '&'#1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103'...'
      Hint = #1050#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 11
      OnExecute = Action_ConfigurationExecute
    end
    object Action_Accounts: TAction
      Caption = '&'#1059#1087#1088#1072#1074#1083#1077#1085#1080#1077' '#1091#1095#1105#1090#1085#1099#1084#1080' '#1079#1072#1087#1080#1089#1103#1084#1080'...'
      Hint = 
        #1059#1095#1105#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1091#1095#1105#1090#1085#1099 +
        #1093' '#1079#1072#1087#1080#1089#1077#1081' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 12
      OnExecute = Action_AccountsExecute
    end
    object Action_RestoreLogPanel: TAction
      Caption = #1057#1074#1077#1088#1085#1091#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      Enabled = False
      Hint = 
        #1057#1074#1077#1088#1085#1091#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1087#1088#1086#1090#1086#1082#1086#1083#1072'|'#1053#1072#1078#1080#1090#1077' '#1076#1083#1103' '#1074#1086#1079#1074#1088#1072#1097#1077#1085#1080#1103' '#1087#1072#1085#1077#1083#1080' '#1087#1088#1086#1090#1086#1082#1086#1083 +
        #1072' '#1082' '#1085#1086#1088#1084#1072#1083#1100#1085#1099#1084' '#1088#1072#1079#1084#1077#1088#1072#1084
      ImageIndex = 16
      OnExecute = Action_RestoreLogPanelExecute
    end
    object Action_MaximizeLogPanel: TAction
      Caption = #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1087#1088#1086#1090#1086#1082#1086#1083#1072
      Hint = 
        #1056#1072#1079#1074#1077#1088#1085#1091#1090#1100' '#1087#1072#1085#1077#1083#1100' '#1087#1088#1086#1090#1086#1082#1086#1083#1072'|'#1053#1072#1078#1080#1090#1077' '#1076#1083#1103' '#1088#1072#1079#1074#1086#1088#1072#1095#1080#1074#1072#1085#1080#1103' '#1087#1072#1085#1077#1083#1080' '#1087#1088#1086 +
        #1090#1086#1082#1086#1083#1072' '#1085#1072' '#1074#1089#1105' '#1086#1082#1085#1086
      ImageIndex = 17
      OnExecute = Action_MaximizeLogPanelExecute
    end
    object Action_Process: TAction
      Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1076#1077#1081#1089#1090#1074#1080#1077'...'
      Hint = 
        #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1074#1099#1073#1088#1072#1085#1085#1086#1077' '#1076#1077#1081#1089#1090#1074#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1074#1099#1073#1088#1072#1085#1085#1086#1075#1086' '#1076 +
        #1077#1081#1089#1090#1074#1080#1103
      ImageIndex = 18
      OnExecute = Action_ProcessExecute
    end
    object Action_OpenReportsFolder: TAction
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1072#1087#1082#1091' '#1086#1090#1095#1105#1090#1086#1074'...'
      Hint = 
        #1054#1090#1082#1088#1099#1090#1080#1077' '#1090#1077#1082#1091#1097#1077#1085#1081' '#1087#1072#1087#1082#1080' '#1086#1090#1095#1105#1090#1086#1074'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1087#1072#1087 +
        #1082#1080' '#1076#1083#1103' '#1093#1088#1072#1085#1077#1085#1080#1103' '#1086#1090#1095#1105#1090#1086#1074', '#1089#1086#1079#1076#1072#1074#1072#1077#1084#1099#1093' '#1087#1088#1086#1075#1088#1072#1084#1084#1086#1081
      ImageIndex = 30
      OnExecute = Action_OpenReportsFolderExecute
    end
    object Action_ProcessSelectedActions: TAction
      Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072' '#1076#1077#1081#1089#1090#1074#1080#1081' '#1079#1072' '#1091#1082#1072#1079#1072#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1087#1086#1083#1085#1077#1085#1080#1103' '#1074#1099#1073#1088#1072#1085#1085#1099#1093' '#1080#1079' '#1089#1087#1080#1089#1082#1072' '#1076#1077#1081#1089#1090#1074#1080#1081' (batch-'#1088#1077#1078#1080#1084 +
        ')'
      OnExecute = Action_ProcessSelectedActionsExecute
    end
    object Action_AddPhones_SIC_01: TAction
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      Enabled = False
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1085#1086#1084#1077#1088#1086#1074' '#1090#1077#1083#1077#1092#1086#1085#1086#1074' '#1074' '#1089#1087#1080#1089#1086#1082
      OnExecute = Action_AddPhones_SIC_01Execute
    end
    object Action_DeletePhone_SIC_01: TAction
      Caption = #1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1090#1077#1083#1077#1092#1086#1085#1072' '#1080#1079' '#1089#1087#1080#1089#1082#1072
      OnExecute = Action_DeletePhone_SIC_01Execute
    end
    object Action_ClearPhones_SIC_01: TAction
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100
      Enabled = False
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1095#1080#1089#1090#1082#1080' '#1089#1087#1080#1089#1082#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074
      OnExecute = Action_ClearPhones_SIC_01Execute
    end
    object Action_Comments: TAction
      Enabled = False
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1089' '#1082#1086#1084#1084#1077#1085#1090#1072#1088#1080#1103#1084#1080' '#1082' '#1074#1099#1073#1088#1072#1085#1085#1086#1084#1091' '#1076#1077#1081#1089#1090#1074 +
        #1080#1102
      ImageIndex = 5
      OnExecute = Action_CommentsExecute
    end
    object Action_RefreshUserList_SIC_04: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082'...'
      Enabled = False
      Hint = 
        #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1089#1087#1080#1089#1082#1072' '#1087#1086#1083#1100 +
        #1079#1086#1074#1072#1090#1077#1083#1077#1081' '#1087#1086' '#1076#1077#1081#1089#1090#1074#1080#1103#1084' '#1082#1086#1090#1086#1088#1099#1093' '#1084#1086#1078#1085#1086' '#1089#1086#1079#1076#1072#1090#1100' '#1086#1090#1095#1105#1090
      ImageIndex = 12
      OnExecute = Action_RefreshUserList_SIC_04Execute
    end
    object Action_RefreshCallsList_Payoff: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082'...'
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1074#1086#1076#1072' '#1089#1087#1080#1089#1082#1072' '#1079#1074#1086#1085#1082#1086#1074' '#1089' '#1091#1082#1072#1079#1072#1085#1085#1099#1093' '#1085#1086#1084#1077#1088#1086#1074' '#1090#1077#1083#1077#1092#1086#1085#1086#1074' ' +
        #1085#1072' '#1089#1087#1088#1072#1074#1086#1095#1085#1099#1077' '#1089#1083#1091#1078#1073#1099' '#1057#1048#1062' '#1079#1072' '#1091#1082#1072#1079#1072#1085#1085#1099#1081' '#1087#1077#1088#1080#1086#1076' '#1074#1088#1077#1084#1077#1085#1080'...'
      ImageIndex = 31
      OnExecute = Action_RefreshCallsList_PayoffExecute
    end
    object Action_RefreshUserList_SIC_10: TAction
      Caption = #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082'...'
      Enabled = False
      Hint = 
        #1054#1073#1085#1086#1074#1080#1090#1100' '#1089#1087#1080#1089#1086#1082' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1086#1074'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1073#1085#1086#1074#1083#1077#1085#1080#1103' '#1089#1087#1080#1089#1082#1072' '#1089#1087#1077#1094#1080 +
        #1072#1083#1080#1089#1090#1086#1074', '#1087#1086' '#1082#1086#1090#1086#1088#1099#1084' '#1084#1086#1078#1085#1086' '#1089#1086#1079#1076#1072#1090#1100' '#1086#1090#1095#1105#1090
      ImageIndex = 12
      OnExecute = Action_RefreshUserList_SIC_10Execute
    end
    object Action_SelectAllServices_SIC_09: TAction
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077' '#1091#1089#1083#1091#1075#1080
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1091#1089#1083#1091#1075
      ImageIndex = 3
      OnExecute = Action_SelectAllServices_SIC_09Execute
    end
    object Action_UnselectAllServices_SIC_09: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      Hint = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1089#1086' '#1074#1089#1077#1093' '#1091#1089#1083#1091#1075
      ImageIndex = 2
      OnExecute = Action_UnselectAllServices_SIC_09Execute
    end
    object Action_SelectOralServices_SIC_09: TAction
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1075#1086#1083#1086#1089#1086#1074#1099#1077' '#1091#1089#1083#1091#1075#1080
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1075#1086#1083#1086#1089#1086#1074#1099#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1090#1086#1083#1100#1082#1086' '#1075#1086#1083#1086#1089#1086#1074#1099#1093' '#1091#1089#1083#1091#1075
      ImageIndex = 12
      OnExecute = Action_SelectOralServices_SIC_09Execute
    end
    object Action_SelectAutoServices_SIC_09: TAction
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1091#1089#1083#1091#1075#1080' '#1072#1074#1090#1086#1080#1085#1092#1086#1088#1084#1072#1090#1086#1088#1072
      Hint = 
        #1042#1099#1076#1077#1083#1080#1090#1100' '#1072#1074#1090#1086#1080#1085#1092#1086#1088#1084#1072#1090#1086#1088'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1090#1086#1083#1100#1082#1086' '#1091#1089#1083#1091#1075#1080' '#1072#1074#1090#1086 +
        #1080#1085#1092#1086#1088#1084#1072#1090#1086#1088#1072
      ImageIndex = 32
      OnExecute = Action_SelectAutoServices_SIC_09Execute
    end
    object Action_SelectAllUsers_SIC_10: TAction
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077#1093' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1086#1074
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077#1093'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1086#1074
      ImageIndex = 3
      OnExecute = Action_SelectAllUsers_SIC_10Execute
    end
    object Action_SelectAllUsers_SIC_04: TAction
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077#1093'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      ImageIndex = 3
      OnExecute = Action_SelectAllUsers_SIC_04Execute
    end
    object Action_UnselectAllUsers_SIC_10: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      Hint = 
        #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1089#1086' '#1074#1089#1077#1093' '#1089#1087#1077#1094#1080#1072#1083#1080#1089#1090#1086 +
        #1074
      ImageIndex = 2
      OnExecute = Action_UnselectAllUsers_SIC_10Execute
    end
    object Action_UnselectAllUsers_SIC_04: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      Hint = 
        #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1089#1086' '#1074#1089#1077#1093' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083 +
        #1077#1081
      ImageIndex = 2
      OnExecute = Action_UnselectAllUsers_SIC_04Execute
    end
    object Action_SelectAllCalls_Payoff: TAction
      Caption = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077' '#1079#1074#1086#1085#1082#1080
      Hint = #1042#1099#1076#1077#1083#1080#1090#1100' '#1074#1089#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1074#1089#1077#1093' '#1079#1074#1086#1085#1082#1086#1074
      ImageIndex = 3
      OnExecute = Action_SelectAllCalls_PayoffExecute
    end
    object Action_UnselectAllCalls_Payoff: TAction
      Caption = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077
      Hint = #1057#1085#1103#1090#1100' '#1074#1099#1076#1077#1083#1077#1085#1080#1077'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1085#1103#1090#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1080#1103' '#1089#1086' '#1074#1089#1077#1093' '#1079#1074#1086#1085#1082#1086#1074
      ImageIndex = 2
      OnExecute = Action_UnselectAllCalls_PayoffExecute
    end
  end
  object TrayIcon1: TTrayIcon
    Icon.Data = {
      0000010001001010080000000000680500001600000028000000100000002000
      0000010008000000000000010000000000000000000000000000000000000000
      0000000080000080000000808000800000008000800080800000C0C0C000C0DC
      C000F0CAA6000020400000206000002080000020A0000020C0000020E0000040
      0000004020000040400000406000004080000040A0000040C0000040E0000060
      0000006020000060400000606000006080000060A0000060C0000060E0000080
      0000008020000080400000806000008080000080A0000080C0000080E00000A0
      000000A0200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0
      000000C0200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0
      000000E0200000E0400000E0600000E0800000E0A00000E0C00000E0E0004000
      0000400020004000400040006000400080004000A0004000C0004000E0004020
      0000402020004020400040206000402080004020A0004020C0004020E0004040
      0000404020004040400040406000404080004040A0004040C0004040E0004060
      0000406020004060400040606000406080004060A0004060C0004060E0004080
      0000408020004080400040806000408080004080A0004080C0004080E00040A0
      000040A0200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0
      000040C0200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0
      000040E0200040E0400040E0600040E0800040E0A00040E0C00040E0E0008000
      0000800020008000400080006000800080008000A0008000C0008000E0008020
      0000802020008020400080206000802080008020A0008020C0008020E0008040
      0000804020008040400080406000804080008040A0008040C0008040E0008060
      0000806020008060400080606000806080008060A0008060C0008060E0008080
      0000808020008080400080806000808080008080A0008080C0008080E00080A0
      000080A0200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0
      000080C0200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0
      000080E0200080E0400080E0600080E0800080E0A00080E0C00080E0E000C000
      0000C0002000C0004000C0006000C0008000C000A000C000C000C000E000C020
      0000C0202000C0204000C0206000C0208000C020A000C020C000C020E000C040
      0000C0402000C0404000C0406000C0408000C040A000C040C000C040E000C060
      0000C0602000C0604000C0606000C0608000C060A000C060C000C060E000C080
      0000C0802000C0804000C0806000C0808000C080A000C080C000C080E000C0A0
      0000C0A02000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C0
      0000C0C02000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A0008080
      80000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
      0000000000000000000000000000005249529B5B5252F7F6F6F6F6F649000052
      F708F6F608A44907FFFFFFFF490000F7080808070808A452F6FFFFFF49000008
      0807F7F70707085BF7FFFF075B000079F7525252A4F708079BFF07A449000030
      5200494949A4F7089B07A45258000030A4A45249499BF7075B52526002000030
      08F6A449499BA49B49606031180000687AF6A449495252526031310218000068
      68A45249494960293132691860000059595249499B2930303169586030000052
      5B5B29727B39303002586030300000737374397A7A39020260603030300000BD
      BDBDBC7169026060303030BBBB0000A3A3A3A31010101010181818A3A3000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000}
    PopupMenu = pmTray
    OnClick = TrayIcon1Click
    OnDblClick = TrayIcon1DblClick
    Left = 416
    Top = 424
  end
  object pmTray: TPopupMenu
    Images = ImageList1
    Left = 448
    Top = 424
    object ActionRestore1: TMenuItem
      Action = Action_Restore
      Default = True
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Action = Action_Help
    end
    object O1: TMenuItem
      Action = Action_About
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Action = Action_Quit
    end
  end
  object pmLog: TPopupMenu
    Images = ImageList1
    OnPopup = pmLogPopup
    Left = 352
    Top = 424
    object N23: TMenuItem
      Action = Action_MaximizeLogPanel
    end
    object N24: TMenuItem
      Action = Action_RestoreLogPanel
    end
    object N31: TMenuItem
      Caption = '-'
    end
    object N33: TMenuItem
      Action = Action_CopyLogStringToClipboard
    end
    object N34: TMenuItem
      Action = Action_ClearLogList
    end
    object N35: TMenuItem
      Caption = '-'
    end
    object SQL1: TMenuItem
      Action = Action_CopySQLFromLogToClipboard
    end
    object GUID1: TMenuItem
      Action = Action_CopyGUIDStringToClipboard
    end
    object N36: TMenuItem
      Caption = '-'
    end
    object GUID2: TMenuItem
      Action = Action_FindSpecifiedGUID
    end
    object GUIDF21: TMenuItem
      Action = Action_FindPreviousWithSuchGUID
    end
    object GUIDF31: TMenuItem
      Action = Action_FindNextWithSuchGUID
    end
  end
  object Timer2: TTimer
    Interval = 60000
    OnTimer = Timer2Timer
    Left = 320
    Top = 424
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 576
    Top = 424
  end
  object pm_SIC_09: TPopupMenu
    Images = ImageList1
    Left = 608
    Top = 424
    object N18: TMenuItem
      Action = Action_SelectAllServices_SIC_09
    end
    object N20: TMenuItem
      Action = Action_SelectOralServices_SIC_09
    end
    object N21: TMenuItem
      Action = Action_SelectAutoServices_SIC_09
    end
    object N27: TMenuItem
      Caption = '-'
    end
    object N19: TMenuItem
      Action = Action_UnselectAllServices_SIC_09
    end
  end
  object pm_SIC_04: TPopupMenu
    Images = ImageList1
    Left = 640
    Top = 424
    object N28: TMenuItem
      Action = Action_SelectAllUsers_SIC_04
    end
    object N29: TMenuItem
      Action = Action_UnselectAllUsers_SIC_04
    end
  end
  object pm_Payoff: TPopupMenu
    Images = ImageList1
    Left = 672
    Top = 424
    object N30: TMenuItem
      Action = Action_SelectAllCalls_Payoff
    end
    object N37: TMenuItem
      Action = Action_UnselectAllCalls_Payoff
    end
  end
  object pm_SIC_10: TPopupMenu
    Images = ImageList1
    Left = 704
    Top = 424
    object MenuItem1: TMenuItem
      Action = Action_SelectAllUsers_SIC_10
    end
    object MenuItem2: TMenuItem
      Action = Action_UnselectAllUsers_SIC_10
    end
  end
  object ilActionList: TImageList
    AllocBy = 3
    Left = 256
    Top = 424
    Bitmap = {
      494C010103000800440110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000004D4D4D004D4D4D004D4D
      4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D4D004D4D
      4D004D4D4D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FBFB
      FE04FCFCFE030000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AE7B6E00D9AD9D00D5AA9C00D1A7
      9A00CEA49800CBA19600C89F9300C49C9200C0999000BC968E00B9938D00977C
      72004D4D4D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCFC
      FE03000000000000000000000000000000000000000000000000FDFDFE02DEE0
      F721F3F4FC0C0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000AE7B6E00EFE7DE00FFEEDD00FFEA
      D600FFE6CD00FFE3C800FFDFBE00FFDCB900FFD8B200FFD4A900FFD0A200D9AA
      A800705E54004D4D4D0000000000000000000000000000000000000000000000
      0000000000002AD5360000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000E8EBFE171937
      F7E6E8EAFE1700000000000000000000000000000000FEFEFE01D4D7F42B1C2C
      BCE3D1D4F32EFAFAFD0500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C28F7900FFF2E500FFEE
      DD006A9D5800FFE6CD00FFE3C800FFDFBE00FFDCB900FFD8B200FFD4A900F7BF
      B0007E665D004D4D4D0000000000000000000000000000000000000000000000
      00002AD5360001C911002AD53600000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EEF1FF12576FFFBF0F31
      FFFF1B39FFEDEBEDFE140000000000000000FDFDFE02DADDF6253A4AD2C50014
      BDFF0C1EB5F3E5E7F91A00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C8957C00FEF5EB00FFF2
      E5002D842B007FA86A00FFE6CD00FFE3C800FFDFBE00FFDCB900FFD8B200FFCF
      AE00997E77004D4D4D00000000000000000000000000000000000000000015CF
      230017E3260015E324000CD61B002AD536000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000F0F2FF102C4B
      FFF71132FFFF072AFFFFCDD3FE32FAFAFD05D3D6F52C2235CEDD0017CFFF1226
      C8EDC2C6EE3DFEFEFE0100000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CF9C8000F3EFEA00FFF5
      EC002D842B002D842B00B1C19400FFE6CD00FFE3C800FFDFBE00FFDCB900FFD8
      B200DDA5A1004D4D4D000000000000000000000000000000000008CF170017E3
      260039E3460041D64C002BE138001DD82B002AD5360000000000000000000000
      000000000000000000000000000000000000000000000000000000000000EAED
      FF173351FFEE1132FFFF0D2EFFF2CCD0F533273CDBD8001CE0FF172BD2E8DBDE
      F724FEFEFE010000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000002D842B002D842B002D842B002D84
      2B002D842B001EB73C000D821200E9DFC400FFE6CD00FFE3C800FFDFBE00FFDC
      B900F7B9AC007F685E004D4D4D00000000000000000012D120001DE32C0039E3
      460043E34F000000000052DA5C002FDD3C0010D71E002AD53600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000E1E5FF215069FFD11136FFFF001FF3FF0925E8F63648D9C9E2E4F81DFDFD
      FE02000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003390390055EF880047E17B0039D3
      6C0031CA630021BB440010A8210024802000FFEAD600FFE6CD00FFE3C800FFDF
      BE00FFD2B7009F857B004D4D4D0000000000000000001DE32C0039E3460043E3
      4F0000000000000000000000000052DA5C002FDD3C0024D030002AD536000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000FDFDFF02C3CCFF4D2446FFFF0D31FFFF0927F1F6D5D9F72AFCFCFE030000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003390390048D973003CCD670031C2
      5C002BBD570025BE4B0012A525002D842B00FFEEDD00FFEAD600FFE6CD00FFE3
      C800FFDFBE00E1A29B004D4D4D00000000000000000039E3460051E35B000000
      00000000000000000000000000000000000052DA5C001EDE2D003ACF45002AD5
      3600000000000000000000000000000000000000000000000000000000000000
      0000CDD5FF413C5CFFFF2C4CFFFF3150FFED1334FFFF0523EAFAD9DDFB260000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CF9C8000C8D1
      BB002B8C340027BF4E0026852800FFF5EC00FFF2E500FFEEDD00FFEAD600FFE6
      CD00FFE3C800F8B3A8004D4D4D004D4D4D000000000000000000000000000000
      0000000000000000000000000000000000000000000052DA5C0015DC240042D0
      4D002AD53600000000000000000000000000000000000000000000000000D8DF
      FF324362FFFF3A59FFFF536FFFEED2D9FF3A4A68FFEE1F41FFFF001FEDFFD7DB
      FB28000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CF9C
      800032903B001E862800F7F9F400FFF8F100FFF5EC00FFF2E500FFEEDD00FFE4
      D300FFDEC900FFC4B600A3887F004D4D4D000000000000000000000000000000
      000000000000000000000000000000000000000000000000000052DA5C0015DC
      240042D04D002AD53600000000000000000000000000FEFEFF01E2E7FF25506F
      FFFF5776FFFF748CFFCBECEFFF18FAFBFF06E0E5FF284967FFEE284AFFFF0021
      F7FFD4D9FB2B0000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DCA9
      87002F812F00DBE9DB00FFFFFF00FFFDFB00FFF8F100FFF5EC00F8E6D700DBA3
      8300D6967100D08E6C00BF9F84004D4D4D000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000052DA
      5C0019DD270019DD2700000000000000000000000000F2F4FF105E7AFFFB5D7B
      FFFF6984FFE8F3F5FF0FFDFDFF020000000000000000E2E7FF254A68FFED3251
      FFFF0026FDFFE1E4FC1E00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000DCA9
      8700F9F2EB00FFFFFF00FFFFFF00FFFFFF00FFFDFB00FFF8F100FDF3E900DCA9
      8700FFB34E00E0A86C004D4D4D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005CE366005CE36600000000000000000000000000FAFBFF06E2E7FF256A84
      FFF2EEF1FF15FEFEFF0100000000000000000000000000000000E1E6FF265773
      FFDCE4E8FF1BFAFAFE0500000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DCA98700FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFDFB00FFF8F100DCA9
      8700E6BB93004D4D4D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000FDFDFF02F3F5
      FF0FFDFDFF02000000000000000000000000000000000000000000000000E7EA
      FF1FFAFBFF060000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000DCA98700DCA98700DCA98700DCA98700DCA98700DCA98700DCA98700DCA9
      87004D4D4D000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF00008007FFFFFFE70000
      0007FFFFEFC700000003FBFFC78300008003F1FF830300008003E0FFC0030000
      8003C07FE00700000001843FF00F000000018E1FF01F000000019F0FF01F0000
      C000FF87E00F0000E000FFC380070000E000FFE381830000E001FFF383C30000
      F003FFFFC7E70000F007FFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
  object pm_ProcessedActions: TPopupMenu
    Left = 224
    Top = 424
  end
end
