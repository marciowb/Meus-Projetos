object dxfmDateTimeFormats: TdxfmDateTimeFormats
  Left = 350
  Top = 153
  BorderStyle = bsDialog
  Caption = 'Change Date and Time Formats'
  ClientHeight = 358
  ClientWidth = 298
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOK: TcxButton
    Left = 12
    Top = 324
    Width = 87
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 106
    Top = 324
    Width = 87
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TcxButton
    Left = 200
    Top = 324
    Width = 87
    Height = 23
    Caption = '&Help'
    TabOrder = 3
  end
  object GroupBox1: TcxGroupBox
    Left = 12
    Top = 12
    PanelStyle.Active = True
    TabOrder = 0
    Height = 301
    Width = 275
    object lblAvailableDateFormats: TcxLabel
      Left = 11
      Top = 15
      Caption = 'Available &Date Formats:'
      Transparent = True
      OnClick = lblAvailableDateFormatsClick
    end
    object lblAvailableTimeFormats: TcxLabel
      Left = 11
      Top = 179
      Caption = 'Available Time &Formats:'
      Transparent = True
      OnClick = lblAvailableDateFormatsClick
    end
    object btnDefault: TcxButton
      Left = 178
      Top = 265
      Width = 86
      Height = 23
      Caption = '&Default ...'
      TabOrder = 3
      OnClick = btnDefaultClick
    end
    object chbxAutoUpdate: TcxCheckBox
      Left = 11
      Top = 268
      Caption = '&Update Automatically '
      Style.TransparentBorder = False
      TabOrder = 2
      Transparent = True
      OnClick = chbxAutoUpdateClick
      Width = 167
    end
    object lbxDateFormats: TcxListBox
      Left = 11
      Top = 32
      Width = 253
      Height = 145
      ItemHeight = 13
      Style.TransparentBorder = False
      TabOrder = 0
      OnClick = lbxDateFormatsClick
      OnDblClick = lbxDTFormatsDblClick
    end
    object lbxTimeFormats: TcxListBox
      Left = 11
      Top = 196
      Width = 253
      Height = 59
      ItemHeight = 13
      Style.TransparentBorder = False
      TabOrder = 1
      OnClick = TimeFormatsChanged
      OnDblClick = lbxDTFormatsDblClick
    end
  end
end
