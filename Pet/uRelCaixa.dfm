inherited frmRelCaixa: TfrmRelCaixa
  Caption = ' Relat'#243'rio de caixa'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited lblNome: TJvLabel
      Caption = ' Relat'#243'rio de caixa'
      ExplicitWidth = 655
    end
  end
  inherited PageControlMaster: TcxPageControl
    inherited tsGeral: TcxTabSheet
      object GroupBox1: TGroupBox
        Left = 24
        Top = 24
        Width = 185
        Height = 73
        Caption = ' Per'#237'odo '
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 24
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object Label3: TLabel
          Left = 96
          Top = 24
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object edtDataIni: TcxDateEdit
          Left = 8
          Top = 40
          TabOrder = 0
          Width = 80
        end
        object edtDataFin: TcxDateEdit
          Left = 96
          Top = 40
          TabOrder = 1
          Width = 80
        end
      end
    end
  end
  inherited cxImageList1: TcxImageList
    FormatVersion = 1
  end
end
