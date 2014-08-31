inherited frmSobre: TfrmSobre
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Sobre'
  ClientHeight = 299
  ClientWidth = 355
  ExplicitWidth = 363
  ExplicitHeight = 326
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 355
    Height = 25
    Align = alTop
    Alignment = taCenter
    Caption = 'Sistema PAN'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 134
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 25
    Width = 355
    Height = 128
    Align = alTop
    Caption = ' Detalhes do sistema '
    TabOrder = 0
    object lblLocal: TLabel
      Left = 16
      Top = 32
      Width = 34
      Height = 13
      Caption = 'lblLocal'
    end
    object lblVersao: TLabel
      Left = 16
      Top = 56
      Width = 43
      Height = 13
      Caption = 'lblVersao'
    end
    object lblSistema: TLabel
      Left = 16
      Top = 79
      Width = 47
      Height = 13
      Caption = 'lblSistema'
    end
    object lblHost: TLabel
      Left = 16
      Top = 102
      Width = 32
      Height = 13
      Caption = 'lblHost'
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 258
    Width = 355
    Height = 41
    Align = alBottom
    TabOrder = 1
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 153
    Width = 355
    Height = 105
    Align = alClient
    Caption = ' Suporte '
    TabOrder = 2
    object lblTel: TLabel
      Left = 13
      Top = 32
      Width = 104
      Height = 13
      Caption = 'Telefone : 8589-2803'
    end
    object lblEmail: TLabel
      Left = 13
      Top = 56
      Width = 35
      Height = 13
      Caption = 'E-Mail :'
    end
    object Label2: TLabel
      Left = 59
      Top = 84
      Width = 291
      Height = 13
      Caption = 'Contatos telef'#244'nicos somente no hor'#225'rio comercial.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 54
      Top = 56
      Width = 111
      Height = 13
      Caption = 'raphael66x@gmail.com'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
end
