object FDBGridLayoutEditor: TFDBGridLayoutEditor
  Left = 82
  Top = 324
  BorderStyle = bsDialog
  Caption = 'FDBGridLayoutEditor'
  ClientHeight = 273
  ClientWidth = 566
  Color = clBtnFace
  OldCreateOrder = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object TPanel
    Left = 0
    Top = 0
    Width = 396
    Height = 273
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object TPanel
      Left = 0
      Top = 242
      Width = 396
      Height = 31
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 0
      object BBands: TButton
        Left = 4
        Top = 5
        Width = 72
        Height = 22
        Caption = '&Bands...'
        TabOrder = 0
        OnClick = BBandsClick
      end
      object BColumns: TButton
        Tag = 1
        Left = 82
        Top = 5
        Width = 72
        Height = 22
        Caption = '&Columns...'
        TabOrder = 1
        OnClick = BBandsClick
      end
      object BSummary: TButton
        Tag = 2
        Left = 160
        Top = 5
        Width = 72
        Height = 22
        Caption = '&Summary...'
        TabOrder = 2
        OnClick = BBandsClick
      end
      object BClear: TButton
        Left = 318
        Top = 5
        Width = 72
        Height = 22
        Caption = 'Cl&ear'
        TabOrder = 3
        OnClick = BClearClick
      end
      object BWizard: TButton
        Left = 239
        Top = 5
        Width = 72
        Height = 22
        Caption = '&Wizard...'
        TabOrder = 4
        OnClick = BWizardClick
      end
    end
    object GridPanel: TPanel
      Left = 4
      Top = 5
      Width = 386
      Height = 237
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      TabOrder = 1
    end
    object TPanel
      Left = 0
      Top = 5
      Width = 4
      Height = 237
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 2
    end
    object TPanel
      Left = 390
      Top = 5
      Width = 6
      Height = 237
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 3
    end
    object TPanel
      Left = 0
      Top = 0
      Width = 396
      Height = 5
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 4
    end
  end
  object TPanel
    Left = 396
    Top = 0
    Width = 170
    Height = 273
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 1
    object TPanel
      Left = 166
      Top = 0
      Width = 4
      Height = 269
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 0
    end
    object TPanel
      Left = 0
      Top = 269
      Width = 170
      Height = 4
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
    end
    object TGroupBox
      Left = 0
      Top = 0
      Width = 166
      Height = 269
      Align = alClient
      Caption = ' Items  '
      TabOrder = 2
      object LItems: TListBox
        Left = 8
        Top = 15
        Width = 150
        Height = 217
        Align = alClient
        ItemHeight = 13
        MultiSelect = True
        PopupMenu = pmItems
        TabOrder = 0
        OnClick = LItemsClick
      end
      object TPanel
        Left = 2
        Top = 15
        Width = 6
        Height = 217
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 1
      end
      object TPanel
        Left = 158
        Top = 15
        Width = 6
        Height = 217
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
      end
      object TPanel
        Left = 2
        Top = 15
        Width = 162
        Height = 0
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 3
      end
      object TPanel
        Left = 2
        Top = 232
        Width = 162
        Height = 35
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 4
        object BAdd: TButton
          Left = 7
          Top = 7
          Width = 71
          Height = 22
          Caption = '&Add'
          TabOrder = 0
          OnClick = BAddClick
        end
        object BDelete: TButton
          Left = 85
          Top = 7
          Width = 71
          Height = 22
          Caption = '&Delete'
          TabOrder = 1
          OnClick = BDeleteClick
        end
      end
    end
  end
  object pmItems: TPopupMenu
    Left = 494
    Top = 58
    object miAdd: TMenuItem
      Caption = '&Add...'
      ShortCut = 45
      OnClick = BAddClick
    end
    object miDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDeleteClick
    end
    object TMenuItem
      Caption = '-'
    end
    object miSelectAll: TMenuItem
      Caption = '&Select All'
      OnClick = miSelectAllClick
    end
  end
  object pmButtons: TPopupMenu
    Left = 286
    Top = 49
    object miBands: TMenuItem
      Caption = '&Bands...'
      OnClick = miBandsClick
    end
    object miColumns: TMenuItem
      Caption = '&Columns...'
      OnClick = miColumnsClick
    end
    object miSummary: TMenuItem
      Caption = '&Summary...'
      OnClick = miSummaryClick
    end
    object miWizard: TMenuItem
      Caption = '&Wizard...'
      OnClick = BWizardClick
    end
    object TMenuItem
      Caption = '-'
    end
    object miClear: TMenuItem
      Caption = 'Cl&ear'
      OnClick = BClearClick
    end
  end
end
