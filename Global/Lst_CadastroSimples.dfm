inherited frmLstCadastroSimples: TfrmLstCadastroSimples
  Anchors = [akLeft, akTop, akRight, akBottom]
  Caption = 'frmLstCadastroSimples'
  ClientHeight = 373
  ClientWidth = 642
  ExplicitWidth = 658
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  object Status: TStatusBar
    Left = 0
    Top = 354
    Width = 642
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 642
    Height = 354
    Align = alClient
    BevelInner = bvLowered
    BevelKind = bkSoft
    BevelOuter = bvLowered
    TabOrder = 1
    object cxSplitter1: TcxSplitter
      Left = 305
      Top = 24
      Width = 8
      Height = 324
      HotZoneClassName = 'TcxMediaPlayer9Style'
      HotZone.SizePercent = 73
      Control = Panel2
    end
    object Panel3: TPanel
      Left = 313
      Top = 24
      Width = 323
      Height = 324
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object edtCodigo: TLabelDBEdit
        Left = 16
        Top = 27
        Width = 73
        Height = 21
        DataField = 'CODIGO'
        DataSource = DataCadastro
        TabOrder = 0
        Titulo.Left = 16
        Titulo.Top = 12
        Titulo.Width = 39
        Titulo.Height = 13
        Titulo.Caption = 'C'#243'digo*'
        IsNull = False
        PodeRepetir = False
        CorPrincipal = clWhite
        CorSecundaria = 11592447
        GravaEsteCampo = True
        AsInteger = 0
      end
      object Panel4: TPanel
        Left = 0
        Top = 283
        Width = 323
        Height = 41
        Align = alBottom
        BevelKind = bkSoft
        BevelOuter = bvNone
        TabOrder = 1
        object BitBtn1: TBitBtn
          Left = 63
          Top = 9
          Width = 99
          Height = 25
          Action = actGravar
          Caption = 'Gravar [F9]'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 0
        end
        object BitBtn2: TBitBtn
          Left = 168
          Top = 9
          Width = 105
          Height = 25
          Action = actCancelar
          Caption = 'Cancelar [F6]'
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 1
        end
      end
    end
    object ToolBar1: TToolBar
      Left = 2
      Top = 2
      Width = 634
      Height = 22
      AutoSize = True
      ButtonWidth = 73
      Customizable = True
      DrawingStyle = dsGradient
      EdgeInner = esLowered
      GradientEndColor = clSilver
      GradientStartColor = 16776176
      Images = DMConexao.ImageList16_16
      List = True
      ParentShowHint = False
      ShowCaptions = True
      AllowTextButtons = True
      ShowHint = True
      TabOrder = 2
      Transparent = True
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = actPrimeiro
      end
      object ToolButton2: TToolButton
        Left = 24
        Top = 0
        Action = actAnterior
      end
      object ToolButton3: TToolButton
        Left = 48
        Top = 0
        Action = actProximo
      end
      object ToolButton4: TToolButton
        Left = 72
        Top = 0
        Action = actUltimo
      end
      object ToolButton7: TToolButton
        Left = 96
        Top = 0
        Width = 8
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object btnNovo: TToolButton
        Left = 104
        Top = 0
        Action = actNovo
      end
      object ToolButton9: TToolButton
        Left = 128
        Top = 0
        Action = actEditar
      end
      object ToolButton10: TToolButton
        Left = 152
        Top = 0
        Action = actPesquisar
      end
      object ToolButton11: TToolButton
        Left = 176
        Top = 0
        Action = actExcluir
      end
    end
    object Panel2: TPanel
      Left = 2
      Top = 24
      Width = 303
      Height = 324
      Align = alLeft
      BevelOuter = bvLowered
      TabOrder = 3
      object PageControl: TcxPageControl
        Left = 1
        Top = 1
        Width = 301
        Height = 322
        ActivePage = tsGrid
        Align = alClient
        TabOrder = 0
        ClientRectBottom = 318
        ClientRectLeft = 4
        ClientRectRight = 297
        ClientRectTop = 24
        object tsGrid: TcxTabSheet
          Caption = 'tsGrid'
          ImageIndex = 0
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlGrid: TPanel
            Left = 0
            Top = 0
            Width = 295
            Height = 296
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object TvCadastro: TcxGrid
              Left = 0
              Top = 0
              Width = 295
              Height = 296
              Align = alClient
              TabOrder = 0
              object TvCadastroDBTableView1: TcxGridDBTableView
                NavigatorButtons.ConfirmDelete = False
                DataController.DataSource = DataCadastro
                DataController.Summary.DefaultGroupSummaryItems = <>
                DataController.Summary.FooterSummaryItems = <>
                DataController.Summary.SummaryGroups = <>
                OptionsData.CancelOnExit = False
                OptionsData.Deleting = False
                OptionsData.DeletingConfirmation = False
                OptionsData.Editing = False
                OptionsData.Inserting = False
                OptionsSelection.CellSelect = False
                OptionsView.GroupByBox = False
                OptionsView.Indicator = True
                Styles.Selection = DMConexao.Selecionado
              end
              object TvCadastroLevel1: TcxGridLevel
                GridView = TvCadastroDBTableView1
              end
            end
          end
        end
        object tsTree: TcxTabSheet
          Caption = 'tsTree'
          ImageIndex = 1
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlTree: TPanel
            Left = 0
            Top = 0
            Width = 295
            Height = 296
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object TvTree: TcxDBTreeList
              Left = 0
              Top = 0
              Width = 295
              Height = 296
              Align = alClient
              Bands = <
                item
                end>
              OptionsBehavior.Sorting = False
              OptionsData.CancelOnExit = False
              OptionsData.Editing = False
              OptionsData.Deleting = False
              OptionsSelection.CellSelect = False
              OptionsView.ColumnAutoWidth = True
              RootValue = -1
              Styles.Selection = DMConexao.Selecionado
              TabOrder = 0
            end
          end
        end
      end
    end
  end
  object ActionList1: TActionList
    Images = DMConexao.ImageList16_16
    OnUpdate = ActionList1Update
    Left = 32
    Top = 64
    object actMenu: TAction
      Caption = 'Menu'
      OnExecute = actMenuExecute
    end
    object actPrimeiro: TAction
      Hint = 'Primeiro'
      ImageIndex = 3
      OnExecute = actPrimeiroExecute
    end
    object actAnterior: TAction
      Hint = 'Anterior'
      ImageIndex = 2
      OnExecute = actAnteriorExecute
    end
    object actProximo: TAction
      Hint = 'Pr'#243'ximo'
      ImageIndex = 5
      OnExecute = actProximoExecute
    end
    object actUltimo: TAction
      Hint = #218'ltimo'
      ImageIndex = 4
      OnExecute = actUltimoExecute
    end
    object actNovo: TAction
      Caption = 'Novo'
      Hint = 'Novo '
      ImageIndex = 0
      ShortCut = 16462
      OnExecute = actNovoExecute
    end
    object actEditar: TAction
      Caption = 'Editar'
      Hint = 'Editar '
      ImageIndex = 8
      ShortCut = 16453
      OnExecute = actEditarExecute
    end
    object actExcluir: TAction
      Caption = 'Excluir'
      Hint = 'Excluir'
      ImageIndex = 6
      ShortCut = 16430
      OnExecute = actExcluirExecute
    end
    object actPesquisar: TAction
      Caption = 'Pesquisar'
      Hint = 'Pesquisar'
      ImageIndex = 11
      ShortCut = 16464
      OnExecute = actPesquisarExecute
    end
    object actGravar: TAction
      Caption = 'Gravar [F9]'
      Hint = 'Gravar registro '
      ImageIndex = 13
      ShortCut = 120
      OnExecute = actGravarExecute
    end
    object actCancelar: TAction
      Caption = 'Cancelar [F6]'
      Hint = 'Cancelar a'#231#227'o atual'
      ImageIndex = 1
      ShortCut = 117
      OnExecute = actCancelarExecute
    end
    object ActNovoPai: TAction
      Category = 'Novo'
      Caption = 'Sint'#233'tico'
      OnExecute = ActNovoPaiExecute
    end
    object actNovoFilho: TAction
      Category = 'Novo'
      Caption = 'Anal'#237'tico'
      OnExecute = actNovoFilhoExecute
    end
  end
  object DataCadastro: TDataSource
    DataSet = CdsCadastro
    Left = 120
    Top = 64
  end
  object PopupMenu1: TPopupMenu
    Images = DMConexao.ImageList16_16
    Left = 152
    Top = 64
    object Novo1: TMenuItem
      Action = actNovo
    end
    object Editar1: TMenuItem
      Action = actEditar
    end
    object Pesquisar1: TMenuItem
      Action = actPesquisar
    end
    object Excluir1: TMenuItem
      Action = actExcluir
    end
  end
  object PopNovoTree: TPopupMenu
    Left = 184
    Top = 64
    object Filho1: TMenuItem
      Action = ActNovoPai
    end
    object Pai1: TMenuItem
      Action = actNovoFilho
    end
  end
  object CdsCadastro: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsCadastroAfterOpen
    BeforeEdit = CdsCadastroBeforeEdit
    BeforePost = CdsCadastroBeforePost
    AfterPost = CdsCadastroAfterPost
    AfterCancel = CdsCadastroAfterCancel
    AfterScroll = CdsCadastroAfterScroll
    OnNewRecord = CdsCadastroNewRecord
    Left = 80
    Top = 64
  end
end
