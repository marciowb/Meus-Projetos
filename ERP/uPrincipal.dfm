inherited frmPrincipal: TfrmPrincipal
  Caption = 'ERP'
  ClientHeight = 529
  ClientWidth = 842
  ExplicitTop = -32
  ExplicitWidth = 858
  ExplicitHeight = 588
  PixelsPerInch = 96
  TextHeight = 13
  inherited Status: TdxRibbonStatusBar
    Top = 506
    Width = 842
    ExplicitTop = 506
    ExplicitWidth = 842
  end
  object dxDockSite1: TdxDockSite [1]
    Left = 0
    Top = 0
    Width = 842
    Height = 506
    Align = alClient
    DockType = 0
    OriginalWidth = 842
    OriginalHeight = 506
    object dxLayoutDockSite1: TdxLayoutDockSite
      Left = 0
      Top = 0
      Width = 520
      Height = 506
      DockType = 1
      OriginalWidth = 300
      OriginalHeight = 200
    end
    object dxTabContainerDockSite1: TdxTabContainerDockSite
      Left = 520
      Top = 0
      Width = 322
      Height = 506
      ActiveChildIndex = 0
      AllowFloating = True
      AutoHide = False
      DockType = 4
      OriginalWidth = 322
      OriginalHeight = 140
      object DockAgenda: TdxDockPanel
        Left = 0
        Top = 0
        Width = 318
        Height = 448
        AllowDockClients = [dtNone, dtClient, dtLeft, dtTop, dtRight, dtBottom]
        AllowFloating = True
        AllowDock = [dtNone, dtClient, dtLeft, dtTop, dtRight, dtBottom]
        AutoHide = False
        Caption = 'Agenda'
        CaptionButtons = [cbHide]
        TabPosition = tctpTop
        ExplicitLeft = 520
        ExplicitWidth = 322
        ExplicitHeight = 140
        DockType = 1
        OriginalWidth = 322
        OriginalHeight = 140
        object pnlAgenda: TPanel
          Left = 0
          Top = 0
          Width = 318
          Height = 448
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 0
          ExplicitHeight = 478
          object cxGrid1: TcxGrid
            Left = 0
            Top = 0
            Width = 318
            Height = 448
            Align = alClient
            TabOrder = 0
            ExplicitHeight = 478
            object cxGrid1DBTableView1: TcxGridDBTableView
              OnDblClick = cxGrid1DBTableView1DblClick
              NavigatorButtons.ConfirmDelete = False
              DataController.DataSource = DataAgenda
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsView.CellAutoHeight = True
              OptionsView.GroupByBox = False
              OptionsView.Header = False
              object cxGrid1DBTableView1Column1: TcxGridDBColumn
                DataBinding.FieldName = 'DATACOMPROMISSO'
                Visible = False
                GroupIndex = 0
                Options.ShowCaption = False
                Options.SortByDisplayText = isbtOff
                IsCaptionAssigned = True
              end
              object cxGrid1DBTableView1Column2: TcxGridDBColumn
                DataBinding.FieldName = 'CAPTION'
                Width = 273
              end
            end
            object cxGrid1Level1: TcxGridLevel
              GridView = cxGrid1DBTableView1
            end
          end
        end
      end
      object pnlPatrimonio: TdxDockPanel
        Left = 0
        Top = 0
        Width = 318
        Height = 448
        AllowFloating = True
        AutoHide = False
        Caption = 'Patrim'#244'nios em alerta'
        CaptionButtons = [cbHide]
        TabPosition = tctpTop
        ExplicitWidth = 185
        ExplicitHeight = 140
        DockType = 1
        OriginalWidth = 322
        OriginalHeight = 140
        object cxGrid2: TcxGrid
          Left = 0
          Top = 0
          Width = 318
          Height = 448
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 40
          ExplicitTop = 104
          ExplicitWidth = 250
          ExplicitHeight = 200
          object cxGrid2DBTableView1: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            DataController.DataSource = DataPatrimonio
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.GroupByBox = False
            object cxGrid2DBTableView1Column1: TcxGridDBColumn
              Caption = 'C'#243'digo'
              DataBinding.FieldName = 'CODIGOPATRIMONIO'
              Width = 60
            end
            object cxGrid2DBTableView1Column2: TcxGridDBColumn
              Caption = 'Patrim'#244'nio'
              DataBinding.FieldName = 'NOMEPATRIMONIO'
              Width = 100
            end
            object cxGrid2DBTableView1Column3: TcxGridDBColumn
              Caption = 'Evento'
              DataBinding.FieldName = 'NOMETIPOEVENTOPATRIMONIO'
              Width = 80
            end
            object cxGrid2DBTableView1Column4: TcxGridDBColumn
              Caption = 'Data limite'
              DataBinding.FieldName = 'DATALIMITE'
              Width = 60
            end
          end
          object cxGrid2Level1: TcxGridLevel
            GridView = cxGrid2DBTableView1
          end
        end
      end
    end
  end
  inherited dxBarManager1: TdxBarManager
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    Left = 272
    Top = 128
    DockControlHeights = (
      0
      0
      0
      0)
  end
  inherited MainMenu: TMainMenu
    Left = 112
    Top = 128
    object Cadastro1: TMenuItem
      Action = actCadastro
      object Pessoas1: TMenuItem
        Action = actClientes
        object Cliente1: TMenuItem
          Action = actCadCliente
        end
        object GrupodeCliente1: TMenuItem
          Action = actGrupoCliente
        end
      end
      object Produtos1: TMenuItem
        Action = actProdutos
        object Cadastrodeproduto1: TMenuItem
          Action = actCadProduto
        end
        object Fornecedor1: TMenuItem
          Action = actFornecedor
        end
        object Fabricante1: TMenuItem
          Action = actFabricante
        end
        object GrupodeCliente2: TMenuItem
          Action = actGrupoProduto
        end
        object Localizao1: TMenuItem
          Action = actLocalizacao
        end
        object actNCM1: TMenuItem
          Action = actNCM
        end
        object Linha1: TMenuItem
          Action = actLinha
        end
        object Unidade1: TMenuItem
          Action = actUnidade
        end
        object ProcessosdeServio1: TMenuItem
          Action = actProcessoServico
        end
        object OperaoEstoque1: TMenuItem
          Action = actOperacaoEstoque
        end
        object actCFOP1: TMenuItem
          Action = actCFOP
        end
        object ransportadora1: TMenuItem
          Action = actTransportadora
        end
        object Almoxarifados1: TMenuItem
          Action = actAlmoxarifado
        end
      end
      object Patrimnio1: TMenuItem
        Action = actPatrimonio
        object Patrimnio2: TMenuItem
          Action = actCadPatrimonio
        end
        object ManutenodePatrimnioporterceiros1: TMenuItem
          Action = actManutencaoPatrimonio
        end
        object ipodePatrimnio1: TMenuItem
          Action = actTipoPatrimonio
        end
        object iposdeeventos1: TMenuItem
          Action = actTipoEvento
        end
      end
      object OS1: TMenuItem
        Action = actCadOS
        object ipodeOS1: TMenuItem
          Action = actTipoOS
        end
        object StatusOS1: TMenuItem
          Action = actStatusOS
        end
      end
      object Financeiro1: TMenuItem
        Action = actCadFin
        object Banco1: TMenuItem
          Action = actBanco
        end
        object actContaBancaria1: TMenuItem
          Action = actContaBancaria
        end
        object CondiodePagamento1: TMenuItem
          Action = actCondicaoPagamento
        end
        object PlanosdeConta1: TMenuItem
          Action = actPlanoConta
        end
      end
      object Contrato1: TMenuItem
        Action = actCadContrato
        object ipodeContrato1: TMenuItem
          Action = actTipoContrato
        end
        object Periodicidade1: TMenuItem
          Action = actPeriodicidade
        end
      end
      object Empresa1: TMenuItem
        Action = actSobreEmpresa
        object actEmpresa1: TMenuItem
          Action = actEmpresa
        end
        object Cargo1: TMenuItem
          Action = actCargo
        end
        object Funcionario1: TMenuItem
          Action = actFuncionario
        end
        object Departamento1: TMenuItem
          Action = actDepartamento
        end
      end
      object actUsuario1: TMenuItem
        Action = actUsuario
      end
    end
    object Venda1: TMenuItem
      Action = actEstoque
      object Venda2: TMenuItem
        Action = actVenda
        object Proposta2: TMenuItem
          Action = actProposta
        end
        object NovaSada1: TMenuItem
          Action = actNovaSaida
        end
        object Listagemdesadas1: TMenuItem
          Action = actListagemSaidas
        end
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Entrada1: TMenuItem
        Action = actEntradas
        object Entradadeprodutos1: TMenuItem
          Action = actNovaEntrada
        end
        object ListagemdeEntrada1: TMenuItem
          Action = actListagemEntrada
        end
      end
    end
    object Centrodecontrato1: TMenuItem
      Action = actContrato
    end
    object Ordensdeservio1: TMenuItem
      Action = actOS
      object InclusaoOS1: TMenuItem
        Action = actInclusaoOS
      end
      object CentralOS1: TMenuItem
        Action = actCentralOS
      end
    end
    object Financeiro2: TMenuItem
      Action = actFinanceiro
      object CentralOS2: TMenuItem
        Action = actContasReceber
      end
    end
    object Agenda1: TMenuItem
      Action = actAgenda
    end
    object Configuraes1: TMenuItem
      Action = actConfiguracoes
    end
  end
  inherited ActionList1: TActionList
    Left = 184
    Top = 128
    object actCadastro: TAction
      Category = 'Cadastro'
      Caption = 'Cadastro'
      OnExecute = actCadastroExecute
    end
    object actCFOP: TAction
      Category = 'Cadastro'
      Caption = 'CFOP'
      OnExecute = actCFOPExecute
    end
    object actNCM: TAction
      Category = 'Cadastro'
      Caption = 'NCM'
      OnExecute = actNCMExecute
    end
    object actEmpresa: TAction
      Category = 'Cadastro'
      Caption = 'Cadastro de Empresa'
      OnExecute = actEmpresaExecute
    end
    object actCadCliente: TAction
      Category = 'Cadastro'
      Caption = 'Cliente'
      OnExecute = actCadClienteExecute
    end
    object actGrupoCliente: TAction
      Category = 'Cadastro'
      Caption = 'Grupo de Cliente'
      OnExecute = actGrupoClienteExecute
    end
    object actCargo: TAction
      Category = 'Cadastro'
      Caption = 'Cargo'
      OnExecute = actCargoExecute
    end
    object actUsuario: TAction
      Category = 'Cadastro'
      Caption = 'Usuario'
      OnExecute = actUsuarioExecute
    end
    object actDepartamento: TAction
      Category = 'Cadastro'
      Caption = 'Departamento'
      OnExecute = actDepartamentoExecute
    end
    object actFuncionario: TAction
      Category = 'Cadastro'
      Caption = 'Funcionario'
      OnExecute = actFuncionarioExecute
    end
    object actFornecedor: TAction
      Category = 'Cadastro'
      Caption = 'Fornecedor'
      OnExecute = actFornecedorExecute
    end
    object actGrupoProduto: TAction
      Category = 'Cadastro'
      Caption = 'Grupo de Produto'
      OnExecute = actGrupoProdutoExecute
    end
    object actLinha: TAction
      Category = 'Cadastro'
      Caption = 'Linha'
      OnExecute = actLinhaExecute
    end
    object actLocalizacao: TAction
      Category = 'Cadastro'
      Caption = 'Localiza'#231#227'o'
      OnExecute = actLocalizacaoExecute
    end
    object actCadProduto: TAction
      Category = 'Cadastro'
      Caption = 'Cadastro de produto'
      OnExecute = actCadProdutoExecute
    end
    object actUnidade: TAction
      Category = 'Cadastro'
      Caption = 'Unidade'
      OnExecute = actUnidadeExecute
    end
    object actFabricante: TAction
      Category = 'Cadastro'
      Caption = 'Fabricante'
      OnExecute = actFabricanteExecute
    end
    object actCodigoMunServico: TAction
      Category = 'Cadastro'
      Caption = 'C'#243'digo Municipal de Servi'#231'o'
    end
    object actProcessoServico: TAction
      Category = 'Cadastro'
      Caption = 'Processos de Servi'#231'o'
      OnExecute = actProcessoServicoExecute
    end
    object actPeriodicidade: TAction
      Category = 'Cadastro'
      Caption = 'Periodicidade'
      OnExecute = actPeriodicidadeExecute
    end
    object actBanco: TAction
      Category = 'Cadastro'
      Caption = 'Banco'
      OnExecute = actBancoExecute
    end
    object actContaBancaria: TAction
      Category = 'Cadastro'
      Caption = 'Conta Banc'#225'ria'
      OnExecute = actContaBancariaExecute
    end
    object actCondicaoPagamento: TAction
      Category = 'Cadastro'
      Caption = 'Condi'#231#227'o de Pagamento'
      OnExecute = actCondicaoPagamentoExecute
    end
    object actProposta: TAction
      Category = 'Venda'
      Caption = 'Proposta'
      OnExecute = actPropostaExecute
    end
    object actEstoque: TAction
      Category = 'Estoque'
      Caption = 'Estoque'
      OnExecute = actEstoqueExecute
    end
    object actTipoContrato: TAction
      Category = 'Cadastro'
      Caption = 'Tipo de Contrato'
      OnExecute = actTipoContratoExecute
    end
    object actContrato: TAction
      Category = 'Venda'
      Caption = 'Centro de contrato'
      OnExecute = actContratoExecute
    end
    object actTipoOS: TAction
      Category = 'Cadastro'
      Caption = 'Tipo de O.S.'
      OnExecute = actTipoOSExecute
    end
    object actStatusOS: TAction
      Category = 'Cadastro'
      Caption = 'Status O.S.'
      OnExecute = actStatusOSExecute
    end
    object actInclusaoOS: TAction
      Category = 'Venda'
      Caption = 'Inclusao O.S.'
      OnExecute = actInclusaoOSExecute
    end
    object actCentralOS: TAction
      Category = 'Venda'
      Caption = 'Central O.S.'
      OnExecute = actCentralOSExecute
    end
    object actOS: TAction
      Category = 'Venda'
      Caption = 'Ordens de servi'#231'o'
      OnExecute = actOSExecute
    end
    object actAgenda: TAction
      Category = 'Venda'
      Caption = 'Agenda'
      OnExecute = actAgendaExecute
    end
    object actNovaEntrada: TAction
      Category = 'Estoque'
      Caption = 'Inclus'#227'o de Entrada de produtos'
      OnExecute = actNovaEntradaExecute
    end
    object actOperacaoEstoque: TAction
      Category = 'Cadastro'
      Caption = 'Opera'#231#227'o Estoque'
      OnExecute = actOperacaoEstoqueExecute
    end
    object actVenda: TAction
      Category = 'Venda'
      Caption = 'Sa'#237'da'
      OnExecute = actVendaExecute
    end
    object actListagemEntrada: TAction
      Category = 'Estoque'
      Caption = 'Todas as Entradas'
      OnExecute = actListagemEntradaExecute
    end
    object actClientes: TAction
      Category = 'Cadastro'
      Caption = 'Clientes'
      OnExecute = actClientesExecute
    end
    object actProdutos: TAction
      Category = 'Cadastro'
      Caption = 'Produtos / Estoque'
      OnExecute = actProdutosExecute
    end
    object actSobreEmpresa: TAction
      Category = 'Cadastro'
      Caption = 'Empresa'
      OnExecute = actSobreEmpresaExecute
    end
    object actCadOS: TAction
      Category = 'Cadastro'
      Caption = 'Ordens de Servi'#231'os'
      OnExecute = actCadOSExecute
    end
    object actCadFin: TAction
      Category = 'Cadastro'
      Caption = 'Financeiro'
      OnExecute = actCadFinExecute
    end
    object actCadContrato: TAction
      Category = 'Cadastro'
      Caption = 'Contrato'
      OnExecute = actCadContratoExecute
    end
    object actEntradas: TAction
      Category = 'Estoque'
      Caption = 'Entrada'
      OnExecute = actEntradasExecute
    end
    object actNovaSaida: TAction
      Category = 'Venda'
      Caption = 'Inclus'#227'o de sa'#237'da'
      OnExecute = actNovaSaidaExecute
    end
    object actTransportadora: TAction
      Category = 'Cadastro'
      Caption = 'Transportadora'
      OnExecute = actTransportadoraExecute
    end
    object actAlmoxarifado: TAction
      Category = 'Cadastro'
      Caption = 'Almoxarifados'
      OnExecute = actAlmoxarifadoExecute
    end
    object actListagemSaidas: TAction
      Category = 'Venda'
      Caption = 'Todas as sa'#237'das'
      OnExecute = actListagemSaidasExecute
    end
    object actConfiguracoes: TAction
      Caption = 'Configura'#231#245'es'
      OnExecute = actConfiguracoesExecute
    end
    object actFinanceiro: TAction
      Category = 'Financeiro'
      Caption = 'Financeiro'
      OnExecute = actFinanceiroExecute
    end
    object actContasReceber: TAction
      Category = 'Financeiro'
      Caption = 'Contas a Receber'
      OnExecute = actContasReceberExecute
    end
    object actPlanoConta: TAction
      Category = 'Cadastro'
      Caption = 'Planos de Conta'
      OnExecute = actPlanoContaExecute
    end
    object actPatrimonio: TAction
      Category = 'Cadastro'
      Caption = 'Patrim'#244'nio'
      OnExecute = actPatrimonioExecute
    end
    object actTipoPatrimonio: TAction
      Category = 'Cadastro'
      Caption = 'Tipo de Patrim'#244'nio'
      OnExecute = actTipoPatrimonioExecute
    end
    object actTipoEvento: TAction
      Category = 'Cadastro'
      Caption = 'Tipo de evento'
      OnExecute = actTipoEventoExecute
    end
    object actCadPatrimonio: TAction
      Category = 'Cadastro'
      Caption = 'Cadastro de Patrim'#244'nio'
      OnExecute = actCadPatrimonioExecute
    end
    object actManutencaoPatrimonio: TAction
      Category = 'Cadastro'
      Caption = 'Manuten'#231#227'o de Patrim'#244'nio por terceiros'
      OnExecute = actManutencaoPatrimonioExecute
    end
  end
  object dxDockingManager1: TdxDockingManager
    Color = clBtnFace
    DefaultHorizContainerSiteProperties.Dockable = True
    DefaultHorizContainerSiteProperties.ImageIndex = -1
    DefaultVertContainerSiteProperties.Dockable = True
    DefaultVertContainerSiteProperties.ImageIndex = -1
    DefaultTabContainerSiteProperties.Dockable = True
    DefaultTabContainerSiteProperties.ImageIndex = -1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ViewStyle = vsUseLookAndFeel
    Left = 232
    Top = 192
  end
  object DataAgenda: TDataSource
    DataSet = CdsAgenda
    Left = 112
    Top = 240
  end
  object CdsAgenda: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    Left = 168
    Top = 248
  end
  object DataPatrimonio: TDataSource
    DataSet = CdsPatrimonio
    Left = 80
    Top = 344
  end
  object CdsPatrimonio: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    Top = 336
  end
end
