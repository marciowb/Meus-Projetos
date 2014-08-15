inherited fmMetaSQLCustomEditor: TfmMetaSQLCustomEditor
  Width = 454
  Height = 315
  OnEnter = FrameEnter
  object atPanel1: TatPanel
    Left = 0
    Top = 27
    Width = 454
    Height = 5
    Align = alTop
    AutoSize = True
    BevelOuter = bvNone
    TabOrder = 0
    OnEnter = atPanel1Enter
    ArrangeMethod = amLabelsJustified
    HorzMargin = 5
    VertMargin = 5
    SortStyle = ssTag
    AutoTabOrder = True
  end
  object Panel1: TatPanel
    Left = 0
    Top = 0
    Width = 454
    Height = 27
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    HorzMargin = 5
    VertMargin = 5
    SortStyle = ssTag
    AutoTabOrder = False
    object btNew: TButton
      Left = 5
      Top = 5
      Width = 75
      Height = 20
      Action = acNew
      TabOrder = 0
      TabStop = False
    end
    object btInsert: TButton
      Tag = 2
      Left = 159
      Top = 5
      Width = 75
      Height = 20
      Action = acInsert
      Caption = '&Save'
      TabOrder = 1
      TabStop = False
    end
    object btCancel: TButton
      Tag = 3
      Left = 236
      Top = 5
      Width = 75
      Height = 20
      Action = acCancel
      Cancel = True
      TabOrder = 2
      TabStop = False
    end
    object btDelete: TButton
      Tag = 1
      Left = 82
      Top = 5
      Width = 75
      Height = 20
      Action = acDelete
      TabOrder = 3
      TabStop = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 32
    Width = 454
    Height = 283
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object lvItems: TListView
      Left = 0
      Top = 0
      Width = 454
      Height = 283
      Align = alClient
      Columns = <
        item
        end
        item
        end>
      HideSelection = False
      PopupMenu = pmList
      TabOrder = 0
      ViewStyle = vsReport
      OnChange = lvItemsChange
      OnKeyDown = lvItemsKeyDown
      OnSelectItem = lvItemsSelectItem
    end
  end
  object ActionList1: TActionList
    Left = 256
    Top = 72
    object acNew: TAction
      Caption = '&New'
      OnExecute = acNewExecute
      OnUpdate = acNewUpdate
    end
    object acInsert: TAction
      Caption = '&Insert'
      OnExecute = acInsertExecute
      OnUpdate = acInsertUpdate
    end
    object acCancel: TAction
      Caption = '&Cancel'
      OnExecute = acCancelExecute
      OnUpdate = acCancelUpdate
    end
    object acEdit: TAction
      Caption = '&Edit'
      OnExecute = acEditExecute
      OnUpdate = acEditUpdate
    end
    object acClearItems: TAction
      Caption = 'Clear all items'
      ShortCut = 16430
      OnExecute = acClearItemsExecute
      OnUpdate = acClearItemsUpdate
    end
    object acDelete: TAction
      Caption = '&Delete'
      OnExecute = acDeleteExecute
      OnUpdate = acDeleteUpdate
    end
  end
  object pmList: TPopupMenu
    Left = 240
    Top = 176
  end
end
