inherited frmLst_Periodicidade: TfrmLst_Periodicidade
  Caption = 'Cadastro de periodicidade'
  ExplicitWidth = 658
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    inherited Panel3: TPanel
      inherited edtCodigo: TLabelDBEdit
        Left = 18
        Top = 33
        Width = 241
        DataField = ''
        Titulo.Left = 18
        Titulo.Top = 18
        Titulo.Width = 46
        Titulo.Caption = 'Descri'#231#227'o'
        Titulo.ExplicitLeft = 18
        Titulo.ExplicitTop = 18
        Titulo.ExplicitWidth = 46
        ExplicitLeft = 18
        ExplicitTop = 33
        ExplicitWidth = 241
      end
      object LabelDBEdit2: TLabelDBEdit
        Left = 17
        Top = 33
        Width = 241
        Height = 21
        DataField = 'DESCRICAOPERIODICIDADE'
        DataSource = DataCadastro
        TabOrder = 2
        Titulo.Left = 17
        Titulo.Top = 18
        Titulo.Width = 46
        Titulo.Height = 13
        Titulo.Caption = 'Descri'#231#227'o'
        IsNull = False
        PodeRepetir = False
        CorPrincipal = clWhite
        CorSecundaria = 11592447
        GravaEsteCampo = True
        AsInteger = 0
      end
      object LabelDBEdit1: TLabelDBEdit
        Left = 17
        Top = 81
        Width = 71
        Height = 21
        DataField = 'NUMDIAS'
        DataSource = DataCadastro
        TabOrder = 3
        Titulo.Left = 17
        Titulo.Top = 66
        Titulo.Width = 49
        Titulo.Height = 13
        Titulo.Caption = 'N'#186' de dias'
        IsNull = False
        PodeRepetir = False
        CorPrincipal = clWhite
        CorSecundaria = 11592447
        GravaEsteCampo = True
        AsInteger = 0
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
          ExplicitLeft = 4
          ExplicitTop = 24
          ExplicitWidth = 293
          ExplicitHeight = 294
        end
        inherited tsTree: TcxTabSheet
          ExplicitLeft = 4
          ExplicitTop = 24
          ExplicitWidth = 293
          ExplicitHeight = 294
          inherited pnlTree: TPanel
            Width = 293
            Height = 294
            ExplicitWidth = 293
            ExplicitHeight = 294
            inherited TvTree: TcxDBTreeList
              Width = 293
              Height = 294
              ExplicitWidth = 293
              ExplicitHeight = 294
            end
          end
        end
      end
    end
  end
end
