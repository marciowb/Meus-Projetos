object FSelectUnion: TFSelectUnion
  Left = 425
  Top = 211
  BorderStyle = bsDialog
  Caption = 'Select Union'
  ClientHeight = 298
  ClientWidth = 278
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object lbUnions: TListBox
    Left = 10
    Top = 10
    Width = 258
    Height = 249
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 0
  end
  object Button2: TButton
    Left = 112
    Top = 265
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object Button1: TButton
    Left = 193
    Top = 265
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
