object fmdxChangeFileName: TfmdxChangeFileName
  Left = 368
  Top = 184
  BorderStyle = bsDialog
  Caption = 'Choose New File Name'
  ClientHeight = 122
  ClientWidth = 356
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object btnOK: TcxButton
    Left = 109
    Top = 88
    Width = 75
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 190
    Top = 88
    Width = 75
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object btnHelp: TcxButton
    Left = 271
    Top = 88
    Width = 75
    Height = 23
    Caption = '&Help'
    TabOrder = 3
  end
  object GroupBox1: TcxGroupBox
    Left = 12
    Top = 12
    PanelStyle.Active = True
    TabOrder = 0
    Height = 65
    Width = 334
    object edFileName: TcxTextEdit
      Left = 10
      Top = 33
      TabOrder = 0
      Width = 314
    end
    object lblEnterNewFileName: TcxLabel
      Left = 10
      Top = 14
      Caption = '&Enter New File Name:'
      Transparent = True
    end
  end
end
