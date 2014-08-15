inherited cxGridLayoutViewCustomizationForm: TcxGridLayoutViewCustomizationForm
  Left = 611
  Top = 172
  ActiveControl = nil
  Caption = 'dxLayoutControlCustomizeForm2'
  ClientWidth = 705
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  inherited lcMain: TdxLayoutControl
    Width = 705
    LayoutLookAndFeel = llfMain
    inherited tvItems: TcxTreeView
      Left = 33
      Top = 100
      Height = 312
      TabStop = False
    end
    inherited tvAvailableItems: TcxTreeView
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnClose: TcxButton
      Left = 10000
      Top = 10000
      ModalResult = 1
      TabStop = False
      Visible = False
    end
    inherited cbTabbedView: TcxCheckBox
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnShowDesignSelectors: TcxButton
      TabStop = False
    end
    inherited btnHighlightRoot: TcxButton
      TabStop = False
    end
    inherited btnRestore: TcxButton
      TabStop = False
    end
    inherited btnStore: TcxButton
      TabStop = False
    end
    inherited btnRedo: TcxButton
      TabStop = False
    end
    inherited btnUndo: TcxButton
      TabStop = False
    end
    inherited btnAlignBy: TcxButton
      Left = 114
      Top = 72
      TabStop = False
    end
    inherited btnTreeViewItemsDelete: TcxButton
      Left = 85
      Top = 72
      TabStop = False
    end
    inherited btnTreeViewCollapseAll: TcxButton
      Left = 56
      Top = 72
      TabStop = False
    end
    inherited btnTreeViewExpandAll: TcxButton
      Left = 33
      Top = 72
      TabStop = False
    end
    inherited btnAvailableItemsViewAsList: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAvailableItemsDelete: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAddItem: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAddGroup: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAvailableItemsCollapseAll: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited btnAvailableItemsExpandAll: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    inherited cxButton1: TcxButton
      Left = 10000
      Top = 10000
      TabStop = False
      Visible = False
    end
    object btnOk: TcxButton [21]
      Left = 458
      Top = 428
      Width = 75
      Height = 25
      Action = acOk
      ModalResult = 1
      TabOrder = 21
    end
    object btnCancel: TcxButton [22]
      Left = 539
      Top = 428
      Width = 75
      Height = 25
      Action = acCancel
      TabOrder = 22
    end
    object btnApply: TcxButton [23]
      Left = 620
      Top = 428
      Width = 75
      Height = 25
      Action = acApply
      TabOrder = 23
    end
    inherited lcMainGroup_Root: TdxLayoutGroup
      Index = -1
    end
    inherited lcMainGroup2: TdxLayoutGroup
      Index = 0
    end
    inherited liUndo: TdxLayoutItem
      Index = 0
    end
    inherited liRedo: TdxLayoutItem
      Index = 1
    end
    inherited lsSeparator4: TdxLayoutSeparatorItem
      Index = 2
    end
    inherited liStore: TdxLayoutItem
      Index = 3
    end
    inherited liRestore: TdxLayoutItem
      Index = 4
    end
    inherited liHighlightRoot: TdxLayoutItem
      Index = 5
    end
    inherited liShowDesignSelectors: TdxLayoutItem
      Index = 6
    end
    inherited lcMainGroup1: TdxLayoutGroup
      Parent = lcMainGroup5
      LayoutDirection = ldTabbed
      Index = 2
    end
    inherited lcgTreeView: TdxLayoutGroup
      Index = 0
    end
    inherited lgTreeView: TdxLayoutGroup
      Index = 0
    end
    inherited lcMainItem10: TdxLayoutItem
      Index = 0
    end
    inherited lcMainItem9: TdxLayoutItem
      Index = 1
    end
    inherited lcMainSeparatorItem3: TdxLayoutSeparatorItem
      Index = 2
    end
    inherited lcMainItem7: TdxLayoutItem
      Index = 3
    end
    inherited lsAlignBy: TdxLayoutSeparatorItem
      Index = 4
    end
    inherited liAlignBy: TdxLayoutItem
      Index = 5
    end
    inherited lcMainItem6: TdxLayoutItem
      Index = 1
    end
    inherited lcgAvailableItems: TdxLayoutGroup
      Index = 1
    end
    inherited lgAvailableItems: TdxLayoutGroup
      Index = 0
    end
    inherited lcMainItem15: TdxLayoutItem
      Index = 0
    end
    inherited lcMainItem14: TdxLayoutItem
      Index = 1
    end
    inherited lcMainSeparatorItem1: TdxLayoutSeparatorItem
      Index = 2
    end
    inherited lcMainItem13: TdxLayoutItem
      Index = 3
    end
    inherited liAddItem: TdxLayoutItem
      Index = 4
    end
    inherited liAddCustomItem: TdxLayoutItem
      Index = 5
    end
    inherited lcMainItem11: TdxLayoutItem
      Index = 6
    end
    inherited lcMainSeparatorItem2: TdxLayoutSeparatorItem
      Index = 7
    end
    inherited lcMainItem3: TdxLayoutItem
      Index = 8
    end
    inherited lcMainItem8: TdxLayoutItem
      Index = 1
    end
    inherited lcMainGroup3: TdxLayoutGroup
      AlignHorz = ahRight
      Hidden = False
      Index = 2
    end
    inherited lcMainItem4: TdxLayoutItem
      Parent = nil
      Index = -1
    end
    inherited lcMainItem1: TdxLayoutItem
      AlignHorz = ahLeft
      Parent = nil
      Index = -1
    end
    object liGridViewContainer: TdxLayoutItem
      AlignHorz = ahClient
      AlignVert = avClient
      CaptionOptions.Text = 'dxLayoutControl1'
      CaptionOptions.Visible = False
      Parent = lcMainGroup5
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object lcMainGroup5: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      Parent = lcMainGroup_Root
      ButtonOptions.Buttons = <>
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = 1
    end
    object lcMainSplitterItem1: TdxLayoutSplitterItem
      CaptionOptions.Text = 'Splitter'
      Parent = lcMainGroup5
      SizeOptions.AssignedValues = [sovSizableHorz, sovSizableVert]
      SizeOptions.SizableHorz = False
      SizeOptions.SizableVert = False
      Index = 1
    end
    object lcMainItem2: TdxLayoutItem
      CaptionOptions.Text = 'cxButton2'
      CaptionOptions.Visible = False
      Parent = lcMainGroup3
      ControlOptions.ShowBorder = False
      Control = btnOk
      Index = 0
    end
    object lcMainItem5: TdxLayoutItem
      CaptionOptions.Text = 'cxButton3'
      CaptionOptions.Visible = False
      Parent = lcMainGroup3
      ControlOptions.ShowBorder = False
      Control = btnCancel
      Index = 1
    end
    object lcMainItem12: TdxLayoutItem
      CaptionOptions.Text = 'cxButton4'
      CaptionOptions.Visible = False
      Parent = lcMainGroup3
      ControlOptions.ShowBorder = False
      Control = btnApply
      Index = 2
    end
  end
  inherited alMain: TActionList
    inherited acClose: TAction
      ShortCut = 0
    end
    object acApply: TAction
      Category = 'Buttons'
      Caption = 'acApply'
      OnExecute = acApplyExecute
    end
    object acCancel: TAction
      Category = 'Buttons'
      Caption = 'acCancel'
      ShortCut = 27
      OnExecute = acCancelExecute
    end
    object acOk: TAction
      Category = 'Buttons'
      Caption = 'acOk'
      OnExecute = acOkExecute
    end
  end
  inherited ilActions: TcxImageList
    FormatVersion = 1
  end
  inherited ilItems: TcxImageList
    FormatVersion = 1
  end
  inherited ilHelper: TcxImageList
    FormatVersion = 1
  end
  object dxLayoutLookAndFeelList1: TdxLayoutLookAndFeelList
    Left = 152
    Top = 392
    object llfMain: TdxLayoutCxLookAndFeel
    end
  end
end
