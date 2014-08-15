inherited frmPrincipalPet: TfrmPrincipalPet
  Caption = 'SCP - Sistema de controle de petshopping'
  ClientHeight = 778
  ClientWidth = 910
  ExplicitWidth = 918
  ExplicitHeight = 812
  PixelsPerInch = 96
  TextHeight = 13
  inherited Status: TdxRibbonStatusBar
    Top = 755
    Width = 910
    Ribbon = Ribbon
    ExplicitTop = 755
    ExplicitWidth = 910
  end
  object Ribbon: TdxRibbon [1]
    Left = 0
    Top = 0
    Width = 910
    Height = 116
    BarManager = dxBarManager1
    ColorSchemeName = 'Blue'
    Contexts = <>
    TabOrder = 5
    TabStop = False
    object dxRibbon1Tab1: TdxRibbonTab
      Active = True
      Caption = 'Acesso r'#225'pido'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar1'
        end>
      Index = 0
    end
    object dxRibbon1Tab2: TdxRibbonTab
      Caption = 'Cadastro'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar2'
        end>
      Index = 1
    end
    object dxRibbon1Tab3: TdxRibbonTab
      Caption = 'Servi'#231'o/financeiro'
      Groups = <
        item
          ToolbarName = 'dxBarManager1Bar3'
        end>
      Index = 2
    end
  end
  object Panel1: TPanel [2]
    Left = 648
    Top = 116
    Width = 262
    Height = 639
    Align = alRight
    TabOrder = 6
    inline fraLebrete1: TfraLebrete
      Left = 1
      Top = 1
      Width = 260
      Height = 637
      Align = alClient
      TabOrder = 0
      Visible = False
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 260
      ExplicitHeight = 637
      inherited GradientLabel1: TGradientLabel
        Width = 260
        ExplicitWidth = 260
      end
      inherited cxGrid1: TcxGrid
        Width = 260
        Height = 620
        ExplicitWidth = 260
        ExplicitHeight = 620
      end
    end
  end
  object cxSplitter1: TcxSplitter [3]
    Left = 640
    Top = 116
    Width = 8
    Height = 639
    HotZoneClassName = 'TcxMediaPlayer9Style'
    HotZone.SizePercent = 36
    AlignSplitter = salRight
    Control = Panel1
  end
  inherited dxBarManager1: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    Left = 192
    Top = 144
    DockControlHeights = (
      0
      0
      0
      0)
    object dxBarManager1Bar1: TdxBar
      Caption = 'Acesso R'#225'pido'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 936
      FloatTop = 8
      FloatClientWidth = 171
      FloatClientHeight = 148
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton18'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton20'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton21'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton23'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton24'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton29'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton30'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar2: TdxBar
      Caption = 'Cadastro'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 936
      FloatTop = 8
      FloatClientWidth = 110
      FloatClientHeight = 316
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton2'
        end
        item
          Visible = True
          ItemName = 'dxBarButton4'
        end
        item
          Visible = True
          ItemName = 'dxBarButton7'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton25'
        end
        item
          Visible = True
          ItemName = 'dxBarButton3'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton10'
        end
        item
          Visible = True
          ItemName = 'dxBarButton5'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton6'
        end
        item
          Visible = True
          ItemName = 'dxBarButton1'
        end
        item
          Visible = True
          ItemName = 'dxBarButton8'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton9'
        end
        item
          Visible = True
          ItemName = 'dxBarButton11'
        end
        item
          Visible = True
          ItemName = 'dxBarButton12'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarManager1Bar3: TdxBar
      Caption = 'Servico'
      CaptionButtons = <>
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 936
      FloatTop = 8
      FloatClientWidth = 171
      FloatClientHeight = 158
      ItemLinks = <
        item
          Visible = True
          ItemName = 'dxBarButton14'
        end
        item
          Visible = True
          ItemName = 'dxBarButton15'
        end
        item
          Visible = True
          ItemName = 'dxBarButton16'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton17'
        end
        item
          Visible = True
          ItemName = 'dxBarButton26'
        end
        item
          Visible = True
          ItemName = 'dxBarButton27'
        end
        item
          BeginGroup = True
          Visible = True
          ItemName = 'dxBarButton31'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = False
    end
    object dxBarButton1: TdxBarButton
      Action = actCadCep
      Category = 0
    end
    object dxBarButton2: TdxBarButton
      Action = actCadEspecie
      Category = 0
    end
    object dxBarButton3: TdxBarButton
      Action = actCadTipoServico
      Category = 0
    end
    object dxBarButton4: TdxBarButton
      Action = actCadCategoriaAnimal
      Category = 0
    end
    object dxBarButton5: TdxBarButton
      Action = actCadFormaPagamento
      Category = 0
    end
    object dxBarButton6: TdxBarButton
      Action = actCadProfissional
      Category = 0
    end
    object dxBarButton7: TdxBarButton
      Action = actCadRaca
      Category = 0
    end
    object dxBarButton8: TdxBarButton
      Action = actCadEmpresa
      Category = 0
    end
    object dxBarButton9: TdxBarButton
      Action = actCadUsuario
      Category = 0
    end
    object dxBarButton10: TdxBarButton
      Action = actTabPreco
      Category = 0
    end
    object dxBarButton11: TdxBarButton
      Action = actCadCliente
      Category = 0
    end
    object dxBarButton12: TdxBarButton
      Action = actCadAnimal
      Category = 0
    end
    object dxBarButton13: TdxBarButton
      Action = actAgenda
      Category = 0
    end
    object dxBarButton14: TdxBarButton
      Action = actVenda
      Category = 0
    end
    object dxBarButton15: TdxBarButton
      Action = actAgenda
      Category = 0
    end
    object dxBarButton16: TdxBarButton
      Action = actServListagemServico
      Category = 0
    end
    object dxBarButton17: TdxBarButton
      Action = actCaixa
      Category = 0
    end
    object dxBarButton18: TdxBarButton
      Action = actAgenda
      Category = 0
    end
    object dxBarButton19: TdxBarButton
      Action = actCadCliente
      Category = 0
    end
    object dxBarButton20: TdxBarButton
      Action = actVenda
      Category = 0
    end
    object dxBarButton21: TdxBarButton
      Action = actCadCliente
      Category = 0
    end
    object dxBarButton22: TdxBarButton
      Action = actCaixa
      Category = 0
    end
    object dxBarButton23: TdxBarButton
      Action = actCadAnimal
      Category = 0
    end
    object dxBarButton24: TdxBarButton
      Action = actCaixa
      Category = 0
    end
    object dxBarButton25: TdxBarButton
      Action = actCadGrupo
      Category = 0
    end
    object dxBarButton26: TdxBarButton
      Action = actFinContasReceber
      Category = 0
    end
    object dxBarButton27: TdxBarButton
      Action = actFinContasRecebidas
      Category = 0
    end
    object dxBarButton28: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarButton29: TdxBarButton
      Action = actFinContasReceber
      Category = 0
    end
    object dxBarButton30: TdxBarButton
      Action = actFinFechamento
      Category = 0
    end
    object dxBarButton31: TdxBarButton
      Action = actFinFechamento
      Category = 0
    end
  end
  inherited MainMenu: TMainMenu
    Left = 32
    Top = 144
  end
  inherited ActionList1: TActionList
    Left = 104
    Top = 144
    object actCadCep: TAction
      Category = 'Cadastro'
      Caption = 'CEP'
      OnExecute = actCadCepExecute
    end
    object actCadEspecie: TAction
      Category = 'Cadastro'
      Caption = 'Esp'#233'cie'
      OnExecute = actCadEspecieExecute
    end
    object actCadTipoServico: TAction
      Category = 'Cadastro'
      Caption = 'Tipo de servi'#231'o'
      OnExecute = actCadTipoServicoExecute
    end
    object actCadCategoriaAnimal: TAction
      Category = 'Cadastro'
      Caption = 'Categoria de animal'
      OnExecute = actCadCategoriaAnimalExecute
    end
    object actCadFormaPagamento: TAction
      Category = 'Cadastro'
      Caption = 'Forma de pagamento'
      OnExecute = actCadFormaPagamentoExecute
    end
    object actCadProfissional: TAction
      Category = 'Cadastro'
      Caption = 'Profissional'
      OnExecute = actCadProfissionalExecute
    end
    object actCadRaca: TAction
      Category = 'Cadastro'
      Caption = 'Ra'#231'as'
      OnExecute = actCadRacaExecute
    end
    object actCadEmpresa: TAction
      Category = 'Cadastro'
      Caption = 'Empresa'
      OnExecute = actCadEmpresaExecute
    end
    object actCadUsuario: TAction
      Category = 'Cadastro'
      Caption = 'Usu'#225'rio'
      OnExecute = actCadUsuarioExecute
    end
    object actTabPreco: TAction
      Category = 'Cadastro'
      Caption = 'Tabela de pre'#231'o'
      OnExecute = actTabPrecoExecute
    end
    object actCadCliente: TAction
      Category = 'Cadastro'
      Caption = 'Cliente [ F7 ]'
      ShortCut = 118
      OnExecute = actCadClienteExecute
    end
    object actCadAnimal: TAction
      Category = 'Cadastro'
      Caption = 'Animal [ Ctrl+A ]'
      ShortCut = 16449
      OnExecute = actCadAnimalExecute
    end
    object actAgenda: TAction
      Category = 'Servico'
      Caption = 'Agenda [Ctrl+G]'
      ShortCut = 16455
      OnExecute = actAgendaExecute
    end
    object actVenda: TAction
      Category = 'Servico'
      Caption = 'Venda [F10]'
      ShortCut = 121
      OnExecute = actVendaExecute
    end
    object actServListagemServico: TAction
      Category = 'Servico'
      Caption = 'Listagem de servi'#231'o'
      OnExecute = actServListagemServicoExecute
    end
    object actCaixa: TAction
      Category = 'Servico'
      Caption = 'Caixa [F1]'
      ShortCut = 112
      OnExecute = actCaixaExecute
    end
    object actCadGrupo: TAction
      Category = 'Cadastro'
      Caption = 'Grupo de animal'
      OnExecute = actCadGrupoExecute
    end
    object actFinContasReceber: TAction
      Category = 'Servico'
      Caption = 'Contas a receber [Ctrl+R]'
      ShortCut = 16466
      OnExecute = actFinContasReceberExecute
    end
    object actFinContasRecebidas: TAction
      Category = 'Servico'
      Caption = 'Contas recebidas'
      OnExecute = actFinContasRecebidasExecute
    end
    object actFinFechamento: TAction
      Category = 'Servico'
      Caption = 'Resumo financeiro do dia [Ctrl+D]'
      ShortCut = 16452
      OnExecute = actFinFechamentoExecute
    end
  end
end
