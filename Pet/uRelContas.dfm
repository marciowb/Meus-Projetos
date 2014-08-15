inherited frmRelContasReceber: TfrmRelContasReceber
  Caption = ' Relat'#243'rio de contas'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel2: TPanel
    inherited lblNome: TJvLabel
      Caption = ' Relat'#243'rio de contas'
      ExplicitWidth = 257
    end
  end
  inherited PageControlMaster: TcxPageControl
    inherited tsGeral: TcxTabSheet
      object GroupBox1: TGroupBox
        Left = 16
        Top = 16
        Width = 251
        Height = 88
        Caption = ' Per'#237'odo de entrada '
        TabOrder = 0
        object Label2: TLabel
          Left = 8
          Top = 24
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object Label3: TLabel
          Left = 126
          Top = 24
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object edtDataIni: TcxDateEdit
          Left = 8
          Top = 43
          Properties.DateButtons = [btnClear, btnToday]
          Properties.DateOnError = deToday
          Properties.ImmediatePost = True
          Properties.InputKind = ikMask
          Properties.MinDate = 39448.000000000000000000
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 0
          Width = 108
        end
        object edtDataFin: TcxDateEdit
          Left = 127
          Top = 43
          Properties.DateButtons = [btnClear, btnToday]
          Properties.DateOnError = deToday
          Properties.ImmediatePost = True
          Properties.InputKind = ikMask
          Properties.MinDate = 39448.000000000000000000
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 1
          Width = 108
        end
      end
      object grpVenc: TGroupBox
        Left = 273
        Top = 16
        Width = 251
        Height = 88
        Caption = ' Per'#237'odo de vencimento '
        Enabled = False
        TabOrder = 1
        object Label4: TLabel
          Left = 8
          Top = 24
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object Label5: TLabel
          Left = 126
          Top = 24
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object edtDataIniVencimento: TcxDateEdit
          Left = 8
          Top = 43
          Properties.DateButtons = [btnClear, btnToday]
          Properties.DateOnError = deToday
          Properties.ImmediatePost = True
          Properties.InputKind = ikMask
          Properties.MinDate = 39448.000000000000000000
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 0
          Width = 108
        end
        object edtDataFinVencimento: TcxDateEdit
          Left = 127
          Top = 43
          Properties.DateButtons = [btnClear, btnToday]
          Properties.DateOnError = deToday
          Properties.ImmediatePost = True
          Properties.InputKind = ikMask
          Properties.MinDate = 39448.000000000000000000
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 1
          Width = 108
        end
      end
      object grpTipo: TRadioGroup
        Left = 18
        Top = 118
        Width = 249
        Height = 83
        Caption = ' Tipo de relat'#243'rio '
        Columns = 2
        ItemIndex = 0
        Items.Strings = (
          'Contas a receber'
          'Contas recebidas')
        TabOrder = 2
        OnClick = grpTipoClick
      end
      object grpRec: TGroupBox
        Left = 273
        Top = 118
        Width = 251
        Height = 83
        Caption = ' Per'#237'odo de recdbimento '
        Enabled = False
        TabOrder = 3
        object Label6: TLabel
          Left = 8
          Top = 24
          Width = 51
          Height = 13
          Caption = 'Data inicial'
        end
        object Label7: TLabel
          Left = 126
          Top = 24
          Width = 46
          Height = 13
          Caption = 'Data final'
        end
        object edtDataIniRec: TcxDateEdit
          Left = 8
          Top = 43
          Properties.DateButtons = [btnClear, btnToday]
          Properties.DateOnError = deToday
          Properties.ImmediatePost = True
          Properties.InputKind = ikMask
          Properties.MinDate = 39448.000000000000000000
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 0
          Width = 108
        end
        object edtDataFinRec: TcxDateEdit
          Left = 126
          Top = 43
          Properties.DateButtons = [btnClear, btnToday]
          Properties.DateOnError = deToday
          Properties.ImmediatePost = True
          Properties.InputKind = ikMask
          Properties.MinDate = 39448.000000000000000000
          Properties.SaveTime = False
          Properties.ShowTime = False
          TabOrder = 1
          Width = 108
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
      746F0200490000000100055749445448020002002C010000}
    object CdsParametrosTexto: TStringField
      FieldName = 'Texto'
      Size = 300
    end
  end
end
