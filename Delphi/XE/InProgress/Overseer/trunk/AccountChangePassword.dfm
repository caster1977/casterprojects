object AccountChangePasswordForm: TAccountChangePasswordForm
  Left = 0
  Top = 0
  ActiveControl = mskPassword
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 6
  Caption = #1048#1079#1084#1077#1085#1077#1085#1080#1077' '#1087#1072#1088#1086#1083#1103' '#1076#1083#1103
  ClientHeight = 86
  ClientWidth = 282
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
  DesignSize = (
    282
    86)
  PixelsPerInch = 96
  TextHeight = 13
  object lblPassword: TLabel
    Left = 0
    Top = 3
    Width = 41
    Height = 13
    Caption = #1055'&'#1072#1088#1086#1083#1100':'
    FocusControl = mskPassword
  end
  object lblConfirmation: TLabel
    Left = 0
    Top = 30
    Width = 87
    Height = 13
    Caption = #1055#1086'&'#1076#1090#1074#1077#1088#1078#1076#1077#1085#1080#1077':'
    FocusControl = mskConfirmation
  end
  object Bevel1: TBevel
    Left = 0
    Top = 54
    Width = 282
    Height = 32
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 56
  end
  object mskPassword: TMaskEdit
    Left = 93
    Top = 0
    Width = 189
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    TextHint = #1042#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    OnChange = FieldsChange
  end
  object mskConfirmation: TMaskEdit
    Left = 93
    Top = 27
    Width = 189
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
    TextHint = #1055#1086#1074#1090#1086#1088#1085#1086' '#1074#1074#1077#1076#1080#1090#1077' '#1085#1086#1074#1099#1081' '#1087#1072#1088#1086#1083#1100
    OnChange = FieldsChange
  end
  object btnCancel: TButton
    Left = 202
    Top = 61
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Cancel
    Anchors = [akRight, akBottom]
    Cancel = True
    TabOrder = 2
  end
  object btnHelp: TButton
    Left = 0
    Top = 61
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Help
    Anchors = [akLeft, akBottom]
    TabOrder = 3
  end
  object btnApply: TButton
    Left = 116
    Top = 61
    Width = 80
    Height = 25
    Cursor = crHandPoint
    Action = Action_Apply
    Anchors = [akRight, akBottom]
    TabOrder = 4
  end
  object ActionManager1: TActionManager
    Left = 56
    StyleName = 'Platform Default'
    object Action_Apply: TAction
      Caption = '&'#1055#1088#1080#1084#1077#1085#1080#1090#1100
      OnExecute = Action_ApplyExecute
    end
    object Action_Cancel: TAction
      Caption = '&'#1054#1090#1084#1077#1085#1072
      OnExecute = Action_CancelExecute
    end
    object Action_Help: TAction
      Caption = '&'#1057#1087#1088#1072#1074#1082#1072
      OnExecute = Action_HelpExecute
    end
  end
end
