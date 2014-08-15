object frmLista_Layouts: TfrmLista_Layouts
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = 'frmLista_Layouts'
  ClientHeight = 286
  ClientWidth = 589
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtom: TPanel
    Left = 0
    Top = 245
    Width = 589
    Height = 41
    Align = alBottom
    TabOrder = 0
    object btnSelecionar: TBitBtn
      Left = 192
      Top = 3
      Width = 88
      Height = 34
      Action = actSelecionar
      Caption = 'Selecionar'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 0
    end
    object btnCancelar: TBitBtn
      Left = 309
      Top = 5
      Width = 88
      Height = 34
      Caption = '&Cancelar'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object CategoryPanelGroup1: TCategoryPanelGroup
    Left = 389
    Top = 0
    Height = 245
    VertScrollBar.Tracking = True
    Align = alRight
    GradientDirection = gdHorizontal
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    TabOrder = 1
    object CategoryPanel1: TCategoryPanel
      Top = 0
      Height = 169
      Caption = 'Geral'
      TabOrder = 0
      ExplicitWidth = 198
      object SpeedButton1: TSpeedButton
        Left = 0
        Top = 33
        Width = 179
        Height = 33
        Action = actEditar
        Align = alTop
        ExplicitTop = 0
        ExplicitWidth = 196
      end
      object SpeedButton2: TSpeedButton
        Left = 0
        Top = 0
        Width = 179
        Height = 33
        Action = actNovo
        Align = alTop
        ExplicitWidth = 196
      end
      object SpeedButton3: TSpeedButton
        Left = 0
        Top = 99
        Width = 179
        Height = 33
        Action = actDeletar
        Align = alTop
        ExplicitTop = 66
        ExplicitWidth = 196
      end
      object SpeedButton4: TSpeedButton
        Left = 0
        Top = 66
        Width = 179
        Height = 33
        Action = actVisualizar
        Align = alTop
        ExplicitWidth = 196
      end
    end
    object CategoryPanel2: TCategoryPanel
      Top = 169
      Height = 136
      Caption = 'Configura'#231#245'es'
      TabOrder = 1
      ExplicitWidth = 185
      object Label1: TLabel
        Left = 6
        Top = 7
        Width = 91
        Height = 13
        Caption = 'Impressora padr'#227'o'
      end
      object DBRadioGroup1: TDBRadioGroup
        Left = 6
        Top = 48
        Width = 183
        Height = 57
        Caption = ' Op'#231#245'es '
        DataField = 'FLAGTIPOIMPRESSAO'
        DataSource = DataRelatorio
        Items.Strings = (
          'Imprimir direto'
          'Visualizar na tela')
        ParentBackground = True
        TabOrder = 0
        Values.Strings = (
          'I'
          'V')
      end
      object cmbImpressoras: TDBComboBox
        Left = 6
        Top = 24
        Width = 145
        Height = 21
        DataField = 'IMPRESSORAPADRAO'
        DataSource = DataRelatorio
        TabOrder = 1
      end
    end
    object CategoryPanel3: TCategoryPanel
      Top = 305
      Height = 30
      Caption = ' Configura'#231#245'es do layout '
      Collapsed = True
      TabOrder = 2
      ExplicitWidth = 185
      ExpandedHeight = 102
      object DBRadioGroup2: TDBRadioGroup
        Left = 0
        Top = 0
        Width = 179
        Height = 0
        Align = alClient
        Caption = ' Tipo de impress'#227'o '
        DataField = 'FLAGTIPOLAYOUT'
        DataSource = DataLayout
        Items.Strings = (
          'Impressora gr'#225'fica'
          'Impressora matricial'
          'Impressora 40 Colunas')
        ParentBackground = True
        TabOrder = 0
        Values.Strings = (
          'G'
          'M'
          'N')
      end
    end
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 389
    Height = 245
    Align = alClient
    TabOrder = 2
    object TvLayouts: TcxGridDBTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = DataLayout
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
      object vLayoutsColumn1: TcxGridDBColumn
        Caption = 'Nome'
        DataBinding.FieldName = 'NOMELAYOUT'
        Width = 208
      end
      object vLayoutsColumn2: TcxGridDBColumn
        Caption = 'Data de modifica'#231#227'o'
        DataBinding.FieldName = 'DATAMODIFICACAO'
        Width = 105
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = TvLayouts
    end
  end
  object DataLayout: TDataSource
    DataSet = CdsLayout
    Left = 48
    Top = 128
  end
  object CdsLayout: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsLayoutAfterOpen
    AfterPost = CdsLayoutAfterPost
    Left = 118
    Top = 131
  end
  object ActionList1: TActionList
    Images = DMConexao.ImageList24_24
    Left = 56
    Top = 72
    object actNovo: TAction
      Caption = 'Novo'
      ImageIndex = 16
      OnExecute = actNovoExecute
    end
    object actEditar: TAction
      Caption = 'Editar'
      ImageIndex = 10
      OnExecute = actEditarExecute
    end
    object actVisualizar: TAction
      Caption = 'Visualizar'
      OnExecute = actVisualizarExecute
    end
    object actDeletar: TAction
      Caption = 'Deletar'
      ImageIndex = 39
      OnExecute = actDeletarExecute
    end
    object actRenomear: TAction
      Caption = 'Renomear'
      OnExecute = actRenomearExecute
    end
    object actSelecionar: TAction
      Caption = 'Selecionar'
      ImageIndex = 33
      OnExecute = actSelecionarExecute
    end
  end
  object CdsRelatorio: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterPost = CdsRelatorioAfterPost
    Left = 272
    Top = 80
  end
  object DataRelatorio: TDataSource
    DataSet = CdsRelatorio
    Left = 184
    Top = 80
  end
end
