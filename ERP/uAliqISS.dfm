inherited frmAliqISS: TfrmAliqISS
  Caption = 'Al'#237'quota de ISS'
  ClientHeight = 489
  ClientWidth = 655
  Position = poDesigned
  WindowState = wsMaximized
  ExplicitWidth = 671
  ExplicitHeight = 528
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 655
    Height = 489
    Align = alClient
    TabOrder = 0
    LevelTabs.Style = 9
    ExplicitLeft = 32
    ExplicitTop = 80
    ExplicitWidth = 250
    ExplicitHeight = 200
    object cxGrid1DBTableView1: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = DataEstados
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView1UF: TcxGridDBColumn
        Caption = 'Sigla'
        DataBinding.FieldName = 'UF'
      end
      object cxGrid1DBTableView1NOME: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'NOME'
      end
    end
    object cxGrid1DBTableView2: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = DataMunicipio
      DataController.DetailKeyFieldNames = 'UF'
      DataController.KeyFieldNames = 'UF'
      DataController.MasterKeyFieldNames = 'UF'
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsBehavior.IncSearch = True
      OptionsBehavior.IncSearchItem = cxGrid1DBTableView2NOME
      OptionsView.GroupByBox = False
      object cxGrid1DBTableView2IBGE: TcxGridDBColumn
        DataBinding.FieldName = 'IBGE'
      end
      object cxGrid1DBTableView2NOME: TcxGridDBColumn
        Caption = 'Munic'#237'pio'
        DataBinding.FieldName = 'NOME'
      end
    end
    object cxGrid1DBTableView3: TcxGridDBTableView
      Tag = 99
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
      object cxGrid1DBTableView3Column1: TcxGridDBColumn
        Caption = 'C'#243'digo'
        DataBinding.FieldName = 'CODIGO'
        Options.Editing = False
        Options.Focusing = False
        Width = 60
      end
      object cxGrid1DBTableView3IDCODIGOMUNICIPALSERVICO: TcxGridDBColumn
        Caption = 'Descri'#231#227'o do tipo de servi'#231'o '
        DataBinding.FieldName = 'DESCRICAO'
        Options.Editing = False
        Options.Focusing = False
        Width = 400
      end
      object cxGrid1DBTableView3ALIQISS: TcxGridDBColumn
        Caption = 'Aliq. ISS'
        DataBinding.FieldName = 'ALIQISS'
        Width = 70
      end
    end
    object cxGrid1Level1: TcxGridLevel
      Caption = 'Estados'
      GridView = cxGrid1DBTableView1
      object cxGrid1Level2: TcxGridLevel
        Caption = 'Munic'#237'pios'
        GridView = cxGrid1DBTableView2
        object cxGrid1Level3: TcxGridLevel
          Tag = 99
          Caption = 'C'#243'digos de servi'#231'o'
          GridView = cxGrid1DBTableView3
        end
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
    Left = 216
    Top = 320
  end
  object CdsMunicipio: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 256
  end
  object CdsCodMunicipal: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsCodMunicipalAfterOpen
    AfterPost = CdsCodMunicipalAfterPost
    OnNewRecord = CdsCodMunicipalNewRecord
    Left = 384
    Top = 200
  end
end
