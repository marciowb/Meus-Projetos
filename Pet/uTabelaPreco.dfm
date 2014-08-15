inherited frmTabelaPreco: TfrmTabelaPreco
  Caption = 'Tabela de pre'#231'o'
  ClientHeight = 471
  ClientWidth = 843
  ExplicitWidth = 851
  ExplicitHeight = 505
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 843
    Height = 471
    Align = alClient
    TabOrder = 0
    object TvPreco: TcxGridDBTableView
      Tag = 99
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = DataPreco
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object TvPrecoNOMETIPOSERVICO: TcxGridDBColumn
        Caption = 'Servi'#231'o'
        DataBinding.FieldName = 'NOMETIPOSERVICO'
        Visible = False
        GroupIndex = 0
        Width = 319
      end
      object TvPrecoNOMECATEGORIAANIMAL: TcxGridDBColumn
        Caption = 'Servi'#231'o / Categoria'
        DataBinding.FieldName = 'NOMECATEGORIAANIMAL'
        Options.Editing = False
        Options.Focusing = False
        Width = 338
      end
      object TvPrecoPRECO: TcxGridDBColumn
        Caption = 'Pre'#231'o'
        DataBinding.FieldName = 'PRECO'
        Width = 76
      end
      object vPrecoColumn1: TcxGridDBColumn
        Caption = 'Esp'#233'cie'
        DataBinding.FieldName = 'NOMETIPOANIMAL'
        Visible = False
        GroupIndex = 1
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = TvPreco
    end
  end
  object DataPreco: TDataSource
    DataSet = CdsPreco
    Left = 288
    Top = 312
  end
  object CdsPreco: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsPrecoAfterOpen
    BeforePost = CdsPrecoBeforePost
    AfterPost = CdsPrecoAfterPost
    Left = 408
    Top = 312
  end
end
