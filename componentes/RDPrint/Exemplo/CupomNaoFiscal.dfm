object DFM_CupomNaoFiscal: TDFM_CupomNaoFiscal
  Left = 79
  Top = 169
  AutoScroll = False
  Caption = 'RDprint - Cupom n'#227'o Fiscal'
  ClientHeight = 416
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel4: TBevel
    Left = 301
    Top = 37
    Width = 295
    Height = 93
    Shape = bsFrame
  end
  object Bevel3: TBevel
    Left = 8
    Top = 37
    Width = 295
    Height = 93
    Shape = bsFrame
  end
  object Label1: TLabel
    Left = 433
    Top = 82
    Width = 95
    Height = 13
    Caption = 'Operador/Vendedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DBText1: TDBText
    Left = 19
    Top = 82
    Width = 241
    Height = 17
    DataField = 'Endereco'
    DataSource = DataSource2
  end
  object DBText2: TDBText
    Left = 19
    Top = 96
    Width = 169
    Height = 17
    DataField = 'Cidade'
    DataSource = DataSource2
  end
  object DBText3: TDBText
    Left = 19
    Top = 110
    Width = 177
    Height = 17
    DataField = 'CGC_CPF'
    DataSource = DataSource2
  end
  object Label6: TLabel
    Left = 149
    Top = 3
    Width = 313
    Height = 29
    Alignment = taCenter
    Caption = 'Cupom N'#227'o Fiscal - Epson '
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Bevel2: TBevel
    Left = 8
    Top = 128
    Width = 295
    Height = 99
    Shape = bsFrame
  end
  object Bevel1: TBevel
    Left = 301
    Top = 128
    Width = 295
    Height = 99
    Shape = bsFrame
  end
  object Label3: TLabel
    Left = 321
    Top = 132
    Width = 66
    Height = 13
    Caption = 'Observa'#231#245'es:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Faturamento: TLabel
    Left = 20
    Top = 132
    Width = 111
    Height = 13
    AutoSize = False
    Caption = 'Transportadora:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 20
    Top = 58
    Width = 32
    Height = 13
    Caption = 'Cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 529
    Top = 43
    Width = 37
    Height = 13
    Caption = 'N'#250'mero'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 319
    Top = 83
    Width = 80
    Height = 13
    Alignment = taCenter
    Caption = 'Data de Emiss'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 11
    Top = 366
    Width = 52
    Height = 13
    Caption = 'Total Bruto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 106
    Top = 366
    Width = 58
    Height = 13
    Caption = '(-) Desconto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 203
    Top = 367
    Width = 63
    Height = 13
    Caption = 'Total L'#237'quido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 321
    Top = 42
    Width = 28
    Height = 13
    Caption = 'CFOP'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel
    Left = 361
    Top = 42
    Width = 108
    Height = 13
    Caption = 'Natureza da Opera'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 320
    Top = 204
    Width = 69
    Height = 13
    Caption = 'Duplicata  ==>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Button1: TButton
    Left = 477
    Top = 371
    Width = 120
    Height = 32
    Caption = 'Cupom  n'#227'o Fiscal'
    TabOrder = 20
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 431
    Top = 97
    Width = 149
    Height = 21
    MaxLength = 15
    TabOrder = 10
    Text = 'Corn'#233'lia'
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 18
    Top = 57
    Width = 269
    Height = 21
    KeyField = 'Codigo'
    ListField = 'Razao'
    ListSource = DataSource2
    TabOrder = 0
  end
  object msg1: TEdit
    Left = 318
    Top = 147
    Width = 263
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 40
    ParentFont = False
    TabOrder = 11
    Text = 'Entregar no Hor'#225'rio Comercial'
  end
  object msg2: TEdit
    Left = 318
    Top = 171
    Width = 263
    Height = 21
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 40
    ParentFont = False
    TabOrder = 12
  end
  object vencimento: TEdit
    Left = 396
    Top = 198
    Width = 67
    Height = 21
    MaxLength = 40
    TabOrder = 13
    Text = '15/11/2001'
  end
  object NUMERO: TMaskEdit
    Left = 521
    Top = 58
    Width = 59
    Height = 21
    EditMask = '000.000;1;_'
    MaxLength = 7
    ReadOnly = True
    TabOrder = 8
    Text = '001.758'
  end
  object Edit2: TEdit
    Left = 19
    Top = 147
    Width = 268
    Height = 21
    MaxLength = 40
    TabOrder = 1
    Text = 'Transportadora Entrega de Tudo Ltda'
  end
  object Edit3: TEdit
    Left = 19
    Top = 171
    Width = 267
    Height = 21
    MaxLength = 40
    TabOrder = 2
    Text = 'Rua Nassimen Mussi, 575'
  end
  object Edit4: TEdit
    Left = 19
    Top = 195
    Width = 78
    Height = 21
    MaxLength = 40
    TabOrder = 3
    Text = 'BZY-4765'
  end
  object Edit5: TEdit
    Left = 109
    Top = 195
    Width = 134
    Height = 21
    MaxLength = 40
    TabOrder = 4
    Text = 'Marilia'
  end
  object Edit6: TEdit
    Left = 256
    Top = 195
    Width = 29
    Height = 21
    MaxLength = 40
    TabOrder = 5
    Text = 'SP'
  end
  object DATAEM: TMaskEdit
    Left = 317
    Top = 98
    Width = 83
    Height = 21
    EditMask = '99/99/9999;1;_'
    MaxLength = 10
    TabOrder = 9
    Text = '17/07/2001'
  end
  object bruto: TEdit
    Left = 9
    Top = 381
    Width = 90
    Height = 21
    ReadOnly = True
    TabOrder = 16
    Text = '0,00'
  end
  object desconto: TEdit
    Left = 105
    Top = 382
    Width = 90
    Height = 21
    TabOrder = 17
    Text = '0,00'
    OnExit = descontoExit
  end
  object liquido: TEdit
    Left = 201
    Top = 382
    Width = 90
    Height = 21
    Color = clInfoBk
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    ReadOnly = True
    TabOrder = 18
    Text = '0,00'
  end
  object Edit7: TEdit
    Left = 319
    Top = 57
    Width = 37
    Height = 21
    MaxLength = 15
    TabOrder = 6
    Text = '5.12'
  end
  object Edit8: TEdit
    Left = 359
    Top = 57
    Width = 136
    Height = 21
    MaxLength = 15
    TabOrder = 7
    Text = 'Venda de Mercadoria'
  end
  object Button3: TButton
    Left = 304
    Top = 372
    Width = 84
    Height = 32
    Caption = 'Totalizar '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 19
    OnClick = Button3Click
  end
  object ValorDpl: TEdit
    Left = 472
    Top = 198
    Width = 109
    Height = 21
    MaxLength = 40
    ReadOnly = True
    TabOrder = 14
    Text = '0,00'
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 225
    Width = 588
    Height = 132
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 15
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clGreen
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Codigo'
        Title.Alignment = taCenter
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Title.Alignment = taCenter
        Width = 213
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Unidade'
        Title.Alignment = taCenter
        Width = 52
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Quantidade'
        Title.Alignment = taCenter
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Unitario'
        Title.Alignment = taCenter
        Width = 68
        Visible = True
      end
      item
        Color = 14221311
        Expanded = False
        FieldName = 'Subtotal'
        Title.Alignment = taCenter
        Width = 75
        Visible = True
      end>
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
    OpcoesPreview.CaptionPreview = 'Rdprint Preview'
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
    TitulodoRelatorio = 'Nota Fiscal'
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
    Left = 451
    Top = 296
  end
  object Table1: TTable
    OnCalcFields = Table1CalcFields
    TableName = 'ITENS.db'
    Left = 147
    Top = 296
    object Table1Sequencia: TAutoIncField
      FieldName = 'Sequencia'
      ReadOnly = True
    end
    object Table1Pedido: TIntegerField
      FieldName = 'Pedido'
    end
    object Table1Codigo: TIntegerField
      FieldName = 'Codigo'
    end
    object Table1Descricao: TStringField
      FieldName = 'Descricao'
      Size = 30
    end
    object Table1Unidade: TStringField
      FieldName = 'Unidade'
      Size = 2
    end
    object Table1Quantidade: TIntegerField
      FieldName = 'Quantidade'
      DisplayFormat = '###0'
    end
    object Table1Unitario: TBCDField
      FieldName = 'Unitario'
      DisplayFormat = '###,###,##0.00'
      Size = 2
    end
    object Table1Subtotal: TCurrencyField
      FieldKind = fkCalculated
      FieldName = 'Subtotal'
      DisplayFormat = '###,###,##0.00'
      Calculated = True
    end
  end
  object DataSource1: TDataSource
    DataSet = Table1
    Left = 219
    Top = 296
  end
  object Table2: TTable
    TableName = 'EMPRESA.DB'
    Left = 309
    Top = 293
    object Table2Codigo: TIntegerField
      FieldName = 'Codigo'
    end
    object Table2Razao: TStringField
      FieldName = 'Razao'
      Size = 35
    end
    object Table2Endereco: TStringField
      FieldName = 'Endereco'
      Size = 30
    end
    object Table2Bairro: TStringField
      FieldName = 'Bairro'
      Size = 15
    end
    object Table2Cidade: TStringField
      FieldName = 'Cidade'
    end
    object Table2Estado: TStringField
      FieldName = 'Estado'
      Size = 2
    end
    object Table2Cep: TStringField
      FieldName = 'Cep'
      Size = 9
    end
    object Table2Data_Compra: TDateField
      FieldName = 'Data_Compra'
    end
    object Table2Valor_Compra: TBCDField
      FieldName = 'Valor_Compra'
      Size = 2
    end
    object Table2CGC_CPF: TStringField
      FieldName = 'CGC_CPF'
      Size = 18
    end
    object Table2Inscricao: TStringField
      FieldName = 'Inscricao'
      Size = 18
    end
  end
  object DataSource2: TDataSource
    DataSet = Table2
    Left = 365
    Top = 293
  end
end
