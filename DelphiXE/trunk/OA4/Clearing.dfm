object ClearingForm: TClearingForm
  Left = 0
  Top = 0
  Anchors = [akLeft, akBottom]
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054#1095#1080#1089#1090#1082#1072' '#1073#1072#1079#1099' '#1076#1072#1085#1085#1099#1093
  ClientHeight = 198
  ClientWidth = 428
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  DesignSize = (
    428
    198)
  PixelsPerInch = 96
  TextHeight = 13
  object sbClearing: TStatusBar
    Left = 0
    Top = 179
    Width = 428
    Height = 19
    Panels = <>
    SimplePanel = True
    SizeGrip = False
  end
  object btnClearing: TButton
    Left = 349
    Top = 153
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Anchors = [akLeft, akBottom]
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100
    Default = True
    TabOrder = 1
    OnClick = btnClearingClick
  end
  object pbClearingTotal: TProgressBar
    Left = 5
    Top = 153
    Width = 338
    Height = 25
    Anchors = [akLeft, akBottom]
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 5
    Top = 0
    Width = 419
    Height = 149
    Caption = ' '
    TabOrder = 3
    object chkbxClearingPhoneTable: TCheckBox
      Left = 5
      Top = 11
      Width = 170
      Height = 17
      Caption = #1058#1072#1073#1083#1080#1094#1072' '#1090#1077#1083#1077#1092#1086#1085#1086#1074
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = chkbxClearingPhoneTableClick
    end
    object chkbxClearingMeasureTable: TCheckBox
      Left = 5
      Top = 34
      Width = 170
      Height = 17
      Caption = #1058#1072#1073#1083#1080#1094#1072' '#1084#1077#1088#1086#1087#1088#1080#1103#1090#1080#1081
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = chkbxClearingPhoneTableClick
    end
    object chkbxClearingOrganizationTable: TCheckBox
      Left = 5
      Top = 57
      Width = 170
      Height = 17
      Caption = #1058#1072#1073#1083#1080#1094#1072' '#1086#1088#1075#1072#1085#1080#1079#1072#1094#1080#1081
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = chkbxClearingPhoneTableClick
    end
    object chkbxClearingMessageTable: TCheckBox
      Left = 5
      Top = 80
      Width = 170
      Height = 17
      Caption = #1058#1072#1073#1083#1080#1094#1072' '#1089#1086#1086#1073#1097#1077#1085#1080#1081
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = chkbxClearingPhoneTableClick
    end
    object chkbxClearingEventTable: TCheckBox
      Left = 5
      Top = 103
      Width = 170
      Height = 17
      Caption = #1058#1072#1073#1083#1080#1094#1072' '#1089#1086#1073#1099#1090#1080#1081
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 8
      OnClick = chkbxClearingPhoneTableClick
    end
    object chkbxClearingUserTable: TCheckBox
      Left = 5
      Top = 126
      Width = 170
      Height = 17
      Caption = #1058#1072#1073#1083#1080#1094#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      OnClick = chkbxClearingPhoneTableClick
    end
    object pbClearingPhonesDetail: TProgressBar
      Left = 206
      Top = 11
      Width = 207
      Height = 17
      TabOrder = 1
    end
    object pbClearingMeasuresDetail: TProgressBar
      Left = 206
      Top = 34
      Width = 207
      Height = 17
      TabOrder = 3
    end
    object pbClearingOrganizationsDetail: TProgressBar
      Left = 206
      Top = 57
      Width = 207
      Height = 17
      TabOrder = 5
    end
    object pbClearingMessagesDetail: TProgressBar
      Left = 206
      Top = 80
      Width = 207
      Height = 17
      TabOrder = 7
    end
    object pbClearingEventsDetail: TProgressBar
      Left = 206
      Top = 103
      Width = 207
      Height = 17
      TabOrder = 9
    end
    object pbClearingUsersDetail: TProgressBar
      Left = 206
      Top = 126
      Width = 207
      Height = 17
      TabOrder = 11
    end
  end
end
