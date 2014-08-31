object frmLincenca: TfrmLincenca
  Left = 0
  Top = 0
  BorderIcons = []
  Caption = 'Licen'#231'a'
  ClientHeight = 247
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TcxPageControl
    Left = 0
    Top = 0
    Width = 400
    Height = 206
    ActivePage = tsSerial
    Align = alClient
    TabOrder = 0
    ExplicitTop = -8
    ExplicitHeight = 196
    ClientRectBottom = 206
    ClientRectRight = 400
    ClientRectTop = 24
    object tsBemVndo: TcxTabSheet
      Caption = 'tsBemVndo'
      ImageIndex = 0
      ExplicitWidth = 289
      ExplicitHeight = 169
      object Panel1: TPanel
        Tag = 99
        Left = 0
        Top = 0
        Width = 400
        Height = 81
        Align = alTop
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 8
          Width = 125
          Height = 31
          Caption = 'Bem vindo'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -27
          Font.Name = 'Times New Roman'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 10
          Top = 34
          Width = 385
          Height = 13
          Caption = 
            'Esse assistente ir'#225' te ajudar a licenciar o software PAN - impre' +
            'ss'#227'o de etiquetas'
        end
      end
      object Panel5: TPanel
        Left = 0
        Top = 81
        Width = 400
        Height = 101
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitLeft = 64
        ExplicitTop = 104
        ExplicitWidth = 185
        ExplicitHeight = 41
      end
    end
    object tsLicencas: TcxTabSheet
      Caption = 'tsLicencas'
      ImageIndex = 1
      ExplicitWidth = 289
      ExplicitHeight = 169
      object Panel4: TPanel
        Left = 0
        Top = 0
        Width = 400
        Height = 182
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 24
        ExplicitTop = 72
        ExplicitWidth = 185
        ExplicitHeight = 41
        object grpLicenca: TRadioGroup
          Left = 56
          Top = 38
          Width = 289
          Height = 105
          Items.Strings = (
            'Usar licen'#231'a Trial (15 dias de uso)'
            'Eu possuo um serial key e quero usar a licen'#231'a full')
          TabOrder = 0
        end
      end
    end
    object tsSerial: TcxTabSheet
      Caption = 'tsSerial'
      ImageIndex = 2
      ExplicitHeight = 223
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 400
        Height = 182
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitTop = 70
        ExplicitHeight = 111
        object Label1: TLabel
          Left = 24
          Top = 77
          Width = 31
          Height = 13
          Caption = 'Chave'
        end
        object SpeedButton1: TSpeedButton
          Left = 343
          Top = 43
          Width = 50
          Height = 31
          Caption = 'Copiar'
          Flat = True
          OnClick = SpeedButton1Click
        end
        object SpeedButton2: TSpeedButton
          Left = 343
          Top = 92
          Width = 50
          Height = 31
          Caption = 'Colar'
          Flat = True
          OnClick = SpeedButton2Click
        end
        object edtSerial: TMaskEdit
          Left = 24
          Top = 92
          Width = 313
          Height = 33
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlue
          Font.Height = -21
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
        end
        object edtString: TLabeledEdit
          Left = 24
          Top = 43
          Width = 313
          Height = 31
          EditLabel.Width = 289
          EditLabel.Height = 13
          EditLabel.Caption = 'String key(Envie esse serial para obter a chave de ativa'#231#227'o)'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
      end
    end
    object tsFim: TcxTabSheet
      Caption = 'tsFim'
      ImageIndex = 3
      ExplicitHeight = 223
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 206
    Width = 400
    Height = 41
    Align = alBottom
    BevelKind = bkSoft
    TabOrder = 1
    object btnVoltar: TBitBtn
      Left = 136
      Top = 6
      Width = 75
      Height = 25
      Caption = '< &Voltar'
      Enabled = False
      TabOrder = 0
      OnClick = btnVoltarClick
    end
    object btnAvancar: TBitBtn
      Left = 217
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Avancar >'
      TabOrder = 1
      OnClick = btnAvancarClick
    end
    object btnCancelar: TBitBtn
      Left = 304
      Top = 6
      Width = 75
      Height = 25
      Caption = '&Cancelar'
      TabOrder = 2
      OnClick = btnCancelarClick
    end
  end
  object Computer: TJvComputerInfoEx
    Left = 312
    Top = 16
  end
end
