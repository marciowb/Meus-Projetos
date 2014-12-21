inherited frmLst_LoteNotas: TfrmLst_LoteNotas
  Caption = 'Listagem de Lotes de Nota'
  ExplicitWidth = 887
  ExplicitHeight = 569
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited BitBtn1: TBitBtn
      Left = 791
      Glyph.Data = {00000000}
    end
    inherited BitBtn2: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited BitBtn3: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited BitBtn4: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited BitBtn5: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited BitBtn6: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited BitBtn7: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited BitBtn8: TBitBtn
      Glyph.Data = {00000000}
    end
    inherited BitBtn9: TBitBtn
      Left = 700
      Glyph.Data = {00000000}
    end
    inherited BitBtn10: TBitBtn
      Glyph.Data = {00000000}
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
      ExplicitLeft = 621
      ExplicitTop = 21
    end
  end
  inherited PageControl: TcxPageControl
    inherited tsListagem: TcxTabSheet
      inherited cxGrid1: TcxGrid
        Height = 216
        ExplicitHeight = 201
        inherited TvListagem: TcxGridDBTableView
          Styles.Inactive = nil
          Styles.Selection = nil
          Styles.Group = nil
        end
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 224
        Width = 871
        Height = 178
        Align = alBottom
        Caption = ' Notas '
        TabOrder = 1
        object cxGrid2: TcxGrid
          Left = 2
          Top = 15
          Width = 867
          Height = 161
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 88
          ExplicitTop = 40
          ExplicitWidth = 250
          ExplicitHeight = 200
          object TvNotas: TcxGridDBTableView
            NavigatorButtons.ConfirmDelete = False
            DataController.DataSource = DataItens
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.Footer = True
            OptionsView.GroupByBox = False
            object vNotasColumn1: TcxGridDBColumn
              Caption = 'Data'
              DataBinding.FieldName = 'DATA'
              Width = 60
            end
            object vNotasColumn2: TcxGridDBColumn
              Caption = 'N'#250'mero sa'#237'da'
              DataBinding.FieldName = 'NUMEROSAIDA'
              Width = 100
            end
            object vNotasColumn3: TcxGridDBColumn
              Caption = 'Pessoa'
              DataBinding.FieldName = 'PESSOA'
              Width = 300
            end
            object vNotasColumn4: TcxGridDBColumn
              Caption = 'Status'
              DataBinding.FieldName = 'STATUS'
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
        Top = 216
        Width = 871
        Height = 8
        HotZoneClassName = 'TcxMediaPlayer9Style'
        AlignSplitter = salBottom
        ExplicitTop = 201
        ExplicitWidth = 8
      end
    end
  end
  inherited ActionList1: TActionList
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
    Left = 328
    Top = 200
  end
end
