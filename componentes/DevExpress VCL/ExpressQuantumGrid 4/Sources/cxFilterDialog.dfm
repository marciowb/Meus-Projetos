object cxFilterDialog: TcxFilterDialog
  Left = 427
  Top = 113
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  ActiveControl = cbOperator1
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'Custom Filter'
  ClientHeight = 175
  ClientWidth = 414
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object lblTitle: TLabel
    Left = 8
    Top = 8
    Width = 87
    Height = 13
    Caption = 'Show rows where:'
  end
  object bvlLine: TBevel
    Left = 8
    Top = 34
    Width = 396
    Height = 4
    Shape = bsTopLine
  end
  object lblColumnCaption: TLabel
    Left = 8
    Top = 27
    Width = 71
    Height = 13
    Caption = 'ColumnCaption'
  end
  object lblSingle: TLabel
    Left = 8
    Top = 134
    Width = 185
    Height = 13
    Caption = 'Use ? to represent any single character'
  end
  object lblSeries: TLabel
    Left = 8
    Top = 153
    Width = 200
    Height = 13
    Caption = 'Use * to represent any series of characters'
  end
  object lblEdit1PlaceHolder: TLabel
    Left = 208
    Top = 46
    Width = 193
    Height = 21
    AutoSize = False
    Color = clGreen
    ParentColor = False
    Visible = False
  end
  object lblEdit2PlaceHolder: TLabel
    Left = 208
    Top = 96
    Width = 193
    Height = 21
    AutoSize = False
    Color = clGreen
    ParentColor = False
    Visible = False
  end
  object cbOperator1: TcxComboBox
    Left = 8
    Top = 46
    Width = 193
    Height = 21
    Properties.DropDownListStyle = lsFixedList
    TabOrder = 0
    OnClick = cbOperator1Click
  end
  object cbOperator2: TcxComboBox
    Left = 8
    Top = 96
    Width = 193
    Height = 21
    Properties.DropDownListStyle = lsFixedList
    Properties.OnChange = cbOperator2PropertiesChange
    TabOrder = 3
  end
  object btnOK: TcxButton
    Left = 248
    Top = 144
    Width = 75
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 4
    UseSystemPaint = False
  end
  object btnCancel: TcxButton
    Left = 330
    Top = 144
    Width = 75
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
    UseSystemPaint = False
  end
  object rbAnd: TcxRadioButton
    Tag = 1
    Left = 56
    Top = 74
    Width = 60
    Height = 17
    Caption = '&And'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object rbOr: TcxRadioButton
    Tag = 1
    Left = 120
    Top = 74
    Width = 65
    Height = 17
    Caption = '&Or'
    TabOrder = 2
  end
end
