inherited frmSQLConsole: TfrmSQLConsole
  Caption = 'SQL Console'
  ExplicitWidth = 686
  ExplicitHeight = 506
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvEnterAsTab1: TJvEnterAsTab
    Left = 642
    Top = 8
    ExplicitLeft = 642
    ExplicitTop = 8
  end
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 678
    Height = 472
    ActivePage = cxTabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 256
    ExplicitTop = 152
    ExplicitWidth = 289
    ExplicitHeight = 193
    ClientRectBottom = 472
    ClientRectRight = 678
    ClientRectTop = 24
    object cxTabSheet1: TcxTabSheet
      Caption = 'Script'
      ImageIndex = 0
      ExplicitWidth = 289
      ExplicitHeight = 169
      object mmScript: TRichEdit
        Left = 0
        Top = 25
        Width = 678
        Height = 343
        Align = alClient
        HideSelection = False
        HideScrollBars = False
        ScrollBars = ssBoth
        TabOrder = 0
        ExplicitTop = 18
        ExplicitHeight = 382
      end
      object Panel1: TPanel
        Left = 0
        Top = 368
        Width = 678
        Height = 80
        Align = alBottom
        BevelOuter = bvLowered
        TabOrder = 1
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 678
        Height = 25
        Align = alTop
        BevelOuter = bvLowered
        TabOrder = 2
        object btnLimpar: TBitBtn
          Left = 1
          Top = 1
          Width = 75
          Height = 23
          Align = alLeft
          Caption = '&Limpar'
          TabOrder = 0
          OnClick = btnLimparClick
          ExplicitLeft = 96
          ExplicitTop = 8
          ExplicitHeight = 25
        end
        object BtnExecutar: TBitBtn
          Left = 76
          Top = 1
          Width = 75
          Height = 23
          Align = alLeft
          Caption = '&Executar'
          TabOrder = 1
          OnClick = BtnExecutarClick
          ExplicitLeft = 208
          ExplicitTop = 8
          ExplicitHeight = 25
        end
      end
    end
    object cxTabSheet2: TcxTabSheet
      Caption = 'Resultados'
      ImageIndex = 1
      ExplicitWidth = 289
      ExplicitHeight = 169
      object Panel3: TPanel
        Left = 0
        Top = 407
        Width = 678
        Height = 41
        Align = alBottom
        TabOrder = 0
        ExplicitLeft = 88
        ExplicitTop = 176
        ExplicitWidth = 185
      end
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 678
        Height = 41
        Align = alTop
        TabOrder = 1
        ExplicitLeft = 104
        ExplicitTop = 24
        ExplicitWidth = 185
      end
      object cxGrid1: TcxGrid
        Left = 0
        Top = 41
        Width = 678
        Height = 366
        Align = alClient
        TabOrder = 2
        ExplicitLeft = 208
        ExplicitTop = 96
        ExplicitWidth = 250
        ExplicitHeight = 200
        object TvResultado: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.DataSource = DataResultado
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = TvResultado
        end
      end
    end
  end
  object DataResultado: TDataSource
    DataSet = CdsResultado
    Left = 328
    Top = 240
  end
  object CdsResultado: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 240
  end
  object Monitor: TZSQLMonitor
    Active = True
    MaxTraceCount = 100
    Left = 488
    Top = 240
  end
end
