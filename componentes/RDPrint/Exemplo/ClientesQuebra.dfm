object DFM_ClientesQuebra: TDFM_ClientesQuebra
  Left = 221
  Top = 140
  Width = 479
  Height = 296
  Caption = 'RDprint - Listagem de Clientes com Quebra'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 17
    Top = 48
    Width = 185
    Height = 62
  end
  object Label1: TLabel
    Left = 41
    Top = 7
    Width = 386
    Height = 29
    Caption = 'Listagem de Clientes com Quebra'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 276
    Top = 221
    Width = 84
    Height = 32
    Caption = '&Imprimir'
    TabOrder = 4
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 372
    Top = 221
    Width = 84
    Height = 32
    Caption = '&Sair'
    TabOrder = 5
    OnClick = BitBtn2Click
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
  object CheckBox3: TCheckBox
    Left = 25
    Top = 52
    Width = 145
    Height = 17
    Caption = 'Saltar p'#225'gina na Quebra'
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 25
    Top = 71
    Width = 153
    Height = 17
    Caption = 'Visualizar Relat'#243'rio'
    Checked = True
    State = cbChecked
    TabOrder = 1
  end
  object CheckBox2: TCheckBox
    Left = 25
    Top = 89
    Width = 161
    Height = 17
    Caption = 'Chamar SETUP RDprint'
    TabOrder = 2
  end
  object Memo1: TMemo
    Left = 16
    Top = 120
    Width = 440
    Height = 94
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      
        'Exemplo demonstrando como fazer uma QUEBRA, com sub-totais por c' +
        'idade e um Total '
      
        'Geral no final do relat'#243'rio, oferendo ainda, a op'#231#227'o de SALTAR p' +
        #225'gina a cada nova '
      'QUEBRA (cidade).'
      ''
      
        'Configura'#231#227'o do Componente para impress'#227'o comprimida em 12 cpp :' +
        ' '
      ''
      'TamanhoQteColunas := 96 colunas  '
      'FontePadr'#227'o  : 12cpp'
      ''
      'Este exemplo demonstra o uso dos seguintes recursos:'
      ''
      '- Cancelamento da impress'#227'o no SETUP;'
      '- Op'#231#227'o para mostrar PREVIEW ou n'#227'o;'
      '- Comando IMP - para imprimir STRING com a fonte padr'#227'o;'
      
        '- Comando IMPVAL para imprimir valores com MASCARA e  ALINHAMENT' +
        'O;'
      '- Uso dos eventos NEWPAGE e BEFORENEWPAGE para impress'#227'o do '
      'CABE'#199'ALHO E RODAP'#201)
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 3
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
    OpcoesPreview.Remalina = True
    OpcoesPreview.CaptionPreview = 'Visualiza'
    OpcoesPreview.PreviewZoom = 100
    OpcoesPreview.CorPapelPreview = clWhite
    OpcoesPreview.CorLetraPreview = clBlack
    OpcoesPreview.Preview = True
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
    TitulodoRelatorio = 'Relat'#243'rio de Clientes com Quebra'
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
    PortaComunicacao = 'LPT1'
    MostrarProgresso = True
    TamanhoQteLinhas = 66
    TamanhoQteColunas = 96
    TamanhoQteLPP = Seis
    NumerodeCopias = 1
    FonteTamanhoPadrao = S12cpp
    FonteEstiloPadrao = []
    Orientacao = poPortrait
    OnNewPage = RDprint1NewPage
    OnBeforeNewPage = RDprint1BeforeNewPage
    Left = 232
    Top = 48
  end
  object Query1: TQuery
    SQL.Strings = (
      'select *'
      'from empresa.db'
      'order by cidade, razao')
    Left = 280
    Top = 64
    object Query1Codigo: TIntegerField
      FieldName = 'Codigo'
    end
    object Query1Razao: TStringField
      FieldName = 'Razao'
      Size = 35
    end
    object Query1Endereco: TStringField
      FieldName = 'Endereco'
      Size = 30
    end
    object Query1Bairro: TStringField
      FieldName = 'Bairro'
      Size = 15
    end
    object Query1Cidade: TStringField
      FieldName = 'Cidade'
    end
    object Query1Estado: TStringField
      FieldName = 'Estado'
      Size = 2
    end
    object Query1Cep: TStringField
      FieldName = 'Cep'
      Size = 9
    end
    object Query1Data_Compra: TDateField
      FieldName = 'Data_Compra'
    end
    object Query1Valor_Compra: TBCDField
      FieldName = 'Valor_Compra'
      Size = 2
    end
    object Query1CGC_CPF: TStringField
      FieldName = 'CGC_CPF'
      Size = 18
    end
    object Query1Inscricao: TStringField
      FieldName = 'Inscricao'
      Size = 18
    end
  end
end
