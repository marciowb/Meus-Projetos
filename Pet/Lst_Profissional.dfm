inherited frmLst_Profissional: TfrmLst_Profissional
  Caption = 'Cadastro de profissional'
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Panel3: TPanel
      inherited Panel4: TPanel
        TabOrder = 5
      end
      object LabelDBEdit1: TLabelDBEdit
        Left = 16
        Top = 65
        Width = 225
        Height = 21
        DataField = 'NOMEPROFISSIONAL'
        DataSource = DataCadastro
        TabOrder = 1
        Titulo.Left = 16
        Titulo.Top = 50
        Titulo.Width = 54
        Titulo.Height = 13
        Titulo.Caption = 'Profissional'
        IsNull = False
        PodeRepetir = False
        CorPrincipal = clWhite
        CorSecundaria = 11592447
        GravaEsteCampo = True
      end
      object LabelDBEdit2: TLabelDBEdit
        Left = 16
        Top = 105
        Width = 73
        Height = 21
        DataField = 'ALIQCOMISSAO'
        DataSource = DataCadastro
        TabOrder = 2
        Titulo.Left = 16
        Titulo.Top = 90
        Titulo.Width = 67
        Titulo.Height = 13
        Titulo.Caption = 'Al'#237'q. comiss'#227'o'
        IsNull = True
        PodeRepetir = True
        CorPrincipal = clWhite
        CorSecundaria = 11592447
        GravaEsteCampo = True
      end
      object DBCheckBox1: TDBCheckBox
        Left = 95
        Top = 107
        Width = 138
        Height = 17
        Caption = 'Solicitar nome no servi'#231'o'
        DataField = 'FLAGPEDIRNOME'
        DataSource = DataCadastro
        TabOrder = 3
        ValueChecked = 'Y'
        ValueUnchecked = 'N'
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 132
        Width = 323
        Height = 151
        Align = alBottom
        Caption = ' Obs '
        TabOrder = 4
        object DBMemo1: TDBMemo
          Left = 2
          Top = 15
          Width = 319
          Height = 134
          Align = alClient
          DataField = 'obs'
          DataSource = DataCadastro
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    inherited ToolBar1: TToolBar
      inherited ToolButton1: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton2: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton3: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton4: TToolButton
        ExplicitWidth = 24
      end
      inherited btnNovo: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton9: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton10: TToolButton
        ExplicitWidth = 24
      end
      inherited ToolButton11: TToolButton
        ExplicitWidth = 24
      end
    end
    inherited Panel2: TPanel
      inherited PageControl: TcxPageControl
        inherited tsGrid: TcxTabSheet
          ExplicitLeft = 2
          ExplicitTop = 22
          ExplicitWidth = 295
          ExplicitHeight = 296
        end
        inherited tsTree: TcxTabSheet
          ExplicitLeft = 2
          ExplicitTop = 22
          ExplicitWidth = 295
          ExplicitHeight = 296
        end
      end
    end
  end
end
