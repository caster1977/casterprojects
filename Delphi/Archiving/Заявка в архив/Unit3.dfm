object ItemSelectionForm: TItemSelectionForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  BorderWidth = 6
  ClientHeight = 200
  ClientWidth = 302
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    AlignWithMargins = True
    Left = 0
    Top = 175
    Width = 302
    Height = 25
    Margins.Left = 0
    Margins.Top = 6
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'pnlBottom'
    ShowCaption = False
    TabOrder = 0
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 227
      Top = 0
      Width = 75
      Height = 25
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Action = actCancel
      Align = alRight
      TabOrder = 1
    end
    object btnApply: TButton
      AlignWithMargins = True
      Left = 146
      Top = 0
      Width = 75
      Height = 25
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 6
      Margins.Bottom = 0
      Action = actApply
      Align = alRight
      TabOrder = 0
    end
  end
  object clbList: TCheckListBox
    Left = 0
    Top = 0
    Width = 302
    Height = 169
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    ExplicitLeft = 80
    ExplicitTop = 40
    ExplicitWidth = 121
    ExplicitHeight = 97
  end
  object ActionList1: TActionList
    Left = 72
    Top = 168
    object actApply: TAction
      Caption = 'RsApply'
      OnExecute = actApplyExecute
    end
    object actCancel: TAction
      Caption = 'RsCancel'
      OnExecute = actCancelExecute
    end
  end
end
