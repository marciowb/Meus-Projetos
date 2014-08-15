object DFM_RDPEditor: TDFM_RDPEditor
  Left = 306
  Top = 252
  BorderStyle = bsDialog
  Caption = 'Editor de Propriedades do RDprint'
  ClientHeight = 388
  ClientWidth = 482
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel13: TBevel
    Left = 0
    Top = 57
    Width = 483
    Height = 3
    Shape = bsTopLine
  end
  object Shape1: TShape
    Left = 0
    Top = 0
    Width = 482
    Height = 57
    Align = alTop
    Pen.Style = psClear
  end
  object Image1: TImage
    Left = 8
    Top = 4
    Width = 32
    Height = 32
    AutoSize = True
    Picture.Data = {
      07544269746D6170360C0000424D360C00000000000036000000280000002000
      0000200000000100180000000000000C00000000000000000000000000000000
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAF4F4EBD9D9F3E7E7
      FCFAFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFDFCFAE8D2EEC498ECC2
      96EABC8BF6DBBFFDF4EBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4E9E7D3ABAACA9998C79595
      D1A8A8DDBEBEF3E5E3FEFCFAFFFFFFFFFFFFFEFCFAF5DFC8F0C698F7E0C9FCF1
      E8F8E9DAEDC59AEABB8BF4DCC2FEFCFAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF8F8EAD5D5C89494D0A2A1EBD8D8DFBDBD
      C99494C58F8EC28B8AC58F8FD7B2B1E8D2D0F5D0A8F3D3ADFCEFE3FCEFE3FBF1
      E9FCF4EEFDF7F4F9EDE0EDC69EEABC8BF4DEC7FCF5EFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFEFCFADCBABAD0A2A2DDBCBCE1C3C2E7CFCFF2E2DF
      DAB6B6CC9999CB9898CA9797C89494DEB09BF9E1C6FCE7D3FEEBD7FEEBD7FDED
      DDFCF0E5FBF2EAFBF3EDFCF6F1F8E9DAE9BB8DE7B889F6E2CAFEFCFAFFFFFFFF
      FFFFFFFFFFFFFFFFF1E3E3D8B1B0DEBDBDE8D0D0EBD6D6ECD9D9ECD9D9ECD9D9
      F4E7E5DCB8B7CC9999CC9999CC9999CFA1A0F4D1B7FEE1C2FEE3C7FEE7D0FEEA
      D4FEEBD7FDECDBFCEFE3FBF1E9FCF4EEFCF6F1F8E7D9E6B586F0CBA4FFFFFFFF
      FFFFFFFFFFFEFCFAD9B4B3E4CACAF0E2E2F0E2E2F1E5E5EDDCDCECD9D9ECD9D9
      EEDCDCF4E8E8D1A4A4CC9999CC9999CC9999D3A49FF4CFB2FFE0C0FFE1C3FEE5
      CBFEE6CEFEEBD7FEEBD7FDEDDDFCF0E5FBF2EAFCF8F4F3D5B6E9B986FFFFFFFF
      FFFFFFFFFFEAD4D4E5CAC8FBF2EAF9EFE8F3E7E6F2E6E6F2E6E6F1E3E3EDDADA
      ECD9D9F0E2E2ECD7D3CC9999CC9999CC9999CC9999CC9999DBB4ADEECDB7FADA
      BCFEE2C4FEE3C7FEE7D0FEE9D3FDEDDCFAE8D7EECBA8E9BC8FF9ECDFFFFFFFFF
      FFFFFFFFFFE8D0D0EDDAD9FCF6F1FCF4EEF9EEE8F6EBE7F2E6E6F2E6E6F1E3E3
      EFDFDFF0E2E2E8D1D1CC9999CC9999CC9999CC9999CC9999CFA1A0D5ACACDDB6
      AEEBC8B4FEDEBCFFE1C3FDEAD7F5DCC1EABA89F0CFAFFCF5EFFFFFFFFFFFFFFF
      FFFFFFFFFFE3C8C8F3E7E6FCF8F5FCF7F4FBF4EFFBF2ECF7ECE8F4E9E7F2E6E6
      F3E8E8F2E4E2CFA0A0CC9999CC9999CC9999CC9999CC9999CE9E9ED8B2B2D8B2
      B2D5ADADD4A9A8E8C7BBE8BC9EBF8276C38C8CDDBAB6FCFAFAFFFFFFFFFFFFFF
      FFFFFFFFFFE5CCCCF6EEEEFEFDFCFCF7F4FCF7F4FCF6F3FBF2EBFAF0E9F8EDE8
      F1E1DDD9B2B1CE9C9CCC9999CC9999CC9999CC9999CC9999D0A1A1E0C1C1E1C3
      C2DCB9B8D7AFAFD5ACACD1A4A4BA7F7FC38C8CC18989DAB8B7F9F4F4FFFFFFFF
      FFFFFFFFFFE6CDCDFCF6F0FFFFFFFFFFFFFEFCFAFCF7F4FCF7F4FBF6F4EDDBDA
      D3A8A8D0A2A1D0A1A0CE9E9DCC9999CC9999CC9999CC9999DDBABAE8D0D0E6CC
      CCE6CCCCE1C3C3DEBDBCDAB6B6D5ABAABA7F7EC99595C18A89D0A5A5FCFAFAFF
      FFFFFFFFFFE8D0D0FCF6F0FFFFFFFFFFFFFFFFFFFEFCFBFDF9F6E6CECED8B1B1
      D4AAAAD3A8A8D0A1A0D0A1A0CE9C9CCC9999CC9999D5ACACEBD6D6ECD9D9E9D2
      D2E6CCCCE6CCCCE5CACAE2C6C6DEBDBDC38D8CC48E8ECA9797C18A89E5CCCCFF
      FFFFFFFFFFE8D2D2FCF6F0FFFFFFFFFFFFFEFCFAF2E3E3E0C0BFD8B2B2D8B2B2
      D5ACACD4AAAAD3A8A8D0A2A1D0A1A0CE9E9DDFBFBEEDDADAEDDCDCECD9D9ECD9
      D9ECD9D9E7CFCFE6CCCCE6CCCCE6CCCCC79494C38C8CCC9999CA9696C79494F2
      E5E5FFFFFFEAD6D6FCF6F0FFFFFFF9F2F1ECD8D6E0C1C1DCB9B8D9B5B5D8B2B2
      D8B1B1D5ACACD4AAAAD3A8A8D2A5A4E1C4C4F1E3E3F2E6E6F1E5E5EDDCDCECD9
      D9ECD9D9EBD8D8EAD5D5E6CCCCE6CCCCC18988C69090CC9999CC9999C38C8CEA
      D8D8FFFFFFECD8D8F4E6E2EEDBDBE1C4C4E0C2C2D9C3BDBACBAD81B876B6B59B
      D9B3B3D8B2B2D5ADADDAB6B6EFDEDCFBF2EAF9EFE8F3E7E6F2E6E6F2E6E6F1E3
      E3EDDADAECD9D9ECD9D9E9D4D4D1A7A7C08888CD9C9BCC9999CC9999C38C8CEA
      D8D8FFFFFFF4E9E9E3C7C7E6CCCCE5CBCBE1C4C4CFCABB78ED9740D85F73B76B
      DCB8B7D9B4B3E6CDCCF5E9E7FCF7F4FCF6F1FBF1E9F9EEE8F2E6E6F2E6E6F2E6
      E6F1E3E3EFDFDFECD9D9DDBDBDC59090D1A3A3D0A1A0CE9C9CCA9696C79494F2
      E5E5FFFFFFFFFFFFF3E8E7E7D0CFE5CBCBE5CBCBE1C4C4C9CCB9BED1B4D7C6B5
      EAC4B2F9D0ABFED7AEFEE1C2FDECDCFDEEE1FCF6F1FBF4EFFBF1E9F7ECE8F2E6
      E6F2E6E6F0E2E2E1C3C3CA9998D4ABABD4AAAAD2A6A5CD9C9BC48E8EE8D1D0FF
      FFFFFFFFFFFFFFFFFFFEFEFBF6F6F0DFDBE7CECEE7C8BFE4C9C9EECEB8F8D5B6
      FED8B0FED5ABFED4A9FED4A9FED5AAFED7AFF9DCBBFDEAD6F4E0CFF9EEE8F8ED
      E8F4E8E6DCBABAD2A8A8D9B3B3D8B2B2D6ADADD2A6A5C5908FE0C2C0FEFDFCFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEF3D9C0F2D3B3FEE6CDFFDFBDFEDCB8
      FEDAB4FEDAB4FED9B2FED6ADFED4A9FED4A9FED7AEF3CFABD1946CC18989DDBB
      BBDCBABADBB7B7DEBEBDDCB9B8D9B2B2CEA0A0C99897ECD8D8FEFDFDFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF6F0EFCCA5FBEBDDFFE2C4FFE0BFFFE0BF
      FFDEBBFEDBB6FEDAB4FEDAB4FED8B0FED5ABFCDBB9E8B787C99082CD9E9EDBB9
      B9E3C6C6E0C2C2E0C2C2DBB8B7CE9F9FD2A7A7EFDFDFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFF9E5CFF4DABFFDEBDBFEE4CAFEE3C8FFE1C3
      FFE0BFFFE0BFFFDFBDFEDCB8FEDAB4FEDBB7F1D2B4E3B085E2C5C5E9D2D2E7CF
      CFE5CACADFBFBFD5ACACD3A7A6E5CBCAFEFCFAFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFF8D6B1FAEADBFEEAD6FEE6CDFEE4CAFEE4CA
      FEE3C6FFE1C1FFE0BFFFE0BFFFDDB9FDE5CEEABD8CE1BAA8D6ADADD7AFAFD8B2
      B2D4AAAAD6ADACE1C5C5F6EDECFFFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFEFEFEE9D3F9E0C5FDEFE1FEEBD7FEEBD7FEE9D4FEE6CE
      FEE4CAFEE4CAFEE3C8FFE1C3FEE3C6F5D8BAEDC59BFFFBF6FEFDFDF8F2F1F2E6
      E6F5EBEBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFEFAF5FEDDBBFCF2E8FDEEDEFEEBD7FEEBD7FEEBD7FEEBD7
      FEE9D3FEE6CDFEE4CAFEE4CAFEE5CBEFC79DFAE9D6FFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFEEFE1FDE8D2FCF5F0FBF1E9FBF1E9FCEEE1FEEBD7FEEBD7
      FEEBD7FEEBD7FEE9D4FEE6CEF5DABFF1D1B1FFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFDECDCFEF1E3FCF6F3FBF2EBFBF1E9FBF1E9FCEFE3FCEFE3
      FEEBD7FEEBD7FEEBD7FDEEDFF1CCA5F9EBDEFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFDF4EBFFE5CAFDE8D2FDECDCFEF1E4FDF2E7FBF2EAFBF3ED
      FCF1E8FDEDDDFDEEDEFBE7D1F6DBBDFEFDFDFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFEFEFFF9F5FFF4E9FDEDDDFEE5CAFEE1C2FDDFBFFDE3C7
      FEEAD4FCF0E4FFF2E6F5D2ABFEF4EAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDF9F5FDF0E3
      FDE7CEF8DFC0F8DFC0FCECD9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF}
    Transparent = True
  end
  object Label3: TLabel
    Left = 56
    Top = 4
    Width = 148
    Height = 32
    Caption = 'RDprint 4.1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -27
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Label2: TLabel
    Left = 56
    Top = 36
    Width = 152
    Height = 15
    Caption = 'Componente de Impress'#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clGreen
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    Transparent = True
  end
  object Label4: TLabel
    Left = 278
    Top = 36
    Width = 185
    Height = 13
    Cursor = crHandPoint
    Alignment = taCenter
    AutoSize = False
    Caption = 'deltress@deltress.com.br'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object Label10: TLabel
    Left = 278
    Top = 20
    Width = 185
    Height = 13
    Cursor = crHandPoint
    Alignment = taCenter
    AutoSize = False
    Caption = 'www.deltress.com.br'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    Transparent = True
  end
  object Label6: TLabel
    Left = 278
    Top = 4
    Width = 185
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Deltress Inform'#225'tica Ltda'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object MATRIZ: TBitBtn
    Left = 135
    Top = 355
    Width = 80
    Height = 25
    Hint = 
      'Imprime uma folha quadriculada para auxilar na confec'#231#227'o do rela' +
      't'#243'rio'
    Caption = '&Matriz'
    DoubleBuffered = True
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
    ParentDoubleBuffered = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    TabStop = False
    OnClick = MATRIZClick
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 65
    Width = 465
    Height = 280
    ActivePage = TabSheet4
    TabOrder = 0
    object TabSheet4: TTabSheet
      Caption = 'Relat'#243'rio'
      ImageIndex = 3
      object Bevel6: TBevel
        Left = 7
        Top = 7
        Width = 443
        Height = 237
        Shape = bsFrame
      end
      object Bevel10: TBevel
        Left = 113
        Top = 158
        Width = 102
        Height = 72
        Shape = bsFrame
      end
      object Bevel8: TBevel
        Left = 249
        Top = 189
        Width = 186
        Height = 41
        Shape = bsFrame
      end
      object Label13: TLabel
        Left = 121
        Top = 174
        Width = 34
        Height = 13
        Caption = 'Linhas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label16: TLabel
        Left = 23
        Top = 14
        Width = 106
        Height = 13
        Caption = 'Titulo do Rel'#225'torio'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Bevel4: TBevel
        Left = 247
        Top = 75
        Width = 188
        Height = 85
        Shape = bsFrame
      end
      object Label7: TLabel
        Left = 259
        Top = 86
        Width = 126
        Height = 13
        Caption = 'Caption do Form "SETUP"'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 249
        Top = 59
        Width = 167
        Height = 13
        Caption = 'Op'#231#245'es de Cores para Form'#39's'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 121
        Top = 203
        Width = 41
        Height = 13
        Caption = 'Colunas:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label32: TLabel
        Left = 252
        Top = 173
        Width = 127
        Height = 13
        Caption = #193'rea '#250'til de Impress'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object MEDIDAS: TLabel
        Left = 257
        Top = 204
        Width = 172
        Height = 20
        Alignment = taCenter
        AutoSize = False
        Caption = '210,22  x  120,78'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clPurple
        Font.Height = -16
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label34: TLabel
        Left = 23
        Top = 91
        Width = 137
        Height = 13
        Caption = 'Tamanho do Formul'#225'rio:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FONTESETUP: TShape
        Left = 259
        Top = 130
        Width = 21
        Height = 20
      end
      object FORMSETUP: TShape
        Left = 353
        Top = 130
        Width = 21
        Height = 20
      end
      object AVANCO: TRadioGroup
        Left = 113
        Top = 108
        Width = 102
        Height = 52
        Caption = 'Avan'#231'o LPP:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Sexto'
          'Oitavo')
        ParentFont = False
        TabOrder = 2
        OnClick = AVANCOClick
      end
      object FONTEPADRAO: TRadioGroup
        Left = 21
        Top = 108
        Width = 94
        Height = 122
        Caption = 'Fonte Padr'#227'o '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Expandido'
          'Normal '
          'Comp 12'
          'Comp 17'
          'Comp 20')
        ParentFont = False
        TabOrder = 1
        OnClick = AVANCOClick
      end
      object TITULO: TEdit
        Left = 21
        Top = 30
        Width = 412
        Height = 21
        TabOrder = 0
        Text = 'TITULO'
      end
      object QTELIN: TEdit
        Left = 164
        Top = 170
        Width = 42
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 3
        Text = '50'
        OnChange = AVANCOClick
        OnKeyPress = QTELINKeyPress
      end
      object QTECOL: TEdit
        Left = 164
        Top = 200
        Width = 42
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 4
        Text = '50'
        OnChange = AVANCOClick
        OnKeyPress = QTECOLKeyPress
      end
      object CAPSETUP: TEdit
        Left = 257
        Top = 102
        Width = 164
        Height = 21
        TabOrder = 5
        Text = 'Edit2'
      end
      object BitBtn1: TBitBtn
        Left = 282
        Top = 128
        Width = 45
        Height = 23
        Caption = 'Texto'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 6
        OnClick = BitBtn1Click
      end
      object BitBtn2: TBitBtn
        Left = 376
        Top = 128
        Width = 45
        Height = 23
        Caption = 'Form'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 7
        OnClick = BitBtn2Click
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Impress'#227'o'
      object Bevel7: TBevel
        Left = 7
        Top = 7
        Width = 443
        Height = 237
        Shape = bsFrame
      end
      object Bevel11: TBevel
        Left = 22
        Top = 122
        Width = 202
        Height = 108
        Shape = bsFrame
      end
      object Bevel1: TBevel
        Left = 265
        Top = 32
        Width = 170
        Height = 51
        Shape = bsFrame
      end
      object Label1: TLabel
        Left = 266
        Top = 17
        Width = 128
        Height = 13
        Caption = 'M'#233'todos de Impress'#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 26
        Top = 17
        Width = 128
        Height = 13
        Caption = 'Modelo da impressora:'
        FocusControl = MODELOS
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label14: TLabel
        Left = 26
        Top = 61
        Width = 191
        Height = 13
        Caption = 'Porta de Comunicacao (Obsoleto)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label33: TLabel
        Left = 25
        Top = 106
        Width = 133
        Height = 13
        Caption = 'Margens em Milimetros:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 40
        Top = 143
        Width = 18
        Height = 13
        Caption = 'Left'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label39: TLabel
        Left = 104
        Top = 170
        Width = 33
        Height = 13
        Caption = 'Bottom'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label45: TLabel
        Left = 104
        Top = 122
        Width = 19
        Height = 13
        Caption = 'Top'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label46: TLabel
        Left = 176
        Top = 143
        Width = 25
        Height = 13
        Caption = 'Right'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 265
        Top = 203
        Width = 43
        Height = 13
        Caption = 'C'#243'pias:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label11: TLabel
        Left = 265
        Top = 220
        Width = 87
        Height = 13
        Caption = 'N'#250'mero de C'#243'pias'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label47: TLabel
        Left = 25
        Top = 212
        Width = 185
        Height = 13
        Caption = '* Para impress'#227'o em MODO GRAFICO.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object USAGERENCIADOR: TCheckBox
        Left = 275
        Top = 36
        Width = 151
        Height = 25
        Caption = 'Usar Gerenciador (spool)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
      end
      object ACENTO: TRadioGroup
        Left = 264
        Top = 144
        Width = 170
        Height = 50
        Caption = 'Acentua'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Transliterate (convers'#227'o)'
          'Sem Acento')
        ParentFont = False
        TabOrder = 9
      end
      object MODELOS: TComboBox
        Left = 24
        Top = 33
        Width = 195
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemHeight = 13
        ParentFont = False
        TabOrder = 0
        Items.Strings = (
          'Epson Matricial e compat'#237'veis'
          'Rima / Emilia'
          'HP Deskjet/Laser (PCL 3)'
          'Gr'#225'fico - Compat'#237'vel com Windows'
          'Personalizado'
          'Bobina / Cupom')
      end
      object PORTA: TEdit
        Left = 24
        Top = 77
        Width = 195
        Height = 21
        TabOrder = 1
        Text = 'Edit2'
      end
      object DIRECAO: TRadioGroup
        Left = 264
        Top = 89
        Width = 170
        Height = 50
        Caption = 'Orienta'#231#227'o do Papel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Items.Strings = (
          'Retrato'
          'Paisagem')
        ParentFont = False
        TabOrder = 8
      end
      object MostrarBarraProgresso: TCheckBox
        Left = 275
        Top = 55
        Width = 151
        Height = 25
        Caption = 'Mostrar Barra de Progresso'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object edLEFT: TEdit
        Left = 38
        Top = 158
        Width = 35
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 3
        Text = '1'
        OnExit = edTOPExit
        OnKeyPress = COPIASKeyPress
      end
      object edTOP: TEdit
        Left = 102
        Top = 137
        Width = 35
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 2
        Text = '1'
        OnExit = edTOPExit
        OnKeyPress = COPIASKeyPress
      end
      object edBOTTOM: TEdit
        Left = 102
        Top = 185
        Width = 35
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 5
        Text = '1'
        OnExit = edTOPExit
        OnKeyPress = COPIASKeyPress
      end
      object edRIGHT: TEdit
        Left = 174
        Top = 158
        Width = 35
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 4
        Text = '1'
        OnExit = edTOPExit
        OnKeyPress = COPIASKeyPress
      end
      object COPIAS: TEdit
        Left = 399
        Top = 213
        Width = 35
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxLength = 4
        ParentFont = False
        TabOrder = 10
        Text = '1'
        OnKeyPress = COPIASKeyPress
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Preview'
      ImageIndex = 1
      object Bevel5: TBevel
        Left = 7
        Top = 7
        Width = 443
        Height = 237
        Shape = bsFrame
      end
      object Bevel12: TBevel
        Left = 342
        Top = 147
        Width = 93
        Height = 84
        Shape = bsFrame
      end
      object Bevel2: TBevel
        Left = 21
        Top = 158
        Width = 177
        Height = 74
        Shape = bsFrame
      end
      object Label5: TLabel
        Left = 138
        Top = 23
        Width = 39
        Height = 13
        Caption = 'Caption:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label35: TLabel
        Left = 20
        Top = 52
        Width = 226
        Height = 13
        Caption = 'Status dos Bot'#245'es no Form "PREVIEW"'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label36: TLabel
        Left = 25
        Top = 142
        Width = 97
        Height = 13
        Caption = 'Layout do Papel:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label37: TLabel
        Left = 358
        Top = 184
        Width = 53
        Height = 13
        Caption = '% de Zoom'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object TEXTOPREVIEW: TShape
        Left = 116
        Top = 202
        Width = 21
        Height = 20
      end
      object PAPELPREVIEW: TShape
        Left = 116
        Top = 169
        Width = 21
        Height = 20
      end
      object RadioGroup1: TRadioGroup
        Left = 248
        Top = 143
        Width = 96
        Height = 89
        Caption = 'Ajuste Zoom:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'P'#225'gina'
          'Largura'
          '100 %'
          'Custom ==>')
        ParentFont = False
        TabOrder = 11
        OnClick = RadioGroup1Click
      end
      object VISUALIZAR: TCheckBox
        Left = 21
        Top = 22
        Width = 92
        Height = 17
        Caption = 'Visualizar'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 0
      end
      object ZOOM: TEdit
        Left = 360
        Top = 200
        Width = 52
        Height = 21
        MaxLength = 3
        TabOrder = 12
        Text = '100'
        OnExit = ZOOMExit
        OnKeyPress = ZOOMKeyPress
      end
      object BTGRAVAR: TRadioGroup
        Left = 268
        Top = 69
        Width = 85
        Height = 65
        Caption = 'Gravar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Ativo'
          'Inativo'
          'Invisivel')
        ParentFont = False
        TabOrder = 5
      end
      object BTIMPRIMIR: TRadioGroup
        Left = 102
        Top = 69
        Width = 85
        Height = 65
        Caption = 'Imprimir'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Ativo'
          'Inativo'
          'Invisivel')
        ParentFont = False
        TabOrder = 3
      end
      object BTLER: TRadioGroup
        Left = 185
        Top = 69
        Width = 85
        Height = 65
        Caption = 'Ler'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Ativo'
          'Inativo'
          'Invisivel')
        ParentFont = False
        TabOrder = 4
      end
      object BTSETUP: TRadioGroup
        Left = 19
        Top = 69
        Width = 85
        Height = 65
        Caption = 'Setup'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Ativo'
          'Inativo'
          'Invisivel')
        ParentFont = False
        TabOrder = 2
      end
      object ZEBRADA: TCheckBox
        Left = 33
        Top = 200
        Width = 68
        Height = 17
        Caption = 'Zebrada'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 8
      end
      object REMALINA: TCheckBox
        Left = 32
        Top = 174
        Width = 68
        Height = 17
        Caption = 'Remalina'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 7
      end
      object CAPPREVIEW: TEdit
        Left = 184
        Top = 20
        Width = 249
        Height = 21
        TabOrder = 1
        Text = 'Edit2'
      end
      object BTTEXTO: TBitBtn
        Left = 139
        Top = 201
        Width = 45
        Height = 23
        Caption = 'Texto'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 10
        OnClick = BTTEXTOClick
      end
      object BTPAPEL: TBitBtn
        Left = 140
        Top = 168
        Width = 45
        Height = 23
        Caption = 'Papel'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 9
        OnClick = BTPAPELClick
      end
      object BTProcurar: TRadioGroup
        Left = 351
        Top = 69
        Width = 85
        Height = 65
        Caption = 'Procurar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ItemIndex = 0
        Items.Strings = (
          'Ativo'
          'Inativo'
          'Invisivel')
        ParentFont = False
        TabOrder = 6
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Impressora Personalizada'
      ImageIndex = 2
      object Bevel3: TBevel
        Left = 7
        Top = 7
        Width = 443
        Height = 237
        Shape = bsFrame
      end
      object Label17: TLabel
        Left = 23
        Top = 25
        Width = 62
        Height = 13
        Caption = 'Impressora'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label19: TLabel
        Left = 23
        Top = 214
        Width = 41
        Height = 13
        Caption = 'Reset (*)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label20: TLabel
        Left = 23
        Top = 51
        Width = 32
        Height = 13
        Caption = 'Sextos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label21: TLabel
        Left = 23
        Top = 78
        Width = 36
        Height = 13
        Caption = 'Oitavos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label22: TLabel
        Left = 23
        Top = 106
        Width = 34
        Height = 13
        Caption = 'Negrito'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label23: TLabel
        Left = 23
        Top = 133
        Width = 28
        Height = 13
        Caption = 'It'#225'lico'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label24: TLabel
        Left = 23
        Top = 160
        Width = 53
        Height = 13
        Caption = 'Sublinhado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label25: TLabel
        Left = 241
        Top = 25
        Width = 50
        Height = 13
        Caption = 'Expandido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label26: TLabel
        Left = 241
        Top = 51
        Width = 33
        Height = 13
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label27: TLabel
        Left = 241
        Top = 78
        Width = 33
        Height = 13
        Caption = '12 cpp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label28: TLabel
        Left = 241
        Top = 106
        Width = 33
        Height = 13
        Caption = '17 cpp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label29: TLabel
        Left = 241
        Top = 133
        Width = 33
        Height = 13
        Caption = '20 cpp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label30: TLabel
        Left = 241
        Top = 187
        Width = 63
        Height = 13
        Caption = 'Saltar P'#225'gina'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label31: TLabel
        Left = 241
        Top = 160
        Width = 70
        Height = 13
        Caption = 'Tamanho Pag.'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label38: TLabel
        Left = 23
        Top = 187
        Width = 43
        Height = 13
        Caption = 'Inicializar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object NOMEIMP: TEdit
        Left = 89
        Top = 21
        Width = 121
        Height = 21
        Color = 14221311
        TabOrder = 0
        Text = 'NOMEIMP'
      end
      object CMDRESET: TEdit
        Left = 89
        Top = 210
        Width = 345
        Height = 21
        Hint = 'Consulte o Help do RDprint para correta configura'#231#227'o do RESET'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        Text = 'Edit4'
      end
      object CMDSEXTO: TEdit
        Left = 89
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 1
        Text = 'CMDSEXTO'
      end
      object CMDOITAVO: TEdit
        Left = 89
        Top = 75
        Width = 121
        Height = 21
        TabOrder = 2
        Text = 'Edit12'
      end
      object CMDNEGRITO: TEdit
        Left = 89
        Top = 102
        Width = 121
        Height = 21
        TabOrder = 3
        Text = 'Edit12'
      end
      object CMDITALICO: TEdit
        Left = 89
        Top = 129
        Width = 121
        Height = 21
        TabOrder = 4
        Text = 'Edit12'
      end
      object CMDSUBLINHADO: TEdit
        Left = 89
        Top = 156
        Width = 121
        Height = 21
        TabOrder = 5
        Text = 'Edit12'
      end
      object CMD05: TEdit
        Left = 313
        Top = 21
        Width = 121
        Height = 21
        TabOrder = 8
        Text = 'Edit12'
      end
      object CMD10: TEdit
        Left = 313
        Top = 48
        Width = 121
        Height = 21
        TabOrder = 9
        Text = 'Edit12'
      end
      object CMD12: TEdit
        Left = 313
        Top = 75
        Width = 121
        Height = 21
        TabOrder = 10
        Text = 'Edit12'
      end
      object CMD17: TEdit
        Left = 313
        Top = 102
        Width = 121
        Height = 21
        TabOrder = 11
        Text = 'Edit12'
      end
      object CMD20: TEdit
        Left = 313
        Top = 129
        Width = 121
        Height = 21
        TabOrder = 12
        Text = 'Edit12'
      end
      object CMDSALTO: TEdit
        Left = 313
        Top = 183
        Width = 121
        Height = 21
        TabOrder = 14
        Text = 'Edit12'
      end
      object CMDTAMANHO: TEdit
        Left = 313
        Top = 156
        Width = 121
        Height = 21
        TabOrder = 13
        Text = 'Edit12'
      end
      object CMDFINAL: TEdit
        Left = 89
        Top = 183
        Width = 121
        Height = 21
        TabOrder = 6
        Text = 'Iniciliza'
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Mapeamento'
      ImageIndex = 4
      object Memo1: TMemo
        Left = 7
        Top = 7
        Width = 442
        Height = 236
        Lines.Strings = (
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
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object TabSheet6: TTabSheet
      Caption = 'Registro'
      ImageIndex = 5
      object Bevel9: TBevel
        Left = 7
        Top = 7
        Width = 443
        Height = 237
        Shape = bsFrame
      end
      object RegKey: TLabel
        Left = 148
        Top = 191
        Width = 290
        Height = 15
        AutoSize = False
        Caption = 'N'#227'o Autorizado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RegSerie: TLabel
        Left = 148
        Top = 151
        Width = 290
        Height = 15
        AutoSize = False
        Caption = 'Demonstra'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object RegNome: TLabel
        Left = 148
        Top = 111
        Width = 290
        Height = 30
        AutoSize = False
        Caption = 'Deltress Inform'#225'tica'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGreen
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        WordWrap = True
      end
      object Label40: TLabel
        Left = 43
        Top = 111
        Width = 88
        Height = 13
        Caption = 'Nome de Registro:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label41: TLabel
        Left = 43
        Top = 151
        Width = 79
        Height = 13
        Caption = 'Licen'#231'a / S'#233'rie :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label42: TLabel
        Left = 43
        Top = 191
        Width = 86
        Height = 13
        Caption = 'Autoriza'#231#227'o (Key):'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label43: TLabel
        Left = 100
        Top = 58
        Width = 270
        Height = 15
        Caption = 'Para uso exclusivo do usu'#225'rio abaixo identificado'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
      end
      object Label44: TLabel
        Left = 163
        Top = 20
        Width = 148
        Height = 32
        Caption = 'RDprint 4.0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object ESPACO: TRadioGroup
    Left = 8
    Top = 351
    Width = 121
    Height = 31
    Caption = 'Matriz / R'#233'gua'
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
    TabOrder = 1
  end
  object OK: TBitBtn
    Left = 287
    Top = 354
    Width = 80
    Height = 25
    Caption = '&Ok'
    Default = True
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      18000000000000060000C40E0000C40E00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF006600006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF656565656565FF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF0066001EB2311FB133006600FF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6565659A9A9A9A9A9A65
      6565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF00660031C24F22B7381AB02D21B437006600FF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF656565ABABAB9E9E9E9797979C
      9C9C656565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      00660047D36D3BCB5E25A83B0066001BA92E1DB132006600FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF656565BFBFBFB5B5B598989865656594
      9494999999656565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF006600
      4FD67953DE7F31B54D006600FF00FF006600179D271EAE31006600FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FF656565C4C4C4CACACAA5A5A5656565FF00FF65
      65658C8C8C989898656565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      00660041C563006600FF00FFFF00FFFF00FFFF00FF00660019AA2B006600FF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FF656565B5B5B5656565FF00FFFF00FFFF
      00FFFF00FF656565939393656565FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF006600149D210066
      00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF656565FF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FF6565658A8A8A656565FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0066
      00006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FF656565656565FF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FF006600006600FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FF656565656565FF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    ModalResult = 1
    NumGlyphs = 2
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 3
  end
  object CANCELAR: TBitBtn
    Left = 385
    Top = 354
    Width = 80
    Height = 25
    Cancel = True
    Caption = '&Cancelar'
    DoubleBuffered = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Glyph.Data = {
      36060000424D3606000000000000360000002800000020000000100000000100
      18000000000000060000C40E0000C40E00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF00009A00009AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009A0000
      9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6B6B6B6BFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF6B6B6B6B6B6BFF00FFFF00FFFF00FFFF00FFFF00FF
      00009A174AFD103BF400009AFF00FFFF00FFFF00FFFF00FF00009A002CF80030
      FC00009AFF00FFFF00FFFF00FFFF00FF6B6B6BA8A8A8A0A0A06B6B6BFF00FFFF
      00FFFF00FFFF00FF6B6B6B9A9A9A9C9C9C6B6B6BFF00FFFF00FFFF00FFFF00FF
      00009A1A47F81A4CFF123BF100009AFF00FFFF00FF00009A012DF60132FF002A
      F300009AFF00FFFF00FFFF00FFFF00FF6B6B6BA7A7A7AAAAAA9F9F9F6B6B6BFF
      00FFFF00FF6B6B6B9999999E9E9E9797976B6B6BFF00FFFF00FFFF00FFFF00FF
      FF00FF00009A1C47F61B4DFF143EF400009A00009A002DF80134FF032BF20000
      9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6BA7A7A7ABABABA2A2A26B
      6B6B6B6B6B9A9A9A9E9E9E9898986B6B6BFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF00009A1D48F61D50FF103DFB0431FE0132FF002CF600009AFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6BA7A7A7ACACACA3
      A3A39F9F9F9E9E9E9999996B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF00009A1A48F91342FF0C3CFF0733F600009AFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6BA7A7A7A7
      A7A7A3A3A39C9C9C6B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FF00009A214EFC1D4BFF1847FF1743F600009AFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6BACACACAC
      ACACA9A9A9A4A4A46B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FF00009A2E5BF92C5FFF224DF8204BF82355FF1B46F600009AFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6BB1B1B1B3B3B3AB
      ABABAAAAAAAFAFAFA6A6A66B6B6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF00009A3664FA386BFF2D59F400009A00009A224CF42558FF1D49F60000
      9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6BB6B6B6B9B9B9AEAEAE6B
      6B6B6B6B6BA9A9A9B0B0B0A7A7A76B6B6BFF00FFFF00FFFF00FFFF00FFFF00FF
      00009A4071FA4274FF325DF100009AFF00FFFF00FF00009A224DF1275AFF204C
      F800009AFF00FFFF00FFFF00FFFF00FF6B6B6BBBBBBBBEBEBEAFAFAF6B6B6BFF
      00FFFF00FF6B6B6BA7A7A7B1B1B1AAAAAA6B6B6BFF00FFFF00FFFF00FFFF00FF
      00009A497AFC3B66F300009AFF00FFFF00FFFF00FFFF00FF00009A2550F42655
      FA00009AFF00FFFF00FFFF00FFFF00FF6B6B6BC0C0C0B5B5B56B6B6BFF00FFFF
      00FFFF00FFFF00FF6B6B6BAAAAAAAEAEAE6B6B6BFF00FFFF00FFFF00FFFF00FF
      FF00FF00009A00009AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00009A0000
      9AFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF6B6B6B6B6B6BFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FF6B6B6B6B6B6BFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    ModalResult = 2
    NumGlyphs = 2
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 4
  end
  object ColorDialog1: TColorDialog
    Left = 232
    Top = 321
  end
end
