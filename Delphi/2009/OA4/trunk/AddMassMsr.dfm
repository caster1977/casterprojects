object AddMassMsrForm: TAddMassMsrForm
  Left = 0
  Top = 0
  ActiveControl = lvMsrDateTimeList
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 5
  Caption = #1052#1072#1089#1089#1086#1074#1086#1077' '#1088#1072#1079#1084#1085#1086#1078#1077#1085#1080#1077' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1103
  ClientHeight = 281
  ClientWidth = 333
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 171
    Height = 244
    Align = alLeft
    Shape = bsRightLine
    ExplicitHeight = 213
  end
  object Bevel2: TBevel
    Left = 0
    Top = 0
    Width = 171
    Height = 180
    Align = alCustom
    Shape = bsBottomLine
  end
  object lblPeriod: TLabel
    Left = 0
    Top = 159
    Width = 162
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = '-'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Layout = tlCenter
  end
  object lvMsrDateTimeList: TListView
    Left = 177
    Top = -1
    Width = 156
    Height = 208
    Columns = <
      item
        Caption = #1044#1072#1090#1072
        Width = 70
      end
      item
        Caption = #1042#1088#1077#1084#1103
        Width = 60
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SortType = stBoth
    TabOrder = 3
    ViewStyle = vsReport
    OnCompare = lvMsrDateTimeListCompare
    OnSelectItem = lvMsrDateTimeListSelectItem
  end
  object btnDelete: TButton
    Left = 177
    Top = 213
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&'#1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
    OnClick = btnDeleteClick
  end
  object MonthCalendar1: TMonthCalendar
    Left = 0
    Top = 0
    Width = 162
    Height = 153
    MultiSelect = True
    Date = 39794.581519953700000000
    EndDate = 39794.000000000000000000
    MinDate = 36526.000000000000000000
    TabOrder = 0
    OnClick = MonthCalendar1Click
  end
  object edbxTime: TEdit
    Left = 0
    Top = 186
    Width = 162
    Height = 21
    TabOrder = 1
    OnChange = edbxTimeChange
  end
  object btnInsert: TButton
    Left = 87
    Top = 213
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&'#1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = btnInsertClick
  end
  object pnlButtons: TPanel
    Left = 0
    Top = 244
    Width = 333
    Height = 37
    Align = alBottom
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 6
    object btnAccept: TButton
      Left = 4
      Top = 4
      Width = 158
      Height = 25
      Cursor = crHandPoint
      Caption = '&'#1055#1086#1076#1090#1074#1077#1088#1076#1080#1090#1100
      TabOrder = 0
      OnClick = btnAcceptClick
    end
    object btnClose: TButton
      Left = 168
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      Default = True
      ModalResult = 2
      TabOrder = 1
    end
    object btnHelp: TButton
      Left = 249
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      TabOrder = 2
    end
  end
  object btnClear: TButton
    Left = 258
    Top = 213
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&'#1054#1095#1080#1089#1090#1080#1090#1100
    TabOrder = 5
    OnClick = btnClearClick
  end
end
