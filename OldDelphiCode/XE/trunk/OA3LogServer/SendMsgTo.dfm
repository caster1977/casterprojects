object SendMsgToForm: TSendMsgToForm
  Left = 0
  Top = 0
  ActiveControl = SendMessageTo_Memo
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  BorderWidth = 2
  Caption = #1054#1090#1087#1088#1072#1074#1082#1072' '#1090#1077#1082#1089#1090#1086#1074#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
  ClientHeight = 114
  ClientWidth = 390
  Color = clBtnFace
  Constraints.MinHeight = 143
  Constraints.MinWidth = 300
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
    390
    114)
  PixelsPerInch = 96
  TextHeight = 13
  object MessageGroupBox: TGroupBox
    Left = 0
    Top = 0
    Width = 303
    Height = 114
    Align = alLeft
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = ' '#1042#1074#1077#1076#1080#1090#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1076#1083#1103' '#1086#1090#1087#1088#1072#1074#1082#1080': '
    TabOrder = 0
    DesignSize = (
      303
      114)
    object SendMessageTo_Memo: TMemo
      Left = 7
      Top = 15
      Width = 288
      Height = 91
      Hint = 
        #1042#1074#1077#1076#1080#1090#1077' '#1090#1077#1082#1089#1090#1086#1074#1086#1077' '#1089#1086#1086#1073#1097#1077#1085#1080#1077' '#1076#1083#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1091#1082#1072#1079#1072#1085#1085#1086#1084#1091' '#1082#1083#1080#1077#1085#1090#1091' '#1080' '#1085#1072 +
        #1078#1084#1080#1090#1077' '#1082#1085#1086#1087#1082#1091' "'#1054#1090#1087#1088#1072#1074#1080#1090#1100'"'
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      OnChange = SendMessageTo_MemoChange
    end
  end
  object Button1: TButton
    Left = 312
    Top = 5
    Width = 75
    Height = 25
    Action = Action_Send
    Anchors = [akTop, akRight]
    ModalResult = 1
    TabOrder = 1
  end
  object Button2: TButton
    Left = 312
    Top = 35
    Width = 75
    Height = 25
    Action = Action_Close
    Anchors = [akTop, akRight]
    Cancel = True
    ModalResult = 2
    TabOrder = 2
  end
  object Button3: TButton
    Left = 312
    Top = 65
    Width = 75
    Height = 25
    Action = Action_Help
    Anchors = [akTop, akRight]
    TabOrder = 3
  end
  object ForAll_CheckBox: TCheckBox
    Left = 311
    Top = 95
    Width = 75
    Height = 17
    Hint = 
      #1055#1086#1089#1090#1072#1074#1100#1090#1077' '#1075#1072#1083#1086#1095#1082#1091' '#1076#1083#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1074#1074#1077#1076#1105#1085#1085#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1089#1088#1072#1079#1091' '#1074#1089#1077#1084' '#1072 +
      #1082#1090#1080#1074#1085#1099#1084' '#1082#1083#1080#1077#1085#1090#1072#1084
    Anchors = [akTop, akRight]
    Caption = #1089#1088#1072#1079#1091' '#1074#1089#1077#1084
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object ActionList1: TActionList
    Left = 15
    Top = 50
    object Action_Send: TAction
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100
      Enabled = False
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1074#1074#1077#1076#1105#1085#1085#1086#1075#1086' '#1089#1086#1086#1073#1097#1077#1085#1080#1103' '#1091#1082#1072#1079#1072#1085#1085#1086#1084#1091'  '#1082#1083#1080#1077#1085#1090#1091
      OnExecute = Action_SendExecute
    end
    object Action_Close: TAction
      Caption = #1047#1072#1082#1088#1099#1090#1100
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1079#1072#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1086#1090#1087#1088#1072#1074#1082#1080' '#1089#1086#1086#1073#1097#1077#1085#1080#1103
      ShortCut = 27
      OnExecute = Action_CloseExecute
    end
    object Action_Help: TAction
      Caption = #1057#1087#1088#1072#1074#1082#1072
      Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1086#1073#1088#1072#1078#1077#1085#1080#1103' '#1086#1082#1085#1072' '#1082#1086#1085#1090#1077#1082#1089#1090#1085#1086#1081' '#1089#1087#1088#1072#1074#1082#1080
      ShortCut = 112
      SecondaryShortCuts.Strings = (
        'Ctrl+H')
      OnExecute = Action_HelpExecute
    end
  end
end
