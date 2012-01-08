object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Shared Memory COM-application'
  ClientHeight = 87
  ClientWidth = 350
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMinimized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 250
    Height = 13
    Caption = #1048#1084#1103' '#1086#1073#1098#1077#1082#1090#1072' '#1086#1073#1097#1077#1081' '#1087#1072#1084#1103#1090#1080' '#1076#1083#1103' '#1090#1077#1082#1091#1097#1077#1081' '#1089#1077#1089#1089#1080#1080':'
    FocusControl = Edit1
  end
  object Edit1: TEdit
    Left = 8
    Top = 27
    Width = 334
    Height = 21
    ParentColor = True
    ReadOnly = True
    TabOrder = 0
  end
  object Button1: TButton
    Left = 192
    Top = 54
    Width = 150
    Height = 25
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' COM-'#1089#1077#1088#1074#1077#1088#1072
    TabOrder = 1
    OnClick = Button1Click
  end
end
