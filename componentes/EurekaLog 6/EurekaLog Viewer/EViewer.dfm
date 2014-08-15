object ELViewerMainForm: TELViewerMainForm
  Left = 270
  Top = 222
  Width = 704
  Height = 511
  Caption = 'EurekaLog Viewer 3.0'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnKeyPress = FormKeyPress
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 194
    Width = 696
    Height = 2
    Cursor = crVSplit
    Align = alTop
    Color = 15224064
    ParentColor = False
  end
  object TabContainer: TcxPageControl
    Left = 0
    Top = 196
    Width = 696
    Height = 281
    ActivePage = cxTabSheet1
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = True
    ParentFont = False
    TabOrder = 11
    ClientRectBottom = 277
    ClientRectLeft = 2
    ClientRectRight = 692
    ClientRectTop = 22
    object cxTabSheet2: TcxTabSheet
      Caption = 'General'
      ImageIndex = 1
      object GridGeneral: TcxGrid
        Left = 0
        Top = 0
        Width = 690
        Height = 255
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
        object GeneralView: TcxGridTableView
          NavigatorButtons.ConfirmDelete = False
          NavigatorButtons.Insert.Visible = False
          NavigatorButtons.Delete.Visible = False
          NavigatorButtons.Edit.Visible = False
          NavigatorButtons.Post.Visible = False
          NavigatorButtons.Cancel.Visible = False
          NavigatorButtons.Refresh.Visible = False
          NavigatorButtons.SaveBookmark.Visible = True
          NavigatorButtons.GotoBookmark.Visible = False
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.DragHighlighting = False
          OptionsBehavior.DragOpening = False
          OptionsBehavior.DragScrolling = False
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.NavigatorHints = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.CellAutoHeight = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.ExpandButtonsForEmptyDetails = False
          OptionsView.GridLineColor = 10070188
          OptionsView.GroupByBox = False
          OptionsView.HeaderEndEllipsis = True
          Preview.LeftIndent = 18
          Preview.MaxLineCount = 1
          Preview.Place = ppTop
          Preview.Visible = True
          Styles.Background = stGreyLight
          Styles.FilterBox = stYellowLight
          Styles.Inactive = stInactive
          Styles.Header = stBlueDarkBold
          OnCustomDrawGroupCell = GeneralViewCustomDrawGroupCell
          object General_Col_Group: TcxGridColumn
            Visible = False
            GroupIndex = 0
            MinWidth = 80
            Options.Editing = False
            Options.Filtering = False
            Options.FilteringMRUItemsList = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.HorzSizing = False
            Options.Moving = False
            Options.Sorting = False
            Styles.Header = stBlueSky
            Width = 80
            IsCaptionAssigned = True
          end
          object General_Col_Name: TcxGridColumn
            Caption = 'Name'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 252
          end
          object General_Col_Value: TcxGridColumn
            Caption = 'Value'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.ScrollBars = ssVertical
            Properties.WordWrap = False
            Options.IncSearch = False
            Options.ShowEditButtons = isebAlways
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = stCourier2
            Styles.Header = stBlueSky
            Width = 507
          end
        end
        object LevelGeneral: TcxGridLevel
          Caption = 'Sections'
          GridView = GeneralView
        end
      end
    end
    object cxTabSheet1: TcxTabSheet
      Caption = 'Call Stack'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 0
      ParentFont = False
      object GridCallStack: TcxGrid
        Left = 0
        Top = 0
        Width = 690
        Height = 255
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
        object CallStackView: TcxGridTableView
          NavigatorButtons.ConfirmDelete = False
          NavigatorButtons.Insert.Visible = False
          NavigatorButtons.Delete.Visible = False
          NavigatorButtons.Edit.Visible = False
          NavigatorButtons.Post.Visible = False
          NavigatorButtons.Cancel.Visible = False
          NavigatorButtons.Refresh.Visible = False
          NavigatorButtons.SaveBookmark.Visible = True
          NavigatorButtons.GotoBookmark.Visible = False
          OnCellDblClick = CallStackViewCellDblClick
          OnCustomDrawCell = CallStackViewCustomDrawCell
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.DragHighlighting = False
          OptionsBehavior.DragOpening = False
          OptionsBehavior.DragScrolling = False
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.NavigatorHints = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.CellAutoHeight = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.ExpandButtonsForEmptyDetails = False
          OptionsView.GridLineColor = 10070188
          OptionsView.GridLines = glHorizontal
          OptionsView.GroupByBox = False
          OptionsView.GroupRowStyle = grsOffice11
          OptionsView.HeaderEndEllipsis = True
          Preview.Column = CallStackView_Preview
          Preview.LeftIndent = 18
          Preview.MaxLineCount = 1
          Preview.Place = ppTop
          Preview.Visible = True
          Styles.Background = stGreyLight
          Styles.FilterBox = stYellowLight
          Styles.Inactive = stInactive
          Styles.Header = stBlueDarkBold
          OnCustomDrawGroupCell = CallStackViewCustomDrawGroupCell
          object CallStack_Col_Group: TcxGridColumn
            PropertiesClassName = 'TcxMemoProperties'
            Properties.WordWrap = False
            Visible = False
            GroupIndex = 0
            SortIndex = 0
            SortOrder = soAscending
            Width = 60
            IsCaptionAssigned = True
          end
          object CallStack_Col_Addr: TcxGridColumn
            Caption = 'Address'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            MinWidth = 70
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 80
          end
          object CallStack_Col_Module: TcxGridColumn
            Caption = 'Module'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 102
          end
          object CallStack_Col_Unit: TcxGridColumn
            Caption = 'Unit'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 105
          end
          object CallStack_Col_Class: TcxGridColumn
            Caption = 'Class'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 118
          end
          object CallStack_Col_Proc: TcxGridColumn
            Caption = 'Procedure/Method'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 137
          end
          object CallStack_Col_Line: TcxGridColumn
            Caption = 'Line'
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.Alignment = taRightJustify
            Properties.ReadOnly = True
            Properties.WordWrap = False
            HeaderAlignmentHorz = taRightJustify
            Options.Filtering = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
          end
          object CallStack_Col_Off: TcxGridColumn
            Caption = 'Rel. line'
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.Alignment = taRightJustify
            Properties.ReadOnly = True
            Properties.WordWrap = False
            HeaderAlignmentHorz = taRightJustify
            Options.Filtering = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
          end
          object CallStackView_Preview: TcxGridColumn
          end
        end
        object LevelCallStack: TcxGridLevel
          Caption = 'Sections'
          GridView = CallStackView
        end
      end
    end
    object cxTabSheet3: TcxTabSheet
      Caption = 'Modules'
      ImageIndex = 2
      object GridModules: TcxGrid
        Left = 0
        Top = 0
        Width = 690
        Height = 255
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
        object ModulesView: TcxGridTableView
          NavigatorButtons.ConfirmDelete = False
          NavigatorButtons.Insert.Visible = False
          NavigatorButtons.Delete.Visible = False
          NavigatorButtons.Edit.Visible = False
          NavigatorButtons.Post.Visible = False
          NavigatorButtons.Cancel.Visible = False
          NavigatorButtons.Refresh.Visible = False
          NavigatorButtons.SaveBookmark.Visible = True
          NavigatorButtons.GotoBookmark.Visible = False
          OnCustomDrawCell = ModulesViewCustomDrawCell
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.DragHighlighting = False
          OptionsBehavior.DragOpening = False
          OptionsBehavior.DragScrolling = False
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.NavigatorHints = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnMoving = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.CellAutoHeight = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.ExpandButtonsForEmptyDetails = False
          OptionsView.GridLineColor = 10070188
          OptionsView.GridLines = glVertical
          OptionsView.GroupByBox = False
          OptionsView.GroupRowStyle = grsOffice11
          OptionsView.HeaderEndEllipsis = True
          Preview.LeftIndent = 18
          Preview.MaxLineCount = 1
          Preview.Place = ppTop
          Preview.Visible = True
          Styles.Background = stGreyLight
          Styles.FilterBox = stYellowLight
          Styles.Inactive = stInactive
          Styles.Header = stBlueDarkBold
          object Modules_Col_Handle: TcxGridColumn
            Caption = 'Handle'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            MinWidth = 70
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 71
          end
          object Modules_Col_Name: TcxGridColumn
            Caption = 'Name'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 88
          end
          object Modules_Col_Desc: TcxGridColumn
            Caption = 'Description'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 185
          end
          object Modules_Col_Ver: TcxGridColumn
            Caption = 'Version'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.Alignment = taRightJustify
            Properties.ReadOnly = True
            Properties.WordWrap = False
            HeaderAlignmentHorz = taRightJustify
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 64
          end
          object Modules_Col_Size: TcxGridColumn
            Caption = 'Size'
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0'
            HeaderAlignmentHorz = taRightJustify
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 58
          end
          object Modules_Col_Mod: TcxGridColumn
            Caption = 'Modified'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.Alignment = taRightJustify
            Properties.ReadOnly = True
            Properties.WordWrap = False
            HeaderAlignmentHorz = taRightJustify
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 83
          end
          object Modules_Col_Path: TcxGridColumn
            Caption = 'Path'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 227
          end
        end
        object LevelModules: TcxGridLevel
          Caption = 'Sections'
          GridView = ModulesView
        end
      end
    end
    object cxTabSheet5: TcxTabSheet
      Caption = 'Processes'
      ImageIndex = 4
      object GridProcesses: TcxGrid
        Left = 0
        Top = 0
        Width = 690
        Height = 255
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
        object ProcessesView: TcxGridTableView
          NavigatorButtons.ConfirmDelete = False
          NavigatorButtons.Insert.Visible = False
          NavigatorButtons.Delete.Visible = False
          NavigatorButtons.Edit.Visible = False
          NavigatorButtons.Post.Visible = False
          NavigatorButtons.Cancel.Visible = False
          NavigatorButtons.Refresh.Visible = False
          NavigatorButtons.SaveBookmark.Visible = True
          NavigatorButtons.GotoBookmark.Visible = False
          OnCustomDrawCell = ModulesViewCustomDrawCell
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.DragHighlighting = False
          OptionsBehavior.DragOpening = False
          OptionsBehavior.DragScrolling = False
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.NavigatorHints = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnMoving = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.CellAutoHeight = True
          OptionsView.CellTextMaxLineCount = 1
          OptionsView.ColumnAutoWidth = True
          OptionsView.ExpandButtonsForEmptyDetails = False
          OptionsView.GridLineColor = 10070188
          OptionsView.GridLines = glVertical
          OptionsView.GroupByBox = False
          OptionsView.GroupRowStyle = grsOffice11
          OptionsView.HeaderEndEllipsis = True
          Preview.LeftIndent = 18
          Preview.MaxLineCount = 1
          Preview.Place = ppTop
          Preview.Visible = True
          Styles.Background = stGreyLight
          Styles.FilterBox = stYellowLight
          Styles.Inactive = stInactive
          Styles.Header = stBlueDarkBold
          object Processes_Col_ID: TcxGridColumn
            Caption = 'ID'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            MinWidth = 50
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 50
          end
          object Processes_Col_Name: TcxGridColumn
            Caption = 'Name'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 88
          end
          object Processes_Col_Description: TcxGridColumn
            Caption = 'Description'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 185
          end
          object Processes_Col_Version: TcxGridColumn
            Caption = 'Version'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.Alignment = taRightJustify
            Properties.ReadOnly = True
            Properties.WordWrap = False
            HeaderAlignmentHorz = taRightJustify
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 65
          end
          object Processes_Col_Memory: TcxGridColumn
            Caption = 'Memory'
            DataBinding.ValueType = 'Integer'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taRightJustify
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0'
            HeaderAlignmentHorz = taRightJustify
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 70
          end
          object Processes_Col_Priority: TcxGridColumn
            Caption = 'Priority'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.Alignment = taCenter
            Properties.WordWrap = False
            HeaderAlignmentHorz = taRightJustify
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 62
          end
          object Processes_Col_Threads: TcxGridColumn
            Caption = 'Threads'
            PropertiesClassName = 'TcxCurrencyEditProperties'
            Properties.Alignment.Horz = taCenter
            Properties.DecimalPlaces = 0
            Properties.DisplayFormat = ',0'
            HeaderAlignmentHorz = taRightJustify
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = stBlueLight
            Styles.Header = stBlueSky
            Width = 65
          end
          object Processes_Col_Path: TcxGridColumn
            Caption = 'Path'
            PropertiesClassName = 'TcxMemoProperties'
            Properties.ReadOnly = True
            Properties.WordWrap = False
            Options.Focusing = False
            Options.IncSearch = False
            Options.Grouping = False
            Styles.Content = cxContrast
            Styles.Header = stBlueSky
            Width = 227
          end
        end
        object LevelProcesses: TcxGridLevel
          Caption = 'Sections'
          GridView = ProcessesView
        end
      end
    end
    object cxTabSheet6: TcxTabSheet
      Caption = 'Assembler'
      ImageIndex = 5
      object GridAssembler: TcxGrid
        Left = 0
        Top = 0
        Width = 690
        Height = 255
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
        object AssemblerView: TcxGridTableView
          NavigatorButtons.ConfirmDelete = False
          NavigatorButtons.Insert.Visible = False
          NavigatorButtons.Delete.Visible = False
          NavigatorButtons.Edit.Visible = False
          NavigatorButtons.Post.Visible = False
          NavigatorButtons.Cancel.Visible = False
          NavigatorButtons.Refresh.Visible = False
          NavigatorButtons.SaveBookmark.Visible = True
          NavigatorButtons.GotoBookmark.Visible = False
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.DragHighlighting = False
          OptionsBehavior.DragOpening = False
          OptionsBehavior.DragScrolling = False
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.NavigatorHints = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.CellAutoHeight = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.ExpandButtonsForEmptyDetails = False
          OptionsView.GridLineColor = 10070188
          OptionsView.GroupByBox = False
          OptionsView.HeaderEndEllipsis = True
          Preview.LeftIndent = 18
          Preview.MaxLineCount = 1
          Preview.Place = ppTop
          Preview.Visible = True
          Styles.Background = stGreyLight
          Styles.FilterBox = stYellowLight
          Styles.Inactive = stInactive
          Styles.Header = stBlueDarkBold
          OnCustomDrawGroupCell = GeneralViewCustomDrawGroupCell
          object Assembler_Col_Text: TcxGridColumn
            Caption = 'Assembler Information'
            PropertiesClassName = 'TcxRichEditProperties'
            Properties.ReadOnly = True
            Properties.ScrollBars = ssBoth
            Options.IncSearch = False
            Options.ShowEditButtons = isebAlways
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = stCourier
            Styles.Header = stBlueSky
            Width = 126
          end
        end
        object LevelAssembler: TcxGridLevel
          Caption = 'Sections'
          GridView = AssemblerView
        end
      end
    end
    object cxTabSheet4: TcxTabSheet
      Caption = 'CPU'
      ImageIndex = 3
      object GridCPU: TcxGrid
        Left = 0
        Top = 0
        Width = 690
        Height = 255
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        LookAndFeel.Kind = lfOffice11
        LookAndFeel.NativeStyle = False
        object CPUView: TcxGridTableView
          NavigatorButtons.ConfirmDelete = False
          NavigatorButtons.Insert.Visible = False
          NavigatorButtons.Delete.Visible = False
          NavigatorButtons.Edit.Visible = False
          NavigatorButtons.Post.Visible = False
          NavigatorButtons.Cancel.Visible = False
          NavigatorButtons.Refresh.Visible = False
          NavigatorButtons.SaveBookmark.Visible = True
          NavigatorButtons.GotoBookmark.Visible = False
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsBehavior.DragHighlighting = False
          OptionsBehavior.DragOpening = False
          OptionsBehavior.DragScrolling = False
          OptionsBehavior.ImmediateEditor = False
          OptionsBehavior.NavigatorHints = True
          OptionsCustomize.ColumnHiding = True
          OptionsCustomize.ColumnMoving = False
          OptionsCustomize.ColumnSorting = False
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.CellEndEllipsis = True
          OptionsView.CellAutoHeight = True
          OptionsView.ColumnAutoWidth = True
          OptionsView.ExpandButtonsForEmptyDetails = False
          OptionsView.GridLineColor = 10070188
          OptionsView.GroupByBox = False
          OptionsView.HeaderEndEllipsis = True
          Preview.LeftIndent = 18
          Preview.MaxLineCount = 1
          Preview.Place = ppTop
          Preview.Visible = True
          Styles.Background = stGreyLight
          Styles.FilterBox = stYellowLight
          Styles.Inactive = stInactive
          Styles.Header = stBlueDarkBold
          OnCustomDrawGroupCell = GeneralViewCustomDrawGroupCell
          object CPU_Col_Text: TcxGridColumn
            Caption = 'CPU Information'
            PropertiesClassName = 'TcxRichEditProperties'
            Properties.ReadOnly = True
            Properties.ScrollBars = ssBoth
            Options.IncSearch = False
            Options.ShowEditButtons = isebAlways
            Options.Grouping = False
            Options.Sorting = False
            Styles.Content = stCourier
            Styles.Header = stBlueSky
            Width = 126
          end
        end
        object LevelCPU: TcxGridLevel
          Caption = 'Sections'
          GridView = CPUView
        end
      end
    end
  end
  object BarHeader: TcxHeader
    Left = 0
    Top = 0
    Width = 696
    Height = 30
    Align = alTop
    AllowSort = False
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    LookAndFeel.Kind = lfOffice11
    ParentFont = False
    ResizeUpdate = False
    Sections = <
      item
        MaxWidth = 98
        MinWidth = 1
        Width = 70
      end
      item
        MaxWidth = 150
        MinWidth = 1
        Width = 135
      end
      item
        MaxWidth = 98
        MinWidth = 1
        Width = 70
      end
      item
        DataIndex = 4
        MaxWidth = 98
        MinWidth = 1
        Width = 70
      end
      item
        DataIndex = 6
        Width = 70
      end
      item
        DataIndex = 6
        Width = 70
      end
      item
        DataIndex = 3
        MaxWidth = 10000
        Text = 'Password'
        Width = 10000
      end>
  end
  object OpenBtn: TcxButton
    Left = 4
    Top = 4
    Width = 60
    Height = 22
    Caption = '&Import'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = OpenBtnClick
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      0800000000000001000000000000000000000001000000000000000801000210
      0300031905000521070006280900072F0B00083B0D0009490F000A5411000B60
      13000B6914000B7015000C7616000C7A16000C7D17000C7F17000C8117000C82
      17000C8317000C8317000C8417000C8417000C8417000C8417000C8418000C84
      18000C8418000C8418000C8418000C8318000C8318000C8218000C8118000D80
      18000D7E18000E7C19000F79190010741A00116F1B0014691C0016601E001959
      20001D502200204924002245260025412800283D2A002A392C002D352E003131
      3100323232003333330034343400353535003636360037373700383838003939
      39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
      4100424242004343430044444400454545004646460047474700484848004949
      49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
      5100525252005353530054545400555555005656560057575700585858005959
      59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
      6100626262006363630064646400656565006666660067676700686868006969
      69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F006F7B8000787E
      9600817FAA009176BF00A566D100C247E400E61EF500F60AFC00FC03FE00FE01
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE01FE00FD02FE00FC03FE00FA05FE00F809FE00F310FD00EC1B
      FB00E12CF800D242F300BE62EC00AD7EE300A48FDB00A296D300A19ECA00A1A6
      BF00A2AEB300ABABAB00AFB0B100B2B6B600B6BBBB00B9BFC000BCC3C400C2CA
      CB00C7D0D100CDDBDD00D0E6E900D3EFF200D4F3F700D5F5FA00D6F6FB00D8F7
      FB00D6F7FC00D4F7FC00D1F7FC00CEF7FC00CAF6FD00C3F6FC00BAF6FC00B6F7
      FD00B1F7FC00ACF7FC00A9F7FC00A5F7FC00A2F7FD009FF6FD009EF4FD009DF3
      FC009BF1FC0099F0FC0095EEFC0092EBFB008FE9FB008CE7FB0089E5FB0086E3
      FB0084E1FA0080DEF9007BDCFA0079DAF90077DAF90074D8F90072D6F8006DD2
      F60066CDF2005EC7EB0058C3E70050BEE1004BBBDD0048B9D90046B8D40046BA
      CB0046BDC10047C0B70047C4AB004BCC980049CD890046CC80003FC679003DC3
      74003BC2740038BF730035BC730030B872002CB27D0028AD8B0022A698001A9D
      AA001396B6000D92B9000A8FBC00088EBD00078DBE00078DBE00078DBE00078D
      BE00078DBE00078DBE00078DBD00078DBD00078DBC00078DBB008AFBFBFBFBFB
      FBFBFBFBFBFBFBFB8A8AFBF1DBD2DADADADADADADADAE0FB8A8AFBDEE0CAD8D8
      D9D8D8D8D8D9DFD3FB8AFBD8FBC3D4D4D4D4D4D4D4D4DFC3FB8AFBD4F2CBCDD1
      D1D1D1D1D1D1DFC2FB8AFBD1DFDCC3CECECECECECE1ADEC1DAFBFBCFD6F1B9BE
      BEBEBEBE1AEC1AB9B8FBFBCCCCF2FBFBFBFBFB1AE7E5E91AFBFBFBC8C7C7C8C7
      C7C81AE7E6E6E5E91A8AFBB9C6C6C6C6C61A1A1A1AE6E71A1A1A8AFBB9C5C5C5
      FFDFDFDF1AE7EC1A8A8A8A8AFBFBFBFB8A8A8A8A1AE81A8A8A8A8A8A8A8A8A8A
      8A8A8A1AEDED1A8A8A8A8A8A8A8A8A8A8A8A8A1AED1A8A8A8A8A8A8A8A8A8A8A
      8A1A1A1A1A8A8A8A8A8A8A8A8A8A8A1A1A1A1A8A8A8A8A8A8A8A}
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
  end
  object ExitBtn: TcxButton
    Left = 420
    Top = 4
    Width = 60
    Height = 22
    Caption = '&Exit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = ExitBtnClick
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      08000000000000010000000000000000000000010000000000000005F0000005
      F1000005F2000005F2000005F1000005EF000005EC000005E7000005E3000005
      DF000005DC000005D8000005D4000005D0000005CD000005C8000005C1000005
      BA000005B7000005B7000005B7000005B6000005B6000005B6000005B6000005
      B6000005B5000005B5000005B4000005B3000106B0000206AD000307A6000509
      9D00070B94000A0D8B000D10800010137400151766001A1B56001C1E50001F20
      49002223420025263B00292934002D2D2D002E2E2E002F2F2F00303030003131
      3100323232003333330034343400353535003636360037373700383838003939
      39003A3A3A003B3B3B003C3C3C003D3D3D003E3E3E003F3F3F00404040004141
      4100424242004343430044444400454545004646460047474700484848004949
      49004A4A4A004B4B4B004C4C4C004D4D4D004E4E4E004F4F4F00505050005151
      5100525252005353530054545400555555005656560057575700585858005959
      59005A5A5A005B5B5B005C5C5C005D5D5D005E5E5E005F5F5F00606060006161
      6100626262006363630064646400656565006666660067676700686868006969
      69006A6A6A006B6B6B006C6C6C006D6D6D006E6E6E006F6F6F00707070007171
      7100727272007373730074747400757575007676760077777700787878007979
      79007A7A7A007B7B7B007C7C7C007D7D7D007E7E7E007F7F7F00808080008181
      8100828282008383830084848400858585008686860087878700888888008989
      89008A8A8A008B8B8B008C8C8C008D8D8D008E8E8E008F8F8F00909090009191
      9100929292009393930094949400959595009696960097979700989898009999
      99009A9A9A009B9B9B009C9C9C009D9D9D009E9E9E009F9F9F00A0A0A000A1A1
      A100A2A2A200A3A3A300A4A4A400A5A5A500A6A6A600A7A7A700A8A8A800A9A9
      A900AAAAAA00ABABAB00ACACAC00ADADAD00AEAEAE00AFAFAF00B0B0B000B1B1
      B100B2B2B200B3B3B300B4B4B400B5B5B500B6B6B600B7B7B700B8B8B800B9B9
      B900BABABA00BBBBBB00BCBCBC00BDBDBD00BEBEBE00BFBFBF00C0C0C000C1C1
      C100C2C2C200C3C3C300C4C4C400C5C5C500C6C6C600C7C7C700C8C8C800C9C9
      C900CACACA00D1B2D100D994D900E46CE400F139F100F917F900FD07FD00FE01
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00
      FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00FE00E9E9E9E9E9E9
      E9E9E9E9E9E9E9E91212E91212E9E9E9E9E9E9E9E9E9E91212E9E9121212E9E9
      E9E9E9E9E9E91212E9E9E912151212E9E9E9E9E9E91212E9E9E9E9E90B111212
      E9E9E9E91212E9E9E9E9E9E9E9E9121215E9151212E9E9E9E9E9E9E9E9E9E915
      0F0F0E1CE9E9E9E9E9E9E9E9E9E9E9E910100BE9E9E9E9E9E9E9E9E9E9E9E915
      0B0E0B07E9E9E9E9E9E9E9E9E9E9080B0CE9E90805E9E9E9E9E9E9E9E9030B05
      E9E9E9E90303E9E9E9E9E9E9030303E9E9E9E9E9E90303E9E9E9E9030303E9E9
      E9E9E9E9E9E9E903E9E9030303E9E9E9E9E9E9E9E9E9E9E9E9E90303E9E9E9E9
      E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9}
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
  end
  object GridList: TcxGrid
    Left = 0
    Top = 30
    Width = 696
    Height = 164
    Align = alTop
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    object ListView: TcxGridTableView
      NavigatorButtons.ConfirmDelete = False
      NavigatorButtons.Prior.Visible = True
      NavigatorButtons.NextPage.Visible = True
      NavigatorButtons.Insert.Visible = False
      NavigatorButtons.Delete.Visible = False
      NavigatorButtons.Edit.Visible = True
      NavigatorButtons.Post.Visible = True
      NavigatorButtons.Cancel.Visible = False
      NavigatorButtons.Refresh.Visible = False
      NavigatorButtons.SaveBookmark.Visible = True
      NavigatorButtons.GotoBookmark.Visible = False
      NavigatorButtons.Filter.Visible = True
      OnFocusedRecordChanged = ListViewFocusedRecordChanged
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoImmediatePost]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      DataController.OnAfterPost = ListViewDataControllerAfterPost
      DataController.OnDataChanged = ListViewDataControllerDataChanged
      OptionsBehavior.DragHighlighting = False
      OptionsBehavior.DragOpening = False
      OptionsBehavior.DragScrolling = False
      OptionsBehavior.ImmediateEditor = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsSelection.HideFocusRectOnExit = False
      OptionsView.CellEndEllipsis = True
      OptionsView.CellAutoHeight = True
      OptionsView.ColumnAutoWidth = True
      OptionsView.ExpandButtonsForEmptyDetails = False
      OptionsView.GridLineColor = 10070188
      OptionsView.GridLines = glHorizontal
      OptionsView.HeaderEndEllipsis = True
      Preview.LeftIndent = 18
      Preview.MaxLineCount = 1
      Preview.Place = ppTop
      Preview.Visible = True
      Styles.Background = stGreyLight
      Styles.FilterBox = stYellowLight
      Styles.Inactive = stInactive
      Styles.Header = stBlueDarkBold
      object Exception_ID: TcxGridColumn
        Caption = 'ID'
        Options.Editing = False
        Options.Focusing = False
        Options.IncSearch = False
        Styles.Content = stBlueBright
        Styles.Header = stBlueLight
        Width = 44
      end
      object Exception_Status: TcxGridColumn
        Caption = 'Status'
        PropertiesClassName = 'TcxComboBoxProperties'
        Properties.DropDownListStyle = lsFixedList
        Properties.Items.Strings = (
          'New'
          'Postponed'
          'Fixed'
          'Rejected')
        Options.IncSearch = False
        Options.ShowEditButtons = isebAlways
        Styles.Content = stBlueLight
        Styles.Header = stBlueSky
        Width = 61
      end
      object Exception_Note: TcxGridColumn
        Caption = 'Note'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.WantReturns = False
        Properties.WordWrap = False
        Options.IncSearch = False
        Styles.Content = stBlueLight
        Styles.Header = stBlueSky
        Width = 210
      end
      object Exception_Date: TcxGridColumn
        Caption = 'Date (local)'
        PropertiesClassName = 'TcxDateEditProperties'
        Properties.ShowTime = False
        Properties.YearsInMonthList = False
        MinWidth = 70
        Options.Editing = False
        Options.Focusing = False
        Options.IncSearch = False
        SortIndex = 0
        SortOrder = soDescending
        Styles.Content = stBlueLight
        Styles.Header = stBlueSky
        Width = 70
      end
      object Exception_Type: TcxGridColumn
        Caption = 'Type'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.WordWrap = False
        Options.Editing = False
        Options.Focusing = False
        Options.IncSearch = False
        Styles.Content = stBlueLight
        Styles.Header = stBlueSky
        Width = 95
      end
      object Exception_Message: TcxGridColumn
        Caption = 'Message'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.VisibleLineCount = 1
        Properties.WantReturns = False
        Properties.WordWrap = False
        Options.Editing = False
        Options.Focusing = False
        Options.IncSearch = False
        Styles.Content = stBlueLight
        Styles.Header = stBlueSky
        Width = 213
      end
      object Exception_Module: TcxGridColumn
        Caption = 'Module'
        PropertiesClassName = 'TcxMemoProperties'
        Properties.WordWrap = False
        Options.Editing = False
        Options.Focusing = False
        Options.IncSearch = False
        Styles.Content = stBlueBright
        Styles.Header = stBlueLight
        Width = 89
      end
    end
    object LevelList: TcxGridLevel
      Caption = 'Sections'
      GridView = ListView
    end
  end
  object XMLBtn: TcxButton
    Left = 210
    Top = 4
    Width = 60
    Height = 22
    Caption = '&XML'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnClick = XMLBtnClick
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      18000000000000060000C21E0000C21E00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FF3C95819A886CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A79D9D9DFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FF3C9581369ADE55A0C7FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFA7A7A7C2C2C2C0C0C0FF00FFFF00FF
      FF00FFFF00FF9B6C449B6C449B6C449B6C449B6C44429E3CFF00FFFF00FF3C95
      81369ADE399AEC399AECFF00FFFF00FFFF00FFFF00FF81818181818181818181
      8181818181A4A4A4FF00FFFF00FFA7A7A7C2C2C2C7C7C7C7C7C7FF00FFFF00FF
      EA851AA47844A37442A469497047123A3B1315520F1A4F121F4B133C9581399E
      D2399AEC399AECFF00FFFF00FFFF00FF9A9A9A8C8C8C8888888181815C5C5C4E
      4E4E5F5F5F5D5D5D5A5A5AA7A7A7C2C2C2C7C7C7C7C7C7FF00FFFF00FFF18418
      EC9033EA851AEA851A7047129F85699F85699F8569A76353433612399EC1399A
      EC399AECFF00FFFF00FFFF00FF9B9B9BA4A4A49A9A9A9A9A9A5C5C5C9A9A9A9A
      9A9A9A9A9A7F7F7F4A4A4ABCBCBCC7C7C7C7C7C7FF00FFFF00FFFF00FFEC8C29
      F28417F28417EA851A9F8569ECD6B1FCFBD4FCFBD6F2E2BB9E876C9A886C4C36
      12FF00FFFF00FFFF00FFFF00FFA0A0A09B9B9B9B9B9B9A9A9A9A9A9AE9E9E9FF
      FFFFFFFFFFF5F5F59C9C9C9D9D9D4B4B4BFF00FFFF00FFFF00FFF18418ED881E
      EC8A21EC8A219B6C44EBEACFFCFBD6FCF8CCFCFAD1FCF8CCF4E5BDA0805B4C36
      125D3811FF00FFFF00FF9B9B9B9D9D9D9F9F9F9F9F9F818181FEFEFEFFFFFFFF
      FFFFFFFFFFFFFFFFF7F7F79494944B4B4B4E4E4EFF00FFFF00FFED881EEC9033
      ED973F299A1F9F8569FCFBD6FCF9CFFCF9CFFCFBD4F4E5BDE8BD8AE6B8846939
      26613911FF00FFFF00FF9D9D9DA4A4A4ABABAB9F9F9F9A9A9AFFFFFFFFFFFFFF
      FFFFFFFFFFF7F7F7D0D0D0CBCBCB525252505050FF00FFFF00FFEC9033ED9D4B
      A57C49299F239E876CFCFBD6FCF9CFFCFBD4FCF9CFE8BD8AECB171E7C5986E35
      31613911FF00FFFF00FFA4A4A4B0B0B08F8F8FA3A3A39C9C9CFFFFFFFFFFFFFF
      FFFFFFFFFFD0D0D0C3C3C3D8D8D8525252505050FF00FFFF00FFED973FECA760
      61BB594AA5479F8569F9F8D2FCF8CCF8F1C8E7C598E6B884F5E8BFE7B780673C
      1B653D12FF00FFFF00FFABABABB9B9B9C0C0C0ABABAB9A9A9AFFFFFFFFFFFFFF
      FFFFD8D8D8CBCBCBFAFAFACACACA535353535353FF00FFFF00FFED9D4BEBB06E
      79CA7870C96FA0805BE4BE90F5E8BFEAB579E7B780FCFBD6EBEACF9B6C441263
      07126307FF00FFFF00FFB0B0B0C2C2C2D1D1D1CECECE949494D1D1D1FAFAFAC7
      C7C7CACACAFFFFFFFEFEFE8181816E6E6E6E6E6EFF00FFFF00FFECA256EBB06E
      7BCA7B9FC09F96C196A0805B99996FE7C598E8C99EB3B3B39B6C447047121065
      06106506FF00FFFF00FFB5B5B5C2C2C2D1D1D1D1D1D1CFCFCF949494AAAAAAD8
      D8D8DCDCDCCCCCCC8181815C5C5C707070707070FF00FFFF00FFFF00FF61BB59
      7BCA7BA5C0A5A5C0A579CA7853A94F9B6C449B6C44A37142EA851A7047121065
      06FF00FFFF00FFFF00FFFF00FFC0C0C0D1D1D1D2D2D2D2D2D2D1D1D1B0B0B081
      81818181818686869A9A9A5C5C5C707070FF00FFFF00FFFF00FFFF00FF53A94F
      69C86881C78181C78169C8684AA547299F23299A1FEC8C29F284175837111065
      06FF00FFFF00FFFF00FFFF00FFB0B0B0CCCCCCD0D0D0D0D0D0CCCCCCABABABA3
      A3A39F9F9FA0A0A09B9B9B4D4D4D707070FF00FFFF00FFFF00FFFF00FFFF00FF
      53A94F61BB5961BB594AA547359E2F289A1F289A1FEA851AF28417F28417FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFB0B0B0C0C0C0C0C0C0ABABABA3A3A39F
      9F9F9F9F9F9A9A9A9B9B9B9B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF359E2F299F23289A1F106506634011F28417FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFA3A3A3A3A3A39F9F9F70
      70705555559B9B9BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    NumGlyphs = 2
  end
  object PwdEdit: TcxTextEdit
    Left = 539
    Top = 5
    ParentFont = False
    Properties.Alignment.Horz = taLeftJustify
    Properties.EchoMode = eemPassword
    Properties.PasswordChar = '*'
    Style.BorderStyle = ebsOffice11
    Style.Font.Charset = DEFAULT_CHARSET
    Style.Font.Color = clWindowText
    Style.Font.Height = -11
    Style.Font.Name = 'Tahoma'
    Style.Font.Style = []
    Style.LookAndFeel.Kind = lfOffice11
    Style.IsFontAssigned = True
    StyleDisabled.BorderColor = 16756398
    StyleDisabled.LookAndFeel.Kind = lfOffice11
    StyleFocused.LookAndFeel.Kind = lfOffice11
    StyleHot.LookAndFeel.Kind = lfOffice11
    TabOrder = 7
    OnKeyUp = PwdEditKeyUp
    Width = 104
  end
  object RefreshBtn: TcxButton
    Left = 646
    Top = 4
    Width = 47
    Height = 22
    Caption = '&Refresh'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = RefreshBtnClick
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
  end
  object HelpBtn: TcxButton
    Left = 350
    Top = 4
    Width = 60
    Height = 22
    Caption = '&Help'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = HelpBtnClick
    Glyph.Data = {
      36080000424D360C000000000000360800002800000010000000100000000100
      20000000000000040000000000000000000000010000000000004D4D4D004F4F
      4F00505050005151510053535300585858005B5A5900636363006C6C6C006D6D
      6D0079736F0070707000747474007D7D7D00BD310100B8460C00BB460D00BD49
      0E00B74D1600B9481100B9572500B9653D00C14B1000C44B1000C14C1100C64F
      1400C7541B00C3541C00C5571F00C9551A00D1541500C4562000C0592400C959
      2200CD5B2100CC5B2200CD5C2300CA5B2400CB5C2400CA5D2700C65F2A00C35F
      2C00CA5F2900C95E2A00CA5F2A00CB602900CD612A00CC612C00CD612C00CC63
      2E00CD632F00C5633300CC653000CC663200CD663200CE673300CF673300CE68
      3400CE6B3900CB6C3B00D3693400DB6B3300D06C3900E2672B00E6713600E073
      3D00D0714000C7795100C77E5900D77F520089817D00DE875D00FF8A4A00FE8C
      4E00C2866A00CA896A00C88B6E00DA8C6600D88E6900D9927000D79C7F00F598
      6B00E29A7700E09C7B00F6A47900FFB27100008080009A9A9A00A5999300A69D
      9800ACACAC00B1ACAA00B3B3B300BBBBBB00CE9A8100CF9A8100C2A49500D4AB
      9600D8A89000D5AF9F00D9AF9A00ECAF8700E8AD9100CFB1A200CFB5A800CABB
      B100E7B9A100FFC99100FCCF9800CFC1BA00DDC6BB00FFD4A900FEDDA800E0C9
      BD00C2C2C200CAC8C600CACACA00DBC9C000D2D2D200DFDCDA00DEDEDE00E1CF
      C600E2D0C600E3D0C700E0D4CD00F3D8CA00FFDECA00EFDBD000EFDBD100EFDC
      D100EFDED300F1DBD000F1DCD100F0DDD200F1DDD200F1DCD300F1DED400F1DF
      D400F0DED500F0DFD500F0DFD600F2DED600FFE9CE00FFF3C600EDE1DA00ECE2
      DF00F1E0D700F2E0D600F2E1D600F3E0D700F2E1D700F3E1D700F3E1D800F2E1
      D900F3E2D800F4E3D800F4E2D900F4E3D900F4E3DA00F4E3DB00F5E5DD00F7E7
      DF00FFEADB00E1E1E100E4E2E200F1E4E000F3E6E000F4E7E000F0EAE300F5EA
      E200F5E8E400FBEDE600F6EDE800F5F1ED00F6F1EF00FFF3EE00ECF1F000EBF0
      F400EEFFFF00F3F2F100F6F3F200F3F9FE00F4FFFF00F7FFFF00FAFAF900F8FA
      FB00FCFBFB00FFFEF800FFFFFB00FCFBFD00F8FCFD00F8FFFF00FAFFFF00FDFC
      FD00FEFCFD00FEFDFE00FCFFFF00FDFFFF00FFFFFF0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000008080000080
      80000080800000808000C2C2C2006D6D6D00505050004D4D4D004D4D4D004D4D
      4D00535353007D7D7D00D2D2D200008080000080800000808000008080000080
      800000808000B1ACAA00E3D0C700F3E1D700F4E3D900F4E3DA00F3E2D800F3E1
      D700CABBB1005B5A590070707000B3B3B3000080800000808000008080000080
      8000CFC1BA00F4E3D800F8FAFB00E4E2E200CFB1A200D4AB9600DDC6BB00ECF1
      F000F6F3F200F2E1D60089817D006C6C6C00BBBBBB000080800000808000E0D4
      CD00F5EAE200F4FFFF00CF9A8100B74D1600B9653D00D9AF9A00C0592400B957
      2500D5AF9F00F7FFFF00F4E2D90079736F0074747400DEDEDE0000808000F2E1
      D700F8FFFF00C77E5900BB460D00C64F1400C2A49500FFFFFF00D9927000C14B
      1000B8460C00CE9A8100F8FFFF00F2E0D600585858009A9A9A00F0DED500FAFA
      F900D8A89000BD490E00CD632F00CD612A00CB6C3B00D88E6900CA5F2A00CC63
      2E00C95E2A00B9481100E0C9BD00F6EDE800A599930063636300F3E0D700F8FA
      FB00C5633300CA5D2700CE683400CB5C2400CA896A00F7E7DF00D06C3900CA5B
      2400CD663200C3541C00C7795100F8FCFD00E1CFC60051515100F3E1D800F2DE
      D600C5571F00CE673300CC663200CC5B2200C2866A00FFFFFF00E8AD9100C44B
      1000CC632E00CB602900C35F2C00F3F2F100F2E0D6004F4F4F00F2E1D900F3D8
      CA00CD5C2300CF673300CC653000CC612C00C4562000CFB5A800FFFFFF00E09C
      7B00C7541B00CD612C00C65F2A00F5F1ED00F0DFD50053535300F1E0D700FBED
      E600DB6B3300D3693400CA5F2900C9592200C9551A00C14C1100E2D0C600FFFF
      FF00D0714000CD5B2100CE6B3900FCFBFB00EFDED3006C6C6C00F1DED400FFFF
      FF00F5986B00E2672B00C88B6E00F0EAE300D77F5200BD310100D79C7F00FFFF
      FF00DA8C6600D1541500E29A7700FEFDFE00DBC9C000ACACAC00F4E3DB00F6F1
      EF00FFEADB00FF8A4A00DE875D00EEFFFF00FEFCFD00E7B9A100FAFFFF00F3F9
      FE00E0733D00E6713600FFF3EE00F4E7E000A69D9800E1E1E10000808000F1DE
      D400FFFFFF00FFE9CE00FFB27100ECAF8700ECE2DF00EBF0F400F1E4E000F6A4
      7900FE8C4E00FFDECA00FDFFFF00F0DDD200CACACA0000808000008080000080
      8000F0DFD600FFFFFF00FFFFFB00FFF3C600FEDDA800FCCF9800FFC99100FFD4
      A900FFFEF800FCFFFF00F1DFD400CAC8C6000080800000808000008080000080
      800000808000F1DCD300F5E8E400FDFCFD00FFFFFF00FFFFFF00FFFFFF00FCFB
      FD00F3E6E000F1DDD200DFDCDA00008080000080800000808000008080000080
      80000080800000808000F5E5DD00F1DCD100EFDBD000EFDBD100EFDCD100F1DB
      D000EDE1DA000080800000808000008080000080800000808000}
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
  end
  object PrnBtn: TcxButton
    Left = 280
    Top = 4
    Width = 60
    Height = 22
    Caption = '&Print'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = PrnBtnClick
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      18000000000000060000130B0000130B00000000000000000000FF00FFFF00FF
      FF00FFFF00FF868484868484FF00FFFF00FF868484868484FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9D9D9D9D9D9DFF00FFFF
      00FF9D9D9D9D9D9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF868484BCBABAB5B3B3868484868484868484EBEAEA8684848684848684
      84FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF9D9D9DD3D3D3CCCCCC9D9D9D9D
      9D9D9D9D9DFFFFFF9D9D9D9D9D9D9D9D9DFF00FFFF00FFFF00FFFF00FFFF00FF
      868484E3E2E2B5B3B3B5B3B3B5B3B35150504F4F4F868787CDCDCDE8E9E9C7C6
      C6868484868484868484FF00FFFF00FF9D9D9DFBFBFBCCCCCCCCCCCCCCCCCC69
      6969686868A0A0A0E6E6E6FFFFFFDFDFDF9D9D9D9D9D9D9D9D9DFF00FF868484
      DEDDDDD6D6D6A4A3A3A4A3A3A4A3A35655551615161212121818181212129393
      93CACACA868484FF00FFFF00FF9D9D9DF6F6F6EFEFEFBCBCBCBCBCBCBCBCBC6E
      6E6E2E2E2E2B2B2B3131312B2B2BACACACE3E3E39D9D9DFF00FF868484D6D6D6
      D6D6D6A4A3A3E0DEDED9D7D7CDCBCBC2C0C0B6B4B49F9D9D7976771212121414
      141313138684848F8C8C9D9D9DEFEFEFEFEFEFBCBCBCF7F7F7F0F0F0E4E4E4D9
      D9D9CDCDCDB6B6B68F8F8F2B2B2B2D2D2D2C2C2C9D9D9DA5A5A5868484D6D6D6
      A4A3A3F3F2F2FFFEFEFCFBFBEAE7E8E6E6E6E6E5E5DAD9D9CCCBCBBFBDBDA2A0
      A07371719391918E8C8C9D9D9DEFEFEFBCBCBCFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFEFEFEF2F2F2E4E4E4D6D6D6B9B9B98A8A8AAAAAAAA5A5A5868484A4A3A3
      FFFFFFFEFDFDFBFBFBDFDEDFADA7A9B4ADAEC3BDBED1CECFE0E0E0E1E1E1D4D3
      D3C7C6C6A7A5A58683839D9D9DBCBCBCFFFFFFFFFFFFFFFFFFF7F7F7C1C1C1C7
      C7C7D7D7D7E7E7E7F9F9F9FAFAFAECECECDFDFDFBEBEBE9C9C9CFF00FF868484
      868484F1F0F0C2B9BA93898BA19B9FABA8AAABA6A7B1ACADAFA9AAB2ADAECAC9
      C9DCDCDCD0D0D0868484FF00FF9D9D9D9D9D9DFFFFFFD3D3D3A3A3A3B6B6B6C2
      C2C2C0C0C0C6C6C6C3C3C3C7C7C7E2E2E2F5F5F5E9E9E99D9D9DFF00FFFF00FF
      FF00FF868484CAA097BA9E87A2897E95817B897C7F928C92A5A2A4BBB6B7D7D6
      D6CFCFCF868484FF00FFFF00FFFF00FFFF00FF9D9D9DBABABAB4B4B4A2A2A29A
      9A9A979797A7A7A7BCBCBCD0D0D0EFEFEFE8E8E89D9D9DFF00FFFF00FFFF00FF
      FF00FFFF00FFCC9A99FFEAC4FFDDB3EEC399D5AE8CC9A786CC9A999895968684
      84868484FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB6B6B6FDFDFDF0F0F0D7
      D7D7C3C3C3BCBCBCB6B6B6AFAFAF9D9D9D9D9D9DFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFCC9A99FFE7C8FFDDBAFFDBB1FFD9A6FFD39FCC9A99FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB6B6B6FBFBFBF1F1F1EE
      EEEEEBEBEBE6E6E6B6B6B6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFCE9D9BFFEDDAFFE7CEFFE2C3FFDDB8FFDBAECC9A99FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB9B9B9FFFFFFFDFDFDF7F7F7F1
      F1F1EEEEEEB6B6B6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFCC9A99FEF0E1FFECD8FFE6CCFFE1C2FEDDB7CC9A99FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB6B6B6FFFFFFFFFFFFFBFBFBF6
      F6F6F1F1F1B6B6B6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      CC9A99FFFFF5FFFFF5FFF0E1FFEBD6FFE8CCF6D4BACC9A99FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFB6B6B6FFFFFFFFFFFFFFFFFFFFFFFFFD
      FDFDEAEAEAB6B6B6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      CC9A99CC9A99CC9A99FCF3E9FCEADAFCE5D0CC9A99FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFB6B6B6B6B6B6B6B6B6FFFFFFFFFFFFFB
      FBFBB6B6B6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFCC9A99CC9A99CC9A99FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB6B6B6B6B6B6B6
      B6B6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    NumGlyphs = 2
  end
  object DelBtn: TcxButton
    Left = 74
    Top = 4
    Width = 60
    Height = 22
    Caption = '&Delete'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = DelBtnClick
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      18000000000000060000C21E0000C21E00000000000000000000FE00FEFE00FE
      FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE
      00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FE
      FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE
      00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FECB6703CB6703
      CB6703CB6703CB6703CB6703CB6703CB6703CB6703FE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FE98979898979898979898979898979898979898979898
      9798989798FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFEFCF9FEFBF8
      FEF8F0FEF4E8FEF1E1FEEDDAFEEAD3FDE7CDCB6703FE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
      E9E9989798FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFEFCF9FEFCF9
      FEF9F3FEF6EDFEF2E4FEEEDCFEEBD4FDE7CDCB6703FE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
      E9E9989798FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFEFCF9FEFCF9
      FEFAF6FEF7EEFEF3E6FEF0DFFEECD7FDE9D1CB6703FE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
      E9E9989798FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FE9A34009A3400
      9A34009A34009A34009A34009A34009A34009A34009A34009A3400CB6703FE00
      FE036203FE00FEFE00FE7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E
      7E7E7E7E7E7E7E7E7E7E7E989798FE00FE656565FE00FEFE00FEFEFCF9FEFCF9
      FEFAF6FEF8F0FEF5EAFEF2E4FEF0DFFEECD8FEEAD3FDE7CDFCE6CBCB6703FE00
      FE036203036203FE00FEE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
      E9E9E9E9E9E9E9E9E9E9E9838383FE00FE656565656565FE00FEFEFCF9FEFCF9
      FEFAF6FEF9F3FEF6EDFEF3E6FEF1E1FEEDDAFEEBD4FDE8CFFCE6CBCB6703FE00
      FE0362039A9A9A036203E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
      E9E9E9E9E9E9E9E9E9E9E9838383FE00FE656565E4E4E4656565FEFCF9FEFCF9
      FEFBF8FEF9F3FEF7EEFEF4E8FEF1E1FEEEDCFEEBD4FDE9D1FDE7CDCB6703FE00
      FE036203036203FE00FEE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
      E9E9E9E9E9E9E9E9E9E9E9838383FE00FE656565656565FE00FE9A34009A3400
      9A34009A34009A34009A34009A34009A34009A34009A34009A3400CB6703FE00
      FE036203FE00FEFE00FE7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E7E
      7E7E7E7E7E7E7E7E7E7E7E989798FE00FE656565FE00FEFE00FEFEFCF9FEFCF9
      FEFAF6FEF7EEFEF2E4FEEEDCFEEBD4FDE7CDCB6703FE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
      E9E9989798FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFEFCF9FEFCF9
      FEFBF8FEF8F0FEF4E8FEF0DFFEECD7FDE8CFCB6703FE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
      E9E9989798FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFEFCF9FEFCF9
      FEFCF9FEFAF6FEF6EDFEF2E4FEEDDAFEEBD4CB6703FE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEE9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9E9
      E9E9989798FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FECB6703CB6703
      CB6703CB6703CB6703CB6703CB6703CB6703CB6703FE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FE98979898979898979898979898979898979898979898
      9798989798FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FE
      FE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00
      FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE
      00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FEFE00FE}
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
    NumGlyphs = 2
  end
  object ClearBtn: TcxButton
    Left = 139
    Top = 4
    Width = 60
    Height = 22
    Caption = '&Clear'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ClearBtnClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2A6
      A4C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFE
      FCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBC2A6A4FF00FFFF00FFFF00FFFF00FF
      C2A6A4FEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFCFBFEFC
      FBC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEFAF5FEFCFBFEFAF5FEFAF5FE
      FCFBFEFAF5FEFAF5FEFCFBFEFAF5FEFAF5C2A6A4FF00FFFF00FFFF00FFFF00FF
      C2A6A4FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFAF5FEFA
      F5C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FE
      F7F0FEF7F0FEF7F0FEF7F0FEF7F0FEF7F0C2A6A4FF00FFFF00FFFF00FFFF00FF
      C2A6A4FEF7F0FEF7F0FEF7F0FEF7F0FEF3E9FEF7F0FEF7F0FEF3E9FEF7F0FEF7
      F0C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FEF3E9FEF3E9FEF3E9FE
      F3E9FEF3E9FEF3E9FEF3E9FEF3E9FEF3E9C2A6A4FF00FFFF00FFFF00FFFF00FF
      C2A6A4FFF0E2FFF0E2FEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEEDEFEF3E9FFEE
      DEC2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FEF3E9FFEEDEFFF0E2FEF3E9FF
      EEDEFFF0E2DDCFC2DDCFC2DDCFC2DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FF
      C2A6A4FFEEDEFFEEDEFFEEDEFFEEDEFFEEDEFFEEDEC3B4A8C3B4A8C3B4A8C3B4
      A8C2A6A4FF00FFFF00FFFF00FFFF00FFC2A6A4FFEEDEFFEAD7FFEEDEFFEAD7FF
      EAD7FFEEDEB0A296B0A296B0A296B0A296C2A6A4FF00FFFF00FFFF00FFFF00FF
      C2A6A4FFEAD7FFEAD7FFEAD7FFEAD7FFEAD7C9B9ACFEFAF5FEF7F0E6DAD9C2A6
      A4FF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4FFEAD7FFE6D0FFEAD7FFE6D0FF
      EAD7C5B5A9FEFAF5DDCFC2C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      C2A6A4FFE6D0FFE6D0FFE6D0FFE6D0FFE6D0C9B9ACDDCFC2C2A6A4FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFC2A6A4C2A6A4C2A6A4C2A6A4C2A6A4C2
      A6A4C2A6A4C2A6A4FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    LookAndFeel.Kind = lfOffice11
    LookAndFeel.NativeStyle = False
  end
  object Images: TImageList
    Width = 17
    Left = 120
    Top = 88
    Bitmap = {
      494C010105000900040011001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000440000003000000001002000000000000033
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000EBCEB200D08C3F00435BDB003342CA00000000000000000009BFFF0009BF
      FF0043AE7B00B1D9C40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B7A29300644A360089654A00D7892D00DE9B3E003A6CE7002446
      E3001D29B400378ADA0016C7FE0038D2F90058CD950036A76C00AFD8C3000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B7A29300F7E5DC00848C
      5F00CD763000EAC6AE00C1BFD9003169F6002947E0001B2AB900378ADA00B8D2
      D900A0D1B0003FBC7F0038A26E00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B7A29300F9E9E2003AA16800579C6400F5DDD100F4DBCE002C91
      F2003767F2002844DD00192BBD00EAD1C400E3CABD00839B5800479F69000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B7A29300F9EEE8005BB2
      830047CA89003BAF7F0025C2E00053D4FD004694FA003166EF002441E1002A29
      AC00CE7E3000DD8C2F00D5A46900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B7A29300FBF2ED00DEC4AA0067AC6F0054CE99003ED8FC003DD7
      FF0009BFFF005B66A5002C63F3003A57D700E2983600E6A85A00FCF0E0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000B7A29300FCF6F300FBF2
      EE00D5E6D5006CC69C003A93D1002CA7E400F6E1D700F4DED3007F9DEA00497D
      E600BC8E5800FCF0E00000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000BAA59600FDF9F600D86B3300DD8F6900DFA98D00E3BBA800D2A2
      8A00CB9E8800D6B5A500F5DFD300B7A29300644A360000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BEA99A00FEFCFB00FDF9
      F800FDF7F400FCF4F000FBF1ED00FAEEE800F8EAE400F7E7DF00F6E2DA00B7A2
      9300644A36000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C3AE9E00FEFEFE00D86B3300D0673100C4612F00B75A2C00A753
      2800994C26008E462300F8E8DF00B7A29300644A360000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C8B2A300000000000000
      0000FFFDFC00FDFBF900FDF9F600FCF5F200FBF2EE00FBEFEA00F9ECE600B7A2
      9300644A36000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CCB6A70000000000D86B3300D0673100C4612E00B75A2B00A853
      2900FCF6F300FBF4EF00B7A29300B7A29300654B370000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D1BBAB00000000000000
      00000000000000000000FFFEFD00FEFBFB00FDF9F800B7A29300654B3700654B
      3700654B37000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D5BFAF000000000000000000000000000000000000000000FFFE
      FE00FEFCFB00B9A49500D4C5BA00644A3600AD998A0000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D8C2B200000000000000
      000000000000000000000000000000000000FFFFFE00C0AB9C00644A3600AD99
      8A00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D8C2B200D8C2B200D8C2B200D8C2B200D8C2B200D8C2B200D4BE
      AE00CFB9A900C9B3A400D5C3B700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000D4CFCC00A0948E007E6F
      660075645B0074635A0074635A0074635A0074635A0074635A0074635A007564
      5B007E6F6600A0948E00D4CFCC00000000000000000000000000000000000000
      0000000000000000000000000000000000008484840000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484840084848400848484000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000AE7C6F00D9AD9D00D6A89A00D3A69800D2A49700CCA19900C99E
      9700C69C9600C4999500C1969300B6918B00B88E8B007F706700C5BDBA000000
      0000000000000000000000000000000000000000000000000000848484000000
      000000000000C6C6C60000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484000000000000000000000000000000000000FFFF00FFFFFF0000FF
      FF00FFFFFF0000FFFF00FFFFFF0000FFFF00FFFFFF0000FFFF00000000000000
      00000000000000000000000000000000000000000000B5827300E6DBD100FFE8
      D100FFE5CB00FFE2C500FFE0C000FFDDBB00FFDAB500FFD7B000FFD4AA00FFD2
      A500EEBDA50075645B00C1B9B500000000000000000000000000000000000000
      0000848484000000000000000000FFFF0000FFFF0000FFFFFF00FFFF0000FF00
      0000000000000000000084848400000000000000000000000000000000000000
      0000000000000000000084848400000000000000000000000000000000008484
      8400008484000084840000848400000000008484840084848400000000000000
      0000000000000000000000FFFF00848484008484840000FFFF00848484008484
      840000FFFF0000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C6000000
      000000000000BB887600E8DFD500FFEBD600FFE8D100FFE5CB00FFE2C500FFE0
      C000FCD3AA00FDD4AB00FFD7B000FFD4AA00EFBFA80074635A00C0B8B4000000
      00000000000000000000848484000000000000000000FFFF00000000FF00FFFF
      0000FFFF0000C6C6C600FF000000FFFF00000000FF00FFFF0000000000000000
      0000848484000000000000000000000000000000000084848400848484008484
      8400000000000000000000000000008484000084840000848400008484000084
      8400000000008484840000000000000000000000000000000000FFFFFF008484
      840084848400FFFFFF008484840084848400FFFFFF0000000000FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF000000000000000000C28F7A00EAE2DB00FFEE
      DC00FFEBD600FFE8D100E8D2BD00EBB47F0011589D00DB9A5B00C99E7900FDD3
      A800F0C1AB0074635A00C0B8B40000000000000000000000000000000000FFFF
      0000FFFF0000FFFF00000000FF00FFFF0000FFFF0000FFFFFF00FFFF0000FF00
      00000000FF00FF000000FFFF0000FF0000000000000000000000000000000000
      FF00000000000000000084848400848484008484840084848400008484000084
      8400008484000084840000848400008484000000000084848400000000000000
      0000000000000000000000FFFF00848484008484840000FFFF00848484008484
      840000FFFF0000000000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C6000000
      000000000000C8957D00ECE6DF00FFF1E200FFEEDC00FFEAD4005093C0001169
      A70037B4E800157BBA001676AB00F0BE8E00F0C3AF0074635A00C0B8B4000000
      0000000000000000000000000000FFFF0000FFFF0000FFFF00000000FF00FFFF
      0000FFFF0000C6C6C600FF000000FFFF00000000FF00FFFF0000FF000000FFFF
      00000000000000000000000000000000FF000000FF000000FF00000000008484
      840084848400848484000084840000FFFF000084840000848400008484000084
      8400008484000000000000000000000000000000000000000000C6C6C6008484
      840084848400C6C6C6008484840084848400C6C6C60000000000FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF000000000000000000CF9C8100EEE9E400FFF4
      E800FFF1E200B1B6C1003C9ED70046BCEF0046B0DB001B9CD3000B90C5007C84
      8900F1C5B10074635A00C0B8B40000000000000000000000000000000000FFFF
      0000FFFF0000FFFF00000000FF00FFFF0000FFFF0000FFFFFF00FFFF0000FF00
      00000000FF00FF000000FFFF0000FF0000000000000000000000000000000000
      FF000000FF000000FF000000FF000000000000000000848484000084840000FF
      FF0000FFFF000084840000848400008484000084840000000000000000000000
      000000000000FFFFFF00FFFFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FF
      FF0000FFFF0000FFFF0000000000FFFFFF00C6C6C600FFFFFF00C6C6C6000000
      000000000000D5A28300F0ECE900FFF6ED00FFF0E100B5D4D30056C3F10066C7
      F200A4A4A400167CAC000998CD0094C0C100F2C8B50074635A00C0B8B4000000
      0000000000000000000000000000FFFF0000FFFF0000FFFF00000000FF00FFFF
      0000FFFF0000C6C6C600FF000000FFFF00000000FF00FFFF0000FF000000FFFF
      00000000000000000000000000000000FF000000FF000000FF00000084000000
      84000000840000000000000000008484840000FFFF0000FFFF00008484000084
      840000000000000000000000000000000000000000000000000000000000FFFF
      FF00FFFFFF0000FFFF0000FFFF0000FFFF000000000000000000FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF000000000000000000DCA98700F2F0EE00E9EE
      DF00388820004CA33800198760005BC0D600999999003898B800329BC100FFE2
      C500F2C9B70074635A00C0B8B40000000000000000000000000000000000FFFF
      0000FFFF0000FFFF00000000FF008484840084848400FFFFFF00848484008484
      84000000FF00FF000000FFFF0000FF0000000000000000000000000000000000
      FF000000FF000000840000008400000084000000840000000000000000000000
      0000008484000084840000848400000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF00000000000000
      0000C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C6000000
      000000000000DCA98700F4F3F30087BD7E004EE775003CD55A002CC542001EB1
      2800567B3C00F9D8B600FFE8D100FFE5CB00F3CCBA0074635A00C0B8B4000000
      0000000000000000000000000000FFFF0000FFFF0000848484000000FF00FFFF
      0000FFFFFF00FFFF0000FFFFFF00FFFF00000000FF0084848400FF000000FFFF
      00000000000000000000000000000000FF000000FF0000008400000084000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF0000000000FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF000000000000000000DCA98700F6F6F60057EC
      81004FE877009DD0A700237F260007980B00059B0700FDE1C300FFEBD600FFE8
      D100F3CDBD0079686000C3BBB700000000000000000000000000000000008484
      840084848400FFFFFF00FFFF00000000FF00FFFF0000FFFFFF00FFFF00000000
      FF00FFFF0000FFFFFF0084848400848484000000000000000000000000000000
      FF00000084000000000000000000000000008484840084000000FF000000FF00
      0000FF000000FF00000000000000848484000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C6000000
      000000000000DCA98700F8F8F800E9FEEF004DE67300D2D2D2003E89470016AE
      2000C3CC9100FFF1E200FFEEDC00FFEBD600F4C9BA008A7A7100CDC6C2000000
      0000000000000000000000000000FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF
      00000000FF000000FF000000FF00FFFF0000FFFFFF00FFFF0000FFFFFF00FFFF
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084000000FF000000FF000000FF000000FF000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C600FFFFFF00C6C6C600FFFFFF000000000000000000DCA98700FAFAFA000000
      0000E5FAEA00A59E97009BA08C00BAE1B400FFF6ED00FFD5CC00FFD5CC00F5B3
      AA00B4897F00AA9E9700DFD9D700000000000000000000000000848484000000
      000000000000FFFFFF00FFFF00000000FF00FFFFFF00FFFF0000FFFFFF000000
      FF00FFFF0000FFFFFF0000000000000000008484840000000000000000000000
      0000000000000000000000000000000000000000000084840000FF000000FF00
      0000FF000000FF00000000000000848484000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00C6C6C600FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF000000000000000000000000000000
      000000000000DCA9870000000000000000000000000000000000FFFDFA00FFFA
      F500FFFBF500F7A64400F7A64400E193420097877E00CEC5C100F1EEEC000000
      000000000000000000000000000000000000848484000000000000000000FFFF
      FF00FFFF0000FFFFFF00FFFF0000FFFFFF000000000000000000848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000084840000FF000000FF000000FF000000FF000000000000008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6
      C6000000000000000000000000000000000000000000DCA98700000000000000
      00000000000000000000000000000000000000000000DCA98700EAB577008E75
      6500BBB0AA00E7E3E000FAF9F800000000000000000000000000000000000000
      00000000000000000000848484000000000000000000FFFF0000000000000000
      0000848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084840000FF000000FF00
      0000FF000000FF00000084000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000000000000000
      000000000000DCA98700DCA98700DCA98700DCA98700DCA98700DCA98700DEAB
      8800D6A38400DCA98700F9F1EB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000848484000000000084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000008484000084840000848400008484000084840000840000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000044000000300000000100010000000000400200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000F0C38000000000000000000080018000
      0000000000000000800180000000000000000000800180000000000000000000
      8001800000000000000000008001800000000000000000008003800000000000
      0000000080078000000000000000000080078000000000000000000080078000
      0000000000000000B00780000000000000000000A00780000000000000000000
      BC0780000000000000000000BE0780000000000000000000BF0F800000000000
      00000000801F800000000000000000008001FF1FFFF8F001F00000008001FC07
      FFF07000000000008001F001FDE03800000000008001C00078E0380000000000
      8001C00060003800000000008001C00060007800000000008001C00060007000
      000000008001C0006020F800000000008001C0006071FE00000000008001C000
      6180FE00000000008001C0006700FE00000000008001C0007F80FE0000000000
      9001C0007F80FE0000000000BC01F001FF80FE0010000000BF81FC07FF81FE00
      30000000801FFF1FFF81FE007000000000000000000000000000000000000000
      000000000000}
  end
  object StyleRepository: TcxStyleRepository
    Left = 88
    Top = 88
    PixelsPerInch = 96
    object stBlueDarkBold: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 11184810
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clWhite
    end
    object stBlueLight: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object stBlueBright: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16773345
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = 4196352
    end
    object stYellowLight: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14811135
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object stGreyLight: TcxStyle
      AssignedValues = [svColor, svFont]
      Color = 14872561
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object stBlueSky: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 15724527
      Font.Charset = DEFAULT_CHARSET
      Font.Color = cl3DDkShadow
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object stBlueDark: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 14529314
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clWhite
    end
    object stGold: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 4707838
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object stBlue1: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16244215
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object stInactive: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = clBlack
    end
    object cxContrast: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16114387
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      TextColor = 4456448
    end
    object stCourier: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      TextColor = clBlack
    end
    object stCourier2: TcxStyle
      AssignedValues = [svColor, svFont, svTextColor]
      Color = 16773345
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      TextColor = clBlack
    end
  end
  object OpenDialog: TOpenDialog
    Filter = 'EurekaLog file|*.elf'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Left = 8
    Top = 88
  end
  object SaveDialog: TSaveDialog
    DefaultExt = '.xml'
    Filter = 'XML file|*.xml'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist, ofEnableSizing]
    Left = 48
    Top = 88
  end
  object EL_Print: TdxComponentPrinter
    CurrentLink = EL_Print_CPU
    Version = 0
    Left = 152
    Top = 88
    object EL_Print_General: TdxGridReportLink
      Active = True
      Component = GridGeneral
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.Background.Brush.Color = 15132390
      PrinterPage.PageFooter.Background.Mode = bmBrush
      PrinterPage.PageFooter.CenterTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageFooter.Font.Charset = ANSI_CHARSET
      PrinterPage.PageFooter.Font.Color = clBlack
      PrinterPage.PageFooter.Font.Height = -12
      PrinterPage.PageFooter.Font.Name = 'Arial'
      PrinterPage.PageFooter.Font.Style = [fsBold]
      PrinterPage.PageFooter.LeftTitle.Strings = (
        '[Machine Name]/[User Name]')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageHeader.Background.Brush.Color = 15132390
      PrinterPage.PageHeader.Background.Mode = bmBrush
      PrinterPage.PageHeader.Font.Charset = ANSI_CHARSET
      PrinterPage.PageHeader.Font.Color = clBlack
      PrinterPage.PageHeader.Font.Height = -12
      PrinterPage.PageHeader.Font.Name = 'Arial'
      PrinterPage.PageHeader.Font.Style = [fsBold]
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 39582.818282870370000000
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.Footers = False
      OptionsView.Caption = False
      OptionsView.FilterBar = False
      OptionsView.GroupFooters = False
      BuiltInReportLink = True
    end
    object EL_Print_CallStack: TdxGridReportLink
      Active = True
      Component = GridCallStack
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.Background.Brush.Color = 15132390
      PrinterPage.PageFooter.Background.Mode = bmBrush
      PrinterPage.PageFooter.CenterTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageFooter.Font.Charset = ANSI_CHARSET
      PrinterPage.PageFooter.Font.Color = clBlack
      PrinterPage.PageFooter.Font.Height = -12
      PrinterPage.PageFooter.Font.Name = 'Arial'
      PrinterPage.PageFooter.Font.Style = [fsBold]
      PrinterPage.PageFooter.LeftTitle.Strings = (
        '[Machine Name]/[User Name]')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageHeader.Background.Brush.Color = 15132390
      PrinterPage.PageHeader.Background.Mode = bmBrush
      PrinterPage.PageHeader.Font.Charset = ANSI_CHARSET
      PrinterPage.PageHeader.Font.Color = clBlack
      PrinterPage.PageHeader.Font.Height = -12
      PrinterPage.PageHeader.Font.Name = 'Arial'
      PrinterPage.PageHeader.Font.Style = [fsBold]
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 39582.818282870370000000
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.Footers = False
      OptionsView.FilterBar = False
      OptionsView.GroupFooters = False
      SupportedCustomDraw = True
      OnCustomDrawCell = EL_Print_CallStackCustomDrawCell
      BuiltInReportLink = True
    end
    object EL_Print_Modules: TdxGridReportLink
      Active = True
      Component = GridModules
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.Background.Brush.Color = 15132390
      PrinterPage.PageFooter.Background.Mode = bmBrush
      PrinterPage.PageFooter.CenterTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageFooter.Font.Charset = ANSI_CHARSET
      PrinterPage.PageFooter.Font.Color = clBlack
      PrinterPage.PageFooter.Font.Height = -12
      PrinterPage.PageFooter.Font.Name = 'Arial'
      PrinterPage.PageFooter.Font.Style = [fsBold]
      PrinterPage.PageFooter.LeftTitle.Strings = (
        '[Machine Name]/[User Name]')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageHeader.Background.Brush.Color = 15132390
      PrinterPage.PageHeader.Background.Mode = bmBrush
      PrinterPage.PageHeader.Font.Charset = ANSI_CHARSET
      PrinterPage.PageHeader.Font.Color = clBlack
      PrinterPage.PageHeader.Font.Height = -12
      PrinterPage.PageHeader.Font.Name = 'Arial'
      PrinterPage.PageHeader.Font.Style = [fsBold]
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 39582.818282870370000000
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.Footers = False
      OptionsView.FilterBar = False
      OptionsView.GroupFooters = False
      BuiltInReportLink = True
    end
    object EL_Print_Processes: TdxGridReportLink
      Active = True
      Component = GridProcesses
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.Background.Brush.Color = 15132390
      PrinterPage.PageFooter.Background.Mode = bmBrush
      PrinterPage.PageFooter.CenterTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageFooter.Font.Charset = ANSI_CHARSET
      PrinterPage.PageFooter.Font.Color = clBlack
      PrinterPage.PageFooter.Font.Height = -12
      PrinterPage.PageFooter.Font.Name = 'Arial'
      PrinterPage.PageFooter.Font.Style = [fsBold]
      PrinterPage.PageFooter.LeftTitle.Strings = (
        '[Machine Name]/[User Name]')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page # of Pages #]')
      PrinterPage.PageHeader.Background.Brush.Color = 15132390
      PrinterPage.PageHeader.Background.Mode = bmBrush
      PrinterPage.PageHeader.Font.Charset = ANSI_CHARSET
      PrinterPage.PageHeader.Font.Color = clBlack
      PrinterPage.PageHeader.Font.Height = -12
      PrinterPage.PageHeader.Font.Name = 'Arial'
      PrinterPage.PageHeader.Font.Style = [fsBold]
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 39582.818282870370000000
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.Footers = False
      OptionsView.FilterBar = False
      OptionsView.GroupFooters = False
      BuiltInReportLink = True
    end
    object EL_Print_Assembler: TdxGridReportLink
      Active = True
      Component = GridAssembler
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.Background.Brush.Color = 15132390
      PrinterPage.PageFooter.Background.Mode = bmBrush
      PrinterPage.PageFooter.CenterTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageFooter.Font.Charset = ANSI_CHARSET
      PrinterPage.PageFooter.Font.Color = clBlack
      PrinterPage.PageFooter.Font.Height = -12
      PrinterPage.PageFooter.Font.Name = 'Arial'
      PrinterPage.PageFooter.Font.Style = [fsBold]
      PrinterPage.PageFooter.LeftTitle.Strings = (
        '[Machine Name]/[User Name]')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page #]')
      PrinterPage.PageHeader.Background.Brush.Color = 15132390
      PrinterPage.PageHeader.Background.Mode = bmBrush
      PrinterPage.PageHeader.Font.Charset = ANSI_CHARSET
      PrinterPage.PageHeader.Font.Color = clBlack
      PrinterPage.PageHeader.Font.Height = -12
      PrinterPage.PageHeader.Font.Name = 'Arial'
      PrinterPage.PageHeader.Font.Style = [fsBold]
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 39582.818282870370000000
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.Footers = False
      OptionsView.FilterBar = False
      OptionsView.GroupFooters = False
      BuiltInReportLink = True
    end
    object EL_Print_CPU: TdxGridReportLink
      Component = GridCPU
      PrinterPage.DMPaper = 9
      PrinterPage.Footer = 6350
      PrinterPage.Header = 6350
      PrinterPage.Margins.Bottom = 12700
      PrinterPage.Margins.Left = 12700
      PrinterPage.Margins.Right = 12700
      PrinterPage.Margins.Top = 12700
      PrinterPage.Orientation = poLandscape
      PrinterPage.PageFooter.Background.Brush.Color = 15132390
      PrinterPage.PageFooter.Background.Mode = bmBrush
      PrinterPage.PageFooter.CenterTitle.Strings = (
        '[Date & Time Printed]')
      PrinterPage.PageFooter.Font.Charset = ANSI_CHARSET
      PrinterPage.PageFooter.Font.Color = clBlack
      PrinterPage.PageFooter.Font.Height = -12
      PrinterPage.PageFooter.Font.Name = 'Arial'
      PrinterPage.PageFooter.Font.Style = [fsBold]
      PrinterPage.PageFooter.LeftTitle.Strings = (
        '[Machine Name]/[User Name]')
      PrinterPage.PageFooter.RightTitle.Strings = (
        '[Page #]')
      PrinterPage.PageHeader.Background.Brush.Color = 15132390
      PrinterPage.PageHeader.Background.Mode = bmBrush
      PrinterPage.PageHeader.Font.Charset = ANSI_CHARSET
      PrinterPage.PageHeader.Font.Color = clBlack
      PrinterPage.PageHeader.Font.Height = -12
      PrinterPage.PageHeader.Font.Name = 'Arial'
      PrinterPage.PageHeader.Font.Style = [fsBold]
      PrinterPage.PageSize.X = 210000
      PrinterPage.PageSize.Y = 297000
      PrinterPage._dxMeasurementUnits_ = 0
      PrinterPage._dxLastMU_ = 2
      ReportDocument.CreationDate = 39010.746111469910000000
      OptionsOnEveryPage.Footers = False
      OptionsOnEveryPage.FilterBar = False
      OptionsSize.AutoWidth = True
      OptionsView.Footers = False
      OptionsView.FilterBar = False
      OptionsView.GroupFooters = False
      BuiltInReportLink = True
    end
  end
end
