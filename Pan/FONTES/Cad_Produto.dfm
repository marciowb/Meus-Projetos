inherited frmCad_Produto: TfrmCad_Produto
  Caption = 'Cadastro produto'
  ClientHeight = 405
  ClientWidth = 443
  ExplicitWidth = 451
  ExplicitHeight = 432
  PixelsPerInch = 96
  TextHeight = 13
  inherited JvEnterAsTab1: TJvEnterAsTab
    Left = 283
    Top = 104
    ExplicitLeft = 283
    ExplicitTop = 104
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 443
    Height = 29
    Caption = 'ToolBar1'
    TabOrder = 0
    ExplicitLeft = 272
    ExplicitTop = 232
    ExplicitWidth = 150
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Caption = 'ToolButton1'
      ImageIndex = 0
    end
    object ToolButton2: TToolButton
      Left = 23
      Top = 0
      Caption = 'ToolButton2'
      ImageIndex = 1
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 29
    Width = 441
    Height = 376
    Align = alLeft
    BevelOuter = bvLowered
    TabOrder = 1
    ExplicitHeight = 443
    object Label1: TLabel
      Left = 13
      Top = 91
      Width = 128
      Height = 13
      Caption = 'Per'#237'odo para expirar (dias)'
    end
    object edtCodigo: TLabelDBEdit
      Left = 13
      Top = 23
      Width = 76
      Height = 21
      TabOrder = 0
      Titulo.Left = 13
      Titulo.Top = 8
      Titulo.Width = 33
      Titulo.Height = 13
      Titulo.Caption = 'C'#243'digo'
      IsNull = False
      PodeRepetir = False
      CorPrincipal = clWhite
      CorSecundaria = 11592447
    end
    object edtProduto: TLabelDBEdit
      Left = 13
      Top = 64
      Width = 404
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      Titulo.Left = 13
      Titulo.Top = 49
      Titulo.Width = 38
      Titulo.Height = 13
      Titulo.Caption = 'Produto'
      IsNull = False
      PodeRepetir = False
      CorPrincipal = clWhite
      CorSecundaria = 11592447
    end
    object edtDias: TcxDBSpinEdit
      Left = 13
      Top = 107
      Properties.MaxValue = 1000.000000000000000000
      Properties.MinValue = 1.000000000000000000
      TabOrder = 2
      Width = 105
    end
    object edtNumOnu: TLabelDBEdit
      Left = 154
      Top = 107
      Width = 76
      Height = 21
      TabOrder = 3
      Titulo.Left = 154
      Titulo.Top = 92
      Titulo.Width = 37
      Titulo.Height = 13
      Titulo.Caption = 'N'#186' ONU'
      IsNull = False
      PodeRepetir = False
      CorPrincipal = clWhite
      CorSecundaria = 11592447
    end
    object edtUN: TLabelDBEdit
      Left = 253
      Top = 107
      Width = 76
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 4
      Titulo.Left = 253
      Titulo.Top = 92
      Titulo.Width = 39
      Titulo.Height = 13
      Titulo.Caption = 'Unidade'
      IsNull = False
      PodeRepetir = False
      CorPrincipal = clWhite
      CorSecundaria = 11592447
    end
  end
  object ActionList1: TActionList
    Left = 287
    Top = 48
  end
  object cxImageList1: TcxImageList
    FormatVersion = 1
    DesignInfo = 3146043
  end
end
