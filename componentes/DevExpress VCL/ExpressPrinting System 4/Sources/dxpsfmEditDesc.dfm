object dxfmEditDescription: TdxfmEditDescription
  Left = 383
  Top = 205
  BorderStyle = bsDialog
  Caption = 'Edit Description'
  ClientHeight = 308
  ClientWidth = 347
  Color = clBtnFace
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object gbxMemoHost: TcxGroupBox
    Left = 12
    Top = 12
    PanelStyle.Active = True
    TabOrder = 0
    Height = 250
    Width = 323
    object memDescription: TcxMemo
      Left = 11
      Top = 11
      Anchors = [akLeft, akTop, akRight, akBottom]
      TabOrder = 0
      Height = 228
      Width = 302
    end
  end
  object btnOK: TcxButton
    Left = 68
    Top = 273
    Width = 85
    Height = 23
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 159
    Top = 273
    Width = 85
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TcxButton
    Left = 250
    Top = 273
    Width = 85
    Height = 23
    Caption = '&Help'
    TabOrder = 3
  end
end
