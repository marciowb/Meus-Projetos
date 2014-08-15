object cxSchedulerEventEditorForm: TcxSchedulerEventEditorForm
  Left = 300
  Top = 150
  AutoScroll = False
  ClientHeight = 352
  ClientWidth = 450
  Color = clBtnFace
  Constraints.MinHeight = 338
  Constraints.MinWidth = 458
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlButtons: TPanel
    Left = 0
    Top = 311
    Width = 450
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 0
    object pnlThreeButtons: TPanel
      Left = 0
      Top = 0
      Width = 340
      Height = 41
      Align = alClient
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 0
      object btnOk: TcxButton
        Left = 15
        Top = 9
        Width = 95
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'OK'
        Default = True
        ModalResult = 1
        TabOrder = 0
      end
      object btnCancel: TcxButton
        Left = 125
        Top = 9
        Width = 95
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Cancel'
        ModalResult = 2
        TabOrder = 1
      end
      object btnDelete: TcxButton
        Left = 235
        Top = 9
        Width = 95
        Height = 25
        Anchors = [akTop, akRight]
        Caption = '&Delete'
        TabOrder = 2
        OnClick = btnDeleteClick
      end
    end
    object pnlRecurrence: TPanel
      Left = 340
      Top = 0
      Width = 110
      Height = 41
      Align = alRight
      BevelOuter = bvNone
      FullRepaint = False
      ParentColor = True
      TabOrder = 1
      object btnRecurrence: TcxButton
        Left = 5
        Top = 9
        Width = 95
        Height = 25
        Caption = '&Recurrence'
        TabOrder = 0
        OnClick = btnRecurrenceClick
      end
    end
  end
  object pnlCaption: TPanel
    Left = 0
    Top = 43
    Width = 450
    Height = 65
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 1
    object lbSubject: TLabel
      Left = 16
      Top = 13
      Width = 40
      Height = 13
      Caption = 'Subject:'
      FocusControl = teSubject
    end
    object lbLocation: TLabel
      Left = 16
      Top = 38
      Width = 44
      Height = 13
      Caption = 'Location:'
      FocusControl = teLocation
    end
    object lbLabel: TLabel
      Left = 239
      Top = 38
      Width = 29
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'La&bel:'
      FocusControl = icbLabel
    end
    object teSubject: TcxTextEdit
      Left = 72
      Top = 9
      Width = 369
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Properties.OnChange = OnChanged
      TabOrder = 0
    end
    object teLocation: TcxTextEdit
      Left = 72
      Top = 34
      Width = 145
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Properties.OnChange = OnChanged
      TabOrder = 1
    end
    object icbLabel: TcxImageComboBox
      Left = 272
      Top = 34
      Width = 169
      Height = 21
      Anchors = [akTop, akRight]
      Properties.Items = <>
      Properties.OnChange = OnChanged
      TabOrder = 2
    end
  end
  object pnlTime: TPanel
    Left = 0
    Top = 108
    Width = 450
    Height = 67
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 2
    object Bevel4: TBevel
      Left = 11
      Top = 0
      Width = 429
      Height = 8
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object lbStartTime: TLabel
      Left = 16
      Top = 15
      Width = 51
      Height = 13
      Caption = 'Start time:'
      FocusControl = deStart
    end
    object lbEndTime: TLabel
      Left = 16
      Top = 40
      Width = 45
      Height = 13
      Caption = 'End time:'
      FocusControl = deEnd
    end
    object deStart: TcxDateEdit
      Left = 96
      Top = 11
      Width = 121
      Height = 21
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnEditValueChanged = StartDateChanged
      TabOrder = 0
    end
    object teStart: TcxTimeEdit
      Left = 224
      Top = 11
      Width = 81
      Height = 21
      EditValue = 0
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = OnChanged
      TabOrder = 1
    end
    object deEnd: TcxDateEdit
      Left = 96
      Top = 36
      Width = 121
      Height = 21
      Properties.DateButtons = [btnToday]
      Properties.InputKind = ikStandard
      Properties.OnChange = OnChanged
      TabOrder = 2
    end
    object teEnd: TcxTimeEdit
      Left = 224
      Top = 36
      Width = 81
      Height = 21
      EditValue = 0
      Properties.TimeFormat = tfHourMin
      Properties.OnChange = OnChanged
      TabOrder = 3
    end
    object cbAllDayEvent: TcxCheckBox
      Left = 320
      Top = 12
      Width = 121
      Height = 21
      Caption = 'All day event'
      Properties.OnChange = cbAllDayEventPropertiesChange
      TabOrder = 4
    end
  end
  object pnlReminder: TPanel
    Left = 0
    Top = 175
    Width = 450
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 3
    object Bevel3: TBevel
      Left = 11
      Top = 1
      Width = 429
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object lbShowTimeAs: TLabel
      Left = 16
      Top = 16
      Width = 67
      Height = 13
      Caption = 'Show time as:'
      FocusControl = icbShowTimeAs
    end
    object cbReminder: TcxCheckBox
      Left = 235
      Top = 13
      Width = 81
      Height = 21
      Caption = 'Reminder:'
      Properties.OnChange = OnChanged
      State = cbsChecked
      TabOrder = 0
    end
    object cbAdvanceTime: TcxComboBox
      Left = 316
      Top = 12
      Width = 121
      Height = 21
      Properties.DropDownListStyle = lsFixedList
      Properties.OnChange = OnChanged
      TabOrder = 1
    end
    object icbShowTimeAs: TcxImageComboBox
      Left = 96
      Top = 12
      Width = 121
      Height = 21
      Properties.Items = <>
      Properties.OnChange = OnChanged
      TabOrder = 2
    end
  end
  object pnlMessage: TPanel
    Left = 0
    Top = 218
    Width = 450
    Height = 93
    Align = alClient
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 4
    object Bevel2: TBevel
      Left = 11
      Top = 0
      Width = 429
      Height = 9
      Anchors = [akLeft, akTop, akRight]
      Shape = bsTopLine
    end
    object Bevel1: TBevel
      Left = 11
      Top = 85
      Width = 429
      Height = 7
      Anchors = [akLeft, akRight, akBottom]
      Shape = bsBottomLine
    end
    object meMessage: TcxMemo
      Left = 10
      Top = 12
      Width = 431
      Height = 67
      Anchors = [akLeft, akTop, akRight, akBottom]
      Properties.OnChange = OnChanged
      TabOrder = 0
    end
  end
  object pnlResource: TPanel
    Left = 0
    Top = 0
    Width = 450
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    ParentColor = True
    TabOrder = 5
    object lbResource: TLabel
      Left = 16
      Top = 14
      Width = 49
      Height = 13
      Caption = 'Resource:'
    end
    object Bevel5: TBevel
      Left = 11
      Top = 36
      Width = 429
      Height = 7
      Anchors = [akLeft, akTop, akRight]
      Shape = bsBottomLine
    end
    object cbResources: TcxComboBox
      Left = 96
      Top = 10
      Width = 346
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      Properties.DropDownAutoWidth = False
      Properties.DropDownListStyle = lsEditFixedList
      Properties.OnEditValueChanged = OnChanged
      TabOrder = 0
    end
  end
end
