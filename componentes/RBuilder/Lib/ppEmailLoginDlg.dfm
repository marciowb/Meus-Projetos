object ppEmailLoginDialog: TppEmailLoginDialog
  Left = 483
  Top = 410
  Width = 551
  Height = 219
  Caption = 'Login'
  Color = clBtnFace
  ParentFont = True
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object btnOk: TButton
    Left = 360
    Top = 144
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 0
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 440
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object gbxHost: TGroupBox
    Left = 8
    Top = 8
    Width = 505
    Height = 41
    TabOrder = 2
    object Label1: TLabel
      Left = 12
      Top = 15
      Width = 66
      Height = 13
      Caption = 'Host Address:'
    end
    object edtHostAddr: TEdit
      Left = 92
      Top = 13
      Width = 400
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
  end
  object gbxUser: TGroupBox
    Left = 8
    Top = 56
    Width = 297
    Height = 73
    TabOrder = 3
    object Label2: TLabel
      Left = 12
      Top = 17
      Width = 56
      Height = 13
      Caption = 'User Name:'
    end
    object Label3: TLabel
      Left = 12
      Top = 45
      Width = 49
      Height = 13
      Caption = 'Password:'
    end
    object edtUserName: TEdit
      Left = 91
      Top = 14
      Width = 193
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
    end
    object edtPass: TEdit
      Left = 91
      Top = 44
      Width = 193
      Height = 19
      Ctl3D = False
      ParentCtl3D = False
      PasswordChar = '*'
      TabOrder = 1
    end
  end
  object btnTest: TButton
    Left = 8
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Test'
    TabOrder = 4
    OnClick = btnTestClick
  end
end
