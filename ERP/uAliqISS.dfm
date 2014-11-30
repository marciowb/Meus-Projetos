inherited frmAliqISS: TfrmAliqISS
  Caption = 'Al'#237'quota de ISS'
  ClientHeight = 489
  ClientWidth = 1143
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 1159
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 489
    Align = alLeft
    Caption = ' Estados '
    TabOrder = 0
    object cxGrid1: TcxGrid
      Left = 2
      Top = 15
      Width = 181
      Height = 472
      Align = alClient
      TabOrder = 0
      LevelTabs.Style = 9
      object TvEstados: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = DataEstados
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.GroupByBox = False
        object TvEstadosUF: TcxGridDBColumn
          Caption = 'Sigla'
          DataBinding.FieldName = 'UF'
        end
        object TvEstadosNOME: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'NOME'
        end
      end
      object TvMunicipios: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = DataMunicipio
        DataController.DetailKeyFieldNames = 'UF'
        DataController.KeyFieldNames = 'UF'
        DataController.MasterKeyFieldNames = 'UF'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.IncSearchItem = TvMunicipiosNOME
        OptionsView.GroupByBox = False
        object TvMunicipiosIBGE: TcxGridDBColumn
          DataBinding.FieldName = 'IBGE'
        end
        object TvMunicipiosNOME: TcxGridDBColumn
          Caption = 'Munic'#237'pio'
          DataBinding.FieldName = 'NOME'
        end
      end
      object TvTRibutos: TcxGridDBTableView
        Tag = 99
        NavigatorButtons.ConfirmDelete = False
        NavigatorButtons.First.Visible = False
        NavigatorButtons.PriorPage.Visible = False
        NavigatorButtons.Prior.Visible = False
        NavigatorButtons.Next.Visible = False
        NavigatorButtons.NextPage.Visible = False
        NavigatorButtons.Last.Visible = False
        NavigatorButtons.Insert.Hint = 'Incluir'
        NavigatorButtons.Delete.Hint = 'Apagar'
        NavigatorButtons.Edit.Hint = 'Editar'
        NavigatorButtons.Post.Hint = 'Gravar'
        NavigatorButtons.Cancel.Hint = 'Cancelar'
        NavigatorButtons.Refresh.Visible = False
        NavigatorButtons.SaveBookmark.Visible = False
        NavigatorButtons.GotoBookmark.Visible = False
        NavigatorButtons.Filter.Visible = False
        DataController.DataSource = DataCodMinicipal
        DataController.DetailKeyFieldNames = 'IDMUNICIPIO'
        DataController.KeyFieldNames = 'IDMUNICIPIO'
        DataController.MasterKeyFieldNames = 'IDMUNICIPIO'
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsView.Navigator = True
        OptionsView.GroupByBox = False
        object TvTRibutosColumn1: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODIGO'
          Options.Editing = False
          Options.Focusing = False
          Width = 60
        end
        object TvTRibutosIDCODIGOMUNICIPALSERVICO: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do tipo de servi'#231'o '
          DataBinding.FieldName = 'DESCRICAO'
          Options.Editing = False
          Options.Focusing = False
          Width = 400
        end
        object TvTRibutosALIQISS: TcxGridDBColumn
          Caption = 'Aliq. ISS'
          DataBinding.FieldName = 'ALIQISS'
          Width = 70
        end
        object vTRibutosColumn1: TcxGridDBColumn
          Caption = 'PIS'
          DataBinding.FieldName = 'ALIQPIS'
          Width = 60
        end
        object vTRibutosColumn2: TcxGridDBColumn
          Caption = 'COFINS'
          DataBinding.FieldName = 'ALIQCOFINS'
          Width = 60
        end
        object vTRibutosColumn3: TcxGridDBColumn
          Caption = 'CSLL'
          DataBinding.FieldName = 'ALIQCSLL'
          Width = 60
        end
        object vTRibutosColumn4: TcxGridDBColumn
          Caption = 'Valor minimo impostos federais'
          DataBinding.FieldName = 'VALORMINIMOTRIBFEDERAL'
          Width = 160
        end
        object vTRibutosColumn5: TcxGridDBColumn
          Caption = 'Valor minimo para IR'
          DataBinding.FieldName = 'VALORMINIMOIR'
          Width = 120
        end
      end
      object cxGrid1Level1: TcxGridLevel
        Caption = 'Estados'
        GridView = TvEstados
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 185
    Top = 0
    Width = 272
    Height = 489
    Align = alLeft
    Caption = ' Munic'#237'pios '
    TabOrder = 1
    object cxGrid2: TcxGrid
      Left = 2
      Top = 15
      Width = 268
      Height = 472
      Align = alClient
      TabOrder = 0
      object cxGrid2DBTableView1: TcxGridDBTableView
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = DataMunicipio
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.IncSearch = True
        OptionsBehavior.IncSearchItem = TvMunicipiosNOME
        OptionsView.GroupByBox = False
        object cxGrid2DBTableView1Column1: TcxGridDBColumn
          DataBinding.FieldName = 'IBGE'
          Width = 60
        end
        object cxGrid2DBTableView1Column2: TcxGridDBColumn
          Caption = 'Nome'
          DataBinding.FieldName = 'NOME'
          Width = 100
        end
      end
      object cxGrid2Level1: TcxGridLevel
        GridView = cxGrid2DBTableView1
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 457
    Top = 0
    Width = 686
    Height = 489
    Align = alClient
    Caption = ' C'#243'digos municipais de servi'#231'o '
    TabOrder = 2
    object cxGrid3: TcxGrid
      Left = 2
      Top = 15
      Width = 682
      Height = 472
      Align = alClient
      TabOrder = 0
      object cxGridDBTableView1: TcxGridDBTableView
        Tag = 99
        NavigatorButtons.ConfirmDelete = False
        NavigatorButtons.First.Visible = False
        NavigatorButtons.PriorPage.Visible = False
        NavigatorButtons.Prior.Visible = False
        NavigatorButtons.Next.Visible = False
        NavigatorButtons.NextPage.Visible = False
        NavigatorButtons.Last.Visible = False
        NavigatorButtons.Insert.Hint = 'Incluir'
        NavigatorButtons.Delete.Hint = 'Apagar'
        NavigatorButtons.Edit.Hint = 'Editar'
        NavigatorButtons.Post.Hint = 'Gravar'
        NavigatorButtons.Cancel.Hint = 'Cancelar'
        NavigatorButtons.Refresh.Visible = False
        NavigatorButtons.SaveBookmark.Visible = False
        NavigatorButtons.GotoBookmark.Visible = False
        NavigatorButtons.Filter.Visible = False
        DataController.DataSource = DataCodMinicipal
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsData.DeletingConfirmation = False
        OptionsView.Navigator = True
        OptionsView.GroupByBox = False
        object cxGridDBTableView1Column1: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODIGO'
          Width = 60
        end
        object cxGridDBTableView1Column2: TcxGridDBColumn
          Caption = 'Descri'#231#227'o do tipo de servi'#231'o'
          DataBinding.FieldName = 'DESCRICAO'
          Width = 150
        end
        object cxGridDBTableView1Column3: TcxGridDBColumn
          Caption = 'Aliq. ISS'
          DataBinding.FieldName = 'ALIQISS'
          Width = 60
        end
        object cxGridDBTableView1Column4: TcxGridDBColumn
          Caption = 'Aliq. PIS'
          DataBinding.FieldName = 'ALIQPIS'
          Width = 60
        end
        object cxGridDBTableView1Column5: TcxGridDBColumn
          Caption = 'Aliq. COFINS'
          DataBinding.FieldName = 'ALIQCOFINS'
          Width = 76
        end
        object cxGridDBTableView1Column6: TcxGridDBColumn
          Caption = 'Aliq. CSLL'
          DataBinding.FieldName = 'ALIQCSLL'
          Width = 60
        end
        object cxGridDBTableView1Column9: TcxGridDBColumn
          Caption = 'Aliq. I.R.'
          DataBinding.FieldName = 'ALIQIR'
        end
        object cxGridDBTableView1Column7: TcxGridDBColumn
          Caption = 'Valor minimo impostos federais'
          DataBinding.FieldName = 'VALORMINIMOTRIBFEDERAL'
          Width = 165
        end
        object cxGridDBTableView1Column8: TcxGridDBColumn
          Caption = 'Valor minimo para I.R.'
          DataBinding.FieldName = 'VALORMINIMOIR'
          Width = 126
        end
      end
      object cxGridLevel1: TcxGridLevel
        GridView = cxGridDBTableView1
      end
    end
  end
  object DataEstados: TDataSource
    DataSet = CdsEstados
    Left = 48
    Top = 272
  end
  object DataMunicipio: TDataSource
    DataSet = CdsMunicipio
    Left = 48
    Top = 216
  end
  object DataCodMinicipal: TDataSource
    DataSet = CdsCodMunicipal
    Left = 48
    Top = 152
  end
  object CdsEstados: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = CdsEstadosAfterScroll
    Left = 216
    Top = 320
  end
  object CdsMunicipio: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = CdsMunicipioAfterScroll
    Left = 288
    Top = 256
  end
  object CdsCodMunicipal: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsCodMunicipalAfterOpen
    AfterPost = CdsCodMunicipalAfterPost
    BeforeDelete = CdsCodMunicipalBeforeDelete
    OnNewRecord = CdsCodMunicipalNewRecord
    Left = 384
    Top = 200
  end
end
