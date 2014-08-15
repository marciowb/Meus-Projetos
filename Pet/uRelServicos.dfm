inherited frmRelServicos: TfrmRelServicos
  Caption = 'Relat'#243'rio de vendas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited lblNome: TJvLabel
      Width = 655
      Height = 45
      Caption = 'Relat'#243'rio de vendas'
      ExplicitWidth = 655
    end
  end
  inherited PageControlMaster: TcxPageControl
    inherited tsGeral: TcxTabSheet
      object GroupBox1: TGroupBox
        Left = 24
        Top = 16
        Width = 203
        Height = 70
        Caption = ' Per'#237'odo '
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 16
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object Label3: TLabel
          Left = 96
          Top = 16
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object edtDataIni: TcxDateEdit
          Left = 8
          Top = 32
          TabOrder = 0
          Width = 78
        end
        object edtDataFin: TcxDateEdit
          Left = 96
          Top = 32
          TabOrder = 1
          Width = 78
        end
      end
    end
  end
  inherited cxImageList1: TcxImageList
    FormatVersion = 1
  end
  inherited CdsParametros: TpFIBClientDataSet
    Active = True
    Data = {
      340000009619E0BD010000001800000001000000000003000000340005546578
      746F020049000000010005574944544802000200B80B0000}
    object CdsParametrosTexto: TStringField
      FieldName = 'Texto'
      Size = 3000
    end
  end
  object CdsEmpresa: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    Left = 80
    Top = 376
  end
  object CdsPagamentos: TpFIBClientDataSet
    Aggregates = <>
    Params = <>
    Left = 136
    Top = 368
  end
end
