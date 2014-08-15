object DFM_DARUMA: TDFM_DARUMA
  Left = 37
  Top = 68
  AutoScroll = False
  BorderIcons = [biSystemMenu]
  Caption = 'RDprint - Imprimindo na DARUMA DUAL N'#195'O FISCAL'
  ClientHeight = 372
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Shape1: TShape
    Left = 8
    Top = 64
    Width = 457
    Height = 105
  end
  object Bevel3: TBevel
    Left = 7
    Top = 176
    Width = 458
    Height = 153
    Shape = bsFrame
  end
  object Label17: TLabel
    Left = 279
    Top = 185
    Width = 127
    Height = 13
    Caption = 'FUN'#199#213'ES ESPECIAIS'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 56
    Top = 8
    Width = 344
    Height = 19
    Caption = 'RDPRINT - Imprimindo em Mini-Impressoras *'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 31
    Top = 185
    Width = 212
    Height = 13
    Caption = 'EXEMPLOS DE CUPOM N'#195'O FISCAL'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 144
    Top = 27
    Width = 180
    Height = 16
    Caption = 'modelo: DARUMA DS340/348'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 14
    Top = 68
    Width = 438
    Height = 15
    Caption = 
      '* ATEN'#199#195'O:  O RDprint N'#195'O foi projetado para trabalhar com mini-' +
      'impressoras.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label5: TLabel
    Left = 21
    Top = 86
    Width = 408
    Height = 56
    Alignment = taCenter
    Caption = 
      'Mini-Impressoras possuem comandos pr'#243'prios. Seu comportamento '#233' ' +
      'diferente das matricias comuns. Entretanto, '#233' poss'#237'vel imprimir ' +
      'utilizando o modelo BOBINA onde NENHUM comando '#233' enviado, fica a' +
      ' seu cargo enviar o comando (IMPASCII) para NEGRITO, EXPADINDO e' +
      'tc, de acordo com os recursos de cada Fabricante / Modelo.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object Label6: TLabel
    Left = 32
    Top = 149
    Width = 408
    Height = 16
    Caption = 'ESTE '#201' APENAS UM EXEMPLO.  USE POR SUA CONTA E RISCO !'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label7: TLabel
    Left = 64
    Top = 43
    Width = 315
    Height = 16
    Caption = 'Compat'#237'vel tamb'#233'm com: PROCOMP DieBold (ok)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 8
    Top = 344
    Width = 97
    Height = 14
    Caption = 'Powered by RDPrint'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 360
    Top = 344
    Width = 96
    Height = 14
    Caption = 'Deltress Inform'#225'tica'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn2: TBitBtn
    Left = 80
    Top = 208
    Width = 120
    Height = 32
    Caption = 'Imprimir Texto Simples'
    TabOrder = 0
    OnClick = BitBtn2Click
  end
  object BitBtn3: TBitBtn
    Left = 80
    Top = 248
    Width = 120
    Height = 32
    Caption = 'Imprime Linha a Linha'
    TabOrder = 1
    OnClick = BitBtn3Click
  end
  object BitBtn4: TBitBtn
    Left = 80
    Top = 288
    Width = 120
    Height = 32
    Caption = 'Imprime c/ recursos'
    TabOrder = 2
    OnClick = BitBtn4Click
  end
  object Button1: TButton
    Left = 280
    Top = 288
    Width = 120
    Height = 32
    Caption = 'Exemplos de Fontes'
    TabOrder = 5
    OnClick = Button1Click
  end
  object BitBtn5: TBitBtn
    Left = 280
    Top = 248
    Width = 120
    Height = 32
    Caption = 'Abrir Gaveta'
    TabOrder = 4
    OnClick = BitBtn5Click
  end
  object BitBtn6: TBitBtn
    Left = 280
    Top = 208
    Width = 120
    Height = 32
    Caption = 'Autentica'#231#227'o'
    TabOrder = 3
    OnClick = BitBtn6Click
  end
  object BitBtn1: TBitBtn
    Left = 185
    Top = 333
    Width = 120
    Height = 32
    Caption = 'Fechar'
    TabOrder = 6
    OnClick = BitBtn1Click
  end
  object RDprint1: TRDprint
    ImpressoraPersonalizada.NomeImpressora = 'Modelo Personalizado - (Epson)'
    ImpressoraPersonalizada.AvancaOitavos = '27 48'
    ImpressoraPersonalizada.AvancaSextos = '27 50'
    ImpressoraPersonalizada.SaltoPagina = '12'
    ImpressoraPersonalizada.TamanhoPagina = '27 67 66'
    ImpressoraPersonalizada.Negrito = '27 69'
    ImpressoraPersonalizada.Italico = '27 52'
    ImpressoraPersonalizada.Sublinhado = '27 45 49'
    ImpressoraPersonalizada.Expandido = '27 14'
    ImpressoraPersonalizada.Normal10 = '18 27 80'
    ImpressoraPersonalizada.Comprimir12 = '18 27 77'
    ImpressoraPersonalizada.Comprimir17 = '27 80 27 15'
    ImpressoraPersonalizada.Comprimir20 = '27 77 27 15'
    ImpressoraPersonalizada.Reset = '27 80 18 20 27 53 27 70 27 45 48'
    ImpressoraPersonalizada.Inicializar = '27 64'
    OpcoesPreview.PaginaZebrada = False
    OpcoesPreview.Remalina = False
    OpcoesPreview.CaptionPreview = 'Rdprint Preview'
    OpcoesPreview.PreviewZoom = 100
    OpcoesPreview.CorPapelPreview = clWhite
    OpcoesPreview.CorLetraPreview = clBlack
    OpcoesPreview.Preview = False
    OpcoesPreview.BotaoSetup = Ativo
    OpcoesPreview.BotaoImprimir = Ativo
    OpcoesPreview.BotaoGravar = Ativo
    OpcoesPreview.BotaoLer = Ativo
    OpcoesPreview.BotaoProcurar = Ativo
    Margens.Left = 10
    Margens.Right = 10
    Margens.Top = 10
    Margens.Bottom = 10
    Autor = Deltress
    RegistroUsuario.NomeRegistro = 'Deltress Inform'#225'tica Ltda'
    RegistroUsuario.SerieProduto = 'SITE:0206/999999'
    RegistroUsuario.AutorizacaoKey = 'COYL-0885-SXKR-5957-MVLN'
    About = 'RDprint 4.0d - Registrado'
    Acentuacao = Transliterate
    CaptionSetup = 'Rdprint Setup'
    TitulodoRelatorio = 'Gerado por RDprint'
    UsaGerenciadorImpr = True
    CorForm = clBtnFace
    CorFonte = clBlack
    Impressora = Epson
    Mapeamento.Strings = (
      '//--- Grafico Compativel com Windows/USB ---//'
      '//'
      'GRAFICO=GRAFICO'
      'HP=GRAFICO'
      'DESKJET=GRAFICO'
      'LASERJET=GRAFICO'
      'INKJET=GRAFICO'
      'STYLUS=GRAFICO'
      'EPL=GRAFICO'
      'USB=GRAFICO'
      '//'
      '//--- Linha Epson Matricial 9 e 24 agulhas ---//'
      '//'
      'EPSON=EPSON'
      'GENERICO=EPSON'
      'LX-300=EPSON'
      'LX-810=EPSON'
      'FX-2170=EPSON'
      'FX-1170=EPSON'
      'LQ-1170=EPSON'
      'LQ-2170=EPSON'
      'OKIDATA=EPSON'
      '//'
      '//--- Rima e Emilia ---//'
      '//'
      'RIMA=RIMA'
      'EMILIA=RIMA'
      '//'
      '//--- Linha HP/Xerox padr'#227'o PCL ---//'
      '//'
      'PCL=HP'
      '//'
      '//--- Impressoras 40 Colunas ---//'
      '//'
      'DARUMA=BOBINA'
      'SIGTRON=BOBINA'
      'SWEDA=BOBINA'
      'BEMATECH=BOBINA')
    MostrarProgresso = True
    TamanhoQteLinhas = 66
    TamanhoQteColunas = 80
    TamanhoQteLPP = Seis
    NumerodeCopias = 1
    FonteTamanhoPadrao = S10cpp
    FonteEstiloPadrao = []
    Orientacao = poPortrait
    Left = 232
    Top = 240
  end
end
