object fraLebrete: TfraLebrete
  Left = 0
  Top = 0
  Width = 347
  Height = 304
  Align = alRight
  TabOrder = 0
  Visible = False
  object GradientLabel1: TGradientLabel
    Left = 0
    Top = 0
    Width = 347
    Height = 17
    Align = alTop
    Alignment = taCenter
    AutoSize = False
    Caption = ' Acompanhamento de animais '
    Color = 12615680
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    GlowSize = 1
    ParentColor = False
    ParentFont = False
    Transparent = False
    Layout = tlCenter
    ColorTo = clWhite
    EllipsType = etEndEllips
    GradientType = gtFullHorizontal
    GradientDirection = gdLeftToRight
    Indent = 0
    LineWidth = 2
    Orientation = goHorizontal
    TransparentText = False
    VAlignment = vaTop
    Version = '1.1.1.0'
    ExplicitLeft = 8
    ExplicitTop = 32
    ExplicitWidth = 65
  end
  object cxGrid1: TcxGrid
    Left = 0
    Top = 17
    Width = 347
    Height = 287
    Align = alClient
    TabOrder = 0
    object cxGrid1DBCardView1: TcxGridDBCardView
      NavigatorButtons.ConfirmDelete = False
      DataController.DataSource = DataLembrete
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      LayoutDirection = ldVertical
      OptionsBehavior.FocusCellOnTab = True
      OptionsBehavior.FocusFirstCellOnNewRecord = True
      OptionsBehavior.PullFocusing = True
      OptionsCustomize.CardExpanding = True
      OptionsCustomize.LayeredRows = True
      OptionsData.Deleting = False
      OptionsView.CardAutoWidth = True
      OptionsView.CardWidth = 247
      RowLayout = rlVertical
      object cxGrid1DBCardView1DATA: TcxGridDBCardViewRow
        Caption = 'Data'
        DataBinding.FieldName = 'DATA'
        Kind = rkCaption
        Position.BeginsLayer = True
      end
      object cxGrid1DBCardView1CLIENTE: TcxGridDBCardViewRow
        Caption = 'Cliente'
        DataBinding.FieldName = 'CLIENTE'
        Kind = rkCaption
        Position.BeginsLayer = False
      end
      object cxGrid1DBCardView1NOMEANIMAL: TcxGridDBCardViewRow
        Caption = 'Animal'
        DataBinding.FieldName = 'NOMEANIMAL'
        Kind = rkCaption
        Position.BeginsLayer = False
      end
      object cxGrid1DBCardView1FLAGCHECADO: TcxGridDBCardViewRow
        Caption = 'Ok'
        DataBinding.FieldName = 'FLAGCHECADO'
        RepositoryItem = cxEditRepository1CheckBoxItem1
        Position.BeginsLayer = False
      end
      object cxGrid1DBCardView1OBS: TcxGridDBCardViewRow
        Caption = 'Texto'
        DataBinding.FieldName = 'OBS'
        RepositoryItem = cxEditRepository1BlobItem1
        Position.BeginsLayer = False
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = cxGrid1DBCardView1
    end
  end
  object DataLembrete: TDataSource
    DataSet = CdsLebrete
    Left = 136
    Top = 144
  end
  object CdsLebrete: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsLebreteAfterOpen
    Left = 224
    Top = 152
  end
  object Timer: TTimer
    Interval = 60000
    OnTimer = TimerTimer
    Left = 72
    Top = 144
  end
  object cxEditRepository1: TcxEditRepository
    Left = 56
    Top = 240
    object cxEditRepository1CheckBoxItem1: TcxEditRepositoryCheckBoxItem
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = 'Y'
      Properties.ValueUnchecked = 'N'
    end
    object cxEditRepository1BlobItem1: TcxEditRepositoryBlobItem
      Properties.BlobEditKind = bekMemo
      Properties.BlobPaintStyle = bpsText
      Properties.ImmediatePost = True
      Properties.MemoAutoReplace = True
      Properties.MemoScrollBars = ssVertical
      Properties.PopupHeight = 500
      Properties.PopupWidth = 500
      Properties.ReadOnly = True
    end
  end
end
