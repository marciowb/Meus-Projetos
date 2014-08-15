object dxfmSelectStyleClass: TdxfmSelectStyleClass
  Left = 427
  Top = 284
  BorderStyle = bsDialog
  Caption = 'Select PrintStyle Type'
  ClientHeight = 122
  ClientWidth = 320
  Color = clBtnFace
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOK: TcxButton
    Left = 41
    Top = 87
    Width = 85
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 132
    Top = 87
    Width = 85
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TcxButton
    Left = 223
    Top = 87
    Width = 85
    Height = 23
    Caption = '&Help'
    TabOrder = 3
  end
  object GroupBox1: TcxGroupBox
    Left = 12
    Top = 12
    PanelStyle.Active = True
    TabOrder = 0
    Height = 64
    Width = 296
    object cbxStyleTypes: TcxComboBox
      Left = 60
      Top = 24
      Properties.DropDownListStyle = lsFixedList
      Style.Color = clWindow
      TabOrder = 0
      Width = 220
    end
    object Label1: TcxLabel
      Left = 16
      Top = 26
      Caption = '&Type:'
      FocusControl = cbxStyleTypes
      Transparent = True
      OnClick = Label1Click
    end
  end
end
