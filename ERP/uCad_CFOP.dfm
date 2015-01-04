inherited frmCad_CFOP: TfrmCad_CFOP
  Caption = 'Cadastro de CFOP'
  ClientHeight = 481
  ClientWidth = 699
  ExplicitWidth = 715
  ExplicitHeight = 520
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 699
    ExplicitWidth = 699
  end
  inherited pnlTree: TPanel
    Height = 451
    ExplicitHeight = 451
    inherited TreeItens: TcxTreeView
      Height = 445
      ExplicitHeight = 445
    end
  end
  inherited Panel3: TPanel
    Width = 514
    Height = 451
    ExplicitWidth = 514
    ExplicitHeight = 451
    inherited PageControl: TcxPageControl
      Width = 514
      Height = 451
      ExplicitWidth = 514
      ExplicitHeight = 451
      ClientRectBottom = 450
      ClientRectRight = 513
      inherited TsPrincipal: TcxTabSheet
        ExplicitLeft = 1
        ExplicitTop = 21
        ExplicitWidth = 512
        ExplicitHeight = 429
        inherited pnlGeral: TPanel
          Width = 512
          Height = 429
          ExplicitWidth = 512
          ExplicitHeight = 429
          object Label1: TLabel
            Left = 16
            Top = 200
            Width = 80
            Height = 13
            Caption = 'CST PIS/COFINS'
          end
          object edtCFOP: TLabelDBEdit
            Left = 16
            Top = 24
            Width = 49
            Height = 21
            DataField = 'CFOP'
            DataSource = DataCadastro
            TabOrder = 0
            Titulo.Left = 16
            Titulo.Top = 9
            Titulo.Width = 27
            Titulo.Height = 13
            Titulo.Caption = 'CFOP'
            IsNull = False
            PodeRepetir = False
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
            AsInteger = 0
          end
          object LabelDBEdit2: TLabelDBEdit
            Left = 71
            Top = 24
            Width = 362
            Height = 21
            DataField = 'NATUREZA'
            DataSource = DataCadastro
            TabOrder = 1
            Titulo.Left = 71
            Titulo.Top = 9
            Titulo.Width = 110
            Titulo.Height = 13
            Titulo.Caption = 'Natureza de opera'#231#227'o '
            IsNull = False
            PodeRepetir = True
            CorPrincipal = clWhite
            CorSecundaria = 11592447
            GravaEsteCampo = True
            AsInteger = 0
          end
          object DBCheckBox1: TDBCheckBox
            Left = 439
            Top = 26
            Width = 50
            Height = 17
            Caption = 'Visivel'
            DataField = 'FLAGVISIVEL'
            DataSource = DataCadastro
            TabOrder = 2
            ValueChecked = 'Y'
            ValueUnchecked = 'N'
          end
          object DBCheckBox2: TDBCheckBox
            Left = 16
            Top = 173
            Width = 81
            Height = 17
            Caption = 'Tributa IPI'
            DataField = 'FLAGTRIBUTAIPI'
            DataSource = DataCadastro
            TabOrder = 3
            ValueChecked = 'Y'
            ValueUnchecked = 'N'
          end
          object DBCheckBox3: TDBCheckBox
            Left = 188
            Top = 173
            Width = 161
            Height = 17
            Caption = 'Tributa substitui'#231#227'o tribut'#225'ria'
            DataField = 'FLAGTRIBUTAST'
            DataSource = DataCadastro
            TabOrder = 4
            ValueChecked = 'Y'
            ValueUnchecked = 'N'
          end
          object DBCheckBox4: TDBCheckBox
            Left = 32
            Top = 120
            Width = 97
            Height = 17
            Caption = 'DBCheckBox4'
            TabOrder = 5
            ValueChecked = 'True'
            ValueUnchecked = 'False'
          end
          object cxDBLookupComboBox1: TcxDBLookupComboBox
            Left = 16
            Top = 219
            DataBinding.DataField = 'CST_PIS_COFINS'
            DataBinding.DataSource = DataCadastro
            Properties.ImmediatePost = True
            Properties.KeyFieldNames = 'CST'
            Properties.ListColumns = <
              item
                Caption = ' '
                Width = 200
                FieldName = 'CONCATENADO'
              end>
            Properties.ListSource = DataCST_PIS_COFINS
            TabOrder = 6
            Width = 417
          end
          object DBRadioGroup1: TDBRadioGroup
            Left = 16
            Top = 51
            Width = 417
            Height = 102
            Caption = ' Tipo de opera'#231#227'o '
            Columns = 2
            DataField = 'FLAGTIPOOPERACAO'
            DataSource = DataCadastro
            Items.Strings = (
              'Entrada no Estado'
              'Entrada fora do Estado'
              'Saida no Estado'
              'Saida fora do Estado'
              'Importacao'
              'Exportacao')
            ParentBackground = True
            TabOrder = 7
            Values.Strings = (
              '0'
              '1'
              '2'
              '3'
              '4'
              '5')
          end
          object DBCheckBox5: TDBCheckBox
            Left = 100
            Top = 173
            Width = 85
            Height = 17
            Caption = 'Tributa ICMS'
            DataField = 'FLAGTRIBUTAICMS'
            DataSource = DataCadastro
            TabOrder = 8
            ValueChecked = 'Y'
            ValueUnchecked = 'N'
          end
          object DBCheckBox6: TDBCheckBox
            Left = 356
            Top = 173
            Width = 113
            Height = 17
            Caption = 'Tributa PIS/COFINS'
            DataField = 'FLAGTRIBUTAPIS_COFINS'
            DataSource = DataCadastro
            TabOrder = 9
            ValueChecked = 'Y'
            ValueUnchecked = 'N'
          end
          object cxPageControl1: TcxPageControl
            Tag = 99
            Left = 0
            Top = 236
            Width = 512
            Height = 193
            ActivePage = cxTabSheet2
            Align = alBottom
            Style = 2
            TabOrder = 10
            ClientRectBottom = 193
            ClientRectRight = 512
            ClientRectTop = 23
            object cxTabSheet1: TcxTabSheet
              Caption = ' CSTs usados nesse CFOP  '
              ImageIndex = 0
              object GroupBox1: TGroupBox
                Left = 0
                Top = -3
                Width = 512
                Height = 173
                Align = alBottom
                TabOrder = 0
                object Panel2: TPanel
                  Left = 478
                  Top = 15
                  Width = 32
                  Height = 156
                  Align = alRight
                  BevelOuter = bvLowered
                  TabOrder = 0
                  object SpeedButton1: TSpeedButton
                    Left = 6
                    Top = 24
                    Width = 23
                    Height = 22
                    Hint = 'Incluir'
                    Glyph.Data = {
                      36050000424D3605000000000000360400002800000010000000100000000100
                      08000000000000010000E30E0000E30E0000000100000001000031319C003131
                      A5003131AD003131B5003131BD003131C6003131CE003131D6003131DE003131
                      E7003131EF003131F700FF00FF003131FF003139FF003939FF003942FF00424A
                      FF004A4AFF005252FF006363FF006B6BFF006B73FF007B84FF00848CFF009C9C
                      FF00C6CEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000C1B1B1B1B1B
                      1B1B1B1B1B1B1B1B1B0C1B16030404040505040403030201141B1B05080A0B0B
                      0A0B0A0A0A090805001B1B070A0E0E0E0E0E0E0E0E0E0906021B1B090E0E0E0E
                      0E1B180E0E0E0B08031B1B0A0E0E0E0E0E1B180E0E0E0E09041B1B0E0E0E0E0E
                      0E1B180E0E0E0E0A051B1B0E0E181818181B181818180B0A061B1B0E0E1B1B1B
                      1B1B1B1B1B1B0A0A061B1B0E10100E0E0E1B180E0E0B0A0A061B1B0E1313100E
                      0E1B180E0E0B0A0A061B1B1015141110101B180E0E0E0B0B061B1B1318151312
                      111B180E0E0E0E0B061B1B1419181514131211100E0E0E0B041B1B1A1412100E
                      0E0E0E0E0E0E0B08171B0C1B1B1B1B1B1B1B1B1B1B1B1B1B1B0C}
                    ParentShowHint = False
                    ShowHint = True
                    OnClick = SpeedButton1Click
                  end
                  object SpeedButton2: TSpeedButton
                    Left = 6
                    Top = 52
                    Width = 23
                    Height = 22
                    Hint = 'Excluir'
                    Glyph.Data = {
                      36050000424D3605000000000000360400002800000010000000100000000100
                      08000000000000010000E30E0000E30E0000000100000001000031319C003131
                      A5003131AD003131B5003131BD003131C6003131CE003131D6003131DE003131
                      E7003131EF003131F700FF00FF003131FF003139FF003939FF003942FF00424A
                      FF004A4AFF005252FF006363FF006B6BFF006B73FF007B84FF00848CFF009C9C
                      FF00C6CEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000C1B1B1B1B1B
                      1B1B1B1B1B1B1B1B1B0C1B16030404040505040403030201141B1B05080A0B0B
                      0A0B0A0A0A090805001B1B070A0E0E0E0E0E0E0E0E0E0906021B1B090E0E0E0E
                      0E0E0E0E0E0E0B08031B1B0A0E0E0E0E0E0E0E0E0E0E0E09041B1B0E0E0E0E0E
                      0E0E0E0E0E0E0E0A051B1B0E0E1818181818181818180B0A061B1B0E0E1B1B1B
                      1B1B1B1B1B1B0A0A061B1B0E10100E0E0E0E0E0E0E0B0A0A061B1B0E1313100E
                      0E0E0E0E0E0B0A0A061B1B1015141110100E0E0E0E0E0B0B061B1B1318151312
                      11110E0E0E0E0E0B061B1B1419181514131211100E0E0E0B041B1B1A1412100E
                      0E0E0E0E0E0E0B08171B0C1B1B1B1B1B1B1B1B1B1B1B1B1B1B0C}
                    ParentShowHint = False
                    ShowHint = True
                    OnClick = SpeedButton2Click
                  end
                end
                object cxGrid1: TcxGrid
                  Left = 2
                  Top = 15
                  Width = 476
                  Height = 156
                  Align = alClient
                  TabOrder = 1
                  object TvCST_CFOP: TcxGridDBTableView
                    NavigatorButtons.ConfirmDelete = False
                    DataController.DataSource = DataCST_CFOP
                    DataController.Summary.DefaultGroupSummaryItems = <>
                    DataController.Summary.FooterSummaryItems = <>
                    DataController.Summary.SummaryGroups = <>
                    OptionsView.GroupByBox = False
                    object vCST_CFOPColumn1: TcxGridDBColumn
                      Caption = 'CST'
                      DataBinding.FieldName = 'ST'
                      Width = 60
                    end
                    object vCST_CFOPColumn2: TcxGridDBColumn
                      Caption = 'Descri'#231#227'o'
                      DataBinding.FieldName = 'DESCRICAO_ST'
                      Width = 388
                    end
                  end
                  object cxGrid1Level1: TcxGridLevel
                    GridView = TvCST_CFOP
                  end
                end
              end
            end
            object cxTabSheet2: TcxTabSheet
              Caption = 'CFOPs semelhantes'
              ImageIndex = 1
              object Panel4: TPanel
                Left = 480
                Top = 0
                Width = 32
                Height = 170
                Align = alRight
                BevelOuter = bvLowered
                TabOrder = 0
                object SpeedButton3: TSpeedButton
                  Left = 6
                  Top = 24
                  Width = 23
                  Height = 22
                  Hint = 'Incluir'
                  Glyph.Data = {
                    36050000424D3605000000000000360400002800000010000000100000000100
                    08000000000000010000E30E0000E30E0000000100000001000031319C003131
                    A5003131AD003131B5003131BD003131C6003131CE003131D6003131DE003131
                    E7003131EF003131F700FF00FF003131FF003139FF003939FF003942FF00424A
                    FF004A4AFF005252FF006363FF006B6BFF006B73FF007B84FF00848CFF009C9C
                    FF00C6CEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000C1B1B1B1B1B
                    1B1B1B1B1B1B1B1B1B0C1B16030404040505040403030201141B1B05080A0B0B
                    0A0B0A0A0A090805001B1B070A0E0E0E0E0E0E0E0E0E0906021B1B090E0E0E0E
                    0E1B180E0E0E0B08031B1B0A0E0E0E0E0E1B180E0E0E0E09041B1B0E0E0E0E0E
                    0E1B180E0E0E0E0A051B1B0E0E181818181B181818180B0A061B1B0E0E1B1B1B
                    1B1B1B1B1B1B0A0A061B1B0E10100E0E0E1B180E0E0B0A0A061B1B0E1313100E
                    0E1B180E0E0B0A0A061B1B1015141110101B180E0E0E0B0B061B1B1318151312
                    111B180E0E0E0E0B061B1B1419181514131211100E0E0E0B041B1B1A1412100E
                    0E0E0E0E0E0E0B08171B0C1B1B1B1B1B1B1B1B1B1B1B1B1B1B0C}
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = SpeedButton3Click
                end
                object SpeedButton5: TSpeedButton
                  Left = 6
                  Top = 52
                  Width = 23
                  Height = 22
                  Hint = 'Excluir'
                  Glyph.Data = {
                    36050000424D3605000000000000360400002800000010000000100000000100
                    08000000000000010000E30E0000E30E0000000100000001000031319C003131
                    A5003131AD003131B5003131BD003131C6003131CE003131D6003131DE003131
                    E7003131EF003131F700FF00FF003131FF003139FF003939FF003942FF00424A
                    FF004A4AFF005252FF006363FF006B6BFF006B73FF007B84FF00848CFF009C9C
                    FF00C6CEFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
                    FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000C1B1B1B1B1B
                    1B1B1B1B1B1B1B1B1B0C1B16030404040505040403030201141B1B05080A0B0B
                    0A0B0A0A0A090805001B1B070A0E0E0E0E0E0E0E0E0E0906021B1B090E0E0E0E
                    0E0E0E0E0E0E0B08031B1B0A0E0E0E0E0E0E0E0E0E0E0E09041B1B0E0E0E0E0E
                    0E0E0E0E0E0E0E0A051B1B0E0E1818181818181818180B0A061B1B0E0E1B1B1B
                    1B1B1B1B1B1B0A0A061B1B0E10100E0E0E0E0E0E0E0B0A0A061B1B0E1313100E
                    0E0E0E0E0E0B0A0A061B1B1015141110100E0E0E0E0E0B0B061B1B1318151312
                    11110E0E0E0E0E0B061B1B1419181514131211100E0E0E0B041B1B1A1412100E
                    0E0E0E0E0E0E0B08171B0C1B1B1B1B1B1B1B1B1B1B1B1B1B1B0C}
                  ParentShowHint = False
                  ShowHint = True
                  OnClick = SpeedButton5Click
                end
              end
              object cxGrid2: TcxGrid
                Left = 0
                Top = 0
                Width = 480
                Height = 170
                Align = alClient
                TabOrder = 1
                object cxGridDBTableView1: TcxGridDBTableView
                  OnDblClick = cxGridDBTableView1DblClick
                  NavigatorButtons.ConfirmDelete = False
                  DataController.DataSource = DataCFOPSemelhante
                  DataController.Summary.DefaultGroupSummaryItems = <>
                  DataController.Summary.FooterSummaryItems = <>
                  DataController.Summary.SummaryGroups = <>
                  OptionsView.GroupByBox = False
                  object cxGridDBTableView1Column1: TcxGridDBColumn
                    DataBinding.FieldName = 'CFOP'
                    Width = 60
                  end
                  object cxGridDBTableView1Column2: TcxGridDBColumn
                    Caption = 'Natureza'
                    DataBinding.FieldName = 'NATUREZA'
                    Width = 385
                  end
                end
                object cxGridLevel1: TcxGridLevel
                  GridView = cxGridDBTableView1
                end
              end
            end
          end
        end
      end
    end
  end
  inherited CdsCadastro: TpFIBClientDataSet
    AfterScroll = CdsCadastroAfterScroll
  end
  object dsCST_PIS_COFINS: TpFIBDataSet
    SelectSQL.Strings = (
      'select CST, descricao, '
      '       CST||'#39'-'#39'||descricao concatenado '
      '  from vw_cst_PIS_COFINS')
    Transaction = DMConexao.Trans
    Database = DMConexao.Conexao
    Left = 32
    Top = 168
  end
  object DataCST_PIS_COFINS: TDataSource
    DataSet = dsCST_PIS_COFINS
    Left = 112
    Top = 200
  end
  object DataCST_CFOP: TDataSource
    DataSet = cdsCST_CFOP
    Left = 32
    Top = 272
  end
  object cdsCST_CFOP: TpFIBClientDataSet
    Aggregates = <>
    Filter = 'FlagEDICAO <> '#39'D'#39
    Filtered = True
    Params = <>
    BeforePost = cdsCST_CFOPBeforePost
    OnNewRecord = cdsCST_CFOPNewRecord
    Left = 112
    Top = 288
  end
  object DataCFOPSemelhante: TDataSource
    DataSet = CdsCFOPSemelhante
    Left = 56
    Top = 376
  end
  object CdsCFOPSemelhante: TpFIBClientDataSet
    Aggregates = <>
    Filter = 'flagedicao <> '#39'D'#39
    Filtered = True
    Params = <>
    OnNewRecord = CdsCFOPSemelhanteNewRecord
    Left = 112
    Top = 344
  end
end
