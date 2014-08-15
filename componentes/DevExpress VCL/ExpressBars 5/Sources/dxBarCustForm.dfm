object dxBarCustomizingForm: TdxBarCustomizingForm
  Left = 326
  Top = 151
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Customize'
  ClientHeight = 310
  ClientWidth = 366
  Color = clBtnFace
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 274
    Width = 366
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object BClose: TButton
      Left = 285
      Top = 8
      Width = 75
      Height = 23
      Cancel = True
      Caption = 'Close'
      Default = True
      ModalResult = 1
      TabOrder = 1
      OnClick = BCloseClick
    end
    object BHelp: TBitBtn
      Left = 6
      Top = 8
      Width = 24
      Height = 23
      TabOrder = 0
      OnClick = BHelpClick
      Style = bsNew
    end
  end
  object PageControl: TPageControl
    Left = 6
    Top = 8
    Width = 354
    Height = 266
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    OnChange = PageControlChange
    object TabSheet1: TTabSheet
      Caption = ' Toolbars '
      object LabelToobars: TLabel
        Left = 4
        Top = 4
        Width = 44
        Height = 13
        Caption = 'Toolb&ars:'
      end
      object BBarDelete: TButton
        Left = 239
        Top = 79
        Width = 104
        Height = 22
        Caption = '&Delete'
        TabOrder = 3
        OnClick = BBarDeleteClick
      end
      object BBarNew: TButton
        Left = 239
        Top = 21
        Width = 104
        Height = 22
        Caption = '&New...'
        TabOrder = 1
        OnClick = BBarNewClick
      end
      object BBarRename: TButton
        Left = 239
        Top = 50
        Width = 104
        Height = 22
        Caption = 'R&ename...'
        TabOrder = 2
        OnClick = BBarRenameClick
      end
      object BarsListBoxPlace: TListBox
        Left = 4
        Top = 20
        Width = 227
        Height = 213
        ItemHeight = 13
        TabOrder = 0
      end
      object BBarReset: TButton
        Left = 239
        Top = 108
        Width = 104
        Height = 22
        Caption = '&Reset...'
        TabOrder = 4
        OnClick = BBarResetClick
      end
    end
    object TabSheet2: TTabSheet
      Caption = ' Commands '
      object Panel6: TPanel
        Left = 0
        Top = 0
        Width = 346
        Height = 25
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object LabelCategories: TLabel
          Left = 6
          Top = 8
          Width = 53
          Height = 13
          Caption = 'Cate&gories:'
          FocusControl = LCategories
        end
        object LabelCommands: TLabel
          Left = 148
          Top = 8
          Width = 55
          Height = 13
          Caption = 'Comman&ds:'
        end
        object CategoriesPopupButtonPlace: TSpeedButton
          Left = 65
          Top = 6
          Width = 75
          Height = 17
        end
        object CommandsPopupButtonPlace: TSpeedButton
          Left = 207
          Top = 6
          Width = 134
          Height = 17
        end
      end
      object Panel7: TPanel
        Left = 5
        Top = 25
        Width = 336
        Height = 213
        Align = alClient
        BevelOuter = bvNone
        Caption = 'Panel7'
        TabOrder = 1
        object LCategories: TListBox
          Left = 0
          Top = 0
          Width = 135
          Height = 147
          Align = alLeft
          ItemHeight = 13
          TabOrder = 0
          OnClick = LCategoriesClick
          OnDragOver = LCategoriesDragOver
          OnEndDrag = LCategoriesEndDrag
          OnKeyDown = LCategoriesKeyDown
          OnMouseDown = LCategoriesMouseDown
        end
        object LCommandsPlace: TListBox
          Left = 142
          Top = 0
          Width = 194
          Height = 147
          Style = lbOwnerDrawVariable
          Align = alRight
          Color = clBtnFace
          DragMode = dmAutomatic
          ItemHeight = 22
          TabOrder = 1
          OnClick = LCommandsClick
        end
        object Panel9: TPanel
          Left = 0
          Top = 147
          Width = 336
          Height = 66
          Align = alBottom
          BevelOuter = bvNone
          TabOrder = 2
          object DescriptionLabel: TLabel
            Left = 0
            Top = 20
            Width = 335
            Height = 40
            AutoSize = False
            WordWrap = True
          end
          object Bevel1: TBevel
            Left = 0
            Top = 10
            Width = 337
            Height = 5
            Shape = bsTopLine
          end
          object LabelDescription: TLabel
            Left = 0
            Top = 4
            Width = 59
            Height = 13
            Caption = 'Description  '
          end
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 25
        Width = 5
        Height = 213
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 2
      end
      object Panel8: TPanel
        Left = 341
        Top = 25
        Width = 5
        Height = 213
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 3
      end
    end
    object TabSheet3: TTabSheet
      Caption = ' Options '
      object StandardOptionsPanel: TPanel
        Left = 0
        Top = 0
        Width = 346
        Height = 238
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object LabelMenuAnimations: TLabel
          Left = 24
          Top = 152
          Width = 83
          Height = 13
          Caption = '&Menu animations:'
          FocusControl = ComboBoxMenuAnimations
        end
        object ComboBoxMenuAnimations: TComboBox
          Left = 134
          Top = 148
          Width = 93
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 3
          OnClick = ComboBoxMenuAnimationsClick
          Items.Strings = (
            '(None)'
            'Random'
            'Unfold'
            'Slide')
        end
        object CBHint1: TCheckBox
          Left = 24
          Top = 63
          Width = 301
          Height = 17
          Caption = 'Show Tool&Tips on toolbars'
          TabOrder = 1
          OnClick = CBHint1Click
        end
        object CBHint2: TCheckBox
          Left = 24
          Top = 85
          Width = 301
          Height = 17
          Caption = 'Show s&hortcut keys in ToolTips'
          TabOrder = 2
          OnClick = CBHint2Click
        end
        object CBLargeIcons: TCheckBox
          Left = 24
          Top = 38
          Width = 301
          Height = 17
          Caption = '&Large icons'
          TabOrder = 0
          OnClick = CBLargeIconsClick
        end
      end
      object EnhancedOptionsPanel: TPanel
        Left = 0
        Top = 0
        Width = 346
        Height = 238
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 20
          Top = 200
          Width = 83
          Height = 13
          Caption = '&Menu animations:'
          FocusControl = ComboBoxMenuAnimationsEx
        end
        object Bevel2: TBevel
          Left = 12
          Top = 122
          Width = 317
          Height = 9
          Shape = bsTopLine
        end
        object Label2: TLabel
          Left = 12
          Top = 116
          Width = 32
          Height = 13
          Caption = 'Other  '
        end
        object Bevel3: TBevel
          Left = 12
          Top = 18
          Width = 317
          Height = 7
          Shape = bsTopLine
        end
        object Label3: TLabel
          Left = 12
          Top = 12
          Width = 166
          Height = 13
          Caption = 'Personalized Menus and Toolbars  '
        end
        object ComboBoxMenuAnimationsEx: TComboBox
          Left = 132
          Top = 196
          Width = 93
          Height = 21
          Style = csDropDownList
          ItemHeight = 13
          TabOrder = 6
          OnClick = ComboBoxMenuAnimationsClick
          Items.Strings = (
            '(None)'
            'Random'
            'Unfold'
            'Slide')
        end
        object CBHint1Ex: TCheckBox
          Left = 20
          Top = 152
          Width = 309
          Height = 17
          Caption = 'Show Tool&Tips on toolbars'
          TabOrder = 4
          OnClick = CBHint1ExClick
        end
        object CBHint2Ex: TCheckBox
          Left = 36
          Top = 172
          Width = 293
          Height = 17
          Caption = 'Show s&hortcut keys in ToolTips'
          TabOrder = 5
          OnClick = CBHint2Click
        end
        object CBLargeIconsEx: TCheckBox
          Left = 20
          Top = 132
          Width = 309
          Height = 17
          Caption = '&Large icons'
          TabOrder = 3
          OnClick = CBLargeIconsClick
        end
        object CBMenusShowRecentItemsFirst: TCheckBox
          Left = 20
          Top = 32
          Width = 309
          Height = 17
          Caption = 'Me&nus show recently used commands first'
          TabOrder = 0
          OnClick = CBMenusShowRecentItemsFirstClick
        end
        object CBShowFullMenusAfterDelay: TCheckBox
          Left = 36
          Top = 52
          Width = 293
          Height = 17
          Caption = 'Show f&ull menus after a short delay'
          TabOrder = 1
          OnClick = CBShowFullMenusAfterDelayClick
        end
        object BResetUsageData: TButton
          Left = 20
          Top = 76
          Width = 119
          Height = 22
          Caption = '&Reset my usage data'
          TabOrder = 2
          OnClick = BResetUsageDataClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = ' All commands '
      object LAllCommands: TListBox
        Left = 6
        Top = 8
        Width = 333
        Height = 200
        Style = lbOwnerDrawFixed
        ItemHeight = 16
        TabOrder = 0
        OnClick = LAllCommandsClick
        OnDrawItem = LAllCommandsDrawItem
      end
      object CBShowCommandsWithShortCut: TCheckBox
        Left = 6
        Top = 216
        Width = 333
        Height = 17
        Caption = 'Show commands that may have a shortcut'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CBShowCommandsWithShortCutClick
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Groups'
      object btnMoveUp: TSpeedButton
        Left = 147
        Top = 76
        Width = 29
        Height = 25
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888888888888888888888888800000888888888880666088
          8888888880666088888888888066608888888800006660000888888066666660
          8888888806666608888888888066608888888888880608888888888888808888
          8888888888888888888888888888888888888888888888888888}
        OnClick = btnMoveUpClick
      end
      object btnMoveDown: TSpeedButton
        Left = 147
        Top = 108
        Width = 29
        Height = 25
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          0400000000008000000000000000000000001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
          8888888888888888888888888888888888888888888088888888888888060888
          8888888880666088888888880666660888888880666666608888880000666000
          0888888880666088888888888066608888888888806660888888888880000088
          8888888888888888888888888888888888888888888888888888}
        OnClick = btnMoveDownClick
      end
      object GroupBox1: TGroupBox
        Left = 4
        Top = 4
        Width = 140
        Height = 229
        Caption = ' Groups '
        TabOrder = 0
        object lbGroups: TListBox
          Left = 7
          Top = 16
          Width = 125
          Height = 177
          Style = lbOwnerDrawVariable
          ItemHeight = 13
          TabOrder = 0
          OnClick = lbGroupsClick
          OnDrawItem = lbGroupsDrawItem
          OnEnter = lbGroupsEnter
          OnKeyDown = lbGroupsKeyDown
          OnMeasureItem = lbGroupsMeasureItem
        end
        object btnGroupAdd: TButton
          Left = 7
          Top = 199
          Width = 61
          Height = 23
          Caption = 'Add'
          TabOrder = 1
          OnClick = btnGroupAddClick
        end
        object btnGroupDelete: TButton
          Left = 71
          Top = 199
          Width = 61
          Height = 23
          Caption = 'Delete'
          TabOrder = 2
          OnClick = btnGroupDeleteClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 179
        Top = 4
        Width = 162
        Height = 229
        Caption = ' Items '
        TabOrder = 1
        object lbGroupItems: TListBox
          Left = 8
          Top = 16
          Width = 146
          Height = 177
          Style = lbOwnerDrawVariable
          ItemHeight = 13
          MultiSelect = True
          TabOrder = 0
          OnClick = lbGroupItemsClick
          OnDrawItem = lbGroupItemsDrawItem
          OnEnter = lbGroupItemsEnter
          OnKeyDown = lbGroupItemsKeyDown
          OnMeasureItem = lbGroupsMeasureItem
        end
        object btnGroupItemAdd: TButton
          Left = 20
          Top = 199
          Width = 61
          Height = 23
          Caption = '&Add...'
          TabOrder = 1
          OnClick = btnGroupItemAddClick
        end
        object btnGroupItemDelete: TButton
          Left = 85
          Top = 199
          Width = 57
          Height = 23
          Caption = 'Delete'
          TabOrder = 2
          OnClick = btnGroupItemDeleteClick
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 8
    Width = 6
    Height = 266
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 2
  end
  object Panel3: TPanel
    Left = 360
    Top = 8
    Width = 6
    Height = 266
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 366
    Height = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 4
  end
  object BarManager1: TdxBarManager
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Bars = <>
    Categories.Strings = (
      'Categories'
      'Commands')
    Categories.ItemsVisibles = (
      2
      2)
    Categories.Visibles = (
      True
      True)
    PopupMenuLinks = <>
    StretchGlyphs = False
    UseSystemFont = False
    Left = 170
    Top = 278
    DockControlHeights = (
      0
      0
      0
      0)
    object CategoriesAdd: TdxBarButton
      Caption = 'Add...'
      Category = 0
      Hint = 'Add'
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888888888888888888800000000000888880FFFFFFFFF0888880FFFFFFFFF
        0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF
        0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFF0000888880FFFFFF0F0
        8888880FFFFFF008888888000000008888888888888888888888}
      OnClick = CategoriesAddClick
    end
    object CategoriesInsert: TdxBarButton
      Caption = 'Insert...'
      Category = 0
      Hint = 'Insert'
      Visible = ivAlways
      ShortCut = 45
      OnClick = CategoriesInsertClick
    end
    object CategoriesRename: TdxBarButton
      Caption = 'Rename...'
      Category = 0
      Hint = 'Rename'
      Visible = ivAlways
      OnClick = CategoriesRenameClick
    end
    object CategoriesVisible: TdxBarButton
      Caption = 'Visible'
      Category = 0
      Hint = 'Visible'
      Visible = ivAlways
      ButtonStyle = bsChecked
      OnClick = CategoriesVisibleClick
    end
    object CommandsAdd: TdxBarButton
      Caption = 'Add...'
      Category = 1
      Hint = 'Add'
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888888888888888888800000000000888880FFFFFFFFF0888880FFFFFFFFF
        0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFFFFF
        0888880FFFFFFFFF0888880FFFFFFFFF0888880FFFFFF0000888880FFFFFF0F0
        8888880FFFFFF008888888000000008888888888888888888888}
      ShortCut = 45
      OnClick = CommandsAddClick
    end
    object CommandsDelete: TdxBarButton
      Caption = 'Delete'
      Category = 1
      Hint = 'Delete'
      Visible = ivAlways
      Glyph.Data = {
        EE000000424DEE000000000000007600000028000000100000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888888888888880F88880F8888888888888000F8888880F8888000F888880
        F888888000F88800F8888888000F800F88888888800000F88888888888000F88
        88888888800000F888888888000F80F88888880000F88800F88880000F888880
        0F88800F8888888800F88888888888888888}
      ShortCut = 46
      OnClick = CommandsDeleteClick
    end
    object CommandsClear: TdxBarButton
      Caption = 'Clear'
      Category = 1
      Hint = 'Clear'
      Visible = ivAlways
      OnClick = CommandsClearClick
    end
    object CommandsMoveUp: TdxBarButton
      Caption = 'Move Up'
      Category = 1
      Hint = 'Move Up'
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888888888888888888888888888888888800000888888888880666088
        8888888880666088888888888066608888888800006660000888888066666660
        8888888806666608888888888066608888888888880608888888888888808888
        8888888888888888888888888888888888888888888888888888}
      ShortCut = 16422
      OnClick = CommandsMoveUpClick
    end
    object CommandsMoveDown: TdxBarButton
      Caption = 'Move Down'
      Category = 1
      Hint = 'Move Down'
      Visible = ivAlways
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        0400000000008000000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8888888888888888888888888888888888888888888088888888888888060888
        8888888880666088888888880666660888888880666666608888880000666000
        0888888880666088888888888066608888888888806660888888888880000088
        8888888888888888888888888888888888888888888888888888}
      ShortCut = 16424
      OnClick = CommandsMoveDownClick
    end
    object CommandsSubMenuEditor: TdxBarButton
      Caption = 'SubMenu Editor...'
      Category = 1
      Hint = 'SubMenu Editor'
      Visible = ivAlways
      OnClick = CommandsSubMenuEditorClick
    end
    object CategoriesItemsVisible: TdxBarCombo
      Caption = 'Items Visible:'
      Category = 0
      Hint = 'Items Visible:'
      Visible = ivAlways
      OnChange = CategoriesItemsVisibleChange
      Width = 100
      ShowEditor = False
      Items.Strings = (
        'Never'
        'InCustomizing'
        'Always')
      ItemIndex = -1
    end
    object CategoriesDelete: TdxBarButton
      Caption = 'Delete'
      Category = 0
      Hint = 'Delete'
      Visible = ivAlways
      Glyph.Data = {
        EE000000424DEE000000000000007600000028000000100000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        888888888888888880F88880F8888888888888000F8888880F8888000F888880
        F888888000F88800F8888888000F800F88888888800000F88888888888000F88
        88888888800000F888888888000F80F88888880000F88800F88880000F888880
        0F88800F8888888800F88888888888888888}
      ShortCut = 46
      OnClick = CategoriesDeleteClick
    end
  end
  object CategoriesPopupMenu: TdxBarPopupMenu
    BarManager = BarManager1
    ItemLinks = <
      item
        Item = CategoriesAdd
        Visible = True
      end
      item
        Item = CategoriesInsert
        Visible = True
      end
      item
        Item = CategoriesRename
        Visible = True
      end
      item
        BeginGroup = True
        Item = CategoriesVisible
        Visible = True
      end
      item
        Item = CategoriesItemsVisible
        Visible = True
      end
      item
        BeginGroup = True
        Item = CategoriesDelete
        Visible = True
      end>
    UseOwnFont = False
    OnPopup = CategoriesPopupMenuPopup
    Left = 204
    Top = 278
  end
  object CommandsPopupMenu: TdxBarPopupMenu
    BarManager = BarManager1
    ItemLinks = <
      item
        Item = CommandsAdd
        Visible = True
      end
      item
        Item = CommandsDelete
        Visible = True
      end
      item
        Item = CommandsClear
        Visible = True
      end
      item
        BeginGroup = True
        Item = CommandsMoveUp
        Visible = True
      end
      item
        Item = CommandsMoveDown
        Visible = True
      end
      item
        BeginGroup = True
        Item = CommandsSubMenuEditor
        Visible = True
      end>
    UseOwnFont = False
    OnPopup = CommandsPopupMenuPopup
    Left = 236
    Top = 278
  end
end
