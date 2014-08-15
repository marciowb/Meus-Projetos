inherited frmRelClientes: TfrmRelClientes
  Caption = ' Relat'#243'rio de clientes'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited lblNome: TJvLabel
      Caption = ' Relat'#243'rio de clientes'
      ExplicitWidth = 270
    end
  end
  inherited PageControlMaster: TcxPageControl
    inherited tsGeral: TcxTabSheet
      Caption = #39
      object GroupBox1: TGroupBox
        Left = 16
        Top = 16
        Width = 201
        Height = 60
        Caption = ' Per'#237'odo de cadastro '
        TabOrder = 0
        object Label2: TLabel
          Left = 10
          Top = 16
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object Label3: TLabel
          Left = 95
          Top = 16
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object edtDataCadIni: TcxDateEdit
          Left = 8
          Top = 31
          TabOrder = 0
          Width = 76
        end
        object edtDataCadFin: TcxDateEdit
          Left = 95
          Top = 31
          TabOrder = 1
          Width = 76
        end
      end
      object GroupBox2: TGroupBox
        Left = 16
        Top = 82
        Width = 201
        Height = 64
        Caption = ' Nascidos entre (mes/ano) '
        TabOrder = 1
        object Label4: TLabel
          Left = 10
          Top = 16
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object Label5: TLabel
          Left = 95
          Top = 16
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object edtDataNiverIni: TMaskEdit
          Left = 8
          Top = 33
          Width = 59
          Height = 21
          EditMask = '!99/99;1;_'
          MaxLength = 5
          TabOrder = 0
          Text = '  /  '
        end
        object edtDataNiverFin: TMaskEdit
          Left = 95
          Top = 33
          Width = 59
          Height = 21
          EditMask = '!99/99;1;_'
          MaxLength = 5
          TabOrder = 1
          Text = '  /  '
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
end
