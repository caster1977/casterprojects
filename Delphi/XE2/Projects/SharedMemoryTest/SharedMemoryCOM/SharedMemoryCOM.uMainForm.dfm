object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Shared Memory COM-application'
  ClientHeight = 120
  ClientWidth = 306
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
    306
    120)
  PixelsPerInch = 96
  TextHeight = 13
  object lblSharedMemoryName: TLabel
    Left = 8
    Top = 8
    Width = 250
    Height = 13
    Caption = #1048#1084#1103' '#1086#1073#1098#1077#1082#1090#1072' '#1086#1073#1097#1077#1081' '#1087#1072#1084#1103#1090#1080' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1089#1077#1089#1089#1080#1080':'
    FocusControl = edbxSharedMemoryName
  end
  object edbxSharedMemoryName: TEdit
    Left = 8
    Top = 27
    Width = 290
    Height = 21
    Alignment = taCenter
    Anchors = [akLeft, akTop, akRight]
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object btnRegisterCOMServer: TButton
    Left = 8
    Top = 54
    Width = 290
    Height = 25
    Cursor = crHandPoint
    Action = Action_Register
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 1
  end
  object btnUnregisterCOMServer: TButton
    Left = 8
    Top = 87
    Width = 290
    Height = 25
    Cursor = crHandPoint
    Action = Action_Unregister
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 2
  end
  object ActionManager1: TActionManager
    Left = 32
    Top = 24
    StyleName = 'Platform Default'
    object Action_Register: TAction
      Caption = #1047#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1090#1100' COM-'#1086#1073#1098#1077#1082#1090
      HelpKeyword = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1085#1077#1089#1077#1085#1080#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086' COM-'#1086#1073#1098#1077#1082#1090#1077' '#1074' '#1089#1080#1089#1090#1077#1084#1085#1099#1081' '#1088#1077#1077#1089#1090#1088 +
        ' Windows'
      OnExecute = Action_RegisterExecute
      OnUpdate = Action_RegisterUpdate
    end
    object Action_Unregister: TAction
      Caption = #1054#1090#1084#1077#1085#1080#1090#1100' '#1088#1077#1075#1080#1089#1090#1088#1072#1094#1080#1102' COM-'#1086#1073#1098#1077#1082#1090#1072
      Hint = 
        #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1091#1076#1072#1083#1077#1085#1080#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1080' '#1086' COM-'#1086#1073#1098#1077#1082#1090#1077' '#1080#1079' '#1089#1080#1089#1090#1077#1084#1085#1086#1075#1086' '#1088#1077#1077#1089 +
        #1090#1088#1072' Windows'
      OnExecute = Action_UnregisterExecute
      OnUpdate = Action_UnregisterUpdate
    end
  end
end
