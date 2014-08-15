object fmHolidaysLocationHolidayEditor: TfmHolidaysLocationHolidayEditor
  Left = 695
  Top = 316
  ActiveControl = teName
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'fmHolidaysLocationHolidayEditor'
  ClientHeight = 97
  ClientWidth = 320
  Color = clBtnFace
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object lbName: TcxLabel
    Left = 6
    Top = 10
    Caption = 'lbName'
  end
  object teName: TcxTextEdit
    Left = 112
    Top = 8
    Properties.OnChange = ValueChange
    TabOrder = 1
    Width = 200
  end
  object btnOk: TcxButton
    Left = 133
    Top = 66
    Width = 85
    Height = 23
    Caption = 'btnOk'
    ModalResult = 1
    TabOrder = 3
    OnClick = btnOkClick
  end
  object btnCancel: TcxButton
    Left = 226
    Top = 66
    Width = 85
    Height = 23
    Cancel = True
    Caption = 'btnCancel'
    ModalResult = 2
    TabOrder = 5
  end
  object lbDate: TcxLabel
    Left = 6
    Top = 38
    Caption = 'lbDate'
  end
  object deDate: TcxDateEdit
    Left = 112
    Top = 37
    Properties.OnChange = ValueChange
    Properties.OnEditValueChanged = ValueChange
    TabOrder = 2
    Width = 200
  end
end
