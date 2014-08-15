object DFM_Regua: TDFM_Regua
  Left = 141
  Top = 172
  AutoScroll = False
  Caption = 'RDPrint - Imprimindo R'#233'gua Matriz'
  ClientHeight = 277
  ClientWidth = 413
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
  object Bevel1: TBevel
    Left = 13
    Top = 65
    Width = 386
    Height = 121
  end
  object Label12: TLabel
    Left = 217
    Top = 85
    Width = 99
    Height = 13
    Caption = 'Tamanho em Linhas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label18: TLabel
    Left = 217
    Top = 109
    Width = 106
    Height = 13
    Caption = 'Tamanho em Colunas:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 141
    Top = 11
    Width = 157
    Height = 29
    Alignment = taCenter
    Caption = 'R'#233'gua Matriz '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 40
    Top = 40
    Width = 329
    Height = 13
    Alignment = taCenter
    Caption = 'Imprime uma folha quadriculada com o n'#250'mero da LINHA E COLUNA.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 196
    Width = 383
    Height = 26
    Caption = 
      'DICA: Imprimindo em cima de uma NOTA FISCAL, ir'#225' auxiliar voc'#234' a' +
      '  possicionar corretamente cada um dos campos da NOTA.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGreen
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object RadioGroup1: TRadioGroup
    Left = 24
    Top = 80
    Width = 89
    Height = 97
    Caption = 'Fonte Padr'#227'o:'
    ItemIndex = 0
    Items.Strings = (
      '10 cpp'
      '12 cpp'
      '17 cpp'
      '20 cpp')
    TabOrder = 0
  end
  object QteCol: TEdit
    Left = 337
    Top = 109
    Width = 45
    Height = 21
    TabOrder = 3
    Text = '80'
  end
  object QteLin: TEdit
    Left = 337
    Top = 77
    Width = 45
    Height = 21
    TabOrder = 2
    Text = '66'
  end
  object RadioGroup2: TRadioGroup
    Left = 123
    Top = 80
    Width = 81
    Height = 97
    Caption = 'Avan'#231'o:'
    ItemIndex = 0
    Items.Strings = (
      'Sextos'
      'Oitavos')
    TabOrder = 1
  end
  object ESPACO: TRadioGroup
    Left = 216
    Top = 139
    Width = 169
    Height = 36
    Caption = 'Espa'#231'amento da R'#233'gua'
    Columns = 3
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemIndex = 1
    Items.Strings = (
      '3'
      '5'
      '10')
    ParentFont = False
    TabOrder = 4
  end
  object MATRIZ: TBitBtn
    Left = 160
    Top = 235
    Width = 105
    Height = 32
    Hint = 
      'Imprime uma folha quadriculada para auxilar na confec'#231#227'o do rela' +
      't'#243'rio'
    Caption = '&Imprimir'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
    TabStop = False
    OnClick = MATRIZClick
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FF1877A61877A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1877A644B0D32FA6CE1877A6FF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      1877A672CDE95AC2E340AFD22DA5CC1877A6FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF1877A698DFF465B7D14A98B155C0E13CACD129
      A3CB1877A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1877A6B3ECFB
      A7E6F775B7CB4E78874992A950BDE038ABCF26A1CB1877A6FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FF1877A6B3ECFB333333A3E5F775BCD2538292468AA04C
      BBDF33A8CE23A0C91877A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF26556C
      B3ECFBAFEAFAA0E3F679C4DA45626C4892AA47B9DD30A6CD209FC91877A6FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF1877A6B3ECFB3333339DE2F575B9CF5F
      A9C159C2E343B7DC2CA4CD1D9EC81877A6FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF26556CB3ECFBA9E7F899E0F483D6EE6CCBE855C0E13FB5DC29A3CB1B9D
      C71877A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1877A6B3ECFB33333395
      DDF37FD3ED68C9E750BDE13BB3DA26A2CB199CC61877A6FF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF26556CB1EBFBA3E4F790DCF27AD2EC63C6E54CBBDF37B1
      D923A0C9179BC61877A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1877A6AE
      EAFA3333338DDAF076CFEA5EC4E447B9DE33AFD9209EC81877A6FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FF26556CACE9F99CE1F588D8EF71CDE95AC2
      E343B7DD1877A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF1877A6AAE7F833333383D6EF6CCBE81877A6FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF26556CA6E6F794DEF31877
      A6FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF1877A61877A6FF00FFFF00FFFF00FFFF00FF}
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
    RegistroUsuario.NomeRegistro = 'Silenus Software ltda'
    RegistroUsuario.SerieProduto = 'SINGLE-1206/00715'
    RegistroUsuario.AutorizacaoKey = 'UMGP-7382-OVLR-1038-ADOG'
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
    Left = 24
    Top = 72
  end
end
