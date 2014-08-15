object FdxTreeListEditor: TFdxTreeListEditor
  Left = 432
  Top = 109
  Width = 375
  Height = 276
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'FdxTreeListEditor'
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 367
    Height = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 8
    Width = 6
    Height = 233
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 361
    Top = 8
    Width = 6
    Height = 233
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 0
    Top = 241
    Width = 367
    Height = 8
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
  end
  object PageControl: TPageControl
    Left = 6
    Top = 8
    Width = 355
    Height = 233
    ActivePage = tsColumns
    Align = alClient
    TabOrder = 4
    OnChange = PageControlChange
    object tsBands: TTabSheet
      Caption = '  Bands  '
      object Panel12: TPanel
        Left = 241
        Top = 6
        Width = 106
        Height = 222
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object BAddBand: TButton
          Left = 8
          Top = 0
          Width = 91
          Height = 22
          Caption = '&Add'
          TabOrder = 0
          OnClick = BAddBandClick
        end
        object BDeleteBand: TButton
          Left = 8
          Top = 29
          Width = 91
          Height = 22
          Caption = '&Delete'
          TabOrder = 1
          OnClick = BDeleteBandClick
        end
        object BUpBand: TButton
          Left = 8
          Top = 58
          Width = 91
          Height = 22
          Caption = 'Move &Up'
          TabOrder = 2
          OnClick = BUpBandClick
        end
        object BDownBand: TButton
          Left = 8
          Top = 87
          Width = 91
          Height = 22
          Caption = 'Move Dow&n'
          TabOrder = 3
          OnClick = BDownBandClick
        end
        object BRestoreDefault: TButton
          Left = 8
          Top = 116
          Width = 91
          Height = 22
          Caption = 'Rest&ore Defaults'
          TabOrder = 4
          OnClick = BRestoreDefaultClick
        end
      end
      object Panel13: TPanel
        Left = 0
        Top = 0
        Width = 347
        Height = 6
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
      end
      object Panel15: TPanel
        Left = 0
        Top = 228
        Width = 347
        Height = 6
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
      end
      object Panel24: TPanel
        Left = 0
        Top = 6
        Width = 6
        Height = 222
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 3
      end
      object LBands: TListBox
        Left = 6
        Top = 6
        Width = 235
        Height = 222
        Align = alClient
        DragMode = dmAutomatic
        ItemHeight = 13
        MultiSelect = True
        PopupMenu = pmBands
        TabOrder = 4
        OnClick = LBandsClick
        OnDragDrop = LBandsDragDrop
        OnDragOver = LBandsDragOver
        OnEndDrag = LBandsEndDrag
        OnKeyDown = CListBoxKeyDown
        OnStartDrag = CListBoxStartDrag
      end
    end
    object tsColumns: TTabSheet
      Caption = '  Columns  '
      object Panel5: TPanel
        Left = 0
        Top = 6
        Width = 6
        Height = 193
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
      end
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 347
        Height = 6
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
      end
      object Panel8: TPanel
        Left = 0
        Top = 199
        Width = 347
        Height = 6
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
      end
      object pnButtons: TPanel
        Left = 241
        Top = 6
        Width = 106
        Height = 193
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 3
        object BAdd: TButton
          Left = 8
          Top = 0
          Width = 91
          Height = 22
          Caption = '&Add...'
          TabOrder = 0
          OnClick = BAddClick
        end
        object BDelete: TButton
          Left = 8
          Top = 29
          Width = 91
          Height = 22
          Caption = '&Delete'
          TabOrder = 1
          OnClick = BDeleteClick
        end
        object BUp: TButton
          Left = 8
          Top = 87
          Width = 91
          Height = 22
          Caption = 'Move &Up'
          TabOrder = 3
          OnClick = BUpClick
        end
        object BDown: TButton
          Left = 8
          Top = 116
          Width = 91
          Height = 22
          Caption = 'Move Dow&n'
          TabOrder = 4
          OnClick = BDownClick
        end
        object BRestore: TButton
          Left = 8
          Top = 145
          Width = 91
          Height = 22
          Caption = 'Rest&ore Defaults'
          TabOrder = 5
          OnClick = BRestoreClick
        end
        object BChange: TButton
          Left = 8
          Top = 58
          Width = 91
          Height = 22
          Caption = '&Change type...'
          TabOrder = 2
          OnClick = BChangeClick
        end
        object BRestoreWidths: TButton
          Left = 8
          Top = 174
          Width = 91
          Height = 22
          Caption = 'Restore &Widths'
          TabOrder = 6
          OnClick = BRestoreWidthsClick
        end
      end
      object CListBox: TListBox
        Left = 6
        Top = 6
        Width = 235
        Height = 193
        Align = alClient
        DragMode = dmAutomatic
        ItemHeight = 13
        MultiSelect = True
        PopupMenu = pmColumns
        TabOrder = 4
        OnClick = CListBoxClick
        OnDragDrop = CListBoxDragDrop
        OnDragOver = CListBoxDragOver
        OnEndDrag = CListBoxEndDrag
        OnKeyDown = CListBoxKeyDown
        OnStartDrag = CListBoxStartDrag
      end
    end
  end
  object pmColumns: TPopupMenu
    Left = 228
    Top = 6
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
    object miChangetype: TMenuItem
      Caption = '&Change type...'
      OnClick = BChangeClick
    end
    object miUp: TMenuItem
      Caption = 'Move &Up'
      OnClick = BUpClick
    end
    object miDown: TMenuItem
      Caption = 'Move Dow&n'
      OnClick = BDownClick
    end
    object miRestore: TMenuItem
      Caption = 'Rest&ore Defaults'
      OnClick = BRestoreClick
    end
    object miRestoreDefaultWidths: TMenuItem
      Caption = 'Restore &Widths'
      OnClick = BRestoreWidthsClick
    end
    object miSelectAll: TMenuItem
      Caption = '&Select All'
      OnClick = miSelectAllClick
    end
  end
  object pmBands: TPopupMenu
    Left = 194
    Top = 6
    object miAddBand: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BAddBandClick
    end
    object miDeleteBand: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDeleteBandClick
    end
    object miUpBand: TMenuItem
      Caption = 'Move &Up'
      OnClick = BUpBandClick
    end
    object miDownBand: TMenuItem
      Caption = 'Move Dow&n'
      OnClick = BDownBandClick
    end
    object miRestoreBands: TMenuItem
      Caption = 'Rest&ore Defaults'
      OnClick = BRestoreDefaultClick
    end
    object miAllBands: TMenuItem
      Caption = '&Select All'
      OnClick = miAllBandsClick
    end
  end
end
