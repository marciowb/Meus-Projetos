inherited frmFechamento: TfrmFechamento
  ActiveControl = GridFP
  BorderStyle = bsNone
  Caption = 'Fechamento de venda'
  ClientHeight = 249
  ClientWidth = 454
  ExplicitWidth = 454
  ExplicitHeight = 249
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 208
    Width = 454
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      454
      41)
    object btnOk: TBitBtn
      Left = 245
      Top = 7
      Width = 83
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Ok'
      DoubleBuffered = True
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnOkClick
    end
    object btnCancelar: TBitBtn
      Left = 336
      Top = 7
      Width = 83
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Cancelar'
      DoubleBuffered = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        36060000424D3606000000000000360000002800000020000000100000000100
        1800000000000006000000000000000000000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FF0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF818181818181FF00FF0732DE
        0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF0732DE0732DEFF00FFFF00FF818181818181FF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF818181818181FF00FFFF00FF0732DE
        0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732
        DE0732DEFF00FFFF00FFFF00FF818181818181818181FF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FF818181818181FF00FFFF00FFFF00FF0732DE
        0732DD0732DE0732DEFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0732DE0732
        DEFF00FFFF00FFFF00FFFF00FF818181818181818181818181FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF818181818181FF00FFFF00FFFF00FFFF00FFFF00FF
        0534ED0732DF0732DE0732DEFF00FFFF00FFFF00FFFF00FF0732DE0732DEFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FF888888828282818181818181FF00FFFF
        00FFFF00FFFF00FF818181818181FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF0732DE0732DE0732DDFF00FF0732DD0732DE0732DEFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF818181818181818181FF
        00FF818181818181818181FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF0732DD0633E60633E60633E90732DCFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF81818185858585
        8585868686808080FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FF0633E30732E30534EFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF83838384
        8484898989FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FF0732DD0534ED0533E90434EF0434F5FF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF81818188888886
        86868888888B8B8BFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FF0434F40534EF0533EBFF00FFFF00FF0434F40335F8FF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8B8B8B898989878787FF
        00FFFF00FF8B8B8B8C8C8CFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FF0335FC0534EF0434F8FF00FFFF00FFFF00FFFF00FF0335FC0335FBFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF8E8E8E8989898D8D8DFF00FFFF
        00FFFF00FFFF00FF8E8E8E8E8E8EFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        0335FB0335FB0335FCFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335
        FBFF00FFFF00FFFF00FFFF00FFFF00FF8E8E8E8E8E8E8E8E8EFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FF8E8E8E8E8E8EFF00FFFF00FFFF00FFFF00FF0335FB
        0335FB0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FF0335FBFF00FFFF00FFFF00FF8E8E8E8E8E8E8E8E8EFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FF8E8E8EFF00FFFF00FF0335FB0335FB
        0335FBFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF8E8E8E8E8E8E8E8E8EFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF0335FB0335FB
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FF8E8E8E8E8E8EFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      NumGlyphs = 2
      ParentDoubleBuffered = False
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 454
    Height = 208
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 150
      Width = 452
      Height = 57
      Align = alBottom
      BevelKind = bkSoft
      BevelOuter = bvNone
      TabOrder = 1
      object Label1: TLabel
        Left = 11
        Top = 7
        Width = 137
        Height = 19
        Caption = 'Valor desconto..:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 11
        Top = 30
        Width = 140
        Height = 19
        Caption = 'Valor acr'#233'scimo.:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblRecebido: TLabel
        Left = 367
        Top = 34
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'R$ 0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCapTotalRecebido: TLabel
        Left = 216
        Top = 30
        Width = 114
        Height = 19
        Caption = 'Falta receber:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotal: TLabel
        Left = 367
        Top = 11
        Width = 49
        Height = 14
        Alignment = taRightJustify
        Caption = 'R$ 0.00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 216
        Top = 7
        Width = 54
        Height = 19
        Caption = 'Total :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtValDesc: TcxCurrencyEdit
        Left = 154
        Top = 6
        TabOrder = 0
        OnExit = edtValDescExit
        Width = 57
      end
      object edtValAcres: TcxCurrencyEdit
        Left = 154
        Top = 29
        TabOrder = 1
        OnExit = edtValAcresExit
        Width = 57
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 1
      Width = 452
      Height = 149
      Align = alClient
      BevelInner = bvLowered
      BevelOuter = bvNone
      BorderWidth = 5
      TabOrder = 0
      object GridFP: TDBGrid
        Left = 6
        Top = 6
        Width = 440
        Height = 137
        Align = alClient
        DataSource = DataFP
        Options = [dgEditing, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnColEnter = GridFPColEnter
        OnColExit = GridFPColExit
        OnEnter = GridFPEnter
        OnExit = GridFPExit
        OnKeyDown = GridFPKeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'NOMEFORMAPAGAMENTO'
            ReadOnly = True
            Title.Caption = 'Forma de pagamento'
            Width = 262
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VALOR'
            Title.Caption = 'Valor'
            Width = 135
            Visible = True
          end>
      end
    end
  end
  object DataFP: TDataSource
    DataSet = CdsPagamentos
    Left = 239
    Top = 72
  end
  object CdsPagamentos: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    AfterOpen = CdsPagamentosAfterOpen
    BeforePost = CdsPagamentosBeforePost
    AfterPost = CdsPagamentosAfterPost
    OnNewRecord = CdsPagamentosNewRecord
    Left = 138
    Top = 74
  end
end
