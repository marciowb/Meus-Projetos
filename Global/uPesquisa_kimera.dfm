inherited frmPesquisa: TfrmPesquisa
  Caption = 'Pesquisa'
  ClientHeight = 573
  ClientWidth = 792
  OnClose = FormClose
  ExplicitWidth = 808
  ExplicitHeight = 612
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 139
    Align = alTop
    BevelKind = bkSoft
    BevelOuter = bvNone
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 0
      Top = 32
      Width = 217
      Height = 103
      Align = alLeft
      Caption = ' Op'#231#245'es de filtro '
      TabOrder = 0
      object lstCampos: TcxListBox
        Left = 2
        Top = 15
        Width = 213
        Height = 86
        Hint = 'Pressione F2 para selecionar o campo de pesquisa'
        Align = alClient
        ItemHeight = 13
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = lstCamposClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 217
      Top = 32
      Width = 216
      Height = 103
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alLeft
      Caption = ' Tipo de pesquisa '
      TabOrder = 1
      object grpOpcaoPesquisa: TRadioGroup
        Left = 2
        Top = 43
        Width = 212
        Height = 58
        Margins.Top = 0
        Align = alBottom
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Que &contenha'
          'Que &inicie com'
          'Que &seja igual')
        TabOrder = 0
      end
      object ChkTempoReal: TCheckBox
        Left = 6
        Top = 17
        Width = 131
        Height = 17
        Hint = 'Pressione F6 para marcar/desmarcar pesquisa em tempo real'
        Caption = 'Pesquisa em tempo real'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
      end
    end
    object Panel5: TPanel
      Left = 433
      Top = 32
      Width = 355
      Height = 103
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        355
        103)
      object lblTituloPesquisa: TLabel
        Left = 7
        Top = 34
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object btnPesquisar: TBitBtn
        Left = 241
        Top = 41
        Width = 88
        Height = 37
        Anchors = [akRight, akBottom]
        Caption = '&Pesquisar'
        DoubleBuffered = True
        Glyph.Data = {
          F6060000424DF606000000000000360000002800000018000000180000000100
          180000000000C0060000610B0000610B00000000000000000000FF00FFFF00FF
          485058485058FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF23588F1158A10D4076485058FF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FF23588F238FFF1173EA1158A10D4076485058FF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF31A1FF40ABFF2A8FFF1173EA1158
          A10D4076485058FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C8FFF38ABFF
          40ABFF2A8FFF1173EA1158A10D4076485058FF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FF1C8FFF38ABFF40ABFF2A8FFF1173EA1158A10D4076485058FF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FF1C8FFF38ABFF40ABFF2A8FFF1173EA11
          58A10D4076485058FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C8FFF38AB
          FF40ABFF2A8FFF1173EA312A23485058FF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FF1C8FFF38ABFF40ABFF8F8473737373312A23FF00FFFF00FFB684
          7BA1736AC08F84CAA18FCA988FC08484B67B7BFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FF1C8FFF1C8FFF9A9A9A8F8473505050
          6A505098736AE0CAABF0E3A9F8E9ACFCEDB0FFEFB1FFF0B4EAD4B6C08F84FF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFB2B2B2312A23C08F7BEBDDA5F7E6ABFBF2D5FBF2D5FBF2D5FBF2D5FBF2D5
          FBF2D5FFF0B6CAA18FCA988FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFB69898C08F7BFFEAABF6E6AAFBF2D5FFF3B4FFF4B6FF
          F6B8FFF7B8FFFBBAFFF8B8FBF2D5FFF0B2B68F8FFF00FFFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFAB7373EAD4A1EFE0A5FEEBAFFFEE
          B1FFEFB2FFF0B2FFF2B4FFF4B5FFF6B6FFFAB8FFFAB8FBF2D5F4EAD4CA988FFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCAA18FE1D39D
          F6E3AAFCEAAFFFEBB0FFEDB0FFEEB1FFEFB2FFF2B4FFF3B5FFF6B6FFF8B7FFFA
          B8FFF3B6AB8F7BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCA
          988FE0C098E6D7A0F8E6ABFBE7ACFCEAADFEEBAFFFEDB0FFEEB1FFEFB2FFF0B4
          FFF3B5FFF4B6FFF8B8FFF3B8CAB698CA988FFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFB77F7DEACAA1E9D8A1EADAA3F8E6ABFBEBBFFBEBBFFEEAAFFF
          EBB0FFEDB1FFEFB1FFF0B2FFF3B4FFF6B6FFF2B6E0CAABAB8473FF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFB77F7DEACAA1E6D59FEADAA3FBEBBFFBF2
          D5FBF2D5FBEBBFFCEAB0FFEBB1FFEDB2FFEFB2FFF0B5FFF3B6FCEDB1E0CAABAB
          8473FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCA988FE0C098DECF9A
          EFDEA5EADAA3FBEBBFFBF2D5FBEBBFFBE7AFFCE9B0FEEBB1FFEDB1FFEFB2FCEB
          AFF4E5ACCAB698CA988FFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFCA988FD4C798E3D49FEFDEA6EADAA3FBEBBFF7E5ADF8E6ABFAE7ADFBE9AF
          FCEAAFFAE9ACF3E3A9EADCA4AB8473FF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFAB7373EAD4A1D9CC9FE5D5A3EFDEA7F2E0A7F3E1A9F4
          E3A9F7E5AAF8E6ABF6E3A9F0E1A6EADAA3EAD4B6CA988FFF00FFFF00FFFF00FF
          FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFB68473FBEBBFDACFA6E1D3
          A1E6D7A1E9D9A1EADAA3EAD9A1E9D9A1E6D8A0E3D49EFFEAB6AB8473FF00FFFF
          00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
          AB8484FBEBBFD7CEAAD8CCA0D9CB9AD9CB98D7C996D5C796D3C695F4E0ABB684
          7BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
          00FFFF00FFFF00FFFF00FFB6847BCAAB8FF4E0ABFFEAABFFEAABFFEAABF4E0AB
          E0B698B67B7BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
          FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFCA988FB68473C0
          8F84C08F84B6847BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = btnPesquisarClick
      end
      object edtPesquisa: TMaskEdit
        Left = 7
        Top = 49
        Width = 202
        Height = 21
        Anchors = [akLeft, akRight, akBottom]
        TabOrder = 1
        OnKeyDown = edtPesquisaKeyDown
      end
    end
    object Panel6: TPanel
      Left = 0
      Top = 0
      Width = 788
      Height = 32
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      object lblTIpoPesquisa: TJvLabel
        Left = 0
        Top = 0
        Width = 788
        Height = 28
        Align = alTop
        Alignment = taCenter
        Caption = 'lblTIpoPesquisa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -24
        Font.Name = 'Times New Roman'
        Font.Style = []
        Layout = tlCenter
        ParentFont = False
        ShadowSize = 1
        Transparent = True
        HotTrackFont.Charset = ANSI_CHARSET
        HotTrackFont.Color = clWindowText
        HotTrackFont.Height = -24
        HotTrackFont.Name = 'Times New Roman'
        HotTrackFont.Style = []
        ExplicitWidth = 157
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 528
    Width = 792
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      792
      45)
    object lblRegistros: TLabel
      Left = 0
      Top = 32
      Width = 792
      Height = 13
      Align = alBottom
      Caption = 'lblRegistros'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      ExplicitWidth = 67
    end
    object btnCancelar: TBitBtn
      Left = 663
      Top = 7
      Width = 119
      Height = 32
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar[Esc]'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000210B0000210B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF000B77000B77FF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B77000B77FF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B77001CCA001CCA000B77FF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B77
        001CCA0A22B7000B77FF00FFFF00FFFF00FFFF00FFFF00FF000B77001CCA1638
        E01638E00A22B7000B77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FF000B77001CCA1638E01638E00A22B7000B77FF00FFFF00FFFF00FF000B77
        001CCA1638E01638E01638E01638E00A22B7000B77FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF000B77001CCA1638E01638E01638E01638E00A22B7000B77FF
        00FFFF00FF000B775672E7324AE51638E01638E01638E01638E00A22B7000B77
        FF00FFFF00FFFF00FFFF00FF000B77001CCA1638E01638E01638E01638E01638
        E0001CCA000B68FF00FFFF00FFFF00FF000B777287ED324AE51638E01638E016
        38E01638E00A22B7000B77FF00FFFF00FF000B77001CCA1638E01638E01638E0
        1638E01638E0001CCA000B77FF00FFFF00FFFF00FFFF00FFFF00FF000B777287
        ED324AE51638E01638E01638E01638E00A22B7000B77000B77001CCA1638E016
        38E01638E01638E01638E0001CCA000B77FF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF000B777287ED324AE51638E01638E01638E01638E0001CCA001C
        CA1638E01638E01638E01638E01638E0001CCA000B77FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B777287ED324AE51638E01638E0
        1638E01638E01638E01638E01638E01638E01638E0001CCA000B77FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B7756
        72E7324AE51638E01638E01638E01638E01638E01638E01638E0001CCA000B77
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FF000B77001CCA1638E01638E01638E01638E01638E01638E000
        1CCA000B77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FF000B77001CCA1638E01638E01638E01638
        E01638E01638E0001CCA000B77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B77001CCA1638E01638E0
        1638E01638E01638E01638E01638E01638E00A22B7000B77FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B77001CCA16
        38E01638E01638E01638E01638E01638E01638E01638E01638E01638E00A22B7
        000B77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B
        77001CCA1638E01638E01638E01638E0324AE5001CCA001CCA324AE51638E016
        38E01638E01638E00A22B7000B77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF000B77001CCA1638E01638E01638E01638E0324AE55672E7000B77000B
        775672E7324AE51638E01638E01638E01638E00A22B7000B77FF00FFFF00FFFF
        00FFFF00FFFF00FF000B77001CCA1638E01638E01638E01638E0324AE55672E7
        000B77FF00FFFF00FF000B777287ED324AE51638E01638E01638E01638E00A22
        B7000B77FF00FFFF00FFFF00FF000B77001CCA1638E01638E01638E01638E032
        4AE55672E7000B77FF00FFFF00FFFF00FFFF00FF000B777287ED324AE51638E0
        1638E01638E01638E00A22B7000B77FF00FFFF00FF000B777287ED324AE51638
        E01638E0324AE55672E7000B77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF00
        0B777287ED324AE51638E01638E01638E05672E7000B77FF00FFFF00FFFF00FF
        000B777287ED324AE5324AE55672E7000B77FF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF000B777287ED324AE51638E05672E7000B77FF00FFFF
        00FFFF00FFFF00FFFF00FF000B777287ED5672E7000B77FF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B775672E75672E7000B
        77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000B77000B77FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        000B77000B77FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ModalResult = 2
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
    end
    object btnOk: TBitBtn
      Left = 538
      Top = 7
      Width = 119
      Height = 32
      Anchors = [akRight, akBottom]
      Caption = 'Achei [F9]'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000890B0000890B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF485058485058FF
        00FFFF00FFFF00FF0364BA03539C03539C03539C03539C03559D03559D03559D
        03559D03559D03559D03559D03559D03559D03559D03559C03509303437B4850
        581158A11173EA485058FF00FFFF00FF0364BB1393DE1088D11088D11088D110
        88D11088D11189D31088D11088D11088D11088D11088D11088D11087D00F80C6
        0D6BA54850581158A11173EA40ABFF1C8FFFFF00FFFF00FF0365BC1393DE1088
        D11088D11088D11088D11088D11088D11087D00F83CA0F7BBF0E7ABC0E7ABC0F
        7ABD0F7BBF0D6FAB4850581158A11173EA40ABFF1C8FFFFF00FFFF00FFFF00FF
        0366BD1399E2C9C7C7ACABABACABABACABABACABABABAAAAA3A1A18A89896F6E
        6E6868686868686B6B6B7575754850581158A11173EA40ABFF1C8FFFFF00FFFF
        00FFFF00FFFF00FF0367BF139AE5C9C7C7FEFEFCFCFCFBF8F8F7F3F3F2EAEAE9
        C6C6C5D3A998C1958EB78B86B48982CEA99C7979794850581173EA40ABFF1C8F
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0368C1149DE6C9C7C7FEFEFCF8F8F7E3
        E3E2C5C5C4AFAFADB58981D4BAA3CCBC89F3E0A0EFDC9DCCBC89B18780312A23
        9A9A9A1C8FFFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0368C2149EE7C9C7
        C7F7F7F6EFEFEE4B4BB66D6D87B0847ECCBC89FCE7A5FCE7A6FBE6A5F7E2A3F2
        DD9FEAD599A77A75074165033A6BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0369C4159FE9C9C7C7F6F6F4C6C6D90101A9BB8F82CCBC89FEE9A6FFEBA9FFED
        AAFFEBAAFFE9A7FAE2A4F0DC9EE1CF95CBA4A1023562FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF036AC515A1EAC7C6C6EEEEED5A5ABC0000A7AF847B896883
        D1C2A4FFEFACFFEFACFFEDABFFEAAAFCE6A6F2DDA0E2CF96C0958C02345EFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF036BC616A3EBC6C5C5C4C4DE0606B011
        11A9AC867B9D7E849D7E84FFEEACFFEBABFFE9A9FCE6A7FAE3A5F0DC9FDECB93
        BD918602345EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF036BC716A4EDC7C6
        C65050CA0303B18888C4AF8377B792889D7E84CEBCA9FEE7A9FBE6A7FAE7B2F6
        E1A5EBD79DD7C58FC09588023766FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        036CC916A6EFC9C7C7FBFBFAF8F8F7F3F3F2B1847ABD978ECABD989D7E84D8C7
        A7F8E2A6FEE7A9F3E2AFE3D098CCBC89CBA69E03437BFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF036DCA16A7F0C9C7C7FEFEFCFEFEFCFEFEFCF2F2F0C2937F
        CCBC89BC998E9D7E84DCCBA1EFDDA7EDDDB1DACA97CAAA980A5686034C8CFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF036ECB17AAF2C9C7C7FEFEFCFEFEFCFE
        FEFCFAFAF8BA8C86CB987FD8C68FBC998E9D7E84D4C499D9CA9CDDD0A9C7A19E
        0D6DA7035196FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF036ECC17ABF4C9C7
        C7FEFEFCFEFEFCFEFEFCFEFEFCF7F7F6CEA9A3C29586C79F8CBC998E9D7E84BD
        9F92BC998E8684840F80C603549CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        036FCE17ACF6C9C7C7FEFEFCFEFEFCFEFEFCFEFEFCFEFEFCF7F7F6E0C9C9EDD8
        D4E7D3D0DECECEBCAFCBDCC9CA9E9D9D1087CF03559DFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FF0470CF18ADF7C9C7C7FEFEFCFEFEFCFEFEFCFEFEFCFEFEFC
        FEFEFCFAFAF8F6F6F4F0F0EFB0B0DD4C4CC0E6E6E5A7A6A61088D103559DFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF0470D018B0F8C9C7C7FEFEFCFEFEFCFE
        FEFCFEFEFCFEFEFCFEFEFCFEFEFCFEFEFCFEFEFCFEFEFCFBFBFAFAFAF8ABAAAA
        1088D103559DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0470D018B1FAC9C7
        C7FEFEFCFEFEFC868A8C626260626260626260626260626260626260626260FE
        FEFCFEFEFCACABAB1088D103559DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0470D016A3EDC9C7C7C9C7C7A1A4A5DDDEE0C2C5C7B0B2B5B0B2B5B0B2B5B0B2
        B5B0B2B5868A8C626260ACABABACABAB1088D103559EFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF0470D016A3ED18B2FBA1A4A5DDDEE0FEFEFCFEFEFC
        FEFEFCFEFEFCFEFEFCFEFEFCB0B2B562626015A1EA16A3ED0360B4FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF046AC4046AC4046AC4A1
        A4A5DDDEE0C2C5C7C2C5C7B0B2B5B0B2B5B0B2B57F7F7D0368C10368C00368C0
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFA1A4A5929697868A8C868A8C868A8C868A8CFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ModalResult = 1
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object PageControl: TcxPageControl
    Left = 0
    Top = 139
    Width = 792
    Height = 389
    ActivePage = TsTree
    Align = alClient
    TabOrder = 2
    ClientRectBottom = 385
    ClientRectLeft = 4
    ClientRectRight = 788
    ClientRectTop = 24
    object tsGrid: TcxTabSheet
      Caption = 'tsGrid'
      ImageIndex = 0
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 784
        Height = 361
        Align = alClient
        BevelKind = bkFlat
        BevelOuter = bvNone
        TabOrder = 0
        object cxGrid1: TcxGrid
          Tag = 99
          Left = 0
          Top = 25
          Width = 780
          Height = 332
          Align = alClient
          TabOrder = 0
          object TvPesquisa: TcxGridDBTableView
            Tag = 99
            NavigatorButtons.ConfirmDelete = False
            OnCellDblClick = TvPesquisaCellDblClick
            DataController.DataModeController.SmartRefresh = True
            DataController.DataSource = DataPesquisa
            DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoFocusTopRowAfterSorting]
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsBehavior.FocusCellOnTab = True
            OptionsBehavior.GoToNextCellOnEnter = True
            OptionsCustomize.ColumnsQuickCustomization = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsSelection.CellSelect = False
            OptionsView.Indicator = True
            Styles.Selection = DMConexao.Selecionado
            Styles.StyleSheet = DMConexao.StiloGrid
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = TvPesquisa
          end
        end
        object Panel4: TPanel
          Left = 0
          Top = 0
          Width = 780
          Height = 25
          Align = alTop
          BevelKind = bkSoft
          BevelOuter = bvNone
          TabOrder = 1
          object SpeedButton1: TSpeedButton
            Left = 23
            Top = 0
            Width = 23
            Height = 21
            Align = alLeft
            Caption = 'Col'
            OnClick = SpeedButton1Click
            ExplicitLeft = 16
            ExplicitHeight = 22
          end
          object SpeedButton2: TSpeedButton
            Left = 0
            Top = 0
            Width = 23
            Height = 21
            Align = alLeft
            Caption = 'Ex'
            OnClick = SpeedButton2Click
            ExplicitLeft = 1
            ExplicitTop = -2
          end
          object chkGrupo: TCheckBox
            Left = 620
            Top = 0
            Width = 156
            Height = 21
            Cursor = crHandPoint
            Align = alRight
            Caption = 'Mostrar barra de Grupo'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
            OnClick = chkGrupoClick
          end
        end
      end
    end
    object TsTree: TcxTabSheet
      Caption = 'TsTree'
      ImageIndex = 1
      object TvTree: TcxDBTreeList
        Left = 0
        Top = 0
        Width = 784
        Height = 361
        Align = alClient
        Bands = <
          item
          end>
        OptionsBehavior.Sorting = False
        OptionsData.CancelOnExit = False
        OptionsData.Editing = False
        OptionsData.Deleting = False
        OptionsSelection.CellSelect = False
        OptionsView.ColumnAutoWidth = True
        RootValue = -1
        Styles.Selection = DMConexao.Selecionado
        TabOrder = 0
        OnDblClick = TvTreeDblClick
      end
    end
  end
  object DataPesquisa: TDataSource
    DataSet = cdsPesquisa
    Left = 304
    Top = 208
  end
  object Cenario: TcxPropertiesStore
    Active = False
    Components = <
      item
        Component = chkGrupo
        Properties.Strings = (
          'Action'
          'Align'
          'Alignment'
          'AlignWithMargins'
          'AllowGrayed'
          'Anchors'
          'BiDiMode'
          'Caption'
          'Checked'
          'Color'
          'Constraints'
          'Ctl3D'
          'Cursor'
          'DragCursor'
          'DragKind'
          'DragMode'
          'Enabled'
          'Font'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'Left'
          'Margins'
          'Name'
          'ParentBiDiMode'
          'ParentColor'
          'ParentCtl3D'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'ShowHint'
          'State'
          'TabOrder'
          'TabStop'
          'Tag'
          'Top'
          'Visible'
          'Width'
          'WordWrap')
      end
      item
        Component = ChkTempoReal
        Properties.Strings = (
          'Action'
          'Align'
          'Alignment'
          'AlignWithMargins'
          'AllowGrayed'
          'Anchors'
          'BiDiMode'
          'Caption'
          'Checked'
          'Color'
          'Constraints'
          'Ctl3D'
          'Cursor'
          'DragCursor'
          'DragKind'
          'DragMode'
          'Enabled'
          'Font'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'Left'
          'Margins'
          'Name'
          'ParentBiDiMode'
          'ParentColor'
          'ParentCtl3D'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'ShowHint'
          'State'
          'TabOrder'
          'TabStop'
          'Tag'
          'Top'
          'Visible'
          'Width'
          'WordWrap')
      end
      item
        Component = GroupBox1
        Properties.Strings = (
          'Align'
          'AlignWithMargins'
          'Anchors'
          'BiDiMode'
          'Caption'
          'Color'
          'Constraints'
          'Ctl3D'
          'Cursor'
          'DockSite'
          'DragCursor'
          'DragKind'
          'DragMode'
          'Enabled'
          'Font'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'Left'
          'Margins'
          'Name'
          'Padding'
          'ParentBackground'
          'ParentBiDiMode'
          'ParentColor'
          'ParentCtl3D'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'ShowHint'
          'TabOrder'
          'TabStop'
          'Tag'
          'Top'
          'Visible'
          'Width')
      end
      item
        Component = GroupBox2
        Properties.Strings = (
          'Align'
          'AlignWithMargins'
          'Anchors'
          'BiDiMode'
          'Caption'
          'Color'
          'Constraints'
          'Ctl3D'
          'Cursor'
          'DockSite'
          'DragCursor'
          'DragKind'
          'DragMode'
          'Enabled'
          'Font'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'Left'
          'Margins'
          'Name'
          'Padding'
          'ParentBackground'
          'ParentBiDiMode'
          'ParentColor'
          'ParentCtl3D'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'ShowHint'
          'TabOrder'
          'TabStop'
          'Tag'
          'Top'
          'Visible'
          'Width')
      end
      item
        Component = grpOpcaoPesquisa
        Properties.Strings = (
          'Align'
          'AlignWithMargins'
          'Anchors'
          'BiDiMode'
          'Caption'
          'Color'
          'Columns'
          'Constraints'
          'Ctl3D'
          'Cursor'
          'DragCursor'
          'DragKind'
          'DragMode'
          'Enabled'
          'Font'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'ItemIndex'
          'Items'
          'Left'
          'Margins'
          'Name'
          'ParentBackground'
          'ParentBiDiMode'
          'ParentColor'
          'ParentCtl3D'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'ShowHint'
          'TabOrder'
          'TabStop'
          'Tag'
          'Top'
          'Visible'
          'Width')
      end
      item
        Component = lstCampos
        Properties.Strings = (
          'Align'
          'AlignWithMargins'
          'Anchors'
          'AutoComplete'
          'AutoCompleteDelay'
          'BiDiMode'
          'Columns'
          'Constraints'
          'Cursor'
          'DragCursor'
          'DragKind'
          'DragMode'
          'Enabled'
          'ExtendedSelect'
          'FakeStyleController'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'ImeMode'
          'ImeName'
          'IntegralHeight'
          'ItemHeight'
          'Items'
          'Left'
          'ListStyle'
          'Margins'
          'MultiSelect'
          'Name'
          'ParentBiDiMode'
          'ParentColor'
          'ParentFont'
          'ParentShowHint'
          'PopupMenu'
          'ReadOnly'
          'ScrollWidth'
          'ShowHint'
          'Sorted'
          'Style'
          'StyleDisabled'
          'StyleFocused'
          'StyleHot'
          'TabOrder'
          'TabStop'
          'TabWidth'
          'Tag'
          'Top'
          'Visible'
          'Width')
      end
      item
        Component = TvPesquisa
        Properties.Strings = (
          'BackgroundBitmaps'
          'DataController'
          'DateTimeHandling'
          'DragMode'
          'FakeComponentLink1'
          'FakeComponentLink2'
          'FakeComponentLink3'
          'FilterBox'
          'Filtering'
          'FilterRow'
          'Name'
          'NavigatorButtons'
          'NewItemRow'
          'OptionsBehavior'
          'OptionsCustomize'
          'OptionsData'
          'OptionsSelection'
          'OptionsView'
          'PopupMenu'
          'Preview'
          'Styles'
          'Synchronization'
          'Tag')
      end
      item
        Component = TvTree
        Properties.Strings = (
          'Align'
          'AlignWithMargins'
          'Anchors'
          'Bands'
          'BorderStyle'
          'BufferedPaint'
          'Constraints'
          'Cursor'
          'DataController'
          'DefaultLayout'
          'DefaultRowHeight'
          'DragCursor'
          'DragKind'
          'DragMode'
          'Enabled'
          'Font'
          'Height'
          'HelpContext'
          'HelpKeyword'
          'HelpType'
          'Hint'
          'Images'
          'Left'
          'LookAndFeel'
          'Margins'
          'Name'
          'OptionsBehavior'
          'OptionsCustomizing'
          'OptionsData'
          'OptionsSelection'
          'OptionsView'
          'ParentColor'
          'ParentFont'
          'PopupMenu'
          'Preview'
          'RootValue'
          'StateImages'
          'Styles'
          'TabOrder'
          'TabStop'
          'Tag'
          'Top'
          'Visible'
          'Width')
      end>
    StorageName = 'Cenario.ini'
    Left = 424
    Top = 216
  end
  object cdsPesquisa: TpFIBDataSet
    CachedUpdates = True
    AutoCalcFields = False
    AfterScroll = cdsPesquisaAfterScroll
    AllowedUpdateKinds = []
    Transaction = DMConexao.Trans
    Database = DMConexao.Conexao
    AutoCommit = True
    CSMonitorSupport.Enabled = csmeDisabled
    Left = 392
    Top = 288
    poUseLargeIntField = True
    poEmptyStrToNull = False
    oFreeHandlesAfterClose = True
    oCacheCalcFields = True
    oKeepSorting = True
    oPersistentSorting = True
    oVisibleRecno = True
    oFetchAll = True
  end
  object cxEditRepository: TcxEditRepository
    Left = 528
    Top = 280
    object ColorComboBox: TcxEditRepositoryColorComboBox
      Properties.ColorValueFormat = cxcvInteger
      Properties.CustomColors = <>
      Properties.DefaultDescription = 'Nenhuma cor selecionada'
      Properties.ImmediateUpdateText = True
    end
    object Imagem: TcxEditRepositoryImageItem
      Properties.GraphicClassName = 'TJPEGImage'
      Properties.ImmediatePost = True
      Properties.Stretch = True
    end
    object Blob: TcxEditRepositoryBlobItem
      Properties.ImmediatePost = True
      Properties.MemoScrollBars = ssBoth
      Properties.PictureGraphicClassName = 'TJPEGImage'
      Properties.PopupHeight = 300
      Properties.PopupWidth = 300
    end
  end
end
