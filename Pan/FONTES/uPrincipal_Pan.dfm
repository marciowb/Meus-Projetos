inherited frmPrincipal: TfrmPrincipal
  Caption = 'PAN - Vers'#227'o 1.0.0.0'
  ClientHeight = 435
  ClientWidth = 710
  ExplicitWidth = 718
  ExplicitHeight = 462
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvEnterAsTab1: TJvEnterAsTab
    Left = 27
    Top = 136
    ExplicitLeft = 27
    ExplicitTop = 136
  end
  object dxRibbon1: TdxRibbon
    Left = 0
    Top = 0
    Width = 710
    Height = 116
    BarManager = dxBarManager1
    ColorSchemeName = 'Silver'
    PopupMenuItems = []
    TabOrder = 0
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Acesso principal'
      Groups = <
        item
          ToolbarName = 'RegionCadastro'
        end
        item
          ToolbarName = 'RegionSaidas'
        end
        item
          ToolbarName = 'RegionSobre'
        end>
    end
  end
  object Status: TdxRibbonStatusBar
    Left = 0
    Top = 412
    Width = 710
    Height = 23
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
        PanelStyle.Alignment = taRightJustify
        PanelStyle.Font.Charset = DEFAULT_CHARSET
        PanelStyle.Font.Color = clDefault
        PanelStyle.Font.Height = -11
        PanelStyle.Font.Name = 'Tahoma'
        PanelStyle.Font.Style = [fsBold]
        PanelStyle.ParentFont = False
        BiDiMode = bdRightToLeft
        ParentBiDiMode = False
        Text = 'Data/Hora'
        Width = 100
      end>
    Ribbon = dxRibbon1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object dxBarManager1: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 83
    Top = 136
    DockControlHeights = (
      0
      0
      0
      0)
    object RegionSaidas: TdxBar
      Caption = 'Sa'#237'das'
      CaptionButtons = <>
      DockedLeft = 190
      DockedTop = 0
      FloatLeft = 736
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'btnSaida'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object RegionCadastro: TdxBar
      Caption = 'Cadastro'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 736
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton12'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          Visible = True
          ItemName = 'dxBarButton11'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object RegionSobre: TdxBar
      Caption = 'Outros'
      CaptionButtons = <>
      DockedLeft = 301
      DockedTop = 0
      FloatLeft = 736
      FloatTop = 8
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end>
      OneOnRow = False
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object btnCadCliente: TdxBarButton
      Action = actCliente
      Category = 0
    end
    object btnCadastroProduto: TdxBarButton
      Action = actProdutos
      Category = 0
    end
    object btnSaida: TdxBarButton
      Action = actSaidas
      Category = 0
    end
    object dxBarButton1: TdxBarButton
      Caption = 'Listagem de sa'#237'das (Ctrl+S)'
      Category = 0
      Visible = ivAlways
      ShortCut = 16467
    end
    object dxBarButton2: TdxBarButton
      Action = actProdutos
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actClasseRisco
      Category = 0
    end
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'New SubItem'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarButton4: TdxBarButton
      Action = actProdutos
      Category = 0
    end
    object dxBarButton5: TdxBarButton
      Action = actCliente
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Action = actClasseRisco
      Category = 0
    end
    object dxBarButton7: TdxBarButton
      Action = actSobre
      Category = 0
    end
    object dxBarButton8: TdxBarButton
      Action = actCadTexto
      Category = 0
    end
    object dxBarButton9: TdxBarButton
      Action = actCadTexto
      Category = 0
    end
    object dxBarSubItem2: TdxBarSubItem
      Caption = 'New SubItem'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object dxBarButton10: TdxBarButton
      Action = actCliente
      Category = 0
    end
    object dxBarButton11: TdxBarButton
      Action = actClasseRisco
      Category = 0
    end
    object dxBarButton12: TdxBarButton
      Action = actCliente
      Category = 0
    end
    object dxBarButton13: TdxBarButton
      Caption = 'Mudar pad'#227'o (F11)'
      Category = 0
      Visible = ivAlways
      ShortCut = 122
    end
  end
  object TdxBarSeparator
    Category = -1
    Visible = ivAlways
  end
  object cxImageList1: TcxImageList
    FormatVersion = 1
    DesignInfo = 8912951
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 111
    Top = 136
  end
  object ActionList1: TActionList
    Left = 139
    Top = 136
    object actCliente: TAction
      Caption = 'Cliente (F6)'
      ShortCut = 117
      OnExecute = actClienteExecute
    end
    object actProdutos: TAction
      Caption = 'Produto (F7)'
      ShortCut = 118
      OnExecute = actProdutosExecute
    end
    object actSaidas: TAction
      Caption = 'Emitir etiqueta (F4)'
      ShortCut = 115
      OnExecute = actSaidasExecute
    end
    object actClasseRisco: TAction
      Caption = 'Classe de risco (F8)'
      ShortCut = 119
      OnExecute = actClasseRiscoExecute
    end
    object actSobre: TAction
      Caption = 'Sobre (F10)'
      ShortCut = 121
      OnExecute = actSobreExecute
    end
    object actCadTexto: TAction
      Caption = 'Textos (F3)'
      ShortCut = 114
      OnExecute = actCadTextoExecute
    end
  end
end
