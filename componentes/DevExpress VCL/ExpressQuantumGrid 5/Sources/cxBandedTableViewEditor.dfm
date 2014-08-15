inherited cxBandedTableViewEditor: TcxBandedTableViewEditor
  Left = 477
  Caption = 'cxBandedTableViewEditor'
  PixelsPerInch = 96
  TextHeight = 13
  inherited PViewEditor: TPanel
    inherited PageControl1: TPageControl
      ActivePage = TSBands
      object TSBands: TTabSheet [0]
        Caption = '   Bands   '
        object LBBands: TListBox
          Left = 0
          Top = 0
          Width = 204
          Height = 285
          Style = lbOwnerDrawFixed
          Align = alClient
          DragMode = dmAutomatic
          ItemHeight = 16
          MultiSelect = True
          PopupMenu = PMBands
          TabOrder = 0
          OnClick = LBBandsClick
          OnDragDrop = LBBandsDragDrop
          OnDragOver = LBBandsDragOver
          OnDrawItem = LBBandsDrawItem
          OnEndDrag = LBBandsEndDrag
          OnKeyPress = FormKeyPress
          OnStartDrag = LBBandsStartDrag
        end
        object Panel22: TPanel
          Left = 204
          Top = 0
          Width = 131
          Height = 285
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 1
          object BAddBand: TButton
            Left = 12
            Top = 10
            Width = 110
            Height = 24
            Caption = '&Add'
            TabOrder = 0
            OnClick = BAddBandClick
          end
          object BDeleteBand: TButton
            Left = 12
            Top = 39
            Width = 110
            Height = 24
            Caption = 'Delete'
            TabOrder = 1
            OnClick = BDeleteBandClick
          end
          object BBandMoveDown: TButton
            Left = 12
            Top = 107
            Width = 110
            Height = 24
            Caption = 'Move &Down'
            TabOrder = 2
            OnClick = BBandMoveDownClick
          end
          object BBandMoveUp: TButton
            Left = 12
            Top = 78
            Width = 110
            Height = 24
            Caption = 'Move &Up'
            TabOrder = 3
            OnClick = BBandMoveUpClick
          end
        end
      end
      inherited TSItems: TTabSheet
        inherited LBColumns: TListBox
          OnDrawItem = LBColumnsDrawItem
        end
      end
    end
  end
  object PMBands: TPopupMenu
    Left = 230
    Top = 90
    object MIBandsAdd: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BAddBandClick
    end
    object MIBandsDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDeleteBandClick
    end
    object MenuItem4: TMenuItem
      Caption = '-'
    end
    object MIBandsMoveUp: TMenuItem
      Caption = 'Move Up'
      ShortCut = 16422
      OnClick = BBandMoveUpClick
    end
    object MIBandsMoveDown: TMenuItem
      Caption = 'Move Down'
      ShortCut = 16424
      OnClick = BBandMoveDownClick
    end
    object MenuItem7: TMenuItem
      Caption = '-'
    end
    object MIBandsSelectAll: TMenuItem
      Caption = '&Select All'
      ShortCut = 16449
      OnClick = MIBandsSelectAllClick
    end
  end
end
