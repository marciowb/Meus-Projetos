object cxSchedulerRecurrenceEventEditorForm: TcxSchedulerRecurrenceEventEditorForm
  Left = 172
  Top = 179
  ActiveControl = teStart
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Event recurrence'
  ClientHeight = 333
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
    Height = 25
    Caption = '&Ok'
    Default = True
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 172
    Top = 298
    Width = 85
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnRemove: TcxButton
    Left = 276
    Top = 298
    Width = 121
    Height = 25
    Caption = '&Remove recurrence'
    Enabled = False
    ModalResult = 3
    TabOrder = 2
  end
  object gbTime: TcxGroupBox
    Left = 8
    Top = 6
    Width = 466
    Height = 50
    Caption = 'Event time'
    Style.HotTrack = False
    TabOrder = 3
    object lbStart: TLabel
      Left = 16
      Top = 21
      Width = 28
      Height = 13
      Caption = 'Start:'
      FocusControl = teStart
    end
    object lbEnd: TLabel
      Left = 144
      Top = 21
      Width = 22
      Height = 13
      Caption = 'End:'
      FocusControl = teEnd
    end
    object teStart: TcxTimeEdit
      Left = 56
      Top = 17
      Width = 65
      Height = 21
      EditValue = 0.000000000000000000
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = DoChange
      TabOrder = 0
    end
    object teEnd: TcxTimeEdit
      Left = 176
      Top = 17
      Width = 65
      Height = 21
      EditValue = 0.000000000000000000
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = DoChange
      TabOrder = 1
    end
  end
  object gbPattern: TcxGroupBox
    Left = 8
    Top = 60
    Width = 466
    Height = 127
    Caption = 'Recurrence pattern'
    Style.HotTrack = False
    TabOrder = 4
    object pnlPeriodicity: TPanel
      Left = 2
      Top = 16
      Width = 93
      Height = 109
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
      object Bevel1: TBevel
        Left = 90
        Top = 8
        Width = 3
        Height = 93
        Shape = bsLeftLine
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
      end
    end
    object pcPattern: TPageControl
      Left = 95
      Top = 16
      Width = 369
      Height = 109
      ActivePage = tsDaily
      Align = alClient
      Style = tsButtons
      TabOrder = 1
      TabStop = False
      object tsDaily: TTabSheet
        TabVisible = False
        object lbDay: TLabel
          Left = 115
          Top = 7
          Width = 18
          Height = 13
          Caption = 'day'
        end
        object rbEveryWeekday: TcxRadioButton
          Left = 2
          Top = 35
          Width = 113
          Height = 17
          Caption = 'Every weekday'
          TabOrder = 1
          OnClick = rbEveryWeekdayClick
        end
        object rbEvery: TcxRadioButton
          Left = 2
          Top = 6
          Width = 66
          Height = 17
          Caption = 'Every'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = DoChange
        end
        object meDay: TcxMaskEdit
          Left = 74
          Top = 3
          Width = 32
          Height = 21
          Properties.MaskKind = emkRegExpr
          Properties.EditMask = '\d{0,4}'
          Properties.MaxLength = 0
          Properties.OnChange = meDayPropertiesChange
          TabOrder = 2
          OnExit = ValidateNumber
        end
      end
      object tsWeekly: TTabSheet
        TabVisible = False
        object lbWeeksOn: TLabel
          Left = 117
          Top = 7
          Width = 57
          Height = 13
          Caption = 'week(s) on:'
        end
        object lbRecurEvery: TLabel
          Left = 4
          Top = 7
          Width = 59
          Height = 13
          Caption = 'Recur every'
          FocusControl = meNumOfWeek
        end
        object cbDayOfWeek1: TcxCheckBox
          Tag = 1
          Left = 0
          Top = 38
          Width = 90
          Height = 21
          Caption = 'Sunday'
          Properties.OnChange = DoChange
          TabOrder = 1
        end
        object cbDayOfWeek7: TcxCheckBox
          Tag = 7
          Left = 178
          Top = 62
          Width = 90
          Height = 21
          Caption = 'Saturday'
          Properties.OnChange = DoChange
          TabOrder = 7
        end
        object cbDayOfWeek6: TcxCheckBox
          Tag = 6
          Left = 89
          Top = 62
          Width = 90
          Height = 21
          Caption = 'Friday'
          Properties.OnChange = DoChange
          TabOrder = 6
        end
        object cbDayOfWeek5: TcxCheckBox
          Tag = 5
          Left = 0
          Top = 62
          Width = 90
          Height = 21
          Caption = 'Thursday'
          Properties.OnChange = DoChange
          TabOrder = 5
        end
        object cbDayOfWeek4: TcxCheckBox
          Tag = 4
          Left = 267
          Top = 38
          Width = 90
          Height = 21
          Caption = 'Wednesday'
          Properties.OnChange = DoChange
          TabOrder = 4
        end
        object cbDayOfWeek3: TcxCheckBox
          Tag = 3
          Left = 178
          Top = 38
          Width = 90
          Height = 21
          Caption = 'Tuesday'
          Properties.OnChange = DoChange
          TabOrder = 3
        end
        object cbDayOfWeek2: TcxCheckBox
          Tag = 2
          Left = 89
          Top = 38
          Width = 90
          Height = 21
          Caption = 'Monday'
          Properties.OnChange = DoChange
          TabOrder = 2
        end
        object meNumOfWeek: TcxMaskEdit
          Left = 74
          Top = 3
          Width = 32
          Height = 21
          Properties.MaskKind = emkRegExpr
          Properties.EditMask = '\d{0,4}'
          Properties.MaxLength = 0
          Properties.OnChange = DoChange
          TabOrder = 0
          OnExit = ValidateNumber
        end
      end
      object tsMonthly: TTabSheet
        ImageIndex = 3
        TabVisible = False
        object lbOfEvery1: TLabel
          Left = 226
          Top = 36
          Width = 41
          Height = 13
          Caption = 'of every'
        end
        object lbOfEvery: TLabel
          Left = 92
          Top = 7
          Width = 41
          Height = 13
          Caption = 'of every'
        end
        object lbMonths1: TLabel
          Left = 311
          Top = 36
          Width = 43
          Height = 13
          Caption = 'month(s)'
        end
        object lbMonths: TLabel
          Left = 174
          Top = 7
          Width = 43
          Height = 13
          Caption = 'month(s)'
        end
        object cbDay: TcxComboBox
          Tag = 11534460
          Left = 121
          Top = 32
          Width = 96
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 10
          Properties.OnChange = SetTheRadioButtonChecked
          TabOrder = 4
        end
        object rbThe: TcxRadioButton
          Left = 2
          Top = 35
          Width = 49
          Height = 17
          Caption = 'The'
          TabOrder = 1
          OnClick = DoChange
        end
        object rbDay: TcxRadioButton
          Left = 2
          Top = 6
          Width = 50
          Height = 17
          Caption = 'Day'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = DoChange
        end
        object cbWeek: TcxComboBox
          Tag = 11534460
          Left = 53
          Top = 32
          Width = 65
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.OnChange = SetTheRadioButtonChecked
          TabOrder = 3
        end
        object meNumMonth1: TcxMaskEdit
          Tag = 11534460
          Left = 273
          Top = 32
          Width = 32
          Height = 21
          Properties.MaskKind = emkRegExpr
          Properties.EditMask = '\d{0,4}'
          Properties.MaxLength = 0
          Properties.OnChange = SetTheRadioButtonChecked
          TabOrder = 5
          OnExit = ValidateNumber
        end
        object meNumMonth: TcxMaskEdit
          Tag = 11533468
          Left = 139
          Top = 3
          Width = 32
          Height = 21
          Properties.MaskKind = emkRegExpr
          Properties.EditMask = '\d{0,4}'
          Properties.MaxLength = 0
          Properties.OnChange = SetDayRadioButtonChecked
          TabOrder = 2
          OnExit = ValidateNumber
        end
        object meNumOfDay: TcxMaskEdit
          Tag = 11533468
          Left = 53
          Top = 3
          Width = 32
          Height = 21
          Properties.MaskKind = emkRegExpr
          Properties.EditMask = '\d{0,4}'
          Properties.MaxLength = 0
          Properties.OnChange = SetDayRadioButtonChecked
          TabOrder = 6
          OnExit = ValidateNumber
        end
      end
      object tsYearly: TTabSheet
        TabVisible = False
        object lbOf: TLabel
          Left = 243
          Top = 36
          Width = 10
          Height = 13
          Caption = 'of'
        end
        object cbDay1: TcxComboBox
          Tag = 11589716
          Left = 130
          Top = 32
          Width = 103
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.DropDownRows = 10
          Properties.OnChange = cbWeek1PropertiesChange
          TabOrder = 5
        end
        object rbThe1: TcxRadioButton
          Left = 2
          Top = 35
          Width = 49
          Height = 17
          Caption = 'The'
          TabOrder = 1
        end
        object rbEvery1: TcxRadioButton
          Left = 2
          Top = 6
          Width = 57
          Height = 17
          Caption = 'Every'
          Checked = True
          TabOrder = 0
          TabStop = True
          OnClick = DoChange
        end
        object cbWeek1: TcxComboBox
          Tag = 11589716
          Left = 60
          Top = 32
          Width = 65
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.OnChange = cbWeek1PropertiesChange
          TabOrder = 4
        end
        object cbMonths1: TcxComboBox
          Tag = 11589716
          Left = 262
          Top = 32
          Width = 90
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.OnChange = cbWeek1PropertiesChange
          TabOrder = 6
        end
        object cbMonths: TcxComboBox
          Tag = 11588656
          Left = 60
          Top = 3
          Width = 90
          Height = 21
          Properties.DropDownListStyle = lsFixedList
          Properties.OnChange = cbMonthsPropertiesChange
          TabOrder = 2
        end
        object meDayOfMonth: TcxMaskEdit
          Tag = 11588656
          Left = 155
          Top = 3
          Width = 32
          Height = 21
          Properties.MaskKind = emkRegExpr
          Properties.EditMask = '\d{0,4}'
          Properties.MaxLength = 0
          Properties.OnChange = cbMonthsPropertiesChange
          TabOrder = 3
          OnExit = ValidateNumber
        end
      end
    end
  end
  object gbRange: TcxGroupBox
    Left = 8
    Top = 191
    Width = 466
    Height = 97
    Caption = 'Range of recurrence'
    Style.HotTrack = False
    TabOrder = 5
    object lbStart1: TLabel
      Left = 16
      Top = 28
      Width = 28
      Height = 13
      Caption = 'Start:'
      FocusControl = deStart
    end
    object lbOccurrences: TLabel
      Left = 332
      Top = 44
      Width = 58
      Height = 13
      Caption = 'occurrences'
    end
    object deStart: TcxDateEdit
      Left = 56
      Top = 24
      Width = 135
      Height = 21
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnChange = DoChange
      Properties.OnEditValueChanged = deStartPropertiesEditValueChanged
      TabOrder = 0
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
    end
    object rbEndAfter: TcxRadioButton
      Left = 216
      Top = 43
      Width = 73
      Height = 17
      Caption = 'End after:'
      TabOrder = 2
      OnClick = DoChange
    end
    object rbEndBy: TcxRadioButton
      Left = 216
      Top = 70
      Width = 73
      Height = 17
      Caption = 'End by:'
      TabOrder = 3
      OnClick = DoChange
    end
    object deEndBy: TcxDateEdit
      Tag = 11453468
      Left = 292
      Top = 66
      Width = 135
      Height = 21
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnChange = deEndByPropertiesChange
      Properties.OnEditValueChanged = deEndByPropertiesEditValueChanged
      TabOrder = 5
    end
    object meEndAfter: TcxMaskEdit
      Tag = 11452416
      Left = 292
      Top = 39
      Width = 32
      Height = 21
      Properties.MaskKind = emkRegExpr
      Properties.EditMask = '\d{0,4}'
      Properties.MaxLength = 0
      Properties.OnChange = meEndAfterPropertiesChange
      Properties.OnEditValueChanged = meEndAfterPropertiesEditValueChanged
      TabOrder = 4
      OnExit = meEndAfterExit
    end
  end
end
