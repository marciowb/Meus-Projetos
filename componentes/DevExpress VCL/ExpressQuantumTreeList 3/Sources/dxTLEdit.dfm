object FdxTreeListEdit: TFdxTreeListEdit
  Left = 235
  Top = 106
  Width = 500
  Height = 354
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = '0'
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 291
    Width = 492
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object BColumnCustomizing: TButton
      Left = 6
      Top = 8
      Width = 85
      Height = 22
      Caption = 'C&ustomize'
      TabOrder = 0
      OnClick = BColumnCustomizingClick
    end
    object Panel3: TPanel
      Left = 185
      Top = 0
      Width = 307
      Height = 36
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object BHelp: TButton
        Left = 211
        Top = 8
        Width = 90
        Height = 22
        Caption = '&Help'
        TabOrder = 2
      end
      object BCancel: TButton
        Left = 116
        Top = 8
        Width = 90
        Height = 22
        Caption = '&Cancel'
        ModalResult = 2
        TabOrder = 1
      end
      object BOk: TButton
        Left = 21
        Top = 8
        Width = 90
        Height = 22
        Caption = '&OK'
        ModalResult = 1
        TabOrder = 0
        OnClick = TreeListEnter
      end
    end
  end
  object TreeList: TdxTreeList
    Left = 6
    Top = 8
    Width = 382
    Height = 283
    Bands = <
      item
      end>
    DefaultLayout = True
    HeaderPanelRowCount = 1
    Align = alClient
    DragMode = dmAutomatic
    PopupMenu = PopupMenu
    TabOrder = 1
    HideSelection = False
    Options = [aoColumnSizing, aoColumnMoving, aoEditing, aoMultiSelect, aoImmediateEditor, aoExtMultiSelect]
    OnDragDrop = TreeListDragDrop
    OnDragOver = TreeListDragOver
    OnEnter = TreeListEnter
    OnChangeNode = TreeListChangeNode
  end
  object Panel2: TPanel
    Left = 388
    Top = 8
    Width = 104
    Height = 283
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 2
    object btNewItem: TButton
      Left = 8
      Top = 0
      Width = 90
      Height = 22
      Caption = '&New Item'
      TabOrder = 0
      OnClick = btNewItemClick
    end
    object btNewSubItem: TButton
      Left = 8
      Top = 28
      Width = 90
      Height = 22
      Caption = 'New &SubItem'
      TabOrder = 1
      OnClick = btNewSubItemClick
    end
    object btDeleteItem: TButton
      Left = 8
      Top = 56
      Width = 90
      Height = 22
      Caption = '&Delete'
      TabOrder = 2
      OnClick = btDeleteItemClick
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 84
      Width = 90
      Height = 92
      Caption = 'Image Indexes'
      TabOrder = 3
      object LImage: TLabel
        Left = 7
        Top = 21
        Width = 29
        Height = 13
        Caption = 'Image'
      end
      object LSelected: TLabel
        Left = 7
        Top = 44
        Width = 42
        Height = 13
        Caption = 'Selected'
      end
      object LState: TLabel
        Left = 7
        Top = 67
        Width = 25
        Height = 13
        Caption = 'State'
      end
      object edImageIndex: TEdit
        Left = 53
        Top = 17
        Width = 29
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object edSelectedIndex: TEdit
        Left = 53
        Top = 40
        Width = 29
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object edStateIndex: TEdit
        Left = 53
        Top = 63
        Width = 29
        Height = 21
        TabOrder = 2
        Text = '-1'
      end
    end
    object GroupBox2: TGroupBox
      Left = 8
      Top = 183
      Width = 90
      Height = 92
      Caption = 'Default Indexes'
      TabOrder = 4
      object Label1: TLabel
        Left = 7
        Top = 21
        Width = 29
        Height = 13
        Caption = 'Image'
      end
      object Label2: TLabel
        Left = 7
        Top = 44
        Width = 42
        Height = 13
        Caption = 'Selected'
      end
      object Label3: TLabel
        Left = 7
        Top = 67
        Width = 25
        Height = 13
        Caption = 'State'
      end
      object edDefImage: TEdit
        Left = 53
        Top = 17
        Width = 29
        Height = 21
        TabOrder = 0
        Text = '0'
      end
      object edDefSelected: TEdit
        Left = 53
        Top = 40
        Width = 29
        Height = 21
        TabOrder = 1
        Text = '0'
      end
      object edDefState: TEdit
        Left = 53
        Top = 63
        Width = 29
        Height = 21
        TabOrder = 2
        Text = '-1'
      end
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 492
    Height = 8
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
  end
  object Panel5: TPanel
    Left = 0
    Top = 8
    Width = 6
    Height = 283
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
  end
  object PopupMenu: TPopupMenu
    Left = 144
    Top = 74
    object miNew: TMenuItem
      Caption = '&New Item'
      OnClick = btNewItemClick
    end
    object miNewSubItem: TMenuItem
      Caption = 'New &SubItem'
      OnClick = btNewSubItemClick
    end
    object miDelete: TMenuItem
      Caption = '&Delete'
      OnClick = btDeleteItemClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miColumns: TMenuItem
      Caption = '&Customize'
      OnClick = BColumnCustomizingClick
    end
  end
end
