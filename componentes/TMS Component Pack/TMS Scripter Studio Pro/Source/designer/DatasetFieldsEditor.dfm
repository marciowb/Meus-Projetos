object fmDatasetFieldsEditor: TfmDatasetFieldsEditor
  Left = 192
  Top = 107
  Width = 142
  Height = 251
  BorderStyle = bsSizeToolWin
  Caption = 'fmDatasetFieldsEditor'
  Color = clBtnFace
  Constraints.MinHeight = 125
  Constraints.MinWidth = 125
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spAggregates: TSplitter
    Left = 0
    Top = 174
    Width = 134
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    Visible = False
  end
  object DBNavigator: TDBNavigator
    Left = 0
    Top = 0
    Width = 134
    Height = 18
    DataSource = dsNavigator
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast]
    Align = alTop
    Ctl3D = True
    ParentCtl3D = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object lsFields: TListBox
    Left = 0
    Top = 18
    Width = 134
    Height = 156
    Hint = 'Fields'
    Align = alClient
    DragMode = dmAutomatic
    ItemHeight = 13
    MultiSelect = True
    ParentShowHint = False
    PopupMenu = popFields
    ShowHint = True
    TabOrder = 1
    OnClick = lsFieldsClick
    OnDragDrop = lsFieldsDragDrop
    OnDragOver = lsFieldsDragOver
  end
  object lsAggregates: TListBox
    Left = 0
    Top = 177
    Width = 134
    Height = 40
    Hint = 'Aggregates'
    Align = alBottom
    DragMode = dmAutomatic
    ItemHeight = 13
    MultiSelect = True
    ParentShowHint = False
    PopupMenu = popFields
    ShowHint = True
    TabOrder = 2
    Visible = False
    OnClick = lsFieldsClick
    OnDragDrop = lsFieldsDragDrop
    OnDragOver = lsFieldsDragOver
  end
  object popFields: TPopupMenu
    Left = 8
    Top = 24
    object miAddFields: TMenuItem
      Action = acAddFields
    end
    object miNewField: TMenuItem
      Action = acNewField
    end
    object miAddAllFields: TMenuItem
      Action = acAddAllFields
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object miCut: TMenuItem
      Action = acCut
    end
    object miCopy: TMenuItem
      Action = acCopy
    end
    object miPaste: TMenuItem
      Action = acPaste
    end
    object miDelete: TMenuItem
      Action = acDelete
    end
    object miSelectAll: TMenuItem
      Action = acSelectAll
    end
  end
  object alFields: TActionList
    OnUpdate = alFieldsUpdate
    Left = 40
    Top = 24
    object acAddFields: TAction
      Category = 'Add'
      Caption = 'Add fields...'
      ShortCut = 16449
      OnExecute = acAddFieldsExecute
    end
    object acNewField: TAction
      Category = 'Add'
      Caption = 'New field...'
      ShortCut = 45
      OnExecute = acNewFieldExecute
    end
    object acAddAllFields: TAction
      Category = 'Add'
      Caption = 'Add all fields'
      ShortCut = 16454
      OnExecute = acAddAllFieldsExecute
    end
    object acCut: TAction
      Category = 'Edit'
      Caption = 'Cut'
      ShortCut = 16472
      OnExecute = acCutExecute
    end
    object acCopy: TAction
      Category = 'Edit'
      Caption = 'Copy'
      ShortCut = 16451
      OnExecute = acCopyExecute
    end
    object acPaste: TAction
      Category = 'Edit'
      Caption = 'Paste'
      ShortCut = 16470
      OnExecute = acPasteExecute
    end
    object acDelete: TAction
      Category = 'Edit'
      Caption = 'Delete'
      ShortCut = 46
      OnExecute = acDeleteExecute
    end
    object acSelectAll: TAction
      Category = 'Edit'
      Caption = 'Select all'
      ShortCut = 16460
      OnExecute = acSelectAllExecute
    end
  end
  object dsNavigator: TDataSource
    Left = 72
    Top = 24
  end
end
