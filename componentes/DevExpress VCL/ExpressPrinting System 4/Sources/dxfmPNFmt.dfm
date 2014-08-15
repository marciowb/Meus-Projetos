object dxfmPageNumberFormat: TdxfmPageNumberFormat
  Left = 434
  Top = 210
  BorderStyle = bsDialog
  Caption = 'Change Page Number Format'
  ClientHeight = 207
  ClientWidth = 288
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object bvlStartAtHolder: TBevel
    Left = 118
    Top = 86
    Width = 158
    Height = 21
    Visible = False
  end
  object lblPageNumberFormat: TcxLabel
    Left = 12
    Top = 13
    Caption = 'Number &Format:'
    FocusControl = cbxPageNumberingFormat
    Transparent = True
    OnClick = lblPageNumberFormatClick
  end
  object lblPageNumbering: TcxLabel
    Left = 12
    Top = 37
    AutoSize = False
    Caption = 'Page Numbering'
    Properties.LineOptions.Visible = True
    Transparent = True
    Height = 19
    Width = 265
  end
  object rbtnContinueFromPrevSection: TcxRadioButton
    Left = 20
    Top = 61
    Width = 257
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Continue from Previous Section'
    Checked = True
    TabOrder = 1
    TabStop = True
    OnClick = rbtnContinueFromPrevSectionClick
    Transparent = True
  end
  object rbtnStartAt: TcxRadioButton
    Left = 20
    Top = 87
    Width = 92
    Height = 17
    Caption = 'Start &at:'
    TabOrder = 2
    OnClick = rbtnStartAtClick
    Transparent = True
  end
  object Bevel2: TcxLabel
    Left = 7
    Top = 113
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Properties.LineOptions.Visible = True
    Transparent = True
    Height = 10
    Width = 269
  end
  object cxLabel1: TcxLabel
    Left = 7
    Top = 157
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
    Properties.LineOptions.Visible = True
    Transparent = True
    Height = 10
    Width = 270
  end
  object btnOK: TcxButton
    Left = 10
    Top = 173
    Width = 85
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
  end
  object btnCancel: TcxButton
    Left = 101
    Top = 173
    Width = 85
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object btnHelp: TcxButton
    Left = 192
    Top = 173
    Width = 85
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = '&Help'
    TabOrder = 6
  end
  object btnDefault: TcxButton
    Left = 191
    Top = 129
    Width = 85
    Height = 23
    Anchors = [akTop, akRight]
    Caption = '&Default...'
    TabOrder = 3
    OnClick = btnDefaultClick
  end
  object cbxPageNumberingFormat: TcxComboBox
    Left = 112
    Top = 12
    Anchors = [akLeft, akTop, akRight]
    Properties.OnChange = cbxPageNumberingFormatChange
    TabOrder = 0
    Width = 165
  end
end
