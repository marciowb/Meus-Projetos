object fmHolidaysEditor: TfmHolidaysEditor
  Left = 380
  Top = 223
  ActiveControl = clbLocations
  BorderStyle = bsDialog
  Caption = 'fmHolidaysEditor'
  ClientHeight = 414
  ClientWidth = 716
  Color = clBtnFace
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnImport: TcxButton
    Left = 8
    Top = 8
    Width = 112
    Height = 23
    Caption = 'btnImport'
    TabOrder = 3
    OnClick = btnImportClick
  end
  object gbAddedHolidays: TcxGroupBox
    Left = 8
    Top = 175
    Caption = 'Added holidays'
    TabOrder = 7
    Height = 200
    Width = 700
    object lbxAllAddedHolidays: TcxListBox
      Left = 8
      Top = 16
      Width = 684
      Height = 174
      Align = alCustom
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 16
      ListStyle = lbOwnerDrawFixed
      ParentFont = False
      TabOrder = 0
    end
  end
  object gbLocations: TcxGroupBox
    Left = 8
    Top = 39
    Caption = 'Locations'
    Style.TransparentBorder = True
    TabOrder = 5
    Height = 130
    Width = 302
    object clbLocations: TcxCheckListBox
      Left = 8
      Top = 16
      Width = 195
      Height = 106
      Align = alCustom
      AllowDblClickToggle = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      EditValueFormat = cvfIndices
      Items = <>
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      OnClick = clbLocationsClick
      OnClickCheck = clbLocationsClickCheck
      OnDblClick = clbLocationsDblClick
      OnEditValueChanged = clbLocationsClick
      OnKeyDown = clbLocationsKeyDown
    end
    object btnLocationAdd: TcxButton
      Left = 209
      Top = 16
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Add'
      TabOrder = 1
      OnClick = btnLocationClick
    end
    object btnLocationEdit: TcxButton
      Tag = 1
      Left = 209
      Top = 45
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Edit'
      TabOrder = 2
      OnClick = btnLocationClick
    end
    object btnLocationDelete: TcxButton
      Tag = 2
      Left = 209
      Top = 74
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Delete'
      TabOrder = 3
      OnClick = btnLocationClick
    end
  end
  object gbHolidays: TcxGroupBox
    Left = 318
    Top = 39
    Caption = 'Holidays'
    TabOrder = 6
    Height = 130
    Width = 390
    object clbHolidays: TcxCheckListBox
      Left = 8
      Top = 16
      Width = 283
      Height = 106
      Align = alCustom
      AllowDblClickToggle = False
      Anchors = [akLeft, akTop, akRight, akBottom]
      EditValueFormat = cvfStatesString
      Items = <>
      ParentFont = False
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clWindowText
      Style.Font.Height = -11
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      OnClickCheck = clbHolidaysClickCheck
      OnDblClick = clbHolidaysDblClick
      OnKeyDown = clbHolidaysKeyDown
    end
    object btnHolidaysAdd: TcxButton
      Left = 297
      Top = 16
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Add'
      TabOrder = 1
      OnClick = btnHolidaysClick
    end
    object btnHolidaysDelete: TcxButton
      Tag = 2
      Left = 297
      Top = 74
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Delete'
      TabOrder = 3
      OnClick = btnHolidaysClick
    end
    object btnHolidaysEdit: TcxButton
      Tag = 1
      Left = 297
      Top = 45
      Width = 85
      Height = 23
      Anchors = [akTop, akRight]
      Caption = 'Edit'
      TabOrder = 2
      OnClick = btnHolidaysClick
    end
  end
  object btnOk: TcxButton
    Left = 443
    Top = 383
    Width = 85
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 533
    Top = 383
    Width = 85
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object btnApply: TcxButton
    Left = 623
    Top = 383
    Width = 85
    Height = 23
    Caption = 'Apply'
    TabOrder = 2
    OnClick = btnApplyClick
  end
  object btnExport: TcxButton
    Left = 128
    Top = 8
    Width = 112
    Height = 23
    Caption = 'btnExport'
    TabOrder = 4
    OnClick = btnExportClick
  end
end
