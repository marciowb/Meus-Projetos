inherited frmLst_LoteNotas: TfrmLst_LoteNotas
  Caption = 'Listagem de Lotes de Nota'
  ClientHeight = 529
  ClientWidth = 877
  ExplicitWidth = 893
  ExplicitHeight = 568
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlFiltros: TPanel
    Width = 877
    ExplicitWidth = 877
  end
  inherited Panel2: TPanel
    Width = 877
    ExplicitWidth = 877
    inherited BitBtn1: TBitBtn
      Left = 791
      ExplicitLeft = 791
    end
    inherited BitBtn9: TBitBtn
      Left = 700
      ExplicitLeft = 700
    end
    object BitBtn11: TBitBtn
      Left = 536
      Top = 0
      Width = 164
      Height = 31
      Action = actGerarDocumentos
      Align = alLeft
      Caption = 'Gerar Documentos fiscais'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 10
    end
  end
  inherited Status: TdxStatusBar
    Top = 509
    Width = 877
    ExplicitTop = 509
    ExplicitWidth = 877
  end
  inherited pnlCaption: TPanel
    Width = 877
    ExplicitWidth = 877
    inherited Panel4: TPanel
      Left = 526
      ExplicitLeft = 526
    end
  end
  inherited PageControl: TcxPageControl
    Width = 877
    Height = 421
    ExplicitWidth = 877
    ExplicitHeight = 421
    ClientRectBottom = 421
    ClientRectRight = 877
    inherited tsListagem: TcxTabSheet
      ExplicitTop = 20
      ExplicitWidth = 877
      ExplicitHeight = 401
      inherited cxGrid1: TcxGrid
        Width = 877
        Height = 215
        ExplicitWidth = 877
        ExplicitHeight = 215
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 223
        Width = 877
        Height = 178
        Align = alBottom
        Caption = ' Notas '
        TabOrder = 1
        object cxGrid2: TcxGrid
          Left = 2
          Top = 15
          Width = 873
          Height = 161
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
            DataController.Summary.FooterSummaryItems = <>
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
      end
      object cxSplitter1: TcxSplitter
        Left = 0
        Top = 215
        Width = 877
        Height = 8
        HotZoneClassName = 'TcxMediaPlayer9Style'
        AlignSplitter = salBottom
        Control = GroupBox1
      end
    end
  end
  inherited ActionList1: TActionList
    inherited actEditar: TAction
      Enabled = False
      Visible = False
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
  end
  object DataItens: TDataSource
    DataSet = CdsItensLote
    Left = 208
    Top = 208
  end
  object CdsItensLote: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    OnNewRecord = CdsItensLoteNewRecord
    Left = 328
    Top = 200
  end
end
