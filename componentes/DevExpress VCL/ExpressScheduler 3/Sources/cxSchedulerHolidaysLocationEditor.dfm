object fmHolidaysLocationEditor: TfmHolidaysLocationEditor
  Left = 617
  Top = 345
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'fmHolidaysLocationEditor'
  ClientHeight = 68
  ClientWidth = 314
  Color = clBtnFace
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object lbName: TcxLabel
    Left = 6
    Top = 10
    Caption = 'lbName'
  end
  object teName: TcxTextEdit
    Left = 96
    Top = 8
    Properties.OnChange = teLocationPropertiesChange
    TabOrder = 1
    Width = 210
  end
  object btnOK: TcxButton
    Left = 128
    Top = 37
    Width = 85
    Height = 23
    Caption = 'btnOK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOKClick
  end
  object btnCancel: TcxButton
    Left = 221
    Top = 37
    Width = 85
    Height = 23
    Cancel = True
    Caption = 'btnCancel'
    ModalResult = 2
    TabOrder = 3
  end
end
