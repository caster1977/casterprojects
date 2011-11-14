object UsersForm: TUsersForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1059#1095#1105#1090#1085#1099#1077' '#1079#1072#1087#1080#1089#1080
  ClientHeight = 266
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnMouseWheelDown = FormMouseWheelDown
  OnMouseWheelUp = FormMouseWheelUp
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 206
    Top = 0
    Height = 266
  end
  object TreeView1: TTreeView
    Left = 0
    Top = 0
    Width = 206
    Height = 266
    Hint = #1057#1087#1080#1089#1086#1082' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081' '#1041#1044
    Align = alLeft
    HideSelection = False
    HotTrack = True
    Images = ImageList1
    Indent = 19
    ReadOnly = True
    TabOrder = 0
    OnChange = TreeView1Change
    OnChanging = TreeView1Changing
    Items.NodeData = {
      03020000003A000000020000000200000002000000FFFFFFFFFFFFFFFF000000
      0000000000010E100434043C0438043D043804410442044004300442043E0440
      044B0436000000020000000200000002000000FFFFFFFFFFFFFFFF0000000000
      000000010C1F043E043B044C0437043E0432043004420435043B043804}
  end
  object Panel2: TPanel
    Left = 209
    Top = 0
    Width = 435
    Height = 266
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    Constraints.MaxWidth = 435
    Constraints.MinWidth = 435
    FullRepaint = False
    TabOrder = 1
    object pnlButtons: TPanel
      Left = 2
      Top = 227
      Width = 431
      Height = 37
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      DesignSize = (
        431
        35)
      object btnClose: TButton
        Left = 260
        Top = 5
        Width = 80
        Height = 25
        Cursor = crHandPoint
        Hint = 
          #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1074#1089#1077#1093' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1074' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1080' '#1079#1072#1082 +
          #1088#1099#1090#1080#1103' '#1086#1082#1085#1072
        Anchors = [akTop, akRight]
        Cancel = True
        Caption = #1047#1072#1082#1088#1099#1090#1100
        ModalResult = 2
        TabOrder = 5
      end
      object btnHelp: TButton
        Left = 345
        Top = 5
        Width = 80
        Height = 25
        Cursor = crHandPoint
        Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1089#1087#1088#1072#1074#1082#1080' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
        Anchors = [akTop, akRight]
        Caption = #1057#1087#1088#1072#1074#1082#1072
        TabOrder = 6
      end
      object btnSaveUser: TButton
        Left = 90
        Top = 5
        Width = 80
        Height = 25
        Cursor = crHandPoint
        Hint = 
          #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1089#1086#1093#1088#1072#1085#1077#1085#1080#1103' '#1074#1085#1077#1089#1105#1085#1085#1099#1093' '#1074' '#1090#1077#1082#1091#1097#1091#1102' '#1091#1095#1105#1090#1085#1091#1102' '#1079#1072#1087#1080#1089#1100' '#1080#1079#1084#1077#1085#1077 +
          #1085#1080#1081
        Anchors = [akTop, akRight]
        Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
        Enabled = False
        TabOrder = 1
        OnClick = btnSaveUserClick
      end
      object btnAddUser: TButton
        Left = 5
        Top = 5
        Width = 80
        Height = 25
        Cursor = crHandPoint
        Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1085#1086#1074#1086#1081' '#1091#1095#1105#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080
        Anchors = [akTop, akRight]
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        TabOrder = 0
        OnClick = btnAddUserClick
      end
      object btnCancelAddingUser: TButton
        Left = 175
        Top = 5
        Width = 80
        Height = 25
        Cursor = crHandPoint
        Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1084#1077#1085#1099' '#1076#1086#1073#1072#1074#1083#1077#1085#1080#1103' '#1085#1086#1074#1086#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        Anchors = [akTop, akRight]
        Caption = #1054#1090#1084#1077#1085#1072
        TabOrder = 3
        Visible = False
        OnClick = btnCancelAddingUserClick
      end
      object btnRestoreUser: TButton
        Left = 175
        Top = 5
        Width = 80
        Height = 25
        Cursor = crHandPoint
        Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1074#1086#1089#1089#1090#1072#1085#1086#1074#1083#1077#1085#1080#1103' '#1074#1099#1076#1077#1083#1077#1085#1085#1086#1075#1086' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
        Anchors = [akTop, akRight]
        Caption = #1042#1086#1089#1089#1090#1072#1085#1086#1074#1080#1090#1100
        TabOrder = 4
        OnClick = btnRestoreUserClick
      end
      object btnEraseUser: TButton
        Left = 175
        Top = 5
        Width = 80
        Height = 25
        Cursor = crHandPoint
        Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1087#1086#1084#1077#1090#1082#1080' '#1090#1077#1082#1091#1097#1077#1081' '#1091#1095#1105#1090#1085#1086#1081' '#1079#1072#1087#1080#1089#1080' '#1082#1072#1082' '#1091#1076#1072#1083#1105#1085#1085#1086#1081
        Anchors = [akTop, akRight]
        Caption = #1059#1076#1072#1083#1080#1090#1100
        TabOrder = 2
        OnClick = btnEraseUserClick
      end
    end
    object PageControl1: TPageControl
      Left = 2
      Top = 2
      Width = 431
      Height = 225
      ActivePage = TabSheet2
      Align = alClient
      Style = tsButtons
      TabOrder = 0
      TabStop = False
      object TabSheet2: TTabSheet
        ImageIndex = 1
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object Label1: TLabel
          Left = 0
          Top = 25
          Width = 58
          Height = 21
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1087#1086#1083#1085#1086#1077' '#1080#1084#1103' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          Caption = #1055#1086#1083#1085#1086#1077' '#1080#1084#1103
          Constraints.MaxHeight = 21
          Constraints.MinHeight = 21
          FocusControl = edbxName
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
        end
        object Label2: TLabel
          Left = 0
          Top = 0
          Width = 30
          Height = 21
          Hint = #1042#1074#1077#1076#1080#1090#1077' '#1083#1086#1075#1080#1085' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
          Caption = #1051#1086#1075#1080#1085
          Constraints.MaxHeight = 21
          Constraints.MinHeight = 21
          FocusControl = edbxLogin
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
        end
        object lblCreationDetails: TLabel
          Left = 0
          Top = 170
          Width = 5
          Height = 13
          Caption = '?'
          Enabled = False
        end
        object lblModificationDetails: TLabel
          Left = 0
          Top = 200
          Width = 5
          Height = 13
          Caption = '?'
          Enabled = False
        end
        object lblID: TLabel
          Left = 300
          Top = 25
          Width = 11
          Height = 21
          Caption = 'ID'
          Constraints.MaxHeight = 21
          Constraints.MinHeight = 21
          FocusControl = edbxID
          Layout = tlCenter
        end
        object lblCreation: TLabel
          Left = 0
          Top = 155
          Width = 103
          Height = 13
          Caption = #1050#1090#1086' '#1080' '#1082#1086#1075#1076#1072' '#1089#1086#1079#1076#1072#1083':'
        end
        object lblModification: TLabel
          Left = 0
          Top = 185
          Width = 226
          Height = 13
          Caption = #1050#1090#1086' '#1080' '#1082#1086#1075#1076#1072' '#1087#1086#1089#1083#1077#1076#1085#1080#1081' '#1088#1072#1079' '#1084#1086#1076#1080#1092#1080#1094#1080#1088#1086#1074#1072#1083':'
        end
        object chkbxDBEdition: TCheckBox
          Left = 0
          Top = 55
          Width = 421
          Height = 17
          Caption = #1042#1085#1077#1089#1077#1085#1080#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1081' '#1074' '#1041#1044
          TabOrder = 4
          OnClick = UserDataChange
        end
        object chkbxDBBackup: TCheckBox
          Left = 0
          Top = 70
          Width = 421
          Height = 17
          Caption = #1056#1077#1079#1077#1088#1074#1080#1088#1086#1074#1072#1085#1080#1077' '#1041#1044
          TabOrder = 5
          OnClick = UserDataChange
        end
        object chkbxDBCleaning: TCheckBox
          Left = 0
          Top = 85
          Width = 421
          Height = 17
          Caption = #1063#1080#1089#1090#1082#1072' '#1041#1044
          TabOrder = 6
          OnClick = UserDataChange
        end
        object chkbxDBDefragmentation: TCheckBox
          Left = 0
          Top = 100
          Width = 421
          Height = 17
          Caption = #1044#1077#1092#1088#1072#1075#1084#1077#1085#1090#1072#1094#1080#1103' '#1041#1044
          TabOrder = 7
          OnClick = UserDataChange
        end
        object chkbxDBMaintenance: TCheckBox
          Left = 0
          Top = 115
          Width = 421
          Height = 17
          Caption = #1055#1086#1083#1085#1086#1077' '#1086#1073#1089#1083#1091#1078#1080#1074#1072#1085#1080#1077' '#1041#1044
          TabOrder = 8
          OnClick = UserDataChange
        end
        object chkbxDBUsersEdition: TCheckBox
          Left = 0
          Top = 130
          Width = 421
          Height = 17
          Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1080' '#1080#1079#1084#1077#1085#1077#1085#1080#1077' '#1089#1087#1080#1089#1082#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
          TabOrder = 9
          OnClick = UserDataChange
        end
        object edbxName: TEdit
          Left = 75
          Top = 25
          Width = 216
          Height = 21
          TabOrder = 2
          OnChange = UserDataChange
        end
        object edbxLogin: TEdit
          Left = 75
          Top = 0
          Width = 216
          Height = 21
          TabOrder = 0
          OnChange = UserDataChange
        end
        object edbxID: TEdit
          Left = 325
          Top = 25
          Width = 96
          Height = 21
          TabStop = False
          Enabled = False
          ReadOnly = True
          TabOrder = 3
          OnChange = UserDataChange
        end
        object btnSetPassword: TButton
          Left = 300
          Top = 0
          Width = 121
          Height = 21
          Cursor = crHandPoint
          Hint = #1053#1072#1078#1084#1080#1090#1077' '#1076#1083#1103' '#1086#1090#1082#1088#1099#1090#1080#1103' '#1086#1082#1085#1072' '#1074#1074#1086#1076#1072' '#1085#1086#1074#1086#1075#1086' '#1087#1072#1088#1086#1083#1103
          Caption = #1057#1084#1077#1085#1080#1090#1100' '#1087#1072#1088#1086#1083#1100'...'
          TabOrder = 1
          OnClick = btnSetPasswordClick
        end
      end
      object TabSheet1: TTabSheet
        TabVisible = False
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object lblHint: TLabel
          Left = 3
          Top = 0
          Width = 407
          Height = 41
          AutoSize = False
          Caption = '1'
          WordWrap = True
        end
      end
    end
  end
  object ImageList1: TImageList
    Left = 10
    Top = 230
    Bitmap = {
      494C010103000400180010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000071717100717171007171
      71006D6D6D006D6D6D006D6D6D006D6D6D006D6D6D0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000006D6D6D00B1654D008C5036008C50
      36008C5036008C5036006C554C006A635F00717171006D6D6D006D6D6D006D6D
      6D006D6D6D0071717100717171006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002AD5360000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000191F
      F800000000000000000000000000000000000000000000000000000000001C10
      BC0000000000000000000000000000000000E0664200DC513100F9635000FD72
      5C00F1684E00D7744500F1684E00D24C270035593800355938002F982D004890
      37002F982D0025662500355938006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00002AD5360001C911002AD53600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000582FFF000F31
      FF001B28FF0000000000000000000000000000000000000000003A11D3000014
      BD000C12B600000000000000000000000000D5885500F9635000FD7C6400FC8B
      6D00D5885500FFCF9C00F36D5300FD6A5700917930004DB34D006AA9660063CA
      630052C252003CB73C00239023006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000015CF
      230017E3260015E324000CD61B002AD536000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000002D44
      FF001132FF00072AFF000000000000000000000000002213CE000017CF001214
      C8000000000000000000000000000000000000000000E0664200FD846900EB80
      5900FFCF9C00FFCF9C00EF765600FD6B580080AB670080B38000FFEFDF004DB3
      4D0075D275004FC14F00489037006D6D6D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000008CF170017E3
      260039E3460041D64C002BE138001DD82B002AD5360000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003440FF001132FF000D21FF00000000002715DB00001CE0001715D2000000
      0000000000000000000000000000000000000000000000000000B1654D004C21
      4F002E3457007F4C6E00B1654D00917930007CD77C008FE08F00FFF7E800BFD9
      AC005BC55B0044A6440000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000012D120001DE32C0039E3
      460043E34F000000000052DA5C002FDD3C0010D71E002AD53600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000503CFF001136FF00001FF300091DE9003613DA00000000000000
      000000000000000000000000000000000000000000001717170005070E000D29
      6800143AA000102F9500081D6C00545454006AA96600427399001579BA00247D
      B600377D57004D4D4D0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000001DE32C0039E3460043E3
      4F0000000000000000000000000052DA5C002FDD3C0024D030002AD536000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000002446FF000D31FF00091FF10000000000000000000000
      0000000000000000000000000000000000003F3F3F001A1A1A00102C5B001A4D
      B3001C56BC001B51B700102F950054545400699AAE002C92F1003399FF003399
      FF002C92F1002C586F0084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000039E3460051E35B000000
      00000000000000000000000000000000000052DA5C001EDE2D003ACF45002AD5
      3600000000000000000000000000000000000000000000000000000000000000
      0000000000003C5CFF002C4CFF00323EFF001334FF00051EEA00000000000000
      00000000000000000000000000000000000012121200282828000F2D93002774
      DA002671D7002671D7001E5AC0005A6064003F95C30040A6FF0040A6FF0040A6
      FF003DA2FF002385C6006D6D6D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000052DA5C0015DC240042D0
      4D002AD536000000000000000000000000000000000000000000000000000000
      00004362FF003A59FF00535EFF00000000004B58FF001F41FF00001FED000000
      0000000000000000000000000000000000002C2C2C00363636002C586F003191
      F9003399FF003694F700246AD0005A606400479FD0004BB1FF004BB1FF004DB3
      FF0049AFFF002D92E60066666600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000052DA5C0015DC
      240042D04D002AD536000000000000000000000000000000000000000000506F
      FF005776FF007458FF000000000000000000000000004A57FF00284AFF000021
      F700000000000000000000000000000000006D6D6D004A4A4A003F3F3F004646
      4600143FA4002060C600135F88007E7E7E0057A9D7004DB3F2004DB3F20055BB
      FF0051B7FF0043A8ED006D6D6D00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000000052DA
      5C0019DD270019DD2700000000000000000000000000000000005F76FF005D7B
      FF006A6DFF0000000000000000000000000000000000000000004B56FF003251
      FF000026FD000000000000000000000000000000000038383800666666008F8F
      8F00A4A4A4004D4D4D00464646000000000063ABD200247DB60057A9D70063AB
      D200479FD0001372A200699AAE00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005CE366005CE3660000000000000000000000000000000000000000006A78
      FF00000000000000000000000000000000000000000000000000000000005850
      FF000000000000000000000000000000000000000000000000006D6D6D00605E
      5E00605E5E00666666000000000000000000000000003A8BB70084C0E400A3D0
      EA00479FD000699AAE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000003A8BB7003A8B
      B7003A8BB7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFFFFFF0000FFFFFFFF807F0000
      FFFFFFFF00000000FBFFEFEF00000000F1FFC7C700000000E0FFE38F80000000
      C07FF11FC0030000843FF83F800300008E1FFC7F000100009F0FF83F00010000
      FF87F11F00010000FFC3E38F00010000FFE3C7C781010000FFF3EFEFC3830000
      FFFFFFFFFFC70000FFFFFFFFFFFF000000000000000000000000000000000000
      000000000000}
  end
end
