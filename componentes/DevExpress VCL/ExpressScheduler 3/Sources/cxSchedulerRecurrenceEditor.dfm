object cxSchedulerRecurrenceEventEditorForm: TcxSchedulerRecurrenceEventEditorForm
  Left = 277
  Top = 263
  ActiveControl = teStart
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Event recurrence'
  ClientHeight = 330
  ClientWidth = 483
  Color = clBtnFace
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOk: TcxButton
    Left = 68
    Top = 298
    Width = 85
    Height = 23
    Caption = '&Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 172
    Top = 298
    Width = 85
    Height = 23
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnRemove: TcxButton
    Left = 276
    Top = 298
    Width = 121
    Height = 23
    Caption = '&Remove recurrence'
    Enabled = False
    ModalResult = 3
    TabOrder = 2
  end
  object gbTime: TcxGroupBox
    Left = 8
    Top = 6
    Caption = 'Event time'
    TabOrder = 3
    Height = 50
    Width = 466
    object lbStart: TLabel
      Left = 14
      Top = 21
      Width = 28
      Height = 13
      Caption = 'Start:'
      FocusControl = teStart
      Transparent = True
    end
    object lbEnd: TLabel
      Left = 144
      Top = 21
      Width = 22
      Height = 13
      Caption = 'End:'
      FocusControl = teEnd
      Transparent = True
    end
    object lbDuration: TLabel
      Left = 264
      Top = 21
      Width = 45
      Height = 13
      Caption = 'Duration:'
      FocusControl = cbDuration
      Transparent = True
    end
    object teStart: TcxTimeEdit
      Left = 52
      Top = 18
      EditValue = 0.000000000000000000
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = DoChange
      Properties.OnEditValueChanged = StartTimeChanged
      TabOrder = 0
      Width = 78
    end
    object teEnd: TcxTimeEdit
      Left = 174
      Top = 18
      EditValue = 0.000000000000000000
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = DoChange
      Properties.OnEditValueChanged = EndTimeChanged
      TabOrder = 1
      Width = 78
    end
    object cbDuration: TcxComboBox
      Left = 323
      Top = 18
      Properties.ImmediateDropDown = False
      Properties.ImmediatePost = True
      Properties.IncrementalSearch = False
      Properties.OnChange = DoChange
      Properties.OnPopup = cbDurationPropertiesPopup
      Properties.OnValidate = cbDurationPropertiesValidate
      TabOrder = 2
      Width = 129
    end
  end
  object gbPattern: TcxGroupBox
    Left = 8
    Top = 60
    Caption = 'Recurrence pattern'
    TabOrder = 4
    Height = 127
    Width = 466
    object pnlYearly: TcxGroupBox
      Left = 94
      Top = 18
      Align = alCustom
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 2
      Visible = False
      Height = 101
      Width = 370
      object lbOf: TLabel
        Left = 243
        Top = 36
        Width = 10
        Height = 13
        Caption = 'of'
        Transparent = True
      end
      object cbMonths1: TcxComboBox
        Tag = 11589716
        Left = 262
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = cbWeek1PropertiesChange
        TabOrder = 6
        Width = 90
      end
      object meDayOfMonth: TcxMaskEdit
        Tag = 11588656
        Left = 155
        Top = 4
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = cbMonthsPropertiesChange
        TabOrder = 3
        OnExit = ValidateNumber
        Width = 32
      end
      object cbMonths: TcxComboBox
        Tag = 11588656
        Left = 60
        Top = 4
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = cbMonthsPropertiesChange
        TabOrder = 2
        Width = 90
      end
      object cbWeek1: TcxComboBox
        Tag = 11589716
        Left = 60
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = cbWeek1PropertiesChange
        TabOrder = 4
        Width = 65
      end
      object rbEvery1: TcxRadioButton
        Left = 4
        Top = 6
        Width = 57
        Height = 17
        Caption = 'Every'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = DoChange
        Transparent = True
      end
      object rbThe1: TcxRadioButton
        Left = 4
        Top = 35
        Width = 49
        Height = 17
        Caption = 'The'
        TabOrder = 1
        Transparent = True
      end
      object cbDay1: TcxComboBox
        Tag = 11589716
        Left = 130
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 10
        Properties.OnChange = cbWeek1PropertiesChange
        TabOrder = 5
        Width = 103
      end
    end
    object pnlWeekly: TcxGroupBox
      Left = 94
      Top = 18
      Align = alCustom
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 3
      Visible = False
      Height = 101
      Width = 370
      object lbRecurEvery: TLabel
        Left = 7
        Top = 7
        Width = 59
        Height = 13
        Caption = 'Recur every'
        FocusControl = meNumOfWeek
        Transparent = True
      end
      object lbWeeksOn: TLabel
        Left = 117
        Top = 7
        Width = 57
        Height = 13
        Caption = 'week(s) on:'
        Transparent = True
      end
      object cbDayOfWeek4: TcxCheckBox
        Tag = 4
        Left = 270
        Top = 38
        Caption = 'Wednesday'
        Properties.OnChange = DoChange
        TabOrder = 4
        Transparent = True
        Width = 90
      end
      object meNumOfWeek: TcxMaskEdit
        Left = 74
        Top = 4
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = DoChange
        TabOrder = 0
        OnExit = ValidateNumber
        Width = 32
      end
      object cbDayOfWeek2: TcxCheckBox
        Tag = 2
        Left = 92
        Top = 38
        Caption = 'Monday'
        Properties.OnChange = DoChange
        TabOrder = 2
        Transparent = True
        Width = 90
      end
      object cbDayOfWeek3: TcxCheckBox
        Tag = 3
        Left = 181
        Top = 38
        Caption = 'Tuesday'
        Properties.OnChange = DoChange
        TabOrder = 3
        Transparent = True
        Width = 90
      end
      object cbDayOfWeek5: TcxCheckBox
        Tag = 5
        Left = 3
        Top = 62
        Caption = 'Thursday'
        Properties.OnChange = DoChange
        TabOrder = 5
        Transparent = True
        Width = 90
      end
      object cbDayOfWeek6: TcxCheckBox
        Tag = 6
        Left = 92
        Top = 62
        Caption = 'Friday'
        Properties.OnChange = DoChange
        TabOrder = 6
        Transparent = True
        Width = 90
      end
      object cbDayOfWeek7: TcxCheckBox
        Tag = 7
        Left = 181
        Top = 62
        Caption = 'Saturday'
        Properties.OnChange = DoChange
        TabOrder = 7
        Transparent = True
        Width = 90
      end
      object cbDayOfWeek1: TcxCheckBox
        Tag = 1
        Left = 3
        Top = 38
        Caption = 'Sunday'
        Properties.OnChange = DoChange
        TabOrder = 1
        Transparent = True
        Width = 90
      end
    end
    object pnlDaily: TcxGroupBox
      Left = 94
      Top = 18
      Align = alCustom
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 4
      Visible = False
      Height = 101
      Width = 370
      object lbDay: TLabel
        Left = 115
        Top = 7
        Width = 18
        Height = 13
        Caption = 'day'
        Transparent = True
      end
      object rbEvery: TcxRadioButton
        Left = 4
        Top = 6
        Width = 66
        Height = 17
        Caption = 'Every'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = DoChange
        Transparent = True
      end
      object meDay: TcxMaskEdit
        Left = 74
        Top = 4
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = meDayPropertiesChange
        TabOrder = 2
        OnExit = ValidateNumber
        Width = 32
      end
      object rbEveryWeekday: TcxRadioButton
        Left = 4
        Top = 35
        Width = 113
        Height = 17
        Caption = 'Every weekday'
        TabOrder = 1
        OnClick = rbEveryWeekdayClick
        Transparent = True
      end
    end
    object pnlMonthly: TcxGroupBox
      Left = 94
      Top = 18
      Align = alCustom
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 1
      Visible = False
      Height = 101
      Width = 370
      object lbMonths: TLabel
        Left = 174
        Top = 7
        Width = 43
        Height = 13
        Caption = 'month(s)'
        Transparent = True
      end
      object lbMonths1: TLabel
        Left = 311
        Top = 36
        Width = 43
        Height = 13
        Caption = 'month(s)'
        Transparent = True
      end
      object lbOfEvery: TLabel
        Left = 92
        Top = 7
        Width = 41
        Height = 13
        Caption = 'of every'
        Transparent = True
      end
      object lbOfEvery1: TLabel
        Left = 226
        Top = 36
        Width = 41
        Height = 13
        Caption = 'of every'
        Transparent = True
      end
      object cbWeek: TcxComboBox
        Tag = 11534460
        Left = 53
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.OnChange = SetTheRadioButtonChecked
        TabOrder = 4
        Width = 65
      end
      object meNumOfDay: TcxMaskEdit
        Tag = 11533468
        Left = 53
        Top = 4
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = SetDayRadioButtonChecked
        TabOrder = 2
        OnExit = ValidateNumber
        Width = 32
      end
      object meNumMonth: TcxMaskEdit
        Tag = 11533468
        Left = 139
        Top = 4
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = SetDayRadioButtonChecked
        TabOrder = 3
        OnExit = ValidateNumber
        Width = 32
      end
      object meNumMonth1: TcxMaskEdit
        Tag = 11534460
        Left = 273
        Top = 33
        Properties.MaskKind = emkRegExpr
        Properties.EditMask = '\d{0,4}'
        Properties.MaxLength = 0
        Properties.OnChange = SetTheRadioButtonChecked
        TabOrder = 6
        OnExit = ValidateNumber
        Width = 32
      end
      object rbDay: TcxRadioButton
        Left = 4
        Top = 6
        Width = 50
        Height = 17
        Caption = 'Day'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = DoChange
        Transparent = True
      end
      object rbThe: TcxRadioButton
        Left = 4
        Top = 35
        Width = 49
        Height = 17
        Caption = 'The'
        TabOrder = 1
        OnClick = DoChange
        Transparent = True
      end
      object cbDay: TcxComboBox
        Tag = 11534460
        Left = 121
        Top = 33
        Properties.DropDownListStyle = lsFixedList
        Properties.DropDownRows = 10
        Properties.OnChange = SetTheRadioButtonChecked
        TabOrder = 5
        Width = 96
      end
    end
    object pnlPeriodicity: TcxGroupBox
      Left = 2
      Top = 18
      PanelStyle.Active = True
      PanelStyle.OfficeBackgroundKind = pobkStyleColor
      Style.BorderStyle = ebsNone
      TabOrder = 0
      Height = 101
      Width = 93
      object Bevel1: TBevel
        Left = 90
        Top = 8
        Width = 3
        Height = 93
        Shape = bsLeftLine
      end
      object rbYearly: TcxRadioButton
        Tag = 3
        Left = 8
        Top = 80
        Width = 80
        Height = 17
        Caption = 'Yearly'
        TabOrder = 3
        OnClick = SelectPeriodicityClick
        Transparent = True
      end
      object rbWeekly: TcxRadioButton
        Tag = 1
        Left = 8
        Top = 32
        Width = 80
        Height = 17
        Caption = 'Weekly'
        TabOrder = 1
        OnClick = SelectPeriodicityClick
        Transparent = True
      end
      object rbMonthly: TcxRadioButton
        Tag = 2
        Left = 8
        Top = 56
        Width = 80
        Height = 17
        Caption = 'Monthly'
        TabOrder = 2
        OnClick = SelectPeriodicityClick
        Transparent = True
      end
      object rbDaily: TcxRadioButton
        Left = 8
        Top = 8
        Width = 80
        Height = 17
        Caption = 'Daily'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = SelectPeriodicityClick
        Transparent = True
      end
    end
  end
  object gbRange: TcxGroupBox
    Left = 8
    Top = 191
    Caption = 'Range of recurrence'
    TabOrder = 5
    Height = 97
    Width = 466
    object lbStart1: TLabel
      Left = 16
      Top = 28
      Width = 28
      Height = 13
      Caption = 'Start:'
      FocusControl = deStart
      Transparent = True
    end
    object lbOccurrences: TLabel
      Left = 332
      Top = 42
      Width = 58
      Height = 13
      Caption = 'occurrences'
      Transparent = True
    end
    object deStart: TcxDateEdit
      Left = 56
      Top = 24
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnChange = DoChange
      Properties.OnEditValueChanged = deStartPropertiesEditValueChanged
      TabOrder = 0
      Width = 135
    end
    object rbNoEndDate: TcxRadioButton
      Left = 216
      Top = 16
      Width = 113
      Height = 17
      Caption = 'No end date'
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = rbNoEndDateClick
      Transparent = True
    end
    object rbEndAfter: TcxRadioButton
      Left = 216
      Top = 41
      Width = 73
      Height = 17
      Caption = 'End after:'
      TabOrder = 2
      OnClick = DoChange
      Transparent = True
    end
    object rbEndBy: TcxRadioButton
      Left = 216
      Top = 67
      Width = 73
      Height = 17
      Caption = 'End by:'
      TabOrder = 3
      OnClick = DoChange
      Transparent = True
    end
    object deEndBy: TcxDateEdit
      Tag = 11453468
      Left = 292
      Top = 65
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnChange = deEndByPropertiesChange
      Properties.OnEditValueChanged = deEndByPropertiesEditValueChanged
      TabOrder = 5
      Width = 135
    end
    object meEndAfter: TcxMaskEdit
      Tag = 11452416
      Left = 292
      Top = 39
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d{0,4}'
      Properties.MaxLength = 0
      Properties.OnChange = meEndAfterPropertiesChange
      Properties.OnEditValueChanged = meEndAfterPropertiesEditValueChanged
      TabOrder = 4
      OnExit = meEndAfterExit
      Width = 32
    end
  end
end
