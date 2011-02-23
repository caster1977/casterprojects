object ViewPostForm: TViewPostForm
  Left = 0
  Top = 0
  Hint = #1054#1082#1085#1086' '#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1080#1103' '#1089#1090#1072#1090#1080#1089#1090#1080#1095#1077#1089#1082#1080#1093' '#1086#1090#1095#1105#1090#1086#1074
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
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 219
    Width = 634
    Height = 37
    Align = alBottom
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      630
      33)
    object btnCreate: TButton
      Left = 4
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1079#1076#1072#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      Anchors = [akTop, akRight]
      Caption = '&'#1057#1086#1079#1076#1072#1090#1100
      Enabled = False
      TabOrder = 0
    end
    object btnClose: TButton
      Left = 469
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072
      Anchors = [akTop, akRight]
      Cancel = True
      Caption = '&'#1047#1072#1082#1088#1099#1090#1100
      Default = True
      ModalResult = 2
      TabOrder = 1
    end
    object btnHelp: TButton
      Left = 550
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      Anchors = [akTop, akRight]
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      TabOrder = 2
    end
    object btnEdit: TButton
      Left = 85
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1085#1077#1089#1077#1085#1080#1103' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1074' '#1091#1082#1072#1079#1072#1085#1085#1099#1081' '#1085#1086#1084#1077#1088
      Anchors = [akTop, akRight]
      Caption = '&'#1048#1089#1087#1088#1072#1074#1080#1090#1100
      Enabled = False
      TabOrder = 3
    end
    object btnDelete: TButton
      Left = 166
      Top = 4
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1085#1086#1084#1077#1088#1072' '#1090#1077#1083#1077#1092#1086#1085#1072
      Anchors = [akTop, akRight]
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      Enabled = False
      TabOrder = 4
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 0
    Width = 634
    Height = 219
    Align = alClient
    ColCount = 2
    DefaultColWidth = 314
    DefaultRowHeight = 23
    FixedCols = 0
    RowCount = 9
    ScrollBars = ssVertical
    TabOrder = 1
    ExplicitTop = -2
    ColWidths = (
      137
      491)
  end
end
