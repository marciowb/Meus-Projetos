object cxfmSchedulerReportLinkDesignWindow: TcxfmSchedulerReportLinkDesignWindow
  Left = 364
  Top = 183
  BorderStyle = bsDialog
  Caption = 'cxfmSchedulerReportLinkDesignWindow'
  ClientHeight = 502
  ClientWidth = 632
  Color = clBtnFace
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object PageControl1: TcxPageControl
    Left = 12
    Top = 12
    Width = 608
    Height = 444
    ActivePage = tshPrintRange
    Anchors = [akLeft, akTop, akRight, akBottom]
    ShowFrame = True
    TabOrder = 0
    OnChange = PageControl1Change
    ClientRectBottom = 443
    ClientRectLeft = 1
    ClientRectRight = 607
    ClientRectTop = 24
    object tshPrintRange: TcxTabSheet
      Caption = 'Print Range'
      ImageIndex = 3
      object lblPrintRangeStart: TLabel
        Left = 17
        Top = 20
        Width = 28
        Height = 13
        Caption = '&Start:'
        Transparent = True
      end
      object lblPrintRangeEnd: TLabel
        Left = 18
        Top = 52
        Width = 22
        Height = 13
        Caption = '&End:'
        Transparent = True
      end
      object dePrintRangeStart: TcxDateEdit
        Left = 70
        Top = 18
        EditValue = 38187d
        Properties.OnEditValueChanged = dePrintRangeStartEditValueChanged
        TabOrder = 0
        Width = 239
      end
      object dePrintRangeEnd: TcxDateEdit
        Left = 70
        Top = 48
        EditValue = 38187d
        Properties.OnEditValueChanged = dePrintRangeEndEditValueChanged
        TabOrder = 1
        Width = 239
      end
      object chbxHideDetailsOfPrivateAppointments: TcxCheckBox
        Left = 66
        Top = 105
        Caption = 'Hide Details of Private Appointments'
        TabOrder = 2
        Transparent = True
        Visible = False
        Width = 236
      end
      object lblPrintRangesMiscellaneous: TcxLabel
        Left = 10
        Top = 81
        AutoSize = False
        Caption = 'Miscellaneous'
        Properties.LineOptions.Visible = True
        Transparent = True
        Visible = False
        Height = 18
        Width = 301
      end
    end
    object tshPrintStyles: TcxTabSheet
      Caption = 'Print Styles'
      object cbxPrintStyles: TcxImageComboBox
        Left = 10
        Top = 18
        AutoSize = False
        Properties.Alignment.Vert = taVCenter
        Properties.Items = <>
        Style.TransparentBorder = False
        TabOrder = 0
        OnClick = cbxPrintStylesClick
        Height = 40
        Width = 300
      end
      object pcPrintStyleOptions: TcxPageControl
        Left = 10
        Top = 64
        Width = 300
        Height = 340
        ActivePage = tshYearly
        HideTabs = True
        ShowFrame = True
        TabOrder = 1
        ClientRectBottom = 339
        ClientRectLeft = 1
        ClientRectRight = 299
        ClientRectTop = 1
        object tshDaily: TcxTabSheet
          Caption = 'Daily'
          TabVisible = False
          object lblPrintStyleDailyLayout: TLabel
            Left = 20
            Top = 34
            Width = 37
            Height = 13
            Caption = 'La&yout:'
            FocusControl = cbxPrintStyleDailyLayout
            Transparent = True
          end
          object lblPrintStyleDailyInclude: TLabel
            Left = 20
            Top = 86
            Width = 39
            Height = 13
            Caption = 'Include:'
            Transparent = True
          end
          object lblPrintStyleDailyPrintFrom: TLabel
            Left = 20
            Top = 155
            Width = 53
            Height = 13
            Caption = 'Print &From:'
            FocusControl = tePrintStyleDailyPrintFrom
            Transparent = True
          end
          object lblPrintStyleDailyPrintTo: TLabel
            Left = 20
            Top = 183
            Width = 41
            Height = 13
            Caption = 'Print &To:'
            FocusControl = tePrintStyleDailyPrintTo
            Transparent = True
          end
          object lblPrintStyleDailyResourceCountPerPage: TLabel
            Left = 20
            Top = 59
            Width = 82
            Height = 13
            Caption = 'Resources/Page:'
            FocusControl = sePrintStyleDailyResourceCountPerPage
            Transparent = True
          end
          object cbxPrintStyleDailyLayout: TcxComboBox
            Left = 114
            Top = 29
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            Properties.Items.Strings = (
              '1 page/day'
              '2 pages/day')
            TabOrder = 0
            OnClick = cbxPrintStyleDailyLayoutClick
            Width = 173
          end
          object chbxPrintStyleDailyTaskPad: TcxCheckBox
            Left = 113
            Top = 83
            Caption = 'Task&Pad'
            TabOrder = 2
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 178
          end
          object chbxPrintStyleDailyNotesAreaBlank: TcxCheckBox
            Tag = 1
            Left = 113
            Top = 104
            Caption = 'Notes Area (&Blank)'
            TabOrder = 3
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 178
          end
          object chbxPrintStyleDailyNotesAreaLined: TcxCheckBox
            Tag = 2
            Left = 113
            Top = 125
            Caption = 'Notes Area (&Lined)'
            TabOrder = 4
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 178
          end
          object tePrintStyleDailyPrintFrom: TcxTimeEdit
            Left = 114
            Top = 152
            EditValue = 0.000000000000000000
            Properties.TimeFormat = tfHourMin
            Properties.OnChange = tePrintStylePrintRangePropertiesChange
            Properties.OnEditValueChanged = tePrintStylePrintRangePropertiesEditValueChanged
            TabOrder = 5
            Width = 100
          end
          object tePrintStyleDailyPrintTo: TcxTimeEdit
            Tag = 1
            Left = 114
            Top = 179
            EditValue = 0.000000000000000000
            Properties.ImmediatePost = True
            Properties.TimeFormat = tfHourMin
            Properties.OnChange = tePrintStylePrintRangePropertiesChange
            Properties.OnEditValueChanged = tePrintStylePrintRangePropertiesEditValueChanged
            TabOrder = 6
            Width = 100
          end
          object sePrintStyleDailyResourceCountPerPage: TcxSpinEdit
            Left = 114
            Top = 56
            Properties.OnChange = sePrintStyleResourceCountPerPagePropertiesChanged
            Properties.OnEditValueChanged = sePrintStyleResourceCountPerPagePropertiesEditValueChanged
            TabOrder = 1
            Width = 100
          end
          object chbxPrintStyleDailyShowResourceImages: TcxCheckBox
            Left = 14
            Top = 224
            Caption = 'Show resource images'
            TabOrder = 7
            Transparent = True
            OnClick = chbxPrintStyleShowResourceImagesClick
            Width = 306
          end
          object chbxPrintStyleDailyShowEventImages: TcxCheckBox
            Left = 14
            Top = 269
            Caption = 'Show event images'
            TabOrder = 8
            Transparent = True
            OnClick = chbxPrintStyleShowEventImagesClick
            Width = 306
          end
          object lbViewDaily: TcxLabel
            Left = 9
            Top = 204
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'View'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object lbImagesDaily: TcxLabel
            Left = 9
            Top = 249
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Images '
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object lbOptionsDaily: TcxLabel
            Left = 9
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Options'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
        end
        object tshWeekly: TcxTabSheet
          Caption = 'Weekly'
          ImageIndex = 1
          TabVisible = False
          object lblPrintStyleWeeklyPrintTo: TLabel
            Left = 20
            Top = 220
            Width = 41
            Height = 13
            Caption = 'Print &To:'
            FocusControl = tePrintStyleWeeklyPrintTo
            Transparent = True
          end
          object lblPrintStyleWeeklyPrintFrom: TLabel
            Left = 20
            Top = 193
            Width = 53
            Height = 13
            Caption = 'Print &From:'
            FocusControl = tePrintStyleWeeklyPrintFrom
            Transparent = True
          end
          object lblPrintStyleWeeklyInclude: TLabel
            Left = 20
            Top = 131
            Width = 39
            Height = 13
            Caption = 'Include:'
            Transparent = True
          end
          object lblPrintStyleWeeklyLayout: TLabel
            Left = 20
            Top = 58
            Width = 37
            Height = 13
            Caption = 'La&yout:'
            FocusControl = cbxPrintStyleWeeklyLayout
            Transparent = True
          end
          object lblPrintStyleWeeklyArrange: TLabel
            Left = 20
            Top = 33
            Width = 43
            Height = 13
            Caption = '&Arrange:'
            FocusControl = cbxPrintStyleWeeklyArrange
            Transparent = True
          end
          object lblPrintStyleWeeklyResourceCountPerPage: TLabel
            Left = 20
            Top = 107
            Width = 82
            Height = 13
            Caption = 'Resources/Page:'
            FocusControl = sePrintStyleWeeklyResourceCountPerPage
            Transparent = True
          end
          object lblPrintStyleWeeklyDaysLayout: TLabel
            Left = 20
            Top = 83
            Width = 61
            Height = 13
            Caption = '&Days layout:'
            FocusControl = cbxPrintStyleWeeklyDaysLayout
            Transparent = True
          end
          object tePrintStyleWeeklyPrintTo: TcxTimeEdit
            Tag = 1
            Left = 114
            Top = 217
            EditValue = 0.000000000000000000
            Properties.TimeFormat = tfHourMin
            Properties.OnChange = tePrintStylePrintRangePropertiesChange
            Properties.OnEditValueChanged = tePrintStylePrintRangePropertiesEditValueChanged
            TabOrder = 8
            Width = 100
          end
          object tePrintStyleWeeklyPrintFrom: TcxTimeEdit
            Left = 114
            Top = 190
            EditValue = 0.000000000000000000
            Properties.TimeFormat = tfHourMin
            Properties.OnChange = tePrintStylePrintRangePropertiesChange
            Properties.OnEditValueChanged = tePrintStylePrintRangePropertiesEditValueChanged
            TabOrder = 7
            Width = 100
          end
          object chbxPrintStyleWeeklyNotesAreaLined: TcxCheckBox
            Tag = 2
            Left = 113
            Top = 167
            Caption = 'Notes Area (&Lined)'
            TabOrder = 6
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 177
          end
          object chbxPrintStyleWeeklyNotesAreaBlank: TcxCheckBox
            Tag = 1
            Left = 113
            Top = 147
            Caption = 'Notes Area (&Blank)'
            TabOrder = 5
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 177
          end
          object cbxPrintStyleWeeklyArrange: TcxComboBox
            Left = 114
            Top = 29
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            Properties.Items.Strings = (
              'Top to Bottom'
              'Left to Right')
            TabOrder = 0
            OnClick = cbxPrintStyleWeeklyArrangeClick
            Width = 173
          end
          object cbxPrintStyleWeeklyLayout: TcxComboBox
            Left = 114
            Top = 54
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            Properties.Items.Strings = (
              '1 page/day'
              '2 pages/day')
            TabOrder = 1
            OnClick = cbxPrintStyleWeeklyLayoutClick
            Width = 173
          end
          object chbxPrintStyleWeeklyTaskPad: TcxCheckBox
            Left = 113
            Top = 127
            Caption = 'TaskPad'
            TabOrder = 4
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 177
          end
          object chbxPrintStyleWeeklyDontPrintWeekends: TcxCheckBox
            Left = 18
            Top = 254
            Caption = 'Don'#39't Print &Weekends'
            TabOrder = 9
            Transparent = True
            OnClick = chbxPrintStyleWeeklyDontPrintWeekendsClick
            Width = 266
          end
          object sePrintStyleWeeklyResourceCountPerPage: TcxSpinEdit
            Tag = 1
            Left = 114
            Top = 104
            Properties.OnChange = sePrintStyleResourceCountPerPagePropertiesChanged
            Properties.OnEditValueChanged = sePrintStyleResourceCountPerPagePropertiesEditValueChanged
            TabOrder = 3
            Width = 100
          end
          object cbxPrintStyleWeeklyDaysLayout: TcxComboBox
            Left = 114
            Top = 79
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            Properties.Items.Strings = (
              'Two columns'
              'One column')
            TabOrder = 2
            OnClick = cbxPrintStyleWeeklyDaysLayoutClick
            Width = 173
          end
          object chbxPrintStyleWeeklyShowEventImages: TcxCheckBox
            Left = 18
            Top = 313
            Caption = 'Show Event Images'
            TabOrder = 11
            Transparent = True
            OnClick = chbxPrintStyleShowEventImagesClick
            Width = 264
          end
          object chbxPrintStyleWeeklyShowResourceImages: TcxCheckBox
            Left = 18
            Top = 293
            Caption = 'Show Resource Images'
            TabOrder = 10
            Transparent = True
            OnClick = chbxPrintStyleShowResourceImagesClick
            Width = 265
          end
          object Label5: TcxLabel
            Left = 9
            Top = 238
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'View'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object Label6: TcxLabel
            Left = 9
            Top = 275
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Images '
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object lbOptionsWeekly: TcxLabel
            Left = 9
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Options'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
        end
        object tshMonthly: TcxTabSheet
          Caption = 'Monthly'
          ImageIndex = 2
          TabVisible = False
          object lblPrintStyleMonthlyLayout: TLabel
            Left = 20
            Top = 34
            Width = 37
            Height = 13
            Caption = 'La&yout:'
            FocusControl = cbxPrintStyleMonthlyLayout
            Transparent = True
          end
          object lblPrintStyleMonthlyInclude: TLabel
            Left = 20
            Top = 86
            Width = 39
            Height = 13
            Caption = 'Include:'
            Transparent = True
          end
          object lblPrintStyleMonthlyResourceCountPerPage: TLabel
            Left = 20
            Top = 59
            Width = 82
            Height = 13
            Caption = 'Resources/Page:'
            FocusControl = sePrintStyleMonthlyResourceCountPerPage
            Transparent = True
          end
          object cbxPrintStyleMonthlyLayout: TcxComboBox
            Left = 114
            Top = 29
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            Properties.Items.Strings = (
              '1 page/month'
              '2 pages/month')
            TabOrder = 0
            OnClick = cbxPrintStyleMonthlyLayoutClick
            Width = 173
          end
          object chbxPrintStyleMonthlyTaskPad: TcxCheckBox
            Left = 113
            Top = 83
            Caption = 'Task&Pad'
            TabOrder = 2
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 174
          end
          object chbxPrintStyleMonthlyNotesAreaBlank: TcxCheckBox
            Tag = 1
            Left = 113
            Top = 104
            Caption = 'Notes Area (&Blank)'
            TabOrder = 3
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 174
          end
          object chbxPrintStyleMonthlyNotesAreaLined: TcxCheckBox
            Tag = 2
            Left = 113
            Top = 125
            Caption = 'Notes Area (&Lined)'
            TabOrder = 4
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 174
          end
          object chbxPrintStyleMonthlyDontPrintWeekends: TcxCheckBox
            Left = 18
            Top = 166
            Caption = 'Don'#39't Print &Weekends'
            TabOrder = 5
            Transparent = True
            OnClick = chbxPrintStyleDontPrintWeekEndsClick
            Width = 267
          end
          object chbxPrintStyleMonthlyPrintExactlyOneMonthPerPage: TcxCheckBox
            Left = 18
            Top = 187
            Caption = 'Print Exactly One Month Per Page'
            TabOrder = 6
            Transparent = True
            OnClick = chbxPrintStyleMonthlyPrintExactlyOneMonthPerPageClick
            Width = 267
          end
          object sePrintStyleMonthlyResourceCountPerPage: TcxSpinEdit
            Tag = 2
            Left = 114
            Top = 56
            Properties.OnChange = sePrintStyleResourceCountPerPagePropertiesChanged
            Properties.OnEditValueChanged = sePrintStyleResourceCountPerPagePropertiesEditValueChanged
            TabOrder = 1
            Width = 100
          end
          object chbxPrintStyleMonthlyShowEventImages: TcxCheckBox
            Left = 18
            Top = 250
            Caption = 'Show Event Images'
            TabOrder = 7
            Transparent = True
            OnClick = chbxPrintStyleShowEventImagesClick
            Width = 250
          end
          object chbxPrintStyleMonthlyShowResourceImages: TcxCheckBox
            Left = 18
            Top = 229
            Caption = 'Show Resource Images'
            TabOrder = 8
            Transparent = True
            OnClick = chbxPrintStyleShowResourceImagesClick
            Width = 250
          end
          object Label7: TcxLabel
            Left = 9
            Top = 147
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'View'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object Label8: TcxLabel
            Left = 9
            Top = 210
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Images '
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object lbOptionsMonthly: TcxLabel
            Left = 9
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Options'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
        end
        object tshTrifold: TcxTabSheet
          Caption = 'Tri-fold'
          ImageIndex = 3
          TabVisible = False
          object lblPrintStyleTrifoldSectionLeft: TLabel
            Left = 20
            Top = 33
            Width = 61
            Height = 13
            Caption = '&Left Section:'
            FocusControl = cbxPrintStyleTrifoldSectionLeft
            Transparent = True
          end
          object lblPrintStyleTrifoldSectionMiddle: TLabel
            Left = 20
            Top = 60
            Width = 72
            Height = 13
            Caption = '&Middle Section:'
            FocusControl = cbxPrintStyleTrifoldSectionMiddle
            Transparent = True
          end
          object lblPrintStyleTrifoldSectionRight: TLabel
            Left = 20
            Top = 87
            Width = 67
            Height = 13
            Caption = '&Right Section:'
            FocusControl = cbxPrintStyleTrifoldSectionRight
            Transparent = True
          end
          object cbxPrintStyleTrifoldSectionLeft: TcxComboBox
            Left = 103
            Top = 29
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            TabOrder = 0
            OnClick = cbxPrintStyleTrifoldSectionModeClick
            Width = 184
          end
          object cbxPrintStyleTrifoldSectionMiddle: TcxComboBox
            Tag = 1
            Left = 103
            Top = 56
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            TabOrder = 1
            OnClick = cbxPrintStyleTrifoldSectionModeClick
            Width = 184
          end
          object cbxPrintStyleTrifoldSectionRight: TcxComboBox
            Tag = 2
            Left = 103
            Top = 83
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            TabOrder = 2
            OnClick = cbxPrintStyleTrifoldSectionModeClick
            Width = 184
          end
          object lbOptionsTrifold: TcxLabel
            Left = 9
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Options'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
        end
        object tshDetails: TcxTabSheet
          Caption = 'Details'
          ImageIndex = 4
          TabVisible = False
          object chbxPrintStyleDetailsUsePagination: TcxCheckBox
            Left = 18
            Top = 29
            Caption = 'Start a New Page Each:'
            TabOrder = 0
            Transparent = True
            OnClick = chbxPrintStyleDetailsUsePaginationClick
            Width = 151
          end
          object cbxPrintStyleDetailsPagination: TcxComboBox
            Left = 167
            Top = 29
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            Properties.Items.Strings = (
              'Day'
              'Week'
              'Month')
            TabOrder = 1
            OnClick = cbxPrintStyleDetailsPaginationClick
            Width = 120
          end
          object lbOptionsDetails: TcxLabel
            Left = 9
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Options'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
        end
        object tshMemo: TcxTabSheet
          Caption = 'Memo'
          ImageIndex = 5
          TabVisible = False
          object chbxPrintStyleMemoStartEachItemOnNewPage: TcxCheckBox
            Left = 18
            Top = 29
            Caption = 'Start Each Item On New Page'
            TabOrder = 0
            Transparent = True
            OnClick = chbxPrintStyleMemoStartEachItemOnNewPageClick
            Width = 187
          end
          object chbxPrintStyleMemoPrintOnlySelectedEvents: TcxCheckBox
            Left = 18
            Top = 51
            Caption = 'Print Only Selected Events'
            State = cbsChecked
            TabOrder = 1
            Transparent = True
            OnClick = chbxPrintStyleMemoPrintOnlySelectedEventsClick
            Width = 187
          end
          object lbOptionsMemo: TcxLabel
            Left = 9
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Options'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
        end
        object tshYearly: TcxTabSheet
          Caption = 'Yearly'
          ImageIndex = 6
          TabVisible = False
          object lblPrintStyleYearlyMonthPerPage: TLabel
            Left = 20
            Top = 60
            Width = 67
            Height = 13
            Caption = '&Months/Page:'
            FocusControl = cbxPrintStyleYearlyMonthPerPage
            Transparent = True
          end
          object lblPrintStyleYearlyResourceCountPerPage: TLabel
            Left = 20
            Top = 86
            Width = 82
            Height = 13
            Caption = 'Resources/Page:'
            FocusControl = sePrintStyleYearlyResourceCountPerPage
            Transparent = True
            Visible = False
          end
          object lblPrintStyleYearlyInclude: TLabel
            Left = 20
            Top = 109
            Width = 39
            Height = 13
            Caption = 'Include:'
            Transparent = True
          end
          object lblPrintStyleYearlyLayout: TLabel
            Left = 20
            Top = 33
            Width = 37
            Height = 13
            Caption = 'La&yout:'
            FocusControl = cbxPrintStyleYearlyLayout
            Transparent = True
          end
          object cbxPrintStyleYearlyMonthPerPage: TcxComboBox
            Left = 119
            Top = 56
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            Properties.Items.Strings = (
              '1 page/year'
              '2 pages/year'
              '3 pages/year'
              '4 pages/year'
              '6 pages/year'
              '12 pages/year')
            TabOrder = 1
            Text = '12 pages/year'
            OnClick = cbxPrintStyleYearlyMonthPagesPerYearClick
            Width = 168
          end
          object sePrintStyleYearlyResourceCountPerPage: TcxSpinEdit
            Tag = 3
            Left = 119
            Top = 83
            Properties.OnChange = sePrintStyleResourceCountPerPagePropertiesChanged
            Properties.OnEditValueChanged = sePrintStyleResourceCountPerPagePropertiesEditValueChanged
            TabOrder = 2
            Visible = False
            Width = 100
          end
          object chbxPrintStyleYearlyTaskPad: TcxCheckBox
            Left = 118
            Top = 109
            Caption = 'Task&Pad'
            TabOrder = 3
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 173
          end
          object chbxPrintStyleYearlyNotesAreaBlank: TcxCheckBox
            Tag = 1
            Left = 118
            Top = 130
            Caption = 'Notes Area (&Blank)'
            TabOrder = 4
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 173
          end
          object chbxPrintStyleYearlyNotesAreaLined: TcxCheckBox
            Tag = 2
            Left = 118
            Top = 151
            Caption = 'Notes Area (&Lined)'
            TabOrder = 5
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 173
          end
          object cbxPrintStyleYearlyLayout: TcxComboBox
            Left = 119
            Top = 29
            Anchors = [akLeft, akTop, akRight]
            Properties.DropDownListStyle = lsFixedList
            Properties.ItemHeight = 15
            Properties.Items.Strings = (
              '1 page/month'
              '2 pages/month')
            TabOrder = 0
            Text = '1 page/month'
            OnClick = cbxPrintStyleYearlyLayoutClick
            Width = 168
          end
          object chbxPrimaryPageHeadersOnly: TcxCheckBox
            Left = 18
            Top = 192
            Caption = 'Primary Page Headers Only'
            TabOrder = 6
            Transparent = True
            OnClick = chbxPrimaryPageHeadersOnlyClick
            Width = 280
          end
          object chbxPrintStyleYearlyShowEventImages: TcxCheckBox
            Left = 18
            Top = 233
            Caption = 'Show Event Images'
            TabOrder = 7
            Transparent = True
            OnClick = chbxPrintStyleShowEventImagesClick
            Width = 280
          end
          object Label9: TcxLabel
            Left = 9
            Top = 173
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'View'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object Label10: TcxLabel
            Left = 9
            Top = 214
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Images '
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object lbOptionsYear: TcxLabel
            Left = 9
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Options'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
        end
        object tshTimeLine: TcxTabSheet
          Caption = 'TimeLine'
          ImageIndex = 7
          TabVisible = False
          object lblPrintStyleTimeLineResourceCountPerPage: TLabel
            Left = 20
            Top = 34
            Width = 82
            Height = 13
            Caption = 'Resources/Page:'
            FocusControl = sePrintStyleTimeLineResourceCountPerPage
            Transparent = True
          end
          object lblPrintStyleTimeLineInclude: TLabel
            Left = 20
            Top = 54
            Width = 39
            Height = 13
            Caption = 'Include:'
            Transparent = True
          end
          object lblPrintStyleTimeLinePrintFrom: TLabel
            Left = 20
            Top = 120
            Width = 53
            Height = 13
            Caption = 'Print &From:'
            FocusControl = tePrintStyleTimeLinePrintFrom
            Transparent = True
          end
          object lblPrintStyleTimeLinePrintTo: TLabel
            Left = 20
            Top = 147
            Width = 41
            Height = 13
            Caption = 'Print &To:'
            FocusControl = tePrintStyleTimeLinePrintTo
            Transparent = True
          end
          object sePrintStyleTimeLineResourceCountPerPage: TcxSpinEdit
            Tag = 4
            Left = 122
            Top = 29
            Properties.OnChange = sePrintStyleResourceCountPerPagePropertiesChanged
            Properties.OnEditValueChanged = sePrintStyleResourceCountPerPagePropertiesEditValueChanged
            TabOrder = 0
            Width = 100
          end
          object chbxPrintStyleTimeLineTaskPad: TcxCheckBox
            Left = 121
            Top = 51
            Caption = 'Task&Pad'
            TabOrder = 1
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 165
          end
          object chbxPrintStyleTimeLineNotesAreaBlank: TcxCheckBox
            Tag = 1
            Left = 121
            Top = 72
            Caption = 'Notes Area (&Blank)'
            TabOrder = 2
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 165
          end
          object chbxPrintStyleTimeLineNotesAreaLined: TcxCheckBox
            Tag = 2
            Left = 121
            Top = 93
            Caption = 'Notes Area (&Lined)'
            TabOrder = 3
            Transparent = True
            OnClick = chbxPrintStyleOptionsViewClick
            Width = 165
          end
          object tePrintStyleTimeLinePrintFrom: TcxTimeEdit
            Left = 122
            Top = 117
            EditValue = 0.000000000000000000
            Properties.TimeFormat = tfHourMin
            Properties.OnChange = tePrintStylePrintRangePropertiesChange
            Properties.OnEditValueChanged = tePrintStylePrintRangePropertiesEditValueChanged
            TabOrder = 4
            Width = 100
          end
          object tePrintStyleTimeLinePrintTo: TcxTimeEdit
            Tag = 1
            Left = 122
            Top = 144
            EditValue = 0.000000000000000000
            Properties.ImmediatePost = True
            Properties.TimeFormat = tfHourMin
            Properties.OnChange = tePrintStylePrintRangePropertiesChange
            Properties.OnEditValueChanged = tePrintStylePrintRangePropertiesEditValueChanged
            TabOrder = 5
            Width = 100
          end
          object chbxPrintStyleTimeLineShowResourceImages: TcxCheckBox
            Left = 18
            Top = 290
            Caption = 'Show Resource Images'
            TabOrder = 10
            Transparent = True
            OnClick = chbxPrintStyleShowResourceImagesClick
            Width = 250
          end
          object chbxPrintStyleTimeLineShowEventImages: TcxCheckBox
            Left = 18
            Top = 311
            Caption = 'Show Event Images'
            TabOrder = 11
            Transparent = True
            OnClick = chbxPrintStyleShowEventImagesClick
            Width = 250
          end
          object chbxPrintStyleTimeLinePrimaryPageHeadersOnly: TcxCheckBox
            Left = 18
            Top = 208
            Caption = 'Primary Page Headers Only'
            TabOrder = 7
            Transparent = True
            OnClick = chbxPrimaryPageHeadersOnlyClick
            Width = 194
          end
          object chbxPrintStyleTimeLinePrimaryPageScalesOnly: TcxCheckBox
            Left = 18
            Top = 187
            Caption = 'Primary Page Scales Only'
            TabOrder = 6
            Transparent = True
            OnClick = chbxPrimaryPageScalesOnlyClick
            Width = 194
          end
          object chbxPrintStyleTimeLineDontPrintWeekends: TcxCheckBox
            Left = 18
            Top = 229
            Caption = 'Don'#39't Print &Weekends'
            TabOrder = 8
            Transparent = True
            OnClick = chbxPrintStyleDontPrintWeekEndsClick
            Width = 194
          end
          object chbxPrintStyleTimeLineWorkTimeOnly: TcxCheckBox
            Left = 18
            Top = 250
            Caption = 'W&ork Time Only'
            TabOrder = 9
            Transparent = True
            OnClick = chbxPrintStyleWorkTimeOnlyClick
            Width = 194
          end
          object Label2: TcxLabel
            Left = 9
            Top = 169
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'View'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object lbTimeLineImages: TcxLabel
            Left = 9
            Top = 271
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Images '
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
          object lbOptionsTimeLine: TcxLabel
            Left = 9
            Top = 8
            Anchors = [akLeft, akTop, akRight]
            AutoSize = False
            Caption = 'Options'
            Properties.LineOptions.Visible = True
            Transparent = True
            Height = 18
            Width = 279
          end
        end
      end
      object lblPreviewWindow: TcxLabel
        Left = 320
        Top = 2
        TabStop = False
        Caption = 'Preview'
        Transparent = True
      end
      object pnlPrintStylesPreview: TcxGroupBox
        Left = 321
        Top = 19
        PanelStyle.Active = True
        ParentBackground = False
        ParentColor = False
        Style.Color = clWindow
        TabOrder = 2
        Height = 385
        Width = 271
        object pnlPrintStylesPreviewContainer: TPanel
          Left = 2
          Top = 2
          Width = 267
          Height = 381
          Align = alClient
          BevelOuter = bvNone
          Color = clWindow
          ParentBackground = False
          TabOrder = 0
          object pbxPrintStylesPreview: TPaintBox
            Left = 0
            Top = 0
            Width = 267
            Height = 381
            Align = alClient
            OnPaint = pbxPrintStylesPreviewPaint
          end
        end
      end
    end
    object tshFormatting: TcxTabSheet
      Caption = 'Formatting'
      ImageIndex = 2
      object imgLookAndFeel: TImage
        Left = 10
        Top = 31
        Width = 48
        Height = 48
        Picture.Data = {
          055449636F6E0000010001003030000001002000A82500001600000028000000
          3000000060000000010020000000000080250000000000000000000000000000
          00000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF000000000100000001000000010000000200000002
          0000000200000002000000010000000100000000000000000000000000000000
          00000000000000000000000000000000000000000000000000000000FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          00000001000000020000000300000005000000080000000A0000000B0000000C
          0000000C0000000C000000090000000700000004000000020000000100000000
          00000000000000000000000000000000000000000000000000000000FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000030000000400000006
          0000000C00000016000000200000002B000000360000003C0000004200000045
          00000046000000420000003B00000033000000270000001D000000140000000B
          00000006000000030000000300000000000000000000000000000000FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000B000000100000001D
          000000330000004C0208116D081F40AC0A244DD00B2957EA0A2756EC092B5FFF
          092B5EFF082654EE07224EE0061B3DBE020D1E8A0000005F000000470000002D
          0000001A0000000E0000000B0C4092000C4092000C4092000C409200FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000010000000E0000001A00000033
          0C264B820F376FD317427EFC215997FF2767A6FF2D75B8FF2B73B6FF3180C8FF
          2E7EC6FF3579B9FF3A76B0FF275B96FF123D78FF08295FE3061C419E0102054D
          0000002E000000170000000E00000001EAF3FB00EAF3FB000C409200FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00000000010000000100000001000000010000000100000001
          000000010000000200000002000000030000000600000014040B152F16498DBD
          366DB3FF3A82C5FF489AD9FF479DDBFF459ADBFF4097D8FF3E96D9FF3A92D6FF
          509DDBFF61A7DEFF589FD9FF5096D3FF4B90D0FF2E76BDFF1653A1FF0B3981E0
          061C416A00000029000000140000000500000002EAF3FB000C409200FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          00000001000000090000001B0000002400000026000000270000002700000027
          0000002700000027000000270000002A00000030010408451C5196CE81ACD9FF
          5AAEE6FF5AB0E9FF56ADE7FF51A8E4FF4398D8FF3184CBFF2F82CAFF4A97D6FF
          6FB6E7FF6BB2E4FF66AEE2FF61ABE2FF4497DAFF2D83D2FF2B7FCEFF2572C1FF
          124C9CFD09316FA60000002D0000001300000005000000020C409200FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          0000000300000020000000610000007C00000080000000820000008100000082
          000000820000008300000083000000850000008C0F2B51BD6691CAFF86CAF2FF
          64B9EEFF5FB5EBFF5AB2E9FF44A4A3FF1F8F2EFF1C8B30FF2B8B70FF589DD6FF
          77B9E9FF70B6E6FF6AB1E4FF4C9DDEFF328DDBFF328DDBFF318AD8FF2C81D0FF
          2B7ECCFF1C61B2FF0A3477B90000002E000000130000000500000001FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000700000030643F2CDA764A33FF764A32FF754A32FF754932FF754931FF
          754831FF734831FF734730FF71452FFF68402BFF2D5692FFC2D6EDFF72C4F2FF
          68BEF0FF63B9EEFF5EB5EBFF349E4EFF7FD089FF64C170FF208E35FF75B7E7FF
          7CBFEBFF66A7DCFF3E88CCFF2777C6FF297BCAFF2F87D5FF328DDBFF328DDBFF
          2F89DAFF2C85D8FF1F69BBFF0A3579BC0000002B0000000F0000000300000001
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000A0000002F774C34FFEAE2DCFFE0D4CCFFE0D4CBFFE0D4CAFFE0D4CAFF
          A58A84FFDFD3C9FFDED2C7FFD9CDC3FFC6BCB3FF2763B4FFEAF5FBFF75C7F4FF
          6DC1F2FF68BDF0FF64B9EDFF41A770FF34A049FF46A76AFF69B9B1FF89C8F1FF
          3E957FFF0F7A2CFF087618FF0F763EFF1E7696FF2879C8FF328DDBFF3391E2FF
          2B83D5FF2B83D5FF2C85D8FF1E5EACFF092D6894000000200000000900000002
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000B0000002D784D36FFF6F2EDFFF2ECE5FFF1EAE4FFF1EBE4FFF0EAE3FF
          A58B84FFF1E9E3FFEFE8E1FFEBE4DCFFD8D2CBFF2866B6FFEBF5FBFF97D5F8FF
          71C5F4FF6DC1F2FF69BEF0FF84CAF4FF9FD8F8FF9AD3F7FF95D2F5FF51A78EFF
          349B42FF2DA23FFF29A13AFF299638FF0B7628FF2E85D2FF3391E2FF2B33B0FF
          2644B4FF277CCEFF3583CEFF4188C9FF124796F90417344C0000001300000005
          00000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000B0000002D794E37FFF6F2EEFFF2ECE6FFF2EBE5FFF1EBE4FFF1EAE4FF
          A68C84FFF1EAE3FFF1E9E2FFECE5DFFFE0D8D2FF527FB9FFB8CFEAFFF2FAFEFF
          EFF9FEFFF1F9FEFFEDF8FEFFE3F4FEFFBAE3FBFF9ED8F8FF9AD3F7FF178533FF
          5CBA69FF37AD49FF269936FF157A55FF23868EFF3594E4FF3273D6FF412AAEFF
          452DB2FF2C45B2FF3A81C4FF3F86C8FF2C6BB3FF0A3477B40000002200000008
          00000002FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000B0000002B7A4F37FFAB8E85FFAB8E85FFA98E85FFA98E85FFA88D85FF
          A78C85FFA68C84FFA68B84FFA48A83FFD3C7C0FFC9C9CAFF4A7BB9FF2966B9FF
          2261B4FF306AB8FF5584C4FFBACFE8FFF6FCFFFFBBE3FBFF77BFF0FF158636FF
          5ABA67FF58B866FF0F7C30FF3890DAFF3999E7FF389CECFF2F37B5FF573FBFFF
          553EC3FF371EAAFF345CB7FF3B80C3FF3E91D6FF0F4696F903122A3F0000000F
          00000002FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000A0000002A7B5039FFF7F3EFFFF2ECE6FFF3ECE6FFF2EBE6FFF2EBE5FF
          A88D85FFF1EAE4FFF1EAE3FFEFE8E2FFEDE7E1FFE8E0DBFFE0D9D3FFD6D1CDFF
          D7CFCAFFC6C4C4FF9FAABAFF4B75AFFFBACFE8FFF2FAFEFF7BBFEFFF3E9EB3FF
          17863DFF158439FF3595B2FF41A1EAFF41A3F0FF384CC4FF614AC5FF7560D0FF
          7A68D2FF6D5ACAFF2D1EA3FF3988CDFF3D9ADFFF1E61AFFF082C648300000017
          00000004FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000A000000287D5139FFF7F3EFFFF3EEE8FFF2ECE6FFF2ECE6FFF1ECE5FF
          A98E85FFF1EBE4FFF1EBE4FFF0EAE3FFEFE9E2FFEFE8E1FFAD9086FFEBE3DDFF
          EAE2DAFFE6E0D9FFE0D8D2FFCFC8C2FF4572B0FFBBD1EAFF99CFF5FF55ACEBFF
          50A8E9FF4BA4E7FF4AA7EEFF49ACF4FF4391E8FF472EB8FF5039BCFF3C24B0FF
          4028B0FF6D5ACAFF3F26ACFF3675CAFF42A0E3FF2E7BC4FF0A377BB90000001E
          00000007FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          00000009000000267D533BFFF8F3F0FFF3EDE8FFF3EDE8FFF3EDE7FFF2ECE6FF
          AA8E85FFF2EBE5FFF1EBE5FFF1EBE4FFF1EAE3FFF1EAE3FFAE9086FFEFE8E1FF
          EEE8E0FFEDE7DFFFE9E1DAFFD9D3CCFF6687B3FF95B5DCFF7BC3F2FF59B1EEFF
          54ADECFF53B0F2FF52B4F9FF4EB0F7FF49AAF4FF5592E1FF5E84D4FF64A0DDFF
          5991D8FF3B39B6FF3B22ABFF468DDEFF4EAFEFFF4B95D4FF0D3C89DC00000023
          00000008FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          00000009000000247E543BFFAE9187FFAE9086FFAE9086FFAD9086FFAC9085FF
          AB8F85FFAA8E85FFA98E85FFA98E85FFA88D85FFA78D84FFAE9086FFAE9187FF
          AE9086FFAD8F85FFCABAB1FFD7D1CAFF4273B4FF8BC0E9FF65B9F1FF5EB5EFFF
          72C3F7FF70C4FCFF57B8FAFF52B4F9FF68B9F1FF7BBDEAFF75B9E7FF68ADE1FF
          4994D3FF469DDFFF4A97E3FF57BAF6FF6ABEF2FF57A2DEFF0E4191F100000025
          0000000AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          00000009000000237F543DFFF8F4F0FFF4EFEAFFF4EEE9FFF3EDE8FFF3EDE7FF
          AC9086FFF2ECE6FFF2ECE5FFF2ECE5FFF1EBE5FFF1EBE4FFAE9086FFF0EAE3FF
          F0E8E2FFEBE4DDFFE0D8D2FF7091BCFF70A5DAFF6FC2F3FF6ABDF2FF8FC6F0FF
          D2E3F4FFEFF9FFFFC0E5FEFF75C3F5FF87C7F0FF81C2ECFF82AAC2FF9D5C1EFF
          8C663DFF618299FF459ADAFF72C4F6FF72C3F4FF57A7E2FF0F4395FB00000026
          00000009FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          000000080000002181553EFFF8F5F1FFF4EFEAFFF3EFE9FFF3EEE8FFF3EEE8FF
          AD9086FFF3EDE7FFF3ECE6FFF2ECE5FFF2ECE5FFF1EBE4FFAE9086FFF1EAE3FF
          EEE8E0FFE7E1DAFF7C9BC3FF8FB2DDFF7FCAF6FF75C6F4FF4F98DAFF386CB1FF
          3569B0FF618DC8FFEDF6FDFFC2E4F9FF8ECBF2FF87C7F0FF947B5BFFCC9661FF
          C5803DFF9A5C20FF57A0DBFF77C8F7FF6EC2F7FF46A0E1FF0F4596FB00000024
          00000009FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          000000080000002081563FFFF8F5F1FFF4EFEAFFF4EFEAFFF4EEE9FFF3EEE8FF
          AE9086FFF3EDE8FFF3EDE7FFF2EDE6FFF2ECE6FFF1ECE5FFAE9086FFF1EBE4FF
          EEE7E0FFE5DED8FF306FBEFFE9F3FBFF8BD1F8FF75C1F2FF367AC5FF96A4B6FF
          C8C3BCFF6C8AB2FF8EAED8FFDDF1FCFF94D0F4FF7FC9F4FFA16325FFDBA979FF
          CE8947FF9D5C1FFF67AFE4FF72C5F7FF5ABCF6FF4198DBFF0F4594EB0000001F
          00000008FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          000000070000001E825840FFB29489FFB19388FFB09288FFB09288FFB09188FF
          AF9187FFAE9087FFAE9086FFAC9086FFAC9086FFAB8F85FFAE9086FFB29489FF
          AF9287FFE3DCD6FF3D78C0FFDBEAF6FFC2E9FDFF76C1F0FF498FD2FF7290B8FF
          CAC5BFFF9AA6B6FF5786C5FFC5E6FAFF87CFF7FF7CB9D5FFB06B2AFFDAA36DFF
          C38141FF89745CFF73C2F3FF60BFF6FF59BAF4FF3684CAFF104089B900000018
          00000006FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          000000070000001C835841FFF8F6F2FFF5F0ECFFF5EFEBFFF5EFEAFFF4EFEAFF
          B09288FFF3EEE8FFF3EEE8FFF2EDE8FFF2ECE7FFF2ECE6FFAE9086FFF2EBE5FF
          F1E9E3FFEAE4DDFF8EA8CAFF84ACDCFFF1FAFFFF9DD6F7FF6CB7E9FF4181C9FF
          3A70B6FF3A6EB4FF74A9DBFF91D5F8FF7BCCF7FF968A70FFCD9864FFD9AA7BFF
          AB6C2FFF7CB3D2FF67C3F7FF63C1F6FF59B6EFFF316FB7FF0E38777600000010
          00000003FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          000000060000001A845A42FFF8F6F2FFF5F0EDFFF5F0EBFFF4EFEAFFF5F0EAFF
          B09288FFF3EFE9FFF3EEE8FFF3EDE8FFF2EDE8FFF2ECE7FFAE9086FFF2ECE6FF
          F0EAE5FFEFE8E2FFE3DEDAFF5C8BC6FFC0D6EFFFF1FAFFFFC4E4F7FF98C8EBFF
          82B7E3FF8EC4EBFF98D9FAFF82D0F9FF7FCEF8FF998E76FFA7692BFFA47340FF
          8CB4C3FF6EC7F8FF69C4F7FF66C2F7FF54A3DFFF184E9CDF030E1D2100000009
          00000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000600000018855B43FFF9F6F3FFF5F1EDFFF5F1ECFFF5F0ECFFF5F0EBFF
          B09388FFF4EFEAFFF4EFE9FFF3EEE8FFF3EEE8FFF3EDE7FFAE9086FFF2ECE6FF
          F2ECE6FFF1EBE4FFEDE7E0FFDAD9D8FF5A8AC5FF86ADDCFFEEF5FCFFEFF9FEFF
          CBEBFCFFA4DEFBFF89D3F9FF85D2F8FF85D1F8FF91D5F8FF91D5F9FF89D1F8FF
          75CAF7FF71C8F7FF6FC7F7FF90CCF3FF4172B5F90E346A520000000E00000004
          00000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000600000017875C44FFB6968BFFB5968AFFB3958AFFB39489FFB39489FF
          B29489FFB19388FFB09288FFB09288FFB09187FFAF9087FFAE9086FFB6968BFF
          B5968AFFB3958AFFB6988DFFDED2CAFFE3DFDAFF8CA7CBFF467FC7FFA5C2E5FF
          E7F2FAFFF4FBFEFFD6F0FDFFB9E6FBFFBCE5FBFFAADFFAFFA2DDF9FF94D6F9FF
          A7DDFAFFBFE5FAFF9CBBDFFF3165AEF4113B785B000000100000000600000001
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000001
          0000000500000015885D45FFFAF7F3FFF6F2EEFFF6F2EEFFF5F1ECFFF5F1ECFF
          B39489FFF5F0EBFFF4EFEBFFF4EFEAFFF4EFE9FFF4EEE9FFAE9086FFF3EEE7FF
          F3EDE7FFF2ECE7FFF2ECE5FFF1EAE4FFCAB8B0FFEAE4DEFFD0D3D6FF7197C6FF
          3471BEFF6192CFFF97B8E0FFA2BFE3FFC9DBF0FFCBDCEFFFC9DBEFFFA0BDE0FF
          7099CDFF2E67B2FD1A519DAF0E2F5B320000000E000000050000000100000000
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          0000000500000013885E46FFF9F7F4FFF7F2EEFFF7F2EEFFF6F2EDFFF5F2EDFF
          B3958AFFF5F0EBFFF5F0EBFFF4EFEBFFF4EFEAFFF4EEEAFFAE9086FFF3EDE8FF
          F3EDE8FFF3EDE7FFF3ECE6FFF2ECE6FFAE9086FFEFE9E2FFEDE7E0FFEAE3DDFF
          E6DFD8FFA1ACBCFF495B80FF2059A2B02361B1D12260B0D3215EB0D21E58A6A8
          1B50977410305B280000000F0000000900000004000000011852A500FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          0000000400000012895F47FFFAF7F4FFF7F3EFFFF7F3EFFFF6F2EEFFF6F2EDFF
          B5958AFFF6F0EDFFF5F0ECFFF5F0EBFFF4F0EBFFF4EFE9FFAE9086FFF4EEE8FF
          F4EEE8FFF3EDE7FFF3EDE7FFF2ECE6FFAE9086FFF2ECE5FFF0EAE3FFEFE9E2FF
          EEE7E1FFDBD0C6FF7B523BFF0000002A000000140000000E0000000C0000000B
          00000009000000060000000400000002000000010000000000000000FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          00000004000000108A6048FFB9988CFFB8988BFFB7978BFFB6978BFFB6978BFF
          B6978BFFB5968AFFB4958AFFB3958AFFB29489FFB29489FFAE9086FFB9988CFF
          B8988BFFB7978BFFB6978BFFB6978BFFAE9086FFB5968AFFB4958AFFB3958AFF
          B29489FFB19389FF80563EFF000000220000000B000000040000000300000002
          00000002000000010000000100000000000000000000000000000000FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          000000040000000E8A6149FFFAF8F6FFF7F4F0FFF7F4F0FFF7F3EFFFF7F3EEFF
          B6978BFFF6F1EEFFF5F1ECFFF5F1ECFFF5F0EBFFF5F0EBFFAE9086FFF4EFE9FF
          F3EFE9FFF4EEE9FFF3EEE8FFF3EDE8FFAE9086FFF3EDE6FFF2ECE6FFF2EBE5FF
          F2EBE5FFE0D4CBFF81573FFF0000001E00000008000000010000000000000000
          00000000000000000000000000000000000000000000000000000000FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          000000030000000D8B614AFFFAF8F6FFF8F5F1FFF8F4F1FFF7F4EFFFF7F3EFFF
          B7988BFFF6F2EEFFF6F2EEFFF5F1EDFFF6F0EDFFF5F0ECFFAE9086FFF5F0EAFF
          F4EFEAFFF4EEE9FFF4EEE9FFF3EDE9FFAE9086FFF2EDE7FFF3ECE7FFF2ECE6FF
          F2EBE5FFE0D4CCFF835840FF0000001D0000000700000001FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          000000030000000C8C624AFFFAF8F6FFF8F5F2FFF8F4F1FFF8F4F0FFF7F4F0FF
          B8988BFFF6F2EFFFF6F2EEFFF6F2EDFFF6F1EDFFF6F1ECFFAE9086FFF4F0EBFF
          F5EFEAFFF4EFEAFFF3EFEAFFF3EEE8FFAE9086FFF3EEE8FFF3EDE7FFF2EDE6FF
          F2ECE6FFE0D5CCFF835941FF0000001C0000000700000001FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          000000020000000A8D634BFFBB9A8DFFBA9A8DFFBA9A8DFFBA9A8CFFBA998CFF
          B9988CFFB8988CFFB8988BFFB7978BFFB6978BFFB5968AFFAE9086FFBB9A8DFF
          BA9A8DFFBA9A8DFFBA9A8CFFBA998CFFAE9086FFB8988CFFB8988BFFB7978BFF
          B6978BFFB5968AFF855A42FF0000001A0000000700000001FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          00000002000000088E644BFFFBF9F7FFF9F6F3FFF9F5F3FFF8F5F1FFF8F5F1FF
          BA9A8CFFF8F4F0FFF7F3EFFFF7F3EFFFF6F2EEFFF6F2EDFFAE9086FFF6F1ECFF
          F5F0ECFFF5EFEBFFF4EFEBFFF4EFEAFFAE9086FFF4EFE8FFF3EDE8FFF3EDE8FF
          F2EDE7FFE0D5CDFF855A44FF000000180000000600000001FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          00000002000000078E644CFFFBFAF8FFF9F6F3FFF9F6F3FFF9F5F3FFF8F5F2FF
          BA9A8DFFF8F4F0FFF7F4F0FFF7F3F0FFF6F3EEFFF6F3EEFFAE9086FFF5F1EDFF
          F5F1ECFFF6F1ECFFF4F0ECFFF4EFEBFFAE9086FFF4EEE9FFF4EFE9FFF3EEE8FF
          F3EEE7FFE1D6CEFF865C44FF000000170000000600000001FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          00000001000000068F644DFFFBFAF8FFF9F6F4FFF9F6F3FFF9F6F2FFF9F5F2FF
          BA9A8DFFF8F4F1FFF7F4F0FFF7F3F0FFF7F3F0FFF7F2EFFFAE9086FFF6F2EDFF
          F6F2EDFFF5F1EDFFF5F0EBFFF5F0EBFFAE9086FFF4EFEAFFF4EFE9FFF3EEE9FF
          F3EDE8FFE1D7CEFF875D45FF000000150000000500000001FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          0000000100000005985522FFD3893FFFD2893DFFD2883DFFD2883CFFD2863BFF
          D1853BFFD0843AFFD0843AFFD0843AFFCE8438FFCE8338FFCE8237FFCD8136FF
          CD8036FFCD7E34FFCD7E34FFCB7E34FFCB7B32FFCA7A33FFC87B32FFC87A31FF
          C8792FFFC8782FFF894918FF000000130000000500000001FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          0000000100000003985522FFE9C49FFFDEA871FFDEA870FFDEA76FFFDEA66EFF
          D1883BFFDDA56DFFDDA46CFFDCA36BFFDBA36AFFDCA36AFFCE8338FFDAA168FF
          DAA167FFDAA066FFDAA065FFD99F64FFCB7F34FFD99E62FFD89D61FFD79D60FF
          D79B5FFFC98F58FF894818FF000000120000000500000000FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          0000000000000002995524FFE9C5A0FFDEA972FFDFA871FFDEA771FFDEA76FFF
          D2883DFFDDA66EFFDDA56DFFDDA46CFFDCA36BFFDCA36AFFCE8439FFDBA269FF
          DAA168FFDAA167FFDAA065FFDAA065FFCD7E34FFD99F62FFD89D62FFD89D61FF
          D79D60FFC99059FF894918FF000000100000000400000000FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          00000000000000019B5624FFEAC5A0FFE9C59FFFE9C49FFFE9C49FFFE9C39FFF
          D2893DFFE9C39DFFE9C39DFFE8C29CFFE7C19BFFE7C19BFFD0843AFFE7C19AFF
          E7C099FFE6BF99FFE6BF98FFE6BF97FFCD7E34FFE6BE96FFE5BD95FFE5BD94FF
          E5BD94FFDBB48FFF894918FF0000000D0000000300000000FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000000
          00000000000000009B5725BD9A5624FF995623FF985522FF965421FF955421FF
          955321FF945320FF92511FFF92511FFF91501EFF904F1DFF8F4E1CFF8F4E1CFF
          8E4D1BFF8D4C1AFF8C4B1AFF8C4B19FF8B4A19FF8A4A18FF8A4A18FF894918FF
          8A4818FF894918FF854617C2000000080000000200000000FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          0000000000000000000000000000000100000001000000020000000200000002
          0000000300000003000000030000000400000004000000050000000500000006
          000000060000000700000007000000080000000800000008000000090000000A
          0000000A0000000A000000070000000300000001FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000001000000010000000100000001000000010000000100000001
          0000000100000001000000020000000200000002000000020000000200000002
          0000000200000002000000020000000100000000FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC0
          1FFFFFFFFFFFFE0003FFFFFFFFFFF000003FFFFFFFFFF000003FFFFFFFFFE000
          001FFFFFFF800000000FFFFFFE0000000007FFFFFE0000000003FFFFFC000000
          0001FFFFFC0000000001FFFFFC0000000000FFFFFC0000000000FFFFFC000000
          0000FFFFFC0000000000FFFFFC0000000000FFFFFC0000000000FFFFFC000000
          0000FFFFFC0000000000FFFFFC0000000000FFFFFC0000000000FFFFFC000000
          0000FFFFFC0000000000FFFFFC0000000000FFFFFC0000000001FFFFFC000000
          0001FFFFFC0000000003FFFFFE0000000007FFFFFE000000000FFFFFFE000000
          003FFFFFFE00000007FFFFFFFE00000007FFFFFFFE00000007FFFFFFFE000000
          07FFFFFFFE00000007FFFFFFFE00000007FFFFFFFE00000007FFFFFFFE000000
          07FFFFFFFE0000000FFFFFFFFF0000000FFFFFFFFF0000000FFFFFFFFF800000
          0FFFFFFFFFC000000FFFFFFFFFFF00001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF}
        Transparent = True
      end
      object imgRefinements: TImage
        Left = 10
        Top = 104
        Width = 48
        Height = 48
        Picture.Data = {
          055449636F6E0000010001003030000001002000A82500001600000028000000
          3000000060000000010020000000000080250000000000000000000000000000
          00000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          0000000100000001000000010000000100000001000000010000000100000001
          0000000100000001000000010000000100000001000000010000000100000001
          0000000100000001000000010000000100000001000000010000000100000001
          00000001000000010000000100000001000000010000000100000001FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000007
          000000170000001E0000001F0000002000000020000000200000002000000020
          00000021000000210000002100000021000000210000002100000021491F19FC
          0000002100000021000000210000002100000021000000220000002200000022
          0000002200000022000000220000002200000021000000200000001800000007
          00000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000100000019
          000000520000006B0000006F0000007000000071000000710000007100000071
          000000710000007100000071000000720000007200000072000000724A2019FF
          0000007200000072000000730000007300000073000000740000007400000074
          00000074000000740000007400000075000000740000006F000000550000001A
          00000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000030000001E
          3C25198B6D432DF373472FFF73462FFF72472FFF72472EFF72462EFF72462EFF
          71452EFF71452EFF71462DFF71452DFF71452DFF71442DFFD3C5BEFF4B2119FF
          BAA69FFF70442DFF70442CFF70442CFF70432CFF70432CFF70442CFF6F432CFF
          6F432CFF6F432BFF6F432BFF6F432BFF6E422BFF6A4029F73721159100000024
          0000000400000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000400000018
          7C543DEAF2EDEBFFE4D9D5FFE4D9D5FFE4D9D5FFE4D9D5FFE4D9D5FFE3D9D4FF
          E3D9D4FFE3D9D4FFE2D9D4FFE3D9D4FFE2D9D3FFE2D9D4FFF6F3F1FF4D211AFF
          D6CCC9FFE2D8D2FFE2D8D3FFE2D7D2FFE2D7D2FFE2D7D3FFE2D7D3FFE1D7D2FF
          E1D6D2FFE2D6D1FFE1D7D2FFE1D7D1FFE1D6D2FFD6C7C0FF714731EC0000001F
          0000000600000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000500000016
          8D624AFFFFFFFFFFF0EEEEFFEFEEEEFFEFEEEDFFEEEDEDFFEEEDEDFFEEEDEDFF
          EEECEDFFEEEDEDFFEEECECFFEDECECFFEEECECFFEEEBECFFF9F9F9FF4D231AFF
          D9D1CFFFECEBEBFFEDEBEAFFECEBEAFFECEAEAFFECEAEBFFECEAEAFFECEAEAFF
          ECEAE9FFECEAEAFFECE9EAFFECE9E9FFEBE8E6FFE2D6D2FF7C5039FF00000020
          0000000700000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000600000016
          8F654DFFFFFFFFFFEFEEEEFF997969FF774B34FF764B34FF764A33FF754A33FF
          754932FF744832FF744832FF734831FF734830FF724730FFD3C6BFFF4F241BFF
          BAA89FFF72452FFF71452EFF71452EFF70442EFF70442DFF70442CFF70442CFF
          6F432DFF6F432CFF6E432CFF927261FFECE9EAFFE1D6D1FF7E523BFF00000021
          0000000800000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000500000015
          906750FFFFFFFFFFEFEEEFFF784C35FFE9E2DCFFDFD4CCFFDFD3CBFFDFD3CAFF
          DFD3CAFFDED2C9FFDED2C9FFDED2C8FFDED1C8FFDED1C8FFF4F1EEFF50241BFF
          D6CAC6FFDDD1C6FFDDD0C6FFDDCFC6FFDDD0C6FFDCCFC4FFDCCEC5FFDCCFC4FF
          DBCFC4FFDBCEC4FFDBCEC3FF6F432CFFECE9EAFFE2D6D2FF80543CFF00000020
          0000000800000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000500000015
          926A51FFFFFFFFFFF0EFEFFF7A4E37FFF6F2EDFFF2ECE5FFF1EAE4FFF1EBE4FF
          F0EAE3FFF0E9E3FFF1E9E3FFF0E9E2FFF0E9E1FFEFE8E1FFFAF8F6FF52251CFF
          DBD0CCFFEEE7DEFFEFE6DEFFEEE6DEFFEDE5DEFFEDE5DDFFEDE5DDFFEDE5DCFF
          EDE4DCFFEDE4DCFFDCCEC4FF6F432DFFEBEAEAFFE1D6D2FF81563EFF0000001F
          0000000800000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000500000014
          956C54FFFFFFFFFFF0EFEFFF7A4F38FFF6F2EEFFF2ECE6FFF2EBE5FFF1EBE4FF
          F1EAE4FFF1EAE3FFF1EAE3FFF1E9E2FFF0E8E2FFF0E8E1FFFAF8F6FF53261DFF
          DBD1CDFFEFE7DFFFEEE7DFFFEFE6DFFFEEE6DEFFEEE6DDFFEEE5DDFFEEE5DDFF
          EDE5DDFFEDE4DCFFDBCEC3FF70442DFFECEAEAFFE1D7D2FF835941FF0000001E
          0000000800000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000500000013
          976F57FFFFFFFFFFF1EFEFFF7C5039FFF6F3EFFFF2ECE6FFF2ECE5FF4E8C44FF
          0D6204FF0C5F02FF0B5B01FF4B8241FFF1E9E2FFF0E9E2FFFAF8F6FF54281EFF
          DBD1CEFFEFE8E0FFEFE7E0FFEEE7DFFFEEE6DFFFEEE6DEFFEEE5DEFFEDE5DDFF
          EDE5DDFFEDE5DDFFDCCFC4FF71452EFFEDEAEAFFE2D7D2FF855B43FF0000001D
          0000000800000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000500000012
          997159FFFFFFFFFFF1F0EFFF7D523AFFF7F3EFFFF2ECE6FFF3ECE6FF0F6906FF
          79CB8EFF32AD51FF2BA94AFF0A5B01FFF0E9E3FFF0E9E3FFFAF8F6FF562A20FF
          DCD1CEFFF0E7E1FFEFE8E0FFEFE7DFFFEFE7DEFFEEE7DEFFEEE6DEFFEEE5DDFF
          EEE6DDFFEEE5DDFFDCCFC4FF72462FFFECEBEAFFE2D8D3FF885D45FF0000001C
          0000000700000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000400000011
          9C745CFFFFFFFFFFF0F0F0FF7E523BFFF7F3EFFFF3EEE8FFF2ECE6FF106C07FF
          7DCD92FF3AB258FF33AD51FF0C5E02FFF0EAE3FFF0EAE3FFFBF8F6FF592B20FF
          DCD1CEFFF0E8E0FFEFE8E1FFA2857BFFA08278FF9E7F75FF9B7D73FF9A7A71FF
          EEE5DEFFEEE6DDFFDCCFC5FF734630FFEDEAEBFFE2D8D3FF895F47FF0000001C
          0000000700000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000400000011
          9E775EFFFFFFFFFFF1F0F0FF7E533CFFF8F3F0FFF3EDE8FFF3EDE8FF117108FF
          7FCF94FF7DCD92FF79CB8DFF0C6104FFF1EBE4FFF1EAE3FFFBF8F6FF5B2B20FF
          DCD2CEFFEFE9E1FFEFE9E1FFF0E8E0FFEFE8E0FFEEE7DFFFEFE6DFFFEEE6DFFF
          EEE7DFFFEEE6DEFFDDCFC6FF744830FFEDEBEBFFE2D8D3FF8C614AFF0000001B
          0000000700000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000400000010
          9F7961FFFFFFFFFFF1F0F0FF80553DFFF8F4F0FFF4EEE8FFF4EEE8FF4D9342FF
          117108FF116C06FF0F6906FF49883FFFF2EBE5FFF1EAE4FFFBF8F6FF5B2C21FF
          DDD2CEFFF0E9E2FFEFE8E1FFEFE8E1FFEFE8E1FFEFE8E0FFEFE7DFFFEFE6DFFF
          EEE7DFFFEEE6DEFFDDCFC6FF754932FFEDEBEBFFE2D8D3FF8E634CFF0000001A
          0000000700000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000040000000F
          A17B63FFFFFFFFFFF2F1F1FF81563FFFF8F4F0FFF4EFEAFFF4EEE9FFF3EDE8FF
          F3EDE7FFF2ECE6FFF2ECE6FFF2ECE5FFF2ECE5FFF1EBE5FFFBF9F7FF5D2E22FF
          DDD2CEFFF1E9E3FFF0E9E2FFF0E8E1FFF0E8E1FFEFE8E0FFEFE7E0FFEFE7E0FF
          EFE6DFFFEEE6DEFFDDD0C6FF754A32FFEDECEBFFE2D8D3FF90664EFF00000019
          0000000600000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000040000000E
          A47E67FFFFFFFFFFF2F0F1FF815740FFF8F5F1FFF4EFEAFFF3EFE9FFF3EEE8FF
          F3EEE8FFF2EDE7FFF3EDE7FFF3ECE6FFF2ECE5FFF2ECE5FFFBF9F7FF5F2F22FF
          DED3CEFFF0EAE2FFF1EAE3FFF0E9E2FFF0E8E2FFEFE9E1FFEFE8E0FFEFE7E0FF
          EEE7DFFFEEE6DFFFDDD0C7FF764B33FFEDECEBFFE2D8D4FF916950FF00000018
          0000000600000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000030000000E
          A6816AFFFFFFFFFFF2F1F1FF835941FFF8F5F1FFF4EFEAFFF4EFEAFFF4EEE9FF
          F3EEE8FFF4EDE8FFF3EDE8FFF3EDE7FFF2EDE6FFF2ECE6FFFBF9F7FF613123FF
          DED4CFFFF1EAE3FFF1EAE3FFF1E9E2FFF0E9E2FFEFE8E2FFEFE8E1FFEFE8E0FF
          EFE7E0FFEFE7DFFFDDD1C7FF774C35FFEDEBEBFFE2D8D3FF946B53FF00000017
          0000000600000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000030000000D
          A8856CFFFFFFFFFFF2F1F1FF845A42FFF8F6F1FFF5F0EBFFF5EFEAFF4F8D46FF
          0D6204FF0C5F02FF0B5B01FF4C8342FFF3EDE7FFF3ECE6FFFBF9F7FF643224FF
          DFD4CFFFF1EAE4FFF1EAE4FFF1EAE3FFF1E9E2FFF1E9E2FFF0E9E1FFF0E9E1FF
          EFE8E0FFEFE7E0FFDED1C7FF784C35FFEEECECFFE2D9D4FF966E55FF00000016
          0000000600000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000030000000C
          AA886FFFFFFFFFFFF3F2F1FF855A43FFF8F6F2FFF5F0ECFFF5EFEBFF0F6906FF
          79CB8EFF32AD51FF2BA94AFF0A5B01FFF2EDE8FFF2ECE7FFFBF9F7FF663325FF
          DFD4D0FFF2EAE4FFF1EBE4FFF1EAE3FFF1EAE3FFF1E9E2FFF0E9E2FFF0E9E2FF
          EFE8E1FFEFE8E0FFDED1C7FF794E37FFEEECECFFE2D9D4FF987058FF00000015
          0000000600000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000030000000C
          AC8A72FFFFFFFFFFF3F2F2FF865C44FFF8F6F2FFF5F0EDFFF5F0EBFF106C07FF
          7DCD92FF3AB258FF33AD51FF0C5E02FFF3EDE8FFF2EDE8FFFBF9F8FF683526FF
          E0D4D0FFF1EBE6FFF2EBE5FFA3847BFFA08279FF9E7F76FF9C7C74FF9A7A72FF
          F0E9E2FFEFE8E1FFDED1C8FF7A4F38FFEEECECFFE3D9D4FF9B725AFF00000014
          0000000500000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000030000000B
          AF8D74FFFFFFFFFFF3F2F2FF875D44FFF9F6F3FFF5F1EDFFF5F1ECFF117108FF
          7FCF94FF7DCD92FF79CB8DFF0C6104FFF3EEE8FFF3EEE8FFFBF9F8FF693626FF
          E0D5D0FFF2ECE6FFF2ECE5FFF1EBE4FFF1EBE4FFF1EAE3FFF0E9E3FFF0E9E3FF
          F0E9E2FFEFE8E2FFDED1C8FF7B5139FFEEECECFFE3D9D4FF9D755DFF00000014
          0000000500000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000000030000000A
          B19079FFFFFFFFFFF3F2F2FF895D46FFF9F6F3FFF6F1EDFFF6F1EDFF4D9443FF
          117108FF116C06FF0F6906FF4A8940FFF4EFE9FFF3EEE8FFFBF9F8FF6C3827FF
          E0D5D1FFF3ECE6FFF2ECE6FFF2EBE5FFF2EBE5FFF1EBE4FFF1EAE4FFF0EAE3FF
          F0E9E2FFF0E9E2FFDED1C8FF7D523AFFEEECEDFFE4D9D4FF9F775FFF00000013
          0000000500000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000200000009
          B4937BFFFFFFFFFFF3F3F3FF895F47FFFAF7F3FFF6F2EEFFF6F2EEFFF5F1ECFF
          F5F1ECFFF5F0EBFFF5F0EBFFF4EFEBFFF4EFEAFFF4EFE9FFFCFAF8FF6E3A28FF
          E1D6D1FFF3EDE7FFF2ECE7FFF2ECE5FFF2EBE5FFF1EBE5FFF1EBE4FFF1EBE4FF
          F0EAE3FFF1E9E2FFDED2C9FF7D523BFFEFEDEDFFE3D9D5FFA07A62FF00000011
          0000000500000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000200000009
          B5957EFFFFFFFFFFF4F3F2FF8A6048FFF9F7F4FFF7F2EEFFF7F2EEFFF6F2EDFF
          F5F2EDFFF5F0ECFFF5F0EBFFF5F0EBFFF4EFEBFFF4EFEAFFFCFAF8FF6F3B29FF
          E1D6D1FFF3EDE8FFF3EDE7FFF3ECE6FFF2ECE6FFF2ECE5FFF1EBE4FFF1EBE4FF
          F1EAE4FFF1EAE3FFDED3C9FF7F543CFFEFEDEDFFE4D9D5FFA37C65FF00000011
          0000000400000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000200000008
          B79881FFFFFFFFFFF4F3F3FF8B6149FFFAF7F4FFF7F3EFFFF7F3EFFFF6F2EEFF
          F6F2EDFFF5F1EDFFF6F0EDFFF5F0ECFFF5F0EBFFF4F0EBFFFCFAF8FF723D2AFF
          E2D6D1FFF4EEE8FFF3EDE7FFF3EDE7FFF2ECE6FFF2ECE6FFF2ECE5FFF1EBE4FF
          F1EBE4FFF1EAE4FFDFD3CAFF80553DFFEFEEEEFFE3D9D5FFA57F69FF00000010
          0000000400000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000200000007
          B99A83FFFFFFFFFFF4F4F4FF8C614AFFFAF8F5FFF7F3F0FFF7F3EFFF508E47FF
          0D6204FF0C5F02FF0B5B01FF4C8443FFF5F0ECFFF4EFEBFFFCFAF8FF743D2BFF
          E2D7D1FFF3EEE8FFF3EDE8FFF3EDE8FFF3ECE7FFF2ECE6FFF2EBE6FFF2EBE5FF
          F1EBE5FFF1EBE4FFDFD3CBFF81563EFFEFEDEDFFE4DAD5FFA8846BFF0000000F
          0000000400000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000200000007
          BB9D88FFFFFFFFFFF5F3F4FF8C624AFFFAF8F6FFF7F4F0FFF7F4F0FF0F6906FF
          79CB8EFF32AD51FF2BA94AFF0A5B01FFF5F1ECFFF5F0EBFFFCFAF9FF753F2BFF
          E3D7D2FFF3EFE9FFF4EEE9FFF3EEE8FFF3EDE8FFF2EDE7FFF3EDE6FFF2ECE6FF
          F2EBE5FFF2EBE5FFDFD4CBFF825840FFF0EEEEFFE4DAD5FFA9856EFF0000000E
          0000000400000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000100000006
          BD9F8AFFFFFFFFFFF4F4F4FF8D634BFFFAF8F6FFF8F5F1FFF8F4F1FF106C07FF
          7DCD92FF3AB258FF33AD51FF0C5E02FFF5F1EDFFF6F0EDFFFCFAF9FF76402CFF
          E3D7D2FFF4EFEAFFF4EEE9FFA2857BFFA08279FF9E7F76FF9C7D74FF9A7A72FF
          F2ECE6FFF2EBE5FFDFD4CCFF835841FFEFEEEEFFE4DAD5FFAB8A70FF0000000D
          0000000300000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000100000005
          BFA28DFFFFFFFFFFF5F4F4FF8D644CFFFAF8F6FFF8F5F2FFF8F4F1FF117108FF
          7FCF94FF7DCD92FF79CB8DFF0C6104FFF6F2EDFFF6F1EDFFFCFBF9FF79422DFF
          E4D8D3FFF5EFEAFFF4EFEAFFF3EFEAFFF3EEE8FFF3EDE8FFF3EEE8FFF3EDE7FF
          F2EDE6FFF2ECE6FFE0D5CCFF855A42FFF0EFEEFFE5DBD5FFAE8C73FF0000000C
          0000000300000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000100000005
          C1A590FFFFFFFFFFF6F4F5FF8E644CFFFAF9F7FFF9F5F2FFF8F5F2FF4E9544FF
          117108FF116C06FF0F6906FF4A8A42FFF7F2EEFFF6F2EDFFFCFBF9FF7C432EFF
          E4D8D3FFF4F0EBFFF5F0EBFFF5EFEAFFF4EFE9FFF3EEE9FFF3EDE8FFF3EDE7FF
          F2ECE7FFF2ECE7FFE0D5CDFF855B43FFF0EFEFFFE4DAD6FFB18E75FF0000000B
          0000000300000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000100000004
          C3A793FFFFFFFFFFF6F5F5FF8E654DFFFBF9F7FFF9F6F3FFF9F5F3FFF8F5F1FF
          F8F5F1FFF8F4F1FFF8F4F0FFF7F3EFFFF7F3EFFFF6F2EEFFFCFBF9FF7D4430FF
          E4D9D3FFF5F0ECFFF5EFEBFFF4EFEBFFF4EFEAFFF4EEE9FFF4EFE8FFF3EDE8FF
          F3EDE8FFF2EDE7FFE0D5CDFF875C44FFF1EFEFFFE5DBD6FFB2917AFF0000000B
          0000000300000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000100000004
          C5AA97FFFFFFFFFFF5F5F5FF8F654DFFFBFAF8FFF9F6F3FFF9F6F3FFF9F5F3FF
          F8F5F2FFF7F5F1FFF8F4F0FFF7F4F0FFF7F3F0FFF6F3EEFFFCFBFAFF7E4630FF
          E5D9D3FFF5F1ECFFF6F1ECFFF4F0ECFFF4EFEBFFF4EFEAFFF4EEE9FFF4EFE9FF
          F3EEE8FFF3EEE7FFE1D6CDFF875D45FFF0EFEFFFE5DBD6FFB4947DFF00000009
          0000000300000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000100000003
          C8AC99FFFFFFFFFFF6F5F5FF8F654DFFFBFAF8FFF9F6F4FFF9F6F3FFF9F6F2FF
          F9F5F2FFF8F5F1FFF8F4F1FFF7F4F0FFF7F3F0FFF7F3F0FFFDFBFAFF814730FF
          E5D9D3FFF6F2EDFFF5F1EDFFF5F0EBFFF5F0EBFFF5F0EBFFF4EFEAFFF4EFE9FF
          F3EEE9FFF3EDE8FFE1D7CEFF885E46FFF0EFF0FFE6DBD7FFB69780FF00000009
          0000000200000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000100000003
          C9AE9BFFFFFFFFFFF6F6F5FF9A5624FFD3893FFFD2893DFFD2883DFFD2883CFF
          D2863BFFD1853BFFD0843AFFD0843AFFD0843AFFCE8438FFF0D9C1FF824730FF
          DBBDA6FFCD8036FFCD7E34FFCD7E34FFCB7E34FFCB7B32FFCA7A33FFC87B32FF
          C87A31FFC8792FFFC8782FFF894918FFF1EFF0FFE6DCD6FFB99A82FF00000008
          0000000200000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000002
          CAB09EFFFFFFFFFFF6F6F5FF9A5624FFE9C49FFFDEA871FFDEA870FFDEA76FFF
          DEA66EFFDDA76EFFDDA56DFFDDA46CFFDCA36BFFDBA36AFFF4E2D1FF834932FF
          DFC6B2FFDAA167FFDAA066FFDAA065FFD99F64FFD99F62FFD99E62FFD89D61FF
          D79D60FFD79B5FFFC98E58FF894918FFF1F0F0FFE6DCD7FFBA9C87FF00000007
          0000000200000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000002
          CCB4A2FFFFFFFFFFF7F6F6FF9A5624FFE9C5A0FFDEA972FFDFA871FFDEA771FF
          DEA76FFFDEA76FFFDDA66EFFDDA56DFFDDA46CFFDCA36BFFF4E2D1FF854B33FF
          DFC6B3FFDAA168FFDAA167FFDAA065FFDAA065FFDA9F64FFD99F62FFD89D62FF
          D89D61FFD79D60FFC98F59FF894918FFF1F0F1FFE6DCD7FFBC9F89FF00000006
          0000000200000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000001
          CEB7A4FFFFFFFFFFF7F6F6FF9A5624FFEAC5A0FFE9C59FFFE9C49FFFE9C49FFF
          E9C39FFFE9C39DFFE9C39DFFE9C39DFFE8C29CFFE7C19BFFF8ECE0FF874B33FF
          E3CEC0FFE7C099FFE6BF99FFE6BF98FFE6BF97FFE6BF97FFE6BE96FFE5BD95FF
          E5BD94FFE5BD94FFDBB48FFF894918FFF1F0F1FFE7DDD8FFBEA18CFF00000006
          0000000100000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000001
          CFB9A7FFFFFFFFFFF7F7F7FFB27F5BFF9A5624FF9A5624FF9A5624FF9A5624FF
          9A5624FF995523FF995523FF985522FF975321FF965221FFDEC9BAFF884C34FF
          CDB2A0FF8F4E1DFF8E4D1CFF8D4D1AFF8C4B1AFF8B4A1AFF8A4A18FF894918FF
          894918FF894918FF894918FFA47450FFF2F1F0FFE7DCD7FFC0A38FFF00000005
          0000000100000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000
          D0BBAAFFFFFFFFFFF9F9F9FFF7F6F7FFF7F6F7FFF7F6F6FFF6F5F6FFF6F5F6FF
          F6F6F5FFF6F5F5FFF6F5F5FFF5F5F5FFF5F5F4FFF5F4F4FFFCFCFCFF8A4D34FF
          E7DAD6FFF5F3F4FFF4F3F3FFF4F3F4FFF3F3F3FFF3F3F3FFF4F3F2FFF3F2F2FF
          F3F2F2FFF3F2F1FFF3F1F2FFF2F1F2FFF2F1F1FFE7DDD7FFC2A690FF00000005
          0000000100000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000
          D2BDACE7F5F1EDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8B4E35FF
          E9DED9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3EDE9FFC3A794E800000003
          0000000100000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000
          D4BFAE3FD3BFADC9D3BEADFFD2BDADFFD2BCACFFD1BCACFFD1BCABFFD0BBAAFF
          D0BBAAFFD0BAA8FFCFB9A7FFCFB8A7FFCFB8A5FFCFB7A4FFF0E9E2FF8C4F36FF
          DDCBC2FFCCB4A2FFCCB3A2FFCCB1A1FFCBB1A0FFCAB09EFFCAB09EFFCAAF9DFF
          C9AF9BFFC9AD9BFFC8AD9BFFC8AD99FFC7AC98FFC5AA97D7BAA08F4300000002
          0000000000000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000
          0000000000000000000000000000000000000000000000000000000000000001
          000000010000000100000001000000010000000100000001000000028D5036FF
          0000000200000002000000020000000200000002000000020000000300000003
          0000000300000003000000030000000300000003000000030000000200000001
          00000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000000000000000000000000000000000000000000000000000000008E5137FC
          0000000000000000000000000000000000000001000000010000000100000001
          0000000100000001000000010000000100000001000000010000000000000000
          00000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00
          FFFFFF00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE00000003FFFFFFFC000000
          00FFFFFFF800000000FFFFFFF8000000007FFFFFF8000000007FFFFFF8000000
          007FFFFFF8000000007FFFFFF8000000007FFFFFF8000000007FFFFFF8000000
          007FFFFFF8000000007FFFFFF8000000007FFFFFF8000000007FFFFFF8000000
          007FFFFFF800000000FFFFFFF800000000FFFFFFF800000000FFFFFFF8000000
          00FFFFFFF800000000FFFFFFF800000000FFFFFFF800000000FFFFFFF8000000
          00FFFFFFF800000000FFFFFFF800000000FFFFFFF800000000FFFFFFF8000000
          00FFFFFFF800000000FFFFFFF800000000FFFFFFF800000000FFFFFFF8000000
          00FFFFFFF800000000FFFFFFF800000000FFFFFFF800000000FFFFFFF8000000
          00FFFFFFF800000000FFFFFFFC00000000FFFFFFFC00000000FFFFFFFC000000
          00FFFFFFFC00000000FFFFFFFE00000000FFFFFFFE00000000FFFFFFFE000000
          01FFFFFFFFFC000001FFFFFFFFFFFDE007FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFF}
        Transparent = True
      end
      object cbxLookAndFeel: TcxComboBox
        Left = 75
        Top = 32
        AutoSize = False
        Properties.DropDownListStyle = lsFixedList
        Properties.ItemHeight = 15
        Properties.OnChange = cbxLookAndFeelPropertiesChange
        TabOrder = 0
        OnClick = LookAndFeelChange
        Height = 23
        Width = 235
      end
      object chbxSuppressBackgroundBitmaps: TcxCheckBox
        Tag = 1
        Left = 73
        Top = 101
        Caption = 'Suppress Background Textures'
        TabOrder = 1
        Transparent = True
        OnClick = OptionsFormattingClick
        Width = 200
      end
      object chbxSuppressContentColoration: TcxCheckBox
        Tag = 2
        Left = 73
        Top = 123
        Caption = 'Suppress Content Coloration'
        TabOrder = 2
        Transparent = True
        OnClick = OptionsFormattingClick
        Width = 200
      end
      object lblLookAndFeel: TcxLabel
        Left = 10
        Top = 11
        AutoSize = False
        Caption = 'Look and Feel'
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 18
        Width = 301
      end
      object lblRefinements: TcxLabel
        Left = 10
        Top = 84
        AutoSize = False
        Caption = 'Refinements'
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 18
        Width = 301
      end
    end
    object tshStyles: TcxTabSheet
      Caption = 'Styles'
      ImageIndex = 1
      object bvlStylesHost: TBevel
        Left = 9
        Top = 32
        Width = 223
        Height = 224
      end
      object cbxStyleSheets: TcxComboBox
        Left = 10
        Top = 318
        Properties.DropDownListStyle = lsFixedList
        Properties.ItemHeight = 20
        Properties.OnDrawItem = cbxStyleSheetsPropertiesDrawItem
        Style.TransparentBorder = False
        TabOrder = 7
        OnClick = cbxStyleSheetsClick
        OnKeyDown = cbxStyleSheetsKeyDown
        Width = 299
      end
      object chbxUseNativeStyles: TcxCheckBox
        Left = 7
        Top = 10
        AutoSize = False
        Style.TransparentBorder = False
        TabOrder = 0
        Transparent = True
        OnClick = OptionsFormattingClick
        Height = 21
        Width = 19
      end
      object lblUseNativeStyles: TcxLabel
        Left = 24
        Top = 11
        AutoSize = False
        Caption = '&Use Native Styles'
        FocusControl = chbxUseNativeStyles
        Properties.LineOptions.Visible = True
        Transparent = True
        OnClick = lblUseNativeStylesClick
        Height = 18
        Width = 287
      end
      object Label1: TcxLabel
        Left = 85
        Top = 140
        Caption = '[ Styles Site ]'
        Visible = False
      end
      object lblStyleSheets: TcxLabel
        Left = 10
        Top = 294
        AutoSize = False
        Caption = 'Style Sheets'
        Properties.LineOptions.Visible = True
        Transparent = True
        Height = 18
        Width = 301
      end
      object btnStyleColor: TcxButton
        Left = 237
        Top = 62
        Width = 72
        Height = 23
        Caption = 'Co&lor...'
        TabOrder = 2
        OnClick = btnStyleColorClick
      end
      object btnStyleFont: TcxButton
        Left = 237
        Top = 33
        Width = 72
        Height = 23
        Caption = '&Font...'
        TabOrder = 1
        OnClick = btnStyleFontClick
      end
      object btnStyleBackgroundBitmap: TcxButton
        Left = 237
        Top = 91
        Width = 72
        Height = 23
        Caption = '&Bitmap...'
        TabOrder = 3
        OnClick = btnStyleBackgroundBitmapClick
      end
      object btnStyleSheetNew: TcxButton
        Left = 10
        Top = 343
        Width = 70
        Height = 23
        Caption = '&New...'
        TabOrder = 8
        OnClick = btnStyleSheetNewClick
      end
      object btnStyleSheetCopy: TcxButton
        Left = 86
        Top = 343
        Width = 70
        Height = 23
        Caption = '&Copy...'
        TabOrder = 9
        OnClick = btnStyleSheetCopyClick
      end
      object btnStyleSheetDelete: TcxButton
        Left = 162
        Top = 343
        Width = 70
        Height = 23
        Caption = '&Delete...'
        TabOrder = 10
        OnClick = btnStyleSheetDeleteClick
      end
      object btnStylesSaveAs: TcxButton
        Left = 124
        Top = 261
        Width = 107
        Height = 23
        Caption = 'Save &As...'
        TabOrder = 6
        OnClick = btnStylesSaveAsClick
      end
      object btnStyleSheetRename: TcxButton
        Left = 239
        Top = 343
        Width = 70
        Height = 23
        Caption = '&Rename...'
        TabOrder = 11
        OnClick = btnStyleSheetRenameClick
      end
      object btnStyleBackgroundBitmapClear: TcxButton
        Left = 237
        Top = 120
        Width = 72
        Height = 23
        Caption = 'Cle&ar'
        TabOrder = 4
        OnClick = btnStyleBackgroundBitmapClearClick
      end
      object btnStyleRestoreDefaults: TcxButton
        Left = 10
        Top = 261
        Width = 108
        Height = 23
        Caption = 'Rest&ore Defaults'
        TabOrder = 5
        OnClick = btnStyleRestoreDefaultsClick
      end
    end
  end
  object pnlPreview: TPanel
    Left = 334
    Top = 55
    Width = 271
    Height = 385
    BevelOuter = bvNone
    TabOrder = 1
    object gbPreview: TcxGroupBox
      Left = 0
      Top = 0
      Align = alClient
      PanelStyle.Active = True
      ParentBackground = False
      ParentColor = False
      Style.Color = clWindow
      TabOrder = 0
      Height = 385
      Width = 271
      object pbPreview: TPaintBox
        Left = 2
        Top = 2
        Width = 267
        Height = 381
        Align = alClient
        OnPaint = pbPreviewPaint
      end
    end
  end
  object pmStyles: TPopupMenu
    Images = ilStylesPopup
    OnPopup = pmStylesPopup
    Left = 46
    Top = 473
    object miStyleFont: TMenuItem
      Caption = '&Font...'
      ImageIndex = 0
      OnClick = btnStyleFontClick
    end
    object miStyleColor: TMenuItem
      Caption = '&Color...'
      OnClick = btnStyleColorClick
    end
    object miLine3: TMenuItem
      Caption = '-'
    end
    object miStyleBackgroundBitmap: TMenuItem
      Caption = '&Bitmap...'
      ImageIndex = 1
      ShortCut = 16463
      OnClick = btnStyleBackgroundBitmapClick
    end
    object miStyleBackgroundBitmapClear: TMenuItem
      Caption = 'Clear'
      ImageIndex = 3
      ShortCut = 16430
      OnClick = btnStyleBackgroundBitmapClearClick
    end
    object miLine2: TMenuItem
      Caption = '-'
    end
    object miStyleRestoreDefaults: TMenuItem
      Caption = 'Restore Defaults'
      OnClick = btnStyleRestoreDefaultsClick
    end
    object milLine: TMenuItem
      Caption = '-'
    end
    object miStylesSelectAll: TMenuItem
      Caption = 'Select A&ll'
      ShortCut = 16449
      OnClick = miStylesSelectAllClick
    end
    object miLine4: TMenuItem
      Caption = '-'
    end
    object miStylesSaveAs: TMenuItem
      Caption = 'Save &As...'
      ImageIndex = 2
      ShortCut = 16467
      OnClick = btnStylesSaveAsClick
    end
  end
  object cxEditStyleController1: TcxEditStyleController
    OnStyleChanged = StyleController1StyleChanged
    Left = 80
    Top = 464
  end
  object ilStylesPopup: TcxImageList
    FormatVersion = 1
    DesignInfo = 30408712
    ImageInfo = <
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          000060360CD274410EFF5C330ACD000000000000000000000000000000000000
          0000160C0234592F07D76A3907FF693907FF0000000000000000000000000000
          000000000000552F0CBA2917055A000000000000000000000000000000000000
          00000D07011E6B3909FC6A3809FC0A0501180000000000000000000000000000
          0000000000002716065459320BC3000000000000000000000000000000000000
          0000391F05846E3C09FF482805AB000000000000000000000000000000000000
          000000000000010100036C3E0EE7120A02270000000000000000000000000301
          000665370BE76F3D0BFF1C100342000000000000000000000000000000000000
          0000000000000000000040250A8743260A900000000000000000000000002716
          0557713F0DFF5E3409D500000000000000000000000000000000000000000000
          0000000000000000000010090221794612FF784511FF764310FF75430FFF7442
          0FFF73410EFF301B066C00000000000000000000000000000000000000000000
          000000000000000000000000000058330EB72E1A076000000000150C032D7642
          10FF6F3E0DF30704010F00000000000000000000000000000000000000000000
          0000000000000000000000000000271706515F360FC60000000047290B997744
          11FF452709960000000000000000000000000000000000000000000000000000
          0000000000000000000000000000010100036F4011E71B100439734310F37845
          12FF150C032D0000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000003F250B815E360EC17B4713FF5D36
          0EC3000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000F09031E7C4715FC7C4814FF2A18
          0757000000000000000000000000000000000000000000000000000000000000
          00000000000000000000000000000000000000000000593410B4774514F00302
          0006000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000030000
          000E000000190000001C0000001F000000220000002400000026000000270000
          002900000029000000290000002000000009000000010000000018577FBB0D61
          96FF075B92FF075A92FF065A92FF065A92FF065A92FF065A92FF065A93FF065A
          92FF075A92FF065A92FF065C93FE010A103C00000005000000000C6199FB4198
          C2FF6BB5D3FF38C7ECFF0BB8E6FF0BB4E5FF0BB0E3FF0BADE1FF0AA9DFFF09A7
          DDFF09A2DCFF099DDAFF0980B7FF065277C20000000E0000000009679EFF5CBA
          E6FF2686B2FF90E7F8FF1BCCF3FF1CC9F1FF19C6EFFF15C1ECFF0DBCEAFF0CB8
          E8FF0BB4E6FF0BAFE4FF0BA2D9FF0A75A8FC0003041D000000000B75AAFF6CC8
          F2FF3994BEFF97CEE2FF59DFF8FF3CD7F6FF39D4F5FF31D0F3FF26CAF0FF19C4
          EEFF11BFEBFF11BBEAFF10B7E8FF0C83B6FF06476190000000000D82B6FF83D4
          F6FF3EAEDEFF3F8EB7FFB3F3FDFF62E3FAFF5EE1F9FF53DDF8FF45D9F5FF33D3
          F3FF22CCF1FF16C7EFFF16C4EDFF12ACD9FF0A73A4F200000000108CBFFF9DE2
          F9FF27BBF1FF3485B3FFBDDBE9FF9AF0FDFF86ECFCFF78E9FBFF65E3F9FF4EDE
          F7FF38D8F5FF26D1F2FF1DCEF2FF1CCBF1FF0C7CAFFF06384C65108FC4FFB8ED
          FCFF3BCAF5FF52B1D8FF5B98BDFFF9FEFFFFF3FDFFFFE8FCFEFFD7F9FEFFC1F5
          FDFFA6F0FCFF88EBFBFF6BE3F9FF59DEF7FF32B0D6FF12709CE11093C8FFD0F6
          FEFF56DBF9FF4BD4F7FF2170A4FF065E98FF075E98FF065E98FF075E98FF075E
          98FF075E98FF075F98FF075F98FF075E98FF075E98FF076099FF1197CDFFE3FB
          FFFF77EBFDFF6AE7FCFF5CE1FBFF50DBF9FF45D6F9FF3AD0F8FF32CBF6FF2BC6
          F5FF26C2F3FF22BDF2FF1FB9F1FF0C70A2FF0000000900000000129BD0FFEFFD
          FFFF9AF4FFFF85F2FFFF7CEFFEFF6DEAFDFF6DE8FCFFB3F2FDFFA1ECFCFF8DE6
          FBFF77DFFAFF63D8F8FF48C5EEFF0C74A6FF0000000600000000129ED4FFF7FE
          FFFFCCF8FEFFA0F5FFFF7EE7F8FF1091C5FF108EC2FF0F8BBEFF0E87BBFF0E85
          B7FF0E82B4FF0D7FB1FF1683B3FB186988B200000002000000002BA7D7FBE0F3
          FAFFF2F8FAFBD9F2F9FF28A0CEFB000000020000000200000002000000030000
          000300000003000000030000000300000002000000000000000047879DAF2BA8
          D7FB12A0D5FF29A4D4FB44829AAF000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000020000
          000C000000160000001A0000001B0000001C0000001D0000001E0000001F0000
          00210000002200000023000000240000002100000013000000040000000A8E6B
          45C9B57039FFB36D35FF252525FF202020FF1D1D1DFF191919FF151515FF1212
          12FF0F0F0FFF0C0C0CFFA1551BFFA05319FF805428D20000001300000011BC78
          41FFEEC18FFFEFCA9FFF343434FF2F2F2FFF2B2B2BFF282828FF232323FF2020
          20FFE7BE90FF181818FFE5BD8DFFDDAA6FFFA1541AFF0000002000000011C07E
          48FFF1C694FFF1CDA5FF454545FF404040FF3C3C3CFF373737FF333333FF2E2E
          2EFFE9C092FF272727FFE6BD8FFFDFAE71FFA3571CFF000000220000000FC583
          4EFFF3CA9AFFF3D1A8FF585858FF535353FF4E4E4EFF494949FF444444FF3F3F
          3FFFE9C293FF363636FFE8BF91FFE1AE74FFA55A20FF000000200000000EC988
          53FFF5CEA1FFF5D5AEFF6B6B6BFF666666FF616161FF5C5C5CFF575757FF5252
          52FF4D4D4DFF484848FFE9C292FFE3B077FFA85E25FF0000001E0000000CCE8D
          59FFF8D4A8FFF8D8B3FFF5D5ADFFF4D0A6FFF1CDA1FFEFCA9DFFEEC89BFFEDC8
          9AFFEDC598FFECC496FFEAC495FFE4B378FFAA6128FF0000001C0000000BD292
          5EFFFBD7AEFFF8D1A7FFF6CE9EFFF3C997FFF0C490FFEEC08AFFECBD84FFEBBB
          83FFE9BA81FFE9B880FFE8B67DFFE7B57CFFAE662DFF0000001B00000009D797
          64FFFDDCB4FFDBA36CFFDAA26BFFD9A16AFFD9A069FFD89E67FFD69D66FFD69C
          65FFD59A63FFD49962FFD39760FFE8B77EFFB16A32FF0000001900000008DA9C
          69FFFFDFBBFFD99F68FFFBFBFBFFFAFAFAFFF8F8F8FFF7F7F7FFF5F5F5FFF4F4
          F4FFF2F2F2FFF1F1F1FFD0935CFFE9BA81FFB56F38FF0000001700000006DEA0
          6EFFFFE5C1FFD69B65FFFDFDFDFF8E8E8EFF8B8B8BFF8A8A8AFF878787FF8484
          84FF828282FFF5F5F5FFCD8F58FFEBBC83FFB9743DFF0000001500000005E1A4
          71FFFFE7C7FFD39760FFFFFFFFFFFFFFFFFFFEFEFEFFFDFDFDFFFCFCFCFFFBFB
          FBFFFAFAFAFFF8F8F8FFCA8B55FFEEBD86FFBD7943FF0000001400000004E3A6
          74FFFFEACDFFD1925DFFFFFFFFFFADADADFFABABABFFA9A9A9FFA7A7A7FFA5A5
          A5FFA3A3A3FFFBFBFBFFC88751FFEFC089FFC27E48FF0000001200000002E5A8
          76FFFFF0D2FFCE8E59FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFEFEFEFFC6844EFFF1C28BFFC6834EFF0000000E00000001AA94
          75C0E5A876FFCB8B56FFACACACFFACACACFFACACACFFACACACFFACACACFFACAC
          ACFFACACACFFACACACFFC4814CFFCD8C58FF95764FC500000007000000000000
          0001000000020000000300000003000000040000000500000005000000060000
          000700000008000000090000000A0000000A0000000600000001}
      end
      item
        Image.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000000000010000
          000800000F4200000B3300000007000000010000000000000000000000000000
          0000000000000000000000000002000000080000000800000002000000040000
          1B68030357DD020242BE00000C3D000000060000000000000000000000000000
          00000000000000000002000000120000176B000017690000000D0000020B0303
          3D8A0E0EBFFF0B0BAAFF02023EB4000008300000000500000000000000000000
          0000000000030000001201011C81040465E9030358D300000830000000020101
          0D210B0B7DA41112D7FF0A0AA3FF010135A90000052300000004000000000000
          00020000001001011E8304046FEB0909B7F903034D8F0000000E000000000000
          000301010C200B0B7BA11312D7FF0A0A9EFF01012FA000000217000000050000
          000F01011F85050574EE090AC1FF0505629A0000001400000003000000000000
          00000000000201010A1C0B0B779C1414D9FF0B0B98FF010128970000001B0101
          228A06067AF10C0CC6FF06066EA1000001150000000300000000000000000000
          00000000000000000002010106160B0B73951414DAFF0B0B91FD010138CA0808
          83F70E0ECAFF080878A60000061E000000030000000000000000000000000000
          00000000000000000000000000020000010F0B0B71961415D6FD0F10B3FF1212
          D2FF0B0B80AD01010C2700000004000000000000000000000000000000000000
          000000000000000000000000000300000725080855A01616DBFF1515DBFF1414
          D5FB06064F940000000F00000002000000000000000000000000000000000000
          0000000000000000000300000C2E030339A811119FFF1B1BDFFF1313AFD21414
          C6ED090A88F00000207D0000000B000000020000000000000000000000000000
          0000000000020101143C06064CB41515ACFF1F1FE1FF131390AE03031A330909
          4E6F1212B2DE08087DEC00001F790000000A0000000100000000000000000000
          00020303214C0C0C64C11C1CBDFF2323E5FF161693AE03031A2F000000040000
          00060808405F1313A6D109097BEB00001F770000000900000001000000010707
          335D141485D22121CCFF2828E7FF1A1A96AC04041C2E00000002000000000000
          0001000000050606324F13129AC30A0A7BEB00002075000000060303141F1717
          8BBF2828DBFF2B2BE9FF1B1B96A804041C2B0000000200000000000000000000
          000000000000000000040404253D11118DB1090969C800000923000000000F0F
          4C5A2626C4D61B1B94A305051B26000000010000000000000000000000000000
          0000000000000000000000000002020213220505283B00000003000000000000
          00000707252A0303111600000000000000000000000000000000000000000000
          0000000000000000000000000000000000010000000100000000}
      end>
  end
end
