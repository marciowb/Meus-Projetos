inherited cxCustomTableViewEditor: TcxCustomTableViewEditor
  Left = 556
  Top = 316
  ActiveControl = PageControl1
  Caption = 'cxCustomTableViewEditor'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited PViewEditor: TPanel
    object PageControl1: TPageControl
      Left = 0
      Top = 0
      Width = 343
      Height = 313
      ActivePage = TSItems
      Align = alClient
      TabOrder = 0
      object TSItems: TTabSheet
        object Panel1: TPanel
          Left = 204
          Top = 0
          Width = 131
          Height = 285
          Align = alRight
          BevelOuter = bvNone
          TabOrder = 0
          object BColumnAdd: TButton
            Left = 12
            Top = 10
            Width = 110
            Height = 24
            Caption = '&Add'
            TabOrder = 0
            OnClick = BColumnAddClick
          end
          object BColumnAddEx: TButton
            Left = 12
            Top = 39
            Width = 90
            Height = 24
            Caption = 'Add...'
            TabOrder = 1
            Visible = False
            OnClick = BColumnAddExClick
          end
          object BColumnDelete: TButton
            Left = 12
            Top = 39
            Width = 110
            Height = 24
            Caption = 'Delete'
            TabOrder = 2
            OnClick = BColumnDeleteClick
          end
          object BColumnAddAll: TButton
            Left = 12
            Top = 179
            Width = 110
            Height = 24
            Caption = 'Retrieve &Fields'
            TabOrder = 6
            Visible = False
            OnClick = BColumnAddAllClick
          end
          object BColumnRestore: TButton
            Left = 12
            Top = 70
            Width = 110
            Height = 24
            Caption = '&Restore Defaults'
            TabOrder = 3
            OnClick = BColumnRestoreClick
          end
          object BColumnMoveUp: TButton
            Left = 12
            Top = 109
            Width = 110
            Height = 24
            Caption = 'Move &Up'
            TabOrder = 4
            OnClick = BColumnMoveUpClick
          end
          object BColumnMoveDown: TButton
            Left = 12
            Top = 140
            Width = 110
            Height = 24
            Caption = 'Move &Down'
            TabOrder = 5
            OnClick = BColumnMoveDownClick
          end
        end
        object LBColumns: TListBox
          Left = 0
          Top = 0
          Width = 204
          Height = 285
          Style = lbOwnerDrawFixed
          Align = alClient
          DragMode = dmAutomatic
          ItemHeight = 13
          MultiSelect = True
          PopupMenu = PMColumns
          TabOrder = 1
          OnClick = LBColumnsClick
          OnDragDrop = LBColumnsDragDrop
          OnDragOver = LBColumnsDragOver
          OnDrawItem = LBColumnsDrawItem
          OnEndDrag = LBColumnsEndDrag
          OnKeyPress = FormKeyPress
          OnMouseDown = LBColumnsMouseDown
          OnStartDrag = LBColumnsStartDrag
        end
      end
      object TSSummary: TTabSheet
        Caption = '   Summary   '
        ImageIndex = 1
        object PageControl2: TPageControl
          Left = 0
          Top = 0
          Width = 335
          Height = 285
          ActivePage = TSFooterSummaryItems
          Align = alClient
          TabOrder = 0
          object TSFooterSummaryItems: TTabSheet
            Caption = '   Footer   '
            object Panel2: TPanel
              Left = 0
              Top = 0
              Width = 185
              Height = 257
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object Panel3: TPanel
                Left = 0
                Top = 222
                Width = 185
                Height = 35
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 0
                object BAddFooterSummaryItem: TButton
                  Left = 5
                  Top = 6
                  Width = 75
                  Height = 24
                  Caption = '&Add'
                  TabOrder = 0
                  OnClick = BAddFooterSummaryItemClick
                end
                object BDeleteFooterSummaryItem: TButton
                  Left = 97
                  Top = 6
                  Width = 75
                  Height = 24
                  Caption = '&Delete'
                  TabOrder = 1
                  OnClick = BDeleteFooterSummaryItemClick
                end
              end
              object LBFooterSummary: TListBox
                Left = 0
                Top = 20
                Width = 185
                Height = 202
                Align = alClient
                ItemHeight = 13
                MultiSelect = True
                PopupMenu = PMFooterSummary
                TabOrder = 1
                OnClick = LBFooterSummaryClick
                OnKeyPress = FormKeyPress
              end
              object Panel4: TPanel
                Left = 0
                Top = 0
                Width = 185
                Height = 20
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 2
                object Label1: TLabel
                  Left = 4
                  Top = 4
                  Width = 28
                  Height = 13
                  Caption = 'Items:'
                end
              end
            end
          end
          object TSDefaultGroupSummaryItems: TTabSheet
            Caption = '   Default For Groups   '
            ImageIndex = 1
            object Panel5: TPanel
              Left = 0
              Top = 0
              Width = 185
              Height = 257
              Align = alLeft
              BevelOuter = bvNone
              TabOrder = 0
              object Panel6: TPanel
                Left = 0
                Top = 222
                Width = 185
                Height = 35
                Align = alBottom
                BevelOuter = bvNone
                TabOrder = 0
                object BDefaultGroupSummaryAdd: TButton
                  Left = 5
                  Top = 6
                  Width = 75
                  Height = 24
                  Caption = '&Add'
                  TabOrder = 0
                  OnClick = BDefaultGroupSummaryAddClick
                end
                object BDefaultGroupSummaryDelete: TButton
                  Left = 97
                  Top = 6
                  Width = 75
                  Height = 24
                  Caption = '&Delete'
                  TabOrder = 1
                  OnClick = BDefaultGroupSummaryDeleteClick
                end
              end
              object LBDefaultGroupsSummary: TListBox
                Left = 0
                Top = 20
                Width = 185
                Height = 202
                Align = alClient
                ItemHeight = 13
                MultiSelect = True
                PopupMenu = PMDefaultGroupsSummary
                TabOrder = 1
                OnClick = LBDefaultGroupsSummaryClick
                OnKeyPress = FormKeyPress
              end
              object Panel7: TPanel
                Left = 0
                Top = 0
                Width = 185
                Height = 20
                Align = alTop
                BevelOuter = bvNone
                TabOrder = 2
                object Label2: TLabel
                  Left = 4
                  Top = 4
                  Width = 28
                  Height = 13
                  Caption = 'Items:'
                end
              end
            end
          end
          object TabSheet3: TTabSheet
            Caption = '   Groups   '
            ImageIndex = 2
            object Splitter2: TSplitter
              Left = 0
              Top = 139
              Width = 327
              Height = 5
              Cursor = crVSplit
              Align = alBottom
              Beveled = True
            end
            object PSummaryGroups: TPanel
              Left = 0
              Top = 0
              Width = 327
              Height = 139
              Align = alClient
              BevelOuter = bvNone
              TabOrder = 0
              OnResize = PSummaryGroupsResize
              object PGroupItems: TPanel
                Left = 165
                Top = 0
                Width = 162
                Height = 139
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 0
                object Panel11: TPanel
                  Left = 0
                  Top = 105
                  Width = 162
                  Height = 34
                  Align = alBottom
                  BevelOuter = bvNone
                  TabOrder = 0
                  object BGroupSummaryItemAdd: TButton
                    Left = 5
                    Top = 6
                    Width = 75
                    Height = 24
                    Caption = '&Add'
                    TabOrder = 0
                    OnClick = BGroupSummaryItemAddClick
                  end
                  object BGroupSummaryItemDelete: TButton
                    Left = 83
                    Top = 6
                    Width = 75
                    Height = 24
                    Caption = '&Delete'
                    TabOrder = 1
                    OnClick = BGroupSummaryItemDeleteClick
                  end
                end
                object LBGroupSummaryItems: TListBox
                  Left = 0
                  Top = 20
                  Width = 162
                  Height = 85
                  Align = alClient
                  ItemHeight = 13
                  MultiSelect = True
                  PopupMenu = PMGroupSummaryItems
                  TabOrder = 1
                  OnClick = LBGroupSummaryItemsClick
                  OnKeyPress = FormKeyPress
                end
                object Panel12: TPanel
                  Left = 0
                  Top = 0
                  Width = 162
                  Height = 20
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 2
                  object Label4: TLabel
                    Left = 4
                    Top = 4
                    Width = 28
                    Height = 13
                    Caption = 'Items:'
                  end
                end
              end
              object PGroups: TPanel
                Left = 0
                Top = 0
                Width = 161
                Height = 139
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 1
                object Panel14: TPanel
                  Left = 0
                  Top = 105
                  Width = 161
                  Height = 34
                  Align = alBottom
                  BevelOuter = bvNone
                  TabOrder = 0
                  object BSummaryGroupAdd: TButton
                    Left = 5
                    Top = 6
                    Width = 75
                    Height = 24
                    Caption = '&Add'
                    TabOrder = 0
                    OnClick = BSummaryGroupAddClick
                  end
                  object BSummaryGroupDelete: TButton
                    Left = 83
                    Top = 6
                    Width = 75
                    Height = 24
                    Caption = '&Delete'
                    TabOrder = 1
                    OnClick = BSummaryGroupDeleteClick
                  end
                end
                object LBSummaryGroups: TListBox
                  Left = 0
                  Top = 20
                  Width = 161
                  Height = 85
                  Align = alClient
                  ItemHeight = 13
                  MultiSelect = True
                  PopupMenu = PMSummaryGroups
                  TabOrder = 1
                  OnClick = LBSummaryGroupsClick
                  OnKeyPress = FormKeyPress
                end
                object Panel15: TPanel
                  Left = 0
                  Top = 0
                  Width = 161
                  Height = 20
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 2
                  object Label5: TLabel
                    Left = 4
                    Top = 4
                    Width = 37
                    Height = 13
                    Caption = 'Groups:'
                  end
                end
              end
              object PGSeparator: TPanel
                Left = 161
                Top = 0
                Width = 4
                Height = 139
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 2
              end
            end
            object PLinks: TPanel
              Left = 0
              Top = 144
              Width = 327
              Height = 113
              Align = alBottom
              BevelOuter = bvNone
              TabOrder = 1
              OnResize = PLinksResize
              object Label3: TLabel
                Left = 4
                Top = 4
                Width = 74
                Height = 13
                Caption = 'Linked columns'
              end
              object PUnlinkedColumns: TPanel
                Left = 0
                Top = 0
                Width = 145
                Height = 113
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 0
                object LBUnlinkedColumns: TListBox
                  Left = 0
                  Top = 20
                  Width = 145
                  Height = 93
                  Align = alClient
                  ItemHeight = 13
                  MultiSelect = True
                  TabOrder = 0
                  OnClick = LBUnlinkedColumnsClick
                  OnKeyPress = FormKeyPress
                end
                object Panel19: TPanel
                  Left = 0
                  Top = 0
                  Width = 145
                  Height = 20
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 1
                  object Label6: TLabel
                    Left = 4
                    Top = 4
                    Width = 88
                    Height = 13
                    Caption = 'Unlinked Columns:'
                  end
                end
              end
              object PLinkUnlink: TPanel
                Left = 145
                Top = 0
                Width = 34
                Height = 113
                Align = alLeft
                BevelOuter = bvNone
                TabOrder = 1
                object BColumnLink: TButton
                  Left = 5
                  Top = 34
                  Width = 25
                  Height = 25
                  Caption = '>'
                  TabOrder = 0
                  OnClick = BColumnLinkClick
                end
                object BColumnUnlink: TButton
                  Left = 5
                  Top = 68
                  Width = 25
                  Height = 25
                  Caption = '<'
                  TabOrder = 1
                  OnClick = BColumnUnlinkClick
                end
              end
              object PLinkedColumns: TPanel
                Left = 179
                Top = 0
                Width = 148
                Height = 113
                Align = alClient
                BevelOuter = bvNone
                TabOrder = 2
                object LBLinkedColumns: TListBox
                  Left = 0
                  Top = 20
                  Width = 148
                  Height = 93
                  Align = alClient
                  ItemHeight = 13
                  MultiSelect = True
                  TabOrder = 0
                  OnClick = LBUnlinkedColumnsClick
                  OnKeyPress = FormKeyPress
                end
                object Panel23: TPanel
                  Left = 0
                  Top = 0
                  Width = 148
                  Height = 20
                  Align = alTop
                  BevelOuter = bvNone
                  TabOrder = 1
                  object Label7: TLabel
                    Left = 4
                    Top = 4
                    Width = 78
                    Height = 13
                    Caption = 'Linked Columns:'
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  object PMColumns: TPopupMenu
    Left = 228
    Top = 6
    object MIColumnAdd: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BColumnAddClick
    end
    object MIColumnDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BColumnDeleteClick
    end
    object MIColumnRestore: TMenuItem
      Caption = 'Rest&ore Defaults'
      OnClick = BColumnRestoreClick
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object MIColumnMoveUp: TMenuItem
      Caption = 'Move Up'
      ShortCut = 16422
      OnClick = BColumnMoveUpClick
    end
    object MIColumnMoveDown: TMenuItem
      Caption = 'Move Down'
      ShortCut = 16424
      OnClick = BColumnMoveDownClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object MIColumnSelectAll: TMenuItem
      Caption = '&Select All'
      ShortCut = 16449
      OnClick = MIColumnSelectAllClick
    end
  end
  object PMFooterSummary: TPopupMenu
    Left = 230
    Top = 90
    object MIFooterSummaryAdd: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BAddFooterSummaryItemClick
    end
    object MIFooterSummaryDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDeleteFooterSummaryItemClick
    end
    object MenuItem4a: TMenuItem
      Caption = '-'
    end
    object MIFooterSummarySelectAll: TMenuItem
      Caption = '&Select All'
      ShortCut = 16449
      OnClick = MIFooterSummarySelectAllClick
    end
  end
  object PMDefaultGroupsSummary: TPopupMenu
    Left = 230
    Top = 130
    object MIDefaultGroupSummaryAdd: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BDefaultGroupSummaryAddClick
    end
    object MIDefaultGroupSummaryDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BDefaultGroupSummaryDeleteClick
    end
    object MenuItem3b: TMenuItem
      Caption = '-'
    end
    object MIDefaultGroupSummarySelectAll: TMenuItem
      Caption = '&Select All'
      ShortCut = 16449
      OnClick = MIDefaultGroupSummarySelectAllClick
    end
  end
  object PMSummaryGroups: TPopupMenu
    Left = 230
    Top = 170
    object MISummaryGroupAdd: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BSummaryGroupAddClick
    end
    object MISummaryGroupDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BSummaryGroupDeleteClick
    end
    object MenuItem5d: TMenuItem
      Caption = '-'
    end
    object MISummaryGroupSelectAll: TMenuItem
      Caption = '&Select All'
      ShortCut = 16449
      OnClick = MISummaryGroupSelectAllClick
    end
  end
  object PMGroupSummaryItems: TPopupMenu
    Left = 230
    Top = 210
    object MIGroupSummaryItemsAdd: TMenuItem
      Caption = '&Add'
      ShortCut = 45
      OnClick = BGroupSummaryItemAddClick
    end
    object MIGroupSummaryItemsDelete: TMenuItem
      Caption = '&Delete'
      ShortCut = 46
      OnClick = BGroupSummaryItemDeleteClick
    end
    object MenuItem6c: TMenuItem
      Caption = '-'
    end
    object MIGroupSummaryItemsSelectAll: TMenuItem
      Caption = '&Select All'
      ShortCut = 16449
      OnClick = MIGroupSummaryItemsSelectAllClick
    end
  end
end
