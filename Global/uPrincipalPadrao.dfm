inherited frmPrincipalPadrao: TfrmPrincipalPadrao
  Caption = 'frmPrincipalPadrao'
  ClientHeight = 616
  ClientWidth = 703
  Menu = MainMenu
  WindowState = wsMaximized
  OnActivate = FormActivate
  ExplicitWidth = 719
  ExplicitHeight = 655
  PixelsPerInch = 96
  TextHeight = 13
  object Status: TdxRibbonStatusBar
    Left = 0
    Top = 593
    Width = 703
    Height = 23
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Width = 200
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Usu'#225'rio'
        Width = 150
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        Text = 'Conexao'
        Width = 300
      end
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        BiDiMode = bdRightToLeft
        Fixed = False
        ParentBiDiMode = False
        Text = 'Vers'#227'o'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 184
    Top = 16
    DockControlHeights = (
      0
      0
      0
      0)
  end
  object MainMenu: TMainMenu
    Left = 24
    Top = 16
  end
  object ActionList1: TActionList
    Left = 96
    Top = 16
  end
end
