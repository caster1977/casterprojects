object EnterStringForm: TEnterStringForm
  Left = 0
  Top = 0
  ActiveControl = edtEnterString
  BorderStyle = bsDialog
  BorderWidth = 6
  ClientHeight = 82
  ClientWidth = 387
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
  object pnlButtons: TPanel
    Left = 0
    Top = 51
    Width = 387
    Height = 31
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      387
      31)
    object btnCancel: TButton
      Left = 312
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actCancel
      Anchors = [akTop, akRight]
      Cancel = True
      ModalResult = 2
      TabOrder = 0
    end
    object btnOk: TButton
      Left = 231
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Action = actOk
      Anchors = [akTop, akRight]
      ModalResult = 1
      TabOrder = 1
    end
  end
  object gbEnterString: TGroupBox
    Left = 0
    Top = 0
    Width = 387
    Height = 51
    Align = alClient
    TabOrder = 1
    DesignSize = (
      387
      51)
    object edtEnterString: TEdit
      Left = 10
      Top = 18
      Width = 368
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object ActionList1: TActionList
    Left = 96
    Top = 50
    object actOk: TAction
      Caption = '&Ok'
      OnExecute = actOkExecute
      OnUpdate = actOkUpdate
    end
    object actCancel: TAction
      Caption = '&'#1054#1090#1084#1077#1085#1072
      OnExecute = actCancelExecute
    end
  end
end
