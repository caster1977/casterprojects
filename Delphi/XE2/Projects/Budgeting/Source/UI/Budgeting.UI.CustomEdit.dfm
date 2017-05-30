object frmCustomEdit: TfrmCustomEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077'/'#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1101#1083#1077#1084#1077#1085#1090#1072
  ClientHeight = 226
  ClientWidth = 382
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object bvl1: TBevel
    Left = 0
    Top = 190
    Width = 382
    Height = 5
    Align = alBottom
    Shape = bsBottomLine
    ExplicitTop = 191
    ExplicitWidth = 299
  end
  object pnlButtons: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 201
    Width = 382
    Height = 25
    Margins.Left = 0
    Margins.Top = 6
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 307
      Top = 0
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Margins.Left = 6
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = actCancel
      Align = alRight
      Cancel = True
      TabOrder = 1
    end
    object btnSave: TButton
      AlignWithMargins = True
      Left = 226
      Top = 0
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Margins.Left = 6
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = actSave
      Align = alRight
      Default = True
      TabOrder = 0
    end
    object pbProgress: TcxProgressBar
      AlignWithMargins = True
      Left = 0
      Top = 1
      Margins.Left = 0
      Margins.Top = 1
      Margins.Right = 0
      Margins.Bottom = 1
      Align = alClient
      Properties.AssignedValues.Min = True
      Properties.BeginColor = 54056
      Properties.PeakValue = 20.000000000000000000
      Properties.ShowTextStyle = cxtsText
      Properties.SolidTextColor = True
      TabOrder = 2
      Visible = False
      Width = 220
    end
  end
  object ActionList: TActionList
    Left = 224
    Top = 32
    object actSave: TAction
      Caption = '&'#1057#1086#1093#1088#1072#1085#1080#1090#1100
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      OnExecute = actSaveExecute
      OnUpdate = actSaveUpdate
    end
    object actCancel: TAction
      Caption = '&'#1054#1090#1084#1077#1085#1072
      Hint = #1054#1090#1084#1077#1085#1080#1090#1100' '#1080#1079#1084#1077#1085#1077#1085#1080#1103'|'#1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1080#1079#1084#1077#1085#1077#1085#1080#1081
      OnExecute = actCancelExecute
      OnUpdate = actCancelUpdate
    end
  end
end
