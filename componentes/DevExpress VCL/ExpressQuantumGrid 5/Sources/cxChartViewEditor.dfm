inherited cxChartViewEditor: TcxChartViewEditor
  Left = 543
  Top = 157
  Caption = 'cxChartViewEditor'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited PViewEditor: TPanel
    object pcMain: TPageControl
      Left = 0
      Top = 0
      Width = 343
      Height = 313
      ActivePage = tshSeries
      Align = alClient
      TabOrder = 0
      object tshSeries: TTabSheet
        Caption = '  Series  '
        object Panel1: TPanel
          Left = 0
          Top = 0
          Width = 335
          Height = 285
          Align = alClient
          BevelOuter = bvNone
          BorderWidth = 5
          TabOrder = 0
          object lbSeries: TListBox
            Left = 5
            Top = 5
            Width = 207
            Height = 275
            Style = lbOwnerDrawFixed
            Align = alClient
            DragMode = dmAutomatic
            ItemHeight = 13
            MultiSelect = True
            PopupMenu = pmSeries
            TabOrder = 0
            OnClick = lbSeriesClick
            OnDragDrop = lbSeriesDragDrop
            OnDragOver = lbSeriesDragOver
            OnDrawItem = lbSeriesDrawItem
            OnEndDrag = lbSeriesEndDrag
            OnKeyPress = FormKeyPress
            OnStartDrag = lbSeriesStartDrag
          end
          object Panel2: TPanel
            Left = 212
            Top = 5
            Width = 118
            Height = 275
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object btnSeriesAdd: TButton
              Left = 8
              Top = 0
              Width = 110
              Height = 24
              Caption = '&Add'
              TabOrder = 0
              OnClick = btnSeriesAddClick
            end
            object btnSeriesDelete: TButton
              Left = 8
              Top = 32
              Width = 110
              Height = 24
              Caption = 'Delete'
              TabOrder = 1
              OnClick = btnSeriesDeleteClick
            end
            object btnSeriesMoveUp: TButton
              Left = 8
              Top = 72
              Width = 110
              Height = 24
              Caption = 'Move &Up'
              TabOrder = 2
              OnClick = btnSeriesMoveUpClick
            end
            object btnSeriesMoveDown: TButton
              Left = 8
              Top = 104
              Width = 110
              Height = 24
              Caption = 'Move &Down'
              TabOrder = 3
              OnClick = btnSeriesMoveDownClick
            end
            object btnSeriesSelectAll: TButton
              Left = 8
              Top = 144
              Width = 110
              Height = 24
              Caption = 'Select All'
              TabOrder = 4
              OnClick = btnSeriesSelectAllClick
            end
          end
        end
      end
    end
  end
  object pmSeries: TPopupMenu
    Left = 140
    Top = 74
    object miSeriesAdd: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = btnSeriesAddClick
    end
    object miSeriesDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = btnSeriesDeleteClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object miSeriesMoveUp: TMenuItem
      Caption = 'Move Up'
      ShortCut = 16422
      OnClick = btnSeriesMoveUpClick
    end
    object miSeriesMoveDown: TMenuItem
      Caption = 'Move Down'
      ShortCut = 16424
      OnClick = btnSeriesMoveDownClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miSeriesSelectAll: TMenuItem
      Caption = '&Select All'
      ShortCut = 16449
      OnClick = btnSeriesSelectAllClick
    end
  end
  object pmSeriesAdd: TPopupMenu
    Left = 140
    Top = 112
  end
end
