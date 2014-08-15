object IDEEditorForm: TIDEEditorForm
  Left = 415
  Top = 131
  ClientHeight = 491
  ClientWidth = 848
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object FLeftSplitter: TSplitter
    Left = 185
    Top = 67
    Height = 424
    Beveled = True
  end
  object FRightSplitter: TSplitter
    Left = 671
    Top = 67
    Height = 424
    Align = alRight
    Beveled = True
  end
  object FLeftPanel: TPanel
    Left = 0
    Top = 67
    Width = 185
    Height = 424
    Align = alLeft
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 0
    OnDockDrop = PanelDockDrop
    OnUnDock = PanelUnDock
  end
  object IDEPaletteToolbar2: TIDEPaletteToolbar
    Left = 0
    Top = 26
    Width = 848
    Height = 41
    Align = alTop
    FlatButtons = True
    ButtonSize = 29
  end
  object ControlBar1: TControlBar
    Left = 0
    Top = 0
    Width = 848
    Height = 26
    Align = alTop
    AutoSize = True
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    object ToolBar2: TToolBar
      Left = 11
      Top = 2
      Width = 70
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      Images = dmIDEActions.ImageList1
      TabOrder = 1
      object ToolButton15: TToolButton
        Left = 0
        Top = 0
        Action = dmIDEActions.acNewProject
      end
      object ToolButton3: TToolButton
        Left = 23
        Top = 0
        Action = dmIDEActions.acOpenProject
      end
      object ToolButton4: TToolButton
        Left = 46
        Top = 0
        Action = dmIDEActions.acSaveAll
      end
    end
    object ToolBar4: TToolBar
      Left = 94
      Top = 2
      Width = 94
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      Images = dmIDEActions.ImageList1
      TabOrder = 3
      object ToolButton16: TToolButton
        Left = 0
        Top = 0
        Action = dmIDEActions.acNewUnit
      end
      object ToolButton17: TToolButton
        Left = 23
        Top = 0
        Action = dmIDEActions.acNewForm
      end
      object ToolButton18: TToolButton
        Left = 46
        Top = 0
        Action = dmIDEActions.acOpenFile
      end
      object ToolButton19: TToolButton
        Left = 69
        Top = 0
        Action = dmIDEActions.acSaveFile
      end
    end
    object ToolBar3: TToolBar
      Left = 201
      Top = 2
      Width = 73
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      Images = dmIDEActions.ImageList1
      TabOrder = 2
      object ToolButton6: TToolButton
        Left = 0
        Top = 0
        Action = dmIDEActions.acCutClipboard
      end
      object ToolButton7: TToolButton
        Left = 23
        Top = 0
        Action = dmIDEActions.acCopyClipboard
      end
      object ToolButton8: TToolButton
        Left = 46
        Top = 0
        Action = dmIDEActions.acPasteClipboard
      end
    end
    object ToolBar1: TToolBar
      Left = 287
      Top = 2
      Width = 179
      Height = 22
      AutoSize = True
      Caption = 'ToolBar1'
      Images = dmIDEActions.ImageList1
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Action = dmIDEActions.acRun
      end
      object ToolButton2: TToolButton
        Left = 23
        Top = 0
        Action = dmIDEActions.acPause
      end
      object ToolButton11: TToolButton
        Left = 46
        Top = 0
        Action = dmIDEActions.acReset
      end
      object ToolButton9: TToolButton
        Left = 69
        Top = 0
        Width = 8
        Caption = 'ToolButton9'
        ImageIndex = 23
        Style = tbsSeparator
      end
      object ToolButton5: TToolButton
        Left = 77
        Top = 0
        Action = dmIDEActions.acTraceInto
      end
      object ToolButton10: TToolButton
        Left = 100
        Top = 0
        Action = dmIDEActions.acStepOver
      end
      object ToolButton12: TToolButton
        Left = 123
        Top = 0
        Width = 8
        Caption = 'ToolButton12'
        ImageIndex = 12
        Style = tbsSeparator
      end
      object ToolButton13: TToolButton
        Left = 131
        Top = 0
        Action = dmIDEActions.acToggleBreak
      end
      object ToolButton14: TToolButton
        Left = 154
        Top = 0
        Action = dmIDEActions.acAddWatch
      end
    end
  end
  object FRightPanel: TPanel
    Left = 674
    Top = 67
    Width = 174
    Height = 424
    Align = alRight
    BevelOuter = bvNone
    DockSite = True
    TabOrder = 3
    OnDockDrop = PanelDockDrop
    OnUnDock = PanelUnDock
  end
  object Panel1: TPanel
    Left = 188
    Top = 67
    Width = 483
    Height = 424
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 4
    object FBottomSplitter: TSplitter
      Left = 0
      Top = 341
      Width = 483
      Height = 3
      Cursor = crVSplit
      Align = alBottom
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 483
      Height = 341
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object TabControl1: TTabControl
        Left = 0
        Top = 0
        Width = 483
        Height = 320
        Align = alClient
        TabOrder = 0
        Visible = False
        object IDEFormDesignControl1: TIDEFormDesignControl
          Left = 4
          Top = 6
          Width = 475
          Height = 310
          Align = alClient
          Color = clWindow
          ParentColor = False
          PopupMenu = PopupMenu1
        end
        object IDEMemo1: TIDEMemo
          Left = 4
          Top = 6
          Width = 475
          Height = 310
          Cursor = crIBeam
          ActiveLineSettings.ShowActiveLine = True
          ActiveLineSettings.ShowActiveLineIndicator = False
          ActiveLineSettings.ActiveLineColor = 10066380
          ActiveLineSettings.ActiveLineTextColor = clBlack
          Align = alClient
          AutoCompletion.Font.Charset = DEFAULT_CHARSET
          AutoCompletion.Font.Color = clWindowText
          AutoCompletion.Font.Height = -11
          AutoCompletion.Font.Name = 'MS Sans Serif'
          AutoCompletion.Font.Style = []
          AutoCorrect.Active = True
          AutoHintParameterPosition = hpBelowCode
          BorderStyle = bsSingle
          BreakpointColor = 16762823
          BreakpointTextColor = clBlack
          CodeFolding.Enabled = False
          CodeFolding.LineColor = clGray
          Ctl3D = False
          DelErase = True
          EnhancedHomeKey = False
          Gutter.DigitCount = 4
          Gutter.Font.Charset = DEFAULT_CHARSET
          Gutter.Font.Color = clWindowText
          Gutter.Font.Height = -13
          Gutter.Font.Name = 'Courier New'
          Gutter.Font.Style = []
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'COURIER NEW'
          Font.Style = []
          HiddenCaret = False
          Lines.Strings = (
            '')
          MarkerList.UseDefaultMarkerImageIndex = False
          MarkerList.DefaultMarkerImageIndex = -1
          MarkerList.ImageTransparentColor = 33554432
          PrintOptions.MarginLeft = 0
          PrintOptions.MarginRight = 0
          PrintOptions.MarginTop = 0
          PrintOptions.MarginBottom = 0
          PrintOptions.PageNr = False
          PrintOptions.PrintLineNumbers = False
          RightMarginColor = 14869218
          ScrollHint = False
          SelColor = clWhite
          SelBkColor = clNavy
          ShowRightMargin = True
          SmartTabs = False
          TabOrder = 1
          TabSize = 4
          TabStop = True
          TrimTrailingSpaces = False
          UndoLimit = 100
          UrlStyle.TextColor = clBlue
          UrlStyle.BkColor = clWhite
          UrlStyle.Style = [fsUnderline]
          UseStyler = True
          Version = '2.1.7.11'
          WordWrap = wwNone
        end
      end
      object TabSet1: TTabSet
        Left = 0
        Top = 320
        Width = 483
        Height = 21
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        OnChange = TabSet1Change
      end
    end
    object FBottomPanel: TPanel
      Left = 0
      Top = 344
      Width = 483
      Height = 80
      Align = alBottom
      BevelOuter = bvNone
      DockSite = True
      TabOrder = 1
      OnDockDrop = PanelDockDrop
      OnUnDock = PanelUnDock
    end
  end
  object MainMenu1: TMainMenu
    Images = dmIDEActions.ImageList1
    Left = 368
    Top = 40
    object File1: TMenuItem
      Caption = '&File'
      object NewUnit1: TMenuItem
        Action = dmIDEActions.acNewUnit
      end
      object NewForm1: TMenuItem
        Action = dmIDEActions.acNewForm
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Newproject1: TMenuItem
        Action = dmIDEActions.acNewProject
      end
      object Openproject1: TMenuItem
        Action = dmIDEActions.acOpenProject
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Open1: TMenuItem
        Action = dmIDEActions.acOpenFile
      end
      object Removefromproject1: TMenuItem
        Action = dmIDEActions.acRemoveFromProject
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Save1: TMenuItem
        Action = dmIDEActions.acSaveFile
      end
      object Saveas1: TMenuItem
        Action = dmIDEActions.acSaveAsFile
      end
      object Saveprojectas1: TMenuItem
        Action = dmIDEActions.acSaveProjectAs
      end
      object Saveall1: TMenuItem
        Action = dmIDEActions.acSaveAll
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Closefile1: TMenuItem
        Action = dmIDEActions.acCloseFile
      end
      object Closeall1: TMenuItem
        Action = dmIDEActions.acCloseAll
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Action = dmIDEActions.acExit
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Undo1: TMenuItem
        Action = dmIDEActions.acUndo
      end
      object Redo1: TMenuItem
        Action = dmIDEActions.acRedo
      end
      object N10: TMenuItem
        Caption = '-'
      end
      object Cut1: TMenuItem
        Action = dmIDEActions.acCutClipboard
      end
      object Copy1: TMenuItem
        Action = dmIDEActions.acCopyClipboard
      end
      object Paste1: TMenuItem
        Action = dmIDEActions.acPasteClipboard
      end
      object Delete1: TMenuItem
        Action = dmIDEActions.acDeleteControl
      end
      object SelectAll1: TMenuItem
        Action = dmIDEActions.acSelectAll
      end
      object N11: TMenuItem
        Caption = '-'
      end
      object Find1: TMenuItem
        Action = dmIDEActions.acFind
      end
      object Replace1: TMenuItem
        Action = dmIDEActions.acReplace
      end
      object Searchagain1: TMenuItem
        Action = dmIDEActions.acSearchAgain
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object AligntoGrid1: TMenuItem
        Action = dmIDEActions.acAlignToGrid
      end
      object BringtoFront1: TMenuItem
        Action = dmIDEActions.acBringToFront
      end
      object SendtoBack1: TMenuItem
        Action = dmIDEActions.acSendToBack
      end
      object Align1: TMenuItem
        Action = dmIDEActions.acAlignDialog
      end
      object Size1: TMenuItem
        Action = dmIDEActions.acSizeDialog
      end
      object TabOrder1: TMenuItem
        Action = dmIDEActions.acTabOrderDialog
      end
      object acLock1: TMenuItem
        Action = dmIDEActions.acLock
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object ObjectInspector1: TMenuItem
        Action = acViewInspector
      end
      object ToolPalette1: TMenuItem
        Action = acViewPalette
      end
      object Watches1: TMenuItem
        Action = acViewWatches
      end
      object N9: TMenuItem
        Caption = '-'
      end
      object ToggleFormUnit1: TMenuItem
        Action = dmIDEActions.acToggleFormUnit
      end
    end
    object Run1: TMenuItem
      Caption = '&Run'
      object Run2: TMenuItem
        Action = dmIDEActions.acRun
      end
      object Compile1: TMenuItem
        Action = dmIDEActions.acCompile
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Stepover1: TMenuItem
        Action = dmIDEActions.acStepOver
      end
      object Traceinto1: TMenuItem
        Action = dmIDEActions.acTraceInto
      end
      object Runtocursor1: TMenuItem
        Action = dmIDEActions.acRunTo
      end
      object Rununtilreturn1: TMenuItem
        Action = dmIDEActions.acReturn
      end
      object Pause1: TMenuItem
        Action = dmIDEActions.acPause
      end
      object Scriptreset1: TMenuItem
        Action = dmIDEActions.acReset
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Addwatch1: TMenuItem
        Action = dmIDEActions.acAddWatch
      end
      object Togglebreakpoint1: TMenuItem
        Action = dmIDEActions.acToggleBreak
      end
    end
    object Project1: TMenuItem
      Caption = 'Project'
      object SelectMainUnit1: TMenuItem
        Action = dmIDEActions.acSetMainUnit
      end
    end
    object Tools1: TMenuItem
      Caption = 'Tools'
      object DesignerOptions1: TMenuItem
        Action = dmIDEActions.acDesignerOptionsDlg
      end
    end
  end
  object ActionList1: TActionList
    Left = 440
    Top = 42
    object acViewWatches: TAction
      Caption = 'Watches'
      Hint = 'View watches'
      ImageIndex = 27
      ShortCut = 49239
      OnExecute = acViewWatchesExecute
    end
    object acViewPalette: TAction
      Caption = 'Tool Palette'
      Hint = 'View Tool Palette'
      ImageIndex = 26
      ShortCut = 49232
      OnExecute = acViewPaletteExecute
    end
    object acViewInspector: TAction
      Caption = 'Object Inspector'
      Hint = 'View Object Inspector'
      ImageIndex = 25
      ShortCut = 122
      OnExecute = acViewInspectorExecute
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 474
    Top = 42
  end
end
