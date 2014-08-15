object fmSpellCheckerAutoCorrectExceptionsForm: TfmSpellCheckerAutoCorrectExceptionsForm
  Left = 412
  Top = 178
  BorderStyle = bsDialog
  ClientHeight = 421
  ClientWidth = 318
  Color = clBtnFace
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object gbFirstLetter: TcxGroupBox
    Left = 8
    Top = 8
    Anchors = [akLeft, akTop, akRight]
    Caption = 'gbFirstLetter'
    Style.TransparentBorder = False
    TabOrder = 0
    Height = 183
    Width = 301
  end
  object gbInitialCaps: TcxGroupBox
    Left = 8
    Top = 199
    Anchors = [akLeft, akTop, akRight]
    Caption = 'gbInitialCaps'
    Style.TransparentBorder = False
    TabOrder = 1
    Height = 183
    Width = 301
  end
  object btnOk: TcxButton
    Left = 158
    Top = 390
    Width = 73
    Height = 23
    Anchors = [akRight, akBottom]
    Caption = 'btnOk'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
  object btnClose: TcxButton
    Left = 237
    Top = 390
    Width = 73
    Height = 23
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'btnClose'
    ModalResult = 2
    TabOrder = 3
  end
end
