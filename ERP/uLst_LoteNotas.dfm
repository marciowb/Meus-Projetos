inherited frmLst_LoteNotas: TfrmLst_LoteNotas
  Caption = 'Listagem de Lotes de Nota'
  ClientWidth = 885
  ExplicitWidth = 901
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFiltros: TPanel
    Width = 885
    ExplicitWidth = 885
  end
  inherited Panel2: TPanel
    Width = 885
    ExplicitWidth = 885
    inherited Bevel1: TBevel
      Left = 457
      ExplicitLeft = 457
    end
    inherited BitBtn1: TBitBtn
      Left = 643
      ExplicitLeft = 643
    end
    inherited BitBtn6: TBitBtn
      Width = 107
      Caption = 'Excluir lote'
      ExplicitWidth = 107
    end
    inherited BitBtn9: TBitBtn
      Left = 552
      ExplicitLeft = 552
    end
    inherited BitBtn10: TBitBtn
      Left = 461
      ExplicitLeft = 461
    end
  end
  inherited Status: TdxStatusBar
    Width = 885
    ExplicitTop = -20
    ExplicitWidth = 885
  end
  inherited pnlCaption: TPanel
    Width = 885
    ExplicitWidth = 885
    inherited Panel4: TPanel
      Left = 534
      ExplicitLeft = 534
    end
  end
  inherited PageControl: TcxPageControl
    Width = 885
    Height = 288
    ExplicitWidth = 885
    ExplicitHeight = 288
    ClientRectBottom = 288
    ClientRectRight = 885
    inherited tsListagem: TcxTabSheet
      ExplicitTop = 20
      ExplicitWidth = 885
      ExplicitHeight = 268
      inherited cxGrid1: TcxGrid
        Width = 505
        Height = 260
        Align = alLeft
        ExplicitWidth = 505
        ExplicitHeight = 260
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
      object cxSplitter1: TcxSplitter
        Left = 0
        Top = 260
        Width = 885
        Height = 8
        HotZoneClassName = 'TcxMediaPlayer9Style'
        AlignSplitter = salBottom
      end
      object GroupBox1: TGroupBox
        Left = 513
        Top = 0
        Width = 372
        Height = 260
        Align = alClient
        Caption = ' Notas '
        Ctl3D = True
        ParentCtl3D = False
        TabOrder = 2
        object cxGrid2: TcxGrid
          Left = 2
          Top = 15
          Width = 166
          Height = 243
          Align = alClient
          TabOrder = 0
          object TvNotas: TcxGridDBTableView
            Tag = 99
            OnDblClick = TvNotasDblClick
            NavigatorButtons.OnButtonClick = TvNotasNavigatorButtonsButtonClick
            NavigatorButtons.ConfirmDelete = False
            NavigatorButtons.First.Visible = False
            NavigatorButtons.PriorPage.Visible = False
            NavigatorButtons.Prior.Visible = False
            NavigatorButtons.Next.Visible = False
            NavigatorButtons.NextPage.Visible = False
            NavigatorButtons.Last.Visible = False
            NavigatorButtons.Edit.Visible = False
            NavigatorButtons.Post.Visible = False
            NavigatorButtons.Cancel.Visible = False
            NavigatorButtons.Refresh.Visible = False
            NavigatorButtons.SaveBookmark.Visible = False
            NavigatorButtons.GotoBookmark.Visible = False
            NavigatorButtons.Filter.Visible = False
            DataController.DataSource = DataItens
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <
              item
                Kind = skCount
                OnGetText = TvNotasTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText
                Column = vNotasColumn2
              end>
            DataController.Summary.SummaryGroups = <>
            OptionsSelection.CellSelect = False
            OptionsView.Navigator = True
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object vNotasColumn1: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DATA'
              Options.Editing = False
              Width = 60
            end
            object vNotasColumn2: TcxGridDBColumn
              Caption = 'N'#250'mero sa'#237'da'
              DataBinding.FieldName = 'NUMEROSAIDA'
              Options.Editing = False
              Width = 100
            end
            object vNotasColumn3: TcxGridDBColumn
              Caption = 'Pessoa'
              DataBinding.FieldName = 'PESSOA'
              Options.Editing = False
              Width = 300
            end
            object vNotasColumn4: TcxGridDBColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STATUS'
              Options.Editing = False
              Width = 100
            end
          end
          object cxGrid2Level1: TcxGridLevel
            GridView = TvNotas
          end
        end
        object Panel1: TPanel
          Left = 168
          Top = 15
          Width = 202
          Height = 243
          Align = alRight
          BevelKind = bkSoft
          BevelOuter = bvNone
          TabOrder = 1
          object GroupBox4: TGroupBox
            Left = 0
            Top = 105
            Width = 198
            Height = 113
            Align = alTop
            Caption = ' NFS-e '
            TabOrder = 0
            object BitBtn13: TBitBtn
              Left = 2
              Top = 56
              Width = 194
              Height = 41
              Action = actCancelarNFSe
              Align = alTop
              Caption = 'Cancelar NFS-e'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 0
            end
            object BitBtn12: TBitBtn
              Left = 2
              Top = 15
              Width = 194
              Height = 41
              Action = actImprimirNFSe
              Align = alTop
              Caption = 'Imprimir RPS'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 1
            end
          end
          object GroupBox5: TGroupBox
            Left = 0
            Top = 218
            Width = 198
            Height = 105
            Align = alTop
            Caption = ' NF-e '
            TabOrder = 1
          end
          object GroupBox6: TGroupBox
            Left = 0
            Top = 0
            Width = 198
            Height = 105
            Align = alTop
            Caption = ' Geral '
            TabOrder = 2
            object BitBtn11: TBitBtn
              Left = 2
              Top = 15
              Width = 194
              Height = 41
              Action = actGerarDocumentos
              Align = alTop
              Caption = 'Gerar Documentos fiscais'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 0
            end
            object BitBtn14: TBitBtn
              Left = 2
              Top = 56
              Width = 194
              Height = 41
              Action = actAbrirNota
              Align = alTop
              Caption = 'Abrir Nota'
              DoubleBuffered = True
              ParentDoubleBuffered = False
              TabOrder = 1
            end
          end
        end
      end
      object cxSplitter3: TcxSplitter
        Left = 505
        Top = 0
        Width = 8
        Height = 260
        HotZoneClassName = 'TcxMediaPlayer9Style'
        Control = cxGrid1
      end
    end
  end
  object Panel3: TPanel [5]
    Left = 0
    Top = 376
    Width = 885
    Height = 134
    Align = alBottom
    TabOrder = 5
    ExplicitTop = -154
    object cxSplitter2: TcxSplitter
      Left = 521
      Top = 1
      Width = 8
      Height = 132
      HotZoneClassName = 'TcxMediaPlayer9Style'
      Control = GroupBox3
    end
    object GroupBox2: TGroupBox
      Left = 529
      Top = 1
      Width = 355
      Height = 132
      Align = alClient
      Caption = ' Msg erro NFS-e '
      TabOrder = 1
      object mmNFSe: TMemo
        Left = 2
        Top = 15
        Width = 351
        Height = 115
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object GroupBox3: TGroupBox
      Left = 1
      Top = 1
      Width = 520
      Height = 132
      Align = alLeft
      Caption = ' Msg erro NF-e '
      TabOrder = 2
      object mmNFe: TMemo
        Left = 2
        Top = 15
        Width = 516
        Height = 115
        Align = alClient
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  inherited ActionList1: TActionList
    Left = 424
    Top = 200
    inherited actEditar: TAction
      Enabled = False
      Visible = False
    end
    inherited actExcluir: TAction
      Caption = 'Excluir lote'
    end
    inherited actPesquisar: TAction
      Enabled = False
      Visible = False
    end
    inherited actImprimir: TAction
      Enabled = False
      Visible = False
    end
    object actGerarDocumentos: TAction
      Caption = 'Gerar Documentos fiscais'
      ImageIndex = 44
      OnExecute = actGerarDocumentosExecute
    end
    object actImprimirNFSe: TAction
      Caption = 'Imprimir RPS'
      ImageIndex = 19
      OnExecute = actImprimirNFSeExecute
    end
    object actCancelarNFSe: TAction
      Caption = 'Cancelar NFS-e'
      ImageIndex = 8
      OnExecute = actCancelarNFSeExecute
    end
    object actAbrirNota: TAction
      Caption = 'Abrir Nota'
      ImageIndex = 10
      OnExecute = actAbrirNotaExecute
    end
  end
  inherited DataListagem: TDataSource
    Left = 256
    Top = 256
  end
  inherited CdsListagem: TpFIBClientDataSet
    Left = 336
    Top = 256
  end
  object DataItens: TDataSource
    DataSet = CdsItensLote
    Left = 192
    Top = 240
  end
  object CdsItensLote: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    OnNewRecord = CdsItensLoteNewRecord
    Left = 328
    Top = 200
  end
end
