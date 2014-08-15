object FdxTreeListFields: TFdxTreeListFields
  Left = 370
  Top = 109
  Width = 423
  Height = 370
  BorderIcons = [biSystemMenu]
  Caption = 'Add all fields'
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 323
    Top = 0
    Width = 92
    Height = 343
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object BOk: TButton
      Left = 10
      Top = 11
      Width = 75
      Height = 22
      Caption = '&OK'
      ModalResult = 1
      TabOrder = 0
    end
    object BCancel: TButton
      Left = 10
      Top = 45
      Width = 75
      Height = 22
      Cancel = True
      Caption = '&Cancel'
      ModalResult = 2
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 0
      Top = 302
      Width = 92
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 3
      object BHelp: TButton
        Left = 11
        Top = 10
        Width = 75
        Height = 22
        Caption = '&Help'
        TabOrder = 0
      end
    end
    object BDelete: TButton
      Left = 10
      Top = 106
      Width = 75
      Height = 22
      Caption = '&Delete'
      TabOrder = 2
      OnClick = BDeleteClick
    end
  end
  object Wizard: TdxTreeList
    Left = 0
    Top = 0
    Width = 323
    Height = 343
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    BandFont.Charset = DEFAULT_CHARSET
    BandFont.Color = clWindowText
    BandFont.Height = -11
    BandFont.Name = 'MS Sans Serif'
    BandFont.Style = []
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'MS Sans Serif'
    HeaderFont.Style = [fsBold]
    HideSelection = False
    LookAndFeel = lfFlat
    Options = [aoColumnSizing, aoEditing, aoTabThrough, aoImmediateEditor, aoAutoWidth]
    OptionsEx = [aoInvertSelect, aoUseBitmap, aoAutoCalcPreviewLines, aoBandSizing, aoEnterShowEditor, aoDragScroll, aoDragExpand, aoShowButtonAlways]
    PaintStyle = psOutlook
    PreviewFont.Charset = DEFAULT_CHARSET
    PreviewFont.Color = clBlue
    PreviewFont.Height = -11
    PreviewFont.Name = 'MS Sans Serif'
    PreviewFont.Style = []
    TreeLineColor = clGrayText
    ShowGrid = True
    OnKeyDown = WizardKeyDown
    object colFieldName: TdxTreeListColumn
      Caption = 'FieldName'
      DisableEditor = True
      HeaderAlignment = taCenter
      Width = 101
      BandIndex = 0
      RowIndex = 0
    end
    object colColumnClass: TdxTreeListPickColumn
      Caption = 'ColumnClass'
      HeaderAlignment = taCenter
      Width = 170
      BandIndex = 0
      RowIndex = 0
      PopupBorder = pbSingle
      DropDownListStyle = True
    end
    object colVisible: TdxTreeListCheckColumn
      Caption = 'Visible'
      HeaderAlignment = taCenter
      Width = 50
      BandIndex = 0
      RowIndex = 0
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
  end
end
