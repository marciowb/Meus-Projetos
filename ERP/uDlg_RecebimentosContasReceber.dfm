inherited frmDlg_RecebimentosContasReceber: TfrmDlg_RecebimentosContasReceber
  ActiveControl = edtData
  Caption = 'Recebimentos'
  ClientHeight = 160
  ClientWidth = 414
  ExplicitWidth = 430
  ExplicitHeight = 199
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 119
    Width = 414
    ExplicitTop = 106
    ExplicitWidth = 414
    inherited btnOk: TBitBtn
      Left = 158
      Top = 6
      ExplicitLeft = 158
      ExplicitTop = 6
    end
    inherited btnCancelar: TBitBtn
      Left = 247
      ExplicitLeft = 247
    end
  end
  inherited Panel2: TPanel
    Width = 414
    Height = 119
    ExplicitWidth = 414
    ExplicitHeight = 106
    object Label1: TLabel
      Left = 14
      Top = 16
      Width = 100
      Height = 13
      Caption = 'Data de recebimento'
    end
    object LabelDBEdit5: TLabelDBEdit
      Left = 180
      Top = 32
      Width = 51
      Height = 21
      DataField = 'VALORJUROS'
      DataSource = DataRecebimentos
      TabOrder = 2
      Titulo.Left = 180
      Titulo.Top = 17
      Titulo.Width = 51
      Titulo.Height = 13
      Titulo.Caption = 'Valor juros'
      IsNull = True
      PodeRepetir = True
      CorPrincipal = clWhite
      CorSecundaria = 11592447
      GravaEsteCampo = True
      AsInteger = 0
    end
    object LabelDBEdit6: TLabelDBEdit
      Left = 237
      Top = 32
      Width = 66
      Height = 21
      DataField = 'VALORMORA'
      DataSource = DataRecebimentos
      TabOrder = 3
      Titulo.Left = 237
      Titulo.Top = 17
      Titulo.Width = 51
      Titulo.Height = 13
      Titulo.Caption = 'Valor mora'
      IsNull = True
      PodeRepetir = True
      CorPrincipal = clWhite
      CorSecundaria = 11592447
      GravaEsteCampo = True
      AsInteger = 0
    end
    object LabelDBEdit7: TLabelDBEdit
      Left = 14
      Top = 72
      Width = 96
      Height = 21
      DataField = 'DESCONTOFINANCEIRO'
      DataSource = DataRecebimentos
      TabOrder = 4
      Titulo.Left = 14
      Titulo.Top = 57
      Titulo.Width = 95
      Titulo.Height = 13
      Titulo.Caption = 'Desconto financeiro'
      IsNull = True
      PodeRepetir = True
      CorPrincipal = clWhite
      CorSecundaria = 11592447
      GravaEsteCampo = True
      AsInteger = 0
    end
    object edtValorRecebido: TLabelDBEdit
      Left = 125
      Top = 72
      Width = 87
      Height = 21
      DataField = 'VALORRECEBIDO'
      DataSource = DataRecebimentos
      TabOrder = 5
      Titulo.Left = 125
      Titulo.Top = 57
      Titulo.Width = 68
      Titulo.Height = 13
      Titulo.Caption = 'Valor recebido'
      IsNull = True
      PodeRepetir = True
      CorPrincipal = clWhite
      CorSecundaria = 11592447
      GravaEsteCampo = True
      AsInteger = 0
    end
    object edtData: TcxDBDateEdit
      Left = 14
      Top = 32
      DataBinding.DataField = 'DATARECEBIDO'
      DataBinding.DataSource = DataRecebimentos
      Properties.PostPopupValueOnTab = True
      TabOrder = 0
      OnExit = edtDataExit
      Width = 105
    end
    object LabelDBEdit1: TLabelDBEdit
      Left = 125
      Top = 32
      Width = 51
      Height = 21
      DataField = 'ALIQJUROS'
      DataSource = DataRecebimentos
      TabOrder = 1
      Titulo.Left = 125
      Titulo.Top = 17
      Titulo.Width = 48
      Titulo.Height = 13
      Titulo.Caption = 'Aliq. juros'
      IsNull = True
      PodeRepetir = True
      CorPrincipal = clWhite
      CorSecundaria = 11592447
      GravaEsteCampo = True
      AsInteger = 0
    end
  end
  object DataRecebimentos: TDataSource
    Left = 360
    Top = 8
  end
end
