object fmGoToDateForm: TfmGoToDateForm
  Left = 160
  Top = 234
  BorderStyle = bsDialog
  Caption = 'fmGoToDateForm'
  ClientHeight = 90
  ClientWidth = 336
  Color = clBtnFace
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object cxGroupBox1: TcxGroupBox
    Left = 8
    Top = 4
    Width = 213
    Height = 77
    Style.HotTrack = False
    TabOrder = 0
    object lbDate: TLabel
      Left = 10
      Top = 20
      Width = 31
      Height = 13
      Caption = 'lbDate'
      FocusControl = deDate
    end
    object lbShowIn: TLabel
      Left = 10
      Top = 48
      Width = 44
      Height = 13
      Caption = 'lbShowIn'
      FocusControl = cbShowIn
    end
    object deDate: TcxDateEdit
      Left = 80
      Top = 16
      Width = 121
      Height = 21
      Properties.DateButtons = [btnToday]
      TabOrder = 0
    end
    object cbShowIn: TcxComboBox
      Left = 80
      Top = 44
      Width = 121
      Height = 21
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 1
    end
  end
  object btnOk: TcxButton
    Left = 232
    Top = 8
    Width = 95
    Height = 25
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 232
    Top = 42
    Width = 95
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
