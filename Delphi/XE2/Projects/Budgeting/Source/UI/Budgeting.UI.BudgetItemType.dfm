inherited frmBudgetItemType: TfrmBudgetItemType
  ClientHeight = 151
  ExplicitWidth = 400
  ExplicitHeight = 192
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvl1: TBevel
    Top = 115
    ExplicitTop = 83
  end
  inherited pnlButtons: TPanel
    Top = 126
    TabOrder = 4
    ExplicitTop = 94
    inherited pbProgress: TcxProgressBar
      ExplicitHeight = 23
    end
  end
  object cxlblName: TcxLabel [2]
    AlignWithMargins = True
    Left = 3
    Top = 6
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077':'
    FocusControl = edtName
  end
  object edtName: TcxTextEdit [3]
    AlignWithMargins = True
    Left = 3
    Top = 29
    Align = alTop
    Properties.OnChange = edtNamePropertiesChange
    Properties.OnEditValueChanged = edtNamePropertiesEditValueChanged
    TabOrder = 1
    Width = 376
  end
  object chkActivity: TcxCheckBox [4]
    AlignWithMargins = True
    Left = 3
    Top = 89
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1040#1082#1090#1080#1074#1085#1086#1089#1090#1100
    Properties.OnChange = chkActivityPropertiesChange
    Properties.OnEditValueChanged = chkActivityPropertiesEditValueChanged
    TabOrder = 3
    ExplicitTop = 59
    Width = 376
  end
  object chkSign: TcxCheckBox [5]
    AlignWithMargins = True
    Left = 3
    Top = 59
    Margins.Top = 6
    Align = alTop
    Caption = #1054'&'#1090#1088#1080#1094#1072#1090#1077#1083#1100#1085#1099#1077' '#1086#1087#1077#1088#1072#1094#1080#1080' ('#1089' '#1084#1080#1085#1091#1089#1086#1084')'
    Properties.OnChange = chkSignPropertiesChange
    Properties.OnEditValueChanged = chkSignPropertiesEditValueChanged
    TabOrder = 2
    ExplicitLeft = 8
    ExplicitTop = 49
    Width = 376
  end
  inherited ActionList: TActionList
    Left = 304
    Top = 0
  end
end
