inherited frmPlannedBudget: TfrmPlannedBudget
  ClientHeight = 356
  ExplicitWidth = 400
  ExplicitHeight = 397
  PixelsPerInch = 96
  TextHeight = 13
  inherited bvl1: TBevel
    Top = 320
    ExplicitTop = 479
  end
  inherited pnlButtons: TPanel
    Top = 331
    TabOrder = 12
    ExplicitTop = 331
    inherited pbProgress: TcxProgressBar
      ExplicitHeight = 23
    end
  end
  object cxlblBudgetItem: TcxLabel [2]
    AlignWithMargins = True
    Left = 3
    Top = 6
    Margins.Top = 6
    Align = alTop
    Caption = #1057'&'#1090#1072#1090#1100#1103' '#1073#1102#1076#1078#1077#1090#1072':'
    FocusControl = cbbBudgetItem
  end
  object cbbBudgetItem: TcxComboBox [3]
    AlignWithMargins = True
    Left = 3
    Top = 29
    Align = alTop
    Properties.DropDownListStyle = lsEditFixedList
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = cbbBudgetItemPropertiesEditValueChanged
    TabOrder = 0
    Width = 376
  end
  object cxlblMonth: TcxLabel [4]
    AlignWithMargins = True
    Left = 3
    Top = 218
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1052#1077#1089#1103#1094':'
    FocusControl = cbbMonth
  end
  object cxlblAccountingCenter: TcxLabel [5]
    AlignWithMargins = True
    Left = 3
    Top = 59
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1062#1077#1085#1090#1088' '#1092#1080#1085#1072#1085#1089#1086#1074#1086#1081' '#1086#1090#1074#1077#1090#1089#1090#1074#1077#1085#1085#1086#1089#1090#1080':'
    FocusControl = cbbAccountingCenter
  end
  object cbbAccountingCenter: TcxComboBox [6]
    AlignWithMargins = True
    Left = 3
    Top = 82
    Align = alTop
    Properties.DropDownListStyle = lsEditFixedList
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = cbbAccountingCenterPropertiesEditValueChanged
    TabOrder = 1
    Width = 376
  end
  object cxlblCurrency: TcxLabel [7]
    AlignWithMargins = True
    Left = 3
    Top = 112
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1042#1072#1083#1102#1090#1072':'
    FocusControl = cbbCurrency
  end
  object cbbCurrency: TcxComboBox [8]
    AlignWithMargins = True
    Left = 3
    Top = 135
    Align = alTop
    Properties.DropDownListStyle = lsEditFixedList
    Properties.ImmediatePost = True
    Properties.OnEditValueChanged = cbbCurrencyPropertiesEditValueChanged
    TabOrder = 2
    Width = 376
  end
  object pnlDocumentDate: TPanel [9]
    AlignWithMargins = True
    Left = 3
    Top = 188
    Width = 376
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    object cbbYear: TcxComboBox
      Left = 0
      Top = 0
      Align = alLeft
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = cbbYearPropertiesEditValueChanged
      TabOrder = 0
      Width = 121
    end
  end
  object cxlblYear: TcxLabel [10]
    AlignWithMargins = True
    Left = 3
    Top = 165
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1043#1086#1076':'
    FocusControl = cbbYear
  end
  object cxlblAmount: TcxLabel [11]
    AlignWithMargins = True
    Left = 3
    Top = 271
    Margins.Top = 6
    Align = alTop
    Caption = '&'#1057#1091#1084#1084#1072':'
    FocusControl = cxcrncydtAmount
  end
  object pnlAmount: TPanel [12]
    AlignWithMargins = True
    Left = 3
    Top = 294
    Width = 376
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 7
    object cxcrncydtAmount: TcxCurrencyEdit
      Left = 0
      Top = 0
      Align = alLeft
      Properties.Alignment.Horz = taRightJustify
      Properties.AssignedValues.EditFormat = True
      Properties.DisplayFormat = ',0.00;-,0.00'
      Properties.UseDisplayFormatWhenEditing = True
      Properties.OnChange = cxcrncydtAmountPropertiesChange
      Properties.OnEditValueChanged = cxcrncydtAmountPropertiesEditValueChanged
      TabOrder = 0
      Width = 121
    end
  end
  object pnlMonth: TPanel [13]
    AlignWithMargins = True
    Left = 3
    Top = 241
    Width = 376
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 5
    object cbbMonth: TcxComboBox
      Left = 0
      Top = 0
      Align = alLeft
      Properties.DropDownListStyle = lsFixedList
      Properties.ImmediatePost = True
      Properties.OnEditValueChanged = cbbMonthPropertiesEditValueChanged
      TabOrder = 0
      Width = 121
    end
  end
end
