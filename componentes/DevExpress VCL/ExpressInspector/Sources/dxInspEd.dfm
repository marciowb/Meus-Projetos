object dxInspectorEditForm: TdxInspectorEditForm
  Left = 405
  Top = 106
  Width = 331
  Height = 283
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = '0'
  Color = clBtnFace
  OldCreateOrder = True
  PopupMenu = PopupMenu
  Position = poScreenCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object pnButtons: TPanel
    Left = 221
    Top = 0
    Width = 102
    Height = 256
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object BAdd: TButton
      Left = 7
      Top = 7
      Width = 90
      Height = 23
      Caption = '&Add...'
      TabOrder = 0
      OnClick = BAddClick
    end
    object BDelete: TButton
      Left = 7
      Top = 39
      Width = 90
      Height = 23
      Caption = '&Delete'
      TabOrder = 1
      OnClick = BDeleteClick
    end
    object BRestore: TButton
      Left = 7
      Top = 103
      Width = 90
      Height = 23
      Caption = 'Rest&ore Defaults'
      TabOrder = 3
      OnClick = BRestoreClick
    end
    object BChange: TButton
      Left = 7
      Top = 71
      Width = 90
      Height = 23
      Caption = '&Change type...'
      TabOrder = 2
      OnClick = BChangeClick
    end
    object cbDragDrop: TCheckBox
      Left = 7
      Top = 136
      Width = 90
      Height = 17
      Caption = 'Drag&&Drop'
      Checked = True
      State = cbChecked
      TabOrder = 4
      OnClick = cbDragDropClick
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 221
    Height = 256
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 0
      Top = 166
      Width = 221
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object dxInspector: TdxInspector
      Left = 0
      Top = 0
      Width = 221
      Height = 166
      Align = alClient
      DragMode = dmAutomatic
      TabOrder = 0
      OnClick = dxInspectorClick
      OnDragDrop = dxInspectorDragDrop
      OnDragOver = dxInspectorDragOver
      OnEnter = dxInspectorEnter
      DividerPos = 108
      OnChangeNode = dxInspectorChangeNode
    end
    object Panel2: TPanel
      Left = 0
      Top = 169
      Width = 221
      Height = 87
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      object LHidden: TListBox
        Left = 0
        Top = 23
        Width = 221
        Height = 64
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = dxInspectorClick
        OnEnter = LHiddenEnter
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 221
        Height = 23
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label1: TLabel
          Left = 6
          Top = 6
          Width = 71
          Height = 13
          Caption = 'Invisible Rows:'
        end
        object Bevel: TBevel
          Left = 0
          Top = 0
          Width = 221
          Height = 7
          Align = alTop
          Shape = bsTopLine
        end
      end
    end
  end
  object PopupMenu: TPopupMenu
    Left = 48
    Top = 34
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
    object miRestoreDefaults: TMenuItem
      Caption = 'Rest&ore Defaults'
      OnClick = BRestoreClick
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miShowButtons: TMenuItem
      Caption = 'Show &Buttons'
      Checked = True
      OnClick = miShowButtonsClick
    end
  end
end
