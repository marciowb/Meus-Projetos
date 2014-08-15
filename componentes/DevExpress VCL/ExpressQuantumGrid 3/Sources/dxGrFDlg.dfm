object fmCustomDialog: TfmCustomDialog
  Left = 382
  Top = 287
  HorzScrollBar.Visible = False
  VertScrollBar.Visible = False
  BorderIcons = [biSystemMenu, biHelp]
  BorderStyle = bsDialog
  Caption = 'Custom AutoFilter'
  ClientHeight = 166
  ClientWidth = 412
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
  object LColumnName: TLabel
    Left = 8
    Top = 27
    Width = 66
    Height = 13
    Caption = 'ColumnName '
  end
  object lblSingle: TLabel
    Left = 8
    Top = 134
    Width = 185
    Height = 13
    Caption = 'Use ? to represent any single character'
    Visible = False
  end
  object lblSeries: TLabel
    Left = 8
    Top = 153
    Width = 200
    Height = 13
    Caption = 'Use * to represent any series of characters'
    Visible = False
  end
  object Edit1: TLabel
    Left = 214
    Top = 46
    Width = 185
    Height = 21
    AutoSize = False
    Color = clBtnFace
    ParentColor = False
    Visible = False
  end
  object Edit2: TLabel
    Left = 214
    Top = 96
    Width = 185
    Height = 21
    AutoSize = False
    Color = clBtnFace
    ParentColor = False
    Visible = False
  end
  object cbOperator1: TLabel
    Left = 14
    Top = 46
    Width = 185
    Height = 21
    AutoSize = False
    Color = clBtnFace
    ParentColor = False
    Visible = False
  end
  object cbOperator2: TLabel
    Left = 14
    Top = 96
    Width = 185
    Height = 21
    AutoSize = False
    Color = clBtnFace
    ParentColor = False
    Visible = False
  end
  object rbAnd: TRadioButton
    Left = 60
    Top = 74
    Width = 41
    Height = 17
    Caption = '&And'
    Checked = True
    TabOrder = 0
    TabStop = True
  end
  object rbOr: TRadioButton
    Left = 118
    Top = 74
    Width = 33
    Height = 17
    Caption = '&Or'
    TabOrder = 1
  end
  object btnOK: TButton
    Left = 248
    Top = 136
    Width = 75
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnCancel: TButton
    Left = 330
    Top = 136
    Width = 75
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
