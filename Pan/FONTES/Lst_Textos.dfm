inherited frmLst_Textos: TfrmLst_Textos
  Caption = 'Cadastro de Textos'
  ClientWidth = 669
  ExplicitWidth = 677
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited cxGrid1: TcxGrid
      inherited TvLista: TcxGridDBTableView
        object vListaColumn1: TcxGridDBColumn
          Caption = 'C'#243'digo'
          DataBinding.FieldName = 'CODIGO'
        end
        object vListaColumn2: TcxGridDBColumn
          Caption = 'Descri'#231#227'o'
          DataBinding.FieldName = 'DESCRICAO'
          Width = 275
        end
      end
    end
  end
  inherited Panel2: TPanel
    Width = 292
    ExplicitWidth = 292
    inherited Panel3: TPanel
      Width = 290
      TabOrder = 3
      ExplicitWidth = 290
    end
    inherited edtCodigo: TLabelDBEdit
      DataField = 'CODIGO'
    end
    inherited edtDescricao: TLabelDBEdit
      DataField = 'DESCRICAO'
      Titulo.Width = 46
      Titulo.Caption = 'Descri'#231#227'o'
      Titulo.ExplicitWidth = 46
    end
    object JvScrollBox1: TJvScrollBox
      Left = 1
      Top = 105
      Width = 290
      Height = 268
      VertScrollBar.Style = ssFlat
      Align = alBottom
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 2
      BackgroundFillMode = sfmNone
      object GroupBox1: TGroupBox
        Left = 8
        Top = 6
        Width = 225
        Height = 166
        Caption = '  Texto 01 '
        TabOrder = 0
        object edtTitulo1: TLabelDBEdit
          Left = 13
          Top = 31
          Width = 204
          Height = 19
          CharCase = ecUpperCase
          DataField = 'TITULO1'
          DataSource = DataCadastro
          TabOrder = 0
          Titulo.Left = 13
          Titulo.Top = 18
          Titulo.Width = 26
          Titulo.Height = 13
          Titulo.Caption = 'Titulo'
          IsNull = False
          PodeRepetir = False
          CorPrincipal = clWhite
          CorSecundaria = 11592447
        end
        object GroupBox2: TGroupBox
          Left = 13
          Top = 54
          Width = 204
          Height = 105
          Caption = ' Texto 01 '
          TabOrder = 1
          object Texto1: TcxDBMemo
            Left = 1
            Top = 14
            Align = alClient
            DataBinding.DataField = 'TEXTO1'
            DataBinding.DataSource = DataCadastro
            Properties.MaxLength = 500
            Properties.ScrollBars = ssVertical
            TabOrder = 0
            Height = 90
            Width = 202
          end
        end
      end
      object GroupBox3: TGroupBox
        Left = 9
        Top = 178
        Width = 225
        Height = 166
        Caption = '  Texto 02 '
        TabOrder = 1
        object LabelDBEdit1: TLabelDBEdit
          Left = 13
          Top = 31
          Width = 204
          Height = 19
          CharCase = ecUpperCase
          DataField = 'TITULO2'
          DataSource = DataCadastro
          TabOrder = 0
          Titulo.Left = 13
          Titulo.Top = 18
          Titulo.Width = 26
          Titulo.Height = 13
          Titulo.Caption = 'Titulo'
          IsNull = False
          PodeRepetir = False
          CorPrincipal = clWhite
          CorSecundaria = 11592447
        end
        object GroupBox4: TGroupBox
          Left = 13
          Top = 54
          Width = 204
          Height = 105
          Caption = ' Texto 02 '
          TabOrder = 1
          object cxDBMemo1: TcxDBMemo
            Left = 1
            Top = 14
            Align = alClient
            DataBinding.DataField = 'TEXTO2'
            DataBinding.DataSource = DataCadastro
            Properties.MaxLength = 500
            Properties.ScrollBars = ssVertical
            TabOrder = 0
            Height = 90
            Width = 202
          end
        end
      end
      object GroupBox5: TGroupBox
        Left = 8
        Top = 354
        Width = 225
        Height = 166
        Caption = '  Texto 03 '
        TabOrder = 2
        object LabelDBEdit2: TLabelDBEdit
          Left = 13
          Top = 31
          Width = 204
          Height = 19
          CharCase = ecUpperCase
          DataField = 'TITULO3'
          DataSource = DataCadastro
          TabOrder = 0
          Titulo.Left = 13
          Titulo.Top = 18
          Titulo.Width = 26
          Titulo.Height = 13
          Titulo.Caption = 'Titulo'
          IsNull = False
          PodeRepetir = False
          CorPrincipal = clWhite
          CorSecundaria = 11592447
        end
        object GroupBox6: TGroupBox
          Left = 13
          Top = 54
          Width = 204
          Height = 105
          Caption = ' Texto 03'
          TabOrder = 1
          object cxDBMemo2: TcxDBMemo
            Left = 1
            Top = 14
            Align = alClient
            DataBinding.DataField = 'TEXTO3'
            DataBinding.DataSource = DataCadastro
            Properties.MaxLength = 500
            Properties.ScrollBars = ssVertical
            TabOrder = 0
            Height = 90
            Width = 202
          end
        end
      end
      object GroupBox7: TGroupBox
        Left = 8
        Top = 530
        Width = 225
        Height = 166
        Caption = '  Texto 04 '
        TabOrder = 3
        object LabelDBEdit3: TLabelDBEdit
          Left = 13
          Top = 31
          Width = 204
          Height = 19
          CharCase = ecUpperCase
          DataField = 'TITULO4'
          DataSource = DataCadastro
          TabOrder = 0
          Titulo.Left = 13
          Titulo.Top = 18
          Titulo.Width = 26
          Titulo.Height = 13
          Titulo.Caption = 'Titulo'
          IsNull = False
          PodeRepetir = False
          CorPrincipal = clWhite
          CorSecundaria = 11592447
        end
        object GroupBox8: TGroupBox
          Left = 13
          Top = 54
          Width = 204
          Height = 105
          Caption = ' Texto 04'
          TabOrder = 1
          object cxDBMemo3: TcxDBMemo
            Left = 1
            Top = 14
            Align = alClient
            DataBinding.DataField = 'TEXTO4'
            DataBinding.DataSource = DataCadastro
            Properties.MaxLength = 500
            Properties.ScrollBars = ssVertical
            TabOrder = 0
            Height = 90
            Width = 202
          end
        end
      end
      object GroupBox9: TGroupBox
        Left = 8
        Top = 698
        Width = 225
        Height = 166
        Caption = '  Texto 05 '
        TabOrder = 4
        object LabelDBEdit4: TLabelDBEdit
          Left = 13
          Top = 31
          Width = 204
          Height = 19
          CharCase = ecUpperCase
          DataField = 'TITULO5'
          DataSource = DataCadastro
          TabOrder = 0
          Titulo.Left = 13
          Titulo.Top = 18
          Titulo.Width = 26
          Titulo.Height = 13
          Titulo.Caption = 'Titulo'
          IsNull = False
          PodeRepetir = False
          CorPrincipal = clWhite
          CorSecundaria = 11592447
        end
        object GroupBox10: TGroupBox
          Left = 13
          Top = 54
          Width = 204
          Height = 105
          Caption = ' Texto 05 '
          TabOrder = 1
          object cxDBMemo4: TcxDBMemo
            Left = 1
            Top = 14
            Align = alClient
            DataBinding.DataField = 'TEXTO5'
            DataBinding.DataSource = DataCadastro
            Properties.MaxLength = 500
            Properties.ScrollBars = ssVertical
            TabOrder = 0
            Height = 90
            Width = 202
          end
        end
      end
      object GroupBox11: TGroupBox
        Left = 8
        Top = 871
        Width = 225
        Height = 166
        Caption = '  Texto 06 '
        TabOrder = 5
        object LabelDBEdit5: TLabelDBEdit
          Left = 18
          Top = 29
          Width = 204
          Height = 19
          CharCase = ecUpperCase
          DataField = 'TITULO6'
          DataSource = DataCadastro
          TabOrder = 0
          Titulo.Left = 18
          Titulo.Top = 16
          Titulo.Width = 26
          Titulo.Height = 13
          Titulo.Caption = 'Titulo'
          IsNull = False
          PodeRepetir = False
          CorPrincipal = clWhite
          CorSecundaria = 11592447
        end
        object GroupBox12: TGroupBox
          Left = 13
          Top = 54
          Width = 204
          Height = 105
          Caption = ' Texto 06'
          TabOrder = 1
          object cxDBMemo5: TcxDBMemo
            Left = 1
            Top = 14
            Align = alClient
            DataBinding.DataField = 'TEXTO6'
            DataBinding.DataSource = DataCadastro
            Properties.MaxLength = 500
            Properties.ScrollBars = ssVertical
            TabOrder = 0
            Height = 90
            Width = 202
          end
        end
      end
    end
  end
  inherited CdsCadastro: TClientDataSet
    FieldDefs = <
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 30
      end
      item
        Name = 'IDTEXTOS'
        DataType = ftInteger
      end
      item
        Name = 'TEXTO1'
        DataType = ftMemo
      end
      item
        Name = 'TEXTO2'
        DataType = ftMemo
      end
      item
        Name = 'TEXTO3'
        DataType = ftMemo
      end
      item
        Name = 'TEXTO4'
        DataType = ftMemo
      end
      item
        Name = 'TEXTO5'
        DataType = ftMemo
      end
      item
        Name = 'TEXTO6'
        DataType = ftMemo
      end
      item
        Name = 'TITULO1'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TITULO2'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TITULO3'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TITULO4'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TITULO5'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'TITULO6'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'CODIGO'
        DataType = ftString
        Size = 10
      end>
    StoreDefs = True
  end
  inherited cxImageList1: TcxImageList
    FormatVersion = 1
  end
end
