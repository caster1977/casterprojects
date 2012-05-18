object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 173
  Width = 358
  object PopupMenu: TPopupMenu
    Left = 32
    Top = 24
  end
  object ImageListSmall: TImageList
    Left = 32
    Top = 96
  end
  object TrayIcon: TTrayIcon
    PopupMenu = PopupMenu
    OnClick = TrayIconClick
    Left = 192
    Top = 24
  end
  object MainMenu: TMainMenu
    Left = 112
    Top = 24
  end
  object ApplicationEvents: TApplicationEvents
    Left = 280
    Top = 24
  end
  object ImageListLarge: TImageList
    Height = 32
    Width = 32
    Left = 112
    Top = 96
  end
  object ActionManager1: TActionManager
    Left = 192
    Top = 96
    StyleName = 'Platform Default'
  end
end
