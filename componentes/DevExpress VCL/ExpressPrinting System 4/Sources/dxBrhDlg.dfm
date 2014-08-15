object dxBrushDlg: TdxBrushDlg
  Left = 363
  Top = 214
  ActiveControl = ccbxColor
  BorderStyle = bsDialog
  Caption = 'Setup Brush properties'
  ClientHeight = 150
  ClientWidth = 284
  Color = clBtnFace
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  AutoScroll = False
  object GroupBox: TcxGroupBox
    Left = 12
    Top = 12
    PanelStyle.Active = True
    TabOrder = 0
    Height = 93
    Width = 260
    object bvlStyleHolder: TBevel
      Left = 69
      Top = 50
      Width = 170
      Height = 21
    end
    object lblColor: TcxLabel
      Left = 19
      Top = 20
      Caption = '&Color:'
      FocusControl = ccbxColor
      Transparent = True
      OnClick = lblClick
    end
    object lblStyle: TcxLabel
      Left = 19
      Top = 52
      Caption = '&Style:'
      Transparent = True
      OnClick = lblClick
    end
    object ccbxColor: TcxColorComboBox
      Left = 69
      Top = 18
      Properties.AllowSelectColor = True
      Properties.CustomColors = <>
      TabOrder = 2
      Width = 170
    end
  end
  object btnOK: TcxButton
    Left = 96
    Top = 115
    Width = 85
    Height = 23
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 1
  end
  object btnCancel: TcxButton
    Left = 187
    Top = 115
    Width = 85
    Height = 23
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
