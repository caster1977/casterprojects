object MainForm: TMainForm
  Left = 0
  Top = 0
  ActiveControl = ledFrom
  BorderStyle = bsDialog
  Caption = 'MAPI Test'
  ClientHeight = 222
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  DesignSize = (
    482
    222)
  PixelsPerInch = 96
  TextHeight = 13
  object lblBody: TLabel
    Left = 8
    Top = 127
    Width = 33
    Height = 13
    Caption = #1058#1077#1082#1089#1090':'
    FocusControl = meBody
  end
  object btnSend: TButton
    Left = 399
    Top = 146
    Width = 75
    Height = 31
    Action = actSendByMAPI
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 4
    WordWrap = True
  end
  object ledFrom: TLabeledEdit
    Left = 8
    Top = 20
    Width = 466
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = #1054#1090' '#1082#1086#1075#1086':'
    TabOrder = 0
    Text = 'v_ivanov@rtl.by'
    ExplicitWidth = 456
  end
  object ledTo: TLabeledEdit
    Left = 8
    Top = 60
    Width = 466
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = #1050#1086#1084#1091':'
    TabOrder = 1
    Text = 'caster1977@yandex.ru'
    ExplicitWidth = 456
  end
  object ledSubject: TLabeledEdit
    Left = 8
    Top = 100
    Width = 466
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = #1058#1077#1084#1072':'
    TabOrder = 2
    Text = 'Test'
    ExplicitWidth = 456
  end
  object meBody: TMemo
    Left = 8
    Top = 146
    Width = 385
    Height = 68
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      #1058#1077#1089#1090#1086#1074#1086#1077' '#1087#1080#1089#1100#1084#1086'.')
    TabOrder = 3
    ExplicitHeight = 67
  end
  object Button1: TButton
    Left = 399
    Top = 183
    Width = 75
    Height = 31
    Action = actSendBySMTP
    Anchors = [akTop, akRight, akBottom]
    TabOrder = 5
    WordWrap = True
  end
  object ActionList: TActionList
    Left = 416
    Top = 24
    object actSendByMAPI: TAction
      Category = 'Internet'
      Caption = 'MAPI'
      OnExecute = actSendByMAPIExecute
      OnUpdate = actSendByMAPIUpdate
    end
    object actSendBySMTP: TAction
      Category = 'Internet'
      Caption = 'SMTP'
      OnExecute = actSendBySMTPExecute
      OnUpdate = actSendBySMTPUpdate
    end
  end
  object IdSMTP: TIdSMTP
    SASLMechanisms = <>
    Left = 296
    Top = 24
  end
  object IdMessage: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 352
    Top = 24
  end
end
