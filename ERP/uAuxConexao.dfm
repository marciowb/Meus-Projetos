inherited frmAuxCOnexao: TfrmAuxCOnexao
  Caption = 'Assistente de conex'#227'o'
  ClientHeight = 196
  ClientWidth = 305
  ExplicitWidth = 321
  ExplicitHeight = 235
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 155
    Width = 305
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 176
    ExplicitTop = 168
    ExplicitWidth = 185
    object BitBtn1: TBitBtn
      Left = 80
      Top = 6
      Width = 75
      Height = 25
      DoubleBuffered = True
      Kind = bkClose
      ParentDoubleBuffered = False
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 166
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Conctar'
      DoubleBuffered = True
      ParentDoubleBuffered = False
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 305
    Height = 155
    Align = alClient
    Caption = ' Dados da conex'#227'o '
    TabOrder = 1
    ExplicitLeft = 192
    ExplicitTop = 56
    ExplicitWidth = 185
    ExplicitHeight = 105
    object Label1: TLabel
      Left = 176
      Top = 15
      Width = 26
      Height = 13
      Caption = 'Porta'
    end
    object edtHost: TLabeledEdit
      Left = 32
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'Host'
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 32
      Top = 72
      Width = 209
      Height = 21
      EditLabel.Width = 175
      EditLabel.Height = 13
      EditLabel.Caption = 'Local do banco de dados no servidor'
      TabOrder = 1
    end
    object LabeledEdit3: TLabeledEdit
      Left = 32
      Top = 120
      Width = 81
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'Usu'#225'rio'
      TabOrder = 2
      Text = 'SYSDBA'
    end
    object edtPorta: TSpinEdit
      Left = 176
      Top = 32
      Width = 65
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 3
      Value = 3050
    end
    object edtSenha: TLabeledEdit
      Left = 119
      Top = 120
      Width = 122
      Height = 21
      EditLabel.Width = 30
      EditLabel.Height = 13
      EditLabel.Caption = 'Senha'
      PasswordChar = 'A'
      TabOrder = 4
      Text = 'masterkey'
    end
  end
end
