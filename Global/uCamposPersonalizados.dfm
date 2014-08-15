inherited frmCamposPersonalizados: TfrmCamposPersonalizados
  BorderStyle = bsNone
  Caption = 'Campos Personalizados'
  ClientHeight = 439
  ClientWidth = 586
  ExplicitWidth = 586
  ExplicitHeight = 439
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 586
    Height = 439
    Align = alClient
    Caption = ' Campos personalizados '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object cxGrid1: TcxGrid
      Left = 2
      Top = 15
      Width = 582
      Height = 422
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object TvCampos: TcxGridDBTableView
        Tag = 99
        NavigatorButtons.ConfirmDelete = False
        DataController.DataSource = DataCampoPersonalizado
        DataController.Summary.DefaultGroupSummaryItems = <>
        DataController.Summary.FooterSummaryItems = <>
        DataController.Summary.SummaryGroups = <>
        OptionsBehavior.GoToNextCellOnEnter = True
        OptionsCustomize.ColumnSorting = False
        OptionsData.Deleting = False
        OptionsData.DeletingConfirmation = False
        OptionsData.Inserting = False
        OptionsView.ColumnAutoWidth = True
        OptionsView.GroupByBox = False
        object vCamposColumn1: TcxGridDBColumn
          DataBinding.FieldName = 'NOMECAMPO'
          Options.Editing = False
          Options.Focusing = False
          Width = 216
        end
        object vCamposColumn2: TcxGridDBColumn
          DataBinding.FieldName = 'VALORCAMPO'
          Width = 335
        end
      end
      object cxGrid1Level1: TcxGridLevel
        GridView = TvCampos
      end
    end
  end
  object DataCampoPersonalizado: TDataSource
    DataSet = CdsCampos
    Left = 200
    Top = 136
  end
  object CdsCampos: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsCamposAfterOpen
    BeforePost = CdsCamposBeforePost
    Left = 296
    Top = 144
  end
end
