inherited frmDlg_CancelamentoDocumento: TfrmDlg_CancelamentoDocumento
  Caption = 'Cancelamento de documento '
  ClientHeight = 219
  ClientWidth = 351
  ExplicitWidth = 367
  ExplicitHeight = 258
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Top = 178
    Width = 351
    inherited btnOk: TBitBtn
      Left = 101
      ExplicitLeft = 168
    end
    inherited btnCancelar: TBitBtn
      Left = 192
      ExplicitLeft = 259
    end
  end
  inherited Panel2: TPanel
    Width = 351
    Height = 178
    object grpMotivoCancelamento: TRadioGroup
      Left = 0
      Top = 0
      Width = 351
      Height = 49
      Align = alTop
      Caption = ' Motivo de cancelamento '
      Columns = 2
      Items.Strings = (
        'Erro na emiss'#227'o'
        'Desist'#234'ncia')
      TabOrder = 0
      ExplicitWidth = 418
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 49
      Width = 351
      Height = 129
      Align = alClient
      Caption = ' Detalhes '
      TabOrder = 1
      ExplicitLeft = 80
      ExplicitTop = 96
      ExplicitWidth = 185
      ExplicitHeight = 105
      object mmDealhes: TMemo
        Left = 2
        Top = 15
        Width = 347
        Height = 112
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitHeight = 260
      end
    end
  end
end
