object DFM_Boletos: TDFM_Boletos
  Left = 35
  Top = 103
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'RDprint - Boletos'
  ClientHeight = 327
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel3: TBevel
    Left = 322
    Top = 58
    Width = 133
    Height = 220
    Shape = bsFrame
  end
  object Bevel2: TBevel
    Left = 7
    Top = 58
    Width = 317
    Height = 124
    Shape = bsFrame
  end
  object Bevel1: TBevel
    Left = 7
    Top = 180
    Width = 317
    Height = 98
    Shape = bsFrame
  end
  object Label3: TLabel
    Left = 22
    Top = 184
    Width = 125
    Height = 13
    Caption = 'Instru'#231'oes para Cobran'#231'a:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Faturamento: TLabel
    Left = 20
    Top = 66
    Width = 111
    Height = 13
    AutoSize = False
    Caption = 'Dados do Sacado:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 336
    Top = 107
    Width = 114
    Height = 13
    Caption = 'Quantidade de Parcelas'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 336
    Top = 66
    Width = 70
    Height = 13
    Caption = 'N'#186' Documento'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 36
    Top = 7
    Width = 400
    Height = 29
    Alignment = taCenter
    Caption = 'Emiss'#227'o de Boletos Pr'#233'-Impressos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label1: TLabel
    Left = 336
    Top = 148
    Width = 112
    Height = 13
    Alignment = taCenter
    Caption = 'Vencimento da 1'#186' Parc.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Anda: TGauge
    Left = 6
    Top = 293
    Width = 199
    Height = 24
    BackColor = clInfoBk
    ForeColor = clNavy
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    Progress = 0
  end
  object Label2: TLabel
    Left = 336
    Top = 189
    Width = 104
    Height = 13
    Caption = 'Taxa de Perman'#234'ncia'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 336
    Top = 230
    Width = 72
    Height = 13
    Caption = 'Valor do Boleto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 53
    Top = 38
    Width = 357
    Height = 13
    Alignment = taCenter
    Caption = 'Propriedades: TAMANHOQTELPP = OITO  E TAMANHOQTELINHAS = 32'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object msg1: TEdit
    Left = 19
    Top = 201
    Width = 291
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 40
    ParentFont = False
    TabOrder = 7
    Text = 'Protestar apos 3 dias do vencimento.'
  end
  object msg2: TEdit
    Left = 19
    Top = 224
    Width = 291
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 40
    ParentFont = False
    TabOrder = 8
    Text = 'Nao dispensar juros de mora'
  end
  object SAIR: TBitBtn
    Left = 364
    Top = 286
    Width = 90
    Height = 32
    Cancel = True
    Caption = '&Sair'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 16
    OnClick = SAIRClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333333333333333333333333333333333FF333333333333370733333333
      33333777F33333333333309073333333333337F77F3333F33333370907333733
      3333377F77F337F3333333709073003333333377F77F77F33333333709009033
      333333377F77373F33333333709999033333333377F3337F3333333330999903
      3333333337333373F333333309999990333333337FF33337F333333700999990
      33333337773FF3373F333333330099990333333333773FF37F33333333330099
      033333333333773F73F3333333333300903333333333337737F3333333333333
      0033333333333333773333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object IMPRIMIR: TBitBtn
    Left = 263
    Top = 287
    Width = 90
    Height = 32
    Caption = '&Imprimir'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    OnClick = IMPRIMIRClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      0003377777777777777308888888888888807F33333333333337088888888888
      88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
      8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
      8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
  end
  object msg3: TEdit
    Left = 19
    Top = 247
    Width = 291
    Height = 21
    MaxLength = 40
    TabOrder = 9
  end
  object NOSSONUM: TMaskEdit
    Left = 334
    Top = 81
    Width = 107
    Height = 21
    EditMask = '000.000;1;_'
    MaxLength = 7
    TabOrder = 10
    Text = '000.000'
  end
  object parcelas: TSpinEdit
    Left = 334
    Top = 122
    Width = 107
    Height = 22
    MaxValue = 99
    MinValue = 1
    TabOrder = 11
    Value = 1
  end
  object Edit1: TEdit
    Left = 19
    Top = 81
    Width = 291
    Height = 21
    MaxLength = 40
    TabOrder = 0
    Text = 'Deltress Informatica Ltda'
  end
  object Edit2: TEdit
    Left = 19
    Top = 105
    Width = 291
    Height = 21
    MaxLength = 40
    TabOrder = 1
    Text = 'Rua Nassimen Mussi, 575'
  end
  object Edit3: TEdit
    Left = 19
    Top = 129
    Width = 78
    Height = 21
    MaxLength = 40
    TabOrder = 2
    Text = '17519-570'
  end
  object Edit4: TEdit
    Left = 99
    Top = 129
    Width = 166
    Height = 21
    MaxLength = 40
    TabOrder = 3
    Text = 'Marilia'
  end
  object Edit5: TEdit
    Left = 271
    Top = 129
    Width = 38
    Height = 21
    MaxLength = 40
    TabOrder = 4
    Text = 'SP'
  end
  object vencimento: TMaskEdit
    Left = 334
    Top = 163
    Width = 107
    Height = 21
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 12
    Text = '  /  /    '
  end
  object taxa: TEdit
    Left = 334
    Top = 204
    Width = 105
    Height = 21
    TabOrder = 13
    Text = '7,5'
  end
  object valor: TEdit
    Left = 334
    Top = 245
    Width = 105
    Height = 21
    Color = 14221311
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    Text = '500,00'
  end
  object Edit6: TEdit
    Left = 19
    Top = 153
    Width = 142
    Height = 21
    MaxLength = 40
    TabOrder = 5
    Text = 'CGC'
  end
  object Edit7: TEdit
    Left = 167
    Top = 153
    Width = 142
    Height = 21
    MaxLength = 40
    TabOrder = 6
    Text = 'IE'
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
    RegistroUsuario.SerieProduto = 'SITE - USO INTERNO'
    RegistroUsuario.AutorizacaoKey = 'COYL-7054-DRSU-0796-VEBX'
    About = 'RDprint 4.0d - Registrado'
    Acentuacao = Transliterate
    CaptionSetup = 'Rdprint Setup'
    TitulodoRelatorio = 'Exemplo de Boleto Bancario Pr'#233'-Impresso'
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
    TamanhoQteLinhas = 32
    TamanhoQteColunas = 80
    TamanhoQteLPP = Oito
    NumerodeCopias = 1
    FonteTamanhoPadrao = S10cpp
    FonteEstiloPadrao = []
    Orientacao = poPortrait
    Left = 224
    Top = 192
  end
end
