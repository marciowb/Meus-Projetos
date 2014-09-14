inherited frmListagemPadrao: TfrmListagemPadrao
  ActiveControl = cxGrid1
  Align = alClient
  Caption = 'frmListagemPadrao'
  ClientHeight = 530
  ClientWidth = 871
  Position = poDesigned
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 887
  ExplicitHeight = 569
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFiltros: TPanel
    Left = 0
    Top = 58
    Width = 871
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 871
    Height = 35
    Align = alTop
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 1
    object Bevel1: TBevel
      Left = 441
      Top = 0
      Width = 4
      Height = 31
      Align = alLeft
      Shape = bsLeftLine
    end
    object Bevel2: TBevel
      Left = 164
      Top = 0
      Width = 4
      Height = 31
      Align = alLeft
      Shape = bsFrame
    end
    object BitBtn1: TBitBtn
      Left = 627
      Top = 0
      Width = 91
      Height = 31
      Action = actSair
      Align = alLeft
      Caption = 'Sair'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 82
      Top = 0
      Width = 41
      Height = 31
      Action = actProximo
      Align = alLeft
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
    end
    object BitBtn3: TBitBtn
      Left = 41
      Top = 0
      Width = 41
      Height = 31
      Action = actAnterior
      Align = alLeft
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 2
    end
    object BitBtn4: TBitBtn
      Left = 0
      Top = 0
      Width = 41
      Height = 31
      Action = actPrimeiro
      Align = alLeft
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 3
    end
    object BitBtn5: TBitBtn
      Left = 123
      Top = 0
      Width = 41
      Height = 31
      Action = actUltimo
      Align = alLeft
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 4
    end
    object BitBtn6: TBitBtn
      Left = 350
      Top = 0
      Width = 91
      Height = 31
      Action = actExcluir
      Align = alLeft
      Caption = 'Excluir'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 5
      ExplicitLeft = 348
      ExplicitTop = -2
    end
    object BitBtn7: TBitBtn
      Left = 259
      Top = 0
      Width = 91
      Height = 31
      Action = actEditar
      Align = alLeft
      Caption = 'Editar'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 6
    end
    object BitBtn8: TBitBtn
      Left = 168
      Top = 0
      Width = 91
      Height = 31
      Action = actNovo
      Align = alLeft
      Caption = 'Novo'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 7
    end
    object BitBtn9: TBitBtn
      Left = 536
      Top = 0
      Width = 91
      Height = 31
      Action = actImprimir
      Align = alLeft
      Caption = 'Imprimir'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 8
    end
    object BitBtn10: TBitBtn
      Left = 445
      Top = 0
      Width = 91
      Height = 31
      Action = actPesquisar
      Align = alLeft
      Caption = 'Pesquisar'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 9
    end
  end
  object Status: TdxStatusBar
    Left = 0
    Top = 510
    Width = 871
    Height = 20
    Panels = <
      item
        PanelStyleClassName = 'TdxStatusBarTextPanelStyle'
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
  end
  object pnlCaption: TPanel
    Tag = 99
    Left = 0
    Top = 35
    Width = 871
    Height = 23
    Align = alTop
    BevelKind = bkTile
    BevelOuter = bvNone
    Caption = 'Display'
    Color = 16556173
    Font.Charset = ANSI_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentBackground = False
    ParentFont = False
    TabOrder = 3
    object Panel4: TPanel
      Tag = 99
      Left = 520
      Top = 0
      Width = 347
      Height = 19
      Align = alRight
      BevelOuter = bvNone
      Color = 16556173
      ParentBackground = False
      TabOrder = 0
      DesignSize = (
        347
        19)
      object SpeedButton1: TSpeedButton
        Left = 0
        Top = 0
        Width = 23
        Height = 19
        Hint = 'Juntar tudo'
        Align = alLeft
        Caption = 'Col'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton1Click
        ExplicitLeft = 48
        ExplicitHeight = 22
      end
      object SpeedButton2: TSpeedButton
        Left = 23
        Top = 0
        Width = 23
        Height = 19
        Hint = 'Expandir tudo'
        Align = alLeft
        Caption = 'Exp'
        Flat = True
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        OnClick = SpeedButton2Click
        ExplicitLeft = 80
        ExplicitTop = 16
        ExplicitHeight = 22
      end
      object chkMostrarGrupo: TCheckBox
        Left = 193
        Top = 0
        Width = 153
        Height = 17
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = 'Mostrar barra de grupo'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        State = cbChecked
        TabOrder = 0
        OnClick = chkMostrarGrupoClick
      end
      object chkRodape: TCheckBox
        Left = 78
        Top = 0
        Width = 108
        Height = 17
        Cursor = crHandPoint
        Anchors = [akRight, akBottom]
        Caption = 'Mostrar rodap'#233
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = chkRodapeClick
      end
    end
  end
  object PageControl: TcxPageControl
    Left = 0
    Top = 88
    Width = 871
    Height = 422
    ActivePage = tsListagem
    Align = alClient
    Style = 9
    TabOrder = 4
    ClientRectBottom = 422
    ClientRectRight = 871
    ClientRectTop = 20
    object tsListagem: TcxTabSheet
      Caption = 'Listagem'
      ImageIndex = 0
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 871
        Height = 402
        Align = alClient
        TabOrder = 0
        object TvListagem: TcxGridDBTableView
          Tag = 99
          OnDblClick = TvListagemDblClick
          NavigatorButtons.ConfirmDelete = False
          DataController.DataModeController.SmartRefresh = True
          DataController.DataSource = DataListagem
          DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.FocusCellOnTab = True
          OptionsBehavior.GoToNextCellOnEnter = True
          OptionsCustomize.ColumnsQuickCustomization = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsSelection.CellSelect = False
          OptionsView.Indicator = True
          Styles.StyleSheet = DMConexao.StiloGrid
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = TvListagem
        end
      end
    end
  end
  object ActionList1: TActionList
    Images = DMConexao.ImageList24_24
    OnUpdate = ActionList1Update
    Left = 576
    Top = 248
    object actPrimeiro: TAction
      Hint = 'Primeiro'
      ImageIndex = 42
      OnExecute = actPrimeiroExecute
    end
    object actProximo: TAction
      Hint = 'Pr'#243'ximo'
      ImageIndex = 41
      OnExecute = actProximoExecute
    end
    object actAnterior: TAction
      Hint = 'Anterior'
      ImageIndex = 40
      OnExecute = actAnteriorExecute
    end
    object actUltimo: TAction
      Hint = #218'ltimo'
      ImageIndex = 43
      OnExecute = actUltimoExecute
    end
    object actNovo: TAction
      Caption = 'Novo'
      Hint = 'Novo'
      ImageIndex = 16
      ShortCut = 16462
      OnExecute = actNovoExecute
    end
    object actEditar: TAction
      Caption = 'Editar'
      ImageIndex = 10
      ShortCut = 16453
      OnExecute = actEditarExecute
    end
    object actExcluir: TAction
      Caption = 'Excluir'
      ImageIndex = 39
      ShortCut = 16430
      OnExecute = actExcluirExecute
    end
    object actPesquisar: TAction
      Caption = 'Pesquisar'
      ImageIndex = 18
      ShortCut = 115
      OnExecute = actPesquisarExecute
    end
    object actImprimir: TAction
      Caption = 'Imprimir'
      ImageIndex = 19
      ShortCut = 16464
      OnExecute = actImprimirExecute
    end
    object actSair: TAction
      Caption = 'Sair'
      ImageIndex = 11
      OnExecute = actSairExecute
    end
  end
  object DataListagem: TDataSource
    DataSet = CdsListagem
    Left = 640
    Top = 248
  end
  object CdsListagem: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsListagemAfterOpen
    AfterScroll = CdsListagemAfterScroll
    Left = 720
    Top = 248
  end
end
